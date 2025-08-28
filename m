Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6295ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOgo-0004Az-J5; Sat, 30 Aug 2025 12:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1urkVM-0002S5-2H
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1urkVJ-0005wS-K0
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756417792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hy2Eqa5e4kKCgSZdk2bsVic2iFTrRLnMw2i5Yj3vwXg=;
 b=Txnf/pBiRyeGWQlQsji058YrywYQwEJl+V1JIY5rVLAAzNk7o3TKwt+/s33dTsVcweqCfJ
 zZ4lAtd0klai2W2owMSlFLnQs9iJZaIxau92HgQSIriA8P8pXawmTZUHBn8S+BmZuTveMr
 9x/4oYFd1DxacMQcX5WHwTeh9oh5z0s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-UqJQmqQRO16cfuHByb1oKA-1; Thu, 28 Aug 2025 17:49:50 -0400
X-MC-Unique: UqJQmqQRO16cfuHByb1oKA-1
X-Mimecast-MFC-AGG-ID: UqJQmqQRO16cfuHByb1oKA_1756417790
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7f95f65400fso344520985a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756417790; x=1757022590;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hy2Eqa5e4kKCgSZdk2bsVic2iFTrRLnMw2i5Yj3vwXg=;
 b=rK3M+fYhPYDwwyT1pVurxTPgUrSZsBEehNpiCWrE3xY5hU3B2C1UmjsDtn4TGPP7oE
 eNirhkXDoTKyGY6xAnuJdHR15oWPJj6ec4gkMV9BgKgeaPlBcNbb1l2tf6PZu635FeoY
 b8lcpQzmGCRwbhjL9aizgY0cNlTEswDcm3Lf4qnYJDlK+Mni4CFAvlixY1D063Q6dywj
 P2V/QoMIuIN2fddcie6cL4SukHF73Nd0qBK0a1ApDOUWX4RhgH//xjiq9iXDECQ67dpo
 LBm6qXrtxyaLELMeQjEA2etaH5e3ptCPo18EuRBye8odgsXEi90Prt08A/wueRRImWsR
 QG1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2H1Y9+dKbEv3MLv0ZbMxVRbvkxu8EmuhajXP36MmXDOiVns4UviJwwO+ey/6PATo3xVP1JNlZoweP@nongnu.org
X-Gm-Message-State: AOJu0YyvWtgATXyuxoRhlXjdO6bV39tWgUwyHsfpEFHmwqGQU6DEfi1V
 lWVkY+veRCrGcjLfW08uZ6FtSCPtt38x2QgJ42J1JwuXTyR2prGnUSPD8MCe0b4v+siNyowWPXO
 o/BC+ilZyFrTBT9E28DVE5UXN5piNTZkr11/0e+MuvaE5NsoA7lqIUKqd
X-Gm-Gg: ASbGnctrrfePGivWjo03HYFpS+5+rbb54Hcu++/7q/P9fYDtNelkZv1U0FU/X1XsicW
 FtySGhb36zL8WKfkQJ5TpndyALwc9BbfdwhVYjuweyGPxFZrD15YSGQ2LAGb09vl1FkGwatmmkJ
 XXKMu+9Wt368mQRWKB86/C1Tl36/rdXt7JA8VvtSQGmPv7lKuy6zhWj1Ur7eypBskAvbiPpAYYm
 z3wV255kvN+DreH4dMGBkon+JudhwMGKrM2hqPMJattV+LNAkIpeeGi2w6iPvJ0ZRzNci+CiJBg
 x78oRdYdbFDTQTE6LH63KyBc9WlFvy5Tq0EE8M5Pu1JVttyE+XTdWyakHy2ZJgwW69XMcbxjUa5
 caw==
X-Received: by 2002:a05:620a:17a4:b0:7fb:2cac:9e68 with SMTP id
 af79cd13be357-7fb2caca0dfmr300239185a.38.1756417789948; 
 Thu, 28 Aug 2025 14:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo8evOCGdEXqiYvkHeub8lXsFJkopO4pdNZ8o924b4PMeQ+II4wBXvRKPhHht8V9d3BlPkCA==
X-Received: by 2002:a05:620a:17a4:b0:7fb:2cac:9e68 with SMTP id
 af79cd13be357-7fb2caca0dfmr300236385a.38.1756417789526; 
 Thu, 28 Aug 2025 14:49:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc14478510sm58199285a.35.2025.08.28.14.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:49:49 -0700 (PDT)
Message-ID: <3456f764-616b-412c-839c-aaef4bf1e47c@redhat.com>
Date: Thu, 28 Aug 2025 23:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Access to remote XIVE2 units (was Re: [PATCH v9 0/7] Power11
 support for QEMU [PowerNV])
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 gautam@linux.ibm.com, Ganesh Goudar <ganeshgr@linux.ibm.com>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
 <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
 <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
 <wdkarichs5jrmpz3k4gxosw42dt6qxwodnc6t6tcuecsmxgqcd@km4q644fiixb>
 <04eb08b6-b787-47f3-86b7-b2d3a0f50ed6@redhat.com>
 <utzcz3bpixqmviolacg7qv2f526tedqovvx6wcrl6ypk3v4v7w@nmjtwot6lhjs>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <utzcz3bpixqmviolacg7qv2f526tedqovvx6wcrl6ypk3v4v7w@nmjtwot6lhjs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/28/25 14:04, Aditya Gupta wrote:
> + Ganesh
> 
> On 25/08/10 02:46PM, Cédric Le Goater wrote:
>> + Glenn
>> + Gautam
>>
>> On 8/10/25 12:45, Aditya Gupta wrote:
>>> On 25/08/10 12:26PM, Aditya Gupta wrote:
>>>>> <...snip...>
>>>>
>>>> About the error, seems xive2 always expecting powernv10 chip, I will
>>>> have to rethink how should I use the same xive2 for powernv11.
>>>>
>>>
>>> There's a type cast to Pnv10Chip in 'pnv_xive2_get_remote'.
>>> The cast is only temporarily used to get the 'PnvXive2' object in the
>>> Pnv10Chip.
>>> It's the only place in hw/intc/pnv_xive2.c assuming Pnv10Chip object.
>>>
>>> Thinking to have a helper function to just return the 'PnvXive2' object
>>> inside the chip, given a 'PnvChip'.
>>>
>>> Or the below change where we are adding another pointer in PnvChipClass:
>>>
>>>       diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>>>       index e019cad5c14c..9832be5fd297 100644
>>>       --- a/hw/intc/pnv_xive2.c
>>>       +++ b/hw/intc/pnv_xive2.c
>>>       @@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
>>>            int i;
>>>            for (i = 0; i < pnv->num_chips; i++) {
>>>       -        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
>>>       -        PnvXive2 *xive = &chip10->xive;
>>>       +        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
>>>       +        PnvXive2 *xive = k->intc_get(pnv->chips[i]);
>>>                /*
>>>                 * Is this the XIVE matching the forwarded VSD address is for this
>>>
>>> Which one do you suggest ? Or should I look for another way ?
>>>
>>> I am preferring the first way to have a helper, but both ways look hacky.
>>
>> Any call to qdev_get_machine() in device model is at best
>> a modeling shortcut, most likely it is a hack :
>>
>>    /*
>>     * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
>>     * scan of all the chips INT controller is good enough.
>>     */
>>
>> So all these calls are suspicious :
>>
>>    $ git grep qdev_get_machine hw/*/*pnv*
>>    hw/intc/pnv_xive2.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>    hw/pci-host/pnv_phb.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>    hw/pci-host/pnv_phb3.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>    hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>    hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>    hw/ppc/pnv_lpc.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>
>> In the particular case of XIVE2, the solution is to rework
>> pnv_xive2_get_remote() like it was for P9. See b68147b7a5bf
>> ("ppc/xive: Add support for the PC MMIOs").
>>
> 
> Hi Cedric,
> 
> While I am working with XIVE engineers to get the pnv_xive2_get_remote()
> reworked as suggested (since it's a bit more work due to multiple cases
> of indirect/direct vst, nvg/nvc types in case of XIVE2), I would like
> to propose below patch to have as an interim solution to unblock
> the PowerNV11 support patches.

pHyp is an unknown FW implementation for opensource. Until an image
is released somewhere (please think about it), QEMU has nothing to
worry about other than supporting OPAL.

For now, let's forget about the grouping aspect of XIVE2, simply
rework pnv_xive2_get_remote() as it was done in b68147b7a5bf for
XIVE. This shouldn't take long. And, for the nvg/nvc types, report
an error of some sort and add a TODO in the code.

> 
> Please let me know if it looks good to you.

It's a hack. So please try the above first.


Thanks,

C.


