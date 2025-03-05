Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91172C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprkq-0004mz-OY; Wed, 05 Mar 2025 11:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tprkn-0004mH-JB
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tprkk-0003XN-Hc
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741192668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M+VTemM/wS71eTIpyi6IY1bop/MkvCO9T/o/XOs2kEk=;
 b=dqg6LEeYZ269gISzANOXTPiz66u7Cy7yIIUCLVIYTECnvtPwrRxj/HNAnSVrHL4chwEmlK
 VtB0dNm435sVk7f+xTvFv+kRmHst91euxsZVgp0HOaFjoXZo5y5/UDF7XhBNI1kVG/dLEm
 nHu7j+M+phFXACU8zi9mgrJXx7cdRk0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-rFuQIPAgNvqERYy2LZta4g-1; Wed, 05 Mar 2025 11:37:47 -0500
X-MC-Unique: rFuQIPAgNvqERYy2LZta4g-1
X-Mimecast-MFC-AGG-ID: rFuQIPAgNvqERYy2LZta4g_1741192666
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bca561111so11646715e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741192666; x=1741797466;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+VTemM/wS71eTIpyi6IY1bop/MkvCO9T/o/XOs2kEk=;
 b=LZVzZCRcCUAuRSIxP6D4gGSfmZXkPvNB4U8Dxkh+XyQAfj13Ma/6f5enJsofUInjN3
 qzsPtr1y4u+i+9JdKJo0ftjtGs8Bx1Tjgs8+Ich/rX7DKxh3xSLtIy769JIoQhSW8pSN
 aDUYAA8QxgxfKWW7PVVZU4ItBLWJ6nzlm4/UT2yM+mUkpiiTnWNncyNqYKyfi9QOPFRG
 FZ8uOhCKTtd8F2TjZrbvYWjK5VhYzKENdhvBHMJS7w7stUG9ucqWSM6upbTRvVugJb2N
 dIIQWAZrQH93sJcjYxR2/r3tRfGtwWUtglv2cR1HEMOocY0P3p4jp7HPnq6pblRkYUEo
 Sf0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2EBx7kkjKbErMdYE1jnwAOmt7FyRmnaU7uwEJ9uKdGrEMXCt3m4OHXhjQZpM5l6ZUhJYBDz0JzK3C@nongnu.org
X-Gm-Message-State: AOJu0Yxa8jx2JkV4wLf6m/NGqIeuiOyukPnK92/3Fct4btu134N5y7iQ
 9RNXeFNHerdcgj5kwEyhxjQFRKlZrzaEDomDc0LlcRNY87SAUF4323aQKKlpqW+xPKeJS+VJU7x
 YsjLDEz7cKkyOQs6iJhED8ML+RbPna4PqbFDg1+LSerUR7roDokhI
X-Gm-Gg: ASbGncv3pzL6Q3VMLHT4QCROaR5k3c4XQNlq+0DG4T/DV+HcWjMVp5Yad9kVvBaSxLf
 l4rMvj5EJcoM/I6Gcl0j5OXZrbJTrknzCSPpkypMXwkq36zCVrIkUtejKMuiWCSuByTjgdLiITy
 LHs1B/CDCoerntSU3RDl7jBftVXkZFpWX5s1xGriLv6pB+GUvSVIai9GY8ex0AWHLjj2pyHhpfn
 HSSIiZWddlk5j4BejWue/B8HIWFNu/qscHEO1doFp4BCxJl49nTxxdTtPZH8lQrkg71EwJYRUqX
 3JzAYsvvRi4G+AqGA7oqm+cY4uiekqyapAtOvYDhdbEWm6+35RH/cA==
X-Received: by 2002:a05:600c:4f11:b0:43b:c468:49df with SMTP id
 5b1f17b1804b1-43bd2929885mr31224315e9.2.1741192665930; 
 Wed, 05 Mar 2025 08:37:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDtQ9k7xNwa4QkW9exd6jyJfNyBWxbwAmFue+arcol/G7ZRpoxFqkQspCAK/YjerDI1ppGdA==
X-Received: by 2002:a05:600c:4f11:b0:43b:c468:49df with SMTP id
 5b1f17b1804b1-43bd2929885mr31224015e9.2.1741192665478; 
 Wed, 05 Mar 2025 08:37:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795d30sm21825332f8f.10.2025.03.05.08.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:37:44 -0800 (PST)
Message-ID: <1828fd0d-3f97-4488-9a58-ab57de5e5b35@redhat.com>
Date: Wed, 5 Mar 2025 17:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/36] migration: postcopy_ram_listen_thread() should
 take BQL for some calls
To: Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <24a7412cc151f8b48d74cd170a3bdc1ce8e6c879.1741124640.git.maciej.szmigiero@oracle.com>
 <Z8hE3ujEKkwsBiJO@x1.local>
 <4aac2a7e-f42e-4e92-8e27-3b0e9a7b6603@maciej.szmigiero.name>
 <Z8h4i3Ima6BhaoBs@x1.local>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z8h4i3Ima6BhaoBs@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 3/5/25 17:15, Peter Xu wrote:
> On Wed, Mar 05, 2025 at 04:11:30PM +0100, Maciej S. Szmigiero wrote:
>> On 5.03.2025 13:34, Peter Xu wrote:
>>> On Tue, Mar 04, 2025 at 11:03:34PM +0100, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> All callers to migration_incoming_state_destroy() other than
>>>> postcopy_ram_listen_thread() do this call with BQL held.
>>>>
>>>> Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
>>>> SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
>>>> to always call that function under BQL rather than to have it deal with
>>>> both cases (with BQL and without BQL).
>>>> Add the necessary bql_lock() and bql_unlock() to
>>>> postcopy_ram_listen_thread().
>>>>
>>>> qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
>>>> "load_state" SaveVMHandlers that are expecting BQL to be held.
>>>>
>>>> In principle, the only devices that should be arriving on migration
>>>> channel serviced by postcopy_ram_listen_thread() are those that are
>>>> postcopiable and whose load handlers are safe to be called without BQL
>>>> being held.
>>>>
>>>> But nothing currently prevents the source from sending data for "unsafe"
>>>> devices which would cause trouble there.
>>>> Add a TODO comment there so it's clear that it would be good to improve
>>>> handling of such (erroneous) case in the future.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>    migration/migration.c | 16 ++++++++++++++++
>>>>    migration/savevm.c    |  4 ++++
>>>>    2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 9e9db26667f1..6b2a8af4231d 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -402,10 +402,26 @@ void migration_incoming_state_destroy(void)
>>>>        struct MigrationIncomingState *mis = migration_incoming_get_current();
>>>>        multifd_recv_cleanup();
>>>> +
>>>>        /*
>>>>         * RAM state cleanup needs to happen after multifd cleanup, because
>>>>         * multifd threads can use some of its states (receivedmap).
>>>> +     *
>>>> +     * This call also needs BQL held since it calls all registered
>>>> +     * load_cleanup SaveVMHandlers and at least the VFIO implementation is
>>>> +     * BQL-sensitive.
>>>> +     *
>>>> +     * In addition to the above, it also performs cleanup of load threads
>>>> +     * thread pool.
>>>> +     * This cleanup operation is BQL-sensitive as it requires unlocking BQL
>>>> +     * so a thread possibly waiting for it could get unblocked and finally
>>>> +     * exit.
>>>> +     * The reason why a load thread may need to hold BQL in the first place
>>>> +     * is because address space modification operations require it.
>>>
>>> Hold on...
>>>
>>> This almost says exactly why load_cleanup() should _not_ take BQL... rather
>>> than should..
>>>
>>> So I had a closer look at the latest code, it's about this:
>>>
>>> static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
>>> {
>>>       /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
>>>       bql_unlock();
>>>       WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
>>>           while (multifd->load_bufs_thread_running) {
>>>               multifd->load_bufs_thread_want_exit = true;
>>>
>>>               qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
>>>               qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
>>>               qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
>>>                              &multifd->load_bufs_mutex);
>>>           }
>>>       }
>>>       bql_lock();
>>> }
>>>
>>> It doesn't make much sense to me to take it only because we want to drop it
>>> unconditionally. Can we guarantee the function not taking BQL instead?  I
>>> had a quick look on pmem's pmem_persist() (from libpmem, qemu_ram_msync <-
>>> qemu_ram_block_writeback <- ram_load_cleanup), it looks ok.
>>>
>>> So the question is, is it safe to unlock BQL in whatever context (in
>>> coroutines, or in a bottom half)?
>>>
>>> If the answer is yes, we could make migration_incoming_state_destroy()
>>> always not taking BQL (and assert(!bql_locked()) instead).
>>
>> All the other callers of migration_incoming_state_destroy() are holding BQL:
>> process_incoming_migration_bh(), process_incoming_migration_co() (called on,
>> failure path only), load_snapshot() and qmp_xen_load_devices_state().
>>
>> So AFAIK the safer way is to standardize on holding BQL when calling
>> that function.
>>> If the answer is no, then vfio_load_cleanup_load_bufs_thread()'s current
>>> version may not work either..
>>
>> I think the reason for BQL is to serialize access to the QEMU internals
>> which are not thread-safe.
>>
>> So as long as these internals aren't touched when not holding BQL then
>> we should be safe - I don't see any particular state that's cached
>> around these BQL calls and would need explicit reloading after re-gaining
>> it.
> 
> OK, I checked with misterious force and looks like it's ok.
> 
> Would you please rephrase the comment, though?  I want to make it crystal
> clear that what we're looking for is not holding BQL.. Maybe something like
> this:
> 
>      /*
>       * The VFIO load_cleanup() implementation is BQL-sensitive. It requires
>       * BQL must NOT be taken when recycling load threads, so that it won't
>       * block the load threads from making progress on address space
>       * modification operations.
>       *
>       * To make it work, we could try to not take BQL for all load_cleanup(),
>       * or conditionally unlock BQL only if bql_locked() in VFIO.
>       *
>       * Since most existing call sites take BQL for load_cleanup(), make
>       * it simple by taking BQL always as the rule, so that VFIO can unlock
>       * BQL and retake unconditionally.
>       */
> 
> We may also want to update the subject.  Currently:
> 
>    "migration: postcopy_ram_listen_thread() should take BQL for some calls"
> 
> It's not accurate anymore, it could be:
> 
>    "migration: Always take BQL for migration_incoming_state_destroy()"
> 
> If with all above, please feel free to take:
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> I'm OK if it'll be touched up when merge too.

Maciej,

Could you please resend just that patch as a reply to the series ? No need to
resend the whole series.

Thanks,

C.



