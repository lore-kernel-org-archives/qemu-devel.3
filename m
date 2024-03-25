Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46932C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 17:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rooSp-0004bJ-H7; Mon, 25 Mar 2024 13:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rooSo-0004b2-LB
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rooSk-0000Mx-Ip
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711389020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgeudOPUdFhKToQeclPDI1rbISaoF9vG9EsQS5jFg/0=;
 b=dZXAgwVvbUc+8WugdVwPV9F6vrpVqBiIAbEmReCLkaMM9gCHJTZfEJktjkJiG4ovICZqku
 iBf5HefpLaba7u42a6x6OpJAjVFQ6f0WfIN3o0uMzQ0+X98EpQBml5hVGYp6jrTbA2Wnsy
 0R+PiLnQ3QM6G+E+yRrLrpqqCtRKhwA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373--o7rlGSNM6S7gVGQ38Y9Qw-1; Mon, 25 Mar 2024 13:50:19 -0400
X-MC-Unique: -o7rlGSNM6S7gVGQ38Y9Qw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ed483c2ecso2274400f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 10:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711389017; x=1711993817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hgeudOPUdFhKToQeclPDI1rbISaoF9vG9EsQS5jFg/0=;
 b=H+TRUv3ccqD1Z4e5ZkduU2tZeLAKYgGNrB+k8S7PLkz6rVuuWROowbT2cr9x+iHv3J
 pONT0PDP4gQ7eYmMXqlsfQ0wN9lWncPFMz2sCmzd3KjImHPM9QM/C0b2SQVeu57EaVpr
 wAMhc4L/nkpIlunu8Wuqf1e7/IFit9HVbto/dqIRJ4QsaY7FimBDqjpgR5PNdF5huFvk
 YyjIzUtM48Ljej1qYtG+kPF4Dwh85ef7ttzUwcwIB2lXg3c99lqAIYtA7Ck3Zj6wBk5h
 ZaiwVKDIRXWUZA+St/n+6PSBZiudSUB3nJmijmm5v8G4367Iki/5pZdPp4SajBEHPL2e
 bgXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPhS9SlGhapnSGe/l/JPwRlTJzMz87z4R7UzyMnQzkmX9A4uUWx5R9o6u3+IwwcjX9iewjZOMnxiNSOmraOjmYBKh8UfI=
X-Gm-Message-State: AOJu0Yxd0SMzQEDMgC7SwznmZki5E5mHoE2D/DDJjqOyrVN0Xe7JLJAB
 DYmbV9Cpgm0FFvzMG/8tVrm6NINcThMHhQD+yfPg/Ran63ZyyQowFIozq815SFZUU3koJgTQju5
 M0DA6WtGUmg80TVBnWLbod7Zn9mqntRJYk9CkziXtYry06FNojkDiwNOQ5k5b
X-Received: by 2002:adf:db4b:0:b0:33e:7a10:4d6e with SMTP id
 f11-20020adfdb4b000000b0033e7a104d6emr4806905wrj.32.1711389017080; 
 Mon, 25 Mar 2024 10:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHahzv4gHdMF6ifZz+x7znDSFtzbIJb88Ky9A5tGtwjbE6qCPvTQF3j2/eNkz5NAuhzoiL1VQ==
X-Received: by 2002:adf:db4b:0:b0:33e:7a10:4d6e with SMTP id
 f11-20020adfdb4b000000b0033e7a104d6emr4806893wrj.32.1711389016776; 
 Mon, 25 Mar 2024 10:50:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a5d5947000000b0033f20497d4asm10070058wri.5.2024.03.25.10.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 10:50:16 -0700 (PDT)
Message-ID: <1e9d4dff-03e0-41f4-9cf0-8059043e0860@redhat.com>
Date: Mon, 25 Mar 2024 18:50:14 +0100
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
Received-SPF: pass client-ip=170.10.129.124;
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
Please forgive me for the delay
> This seems reasonable, but it's not the same way we opted to
> handle telling the kernel the IRQ number for the PMU interrupt
> (where we use kvm_arm_pmu_set_irq()). I guess we have to do
> it this way because it's a device attr so we need to set it
> in gic realize, though?
This cannot follow the same pattern as the

kvm_arm_pmu_set_irq() because the maintenance irq must be set between before the GICv3 KVM device creation and the 
KVM_DEV_ARM_VGIC_CTRL_INIT. The GICv3 realize function calls both so I cannot set the maintenance after the realize. It would fail
with -EBUSY. Hope this helps.

Thanks

Eric

>
> By the way, does the kernel automatically complain and fail
> if we try to enable nested-virt with a GICv2 or with a
> userspace GIC, or do we need to catch and produce error
> messages for those (invalid) combinations ourselves?
>
> thanks
> -- PMM
>


