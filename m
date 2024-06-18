Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D428C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbHP-0004EJ-7Z; Tue, 18 Jun 2024 12:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHG-0003xq-8d
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHD-0006t1-3v
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d0699fd02so83916a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726501; x=1719331301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpuxhErWC4Hjg+11YRmyemEnWJkaBfj9X0XpeCPS0AU=;
 b=YgK/2EdCl9J/u/RAlm87/stZb2ZoE3/SkwnN55D9fezFvnfA5qvxv5lOOx3ZnyMFQc
 LMlqmkEhJGHMTD8Cv6Qn+4n0zGLjQWpjlDVMq3Hp4h8eRxkd760tHA/3Ep/iBeM/+KnD
 efmjPRhGeptVadvB6xdSzVb+3jJZnAuVZVcRhownVMaFcaegCrB+YtHt1lrcia83oJIv
 7pQr6YONZSpStIQdKX5f6LLmwHWoWS+XhimKZD6c4uveK8NC6AHBWyTHL5SULRkzyNrg
 WLwPKfXN2x1M/hhxcW+nZkEj5pVklbh1A6QbI5pKKctPXaJwWB9suSUCPGl4L+OXGcVR
 g7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726501; x=1719331301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpuxhErWC4Hjg+11YRmyemEnWJkaBfj9X0XpeCPS0AU=;
 b=gEqmsipTqvbbOujQnYbEPn9j0zlOejlu+NwyxGqFV0H4msWc0RurYmw0UUO0LzViIp
 ZgnxBi8qTJE/EWrRcFIaR9pa3AO6Fn7nmCVeBtNBQKkV94b0/RjzSz7QLaWeSpLaqD7u
 oqZHe+d6/3TFWiraAnh8koKrWDhaOK6zKC6GdL1fi/g7io4SSnE4/BIaCMph3mq6CKmw
 DbABaWcLgrfmRv2pPDH/HntO1QLqwqwUBjLKF8I3e+/agf2x4+aJ9pMI2DmOMoeAwIsf
 By87psMbZarSx6b/H+t/TBNJalCasZwnEBBqMcoMDnY8edOZKNDn0kq1/QrhvhfM32P+
 k49Q==
X-Gm-Message-State: AOJu0YwJLtXwGj+HeG0e0hJCBjRoHcpKT/Zvf3J56XTdT6ckc8ZVu8JX
 ScmnFr2R6O9mooL4YoI1dP2L0j8PPBllAfCu1p7Ew7niYGMWuX1NpoApqYE59pFsfNwdHnncSW1
 S
X-Google-Smtp-Source: AGHT+IEFH3kMuoqdrWRnIi7/iKcFANfQeLHlgITHPlqUd+JyW2whIRWma36r1RFmq+fpkLtm49X5rQ==
X-Received: by 2002:a50:d602:0:b0:56e:3293:3777 with SMTP id
 4fb4d7f45d1cf-57cbd684886mr10972146a12.17.1718726501177; 
 Tue, 18 Jun 2024 09:01:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed3679sm627324366b.122.2024.06.18.09.01.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 10/76] hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
Date: Tue, 18 Jun 2024 17:59:32 +0200
Message-ID: <20240618160039.36108-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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
Message-Id: <20240617071118.60464-11-philmd@linaro.org>
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


