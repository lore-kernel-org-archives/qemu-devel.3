Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBAEC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2CW-0000b1-RB; Mon, 03 Mar 2025 04:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp2C8-0000Yc-2E
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:34:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp2C3-0008D4-Vn
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740994474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CBonXNuVxD39i3zbZ67LbBrSExdivCJqgCzYXnb2wn4=;
 b=PkK446kI/+14ayYR2iNGAHXsQ/es/sNENQVPOMTywWjSc1Own8zWqeroRorL97QyGz0z6F
 I1+EMukSbScClD4LS5iGBX1Ea+wQZGXUS5QV/uKT1CAW16W37ljbsMtrm+nG+APgtDK0ua
 cO20ovwcUOmrj4f2toMlj3WNlHG0jTc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-DxBnOQa3MH65t-28DpKltw-1; Mon, 03 Mar 2025 04:34:33 -0500
X-MC-Unique: DxBnOQa3MH65t-28DpKltw-1
X-Mimecast-MFC-AGG-ID: DxBnOQa3MH65t-28DpKltw_1740994472
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3910b93cb1eso230103f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 01:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740994472; x=1741599272;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBonXNuVxD39i3zbZ67LbBrSExdivCJqgCzYXnb2wn4=;
 b=VDzwt1BEl2V4ppFKVSR2V0MQA7NuWwowpQSSFjVAZRA3MKobPuMJidVucO1PafQO6E
 fwUw8OrncszAMf0vKNhUCnQCqxtTaM2stXeNi2ZO3/hTw9OELQhPnZvbUm9Y+3JYG/K2
 w49NoWRqf8HIdfEtSXZwfu7q67H1XdGtSmdNG4O84M/rWqnLZ24WSDkrBac1nZTX4Tmj
 zkNYCqpVb3mSkwo0jNNXJFe/T3vFa83vFcETWEJ6FIa853sFi1NZr/oqZOlng0MJ4JWt
 wyCQXbOfbN5mrVeZ6d0900WYHstxVeDIs752UlQtZPBxQtlFyv0zMvNR9FNwjvdK2Pgu
 F9vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Hn6GqiZCBbWF49oN933QQtknwdX8sd28enxqOSuBAj/H0auRGZXQqHHY0ZzzNplsbGx+6+A371pa@nongnu.org
X-Gm-Message-State: AOJu0Ywg99G0AoZ3rbM3sU4z16DjuJkUNSiqjFVDI/UpaGXLCqGZeGOX
 k1UgRodsuEaNL0X7MDOBfX1q986INUjCjS7LbeUOnyA6RMPJgxEHcTGHWtYWaRqM+NiQQ00MGnE
 BsZS3m11tLu61ws9F+g5iworir72Zc2J11QKnNQg1gmW0MMqpk+zx
X-Gm-Gg: ASbGncuywDNq9cOQ6Yv2za3xG1DHRztHMrHmabFFMJPFDUXPkVwYyimaDbOsYYCYPcs
 l5At1AttLeFbG6Uv1sekmCoQuvYQlTUmpRb7R9J2VgJOGvEpa47TyMaU3BMTJMfA06xwAEyNKp0
 haX25qqpnKZPH98+pyoq3EpFXNxoyHB/RDwAwg50w64MjR5xedoHxGghWtCmF9j4yLVa9jEsJnn
 wA0LP/hmPegtN9X/Qh7pL16Fjlb8Z9EHjHNmkK7l74siaMnxicCxUUvY0aZ7NdZYYshEuKxyW9H
 cGpgPuIgwvNk2tw++shrlx/4at/unu1JGQDQkJjCmVJMnQyWzPZKRg==
X-Received: by 2002:a5d:5889:0:b0:391:d52:d03d with SMTP id
 ffacd0b85a97d-3910d52d0bemr1272077f8f.32.1740994471975; 
 Mon, 03 Mar 2025 01:34:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/LlhjefEz67HGmKuXyaphcoEzXkgUHJmxwDPDBpaaWHpgJ7s+c9iToglZypiXeQ60cMxt2g==
X-Received: by 2002:a5d:5889:0:b0:391:d52:d03d with SMTP id
 ffacd0b85a97d-3910d52d0bemr1272034f8f.32.1740994471455; 
 Mon, 03 Mar 2025 01:34:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484489esm14199065f8f.68.2025.03.03.01.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 01:34:30 -0800 (PST)
Message-ID: <40d313d7-d16a-4342-aeb3-ae73f52cd911@redhat.com>
Date: Mon, 3 Mar 2025 10:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 36/36] vfio/migration: Update VFIO migration
 documentation
To: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <2031790b755aa95b61470b286fa787b78be08107.1739994627.git.maciej.szmigiero@oracle.com>
 <cbebee68-f891-4946-885d-01a8ed24e6c1@redhat.com>
 <7c41add3-72ad-4aec-bd74-3c9715fda5c7@maciej.szmigiero.name>
 <a7f66c0f-1355-43e6-b20d-eddaef6fb1d1@redhat.com> <87frjxvdvm.fsf@suse.de>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <87frjxvdvm.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 3/1/25 00:38, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> On 2/27/25 23:01, Maciej S. Szmigiero wrote:
>>> On 27.02.2025 07:59, Cédric Le Goater wrote:
>>>> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> Update the VFIO documentation at docs/devel/migration describing the
>>>>> changes brought by the multifd device state transfer.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> ---
>>>>>    docs/devel/migration/vfio.rst | 80 +++++++++++++++++++++++++++++++----
>>>>>    1 file changed, 71 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
>>>>> index c49482eab66d..d9b169d29921 100644
>>>>> --- a/docs/devel/migration/vfio.rst
>>>>> +++ b/docs/devel/migration/vfio.rst
>>>>> @@ -16,6 +16,37 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
>>>>>    support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>>>>>    VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>>>
>>>> Please add a new "multifd" documentation subsection at the end of the file
>>>> with this part :
>>>>
>>>>> +Starting from QEMU version 10.0 there's a possibility to transfer VFIO device
>>>>> +_STOP_COPY state via multifd channels. This helps reduce downtime - especially
>>>>> +with multiple VFIO devices or with devices having a large migration state.
>>>>> +As an additional benefit, setting the VFIO device to _STOP_COPY state and
>>>>> +saving its config space is also parallelized (run in a separate thread) in
>>>>> +such migration mode.
>>>>> +
>>>>> +The multifd VFIO device state transfer is controlled by
>>>>> +"x-migration-multifd-transfer" VFIO device property. This property defaults to
>>>>> +AUTO, which means that VFIO device state transfer via multifd channels is
>>>>> +attempted in configurations that otherwise support it.
>>>>> +
>>>
>>> Done - I also moved the parts about x-migration-max-queued-buffers
>>> and x-migration-load-config-after-iter description there since
>>> obviously they wouldn't make sense being left alone in the top section.
>>>
>>>> I was expecting a much more detailed explanation on the design too  :
>>>>
>>>>    * in the cover letter
>>>>    * in the hw/vfio/migration-multifd.c
>>>>    * in some new file under docs/devel/migration/
>>
>> I forgot to add  :
>>
>>        * guide on how to use this new feature from QEMU and libvirt.
>>          something we can refer to for tests. That's a must have.
>>        * usage scenarios
>>          There are some benefits but it is not obvious a user would
>>          like to use multiple VFs in one VM, please explain.
>>          This is a major addition which needs justification anyhow
>>        * pros and cons
>>
>>> I'm not sure what descriptions you exactly want in these places,
>>
>> Looking from the VFIO subsystem, the way this series works is very opaque.
>> There are a couple of a new migration handlers, new threads, new channels,
>> etc. It has been discussed several times with migration folks, please provide
>> a summary for a new reader as ignorant as everyone would be when looking at
>> a new file.
>>
>>
>>> but since
>>> that's just documentation (not code) it could be added after the code freeze...
>>
>> That's the risk of not getting any ! and the initial proposal should be
>> discussed before code freeze.
>>
>> For the general framework, I was expecting an extension of a "multifd"
>> subsection under :
>>
>>     https://qemu.readthedocs.io/en/v9.2.0/devel/migration/features.html
>>
>> but it doesn't exist :/
> 
> Hi, see if this helps. Let me know what can be improved and if something
> needs to be more detailed. Please ignore the formatting, I'll send a
> proper patch after the carnaval.

This is very good !  Thanks a lot Fabiano for providing this input.

> @Maciej, it's probably better if you keep your docs separate anyway so
> we don't add another dependency. I can merge them later.

Perfect. Maciej, We will adjust the file to apply it to before merging.


Thanks,

C.



> 
> multifd.rst:
> 
> Multifd
> =======
> 
> Multifd is the name given for the migration capability that enables
> data transfer using multiple threads. Multifd supports all the
> transport types currently in use with migration (inet, unix, vsock,
> fd, file).
> 
> Restrictions
> ------------
> 
> For migration to a file, support is conditional on the presence of the
> mapped-ram capability, see #mapped-ram.
> 
> Snapshots are currently not supported.
> 
> Postcopy migration is currently not supported.
> 
> Usage
> -----
> 
> On both source and destination, enable the ``multifd`` capability:
> 
>      ``migrate_set_capability multifd on``
> 
> Define a number of channels to use (default is 2, but 8 usually
> provides best performance).
> 
>      ``migrate_set_parameter multifd-channels 8``
> 
> Components
> ----------
> 
> Multifd consists of:
> 
> - A client that produces the data on the migration source side and
>    consumes it on the destination. Currently the main client code is
>    ram.c, which selects the RAM pages for migration;
> 
> - A shared data structure (MultiFDSendData), used to transfer data
>    between multifd and the client. On the source side, this structure
>    is further subdivided into payload types (MultiFDPayload);
> 
> - An API operating on the shared data structure to allow the client
>    code to interact with multifd;
> 
>    - multifd_send/recv(): A dispatcher that transfers work to/from the
>      channels.
> 
>    - multifd_*payload_* and MultiFDPayloadType: Support defining an
>      opaque payload. The payload is always wrapped by
>      MultiFDSend|RecvData.
> 
>    - multifd_send_data_*: Used to manage the memory for the shared data
>      structure.
> 
> - The threads that process the data (aka channels, due to a 1:1
>    mapping to QIOChannels). Each multifd channel supports callbacks
>    that can be used for fine-grained processing of the payload, such as
>    compression and zero page detection.
> 
> - A packet which is the final result of all the data aggregation
>    and/or transformation. The packet contains a header, a
>    payload-specific header and a variable-size data portion.
> 
>     - The packet header: contains a magic number, a version number and
>       flags that inform of special processing needed on the
>       destination.
> 
>     - The payload-specific header: contains metadata referent to the
>       packet's data portion, such as page counts.
> 
>     - The data portion: contains the actual opaque payload data.
> 
>    Note that due to historical reasons, the terminology around multifd
>    packets is inconsistent.
> 
>    The mapped-ram feature ignores packets entirely.
> 
> Theory of operation
> -------------------
> 
> The multifd channels operate in parallel with the main migration
> thread. The transfer of data from a client code into multifd happens
> from the main migration thread using the multifd API.
> 
> The interaction between the client code and the multifd channels
> happens in the multifd_send() and multifd_recv() methods. These are
> reponsible for selecting the next idle channel and making the shared
> data structure containing the payload accessible to that channel. The
> client code receives back an empty object which it then uses for the
> next iteration of data transfer.
> 
> The selection of idle channels is simply a round-robin over the idle
> channels (!p->pending_job). Channels wait at a semaphore, once a
> channel is released, it starts operating on the data immediately.
> 
> Aside from eventually transmitting the data over the underlying
> QIOChannel, a channel's operation also includes calling back to the
> client code at pre-determined points to allow for client-specific
> handling such as data transformation (e.g. compression), creation of
> the packet header and arranging the data into iovs (struct
> iovec). Iovs are the type of data on which the QIOChannel operates.
> 
> Client code (migration thread):
> 1. Populate shared structure with opaque data (ram pages, device state)
> 2. Call multifd_send()
>     2a. Loop over the channels until one is idle
>     2b. Switch pointers between client data and channel data
>     2c. Release channel semaphore
> 3. Receive back empty object
> 4. Repeat
> 
> Multifd channel (multifd thread):
> 1. Channel idle
> 2. Gets released by multifd_send()
> 3. Call multifd_ops methods to fill iov
>     3a. Compression may happen
>     3b. Zero page detection may happen
>     3c. Packet is written
>     3d. iov is written
> 4. Pass iov into QIOChannel for transferring
> 5. Repeat
> 
> The destination side operates similarly but with multifd_recv(),
> decompression instead of compression, etc. One important aspect is
> that when receiving the data, the iov will contain host virtual
> addresses, so guest memory is written to directly from multifd
> threads.
> 
> About flags
> -----------
> The main thread orchestrates the migration by issuing control flags on
> the migration stream (QEMU_VM_*).
> 
> The main memory is migrated by ram.c and includes specific control
> flags that are also put on the main migration stream
> (RAM_SAVE_FLAG_*).
> 
> Multifd has its own set of MULTIFD_FLAGs that are included into each
> packet. These may inform about properties such as the compression
> algorithm used if the data is compressed.
> 
> Synchronization
> ---------------
> 
> Since the migration process is iterative due to RAM dirty tracking, it
> is necessary to invalidate data that is no longer current (e.g. due to
> the source VM touching the page). This is done by having a
> synchronization point triggered by the migration thread at key points
> during the migration. Data that's received after the synchronization
> point is allowed to overwrite data received prior to that point.
> 
> To perform the synchronization, multifd provides the
> multifd_send_sync_main() and multifd_recv_sync_main() helpers. These
> are called whenever the client code whishes to ensure that all data
> sent previously has now been received by the destination.
> 
> The synchronization process involves performing a flush of the
> ramaining client data still left to be transmitted and issuing a
> multifd packet containing the MULTIFD_FLAG_SYNC flag. This flag
> informs the receiving end that it should finish reading the data and
> wait for a synchronization point.
> 
> To complete the sync, the main migration stream issues a
> RAM_SAVE_FLAG_MULTIFD_FLUSH flag. When that flag is received by the
> destination, it ensures all of its channels have seen the
> MULTIFD_FLAG_SYNC and moves them to an idle state.
> 
> The client code can then continue with a second round of data by
> issuing multifd_send() once again.
> 
> The synchronization process also ensures that internal synchronization
> happens, i.e. between each thread. This is necessary to avoid threads
> lagging behind sending or receiving when the migration approaches
> completion.
> 
> The mapped-ram feature has different synchronization requirements
> because it's an asynchronous migration (source and destination not
> migrating at the same time). For that feature, only the internal sync
> is relevant.
> 
> Data transformation
> -------------------
> 
> Each multifd channel executes a set of callbacks before transmitting
> the data. These callbacks allow the client code to alter the data
> format right before sending and after receiving.
> 
> Since the object of the RAM migration is always the memory page and
> the only processing done for memory pages is zero page detection,
> which is already part of compression in a sense, the multifd_ops
> functions are mutually exclusively divided into compression and
> no-compression.
> 
> The migration without compression (i.e. regular ram migration) has a
> further specificity as mentioned of possibly doing zero page detection
> (see zero-page-detection migration parameter). This consists of
> sending all pages to multifd and letting the detection of a zero page
> happen in the multifd channels instead of doing it beforehand on the
> main migration thread as it was done in the past.
> 
> Code structure
> --------------
> 
> Multifd code is divided into:
> 
> The main file containing the core routines
> 
> - multifd.c
> 
> RAM migration
> 
> - multifd-nocomp.c (nocomp, for "no compression")
> - multifd-zero-page.c
> - ram.c (also involved in non-multifd migrations + snapshots)
> 
> Compressors
> 
> - multifd-uadk.c
> - multifd-qatzip.c
> - multifd-zlib.c
> - multifd-qpl.c
> - multifd-zstd.c
> 


