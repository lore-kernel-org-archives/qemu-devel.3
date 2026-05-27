Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E722CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGz3-0005wl-PX; Wed, 27 May 2026 12:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGz0-0005uJ-Qz
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGyy-0005U4-EN
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779898787;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWehKC6VzlOi12pDotLZu0gXRvyJlSMzVrHQdPkljoo=;
 b=hSNgbYRZxhKJlp67EZ03JrkHJ2ljkVJO4X9dohfwymEVov8F67nOgv2yWIpwC88YgjPwcH
 B0LooMaXNOQ90qgmm5o5jN+6D2qcg1rfNJ1JprCi7nBGov5mhlGFxAc/53WJdkoFZMdjYi
 sra3de3DR+o7TD05awthiw0q+SlyPlc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-p4F0gNhpNQeBaQAeXLseBw-1; Wed, 27 May 2026 12:19:45 -0400
X-MC-Unique: p4F0gNhpNQeBaQAeXLseBw-1
X-Mimecast-MFC-AGG-ID: p4F0gNhpNQeBaQAeXLseBw_1779898784
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49047e9ca88so45310035e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898784; x=1780503584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWehKC6VzlOi12pDotLZu0gXRvyJlSMzVrHQdPkljoo=;
 b=KoqzCO6gFndGhEAvn+bKYNdctNUwWqXKygySL0dJmlDxiNRM/MTg/nN6BoaE5XKu9n
 /8FjYy2DUCk5/whOrjmRIuKIXWG1WU9oP/G/cufceE8LpPQaspBwzK0XiSSBFyKtaUYD
 f9ya0+motDrBtdexcVKB1HzE9taPmnZ9sNmM6n0F4sZtHlrLQn12/yK7oNMtjtU1bRlX
 QiZRIMF1svxYojPDzay+jLmx5uM0uHNPpKP+8N4vfnB/l4KdSCpAagaxHgJJfZgNHJ6o
 kQWOk+Jz06d+6B3VaOzz02rsccacKkij4qIE/NxYbO+vry8wcTEa9UCZg/rHxXf99R+H
 Bo3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y7TL12L7tw/gVs3ImnOp7sokEjwmtpebP78B6YPeEqc9higpV8vjc2g8tKu24Dgjd59cwcx4Y4epX@nongnu.org
X-Gm-Message-State: AOJu0YwGuUxwshsVwHBOnmh5mNL76CmGof9wCmFFL2NzmOujb6y7tWd9
 BDyo6fMVKhlno/QwMeAAxViqMM9vN+977QApzB83aSnADdEY6HzS3aQ11QBkgS8ZfVz7H4fv0xl
 ViaydVfWJGfMsi0UP1NzFjZjVK1AhEBazeVqBJhd5qQIml62G73TgIp/N
X-Gm-Gg: Acq92OHCfE4OdTYpkGXAqqw/3JKH3QvM+HmJot1F7Vj7ibeGzb509eu8cco/1qARe4w
 YWh9ZHjh0hvgACdvLgd/R72K/sx08Z0Rhg6jnq7S0e5tx/XAjpHZue1injcC16Y8itBcw3uOxml
 B9EXQXiQd6dj3lXyobP04y6dx0DiH/qX0GvYoy/nlFt1BpOBlMjfGkbI+7xauPtog6OLM5J5/Lu
 v30oFBXtRbKOAfRHwbFXEUvdHf7sunlLoz+GPxQLaMd9xs7Ct/pbCgqOr8nH6D9djJIT6t5GM2T
 jajtN06dvFMW5JLE3KT7wbS/AJ8KJUGXij9A7qL0JtL+/54zh+UVEGygEaL9/jnvmTpw/0U0gcm
 gXOjREludYeTDnFf457emz059MIIhi4dzhneBZMws1G0z1hk95LAMRWt8tn0w1Hwl8Qs9C5Xyz4
 uIuHk0
X-Received: by 2002:a05:600c:4746:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490469c56d6mr377120075e9.12.1779898784006; 
 Wed, 27 May 2026 09:19:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4746:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490469c56d6mr377119545e9.12.1779898783505; 
 Wed, 27 May 2026 09:19:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a198sm396774325e9.10.2026.05.27.09.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 09:19:43 -0700 (PDT)
Message-ID: <63a8bd66-c324-4d2f-9d6b-1ea35e72db5b@redhat.com>
Date: Wed, 27 May 2026 18:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/18] target/arm/kvm: Introduce
 kvm_arm_expose_idreg_properties
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-14-eric.auger@redhat.com>
 <3344B74E-39B1-421D-8417-373A688DB372@nutanix.com>
 <c4a38526-a803-4e69-b6ca-f6bf0583198a@redhat.com>
 <F50EB764-5F22-42AD-89E2-677BF7DB453B@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <F50EB764-5F22-42AD-89E2-677BF7DB453B@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 5/27/26 5:44 PM, Khushit Shah wrote:
>
>> On 27 May 2026, at 9:02 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> I replied separately to this on your series thread. I am inclined to do
>> so but this raises another problematic for the layered products to know
>> which mismatch can be fixed
>>
>> Thanks
>>
>> Eric
>>
>
> Hence the safe-value tags :), sneak peek to v2 of RFC, with safe-value tags.
> For each prop we can say:
>         ...
>         {
>             "name": "feat_RDM",
>             "supported-values": [
>                 "off",
>                 "on"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_ATOMIC",
>             "supported-values": [
>                 "off",
>                 "on"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_CRC32",
>             "supported-values": [
>                 "off",
>                 "on"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_SHA2",
>             "supported-values": [
>                 "off",
>                 "sha256",
>                 "sha512"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_SHA1",
>             "supported-values": [
>                 "off",
>                 "on"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_AES",
>             "supported-values": [
>                 "off",
>                 "aes",
>                 "pmull"
>             ],
>             "type": "string"
>         }
>         {
>             "name": "feat_NV",
>             "supported-values": [
>                 "0.0"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_RAS",
>             "supported-values": [
>                 "0.0",
>                 "1.0",
>                 "1.1_base"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_MPAM",
>             "supported-values": [
>                 "0.0"
>             ],
>             "type": "string"
>         },
>         {
>             "name": "feat_CSV2",
>             "supported-values": [
>                 "0.0",
>                 "1.0"
>             ],
>             "type": "string"
>         },
I am not sure what the above represents
>         …
>
>
> 	I am inclined to do so but this raises another problematic for the 	layered products to know which mismatch can be fixed
> 	
> I am tempted to make the same argument for writable fields: how will the
> layered products know which values are safe (or effectively can be set?)?
>
> I know right now we don’t agree on keeping safe-value tags or default values.
> But, I hope the above inclines you towards keeping those :) 

OK I think I now understand what you plan to do with safe_rule (which,
as far as I understand is not currently implemented in your v1). With a
"tool" like 

query-cpu-model-expansion you would be able to retrieve the host value. If it does not match your named model default value, you can use the safe_rule to see if it could be applied, without relying on any scratch vcpu instantiation. This makes sense in the context of providing ways for layered products to see which vcpu model can be used, assuming there is no other way like scratch vcpu instantiation.

Is that a correct understanding?

I think this implies that we need to return more information though query-cpu-model-expansion than what we currently do (at least in [1] we only return the value). We would need to return whether the prop value can apply on this host (its default value is same as host value or OK with regards to host value and safe rule and the ID reg field is writable). This most probably means we need to enhance the prop value to contain more fields.

Thoughts?

Eric



>
> Warm Regards,
> Khushit


