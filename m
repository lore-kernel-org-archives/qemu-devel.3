Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AD9C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPyt-000858-Jg; Wed, 27 Mar 2024 05:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyL-0007Ox-0C
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:30 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyJ-00074M-4k
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:28 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso827941366b.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533205; x=1712138005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hg7aD3ta6JZQmhzmuZhz9rmDwJrsQ0H6Vo+PaPMmwrY=;
 b=k2YxGUUPm0A/UcZZFdBggG71jYRaR7E5Xzd+205iWxV5qr7Y0Z1nFB0cPuSJVcf6um
 BRN1c+xmYIB2/t9VfAjL51dfnHIUaUfi2M08QmwQlRSpPJdv/LrIfe5S3FM5/bb8zVr5
 3jQX+hzHocWXBFwlo6Eb3wGs5ylmt+vAlO+AhP07oFMn/iUo9b8Iqv4TwBW5yQ/OPFPh
 JDeeblsoPTVYvTxgaeN/o2dC28Q4qenGkOFrrvy2E5M4nXdrRybkd7dfFuFWUa+vfZGw
 WNqDmtPq9t1c8N+5gZyQdapJJCEE6z4+eDEa4IbTmTcIw7meuzWy39+rbjTXNdX4Vap1
 eGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533205; x=1712138005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hg7aD3ta6JZQmhzmuZhz9rmDwJrsQ0H6Vo+PaPMmwrY=;
 b=gc2sdAUk+43JHJK0FoQPxJTQ5x6MBogk0/piw7okBESSI541Dwr5yl7FoLF159Mv6q
 Guc4wKOjRxw2aQbYUlRvl+bc+txEpC1d5Ydbk2kiNfelnh2wVR3glWTT4G2VskTKuf5g
 GI4rnhoRpoiEhuDH1INZpHcwJ4q8u6oFuFgKEfsH8bW+hGGSzABjfeF8UKYCogBloVKG
 aARJdf7ShbhWyKiHii5L5MKN8rtOf5eAprgGlBgG8YFYa+EIklbtcqh8cLREUO9evR4A
 14GQADJ4OPgctOK7CgEf1tpeH1wIJtrlz7/k4hfbIRoDpEQYsmf4ACAnedLo6XnUYlOK
 eslQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIrfILXsBTBADGdvrWch5oA9N+/ceYHWF0GSUKbDxyqpgf//LLjLtrgZGvVZp3RTecR8bndZ1eXSvXOpvW8wFGXVBLaAE=
X-Gm-Message-State: AOJu0YzvtTuNwpg1NTJdnXtS01kmD9C5QdeMLhkqv6pMTrz3uKe0yGah
 z6uIzi4Jki3jBpvZzf2lTFq6xM6IMOpOCdZXfKbOqVUYoCkkIPAiN02spBu/lm8=
X-Google-Smtp-Source: AGHT+IGbSnZ0JHvbwnkSi0T0biHf2h7xI89d1QRDs26/VD6t5G/kTeDSSlPcQCX1U0OT3miOcthUxw==
X-Received: by 2002:a17:906:f809:b0:a47:1f87:206e with SMTP id
 kh9-20020a170906f80900b00a471f87206emr479336ejb.53.1711533205520; 
 Wed, 27 Mar 2024 02:53:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a1709060e4200b00a4674ad8ab9sm5162406eji.211.2024.03.27.02.53.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:53:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.1 v2 19/21] hw/i386/pc: Remove 2.3 and deprecate 2.4 to
 2.7 pc-i440fx machines
Date: Wed, 27 Mar 2024 10:51:21 +0100
Message-ID: <20240327095124.73639-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

The pc-i440fx-2.3 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it. Similarly to the cited commit,
deprecate the 2.4 to 2.7 machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  6 +++---
 docs/about/removed-features.rst |  2 +-
 hw/i386/pc.c                    | 25 -------------------------
 hw/i386/pc_piix.c               | 20 --------------------
 4 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f6eac988c0..22335ef6b0 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -219,10 +219,10 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.3`` (since 8.2)
-'''''''''''''''''''''''''''''
+``pc-i440fx-2.4`` up to ``pc-i440fx-2.7`` (since 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-This old machine type is quite neglected nowadays and thus might have
+These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
 instead.
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 4664974a8b..0caa6a63e4 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -816,7 +816,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.2`` (removed in 4.0 up to 9.0)
+``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5fd83010ba..27e04c52f6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -256,31 +256,6 @@ GlobalProperty pc_compat_2_4[] = {
 };
 const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
 
-GlobalProperty pc_compat_2_3[] = {
-    PC_CPU_MODEL_IDS("2.3.0")
-    { TYPE_X86_CPU, "arat", "off" },
-    { "qemu64" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "kvm64" "-" TYPE_X86_CPU, "min-level", "5" },
-    { "pentium3" "-" TYPE_X86_CPU, "min-level", "2" },
-    { "n270" "-" TYPE_X86_CPU, "min-level", "5" },
-    { "Conroe" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "Penryn" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "Nehalem" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "n270" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Penryn" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Conroe" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Nehalem" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Westmere" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "SandyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "IvyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Haswell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Haswell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Broadwell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Broadwell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { TYPE_X86_CPU, "kvm-no-smi-migration", "on" },
-};
-const size_t pc_compat_2_3_len = G_N_ELEMENTS(pc_compat_2_3);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9615e25d56..c00d2a66a6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -421,14 +421,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
  * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
  */
 
-static void pc_compat_2_3_fn(MachineState *machine)
-{
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    if (kvm_enabled()) {
-        x86ms->smm = ON_OFF_AUTO_OFF;
-    }
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -811,18 +803,6 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
                       pc_i440fx_2_4_machine_options)
 
-static void pc_i440fx_2_3_machine_options(MachineClass *m)
-{
-    pc_i440fx_2_4_machine_options(m);
-    m->hw_version = "2.3.0";
-    m->deprecation_reason = "old and unattended - use a newer version instead";
-    compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
-    compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
-}
-
-DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
-                      pc_i440fx_2_3_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


