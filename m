Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B6AC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPFe2-0004Zj-V6; Wed, 11 Jun 2025 03:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFe0-0004Za-4v
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFdx-0006ra-PW
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749625982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H5Gvt42Baqh30tYL+QPdYoGAqIbLqsVh79cmWiB4xqg=;
 b=cDLESA14le83ZRSEtZ9bzxnXgMwv1oKNC6FUUzubYrnECaMg5l0rOLdQRzlmMtCLZgskqb
 oNhmru2VTiz3rGdMqsRCwjXEfgD3KNnC1rXSEzmw52Gu7w6ybJlp3BIBGzvmcv1LgWoawd
 23lwkhrodg0HAhHZ4SG+jHMNDnbTS8U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-KWfLwySYPG6Yq4Wu_MTV2A-1; Wed, 11 Jun 2025 03:12:59 -0400
X-MC-Unique: KWfLwySYPG6Yq4Wu_MTV2A-1
X-Mimecast-MFC-AGG-ID: KWfLwySYPG6Yq4Wu_MTV2A_1749625978
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a5281ba3a4so2115931f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749625978; x=1750230778;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5Gvt42Baqh30tYL+QPdYoGAqIbLqsVh79cmWiB4xqg=;
 b=Ue14vGf6bFztC/1cgptE1NmlrOxmhMRujVBZs2FqbwmuzvvQVYZlK7z2Oem391IA4z
 kNA8z6FskAge0IcmlM8NcarL6VFpzR2a19SAgTT2phtqbZUNVZhvj7ZrmvuVX6KqBZb8
 pGzwgKBNp/Msj9EgTI1t8N/U/WxxQGmKjAAxms5MTXxGxP+YsLfY0ABx9X6Ygtc3bJ1E
 YSJVSvoQSzuVqoHoA+01B8FwWDu2JDh0oMiFuawcLXH/tH2v4HotLKAyD6W5SS/rnveZ
 76FML6bJBowmgXnr+134iNaCZbhUOPZnzi4bJo5+IBZWqsDyV4tSVOzDKfJhsopJNrk8
 tRBw==
X-Gm-Message-State: AOJu0YyVE3QUEhH4luPmz7TmxpsBbFD4U1X12RNr03KBA9aaxFCmcix4
 H3yGzYXjWqW6Ctngv0GwS0Sa69dAhF7duFOeiDBgCrkmjWF+JSUyslfvYTUqK6+kWYrLHDct5L/
 ssZYkrIp/zQLUQqqviPeWN8Aitwtsu3SU+o2B9Mx26Lo0rypLK3Mo+tFa
X-Gm-Gg: ASbGncuMtxG58+N9ep5v1kuR0zIAsk8EOPhJ8b4WWy3A62sUfgBkRS9J6n5NOcxv0N+
 36UkFm39l74vAQ8UEinVWcTD4AAwGMeG6qE+cXoeJgws6iZIxZIJTrXUFDmKm+Wi2Tp1YG2Ax/P
 wuoXbywerjk3cARLUNo8TZSvHrK+L/XTgn6BUzUHvuckWn0xV7NBdBdQ+brvdzJscIpkUjUOSaw
 GZ5dKkqmMRNoJgIWNx7bE8ADYzbm/MgccnIvSNUriXN0wdj+j/8fTjI2SJYBz2sJcxOqvtFFOW6
 4RWrhlFzd8ms2YWfxCZiAb/BZTf2E3z1DA1hagHNObP2oA81STRaGAQAW26S
X-Received: by 2002:a05:6000:1a8d:b0:3a5:276b:1ebd with SMTP id
 ffacd0b85a97d-3a558aef287mr1424527f8f.54.1749625977792; 
 Wed, 11 Jun 2025 00:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGxFkQqzV6ccCxlnGcbhuqLgcE1s3k0z3AX6Kz3GpEsyxb5Rj+I0oSdbbuy9VvTy02+emuRQ==
X-Received: by 2002:a05:6000:1a8d:b0:3a5:276b:1ebd with SMTP id
 ffacd0b85a97d-3a558aef287mr1424503f8f.54.1749625977426; 
 Wed, 11 Jun 2025 00:12:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532436650sm11645087f8f.65.2025.06.11.00.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 00:12:56 -0700 (PDT)
Message-ID: <182479e4-118f-450b-96a6-b331a6f9cb5f@redhat.com>
Date: Wed, 11 Jun 2025 09:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
 <44882230-0e48-4232-9549-9c24c09d3749@redhat.com> <aEgmbDKrjG_-luXP@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aEgmbDKrjG_-luXP@lent>
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

On 6/10/25 14:34, John Levon wrote:
> On Tue, Jun 10, 2025 at 09:42:41AM +0200, Cédric Le Goater wrote:
> 
>> On 6/7/25 02:10, John Levon wrote:
>>> For vfio-user, each region has its own fd rather than sharing
>>> vbasedev's. Add the necessary plumbing to support this, and use the
>>> correct fd in vfio_region_mmap().
>>>
>>> @@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
>>>        /**
>>>         * @get_region_info
>>>         *
>>> -     * Fill in @info with information on the region given by @info->index.
>>> +     * Fill in @info (and optionally @fd) with information on the region given
>>> +     * by @info->index.
>>>         */
>>
>> Could you please update the whole documentation of the VFIODeviceIOOps
>> struct and document each parameter ?
> 
> Sorry, not sure what you're asking for. This struct was fully documented in
> 38bf025d ("vfio: add device IO ops vector")
> and its subsequent patches.

yes. See the formatting of VFIODeviceOps :

     /**
      * @vfio_save_config
      *
      * Save device config state
      *
      * @vdev: #VFIODevice for which to save the config
      * @f: #QEMUFile where to send the data
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error
      */
     int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);


No big deal. It can come later.


>>> @@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>>>        vbasedev->io_ops = &vfio_device_io_ops_ioctl;
>>>        vbasedev->dev = dev;
>>>        vbasedev->fd = -1;
>>> +    vbasedev->use_region_fds = false;
>>
>> why not extend vfio_device_init() with a 'region_fd_cache' bool
>> parameter instead ?
> 
> I could do, but you previously asked me not to add an "io_ops" parameter to this
> function and instead directly change it here - why is this parameter different?
Because I thought we could allocate vbasedev->region_fds[] directly under
vfio_device_init().
  >> and avoid the extra VFIODevice attribute.
> 
> I don't get this - we still need to record the boolean in the vbasedev.

but we can't because we don't have the vbasedev->num_regions value yet.
So forget this proposal.

That said, there are a few contortions around the instance_init()
handler, vfio_device_init() and the realize() handler that I find
confusing. I will see if it can be improved when the code is stable
again.

Thanks,

C.



