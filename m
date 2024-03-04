Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53005C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5lp-0005Xl-Sj; Mon, 04 Mar 2024 05:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh5lo-0005VU-43
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:42:08 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh5lm-0003mI-Ji
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:42:07 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-566adfeced4so4350124a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709548924; x=1710153724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EjLkmn4Jw88Be2lNSETLjKfywgeAWRZQl7FiCmTVJao=;
 b=NUHA8GuBz0HyRaDqp45R0FIh523g/zUumiXTBdruObiEI9ZBT8w0ieWVBdEmZrVa0w
 KbXzBwBFIGw/Xggpp1+ZwPmb44rs/OIdgzNOGJ0xcLt/MDxx2cmTx++20okG4tGuyZ2R
 ZQ/gtssIl9MUkAqWPXb6l10VyZ9NuQEk/qlz+VGnz2RtkzWO990+nT8GYjQCbTIlfcfD
 W+Xa2RqEwF4n6ZowAUDy7+O226Ij4jTd/bpcNl3dK+MdnTE7bEend1FnTGPujL24WAdb
 j8j4RpeGAY2DskIzlgwq9xOsVKRwTFqtT57trqi7tj/5JQTf5hKdCij6Yux3V6bAeSUH
 PD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709548924; x=1710153724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EjLkmn4Jw88Be2lNSETLjKfywgeAWRZQl7FiCmTVJao=;
 b=vD7OKpMyDBuGmJS9jVuOqrCHoMGcFktx6zXpGztXy6+p9ovWaY988rWwZuprthAaiO
 VDKoCSK5P+GxMjilHwu7BoVBNiFkK/v/5g1GfAIjzmTzI7bIOVNnwMYvlqHl91vOlvRj
 ac0XOQUPUrTbF1V8M9HZ4X9k2RWKM4AYgI5YJA9n2Zd3eRDbpeFRAkc99L/On4Gpma6N
 VaZ8lxmd1RK/By1TTdhgivVNsg5ZBmEps6cs1S88I8EYCZx6NyKi1tp2h30gJYIrgfMM
 8EGCSzuOBQqxf1P5x5p4zdRZhEQFJKJXLaIo3ivQdEPbo9JQFFKjXoEEEGLAwsaZ8tDG
 yb6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF1bX2M7Oq7XCVjRVwOVyQYvb539fl8cWHQ/Yw2u/rWYlbIC/74vCeyxVozjzM199randxAIUAg0uhjq0yYdirsYSU/xs=
X-Gm-Message-State: AOJu0YxiiLat+6dQPRBkIRUYasHK6bFHe4CLrzh7HJF+2LTGic031fRd
 uT4yMpkbNgFaVpFqzerRvIHHX5IFtQeeOF1YZa7CvebLsIJuUw2lJbjLiLxqBI3xbuvL+R6xhaX
 TgmTYJv1luLpBDADNW/dvqSFsUC6Jj120qE9x/w==
X-Google-Smtp-Source: AGHT+IHg9ma/DaqX4tgFT+nrP1I5lP22rxL6wCOLthmDTsQXYB/2iBPj86FVYpVbsemGyK66ngYy7cmILEA7iqmk1LU=
X-Received: by 2002:a05:6402:2152:b0:565:7c8d:5790 with SMTP id
 bq18-20020a056402215200b005657c8d5790mr5793845edb.4.1709548924454; Mon, 04
 Mar 2024 02:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20240304-common-v1-1-1a2005d1f350@daynix.com>
In-Reply-To: <20240304-common-v1-1-1a2005d1f350@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 10:41:52 +0000
Message-ID: <CAFEAcA_-B46tABOTD=9PBQ1Kt2farT9RPRnMGrEEY=ytcVmmUg@mail.gmail.com>
Subject: Re: [PATCH] meson: Remove --warn-common ldflag
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
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

On Sun, 3 Mar 2024 at 16:26, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> --warn-common ldflag causes warnings for multiple definitions of
> ___asan_globals_registered when enabling AddressSanitizer with clang.
> The warning is somewhat obsolete so just remove it.
>
> The common block is used to allow duplicate definitions of uninitialized
> global variables. In the past, GCC and clang used to place such
> variables in a common block by default, which prevented programmers for
> noticing accidental duplicate definitions. Commit 49237acdb725 ("Enable
> ld flag --warn-common") added --warn-common ldflag so that ld warns in
> such a case.
>
> Today, both of GCC and clang don't use common blocks by default[1][2] so
> any remaining use of common blocks should be intentional. Remove
> --warn-common ldflag to suppress warnings for intentional use of
> common blocks.

We also explicitly turn off the common block with -fno-common
(since commit 4c288acbd6b9e, 2014).

thanks
-- PMM

