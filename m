Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEADC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpT1z-0001vT-Kv; Wed, 27 Mar 2024 09:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rpT1x-0001uj-SL
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rpT1v-0001dz-M3
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711544962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0I86kTNYOKrCXN/nN2NxIZLiLpsAdoBdvgJZ+LHEbU=;
 b=Q4m7cYoAZMzjzz44p8AXww6vJXmv0SDQAxNhPKK4VjRW3hDFivh6X+d9gwV9QredoGWNOY
 zdQTXqDZ1C+YMmakP9qtlqTsG0+SDkFayWc34CGQVTrynYDvcG6XSp8qLi3q0fqR50Sqkn
 q7JIedxgBtXAVfJudt2DxUO684VK8Fw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-kHC1ca8wPBC0Y8WYxMgggQ-1; Wed, 27 Mar 2024 09:09:20 -0400
X-MC-Unique: kHC1ca8wPBC0Y8WYxMgggQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4140bf38378so47944155e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711544959; x=1712149759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0I86kTNYOKrCXN/nN2NxIZLiLpsAdoBdvgJZ+LHEbU=;
 b=HQfx7ivfMEmNkzNsye2vfbJWIBbWZ1tuxJGyHrU3vGa84r+HKv9uQYMTl3qZwb/qRn
 Uo+hE+9mGM+5/olw7u6LneBxelyP1F6/tqnU8LU91Vq+txl+a/SeGEG+AliDN9tw3Lh/
 kIzSS5UDgyrSdkzP5T2+CpoiunQRRU3daAVMmxrQkUy1mU/07ly9qDIO9ZIEFyLR2TfW
 M9LIH3gZCJ6YvKlIneIRHmG4a3wVQ44ecM5t0cNVLoxXMMuz2xPDE3yrBkDQ9J0oI5CW
 itUkeLHMmP9VUni1LWOi3VNSoeqyQiefsW/Sbq74ZC9VqW/20Q+vzqrGMmyEUv+XiIrZ
 2DUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG2ohkeVUsn7C+aXZ7mml1iAtHGqbBkqF+Lf9BiTk0Az3ZdUHJUINdNXf4SaLtH97VQrXcU8vrWItzoZUQscTq1wMHqHs=
X-Gm-Message-State: AOJu0YzdjybCq6NDnc4A+M4oNd+PBlTJ2WBMZQPI44dE9PXrT+pLbjL0
 HwUvnkXdxqM+Y6/uPSpW0U4X/LSbavdj9molQcJpnmyyQS0SS3u3UkhKTWpFClxZfU3k+JOyYYS
 fwQMYMGeM7W64FzzPXGtFvDt93pNEk5UBmpPm5Z8WOdxBdKgsL49r
X-Received: by 2002:a05:600c:4f06:b0:414:24d:7f9 with SMTP id
 l6-20020a05600c4f0600b00414024d07f9mr2684505wmq.1.1711544959162; 
 Wed, 27 Mar 2024 06:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7P6UsvagMdr7a+OE7ugtmmSKernCYFg3RggG3pjjUyipxPftz9JsEcV4eqRDLM65xFgemtg==
X-Received: by 2002:a05:600c:4f06:b0:414:24d:7f9 with SMTP id
 l6-20020a05600c4f0600b00414024d07f9mr2684473wmq.1.1711544958685; 
 Wed, 27 Mar 2024 06:09:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c45ca00b004149536479esm1491588wmo.12.2024.03.27.06.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 06:09:18 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:09:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Thomas
 Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Bernhard Beschow
 <shentey@gmail.com>, pbonzini@redhat.com, devel@lists.libvirt.org,
 richard.henderson@linaro.org, mst@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZgP5x3ECYGevla1-@redhat.com>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
 <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
 <ZgP5x3ECYGevla1-@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 27 Mar 2024 10:49:43 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Mar 26, 2024 at 05:16:32PM +0100, Igor Mammedov wrote:
> > On Tue, 26 Mar 2024 14:29:58 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >  =20
> > > Hi Igor,
> > >=20
> > > On 26/3/24 14:08, Thomas Huth wrote: =20
> > > >=20
> > > > s/iaspc/isapc/ in the subject
> > > >=20
> > > > On 26/03/2024 13.51, Igor Mammedov wrote:   =20
> > > >> ISAPC machine was introduced 25 years ago and it's a lot of time s=
ince
> > > >> such machine was around with real ISA only PC hardware practically=
=20
> > > >> defunct.
> > > >> Also it's slowly bit-rots (for example: I was able to boot RHEL6 o=
n=20
> > > >> RHEL9 host
> > > >> in only TCG mode, while in KVM mode it hung in the middle of boot)=
   =20
> > >=20
> > > I'm quite opposed to this patch. QEMU models various very-old /
> > > defunct hardware. I'm pretty sure Bernhard and myself are OK to
> > > keep maintaining it, besides we are working in separating it from
> > > the i440fx+piix machine. Also, this machine is particularly
> > > interesting for my single-binary experiments. =20
> >=20
> > it would not be fair to ask you or Bernard to deal with every
> > case where ISAPC related code gets in a way, nor it's fair to
> > ask other contributors to ensure that their patches don't break
> > semi-working ISAPC or refactor code that relates to it.=20
> >=20
> > [
> > for example I'd like to refactor smbios parts in the image
> > ACPI table builder, but the I'd have to do it for legacy
> > part as well without means to verify that. Sure it can be
> > done but at cost of extra time spent to rewrite something
> > that would never be used and to find test env to verify
> > touched code.
> > ] =20
>=20
> Is SMBIOS even relevant for isapc ? IIUC, the first SMBIOS spec
> is from 1999, while PCI has been around since 1992.

Theoretically SMBIOS can still be used with isapc,
(that's how I've tested factoring out legacy part by running
RHEL6 in TCG mode)=20
Whether it's used in practice somewhere else is unknown.=20

> IOW, we shouldn't even be exposing SMBIOS with the isapc
> machine type. If we address that, then isapc has no impact
> on your ability to refactor SMBIOS code.

It's question of whether we are willing to do unthinkable,
i.e. to break QEMU <-> guest ABI for isapc case by removing
corresponding fwcfg entries.

With migration ignored it shouldn't be a problem.
Question is: does anyone care about migration with isapc?
If not, I'd gladly axe smbios legacy parts in 9.1


But given how easy one can spawn old qemu environment to
run something on isapc, we are loosing a chance to cleanup
QEMU code base touching following=20

    m->option_rom_has_mr =3D true;                                         =
       =20
    m->rom_file_has_mr =3D false;                                          =
       =20
    pcmc->pci_enabled =3D false;                                           =
       =20
    pcmc->has_acpi_build =3D false;                                        =
       =20
    pcmc->smbios_defaults =3D false;                                       =
       =20
    pcmc->gigabyte_align =3D false;                                        =
       =20
    pcmc->smbios_legacy_mode =3D true;                                     =
       =20
    pcmc->has_reserved_memory =3D false;

they are all marginal but in shared code, and removing them
makes code a bit more easier to follow (especially when it
comes to memory layout).

> With regards,
> Daniel


