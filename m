Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78995C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tps0R-00009Z-Nc; Wed, 05 Mar 2025 11:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tps0N-0008Vn-Ai
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tps0I-00068t-Lx
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741193633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PYldZ4yimIv9n17iUhUj3a3gpSjDogcpGp+5LQbYKFc=;
 b=cEBObzb1cHJ/qTQ15IsjTlC8cljLyimyf8SUMU7Pq55hO3BlSTbL19gG/Y2jXxNvWtLHTQ
 3/MgSmNls0g6BC1bYJl2wsk9xU0jO7Lbr2QefQrEW/cV1+dE4JNOPHD6BPJ4q76IwllftY
 6MxVk0y/5tiCHZTJT7ccmGAYkI7j38o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-T3_Pz1coOl2PTT-rTLHcdw-1; Wed, 05 Mar 2025 11:53:51 -0500
X-MC-Unique: T3_Pz1coOl2PTT-rTLHcdw-1
X-Mimecast-MFC-AGG-ID: T3_Pz1coOl2PTT-rTLHcdw_1741193631
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-390e5214efdso4737246f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193630; x=1741798430;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYldZ4yimIv9n17iUhUj3a3gpSjDogcpGp+5LQbYKFc=;
 b=S3iBtF/YXa2dbgSebqdSQ4P4O16KJrjko704EdAaa607glw73D8svkZjtExMDw5hRD
 anQvvsFSo6z/g0l702lESWLfY81IDO6PX6O8Jw6OxWyDe/++uQwNCMknpEAn+QmBDbGO
 fSc7f4Z1bStiO5/77HllVW0qpe8EnQ73acoP9aFyhiaXHI6OwQ8ejkfvNowXW2MF58Y3
 UChBoV5TXqag1u/k7Jasb5YaJVZSp6e0gevTRDWt+x9+D0ELoz3JxVVJ00NjZl1l9tvs
 MU7cItQ/yZGXkXLu/Jd0RUJP7emPROFKdL9hzT4WKfsK1u6r1YUhHjm3ifHI5c046RnK
 gWZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmV4MsV6a1VObeNrV3DhTwGD37xb/3EFinCCV+kNnekO7tlvuxn8jiESqyLVyqSdQA5uUPTxy0OSn/@nongnu.org
X-Gm-Message-State: AOJu0YzTU9dQg5j7MllpP5w1IuJ33MVkIlzi0cBOtyPwKqkvs0Tb527H
 EbtHP6m8s5KA3DeMWytrHAHlTNoYCZPdXa7Xvj7rWuBq9d2SQrETOrsem1vZ6+kK/rS3ud5CJYg
 R4R4pd1SIbiyE+Zu2iwW1V3MlTOQzojmcrkLBtWd2Wp8MXSaSR7B7
X-Gm-Gg: ASbGncvm4Kr7y3qI0oprrjtNIK/srxApHIBBPTxcvB4CYhqRbM8RWt6D3j6VEBRBnvT
 apJTrFG1qatd98q8EwDvrkQPiXRYw62Ku2lOqe7KFLRoePtFDHcXClJNhsFYZuxeE/GY35KHRcQ
 f3/CFBmIxygAcH9wAvJq541jhTMQY7LH8ETyREOWdkLlJV1Z0bnuiFyMYhZ4T//h7Q1q/v+GLd6
 Gk8sqZYU5C8zydEoXpnNnoVMDunPilPmk5guDGVcDHwXma96MbIzZUrje27l0FahUWtJPICpFWU
 OCxEYOR6mr2xAdDJsHxlphnj4v/7IGARnvwdpHctddqWJC/+iLQJGA==
X-Received: by 2002:a5d:64a6:0:b0:391:c3a:b8ae with SMTP id
 ffacd0b85a97d-3911f74dac3mr4276318f8f.23.1741193630465; 
 Wed, 05 Mar 2025 08:53:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP77ThmpScju8RDTSE0jsohEtmZvVA8HSD2PoSShpfMpkEDgYVXzJi+OyARj1jlMz8+5vtyA==
X-Received: by 2002:a5d:64a6:0:b0:391:c3a:b8ae with SMTP id
 ffacd0b85a97d-3911f74dac3mr4276293f8f.23.1741193630112; 
 Wed, 05 Mar 2025 08:53:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485dba4sm21940001f8f.92.2025.03.05.08.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:53:48 -0800 (PST)
Message-ID: <00b3cd87-2be1-4981-9b7a-4b92b44b7c8b@redhat.com>
Date: Wed, 5 Mar 2025 17:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Always take BQL for
 migration_incoming_state_destroy()
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <21bb5ca337b1d5a802e697f553f37faf296b5ff4.1741193259.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <21bb5ca337b1d5a802e697f553f37faf296b5ff4.1741193259.git.maciej.szmigiero@oracle.com>
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

So that's PATCH 7 replacement.

Thanks,

C.



On 3/5/25 17:49, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> All callers to migration_incoming_state_destroy() other than
> postcopy_ram_listen_thread() do this call with BQL held.
> 
> Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
> SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
> to always call that function under BQL rather than to have it deal with
> both cases (with BQL and without BQL).
> Add the necessary bql_lock() and bql_unlock() to
> postcopy_ram_listen_thread().
> 
> qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
> "load_state" SaveVMHandlers that are expecting BQL to be held.
> 
> In principle, the only devices that should be arriving on migration
> channel serviced by postcopy_ram_listen_thread() are those that are
> postcopiable and whose load handlers are safe to be called without BQL
> being held.
> 
> But nothing currently prevents the source from sending data for "unsafe"
> devices which would cause trouble there.
> Add a TODO comment there so it's clear that it would be good to improve
> handling of such (erroneous) case in the future.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   migration/migration.c | 13 +++++++++++++
>   migration/savevm.c    |  4 ++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9e9db26667f1..0bf70ea9717d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -402,10 +402,23 @@ void migration_incoming_state_destroy(void)
>       struct MigrationIncomingState *mis = migration_incoming_get_current();
>   
>       multifd_recv_cleanup();
> +
>       /*
>        * RAM state cleanup needs to happen after multifd cleanup, because
>        * multifd threads can use some of its states (receivedmap).
> +     * The VFIO load_cleanup() implementation is BQL-sensitive. It requires
> +     * BQL must NOT be taken when recycling load threads, so that it won't
> +     * block the load threads from making progress on address space
> +     * modification operations.
> +     *
> +     * To make it work, we could try to not take BQL for all load_cleanup(),
> +     * or conditionally unlock BQL only if bql_locked() in VFIO.
> +     *
> +     * Since most existing call sites take BQL for load_cleanup(), make
> +     * it simple by taking BQL always as the rule, so that VFIO can unlock
> +     * BQL and retake unconditionally.
>        */
> +    assert(bql_locked());
>       qemu_loadvm_state_cleanup();
>   
>       if (mis->to_src_file) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7c1aa8ad7b9d..3e86b572cfa8 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1986,6 +1986,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
>        * in qemu_file, and thus we must be blocking now.
>        */
>       qemu_file_set_blocking(f, true);
> +
> +    /* TODO: sanity check that only postcopiable data will be loaded here */
>       load_res = qemu_loadvm_state_main(f, mis);
>   
>       /*
> @@ -2046,7 +2048,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>        * (If something broke then qemu will have to exit anyway since it's
>        * got a bad migration state).
>        */
> +    bql_lock();
>       migration_incoming_state_destroy();
> +    bql_unlock();
>   
>       rcu_unregister_thread();
>       mis->have_listen_thread = false;
> 


