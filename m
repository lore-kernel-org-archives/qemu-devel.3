Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59298C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBXX-0005t0-QR; Fri, 26 Jun 2026 14:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBXW-0005mM-81
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBXS-0003Lm-LK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w7ZANMtU5sm5/C/vAJEmnfKUy3gQtm35xaQV0WcjevM=;
 b=D5NI6Evx9e7ny4HBxuQfBlqQ5JGBi+dmlXn7wcyT45c+xfjpuzhNS1j7RxBI13rHN/RvAB
 3cnT2uRAXPhqhYbDw6+EONB8NeQZkyumxRQJEnMqbsDhIdOlQbV57PJS/lAJ9BV4MMwP89
 d/2sczGezjFuj09/aZS0dPbIaMUudW0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-kHcSiuunNTW9amMT55avYw-1; Fri, 26 Jun 2026 14:44:28 -0400
X-MC-Unique: kHcSiuunNTW9amMT55avYw-1
X-Mimecast-MFC-AGG-ID: kHcSiuunNTW9amMT55avYw_1782499467
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-492488f8583so12241105e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499467; x=1783104267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=w7ZANMtU5sm5/C/vAJEmnfKUy3gQtm35xaQV0WcjevM=;
 b=VrwV+ZzyvTh1W8rMf0XVv6qb1jAyWK04vNuZT3ChP9EPSuDha3UAYkkXob4umgNPsR
 nC/qpUVPUlWJcp96M1JG7RXxxYVRbzgK1TfyIfQWill0pb4vGKrmBBI/p7Xa9ZhCDBKw
 WJ36Kk0VrnspOPIhiZx/uSayCVG7AFkMn8YiwEuC3rP8YBpx0iW1yxNdBEIRvABSIqFk
 WRmUhfhFjj0tcqPr8R1vq4ugG9Pc/G8Ho+MnZN5qtcHSi4f/gAmr3GHyKJjjgY7Gv5BH
 aiTTNKOLnczRhvy/sX8NiSli7rwLBlJV2Esq0hcfClrNWy3JPB5VQTFhGxlPeor9wtJw
 tjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499467; x=1783104267;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7ZANMtU5sm5/C/vAJEmnfKUy3gQtm35xaQV0WcjevM=;
 b=cEJiNw4RssCkpWzQ8lLz1YaPlzaUbyrM5wtMth5Xo0eELvZRjrZsWD4eMch070CSvb
 Zq8zgncS85Z4G5NCZaQ6qhIcQhdmZ7I1A4OSG4HykCtdQT80ztEnxaZ28jeH4+B2jvfm
 uM6yC8BMVhuZiPXH4sk0khUva8JhSEY4d+761Q4PmOB5nEeXZqAH6YXp0M20PW0+VyG5
 WYpZUrt6Rbi5vyWdtcDBzbh6s4l22R+8dcFrlLTXJtTslPjw0aFqTh2wuOAb8zpkJTgE
 8vOS/3Qi+e+Saj7yrBQAYv5NZqa/YKKr/w5R38699oLOyxzvD7nW+OGfyH0MTcg6cxm+
 ggmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kFlkx1/pDxKMAWq8fPparj907FNHTWYFvTt7X7zcPbkwnMsdQl6P/qFuOKQkRv+Wp4ytdPEe2dAJa@nongnu.org
X-Gm-Message-State: AOJu0YwLwsrM4exKHP+ltxqtBDa4Ee3oyufrVE6+mjBUHNG+la9GZmRs
 MI68VEQD3R6Easvg6GLEHTcn0nrLBD6n2pC3zpr0WlLklDfru2LVoLHCsRdS0vuI3FOg9BXgcwo
 mnQr3EGKO4LLzgIyJ8uNl6MT714cz6YpovXLEOJuhx/MpRSTt32E03hp1
X-Gm-Gg: AfdE7cmKLifLncYDXVRGeQsJJPoqK6hREInXldgLzisntyntqbgSIwH+NSHkBp9/jr9
 fj5b6IKhHlJS8fBTKzAYEZZU5m1Y9EOY3Xxyc782EDM2hJ6yGTitR1fOz0PDQAVsl2oWCIPX/D7
 Qq4/HafRZ8LVpQslv+O09eryQU4QaTOfzStmtvyfAaQjEodrfbra52r3IQVA0QEkzbGsD9wgYYz
 59NXlL3bpQVs27fh/WJ20WLW6vtiRbyfGBtDUVhHKOBJ9Y5WZzZYqs+zWaV86N6dCZxouFJFHTS
 Gi9o9zVQ2k5ajyWG0/6PNGfhxp2DBerMPM2IUOX90YycCwggorEWR+YZpeF1u4eNP41W5rAwW7s
 oAC71Z57IqRoG46xTh0JIZ7yBhKvnng/5nFvEVBNC7k5uPOAD53EM
X-Received: by 2002:a05:600c:4e54:b0:492:523f:a3df with SMTP id
 5b1f17b1804b1-4926685fccfmr119361425e9.5.1782499467142; 
 Fri, 26 Jun 2026 11:44:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4e54:b0:492:523f:a3df with SMTP id
 5b1f17b1804b1-4926685fccfmr119360935e9.5.1782499466663; 
 Fri, 26 Jun 2026 11:44:26 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22c680fasm27449420f8f.34.2026.06.26.11.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:44:26 -0700 (PDT)
Message-ID: <7964bff5-fad8-4627-8999-85d90486b2f3@redhat.com>
Date: Fri, 26 Jun 2026 20:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Make switchover-ack re-usable and add VFIO
 precopy REINIT feature
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/22/26 12:12, Avihai Horon wrote:
> Hello,
> 
> Changes from v3 [4]:
> * Rebased on top of master.
> * Patch #7: Moved switchover-ack-legacy machine compat entry to patch
>    #14. (Peter)
> * Collected R-bs.
> 
> Changes from v2 [3]:
> * Rebased on top of master.
> * Patch #1: Added Error **errp parameter to
>    qemu_savevm_state_complete_precopy(). (Peter)
> * Added new patch that replaces migration_bitmap_sync() with
>    migration_bitmap_sync_precopy() in ram_postcopy_send_discard_bitmap().
>    (Peter)
> * Patch #2:
>    - Dropped dirty sync from ram_postcopy_send_discard_bitmap(). (Peter)
>    - Added explanatory comment to qemu_savevm_query_pending_final() call
>      site for precopy and postcopy case. (Peter)
>    - Removed skipping of final pending query for cmma, vfio and block
>      dirty bitmap, and updated mig_stats.dirty_bytes_total
>      unconditionally. (Peter)
> * Patch #6: Rephrased switchover-ack QAPI documentation and fixed
>    return-path markup. (Markus)
> * Patch #7: Moved new switchover-ack requests check during switchover
>    inside qemu_savevm_query_pending_final() and used local
>    switchover_ack_pending counter instead of global one. (Peter)
> * Patch #9: Changed vfio_migration_init() to return bool. (Philippe)
> * Collected R-bs.
> 
> Changes from v1 [2]:
> * Rebased on top of master.
> * Added a new patch that runs a final save_query_pending at switchover
>    (replace RAM specific code). (Peter)
> * Dropped patches #1 and #2 as they were already taken by Cedric (in
>    some way or another).
> * Patch #3: Used Error variable of migration_completion() instead of
>    adding a new one in migration_completion_precopy(). (Cedric, Peter)
> * Patch #6: Dropped renaming of qemu_loadvm_approve_switchover to legacy
>    since in next patch it's renamed back again. (Peter)
> * Patch #7:
>    - Rephrased switchover-ack QAPI documentation to be more general and
>      not mention number of ACKs sent. (Peter)
>    - Dropped the new request_switchover_ack SaveVMHandler and instead
>      requested switchover ACKs via save_query_pending SaveVMHandler.
>      (Peter)
>    - Added documentation comment for legacy/new switchover-ack. (Peter)
> * Patch #8: Adjusted according to changes in patch #7.
> * Dropped patch #9 since the scenario that it comes to solve can't
>    really happen (kept only the part that extracts sending of
>    INIT_DATA_SENT flag to a helper). (Peter, Cedric)
> * Patch #10: Used error_prepend() to add error prefix in
>    vfio_migration_init(). (Cedric)
> * Patch #11-13: Adjusted according to changes in patch #7.
> * Patch #12: Added explanation about VFIO_PRECOPY_INFO_REINIT and an
>    example to vfio migration documentation. (Peter)
> * Collected R-bs.
> 
> ===
> 
> This series adds support for the kernel VFIO_PRECOPY_INFO_REINIT feature
> [1], which can reduce migration downtime in some VFIO precopy scenarios
> (see the Tests section below). Supporting it requires refactoring
> switchover-ack and making it re-usable; that work comes first.
> 
> === Background ===
> 
> Switchover-ack is a mechanism to synchronize between source and
> destination QEMU during migration to prevent the source from switching
> over prematurely.
> 
> VFIO uses switchover-ack to ensure switchover happens only after
> destination side has loaded the precopy initial bytes. This is important
> for VFIO, as otherwise downtime could be impacted and be higher.
> 
> In its current state, switchover-ack is a one-time mechanism, meaning
> that switchover is acked only once and past that another ACK cannot be
> requested again. This was sufficient until now, as VFIO precopy initial
> bytes was defined to be monotonically decreasing. Thus, when precopy
> initial bytes reached zero for all VFIO devices, a single ACK would be
> sent and its validity would hold.
> 
> === Problem ===
> 
> Now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy initial
> bytes to be re-initialized during precopy. Specifically, it means that
> initial bytes can grow after reaching zero, which would invalidate a
> previously sent switchover ACK.
> 
> === Solution ===
> 
> To support VFIO_PRECOPY_INFO_REINIT, this series makes switchover-ack
> re-usable and allows devices to request another switchover ACK when
> needed.
> 
> In the new mechansim, switchover ACK can be requested for a specific
> device and in different times, so switchover ACK is changed to be
> per-device (instead of a single ACK for all devices) and source side is
> the one who does the pending ACKs accounting (instead of destination
> side).
> 
> The old (legacy) switchover-ack mechanism is kept for backward
> compatibility and is turned on by a compatibility property for older
> machines.
> 
> With that infrastructure in place, VFIO uses the new switchover-ack path
> and implements VFIO_PRECOPY_INFO_REINIT.
> 
> === Tests ===
> 
> Functional and performance tests were run.
> 
> Performance tests were done by migrating a single VM with:
> * 8 GB RAM
> * 4 mlx5 VFIO devices:
>    - One device with 1GB of device data (stopcopy data) that runs
>      workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
>      (generate new initial_bytes chunks during precopy).
>    - The other 3 devices are idle.
> 
> In this setup, VFIO_PRECOPY_INFO_REINIT reduced total migration downtime by
> about 43%, and downtime attributed to the busy VFIO device by about 67%:
> 
> With VFIO_PRECOPY_INFO_REINIT:
>    1335ms total (~520ms from the VFIO device running the workload).
> 
> Without VFIO_PRECOPY_INFO_REINIT:
>    2352ms total (~1600ms from the VFIO device running the workload).
> 
> Functional tests covered the main code paths and combinations, including
> legacy and new switchover-ack across versions, for example:
> * Migration between QEMU 11.0 (old binary) and 11.1 (new binary).
> * Migration between two 11.1 binaries with different machine versions.
> * Migration when the VFIO device has no VFIO_PRECOPY_INFO_REINIT.
> * Migration when the VFIO device has no VFIO precopy support.
> 
> === Patch Breakdown ===
> 
> * Patches 1-8,14: Migration cleanups and the new switchover-ack mechanism
> * Patches 9-13: VFIO cleanups and VFIO_PRECOPY_INFO_REINIT
> 
> Thanks.
> 
> [1] https://lore.kernel.org/all/20260317161753.18964-1-yishaih@nvidia.com/
> [2] https://lore.kernel.org/qemu-devel/20260505081423.28326-1-avihaih@nvidia.com/
> [3] https://lore.kernel.org/qemu-devel/20260602092621.382-1-avihaih@nvidia.com/
> [4] https://lore.kernel.org/qemu-devel/20260609075812.32067-1-avihaih@nvidia.com/
> 
> Avihai Horon (14):
>    migration: Propagate errors in migration_completion_precopy()
>    migration/ram: Use migration_bitmap_sync_precopy() for postcopy
>      discard
>    migration: Run final save_query_pending at switchover
>    migration: Log the approver in qemu_loadvm_approve_switchover()
>    migration: Replace switchover_ack_needed SaveVMHandler
>    migration: Rename switchover-ack code to legacy
>    migration: Make switchover-ack re-usable
>    migration: Fail migration if switchover-ack is requested after
>      switchover decision
>    vfio/migration: Extract VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to
>      helper
>    vfio/migration: Add Error ** parameter to vfio_migration_init()
>    vfio/migration: Add new switchover-ack mechanism
>    vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
>    vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
>    migration: Enable new switchover-ack
> 
>   docs/devel/migration/vfio.rst      |  17 ++-
>   qapi/migration.json                |  14 +-
>   hw/vfio/vfio-migration-internal.h  |   2 +
>   include/migration/client-options.h |   1 +
>   include/migration/misc.h           |   2 +
>   include/migration/register.h       |  56 ++++----
>   migration/migration.h              |  34 ++++-
>   migration/savevm.h                 |   9 +-
>   hw/core/machine.c                  |   1 +
>   hw/s390x/s390-stattrib.c           |   2 +-
>   hw/vfio/migration.c                | 204 +++++++++++++++++++++++------
>   migration/block-dirty-bitmap.c     |  11 +-
>   migration/migration.c              |  73 +++++++++--
>   migration/options.c                |   9 ++
>   migration/ram.c                    |  40 +++---
>   migration/savevm.c                 | 173 ++++++++++++++++--------
>   hw/vfio/trace-events               |   7 +-
>   migration/trace-events             |   9 +-
>   18 files changed, 476 insertions(+), 188 deletions(-)
> 


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


