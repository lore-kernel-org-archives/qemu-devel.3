Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70BCC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyC-0005OA-HI; Tue, 28 Jul 2026 08:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyB-0005MQ-0A
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy9-00032b-5M
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso46714495e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241895; x=1785846695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=53t/PC/IOFLB1bZ1tVW3ef3eYmULen1B96mTJRH3Ugk=;
 b=qFbFHY1fyFe4fANfVfHQ4LPumvNuzGIUa0gVUAyTUKak/SdH3/b9/cXhUwZRDh7C9k
 5qWKnv0bz7/K32dFNarUwows8TQxer1UyxCSipIpALbZst9yykB597Ah/N8EuzZ2/KD7
 chUkVRhO1hAIUmPv9p8ZEE88FuNpPLBatWNPfuw9ZNiyBPwfeGiffPjau9jzEd/28Cx9
 zqkhacYXwR9ecWVCXhluD/MViOyHCT379kGamwoRmvli2wyXsPQ/IgtDALrn7z9q+47N
 kXJx9kwALoBnhA3yXJfVRla8MpedKE/x0NwsDr2qeSPegZ7VkNdUt/pLiznJbFo4jRt6
 p/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241895; x=1785846695;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=53t/PC/IOFLB1bZ1tVW3ef3eYmULen1B96mTJRH3Ugk=;
 b=SPRECNnnmmvdCgENzSi1JSPDZbI/utm2HbDobQ3DOgPbWurKe5E8UwqhiOFK1mmwic
 jROaT1reH50QdBvtHCGm1a5+okh0SbUmwJ5hWZMyUYLP7Dxz1FmiiyrO9W8xDCEFbbB1
 wCNn9aYGT4l8qn6NqSyb3b8rOLbeSlXgfutSfTPRG+3qZB4s3j5DVtIYK+KxBRKedLBI
 BHP8U91pwnifcYaJvTCZpAUSbOBfVx54SO3v46e4cJ7UkoK2fJ2uSy/PURpKSmul8sXU
 9mg2VLxGDZWad1dznn+o8t+R6+oeehGp9NmKwTUhDcDyor5JpJFQ8LurPFOw319PIZ6n
 rRjA==
X-Gm-Message-State: AOJu0YxPhWF72ol2poGYEfWyFQB2xo8yz9Gu6p2c1Etctk9WZdYennK7
 CvpPmZZvizYqwmt7LvXeeWQKtT+BzBG/lTGHsv7906i8nOdOnNX0SnKBJYHCeBLGHJ8hHrQnUAn
 KwBhg
X-Gm-Gg: AR+sD12TanT5Ru8fxJkRU7QGf7WrPMhG8ElMjI0bfhgTaE1AtrDeYnCNEy76YC46t5c
 /VhvZKp4AonPecrGB7estgdWATlqoDJhs/OKlAhwOji06xl069xvIN16s88z3o0n9R8UMeGUBFr
 WBZMONauri2mrT5zWumOrfp8J7ldV8qTtc0UnJNMZpBFb7eLuhJAESNCma1CRleVo/oOq6RGFH3
 T/ax71FeL6a2FoUMzHeIsbvDnnPsfx6nkcaxmaOlwzhayBdtBR7NgecOHWZnJi6Ax8Yt5pg0MHP
 4eOnov1OJ7nxS5IYfj5guifI5yQXMHyMw1MMM2a6PxLZ+/gDXgaMtD0egPNzFHAoFn71CnrBgS6
 EOASH6kHxyBKvzScDaW+RWY6Sdc3xmZYVu+ArhWbxymm0Qb1nsLVVvI1IGnX+h8DwR8SDFHR6xX
 C5WQq/dkKFdLfzzuOMU7D0/VftB6w4AmvLmmAp9vpEV2XPL1OgJJuujfWRnFKUa+QVgoI+1K5uC
 ZGLVPp8rgg=
X-Received: by 2002:a05:6000:310a:b0:46d:8169:bb39 with SMTP id
 ffacd0b85a97d-47fb1ecd5damr2570721f8f.37.1785241895541; 
 Tue, 28 Jul 2026 05:31:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] hw/net/flexcan: Drop unused RX FIFO register overlay
Date: Tue, 28 Jul 2026 13:31:13 +0100
Message-ID: <20260728123127.1711653-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Remove the unused `FlexcanRegsRXFifo` union view now that FIFO accesses
use the underlying `mbs[]` array directly.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260723070059.6332-3-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/flexcan.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index 32de7b904af..d8159475e04 100644
--- a/include/hw/net/flexcan.h
+++ b/include/hw/net/flexcan.h
@@ -35,16 +35,6 @@ typedef struct FlexcanRegsMessageBuffer {
     uint32_t data[2];
 } FlexcanRegsMessageBuffer;
 
-/* RX FIFO view of message buffer registers */
-typedef struct FlexcanRegsRXFifo {
-    /* 6 message buffer deep queue, queue back first */
-    FlexcanRegsMessageBuffer mb_back;
-    FlexcanRegsMessageBuffer mbs_queue[FLEXCAN_FIFO_DEPTH - 1];
-
-    /* number of filter elements active depends on ctrl2 | FLEXCAN_CTRL2_RFFN */
-    uint32_t                 filter_table_els[128];
-} FlexcanRegsRXFifo;
-
 /* FlexCAN register in hw layout */
 typedef struct FlexcanRegs {
     uint32_t mcr;                /* 0x00 */
@@ -78,7 +68,6 @@ typedef struct FlexcanRegs {
     union {                      /* 0x80 - not affected by soft reset */
         uint32_t mb[sizeof(FlexcanRegsMessageBuffer) * FLEXCAN_MAILBOX_COUNT];
         FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
-        FlexcanRegsRXFifo fifo;
     };
     uint32_t _reserved4[256];    /* 0x480 */
     uint32_t rximr[64];          /* 0x880 - not affected by soft reset */
-- 
2.43.0


