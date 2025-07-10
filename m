Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491CDC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 23:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua0Jy-0005mf-WF; Thu, 10 Jul 2025 19:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ua0Jt-0005jH-Q0; Thu, 10 Jul 2025 19:04:51 -0400
Received: from mail-co1nam11on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2416::618]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ua0Jr-0007kP-AV; Thu, 10 Jul 2025 19:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkCbKtzfMQvYJzqTiVZU1tcGL3Feu+UcevOVbI/YLCh53bqMRNi5jqlmEQB7COIPS5Ip+4hHBxHYJHYM8HK+htIlZQAkKmAJBqTF+aRaBL/oYX2cv201Lugdi/FQC7HWIERbQ7Ya8XfmlcKYxlfcgbXeQcIdPCc8QhuVGaF1aErLktRKurhxHZcDDRJlMHXoq/ey1M5B7HW9ogPZusoOs9/WPtD32BTqWWiOujZRFTteYtI3wCsJk34dJcVpg0RTqOJExZtNYTtG4NTjYTEmTCX7LbqqAfmlntxz5P49aeuKPqvNCsi6rHExypogE6qZD88PqnDp50McRpM69xVa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYksPqydO0d6pfZBmypTKn96zS+EXwyH7CXQ395pgmk=;
 b=eIL+gvgS0GkU8VLgr6tvWwnTWI7mYG2iABP3i1U/r81WyvHP8Agr01Qv1NyoZwIQEqrYADsnxGKpjG1POWRsGzgf6sbODd3/BjJxVjCbzuOwygfzJPToGpBRa2bvwY4O6KnAaSQdMBoL8MJIwo/e/nbbEc5wsgLpSISIBi/bDDp+HrD76fRr8ZeEHnfMojV8V0//YWouyvYnTTBKUGkqV4sg55Mj82m7+o4P14PNvUM9hIrBQCb+FYBzSeLffiK57kI9NZH2HVvdE0iXuIeni5bmJLdh1kZwipEqPJjWyMigftmp42xe8KJuX8489wBpwR2Wjdnlv3LE6SONWEmfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYksPqydO0d6pfZBmypTKn96zS+EXwyH7CXQ395pgmk=;
 b=EsD4M6h0goiIH9+81FgK1U5mOerkJk2GMj1/im66uY2d2Hue3UI7wcn3UEhCcCbrqT/Ad6QPL+fGe0RcDinE82p2eLXAv4xvPiQRUPu2L6+mY4h420bd6MvNPeI2d9sEhsOETMba9vcgZyCNlo4072E644ziouKZ3BPe4DG/DIyfU4+T3gMiEnVnrrH8LtLzJP5+OLLjI3BydK6s5obTncFNfuiTSLSekvwD6e3QDlMJINgErPg6okVzBml87JDACJVQ/vp7pkB75yYjkmbTCYQkV73cbFh6wywC6wYXl7W2R72RoIu5pYnmywJqGIFXaDqFKmTJgZvJ2iSzsjHolA==
Received: from BLAPR03CA0108.namprd03.prod.outlook.com (2603:10b6:208:32a::23)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 23:04:39 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::ca) by BLAPR03CA0108.outlook.office365.com
 (2603:10b6:208:32a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 23:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 23:04:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 16:04:24 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 16:04:24 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 16:04:23 -0700
Date: Thu, 10 Jul 2025 16:04:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, 
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 00/12] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Message-ID: <aHBG9U8mIm2LFsdG@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <1291e658f6284fc3b041b599ad375ea1@huawei.com>
 <CAFEAcA_eX0uwYcVjSN=V97xh3uHs5SgHZOx_wYkLC6TNCX7+9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_eX0uwYcVjSN=V97xh3uHs5SgHZOx_wYkLC6TNCX7+9g@mail.gmail.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a92d64c-d3b9-4448-970b-08ddc00625ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PRKwCjKymsXsfItE835oIMkYHiIUJ0DL8hgT7YzQ4L8uCjKJ3yHXX96KItcy?=
 =?us-ascii?Q?t5VcYJ3TVXRhQc5kJrVoh4zzUdHUCIwFmbKyj9i1Mi9p1D+k7dDEvv7DjD+G?=
 =?us-ascii?Q?mRM5EiJz2H3aAOlM3uX9CEIuCmmWMDE6FZgQSSdMAluQg89jSzDqP+UYODyM?=
 =?us-ascii?Q?Z17gQa8u48i/zfckGFK2WhVSpVt+loKtlU0cExF9q4oKlqmuzrESpQAUtEm1?=
 =?us-ascii?Q?+AC2HozufB0pxBeUKEx6Qe0uJxdTZfzG4FCw8z9F8tPcUOmryGvosQBzoIqp?=
 =?us-ascii?Q?QfeJZyqdOxLMX9Am8JlSMBIvqmvI3nrr3dolkqV9aof3ML6/rEy6fKN355Jw?=
 =?us-ascii?Q?qJXQX/NiwqGR7n9H1VCUORdtOpky/KcFhK30Tn8XPg/euZRmxM2e8K7y1SPU?=
 =?us-ascii?Q?G6Ef0iX2a9JmQmcp/pu9uR0WuEFimY+BfMjWx5JXniaAyWk+GoM6SjJGqRrN?=
 =?us-ascii?Q?Boy4QtTe1NNo23BmoRw2B9gzstotim6coCzuzllFc0hvjzFdMxmbhapWPJsS?=
 =?us-ascii?Q?v9LLZVt/Jwn5fLshje0pT/woDG2kYXRPYG1gmc3Xm1hDd6HIiP0C7hGvDL4x?=
 =?us-ascii?Q?XVQfZjxLZ2i5Z8Je42uW9axBt0tveocFswwtQkjGZPhpYpulcf5TNS+FFkfy?=
 =?us-ascii?Q?FYjOOgXXYGQWUdBpZbYU84uVIJEcJwNkwxuAXq/Xv0iv8XhMCAOYoU0meqwj?=
 =?us-ascii?Q?6J8lqVUYTQcbv0gZmY0dA/w2M3T4ZTrpbW8q4d98HF9DCJcfdd94c8nOM6dW?=
 =?us-ascii?Q?DBg/hphiapzV/pAnXN3jCDvFovejgrEUJXMlb7s6LK8AAqkRmfyrvw184Wrs?=
 =?us-ascii?Q?NZ7W6fEiYSwFJyT8SjEBb836wZXDiJtJNf7Q6PANcX5erpo5hA6x998TZBxU?=
 =?us-ascii?Q?Ej8JQzw2vsBjxj4URayNYUEb7bW97GQ4xi27jNU0RaQ/lmtGS8285J8I53V/?=
 =?us-ascii?Q?QqSUw2i+O8pNRNk3G5aW6x/ldt51uilOr3BAEmhx2tVNzI+GU8wJE8m6+IgD?=
 =?us-ascii?Q?Jq/CG63maqTIW7wZQZpOXckJ1HPLBA7ScIzEN/gO/jlw3dorR/+nWVaPfMxH?=
 =?us-ascii?Q?sCkgJOcwBKNfwiuCL+XwQtVGgAArMlYfZfyKncal9rDGiCb0XzQgT0/CuA3q?=
 =?us-ascii?Q?emd2roZQPLJ74H/5mqwnLn9KJvpHoie7M7QjAXYzbh1YUq7l8ky1QcdjmkMo?=
 =?us-ascii?Q?/nVpn0/AIWrN3u2Z2vg8J6+PWMtl0AZxpn2xZGTXKTgte2u1C024aJUwtWmV?=
 =?us-ascii?Q?L3thLYA7M4fTo/oPT/2HxWmXjSllyDA5P2nU07ZAiCNB6SxgndTsPLSqlH3a?=
 =?us-ascii?Q?pHXLb1QJ5UY1QkgWIYESWPkRhB0JA7DHvQ8R0vidokmQ/c8EkyAUArTfQuDY?=
 =?us-ascii?Q?NKlK3GL2s0seFnIMQB9bG98vTFUKLhuk1bOyj1XGTQTxDNuCjrzCELO5WsDT?=
 =?us-ascii?Q?mOF165FWd1Nc19xehhXeLvp9eKRsmlbpE1+e5Qwf54hrnCW2ggYQmGkmILHb?=
 =?us-ascii?Q?py1Mp+Uw3jzbe3lde/yM43/TOkdZcALWxyDvyHP6E0cWJuag4iwfoLRnPg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
Content-Transfer-Encoding: 7bit
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 23:04:38.9166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a92d64c-d3b9-4448-970b-08ddc00625ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
Received-SPF: permerror client-ip=2a01:111:f403:2416::618;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Peter,

On Thu, Jul 10, 2025 at 12:48:20PM +0100, Peter Maydell wrote:
> On Thu, 10 Jul 2025 at 11:10, Shameerali Kolothum Thodi
> > > Changes from v6:
> > > https://lore.kernel.org/qemu-devel/20250703084643.85740-1-
> > > shameerali.kolothum.thodi@huawei.com/
> > >
> > > 1. Fixed the warning case for DT support, reported by Eric(patch #8).
> > > 2. Picked up R-by's and T-by's. Thanks!
> > >
> > > Please take a look and let me know. I think this is in a good shape now
> > > for 10.1.
> >
> > I understand the soft-freeze for 10.1 is next week. Any chance this series
> > can be picked for 10.1? Please let me know.
> 
> I'm afraid it's already pretty late, and you seem to still have
> at least one person with comments/questions about this v7
> series which has only just hit the list in the last few days.
> So I think we should leave this until 10.2.

Sorry for hitting this series late.

All my questions were addressed. And I have given my "Reviewed-by".
Once Shameer confirms (maybe with a v8), everything would be fine.

That being said, it's still up to you to take it or not :)

Thanks
Nicolin

