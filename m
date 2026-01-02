Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5AFFA3752
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 15:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbhKw-0006i9-2K; Fri, 02 Jan 2026 10:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vbhKt-0006fm-N9
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:45:07 -0500
Received: from mail-centralusazon11011003.outbound.protection.outlook.com
 ([52.101.62.3] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vbhKr-0002AT-QE
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:45:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcyJk9SY7nm2E7gVNcMyxIZM0rbvr1PTNUaDo3jX7J7hNW1BguvAioAI9wFUYW0yOmLf0aCkBdHSgzleMngYR0ykba/18NntQygrXBggHNkEiiQ75D761MOawMh4IaX4L0Q5Zw0yMy3A1OwQVFfSL6gGWAYP/5zIepyQ7x/yruDtTAJiMhsYawTjeJx/PVvothV0YR5g8CfV82qVkcTQT8KVTL+GypdFRbR/v5bE9yhGped/c+d2fwUuA6hjvvGVmPgZRHX8WzLyuka14N/MaOGYJLZF4p58TDT5fels8bZf99sIsctEdxyyDSSremSXzq5h0AwirX82F8imfXd43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhtSPRHGuXI4JZPIB71D+l4LWbCAMgwMyJ1cuqBvNrA=;
 b=QNpaKHJudDWJa8HUBPOf6WlAl+jGK4giYjYehC3JSgUq7RidFWBfDB5YvRWamqhYYJ95RLTLCU8hwarhYdRMsp6osETQhpbaaetrJmVg07Zvk8NoEwBso5klWW5lUKzWDJxS4r3PqVVvQFSbFxDfuyd0tq67PrNiT2veXM+RUIJBdiDz7WekkqwX8XWS4QUDGtbkKufvj9C0SEAFW3iMq6G4CTnBr9cCGQtDoRxZJKfyzza2QQEspiT7IOiK37UcZhLDi07Ye2URV38MZ566nYUqw1LGRiVlQTcxT/ksB0pDZscWdTX9qWvWHPJU7k+RYv564cXQsc5UIKF8/dpSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhtSPRHGuXI4JZPIB71D+l4LWbCAMgwMyJ1cuqBvNrA=;
 b=qstxFsqcDXKO/FKRUYy8iZzhwKgJF9Big5C3qbWofylSuma1PHuB/G3BEKK8BkNU/vEU2T0EfL94rDe659L5hfu5s7oJMEyhYLGnXq1CG4u5m24HPYzbBCE6OI/I19Ilgm0JxwTyzjI4Ww4HPsad7Y6u2bDpoP7w3G7rWiOCJBgk/JgSHukJqh3K/u1u69LJblV6lVayacEdJ9u5NVsWoiteMJ22ac/mL8AIZ5FD9hmRkjJtT+PoIZ6d3kTTOXEvrcRBuZ5Eh5uMppmbDrMWWSdDtXpi/HppvPJM9EQJWMDk+P9Z2t8aHuePBeoqa6cX7VJLsXTi//1VryO3hmQYKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 15:39:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 15:39:58 +0000
Date: Fri, 2 Jan 2026 11:39:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Li Chen <me@linux.beauty>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, David Matlack <dmatlack@google.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 0/3] CPR: shared RAM with /dev/fdset for LUO kexec reboot
Message-ID: <20260102153957.GA125162@nvidia.com>
References: <20251229120839.89817-1-me@linux.beauty>
 <CA+CK2bA1Xv+asZ3d2jALk+VePDdDg+4ao0Y72CWV2i0rg3GsyQ@mail.gmail.com>
 <19b6e60dfd2.187d822f1751681.8912147399180739154@linux.beauty>
 <CA+CK2bC0N7v7MnC6LybAzE_oJPWeWK0v9xVng-JgEnvC6ay+nQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bC0N7v7MnC6LybAzE_oJPWeWK0v9xVng-JgEnvC6ay+nQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 8431c2a0-213e-4adb-389c-08de4a152f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?22pEbGom1fnl3VsKmxlF4hKuEiEeahOG6uLCEuDqmUMxvKhgtcGMNjjfHfl7?=
 =?us-ascii?Q?2aNUkY4hSKdWcCSxLe4a3BoLzcaLTOKQYHOzurCHEjjpTHDlLUo4DbM/zV77?=
 =?us-ascii?Q?2Km7aX+pNGog5e5na1OxuP4Bw8gA4EuwvRp3R84UKpd0hSad7sOU7Pe/oySL?=
 =?us-ascii?Q?HVwM0H9WKGK61RSwcr8bYfdhNIYFu0gA9fuiwRKb5j9bcJ/X5Tx6VqKmYNij?=
 =?us-ascii?Q?k+/xN81sV9qkdL9JZT5q1YLO8zqhyd+FzcvWD6KKjF4rjxAo8g3RcmRXiII2?=
 =?us-ascii?Q?iDXnSZN+dR0Ie3UyGeGoCkDEiAgZ7+/fOfQc7M22S47nbCalebt2rWPQLSbB?=
 =?us-ascii?Q?uS8VOVmTGCFyc01uIe2fKTvJp4G369Xad1dBqYsLgvcB1kaSZcBjvDd87kqd?=
 =?us-ascii?Q?fRKZb0Ne8jDP+VK8EVcC1k0m4piyjsA9sMnX7bcMDfdEGRmd/yAvWhE5vgXy?=
 =?us-ascii?Q?PEwRp5geDLLKI+D/bHbCbI+H4gNog4Vo8iVMwW/BmGA41KwCUj7BgoPtnv8n?=
 =?us-ascii?Q?gkjTZ2+b9jjb/hRQXCV50X8BKyDypqZY1csInsukSxJ7Pc2EcGnR4pdLgPiQ?=
 =?us-ascii?Q?WMckdIh0SBrE9ZNS9yhYu6DKc51UijEjr6fwcpewCJCQnsn8UFN/OVbMHoHC?=
 =?us-ascii?Q?3JPYCcRZwZztGEs9Xm3Ry1JKkTQjhMUw9mFiFWQUpKHcbIGpmh8LnOjJ3iyl?=
 =?us-ascii?Q?EGe7S8t5Q7pTTJsks7qCVO4MZSfDaN8qePqOr5VsrUb5+wRKLlhtV6XMzrji?=
 =?us-ascii?Q?lLY4vLzLcUUZcelZuUyNGpB+csivMOTdTAwqylVVn7CKIn2ZL2mb5G8UH4mt?=
 =?us-ascii?Q?Hp/8+99U+z8SZuoeC423yWGRza8aheRhjDiVhY9lV8riFJL5ayMUwtAp3jS1?=
 =?us-ascii?Q?9ZtvkE4CKuK2iU0YF2h0dP13IKZ9UJFs/de49OHL517KQyteBkrjNdOv+5AE?=
 =?us-ascii?Q?YwSN3KF42+vmTY/nGDorxdvfn7x3ia9EO2z46QqQoebveqv3kodpTxkL/2Vu?=
 =?us-ascii?Q?+knTK8mO4GAtaJPJYKHF/suNJGfPTXEdQVZYZgvS1mlFq+XAbqNQrv/o9yQv?=
 =?us-ascii?Q?Wsn7SPS2BCQF1ag6EYU7YLGrS20z+zW6sLydr9mVLouK02iVacX7UtklKc9L?=
 =?us-ascii?Q?ZvhEf6BpPAipMxtRzwMi28oKcEnDViWcMjpiFLFmyr/zxdhCwvE0LSQQDYlh?=
 =?us-ascii?Q?qvpLH/aXmhYCp96alKmuPyfmsnP/7vLtAcZlhvqw5iNe8u4/VTQhKIVkeW24?=
 =?us-ascii?Q?j7ALEHFiJBjQkp4ufeAWDYbiE4BKNO6TFB2En3XjOTHai1M+jjXRtOe+6qVZ?=
 =?us-ascii?Q?lFVbMBBOhmdQpffMM+a5t5Wr0FtBGOw3e+4rtqQBLtTrgkDetIg1y0xLlqjE?=
 =?us-ascii?Q?VcnNNqRRpxybhhTa1EUd/yS6xKiY4Wx7T6AreKkjP0OrW80qmbhUlJ1WRPLo?=
 =?us-ascii?Q?vNtdwXkh0fHr1gd8YdtKTTyg59paxA6p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAlq6jZT/qjbMQNdcESVZqDtfv33pfOj5xPV5IWblpEBQGrQWUkVNupig/l3?=
 =?us-ascii?Q?XiuP8f+Noa7o7YNV5uDYo0f/6O361WttABL3BT7OJu+0Ihr1RSlyRa00eBoW?=
 =?us-ascii?Q?VLLT141sCRZz6ZP43Li69cOxx02ODleXP11lr+Ucx/vIUeKi9cAfBe8KS9py?=
 =?us-ascii?Q?ULMFJhJbqfuSvSof8Bb9Cf8UeGnf/FAcYjESX0rJ9Vx2S9qv37gJt5iskAsq?=
 =?us-ascii?Q?in2hyODOR7FjIoOsNNy1Hi0+iVwlXkKV+3CKmZ8n25z54HP6jNczPS823YAw?=
 =?us-ascii?Q?LAW0vSHU/Hmw0tgjALSFK+THY2AvA8NkRaYOwPdDVBDqdVs1g7TgywY7hCaD?=
 =?us-ascii?Q?L8tV+LL0A3tAbkfRYa0qfbrj4VGdX7AakgtpbHR3cepxLZpczKrhF8Kgu9Xm?=
 =?us-ascii?Q?Fn64O4DWQgGYwM0BlVY5HEXNJ29JXW6ZRWXiBFmPoBezp04jn63ZOhooCOpB?=
 =?us-ascii?Q?+3oOxjKS0U8subJmlxtxufrWdfkJQWP6ERxOj4aPiPHRygh3FyeNUv1kwDQJ?=
 =?us-ascii?Q?8rjkVbTc4b9eTNUBvFBJmWXSs6TsK6Vec0wssL5P9OfUZairQJf1uVUp9Joi?=
 =?us-ascii?Q?jaOhX9ehXhbGIL8Cn+x03xbEEaG+F0Kq8fHySg6ybQ7Yx1QkMPTff+4aj2cY?=
 =?us-ascii?Q?6HOiBFgjsJqclCOHyiAaPqvP0aI9hMSKVAGxUqVIIncRZjjP4wg0oRvekMvj?=
 =?us-ascii?Q?qUOt3BcXRLeeAryIhhHU46oAjwildvK2xrw/biaBUpXor89wohrpGDYTXfm5?=
 =?us-ascii?Q?7wklNCCkDdBbVHAReLwu2zJGaGM3Q1StIAcGR+fRHWDKYB+qkviPTsc9z9qA?=
 =?us-ascii?Q?RUy6jeouMA7wr1Jx4EIdhVSIee2yCPup+rsBPBbP+67sYKO2TK+u4SGlqD4X?=
 =?us-ascii?Q?ji9nRh7nD5dxMMH/+IfzSW3zK3QO5I0O4Xy0+5hyn7o6aGKS5iPvfrxyotv0?=
 =?us-ascii?Q?rTh6c/GePm9bCOHwtARbRnHGjgGOIo3TyxoeMblmkLreJlqiv6lME/nbuFRT?=
 =?us-ascii?Q?4If9Ad1uXetcGbKMbAFyiC+1Yp8ZaUBdwlKtCNBcqlBF80ifUs9ajFTGkI2a?=
 =?us-ascii?Q?ch/rn2OKpiMfNCEomS4KWcJNp9QE0Noodh0mP45/t4OzZflBdu5eRE5/P0qR?=
 =?us-ascii?Q?GbYHUrQrXazpTnk1Lzmp9rEJh2wSlY+lRfjAoxvTjEZFOuYBvklvXkcSsD77?=
 =?us-ascii?Q?r6uobbUXPllWzXBM1dZ1bNbSnHgKQHVHEvosKmnVupGnqdOd0NTjsRQ4f0jl?=
 =?us-ascii?Q?gorgh26f+Rde2ibXfErqfPBjjPiZ2pn5eaoQpDpQEM4B6yNOHNMvNGlmlQhO?=
 =?us-ascii?Q?sjddYSMQEGmCcCDd09b9WXNjcipeufOoSKU0Pv9H6YqF2517y8xm/59v/L2I?=
 =?us-ascii?Q?fRkfhJdbZO4IU8oHxWrYSWiGj6k37N9UqnsTFD7lUlNWGgp15MSUPm1QdHfw?=
 =?us-ascii?Q?40wsLZ1YomSTdZu7Kr2doVSaikFosZKqep432Tsw3gPumTAfJ1AL3DLecRX1?=
 =?us-ascii?Q?ZGuOnGgE+hAEtWl356dI0LUWfMcKQHAZVll3X+0Yi8nvMPyNDAzXN3jNVXDz?=
 =?us-ascii?Q?UH+JiSuGL3vCjmzgzbiKf6zceFLj5tbDcTkuqlqKQHLloOfmv/iaqoIYsepd?=
 =?us-ascii?Q?Q2JDzqRlrH+lm/cLdDfFXoBpcgOUrdJ5sj2lGCFKQpZNdlk71dj6/PcV4uyZ?=
 =?us-ascii?Q?+sc88Qn+wx/Ljs6IXK6ecMj81Jd234pxfdnmGcS3zeEUF7XW7LUKFeiFYldx?=
 =?us-ascii?Q?gRQM1eBqag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8431c2a0-213e-4adb-389c-08de4a152f39
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 15:39:58.9268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oihqA+o/AWwiQ9bmw7A1mF6t6PmeDkbpqSZIyyQa1KDL7aeIzx0JVPOmkrD/VQny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
Received-SPF: permerror client-ip=52.101.62.3; envelope-from=jgg@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 30, 2025 at 11:42:09AM -0500, Pasha Tatashin wrote:
> > One question: in the intended LUOD/session architecture, do you still expect
> > clients (or a wrapper) to inject the retrieved guest RAM memfd FD into QEMU
> > via -add-fd + /dev/fdset/<id> at QEMU startup? (as this patchset does)
> >
> > Or is the longer-term plan that QEMU itself connects to LUOD over UDS, retrieves
> > the session/resource FD directly, and consumes it as the RAM backing without
> > going through -add-fd?
> 
> The latter, I expect QEMU and other VMMs use their LUO session FDs
> that they receive from LUOD to retrieve and restore the preserved
> resources: memfd+iommufd+vfiofd and resume the suspended VMs.

Right, and we shouldn't have something like /dev/fset/ID at all.

The VMM has to know it is doing a LUO restoration and squence
restoration of all the stuff the preserving VMM put into LUO.

The general case is far more complex than just opening a memfd.

Jason

