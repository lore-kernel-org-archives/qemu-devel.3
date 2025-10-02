Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDBCCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4J45-0002F1-In; Thu, 02 Oct 2025 09:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4J3p-00022K-Mq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4J3i-0007Hx-CV
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759410557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SimURmzwq8HtzNr4CVKu8DW7ZIM6lOM9IzSx3elnmxA=;
 b=HRx0y8sv/mG1QVnUoILcVH3REc4lmrxzIh2Aiyy3VzoeTRy45hSzMqET1PTh2rSMn23sTQ
 Tx/UaVh/3xk4VmdPy6Fimz+Wcm1xmQygRsQ99Lf+vGGzNIeLMdUlmc5V1MB0aRv8ZKol4K
 boXWRgSXzMl1kDy8+Igdmy+Ni2UOk90=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-UZdVAiV9NNCHsGK5wlRJiQ-1; Thu, 02 Oct 2025 09:09:16 -0400
X-MC-Unique: UZdVAiV9NNCHsGK5wlRJiQ-1
X-Mimecast-MFC-AGG-ID: UZdVAiV9NNCHsGK5wlRJiQ_1759410555
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso3746825e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 06:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759410555; x=1760015355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SimURmzwq8HtzNr4CVKu8DW7ZIM6lOM9IzSx3elnmxA=;
 b=P1L5W53MdYf0MSZuySQZpaKWWuOWoj6cCf0tOxNgV6bV5OxrYWsBZHQuxs7qTiBAsa
 5LeAjKb4olOFhfGn8YHksY46+bYI0D/rMWViMERsrEXVvHepJ35veSYjjevAfGmIuMSt
 eJXowy1ZL+aL6F5lhEOKekwie2A7FUfEyw921Gq0e+9pSNiaJG3lBfxS8KtHsbX0DBGx
 DaIumvdfP3fK7j4hd3enzaTllU6yRPD4SqCoKnebHYOUhFar3dlj5abOQMO8md7QCpkN
 /YirrQCgd/O8SvZr3ejNeKRUbzCDFqRxq6VFbEc1f63pfeG6TNsb8+0XcNHZ9VW0ubbF
 QFlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcaUb5fPZ87j7AZFQuQVwpa+EnVB4joZXFE7Oz2yN6ygZhxB/4SmgYvFMejfei5aReXNfwq4Guwj4U@nongnu.org
X-Gm-Message-State: AOJu0YwE+suwY2DecffS8gQ8rPSR6Dj8em/+vcvX9mhTULRsU1f01Q1o
 8j5y7k7UOyVc56MDWPxSulqRK1HWbX5QCrFLnMamOoDiYya6/ZKIWDqyt65qr6ak4QQTg74vMja
 9xdkxl3CSji25ibn3tj5jsgH6rINaK4BiHDgzPgM+sSH4hq7Hdv0sbJTK
X-Gm-Gg: ASbGnctJExuDLH4ASidJ6oVnr0xrI6e0At4QM7yxiw8n6nZCEF8f/Kt9XKw5ydg4MTC
 tLWMMRTgTT/06Oeu7ghDv+OzpezxG8RY/VSpj3+gRTo7Hxedt7JMw4zRoTbBy2T7QANokNg0xDW
 ybvLcbULHDd4v98y77a8AacvsWhZA7ryzvtKjDknBVHFSp2hcAA75M1UUpkwlwwdYJPjAakm4qZ
 qSzqZKqll0VPQzQLMCRjH/pNnuVi9NIS24J7Iq6P+e2kZ+s8JDA0fbOoFV2MDUWpS+E219btOno
 0mPy0w4y5MHpB2vEIYUtbWVvHQ+2gpkGvfx4
X-Received: by 2002:a05:6000:610:b0:408:9c48:e27b with SMTP id
 ffacd0b85a97d-42557820c81mr5280534f8f.62.1759410554628; 
 Thu, 02 Oct 2025 06:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKLK9Wdm1jOf8fVvPsR67jO6ceIcModfF2qZ2ILE9lN4fFS6q2dcIZfOa2dou9wDC/5RvQqw==
X-Received: by 2002:a05:6000:610:b0:408:9c48:e27b with SMTP id
 ffacd0b85a97d-42557820c81mr5280503f8f.62.1759410554171; 
 Thu, 02 Oct 2025 06:09:14 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9719sm3748175f8f.31.2025.10.02.06.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 06:09:13 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:09:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, philmd@linaro.org, jdenemar@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] hw/i386/isapc.c: remove support for -cpu host
 and -cpu max
Message-ID: <20251002150910.70dcf950@fedora>
In-Reply-To: <063bdc3f-7767-40b6-b5d4-bb806f692d10@nutanix.com>
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-2-mark.caveayland@nutanix.com>
 <87wm5lo37q.fsf@pond.sub.org> <aNaJl3J5dZEt6n4_@redhat.com>
 <70ff12c0-9ed7-4c19-a7cb-d14a5176d3f7@nutanix.com>
 <aNabaxWyioLXgfFH@redhat.com>
 <0c125c3e-001c-40fc-b2d9-7ef3c1d0451d@nutanix.com>
 <aNatTdDfJw4FL4Is@redhat.com>
 <063bdc3f-7767-40b6-b5d4-bb806f692d10@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 26 Sep 2025 16:22:31 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> On 26/09/2025 16:12, Daniel P. Berrang=C3=A9 wrote:
>=20
> > On Fri, Sep 26, 2025 at 04:01:23PM +0100, Mark Cave-Ayland wrote: =20
> >> On 26/09/2025 14:55, Daniel P. Berrang=C3=A9 wrote:
> >> =20
> >>> On Fri, Sep 26, 2025 at 02:49:00PM +0100, Mark Cave-Ayland wrote: =20
> >>>> On 26/09/2025 13:39, Daniel P. Berrang=C3=A9 wrote:
> >>>> =20
> >>>>> On Fri, Sep 26, 2025 at 01:36:25PM +0200, Markus Armbruster wrote: =
=20
> >>>>>> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
> >>>>>> =20
> >>>>>>> Following recent discussions on the mailing list, it has been dec=
ided
> >>>>>>> that instead of mapping -cpu host and -cpu max to a suitable 32-b=
it x86 CPU,
> >>>>>>> it is preferable to disallow them and use the existing valid_cpu_=
types
> >>>>>>> validation logic so that an error is returned to the user instead.
> >>>>>>>
> >>>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >>>>>>> ---
> >>>>>>>     hw/i386/isapc.c | 27 ---------------------------
> >>>>>>>     1 file changed, 27 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> >>>>>>> index 44f4a44672..6c35a397df 100644
> >>>>>>> --- a/hw/i386/isapc.c
> >>>>>>> +++ b/hw/i386/isapc.c
> >>>>>>> @@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
> >>>>>>>         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> >>>>>>>         int i;
> >>>>>>> -    /*
> >>>>>>> -     * There is a small chance that someone unintentionally pass=
es "-cpu max"
> >>>>>>> -     * for the isapc machine, which will provide a much more mod=
ern 32-bit
> >>>>>>> -     * CPU than would be expected for an ISA-era PC. If the "max=
" cpu type has
> >>>>>>> -     * been specified, choose the "best" 32-bit cpu possible whi=
ch we consider
> >>>>>>> -     * be the pentium3 (deliberately choosing an Intel CPU given=
 that the
> >>>>>>> -     * default 486 CPU for the isapc machine is also an Intel CP=
U).
> >>>>>>> -     */
> >>>>>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> >>>>>>> -        machine->cpu_type =3D X86_CPU_TYPE_NAME("pentium3");
> >>>>>>> -        warn_report("-cpu max is invalid for isapc machine, usin=
g pentium3");
> >>>>>>> -    }
> >>>>>>> -
> >>>>>>> -    /*
> >>>>>>> -     * Similarly if someone unintentionally passes "-cpu host" f=
or the isapc
> >>>>>>> -     * machine then display a warning and also switch to the "be=
st" 32-bit
> >>>>>>> -     * cpu possible which we consider to be the pentium3. This i=
s because any
> >>>>>>> -     * host CPU will already be modern than this, but it also en=
sures any
> >>>>>>> -     * newer CPU flags/features are filtered out for older guest=
s.
> >>>>>>> -     */
> >>>>>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
> >>>>>>> -        machine->cpu_type =3D X86_CPU_TYPE_NAME("pentium3");
> >>>>>>> -        warn_report("-cpu host is invalid for isapc machine, usi=
ng pentium3");
> >>>>>>> -    }
> >>>>>>> -
> >>>>>>>         if (machine->ram_size > 3.5 * GiB) {
> >>>>>>>             error_report("Too much memory for this machine: %" PR=
Id64 " MiB, "
> >>>>>>>                          "maximum 3584 MiB", machine->ram_size / =
MiB);
> >>>>>>> @@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClas=
s *m)
> >>>>>>>             X86_CPU_TYPE_NAME("pentium2"),
> >>>>>>>             X86_CPU_TYPE_NAME("pentium3"),
> >>>>>>>             X86_CPU_TYPE_NAME("qemu32"),
> >>>>>>> -        X86_CPU_TYPE_NAME("max"),
> >>>>>>> -        X86_CPU_TYPE_NAME("host"),
> >>>>>>>             NULL
> >>>>>>>         };
> >>>>>>>         PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m); =20
> >>>>>>
> >>>>>> This reverts the "smart" part of recent
> >>>>>>
> >>>>>> commit e1e2909f8e74051a34a044940f90d4650b6e784a
> >>>>>> Author: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >>>>>> Date:   Thu Aug 28 12:09:44 2025 +0100
> >>>>>>
> >>>>>>        hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
> >>>>>>        The isapc machine represents a legacy ISA PC with a 486 CPU=
. Whilst it is
> >>>>>>        possible to specify any CPU via -cpu on the command line, i=
t makes no
> >>>>>>        sense to allow modern 64-bit CPUs to be used.
> >>>>>>        Restrict the isapc machine to the available 32-bit CPUs, ta=
king care to
> >>>>>>        handle the case where if a user inadvertently uses either -=
cpu max or
> >>>>>>        -cpu host then the "best" 32-bit CPU is used (in this case =
the pentium3). =20
> >>>>>
> >>>>> What is written here made sense from the POV of use of isapc with
> >>>>> qemu-system-x86_64, but in qemu-system-i686, both 'max' and 'host'
> >>>>> where already 32-bit CPUs IIUC. Both this original patch and
> >>>>> the new patch block them from being used in qemu-system-i686
> >>>>> which feels wrong given the justification above. =20
> >>>>
> >>>> I tried stepping through with -cpu host/-cpu max on qemu-system-i386=
 and
> >>>> it's a bit confusing: I think we end up with some kind of custom AMD=
 vendor
> >>>> CPU but with LM disabled. I can't easily see a way to understand what
> >>>> features are currently enabled?
> >>>>
> >>>> I must admit I'm struggling to see the usefulness of -cpu host/-cpu =
max for
> >>>> isapc given that older OSs can be quite picky when it comes to hardw=
are. =20
> >>>
> >>> But x86 CPU vendors go to ridiculous levels of complexity to retain
> >>> historical back compat over many decades. If anything, I'd be surpris=
ed
> >>> about the opposite - an OS that didn't work with -cpu max. =20
> >>
> >> It's not the CPU vendor I'd be worried about, but the OS vendor who ma=
y for
> >> example execute CPUID and become confused if it returns an AMD vendor =
ID
> >> instead of an Intel vendor ID. =20

ha, that's how KVM works if I recall it right, one doesn't need host/max fo=
r it,
flip to host's vendor would happen with _any_ cpumodel.
That's leads to some degree of fun on guest OS side to deal with.

> >=20
> > IIRC/IIUC, AMD sold i486 CPUs with CPUID present in the ISA era, so I
> > would have thought anything checking vendor ID should expect to see
> > more than just Intel ? =20
>=20
> Unfortunately I don't remember the specifics, but I have a vague memory=20
> that someone has mentioned this to me in the past.
> >> What do you think is the best way forward? I'm still not convinced of =
the
> >> utility of -cpu host/-cpu max for isapc, so what if instead of mapping=
 them
> >> to the pentium3 CPU we follow the standard deprecation path and emit a
> >> warning on startup, and then remove them from valid_cpu_types in 2 rel=
eases
> >> time? The advantage to this approach is that if people are actually us=
ing
> >> -cpu host/-cpu max with the isapc machine then they would at least fil=
e an
> >> issue in Gitlab and make us aware of it. =20
> >=20
> > If we want to deprecate it the formal route, that's fine. =20
>=20
> Works for me. Igor, any objections?

given host/max are accelerator specific models with all possible features f=
or it,
it' would be fair to make sure that those models in qemu-system-i686 case e=
xpose
only 32-bit CPU's features
(do we wanna go to that extent for i386? I'm not sure)

However let's not confuse it with capabilities of specific machine type,
it shouldn't have any influence on cpu models. It looks like this patch does
the right thing /limiting permitted cpus to back then reality/.

If we strictly follow rules,
then deprecation is the way to go, so it wouldn't look as regression.

(aka QEMU used to start fine with host/max, and we warn in advance that it's
going out in favor of .../because of ...
shout out if you have a use case.)
=20
>=20
>=20
> ATB,
>=20
> Mark.
>=20


