Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E097C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmy8C-0007SP-Aj; Wed, 20 Mar 2024 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmy8A-0007S0-Ay
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:45:30 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmy88-0006HV-5q
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:45:30 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so1895752a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710949526; x=1711554326; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U2gasiC/qhxM/mCDkzHcsdpHyOBwrr+cNja+FCcCynk=;
 b=RvKROz6HF1ZlsqJu/R021qcJz/E0Q0bKhYg/XgjDSRIQwYZM8l7aqfX7PrV707QZ9O
 f6cWyfI5KSkVLj9FigWdUtTokpnco4vBQuLDrdWZbIjIHtFeutCl976gWFJYPEDfviJb
 +s9lhjoAqOo0B+oRQlRTYhCVRUcUbDGk+3/5NFSVR2SuirOuA1iNw89kOZTX14Zx7i5j
 KVi/tQyuzKofKYIXHKjP8tMWZjzAXSZ6CooReiNSo4hfhL/YzhxgpC1yaD00jXWS4SGj
 /qe5QvsKkwx2pdwW7MBDHjGennTzj2ydQbeAqZkJaNZIZ5s0KdVohDlaxtmffqZeZmMr
 wRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710949526; x=1711554326;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2gasiC/qhxM/mCDkzHcsdpHyOBwrr+cNja+FCcCynk=;
 b=sJ7P+oUFgk37BdhLkc7Lu71sgLqBzQN7o0kCmwMghZyXwE5fySKElYfRoVWaArD4TV
 YBOpybwfA1365ju1x4vjMun0/sxAePpQzqF+2syqkqIhYMC1ta5r4+F1IIRHUFK5m46g
 BcltPFTTGUKkIMftFQkSBGxEA+5diDL+obT4Eak1rbC/MhsEsEe3AjosRNl5BuOYlFfB
 8CeR/RjMZCsCYEyvei9Cut2dYANSnY0KTdZKBzGgobUTRyaokiSjC4Th+i4+l/emcY5T
 nHV1W+5M2WrlLTGVbFgk18rQN7wpLZ8WE9otHwszIOxiugvouFXUOXkRwCajBeD5evtY
 Sazg==
X-Gm-Message-State: AOJu0Yytht3YJf/sb4T/fAjVjJspLsBMm+NCepN24pGz/GUhjbeufHJb
 67a+p41jD/EUAJiN/z36FSjZr6q97BTm9XeDqWMhiCznMc0/Sas7xEXaEQtZ59w=
X-Google-Smtp-Source: AGHT+IFoJUVgTyZj4BqYDJ5aw9JmzV4hOcMSUs9sBmCgjV01gGr/TbgZsD21KXDlTfohm2LA4f5EWg==
X-Received: by 2002:a17:906:595:b0:a46:9be4:6037 with SMTP id
 21-20020a170906059500b00a469be46037mr39329ejn.30.1710949525979; 
 Wed, 20 Mar 2024 08:45:25 -0700 (PDT)
Received: from [192.168.7.120]
 (cpc81487-lanc8-2-0-cust139.3-3.cable.virginm.net. [81.110.179.140])
 by smtp.gmail.com with ESMTPSA id
 ho16-20020a1709070e9000b00a4672fb2a03sm7377844ejc.10.2024.03.20.08.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 08:45:25 -0700 (PDT)
Message-ID: <e101c3b1c171a828ef34983aa448ced52bb934ee.camel@suse.com>
Subject: Re: [PATCH 9/9] docs/system: Add documentation on support for IGVM
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel
 <jroedel@suse.com>
Date: Wed, 20 Mar 2024 15:45:24 +0000
In-Reply-To: <ZfhqEL0-wCiDJJtm@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <2f98be192cf6ffd36b984266570ea2eed4dfe364.1709044754.git.roy.hopkins@suse.com>
 <ZeIL9Tco7PCRxdg-@redhat.com>
 <46d91ba880f566e7ced7c01b18682b749185c9ba.camel@suse.com>
 <ZfhqEL0-wCiDJJtm@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::52b;
 envelope-from=roy.hopkins@suse.com; helo=mail-ed1-x52b.google.com
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

On Mon, 2024-03-18 at 16:21 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 18, 2024 at 03:59:31PM +0000, Roy Hopkins wrote:
> > On Fri, 2024-03-01 at 17:10 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > On Tue, Feb 27, 2024 at 02:50:15PM +0000, Roy Hopkins wrote:
> > > > IGVM support has been implemented for Confidential Guests that supp=
ort
> > > > AMD SEV and AMD SEV-ES. Add some documentation that gives some
> > > > background on the IGVM format and how to use it to configure a
> > > > confidential guest.
> > > >=20
> > > > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > > > ---
> > > > =C2=A0docs/system/igvm.rst=C2=A0 | 58 +++++++++++++++++++++++++++++=
++++++++++++++
> > > > =C2=A0docs/system/index.rst |=C2=A0 1 +
> > > > =C2=A02 files changed, 59 insertions(+)
> > > > =C2=A0create mode 100644 docs/system/igvm.rst
> > >=20
> > >=20
> > > > +Firmware Images with IGVM
> > > > +-------------------------
> > > > +
> > > > +When an IGVM filename is specified for a Confidential Guest Suppor=
t
> > > > object
> > > > it
> > > > +overrides the default handling of system firmware: the firmware im=
age,
> > > > such
> > > > as
> > > > +an OVMF binary should be contained as a payload of the IGVM file a=
nd
> > > > not
> > > > +provided as a flash drive. The default QEMU firmware is not
> > > > automatically
> > > > mapped
> > > > +into guest memory.
> > >=20
> > > IIUC, in future the IGVM file could contain both the OVMF and SVSM
> > > binaries ?
> > >=20
> > > I'm also wondering if there can be dependancies between the IGVM
> > > file and the broader QEMU configuration ?=C2=A0 eg if SVSM gains suup=
port
> > > for data persistence, potentially we might need some pflash device
> > > exposed as storage for SVSM to use. Would such a dependancy be
> > > something expressed in the IGVM file, or would it be knowledge that
> > > is out of band ?
> > >=20
> > Yes, the IGVM file can indeed contain both OVMF and SVSM binaries. In f=
act,
> > that
> > is exactly what we are doing with the COCONUT-SVSM project. See [1] for=
 the
> > IGVM
> > builder we use to package OVMF, bootloader components and the SVSM ELF
> > binary.
> >=20
> > Data persistence is something that is definitely going to be needed in =
the
> > SVSM.
> > At present, this cannot be configured using any of the directives in th=
e
> > IGVM
> > specification but instead requires QEMU to be configured correctly to
> > support
> > the application embedded within the IGVM file itself. You could however
> > populate
> > metadata pages using IGVM that describe the storage that is _expected_ =
to be
> > present, and validate that within the firmware itself.=20
> >=20
> > The real value from IGVM comes from the ability to describe the initial
> > memory
> > and initial CPU state which all forms part of the launch measurement an=
d
> > initial
> > boot procedure, allowing the expected launch measurement to be calculat=
ed
> > from a
> > single IGVM file for multiple virtualisation stacks or configurations. =
Thus,
> > most of the directives in the IGVM file directly have an effect on the
> > launch
> > measurement. I'm not sure configuring a storage device or other hardwar=
e
> > configuration fits well with this.
>=20
> Yeah, I can understand if IGVM scope should be limited to just memory
> and CPU setup.
>=20
> If we use the firmeware descriptor files, we could define capabilities
> in that to express a need for a particular type of persistent storage
> to back the vTPM. So having this info in IGVM files isn't critical.

I'll need to look into firmware descriptor files as I'm unfamiliar with how=
 they
work. Would I need to make any additions to this patch series to support th=
is in
QEMU? Or is this all handled by libvirt?

>=20
> > > Finally, if we think of the IGVM file as simply yet another firmware
> > > file format, then it raises of question of integration into the
> > > QEMU firmware descriptors.
> > >=20
> > > Right now when defining a guest in libvirt if you can say 'type=3Dbio=
s'
> > > or 'type=3Duefi', and libvirt consults the firmware descriptors to fi=
nd
> > > the binary to use.
> > >=20
> > > If the OS distro provides IGVM files instead of traditional raw OVMF
> > > binaries for SEV/TDX/etc, then from libvirt's POV I think having this
> > > expressed in the firmware descriptors is highly desirable.
> > >=20
> >=20
> > Whether IGVM is just another firmware file format or not, it certainly =
is
> > used
> > mutually exclusively with other firmware files. Integration with firmwa=
re
> > descriptors does seem to make sense.=C2=A0
> >=20
> > One further question if this is the case, would we want to switch from
> > specifying an "igvm-file" as a parameter on the "ConfidentialGuestSuppo=
rt"
> > object to providing the file using the "-bios" parameter, or maybe even=
 a
> > dedicated "-igvm" parameter?
>=20
> If the IGVM format is flexible enough that it could be used for any VM
> type, even non-confidential VMs, then having its config be separate from
> ConfidentialGuestSUpport would make sense. If it is fundamentally tied
> to CVMs, then just a property is fine I guess.
>=20
> Probably best to stay away from -bios, to avoid overloading new semantics
> onto a long standing argument.
>=20
> With regards,
> Daniel

Currently, the IGVM specification only contains support for confidential
platforms.=C2=A0It could theoretically be used for non-confidential platfor=
ms but
that would require changes to the IGVM specification itself to support this=
. I
don't think it makes sense to extend this to non-confidential VMs until the
specification supports this, so I'll leave it as a property of
ConfidentialGuestSupport.


Regards,
Roy

