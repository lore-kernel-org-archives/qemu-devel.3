Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C078C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gI4-00017d-60; Fri, 04 Apr 2025 08:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gI2-00017M-SD
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gI0-0000Qv-W3
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743770211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STcIVku/MlTLI5kKSRbLLnMZeMqj0tR6HB9kchMZuAM=;
 b=ZOP7/EUmulIGETx7Qdnf+MYo+MVO/QZ2wdoy42dOA2IdBhJZ9t+1GnaXVZYIiUNO8Dh4+q
 UEQ/LAD29BPvbGy0Np8AjgdDitWafskpK9RV3rsUQQYEUYeb2DlM7giIHtYHAQelhD4O1M
 NXUrSEjL1shSz9gYQR/xggjzrZSJ9hM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-u45OH1-7N4Crd_rnvQJjlQ-1; Fri, 04 Apr 2025 08:36:50 -0400
X-MC-Unique: u45OH1-7N4Crd_rnvQJjlQ-1
X-Mimecast-MFC-AGG-ID: u45OH1-7N4Crd_rnvQJjlQ_1743770209
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so11514745e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743770209; x=1744375009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STcIVku/MlTLI5kKSRbLLnMZeMqj0tR6HB9kchMZuAM=;
 b=trXweZxib3f1F31M1QoF3Rb6p106D1iHzZZUYAukAO/2Oww7JANID2AgbmRfkqV0gc
 E/AAjdCePtiauEnigV3XZ3JjaU2jEFDzrLdvPZ7v/wEQg6LlNfbr7nzJNDQQ+RC+MUrG
 jpL4HzBh0p2fWTASx2q03Lb6l4zpDCq9HCATA6QDh2S1PyOujO19a3NkfsyXYbq/BKQr
 WHEJg11ApxKPS07+9tua9lSolKWFd30XVpE3nm6j2EWJu7LOQ10vDJxuOma1Wp+QRNii
 KsPkMIY1T2ogSj3BI3uSw+yzMzfHG7b84IuIRhlVbjxLBVbtYsH6w27cAoL7GP8FDMk1
 /Gsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOx4ImPdHmpGm4Zar6VqxBR7uKd4IWPrmshJvXv+ymPEIBaD5EEWkBZSx1qV9hxqzwFt99tcGcUnfj@nongnu.org
X-Gm-Message-State: AOJu0YzKhItG3/AbzlLepSuRjEkXxsAnte1yQ9GYWEZ4Q4GxaVda78HP
 YhxH+kOvxpF/WlsrC/4pxfyoBuWWCSjFGSQP8Vwxo5CTfHHrRgYcd7KS9F/hV1qjJ4KtDvqDvSA
 lhLKGngLvkNZrYL49L0/AnLg4mKaEBZ63AgZi1L3NEH2WRQHmC1eb
X-Gm-Gg: ASbGnct3i90krLA40fHSapDXl4gUe6FRGG2DSS6LqfqNigoAU+W5BlD0pkG9YEarBLs
 yQ4SFTdhKxbgmgmTebzA62Ih5Ely4gMnpsVp30f7UE6oX27w/AVwBwzJYlDJzOmIcXGhTt8Y8vK
 mJbgbujQloTu84DM73gNy5cjSYBZlJ++gFTMnR6A5cqYsDKlObbyycxEpW6xpc9JQFPkHuYk90E
 rs9uGAZD8zcYWQMvBAE7VOtDekTpifcd4w5hBiIOXS9kaVWVEuJa2lwyz/rTKPLeCQOOvfJoJfu
 f+ImF6K0Ci/Jqv1E7gZWbMqxS8qGmbixpC0GoBg3bFLR/b6f/HNzxhTYWZPp0bZv5dbkaXEfCsa
 alJ24VO21umwE4ghwEcRVyoLaN+ALBVdHEw7XBFoC2ZJ6
X-Received: by 2002:a05:600c:4e42:b0:43c:f629:66f3 with SMTP id
 5b1f17b1804b1-43ed0c50af4mr29378115e9.18.1743770208688; 
 Fri, 04 Apr 2025 05:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUWlDb2Yd6Rbo3J3CcYx3X9qi+s18/KSQU8KenICSBkQCa1pzLcT4vG/CsasUBL+M319+/bw==
X-Received: by 2002:a05:600c:4e42:b0:43c:f629:66f3 with SMTP id
 5b1f17b1804b1-43ed0c50af4mr29377805e9.18.1743770208172; 
 Fri, 04 Apr 2025 05:36:48 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366a699sm44474675e9.38.2025.04.04.05.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 05:36:47 -0700 (PDT)
Message-ID: <d4dc6324-110d-42ba-bfe1-366b937de40e@redhat.com>
Date: Fri, 4 Apr 2025 14:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] fuse: Manually process requests (without libfuse)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-10-hreitz@redhat.com> <20250327153503.GK37458@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250327153503.GK37458@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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

On 27.03.25 16:35, Stefan Hajnoczi wrote:
> On Tue, Mar 25, 2025 at 05:06:51PM +0100, Hanna Czenczek wrote:
>> Manually read requests from the /dev/fuse FD and process them, without
>> using libfuse.  This allows us to safely add parallel request processing
>> in coroutines later, without having to worry about libfuse internals.
>> (Technically, we already have exactly that problem with
>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>>
>> We will continue to use libfuse for mounting the filesystem; fusermount3
>> is a effectively a helper program of libfuse, so it should know best how
>> to interact with it.  (Doing it manually without libfuse, while doable,
>> is a bit of a pain, and it is not clear to me how stable the "protocol"
>> actually is.)
>>
>> Take this opportunity of quite a major rewrite to update the Copyright
>> line with corrected information that has surfaced in the meantime.
>>
>> Here are some benchmarks from before this patch (4k, iodepth=16, libaio;
>> except 'sync', which are iodepth=1 and pvsync2):
>>
>> file:
>>    read:
>>      seq aio:   78.6k ±1.3k IOPS
>>      rand aio:  39.3k ±2.9k
>>      seq sync:  32.5k ±0.7k
>>      rand sync:  9.9k ±0.1k
>>    write:
>>      seq aio:   61.9k ±0.5k
>>      rand aio:  61.2k ±0.6k
>>      seq sync:  27.9k ±0.2k
>>      rand sync: 27.6k ±0.4k
>> null:
>>    read:
>>      seq aio:   214.0k ±5.9k
>>      rand aio:  212.7k ±4.5k
>>      seq sync:   90.3k ±6.5k
>>      rand sync:  89.7k ±5.1k
>>    write:
>>      seq aio:   203.9k ±1.5k
>>      rand aio:  201.4k ±3.6k
>>      seq sync:   86.1k ±6.2k
>>      rand sync:  84.9k ±5.3k
>>
>> And with this patch applied:
>>
>> file:
>>    read:
>>      seq aio:   76.6k ±1.8k (- 3 %)
>>      rand aio:  26.7k ±0.4k (-32 %)
>>      seq sync:  47.7k ±1.2k (+47 %)
>>      rand sync: 10.1k ±0.2k (+ 2 %)
>>    write:
>>      seq aio:   58.1k ±0.5k (- 6 %)
>>      rand aio:  58.1k ±0.5k (- 5 %)
>>      seq sync:  36.3k ±0.3k (+30 %)
>>      rand sync: 36.1k ±0.4k (+31 %)
>> null:
>>    read:
>>      seq aio:   268.4k ±3.4k (+25 %)
>>      rand aio:  265.3k ±2.1k (+25 %)
>>      seq sync:  134.3k ±2.7k (+49 %)
>>      rand sync: 132.4k ±1.4k (+48 %)
>>    write:
>>      seq aio:   275.3k ±1.7k (+35 %)
>>      rand aio:  272.3k ±1.9k (+35 %)
>>      seq sync:  130.7k ±1.6k (+52 %)
>>      rand sync: 127.4k ±2.4k (+50 %)
>>
>> So clearly the AIO file results are actually not good, and random reads
>> are indeed quite terrible.  On the other hand, we can see from the sync
>> and null results that request handling should in theory be quicker.  How
>> does this fit together?
>>
>> I believe the bad AIO results are an artifact of the accidental parallel
>> request processing we have due to nested polling: Depending on how the
>> actual request processing is structured and how long request processing
>> takes, more or less requests will be submitted in parallel.  So because
>> of the restructuring, I think this patch accidentally changes how many
>> requests end up being submitted in parallel, which decreases
>> performance.
>>
>> (I have seen something like this before: In RSD, without having
>> implemented a polling mode, the debug build tended to have better
>> performance than the more optimized release build, because the debug
>> build, taking longer to submit requests, ended up processing more
>> requests in parallel.)
>>
>> In any case, once we use coroutines throughout the code, performance
>> will improve again across the board.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/export/fuse.c | 793 +++++++++++++++++++++++++++++++-------------
>>   1 file changed, 567 insertions(+), 226 deletions(-)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 3dd50badb3..407b101018 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c

[...]

>> +/**
>> + * Check the FUSE FD for whether it is readable or not.  Because we cannot
>> + * reasonably do this without reading a request at the same time, also read and
>> + * process that request if any.
>> + * (To be used as a poll handler for the FUSE FD.)
>> + */
>> +static bool poll_fuse_fd(void *opaque)
>> +{
>> +    return read_from_fuse_fd(opaque);
>> +}
> The other io_poll() callbacks in QEMU peek at memory whereas this one
> invokes the read(2) syscall. Two reasons why this is a problem:
> 1. Syscall latency is too high. Other fd handlers will be delayed by
>     microseconds.
> 2. This doesn't scale. If every component in QEMU does this then the
>     event loop degrades to O(n) of non-blocking read(2) syscalls where n
>     is the number of fds.
>
> Also, handling the request inside the io_poll() callback skews
> AioContext's time accounting because time spent handling the request
> will be accounted as "polling time". The adaptive polling calculation
> will think it polled for longer than it did.
>
> If there is no way to peek at memory, please don't implement the
> io_poll() callback.

Got it, thanks!

Hanna


