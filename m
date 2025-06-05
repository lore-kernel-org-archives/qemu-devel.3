Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285D6C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 21:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNHvY-0005eR-U1; Thu, 05 Jun 2025 17:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNHvW-0005cO-DX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 17:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNHvU-0005n2-Dv
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 17:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749158101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Z+dg0awtdZ1Vp377tncwTRIfl8+FAY5C98N27KWHKE=;
 b=MV0I/dsMcSat5Cgsj+RSQYtkQSXXEPEXwuiVw0tWcqXv3U2R2vxDGV8GkUYAtq6bVyXpO3
 Up6Yhs7mmWmlANfYr5pDALIbnKwTKsbzEHcQnSsnIlISiFuYl7AHMfpx/pVJaXa7eIoLQo
 ok1ZbMiPIWIYUsLHIjHYqvkI8iO4lPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-VQlxrgIEOwiVJVmYy-PT6g-1; Thu, 05 Jun 2025 17:15:00 -0400
X-MC-Unique: VQlxrgIEOwiVJVmYy-PT6g-1
X-Mimecast-MFC-AGG-ID: VQlxrgIEOwiVJVmYy-PT6g_1749158099
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450787c8626so7833125e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 14:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749158099; x=1749762899;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Z+dg0awtdZ1Vp377tncwTRIfl8+FAY5C98N27KWHKE=;
 b=l7g5oRdfchqKwDwhq/jPMehtPzSrnWpS17a/S0l8ate2ecR+ocOftSh0T9bJ9gi7vf
 nloPLxQFqGLLIhm7Y/oKOqcqVdgvwrzHBqumxJ3jQOsZg+Pw0TX6EOS/9zcambunzMAe
 Gnr76VjXi78eq10YjzWtwP+JthOPLGyI0Q3TOA/WN1WREvF2Xr0i/2m8tYR5u9AJZI1G
 w48bOpUSflH2JsTGiHfOvFbYTHBOC5nQRbL8NoSmb5ic7jBHhfCBrPtQ/rAk+mH+xHHn
 Ny54ZrXKURo4a9tSKHNwaUmKUadw4nmKlPSa2EOJbbUwP5hgS3nx0a9W1HS7GIZyglm0
 D2aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3IZn816ZxWSN/hxrsOhArKvAa4P5vr/y0teILVAsZSx1U1vnOb8onYMLzcDNNvkHFIcFmteY6WqZi@nongnu.org
X-Gm-Message-State: AOJu0Yye/Q2A+2AaiqRRjzl9esH213SJwC/DTKkaePhzBoh6EX9+0WLx
 mIoT+0wtL+L5lamcb7XRZiHwGYw60Kh1V2+Vgpz6MthlOQfjQl5E4B8MWSIvCK9u9mYm8Dqdb69
 hyb7N5RB/uGNtanGwRfNrHXo0scC4GU7abcFK8ur+QMMyX9C+5BKe/flt
X-Gm-Gg: ASbGnct4D6cwd/YO9uGx32OqBy3SZiBSlCwIrW8lXTZwhDAiZM7P7WLnwQNXXYvTszL
 D43P41DA30bIWk/83YSBYiV9/+85Peax6lAFtJs5aXkY283NgardALZOY7x9R2jvILiTS5LZr/P
 e0uIyYBP6EtHogTG0YJxTRyTdsgjLoF/4Lk+uyMFMcfe6kA05eiWjbFLczrLJTjuPC2DIfj/mYD
 zpx+dvDijapqvzaacWaolnaNCYSw2dzCxaSIc504uu5eZpcg05aApAe8+K3dJUxcj5IYc1xga8Q
 aF48G6bNQykonfxoDKDMGJMr2YMlDvBYU8IPwff7Jdruy43k0JrqQXUm4J9x
X-Received: by 2002:a05:600c:1c1b:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-4520139c741mr9991645e9.13.1749158099297; 
 Thu, 05 Jun 2025 14:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW5zD7UDdtrQhqs2/Xo7hVN7WDN31ArRqBqiqo5+AVIrw+ITgnuSmafKFy3C09hFGHSyBpoQ==
X-Received: by 2002:a05:600c:1c1b:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-4520139c741mr9991395e9.13.1749158098945; 
 Thu, 05 Jun 2025 14:14:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452669ada25sm1654315e9.0.2025.06.05.14.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 14:14:58 -0700 (PDT)
Message-ID: <7cf59908-89a2-4603-b0bc-29df40f2fd13@redhat.com>
Date: Thu, 5 Jun 2025 23:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
To: Steven Sistare <steven.sistare@oracle.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <65ebacc7-ee7e-4c44-92fb-e75a0a6490a8@oracle.com>
 <IA3PR11MB913659879C0B2EFF7358B229926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aa0c0091-7db4-46f3-956a-03a9f1362c1f@oracle.com>
 <IA3PR11MB9136014A45DEE58E09ED31F0926FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <b44ea0e5-340e-4baf-872b-0ab8fcb0fea2@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b44ea0e5-340e-4baf-872b-0ab8fcb0fea2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On 6/5/25 17:16, Steven Sistare wrote:
> On 6/4/2025 11:02 PM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steven Sistare <steven.sistare@oracle.com>
>>> Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>>
>>> On 6/3/2025 11:55 PM, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>> Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>>>>
>>>>> On 6/3/2025 6:40 AM, Duan, Zhenzhong wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>>> Subject: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>>>>>>
>>>>>>> If vfio_realize fails after vfio_device_attach, it should call
>>>>>>> vfio_device_detach during error recovery.  If it fails after
>>>>>>> vfio_device_get_name, it should free vbasedev->name.  If it fails
>>>>>>> after vfio_pci_config_setup, it should free vdev->msix.
>>>>>>>
>>>>>>> To fix all, call vfio_pci_put_device().
>>>>>>>
>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>> ---
>>>>>>> hw/vfio/pci.c | 1 +
>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>>>> index a1bfdfe..7d3b9ff 100644
>>>>>>> --- a/hw/vfio/pci.c
>>>>>>> +++ b/hw/vfio/pci.c
>>>>>>> @@ -3296,6 +3296,7 @@ out_teardown:
>>>>>>>        vfio_bars_exit(vdev);
>>>>>>> error:
>>>>>>>        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>>>>>>> +    vfio_pci_put_device(vdev);
>>>>>>
>>>>>> Double free, vfio_pci_put_device() is also called in vfio_instance_finalize().
> 
> Agreed, this line must be deleted.
> Cedric, this must be fixed in vfio-next.


yes. It was not merged.

Thanks to you both for the analysis. I lacked the time.

C.



