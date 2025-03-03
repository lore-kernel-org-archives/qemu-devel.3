Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F4C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 19:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpBKx-0003WD-MN; Mon, 03 Mar 2025 14:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tpBKX-0003O2-0B
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tpBKR-0003Gu-Ij
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741029587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew8cLbviQXGRSsXKjXB+/SyYXVC0dlfqrmPZgpUh6lg=;
 b=D8xSD+BOFfcx/vq6DezduPZuYfP2+MOD87whq4hfBINNJ5rsjVMkDDv9mUOUP4RHb9lQXo
 0l/63HPZfMX0uJU/nQyOWp91RNrVvoTRmIE/yTBtj4eE444vVC4b3GUtu8qfbXBuhJ8zL4
 LC3PoNWlCUMb6FF5ZuVrm4KU0a6QeJ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-X3wY6VqJOq2gGFoTobeCTA-1; Mon,
 03 Mar 2025 14:19:37 -0500
X-MC-Unique: X3wY6VqJOq2gGFoTobeCTA-1
X-Mimecast-MFC-AGG-ID: X3wY6VqJOq2gGFoTobeCTA_1741029576
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBE6E1800874; Mon,  3 Mar 2025 19:19:35 +0000 (UTC)
Received: from gezellig (unknown [10.45.224.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F831180035F; Mon,  3 Mar 2025 19:19:30 +0000 (UTC)
Date: Tue, 4 Mar 2025 00:49:26 +0530
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com,
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com
Subject: Re: [PATCH v2 0/8] riscv: AIA: kernel-irqchip=off support
Message-ID: <Z8YAvmO4OMEeyL3U@gezellig>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224082417.31382-1-yongxuan.wang@sifive.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 24, 2025 at 04:24:07PM +0800, Yong-Xuan Wang wrote:
> This series introduces the user-space AIA MSI emulation when using KVM
> acceleration.
> 
> After this series, RISC-V QEMU virt machine with KVM acceleration has
> 3 parameters to control the type of irqchip and its emulation method:
> - Machine prop "aia" controls the type of irqchip
>   - none: use PLIC and emulated in user-space
>   - aplic: use AIA wired and emulated in user-space
>   - aplic-imsic: use AIA MSI, emulation mode is determined by
>     "kernel-irqchip" and "riscv-aia". This can only be used
>     when the host machine support the AIA extension.
> - Accel prop "kernel-irqchip", effective with AIA MSI
>   - on: in-kernel APLIC and in-kernel IMSIC
>   - off: user-space APLIC and user-space IMSIC
>   - split: user-space APLIC and in-kernel IMSIC
> - Accel prop "riscv-aia", effective with in-kernel IMSIC
>   - emul: use MRIF as in-kernel IMSIC
>   - hw: use hardware guest IMSIC file as in-kernel IMSIC
>   - auto: use the hardware guest IMSICs whenever available otherwise
>     fallback to MRIF

[...]

> Yong-Xuan Wang (8):
>   target/riscv/kvm: rewrite get/set for KVM_REG_RISCV_CSR
>   target/riscv/kvm: add KVM_REG_RISCV_CSR_AIA
>   target/riscv/kvm: add KVM_REG_RISCV_CSR_SMSTATEEN
>   target/riscv: add helper to get CSR name
>   target/riscv/kvm: rewrite kvm_riscv_handle_csr
>   target/riscv/kvm: add CSR_SIREG and CSR_STOPEI emulation
>   docs: update the description about RISC-V AIA
>   hw/intc/imsic: prevent to use IMSIC when host doesn't support AIA
>     extension
> 
>  docs/specs/riscv-aia.rst   |  24 +++-
>  docs/system/riscv/virt.rst |  10 +-
>  hw/intc/riscv_imsic.c      |  17 ++-
>  target/riscv/cpu.h         |  10 +-
>  target/riscv/csr.c         |  30 ++---
>  target/riscv/kvm/kvm-cpu.c | 235 +++++++++++++++++++++++++++++++------
>  6 files changed, 254 insertions(+), 72 deletions(-)


I don't pretend to grok all the details here, and I couldn't test the
KVM-acceleration path ("-accel kvm,kernel-irqchip=split"), as I don't
yet have hardware to test.  I was able to test the TCG part:

I'm at:

    $> git describe
    v9.2.0-1976-g68d58113df

My QEMU command-line is here[1].  I tried out these two variataions:

    ... -machine virt,accel=tcg,aia=aplic,kernel-irqchip=split ...

    ... -machine virt,accel=tcg,aia=aplic-imsic,kernel-irqchip=split ...

And booted a Fedora-41 RISC-V host-generic guest image from here:

    https://dl.fedoraproject.org/pub/alt/risc-v/release/41/Server/riscv64/images/

As near as I see, nothing exploded :)

I see that:

  - From the docs: “aia=aplic” selects APLIC (advanced platform level
    interrupt controller) to handle wired interrupts whereas the
    “aia=aplic-imsic” selects APLIC and IMSIC (incoming message signaled
    interrupt controller) to handle both wired interrupts and MSIs

  - There's no user-visible change here, but only a developer-visible
    change: in terms of what's being emulated in userspace vs. in-kernel
    irqchip.)

So, if it's still not too late:

    Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

        * * *

[1] QEMU command-line:
------------------------------------------------------------------------
$ ./qemu-system-riscv64
-display none
-cpu max
-no-user-config
-nodefaults
-serial stdio
-smp 4,sockets=4,cores=1,threads=1
-machine virt,accel=tcg,aia=aplic,kernel-irqchip=split
-blockdev node-name=node-Base1,driver=raw,file.driver=file,file.filename=./base1.raw,file.node-name=node-Base1-file
-device virtio-blk,drive=node-Base1,id=virtio0
-device virtio-net-device,netdev=net \
-netdev user,id=net,hostfwd=tcp::2222-:22 \
-blockdev '{"driver":"file","filename":"/usr/share/edk2/riscv/RISCV_VIRT_CODE.qcow2","node-name":"pflash0-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"pflash0-format","read-only":true,"driver":"qcow2","file":"pflash0-storage"}' \
-blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/base1_VARS.qcow2","node-name":"pflash1-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"pflash1-format","read-only":false,"driver":"qcow2","file":"pflash1-storage"}' \
-machine virt,usb=off,dump-guest-core=off,memory-backend=riscv_virt_board.ram,pflash0=pflash0-format,pflash1=pflash1-format,acpi=off \
-m size=4194304k \
-object '{"qom-type":"memory-backend-ram","id":"riscv_virt_board.ram","size":4294967296}' \
-object rng-random,filename=/dev/urandom,id=rng \
-device virtio-rng-device,rng=rng 
------------------------------------------------------------------------

-- 
/kashyap


