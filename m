Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486A606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=lvQdfArY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN3vc-0002dr-T2; Sat, 31 Oct 2026 03:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xN3vb-0002bt-5K; Sat, 31 Oct 2026 03:55:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xN3vZ-0007eN-2n; Sat, 31 Oct 2026 03:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft/LYIqU93air4R/QNb5ny5LQ2m/12caX5/FFTnV+dX4lTFg7KxPPYx6IcdNBWNqHF+MxI/1BB5s+IHpwLAMrQQqoPgAKL/qKR0B/9oG4Tmj8PxZv1Wi4WJfZHh05dsHvudv9Nv7XSeK9jlUJl2rorkBsYOVPvFYc+IbvYLvefAaUAN/EQSHvFvFLIRjjYSXEsDDx59a7GivhrXknVQGhtvTZ447YqqNFD9mZlYY0aJwJTT3gIK6c8fjriDvgctudquwhh1AwJdFZ1tI8WL6/cjXiD7hpYSm3K5vIBLxYjhwrZkc3iHq4+0XbCNlf/0XHsBvHemtJE1PoyWLsAC15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuzrcoWXkmwygDR4F/cNWuwOgRU92ptLtapgp8XsjOQ=;
 b=DHEKw9r/RF7FM7d0L+r2Anif7oPqhXZ+2ICpgzZG+9uRJPTS5mewyb8ClYtxZhDkcld70k+nYno7RtrLLabgTb+3E7Af7OtsY+eHlRf/BpWqM+c5dgGx7m66XS5wFKJ2gkwC3+rCbrc/ztfuE5W3EvKmihGrWRyW/vcsFyFFoJSSmmzaB4pW10znWao+KKlNE0UMWGNn03hYQJYcXKLdvLLRehgmDXZ8OdtGeZQCjGGbAp66Y1BJ/mCRfBv06UpzA1GYFRYC3h0taxtA1zK1Z08SV0lWz4ZVgyAmoJYLfFvuen4HuAd536lxJS1HN3eIyFznjuth2e3CoUCBIBZFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuzrcoWXkmwygDR4F/cNWuwOgRU92ptLtapgp8XsjOQ=;
 b=lvQdfArYILyFjnuB6JfsTaxGWINAzUHfJUOk5GzDT5tpSn+MllTj6qLegPAONxm+ueyQLR6SqLB8HxGz4ID4g3r4VB7upgIRz9PP+o32q4PGsNPp/Wvr6S/gmwLFlTiWA/xqD6Hddf8l3P15R3+mi4ybUIJl8fcsl6O8rahwlfC7AbiIhpCvAYKj5G5GtAlkAo51o/YwoxYI9jF3Hoe2NoE61D0tCuC6fXQwF3gnl156XVjdlvtDKU6H9Z6cDpH54qnawex1DgOj0gv4Qrq8PbK9LIEd9Vjzbtr1wnCdm/ERqCC4T5j1HcnxNzj2A6DBKK7zUA+wcOAPNBH9Iignlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6798.apcprd02.prod.outlook.com (2603:1096:820:112::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 07:54:52 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 07:54:50 +0000
From: Chao Liu <chao.liu@processmission.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 0/2] riscv: boot the K230 from qemu-machine-images
Date: Sat, 31 Oct 2026 15:54:31 +0800
Message-ID: <cover.1793433265.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 991d564f-8bb8-4cc7-17ed-08df37243db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|261021121427099003|261022115727099003|261022075727099003|261026121527099003|261021123027099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: j6W5RqP9eQAmeH6ahe76EdlOXgOp/bj08VmQOpCuX6La9j0l5r2sEuMvDV32Sise0oQYdaWauOILQels1AbXTWFOXQ7mz4uoDqiw2Thve5HmFne00hGJ+nUENMFc4us+zKAlgwYSWsFnm4+yd8G4uf655yHBUHoxVerQw6T5dpa7jJO8WndbeGiYNCe9FcbHpEtVJZdPJSX0aLxR6rjm7J+1WCHJOf61DFw3ciKCMfTk+EEIq026IwU5avyWME1amrCkb9Za7GCQMNtjloBPORf89knndE/Y25Sm/9lGpHY8AEc5mHPlUjZKzYye5acyFDUcu/HWD+ds2FhW0XrgR44FAFbfEqoVOEy3JwO7yyP5hDQGoeFvb9V4LPRbwLhYtjAVgkX784eE3UkQtCbI657nJTFVTYd03asV0pVzOMKd5zI3JbPBommi/WZSRRgSiNovtmkSfH75Bo6TDdR3bdbgAIMPelrqyvgdtFFxTWCM2pgJBUUB7sUkYeptQPhDepVwaD/7yUPGAjdqhsGwd45lt7NwJPdKqKGRiFbP01bFtwo/q+eJkb9lZKQTd6duXIgrbTuhCtoJER1/4ypEMhlN+4YqEFwa8t6EVIA6Ri3MQ7mB6GshWP6jRw1XjwxBsglsbXEeBKlcIOvdGGbepGl9Dk6RpoIsDe4E/og23OY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(261021121427099003)(261022115727099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owh62Wnl4zUM9g+i2Sg4rFu5Befq9LtkbmgZ3/r866Iq6akjGXUahrlWCV+X?=
 =?us-ascii?Q?AcR1LeKARLJPHd8B1dLsa0kbgpMtannFxKYbUvtzQ3JszVRBVDLHVlTYPKBS?=
 =?us-ascii?Q?mY+qWrTmfewpNtz7yqLJLv5qm9t1WOyVPVxdaL0ysspoOgKR5yjywBnCmT1d?=
 =?us-ascii?Q?btfAR90dewQVwRkSGzKXh7Fbj+W6AjFVmNCwvQuNtLV7+GwuFmudlPealBgd?=
 =?us-ascii?Q?/0irRmOAhkmqc2Vol1H3QSAmLSyJpzP5H7HntCePMcbA/4J6DRmeC04QFkVA?=
 =?us-ascii?Q?UW+WyT1YxFWrje8MkZCllcu7u71CuRe2+jPdh0FKvXsoRLiZ7sbsH0Q930M8?=
 =?us-ascii?Q?+EyrxevMTuErm5UskOXE+osHjNv/lQPSUaZji2wC7+oYBHT99uIkmCBw9J4z?=
 =?us-ascii?Q?Mrufo+/g69f5GmLiTwZRiw4svqzYy++gmIAYkZ/gP5Spgl2DU0t4SOk2ZdGs?=
 =?us-ascii?Q?JeliizNLi1YhZKJ0AOzQMD4rjJ1/Tv/krxJSDHCfl5P9TqINTTdQhGW7Jn2c?=
 =?us-ascii?Q?VOEp4uAm9Bpb1/RAH4xlmybXoVI4dafr570jxsd0HSzoDguR02F46ENvNVOc?=
 =?us-ascii?Q?u4R8xTZ01nIH4DpC+pcJfbDGineVxtkbgLoOOQfO3L2gkd6jzYm7aT//kax5?=
 =?us-ascii?Q?gLdCX7cl39wtPDcATCn+NtLibbpkXZJRjxkRjvg/AIZPXQzIf+f5kmw5p3J/?=
 =?us-ascii?Q?ZmfmR5J0wPEoj+/NHhnjXV6jHGWHlDpT19Zc+spuBJGIU9TdNu2dBy0oPle3?=
 =?us-ascii?Q?5xuLGbSMKKvq8dWxK0R8K2UuZ1EjpL2eFTf2ABQbBGugB9Q3lUOoXFdFeCgy?=
 =?us-ascii?Q?34xNa5fUGVi3Z1wozf2NtV9S4zK8RmR6Me2rP5Q5tfAEsj0nG4C3KqWMJJ1d?=
 =?us-ascii?Q?Ql3gWHvRN0oflxuWY+Waek0k0BBl5x08ZFi1sRsRKhT7M3ybRL8G0fpQV5Ns?=
 =?us-ascii?Q?6AqJYJZvWQpaxAHvp2SGvE2gWnGAq2rkXGXMfHRTxuKVh37/WeKD7FRr9b0U?=
 =?us-ascii?Q?qkh7zs87NF04ZtbvAQoltU2Ry06jT7mbHIVSJcuNDwHSlViVzHUIeXHybwLN?=
 =?us-ascii?Q?lY7UM887C4oh/MMH2FfsnJBUCQROsyMnvcbClrsOZlv4cx8b5VP9JROgTUHb?=
 =?us-ascii?Q?6XObOeo1b16xBnHWX49j+KIw88oEyhw6k+UqgTR05FqxMM8cACryRbdh4nGG?=
 =?us-ascii?Q?c7kIEBfjN4icncI0CRlEymF4SwNDKP83YoqJUmXFRJcGe3gIFNcY422YnBiJ?=
 =?us-ascii?Q?zdyhFLWOiA+rdDr6/DU09nvJ8FV4d0TkbcYJqVal18J0B94li+tQu9od01gB?=
 =?us-ascii?Q?6qh/eyHz/jGVAVGfOdvlJJmBCn7kyc7HClolqtqN7cqjjwH/MnBr7QJ41cQh?=
 =?us-ascii?Q?H3GzTv3yGwEKxYA3Xuso7/UT+pk+wd1vQU7lmQ2MmPZlVfjeu9WO7JSx2meq?=
 =?us-ascii?Q?wn9Q/rVBrILP2BkUE2vfTh0e/J41ZwJPLVE2JQ5KM4zk9ZtNMh8d6sysZzIs?=
 =?us-ascii?Q?t1ckJ2Vi/e5riNRHoOTkHjj6ElzvNL8B7Pe0Z6oxuuFIiYiLs05dtkuf5j6u?=
 =?us-ascii?Q?LuJ49KE2qWQ2eKatODDpLD1ipv5zcVPujqvZAycQOCSZNPEXzMTzOQ+6iwvp?=
 =?us-ascii?Q?u2enpB7EbzxabVoL0lXc8BW62mGE1trTBfy4VQjJCpcKj+Q8I1HIeQ+/ushi?=
 =?us-ascii?Q?iCeWNEigXp1kZk0MNJm+T0VTampm+v5nQS4QviWSjB3iY8npFj6pqynV7rTX?=
 =?us-ascii?Q?51Dpk7W0+HM3PzHFJUxH+HPZzNcRuAA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991d564f-8bb8-4cc7-17ed-08df37243db9
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 07:54:50.6238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvbnIj5ozB8Svl9OjJPKcBHagLxFNCMbmNcWgI4P33pOTqAIWirfZjyd3dByEV6PTpxZU7jHZ2D6iUaDajKWzlLY/JmaEe7c62YVpoLuCHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6798
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The K230 machine has many hardware models now, so I simplify
firmware booting flow documentation in this series.

The K230 images now come from qemu-machine-images[1], which
builds them with the standard Buildroot image build tools,
replacing my own repository that the K230 images.

The series has two changes:

Patch1: Update the k230 functional test for firmeware booting
Patch2: Simplify the k230 boot process desc in k230.rst

Link:
[1]: https://github.com/processmission/qemu-machine-images

Thanks,
Chao

Chao Liu (2):
  tests/functional/riscv64: boot K230 from qemu-machine-images
  docs/system/riscv: simplify the K230 U-Boot boot flow

 docs/system/riscv/k230.rst            | 60 +++++-------------
 tests/functional/riscv64/test_k230.py | 90 +++++++++------------------
 2 files changed, 43 insertions(+), 107 deletions(-)

-- 
2.56.0


