Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4BDC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret0j-00066p-4o; Tue, 27 Feb 2024 03:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret0i-00066F-4V
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:24 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret0g-0007i6-E8
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso893705f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023221; x=1709628021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWmgk+68LApkOPWy7YUYgSrrjaqZXObndrHRfRf+NyU=;
 b=V7dI4Ho9LDLuMHQi8UHl5tXKKI397zCeRb9GHzzXNOEam4+/VNpWpgfnYHzVLct2ig
 DnD8aAqV9UH7QV54v/dl/yxsQwdYXa7oNVpZsPCJg2lVW9KM+mMEs52UrHSLkghwvtnj
 x7m6UlhN+KnfkDuffXG8KPRJbdGJSwOTZuTmdLxaCH+hpt7cuorr9RLJhS4XVtXkyzCf
 JzC12yO15gAFqiKHNDOG0TlYsyPRAoJPUPznTpVIp/evLuViPoWcxHzlk0jKNnZ1LO+a
 i9n5sfLh7tvs9x7K85iKGZZLsdJ4nKEGxTiq+tpm4crQyYrMLDSnDFVN2FoT7WHTj8+k
 Ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023221; x=1709628021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWmgk+68LApkOPWy7YUYgSrrjaqZXObndrHRfRf+NyU=;
 b=Z7uaKPshVfxKF3vGzyLbAaWY3vwdbZAYefl/L8xfZmTMCKXOQNphWRM8kUYfDa8MWU
 n81EG4xGX92ZmGw6tcvX+WWF2ypn4myuYnNbAyF/XzgcCgw1EJ5eIY4tAiBD3RU7bJl+
 yuoqkGEyN0bdixCpaN/cQqX9/yRVpK63dEOrjZNSqfEv68u6BSZxAEJnx64FcIVLcxdd
 s/yJjm70EKKlC4jyJWXQp0p7oSNMEt2lopvI7dqMJd17XWI2GPMacDYq2RZUjjsq2AfT
 oudoyJ9DdhGbTqMj+aMBaGw5HW8yjakx42JC/R3BLg66LDcFmGfto3fMj5O+k21ASd4u
 R3RQ==
X-Gm-Message-State: AOJu0YwLIh9GrpclfmWXIPX64QGnjXneUqRKlrwPRWCyl7St+GJ2yUZt
 M/hbCnJFvwnmQl71BJHTY8KebgswCw1A3jRA1IIWY3iZ8lbr7Tezc9H4kWgVqMbGXkLTJhqdZup
 /
X-Google-Smtp-Source: AGHT+IHlowSWUgonUicezcAUv37tfeY2t4fNQ8ilz1Ff3gwsIZgFc3bnnF3Er3iJzfWjvl1FPo7WKg==
X-Received: by 2002:a5d:4106:0:b0:33d:90c2:c7f4 with SMTP id
 l6-20020a5d4106000000b0033d90c2c7f4mr8225142wrp.14.1709023220812; 
 Tue, 27 Feb 2024 00:40:20 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 bj29-20020a0560001e1d00b0033d81d9c44esm10779692wrb.70.2024.02.27.00.40.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:40:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org
Subject: [PULL 05/30] hw/i386/kvmvapic: Inline sysbus_address_space()
Date: Tue, 27 Feb 2024 09:39:21 +0100
Message-ID: <20240227083948.5427-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

sysbus_address_space(...) is a simple wrapper to
get_system_memory(). Use it in place, since KVM
VAPIC doesn't distinct address spaces.

Rename the 'as' variable as 'mr' since it is a
MemoryRegion type, not an AddressSpace one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240216153517.49422-6-philmd@linaro.org>
---
 hw/i386/kvmvapic.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 20b0300357..61a65ef2ab 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -58,6 +58,7 @@ typedef struct GuestROMState {
 
 struct VAPICROMState {
     SysBusDevice busdev;
+
     MemoryRegion io;
     MemoryRegion rom;
     uint32_t state;
@@ -581,19 +582,17 @@ static int vapic_map_rom_writable(VAPICROMState *s)
 {
     hwaddr rom_paddr = s->rom_state_paddr & ROM_BLOCK_MASK;
     MemoryRegionSection section;
-    MemoryRegion *as;
+    MemoryRegion *mr = get_system_memory();
     size_t rom_size;
     uint8_t *ram;
 
-    as = sysbus_address_space(&s->busdev);
-
     if (s->rom_mapped_writable) {
-        memory_region_del_subregion(as, &s->rom);
+        memory_region_del_subregion(mr, &s->rom);
         object_unparent(OBJECT(&s->rom));
     }
 
     /* grab RAM memory region (region @rom_paddr may still be pc.rom) */
-    section = memory_region_find(as, 0, 1);
+    section = memory_region_find(mr, 0, 1);
 
     /* read ROM size from RAM region */
     if (rom_paddr + 2 >= memory_region_size(section.mr)) {
@@ -614,7 +613,7 @@ static int vapic_map_rom_writable(VAPICROMState *s)
 
     memory_region_init_alias(&s->rom, OBJECT(s), "kvmvapic-rom", section.mr,
                              rom_paddr, rom_size);
-    memory_region_add_subregion_overlap(as, rom_paddr, &s->rom, 1000);
+    memory_region_add_subregion_overlap(mr, rom_paddr, &s->rom, 1000);
     s->rom_mapped_writable = true;
     memory_region_unref(section.mr);
 
-- 
2.41.0


