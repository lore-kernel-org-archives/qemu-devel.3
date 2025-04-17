Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C34C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Mt0-0008UJ-JJ; Thu, 17 Apr 2025 06:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mst-000891-2u
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:19 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Msq-0003Yt-7j
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so449979b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887254; x=1745492054; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wmWgl0GHsRaxiJyu5Hk62jxV2+HXDxpJgBZBEMvOZO8=;
 b=Dsh5o9sZ+zYV684ovMrynO4TdXNa5wE+VXlIt/uSoiA/fIXDkSTLj84yBDrI+F5Yvf
 ghAUUsyb8am4uwUj+oRxh3DpcBUymbPjWMyNKF10T44r4sHyc81/+GuaYYgEmV6DtrlS
 Wt5L/3E/HbTekpkxvUEVlc7DGUnK1iPnZptgqjP+ehMHdZBLCLP9l38K2PkmiFVzceM8
 sWDban404v9GS5Dj1vxQRSS9X5YBbIGO/vq9OL3ivTogdjWAvOZSvtMX5OiFsWzxWmRx
 /eRRm3fXnkp926PTfIa7qsqmQ7q/v6ImfpNn9/h9hxtXJKgnCnJdhDFvqvyNUtgyeMsX
 501Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887254; x=1745492054;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wmWgl0GHsRaxiJyu5Hk62jxV2+HXDxpJgBZBEMvOZO8=;
 b=iD84h1lnFTPt9QqGzDZ3RNTrS7zuNGCrxnZp71SWo1A1suAPamX6zXh9K3Ybjkfcxt
 fL3XA/nfLhx0okfhAJkUUEiYHFQ6dnKbMEzs6fkeJYkAuVTFTnQi+/XS8oO+sN0cq3vE
 C7R8oDfGsHW1gsUz/zIHfsNm84xKGGxjKhrKEuW80lidZ3lKoBPD01NSZnWwLRFyz7LN
 TYScaR9UgbpyPPuu2fQhnbd4YSRsLB+n8LWpmFUKa5EG9w3C3htRFL3LgjkVi+xfYpjv
 V3OERNmrjTDbXQpPMjGhHmJYdyUjj9w10qYyge40rvLv+0vgy9UcFZ6LQhK+MHv7VzvL
 oTsA==
X-Gm-Message-State: AOJu0YwsI6vZoHZqTtfHwY1EUB5UQhzfNDUeKm/hktSF7aVU5Zqy/nsQ
 LeJAHUEYAc/hKMOnb7m2PPqcxiZ0IpFyQ0ELd9/ItcQi1gwfYhQ7aMr/Vc/4MChHZ2LTz1W9zx2
 F42IPNxMFacPYspwluQhF2uFLbPUeQaFWQXw012QWTxwxO/AqZW0xh7YfgFI77bQKZWDnpXpOpU
 viQ9n+IRcvmQXSTASdPXjuCWUN1RcNyxs0wA==
X-Gm-Gg: ASbGnctU0jI6rRcNg9TqMrasIbqlrzONqzAMEt3Jod8PB6iF3H/eN1Bs/ZK7BZ6/kl+
 fBcp51KwCb/5IvGGrd9l/qmi1uQ2I5LM9JUP3ILDr9qjVjgk2hNdBY//b5LYxWIsJIYQYnuighh
 7ReiMB/DgMgQ03/6PStgCJLWqkJoIy1jMglpbFVE7x9EooddZ5cgqRAytMZNPOU44ICXEl0otVU
 QI1TOEMXc/lX9lr0bPNy1CqlMoxP1RF2ppt1acLxn0NUj72vmczAQNPXwvDpdAYwb1aeqOJcTRy
 JlFS73lfTY7Jw7kvpFPD+bjXqhiO5spYf2jANky/+GkpkDFC2jTCtKbg8ZBB11Q=
X-Google-Smtp-Source: AGHT+IECc63NCIK987B/j/uELTkz7L/JtCbP40ku5xPL7tfpLlmeUFI8Jsywa0uCscADRXmakFVT+Q==
X-Received: by 2002:a05:6a21:99a6:b0:1f5:86ce:126a with SMTP id
 adf61e73a8af0-203b3ff78f4mr8932278637.40.1744887254253; 
 Thu, 17 Apr 2025 03:54:14 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:54:13 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 13/18] hw/misc: riscv_worldguard: Add API to enable WG
 extension of CPU
Date: Thu, 17 Apr 2025 18:52:44 +0800
Message-Id: <20250417105249.18232-14-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x433.google.com
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

riscv_worldguard_apply_cpu() could enable WG CPU extension and set WG
callback to CPUs. It is used by machine code after realizing global WG
device.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/riscv_worldguard.c         | 87 ++++++++++++++++++++++++++++++
 include/hw/misc/riscv_worldguard.h |  1 +
 2 files changed, 88 insertions(+)

diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
index b02bd28d02..1a910f4cf3 100644
--- a/hw/misc/riscv_worldguard.c
+++ b/hw/misc/riscv_worldguard.c
@@ -92,6 +92,93 @@ uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
     }
 }
 
+static void riscv_cpu_wg_reset(CPURISCVState *env)
+{
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t mlwid, slwid, mwiddeleg;
+    uint32_t trustedwid;
+
+    if (!riscv_cpu_cfg(env)->ext_smwg) {
+        return;
+    }
+
+    if (worldguard_config == NULL) {
+        /*
+         * Note: This reset is dummy now and WG CSRs will be reset again
+         * after worldguard_config is realized.
+         */
+        return;
+    }
+
+    trustedwid = worldguard_config->trustedwid;
+    if (trustedwid == NO_TRUSTEDWID) {
+        trustedwid = worldguard_config->nworlds - 1;
+    }
+
+    /* Reset mlwid, slwid, mwiddeleg CSRs */
+    if (worldguard_config->hw_bypass) {
+        /* HW bypass mode */
+        mlwid = trustedwid;
+    } else {
+        mlwid = 0;
+    }
+    slwid = 0;
+    mwiddeleg = 0;
+
+    env->mlwid = mlwid;
+    if (riscv_cpu_cfg(env)->ext_sswg) {
+        env->slwid = slwid;
+        env->mwiddeleg = mwiddeleg;
+    }
+
+    /* Check mwid, mwidlist config */
+    if (worldguard_config != NULL) {
+        uint32_t valid_widlist = MAKE_64BIT_MASK(0, worldguard_config->nworlds);
+
+        /* CPU use default mwid / mwidlist config if not set */
+        if (cpu->cfg.mwidlist == UINT32_MAX) {
+            /* mwidlist contains all WIDs */
+            cpu->cfg.mwidlist = valid_widlist;
+        }
+        if (cpu->cfg.mwid == UINT32_MAX) {
+            cpu->cfg.mwid = trustedwid;
+        }
+
+        /* Check if mwid/mwidlist HW config is valid in NWorld. */
+        g_assert((cpu->cfg.mwidlist & ~valid_widlist) == 0);
+        g_assert(cpu->cfg.mwid < worldguard_config->nworlds);
+    }
+}
+
+/*
+ * riscv_worldguard_apply_cpu - Enable WG extension of CPU
+ *
+ * Note: This API should be used after global WG device is created
+ * (riscv_worldguard_realize()).
+ */
+void riscv_worldguard_apply_cpu(uint32_t hartid)
+{
+    /* WG global config should exist */
+    g_assert(worldguard_config);
+
+    CPUState *cpu = qemu_get_cpu(hartid);
+    RISCVCPU *rcpu = RISCV_CPU(cpu);
+    CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+
+    rcpu->cfg.ext_smwg = true;
+    if (riscv_has_ext(env, RVS) && riscv_has_ext(env, RVU)) {
+        rcpu->cfg.ext_sswg = true;
+    }
+
+    /* Set machine specific WorldGuard callback */
+    env->wg_reset = riscv_cpu_wg_reset;
+    env->wid_to_mem_attrs = wid_to_mem_attrs;
+
+    /* Reset WG CSRs in CPU */
+    env->wg_reset(env);
+}
+
 bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
 {
     uint32_t wid = mem_attrs_to_wid(attrs);
diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
index 8a533a0517..211a72e438 100644
--- a/include/hw/misc/riscv_worldguard.h
+++ b/include/hw/misc/riscv_worldguard.h
@@ -48,6 +48,7 @@ extern struct RISCVWorldGuardState *worldguard_config;
 
 DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
                                      bool hw_bypass, bool tz_compat);
+void riscv_worldguard_apply_cpu(uint32_t hartid);
 
 uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
 bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
-- 
2.17.1


