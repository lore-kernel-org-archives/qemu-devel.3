Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9988F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pi-0000id-AI; Tue, 24 Mar 2026 11:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pd-0000f2-O7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pb-0005C8-Rv
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:21 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso4338521f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365078; x=1774969878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dfNzBGzpTKbGiyXwJIuebHg/gBlotrth/GBr1EmFLrI=;
 b=L9PQlHij6P2oa62nh/6vI/myNzR7cRrJTW1xJ096HLD5FhpdUdOtrE0wu8WcyoUbz7
 /lSqpgn+96ypKo4kN5tp4U8SHXbetno48LZQF+LeRBxZg5chPVdkDJW2o0oB+2bWh6eJ
 wAfsp2+wRCGFF3AyJJeUoef99ihbcG0M6KsPdCkftkPLAysbw4iv/3jn48TZlFwCbmWz
 5AKj1idqc3qaB0zVJ5SjcvKreCfsWl9T5ZUkbax3jqrrjuaBFIouM9YAUEiyFrgsyqMf
 UnWgDRLxmTFOvtDVmEeyiyykzsPBhmR0hwNa2ybsvE27L9Xil5IUsalXcmi1FwRMQFr0
 IEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365078; x=1774969878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dfNzBGzpTKbGiyXwJIuebHg/gBlotrth/GBr1EmFLrI=;
 b=Fk2AXkTHFSUXpSCxNN+x5NNDn8IqYRJckO0cK5QPbeY4/OICn35q181ZBWBqlURTCl
 JGJooyOv4lie917uT524DjI13LYpDhW1OYVmX0trzLpMXyZAUpgJrfB5BgiY6T83NJ90
 4fPo4DJMisAEaEX2evNf+RP4ksnAi5xsvDMVBbkZZYN+yCim+QEhhdKNh0s//dKI0PJ4
 jCc3iNxsErMFz7WR4sj7CQw25uv6Ih8v54lQnGS4Ylsu2lZoi2Sxif/vLmjtQAGkkFFl
 NNUifo3M9j5aEuD8gw7A640Z+4EP68BABi024IO9gOPfWIbumzQNxvcu7m4a4VILc8Wj
 kMMQ==
X-Gm-Message-State: AOJu0YxBfwheIDtSsyPk4lkKzIMgd0+uZGwU3v2sBLvSb8pzYMhjlB3K
 2npnxZSxd8SbRLoAnYF9Ur8gLwiZ/jRj9c7FK2oTnE8i19tuNwfSgVexZT6jLbfP0CEwoRZDxjX
 MxEB9WKs=
X-Gm-Gg: ATEYQzzbQvboBjeVKqQLCP74EKyrVoEk/ieSlgjloWWo6D47B5JqT4beR/VlNu7/Hrh
 L6+vXU9wQMIOX5Oy3Zz+NrzJWnv2n4rKC0uYDrlftVUfEygbEpNbaJQKvpsEZh6LllLU9u+4vkS
 yji3rfapB3BFflygxZnNy+qwTq5lVoSGLPLJoTujUhMS1JRncnQ39cdRfHsSJrljcsbd2ftLMEA
 XSBrPbTTHWpKf8oUiWo8vX02FQwurnkMFpz04b/mo5PZZfNRPxS+MT4fD11AcVkrMmLnIGqpJ7u
 aRfZCBjzwF/JcdILtzHtQppfJyb0ecObJhci8KPNuV0u+gq4DOGhXcCKtfnGl0YBweF3o4Vh9pa
 apBnUD8EZAqYP1MfdqnyGKtmPUg+RzqlIASW2r38HThLb5LExj9t+5d1oCnb8kKHmopBPoVQMyl
 By/TDFs46B/Cc5AGdshs+rCHqIEGehElnqGaK+UNjBR0NGwTq6LTXsRvp3JvnwQ7Kcm4rEakyks
 I6uQ5IBVh7UGiUzj7LHggAbTabhzNc=
X-Received: by 2002:a05:6000:2c0e:b0:439:b744:c5fe with SMTP id
 ffacd0b85a97d-43b6427d272mr25436263f8f.52.1774365077977; 
 Tue, 24 Mar 2026 08:11:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] hw/dma/pl080: Fix transfer logic in PL080
Date: Tue, 24 Mar 2026 15:11:03 +0000
Message-ID: <20260324151111.237411-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tao Ding <dingtao0430@163.com>

The logic in the PL080 for transferring data has multiple bugs:

 * The TransferSize field in the channel control register counts
   in units of the source width; because our loop may do multiple
   source loads if the destination width is greater than the
   source width, we need to decrement it by (xsize / swidth),
   not by 1, each loop

 * It is documented in the TRM that it is a software error to program
   the source and destination width such that SWidth < DWidth and
   TransferSize * SWidth is not a multiple of DWidth. (This would
   mean that there isn't enough data to do a full final destination
   write.) We weren't doing anything sensible with this case.
   The TRM doesn't document what the hardware actually does (though
   it drops some hints that suggest that it probably over-reads
   from the source).

 * In the loop to write to the destination, each loop adds swidth
   to  ch->dest for each loop and also uses (ch->dest + n) as the
   destination address. This moves the destination address on
   further than we should each time round the loop, and also
   is incrementing ch->dest by swidth when it should be dwidth.

This patch fixes these problems:
 * decrement TransferSize by the correct amount
 * log and ignore the transfer size mismatch case
 * correct the loop logic for the destination writes

A repro case which exercises some of this is as follows.  It
configures swidth to 1 byte, dwidth to 4 bytes, and transfer size 4,
for a transfer from 0x00000000 to 0x000010000.  Examining the
destination memory in the QEMU monitor should show that the
source data 0x44332211 has all been copied, but before this
fix it is not:

    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
    -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
    -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
    -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
    -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
    -device loader,addr=0x1013010C,data=0x9e47f004,data-len=4 \
    -device loader,addr=0x10130110,data=0x0000c001,data-len=4

Without this patch the QEMU monitor shows:
    (qemu) xp /1wx 0x00001000
    00001000: 0x00002211

Correct result:
    (qemu) xp /1wx 0x00001000
    00001000: 0x44332211

Cc: qemu-stable@nongnu.org
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Tao Ding <dingtao0430@163.com>
[PMM: Wrote up what we are fixing in the commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/pl080.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 627ccbbd81..4a90c7bb27 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -179,23 +179,28 @@ again:
                               c, extract32(ch->ctrl, 21, 3));
                 continue;
             }
-
-            for (n = 0; n < dwidth; n+= swidth) {
+            if ((size * swidth) % dwidth) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "pl080: channel %d: transfer size mismatch: size=%d swidth=%d dwidth=%d\n",
+                    c, size, swidth, dwidth);
+                continue;
+            }
+            xsize = MAX(swidth, dwidth);
+            for (n = 0; n < xsize; n += swidth) {
                 address_space_read(&s->downstream_as, ch->src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
                 if (ch->ctrl & PL080_CCTRL_SI)
                     ch->src += swidth;
             }
-            xsize = (dwidth < swidth) ? swidth : dwidth;
             /* ??? This may pad the value incorrectly for dwidth < 32.  */
             for (n = 0; n < xsize; n += dwidth) {
-                address_space_write(&s->downstream_as, ch->dest + n,
+                address_space_write(&s->downstream_as, ch->dest,
                                     MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
                 if (ch->ctrl & PL080_CCTRL_DI)
-                    ch->dest += swidth;
+                    ch->dest += dwidth;
             }
 
-            size--;
+            size -= xsize / swidth;
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
-- 
2.43.0


