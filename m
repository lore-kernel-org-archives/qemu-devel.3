Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C907C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoUO-00027b-D5; Wed, 21 Feb 2024 10:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rcoNG-0000wD-Rp
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rcmVJ-0006T8-7K
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708521556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVwiqYY/MawHX7uK5b7FML3FgyS678RUua5nc2wqOyI=;
 b=GM4ppNxOqLh5NxAQS5mzEOgXY+pziPj+KbuyM/ZH2tJXK8Tlu3verBe3dlhHSZ5XFZdjGQ
 YbmtiVn8Xp2hcQOm3blc5UnkUFbuITHIc/rpQbmoV2Mo9VUsSDpqFcZXPXBfmulgqQNo9z
 ugARWjseT91jyR3WzMoyqpNFJoK9i6Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-CXCibcpOMAaN0yBlonVhFA-1; Wed, 21 Feb 2024 08:19:14 -0500
X-MC-Unique: CXCibcpOMAaN0yBlonVhFA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d244967778so18274571fa.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 05:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708521552; x=1709126352;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BVwiqYY/MawHX7uK5b7FML3FgyS678RUua5nc2wqOyI=;
 b=AM27D9amOjYf8JKep5P78iZk/BxwozfwA4OuoJcZZKDp8vLiC+dkGb0yIxHxCCCk4R
 McDHLcCae80/Aq3lfiThiqk1qu0JjLEcxCH4kpHypl3ObK/tSD0m38cRf/pmDNX96BIz
 s8465h2PL5R4iSvX0/TOMaVNxsr3qwsoAGkcQNFShhboJjPsmlB/C8FFvEw6rsu0LtVm
 efEnilReTYtzvGuae3ia0FF/S7SZjxXg5IsFb0iILUxX7TWCF7Bw9w58LHu+N8lx2Mn5
 84Lr6mrBGlRfHbX7o4vQX3n2AjlrkghTG5sQ8x95qKM4uf0jAQ6+HojZ3LafMIgIPlqz
 w6Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+fBbyytoMRE26XXkt9NZ5YJUEQoU6PL5/y/Pf2c7ZrA3AgGCn9LCk07GT3ddBX6wsciYRQ/GZGcZCs6yBi60gA56udlQ=
X-Gm-Message-State: AOJu0YwdUS8VI6u881JS+pxrDUsBZAwEUlngd/jHEExwqvzhgTItZdIz
 vNIMjWFrq6SxeajqHN3r5rkfTb8BNPwL6sQeZOKaauYus0NxK7kk3XhL+n43r1DyOrjfPzdihjP
 hPZfTIWJudOJAdgYDmBflgrPqJZEei1ZF5hwvLWj23z2xqwUud6JO
X-Received: by 2002:a05:651c:220c:b0:2d2:3451:52de with SMTP id
 y12-20020a05651c220c00b002d2345152demr7757628ljq.12.1708521552684; 
 Wed, 21 Feb 2024 05:19:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGjekNICzgyX0kDsisrVSZRvqQLLmlJFfASwII2li5TRadd5PR01c7useJ9DEBZZbetIuYxA==
X-Received: by 2002:a05:651c:220c:b0:2d2:3451:52de with SMTP id
 y12-20020a05651c220c00b002d2345152demr7757617ljq.12.1708521552323; 
 Wed, 21 Feb 2024 05:19:12 -0800 (PST)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a5d6784000000b0033d39626c27sm12470082wru.76.2024.02.21.05.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 05:19:11 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 14:19:11 +0100
Message-Id: <CZASCDCNT6TJ.1LP37HOBJVYGT@fedora>
Cc: <mtosatti@redhat.com>, <qemu-devel@nongnu.org>, <vchundur@redhat.com>
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com> <Zbf0Fbhmg0tvMbxK@redhat.com>
 <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
 <ZbgAb3m6-rwUFxOO@redhat.com>
In-Reply-To: <ZbgAb3m6-rwUFxOO@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Daniel P. Berrang=C3=A9, Jan 29, 2024 at 20:45:
> On Mon, Jan 29, 2024 at 08:33:21PM +0100, Paolo Bonzini wrote:
> > On Mon, Jan 29, 2024 at 7:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > > > diff --git a/meson.build b/meson.build
> > > > index d0329966f1b4..93fc233b0891 100644
> > > > --- a/meson.build
> > > > +++ b/meson.build
> > > > @@ -4015,6 +4015,11 @@ if have_tools
> > > >                 dependencies: [authz, crypto, io, qom, qemuutil,
> > > >                                libcap_ng, mpathpersist],
> > > >                 install: true)
> > > > +
> > > > +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-hel=
per.c'),
> > >
> > > I'd suggest 'tools/x86/' since this works fine on 64-bit too
> >=20
> > QEMU tends to use i386 in the source to mean both 32- and 64-bit.
>
> One day we should rename that to x86 too :-)
>
> > > You never answered my question from the previous posting of this
> > >
> > > This check is merely validating the the thread ID in the message
> > > is a child of the process ID connected to the socket. Any process
> > > on the entire host can satisfy this requirement.
> > >
> > > I don't see what is limiting this to only QEMU as claimed by the
> > > commit message, unless you're expecting the UNIX socket permissions
> > > to be such that only processes under the qemu:qemu user:group pair
> > > can access to the socket ? That would be a libvirt based permissions
> > > assumption though.
> >=20
> > Yes, this is why the systemd socket uses 600, like
> > contrib/systemd/qemu-pr-helper.socket. The socket can be passed via
> > SCM_RIGHTS by libvirt, or its permissions can be changed (e.g. 660 and
> > root:kvm would make sense on a Debian system), or a separate helper
> > can be started by libvirt.
> >=20
> > Either way, the policy is left to the user rather than embedding it in
> > the provided systemd unit.
>
> Ok, this code needs a comment to explain that we're relying on
> socket permissions to control who/what can access the daemon,
> combined with this PID+TID check to validate it is not spoofing
> its identity, as without context the TID check looks pointless.

Hi Daniel,

would you prefer a comment in the code or a security section in the doc=20
(i.e docs/specs/rapl-msr.rst) ?

Regards,
Anthony

>
>
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


