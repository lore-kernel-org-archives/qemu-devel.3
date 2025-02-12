Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B7C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGX7-0007kS-0k; Wed, 12 Feb 2025 12:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiGX4-0007jz-Ki
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiGX1-0003UF-Hz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dAeB2sjmO1LspadXAmgkFq1LNAylM/GkDoXEOqI4veI=;
 b=Bu5t60GmAEsdjjuEP63dqs70c+dfJK5MzeHD73wVxxVL3KjaJWArlZaRsRYXgqVQwuqxCo
 7O/gynDCKO5hG4xph/B5vkEtUskxrB3fdD4CJiK5cyEhKMCPmvMescnMTDDyhD9F5Hoj2A
 atEFipBCOiI3tvBte90WnWdAmAiMiS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-gjA6OX_kNuy8SG5uoPxDnA-1; Wed, 12 Feb 2025 12:28:12 -0500
X-MC-Unique: gjA6OX_kNuy8SG5uoPxDnA-1
X-Mimecast-MFC-AGG-ID: gjA6OX_kNuy8SG5uoPxDnA_1739381291
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38ddba9814bso1868242f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739381291; x=1739986091;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAeB2sjmO1LspadXAmgkFq1LNAylM/GkDoXEOqI4veI=;
 b=f800N2XUZrz9J4XmzCHHQd5sVz0jVWBKFFJr0n8sGdXIXEuUpc125l/kz04MprgDIb
 w/O1cL7hs1a2rKxZeuZ0E7JRR89fyXvK4otcyB2aShQyYoDjvs8V8h+aEDtrc/IvdCHd
 PCbJCbp1WoHvIQSLQvFkZFvyouNyveKYhaojAyV8zM4/qpGNnQbpzwA5dOm4GzlrlR20
 AEnpP0Iduz1pxIPc/Lr21QHdoEBu3YjcEfiDwZLE96/pNX1C4bdx3uER4nUBc6QSfmvR
 IBGkxUytCIHaLOTDSnEldXkUqnPACXGhICgSzYHoHICKqO6vlkJOW2BmSSMga2AU5o7c
 h14g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu7WUTNzpMVj31kygM5+3FNJqdk936TRepFCskpg4VUSecITYpIcp7IycuILPy5hPlL9G4NCXDqhkB@nongnu.org
X-Gm-Message-State: AOJu0YwAEQVa0bUFzy5npAnp+UTo8BsNrPFheY/u2Fi89z94C22Sb93K
 i6QVwXvnA0y/DBrJObRGiD1Qn3JknElGpfsfoZ+P4mOP2UiJ0dr36KKXEWRSIt2DZlzKwvJBBu0
 8/5e0TpmxzX5qkmbstCWFQs+NZIA6pbWpBRiP6EW6s56i+Jf+JBmg
X-Gm-Gg: ASbGncs7bDcLn2A1o9K0k3hk491gqRgRpcRjQl3W2TegC/LNXGQ3rBUkCubk6wsviGQ
 cUHJHgPvJhemFbhoQ+Geob56te7AqW71v4LQzNqXTVDC3s/xh0s7fI+Sgb5fhKOznrkXwt9fKL9
 b2OwHCt+N7YQ/9fYmkZqBTQxGcJohbJm37snUXvQMtvc6iRyQxmxaCM36nCN4hCbar/mKObELD2
 BZQY1SYUpsLygU6Ug1eK73d2LEqUXd5aVoCypC3oWUolsg8rd7lsDIOPYrEhDQeyRcNRz2M+vqY
 6No95K1Uomcwm2fC5L+wS08HX0sMjoWkQT9AFu7Relg=
X-Received: by 2002:a5d:64c7:0:b0:38d:d6cc:a6ed with SMTP id
 ffacd0b85a97d-38f244d62bdmr188601f8f.5.1739381291334; 
 Wed, 12 Feb 2025 09:28:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS5CpbCrpiHvE6d+geXcYeftZDES36gjznmeebhBcR4ByvyrRNEfFLMsrdaX5uz3ywoMIZIw==
X-Received: by 2002:a5d:64c7:0:b0:38d:d6cc:a6ed with SMTP id
 ffacd0b85a97d-38f244d62bdmr188577f8f.5.1739381290969; 
 Wed, 12 Feb 2025 09:28:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38e0e7abd1csm2172782f8f.43.2025.02.12.09.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:28:10 -0800 (PST)
Message-ID: <928138f6-3434-470c-b758-377270d04b94@redhat.com>
Date: Wed, 12 Feb 2025 18:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 imammedo@redhat.com, alex.williamson@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
 <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
 <Z6ZHTStx_S9ALdxt@x1.local>
 <CAFEAcA8ovoGsQ9oEco88iw3iUy_3kBOUaYHL+oq5VF-i9xg4+A@mail.gmail.com>
 <Z6oJzRCt_fJLfkmQ@x1.local>
 <CAFEAcA9640s-Eu7PHxJ-Xb5X38n-25pnUG+GxymsAWkJf8YfcA@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA9640s-Eu7PHxJ-Xb5X38n-25pnUG+GxymsAWkJf8YfcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/10/25 15:22, Peter Maydell wrote:
> On Mon, 10 Feb 2025 at 14:14, Peter Xu <peterx@redhat.com> wrote:
>>
>> On Fri, Feb 07, 2025 at 06:18:50PM +0000, Peter Maydell wrote:
>>> On Fri, 7 Feb 2025 at 17:48, Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Fri, Feb 07, 2025 at 04:58:39PM +0000, Peter Maydell wrote:
>>>>> (I wonder if we ought to suggest quiescing outstanding
>>>>> DMA in the enter phase? But it's probably easier to fix
>>>>> the iommus like this series does than try to get every
>>>>> dma-capable pci device to do something different.)
>>>>
>>>> I wonder if we should provide some generic helper to register vIOMMU reset
>>>> callbacks, so that we'll be sure any vIOMMU model impl that will register
>>>> at exit() phase only, and do nothing during the initial two phases.  Then
>>>> we can put some rich comment on that helper on why.
>>>>
>>>> Looks like it means the qemu reset model in the future can be a combination
>>>> of device tree (which resets depth-first) and the three phases model.  We
>>>> will start to use different approach to solve different problems.
>>>
>>> The tree of QOM devices (i.e. the one based on the qbus buses
>>> and rooted at the sysbus) resets depth-first, but it does so in
>>> three phases: first we traverse everything doing 'enter'; then
>>> we traverse everything doing 'hold'; then we traverse everything
>>> doing 'exit'. There *used* to be an awkward mix of some things
>>> being three-phase and some not, but we have now got rid of all
>>> of those so a system reset does a single three-phase reset run
>>> which resets everything.
>>
>> Right.  Sorry I wasn't very clear before indeed on what I wanted to
>> express.
>>
>> My understanding is the 3 phases reset, even if existed, was not designed
>> to order things like vIOMMU and devices that is already described by system
>> topology.  That's, IMHO, exactly what QOM topology wanted to achieve right
>> now on ordering device resets and the whole depth-first reset method would
>> make sense with it.
>>
>> So from that specific POV, it's a mixture use of both methods on ordering
>> of devices to reset now (rather than the order of reset process within a
>> same device, provided into 3 phases).  It may not be very intuitive when
>> someone reads about the two reset mechanisms, as one would naturally take
>> vIOMMU as a root object of any other PCIe devices under root complex, and
>> thinking the order should be guaranteed by QOM on reset already.  In
>> reality it's not.  So that's the part I wonder if we want to document.
> 
> Yeah, I see what you mean. The issue here is that the iommu isn't
> actually a parent of the devices that access through it. This is
> true both in the "qbus/qdev bus tree" sense (where it is the PCI
> controller device that owns the PCI bus that the devices are on)
> and also in the QOM tree sense[*] (where usually the iommu and the
> PCI controller are both created by the machine or the SoC, I guess?).
> Instead iommus are separate devices that control data flow but
> aren't in a parent-child relationship with the devices on either
> side of that flow. There is a guarantee about reset ordering between
> bus parent/child (so the PCI controller resets before it resets
> the PCI bus that resets the PCI devices on the bus), but that doesn't
> help the iommu.
> 
> [*] I have a vague idea that ideally we might want reset to be
> QOM-tree based rather than qbus-tree based. But getting there from
> here is non-trivial. And maybe what we really want is "objects,
> especially SoCs, that create children can define what their reset
> tree is, with the default being to reset all the QOM children".

yes. When I quickly thought about it, I had the idea that we could
reparent the vIOMMU device(s) to a default or a specific PHB and
order the reset calls from the PHB reset routine.

> Lots of non-thought-through complexity here ;-)

same ...

C.




