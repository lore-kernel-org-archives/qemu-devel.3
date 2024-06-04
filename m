Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180BAC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENx1-000844-O7; Tue, 04 Jun 2024 02:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENw8-00054w-MK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENw7-0007fN-6N
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkSjX6Tgf/hIveuNh1PWp+shd4Akyf2hePPEwewEYlA=;
 b=Hqt9+IPM1Rqld738jTOps5J3IwFd8yYD9nLRLM26hg6zOTC5k7aqc2H2tw6s322yTl41su
 182ZhmeECKaNCGiLNfyoZ0IU2CrdIRBIuX5Cq9lvQ3AsZZWmHLby71wbnHhWR2vGND12K/
 tpZvuqAKEjLnoBEr43PpC+M/R5ssJEI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-mY1NHqpOOjOQCvhreFYZfw-1; Tue, 04 Jun 2024 02:46:18 -0400
X-MC-Unique: mY1NHqpOOjOQCvhreFYZfw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68c70ab413so247045766b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483577; x=1718088377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkSjX6Tgf/hIveuNh1PWp+shd4Akyf2hePPEwewEYlA=;
 b=GLQQE2uVtpsj5T6ml01bQkJu1eRU84TbQnKGesjnAGYHjC8WZqmac1oTCoTAD46PZ5
 eJcNxr0VTmkxe6ASHbJyWT3eIB88tvu/5zH4t0VK4ZPiZniuna+yr66o9mpkktWUQlFg
 hVm30iS4UhkWluVh/qeE4QQ+XfFPtEnTnLyKouquOELk7HcT6qtNtt/Fx8QG1n8l/X/j
 aCDoPZDtvalcayfM+mlQVvje1+U8CmZEc1JKi3UXZfovqbs88JSGznZb8wrPAHE/ZaKg
 cwfI0hCg6FWakMV6x9KgFuT5RXSpnChBTZIwtPEgBO9lVYQdcXHSAtbDPkgRUMCKR7m5
 7Dsg==
X-Gm-Message-State: AOJu0Yws6T9bU61wBZySOT2ai+wr6BDP+udhPSv3+D2V7Jlc7s7V4raY
 dkyqaKYbBHeAqnRnYnvTAKSI9ysT//+DG7FJzbmxoDolH1eo0VMax66TgmI9aqDRKdR9pSByJt9
 f5VGFdLPT+So7bY4Utcr+vPTGV0qnys0TE5xm+FQVAEazcrhP7E7JKhFRzN336jkHtFfedzmA11
 NKxqs6cUBKRkKvdw5XdZg1TqjNh/nlLaawNdz2
X-Received: by 2002:a17:906:3995:b0:a68:c375:bc03 with SMTP id
 a640c23a62f3a-a695457434dmr116862866b.38.1717483577197; 
 Mon, 03 Jun 2024 23:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ad+iRFFwYT815k1/vRouNlMS1mIqD7fCb6m/0C1rgr/04nT38pGTAdd6GPfXz1R1LpzARA==
X-Received: by 2002:a17:906:3995:b0:a68:c375:bc03 with SMTP id
 a640c23a62f3a-a695457434dmr116862066b.38.1717483576853; 
 Mon, 03 Jun 2024 23:46:16 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691a8f98ffsm201174266b.123.2024.06.03.23.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:46:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 45/45] hw/i386: Add support for loading BIOS using guest_memfd
Date: Tue,  4 Jun 2024 08:44:09 +0200
Message-ID: <20240604064409.957105-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Michael Roth <michael.roth@amd.com>

When guest_memfd is enabled, the BIOS is generally part of the initial
encrypted guest image and will be accessed as private guest memory. Add
the necessary changes to set up the associated RAM region with a
guest_memfd backend to allow for this.

Current support centers around using -bios to load the BIOS data.
Support for loading the BIOS via pflash requires additional enablement
since those interfaces rely on the use of ROM memory regions which make
use of the KVM_MEM_READONLY memslot flag, which is not supported for
guest_memfd-backed memslots.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-29-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86-common.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index f41cb0a6a8b..c0c66a0eb52 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1001,8 +1001,13 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
-    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
-                           &error_fatal);
+    if (machine_require_guest_memfd(MACHINE(x86ms))) {
+        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
+                                           bios_size, &error_fatal);
+    } else {
+        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
+                               bios_size, &error_fatal);
+    }
     if (sev_enabled()) {
         /*
          * The concept of a "reset" simply doesn't exist for
@@ -1023,9 +1028,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     }
     g_free(filename);
 
-    /* map the last 128KB of the BIOS in ISA space */
-    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
-                      !isapc_ram_fw);
+    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
+        /* map the last 128KB of the BIOS in ISA space */
+        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+                          !isapc_ram_fw);
+    }
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.45.1


