Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1452BC369DF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 13:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stRkN-0006DD-Oh; Wed, 25 Sep 2024 09:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1stRkM-0006Cc-Of
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:07:58 -0400
Received: from mail-sy4aus01olkn20805.outbound.protection.outlook.com
 ([2a01:111:f403:2819::805]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1stRkK-0000lI-Lp
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEueyC9H2Ey0waRJtLTI467jIyOv279XQhY7J8VyzncqL3ENFK1XHiqgtYKrQoabR22X9RvQl6W8uhL00f7x51KzR8WdEGxT4wT8Rj3IYRSs0UtLpN34d6BghhAKfIkDCAT7CSG6GDpFkhN4Cdg0uTOQOImG/XngiJZ2f4ka5dDFjPqDrbNGshb1CNWjFFLiyy6J0QerGl0OgUO6VHHhNAfvMkhUe2u8fwL1dkG/Xg/zeOx5AjHqPXDrsMSeg6F7Koluqp2DuCWpJo+PQKaWpLBXEiUwyuiBKVHKcRxxA4jjv/BWATo1mOYHnb79UHApiYw0HRowqfj9m4JDnQbbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw+yGu2E4Db0G8X+j7rj2V1xW4DPtA+aWYdDVULCCDM=;
 b=jKhUqNSm6NYGBebPJxk/bt5n/B+v9FjIV07cVUib8vlUMvEhUdKDrgrhTso5I/BXw29JPclNHovCCtUpArpeLHQNN6wD/qcwBdDdTGBL/B60ED3Md3wMv9hC8VVtUui33WAslriPjcEnRwz02hK8/oq9qgmPWtnQ7QaKO+YoDXo9XGgJK3uwnr9GlTJC0Z/dtXVV2EIDadr9mR/oP0UKj0mdiuQI7v0VKBi92ZM4GqK34ik7nuoDaOT4pbxrG9hQZA3YGMyrAqKO/vgFvT6q/14WyWAcznFCpDPlBo1MtvFBRehP4zm6wj9VSJoq7tGUJKZk23/+5WytIdNZQATeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw+yGu2E4Db0G8X+j7rj2V1xW4DPtA+aWYdDVULCCDM=;
 b=TjHu6h3xAa21oa9FfGPxVObKznz23mSUOwa+Ume7rhKbleSpVqEWS8likFWNcDXrvZwU/6l7izwMPJw4Lux1Seujycgcd34MXLtaj98B4aVqbphrOYe/0ZAXqh7b2t9K66hyXSya35Pl4fpn/RigcDbaZ6eeYZqjH5kIdLUgCAlOdMs5PpMcN2uKzW9gdxJPevpgygLfgUwzmhilLQN6NEjnm93kwjO+UVGHMjZjN1HZQ2qqdC61dqldnSM8wtcHUeYhvrBdJoOuULO7ZvdLGwudlWyY0upH4/TtLXnWqMcmmaspid/MxOKLf62jnJzflf7RteCXPiZ+4+kQiKuRMA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0661.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 13:07:49 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 13:07:49 +0000
References: <20240924011156.48252-1-gaoshiyuan@baidu.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, zuoboqun@baidu.com, david@redhat.com,
 thuth@redhat.com, alxndr@bu.edu, peterx@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Date: Wed, 25 Sep 2024 20:58:19 +0800
In-reply-to: <20240924011156.48252-1-gaoshiyuan@baidu.com>
Message-ID: <SY0P300MB1026228CEDFEA2F09E0DE0A295692@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87tte3zxt1.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0661:EE_
X-MS-Office365-Filtering-Correlation-Id: 736489f0-48c5-453b-d6c8-08dcdd630e41
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|461199028|19110799003|5072599009|8060799006|15080799006|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info: uwwrGc5H7hjQ8uxRVctjlVOBLJ8g4ImvnGq7Fdvt2aEIY06s/vKcdiUImIkhjFb8oSyDV7+Do78VIKQw1FDbN9+bzfe56v8N8CmEuk1KAAn+T2T/Ilda+jlx0aJF0KSapGSm7ymAzjipcpsTR1WqU8LppuILFmkAUkPrcbuR2MYnnzs89X6mFwr/HZdo+ibTFWkrT5fDdkBd9o/m+FpQ7JUZEBNA4fcKi1LeiB6oa6PUDgsnRLrbIXW0cfzkuoEYnyYAwCDRdbxPrCMk8Z5HeOadb11S2cOSeSTiXa9BOB626gIUf/UKthL/gAQ1OBrkWjnT2BnLnEtfQNoGQ6AY1KOftDyMmemDBovoo2TDM2Bz/jtdnkrNnuB9sSoeq5K0BxOjVLTcAh/GEgKHxPrC6z6YsvboiuqL8cdukWuUMoW2w9nphgJjKCZPrDXGma/MeMl+hwjnla0dgVkaV5xm5+dTAFOMnaod3yUOcSRCkEIa5Sz+RU603v+v0iaJIz4NmCEUskssPZ5fpJWIkjNZv7YaRT2dvZ66oIdIBBfR8QlEmiykACSpb7zI4OaCMHNI3k0yOuEUB6w6Pyp4Bv62x6IqcMmybcYQeuxC0i9NgRmsKhbtw3VjPmqEURKZLBBe0NHQhqe/M7vpTRt8EHSWy9VqZ4Jx+dQzFti9PTJQsVWo9fqEb6AGXS623wWUcrua6PJ6lBBmm0Kf4MWVUkGqDXo//Ysle7JlwUo5pwhRDZvfZlRaTjKN9wgjBm5dAQ62W79OoAfbPt6P5Nl5SbVt9b1XktLNl3mZcWvGr7VT2pRuaLQG16WHsZjMaaz5CAu//mq52OWDU40287TD2MtXWDDbCPvHJopGXhUO5+sBGsqd4X3yhqCkw4iDZGxjX2ILkrDA9yeRHM7Et532Oi9wxQRRzpMcuCWR4o05xUyQW0I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KvjgBsEuPMJ3eIt9ctMteOmohoax1JYuQCzx9lmlCxVVQAZy/BESQTCcxToI?=
 =?us-ascii?Q?WF0Z0PVSEOCk7ZrltAZ7TSg3qqWke1SVwoSuIaPY1s9eXDiSMeQmMlPAyGb4?=
 =?us-ascii?Q?xNNevlUl3Bq6IeDg1gB3+AXiD7lBOrnsStGa9rW4B18wuHtXd9SWjl2va1u1?=
 =?us-ascii?Q?Q5mA4jMZvm4OmjyTJ6EiOs32NN+CnF9Yj1ZxQbbH91JE9EiII0/GOGOoh5Q1?=
 =?us-ascii?Q?kaXAMVDgPOj/W7+ZGqP4am65K8jzKOA/2uzNLZNIGDZauaxH5La7FJmtGqzZ?=
 =?us-ascii?Q?PvTxe2LoLG9NKJnqEt+tzkznyZXTYDFFNvAnCUtVISUee/vp+OMAXAAh/wT2?=
 =?us-ascii?Q?fcXDorGqqiyxMwi0/jMO8StSdlMW1PBiR8IfXt+9HagdNEIJVraNyKpbUUkU?=
 =?us-ascii?Q?wNowaLM/FORVmZj76bjTwa7rNrvSemzR6YxBM/srCSNwG6rfMe7DvnKjd5Va?=
 =?us-ascii?Q?HB0x5Ls5Hii569SN/FvOfxtnZfu6rDBdNZ7QlxLx85ToS7BoYMdO79U6VjeG?=
 =?us-ascii?Q?NZH4XAyFYhWvjv0T2h7jap0lVCfd/2SRUOIxHkCzLQiX3EnWb2qsMukZqimx?=
 =?us-ascii?Q?duHpvrrKBOW4sHg3eCf+AOsmHZSciNKLW4Xgo6ijjofHihNdFV5PuCoC9FaE?=
 =?us-ascii?Q?KUnjBpstE7Z8/xk5VC+HTUuW/CzdLoD3XTm4hrwFnkQEwFk+fW0Be7+dSMmj?=
 =?us-ascii?Q?HpcZG2HoSmLEXaBWczkIBpNJIXCWlqjozDyQ8Vov+P6ygEhEUG6hVt3Q8ppN?=
 =?us-ascii?Q?IelK+tfpIQc08wP+5lFO26hc4cITAafV6K6TApBKk6abXTItbhgj8PPhDK7r?=
 =?us-ascii?Q?7kXYkVBIR6Fsv0/+QmaXP1JOOL2voravtD5oU3Pyluz1jF1r1BcpkcfR05oG?=
 =?us-ascii?Q?GNzhkAKaGaXML9+XSVmdV+rOslTmRhxt66Ar8xeuhiDvQH9z3ClsB79/wkpi?=
 =?us-ascii?Q?V8gGhm4bFOdQuA0Abm0ceCtbwrj7gNYuUIlrTGHEpW/DcdcOwhJGDeM36Xh8?=
 =?us-ascii?Q?twtMrMjwcBqm/kn16+4M22XpOmsefNhbqQKFgL6bUw9VtbVxcTSd1t2B9FVt?=
 =?us-ascii?Q?7stTn3eA6hwEhL6YwSvWayJyyxVvyaFme1imrJ06kGKDO61Ss+QKkltZubXX?=
 =?us-ascii?Q?Fw544bHF41gBjiNl9QdBWnP0xo1BuvJMmcVOd7v3853X0xbEr1BPRyY/PAop?=
 =?us-ascii?Q?hA+tcWw+ZoUnZLNSWwS18OQTXyTaUcoOmEgKhxKR6ncOU8FjTai5748SYnA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 736489f0-48c5-453b-d6c8-08dcdd630e41
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:07:49.2854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0661
Received-SPF: pass client-ip=2a01:111:f403:2819::805;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Gao Shiyuan via <qemu-devel@nongnu.org> writes:

> As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
> of VirtIOPCIRegion does not belong to any address space. So memory_region_find
> cannot be used to search for this MR.
>
> Introduce the virtio-pci and pci_bridge_pci address spaces to solve this problem.
>
> Before:
> memory-region: pci_bridge_pci
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>       00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>       00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>     000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>       000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>       000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>       000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>       000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>
> After:
> address-space: pci_bridge_pci
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>       00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>       00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>     000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>       000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>       000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>       000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>       000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>
> address-space: virtio-pci
>   000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>     000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
>     000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>     000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
>     000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> ---
>  hw/pci/pci_bridge.c            | 2 ++
>  hw/virtio/virtio-pci.c         | 3 +++
>  include/hw/pci/pci_bridge.h    | 1 +
>  include/hw/virtio/virtio-pci.h | 1 +
>  4 files changed, 7 insertions(+)
>
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 6a4e38856d..74683e7445 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -380,6 +380,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
>      sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
>      sec_bus->address_space_mem = &br->address_space_mem;
>      memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
> +    address_space_init(&br->as_mem, &br->address_space_mem, "pci_bridge_pci");

I don't think this "pci_bridge_pci" address space is necessary. The
VirtIOPCIProxy.modern_as AddressSpace is sufficient for
memory_region_add() to work.

>      sec_bus->address_space_io = &br->address_space_io;
>      memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
>                         4 * GiB);
> @@ -399,6 +400,7 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
>      PCIBridge *s = PCI_BRIDGE(pci_dev);
>      assert(QLIST_EMPTY(&s->sec_bus.child));
>      QLIST_REMOVE(&s->sec_bus, sibling);
> +    address_space_destroy(&s->as_mem);
>      pci_bridge_region_del(s, &s->windows);
>      pci_bridge_region_cleanup(s, &s->windows);
>      /* object_unparent() is called automatically during device deletion */
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 4d832fe845..502b9751dc 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2180,6 +2180,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>                         /* PCI BAR regions must be powers of 2 */
>                         pow2ceil(proxy->notify.offset + proxy->notify.size));
>
> +    address_space_init(&proxy->modern_as, &proxy->modern_bar, "virtio-pci");

Can we add some suffix to the address space name so that we can tell
them apart when there are multiple virtio devices created?

> +
>      if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
>          proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }
> @@ -2275,6 +2277,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
>          pci_is_express(pci_dev)) {
>          pcie_aer_exit(pci_dev);
>      }
> +    address_space_destroy(&proxy->modern_as);
>  }
>
>  static void virtio_pci_reset(DeviceState *qdev)
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 5cd452115a..2e807760e4 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -72,6 +72,7 @@ struct PCIBridge {
>       */
>      MemoryRegion address_space_mem;
>      MemoryRegion address_space_io;
> +    AddressSpace as_mem;
>
>      PCIBridgeWindows windows;
>
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 9e67ba38c7..fddceaaa47 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -147,6 +147,7 @@ struct VirtIOPCIProxy {
>      };
>      MemoryRegion modern_bar;
>      MemoryRegion io_bar;
> +    AddressSpace modern_as;

How about naming it "config_as" or "config_mem_as"? While the PCI
configuration access capability is specific to modern devices, what it
maps (and only maps) are the virtio config regions.

Also, we may need another "config_io_as" for the port I/O mapped
notification config region.

>      uint32_t legacy_io_bar_idx;
>      uint32_t msix_bar_idx;
>      uint32_t modern_io_bar_idx;

--
Best Regards
Junjie Mao

