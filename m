Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2465D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRzx-0006sK-E7; Mon, 26 Jan 2026 14:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkRzq-0006ra-K0; Mon, 26 Jan 2026 14:11:35 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkRzo-00008O-I6; Mon, 26 Jan 2026 14:11:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjvtxENouXqu4ES4ot1j5grPlirVh9bumhc6erTlTyAISFE+97Irio6CLI0fpsg0e+KPq6OcRImJmKNe3uZdoo7QQYiq0fyx7bs6mffScevJVakS4cuk6oBFE1k3IO9QOlSlRZbaDbh5DXFj9P0Uo8Q97dPZvXQ3jhELkgbBs3vHhyaOzol6MQlMtF4GgzWdjbnwQzdefnpmgJfAshuXHV+4Ij/kFF/6tC3d7JlYVLti2oEgN9/Gt/ApwQhtceMDTQah6rJ7JExjo+P1uEuAS+E37malmu+joQzBGFgKbX/DdtPH8ni7CkyknxbJd+qDxgsFMN0NkIzIVWrt+5ccVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw6DxrE23AFuvOpOMnBSLLGd8penpgf+8rNtVxN8JwE=;
 b=RpozVdcSyKzvg5R6V8/AYoiXpy2e6WJ5FAa1Kgly7emdU2XXu0kthLeaHunyqtKzjMUbWcFc5IXuN5M5qhFqWsrKWFyzYqPdLGqx7paB2g2phN+sOrcCx/lShIFasem5X1Em0bYfQcFiNhxAVXXWUjVJ7Oi7rUs8r3OuBZ2iD6IUsQTFT9hkcbnqrV42PgqClbvxEOyKCrY2WxLj5hhLwSNmNYjbYILppwBsHSTnwr30rPIxQeWuSnObBZmxf0a8CgtnMQD9dbjuM3DhYNNh59mJXqALr0Ivp1PYv37CJw+jHGls+BHIbbZ8ltMvq2sNge0M/pcOUNW0dbXhUUdcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw6DxrE23AFuvOpOMnBSLLGd8penpgf+8rNtVxN8JwE=;
 b=jwxVhqMs64IKE3AZOgOvMv82ppfehL4/xUT1HOunPmCI4XfeHHtIRc0P6xM948wgbXGYPE+Zypz2GhcpNErX+PTkfw404mfqOXnUSKOZXHMHnD5p41P5+mL8yLZB6CqFutUKJiBT87x7lQNMHj03CZD0yBvoq/8l2ndTaTl6bI80/nliMmnXl/E7fUi5/bZyZXdYifPAWFa9sKul6HR2CSoOt7yFP2n9a7d+8tW0ha2+qh2G8EDwEoV+yFwa+Tja4DLNiLj5duen5Q509bRpW2X3MDzgYqB7//kGf0LZimBot02dzLAlOLjOZIwyGjCzwnfaCjkwhWoI5XtIS5nldQ==
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 19:11:17 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::5) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 19:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 19:11:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 11:11:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 11:10:59 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 11:10:59 -0800
Date: Mon, 26 Jan 2026 11:10:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 07/16] hw/arm/tegra241-cmdqv: Add read emulation
 support for registers
Message-ID: <aXe8QgtdyBmXm5iS@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-8-skolothumtho@nvidia.com>
 <d50e2921-38a0-412f-ac9d-1d0d81490590@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d50e2921-38a0-412f-ac9d-1d0d81490590@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3d09ab-1d05-4829-2c8b-08de5d0eae86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cFuULaPF++RA/JTk7WsOLT9EHpl5dhb1plL+9WBnZku5Itepob3chFQpRLsp?=
 =?us-ascii?Q?50miC7mZAKRxbt3qIIsQiTTZa16wl4iFwbPJQ/QB97mhAu3tLE01fjqh3H8b?=
 =?us-ascii?Q?frnomnFJeBdzvdEOlDyQ2u9T4xWsYSAjd+9GLLQVK81RcgKfgj0BFAH715KI?=
 =?us-ascii?Q?yPuPhsvQvohJLMvfrWW5z9gQimtS5MfhYqlMO1oGG4Cp4b+SJtR7DSxew8sV?=
 =?us-ascii?Q?58NLNy+6HIq5lWWMeOvtzYc3WpTJpJgdKePdMdXolWQ0ZzQXZn+S7eKQTj9w?=
 =?us-ascii?Q?EnI4LDgw4RyhRbi91e28+6QBq9G4ryG9TCqujfDvxdH1j8osqtswzYRIgz3N?=
 =?us-ascii?Q?EQpXsdelFYSU9H967RlcdUo7AF+St4Ve5h/t3cWw8SPnP5/w6YfEV0G47fTv?=
 =?us-ascii?Q?f7wLbLBWjOUPT6Fb0ELDdYBfc6VF4/bSrId0PJwtqAhzqhLmUS/9rihEbJuC?=
 =?us-ascii?Q?Q9BKa/j87HLUG596OrhkC0/20xr4ZjjX2j4r8N2YFPup9PhmXhwrzSrSIs5f?=
 =?us-ascii?Q?fkruFGiBGUxlVgX1FMnZ1XSYD+A4/UIiJNrDEN9ctpuzWikkh+vBeYFnC3CG?=
 =?us-ascii?Q?89pRkda+VrbYm5Ijv70oPWwIR7hy8L34qh55a1+kI8Ed74yzIMHA4BwKC2ny?=
 =?us-ascii?Q?0iFH3t3pZh7d6qWt38oR7Qx2/BPbQMlc/aj3jXjGINuT75OSkrSm7yjfqqVr?=
 =?us-ascii?Q?TH/xjy/bsqMlPdlmDXGAC5FRV+NrTosDxcD8hryYm+VuTjw4ktyPRRz7g+OH?=
 =?us-ascii?Q?CQN6VatfdojRZtlpKJ+oyIcKoOg8Ia3yxd5PN5RQlOIIrYR3L3HOkZcO1e+Z?=
 =?us-ascii?Q?S80qO6OO5kcrpDShDJLR/etQNo6w1ORBWU93NHfJ7km6hs70C5J4X0yYqH7f?=
 =?us-ascii?Q?Nv6lPi7rfrzmawiWm6FPR/5RC97TIiQnu8g+Kw4pJKS0pQ28UbP4hB0a8aUU?=
 =?us-ascii?Q?VYRXn9jK/l7yBOihqanAlRQdKB00zbg3+r+rr6bTGsUQxOC2J50uXxnUOBiF?=
 =?us-ascii?Q?QaubFG7vBDMLIbel/EhctKLMlFp08VVhLCWl6PJwRdPDpimpebjn9u+GySeG?=
 =?us-ascii?Q?651bLU7yuFtMLUawgts4z+XZx3y+vj1YtO9aO/gEjO2QvcRA1Yq3i6XYnzuu?=
 =?us-ascii?Q?oE2iVRlpOo466tB5EROaQZ2CaMy/jhlhvq+6HMoapl0ktoXYdf95y6lT47Zc?=
 =?us-ascii?Q?Q5DVWNoQYtyNWxzQEfBQ3D8fslBU8dN8YIo20CMH0KIlA+SdYsW4TPXfTPtZ?=
 =?us-ascii?Q?1CHjrhP3lec4HB/2mWoQMzTWKkl4fAHlEu+H3ovS8YF8Ngaw09eLP/DYn4Lt?=
 =?us-ascii?Q?6ZoWBsciv2Qh5XoeeT9E02kQINZFbUMbixe9hhkZdrqpd0wq5quoi7zL926U?=
 =?us-ascii?Q?8TYlalR5enaZ7Y74YJo6M+v+8rLDdLVyJRDWU7bXMckp/I6+efNtnQPXZJKc?=
 =?us-ascii?Q?b4DtoZSTSQztU813WCDlvKI0EaCvkmw+pyiUsmNXK6vkieVkYttIA1lNb1vM?=
 =?us-ascii?Q?y/ltCLXkXuJ+pw+xDhEc45XR7NShJGemFum9T5O8r9rSJL2HxkldYjWfwHGv?=
 =?us-ascii?Q?LIzleiIMop28Lrng/0HW5CvZU/sKcg3HduQCKTpoGvMgoQh0zI/IqzWHjVSA?=
 =?us-ascii?Q?SYIL4gZ18KTZkrWzNLDjrstrT/4THwzfSqF04cl78h2tU+IMDaK9vOE7LtyL?=
 =?us-ascii?Q?T1j3KA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 19:11:17.1585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3d09ab-1d05-4829-2c8b-08de5d0eae86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Hi Eric,

On Mon, Jan 26, 2026 at 04:13:38PM +0100, Eric Auger wrote:
> > +/* Note that offset aligns down to 0x10000 */
> > +static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset,
> > +                                          int index)

> the offset is within the instance, right? Better to rename it
> differently from the main offset

In tegra241_cmdqv_read(), its offset is the register offset to the
entire CMDQV. That can be A_VCMDQ0_CONS_INDX, A_VCMDQ1_CONS_INDX,
until A_VCMDQ127_CONS_INDX.

Then, we align it down to 0x10000 (A_VCMDQ0_CONS_INDX) to pass it
into this function, so this function can handle any VCMDQ via the
A_VCMDQ0_* registers only, as "index" tells which VCMDQ instead.

Perhaps we could rename this "offset" to "offset0", and elaborate
this with a better function comments, e.g.:
/*
 * The caller striped away the VCMDQ index from its offset and passed that in
 * via @offset0 so any VCMDQ can fit into A_VCMDQ0_CONS_INDX for simplicity.
 *
 * On the other hand, @index will tell which VCMDQ is being accessed here.
 */

> > +{
> > +    uint32_t *ptr = NULL;
> > +    uint64_t off;
> better initialize it?

It's not used unless cmdqv->vcmdq_page0, so we should probably move
it to the if statement instead.

> > +
> > +    /*
> > +     * Each VCMDQ instance occupies a 128 byte region (0x80).
> > +     * The hardware layout is:
> > +     *   vcmdq_page0 + (index * 0x80) + (offset - 0x10000)
> > +     */
> > +    if (cmdqv->vcmdq_page0) {
> > +        off = (0x80 * index) + (offset - 0x10000);
> > +        ptr = (uint32_t *)(cmdqv->vcmdq_page0 + off);

> I am confused because I understood page0 was mmapped so that the guest
> could read it without VMM mediation?

Yes. I pointed it out too. This should be cleaned away:
https://lore.kernel.org/qemu-devel/aVLZv+nwUB7+ohuw@Asurada-Nvidia/

So, only return the cached regval unless !cmdqv_page0:

    if (!cmdqv->vcmdq_page0) {
        return cmdqv->vcmdq_cons_indx[index];
    }

> > +    case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
> > +        /*
> > +         * Align offset down to 0x10000 while extracting the index:
> this is a bit cryptic to me. Could you explain this in the commit msg
> > +         *   VCMDQ0_CONS_INDX  (0x10000) => 0x10000, 0
> > +         *   VCMDQ1_CONS_INDX  (0x10080) => 0x10000, 1
> > +         *   VCMDQ2_CONS_INDX  (0x10100) => 0x10000, 2
> > +         *   ...
> > +         *   VCMDQ127_CONS_INDX (0x13f80) => 0x10000, 127
> > +         */
> > +        index = (offset - 0x10000) / 0x80;
> > +        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - 0x80 * index, index);

As I mentioned above, it is to ease the tegra241_cmdqv_read_vcmdq()
that only needs to handle A_VCMDQ0_* cases in the switch statement.

Yes, let's add in the commit message.

Thanks
Nicolin

