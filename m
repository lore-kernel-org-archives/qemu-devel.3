Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058D1C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 12:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWdY-00066y-8A; Mon, 26 May 2025 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWdR-00066Z-Qd
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWdP-0007RC-CV
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748261326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Glx3ZE+aEUbK3b+fSAb6UJf7TDKVLgLAXxwK4aNQMnw=;
 b=YXJkX+EX/HLRlGG3rbHlVkRcDnze2FjdG4NXQmUX5Y5lCRC5xqfjh6dVmtIs4r86Zrv3bT
 +e9Ma3aAFntphAgNYnQTX/LAZs6+mYrD6jGzXn+bfuE1ncfAz9vM7hJ6KcXIiHiJq60Rz/
 G8qY4jgWdVjIVrrLbN1WeldeRV7jrqg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-MdZqG1x2PqWFC9H5nJNNCg-1; Mon, 26 May 2025 08:08:44 -0400
X-MC-Unique: MdZqG1x2PqWFC9H5nJNNCg-1
X-Mimecast-MFC-AGG-ID: MdZqG1x2PqWFC9H5nJNNCg_1748261324
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so12547205e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 05:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748261323; x=1748866123;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Glx3ZE+aEUbK3b+fSAb6UJf7TDKVLgLAXxwK4aNQMnw=;
 b=sr74YenzoJM8JpD+069QqeO/WE5t37ekcA/iOY4+81k4F0EzfWir6Xdx+kQ4BaoqMY
 NB9wFUbA/9qfvHKizLBQ9OB2oZcBldtNnj8Qxd7Y0OluYMOF1bjLuf481WlMUUN5Olbk
 Ujsznb4okbfgAx/kuG4nOVCP803tHCfzgHEn22Npo8XZ+VMiaEEwmizwKEMeOlqL0BfA
 9EqBVaLn7zNAWHIFhHohdtx0AS5rnzEdY0aZtZgtFyY9vIEs0Jg5NQnQ3xVllUXBUR+t
 MtKc6/lTcx2N4pixWx8X3R1Z+RiLVzFeA9X1DtI6NOjmt3fpu4c/JP7xClaZkPkYxHsr
 c21A==
X-Gm-Message-State: AOJu0YwB9J0z0cAFOZW3S+w8SWTKImhBQnFp4cJ7u4YNl8cMolcPTlPQ
 g2aoONhinkOSU+ReP0Q1sK4dHAepKlIkLGr2At7yp8lqMjPlwMkZHAmxJDB6+TFv+1q+0dyy88v
 gGBilNDiFPOQVxHqnQBBgSdHkK7RB+Vw/5sLEv/OEfI6abC+HrnbzRROK
X-Gm-Gg: ASbGncutq2NSija1Cbxpb9msHcjUC5of/a3ISVx84ox9zKwsH2wrynXSBQezgPeOnde
 gYYiFf9OQy/xqbLsQ5zJtL5CRhqrGot7kUhOV3RXdG/XgMhlyUp0HQHBQMqmPVEBVVQEgfAzV30
 qcC8W0XZGOCu+Q8IWXdw5jI3hrFV6pzdGt09jBYmf/rc9oLNZnycTSg+9hwcMp9BBpx43Patx5P
 owdH6kx5Goa2KKEWGpXTqHJPeBBw8WtaV0U8PI6SVEFpkVgpkpiK2MQ8RDbr6JYuAkFA1x9IaZS
 Lwqajfs2M/A/SWa4vMvcQYfVncdWkcBn/45iSBr/dk/3Jick0A==
X-Received: by 2002:a05:600c:3ca6:b0:44a:b478:1387 with SMTP id
 5b1f17b1804b1-44c9465c97cmr79822505e9.17.1748261323675; 
 Mon, 26 May 2025 05:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHkDDaluNpXERncpMYCGszXtZM2cTaqlLKvjdbGEjx6smyvkTBY8ewkQECNK/MxvdYuFayxA==
X-Received: by 2002:a05:600c:3ca6:b0:44a:b478:1387 with SMTP id
 5b1f17b1804b1-44c9465c97cmr79822045e9.17.1748261323212; 
 Mon, 26 May 2025 05:08:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3dd99edsm233207885e9.36.2025.05.26.05.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 05:08:42 -0700 (PDT)
Message-ID: <28e57f32-a7f7-4bb8-af6e-483e72750c0d@redhat.com>
Date: Mon, 26 May 2025 14:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/29] vfio: add per-region fd support
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-8-john.levon@nutanix.com>
 <340d64a0-b85c-422a-ac81-4de6b10c8228@redhat.com> <aC2OEkS9IjFNiH1g@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aC2OEkS9IjFNiH1g@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/21/25 10:25, John Levon wrote:
> On Wed, May 21, 2025 at 10:11:06AM +0200, Cédric Le Goater wrote:
> 
>>> -     * Fill in @info with information on the region given by @info->index.
>>> +     * Fill in @info (and optionally @fd) with information on the region given
>>> +     * by @info->index.
>>
>> The whole VFIODeviceIOOps struct needs better documentation. The arguments
>> are missing.
> 
> Will add another preparatory patch, thanks.
> 
>>> @@ -29,6 +29,7 @@ typedef struct VFIORegion {
>>>        uint32_t nr_mmaps;
>>>        VFIOMmap *mmaps;
>>>        uint8_t nr; /* cache the region number for debug */
>>> +    int fd; /* fd to mmap() region */
>>
>> Could you split this change ? I am not sure it is needed.
> 
> The idea was to avoid having every bit of code that needed the region fd having
> to remember to do:
> 
>>> @@ -278,7 +283,7 @@ int vfio_region_mmap(VFIORegion *region)
>>>            region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
>>>                                         MAP_SHARED | MAP_FIXED,
>>> -                                     region->vbasedev->fd,
>>> +                                     region->fd,
>>
>> Would this work ?
>>
>> 		vbasedev->region_fds ? vbasedev->region_fds[region->nr] : vbasedev->fd,
> 
> That is, region->fd is *always* correct, and there is less chance of a bug where
> somebody incorrectly uses vbasedev fd instead. IMO "region->fd" is much
> cleaner/clearer.

maybe. It's only used in one place : vfio_region_mmap(). I think caching the
fd value under VFIORegion is overkill.


Thanks,

C.



> 
> But, if you don't like that, yes, I can drop region->fd in favour of the above.
> 
> thanks
> john
> 


