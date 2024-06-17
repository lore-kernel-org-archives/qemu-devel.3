Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95540C2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 12:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJBZH-0002mS-OR; Mon, 17 Jun 2024 08:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJBZC-0002ly-88
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJBZ9-0007iw-JY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718627670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx7G9AvMQdMNVZPaWkV7+FidGRLRftObktbpunVi6xo=;
 b=NJa47oXCG4LHj+8Z4x7PljuKFsM5m8fuui0tWC+QYnFzaOG9JkH4FtoYMUFAW7ZmeLoXGP
 wovOxob5IbLDauk8rlpIN2bk9ExcbilOLtFDW808ZEP4cwOzKTPVH6Dtv4PFIZQD41auxy
 ues8XOKYDLBkkrND8G2r7qExxXR5+7E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-GWozqR06NWy1zbhDs9MdPA-1; Mon, 17 Jun 2024 08:34:28 -0400
X-MC-Unique: GWozqR06NWy1zbhDs9MdPA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b071b70d2dso58596186d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718627668; x=1719232468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zx7G9AvMQdMNVZPaWkV7+FidGRLRftObktbpunVi6xo=;
 b=DZUgyLQ94JbsHLagFZ8bN3NV/TsA7izFCfcUwObEfeGsLCn3GlmTMk0V2W3IObHmf0
 B9j+26Y11o9AFQI2rmUdyWAqwj34OfPlnEeSC5QYK3aERbr5Oibgyk54UADuqQcEJ8vT
 y9uQUtj/khmQHsPee44o/M1qi+picy4QpfjJgGmGWhg3FFR79lTPtsAsmsyUFJL2100g
 /SdsqEhhRhJx6bCC7cd/mjeAtYGtrW4rzt1YatTiVLx7bu6DtImTdMcK/ZVx5Cv2EA5A
 tNNBMcaIoJDH0eyo+CTD/aT9s9x+g40AUr2QVt2If1/bwbYa6kSFo2vlWTMLNj4ty7on
 tqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWizoW98QK7ISEHAYYo7SrSLluPhQ+GxfZOVTVmVbVcTRy+X6GRnQJ8mLQGdk8FdieLRwtiDm58SsUonugtNM5UKPk+GA0=
X-Gm-Message-State: AOJu0Yza8wPel+WAn9e5qKOxCI76xf0LQpW1216gOLATV76GON+tLrzO
 igrCe59HwgCeYBu0hb0qbwIRSvZcZ8iMmJLIy5nQi4u169d3cEooAED4y5f2XxNsjnvg+n9erx8
 ZNnz2Mf5zp+bu/NF6Uk1SN1pns6rIjY/vILJ7/L0Muj22+uusTl5P
X-Received: by 2002:a0c:da91:0:b0:6af:bcb0:c29c with SMTP id
 6a1803df08f44-6b2afc76da1mr101571076d6.10.1718627667696; 
 Mon, 17 Jun 2024 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8sX9gxmjcA3N05LYm/ODaWRKEJ3oSzm/4xHN2eWsi3ZMFVUJSzDiaCN+b1sPcBrsy05+SFw==
X-Received: by 2002:a0c:da91:0:b0:6af:bcb0:c29c with SMTP id
 6a1803df08f44-6b2afc76da1mr101570696d6.10.1718627667124; 
 Mon, 17 Jun 2024 05:34:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441f2fd020csm45904741cf.64.2024.06.17.05.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 05:34:26 -0700 (PDT)
Message-ID: <c998c442-f873-4409-804a-fcba1f53efc2@redhat.com>
Date: Mon, 17 Jun 2024 14:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] vfio: Make vfio_devices_dma_logging_start()
 return bool
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-2-clg@redhat.com>
 <a1c5811d-f376-483f-8ab4-e09ca8f874b6@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a1c5811d-f376-483f-8ab4-e09ca8f874b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Eric,

On 6/17/24 1:31 PM, Eric Auger wrote:
> Hi Cédric,
> 
> On 6/17/24 08:33, Cédric Le Goater wrote:
>> Since vfio_devices_dma_logging_start() takes an 'Error **' argument,
>> best practices suggest to return a bool. See the api/error.h Rules
>> section. It will simplify potential changes coming after.
> 
> 
> As I already mentionned the Rules section does not say that, as far as I
> understand:
> It is allowed to either return a bool, a pointer-value, an integer,
> along with an error handle:
> 
> "
>   *   • bool-valued functions return true on success / false on failure,
>   *   • pointer-valued functions return non-null / null pointer, and
>   *   • integer-valued functions return non-negative / negative.
> "
>
> Personally I don't like much returning a bool as I think it rather
> complexifies the code and to me that kind of change is error prone.

Returning an int could be misleading too, since there are multiple ways
it could be interpreted. You can find in QEMU routines returning -1 for
error which is later used as an errno :/

The error framework in QEMU provides a way to to save and return any
kind of errors, using the error_seg_*() routines. I tend to prefer
the basic approach: return fail or pass and use the Error parameter
for details.

Now, the problem, as always, is doing the conversion in all the
code. This is probably why people, with a kernel background, find
it confusing.


> 
> 
>>
>> vfio_container_set_dirty_page_tracking() could be modified in the same
>> way but the errno value can be saved in the migration stream when
>> called from vfio_listener_log_global_stop().
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/common.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 9e4c0cc95ff90209d3e8184035af0806a2bf890b..d48cd9b9361a92d184e423ffc60aabaff40fb487 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1020,7 +1020,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>       g_free(feature);
>>   }
>>   
>> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>> +static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>                                             Error **errp)
>>   {
>>       struct vfio_device_feature *feature;
>> @@ -1033,7 +1033,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>                                                              &ranges);
>>       if (!feature) {
>>           error_setg_errno(errp, errno, "Failed to prepare DMA logging");
>> -        return -errno;
>> +        return false;
>>       }
>>   
>>       QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>> @@ -1058,7 +1058,7 @@ out:
>>   
>>       vfio_device_feature_dma_logging_start_destroy(feature);
>>   
>> -    return ret;
>> +    return ret == 0;
>>   }
>>   
>>   static bool vfio_listener_log_global_start(MemoryListener *listener,
>> @@ -1067,18 +1067,18 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>>       ERRP_GUARD();
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>> -    int ret;
>> +    bool ret;
>>   
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;
> 
> why vfio_container_set_dirty_page_tracking(bcontainer, true, errp) doesn't return a bool then?

The errno value can be saved in the migration stream when called from
vfio_listener_log_global_stop(). So this would require changes in the
migration subsystem, like we did for vfio_listener_log_global_start().

Thanks,

C.





> 
> Eric
> 
>>       }
>>   
>> -    if (ret) {
>> +    if (!ret) {
>>           error_prepend(errp, "vfio: Could not start dirty page tracking - ");
>>       }
>> -    return !ret;
>> +    return ret;
>>   }
>>   
>>   static void vfio_listener_log_global_stop(MemoryListener *listener)
> 


