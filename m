Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3792E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 02:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO6Le-0007da-9e; Wed, 18 Dec 2024 21:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34IVjZwYKCrstfbokdhpphmf.dpnrfnv-efwfmopohov.psh@flex--seanjc.bounces.google.com>)
 id 1tO6Lc-0007dR-W3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 21:33:09 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34IVjZwYKCrstfbokdhpphmf.dpnrfnv-efwfmopohov.psh@flex--seanjc.bounces.google.com>)
 id 1tO6Lb-0005sU-0p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 21:33:08 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2161d5b3eb5so2853365ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 18:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734575584; x=1735180384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=HQz/W0jA/cWE29IHSyfApDS/sF2Zud2SdAZLUMT0YUo=;
 b=IdkaB1nlcNX7qn1jz9z2rTJP+inTr+zIxY/tz3hwT/DQneQa0ri6zs6f1i+pqSTGDv
 OWjTgkFGRw0uVlduhNj2I5hOp9OBdJ44PeSZ0pCOlsGzb01JLx1nieOchUaDossCe/54
 JfbEmyTazcyYRsBwqeLEDKkR3odyZwWFN1PU8snreJmymGFWcOVFNbPNT0q69D6THsTL
 lWWhBcWFUsPI2fraUuQO+QXJwLN4mQTTyczWpzT341AAz3ZJ7L1thIzSy8rCA2QCzJGg
 nOWOQk/agSJZuoi7pPGG66j+gqDTeQm1HDKPzJ5JYFYmoODFytclk2aFHlHoH3yUBv+B
 /ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575584; x=1735180384;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HQz/W0jA/cWE29IHSyfApDS/sF2Zud2SdAZLUMT0YUo=;
 b=VLTDipVYZZYlbZSQp/YEmMNuwOy/8cfd6mg6xv1CXoUyTlap/GYGPPZX8uVCdOZtTx
 sCKUTXE9FYC6xXDmE/ENcf7EMIXZvy4GN39lLVffcPjgAyIAThmDPQJ2TYEwP5YxTYv/
 pVUjPiiZovYp/ayfxf4yM/xlDR2YA2e0NG3J7xpcbSZ8EC3EKy0nK16GjbTar93WZ28B
 1/cw6oFz1mdYBqJEVjTzgoOssCfvflngYQEzT6RcLkWbSYypt0ScxJcNsHCb1tvnmFQG
 NXoJyB7UQk3a4Q5LBHHyzed8mzA64pS2bQ62a508mWrYgRFt4flX0bXRlA0JsGmPAuJw
 pBog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPKmhlV775UDh47nWAy7cVoXBY94eIKtFGwQT6GK67u0Sz7gDjcibfpoVmC0o4Vx0xjoQc//ki8VX4@nongnu.org
X-Gm-Message-State: AOJu0YxyrCN5ucvZ1euGMm36IC+eSuFTHWfzDGmqnMxujnmeW8Qg5frr
 IKFCcy/i1gY27gDWMoeuhQDA2DwFPp9D2qgA/yiaWE69OuWwW5/oPh8MH4FG6SZXjIPFbY58wUf
 vtA==
X-Google-Smtp-Source: AGHT+IGvNxp6Y5CDKAj2Fil5RlhKrICn/fVyxK4RhafU7lQC1PQbHLvUMm/awn2nglyRSxT/yimJ3J4w8eA=
X-Received: from plev13.prod.google.com ([2002:a17:903:31cd:b0:216:248e:8fab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c410:b0:215:7faa:ece2
 with SMTP id d9443c01a7336-219d96ff1cemr29517635ad.35.1734575584390; Wed, 18
 Dec 2024 18:33:04 -0800 (PST)
Date: Wed, 18 Dec 2024 18:33:03 -0800
In-Reply-To: <f58c24757f8fd810e5d167c8b6da41870dace6b1.camel@intel.com>
Mime-Version: 1.0
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
 <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
 <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
 <Z2DZpJz5K9W92NAE@google.com>
 <3ef942fa615dae07822e8ffce75991947f62f933.camel@intel.com>
 <Z2INi480K96q2m5S@google.com>
 <f58c24757f8fd810e5d167c8b6da41870dace6b1.camel@intel.com>
Message-ID: <Z2OEQdxgLX0GM70n@google.com>
Subject: Re: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, 
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, 
 Reinette Chatre <reinette.chatre@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=34IVjZwYKCrstfbokdhpphmf.dpnrfnv-efwfmopohov.psh@flex--seanjc.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Dec 19, 2024, Rick P Edgecombe wrote:
> On Tue, 2024-12-17 at 16:08 -0800, Sean Christopherson wrote:
> > On Tue, Dec 17, 2024, Rick P Edgecombe wrote:
> > > Some options discussed on the call:
> > >=20
> > > 1. If we got a promise to require any new CPUID bits that clobber hos=
t state to
> > > require an opt-in (attributes bit, etc) then we could get by with a p=
romise for
> > > that too. The current situation was basically to assume TDX module wo=
uldn't open
> > > up the issue with new CPUID bits (only attributes/xfam).
> > > 2. If we required any new configurable CPUID bits to save/restore hos=
t state
> > > automatically then we could also get by, but then KVM's code that doe=
s host
> > > save/restore would either be redundant or need a TDX branch.
> > > 3. If we prevent setting any CPUID bits not supported by KVM, we woul=
d need to
> > > track these bits in KVM. The data backing GET_SUPPORTED_CPUID is not =
sufficient
> > > for this purpose since it is actually more like "default values" then=
 a mask of
> > > supported bits. A patch to try to do this filtering was dropped after=
 upstream
> > > discussion.[0]
> >=20
> > The only CPUID bits that truly matter are those that are associated wit=
h hardware
> > features the TDX module allows the guest to use directly.  And for thos=
e, KVM
> > *must* know if they are fixed0 (inverted polarity only?), fixed1, or co=
nfigurable.
> > As Adrian asserted, there probably aren't many of them.
>=20
> I don't follow why the fixed bits are special here. If any configuration =
can
> affect the host, KVM needs to know about it. Whether it is fixed or
> configurable.

I think we're in violent agreement.  Ignore the last line about Adrian's as=
sertion,
which was very poorly phrased, and the above boils down to:

  The only CPUID bits that truly matter are those that are associated with =
hardware
  features the TDX module allows the guest to use directly, and KVM *must* =
know
  if the bits are fixed0, fixed1, or configurable.

> I wonder if there could be some confusion about how much KVM can trust th=
at its
> view of the CPUID bits is the same as the TDX Modules? In the current pat=
ches
> userspace is responsible for assembling KVM's CPUID data which it sets wi=
th
> KVM_SET_CPUID2 like normal. It fetches all the set bits from the TDX modu=
le,
> massages them, and pass them to KVM. So if a host affecting configurable =
bit is
> set in the TDX module, but not in KVM then it could be a problem. I think=
 we
> need to reassess which bits could affect host state, and make sure we re-=
check
> them before entering the TD. But we can't simply check that all bits matc=
h
> because there are some bits that are set in KVM, but not TDX module (real=
 PV
> leafs, guestmaxpa, etc).
>=20
> So that is how I arrived at that we need some list of host affecting bits=
 to
> verify match in the TD.

At the end of the day, the list is going to be human-generated.  For the UX=
 side
of things, it makes sense to push that responsibility to the TDX Module, be=
cause
it should be trivially easy to derive from the source code.

But identifying CPUID bits that control features requires human interventio=
n (or
I suppose AI that can cross-reference specs with code).

Again, I think we're in violent agreement.

> > For all other CPUID bits, what the TDX Module thinks and/or presents to=
 the guest
> > is completely irrelevant, at least as far as KVM cares, and to some ext=
ent as far
> > as QEMU cares.  This includes the TDX Module's FEATURE_PARAVIRT_CTRL, w=
hich frankly
> > is asinine and should be ignored.  IMO, the TDX Module spec is entirely=
 off the
> > mark in its assessment of paravirtualization.  Injecting a #VE instead =
of a #GP
> > isn't "paravirtualization".
> > =20
> > Take TSC_DEADLINE as an example.  "Disabling" the feature from the gues=
t's side
> > simply means that WRMSR #GPs instead of #VEs.  *Nothing* has changed fr=
om KVM's
> > perspective.  If the guest makes a TDVMCALL to write IA32_TSC_DEADLINE,=
 KVM has
> > no idea if the guest has opted in/out of #VE vs #GP.  And IMO, a sane g=
uest will
> > never take a #VE or #GP if it wants to use TSC_DEADLINE; the kernel sho=
uld instead
> > make a direct TDVMCALL and save itself a pointless exception.
> >=20
> >   Enabling Guest TDs are not allowed to access the IA32_TSC_DEADLINE MS=
R directly.
> >   Virtualization of IA32_TSC_DEADLINE depends on the virtual value of
> >   CPUID(1).ECX[24] bit (TSC Deadline). The host VMM may configure (as a=
n input to
> >   TDH.MNG.INIT) virtual CPUID(1).ECX[24] to be a constant 0 or allow it=
 to be 1
> >   if the CPU=E2=80=99s native value is 1.
> >=20
> >   If the TDX module supports #VE reduction, as enumerated by TDX_FEATUR=
ES0.VE_REDUCTION
> >   (bit 30), and the guest TD has set TD_CTLS.REDUCE_VE to 1, it may con=
trol the
> >   value of virtual CPUID(1).ECX[24] by writing TDCS.FEATURE_PARAVIRT_CT=
RL.TSC_DEADLINE.=20
> >=20
> >   =E2=80=A2 If the virtual value of CPUID(1).ECX[24] is 0, IA32_TSC_DEA=
DLINE is virtualized
> >     as non-existent. WRMSR or RDMSR attempts result in a #GP(0).
> >=20
> >   =E2=80=A2 If the virtual value of CPUID(1).ECX[24] is 1, WRMSR or RDM=
SR attempts result
> >     in a #VE(CONFIG_PARAVIRT). This enables the TD=E2=80=99s #VE handle=
r.
> >=20
> > Ditto for TME, MKTME.
> >=20
> > FEATURE_PARAVIRT_CTRL.MCA is even weirder, but I still don't see any re=
ason for
> > KVM or QEMU to care if it's fixed or configurable.  There's some crazy =
logic for
> > whether or not CR4.MCE can be cleared, but the host can't see guest CR4=
, and so
> > once again, the TDX Module's view of MCA is irrelevant when it comes to=
 handling
> > TDVMCALL for the machine check MSRs.
> >=20
> > So I think this again purely comes to back to KVM correctness and safet=
y.  More
> > specifically, the TDX Module needs to report features that are uncondit=
ionally
> > enabled or disabled and can't be emulated by KVM.  For everything else,=
 I don't
> > see any reason to care what the TDX module does.
> >=20
> > I'm pretty sure that gives us a way forward.  If there only a handful o=
f features
> > that are unconditionally exposed to the guest, then KVM forces those fe=
atures in
> > cpu_caps[*].
>=20
> I see. Hmm. We could use this new interface to double check the fixed bit=
s. It
> seems like a relatively cheap sanity check.
>=20
> There already is an interface to get CPUID bits (fixed and dynamic). But =
it only
> works after a TD is configured. So if we want to do extra verification or
> adjustments, we could use it before entering the TD. Basically, if we del=
ay this
> logic we don't need to wait for the fixed bit interface.

Oh, yeah, that'd work.  Grab the guest CPUID and then verify that bits KVM =
needs
to be 0 (or 1) are set according, and WARN+kill if there's a mismatch.

Honestly, I'd probably prefer that over using the fixed bit interface, as m=
y gut
says it's less likely for the TDX Module to misreport what CPUID it has cre=
ated
for the guest, than it is for the TDX module to generate a "fixed bits" lis=
t that
doesn't match the code.  E.g. KVM has (had?) more than a few CPUID features=
 that
KVM emulates without actually reporting support to userspace.

> What is special about the new proposed fixed bit interface is that it can=
 run
> before a TD runs (when QEMU wants to do it's checking of the users args).

