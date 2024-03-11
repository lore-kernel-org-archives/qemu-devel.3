Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEE4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlrm-0003mb-LA; Mon, 11 Mar 2024 16:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rjlrl-0003lX-3R
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rjlrj-0001AY-Fh
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710187398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrc+ywjzx8W82pG7aXFdiic/bcqjSaD3pmcfHYkuBQk=;
 b=aXyDJbniXDgczYPRw15friI3/KB87i+mLif+GDBE+WMRTz3gNvQjEgcqnxjoT3TYVH3R31
 oKqoTrANyuFkB+mq96x8I8xFIvy5I7oyqUVxXj0nwAFdKzN/BEfF13nQDLADAf0OhtDbXD
 r2nf459diFKbzl7y2W77l2bAPX/pP9Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-idgP9D26PTqoe7lKx0SqoQ-1; Mon, 11 Mar 2024 16:03:17 -0400
X-MC-Unique: idgP9D26PTqoe7lKx0SqoQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d2e4ea0f63so26575501fa.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187396; x=1710792196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrc+ywjzx8W82pG7aXFdiic/bcqjSaD3pmcfHYkuBQk=;
 b=ZEwr/+Gc+wmTDonsTsmQn+e+lSYzvKn45IweRHUhfi75V4gv/CajHaaKOhCbapw+C3
 vhibkce189cTTDZioScT5NsIQmgYc7U8rnrQGkDQotd3kqjL82ZnEJ26IVEHlNpdJD4O
 ZruVNGRVSljxxSwceejE4BLW9QqHS4lAeAz+LFTfck5p7qZD1wTCS4dZk1mCFDGU8fcV
 oIhTH7hMz1MOdEDykIjok26feInUkdiIoXqXH4+CtzC7bw97FhieMKSrKG6O0I5ItArJ
 IDjMH5WK/byZZz7EdLB6ZtQvj4VF0KWshcM4XvlpRTzUmMxMJlgR5aWwBPTcbGbrJY3h
 N4fQ==
X-Gm-Message-State: AOJu0YxpJ4ctlnCw0h7EVJSNFDyMsixAPz2hKkGfURVch8hIKY4AYGTv
 GHUx8KFTVaVuiteF1Ice4THjAb8XcBG7dlrea5WLOsiLOqjH7o3LBzK7dIwoN82C39ABb90p5Rd
 Qyi3MDrcbD1/4XPi2fnqAgRnd7HYmj7wiZWTXQRNv4+LVEWn5eB3PEX47ahLqaxhplBay0tgtuX
 Dl5CRW0QYi8U7k6ofePYg6rcqnF9c=
X-Received: by 2002:a2e:a702:0:b0:2d2:f148:29fc with SMTP id
 s2-20020a2ea702000000b002d2f14829fcmr3957686lje.12.1710187395754; 
 Mon, 11 Mar 2024 13:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7hMUQlZSjTWxcGeU/SJjPRy5CFkiuUp7V/tQWMEY/vF5C22xIc/6dxq0E36SqS0AyVwppQKU/+pPGBJ4sUsk=
X-Received: by 2002:a2e:a702:0:b0:2d2:f148:29fc with SMTP id
 s2-20020a2ea702000000b002d2f14829fcmr3957665lje.12.1710187395344; Mon, 11 Mar
 2024 13:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240214151701.29906-1-david@redhat.com>
 <CAMXpfWv2Pdn8ThtQFQgL0BUX4KHWvaZixaAc1C6STL06Gqx6og@mail.gmail.com>
In-Reply-To: <CAMXpfWv2Pdn8ThtQFQgL0BUX4KHWvaZixaAc1C6STL06Gqx6og@mail.gmail.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 11 Mar 2024 21:03:04 +0100
Message-ID: <CAMXpfWv5usTd__TahmDiFjMMkf-CeaVDSWEv3OLoDnRsz4k-uw@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Mon, Mar 11, 2024 at 9:00=E2=80=AFPM Mario Casquero <mcasquer@redhat.com=
> wrote:
>
> This series has been successfully tested by QE. Start the
> qemu-storage-daemon in the background with a rhel 9.5 image and
> vhost-user-blk. After that, boot up a VM with virtio-mem and
> vhost-user-blk-pci. Check with the HMP command 'info mtree' that
> virtio-mem is making use of multiple memslots.
>
>
> On Wed, Feb 14, 2024 at 4:18=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > This series adds support for more memslots (509) to libvhost-user, to
> > make it fully compatible with virtio-mem that uses up to 256 memslots
> > accross all memory devices in "dynamic-memslot" mode (more details
> > in patch #2).
> >
> > With that in place, this series optimizes and extends memory region
> > handling in libvhost-user:
> > * Heavily deduplicate and clean up the memory region handling code
> > * Speeds up GPA->VA translation with many memslots using binary search
> > * Optimize mmap_offset handling to use it as fd_offset for mmap()
> > * Avoid ring remapping when adding a single memory region
> > * Avoid dumping all guest memory, possibly allocating memory in sparse
> >   memory mappings when the process crashes
> >
> > I'm being very careful to not break some weird corner case that modern
> > QEMU might no longer trigger, but older one could have triggered or som=
e
> > other frontend might trigger.
> >
> > The only thing where I am not careful is to forbid memory regions that
> > overlap in GPA space: it doesn't make any sense.
> >
> > With this series, virtio-mem (with dynamic-memslots=3Don) +
> > qemu-storage-daemon works flawlessly and as expected in my tests.
> >
> > v1 -> v2:
> > * Drop "libvhost-user: Fix msg_region->userspace_addr computation"
> >  -> Not actually required
> > * "libvhost-user: Factor out adding a memory region"
> >  -> Make debug output more consistent (add missing ":")
> > * "libvhost-user: Use most of mmap_offset as fd_offset"
> >  -> get_fd_pagesize -> get_fd_hugepagesize; remove getpagesize()
> >  -> "mmap_offset:" to "old mmap_offset:" in debug message
> >  -> "adj mmap_offset:" to "new mmap_offset:" in debug message
> >  -> Use "(unsigned int)fs.f_type"; the man page of fstatfs() calls out
> >     that the type of f_type can vary depending on the architecture.
> >     "unsigned int" is sufficient here.
> >  -> Updated patch description
> > * Added RBs+ACKs
> > * Did a Gitlab CI run, seems to be happy reagrding libvhost-user
> >
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Cc: Germano Veit Michel <germano@redhat.com>
> > Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> >
> > David Hildenbrand (14):
> >   libvhost-user: Dynamically allocate memory for memory slots
> >   libvhost-user: Bump up VHOST_USER_MAX_RAM_SLOTS to 509
> >   libvhost-user: Factor out removing all mem regions
> >   libvhost-user: Merge vu_set_mem_table_exec_postcopy() into
> >     vu_set_mem_table_exec()
> >   libvhost-user: Factor out adding a memory region
> >   libvhost-user: No need to check for NULL when unmapping
> >   libvhost-user: Don't zero out memory for memory regions
> >   libvhost-user: Don't search for duplicates when removing memory
> >     regions
> >   libvhost-user: Factor out search for memory region by GPA and simplif=
y
> >   libvhost-user: Speedup gpa_to_mem_region() and vu_gpa_to_va()
> >   libvhost-user: Use most of mmap_offset as fd_offset
> >   libvhost-user: Factor out vq usability check
> >   libvhost-user: Dynamically remap rings after (temporarily?) removing
> >     memory regions
> >   libvhost-user: Mark mmap'ed region memory as MADV_DONTDUMP
> >
> >  subprojects/libvhost-user/libvhost-user.c | 595 ++++++++++++----------
> >  subprojects/libvhost-user/libvhost-user.h |  10 +-
> >  2 files changed, 334 insertions(+), 271 deletions(-)
> >
> > --
> > 2.43.0
> >
> >


