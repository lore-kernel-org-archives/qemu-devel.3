Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218D2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjj9n-0001zg-98; Mon, 11 Mar 2024 13:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjj9k-0001z8-9k
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:09:45 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjj9g-0000Gf-T1
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:09:43 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so6137174a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710176979; x=1710781779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5+atn9B3k6GCR2P47c0TyLerksbvp/JaJLuNOJ5IHBs=;
 b=AXiLZ1QV/mSOvnDRaDdjNqpzZxDH2XvtAFyU951YZviZjn6moZclVsxVI7TmgcYfmN
 P0z8L8dJ3tfjGpFGQXd8Ud9Uixhks/y24+/1FYQaDIYsmt6xNefMEbh5utSdiz1f7OsW
 Ve3SK2ZoJ2DphWtaFkTPxOaUPdLF2cIqYEkUdqxAeKCHJY3D2a8E8/b7vt4FVuIipAKb
 fl2w2UdsA3u4CljaRRZqT1++Xz0oKcxGBwN3HcQlIrmz3fJxde1RX9k0EWHbvGdDPX1h
 dUGDkkYkeDNb3Xm+2YLpk2Ni7eoZyZ7FBFF7QHa/E6JkKbVkwneyfVYR+APS8wkhIsg/
 mCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710176979; x=1710781779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+atn9B3k6GCR2P47c0TyLerksbvp/JaJLuNOJ5IHBs=;
 b=awMzblV8y1Kdp3i+aTc4s2Kii+ZZ08LuvddppjeJQc8rcx7lu/JO91OujhGpRhbhGM
 J7+xnwzFqsxRs3zzBeUPDbZYoBfg/u4nYiXPwPQ1S9joP5cUTNO5ib9rLNGq2oy+aZqN
 WNwSeJFUpDQSWSGEbKjEMKQ5mBXjs6hHZ1k3nHBgFNPNvCeUqHpI0BRDnNA3pDnDfxoj
 qcDkTMHVdx8eLTOhtp6hHFrekjg7CHaH0AGA53x9Q4Cb7uxxshWka3mdJ2ivbkfaSIrb
 kdvbYIxDpQEESWboVf8U+Ve4eWWJvwrXiKvw2T1oyNE4HJk0XkZ02pAhn847Oa3If/st
 EodQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTYri8NfsYomVkcSn4D2bjMynGY+VOoWW9bAqG112/7MReyPiEfzS3r5bltZvnPrVIEOTd7Nh78GKjnwlQK0BtTovYZhk=
X-Gm-Message-State: AOJu0YxKRaMuuonek+u7xgKQVyTZN1Yt8CiHO8jHgCTtraCqiTzMC4yQ
 rQ5XIROuBkQu8BL9m3bWEXKORFCn+LrlO/gL3pKpDTmturnkidDKYYoljRZXnmciCERDxr/gPco
 j/ET7Qfvy7/UNU8/L3vbUltZxESC0x8PqG28L2Q==
X-Google-Smtp-Source: AGHT+IFfrjxfuip2SxkEjrG72qEazSt07c7smC1BISZChoQXKvSKzT8ClBj3Wg/llcxCXwwdSaZg9B6HB7aar0/9poY=
X-Received: by 2002:a50:9e25:0:b0:567:a37a:4c95 with SMTP id
 z34-20020a509e25000000b00567a37a4c95mr4539140ede.42.1710176979079; Mon, 11
 Mar 2024 10:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2024 17:09:27 +0000
Message-ID: <CAFEAcA9M8UcYgafbmcrrYpLgD6v_uGxVd1Re5G_4bjd3vHNR1A@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] contrib/elf2dmp: Improve robustness
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 7 Mar 2024 at 10:20, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> elf2dmp sometimes fails to work with partially corrupted dumps, and also
> emits warnings when sanitizers are in use. This series are collections
> of changes to improve the situation.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Thanks for this -- I've taken it via target-arm.next since I
want to make another pullreq for softfreeze anyway.

I didn't take the "Build only for little endian host" patch. I thought
about it, and decided that on balance it was probably best not to:
in practice we haven't had anybody say "I tried to run this on a BE
host and it didn't work" (unsurprising, most users especially of Windows
VMs will be on LE hosts), and if we do stop building it for BE this
seems like it might well create work for downstream distros who might
have to make their package creation deal with "this binary doesn't
get built on these hosts" (and then remove that handling again in future
if we ever fix the endianness bugs).

thanks
-- PMM

