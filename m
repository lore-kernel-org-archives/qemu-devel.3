Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327CAC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9LX-0001g1-DS; Fri, 28 Jun 2024 07:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sN9LW-0001fp-M2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:00:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sN9LT-0007It-Dz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:00:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-424ad289949so3673205e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719572444; x=1720177244; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uQDuMOEtGRYXUaHHMkEYwl2bIk9ik6NqJzOyhQ9D+Fs=;
 b=DeRzlynmBRrun+2BwXQBt2RLEJ3zDxY92V6rW6sUqEK4dv0I6Uybur3ZDcdDUJSctA
 LXBVeySZ28B6aHOcQXZLvkb4wbIv9yykgbs2Cw11o5b1q3Mj6MPMuX0jOzQVsDTme7Us
 AYGAzBwZWPzQRQI7TXMDt6MjXbihth8GHo6SedDGdbOb9YWRsx11vYpb6j2CLw/Z7f52
 99BdFavZqTtCN3vp0badB/NtwljRC8jhJovqLzJfcf0ZxEOdcQz6EuGOuCnT8J+gVxdd
 jGOEWiBLrwyZ4cB0DTBeTejlyKdZwJFAsno+HxHmT8S4RZt/vtmi/q7FMBhEGj1bviCd
 kDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719572444; x=1720177244;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uQDuMOEtGRYXUaHHMkEYwl2bIk9ik6NqJzOyhQ9D+Fs=;
 b=Mxn95gskHlUO+MyqpqsqJVIeHcvBpVYS8qtn681ivTUduHUAKn4KT42uE0SCBXOi3H
 fN+q2NuNb5QHSxqx3/9AmsGtIOkuq/3E/p6zkKBMaboqHJA2fmR/8J20K4Br/oSfPkYo
 ny6ToI4fOvgIPQ2JYB2T3sqKaDKDlZ1V40yWTO+FdOLLBHThrU5U/BgqtvHHDVAU6XWl
 UJdAIC67KumdyTMKK6oOsTql/u3kIYfnHF9r21aI10zunTl+lgvC1HmKrhxzEhDC5bPF
 8be5OBbLgjmbNlYsJ2vkyI7qoExeXef1CaREPUhUb9cmBl9z6y1WvtSXYFcj2l0sRxne
 a9RA==
X-Gm-Message-State: AOJu0YwoxfRFFgyl6f0UUexCA1xIsa4DsJaol6tiZ7wimmnCaZLUHrZy
 +ko6ZChsTKiwtSpAOwmBqifeYcSz5d8ezOEDlApTcOqeJeD8hGPQ7fwkNPqoQRhCnPk8cLQhvfy
 kKTU=
X-Google-Smtp-Source: AGHT+IGycLBtCz2s8DYGFLprraM6MrR16+aoyYjIpp9QYMo9FFPabXLupX3e4jCvOCFUj/dNptWrKw==
X-Received: by 2002:a7b:cb0f:0:b0:421:f4da:f4b with SMTP id
 5b1f17b1804b1-4248b9ece43mr104628095e9.40.1719572443857; 
 Fri, 28 Jun 2024 04:00:43 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5ba67sm29986025e9.19.2024.06.28.04.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 04:00:43 -0700 (PDT)
Message-ID: <3c0e63f8aa27f550f95b3b25623d7d759acf76cf.camel@suse.com>
Subject: Re: [PATCH v3 03/15] backends/igvm: Add IGVM loader and configuration
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Fri, 28 Jun 2024 12:00:43 +0100
In-Reply-To: <Zn0taV-uq0MlSalm@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <31e19ee36bdbf0ba91d95bc2d71865d7d0007ff1.1718979106.git.roy.hopkins@suse.com>
 <jyfhkynory4jydxrlx7cfvbrnibq2klk5lekn656gcob4kls6m@3u7qugxmxjsq>
 <Zn0taV-uq0MlSalm@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::32a;
 envelope-from=roy.hopkins@suse.com; helo=mail-wm1-x32a.google.com
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

On Thu, 2024-06-27 at 10:14 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jun 27, 2024 at 11:06:50AM +0200, Stefano Garzarella wrote:
> > On Fri, Jun 21, 2024 at 03:29:06PM GMT, Roy Hopkins wrote:
> > > Adds an IGVM loader to QEMU which processes a given IGVM file and
> > > applies the directives within the file to the current guest
> > > configuration.
> > >=20
> > > The IGVM loader can be used to configure both confidential and
> > > non-confidential guests. For confidential guests, the
> > > ConfidentialGuestSupport object for the system is used to encrypt
> > > memory, apply the initial CPU state and perform other confidential gu=
est
> > > operations.
> > >=20
> > > The loader is configured via a new IgvmCfg QOM object which allows th=
e
> > > user to provide a path to the IGVM file to process.
> > >=20
> > > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > > ---
> > > qapi/qom.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +
> > > backends/igvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 37 ++
> > > include/sysemu/igvm-cfg.h |=C2=A0 54 +++
> > > backends/igvm-cfg.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 66 ++=
++
> > > backends/igvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 791 ++++++++++++++++++++++++++++++++++++++
> > > backends/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > 6 files changed, 966 insertions(+)
> > > create mode 100644 backends/igvm.h
> > > create mode 100644 include/sysemu/igvm-cfg.h
> > > create mode 100644 backends/igvm-cfg.c
> > > create mode 100644 backends/igvm.c
> > >=20
> > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > index 8bd299265e..e586707c4c 100644
> > > --- a/qapi/qom.json
> > > +++ b/qapi/qom.json
> > > @@ -874,6 +874,18 @@
> > > =C2=A0 'base': 'RngProperties',
> > > =C2=A0 'data': { '*filename': 'str' } }
> > >=20
> > > +##
> > > +# @IgvmCfgProperties:
> > > +#
> > > +# Properties common to objects that handle IGVM files.
> > > +#
> > > +# @file: IGVM file to use to configure guest (default: none)
> > > +#
> > > +# Since: 9.1
> > > +##
> > > +{ 'struct': 'IgvmCfgProperties',
> > > +=C2=A0 'data': { '*file': 'str' } }
> >=20
> > =C2=A0=C2=A0=C2=A0 'if': 'CONFIG_IGVM'
> >=20
> > I recently did a similar modification to QAPIs and Markus suggested to =
add
> > the if here as well, see
> > https://lore.kernel.org/qemu-devel/87zfs2z7jo.fsf@pond.sub.org/
>=20
> Yes, it avoids the code generator emitting an otherwise unusd
> struct when CONFIG_IGVM is unset.

Thanks. I'll add that change.

>=20
>=20
> With regards,
> Daniel


