Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372F9CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScZF-0005Md-Lt; Thu, 28 May 2026 11:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wScZE-0005M2-Hn
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wScZC-0001uL-1n
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779981752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWiwiiY+LDiQr0yd8VQcVqBy0PYAtYZ/fqvE6dB6fvA=;
 b=jMrctJk+4UHyCJbcpDQlGCJoxcvLT596rYYTL6IoIwEqs4Ow+AqJAwBgHBOIEdrB0GGgdA
 7CfkobKV5lrQdFGMOx9f85XkFdkTzrdGZpPXXhA9HGdx7kTpi8ClaL+M41Mbwcs7NFpTx1
 OwVxqPrRXQYgoP2K78ka7m3080n/TUc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284--CGK_GJ5PuSxv2C-ArRYrQ-1; Thu, 28 May 2026 11:22:31 -0400
X-MC-Unique: -CGK_GJ5PuSxv2C-ArRYrQ-1
X-Mimecast-MFC-AGG-ID: -CGK_GJ5PuSxv2C-ArRYrQ_1779981750
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490261c79fcso49690875e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981750; x=1780586550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWiwiiY+LDiQr0yd8VQcVqBy0PYAtYZ/fqvE6dB6fvA=;
 b=bx7KJF5OctozCXOpU+iaAC/fUa2tGH1+nE7NsJzf5J60k3Ogcow1fyVUhvjttM1toi
 OOUEBfDe1bMfxiK15BzbIZnR6wx//d9LiBri15dSTHqKmSL7ZUwWahWKahbJKVA4O+/4
 KPIDR0AU9dVDu//LUvChSgQ+NZaAJPnZbtBWBurYb7wghOmJ4wOeuPRN2L3POTHmtQ3m
 J8P9kLxYbU3qFSX4CNu3iooTH44UO+Z4y8z4lCeeg0eQN+T8E9MYcpQjOJux5G5DXoOk
 sdugxvr95F3NEbAs5ShkhI2qHFmlRwLSQns/DMCnQe6eUZQ0zEiu5Uy+kSDfxRpHBfAo
 zlQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+InAQyOINo8zF/ThyHm7zM7x4LnuvEoeEBODOfo1ajSFo3SzTLMcwN4/WqUGVp8Byweu6OfI3WY9MW@nongnu.org
X-Gm-Message-State: AOJu0Yzy8OOar5K2zMpBkOaFbdLs+8TDhVGzhJ/oBf8E4fucYzvlcDw2
 CJmYzyLNXNEsyM63fy0VOmRTNQwNKK/byT56Kv/6AkFu9lBYr4ucSMwh0Ty88x24qZRWeq1Unsf
 T15XeJfvXAjlN5hrprHUWONIWcvQCx/ilfX559BXIZehiNyz/vucixDeV
X-Gm-Gg: Acq92OEBKtYZ0jdp8SiFVB/hkH19S646jjzfPTY1nPBlYokDLwV2iqTeze9vZscreVe
 +ybPJ/494+GxTell5yHxS2QyPowXBHD/mBydgyHFA2AQMhv5T9gt4navWguiicDcWPCcLFZTKjm
 Kfi8KY2s17/8DHRDoMmWW7t+o7f/T9ajmD/XQHqImsPorZ5r7EbGmUUse8yWYVMBihN33CtQJ9F
 VjQ/bPj6EMkLNsrqKKTJl1ejnqdP08oadohgTOmLGTfQ4CyP9tMSKgju6sApm273F/sfC0V0Du3
 4OQi5xAyrbtgEncTJNJsoYKv8eYcNibxcShJZw4ncSd3YdNMCbyRzKI3QFOAMCWDaM9VNbqHTXW
 dn7EQ50kv01LoZx+OXwwlDWLxnHnjT665A+rEzmiagtaR/3+10CPtKvbc/JZEHJHz83HEFP5Eq0
 NhxytI
X-Received: by 2002:a05:600c:528c:b0:490:3b8a:b0c with SMTP id
 5b1f17b1804b1-490947779d4mr37582395e9.3.1779981749922; 
 Thu, 28 May 2026 08:22:29 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:490:3b8a:b0c with SMTP id
 5b1f17b1804b1-490947779d4mr37581675e9.3.1779981749452; 
 Thu, 28 May 2026 08:22:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eed49f19bsm2222373f8f.14.2026.05.28.08.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:22:28 -0700 (PDT)
Message-ID: <294d4e4b-6ddf-412c-9a47-24aab232a2b8@redhat.com>
Date: Thu, 28 May 2026 17:22:27 +0200
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
 <63a8bd66-c324-4d2f-9d6b-1ea35e72db5b@redhat.com>
 <47CCCA9C-EE35-4314-9619-50F28BFFB0AD@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <47CCCA9C-EE35-4314-9619-50F28BFFB0AD@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/28/26 7:07 AM, Khushit Shah wrote:
>
>> On 27 May 2026, at 9:49 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>>
>>
>> On 5/27/26 5:44 PM, Khushit Shah wrote:
>>>> On 27 May 2026, at 9:02 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>> I replied separately to this on your series thread. I am inclined to do
>>>> so but this raises another problematic for the layered products to know
>>>> which mismatch can be fixed
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>
>>> Hence the safe-value tags :), sneak peek to v2 of RFC, with safe-value tags.
>>> For each prop we can say:
>>>        ...
>>>        {
>>>            "name": "feat_RDM",
>>>            "supported-values": [
>>>                "off",
>>>                "on"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_ATOMIC",
>>>            "supported-values": [
>>>                "off",
>>>                "on"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_CRC32",
>>>            "supported-values": [
>>>                "off",
>>>                "on"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_SHA2",
>>>            "supported-values": [
>>>                "off",
>>>                "sha256",
>>>                "sha512"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_SHA1",
>>>            "supported-values": [
>>>                "off",
>>>                "on"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_AES",
>>>            "supported-values": [
>>>                "off",
>>>                "aes",
>>>                "pmull"
>>>            ],
>>>            "type": "string"
>>>        }
>>>        {
>>>            "name": "feat_NV",
>>>            "supported-values": [
>>>                "0.0"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_RAS",
>>>            "supported-values": [
>>>                "0.0",
>>>                "1.0",
>>>                "1.1_base"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_MPAM",
>>>            "supported-values": [
>>>                "0.0"
>>>            ],
>>>            "type": "string"
>>>        },
>>>        {
>>>            "name": "feat_CSV2",
>>>            "supported-values": [
>>>                "0.0",
>>>                "1.0"
>>>            ],
>>>            "type": "string"
>>>        },
>> I am not sure what the above represents
> This is truncated output of similar qmp command as cpu-model-expansion, which returns for each prop what
> values can be set. For example MPAM is not writable by KVM, hence only one supported value “0.0”,
> CSV2 on the host is only “1.0” (architecturally, 2.0 is also valid), hence only “0.0” and “1.0” in the supported values.
>
>>>        …
>>>
>>>
>>> I am inclined to do so but this raises another problematic for the layered products to know which mismatch can be fixed
>>>
>>> I am tempted to make the same argument for writable fields: how will the
>>> layered products know which values are safe (or effectively can be set?)?
>>>
>>> I know right now we don’t agree on keeping safe-value tags or default values.
>>> But, I hope the above inclines you towards keeping those :)
>> OK I think I now understand what you plan to do with safe_rule (which,
>> as far as I understand is not currently implemented in your v1). With a
>> "tool" like 
> Yes not implemented in v1.
>
>> query-cpu-model-expansion you would be able to retrieve the host value. If it does not match your named model default value, you can use the safe_rule to see if it could be applied, without relying on any scratch vcpu instantiation. This makes sense in the context of providing ways for layered products to see which vcpu model can be used, assuming there is no other way like scratch vcpu instantiation.
>>
>> Is that a correct understanding?
> Yes!!! 
>
>> I think this implies that we need to return more information though query-cpu-model-expansion than what we currently do (at least in [1] we only return the value). We would need to return whether the prop value can apply on this host (its default value is same as host value or OK with regards to host value and safe rule and the ID reg field is writable). This most probably means we need to enhance the prop value to contain more fields.

I imagined we could return all the data
through query-cpu-model-expansion but it seems you plan to use another
qmp cmd. Let's see what it looks like in your v2

Thanks

Eric
> Sorry, did not fully understand this.
>
> Warm Regards,
> Khushit
>
>> Thoughts?
>>
>> Eric
>>
>>
>>
>>> Warm Regards,
>>> Khushit


