Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8CDC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7gV-0001qh-Ds; Thu, 08 Feb 2024 11:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rY7gT-0001qI-RT
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rY7gS-0001Mf-CG
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707411331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMoXHXY4+qZJUeESHsnlS6as99TdnkReAv8/2YwmyFc=;
 b=Q2pMqymUUAyuglxWGO3Es5sicgoGCqPhwrfG2RH+joEbzWR0rdmvlckLh2y6mkf57Erstp
 BvUiq/1W89nWelHji0KIaT4oRkYXnSHDWar1jAce2uFUI4dNQpVqE/Ybzql8hcJjCdipeT
 Y2j9jdR3Dhy5MVyNyI2EI48SVWcPHJE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-LNRpkZexPFKjM2UH6h7K5Q-1; Thu, 08 Feb 2024 11:55:28 -0500
X-MC-Unique: LNRpkZexPFKjM2UH6h7K5Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42c4346a56dso140691cf.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707411328; x=1708016128;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pMoXHXY4+qZJUeESHsnlS6as99TdnkReAv8/2YwmyFc=;
 b=LJJqJ6Vh6Bpk2apjD3ku4wIgOqEjEczlu5uJUFbsnCmXKqwb43DCQPteNJJRyC0JeG
 ed5ccaixJG9Co/5OlBxAasRXt78xlYdZL2oJsnQo0mtdUpxr4NDGTW++jyB0hk80wqjS
 7LgKTEAspzCOfqYnKizihTl3nqxdohXV6q+2dwoWD6AuIfUVdjUD6aY+1NP8r7WxPuif
 S5PB/yMEVxpSEFHcYgy2QQvkGXqqa6TkdFmk3Lcw1Atrk63wNPJzp96GP9nlbr1UN57S
 txlC0iEeje3j3oEVy2SsVToxYmbrEAO2ddRhgqVN2IFhGAUCxo5rxiB990Vi1rYFpXjs
 mTOQ==
X-Gm-Message-State: AOJu0YxQokLjcq+WZanrg/qB2Ojv7igbiUnyLhtbMTVYyPvl8AiXTWXY
 3oz81CK8KNwOoT0qNoYjwm8cFt//2DmRNDvSj4HliQyVZzyQ5cYfNd8375qBapxwDOAlsoCHTeR
 tNktXEha/k/wYOw6auEvedmo7Qajow7QX3W2HEHrwwj4VlqSb0God
X-Received: by 2002:ac8:48c2:0:b0:42c:35e4:3cc6 with SMTP id
 l2-20020ac848c2000000b0042c35e43cc6mr8166344qtr.3.1707411327952; 
 Thu, 08 Feb 2024 08:55:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHTUvt6+9XsB4dFreOWX47R9TxG8zqZv/VOJoiksc6oyDd9cLFcSxf7OoTKYYgdl264aNidg==
X-Received: by 2002:ac8:48c2:0:b0:42c:35e4:3cc6 with SMTP id
 l2-20020ac848c2000000b0042c35e43cc6mr8166327qtr.3.1707411327686; 
 Thu, 08 Feb 2024 08:55:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV0MsbI4sXkZ9EFzkklzZHbdlraq6P1pZFfv11g5LJ0Ac6oud/PoQh/z0Jr7I953hvqsvKrFejLdLpFPkcMTZl8pH7LzX6u1nIfkpefR2hGtT/abz+9scooBMx2EVJulbAYZYh06hD0boFsRH3XXqxzFK5dQOW06WnvfKrh6imAvFMiqIs26SGwhPNiIdTlTDTJlqy2qZo01TjL0nsVCBEMeSveqI1KCGMN+3+19GbMKSeFj9bOZhe3t98r7SDM5XQdeHLCXR/+EtahhAuypFcRQGcr5TkryosL1b1gQI74sCMa7/J2
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 gx11-20020a05622a27cb00b0042bf5ec20f0sm148876qtb.30.2024.02.08.08.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 08:55:26 -0800 (PST)
Message-ID: <5ede0197-4587-43e8-976f-d3001f42b8b9@redhat.com>
Date: Thu, 8 Feb 2024 17:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] QEMU v7.2.0 aarch64 Nested Virtualization Support
Content-Language: en-US
To: Miguel Luis <miguel.luis@oracle.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Marc Zyngier <maz@kernel.org>
References: <20230227163718.62003-1-miguel.luis@oracle.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20230227163718.62003-1-miguel.luis@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Miguel,

On 2/27/23 17:37, Miguel Luis wrote:
> This series adds ARMv8.3/8.4 nested virtualization support in KVM mode.
>     
> To enable nested virtualization for a guest, the host must expose EL2
> support via QEMU command line switches:
> 
> -machine virt,accel=kvm,virtualization=on
> 
> Inspired on Haibo Xu's previous work [0][1], Marc Zyngier's kvmtool branch [2]
> and kernel patches [3] on nested virtualization for aarch64, this has been
> tested on an Ampere implementation.
> 
> This series adapts previous work on top of v7.2.0, it considers comments given
> at the time and preserves authorship of the original patches.
> 
> [0]: https://lore.kernel.org/qemu-devel/cover.1616052889.git.haibo.xu@linaro.org/
> [1]: https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/maz/kvmtool.git/log/?h=arm64/nv-5.16
> [3]: https://lore.kernel.org/linux-arm-kernel/20230131092504.2880505-1-maz@kernel.org/

I rebased the series on top of v8.2. I was able to boot some L2 guests
with it, although it still does not work with guests featuring edk2.

Do you plan to send a respin or may I do?

Thanks

Eric
> 
> Miguel Luis (5):
>   linux-headers: [kvm,arm64] add the necessary definitions to match host
>     kernel
>   hw/intc/gicv3: add support for setting KVM vGIC maintenance IRQ
>   target/arm/kvm: add helper to detect EL2 when using KVM
>   target/arm: enable feature ARM_FEATURE_EL2 if EL2 is supported
>   arm/virt: provide virtualization extensions to the guest
> 
>  hw/arm/virt.c                      |  8 +++++++-
>  hw/intc/arm_gicv3_common.c         |  1 +
>  hw/intc/arm_gicv3_kvm.c            | 25 +++++++++++++++++++++++++
>  include/hw/intc/arm_gicv3_common.h |  1 +
>  linux-headers/asm-arm64/kvm.h      |  2 ++
>  linux-headers/linux/kvm.h          |  1 +
>  target/arm/cpu.h                   |  2 +-
>  target/arm/kvm64.c                 | 21 +++++++++++++++++++++
>  target/arm/kvm_arm.h               | 12 ++++++++++++
>  9 files changed, 71 insertions(+), 2 deletions(-)
> 


