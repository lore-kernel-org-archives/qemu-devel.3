Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A1ECD6E3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqFYm-00035S-3d; Wed, 11 Feb 2026 14:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqFYk-00035F-EA; Wed, 11 Feb 2026 14:07:34 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqFYh-0001Di-9z; Wed, 11 Feb 2026 14:07:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdE/NP3WOLQj5Ol+Ppe9WeNE+StExYwAySXgDId3eCwd2xgSgeVCbjQBvLp4FBTVz4Nx7gBe29zmHm7+Ykqw/Ayx9RF9Z5ZpvTfT+ab6IlRJDL71ptIJdirpkSv7sZuN5yH4OtVPqNEEesR5VY3dkVQ0WspzprsOwHH//mv6hUzkYqWQmG1p4tBSI3CP2JqlguXrP6unc1P+ByOFJc07FmmkoxAJx5z3sBpY2TflA8jx2I89giKil+zEg5LcWrrC+U1v5Om/g9vRiAHbsXUDfKPKbIAzplmHgNqTznMVgKVc5HdiMYurPLTAua5AtbgtQc+M9R0AghlRjG1i0t0DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUYNllq0Prn4KJGzv3waNq4MsATeH1eOXn1wCptLCd4=;
 b=nDqeDoN+atSHbVQY3XvLVZqLRrsPEDAlBQZX4ihcx0nyvwx3gmYD1HfR0n89PF8rpTRUgAWq+BgVwLqhu6x2EoCXmqFbXv69LKk9as5Wa5woyiWg+PO9rH4q4XccgDQGnmifJecv+WWwqmXPjxlmCuz9WcmGJb83kPXcCLzakZHmnuvHX+6RIfQUzCRFFy3dYCGMRD9kSavvoynhhExmSVIT54v0Ilwm3/aCGt7HIFafuc4qiv5Aa0LMIuB6IVpjp8nYEH8ra2/upXHw8RNiiaFAbVIEiSMzlN7zI334FELYZgVkU8RHA8SUAPchMcd3j4q1DYxqj85xFucLemfTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUYNllq0Prn4KJGzv3waNq4MsATeH1eOXn1wCptLCd4=;
 b=QbNlFDUE1Miiy3NMjttCxzE+p8y01T0OkE5hlXHrOp64g7oRF5GF7OF74Sv+5adNhWuce6tuXv4u7144a4gJnUY6Ef8iXgyBJunVvwA2Nt6H85O3O2qV/bSJdISiqM5AJfIeMETiVjU5lOL9QlLw2M0sGMx96sXQh+GgFNXcYCvTKNKW2YNmTaRZ914GhCIM0UTXsOB7XZK7t2eooI91yDsBXadDLrH7yip+s/AnlOHPMD/NyA7Z5gT7pmMMh7L0l0JTJtt0IGxxA6ru+3FuIm8COnPjJ4MQvy4PloUEiD7jJVEyuadX17OwuGBBpN1KlJF0VvRN7HAEnz6fEwNO9w==
Received: from CH0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:610:e6::18)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 19:07:21 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::b7) by CH0PR03CA0283.outlook.office365.com
 (2603:10b6:610:e6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend
 Transport; Wed, 11 Feb 2026 19:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 19:07:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 11:06:59 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 11:06:58 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 11:06:57 -0800
Date: Wed, 11 Feb 2026 11:06:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <aYzTUDmTzIZZCwnW@Asurada-Nvidia>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
 <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e6ba43-2006-4992-1b94-08de69a0c88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l2w6hKpb5TuToIpB+pI3ijBD8HaeYi4zdJ8aC8xCbJ5A6wl8Sg4GDiyZPn85?=
 =?us-ascii?Q?iBsIyH4eWVWcUPdKUzjoR0HF2T6lud3+sdOml4G8wU2PugKEsLKxZM1zGO71?=
 =?us-ascii?Q?lxflrvD80kb1nXDr+tEG7nPVWqgKzydTjP7W0AekZ3qihhGBblmaP9ABcyua?=
 =?us-ascii?Q?1Y0W6Jy1gup9EGYec/017IBPxFbDikqiUQueWFvRF6cA1BarnocFPix0tFKu?=
 =?us-ascii?Q?MQ53EFMzRV4qTIUj2+SscKDvy5jT0LdmeXc6Pys7oVO6bw3VeQG3rsGmCZOY?=
 =?us-ascii?Q?3WUEmDtwv430ci/99dp98D/3SVJrZeKDs0h0gGSG9IlVxT0RAuR8omwg9WT4?=
 =?us-ascii?Q?YSUKc+isBa4vi6LXgNUdR8qu20REY82Zlqf0wzUcvfKUn6Uk4CMeNb7QfA54?=
 =?us-ascii?Q?48QfNwYm8hmAhkx48b9gfyCTAapCAxzlKxUKrdtskrRMkRHP3eiCoZx/bxCq?=
 =?us-ascii?Q?jlayGrrJjAM5AVTeWD/qBJl6UTLeIT1P1wNKUyBWBdjf80gIvBIitX/lJGe0?=
 =?us-ascii?Q?emyjXIQlrXMpdRhanK7IXDnynYNmgNyczztvnJNSQc+n0f5MsB7dNHU00J/H?=
 =?us-ascii?Q?4qo5cmlGUie5Duh64QMN0/IW5aYOB8/xfSLhw347y1J1VCZ0COKAVl9XUka6?=
 =?us-ascii?Q?OFM4eIBV3PRdm5ORb8d/i7UHzGY/H3WEZNWjER4/qQ+Od/s9Gfkhrzh4e6MQ?=
 =?us-ascii?Q?7TMH9ErYnSKvqvwDiavHb16/XghHNCzYgwqumhy4R6r2B7NFsRKNqu7GXQID?=
 =?us-ascii?Q?95ZWOtE3+/lmwncJwVq9IC4ah/4M8uwh5MqB5LJZcb3pQjPmM62O5ReEG3SA?=
 =?us-ascii?Q?eRU69LpuzraQaZyFIAYNBgCs930yTtaY1He0a787LVP4kCsFIVkSBG3C6c7d?=
 =?us-ascii?Q?z/ezkMZ5og/9V4pMfyvsdIJFlM5FJfZmg81W5+rpzdV3ixiWsEmS202N9kof?=
 =?us-ascii?Q?wa/b7EWDoZtmM562qsPGONufFbe2vYO0NUHGdqxClzAVvYl3ZJU+g5T7KuuM?=
 =?us-ascii?Q?FyOmVnQNRuEdcHdJaVYRASBSQ6xvWiTHGzdWWv2c48U5Iayq1rh3/WrYO7un?=
 =?us-ascii?Q?B2hggsHTDGtsZmZroUwO6uFIMoRCi1/3vEffaoUGprx8MgprlqMUF6B0iyC7?=
 =?us-ascii?Q?d5K1Iyq7Aow62N6ROG6OCa3vo8yfIJ2iwDYsUKtp8/qeiqlIpUqEiF90AvWc?=
 =?us-ascii?Q?lzFFf5szPgTf9zb1bxeGTyR5ih67RXMp05B+NomfZR0+5nzSh7Njt2K3l92U?=
 =?us-ascii?Q?0BloNiMnIVCN26lqmDJIo+lfz9nb7AHof1fN4hccERvx8+/arS9GkWJjEL1h?=
 =?us-ascii?Q?5s0FNk9Q9yKdWwe6tucJGq9NDt1w+P2VhP9x4yBgu42dQD9Uyy6OebBNZBtV?=
 =?us-ascii?Q?xzsP1+ozFHb2+5rmSDpj05IdWT4WtNmJYstJjSW8ODeBhVLAIO9fcqz/sR3s?=
 =?us-ascii?Q?HlYYGbBZ7HSpcJgriNpVpVe0F4Bs+sEO1aQTfOyS8VUyx8OrxwQpjN4jiqt0?=
 =?us-ascii?Q?uFr7pBm3T2JN7bPMjq7KA9fE6yH39B0E8nFSE3ajNBkvuBHmFB5Nci94p5/R?=
 =?us-ascii?Q?tFDcv3trWSXp+kVxmCSc5d+IXjHwc4vDTkA7VBnvsvFcvhWIvAsWrMPU9Q1L?=
 =?us-ascii?Q?RoWaRyQ8M9RMyCpdjUp13GYHkbraXMkTzEWXUHaXlCNVLZ+jPEwA5xv6BFUT?=
 =?us-ascii?Q?Dpk0LQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0s2vTylEDYuADKFEdNlyALIYhPVtCTWVZ48ZFzfiV2tvjzGsa2rVW/NdDyPcpceaTYmOAesz8soApN0dqgDveDGGl1t3aJO81sByP7RaZ/cooThJqUGTffD7Ach5+egvJRZqcShvSKi9/c8Zu+AWMxLICGCs9G3woB8h0TzQFsT8BZeBX3j7T/k9W46qBrz6nMB6AKL3D8cUDV34s1reYWrVDn+83E3bN/D/6UgTRnjWozUpo6VydXVDlssoOIffjtq2OzuFo7h/sH937FVld7vv93aPaOHGki/Fao+iDkKW9OFRh46cgJxpPuWab2faSso5YQoOKho9OAec2STMVgPjxVGYg4rwqXni8Kq6+SQz46i9zTHo/DCUTLWgRT2/ilULFtFvYwmPl2qfN7PnNutlJ0AMlDm0XiQplzhQXKD2fcqESSfv/CDEj5Ck+lE1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 19:07:21.2175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e6ba43-2006-4992-1b94-08de69a0c88f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8
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

On Wed, Feb 11, 2026 at 10:43:04AM -0800, Shameer Kolothum Thodi wrote:
> > On Wed, Feb 11, 2026 at 07:14:40PM +0100, Eric Auger wrote:
> > > On 2/11/26 7:07 PM, Nicolin Chen wrote:
> > > > On Wed, Feb 11, 2026 at 08:34:13AM +0000, Shameer Kolothum wrote:
> > > >> +        if (local_err == NULL) {
> > > > Does eventq need to rely on !local_err from cmdq?
> > 
> > > if local_err is NULL we can safely use it, no? Or maybe I miss your
> > > point. maybe test !local_err directly?
> > 
> > Point is: if local_err isn't NULL, why can't we allocate vEVENTQ?
> 
> Technically nothing prevents that I guess.
> 
> The only thing is we have to call error_report_err() if local_err != NULL
> and then set local_err == NULL before calling  alloc_veventq().

Or should we use:

include/qapi/error.h-402-/*
include/qapi/error.h-403- * Append a printf-style human-readable explanation to an existing error.
include/qapi/error.h-404- * If the error is later reported to a human user with
include/qapi/error.h-405- * error_report_err() or warn_report_err(), the hints will be shown,
include/qapi/error.h-406- * too.  If it's reported via QMP, the hints will be ignored.
include/qapi/error.h-407- * Intended use is adding helpful hints on the human user interface,
include/qapi/error.h-408- * e.g. a list of valid values.  It's not for clarifying a confusing
include/qapi/error.h-409- * error message.
include/qapi/error.h-410- * @errp may be NULL, but not &error_fatal or &error_abort.
include/qapi/error.h-411- * Trivially the case if you call it only after error_setg() or
include/qapi/error.h-412- * error_propagate().
include/qapi/error.h-413- * May be called multiple times.  The resulting hint should end with a
include/qapi/error.h-414- * newline.
include/qapi/error.h-415- */
include/qapi/error.h:416:void error_append_hint(Error *const *errp, const char *fmt, ...)
include/qapi/error.h-417-    G_GNUC_PRINTF(2, 3);

?

Nicolin

