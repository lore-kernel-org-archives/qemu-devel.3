Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAEC606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k87fuQQ7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSB8V-0000Iy-VI; Sat, 14 Nov 2026 05:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSB8P-0000Bp-MJ
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:37:26 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSB8N-0003lQ-F2
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:37:24 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so2253270d50.2
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 02:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794652641; cv=none;
 d=google.com; s=arc-20260327;
 b=N3yaJrmbtvKn0rSBWJGvt2P7nEqlxKZn9K8pzNew8YJGE99NME4ykkZszwb6yxsBVQ
 p/IFelZqhSBOWARCYShu1Jq1Oyr2o8nNa3U51r9/ULOqqfXoQIJSBeJ08+2c2RBWfVQd
 BMc8GAvyXCPT23dYYRuxvxzS1dhT1XBlugMpn5/wtUI3IoeT1gs1m54MOZgTtOwNTwKz
 L8np8Lj6eQiQLzMv/lWDFEOuydjuI4geoB6/FSuND6788ehE+EfSjna0ZDMGTmlcC6x7
 ElhjPD/WqFq7VmlW71OIpG/oU7raKoFhhhXfmo1gJ+2h/DagOUdPb5ldgkQefL30GL33
 Cz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fQn3EUcBZC3W6R1YoO7TYSM5Vj4XfVQSrRh5MRgrh3c=;
 fh=4/xdZJ+NazwH4EZjBodZwI2khTaPzj7uTNLaw69xUPg=;
 b=b7/dYCajxi0rGJtzLF6pAyAjIlrV3GXsCo6+EpstDQVp41GZLXkzkdKgcxA8DVe1IG
 DLo+Av0z/7Diyvfvukbir3vg0mFdL+So//x5taReGvHpHJAUdk2/LfJMzmQ54Xnyd7Ur
 S+Bb6F0MXhb/R4a49nRyblOhQhWgCdmKgJJ9RJQwcVIlG/qgNpBlHTeFnZxvjk/4ZD/U
 w70rBECda3rrrMaZP9GBr3LC+OivcwDjhkMPnI0HqZefEl3Fw+BJFyb81x/Y/zv3bSWu
 fN9eWHxyiTU5sf9eneSislYn5O2+YTvFJUchI4ENWVwYHOMFzwOQU9o+a+3RWHLPQqmt
 2Whg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794652641; x=1795257441; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fQn3EUcBZC3W6R1YoO7TYSM5Vj4XfVQSrRh5MRgrh3c=;
 b=k87fuQQ7nkk1uwtVyezBcAsAU7GYNv7QTZfJe4s9mEA0SOn4b5lhMoTFZxzG0z46aI
 kd5PmXEC8KcR4xMr1OV1gxPDEO++QI+1826q4aCwfFymx7JxWwtULAg2+etO6yLROCGt
 B410OAi2YIHgQMOB3WcDDXDKwW3d2nCdFYdO3wCmJpD+hcn1MZ6HolTXHQsbc8loshIX
 vobAoNpf097ZLoMHsXF8ww+JZ1lxnTcVjtvj1XxMSpP8HAYv9okSC/xFdTxdvTvLSuRz
 MuV1QOfvagqTqEXarD5lZU5XJjq4rNFYKllZsujA8Nqj2CWgz/1k+tBddlXvbyI6O+Ub
 UhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794652641; x=1795257441;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fQn3EUcBZC3W6R1YoO7TYSM5Vj4XfVQSrRh5MRgrh3c=;
 b=mCnAuOnyw9VhEEXgZtotzYqRoR/svnkRlc1HJx2WkDt4OAm62E21iW6JiL0RkNl5ZG
 tJVk0eoSOgbpgm1YIOl+7e9i/33VpPZNP2+DLPmu0mMPp5UjxjSCzg8rlA6uS8dzaXTa
 tmc8BVThxKA2rqbbRQOfAoR7TcixzdhSItSuNWCs8eWMWxxFY1UqP+KaO2WSV6XNBYS7
 oYOwOcAeoZsyswV51RhaurU1byCqVOPsvduFFP7CVGmWJLDa5l4o/83kHAXH44MAG3KE
 bvAyht7frWrT/dnIUQDSrI6CVDgMSKVM8e2DYPaTSXC6SbD/T7R4iCvBEViTX14BxiH3
 TTiw==
X-Gm-Message-State: APuU4Z/6z4LriI/CQkD4FW/j0gLNwoheSEhyWWkiX84B047Syk8/pDb4
 ABygByq0UZNsWUO4N/yV/oMF3h8wYtdxhqEbJeWnDxBL0UtRSTbJbSAqSsgXJLtfytlJAUPuYz9
 Pg1LLCqEfdEdqgIEPkhwmpIwcXpa+2fwDPX/2r7mv8g==
X-Gm-Gg: AYBFou2gySW6M9B/EECZB+zVk2UMiXv/6Uy8cjVrm87gGSRp+b/eCFyZ2Jq6ir619V0
 nMQz5u5AFnHNMdSau2cSSAqdq8vz4kZKLI/oL9QSZq8z3l/8aGYfLmiZYfARv8au8fzF/gVouDR
 9kZqGc3fEShc8md1BXakmDajfwXyZVVXokuTNFpztZuDWweUo0U8kddyeHhzSuZkzPM4YUgOl4k
 dSXoqZ+YE6yN0K3jJxUgv2a9mNQV9/UoOv37lEkEWNXV9RYE7rS8cW9zDO7a2E3iEb/SIYPUxtU
 1Uilp8FwtmfxhapE3nE0W8DMHXfAtWO2aNUPZvQjThcruLqScVtu1/rlRmUXJ4z+TH9Yii9wyGJ
 9LCNM86B8W5oucWtGveFYyc7mDEaULGDEZcpLkmgxSDKJ7J25RMipeR8ftlm7tjKM2eNbdeSb3M
 D0Ae039cem87P1QbO24E7W
X-Received: by 2002:a05:690c:e3c9:b0:8b0:a7d5:8595 with SMTP id
 00721157ae682-8b4aa2f370cmr26980887b3.51.1794652641217; Sat, 14 Nov 2026
 02:37:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA9Ob8CsaufaAZ6jUhrKkxSfCkcig3ciG5LK_WCNCi14NA@mail.gmail.com>
 <de8cfd7a-9c43-44ac-baba-c8f892749dc4@eik.bme.hu>
In-Reply-To: <de8cfd7a-9c43-44ac-baba-c8f892749dc4@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Nov 2026 10:37:09 +0000
X-Gm-Features: AclHuK-8HjdxRF83J8M_9KxecSo0_5DTsNbL5y8oBiR9Cwd7EBeSapLPXsYWC5o
Message-ID: <CAFEAcA9BnWRnyMp4rswY1dxA4b5FQpQhK3YsGYGPXzwa-5YfGA@mail.gmail.com>
Subject: Re: Who should be allowed to unrealize a device, and what can you
 still do with it afterwards?
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 at 20:07, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 13 Nov 2026, Peter Maydell wrote:
> > We give QOM objects a reference count. This means that if you are
> > going to try to use one, you can take a ref to it, and then you're
> > guaranteed that it won't disappear while you're working with it.
> >
> > For QDEV devices, we add the "realize" and "unrealize" steps to
> > the lifecycle. There is no "reference count for having a realized
> > device". So what do we intend here?
> >
> > (1) We could say that if you have a reference to the device then you
> > can assume it's not going to be unrealized under your feet, and have
> > very careful rules about who can unrealize a device and when.
> >
> > (2) We could say that if you have a reference to the device then it
> > might be unrealized, but it won't be deinitialized, and you can assume
> > that all the API calls you might make on it will in some sense still
> > work, and at any rate at least won't try to access memory that's been
> > freed or crash.
>
> I have no idea but (2) seems to be impossible to achieve without likely
> also patching all devices one by one that don't expect this now. So I
> think requiring that a device should only be unrealized if the caller of
> unrealize has the only reference to it would make sense. This is at least
> easy to check but may not be easy to ensure in every case but, failing
> that may only leave a leaked device at worst but not break things. So I'd
> vote (1).

The good news about (2) is that the only devices that can be
unrealized is the ones that can be hot-unplugged, which is
"PCI devices and a handful of others", so we wouldn't have to look
at literally every device. But I agree that if we can figure out a
viable rule for when you're allowed to unrealize then that would
probably be less work to implement.

One thing I'm not sure about is what unrealize is actually for.
Is there ever anything that a device needs to do in unrealize that
it could not postpone to deinit?

-- PMM

