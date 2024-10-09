Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2D0CF0433
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syN7J-0000R0-Nq; Tue, 08 Oct 2024 23:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1syN7J-0000Qq-3p
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:12:01 -0400
Received: from mail-sy4aus01olkn2062.outbound.protection.outlook.com
 ([40.92.62.62] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1syN7G-0003dX-Qt
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:12:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFUhF9ByCDWb+aL/274HMjLkBiJR425qFvUMM3ccnTDFrIYxBsw1IQw14vkNe10500aYkJpq3969VQqPXNwzYQEWersZQr6xmq+tlgh/RJHIE2tdwok8JhxEy86Xot4wevaphZe1vVhhahu6SrflHXT5nY+EBD15G3WM9Yfjmmt+aFTgAXGFawCK3XVBTfZ4JcuIUolr0grV5FdOnTsEZnMVkHSz+cxlLHOgaScnEezkQNT4bR7RSiEnqwz5fFwel7jZtQxPqJM5KezxLjo39kGsVvcJ3m4XrHiZKxSQ9fqCt2HzQBGitXytTZfcC2SzuQcD+g/Dru1Snc95yQtAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XIIERdXRhzI/FTSS7e6eSrru89Z1g5VgSDYCOFnv3I=;
 b=Nz/N0R6RH+nSXU5R6IyFMwNbVMzN8lHhN3H5n4vpYojxLdKu+AfNmYI+HpsLc2cPaY82wqawIo57P8hdNMkQ0W0oAceRS82/W1vQYW4vqZrahv4xmJqua9qliqIo/QHBC/K45FHEjJMOYAkm5GeGsWhCe6Yf5IGOFGkI1RR4y/loxHKsCXqMdyrVvPHSPajSlhwL/u4UAzMNLjOyX38MVFJ5mpdoZtkCoxcWN5PNhDQLouRrtQnELmJjkln+n9qvneSQQ80p3mnXn7+cZk8RYm+RnE/EUilFKDYIhWXokOAlrQOMxdwch/djSSxj+1HClmG4QUaE0rKpXA4p9S1bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XIIERdXRhzI/FTSS7e6eSrru89Z1g5VgSDYCOFnv3I=;
 b=clTVyF06u6PCfCDlo0fGXXxaeTDJzREwWkYb1jG2dU8MP0yVrWi5cQxOeZwR1k9N6k3LYDPs9ifXjC5YIL1IfL/AcuQKMnCLeBjWWfGsRYGCIm8TwSOg+hLWySntk+lARmM/QF49xC+mB7KEAcWe476HJ0qvVaG5/K2NdETca+sa0keSyAWxMZPigethLiiFPNNLlZlH8OHRamAgg7k+j2vLSNcvUDFCdolYvcVgNZcJMs83FVWVicNOUVENhCQrlcLFtdIIpknm70IofzCMM8G8RcN/AsDOPDRIEfaEwboh7NgA0LYgaiuLDmrf2sl24xezKrsz5UOKv6+Xq+YH7w==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0585.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 03:06:48 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 03:06:48 +0000
References: <62225479bf3f476496df7c5fbb0b9aa9@baidu.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: "Zuo,Boqun" <zuoboqun@baidu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Gao,Shiyuan" <gaoshiyuan@baidu.com>,
 "david@redhat.com" <david@redhat.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "alxndr@bu.edu" <alxndr@bu.edu>, "peterx@redhat.com"
 <peterx@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Date: Wed, 09 Oct 2024 11:01:43 +0800
In-reply-to: <62225479bf3f476496df7c5fbb0b9aa9@baidu.com>
Message-ID: <SY0P300MB1026F25D8A76CE8A57EACDC3957F2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87set67z5x.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0585:EE_
X-MS-Office365-Filtering-Correlation-Id: b390a16a-bfaf-4dfd-41b3-08dce80f69da
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|5072599009|461199028|8060799006|19110799003|1602099012|10035399004|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 1ivV+q+aOT5sXFhPIqXncWgBN9M7wR3RJJ0b/BCAJk5b4y7evJ91tdvkO18Y+81gfpOcoCaez7gegM1oB2kOYBe2obNxk4xhHHRevxwJemFcYJA4mhTK49fKN6MkOgS3U8zpfKgci0YgezoeEvDQb2y5HITFi/aKVeq4Eowo6eBbp0DLOtHz30fkavRel4PQyOc7J6dYboCWnmmCgigvwKfDEVBeIIQCsU+zgE6CTS37UbJpNd83s/y4AoZElXW8ZL/J7DJGig1KnbgyFKzbyyboOhzNJhopW/wB4qliylJ9sEJt0tbxiOfyS1twrNfm1kpWS0PwiK8Snf6QRW+DuiqA2uHdNDV240okMHMZvIVsph6Sg2SAuwuio55rUrGWTdhmnwPCA5X4G7rU1OCLHUjUZVgjU7igVV/EOCrmD8tOU3A7cuNuR5dzLCryKaudBroDCzlSZlGm4tz2zU6wdDG01xf7TYVB62HQ62yL2VqjP0i4IqopUJIZjdz0OD5UAQPpUX/9Zcrqa6mTVrb4hal0a8UzoGJDUkfd+nXV7BlP43NKOAO9Gy3gYsbQco03FxcoiPBfF9k1aaEao6CJcz2bgZulDLI7AY7bg/P7oLWK8wS139cqc3IBLmFGtoYPC7Ov7YW3kuirzuoks4aRPSER70qeTOLbiELcr7OIxWpTYVKPTJymDfn/Dq15ZxnhVIV6aBUUguE4+KoVe3uBRzv7lLOCw/03t1eJ5M+Op8uyQrTcyIarwg0yoaUzwcoWtO8p7nPLl9denEsJ+Umfkt8Cm4bZQnwx76uA05ffF1RejrULwDagSzfAVulpwQBt9vuhvALWjk/W7CK5fhCBJVvX6a3BY5m3ckeq0KxD4b8mM4uuu1XTNrsfIRb0KjYANkxLH7I1FBaYby17EzfL9Kh1Yi073SCkBJYO64cFJCQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1NIQGoItZMcjQn8oyb5JISFrxZDFKo/OtZRvMK/7TYQDhxRhqX3J9OGCUb5?=
 =?us-ascii?Q?kmhcra5jq/wwwUdx4P0HU45pc1K+MO1LAoxTiWuA5KXN8jOB/Fh8l2iIgbnh?=
 =?us-ascii?Q?khV2QC7xilApHtXa7Wuilg10svFA856mB8IVw8At/hsE1ezVVvsAcUXY/qiq?=
 =?us-ascii?Q?jCAS9i1VKcLAzZG1OryqfQ8ng5+jfDJIjOB6+n4qZuVRzj8BRU0DfDG1gChP?=
 =?us-ascii?Q?hqCEhq5Qn3cs8UmnlCdbMht34+Wa+hk7fmnZHU4TalNCh/AZI3h0wPJxWKSG?=
 =?us-ascii?Q?BnCdQTnKSjm2E/XahgvfMepAYqN6FpgLMhLtHZj2U8iA2HjJ55N7+UIZXpmG?=
 =?us-ascii?Q?VjEGZ0aVtA8GFY4qcBqcMylQ87PaGoAVLvdPUOe7PbS1J5CmaZWP/zBW4b3B?=
 =?us-ascii?Q?IgCXYS64skqk+klRWtnCYQ61Ibx8hHSgOpqErgH8Wg5DZpzKlAYalRFW302E?=
 =?us-ascii?Q?7I4kcVEz6h+/jP8RNJhjIlur1Tfa9TiAyc0HDi9LTyNMPFpS9Yfx6fFzDHHn?=
 =?us-ascii?Q?ipfdLA22kosvS/YMheySmQ/Yh4EUP21uVEDWjLpSoIEHIwM9M52SqMN1YQam?=
 =?us-ascii?Q?HcbAtXuZb5hqFI/ZoB/t+QUVkRqsUP5jvASE3pAkN3Qwkb7iKngVUO80jNEj?=
 =?us-ascii?Q?WKulCsuwzAS0nC0jrAZ+HRgGfegszPaX4OZMvAuqKrVzHpK/4f0U58zy723s?=
 =?us-ascii?Q?hTRd0GeE34dBPNoRC0dlems7nDurhH/hGqkUGrBPAo98T1Zden9sIITTqhBY?=
 =?us-ascii?Q?u4WKITJh2xh0d3KIzUr1PVOKRCSRrhrP+FeXxEGwtBURrVLuOEhM8mEYPuuE?=
 =?us-ascii?Q?I+pYjmjNqgW2WuodSSEDgMIoIdaAvsQol4gHsxdLF0T0zIEDDScZohCQZH3a?=
 =?us-ascii?Q?J0EJ7jGr799gYL7bo9hQsZ7fQh214tyksGrWrkSSUqe0Z1EYmNf0EjLViFvh?=
 =?us-ascii?Q?Yeh4GnOOqfQU5eq5dmIOGYMLmaU5BcK+xu9uzGFjU8hDQ9iCCGPzEpfugjZD?=
 =?us-ascii?Q?0vfQj2w8ngRMgaVjXK4vsUoZJqwqThE4IJ2CqCusvZ1Vd0Nk0g4znB8fa3gE?=
 =?us-ascii?Q?C1Fbm+dgm87mrhaqrYttqrokeHbAhWp4D3vfRR/m/CkLZ9RhldiOWYPsW2WQ?=
 =?us-ascii?Q?bt4I7BIJOImp7WZfNzaIKGWKPkiS+TLqkf5/5oNZTEja4nuai9gM/v0EF3HG?=
 =?us-ascii?Q?Ps9k8JWHfF4fps1QcoPdkwQa8dpve/Jk4VWQBjZMPPujRIuVqYEc8kRWY4w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b390a16a-bfaf-4dfd-41b3-08dce80f69da
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 03:06:48.1382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0585
Received-SPF: pass client-ip=40.92.62.62; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


"Zuo,Boqun" <zuoboqun@baidu.com> writes:

> On Wed, Sep 25, 2024 8:58 PM Junjie Mao wrote:
>> > As shown below, if a virtio PCI device is attached under a pci-bridge,
>> > the MR of VirtIOPCIRegion does not belong to any address space. So
>> > memory_region_find cannot be used to search for this MR.
>> >
>> > Introduce the virtio-pci and pci_bridge_pci address spaces to solve this
>> problem.
>> >
>> > Before:
>> > memory-region: pci_bridge_pci
>> >   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>> >     00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>> >       00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>> >       00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>> >     000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>> >       000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-
>> virtio-blk
>> >       000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-
>> blk
>> >       000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-
>> virtio-blk
>> >       000000a000403000-000000a000403fff (prio 0, i/o):
>> > virtio-pci-notify-virtio-blk
>> >
>> > After:
>> > address-space: pci_bridge_pci
>> >   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>> >     00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
>> >       00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
>> >       00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
>> >     000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>> >       000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-
>> virtio-blk
>> >       000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-
>> blk
>> >       000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-
>> virtio-blk
>> >       000000a000403000-000000a000403fff (prio 0, i/o):
>> > virtio-pci-notify-virtio-blk
>> >
>> > address-space: virtio-pci
>> >   000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
>> >     000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-
>> virtio-blk
>> >     000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>> >     000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-
>> virtio-blk
>> >     000000a000403000-000000a000403fff (prio 0, i/o):
>> > virtio-pci-notify-virtio-blk
>> >
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
>> > Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion
>> > MR")
>> >
>> > Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>> > Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
>> > ---
>> >  hw/pci/pci_bridge.c            | 2 ++
>> >  hw/virtio/virtio-pci.c         | 3 +++
>> >  include/hw/pci/pci_bridge.h    | 1 +
>> >  include/hw/virtio/virtio-pci.h | 1 +
>> >  4 files changed, 7 insertions(+)
>> >
>> > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c index
>> > 6a4e38856d..74683e7445 100644
>> > --- a/hw/pci/pci_bridge.c
>> > +++ b/hw/pci/pci_bridge.c
>> > @@ -380,6 +380,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char
>> *typename)
>> >      sec_bus->map_irq = br->map_irq ? br->map_irq :
>> pci_swizzle_map_irq_fn;
>> >      sec_bus->address_space_mem = &br->address_space_mem;
>> >      memory_region_init(&br->address_space_mem, OBJECT(br),
>> > "pci_bridge_pci", UINT64_MAX);
>> > +    address_space_init(&br->as_mem, &br->address_space_mem,
>> > + "pci_bridge_pci");
>>
>> I don't think this "pci_bridge_pci" address space is necessary. The
>> VirtIOPCIProxy.modern_as AddressSpace is sufficient for
>> memory_region_add() to work.
>
> This is because memory_region_find_rcu () and memory_region_to_address_space() will find the memory container
> on the top level and then get the corresponding address space of it.
> If we only add "VirtIOPCIProxy.modern_as AddressSpace", memory_region_find() still cannot find a address space.
> Because "pci_bridge_pci" is the memory container on top level and it doesn't have a corresponding address space.

Got your point. That address space can help when a so-ill-behaved guest
enables both the bridge and the virtio device, clears the memory base of
secondary bus and then accesses the virtio configurations via the PCI
config access cap. Thanks for the clarification.

As mentioned earlier, you may want to add the I/O space counterparts for
both address spaces, as the cap can target modern I/O BARs (when they
are present) as well.

--
Best Regards
Junjie Mao

