Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0EFF3C991
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutsM-0007o5-8Z; Tue, 24 Feb 2026 09:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vutsK-0007nb-Py
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:59:00 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vutsJ-0005W3-D4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:59:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8iAknrXWivlsxc8GKsthJiTq1wjbn1s3KEZoHI7FSeYVM7EX4vXxBad0ugb71IAgb0SF/VtdNndTv+DIr0PGzh3oeW4T2HqkNeyEDXNf7CMG3emevdE0tM6wEkZus5wMc6zcvmhggApbFEtu0yN31bnNLMmb/JWjV+BQV+ggUQrQ7WrxlABkieACbIDB3Pv1YV0FyqhU03lUYi+6EEmhyb4ZfPjwarxykQXep4caRjYDnw7trfe4WHGULkzvLynRhKGcQ6tFVHkUk5fbe8TjCpPguG8nIkoj7rDJvG/N97aTbmfC0BlL9erUUQPJP/wm72U0g2/6pH+7FtynykodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqL8DnDRcDqibAkmEgFTMS4s1YL2Jx0UJePZMAmlqCE=;
 b=bfbGig132K/JJGTWDePZPCeS+6G+/vr3gtB0UOGFZulPV0UAaeHczX1shiK3adn7BBkvQzWaSwQk/gE7FZ2PiqYyYOby8iZgtYBNs/MCXqMPF4vdTxzNAxHIJXgvI80s1dQ8ywCM2ypF3odI+2Zd+gYxkOC82bHKIR3kw7Pt2Txz3dA6IdC7ZOVaad2JzPfBvPtnT+4QA9I0TS/yM1L/cWrT0UA/RMcO/95v604Bh+m+z4OFW7OTqp60fk7flL/QTeQGqKrmnLx8LfIeKyifsLmxEnmt2o+LCh1gQkIQ8AEjN/JzCsQ//ZQDB2gQUTjNFTUIuoyQTJEXWvDBuH/0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqL8DnDRcDqibAkmEgFTMS4s1YL2Jx0UJePZMAmlqCE=;
 b=JxR8wxZ8CZqJXL/DMCEBSJIIKEKt0BOkCN23aPi6XHJUW3XZp+IIMjv3YokUsaqzzTiMkCwIjwYuY5R05REpoaV/WbfqGG9h+TzD/DfGu5O5Cx8Op+dZseV6h6qR5WALjgUktUcFaFSwwHwMZVv3ysS9aX1r/bkdNc/9TctW5DZvU5h7IRl8eUxjIA2Nx/Ir8/af+xEUQVyVXSOZIg9NHK9BYEOJA0oAGOAHq0ySoBvshWIfGf/BAK0FpBErJCs6eZ7vSAXvLwNQ4KAyJcxRTkeWijUONIiglWuZVTza6H+6ng4cz3rjNMGIRlYMfnZc38X0fjIDOvW30HFHPeyx6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:58:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:58:52 +0000
Date: Tue, 24 Feb 2026 10:58:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Vikram Sethi <vsethi@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <aZ28qvehl7Lleo2a@nvidia.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
 <20260224085955-mutt-send-email-mst@kernel.org>
 <aZ2449e8ucB8e3AJ@nvidia.com>
 <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d231c6-bc07-4bc3-25c0-08de73b5391c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dHavTt6ZUQd9SCUS0b/sqS7P9mZduRToyds2h/3kxwgKmozGoVith+mmxzwL?=
 =?us-ascii?Q?vi6E7d/vqrC3gLL00Ox8xoXMDZOsCYRXNlfZF8YKw+U34sz1/XsTj7VJP6+M?=
 =?us-ascii?Q?cpqUQ5Un0HXowfw8FFNfhUmiY3tJBMQKU6mrtJhh5v6ZphbrbYipXfqWuJnm?=
 =?us-ascii?Q?5JD0NBVz1HHzLCy8Kirz9unMk7wOzlaLg4njBeaT0oDBvwLzjMYb39haAO4h?=
 =?us-ascii?Q?rmIDyLDmUWsCzHUesZ0VPml6Py+UVF+j5+hVVCSM8StFo8jmVwbDrc4nF3pF?=
 =?us-ascii?Q?5arFm/spBrwH1Fd+qEA4XBv4is1JxQrY6xE5J4NSFU1sHhNarS1sY6pgX1VV?=
 =?us-ascii?Q?PTxP0nbaFqu0ZgBJTon/TNuHN+9clU2OyNTYBmnT04mdDyGYtCftUBJMq8qG?=
 =?us-ascii?Q?TvZmoO+YqNjwugAEvW8bOsJABQrxlpfcpcPfZayPUV82xXTUfRMionY/D0E7?=
 =?us-ascii?Q?Wj2+KYgL0DNLGCXSr4s0kn5Oq9EgE/wWZn8kZJvj1Kl4cPvlJX7zRJs6Y6gC?=
 =?us-ascii?Q?N5Mn32CX/ALxIigLzbBVB/YUDTIReoslnCnLukfAcEfmdhex32Kbpgtxgn64?=
 =?us-ascii?Q?FsTaYHvuHujCHm9P9eoQSO62RQF1lC0ZMlPeoH3fo41zo9edxNVscn6+lc3p?=
 =?us-ascii?Q?2CVf1y6bzd6JqgZJYjWdq+738lAlrRzuF5mNAG/aq7SHf7LNjYfTb04lR/d2?=
 =?us-ascii?Q?69mI/RlIuB/9LsXpl2btMu6/q/d2E4TpTL4gfIQbJKQXSQ+tmDPQ4OennPN8?=
 =?us-ascii?Q?9RH85TZAtgKYLRsWOwZvngzgTgY5i0K5gNvXFT9opGEu8kWV6NQRQg7Rmg6G?=
 =?us-ascii?Q?ZZWauuWBvniwCadwTh0qKaxxPnbUhtobN6rmAMVfs3Ww8bzttCfE/j+/KUvt?=
 =?us-ascii?Q?CrHY6kDGGfCc/f1WYIU/AcuPedypwkY1Yt8tvcQHaDY5e3o585/ZxQaPNsdt?=
 =?us-ascii?Q?TjVpPK+SHlsWx/r+Bb7uXn2745UYYedoRxhYeJl5+MSMihdfvShThDtXcakd?=
 =?us-ascii?Q?fwvuADsnFtkN2pxhmzhZVpYSz4UKfCHoztP2ewEL3hANT1Nn48MqUYF/Xi9O?=
 =?us-ascii?Q?NUgqLQDGoCcgCkD50qhev6yAtJipV6H8UywzVTvmyhSWNda+9wByL5LBiPWQ?=
 =?us-ascii?Q?thCR1RtEcP0gVTNGQ9ggr/54f2JJNTcCJUyq/rbmZ+JFQDhr30/G7Hf2TKdS?=
 =?us-ascii?Q?898EzanvtK1HueNCqc4smWdBhEv/94k5FLysFfvrJK2XivIuDoddF5hBSlOY?=
 =?us-ascii?Q?Fnq4vpa8BIuFFBJ75YQAO1J0r8QBz95nQKV3yDrh47hB6KcRfGlud1tQZ7kk?=
 =?us-ascii?Q?bPx+hNfBIPhCnO6kKx7vd+uYwBxOASTWe+Zvwf4bqsfhaIM0+NuVFSAeLN/g?=
 =?us-ascii?Q?ZNq8YpaxmOuXQbQHNQKHqF7ovpTa6L/s91vv+zgOduei1G+bpbSD/ZOGwTyA?=
 =?us-ascii?Q?8qvA6uklDrHQcaXhJYmkNyitispyJ/kUIAZzK11o2cwEXTmV/T6S04nRiMoF?=
 =?us-ascii?Q?RVtucxFuveRqQ9q5h3gp0+jYjNeT8Udf384TzSWONjlzb6frmYSq7kd37s6V?=
 =?us-ascii?Q?uM+0dTIEJfxEiPD0/Z8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwyeiDGFvmJjg0nrIpalj9Uk0T+nwdOqhbEfoQ35JChhpF+8bFQTukmODsVC?=
 =?us-ascii?Q?sh44t4L6ZkWS4Hk9LBMjntuIkJ4awx2Iird3tOAGdq+Z0q6uUWDBWEXcsHiU?=
 =?us-ascii?Q?iwGitNHPY2z51UeFNKjIjooWrEDCXACrTGlZUb/5hkIIDyb7sMe2GxgUzJgO?=
 =?us-ascii?Q?f7U0c1h7NZTvU6bvzCzu2fDoE7CLkEsKvnc5kqRYjybcpuR/afwOp5gOyON0?=
 =?us-ascii?Q?iBHlMdbOmHLZbrmVUrAqGSO35epIKFJjRzxeHGzI9zKrs33cVSYUbKfo2Adl?=
 =?us-ascii?Q?eW1sNcSMJ6RKXjeroDGwNjA4f66BKAarWeFguciwpdQKBgoEBDKEWXbJ3SGx?=
 =?us-ascii?Q?zsfzcISyQ1uE+lF8zIjJdfGT0xQ5sHm9zb8qKDTEtKn6V19Z45qeVYE7m24i?=
 =?us-ascii?Q?uVcUs47U5Rt3+1U7XdEyoe5RMPBJyMvbmfQYBMiX6iFoTQ9JDRceG2cGHaxV?=
 =?us-ascii?Q?WLq7zQw4Inp++MLYaBJhMvrT56LhlLczFTUBHz3d7//MPbcS88ilTzLBhYiP?=
 =?us-ascii?Q?hf3POyhn/QHx7ym3176h8orgny5GUMPPmzG39pj6hYqHORfCh9+8e1Pn+MjQ?=
 =?us-ascii?Q?AIs2Shy+3q5I+T3rPrLq+LCCG7sHlcQrWMYbDXdYFhWpuOit8qcBBa7EMpC5?=
 =?us-ascii?Q?dMyavi/asTCI1CQ92ceMZWQBbw1GAIqWcd0JzYDSljTSJkvQjHz6UYpg2RbU?=
 =?us-ascii?Q?2ouaOoQzz70q6IlbUKMjyL2xUki/7q6WldECXQvgyHDC4tWAIaBdIHYrGM3r?=
 =?us-ascii?Q?LYy4CnXrMrLo1bNvRNdtmIafUUWnc+fgqVenl7Qsh6OxJ1pruSN6ZTpfPBNb?=
 =?us-ascii?Q?nlDzSU8ofzzTY/Ck7Y3DKu3op4Diu8x6T2mXnt/X4mbKvHa2pY8xcbEX0APz?=
 =?us-ascii?Q?e7AFPXT2kJdJFx5EXFtiMoT+J61b6kehdWSgx2/yEee9814VPuJimpZ3GbUP?=
 =?us-ascii?Q?MkKSNnhmUvlY5lSGx967AsHeIeYRAuza2cfTHgQZPf5b6fKoWUZXoBYT92Wr?=
 =?us-ascii?Q?IHwuLc4CkqRP3r0/dHpsYnLpsVXDGPekKzg73lrN2y26lLJN2rxR4shMBskK?=
 =?us-ascii?Q?EWCmoKh5UIxuLI9c8hRmzJEM/OpUkGxAcTaRrfEKI/mCtxx8Fxq67a4x2iJZ?=
 =?us-ascii?Q?6E7Oy8p22GERVn8ypAcbjSjFAMSTty2NwrRMsWqQBwQFS2xI0nSozS6kgpxr?=
 =?us-ascii?Q?EGAGE0Mc5chnnxXYJdrJh/lrsa7S6VU/i2x39j/p0kt9LGFnZM5cV3bPgz4D?=
 =?us-ascii?Q?FQPCihnec+jH8hI2P5V8EgVEu5srNVwDMBRfQHs+KgGxTN+6J/8ZTSFzq4k7?=
 =?us-ascii?Q?oXOYWG4VefkHQWSFaEIpXPXb57smVlAK4Hbk/BehVgZrwma5gQsnkFKbweee?=
 =?us-ascii?Q?s8ZN+91zvZ5/UL54jMeKe2K9uvCFN7E3UsmEDwTYkaX62hNa+F3RoJlSPnrb?=
 =?us-ascii?Q?6IoeFaUlClXFXpy68VPsZNEPNc/1CiNhMXRFnRp5rrgsnbB8vvD0JtmyeSIj?=
 =?us-ascii?Q?PZD/b7QnKzg30sB2/uW4BuVxvCBpHhjXqk/fGmrTmO2nQ+HHI+WmWTMm0beQ?=
 =?us-ascii?Q?dETdmzY8tvo7IaKGv5yduvYpgYUFJMLB5WP1T4hr+sOmCODpYEzDmaFHDBI/?=
 =?us-ascii?Q?qgNqevd2C68xW87H1nE8vf/WhxF07rjGpYnu1eHK4DGFZxrwciyvtsyj8fey?=
 =?us-ascii?Q?Id212F/Hz2soartLIQ/+w0kpTNAtN4Eu5IpbW158SpzObSmz3K/oYjxubyJP?=
 =?us-ascii?Q?/8+Kpg2sbg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d231c6-bc07-4bc3-25c0-08de73b5391c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:58:51.9363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz61u23bJ/hgXMDifnbPWjIeg2NUSwK3pDcsj3JB4ddxY26y/h+F3l3CvuchUH70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=jgg@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 02:51:42PM +0000, Ankit Agrawal wrote:
> Now the kernel parse it in the sequence of their occurrence. A jumbled up
> sequence thus results in a jumbled up assignment.

But what is the actual failure mode here? So the numa IDs are all in a
weird order, what goes wrong from that?

Jason

