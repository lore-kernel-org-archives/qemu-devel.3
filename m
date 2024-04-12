Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56506C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDxI-00026B-3V; Fri, 12 Apr 2024 06:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rvDxG-000262-Tw
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rvDxF-00046K-2m
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712916979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=GF2LAK9FxTXXrJJDZzQCyrGusn4l5a1RhyRLg3WAxU4=;
 b=cOfRPRdRbLKZAzNnBg7abS9e3qqFHhMPSBX47Oem9ik/IXFvt7snGa8QWLWplW8ZWtl/+L
 tdBH7iItdf1SfXmK1TFGtGjfDkR+gbADspyifbvcUHV/JMrDvfrNuHEloHVe+o7R4QoA4b
 pu7LcBSMMfcOfweXnoim7vwBORx/m1Y=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-6nOeLWu9Mwq6Dwe6TPvqSA-1; Fri, 12 Apr 2024 06:16:17 -0400
X-MC-Unique: 6nOeLWu9Mwq6Dwe6TPvqSA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dd1395fd1bfso1373439276.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916977; x=1713521777;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GF2LAK9FxTXXrJJDZzQCyrGusn4l5a1RhyRLg3WAxU4=;
 b=vjtD9uH0ba4cRXnvq4r3ldI/mPTIIu8g8B2Eo/CvIgr0bqu4syWo/2uFche489uGmG
 DWhqv3rQjPiVg0nBKCXcAS9cWl5r4ui47wekUDoInZGzvTMMZRS2jN3VHDbFy0nCWimS
 1XTghtQvvZadQ0bzLgqgk6xeHpPIrADzAvINIVFdEtOG41KYCWheYvxp1Y0sNaQqBDDb
 ADh9xU7Oyft36t3cjDS4Obsi9y46UrWtmgpCjJfltoPSPmDrBFO+gfyFo62Llfu+qMWM
 Y51xzROU34iVlnJPWTuwqsDl2Gt4UUENu5XX5QRh5m3S74hvMiyPk4iSc0ovp15J/xGC
 rYFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLauQjg8Z10NmGLufMaSj0bj8qHugazPoZ1hfCeWOcrlaiAeLkgDJGMMxwrSjoRLr28UQ/ChWcxJ2K7nj5JimooblF134=
X-Gm-Message-State: AOJu0YzIEuuYnWzijUDnONg9MXSwIeQMzje5Zk6ezPclxbqWVQ0TgKJE
 eGMPwXFXEeGCpojUVuLygOOmJ/NQJEcqx4TyfOZcYX5yQ4QkreXHMgUIXAHR690ntY0OVLNQk3p
 PRfMSMb4snx4k4mtn/L+g5xs1BfIwdxSV5Ws3OsbrjEh3c/8LyHP/aAjpWPLkQDQOXSxJbe3dtC
 vwuVhavWzmDOiA1AZDvh4gbyX7/b8=
X-Received: by 2002:a25:6881:0:b0:dc7:42b8:2561 with SMTP id
 d123-20020a256881000000b00dc742b82561mr507179ybc.34.1712916976951; 
 Fri, 12 Apr 2024 03:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQKcsDx2+1wOASqw5VWWTEMZseMcF9BHmqmYLbloG7pu56pLsdaIe/lo+pfm294mOZRRP8iSFXRHa2PF/ydnA=
X-Received: by 2002:a25:6881:0:b0:dc7:42b8:2561 with SMTP id
 d123-20020a256881000000b00dc742b82561mr507163ybc.34.1712916976611; Fri, 12
 Apr 2024 03:16:16 -0700 (PDT)
MIME-Version: 1.0
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 12 Apr 2024 12:15:40 +0200
Message-ID: <CAJaqyWcL7DRSj7bPK=MfAZoTw-GgZCKr4on3U0Q8jmRd2OZSPg@mail.gmail.com>
Subject: Discrepancy between mmap call on DPDK/libvduse and rust vm-memory
 crate
To: Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 German Maglione <gmaglione@redhat.com>, Hanna Czenczek <hczenczek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

Hi!

I'm building a bridge to expose vhost-user devices through VDUSE. The
code is still immature but I'm able to forward packets using
dpdk-l2fwd through VDUSE to VM. I'm now developing exposing virtiofsd,
but I've hit an error I'd like to discuss.

VDUSE devices can get all the memory regions the driver is using by
VDUSE_IOTLB_GET_FD ioctl. It returns a file descriptor with a memory
region associated that can be mapped with mmap, and an information
entry about the map it contains:
* Start and end addresses from the driver POV
* Offset within the mmaped region of these start and end
* Device permissions over that region.

[start=0xc3000][last=0xe7fff][offset=0xc3000][perm=1]

Now when I try to map it, it is impossible for the userspace device to
call mmap with any offset different than 0. So the "straightforward"
mmap with size = entry.last-entry.start and offset = entry.offset does
not work. I don't know if this is a limitation of Linux or VDUSE.

Checking QEMU's
subprojects/libvduse/libvduse.c:vduse_iova_add_region() I see it
handles the offset by adding it up to the size, instead of using it
directly as a parameter in the mmap:

void *mmap_addr = mmap(0, size + offset, prot, MAP_SHARED, fd, 0);

I can replicate it on the bridge for sure.

Now I send the VhostUserMemoryRegion to the vhost-user application.
The struct has these members:
struct VhostUserMemoryRegion {
    uint64_t guest_phys_addr;
    uint64_t memory_size;
    uint64_t userspace_addr;
    uint64_t mmap_offset;
};

So I can send the offset to the vhost-user device. I can check that
dpdk-l2fwd uses the same trick of adding offset to the size of the
mapping region [1], at
lib/vhost/vhost_user.c:vhost_user_mmap_region():

mmap_size = region->size + mmap_offset;
mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
            MAP_SHARED | populate, region->fd, 0);

So mmap is called with offset == 0 and everybody is happy.

Now I'm moving to virtiofsd, and vm-memory crate in particular. And it
performs the mmap without the size += offset trick, at
MmapRegionBuilder<B>:build() [2].

I can try to apply the offset + size trick in my bridge but I don't
think it is the right solution. At first glance, the right solution is
to mmap with the offset as vm-memory crate do. But having libvduse and
DPDK apply the same trick sounds to me like it is a known limitation /
workaround I don't know about. What is the history of this? Can VDUSE
problem (if any) be solved? Am I missing something?

Thanks!

[1] https://github.com/DPDK/dpdk/blob/e2e546ab5bf5e024986ccb5310ab43982f3bb40c/lib/vhost/vhost_user.c#L1305
[2] https://github.com/rust-vmm/vm-memory/blob/main/src/mmap_unix.rs#L128


