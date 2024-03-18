Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC305C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBUp-0006q3-El; Mon, 18 Mar 2024 07:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmBUZ-0006mc-Cl
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:49:24 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rmBUV-0001d2-Nb
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:49:23 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d46dd5f222so46871751fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710762556; x=1711367356; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/G7UMhedHuDKC58PKeFwA4NkKYuwpkOT+mP9mlFTtgQ=;
 b=Um5f/9aG73/AYqYLbt+p7x6emrv7d49kgFhlbXUeZFozjWSryHwsmcUU1V8wxw2Coy
 JBwqSpkUeniH2MgMCP5ZL8Q4nnrU5VV+yO7vqt080v2OthePsiGdBCiShx2GtskyhWx5
 QxXy1FW7Ge5MHcwbVcQdTRzimuzi0WERNTDIfdWfnSO77NLtDnDNjm5E7GmBEIZEIh00
 L6KJbJBTGQzhz/F3G6jLYx+X42zePxwZa8wYRNVNtPeRxAekTRCsxvB+bDBDGEei0/QV
 iqxm4Y6c3NVjeMo1w8IerMaXKqzCFCsvL+uBeQBStfaDs0XzLw9MaE4aA1056rGTKB1v
 SQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710762556; x=1711367356;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/G7UMhedHuDKC58PKeFwA4NkKYuwpkOT+mP9mlFTtgQ=;
 b=G6jieOwdCXv1h0QFTvLJLBhNc1veO5sOFX1bwRY2oOg8atKCwD1MUsEOl9Kr09KftW
 3Kp43YF+PzoL22+SIF0MPu3swbuaTdXC4YQVtTK7FxlNDjvzaCok2Tzyx0fooYNqKsx0
 MMladLTH7LeszLAoK3n7bzpOgpT2/pbxQosZzwiHPVSU1qJemMn2WMIY+f1ZKSA6RI+b
 tdrqJ/BKOo6O5D8bGSHjNyrQ28AoJy5aYPZtkzyKcklf+IQgxgQN66iQ+Yy2cuh8blMc
 KwRZTH1mG3qcYnqjgnsmnsCU0I0i8EGPFtNyu/KAnQze3p/lcbsuVgO5ZYDnBEYzF05E
 RAKw==
X-Gm-Message-State: AOJu0YxElQYKykBKoqUD56oHzyRKhXBLLLpWex9MLnCOwZ2kS7IHw4s6
 swlYxFrFI7tEEatESSn4AupD4BkCxBfscl2cTFISZ9SvXdVjUnGRIPAoqO0zH4w=
X-Google-Smtp-Source: AGHT+IEWQXMC2GsNPK13kfcwq0LL40d2CoPsoO14E3x9RpUfEB6L8zRc9UXxtYBcUykw1Gu3gSWyiA==
X-Received: by 2002:a05:651c:820:b0:2d2:ae55:f428 with SMTP id
 r32-20020a05651c082000b002d2ae55f428mr6760706ljb.34.1710762556264; 
 Mon, 18 Mar 2024 04:49:16 -0700 (PDT)
Received: from [192.168.7.166]
 (cpc81487-lanc8-2-0-cust139.3-3.cable.virginm.net. [81.110.179.140])
 by smtp.gmail.com with ESMTPSA id
 dh21-20020a0564021d3500b00568e3d3337bsm1242005edb.18.2024.03.18.04.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 04:49:16 -0700 (PDT)
Message-ID: <d09fe795c0903169bae50ae19173f11933574db8.camel@suse.com>
Subject: Re: [PATCH 7/9] i386/sev: Refactor setting of reset vector and
 initial CPU state
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, "Michael S
 . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Mon, 18 Mar 2024 11:49:15 +0000
In-Reply-To: <ZfB-9lPyDUHv6FbG@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <bf045e3364a0575d9680832dec5acba7aa441895.1709044754.git.roy.hopkins@suse.com>
 <ZeIJ-3zFzj0PAvDe@redhat.com>
 <734b9e05fe7acbc7c09c323f1d78956b0394360a.camel@suse.com>
 <ZfB-9lPyDUHv6FbG@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::230;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x230.google.com
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

On Tue, 2024-03-12 at 16:12 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 12, 2024 at 03:45:20PM +0000, Roy Hopkins wrote:
> > On Fri, 2024-03-01 at 17:01 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > On Tue, Feb 27, 2024 at 02:50:13PM +0000, Roy Hopkins wrote:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * Ideally we would provide the VMSA directly to kvm which
> > > > would
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * ensure that the resulting initial VMSA measurement which
> > > > is
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is
> > > > calculated
> > > > from
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * exactly what we provide here. Currently this is not
> > > > possible
> > > > so
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * we need to copy the parts of the VMSA structure that we
> > > > currently
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * support into the CPU state.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */
> > >=20
> > > This sounds like it is saying that the code is not honouring
> > > everything in the VMSA defiend by the IGVM file ?
> > >=20
> > > If so, that is pretty awkward. The VMSA is effectively an external
> > > ABI between QEMU and the guest owner (or whatever is validating
> > > guest attestation reports for them), and thus predictability and
> > > stability of this over time is critical.
> > >=20
> > > We don't want the attestation process to be dependent/variable on
> > > the particular QEMU/KVM version, because any upgrade to QEMU/KVM
> > > could then alter the effective VMSA that the guest owner sees.
> > >=20
> > > We've already suffered pain in this respect not long ago when the
> > > kernel arbitrarily changed a default setting which altered the
> > > VMSA it exposed, breaking existing apps that validate attestation.
> > >=20
> > > What will it take to provide the full VMSA to KVM, so that we can
> > > guarantee to the guest owner than the VMSA for the guest is going
> > > to perfectly match what their IGVM defined ?
> > >=20
> >=20
> > Yes, the fact that we have to copy the individual fields from the VMSA =
to
> > "CPUX86State" is less than ideal - a problem made worse by the fact tha=
t the
> > kernel does not allow direct control over some of the fields from users=
pace,
> > "sev_features" being a good example here where "SVM_SEV_FEAT_DEBUG_SWAP=
" is
> > unconditionally added by the kernel.
>=20
> Ah yes, the SVM_SEV_FEAT_DEBUG_SWAP feature is the one I couldn't remembe=
r
> the name of in my quoted text above, that break our apps when the kernel
> suddenly set it by default (thankfully now reverted in Linux with
> 5abf6dceb066f2b02b225fd561440c98a8062681).
>=20
> > The kernel VMSA is at least predictable. So, although we cannot yet all=
ow
> > full
> > flexibility in providing a complete VMSA from QEMU and guarantee it wil=
l be
> > honoured, we could check to see if any settings conflict with those imp=
osed
> > by
> > the kernel and exit with an error if this is the case. I chose not to
> > implement
> > for this first series but could easily add a patch to support this. The
> > problem
> > here is that it ties the version of QEMU to VMSA handling functionality=
 in
> > the
> > kernel. Any change to the VMSA handling in the kernel would potentially
> > invalidate the checks in QEMU. The one upside here is that this will ea=
sily
> > be
> > detectable by the attestation measurement not matching the expected
> > measurement
> > of the IGVM file. But it will be difficult for the user to determine wh=
at
> > the
> > discrepancy is.
>=20
> Yes, the difficulty in diagnosis is the big thing I'm worried about from
> a distro supportability POV. The DEBUG_SWAP issue caused us a bunch of
> pain and that's before CVMs are even widely used.
>=20
> I agree that hardcoding checks in QEMU is pretty unpleasant, and probably
> not something that I'd want us to do. I'd want QEMU to be able to live
> query the kernel's default initial VMSA, if it were to be reporting
> differences vs the IGVM provided VMSA. I dn't think there's a way to
> do that nicely though - i only know of ftrace probes to dump it informall=
y.
>=20
> I guess if we know & document what subset of the VMSA QEMU /can/ directly
> control, that at least narrows down where to look if something does chang=
e
> or go wrong.
>=20
Yes, it makes sense to document the subset that can be reliably set by QEMU=
,
along with any modifications made byt the kernel. Perhaps I should go one s=
tep
further and check that the VMSA does not contain any entries beyond what is
copied in "sev_apply_cpu_context()"? If any field other than those explicit=
ly
copied by this function contain a non-zero value then an error is generated=
.=C2=A0As
you suggest this will limit the scope of any measurement differences to the
documented subset.

> > The ideal solution is to add or modify a KVM ioctl to allow the VMSA to=
 be
> > set
> > directly, overriding the state in "CPUX86State". The current
> > KVM_SEV_LAUNCH_UPDATE_VMSA ioctl triggers the synchronisation of the VM=
SA
> > but
> > does not allow it to be specified directly. This could be modified for =
what
> > we
> > need. The SEV-SNP kernel patches add KVM_SEV_SNP_LAUNCH_UPDATE which al=
lows
> > a
> > page type of VMSA to be updated, although the current patch series does=
 not
> > support using this to set the initial state of the VMSA:
> > https://lore.kernel.org/lkml/20231230172351.574091-19-michael.roth@amd.=
com/=C2=A0
> > I
> > have experimented with this myself and have successfully modified the S=
EV-
> > SNP
> > kernel patches to support directly setting the VMSA from QEMU.
> >=20
> > On the other hand, I have also verified that I can indeed measure an IG=
VM
> > file
> > loaded using the VMSA synchronisation method currently employed and get=
 a
> > matching measurement from the SEV attestation report.
> >=20
> > What would you suggest is the best way forward for this?
>=20
> I'll delegate to Paolo for an opinion on the possiblity of new (or
> updated) ioctls to provide the full VMSA data.
>=20
> If we can't directly set the full VMSA, then next best option is a
> more formal way query to VMSA. That way libvirt could report on
> what the default initial kernel VMSA state is, which could be useful
> debug info for any bug reports.
Setting the full VMSA definitely seems like the right option here. Querying=
 the
VMSA that was actually measured would obviously give us the ability to diag=
nose
problems with the measurement but does not allow full compatibility with th=
e
IGVM specification. This will potentially restrict the types of guests that=
 can
be packaged using IGVM.

Another thing to bear in mind is that with the incoming host kernel support=
 for
SEV-SNP, there are more constraints on how the VMSA is measured and populat=
ed.
In particular, the current patches for SEV-SNP automatically sync and measu=
re
the VMSA as the final stage of guest measurement, requiring the IGVM file t=
o
provide the VMSA as the final directive for the measurement to match. Also,=
 the
kernel hardcodes the VMSA GPA, again requiring the IGVM file to match. If w=
e
have the ability to provide the VMSA directly (including the GPA of the VMS=
A)
then these restrictions are removed.

I'd suggest that for SEV and SEV-ES, the current method of syncing certain
fields (and updating the QEMU documentation to describe this) is sufficient=
 for
now. And perhaps this is ok for SEV-SNP too, but we should pursue the abili=
ty to
provide the full VMSA at least in the SEV-SNP case.

>=20
> With regards,
> Daniel

Kind regards,
Roy

