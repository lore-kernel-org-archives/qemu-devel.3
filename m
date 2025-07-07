Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88251C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 20:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYs78-0004wc-8l; Mon, 07 Jul 2025 16:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36iVsaAYKCjEfRNaWPTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--seanjc.bounces.google.com>)
 id 1uYrv2-0000He-RV
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:54:29 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36iVsaAYKCjEfRNaWPTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--seanjc.bounces.google.com>)
 id 1uYruv-0008QV-DA
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:54:27 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-74928291bc3so2626869b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751918058; x=1752522858; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dvkjx2/EXKNVPNHMXsjFWWDExhVd8STolUBKVwumVSQ=;
 b=UFt8AGpYjhx5Rppn5Sy+adjVBL3bw3W1iybIYU4XqJRKbyaFrlGP9HyDn0OBA4EdOk
 JdMHMTj7QbkcdqBBtoXD8oBCq1XUun5C1oH/EFUWg+l1kqg5eZQ40EnYb+mxPqdP8hqf
 w72ZEOoj9/cbdJctVH10xZLV+JVaMwspyUuHxWlpsLQgzWJW+nBqNmgdnZATZK5IZJz1
 LLA6MXmXHYpL7B+HL6hV2MJXTL+24/FbvqPpOP+oWI5ymdhWn5KohgHVeBaFrS0jOt0U
 M7vOTuFpKn+l3tiHNyz4KqAg4qmkrTafdVqR6WI1y+4j0PTQeSJrswtlaMCvBtIQppIV
 207A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918058; x=1752522858;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dvkjx2/EXKNVPNHMXsjFWWDExhVd8STolUBKVwumVSQ=;
 b=gTXKDFNTMG2E/kxa9rRRQjJsj8LFZzD6QVDVV2zEJeF0atdqvnxRNOZluO6NcCN4Rr
 pr8aBs/BZculqS592IhNpPBwBFFBcXNVWNSgN5Sbc2thR3ghwhtZTHUQquB643mu6lIB
 HETh5RNYqwEkYngQTX+V4PTzgkZIWYseaXnkpmhnsUkPLzsJbjmx3wNHrN2RE6XYtPD6
 hMig+myCLmjyZy0lGTklWvY3/SLeshDyQ9YNHlAH9plDVUHRB0am4i2x2D98LBUrkjkD
 7KpRxnPnraZWEQAuZmuHFDzWh7wnThQhcDzUO9S23OL7PIK8BnQ3gMJ9RS8yW8c40rbu
 TntQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXv+HntbyooggFzXGpFLFjEdE2bvig/4YOqGsiq9yXao+7C6NX4n6lWrxtlYLYDkZuFd7jKuLgSyUb@nongnu.org
X-Gm-Message-State: AOJu0Yy+QgElQtDrxG69go6LQANmKNk68D05hvwG37KYwM4UZ0YEzegH
 QYc9wv5MMXKb8CWUB5L9GONcjwqbCnHINfCZoJR0nqniga/ReZtxYyodwEjFJRCCCNH61pkstLG
 QL1VLUA==
X-Google-Smtp-Source: AGHT+IE/n24T+yY82t7dVRDwU/3hR1H7fbmnSobXXAgaDbo+nhrjc/FK4GpjJIoi0wiHsG3fN7p26DN5fIY=
X-Received: from pfbfc40.prod.google.com
 ([2002:a05:6a00:2e28:b0:746:fd4c:1fcf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4483:b0:748:fd94:e62a
 with SMTP id d2e1a72fcca58-74d242e8ad6mr793708b3a.1.1751918058346; Mon, 07
 Jul 2025 12:54:18 -0700 (PDT)
Date: Mon, 7 Jul 2025 12:54:16 -0700
In-Reply-To: <20250702132307.71e3b783@fedora>
Mime-Version: 1.0
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com> <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com> <20250701150500.3a4001e9@fedora>
 <aGQ-ke-pZhzLnr8t@char.us.oracle.com> <20250702132307.71e3b783@fedora>
Message-ID: <aGwl6GUwYsGVXG5k@google.com>
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
From: Sean Christopherson <seanjc@google.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org, 
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=36iVsaAYKCjEfRNaWPTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--seanjc.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

On Wed, Jul 02, 2025, Igor Mammedov wrote:
> Or even better a single KVM optin feature 'do_not_advertise_features_not_supported_by_host_cpu',
> and then QEMU could use that for disabling all nonsense in one go.
> Plus all of that won't be breaking KVM ABI nor qemu had to add fixups for this and that feature.
> 
> After some time when old machine types are deprecated/gone, KVM could make it default and eventually
> remove advertising 'fake' features.

Such a feature/quirk wouldn't be useful in practice.  There are several features
that KVM emulates irrespective of hardware support, and that generally speaking
every VMM will want to enable whenever possible, e.g. x2APIC, TSC deadline timer,
TSC adjust, and the amusing "no SMM_CTL MSR" anti-feature.  Throwing out x2APIC
and TSC deadline timer in particular would be a significant regression, i.e. not
something any end user actually wants.

If QEMU or any other VMM wants to filter KVM's support against bare metal, then
QEMU can simply do CPUID itself.

Somewhat of a side topic, the somewhat confusingly-named KVM_GET_EMULATED_CPUID
exists to allow KVM to differentiate between features that KVM can emulate and/or
virtualize without additional overhead, and those that KVM can emulate but with
non-trivial cost.  E.g. KVM advertises MOVBE and RDPID in KVM_GET_SUPPORTED_CPUID
if and only if they are natively suppored, because enabling those instructions in
the guest's CPUID model turns exitless instruction execution into expensive #UD
VM-Exits and slow emulation.  But KVM unconditionally advertises support for them
in KVM_GET_EMULATED_CPUID so that userspace can run a "newer" VM on old hardware.

I mention KVM_GET_EMULATED_CPUID purely to stave off any exploration into trying
to move ARCH_CAPABILITIES to KVM_GET_EMULATED_CPUID.  Name aside, it's not the
correct fit (and would still be an ABI change).

