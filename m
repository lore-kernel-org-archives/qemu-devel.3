Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EF2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tVg-0007W0-BH; Fri, 03 May 2024 10:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3q-40ZgYKCpQG2yB704CC492.0CAE2AI-12J29BCB4BI.CF4@flex--seanjc.bounces.google.com>)
 id 1s2tVY-0007VF-4f
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:03:28 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3q-40ZgYKCpQG2yB704CC492.0CAE2AI-12J29BCB4BI.CF4@flex--seanjc.bounces.google.com>)
 id 1s2tVW-0002oe-3K
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:03:27 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc6b26783b4so13077165276.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714745003; x=1715349803; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=a136SOKV90n/XcmvCvD6zgQKrJ5kR/Q+OhiUt3FbOiE=;
 b=GlBV8Z+2OQCVm1mDNz26czpzHhe31JaENN+erpNL2a5rh1poQMWvkMUbjnuWB4zXcw
 bkkvn8dcVP3F1xStfvCvHi6rAnMRlOQyaRISZx6oVySfjqLfRLgv47SR34rE/Me4CiUV
 iN+W1Jk8TppM0ycbSzuRa2Re1TTbfckGKa5Lnu4r3kZM4XlDgHCZ569Od1LFaSpuIvFE
 i16QXtNSXJlakGGB4nr18TL3GzSlaITZk7qduJQHFMRDCAi8DaKX31pmRIQ6aVl7t6N8
 Ifc7UZQsej1Qo38kschTaxS1pHpd4CdWGEgJ5vtvg/tZYWf89oDKKOA/oa10V/EeXeZh
 G1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714745003; x=1715349803;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=a136SOKV90n/XcmvCvD6zgQKrJ5kR/Q+OhiUt3FbOiE=;
 b=sX0HLCZh0cOX5WFy4ZBwqEC7NNrOFiyRZ5gWvPrBHYJ+7oIyq+G5JWTZuBlO4VpnbW
 QFEqmyI/ibhCRcioOvoG6qIl0AOcbFqDPotikr5TPrCzRIoYp9Un398A1n+FmOAoLJFi
 Odu9NphHabLbhf3ezjceiWId7crgkMeigWdcwI40TG7xaYjiZpdhDLuZeiK3wnQnhjJT
 Xm+9aGoj3m2xHbyJpOvEZVELtIk4TDF0u2Eeg5MnZnFItIjR1mOVPxvwPzfCJ6yEQJjS
 xCE+f5Y6mddA/9gLhLPwB7VXo3BMEN2T1cYE7AmSoV6eRhlOsAbtWDY8UiXJpUYtKKqm
 6JZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYqNKe1KzDz4o1e5kFeP9YGKsGcSvSO5zEiwniG9whhsLAkp/zC6rcf1J7PbfOje/XLW/KO3jUrW2wTjzruSDMcgIOdtU=
X-Gm-Message-State: AOJu0YxZ6a47D2ZyvwYhycmNBn5F/HVaGCKc0IDgSVTMRHawbncIkbnf
 aDN+ELMigl3AO7TV++VgmqeU0rxfjrnjBtuQ/X5ofl9lhoC8AVZMwiM2WPLwt2T6I/jXj3dqs8l
 drQ==
X-Google-Smtp-Source: AGHT+IG8Se+FDx3icVQiBS8y3Ql+XygTIGhFwTldpFeLgMxDQJNLd2QsRcCHI+DmhaCm9MeTHgIbmJIbKcw=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1201:b0:de6:141a:b0de with SMTP id
 s1-20020a056902120100b00de6141ab0demr337561ybu.10.1714745003300; Fri, 03 May
 2024 07:03:23 -0700 (PDT)
Date: Fri, 3 May 2024 07:03:21 -0700
In-Reply-To: <20240503131910.307630-4-mic@digikod.net>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
Message-ID: <ZjTuqV-AxQQRWwUW@google.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3q-40ZgYKCpQG2yB704CC492.0CAE2AI-12J29BCB4BI.CF4@flex--seanjc.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

On Fri, May 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> Add an interface for user space to be notified about guests' Heki policy
> and related violations.
>=20
> Extend the KVM_ENABLE_CAP IOCTL with KVM_CAP_HEKI_CONFIGURE and
> KVM_CAP_HEKI_DENIAL. Each one takes a bitmask as first argument that can
> contains KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4. The
> returned value is the bitmask of known Heki exit reasons, for now:
> KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4.
>=20
> If KVM_CAP_HEKI_CONFIGURE is set, a VM exit will be triggered for each
> KVM_HC_LOCK_CR_UPDATE hypercalls according to the requested control
> register. This enables to enlighten the VMM with the guest
> auto-restrictions.
>=20
> If KVM_CAP_HEKI_DENIAL is set, a VM exit will be triggered for each
> pinned CR violation. This enables the VMM to react to a policy
> violation.
>=20
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240503131910.307630-4-mic@digikod.net
> ---
>=20
> Changes since v1:
> * New patch. Making user space aware of Heki properties was requested by
>   Sean Christopherson.

No, I suggested having userspace _control_ the pinning[*], not merely be no=
tified
of pinning.

 : IMO, manipulation of protections, both for memory (this patch) and CPU s=
tate
 : (control registers in the next patch) should come from userspace.  I hav=
e no
 : objection to KVM providing plumbing if necessary, but I think userspace =
needs to
 : to have full control over the actual state.
 :=20
 : One of the things that caused Intel's control register pinning series to=
 stall
 : out was how to handle edge cases like kexec() and reboot.  Deferring to =
userspace
 : means the kernel doesn't need to define policy, e.g. when to unprotect m=
emory,
 : and avoids questions like "should userspace be able to overwrite pinned =
control
 : registers".
 :=20
 : And like the confidential VM use case, keeping userspace in the loop is =
a big
 : beneifit, e.g. the guest can't circumvent protections by coercing usersp=
ace into
 : writing to protected memory.

I stand by that suggestion, because I don't see a sane way to handle things=
 like
kexec() and reboot without having a _much_ more sophisticated policy than w=
ould
ever be acceptable in KVM.

I think that can be done without KVM having any awareness of CR pinning wha=
tsoever.
E.g. userspace just needs to ability to intercept CR writes and inject #GPs=
.  Off
the cuff, I suspect the uAPI could look very similar to MSR filtering.  E.g=
. I bet
userspace could enforce MSR pinning without any new KVM uAPI at all.

[*] https://lore.kernel.org/all/ZFUyhPuhtMbYdJ76@google.com

