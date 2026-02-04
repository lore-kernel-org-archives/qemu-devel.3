Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D51EA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniyE-0001oE-RO; Wed, 04 Feb 2026 14:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vniy9-0001nB-B1; Wed, 04 Feb 2026 14:55:23 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vniy7-0002hf-Ur; Wed, 04 Feb 2026 14:55:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOIJTnjm4rb94xb+6NCjjoRSUIoZxBCJ8zY3W6bgIme3/JSPLcHNfcf5m17NAxujFjrP+kN8MiDUAVFsfZvlDdnaRUIAF4SivXJOtMip+QGNTs1WX2mtTx/XLaagNhhilLaLAvBUY7MROW0Jco8Iv1qDDhd9uEy3aSZxLntwmXPC2JR+nPFetySvINBd0nRgwHx/R5uhhwSIGyf1VHJwpwPmJACKu9u+PlfZmoeIdLHVCiFLJB1Kvl9JmH13SUJ1AYqxbENInL4oKZ9Dl/yoxNbCl/3MA2TYm70otPdSCosVUsiYKG8JjKlLd2HZJJRewmPJDlV2FGJxEixwkTTsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWSAGz1AKyg7GrSLBanxEvZ6FTIrxo69hK7PSzIGE2M=;
 b=WSF2sblVSHsAdCGPTDb5WVsb+oAuPfvUpRN1jJu8irRvqigxdDG5fqTk4edRnR+T/7PidUmceI1cuXmmAxLo9M8Sx6Q4nq7ptl9bTSJlsQEoqaB/nlmsWr1rHMyUvq1oZjq+3o2/Ck0JqqTQq/J/vCpjMS41MnHamozmce2+VoR9UBpCRPwb9MfJ83uiWCrG0167UmtNha+Y6gSfLzCqPq2M+2h7+/QDXbjIICH9Uei+eUa+9gFEiRfF9CLbkChxL7qi3CXNCIOObo3lfnoUm0c1WUOm6ml+0aUeWwJF8ojsRAxfHPqCAe2apZACIObLMajbbIAAa2yCvPY8CcV4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWSAGz1AKyg7GrSLBanxEvZ6FTIrxo69hK7PSzIGE2M=;
 b=GtKVGbyrUrHLw+mg/u8tyNtrU/qGYjoejUCV+WG2hoKtkeysdRs0A+XQXTno75hOnFk4zs0w/A5+E+Lo8qIdJPMP/TSqJKlb4l28iWSIEqP9DSMxkoNyCreR8iKxf+iil9vtHxE1DD/zsJyBvJGQKDOx6dnPo72+N+8mSkzA6iskM2g0JEutJPcwvj11J9iUHoDZiN6HJNgp5WtMPozBqLEJsCKKv8AkA/LTFCgqF0XBNOu7168NLN1SdE/vQnXT+nqxrzQJ0vYiziN0plvI/ikFIlQ/mRcmOIHtBJYF8MaAOkTAyCroLVkNK7ivIQTmxWpOpaLJY/GZot1+Zki2tA==
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 19:55:08 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::5) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 19:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 19:55:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:54:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:54:48 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 11:54:47 -0800
Date: Wed, 4 Feb 2026 11:54:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <aYOkBm5Ghih0Uxzf@Asurada-Nvidia>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-4-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260204190008.20070-4-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbeb4d0-a1f2-49be-373f-08de64274c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5AW3JYYZ+O81MG/T8DLVtzhfwWU90GFjQEuN/xD77ZBARoegznpQ88DmENmC?=
 =?us-ascii?Q?arFI8Ynsq9sgbCTNqtUU7NsCI/P3bXB8/IAHp16G+uChsvWFBWWSNnxFtKNS?=
 =?us-ascii?Q?4aMQPo6ASTXdVLCCMEX1JHcTnZ/ilw6j0UTSvmiB5n5AJnxfkcOvgRd+mqxD?=
 =?us-ascii?Q?yxdEM4FBcuXF2HTE/Vz43zMOWRdUfyL0fmRcJlUofWNzvsAqMv2ydJGloHdl?=
 =?us-ascii?Q?QnZEJje30PpS1LjK8RuOMH0WTgdig2gLs+Teiau9fFw3YCdJC3KJQViGRg68?=
 =?us-ascii?Q?nGQiMUYtyyNL0YgcSxUcQguWqPZMOVGeayyClzTm+o7ABZi1+0DIc40odYh5?=
 =?us-ascii?Q?O0c4NaEFtnYa+5fUEYBIg+8VwoZqPGdhZFGUumrZ4YEJwCaYmSl+ohHviFiG?=
 =?us-ascii?Q?TcEBktAfuagAKFFsFIZrsVy+aS7Zlu0lkYmB6C0pD0IaqcS/4J0sdt9gbRN9?=
 =?us-ascii?Q?wLjKlqokoC15YNwJOcaLtehR05g3IQ8nepqymKGhFEpFJ6MrZEpKX5fnpdNe?=
 =?us-ascii?Q?DuERfgoORgaBHN82jWJwW3khGu1bUD078Q7frkwRzGJ2Jo6Rrz8iX34+ov3A?=
 =?us-ascii?Q?4KV/hILMZp7PPJqRquyeEdms4fQyfCmEma9UR6fu0qjqrHhHEgSyzEY5zpfH?=
 =?us-ascii?Q?HYTJv9hgxdJhofkNBzBT2uXllx4zzjQHutJzRdLzLEStRved5irD7xHHpLKE?=
 =?us-ascii?Q?x1wr4WMfTE1M4V0HGd/3LZ6Pd/iZjNCQhDZeXTyESP43DGQbyNAMa/1Uk19Q?=
 =?us-ascii?Q?92ze/hoQ0kklvn3L0cn4OF/7AxSzPhWuvQctpR1f/LnLcTy8nmdO37iNeD2Z?=
 =?us-ascii?Q?UdNTEYBdAG3DqHYVgAkQDxUKV7jW7tJlWwViKLg7o4dPFPN/FcnmTXQo91fq?=
 =?us-ascii?Q?6kV9wzc1ly8DZouf9vqlLXEJUVn46QKe8IPBf/VLzIcEt1RoUOTXim8EmdRk?=
 =?us-ascii?Q?jGp+Hcjxy9PCF8XH+n2ktp49ZI79tpmNFY2Z4RwZeFQnT/xb7I9CeYxYeXfH?=
 =?us-ascii?Q?jq3KZHMngQzWaDdvs3STs4zLVezdOwrgMK8swxI+bSUzNLboDpLuZ0vwQbr8?=
 =?us-ascii?Q?+h5vyIeUni6zNmuvDv1OKl3XnCkZekCGe2zJ8LXskbWyXaMd2f3cn83DMsTt?=
 =?us-ascii?Q?1+W04jCjDNRFbhpZ22Th0QJZ1edRxja5dhRIPPc9SFA8qAbbadoJJXpugRZ9?=
 =?us-ascii?Q?Dbq2P+uTvM3ziyyZDMom55wo3PYzVd8Pux8777seHRwmgGqMUzdXnUjUQoyN?=
 =?us-ascii?Q?QNnxWdqNAHRp5NGmqyV2n6TOTiIpPlE2oACUajkScK1awObWPeclM06h9XGA?=
 =?us-ascii?Q?xRJ7C3psg9M0AhWPzZ1wVTLL2Yw3u07buJgt+0KcXCnCa6js6i1aboKS8dRZ?=
 =?us-ascii?Q?Ou/Dwbf4LbVewyvuIf3zmaJ++SMXgUA7FsEzy0wOHB5W3P0YuAwcoPKKiU6k?=
 =?us-ascii?Q?0i7zioK48ZU5l10SbDo2WQNLGbQ6s8QSN1JGYtyO0kyRYsP8HdN8jI6/d0kh?=
 =?us-ascii?Q?+n2z9HlNQgzKLJqAsh2p89kuMotnOKfUi/bV74S1Pz0UKxVWAxbS78e6sCBh?=
 =?us-ascii?Q?s49iFnNz3QcXOBkbYiQVrYPiHLRCErEZEG9yPUdv/U0trU25Uvua8dk4VMIj?=
 =?us-ascii?Q?O2RGSD3PZplFO7bDqPN0xf4VLoHxZiRq4pMPFi41nvj8oXHR2mLPclGtj9Qe?=
 =?us-ascii?Q?3dkKsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vxJFCmYc994xDzJ1/+263eRqpo0IAqdF6tNiVBDEnNL4B/+1Xxih+NzGT+1Uywd4XtThSfVJ/PyKBf8ERQjde9eMQqe1ZWS6AzhsC3Od02B+u+JMCq6R53eeTt0hhN1LZDIGJSNp8+Y9swGExERDPRVn+y8sr2VWq7dsxrz2TK1+l1yswi8NEik1tnOHEsRsp9kqrcNPAR9OOFNQvIAvKXyOlFSLSSh2C1falnWjIF6FQBcBmn6948tREdkcw7yVZ8UqASFx9N2bkYNxSI1joA9Vzc6fjioK8k2TPR/z5RXb+keIWka1jG9gzKySLYQZ8sNnoU8H6oFI1z36140bC+rzVkeMAVGJel40mYOICEGTJk3aKlhggW3hTgiQZ///R/zSalpgg0v5iayHcasTwcsL+WVWjONUZoc4oBX1voI8prlmOADJuTqkDGhwaryb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:55:07.7186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbeb4d0-a1f2-49be-373f-08de64274c40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837
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

On Wed, Feb 04, 2026 at 07:00:06PM +0000, Shameer Kolothum wrote:
> +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
> +{
> +    SMMUv3AccelState *accel = s->s_accel;
> +    IOMMUFDVeventq *veventq;
> +    uint32_t veventq_id;
> +    uint32_t veventq_fd;
> +
> +    if (!accel->viommu) {
> +        return true;
> +    }

This seems meaningless or should be an assert?

Other looks okay.

Nicolin

