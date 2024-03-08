Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149BEC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZqi-0004Om-4B; Fri, 08 Mar 2024 08:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riZqb-0004J5-Eo
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riZqY-0003sp-5E
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709902866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UlsJiFLJLsyZDil6IZYiUw1tiZZReAlV6tZXNBXvIo=;
 b=ZtfDfuz2k905vWgTzpPXyQk8JC7IiXQSfy+STp3LflgTqAJroEUYBSccgMvyW/eDPSC7+8
 BvTJs9PMSIn77RalrXVnzzZuuO2bkGZ4sb2L0rDEpCBi70LAc1PZ0XdWD2Y60ot5PftJuV
 HGdTk0+KVKvB/CshM8dHdLClZ6Oa58A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-FY72oIWdNLCGn4kNxCphqQ-1; Fri, 08 Mar 2024 08:01:04 -0500
X-MC-Unique: FY72oIWdNLCGn4kNxCphqQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33dfefa9b1dso1055205f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709902863; x=1710507663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8UlsJiFLJLsyZDil6IZYiUw1tiZZReAlV6tZXNBXvIo=;
 b=i+/Vvzz4TdRALs+9s+ps2xZODPfe3e8mHA8VIopRt01m5W/3YJ7F5lKKwffCylKk3T
 T4m7llL1b/h/RnTENydOuFtS3i+WE5h4UogrlPEIjsOlUlsWlMM4Jg/npVhzqmDuD4YO
 yrA8Bm8RTwu5cXXwloD6wgupRUPv/8ZTM6Xo9F5N5UABHiDDydDZFbp/jJ02Sxn6E8Ws
 Kgktk96zhhZGJRrpKpFZsccf+zihoWyhVwLl42e8VzPfEwz0XT4NbnEAC8lSDCYoFfy9
 omYud6Xt+2TpsROo6NP+2wk8cLyDst6MkZ7pO1CAXiYhGUYe0NIuM+DeUkzQGJjc2cQO
 umFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDBECzUUhc0zuHDe+Sn0cz5unMXicnwnpZhfpro4bTslN1MZ4bO+hJk5136aWR7Ab3UvPOc8jZEGxVEIBX2eLzhtN3ASI=
X-Gm-Message-State: AOJu0YyFAtOroV5tnHXvBZJnGjCVpFJ6sXLyf2QlpqiddyHGt31hhHoA
 rsj3GbQqKo03p7SJgwIjqAnFcDNz6WWY0r//zUPykqqMGjtul4Pdq25JpaSi5sSk1hDRUMF3+Mw
 c816oCOyKJEZESUk3YoncXqYzhFo9maTZR55c0cq5HgdjypFe0C70
X-Received: by 2002:adf:979a:0:b0:33e:7866:80d with SMTP id
 s26-20020adf979a000000b0033e7866080dmr193353wrb.4.1709902863103; 
 Fri, 08 Mar 2024 05:01:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJAvLgOcKXrXkb5YwUtqw1/2NoGIoT1FpdmYNF/ecgkcEhO/dnRjavEQ2o9RU8LOV+AunzoQ==
X-Received: by 2002:adf:979a:0:b0:33e:7866:80d with SMTP id
 s26-20020adf979a000000b0033e7866080dmr193320wrb.4.1709902862716; 
 Fri, 08 Mar 2024 05:01:02 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 v9-20020adfedc9000000b0033e712b1d9bsm2737867wro.77.2024.03.08.05.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 05:01:02 -0800 (PST)
Message-ID: <57dc7442-a3ab-4b79-805f-df24befbf896@redhat.com>
Date: Fri, 8 Mar 2024 14:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/25] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
Content-Language: en-US, fr
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-17-clg@redhat.com>
 <9250446e-c48b-4465-b50c-da4fe3c1ee2f@redhat.com>
 <7202b70e-cba0-4dcf-b0a4-485e7dc3eba6@redhat.com>
 <0b9ee4ca-334c-4217-869a-2b58510a8eef@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <0b9ee4ca-334c-4217-869a-2b58510a8eef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

On 3/8/24 08:39, Eric Auger wrote:
> 
> 
> On 3/7/24 13:06, Cédric Le Goater wrote:
>> On 3/7/24 09:09, Eric Auger wrote:
>>> Hi Cédric,
>>>
>>> On 3/6/24 14:34, Cédric Le Goater wrote:
>>>> We will use the Error object to improve error reporting in the
>>>> .log_global*() handlers of VFIO. Add documentation while at it.
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>
>>>>    Changes in v3:
>>>>
>>>>    - Use error_setg_errno() in vfio_legacy_set_dirty_page_tracking()
>>>>      include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>>>    hw/vfio/common.c                      |  4 ++--
>>>>    hw/vfio/container-base.c              |  4 ++--
>>>>    hw/vfio/container.c                   |  6 +++---
>>>>    4 files changed, 23 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-container-base.h
>>>> b/include/hw/vfio/vfio-container-base.h
>>>> index
>>>> 3582d5f97a37877b2adfc0d0b06996c82403f8b7..c76984654a596e3016a8cf833e10143eb872e102 100644
>>>> --- a/include/hw/vfio/vfio-container-base.h
>>>> +++ b/include/hw/vfio/vfio-container-base.h
>>>> @@ -82,7 +82,7 @@ int
>>>> vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>>>    void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>>>                                           MemoryRegionSection *section);
>>>>    int vfio_container_set_dirty_page_tracking(VFIOContainerBase
>>>> *bcontainer,
>>>> -                                           bool start);
>>>> +                                           bool start, Error **errp);
>>>>    int vfio_container_query_dirty_bitmap(const VFIOContainerBase
>>>> *bcontainer,
>>>>                                          VFIOBitmap *vbmap,
>>>>                                          hwaddr iova, hwaddr size);
>>>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>>>        int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>>>                             AddressSpace *as, Error **errp);
>>>>        void (*detach_device)(VFIODevice *vbasedev);
>>>> +
>>>>        /* migration feature */
>>>> +
>>>> +    /**
>>>> +     * @set_dirty_page_tracking
>>>> +     *
>>>> +     * Start or stop dirty pages tracking on VFIO container
>>>> +     *
>>>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>>>> +     *              pages tracking
>>> s/pages/page?
>>
>> yep
>>
>>> for my education is the "#"VFIOContainerBase formalized somewhere?
>>
>> It's QEMU specific. See 4cf41794411f ("docs: tweak kernel-doc for QEMU
>> coding standards").
> OK thank you for the education!

Took me a while do understand where it was come from. So you educated
me also :)

>>
>>> +     * @start: indicates whether to start or stop dirty pages tracking
>>>> +     * @errp: pointer to Error*, to store an error if it happens.
>>>> +     *
>>>> +     * Returns zero to indicate success and negative for error
>>>> +     */
>>>>        int (*set_dirty_page_tracking)(const VFIOContainerBase
>>>> *bcontainer,
>>>> -                                   bool start);
>>>> +                                   bool start, Error **errp);
>>>>        int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>>>                                  VFIOBitmap *vbmap,
>>>>                                  hwaddr iova, hwaddr size);
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index
>>>> 800ba0aeac84b8dcc83b042bb70c37b4bf78d3f4..5598a508399a6c0b3a20ba17311cbe83d84250c5 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -1085,7 +1085,7 @@ static bool
>>>> vfio_listener_log_global_start(MemoryListener *listener,
>>>>        if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>            ret = vfio_devices_dma_logging_start(bcontainer);
>>>>        } else {
>>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
>>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer,
>>>> true, NULL);
>>> It is not obvious why we don't pass errp here. Also there is ana
>>> error_report below. Why isn't the error propagated? (not related to your
>>> patch though)
>>
>> When I started this series, I was trying to find a way to introduce
>> progressively the changes and this patch is preparing ground for
>> what is coming next. It could be merged with the following if you prefer.
> up to you or tweek the commit msg

ok. Let's get the initial migration part in first and then I will resend the
VFIO part.

Thanks for your time.

C.


