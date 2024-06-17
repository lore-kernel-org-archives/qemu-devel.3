Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8C8C2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCpe-0003IU-FB; Mon, 17 Jun 2024 09:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJCpc-0003Hi-Dl
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJCpa-0006Qu-B7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718632533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEeS1xJ9TtrzPgm3WzmvMD/jkKvrPQDkt8PrIiLMux0=;
 b=QNzrYNuMkSbmnYzOudVNdka4wxLz01m/c+vFZTJWUfEl4aOnlvitd8DZX3uLTGk66Jmqq1
 Agbz76IhVygNbR1lB4WXnIY6zbcXFaZkMMYCIF0kUCWRk7ih9dpvTJmhyLIZufuffWG4ni
 UpEI10gj6sLMbcRU5aP+I/byg6ZdfzU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-620pds3oM4GCsmy7CbQEZg-1; Mon, 17 Jun 2024 09:55:31 -0400
X-MC-Unique: 620pds3oM4GCsmy7CbQEZg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c6f37cc97so2724544e87.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 06:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632530; x=1719237330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEeS1xJ9TtrzPgm3WzmvMD/jkKvrPQDkt8PrIiLMux0=;
 b=LLXuQD5fTBed3LyIUUCbgMgYeAShcje3q0+7m/sgQjW9/dngiSBkJCGdxkrtz9eRu8
 vMsRwMC1FZmb05bk3J+cOHh/heyjjOCnLh2pjaBt5Z3K0x8nspElY3JPuRQLYrcvHbTK
 FaHgv/ZMziDMRCD2TQS+uRXRTjaCrywGoQUgSx+oC7CX9d0CM9kuhHWz37Ti9fG4iSwz
 BqPR6ng7ECWQrrpqt0cYc/MHY237QgHue8zisFWjcjsMA8D9TE6COD03ld1ZPfSR/Gft
 gnaZLrS2ZeqopnmMBaBT2aMBOeRMaPR/en5/wCTwOb9GuLVqbeEkYDSVtICriiizVE5z
 3k/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4LtR+fVQBxllM+xbNkMbmrsYMQOSoGFZ2oIvHLZLouYkgweu4fAQvSlEgQg6q7k8XKAecnnR4keyo2ks6M+3YqKcyekw=
X-Gm-Message-State: AOJu0YzTx/nYxLbDgRMRBBBi3yyKSsIkP0hybB7zloiYii6tLcCtDpYW
 QUaYylR82abJtPJF+ZLuLm86LCFoUZnFAQldbMCZXE5SshKnFJHSpQ4ivIb/9BdlnYFLPWIidPH
 54QDIfN8v1ePdAKePlWoSCBjjd/0tvqCPOnbQ9VMRd1omP/90MJRK
X-Received: by 2002:ac2:53a7:0:b0:52c:84b0:bd21 with SMTP id
 2adb3069b0e04-52ca6e653femr6656375e87.16.1718632530004; 
 Mon, 17 Jun 2024 06:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGThT+NN+eLb0GIdUGNW6bpMy4o/j1ETjXmS2D+THpLKdv3gqLjX4mf74sc+49ixLLz9WzvFA==
X-Received: by 2002:ac2:53a7:0:b0:52c:84b0:bd21 with SMTP id
 2adb3069b0e04-52ca6e653femr6656368e87.16.1718632529552; 
 Mon, 17 Jun 2024 06:55:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750935ecsm11981655f8f.3.2024.06.17.06.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 06:55:29 -0700 (PDT)
Message-ID: <d830b55b-b45c-43cc-aee7-cd996985c4f3@redhat.com>
Date: Mon, 17 Jun 2024 15:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] vfio: Make vfio_devices_dma_logging_start()
 return bool
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-2-clg@redhat.com>
 <a1c5811d-f376-483f-8ab4-e09ca8f874b6@redhat.com>
 <c998c442-f873-4409-804a-fcba1f53efc2@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c998c442-f873-4409-804a-fcba1f53efc2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cédric,

On 6/17/24 14:34, Cédric Le Goater wrote:
> Hello Eric,
>
> On 6/17/24 1:31 PM, Eric Auger wrote:
>> Hi Cédric,
>>
>> On 6/17/24 08:33, Cédric Le Goater wrote:
>>> Since vfio_devices_dma_logging_start() takes an 'Error **' argument,
>>> best practices suggest to return a bool. See the api/error.h Rules
>>> section. It will simplify potential changes coming after.
>>
>>
>> As I already mentionned the Rules section does not say that, as far as I
>> understand:
>> It is allowed to either return a bool, a pointer-value, an integer,
>> along with an error handle:
>>
>> "
>>   *   • bool-valued functions return true on success / false on failure,
>>   *   • pointer-valued functions return non-null / null pointer, and
>>   *   • integer-valued functions return non-negative / negative.
>> "
>>
>> Personally I don't like much returning a bool as I think it rather
>> complexifies the code and to me that kind of change is error prone.
>
> Returning an int could be misleading too, since there are multiple ways
> it could be interpreted. You can find in QEMU routines returning -1 for
> error which is later used as an errno :/
yes no good!
>
> The error framework in QEMU provides a way to to save and return any
> kind of errors, using the error_seg_*() routines. I tend to prefer
> the basic approach: return fail or pass and use the Error parameter
> for details.
>
> Now, the problem, as always, is doing the conversion in all the
> code. This is probably why people, with a kernel background, find
> it confusing.
>
>
>>
>>
>>>
>>> vfio_container_set_dirty_page_tracking() could be modified in the same
>>> way but the errno value can be saved in the migration stream when
>>> called from vfio_listener_log_global_stop().
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   hw/vfio/common.c | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index
>>> 9e4c0cc95ff90209d3e8184035af0806a2bf890b..d48cd9b9361a92d184e423ffc60aabaff40fb487
>>> 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1020,7 +1020,7 @@ static void
>>> vfio_device_feature_dma_logging_start_destroy(
>>>       g_free(feature);
>>>   }
>>>   -static int vfio_devices_dma_logging_start(VFIOContainerBase
>>> *bcontainer,
>>> +static bool vfio_devices_dma_logging_start(VFIOContainerBase
>>> *bcontainer,
>>>                                             Error **errp)
>>>   {
>>>       struct vfio_device_feature *feature;
>>> @@ -1033,7 +1033,7 @@ static int
>>> vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>                                                              &ranges);
>>>       if (!feature) {
>>>           error_setg_errno(errp, errno, "Failed to prepare DMA
>>> logging");
>>> -        return -errno;
>>> +        return false;
>>>       }
>>>         QLIST_FOREACH(vbasedev, &bcontainer->device_list,
>>> container_next) {
>>> @@ -1058,7 +1058,7 @@ out:
>>>         vfio_device_feature_dma_logging_start_destroy(feature);
>>>   -    return ret;
>>> +    return ret == 0;
>>>   }
>>>     static bool vfio_listener_log_global_start(MemoryListener
>>> *listener,
>>> @@ -1067,18 +1067,18 @@ static bool
>>> vfio_listener_log_global_start(MemoryListener *listener,
>>>       ERRP_GUARD();
>>>       VFIOContainerBase *bcontainer = container_of(listener,
>>> VFIOContainerBase,
>>>                                                    listener);
>>> -    int ret;
>>> +    bool ret;
>>>         if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>           ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>>       } else {
>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer,
>>> true, errp);
>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer,
>>> true, errp) == 0;
>>
>> why vfio_container_set_dirty_page_tracking(bcontainer, true, errp)
>> doesn't return a bool then?
>
> The errno value can be saved in the migration stream when called from
> vfio_listener_log_global_stop(). So this would require changes in the
> migration subsystem, like we did for vfio_listener_log_global_start().

OK

so although I am not a big fan of that kind of change and once
highlighted this is not mandated by the error.h doc, please feel free to
add my
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>
> Thanks,
>
> C.
>
>
>
>
>
>>
>> Eric
>>
>>>       }
>>>   -    if (ret) {
>>> +    if (!ret) {
>>>           error_prepend(errp, "vfio: Could not start dirty page
>>> tracking - ");
>>>       }
>>> -    return !ret;
>>> +    return ret;
>>>   }
>>>     static void vfio_listener_log_global_stop(MemoryListener *listener)
>>
>


