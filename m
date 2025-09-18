Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970A7CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFZQ-0000WU-JH; Thu, 18 Sep 2025 10:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uzFZP-0000W6-Hy
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uzFZN-00027N-LP
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758205507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2G7vCS/dq3lMHpDvsFlhCHpysVPfG96RFQkuvStkzk=;
 b=feK9Y22rfNh7iy7+3m0TCji9n5u0RmJIe0JwPkKhVqWxVciOR3EdXsGce9OSQ2CuZlTN8s
 1IGmAeqXphewKFn/Bg3G4fyQU9ijAdKgutV1A6VhgJkQ3SwP871q1aUbp3ar2FPQ+0gIpm
 T3Mdl623gPkj22F6XPLDJQJ8cJO5wkI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-covSSmeeMda9n1HQC9Ea4Q-1; Thu, 18 Sep 2025 10:25:05 -0400
X-MC-Unique: covSSmeeMda9n1HQC9Ea4Q-1
X-Mimecast-MFC-AGG-ID: covSSmeeMda9n1HQC9Ea4Q_1758205504
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45f2f15003aso6671695e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 07:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758205504; x=1758810304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k2G7vCS/dq3lMHpDvsFlhCHpysVPfG96RFQkuvStkzk=;
 b=gGPIN/cGq6vUzugoRaf65loRrgspbqIanXpWD23UG4dNGbYyZ1DlNI4guQAqMoCBjH
 4VNZK3cbXk3Oh+ANyy0wbakK6neAojYvh4qMpM+c7ADM3sjCyvWH0y0V6zHf6plWSI87
 Tm/uDVhsTOp8Ig3Pah5zWhkzupWDTAzkBrCC+7qAwYS+eiKi2xmsVXqISwNi8YgRjVET
 HeHKDvBm9atprOaq1QvRd6UQNnKgL6llgQfMptGF6kVcUoMaOcWZb7kKBb5OUQX/miel
 Ke/WzYb1TJFgAPwW8mWDgXzP0/giveNG34qeLgGCiNgrjjbqR1nImUrNrnAfDKahPZ42
 yhRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVxG+9CZl5laclhSVzKofkW+ezPk5ZExPFUPe160+x1rqpIwDtUUV7BVNuUU7eZu23JaeAXSZYZ8YI@nongnu.org
X-Gm-Message-State: AOJu0Yw+78Dfr8x7SVqD7MyqlKNVyNIu2ANKWTi2Yf5QV48a39L7gk5I
 /+pxbCFyPOuzFY8RVIVfsuoXHTPxWBtfL3HOEGSEpwSpjUIxhl+JgDv0HnZWf6crX4FswdLVTVh
 osZFMj9Xfyyb8V9lD0Atvc3IQW3KpYa2vlYzy+POG4oiPtUd1nS+CO8Mx
X-Gm-Gg: ASbGncv7bzLW2hq7lYzcZ/Sp1xW8P4lUEu3haYmxJPpI34T73UXZscaFLZAKgVEB9fB
 qOWg1E0iE8j5oyTzxWA3MO7apQjAauKUzXUtaHqabhe0X7NdoMWHFO5Llgy/NAgkg/hObmTR15F
 Z8b+mLHXDxLJxy2zqk3iiKWMeRrdp7h9Oaiel1HBBEyizqS1vJXfJ1En/0v9T+ibDBb2RA+TQ3Z
 AZ90/ayZWrAU/f9kmseMGUlqXUdVaug8IbezmSX0Ewo3AJdwNJuCYc94HGYlXG1UlcXW7Eifk/1
 hSzflWVxtbFgrItJ4wb3VgfIlutDsiVKeZRLxsV16RKgt/wOHxy8F2YF6rAaTOQo14xYBQ9OLCr
 0XdYMlpD9iSQ=
X-Received: by 2002:a05:600c:4eca:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-4634c528acamr46109965e9.36.1758205504156; 
 Thu, 18 Sep 2025 07:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMq4Lq58qPJkEx6oekmJdG1VjWks1gpE5xrvTqloRglPEvekf9jxRLASR2o5eHIbj094/fAw==
X-Received: by 2002:a05:600c:4eca:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-4634c528acamr46109655e9.36.1758205503707; 
 Thu, 18 Sep 2025 07:25:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f64ad359sm52761595e9.22.2025.09.18.07.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 07:25:03 -0700 (PDT)
Message-ID: <60b78889-79b6-4efd-aacf-48e7b9456db2@redhat.com>
Date: Thu, 18 Sep 2025 16:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: add kvm-psci-version vcpu property
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Cornelia Huck <cohuck@redhat.com>
References: <20250911144923.24259-1-sebott@redhat.com>
 <CAFEAcA8EDJT1+ayyWNsfdOvNoGzczzWV-JSyiP1c1jbxmcBshQ@mail.gmail.com>
 <8bca09f1-48fe-0868-f82f-cdb0362699e1@redhat.com>
 <CAFEAcA8hUiQkYsyLOHFQqexzY3u4ZZZBXvi+DuueExGdJi_HVQ@mail.gmail.com>
 <3176813f-77c0-4c39-b363-11af3b181217@redhat.com>
 <CAFEAcA_ui7iyKx36fuhmOqizRWnNppb9B1iPc4nAxU2VnovMOQ@mail.gmail.com>
 <6f1eb1b8-29d4-cdcb-f379-9869d806a116@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6f1eb1b8-29d4-cdcb-f379-9869d806a116@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/11/25 6:46 PM, Sebastian Ott wrote:
> On Thu, 11 Sep 2025, Peter Maydell wrote:
>> On Thu, 11 Sept 2025 at 17:29, Sebastian Ott <sebott@redhat.com> wrote:
>>>
>>> On Thu, 11 Sep 2025, Peter Maydell wrote:
>>>> On Thu, 11 Sept 2025 at 16:59, Sebastian Ott <sebott@redhat.com>
>>>> wrote:
>>>>>
>>>>> On Thu, 11 Sep 2025, Peter Maydell wrote:
>>>>>> On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> This series adds a vcpu knob to request a specific PSCI version
>>>>>>> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
>>>>>>>
>>>>>>> Note: in order to support PSCI v0.1 we need to drop vcpu
>>>>>>> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>>>>>>> Alternatively we could limit support to versions >=0.2 .
>>>>>>>
>>>>>>> Sebastian Ott (2):
>>>>>>>   target/arm/kvm: add constants for new PSCI versions
>>>>>>>   target/arm/kvm: add kvm-psci-version vcpu property
>>>>>>
>>>>>> Could we have some rationale, please? What's the use case
>>>>>> where you might need to specify a particular PSCI version?
>>>>>
>>>>> The use case is migrating between different host kernel versions.
>>>>> Per default the kernel reports the latest PSCI version in the
>>>>> KVM_REG_ARM_PSCI_VERSION register (for KVM_CAP_ARM_PSCI_0_2) -
>>>>> when that differs between source and target a migration will fail.
>>>>>
>>>>> This property allows to request a PSCI version that is supported by
>>>>> both sides. Specifically I want to support migration between host
>>>>> kernels with and without the following Linux commit:
>>>>>         8be82d536a9f KVM: arm64: Add support for PSCI v1.2 and v1.3
>>>>
>>>> So if the destination kernel is post that commit and the
>>>> source kernel pre-dates it, do we fail migration?
>>>
>>> This case works with current qemu without any changes, since on
>>> target qemu would write the register value it has stored from
>>> the source side (QEMU_PSCI_VERSION_1_1) and thus requests kvm
>>> on target to emulate that version.
>>>
>>>> Or is
>>>> this only a migration failure when the destination doesn't
>>>> support the PSCI version we defaulted to at the source end?
>>>
>>> Yes, this doesn't work with current qemu. On target qemu would
>>> write QEMU_PSCI_VERSION_1_3 to the KVM_REG_ARM_PSCI_VERSION
>>> register but that kernel doesn't know this version and the
>>> migration will fail.
>>
>> I was under the impression that trying to migrate backwards
>> from a newer kernel to an older one was likely to fail
>> for various reasons (notably "new kernel reports a new
>> system register the old one doesn't") ?  Perhaps we should
>> think about the problem in a wider scope than just the
>> PSCI version...
>
> Yes we already are ;-) See this series from Cornelia:
> https://lore.kernel.org/qemu-devel/20250414163849.321857-1-cohuck@redhat.com/
>
>
> And this from Eric:
> https://lore.kernel.org/qemu-devel/20250911134324.3702720-1-eric.auger@redhat.com/
>
the above series especially handles a class of migration errors where
the source host kernel exposes more KVM regs to userspace than
destination host kernel. In that case, currently, the vcpu state cannot
be migrated. I should have called that: mitigation of* "failed to load
cpu:cpreg_vmstate_array_len" migration errors. Sebastian tries to handle
a change in the default value of a pseudo FW register. We would like to
have a compat to keep the old value for old machine types. Thanks Eric *
>
> Both will help mitigate register differences for a backwards/downgrade
> migration.
>
> Sebastian
>


