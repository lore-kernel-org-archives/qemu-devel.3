Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B83C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4Jl-0000VQ-Of; Tue, 12 Mar 2024 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rk4Jj-0000MQ-SI
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:45:27 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rk4Jg-0002s1-N0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:45:27 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513b39eea3dso23241e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710258322; x=1710863122; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M+JWEdSw+TmTgZRFPya7nOirljMex3dYgbn9E4vzyRk=;
 b=PNw8Dboo1nO6hodGWjDkjAqPQmtD0oxwlRMmz0vUwg6pxH348HGeAi9JF3wJdalVNW
 XscCStG8ymsXhmX2iWmPjeBYFBdqDQFbMMBkOFRSkX61TMahMLGpDQQCAEpdyBsXgDKk
 obhy5r/kHI8yko0VulKSEn31pBHpXdBiT0aArrqT0LBULEM2JAsTHF0o7K49wGCoK9Ne
 hTarrKZDsUzD7HCRKXeV/pBQOwZj9hGzMLNHXGqQgGSemCRZOQ/s+4dLOaMzGF9lC3jc
 1YKroIzwM4nQ1ZaCK5rn961dZuaXRZNpZFH8J1zoc3yG/H2/cx6+MgVCF+MR2AB/zHn2
 NWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710258322; x=1710863122;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M+JWEdSw+TmTgZRFPya7nOirljMex3dYgbn9E4vzyRk=;
 b=OQTbb579Z882BiARlQWTqTpc1Nd+MwzP9qY7aIR0oz70klk/qOEswXPD/9HRym2hfb
 UWcVK0aRdOiohy1c3dU+F/yITrrX5qRvwuZqHhQ2fiM7/s5hOxRheQEySf5A/Lj0SCER
 HfZfYSGqXTQqjA0MgR7WYIRkDl6FKOEbxJCm3w7R9C+10abbNEyAXIlW/veywbi+Aigk
 dB03lCjj9g9bzbWUWmCIib5NjRgecOZpCNpSrBgOKrlRDFa0WyrNkjNLYjlT33PBs9YQ
 gnbwf8EvZvb19KLwmpcWaTHN2UpMOeot7FmS3oDht/Lom81DPbkLmEgH3G9Fj4Tgud34
 0GkA==
X-Gm-Message-State: AOJu0Yw2TJJ1EoRvv/lAOapT5GagbDumE/iCvFSK5/kCInvZw04ot22c
 WIxzw0z+PPeVrMQsVdyBCPHcxbGfwRrHTpMBfUKzCiZc17XkdiHJNBxVwhhXV00=
X-Google-Smtp-Source: AGHT+IFnWl9KcyR9qGa+MxITi3l4Nn4Mi7LaluC3DNHxSIuXWNv+O56tM4uYKg6zCeCob3ZboRGFAg==
X-Received: by 2002:ac2:58ce:0:b0:513:21a9:79a8 with SMTP id
 u14-20020ac258ce000000b0051321a979a8mr2629643lfo.62.1710258321795; 
 Tue, 12 Mar 2024 08:45:21 -0700 (PDT)
Received: from [192.168.7.188]
 (cpc81487-lanc8-2-0-cust139.3-3.cable.virginm.net. [81.110.179.140])
 by smtp.gmail.com with ESMTPSA id
 ju18-20020a170906e91200b00a4628cacad4sm2012461ejb.195.2024.03.12.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:45:21 -0700 (PDT)
Message-ID: <734b9e05fe7acbc7c09c323f1d78956b0394360a.camel@suse.com>
Subject: Re: [PATCH 7/9] i386/sev: Refactor setting of reset vector and
 initial CPU state
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
Date: Tue, 12 Mar 2024 15:45:20 +0000
In-Reply-To: <ZeIJ-3zFzj0PAvDe@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <bf045e3364a0575d9680832dec5acba7aa441895.1709044754.git.roy.hopkins@suse.com>
 <ZeIJ-3zFzj0PAvDe@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::129;
 envelope-from=roy.hopkins@suse.com; helo=mail-lf1-x129.google.com
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

On Fri, 2024-03-01 at 17:01 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 27, 2024 at 02:50:13PM +0000, Roy Hopkins wrote:
> > When an SEV guest is started, the reset vector and state are
> > extracted from metadata that is contained in the firmware volume.
> >=20
> > In preparation for using IGVM to setup the initial CPU state,
> > the code has been refactored to populate vmcb_save_area for each
> > CPU which is then applied during guest startup and CPU reset.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > =C2=A0target/i386/sev.c | 288 +++++++++++++++++++++++++++++++++++++++++=
-----
> > =C2=A0target/i386/sev.h | 110 ++++++++++++++++++
> > =C2=A02 files changed, 369 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 173de91afe..d6902432fd 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -74,9 +74,7 @@ struct SevGuestState {
> > =C2=A0=C2=A0=C2=A0=C2=A0 SevState state;
> > =C2=A0=C2=A0=C2=A0=C2=A0 gchar *measurement;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 uint32_t reset_cs;
> > -=C2=A0=C2=A0=C2=A0 uint32_t reset_ip;
> > -=C2=A0=C2=A0=C2=A0 bool reset_data_valid;
> > +=C2=A0=C2=A0=C2=A0 QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
> > =C2=A0};
> > =C2=A0
> > =C2=A0#define DEFAULT_GUEST_POLICY=C2=A0=C2=A0=C2=A0 0x1 /* disable deb=
ug */
> > @@ -99,6 +97,12 @@ typedef struct QEMU_PACKED SevHashTableDescriptor {
> > =C2=A0/* hard code sha256 digest size */
> > =C2=A0#define HASH_SIZE 32
> > =C2=A0
> > +/* Convert between SEV-ES VMSA and SegmentCache flags/attributes */
> > +#define FLAGS_VMSA_TO_SEGCACHE(flags) \
> > +=C2=A0=C2=A0=C2=A0 ((((flags) & 0xff00) << 12) | (((flags) & 0xff) << =
8))
> > +#define FLAGS_SEGCACHE_TO_VMSA(flags) \
> > +=C2=A0=C2=A0=C2=A0 ((((flags) & 0xff00) >> 8) | (((flags) & 0xf00000) =
>> 12))
> > +
> > =C2=A0typedef struct QEMU_PACKED SevHashTableEntry {
> > =C2=A0=C2=A0=C2=A0=C2=A0 QemuUUID guid;
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint16_t len;
> > @@ -125,6 +129,15 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
> > =C2=A0QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 !=3D 0);
> > =C2=A0
> > =C2=A0static SevGuestState *sev_guest;
> > +
> > +typedef struct SevLaunchVmsa {
> > +=C2=A0=C2=A0=C2=A0 QTAILQ_ENTRY(SevLaunchVmsa) next;
> > +
> > +=C2=A0=C2=A0=C2=A0 uint16_t cpu_index;
> > +=C2=A0=C2=A0=C2=A0 uint64_t gpa;
> > +=C2=A0=C2=A0=C2=A0 struct sev_es_save_area vmsa;
> > +} SevLaunchVmsa;
> > +
> > =C2=A0static Error *sev_mig_blocker;
> > =C2=A0
> > =C2=A0static const char *const sev_fw_errlist[] =3D {
> > @@ -291,6 +304,149 @@ sev_guest_finalize(Object *obj)
> > =C2=A0{
> > =C2=A0}
> > =C2=A0
> > +static void sev_apply_cpu_context(CPUState *cpu)
> > +{
> > +=C2=A0=C2=A0=C2=A0 SevGuestState *sev_guest =3D SEV_GUEST(MACHINE(qdev=
_get_machine())->cgs);
> > +=C2=A0=C2=A0=C2=A0 X86CPU *x86;
> > +=C2=A0=C2=A0=C2=A0 CPUX86State *env;
> > +=C2=A0=C2=A0=C2=A0 struct SevLaunchVmsa *launch_vmsa;
> > +
> > +=C2=A0=C2=A0=C2=A0 /* See if an initial VMSA has been provided for thi=
s CPU */
> > +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(launch_vmsa, &sev_guest->launch_vmsa=
, next)
> > +=C2=A0=C2=A0=C2=A0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu->cpu_index =3D=3D l=
aunch_vmsa->cpu_index) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86=
 =3D X86_CPU(cpu);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
 =3D &x86->env;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Ideally we would provide the VMSA directly to kvm which
> > would
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * ensure that the resulting initial VMSA measurement which is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is calculated
> > from
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * exactly what we provide here. Currently this is not possible
> > so
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * we need to copy the parts of the VMSA structure that we
> > currently
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * support into the CPU state.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>=20
> This sounds like it is saying that the code is not honouring
> everything in the VMSA defiend by the IGVM file ?
>=20
> If so, that is pretty awkward. The VMSA is effectively an external
> ABI between QEMU and the guest owner (or whatever is validating
> guest attestation reports for them), and thus predictability and
> stability of this over time is critical.
>=20
> We don't want the attestation process to be dependent/variable on
> the particular QEMU/KVM version, because any upgrade to QEMU/KVM
> could then alter the effective VMSA that the guest owner sees.
>=20
> We've already suffered pain in this respect not long ago when the
> kernel arbitrarily changed a default setting which altered the
> VMSA it exposed, breaking existing apps that validate attestation.
>=20
> What will it take to provide the full VMSA to KVM, so that we can
> guarantee to the guest owner than the VMSA for the guest is going
> to perfectly match what their IGVM defined ?
>=20

Yes, the fact that we have to copy the individual fields from the VMSA to
"CPUX86State" is less than ideal - a problem made worse by the fact that th=
e
kernel does not allow direct control over some of the fields from userspace=
,
"sev_features" being a good example here where "SVM_SEV_FEAT_DEBUG_SWAP" is
unconditionally added by the kernel.

The kernel VMSA is at least predictable. So, although we cannot yet allow f=
ull
flexibility in providing a complete VMSA from QEMU and guarantee it will be
honoured, we could check to see if any settings conflict with those imposed=
 by
the kernel and exit with an error if this is the case. I chose not to imple=
ment
for this first series but could easily add a patch to support this. The pro=
blem
here is that it ties the version of QEMU to VMSA handling functionality in =
the
kernel. Any change to the VMSA handling in the kernel would potentially
invalidate the checks in QEMU. The one upside here is that this will easily=
 be
detectable by the attestation measurement not matching the expected measure=
ment
of the IGVM file. But it will be difficult for the user to determine what t=
he
discrepancy is.

The ideal solution is to add or modify a KVM ioctl to allow the VMSA to be =
set
directly, overriding the state in "CPUX86State". The current
KVM_SEV_LAUNCH_UPDATE_VMSA ioctl triggers the synchronisation of the VMSA b=
ut
does not allow it to be specified directly. This could be modified for what=
 we
need. The SEV-SNP kernel patches add KVM_SEV_SNP_LAUNCH_UPDATE which allows=
 a
page type of VMSA to be updated, although the current patch series does not
support using this to set the initial state of the VMSA:
https://lore.kernel.org/lkml/20231230172351.574091-19-michael.roth@amd.com/=
 I
have experimented with this myself and have successfully modified the SEV-S=
NP
kernel patches to support directly setting the VMSA from QEMU.

On the other hand, I have also verified that I can indeed measure an IGVM f=
ile
loaded using the VMSA synchronisation method currently employed and get a
matching measurement from the SEV attestation report.

What would you suggest is the best way forward for this?

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_load_efer(env, launch_vmsa->vmsa.efer);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_update_cr4(env, launch_vmsa->vmsa.cr4);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_update_cr0(env, launch_vmsa->vmsa.cr0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_update_cr3(env, launch_vmsa->vmsa.cr3);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_load_seg_cache(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env, R_CS, launch_vmsa->vmsa.cs.selector,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 launch_vmsa->vmsa.cs.base, launch_vmsa->vmsa.cs.limit=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.cs.attrib));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_load_seg_cache(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env, R_DS, launch_vmsa->vmsa.ds.selector,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 launch_vmsa->vmsa.ds.base, launch_vmsa->vmsa.ds.limit=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ds.attrib));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_load_seg_cache(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env, R_ES, launch_vmsa->vmsa.es.selector,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 launch_vmsa->vmsa.es.base, launch_vmsa->vmsa.es.limit=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.es.attrib));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_load_seg_cache(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env, R_FS, launch_vmsa->vmsa.fs.selector,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 launch_vmsa->vmsa.fs.base, launch_vmsa->vmsa.fs.limit=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.fs.attrib));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_load_seg_cache(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env, R_GS, launch_vmsa->vmsa.gs.selector,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 launch_vmsa->vmsa.gs.base, launch_vmsa->vmsa.gs.limit=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.gs.attrib));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_x86_load_seg_cache(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env, R_SS, launch_vmsa->vmsa.ss.selector,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 launch_vmsa->vmsa.ss.base, launch_vmsa->vmsa.ss.limit=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ss.attrib));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->gdt.base =3D launch_vmsa->vmsa.gdtr.base;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->gdt.limit =3D launch_vmsa->vmsa.gdtr.limit;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->idt.base =3D launch_vmsa->vmsa.idtr.base;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->idt.limit =3D launch_vmsa->vmsa.idtr.limit;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_EAX] =3D launch_vmsa->vmsa.rax;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_ECX] =3D launch_vmsa->vmsa.rcx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_EDX] =3D launch_vmsa->vmsa.rdx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_EBX] =3D launch_vmsa->vmsa.rbx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_ESP] =3D launch_vmsa->vmsa.rsp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_EBP] =3D launch_vmsa->vmsa.rbp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_ESI] =3D launch_vmsa->vmsa.rsi;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_EDI] =3D launch_vmsa->vmsa.rdi;
> > +#ifdef TARGET_X86_64
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R8] =3D launch_vmsa->vmsa.r8;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R9] =3D launch_vmsa->vmsa.r9;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R10] =3D launch_vmsa->vmsa.r10;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R11] =3D launch_vmsa->vmsa.r11;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R12] =3D launch_vmsa->vmsa.r12;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R13] =3D launch_vmsa->vmsa.r13;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R14] =3D launch_vmsa->vmsa.r14;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->regs[R_R15] =3D launch_vmsa->vmsa.r15;
> > +#endif
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env=
->eip =3D launch_vmsa->vmsa.rip;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
>=20
>=20
> With regards,
> Daniel

Regards,
Roy


