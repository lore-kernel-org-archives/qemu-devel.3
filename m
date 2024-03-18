Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B542AC54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFeu-0007Ly-1p; Mon, 18 Mar 2024 12:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFec-00078A-37
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeX-0004dD-Gj
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G4uSwZ/MizuMlWmoJcnBQJMBFs8dEzQrjhYJsZpx96c=;
 b=PcnVspY13sjiibWlG5XyVoRJ67L3MxB0wLG9YTpT9ceFGVM3imiiFlEVQh2CpfZ+JEjFkM
 pJJXyJVJhEqf4H675s1QzYzEs+3oEXeEsXHgaiU8ORnQMP2hTvt3d/Zhg68lfI71yq9bh1
 B1fp3QL3IMz5czCpTuFRIuP0NT4kjLg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-ClFxfxPfOYGE1mfAPBjXBA-1; Mon, 18 Mar 2024 12:15:55 -0400
X-MC-Unique: ClFxfxPfOYGE1mfAPBjXBA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3417fbb38daso310860f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778554; x=1711383354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4uSwZ/MizuMlWmoJcnBQJMBFs8dEzQrjhYJsZpx96c=;
 b=dYi5s2LDUXuRogAkZmJOkZV65L3TR7hIr7i07DAOip2L5lxACf0j15hrsLCgswgebg
 Bo7htD5nWjwbTeOlTH0cH7zqbNILh07ebRFezi/s9Ny2lHh7P8YVlxhgWYN5Z6Zvw6mV
 QjjcC2x84qgGGt6pg9Ov9NxawNgbypnz/fr89zBRI3PNEL0gNvYfS2e/8V1pqR6hqu2W
 FLBRGtrlx/kCQ4TzWTQdKk/7+r73h0krQ7UFVSr6WiK1rckPLiL1vuip567e1mCx4jNZ
 o+MEyMywL2glryg+Ak4MdTae9ef/KkXAgmz2j68maa5C3jIARlP1UHnt4Dh9M4WHx0bQ
 PGNw==
X-Gm-Message-State: AOJu0YyDlNu6Rj11TTClOT1XWERdgZkd62xyU7clkU2atmvjeaSajMiJ
 tMFTGwZ4u6ciXauJVZq43qUE97IUstWSDIinGF+PZbibHszuHF4wafW148nrm2KWDFF+9i4CLgW
 oC0EbZ471WCDyBfn68ixqOVkRuNrLo/nqYRlsrNacTgVb4WS6VogWMMzJxmcyIy1PC1kln7NnN1
 h/91ShcWQxl6OMRFx7VUVTL1m1xOFDgQ==
X-Received: by 2002:a05:6000:4e4:b0:33e:78c4:3738 with SMTP id
 cr4-20020a05600004e400b0033e78c43738mr10423215wrb.54.1710778553838; 
 Mon, 18 Mar 2024 09:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjfAxQqcnv0UP4PlclIOInFi8dmabiAWEbUq8Miw7LDUHTmljgN/Ct3JGJKRFci78gG+VWMA==
X-Received: by 2002:a05:6000:4e4:b0:33e:78c4:3738 with SMTP id
 cr4-20020a05600004e400b0033e78c43738mr10423177wrb.54.1710778553285; 
 Mon, 18 Mar 2024 09:15:53 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm10175671wrp.69.2024.03.18.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:52 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 07/24] smbios: cleanup smbios_get_tables() from legacy handling
Message-ID: <a7bdf7186f8ee5955874438ec2ddb1d28bc084b4.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

smbios_get_tables() bails out right away if leagacy mode is enabled
and won't generate any SMBIOS tables. At the same time x86 specific
fw_cfg_build_smbios() will genarate legacy tables and then proceed
to preparing temporary mem_array for useless call to
smbios_get_tables() and then discard it.

Drop legacy related check in smbios_get_tables() and return from
fw_cfg_build_smbios() early if legacy tables where built without
proceeding to non legacy part of the function.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-5-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/fw_cfg.c   | 1 +
 hw/smbios/smbios.c | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 98a478c276..a635234e68 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -74,6 +74,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     if (smbios_tables) {
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
+        return;
     }
 
     /* build the array of physical mem area from e820 table */
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 949c2d74a1..a1741a64a6 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1229,12 +1229,6 @@ void smbios_get_tables(MachineState *ms,
 {
     unsigned i, dimm_cnt, offset;
 
-    if (smbios_legacy) {
-        *tables = *anchor = NULL;
-        *tables_len = *anchor_len = 0;
-        return;
-    }
-
     if (!smbios_immutable) {
         smbios_build_type_0_table();
         smbios_build_type_1_table();
-- 
MST


