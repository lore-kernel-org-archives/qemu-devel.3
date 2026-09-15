Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E88EC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XKp-0005ph-Mt; Tue, 15 Sep 2026 13:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XKn-0005pV-FN; Tue, 15 Sep 2026 13:52:45 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XKl-0003Hf-SF; Tue, 15 Sep 2026 13:52:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68733600D1;
 Tue, 15 Sep 2026 17:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F14E1F000FF;
 Tue, 15 Sep 2026 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789494762;
 bh=uodPxlgBecGq4pzVFqjxaJw1KTwHptSdfwPzXkSyiuw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YlVCiFBaRvrGblGKhXWX0PxF5kcleH4rh9Y0lxfn0a0Mz7zGL4jdPdqKnZ0WFSk9N
 7aPkCOAmh6DKccghtpgJEGfw+hH3HObZmGsryJmRpX+fQpWP8hbk7zdqlctelNeoue
 o4durAKKYs3rOPIOalli+DFCv1i/9EVpGIUY6t+L1Mt/ILbNqufHFuLXu0kg0ixQbv
 mZQwOkYR/mgqF+uYd8qyjbT2MZ01AyCniFWZnu3kuKj/VQMGAaLjYC9ZPNMgcmi1A+
 jwM16nUQmJsLz2b7kyKxlSYugeES1y7cWm+ezjIO7Ktv+HBywktaZ/Z9SVEggNokv9
 saR39xa7TzoYQ==
Date: Tue, 15 Sep 2026 18:52:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 3/6] hw/riscv/virt: Advertise the CXL host bridge to
 firmware via extra-pci-roots
Message-ID: <20260915185239.2c79393a@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-4-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
 <20260907093735.2753-4-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon,  7 Sep 2026 17:37:30 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> The pxb-cxl expander bridge presents as a class 0x0600 host bridge with
> a type-0 header, so EDK2's PciBusDxe never recurses into it and never
> assigns the CXL root port a memory window or bus numbers.  As a result
> build_crs() produces an empty _CRS for the ACPI0016 host bridge and the
> CXL devices behind it are not enumerated by the OS.
> 
> Advertise the pxb-cxl expander root buses to firmware via the
> etc/extra-pci-roots fw_cfg file, the same way arm/virt and x86 do, by
> calling pci_bus_add_fw_cfg_extra_pci_roots() from virt_machine_done().
> EDK2's PciBusDxe then enumerates behind the CXL host bridge and assigns
> the root-port window and bus numbers.  The ACPI tables are rebuilt when
> the guest reads them (after that firmware enumeration), so build_crs()
> then emits a correct _CRS for the ACPI0016 host bridge.
> 
> The call is made unconditionally, in line with arm/virt, pc and hppa,
> so plain pxb-pcie expander bridges, which likewise depend on
> etc/extra-pci-roots, are advertised as well; the generator simply
> returns nothing when there is no expander root bus.
> 
> This approach also scales to multiple pxb-cxl host bridges (each gets
> its own window from the shared aperture) and lets firmware size the
> window to what is actually behind the bridge, rather than reserving a
> fixed carve-out.
> 
> Verified by booting an RVA22 guest: the CXL root port and Type3 device
> enumerate, and 'cxl enable-memdev' / 'cxl create-region' /
> 'daxctl online-memory' bring the CXL memory online as system RAM.
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Aligns with other arch, so makes sense.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

