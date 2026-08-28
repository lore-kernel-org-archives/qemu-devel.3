Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50788C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsBc-0000wT-0N; Fri, 28 Aug 2026 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzsBa-0000wD-TF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzsBY-0000Bb-NB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787906619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWYBYe4WhXxFr8GsMezY8DxaX6oc77Se5EtU1IhdDHE=;
 b=aAYpjekgYgLSkPineAK6zCMfv8OBRYStag+l58xJjxXaY/lV/dp0MUFdouzy6N4dKYw+4t
 FVx20DimSFjLqbJ8w5e+iLfJeQjG6ToWrW7ZaAxXL97cTHdgOECGNDniiUmYtfeArmjD9/
 T00MPoRKxTe17ycUdADGJ7MFWm/zZQk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-axRwwgpNOrKQ4ynmWNwqNw-1; Fri, 28 Aug 2026 04:43:36 -0400
X-MC-Unique: axRwwgpNOrKQ4ynmWNwqNw-1
X-Mimecast-MFC-AGG-ID: axRwwgpNOrKQ4ynmWNwqNw_1787906615
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso4968615e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 01:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787906615; x=1788511415;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mWYBYe4WhXxFr8GsMezY8DxaX6oc77Se5EtU1IhdDHE=;
 b=E12c1EG+pW9XdVmt9RCnptoYTHr3+BY59pefiRMyZ4d0v+gwE1hd56VHHOxYTp3QXQ
 UV/mZhswMXik7MZPJDARc1vfoR5ZHi9fBcVmVtl0qE8zYljD/DgG8x+124vDlyj4D3/i
 3vOulMwoVaMk5Prtw9OSW6/oLbQXnhT58a9EsGPc9TEpn7KsDSxJemw38oJzDQ3T8g1V
 Zu1XkwLswuemGRfx8jXjUxYfGxMwXxiJj37pf3VqmrC0jz1XNZl6pHkmDhZc2vGwlZNS
 DxkJ+P+JTsY/FYuHaVc3UB8XDRl5CqQOfnYTsnmNIAQcqGQUKww94Kd6PS8V1kwOmIlV
 e8kw==
X-Gm-Message-State: AFuF++nSw/3LYEi6QuwglG7PN+jN4HZwJrZ/Sg6SiUQJuSEL39zR9eEG
 X1u/IKFE8WFbHn06FvkD7mEtOoKuhzaMV7x/V5BWdGya2Wj7Xb60c8xWt9Y3kW+cHCL6rAOpzLy
 7ghJlU0y7k3pB0nJ05K999SG4u71FUAps049DVm94Yj2FLq2XM38hgT2r
X-Gm-Gg: AR+sD12x995dnmmt3HUfjdyY5Q8Nqsbo7DFCt6pfEDLuGZHryBLUO9HFV6Kg6K3dGcz
 6Oi3E08DXmxfb8rfguxSapU3m+mEn31I6zvI7CacYJnMQ+uC/wva4HVpIFJA+EM/hHH3E27cnhn
 sAtnrs6yhjOg7GgsWARxD3pcWEc0f5/xEZdHjDkYYm/epVHTnUTUYR95qSm3cqZxyH6qzEYdFvK
 LBUcmLna3B+aCkhi076RmWbXiFbIoNqJxgsjt17d1TaeRMWlMf9pICuVMUW8ZWnrLrlYxn7FShn
 MJ9FCc5ZbEvkmK2KdRftVwg2nu1rEspI59+mOt0P9OouWV75JXkxiYy/FVuLCXPVj8vevtKX6vx
 GU8i/jMvkU8FuXrFA2Pswj9+Xx1eQ1iiTiGiAUWFYB9hnZH3y
X-Received: by 2002:a05:600c:8b75:b0:499:d22a:8973 with SMTP id
 5b1f17b1804b1-49b91c1da1emr80705425e9.1.1787906615442; 
 Fri, 28 Aug 2026 01:43:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8b75:b0:499:d22a:8973 with SMTP id
 5b1f17b1804b1-49b91c1da1emr80704635e9.1.1787906615041; 
 Fri, 28 Aug 2026 01:43:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d06sm45781605e9.12.2026.08.28.01.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 01:43:34 -0700 (PDT)
Message-ID: <3d821b55-eda6-40ea-9c5b-15e75b11524e@redhat.com>
Date: Fri, 28 Aug 2026 10:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC v5 15/28] hw/arm/smmu: Make CMDQ invalidation security-state
 aware
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-5-tangtao1634@phytium.com.cn>
 <4b80bd7c-1002-4ae4-a9fe-7449c0637687@oss.qualcomm.com>
 <0f3cec2d-a184-4fdf-b4e1-d7d2ae4a67fb@phytium.com.cn>
Content-Language: en-US
In-Reply-To: <0f3cec2d-a184-4fdf-b4e1-d7d2ae4a67fb@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On 8/21/26 6:00 PM, Tao Tang wrote:
> Hi Pierrick,
>
> On 8/21/2026 6:29 AM, Pierrick Bouvier wrote:
>> On 8/13/2026 9:25 AM, Tao Tang wrote:
>>> Refactor CMDQ invalidation paths to carry security state and apply
>>> cache
>>> invalidation per sec_sid instead of globally. Add separate helpers for
>>> invalidating all entries and for invalidating entries belonging to one
>>> valid sec_sid.
>>>
>>> In smmuv3, propagate the command queue sec_sid and command SSec through
>>> CFGI and TLBI handling, and gate VMID use on the stage-2 capability of
>>> the selected command queue, including SMMU_S_IDR1.SEL2 for a Secure
>>> Command queue.
>>>
>>> Keep acceleration and IOMMU notifier propagation Non-secure-only.
>>> Commands targeting a programming interface other than Non-secure do not
>>> reach the accelerated backend or Non-secure notifiers, while Non-secure
>>> stage-1 CMD_TLBI_NH_ALL remains forwarded to the host.
>>>
>>> Include the command queue SEC_SID and target SEC_SID in the relevant
>>> invalidation tracepoints.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>   hw/arm/smmu-common.c         | 100 ++++++++++++++++++++++++++++-
>>>   hw/arm/smmuv3-accel-stubs.c  |   6 +-
>>>   hw/arm/smmuv3-accel.c        |  30 +++++++--
>>>   hw/arm/smmuv3-accel.h        |   6 +-
>>>   hw/arm/smmuv3.c              | 121
>>> ++++++++++++++++++++++++++---------
>>>   hw/arm/trace-events          |  12 ++--
>>>   include/hw/arm/smmu-common.h |   6 ++
>>>   7 files changed, 231 insertions(+), 50 deletions(-)
>>>
>> Given this patch, would that be simpler to have multiple iotlb hashtable
>> per sec_sid? This way, invalidation becomes trivial.
>>
>> It has been long time since last version, so I forgot if there was a
>> specific reason to keep a single table and add sec_sid to each entry.
>
>
> I agree that separate IOTLB tables per SEC_SID would simplify the
> namespace-wide invalidation in the current model. Mostafa made the
> same suggestion in v4 [1], and I agreed to rework it for v5.
>
> As Eric later pointed out [2], SEC_SID is not itself the architectural
> TLB tag. It selects the programming interface and Stream table, while
> cached translations are identified by the effective StreamWorld and
> the applicable ASID/VMID.
>
> My reason for retaining the single table is therefore patch scope, not
> an architectural objection to per-SEC_SID tables. This series models
> one StreamWorld per SEC_SID and uses SEC_SID as a temporary
> discriminator, as described in the definition of struct SMMUIOTLBKey
> [3]. I would prefer to keep the cache topology unchanged here and
> address the layout together with full StreamWorld tagging and
> invalidation in a follow-up series.
>
> Eric, would you prefer that v6 adopt the per-SEC_SID split suggested
> by Pierrick and Mostafa, or keep the current layout and defer the
> topology decision to the StreamWorld work? I am happy to follow the
> preferred direction. 
In case we change this implementation into per-SEC_SID tables, what will
it become when we implement full StreamWorld solution. Will we end up
with even more tables?
My current understanding is this implementation can be easily extended
by replacing the SED_SID tag by StreamWorld later on, so maybe the
effort done will have return of investment later on?

Thanks

Eric
>
> [1] https://lore.kernel.org/qemu-devel/aaGuGuevX8HFqx0x@google.com/
> [2]
> https://lore.kernel.org/qemu-devel/72026588-1db3-48a1-af99-e5e2aca69058@redhat.com/
> [3]
> https://lore.kernel.org/qemu-devel/20260813162512.2807281-2-tangtao1634@phytium.com.cn/
>
>
>
>> Regards,
>> Pierrick
>
>
> Best regards,
>
> Tao
>


