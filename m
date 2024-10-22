Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A912D2C56D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GvL-0006Mo-VG; Tue, 22 Oct 2024 11:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t3Gv7-0006Ft-DI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t3Gv4-0006ej-Ep
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729611336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCMd/VJdNW9wmA48jvZ4VG+AYDAWNSVYrrbeOs4EqSc=;
 b=bFUHS4d47beETCiXDLbYwxh8r5EZi4+Ea4CvDTQTBv2pjqAwp5MtfuNnB8m51RTkmd2LlL
 AebqntRlKcnzLV9ZWak811Mwab3Ez28zYaOypGX9XVQowhApowzCyxlGhPjimM/YFHrZJU
 zgGf5UUXgdUjmPAgqjwvJz5PbY2gFzU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6C4AiALmM6K_-6NSy61ENw-1; Tue, 22 Oct 2024 11:35:32 -0400
X-MC-Unique: 6C4AiALmM6K_-6NSy61ENw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso40534725e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 08:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729611331; x=1730216131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCMd/VJdNW9wmA48jvZ4VG+AYDAWNSVYrrbeOs4EqSc=;
 b=c6o3rOhbwzCEXUf07ZgcZuSr4h6+1YJizuMmWuj2lisVutmYAGxWqC/c8rHJelolwO
 Nv+Tz2rLKw7/VR6yNzXAMrM4RYPXL2AVuCfrIzkYXoK/ND+jb1kTFJkb8urpP22z2JY2
 iP1h1ld1vta5E1v8ECAZZhXkAy9fn6nKKR5+kBxvfCRw5u3j4qkYzaTk0wfKet9v4LLB
 PByENl/WaqLQac0zFTexP8OZU7sQYQyx1yFqoItvc977DZJ+t29s+IM+W8lZPKeOrlQ/
 QS52qFw2rM7Bq2IyrzuDa/oZE2bcwCjgqKJgPlF7xarnHe30IwLDjdoHWR1IJ5ofKdlk
 ne9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/TjTFsEl4FC5QP83xFea3htLU2b++aRpYy6LiK5x9kgwm3xK1o5HUBmyWMYX4u+xRW6stnIROthN@nongnu.org
X-Gm-Message-State: AOJu0Yz7Ak8B42qGAZXaKZZIVsyLFMh1JC9qArpUXXrl22lNcnBAGOny
 gFhYCEU4qgD2oCyL9O/Dq5FccZWEfG9lef4i2uPFIBEg7m5LCD4jXon4JtjZJIemVN81NqsaqLK
 jWLlV+2bctZqxARSA1/DOEySUoLlvENFffPAXiXrd1qm00+AMy8w9
X-Received: by 2002:a05:600c:5124:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-4316169a57amr110118255e9.27.1729611331435; 
 Tue, 22 Oct 2024 08:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWFPyaqMcklA3vjnYqRKyWYmtekMsl6T/umXnGrr6I1mcm1qU71XKjV+nxysinP5K7av/Yzw==
X-Received: by 2002:a05:600c:5124:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-4316169a57amr110118055e9.27.1729611330994; 
 Tue, 22 Oct 2024 08:35:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f570ffcsm92904405e9.2.2024.10.22.08.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 08:35:30 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:35:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <20241022173529.54dfcee4@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZxelgDeuZaia-Vqf@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
 <ZxelgDeuZaia-Vqf@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Tue, 22 Oct 2024 14:15:44 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Oct 22, 2024 at 02:46:15PM +0200, Igor Mammedov wrote:
> > On Fri, 18 Oct 2024 13:59:34 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote: =20
> > > > On Wed, 16 Oct 2024 14:56:39 +0200
> > > > "Anthony Harivel" <aharivel@redhat.com> wrote: =20
> > [...]
> >  =20
> > > >=20
> > > > This also leads to a question, if we should account for
> > > > not VCPU threads at all. Looking at real hardware, those
> > > > MSRs return power usage of CPUs only, and they do not
> > > > return consumption from auxiliary system components
> > > > (io/memory/...). One can consider non VCPU threads in QEMU
> > > > as auxiliary components, so we probably should not to
> > > > account for them at all when modeling the same hw feature.
> > > > (aka be consistent with what real hw does).   =20
> > >=20
> > > I understand your POV, but I think that would be a mistake,
> > > and would undermine the usefulness of the feature.
> > >=20
> > > The deployment model has a cluster of hosts and guests, all
> > > belonging to the same user. The user goal is to measure host
> > > power consumption imposed by the guest, and dynamically adjust
> > > guest workloads in order to minimize power consumption of the
> > > host. =20
> >=20
> > For cloud use-case, host side is likely in a better position
> > to accomplish the task of saving power by migrating VM to
> > another socket/host to compact idle load. (I've found at least 1
> > kubernetis tool[1], which does energy monitoring). Perhaps there
> > are schedulers out there that do that using its data. =20
>=20
> The host admin can merely shuffle workloads around, hoping that
> a different packing of workloads onto machines, will reduce power
> in some aount. You might win a few %, or low 10s of % with this
> if you're good at it.

package level savings probably won't make a much of dent (older hw, less im=
pact),
but if one would think about vacating/powering down host it's a bit
different story (it was in my home lab case - trying to
minimize idle consumption of 24/7 systems). But even with
that when switching to newer hardware it might come to the point
of diminishing returns eventually.

> The guest admin can change the way their workload operates to
> reduce its inherant power consumption baseline. You could easily
> come across ways to win high 10s of % with this. That's why it
> is interesting to expose power consumption info to the guest
> admin.

Looking at discussions around Intel's hybrid CPUs, I got
an impression that not userspace nor kernel have enough energy
consumption info to make decent scheduling decision and no _one
really wishes do scheduling manually_ to begin with. That's where
Intel's CPUs with IDT come into the picture to help kernel
somehow bin tasks based on efficiency figures (since CPU knows
exactly how much resources it is using).
But that's relatively new and whether such cpus will stick or
not is still an open question (it makes sense for mobile market,
but for other applications I'd guess time will show).


> IOW, neither makes the other obsolete, both approaches are
> desirable.

no argument here.

> > > The guest workloads can impose non-negligble power consumption
> > > loads on non-vCPU threads in QEMU. Without that accounted for,
> > > any adjustments will be working from (sometimes very) inaccurate
> > > data. =20
> >=20
> > Perhaps adding one or several energy sensors (ex: some i2c ones),
> > would let us provide auxiliary threads consumption to guest, and
> > even make it more granular if necessary (incl. vhost user/out of
> > process device models or pass-through devices if they have PMU).
> > It would be better than further muddling vCPUs consumption
> > estimates with something that doesn't belong there. =20
>=20
> There's a tradeoff here in that info directly associated with
> backends threads, is effectively exposing private QEMU impl
> details as public ABI. IOW, we don't want too fine granularity
> here, we need it abstracted sufficiently, that different
> backend choices for a given don't change what sensors are
> exposed.
>=20
> I also wonder how existing power monitoring applications
> would consume such custom sensors - is there sufficient
> standardization in this are that we're not inventing
> something totally QEMU specific ?

we can expose them as ACPI power meter devices, to make it
abstract for guest OS (i.e. guest would need only a standard
driver for it) or alternatively model some of real i2c
sensors. But yes, it something that should be explored so
it would work/supported by common tools or the tool of the choice.

>=20
> > > IOW, I think it is right to include non-vCPU threads usage in
> > > the reported info, as it is still fundamentally part of the
> > > load that the guest imposes on host pCPUs it is permitted to
> > > run on. =20
> >=20
> >=20
> > From what I've read, process energy usage done via RAPL is not
> > exactly accurate. But there are monitoring tools out there that
> > use RAPL and other sources to make energy consumption monitoring
> > more reliable.
> >=20
> > Reinventing that wheel and pulling all of the nuances of process
> > power monitoring inside of QEMU process, needlessly complicates it.
> > Maybe we should reuse one of existing tools and channel its data
> > through appropriate QEMU channels (RAPL/emulated PMU counters/...). =20
>=20
> Note, this feature is already released in QEMU 9.1.0.

that doesn't preclude us from improving impl. details=20
/i.e. what tasks qemu does and what is upto backend (external daemon)/
though. Incl. changing backend if it that would do a better job
for in the end (with a benefit that it's mostly maintained by another proje=
ct).

> > Implementing RAPL in pure form though looks fine to me,
> > so the same tools could use it the same way as on the host
> > if needed without VM specific quirks. =20
>=20
> IMHO the so called "pure" form is misleading to applications, unless
> we first provided  some other pratical way to expose the data that
> we would be throwing away from RAPL.
I don't argue that data should be thrown away. But just that we should
provide them some other way instead of vCPU RAPL interface. And not
confuse host's pCPU with vCPUs.

PS:
Taking example above that aux threads are inherent pCPU load and
stretch it in to host side. Then one can say pCPU inherently incurs
power draw on other system components with some workloads, so RAPL MSRs
should include that load as well.
But yep, at this point turns into a pointless bike-shedding.

PS2:
in nutshell, my questions are:
 * should we expose aux threads as other power meter device
 * would it be better to reuse/integrate with existing (hopefully mature)
   projects for monitoring on host side instead of duplicating a subset
   of capabilities in QEMU specific helper and then maintain it.

> With regards,
> Daniel


