Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EC7CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 12:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6q7Z-0002vL-31; Thu, 09 Oct 2025 08:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v6q7U-0002v8-6P
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v6q7O-0005fi-Np
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760014293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zol2J4ObuodIwQfQ/7QAzSmiVw6roWxQLGHZuPMy4wU=;
 b=Xc2AecuypNQ1hN4/5NeHlhp0wOtw+0afSUjNk+TRhohbKW4ZC5kb/gzqFCSkBBsEFefTTL
 e5jXCl5SxfvTVA9k7VfLKrmvOgVbRkUKe0Ra/7Bk66zua7sZkXJb39YpZA2fQ96nAzzmjP
 Jg7z8Z9l9Vwz57w6VQEUbjEGKdM4amo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-o13U-WIOO2-jsfp1ZpaORA-1; Thu, 09 Oct 2025 08:51:31 -0400
X-MC-Unique: o13U-WIOO2-jsfp1ZpaORA-1
X-Mimecast-MFC-AGG-ID: o13U-WIOO2-jsfp1ZpaORA_1760014290
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so931026f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 05:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760014290; x=1760619090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zol2J4ObuodIwQfQ/7QAzSmiVw6roWxQLGHZuPMy4wU=;
 b=oVcnqpJIk3nNApprBcfWP3iNRgwTOcIsmO7iLTyor/lAlhSHNjTB7LyHFp8sq3EyEW
 jkLCY3O6sY0HtimEmP0fjZtDqU3U1ZSPNTeDwmiaxJZTZmI7D3pwPbpQpeTAChSGbfRF
 KF8RnIkmYj52Xd9ApzW/fZk99PLeWCQxvHDpmC/I3vWtpWcdFraisRjYdU7quozL+M9E
 QzQZoLpeAHrYA37ba+/saGPmG6xQxrin12iQLlQu4mWU/EirLIeXdvT0/HOgZSBF+z2s
 eSqVXqCm1x2EmpWifETCco7mdlT+T3eUNfMu3rQS2o/FKTM5X4S4K3g0GX3f1Lf6ruNr
 gFAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+yGWURE+D6WwuS7ntgwJ1aWOTKP0/jM+gYuy1QY0zaNCv6WXn4XJ08LJuqzoJVlTmkfUsop1EM2Tu@nongnu.org
X-Gm-Message-State: AOJu0YwquZqBpnQS4Vuo/w0z4MmmvK74QIbDzzRLGwzqYPyNN/GkrxL8
 U34bZsN18XlFWBD6DuUGC9Z89MsHKYhTH3ZL17toJ4JxjwKOeXMfQZpDwjuZ6EnnLK+YnIhs675
 73XosjphTjxh4BgaQpLPrsMVy+d4i370bCmePKV4ivD77SVKOLH+z/ut7
X-Gm-Gg: ASbGnctJD8lUtPX67AW+Qr8InOxgcQIK9Ibxnz8/G1M01anWQmWm3snVoBKyOi4aL18
 ALjcvfTNsH4cCGoZeOqIQlOOlHrZ0MH72Vm9LwQY4/aGDLiODHrkz2Ck4vAtPM08rLwF55GDFLm
 20PYinv0Od7tqFWzoz8YHFneyKHOk5SCxWmeGM0fnx6eHosUfa0nQc1CKtFfZ33kjy3ErEsDc9G
 JzN8/95m7qJQ9nTF3P7ya/SAetrlKp6R4h/nltHF0j6iqrzNvxKNBSEGQfGMNgreO2ROaL89LC1
 IwVriTo9rR6fZzezFUyLYe560yPksk0NeErE
X-Received: by 2002:a05:6000:40d9:b0:404:c253:a38 with SMTP id
 ffacd0b85a97d-42582a053d4mr8053089f8f.28.1760014289802; 
 Thu, 09 Oct 2025 05:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkNBloNj6n8d75gMpZvao+iiP90ewDmXHph980mr8fmR4pkfG6rD4lQnmLLfjFRFBwoBSDJA==
X-Received: by 2002:a05:6000:40d9:b0:404:c253:a38 with SMTP id
 ffacd0b85a97d-42582a053d4mr8053017f8f.28.1760014289167; 
 Thu, 09 Oct 2025 05:51:29 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b005dsm34180419f8f.25.2025.10.09.05.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 05:51:28 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:51:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: salil.mehta@opnsrc.net, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, salil.mehta@huawei.com, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, devel@lists.libvirt.org
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
Message-ID: <20251009145125.6583a24a@fedora>
In-Reply-To: <87plawh2sz.fsf@pond.sub.org>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 09 Oct 2025 10:55:40 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> salil.mehta@opnsrc.net writes:
>=20
> > From: Salil Mehta <salil.mehta@huawei.com>
> >
> > This patch adds a "device_set" interface for modifying properties of de=
vices
> > that already exist in the guest topology. Unlike 'device_add'/'device_d=
el'
> > (hot-plug), 'device_set' does not create or destroy devices. It is inte=
nded
> > for guest-visible hot-add semantics where hardware is provisioned at bo=
ot but
> > logically enabled/disabled later via administrative policy.
> >
> > Compared to the existing 'qom-set' command, which is less intuitive and=
 works
> > only with object IDs, device_set provides a more device-oriented interf=
ace.
> > It can be invoked at the QEMU prompt using natural device arguments, an=
d the
> > new '-deviceset' CLI option allows properties to be set at boot time, s=
imilar
> > to how '-device' specifies device creation. =20
>=20
> Why can't we use -device?

that's was my concern/suggestion in reply to cover letter
(as a place to put high level review and what can be done for the next revi=
sion)

(PS: It looks like I'm having email receiving issues (i.e. not getting from
mail list my own emails that it bonces to me, so threading is all broken on
my side and I'm might miss replies). But on positive side it looks like my
replies reach the list and CCed just fine)


> > While the initial implementation focuses on "admin-state" changes (e.g.,
> > enable/disable a CPU already described by ACPI/DT), the interface is de=
signed
> > to be generic. In future, it could be used for other per-device set/uns=
et
> > style controls =E2=80=94 beyond administrative power-states =E2=80=94 p=
rovided the target
> > device explicitly allows such changes. This enables fine-grained runtime
> > control of device properties. =20
>=20
> Beware, designing a generic interface can be harder, sometimes much
> harder, than designing a specialized one.
>=20
> device_add and qom-set are generic, and they have issues:
>=20
> * device_add effectively bypasses QAPI by using 'gen': false.
>=20
>   This bypasses QAPI's enforcement of documentation.  Property
>   documentation is separate and poor.
>=20
>   It also defeats introspection with query-qmp-schema.  You need to
>   resort to other means instead, say QOM introspection (which is a bag
>   of design flaws on its own), then map from QOM to qdev.
>=20
> * device_add lets you specify any qdev property, even properties that
>   are intended only for use by C code.
>=20
>   This results in accidental external interfaces.
>=20
>   We tend to name properties like "x-prop" to discourage external use,
>   but I wouldn't bet my own money on us getting that always right.
>   Moreover, there's beauties like "x-origin".
>=20
> * qom-set & friends effectively bypass QAPI by using type 'any'.
>=20
>   Again, the bypass results in poor documentation and a defeat of
>   query-qmp-schema.
>=20
> * qom-set lets you mess with any QOM property with a setter callback.
>=20
>   Again, accidental external interfaces: most of these properties are
>   not meant for use with qom-set.  For some, qom-set works, for some it
>   silently does nothing, and for some it crashes.  A lot more dangerous
>   than device_add.
>=20
>   The "x-" convention can't help here: some properties are intended for
>   external use with object-add, but not with qom-set.
>=20
> We should avoid such issues in new interfaces.
>=20
> We'll examine how this applies to device_set when I review the QAPI
> schema.
>=20
> > Key pieces:
> >   * QMP: qmp_device_set() to update an existing device. The device can =
be
> >     located by "id" or via driver+property match using a DeviceListener
> >     callback (qdev_find_device()).
> >   * HMP: "device_set" command with tab-completion. Errors are surfaced =
via
> >     hmp_handle_error().
> >   * CLI: "-deviceset" option for setting startup/admin properties at bo=
ot,
> >     including a JSON form. Options are parsed into qemu_deviceset_opts =
and
> >     applied after device creation.
> >   * Docs/help: HMP help text and qemu-options.hx additions explain usag=
e and
> >     explicitly note that no hot-plug occurs.
> >   * Safety: disallowed during live migration (migration_is_idle() check=
).
> >
> > Semantics:
> >   * Operates on an existing DeviceState; no enumeration/new device appe=
ars.
> >   * Complements device_add/device_del by providing state mutation only.
> >   * Backward compatible: no behavior change unless "device_set"/"-devic=
eset"
> >     is used.
> >
> > Examples:
> >   HMP:
> >     (qemu) device_set host-arm-cpu,core-id=3D3,admin-state=3Denable
> >
> >   CLI (at boot):
> >     -smp cpus=3D4,maxcpus=3D4 \
> >     -deviceset host-arm-cpu,core-id=3D2,admin-state=3Ddisable
> >
> >   QMP (JSON form):
> >     { "execute": "device_set",
> >       "arguments": {
> >         "driver": "host-arm-cpu",
> >         "core-id": 1,
> >         "admin-state": "disable"
> >       }
> >     } =20
>=20
> {"error": {"class": "CommandNotFound", "desc": "The command device_set ha=
s not been found"}}
>=20
> Clue below.
>=20
> > NOTE: The qdev_enable()/qdev_disable() hooks for acting on admin-state =
will be
> > added in subsequent patches. Device classes must explicitly support any
> > property they want to expose through device_set.
> >
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  hmp-commands.hx         |  30 +++++++++
> >  hw/arm/virt.c           |  86 +++++++++++++++++++++++++
> >  hw/core/cpu-common.c    |  12 ++++
> >  hw/core/qdev.c          |  21 ++++++
> >  include/hw/arm/virt.h   |   1 +
> >  include/hw/core/cpu.h   |  11 ++++
> >  include/hw/qdev-core.h  |  22 +++++++
> >  include/monitor/hmp.h   |   2 +
> >  include/monitor/qdev.h  |  30 +++++++++
> >  include/system/system.h |   1 +
> >  qemu-options.hx         |  51 +++++++++++++--
> >  system/qdev-monitor.c   | 139 +++++++++++++++++++++++++++++++++++++++-
> >  system/vl.c             |  39 +++++++++++
> >  13 files changed, 440 insertions(+), 5 deletions(-) =20
>=20
> Clue: no update to the QAPI schema, i.e. the QMP command does not exist.
>=20
> >
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index d0e4f35a30..18056cf21d 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -707,6 +707,36 @@ SRST
> >    or a QOM object path.
> >  ERST
> > =20
> > +{
> > +    .name       =3D "device_set",
> > +    .args_type  =3D "device:O",
> > +    .params     =3D "driver[,prop=3Dvalue][,...]",
> > +    .help       =3D "set/unset existing device property",
> > +    .cmd        =3D hmp_device_set,
> > +    .command_completion =3D device_set_completion,
> > +},
> > +
> > +SRST
> > +``device_set`` *driver[,prop=3Dvalue][,...]*
> > +  Change the administrative power state of an existing device.
> > +
> > +  This command enables or disables a known device (e.g., CPU) using the
> > +  "device_set" interface. It does not hotplug or add a new device.
> > +
> > +  Depending on platform support (e.g., PSCI or ACPI), this may trigger
> > +  corresponding operational changes =E2=80=94 such as powering down a =
CPU or
> > +  transitioning it to active use.
> > +
> > +  Administrative state:
> > +    * *enabled*  =E2=80=94 Allows the guest to use the device (e.g., C=
PU_ON)
> > +    * *disabled* =E2=80=94 Prevents guest use; device is powered off (=
e.g., CPU_OFF)
> > +
> > +  Note: The device must already exist (be declared during machine crea=
tion).
> > +
> > +  Example:
> > +      (qemu) device_set host-arm-cpu,core-id=3D3,admin-state=3Ddisabled
> > +ERST =20
>=20
> How exactly is the device selected?  You provide a clue above: 'can be
> located by "id" or via driver+property match'.
>=20
> I assume by "id" is just like device_del, i.e. by qdev ID or QOM path.
>=20
> By "driver+property match" is not obvious.  Which of the arguments are
> for matching, and which are for setting?
>=20
> If "id" is specified, is there any matching?
>=20
> The matching feature complicates this interface quite a bit.  I doubt
> it's worth the complexity.  If you think it is, please split it off into
> a separate patch.

It's likely /me who to blame for asking to invent generic
device-set QMP command.
I see another application (beside ARM CPU power-on/off) for it,
PCI devices to simulate powering on/off them at runtime without
actually removing device.

wrt command,
I'd use only 'id' with it to identify target device
(i.e. no template matching nor QMP path either).
To enforce rule, what user hasn't named explicitly by providing 'id'
isn't meant to be accessed/manged by user later on.=20

potentially we can invent specialized power_set/get command as
an alternative if it makes design easier.
But then we would be spawning similar commands for other things,
where as device-set would cover it all. But then I might be
over-complicating things by suggesting a generic approach.=20

> Next question.  Is there a way for management applications to detect
> whether a certain device supports device_set for a certain property?

is there some kind of QMP command to check what does a device support,
or at least what properties it supports? Can we piggy-back on that?
=20
>=20
> Without that, what are management application supposed to do?  Hard-code
> what works?  Run the command and see whether it fails?

Adding libvirt list to discussion and possible ideas on what can be done he=
re.

> I understand right now the command supports just "admin-state" for a
> certain set of devices, so hard-coding would be possible.  But every new
> (device, property) pair then requires management application updates,
> and the hard-coded information becomes version specific.  This will
> become unworkable real quick.  Not good enough for a command designed to
> be generic.
>=20
> > +
> >      {
> >          .name       =3D "cpu",
> >          .args_type  =3D "index:i", =20

We still do have a few legacy uses of cpu index (CLI|HMP), but
I'd avoid using cpu index or something similar in new interfaces.

> [...]
>=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 83ccde341b..f517b91042 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -375,7 +375,10 @@ SRST
> >      This is different from CPU hotplug where additional CPUs are not e=
ven
> >      present in the system description. Administratively disabled CPUs =
appear in
> >      ACPI tables i.e. are provisioned, but cannot be used until explici=
tly
> > -    enabled via QMP/HMP or the deviceset API.
> > +    enabled via QMP/HMP or the deviceset API. On ACPI guests, each vCP=
U counted
> > +    by 'disabledcpus=3D' is provisioned with '\ ``_STA``\ ' reporting =
Present=3D1
> > +    and Enabled=3D0 (present-offline) at boot; it becomes Enabled=3D1 =
when brought
> > +    online via 'device_set ... admin-state=3Denable'.
> > =20
> >      On boards supporting CPU hotplug, the optional '\ ``maxcpus``\ ' p=
arameter
> >      can be set to enable further CPUs to be added at runtime. When both
> > @@ -455,6 +458,15 @@ SRST
> > =20
> >          -smp 2
> > =20
> > +    Note: The cluster topology will only be generated in ACPI and expo=
sed
> > +    to guest if it's explicitly specified in -smp.
> > +
> > +    Note: Administratively disabled CPUs (specified via 'disabledcpus=
=3D' and
> > +    '-deviceset' at CLI during boot) are especially useful for platfor=
ms like
> > +    ARM that lack native CPU hotplug support. These CPUs will appear t=
o the
> > +    guest as unavailable, and any attempt to bring them online must go=
 through
> > +    QMP/HMP commands like 'device_set'.
> > +
> >      Examples using 'disabledcpus':
> > =20
> >      For a board without CPU hotplug, enable 4 CPUs at boot and provisi=
on
> > @@ -472,9 +484,6 @@ SRST
> >      ::
> > =20
> >          -smp cpus=3D4,disabledcpus=3D2,maxcpus=3D8
> > -
> > -    Note: The cluster topology will only be generated in ACPI and expo=
sed
> > -    to guest if it's explicitly specified in -smp.
> >  ERST
> > =20
> >  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> > @@ -1281,6 +1290,40 @@ SRST
> > =20
> >  ERST
> > =20
> > +DEF("deviceset", HAS_ARG, QEMU_OPTION_deviceset,
> > +    "-deviceset driver[,prop[=3Dvalue]][,...]\n"
> > +    "                Set administrative power state of an existing dev=
ice.\n"
> > +    "                Does not hotplug a new device. Can disable or ena=
ble\n"
> > +    "                devices (such as CPUs) at boot based on policy.\n"
> > +    "                Example:\n"
> > +    "                    -deviceset host-arm-cpu,core-id=3D2,admin-sta=
te=3Ddisabled\n"
> > +    "                Use '-deviceset help' for supported drivers\n"
> > +    "                Use '-deviceset driver,help' for driver-specific =
properties\n",
> > +    QEMU_ARCH_ALL)
> > +SRST
> > +``-deviceset driver[,prop[=3Dvalue]][,...]``
> > +    Configure an existing device's administrative power state or prope=
rties.
> > +
> > +    Unlike ``-device``, this option does not create a new device. Inst=
ead,
> > +    it sets startup properties (such as administrative power state) for
> > +    a device already declared via -smp or other machine configuration.
> > +
> > +    Example:
> > +        -smp cpus=3D4
> > +        -deviceset host-arm-cpu,core-id=3D2,admin-state=3Ddisabled
> > +
> > +    The above disables CPU core 2 at boot using administrative offlini=
ng.
> > +    The guest may later re-enable the core (if permitted by platform p=
olicy).
> > +
> > +    ``state=3Denabled|disabled``
> > +        Sets the administrative state of the device:
> > +        - ``enabled``: device is made available at boot
> > +        - ``disabled``: device is administratively disabled and powere=
d off
> > +
> > +    Use ``-deviceset help`` to view all supported drivers.
> > +    Use ``-deviceset driver,help`` for property-specific help.
> > +ERST
> > +
> >  DEF("name", HAS_ARG, QEMU_OPTION_name,
> >      "-name string1[,process=3Dstring2][,debug-threads=3Don|off]\n"
> >      "                set the name of the guest\n"
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index 2ac92d0a07..1099b1237d 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -263,12 +263,20 @@ static DeviceClass *qdev_get_device_class(const c=
har **driver, Error **errp)
> >      }
> > =20
> >      dc =3D DEVICE_CLASS(oc);
> > -    if (!dc->user_creatable) {
> > +    if (!dc->user_creatable && !dc->admin_power_state_supported) {
> >          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> >                     "a pluggable device type");
> >          return NULL;
> >      }
> > =20
> > +    if (phase_check(PHASE_MACHINE_READY) &&
> > +        (!dc->hotpluggable || !dc->admin_power_state_supported)) {
> > +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> > +                   "a pluggable device type or which supports changing=
 power-"
> > +                   "state administratively");
> > +        return NULL;
> > +    }
> > +
> >      if (object_class_dynamic_cast(oc, TYPE_SYS_BUS_DEVICE)) {
> >          /* sysbus devices need to be allowed by the machine */
> >          MachineClass *mc =3D MACHINE_CLASS(object_get_class(qdev_get_m=
achine()));
> > @@ -939,6 +947,76 @@ void qmp_device_del(const char *id, Error **errp)
> >      }
> >  }
> > =20
> > +void qmp_device_set(const QDict *qdict, Error **errp)
> > +{
> > +    const char *state;
> > +    const char *driver;
> > +    DeviceState *dev;
> > +    DeviceClass *dc;
> > +    const char *id;
> > +
> > +    driver =3D qdict_get_try_str(qdict, "driver");
> > +    if (!driver) {
> > +        error_setg(errp, "Parameter 'driver' is missing");
> > +        return;
> > +    }
> > +
> > +    /* check driver exists and we are at the right phase of machine in=
it */
> > +    dc =3D qdev_get_device_class(&driver, errp);
> > +    if (!dc) { =20
>=20
> Since qdev_get_device_class() sets an error when it fails, *errp is not
> null here, ...
>=20
> > +        error_setg(errp, "driver '%s' not supported", driver); =20
>=20
> ... which makes this wrong.  Caught by error_setv()'s assertion.
>=20
> Please test your error paths.
>=20
> > +        return;
> > +    }
> > +
> > +    if (migration_is_running()) {
> > +        error_setg(errp, "device_set not allowed while migrating");
> > +        return;
> > +    }
> > +
> > +    id =3D qdict_get_try_str(qdict, "id");
> > +
> > +    if (id) {
> > +        /* Lookup by ID */
> > +        dev =3D find_device_state(id, false, errp);
> > +        if (errp && *errp) {
> > +            error_prepend(errp, "Device lookup failed for ID '%s': ", =
id);
> > +            return;
> > +        }
> > +    } else {
> > +        /* Lookup using driver and properties */
> > +        dev =3D qdev_find_device(qdict, errp);
> > +        if (errp && *errp) {
> > +            error_prepend(errp, "Device lookup for %s failed: ", drive=
r);
> > +            return;
> > +        }
> > +    }
> > +    if (!dev) {
> > +        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > +                  "No device found for driver '%s'", driver);
> > +        return;
> > +    }
> > +
> > +    state =3D qdict_get_try_str(qdict, "admin-state");
> > +    if (!state) {
> > +        error_setg(errp, "no device state change specified for device =
%s ",
> > +                   dev->id);
> > +        return;
> > +    } else if (!strcmp(state, "enable")) {
> > +
> > +        if (!qdev_enable(dev, qdev_get_parent_bus(DEVICE(dev)), errp))=
 {
> > +            return;
> > +        }
> > +    } else if (!strcmp(state, "disable")) {
> > +        if (!qdev_disable(dev, qdev_get_parent_bus(DEVICE(dev)), errp)=
) {
> > +            return;
> > +        }
> > +    } else {
> > +        error_setg(errp, "unrecognized specified state *%s* for device=
 %s",
> > +                   state, dev->id);
> > +        return;
> > +    }
> > +}
> > +
> >  int qdev_sync_config(DeviceState *dev, Error **errp)
> >  {
> >      DeviceClass *dc =3D DEVICE_GET_CLASS(dev); =20
>=20
> [...]
>=20


