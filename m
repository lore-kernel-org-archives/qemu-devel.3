Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694F6C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6D-0006fG-22; Fri, 10 Jul 2026 17:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6A-0006GU-Hq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ68-00054R-PH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCjQw1931534
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I72i8fmmW5R
 rqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=; b=IR+EELWgM++Zc29xjrp4/MBuokE
 00rynnMhGPNgLnNuN2lFaKiiS51qvhhAX8+HluZzQ6GMdD3b8T0Xmlw3m+nztGu1
 TKEU0siSKHsmd8O+snSPl7WK7fb18pGtJ0VMEbRU3R2iZdmMn+Mk9gqIkQIJOOry
 AJ04oZIqPdjzffLTKEQdO/xWwiesdBq1DCvZaK8I1V4WPHO7d7MSe3T6q3cz15aN
 U1Za+NMSZ23Vmwf25hwxaVxHzi4FsjcrCS2x9ByZ0Ex4bG/q1csPunTCBVigWCmY
 bZHkp3CBnzi6rx9dg9prOJKFVicV6c0NTZD+zJkZB+rKLUtRT8mqEUVuKxw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r336-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9667280edeso1942940a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720157; x=1784324957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I72i8fmmW5RrqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=;
 b=B49ZRBWX2SghcekJs8b93Dqz5NBB+q6EyXX1oAOYUWcpAQ77ewx66I3KJNrbVyQrXr
 TYX9b+xYu8miuNgcYNQLyuM/zM+jaAXNgIwHI4GRUuso4fgEuhjyCS4taqmx0S2573io
 e64p8gwv2LF/vJX3cOT97kmbUXqA280B9ltg9l0ovn+q7GAGp1krqBxUtNUz1gvp4QfH
 LtHsbh4LgWps18287GWeget9zHjh+KQ6rsOBrZ1ZdiIBb0GKkq+VFg1GNIGbr20A8cI6
 IuWO7xVYlcEqGooOqa0dbffAL6ctAuqqJJFOyR/UwEX4VNuj66lb2xBwvCl1GizmITib
 HFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720157; x=1784324957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I72i8fmmW5RrqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=;
 b=B2ocaTu1AQutrFl9ndGSf8fp7cm6180npckfQUSYsKF67WW1bPuhR4E7HwIMscaxVW
 7nk4Jwvjh+4dclq94Bo2AatuC4MH/f6ssAAg9422oJ02Hq5x8olWBFcYMHoi7AKclh11
 iMACwF9wKlz6ScUEhmN2Yzrcsl5QrgeJDEsR8kJnAjjGlwhNu01/Rd+YArA7ANo7QNlM
 xikDhWwLO3c1why9Xf6/8E2EDPrlaZc9XPEbom7cyNvEt6LE7tQFdSPDvihdEpzFnDG8
 vUr2nYVS+Tqj41aDDyrZrQLd9jOardX1zUsPcJuuSWLzdJrwYQF38hoCCosX5JxyfiF0
 Rr6g==
X-Gm-Message-State: AOJu0YzPpn/U99h48ozrJ/x1wjYBzEqp1YQcQjhQOwei9VZUIb4ZLScs
 3ch356n3k5MAJqvn3IvvPdQpcZBm8eDTcOLeedDLeYuJ0vNiNgJ8z9LHKvz7pwxPiAFRv0eJQes
 /pFE3M9weW2Y+rJsQivGijlFloNASRrrQNZcisW6cFVvJLgVV1SZqtRgaOQz8dFJ5+w==
X-Gm-Gg: AfdE7clKsgDkvv9MJio+i1o4STNsJ0Rk/L0r0O+p8ctWHIvw4HFtsyyQp0VunSjzSRf
 sEPYsbQQbnrivrb8/70gZBMQuSlaH7b34LTc9FXaMMTzZwxUqOgeEKFL5/qU3LwEPVt1huRkhWo
 ktstBv+tLYEn+RvRuWneKPzS+cdizbWeBgVY74tMl4l01DUUxSS5VpcVG+w0AKD51YjmYCQDwWD
 rAJZXTElwGjEmXejWqHgd2TyIQnqPKcL5R1NXvCLC/7223qxawwTYSdexS8/ntKKK3hzQPO2ilA
 LLpyGjTp+n69unwz63OGX8Sz5sb37ChJfHh6y5SgEfitsua83TEWMT6gIssny2U6bGfPJencpIJ
 Lj7iMOR7GFZdIifGDPB0Adw3Q+oSH0zuKDfFIUpIbYFNstrm+MxncaXU1kMWBDlC9Rq4JDHv4Ms
 3Vlr3pGw==
X-Received: by 2002:a05:6a20:1604:b0:3bb:2200:f67b with SMTP id
 adf61e73a8af0-3c110cdb319mr681172637.40.1783720156747; 
 Fri, 10 Jul 2026 14:49:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:1604:b0:3bb:2200:f67b with SMTP id
 adf61e73a8af0-3c110cdb319mr681153637.40.1783720156337; 
 Fri, 10 Jul 2026 14:49:16 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 66/98]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
Date: Fri, 10 Jul 2026 14:43:10 -0700
Message-ID: <20260710214343.2065491-67-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5168dd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=TNSyY6zQAAAA:8
 a=3B-k7g5EAAAA:20 a=EUspDBNiAAAA:8 a=ucEKaO2-bgP9YeC-RA4A:9
 a=bFCP_H2QrGi7Okbo017w:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 1yojls_cPBx2wf5zgqRTfrwDPlql26Xc
X-Proofpoint-ORIG-GUID: 1yojls_cPBx2wf5zgqRTfrwDPlql26Xc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXwBVGU81Q7/Pj
 wOcMyZ5Uymxkz8RTSrw5c5oYetDxugHFgkWBTnywQFv8VsVNO9ckXA7P5CfQ4pRej/arVsEPaHh
 nEBl97GUt1OuvWD9U7LyKNCe9pKIoms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX4Qt9s1KCS+4x
 oQ98Ijta7ki27nufQJqUTnvwW/KoJjtXpHrNeyoPsfe6bFRNBlPghR72EHWfJWebx0sIe/1gag+
 pXirudwpQNpBUGAhS6legT1cX/SO6biynEcW9LTxeM7FtcEPIBRbXeeJAL/hy9b7qMANxlkgSb+
 qsw9BBX+pHIytWaXoFXCZ0+g7RNp4zFvQ2pVA7uvqbRu1Q+0JZqVF3OV+e45ugP+MKfK1UNp1U5
 TzINHqcsYlUUzeJcJsXK1qSx3BMZA7HHdHJDgKaoqC5yvXPHBuQ27VleFrwAOify+Z5Af2gL/ZK
 Nc+Ztvg5eCJ4FgVvTUSbJznG7Z4IptBqfk/exmEWowsess+dUXyd9lqtelmoRoDtteux+kAJwv5
 9+al8Js8CoEIESHRLIDsocBZBO2xLHWH90CshOguYlX5qWAvbC/uXCWgbwyQIt4fYm7KoriDCeL
 urEevbGd5FXqy8+tOLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
2.47.3


