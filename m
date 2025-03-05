Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F252AC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd0e-00029p-0S; Tue, 04 Mar 2025 19:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0c-00028h-1U
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:14 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0a-0007WO-5a
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390dd362848so4824127f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135990; x=1741740790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=istWwK/PBp4qWDVkDVm5a+mDjkZK9769dQ3JC5v2GBw=;
 b=uApn1ED5G2512UO648I1nJbFSsxYDir0b7FNJUG3qpA6vhZ74PJQTZWN33Fm093Ew2
 SzybHv5swcnyhY9bGWC0iH6A4aiZYTKE2WQvCP55S641s4s46TPDNxHszv2T+2RXHDgr
 04PPKkQActqAp5dEWKSQqnvdNuX8Bjv8o0ottk1IpGz4VHGZyoW8x85hfKDVtW9hhJxu
 S8j2z3UPpfO8aAHsZCBDT99tblEoZf6SZMEKyatLtgxud3OEamqytz/hq3P//TtmyN2j
 RZ3NdbJG8qf6cUbEORlDRZIB6kTxRiBUspUVcUfc/+s6g1i6vE1IyvicMGdWbvc2pdWS
 zLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135990; x=1741740790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=istWwK/PBp4qWDVkDVm5a+mDjkZK9769dQ3JC5v2GBw=;
 b=IZSsrT2BnqvZhkp2i4V5r9y5W0AxOkUAEFBLsknkjy5rYGYyPSSLGFWrrGRVHLOS8u
 qn1WjoYftzfNxFe+PLid0X5jnggktn6fT0xzxEZLHSxppGf5pGbQ0CaD6VZOkwWZQKhZ
 GFYwCdrCaRrzNpOheUPaFm39fSdkEz4bU+UIztLthJHAI4U4m11QUbri75qiohyMq1ec
 vy2UbowJtzDR8cTAXPrdxgj3zKpH9PiMvhlR3rlT7IQ1CUR+C9Wm6uIy3/UFBRpLl1n6
 fH0fHcxcTHtkCHApfMq+KvDywgbYRoNbcpHgdCYyqSLIxhhO1iLjDv9KbsOcZtDiotPE
 0wNg==
X-Gm-Message-State: AOJu0Yxd5NTwHgXD6B8JJ6z85JX5BdB8Ld1vBN2fLwu2yE6jXGx37pmT
 euAFGqH+AbY8FSSQZwvu3c5jiJtPV8X/mQgDpyXSnSRHpWBMyYn8OJjKSKLF6P+bM2JtXAbvIU6
 oais=
X-Gm-Gg: ASbGncvQY3zGzvPZQgp1DmDUdHN8aCYaj2ITnqb1px+By1J6eI3uUc9BdyIBPWD8gBf
 PAODNAW9AYfBrUwyPFT8IVZNWz5IyxW7N1N/SzDk9acTxahUioDg4ZRIqnt8Fud2DEOafe5OvFx
 6m1BBoC0BQ0bpzrm5K1otT6AvCK9ef/9fxKR/0e+VyXtPap2SMNk5YoxJy94olmoKbXhqadnOuG
 EruRVaUU535+trktbsR+ZhLxpmHUCcbdiw/105xi1EhL+8PWXkx051SHBin/Yo/g3lLzxzoMoh1
 qIW46QEiqZ6WVEF55uV+yaArKaH0OLYt1BM9zphXyEGYK7iIexyuu2uZH52R5Ubnh66G9yThVsS
 8GTbX1ip2oUed2JDifX8=
X-Google-Smtp-Source: AGHT+IFLaHEuYqBMxzfMC/y66DHhEBKMByv5Ts2cVU1l+a1jHcsqX4bCf9VpWdTd0iXvNHyrnAtQyw==
X-Received: by 2002:a05:6000:2a8:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-3911f714a20mr510534f8f.2.1741135990272; 
 Tue, 04 Mar 2025 16:53:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c836sm1323485e9.37.2025.03.04.16.53.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:53:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 08/11] tests/qtest: Replace TARGET_NAME -> target_name()
Date: Wed,  5 Mar 2025 01:52:22 +0100
Message-ID: <20250305005225.95051-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to avoid the target-specific TARGET_NAME definition,
replace it by the generic target_name() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/fuzz/fuzz.c         | 5 ++---
 tests/qtest/fuzz/generic_fuzz.c | 4 ++--
 tests/qtest/fuzz/i440fx_fuzz.c  | 5 +++--
 tests/qtest/fuzz/qos_fuzz.c     | 5 +++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index ca248a51a6c..84cef4907f9 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -17,6 +17,7 @@
 
 #include "qemu/cutils.h"
 #include "qemu/datadir.h"
+#include "qemu/arch_info.h"
 #include "system/system.h"
 #include "system/qtest.h"
 #include "system/runstate.h"
@@ -35,8 +36,6 @@ typedef struct FuzzTargetState {
 
 typedef QSLIST_HEAD(, FuzzTargetState) FuzzTargetList;
 
-static const char *fuzz_arch = TARGET_NAME;
-
 static FuzzTargetList *fuzz_target_list;
 static FuzzTarget *fuzz_target;
 static QTestState *fuzz_qts;
@@ -61,7 +60,7 @@ void fuzz_reset(QTestState *s)
 static QTestState *qtest_setup(void)
 {
     qtest_server_set_send_handler(&qtest_client_inproc_recv, &fuzz_qts);
-    return qtest_inproc_init(&fuzz_qts, false, fuzz_arch,
+    return qtest_inproc_init(&fuzz_qts, false, target_name(),
             &qtest_server_inproc_recv);
 }
 
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index d107a496da6..89a9c16ce1f 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -12,10 +12,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/range.h"
+#include "qemu/arch_info.h"
 
 #include <wordexp.h>
 
-#include "hw/core/cpu.h"
 #include "tests/qtest/libqtest.h"
 #include "tests/qtest/libqos/pci-pc.h"
 #include "fuzz.h"
@@ -914,7 +914,7 @@ static size_t generic_fuzz_crossover(const uint8_t *data1, size_t size1, const
 
 static GString *generic_fuzz_cmdline(FuzzTarget *t)
 {
-    GString *cmd_line = g_string_new(TARGET_NAME);
+    GString *cmd_line = g_string_new(target_name());
     if (!getenv("QEMU_FUZZ_ARGS")) {
         usage();
     }
diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index 155fe018f80..7b39a2ad085 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/main-loop.h"
+#include "qemu/arch_info.h"
 #include "tests/qtest/libqtest.h"
 #include "tests/qtest/libqos/pci.h"
 #include "tests/qtest/libqos/pci-pc.h"
@@ -145,11 +146,11 @@ static void i440fx_fuzz_qos(QTestState *s,
     pciconfig_fuzz_qos(s, bus, Data, Size);
 }
 
-static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
+static const char *i440fx_qtest_argv = " -machine accel=qtest"
                                        " -m 0 -display none";
 static GString *i440fx_argv(FuzzTarget *t)
 {
-    return g_string_new(i440fx_qtest_argv);
+    return g_string_append(g_string_new(target_name()), i440fx_qtest_argv);
 }
 
 
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index d3839bf9994..fd93c405f2f 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/arch_info.h"
 #include "qapi/error.h"
 #include "exec/memory.h"
 #include "qemu/main-loop.h"
@@ -83,8 +84,8 @@ static GString *qos_build_main_args(void)
         test_arg = test_node->u.test.before(cmd_line, test_arg);
     }
     /* Prepend the arguments that we need */
-    g_string_prepend(cmd_line,
-            TARGET_NAME " -display none -machine accel=qtest -m 64 ");
+    g_string_prepend(cmd_line, target_name());
+    g_string_prepend(cmd_line, " -display none -machine accel=qtest -m 64 ");
     return cmd_line;
 }
 
-- 
2.47.1


