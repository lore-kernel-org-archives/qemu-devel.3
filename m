Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF24C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfE12-0003Dz-Od; Thu, 02 Jul 2026 05:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wfE10-0003Da-SH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:47:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wfE0y-0002XB-Rk
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:47:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493b779003fso7933035e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782985643; x=1783590443; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fKC1D1OsYzhuu2T5DhZS+ayo24Iqaetkzw1OMf9jA3M=;
 b=LxGYbcBVX+uZNj+YOFMF7NS8nWo4QmrCm2KQd8cmD7qHlYBN/MxRw3mXhIi6dx8J0r
 ODWOrQ8niw2JrbxJOX1Ay+1pRM+K+Dqn4mNe6z/0j7olyz3cf45kQDAyL6/wqc+b7cgm
 5CQdAVM+cPjHvxl3HQjxOrScXKjgQGHLwKXX1e7Xn+EgT5GY5YdI0fcXMJFDOZldRkta
 J3/LRmXy0TOyVLsxw5qHYhIKlxKSyiSZhPL1Ye17itvRu1wDDvM437kPBhllYrw7d2ma
 rmwemiF5d1JVsWLsErRxLQi243SSF8PAPuki8gxwKA1e6I8Ij1F91yjoVwVzetaCLaUW
 z8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985643; x=1783590443;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKC1D1OsYzhuu2T5DhZS+ayo24Iqaetkzw1OMf9jA3M=;
 b=RBlQUPD1d/peHHi5d9kVHyRmMT09v+sz4LTbadu7jjVCfs5f/5U3wdor2fHJDwXJQP
 oItdO3ztOLptPeMynqMSRzuZ890sM1o4wQDCcVTJe/TYPgubOG5574IqqAu1f4nskN7B
 3y5WjDZM03DcvTgIxzaYEzzklOjSvdu81fvb6chJrwCa9c8UzMeTidZhcJSXClYVtgT2
 ZygAo2m/NycpXOp46mKSVBXkUr99wNcGcKDuwYFIW5m25Ofubfd2tIBF4yQdQ7QUYWfj
 Ty52p6UJolUOVbX5V1K4KlreYaadLecLEiQuZPT/lrI92uIfp+nQlQXoQWucj152d0fq
 PYJQ==
X-Gm-Message-State: AOJu0YymIXx1IMSIcIaAFSRq5TPTykIaOVSTFaqT/+ZlyqG9jL7DHrga
 rceFmux+HZZrqTF0r2nSLAByFd2wbJcoD2jmwKLy3xLMRrkVCemS5z88
X-Gm-Gg: AfdE7ckJO+I6L3IZNqlj6VLQBoieux2xkvC86tXmrP/U2cFou6r6lc6Rcis2OMa2ju5
 xXpUbROJltFpb0WDPIOTSPOFpx4GpnxUUT9m0OJPEt2llO+HJ+yF3Kj6L9h7jP87BmzOAw6Z6TQ
 9XG3MswcNmyQyqr4IZ6bx7/T/K7qo7pfI9pOE/s0hHZt6TbkKZRTsDpjz6h3xUQ4Rkz2+oJDr3u
 V+dS7iKuVNy41tpUeuD8mOipGs85zygi10h2Y/c9V2JPq4PidzQVIzZuylPIFoaYge8qjvea3yU
 86WSV+LEhxaS5cSSVmbgl4l9/3VgxQk7xasbyHNceajyHP1xoi4VJkgTJcgXuZXNfLTcZ2A4fc7
 nlXpIW76i/GhLxzGoUBeRS9I/f4PeaQzwpARMHC6KMVnd/WRX0iri3TWRW90cv87rMIQOykpPuQ
 L1e1hPdPuC6M/idg7R1ZzqAQzIa7JW0VFpQGSmGWcIxA==
X-Received: by 2002:a05:600c:8b30:b0:493:bdaf:83a7 with SMTP id
 5b1f17b1804b1-493c83a5b75mr4322745e9.28.1782985642521; 
 Thu, 02 Jul 2026 02:47:22 -0700 (PDT)
Received: from RTRKN1313-LIN.domain.local ([89.216.37.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a15sm7539152f8f.14.2026.07.02.02.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:47:22 -0700 (PDT)
From: Dusan Stojkovic <stojkovicdusan555@gmail.com>
Subject: [PATCH RFC v3 0/2] vhost-user: support Xen foreign memory mappings
Date: Thu, 02 Jul 2026 11:46:11 +0200
Message-Id: <20260702-vhost-xen-foreign-mapping-v3-0-2b8ef913382b@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMzRmoC/43NTQqDMBAF4KtI1p2SRJNoV4VCD9Bt6cKfUUMxk
 USCRbx7Q1auSpdvHvO9jXh0Gj25ZBtxGLTX1sSQnzLSjrUZEHQXM+GUSypZCWG0foEVDfTWoR4
 MTPU8azNAR3nelqJpFJUk/s8Oe70m+0ke9xt5xeOo/WLdJ+0Flqo/6MCAguolrSUvWKXY1S3g3
 ufWTkkN/CDx6pfEo8QqLGQpUAkljtK+719pMItFEQEAAA==
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>, 
 Nikola Jelic <Nikola.Jelic@rt-rk.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=stojkovicdusan555@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series lets QEMU, when running as a Xen device model, drive
vhost-user backends that map guest memory through the Xen foreign
mapping interface, implementing the front-end side of
VHOST_USER_PROTOCOL_F_XEN_MMAP. The protocol extension itself is
already documented in docs/interop/vhost-user.rst (feature bit 17,
extended memory region description) and implemented by rust-vmm's
vhost / vm-memory crates and the vhost-device backends built on them.
 
The problem this solves: under Xen the guest's RAM is not allocated by
QEMU and is not backed by a file descriptor. memory_region_get_fd()
returns -1, so vhost_section() filters out every RAM section, the vhost
memory listener registers no regions, and starting any vhost-user
device fails with "Failed initializing vhost-user memory map". With
F_XEN_MMAP the backend maps guest memory itself.

The protocol requires one file descriptor per region in SET_MEM_TABLE.
Guest RAM under Xen has no backing fd, so the front-end opens
/dev/xen/privcmd per region purely to satisfy that requirement; the
backend derives the mapping from guest_phys_addr + domid and never
reads the fd. Each fd is closed once the message has been sent.

This patchset was rebased onto the new vhost_phys_vring_addr infrastructure 
and extends vhost_user_gpa_addresses() so that negotiated
F_XEN_MMAP (bit 17), not F_GPA_ADDRESSES (bit 21, which the backend doesn't 
advertise), drives GPA addressing for both rings and userspace_addr.

The two patches:
  1/2  accept the Xen RAM section in vhost_section()
  2/2  negotiate F_XEN_MMAP and build SET_MEM_TABLE from the extended
       region layout. 
Testing:
Tested on Xen/ARM64 with a DomU using virtio-mmio transports created
by the xenpvh machine, running vhost-device-sound (rust-vmm, built
with the "xen" feature) as the backend in dom0. The device negotiates,
receives the memory table and ring addresses, and the guest's
virtio-snd driver probes and operates.

Non-Xen / x86 KVM: vhost-user-snd backed by
vhost-device-sound (null backend) on a q35/KVM guest. The device
negotiates, the guest virtio-snd driver probes and runs the control and
PCM paths, and the SET_MEM_TABLE and vring-address traffic is identical
to a build without this series confirming the
non-Xen path is unchanged.

The control message exchange between the frontend and backend was
tracked using sockdump as was described in:
Making VirtIO sing - implementing virtio-sound in rust-vmm project
|-> at FOSDEM 2024

Setup:
The main part of the xl config this enables:
virtio = [
 'backend=0,type=virtio,device,transport=mmio,grant_usage=false'
]

device_model_args = [
 ...
 '-chardev', 'socket,id=snd_chardev,path=/tmp/snd.sock',
 '-device', 'vhost-user-snd,chardev=snd_chardev,id=snd,iommu_platform=true',
 ...
]

Xen 4.22-unstable was used with:
 -enable-IOREQ_SERVER 
 -enable-EXPERT

An extra patch was added to xen-tools.
Namely, xen tools will request a pv device drive type for ARM64 but 
qemu expects pvh. This is a known issue:
github.com/Xilinx/xen/commit/5f669949c9ffdb1947cb47038956b5fb8eeb072a

Qemu master was used configured with the following flags:
    --target-list=aarch64-softmmu \
    --cross-prefix=aarch64-linux-gnu- \
    --enable-xen \
    --enable-vhost-user \
    --extra-cflags="-I$XEN-TOOLS/usr/local/include" \
    --extra-ldflags="-L$XEN-TOOLS/usr/local/lib -Wl,
        -rpath-link,$XEN-TOOLS/usr/local/lib" \

Likewise for x86:
    --target-list=aarch64-softmmu \
    --enable-slirp \
    --enable-xen \
    --enable-vhost-user \
    --enable-virtfs \

Linux version 6.11.7 was used with extra configuration flags:
* For enabling Xen Dom0/DomU support
* For enabling virtio (mmio, snd, etc.)
* For enabling sockdump features (BPF, IKHEADERS, KPROBE, etc.)
* Extra debug flags (DEBUG_FS, etc.)

vhost-device commit-id:
    c3bb658ef4fe20a2f264dbbbbc6fa19f1c08c0c5
    
    Was used built with:
    --features alsa-backend,xen

Importantly in vhost-device-scmi/src/vhu_scmi.rs:

// QUEUE_SIZE must be apparently at least 1024 for MMIO.
// There is probably a maximum size per descriptor defined in the kernel.
const QUEUE_SIZE: usize = 1024;

A similar change was made to make mmio work in vhost-user-sound device,
bumping QUEUE_SIZE to 1024.

Without this frontend and backend will fail to negotiate queue size.

Scope and known limitations:
* Foreign mappings only. Grant mappings are not supported: vhost's
  section tracking derives a host pointer for each region, which is
  invalid for the grant pseudo-region, and per-access grant mapping
  needs a different region description (GRANT | no-advance-map). Patch
  1 rejects the xen.grants region explicitly. Setting grant_usage=true
  does not change the qemu<->backend vhost-user exchange.
 
* VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS is suppressed under Xen:
  the ADD/REM_MEM_REG path has not been converted to the extended
  region format, and Xen guests currently expose a single RAM region,
  so SET_MEM_TABLE is sufficient. Multiple RAM regions are not yet
  exercised. Postcopy is refused.

* Spec vs reference implementation: docs/interop/vhost-user.rst
  describes the "can not be mapped in advance" xen-mmap flag as Bit 8
  (value 0x100), whereas rust-vmm's vm-memory uses 0x8 (bit 3,
  MmapXenFlags::NO_ADVANCE_MAP). This series uses neither, but the
  discrepancy probably wants resolving in the spec. Viresh, which is
  intended -- bit position 8 or value 0x8?

* userspace_addr is carried unchanged in the region descriptor; under
  Xen it does not correspond to a mapping and backends do not
  interpret it. An alternative would be to define it (e.g. mirror
  guest_phys_addr).

Open questions:
- userspace_addr semantics under Xen: leave it unchanged, or define it?
- Multi-region support: convert ADD/REM_MEM_REG to the extended layout
  rather than suppressing CONFIGURE_MEM_SLOTS?
- Grant-mapping support: worth pursuing, and what region-description
  shape do backends expect?
- Updating vhost-device-sound to reflect the mmio support.

References:
- vhost-user spec, F_XEN_MMAP / extended memory region / xen mmap flags:
  docs/interop/vhost-user.rst
- rust-vmm vm-memory MmapXenFlags (FOREIGN=0x1, GRANT=0x2,
  NO_ADVANCE_MAP=0x8): src/mmap/xen.rs
- Making VirtIO sing - implementing virtio-sound in rust-vmm project
|-> at FOSDEM 2024

Signed-off-by: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>
Signed-off-by: Nikola Jelic <Nikola.Jelic@rt-rk.com>
---
Changes in v3:
- Rebased onto current master
- Fixed semantic error in vhost_section comment
- Link to v2: https://lore.kernel.org/qemu-devel/20260629-vhost-xen-foreign-mapping-v2-0-19e4685e7575@rt-rk.com

Changes in v2:
- Rebased onto current master
- Cover letter: removed a rust-vmm hunk which made the git am
  on Patchview fail. The reference is now mentioned in a sentance.
- Link to v1:
  https://lore.kernel.org/qemu-devel/20260618-vhost-xen-foreign-mapping-v1-0-7f60a6241971@rt-rk.com

---
Dusan Stojkovic (2):
      vhost: accept Xen guest RAM sections for vhost-user
      vhost-user: implement VHOST_USER_PROTOCOL_F_XEN_MMAP

 hw/virtio/trace-events         |   2 +
 hw/virtio/vhost-user.c         | 120 +++++++++++++++++++++++++++++++++++++++--
 hw/virtio/vhost.c              |  18 +++++++
 hw/xen/xen_stubs.c             |   5 ++
 include/hw/virtio/vhost-user.h |   2 +-
 5 files changed, 143 insertions(+), 4 deletions(-)
---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260618-vhost-xen-foreign-mapping-d023c85bb706

Best regards,
-- 
Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>


