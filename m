Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF06CEEF316
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 08:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy42S-0004l3-8T; Thu, 05 Mar 2026 03:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vy42Q-0004kv-3Y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vy42N-0002fL-Tl
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772699185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dj36ZMr5ZLO42XHYvhlamh6r3wfQc2CH6Z0U//mRUOc=;
 b=WHSv7NgHdtpocDlcb45gvMC3SfOeEVYpePwaqzq2pxfakHejDQuT78FT6HPWBJcl1UqosF
 KxfXTuDw/KouJ4MqEPNaRwcRmfVfHaCIzPxPsYVJ1xxPmDYix099jdrZz/paPB4nPvje0/
 9OHqtEjl++VDMls8ipnp8eBuYBBFDp8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-WOC0yioLMFO7p2hcnBAEbg-1; Thu, 05 Mar 2026 03:26:24 -0500
X-MC-Unique: WOC0yioLMFO7p2hcnBAEbg-1
X-Mimecast-MFC-AGG-ID: WOC0yioLMFO7p2hcnBAEbg_1772699183
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837246211bso96935395e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772699183; x=1773303983; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj36ZMr5ZLO42XHYvhlamh6r3wfQc2CH6Z0U//mRUOc=;
 b=gNg5u1Qrkp+r2a2zID+WArCEBUwW4hFCBqMNF6ccIAQoQdpogG4g3wnUlAYtfc8XVo
 YBIp3rqTqh/qmtZaYMbQMTk8p1lvoHIDp+h+pX8stU79Xm/4klpKHEWPsilgHViE7FOb
 7k8EtkfCx9YyH0iGf1ZQMOqcJBuBYxpneZX0o1Z/hxKus5L5bO//o1SrUKuI4AHwoIBg
 QVN08bsDIpxARcKJsS0wN2UtFNiO/m1jaJVtreIxkQjL8bxclN0k3j5PHB3CSSGq0nJc
 ECkbusYAxntcAGaxjaGJHZYJ65pMys3AsJ8QDJOyCGuj/iXx+6yDQaedQvMlIhUAMTHX
 cp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772699183; x=1773303983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dj36ZMr5ZLO42XHYvhlamh6r3wfQc2CH6Z0U//mRUOc=;
 b=VQvxW0H1PtAJD3ZoyEqo+VSs6Po5aUgSWaEEKsvyMaXjpHxwjX/CMWh/iAsv9h3J9Q
 VbPFz69Nfmz0ZCNY0SPXrimwy4eJEl2dJvVRSulq7BiPTQgeSi2hb/Afmjh9AOu8e1UX
 cSXphiaeLod4F0NOanNzk0N8VtwDub415Md4cxrQbWOlo8UbAjphbu2paOt3ZW5tbv2/
 oorndJ3ZYpHE9xVXtutLCIZDG9T0DKrvcvB+vDTSbXL1VCH7om1MS2kS2wrfNXLH8qVe
 PynNRMr7MgGbo3EFKAM80Q+sGLFj8oeSNRKU/i3AjaMiiVFNDj9qFt3tgzQPeXBqRXge
 86Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcVsf+rZAknyOtL07yALF+1A8FA0tzuq7Tc6G0omt4QkcBote0B89PBAh9syTzSW8ShJzKx6j4hdX3@nongnu.org
X-Gm-Message-State: AOJu0Yz1E/fgNhMJhnMsEkXUzWzfvirn/t/821HLJ9Jq63V7gT7iRerJ
 EhhmTZHiGzGw7lMkfXZc7ByDav3604eqtb1ln1GM4H3Fr67RSqOhPjE0TJky7Vunpk1D7y5MkqW
 qDSsyR5aPSiHywJp+mIuhNWlFwMGWiulKE4yoScr+HeF9cnQLcPfo+Rvr
X-Gm-Gg: ATEYQzyo1qWqPyq90EqJBd2D50EUqrr7lhluGmofp5EUA4FplH8/rgtIYIeZ9ppBwVo
 fJAI5lkDwfSCq0ggPR6w02StQQKQwcxKi6xZ+uuXV6dB2TVbOgsT+mo5fgMJqK4eyTVwfMqgCzy
 vcpP3szq7Xo8/vndj8xZjRznvHnQlgSfi1+fUAY5b0uWH1WOxKe+J9mtYjzSkDyKvwEnMfuDFik
 q/D+Zlx2No3vuh/T4W0FnkQ7Lxm4ubxbDxxBjJlfsoWHax+rQVpt9+E6tWsbocfIx4xqpwhlmx1
 0Q5b7UeYD9vCsSajIBtezGlBVKgVtCqY4tNnAt0lucnGvpcY8NAw/0Kc2U4ZP9+jQ2GhXEqTgRb
 A2kaVlcO3mWvi+dD/mRp90xdHWwH2ogf2FvnFOrC2lKdt4w==
X-Received: by 2002:a05:600c:609a:b0:483:a8e9:201b with SMTP id
 5b1f17b1804b1-485197ecfdcmr88133365e9.0.1772699182689; 
 Thu, 05 Mar 2026 00:26:22 -0800 (PST)
X-Received: by 2002:a05:600c:609a:b0:483:a8e9:201b with SMTP id
 5b1f17b1804b1-485197ecfdcmr88132935e9.0.1772699182218; 
 Thu, 05 Mar 2026 00:26:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851faf3938sm25340335e9.13.2026.03.05.00.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 00:26:21 -0800 (PST)
Date: Thu, 5 Mar 2026 03:26:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 manos.pitsidianakis@linaro.org, slp@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com, stevensd@chromium.org,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com,
 Peter Xu <peterx@redhat.com>, hi@alyssa.is,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, dbassey@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v14 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20260305032601-mutt-send-email-mst@kernel.org>
References: <20260304165223.2166175-1-aesteve@redhat.com>
 <aak5QkV_RxUEnV_f@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aak5QkV_RxUEnV_f@sgarzare-redhat>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 05, 2026 at 09:06:20AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 04, 2026 at 05:52:16PM +0100, Albert Esteve wrote:
> > Hi all,
> 
> Thanks!
> 
> This is now fully reviewed, Michael can we queue it?
> 
> Thanks,
> Stefano


yes, I tagged it already.

> > 
> > v13->v14
> > - Switched F_SHMEM id to 21 to avoid collision after rebasing
> > - Fixed all occurrences of shmem->mr.size to memory_region_size()
> > - Other small fixes following reviews from previous version
> > v12->v13
> > - SMEM_UNMAP spec update to explicitly state the use of
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK for replies
> > - Removed confusing remark for 0-sized regions in
> >  GET_SHMEM_CONFIG
> > v11->v12
> > - Refined VIRTIO Shared Memory Region configuration mem size
> >  spec description
> > - Removed unused name in vhost-user-base's vub_device_realize to
> >  avoid build error
> > - Initialize shmem in vhost_user_backend_handle_shmem_unmap
> >  to avoid compiler being confused
> > - Added stub for memory_region_init_ram_from_fd in memory.h
> >  for windows builds
> > - Use memory_region_size for shmem_region handlers instead
> >  of accessing size member directly in shmem mrs
> > v10->v11
> > - Rebase to grab commit fde5930cc37175cfcd0f03a089e26f4458a52311
> >  and explicitly unset reply_ack on the SHMEM_MAP/UNMAP msg.
> > - Mention mapping cleanup on device reset in the spec.
> > 
> > This patch series implements dynamic fd-backed memory mapping support
> > for vhost-user backends, enabling backends to dynamically request memory
> > mappings and unmappings during runtime through the new
> > VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.
> > 
> > This feature benefits various VIRTIO devices that require dynamic shared
> > memory management, including virtiofs (for DAX mappings), virtio-gpu
> > (for resource sharing), and the recently standardized virtio-media.
> > 
> > The implementation introduces a QOM-based architecture for managing
> > shared memory lifecycle:
> > 
> > - VirtioSharedMemoryMapping: an intermediate object that manages
> >  individual memory mappings by acting as generic container for regions
> >  declared in any vhost-user device type
> > - Dynamic Mapping: backends can request mappings via SHMEM_MAP messages,
> >  with the frontend creating MemoryRegions from the provided file
> >  descriptors and adding them as subregions
> > 
> > When a SHMEM_MAP request is received, the frontend:
> > 1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
> > 2. Maps the provided fd with memory_region_init_ram_from_fd()
> > 3. Creates a MemoryRegion backed by the mapped memory
> > 4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region
> > 
> > The QOM reference counting ensures automatic cleanup when mappings are
> > removed or the device is destroyed.
> > 
> > This patch also includes:
> > - VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
> >  vhost-user devices to query shared memory configuration from backends
> >  at device initialization, enabling the generic vhost-user-device
> >  frontend to work with any backend regardless of specific shared memory
> >  requirements.
> > 
> > The implementation has been tested with rust-vmm based backends.
> > 
> > Albert Esteve (7):
> >  vhost-user: Add VirtIO Shared Memory map request
> >  vhost_user.rst: Align VhostUserMsg excerpt members
> >  vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
> >  vhost_user: Add frontend get_shmem_config command
> >  vhost_user.rst: Add GET_SHMEM_CONFIG message
> >  qmp: add shmem feature map
> >  vhost-user-device: Add shared memory BAR
> > 
> > docs/interop/vhost-user.rst               | 104 ++++++++
> > hw/virtio/vhost-user-base.c               |  46 +++-
> > hw/virtio/vhost-user-test-device-pci.c    |  42 +++-
> > hw/virtio/vhost-user.c                    | 274 ++++++++++++++++++++++
> > hw/virtio/virtio-qmp.c                    |   3 +
> > hw/virtio/virtio.c                        | 201 ++++++++++++++++
> > include/hw/virtio/vhost-backend.h         |  10 +
> > include/hw/virtio/vhost-user.h            |   1 +
> > include/hw/virtio/virtio.h                | 136 +++++++++++
> > include/system/memory.h                   |   2 +-
> > subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> > subprojects/libvhost-user/libvhost-user.h |  54 +++++
> > system/memory.c                           |  14 ++
> > 13 files changed, 951 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.52.0
> > 


