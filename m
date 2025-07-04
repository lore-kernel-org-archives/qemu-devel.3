Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40D8C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRi-00060I-SQ; Fri, 04 Jul 2025 06:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRd-0005xk-2f
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRa-0006CN-5S
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453608ed113so8246975e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624095; x=1752228895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qi/F+aAGU5AG22ZfFCwxT77wB5E9yShca/tWxG6C5Mo=;
 b=NnIxT5ou1DHoujuU5kkKVrVU+WvlhfCUOGmhdKyONG08Uu+mmIIyQJB+QemYgiGJGg
 tzBhPh89sA+RQqjOimd/swa34Cf3kUgrrXUc+8nxswSnS3CIZjDZNhHFH5XLGTHrnuW4
 tJYnyNc3gSKMHLT3loHrwvc4widSlmmW6NCSCYpzt/ATQE6RjvNoy2Vwfu/WmCUvUPbw
 b7UyvMOlGjROHdY2OyTs7EDB0F2s16Hh+uhMW6JgqjKJdAvwAPvo3sO5DVAgStI4RELW
 34eCxZZmiJW2oMwM3l2ez7+xbIpMTuy9EYHDrJjVEzT1UXXGdNojrNd3onW3Y3qtxFYz
 HxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624095; x=1752228895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi/F+aAGU5AG22ZfFCwxT77wB5E9yShca/tWxG6C5Mo=;
 b=paSh1xLyTCj46C1PLHh0wnh8YA83X5x/T7bPkiENjCbtpbQbxNVVy1IW6d6Q2HdOf0
 UUsJ0mCJsXl7wjL/yJv08f3zr/XsHrmcdeKm/cKH/87Wy89t/HQXy+EA0kpqg72hL2Hb
 ty8kohCqV3Hr1y8BCyQFHTbyJ645s9zvkXEjYgWe7Kvk8W40PnHUgTmHr3SiR5zsUG1P
 uKBtrMfoSlI5wRO95bXHgzKeGMxp9IRal8HG/xoTFVcn1LeZ6OryYhKHuam0TQPbIE5I
 x1N5yu2810z15VcXEt2TYhkXcheEwir+LShx0RZxT9Z+7UXBgU1coGUzv8egQC0jbJzC
 U97g==
X-Gm-Message-State: AOJu0YyzR2IgTyOmGlEB+DQaLE1tXdj4bZ0hffqLGGSuuqAu6H58yD05
 iD9Dy0cdOlA5QzrJffym/EcVQX12umidT3LsqGJMQG3i6OZVC0nzQg74PaezwW37jbVNXxircV8
 T1VU+tKw=
X-Gm-Gg: ASbGncukm8urMPvoUfwKQMzP8XdpDx23/ncPnCpBGpykuCxE1/JZuUh4EAXRT5Vozom
 xSgm8BlGsEhFsLCK1y5SQbXAPRALqE4EkmWLR6IkDyaBvnf0eM9UPuL2BFv4/ePIgrUD4/idPay
 MWM+l9Kg8mkW8XnYCNxx/puMJeoAm9f2zOLbT0Mql4FhJyHG+3j+Dd39GsDwAUedolBYzqHUuy/
 vRS4lWqhKz/Daphh5wsyje5objjkhNPllc/ot+oCCFN/TvA4Ge0tW8K7LtUGhSD5yfj3mODfwp2
 Q5+EaI8wYSS/Kmro9l1m8+2s4lYvyKExgaq0PBU2Mpjy4yZwnU5GmQwl6Jgu58n0Ti0Hq+jZjA4
 GmyI13/HyQ5c4wyUmjyU+WAexKlSmNq2/dO0x
X-Google-Smtp-Source: AGHT+IGeJvXwa1E87X3fBLWH1XWeO+jo/c5pKJzo//sW5SkaGqSgGfcoQxiLacD5YtRK/cNrI0+Zbw==
X-Received: by 2002:a05:600c:3493:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-454b306a122mr20465715e9.2.1751624094842; 
 Fri, 04 Jul 2025 03:14:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bced0esm51337475e9.22.2025.07.04.03.14.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:14:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/31] accel/tcg: Remove 'info opcount' and @x-query-opcount
Date: Fri,  4 Jul 2025 12:14:05 +0200
Message-ID: <20250704101433.8813-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since commit 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER",
released with QEMU v8.1.0) we get pointless output:

  (qemu) info opcount
  [TCG profiler not compiled]

Remove that unstable and unuseful command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-8-philmd@linaro.org>
---
 qapi/machine.json          | 18 ------------------
 accel/tcg/monitor.c        | 21 ---------------------
 tests/qtest/qmp-cmd-test.c |  1 -
 hmp-commands-info.hx       | 14 --------------
 4 files changed, 54 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0650b8de71a..f712e7da6d6 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1761,24 +1761,6 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
-##
-# @x-query-opcount:
-#
-# Query TCG opcode counters
-#
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
-# Returns: TCG opcode counters
-#
-# Since: 6.2
-##
-{ 'command': 'x-query-opcount',
-  'returns': 'HumanReadableText',
-  'if': 'CONFIG_TCG',
-  'features': [ 'unstable' ] }
-
 ##
 # @x-query-ramblock:
 #
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 1c182b6bfb5..7c686226b21 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -215,30 +215,9 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
-static void tcg_dump_op_count(GString *buf)
-{
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
-}
-
-HumanReadableText *qmp_x_query_opcount(Error **errp)
-{
-    g_autoptr(GString) buf = g_string_new("");
-
-    if (!tcg_enabled()) {
-        error_setg(errp,
-                   "Opcode count information is only available with accel=tcg");
-        return NULL;
-    }
-
-    tcg_dump_op_count(buf);
-
-    return human_readable_text_from_str(buf);
-}
-
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
-    monitor_register_hmp_info_hrt("opcount", qmp_x_query_opcount);
 }
 
 type_init(hmp_tcg_register);
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 040d042810b..cf718761861 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -51,7 +51,6 @@ static int query_error_class(const char *cmd)
         { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
         /* Only valid with accel=tcg */
         { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
-        { "x-query-opcount", ERROR_CLASS_GENERIC_ERROR },
         { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
         { NULL, -1 }
     };
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 639a450ee51..d7979222752 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -256,20 +256,6 @@ SRST
     Show dynamic compiler info.
 ERST
 
-#if defined(CONFIG_TCG)
-    {
-        .name       = "opcount",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show dynamic compiler opcode counters",
-    },
-#endif
-
-SRST
-  ``info opcount``
-    Show dynamic compiler opcode counters
-ERST
-
     {
         .name       = "sync-profile",
         .args_type  = "mean:-m,no_coalesce:-n,max:i?",
-- 
2.49.0


