Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DB606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QVRxJXRq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eQrst5mI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzLh-0006iz-HO; Fri, 27 Nov 2026 12:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJM-0006DR-8W
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJC-00026W-IY
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:29 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFp7kj925498
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z/vxgJGhBdJ
 mKYZp1licpBLEykqurdN1Auf82kc/PHM=; b=QVRxJXRqtc6XwL8USlTy7UF+zkI
 8ZbcU4iJaU4J+ntWNWqqpEbUMbsxRS51DWVfCBXK+dyFl3Fu6jC7sJ20WXBdrHq0
 8O7hfgeCmxuTuuVLZ3tWS2qTk6/xnII8ENGp2DfJQwC0JptczZqKAcE/Uh14TbQ+
 v7Vk17oWdnCyxi6reb64UaP0SVgRdSHgSRwni39JA+hI7288QR0wN1Rdm2epoM4x
 aBKkoKKr+968LQxU+JNXPsl0UsjZ3smk2YK8qSOhjpvCPVtAzZ9hQ0vv95BrpHJV
 b75/gD6Wx3XxZc8Blixwz5XW8nSbNm0+X4L5HIgTfkp2JRfW1ORjKhYLD4g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49bwng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8aa185840bdso5910668b3a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795798819; x=1796403619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z/vxgJGhBdJmKYZp1licpBLEykqurdN1Auf82kc/PHM=;
 b=eQrst5mIyVGIG+Lyl3G6D75OCesGRuvM/KmQHaYZtcRzMD8nEVDAs1jUygOnmNWTAB
 BA2AszLSLeREvTJ1foW3TLuy+h7IzCbbGHF/4Qa+ZiSL4hcMrcAcsq28TxOi9/aKab7C
 yHwh97snD2n+BOQRF7NdlIVAvO8nnq/fkutBan5xtCIc5sEXieOuiejhLWmGFasL1KCZ
 asLWf36pOMU4h9kwN+xD3pUNYULiwAyg0BRcqvIndWnqWF8Hue+uJ2IAXRzw2arllAN6
 teCe8BLehA+pn1WmBHlT4VpXGWlb7CgVTYH4boaehCd7/4DiTkuAeM6A9BLurK/AnK0g
 XUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798819; x=1796403619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z/vxgJGhBdJmKYZp1licpBLEykqurdN1Auf82kc/PHM=;
 b=UBboj8t1P2BeOeQ39VZM0KRoGJf46TKIsvpgzTXHiD3tFqRJ9HtZdpAzUQg6dMFJJk
 9VroIRLoSYmvJGf4Wyx1T4IXOcVnp9sQGlCrXf6Eq+GXLLDNqusBPnOEDqMMLcLYGsAQ
 2oqEgUDK4qSa30Guvt9NF/bPlvDMoiTCOfTvGZCTnIRO1/xvT3e6ypfFog0Gf3ZPX52x
 kAKalNC9KbeSXBKYbJwT6eZQx0xwJPrW+rrlVodm8YwDEg1tWdS5Xzs0OIvt5/xf3X5v
 LvYR4tb7dk++wgUX3im3NT6iJcjR3bBm/ulct7FZE0gZGr+VjCZfNuGtz7SLFxBWTHqJ
 qt1Q==
X-Gm-Message-State: APuU4Z8fsU+86yg7mz6OXp+71XZBnTAJX7xwk/INhoyQd/uTpGaUs+aT
 fFxzhFcpqm8aC9u/8DvfrU4LyDU5hN5Fe4gXf8evjsCZOckBkC4he+Zs6vYAYjKIgBMs/zeqqn7
 7m+LQJTTm9kS6WjFlQ3dKWEhAyjyPeZZa4372BSaewEMDQ/sGRphJFbJS0spIGxRSLg==
X-Gm-Gg: AZFdTZcKsfC+JAx2cwgfVYV9pmdDBv6JWsuuF0MdFh94pj3h4GX+Brr2tOT7UponO4W
 aJKj0G1YXDqabT43uBDZUwMr8rdKBWjCXnAiJcOa7Nuu14Y0oAAuybLtc4HTvg7rOB4ff9R4YTo
 hp/Isc6HhXJlM2SLKpj/4f5BIRLG8NcFHD81n+X4nZB695eG4Mqe2vXHzF+l5p+sVE+GNbVqR6q
 J5xKg3mnbpJ2xejpThFcV3JN00pRGD7JBNGpIr6dHKdw+FZb/vKV+d02T+M5gl+gzVHgB14aqmU
 1oLf0PxMPdJC/eidN3K7amFhyLUhDZX4EqwyIdgvPeI+1CvekY8Xq2ThtTJFbCSwvRCogB95hCb
 InjvnDihyHD6MxVc1qIdGJhm6rua6F6qUOUsOKtizpNwx66XXJ34nrxZTCb0rwW43TFDI5+9RHt
 zvmzBLBkjrIK1lMoUn2BxUGaVEFpTSAL1Swi7K
X-Received: by 2002:a05:6300:8095:b0:3f8:f792:2373 with SMTP id
 adf61e73a8af0-4014c2573b2mr22899606637.48.1795798819125; 
 Fri, 27 Nov 2026 09:00:19 -0800 (PST)
X-Received: by 2002:a05:6300:8095:b0:3f8:f792:2373 with SMTP id
 adf61e73a8af0-4014c2573b2mr22899547637.48.1795798818571; 
 Fri, 27 Nov 2026 09:00:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077a058sm13014650b3a.8.2026.11.27.09.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:00:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] tests/lcitool: Switch to a newer version of netmap and
 check it out faster
Date: Fri, 27 Nov 2026 16:59:51 +0000
Message-ID: <20261127165953.51257-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 06wy8cxZAeDbpGlb0oVUBrlB1NOd7TmH
X-Proofpoint-ORIG-GUID: 06wy8cxZAeDbpGlb0oVUBrlB1NOd7TmH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfXw7ATj8jVFMIE
 vKPE5Lu/no3iWV1M5ipma4ImPXKRumBXPlQDRSRzHPvnR3ebX/B35tnjLxbiZNCMNVACI3cyo+v
 MPJhwl3U0hyfp28fMEwp8k7mnuW8jRA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfXyQMYCLSgOUyS
 90v+zwR6fc8zDFn4gTMUleYMULA7qTrQli3cODoAW8LTf+ud1VPNjLCKnGyTEbjisk2LKeVFVSk
 5p/zZQBUQk0R/VsUWY4nZX3fJEihuOVp6LCJKgly9AlJhc5TeWekMuWxS99xWUIGMfaNemJfkCp
 MXHY1h1wNRnLJJ1YG0bT205ZpGGWRmme4lZcIvVmII8+eCgOn5U4lTFV5QJzCZdp5EnHsJ3/Az3
 e8D1UDl9bhWJnXGNYfp3FYesSvcfk5qy/xO20i5GIH0VIrxYJ/Y2NGJgms7Yp81qm0cukgrzbVa
 hCEpbTxaRFEsb2LKxAMNZcYfWHinUIqrpWXSDFnLETGNa+OkUWxAD5EN+aATnqGHlIh7DLwwm6k
 MScwNA9AUZo57sMxcEbRiOGWWPBiOTyatGD9x7XgC+DEzKHA73PNZi+zBMaOKPBqmI9dr7dztvu
 06ER4dbUyEiLJLRQsZA==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b09b724 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=37pvPIjoEhJvAkar:21 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=irxyurOfxv8hHXk4GvsA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

Netmap v11.3 is from 2017, so this is way older than the oldest version
of other features that we support in QEMU. The newest tagged version is
v13.0 which is from 2019 - still old, but at least it's the newest one
with a version number, so let's use that instead.

While we're at it, also make sure to check out only the revision that we
need, so we don't waste bandwidth by downloading the whole repository here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261106063103.21061-1-thuth@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian.docker | 4 ++--
 tests/lcitool/refresh                  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index ce591feec21..aeed90523c7 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -161,8 +161,8 @@ RUN apt update && \
   cscope\
   global\
   linux-headers-generic
-RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
-RUN cd /usr/src/netmap && git checkout v11.3
+RUN git clone -cadvice.detachedHead=false --branch=v13.0 --depth=1 \
+              https://github.com/luigirizzo/netmap.git /usr/src/netmap
 RUN cd /usr/src/netmap/LINUX && \
   ./configure --no-drivers --no-apps \
   --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 075acb82e1d..57593e6ded1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -117,8 +117,8 @@ RUN apt update && \
   cscope\
   global\
   linux-headers-generic
-RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
-RUN cd /usr/src/netmap && git checkout v11.3
+RUN git clone -cadvice.detachedHead=false --branch=v13.0 --depth=1 \
+              https://github.com/luigirizzo/netmap.git /usr/src/netmap
 RUN cd /usr/src/netmap/LINUX && \
   ./configure --no-drivers --no-apps \
   --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \
-- 
2.43.0


