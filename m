Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48852C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 19:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc7QS-0000ME-TO; Wed, 16 Jul 2025 15:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc7Gn-000386-2a; Wed, 16 Jul 2025 14:54:21 -0400
Received: from mail-dm3nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2405::62e]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc7Gk-000636-NB; Wed, 16 Jul 2025 14:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQwVknhHid3KemHmkmi40cNECet4sIlr/Iuq9RJQ2iRkGJNNkE36uNNB/JbKOj9BURAp5n/HiapuXUS1RgKulLlRQ6pmxek4dC1kjN3GyJ6WFnrYK0H2+IQepRMoiNx1DR/k1KDOhPHZjrw/WsgdFL+vJaLK+Hw3i2bTrSUBwsqA9V0YXvIJB+KTFOH1Pq50oAvYVIKKUPHEq7ISOGVmUvag/eDCkVfMzGDbAL7V9c57PonRCEfr1ckTHBiozpRu8OjlPHeWhH3ouUEvlLcHOEqmWOGSTnlZe2Eri4gs5Fk2WcarfCFhzvOKK95MNEdDhxR17OnkhidXjvOnXlGKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zi4VU7zOTfpc7wrxeAvXTMDb/VEdd1HJc6rbthSX4M=;
 b=sirbpGFUs0LIgCQeI8TyUdBeHUaaQiSsaXiTwFkeUODh0SWheheek9rHuj4RiW/0zCMHFNDTGK/hyKsJD+7CMB/zK4GgBJA/PnGTtm3SAoYCQMp05aII1Pq8+ZwVLV1IKe4k2CJxdCJcbRx39iEAl9352xBQcbJEkMwgCqVr6zihP1euAFUtPGHTyILtlmxW0RxzBANLQEszwim0QZG1E8lIYtP7bx86bWObZ/RZHH7qsIyMhcTfO6qzqUMeZGZTEbcOTlrkslppox0IFTtw40Oeo/YNTbP2krn2hSxqt+jP3bY6f2r4zfeK69m6c6hZe0lrCPHweUDAtoFaknK6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zi4VU7zOTfpc7wrxeAvXTMDb/VEdd1HJc6rbthSX4M=;
 b=M/YUfCPbLkxMtjdg257PkCXa3Mcc24Hn1nYzL1OfHBXO9eKM3DvjE/1Ks5i1IgTSc8hJancdA+whBgLI9LvAtxQOi/YtpA2midM2HdGDa8bGjo59d3G5dYgWc3vdUITtzx51Fpqx4dbOmZ33dMUtWrUNxscmE084g3QTuRtWiZOKyjyUslxhjWyqF8yL/bzkxffxm+/FloOJs4ILUNW+bIZSav/5AA9CUr8FOlEaxeMMKaxUrmUpGT7v3kjIGbarOaQb17qDO4845CrkErFBmR5yEvV8/gawb9oVifZJxB1vJQwvXdUcPdhjYuzYbirKCA62qOgaX45HsR35760KHg==
Received: from BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6)
 by BN7PPF862C85B20.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 16 Jul
 2025 18:54:12 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::fe) by BY3PR05CA0031.outlook.office365.com
 (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 18:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 18:54:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:53:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 11:53:52 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:53:51 -0700
Date: Wed, 16 Jul 2025 11:53:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aHf1PZAAVlUx6g9u@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
 <20250716115123.GW2067380@nvidia.com>
 <aHfi3SS/V6qlx77H@Asurada-Nvidia>
 <20250716174506.GB2177622@nvidia.com>
 <aHfq6ccB44yupGb1@Asurada-Nvidia>
 <20250716184239.GC2177622@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716184239.GC2177622@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc910ba-46b6-4751-835f-08ddc49a27c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8mqT7JouJpNtKhIz68NDtrn8r0uxWnOuKCXWn/IY93kFCqfCuxOPzkI/H6r9?=
 =?us-ascii?Q?KyAyIZtKbsg24S+d9XjtvzGCfxoIi0XdoW+4LX4XaznVaJRqTgD5u5eOsiRy?=
 =?us-ascii?Q?Q2EPwpJLOimdYDVIiagK8rnRBt5aM7Qd5he5f3OjavQZv8NuDAg07Q8exTgE?=
 =?us-ascii?Q?9RTrY62SQUIL3rUP5sREuumYBSqv/2s1pI7QTwQWXp0FuhCE7SNXB3YFCAuS?=
 =?us-ascii?Q?kRrmOiPianpor73gKjr3L7YEFDtfK/D9/IlgEaeW6RvYtWLdOnmZbIf6fQ3V?=
 =?us-ascii?Q?7IDCVkrTIgTF+9xiXYGSuWx5Bj3ppEFY8D5+yyXZs3dPdSDtqVGDFXZ1+n9K?=
 =?us-ascii?Q?sm1C0xAMCOKY6dB6YR5ZYA27MdwonQ8eaVJR9pjfIXxUh3WOLwjfiVBs9UP+?=
 =?us-ascii?Q?n3vIS9J4OyZcXIqSmAJQ/uGCHeq/SvbKpLirz1TUoog8EEdTHcvMLo+y9kjb?=
 =?us-ascii?Q?2/0CmARHoLxThIJByKXhG++NH7406JD1UC7+iVoqAD9aPkSbqnQ3cgK91tIE?=
 =?us-ascii?Q?jjWwpNFSXFow5gbNZ6OamZhhdfqP9pd8GmtdoeSCBpua67mGPgMgxecKQBlT?=
 =?us-ascii?Q?iZlQr/HJ5G6HsvW5pK4T6FzBMBJsHvEVCQu9k+p5OSUL22i8q0y4vKIaRTsV?=
 =?us-ascii?Q?k3eQV5r06zIlou31EGD/m/KkzKAvr8YqU1mW1gQhf9dEbcpD2asp6FFW5cVZ?=
 =?us-ascii?Q?YKtiLSiM3KXVbyCIjXVz+jdNMlRaUg3Sg9fVH1vm9FeEC4KvYIbOTSfr/Fdz?=
 =?us-ascii?Q?GvX/sJE2lRhkg7YAWicTEE2gwMWePzDT16vaJ1YHSfecVYKhpH9h6526XntK?=
 =?us-ascii?Q?K2546rSRHPY8ll2nm9f0qkuTxEymYcb8pYFwBzHsC430H0NIrS2ni59rm/BG?=
 =?us-ascii?Q?iy70eJM4hhDoDlm/S8KPNe/fFkZxvqECw34cEtixVVJzUpefACxeNDyui3PM?=
 =?us-ascii?Q?00nYoGtIkMQOOBb1WkL/O8ic7dlnjcp65iOrdQy80lg/nrsBo9Er9PJFAcdW?=
 =?us-ascii?Q?SvBTfz47fZIQkpnrnZ6oal/azxxXn44+mPHvlKR6CXwWhrhlYpABLGtxP7gG?=
 =?us-ascii?Q?bOatRQqzAwk4/ehWneqMXZ4Q68J8RiyUBrvIHOiGv3pJRVn3dtWlJqV1gabj?=
 =?us-ascii?Q?lZQd9xNOfU01s+U9L3WTicjJs90RCA8NM9c3h75a6JmnumHqPTgo9Ou9Rj0a?=
 =?us-ascii?Q?UNGCaKuY9BSjP3w8z7cNMrTGzWWte9FbuRLrOrHl2iOPR5GE9SvNcKtZjl5G?=
 =?us-ascii?Q?pZdJWAkaTCJa6gElZ5y0Idj+sbCXr8JJYbQLMRbx1tCKkT0N0i3VgW3+x8QV?=
 =?us-ascii?Q?SIUZqacazCNavEhEzTEBv+s1yp5HBp2za86sxHpHyyOVl9gSX1CqBPAcPLpW?=
 =?us-ascii?Q?w+sOPkIOVl+xRo056ErJgdhMdk8j2cCA+BT1Q82NGMjgb94oaZiAbeMqUaNR?=
 =?us-ascii?Q?qA04n1Mq+9/K02oiAPdsCPkOuphF8e1/2cJptmpwqn3GUTuFALSNDIPLcCxX?=
 =?us-ascii?Q?S3+rNy2pD56HbSRTlG1wadeR8KGz10yV902M?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:54:12.6365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc910ba-46b6-4751-835f-08ddc49a27c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
Received-SPF: permerror client-ip=2a01:111:f403:2405::62e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 03:42:39PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 16, 2025 at 11:09:45AM -0700, Nicolin Chen wrote:
> > OK. I see your point. That will leads to a very long list of
> > parameters.
> 
> I would have some useful prebaked ones. Realistically there are not
> that many combinations of HW capabilities that are
> interesting/exist.

Maybe starting with a configurable subversion could be a good one.

But I suspect there can be some case where somebody wants certain
bits to be off on top of a subversion prebake..

> > So, a vSMMU model is defined following the parameters in the
> > command line. A device (and its attaching SMMU HW) that's not
> > compatibile should just fail the cold-plug at the beginning.
> 
> Yes
> 
> And if you want to do hotplug the SMMU is already fully defined so you
> don't need to discover anything at VM startup time.

Yea, basically every device (whether hotplug or coldplug) should
run hw_info to make sure it's compatible to the predefined vSMMU,
not the other way around that I expected.

Thanks
Nicolin

