Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC081C0218F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 03:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcc2X-0002AO-Na; Mon, 27 Jan 2025 22:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcc2U-00029b-Lb
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 22:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcc2S-0004q0-U2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 22:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738033998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v6WjQrvYlqnmxWAy8CB0l3zm04AMhXgKt+vO4cKxkLw=;
 b=R8GR79UcwV0B8t+v2GmfTug6o/6Gh/Ai2eoXOCTME4JxrCdhKs09JSdeNFeiL/UVMG58nK
 soz2iLoweS/ydyaTXWtKH3M9ix3F9YK0aHdsbjH0361LR9aLGEHC5cceA8LL5toiEespJ1
 1YeHIbP0l8oR27n9TXh0E5lHVcoLnH4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-OusSytQaMfyQnd8UO5nGwg-1; Mon, 27 Jan 2025 22:13:16 -0500
X-MC-Unique: OusSytQaMfyQnd8UO5nGwg-1
X-Mimecast-MFC-AGG-ID: OusSytQaMfyQnd8UO5nGwg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aaf8f016bb1so512004166b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 19:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738033995; x=1738638795;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6WjQrvYlqnmxWAy8CB0l3zm04AMhXgKt+vO4cKxkLw=;
 b=bwkLta/+hNp5CDOM4qp3pe7iboO4lq7c8cArHehsoZ1fACtFmfd/xvG7iJmtKEjLSd
 7vYM9OJ+1+mctPxW7iCCv+optklm87Y6axrBnCAcuEkveXocwXP4P68ZiOQyJFVKIMVg
 FfpjMHq7FHtOw7KF7jhol3EfKxot+6AmFXveW7n+YDVV3EuVSC3OpBl4rXo1SUpB9Dff
 FjEpakatj6K+YnfkzzKs7JIEWnPUIBq4X9ZlVWzSkGk79Md1o0k1nQMV7/Ot5QbTQrZ5
 ZfnLNvMJ82zRqMJ8tA2o8ttN/tqZstR5gl4bfsCBixFJFtZ2l6o/X7bStXnhBJ+ANBAQ
 p/FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc2ARO07MhTp0v74CBwtZ9podzixoPVFNkAOIBxp4Sh+tUSGOMFD7LI27u03RbuwI7OBZrfPPbPmnD@nongnu.org
X-Gm-Message-State: AOJu0YwJvzePyBPG4RDp9+9YTJa0/QJ0DOXy5QKWd5Yj7F7JxYHiTJPI
 kdojdFEdkWH6MacaVsm1kM2RrNkTaCg46Xx+vYSNRRy3iBqlHFjLHVcr8TU3nS6q1ih/praDAtj
 NQw66PyyHIJZYB9zNGOhQCIW0OUpKaAK3OjWCes3PCe5b02qGQlGb
X-Gm-Gg: ASbGncvlbvmXRTquKFXn4NdK7ubWy8QHjkbE5ZsTSO3lgqvbWXkjMZyyr4pFKNOrUbJ
 piirtZzkOYef1UQldVnNaZEjlJjm6UJvy/IRIBaV7hQSuY3ScZO+sXIPSJLSH+XvJznj/UMcVUK
 36jt8SSMgOCxYeqnXkIlQnzVwMwqHB+faJ/f21C4LZKMIkiWd7eqTjuetKK6bk91kysA0FHwJzA
 y5lvGcae7At1ghP3fU1tQnHEQiyGOapy/9KZ/dPYS401Ce6pjYabANkC3niSXuYOs4GH84FcnQe
 ynRWF6IpfsEdVwMtMb+lI1SEZW7CGxcI+NeL
X-Received: by 2002:a17:907:805:b0:aa6:7c8e:8085 with SMTP id
 a640c23a62f3a-ab38b1100f2mr4029284366b.15.1738033994817; 
 Mon, 27 Jan 2025 19:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlQ7Vf3UlU8xDCnVlfmgLtGaa+De66XlYqMsFBZXBv4ywHq6G67QUykGD7/d1yiz0cFEIdwQ==
X-Received: by 2002:a17:907:805:b0:aa6:7c8e:8085 with SMTP id
 a640c23a62f3a-ab38b1100f2mr4029281766b.15.1738033994403; 
 Mon, 27 Jan 2025 19:13:14 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760b70a7sm690112266b.116.2025.01.27.19.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 19:13:13 -0800 (PST)
Message-ID: <5063ea9f-40d7-467c-b854-cbc935a15fbb@redhat.com>
Date: Tue, 28 Jan 2025 04:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, clegoate@redhat.com, qemu-devel@nongnu.org
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
 <20250124202115.349386-2-mjrosato@linux.ibm.com>
 <209cba11-2fb3-404f-bbe4-e02b8e2595dd@redhat.com>
 <6881033c-efb8-4276-aae7-234e611d5fb9@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6881033c-efb8-4276-aae7-234e611d5fb9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27/01/2025 21.45, Matthew Rosato wrote:
> 
>>>    #include "hw/s390x/s390-pci-bus.h"
>>> @@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>>>        }
>>>          /* currently we only support designation type 1 with translation */
>>> -    if (!(dt == ZPCI_IOTA_RTTO && t)) {
>>> +    if (t && !(dt == ZPCI_IOTA_RTTO)) {
>>
>> While you're at it, you could change that "!(dt == ZPCI_IOTA_RTTO)" into
>> "dt != ZPCI_IOTA_RTTO".
>>
> 
> ACK
> 
>>>            error_report("unsupported ioat dt %d t %d", dt, t);
>>>            s390_program_interrupt(env, PGM_OPERAND, ra);
>>>            return -EINVAL;
>>> +    } else if (!t && !pbdev->rtr_allowed) {
>>> +        error_report("relaxed translation not allowed");
>>
>> Not sure, but maybe better use qemu_log_mask(LOG_GUEST_ERROR, ...) instead?
>>
> 
> Hrm, this one I'm not so sure.  If I force this path and we give back the operand exception to the guest, the guest kernel is going to panic as a result.  We are very much in a "that wasn't ever supposed to happen" path, just like the unsupported dt above, because we already reported what we do (not) support via CLP.
> 
> I just tried to force the path with default settings + the above change, and I don't see anything in the qemu log from qemu_log_mask(LOG_GUEST_ERROR, ...) but I do with error_report.

The qemu_log_mask() stuff has to be enabled on the command line with "-d 
guest_errors".

>  Given the unlikely scenario that we reach this path and the potential ramifications, I think I'd rather leave it as error_report unless you've got a strong opinion on it!

Ok, fine for me, too.

  Thomas


