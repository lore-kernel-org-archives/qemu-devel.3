Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9CCC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFEZ-00013d-JJ; Tue, 21 Jan 2025 09:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCc-000309-5f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:26:02 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCZ-0003kk-EW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:26:01 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862a921123so4055430f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469558; x=1738074358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8HZuuYQMEsWgExTk6OZpUbl9UQpyo61BMv/xXe3yCU=;
 b=BfQu0p4DVC4KY7tbxL8KGrsDq5jbC+kD+4AMX7qFMcOod9Vpfq+Lh/YMDw+zWR9xau
 2/pwlGSKAgDxX0HLbjJL05Mr/DVienYWSazErsOLDiyDg+ASNw8RAk6sYGK6XmkPTHYk
 TWJ3ElDDjwFNDCFC4YTweyMhmH9qKTtKIXEbss5JlSfconBbIJBmP8y17c8aFWeDIaAy
 pkRzyA3seBFqNPpJl/WDVoZ+rZYEN2qeUlk8E1MO4LQb7PJ4gf1wmE0UKQqr5k3r0O4b
 kIq3VcZ5nLwncZ+DYhWBUjNoB09HsFv73WKXGO/d+GetRh/qcDfwtQu/PUzQyFJdYLFa
 wdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469558; x=1738074358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8HZuuYQMEsWgExTk6OZpUbl9UQpyo61BMv/xXe3yCU=;
 b=iaokzRLrHzk0BUf4IFHr5/XDZgABhmobJR55/Cv8L8GOQQqFcptRZS8YRklBdc1HAx
 kGF7xw+etF4uEvUF7etrlVu0fdTUGCTPPKEBxYkBdAJj8f82HevRLkTzBJtdQtnzvvGI
 iPGIdFll6v8c2Ce1DwtVNxu+QomQKoNh4f33UIKOXl6cTqoS5zD+bDmupJ4SmSVwZDQZ
 TH6blf7W+cDxuegke1gTq/WGXb8wHp2XGN3Pn1YX8X71nc1x4spcRIiki3pdFZNhy3n8
 3rE5PccIbHayTQK9ONr2dKGBiTe39rUwzfb+FeN3icnOIvFieX11U6Adjs61BpW2MsnK
 iQqQ==
X-Gm-Message-State: AOJu0Yyg+4hMw+Cz6GyBh7EWPqyrBWXGCR9pltNw+8tddeW1dcWlIBUE
 16Qdp1zzjkHZHARz1p1ZiROOsemDAaM49gpQ21RI0RraNr2oeRJfeHyZzXc4WEIyseRPcz1CpMa
 m0CI=
X-Gm-Gg: ASbGncvsDz0DTD0R4bvjQClZGGreYK9gOHm4XN+bkboD1ByT76Te5kDL6361HRZ7d98
 XDo2bYVZFqvatPHVw8F3etk2XkSDy4UTTZquMumbdf1svq7wWgE2XME0asWvyCVMl9yUWcZpGta
 bKjTxSwDxUq1OdIENQzoyYMlslhTGdCVtVh9OaCMgbvSd0REJDV5Q9YDA1YxmkKg9gwwEgCrCNT
 CFUh5T5ZU2b8XYm28I9wuZpQxgMCDbY/rNBfJpVe14WLffJXc8Ibyh24Kl3gXtYyDRW2mm4lFvk
 f2S6sRoCoI7TzwJFHgUE+bO2frYuYWmWwMRt/49X8jZQ
X-Google-Smtp-Source: AGHT+IGXBMPZV3pKxE3kbnvFv67XaZmF+3jLiMcRDIvwoyctOcpXqWVJtM2TBXtUgdoIVmH5D1Ndww==
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38bf56555f4mr14225672f8f.5.1737469557655; 
 Tue, 21 Jan 2025 06:25:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322aab8sm13695067f8f.57.2025.01.21.06.25.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 28/28] cpus: Remove CPUClass::has_work() handler
Date: Tue, 21 Jan 2025 15:23:41 +0100
Message-ID: <20250121142341.17001-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All handlers have been converted to SysemuCPUOps::has_work().
Remove CPUClass::has_work along with cpu_common_has_work() and
simplify cpu_has_work(), asserting SysemuCPUOps::has_work is
always registered.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 --
 hw/core/cpu-common.c  | 6 ------
 hw/core/cpu-system.c  | 8 ++------
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d64c823e768..2bcad4b16bf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,7 +104,6 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @has_work: Callback for checking if there is work to do.
  * @mmu_index: Callback for choosing softmmu mmu index;
  *       may be used internally by memory_rw_debug without TCG.
  * @memory_rw_debug: Callback for GDB memory access.
@@ -151,7 +150,6 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    bool (*has_work)(CPUState *cpu);
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 886aa793c04..c933de1416c 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -134,11 +134,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu_exec_reset_hold(cpu);
 }
 
-static bool cpu_common_has_work(CPUState *cs)
-{
-    return false;
-}
-
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
     ObjectClass *oc;
@@ -304,7 +299,6 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
 
     k->parse_features = cpu_common_parse_features;
     k->get_arch_id = cpu_common_get_arch_id;
-    k->has_work = cpu_common_has_work;
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 7b16bda2250..7f287984aa6 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,12 +25,8 @@
 
 bool cpu_has_work(CPUState *cpu)
 {
-    if (cpu->cc->sysemu_ops->has_work) {
-        return cpu->cc->sysemu_ops->has_work(cpu);
-    }
-
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
+    g_assert(cpu->cc->sysemu_ops->has_work);
+    return cpu->cc->sysemu_ops->has_work(cpu);
 }
 
 bool cpu_paging_enabled(const CPUState *cpu)
-- 
2.47.1


