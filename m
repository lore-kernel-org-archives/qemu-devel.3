Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE805C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLkS-0004rh-QF; Tue, 23 Jan 2024 13:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLkA-0004jF-Kb
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:34 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLk6-0002oW-Jx
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:28 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 918E440342
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706035399;
 bh=wxjzye6ArgMxmoVHqUrJaFh02KD7JKVgYqu3hfX0S3g=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jrfhVpJ/URccex16MDtXw5mQyd/aGQP0R6rtx6Bw2dmJ3+juUH/gaZ1GOlgHUYBle
 I3BdcCT3X8NCS1X2R/3jTrtbHqGrplxF715juktd5jwBYnz1xURAEtVskthXpE9Hzq
 vXL9iNkH/b738P24Z2lZaojDmWzKSmnQ0ljl+puKb/cQR5b/yL/co0pTDvddXGlmtP
 Zc6Ee6L041cRWIb3cyJzP6z9hYkX8jWGEuDc8MKO4P00CUYckO18iCV5cx+7Q/pblq
 RbKls3nEXjKdDuYfA8ZSHb0nF3n1PWbeaDFWicB9PPnX4A6RHBwJ8SzUopqNhwEvd7
 XvC+grUXzHUQg==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-337bf78ef28so1965456f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 10:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706035393; x=1706640193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxjzye6ArgMxmoVHqUrJaFh02KD7JKVgYqu3hfX0S3g=;
 b=L5UvNDekakhr/DTC4blTlG61ndV8IS4Lym0XkyFc56ZMnVbR5jAPvTKQJ66SLYPwhZ
 Amk/LVfYzL0XK8qJxCCH6RY3SbUKxy4bt/URyyWZdGsADW4CbJ7RFj7lsmhlvLo20XJj
 ZgdKeyPFcbEqEKL+QvXq0KMOEaWsF3wRpDcrm3YrP92RvfNF1GnS6/9uffgAcGTCNfQ9
 5zO0mb7OXE903Bg+sKXHJyExnk7DBR/MFqmjYC0q8VLOf4v1ifkJbYAypZk50Q9QhD4e
 pqo7yvfTRJ5aTlXCsGHVI1U70u//fq0mZJQr+gCVuDfOn3QdXOee/FTdwE0YPcfn/kCW
 xFAA==
X-Gm-Message-State: AOJu0Yyey1qnJQBc6jhgXUkM4U0Oen0/OxoNQzByNdLTo5lYFGOXa7/Z
 G5XYrs12VbHP7Lgpvi0vvrA3TTWSS9R0iKqxczQteBUtNEiMwOkMiYCD1hFgagNFuaa4yPHRWV+
 TL8Xkkv095g2y/0lrGAFOLBsOQ06/d3w0UxwhEB/Yw0WVkzrJ2sBA2Ycl70F0cz3q4AZ2
X-Received: by 2002:a05:6000:1f8b:b0:336:8b43:acac with SMTP id
 bw11-20020a0560001f8b00b003368b43acacmr3550514wrb.13.1706035392772; 
 Tue, 23 Jan 2024 10:43:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVkMEoT3CoARuuvLZvj7i4pj60uiyJpsHob7hO0S6XTcGGzaqwL/W8ylqJOXfi3ZW9ne8TkA==
X-Received: by 2002:a05:6000:1f8b:b0:336:8b43:acac with SMTP id
 bw11-20020a0560001f8b00b003368b43acacmr3550505wrb.13.1706035392419; 
 Tue, 23 Jan 2024 10:43:12 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a5d6ac9000000b00337d392c6c3sm14180252wrw.13.2024.01.23.10.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 10:43:12 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 2/4] smbios: function to set default processor family
Date: Tue, 23 Jan 2024 19:42:27 +0100
Message-ID: <20240123184229.10415-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
References: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Provide a function to set the default processor family.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v4:
	no change
v3:
	no change
v2:
	new patch
---
 hw/smbios/smbios.c           | 7 +++++++
 include/hw/firmware/smbios.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 647bc6d603..c0c5a81e66 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -989,6 +989,13 @@ void smbios_set_cpuid(uint32_t version, uint32_t features)
         field = value;                                                    \
     }
 
+void smbios_set_default_processor_family(uint16_t processor_family)
+{
+    if (type4.processor_family <= 0x01) {
+        type4.processor_family = processor_family;
+    }
+}
+
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type)
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 7f3259a630..6e514982d4 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -295,6 +295,7 @@ void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
+void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
 void smbios_get_tables(MachineState *ms,
                        const struct smbios_phys_mem_area *mem_array,
-- 
2.43.0


