Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90162C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhCA-0001Eq-07; Mon, 09 Jun 2025 14:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MidHaAYKCuUZLHUQJNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--seanjc.bounces.google.com>)
 id 1uOhC6-0001Eh-QV
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:26:02 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MidHaAYKCuUZLHUQJNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--seanjc.bounces.google.com>)
 id 1uOhC1-0003s9-Ll
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:26:02 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-310e7c24158so4501242a91.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749493554; x=1750098354; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=z9qcsdHcsSJ5C6VTefgwjQ8viEabDJHufEh6SESIfaQ=;
 b=3Vv8keIPyPtjgut8s3JqGpzyjpgVjWRfZtsZodBopE2epkj7bJnOSM0nGWXOUg5NaZ
 u4t7A1wqvkL/ieFYYexdydQUV4FzZgHRAlL9y/MJ+EHfjAAW7zOY+WOQBL/KxJdgEGK4
 i6G4p9PFh71YuTguYY0G24k7sPVLmjGyx+sg0VK+QkmdAT0xg9OSu3HkTuJWiMO9Xpak
 v6bvdgZdbZ+58KHAF1kNMJMr6R9jysmMMWXWKBRj2zd7B8Sk9Yi3yk3ZrdtzbiU/C9jd
 wcsLQG4eVU4ON9RRoDzUdCdqcQrKyn2y6Ew8YaeQAuONn4RiQGE1rClQTqEfKsu566Zj
 cwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749493554; x=1750098354;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9qcsdHcsSJ5C6VTefgwjQ8viEabDJHufEh6SESIfaQ=;
 b=PNYaKX09xUBT0aG/WfBrmv7yI/LEhUTXfjNGoD6VRLE4QRqZHvOBS2mPSq/0IMaegk
 +XOnT/2lGsiuMw2uGktiw5mjqcmuxA6tvCzkefZBEzSRBskKb4IC4DIXgWe/U10tbSJ0
 jD9XB+aRZIYan7xcVDYAAFubIh2TTRKTSOY0XbyVH3smkigwuZmZxoYxOoPWOK0xygac
 O28v/rmK2Xy6v1V570+Wia1NxkgyHxExO2wGG62ETm9s9wYhEoPHXRosdNRTokFmZ9oQ
 t/5rwpN8A/tp+XudMBIviu8zdy3d0dKIZCWB5iDr95fNkI7FGJNq9Hp1lW9cUwpn/MHS
 eIzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Dshqat4cQkAQz8Hk6+7A7CRA/C06NF16bydVfv0xfwOQI96RGnsSg3eWTNYLNIV8ZQTmXXwbdi/a@nongnu.org
X-Gm-Message-State: AOJu0Yx0JYHrSDF8NP7KbUg5/XlQUb8AOOzv/mHLMejOegaOMuImxg0y
 uDAnAnr/d2YICwVST1JYHbQr5jUDOKsrGaBSf+JqJVZogUuU88WT73eIn/iu486TTC52NCTnI1V
 iCNVTcQ==
X-Google-Smtp-Source: AGHT+IHwUDbgPx1C4OZ9+5MSRmLvBlj6RD8esNnLDwkHpfWEmmt9w7lnjOzBIl0+4tvkc8ZFnU35qEABdKU=
X-Received: from pjbqn15.prod.google.com ([2002:a17:90b:3d4f:b0:311:ff0f:6962])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2252:b0:312:25dd:1c86
 with SMTP id 98e67ed59e1d1-3134730af09mr22498660a91.18.1749493554444; Mon, 09
 Jun 2025 11:25:54 -0700 (PDT)
Date: Mon, 9 Jun 2025 11:25:52 -0700
In-Reply-To: <203f24da-fce0-4646-abed-c6ca657828d1@virtuozzo.com>
Mime-Version: 1.0
References: <20250609132347.3254285-2-andrey.zhadchenko@virtuozzo.com>
 <7ce603ad-33c7-4dcd-9c63-1f724db9978e@redhat.com>
 <4f19c78f-a843-49c9-8d19-f1dc1e2c4468@virtuozzo.com>
 <aEcOSd-KBjOW61Rt@google.com>
 <203f24da-fce0-4646-abed-c6ca657828d1@virtuozzo.com>
Message-ID: <aEcnMFzh-X7Aofbl@google.com>
Subject: Re: [PATCH] target/i386: KVM: add hack for Windows vCPU hotplug with
 SGX
From: Sean Christopherson <seanjc@google.com>
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhao1.liu@intel.com,
 mtosatti@redhat.com, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, andrey.drobyshev@virtuozzo.com, 
 "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3MidHaAYKCuUZLHUQJNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jun 09, 2025, Andrey Zhadchenko wrote:
> On 6/9/25 18:39, Sean Christopherson wrote:
> > On Mon, Jun 09, 2025, Denis V. Lunev wrote:
> > > > Does anything in edk2 run during the hotplug process (on real hardware
> > > > it does, because the whole hotplug is managed via SMM)? If so maybe that
> > > > could be a better place to write the value.
> > 
> > Yeah, I would expect firmware to write and lock IA32_FEATURE_CONTROL.
> > 
> > > > So many questions, but I'd really prefer to avoid this hack if the only
> > > > reason for it is SGX...
> > 
> > Does your setup actually support SGX?  I.e. expose EPC sections to the guest?
> > If not, can't you simply disable SGX in CPUID?
> 
> We do not have any TYPE_MEMORY_BACKEND_EPC objects in our default config,
> but have the following:
> sgx=on,sgx1=on,sgx-debug=on,sgx-mode64=on,sgx-provisionkey=on,sgx-tokenkey=on
> We found this during testing, and it can be disabled on our testing setup
> without any worries indeed.
> I have no data whether someone actually sets it properly in the wild, which
> may still be possible.

The reason I ask is because on bare metal, I'm pretty sure SGX is incompatible
with true CPU hotplug.  It can work for the virtualization case, but I wouldn't
be all that surprised if the answer here is "don't do that".

> > > Linux by itself handles this well and assigns MSRs properly (we observe
> > > corresponding set_msr on the hotplugged CPU).
> 
> I think Linux, at least old 4.4, does not write msr on hotplug.

Yeah, it's a newer thing.  5.6+ should initialize IA32_FEATURE_CONTROL if it's
left unlocked (commit 1db2a6e1e29f ("x86/intel: Initialize IA32_FEAT_CTL MSR at boot").

> Anyway it hotplugs fine and tolerates different value unlike Windows

Heh, probably only because the VM isn't actively using KVM at the time of hotplug.
In pre-5.6 kernels, i.e. without the aforementioned handling, KVM (in the guest)
would refuse to load (though the hotplug would still work).  But if the guest is
actively running (nested) VMs at the time of hotplug, the hotplugged vCPUs would
hit a #GP when attempting to do VMXON, and would likely crash the kernel.

> > Linux is much more tolerant of oddities, and quite a bit of effort went into
> > making sure that IA32_FEATURE_CONTROL was initialized if firmware left it unlocked.
> 
> Thanks everyone for the ideas. I focused on Windows too much and did not
> investigate into firmware, so perhaps this is rather a firmware problem?
> I think by default we are using seaBIOS, not ovmf/edk2. I will update after
> some testing with different configurations.

Generally speaking, firmware is expected to set and lock IA32_FEATURE_CONTROL.
But of course firmware doesn't always behave as expected, hence the hardening that
was added by commit 1db2a6e1e29f to avoid blowing up when running on weird/buggy
firmware.


