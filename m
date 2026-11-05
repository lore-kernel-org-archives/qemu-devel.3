Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C698606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1XlBmGM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP67G-0007cC-Lc; Thu, 05 Nov 2026 17:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1xP67E-0007bv-NF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:39:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1xP67A-0002sl-U7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:39:27 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e985106c0cso97575ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 14:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793918363; x=1794523163; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AKGvZg4V+w18M4Zq0FCnto7JGIRgmxaKrCtgH1IjroI=;
 b=K1XlBmGMq6LKSg829ctQSZZlfZ5+x3Rp0ZXJtcZpBOZEbmWtLL0Cb4qqQHzngFpN4+
 zkjRAUCKDfSvB3MHN9v/Xc8FVmqFtF5vpJtdwQgYDsUj7oQDurYJ74KU6tN+ftHKRxkz
 qlNQLHxg/r4Oq4PMKAX/ucCkxIxa782HsNjzHykdPE1ubMdyi2FNmFZ9IzmNd+uysMnj
 FcRKZdFAOE+xHliqIL4dXU2efz/Va2/x3Z33MdvW8Pz3qjTbVRjrdVTBuqMLd1u9nQzb
 4CTKvn5g0u3002rYjWKL9WI9sPDSmuouHOr8YCv7fcAXHF+liOXMiDFrlg0ms2Ivpmqb
 AorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793918363; x=1794523163;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AKGvZg4V+w18M4Zq0FCnto7JGIRgmxaKrCtgH1IjroI=;
 b=ISzNBaiQILpDeL7WZ54EwPx7A1zU8rrJKmlYlVOTDI0ZjlNWn67qjYHjG4yNL01oCA
 i+FivgiZw1FdzVLlUmHgIcZAlYWPb8qVASzTWun7oqF97WagZeE2TxxdKlTH6IeArAOT
 +lDr0LQLKhuwkbRHDhWmX5ODc3bG6bISylOFkN6ggpg5cORz10dB7SLzhpxc4L135Lxz
 ocvIt3ReU32y4GGOyjqs4Zc5zcxxdR/MbAqujVHq0MLFqtccziDaV7seJDunGzQDcKx/
 Q6He6QNlpjCl8ptvo97EkbdrICSaWmDaa1FjyQK0o8t6oZjB+/r/Tt7BGgabwILfMaNM
 EhQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxwXagAfX6Sm3Pd39R8J/6dXTUMrjm3I8/+1FjlGv67nFW4d7tk9T9WgZ+rFwOf4BLqwoiU0W3lWdM@nongnu.org
X-Gm-Message-State: APuU4Z+AwoUntI23TE326nLOxvmyVZ7GjVV+ZDeixuFBl1RpozFUx2WI
 +1n0whj1jWG+brzIzYuBrc9jix4UsQh233xNrm2PvelVBQClOLpZHHHz
X-Gm-Gg: AYBFou1u+Q2x2aljmxYM/DoAKrJBc+ZC78pC+74Zv3tP3Ad3rTmyHnhb9LermQAVOaT
 k7MScr4GIXqqf1lIGC/HBpxjIxCbpsFsCnFGcpFjaJPxh7MAZRFdCWBtH7xyCcRLcdBBvDnaqyU
 i1pqjC2c9/BaYyK7/mBVJIXNpk6oZqW/CV6DxrViYDD6C4+0qKLxo6NcrQT2WzGpLe/D2VggNiy
 y2waPFHKFv10QT0za8AljKkA455pDB4JChsXsBwUTZBE5xyfOY1WIYjhzdL9jDVVgedR/0XP2UU
 yGrEuasdc+UYDatiSu+a3Y6Tp/5TgDJUH4bazJepn/XQ8K52EzQkyJfo2oeZeiKkCFf0ZCU7CQx
 hnfFM3fMJvUTPC7WNvuenNPl8UnpXdzNSWEvwMSUp1ItdxemKwEv4wKSwEbP2RWARNRPeibqqyD
 X6RRWEcXU/d1wj0NrPoCcWUFVvSfzbdzD1kyGRdwaVYiYsjp3bo9HoKu3g69biRa3zRffW2Di0c
 ytu+IL/Lrae50V2dLWFUAqvNdS0JKKoVnj9KepPDKOqXJywzTQPkrU4I7bby4ILlBF8h2VW4X/F
 Oue1l5yU+rjRaC+zKeEnz4oVag==
X-Received: by 2002:a17:903:285:b0:2e9:4048:3031 with SMTP id
 d9443c01a7336-2ed4198b8eemr10304335ad.39.1793918363084; 
 Thu, 05 Nov 2026 14:39:23 -0800 (PST)
Received: from cxlqual ([220.120.90.131]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d89976sm18335ad.66.2026.11.05.14.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 14:39:22 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 6 Nov 2026 07:41:38 +0900
To: Anisa Su <anisa.su887@gmail.com>
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>, lizhijian@fujitsu.com,
 y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: Re: [PATCH RFC 0/7] QEMU/hw/cxl: Allow CXL Type 3 memory regions to
 be initialized at guest boot
Message-ID: <au0GIiKIggftlWe2@cxlqual>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
 <auvsOE3OlS5I9ueG@cxlqual>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auvsOE3OlS5I9ueG@cxlqual>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x62e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 11:38:48AM +0900, Anisa Su wrote:
> On Mon, Oct 26, 2026 at 07:03:21PM +0900, Yukiya Takaki wrote:
> > Hello everyone,
> > 
> > I’m a student intern, and this is my first time sending patches to an open source mailing list.
> > 
> > This patch series configures QEMU’s CXL Type 3 devices so that guest operating systems can automatically discover
> > and create CXL regions during boot, aligning QEMU’s behavior with real hardware.
> > 
> > Background and motivation
> >   Currently, during guest boot QEMU does not provide the information or register programming needed for the guest OS
> >   to initialize CXL Type 3 memory, so using it still requires an explicit action in the guest (for example, running the cxl create-region command).
> >   By contrast, on some physical systems the firmware automatically allocates CXL memory ranges and exposes them to the OS,
> >    allowing the Linux CXL driver to discover and create regions during boot.
> >   This patch series is a first, experimental attempt to reproduce that behavior in QEMU.
> > 
> >   Some parts of this implementation are based on Li, Zhijian’s work in:
> >   https://github.com/zhijianli88/qemu/tree/program-decoder-v2
> > 
> >   I would like to ask for feedback on whether this approach makes sense and whether I should continue to enhance it.
> > 
> > Approach
> >   This patch first adds a program_hdm_decoder option to cxl-type3.
> >   When program-hdm-decoder is enabled on cxl-type3, QEMU will:
> >     1) program endpoint/host-bridge HDM decoder state,
> >     2) expose Type 3 ranges as E820_SOFT_RESERVED on x86,
> >     3) create memory-only NUMA nodes for those ranges,
> >     4) emit SRAT memory-affinity entries mapping each Type 3 HPA range to its node ID
> > 
> >   On real hardware, HDM decoder programming and memory layout are typically handled by firmware, so they would ideally be managed by SeaBIOS.
> >   However, in the current QEMU/SeaBIOS model, E820 and SRAT are built on the QEMU side, and pushing HDM decoder programming
> >   into SeaBIOS would introduce additional complexity and risk inconsistencies.
> > 
Ignore my previous suggestion and listen to Jonathan :)

Thanks,
Anisa

> Hi again,
> 
> Thank you for your contribution. I think this series can be valuable for
> helping test autodiscovery in the kernel driver. I spent more time looking over this
> patchset and in my view, the main blockers for making this ready for upstream are:
> 
> 1.The HPA state is kept in the wrong place.
> Patch 2 adds hpa_offset, idx and node to CXLType3Dev but and endpoint should
> not track host state.
> 
> I also think it makes more sense to make program-dhm-decoder a machine
> option (-M program-hdm-decoder...) instead of having it on cxl-type3
> endpoint
> 
> 2. Host bridge register init moved from reset to realize.
> As you mentioned below, "The current implementation prevents the host
> bridge HDM decoder configuration from being overwritten later in the same reset
> by moving the common initialization of the host bridge component registers from
> the reset path to the realization path."
> 
> To more accurately emulate what firmware does, maybe you can try
> something like the following?
> 
> 1. Add program-hdm option to machine (hw/cxl/cxl-host.c, include/hw/cxl/cxl.h)
> 
> typedef struct CXLState {
>     bool is_enabled;
> +   bool program_hdm_decoders;
>     ...
> } CXLState;
> 
> +static void machine_set_hdm_auto(Object *obj, Visitor *v, const char *name,
> +                                 void *opaque, Error **errp)
> +{
> +    CXLState *cxl_state = opaque;
> +    bool value;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +    cxl_state->program_hdm_decoders = value;
> +}
> 
>  void cxl_machine_init(Object *obj, CXLState *state)
>  {
>      ...
> +    object_property_add(obj, "cxl-hdm-auto", "bool", machine_get_hdm_auto,
> +                        machine_set_hdm_auto, NULL, state);
> +    object_property_set_description(obj, "cxl-hdm-auto",
> +                                    "Set on/off to have HDM decoders "
> +                                    "programmed at reset as firmware would");
> 
> 2. Add cxl_fmws_program_decoders() to pxb_cxl reset exit.
> Every device has 3 reset phase: enter, hold, and exit. Currently,
> pxb-cxl has:
> - enter = none
> - hold = pxb_cxL-dev_reset(), which zeroes registers
> - exit = none
> 
> Register cxl_fmws_program_decoders() to pxb-cxl reset exit.
> 
> cxl-host.c:
> +void cxl_fmws_for_each_auto_range(PXBCXLDev *pxb)
> {
> 
> + /* use existing helper cxl_fmws_get_all_sorted to iterate */
> + GSList *fws = cxl_fmws_get_all_sorted(), *it;
> +
> +for (it = fws; it; it = it->next) {
> +    CXLFixedWindow *fw = CXL_FMW(it->data);
> 	/* program decoders here */
> 
> +    }
> }
>  ...
> 
> +/* Call from the pxb-cxl reset exit phase, see pxb_cxl_dev_reset_exit() */
> +void cxl_fmws_program_decoders(PXBCXLDev *pxb)
> +{
> +    cxl_fmws_for_each_auto_range(pxb);
> +}
> 
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
>  #include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
> 
> +static void pxb_cxl_dev_reset_exit(Object *obj, ResetType type)
> +{
> +    PXBCXLDev *pxb = PXB_CXL_DEV(obj);
> +    PXBCXLDevClass *pc = PXB_CXL_DEV_GET_CLASS(obj);
> +
> +    if (pc->parent_phases.exit) {
> +        pc->parent_phases.exit(obj, type);
> +    }
> +    if (pxb->cxl_state && pxb->cxl_state->program_hdm_decoders) {
> +        cxl_fmws_program_decoders(pxb);
> +    }
> +}
> +
> static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
>  {
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>      ...
>      device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
> +    rc->phases.exit = pxb_cxl_dev_reset_exit;
>  }
> 
> This way, we shouldn't need to store the extra state (hpa_offset,etc.)
> in the cxl-type3 endpoints.
> 
> I'm also not that familiar with the machine initialization and reset
> stages, so maybe this approach doesn't work, but this is my best guess.
> 
> Thanks,
> Anisa
> 
> > Testing
> >   We ran tests in the following environment and confirmed that CXL regions were created at boot, NUMA nodes were set up,
> >   and E820_SOFT_RESERVED entries appeared in the E820 table:
> > 
> >   - BIOS: SeaBIOS c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf
> >   - CXL memory: 4 GB
> >   - CFMWS: 4 GB
> >   - Host bridge: 1
> > 
> >   The following is the startup script.
> > 
> >   sudo /path/to/qemu/build/qemu-system-x86_64 \
> >     -name guest=cxl \
> >     -nographic \
> >     -machine q35,accel=tcg,nvdimm=on,cxl=on \
> >     -cpu max -smp 4,sockets=4,cores=1,threads=1 \
> >     -m size=4G,slots=10,maxmem=20G \
> >     -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
> >     -bios /path/to/seabios/out/bios.bin \
> >     -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
> >     -object memory-backend-ram,size=2G,id=m0 \
> >     -object memory-backend-ram,size=2G,id=m1 \
> >     -numa node,nodeid=0,cpus=0-1,memdev=m0 \
> >     -numa node,nodeid=1,cpus=2-3,memdev=m1 \
> >     -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
> >     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> >     -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
> >     -object memory-backend-ram,size=4G,share=on,id=vmem0 \
> >     -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
> >     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> >   
> >   Furthermore, we conducted the experiment in which we added two CXL Type3.
> > 
> >   - CXL memory: 4 GB × 2
> >   - CFMWS: 4 GB × 2
> > 
> >   The following is the startup script.
> >     
> >   sudo /path/to/qemu/build/qemu-system-x86_64 \
> >     -name guest=cxl \
> >     -nographic \
> >     -machine q35,accel=tcg,nvdimm=on,cxl=on,hmat=on \
> >     -cpu max -smp 4,sockets=4,cores=1,threads=1 \
> >     -m size=4G,slots=10,maxmem=20G \
> >     -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
> >     -bios /path/to/seabios/out/bios.bin \
> >     -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
> >     -object memory-backend-ram,size=2G,id=m0 \
> >     -object memory-backend-ram,size=2G,id=m1 \
> >     -numa node,nodeid=0,cpus=0-1,memdev=m0 \
> >     -numa node,nodeid=1,cpus=2-3,memdev=m1 \
> >     -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
> >     -device pcie-root-port,id=pci-root-net,chassis=5,slot=5,bus=pcie.0 \
> >     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> >     -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
> >     -device cxl-rp,port=3,id=root_port14,bus=cxl.1,chassis=2,slot=4 \
> >     -object memory-backend-ram,size=4G,share=on,id=vmem0 \
> >     -object memory-backend-ram,size=4G,share=on,id=vmem1 \
> >     -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
> >     -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1,program-hdm-decoder=true \
> >     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=4k
> > 
> > 
> > How to use
> >   Specify the following parameters when starting QEMU:
> > 
> >   - bios <SeaBIOS binary that includes commit c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf> to ensure that E820_SOFT_RESERVED entries are exposed
> >   - Add hmat=on to the -machine option [1]
> >   - Add program-hdm-decoder=true to each -device cxl-type3 option
> >     [1] On Linux, the kernel first checks E820_SOFT_RESERVED ranges. When multiple CXL Type 3 devices share a contiguous HPA range,
> >         these ranges tend to be merged into a single region, so the CXL driver cannot reliably initialize per‑device regions based on E820 alone.
> >         SRAT entries for CXL memory are therefore needed, and the guest seems to discard SRAT when `hmat=on` is not specified,
> >         so HMAT must be enabled.
> > 
> > QEMU base commit: bddb785e791e415db38884848d068457e226f5e3
> > 
> > TODO
> >   With the current implementation of this patch, the following configurations are either not supported or have not been sufficiently tested.
> >   As a result, automatic creation of CXL regions in the guest OS may fail:
> > 
> >   - A CXL persistent memory device is included
> >   - Interleaved configurations
> >   - Cases where the memory size specified by CFMWS does not match the size of the CXL Type 3 backend memory
> >   - Configurations where CXL memory is attached via a switch
> >   - Multi-target CFMWS environments
> >   - ARM environments
> >   - HMAT does not yet include information about CXL memory devices
> > 
> >   The following behaviors are also provisional implementations and may need further refinement:
> >    - A new NUMA node ID is assigned to each CXL memory device. This should be improved either to reflect more accurate NUMA distances for CXL memory,
> >      or to allow the NUMA node IDs to be specified by the user.
> >    - Assignment of CXL Type 3 devices to CFMWS address ranges. On physical systems, platform firmware typically generates CFMWS entries
> >      based on the detected CXL topology and its address-space allocation. In QEMU, however, CFMWS entries are configured explicitly
> >      through machine options. The current implementation therefore has to infer which CFMWS range should be used for each Type 3 device.
> >      This selection logic may need further refinement. Possible approaches include improving the selection and validation logic,
> >      adding an explicit option to associate each Type 3 device with a CFMWS entry,
> >      or generating CFMWS entries automatically from the configured CXL topology and devices.
> >    - HDM decoder reset sequencing and state reconstruction.
> >      The current implementation prevents the host bridge HDM decoder configuration from being overwritten later in the same reset
> >      by moving the common initialization of the host bridge component registers from the reset path to the realization path.
> >      However, ideally, after the registers have been restored to their reset values, the host bridge HDM decoder configuration
> >      automatically programmed by QEMU should be reconstructed as part of reset processing.
> > 
> > Thanks,
> > 
> > ------
> > 
> > Yukiya Takaki (7):
> >   QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
> >   QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
> >   QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
> >   QEMU/hw/cxl: auto‑program HDM decoders for CXL Type 3
> >   QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
> >   QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
> >   add CXL Type 3 memory ranges to SRAT
> > 
> >  hw/acpi/cxl_type3.c                 |  30 +++++
> >  hw/acpi/meson.build                 |   1 +
> >  hw/arm/cxl.c                        |  10 ++
> >  hw/arm/meson.build                  |   2 +
> >  hw/cxl/cxl-host.c                   |  63 ++++++++++
> >  hw/i386/acpi-build.c                |   7 ++
> >  hw/i386/cxl.c                       |  11 ++
> >  hw/i386/meson.build                 |   1 +
> >  hw/i386/pc.c                        |   2 +
> >  hw/mem/cxl_type3.c                  | 177 ++++++++++++++++++++++++++++
> >  hw/pci-bridge/pci_expander_bridge.c |  13 +-
> >  include/hw/cxl/cxl.h                |   2 +
> >  include/hw/cxl/cxl_device.h         |   6 +
> >  include/hw/cxl/cxl_host.h           |   3 +
> >  include/hw/mem/cxl_type3.h          |   8 ++
> >  15 files changed, 334 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/acpi/cxl_type3.c
> >  create mode 100644 hw/arm/cxl.c
> >  create mode 100644 hw/i386/cxl.c
> >  create mode 100644 include/hw/mem/cxl_type3.h
> > 
> > -- 
> > 2.52.0
> > 

