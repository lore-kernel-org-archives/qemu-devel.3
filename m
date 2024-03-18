Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346A6C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFOq-0006lJ-C5; Mon, 18 Mar 2024 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmFOp-0006hc-Bt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:59:43 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmFOl-0001ST-KH
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:59:43 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d29aad15a5so55693691fa.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710777576; x=1711382376; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o/LvVDRtjQZQbX8Tz6ilnF10Zuz/qf2OT0JECsBqApo=;
 b=SSmguG/xGiYnnV3X36F1OI6ABERSvpQxGMCmlPeYqw3xi3fXx1yqo0JkDgkwvv0RES
 tELUD+ayCpr+pJ+6uztZ3lJhtgsaihxOqz/sKXm732Hm5oD1jCGG9axrLGKVrr7C+23C
 HAnVnKsWjzD/aIZO5ev5fcb/IEY/1iiKafgqI01ErpDq+V+MlTb1s4m3YD8S/R0g239+
 TTZceJFxqE250eThG1212jmSZXKM1qvTOBD/BJhWUy5lJqNqHA81jdqRipPneVAagGdH
 4tW+2szb5PuMrCeNA7/5zhv/h1gTp0Y11+CQLe5Phm2Lraa8kE9Uwy3e6sLW2YlC9HiO
 eTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710777576; x=1711382376;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/LvVDRtjQZQbX8Tz6ilnF10Zuz/qf2OT0JECsBqApo=;
 b=TVnuTUEPsY2R91K3eghJPVDrJHNLdS76SYLKCR9lr1DYoYvo56GLJ5QyWV18AHdWON
 u20nqxZ5PKX6q4CvF6GEttXktz4BadRQEMY29Pt3iyPKiCsS9E50AGQGcjBVfHUvsZkg
 +7rOfp3kHgzAZ2pBySGWSMf24Q4wLAUTB6lHQJMr9Wb55xCkPzPN9L7jXv3oaaUcgroH
 wTPA7j+qyj+rTtiy2pO9Peld5HnK452ln12G1i1vHRwbYXBhliNTMHxwngbAfAIjKGXx
 etQpg28hDrhaatXuJakLJVbIhpwbWBDJfNhREt+8Mm5DPeEGnqsagX71Xef+IW5Qm9Sk
 6kTg==
X-Gm-Message-State: AOJu0Yw4J8NS/XAjTj7Iulm4jDmifWP4IkNNGptS4b4DYcyUWkcs/cKz
 0y2IwsjrZZ3B3DT0lZun6P7sCPaCQh5ztjaGbSDbrl1f10rKa6WQp0eIzg8Zkqs=
X-Google-Smtp-Source: AGHT+IG5JSm5cYTPVjhA4l0UdbChxv4C4+TOrwXC1Nrz628DZA0PTyPjwqUG2Ks5Y0Rpw1lXmR6qfw==
X-Received: by 2002:a2e:9b07:0:b0:2d3:8b2:6885 with SMTP id
 u7-20020a2e9b07000000b002d308b26885mr6202699lji.49.1710777575720; 
 Mon, 18 Mar 2024 08:59:35 -0700 (PDT)
Received: from [192.168.7.166]
 (cpc81487-lanc8-2-0-cust139.3-3.cable.virginm.net. [81.110.179.140])
 by smtp.gmail.com with ESMTPSA id
 jm2-20020a0561306a4200b007da11ecd37fsm1072926uab.24.2024.03.18.08.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:59:35 -0700 (PDT)
Message-ID: <46d91ba880f566e7ced7c01b18682b749185c9ba.camel@suse.com>
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
Date: Mon, 18 Mar 2024 15:59:31 +0000
In-Reply-To: <ZeIL9Tco7PCRxdg-@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <2f98be192cf6ffd36b984266570ea2eed4dfe364.1709044754.git.roy.hopkins@suse.com>
 <ZeIL9Tco7PCRxdg-@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::22d;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x22d.google.com
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

On Fri, 2024-03-01 at 17:10 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 27, 2024 at 02:50:15PM +0000, Roy Hopkins wrote:
> > IGVM support has been implemented for Confidential Guests that support
> > AMD SEV and AMD SEV-ES. Add some documentation that gives some
> > background on the IGVM format and how to use it to configure a
> > confidential guest.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > =C2=A0docs/system/igvm.rst=C2=A0 | 58 +++++++++++++++++++++++++++++++++=
++++++++++
> > =C2=A0docs/system/index.rst |=C2=A0 1 +
> > =C2=A02 files changed, 59 insertions(+)
> > =C2=A0create mode 100644 docs/system/igvm.rst
>=20
>=20
> > +Firmware Images with IGVM
> > +-------------------------
> > +
> > +When an IGVM filename is specified for a Confidential Guest Support ob=
ject
> > it
> > +overrides the default handling of system firmware: the firmware image,=
 such
> > as
> > +an OVMF binary should be contained as a payload of the IGVM file and n=
ot
> > +provided as a flash drive. The default QEMU firmware is not automatica=
lly
> > mapped
> > +into guest memory.
>=20
> IIUC, in future the IGVM file could contain both the OVMF and SVSM
> binaries ?
>=20
> I'm also wondering if there can be dependancies between the IGVM
> file and the broader QEMU configuration ?=C2=A0 eg if SVSM gains suupport
> for data persistence, potentially we might need some pflash device
> exposed as storage for SVSM to use. Would such a dependancy be
> something expressed in the IGVM file, or would it be knowledge that
> is out of band ?
>=20
Yes, the IGVM file can indeed contain both OVMF and SVSM binaries. In fact,=
 that
is exactly what we are doing with the COCONUT-SVSM project. See [1] for the=
 IGVM
builder we use to package OVMF, bootloader components and the SVSM ELF bina=
ry.

Data persistence is something that is definitely going to be needed in the =
SVSM.
At present, this cannot be configured using any of the directives in the IG=
VM
specification but instead requires QEMU to be configured correctly to suppo=
rt
the application embedded within the IGVM file itself. You could however pop=
ulate
metadata pages using IGVM that describe the storage that is _expected_ to b=
e
present, and validate that within the firmware itself.=20

The real value from IGVM comes from the ability to describe the initial mem=
ory
and initial CPU state which all forms part of the launch measurement and in=
itial
boot procedure, allowing the expected launch measurement to be calculated f=
rom a
single IGVM file for multiple virtualisation stacks or configurations. Thus=
,
most of the directives in the IGVM file directly have an effect on the laun=
ch
measurement. I'm not sure configuring a storage device or other hardware
configuration fits well with this.


> Finally, if we think of the IGVM file as simply yet another firmware
> file format, then it raises of question of integration into the
> QEMU firmware descriptors.
>=20
> Right now when defining a guest in libvirt if you can say 'type=3Dbios'
> or 'type=3Duefi', and libvirt consults the firmware descriptors to find
> the binary to use.
>=20
> If the OS distro provides IGVM files instead of traditional raw OVMF
> binaries for SEV/TDX/etc, then from libvirt's POV I think having this
> expressed in the firmware descriptors is highly desirable.
>=20

Whether IGVM is just another firmware file format or not, it certainly is u=
sed
mutually exclusively with other firmware files. Integration with firmware
descriptors does seem to make sense.=C2=A0

One further question if this is the case, would we want to switch from
specifying an "igvm-file" as a parameter on the "ConfidentialGuestSupport"
object to providing the file using the "-bios" parameter, or maybe even a
dedicated "-igvm" parameter?

>=20
> With regards,
> Daniel

[1] COCONUT IGVM builder:
https://github.com/coconut-svsm/svsm/tree/main/igvmbuilder

Regards,
Roy

