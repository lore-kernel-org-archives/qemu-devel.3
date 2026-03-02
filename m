Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7D3E9B37E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3bN-0004C3-7P; Mon, 02 Mar 2026 08:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx3b7-000422-Tc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx3b4-00019O-Jg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772459164;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXggzZksC/lnevLmb0OfpevtWIg+C4FZBStw4dowp9g=;
 b=ekpu/vVvYnDvlUL5q/nFbhfPB54UdQHORqC29i4WEZ3JUPvPf0Q2vQE+/XcCKYT8iMxSle
 Kg+gRM6HYTG9/yB1XOy3uYMsF29u+ejCqbH1Iw9gN8d0iw2yQrnSlRg6aqVpfbfR/dXQEU
 qlvOAjYnHVplKIKDq0TZ3yBU3SSP5PU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-itpJbjpJM_6KIRfTbiC6_Q-1; Mon, 02 Mar 2026 08:46:01 -0500
X-MC-Unique: itpJbjpJM_6KIRfTbiC6_Q-1
X-Mimecast-MFC-AGG-ID: itpJbjpJM_6KIRfTbiC6_Q_1772459160
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836e35292cso38009515e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 05:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772459160; x=1773063960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXggzZksC/lnevLmb0OfpevtWIg+C4FZBStw4dowp9g=;
 b=NT1AhHF55qQb9iWjxWrQBlqDHtdy9x8bvsgwK7FtcNyxjreg/arKkPfnn0qIg0zgFB
 vkur8gc8yDJnW7Td1jUnZ9wGbXWkYqmjYh0zC4bjOIjmlVo4ZwqQN0rlirGlrhumA+jG
 LwNT/JJGODPbnROuDEI1rrTpHKF6ldnFzjZ62jVXN3J0OI/Me/sCXYMe1wGtWS+azvOe
 9gVF+BepN/fV2zLfjUasxmoRHlU/WdqaggBwyMabGB8esXvjr9PxwkZc5kpEl38s+5eT
 zK7xvJzcD7vsDfvWFPkunuFj0MqxUlhRla50Mm+EbT9IpaRrP7gixdTkSOjkfQ5fGPCd
 ZmnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdBuFmFFnBSl++SvwWq3cMZSpUfAT+XUeWxpnx+0RxoP4klWPKT5UVV5zVvUme7tZw5OaMHghxvszc@nongnu.org
X-Gm-Message-State: AOJu0YyvauvmbfO+fWju6ltrnMyLv8fG/yQxIHjpz3mIbsADoTOEsRrD
 jwZypXafESJIA0Kp7Q+qPKF7EL6/lhtygqe1TIAilgbALbsmz9ohod9FE/8OFnp8cq997dqDbna
 d3sO87y/5+kOC9OPTozNnEDzmtCDyy1NJbI99iRUz0NxeGvycBDix2x/j
X-Gm-Gg: ATEYQzzOySSNp+ufMiMHSHcIY9yvQmabHw5cJ7r3SxGDNVQis61aHJd8W683zSstMfT
 Z62zui+Jqy6/E85em3LMxv5tUlhZS2bIvZm+CzC0WR6oqwbWqX7dtidxkhOjqmkjJPnfLEdOQIe
 wtDg4UhUMgm3IinylEIkKkb8kuXK5S6vSV6Pls7VpD58dH6Sl1K1VxuDjmOP5EW5kVE/kFglYPv
 9XQ4WdBUURg7h9CiKzmZCVmgo4x4ddxXHK5jKtQdN0gt1szT2UssxgAE0odkN9Ou0qF331eh51m
 e/SxaOtn9t8LjFF4KMQU/EnmCug8JfiezlNTsxmdJfQ+83RxtMdJcUOkwcddsVr5n2Qu9bCoEtu
 KcIphzKZYi7maC+l37PE7ZFqik53WjKpdFpamk5yGb9/BKgAQNeaC7hr8iA/+wwHy2BU1Ww==
X-Received: by 2002:a05:600c:b86:b0:483:badb:618a with SMTP id
 5b1f17b1804b1-483c9c1525emr205510565e9.27.1772459159823; 
 Mon, 02 Mar 2026 05:45:59 -0800 (PST)
X-Received: by 2002:a05:600c:b86:b0:483:badb:618a with SMTP id
 5b1f17b1804b1-483c9c1525emr205510055e9.27.1772459159350; 
 Mon, 02 Mar 2026 05:45:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b44207sm301238455e9.7.2026.03.02.05.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 05:45:58 -0800 (PST)
Message-ID: <faffa388-51b3-476f-8c5d-67aacc467c87@redhat.com>
Date: Mon, 2 Mar 2026 14:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 06/31] hw/arm/smmuv3: Track SEC_SID in configs and events
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-7-tangtao1634@phytium.com.cn>
 <aaGsltcRyTu7j1tU@google.com>
 <df545e5d-0380-49bd-97f1-5b7b9a4259da@phytium.com.cn>
 <aaVkQdanf4KhROna@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aaVkQdanf4KhROna@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Tao,

On 3/2/26 11:19 AM, Mostafa Saleh wrote:
> On Sun, Mar 01, 2026 at 09:53:24PM +0800, Tao Tang wrote:
>> Hi Mostafa,
>>
>> On 2026/2/27 PM10:39, Mostafa Saleh wrote:
>>> On Sat, Feb 21, 2026 at 06:02:25PM +0800, Tao Tang wrote:
>>>> Cache the SEC_SID inside SMMUTransCfg to keep configuration lookups
>>>> tied to the correct register bank.
>>>>
>>>> Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
>>>> and event logs always show which security interface emitted the record.
>>>> To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
>>>> identified as soon as an event record is built.
>>>>
>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>   hw/arm/smmuv3-internal.h     |  1 +
>>>>   hw/arm/smmuv3.c              | 20 +++++++++++++-------
>>>>   hw/arm/trace-events          |  2 +-
>>>>   include/hw/arm/smmu-common.h |  1 +
>>>>   4 files changed, 16 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>>> index 866d62257e3..a1071f7b689 100644
>>>> --- a/hw/arm/smmuv3-internal.h
>>>> +++ b/hw/arm/smmuv3-internal.h
>>>> @@ -274,6 +274,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
>>>>   /*  Encode an event record */
>>>>   typedef struct SMMUEventInfo {
>>>> +    SMMUSecSID sec_sid;
>>>>       SMMUEventType type;
>>>>       uint32_t sid;
>>>>       bool recorded;
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index 2c107724e77..3438adcecd2 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -148,9 +148,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
>>>>       return MEMTX_OK;
>>>>   }
>>>> -static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>>>> +static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>>>> +                                       Evt *evt)
>>>>   {
>>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>>>       SMMUQueue *q = &bank->eventq;
>>>>       MemTxResult r;
>>>> @@ -178,7 +178,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>>>   {
>>>>       Evt evt = {};
>>>>       MemTxResult r;
>>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>> +    SMMUSecSID sec_sid = info->sec_sid;
>>>> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
>>> What does this defend against?
>>
>> sec_sid is now taken from SMMUEventInfo, so the assert is to catch
>> programming errors early and avoid out-of-bounds bank accesses in
>> smmuv3_record_event.
> Personally, I don't like this kind of defensive programming, someone can
> argue we can add such checks anywhere.
> I believe we should definitely know the possible states in the software
> and add checks needed at guest inputs.
> But that's also up to Eric.
I tend to agree with Mostafa. We shall avoid putting those asserts
everywhere. Would it make sense to pove it to smmuv3_bank directly?

Eric  
>
> Thanks,
> Mostafa
>
>>> Thanks,
>>> Mostafa
>>
>> Best regards,
>>
>> Tao
>>
>>>>       if (!smmuv3_eventq_enabled(s, sec_sid)) {
>>>>           return;
>>>> @@ -258,8 +259,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>>>           g_assert_not_reached();
>>>>       }
>>>> -    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
>>>> -    r = smmuv3_write_eventq(s, &evt);
>>>> +    trace_smmuv3_record_event(sec_sid, smmu_event_string(info->type),
>>>> +                              info->sid);
>>>> +    r = smmuv3_write_eventq(s, sec_sid, &evt);
>>>>       if (r != MEMTX_OK) {
>>>>           smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
>>>>       }
>>
>>
>>
>>


