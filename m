Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D13606A88F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RbUFAC1D;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DGr79r0f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT0GO-0003bu-7R; Mon, 16 Nov 2026 12:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1xT0GL-0003bV-0s
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1xT0GJ-0007or-1T
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794849177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3sjBxoGOYwuAX1aR0c7CSWHtoyw3M4gkajNUpNVeVbs=;
 b=RbUFAC1DQ+Ga0j9lLxg/QxVbqX8rOli/JLkFdNZahuZ2lYz2iXxesmc00U6TjAZFbndJCr
 ncVTBKeKdTGTyjUwZzTnc0OTMDn33GIYuA2ZQj5S6cClTb5ZoEXDjDGeaa0eyOkVQgxOYs
 L8yVdwKY6qI0fg1mdiTrcbGpcLUGDnw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-KowhD293OI252wFEnShd6g-1; Mon, 16 Nov 2026 12:12:56 -0500
X-MC-Unique: KowhD293OI252wFEnShd6g-1
X-Mimecast-MFC-AGG-ID: KowhD293OI252wFEnShd6g_1794849175
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48df02b91f9so23020f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794849175; x=1795453975; darn=nongnu.org;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3sjBxoGOYwuAX1aR0c7CSWHtoyw3M4gkajNUpNVeVbs=;
 b=DGr79r0f73Q5+WAg2u7o5mSCmiiFOeV8mf6YWeaikC6hbH9DtHuDEPn1OprdyTqs5i
 MukbDa8AH1k3c2touFjiYCY7EsHMwFbBuIjcNC2BqV3Rs//Psn/b5VRuraAIM2A7WKOL
 ct9waeS92+OicaWzNMLiquTRvyHgvHAuS9EiMci594ioFqm8zNKiUCEC7nOnJpYaiSaU
 FTx9Ig9tGV6OJC5Ev4zhauYLSmk1H041N5fVQWs4ZWfRgbWXu4ovWQzDxc9XWwbh6o9a
 RJ6xYkIbdK/BPKpZ6QbzeNXzEAPIWmx7MWYS5IWDbhXmCIkD3Vy6Idy8J9kUmG6RWIj2
 gNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849175; x=1795453975;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3sjBxoGOYwuAX1aR0c7CSWHtoyw3M4gkajNUpNVeVbs=;
 b=m91f7s8bqqItH1Pw4zLAKpSEYsfGdCVXO4mT+BzFj4MW5SO/R3gCj8p7KfiBpy5Ks3
 /A2xe/yxFPcK813eIRskUpkleK07Zh1WUx51VgPd+ZxH0BvrgvLuUA23TUefgHWfioGC
 LsD0/tvFQZloJrmKuUaRn7M4TL2AUsmM4D9lBeceD6P6LmEvJRPWENBxfCLsJhumLSeT
 d0WVvkhYFqP9Izv2ZOtuEjo8zXvcpXtKy3whw0+J8UeigdHlHze+zxut8aPfy7Ct1kt+
 Za55wsNoW7n/Dz1d12duL/vSQ3/3JCUsWHk48NHJ2H7jeDycsvh5KX178WHeEMDyc6Go
 wUtA==
X-Forwarded-Encrypted: i=1;
 AL+hErHZqItx93BP2PEKY1+kOQA+VCOkBGoO1+OrjqTHZYoPoXmhv9WVu70vqK6OMBVGhB+oKJmVwUABeAHL@nongnu.org
X-Gm-Message-State: APuU4Z+Kmp/13r0TKwn8eOqbDeYZXjfcNpuBfsn0Qux6IEZEJA7XexrF
 ry1dvMRgdrXizEKSaoMpf3DnKtUN8rB5+wNz/ccF/HgW8Mb/GTHnlPI8+s/kTRSfIA6dzze2K97
 8TZ/7zcqcDTQ/Z0YzzW4I6hxNpLgC4srnGMa8+bjlGI5iAr5rldEE3jcEHxrHVKVQuVRvxhyRoF
 JYpM/8gc3uOAhXMUtqJjwy9f2K80zYHVlqw1+T2UXFC5+1fA==
X-Gm-Gg: AYBFou1M1aY71yMsEOgrzLO2RzFOtRBTnJIqlULoS8k69sBi3DY6lDr4RbMyDkohboW
 ml1050src/ATgS4aUwEoks7VYhpLxUT0UPM6RaN8MIIgKTgu1EuTWKiKnRG/xljMcez2IASlR6j
 JqpOfL8vim3JDWlyoqLZXt6CI0xvdOEam+wA2QSbpj+wwSjvXsmtP24oaWWrVSIt4u2LhGxrDzK
 BovMaBorEXPxJ+3Cjg9xgjGFx8S6/pQewoFllY99h3hRmrG5Eim36EF/C8aFV7piGZ2XWID/Qtr
 vBK7UFJ9jmNjO44HlZD/9QtFgJWAbjTRrpvGCaaw5aU88HpzBs6UiBV25zOTK19ZmOUge6QehEU
 Ke1L+t2LsaeTLe+cQhgxOITo4IXeOf3CBNMoGjtF/VTQgJDPs7pY/KCXZ5eMAVy7MOzHRoxp2VZ
 jtQ/PXAq3bx7RB0og=
X-Received: by 2002:a05:600c:5493:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb783813a7mr3047485e9.10.1794849174771; 
 Mon, 16 Nov 2026 09:12:54 -0800 (PST)
X-Received: by 2002:a05:600c:5493:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb783813a7mr3046825e9.10.1794849174186; 
 Mon, 16 Nov 2026 09:12:54 -0800 (PST)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz.
 [91.219.240.17]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm67737045e9.3.2026.11.16.09.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:12:52 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: DV <dv@etik.com>
Cc: Alexander Graf <graf@amazon.com>, Sean Christopherson
 <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 hpa@zytor.com, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 nh-open-source@amazon.com, gurugubs@amazon.com, jalliste@amazon.co.uk,
 Michael Kelley <mhklinux@outlook.com>, John Starks
 <jostarks@microsoft.com>, David Woodhouse <dwmw2@infradead.org>, Marcelo
 Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] kvm: hyper-v: Delay firing of expired stimers
In-Reply-To: <1435d106-d4b0-487e-85d3-4032a9fe9332@etik.com>
References: <20260115141520.24176-1-graf@amazon.com>
 <aXO8I6xuZyZB7CxV@google.com>
 <769f538d-dd42-4d36-a4c5-7e6e48b209f6@amazon.com>
 <87bjigaeyx.fsf@redhat.com>
 <1435d106-d4b0-487e-85d3-4032a9fe9332@etik.com>
Date: Mon, 16 Nov 2026 18:12:51 +0100
Message-ID: <kupzev8hf8s.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DV <dv@etik.com> writes:

> Hi Vitaly, Alex, all,
>
> On Mon, 26 Jan 2026, Vitaly Kuznetsov wrote:
>> My bet goes to the clocksource switch, e.g. the guest disables (or
>> just stops using, good luck detecting that :-) ) TSC page and uses
>> raw TSC for some period or something.
>
> I think I've hit a close relative of this, with a reproducer that
> works on every boot. A Windows guest running its own Hyper-V computes
> direct-mode stimer deadlines from the raw TSC, while KVM's reference
> counter lags the TSC because of how QEMU restores kvmclock. Here the
> lag is positive, so the guest's timers fire late instead of storming.
>
> Setup
> -----
>
> Host: Intel Core Ultra 9 285K (invariant TSC, 3686.4 MHz), Linux
> 7.3.0, QEMU 10.2.4 (pc-q35-10.2), libvirt 12.2.0.
>
> Guest: Windows 11 Pro 26H2 (build 26300.9711), 8 vCPUs, with
> virtualization-based security on. So Windows runs as the root
> partition on its own Hyper-V (L1), nested on KVM.
>
>    -cpu host,migratable=off,hv-time=on,hv-relaxed=on,hv-vapic=on,
>         hv-spinlocks=0xfff,hv-vpindex=on,hv-runtime=on,hv-synic=on,
>         hv-stimer=on,hv-stimer-direct=on,hv-frequencies=on,
>         hv-tlbflush=on,hv-tlbflush-direct=on,hv-tlbflush-ext=on,
>         hv-evmcs=on,hv-avic=on,hv-emsr-bitmap=on,hv-xmm-input=on,...
>
> Symptom
> -------
>
> Every timer inside Windows fired 0.3-0.7 s late. A 1 ms wait on a
> high-resolution waitable timer took up to 466 ms, and an indirect
> display driver paced only by a timer refreshed at 6-8 Hz instead of
> 120. Things only moved when some other interrupt woke a vCPU.
>
> What L1 does
> ------------
>
> With both hv-stimer-direct and hv-frequencies, L1 arms stimer0 in
> direct mode (config 0x1ef8: vector 0xef, direct, auto-enable) and
> writes absolute counts. Call X the amount by which the reference
> counter lags guest TSC / HV_X64_MSR_TSC_FREQUENCY. L1's counts are
> X too far out. A timer that should fire right away looks like this:
>
>    kvm_hv_stimer_start_one_shot: vcpu_id 6 timer 0
>        time_now 40095770231 count 40100417164
>
> That count is 464.69 ms ahead of time_now, and X on that boot was
> 464.7 ms. L1 writes the count again on every L2 timer exit, so such a
> timer keeps moving to now + X and only fires once the vCPU is quiet
> for that long.
>
> Without hv-stimer-direct, without hv-frequencies, or without
> hv-stimer, L1 uses the local APIC timer instead (TMICT/TDCR writes,
> a relative countdown), and all timers are on time. I've turned direct
> mode off as a workaround: a 1 ms wait is now late by at most 1.24 ms.
>
> Why the reference counter lags
> ------------------------------
>
> get_time_ref_counter() follows kvmclock on both paths. The fallback
> divides get_kvmclock_ns() by 100, and compute_tsc_page_parameters()
> takes the TSC page's tsc_offset from the pvclock system_time.
>
> QEMU's kvmclock_realize() calls KVM_GET_CLOCK when the VM is created.
> kvmclock_vm_state_change() writes the saved value back with
> KVM_SET_CLOCK when the VM starts running, and saves a new value
> whenever it stops. So kvmclock, and with it the reference counter,
> stands still from creation to first run and during every pause. The
> guest TSC keeps counting through both. On six boots X was 297, 465,
> 570, 495, 669 and 512 ms.
>
> Two measurements tie X to this:
>
> - In a trace from QEMU startup, extrapolated back to zero, the guest
>    TSC started at host monotonic 265208.1505 s and the reference
>    counter at 265208.8205 s, 0.670 s later. X on that boot was
>    669.2 ms.
>
> - virsh suspend for 1.045 s, then resume: X grew from 669.2 to
>    1689.3 ms (+1020.1 ms), and L1's far stimer deadline moved out by
>    the same amount.
>
> hv-evmcs off (X = 570.1 ms) and hv-reenlightenment on (X = 494.7 ms)
> didn't change the behaviour. Host load and power management were
> ruled out too.
>
> Connection to your thread
> -------------------------
>
> If the reference counter were ahead of TSC time instead, L1's
> deadlines would land in the past. stimer_start() expires a one-shot
> whose count is in the past at once, L1 arms it again on its next
> exit, and that would look like the expired-stimer storm Alex's patch
> delays.
>
> I haven't been able to try that here, because libvirt is set up to
> start a fresh QEMU whenever the guest reboots. But a reset inside the
> same QEMU process sets the guest TSC back to 0 while kvmclock keeps
> counting, so I'd expect it to flip the sign, possibly by the whole
> previous uptime. A resume path that restores the two clocks
> differently could do the same.
>
> Questions
> ---------
>
> 1. Should KVM keep the Hyper-V reference counter equal to guest TSC /
>     TSC frequency when hv-frequencies is exposed? L1 seems to assume
>     it is.
>
> 2. If so, where does the fix belong: in QEMU's kvmclock save/restore,
>     or in KVM deriving the reference counter (and TSC page) from the
>     guest TSC?
>
> 3. If not, should hv-stimer-direct be documented as unsafe for guests
>     that run their own Hyper-V?
>

From what I remember, direct mode synthetic timers were added
specifically to aid Hyper-V-on-KVM case as non-nested Windows was
preferring non-direct version anyway. So I believe we need a fix and not
3).

I'm wondering if the issue is somewhat related to the nasty hack we put
in 

commit 0469f2f7ab4c6a6cae4b74c4f981c4da6d909411
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Tue Mar 16 15:37:36 2021 +0100

    KVM: x86: hyper-v: Don't touch TSC page values when guest opted for re-enlightenment

but maybe hibernation is somewhat different. Or maybe we misunderstood
the problem in the first place and only fixed one sympthom of it?

> I can share the full traces and the Windows-side timer and frame
> probes if they'd help.
>
> Claude Code, an AI coding assistant, did the tracing and analysis
> while I was looking into why the VM's virtual display ran at a few
> frames per second.
>
> Thanks,
> David
>

-- 
Vitaly


