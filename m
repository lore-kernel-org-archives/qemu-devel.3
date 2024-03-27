Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2B2C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPxK-0003Oy-Hp; Wed, 27 Mar 2024 05:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxI-0003C9-MN
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxH-0006n4-3b
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:24 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a468004667aso877389766b.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533141; x=1712137941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moMRgwVbBcI6V0GvPpasfOh1Y8vOj0lwuTNViKRW0J4=;
 b=cighFEa0SSY5elw7R8hguzTcc+TNFd7OFTL7vVC3rfau0yWnHJMasile17QM65TxDm
 Ec+tNfHh3QF4rQNN5aqrmGrZFSYcB6/9XDjxqJsCbIiD0Tj35GzIk0EG1V20EU4PMqkr
 SntIplNe4Ij2KKGcYm2VYfH5NsiFkRH5fQK/u//6f5Bws7E4NyqaZPy8QHz2gwX1wnud
 kZgn4SA75oV0tnk51Sdnp2TvYUMVtn62QYpoOB6RCSm9jgeEMJBBYgjArFXzUN+j/jov
 ve7XXTjBuB6z2IldiAH+Cg8q6CVJiD1VKYIIXrZmJc5Uj6p9CA5x6bn0UJOmP0IVa3Cz
 uW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533141; x=1712137941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=moMRgwVbBcI6V0GvPpasfOh1Y8vOj0lwuTNViKRW0J4=;
 b=OhXF05PHRLTyfOFu2t+TmsuOzSfhZOc6jVBSoZPqDC/plmrTpy4UUDjQ5OwMvDtxlU
 VqwkAfKzzQ/S8qJaoAEQG8oZa0ubjVytqoQfkgkTLXFqWdOoPXoz38XVaTsNAWAhp/FJ
 1N3I10AfJpVM40cluHvCXriPziiHGskl7U/1ylsqQK/bWeM5q3eCPK5yXEpDV8hsk3FZ
 49mOXRdg63cXR9OkIhVYSozOOBSDMrT8UxFDYPXVOS56GKu88MWG6KsbP8rV4pgCrDZE
 rVPFu+wgC1gFQXSOrMHL19N8vTGqigYfhDLd9kNS4xJa3yO0qbzRepDrgRJBsvwfUT4S
 gSeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX1aNDjlOKfODkm1tA18oEmC68iK1j3C+0JMpFOthaf67ARKCC2VlDhgAUbB2aylzOrwH5fFPNhEuZoHcoZJEtGyv4m/A=
X-Gm-Message-State: AOJu0Yxr6ubY2U5FZ/FWirw1RE/rw+tYa473RJsuHSV28SLghT9dPwSe
 hYFPLqDiixGDrYYcz6xtRi8wU7RDz/z+RIw+Zv/ajOkClSMennPdvXUHki2v1h5ZihoTbGUV3SF
 9
X-Google-Smtp-Source: AGHT+IFnKw0SDb6IVuscFF1/38X2UZrufZOvBqSpkICgzFbt0upCslCJdObQt78dvvNAU5W8kG3bXQ==
X-Received: by 2002:a17:906:8c3:b0:a47:3312:b32a with SMTP id
 o3-20020a17090608c300b00a473312b32amr2637994eje.58.1711533141593; 
 Wed, 27 Mar 2024 02:52:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 t26-20020a170906a11a00b00a473792da26sm5303969ejy.19.2024.03.27.02.52.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:52:21 -0700 (PDT)
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
Subject: [PATCH-for-9.1 v2 09/21] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Date: Wed, 27 Mar 2024 10:51:11 +0100
Message-ID: <20240327095124.73639-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

PCMachineClass::smbios_uuid_encoded was only used by the
pc-i440fx-2.1 machine, which got removed. It is now always
true, remove it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/fw_cfg.c     | 3 +--
 hw/i386/pc.c         | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b528f17904..c2d9af36b2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -109,7 +109,6 @@ struct PCMachineClass {
     /* SMBIOS compat: */
     bool smbios_defaults;
     bool smbios_legacy_mode;
-    bool smbios_uuid_encoded;
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d802d2787f..f7c2501161 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,8 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
 
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc, mc->name,
-                            pcmc->smbios_uuid_encoded);
+        smbios_set_defaults("QEMU", mc->desc, mc->name, true);
     }
 
     /* tell smbios about cpuid version and features */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 21a19f9f9f..f9650a2821 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1776,7 +1776,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_acpi_build = true;
     pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
-    pcmc->smbios_uuid_encoded = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_aligned_dimm = true;
-- 
2.41.0


