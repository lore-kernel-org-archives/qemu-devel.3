Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEBDC0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 02:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdh2h-0004at-69; Thu, 30 Jan 2025 21:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tdh2f-0004al-F9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 21:46:01 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tdh2d-0003dO-QJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 21:46:01 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1C1665C607E;
 Fri, 31 Jan 2025 02:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603D9C4CED2;
 Fri, 31 Jan 2025 02:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738291553;
 bh=En/iMtmkKZux8N9VA5uOiTQQrDgmaDnMr02/HapSy+U=;
 h=Date:From:To:cc:Subject:From;
 b=ckOc6L4VRZzsaVa7ZLCvhRH8t299g7lK6C3ghotjHLqEhDVBVUSU++AxxKl+yTpAt
 cU+LgppTM4lbQT6YuhQKRcIwHFiCYuc4Gac9gfjLmTuhwZOKHazQNkvIQjYmFuqG4+
 uyKbJ79fTxlfW4wesiFN+X2/uMNFYWXK70VP+V+AVN7L8XVtmZRu2zpVhnln8q396/
 Lx4MKpQFJqAJktKIIVVSge8cyxP5OBBkQbc2sa9T/ghr8xwgDKSUqTB1K+DvW4JdSB
 R7QTVb2ejExuU9408LtunBhSaZwXAq+pKhkvRgnUoDgYW1WiqOoxMl1I8Lj14vZg0i
 KMMfxoLtdSMkQ==
Date: Thu, 30 Jan 2025 18:45:50 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Paolo Bonzini <pbonzini@redhat.com>
cc: sstabellini@kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org, 
 Edgar.Iglesias@amd.com, jason.andryuk@amd.com, xenia.ragiadakou@amd.com
Subject: QEMU TCG AMD64 error running Xen
Message-ID: <alpine.DEB.2.22.394.2501301825380.11632@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,

It has been a long time :-)  Nowadays I work on Xen on both ARM and AMD
x86, and our x86 configuration has only hardware-assisted guests (PVH
guests). Even Dom0 is hardware-assisted.

I am trying to run Xen with Dom0 as PVH guest in QEMU TCG. If I enable
KVM, it works, but with KVM disabled it does not.

Xen gets all the way to doing "vmrun" on Dom0, but then it keeps getting
VMEXITs (svm_vmexit_handler) with vmcb->exitcode=0x60, which is
VMEXIT_INTR. QEMU is executing
target/i386/tcg/system/seg_helper.c:x86_cpu_exec_interrupt with
interrupt_request == CPU_INTERRUPT_HARD.

This is my QEMU command line, I am using the staging branch:

/local/repos/qemu/build/qemu-system-x86_64 \
    -cpu EPYC-v3,+svm \
    -machine q35 \
    -smp 1 -m 4G \
    -monitor none -serial stdio \
    -nographic \
    -no-reboot \
    -device virtio-net-pci,netdev=n0 \
    -netdev user,id=n0,tftp=/local/qemu-x86/binaries,bootfile=/pxelinux.0

This is my pxelinux.0 file:

#!ipxe
  
kernel xen console=com1 dom0=pvh dom0-iommu=none dom0_mem=1G sync_console
module bzImage console=hvc0
boot

If it helps make things easier, you can even take the Xen and Linux
bzImage binaries from the Xen CI-loop:
https://gitlab.com/xen-project/hardware/xen/-/jobs/8980862961/artifacts/browse/binaries/
https://gitlab.com/xen-project/hardware/xen/-/jobs/8980862959/artifacts/browse/binaries/

Do you have any ideas of what could be the source of the problem?

Cheers,

Stefano

