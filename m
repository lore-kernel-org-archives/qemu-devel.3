Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6D9CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9OZi-0004vM-Sc; Thu, 16 Oct 2025 10:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OZg-0004tG-QS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OZR-00079C-Q4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760623386;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8giGHhG8T5nbIjMPjoC+yK9yQpSqCmuqMYVXVpZhhA=;
 b=OIw32+lwqIN3pd/lZHo29q6KCuOtLf5dfjUTVE9Ret6pBeMFrTpaZusDprGRKNEYWTK1oD
 ype+ql69Kkj+BYaqfBuDfmN54oKhsPSZlRJiYXFh5yZnxM3o9PhTVnhVD8/1dknKyHIan7
 iSDhWfNWN6D0Wl9pdy8RC9ytf5xU5DA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-B4QkWNrKNTOk7h1RTHjMPw-1; Thu, 16 Oct 2025 10:03:04 -0400
X-MC-Unique: B4QkWNrKNTOk7h1RTHjMPw-1
X-Mimecast-MFC-AGG-ID: B4QkWNrKNTOk7h1RTHjMPw_1760623383
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47113dcc1e0so4397675e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 07:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760623383; x=1761228183;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8giGHhG8T5nbIjMPjoC+yK9yQpSqCmuqMYVXVpZhhA=;
 b=P9qQD4hKtotS0j/jzILtJ9E4/0pWYPnwdKhJa2HijBFMhvPMF0p0s+Ia70ta2IJvFU
 SiUddSqIbNZezSd0RziX6zWQumiSYC3CTDvKqkka6W5oqiVOX5GR6ffETqL6/YW3Px0d
 Y6LX+OtJw5nN2mcD7eU9OGeTm7HsjEpb5uqbkDTS03w4f3/Pym05TPG7tFF99s7q9UbH
 pGPs+oQdCamlRstzYRlJ4O32rTCbww9cMHv0FYJ+hH4SHa7wQNVhdv/aLrjKIbUFvGwk
 i0gUX3cV2+AT89No3ldgw1c8MODA5YaGSyKe/uSZuhELKpTHG689mQRphVBe+jQZi3lx
 NE4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU48rXr2pMA1OUKkibiRc4wN5rYnOnKiQSONTIcdn3KrnMlGevf3g1WWhihzzweP6O4yRO3fqzGAebX@nongnu.org
X-Gm-Message-State: AOJu0YxiGBpFq0Hq9XUS5bOKjX0FTG+TEjaoWJHXVDX6nf04P4H8K4bD
 RJykJdg0/FSOJOBpw/srJRHS0sCpuA0kak31FaEl/O71lqSKTvlHYcyiUNphGi4C6grrfpJ4heH
 BhvAyiJdtELKNrfm5/m6M79ybkdqZyzjE+t0/rk6RcD8eOiyc0fFKKbut
X-Gm-Gg: ASbGncuoDaPHUVimFgwaI7drzSk3IFiIf+ApcQ6gEufTGWDg5rAK5HaYJYiBoM9MQmH
 gjbw1e/sx8cwn/85eCXiecYVymg+goXGyC4AYgicuZQgk9IrpiR7Gw+5d36m8juCu9rPsm+FBns
 oJWtjLRCbS19m+IG56PvOkGlHXZpr2puFLweRbu5gNWKw2hHgHcN5Etg9iSwybjC8X3aOYvqaK/
 jxMIhZ7BoMWpsP8OsuGniX0ti7dWOX5pi0AtnuLLOfy7/XFZ6bi9vTml7vw4f5Th34JjPWghii0
 8XEkXLGIUbyk6cBr3ET1+YFfotWzmYCZBrIpVYJVEk9AgI+D5+4FgGddse9N7t7GHcv1eytQwyw
 P1v39K48LmOZJRvOzWO0PSiqo0bW89iJfbi7jEuDxsdRZwg==
X-Received: by 2002:a05:600c:3544:b0:471:c72:c80b with SMTP id
 5b1f17b1804b1-471178ad7b3mr599725e9.18.1760623382761; 
 Thu, 16 Oct 2025 07:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJrVIC0NiC3D/z9lLru4+1nxANr45HaI5xWg8T/RSKZr4f2v5O4Ms8S+qsCZMRpPTLQqsf9A==
X-Received: by 2002:a05:600c:3544:b0:471:c72:c80b with SMTP id
 5b1f17b1804b1-471178ad7b3mr599375e9.18.1760623382104; 
 Thu, 16 Oct 2025 07:03:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f289daasm20449135e9.6.2025.10.16.07.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 07:03:01 -0700 (PDT)
Message-ID: <6b07479f-cc69-4b05-bd6b-ef3fa199794a@redhat.com>
Date: Thu, 16 Oct 2025 16:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251016135625.249551-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251016135625.249551-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 10/16/25 3:55 PM, Eric Auger wrote:
> When migrating ARM guests accross same machines with different host
> kernels we are likely to encounter failures such as:
>
> "failed to load cpu:cpreg_vmstate_array_len"
>
> This is due to the fact KVM exposes a different number of registers
> to qemu on source and destination. When trying to migrate a bigger
> register set to a smaller one, qemu cannot save the CPU state.
>
> For example, recently we faced such kind of situations with:
> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>   register from v6.16 onwards. Causes backward migration failure.
> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>   from v6.13 onwards. Causes forward migration failure.
>
> This situation is really problematic for distributions which want to
> guarantee forward and backward migration of a given machine type
> between different releases.
>
> This small series tries to address that issue by introducing CPU
> array properties that list the registers to ignore or to fake according
> to the situation. An example is given to illustrate how those props
> could be used to apply compats for machine types supposed to "see" the
> same register set accross various host kernels.
>
> The first patch improves the tracing so that we can quickly detect
> which registers are unexpected and cause the migration failure. Missing
> registers are also traced. Those do not fail migration but their default
> value is kept on the destination.
>
> Then we introduce the infrastructure to handle 'hidden' registers and
> 'fake' registers.
>
> Eric Auger (7):
>   target/arm/machine: Improve traces on register mismatch during
>     migration
>   target/arm/kvm: Introduce the concept of hidden KVM regs
>   target/arm/kvm: Introduce the concept of enforced/fake registers
>   kvm-all: Add the capability to blacklist some KVM regs
>   target/arm/cpu: Implement hide_reg callback()
>   target/arm/kvm: Expose kvm-hidden-regs and kvm-fake-regs properties
>   hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility with older
>     kernels
For some reason the last patch was not properly sent
PATCH 7/7] hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility with
older kernels

got "4.7.1 Service unavailable - try again later"

So I resent. Sorry for the noise.

Eric
>
>  include/hw/core/cpu.h   |  2 ++
>  target/arm/cpu.h        | 42 ++++++++++++++++++++++++
>  accel/kvm/kvm-all.c     | 12 +++++++
>  hw/arm/virt.c           | 19 +++++++++++
>  target/arm/cpu.c        | 12 +++++++
>  target/arm/kvm.c        | 73 ++++++++++++++++++++++++++++++++++++++++-
>  target/arm/machine.c    | 71 +++++++++++++++++++++++++++++++++++----
>  target/arm/trace-events | 11 +++++++
>  8 files changed, 235 insertions(+), 7 deletions(-)
>


