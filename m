Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5657CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 07:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Ozq-0004tN-Nk; Sat, 27 Sep 2025 03:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2Ozo-0004tF-Nu
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 03:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2Ozl-0003nR-Py
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 03:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758956720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zDFIVESDUNDAMtYggAF2j/3vyPpC85ftES5f2be7WJM=;
 b=jReGMQFg5GiiRghts5TOND92nPj9iUIk3IJ+pLP4rw3pSMSkJU3yMbUlOYEDVqLIuSexTW
 IioSA/RfxFT6fJODz1ZZzqfxBaYgaZi0sm4M0n94S5McTzwuN4+Q4fTKFi6ScUVZhDuglj
 SxRe7aCr+zDNKcI9lxpUpf4oWiC9CX8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-7l8xzthjOrqDeDELWX64bg-1; Sat, 27 Sep 2025 03:05:17 -0400
X-MC-Unique: 7l8xzthjOrqDeDELWX64bg-1
X-Mimecast-MFC-AGG-ID: 7l8xzthjOrqDeDELWX64bg_1758956717
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e38957979so10827765e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Sep 2025 00:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758956716; x=1759561516;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zDFIVESDUNDAMtYggAF2j/3vyPpC85ftES5f2be7WJM=;
 b=N2DSsrNUGqhexdTdhEjPBZ6UL4tpNSBiIDiqb6NHAoFuyyVwCv8CRCmsiPp6kKIdFP
 hWVn3BWShz5I08XaBXQ3w2FRyiK042FmP02unq6Bb4H+FnFnsIwc5Ob6R4Oxm5UldvYX
 8pDt/k7BjXgz/JavT6RH8WNZZJlLzMuawTC94cyn86jYY1/MYDdURXvU3yJno+IaS2tZ
 eA3nDJN/mNqPKxuX5H6Z2gRxJbEGEpTwCNqBA8R02mQgibmHTxU2vwqutlzirEIPyzZv
 KQaprt7JtAcsvVG1y9rAGykmBiq6Wx8keikzpZBxRYxFxAwbCL+qvYR96qt/VexvxPpX
 NSOQ==
X-Gm-Message-State: AOJu0Ywi0ze6IDfo4mWtoDqJAx+yYDhKzOjw7ui1nEe/AeWFIwPmBBqR
 XaKKOEsUUwCirncdbDNuogXpYPt0KNgLiL946KmzQIM+PRRwe0vePX7nPeCpOt9HzT0LlJZ5SRg
 YePwMOuSOHt1XJEPPPUr2wYtS85487cP9iXVCQtiyRLe05G9f+Rp27m37
X-Gm-Gg: ASbGncuHmkM59eSt1JAufHfLtZBQXa7mumETLTf6in7XVsCI9d4FfkrCV9wkkzHZhC3
 50NGIebT6kD/L58bFKF6938jf2Krp8SOTWcvpnrle/AXpTdRktonXPPYIdi4YGsL1t0TmRemzts
 lj7RktwvIOhQXhTz1Tu6UpcOQEeU38tm0dhYm5J/toYU+nW8wLCzIsnW7UxST9wk522juJ6l1rn
 jC1iFsCDBvKznnV2Wmxcah1VJh6cPPVbNvLLgTGSFmWuKFkM3iuBQILBZQbt9gLw/RJzdvxcMiA
 EAKpwBfkq0KEOcOQVPzITu7tG+8iKtIvT8bcLOdFH3/FQJ2cBGrCnb5tDnQ5UDNwk4h7w7i0Vig
 l35JMIsiARfM676YlB/vKeWmOvBlEzLs7xNiZkwo3rIH+eW01pBbzVs9/dwal1vZKJIpbDA==
X-Received: by 2002:a05:600c:4d18:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-46e32a1c5b8mr61565235e9.37.1758956716494; 
 Sat, 27 Sep 2025 00:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtmtPkl7ttxsVTh52Mblcz0zX8FSYK5RWEULAxirJjUay6HvrxetY5hGa8ukNanGLMcftHzQ==
X-Received: by 2002:a05:600c:4d18:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-46e32a1c5b8mr61564985e9.37.1758956715916; 
 Sat, 27 Sep 2025 00:05:15 -0700 (PDT)
Received: from ?IPV6:2a01:cb01:305e:3128:cc60:67bc:12c9:1f8e?
 (2a01cb01305e3128cc6067bc12c91f8e.ipv6.abo.wanadoo.fr.
 [2a01:cb01:305e:3128:cc60:67bc:12c9:1f8e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e336f2425sm48617205e9.10.2025.09.27.00.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Sep 2025 00:05:15 -0700 (PDT)
Message-ID: <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
Date: Sat, 27 Sep 2025 09:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
To: Markus Armbruster <armbru@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mjrosato@linux.ibm.com,
 thuth@redhat.com, alex.williamson@redhat.com
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com> <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
 <87ms6gmo4j.fsf@pond.sub.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <87ms6gmo4j.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/27/25 07:59, Markus Armbruster wrote:
> Farhan Ali <alifm@linux.ibm.com> writes:
> 
>> On 9/25/2025 9:57 PM, Markus Armbruster wrote:
>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>
>>>> Provide a vfio error handling callback, that can be used by devices to
>>>> handle PCI errors for passthrough devices.
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    hw/vfio/pci.c | 8 ++++++++
>>>>    hw/vfio/pci.h | 1 +
>>>>    2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index bc0b4c4d56..b02a974954 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>>   static void vfio_err_notifier_handler(void *opaque)
>>>>   {
>>>>       VFIOPCIDevice *vdev = opaque;
>>>> +    Error *err = NULL;
>>>>
>>>>       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>>           return;
>>>>       }
>>>>
>>>> +    if (vdev->err_handler) {
>>>> +        if (vdev->err_handler(vdev, &err)) {
>>>> +            return;
>>>> +        }
>>>> +        error_report_err(err);
>>>> +    }
>>>
>>> This is unusual.
>>>
>>> Functions taking an Error ** argument usually do so to report errors.
>>> The rules spelled out in qapi/error.h apply.  In particular:
>>>
>>>    * - On success, the function should not touch *errp.  On failure, it
>>>    *   should set a new error, e.g. with error_setg(errp, ...), or
>>>    *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>>    *
>>>    * - Whenever practical, also return a value that indicates success /
>>>    *   failure.  This can make the error checking more concise, and can
>>>    *   avoid useless error object creation and destruction.  Note that
>>>    *   we still have many functions returning void.  We recommend
>>>    *   • bool-valued functions return true on success / false on failure,
>>>
>>> If ->err_handler() behaved that way, it @err would be null after it
>>> returns false.  We'd call error_report_err(NULL), and crash.
>>>
>>> Functions with unusual behavior need a contract: a comment spelling out
>>> their behavior.
>>>
>>> What is the intended behavior of the err_handler() callback?
>>
>> Hi Markus,
>>
>> Thanks for reviewing! The intended behavior for err_handler() is to set errp and report the error on false/failure. With the above code, I also intended fall through to vm_stop() when err_handler() fails.
>>
>> I think I misunderstood the errp error handling, it seems like the correct way to do what I intended would be
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index b02a974954..630de46c90 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3070,10 +3070,11 @@ static void vfio_err_notifier_handler(void *opaque)
>>       }
>>
>>       if (vdev->err_handler) {
>> -        if (vdev->err_handler(vdev, &err)) {
>> +        if (!vdev->err_handler(vdev, &err)) {
>> +            error_report_err(err);
>> +        } else {
>>               return;
>>           }
>> -        error_report_err(err);
>>       }
>>
>> Please correct me if I missed anything.
> 
> Resulting function:
> 
>     static void vfio_err_notifier_handler(void *opaque)
>     {
>         VFIOPCIDevice *vdev = opaque;
>         Error *err = NULL;
> 
>         if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>             return;
>         }
> 
>         if (vdev->err_handler) {
>             if (!vdev->err_handler(vdev, &err)) {
>                 error_report_err(err);
>             } else {
>                 return;
>             }
>         }
> 
>         /*
>          * TBD. Retrieve the error details and decide what action
>          * needs to be taken. One of the actions could be to pass
>          * the error to the guest and have the guest driver recover
>          * from the error. This requires that PCIe capabilities be
>          * exposed to the guest. For now, we just terminate the
>          * guest to contain the error.
>          */
> 
>         error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
> 
>         vm_stop(RUN_STATE_INTERNAL_ERROR);
>     }
> 
> Slighly rearranged for clearer control flow:
> 
>     static void vfio_err_notifier_handler(void *opaque)
>     {
>         VFIOPCIDevice *vdev = opaque;
>         Error *err = NULL;
> 
>         if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>             return;
>         }
> 
>         if (vdev->err_handler) {
>             if (vdev->err_handler(vdev, &err)) {
>                 /* Error successfully handled */
>                 return;
>             }
>             error_report_err(err);
>         }
> 
>         /*
>          * TBD. Retrieve the error details and decide what action
>          * needs to be taken. One of the actions could be to pass
>          * the error to the guest and have the guest driver recover
>          * from the error. This requires that PCIe capabilities be
>          * exposed to the guest. For now, we just terminate the
>          * guest to contain the error.
>          */
> 
>         error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
> 
>         vm_stop(RUN_STATE_INTERNAL_ERROR);
>     }
> 
> Questions / issues:
> 
> * Is the comment still accurate?
> 
> * When ->err_handler() fails, we report the error twice.  Would it make
>    sense to combine the two error reports into one?

Yes. It was my request too.

Thanks,

C.



> * Preexisting: the second error message is ugly.
> 
>    Error messages should be short and to the point: single phrase, with
>    no newline or trailing punctuation.  The "please collect ..." part
>    does not belong to the error message proper, it's advice on what to
>    do.  Better: report the error, then print advice:
> 
>         error_report("%s(%s) Unrecoverable error detected",
>                      __func__, vdev->vbasedev.name);
>         error_printf("Please collect any data possible and then kill the guest.");
> 
>    Including __func__ in an error message is an anti-pattern.  Look at
> 
>      vfio_err_notifier_handler(fred) Unrecoverable error detected
> 
>    with a user's eyes: "vfio_err_notifier_handler" is programmer
>    gobbledygook, the device name "fred" is useful once you realize what
>    it is, "Unrecoverable error detected" lacks detail.
> 
> [...]
> 


