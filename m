Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CAFC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1l5-0003pn-Ed; Mon, 17 Feb 2025 09:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tk1l3-0003pZ-Lu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:06:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tk1kj-00079H-Qx
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:06:00 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-219f8263ae0so77256955ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739801137; x=1740405937; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zg/EVU0f4eFzBH9Wpquuf21heBkWFjy5hpmnqQ/UTNs=;
 b=FSr4SSGeaSKCHOr/4ptD2Obb+sdmQ6r79sH0UNWBMVrXxyCp2UZBonultC5/pO5Gdi
 5Tv/bmf5npqzXV7iLH0ohSYr8j5kielj5jhDYnDru7GZmIBBq1+iVWmGTHoKoUS9rt6e
 PbFMjzEXrEkc1wbKgif2RahAjT2+uFouUomlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801137; x=1740405937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zg/EVU0f4eFzBH9Wpquuf21heBkWFjy5hpmnqQ/UTNs=;
 b=nHD5f+l4tQX0ZEHI9m/xdCSIF/yVjJaiy8BjwHktHgF41l3FUnJjKv10crpJfyZQRz
 eGbTqR6aPKPzYeC4gK3wX0Cvle293FqulWYqGQh4mbHG5jBE1AfI8huvgRc1e02lZjWC
 Kway08WlPFhOg0yXlWIjXEvx1jvlfdMC46rUBkr0Lk4ISHJyirhdEaq3bLo0FEszlWYX
 t1hQ3SdWo79lsUeihwq8Rv+veKrncfHaiuZuRshCdVR5Syvkbf2LGpVk0XMuuwGN53g9
 QpRCW1R3hsNYswbNpyNG+D2MYupwuYxf20iZevKNESwLnYKwDgkDwMbOEsTNWYFWIJwX
 McIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMOnADr6JhBdOM8LYGmW9zs3ki4pb5S6GNvsf4bpvqTRp/SJGvut5Fpn9tJpaSGD7TbODMDA892Jmj@nongnu.org
X-Gm-Message-State: AOJu0YyQCVnzMmKb89AcCmw6Si+cQ+uuvwTkXv7oHr7PQ6QQFKK1PR9I
 muaTzok4UP/hZLQR+zxtmcV8fdhIFkQwRhX/Rb0r1nySG+P3YRpR/4bfKosw2BnLzLdOQdEyaih
 B
X-Gm-Gg: ASbGncvhEzJ4xORnGPfjx85epR1TPhLkNbzjzQ4U9onWji6r3XPBeb8y04TLEeFaxob
 SuiHvTdOWX5r0aNH5u7GruOLFYk0/rM5Ag+iIx+P6znJemMdDSGP3UnXfews5j5GKa0OK4YVKwL
 4Ij6I0wHpP70e7f470ted83LOiW98DOsYD1f6BzXUlNwcV9XA4j3V9Lgzen/WA1aUuY+p9Pu7VS
 /lwiPjXZXKhpajkr38tMzZ0oG6iNhd+iMg5TWVbReqZcy6R/KfkD8WMW/df5WoA2Rtlo1bm9Gl6
 YDpcwZpR/dsaKA==
X-Google-Smtp-Source: AGHT+IGX4dYYsQ1A+LIO1LY5u3sAS4bhWhQLiUwWyk7C0SR8FxIgbOQmcQgNpeCF4DbVUOJdGj5Z3w==
X-Received: by 2002:a05:6a21:7899:b0:1ee:73bc:5f2 with SMTP id
 adf61e73a8af0-1ee8cac56cemr16813086637.2.1739801137009; 
 Mon, 17 Feb 2025 06:05:37 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324f22fd95sm6769705b3a.11.2025.02.17.06.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:05:35 -0800 (PST)
Date: Mon, 17 Feb 2025 08:05:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
Message-ID: <20250217140532.GG1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216215738.GF1233568@bill-the-cat>
 <CAFLszTjtgMT6Pd9_MG8t4irU-jyoHTd40MwX5m1iqj4rjVED3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="umW28Lcj/p6fp0Bs"
Content-Disposition: inline
In-Reply-To: <CAFLszTjtgMT6Pd9_MG8t4irU-jyoHTd40MwX5m1iqj4rjVED3Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=trini@konsulko.com; helo=mail-pl1-x630.google.com
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


--umW28Lcj/p6fp0Bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 06:14:12AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 16 Feb 2025 at 14:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 01:43:45PM -0700, Simon Glass wrote:
> >
> > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but =
it
> > > is not perfect.
> > >
> > > With both builds, executing the VESA ROM causes an intermittent hang,=
 at
> > > least on some AMD CPUs.
> > >
> > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-b=
it)
> > > is done in a way that works on real hardware but not with QEMU. This
> > > means that performance is 4-5x slower than it could be, at least on my
> > > CPU.
> > >
> > > We can work around the first problem by using Bochs, which is anyway a
> > > better choice than VESA for QEMU. The second can be addressed by using
> > > the same descriptor across the jump to long mode.
> > >
> > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> >
> > This seems needlessly not against mainline.
>=20
> I just tried it and yes there is a very small delta. I can resend it
> rebased to -next if you like. I'd really like to get some OS-booting
> tests into CI.

Sure, and please start pushing scripts to u-boot-extras. Having these
scripts in u-boot itself explicitly makes it harder to use them for
debug as you now rely on them being within the tree with the changes you
want on whatever older commit you want. And since you want to move these
to Python too you that also means language updates need to be in there
as well. Thanks.

--=20
Tom

--umW28Lcj/p6fp0Bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezQiQACgkQFHw5/5Y0
tyzjhQwArYVqHUFpomFtiW+i5S/JC2/oMdDkBPWILbq5Me7qwk9HjuTGQOfDGHRk
xas9Gp0soGZoFCh68x8uIE2Qluho2QDemPpkJLsGALB4/Un9H2E2L9JigIr1fiZ8
SqGr69eVuY5nVREZtnJ93xOr3rx04lmFCc8XDCP3UQk4rx7FyluYzXMM0Owq1XBb
wnZ2HfVaK6bbJou+G40P91vRhYO65un4HxGHlt/sTzDQcvBqfMeyH3fAGAZdmHOK
BmDeJD3VsL3x2GHK7ur7lC4/kOAINjGa+EOuTHpFVWiSWKCr4ATvPuamfc+6Y41m
tLU4k2QFUcwpEq89EQZk3JvjXweUnrus+sr6JtBJIDBsT46+z8Mr79QVjk2BhmN4
wOHCCn0I9ZlAL0KuhoQ0hGGSXhC5y4fe7+vbblYVif1g9t/UG/vgdBQ8TouCrqWn
O9FR1r4pff+CCPz96bJJGLCZHMFt4vANBEavc9mPRSqVLe5u3917lSe2EABUXODB
yznpliJo
=pv6D
-----END PGP SIGNATURE-----

--umW28Lcj/p6fp0Bs--

