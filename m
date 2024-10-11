Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84816CFD30C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 10:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szCXm-0004Ym-MO; Fri, 11 Oct 2024 06:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1szCXk-0004YJ-CF
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:06:44 -0400
Received: from mail-me3aus01olkn2093.outbound.protection.outlook.com
 ([40.92.63.93] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1szCXi-0007vr-LD
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:06:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M82WpN9i5E2eoL3JIa7RQQZRkemQAYvQ/QbGNDMg9SQjymxukqDfzDKfYJRRO8A70lnZOIrWfdv9Dnj6nDKy11tXQHFUU9YXvSkfztwn9p7EPelUJvd7oh5Yr7zxFO59yHw9H/pdnaOoni1BDOHDxW5oIeyO242prJMxk5t6IyQLoVQ+f/XHMa9TC1u44Id/33i/Zn/44m1e4aB16bBylg7eX37yWsEmvtgFaoEIZp9hbj0h9wWLZaZ1eVmLE8uNJ1u4o5xhfLU38ULcNpRjzzqVV5m4m2vd5wFiLiMUjGxVhoDFccPNoUijq6ns0ubltOyWC9uBnPk2aVgeDGpLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbBrsQjMq73hi4s1z7iIC1pvF/4Rt09/xlmfmYPhavw=;
 b=HjVMaMAa8O33dSqpnhux/yB9Rl07Bx1WTsWtrDW1QEMhuPDmoALIZnydNlUlPwRpp246MeoouT9jE/KdoKloIxNkZrHaUfjPh2FFG02GFVYIr6olaAvR/JgQE33cnDIphKUQysE/h6lt1VoronHZ2NZrcDmuj+KjxSKZnCugsumwQHsPDto0NS0VAPddGkrbirbfsXghFD7KAn69Xd4ugg7jHKrrbp7k99EpPeYsZ68ZOW+80JGwYTFFy2dIbO0/hNG40xKV0bqCjcf3VQ9WNPJMBzjRLix8mV3XVafIsalsIo8y6zI3wCDJDwsiUf9tRHL2o02byrvNq0F1TpkTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbBrsQjMq73hi4s1z7iIC1pvF/4Rt09/xlmfmYPhavw=;
 b=quuun1abvg35eSCw6EsIIuDFE+RVwnrSOWOSpO8GJ6/FJNnpRSa2ejBHRDAdlfZQz1TZ9I7DJv5qJPeI6MQc6E55hZBjRc6gC/et5iv1f9qp8mrq2tWevwzc8L+am0VEKh9CeFLlgbilECQte9+oWaHDHmTglR/WKfGrXvrJiaaGcXq4CPry/WGINeRqdiosL7dcQOMqgJqkjQi6Kea5TGf7vVvZg1ySlYR1QAwZPI5fctErMPtUbm5oCDsXraLF922TW4tEsXjJWhREyrBw4+kIo7PQqKHT0iYyXkt5riKBcWqz9nutjILg/TnQb+MY086hH7Zjc557D3dyFi2Ahw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 10:01:29 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 10:01:29 +0000
References: <20241009095827.67393-1-gaoshiyuan@baidu.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, zuoboqun@baidu.com, david@redhat.com,
 wangliang44@baidu.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Date: Fri, 11 Oct 2024 18:00:35 +0800
In-reply-to: <20241009095827.67393-1-gaoshiyuan@baidu.com>
Message-ID: <SY0P300MB10261082CF8E7DF9F530975095792@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87cyk7yn4l.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0282:EE_
X-MS-Office365-Filtering-Correlation-Id: 2404f6b6-3459-47e4-183d-08dce9dbacef
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|8060799006|19110799003|15080799006|461199028|5072599009|1602099012|10035399004|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info: CUXGeKejjJNLpNxDaCXO7j/DQwXV2aGe+xSeG6jVbfAm7+hXquf8YRnO7HldDS1ICAtWkMCUglDRc7HgdrnUpa7KRfOtFpnOaxprLZ2lOeEWoxeTF3IKqAF6u48ViQzREq3qy9jGbLqzysWC6mUdYxN9KOmJPVifUWnLcrZ3P64U/KL6i44j2X4MBHQdDh/jC43vkAC0CLsFYmY0dHmWCT89O5nBPaJJekYCZsZKqNvkM1uc7YN04Ps2lMD6JzsfBxOz8ljNK+qVI9EQOQTYPYfOVird4jRRqRJZ6NT0oApYLmL7POlDgsJwpFn3ZKO7mLgo4JDauWhGylmNT6bKYIy7bd1M5q9Ob934f8iX8xNuzTXoFAjVy0Z0iqFRUdkOJ9ODbbdJAsMKKkJ/z5c8t0lVbah16TKdSlBSG9A7aik7ueKcnWqF7olKIY/tcU1PiwIHMzBxEPpoBEuMTBkROWPmCWEDg73jgN189TlRjtcY+IbLM71+79q0zsYPS3R3rQOoQagL0rnLyJHn3DPzN2BICIqCM7lTvrK1vHKy4b53nyAiEI6kVShXLGK5Q3ICQTTbi9V1AJqYZcDX8ft9y43INaRAq76QWHR0R5jK+LFnzz60vCu+zotnBrv4AreeUXbgbXqFB7v1eTCiFprS4m99yrRBtI4nZmjZNrkiHzf25IfpzAq9zlQyYrBLZDyNZiPAj/ivMp4WyfGiFXBLJlW2For5ChoJW7sabc0MlW2sbGO/rC3LDSZ1ykpIb1P2kuSZ0gZfGemM4RluXYp7NXAtRpO6mecIG327T7OF2lNuZt4fH1sFU+72midTdTkoomeivxb650yLUoQLoFN3jagBEwPZlsGsiSGqEQqd8c9CoQtN27wocUh6j5SyJLOXMVRLDVVb1vdB/Dje84kpz+uP6izcyay0doBz+63+1WM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hB9Z1yAEHvrrI7eX1XvdiTyCNlQi4R0kiVyrlhEvBSOtH5xmGYl5bmN7fq+z?=
 =?us-ascii?Q?Bg8M/hLv+H8NLY/OGL6hvpu0H65ZSw4PonmUG+SOPIWrPpFXEOxf4P9qY/sc?=
 =?us-ascii?Q?7WHZNmVCjUKqEQCXMb6QUeVwddGvHap7fsEa6sdPwr+66cDaGlWJfFH9kgr3?=
 =?us-ascii?Q?4vxN5o0+iwDdd1wOF74oTsfS9MRqoSkRCuUFBs10CtPGrWu0j9e7lNTSlc8S?=
 =?us-ascii?Q?2qzZ0U4Rb1ucu1/wCpSjTzj65yKYhjkVhVzwluSdIXk4cZc0a8ugg94OHKSa?=
 =?us-ascii?Q?LdqR/ir2WwbnsSE7HUNCau5idholsePVoKpS4oJngSXoTGaH1uMGQ4598B71?=
 =?us-ascii?Q?eRFLP8e2fBpbLpceDOqLXiMgPyqiUcuk/NH6KIxtVwB6Dpjp4e5o74WgpmFa?=
 =?us-ascii?Q?19Vp9uL+HIMpEoSSdJaQuUXcaTZvbQR1T+2OP3Il8xdn1GSKlvMbxUCjAQuQ?=
 =?us-ascii?Q?PQt5b02H0hlbwOthX4nwOgW6URSjvYENWCbjai3Xd6rW9EHdLAZKZexQLiJo?=
 =?us-ascii?Q?DsFYhFtdOdNpwI0Sq98OKyLXZRT+tEeu4pq3C8JX3gb/s3tmXiGAjnxVKVjH?=
 =?us-ascii?Q?gtzPcl/NOrKdbLDRuvw3X5hU1C1fJT+M/IZd7KaaOS85Q5eUcGgjyLMpCTP3?=
 =?us-ascii?Q?KILudecxdFF64fnR0oZ8bqKJ8QvB2pb6vsEt7R9SGgfYmbxakYhceieLh81D?=
 =?us-ascii?Q?oLtjbvXOJ/aqkvqKkU6p/QdXyBwtBdVrlh0dcwDdgtOTu34UlGO8vodAhtiD?=
 =?us-ascii?Q?+4darrG0sEzapSQmpM6WEcprjGavLuiyAA7vkmc/BcrC7XjxayRWjf7KGaol?=
 =?us-ascii?Q?VISMXRIoKXpVCSMroK/ss9whUvni1b/OrRwWMq/WNXjalvx49m0mIX05cV/i?=
 =?us-ascii?Q?1e8M0mvyhMCIArGRp5e4rpbeIktvS9VBMMjPBK1UE0nf8+3VfJ+nTJ7hHhE0?=
 =?us-ascii?Q?hkncIJ86hy9dzAAWWeWtr2f1+mHuSyrmDrzBtizzmR0eUpVQrQQd7DW7unPH?=
 =?us-ascii?Q?q++9ey+Kae59y+F/dRc5s4aomuzQuyNnaWEvMaN3b7Lgw5aAA1cbKMkdZlhR?=
 =?us-ascii?Q?OEr4fp7dg2zYWKYt9a8OZ5CO0ejdBgIAUjrdRtJooLNQz+O4iDT/23ubpciH?=
 =?us-ascii?Q?sP1KH8qzBzGJLqzs+K+r/amQ2wOWiR2Nid6MhQ0Rzz7nHq5/trcRcNE7JKaU?=
 =?us-ascii?Q?FYIOmkCLtvqlh7V3jGWglx1j752xN/nSfOJZeegHuISrxFaVbw2EpwqU1KA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2404f6b6-3459-47e4-183d-08dce9dbacef
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 10:01:29.1943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0282
Received-SPF: pass client-ip=40.92.63.93; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Introduce the virtio-pci and pci_bridge address spaces to solve this problem.
>
> Before:
> memory-region: pci_bridge_pci
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>       00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>       00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>     0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>       0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>       0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>       0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>       0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
>
> After:
> address-space: virtio-pci-cfg-mem-as
>   0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>     0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>     0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>     0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>     0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
>
> address-space: pci_bridge_pci_mem
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>       00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>       00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>     0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>       0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>       0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>       0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>       0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> Fixes: ffa8a3e3b2e6 ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Wang Liang <wangliang44@baidu.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

Thanks!

--
Best Regards
Junjie Mao

