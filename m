Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27554CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zMH-0006LY-0R; Tue, 23 Sep 2025 05:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0zMD-0006Km-2l
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0zM5-0003sP-FL
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758619835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDZphouxOZnUK+yuhGBDqAcw5mt2BqtVB7QSXzHqH30=;
 b=WTeI+L2N0/0OZ/YWGsWPq6VaiP0XRtll0e+jwmhqm+bIC6944XguOJAnVAI3zy9xEyybhH
 kOAU+ID0MnhQWKHHDVa/TAuNsxjk0lkOxJnz7E4TywxdGvWvaYFkB8sGNB+4V2/B0l18qD
 1p0xkghPg5K68+Ni9ycIKawFwJxxv3k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-amgpOqX9PISwIlCuZTi1gg-1; Tue, 23 Sep 2025 05:30:33 -0400
X-MC-Unique: amgpOqX9PISwIlCuZTi1gg-1
X-Mimecast-MFC-AGG-ID: amgpOqX9PISwIlCuZTi1gg_1758619832
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so1006461f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758619832; x=1759224632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDZphouxOZnUK+yuhGBDqAcw5mt2BqtVB7QSXzHqH30=;
 b=CmUusGpE8IjpaWGzIksw+dSN+yvPeoW4Ryeb7jNE9UVfRwQ9k5bpHnAlvtUrLLneCt
 yk7o4EGf3w+r6z73ru8+wq7BOXYCdHfB7KV+io9StDdkNbncdg6xDhGa5yWXjAjNg0JF
 JdSILey2gEU121L6TqJ+uHyFax5u4UuUIECU4X0MyQCRO48er/SbkBPkD420/v96wK9B
 8PoZwL42yj5ZbInJ1364U6l+MxuoGPTKwdub/JCLSXfZP+wcVTDsnUjPoF+4tU7DHLRw
 vdWLXRhF/vwkQ23kdOnIfz69YdraHzTsfHH973RW+35gMeXgziU5VJpxtR8fLPUD+m9q
 NYNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaAM9DIcbJg4fFxBMLOwJ4tSXYE4LkdRzse77jvZsRDMZZE/Y4L/8R849aXgYx6AWFLeL1qrMHikD9@nongnu.org
X-Gm-Message-State: AOJu0YwcoKuLbbwKMQ4L1Xd52AfkjVM7ebLFS+PE0QZquRWXGZIw5mSh
 XowGueoc2AvQVKEFrn3doV6Df88sdg2sG4DHAcCm8sCIC2BZgsVwiliRC8Jk4ZtZmsYt6PgWtSf
 aWVkbqG8t9BbAwBWhl2mUTL3CDvyrfS9ifWEyocVE6ydGnH81gSN0WPIF
X-Gm-Gg: ASbGncvenflJFPmCOH7RzaHazg9pEC4k4IH+PC9Yy9RuhTLqyp7nEwKrhhyx2Yf+XA1
 I6JnR8dbyTtIzXaRDRipQIVy+YV6tT/pVBTKwQ6bPhjwMfmi/gxSfFurTn4JKYcg1HZ5uw4vjqL
 mHrL46oTTWOEIHBuxYYHX19dvCPRb0WOQbjmjUyQARsgT9ErDtiOc38OjN36NkHEN8QlMaD88rB
 NP0ztBY0Fqw2UGdWu2obdZVryXD2OZT98U3uY/Z8oFHjz4eLzPNINljpTZQBhGuhVN2ITLVu25r
 KtgO3vap4LU/APYoAvCDht9K2mIDSLA=
X-Received: by 2002:a05:6000:1a8f:b0:3ee:1521:95fc with SMTP id
 ffacd0b85a97d-405c6751d5fmr1531594f8f.14.1758619832197; 
 Tue, 23 Sep 2025 02:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLxZHBwQ4V5dfBA91z6hp+s2xxMF4YWZ0Zo/WKZB3v5fT9NV1/BYZs4v30CmBOKjQWChiZtQ==
X-Received: by 2002:a05:6000:1a8f:b0:3ee:1521:95fc with SMTP id
 ffacd0b85a97d-405c6751d5fmr1531558f8f.14.1758619831691; 
 Tue, 23 Sep 2025 02:30:31 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-407a3bbeaf2sm502271f8f.49.2025.09.23.02.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 02:30:31 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:30:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Daniel
 P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
Message-ID: <20250923113029.78c03a5c@fedora>
In-Reply-To: <bb967b28-4ec5-40b5-88cc-cebd7493d381@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <aK7wDn03e8RtKmk3@redhat.com>
 <1178e514-a054-4ace-a5b7-06ca899badec@linaro.org>
 <20250922143537.39896851@fedora>
 <bb967b28-4ec5-40b5-88cc-cebd7493d381@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 22 Sep 2025 14:56:57 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> On 22/09/2025 13:35, Igor Mammedov wrote:
>=20
> > On Mon, 22 Sep 2025 14:05:13 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >  =20
> >> On 27/8/25 13:46, Daniel P. Berrang=C3=A9 wrote: =20
> >>> On Wed, Aug 27, 2025 at 12:10:00PM +0100, Mark Cave-Ayland wrote: =20
> >>>> On 26/08/2025 08:25, Xiaoyao Li wrote:
> >>>>    =20
> >>>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote: =20
> >>>>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whils=
t it is
> >>>>>> possible to specify any CPU via -cpu on the command line, it makes=
 no
> >>>>>> sense to allow modern 64-bit CPUs to be used.
> >>>>>>
> >>>>>> Restrict the isapc machine to the available 32-bit CPUs, taking ca=
re to
> >>>>>> handle the case where if a user inadvertently uses -cpu max then t=
he
> >>>>>> "best"
> >>>>>> 32-bit CPU is used (in this case the pentium3).
> >>>>>>
> >>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>>>> ---
> >>>>>>   =C2=A0 hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
> >>>>>>   =C2=A0 1 file changed, 26 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >>>>>> index c03324281b..5720b6b556 100644
> >>>>>> --- a/hw/i386/pc_piix.c
> >>>>>> +++ b/hw/i386/pc_piix.c
> >>>>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj,
> >>>>>> int value, Error **errp)
> >>>>>>   =C2=A0 #ifdef CONFIG_ISAPC
> >>>>>>   =C2=A0 static void pc_init_isa(MachineState *machine)
> >>>>>>   =C2=A0 {
> >>>>>> +=C2=A0=C2=A0=C2=A0 /*
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * There is a small chance that someone u=
nintentionally passes
> >>>>>> "- cpu max"
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * for the isapc machine, which will prov=
ide a much more modern
> >>>>>> 32-bit
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * CPU than would be expected for an ISA-=
era PC. If the "max"
> >>>>>> cpu type has
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * been specified, choose the "best" 32-b=
it cpu possible which
> >>>>>> we consider
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * be the pentium3 (deliberately choosing=
 an Intel CPU given
> >>>>>> that the
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * default 486 CPU for the isapc machine =
is also an Intel CPU).
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NA=
ME("max"))) {
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->cpu_type =3D =
X86_CPU_TYPE_NAME("pentium3");
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("-cpu max =
is invalid for isapc machine, using
> >>>>>> pentium3");
> >>>>>> +=C2=A0=C2=A0=C2=A0 } =20
> >>>>>
> >>>>> Do we need to handle the case of "-cpu host"? =20
> >>>>
> >>>> I don't believe so. I wasn't originally planning to support "-cpu ma=
x" for
> >>>> isapc, however Daniel mentioned that it could possibly be generated =
from
> >>>> libvirt so it makes sense to add the above check to warn in this cas=
e and
> >>>> then continue. =20
> >>>
> >>> Libvirt will support sending any valid -cpu flag, including both
> >>> 'max' (any config) and 'host' (if KVM).
> >>>
> >>> If 'isapc' still expects to support KVM, then it would be odd to
> >>> reject 'host', but KVM presumably has no built-in way to limit to
> >>> 32-bit without QEMU manually masking many features ?
> >>>
> >>> I'm a little worried about implications of libvirt sending '-cpu max'
> >>> and QEMU secretly turning that into '-cpu pentium3', as opposed to
> >>> having '-cpu max' expand to equiv to 'pentium3', which might cauase
> >>> confusion when libvirt queries the expanded CPU ? Copying Jiri for
> >>> an opinion from libvirt side, as I might be worrying about nothing. =
=20
> >>
> >> OK, on 2nd thought, even while warning the user, changing the type
> >> under the hood isn't great. =20
> >=20
> > I second that,
> > Please don't do magical mutations of CPUs, just error out.
> >=20
> > we used to 'fix|tweak' CPUs using machine compat hack,
> > however with introduction of versioned cpu models we shouldn't do that =
anymore.
> > (aka: existing CPU devices should stay immutable if possible, and any v=
isible
> > changes should go into new version) =20
>=20
> The original suggestion for allowing "max"/"host" was so that it=20
> wouldn't cause any regressions with command lines erroneously including=20
> -cpu max or -cpu host (which I believe may be possible with libvirt).

looking back and at Daniels reply,
max/host are indeed are 'special' aka mutable as opposed to named cpu model=
s.

if we go by the books, 'host' and by extension 'max' should work with KVM a=
ccelerator.
But that (aka reducing it to isapc levels) should be done at 'host' cpu mod=
el code
and that part of code is not really aware (nor should be) of machine types.
I'm not sure, whether it's worth the effort and complexity.

I'd be fine with valid_cpu_types[] approach here, i.e. user will get
clear error that her is doing wrong thing trying 'host/max',
and printing suggestion how to remedy error should guide user
to the right config.
=20
>=20
> >> What about simply removing "max" of valid_cpu_types[], since it is
> >> clearly confusing "max" =3D=3D "pentium3"... =20
> >=20
> > it seems that specifying supported cpu models in valid_cpu_types[] is t=
he way to go. =20
>=20
> That was what I did in v1 and v2 version of the series, but I can submit=
=20
> a patch to change this once there is agreement on the desired behaviour.
>=20
>=20
> ATB,
>=20
> Mark.
>=20


