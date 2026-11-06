Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F2606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+vCc4ZE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=j4ux1EW1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPL03-0006U8-7m; Fri, 06 Nov 2026 09:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xPKzy-0006S9-M9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xPKzw-0008Mm-CN
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793975573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFgof38YVmuhepQLwF5AfzYRURG39/TBDJ0Tu3cg9+s=;
 b=d+vCc4ZEqk9hB1F2ZtLr6QRRe54YMjMEQzQlzMJv13h7o4uLz6ejtqRK05owWGDh0LM0Ok
 rvbeqRxtDaEZKu8kl0+h2Uoxc0SfUheW5AMXz4eUA6R4T16sEj8M6v+R0rKHpSHeC5zboA
 T3sYZGr2pA2p5kMXLtYoYK02jJSfDdU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-fmMcW-imNyazL6qa9_eVkQ-1; Fri, 06 Nov 2026 09:32:52 -0500
X-MC-Unique: fmMcW-imNyazL6qa9_eVkQ-1
X-Mimecast-MFC-AGG-ID: fmMcW-imNyazL6qa9_eVkQ_1793975571
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b0e00d7cc2so704663a91.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 06:32:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793975571; cv=none;
 d=google.com; s=arc-20260327;
 b=a0Q+liWmWLcDOIP4qTb9o4GlcwfT6IObDfrYb+mV8V0ZHCy4i6A6Dbx6Xilajc65W8
 fNYkFpeLnjNYYGbWXnLxCmG+lbTSBtlNcE4VUDWGwUjWBt6KzkOUSszwC9Fl2h+wEwUt
 oFHKG1WUjFuV69rb+2v0ktPm/VNO1d1OS2YC0qy4nETENzReVnr0SvP4hILjWmFyHUbq
 jwqkOPjvXouyJ52w8Nbm8FYsH5NHL5r+IAbQ8ofvIxlHjHQwivkI0AR8bj6fBNYSvh6a
 9cZ9dGP0JHbuLC0wZaNZEOd4u/Krw/o4GJwkkoeBqjoEIUjdkUh5QRdf8NQVcY//ank2
 46gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KFgof38YVmuhepQLwF5AfzYRURG39/TBDJ0Tu3cg9+s=;
 fh=WYXJpkny4qQ7Hg5fWbBolscC7TqUrV2RLz+rrXSMta4=;
 b=cXzYngT4tx3LIzKH7SGwSKQpQ1JpsV1fmNCTk02mH7SLLT20RUmM3PZ7/txLZDc9UP
 FxHbjLZODTekuzl8SPn2ZvK05qh8UPIaF4/c8/K5Wu1P1B+EF0qbd66gy5okPQuC0jO/
 x7xDf+NyMyU/KZsbXGHsY68gQl4roMudOZ6qc6j4ZsTa5wLiOKaWlf3H2cOz/4PkMXPn
 uEZf7ovU5eB003azux+y+uq6OEljpoMAqlYzk2ydREqprdo8tM5SuCdTvELgViGJQtiq
 9BkomGTqNvxlh5ZYR84GqAnvNFjEKtuQq1zbkqoFwtcyWhjSGKn91mH1wMHwGU62cVT3
 oclQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793975571; x=1794580371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KFgof38YVmuhepQLwF5AfzYRURG39/TBDJ0Tu3cg9+s=;
 b=j4ux1EW1FCFMzZaraVomBCO7ibmJU2OE+KA9dPeokvTFu0qla2btuDhpjCpd1cqaEn
 vuEm3A8HIpQ1FnBusJHxUXycaAnUrC1jcpWpNq0UNmqu9ldU1N9YtgowGDeaDJzw9NGU
 nOXdpVZjdlxhmhieTBNS7O+Xmv8dEonO1hBNKF+W4PFPPdeMxgtX4aB4aLW0TacLrEcq
 L8oFPx8UbciPwONBcEuVbKFKKpySzaXqB+aTmfe5Ho646wVyNSIQIDEMzDAXZVVzAHWs
 +TVvIsRmIo8AT+W1YRGdVF//udy5bhlDL1CaMEdXKF4gTy7br6bjfi1LWKy+2ukkHHoE
 aRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793975571; x=1794580371;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KFgof38YVmuhepQLwF5AfzYRURG39/TBDJ0Tu3cg9+s=;
 b=fh5rinXRn2bNVisDK+omNC+YbuLq3UKeAKx4PNEM0W9Q8om/HWcpGzFAlD8roG/2H3
 jYN2ICHTJVQxtUyiR4r0xneq9dij5jjBYI36yhlZHLrvrvNRNBxv2GA+jUis5aV41Idd
 vIiFvdG9giruR3DEMf8cfjiizdHmRJ5Y6PbRg+HYaNxLR1xADMJJyTN1JDTkIar5LsXp
 kVzVS+5oWlkd8O3SJe7/2ucE3HqQsLh+rws5vkofYxRjVERn4/d7SMzBiyFTqzFnaF6d
 82bluZKXbah4hoLYklhRz23hNmFkUd1uPGZhFQogCur6ynogWk3qYFr+9mC+Y+n/XnEL
 OvoQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEx0X3fdo3sns28EL+g8Vtl/ym89u/kxJQ9SZQRIoo3TpHCtx6H4ZKUmwmbAVrMeDv62X46EW1WwGtQ@nongnu.org
X-Gm-Message-State: APuU4Z+5/HFrGKAHdGclut/Oes+emevg9O50VcFvN411AsIffyp6PJpY
 Vtad8anF3b6Jw7hHOMTY0gPerJB4+Xynn3EMLqoz46K3Z9inj705sV++5XVP9rjNEkZQyX1zJxP
 xWnbVdYLmd4ptvsxzF1s+GzVbgBXNuyM4rdVWDISNymKDbyZy6Lh8b4RjN217K5m8Iiwr7I2dl3
 ZzgF8Owmk+19BeAIwO0s5zbURWzkDEe+A=
X-Gm-Gg: AYBFou0OtNICqhz9Lw2LGhvpfQHpnSda34B5PNgKTjCTUK8T7Bsrq7oFG+tSrDuuDvj
 dJtsZGFzW+9kUoG1+C/kifjJIC/iJGFeznvcUQUtUTzFiTTL/8B0vPJmhkczQyxiAlXGmVNhAYb
 YcvGNL87aMZ7t6rWOTIH003sLoL8s58OC1nqgIaDYJdK78t/38ef3pklK84LTw7ekq1g4rbG0S2
 c8UmzxvybYnuzjLFj5fxJzVn3QX3jOut8YrsUnA+4tBZpwjS+2zAcrx71qHHqzYfrJWo3JDz1MY
 6w==
X-Received: by 2002:a17:90b:4acc:b0:3ac:9e76:aa9b with SMTP id
 98e67ed59e1d1-3b0db5f17abmr2690759a91.7.1793975570838; 
 Fri, 06 Nov 2026 06:32:50 -0800 (PST)
X-Received: by 2002:a17:90b:4acc:b0:3ac:9e76:aa9b with SMTP id
 98e67ed59e1d1-3b0db5f17abmr2690726a91.7.1793975570320; Fri, 06 Nov 2026
 06:32:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-28-berrange@redhat.com>
 <31bf0fb1-06fa-4bae-8b22-853f80548f9e@redhat.com>
In-Reply-To: <31bf0fb1-06fa-4bae-8b22-853f80548f9e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 6 Nov 2026 18:32:38 +0400
X-Gm-Features: AclHuK_pAxkav4OTh3uql40djULH5fMEJ-oSsUYthtVGQo9W5daHH-dJ8IAFL2k
Message-ID: <CAMxuvaxAmTShKMxxhtMxVEjB5QL+d5Qgw44efB4WeRAC9oQS_g@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] hw/display: mark cirrus and QXL as secure
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Fri, Nov 6, 2026 at 4:23=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 29/10/2026 14.12, Daniel P. Berrang=C3=A9 wrote:
> > Most of the display adapters are emulating old hardware which is not
> > relevant to virtualization use cases. The previous commit added the
> > generic, simple devices.
> >
> > This proposes two further devices based on their historical widespread
> > usage in virtualization use cases.
> >
> > Cirrus (PCI, not ISA) was the recommended default for x86 for an
> > incredibly long time and while it is now discouraged, it is likely
> > to still be in common use.
> >
> > QXL was the recommended default to be used with SPICE, which is designe=
d
> > to service virtualization use cases and is still commonly shipped by
> > many distros and often used by default in mgmt apps still.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   hw/display/cirrus_vga.c | 1 +
> >   hw/display/qxl.c        | 2 ++
> >   2 files changed, 3 insertions(+)
> >
> > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > index 0a8c74e1374..8232c5c4687 100644
> > --- a/hw/display/cirrus_vga.c
> > +++ b/hw/display/cirrus_vga.c
> > @@ -3013,6 +3013,7 @@ static const TypeInfo cirrus_vga_info =3D {
> >       .parent        =3D TYPE_PCI_DEVICE,
> >       .instance_size =3D sizeof(PCICirrusVGAState),
> >       .class_init    =3D cirrus_vga_class_init,
> > +    .secure        =3D true,
> >       .interfaces =3D (const InterfaceInfo[]) {
> >           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> >           { },
> Considering that the cirrus card also had a bunch of security-related bug=
s
> already and nobody is really in the mood of maintaining this anymore, I'd
> rather not mark this as secure. I'd recommend to rather drop this patch.
>
> With regards to qxl, maybe better also omit this for now 'til we've got a
> proper maintainer for this again.

+1


