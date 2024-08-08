Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED415C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 13:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc3Iz-0004pX-Rw; Thu, 08 Aug 2024 09:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc3Iy-0004kA-Eo
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:35:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc3Iw-0007Cm-Tp
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:35:48 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a156557029so1181672a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723124145; x=1723728945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DnFj25yh+HBn+LTO471MSPWbwerXwFu0zprTjbKkPpc=;
 b=rIu6mlymdnQBn8l068FO3dFtTtKioexUnwlU60O4/qGpdD/BloayPiPltvUMaaoEpD
 A8oeIgAm9DrGO0leHqdNfOmf3Us6FmJ6XdjsYAlf3HOMul5TbBj7NLvkpBOykPgF42nm
 5GWzjgx/EJtNX5GIMqSdXu/FGwG+KE8hAn3Kks0hRgtgkUE95CKx5kGvrvWQyAq2SWrE
 1L/m+ozmT/jswxzEqLi9FRkyiHS+b0PPmbdrz0evg6/wn2W4x7KnFt1fvSqVnpZvv/7e
 Y+hvQskP6G+TTwzugFbhw4oihALJx6BUQZl8Xokz6HAohPqjc6Jvn/G+7QBw/DjT8kSD
 0Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723124145; x=1723728945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnFj25yh+HBn+LTO471MSPWbwerXwFu0zprTjbKkPpc=;
 b=Fd5Rx8BJ5phitEEsTtJZPNd6I5DUOLbKcFh930avPTniVvufIti67gUpTE3xV8EZsd
 WVyksU2DMUILUreLuXO1fngs8z3BpWJ3DpV2M04hX6lJwpvIsUv7FdB2bQfTa589p96A
 ERKw1qgBh1g69CTeNfzOb7gFrG+CC7utRp+juVfeBUuW82InKVZQv6PxWuB04XzqVAjf
 L5anSPbgdPj1qSDoI6doK2LukSDKCTXKiO8E8iwsXDO/ss+OsZlSmiau2jpLVU2+YluM
 +QYQiu75HD0+e/+yUy6jBTOIDrKRYx7TEIPpY0ve8ABbn4g8aQcCbB7JmK2h40/0L04v
 YETQ==
X-Gm-Message-State: AOJu0YwIWrnAEYEn52gPvwMib8mBj3BuvF/fCo0m/FB4jNRFaujgV3Cd
 kR4MLyKtWNS5Vfxq22pFRK65gkiFq1R2/sIbr+Ey6rDJv1DatC9/T1qvafV2/mjPO+0uh+uu0E7
 Mw0+oBpmSiugFAvS7h+/9b3x97IO1eoJyewHIXw==
X-Google-Smtp-Source: AGHT+IHn/skJrkLbnxIad14kLFzKzfY/ByW3TJuRLWNy3wfH3Y1SoeqLO5iHu3aJEH7KDugAo9ErIATgxaKy+bPGDuw=
X-Received: by 2002:a05:6402:51ca:b0:5aa:2a06:d325 with SMTP id
 4fb4d7f45d1cf-5bbb21f4159mr1355048a12.7.1723124145061; Thu, 08 Aug 2024
 06:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240801140609.26922-1-jim.shu@sifive.com>
 <20240801140609.26922-4-jim.shu@sifive.com>
In-Reply-To: <20240801140609.26922-4-jim.shu@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 14:35:34 +0100
Message-ID: <CAFEAcA-mvJyet3wjiTwwU22q6MSPO1pt+zWQ1fnjH8eGUfwEJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/net: xilinx_axienet: Fix DMA RX IRQ if ethernet
 disable RX
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 1 Aug 2024 at 15:08, Jim Shu <jim.shu@sifive.com> wrote:
>
> When AXI ethernet RX is disabled, it shouldn't send packets to AXI DMA,
> which may let AXI DMA to send RX full IRQs. It is aligned with real AXI
> DMA/ethernet IP behavior in the FPGA.
>
> Also, now ethernet RX blocks the RX packets when it is disabled. It
> should send and clear the remaining RX packets when enabling it.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

