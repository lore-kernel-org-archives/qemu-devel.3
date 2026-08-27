Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D33DC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSR-0007PF-24; Thu, 27 Aug 2026 18:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSC-0005xI-Mr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSA-0007O2-2z
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMLD11804178
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OeRwKx71Rli
 Splp6GuKibt2VONzaVuujgMHvj7APDPQ=; b=arC5Rv5EIOp3sN8FMe2VAOG4J70
 RY5odemtMt0am8L4hpOHOFW7DTpIE2y8xco2y94DiO5rA5xdtFXePt1wqenX5ATN
 2f5lZxef0H4j1DUYgQcmvN1U+g7Wn46wygCVv3k/lvLn1sNGLnnTcUIoe0biDZg9
 rIbLfNtysS3whWZH4kbhjhHbFnhI6bTvEFgV7Ms+k+/I/xhcFMvXLLauNeIKCU12
 8/BDyWQF+YBElSf+I4shumQ+wnE4BaAqP54eiJoUIhuSU8TJRqj2Wufgpi5f1RMz
 r7gxjZSCyw4Pjtkea1bucuauGOyhP5g9jIv8mk09OZYmHTa1Z2issRPa1pQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so536082a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869198; x=1788473998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OeRwKx71RliSplp6GuKibt2VONzaVuujgMHvj7APDPQ=;
 b=Qtv754W42xrl/Jn2V5rlpvFf8CMBdrK7jx0y+FFZi37jm2abu09dOmL85VPicloxTi
 H35X+l0uzmnZ8Oo87LMfeBmm8YLlJUo7Ju4Yt+CTKscffVma/Sl1uNe/aQwSvEt6k/l4
 +dhGKINMLCfgpH9DOTkt4of6GdugKXwazcj1WgK2efCBpo0L1H0xAhWvGf49Gb65RBET
 Q4nFfGCoTOzRcIExwIh5xeFpNmYvCHbpZ3OqetUwhQr8uNkBr+4eLNbw4pk/DRllt+dA
 85luMRBXxV5bFiqnW6ivxmC3mopbS+DJHCSZ2O7RxtlJphmkdRuw2RF80HDLx5vqFR1w
 mgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869198; x=1788473998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OeRwKx71RliSplp6GuKibt2VONzaVuujgMHvj7APDPQ=;
 b=hSFJQlAMXdML+AS6Q/rPcQkFNQ4Wic/7FZbZYnGEaU7MTH0wZpRYUxZ1kqBNNYasG1
 MYoweON4HPFu/okDQry2+8ofLNBJsjNc6eM1mU2pSWohI+tRjkXBHebW5iIshdaBHYNK
 nlXmu4KZS/HsNtvSzbqfLaksGeHIKR8BAwWJoLQMuv9UIkzrcLGJngKuPJzi7pHbPGAg
 AUZj5eZ0tyeIOuDlSupbrDqe6dMBjnd58dYipQZtZ2F0q3EEVG4QjGsGyRwSxSIhER5W
 h3f/EmwZ8fxF41NM2aXM6+RsJe8n1KeRh9WB+WEqNB8c4EgcaJ+DniZGnauU2k8fjwEQ
 H1eA==
X-Gm-Message-State: AFuF++mYsikkpMBi/hkq2fmJ5odsTmyp/XzT07ZfuVo7HK+LmAA4vQrn
 s8VXl/sRU4M7guWWZR4QftpnWmjhnwEjril7xIYmlwm32bpBSrOiI5d9Mc++LIu7hb1a0scLgsd
 CNntzWnz1sv8WAPa1K707QlET8wo91C7hzGv301odvhVxPLuk1KMCcgytIABF/DVanQ==
X-Gm-Gg: AR+sD12NZ/KiBuSDIfCTrngZcUKCPJTE3eky/+4qeHzUsWzhf9P5Tg5J7TVa7AWyGFp
 OnVYwgt9UbBeeoSWjiEUcsva57gxAubW7weOisD/IIwshyrx24/u/TLVKimpf/AHRMOiua/OOmG
 qysgsHsX7tNBI8ykiP6JspPed0ER7MAETn74t6Hy/9Eh9vEIRjkvBsmCtEpzlEjRRqDigUAH0TA
 lxM92rSe7SfRnFEYa5c6O96o6ssskDDLd0evsUIyomZ+pbTBQFiYDvwB15QVRahHhzvV9fXhP2E
 5QzX8++UoKPuhIXy/HHeZwNavYgMkuTu/zgCJSKGtC2+S68kndb2GCp/HkWfsOLWwtO0wHhSZ0J
 Jfd6y3cYJwyNi8nh1+JwESfCbNDWHY7yKHkZ7f427lUSRbz+FcDc6hUWTYx4=
X-Received: by 2002:a17:90b:1d46:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-396d0f8d841mr4437568a91.14.1787869197699; 
 Thu, 27 Aug 2026 15:19:57 -0700 (PDT)
X-Received: by 2002:a17:90b:1d46:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-396d0f8d841mr4437491a91.14.1787869197283; 
 Thu, 27 Aug 2026 15:19:57 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 068/105]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
Date: Thu, 27 Aug 2026 22:14:29 +0000
Message-ID: <20260827221506.91574-69-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b80e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=TNSyY6zQAAAA:8
 a=3B-k7g5EAAAA:20 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=ucEKaO2-bgP9YeC-RA4A:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: pqY46yNcF1rrp6PCHvk-kPAHk83AAIy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX8n+SsKsLJiH/
 UYPDHzuUgpPdI4WCRj8bH/XdTPKUvivDCigE3+BaJ3F0XOrez9Y3AAxOHF/jUgFnyJejs0c5qrX
 8YuP14B7hmUHJi0IKKyRwi4FUQqrkYTzZcS8REiLlU+lW/G0GV38m3bVMmfmXESTRq1u2NskpoI
 tcXZ/8EX4Iikml9F2goR0Iam2ABd86CiNmQnGn1UsGpDEd/IO9psjNdxkTkYu+i03G4dS+2nNKH
 5v6zj9NV5dDBAkczE5DD1rRNiVfyKDMRSe/pQH2Hh9EvwlCMDzz8GsLkvtVRBzYjMcDAcoi887W
 54LIVWIQ7ge5+VvLq0+FcQ8p2R14aCZQr3oNXQsASKp74Ab69N06kLj8bNfyGFomTjguSGrsleT
 mXRTRo29e0a01bzOFR0LPeqd++oD8+O0101BtWnS3C9rauh3/A+RUlb107Ny/n4RWbUYzxDEGle
 vhxkGe/2RAT0U90cU/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX51ivdinSFUXC
 sna770e2m6Y5KDIUo8VRyrInA5TO9MUWzMDev8Yu4Wk6ftfPeI44ktXe/i5SGROHa5nnI5Is0mo
 JTtvEj4c1lALusiAJpqiu+wLv7hrNVc=
X-Proofpoint-ORIG-GUID: pqY46yNcF1rrp6PCHvk-kPAHk83AAIy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .../dockerfiles/debian-all-test-cross.docker       | 14 +++++++++++++-
 tests/lcitool/refresh                              | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 833185f6072..c0ab05a5ff3 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -61,7 +61,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 6bc611b0e6c..9a71af0e41d 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -172,7 +172,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
-- 
2.43.0


