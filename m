Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F44E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 10:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLg3o-0007zV-LO; Thu, 12 Dec 2024 05:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tLg3l-0007yC-NP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tLg3i-0000I1-L0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733997877;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xuef9j19a6S4cy5t3jz7hMtr1tGA8HyHJRgE1u6fNo8=;
 b=CXq1HPKvk7OtffVY7smyrWYhdthDjDJVxxk14cWX6kJoKwxBrXqy17seXnKaJfZn765k1Y
 rSpnD0qR1zUkyTewM0rpmzeMqqLffqr24aBUH8MZqoua1ikG0OHGNR04e5zS13RdIwKcxC
 AUgVlME45KKKdjHAESaNWmA8Fnz0/wc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-rgGy8A3kNbKYwdy4p4rykQ-1; Thu, 12 Dec 2024 05:04:36 -0500
X-MC-Unique: rgGy8A3kNbKYwdy4p4rykQ-1
X-Mimecast-MFC-AGG-ID: rgGy8A3kNbKYwdy4p4rykQ
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f51b49e5so8765436d6.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 02:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733997876; x=1734602676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xuef9j19a6S4cy5t3jz7hMtr1tGA8HyHJRgE1u6fNo8=;
 b=GIa7ISWwjt3hjkPVfVDtWOoXjyNS8HQCdVPrKivaaoNr7cAc0HtR338Lch8UiIKr+d
 x12oJBhPuec8cgLrSk6Rpuzzo2FVaEkXkTzRf4DM7sPVvdi64nYzO7icryIGR5AuuLoC
 z4DnJ2ggHzgiMIdaUetbsO7sC++YnZabgR4iaQvNjwwhdRqJonhcRxwgnD+1ilQbbmM+
 Vfbh5vcTJhgbaUlvGT795DqxGXXipGV/G4gCYSpmqal2oGZ3/A/6nJDXEGJbfTRSXVyx
 Ae1O8QSHdobHXmSynLCVD/AWhhR/5w3RATBN0w9Aoeclxo4rYEs5HjSMHbLkcn5swDzz
 0/Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+1ZSx7OTs/2D4Z+jI0oM3MheKE5YT9T6OvjkRMSk4sesYqB6ocXhzHfOgt+9LqL8ZIyEQ6UanMioq@nongnu.org
X-Gm-Message-State: AOJu0YxlSU6u7AEXI5Y4O1+OC/rfLXCRuiABTAa9XtWpksYh/50E+Dez
 R5L0D6Y80i8Iv8fnshqjJcKzOeWjNJJFtYk+OuRP+6ei8jyfvbUeet2a/nYGEun4rNIoylkIKB0
 A/vuWZp7jPC6Y8CEFlw3OXrYii3fQHLBMKFcEcbd+af6HPc9D5Vs5
X-Gm-Gg: ASbGncuD6lRJxILwK3+UexuGRidZ+/vrxMUs18Zp5Y9QvWTDlsnmhVwfAcN7MF6PqQX
 UcTuf127fzXa/OdMreyVCxNkkE835ZcKLbIXS0P/otFgtExb5+qzl0GFeoRufS4pCkoHnsufzCY
 rtPOiloeCn/+/kFLHH9aPXUta4IOIV8F1vbmIku4866DQ12YEAOiShKoD9fzSJ/p4CwIHxUbck/
 Xu9wTGpoVwsi/6UsnLH9IooJAVyjorOjYCIV4s1PYMfcRIU7vsXyMh9lPVJj47gLX+ErYlvBwn7
 jBL1w1dcJWmz9pzVhMTuP2LUTwiy
X-Received: by 2002:ad4:5748:0:b0:6d8:959b:c307 with SMTP id
 6a1803df08f44-6dae38dd832mr47255806d6.10.1733997875843; 
 Thu, 12 Dec 2024 02:04:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF3KTyI2FwWZR0PYcTNWutT+SOIZjlczitRUUPCpTiP/v5+N6XDYRHA8yRBfMoXEZbgHkVOw==
X-Received: by 2002:ad4:5748:0:b0:6d8:959b:c307 with SMTP id
 6a1803df08f44-6dae38dd832mr47255336d6.10.1733997875470; 
 Thu, 12 Dec 2024 02:04:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d9162133aasm39276806d6.129.2024.12.12.02.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 02:04:34 -0800 (PST)
Message-ID: <1fea79e4-7a31-4592-8495-7b18cd82d02b@redhat.com>
Date: Thu, 12 Dec 2024 11:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
 <Z1qoa8yXscTSAJ9e@redhat.com> <8734it1bv6.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <8734it1bv6.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 12/12/24 10:36, Cornelia Huck wrote:
> On Thu, Dec 12 2024, Daniel P. Berrangé <berrange@redhat.com> wrote:
>
>> On Thu, Dec 12, 2024 at 09:12:33AM +0100, Eric Auger wrote:
>>> Connie,
>>>
>>> On 12/6/24 12:21, Cornelia Huck wrote:
>>>> A respin/update on the aarch64 KVM cpu models. Also available at
>>>> gitlab.com/cohuck/qemu arm-cpu-model-rfcv2
>> snip
>>
>>> From a named model point of view, since I do not see much traction
>>> upstream besides Red Hat use cases, targetting ARM spec revision
>>> baselines may be overkill. Personally I would try to focus on above
>>> models: AltraMax, AmpereOne, Grace, ... Or maybe the ARM cores they may
>>> be derived from.
>> If we target modelling of vendor named CPU models, then beware that
>> we're opening the door to an very large set (potentially unbounded)
>> of named CPU models over time. If we target ARM spec baselines then
>> the set of named CPU models is fairly modest and grows slowly.
>>
>> Including ARM spec baselines will probably reduce the demand for
>> adding vendor specific named models, though I expect we'll still
>> end up wanting some, or possibly even many.
>>
>> Having some common baseline models is likely useful for mgmt
>> applications in other ways though.
>>
>> Consider you mgmt app wants to set a CPU model that's common across
>> heterogeneous hardware. They don't neccessarily want/need to be
>> able to live migrate between heterogeneous CPUs, but for simplicity
>> of configuration desire to set a single named CPU across all guests,
>> irrespective of what host hey are launched on. The ARM spec baseline
>> named models would give you that config simplicity.
> If we use architecture extensions (i.e. Armv8.x/9.x) as baseline, I'm
> seeing some drawbacks:
> - a lot of work before we can address some specific use cases
> - old models can get new optional features
> - a specific cpu might have a huge set of optional features on top of
>   the baseline model
>
> Using a reference core such as Neoverse-V2 probably makes more sense
> (easier to get started, less feature diff?) It would still make a good
> starting point for a simple config.
>
Actually from a dev point of view I am not sure it changes much to have
either ARM spec rev baseline or CPU ref core named model.

One remark is that if you look at
https://developer.arm.com/documentation/109697/2024_09?lang=en
you will see there are quite a lot of spec revisions and quite a few of
them are actually meaningful in the light of currently avaiable and
relevant HW we want to address. What I would like to avoid is to be
obliged to look at all of them in a generic manner while we just want to
address few cpu ref models.

Also starting from the ARM spec rev baseline the end-user may need to
add more feature opt-ins to be close to a specific cpu model. So I
foresee extra complexity for the end-user.

But again I from a dev pov it shouldn't change much and we should end up
with a proto that illustrates the working model

Eric


