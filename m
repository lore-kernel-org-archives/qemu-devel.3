Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AE5C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObI-0000vx-0R; Fri, 09 Feb 2024 05:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObG-0000ts-QK
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:18 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObF-0000G7-BX
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:18 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3be6ff4f660so398429b6e.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476355; x=1708081155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJswhLBF6om99L91XcgSKdyVxdEvKbkUau47VRG7lWU=;
 b=Qu2hOaDHq4mK+57ywkoZaLbY+H3hvvs44cRSr0msMbg3U3W+KWJbaLs2dHwWtBh6C8
 pBErb+Ed2MuuUp5pyluZgerTY8S0v0vToN4jna+ijSiCEFXoiMtO/CR+4pZW8oM9lQ4/
 SYFSxC0OmhnMzcCHaXZgLeg5U/BTFJjsQz0bD5BP3oVgx0ZRg27jgGFzCS9qlwWJklAa
 lIc48bhjzha2CmfzoJPujVZWNbu2EcgfIc/Ywb/eEOpAn4N/3u4aLO/eSufJ2SeA/Ci6
 /QpgsWT77dt91bHpztDyt0YlUPYbM+Ie/WLFbB9p7C5TBQp7KXJ3xw0AAa4rPorIO1sh
 Ej3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476355; x=1708081155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJswhLBF6om99L91XcgSKdyVxdEvKbkUau47VRG7lWU=;
 b=UJ7OVMuDe0xJPMu7AuGsqBE0OGyNTycnWqi/4UtsFvZRHuL7bO+1Uf5kAGz7l7foey
 Qu0GFzAfJXxWDa51jS4uXxNOHEZQuph+KFxzwTO9xhDKfrO3ABr7qu0q3aabmDJLuwcO
 e8SpG/ejIs99kbb55eYGRmVHEL6zLMXZ5YiEWP9xd7GiamibydAxSXKv2dI2WGmz+noB
 RHJZR7XmE1wQx4fLidIAg8t4p3xtt0sb4Awgsc7SoVy3U1p4RT3cMIlcMRHxMxxl9/Ms
 8DGOGxScrDDZJka4VPfJbfWjYWOWfxE2Z89ORuKrpv1D/Fi83py0WOV55fjPabV33KtP
 U1UA==
X-Gm-Message-State: AOJu0YweHU4w2hTD6oH5uhUBYuGE/ImJBPM0HrNnVMRodt/2yFgalSM7
 /RZEjWiwOG0jU/cRTgiigdB01VvdmRAVGyOq6qYQ0JOsXG8nxPXQKLMBVKyvkWK/tw==
X-Google-Smtp-Source: AGHT+IGwsCKay+Xcr7Q/QAZKFoH7UthP6ccIuSNZUCjoH7l63RTOi33Kz99xC6kwRciknzLroUppgw==
X-Received: by 2002:a05:6359:45a5:b0:178:b9a0:fe9f with SMTP id
 no37-20020a05635945a500b00178b9a0fe9fmr1246147rwb.19.1707476355006; 
 Fri, 09 Feb 2024 02:59:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUZEzvlO0CLYOFZdaL0KIxxIUshTUc+6zLHhnx6wnuMZFQT2Kj6x//+3UK6OB46lAc1C8i+TOCRatn+4hBfLzXalM9Mc3vwVYGue36D0Ca8bARffhCKrWhKeIsWhKsoSgqQajv0ZCromhYNozV84nRk0Uno2fCE3HxoquQIt9I045Q=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 15/61] target/riscv: move 'cbop_blocksize' to
 riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:27 +1000
Message-ID: <20240209105813.3590056-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Do the same we did with 'cbom_blocksize' in the previous patch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
tested-by tags added, rebased with Alistair's riscv-to-apply.next.
Message-ID: <20240112140201.127083-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3b3098ee76..1828366d93 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1327,6 +1327,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.vlen = 128;
     cpu->cfg.elen = 64;
     cpu->cfg.cbom_blocksize = 64;
+    cpu->cfg.cbop_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1913,8 +1914,42 @@ static const PropertyInfo prop_cbom_blksize = {
     .set = prop_cbom_blksize_set,
 };
 
+static void prop_cbop_blksize_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value != cpu->cfg.cbop_blocksize && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.cbop_blocksize);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.cbop_blocksize = value;
+}
+
+static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.cbop_blocksize;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_cbop_blksize = {
+    .name = "cbop_blocksize",
+    .get = prop_cbop_blksize_get,
+    .set = prop_cbop_blksize_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
@@ -2003,6 +2038,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "elen", .info = &prop_elen},
 
     {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
+    {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
-- 
2.43.0


