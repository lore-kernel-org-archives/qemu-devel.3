Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70687F46100
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8S-0000Eb-LK; Mon, 23 Mar 2026 09:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8Q-0000Dt-Tr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8O-0000Kj-KL
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NCegCW2475974
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZaSE5FAGvb9
 L9rKv3u4p8gymDEWwzpmw3iLQZAJ38eA=; b=nmXlsZuYqzgJ5fDbUg47Su9ByfT
 5zZWOyszFYhc1+DCSmaYI4kSGWnPZAuz3+zj3+nKw2/cnUJsSw+oHMAcTxj2JWSU
 viCv/2Kf/9J6Y/VsTAurnbAWsuYOgRaKizXhkZpT6PqhIy/auiGcrorM2ijJ8vMl
 vE8946feWtJm8sgOo1/EsoDbtbQtqOBogMNZ0XSc9N60ym6ixGLspkhRV8LBqakl
 g868Lrv9/RwHXwP6cUUSCaGz7jDJEKo76eB9WXKrXvglKuXKZGIwEwNkVkXl/LXe
 nTejE22qLWJJWHMraNHZESzftQyBFegOQuQj4Kn3Z0KdLD8NyKtQccNufnA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r203ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so3245694eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271754; x=1774876554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaSE5FAGvb9L9rKv3u4p8gymDEWwzpmw3iLQZAJ38eA=;
 b=eQ2M6omAoqPOIZliLOBfCWyaJ7NJuAxjfUCYZdH41WQD37KRIAHNjOax5amlT3+S8H
 /mnKXHhnWpFEIxir8YfrQuk12GRb7Z1yZegwAV9WUm+BOZqRRdmKPlDFV2GgwCpQuKaV
 MdwZfaDiIkqEBpKxV+Vq538L2Q5dInQyR8NC5BWgt91mIImUGGuw6vje5bH66uJJPL4b
 BpLJVGE84ItiWVpyY2VVzcKA2czjvnTBs8aTcWDVbzyuYO9f9LzE1hpM5ApOMm6ezxK/
 ySGmxTKAF5QlxrkAWb0+AeXGIBxYllJgC8aUgQcx4ETiqPBitlfeksm0qd1QvvVREFZT
 wm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271754; x=1774876554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZaSE5FAGvb9L9rKv3u4p8gymDEWwzpmw3iLQZAJ38eA=;
 b=iLvnur/N+9+J8e1NGqLeAovjIBwLLBuadFLuhDP3aQ/FNC73QaVdmXacsuM7Q4nbgd
 4gFyGHwAs7BHLzmSL7BzuL594XKmDBQRgw0yFyF0afwDbDidfCNj36+zak8iKZZAd+IN
 +0iPoXzZIZJUhoufm5w4nw1RWzPIZbwqTjCl40uJB3gzcq4+xvYq9Ugo1lkd0YxkGcy8
 Dod4awGXHkQ8NQ3Lud6DvWlUq1KRNiJD9Zsv9YlxeuQn8qxLRdZTUtz7V0gF0S0HiER6
 umWyPS1+Ug0UHYEK0nsNlPXZ21ccYrllw0ZWN+9OXEiJ6as/297E2J9nHAiq5C+vvc3X
 fsIQ==
X-Gm-Message-State: AOJu0YxIiZKBXLlvX/yAimPD5jNdQ1xkQLhO4AbOts6ESuGtxs9v3Idx
 KdbxtX/p9OTNm1OV/GfGjrPtgG/ANoUDHesSMpiWE4dIISww6mBcFSA2siPaXIGkuDItmCB46iv
 RLbL8pt/xW6/u6F75KTRSo6Y2m8dSRpd3NdzbQZB+h3ZNLfL1j7iLv71GIjaEJhuFnJ8i
X-Gm-Gg: ATEYQzz/8kWtsKc6qTWCdHDrv/+qLI/rgpwl18dkkROOTQ21G6uGKynKxgyBdZRmqHJ
 m5ChqPicMc3+BPsSZ2hwbnir2ax7/FNREpKI1VSoMOuAUA+S9tGxBxHgkKIolVMnk+mi72GRQld
 e8+uT0W2hmhQsoWqApo12zR+HLIHLRysjEIZU4L4VMKGO8SAOlewqA7vOl4rtvONs1UGiuKDixV
 tfQYGuXNc30+iQJZG8k3kqHHwsaLWMs5JZ6K9TcoFfkg4z6oZ65HSOZ1JKl3SB9EJnUO7ffsCli
 K1UWEgOn+AObMY/BxTeY6lhpffa12aW01k52rI76xRFxm29UHbJBErno/ed+U541rk6BVanVpsT
 Jwb76ehdmO8PZXIoaMHZkcIQ7cvbSYmUtYb/ME4plp+zn3UfF+oLOASXVeFs1k+lzvfip+zQ0Yi
 4/gOCziinM
X-Received: by 2002:a05:693c:300b:b0:2be:1f56:ed21 with SMTP id
 5a478bee46e88-2c109563b70mr4891460eec.7.1774271753702; 
 Mon, 23 Mar 2026 06:15:53 -0700 (PDT)
X-Received: by 2002:a05:693c:300b:b0:2be:1f56:ed21 with SMTP id
 5a478bee46e88-2c109563b70mr4891433eec.7.1774271752888; 
 Mon, 23 Mar 2026 06:15:52 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:52 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 01/13] tests/docker: Update hexagon cross toolchain to 22.1.0
Date: Mon, 23 Mar 2026 06:15:37 -0700
Message-Id: <ab13d62e54a5f2a46b2bdce60a99cdadbdc7dbcd.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c13d0b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=ovJmrJClAAAA:8
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=q7X4_axEi9qJq2Gpr8MA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tm5Ntaz8aV3TqYRsgjWVOxJ7ok6bWyh2
X-Proofpoint-ORIG-GUID: tm5Ntaz8aV3TqYRsgjWVOxJ7ok6bWyh2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX0pbZTdt4GVSt
 se4eT1Ue9bDP1Del7N3wSg6URWs6iHF43A5hS7FjoAZx/GOOGtESsCFho+xZF+TKoaMq3l7t3TS
 cv4dVRPPWKtjDjbM0eeI2+NjfV0kkJu5BBImbjBtF3wOOyOUu5tagMATN5YFaWH3ztxwrJYBjmF
 op1Ebsqangp/vpB7TUL/o04lkp/8WlozvHf53Nr2hYevqKSv5yqpFO7D1gboYGqjNIDWTngcGEF
 AqrQExT7QxLB8P1n0AEFCSjiXZQsdMz4YkVSRdzEm0tpDZbcp7gy1V2N0A1E8rGscEAldL68wFY
 5271ms/l86yRFoGbNpBSLJk59fvHa6Knpu0SJUDWc08cksbCy7ekkgdsr45qIkpAzOK3Nty8oaB
 wP5PGMtbXSpbuJWAf4rr53hYO0UNw//6JVSeZb+q4RLLlT2TVIohVPNC60nK6i1GK7D4O+f3Ey3
 sDle5SrxrJONM3KgJsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <brian.cain@oss.qualcomm.com>

Update the hexagon cross-compiler Docker container to use toolchain
version 22.1.0, replacing the previous 12.Dec.2023 release.

Changes to accommodate the new toolchain:

- Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
  LLVM-based toolchain
- Add zstd for the new .tar.zst archive format
- Update artifact URL domain to artifacts.codelinaro.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---

I've added this patch because the tests that are added at the end of the
series depend on the new toolchain. Brian, feel free to drop this patch
when you rebase the series onto your hex-next if the patch is already
present there.

 tests/docker/dockerfiles/debian-hexagon-cross.docker | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 91d4b71ac9..636d0ca8a0 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -19,7 +19,11 @@ RUN apt-get update && \
         curl \
         ccache \
         xz-utils \
+        zstd \
         ca-certificates \
+        libc++1 \
+        libc++abi1 \
+        libunwind-19 \
         bison \
         flex \
         git \
@@ -40,12 +44,12 @@ RUN apt-get update && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 ENV TOOLCHAIN_INSTALL /opt
-ENV TOOLCHAIN_RELEASE 12.Dec.2023
+ENV TOOLCHAIN_RELEASE 22.1.0
 ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
-ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
+ENV TOOLCHAIN_URL https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 
-RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
+RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
 ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
 ENV MAKE /usr/bin/make
 # As a final step configure the user (if env is defined)
-- 
2.37.2


