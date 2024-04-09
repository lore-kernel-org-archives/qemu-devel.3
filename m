Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BB1C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruC5Y-0002o0-DC; Tue, 09 Apr 2024 10:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC5S-0002kq-Rs
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:04:34 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC5H-0005Em-BF
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:04:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a4644bde1d4so776963466b.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712671462; x=1713276262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=snqsNJuNjnpjq25haviFcnyUfxqKDdAR6m1sCavgQrw=;
 b=Vup1B33s6+CnkG2CI4Hx0rQwAlFOuGbRr2F40pj83z85rFUvYmYFr4+BudXjFyArBS
 zaKeo/XTtihgYnEMvjPpYLRlyG2Gx+aqv8zZX7a4/uDiVrXmG1r1msjXuBX1l9G7a+Go
 5JwvLmFq+4v2fGFt93y7uXdRJeDPnOjwdYXBDxhVbaorwwJEzGQ/XvMIAwEDZKsk+Foz
 emnVDSOhPzj5n48a/SYf/+lfsb+RBhut2pXUk0oFfvxFl/h+NdVAoSHtqHsGfUpnj+KR
 Qlt8vkB764n6RmuxhK5nmQVqWNg3GIQ438xCZbMTyS+S6OyNLNI+BxGm3CUwxstCh+o0
 NNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712671462; x=1713276262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=snqsNJuNjnpjq25haviFcnyUfxqKDdAR6m1sCavgQrw=;
 b=RtfIs+1uCGnVsdd2kp3/pHUj1QkG6NCUGPhQScNcsQJrW1Z9cP3LBLelR7SnzmIaah
 gPCTdFbrGLNc52P8K0ZzndOQlNPVWtrB+PxjY/H0PsyF+f1ergRS2vCU6f/hg5DDgubL
 KReq12k6P3tSfRAnPhpY8fno4bZdk3cJ+CkAWLkf1R5ySnz1ZKm1PrsJDCNGHqdVoE/P
 eDntro/xo4Bws/SABP9b97F6dY7M8iqZfw38NVGdKJA/rpal9+DbCcrqG1Si56ygshu5
 0Ni3Z5paMMNBxsrCpkXOdaP1hya3ffJae+54+VPoRlb8AT5gooHe85oYHGlYx1fI1Qrn
 agkg==
X-Gm-Message-State: AOJu0YxvQ82xFt3+gt5xT7eliP12S1RUKnF5OpydU3LgKuQ/eeOuow9A
 kJpBaLr67z2rh3YYkQxblQNVIsFy1ZTNW0ily6AtRJv1+VQhIzuQf3gZNxGY9cxdex+/lDZ98iw
 n
X-Google-Smtp-Source: AGHT+IF4QQqseTshtpPVZoauTzckILnYiVEOm/rNcqsd52BHAtnIZoxkYjvWPZreKUf9UB1iWx3tWA==
X-Received: by 2002:a17:907:948f:b0:a51:c71b:e1df with SMTP id
 dm15-20020a170907948f00b00a51c71be1dfmr5937719ejc.47.1712671461874; 
 Tue, 09 Apr 2024 07:04:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a170906468b00b00a51d408d446sm2795931ejr.26.2024.04.09.07.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 07:04:21 -0700 (PDT)
Message-ID: <2bf93771-5b70-4549-b7df-6021975f9008@linaro.org>
Date: Tue, 9 Apr 2024 16:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 0/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>,
 qemu-block@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Hanna Reitz <hreitz@redhat.com>
References: <20240409135944.24997-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240409135944.24997-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/4/24 15:59, Philippe Mathieu-Daudé wrote:
> Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446
> 
> Since v1:
> - Addressed Kevin trivial suggestions (unsigned offset)

$ git backport-diff
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, 
respectively

001/       3:[0009] [FC] 'hw/block/nand: Factor nand_load_iolen() method 
out'
002/       3:[0004] [FC] 'hw/block/nand: Have blk_load() return boolean 
indicating success'
003/       3:[----] [-C] 'hw/block/nand: Fix out-of-bound access in NAND 
block buffer'

$ git diff
diff --git a/hw/block/nand.c b/hw/block/nand.c
index d90dc965a1..e2433c25bd 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -88,7 +88,7 @@ struct NANDFlashState {
       * Returns %true when block containing (@addr + @offset) is
       * successfully loaded, otherwise %false.
       */
-    bool (*blk_load)(NANDFlashState *s, uint64_t addr, int offset);
+    bool (*blk_load)(NANDFlashState *s, uint64_t addr, unsigned offset);

      uint32_t ioaddr_vmstate;
  };
@@ -251,18 +251,21 @@ static inline void nand_pushio_byte(NANDFlashState 
*s, uint8_t value)
   * nand_load_block: Load block containing (s->addr + @offset).
   * Returns length of data available at @offset in this block.
   */
-static int nand_load_block(NANDFlashState *s, int offset)
+static unsigned nand_load_block(NANDFlashState *s, unsigned offset)
  {
-    int iolen;
+    unsigned iolen;

      if (!s->blk_load(s, s->addr, offset)) {
          return 0;
      }

-    iolen = (1 << s->page_shift) - offset;
+    iolen = (1 << s->page_shift);
      if (s->gnd) {
          iolen += 1 << s->oob_shift;
      }
+    assert(offset <= iolen);
+    iolen -= offset;
+
      return iolen;
  }

@@ -776,7 +779,7 @@ static void glue(nand_blk_erase_, 
NAND_PAGE_SIZE)(NANDFlashState *s)
  }

  static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
-                uint64_t addr, int offset)
+                uint64_t addr, unsigned offset)
  {
      if (PAGE(addr) >= s->pages) {
          return false;
---

> 
> Philippe Mathieu-Daudé (3):
>    hw/block/nand: Factor nand_load_iolen() method out
>    hw/block/nand: Have blk_load() take unsigned offset and return boolean
>    hw/block/nand: Fix out-of-bound access in NAND block buffer
> 
>   hw/block/nand.c | 55 ++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 38 insertions(+), 17 deletions(-)
> 


