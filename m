Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E500C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLy8-0007k2-Bq; Fri, 26 Jan 2024 08:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLxz-0007jV-PM
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:09:56 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLxy-0001lY-3G
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:09:55 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cf42ca9bb2so5164061fa.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706274592; x=1706879392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SN9PmPew6KJXfWNQk+okgUHo88ml+w31lIrTZuyUzvU=;
 b=fpMMWPLqmely3TKhiSkUjj/rsDScZCY1bHBmgkgf4xr6kS6IFU0521LHCM1RCTLL6r
 9MebXxVOtokY5odtioZ28Tc14xia/jEGsmFREH9t7cGar5m9r1l19WcUdeKhSLCa1oRR
 oOYsjW3YcQQD+NkMf5J9Htqycioe/5Z3FibZwlLKF135jGJWHwVYD1EOAHzMfay+MmAP
 SryS748Xv484onFEJlRuvMn+k3QVubTo0cPI0j58wXvHbUpwrv2LrRB74cWVBVyGgpfj
 OlrnG4xqM6GXbWmGPpOeXZlAcrrO8bpW54Oeti3XPVlG3x6egqWf/dOkhaasCkouHAAp
 grlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706274592; x=1706879392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SN9PmPew6KJXfWNQk+okgUHo88ml+w31lIrTZuyUzvU=;
 b=vBxLkMZdcFhnj0zdiRA95QS/Vy9roQ6um68oYgU4uqGJWhrMLQzrXYtqf6gIaWU7DS
 gLCvqZ7pc1fOSRIlmaie11gF9Y3g3pJzjrqHvddzwAR0/MnRwBuoPd6X/fIGTkPUoLhR
 8daXuJjpJ8ejYHpQS0gHbrOYBZVKWkyQco1se7Mul47Uw9bkUv9aaOlFRPBiClHrpuBA
 jX0bgKYB+2hvAuKBs4d7ka+qpkFTvJJ5ivjrdYANSzIHQYUPWtU7+quZR6XxqZJdz7Ne
 HESf7YaHQrSLckcSkd8t490LYzstIj9zRkGPvISHXkqhSynodnp7NWkZTpO7OEf+kuoz
 oO8g==
X-Gm-Message-State: AOJu0YwVHC6W1IC21T4PAnFdmjUU8P8lc8IXh2PfcD0hy740LRu76M0e
 ELc/KwfOYGjVw8WBhcu6mfLmrmeA0/IJFoOx0wsiblY2dXjmF1hydh1N7Et5Yv9XqjBM1atLvu4
 gNNZCKKJ7yem14nvt8MSwMKj7TUPOl4UMS2A6u8d4NpWopL7T
X-Google-Smtp-Source: AGHT+IGkzL6+UZs8AE2pESIPZHyw/TWUbsZVTJ31L0kx8D/lEAg/+yr9i/aXaSjtUrSwoIoD8vdMK++UxFpVjSr6LpY=
X-Received: by 2002:a2e:904e:0:b0:2cf:4d5d:3ab2 with SMTP id
 n14-20020a2e904e000000b002cf4d5d3ab2mr193668ljg.66.1706274592009; Fri, 26 Jan
 2024 05:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20240125071537.53397-1-gaosong@loongson.cn>
In-Reply-To: <20240125071537.53397-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 13:09:41 +0000
Message-ID: <CAFEAcA_pn08qBrzmBMSuBv+ZhmVX7=ObhfTCvGa2D1eMbP15Sg@mail.gmail.com>
Subject: Re: [PULL 0/2] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 25 Jan 2024 at 07:31, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 4a4efae44f19528589204581e9e2fab69c5d39aa:
>
>   Merge tag 'pull-hex-20240121' of https://github.com/quic/qemu into staging (2024-01-23 13:40:45 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240125
>
> for you to fetch changes up to fc70099621fe7002d30fc1509456d1ae57264aa6:
>
>   target/loongarch/kvm: Enable LSX/LASX extension (2024-01-25 15:25:31 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240125
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

