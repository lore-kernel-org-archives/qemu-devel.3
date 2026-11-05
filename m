Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8D606D819
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=YIkuuWhr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsKq-00044F-PZ; Thu, 05 Nov 2026 02:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xOsJD-0003Py-2w; Thu, 05 Nov 2026 02:55:03 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xOsJ9-0002yM-Cb; Thu, 05 Nov 2026 02:54:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRzQk00nXDR/fUZMKPcA2FFn+IcQrC/0nrefXuZy3uoOagNJvNv6FlzgCeunFWcF9eppMNiLJ8nvMdviBI4XO9nu4iHOFpevPH5EWDn5gSoqH6Cw9VAMHxcFuudjH4U8yGAbB4GwJ6m6nrfV8/b+N5DG7SWtVw7qyfPsxdYbi8wD0yI0QWKLbyAP+/t4SODLlIqeGOkioR0Lyvbhj9m0QUCG/2qw7OFfA59DnUVJnWqDuEszzs+SkVMiYlwkbbHlEh1FP/DWGCKYM83E/PkyB1yI25rpea3ylHC9hPmHOh3lrIXxz8kuwXACA91r41MaOMtMiQjr32ZF9OD0jEgfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcaVt7f6cJgCjyt5671miY+AJCb9YYwLUBG0G0tpkpo=;
 b=QqUBhM9WyQVVF1Wz3nwy3X7WRM6VkslRqQ1KB9H1+pB9JcqYdIElfH2E/GwiQAKkeSObXSi40rz8XyJRswLwecAMZS/hHbk2NxAl+LLSh6VVp0wEiQWk2AzfW4bkeQfb0nId3cIB+sy/yU9w0GYyA72qudR7XY1k6WBecl29hLtkw33t/GcB2+EUaOk+xIhIksHwTmvrNN2gpWFzT5BmY1sxDNxr+6Gr0NGUwwz+xemtXgJn1dw8AQftvDWhiIV2UyUT9Vnq+hzexPOt68ih3zlcQOXzXqJc6ADVZ/6Y9V4mqaYkHebOEw6Eq8JHwC6RfHZVhvemRH6MN03u+KVHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcaVt7f6cJgCjyt5671miY+AJCb9YYwLUBG0G0tpkpo=;
 b=YIkuuWhrP+Nq9cZiYFrQE+clvpZjDUX1OEiO5IITDglyKmJ3T1b9CWYllXlCBuHT3OrnPRExjFyDrkNe1LQ8IPTexIfs0HrWqWFqKJrQX4S47j8OsCDqwxsqQmWVs8wz5zoE93ePIAOXtk1F89mZD5OprUFtPHz+BJtftpnfqxoVzaG5V65vlpGH8lyccuZvX2AlO7NhgmqW0u00y1oAslcFsatI/l7eFVZ/oSftXnG2TZ9pF5hYGs8DtMzYeJDxhI/Mm482NdKWB9fEV89oUnOQEA6xvgxEqpRUHnt7avTDuDZaqQK3zqBlJKwCfvC9huHkv1GqBqMl2V7XxMdIXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB6593.apcprd02.prod.outlook.com (2603:1096:405:1e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:54:23 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:54:23 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 6/6] MAINTAINERS: add contact for the RISC-V server-ref
 machine
Date: Thu,  5 Nov 2026 15:54:01 +0800
Message-ID: <20261105075404.9239-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023160913.24992-7-daniel.barboza@oss.qualcomm.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbe324a-a82e-4958-2eba-08df3b120157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JggDmfdSphVWKI2U/VL7PvooDxAbz38rcMXd0jjJmHUGfb/SjpZ/+x1qq+waBF2JeFiWCU8vpEtNmvK2iHsvO5KnVSIOmDp4Dq0CYgfGMMMkHmcyXA6PwDEq4cFD9g7h+VgEZQfAuvOh6fheoSTsOj5Ywe6+2y78LYmAK3+E3ClfHoOfVzFskqbJtphABp1Jxc1KBqq2P1khWR4bgIpSQQQgaA81uCXJrh0+aTTU9RPvmEHDFJGZt2Ow6ZjfxGJHX6HhaoFZFo1qIhiZmVaRoaIpxLXpe9EFrcy4xOft7FarKP4RVJKm5UpcuColYq+RK+eCprHbMerXY4wDM4GAKUJlhNZFiGCFV3SPHr5f16h1LYG8K3IL7OoHjq9fQbiNkdmKxFXkRxRKvX8xktbfzZmX5xI+nqSdls6aNm1ReChcICIpefieytUB+3oj3aL+db5Hvx2R3xWORCvL0mYKp4CroPYb3p+zR8Hg6+7YECyBQKEae20QRrX2sxLJcf6XpsToYwcCMMAgWv24g/Ko6vd5aSNsrUShCLoldtJN+fmCSU5CRYjd8JXomKvGKD745DNKCLNnxEE7y1pRgYy2WumovPTdN6Pz8ulDwOIuTEZDRbTV0VAh6VNqo+7+0fDVyG70/Mx5gBiMHQ5mn5R7LOba3cOyG4dAUwClxdQ76G4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sU0tS+5/MiIkBWJy84xPdq8n2kt/sYSL5x0xoaPcLq/QqPxIWKJb8y8e9Igv?=
 =?us-ascii?Q?TBYF1sR+ksNLF9Fy01NFbBKcdpm66DhiDJTtm5cTpBNce9hj2hPZM1AFBEwB?=
 =?us-ascii?Q?C27yWAshPf2oO2wG2f+OMJYDiQxenRcRqI738FxJJp7dzGC63cF5Abvp5daC?=
 =?us-ascii?Q?ofjzDkVfpOr3F+VCR1rmCYmIzqlXQN68faCgTzQQ2k81P4osN7OZLB9rTpAE?=
 =?us-ascii?Q?mNpFtDPV0buYmXO6xvegXdmOdJs6kh7uG6HTUedFijHN25JFsNK0XBdAKtCa?=
 =?us-ascii?Q?xzYMhU6vj8Ud7sMNZQiILS/aVTnVkT29mngS0aFDO/2WnI1y45LVE21JD66D?=
 =?us-ascii?Q?6+I3sUBpPXJp14Z/3LdChxOyuqXRIEb9s3B833qq0J/iM2GTqvHAdL8ae1Ze?=
 =?us-ascii?Q?wDvhK/1Z274uwSMh1qZ8s3SqQd3zEJ3fnKnhVZfoLhf3wNFLNE2aH+ZjltwJ?=
 =?us-ascii?Q?jzExp5bUaMLB1niPu5iirnIvI8xlRcnAAJ9F5Gwh+2eENdPHX/nsFBwzNsPp?=
 =?us-ascii?Q?KE1H/WAQs+DVKqRhxk0+wqA6pH0vELoR3G522+bGgDuakJiFosq3MwhlVS1N?=
 =?us-ascii?Q?3fnKb/AMbh4vlbBT5xAezAvvZLvJhA75UCbXU6cvDCvhc2mcTpJk5gQYX2ar?=
 =?us-ascii?Q?bpqtUddduKryDI3MTdHmnRiXgkh9fosE+CO5bB+0X8jJRRD8WjmmHLd5GltZ?=
 =?us-ascii?Q?KnSOIouoTjLynCXxny+hwZHvRNbNEUmSz538rYxny9SzL1oUop+QuaVcwjRT?=
 =?us-ascii?Q?O+zge93aWr4PpabKzW2kMosDqbG7vnygQJXgesR56aPS3s4ArDe3kqCehz7v?=
 =?us-ascii?Q?CLxVikVOtIWCX67VVksjhrjL/bQoEXbpsUV2Upj7vaA15aWnLQa3ZNlBbPfp?=
 =?us-ascii?Q?3O4qrRXEWZSASRKcZ4SYqtblCBR8+VIOD4LwnTa49MOLNuhYd/XGFzTZnF5t?=
 =?us-ascii?Q?d6wkkwuOktNh6PEGBUbph8gHHmWIY3lK/1bVchwGwwdPBq9aCksjhIw+CQWE?=
 =?us-ascii?Q?ereLhuHD7imnJaIi8G7Rl/3mJnrsBXr/DetLO8JeAqFDJ2XPBVqfOlMs5xkG?=
 =?us-ascii?Q?JcDNbTMyrpDVTkqOsb6U+iuQD5lyrGcdFrfGxS0PuoCQlY05Kn20YEWySBWN?=
 =?us-ascii?Q?fo67+aWQ9525V7VR5c6t3t/SdzaOcUDeRsbKscuZzsBYaKuLh3vVpJTSKH4h?=
 =?us-ascii?Q?PlCH1Wy01OM5dc5EAl5ELkBjCXoEk9KrVsuShYiuW3BNAipiqWNkilwGylhf?=
 =?us-ascii?Q?F4w3MHEWxon2QgsPmArQ9I6OFRotHRvY0KIxooFiGMqNuovrFWZYLNg6JEW+?=
 =?us-ascii?Q?i9etS2FUPRPKBQ06+OBhMpeP4fXq/Ff5oiYbttwQNzLTizcL4tWKap5lus7/?=
 =?us-ascii?Q?rzjfWmVLixR8N+hJ8OfePsv4JGShZk/hHxDLyqCPdi/zg/9XrYCZk/BmTD0n?=
 =?us-ascii?Q?su6CdaKrh5FRs/K4Cv2dxNz1wfgtwZ1NszYZCIDyJuR3KFzLjre0FKCgGm/L?=
 =?us-ascii?Q?ZggAp30/DDes/ywCGHx/mmv0M9yEJT1NDHtsh/LvZRNQcbKBLnVeb5aYj1fB?=
 =?us-ascii?Q?kmUEoPYl/vCWYTDWugnaKgWTYV4ya1J/GnzRmTfsVu3f6oA1fs02yTn7Lm81?=
 =?us-ascii?Q?CPC0zgtEAkDTPp7ulw94BeHK831D38UJmBCx3sBVsh8NPvHqL6fjV4L29Qgd?=
 =?us-ascii?Q?pK2cdYLT7mHY86oMvT0dz9C9XN7YAC+lQRvBojBfItTcKXM1q9ksAcz2zzKm?=
 =?us-ascii?Q?zpa+rDG4JnexiOPJxJvX3pEJs/IOQMQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbe324a-a82e-4958-2eba-08df3b120157
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:54:22.9965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAXQ+N74LyiP/nZFv06i5jBP2ScTe3Z3IECmlwsGrhHVNrktrADMJvWLSF+jI4HTrINvkqO5bKRceBYINTx9or53Q1u1fWVbufN4YB371Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6593
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_SPF_HELO_TEMPERROR,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 13:09:13 -0300 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> wrote:

> Make it clearer that this is a board that is actively maintained.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9209f043f..146bdb587b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1897,6 +1897,14 @@ F: include/hw/riscv/cv1800b.h
>  F: tests/functional/riscv64/test_milkv_duo.py
>  F: tests/qtest/milkv-duo-test.c
>  
> +RISC-V Server Reference Platform (riscv-server-ref) machines
> +M: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> +L: qemu-riscv@nongnu.org
> +S: Maintained
> +F: docs/system/riscv/riscv-server-ref.rst
> +F: hw/riscv/server_platform_ref.c
> +F: tests/functional/riscv64/test_server_ref.py
> +
>  RX Machines
>  -----------
>  rx-gdbsim
> -- 
> 2.43.0

Sent using hkml (https://github.com/sjp38/hackermail)

