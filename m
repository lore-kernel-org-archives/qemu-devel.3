Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A17C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvBs-0001TF-Ae; Tue, 25 Feb 2025 08:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvBk-0001Sa-9z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:41:32 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvBi-0002SK-Qz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:41:32 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6fb7d64908fso47661207b3.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 05:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740490889; x=1741095689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Pi79nxp9yRcvsypxDsQKDeReeaW2VFDHpsIWhblTY4=;
 b=PR1pVtwfQzMczGrAHTMp7/UPqsfR/+MP1RulRFS2cPEc0m4JaC7chBeXGAGb+D+FoS
 AdArjnd7bLdMWAac6QCgFsdmSfBs2MNG+NSuyDQ773GNWUAeXcyU2Ahgot/eji2KR5Du
 6kJu2MovjIw13NfUonFc2ttdpVW0GCCL0zYsl1i9MM1Ab9uqNveQ5FzTlHfJxXPyV7bk
 i9prh45dlEHz2fyb657a55PuD1XZXB7/y+K4XYKkNnFS4EcEMlerXT3F9g2iGrTHphEV
 dkIEqvNlTPKtvdnw8BRrlzjiTPX0ODaNyIQGpqJnyut+am+EVo0RsckeH51ooE7wrdXl
 vvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740490889; x=1741095689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Pi79nxp9yRcvsypxDsQKDeReeaW2VFDHpsIWhblTY4=;
 b=WBMho99TiqIrbHwyC1nYn7xPe4OFBNsmb6b7uROeAxwZ+yyvZFtBEMvsx5MPHS6Uef
 NdAwd0qhvVg4rUJw6k96XJ4KjjI/+vs9DnH4btRoHNMoXXMOGGwHMkkK7KoqQPKHZmLy
 SX34p/dwujIMD4B4q1K46mAoGodEL1ekCVMPRj7A8ejD4p1cns+mdvbDmGLPGA2ZhoR0
 12FNU9+287YRSG4zZAqBRohxVDFAbjUUCtpu0XWN+EXPboZND4ao+PNBXFhS/RFDcZXY
 C+PRk3sNWyyl161auZwqSd9C6k2sn15PvnUNg9e28281ySxRZlAFlqraiGUrw1nGxpKK
 EmHg==
X-Gm-Message-State: AOJu0YzX3ZmJq1b19kr3ZV0wdTT3IDHXq+zXNUaB+RUrLTYzgk05zn26
 OnMbvWRoawr4fsSF0cbFbFjeXmBKsNPnFenEvsYiNhrosVWXNxoh1mTtlvkPq6jlzI2FN0YrnZW
 WIQKNrBbMCSGGmcROkkiOya57a9ZKagW0Vgg+1Q==
X-Gm-Gg: ASbGncvYxh4eD4Fws3HuGPTANdQ+H4+edRnpvqZ5KHjGM5DDFP3OYiQVicPr/vD71lZ
 LdiRftSqbSz5T+GPfoil/WSdjzRHfmfa9NTrNjM/1W2N9RUgb2q3vkxcXfgOEe6sndYsG9cicPy
 /jqdNvf1az
X-Google-Smtp-Source: AGHT+IGpRAUXfFql/J0ND5ANPGYKAfS8IXWTTZXKTxWI5ImgBOk3q+IQjfHiJtEb4ykQUpx3gko/R78YsflsMP5blQU=
X-Received: by 2002:a05:690c:7306:b0:6f8:cedc:570d with SMTP id
 00721157ae682-6fbcc1ec613mr157750227b3.6.1740490889274; Tue, 25 Feb 2025
 05:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 13:41:18 +0000
X-Gm-Features: AWEUYZn2_0AGYG0NJBtP21sNGm1KEn1x-rzEPAgZUmackG5pDveJCDIo4syuXXQ
Message-ID: <CAFEAcA_sz-_6WGCQ=4kC2vtK2RUBXbAtMVzh3iZsp0xmNbgaxQ@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/npcm_clk: fix buffer-overflow
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, titusr@google.com, hskinnemoen@google.com, 
 wuhaotsh@google.com, qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 24 Feb 2025 at 20:51, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Regression introduced by cf76c4
> (hw/misc: Add nr_regs and cold_reset_values to NPCM CLK)
>
> cold_reset_values has a different size, depending on device used
> (NPCM7xx vs NPCM8xx). However, s->regs has a fixed size, which matches
> NPCM8xx. Thus, when initializing a NPCM7xx, we go past cold_reset_values
> ending.


> diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
> index d1f29759d59..0e85974cf96 100644
> --- a/hw/misc/npcm_clk.c
> +++ b/hw/misc/npcm_clk.c
> @@ -964,8 +964,9 @@ static void npcm_clk_enter_reset(Object *obj, ResetType type)
>      NPCMCLKState *s = NPCM_CLK(obj);
>      NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
>
> -    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
> -    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
> +    size_t sizeof_regs = c->nr_regs * sizeof(uint32_t);
> +    g_assert(sizeof(s->regs) >= sizeof_regs);
> +    memcpy(s->regs, c->cold_reset_values, sizeof_regs);
>      s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      npcm7xx_clk_update_all_clocks(s);
>      /*

Whoops, thanks for catching this. Applied to target-arm.next, thanks.

(Looking more closely at the cold_reset_values handling
in npcm_gcr.c, that looks not quite right in a different
way; I'll send a reply to that patch email about that.)

-- PMM

