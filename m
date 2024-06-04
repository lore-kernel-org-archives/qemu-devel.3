Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C66C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEI3o-00016y-Sl; Mon, 03 Jun 2024 20:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_l9eZgYKCnEhTPcYRVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--seanjc.bounces.google.com>)
 id 1sEI3n-00016N-3W
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:29:55 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_l9eZgYKCnEhTPcYRVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--seanjc.bounces.google.com>)
 id 1sEI3l-0003IQ-Ew
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:29:54 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-1f4f00cff60so25901785ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 17:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717460991; x=1718065791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=QxIMQXFvRFWSOBKMLO/Pb11VLx9FgWxOAKpcjqg1q6M=;
 b=3IGHVtNW5BaApW/bHq64DKv3YYXtiJPoMtZ9f1yEtH3XKBz52j6Y0ROPxQG0Z4mVIh
 TVyfVN9sQFf5nkkMb0pruRvZrMozWOb15Mgg4tludRr8UkQcVK+Lj70VMR6cGLchap+z
 xX/Fp6jliU/5VKH4QXgi1v19CO0TYhkHBTOd1QDtYhyEQVDNHYEcJLgOcynYPCPXv/D0
 qpB3sN1UZyARF3cjietP+Z4v0KgQvBteP9CIvyJpOsBDOYMsL0bmy8e+beW6Ji3e4QB+
 sYHjwR234EWZuEBcerXLsLcT8+ct3xkPQbDnZmIqWFAq+rOratjSHM9gLZjuftMl+Yqc
 Mtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717460991; x=1718065791;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QxIMQXFvRFWSOBKMLO/Pb11VLx9FgWxOAKpcjqg1q6M=;
 b=kNz3SWrTwW9Xt6xwwJrjj1DpQnfWIV6ZmxAUT2iYr3NaaxxcDCGTSK+PeQZfhoX8C7
 RX0z5h24VUY2KhBsicc7OTA9eZRQOltNUUDbhNE4BB+g3Z4nitzLmIsAQlNwGCGKDmmY
 awsXAgKC7j1HNlKsyaMhsFA6maPU3H4USHdlMszJz0dQJYa9tL//boFu8vqwSF7QNZz0
 JX/XoCWbFiMwaEGd0BY39aQo2LCQcYq+oUj47FsAv7i1WBg1/TDKxjJvnWnoFwcRBLvp
 KLUr4ctz5M+iWvIhXuIpre2Bh+7BkRFszcMqdIOjBJ5FVgMv6wuM0Q+uw8ZoLyLW1VEl
 LKFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAgcJ/Q/Z7TKq/NXbsE8NE0n+6f8F6TN1LSrB4/Cjn7e8MF3B715h72GDis+sS9ooRBzes3z39o7qSRBjrjgivQu8VkrY=
X-Gm-Message-State: AOJu0YyCS+kaI4tJkAFZmvp9+rFNPbKKuyihZr0ofqD5Dw6Sq/aOhXME
 xyGlpmCYG/96HpIeYI9s8CY8TUdfqOgwHhI083dSL6m0rutBKiHx8Etjj4rxR++oXbI1YU5U52T
 hPA==
X-Google-Smtp-Source: AGHT+IENLGEaWbs37HwWar6l9tfsoGWg6m42nFsyoTQfIezFlKVeE9IraziAYhpEU9jmdwNYoPJqg3Pzh8c=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f7c1:b0:1f4:620b:6a47 with SMTP id
 d9443c01a7336-1f6370524bemr2945395ad.4.1717460990723; Mon, 03 Jun 2024
 17:29:50 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:29:49 -0700
In-Reply-To: <20240514.OoPohLaejai6@digikod.net>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com> <20240514.OoPohLaejai6@digikod.net>
Message-ID: <Zl5f_T7Nb-Fk8Y1o@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
 Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3_l9eZgYKCnEhTPcYRVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--seanjc.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, May 07, 2024 at 09:16:06AM -0700, Sean Christopherson wrote:
> > On Tue, May 07, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > > If yes, that would indeed require a *lot* of work for something we're=
 not
> > > sure will be accepted later on.
> >=20
> > Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SV=
SM support
> > is trending toward the paired VM+vCPU model.  IMO, it's entirely feasib=
le to
> > design KVM support such that much of the development load can be shared=
 between
> > the projects.  And having 2+ use cases for a feature (set) makes it _mu=
ch_ more
> > likely that the feature(s) will be accepted.
> >=20
> > And similar to what Paolo said regarding HEKI not having a complete sto=
ry, I
> > don't see a clear line of sight for landing host-defined policy enforce=
ment, as
> > there are many open, non-trivial questions that need answers. I.e. upst=
reaming
> > HEKI in its current form is also far from a done deal, and isn't guaran=
teed to
> > be substantially less work when all is said and done.
>=20
> I'm not sure to understand why "Heki not having a complete story".  The
> goal is the same as the current kernel self-protection mechanisms.

HEKI doesn't have a complete story for how it's going to play nice with kex=
ec(),
emulated RESET, etc.  The kernel's existing self-protection mechanisms Just=
 Work
because the protections are automatically disabled/lost on such transitions=
.
They are obviously significant drawbacks to that behavior, but they are acc=
epted
drawbacks, i.e. solving those problems isn't in scope (yet) for the kernel.=
  And
the "failure" mode is also loss of hardening, not an unusable guest.

In other words, the kernel's hardening is firmly best effort at this time,
whereas HEKI likely needs to be much more than "best effort" in order to ju=
stify
the extra complexity.  And that means having answers to the various interop=
erability
questions.

