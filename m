Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A49EE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYir-0002lO-0s; Thu, 12 Feb 2026 10:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqYip-0002jP-1p
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqYin-0003O2-K1
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770910512;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KD0DUPsT/ogPTGMRO4qfDsgytWowuXfUh9PkIdHYmKw=;
 b=ASVe/M5En3mUvgZFwGXeEVr3+BI5YFEfh0YX9QiUA2e27duoStKw3Ylvf5XPaAHmfFf1R7
 Y6JM3BJPVMnsragUaBqzbnVJGe3gc/MjTah4ZA9qeVJ+TUzJcx6XrVMqRy9TIey+I9Oe8g
 VnGSh6bfaHJsvhDWSVf7oXg7KUEoVf8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-1huG-OWLPM2M4vRmunqq0A-1; Thu, 12 Feb 2026 10:35:09 -0500
X-MC-Unique: 1huG-OWLPM2M4vRmunqq0A-1
X-Mimecast-MFC-AGG-ID: 1huG-OWLPM2M4vRmunqq0A_1770910508
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4358f90fe8dso1466957f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770910508; x=1771515308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KD0DUPsT/ogPTGMRO4qfDsgytWowuXfUh9PkIdHYmKw=;
 b=xKKOsL1fCW7iIuE4PIkIeBrIt+jb26QgYGUOGltwo/JWpOtWPV7OgzGkNdBkSrtZMB
 z67PZjp3Usnk3zBZBBlut87F4VWaLepQ/+Jf48XY6yAe/LpZlZFplsKrwjjB/ZUFYOrc
 YJb9/vvoWCGzWu6yC48AFDOZxnTobGT+1kGhdXu/YM/milOrzUlwKYwP2jRWxHbw+3bn
 H0aHplz0j4HSRhYPAXJKhO3Xe+zFXVVEs1bhy3bhpa92Cem4XYtz6RgnejznCnLNwBCA
 beWBKHUiRN6KzbHxHLFP1l1FZCcRl6AMxvRhNol3KDV2f1rtd3bcoX+FSsDJxPHSkqny
 y0Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0xgFN7b2onMEUl0sFRB+xjYs5vMAFNjaq6zgy3C6nQwb1Xt4eR7K29y3IjnVWP7N6GgXVDAzgolP+@nongnu.org
X-Gm-Message-State: AOJu0YyGt5nrX/FcA+jlxUWOvgB6ZsgCSkGOyO4FRfll/qz6+DhM8MGQ
 oHCo8IutkMo/P4w1VexXEvE7+JhDj6NkAJ22gr5uV47udNDyHHyuGXEQNuOrM1stFT6QaE71YRY
 au308fnsBPHez2kg0KZvJhdpQwfvPLXWbzk6jxbH5hahxcgoMkSWPljo0
X-Gm-Gg: AZuq6aILB04+PFfvW1dYhcFQqW2NhHd20paBOS8MQLVjSkn6Rw/8V5k6srcm/AsegGW
 ahdRirYTJLTA5L4kEpJtQ50I8ROZ1FiBk+NyXptqIAIYReuti8NPL4Slhkh2W/AXlSp1Yk1SMG5
 n85hQn9b61NNOKT5h6t1Ty83KB1S8CnTtQImGd0FOlr8pda1qSKCqu3iY+rH+epxHWJkqtWR7U0
 9F8HbXd4ElCb36X5dk9RmiOvho+hH7pnu5rx5o2+gpdcv2gbw+DqRBe9poC6fClZFnmZAbpG279
 GIbheLbPGGLbxWsiURcM3DpkXDK//7uuGRJSIOQoTwo7VVvxC6LKpBQOmQNNvXRbuL6xp9xTWqC
 bBtCz10wXmyG0vnQGuuRHGL/X8iVImrwwBv1rnDPWWi3bP1G/wAEtVogVPMxFAHyZ6LDf/Q==
X-Received: by 2002:a05:6000:1883:b0:437:7300:eb1c with SMTP id
 ffacd0b85a97d-4378e73ac8fmr5191572f8f.26.1770910508231; 
 Thu, 12 Feb 2026 07:35:08 -0800 (PST)
X-Received: by 2002:a05:6000:1883:b0:437:7300:eb1c with SMTP id
 ffacd0b85a97d-4378e73ac8fmr5191511f8f.26.1770910507780; 
 Thu, 12 Feb 2026 07:35:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e39c6asm12442140f8f.28.2026.02.12.07.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:35:07 -0800 (PST)
Message-ID: <ef13c99e-29b3-47cf-a090-811294e723e0@redhat.com>
Date: Thu, 12 Feb 2026 16:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
 <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
 <CH3PR12MB7548A87A5BC62C6D90501947AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548A87A5BC62C6D90501947AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2/12/26 4:05 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 12 February 2026 14:57
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Nicolin Chen
>> <nicolinc@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
>> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
>> interface
>>>> I had
>>>> the impression you reverted to a fallback impl. If there is
>>>> specialization, I still think ops are relevant. Eric
>>> There is no fallback implementation. So just to confirm, you are suggesting
>>> to remove the ops completely or just keep the ops for reset/init only?
>> Depends on the code to come next. If your reset and init really differs
>> between normal accel SMMU and vcmdq enhanced accel SMMU, to me it is
>> still relevant to have separate implementations in different callbacks.
> It is not an either/or case.
>
> The vCMDQ path does not replace the normal accelerated SMMU init/reset.
> Instead, it requires additional init/reset steps on top of the regular accel flow.
>
> if (accel)
>     accel_init();
>
> if (accel && cmdqv)
>     cmdqv_init();   
>  
> So the vCMDQ logic is an extension of the accelerated mode, not a fallback
> or alternative implementation.
>
> I think the later patches in the series make this clearer.
> Please let me know if you still feel the ops necessary.

do we have any way to introspect from the kernel what cmdq type we have,
so that we could have a cmdqv option with ON/OFF/AUTO value instead of
duplication cmdq option for each vendor?

Eric
>
> Thanks,
> Shameer


