Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02141C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoX8-0002KW-1m; Wed, 21 Feb 2024 10:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rcoOo-0003GZ-7b
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rcn1D-00042d-OE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708523535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA9QNh3Ts4warO/TN+qO0jRa06vayUkXcLHH7BrdjRo=;
 b=jNbURFv//lK0iOuYT2kDGFlQNi6CCItvka3q21Mrr3y76Z6wFMaBfke8PZjTFP86EknO1I
 KRAy2IUVQlvoiuHsDYZC9kv/a9pGdrohtQwyAF5KekkR/uA9ryCwxEGyTVNwPwiQWZ2Wv3
 kT6ZI8Zk7zz8u864osVw+pGJfnntG7s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-H00PTE3rPO6SWtoPGDgaXQ-1; Wed, 21 Feb 2024 08:52:12 -0500
X-MC-Unique: H00PTE3rPO6SWtoPGDgaXQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d10bd57d7so2239750f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 05:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708523531; x=1709128331;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NA9QNh3Ts4warO/TN+qO0jRa06vayUkXcLHH7BrdjRo=;
 b=UOuKOMaDKCKI8YQBv8lY1UCE+DIrnHmA1C3GbmtE1fGdw23wHXaaVNcRKqMu+MhU5S
 nJlN5AMpkHPz7PlSpV6Ex+gcxKPxdNtxWRCNWNP5kCxAR80fK19cN+b1DjkJqLw2QNUX
 FQ/aH8nW7rjEGJgNrZPnxk33JcojKymk2s0diFBnygOF9nY1qQ7iEwEcncz6fBZKE9DP
 funtxGDs2+tKoQcb4uQi+Sv81s5nwuyImIYX8vwInmuPms/BvYWuxj6KtzzDSZVvbeZ6
 ZyVuIpGjQgAx6d5G53rR/z1OqXH2xFRbB60w1RexlK7x9BPK6KQWUbQyETm8KHGczWbx
 +QKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMk+GVrLqJRfATo3UsAK2WXggcRVsZN0AsJET5jZXzMhN4AFM4zDLP++VUYSf569ArKCXAUcCIbKgspXZk3cSri4Qwh44=
X-Gm-Message-State: AOJu0YzJ4cJ7tSvOXC1kQf7kvVqLX6Ickau1QXDyMJgs/SaYsVrWnfgI
 iFuwOneoNeFtBRPj9cS0YjYDCIpy288FVyLCjee2IkGKrIViDGcWijYdwkOETyx2B9aVlCtTPZY
 J/XKyKMWbUpTA6rdscbngem2UQ61LdHj243d5YJQhTNmgxfFC8zgc
X-Received: by 2002:a5d:4a8a:0:b0:33d:855d:7457 with SMTP id
 o10-20020a5d4a8a000000b0033d855d7457mr459595wrq.21.1708523531114; 
 Wed, 21 Feb 2024 05:52:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERHxHceY72u24QPQWwZlnF2Vht/9nsjIWucMPGOsJOMKjgvmMGPnNO4yNo5JhyxukCs2Zw7Q==
X-Received: by 2002:a5d:4a8a:0:b0:33d:855d:7457 with SMTP id
 o10-20020a5d4a8a000000b0033d855d7457mr459580wrq.21.1708523530790; 
 Wed, 21 Feb 2024 05:52:10 -0800 (PST)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a05600011c300b0033cf453f2bbsm16975610wrx.35.2024.02.21.05.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 05:52:10 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 14:52:10 +0100
Message-Id: <CZAT1MBJ3ARY.2VJ27QSELNPGZ@fedora>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, <mtosatti@redhat.com>,
 <qemu-devel@nongnu.org>, <vchundur@redhat.com>
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com> <Zbf0Fbhmg0tvMbxK@redhat.com>
 <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
 <ZbgAb3m6-rwUFxOO@redhat.com> <CZASCDCNT6TJ.1LP37HOBJVYGT@fedora>
 <ZdX-6mJbpuMaRio9@redhat.com>
In-Reply-To: <ZdX-6mJbpuMaRio9@redhat.com>
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

Daniel P. Berrang=C3=A9, Feb 21, 2024 at 14:47:
> On Wed, Feb 21, 2024 at 02:19:11PM +0100, Anthony Harivel wrote:
> > Daniel P. Berrang=C3=A9, Jan 29, 2024 at 20:45:
> > > On Mon, Jan 29, 2024 at 08:33:21PM +0100, Paolo Bonzini wrote:
> > > > On Mon, Jan 29, 2024 at 7:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <be=
rrange@redhat.com> wrote:
> > > > > > diff --git a/meson.build b/meson.build
> > > > > > index d0329966f1b4..93fc233b0891 100644
> > > > > > --- a/meson.build
> > > > > > +++ b/meson.build
> > > > > > @@ -4015,6 +4015,11 @@ if have_tools
> > > > > >                 dependencies: [authz, crypto, io, qom, qemuutil=
,
> > > > > >                                libcap_ng, mpathpersist],
> > > > > >                 install: true)
> > > > > > +
> > > > > > +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr=
-helper.c'),
> > > > >
> > > > > I'd suggest 'tools/x86/' since this works fine on 64-bit too
> > > >=20
> > > > QEMU tends to use i386 in the source to mean both 32- and 64-bit.
> > >
> > > One day we should rename that to x86 too :-)
> > >
> > > > > You never answered my question from the previous posting of this
> > > > >
> > > > > This check is merely validating the the thread ID in the message
> > > > > is a child of the process ID connected to the socket. Any process
> > > > > on the entire host can satisfy this requirement.
> > > > >
> > > > > I don't see what is limiting this to only QEMU as claimed by the
> > > > > commit message, unless you're expecting the UNIX socket permissio=
ns
> > > > > to be such that only processes under the qemu:qemu user:group pai=
r
> > > > > can access to the socket ? That would be a libvirt based permissi=
ons
> > > > > assumption though.
> > > >=20
> > > > Yes, this is why the systemd socket uses 600, like
> > > > contrib/systemd/qemu-pr-helper.socket. The socket can be passed via
> > > > SCM_RIGHTS by libvirt, or its permissions can be changed (e.g. 660 =
and
> > > > root:kvm would make sense on a Debian system), or a separate helper
> > > > can be started by libvirt.
> > > >=20
> > > > Either way, the policy is left to the user rather than embedding it=
 in
> > > > the provided systemd unit.
> > >
> > > Ok, this code needs a comment to explain that we're relying on
> > > socket permissions to control who/what can access the daemon,
> > > combined with this PID+TID check to validate it is not spoofing
> > > its identity, as without context the TID check looks pointless.
> >=20
> > Hi Daniel,
> >=20
> > would you prefer a comment in the code or a security section in the doc=
=20
> > (i.e docs/specs/rapl-msr.rst) ?
>
> I think it is worth creating a docs/specs/rapl-msr.rst to explain the
> overall design & usage & security considerations.

It was already included in the add-support-for-RAPL-MSRs-in-KVM-Qemu.patch=
=20
but indeed it needs now some updates for the v4 about security and=20
change in design.

Regards,
Anthony

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


