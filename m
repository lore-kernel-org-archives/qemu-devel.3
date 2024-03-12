Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F11C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzwt-0006E1-89; Tue, 12 Mar 2024 07:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzws-0006Ds-5p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:05:34 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzwq-0004Wp-C3
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:05:33 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-568307fe62eso5421532a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710241530; x=1710846330; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ns/D/GEbg+1EaTTfRx4jrWC5lSquljI+6HiF884RLvU=;
 b=Xk43gGrttHSZ26qAy+QR1hlG11q4hWrn+Yruvuf6RtfyOnVK9+4mTu+CCYWnuV+weO
 2lS+SIsfCdQ6FerROUj1kTtqrNE0vulQEZy9ZO7rAGpm5BivRTqEhLRiezqK0meV0q5V
 AiuYL/3mZmBUs24zaiGcrXkdZcvrlpdAZM9c1hqyeoBqpoVuTUrDCitTgP2b8vyQSLNr
 Y75L2MLtri8RZJrvBgnKWKU94A5bj+Vj90oU5AJYjmE+Ed+4fyow5NyXhrt+HK+tBRAL
 x3KW2xPbRkDov42neKBtLUs3MsYYrgLYtDr/2h7p38FKSqbABMANzUYvdChXg388OlGE
 S4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710241530; x=1710846330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ns/D/GEbg+1EaTTfRx4jrWC5lSquljI+6HiF884RLvU=;
 b=K72LlIwjW6o/FYnegUrDiSN88CYNXze/iRWIG1bP2CkLs57p69IYIWY1osQfuqY0L+
 hnaOQfuraIEA+gE8e2kuYE3tXATZSOnjYQiFcsFfNBvNfpLfQrscJGyE6x3B3of8vkxS
 2qUTnIc1Mpql1ESQJW3dvEyi1t7dZL1SdHOO0SUC38BzVoEBNmLprKZPU4CJWwvLBPQR
 mhOaYbaKIMO45pZYHNpAjEA1QH9u96If/0mWSZRa9s9fC28PzmOTA98AD4ndngvSm20o
 ccEuQ0APitirb4fTLjUGAi+GhxJMBATBlyeJl31KZ8ehvkTmYgvjbgmQx/RS8TEdN/9R
 6+Zw==
X-Gm-Message-State: AOJu0Yy6jQr3Vd3YHEYgAwA6Jyiro3Oxe0g409vwmZ4owKLNj2CAm54r
 D1sMafDj/QFOChAPore57bzCGzNODqwTFKqAgEWGsrkQr7oMaj4B1iHCAPyYDxEPwOQnuSDHmWl
 IjZletYpKu7YegfAFRAfO3E/AqGZvSlarHKQ8/rJzqV1ecN+w
X-Google-Smtp-Source: AGHT+IHltc7pU83o9mj7u1mF4YlNhurjHr9Jp/QFtD+lmI4IJcLzCbsU5u8xUntH0OYXWfmz4aBhVrnnLKvgkMo7pUM=
X-Received: by 2002:a50:d495:0:b0:568:3004:c611 with SMTP id
 s21-20020a50d495000000b005683004c611mr5197993edi.42.1710241530193; Tue, 12
 Mar 2024 04:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240310191924.201680-1-clg@redhat.com>
In-Reply-To: <20240310191924.201680-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 11:05:19 +0000
Message-ID: <CAFEAcA853VG67nvAf0SNjaWcaVt2YqKSmwkcWoaREiggdLboDQ@mail.gmail.com>
Subject: Re: [PULL 0/2] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sun, 10 Mar 2024 at 19:20, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit cbccded4a2b5d685a426a437e25f67d3a375b2=
92:
>
>   Merge tag 'pull-riscv-to-apply-20240308-1' of https://github.com/alista=
ir23/qemu into staging (2024-03-08 11:47:01 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20240310
>
> for you to fetch changes up to 0cb51c183a91e882b10ead4ddf2321296a537c47:
>
>   vfio: allow cpr-reboot migration if suspended (2024-03-08 22:10:13 +010=
0)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Allow cpr-reboot for vfio
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

