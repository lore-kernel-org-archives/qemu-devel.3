Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67597E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCgs-0003yx-2E; Thu, 19 Dec 2024 04:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOCgb-0003x3-6T
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOCgY-0007La-7l
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734599947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mk7bALXoQFTig4g1/hCH0UsQyuV25G2kh7ydrcfI8pA=;
 b=beRLFYjQxL9ULwStaERBbl5ZzPVEY0r0WjGkunybq+SQ7+ZehD//l8IDI9TTQY/fiEviVz
 yXUKUi+szO4/5qcou2oPtsdg2hmGVqclJsMQdhXQjzT27GtvMIl8g/4LHFkiIFQKm3iHi6
 HBpeMSHT9hqKys/BJpIkIoH5EBIJeww=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-OXPxKdtQPcWruWCVTZ4L5Q-1; Thu, 19 Dec 2024 04:19:05 -0500
X-MC-Unique: OXPxKdtQPcWruWCVTZ4L5Q-1
X-Mimecast-MFC-AGG-ID: OXPxKdtQPcWruWCVTZ4L5Q
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6c51069f5so70769485a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734599945; x=1735204745;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mk7bALXoQFTig4g1/hCH0UsQyuV25G2kh7ydrcfI8pA=;
 b=Jsk1PnYpvq7z3YIcv7e63kSwpRQt71CVswtpuhh4NJHI4s0MP5ocsoviXeGmt36Hev
 RSM/Tk7m+Y6ZGiSuFTfiKjPmC1VJt/IzuLxoVQNjEwe3SmnX5oNk+F4AziWd8lb0pKRa
 /iOoNqjqw4Fp7CISXcGVhp04Uv8J10ZfFWLUam+YBvKn32WKrX5+lubkyDAy6XJ8V/Q/
 j1EEZwavECTsulQphMU/HXXP7DLnltvJ1b5Cn7SNtZ5rOeriHkVEF9/Je9b25P8MZB73
 +0FD6XRngZ6Pm9zaKWw4rA46m4rsZCoUP1TMxCo8H25VaoR3cC1z8ONlRUda86NxTnLT
 FfLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW9k2mFcNUyX36/z+qp6ZMt7Z8dq8JYyp3kpUsHsovAHTcQyHhZ5+2wv0wVLYaq9JNurAs4Atg4Yxy@nongnu.org
X-Gm-Message-State: AOJu0YwAdmmeRBkoSrPucaaHYuSAZoPsLJA2QbWXfS+YrpHA9cHOg5m8
 ya0EltRp6FPclUh7D82QNXoI7XWRpRWOwugUKieb/3Kll7wDRkDpgFhm1j7biLvCbig0nZzypa7
 UZ+TRIS2KFMITuFy8j7BCYFXWxobf/JapllQ7DfIpCzrv9kWVBfgD
X-Gm-Gg: ASbGncu2SN2OHM9LsGHHFgxgyZPy8Wke7BcVMTFvZ2M0wldTCFpTH2M5p5XU3qrXUNV
 ClnkVnMFtHcVJzrjFTWLoG1xo6mQbRFi8kT9PJR2gqCqaYSqnfU8QG322qYFf8uggRpUPLEzhqY
 mBIvZDeqOQJC6fUsrxU1kKIFJm1t/ls51836tw1A2rWOlaLM4JXZjvEJHEzyl7zFFvQqcL/K5ce
 dSCjWuzVTRWf+7G40X+eottVUhvCuncWS4yxksGyZk4cFMe7XSgWGN+kSqYm+G6VaFwkvOO7IZq
 2z1Gn0gCcPuQFKhRBvU=
X-Received: by 2002:a05:620a:28c9:b0:7b6:6d99:ecfc with SMTP id
 af79cd13be357-7b863594e5cmr1029845485a.0.1734599945355; 
 Thu, 19 Dec 2024 01:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp+RgPQhdzdstyIRqaVDDuH/+OdJFEl32dZz15j+KZGSHsS7xiWLo4dFqS9Jm2d3m5rCycyg==
X-Received: by 2002:a05:620a:28c9:b0:7b6:6d99:ecfc with SMTP id
 af79cd13be357-7b863594e5cmr1029843185a.0.1734599945031; 
 Thu, 19 Dec 2024 01:19:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc3aasm33408185a.26.2024.12.19.01.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:19:04 -0800 (PST)
Message-ID: <dd3b531d-3deb-4bfc-aa09-cdac19380352@redhat.com>
Date: Thu, 19 Dec 2024 10:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/24] vfio/migration: Don't run load cleanup if load
 setup didn't run
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <72424ece45968b1ae6b39750917a041867c415ab.1731773021.git.maciej.szmigiero@oracle.com>
 <9f27f058-59f0-4056-b19a-f613418e0760@redhat.com>
 <fd69d0ef-67de-4ac8-b00e-a68c4e2ae62f@maciej.szmigiero.name>
 <1fbd277d-c3e0-48f6-81b1-2a5ae97ed9a0@nvidia.com>
 <2e0ea3b7-2f63-41ff-a316-52681d6f0eb8@maciej.szmigiero.name>
 <5601b5a2-1f4b-49b6-93fb-7242a2db71a6@nvidia.com>
 <a3a77e6a-fb0b-493c-849b-d9ed29fae471@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a3a77e6a-fb0b-493c-849b-d9ed29fae471@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 12/12/24 23:52, Maciej S. Szmigiero wrote:
> On 12.12.2024 15:30, Avihai Horon wrote:
>>
>> On 11/12/2024 1:04, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 3.12.2024 16:09, Avihai Horon wrote:
>>>>
>>>> On 29/11/2024 19:15, Maciej S. Szmigiero wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 29.11.2024 15:08, Cédric Le Goater wrote:
>>>>>> On 11/17/24 20:20, Maciej S. Szmigiero wrote:
>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>
>>>>>>> It's possible for load_cleanup SaveVMHandler to get called without
>>>>>>> load_setup handler being called first.
>>>>>>>
>>>>>>> Since we'll be soon running cleanup operations there that access objects
>>>>>>> that need earlier initialization in load_setup let's make sure these
>>>>>>> cleanups only run when load_setup handler had indeed been called
>>>>>>> earlier.
>>>>>>>
>>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>>
>>>>>> tbh, that's a bit ugly. I agree it's similar to those 'bool initialized'
>>>>>> attributes we have in some structs, so nothing new or really wrong.
>>>>>> But it does look like a workaound for a problem or cleanups missing
>>>>>> that would need time to untangle.
>>>>>>
>>>>>> I would prefer to avoid this change and address the issue from the
>>>>>> migration subsystem if possible.
>>>>>
>>>>> While it would be pretty simple to only call {load,save}_cleanup
>>>>> SaveVMHandlers when the relevant {load,save}_setup handler was
>>>>> successfully called first this would amount to a change of these
>>>>> handler semantics.
>>>>>
>>>>> This would risk introducing regressions - for example vfio_save_setup()
>>>>> doesn't clean up (free) newly allocated migration->data_buffer
>>>>> if vfio_migration_set_state() were to fail later in this handler
>>>>> and relies on an unconstitutional call to vfio_save_cleanup() in
>>>>> order to clean it up.
>>>>>
>>>>> There might be similar issues in other drivers too.
>>>>
>>>> We can put all objects related to multifd load in their own struct (as suggested by Cedric in patch #22) and allocate the struct only if multifd device state transfer is used.
>>>> Then in the cleanup flow we clean the struct only if it was allocated.
>>>>
>>>> This way we don't need to add the load_setup flag and we can keep the SaveVMHandlers semantics as is.
>>>>
>>>> Do you think this will be OK?
>>>
>>> I think here the discussion is more of whether we refactor the
>>> {load,save}_cleanup handler semantics to "cleaner" design where
>>> these handlers are only called if the relevant {load,save}_setup
>>> handler was successfully called first (but at the same time risk
>>> introducing regressions).
>>
>> Yes, and I agree with you that changing the semantics of SaveVMHandlers can be risky and may deserve a series of its own.
>> But Cedric didn't like the flag option, so I suggested to do what we usually do, AFAIU, which is to check if the structs are allocated and need cleanup.
>>
>>>
>>>
>>> If we keep the existing semantics of these handlers (like this
>>> patch set did) then it is just an implementation detail whether
>>> we keep an explicit flag like "migration->load_setup" or have
>>> a struct pointer that serves as an implicit equivalent flag
>>> (when not NULL) - I don't have a strong opinion on this particular
>>> detail.
>>>
>> I prefer the struct pointer way, it seems less cumbersome to me.
>> But it's Cedric's call at the end.
> 
> As I wrote above "I don't have a strong opinion on this particular
> detail" - I'm okay with moving these new variables to a dedicated
> struct.

I would prefer that, to isolate multifd migation support from the rest.

> I guess this means we settled on *not* changing the semantics of
> {load,save}_cleanup handler SaveVMHandlers - that was the important
> decision for me.

Handling errors locally in SaveVMHandlers and unrolling what was done
previously is better practice than relying on another callback to do
the cleanup.

Let's see when v4 comes out.

Thanks,

C.



