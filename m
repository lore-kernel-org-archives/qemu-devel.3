Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7706D2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdwT-0003V9-C4; Tue, 13 Jan 2026 07:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1vfdvr-0002xu-WB
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:55:37 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1vfdvp-0000Q5-UE
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:55:35 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-59b6f267721so5855692e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768308931; x=1768913731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AzgpZX/s+JwEfxKeQDTA8+BAxqVDSuLUyHaHdrkLiP0=;
 b=V0Ig+aC0yWVMS+SfR26IvT8sYx7t/OuwTEhKY1s4B83OHWXuDxm+UlEPA5B2gjvBAH
 lIY3Aj21tJAMWe+6W0ezrJ5/o3jbHG+k9B4QUtq5RHo1hD1I5VQZWFhW/LuIVtVQbN48
 Dgh6psS76isBBTZxHz6IqogzHr7t5sOmFIVVPeCWXee5wmq9kfuiL0NrWenEIvpdgJHo
 u2qWkdWZy/aNLDJnQ/tJf4NmGODD7Z94IK8efT+e+0DzJuBTbi4Z9OF+xztScQn5adP2
 Kw/SgAw2NE12gf8997TpA+1Ia7+gbE/xCxHAuffYqLEDaDZbgoEXP/n59/za+40ALl1E
 fNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768308931; x=1768913731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzgpZX/s+JwEfxKeQDTA8+BAxqVDSuLUyHaHdrkLiP0=;
 b=EwszsKwpHns/ehugEYqkebNJL+oegbpz+DlOirhvezmWuAnxDndWhTbRvjuWedbHoi
 M2veyMQ7hXcRqJh2hSGkMUxCqHPKmmR98EucnVYUTlm+WgJL7/E+yOUrcWiGslmCXlYp
 zXWS1aXHI1CnZx1ZHMYqr/MriMQY+wNiLRRXbLCYNab/iBqIQzgykiQcIA6vFkbwJOQg
 a7RG3rhxvZ+Yj1Ml4FgN6r/47lS8hgtUXmhNQVl45yDEHm2BwLDzkyH44Ihr833mMHaE
 BHpt9ZJYjl8J5990XbkOXjQCSK4jpZiV7tOTs3yHVdQnM3BGALo+152vg04dDTJCUQT9
 DUOA==
X-Gm-Message-State: AOJu0YwAyug6tJ3irnJ3bPmqgm6xFWcXSZ+kJyCxqLIt74URsKPrWpj8
 s0rFCKRKW/8qTa81XqHDxGzHXVmrAZeOgHGEKnQNbMAo8x41GrNfvuNK
X-Gm-Gg: AY/fxX4STb7mZU1/KorHetc0YuUW4RXmyKbJKYMSdFqigtMs0Pv6Vb6+7L6qfXqGBAn
 A0TYlW/CUDhdLQCOPoWlUUDAPC/pyepjJftTzHHdnivlS6Bz4C3VwtfFAHC2QJ2NReVIlc++rGw
 uioL+V2RsmkyQ3U8hhBQFhP2ZLHW/zGSI7gg22Ry7xIG7gIgSGJgWkvimAgOg7JES47HY9pDCfX
 Yr+8lMLMS1MRoKjcE+ApiCVQQnjoeiim8H6jbJAwa6PeOtS0SPcirke1FW0ZvYGg+kJ1FdNCRKL
 HeBVBkiYn60y3zru07/kUVdzpuQPX2M2PPPPMsNJ4H+0liZKWN/46iQaPlyNEZv1lzVtXv+uJZC
 trH+Sxq1U/gi87rTz0mSMoOj4rYmtmeWmfvC9hwMjSWr/su/qR2PwCKRHwDSoCMT6j1siOA==
X-Google-Smtp-Source: AGHT+IHs3HJkYK/2SSu0rqev4bLnx9VB5KWwkj4bh/+fBn4HSlKAzkncA5qbKM8dP5j7WL/e/05JyA==
X-Received: by 2002:a05:6512:1292:b0:59b:6b31:d786 with SMTP id
 2adb3069b0e04-59b6f05b50dmr7461700e87.49.1768308930376; 
 Tue, 13 Jan 2026 04:55:30 -0800 (PST)
Received: from X1 ([178.66.48.90]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b6dd08593sm4945059e87.77.2026.01.13.04.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 04:55:30 -0800 (PST)
From: Vladimir Isaev <vvisaev@gmail.com>
To: richard.henderson@linaro.org,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	Vladimir Isaev <vvisaev@gmail.com>
Subject: [PATCH] accel/tcg/cputlb.c: fix unaligned IO region access
Date: Tue, 13 Jan 2026 15:54:58 +0300
Message-ID: <20260113125514.111899-1-vvisaev@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=vvisaev@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to comment for full->xlat_section for non-RAM:
 Otherwise, iotlb contains
  - a physical section number in the lower TARGET_PAGE_BITS
  - the offset within section->mr of the page base (I/O, ROMD) with the
    TARGET_PAGE_BITS masked off.

This 'physical section number in the lower TARGET_PAGE_BITS' is true only
if memory region is aligned to TARGET_PAGE_BITS.

For example for memory region with address 0x1000c220 and size of
2 x 4k pages following sections will be created by flatview_add_to_dispatch():

flatview_add_to_dispatch section 1: addr: 0x1000c220 offset_within_address_space 0x1000c220 offset_within_region 0x0
flatview_add_to_dispatch section 2: addr: 0x1000c220 offset_within_address_space 0x1000d000 offset_within_region 0xde0
flatview_add_to_dispatch section 3: addr: 0x1000c220 offset_within_address_space 0x1000e000 offset_within_region 0x1de0

So offset_within_region is not aligned to TARGET_PAGE_SIZE.

This leads to full->xlat_section & ~TARGET_PAGE_BITS to contain information not only about
section number, but also about offset in the memory region.

Fix it by clearing TARGET_PAGE_BITS bits in xlat before adding section and reapply them in io_prepare().

Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
---
 accel/tcg/cputlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c30073326a..4c0b01b606 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1090,7 +1090,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         }
     } else {
         /* I/O or ROMD */
-        iotlb = memory_region_section_get_iotlb(cpu, section) + xlat;
+        iotlb = memory_region_section_get_iotlb(cpu, section) + (xlat & TARGET_PAGE_MASK);
         /*
          * Writes to romd devices must go through MMIO to enable write.
          * Reads to romd devices go through the ram_ptr found above,
@@ -1277,7 +1277,8 @@ io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
     hwaddr mr_offset;
 
     section = iotlb_to_section(cpu, xlat, attrs);
-    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
+    mr_offset = (xlat & TARGET_PAGE_MASK) + addr +
+                (section->offset_within_region & ~TARGET_PAGE_MASK);
     cpu->mem_io_pc = retaddr;
     if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
-- 
2.51.0


