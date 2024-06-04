Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27B2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 17:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEXVT-0001IB-Rx; Tue, 04 Jun 2024 12:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEXVS-0001I3-S2
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEXVQ-0006qY-Am
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717520367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7t5oM+Eg8d/5fHxDc1fzoxj1cH6/YuKgB7bo9V6GAvE=;
 b=RAvyPrz2E/Y6s0QT0S+lotLbFgEJeEtEgBG2rQ/8YTv3lm6B/uDh2eDTjk+iWUfHWVZzx9
 U/QzJR2be+NxEEdf03ZaoKx2mJQWlB4Q/zFOp/nNKpGMKOwf6X2X0iMUCtb7ZjiHmIlAq7
 swAYRE1GYffCeRaaL1RKLyByDC8SsYg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-10uFSxkkNzO6P939L-yMcg-1; Tue, 04 Jun 2024 12:59:24 -0400
X-MC-Unique: 10uFSxkkNzO6P939L-yMcg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6f93e498e97so682152a34.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 09:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717520363; x=1718125163;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7t5oM+Eg8d/5fHxDc1fzoxj1cH6/YuKgB7bo9V6GAvE=;
 b=kYBwDgXilunJbqHnvrmJnMC0hJGFcwrqunT/WENE+j5QTm/D2SrF6OfxpBNqf8ydZ5
 Uyl6it5cuqELS6XR1T908OFlhRsBqjcBGFZSy2mQl2kHImTedCINAyKcs4bmZNwODRQP
 yU04+avzDKUCcubLtZQSDQj1GOTw3fz1WHHI/HvEBGnoVtXEj3jbqKUYTfaWwFMd7q8Z
 VVpUuEk26A+X8pRhAi2BdlX0m/TBxX9bV65/1OKf8gzSiUE65JktpPuvCBIFYSIrwtzK
 RYuAATwyWU7l1mDvrtxvqKTWyQJWwBGMp9vgsM+uSuKhuuXlryaVAvU5eCDXiixO++aG
 hwAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWox2tiFiYO7AzYGO/bi/ADSdy+KT9hIFulKQJks3ObUgj/enyRiDdJrhLSsSzip3llgGDtcTfbVaYgHjWZlxnBAeJUrwg=
X-Gm-Message-State: AOJu0YyZxIEFUcUUEen9kA4z1/YNkxhd5zi8RByMSe7cbmRq6zF/yjbw
 UhebtnA8LclP+EagibpEa4fluW7IoMDZOWzSJIPlAM8bA0QWMYrl9lb+cayOQONqW3exZfNYzP0
 GVDbCVK9+trgGgpxQ/JOekWX6d2iQlFJjs/+0piWzRrQK193Tcg5njp3NFLGR
X-Received: by 2002:a05:6808:3948:b0:3d1:fed9:a644 with SMTP id
 5614622812f47-3d1fed9a7afmr1839735b6e.15.1717520363101; 
 Tue, 04 Jun 2024 09:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr36tJBsBMBP94XhzNFWH+eSH3b5FJgQmMZ6SO2Ic1vaGG+KZBGrf4ng/jQfiFYUid67zWUg==
X-Received: by 2002:a05:6808:3948:b0:3d1:fed9:a644 with SMTP id
 5614622812f47-3d1fed9a7afmr1839720b6e.15.1717520362662; 
 Tue, 04 Jun 2024 09:59:22 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-97.web.vodafone.de.
 [109.43.178.97]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b003b75f93sm1037776d6.113.2024.06.04.09.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 09:59:22 -0700 (PDT)
Message-ID: <52d3e3df-4326-499c-9ae8-41cf04517288@redhat.com>
Date: Tue, 4 Jun 2024 18:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] s390x: Add loadparm to CcwDevice
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-3-jrossi@linux.ibm.com>
 <8240e6c8-8de1-4529-9479-73e555c1b590@redhat.com>
 <baf90d34-9894-4174-8888-4ad72c9a8cbc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <baf90d34-9894-4174-8888-4ad72c9a8cbc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 04/06/2024 18.27, Jared Rossi wrote:
> Hi Thomas,
> 
> Firstly, thanks for the reviews and I agree with your suggestions about 
> function names, info messages, simplifications, etc...  I will make those 
> changes.
> 
> As for the DIAG308_FLAGS_LP_VALID flag...
> 
>> [snip...]
>>> @@ -438,40 +473,20 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>>               break;
>>>           }
>>>   -        if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
>>> -            ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
>>> +        /* If the device loadparm is empty use the global machine 
>>> loadparm */
>>> +        if (memcmp(lp, "\0\0\0\0\0\0\0\0", 8) == 0) {
>>> +            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
>>>           }
>>>   +        s390_ipl_set_loadparm((char *)lp, ipl->iplb.loadparm);
>>> +        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID; 
>>
>> That means DIAG308_FLAGS_LP_VALID is now always set, even if no loadparm 
>> has been specified? Shouldn't it be omitted if the user did not specify 
>> the loadparm property?
> 
> No, I don't think it should be omitted if the loadparm hasn't been specified 
> because it is optional and uses a default value if not set. My understanding 
> is that the flag should, actually, always be set here.
> 
> As best as I can tell, the existing check is a redundant validation that 
> cannot fail and therefore is not needed. Currently the only way 
> s390_ipl_set_loadparm() can return non-zero is if object_property_get_str() 
> itself returns NULL pointer when getting the loadparm; however, the loadparm 
> is already validated at this point because the string is initialized when 
> the loadparm property is set. If there were a problem with the loadparm 
> string an error would have already been thrown during initialization.
> 
> Furthermore, object_property_get_str() is no longer used here.  As such, 
> s390_ipl_set_loadparm() is changed to a void function and the check is removed.

Ok, makes sense thanks for the explanation!

  Thomas



