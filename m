Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FA3C25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 00:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6gUQ-0000kR-Mk; Mon, 13 May 2024 20:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <perry@mosi.io>) id 1s6fAO-0004Yr-NA
 for qemu-devel@nongnu.org; Mon, 13 May 2024 19:33:12 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <perry@mosi.io>) id 1s6fAN-00022n-0d
 for qemu-devel@nongnu.org; Mon, 13 May 2024 19:33:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ed41eb3382so35768635ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 16:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mosi-io.20230601.gappssmtp.com; s=20230601; t=1715643188; x=1716247988;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=53Jt6gMAorAi5CZBeF/uqWTQ338ADSVXOncCzDFWhtY=;
 b=DQ5QgotT1uqKoZQyhMZdPt6AwjvJNASpzAOH5+r2XzPWhsJNx6YBQ2gh4Z0WG+Ya3I
 YT6vfNAbc+EDa/d76DnrTMkLFWCmFe/yndKFpdVnIXWCMirjjl/tT+QNMVoucu9Qp3jn
 6N4wx0Qys9elrXYMwvxvL2ofKCp9+B9KVePHZwXCIMHaDseMwcbtT+86ok6vGj+5u4UA
 4zwUIyKsyfAcEuyhFngBZkkoOv0v/VCGtuLcwl8KYuY0GnS5/uBJ/O2re24uUx/YSINQ
 pIo7ET5PmMzbsy/JR9eUpu9SkRp0QLlsIXDppoiNx0zK4r0svNky2PocT2lK5C2JOSW5
 A5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715643188; x=1716247988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53Jt6gMAorAi5CZBeF/uqWTQ338ADSVXOncCzDFWhtY=;
 b=dmFRIAUI+ZUFPUwPIG4aGvO5qws7uECpfz+K6++eNDcbgk+uLmaxw9CMHsJjadV9tu
 Ibt7PqrKCP1pFujRMyGzQURFoSlautZ2k2BaB5/i0OheeXI4kXTeubGKFpTFj+fC0E4a
 LRp53AgygIBpXfAcPnHAb2+RjUiQm8HkgZ4hjzyup2yAjk54oUs/YX16U5EfdjTKaAeq
 +gYfD8gNGPCWQVAMKJ6DNTG8t6rYCd/z38GW0fevpnw3F0pgBMNzgYRAbzqh0ChupMW0
 kC8kRNpff5K7NC2wsjKxaj+JnYWaT+YcOkDglmw2UBHhOeNA6Bi5uftHIguTLq97qPRf
 O7xA==
X-Gm-Message-State: AOJu0YwMXMV9jjnTKSjQhaGO8nn9IKZ4Iej+gOCVIlKMy227y35AC0tt
 XRkjHsUq1713wPqbuQsTgxgRjxyEEO3D8kFo1mjKZ/a6MR0LvOb12ADrn3Sx8iPv+xGbyinOfoY
 8R4w=
X-Google-Smtp-Source: AGHT+IHw9dD3I2/NyDElq8gV0krFctYIcSX25jkdGB3c3XKaxBob1Dm1J44J0WM1WFoujHME7mnmAA==
X-Received: by 2002:a17:902:ecc7:b0:1ec:7b0d:9eb9 with SMTP id
 d9443c01a7336-1ef4404e44bmr176914715ad.64.1715643188420; 
 Mon, 13 May 2024 16:33:08 -0700 (PDT)
Received: from lsp.pagetable.io
 (108-78-254-250.lightspeed.sntcca.sbcglobal.net. [108.78.254.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c03aadbsm84596215ad.227.2024.05.13.16.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 16:33:08 -0700 (PDT)
From: Perry Hung <perry@mosi.io>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, Perry Hung <perry@mosi.io>
Subject: [PATCH] physmem: allow debug writes to MMIO regions
Date: Mon, 13 May 2024 16:33:05 -0700
Message-ID: <20240513233305.2975295-1-perry@mosi.io>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=perry@mosi.io; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 May 2024 20:57:56 -0400
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

Writes from GDB to memory-mapped IO regions are currently silently
dropped. cpu_memory_rw_debug() calls address_space_write_rom(), which
calls address_space_write_rom_internal(), which ignores all non-ram/rom
regions.

Add a check for MMIO regions and direct those to address_space_rw()
instead.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
Signed-off-by: Perry Hung <perry@mosi.io>
---
 system/physmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 342b7a8fd4..013cdd2ab1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3508,7 +3508,10 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         if (l > len)
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
-        if (is_write) {
+        if (cpu_physical_memory_is_io(phys_addr)) {
+            res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs,
+                                   buf, l, is_write);
+        } else if (is_write) {
             res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
                                           attrs, buf, l);
         } else {
-- 
2.45.0


