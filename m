Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCB1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6D-0006mD-Mh; Fri, 10 Jul 2026 17:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ66-0005ee-1B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ63-00052m-Vm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCkYC1931536
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qk/jcZ6m7Re
 k2AIwVpaYOYJh2juXscPkfi+XMTCG4OE=; b=bKYzVPp2EBE5mO9RMwigNsw7MK9
 sps5VzTTXs+njcFrwgt8+lNO7bCg4c1GxnYoQo0o1yfQi69r/BfJa5ocP+JMESpU
 ygK7KRwzJ73HocX0VPWpN36/BAei814Yg+eLT42ymovm/7haeUculQTFyOgC+Toz
 mzpAZYsxC/3r4lY8tsNFJ04I+g6CK6O/cyiugdBMol7pvftbdHQ5PCbCmZaXnNpV
 S+zR3RRgkX1gYecNGUe037b5+3TH5/QXiOkU+MgZrbFnHOVgNpASrr04YzW5WT0M
 iTuBfgieF9BPxFfdXFGNUTXYEhZU/URDsIFPsLa0SsPLrtIdloA6Rlo6LEw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r32x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381250979d5so1595654a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720151; x=1784324951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qk/jcZ6m7Rek2AIwVpaYOYJh2juXscPkfi+XMTCG4OE=;
 b=EinWP3tMsaouFCa3xwW464QKgCI0lXnLldhRE9nUjUV/gJBo/iUxWYgiUjGb6yzpyJ
 5lnXPA4P/yh6Ah9cQaIcicOezdMczJhxzacW5lFIWJqqamYnkcePYWagrovkP8xupm8O
 qzer919DvHrzmiRYdPD5DyohBGACy3VgbREzzkVE50MU7UUZCLRq5uzGqCA+5ZVqiLTp
 /EPO45f5GVREt0vrEGDU2WH0vSBBHfQml87pig0pqaKVbhDaKq1MbQ/hx4UIwYsJ8vvP
 AyD4kEO4eir158IEmhORCmwcEC9ZDzuYYsD2kdX02fYA/NQ3We1d8T++AYpP0x0lww0h
 9wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720151; x=1784324951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qk/jcZ6m7Rek2AIwVpaYOYJh2juXscPkfi+XMTCG4OE=;
 b=RC/pcHGmyjGakvCpedUPQuHiLFV8Y974FevOx49lGunUfiVfbL9sUiojERnfelGGdF
 EWAqat0bthtd5BYPlcuhJfnIpHW1ZFZJPOMo8r7Yxud/vOO5nyaTs/fprsJbC8IMXU0h
 X53QOI0G9ZuBbLAGoTZXoz7EwX73TMPRTB2TYy66X7FGR6aAEv+A5fXFW1u/zZ4r0Jv1
 q/FVFGMREO3rGd7Szdoy6LcRtB/nMMMsrQJMProtsYRrIb8pN+kGvWE8ypwtpG3ZqlUM
 HtFLUG3q6NKdWAVuLQzWNmTvPy6dhRS1+5YimSvnbw1wXLPo2POjEdqLGbTzDl047HTh
 ErYA==
X-Gm-Message-State: AOJu0Ywp75BRN5l0j5u9DWFVQsG1pK/LHFQzCpayupuaRB6GDpL5cybL
 +cSj7BE+AaiJvQqL3Fgn/w2gHP1EOmpuZC5YvFH9FV6E8mFyUSKVZsztii7eXyLFhn+bMteuSAL
 ccgt9QoojrZxK7XyqOfiVSA559AQQSqkqBqyv/pofCgWg0pBeiq49xPQ2znchbagorQ==
X-Gm-Gg: AfdE7clVhP4f9b3aI495UVcfwfKK2qJXWnmqdIya5F/EtCukBKfpGM1IWaiWu6WPNe1
 4dMxWT7MyejU1XvJvJ9Lp7k2FG+D1RRb40+w7jSi1GC9RlJQGXICVUnaisN66MyYuyoZrdA8v9Y
 vsOyKHolFIN3Ivpcrmp7bnkpzVcNbd8pIy7GgFWAKfwKv+GD4dH67x7iznreoWJHQD6A3LmHqie
 mo7UdO3gi5xSi/abK06oXNr6nS+ogyDAT4dzAkrCr8IX3QNZXFfGzEuLcdkpcwBmyBdpLPq8c23
 5M4Ok+sZKLRW0THLQ0JMN4FwEuoxnVEdGdC5sDnQnBG8IdAO3ih8RmJGWFjKt9e9OW2zhll7u9V
 kMTC64VDLFPt+m4FOjJ6U9uFFoD6UpuYsz09Apv7eCwJmhM/eOvpHLQ4gXBZ2hJ4acYl/Ou6zXG
 1JuEARDw==
X-Received: by 2002:a17:90b:3c85:b0:387:e0db:bc2c with SMTP id
 98e67ed59e1d1-38dc7ba2ab1mr691388a91.34.1783720150913; 
 Fri, 10 Jul 2026 14:49:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3c85:b0:387:e0db:bc2c with SMTP id
 98e67ed59e1d1-38dc7ba2ab1mr691373a91.34.1783720150476; 
 Fri, 10 Jul 2026 14:49:10 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:09 -0700 (PDT)
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
Subject: [PATCH v5 65/98] tests/tcg/mips64el: user tests
Date: Fri, 10 Jul 2026 14:43:09 -0700
Message-ID: <20260710214343.2065491-66-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5168d7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=MTytrtsdTjBmL2pvzDgA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: IUsSnf4cNnCHelnOfSkwSOyCJbmntJOu
X-Proofpoint-ORIG-GUID: IUsSnf4cNnCHelnOfSkwSOyCJbmntJOu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX9YgRvC+qKTBx
 bs/D95aZ0XAi5fAWWMyjlWz4Qe750P6XRlqHUKo3arhRJ2wCGXjM0iG6BPhqPWz0DF9cRWMTiMz
 fPCfsbjS/ZKkKNOiy2ka+WTTkmDz/rg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX4+9VjqAGFHT2
 7iT69KWTdBhPBE5gCpyRWSBbhLwsOU0lXJdGFf9mLZG+WpeRhvQXEgr4Pq2S45jMgUWFjZYS9nR
 2dJ67cmljb6xkianUm+rQ3ggdmRjJQ/qOet9MzQEs8EYecYDPsbQtyjn3bIah2M0+YU8pwYjdYv
 S5rkgh04y2F/E+rFb14dZVIWIR/vCY+DfCICdv+MUvxzoIRdrlETbxpaVg9CPq2oWyfEEvRSrlx
 ZmW61RC65xbFNNvVnDJIXGb4cbqbD0VKTnhZwPy18mZcQWN30mObXWKikXuYryyxog50tlxHFhC
 ZCWIxhchliFk6lkaRiP7KAOPvFD69cshsNiBCsBSKKwomF3FX11Dc8hwDmxG3HtGTxYS6i4MEf+
 wdt3dHgOjCg0e7okHdW6U5OPqolzEMkKOUAqaTCcytXHViBHaX3jTSNWqNk9ZKBOI6mEQJ1iHwi
 3TdlVpdhabWzeLKKEOQ==
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
 tests/tcg/meson.build              |  1 +
 tests/tcg/mips64el/Makefile.target |  8 --------
 tests/tcg/mips64el/meson.build     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)
 delete mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mips64el/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ab367896bf2..598b32ea1b4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -144,6 +144,7 @@ subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
 subdir('mips64')
+subdir('mips64el')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
deleted file mode 100644
index 78c722a583d..00000000000
--- a/tests/tcg/mips64el/Makefile.target
+++ /dev/null
@@ -1,8 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 little-endian - included from tests/tcg/Makefile.target
-#
-
-#include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
new file mode 100644
index 00000000000..f6c0fae7981
--- /dev/null
+++ b/tests/tcg/mips64el/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-mips64el' in emulators
+  tcg_tests += {
+    'mips64el-linux-user': {
+      'cc': 'mips64el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
-- 
2.47.3


