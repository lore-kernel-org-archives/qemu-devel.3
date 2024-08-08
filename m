Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F030C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2OQ-0005vK-N8; Thu, 08 Aug 2024 08:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sc2OO-0005l9-2r
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sc2OL-00071I-Bt
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723120635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+8ob7gJEf6qO/CnE5YoM1ikjgB5Hl9vQE6388s1Q3RE=;
 b=UWs/thRVLInxfV0vWsBYl8slmUP4Hyt3kVSUDEZ4vtTLhIQPyyGaVQl4riKGvCW6DYcn+b
 k6foL4uxEC9d7PyhHLUSFCz85ulknbnn7DpT/UpCO95IqoSDvvYu2E5S1NmHOxbIybVdNN
 nE7I8dpQTFL6M65b0wZxXOrdNWIYvSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-PYVRheWrMtG0NKWy-R0lrA-1; Thu, 08 Aug 2024 08:37:13 -0400
X-MC-Unique: PYVRheWrMtG0NKWy-R0lrA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42820af1106so6191735e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723120632; x=1723725432;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+8ob7gJEf6qO/CnE5YoM1ikjgB5Hl9vQE6388s1Q3RE=;
 b=KEiAvRpryptyFX21WGB2TYBuw2sEQUCEAlNm+fLAJ1ohlJeAJt5e46KbNtP6LoWGve
 wV5l08Aqx3EKd/87dqn85kSfs0T4bQouDQOf52FBgGJ7oQOijiD52sMzdL8pH81FMXlY
 0R3NL4YUo1XlpsVE3aOejsC93/9ii8uRXt+VIIkZfThs0uelIbkhqDaYA4RV3v+Evp7J
 4XO3NC2DBPo7PU7t3S3MU14tmj4OfDfWXyLNOrnd8AFxxF1CbTSrMZ/wp1Dh8NV/kEC6
 8CMLTSF0iiQ/+CC7XeFyPahkOBFOclTAYda3j5S+smueVhKa2f4AnSYbcRHHVaIPsNtr
 9ASg==
X-Gm-Message-State: AOJu0YxkcrhVnu/XKmJOWrBkcMwPEQb0mEePbZkeDRaHvYiXAbNPxEZo
 4+ud5nrgoxf7P5jXTDrfxPYZ/zRMfsnvH+q7jdXb168O9pnfMcsX3CZ2eutytUrDVpwn95sHbf7
 C+XYEX5XA5ZwTxoyDUYNHjttlQr8fXVMIKW+4742LZA5kBwoZy6TN
X-Received: by 2002:a05:600c:4f95:b0:429:a05:32fb with SMTP id
 5b1f17b1804b1-4290aeee340mr12483505e9.10.1723120632302; 
 Thu, 08 Aug 2024 05:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjGlXPyI0VmWPDrSOA8eGj5LT2XvVH5X2HLlCl8+nRHh/eAK2VpW8uPyikcnNjvw2+IAhikQ==
X-Received: by 2002:a05:600c:4f95:b0:429:a05:32fb with SMTP id
 5b1f17b1804b1-4290aeee340mr12483305e9.10.1723120631794; 
 Thu, 08 Aug 2024 05:37:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6?
 (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de.
 [2003:cb:c713:2a00:f151:50f1:7164:32e6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c74aa5dsm21322135e9.26.2024.08.08.05.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 05:37:11 -0700 (PDT)
Message-ID: <5aabd401-af44-4c2b-9b91-1bf2877d2310@redhat.com>
Date: Thu, 8 Aug 2024 14:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] virtio-mem: Implement Resettable interface instead of
 using LegacyReset
To: Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-4-jmarcin@redhat.com>
 <CAFEAcA8ENru8Cb9DKi_PaQYkox397ZxhPjFbf7ioHjKhAHqKXA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFEAcA8ENru8Cb9DKi_PaQYkox397ZxhPjFbf7ioHjKhAHqKXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08.08.24 14:25, Peter Maydell wrote:
> On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
>>
>> LegacyReset does not pass ResetType to the reset callback method, which
>> the new Resettable interface uses. Due to this, virtio-mem cannot use
>> the new RESET_TYPE_WAKEUP to skip reset during wake-up from a suspended
>> state.
>>
>> This patch adds the Resettable interface to the VirtioMemClass interface
>> list, implements the necessary methods and replaces
>> qemu_[un]register_reset() calls with qemu_[un]register_resettable().
> 
>> @@ -1887,6 +1897,7 @@ static const TypeInfo virtio_mem_info = {
>>       .class_size = sizeof(VirtIOMEMClass),
>>       .interfaces = (InterfaceInfo[]) {
>>           { TYPE_RAM_DISCARD_MANAGER },
>> +        { TYPE_RESETTABLE_INTERFACE },
>>           { }
>>       },
>>   };
> 
> TYPE_VIRTIO_MEM is-a TYPE_VIRTIO_DEVICE, which is-a TYPE_DEVICE,
> which implements the TYPE_RESETTABLE_INTERFACE. In other words,
> as a device this is already Resettable. Re-implementing the
> interface doesn't seem like the right thing here (it probably
> breaks the general reset implementation in the base class).
> Maybe what you want to do here is implement the Resettable
> methods that you already have?

TYPE_DEVICE indeed is TYPE_RESETTABLE_INTERFACE.

And there, we implement a single "dc->reset", within which we 
unconditionally use "RESET_TYPE_COLD".

Looks like more plumbing might be required to get the actual reset type
to the device that way, unless I am missing the easy way out.

-- 
Cheers,

David / dhildenb


