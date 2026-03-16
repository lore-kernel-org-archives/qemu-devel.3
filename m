Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A071FF4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PJ-0001Jg-RM; Mon, 16 Mar 2026 06:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PH-0001D7-Jx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PG-0003ey-2O
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so50330935e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657760; x=1774262560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QivXNglU3D5z845k4K3akybnT7x3kG0DcKlXXbcSIQU=;
 b=mmZl5ZU+Ba4BTveLi2Np/V3PcorntvD2Zj9CkBWi8QED6UZ+fFYfUea0tRgnO2GkHM
 OASJ/Ec1E0mH7niMh9qdwrQ4e/QF0thqmqJSmMDB+HmPSi4CimWl7Ms1fICfd5m28G/O
 41sLEz0g+Odd8ltr1fQL7yUJYk9dL5UrejI8r9CIzRl/m2E8ue0M34964Twhx9Esa6JT
 v/w4nU1Dw6wrjJeYXjhbsUG7JkeYNu+G999cAFVEKhuMavn952/mIgHn8q82j+DQNPh8
 pKoMEb6JbwTLt0xH7b+zDYm5h1u1yu66ravQI37dlNogRbLWvgZCoRFRdH9mnrLYx5bT
 Q4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657760; x=1774262560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QivXNglU3D5z845k4K3akybnT7x3kG0DcKlXXbcSIQU=;
 b=kJmgeO4a2H2siOKjTwvWcjx/uxpjkT4q/a4/SWmco+Gf2gReBcNTLkw7NxqYlIxLs5
 aGWM+x1ziBR++G+AUex7mIEcNWRkuoWJOBXZY/ELMhrmjCBXbH79Eh1mXuY+w00P6yIf
 kQJcChJug74iDapWvWDcYNYqf2xxyolKjwi5In1xn4a+5YlN8bYTfgq0zITRbveb1iTe
 sKeB97wwUhNJ3LITkh1+2Q86cdEpQCxk6iUn9GoMHOSZD6+fbm66pN+iH74eAWYqfL7t
 0NySteTp9R9UyWy2MkLnD3QRIPDG8jPmH73pffP7//epVmnwtpL1EKVMj0IM1qaJYp/L
 fiPQ==
X-Gm-Message-State: AOJu0YxKLE4sPZV2xU1NDOvReLyxoo1CpSMTMjkFfn1005QpBBdB9Gnz
 VkzavVwVOmol7jMrXX/79KS85BPqfL2no2Cgn1wG+5droIeDaxBewNAcIgko4hRw3qDxvdwpr/Z
 TACGY
X-Gm-Gg: ATEYQzyzMHIVg39diffgbngMeRgYnMUiv975gl8gNFjOxxQYSu7aZdG1rXyNNpC1U6q
 iIo8X6bvrQaPNoVZ1vjQwYqcdXtZmRks0zFePu4e9cATS+VmfZBuIUOAU8P1A6eK7IXSOU0k4/L
 Hro6xYthTJNu1/J9/BJ/YtWr0krZ2DLG2h0h7qpawunnR9YMHNgoIHK6oa6ri2Q1MbZ/nRcsPV1
 vLVmXXptGlhRxGjsIK5FwYdMCRakA2IqQhE4MCkC+FiSLOutLJrax5QUVf1ytTXbuq9Uv3+oRcd
 8svUEpkzn1X1I8OhrYYRpZuMeal+w+HpT3cGPshV5RuCg7PK+YPxst0ixJlB876H2YYmsxDvtmv
 nYNbXzHIw6WunpmEKM+CcoJ3z+kRl9BvHIOOMQShTKuVODL69IgU0Gy5gnc0qVJ3P+5xrjYKlls
 x2iY0P5oOW3Ikk12IvXdNlAie4A3WraySJwRPG+vFdVKsJ7vVubUXejAdu4hND5N2O1Z7IkxZTG
 tON6og=
X-Received: by 2002:a05:600d:6445:10b0:485:35a4:939c with SMTP id
 5b1f17b1804b1-4855670c0f4mr148884485e9.29.1773657760414; 
 Mon, 16 Mar 2026 03:42:40 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] hw/dma/pl080: Update interrupts after pl080_run()
Date: Mon, 16 Mar 2026 10:42:19 +0000
Message-ID: <20260316104230.836962-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In the codepath in pl080_write() where we run the DMA engine
after a change in the channel configuration register, we were
missing a pl080_update() call, which meant that we weren't
raising any interrupts generated by that DMA transfer.

A repro case for this is to program the PL080 and then
check the interrupt status by looking at the PL190 status
register, since the PL080 interrupt output is connected
to input 17 of the PL190. We look at the register value via
the QEMU monitor:

Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
    -device loader,addr=0x00000000,data=0x11223344,data-len=4 \
    -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
    -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
    -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
    -device loader,addr=0x1013010C,data=0x9e4bf001,data-len=4 \
    -device loader,addr=0x10130110,data=0x0000c001,data-len=4

Qemu monitor
    (qemu) xp /1wx 0x10140008
    10140008: 0x00000000

The correct result after this fix:
    (qemu) xp /1wx 0x10140008
    10140008: 0x00020000

Cc: qemu-stable@nongnu.org
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-id: 7584486ba62bc6d767c0d132dc843067f8c5efff.1773301927.git.dingtao0430@163.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: Adjusted commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/pl080.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 6262c3f3df..c6dc5c8efa 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -227,6 +227,7 @@ again:
         if (--s->running)
             s->running = 1;
     }
+    pl080_update(s);
 }
 
 static uint64_t pl080_read(void *opaque, hwaddr offset,
-- 
2.43.0


