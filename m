Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33733C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 09:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvvkX-0000HW-LI; Sun, 14 Apr 2024 05:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rvvkW-0000HG-40
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 05:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rvvkU-00081H-7R
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 05:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713085324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V53M1T8aCbpqEyKzezKwhv2d67ecnlX5qp0FiENgsF8=;
 b=d19abpiUdLIKpuyqEF8jZVOC9Eibk43V4e+NmpPTGvKqgcBHnJ1PnubyDbTyGqC5OlA3Bg
 5qi5w9Z+2IHTr7DTSOcPil+7sXnIUfZ1DGyBx4TgqZZpywJV2PinsUYN7o7WrxDyWvCB7N
 d/5Nh18BfyFZdyMsa5mxo3a9utVMxko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-in7Lvk9GMeKJOUUwXa0V1w-1; Sun, 14 Apr 2024 05:02:02 -0400
X-MC-Unique: in7Lvk9GMeKJOUUwXa0V1w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3479b511725so298077f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 02:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713085321; x=1713690121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V53M1T8aCbpqEyKzezKwhv2d67ecnlX5qp0FiENgsF8=;
 b=qhehgo1HPWIAYOrgKmWEgPOt86GSDn5RfKa6q0HEYBkHAL4SUlmzXxc1yFRLeVfsWM
 BC3c3t8BWPosnFl+uSMj7a9kWo8+7vikl3MXgQ7unh3/4dzYZ5L3gQkZAUvqMEiQNN4W
 XtNTJf2ONaNK2k+1Dmoj7LANR1+MPrnQBhz3Yx4pVk+d1WGspgvSguSo3LEvggQwAMj3
 UnSEGiYaGrYVQj2HciuyTRjuKa7VYUdxfDpdG/CdSRaCWBVs6csavB0J+EmINLMSV7+j
 dDC34LyLLkJ1rB64V6jFq03V1s11BrcROGlmmc3KRA28IAhO3dTXmtQpAvCQW/8FoV89
 mhPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXllGx1f+qmPvdIgpS+6oar8Hs5IOsRe6j0lPIejdxnNklyy4K8wh39xoKBITPuXlG7ToQ7zB78apEegzfVHNOAPie7M7g=
X-Gm-Message-State: AOJu0Yy2N8UdZir3EsbB3B6PZ7KksFNNCfaXXFYQjxD1q7lUcnTsj7m7
 vWsPao8fPHG3ZhoKAy04KbYMkZIXJkXwp0qvHlV5DBr33SwZD4SchEBEMTIRFZ6jbBdoxJ0L1xn
 rYrXe+LGusV9T3/Sx5QJGFBk4WroROJOC66zLY6t6dU9gDaVwMULz
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d809 with SMTP id
 h12-20020a05600c314c00b00417e4add809mr4697784wmo.25.1713085321335; 
 Sun, 14 Apr 2024 02:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHX2tYVdPi2ksBJcWat13o8+JHI6gNCZUxwWoKAYpj3Z1PUGmwzel0rP8xZ+ZiIjY72YDOeA==
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d809 with SMTP id
 h12-20020a05600c314c00b00417e4add809mr4697765wmo.25.1713085320811; 
 Sun, 14 Apr 2024 02:02:00 -0700 (PDT)
Received: from redhat.com ([31.187.78.68]) by smtp.gmail.com with ESMTPSA id
 x13-20020a5d60cd000000b0033e7b05edf3sm8606084wrt.44.2024.04.14.02.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 02:02:00 -0700 (PDT)
Date: Sun, 14 Apr 2024 05:01:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, German Maglione <gmaglione@redhat.com>,
 Hanna Czenczek <hczenczek@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: Re: Discrepancy between mmap call on DPDK/libvduse and rust
 vm-memory crate
Message-ID: <20240414044353-mutt-send-email-mst@kernel.org>
References: <CAJaqyWcL7DRSj7bPK=MfAZoTw-GgZCKr4on3U0Q8jmRd2OZSPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWcL7DRSj7bPK=MfAZoTw-GgZCKr4on3U0Q8jmRd2OZSPg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.283,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 12, 2024 at 12:15:40PM +0200, Eugenio Perez Martin wrote:
> Hi!
> 
> I'm building a bridge to expose vhost-user devices through VDUSE. The
> code is still immature but I'm able to forward packets using
> dpdk-l2fwd through VDUSE to VM. I'm now developing exposing virtiofsd,
> but I've hit an error I'd like to discuss.
> 
> VDUSE devices can get all the memory regions the driver is using by
> VDUSE_IOTLB_GET_FD ioctl. It returns a file descriptor with a memory
> region associated that can be mapped with mmap, and an information
> entry about the map it contains:
> * Start and end addresses from the driver POV
> * Offset within the mmaped region of these start and end
> * Device permissions over that region.
> 
> [start=0xc3000][last=0xe7fff][offset=0xc3000][perm=1]
> 
> Now when I try to map it, it is impossible for the userspace device to
> call mmap with any offset different than 0.

How exactly did you allocate memory? hugetlbfs?

> So the "straightforward"
> mmap with size = entry.last-entry.start and offset = entry.offset does
> not work. I don't know if this is a limitation of Linux or VDUSE.
> 
> Checking QEMU's
> subprojects/libvduse/libvduse.c:vduse_iova_add_region() I see it
> handles the offset by adding it up to the size, instead of using it
> directly as a parameter in the mmap:
> 
> void *mmap_addr = mmap(0, size + offset, prot, MAP_SHARED, fd, 0);


CC Xie Yongji who wrote this code, too.


> I can replicate it on the bridge for sure.
> 
> Now I send the VhostUserMemoryRegion to the vhost-user application.
> The struct has these members:
> struct VhostUserMemoryRegion {
>     uint64_t guest_phys_addr;
>     uint64_t memory_size;
>     uint64_t userspace_addr;
>     uint64_t mmap_offset;
> };
> 
> So I can send the offset to the vhost-user device. I can check that
> dpdk-l2fwd uses the same trick of adding offset to the size of the
> mapping region [1], at
> lib/vhost/vhost_user.c:vhost_user_mmap_region():
> 
> mmap_size = region->size + mmap_offset;
> mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>             MAP_SHARED | populate, region->fd, 0);
> 
> So mmap is called with offset == 0 and everybody is happy.
> 
> Now I'm moving to virtiofsd, and vm-memory crate in particular. And it
> performs the mmap without the size += offset trick, at
> MmapRegionBuilder<B>:build() [2].
> 
> I can try to apply the offset + size trick in my bridge but I don't
> think it is the right solution. At first glance, the right solution is
> to mmap with the offset as vm-memory crate do. But having libvduse and
> DPDK apply the same trick sounds to me like it is a known limitation /
> workaround I don't know about. What is the history of this? Can VDUSE
> problem (if any) be solved? Am I missing something?
> 
> Thanks!
> 
> [1] https://github.com/DPDK/dpdk/blob/e2e546ab5bf5e024986ccb5310ab43982f3bb40c/lib/vhost/vhost_user.c#L1305
> [2] https://github.com/rust-vmm/vm-memory/blob/main/src/mmap_unix.rs#L128


