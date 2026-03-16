Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA54CF4644C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PK-0001Nk-UV; Mon, 16 Mar 2026 06:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PJ-0001IO-9k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PH-0003fH-Mz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so40189735e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657761; x=1774262561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kelPWOF6pmkgPgzJacHMTl6GsWcX8RKLhqs0Nt6o2AY=;
 b=gtN49BIUzGpBU48ZbpOeNZja+1T6hlzcxMt+OzJWsknktcQlYnMjaCaV6vSATYoLzw
 e3Ig3YEmrTyP2UYtASzA0TY4qNBwYKMuolll6AQ5rHKr597v3n1gJO16RPhNANGLYwaX
 NT5ib5iBtfeBy1iiNXutxDFJQD5/oLp4MhrjO+kM/Xr9BA3P6+OUO6KWjVFTTGPyi3nN
 ilYKBF1PJ3xL0U3yU/gbW218RaKUyNt7Y4psJ1PI6T4Q2qwOpIX5YCGg8R6ZIUYhL1C0
 w9T4eMgMFwTqhYhzJMivgDDzzhdl749xQIuz837i8fIhrYT0uDMyWRIIyfkEKqmiiLFb
 FpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657761; x=1774262561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kelPWOF6pmkgPgzJacHMTl6GsWcX8RKLhqs0Nt6o2AY=;
 b=pOLacuaKkMUyq2T8aq2XYBhV3vWel0solLCqw5lRfYZBhOc2hy9fhBC/Uc+7BkMvxO
 Xqs8GTIx4oVTkNq7ADAHc2i6XYezwZqEYFooVzud8wTVuIG3ob36F++ZR8RvFQdL3IHD
 q1VH8x3Z2cvAZ8xwP4rMkNZ9JG28MlW8tdjKCRlWfqCfsi28FAfRSAbAESniOyrusSqr
 wgtwlp/UhNJbAY+bk+eHGryTwnraZ1agn5I4ScdnnCuOkFKj97pJmerq8MhVD6SSo47i
 dKXY+aKVEIt21UfwkzWBddiYvg43lg48EqKo3vL1uTFFVZHD6qaFwGbKyTKwwNFVPnPl
 TuCw==
X-Gm-Message-State: AOJu0YyEicUxeFZR8WK39YACN3bUbmsjSJksSyeo8Trn3Bav7tpsdr4S
 2E3jbFFt6mO6wKvIcIBummQp0LKJquh1PmVkLPFqKVR68LfINp5ZmwHVcflBZ/Uoz13ZZF8bw05
 /OsBw
X-Gm-Gg: ATEYQzwujHKSciGQPAud8G9pfW6Sbld1vofHDuFJugMzZJdEBjNSX/Q1HKTCody4Hv/
 QDUgq69sDWH9kofG4e3c7wb5dNFn2alKPFT1S1bb1wMktHkSGdpOiu/1cPhzLKRsYGggXujUTxE
 /8smekpb6qGpvI7PmoDlHtl010MkycnF8Q6uGv5N9OXkCqhrFu92tD+35EA8gtkb7FNVRYrOoMC
 byi2ZlvinUVa4EdOgSgRnJrz9H+GVdlB/AJAR7JJKPOzGK4BVWEF7J40oqb18pgMyQu7qpa8euX
 20t+E0nQQ4Oyw/2XDq6OjNKd0WaZUD2EUCfHRE7VUxcDXeD671mnqeEELnZ+7wHjMgxVjEetJ/p
 nZixBhIFoxraii0nJOpi4KJsjVL2BUV9SFdPVQDq6zwZ0ZlS7mMr7uxAQvrwgaOhPHbMMPR+qxd
 r0VVxqQS71FT0n7hkteRK6zDYynC5QwBVpSdAzmsfSo21CwdZsniTyZlr0Swev8hQQ8hRmZotiT
 zvGuNn0X4I=
X-Received: by 2002:a05:600c:3b04:b0:485:3c7f:527e with SMTP id
 5b1f17b1804b1-485566dd02emr189177655e9.15.1773657761308; 
 Mon, 16 Mar 2026 03:42:41 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] hw/dma/pl080: Ignore bottom 2 bits of LLI register
Date: Mon, 16 Mar 2026 10:42:20 +0000
Message-ID: <20260316104230.836962-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Tao Ding <dingtao0430@163.com>

The PL080 channel LLI (linked list item) register has bits [31:2] of
the address of the next LLI in bits [31:2], with bit [1] reserved
and bits [0] the AHB master select. We were incorrectly using the
whole register value as the address, which meant that if the guest
programmed something into the AHB master select bit we would use
an incorrect address, and read incorrect data from memory.

The following reproducer creates a setup which has bit 0 set in
an LLI value:

Configuration
    ../configure --target-list=arm-softmmu --enable-debug
Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
     -device loader,addr=0x00002000,data=0x00000004,data-len=4 \
     -device loader,addr=0x00002004,data=0x00001004,data-len=4 \
     -device loader,addr=0x00002008,data=0x00000000,data-len=4 \
     -device loader,addr=0x0000200c,data=0x9e4bf001,data-len=4 \
     -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
     -device loader,addr=0x00000004,data=0x88776655,data-len=4 \
     -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
     -device loader,addr=0x00001004,data=0x00000000,data-len=4 \
     -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
     -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
     -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
     -device loader,addr=0x10130108,data=0x00002001,data-len=4 \
     -device loader,addr=0x1013010C,data=0x1e4bf001,data-len=4 \
     -device loader,addr=0x10130110,data=0x0000c001,data-len=4

The correct result with this bug fix:
    (qemu) xp /1wx 0x00001000
     00001000: 0x44332211
    (qemu) xp /1wx 0x00001004
     00001004: 0x88776655

Cc: qemu-stable@nongnu.org
Signed-off-by: Tao Ding <dingtao0430@163.com>
[PMM: Adjusted commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: cb35c1b622674da7a2b70691402132f691933f2c.1773301927.git.dingtao0430@163.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/pl080.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index c6dc5c8efa..627ccbbd81 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -102,6 +102,7 @@ static void pl080_run(PL080State *s)
     int size;
     uint8_t buff[4];
     uint32_t req;
+    uint32_t next_lli;
 
     s->tc_mask = 0;
     for (c = 0; c < s->nchannels; c++) {
@@ -198,21 +199,22 @@ again:
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
-                if (ch->lli) {
+                next_lli = (ch->lli & ~3);
+                if (next_lli) {
                     ch->src = address_space_ldl_le(&s->downstream_as,
-                                                   ch->lli,
+                                                   next_lli,
                                                    MEMTXATTRS_UNSPECIFIED,
                                                    NULL);
                     ch->dest = address_space_ldl_le(&s->downstream_as,
-                                                    ch->lli + 4,
+                                                    next_lli + 4,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
                     ch->ctrl = address_space_ldl_le(&s->downstream_as,
-                                                    ch->lli + 12,
+                                                    next_lli + 12,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
                     ch->lli = address_space_ldl_le(&s->downstream_as,
-                                                   ch->lli + 8,
+                                                   next_lli + 8,
                                                    MEMTXATTRS_UNSPECIFIED,
                                                    NULL);
                 } else {
-- 
2.43.0


