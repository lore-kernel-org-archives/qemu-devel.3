Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC47D1A435
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 06:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szVwj-0004Xn-Cc; Sat, 12 Oct 2024 02:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szVwh-0004XY-2d
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 02:49:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szVwe-00071y-Qx
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 02:49:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e15fe56c9so1976605b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728715783; x=1729320583;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=shEvOsIqnFEdJAF59XGhekSu58mftGKg5A0X7iIHXlY=;
 b=jxzNEaKKw//ixLd0HPYZ2JTpKz1sDXSzAh4osQtbyr0K4kVbAwGwyJ0Bb4MNoKIYrE
 NVNRmCxmu8lV6Dpw9MMVirhj+Jqc830vyHE92+bf3vzKVmyFXCQ7Z3hK9ohk3Yj24xCW
 /XMiosRW4CEDi1zxckoxtsZjiY/WR2c/9lAcY0Ihe/ZyTZrF3ChLiSar7KS/s4HrxpBf
 V6xuKcRFMi76NZVhAx5yWQ6Jh8ly8HLwgfRjqEUr4HMrQ16u4vjQKT1E8RSGM6R5BaPR
 EJg/0cvQZkJ4r/GF/1TU5X4RaCZC7FHy4WkA3Dauu+iQVgYVTwAiUgtBq52X4X2vJrz9
 EV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728715783; x=1729320583;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=shEvOsIqnFEdJAF59XGhekSu58mftGKg5A0X7iIHXlY=;
 b=NQoF+uJcHToTjcD+Rn0Inm5lxvFqkIjYf85MeI6PjXZXKPPLVcqdi7TKVmBq8iQBSk
 EpFZ/7w5/w0vUMS0CbTRW+tMGNtEzSVoyWR/qcmCU1Ok6IO5kkLMNUk4o+g145MNqMzj
 BsP4O/8gyEypnDQ5R077pHiu4OkEEBYgy23dxOPo6RvKQSRCJ+tvngBwo/Pk16HwD85J
 MhCwCieak4cODBLWVstNQFqWyB8gNbQwFrbbm7wAY0oWpex8HREhnbVOuNfzRSk8B8O+
 IfAcm3F0cB980USRWg68OkZzbGZK/zB7/mWBWzAd6DLk/tExhyusOmsfiLg0DjsViMkk
 BUPQ==
X-Gm-Message-State: AOJu0YzGy3tlmqZl9JILxxOkCEJsbOW3Jd7Txl5DHp0saZR04sJeXfaQ
 ql4F0Q+mdSNKouWGlyurNSQVsYIzvbNRmTx9kazMooutCOCTGIh/NhewFu845pc=
X-Google-Smtp-Source: AGHT+IEq884tq7XRmBjgoLKz0poIU48SytuDy11jCkVqq96xCT8i6KmoSQ3EIhlA86a4SsK0T2xKRw==
X-Received: by 2002:a05:6a20:6724:b0:1d8:acec:f5c2 with SMTP id
 adf61e73a8af0-1d8bcfaa1b6mr5301068637.36.1728715782761; 
 Fri, 11 Oct 2024 23:49:42 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7ea6ffeb587sm274072a12.44.2024.10.11.23.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 23:49:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 12 Oct 2024 15:49:36 +0900
Subject: [PATCH v2] dma: Fix function names in documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-dma-v2-1-6afddf5f3c8d@daynix.com>
X-B4-Tracking: v=1; b=H4sIAP8bCmcC/1WMQQ7CIBBFr9LMWgzQmoAr72G6IMNgZ1EwYEibh
 ruL3bl8P/+9AwplpgL34YBMlQun2EFfBsDFxRcJ9p1BSz0pKY3wqxNSaxUskjHWQH++MwXezsp
 z7rxw+aS8n9Gqfuu/X5VQAqfRogx4C6N7eLdH3q6YVphba18n6pzzlwAAAA==
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Ensure the function names match.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- s/space/memory/ (Peter Maydell)
- Covered more function names
- Link to v1: https://lore.kernel.org/r/20241008-dma-v1-1-c439c0fc5f3a@daynix.com
---
 include/sysemu/dma.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index a1ac5bc1b543..5a49a306284d 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -152,7 +152,7 @@ static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
 }
 
 /**
- * address_space_write: Write to address space from DMA controller.
+ * dma_memory_write: Write to address space from DMA controller.
  *
  * Return a MemTxResult indicating whether the operation succeeded
  * or failed (eg unassigned memory, device rejected the transaction,
@@ -189,7 +189,7 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
                            uint8_t c, dma_addr_t len, MemTxAttrs attrs);
 
 /**
- * address_space_map: Map a physical memory region into a host virtual address.
+ * dma_memory_map: Map a physical memory region into a host virtual address.
  *
  * May map a subset of the requested range, given by and returned in @plen.
  * May return %NULL and set *@plen to zero(0), if resources needed to perform
@@ -216,16 +216,15 @@ static inline void *dma_memory_map(AddressSpace *as,
 }
 
 /**
- * address_space_unmap: Unmaps a memory region previously mapped
- *                      by dma_memory_map()
+ * dma_memory_unmap: Unmaps a memory region previously mapped by dma_memory_map()
  *
  * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
  * @access_len gives the amount of memory that was actually read or written
  * by the caller.
  *
  * @as: #AddressSpace used
- * @buffer: host pointer as returned by address_space_map()
- * @len: buffer length as returned by address_space_map()
+ * @buffer: host pointer as returned by dma_memory_map()
+ * @len: buffer length as returned by dma_memory_map()
  * @dir: indicates the transfer direction
  * @access_len: amount of data actually transferred
  */

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20241008-dma-0221f9ce8898

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


