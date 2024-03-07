Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B96BC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCWX-0005EN-B8; Thu, 07 Mar 2024 07:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riCWU-0005AW-8e
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riCWR-0005fb-TX
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709813210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqLNZtKKzJp+wo8PF9wPGvq/IGCF2nsRyWfkY6OmsuE=;
 b=aAl3Zsc6CiFUSAruMVoxhtrNqMDFTFtgh9KgOhrxumZkN0B1DFKfrlkJp/Icoe+n2ia11W
 0jGQ/IHCIzWNAWzJYZXJt0v4alK59Jvq97SrZWBZ9Xt3B/wQNOmR+kJ30SgdGFGE7BH5Rg
 Y1wvhrY8+5LMZ0HCFszoEa6aQ0ygOJQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-20mL4WB0ObCIr24Axy0BeA-1; Thu, 07 Mar 2024 07:06:48 -0500
X-MC-Unique: 20mL4WB0ObCIr24Axy0BeA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d8d208be9so478610f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709813206; x=1710418006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tqLNZtKKzJp+wo8PF9wPGvq/IGCF2nsRyWfkY6OmsuE=;
 b=kFTdqjSrCIJNmYgExtEp2nix3kxTzTLC5fo3EzKEflVyGVfbERSS75WKltUDrITjy9
 WfutDMEY0dwz/s0PIzFKWRgzcj2iINDOEzqbd3yTDZ5aBobRylnRI/9SIFjeeuqTRuy2
 vN5iUEyc3QLh5/6m18H7brTYltkmEw3jVBsJr3LpxBp5TN47+fk9dfnbQKbb2LqqQL+b
 sHSRTdJW2c1xGXHc7P4NGM/gdR46zHzjOKlBvKymmNr4Ay5np7c4cYhz8AiZM9a2leeu
 5x0BGJDBaM/JQKY62tvuGO+cU0CG+CaStqbPQq1QyglZEqRAxvAIKNW1KtMHuozLAPcK
 2NkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5+JNHURsElpCgVi/AHvL+XYt5XZt6gv37qZZBtlbZvpn+UaFptQ+E8vwnRI3aTzMKEFG9W0ZpEkGP9m0TDxLkj9R3ibo=
X-Gm-Message-State: AOJu0Yz+djH72pjVlX47EH6Kde8wwU0U0+PVdbRKEmk6dzFLwoQUoifh
 3N0nehm2L5AF4LhXNFL5QN3yF0Fo25o2bX85FGKeET2pggQW9UtvsMbu7pQVavQmOEIerOR9e0g
 PIJ0sTcBLKcnu5WYQr131/u/2OwjE0DoFrhHYw9TqswQyEXElJxLB9arJKeAc
X-Received: by 2002:a5d:5490:0:b0:33d:6ca1:3058 with SMTP id
 h16-20020a5d5490000000b0033d6ca13058mr12116097wrv.56.1709813206582; 
 Thu, 07 Mar 2024 04:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKt/XfUdwaZTRVvt7UUAI6Vh7ULLapNT4+3CuArmsuc0E4FrHVpttXpMcREsew6NCjtJn87g==
X-Received: by 2002:a5d:5490:0:b0:33d:6ca1:3058 with SMTP id
 h16-20020a5d5490000000b0033d6ca13058mr12116083wrv.56.1709813206234; 
 Thu, 07 Mar 2024 04:06:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 v13-20020adfd04d000000b0033d202abf01sm20037804wrh.28.2024.03.07.04.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 04:06:45 -0800 (PST)
Message-ID: <7202b70e-cba0-4dcf-b0a4-485e7dc3eba6@redhat.com>
Date: Thu, 7 Mar 2024 13:06:44 +0100
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9250446e-c48b-4465-b50c-da4fe3c1ee2f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

On 3/7/24 09:09, Eric Auger wrote:
> Hi Cédric,
> 
> On 3/6/24 14:34, Cédric Le Goater wrote:
>> We will use the Error object to improve error reporting in the
>> .log_global*() handlers of VFIO. Add documentation while at it.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v3:
>>
>>   - Use error_setg_errno() in vfio_legacy_set_dirty_page_tracking()
>>   
>>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>   hw/vfio/common.c                      |  4 ++--
>>   hw/vfio/container-base.c              |  4 ++--
>>   hw/vfio/container.c                   |  6 +++---
>>   4 files changed, 23 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..c76984654a596e3016a8cf833e10143eb872e102 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>                                          MemoryRegionSection *section);
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start);
>> +                                           bool start, Error **errp);
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                                         VFIOBitmap *vbmap,
>>                                         hwaddr iova, hwaddr size);
>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>                            AddressSpace *as, Error **errp);
>>       void (*detach_device)(VFIODevice *vbasedev);
>> +
>>       /* migration feature */
>> +
>> +    /**
>> +     * @set_dirty_page_tracking
>> +     *
>> +     * Start or stop dirty pages tracking on VFIO container
>> +     *
>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>> +     *              pages tracking
> s/pages/page?

yep

> for my education is the "#"VFIOContainerBase formalized somewhere?

It's QEMU specific. See 4cf41794411f ("docs: tweak kernel-doc for QEMU
coding standards").

> +     * @start: indicates whether to start or stop dirty pages tracking
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>> -                                   bool start);
>> +                                   bool start, Error **errp);
>>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>                                 VFIOBitmap *vbmap,
>>                                 hwaddr iova, hwaddr size);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 800ba0aeac84b8dcc83b042bb70c37b4bf78d3f4..5598a508399a6c0b3a20ba17311cbe83d84250c5 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1085,7 +1085,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           ret = vfio_devices_dma_logging_start(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
> It is not obvious why we don't pass errp here. Also there is ana
> error_report below. Why isn't the error propagated? (not related to your
> patch though)

When I started this series, I was trying to find a way to introduce
progressively the changes and this patch is preparing ground for
what is coming next. It could be merged with the following if you prefer.


Thanks,

C.




>>       }
>>   
>>       if (ret) {
>> @@ -1105,7 +1105,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           vfio_devices_dma_logging_stop(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>>       }
>>   
>>       if (ret) {
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>   }
>>   
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start)
>> +                                           bool start, Error **errp)
>>   {
>>       if (!bcontainer->dirty_pages_supported) {
>>           return 0;
>>       }
>>   
>>       g_assert(bcontainer->ops->set_dirty_page_tracking);
>> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
>>   }
>>   
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 096d77eac3946a9c38fc2a98116b93353f71f06e..6524575aeddcea8470b5fd10caf57475088d1813 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -210,7 +210,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>   
>>   static int
>>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>> -                                    bool start)
>> +                                    bool start, Error **errp)
>>   {
>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>                                                     bcontainer);
>> @@ -228,8 +228,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>>       if (ret) {
>>           ret = -errno;
>> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
>> -                     dirty.flags, errno);
>> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
>> +                         dirty.flags);
>>       }
>>   
>>       return ret;
> 
> Thanks
> 
> Eric
> 


