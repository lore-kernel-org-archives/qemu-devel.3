Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86452CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsE-0001fe-9s; Mon, 08 Sep 2025 06:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsD-0001fA-DX
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs6-0000vT-MX
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7929tqjr/p/MqUXWGl/GVOXgHyxRWujXMrtUmPUHm9Y=;
 b=WO457PV+suSFr3jsTBI9eHe/2pba7zorezbpecY/VqnpBf3aYQ6khfWA/cxHX4Df2H6WvH
 CS7ZelyHOKvWt7FHcMFbW1dieLo01cuyK6Rzj/yDU/7eYaajPA+vPm/8yRIAJc8OIdAUn6
 4oIugyZNGgnQYUiTIPCTFCewFnbOcEg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-sc1GTG6mNj2bua4IC_NALQ-1; Mon, 08 Sep 2025 06:13:02 -0400
X-MC-Unique: sc1GTG6mNj2bua4IC_NALQ-1
X-Mimecast-MFC-AGG-ID: sc1GTG6mNj2bua4IC_NALQ_1757326381
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3dabec38299so2705404f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326380; x=1757931180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7929tqjr/p/MqUXWGl/GVOXgHyxRWujXMrtUmPUHm9Y=;
 b=hCflh+VHIP0tfbtBj+yecGRlw8hgaYf1cFrI7qTOaCXd2qgwFvR6Zb0hVTSnborejl
 C7zZmQCuebp/OsWVjVEqOId53g5nXGqcWQAOPMggCH/kcjplvkAvz0luncPeStrb3XIi
 JVx8I+HvdRyDAD8Wxv+939uDDD8JeB0ao7nzXh9/l8R44eWRtmrC/1Y5NBBRhtMaks7h
 Y56lsZkiG7K0Ev6LXjvEL6bCP6TtIDIubiorXI4II2kcafKfRisx0cRf3k0R4drN097u
 rOmduSzor4DPBsUAP94qymF8ThRNlgG8KskFfxsQea7Lq126N/YJDqv7eTeRPD3gZyIZ
 8dhQ==
X-Gm-Message-State: AOJu0YxgukNrp2446AIs4xRI0LmeeF4EoKvpqBU032enKxgGRzMWbn4V
 wUZBZA4A4bviFTkRKmpfjCdcMjonOufOyjHlk/aHWvs1lIaynQQRbdZEUJMA4JvQ6SziiwtwWcn
 T8OxizGlBtMcg8J8o7feUO12JXuuxl4OIcJkx/gUohA/4YmQBREKSSkMkmc+R3Ynp/5r1GvlGp1
 /K6zKUB+JzJ+cx6hIGZnV9GNJJwX8QHhht77C/RB2P
X-Gm-Gg: ASbGncvSJP5yAOTYb3JlIj+IGus7FWDOgEM6mrMl+T6YHkb5T2XCZlfknc6SlhoMtU3
 dIQ51xzeL+4PP5mQh2JgNXkS4h1i3L4dYY8fUP8zRUEPbGN6Fb2u0LBdC8/TDWzA6PGUGzJNVCb
 DY9YnFZln6vwGYswXBCWufVWPe/p5StSoiC0shvuSaAOFZocaeRS71JYba6U1fqZZLMiTAP9wtp
 H6FDq3ylIR+3gXD8V6tr0l67f7dDQ7WsxdsGg4EzV37sDjw8/8Rz1GHWBAgNO9vE6nj4Maw4AD/
 LbiG+O4LMk+SM1+sT+FidOEVuktbdbSH2jF8bT2mFVKLQYHxssTK1GfExP7wpBlW1d8/nmrOET4
 du4SnhyiYNCowTi/ZF1+7wrGpzcw5GN7vwn8kEZ4Yn0k=
X-Received: by 2002:a05:6000:2509:b0:3dc:15d2:b92a with SMTP id
 ffacd0b85a97d-3e64bde94a4mr4706612f8f.41.1757326379710; 
 Mon, 08 Sep 2025 03:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM7sMBr396NKPBWrdH3NAXZDFZt8x2cZeikGC5wItcU0fa+hOanLW0pAo/ZekQOi0DsZpMIw==
X-Received: by 2002:a05:6000:2509:b0:3dc:15d2:b92a with SMTP id
 ffacd0b85a97d-3e64bde94a4mr4706585f8f.41.1757326379193; 
 Mon, 08 Sep 2025 03:12:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9bcda91dsm270382705e9.6.2025.09.08.03.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/19] cpu-common: use atomic access for interrupt_request
Date: Mon,  8 Sep 2025 12:12:29 +0200
Message-ID: <20250908101241.2110068-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Writes to interrupt_request used non-atomic accesses, but there are a
few cases where the access was not protected by the BQL.  Now that
there is a full set of helpers, it's easier to guarantee that
interrupt_request accesses are fully atomic, so just drop the
requirement instead of fixing them.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h |  1 -
 hw/core/cpu-common.c  | 12 +-----------
 system/cpus.c         |  3 +--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b01a0cffd64..23bd02277f4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -495,7 +495,6 @@ struct CPUState {
     bool exit_request;
     int exclusive_context_count;
     uint32_t cflags_next_tb;
-    /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
     int64_t icount_budget;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 259cf2a3c36..152abc9024b 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -67,19 +67,9 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
-/* Resetting the IRQ comes from across the code base so we take the
- * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool need_lock = !bql_locked();
-
-    if (need_lock) {
-        bql_lock();
-    }
-    cpu->interrupt_request &= ~mask;
-    if (need_lock) {
-        bql_unlock();
-    }
+    qatomic_and(&cpu->interrupt_request, ~mask);
 }
 
 void cpu_exit(CPUState *cpu)
diff --git a/system/cpus.c b/system/cpus.c
index 437848b5eb4..9bfbe2b0607 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -257,8 +257,7 @@ int64_t cpus_get_elapsed_ticks(void)
 void cpu_set_interrupt(CPUState *cpu, int mask)
 {
     /* Pairs with cpu_test_interrupt(). */
-    qatomic_store_release(&cpu->interrupt_request,
-        cpu->interrupt_request | mask);
+    qatomic_or(&cpu->interrupt_request, mask);
 }
 
 void generic_handle_interrupt(CPUState *cpu, int mask)
-- 
2.51.0


