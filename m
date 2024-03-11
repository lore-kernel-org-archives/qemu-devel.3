Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7616C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlqa-000250-IP; Mon, 11 Mar 2024 16:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rjlqW-0001zB-4E
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rjlqT-00015K-Vp
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710187320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kS5y5yApovlta2J1vXw2ITU+KivOgFdnNOOazYCNpDs=;
 b=BxpTTQkfNTtlMIj04Yk9b6Qw2xulLGVWDXjwE5wmWlryG8pKhGtLUpW305gZOzp7eV6tUt
 13j2wP4pgjzfT+iaWI2FEAWiDm/K4g049IBMtiLw+Tu+gCXiLpxHqFi9gBC6ec6BbHo5Zf
 vI9UV4fIuoPk9acR/Uaa9VZroh0CWYo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-QvoWazcGMoOde9c9Ns_Dcg-1; Mon, 11 Mar 2024 16:00:40 -0400
X-MC-Unique: QvoWazcGMoOde9c9Ns_Dcg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d33e6f838dso39442821fa.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187238; x=1710792038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kS5y5yApovlta2J1vXw2ITU+KivOgFdnNOOazYCNpDs=;
 b=sH147BY62wqqkWI9mWo9i1RfQ42ZBIulTLrEWYnAYEdH8qkHWFrWQNR/Ddmy14/GAX
 bfs1XMfyb4/B3lmZqm2eRFKsVsP0p+xz+qOhze6tAbsEO3bfcjMYUhLaZvbX7LLtqoz8
 xZNOR7z8GTB2Q31kIKh+cevui0qKFUE1wbunV0K++waKHh9JX9iYbNFntoRLRMKxTvuf
 qkS6GBE+HvEEybNdjBbPiSQS4AWnv0xPS5sikFLrhmbPhh4TpWQRHQofc5SdmwarlznH
 2WYNzPJNuTBKHi3v1twUbT8iZipnYUzijDcg1QmppZKmxrTvtRHJ6X16cutXU+of61bw
 hvkA==
X-Gm-Message-State: AOJu0Yy1/YgBpDbpe8wMwBpZbNz0CquNaWpVrhm6KCqU3QQlL6mgMx2/
 GccGlTLJQtFGBUKegSExEISTkTFp7XlARvsV3n81ElJ0rXwzmKEGykGyYQwztK+IUhwaZdoXEnG
 9VebS2mS/Asn0D5nFVA+O7eujcN/I+97BN9L1YOjPA1zxn4QuqQhnwGW0lLdTj5LozNSY3DJmY1
 d9FATxFSfLldRVr22Oxf6lng1dzOU=
X-Received: by 2002:a2e:9ed9:0:b0:2d3:3305:c37d with SMTP id
 h25-20020a2e9ed9000000b002d33305c37dmr1029885ljk.2.1710187238704; 
 Mon, 11 Mar 2024 13:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ3r09nKglKeLTlzmLwp36e+C/X5D6MYWz8Aesy9/yR2AJss3XQOAvUs3qYQLQ2BRQk2JJjkHIOMMRrlmAW8s=
X-Received: by 2002:a2e:9ed9:0:b0:2d3:3305:c37d with SMTP id
 h25-20020a2e9ed9000000b002d33305c37dmr1029870ljk.2.1710187238349; Mon, 11 Mar
 2024 13:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240214151701.29906-1-david@redhat.com>
In-Reply-To: <20240214151701.29906-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 11 Mar 2024 21:00:27 +0100
Message-ID: <CAMXpfWv2Pdn8ThtQFQgL0BUX4KHWvaZixaAc1C6STL06Gqx6og@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] libvhost-user: support more memslots and cleanup
 memslot handling code
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

This series has been successfully tested by QE. Start the
qemu-storage-daemon in the background with a rhel 9.5 image and
vhost-user-blk. After that, boot up a VM with virtio-mem and
vhost-user-blk-pci. Check with the HMP command 'info mtree' that
virtio-mem is making use of multiple memslots.


On Wed, Feb 14, 2024 at 4:18=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> This series adds support for more memslots (509) to libvhost-user, to
> make it fully compatible with virtio-mem that uses up to 256 memslots
> accross all memory devices in "dynamic-memslot" mode (more details
> in patch #2).
>
> With that in place, this series optimizes and extends memory region
> handling in libvhost-user:
> * Heavily deduplicate and clean up the memory region handling code
> * Speeds up GPA->VA translation with many memslots using binary search
> * Optimize mmap_offset handling to use it as fd_offset for mmap()
> * Avoid ring remapping when adding a single memory region
> * Avoid dumping all guest memory, possibly allocating memory in sparse
>   memory mappings when the process crashes
>
> I'm being very careful to not break some weird corner case that modern
> QEMU might no longer trigger, but older one could have triggered or some
> other frontend might trigger.
>
> The only thing where I am not careful is to forbid memory regions that
> overlap in GPA space: it doesn't make any sense.
>
> With this series, virtio-mem (with dynamic-memslots=3Don) +
> qemu-storage-daemon works flawlessly and as expected in my tests.
>
> v1 -> v2:
> * Drop "libvhost-user: Fix msg_region->userspace_addr computation"
>  -> Not actually required
> * "libvhost-user: Factor out adding a memory region"
>  -> Make debug output more consistent (add missing ":")
> * "libvhost-user: Use most of mmap_offset as fd_offset"
>  -> get_fd_pagesize -> get_fd_hugepagesize; remove getpagesize()
>  -> "mmap_offset:" to "old mmap_offset:" in debug message
>  -> "adj mmap_offset:" to "new mmap_offset:" in debug message
>  -> Use "(unsigned int)fs.f_type"; the man page of fstatfs() calls out
>     that the type of f_type can vary depending on the architecture.
>     "unsigned int" is sufficient here.
>  -> Updated patch description
> * Added RBs+ACKs
> * Did a Gitlab CI run, seems to be happy reagrding libvhost-user
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Germano Veit Michel <germano@redhat.com>
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
>
> David Hildenbrand (14):
>   libvhost-user: Dynamically allocate memory for memory slots
>   libvhost-user: Bump up VHOST_USER_MAX_RAM_SLOTS to 509
>   libvhost-user: Factor out removing all mem regions
>   libvhost-user: Merge vu_set_mem_table_exec_postcopy() into
>     vu_set_mem_table_exec()
>   libvhost-user: Factor out adding a memory region
>   libvhost-user: No need to check for NULL when unmapping
>   libvhost-user: Don't zero out memory for memory regions
>   libvhost-user: Don't search for duplicates when removing memory
>     regions
>   libvhost-user: Factor out search for memory region by GPA and simplify
>   libvhost-user: Speedup gpa_to_mem_region() and vu_gpa_to_va()
>   libvhost-user: Use most of mmap_offset as fd_offset
>   libvhost-user: Factor out vq usability check
>   libvhost-user: Dynamically remap rings after (temporarily?) removing
>     memory regions
>   libvhost-user: Mark mmap'ed region memory as MADV_DONTDUMP
>
>  subprojects/libvhost-user/libvhost-user.c | 595 ++++++++++++----------
>  subprojects/libvhost-user/libvhost-user.h |  10 +-
>  2 files changed, 334 insertions(+), 271 deletions(-)
>
> --
> 2.43.0
>
>


