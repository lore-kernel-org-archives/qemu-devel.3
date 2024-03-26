Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C579CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 11:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp4bT-0004pM-F8; Tue, 26 Mar 2024 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rp4bR-0004on-HZ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 07:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rp4bL-0004Hu-V3
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 07:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711451058;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f53q2SxPvBYjGYJCIgE6J1ereeB88Gl5EgTBiYMMG8w=;
 b=L5fqwYyuzEKicpLSE9v3mcL1z9F2ySL5zIh3Pkkik3cQ2/3hFVjB80ZPjMoApL1pWFp77c
 jaEqSDPxSaKM6KdgsF9SQZ/GKDgxYyHhZgNm2T3WIG0Hp6cy5F4LK14gz5RkCzkn+6xFnU
 4/Vz60WnN/K2fkR4vC86k5rII3yzXeU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-1ADkDiHjO16COpcDhhfD9Q-1; Tue, 26 Mar 2024 07:04:16 -0400
X-MC-Unique: 1ADkDiHjO16COpcDhhfD9Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4147de378b9so20183245e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 04:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711451055; x=1712055855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f53q2SxPvBYjGYJCIgE6J1ereeB88Gl5EgTBiYMMG8w=;
 b=LtyismeRPH4N+QzqaoEXTJfnkU5lgy4atjnxrQyx+hIrDExk928jJVnUZME9tbwlV5
 Vz3ODx7n553VGa7g03BYE3ci/waMf1fNvxEtQjnfHGG0ypJwXAWIjIwcmLzgRwWBdU8/
 N49wi1R7lvrYTKbndmHFzK/e0bVwOuEiOZaPd7fCGUPs47OHEvRV9dYIYcxfk4Sjz363
 5B2vyF74WhGiFVcP3s9u0cgWjCSfGZGGCFHOoONj/P7bt+GR6jbVMcbiCMF/BjDHb6Qz
 EZF0pRWLYDLWaMP1yeW+6E2TervTtfzesexsLWdWIAUrxzcfQIla2jtn0/+5CynZ5hrQ
 A+Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLvV3b91r9vwQBUElXyXswnbh6NUa1BEm+Icy4agEA02SCZyIXyGFtwZVn7BVVgDdjnKyN2C2PSQthH5Xsjc/0vaHtrVs=
X-Gm-Message-State: AOJu0YzLr71rz0aiVaB9dCUuhaNe4pd79aAHe6Li+g/hiqszVTQ0o8JV
 5/Tpb8z9x89m7P//gs3EMxLPH8/LWR1JncKftLXlrDVanscNaC+8eGGEw7AhvqRbk62v2BS/EnZ
 IICm6TSsHgy7sO028Go+hKB7oL08SJr0th4R13zhZdKY7Pqs0m36l
X-Received: by 2002:a05:600c:310f:b0:414:8fe0:2d16 with SMTP id
 g15-20020a05600c310f00b004148fe02d16mr704596wmo.37.1711451054642; 
 Tue, 26 Mar 2024 04:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdPThOuBxSgRlZH6H9FOFSMJ6YN1MqKlrf0HdFMuJEhYFylSzGcbb1pAFh7O3Ml/KsDNiAiQ==
X-Received: by 2002:a05:600c:310f:b0:414:8fe0:2d16 with SMTP id
 g15-20020a05600c310f00b004148fe02d16mr704569wmo.37.1711451054234; 
 Tue, 26 Mar 2024 04:04:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 hg9-20020a05600c538900b004101f27737asm11162672wmb.29.2024.03.26.04.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 04:04:13 -0700 (PDT)
Message-ID: <7f3e08db-5c95-4c8d-8b33-857ced740d48@redhat.com>
Date: Tue, 26 Mar 2024 12:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/5] hw/arm: Allow setting KVM vGIC maintenance IRQ
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org,
 maz@kernel.org, gkulkarni@amperecomputing.com
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <20240209160039.677865-3-eric.auger@redhat.com>
 <CAFEAcA-yLbwPyUxQy2s0CGwcE1z04WQd+EX0xmrvhUepfPR5ZQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA-yLbwPyUxQy2s0CGwcE1z04WQd+EX0xmrvhUepfPR5ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

On 3/5/24 17:46, Peter Maydell wrote:
> On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>> From: Haibo Xu <haibo.xu@linaro.org>
>>
>> Allow virt arm machine to set the intid for the KVM GIC maintenance
>> interrupt.
>>
>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v1 -> v2:
>> - [Miguel] replaced the has_virt_extensions by the maintenance irq
>>   intid property. [Eric] restored kvm_device_check_attr and
>>   kvm_device_access standard usage and conditionally call those
>>   if the prop is set
> This seems reasonable, but it's not the same way we opted to
> handle telling the kernel the IRQ number for the PMU interrupt
> (where we use kvm_arm_pmu_set_irq()). I guess we have to do
> it this way because it's a device attr so we need to set it
> in gic realize, though?
>
> By the way, does the kernel automatically complain and fail
> if we try to enable nested-virt with a GICv2 or with a
> userspace GIC, or do we need to catch and produce error
> messages for those (invalid) combinations ourselves?
I don't think there is any check of that kind in Marc's series yet.
This may be added if GICv2 KVM device is created while kvm_mode is set
to KVM_MODE_NV.

Wrt userspace irqchip compat, KVM_CAP_ARM_USER_IRQ extension may not be
exposed in case of nested virt.

Marc, is that something you would like to integrate into the kernel series?

Thanks

Eric
>
> thanks
> -- PMM
>


