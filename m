Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87BBEE36A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqa8q-0001ZI-Aq; Thu, 12 Feb 2026 12:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqa8o-0001V8-FR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqa8m-0008Of-Qe
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770915966;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSOaLWuingcRSym2iM0y3zd9G1wL2md46WyRDQEzups=;
 b=erURcZLq0KBWT0sScel+d/UP2MCe9ngT+awZ3pLhr7yma2OypS1bH+5S5jxXN5Ysxotcb4
 bRzcsxmOQyxBKvemRXwsMcVfeKFUpWOFgF1271f/1Ml4u5ulIooLgsf1ZDTFJLNvcakLq3
 qclCmoR945ppHJQn9qfOJvCQxmvwwbQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-qjkWE9VIOraUw-ojQ2EXbg-1; Thu, 12 Feb 2026 12:06:02 -0500
X-MC-Unique: qjkWE9VIOraUw-ojQ2EXbg-1
X-Mimecast-MFC-AGG-ID: qjkWE9VIOraUw-ojQ2EXbg_1770915961
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-65811f8a102so7344436a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 09:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770915961; x=1771520761;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSOaLWuingcRSym2iM0y3zd9G1wL2md46WyRDQEzups=;
 b=U5rtwejF9lRliCYe/dVuUgwa7TTCb99pULc9+GeXJM61KufzcqtxQzdUOvU72cXNNZ
 ZjnAXIyHK4ViurO9YpgMexULsa6orePUL1lAw/dhlAMZCE4R4hcswBbI3ku4P2z74QvR
 9RXsPH1ge4PH8dv14raLDmN9900+qUyd3ptQVS8yofXNO23id2xPZdCrGWbkB18vU/VR
 B2h5q8+bU/Avas6yLzQt8uKAj84e6DNwEsAYFTpN++NmaSKrrFiKqBKjhjEHPJokWBY9
 OxXWMeQs2BOcIbGxclH75wXZBR47bC4DQjLQ/u7vE6g3leu7kR40Dgm4Ll1HZaqeMJwE
 cqAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU55g60od1EH/thZKgECKp8SniJzu2R7iL1G8/kYIcoVVKv1IxDML5cXHXrxeT9BjnKI66kqk14Am56@nongnu.org
X-Gm-Message-State: AOJu0Yx889/cP269U8Re1/2M2/sNvou1Rg878BoFblrZD+3GXzjCPo2b
 bbu45rEE+0HRJtqaPbNk4ubTRlC4fc1bgC9G8keKpOGDzdPnKiyKwl1lWWtKbgwNeTBqgWSiAC+
 ORMgsweKip330dawcLOSzRvCc313YZlnq+goIzVMTwdep+KysmVd/7wM5
X-Gm-Gg: AZuq6aKVJBC+sGYHSBanET6ScOtXQ9qC9e57EuroZnWmc8VwUbByC5PG62Lzw9sNj+P
 ShACl8+t3RnbDfpritHCd8+zi3i7Lry0Q4Gr1eqjBmBQaW2r6iUiCtE4mvsb3QfItmqKbRX+ama
 fZIeTpfe3D0hMwVDf6rvpyHPUWsuGEPvp0QGpBNrcI7kYIKm9173f8JfKE+PLRxdEpyZAtQ2uJn
 c0nt+ey1WXlIPQixt0aq02sWx4qZNW0kBLwa3482H7Bo7xR9UkuY4eWgZKMXfOgCI2iQUfiWIWx
 VaWuGO2SKoXDix4w9GVZBIE83f6eWzcebxUoyGooKVMoCHbfaifRI+tJObKycV2+k00NFFcZRJQ
 vIJ0gAyUflVGTyz0SdZ1ER+0IE7cyGoCQ/Y7YzbhUfCzxcPAq6mILF39CbOqfGDCLRTWYYQ==
X-Received: by 2002:a05:6402:42c9:b0:658:177a:292 with SMTP id
 4fb4d7f45d1cf-65b96e1b9d8mr1999650a12.17.1770915961192; 
 Thu, 12 Feb 2026 09:06:01 -0800 (PST)
X-Received: by 2002:a05:6402:42c9:b0:658:177a:292 with SMTP id
 4fb4d7f45d1cf-65b96e1b9d8mr1999617a12.17.1770915960705; 
 Thu, 12 Feb 2026 09:06:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65a3cf50e38sm1867700a12.33.2026.02.12.09.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 09:06:00 -0800 (PST)
Message-ID: <7af8156e-4874-4cab-b71a-c39c56aa59c0@redhat.com>
Date: Thu, 12 Feb 2026 18:05:58 +0100
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
 <ef13c99e-29b3-47cf-a090-811294e723e0@redhat.com>
 <CH3PR12MB75481019FE5FEB62BCE96D58AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75481019FE5FEB62BCE96D58AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 2/12/26 4:47 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 12 February 2026 15:35
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
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/12/26 4:05 PM, Shameer Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: 12 February 2026 14:57
>>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Nicolin Chen
>>>> <nicolinc@nvidia.com>
>>>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>>>> peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nathan
>> Chen
>>>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
>>>> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
>>>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>>>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
>>>> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV
>> ops
>>>> interface
>>>>>> I had
>>>>>> the impression you reverted to a fallback impl. If there is
>>>>>> specialization, I still think ops are relevant. Eric
>>>>> There is no fallback implementation. So just to confirm, you are suggesting
>>>>> to remove the ops completely or just keep the ops for reset/init only?
>>>> Depends on the code to come next. If your reset and init really differs
>>>> between normal accel SMMU and vcmdq enhanced accel SMMU, to me it is
>>>> still relevant to have separate implementations in different callbacks.
>>> It is not an either/or case.
>>>
>>> The vCMDQ path does not replace the normal accelerated SMMU init/reset.
>>> Instead, it requires additional init/reset steps on top of the regular accel flow.
>>>
>>> if (accel)
>>>     accel_init();
>>>
>>> if (accel && cmdqv)
>>>     cmdqv_init();
>>>
>>> So the vCMDQ logic is an extension of the accelerated mode, not a fallback
>>> or alternative implementation.
>>>
>>> I think the later patches in the series make this clearer.
>>> Please let me know if you still feel the ops necessary.
>> do we have any way to introspect from the kernel what cmdq type we have,
>> so that we could have a cmdqv option with ON/OFF/AUTO value instead of
>> duplication cmdq option for each vendor?
> Looking at it again, I think we can, by calling IOMMU_GET_HW_INFO with all supported 
> CMDQ types and check which one succeeds.

then I think we should endeavour doing that. Regarding the ops, if you
feel that reset/init can be managed through a simple add-on code I am
fine with it. Maybe Cédric or Peter will have another opinion though ;-)

Eric
>
> Thanks,
> Shameer
>
>


