Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A696FC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXrh-0006T9-26; Fri, 23 Feb 2024 10:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjC-0005es-NZ; Fri, 23 Feb 2024 10:44:46 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjA-0006Nk-Pj; Fri, 23 Feb 2024 10:44:46 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso7381555ad.1; 
 Fri, 23 Feb 2024 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703082; x=1709307882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNu7LbnPyEXqAmNz1J8vUk98CtltlRUnNqB1Qw24DM8=;
 b=DeDONqHDSymA/XFfOc8YHLJ+0uJbYCG3Nadcfu6QTGHOkLOku7wLyz5lDK1iF39K+T
 xp8UE43upovGOuit4KExFDEinOdcAjexGxbIQm2cy/IQ7W1X6V+9QL8xdz2LOsQwljn8
 9OlRmfQZEoz6x+BY2VP3ZqyNqgFIb3/8JJNEeSKTXmIFt4JRezMagIW5P54ydd2Ay8xm
 HRsVf16NP0XHBHsbW/Ti6/UcLaTlSDBbv6FUkTc6VB+o8niMv4FJPiYWMM+8Y7LJEtEw
 Abe+idO1Dso2QmZzOWKP+wY5bb85ajBEuPj/69eNvH7bIdXiEy/qpx8CnE4sMx7qdp5x
 bEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703082; x=1709307882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNu7LbnPyEXqAmNz1J8vUk98CtltlRUnNqB1Qw24DM8=;
 b=JzhQRXMmwjQ6HymYdSh+r4NZlt39gb+hxJGZlVspeEnDi71vVy2i2p4MKTdVO6v0yv
 lGgb0wqv6B8jj8NQU0WGrtr9vhWvUHhQnPjYfV/AOnlLwxBCv0BjnFhohItdBg6vJAZI
 FbpQ+7ebFvi5oFDxXMlvWtILpfZsZE7jl7Sdyk768u/i0gNQx0ZuyB8NmIAoWoCO1/oz
 Rb4wjL5OEgLlHcBk8wrOiT08hX5rH3p1J9klMqt5MV9jxfhtARYEhvaaeGHIAmHbkoRl
 6GRXwRGoMCUxAARg5ksHdkOmLnoK9HZZX9dEYpvPBD6DANDPHwT7TDpS5tasa2LhJosn
 hckw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKRyxzdhAE/I3GgtOtuUIpWRDYeAZCL3UogBMqeHoPFER59vP4qDC1Pim9Ep2SDlFVTCa9qfXqeGFtiuclJOxH9819
X-Gm-Message-State: AOJu0Yy9GIx8jxAMOZiVp0Y9Gpm4ivCf3jFD92Yaae2AqS/ykEoBT9h7
 r3EZoYMD2DGYhjINaaICxalKPLfaBS0cukBC+nJQ3ZZflzHgkp2A0MMW/Rlf
X-Google-Smtp-Source: AGHT+IHw1f8jyhcV7XTIcLCsdweiCWL+3+t5UY38Pi1YwwSfz3cssz0gEjdsLwrPhvuTPEj+9YqLcQ==
X-Received: by 2002:a17:903:1246:b0:1db:f830:c381 with SMTP id
 u6-20020a170903124600b001dbf830c381mr166747plh.44.1708703081956; 
 Fri, 23 Feb 2024 07:44:41 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 23/47] ppc/pnv: New powernv10-rainier machine type
Date: Sat, 24 Feb 2024 01:41:42 +1000
Message-ID: <20240223154211.1001692-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Create a new powernv machine type, powernv10-rainier, that
will contain rainier-specific devices.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b949398689..33b905f854 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2249,7 +2249,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
-static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
@@ -2261,7 +2261,6 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
         { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
     };
 
-    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
@@ -2276,6 +2275,22 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
+static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    pnv_machine_p10_common_class_init(oc, data);
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
+}
+
+static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    pnv_machine_p10_common_class_init(oc, data);
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2381,6 +2396,11 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     }
 
 static const TypeInfo types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
+        .parent        = MACHINE_TYPE_NAME("powernv10"),
+        .class_init    = pnv_machine_p10_rainier_class_init,
+    },
     {
         .name          = MACHINE_TYPE_NAME("powernv10"),
         .parent        = TYPE_PNV_MACHINE,
-- 
2.42.0


