Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA6606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gl+HBH2s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoM3-0004cv-I1; Fri, 30 Oct 2026 11:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoL8-0004LW-U5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:27 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoL6-0008QY-Ux
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:22 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-15943c9c005so1423772c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373379; x=1793978179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eLhsKCTjuKy4eSFshqKS/+IjBjdCXZJ8by/9qMkJXhQ=;
 b=gl+HBH2siUVKdvYiToIcKAQmmENtMLFwZ5fXwHVnJpc0hnA8bdoRRWUgoXoqNXheUV
 hDPjFmW5pveEwPJXC1GvdUKhU4ez79agEtf2DTeYj3hYvc57Vp+9OX/jgwRZ6UtOhmMn
 uFpJzsCN56sOQkU7lsWmAS5U0UXUzfQ+LYtmS3tttHqmziovpXQOQTybvV1wUNmEgp1H
 z6knlRskge2qpLwfGbtoO/nxoQ8Pa+h/g3c5PW2ZUZerp4scB0duYN1aU0kjaz0XfaVj
 YXJU6rKeEnvrgNg+ZYOFe+Q6cVlwX0pdRUaYeuCJ4j/EnU8m+A7AqldVEaqfyWKuLojB
 dIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373379; x=1793978179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eLhsKCTjuKy4eSFshqKS/+IjBjdCXZJ8by/9qMkJXhQ=;
 b=kAEwfeYRZmpiYRCKJgQL8DkrnfEeHBqby7ailLyUDd5CrYT+tJHbNrB3wICedeKx7K
 6w5B2AInNF6KATEk4rPU7V7N3pPf/ZeMvHTY/J22CEOZJ0Yp8BwqtP4seAYOgw4NMAq/
 gI02FcM2+Kc/10WIVBlGsZzVpA5AWPtJHgn2ZTHnih449OQIkrCnH75lSigOad4sxFaY
 8d5yZLFXm5Rxl8+GI98rmuHtY+Kfk6NMvNWhIaJ0DknhhYqT5G+o9CTnnz9R9EsrKqkO
 Zc4K+RUJUhtBjt296UDTQxyASo5tRjGxdRt1KNrhHio7l3k2ALm0IxZ95iGUqEvLf5ix
 9PuQ==
X-Gm-Message-State: AFq9FYIqeE8VLRbv55Bf1k5YKRRs24kX6tEMgHt412WvOJAfh74lW6eo
 x5DHdHzS2yedKjA3w18uWPHR6BTgLcO5n5om3ZKz2vm8FZgrsvy9XuBxQ5tpbO8yKrY=
X-Gm-Gg: AYBFou1n3+nNrOFMjcMA9nKECu1nYDSb5UpQaiuCViWv4T6eyuExyIimu3PMNTUcnyH
 RcSieuzd8AdIxNadfM+6KUXAxxp9qiJgCO9y+GK/NQRgJMR/KiH517hYLH1FV6PAUjY0JlgBs+H
 4rTql2nGC8tV06Q2UwnLXnNMRy3FTUGzjeV23D/4kES6T5tUia1lJhYKoRJmptgtKcYkplvMLXi
 djydWZWvhEht7f3KKx/4F7/uFhJErKSUO9t3VtuXezQikRk/uTwsY3nbizIMApaLNM0bUf+iS74
 HFCjStr4aAnAauG3WhKn/A7pU5cR+OghfvZl8DK4qr5XgKVd0rhVfmueWTgOSuKgUUhpIEES8Vu
 w6bzo1/KYjfbPFSyXxLA8Bw8+jQlzUouUrzlU1BE1JfEfLIckdsE5J/3urMHL1cu+FX9b1aOIDi
 UF5d+COXWJ1Pts3KKdYmlfUqZCxqS65a9W+26AdB23iZWYFiI50dhXwTSeXjMxgfAxkk+zDj6DX
 e8duWby3VzyTwtKH4GMDOAgEYz9SgbdjOqJeVZFkfSzXj6h5Ok5Y0RCStWANl+1WTKlXoaXteiv
 IZyK1ePdFTwvwA5FrqkGo6mWDsPlHznpk6Ej+NkPUQBThFCgDPjmsisCs/AMo5H6dTTvkQ==
X-Received: by 2002:a05:7022:e27:b0:14d:cb67:afc4 with SMTP id
 a92af1059eb24-1ac5e8e1e4bmr4866883c88.41.1793373379151; 
 Fri, 30 Oct 2026 08:16:19 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:16:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH 02/15] hw/m68k: expand DEFINE_MACHINE for M68K machines
Date: Fri, 30 Oct 2026 23:15:23 +0800
Message-ID: <20261030151539.1872-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expand DEFINE_MACHINE() in hw/m68k/an5206.c and hw/m68k/mcf5208.c to
explicit TypeInfo and type_init() functions calling
type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/m68k/an5206.c  | 18 ++++++++++++++++--
 hw/m68k/mcf5208.c | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 1acd2fbdfb3..8838563cb3e 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -93,12 +93,26 @@ static void an5206_init(MachineState *machine)
     env->pc = entry;
 }
 
-static void an5206_machine_init(MachineClass *mc)
+static void an5206_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Arnewsh 5206";
     mc->init = an5206_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
     mc->default_ram_id = "an5206.ram";
 }
 
-DEFINE_MACHINE("an5206", an5206_machine_init)
+static const TypeInfo an5206_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("an5206"),
+    .parent     = TYPE_MACHINE,
+    .class_init = an5206_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void an5206_machine_register_types(void)
+{
+    type_register_static(&an5206_machine_typeinfo);
+}
+
+type_init(an5206_machine_register_types)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index a8068c91f24..5c3ab48ddde 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -389,8 +389,10 @@ static void mcf5208evb_init(MachineState *machine)
     env->pc = entry;
 }
 
-static void mcf5208evb_machine_init(MachineClass *mc)
+static void mcf5208evb_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "MCF5208EVB";
     mc->init = mcf5208evb_init;
     mc->is_default = true;
@@ -398,4 +400,16 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->default_ram_id = "mcf5208.ram";
 }
 
-DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
+static const TypeInfo mcf5208evb_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("mcf5208evb"),
+    .parent     = TYPE_MACHINE,
+    .class_init = mcf5208evb_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void mcf5208evb_machine_register_types(void)
+{
+    type_register_static(&mcf5208evb_machine_typeinfo);
+}
+
+type_init(mcf5208evb_machine_register_types)
-- 
2.55.0.windows.3


