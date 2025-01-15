Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D3C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 10:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0Uu-0004l0-2Y; Wed, 15 Jan 2025 05:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY0Us-0004kl-Bl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY0Uq-0002Ti-C7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736936374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOuXHiINgTRXJuIWOe4F3DQorQiY488CjwgD1dVo+ew=;
 b=M0Q7ZI8o/JNBlJ6lChEFwY39sXFepXXlubKMMkI7Tqd0acfR2R8uBuY4M0KzW2s0tF0Mj8
 iuyXjSxZZlkqrnVsuzBH3J746hxYeJn3MQjmgUsOspAVgmTl8aD48WmW3Dxr8j9r3XML4p
 WeFIW+krFf/vOFsntpcaWxUs2I7K6bU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-0EXnUxx5N0qJX8o8T_f1rw-1; Wed, 15 Jan 2025 05:19:32 -0500
X-MC-Unique: 0EXnUxx5N0qJX8o8T_f1rw-1
X-Mimecast-MFC-AGG-ID: 0EXnUxx5N0qJX8o8T_f1rw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so36385375e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 02:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736936371; x=1737541171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOuXHiINgTRXJuIWOe4F3DQorQiY488CjwgD1dVo+ew=;
 b=bo6pgvJWaIIoBZH9ZPfFx1VH5lITsOSMs/r+NlJBbGM+tOkIwXdtwLS0AWiHypCGkm
 +tviEFOe4gTpZ4iqQM39BUZG63+t93gIa9fgYLerolDsOqCXSF435lqW4gPODIN8gtJ/
 0ShnB6NKJQat65ICXBqWxhQxdlhgPnN93WjZp8H01L+3M4rZTigU3raB7J4f/qi8OXeH
 IE+uECxXEFItTht/bQV0LcTrMbMj1xUSubE89bkdLww3FyHhuighzwTBXO3fuTYMCt+7
 fcS+dNckkVhII3G836LUAfmR58TQk4h9UY1wbA1FU5NAusqO58ickej6Ns/0njucuqo3
 brbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFKQWRPsW+SzTEJOtjHPE8Ycb3+QC/FtailTz9nYzQoK5yO11qUtcCrvZdbLHidrxHESqszEXOQqLH@nongnu.org
X-Gm-Message-State: AOJu0Yz8wx4qBO6fQyJRy6ALjafaAoan19HxQKb/ERxDzMrQSJ5IfCsF
 86udaJItT7srjKxizgmesGbqkgoXPqx9msgwbvY99T7M88ufnCRbNzTq3JPzN4ckFNLVnfiZutq
 wPlgp7Jc3OJNKJSNapGX5VHEEUQqQdI9kdtEAtmMArpoHYYIj+L4p
X-Gm-Gg: ASbGncuzlJPHtXlBlYZgix7xyJGVIl9Jq3TaAKga8LS7evJ6+9KAjg//tky5wLldcbf
 cPYKZz1QZOrj7IPwrIusGxfseECJqPWRkTX2eh6XV77aMEcTbDGn+DuGMpjFYcqZ54WVeyrrloX
 Vdq4RVl95mfW/+YWznq5Hu004hEBum3XuWZDeM5s+zsiNW2t+Y19/W0wFvtoIFn3O33VysM5/0B
 uyvWEn22Y7irxxsAzcaU18sqvmxFKc152Q9czSUI6WueWHXKz2fv6Y6foBi88nJgBNsz2ow/Sk8
 GaW+KCWRdspcOHywsyvNGnrb+GqR
X-Received: by 2002:a05:600c:3aca:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-436e26eb428mr215241605e9.28.1736936371364; 
 Wed, 15 Jan 2025 02:19:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN+BIi1iavWZvJRjxMk1o5mA1RjGSkLZK0ncFGSWg3HRFl4YitZacwdaOr0r3tP6F/AZqNxw==
X-Received: by 2002:a05:600c:3aca:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-436e26eb428mr215241415e9.28.1736936370956; 
 Wed, 15 Jan 2025 02:19:30 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac5f9sm17698355e9.11.2025.01.15.02.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:19:30 -0800 (PST)
Date: Wed, 15 Jan 2025 11:19:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <20250115111928.17950323@imammedo.users.ipa.redhat.com>
In-Reply-To: <87zfjtfu3g.fsf@pond.sub.org>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
 <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
 <87zfjtfu3g.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 14 Jan 2025 13:38:59 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > On Mon, 13 Jan 2025 17:00:55 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> > =20
> >> On 13/1/25 13:28, Igor Mammedov wrote: =20
> >> > On Sun, 12 Jan 2025 23:16:40 +0100
> >> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >> >    =20
> >> >> QDev objects created with object_new() need to manually add
> >> >> their parent relationship with object_property_add_child().
> >> >>
> >> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> >> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >> >> Message-Id: <20240216110313.17039-22-philmd@linaro.org>
> >> >> ---
> >> >>   hw/i386/x86-common.c                     | 1 +
> >> >>   hw/microblaze/petalogix_ml605_mmu.c      | 1 +
> >> >>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
> >> >>   hw/mips/cps.c                            | 1 +
> >> >>   hw/ppc/e500.c                            | 1 +
> >> >>   hw/ppc/spapr.c                           | 1 +
> >> >>   6 files changed, 6 insertions(+)
> >> >>
> >> >> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> >> >> index 97b4f7d4a0d..9c9ffb3484a 100644
> >> >> --- a/hw/i386/x86-common.c
> >> >> +++ b/hw/i386/x86-common.c
> >> >> @@ -60,6 +60,7 @@ static void x86_cpu_new(X86MachineState *x86ms, i=
nt64_t apic_id, Error **errp)
> >> >>       if (!object_property_set_uint(cpu, "apic-id", apic_id, errp))=
 {
> >> >>           goto out;
> >> >>       }
> >> >> +    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu)=
);   =20
> >> >=20
> >> > I might  be missing something but why it needs to be done manually?
> >> >=20
> >> > device_set_realized() will place any parent-less device under (1) /m=
achine/unattached   =20
> >>=20
> >> This is exactly what we want to avoid, to eventually remove
> >> the "/machine/unattached" container for good.
> >>=20
> >> See "=3D Problem 4: The /machine/unattached/ orphanage =3D" in:
> >> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/ =20
> >
> >
> > QOM paths as far as I'm aware were never part ABI nor I'm aware of
> > of any proposal to make it or some parts of it a public interface. =20
>=20
> We've been waffling on this since forever.  QOM is not a public
> interface except when it is, and it is when somebody says so, and it
> isn't when somebody says so, resulting in a wave function that wobbles
> like an underdone souffle, but never quite collapses.
>=20
> > IMHO for public ABI, QEMU provides explicit QMP commands while
> > QOM should stay a playground for developers. =20
>=20
> Plenty of commands take QOM paths as arguments: eject,
> blockdev-open-tray, blockdev-close-tray, blockdev-remove-medium,
> blockdev-insert-medium, blockdev-change-medium,
> block-latency-histogram-set, cxl-inject-general-media-event,
> cxl-inject-dram-event, cxl-inject-memory-module-event,
> cxl-inject-poison, cxl-inject-uncorrectable-errors,
> cxl-inject-correctable-error, device_del, device-sync-config,
> query-stats, x-query-virtio-status, x-query-virtio-queue-status,
> x-query-virtio-vhost-queue-status, x-query-virtio-queue-element, and
> possibly more.

well, unless draw a line somewhere it will never stop.
Perhaps we should find on some border where QOM exposure stops
and document it. So whenever question pops up again, one could be
sent there.

all x- commands could be ignored, prefix tells no promises whatsoever,
cxl- group all new and doesn't have excuse to expose QOM, but not
many pay attention it subsystem considering it as platform bring up effort

> The only way their QOM path arguments can be used without relying on QOM
> paths being ABI would be obtaining the argument value with a command or
> from an event.  I doubt that would be possible even if we tried it,
> which we haven't.

hotpluggable-cpu command might be an example (it returns vcpu path,
which is valid within vcpu lifetime). But then again it's for
devs convenience.=20

What I don't like about exposing QOM is=20

> > I this specific case, one basically replaces /machine/unattached
> > orphanage with explicit /machine one and many 'cpuN' children,
> > which ain't any better than device[N].
> >
> > and in future I can imagine that at least in x86 case vcpus
> > might have another parent depending on configuration.
> > (i.e. being parented to cores instead)
> >
> > If goal is to get rid of /machine/unattached, that's fine. =20
>=20
> /machine/unattached was a lazy mistake.

no argument here

>=20
> > But please not make brittle naming under /machine/unattached
> > as a reason as 'cpu[N]' is the same just in different place
> > and scattered all over code (hence doubts if it's any better than curre=
nt way). =20
>=20
> Can you suggest a better, workable naming scheme?

nope, that's why I'm not arguing against it (modulo voicing my doubts)

PS:
Another question is if it's safe to move/rename device withing QOM tree
wrt migration (i.e. when 1st instance has old QOM tree and 2nd a modified o=
ne)

quick smoke test works (migrating from old qemu to a new one with this patc=
h)
But it's better to ask to be safe.

> > (ps: don't we have exactly the same for peripheral-anon container) =20
>=20
> Yes, but users can avoid that by passing an @id argument.
>=20
> [...]
>=20


