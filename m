Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D370C27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6XO-00046Y-M6; Mon, 17 Jun 2024 03:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XM-00044o-Cs
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:20 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XK-0002I2-Qu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:20 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cce3bc8c6so1762846a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608337; x=1719213137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jy+NKKxzRsNSVOw4XNFiJizT7ql+sFnoJXDbQFpH2Zk=;
 b=qmKjKvwVH7ZBzzYQe4vULOQv2VRa9j07N1gocZ3OBl1Lg8R6VIuiZGkNcTfsnmGOXg
 zso11R0zMXv4zKaNnI2TBeYy+CegPlb0Z9L3T/+nkY5VOCqzAj78NHb4AjyeM3z2tcrZ
 Hvj1LhDHZsD4RzIOkNu49jpJhKjK2GvIOd+0q1dkzumcQ+aRU6YmSwBurbj47k27K2l+
 3Jyoaw/ykh2X/GT+gQrtTCju8tGkqwlzePud3SKlJxg+H57uR1tCyK/fkKyg14nOl4o+
 FdczJYkFXyy9UDx9iXiw42e8B7ka1teMZUeCFA6VuOFt35L+nZ4PCErp3rFlv4J71zsR
 kcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608337; x=1719213137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jy+NKKxzRsNSVOw4XNFiJizT7ql+sFnoJXDbQFpH2Zk=;
 b=mkKkOY9h0CPCsm+Pq6z5lQMhTeFZmyh4fC6HZ9liuvigXE3q6zuMPumc9lZ8yiKmkG
 nTWw6FWCk+x7iQSDLpKTAWnKRyNX2xDH0M11y7t9vRGmA3wis0tQLOsX+zDo4Ygn5Cy8
 Vy6t0yjykJA58nSMZ5xJhkj1k23krp1HrybdMM94cEWiu20LK6zmmr0qq2ildVoyL4eA
 jOFjLcMhzeGI3WgMfDVL3b3vYtD4KlEuJRli5ipiIiqFkmoVJ2EtGeGkWBaI0sKRUEO0
 EyEt6f+PoKATSlrHQLrM0wSTj9mZV1YnxVfw1v9ppYsdQrhXujNQJa6SivJLK4mbBISo
 MsTA==
X-Gm-Message-State: AOJu0Yy0TqJaC8BuGg1bP8FixAsAAadXKnMEUB6ceQQ6wEfrYQpfcM1T
 uQR+pt1c3VxN34EOqckgMWx7gs9dGzzAOwJynbU569gQDA8n9qMuYR5tGn/1GO1H/G5VlRlD0qT
 REMc=
X-Google-Smtp-Source: AGHT+IFoFE8ZaiuI0QA7SKWwhzV4D+kXevwS/LoU/+xuX5RKkp+XiWRAt4SNAuYSbP4L69x0OT6AZw==
X-Received: by 2002:a05:6402:17d9:b0:57c:c712:a3c7 with SMTP id
 4fb4d7f45d1cf-57cc712a42emr4638452a12.36.1718608336894; 
 Mon, 17 Jun 2024 00:12:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da156sm5973482a12.22.2024.06.17.00.12.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 10/23] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Date: Mon, 17 Jun 2024 09:11:05 +0200
Message-ID: <20240617071118.60464-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

PCMachineClass::smbios_uuid_encoded was only used by the
pc-i440fx-2.1 machine, which got removed. It is now always
true, remove it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/fw_cfg.c     | 3 +--
 hw/i386/pc.c         | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0d730318fe..5667b87ed0 100644
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
index 6e0d9945d0..f9e8af3bf5 100644
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
index b0b8ecd64d..215462e861 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1796,7 +1796,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_acpi_build = true;
     pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
-    pcmc->smbios_uuid_encoded = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_aligned_dimm = true;
-- 
2.41.0


