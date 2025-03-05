Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE78C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdTw-0000re-4Y; Tue, 04 Mar 2025 20:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UqfHZwYKCgUxjfsohlttlqj.htrvjrz-ij0jqstslsz.twl@flex--seanjc.bounces.google.com>)
 id 1tpdSy-00089K-0i
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:35 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UqfHZwYKCgUxjfsohlttlqj.htrvjrz-ij0jqstslsz.twl@flex--seanjc.bounces.google.com>)
 id 1tpdSw-0006wk-5C
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:31 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2feb47c6757so10280701a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741137747; x=1741742547; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=DCS/nNw6mNxVSNW6ZyvtCA2C5M73+qL9HLBJBSb59yY=;
 b=AhHtMCq9ietAAoCfODIvGTShfYVsqHUHr8yHJrQBmTt8f2gk9eYjwLuqNF+O8OVpiS
 WwKeD5Bmqn0AnG1pH9fTQ3OJT1dgKCLeUryCXDp+d5r/NfZQ9KSvJ3W9ExO7LQey9+rw
 mm7HYdWecCebFpenzyAG4WZJxcNML0l53ci5X+WPUXRN4vFXFx3aPpZ8TP5RzJWlFbM9
 rLiDURKTdq2L9KWeiIhxECCJRXxs5XeagKY9eXYqT2n0vImcpXqCZYPIj6bkCPlRw7i7
 +fEni/GvIx75jiDqwQT8yJLQapI6prb2rXETl7cCs2hCl7fYMNoFx6aLLGVq1kIVVxMn
 p4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137747; x=1741742547;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DCS/nNw6mNxVSNW6ZyvtCA2C5M73+qL9HLBJBSb59yY=;
 b=CJGpLgBoOgZFA5I8wlb4l0b4JhpzPQwAbUmw/aZBV+ZNYoESDI8JEt+J51MHRfNrf7
 QHKsEVU7FLAkxbShClkZNn/x/8i4lBc2l7lqEEEmG039ghMpCiba2gczs5elPOYskCSX
 ZLa5IZPkB43Enjn/yg2sv+VsCeg/LdEqJWTqpYxagUlvrGUYFqWnCKSS6UiY291NmXCO
 16tDffkKh6rEb8miaelAG19ayTGV+y+O3g+yVTvUSlA42ELboTbYzbkG3ZwoDX/PdGlW
 JIknx/E7uHfeJmSFR4aAW4lMJrGeQmJ/u3YwXmDJPy+K6PRNdeGqvfs+ymnjvu+SYa87
 3WUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoLORJVssz+i6rhPU6JYAJecSU5tserS4dPWxqc5kHnhAFfx0/vp2E7qH6B2vDVzH+aF30jlxpMIZS@nongnu.org
X-Gm-Message-State: AOJu0YwwxvO11Qm4n4qsHLHawpSm+x2SDUxS5cSIgH2joUejS+gildjx
 GBrHHP5yvGnxo23L9jF+cIXXiFHg9O9hSweLcPyiORKnGTFfvW80TBqMnATD0Ms8oaLI6f6CMpw
 LgA==
X-Google-Smtp-Source: AGHT+IGJYp2ZLl5wcmz8t5mtTOoaetyDIG/yhDzE4zTGYRR+kewQEAAmX8rVAMwffKV4YIgqaMx4Mf/Jkw0=
X-Received: from pjf14.prod.google.com ([2002:a17:90b:3f0e:b0:2fc:2ee0:d38a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2413:b0:2ff:4bac:6fa2
 with SMTP id 98e67ed59e1d1-2ff4bac7163mr971273a91.16.1741137746768; Tue, 04
 Mar 2025 17:22:26 -0800 (PST)
Date: Tue, 4 Mar 2025 17:22:25 -0800
In-Reply-To: <76da2b4a-2dc4-417c-91bc-ad29e08c8ba0@intel.com>
Mime-Version: 1.0
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-5-dongli.zhang@oracle.com>
 <76da2b4a-2dc4-417c-91bc-ad29e08c8ba0@intel.com>
Message-ID: <Z8enUUXhfRTr7KCf@google.com>
Subject: Re: [PATCH v2 04/10] target/i386/kvm: set KVM_PMU_CAP_DISABLE if
 "-pmu" is configured
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, 
 pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com, 
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com, 
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org, 
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com, 
 davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3UqfHZwYKCgUxjfsohlttlqj.htrvjrz-ij0jqstslsz.twl@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

On Tue, Mar 04, 2025, Xiaoyao Li wrote:
> On 3/3/2025 6:00 AM, Dongli Zhang wrote:
> > Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
> > there is no way to fully disable KVM AMD PMU virtualization. Neither
> > "-cpu host,-pmu" nor "-cpu EPYC" achieves this.
> 
> This looks like a KVM bug.

Heh, the patches you sent do fix _a_ KVM bug, but this is something else entirely.

In practice, the KVM bug only affects what KVM_GET_SUPPORTED_CPUID returns when
enable_pmu=false, and in that case, it's only a reporting issue, i.e. KVM will
still block usage of the PMU.

As Dongli pointed out, older AMD CPUs don't actually enumerate a PMU in CPUID,
and so the kernel assumes that not-too-old CPUs have a PMU:

	/* Performance-monitoring supported from K7 and later: */
	if (boot_cpu_data.x86 < 6)
		return -ENODEV;

The "expected" output:

   Performance Events: PMU not available due to virtualization, using software events only.

is a long-standing workaround in the kernel to deal with lack of enumeration.  On
top of explicit enumeration, init_hw_perf_events() => check_hw_exists() probes
hardware to see if it actually works.  If an MSR is unexpectedly unavailable, as
is the case when running as a guest, the kernel prints a message and disables PMU
usage.  E.g. the above message is specific to running as a guest:

	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
		pr_cont("PMU not available due to virtualization, using software events only.\n");

From the KVM side, because there's no CPUID enumeration, there's no way for KVM
to know that userspace wants to completely disable PMU virtualization from CPUID
alone.  Whereas with Intel CPUs, KVM infers that the PMU should be disabled by
lack of a non-zero PMU version, e.g. if CPUID.0xA is omitted.

> Anyway, since QEMU can achieve its goal with KVM_PMU_CAP_DISABLE with
> current KVM, I'm fine with it.

Yeah, this is the only way other than disabling KVM's PMU virtualization via
module param (enable_pmu).

