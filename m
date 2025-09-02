Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CFFCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utR13-0001jM-E5; Tue, 02 Sep 2025 09:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utR0e-0001cV-OX
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:25:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utR0X-0006bf-EZ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:25:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b9814efbcso5581745e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756819504; x=1757424304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rz/p6M0rklQHwfyQ6YvhjhFju5Y1e2Dz66wkkh69jUI=;
 b=V+f0QGCmLLB3/qhKhi8harvVDOJqFRxa1oh0gDKquKDvxPQuNLAeJN2MLhuOCFNK+G
 cS2B1UB1hV+W4UmvT23cRSZO+i8VPpUV7ht4zBj7bH/xX/u0hMz00KnfRkqW1d1S75+p
 xnxITKhnZWYGktFSV3GQL67blatkLFGntLHamyF0NJrSIQaGfrRUT5byjsySS5pQLV80
 wRNRSqU7VGWXdmvH9rqT2zLU+HNEqli4bM7u2qN5+IaDc+PZW/4Ci+B2opW6ZbYoUvee
 70L7Kmi+JWuvBNPDTDUx1DtUOQlZXGkU+DElctrbRx92/C84pZiYzOa8J+IGtyAWZxPW
 +DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756819504; x=1757424304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rz/p6M0rklQHwfyQ6YvhjhFju5Y1e2Dz66wkkh69jUI=;
 b=o98wiltKcAUTl6NNGTJHqF0B9F+C0SaLwe8WfU+zlZrH3INpDbJzaTnPtIP4BfQ8M2
 odMlv12jCtRsDO8jJ2xvtrhNcSJdSe/cu+eLz04h5T8R4+ibqRApy8Mp93Yf35MmXdl3
 6Og/XLfomeO4rvYe5Q0LIQbO1MNiohDZYuJhb+a2iYM7su/8/3QynI1qQmvIswcHGk8C
 37LXBOUaFwu1UQiw17lO+LwpA8MRo1QiMCUXvDuRGCc32rh4/M82wwI0uLkf7QiQ84sn
 wgvP7GjXK3MOu3OYbApBqaK5M9oxmOlV0psZurBrDLmiR3n2XK6PLNb15POH7lMAD1zn
 e7FQ==
X-Gm-Message-State: AOJu0YyjSfBvt2JhR86HIbRzLs266OthTKMxEnsgFttivdvcvCFw9Jbk
 TVsQQSCAkXsLqh3bpaWCLqIU02mAkyNHLvSvWGFcxYG7r16QYw8EeTn7g5X96lcK7ut9OSjq+8f
 X4KNP
X-Gm-Gg: ASbGncvbnawmRpY6JsTm8u5jHCTYdKn+1iWDDnVZGgp3chyrKsCGNNgbdccJ9YHNmUz
 Yj9H7SIL8MH0xhyFHk5GxDx+pMKikceWcTsM00TONA7+qfq44VmQ4URyEmi5hYbyCKBH0CxtU5x
 CtZnfTRlf64OCw0i+LhPEVMdEDx8uenMV7ZCPcGGAvTmVID+Q0R19VMOZXUN7/ng3U8/+F+839u
 4KTlMDoMFBwu26YY/i7kvZhk+LDHCzhCHGGkSs9koEUNmejMZpAYudcbhUEVH0CkbxxF77ssqta
 TV17Jl6UPbNur0p2ISa3gXET+NptqbSsgjM0kKyYHX7F/CgTDfA3MENghkWMQsR9f/4/9K9cpSm
 QsBVb2BavFsCFQvDWQgxqECF2Dq1+oNBno3A7PqzhAG7zpde5wKq6DJeXsmIgeNEdgIerP6qrp3
 F1
X-Google-Smtp-Source: AGHT+IEYmruxNHSN7LVlQ+61cQOiuO9GUpOJdI4vg0itRWRn52yE5aUCbQ+D5IlmMUWkcOPQ5loTdw==
X-Received: by 2002:a5d:5712:0:b0:3dc:db:89f3 with SMTP id
 ffacd0b85a97d-3dc00db8a77mr46469f8f.16.1756819504134; 
 Tue, 02 Sep 2025 06:25:04 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fbd01sm20127940f8f.13.2025.09.02.06.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:25:03 -0700 (PDT)
Message-ID: <baa2f292-c29c-4045-8470-a9c7387cf98a@linaro.org>
Date: Tue, 2 Sep 2025 15:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] accel: Add per-accelerator vCPUs queue
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Zhao Liu
 <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Salil Mehta <salil.mehta@huawei.com>
References: <20250106200258.37008-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc'ing Pierrick & Salil.

On 6/1/25 21:02, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Currently we register all vCPUs to the global 'cpus_queue' queue,
> however we can not discriminate per accelerator or per target
> architecture (which might happen in a soon future).
> 
> This series tries to add an accelerator discriminator, so
> accelerator specific code can iterate on its own vCPUs. This
> is required to run a pair of HW + SW accelerators like the
> (HVF, TCG) or (KVM, TCG) combinations. Otherwise, i.e. the
> HVF core code could iterate on TCG vCPUs...
> To keep it simple and not refactor heavily the code base,
> we introduce the CPU_FOREACH_TCG/HVF/KVM() macros, only
> defined for each accelerator.
> 
> This is just a RFC to get some thoughts whether this is
> heading in the correct direction or not ;)
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (7):
>    cpus: Restrict CPU_FOREACH_SAFE() to user emulation
>    cpus: Introduce AccelOpsClass::get_cpus_queue()
>    accel/tcg: Implement tcg_get_cpus_queue()
>    accel/tcg: Use CPU_FOREACH_TCG()
>    accel/hw: Implement hw_accel_get_cpus_queue()
>    accel/hvf: Use CPU_FOREACH_HVF()
>    accel/kvm: Use CPU_FOREACH_KVM()
> 
>   accel/tcg/tcg-accel-ops.h         | 10 ++++++++++
>   include/hw/core/cpu.h             | 11 +++++++++++
>   include/system/accel-ops.h        |  6 ++++++
>   include/system/hvf_int.h          |  4 ++++
>   include/system/hw_accel.h         |  9 +++++++++
>   include/system/kvm_int.h          |  3 +++
>   accel/accel-system.c              |  8 ++++++++
>   accel/hvf/hvf-accel-ops.c         |  9 +++++----
>   accel/kvm/kvm-accel-ops.c         |  1 +
>   accel/kvm/kvm-all.c               | 14 +++++++-------
>   accel/tcg/cputlb.c                |  7 ++++---
>   accel/tcg/monitor.c               |  3 ++-
>   accel/tcg/tb-maint.c              |  7 ++++---
>   accel/tcg/tcg-accel-ops-rr.c      | 10 +++++-----
>   accel/tcg/tcg-accel-ops.c         | 16 ++++++++++++----
>   accel/tcg/user-exec-stub.c        |  5 +++++
>   accel/xen/xen-all.c               |  1 +
>   cpu-common.c                      | 10 ++++++++++
>   hw/i386/kvm/clock.c               |  3 ++-
>   hw/intc/spapr_xive_kvm.c          |  5 +++--
>   hw/intc/xics_kvm.c                |  5 +++--
>   system/cpus.c                     |  5 +++++
>   target/arm/hvf/hvf.c              |  4 ++--
>   target/i386/kvm/kvm.c             |  4 ++--
>   target/i386/kvm/xen-emu.c         |  2 +-
>   target/i386/nvmm/nvmm-accel-ops.c |  1 +
>   target/i386/whpx/whpx-accel-ops.c |  1 +
>   target/s390x/kvm/kvm.c            |  2 +-
>   target/s390x/kvm/stsi-topology.c  |  3 ++-
>   29 files changed, 130 insertions(+), 39 deletions(-)
> 


