Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B87DE8FDB8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 22:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZGfE-0005bw-2l; Fri, 26 Dec 2025 17:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apopple@nvidia.com>)
 id 1vZGf9-0005bV-Ep
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 17:51:59 -0500
Received: from mail-westusazon11012040.outbound.protection.outlook.com
 ([52.101.43.40] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apopple@nvidia.com>)
 id 1vZGf7-0006Us-Cp
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 17:51:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMefAm5vZgSzoI/aoJcttP8jqSgYbOz7V/Ai0QGKAZB/TJ+fTxj8samgSxxl5cue2/PTdqcYD45fJNxXpez8BJuHGtRcFkyq1gdBL/0w44ejiMcM1r3f3tp9MVcE9pGPCOtFysIF6RZdI81oF1mxUee7eBwxriILvt8QVxwahnd/XgdY7B5pkmCPqV+vsouFFbzy8LUZmE5pOv5aBb6OT4XLnxy1m09K94ImcGExsLYnNDfX2Rq3B6ajIh/PS855AYeQXl27OaQ6eGRPJUiFvdZZUkXSxww4Ea0o4D9zBnSUQK2LL1ySX0ITvR1T/jnAkJxtCocVs+ziiH1clGw3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8U8q0WTukP2MIrDBo6LhTSBJcg0DTgWJeU1Nl+Iwpw=;
 b=BmzCBJmphWK2g1RQOccpgccHhRe4D7zPeUsRsFVio54BgZW41Q/Mn7c5tbAb+8OiiRr5NSVzyosH4U3Up6WhpIwRM7/uvUI6Tnrqjy0Nut4rJ+YSoRNE1zHpYGvxsHbPqr/l1dsMy9Jg4ZVba/VB/c4zYaIJ+lb2AYzQf9rB8S+njFcaOwcClWbIXL9mvD0czAGWZcFYpDXM69RYXr/4Db8tmrUtIoylA8QCaS1K6la8Lc7oeuGIW/6xgMsrVCGrRwFRhLEXNLflQALZDHxWQcb5u+zkecWZp9W4UYkEfBufSFdYii+rfvuGX57ivS16uSePy78c3vhNEWCiqIlKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8U8q0WTukP2MIrDBo6LhTSBJcg0DTgWJeU1Nl+Iwpw=;
 b=eXjXvTtrY2uSpEoC3/ZTXS1xziA7FXqdim3Zc5VBh6TqtIml2g3XqbWgfOeQOFEK7s07UOYL4NFyVIg+riXXB+t1k27+SvfAcPkulYRQZ7JxRfUPGNMxUamUS196S8gF4eAMmVM8Xa5MG9O8nwS1R6TsjfKsF2b1ZQTfMmGg7PXgcA5Hu2/OUEp7BrE/Qoq9hh8tEqrBjvZXujEskYmokFVnjyzQ74tSZCBMbXZjNmE4AiQg+tJ4rh1ldoTt4ctvd4Ctp8Gottr5nBqS+cl0+V03L+Bc/Mg5KDFIIKs2VlvzupPFgNndpAIOuKZ7EJyJ/42yDVJMRzBgi1ReSO3fgw==
Received: from PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 22:46:50 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 22:46:49 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 22:46:48 +0000
Date: Sat, 27 Dec 2025 09:46:43 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, Zhigang.Luo@amd.com, 
 Lianjie.Shi@amd.com, "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, 
 Paul Blinzer <Paul.Blinzer@amd.com>, dan.j.williams@intel.com,
 Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v4 1/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <x4nm3h6rk6xal4e2p5bfoc6vanc5sg7bjhoq6evmdxuvydukbh@45arim6i5c6b>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <20251209093841.2250527-2-FangSheng.Huang@amd.com>
 <20251223095605.0000065d@huawei.com>
 <586a3535-ffa1-4d13-8bb5-c1b922a90a43@kernel.org>
 <bcad3442-0ed2-4046-a2a6-5176a7530f93@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcad3442-0ed2-4046-a2a6-5176a7530f93@amd.com>
X-ClientProxiedBy: SY6PR01CA0118.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB7908:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f66cb9-4960-493a-1bba-08de44d0a76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9k8YJSbQekOFyGfNxFIZDZC5RaCt6ld+uxi+cXc76johNIZwQjcRVkA+0QIM?=
 =?us-ascii?Q?mJLMSVNhIK9wyPRLBA/AW4qIoiOx06/DCDFXOyiT0tzkPUTST5ns8MVu5zQP?=
 =?us-ascii?Q?rL0HLyBH02V01GnAZRUVtU6dQxQux+F+8YxedNcaZExzJk0OaGtYnkiOTj3b?=
 =?us-ascii?Q?6CKAlIV8B41TzXMUjCwPEA8jy8uzCzy0+0108IOvGvZJInoqb0lVPFbEqVb6?=
 =?us-ascii?Q?kAeX+jgrgOVIUhtAxYo8x4rG94hoiLhbfSnDnwKc6zB/v5CxhN/2oi/k3Mq1?=
 =?us-ascii?Q?B1Z402Ab4itcbf4qJyAB1Lxo41HBvKWfgyGOpkNlmAGGWxZZna+IVB0Y5Wta?=
 =?us-ascii?Q?2nJqsEnDWOoiiWG8vQivAk0LJv3/bJInUvkmyotAdWgZhzeuMNcLrZsRJuy8?=
 =?us-ascii?Q?wrOebYE6AWCcJKJiLy+eSrkmPZa5pi21WNh44gpePj2nPqVcJoRhCQYW0LLp?=
 =?us-ascii?Q?uJUxPK+afLWHN0ej7iqI7avfNI9QLKpekBk1IDJq3Se6E3RVoavB3KL8rW8h?=
 =?us-ascii?Q?1StVMyzWk9O8HHLhET6q4As0KB+4eupArMCe9Uy3c7hTrTqDjMgniRMLBvk5?=
 =?us-ascii?Q?gfA7F1siaentSwoJcMcxKoZPnckeL+7sMtz9QKqxpRHLA0BHFOg7tGh+V7f9?=
 =?us-ascii?Q?Pd3Av6pCdAshUTFqU3jtAhYnY8FWCutIsAFgaTaMucH+uU8rY9dCHt5mgknv?=
 =?us-ascii?Q?VhDScwk6/YX7T5f/nKKPYAF69NCL5eOhUJL1mtKt5HiKnnjOejZFlXCTDGnJ?=
 =?us-ascii?Q?AUB8zVtFg7QMhbGSIqsSl4R+PCfjwNi0xhnDjq/ef+/E0q41SrfC+J66Sqpf?=
 =?us-ascii?Q?75zrgMQ90Lw00zOblN5BGpZFNu7bTXaPDBLpPIBQOJH7Kl9tH76EpJ7owfgX?=
 =?us-ascii?Q?Bxt6S7TfCNyBJ4LV1OVjsLSmpTYp2Tn3Iuv50kGgX7XBewHSWm/doRwhpPQn?=
 =?us-ascii?Q?UNWPYRse4UOV7LI6GaoDHA//FbQhDxos6tXGfOljfUV/q7Wk9B4VSjOQkkRL?=
 =?us-ascii?Q?un5/lOoZC2N/f5eU6t6ZKYZYVFpOM203ScdGtj3HwsDMAXwoOBrNMVH1u3qO?=
 =?us-ascii?Q?Knh3iEaRlY3h2PdmrCRgdHOZqYyb03A1ppZW2GQqJk2eZ92XP+P8Pkq+iVdx?=
 =?us-ascii?Q?YhR206ZTTfiVsuAwGkEJsAAFUDw4fdHTlnNLCBvQwLAVJs2kqSzaeH0yIlA1?=
 =?us-ascii?Q?ZZrea38aBjAlDxscsbWCgwz9hg1pCs0di6J6JcAhyIZbalNaQrSgT+WhOIAV?=
 =?us-ascii?Q?8WcHI8+dgrMWWoTRNW0J+Jy/ImYr89+Eow2qnUuSsCUBjVzEmmOsnIlNotMs?=
 =?us-ascii?Q?qrPtQBIMxFvSBTk/FURA12IIfJp17Ezu84eRkLHBka/pgrXBQdFwGTdN1whO?=
 =?us-ascii?Q?3i6v24l+plGBAx8NmSPHyNYHGwWCpW6bLDlPPc5HgvQrYRep6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7908.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpfpcKYz0o8RoZ/Bas9hAEuyFknzER95SyXdVumZwbJtxIbXZw1/cApGNboy?=
 =?us-ascii?Q?SuwSBKhs0o+kKRFIPcKiUijYUexwO/DhiU/chHUAq/Q0rz2Iz9VJVmOgEnIZ?=
 =?us-ascii?Q?wMRxZJ7ccPIXwTwaJuWyBl6QkbBDmYBQLahA49aekwXASw+EJtQp+dmRRRAF?=
 =?us-ascii?Q?96zBMeOcIDfqGQ4mgya7R/Mus0Y6Fo1jXmAAv2f9GNTuPAX2gb9cP5h+Z/la?=
 =?us-ascii?Q?yhWuR6e56bV9N2COAkIVzupMrXYCFaijj7YhLDW3MhGn+3Skj7BNlfnro+Nf?=
 =?us-ascii?Q?WD2unQI0c8QndHEhCwQOnnCAXGX0//WYayznl3VT7yFt0jlbIx6Hr6Bes+C0?=
 =?us-ascii?Q?Wy0YYTj1FmCtwmuIVPB0WHZm7i644XSznKH8HlBeJ63tBZsbeV3pg+TY8SeY?=
 =?us-ascii?Q?5f+3dvrVeq/vQ+CP0znD6IREWOXrA/ZoGJ8fB0G3r4ZorujW0vlPE6nxHn51?=
 =?us-ascii?Q?xuiu6/jDZtbNlOaKRLtMVu2ngkHP1Qeq13V9HUZYivh/in7PQ9axFXBPO9M5?=
 =?us-ascii?Q?wdfPtotsHHt6k8Qd/4QBjlgsr6OOaPnLjyVE8ofDSswe53gE8I7OI7cKjEjj?=
 =?us-ascii?Q?L7b+GXTj/Nbu332Kjyg3DQCo4bxyZRt2YExhW7//t3OW0LHiCH0sRkb1P2SD?=
 =?us-ascii?Q?/Beq42hnqKUQNm31QRO3cZjY6z4802G1USa6/ZCayYEtgAFjmBbWknuzNZ6p?=
 =?us-ascii?Q?/6jtphr6Bz2RMNeA0owNlUXWYR7vj9UAfgXVazMqWTKltgZArBNtbQocZkLN?=
 =?us-ascii?Q?ReHDJZq3Y8NF/I+A+ZVyDuJubmJ1ggAhHREQQDUPtu/PVnsetvcCBaeF43nx?=
 =?us-ascii?Q?stueEsQWec7kIVYouvvJj3jThBjEtFVt5wBhlB6nIlboAoHxeMlxziXphEot?=
 =?us-ascii?Q?ZOvcqYdRBUAUtQ9DqGMBNOZJU7sx7q1bOq8LT6/2680zpX06DCxIHwJcu9n6?=
 =?us-ascii?Q?pDwmZtUBLkJX91VfWalEJ3oxiJnNgaBiMAeQLWvvpefgjDTry33HYvR4m/Gw?=
 =?us-ascii?Q?oVJG5LJAeTbBsJqqTOTVKPQRXHGyM7dQR55caQfrc+i/WC1J9vbCPNCRI4Qk?=
 =?us-ascii?Q?y6mTPKYIAoFUTluLD2B6q6D42IP7EGdhOuVD4OSImdvStfTloFvxTzG9ii4T?=
 =?us-ascii?Q?bNz5aS6QmLCYG1KxargXo/vAtTz+rRPmIf2LVXO6ggfo/AJQvMrqRrPS1X36?=
 =?us-ascii?Q?23v6H49FR6phn8T7sd30Fe94OwiDRhl5HynJX0wmNEUekZq/XbzzYd91EG/N?=
 =?us-ascii?Q?mjnqsiYDe9Olz+cCqtPVdnvVsIe+OA+iVv3rpTGoLXyt7iSvv84lw0+C7ftD?=
 =?us-ascii?Q?H8ARHW/kqTVni7OImr7wZ0OiIwTvJvk5kGMWRdXktq2yhq7CaTkjOaTRqfCD?=
 =?us-ascii?Q?Sz/LmGAqtsytQvXTYf1afJKc+NvQGu89E0AaYPCZCo7RB1ZHTY9GxRWL8aA7?=
 =?us-ascii?Q?CHbo+B6gkF1WrilbKbhy+qHGMotT7733kInfn8yHTG+rA1AUFxs+Np/8O7pr?=
 =?us-ascii?Q?GQ3SghubRdtAjc2J0enQs7+GVYG8pBJPjwThyav3d4lcXKx9Q6fROMcyGGNc?=
 =?us-ascii?Q?zZHSrTvKxD2yHK39t5n751224tDBBwwc7EvEiP56FTJIQdRZRhO98vgr7iR1?=
 =?us-ascii?Q?q23nlLKt/tzna/YFSOnEaWKBMgArsZe9hRJfM8vgLIsqXUd5teAw180kGZ0e?=
 =?us-ascii?Q?ltXlsrM/ULf+BQAeyk6tlfpdTW6yDVH/ITvRaEtDtjogq7KR33Eg6ArTpNTQ?=
 =?us-ascii?Q?767/kYArrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f66cb9-4960-493a-1bba-08de44d0a76f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 22:46:48.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvQZAQL/cPNDJqXhJRbUBwBTWxEdK3jnLW8ICLJrTHeCftsF7gywT2nrk0M33pueoX+rPqljt/JbpZs9ok7l9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797
Received-SPF: softfail client-ip=52.101.43.40; envelope-from=apopple@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2025-12-26 at 18:15 +1100, "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote...
> [You don't often get email from fangsheng.huang@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Jonathan, David,
> 
> Thanks for the review and for pointing out the LPC discussion!
>
> On 12/23/2025 6:01 PM, David Hildenbrand (Red Hat) wrote:
> > On 12/23/25 10:56, Jonathan Cameron via wrote:
> > > On Tue, 9 Dec 2025 17:38:41 +0800
> > > fanhuang <FangSheng.Huang@amd.com> wrote:
> > > 
> > > > This patch adds support for Specific Purpose Memory (SPM) through the
> > > > NUMA node configuration. When 'spm=on' is specified for a NUMA node,
> > > > the memory region will be reported to the guest as soft reserved,
> > > > allowing device drivers to manage it separately from normal system RAM.
> > > > 
> > > > Note: This option is only supported on x86 platforms. Using spm=on
> > > > on non-x86 machines will result in an error.
> > > > 
> > > > Usage:
> > > >    -numa node,nodeid=0,memdev=m1,spm=on
> > > > 
> > > > Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
> > > 
> > > Given the discussions at LPC around how to present GPU/HBM memory and
> > > suggestions that reserved might be a better choice. I wonder if this
> > > patch should provide that option as well?  Or maybe as a potential follow
> > > up. The fun their is that you also need to arrange for DSDT entries to
> > > tie the region to the driver that actually wants it.
> > > 
> > > Anyhow that session reminded me of what SPM was designed for
> > > (you don't want to know how long it took to come up with the name)
> > > and it is a little more subtle than the description in here suggests.
> > > 
> > > The x86 specific code looks fine to me but I'm more or less totally
> > > unfamiliar with that, so need review from others.
> > > 
> > > +CC a few folk from that discussion. I wasn't there in person and
> > > it sounded like the discussion moved to the hallway so it may
> > > have come to a totally different conclusion!

Indeed it did! We had an interesting discussion. I'm out of office for the next
week or so though so don't have much to add for now but adding Gregory to this
discussion as well.

 - Alistair

> > > https://lpc.events/event/19/contributions/2064/ has links to slides
> > > and youtube video.
> > > 
> 
> I watched the slides.  Actually we've been experimenting with
> a combined approach: SBIOS
> reports HBM as SPM, then driver dynamically partitions and hot-plugs it as
> driver-managed memory to NUMA nodes. So SPM and driver-managed are
> complementary rather than mutually exclusive. This patch focuses on the
> first part - enabling QEMU to report memory as SPM to the guest.
> 
> For the `reserved` option - agree it could be a potential follow-up, though
> it needs more investigation. For now, let's focus on SPM and soft reserved.
> 
> > > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > > index 907cb25f75..cbb19da35c 100644
> > > > --- a/qapi/machine.json
> > > > +++ b/qapi/machine.json
> > > > @@ -500,6 +500,12 @@
> > > >   # @memdev: memory backend object.  If specified for one node, it must
> > > >   #     be specified for all nodes.
> > > >   #
> > > > +# @spm: if true, mark the memory region of this node as Specific
> > > > +#     Purpose Memory (SPM).  The memory will be reported to the
> > > > +#     guest as soft reserved, allowing device drivers to manage it
> > > > +#     separately from normal system RAM.  Currently only supported
> > > > +#     on x86.  (default: false, since 10.0)
> > > 
> > > As below. This needs to say something about letting the guest know
> > > that it might want to let a driver manage it separately from normal
> > > system RAM.
> > > 
> > > > +#
> > > >   # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
> > > >   #     to the nodeid which has the memory controller responsible for
> > > >   #     this NUMA node.  This field provides additional information as
> > > > @@ -514,6 +520,7 @@
> > > >      '*cpus':   ['uint16'],
> > > >      '*mem':    'size',
> > > >      '*memdev': 'str',
> > > > +   '*spm':    'bool',
> > > >      '*initiator': 'uint16' }}
> > > >   ##
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index fca2b7bc74..ffcd1f47cf 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -431,7 +431,7 @@ ERST
> > > >   DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> > > >       "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]
> > > > [,initiator=node]\n"
> > > > -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]
> > > > [,initiator=node]\n"
> > > > +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]
> > > > [,initiator=node][,spm=on|off]\n"
> > > >       "-numa dist,src=source,dst=destination,val=distance\n"
> > > >       "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
> > > >       "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|
> > > > first-level|second-level|third-level,data-type=access-latency|read-
> > > > latency|write-latency[,latency=lat][,bandwidth=bw]\n"
> > > > @@ -440,7 +440,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> > > >   SRST
> > > >   ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]
> > > > [,initiator=initiator]``
> > > >     \
> > > > -``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]
> > > > [,initiator=initiator]``
> > > > +``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]
> > > > [,initiator=initiator][,spm=on|off]``
> > > >     \
> > > >   ``-numa dist,src=source,dst=destination,val=distance``
> > > >     \
> > > > @@ -508,6 +508,13 @@ SRST
> > > >       largest bandwidth) to this NUMA node. Note that this option can be
> > > >       set only when the machine property 'hmat' is set to 'on'.
> > > > +    '\ ``spm``\ ' option marks the memory region of this NUMA node as
> > > > +    Specific Purpose Memory (SPM). When enabled, the memory will be
> > > > +    reported to the guest as soft reserved, allowing device drivers to
> > > > +    manage it separately from normal system RAM. This is useful for
> > > > +    device-specific memory that should not be used as general purpose
> > > > +    memory. This option is only supported on x86 platforms.
> > > 
> > > This wants tweaking.  As came up at the LPC discussion, SPM is for
> > > memory that 'might' be used as general purpose memory if the policy of
> > > the
> > > guest is to do so - as Alistair pointed out at LPC, people don't actually
> > > do that very often, but none the less that's why this type exists. It is
> > > a strong hint to the guest that it needs to apply a policy choice to
> > > what happens to this memory.
> 
> Got it. To clarify - this patch only handles the "reporting" part, just
> like how SBIOS reports HBM as SPM on real hardware. The guest kernel
> then decides how to use this memory based on its own policy (kernel config,
> boot parameters, etc.). Will update the docs to describe SPM as a
> policy hint rather than a definitive restriction.
> 
> > 
> > Just curious, it's the same on real hardware, right?
> > 
> 
> Hi David, could you clarify what you're asking about? Whether the SPM
> semantics are the same, or whether this QEMU implementation matches real
> hardware behavior?
> 
> Best Regards,
> Jerry Huang

