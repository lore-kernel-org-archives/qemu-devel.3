Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3829EED60A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sokZd-0004DU-6i; Thu, 12 Sep 2024 10:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sokZc-0004Cv-AE
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:13:28 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sokZZ-000472-L1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:13:28 -0400
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1C59E11404DA;
 Thu, 12 Sep 2024 10:13:23 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Thu, 12 Sep 2024 10:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1726150403;
 x=1726236803; bh=BM3fGlpxltJdI5x/JFAlbV2j6kw7AJv1Z4ErZJlh9Hs=; b=
 pbibKE1322S8RttHYUyZHmt6UdH76vvKtaJRNX4eO6qaAYTxHoRKdMVmtOg2/nRW
 CmVECxbWXKYXLUECHtl0FInluBo89Rege5QUfBZ6iUBkdm4JlVwSAlnQN1jfYVBY
 LlsmCbcjmqOVmGnivhY6le+2DjecY9LthZiEHPAANUj8Ni1ye+dlzU9MdPfRVwlc
 IIGZGUtc76XgYI9u5lxTEa+xQJEn9NmO/l3KX6CFqJCpTi8VGfZipqTApGOstgOl
 V/nZ7w6Xf8NsWqwjNQ3qGePQ7VNGvZnXxFOkkFfSKcGOaJKgowE3bMe74oNxXrQm
 9Bnjs03+Z/MynJtEYOKy+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726150403; x=
 1726236803; bh=BM3fGlpxltJdI5x/JFAlbV2j6kw7AJv1Z4ErZJlh9Hs=; b=G
 oX9vWCzOF17UlNiJbjlhgBpn829ODirFE6JEP4QUvzZs+WOA+UwK8oCsLzu7jmbZ
 KCEDLQVq+JkMx840xhv2n3bWeVhwWFRSs+McmAWH0FmgzllGxSbPufpGzXy+UOEn
 doIPbJPLCUXBW581uggKIPZdKDCF+ckdL2HVwPcL1bFkO8zjeZChTXHR8YVXSUe7
 uTLgLl5gkBy1h4gq1M6u8/U2oAGqQ/yg53Mg9URlVm4lSMA+G23oAkVneghksPa4
 M09PZ21r/GkDiG/goINgJ6mHcBpEqyw47a+hRbbCudUF8wdnYOPvHJM416W5eWo0
 8t3pxk/DxUzXly3n1T9iQ==
X-ME-Sender: <xms:AvfiZnxmw6uJHt_lHTr5gpLoyBVHQHyOOgO_EfP6BUPi5apxZHRM8w>
 <xme:AvfiZvQmjPpwugzI4GeVymJakuaPBljhfngJ96xeUkv_SHS2tmGHyx8DMpAc2TCz5
 yLpqPnzkaL1bjL8Gvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrgho
 shhonhhgsehlohhonhhgshhonhdrtghnpdhrtghpthhtoheplhhigihirghnghhlrghise
 hlohhonhhgshhonhdrtghnpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhsohhn
 rdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:AvfiZhUm_BBWMH0Fa--7oeSG0Qtdu3W4kXdqOTWCFOgMdRb7tBl84A>
 <xmx:AvfiZhiB0lu2llRqSHDGHwrDyk59-1yFD-lLlwd3WWuHgmcI54ZY6w>
 <xmx:AvfiZpBLAEeRETSSjRvEz4Z6apVYpru-UCp62ARen3cHBDBt7Vshbg>
 <xmx:AvfiZqIoqoirPWWRgagdBI3HX2q4HeULU91xsTXi8OedD-ItXLiMKA>
 <xmx:A_fiZk_JzuMJyyVft0UiPo_yG_vb7CrMHsiPlWFRVmKYhfeIEYOu54d1>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 874741C20065; Thu, 12 Sep 2024 10:13:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 12 Sep 2024 15:13:01 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Xianglai Li" <lixianglai@loongson.cn>,
 "QEMU devel" <qemu-devel@nongnu.org>, "Bibo Mao" <maobibo@loongson.cn>
Cc: "Song Gao" <gaosong@loongson.cn>, "Huacai Chen" <chenhuacai@kernel.org>
Message-Id: <5374ab19-3b27-431c-97f9-dc23d85fae5a@app.fastmail.com>
In-Reply-To: <2182eb694629ee3f2859e441b8076d62d3606ee2.1725969898.git.lixianglai@loongson.cn>
References: <cover.1725969898.git.lixianglai@loongson.cn>
 <2182eb694629ee3f2859e441b8076d62d3606ee2.1725969898.git.lixianglai@loongson.cn>
Subject: Re: [RFC PATCH V2 1/5] include: Add macro definitions needed for
 interrupt controller kvm emulation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B49=E6=9C=8810=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=881:18=EF=BC=8CXianglai Li=E5=86=99=E9=81=93=EF=BC=9A
> Add macro definitions needed for interrupt controller kvm emulation.

Hi Xianglai and other LoongArch folks,

As I can see your recent works had enabled IOCSR to be treated like a ad=
dress
space, should we migrate IOCSR stuff to iofd/eventfd infra?

Thanks
- Jiaxun

>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
>
>  include/hw/intc/loongarch_extioi.h    | 38 ++++++++++++++++--
>  include/hw/intc/loongarch_ipi.h       | 15 +++++++
>  include/hw/intc/loongarch_pch_pic.h   | 58 +++++++++++++++++++++++++--
>  include/hw/intc/loongson_ipi.h        |  1 -
>  include/hw/intc/loongson_ipi_common.h |  2 +
>  include/hw/loongarch/virt.h           | 15 +++++++
>  linux-headers/asm-loongarch/kvm.h     | 18 +++++++++
>  linux-headers/linux/kvm.h             |  6 +++
>  8 files changed, 146 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/intc/loongarch_extioi.h=20
> b/include/hw/intc/loongarch_extioi.h
> index 626a37dfa1..97f6aa4d60 100644
> --- a/include/hw/intc/loongarch_extioi.h
> +++ b/include/hw/intc/loongarch_extioi.h
> @@ -15,7 +15,7 @@
>  #define EXTIOI_IRQS                (256)
>  #define EXTIOI_IRQS_BITMAP_SIZE    (256 / 8)
>  /* irq from EXTIOI is routed to no more than 4 cpus */
> -#define EXTIOI_CPUS                (4)
> +#define EXTIOI_CPUS                (256)
>  /* map to ipnum per 32 irqs */
>  #define EXTIOI_IRQS_IPMAP_SIZE     (256 / 32)
>  #define EXTIOI_IRQS_COREMAP_SIZE   256
> @@ -36,7 +36,7 @@
>  #define EXTIOI_ISR_START             (0x700 - APIC_OFFSET)
>  #define EXTIOI_ISR_END               (0x720 - APIC_OFFSET)
>  #define EXTIOI_COREISR_START         (0x800 - APIC_OFFSET)
> -#define EXTIOI_COREISR_END           (0xB20 - APIC_OFFSET)
> +#define EXTIOI_COREISR_END           (0x820 - APIC_OFFSET)
>  #define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
>  #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
>  #define EXTIOI_SIZE                  0x800
> @@ -64,7 +64,8 @@ typedef struct ExtIOICore {
>      qemu_irq parent_irq[LS3A_INTC_IP];
>  } ExtIOICore;
>=20
> -#define TYPE_LOONGARCH_EXTIOI "loongarch.extioi"
> +#define TYPE_LOONGARCH_EXTIOI        "loongarch-extioi"
> +#define TYPE_KVM_LOONGARCH_EXTIOI    "loongarch-kvm-extioi"
>  OBJECT_DECLARE_SIMPLE_TYPE(LoongArchExtIOI, LOONGARCH_EXTIOI)
>  struct LoongArchExtIOI {
>      SysBusDevice parent_obj;
> @@ -86,4 +87,35 @@ struct LoongArchExtIOI {
>      MemoryRegion extioi_system_mem;
>      MemoryRegion virt_extend;
>  };
> +
> +struct KVMLoongArchExtIOI {
> +    SysBusDevice parent_obj;
> +    uint32_t num_cpu;
> +    uint32_t features;
> +    uint32_t status;
> +
> +    /* hardware state */
> +    uint32_t nodetype[EXTIOI_IRQS_NODETYPE_COUNT / 2];
> +    uint32_t bounce[EXTIOI_IRQS_GROUP_COUNT];
> +    uint32_t isr[EXTIOI_IRQS / 32];
> +    uint32_t coreisr[EXTIOI_CPUS][EXTIOI_IRQS_GROUP_COUNT];
> +    uint32_t enable[EXTIOI_IRQS / 32];
> +    uint32_t ipmap[EXTIOI_IRQS_IPMAP_SIZE / 4];
> +    uint32_t coremap[EXTIOI_IRQS / 4];
> +    uint8_t  sw_coremap[EXTIOI_IRQS];
> +};
> +typedef struct KVMLoongArchExtIOI KVMLoongArchExtIOI;
> +DECLARE_INSTANCE_CHECKER(KVMLoongArchExtIOI, KVM_LOONGARCH_EXTIOI,
> +                         TYPE_KVM_LOONGARCH_EXTIOI)
> +
> +struct KVMLoongArchExtIOIClass {
> +    SysBusDeviceClass parent_class;
> +    DeviceRealize parent_realize;
> +
> +    bool is_created;
> +    int dev_fd;
> +};
> +typedef struct KVMLoongArchExtIOIClass KVMLoongArchExtIOIClass;
> +DECLARE_CLASS_CHECKERS(KVMLoongArchExtIOIClass, KVM_LOONGARCH_EXTIOI,
> +                       TYPE_KVM_LOONGARCH_EXTIOI)
>  #endif /* LOONGARCH_EXTIOI_H */
> diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongar=
ch_ipi.h
> index 276b3040a3..64ebbdcba6 100644
> --- a/include/hw/intc/loongarch_ipi.h
> +++ b/include/hw/intc/loongarch_ipi.h
> @@ -22,4 +22,19 @@ struct LoongarchIPIClass {
>      LoongsonIPICommonClass parent_class;
>  };
>=20
> +#define TYPE_KVM_LOONGARCH_IPI  "kvm_loongarch_ipi"
> +
> +OBJECT_DECLARE_TYPE(KVMLoongarchIPIState,
> +                    KVMLoongArchIPIClass, KVM_LOONGARCH_IPI)
> +
> +struct KVMLoongarchIPIState {
> +    LoongsonIPICommonState parent_obj;
> +    int dev_fd;
> +};
> +
> +struct KVMLoongArchIPIClass {
> +   LoongsonIPICommonClass parent_class;
> +   DeviceRealize parent_realize;
> +    DeviceUnrealize parent_unrealize;
> +};
>  #endif
> diff --git a/include/hw/intc/loongarch_pch_pic.h=20
> b/include/hw/intc/loongarch_pch_pic.h
> index d5437e88f2..bbde9e6de9 100644
> --- a/include/hw/intc/loongarch_pch_pic.h
> +++ b/include/hw/intc/loongarch_pch_pic.h
> @@ -5,9 +5,13 @@
>   * Copyright (c) 2021 Loongson Technology Corporation Limited
>   */
>=20
> +#ifndef LOONGARCH_PCH_PIC_H
> +#define LOONGARCH_PCH_PIC_H
> +
>  #include "hw/sysbus.h"
>=20
> -#define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
> +#define TYPE_LOONGARCH_PCH_PIC          "loongarch_pch_pic"
> +#define TYPE_KVM_LOONGARCH_PCH_PIC      "loongarch_kvm_pch_pic"
>  #define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
>  OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
>=20
> @@ -28,15 +32,26 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC,=20
> LOONGARCH_PCH_PIC)
>  #define PCH_PIC_AUTO_CTRL0_HI           0xc4
>  #define PCH_PIC_AUTO_CTRL1_LO           0xe0
>  #define PCH_PIC_AUTO_CTRL1_HI           0xe4
> -#define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
> +#define PCH_PIC_ROUTE_ENTRY_START       0x100
>  #define PCH_PIC_ROUTE_ENTRY_END         0x13f
> -#define PCH_PIC_HTMSI_VEC_OFFSET        0x200
> +#define PCH_PIC_HTMSI_VEC_START         0x200
>  #define PCH_PIC_HTMSI_VEC_END           0x23f
>  #define PCH_PIC_INT_STATUS_LO           0x3a0
>  #define PCH_PIC_INT_STATUS_HI           0x3a4
>  #define PCH_PIC_INT_POL_LO              0x3e0
>  #define PCH_PIC_INT_POL_HI              0x3e4
>=20
> +#define PCH_PIC_INT_ID_START            PCH_PIC_INT_ID_LO
> +#define PCH_PIC_MASK_START              PCH_PIC_INT_MASK_LO
> +#define PCH_PIC_HTMSI_EN_START          PCH_PIC_HTMSI_EN_LO
> +#define PCH_PIC_EDGE_START              PCH_PIC_INT_EDGE_LO
> +#define PCH_PIC_CLEAR_START             PCH_PIC_INT_CLEAR_LO
> +#define PCH_PIC_AUTO_CTRL0_START        PCH_PIC_AUTO_CTRL0_LO
> +#define PCH_PIC_AUTO_CTRL1_START        PCH_PIC_AUTO_CTRL1_LO
> +#define PCH_PIC_INT_IRR_START           0x380
> +#define PCH_PIC_INT_ISR_START           PCH_PIC_INT_STATUS_LO
> +#define PCH_PIC_POLARITY_START          PCH_PIC_INT_POL_LO
> +
>  #define STATUS_LO_START                 0
>  #define STATUS_HI_START                 0x4
>  #define POL_LO_START                    0x40
> @@ -67,3 +82,40 @@ struct LoongArchPCHPIC {
>      MemoryRegion iomem8;
>      unsigned int irq_num;
>  };
> +
> +struct KVMLoongArchPCHPIC {
> +    SysBusDevice parent_obj;
> +    uint64_t int_mask; /*0x020 interrupt mask register*/
> +    uint64_t htmsi_en; /*0x040 1=3Dmsi*/
> +    uint64_t intedge; /*0x060 edge=3D1 level  =3D0*/
> +    uint64_t intclr; /*0x080 for clean edge int,set 1 clean,set 0 is =
noused*/
> +    uint64_t auto_crtl0; /*0x0c0*/
> +    uint64_t auto_crtl1; /*0x0e0*/
> +    uint64_t last_intirr;    /* edge detection */
> +    uint64_t intirr; /* 0x380 interrupt request register */
> +    uint64_t intisr; /* 0x3a0 interrupt service register */
> +    /*
> +     * 0x3e0 interrupt level polarity selection
> +     * register 0 for high level trigger
> +     */
> +    uint64_t int_polarity;
> +
> +    uint8_t route_entry[64]; /*0x100 - 0x138*/
> +    uint8_t htmsi_vector[64]; /*0x200 - 0x238*/
> +};
> +typedef struct KVMLoongArchPCHPIC KVMLoongArchPCHPIC;
> +DECLARE_INSTANCE_CHECKER(KVMLoongArchPCHPIC, KVM_LOONGARCH_PCH_PIC,
> +                         TYPE_KVM_LOONGARCH_PCH_PIC)
> +
> +struct KVMLoongArchPCHPICClass {
> +    SysBusDeviceClass parent_class;
> +    DeviceRealize parent_realize;
> +
> +    bool is_created;
> +    int dev_fd;
> +};
> +typedef struct KVMLoongArchPCHPICClass KVMLoongArchPCHPICClass;
> +DECLARE_CLASS_CHECKERS(KVMLoongArchPCHPICClass, KVM_LOONGARCH_PCH_PIC,
> +                       TYPE_KVM_LOONGARCH_PCH_PIC)
> +
> +#endif /* LOONGARCH_PCH_PIC_H */
> diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson=
_ipi.h
> index 4e517cc8dc..57e0d94e2b 100644
> --- a/include/hw/intc/loongson_ipi.h
> +++ b/include/hw/intc/loongson_ipi.h
> @@ -27,5 +27,4 @@ struct LoongsonIPIState {
>=20
>      MemoryRegion *ipi_mmio_mem;
>  };
> -
>  #endif
> diff --git a/include/hw/intc/loongson_ipi_common.h=20
> b/include/hw/intc/loongson_ipi_common.h
> index df9d9c5168..adba8ffd49 100644
> --- a/include/hw/intc/loongson_ipi_common.h
> +++ b/include/hw/intc/loongson_ipi_common.h
> @@ -45,6 +45,8 @@ struct LoongsonIPICommonClass {
>      DeviceUnrealize parent_unrealize;
>      AddressSpace *(*get_iocsr_as)(CPUState *cpu);
>      CPUState *(*cpu_by_arch_id)(int64_t id);
> +    void (*pre_save)(LoongsonIPICommonState *s);
> +    void (*post_load)(LoongsonIPICommonState *s, int version_id);
>  };
>=20
>  MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64=
_t *data,
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index c373e48f27..c1769fc20c 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -36,6 +36,21 @@
>=20
>  #define FDT_BASE                0x100000
>=20
> +/* KVM_IRQ_LINE irq field index values */
> +#define KVM_LOONGARCH_IRQ_TYPE_SHIFT            24
> +#define KVM_LOONGARCH_IRQ_TYPE_MASK             0xff
> +#define KVM_LOONGARCH_IRQ_VCPU_SHIFT            16
> +#define KVM_LOONGARCH_IRQ_VCPU_MASK             0xff
> +#define KVM_LOONGARCH_IRQ_NUM_SHIFT             0
> +#define KVM_LOONGARCH_IRQ_NUM_MASK              0xffff
> +
> +/* irq_type field */
> +#define KVM_LOONGARCH_IRQ_TYPE_CPU_IP           0
> +#define KVM_LOONGARCH_IRQ_TYPE_CPU_IO           1
> +#define KVM_LOONGARCH_IRQ_TYPE_HT               2
> +#define KVM_LOONGARCH_IRQ_TYPE_MSI              3
> +#define KVM_LOONGARCH_IRQ_TYPE_IOAPIC           4
> +
>  struct LoongArchVirtMachineState {
>      /*< private >*/
>      MachineState parent_obj;
> diff --git a/linux-headers/asm-loongarch/kvm.h=20
> b/linux-headers/asm-loongarch/kvm.h
> index f9abef3823..e102d500a3 100644
> --- a/linux-headers/asm-loongarch/kvm.h
> +++ b/linux-headers/asm-loongarch/kvm.h
> @@ -108,4 +108,22 @@ struct kvm_iocsr_entry {
>  #define KVM_IRQCHIP_NUM_PINS	64
>  #define KVM_MAX_CORES		256
>=20
> +#define KVM_DEV_LOONGARCH_IPI_GRP_REGS		        0x40000001
> +
> +#define KVM_DEV_LOONGARCH_EXTIOI_GRP_REGS	        0x40000002
> +
> +#define KVM_DEV_LOONGARCH_EXTIOI_GRP_SW_STATUS	        0x40000003
> +#define KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_NUM_CPU   	0x0
> +#define KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_FEATURE   	0x1
> +#define KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE   	0x2
> +
> +#define KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL	        0x40000004
> +#define KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_NUM_CPU   	0x0
> +#define KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_FEATURE 	0x1
> +#define KVM_DEV_LOONGARCH_EXTIOI_CTRL_LOAD_FINISHED   	0x3
> +
> +#define KVM_DEV_LOONGARCH_PCH_PIC_GRP_REGS	        0x40000005
> +#define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL	        0x40000006
> +#define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT	        0
> +
>  #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index c93876ca0b..cd2aed735c 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1138,6 +1138,12 @@ enum kvm_device_type {
>  #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
>  	KVM_DEV_TYPE_RISCV_AIA,
>  #define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
> +	KVM_DEV_TYPE_LOONGARCH_PCH_PIC,
> +#define KVM_DEV_TYPE_LOONGARCH_PCH_PIC  KVM_DEV_TYPE_LOONGARCH_PCH_PIC
> +	KVM_DEV_TYPE_LOONGARCH_IPI,
> +#define KVM_DEV_TYPE_LOONGARCH_IPI      KVM_DEV_TYPE_LOONGARCH_IPI
> +	KVM_DEV_TYPE_LOONGARCH_EXTIOI,
> +#define KVM_DEV_TYPE_LOONGARCH_EXTIOI   KVM_DEV_TYPE_LOONGARCH_EXTIOI
>  	KVM_DEV_TYPE_MAX,
>  };
>=20
> --=20
> 2.39.1

--=20
- Jiaxun

