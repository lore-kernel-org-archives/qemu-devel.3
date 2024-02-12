Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E58C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZIE-0003pL-3Z; Mon, 12 Feb 2024 11:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZZI9-0003nL-KR
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:36:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZZI7-0005o4-V8
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707755782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48oA5tRdvShoGmS5n9L33tMrwd5YbVad5gdD5mRpFcc=;
 b=an4bR7dgHnA1wIUzcigGJcu8zLD4Vxe0kULj0sizIwITfXP0adV/6JDM6UO6PlBABl5u06
 NJWuUgC/bPMO7Ar7Xjw/1XGbQQkh2VERkCqHGGwYXZ2r4ezInKFi0B0A8cQetfuJDOEClM
 1P0QCfSTRTmK/1czfgKn+4t6/Xjvfpw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-o0IgO1s7NSOKZFTGtfRHxA-1; Mon, 12 Feb 2024 11:36:21 -0500
X-MC-Unique: o0IgO1s7NSOKZFTGtfRHxA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bff4204b94so4261873b6e.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 08:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707755780; x=1708360580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=48oA5tRdvShoGmS5n9L33tMrwd5YbVad5gdD5mRpFcc=;
 b=M4utIDvFo4aV317Kaa1sRipKD0I7Nswp4CNyyIVky0v267h/c5FW48gOtnpD8pfQrC
 FK58FOwi6hDTKeFvoFkAnSAmlXlLllB1eEMxZ421fDUFEZtrnL+mlTwtkq2r0OnKVvEp
 1w5LUkX/3ExTms/DRkn8jpbiiroRIXSLp1ZueAe/tdlhvL20Q1BKKPRoORk6mGcir+y1
 zJh6Ye9cOGZTCfbnYOaGiJGYLuRFhhPBoz/eq+d/yO49/lbLmPaoOHTpYljJbzjd/77O
 Y+ViPKa/BmuW4bKXI0KcVoK8NWvckb3gGOkEjNXrk/DJCMhP4EmrTeq0+n9ryT+FUEtB
 fg0A==
X-Gm-Message-State: AOJu0YwC4yCa2zjlPaCoEbkeO0cwe/aG/XcJC3Rf78hs8lJ7c+NLEqIa
 r7jzTXcKxXJWZbZFr+G/ULI9YHWWcdusvBDUFZn6Xt51RbdTGeoOz4dfCwd7UPA8GF8OxCSEXjS
 NSQM04g89uKP8udROtZq3VPXgjaCDGhO2TvMFCQk0KaxvTJce/+3E
X-Received: by 2002:a05:6808:398f:b0:3bf:cd51:b8d4 with SMTP id
 gq15-20020a056808398f00b003bfcd51b8d4mr12588584oib.11.1707755780660; 
 Mon, 12 Feb 2024 08:36:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHycwl9oFi4PWicP52sx16qqOEkhPusHwJJW4W9Y66PfzdtDTkaqxLjP7u3aN/GBKxUahH+0g==
X-Received: by 2002:a05:6808:398f:b0:3bf:cd51:b8d4 with SMTP id
 gq15-20020a056808398f00b003bfcd51b8d4mr12588571oib.11.1707755780460; 
 Mon, 12 Feb 2024 08:36:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUf7eT5CviPXcWp2xieVbUladSAb2BBenB5SIKQktO1toVzuFzHUVRLXze5kzbyj0iE1xutA3sDBT45wK7e9fHIflmKC7NlVAGdPfLcyxpoJ/+DlF4p7tmuWzd/bIYwytpLj11P7Xaum/NQrAXfjB1Lxjt44HoBbV1GiZh3jmcMMQOd6PmhDleYnds5MxEqrihapF2HY1D39aYKDFi/OfNkIWx2exH3d3uZrOKJR4ibvthegPEvJU2Y2DF7FKUTzZ3cx+7eklJtxPivdI1rSwxCBuGJH+KKVDfaNYsEnTmyYAiF8HGsZzFEzu7TP6DWrR3T/h1NCEYCBXg=
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a05620a110a00b00783b6da58a9sm2170981qkk.39.2024.02.12.08.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 08:36:20 -0800 (PST)
Message-ID: <9a0c596f-ba81-4f77-96cc-9efb49e04786@redhat.com>
Date: Mon, 12 Feb 2024 17:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] memory: Add Error** argument to .log_global*()
 handlers
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-4-clg@redhat.com> <ZcRrJIrInupeanqB@x1n>
 <c9c45081-4874-4c89-b283-1b19d21ee670@redhat.com>
 <8343df56-d6a4-42e7-9140-9610fd140e9d@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <8343df56-d6a4-42e7-9140-9610fd140e9d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/12/24 09:43, Avihai Horon wrote:
> Hi Cedric,
> 
> On 09/02/2024 12:14, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/8/24 06:48, Peter Xu wrote:
>>> On Wed, Feb 07, 2024 at 02:33:36PM +0100, Cédric Le Goater wrote:
>>>> @@ -2936,14 +2940,14 @@ void memory_global_dirty_log_start(unsigned int flags)
>>>>       trace_global_dirty_changed(global_dirty_tracking);
>>>>
>>>>       if (!old_flags) {
>>>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
>>>> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward, errp);
>>>>           memory_region_transaction_begin();
>>>>           memory_region_update_pending = true;
>>>>           memory_region_transaction_commit();
>>>>       }
>>>>   }
>>>>
>>>> -static void memory_global_dirty_log_do_stop(unsigned int flags)
>>>> +static void memory_global_dirty_log_do_stop(unsigned int flags, Error **errp)
>>>>   {
>>>>       assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>>>>       assert((global_dirty_tracking & flags) == flags);
>>>> @@ -2955,7 +2959,7 @@ static void memory_global_dirty_log_do_stop(unsigned int flags)
>>>>           memory_region_transaction_begin();
>>>>           memory_region_update_pending = true;
>>>>           memory_region_transaction_commit();
>>>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
>>>> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse, errp);
>>>>       }
>>>>   }
>>>
>>> I'm a little bit surprised to see that MEMORY_LISTENER_CALL_GLOBAL()
>>> already allows >2 args, with the ability to conditionally pass over errp
>>> with such oneliner change; even if all callers were only using 2 args
>>> before this patch..
>> yes. The proposal takes the easy path.
>>
>> Should we change all memory listener global handlers :
>>
>>   begin
>>   commit
>>   log_global_after_sync
>>   log_global_start
>>   log_global_stop
>>
>> to take an extra Error **errp argument ?
>>
>> I think we should distinguish begin + commit handlers from the log_global_*
>> with a new macro. In which case, we could also change the handler to return
>> a bool and fail at the first error in MEMORY_LISTENER_CALL_GLOBAL(...).
> 
> I think we must fail at first error in any case. Otherwise, if two handlers error and call error_setg() with errp, the second handler will assert IIUC.

Good point. I will respin with a new MEMORY_LISTENER_CALL_GLOBAL_ERR macro
exiting the loop at first error.

Thanks,

C.


