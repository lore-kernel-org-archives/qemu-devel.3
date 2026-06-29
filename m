Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACC7C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9Xf-0006uL-CP; Mon, 29 Jun 2026 06:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1we9Xd-0006tL-8n
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:48:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1we9Xb-0006VS-7w
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:48:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49395888c7bso24668195e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782730116; x=1783334916; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rHdJNyHlU9wGBSmmTt70KC8pzxHHCNTKtY01TPe9p90=;
 b=dLF6G5+hgmGcJYsplOzQrLnOtlyBtgo9b6VKx58rcl/DZbOza/njVdccXBuZw3wVK/
 iZ4iJ2OhqJYcO6ktTO++o3A+Vy7OAf5vog2FAcdd9T0hs/kIIQZwxpY7CeM9QBLnC4Bv
 h4fbMbC/9H2r8ajIi3swSX3hB2Lv0C4s3ZWFFwqGVb/l2FSNgwONjQ/ruJ2A38mOnIJy
 3SirbxZZQ44sxxO2cQW5QDJuX2XSl57PfR0UqU3jnDhTu9BXHjmbyFP1VC6H/gb0HVfl
 gfZIYyUwid1IcuZ1QmIiKlR5UYDay7j3p9ObQaelee26ercJfFi8qxPjKtY3dY6K3s0O
 83vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782730116; x=1783334916;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHdJNyHlU9wGBSmmTt70KC8pzxHHCNTKtY01TPe9p90=;
 b=k2LbzyhvIYUqj3ReBk8Z2QRm2eOfO1CVP6mbl8RkOQG8ZiWgtbLvmAFWtWkhbWUkBT
 EtOHyWBhmnEc0zDss539mRSEyrSYnRAsb4w3D3o08vVGehtOaTD/rFcr8DkTUM29Gku3
 kFNVh7ZlMD/WxZ+4kd4Fu3fHEYkAjjH2lgk9oNrkD11TAejvPAL7zie6Q2LOPas6g9WZ
 Rs8U/CAoNqmeLnH29WnE4PrJ6IJq2YwzfihzCOqYw9fxfRYhbc4vio74Od/CyYI+GQae
 Wb0GYNOAhmWTwVZg/csDCc5DLcJ3Weqen+LDJcyF4eZ74wISNgYE+TyF+1qCAm44vhMN
 cPUw==
X-Gm-Message-State: AOJu0Yz51XzVY70LJKHNu++jRke3I3EOKKZrLjLVwdjdsndpEmJJnfZC
 RzxqUQBdnbRn0TVZ50eHjGXlMYZEWnwUV25LDsn6uWIc5QtvucBYKnIi
X-Gm-Gg: AfdE7cnCm6kqxo4R2X5VLzHGceayMkW8rvZE6Gl/mggNkCHmoCRRS9/C3XZ2OixEzUZ
 tJTpjRdUBPSk0OGsjLe6UofWth4Xi8mHvKppo709ovj0I+9ZS7wK6f9DGPsU1/vzrKBq8nxvRiw
 Q8io9MDYl9BS4Nwk8L/7N6TfvEtt7hB+e6p8XI/vaFkkpkQkZ+hQPg7H64jJzoX+O+3gVeAlb3b
 BbMWAoAM6Bze3RoOEwujeV6TXnREI7/K5OIDLQ4fsmpQgNEAwQmSUzZNLo+Bj/vXTHb4cWzyg9k
 pBBIl0B7Xc2YVu7p7/gikkrtH4ZbG1zoRt9nqDOmrhxRmQItW/vd0WyllCFiumh1aIJ83RU9+NE
 t0YtDcwxxb3Zv9N31naXP1xObSNwcvSUDVyq5kUUNNLqsIL0kNY1UjqOx31l6k4j6kyjKtgIkNO
 EQ7Km47fWsRUoqQcBUvEx7JTlYJBnMlc6/B/Oz+bFW0XUie5aYlCqppTFaVpHMoKSzcIQmqa94f
 JCUI15POQ==
X-Received: by 2002:a05:600d:8497:20b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-492668414d1mr182360655e9.11.1782730116125; 
 Mon, 29 Jun 2026 03:48:36 -0700 (PDT)
Received: from RTRKN1313-LIN.domain.local
 (cable-89-216-248-190.dynamic.sbb.rs. [89.216.248.190])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46cf775a4f0sm39691675f8f.17.2026.06.29.03.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 03:48:35 -0700 (PDT)
From: Dusan Stojkovic <stojkovicdusan555@gmail.com>
Subject: [PATCH RFC v2 0/2] vhost-user: support Xen foreign memory mappings
Date: Mon, 29 Jun 2026 12:46:24 +0200
Message-Id: <20260629-vhost-xen-foreign-mapping-v2-0-19e4685e7575@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABNQmoC/42NTQrCMBCFr1Jm7UgSNa2uBMEDuJUu+jNtB2lSJ
 iVUSu9u6Alcfu/xvrdCIGEKcMtWEIoc2LsE5pBBM1SuJ+Q2MRhlrLK6wDj4MONCDjsvxL3DsZo
 mdj22ypya4lLXubKQ9pNQx8vufsPr+YAyhQOH2ct3/4t6r/5QR40K886qypqzvub6LjPK59j4E
 cpt236SPSRNxwAAAA==
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=stojkovicdusan555@gmail.com; helo=mail-wm1-x32e.google.com
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
base-commit: 20553466cc47af6a8c95f665b601fce3c852e503
change-id: 20260618-vhost-xen-foreign-mapping-d023c85bb706

Best regards,
-- 
Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>


