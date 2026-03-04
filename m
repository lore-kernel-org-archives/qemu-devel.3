Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82526EFCE42
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 20:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxsXC-0006Gd-03; Wed, 04 Mar 2026 15:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsX8-0006Fn-DB
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:09:28 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsX3-0005DZ-1i
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:09:23 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624HH67W3837880
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2026 20:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g+hCYkwsp9syiYngs9sY5w24m9/3g8ESrqSXmU68kjc=; b=hFE/3Bs+8i8bfieW
 6GadyC01HaNa9OpE09b3Jy71jIxeF186lWmwNfz8TPzMBu3g6OXy8b9mdra8kLQq
 SakAz3FJXwoQxxRBCKk1you3xeGBGszabOZ1hD74RmlN5WELlC7Py6q+2bbIGrBv
 tMuGMjzAecALyONZQBjYTcTuHiEXUECPxucyQbBkYRL71cRaYwKRlhfI9lNQzHre
 f6SEnXKYglI7psbKRJF0b+6KjWHyLT8zBVWOiGAsLx2y6wMqKN0S2M/X0GfWYfLn
 G7y1aWZdjJKmb72R2YZ+lKE1oOI+yxJSPbcMq2I2jsJl3Wtdvf90ZFJsjVyvFPMd
 AMqk8Q==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m0hbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 20:09:19 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-679c69b46c6so62950551eaf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772654959; x=1773259759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+hCYkwsp9syiYngs9sY5w24m9/3g8ESrqSXmU68kjc=;
 b=HCMBRN+/CnefGJxs30u+PtFzsrHT9uwv8WF093cBOBjN9AepeDUFF8tlqGKGoTU4Vf
 xy7DRhsq5BSIspQo3N3x4taEF8XzXkMAnU7Dxf1nw1AUT1LpQKaJhuGaclxu2ax1P8+D
 JXFnHW6rO9hIeaYXrSgjzMPMqsZHDK7GcdHtErti6yfjx8Nyil/Vb8NVI3Ll0aJM+wXt
 dV+AbOsiEFg/LOjyfJxl5RDzzhu5nTqGxVy+0UlC5R1jRKxEQHomLbrCrZz693xju522
 MjB8ROghs0arGHQuFbt0VXimT85OPDIH55QfrW/DhILNFqDI3WeWyODWKJY28UUokzIm
 u8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772654959; x=1773259759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+hCYkwsp9syiYngs9sY5w24m9/3g8ESrqSXmU68kjc=;
 b=bmdwnefJ5wvVSxI4BqcbBsf/+ypzJ93U2rDKOe7FmVKRCffiwUmHskV+SImC8l+Doi
 sid7QB0jaq8S+sQPtVjl9cQU14p1VYSorjo7zjRole6a+uEQXL0mwpkcTNUHeAIzJich
 5hgtuOSR1V4vgMGXc2jHx3K5Xy86TrW7WBqvw7ZlNVS3EVyZbS7iNY6HyllzB0mTW2dK
 vtCY7UNZDcjhLp/EB3YTIE+HlQeY6Y5L/L5+RN++TnkdeUBGXfFFuepEjIgB8dVrkRcx
 g2PNTqnIqT/+KVoSwtiYS8wSeVtETu5c5GUv6Gyw0jljfDlUKFq0333qUG3qwtFtoqJv
 FKAg==
X-Gm-Message-State: AOJu0YzjOYYm9EvrmMz4jKiD3e+alOJYHiNTq9QzQ4+DOws3eEl17KUr
 hetcuKG0eFri06lQf7spNNHNg+gghYpuZ00cr1w/AYy/MqEoTU75lWpET+1eGvbhbglyEMNEfHq
 TMVcroabksJIiD9okN1WBiC5HjO1dAXPNlFEq1boqq+bRE9Lh96MRyrllIOdz8GL02g==
X-Gm-Gg: ATEYQzyQKjjr5Of1vD0mXvdzw10yDIOXOXdCa0SX5q0lBGUCNCSrHb0qEEO4HAQsRay
 zBdtr/zXo8KkD29LKxCt16vyxPWwcTVVfd1wDV2ZP4gXh0UvyoO1sU+7Pt50CjaUA6bUMsTCTgz
 WV2w7BBt5Xpkn74T05NHneetqn30nBdCIIFIy0QVlz6p4AMhrGCdjgNN8Tg014q5wnPBKR29Pnn
 Cng1UFednOEn1MorYLPZ6IrCqsm4UbH+WDmk89IW2X+FzTqnwxH8qWZyXx8YG0eLi3AKvAXv03a
 Tpa4wyTlZ4slVgkij00Gl+c9g1UP0xd0hlc0pTiFDtoi8OCcRWVZubDnDwbmDZ0zRh9B3kUgcnl
 TPfGpN8gRiIUOGOAyElRlDW2uuBB7QsUtk95NpfdiJ4Qx9M+MhfGpIPC39oQpwzNiQ7TGhg==
X-Received: by 2002:a05:6820:2d08:b0:662:f7a0:e489 with SMTP id
 006d021491bc7-67b176f7ec2mr1944826eaf.19.1772654958815; 
 Wed, 04 Mar 2026 12:09:18 -0800 (PST)
X-Received: by 2002:a05:6820:2d08:b0:662:f7a0:e489 with SMTP id
 006d021491bc7-67b176f7ec2mr1944802eaf.19.1772654958458; 
 Wed, 04 Mar 2026 12:09:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2bec8a1sm14904882eaf.6.2026.03.04.12.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 12:09:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, berrange@redhat.com, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/1] tests/docker: Update hexagon cross toolchain to 22.1.0
Date: Wed,  4 Mar 2026 12:09:01 -0800
Message-Id: <20260304200901.1281731-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304200901.1281731-1-brian.cain@oss.qualcomm.com>
References: <20260304200901.1281731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a8916f cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ovJmrJClAAAA:8 a=qC_FGOx9AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=q7X4_axEi9qJq2Gpr8MA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ls8JeclrNXe5xyBYffgjSYIDZU_YJWr3
X-Proofpoint-GUID: ls8JeclrNXe5xyBYffgjSYIDZU_YJWr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2NCBTYWx0ZWRfXye9zbQsfFyv5
 rFIoGoGvbuDyvHwSOa60qwWHkrfhQFwsixCRmGREsljgXtPYhwcIKzY/76UxU+HohqkIZyr5EzL
 sNV7xhE45In22+cP+Ws4t/DtB8S6BV7puUaXn+XNYhRU9bMiYe0tWXw3WL2BTf4dEDQzd9kDD9c
 +4H84dPYqhsTgr27okaTQ9iBw8trdLC82gSXu4lhLMg+07zcl0mseneLbl/k/eAf0KEmuRbfkW7
 9yWnBx8YxWDZvdZMlMNWembPZQFjQKpcgyqWW2eI9Ab8O0rs1twPrsCihvuWQf8KbuSOwOUvh9z
 vW5XNy4iFcgYQeAz7PGVD/7ofoeZxrRg7KQqGRhFqK8MQGPh5CK+TCOWvYF8WNYYEYnZb+RFiBq
 Kua30Jkh41fAVpQWSdU+pNYU2rkc7zqThGtNOLY6yT6TJ60pjYo6ktV9IIn/3f+EUfoGfaUnrrl
 ranLUiEXpfeluyxHkqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.34.1


