Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0742C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NUI-0007Tf-5x; Tue, 07 May 2024 12:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3x1M6ZgYKCpACyu73w08805y.w86Ay6E-xyFy578707E.8B0@flex--seanjc.bounces.google.com>)
 id 1s4NUE-0007OP-6H
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:16:14 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3x1M6ZgYKCpACyu73w08805y.w86Ay6E-xyFy578707E.8B0@flex--seanjc.bounces.google.com>)
 id 1s4NUC-00088T-5K
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:16:13 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc6b26783b4so4331423276.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715098568; x=1715703368; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=IWxS0mCdKrqU6bVOz4n3NTmQy0CRO7Urzkw5a/fWZlQ=;
 b=RO2JYa+Qdqmza82S9vsDCjEZccXPJsCxMqQvCWn7CwVOBOcm1ri8EXijrnVHdM3ok6
 HuSJeHTln+q0FdeevrzGfZ4N7b9EHx7f4hI36i8YB/AkL36p+dWxqOf9iNwjODVNWTaj
 g8ZTG5txob8lqTyWYYW9RDh/JVRCLgdz4oWnNF5rZ7OH/3bDcEZE3pXOy1iuFN67WSfo
 xbalkZ82o06wBqoB2o0h5aWWhHDB8v/Yv8yC+qMQuf2bDw8bdfFQ8fjPGfZ9P70p5ZEI
 qKZp45tSGIHpC+q0xnABCoBz3ph/GAJ0s5237ZJoyTrp/ywRjyVhB4L0cSJj+/Ypbr3N
 BLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715098568; x=1715703368;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IWxS0mCdKrqU6bVOz4n3NTmQy0CRO7Urzkw5a/fWZlQ=;
 b=mwD39ojovbBTlCvPcsrQyCB1ZzzfindM6WCMFSs35Mq0kTXNME9RPPGv2arNqHjTVE
 SNW26Xa5/cmhy1J94KUjLThMYCp/dS/rTDpo4psY+Nt1xQO4wuKImZ4T1jPicLYSVsLa
 Bql9RoQitqKCA/PfLIucD9GjCntIzSAQDTeY71mApZT93J7FCFGDI1m+utpK2aa50yF+
 zra7RYVgVNA9aMI+w4YEdn73ZbCsDPEzZwnSGYsb5JG2LCvtU+1695VTq5ltAj3W/eQg
 yhxyrngLQ5yrtnS2Bl0TwVN6DzHuRi34FNn1KTA01xU/nMmZ4oxxDwQLmLnLJdyLzRhM
 7xSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOF+i5li5onP7yHAIfpUiyrOr1OJLRBse6pThsFocYncqwDyj3YR/kXjTTFrhfThg2gvAiptoIcathti72A9G1nRu4LB0=
X-Gm-Message-State: AOJu0YzNl2qdsoY1EOWd3p3NbsfRdyjGp8VXTR4C7fK/sFoR2Vo+6suh
 DOKA/ucCFycJMEIEkE3WkAGS+LB15+zNXMr4IRCoQSqq+X/e/LWly4/MS3vfuwM0Kw1rrLD2PES
 svw==
X-Google-Smtp-Source: AGHT+IEEPkTwPJaOTGouRKDc7DVHMnqTRjb0yesgQ4YUUdFhPv8WpJzXBwRvcXmUBR39ssSE6I5KsNiqYrA=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:707:b0:dbe:30cd:8fcb with SMTP id
 3f1490d57ef6-debb9c0032emr11950276.0.1715098567940; Tue, 07 May 2024 09:16:07
 -0700 (PDT)
Date: Tue, 7 May 2024 09:16:06 -0700
In-Reply-To: <20240507.ieghomae0UoC@digikod.net>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
Message-ID: <ZjpTxt-Bxia3bRwB@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>,
 Angelina Vu <angelinavu@linux.microsoft.com>, 
 Anna Trikalinou <atrikalinou@microsoft.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, 
 Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>, 
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>, 
 "Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
 "=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>, 
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
 "=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, 
 kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
 virtualization@lists.linux-foundation.org, x86@kernel.org, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3x1M6ZgYKCpACyu73w08805y.w86Ay6E-xyFy578707E.8B0@flex--seanjc.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

On Tue, May 07, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > Actually, potential bad/crazy idea.  Why does the _host_ need to define=
 policy?
> > Linux already knows what assets it wants to (un)protect and when.  What=
's missing
> > is a way for the guest kernel to effectively deprivilege and re-authent=
icate
> > itself as needed.  We've been tossing around the idea of paired VMs+vCP=
Us to
> > support VTLs and SEV's VMPLs, what if we usurped/piggybacked those idea=
s, with a
> > bit of pKVM mixed in?
> >=20
> > Borrowing VTL terminology, where VTL0 is the least privileged, userspac=
e launches
> > the VM at VTL0.  At some point, the guest triggers the deprivileging se=
quence and
> > userspace creates VTL1.  Userpace also provides a way for VTL0 restrict=
 access to
> > its memory, e.g. to effectively make the page tables for the kernel's d=
irect map
> > writable only from VTL1, to make kernel text RO (or XO), etc.  And VTL0=
 could then
> > also completely remove its access to code that changes CR0/CR4.
> >=20
> > It would obviously require a _lot_ more upfront work, e.g. to isolate t=
he kernel
> > text that modifies CR0/CR4 so that it can be removed from VTL0, but tha=
t should
> > be doable with annotations, e.g. tag relevant functions with __magic or=
 whatever,
> > throw them in a dedicated section, and then free/protect the section(s)=
 at the
> > appropriate time.
> >=20
> > KVM would likely need to provide the ability to switch VTLs (or whateve=
r they get
> > called), and host userspace would need to provide a decent amount of th=
e backend
> > mechanisms and "core" policies, e.g. to manage VTL0 memory, teardown (t=
urn off?)
> > VTL1 on kexec(), etc.  But everything else could live in the guest kern=
el itself.
> > E.g. to have CR pinning play nice with kexec(), toss the relevant kexec=
() code into
> > VTL1.  That way VTL1 can verify the kexec() target and tear itself down=
 before
> > jumping into the new kernel.=20
> >=20
> > This is very off the cuff and have-wavy, e.g. I don't have much of an i=
dea what
> > it would take to harden kernel text patching, but keeping the policy in=
 the guest
> > seems like it'd make everything more tractable than trying to define an=
 ABI
> > between Linux and a VMM that is rich and flexible enough to support all=
 the
> > fancy things Linux does (and will do in the future).
>=20
> Yes, we agree that the guest needs to manage its own policy.  That's why
> we implemented Heki for KVM this way, but without VTLs because KVM
> doesn't support them.
>=20
> To sum up, is the VTL approach the only one that would be acceptable for
> KVM? =20

Heh, that's not a question you want to be asking.  You're effectively askin=
g me
to make an authorative, "final" decision on a topic which I am only passing=
ly
familiar with.

But since you asked it... :-)  Probably?

I see a lot of advantages to a VTL/VSM-like approach:

 1. Provides Linux-as-a guest the flexibility it needs to meaningfully adva=
nce
    its security, with the least amount of policy built into the guest/host=
 ABI.

 2. Largely decouples guest policy from the host, i.e. should allow the gue=
st to
    evolve/update it's policy without needing to coordinate changes with th=
e host.

 3. The KVM implementation can be generic enough to be reusable for other f=
eatures.

 4. Other groups are already working on VTL-like support in KVM, e.g. for V=
SM
    itself, and potentially for VMPL/SVSM support.

IMO, #2 is a *huge* selling point.  Not having to coordinate changes across
multiple code bases and/or organizations and/or maintainers is a big win fo=
r
velocity, long term maintenance, and probably the very viability of HEKI.

Providing the guest with the tools to define and implement its own policy m=
eans
end users don't have to way for some third party, e.g. CSPs, to deploy the
accompanying host-side changes, because there are no host-side changes.

And encapsulating everything in the guest drastically reduces the friction =
with
changes in the kernel that interact with hardening, both from a technical a=
nd a
social perspective.  I.e. giving the kernel (near) complete control over it=
s
destiny minimizes the number of moving parts, and will be far, far easier t=
o sell
to maintainers.  I would expect maintainers to react much more favorably to=
 being
handed tools to harden the kernel, as opposed to being presented a set of A=
PIs
that can be used to make the kernel compliant with _someone else's_ vision =
of
what kernel hardening should look like.

E.g. imagine a new feature comes along that requires overriding CR0/CR4 pin=
ning
in a way that doesn't fit into existing policy.  If the VMM is involved in
defining/enforcing the CR pinning policy, then supporting said new feature =
would
require new guest/host ABI and an updated host VMM in order to make the new
feature compatible with HEKI.  Inevitably, even if everything goes smoothly=
 from
an upstreaming perspective, that will result in guests that have to choose =
between
HEKI and new feature X, because there is zero chance that all hosts that ru=
n Linux
as a guest will be updated in advance of new feature X being deployed.

And if/when things don't go smoothly, odds are very good that kernel mainta=
iners
will eventually tire of having to coordinate and negotiate with QEMU and ot=
her
VMMs, and will become resistant to continuing to support/extend HEKI.

> If yes, that would indeed require a *lot* of work for something we're not
> sure will be accepted later on.

Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SVSM s=
upport
is trending toward the paired VM+vCPU model.  IMO, it's entirely feasible t=
o
design KVM support such that much of the development load can be shared bet=
ween
the projects.  And having 2+ use cases for a feature (set) makes it _much_ =
more
likely that the feature(s) will be accepted.

And similar to what Paolo said regarding HEKI not having a complete story, =
I
don't see a clear line of sight for landing host-defined policy enforcement=
, as
there are many open, non-trivial questions that need answers. I.e. upstream=
ing
HEKI in its current form is also far from a done deal, and isn't guaranteed=
 to
be substantially less work when all is said and done.

