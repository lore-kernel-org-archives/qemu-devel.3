Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139D5C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgf0-0003TC-Vm; Mon, 12 Aug 2024 21:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgeu-0002xY-Pp
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:49:14 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdget-0000VU-1O
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:49:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0A7D3602BF;
 Tue, 13 Aug 2024 01:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9FCC4AF0D;
 Tue, 13 Aug 2024 01:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723513749;
 bh=ZRmOJq5hRHTEKtPFJV0GBl+YFUXJeHYluIT7QrSEQrU=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=J8MkLBDuS20gYPoBTbHMj61jyWLS0NE+biTu+uJ+rEZV6hwc7WL4pDEHc2xEDU5Uh
 DMfMZXw1HCt3nz/XqGLf2g66IVqXfdcOiw+kbj+UeWigIPLUHFHLDsXBqLbixlYRwo
 ht/Ai/QKUiw3mtFhQmBsxKubYufBrtP5kNoXdSLBn82u1h4/CPJwTKqTLiDQv/N3DK
 maEEw2sjJ/jqUsFM05obzXV0pPVc4NIV1xCuQuByRiV/ZYuyXPtY3cvCIUGLu5i199
 mPOMUz5HzC2UJ56KkvftsqLXxDtj2WxAo6g9bp0vFrmD+ud1ynutR+gsWJfe0yNC7a
 Cxn+qJFw7WCog==
Date: Mon, 12 Aug 2024 18:49:07 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 10/10] docs/system/i386: xenpvh: Add a basic description
In-Reply-To: <20240812130606.90410-11-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408121848590.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-11-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  MAINTAINERS                 |  1 +
>  docs/system/i386/xenpvh.rst | 49 +++++++++++++++++++++++++++++++++++++
>  docs/system/target-i386.rst |  1 +
>  3 files changed, 51 insertions(+)
>  create mode 100644 docs/system/i386/xenpvh.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24c2e14d9..da4c9d4d46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -560,6 +560,7 @@ F: include/sysemu/xen.h
>  F: include/sysemu/xen-mapcache.h
>  F: stubs/xen-hw-stub.c
>  F: docs/system/arm/xenpvh.rst
> +F: docs/system/i386/xenpvh.rst
>  
>  Guest CPU Cores (NVMM)
>  ----------------------
> diff --git a/docs/system/i386/xenpvh.rst b/docs/system/i386/xenpvh.rst
> new file mode 100644
> index 0000000000..354250f073
> --- /dev/null
> +++ b/docs/system/i386/xenpvh.rst
> @@ -0,0 +1,49 @@
> +Xen PVH machine (``xenpvh``)
> +=========================================
> +
> +Xen supports a spectrum of types of guests that vary in how they depend
> +on HW virtualization features, emulation models and paravirtualization.
> +PVH is a mode that uses HW virtualization features (like HVM) but tries
> +to avoid emulation models and instead use passthrough or
> +paravirtualized devices.
> +
> +QEMU can be used to provide PV virtio devices on an emulated PCIe controller.
> +That is the purpose of this minimal machine.
> +
> +Supported devices
> +-----------------
> +
> +The x86 Xen PVH QEMU machine provide the following devices:
> +
> +- RAM
> +- GPEX host bridge
> +- virtio-pci devices
> +
> +The idea is to only connect virtio-pci devices but in theory any compatible
> +PCI device model will work depending on Xen and guest support.
> +
> +Running
> +-------
> +
> +The Xen tools will typically construct a command-line and launch QEMU
> +for you when needed. But here's an example of what it can look like in
> +case you need to construct one manually:
> +
> +.. code-block:: console
> +
> +    qemu-system-i386 -xen-domid 3 -no-shutdown        \
> +      -chardev socket,id=libxl-cmd,path=/var/run/xen/qmp-libxl-3,server=on,wait=off \
> +      -mon chardev=libxl-cmd,mode=control             \
> +      -chardev socket,id=libxenstat-cmd,path=/var/run/xen/qmp-libxenstat-3,server=on,wait=off \
> +      -mon chardev=libxenstat-cmd,mode=control        \
> +      -nodefaults                                     \
> +      -no-user-config                                 \
> +      -xen-attach -name g0                            \
> +      -vnc none                                       \
> +      -display none                                   \
> +      -device virtio-net-pci,id=nic0,netdev=net0,mac=00:16:3e:5c:81:78 \
> +      -netdev type=tap,id=net0,ifname=vif3.0-emu,br=xenbr0,script=no,downscript=no \
> +      -smp 4,maxcpus=4                                \
> +      -nographic                                      \
> +      -machine xenpvh,ram-low-base=0,ram-low-size=2147483648,ram-high-base=4294967296,ram-high-size=2147483648,pci-ecam-base=824633720832,pci-ecam-size=268435456,pci-mmio-base=4026531840,pci-mmio-size=33554432,pci-mmio-high-base=824902156288,pci-mmio-high-size=68719476736 \
> +      -m 4096
> diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
> index 1b8a1f248a..23e84e3ba7 100644
> --- a/docs/system/target-i386.rst
> +++ b/docs/system/target-i386.rst
> @@ -26,6 +26,7 @@ Architectural features
>     i386/cpu
>     i386/hyperv
>     i386/xen
> +   i386/xenpvh
>     i386/kvm-pv
>     i386/sgx
>     i386/amd-memory-encryption
> -- 
> 2.43.0
> 

