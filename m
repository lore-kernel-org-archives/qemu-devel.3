Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E510C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmE3d-0005VA-2n; Mon, 18 Mar 2024 10:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmE3b-0005UA-FL
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmE3X-000341-59
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710772418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGH+NjWA5UAnM+HV6NW2yB4hXpmesnla1CwQOwAZq9Y=;
 b=YaMtOsqQWoc8W6LVUIacTVbJdW9lBbZmMCvSy/PVBjVW6qoKRppHcqy0kByOqE4eisB8pP
 BzoiCKZUt+UbZFlgTnvLmSPW0aOHHT9yrT8+wA9bg8Z3kr8nU5kQH5upV79vHx9PIoPVC2
 P3trB5oSeWy1qTNdh4RKLBSP3naodE4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-jmdBEj31OpSSI8ZyL3sGdw-1; Mon, 18 Mar 2024 10:33:37 -0400
X-MC-Unique: jmdBEj31OpSSI8ZyL3sGdw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed26afd99so1567984f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710772416; x=1711377216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGH+NjWA5UAnM+HV6NW2yB4hXpmesnla1CwQOwAZq9Y=;
 b=kxUUvDAN2EhekqHnnOMVSqeLfGucqruunchX//s+dHRvXWsJrAbaUXVPqADhYoAHiz
 NIWkOhIWTYTFkD7tLFDY/Y7G4KG1/UAVgTgrNXI6+lffWJSpzqhmDux9bOMcHgwoUl0J
 D3awISaff8XRlv9y00UDsU50p6eh4tFF3HZdnZCxkuJfvBR+SSEc87k5Du5Zs1ipDPAC
 LaL7H480DDQoZWTXqFbaqzyQw/3S0l4VJlngyNyBuynXQPOKLmpNJboNO6g7lRjGyyoT
 XXMBjbPe+uLCH8nfkZs63cedsiL2urB9PeAcqABW0iMWjZ+ARGshridvV/6e3cHhKXBe
 vaCg==
X-Gm-Message-State: AOJu0YxzUGzzWfCJsQ0vADfNo8JeY5XdOBU8/fG5mdaiUrxgDgIyROvs
 JD9exfBscg5X5fV6mC1xbkO++SPunOVNhMRXVTOS9OZcl2WjkGuPSzlRqEcLbxUzhPFNB9BZB5C
 1U1F8mksDBiyG0KTz0oAi8ySWKy7DUsoNF69fuqdYIWkYQE8t6WGV
X-Received: by 2002:adf:a494:0:b0:33e:6a17:3e63 with SMTP id
 g20-20020adfa494000000b0033e6a173e63mr6732597wrb.47.1710772416016; 
 Mon, 18 Mar 2024 07:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa9BsmubdRGP7DBCI4wtCwrKm92yg5LMBy1thbSSHPXvDRcbTf7LW0ViHqOGmIAY8PvHFADA==
X-Received: by 2002:adf:a494:0:b0:33e:6a17:3e63 with SMTP id
 g20-20020adfa494000000b0033e6a173e63mr6732569wrb.47.1710772415301; 
 Mon, 18 Mar 2024 07:33:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adff9ca000000b0033e72e104c5sm9905659wrr.34.2024.03.18.07.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:33:34 -0700 (PDT)
Message-ID: <7ab998d7-1963-49a7-92ea-69a7f4739824@redhat.com>
Date: Mon, 18 Mar 2024 15:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/25] memory: Add Error** argument to
 .log_global_start() handler
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-14-clg@redhat.com> <ZfQukLXQsgFEap4f@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfQukLXQsgFEap4f@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/15/24 12:18, Peter Xu wrote:
> On Wed, Mar 06, 2024 at 02:34:28PM +0100, Cédric Le Goater wrote:
>> diff --git a/system/memory.c b/system/memory.c
>> index a229a79988fce2aa3cb77e3a130db4c694e8cd49..3600e716149407c10a1f6bf8f0a81c2611cf15ba 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2914,9 +2914,27 @@ static unsigned int postponed_stop_flags;
>>   static VMChangeStateEntry *vmstate_change;
>>   static void memory_global_dirty_log_stop_postponed_run(void);
>>   
>> +/*
>> + * Stop dirty logging on all listeners where it was previously enabled.
>> + */
>> +static void memory_global_dirty_log_rollback(MemoryListener *listener,
>> +                                             unsigned int flags)
>> +{
>> +    global_dirty_tracking &= ~flags;
> 
> Having a hook rollback function to touch the global_dirty_tracking flag is
> IMHO tricky.
> 
> Can we instead provide a helper to call all log_global_start() hooks, but
> allow a gracefully fail (so rollback will be called if it fails)?
> 
>    bool memory_global_dirty_log_start_hooks(...)
> 
> Or any better names..  Leaving global_dirty_tracking rollback to
> memory_global_dirty_log_start() when it returns false.
> 
> Would this be cleaner?

I will introduce a memory_global_dirty_log_do_start() helper to call
the log_global_start() handlers and to do the rollback in case of
error. Modification of the global_dirty_tracking flag will stay local
to memory_global_dirty_log_start() to avoid any futur errors.


>> +    trace_global_dirty_changed(global_dirty_tracking);
>> +
>> +    while (listener) {
>> +        if (listener->log_global_stop) {
>> +            listener->log_global_stop(listener);
>> +        }
>> +        listener = QTAILQ_PREV(listener, link);
>> +    }
>> +}
>> +
>>   void memory_global_dirty_log_start(unsigned int flags)
>>   {
>>       unsigned int old_flags;
>> +    Error *local_err = NULL;
>>   
>>       assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>>   
>> @@ -2936,7 +2954,25 @@ void memory_global_dirty_log_start(unsigned int flags)
>>       trace_global_dirty_changed(global_dirty_tracking);
>>   
>>       if (!old_flags) {
>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
>> +        MemoryListener *listener;
>> +        bool ret = true;
>> +
>> +        QTAILQ_FOREACH(listener, &memory_listeners, link) {
>> +            if (listener->log_global_start) {
>> +                ret = listener->log_global_start(listener, &local_err);
>> +                if (!ret) {
>> +                    break;
>> +                }
>> +            }
>> +        }
>> +
>> +        if (!ret) {
>> +            memory_global_dirty_log_rollback(QTAILQ_PREV(listener, link),
>> +                                             flags);
>> +            error_report_err(local_err);
>> +            return;
>> +        }
>> +
>>           memory_region_transaction_begin();
>>           memory_region_update_pending = true;
>>           memory_region_transaction_commit();
>> @@ -3009,13 +3045,16 @@ static void listener_add_address_space(MemoryListener *listener,
>>   {
>>       FlatView *view;
>>       FlatRange *fr;
>> +    Error *local_err = NULL;
>>   
>>       if (listener->begin) {
>>           listener->begin(listener);
>>       }
>>       if (global_dirty_tracking) {
>>           if (listener->log_global_start) {
>> -            listener->log_global_start(listener);
>> +            if (!listener->log_global_start(listener, &local_err)) {
>> +                error_report_err(local_err);
>> +            }
> 
> IMHO we should assert here instead of error report.  We have this to guard
> hot-plug during migration so I think the assert is justified:
> 
> qdev_device_add_from_qdict():
> 
>      if (!migration_is_idle()) {
>          error_setg(errp, "device_add not allowed while migrating");
>          return NULL;
>      }
> 
> If it really happens it's a bug, as listener_add_address_space() will still
> keep the rest things around even if the hook failed.  It'll start to be a
> total mess..

OK. I will change the Error parameter to error_abort in that case.

However, It would be useful to catch errors of the .region_add() handler
for VFIO. Let's address that later.

Thanks,

C.




