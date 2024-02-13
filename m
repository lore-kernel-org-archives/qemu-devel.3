Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31549C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 17:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZweu-0001Oq-58; Tue, 13 Feb 2024 12:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZwes-0001OP-Rl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZwer-0008Lt-6p
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707845603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ME70Nk+IqjXYYr3bXdGJtxTF3A5ePMFRadnYj5L3+zo=;
 b=YMvS5/FVUTdAv0kFF0YsW3E2jcV5slCzJBjmnWI2TtH6mHA2bkaPav17V4xCqOeE7QBonk
 tiRbyxleTtEbXsnNpfUS0fpucOoCPL3ESySnT6F+Zo2sPVpRgBTpahXivrZvr7eOC5QquQ
 RHpubOiJr05atFggD8VYzxzLhmPuo5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-yr31DFKcMymh5Kkit4_SuA-1; Tue, 13 Feb 2024 12:33:21 -0500
X-MC-Unique: yr31DFKcMymh5Kkit4_SuA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-410d0660929so13345285e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 09:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707845600; x=1708450400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ME70Nk+IqjXYYr3bXdGJtxTF3A5ePMFRadnYj5L3+zo=;
 b=r+YsS50uE9Vyxewa1hoYtr9bVpLLW3UBlWYP8TPuzh2dug/EKqRPSJB/J33VUUcfjs
 Iah/rPa5/oy+xXOqRnJNbW1n1xu1tFZG9gT+hQixESvqwxfixpBm8QgmEfFC+MmG3NGV
 tgB9IQ7ADvYQu6ai5dnAWLAsW1HEhaO8i5wDeIuMNUL6kvW7RLDHdFi6K1Hiw9JO5OH1
 LXpqVQ0CpqToERFfZ42ttRh9LHdwZE3azYihEfdpIuzdzaVmf3V6AAvadicrbNZj/VSK
 x60t0REL+cq9rW61rU6g9JfUSH7pRtPXhRROa34/ky1G376FzcwaDspEzydC2VNt2TG0
 5Iqw==
X-Gm-Message-State: AOJu0YyyIuJ3dN09a8wRfSafw6UsNUYG/LtFNa5bb0+jAjyr+d7+KS3Q
 Af0UEmWFfCswiP1dDKdQbilz0BfipFT9XoutaBqgS1n/8SQ/olMsQkmBVY43jFa1Qkf2+yQy5sf
 yF0k/PQxda/hfgH9PpPep+xGCdfq7IXZdr8X+nC9yeBYyVKGetB+G
X-Received: by 2002:a05:600c:6017:b0:411:d889:ed81 with SMTP id
 az23-20020a05600c601700b00411d889ed81mr389512wmb.5.1707845600004; 
 Tue, 13 Feb 2024 09:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs8U2MwAwSPS2D4BLaYy5nqm4qJVJ9t70kALA87tbYSoS41XYICRV0df7iThggJisovO8ukg==
X-Received: by 2002:a05:600c:6017:b0:411:d889:ed81 with SMTP id
 az23-20020a05600c601700b00411d889ed81mr389502wmb.5.1707845599801; 
 Tue, 13 Feb 2024 09:33:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUsXD5ZsV+N510f5toBDNe+Na3IOz4/zlr1oTsz17I/xd+R3nurpthKyUZyEsPuggoxR1pRgoC4W6v2ZpxSgm9ON6efIgy12896bcYKJ/VC+oggfQO/yI4vxehOP6ZVkcKPm+rapb4TJTK3FvgwAqndkwk5uHyZ/DAFQjw+A/Rl+QWHxK0jpvC2Ug5c8AFNTRMCjNJc8M4z+TzwGpsGyA==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 dx9-20020a05600c63c900b0040d5ae2906esm12230078wmb.30.2024.02.13.09.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 09:33:19 -0800 (PST)
Date: Tue, 13 Feb 2024 12:33:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v1 00/15] libvhost-user: support more memslots and
 cleanup memslot handling code
Message-ID: <20240213123259-mutt-send-email-mst@kernel.org>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 10:53:17PM +0100, David Hildenbrand wrote:
> This series adds support for more memslots (509) to libvhost-user, to
> make it fully compatible with virtio-mem that uses up to 256 memslots
> accross all memory devices in "dynamic-memslot" mode (more details
> in patch #3).


Breaks build on some systems. E.g.
https://gitlab.com/mstredhat/qemu/-/jobs/6163591599



> One simple fix upfront.
> 
> With that in place, this series optimizes and extens memory region
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
> With this series, virtio-mem (with dynamic-memslots=on) +
> qemu-storage-daemon works flawlessly and as expected in my tests.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Germano Veit Michel <germano@redhat.com>
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> 
> David Hildenbrand (15):
>   libvhost-user: Fix msg_region->userspace_addr computation
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
>  subprojects/libvhost-user/libvhost-user.c | 593 ++++++++++++----------
>  subprojects/libvhost-user/libvhost-user.h |  10 +-
>  2 files changed, 332 insertions(+), 271 deletions(-)
> 
> -- 
> 2.43.0


