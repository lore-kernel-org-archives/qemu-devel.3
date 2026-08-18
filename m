Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E9BC5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwEXT-0001yX-3i; Tue, 18 Aug 2026 03:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wwEXR-0001yE-Hq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 03:47:13 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wwEXO-0001HM-Le
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 03:47:13 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c2022323c37so538155966b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 00:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787039229; cv=none;
 d=google.com; s=arc-20260327;
 b=Q00nyzniESiqv8nLOFf1bHWy3uWmVTg9i+OdnDLSV/t4wKL0sHFpDcF76nXc5h8HTC
 ySJiFRP/A8jJYtJYBqhfnhWuZ91n96yKY+caIOJD0//CCH5O7uf8hXJvpret+QmF8DJT
 n4JMt1Yw59MP1GnbXJ8y6p3+m1ji64ZIZEN4JJYm+xDg/JGRU5Q+Agu9CbWkDTbJ7gWJ
 0Xd6wznSi06finAu/Aqur+tE7KY7cZze2x/4aD9xtqXWc+q8Nw0chGtGnEd9oyMJUAdh
 YuG53RSvB0W1YSgKAp8cfWaLKlLnzgJHNvXAYY736vqEvyZdpX/0/kmXmO+/mq+dCpxW
 OimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8zpGVmQCF4Ej1R71DGStEiTG8p9UGbCUyASXHvOD9PY=;
 fh=TzmyyC0TqgvW7ag4CFkRUX68PWX7qQGduA3z0xBSlo0=;
 b=VnKzLVB6aT7BUcQmSxEU1WH1vvI+LeerLm4oiKowbkjc0s7XfTnvQiHNH/2Na1ALRe
 ISY6Dt0uZf+7M0kqEbAwrrKpCkrCbAO25q+4LaZgN4Md3dDKxHLffvNTuVn2GtCGpDDo
 K1GesxaLf395mEuFh5jmzIZJRFrXc9TKwSkmpo1aB5RFCCJFqjrCL5UkpLQyPc8VTEos
 kKm4lwFQoF68AtpAENYs4ppk4mtPkkpvIQRckAU5KKYM5n0m2RXWYk+cn5gDTD7eust6
 sKeIixSpgGkJQpfbUxo1eElfQimt6vF3awIGzdrWQHalpajhhbs5EqP5M6spm9HoC6iR
 IJ8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787039229; x=1787644029; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8zpGVmQCF4Ej1R71DGStEiTG8p9UGbCUyASXHvOD9PY=;
 b=Pw5wHBC0RIyXMB1y94lS6cpQkLe5JTk1S63YajEroGLBgWRwx63HypBnXTKty/rAW7
 KncRGoFI1JOVHcvaK39uehET2toHBhuRIEotMRxiTZd2mKtdKsPPIxFP+BGHMjy67yG2
 3LIvsvdLgHSMybvxFVHCmIJmR4wdPqcP1J4Mn5aKUBDa7v8aa7QOSo4PzcPJ74QQ1zJC
 oM0q9rsum4Pie5CfNdz5Y1CZSyAVXIJrULgYKp1cCW+NRGwlnAmGymXHBGseFdLlNuFi
 XrQXCoxQt6kEd4BaNulMswa4DzRfEK70hCRhlNASwAd8evjOXSXWs4lkCUE6dm5SVTGW
 ucBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787039229; x=1787644029;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8zpGVmQCF4Ej1R71DGStEiTG8p9UGbCUyASXHvOD9PY=;
 b=UKCbRtxmsQjtGB7kBjR9++FkJSm+tN/Sr1Ym6U2Ep/xMix0rILm6uo4fvgjw1y53GO
 HKV8kaQes4kV+F9uaxFW9yD/V+J8IiNvTPwZ/jI5RpGMTwTLzOVOVqDRmNr+Nf1P6Gn6
 el8ve6gbMSaqnxarjpBKuUs1hwZOOWvwQYxacFyl9db+nTO4PSpojaaYfCOefLiUcg8A
 thjwA6P5HHxKcLsJ/GWqCc/EvprPOn5Bbks8T63hqFYo+xz+gaWwVaTBH71foQYTEQAf
 R84r9amYK79d60wbaIUgPUxpylYC6Soq+k5EojY8DH9+MG4vCalZbCB7+zcCbF/iWOX6
 yGNQ==
X-Gm-Message-State: AOJu0YzI3AA3RUBxv0jGu0VjW2e6V8LOqPY9MPaKl+CXSk8b4HMZdV4n
 hKVOs1iPixlWyfH5XgqFXf+HJEZkCcgRwPl+5kkFAaYPuf/LeBB+OlLlyETUbOsZeHJnSi69A6u
 cOvTaE0fY5HO42wVwEdhmoM1i2AoT+8sOLw==
X-Gm-Gg: AR+sD13Dp3RF5Bbg3q/aeceLGJCflKzFnsbb836uH4K0q+J12BmR9utX8AZqavuOiwq
 3WG8oBDP9Tqj1IZoj4ZTetyhaqYrcQSEt+0FYXL73/t1Xn1YCoONMLtJHmSBUMZ2MJuZzvSV0B3
 UqCe/9DWb0YAEMtmaE6sBNdJyoMTvluYR739bjGmKDImi1M2COzIe8zSBOIhUQGSGjK/h57vYR4
 XWILJvywcImgDTOEGuMiYxE/eeOB5CuZE7S54MZjh4YTR6fTE2ysBexojYmGn6ZcUouvjHo+JWc
 Aqw6OnDxgdmSLxhtn7a/ZeGmw4/ClOg5a0zDZ1kGuqNJsg==
X-Received: by 2002:a17:907:3e0a:b0:c19:473b:dc8f with SMTP id
 a640c23a62f3a-c2129a9a64bmr1559305066b.3.1787039228250; Tue, 18 Aug 2026
 00:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-vhost-xen-foreign-mapping-v3-0-2b8ef913382b@rt-rk.com>
In-Reply-To: <20260702-vhost-xen-foreign-mapping-v3-0-2b8ef913382b@rt-rk.com>
From: Dusan Stojkovic <stojkovicdusan555@gmail.com>
Date: Tue, 18 Aug 2026 09:46:55 +0200
X-Gm-Features: AcwNN1W7gU_jJa_iP4WQA_eZBPE7Cr-gPNRXOQzqoF4jm3hepZhRV2OF6Roqhp0
Message-ID: <CALPHYNQOLY1FBRE_=rKHSXRELBpinezpLWUb2cwuKY+ev64j2A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] vhost-user: support Xen foreign memory mappings
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>, 
 Nikola Jelic <Nikola.Jelic@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000664b2706594d7e05"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=stojkovicdusan555@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000664b2706594d7e05
Content-Type: text/plain; charset="UTF-8"

Ping for feedback.

On Thu, Jul 2, 2026, 11:47 AM Dusan Stojkovic <stojkovicdusan555@gmail.com>
wrote:

> This series lets QEMU, when running as a Xen device model, drive
> vhost-user backends that map guest memory through the Xen foreign
> mapping interface, implementing the front-end side of
> VHOST_USER_PROTOCOL_F_XEN_MMAP. The protocol extension itself is
> already documented in docs/interop/vhost-user.rst (feature bit 17,
> extended memory region description) and implemented by rust-vmm's
> vhost / vm-memory crates and the vhost-device backends built on them.
>
> The problem this solves: under Xen the guest's RAM is not allocated by
> QEMU and is not backed by a file descriptor. memory_region_get_fd()
> returns -1, so vhost_section() filters out every RAM section, the vhost
> memory listener registers no regions, and starting any vhost-user
> device fails with "Failed initializing vhost-user memory map". With
> F_XEN_MMAP the backend maps guest memory itself.
>
> The protocol requires one file descriptor per region in SET_MEM_TABLE.
> Guest RAM under Xen has no backing fd, so the front-end opens
> /dev/xen/privcmd per region purely to satisfy that requirement; the
> backend derives the mapping from guest_phys_addr + domid and never
> reads the fd. Each fd is closed once the message has been sent.
>
> This patchset was rebased onto the new vhost_phys_vring_addr
> infrastructure
> and extends vhost_user_gpa_addresses() so that negotiated
> F_XEN_MMAP (bit 17), not F_GPA_ADDRESSES (bit 21, which the backend
> doesn't
> advertise), drives GPA addressing for both rings and userspace_addr.
>
> The two patches:
>   1/2  accept the Xen RAM section in vhost_section()
>   2/2  negotiate F_XEN_MMAP and build SET_MEM_TABLE from the extended
>        region layout.
> Testing:
> Tested on Xen/ARM64 with a DomU using virtio-mmio transports created
> by the xenpvh machine, running vhost-device-sound (rust-vmm, built
> with the "xen" feature) as the backend in dom0. The device negotiates,
> receives the memory table and ring addresses, and the guest's
> virtio-snd driver probes and operates.
>
> Non-Xen / x86 KVM: vhost-user-snd backed by
> vhost-device-sound (null backend) on a q35/KVM guest. The device
> negotiates, the guest virtio-snd driver probes and runs the control and
> PCM paths, and the SET_MEM_TABLE and vring-address traffic is identical
> to a build without this series confirming the
> non-Xen path is unchanged.
>
> The control message exchange between the frontend and backend was
> tracked using sockdump as was described in:
> Making VirtIO sing - implementing virtio-sound in rust-vmm project
> |-> at FOSDEM 2024
>
> Setup:
> The main part of the xl config this enables:
> virtio = [
>  'backend=0,type=virtio,device,transport=mmio,grant_usage=false'
> ]
>
> device_model_args = [
>  ...
>  '-chardev', 'socket,id=snd_chardev,path=/tmp/snd.sock',
>  '-device',
> 'vhost-user-snd,chardev=snd_chardev,id=snd,iommu_platform=true',
>  ...
> ]
>
> Xen 4.22-unstable was used with:
>  -enable-IOREQ_SERVER
>  -enable-EXPERT
>
> An extra patch was added to xen-tools.
> Namely, xen tools will request a pv device drive type for ARM64 but
> qemu expects pvh. This is a known issue:
> github.com/Xilinx/xen/commit/5f669949c9ffdb1947cb47038956b5fb8eeb072a
>
> Qemu master was used configured with the following flags:
>     --target-list=aarch64-softmmu \
>     --cross-prefix=aarch64-linux-gnu- \
>     --enable-xen \
>     --enable-vhost-user \
>     --extra-cflags="-I$XEN-TOOLS/usr/local/include" \
>     --extra-ldflags="-L$XEN-TOOLS/usr/local/lib -Wl,
>         -rpath-link,$XEN-TOOLS/usr/local/lib" \
>
> Likewise for x86:
>     --target-list=aarch64-softmmu \
>     --enable-slirp \
>     --enable-xen \
>     --enable-vhost-user \
>     --enable-virtfs \
>
> Linux version 6.11.7 was used with extra configuration flags:
> * For enabling Xen Dom0/DomU support
> * For enabling virtio (mmio, snd, etc.)
> * For enabling sockdump features (BPF, IKHEADERS, KPROBE, etc.)
> * Extra debug flags (DEBUG_FS, etc.)
>
> vhost-device commit-id:
>     c3bb658ef4fe20a2f264dbbbbc6fa19f1c08c0c5
>
>     Was used built with:
>     --features alsa-backend,xen
>
> Importantly in vhost-device-scmi/src/vhu_scmi.rs:
>
> // QUEUE_SIZE must be apparently at least 1024 for MMIO.
> // There is probably a maximum size per descriptor defined in the kernel.
> const QUEUE_SIZE: usize = 1024;
>
> A similar change was made to make mmio work in vhost-user-sound device,
> bumping QUEUE_SIZE to 1024.
>
> Without this frontend and backend will fail to negotiate queue size.
>
> Scope and known limitations:
> * Foreign mappings only. Grant mappings are not supported: vhost's
>   section tracking derives a host pointer for each region, which is
>   invalid for the grant pseudo-region, and per-access grant mapping
>   needs a different region description (GRANT | no-advance-map). Patch
>   1 rejects the xen.grants region explicitly. Setting grant_usage=true
>   does not change the qemu<->backend vhost-user exchange.
>
> * VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS is suppressed under Xen:
>   the ADD/REM_MEM_REG path has not been converted to the extended
>   region format, and Xen guests currently expose a single RAM region,
>   so SET_MEM_TABLE is sufficient. Multiple RAM regions are not yet
>   exercised. Postcopy is refused.
>
> * Spec vs reference implementation: docs/interop/vhost-user.rst
>   describes the "can not be mapped in advance" xen-mmap flag as Bit 8
>   (value 0x100), whereas rust-vmm's vm-memory uses 0x8 (bit 3,
>   MmapXenFlags::NO_ADVANCE_MAP). This series uses neither, but the
>   discrepancy probably wants resolving in the spec. Viresh, which is
>   intended -- bit position 8 or value 0x8?
>
> * userspace_addr is carried unchanged in the region descriptor; under
>   Xen it does not correspond to a mapping and backends do not
>   interpret it. An alternative would be to define it (e.g. mirror
>   guest_phys_addr).
>
> Open questions:
> - userspace_addr semantics under Xen: leave it unchanged, or define it?
> - Multi-region support: convert ADD/REM_MEM_REG to the extended layout
>   rather than suppressing CONFIGURE_MEM_SLOTS?
> - Grant-mapping support: worth pursuing, and what region-description
>   shape do backends expect?
> - Updating vhost-device-sound to reflect the mmio support.
>
> References:
> - vhost-user spec, F_XEN_MMAP / extended memory region / xen mmap flags:
>   docs/interop/vhost-user.rst
> - rust-vmm vm-memory MmapXenFlags (FOREIGN=0x1, GRANT=0x2,
>   NO_ADVANCE_MAP=0x8): src/mmap/xen.rs
> - Making VirtIO sing - implementing virtio-sound in rust-vmm project
> |-> at FOSDEM 2024
>
> Signed-off-by: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>
> Signed-off-by: Nikola Jelic <Nikola.Jelic@rt-rk.com>
> ---
> Changes in v3:
> - Rebased onto current master
> - Fixed semantic error in vhost_section comment
> - Link to v2:
> https://lore.kernel.org/qemu-devel/20260629-vhost-xen-foreign-mapping-v2-0-19e4685e7575@rt-rk.com
>
> Changes in v2:
> - Rebased onto current master
> - Cover letter: removed a rust-vmm hunk which made the git am
>   on Patchview fail. The reference is now mentioned in a sentance.
> - Link to v1:
>
> https://lore.kernel.org/qemu-devel/20260618-vhost-xen-foreign-mapping-v1-0-7f60a6241971@rt-rk.com
>
> ---
> Dusan Stojkovic (2):
>       vhost: accept Xen guest RAM sections for vhost-user
>       vhost-user: implement VHOST_USER_PROTOCOL_F_XEN_MMAP
>
>  hw/virtio/trace-events         |   2 +
>  hw/virtio/vhost-user.c         | 120
> +++++++++++++++++++++++++++++++++++++++--
>  hw/virtio/vhost.c              |  18 +++++++
>  hw/xen/xen_stubs.c             |   5 ++
>  include/hw/virtio/vhost-user.h |   2 +-
>  5 files changed, 143 insertions(+), 4 deletions(-)
> ---
> base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
> change-id: 20260618-vhost-xen-foreign-mapping-d023c85bb706
>
> Best regards,
> --
> Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>
>
>

--000000000000664b2706594d7e05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping for feedback.</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 2, 20=
26, 11:47 AM Dusan Stojkovic &lt;<a href=3D"mailto:stojkovicdusan555@gmail.=
com">stojkovicdusan555@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">This series lets QEMU, when running as a Xen device model, dr=
ive<br>
vhost-user backends that map guest memory through the Xen foreign<br>
mapping interface, implementing the front-end side of<br>
VHOST_USER_PROTOCOL_F_XEN_MMAP. The protocol extension itself is<br>
already documented in docs/interop/vhost-user.rst (feature bit 17,<br>
extended memory region description) and implemented by rust-vmm&#39;s<br>
vhost / vm-memory crates and the vhost-device backends built on them.<br>
<br>
The problem this solves: under Xen the guest&#39;s RAM is not allocated by<=
br>
QEMU and is not backed by a file descriptor. memory_region_get_fd()<br>
returns -1, so vhost_section() filters out every RAM section, the vhost<br>
memory listener registers no regions, and starting any vhost-user<br>
device fails with &quot;Failed initializing vhost-user memory map&quot;. Wi=
th<br>
F_XEN_MMAP the backend maps guest memory itself.<br>
<br>
The protocol requires one file descriptor per region in SET_MEM_TABLE.<br>
Guest RAM under Xen has no backing fd, so the front-end opens<br>
/dev/xen/privcmd per region purely to satisfy that requirement; the<br>
backend derives the mapping from guest_phys_addr + domid and never<br>
reads the fd. Each fd is closed once the message has been sent.<br>
<br>
This patchset was rebased onto the new vhost_phys_vring_addr infrastructure=
 <br>
and extends vhost_user_gpa_addresses() so that negotiated<br>
F_XEN_MMAP (bit 17), not F_GPA_ADDRESSES (bit 21, which the backend doesn&#=
39;t <br>
advertise), drives GPA addressing for both rings and userspace_addr.<br>
<br>
The two patches:<br>
=C2=A0 1/2=C2=A0 accept the Xen RAM section in vhost_section()<br>
=C2=A0 2/2=C2=A0 negotiate F_XEN_MMAP and build SET_MEM_TABLE from the exte=
nded<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0region layout. <br>
Testing:<br>
Tested on Xen/ARM64 with a DomU using virtio-mmio transports created<br>
by the xenpvh machine, running vhost-device-sound (rust-vmm, built<br>
with the &quot;xen&quot; feature) as the backend in dom0. The device negoti=
ates,<br>
receives the memory table and ring addresses, and the guest&#39;s<br>
virtio-snd driver probes and operates.<br>
<br>
Non-Xen / x86 KVM: vhost-user-snd backed by<br>
vhost-device-sound (null backend) on a q35/KVM guest. The device<br>
negotiates, the guest virtio-snd driver probes and runs the control and<br>
PCM paths, and the SET_MEM_TABLE and vring-address traffic is identical<br>
to a build without this series confirming the<br>
non-Xen path is unchanged.<br>
<br>
The control message exchange between the frontend and backend was<br>
tracked using sockdump as was described in:<br>
Making VirtIO sing - implementing virtio-sound in rust-vmm project<br>
|-&gt; at FOSDEM 2024<br>
<br>
Setup:<br>
The main part of the xl config this enables:<br>
virtio =3D [<br>
=C2=A0&#39;backend=3D0,type=3Dvirtio,device,transport=3Dmmio,grant_usage=3D=
false&#39;<br>
]<br>
<br>
device_model_args =3D [<br>
=C2=A0...<br>
=C2=A0&#39;-chardev&#39;, &#39;socket,id=3Dsnd_chardev,path=3D/tmp/snd.sock=
&#39;,<br>
=C2=A0&#39;-device&#39;, &#39;vhost-user-snd,chardev=3Dsnd_chardev,id=3Dsnd=
,iommu_platform=3Dtrue&#39;,<br>
=C2=A0...<br>
]<br>
<br>
Xen 4.22-unstable was used with:<br>
=C2=A0-enable-IOREQ_SERVER <br>
=C2=A0-enable-EXPERT<br>
<br>
An extra patch was added to xen-tools.<br>
Namely, xen tools will request a pv device drive type for ARM64 but <br>
qemu expects pvh. This is a known issue:<br>
<a href=3D"http://github.com/Xilinx/xen/commit/5f669949c9ffdb1947cb47038956=
b5fb8eeb072a" rel=3D"noreferrer noreferrer" target=3D"_blank">github.com/Xi=
linx/xen/commit/5f669949c9ffdb1947cb47038956b5fb8eeb072a</a><br>
<br>
Qemu master was used configured with the following flags:<br>
=C2=A0 =C2=A0 --target-list=3Daarch64-softmmu \<br>
=C2=A0 =C2=A0 --cross-prefix=3Daarch64-linux-gnu- \<br>
=C2=A0 =C2=A0 --enable-xen \<br>
=C2=A0 =C2=A0 --enable-vhost-user \<br>
=C2=A0 =C2=A0 --extra-cflags=3D&quot;-I$XEN-TOOLS/usr/local/include&quot; \=
<br>
=C2=A0 =C2=A0 --extra-ldflags=3D&quot;-L$XEN-TOOLS/usr/local/lib -Wl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -rpath-link,$XEN-TOOLS/usr/local/lib&quot; \<br=
>
<br>
Likewise for x86:<br>
=C2=A0 =C2=A0 --target-list=3Daarch64-softmmu \<br>
=C2=A0 =C2=A0 --enable-slirp \<br>
=C2=A0 =C2=A0 --enable-xen \<br>
=C2=A0 =C2=A0 --enable-vhost-user \<br>
=C2=A0 =C2=A0 --enable-virtfs \<br>
<br>
Linux version 6.11.7 was used with extra configuration flags:<br>
* For enabling Xen Dom0/DomU support<br>
* For enabling virtio (mmio, snd, etc.)<br>
* For enabling sockdump features (BPF, IKHEADERS, KPROBE, etc.)<br>
* Extra debug flags (DEBUG_FS, etc.)<br>
<br>
vhost-device commit-id:<br>
=C2=A0 =C2=A0 c3bb658ef4fe20a2f264dbbbbc6fa19f1c08c0c5<br>
<br>
=C2=A0 =C2=A0 Was used built with:<br>
=C2=A0 =C2=A0 --features alsa-backend,xen<br>
<br>
Importantly in vhost-device-scmi/src/vhu_scmi.rs:<br>
<br>
// QUEUE_SIZE must be apparently at least 1024 for MMIO.<br>
// There is probably a maximum size per descriptor defined in the kernel.<b=
r>
const QUEUE_SIZE: usize =3D 1024;<br>
<br>
A similar change was made to make mmio work in vhost-user-sound device,<br>
bumping QUEUE_SIZE to 1024.<br>
<br>
Without this frontend and backend will fail to negotiate queue size.<br>
<br>
Scope and known limitations:<br>
* Foreign mappings only. Grant mappings are not supported: vhost&#39;s<br>
=C2=A0 section tracking derives a host pointer for each region, which is<br=
>
=C2=A0 invalid for the grant pseudo-region, and per-access grant mapping<br=
>
=C2=A0 needs a different region description (GRANT | no-advance-map). Patch=
<br>
=C2=A0 1 rejects the xen.grants region explicitly. Setting grant_usage=3Dtr=
ue<br>
=C2=A0 does not change the qemu&lt;-&gt;backend vhost-user exchange.<br>
<br>
* VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS is suppressed under Xen:<br>
=C2=A0 the ADD/REM_MEM_REG path has not been converted to the extended<br>
=C2=A0 region format, and Xen guests currently expose a single RAM region,<=
br>
=C2=A0 so SET_MEM_TABLE is sufficient. Multiple RAM regions are not yet<br>
=C2=A0 exercised. Postcopy is refused.<br>
<br>
* Spec vs reference implementation: docs/interop/vhost-user.rst<br>
=C2=A0 describes the &quot;can not be mapped in advance&quot; xen-mmap flag=
 as Bit 8<br>
=C2=A0 (value 0x100), whereas rust-vmm&#39;s vm-memory uses 0x8 (bit 3,<br>
=C2=A0 MmapXenFlags::NO_ADVANCE_MAP). This series uses neither, but the<br>
=C2=A0 discrepancy probably wants resolving in the spec. Viresh, which is<b=
r>
=C2=A0 intended -- bit position 8 or value 0x8?<br>
<br>
* userspace_addr is carried unchanged in the region descriptor; under<br>
=C2=A0 Xen it does not correspond to a mapping and backends do not<br>
=C2=A0 interpret it. An alternative would be to define it (e.g. mirror<br>
=C2=A0 guest_phys_addr).<br>
<br>
Open questions:<br>
- userspace_addr semantics under Xen: leave it unchanged, or define it?<br>
- Multi-region support: convert ADD/REM_MEM_REG to the extended layout<br>
=C2=A0 rather than suppressing CONFIGURE_MEM_SLOTS?<br>
- Grant-mapping support: worth pursuing, and what region-description<br>
=C2=A0 shape do backends expect?<br>
- Updating vhost-device-sound to reflect the mmio support.<br>
<br>
References:<br>
- vhost-user spec, F_XEN_MMAP / extended memory region / xen mmap flags:<br=
>
=C2=A0 docs/interop/vhost-user.rst<br>
- rust-vmm vm-memory MmapXenFlags (FOREIGN=3D0x1, GRANT=3D0x2,<br>
=C2=A0 NO_ADVANCE_MAP=3D0x8): src/mmap/xen.rs<br>
- Making VirtIO sing - implementing virtio-sound in rust-vmm project<br>
|-&gt; at FOSDEM 2024<br>
<br>
Signed-off-by: Dusan Stojkovic &lt;<a href=3D"mailto:Dusan.Stojkovic@rt-rk.=
com" target=3D"_blank" rel=3D"noreferrer">Dusan.Stojkovic@rt-rk.com</a>&gt;=
<br>
Signed-off-by: Nikola Jelic &lt;<a href=3D"mailto:Nikola.Jelic@rt-rk.com" t=
arget=3D"_blank" rel=3D"noreferrer">Nikola.Jelic@rt-rk.com</a>&gt;<br>
---<br>
Changes in v3:<br>
- Rebased onto current master<br>
- Fixed semantic error in vhost_section comment<br>
- Link to v2: <a href=3D"https://lore.kernel.org/qemu-devel/20260629-vhost-=
xen-foreign-mapping-v2-0-19e4685e7575@rt-rk.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://lore.kernel.org/qemu-devel/20260629-vhost-xen=
-foreign-mapping-v2-0-19e4685e7575@rt-rk.com</a><br>
<br>
Changes in v2:<br>
- Rebased onto current master<br>
- Cover letter: removed a rust-vmm hunk which made the git am<br>
=C2=A0 on Patchview fail. The reference is now mentioned in a sentance.<br>
- Link to v1:<br>
=C2=A0 <a href=3D"https://lore.kernel.org/qemu-devel/20260618-vhost-xen-for=
eign-mapping-v1-0-7f60a6241971@rt-rk.com" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://lore.kernel.org/qemu-devel/20260618-vhost-xen-foreig=
n-mapping-v1-0-7f60a6241971@rt-rk.com</a><br>
<br>
---<br>
Dusan Stojkovic (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: accept Xen guest RAM sections for vhost-user<br=
>
=C2=A0 =C2=A0 =C2=A0 vhost-user: implement VHOST_USER_PROTOCOL_F_XEN_MMAP<b=
r>
<br>
=C2=A0hw/virtio/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 120 +++++++=
++++++++++++++++++++++++++++++++--<br>
=C2=A0hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 18 +++++++<br>
=C2=A0hw/xen/xen_stubs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 ++<br>
=C2=A0include/hw/virtio/vhost-user.h |=C2=A0 =C2=A02 +-<br>
=C2=A05 files changed, 143 insertions(+), 4 deletions(-)<br>
---<br>
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0<br>
change-id: 20260618-vhost-xen-foreign-mapping-d023c85bb706<br>
<br>
Best regards,<br>
-- <br>
Dusan Stojkovic &lt;<a href=3D"mailto:Dusan.Stojkovic@rt-rk.com" target=3D"=
_blank" rel=3D"noreferrer">Dusan.Stojkovic@rt-rk.com</a>&gt;<br>
<br>
</blockquote></div>

--000000000000664b2706594d7e05--

