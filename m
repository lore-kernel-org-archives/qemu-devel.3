Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D98C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLiey-0007Oo-CN; Mon, 24 Jun 2024 08:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLiev-0007O0-IV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:18:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLier-00013F-Ek
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:18:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so5133518a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719231531; x=1719836331; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BB9DMwRqGzAcRENqpw1dCqUIDzOYjuf8OXy4togdbos=;
 b=W0rjN5lJt1VrYQH5Lx/2Fm0Qjg2lGZ4henmeMjQLyf1SoLGoGEc8w/8RfPiX7QLc0m
 Gk7sFPm0rETuOnHpIQ2GScQCoH5snlgmk80DH2j9tXczqdssgh7ImTCV+Gk/KdC6HpGV
 Gu535qcvcq7embBvif9KKCKtMjxxRDnWmSt/OHDa5O+Ak21HVbW0WB4Itxnw/TzcIBNh
 8NRYzhQ0dkFPWconGTJZq5Y6bkJiemcFXGVZ5+MDWFqEAEdiiLSlRJI7mPyyVU4oehYz
 P9VOAeiBPxJISbGclnCeUyzhSOt6L79KbwTMfleBrmpkEYrxS6RpkcfXRcqjdsaTjmRG
 g+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719231531; x=1719836331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BB9DMwRqGzAcRENqpw1dCqUIDzOYjuf8OXy4togdbos=;
 b=jmsftx2FcQr0bLBjyiJ4OE44RG5dTBBWSx/kOKqorDgnww4U3ReC4VYwn3Ik1DpSXB
 S3UUPeWVLnErRe7tMrwxQ14zSNqHwT1e7PujKJ54zOfP4RGsy/jyMkv554K9W1uurang
 BnAeo17fOrNCkXKpDvqzGrVE1Zmr49oUUYRvbbK35TmNUxxmzTn3peTO46jTrJOhLck5
 Qp2DKkdEeTF4EezPGgv7DHJ9v7m1FFBH20XmT+RX/S+W8VNYNMWey8EBn0KdwAVrAXgz
 Kbl5w9cE7ZfMyHMuFagGKT+cTm8kVXI9CKThFfLD6uvxU31RDTUEpTvhCq62KEIhWZB5
 WEHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJsZhvadXTgRcv9rIIqkPKO+ZQpZpk/+kHa2AGCa3bKNdc77JG0wTb5TDT0Uroyw4ntcYeHuNg0L37qF1V4TCMvg0QLQU=
X-Gm-Message-State: AOJu0YykeX1PlyXSGPN4MvumyOvKKVaGQph6gaWqpqs7IgoLgzjtWeSH
 9afspg5Da/u0NjD0kScvewdtem8WSTMDU7kM9B2R8w7Eo0JiOh09PzYBSWcVawJ8BkILUNTLNtd
 yQTHoT67aEhFFApgYzubJYgRuQ9/T+7ZPQCp5pA==
X-Google-Smtp-Source: AGHT+IFUqnGUj+m9mLdbEB1INhNZQv5b5C1BIbclKCjz5PONf1bUpgQ5SZMPCjnw3UQZuR00+LGDXDD+r1HzsgwPAgw=
X-Received: by 2002:a50:cdd5:0:b0:57d:788:aaa2 with SMTP id
 4fb4d7f45d1cf-57d4bd53410mr2795875a12.8.1719231530730; Mon, 24 Jun 2024
 05:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240619093508.2528537-1-jamin_lin@aspeedtech.com>
 <20240619093508.2528537-2-jamin_lin@aspeedtech.com>
In-Reply-To: <20240619093508.2528537-2-jamin_lin@aspeedtech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 13:18:39 +0100
Message-ID: <CAFEAcA8tTHusKOR7JhyU+wwA3JJWq1o5wVaNXugw2S9SjAsESw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] aspeed/soc: fix coverity issue
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 19 Jun 2024 at 10:35, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>
> Fix coverity defect: DIVIDE_BY_ZERO.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/arm/aspeed_ast27x0.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index b6876b4862..d14a46df6f 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -211,6 +211,12 @@ static void aspeed_ram_capacity_write(void *opaque, hwaddr addr, uint64_t data,
>      ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
>                                          &error_abort);
>
> +    if (!ram_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: ram_size is zero",  __func__);
> +        return;
> +    }
> +

Isn't this a QEMU bug rather than a guest error? The
RAM size presumably should never be zero unless the board
set the ram-size property on the SDMC incorrectly. So the
SDMC device should check (and return an error from its realize
method) that the ram-size property is valid, and then here
we can just assert(ram_size != 0).

thanks
-- PMM

