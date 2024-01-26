Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E180C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTL8W-0004VI-58; Fri, 26 Jan 2024 07:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTL8P-0004UW-52; Fri, 26 Jan 2024 07:16:37 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTL8L-00053L-Hu; Fri, 26 Jan 2024 07:16:36 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLxWG3KJ0z4wd4;
 Fri, 26 Jan 2024 23:16:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLxW51TKHz4wd0;
 Fri, 26 Jan 2024 23:16:16 +1100 (AEDT)
Message-ID: <9d1368b2-b163-4fd7-90e6-c87a3e643bbc@kaod.org>
Date: Fri, 26 Jan 2024 13:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/11] hw/fsi: Added FSI documentation
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20240126104956.74126-1-ninad@linux.ibm.com>
 <20240126104956.74126-11-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240126104956.74126-11-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/26/24 11:49, Ninad Palsule wrote:
> Documentation for IBM FSI model.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v11:
>    - Removed Cedric's signoff.
> ---
>   docs/specs/fsi.rst   | 126 +++++++++++++++++++++++++++++++++++++++++++
>   docs/specs/index.rst |   1 +
>   2 files changed, 127 insertions(+)
>   create mode 100644 docs/specs/fsi.rst
> 
> diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
> new file mode 100644
> index 0000000000..b33b4d565c
> --- /dev/null
> +++ b/docs/specs/fsi.rst
> @@ -0,0 +1,126 @@
> +======================================
> +IBM's Flexible Service Interface (FSI)
> +======================================
> +
> +The QEMU FSI emulation implements hardware interfaces between ASPEED SOC, FSI
> +master/slave and the end engine.
> +
> +FSI is a point-to-point two wire interface which is capable of supporting
> +distances of up to 4 meters. FSI interfaces have been used successfully for
> +many years in IBM servers to attach IBM Flexible Support Processors(FSP) to
> +CPUs and IBM ASICs.
> +
> +FSI allows a service processor access to the internal buses of a host POWER
> +processor to perform configuration or debugging. FSI has long existed in POWER
> +processes and so comes with some baggage, including how it has been integrated
> +into the ASPEED SoC.
> +
> +Working backwards from the POWER processor, the fundamental pieces of interest
> +for the implementation are: (see the `FSI specification`_ for more details)
> +
> +1. The Common FRU Access Macro (CFAM), an address space containing various
> +   "engines" that drive accesses on buses internal and external to the POWER
> +   chip. Examples include the SBEFIFO and I2C masters. The engines hang off of
> +   an internal Local Bus (LBUS) which is described by the CFAM configuration
> +   block.
> +
> +2. The FSI slave: The slave is the terminal point of the FSI bus for FSI
> +   symbols addressed to it. Slaves can be cascaded off of one another. The
> +   slave's configuration registers appear in address space of the CFAM to
> +   which it is attached.
> +
> +3. The FSI master: A controller in the platform service processor (e.g. BMC)
> +   driving CFAM engine accesses into the POWER chip. At the hardware level
> +   FSI is a bit-based protocol supporting synchronous and DMA-driven accesses
> +   of engines in a CFAM.
> +
> +4. The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in POWER
> +   processors. This now makes an appearance in the ASPEED SoC due to tight
> +   integration of the FSI master IP with the OPB, mainly the existence of an
> +   MMIO-mapping of the CFAM address straight onto a sub-region of the OPB
> +   address space.
> +
> +5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in the
> +   AST2600. Hardware limitations prevent the OPB from being directly mapped
> +   into APB, so all accesses are indirect through the bridge.
> +
> +The LBUS is modelled to maintain the qdev bus hierarchy and to take advantages
> +of the object model to automatically generate the CFAM configuration block.
> +The configuration block presents engines in the order they are attached to the
> +CFAM's LBUS. Engine implementations should subclass the LBusDevice and set the
> +'config' member of LBusDeviceClass to match the engine's type.
> +
> +CFAM designs offer a lot of flexibility, for instance it is possible for a
> +CFAM to be simultaneously driven from multiple FSI links. The modeling is not
> +so complete; it's assumed that each CFAM is attached to a single FSI slave (as
> +a consequence the CFAM subclasses the FSI slave).
> +
> +As for FSI, its symbols and wire-protocol are not modelled at all. This is not
> +necessary to get FSI off the ground thanks to the mapping of the CFAM address
> +space onto the OPB address space - the models follow this directly and map the
> +CFAM memory region into the OPB's memory region.
> +
> +QEMU files related to FSI interface are in following directories:
> + - ``hw/fsi``
> + - ``include/hw/fsi``

This is not useful.

> +The following commands start the ``rainier-bmc`` machine with built-in FSI
> +model. There are no model specific arguments. Please check this document to
> +learn more about Aspeed ``rainier-bmc`` machine: docs/system/arm/aspeed.rst

This should be :  (:doc:`../../system/arm/aspeed`)

I will fix it.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> +
> +.. code-block:: console
> +
> +  qemu-system-arm -M rainier-bmc -nographic \
> +  -kernel fitImage-linux.bin \
> +  -dtb aspeed-bmc-ibm-rainier.dtb \
> +  -initrd obmc-phosphor-initramfs.rootfs.cpio.xz \
> +  -drive file=obmc-phosphor-image.rootfs.wic.qcow2,if=sd,index=2 \
> +  -append "rootwait console=ttyS4,115200n8 root=PARTLABEL=rofs-a"
> +
> +The implementation appears as following in the qemu device tree:
> +
> +.. code-block:: console
> +
> +  (qemu) info qtree
> +  bus: main-system-bus
> +    type System
> +    ...
> +    dev: aspeed.apb2opb, id ""
> +      gpio-out "sysbus-irq" 1
> +      mmio 000000001e79b000/0000000000001000
> +      bus: opb.1
> +        type opb
> +        dev: fsi.master, id ""
> +          bus: fsi.bus.1
> +            type fsi.bus
> +            dev: cfam.config, id ""
> +            dev: cfam, id ""
> +              bus: lbus.1
> +                type lbus
> +                dev: scratchpad, id ""
> +                  address = 0 (0x0)
> +      bus: opb.0
> +        type opb
> +        dev: fsi.master, id ""
> +          bus: fsi.bus.0
> +            type fsi.bus
> +            dev: cfam.config, id ""
> +            dev: cfam, id ""
> +              bus: lbus.0
> +                type lbus
> +                dev: scratchpad, id ""
> +                  address = 0 (0x0)
> +
> +pdbg is a simple application to allow debugging of the host POWER processors
> +from the BMC. (see the `pdbg source repository`_ for more details)
> +
> +.. code-block:: console
> +
> +  root@p10bmc:~# pdbg -a getcfam 0x0
> +  p0: 0x0 = 0xc0022d15
> +
> +.. _FSI specification:
> +   https://openpowerfoundation.org/specifications/fsi/
> +
> +.. _pdbg source repository:
> +   https://github.com/open-power/pdbg
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index b3f482b0aa..1484e3e760 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -24,6 +24,7 @@ guest hardware that is specific to QEMU.
>      acpi_erst
>      sev-guest-firmware
>      fw_cfg
> +   fsi
>      vmw_pvscsi-spec
>      edu
>      ivshmem-spec


