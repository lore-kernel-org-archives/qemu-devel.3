Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899E3E77184
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 00:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNhcf-0001Go-MN; Tue, 17 Dec 2024 19:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kxJiZwYKCoIykgtpimuumrk.iuswks0-jk1krtutmt0.uxm@flex--seanjc.bounces.google.com>)
 id 1tNhcc-0001GU-H8
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 19:09:03 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kxJiZwYKCoIykgtpimuumrk.iuswks0-jk1krtutmt0.uxm@flex--seanjc.bounces.google.com>)
 id 1tNhcU-0007id-Nu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 19:09:02 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2eeeb5b7022so5509381a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734480532; x=1735085332; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=st2IAj6IOBo51GPhAmFtzPu7zBrruXbW4TvInWYdQ6A=;
 b=UPCRU1OMEbibNzCn/COsiXChlO8yV/oTxehbffrIP3GZVDSONMDmAmoFAVsotKCFBL
 6C/BP8sJ9IboNTXl5D7Rfq20ahekTxT9cF7ZwndlJfVPiOjdF28YsdwfKgYDL0jBLoRR
 RwZ17u9JFRuYM6JL4w8sqkioKdcUXG9FoO5UPWLFd0RDVvjyu7ZgaVWgFmXKcd+il6YD
 bRuj4bvhmEcl65y8FoW1fYt4z0vpm7fgQkgaNwJ0K8SKDNsJs36QAZqoBRUjXBaJJUeT
 lTNIjAnAwuID7/kh6vjW2LbUVhwHttZDhZego+HH94Yc8YiH+cOhTLYjVMSzl0y3H4dC
 ZdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734480532; x=1735085332;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=st2IAj6IOBo51GPhAmFtzPu7zBrruXbW4TvInWYdQ6A=;
 b=B+DweHSH+txyQ03KLrpzQy8C9dl628eIkkuGbReNRYmEFM7ROIg/wxnzYuq+BZMXOk
 qoDEIHfrR+rrxIh5JxvlWruPVJPikFkIiusVhEhTZeWHWkJ76in3teJaBGiyG/FsaEjm
 LhjiAXEpmyZyGoLBbDHcWF3UWkv6pgQUt1yeyEvAoBMqSi4FojoUSUQ+8c/tZdKhs9OG
 m1MA3q/WLDZVH+6l8hcNkGV3zFOJSrbRXis6JIPXtGInDOEGhmQhr5S1Su1oFNW+2fz3
 TV66l0MlgBGJgylM62KtRpYZECFAajbvNe/lnoUkV6cThRUl5di+4xD2n0x70wJHv1wB
 GqNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdFPLb22noxbOjO85jcDKX+UC5zQfuDVGLboeuqM8Dao7OIzeeX6WaHJA2fHYm6YUt2TVOnUArSPBU@nongnu.org
X-Gm-Message-State: AOJu0Yxhg+WpRJLEJHSQ+hj57famDxjoRG8GGXAQMxgciKQWOR01EEMe
 N63sAIXoVs2G7B8Gk9zuMoiBIJhBQ3nxtT2zjXNWchkJA2V2YyntGPE7RycJTDLdcb71IQ/4y1n
 9mA==
X-Google-Smtp-Source: AGHT+IEvw+3WTZ19MkBtE5+J2V7DUw5s6WfLWarD7KcORBXUM2PQBWzwSUsIh3pqEldb+UbEIvQfqAeEFdI=
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:2ef:94c6:5048])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:350f:b0:2ee:b666:d14a
 with SMTP id 98e67ed59e1d1-2f2e91f813amr1345849a91.17.1734480531629; Tue, 17
 Dec 2024 16:08:51 -0800 (PST)
Date: Tue, 17 Dec 2024 16:08:50 -0800
In-Reply-To: <3ef942fa615dae07822e8ffce75991947f62f933.camel@intel.com>
Mime-Version: 1.0
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
 <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
 <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
 <Z2DZpJz5K9W92NAE@google.com>
 <3ef942fa615dae07822e8ffce75991947f62f933.camel@intel.com>
Message-ID: <Z2INi480K96q2m5S@google.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3kxJiZwYKCoIykgtpimuumrk.iuswks0-jk1krtutmt0.uxm@flex--seanjc.bounces.google.com;
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

On Tue, Dec 17, 2024, Rick P Edgecombe wrote:
> On Mon, 2024-12-16 at 17:53 -0800, Sean Christopherson wrote:
> > Every new feature that lands in hardware needs to either be "benign" or=
 have the
> > appropriate virtualization controls.=C2=A0 KVM already has to deal with=
 cases where
> > features can effectively be used without KVM's knowledge.=C2=A0 E.g. th=
ere are plenty
> > of instruction-level virtualization holes, and SEV-ES doubled down by e=
ssentially
> > forcing KVM to let the guest write XCR0 and XSS directly.
>=20
> We discussed this in the PUCK call.

Argh, I had a response to Xiaoyao all typed up and didn't hit "send" earlie=
r today.

> It turns out there were two different ideas on how this fixed bit API wou=
ld be
> used. One is to help userspace understand which configurations are possib=
le. For
> this one, I'm not sure how helpful this proposal will be in the long run.=
 I'll
> respond on the other branch of the thread.
>=20
> The other usage people were thinking of, which I didn't realize before, w=
as to
> prevent the TDX module from setting fixed bits that might require VMMs su=
pport
> (i.e. save/restoring something that could affect the host). The rest of t=
he mail
> is about this issue.
>=20
> Due to the steps involved in resolving this confusion, and that we didn't=
 really
> reach a conclusion, the discussion is hard to summarize. So instead I'll =
try to
> re-kick it off with an idea which has bits and pieces of what people said=
...
>=20
> I think we can't have the TDX module setting new fixed bits that require =
any VMM
> enabling. When we finally have settled upstream TDX support, the TDX modu=
le
> needs to understand what things KVM relies on so it doesn't break them wi=
th
> updates. But new fixed CPUID bits that require VMM enabling to prevent ho=
st
> issues seems like the kind of thing in general that just shouldn't happen=
.
>=20
> As for new configurable bits that require VMM enabling. Adrian was sugges=
ting
> that the TDX module currently only has two guest CPUID bits that are prob=
lematic
> for KVM today (and the next vcpu enter/exit series has a patch to forbid =
them).
> But a re-check of this assertion is warranted.
>=20
> It seems like an anti-pattern to have KVM maintaining any code to defend =
against
> TDX module changes that could instead be handled with a promise.=20

I disagree, sanity checking hardware and firmware is a good thing.  E.g. se=
e KVM's
VMCS checks, the sanity checks for features SEV depends on, etc.

That said, I'm not terribly concerned about more features that are uncondit=
ionally
exposed to the guest, because that will cause problems for other reasons, i=
.e.
Intel should already be heavily incentivized to not do silly things.

> However, KVM having code to defend against userspace prodding the TDX mod=
ule
> to do something bad to the host seems valid. So fixed bit issues should b=
e
> handled with a promise, but issues related to new configurable bits seems
> open.
>=20
> Some options discussed on the call:
>=20
> 1. If we got a promise to require any new CPUID bits that clobber host st=
ate to
> require an opt-in (attributes bit, etc) then we could get by with a promi=
se for
> that too. The current situation was basically to assume TDX module wouldn=
't open
> up the issue with new CPUID bits (only attributes/xfam).
> 2. If we required any new configurable CPUID bits to save/restore host st=
ate
> automatically then we could also get by, but then KVM's code that does ho=
st
> save/restore would either be redundant or need a TDX branch.
> 3. If we prevent setting any CPUID bits not supported by KVM, we would ne=
ed to
> track these bits in KVM. The data backing GET_SUPPORTED_CPUID is not suff=
icient
> for this purpose since it is actually more like "default values" then a m=
ask of
> supported bits. A patch to try to do this filtering was dropped after ups=
tream
> discussion.[0]

The only CPUID bits that truly matter are those that are associated with ha=
rdware
features the TDX module allows the guest to use directly.  And for those, K=
VM
*must* know if they are fixed0 (inverted polarity only?), fixed1, or config=
urable.
As Adrian asserted, there probably aren't many of them.

For all other CPUID bits, what the TDX Module thinks and/or presents to the=
 guest
is completely irrelevant, at least as far as KVM cares, and to some extent =
as far
as QEMU cares.  This includes the TDX Module's FEATURE_PARAVIRT_CTRL, which=
 frankly
is asinine and should be ignored.  IMO, the TDX Module spec is entirely off=
 the
mark in its assessment of paravirtualization.  Injecting a #VE instead of a=
 #GP
isn't "paravirtualization".
=20
Take TSC_DEADLINE as an example.  "Disabling" the feature from the guest's =
side
simply means that WRMSR #GPs instead of #VEs.  *Nothing* has changed from K=
VM's
perspective.  If the guest makes a TDVMCALL to write IA32_TSC_DEADLINE, KVM=
 has
no idea if the guest has opted in/out of #VE vs #GP.  And IMO, a sane guest=
 will
never take a #VE or #GP if it wants to use TSC_DEADLINE; the kernel should =
instead
make a direct TDVMCALL and save itself a pointless exception.

  Enabling Guest TDs are not allowed to access the IA32_TSC_DEADLINE MSR di=
rectly.
  Virtualization of IA32_TSC_DEADLINE depends on the virtual value of
  CPUID(1).ECX[24] bit (TSC Deadline). The host VMM may configure (as an in=
put to
  TDH.MNG.INIT) virtual CPUID(1).ECX[24] to be a constant 0 or allow it to =
be 1
  if the CPU=E2=80=99s native value is 1.

  If the TDX module supports #VE reduction, as enumerated by TDX_FEATURES0.=
VE_REDUCTION
  (bit 30), and the guest TD has set TD_CTLS.REDUCE_VE to 1, it may control=
 the
  value of virtual CPUID(1).ECX[24] by writing TDCS.FEATURE_PARAVIRT_CTRL.T=
SC_DEADLINE.=20

  =E2=80=A2 If the virtual value of CPUID(1).ECX[24] is 0, IA32_TSC_DEADLIN=
E is virtualized
    as non-existent. WRMSR or RDMSR attempts result in a #GP(0).

  =E2=80=A2 If the virtual value of CPUID(1).ECX[24] is 1, WRMSR or RDMSR a=
ttempts result
    in a #VE(CONFIG_PARAVIRT). This enables the TD=E2=80=99s #VE handler.

Ditto for TME, MKTME.

FEATURE_PARAVIRT_CTRL.MCA is even weirder, but I still don't see any reason=
 for
KVM or QEMU to care if it's fixed or configurable.  There's some crazy logi=
c for
whether or not CR4.MCE can be cleared, but the host can't see guest CR4, an=
d so
once again, the TDX Module's view of MCA is irrelevant when it comes to han=
dling
TDVMCALL for the machine check MSRs.

So I think this again purely comes to back to KVM correctness and safety.  =
More
specifically, the TDX Module needs to report features that are unconditiona=
lly
enabled or disabled and can't be emulated by KVM.  For everything else, I d=
on't
see any reason to care what the TDX module does.

I'm pretty sure that gives us a way forward.  If there only a handful of fe=
atures
that are unconditionally exposed to the guest, then KVM forces those featur=
es in
cpu_caps[*].  I.e. treat them kinda like XSAVES on AMD, where KVM assumes t=
he
guest can use XSAVES if it's supported in hardware and XSAVE is exposed to =
the
guest, because AMD didn't provide an interception knob for XSAVES.

If the list is "too" long (sujbective) for KVM to hardcode, then we revisit=
 and
get the TDX module to provide a list.

This probably doesn't solve Xiaoyao's UX problem in QEMU, but I think it gi=
ves
us a sane approach for KVM.

[*] https://lore.kernel.org/all/20241128013424.4096668-1-seanjc@google.com

> Other idea
> ----------
> Previously we tried to maintain an allow list of KVM supported configurab=
le bits
> [0]. It was do-able, but not ideal. It would be smaller for KVM to protec=
t
> itself with a deny list of bits, or rather a list of bits that needs to b=
e in
> KVM_GET_SUPPORTED_CPUID, or they should not be allowed to be configured. =
But KVM
> can't keep a list of bits that it doesn't know about.
>=20
> But the TDX module does know which bits that it supports result in host s=
tate
> getting clobbered. So we could ask TDX module to expose a list of bits th=
at have
> an effect on host state. We could check those against KVM_GET_SUPPORTED_C=
PUID.
> That check could be expected to fit better than when we tried to massage
> KVM_GET_SUPPORTED_CPUID to be a mask that includes all possible configura=
ble
> bits (multi-bit fields, etc).
>=20
> In the meantime we could keep a list of all of today's host affecting bit=
s. TDX
> module would need to gate any new bits that effect host state behind a ne=
w sys-
> wide opt-in that comes with the "clobber bits" metadata. Before entering =
a TD,
> KVM would check the clobber bits in KVM's copy of CPUID against the TD's =
copy to
> make sure everyone knows what they have to do.
>=20
> (and also this opt-in stuff would need to be run by the TDX module team o=
f
> course)
>=20
> It leaves open the possibility that there is some other bits KVM cares ab=
out
> that don't have to do with clobbering host state. Not sure about it.
>=20
> [0]
> https://lore.kernel.org/kvm/20240812224820.34826-26-rick.p.edgecombe@inte=
l.com/

