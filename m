Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1D1C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwe-00050V-I9; Thu, 27 Jun 2024 06:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwb-0004ze-3h
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:34 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwX-0001cs-CH
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:32 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so7005869a34.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482486; x=1720087286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+eeNlFB8GixGjITkNWps0WtpsIa1zNDxCGuytiuKIQ=;
 b=SHVsJgK3DcmSAKs6Tcc+sUEiYbSnMdx6IIdW3qtIlDUt+v/QCQjLie4EW/hry4jlWo
 a0/VA2c7RtpHsSsd67XFLanKHfjTcrLBjThF0Dzp0/jvAhS/o98D4R+mRJ3o2oWUIB/m
 ViMkdFULeV0UR6xRCgGs+cjPyVCUxrvosQGlFhukVO5pXZMaH+U+w/UZ+ry4iiKNEjoG
 DT7uO6rcFjh1fETFYJRELpr0Bd9/l5HxxaoKUkMSKuctMhJQ8ur5nqb0J/RoIoN/PUrz
 BaGqz9MAy6Bi05rC0LPZXns+Rzo22BO3yBzIntOgPr9W25r+fcviU3OvTKhM0mgJ1pxE
 Ri/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482486; x=1720087286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+eeNlFB8GixGjITkNWps0WtpsIa1zNDxCGuytiuKIQ=;
 b=necpxBhmowDSJ8Vxyjhsp4I2KwPwrGit+h1huy/5I3/mQqExEwUa8ktz0FgC6hiVaP
 y/UgSC8PYGRswWQgT6Do6y5qKAVC+lbtVgfq5bSdPGgazNOYGZ5vC1nD05GGieQZsSK+
 VShCtYREFZItk+Ii6HDoHqJvTNQA5S6EC/TlM1B+HNzC0koAci1W/u4diUB+UfeONIZJ
 hvCpEFE5ufuRkdmU5FM8/WiIapqf61djzvcSdKUlykkTM7SF/LP6NZ+4aiuKxlQoJgFt
 JHACEO0O9wa2RBVwEfssTE2AEZACR0aRQ8HK7/z1BzM1Bg98xqIcDhS8T6bR+pZ9Mwmc
 Uq5w==
X-Gm-Message-State: AOJu0YxRMePJzNIeqQj3JBbHansAffMFPZZKh1HVMEjuuO+5zoG7eLrR
 kgQN19mnQv/9+iZp9fi/ibzaJ4643K4h6c9FPOQ420RrtuYVn4SsfMEpaVLj
X-Google-Smtp-Source: AGHT+IFQnutwQGVZAxVvlm79DohdPZj6MHxRC9K9rwOoZofaWpmovVStQXhnQRuGJaj35md+aEREMQ==
X-Received: by 2002:a05:6870:1491:b0:254:b7d9:2dd0 with SMTP id
 586e51a60fabf-25cfcfa10f2mr14767976fac.55.1719482486276; 
 Thu, 27 Jun 2024 03:01:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/32] hw/riscv/virt.c: aplic DT: add 'qemu,
 aplic' to 'compatible'
Date: Thu, 27 Jun 2024 20:00:28 +1000
Message-ID: <20240627100053.150937-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The DT docs for riscv,aplic [1] predicts a 'qemu,aplic' enum in the
'compatible' property.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240531202759.911601-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a803c33e21..746df3f294 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -606,6 +606,9 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
     g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
     MachineState *ms = MACHINE(s);
+    static const char * const aplic_compat[2] = {
+        "qemu,aplic", "riscv,aplic"
+    };
 
     for (cpu = 0; cpu < num_harts; cpu++) {
         aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
@@ -613,7 +616,9 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     }
 
     qemu_fdt_add_subnode(ms->fdt, aplic_name);
-    qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
+    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
+                                  (char **)&aplic_compat,
+                                  ARRAY_SIZE(aplic_compat));
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
                           FDT_APLIC_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name,
-- 
2.45.2


