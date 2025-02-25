Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D4CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvq8-0007Yr-7o; Tue, 25 Feb 2025 09:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tmvq5-0007YJ-Un
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:23:13 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tmvq4-0007Vt-4w
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:23:13 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-471f9d11176so63879961cf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740493389; x=1741098189; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jpccQP1wQ2uWfx/9mxAJB7qiyDiRd7hyp9S3OR+v1Ko=;
 b=JN5OdKRlemn4MnKIua24mPwS/ywAUCat/MSPwbxj81flmTrvXHaXRJBEiJKlPUX5ot
 FzLQdL3w5qOBk9QrDdiOTWhGKauJCEiQs56hL0OzlKJ50SwNWedhOskevHKmVj7sQJSh
 49o+gHw+X3hrb2eUptEtBkXvCaXuMGpt0k+Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740493389; x=1741098189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpccQP1wQ2uWfx/9mxAJB7qiyDiRd7hyp9S3OR+v1Ko=;
 b=hRC/9kAlGnS7dZ9BK1a3ukRTsmELgBCXfDR8u4sRRiTlrW7KG6Mp8/V0sudfxS+XzA
 q9LkHpq0N++rGf0Arpti6yXxO0R+35ef38RWFEAIe/kKIsyVof2Q4QK3Upt4toqHPGGk
 jysFUiFLvpCF7GeSfcu+MO28AN3SIvXRZeu+2pN6/ZKdnbdo6wPPk6DT+0TSTq2PZ2Ht
 u3ms1cHiuO7RikJC8eTkJMAbML5Djf2gu6Bn8hWXIOwgemXtTlKenT0FkcYYMJE+lh7e
 wbm8PpiBQI9UvaOnhCHO31y+U5iSN7Wwnsu6KUfqrLdy3TeEXLO+VzU4JrgdtOTiVOma
 0qtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq/A0BW2fSXhSR0ZeF0Xou3i6bCcxznakgePuGjWK9evQZHR3VHAun7qZAiEfnbw5shmPOcxWh+DcR@nongnu.org
X-Gm-Message-State: AOJu0YzW8Do91l7UbbtP+fxRamjDc2PX469fGK/Q+UdS/BNwwihBe15F
 8IFF4/92IadOJnai4mKW12MSwRRza3Qzla2B11LMxlyz6o4dt7tqj36S2qo3R1s=
X-Gm-Gg: ASbGnctqGxwEBzNck6CWC8nG0b1bfgwOgn044qrqiv6jxXG9GLCOEroCMS81xDyrfIY
 LOr/J8fH9Lfd789tgvhIQglZBpMIl1uMoeknleIzuU2uik8Vf7KrcbHk+xRnyN0g6IFl7zFG1gx
 mLDJ5+jvzqLugaPS0LzVaGyGYVqd4jnUa9ZXfAsf9gYr3useD9ojYXk5u2bBtQkVJLP/GVvyXIz
 LdvbrwFrGszhftPwEh2BeT2g3sePVt1CzL7ea836mV4ORgJzmFB899jgICN2huQ2d2lqaXrxXP8
 ZSxAguJEfm+/df4bNxwEyoqb
X-Google-Smtp-Source: AGHT+IH+5R6JtDqjCKb2vMgDHuKjl4XFEc9mMxH1uUsgxuoUGvaEvrENyuKtNtfLsM7cRh5+0menYw==
X-Received: by 2002:ac8:574e:0:b0:472:133f:93b3 with SMTP id
 d75a77b69052e-47224923383mr257532731cf.47.1740493389194; 
 Tue, 25 Feb 2025 06:23:09 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-473780867a5sm10256801cf.78.2025.02.25.06.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 06:23:08 -0800 (PST)
Date: Tue, 25 Feb 2025 08:23:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/44] x86: Improve operation under QEMU
Message-ID: <20250225142303.GN1233568@bill-the-cat>
References: <20250224230640.2665206-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lOSbmaG6ytFQr+Z6"
Content-Disposition: inline
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=trini@konsulko.com; helo=mail-qt1-x82f.google.com
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


--lOSbmaG6ytFQr+Z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 04:05:49PM -0700, Simon Glass wrote:

> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
>=20
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
>=20
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.
>=20
> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
>=20
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
>=20
> In v3 some e820 patches are included to make booting reliable and avoid
> ACPI tables being dropped. Also, several MTTR problems are addressed, to
> support memory sizes above 4GB reliably.

This is based on your tree I guess and not next, because you've not
rebased at least the prerequisite test/py series and I didn't try
farther than that with applying this.

--=20
Tom

--lOSbmaG6ytFQr+Z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme90kQACgkQFHw5/5Y0
tyxFFAv+KbHXXRIpTQt16JR1R16uoMRcOCJ0kA40qF+mXcsUeLH1aG2ZYaN3od5c
xgn2cWXsOd/QThi1XLi+96A1NQZzwbopmx3+lx+EJG3BBkvnpvMFQ/PHn9fFQiuz
3Iqznvh38OLSG1J1Wgb0mEBRoauT8lBWXaI7dx4OhBYALvgiZ2aY0cwW+mK/TJkN
w4gqQeg4TmcK1viwtFWeXwSJAQtBu/WX7WshsxMuE3+9POtIBhmNbd1TZcnW07/D
Tf8HwGEsNh7NI13/sLw8xfe3VUrjX2Iu5atcHKGFPlmjnPYYE4ug+d+H6vB3+NdK
k3Gj5tnOm8cDCRnSOJMrbi4gnp2HwxO0tOFBcQ2lT00G4FVzWCN3yhRbtSFsQCdc
Gwe4lpaK9GNIeT64uuo76O5x+s+xxjYUicOm/PCUjIfUA00/D/UgZPLoYZuHyN/O
vhU6GoVRfGvNFfcxfwSwMl6mkFJjSZ2X5Eg8K7HtQICgFyxzggDVMF4R9D9FOs0I
+MU1pRjV
=4CzA
-----END PGP SIGNATURE-----

--lOSbmaG6ytFQr+Z6--

