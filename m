Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0791EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauc7-0003HR-W0; Mon, 05 Aug 2024 06:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sauc6-0003Bs-F4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sauc4-0002qU-M6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722852407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qqqarilDeosWdla69lCnBN0D4oBX8B2KiMpKAsxfoyg=;
 b=RcasI8ZokZJyx1tOzRMqHt+ihhuKDF3Ghy5nuNcdMqy/rC6AVTDoGuMF8af6MYAORsre/8
 mBUIyllx29jLmM7YiS+V6dUBwchBQ8pM5z7WBmCLlEr6iUa4ntfZRlnfbqKb+n3u34iUbw
 bJHyXGikQiNaWBIGIZ5/mM9AoSKM4Xg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-ROaXQo49PBO2eu7L5uShTQ-1; Mon, 05 Aug 2024 06:06:45 -0400
X-MC-Unique: ROaXQo49PBO2eu7L5uShTQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42816096cb8so99397045e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 03:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722852404; x=1723457204;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qqqarilDeosWdla69lCnBN0D4oBX8B2KiMpKAsxfoyg=;
 b=SXgx6FxDK0r/jx1BoWWwfWSas1ypOMDlpzwE3hO+ncfVu6Bs4HaJ7APaq4rMbwYjgD
 AlwPUwqvdwrvvSTweXpAaOd/gyyviGoAURYgGb9QNrnhmtlbWbLzGGJjzYJVrSEb9Qfc
 f14DjeCh14TMDOW27cHqKVxmT8z9IEh41TmBlB5ICr5PM/bP3PXLGMagzapXPxapwG9x
 rUF2VFbERaRQDo0UelsgSrmuTQMybnqFftYCXNGlotmkQvUpS3ndk02rmDdqwbz5zo5B
 wvRtagouKj/PU5XR35kFlPfazs0bfb7swLC8gKpRs1VBo1NUjhU9UQi4aOTTER/AtQV7
 Nexg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe+1UpPXxqehcCIsLmpoXN8jH6FAO/C9ozOaRcTd0j3TBFUevsR8/Ht5up4rPMt3/oaupxRf+8Hdg3/1H3jdtr50CvpPc=
X-Gm-Message-State: AOJu0Yzp943IN5PvmtRR7jbNzzgHR/WgH0ufW046JrzTOxSHgCk8vKXN
 jw9oJD2mGH1Bm8UwP7c7herndbVyReTBYMBroumMxFWJ8z6liw3H+7wzG07ZuWuaIrjQwu3lDk9
 2dEf2OGO4axmdjrfof/Ux5Y9YZ0rruVQAic7HhK6CEqG8wP0vfKMV
X-Received: by 2002:a05:600c:314c:b0:426:6857:3156 with SMTP id
 5b1f17b1804b1-428e6b7e949mr97055225e9.27.1722852404523; 
 Mon, 05 Aug 2024 03:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvBlqAg1optDQWZ4Brpnj59DgvSI0hZxFN9HNKO6x8jKResqApP/TNWLPe52tcXJg3WotMKA==
X-Received: by 2002:a05:600c:314c:b0:426:6857:3156 with SMTP id
 5b1f17b1804b1-428e6b7e949mr97054925e9.27.1722852404125; 
 Mon, 05 Aug 2024 03:06:44 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb6403bsm194483035e9.35.2024.08.05.03.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 03:06:43 -0700 (PDT)
Message-ID: <44a34534-993d-4352-966f-c0c2fd4008d7@redhat.com>
Date: Mon, 5 Aug 2024 12:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
From: David Hildenbrand <david@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <37d9e725-1be7-48e1-b621-3f657192f124@redhat.com>
 <Zq-hkUnPGWHMoEY0@x1n> <636cc66b-95bf-4003-9e35-9547dfbcbfd1@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <636cc66b-95bf-4003-9e35-9547dfbcbfd1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 05.08.24 11:52, David Hildenbrand wrote:
> On 04.08.24 17:43, Peter Xu wrote:
>> On Mon, Jul 22, 2024 at 10:59:47AM +0200, David Hildenbrand wrote:
>>>> So I wonder whether there's comparison between exec() and transfer mode
>>>> that you recently proposed.
>>>>
>>>> I'm asking because exec() (besides all the rest of things that I dislike on
>>>> it in this approach..) should be simply slower, logically, due to the
>>>> serialized operation to (1) tearing down the old mm, (2) reload the new
>>>> ELF, then (3) runs through the QEMU init process.
>>>>
>>>> If with a generic migration solution, the dest QEMU can start running (2+3)
>>>> concurrently without even need to run (1).
>>>
>>> I'll note (not sure if already discussed) that with the "async-teardown"
>>> option we have a way to move the MM teardown to a separate process, such
>>> that it will happen asynchronously.
>>
>> I just had a look, maybe it won't trivially work, as it relies on QEMU
>> process to quit first..
>>
>> async_teardown_fn():
>>       if (the_ppid == getppid()) {
>>           pause();
>>       }
>>
>> While if we stick with exec(), then PID shouldn't change, so the teardown
>> process can hold the mm and pause until the VM is destroyed..
> 
> Right, the mechanism would have to be extended to realize that exec()
> happened. Notifying the child before exec() would be undesired, so it
> would have to happen after exec() from the changed parent.
> 
> Sounds doable, but certainly doesn't come for free!

I did not look deeply into this, but possibly using a pipe between both 
processes created with O_CLOEXEC might do. Anyhow, something to look 
into if really required :)

-- 
Cheers,

David / dhildenb


