Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE463C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPyS-0007PQ-Hn; Wed, 27 Mar 2024 05:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyF-000793-Ac
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:23 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyC-00073d-Pj
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso884865066b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533199; x=1712137999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXxR1JayEENwAneVfwOyENbtuFk+v6QHC/g5hLFE3LE=;
 b=eyZXeS3SGv1nuljx414K5gzvED7pFbX8zFwTpLQGOzYRQXonGsC9bVqaJpLElBHx1T
 GP75dbPxTzTH4swgWGhzFHLNFgmjtZ3i1mF1oxMDNZkwxLvi/xG3lmMkUUhH7mF71wo6
 AZkchue+hQnikF3qDnN8JhOgFWgqGzOqezBm+7OWPVLbolRN2HPMYPzlnx2Ox4X2x9VN
 T85nrQAX5Fe96TBHIYHQhwwF/fV8e6npkMxX8IBlG2j0JWwUDg1nOW/ooFuccynEJaWm
 SkPa6TymPnWOk07QBJPIFWdHcP76huoutofcUeTZsWhgeqfg4chOEVm7w+TX2TCnILTl
 VPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533199; x=1712137999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXxR1JayEENwAneVfwOyENbtuFk+v6QHC/g5hLFE3LE=;
 b=PCW7CV1BwnYx9N4yHdyg2XtzBdht8bmiymtCrwvkHNDTsz2mdT0TUhcrb4Y5T4omgL
 jW+YVZS4Ti56AkKPH7RUuxxT9RczG6QN0CVDttOfL8B3if3IekGMUGlHBEuzHBU5EGAR
 iCxXIbObGPd1kJZ9zCJ2p+QttI2cEh7d+cKHTvPjS5wIO4WORdTpU7/t6HylkZdFp6be
 ksnGZi3tMw3uMlCsJFCVcoqrRn4G6abf1+HCi6ZkIDdRVlwt4fWvQ2EKN6oQL4R/bG4v
 vohGxAbcZ6V71eM7nh1weAtBEurWr+U4LHWQla6Xki7VzUxO7tCxCgXCktGpi1NqeQeZ
 oERA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7JBiNnjygw0xHtbNyR+uzcAc1A4jucEM7DEAmZ7vLv0fjqG+rWoTsKgDJOPKAy5n8wUbs/epsLMyXXJabvzV9vBRKYRw=
X-Gm-Message-State: AOJu0Yw0+jkP9RGqZybcvQE3cg2TusCttlmqMlujMxVKYO1DjljbTkio
 x4Bcv1R+gj9t+W8orgMFksAT2aQSHp6Xaav6E1a6lECZLeZ/DTkaxe/xp6IGMT0=
X-Google-Smtp-Source: AGHT+IHooKJF3jmZgTnKpmDkYTg1D0pOTsqGCPA/7pGTnWXaj8BLHCOnpSoxiow8/OCSSgIM2BU0bA==
X-Received: by 2002:a17:906:3b0b:b0:a47:3887:db68 with SMTP id
 g11-20020a1709063b0b00b00a473887db68mr2521233ejf.38.1711533199430; 
 Wed, 27 Mar 2024 02:53:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 bm6-20020a170906c04600b00a46b4544da2sm5162665ejb.125.2024.03.27.02.53.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:53:19 -0700 (PDT)
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
Subject: [PATCH-for-9.1 v2 18/21] hw/i386/acpi: Remove AcpiBuildState::rsdp
 field
Date: Wed, 27 Mar 2024 10:51:20 +0100
Message-ID: <20240327095124.73639-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

AcpiBuildState::rsdp is always NULL, remove it,
simplifying acpi_build_update().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240305134221.30924-16-philmd@linaro.org>
---
 hw/i386/acpi-build.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ed0adb0e82..6f9925d176 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2459,7 +2459,6 @@ struct AcpiBuildState {
     MemoryRegion *table_mr;
     /* Is table patched? */
     uint8_t patched;
-    void *rsdp;
     MemoryRegion *rsdp_mr;
     MemoryRegion *linker_mr;
 } AcpiBuildState;
@@ -2715,11 +2714,7 @@ static void acpi_build_update(void *build_opaque)
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
 
-    if (build_state->rsdp) {
-        memcpy(build_state->rsdp, tables.rsdp->data, acpi_data_len(tables.rsdp));
-    } else {
-        acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
-    }
+    acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
 
     acpi_ram_update(build_state->linker_mr, tables.linker->cmd_blob);
     acpi_build_tables_cleanup(&tables, true);
@@ -2805,7 +2800,6 @@ void acpi_setup(void)
                            tables.vmgenid);
     }
 
-    build_state->rsdp = NULL;
     build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE);
-- 
2.41.0


