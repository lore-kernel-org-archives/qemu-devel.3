Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B192FEF8FE3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmGz-0003UC-D9; Wed, 04 Mar 2026 08:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxmGp-0003Qp-DD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxmGn-0002Jl-Sz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772630888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dyF7Anbi15goNLpoLuRwZCY+QvMurNIzg9MVhpNEL6w=;
 b=OrrYwgzf3GUshJ5vUe9VNmUfzOx1B8ZC7RpQd+g4CVO5wClAe9ecGw1WeUqS21VF341PrQ
 3H+XxuwDZhjRqfQiJpTW9m3BaIs3VbMcepEf9hmVno0XZaeyk7/r3X4N6dq25iWsyLRNG2
 Vvl+EXybeV5DTs4QW26OacTWN0/XQK8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-i7qWOqs1PSyV3Yn_ePaHEg-1; Wed, 04 Mar 2026 08:28:08 -0500
X-MC-Unique: i7qWOqs1PSyV3Yn_ePaHEg-1
X-Mimecast-MFC-AGG-ID: i7qWOqs1PSyV3Yn_ePaHEg_1772630887
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837246211bso80948545e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772630886; x=1773235686; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dyF7Anbi15goNLpoLuRwZCY+QvMurNIzg9MVhpNEL6w=;
 b=nEt3l7dnXTHL21u3y6pSIIfI/lTXFdxergyEHQcTShg/ANVuKry8Wxp2zQiklpmZO4
 JmBXk4eaIPzTRjKGeb2vTiRTPeCSPAJNKVYAgu26NTahZc4CveJB/Jy3YzwZaNu7wjUq
 2STzIwRImECoLrGDyzui3Wr/SLov8a8GFYvHkpb6e/w1XY4qOnEA2wDH3S5mQ8shjVNY
 8hZvQxCjxppF1KMaCnVZMjEt7ibub7yPJdTI0nh+7J/o/CiG7Cdekk/k8JkhbSKDP5UM
 L654jS3FGKk3K2uDv0e9Di7/IauFDAWFQVFdJIUTbPxNcNsowo7ZaxD5CyBn/lYPRFSJ
 mKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630886; x=1773235686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyF7Anbi15goNLpoLuRwZCY+QvMurNIzg9MVhpNEL6w=;
 b=YnmG5aXSyeigaMADobt24WJ/wGMHBxBQ/a4MEJ9qFZZ5maH23+Cv2sa8dGVNK+Oro3
 bdjukTnTpFg1oCCrMrb6Ofak/7t+Pg5jMTwwC6SGXZ4umEsSrs+bTIPfQrkRRA5Uph7J
 m7s29P4hFPuHfmbNfT/Hlr82cfR+3m+hfpZL3wMz/NW3neQ5gtKxvjqCPhgX2yLsudO8
 M3n2D9CCnEo4sxvjOsa0vo/FTCRFImXszUDWNDtF5yjwelLIdERRhGmBP0YN8arfr+16
 S49tDHxzrTP58bG2EpcjvTMKR+7o8WBsBxkhf3qgQ8LMN0caJKij6+by2DsZ+k0gmM+1
 k+bA==
X-Gm-Message-State: AOJu0YwIIth0Du/rLf8nHJmJtmZSd0kR/ngubNNWzD5LTfx72huNZiQA
 YHVs76BgxiUDG2svCDEW9VRUzlAXp7K1JCXxr5tj96yUG8EgXV8K4rwaS2vwkDE2mXmNufjfuDp
 wVK2m8kVX4vfMTwjU4EUYMDj86Tj0wUaG0NSiQZGzaGPDM4lgXbbSvoc/MB9IFpL8
X-Gm-Gg: ATEYQzzifccBCXK5Od8OGewClKEow/gSs6k7U1Bud1uivZKlqKrwz3wYqky35uDueP0
 MHZCUUWqLx5aE/ZgAVSFUmOzo/sZvhDfXHgNQxG99rRjvWCbFiFHfJXKnRJRdtoYd7SmU9TRZKp
 tFdPiPdvwNgAQFN+kNfD7T1vLoyZDlr+5bSBJZB8+Opp3vZPztNL3H1sNuu0r6+5MHpmRXvhQ9G
 FaXQxfd3VF/BYspPK3Hfs4bTFj5b/iNJapTnwjiwqg7EcOnjTkmUgPG3apD/TgVJE1MnJowMRLi
 8sgNerNx/sCYGDxWEuCARlqyX7RQqQmuicJC7o8xd9ofX+YyR4VYw//DxwYVw0WgXBAkUsKjCAc
 a87rMnrwZlBE1lNKcibcRHTQSO/olWW+RR4CGgKe/iVbHsuC5Y8097lc6JNIquN4ICblnHu0=
X-Received: by 2002:a05:600c:1f13:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-485198bab53mr30304735e9.34.1772630886118; 
 Wed, 04 Mar 2026 05:28:06 -0800 (PST)
X-Received: by 2002:a05:600c:1f13:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-485198bab53mr30304235e9.34.1772630885585; 
 Wed, 04 Mar 2026 05:28:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485188422dbsm55054725e9.5.2026.03.04.05.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:28:05 -0800 (PST)
Date: Wed, 4 Mar 2026 14:28:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <aagy-gBSlkNAZuNv@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260219130334.787858-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 19, 2026 at 02:03:27PM +0100, Albert Esteve wrote:
>Hi all,

Thanks, I fully reviewed this and LGTM! I left some minor comments.

@Michael IIUC this is not applying on master, so I suggested to rebase 
and send a new verions. Would be great if we can merge this before rc0.

Thanks,
Stefano

>
>v12-v13
>- SMEM_UNMAP spec update to explicitly state the use of
>  VHOST_USER_PROTOCOL_F_REPLY_ACK for replies
>- Removed confusing remark for 0-sized regions in
>  GET_SHMEM_CONFIG
>v11->v12
>- Refined VIRTIO Shared Memory Region configuration mem size
>  spec description
>- Removed unused name in vhost-user-base's vub_device_realize to
>  avoid build error
>- Initialize shmem in vhost_user_backend_handle_shmem_unmap
>  to avoid compiler being confused
>- Added stub for memory_region_init_ram_from_fd in memory.h
>  for windows builds
>- Use memory_region_size for shmem_region handlers instead
>  of accessing size member directly in shmem mrs
>v10->v11
>- Rebase to grab commit fde5930cc37175cfcd0f03a089e26f4458a52311
>  and explicitly unset reply_ack on the SHMEM_MAP/UNMAP msg.
>- Mention mapping cleanup on device reset in the spec.
>v9->v10
>- Fix transaction_commit invoked without transaction_begin
>  on vhost_user_backend_handle_shmem_map() early errors
>- Removed fd tracking on VirtioSharedMemoryMapping, it
>  is handled by the RAMBlock
>- Reject invalid BAR configurations when VIRTIO Shared Memory
>  Regions are in use by vhost-user-test-device
>
>This patch series implements dynamic fd-backed memory mapping support
>for vhost-user backends, enabling backends to dynamically request memory
>mappings and unmappings during runtime through the new
>VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.
>
>This feature benefits various VIRTIO devices that require dynamic shared
>memory management, including virtiofs (for DAX mappings), virtio-gpu
>(for resource sharing), and the recently standardized virtio-media.
>
>The implementation introduces a QOM-based architecture for managing
>shared memory lifecycle:
>
>- VirtioSharedMemoryMapping: an intermediate object that manages
>  individual memory mappings by acting as generic container for regions
>  declared in any vhost-user device type
>- Dynamic Mapping: backends can request mappings via SHMEM_MAP messages,
>  with the frontend creating MemoryRegions from the provided file
>  descriptors and adding them as subregions
>
>When a SHMEM_MAP request is received, the frontend:
>1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
>2. Maps the provided fd with memory_region_init_ram_from_fd()
>3. Creates a MemoryRegion backed by the mapped memory
>4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region
>
>The QOM reference counting ensures automatic cleanup when mappings are
>removed or the device is destroyed.
>
>This patch also includes:
>- VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
>  vhost-user devices to query shared memory configuration from backends
>  at device initialization, enabling the generic vhost-user-device
>  frontend to work with any backend regardless of specific shared memory
>  requirements.
>
>The implementation has been tested with rust-vmm based backends.
>
>Albert Esteve (7):
>  vhost-user: Add VirtIO Shared Memory map request
>  vhost_user.rst: Align VhostUserMsg excerpt members
>  vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
>  vhost_user: Add frontend get_shmem_config command
>  vhost_user.rst: Add GET_SHMEM_CONFIG message
>  qmp: add shmem feature map
>  vhost-user-device: Add shared memory BAR
>
> docs/interop/vhost-user.rst               | 104 +++++++++
> hw/virtio/vhost-user-base.c               |  46 +++-
> hw/virtio/vhost-user-test-device-pci.c    |  38 ++-
> hw/virtio/vhost-user.c                    | 269 ++++++++++++++++++++++
> hw/virtio/virtio-qmp.c                    |   3 +
> hw/virtio/virtio.c                        | 201 ++++++++++++++++
> include/hw/virtio/vhost-backend.h         |  10 +
> include/hw/virtio/vhost-user.h            |   1 +
> include/hw/virtio/virtio.h                | 137 +++++++++++
> include/system/memory.h                   |  13 ++
> subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> subprojects/libvhost-user/libvhost-user.h |  54 +++++
> 12 files changed, 941 insertions(+), 5 deletions(-)
>
>-- 
>2.52.0
>


