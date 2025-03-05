Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9474C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpl4v-0006A5-1c; Wed, 05 Mar 2025 04:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpl4s-00069G-OK
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpl4p-0002NX-Gm
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741167005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ndDMkluX6ndQcAl0YLMQh3kKtEnATbW+uFE708Dk998=;
 b=L85dhp/BMbu+Xy5ED8PSxfakgWTlb4zUKs3PLZfu++3wLwxmd/dmIbFyxk7aDnMDTG7NEq
 gY262fPFx+Jb5AfnZ4menevIIcivS2kJZ2wW16Zwj4Wc5XRCSTUykuO/r6Pq2UN3eo32xX
 uO9TGAY0efNIemWntVBuZa3xqI8KoxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-bZyXqFegOFW9aigCfUYAAw-1; Wed, 05 Mar 2025 04:29:48 -0500
X-MC-Unique: bZyXqFegOFW9aigCfUYAAw-1
X-Mimecast-MFC-AGG-ID: bZyXqFegOFW9aigCfUYAAw_1741166987
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so25903745e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 01:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741166987; x=1741771787;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndDMkluX6ndQcAl0YLMQh3kKtEnATbW+uFE708Dk998=;
 b=XlwfmpgEzIoRArFu4bdE3jZSXISSTvuxMxu8a1PM+SQc4K8x1mneRvMh0AzH1inXr8
 MPoiEZmCSV8lq50lhe/wbu/eA6ID+P2tQmRepTg6yJ9fBgnq8OQXhvigfkZriEa7KN0K
 TWjD42PxKt9UU9NskFIkCp9nkagw0HCJ4QEtdNX3qrfdfFv9UcETMMbicpV8Mmfrs2Ki
 dDtwhoyzvgpFrs2vzIjkG/AfCfZUf4j2N0NoDXy6ricpRv2fNCt8xIwEi+cn5VHdPRqg
 aokrltNwA67fjAMLA8HN3DIyJ3zUHPnhpeoDexetHTSBYSWZ+8kiLV9T4pVIRHXH/Qkw
 i4mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQFr/LElyUI02zLA9/CkDh1SmdcTJl69kF4/9K1qrNtAHCu1RDjUsM2o3oR9YJ6KKhPqrmghptCD3u@nongnu.org
X-Gm-Message-State: AOJu0YzKfawwhob4AOMkYlqW7tCVa68+bzkSbGnvtrIat2KRLsWeDbmB
 XDSrAnvZEI3wNRLzVfEuR0/jpIhdo5O7n8wFuwtWZ6+MZPhUUEE5Epx9ZNNb4S4hGOqL9m+BOE4
 NPetNesKXZzoG9WGLAsIw5QbP54ha4WUW9g1wZgcA0GKU49vi126b
X-Gm-Gg: ASbGncvmc2NF7MB1jYQWzPss9fy2wxUQpgC4fjpbdGqtxp28YCQU8xulEqFRGZ5XzQB
 dpJu3ww69KCh0xwi6uncBKBZXmXHiuU6mN6fWJLvuWR3RIBUN1vFy0bcuWiASRlV+CHZcp7NA+T
 FBFTQe+p8ne06hHY3ZQh+h1GFxeUHiZJzDzUKwCXGA3Ln8k6cuyhnj9IJCeOKE+EbQ6rHbnCFGC
 3ankBiaD7KT9Isbm5LarT5LkgbmjXwwDUGF50q5nIZRgSleSYyzIXbj1OaukKYdQclty0cITXMG
 55SyfVJJAXyB7flO2+nSR8h1CQ9TVeKyeKouuvBHBQUMdM+JfbjykA==
X-Received: by 2002:a05:600c:3b9e:b0:43b:ca5b:8490 with SMTP id
 5b1f17b1804b1-43bd289be7emr17601445e9.0.1741166987135; 
 Wed, 05 Mar 2025 01:29:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTk5zlWbpkLjZFIgeGM+BZvAhMbiLN/f/YRYlFSt3argvlQTO4VLGVWja2ovKVfJm3FCgqLA==
X-Received: by 2002:a05:600c:3b9e:b0:43b:ca5b:8490 with SMTP id
 5b1f17b1804b1-43bd289be7emr17601105e9.0.1741166986697; 
 Wed, 05 Mar 2025 01:29:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42b7478sm11740765e9.17.2025.03.05.01.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 01:29:46 -0800 (PST)
Message-ID: <4ea12608-ec9d-4eed-a20c-75f3ac6a5d0d@redhat.com>
Date: Wed, 5 Mar 2025 10:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00/36=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
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

Hello,

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is an updated v6 patch series of the v5 series located here:
> https://lore.kernel.org/qemu-devel/cover.1739994627.git.maciej.szmigiero@oracle.com/
> 
> What this patch set is about?
> Current live migration device state transfer is done via the main (single)
> migration channel, which reduces performance and severally impacts the
> migration downtime for VMs having large device state that needs to be
> transferred during the switchover phase.
> 
> Example devices that have such large switchover phase device state are some
> types of VFIO SmartNICs and GPUs.
> 
> This patch set allows parallelizing this transfer by using multifd channels
> for it.
> It also introduces new load and save threads per VFIO device for decoupling
> these operations from the main migration thread.
> These threads run on newly introduced generic (non-AIO) thread pools,
> instantiated by the core migration core.

I think we are ready to apply 1-33. Avihai, please take a look !

7,15 and 17 still need an Ack from Peter and/or Fabiano though.

34 can be reworked a bit before -rc0.
35 is for QEMU 10.1.
36 needs some massaging. I will do that.

This can go through the vfio tree if everyone agrees.

Thanks,

C.




> Changes from v5:
> * Add bql_locked() assertion to migration_incoming_state_destroy() with a
> comment describing why holding BQL there is necessary.
> 
> * Add SPDX-License-Identifier to newly added files.
> 
> * Move consistency of multfd transfer settings check to the patch adding
> x-migration-multifd-transfer property.
> 
> * Change packet->idx == UINT32_MAX message to the suggested one.
> 
> * Use WITH_QEMU_LOCK_GUARD() in vfio_load_state_buffer().
> 
> * Add vfio_load_bufs_thread_{start,end} trace events.
> 
> * Invert "ret" value computation logic in vfio_load_bufs_thread() and
>    vfio_multifd_save_complete_precopy_thread() - initialize "ret" to false
>    at definition, remove "ret = false" at every failure/early exit block and
>    add "ret = true" just before the early exit jump label.
> 
> * Make vfio_load_bufs_thread_load_config() return a bool and take an
>    "Error **" parameter.
> 
> * Make vfio_multifd_setup() (previously called vfio_multifd_transfer_setup())
>    allocate struct VFIOMultifd if requested by "alloc_multifd" parameter.
> 
> * Add vfio_multifd_cleanup() call to vfio_save_cleanup() (for consistency
>    with the load code), with a comment describing that it is currently a NOP
>    there.
> 
> * Move vfio_multifd_cleanup() to migration-multifd.c.
> 
> * Move general multifd migration description in docs/devel/migration/vfio.rst
>    from the top section to new "Multifd" section at the bottom.
> 
> * Add comment describing why x-migration-multifd-transfer needs to be
>    a custom property above the variable containing that custom property type
>    in register_vfio_pci_dev_type().
> 
> * Add object_class_property_set_description() description for all 3 newly
>    added parameters: x-migration-multifd-transfer,
>    x-migration-load-config-after-iter and x-migration-max-queued-buffers.
> 
> * Split out wiring vfio_multifd_setup() and vfio_multifd_cleanup() into
>    general VFIO load/save setup and cleanup methods into a brand new
>    patch/commit.
> 
> * Squash the patch introducing VFIOStateBuffer(s) into the "received buffers
>    queuing" commit to fix building the interim code form at the time of this
>    patch with "-Werror".
>    
> * Change device state packet "idstr" field to NULL-terminated and drop
>    QEMU_NONSTRING marking from its definition.
> 
> * Add vbasedev->name to VFIO error messages to know which device caused
>    that error.
> 
> * Move BQL lock ordering assert closer to the other lock in the lock order
>    in vfio_load_state_buffer().
> 
> * Drop orphan "QemuThread load_bufs_thread" VFIOMultifd member leftover
>    from the days of the version 2 of this patch set.
> 
> * Change "guint" into an "unsigned int" where it was present in this
>    patch set.
> 
> * Use g_autoptr() for QEMUFile also in vfio_load_bufs_thread_load_config().
> 
> * Call multifd_abort_device_state_save_threads() if a migration error is
>    already set in the save path to avoid needlessly waiting for the remaining
>    threads to do all of their normal work.
> 
> * Other minor changes that should not have functional impact, like:
>    renamed functions/labels, moved code lines between patches contained
>    in this patch set, added review tags, code formatting, rebased on top
>    of the latest QEMU git master, etc.
> 
> ========================================================================
> 
> This patch set is targeting QEMU 10.0.
> 
> It is also exported as a git tree:
> https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio
> 
> ========================================================================
> 
> Maciej S. Szmigiero (35):
>    migration: Clarify that {load,save}_cleanup handlers can run without
>      setup
>    thread-pool: Remove thread_pool_submit() function
>    thread-pool: Rename AIO pool functions to *_aio() and data types to
>      *Aio
>    thread-pool: Implement generic (non-AIO) pool support
>    migration: Add MIG_CMD_SWITCHOVER_START and its load handler
>    migration: Add qemu_loadvm_load_state_buffer() and its handler
>    migration: postcopy_ram_listen_thread() should take BQL for some calls
>    error: define g_autoptr() cleanup function for the Error type
>    migration: Add thread pool of optional load threads
>    migration/multifd: Split packet into header and RAM data
>    migration/multifd: Device state transfer support - receive side
>    migration/multifd: Make multifd_send() thread safe
>    migration/multifd: Add an explicit MultiFDSendData destructor
>    migration/multifd: Device state transfer support - send side
>    migration/multifd: Add multifd_device_state_supported()
>    migration: Add save_live_complete_precopy_thread handler
>    vfio/migration: Add load_device_config_state_start trace event
>    vfio/migration: Convert bytes_transferred counter to atomic
>    vfio/migration: Add vfio_add_bytes_transferred()
>    vfio/migration: Move migration channel flags to vfio-common.h header
>      file
>    vfio/migration: Multifd device state transfer support - basic types
>    vfio/migration: Multifd device state transfer - add support checking
>      function
>    vfio/migration: Multifd setup/cleanup functions and associated
>      VFIOMultifd
>    vfio/migration: Setup and cleanup multifd transfer in these general
>      methods
>    vfio/migration: Multifd device state transfer support - received
>      buffers queuing
>    vfio/migration: Multifd device state transfer support - load thread
>    migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
>    vfio/migration: Multifd device state transfer support - config loading
>      support
>    vfio/migration: Multifd device state transfer support - send side
>    vfio/migration: Add x-migration-multifd-transfer VFIO property
>    vfio/migration: Make x-migration-multifd-transfer VFIO property
>      mutable
>    hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
>      property
>    vfio/migration: Max in-flight VFIO device state buffer count limit
>    vfio/migration: Add x-migration-load-config-after-iter VFIO property
>    vfio/migration: Update VFIO migration documentation
> 
> Peter Xu (1):
>    migration/multifd: Make MultiFDSendData a struct
> 
>   docs/devel/migration/vfio.rst      |  79 ++-
>   hw/core/machine.c                  |   2 +
>   hw/vfio/meson.build                |   1 +
>   hw/vfio/migration-multifd.c        | 786 +++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h        |  37 ++
>   hw/vfio/migration.c                | 111 ++--
>   hw/vfio/pci.c                      |  40 ++
>   hw/vfio/trace-events               |  13 +-
>   include/block/aio.h                |   8 +-
>   include/block/thread-pool.h        |  62 ++-
>   include/hw/vfio/vfio-common.h      |  34 ++
>   include/migration/client-options.h |   4 +
>   include/migration/misc.h           |  25 +
>   include/migration/register.h       |  52 +-
>   include/qapi/error.h               |   2 +
>   include/qemu/typedefs.h            |   5 +
>   migration/colo.c                   |   3 +
>   migration/meson.build              |   1 +
>   migration/migration-hmp-cmds.c     |   2 +
>   migration/migration.c              |  20 +-
>   migration/migration.h              |   7 +
>   migration/multifd-device-state.c   | 212 ++++++++
>   migration/multifd-nocomp.c         |  30 +-
>   migration/multifd.c                | 248 +++++++--
>   migration/multifd.h                |  74 ++-
>   migration/options.c                |   9 +
>   migration/qemu-file.h              |   2 +
>   migration/savevm.c                 | 201 +++++++-
>   migration/savevm.h                 |   6 +-
>   migration/trace-events             |   1 +
>   scripts/analyze-migration.py       |  11 +
>   tests/unit/test-thread-pool.c      |   6 +-
>   util/async.c                       |   6 +-
>   util/thread-pool.c                 | 184 +++++--
>   util/trace-events                  |   6 +-
>   35 files changed, 2125 insertions(+), 165 deletions(-)
>   create mode 100644 hw/vfio/migration-multifd.c
>   create mode 100644 hw/vfio/migration-multifd.h
>   create mode 100644 migration/multifd-device-state.c
> 


