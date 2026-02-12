Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09B9EEA84A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbsM-0002cH-6Z; Thu, 12 Feb 2026 13:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqbsK-0002bO-Ql
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqbsI-0004xY-HG
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIDIJX0tRI/GboZIbqLyZDHS7CmPYsxtAqtgGplFOkI=;
 b=MAUy3zCnE3w7je+HeyiRvsFnAkcTteqgFdE9ro2AJe5vjF1WmP/6im1evyWMQMk9y0xk39
 s7kLy5z3lccPAd03VxYqYirMsbjZgO2xVRtMEEozOBfS2NFndEtk3WD4c0ECsXCbXy7oCg
 BcXUKTwC8ySL1DJ0eTFE5WzRZFwcWSo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Z6L4dIcDMyOGjj6bQS9LTg-1; Thu, 12 Feb 2026 13:57:11 -0500
X-MC-Unique: Z6L4dIcDMyOGjj6bQS9LTg-1
X-Mimecast-MFC-AGG-ID: Z6L4dIcDMyOGjj6bQS9LTg_1770922630
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-480686b3b4cso1956515e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 10:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770922630; x=1771527430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIDIJX0tRI/GboZIbqLyZDHS7CmPYsxtAqtgGplFOkI=;
 b=r4AMGh3CXkAcYEEBjZeQdOx9O6rus8X/VzkmjzY+BBtXCDKNQLDAGVFBteIm5ksPEC
 nk44u505G4SE5y3uCGSLEEKfljlwlAPU9SzMJDYdH+7wM1b4p5G9Mv5wUuOmnyO6YJ7R
 Ky2DFgg8mTNXg907S5fvgEebGByADlAHpW24Evu+zzjf3uEfbdDC7hDVON7QNSlifLDb
 7g8qN6YZWWyXXJmIdOexMpKJgUOY6o0KU75yTiHEhDhkbdfFyCyVwSxhtBibD5xiWJF5
 8GEabeTLYXbrIWi4XlieTpO8LzpMeCug7/TSUIEv4LTJTUKohh2JYoMbw+jskz9g0npr
 Fghg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpKTOg6vu7J5zJP5tX04wT1dF2a5QcxQFqSkfLk1V6jvNut8bmJqQt/+mxjrHFclvYzMCjd8KDANmN@nongnu.org
X-Gm-Message-State: AOJu0YxB1oJ19ryhuIcpTXKnAu+OEA7jDZRg4jwYDh21G43D3cZ6Z7M9
 AIKJcKF46bxiSc8GFJOWAcZPhOnomTk5p9I5PigbTX5kp9CKQQpHrIvxQ/489LLGN/ATo86LtUk
 j58e2T2QbU9bYBbIUyoqAwL4d281EyAXJG+E//mMbnaLuuTzFQp9PVYGI
X-Gm-Gg: AZuq6aLeufGHv5k3HLkllbjHDEp8JcbsE0MCSz6KH9wmduLyQ0Yq9G83E74VZ/LGh0h
 M6ycW+SBLcqBiB3C97GPsgk/FEUVr8VlWLLd3OAvpr7QuN93XpX+NxqB6F9IZJWWyKRKw9SWr4k
 t21z8AqwL0dNto9NqxbGrj4wv2f2QWIKNG3d4pLJ/Qx7pFCAoz0JdUktavz08WwVe1DESgtAGmO
 2SC7xjEnDfMuSEe5xy8mFecv931OZTNu0PffpL2bwQXhz7LqHkJHe2Tq6Wq2DMqFR0k66HWm48P
 0vcX5dazzQ6GLm4M7aievOvUcHgk7rY2HID7JuWzQe3AcP8//ST0KJ1YWLZw+2RT3IYkB0oF/zV
 SM6bmXdcfxjMjvDr3eaPtQ3ZRhTFRmtbwugfjzhgv5Qg3PyekQlMXyXkHagpfQXwWDDRMCA==
X-Received: by 2002:a05:600c:3b19:b0:480:6b76:dfb4 with SMTP id
 5b1f17b1804b1-48370e18708mr2382785e9.8.1770922630154; 
 Thu, 12 Feb 2026 10:57:10 -0800 (PST)
X-Received: by 2002:a05:600c:3b19:b0:480:6b76:dfb4 with SMTP id
 5b1f17b1804b1-48370e18708mr2382345e9.8.1770922629696; 
 Thu, 12 Feb 2026 10:57:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d34657sm16274631f8f.6.2026.02.12.10.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 10:57:09 -0800 (PST)
Message-ID: <b1cf54c0-d8a0-47a7-bd67-f3773fe1a52b@redhat.com>
Date: Thu, 12 Feb 2026 19:57:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
 poroperty
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-23-skolothumtho@nvidia.com>
 <6c4468e1-85e5-4d3e-9b4d-6710aac202a2@redhat.com>
 <CH3PR12MB7548BFE35E11F407DC3AAC8DAB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548BFE35E11F407DC3AAC8DAB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2/12/26 7:53 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 12 February 2026 18:30
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>
>> Subject: Re: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
>> poroperty
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/6/26 3:48 PM, Shameer Kolothum wrote:
>>> Add an "identifier" property to the SMMUv3 device and use it when
>>> building the ACPI IORT SMMUv3 node Identifier field.
>>>
>>> This avoids relying on enumeration order and provides a stable
>>> per-device identifier. This is useful when we add support for
>>> Tegra241 CMDQV DSDT in subsequent patch.
>>>
>>> No functional change intended.
>> I think an important info which is missing here is you need the id used
>> in IORT and DSDT to be the same, is that correct
> Yes. That is correct. I think I have that explanation in next patch. I will
> mention it here as well.
>> By the way why can't you reuse the QOM id. I think Dan said there is one
>> for all QOM objects.
> Yes. QOM device has a global id. But I am not sure we can use that here.
> For one it is a "char *" and normally user or management layers will use
> That,
> eg:
> -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1-pxb1,
oh yes you're correct. Forget about it

Eric
>
> Thanks,
> Shameer
>


