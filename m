Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1530FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 17:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOgM0-0000UG-Cd; Fri, 20 Dec 2024 11:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hKJlZwYKCqETFBOKDHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--seanjc.bounces.google.com>)
 id 1tOgLy-0000Ti-SX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:59:54 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hKJlZwYKCqETFBOKDHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--seanjc.bounces.google.com>)
 id 1tOgLv-0002ya-7n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:59:53 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2ee6dccd3c9so1945774a91.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734713988; x=1735318788; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=n61l0zrRSrZD3ftUtvSs02eIlCxovtOVrwB65P210Fg=;
 b=lP47JayOxKOlql+TlHDwlEyc2qyyK18J6m7Pmk+V/ZocG7EGUEpmJGudBa2AUFEXfv
 aGWTXazQDlsziGzSbaQfE/FUqUhxgcHJdblyQQbqwfhhkmxy34HTK+je5aUFskBg++Aa
 RNfy3u15GbBm6E26uqjE4Aqlta+LeH24dNGcBruQrG7xna3XWAbCx4d+JC6YRAfokgcl
 Yd5msUNbO9pZge2ikF80UU+oA697hMQkWn1eOhhu3zHEjYGqfRub3euB6iE6jE+f7s9A
 uYEvPjDknc6C0CW1kSmHvJIMYq4YlxjTgWivp1bS9swpzwUA4H0s9Sqjg8HgbJSA7SY8
 iMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734713988; x=1735318788;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n61l0zrRSrZD3ftUtvSs02eIlCxovtOVrwB65P210Fg=;
 b=WwxC4KmyXQWVDCOP1JagX/IBXFCdjm+fX7y88RuM/5JBU6gxksAz0Ku5ZIeGTDGCr6
 8dBiXh2icBkb2wpoeQa9ggK+Wx0LxVgEPuuLGFLfa215JzrJDtGkUB4wIqcI8fiG/cVE
 4pYWJEhTlRo+MIgNjKYScCw3rp0rsxh6ANDbKGljaJzrvlwVQ5Ej53Tnyr4Lc27f5GRF
 1Drkcz9URrZvlnVHaqJeDTC0CAg3ssUgIGrdUBeOoFN5Z83LY910xVaLkhAJ5KC02xYq
 zO4zeDsr3+XbS0APPxHIsycINUUpX43+XUadDiwD8hlG3z6tQwvi/GvCkxbIryo6zIZT
 r+IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi3g9kI7b7k1IQJYQ4hHtu+kXFDvtu6Y7waPniSrpcyiZR+nxYBLECReivjI9SqUVZJoid41QdKlaV@nongnu.org
X-Gm-Message-State: AOJu0Yz45NTMLC0KVcipC+AC4aHU2z43/oDZ7pIs8l0hNxFRBUFqAB/N
 UGyWNBi+GsTdiH1Xp4rH9vO+y+EnCH77VFLmo9/H+uXF8SXB//BcerTvDAecPoDHSHzKDJJYTFx
 mWA==
X-Google-Smtp-Source: AGHT+IGdgk5HiSUnypJSBS1nKyIa0BWmsZTWLmrxxURD+4sMnll4s3ySbEPev1+VFPU7ihrePN1uazKe0nI=
X-Received: from pjbqn3.prod.google.com ([2002:a17:90b:3d43:b0:2e2:44f2:9175])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ccc:b0:2ef:3192:d280
 with SMTP id 98e67ed59e1d1-2f452dfaed8mr5764829a91.5.1734713988589; Fri, 20
 Dec 2024 08:59:48 -0800 (PST)
Date: Fri, 20 Dec 2024 08:59:47 -0800
In-Reply-To: <88c87ff8-bae0-4522-bb65-109b959a7e52@intel.com>
Mime-Version: 1.0
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
 <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
 <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
 <Z2DZpJz5K9W92NAE@google.com>
 <3ef942fa615dae07822e8ffce75991947f62f933.camel@intel.com>
 <Z2INi480K96q2m5S@google.com>
 <f58c24757f8fd810e5d167c8b6da41870dace6b1.camel@intel.com>
 <Z2OEQdxgLX0GM70n@google.com> <88c87ff8-bae0-4522-bb65-109b959a7e52@intel.com>
Message-ID: <Z2Wig9CiowRkeeOl@google.com>
Subject: Re: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Kai Huang <kai.huang@intel.com>, 
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, 
 Yan Y Zhao <yan.y.zhao@intel.com>, 
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3hKJlZwYKCqETFBOKDHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

On Fri, Dec 20, 2024, Xiaoyao Li wrote:
> On 12/19/2024 10:33 AM, Sean Christopherson wrote:
> > > > For all other CPUID bits, what the TDX Module thinks and/or present=
s to the guest
> > > > is completely irrelevant, at least as far as KVM cares, and to some=
 extent as far
> > > > as QEMU cares.  This includes the TDX Module's FEATURE_PARAVIRT_CTR=
L, which frankly
> > > > is asinine and should be ignored.  IMO, the TDX Module spec is enti=
rely off the
> > > > mark in its assessment of paravirtualization.  Injecting a #VE inst=
ead of a #GP
> > > > isn't "paravirtualization".
> > > > Take TSC_DEADLINE as an example.  "Disabling" the feature from the =
guest's side
> > > > simply means that WRMSR #GPs instead of #VEs.*Nothing* has changed =
from KVM's
> > > > perspective.  If the guest makes a TDVMCALL to write IA32_TSC_DEADL=
INE, KVM has
> > > > no idea if the guest has opted in/out of #VE vs #GP.  And IMO, a sa=
ne guest will
> > > > never take a #VE or #GP if it wants to use TSC_DEADLINE; the kernel=
 should instead
> > > > make a direct TDVMCALL and save itself a pointless exception.
> > > >=20
> > > >    Enabling Guest TDs are not allowed to access the IA32_TSC_DEADLI=
NE MSR directly.
> > > >    Virtualization of IA32_TSC_DEADLINE depends on the virtual value=
 of
> > > >    CPUID(1).ECX[24] bit (TSC Deadline). The host VMM may configure =
(as an input to
> > > >    TDH.MNG.INIT) virtual CPUID(1).ECX[24] to be a constant 0 or all=
ow it to be 1
> > > >    if the CPU=E2=80=99s native value is 1.
> > > >=20
> > > >    If the TDX module supports #VE reduction, as enumerated by TDX_F=
EATURES0.VE_REDUCTION
> > > >    (bit 30), and the guest TD has set TD_CTLS.REDUCE_VE to 1, it ma=
y control the
> > > >    value of virtual CPUID(1).ECX[24] by writing TDCS.FEATURE_PARAVI=
RT_CTRL.TSC_DEADLINE.
> > > >=20
> > > >    =E2=80=A2 If the virtual value of CPUID(1).ECX[24] is 0, IA32_TS=
C_DEADLINE is virtualized
> > > >      as non-existent. WRMSR or RDMSR attempts result in a #GP(0).
> > > >=20
> > > >    =E2=80=A2 If the virtual value of CPUID(1).ECX[24] is 1, WRMSR o=
r RDMSR attempts result
> > > >      in a #VE(CONFIG_PARAVIRT). This enables the TD=E2=80=99s #VE h=
andler.
> > > >=20
> > > > Ditto for TME, MKTME.
> > > >=20
> > > > FEATURE_PARAVIRT_CTRL.MCA is even weirder, but I still don't see an=
y reason for
> > > > KVM or QEMU to care if it's fixed or configurable.  There's some cr=
azy logic for
> > > > whether or not CR4.MCE can be cleared, but the host can't see guest=
 CR4, and so
> > > > once again, the TDX Module's view of MCA is irrelevant when it come=
s to handling
> > > > TDVMCALL for the machine check MSRs.
> > > >=20
> > > > So I think this again purely comes to back to KVM correctness and s=
afety.  More
> > > > specifically, the TDX Module needs to report features that are unco=
nditionally
> > > > enabled or disabled and can't be emulated by KVM.  For everything e=
lse, I don't
> > > > see any reason to care what the TDX module does.
> > > >=20
> > > > I'm pretty sure that gives us a way forward.  If there only a handf=
ul of features
> > > > that are unconditionally exposed to the guest, then KVM forces thos=
e features in
> > > > cpu_caps[*].
> > > I see. Hmm. We could use this new interface to double check the fixed=
 bits. It
> > > seems like a relatively cheap sanity check.
> > >=20
> > > There already is an interface to get CPUID bits (fixed and dynamic). =
But it only
> > > works after a TD is configured. So if we want to do extra verificatio=
n or
> > > adjustments, we could use it before entering the TD. Basically, if we=
 delay this
> > > logic we don't need to wait for the fixed bit interface.
> > Oh, yeah, that'd work.  Grab the guest CPUID and then verify that bits =
KVM needs
> > to be 0 (or 1) are set according, and WARN+kill if there's a mismatch.
> >=20
> > Honestly, I'd probably prefer that over using the fixed bit interface, =
as my gut
> > says it's less likely for the TDX Module to misreport what CPUID it has=
 created
> > for the guest, than it is for the TDX module to generate a "fixed bits"=
 list that
> > doesn't match the code.  E.g. KVM has (had?) more than a few CPUID feat=
ures that
> > KVM emulates without actually reporting support to userspace.
>=20
> The original motivation of the proposed fxied0 and fixed1 data is to
> complement the CPUID configurability report, which is important for
> userspace. E.g., Currently, what QEMU is doing is hardcoding the fixed0 a=
nd
> fixed1 information of a specific TDX release to adjust the
> KVM_GET_SUPPORTED_CPUID result and gets a final "supported" CPUID set for
> TDX. Hardcoding is not a good idea and it's better that KVM can get the d=
ata
> from TDX module, then pass to userspace (of course KVM can tweak the data
> based on its own requirement). So, do you think it's useful to have TDX
> module report the fixed0/fixed1 data for this purpose?

I'm definitely supportive of KVM passing on accurate information, so long a=
s KVM's
ABI isn't too crazy.

That said, I'm starting to agree with Rick's assessment that trying to enum=
erate
fixed CPUID feature bits is becoming a fool's errand as the TDX architectur=
e gets
more and more complex.

But _that_ said, if userspace ever needs to pivot on the TDX Module *versio=
n*,
then IMO that's a non-starter.  E.g. QEMU shouldn't have to hardcode fixed0=
/fixed1
bits based on TDX 1.5.whatever vs. TDX 2.0.whatever.

One alternative idea to trying to enumerate every fixed bit would be to mim=
ic what
the VMX architecture does for fixed CR0 bits.  Use TDX Module spec 1.5.06 (=
or whatever
version makes the most sense) as the base, and then adjust fixed/configurab=
le
information based on *features*.  E.g. when unrestricted guest is enabled, =
CR0.PG
and CR0.PE switch from fixed0 to configurable.  At a glance, I think the wh=
ole #VE
reduction madness could follow a similar path.

And then if the TDX tries to add fixed bits in the future that aren't expli=
citly
and clearly tied to some feature enablement, we collectively reject that TD=
X spec.

