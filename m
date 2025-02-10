Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85138C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 11:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRfM-0006Xt-2S; Mon, 10 Feb 2025 06:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thRfG-0006XE-J8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:09:22 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thRfE-0001T6-Ty
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:09:22 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e5b296611d1so4152232276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 03:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739185759; x=1739790559; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eK1jTOW4gcbM5QQ/4u/r3xN3SVV7OOLmtpQgGF+8Uio=;
 b=BjdjIy753aYCBqhMHN+zRqRwzIb+Jlj005X+S8CmjBPo2/Q9BoASMowJRNs2S+u6GG
 Al0FimlXasXMKCOdh6IvGTRECLp65AXNZb2pL0cA5yN/3B1sy9U6R5SYPxck8LDpv8y0
 TzXsXp0HCoxNsvD0c2iMCB5/oakIDTkP8P9gGHN2eb53eDqFB+4+/C2NNZq2IUp+DIhu
 MyfDknA5+eDHJKKxqpAj5OqdOUjH+zwWdX+p9KqgNjB8nUYIpR14Xf7A7kennATsi9Gl
 Vt2Z6TJy5uPeVAny5KY2fUOuYkja9VCFsh2D0/L06QpUjGhf1B8uv/ngvMPp1JCIM7CL
 dXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739185759; x=1739790559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eK1jTOW4gcbM5QQ/4u/r3xN3SVV7OOLmtpQgGF+8Uio=;
 b=pSdm46pUTu00ue3QcjbbCvNjNwyh8JgBKB1zXVW0QBVZyVft4jTOSC62GEHzJnwEH5
 +r311dDQZbyms4UAjqfDCcjelctfepZ5xk4kNXjYZN4JvX0dvKJ/mTYAJeCkfGSmadf9
 zlxQq0uH+VNn1qbjzXdOXil7zSpmOFkCmVHsP+XVZgzUPjaiJ1bjoy0oPWQgabnsCK1G
 XIF878ppwDPRehTyP6mTV5Yjgo883RQ0qjMzBVsA4mYyBFPrMTKgIgbHUCdmKj58LVDP
 groS24yO9fPmAN1alNJUSQQnpadk8rq5e3YyFkWB7AbPIjWMmoJEm0iFuLND1hHjbXE2
 1eSg==
X-Gm-Message-State: AOJu0YyXAE4AXFuCinEEruU5FpPkAMh7CM/kFW/CX5R7QuREDyMK7/MO
 uoiV/j/7PqMs1Mkc38ujOb2JB0SI5fqt3bC6wrTgSebWgtBI9TtnYiEweYW4h8Rf8ofxTI8+RA+
 3KjoIIMp5TGGS6L8xjYf6EAMeRbL53GhFi/gwkg==
X-Gm-Gg: ASbGncv8+qOOdTL5AMVvSRqZVvQf8GqFe81hbstyYholY1H2u/w23E884WENCfTpmpA
 VP9xpSOe5YVFu3Zyt2tB6njmVQJpzFG7+Dc8zflQ3zMGSAL67LR3iPOVqdbhbciOWX5YPL0zEIA
 ==
X-Google-Smtp-Source: AGHT+IER9fUAa5H8srVrMWBkMmRfclzQRx1uHNtqb1OW1YMTMqkBaUz4j5FDFbOompqbN7jNMqx9Icfwrb5sBoTNg7I=
X-Received: by 2002:a05:6902:230a:b0:e58:fd2:2cdb with SMTP id
 3f1490d57ef6-e5b46b9b8b0mr11496045276.7.1739185759623; Mon, 10 Feb 2025
 03:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-5-peter.maydell@linaro.org>
 <fd7e874a-9cb1-4b41-ad89-d9c34d9def5f@linaro.org>
In-Reply-To: <fd7e874a-9cb1-4b41-ad89-d9c34d9def5f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 11:09:08 +0000
X-Gm-Features: AWEUYZn0BTvpAki_Exuupby8LU1JQsxgzbzWBPeos-dhBp2AqBtL-kFKp5xMeaQ
Message-ID: <CAFEAcA-NQs+AuLK7Gu_AFfLQLgsxZHEy=H+LiwSJKimx0P1cXQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/mips/boston: Support dumpdtb monitor commands
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jia Liu <proljc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Mon, 10 Feb 2025 at 10:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 6/2/25 16:12, Peter Maydell wrote:
> > -int load_fit(const struct fit_loader *ldr, const char *filename, void =
*opaque);
> > +/**
> > + * load_fit: load a FIT format image
> > + * @ldr: structure defining board specific properties and hooks
> > + * @filename: image to load
> > + * @pfdt: pointer to update with address of FDT blob
>
> It is not clear this field is optional or mandatory.
>
> Looking at other docstrings, optional is not always precised,
> and code often consider optional if not precised. Mandatory is
> mentioned explicitly.

I did go back and forth while I was writing this on whether to
make it optional or not (and the versions where it is optional,
I had a note in the documentation about that). But there is exactly
one caller of this function, and that callsite wants to pass a
non-NULL pointer, so I ended up deciding that it was pointless
to make the argument optional and include the code to handle
"pfdt is NULL".

If you get it wrong you'll find out very quickly because your
code will segfault :-)

Generally we (should) say arguments are optional when they're
optional; in those cases we also should document what the behaviour
when they're omitted is. So I think "mandatory" is the default.
In this function, ldr and filename also are mandatory. If
we mark every mandatory argument as "mandatory" then we will
end up with a lot of boilerplate markup for most arguments,
I think.

> Could you update the documentation? Otherwise consider adding
> a non-NULL check.
>
> Either ways:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

thanks
-- PMM

