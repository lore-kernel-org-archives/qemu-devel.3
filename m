Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6785AC98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9Bh-0004D3-Cs; Sat, 17 Jan 2026 11:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9Bf-00049S-G3
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9Bd-0006Jm-OO
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso10056555e9.2
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667404; x=1769272204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wg6Ic+tut9fOwCqqNsv7VAskSr0QtGRBRhw3Vb7WYpA=;
 b=teFj70ewYWY8JOVUhUR/vJS9J+w2FzRISoBwBn+LCb7FIqWL/uYyu2o2nSnBOaAKJn
 ts7rlvk/RWdbbOZtbxWyva7z/n3Iyc3rw3Y8F9elnUaoU1N8C1cJE33cLVyknD5KWoly
 7JgspDA//EeN5VesCqZIo5YhqqxsVHC6htxTBsAlwWQF23m1IH+ef2NFDltWmzQSkpBV
 7WUBNNVIMhlLI+FS4Pr/zMcBZvBSKbijFQsYrdIJsh87LzATmKsPMm5gv2epEGuNP6qZ
 wfOBfUCad6lt1TEA2RBcyOgUj207Az96hJ8hnzrfyiNkIMy+3vwukBadMt0O+6Nk3b0f
 fVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667404; x=1769272204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wg6Ic+tut9fOwCqqNsv7VAskSr0QtGRBRhw3Vb7WYpA=;
 b=Y0WWyL6dEWwSseeqxMgbyYXojv8PApNDY2f0p3/LJguJ1Rnco6oOJnrzesYs6lTQiC
 2fEV/qthEcyvs3DCBybcxmU4rs/0/ckU/MOpZiILdEOTy/FeKgErfujSTS0R0eJ8VmFa
 5qPF7g3v0HN92Ps7eS/bGgXrvZrhUHYiNnjTcgmguWd9eh2X8cUklN8y/QdArpf6QnPO
 SGQPSI3t5U55alFAGmE4h/qQO1GT25aTLJ4Wkxhb3vu1wV8WJR3xGVObBKO5mUqzgKnp
 mRPzjBLLc3lfUyC8IFRDnBMQyiXH73qau5F8uMF8/Icoi8KUpyB13aJRZy5USZ0lX8X4
 I0mQ==
X-Gm-Message-State: AOJu0YzzP46Y17NqchJo7/8P1/hDRnxqLJ+haHv91F/J7PopcpfNr7P6
 EG1Vw7ImwjvXPBGBNRML7fLorBZOxFQT/LHf3OJU3S7sxUl2K+HDv3+lvfNJLqpABOI92NU0oSf
 iuiufHpQ=
X-Gm-Gg: AY/fxX6Ho3DROMqnLeAquuWSohbLn+acC2pQ/7W7oqlBWavY0GQ4N3v/UtmuyPaK9HA
 50IX3wmM/OnQkqaSGarkKWbnwkGcIrmZ0za8UtGy4RWt5yX5vLLQcmFIWO4Ts90nvR8HtVViS/6
 QCqpRVODLPMDqY8Dp4EdYCdA+VNznT8aoRDdXn0KqVRlp20rRKDs/1mEi1skSP9DJ+2JuUckGwi
 TenR/TjEHJ7jssBTzq9l4TZa04CKjKWQDpoEJhL1RZHknwcLk+uWcq9sT2OiBvEUHXVI/7u2nTd
 otyDFacEbrp0rcz+HaCJ097GC9fmRv8T/zfiQSqPgO76W4sDk4FT7WaMvzfMME97X+Z3DRsFZCU
 8FXyQcmxU3/nuURicdxv+x4T6o1bwYkOYlYITt+uSQ8fu4UWdHl5QaDAdPi79JSrg2+0eU6kLhq
 KedalSSD8Ki1t/tOvEpBZte8aRuSs9fzfvLWTrPdM9nFBjRQVJu3ukoJHfLPaRz+WGgzPW5jI=
X-Received: by 2002:a05:600c:350b:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4801eb14fe5mr68133225e9.35.1768667403821; 
 Sat, 17 Jan 2026 08:30:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6e703sm41238005e9.18.2026.01.17.08.30.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:30:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/8] monitor: Have *get_monitor_def() fill an unsigned value
Date: Sat, 17 Jan 2026 17:29:23 +0100
Message-ID: <20260117162926.74225-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117162926.74225-1-philmd@linaro.org>
References: <20260117162926.74225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

target_get_monitor_def() fills an unsigned value.
Have get_monitor_def() fill an unsigned value too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/monitor-internal.h | 2 +-
 monitor/hmp-target.c       | 4 ++--
 monitor/hmp.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae31..8dc88963630 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -181,7 +181,7 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
+int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 3fb4fb12508..ead195f5616 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -63,7 +63,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
  * Set @pval to the value in the register identified by @name.
  * return 0 if OK, -1 if not found
  */
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
+int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 {
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
@@ -100,7 +100,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_long) tmp;
+        *pval = (target_ulong)tmp;
     }
 
     return ret;
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0a5bbf82197..eee8b7e964e 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -376,7 +376,7 @@ static int64_t expr_unary(Monitor *mon)
     case '$':
         {
             char buf[128], *q;
-            int64_t reg = 0;
+            uint64_t reg = 0;
 
             pch++;
             q = buf;
-- 
2.52.0


