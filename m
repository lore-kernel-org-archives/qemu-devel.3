Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C2606C117
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i7CdxeNS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufe-0004QN-C9; Mon, 16 Nov 2026 06:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueg-0003wg-7S
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuec-0002Dy-Uq
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:45 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1791370f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827621; x=1795432421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=adxIr/XFyHr4P8yYnBX6Rcv9bXNf1Ug2i/vRC0a93N8=;
 b=i7CdxeNSfktXkNIQjlQu5mi1EOXFTCaUvpH2C84tejRGkQknjBRE1m/paX5lDKTnV0
 LNf/7WYe7KKgeyAQoc3DyblKAkoFO7PfuHjzi7mYu6DEOwKwNxC7Yi2fhP7+Wxi1NtfE
 YJuXbK/bWHkJeMbbj3+aYToqmiPF0ZWMmi3sougY03B5iw8QKun+w1smlhqP6MOVlayi
 rQUpLzIboaZxz0wQNUOIA4j688pbhxA8cb819uFJqoGGyqaKfKJ8wuGVMml1Nn3ej+Kl
 nDH0MvecinO4SM0u8s17wTUFmihnEOvWP5NX3hAsF8QnzjUhK5LySYS+ohmL2rUWxSkK
 m0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827621; x=1795432421;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=adxIr/XFyHr4P8yYnBX6Rcv9bXNf1Ug2i/vRC0a93N8=;
 b=AhU6n/7/YcbYO/A7noJ2BnU/769CAMqj8EGaAwGawh61F/sJkUJtK0Vjrvf7KSlo9r
 EXOIe8/rGGeU7/OOOztheQP7vlc8v5mN8Vwr9x9nzSrxI1ixiMguIU+YC8s6Y8HqSf43
 L2ABiHM3MIe9oDs/beLT6sE197BsHW9Ki3dSUB2bDgbxoHNovCRIDD1RghNd/RfJz+kk
 3FbrUodLur9aruADALh+xwqaqFiRgKGtfEQRFV0QSkq2i0cJpQHDc3RuTaeIREEVNoIa
 DjTaWsk7W1w08645Z7GGDSQOk7RjZEBa5/G0B0qnN5BF4fn0nDh9EUu/YRF/TWNcZkbX
 VRsA==
X-Gm-Message-State: APuU4Z++0a0xwy8tn0kt2wHDbI23L33Nj9XFaFDQt1jMQM4EMM9tvjiR
 WEfPi431gxTUWZtkZ0pBhk6KkK7q7gMhsDQ5eqglbDm2/kNe1Ov6RCYmEZHllyEMk4+AZfz6eIo
 L9gIIUUM=
X-Gm-Gg: AZFdTZdMzUn7Vs7ASGkvszer0+d+LkFnSx/faba0ydNCCpDYeu7BpF1GVhFzEzaIorz
 NofFqMWHy4UMUDGVHJINixOvo+rw5LXqh26CHQa0CRliZQ0/1ZxYTGoXs+6RSCHMuAqQA7eEHUV
 UrzGypYQJq+JWu945+NpOPCthA2eUQ+iAkNJEYdTZSXT3ywRqKry1R/RIClq+uM6G4R4HCLNN7g
 8a8dmJHPw/xFjNTh0yDxLtQHfsgvasAwKcF7Qxker0MRm2O3ixaPRT8iXUvSdw4qvEN71glzFYq
 fLNz9ngINgGKd/Zq3D5eHNsyLwqBXkLlb/Xtl5CluACmJdVw3FmlrskXYRGILhLV8jFph4Rci9Z
 OJ8mSkSmIE4EEOOKpVNrXhLdUX4cuZJI/JdPVFS6eyiHxUI1NnKQLemAS1GDsMMBRPI6nbDdmHS
 4ikQs9kMlagCH2EuoVypEPNb4ekCiWqnC8iMAGNZ/HkNva9U52qCqXyPEbHsw7qpmBxriXtDsx0
 8dtqKcl2ZSaqhupz/8FYrPvrN2JQw765K5aHAVlaMdl2iLW9V3bG9kgwcEJ95innN2cnrz5bla5
 deRCttVnAY2xtdK62mAx5HOfDwmWiMDtPJi/Qu7ZYePlnMPpEjNWund8C+sUci9JN0LX62Mo06p
 Z7+8qm+zJYnByijOCAOgiOBu8XCpeEW4+3JXjHupRK3N1SK4ACulWvHU=
X-Received: by 2002:a05:6000:480c:b0:491:45bc:d691 with SMTP id
 ffacd0b85a97d-49c6fc9e626mr20756606f8f.2.1794827620996; 
 Mon, 16 Nov 2026 03:13:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/33] hw/net: cadence: Honor subword lanes in the GEM registers
Date: Mon, 16 Nov 2026 11:13:02 +0000
Message-ID: <20261116111303.1692832-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bin.meng@processmission.com>

The GEM MMIO callbacks ignored the low address bits and access size.
Byte reads therefore always returned lane zero, causing guest driver
that reads the station address byte by byte to turn four unique MAC
addresses into the same value. Partial writes had the corresponding
lane-selection problem.

Extract the requested little-endian read lane and merge partial writes
with the current register value. Preserve the existing read-clear and
write-clear behavior and dynamic queue pointer readback.

With this change, reset the TX queue pointers only when a write covers
TX-enable and leaves it clear, and only start a PHY operation when a
write covers the OP/ST fields in the PHY maintenance register.

Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261109143410.3279305-1-bin.meng@processmission.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 55 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 9a94b3b8ca4..7456f0e18e7 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1603,8 +1603,11 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 {
     CadenceGEMState *s;
     uint32_t retval;
+    unsigned shift;
+
     s = opaque;
 
+    shift = (offset & 3) * 8;
     offset >>= 2;
     retval = s->regs[offset];
 
@@ -1638,7 +1641,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 
     DB_PRINT("0x%08x\n", retval);
     gem_update_int_status(s);
-    return retval;
+    return extract32(retval, shift, size * 8);
 }
 
 /*
@@ -1649,35 +1652,43 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         unsigned size)
 {
     CadenceGEMState *s = (CadenceGEMState *)opaque;
-    uint32_t readonly;
+    uint32_t access_mask;
+    uint32_t writable_mask;
+    uint32_t write_val;
+    unsigned shift;
     int i;
 
     DB_PRINT("offset: 0x%04x write: 0x%08x ", (unsigned)offset, (unsigned)val);
+    shift = (offset & 3) * 8;
+    access_mask = MAKE_64BIT_MASK(shift, size * 8);
+    write_val = (uint32_t)val << shift;
     offset >>= 2;
 
     /* Squash bits which are read only in write value */
-    val &= ~(s->regs_ro[offset]);
-    /* Preserve (only) bits which are read only and wtc in register */
-    readonly = s->regs[offset] & (s->regs_ro[offset] | s->regs_w1c[offset]);
+    write_val &= ~(s->regs_ro[offset]);
 
-    /* Copy register write to backing store */
-    s->regs[offset] = (val & ~s->regs_w1c[offset]) | readonly;
+    /* Copy writable bits in the accessed lanes to the backing store */
+    writable_mask = access_mask &
+                    ~(s->regs_ro[offset] | s->regs_w1c[offset]);
+    s->regs[offset] = (s->regs[offset] & ~writable_mask) |
+                      (write_val & writable_mask);
 
     /* do w1c */
-    s->regs[offset] &= ~(s->regs_w1c[offset] & val);
+    s->regs[offset] &= ~(s->regs_w1c[offset] & write_val);
 
     /* Handle register write side effects */
     switch (offset) {
     case R_NWCTRL:
-        if (FIELD_EX32(val, NWCTRL, ENABLE_RECEIVE)) {
+        if (FIELD_EX32(write_val, NWCTRL, ENABLE_RECEIVE)) {
             for (i = 0; i < s->num_priority_queues; ++i) {
                 gem_get_rx_desc(s, i);
             }
         }
-        if (FIELD_EX32(val, NWCTRL, TRANSMIT_START)) {
+        if (FIELD_EX32(write_val, NWCTRL, TRANSMIT_START)) {
             gem_transmit(s);
         }
-        if (!(FIELD_EX32(val, NWCTRL, ENABLE_TRANSMIT))) {
+        if ((access_mask & R_NWCTRL_ENABLE_TRANSMIT_MASK) &&
+            !(FIELD_EX32(s->regs[offset], NWCTRL, ENABLE_TRANSMIT))) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
                 s->tx_desc_addr[i] = gem_get_tx_queue_base_addr(s, i);
@@ -1692,37 +1703,37 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         gem_update_int_status(s);
         break;
     case R_RXQBASE:
-        s->rx_desc_addr[0] = val;
+        s->rx_desc_addr[0] = s->regs[offset];
         break;
     case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
-        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = val;
+        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = s->regs[offset];
         break;
     case R_TXQBASE:
-        s->tx_desc_addr[0] = val;
+        s->tx_desc_addr[0] = s->regs[offset];
         break;
     case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
-        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = val;
+        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = s->regs[offset];
         break;
     case R_RXSTATUS:
         gem_update_int_status(s);
         break;
     case R_IER:
-        s->regs[R_IMR] &= ~val;
+        s->regs[R_IMR] &= ~write_val;
         gem_update_int_status(s);
         break;
     case R_JUMBO_MAX_LEN:
-        s->regs[R_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
+        s->regs[R_JUMBO_MAX_LEN] &= MAX_JUMBO_FRAME_SIZE_MASK;
         break;
     case R_INT_Q1_ENABLE ... R_INT_Q7_ENABLE:
-        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~val;
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~write_val;
         gem_update_int_status(s);
         break;
     case R_IDR:
-        s->regs[R_IMR] |= val;
+        s->regs[R_IMR] |= write_val;
         gem_update_int_status(s);
         break;
     case R_INT_Q1_DISABLE ... R_INT_Q7_DISABLE:
-        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= val;
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= write_val;
         gem_update_int_status(s);
         break;
     case R_SPADDR1LO:
@@ -1738,7 +1749,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
     case R_PHYMNTNC:
-        gem_handle_phy_access(s);
+        if (access_mask & (R_PHYMNTNC_OP_MASK | R_PHYMNTNC_ST_MASK)) {
+            gem_handle_phy_access(s);
+        }
         break;
     }
 
-- 
2.43.0


