Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD05C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4LYD-0002f9-Ae; Mon, 14 Apr 2025 11:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4LY0-0002dV-AX
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:16:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4LXy-0000y6-3d
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:16:31 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e60cfef9cfso7446587a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744643787; x=1745248587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VR6hr5Q8tZ9P51V6WO9fFP4WiUhTFfS9tVwAoP/OGN0=;
 b=fgn2/89/dLwmymixysga9W/BuVWLLk7CUWBGtL0MK0XTwmfevirRsR3AR5iDQIrsb0
 99JKhLma5wwWZY4EBwLtvSAfYyZ+FosStmVnJLj3oWKeTDvfqInF4I7CUsNgwJob5EuF
 0OFtl4dn2sqdWYjJ02UMpGzFG22nwrIaKasz97aIboxuSKegKaWLN3R2DXP9RISPz1by
 TuvWPCduqh73rZHdhzg/dk3tzVk2hAtygZYxbmdCfZcWzra5fsbKNPG8g/atmCYmkdaP
 erp6rjGpIh7BFzG5vBEr3WmUA3+KKhhi9NSui9wz1Y4XRRJ/y4k2oex2AwlV4C1sNx01
 qZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744643787; x=1745248587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VR6hr5Q8tZ9P51V6WO9fFP4WiUhTFfS9tVwAoP/OGN0=;
 b=GiFMaDKTf0AcPKQGk2ofWJgM/N3YbvLZGMRsso8qXbz27Xpah4MWoJSLhEOCfbM30E
 uZ0cHdcrQAHG/GykH2gkXZoT+9RZyTgHX71rXSRatvDQNiBLuSN/vKvUUF2BZ8RYInlL
 W+0HPNqarD+kX3bOKiSMLcNr/WFAfns0gVL+dmrWVLmxkkVgYC/haHb5/sfV8dF9BCKw
 nQveDjVDTD5vN1fXUbAGXmb+r8WRZBFrnkM36rQ26Ni+jXgEthUg2X9n40tLHsQXWelp
 ylY2eMnNAqXapvIq5/ss5kq4cd4wZaQ+becyqgNtbsRt/8zN0M3jCKKnvb5aYOpvskR3
 0FXg==
X-Gm-Message-State: AOJu0YwOqtBOiuKN1hOuJ565mJMjUmhs5T20f7MEGPfG91UugCIK3jQy
 oBQFp/tYXo2Md2ee6R3N8hueFo03mStiR+rysG9jAcRUSO2/eLcwh/tsbP4pu51YftCevj8ZY35
 nqYHKJlmQ2wRLxQUcFzD0Na8iFEc=
X-Gm-Gg: ASbGncs5oGML5epWMvy2ko+hppQPUbg+gAN/uLjwJs92qPFI1ldvS0kzbkwUv65MknC
 2f2NJ5u+f/ozqwBWKhEFD2ZKGGNKp7zFhF58KnqynjK2S9VcphyRZg5QE6JhAuFZSps9d0ypaD+
 yVw9gylJ4K+/GLUWhuPrzc
X-Google-Smtp-Source: AGHT+IGXuexUWm/g8sHuowdXAw8sePqZQfDRxBBYmLnsgjhT/1klF2L8UO412IRdWKBJEY3DCk7toesy4LPunC4x7u0=
X-Received: by 2002:a05:6402:51ce:b0:5e7:5b30:3c4f with SMTP id
 4fb4d7f45d1cf-5f36f77bab2mr10212484a12.14.1744643786885; Mon, 14 Apr 2025
 08:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250412164315.36161-1-richard.henderson@linaro.org>
In-Reply-To: <20250412164315.36161-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 14 Apr 2025 11:16:15 -0400
X-Gm-Features: ATxdqUGzX8yLcGiv70MfS1yAH2SdHDwGOksYqSx3_bpaeLN2WsQiB85fJwspuo0
Message-ID: <CAJSP0QWHv5uQ0n=re42+whWgPyASPThMYoT3VOqPbYY67fgE8g@mail.gmail.com>
Subject: Re: [PATCH for-10.0] docs: Document removal of 64-bit on 32-bit
 emulation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Apr 12, 2025 at 12:43=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With acce728cbc6c we disallowed configuring 64-bit guests on
> 32-bit hosts, but forgot to document that in removed-features.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/about/removed-features.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

Merged for 10.0 via Michael Tokarev's trivial patches pull request.

Stefan

>
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index 2527a91795..790a5e481c 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -858,6 +858,15 @@ QEMU.  Since all recent x86 hardware from the past >=
10 years is
>  capable of the 64-bit x86 extensions, a corresponding 64-bit OS should
>  be used instead.
>
> +32-bit hosts for 64-bit guests (removed in 10.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +In general, 32-bit hosts cannot support the memory space or atomicity
> +requirements of 64-bit guests.  Prior to 10.0, QEMU attempted to
> +work around the atomicity issues in system mode by running all vCPUs
> +in a single thread context; in user mode atomicity was simply broken.
> +From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit ho=
sts.
> +
>  Guest Emulator ISAs
>  -------------------
>
> --
> 2.43.0
>

