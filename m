Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493EBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFS3-0005zQ-5K; Mon, 01 Jul 2024 07:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFRt-0005nG-OP
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:43:59 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFRl-0007gk-PL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:43:57 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d1d614049so177131a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719834227; x=1720439027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v/UoOU3lwclxAD1O5dzqYM8NliYIIji205Pxmk24KaM=;
 b=fAQu8sWPtKI7pHrE+fQRr9qrxphIXnbgZiS2Qi6sZ0u5xM71CEpGC3unwGui4IaGcW
 sHZsVsWsa6fiYw2zghBiQHcogSL655CJxb8AwBGCFQKCNOSncsdN7U9Qbt9Frd5ZSbaV
 kncmdNYeSskUnVnP6I2CEHh7Ad+gINO+cN7cySQJxIxbcgWMX843kvCp5tWAFdxjk2MS
 zB3eK1+JNquPOZBdQ99O1tsNeQlSMsGHsxR/oGNQOBe5ZYElXjlVQ9ofrB4XPcZaEy/H
 ta9aKI7vX8duL7yIs1VXUlmWN9JoKi3QyN5Aus5jPZmulfZBz58we2+TH85OK8Xg9fty
 +XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719834227; x=1720439027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v/UoOU3lwclxAD1O5dzqYM8NliYIIji205Pxmk24KaM=;
 b=UrI/Is49cRk2NGfgV+lsoUVfIyRdLN06zZFQ+4VXPG0gSHWC/GjUcILhiEzd8JUdxh
 x5VFNYHAlW8wo/3bPKsw4LJQQ4Kg1tNqhPbDRypmjxKJD6t8SdTuZIaYAmzxa1aY8ZmW
 a6zCOwhkDpeWz87qYOEba5zqyJQoqVCWpPoqsuhuNAbhjmo/92zJvQSmCMug7PN6D6no
 GZA1a7kVWOXFLSa+OiWngfKlbBmNfKSv0t6+OrGmCaLRWey4R6qM/7jt5USqFKMkW0xZ
 nprSwdj8c2CjUInz8AlKrmTS+tmYOqx662/gu/9/23LMUJNYxvYo2LK6+8aPRyf7tkmM
 EaKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3GbaWT2TKEYKQgGlzk/ifTsRGwjLpcpnSB8EF6ficlLCLK92ExEEo33W8i0v673qqdConEPc2wzWy8yVDAqh8/U6SVpk=
X-Gm-Message-State: AOJu0YwkE/+1eTKtNhdX4G0xN9JLVqixCWJ7v9KiIJ/h8WbXG7f053Bw
 0XAVvGhAU7fbDlSM9RCoxthJOb/SgnySnpppl0+6DY383XFXckWhOtLWKXnaem5PNp/qUe0hIH7
 u7K3IE4BVIw3S8Nv0GxDVDk55FHfjhXDNOgggog==
X-Google-Smtp-Source: AGHT+IHIqxOwBZEZkAVUl3UeA00jyNeq7b2XDELf6k0d5NnZ2y56FAwR0uRMs11HIAzHBEW80etsDKCtEY6tkaIWbEA=
X-Received: by 2002:a05:6402:4310:b0:57c:6f67:b173 with SMTP id
 4fb4d7f45d1cf-5879ede2a7amr4551140a12.2.1719834227285; Mon, 01 Jul 2024
 04:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
In-Reply-To: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 12:43:36 +0100
Message-ID: <CAFEAcA88ALQNOrdCmMV5z8mNN2hydarMwSx1P-43Hn7hEzca8A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Drop ifdef for macOS versions older than 12.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, 29 Jun 2024 at 07:26, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> macOS versions older than 12.0 are no longer supported.
>
> docs/about/build-platforms.rst says:
> > Support for the previous major version will be dropped 2 years after
> > the new major version is released or when the vendor itself drops
> > support, whichever comes first.
>
> macOS 12.0 was released 2021:
> https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/


Further, we have already dropped support for macos < 12
in the ui/cocoa.m code in commit 2d27c91e2b72ac.

For the whole series:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

PS: you don't need to put a signed-off-by line on the cover
letter, only in the individual patches.

thanks
-- PMM

