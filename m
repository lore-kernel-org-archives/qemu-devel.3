Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D1FCD1288
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps85-0008Vc-7m; Thu, 28 Mar 2024 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps82-000859-Mh
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps81-0002j1-3F
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:22 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56c12c73ed8so1458494a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641439; x=1712246239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZcClnRjP7+/0e8fY+P9N5bd75aoGZ6efgZZhKhlNAY=;
 b=TyCwPyPhRh1929UKMQEMeZoUubWRLkspcsSFjnqhDWUlPcH/U6+jL12lMi1grKFMtQ
 WqF4QZy9LZdPrlALfj1poub4jLN9TXkmSXe1CqSDCAAC9LjXJzNzK8zB6wjQPryXWo9D
 9+b47+phR94y/+PXXF7zDQgMAA8jJ8QfsMDD11qIkrPIsS/udQ6mZB6I5I6v+gRDvLWY
 tyAN2H+b8T/bhYw02LAjI1E7B8PcNrkckLVaY0tKwqcXKyw30NO8dQ32+D/cLUK4/RPq
 DBFMR2kPVzPA/jdic3LmaFlsAsLg5e9BUDO9uoC30dO33gPDMaS4NMCa5BPH9BHNHkmE
 /3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641439; x=1712246239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZcClnRjP7+/0e8fY+P9N5bd75aoGZ6efgZZhKhlNAY=;
 b=JXScT5z1ZCU9UZ/nc81ioDi0lcfgewo2KkEeN+w/bUNDz6PCSg4jCiwwim9Adfk43K
 DEpXLBRPhqdCj5lH6Zq8YQPsl0iwkHCf3Hffc9NdGkVy/XbVqwRg6DIIlY40gZtpsaZ4
 hJtiRsXC1EjqrJma3LWMPOeJ4ojqKK03lCuCIu9rIKFpVd4hJowDwNX3IBkgUbd9cQUJ
 p0k+7i4Yr6LMLJBsFElAFbTHjngU7MHuz/jCzQ72FO2zEe9oCi6qiMz56nPqPZ0XpBkw
 A73oknZQJkTCK/SNbKw6as/15XG6cZ8B5MhgtrwMGh4Bwm323zJN0noFBN4ZcgbM3KAH
 obSQ==
X-Gm-Message-State: AOJu0YwYHKMer+xJJpqleHyqOmuBVJJtz3q+LuP6Mqvr8YVNzCleunAE
 b4udpCyGA2HGXNNBlqz98Ru3KBGXUYCNyh8l+sODTdXeRmz333ZH6ZqIc7DBcmKKTgCfb+Gq0Ew
 d
X-Google-Smtp-Source: AGHT+IFt2sBCHTR2Jv1SbwhNWwKdKTxoa7hJqsQNpLxVlwdOrAYikOdlndg+94qQnyUkEffbEuTZKw==
X-Received: by 2002:a17:907:971c:b0:a46:a1d0:8451 with SMTP id
 jg28-20020a170907971c00b00a46a1d08451mr2602412ejc.16.1711641439232; 
 Thu, 28 Mar 2024 08:57:19 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 eb16-20020a170907281000b00a4e0df9e793sm887845ejc.136.2024.03.28.08.57.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 25/29] hw/i386/fw_cfg: Replace smbios_defaults()
 by !smbios_legacy_mode()
Date: Thu, 28 Mar 2024 16:54:33 +0100
Message-ID: <20240328155439.58719-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

smbios_defaults() and smbios_legacy_mode() are logical
opposite. Simplify using the latter.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index ffa60a4a33..df05fe060c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -49,11 +49,6 @@ const char *fw_cfg_arch_key_name(uint16_t key)
 }
 
 #ifdef CONFIG_SMBIOS
-static bool smbios_defaults(PCMachineState *pcms)
-{
-    return pc_machine_is_pci_enabled(pcms);
-}
-
 static bool smbios_legacy_mode(PCMachineState *pcms)
 {
     return !pc_machine_is_pci_enabled(pcms);
@@ -70,7 +65,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
-    if (smbios_defaults(pcms)) {
+    if (!smbios_legacy_mode(pcms)) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc, mc->name);
     }
-- 
2.41.0


