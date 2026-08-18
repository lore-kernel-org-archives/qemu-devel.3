Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2BFC5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUG-0007HD-DI; Tue, 18 Aug 2026 15:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUE-00078J-CP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUC-0007ah-89
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGxN91549009
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yFgi7sP7Cuw
 5D6GHhcIlectrikwK2uQIM6YG8U50DIg=; b=oUrAFb1+loLZyIlc8RSNiYkmsrL
 nEEqW6+pMAMi5QTvqPW5W7ePU0pbOv5wH6t1zuhFts2FgFxdjeryn4rq/ZMi39tk
 NFKv2l1gg7t+8YRCFc4fHDTABKDuKiilr2jHNtUDxrOcCoRii6QwW8KkkfcBj0O+
 8SyTAXnudF6elDcskJ6udz+iIqfE5by6jLrQLTiNUjYc5l1HHIlZs293FRZQtVxj
 7aMXxMbJfWHoxvwL/FSjJ5ias8sHLbBFG6xbPzfAJ4lzpfxjJjNx2+idjSzxj+5r
 7TOqjv6tEVGqhkzRRnuV99GzwBgbD0kbbruxh5GSFr24RFjUf/m4knQ4Whw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uj1gpv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d54187d8b0so4265115ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081314; x=1787686114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yFgi7sP7Cuw5D6GHhcIlectrikwK2uQIM6YG8U50DIg=;
 b=S/xbPKTZV3AcSpgwaR3s9lzjr/FCq77OlWI59tGMFw+jQc7zBRNI+c2W60wsjlNDn9
 /i8EYYJVm200YkO7RqpcYisJF0wsY210k0C1oly/3agcHoA3LrvFAXGmUhc5MrvPugjH
 WBc3ug4F/pzfgHeZPxG3y3d2nuira1545/Huem5lAW/McLSOm38uXQ6lxDfyYDBmFK68
 z7HqN026UhfDv988Io/wMO3X6807sbHkZhaGMvGx7c/jHMG5cBMjfZ+J3Uhr8uY5PX+/
 QOguUUxuY+hfVZmBKl5waCF4MxcF+ZvAC6DHqeG6hCRmAb6ZdPASocb0tc9aG9qE/lyw
 ydEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081314; x=1787686114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yFgi7sP7Cuw5D6GHhcIlectrikwK2uQIM6YG8U50DIg=;
 b=mvjwtBgU34phkrX+S8T5O2C0HOhcmpxD6HUrbmCSzcnRdoKYg1s9x8ED+tXHofjNjh
 3EP9AK4IXKoHRw7HcSiyloZOAp+7oqf7Ux2lrSop6Yl388S5Ec+MFzyXLLkfIx7cRJNi
 pHgmqCgW1xp69Vz2XEOM63w2x6m0CwVvbe+yEVqcwulOYkGN+jY0ah9B2dumdkbnk4B2
 tXVn9Rya72jGCjZYgnwNPWyJqnKSy3g1ROQBXCdsh69vF6SWq+MHtfJum02BHdpWXk81
 Q2wkcebXFpJqJ2AzPLOWt8MpWWOv3jhFu4oCy27P2ngqF35mX6w3r+d/dj1mU+CxT6X1
 vJfA==
X-Gm-Message-State: AOJu0YxOt6mdlBjQYvLWl970HXVoV7FIuwZeATmKjlv2u9xJGzTaLZBV
 IYsiEbqfhbdNw3U+04V4teu0D9ymSkV7jh9m8afrOmFQRuwaEm3PjJA5lhbmFIyV+cUgLe++CJs
 ofUCFKHXCTop3czWUDB4BbIwNPrGmModP0SFX8PqdBVoRZFydbeQSdetenTe+mqpswA==
X-Gm-Gg: AR+sD127SqOxLZlRTjmfQupM4m0NtRfRYK1HhB3Bke+ZgXEwWo3WrV8DLHNQ2eN+lWX
 wWw4WqiML2cGL3HEIaiKqozC0lXo59XQ+qHVMEaA0l2g4xBIazaXzvVXqTcDr8J6VaX4dSyYHgv
 sATgEPwKCpq8ml5Q70cueGjRX2aNQWB5TtoLpVfVbbG98F9Q5HOryaPfmAlK3kKmUTFYJ4AOkrw
 /kxYUj73SQM+n36D74NJcnug7igLSt2Dwp/M6aKwwpr0TD1tDQMG6cH7dOfyOI6qDDDeayGL2ES
 LYmG+rT5nElgAh3xBxyoQhLzPmZnkmZ6KvBcj6P1lbAjifnWlLsnM7IkBgiumFAMZyxW0ibdsHo
 EpuBm3XASnrCpeEx6o0ft1j0nn1StTKz/HNnwN3JtbU27oqdQxQBvi6GGli4=
X-Received: by 2002:a17:902:ffce:b0:2d0:cc92:f7ae with SMTP id
 d9443c01a7336-2d5f6a50914mr3400915ad.3.1787081314164; 
 Tue, 18 Aug 2026 12:28:34 -0700 (PDT)
X-Received: by 2002:a17:902:ffce:b0:2d0:cc92:f7ae with SMTP id
 d9443c01a7336-2d5f6a50914mr3400265ad.3.1787081313753; 
 Tue, 18 Aug 2026 12:28:33 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 068/104]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
Date: Tue, 18 Aug 2026 19:22:32 +0000
Message-ID: <20260818192309.22169-69-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rKy6hGfMdIgJUooViI9zN2Lc6m6rG74F
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6JURuSTPbgVc
 MEHw54iakWrZp7+Vch0MgZY3OYRA4YzugsNjQcB0aYz5+79Jh1BLRmaDhTQMzdkP9woHNV1GeBJ
 /CDIQXxGkw0ne1x55Vjc0cgunAhSbe8=
X-Proofpoint-ORIG-GUID: rKy6hGfMdIgJUooViI9zN2Lc6m6rG74F
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=6a84b263 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=TNSyY6zQAAAA:8
 a=3B-k7g5EAAAA:20 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=ucEKaO2-bgP9YeC-RA4A:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxM4xM8hSov3s
 fYopwqcECnN9HN3lDmjd7LQPqCxREqkzYIQxZGPlCPKJM88utoGVOOk65elID5Fh/ZbAxmK3Tx8
 3dRjI7SZw/7axoYWVglebXZ4Lmte4ecpOgXimbijwS2Tj/x9DOffnDhDt3m7HZkYcs+VYdGB/HX
 MSrlq0t6Wo48z+N4nBLg35PeCNV/viHEOleP62wetbO+8UYjbkpIRX8MiDsX1OHZwkoSNLtKPXA
 T2eNFISveXYySBi8wNAgh6A+CO4MNIFKcUXFdgvShQ/TUCwTEf9WWaO1Hboz9H8oh3QHoYna4AF
 uRiL4S1C6GQU0syAFA6eaq57OQeIGBqGj9kV4ZlorvVVbK1TSHY+rOEyWIWj6Il/m/GyjaZnkCP
 P+w++2lxwUEhDuM67bh4gwJh+WWzyOGxx5Vn1NF82mMBygQ5klw3RnhvyqBHXjSs+3gIo4Sa39E
 8wnXPjaOksvyXw3SElA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
index 2dc580552e3..449ea0301a0 100644
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


