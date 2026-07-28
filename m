Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE88DC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjW-000291-6e; Tue, 28 Jul 2026 00:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjT-0001rm-1q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjR-00026c-4d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bZVL1425153
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z0iGwdNCnsF
 yGmYtxmWkBPG2F8MsivvDR0UbaQXRdUM=; b=TGuUDh8SMfminffebmYq9g0fJDZ
 aPoCmOFsX8/P+Yj37rZUhRTsl8TCcGKauINK2pCDu8SuBB8J7fPACirb5zhWhyi9
 UOHi9oZaqtcAl+YyxluBBLgP/VM9ZRKxImCjHgIq+vieI49N1st/sgUOToaLfE2R
 v+AqmqUux2zEmGEuejy/MEDhNypR7ntl0g3w128ljALcZRD24ST6Uw5GwIvZkBHS
 +XjlzvG4crjMc2Pqv50C74kMVxd86mpmzI8uPXkDWRVhdxFlbE/avhommBONQ5ks
 gjTjrxUKdR213nhIrUIkB+C/qy7eIohJ6WQm752oR/zcBaDdSPb2PzuyCNg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mpv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so2590172a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214075; x=1785818875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z0iGwdNCnsFyGmYtxmWkBPG2F8MsivvDR0UbaQXRdUM=;
 b=YFM5ErA++hNWSxXbWEC2KD0Z+t+37e5uHva1M2tYVQ9Kw3ZwScYqa6Z4YbXQ/RGPfy
 1cWn74ZqDT5jVmuk1IlYlaWaYQFrimOGdpQQUWDTrCnDlHb9E4PcbtCk9IQRkrrAsLMk
 zA0L7EvoM5kDRmrMWnbCXYURjxSOWlzMV0gq9eLbLczxc2uYc2Nd02olUl/LOulHqjvI
 0RNAVLmwMR+vQureZF+vxaqEoXTwrNBgRGK6izf8huddYgOgtEOpkUFt6xRv96CB1iE1
 afawnStEYt8eCdmFKboHrw6HGpIcYfONdIo+5Sv+3NpsgQec2WSPqhtyX3D0jNautNsL
 nadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214075; x=1785818875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z0iGwdNCnsFyGmYtxmWkBPG2F8MsivvDR0UbaQXRdUM=;
 b=shRg28Ndt5JTU+W/YUYsoOuH+V3089Rj51HwHkss5x5F93TIg9muZ/W2iMk9hjzw4i
 CagonyS3+UrOjLgBfxtjMqzzwT/ErFjA9dh78Irg3Xh1NwhqDdDzaS0PjVS8clsiymzP
 titg6oJu2HzE3zlBnvuxrperTt4HU9k0ig82Bn/uXHnjscNBNzuRyi/BFF0TC/8L1iZH
 f5Zp90CsTjoCPDYIDVTpVgKu2YPH17SSpTJgmiU8gTlEK9Ko3JVR9f5H/uYMZSu6aeg8
 VdWAUbCZgebuMOnvd8F53fmoJi2yiFFsWnrc45fxNDw6ThWBmpi72UzohabAyW12mt5X
 6uuA==
X-Gm-Message-State: AOJu0Yxw7yyhEpzSIUKzrqVAT3b/0i+2ioGYBlEqCYqaCxLAJ+ATsSe2
 yKJPJgRYB1c1Lcuc1jjmcpwLlvli/ZeGkDkggSh8yzXjNnUStdEKzF3GHUze8Er5CNiIG/eKHzw
 Kw6/ZtDTzgZyKDg9kYhHiznu5lIGCqYzF4ErVOOgZnRHU1VN5OIzAbaqn+gu1Qrhwfw==
X-Gm-Gg: AR+sD10r8djL2dIgnPsg8Mg1sHno13oUr7YDPSad2NOT0r6La7JAVGcNZ+I1AGzNX/G
 fSw0AziAvpyqW1jHjeFMDwksQMUwVtb9Bq/UnhfHLqVOs6i6hxDpyxvZXr/vj23XBSyLNGKab8H
 o0w3IOtpUFyJPoHKXw5NlAbMfSieg0yzmFWL3R9u77YDCMf/ipmzkvf+JdW0Lad0SeXSQ9O7m0V
 qmSb1spdzXnkldrLNtRNPupFWzf4XV08EzIAR7DuNZQDoAKFJmfVynFplK1EeAAwyy+G1KV3VHS
 ONCEpLYFN62OGb8vSaF3BQcKjS4Z9VFk1knotgC8MVucq/t7DbFn8Un8i5cXzVN7i1Odvifv7I4
 n6jom0oXzt9BnVgXM/F+2j2CSeP1rLrSTbgKHkCshyhYYNx60JfGIPI+YD0zuAgiDodbTU1w=
X-Received: by 2002:a05:6a21:6b01:b0:3c3:bee9:8eec with SMTP id
 adf61e73a8af0-3c8b70d0182mr1082358637.19.1785214075108; 
 Mon, 27 Jul 2026 21:47:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b01:b0:3c3:bee9:8eec with SMTP id
 adf61e73a8af0-3c8b70d0182mr1082322637.19.1785214074685; 
 Mon, 27 Jul 2026 21:47:54 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 056/103] tests/tcg/loongarch64: user tests
Date: Mon, 27 Jul 2026 21:42:00 -0700
Message-ID: <20260728044248.137626-57-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXzOxkTn+0Gzc9
 iQjrg6qJVg1DZOEt/sAzOsfpfRbmgN/O72ZsbONfYj2fU53bkbDQDG0/h5qT0zdVmqZP9WM2NWz
 INBrgQ4ou8IQBX8OT38xj5yBG6BGaf4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXzcLxtVYIoHvA
 SBBh+ZucRm0/r4Nb7XUDO0wkTd8LCguoI9N7208EwTf8ti888EYLAUNCMgbYkQ//gOBwgZv5zL1
 S9jF4xg7CDgqkog+MlrCgSXofWer63KZfmEbrvTURjQm+Nvd7xi/bHp7m5SUraVF7DKxKYaSR8S
 3wX6XMslbMX4+eOhXsmEn6xrssUIyaLI5e0/24MGA1aLlqBNlMJvkborhs71lnDJRh8toa8MQsa
 vRBYdTiickxuBD8Qhr0WhACXQgZTo4220Bzn1Dgfgr6QP/CzUq6BVrtFugGZ8g3svKfG34QkLUA
 D9P3lwMYIEAPl7nHPlq4tePI4GFHIMolfZ3HTaIT8UobLvcz948Aufo1r3OOrJnWSPDj/hW9kA0
 1b2OfuCQysyyS+r9/upRYLefsa+398m1Pb82mGv8RGqRon3PDFJhuCWdvbptMsgRFCmBYV7AV2Y
 HwDM6nC4sRWGBy3w58w==
X-Proofpoint-GUID: qvQY3BlqRsGkY5f6vg__pztcjbOmnUXW
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a68347c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Y62p6b28tDkMR5CZvOEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: qvQY3BlqRsGkY5f6vg__pztcjbOmnUXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
 tests/tcg/loongarch64/Makefile.target | 20 ------------------
 tests/tcg/loongarch64/meson.build     | 30 +++++++++++++++++++++++++++
 tests/tcg/meson.build                 |  1 +
 3 files changed, 31 insertions(+), 20 deletions(-)
 delete mode 100644 tests/tcg/loongarch64/Makefile.target
 create mode 100644 tests/tcg/loongarch64/meson.build

diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
deleted file mode 100644
index 00030a10266..00000000000
--- a/tests/tcg/loongarch64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# LoongArch64 specific tweaks
-
-# Loongarch64 doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-LOONGARCH64_SRC=$(SRC_PATH)/tests/tcg/loongarch64
-VPATH += $(LOONGARCH64_SRC)
-
-LDFLAGS+=-lm
-
-LOONGARCH64_TESTS  = test_bit
-LOONGARCH64_TESTS  += test_div
-LOONGARCH64_TESTS  += test_fclass
-LOONGARCH64_TESTS  += test_fpcom
-LOONGARCH64_TESTS  += test_pcadd
-LOONGARCH64_TESTS  += test_fcsr
-
-TESTS += $(LOONGARCH64_TESTS)
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
new file mode 100644
index 00000000000..209179fd96c
--- /dev/null
+++ b/tests/tcg/loongarch64/meson.build
@@ -0,0 +1,30 @@
+cc = 'loongarch64-unknown-linux-gnu-gcc'
+cc_dockerfile = 'debian-loongarch-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_bit.c': {},
+  'test_fclass.c': {},
+  'test_fcsr.c': {},
+  'test_fpcom.c': {},
+  'test_div.c': {},
+  'test_pcadd.c': {},
+}
+
+if 'qemu-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 82217fcb6ff..30d7f1a7344 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -143,6 +143,7 @@ subdir('arm')
 subdir('hexagon')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


