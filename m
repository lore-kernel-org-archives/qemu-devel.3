Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBA6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFybg-0001Ga-Nm; Mon, 03 Nov 2025 12:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFybT-0001Fy-O3; Mon, 03 Nov 2025 12:44:30 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFybJ-0000ab-7j; Mon, 03 Nov 2025 12:44:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx/tOWKJCYodw3NOWUM9KT7OkRi3rQiNK7ixVjSce0ZFYNK0QW6OZ12SP3t1xBpGHw7OiPbkJq66LJ19mAyv9O1hGmrTNnZr/qnKZ5OAIu8kBxlq7ct2XMENi7/Sti5Q7Lm84dbLhbE5zEpKL4rD/ccuC4L4wGqSAELIQyhINrk0rJkE0PtBMuCkbidYtXeMcXVV14e+W28WM+MDaaTr2ON8JzPMUvifNfEMGLaJBoVIKoQTIftYnzfyUFVQnZurkOeRqUHCLOOTCeRS/5YzUMFJbpDy3L+zbhwwG4/hhF/PGknuIn4EO+WIXrhefE4Tv+liuUgEW0q3SG6UgJ68Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tZs4MOj9uLC1A2q3FdEtPBN1IrB3GGlXL4sxy2YFbY=;
 b=dg9UmMggMqhrxlVRwoSy7Av3S4Bt78EzuoKR+BO7YgHgVQNB7VKlztANDGSS1v4Hm60vcHTS6iHro41u3oKVLNNE6UeZeiQgxv2qRfvZPdNDrezemc24YGdRMmF7KDiXhpPmmIKFzVGHBqy0u9wxiIQSMZqu05LSWcRlLYBqmgMcIzqikD+FLlbQLbtjcSml+QxjtkfPsIWpPOgQjWaRJLeH6dn2CIVZdYbD05FAGTR6KEG1xD0i3Kg0CTRSwI7IKB4tB6cJb0AEIRF/3qXZJoPe8zxwZjkMmIhbIFr551X9d0KNNNiE7vnVNJKZ2tKp6nXYQmfLLkQaY27lC5C2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tZs4MOj9uLC1A2q3FdEtPBN1IrB3GGlXL4sxy2YFbY=;
 b=gEbcQyx7CKs8n7KFqiUHtt/MeqmUBVlByOrq1Nsq8+YGhMNrgzSgDxKoHJyuNCYpdIQqeoHuKLXo7PGVlp0e/uUfdK1IO8dUvI40TBhmoqbBDmrkl/xM4EJk1ofa/SXXakXCyts5HFRKSQq6n2d8Qp1L4RBKPr1FeqgrT64J6xQfWgK9vXb0NTJ2AE7ROgO+Za31S7n8pLMSh3iXk4dKtTKBJ5zf4Ntusf2m46iyOsmSIQ2Dq0Z6voD7Y3sdnxFkht8NaSJOD85J0VVqF+0K3Q5y7Azg4hmZzoCRnzg8gXbyHDPghVnKpfv8CEMLU6X97IMgZgr2e6K/78z9Q8AjMQ==
Received: from DS7PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:3bb::7) by
 DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 17:43:58 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::81) by DS7PR03CA0062.outlook.office365.com
 (2603:10b6:5:3bb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 17:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 17:43:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Nov
 2025 09:43:44 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:43:43 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 09:43:42 -0800
Date: Mon, 3 Nov 2025 09:43:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Message-ID: <aQjpzdwbJVPN7AqF@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-18-skolothumtho@nvidia.com>
 <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
 <CH3PR12MB75481D898FF28E9832B0013EABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75481D898FF28E9832B0013EABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 72096100-962e-4f7a-b203-08de1b00915c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pjivbQHjLGaheeA8GBSvu8hVtgA04+UBl5MJAcygl4HVVCTWYjtbyHw0gPcN?=
 =?us-ascii?Q?pJsKt8JbLDZFzd14O32NvgvdWq3Zzq9TPXxRLbeDyWC1QJjk82K7vCqvqfnV?=
 =?us-ascii?Q?isE8jGLxEEMMCRCOpgMJYwxUoWtxinmHwn7spRW2Lef8qiWtYmQXENrG/73S?=
 =?us-ascii?Q?Y2bojGKrw1AxxjGoRi8PGP6BcI8LdUQvcZ3kl1hXDfRm4LXU/D6sgt3Rs7w+?=
 =?us-ascii?Q?9jKtikr58uax5LSZNBqyZJGtQ4Evv0FNXmm1ZXf4rwxkiDF+/PY4fVXoQztF?=
 =?us-ascii?Q?DD2lZ1bNI8B5mcLNtwzH8KOscYlDNrEXkMTlngetTb78SjduPnw4qrSnxn+p?=
 =?us-ascii?Q?fNGpjAj2BaB1ZBvJvA7B31hbmWVX3wLyY9Fn8Ub1RA+H98kU04wrsgETJ2kg?=
 =?us-ascii?Q?JBJcuJlVgjRQiy05YyGKisjl6tQuTc95ANsHlSts95gxqOvhKzutA2nJCT3x?=
 =?us-ascii?Q?ue9LA8zJBzPmqyQDmQpdHFH+FiYwalDZ3uqwJibHj7/EKnPH7GaQtbEl1hho?=
 =?us-ascii?Q?vmLb9Nj8kaudnLn7WniTLzXFmIW17djDh7rOxAuNK70X2dI01Yr8XTPm0Jpj?=
 =?us-ascii?Q?TLIvxIqoabsCA1BabJkZBxSAbL+2Gw0uaEjHQgyKVFqo1ZGwvF9vV5bsHhSz?=
 =?us-ascii?Q?9z6BYpUOB7YKR0NO4VzVsflsfc+p8vYjKr/5aozJaxWON1L+B78w6dw/mdxV?=
 =?us-ascii?Q?tT6aexAlZH1bZ/l5sUZT9WRzX+cHNtVW8kvotBK40EvLVXNBeCLF9CGBHT8z?=
 =?us-ascii?Q?MIfcWFFSLyxLimh3Q1+8ii6LwytSYqm8d/MsFcA8ctSaTlnriPOIUFANd7MZ?=
 =?us-ascii?Q?KPQ04mJnXRkCncH5+1mLpIF45BuPJz1VLVFYcGMQ0p+onKka+9+/+PFHzxgZ?=
 =?us-ascii?Q?zOtFtHHPxfgkc18I1Oo/GZaVdvUmbTMVAllErkb/TL186JrkX9E2u7x6PKxi?=
 =?us-ascii?Q?ckyQd3q1Ts2qCkdERRsHShsYDbHatxEtONdsoKFT1yL75Y3zsyqxPhIc0EM0?=
 =?us-ascii?Q?VWV+fbKjH0ep2WgXMhbS1CW6c/6hNPqoJmbNyOVx3pW9ngxqyFzacQCVfVCe?=
 =?us-ascii?Q?gKbJSP0ltZWGso8l5NLFfUWwmlK71uMRWKZd+4DqytboO3SerxPGcl3uUtSC?=
 =?us-ascii?Q?+d1yEhcYi0maJFWc3EK+bTrswNHrAV8AUDA9ijnZBd9yqoQ86UnHYc1ZX0hf?=
 =?us-ascii?Q?gntE7MXgDe96qIHuWgzvltQAUtMMYdU/lk8Fn+j1wk+U2t8ZZW6gci7Lb40a?=
 =?us-ascii?Q?RaXdCuBfFBm3lJjxYTrLn4PbEwm246Ry3mc0Qex8Zt+jDSfgJrEmEW+YoN0y?=
 =?us-ascii?Q?tuaBQA/nXbakhp9JFIgT24gZ8D2NLKpPt0xCpxYWa3gnnZbc3BBwTQ4/eHl7?=
 =?us-ascii?Q?IHmYi/s/bK+g8WajbIwNoglPreH+ZqKLCO4CBj2xWwFl4sI5UBbv/Fj2swve?=
 =?us-ascii?Q?ppKnuMrWnYVnlkkjeEUNku3nATR93f9ZlI84W0bYCKpbBj/HXz5INBiDtQQ/?=
 =?us-ascii?Q?SXzBz1SZ5IScUnJXsmChSI171cFdxvGsy+qm4CiTtfwYqTVXRPM/d7UvrB24?=
 =?us-ascii?Q?E/f1ETlzxHA0yyG3jLg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:43:58.4439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72096100-962e-4f7a-b203-08de1b00915c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

On Mon, Nov 03, 2025 at 07:28:14AM -0800, Shameer Kolothum wrote:
> > >          case SMMU_CMD_TLBI_NH_VAA:
> > >          case SMMU_CMD_TLBI_NH_VA:
> > > +        {
> > > +            Error *local_err = NULL;
> > > +
> > >              if (!STAGE1_SUPPORTED(s)) {
> > >                  cmd_error = SMMU_CERROR_ILL;
> > >                  break;
> > >              }
> > >              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> > > +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
> > > +                error_report_err(local_err);
> > > +                cmd_error = SMMU_CERROR_ILL;
> > > +                break;
> > > +            }
> > >              break;
> > > +        }
> > 
> > The local_err isn't used anywhere but by the error_report_err()
> > alone. So, it could be moved into smmuv3_accel_issue_inv_cmd().
> 
> Though that is true, it is following the same pattern as 
> smmuv3_accel_install_nested_ste()/_range()  functions.

We could drop the one in smmuv3_accel_install_nested_ste() too.

> The general
> idea is, we will pass the errp to accel functions and report or propagate
> from here.

But there is no "errp" in smmuv3_cmdq_consume() to propagate the
these local_errs further? It ends at the error_report_err().

If we only get local_err and print them, why not just print them
inside the _accel functions?

Nicolin

