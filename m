Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC590C44521
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 06:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkycF-0006OI-DF; Sat, 18 Jul 2026 02:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.gellermann@codasip.com>)
 id 1wkl9m-00017j-Pa; Fri, 17 Jul 2026 12:11:22 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.gellermann@codasip.com>)
 id 1wkl9k-00057k-MZ; Fri, 17 Jul 2026 12:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac+T9dv2FaRFpxIP5VhBwclZL9XpgUjzQAkj0SSAz/5Rqc4oDQN5gQYHOYzhywKIkGKdvaCNMcI1wY9T5/BkFl2Z4tTY2U53sbUn5opoWextOs+GCXmUuVaSfAyNAQE3XgLVZlTdF16bpkFljv4BCl6zFdfjk2X6VB/T+G/YkI1Y/16PHI202gQ3KiGWDhaxsPwAxD+Jou9KAEk9RWY0CXTFZ2SOTHghC6wf75QyiM3B3rNVFD7+0K2I3MAdS4cXzpwdPgT7QiTc13JiuUmzwWMwTWvNP7Ve/j+4wniQebVMntP8x+cMeynnigIbbe+EHWBiDUN9Hs444ZzmCOUn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l49Ic/XmzjGECccTpeqqs9f/GNocXUn3uFK6B9KCZFw=;
 b=ESnZJE73I89o2ns3302m6I6ey1BnzOzep0T6A0t2Kx9xqk+lQI5ezLEWbUoAE3ZVKoAGfn/WY1bJeAkDTk/6d5PJaYglts0fdroRxidfuNRmex+hSk6sP6TRxckLEy0TdgD9A1hrKmHpmVpJg6SkRYeVmxipPYWXn5A4Tw9SeaSUr6K56tg82gyxJQxfwWKaHJNNeyK9IafR6jiTQB/u8sfxFcUDCd7b7WLjiCVQg8QNaWmY/mpmKEYYnWX/v7N6tb6LcJlLWwR3fhnykLZTNzC1btN22BkuuqK3x15YOevQ6aoy03rI8UrfrUn/Z0ytujt9/RpX4ZzxO9CFIKT0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l49Ic/XmzjGECccTpeqqs9f/GNocXUn3uFK6B9KCZFw=;
 b=3ReNYNXRxMEfwvgZklDLMtJeUYUYF/Plj0wIBc1dcr6YsC8K7UKIaq13fLWCsZkPFdyjl9diPh4SDf0AAMVF+5OlzO6vErtKb6rxFgcbwWQoowZ7+9Mw98LW/dQ6fP4V0Rln2Ks4mSDWaFwj0U7Aqn4wamH88qQaAL4xe7cbZxVKzMopMxOgEXaAc0AlunOTLhkXRYgBLzt9zFBdV7iH4zL+WX9SA68L9wIno5uECRXOJ5UaNCp8VZU2gsATZRs0fK86Ho0pCA0rGCsC26q66QTe06C3z+CZqWOvkrl+wB7AIDY5tzRo+x/q/lPsvVKfVmHmDoZQEETQfc6i02vaBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:46::8) by
 AS8P192MB2173.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:637::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 16:11:15 +0000
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8209:40a:b436:bb07]) by PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8209:40a:b436:bb07%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 16:11:15 +0000
From: Chris Gellermann <christian.gellermann@codasip.com>
To: kbusch@kernel.org,
	its@irrelevant.dk,
	foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Chris Gellermann <christian.gellermann@codasip.com>
Subject: [PATCH 0/1] NVMe: Fix stale event index of CQ causing interrupt storm
Date: Fri, 17 Jul 2026 18:11:10 +0200
Message-ID: <20260717161111.2714244-1-christian.gellermann@codasip.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0303.eurprd07.prod.outlook.com
 (2603:10a6:800:130::31) To PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:46::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0796:EE_|AS8P192MB2173:EE_
X-MS-Office365-Filtering-Correlation-Id: 32020e51-7bf6-4c53-07e6-08dee41e0755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: LVyQBr15lDXCL1DKnKXhKLGkD3OBsVqNoS1mHytSNPaVrN/mj52vTJMvFp/C08lptmJaEMFfYJexJ1OlNuhhLdGDzYzQVL9P50/XVt69Xkrqh5LYvKJc95Im11KziYrB93qc4zv+BQwtrzRJSC5kOMdaUOY7h+Mil3NNS+fenChertevE5J4+InZCyG8YhelPxNj0NREdpED0edqAEapqude88DSdCKTBsN8z1dk3eigwZHcgG6clfMTlonUS+Yvk+UQPzZJ5QizgIXd72Jre5aKaqRoi1zs48WZZpDul8xyTjdUyfa1pEr1/yQfeNeoXh8fWEhsqBZy2onEcebCdk9nHClomPkDz0j4KeIrUxbHE9TxhQabortaUkOnm+XkB/dhMMl/5J5Dk6RmL/RZfoOFbJnAa2JSG5QRw9YyPTPN3R9kD/TfLrTRne/ole/ImP+xA8dkOtVxomwg0IiKlDcqbxaEkVg6Ilnk893BYT/WZNRW+FhK7cthYICIPJrtP+lJDyN6ct3/BXgW5LV0kthIypHib89CoKePCTLX39pBL9hdMRnpdEN7wUEF0+KkYz129tSLmNt+OsF8DPyi7lXTuapwQOkTS3A1CKnvTy0Z+MkamrwUxx1poHD9wLoeM0+8XcpNr+ItYNfncfQn3+NVCcJkN0mJ5Nh/PkIDOIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3P192MB0796.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1rKafacVRo6T2U8YPBrV/dDgt32y2exfBVeIUbCYzYYkaeQRMUS4giiQxMUO?=
 =?us-ascii?Q?wixZ0gHNgjoEEth6KdZL/nGAV94NAeGTHe6wJvK5J4Lyq/dqsQI1hiax8eOI?=
 =?us-ascii?Q?vqDlm/yRdv197uVb1kdrISC66VIpcjJxG+RksXl5CF5+0Ulvb9+eI2uFy26B?=
 =?us-ascii?Q?kK3JpuZ7walkMaLp+TcZ1wkpMI1ilAl26jJR5NfYb2RolmcVflxKaLLnbAAW?=
 =?us-ascii?Q?ND/FFYJ+drPdmwdWKgrzCR70gULp/vIj3b9Ydiv6nFyVCwrFqef6Naldjrlh?=
 =?us-ascii?Q?5qoRKARAydnit67y2J++TsmSCiGGl/1aflRzpoaUmV3Re7L3aXqqt/tr5/RZ?=
 =?us-ascii?Q?ycwQfaP+kSZHBeS0+QCqXfynAV7AOHvi6JG6oP9vU5hU31sVX+LCiWAaRyrc?=
 =?us-ascii?Q?c+B1I8YekwpFlrDyOFhVkb7uIdq8NC/ZUvmMYkRu7CtuRXASPSkIc60wlJqc?=
 =?us-ascii?Q?+JZe25T23l/NIHwnJ9dYHYx3Uwj1APWytXhk7ZGUebMhT0UZ8AGx6bzRoE03?=
 =?us-ascii?Q?0T0MUzm9bUCvx4YlvyCIQ/tO8TFsgMJK88ORVfxbYpeNZftP2aYqSuJZYKLU?=
 =?us-ascii?Q?n7hUWj4gFaC1yLgmz2S/RopK7sSKX3AwJmeGw2JSgBIdKceJu7DRMB8jcIyK?=
 =?us-ascii?Q?2JfEaNecIgqG7MzShUsR0FV1d4Jyrz8Yhxk+4TmLFhb9sQIsXHUyoFiSQDwV?=
 =?us-ascii?Q?WgGTY8oGaNhjD51THobVyf+5eC5+BOEj3BeO/MiA+IFSHSIjfd8ko1Kyiee0?=
 =?us-ascii?Q?zbysOThh5JO3B09T9psUefXo5NmfLiMjsDCycKUwhVPKefE0Tu6hmtVhKPef?=
 =?us-ascii?Q?PtLNMGaGDzifWiOCgS+BFN+Cjb0z1LKctW30sUOJszN0+hH78ogaKnpvyEmX?=
 =?us-ascii?Q?SlcBdzOg84UYUWuXZvkuqqi/oz/ApAqLWGrzyo5XElxrJE1PAl7th5oWVRkT?=
 =?us-ascii?Q?jmJehk5MSTLYHYdbo3belauSsAv5Tir+i7NpWF2svRjnPdmBFHbHecbQAhmx?=
 =?us-ascii?Q?j9VgCNgUyCncOenBTJo2Iuo2n6rVUB5WHKU9LkOpF65mi0H3LznUtUmpVXA+?=
 =?us-ascii?Q?hggqQgKyjihV2mKkYWURZuYdnU4RwffyQrELFdhk0Cxwfk5erWealyQcyGpL?=
 =?us-ascii?Q?0N35SvtbQ66NbbeMZPn6DWUROBi8PknZnYe9NTsIR91OoIhai90VJcg1cCOa?=
 =?us-ascii?Q?tJxBgRrRw0UzaA9lwZ6Hs7k6GJ+Xis3eQvVJgZMHHCzREcehEIGNvNqJ7ORN?=
 =?us-ascii?Q?FZWbTVoH7rV5x9Are1P0V+L0DOBsosEMiMkz+9xDuouGTpwmzwK+mVrjv8Jl?=
 =?us-ascii?Q?xgyu4GJIF94oyFltmtNL5CpspPeiA8sGYEsEM3tehft+fyqk1G+IYdfzIS1C?=
 =?us-ascii?Q?d/D2tGgXSGLg6T5/UguoKC3WMOb4a4NphUZSTz5wHMGSZopXW80rlKEPeO0/?=
 =?us-ascii?Q?ZwB6foH+grrM3/et8bN9dHKHnm9YVE/chyUUrwhy0dYsriATnBUdKVN4zl/k?=
 =?us-ascii?Q?WjnoOPDUgpP69DlI6JUUovFkCqha57bsJOPkvsCkiKo72XZb/M+JvIssQmqS?=
 =?us-ascii?Q?riPuIF6Nct1lTDpCXwguhx6iFzYDq9jYn/2j2UVLVg8Qth3xtMKVOxZCXsSb?=
 =?us-ascii?Q?GrI4RRHk3FtYxv7qPzHoirV2HuiNPQ35Svf1XBWAZZfaEAuSYW88OsfCXreV?=
 =?us-ascii?Q?ND1fnvQV3k3/Ej3a7B9kk7V8QmHGeLIIOYcX+/x8jjiam8NpxgBaNBmj8sLE?=
 =?us-ascii?Q?aP5iAadpOZrUPICpNglImqjYeRc3TR4+ftVFzWQjJVYKt/3QbDOPRDb09dQl?=
X-MS-Exchange-AntiSpam-MessageData-1: HNaX0C7Q5IlCS/aZFyp0y4t/yKOkmb97As4dbALjW7MoPJ+5hcKD03p5
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32020e51-7bf6-4c53-07e6-08dee41e0755
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 16:11:15.7320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppWU37lHIx0/tmCIbtwWSys0ZkpOzs9osyfXNeRxk5LsggicdPHBb97LYptNdhsHVjtos3Y2z+dbive1DNUSSoPIdJRw2TaVy67ce6G8xgaTFXkSJHYv3nJUkYDjLCOu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2173
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=christian.gellermann@codasip.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Jul 2026 02:33:18 -0400
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

Hi there,

I've been debugging since a few days a situation where the NVMe CQ interrupt
remains asserted, but the host does not issue an MMIO write if doorbell buffering
is enabled. I've been tracing this back to what I believe is a missing CQ event
index update. We ran into this issue on Linux 7.1 with an older Qemu version
(v7.1 with backported fixes). I couldn't reproduce the issue with upstream Qemu
which makes me suspicious whether/where my observation based on a trace log
is flawed.

Regarding the Qemu version [1] we use, we are on a v7.1 fork where we backported
the following NVMe fixes:
* 5fb65529ef2ad: hw/nvme: Change alignment in dma functions for nvme_blk_*
* 248761f9c850f: hw/nvme: fix missing cq eventidx update
Other than that, there are no NVMe related changes on top of v7.1. We run
Qemu with the NVMe as Xilinx PCIe endpoint with level-triggered legacy-PCI
interrupts. So our cli args look like this:
-drive file=./my-rootfs.wic,if=none,id=nvme1,format=raw \
-device nvme,serial=1234,drive=nvme1,bus=pcie.0 \

The situation I believe to observe is:
---- from the commit message of the attached fix ----
Assume a situation where the interrupt is deasserted, so cq->head ==
cq->tail == x. A first CQE is posted, so cq->tail becomes x + 1 and the
interrupt is asserted as cq->tail != cq->head. The host is handling the
CQE and writes x + 1 to it its shadow doorbell. Before the host issues an
mmio doorbell write, another CQE is posted, so event index remains x,
cq->head becomes x + 1, cq->tail becomes x + 2 and the IRQ remains
asserted. Just after the CQE has been posted, the host checks if the
condition to issue an mmio doorbell write applies:
  new_shadow_db - event_idx <= old_shadow_db - new_shadow_db
with new_shadow_db == x + 1, event_idx == x and old_shadow_db == x.
So the host issues an mmio to write x + 1 to the doorbell. As cq->tail is
x + 2, the interrupt remains asserted. But now, after the host is done
with processing the second CQE, it won't issue another doorbell mmio write
as the above condition is not met due to the CQ event_idx still being x.
Thus, the interrupt remains pending.
---- end of from the commit message of the attached fix ----

Here is a trace of the situation where I believe above happens:
...
pci_nvme_rw_complete_cb cid 37025 blk 'nvme1'
pci_nvme_enqueue_req_completion cid 37025 cqid 1 dw0 0x0 dw1 0x0 status 0x0
pci_nvme_update_cq_eventidx cqid 1 new_eventidx 92  <---- First CQE gets posted
pci_nvme_shadow_doorbell_cq cqid 1 new_shadow_doorbell 92
pci_nvme_irq_pin pulsing IRQ pin    <---- interrupt gets asserted
pci_nvme_mmio_write addr 0x1008 data 0x5e size 4
pci_nvme_mmio_doorbell_sq sqid 1 new_tail 94
pci_nvme_shadow_doorbell_sq sqid 1 new_shadow_doorbell 94
...
pci_nvme_eventidx_sq sqid 1 new_eventidx 94
pci_nvme_shadow_doorbell_sq sqid 1 new_shadow_doorbell 94
pci_nvme_rw_cb cid 37178 blk 'nvme1'
pci_nvme_rw_complete_cb cid 37178 blk 'nvme1'
pci_nvme_enqueue_req_completion cid 37178 cqid 1 dw0 0x0 dw1 0x0 status 0x0
pci_nvme_update_cq_eventidx cqid 1 new_eventidx 92  <---- Second CQE, event index unchanged
pci_nvme_shadow_doorbell_cq cqid 1 new_shadow_doorbell 93  <---- CQ shadow doorbell has been updated by host
pci_nvme_irq_pin pulsing IRQ pin   <---- interrupt remains asserted
pci_nvme_mmio_write addr 0x100c data 0x5d size 4
pci_nvme_mmio_doorbell_cq cqid 1 new_head 93           <---- CQ doorbell mmio access updating doorbell
pci_nvme_mmio_write addr 0x1008 data 0x5f size 4
pci_nvme_mmio_doorbell_sq sqid 1 new_tail 95
...

The issue causes the NVMe interrupt to be disabled by Linux due to being
asserted:

[   24.829513] irq 15: nobody cared (try booting with the "irqpoll"
option)
[   24.830575] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
7.1.0-gd8bb0e727297-dirty #
23 PREEMPT
[   24.831145] Hardware name: riscv-virtio,qemu (DT)
[   24.831402] Call Trace:
[   24.831810] [<ffffffff80027ff0>] dump_backtrace+0x30/0x50
[   24.832359] [<ffffffff80001802>] show_stack+0x42/0x60
[   24.832569] [<ffffffff80020e5a>] __dump_stack+0x2a/0x40
[   24.832763] [<ffffffff80020df8>] dump_stack_lvl+0x68/0xa0
[   24.832958] [<ffffffff80020e88>] dump_stack+0x18/0x20
[   24.833148] [<ffffffff80003e2e>] __report_bad_irq+0x4e/0x1c0
[   24.833348] [<ffffffff800df0b8>] note_interrupt+0x188/0x210
[   24.833544] [<ffffffff800db07a>] handle_irq_event+0x7a/0xb0
[   24.833736] [<ffffffff800e0b74>] handle_fasteoi_irq+0x154/0x260
[   24.833939] [<ffffffff800d9568>] generic_handle_domain_irq+0x38/0x60
[   24.834130] [<ffffffff805c40f4>] plic_handle_irq+0xf4/0x170
[   24.834322] [<ffffffff800d9568>] generic_handle_domain_irq+0x38/0x60
[   24.834514] [<ffffffff805bf632>] riscv_intc_irq+0x32/0x80
[   24.834701] [<ffffffff810d1f08>] handle_riscv_irq+0x38/0x60
...

If you find some time, I'd appreciate your feedback. It would help me
clarify where my understand is flawed.

Best,
Chris

[1] https://github.com/CHERI-Alliance/qemu/tree/codasp-head

Chris Gellermann (1):
  nvme/ctrl: Fix stale CQ event index causing interrupt storm

 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

--
2.47.3

