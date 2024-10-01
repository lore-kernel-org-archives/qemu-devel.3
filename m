Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E021CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveEx-0007uk-WA; Tue, 01 Oct 2024 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sveEt-0007LO-IA; Tue, 01 Oct 2024 10:52:35 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sveEr-0005qq-Oi; Tue, 01 Oct 2024 10:52:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B8EC65C2975;
 Tue,  1 Oct 2024 08:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0F2C4CECD;
 Tue,  1 Oct 2024 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727772872;
 bh=O5qZmitZ7A2fHApahkP4Nj4o31RxP8kbzcB8RWngS90=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iJSTa7B5pgdIDhqA5ZkEkVfGdaNaCMsS5XlU7oowrg/lR44OYLfFSBb90vYWy1TjM
 8bkb9yivHYPYhuEMCoSbNKzbQOnBYYvkEpyr+tYh53KWyL6WAvr2vh3p1nQHSF3ip3
 L3NUPLKPZmXMSPQ2n2NP5UgSyowTJDxaw0uR/0iQCMhrPtBPeeg8AZYLKO5W74R06y
 H7tE/gmDLAEiCNZIxwoSeyS8u8+QxFoeYx9QqXn3/DOfsgvvnpq1rYjZpO1WmG+tHm
 h9cVl8yMfxN6GpbfBuCtZ0ItIXJ0XQbk4gEL+Wz5uOsDI5vG11/IejmiTaDwEqjMWX
 E6mo9ZKo+rsLA==
Date: Tue, 1 Oct 2024 10:54:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST address
Message-ID: <20241001105426.48598baa@sal.lan>
In-Reply-To: <20240916130506.293ab543@imammedo.users.ipa.redhat.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
 <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
 <20240913074435.0eea2552@foz.lan>
 <20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
 <20240914073314.46368ff6@foz.lan>
 <20240916130506.293ab543@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Em Mon, 16 Sep 2024 13:05:06 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > But no idea how to start a machine using a saved state.  
> 
> see https://www.linux-kvm.org/page/Migration
> 'savevm/loadvm to an external state file (using pseudo-migration)' section
> 

It didn't work. Is migration currently working between 9.1 and 9.2?

I did a compilation of qemu version v9.1.0-rc0 and saved the state.

Then, on vanilla 9.2 (changeset 01dc65a3bc26), I tried to restore the
state with both "virt" and "virt-9.1". None worked:


$ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
qemu-system-aarch64: load of migration failed: Operation not permitted

$ qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -M type=virt,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 --nographic -monitor telnet:127.0.0.1:1234,server,nowait -incoming "exec: gzip -c -d statefile.gz" -no-reboot -bios /new_devel/edac/emulator/QEMU_EFI-silent.fd -kernel /new_devel/edac/work/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=/new_devel/edac/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
qemu-system-aarch64: Machine type received is 'virt-9.1' and local is 'virt-9.2'
qemu-system-aarch64: load of migration failed: Invalid argument

Did I made something wrong?

Regards,
Mauro

