Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3120EFD7F98
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvwDf-0007Cm-Of; Fri, 27 Feb 2026 06:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvwDb-0007CV-18
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvwDY-0005Xe-M1
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772192471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rPcxh9OKX8V2vErua26EY6iB72av5LubOvXoLWlwqs=;
 b=Ay4Nwie4q5OyXLYPLKF5Fj0ZSsepIVledYO9FfLy/brbbXTYpc1NIOxlnqgCJiXXE/BSn8
 XjyJUjfaxHdF+vHePJIca8ZpaM9eg0Iu6wxe5URVrWZo2IK4QE51h2Mx7Olpqx3jrZQf7Y
 sZYNWiRTNKfSauvF3gGyJCalfi15W3o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-eudxrtomMnCXb7EteiyniQ-1; Fri, 27 Feb 2026 06:41:09 -0500
X-MC-Unique: eudxrtomMnCXb7EteiyniQ-1
X-Mimecast-MFC-AGG-ID: eudxrtomMnCXb7EteiyniQ_1772192469
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so9679805e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 03:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772192468; x=1772797268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rPcxh9OKX8V2vErua26EY6iB72av5LubOvXoLWlwqs=;
 b=NiNFnQczq8LmztluJvkQ8Gra4zo/0CFfGLZbyGGkrfUNYSDMYFXOTo9wu9NkNM65L8
 ATcFFdf5nuVT8swkJAeYd0C3g7UdICifhbKruORo3CAH3v/7KepLOzrTqEovhCtZJe3P
 ehx8NMsVYr2+XpRKTN582dzeBiqE/AX98eUhKbb4ASZvrxk9a7EnckoBfR6P1j8IYwK+
 C9mVwUPKTr2OsRIAckeKg8ZBlpGzRzDs5umE00rNkeFRplkBmbY80IRsJTH5fnpMlTAc
 IHOn2n00mIl+oaxXx4XCQUxn3qtJiGUmLMbVc+7Htoe4w0+e5Q1GohFPUkuQE6lA8zw+
 2E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772192468; x=1772797268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9rPcxh9OKX8V2vErua26EY6iB72av5LubOvXoLWlwqs=;
 b=XGgheqQNpOrqGp2Qw6CCgHun+oJF3gD7N6i9aD/mRnpq6UB0F5BSivKxtZUFZlL+YZ
 r3iQxf8Tkvz0hfAUzLc/5qHw5cvlShpydX9KQ2cB8lAMO0zuY8ygXkXURMpc/X+5lnR/
 rMIHqa9lGCoQLvaG6Wy1PA7Y8P8TpDELf2rmsF/8Aj0IibQkR2+jnPncGziFD+IpWZ0o
 /M5kP4KOiUr64hwRwtlWnxYn8TNX0QQ9KvG3MI3VKKx0ex4L/Sv8bArZ9OvdClmHs7vb
 ny5n4/jWqoauHIkW3vRHNk7djKTqaymRS6uk73LdcUi+205QHDIMQailCfaD1Xd/RG5v
 EbmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/sE+6z/uA9TPoRgm7x9eANfDvTt4Mwul4lKFPmAwhFq3EkJNgM4/8Lkf4oKwk5P/RjUv8HOjpUm3u@nongnu.org
X-Gm-Message-State: AOJu0YyXbXYVZTl8WvAM09BuTOUUd5Ln4/ugSHIYwTVrtK6DoP5x+fB8
 jg1qfY6ndFbhbdM3vnNRijO6TW7GKM2euGnWE7KR2jnNrFPjAChpLs3nlH+8dl6cPw9yxuq4ZJj
 +vz/OtaC99yAsKL78sW5vIdRCi0ZkERptcdsiFMETCpZ8c2Y1R9OSmmoeC4hfh0mB
X-Gm-Gg: ATEYQzz7hNHvdpui1PKcmqowv+SjpxF2b7jWlvj28y8lyrDtd+9XHe1wJevDtEC3AMr
 As2w/6noCCWMZiCkFTtWGJ4hvjxKr+tq07OCYEJk6aEHAh5YhY7Y+Xc2E1CTzo10u9J8a9LCjyp
 YsPLDxiAicHf6CfIAw4QaZx68sOyVdGFd/Z+J18VRUcQvMjlIKq86kcG38mr8457tiDjq6mliFS
 es3gmqR/KoWWOWYf/FLLY4m1DdWCDMWD759gVVBNxdj/gUcVOMKVPKLGRgxYuoSP9ZSHnU0al72
 zfMT2zeR6PxIJH10JWN3GPpbwyLtBm+pJ70a7yw0PYTv4lY8sttvrT8lbii0Pp3FYKg0F/pVLgz
 LUOjfOQ==
X-Received: by 2002:a05:600c:4f94:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-483c9bdb6b7mr31222155e9.34.1772192468234; 
 Fri, 27 Feb 2026 03:41:08 -0800 (PST)
X-Received: by 2002:a05:600c:4f94:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-483c9bdb6b7mr31221545e9.34.1772192467675; 
 Fri, 27 Feb 2026 03:41:07 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm206230125e9.1.2026.02.27.03.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 03:41:07 -0800 (PST)
Date: Fri, 27 Feb 2026 12:41:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <20260227124105.44c3b75d@imammedo>
In-Reply-To: <aaFvcWnmE7dOiK-o@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
 <aaFdZY5ESpQCJigY@redhat.com> <20260227110125.1d46e695@imammedo>
 <aaFvcWnmE7dOiK-o@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 27 Feb 2026 10:18:25 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Feb 27, 2026 at 11:01:25AM +0100, Igor Mammedov wrote:
> > On Fri, 27 Feb 2026 09:01:25 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Fri, Feb 27, 2026 at 08:24:42AM +0100, Markus Armbruster wrote: =20
> > > > Igor Mammedov <imammedo@redhat.com> writes:
> > > >    =20
> > > > > On Wed, 25 Feb 2026 15:19:56 +0000
> > > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:   =20
> > > > >>=20
> > > > >> Right, if there was a case where we were already using -device to
> > > > >> create the watchdog, then I would suggest having a simple
> > > > >> 'wadt=3Don|off' property as standard for any watchdog wanting th=
at
> > > > >> ACPI abstraction wrapper.
> > > > >>=20
> > > > >> That could (hypothetically) be the case if we had chosen to add
> > > > >> WADT suport backed by i6300esb, eg -device i6300esb,wadt=3Don|off
> > > > >>=20
> > > > >> For cases built-in to the machine type, I'd suggest <type>-wadt=
=3Don|off
> > > > >>=20
> > > > >> eg for Q35,  "-machine q35,itco-wadt=3Don|off"
> > > > >>=20
> > > > >> for virt, '-machine virt,gwdt-wadt=3Don|off'   =20
> > > > >
> > > > > CCin Markus since it touches QAPI stuff.
> > > > >
> > > > > For respin, I've went ahead with a bit more generic approach
> > > > > (as a user, I wouldn't really care what kind of built-in watchdog=
 board ships,
> > > > > and having 1 property instead total instead of machine specific o=
nes makes it
> > > > > easier for mgmt layer to deal with).
> > > > >
> > > > > here is current idea:
> > > > >
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index 6411e68856..a0c6719b58 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -1257,6 +1271,14 @@ static void machine_class_init(ObjectClass=
 *oc, const void *data)
> > > > >          NULL, NULL);
> > > > >      object_class_property_set_description(oc, "memory",
> > > > >          "Memory size configuration");
> > > > > +
> > > > > +    object_class_property_add_enum(oc, "watchdog", "WatchdogType=
",
> > > > > +        &WatchdogType_lookup,
> > > > > +        machine_get_watchdog, machine_set_watchdog);
> > > > > +     object_class_property_set_description(oc, "watchdog",
> > > > > +        "Use: auto (watchdog is configured according board defau=
lts),"
> > > > > +        " off (disabled), native (built-in watchdog), wdat (ACPI=
 based watchdog)]. "
> > > > > +        " Default: auto");
> > > > >  }   =20
> > > >=20
> > > > Adds the property to abstract base type "machine", i.e. every machi=
ne
> > > > has it.
> > > >=20
> > > > Fundamentally assumes there is at most one onboard watchdog of inte=
rest.
> > > >=20
> > > > I'm lacking context, please bear with me: who or what is going to s=
et
> > > > this property, and for what purpose?
> > > >    =20
> > > > > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > > > > index 92e84dfb14..7f5e10340f 100644
> > > > > --- a/qapi/machine-common.json
> > > > > +++ b/qapi/machine-common.json
> > > > > @@ -9,6 +9,23 @@
> > > > >  # Common machine types
> > > > >  # ********************
> > > > >  ##
> > > > > +##
> > > > > +# @WatchdogType:
> > > > > +#
> > > > > +# On board watchdog configuration.
> > > > > +#
> > > > > +# @auto: Watchdog is configured according to board defaults.   =
=20
> > > >=20
> > > > As far as I can tell, we don't document "boards" (machine types)
> > > > anywhere, let alone "board defaults".  Not this patch's fault, of
> > > > course.  The meaning of @auto remains unclear.
> > > >    =20
> > > > > +#
> > > > > +# @off: Watchdog disabled (ARM).
> > > > > +#
> > > > > +# @native: Native watchdog (arm/virt: sbsa-gwdt, x86/q53: TCO)
> > > > > +#
> > > > > +# @wdat: ACPI WDAT watchdog.
> > > > > +#
> > > > > +# Since: 10.2   =20
> > > >=20
> > > > 11.0
> > > >    =20
> > > > > +##
> > > > > +{ 'enum': 'WatchdogType',
> > > > > +  'data': [ 'auto', 'off', 'native', 'wdat' ] }   =20
> > > >=20
> > > > What do managament applications need to know about onboard watchdog
> > > > configuration?
> > > >=20
> > > > Do they need to know what @auto means for the machine type at hand?
> > > >=20
> > > > Do they ever need to pick a value?  Do they need to know which valu=
es
> > > > work with the machine type then?   =20
> > >=20
> > > Libvirt generally wants to work with & express the exact hardware
> > > and not rely on "auto" settings in QEMU.
> > >=20
> > > So in terms of the built-in watchdog for Q35 we currently express
> > > this explicitly via
> > >=20
> > >     <watchdog model=3D'itco' /> =20
> >=20
> > not specifying above libvirt doesn't make itco go away on qemu side,
> > it's still there regardless of above. =20
>=20
> That is fine. Libvirt will synthesize a <watchdog> device to
> represent & track the built-in default hardware, if the mgmt
> app did not specify it explicitly.
>=20
>=20
>=20
> > > Adding "WADT" is not expressing a new piece of hardware, just a
> > > configuration choice of the iTCO hardware. So from that POV in
> > > libvirt I anticipate expressing it as
> > >=20
> > >     <watchdog model=3D'itco' wadt=3D'yes|no'/>
> > >
> > > IMHO, similar reasoning works at the QEMU level - WADT is not a
> > > new type of watchdog hardware, just a config choice supported
> > > with certain specific QEMU watchdogs. So I'd prefer something
> > > closer to what I suggested in the mail that Igor replies to,
> > > where we have a simple boolean flag to control use of WADT,
> > > and other distinct properties if we need other controls on the
> > > watchdog, instead of trying overload multiple distinct settings
> > > into one enum.
> > >=20
> > > For Arm we would similarly want to express the choice of
> > > hardware directly as
> > >=20
> > >    <watchdog model=3D'gwdt'/> =20
> > for gwdt it's more than just adding extra ACPI table,
> > with wdat knob, watchdog entry in GTDT table should be disabled
> > and gwdt itself should be wired to use different freq
> > (in the end it's different hw that happens to use the same registers/
> > protocol). =20
>=20
> That doesn't really sound that different to me.  If enabling WADT
> implies disabling GTDT that's ok, likewise if Peter wants DT to be
> available in parallel that's ok too. We can cope with modelling
> either approach in libvirt

with wdat enabled not only GTDT part but also a corresponding DT node should
be hidden from guest as they assume gwdt running at different frequency.

As for exposing both GTDT along with DT node when wdat is disabled,
quick test shows that it works for linux and Windows (if one considers
unusable Windows driver as works).
Both pickup GTDT definition just fine and
with ACPI disabled, linux guest fallbacks to DT and uses DT node
to create watchdog device node.

>=20
> > if we make it built-in, we would need in addition to virt.wadt alias
> > also have virt.watchdog=3D[on|off] to manage creation.  =20
>=20
>=20
>=20
> With regards,
> Daniel


