Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD7CCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v235F-0007F5-6D; Fri, 26 Sep 2025 03:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2350-0007AQ-RE
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v234k-00046x-LY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758872459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bgmZk+js2Vz9yDQNJ1UGlADwu+5l6n7+W7KW+NXmkeY=;
 b=F5MwyAygkd3l4uusDMH/WNJqc+Krj4oVk0oHzIbDRCWbAbNonIZfRGn3kSmZa0elJfJ86H
 8tTCEl7XsLZQq1kDfJ4OF+6Vm9Bj1uDXdSFiZjsuv/VlTJIRkMxuZr0OxbTw/eBj6ttgC2
 ULM+1FSlAHRuVJZNTksNz3pQ6pxKVqc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-X9EIxhSdOoOxU_dDfNKCag-1; Fri, 26 Sep 2025 03:40:57 -0400
X-MC-Unique: X9EIxhSdOoOxU_dDfNKCag-1
X-Mimecast-MFC-AGG-ID: X9EIxhSdOoOxU_dDfNKCag_1758872456
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso982093f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 00:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758872456; x=1759477256;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bgmZk+js2Vz9yDQNJ1UGlADwu+5l6n7+W7KW+NXmkeY=;
 b=H0xxoTHCnX5cFBzhPcsReVLbj/lpkVKNanc2rcAXl9FSG+l+0GMEcUQX61IFNNGlfw
 lbx+dXFl1y9EjQvBnPnvWbDd23wXEywWoB7iCEVmuZZkD1vMeky0QdzymocbUy/VXNQQ
 VNjQ/FjmDlXqXvAoEPjj6LejRJe+qm67boGnIoI2bqe8TANEBxk4LLJg7WbkpVM7Iz9v
 KrUF6A4DyJJclq8OIYBa4gW1l+H9T5hDeyQ5L4ACFfIYSquXGjGf77mC/KGPkcT+7WA+
 /Z+D5t4TDCqUSjcP3HLBGQtPEu52g78pZLODU4L7dm3v5t1LhrQCg0XKRePaRVsysEFa
 nrQw==
X-Gm-Message-State: AOJu0Yz+M7xsTlYh6Z+HNvGYUKhRBwWbU5NISCI/SBtNPl7ZC2YrR//B
 W0Z5mSHxyLN4Zx0iNbdKp3MY1+ali730Kvls88zRx2zhTSCDCQe4x2a79xJ3MpTY9UlpQh/bqXB
 pKyba8N/6lk+WqKk1ndGoxnmQpDSDOX5Yy5Z89n9Ph7xjX7CuYeogHTVJ
X-Gm-Gg: ASbGnctcf59lTHU2IAWjeLU3spyafpvOzQoEW8FgIJC4ZiK/DR7gy8tu0FbN5xphpBl
 Y4FvmHVntv2fL4gSpMRrduIe/LB5Sg3qYFKEdBPZuPCjnnY+CPnq1LUMUtdyJnj5emGYNvpF46r
 Rxz68HjqLr3ncZfzo8RZ9+zEdX/cevSjJtiZL2m+lObakP68T2dCBdsdcSUy+UfFbtXsLZYF/E+
 MTmrcs8oGHNz8LY6M+WinTwURynufjhUjE3GV7eJkUkrjxGsSZCsP0Hz52LDWWSq/9KWgvu9lH2
 cvdWBP4/C76/pf1qMenrHCky4LGv3dsYa8nJe8ZPFERX1jcyocBV6CDxwtaAZwAySlQlwcIQHKA
 8YRA=
X-Received: by 2002:a05:6000:2381:b0:3ee:1461:166c with SMTP id
 ffacd0b85a97d-40e497c34b8mr5988717f8f.5.1758872455892; 
 Fri, 26 Sep 2025 00:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5gJ42YcMP4Zpmno8L2e6wUWpvsx/K+yCNJaRVal7iPTX/8euNegS4TBpfysmlkn801FN20w==
X-Received: by 2002:a05:6000:2381:b0:3ee:1461:166c with SMTP id
 ffacd0b85a97d-40e497c34b8mr5988698f8f.5.1758872455474; 
 Fri, 26 Sep 2025 00:40:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm6124045f8f.37.2025.09.26.00.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:40:55 -0700 (PDT)
Message-ID: <1b384231-fe7a-4f13-a30e-2c8c1b9f1563@redhat.com>
Date: Fri, 26 Sep 2025 09:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
To: Markus Armbruster <armbru@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mjrosato@linux.ibm.com,
 thuth@redhat.com, alex.williamson@redhat.com
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com> <87qzvtstd7.fsf@pond.sub.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <87qzvtstd7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/26/25 06:57, Markus Armbruster wrote:
> Farhan Ali <alifm@linux.ibm.com> writes:
> 
>> Provide a vfio error handling callback, that can be used by devices to
>> handle PCI errors for passthrough devices.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/vfio/pci.c | 8 ++++++++
>>   hw/vfio/pci.h | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index bc0b4c4d56..b02a974954 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>   static void vfio_err_notifier_handler(void *opaque)
>>   {
>>       VFIOPCIDevice *vdev = opaque;
>> +    Error *err = NULL;
>>   
>>       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>           return;
>>       }
>>   
>> +    if (vdev->err_handler) {
>> +        if (vdev->err_handler(vdev, &err)) {
>> +            return;
>> +        }
>> +        error_report_err(err);
>> +    }
> 
> This is unusual.

and the compiler complains :

../hw/vfio/pci.c: In function ‘vfio_err_notifier_handler’:
../hw/vfio/pci.c:3076:9: error: dangling pointer to ‘err’ may be used [-Werror=dangling-pointer=]
  3076 |         error_report_err(err);
       |         ^~~~~~~~~~~~~~~~~~~~~
../hw/vfio/pci.c:3066:12: note: ‘err’ declared here
  3066 |     Error *err = NULL;
       |            ^~~
cc1: all warnings being treated as errors


C.


> 
> Functions taking an Error ** argument usually do so to report errors.
> The rules spelled out in qapi/error.h apply.  In particular:
> 
>   * - On success, the function should not touch *errp.  On failure, it
>   *   should set a new error, e.g. with error_setg(errp, ...), or
>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>   *
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
> 
> If ->err_handler() behaved that way, it @err would be null after it
> returns false.  We'd call error_report_err(NULL), and crash.
> 
> Functions with unusual behavior need a contract: a comment spelling out
> their behavior.
> 
> What is the intended behavior of the err_handler() callback?
> 
>> +
>>       /*
>>        * TBD. Retrieve the error details and decide what action
>>        * needs to be taken. One of the actions could be to pass
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index e0aef82a89..faadce487c 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -146,6 +146,7 @@ struct VFIOPCIDevice {
>>       EventNotifier err_notifier;
>>       EventNotifier req_notifier;
>>       int (*resetfn)(struct VFIOPCIDevice *);
>> +    bool (*err_handler)(struct VFIOPCIDevice *, Error **);
>>       uint32_t vendor_id;
>>       uint32_t device_id;
>>       uint32_t sub_vendor_id;
> 


