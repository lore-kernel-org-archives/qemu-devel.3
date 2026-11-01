Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4D606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=ULmjVbSj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNPwb-0008A3-Nv; Sun, 01 Nov 2026 02:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xNPwX-00089m-6p; Sun, 01 Nov 2026 02:25:29 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xNPwV-0004Ch-A2; Sun, 01 Nov 2026 02:25:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3JxBPJ/mlMjjhqPU2vfxBMd6cKaGP11wSIP81D4Uy/sU4pil9MEPEVFiXE7eujG1l2q8Wj/vduVEvxbbssZ26cZarldVWBGKnlgvc+PKRDVGsUSHDobLDtqKXXHjTbFTPuJdmzbXAu5HQ2ROyX0B6h2cbwfuZDlzaPwvcZNTK90jdOEJt7VsbCx3AC56UDUSDxmmtOqnVzltRlWNSs7lbEBg63ls3sZhIceIUNPQZz5mhDK73NEsybvjjT5GtymeUs907/wOuQhRXG1Arv3iCCSphkMDOsmr3a4btHuIek0SwJaxK+mY0m/UvBMJv4rgpEchdKIwniM+tDCLoEqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY1suf7Ya/883ZdMDnhJjk4wf3x2mVut2k/7eMcbe7k=;
 b=ESzg3lTi6IX1pxYflPAeOrSFXPQ5SNjFr2cm1Rf6Hz0W7rWcr7SqJxxHY+GCfsYbqRUMb0iACoyzH6AO5Fr08vjO1uRF3KnRKV/b5hCLvvLjMTdVxXmR1gAjHcIAnkRUuikJn3090kSD8tB694MJE0CHqH1ThwjEX9ox3QGHNkvMu5Yc0vLIqqhAuoG20rWzt5mQ49LHV9A8T/VP6RrfBYpm9LNxv4h6Ig+9WRqlRjjZX/62pF572sTQrm064kpRaxS+eUk0f/Fj+JDD6htIqUit0GPulwNN2MGgGxtnBGOVe8lzTD25osQU8UlUWEW6HH8YTmv9n5iQWHrv2cRnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY1suf7Ya/883ZdMDnhJjk4wf3x2mVut2k/7eMcbe7k=;
 b=ULmjVbSjx4yNUsZZwm5zDFdChqEanP4IpLtQQ296pitQjQFmUk9jJzWx+HQIclpHh0/E0UE2RuvTRJA5P6TIu9Qz3e1OCqhEIaa2t06vNNlCQoyzEz1u/Uopi7jzNNuiEZaADJ9Ps7mbpuvjvHcECdH+f/LMqo9JFtEMTfSA0X8c+WQVyLHAjNYecHVy8GQ0BdYNRyzzMZtSLk0h6trTXcuO5n3HRkcWBibO/dV2KtHtzI3KU3rQFSRGYeA8bJapMEFo+oIc7o9IGAu90cv5hkbQAvYek3OyJKExXMG+bugep+ScDql8TJ8BMRHufNPweyrkNZ+4+aGSSzo7z7kM7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by TY0PR02MB5993.apcprd02.prod.outlook.com (2603:1096:400:207::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sun, 1 Nov
 2026 07:25:16 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0569.010; Sun, 1 Nov 2026
 07:25:15 +0000
From: Bin Meng <bin.meng@processmission.com>
To: chao.liu@processmission.com
Cc: alistair.francis@wdc.com, bin.meng@processmission.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, palmer@dabbelt.com,
 pierrick.bouvier@oss.qualcomm.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 1/2] tests/functional/riscv64: boot K230 from
 qemu-machine-images
Date: Sun,  1 Nov 2026 15:24:59 +0800
Message-ID: <20261101072459.3767273-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8ccce284bed69c31ee16bcbd95d562e2861bd636.1793433265.git.chao.liu@processmission.com>
References: <8ccce284bed69c31ee16bcbd95d562e2861bd636.1793433265.git.chao.liu@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PUVP216CA0010.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16f::10) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|TY0PR02MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d52f5c-8a17-4490-c46e-08df37e9460b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|261009223027099003|261021121427099003|261021123027099003|261022115727099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n67Rv8cgNP7iB20xwp8vlfOkMAIaWdfSETlTdWqiyhi4CsfKQduMn9ZF32mIpft1weoUUqvc+cNhLimFGzOPwJV6Wf831uwRG4dwpvC5BVtx1OHMQiAV/h4vDs34kKoW34xYgmEJNjcpFH1U4/N0xDHmOOXVhwSwHwK4kKqdf6xj2tbjIGQtPs0SK0iYddP8PpZBiiLU76xE735Cb0NzW9qu6g0SM76iVGGqwAUHlF+0ruZilUFtWQ061EoAqBR9s9q2GZytcOpYJsVwab7+3PC+oJYPh64lxXxhe+nk6PufWtfYYdb5XeJnKfvtZbQEzcedga/E0kaDOszarpR78sVr9vPV9KkR1dLn6FrLTOfzo7+WeYti0SJLKmQrrI78Yu8QDdHiv9vhBu2vpvUfV2E+1PptEvg9dbnAeOI12ZcEO9rXRdiDPzwYwsIuvwYkKZSsXj/SGPxY7avd/spBra34mnD5W4fWYTxSpRr2EC/6iW+hStGW5LgOpq+J4CPsW3iAkcaE7klo82B83aWMaPreALebDPe8rRx6gTKgIZDgQXSXmAO6k85UP56guVh0G68Qg2i3Eb5UsSoge0nzZ36ZfvCafRLNaXvBqOhiTqdvupKianIt51l3yC4uEG/IsMgpMpEoZodOl/VCtvgBWYzcIpknUv0sCLnRaCuVi0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261022115727099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJKaLjJE7GFOmwqpAddvknJ9v4ueoSFjFUpfPjiMkVKM1SKumpZRlfuW7tlz?=
 =?us-ascii?Q?a1QSXt6vwrkyBlqzrRb8vmQL0eMOAlE9HBKCUctoeaoEBaqUHkOOu4Oe3Iww?=
 =?us-ascii?Q?l1/V0bzccJFMVzjOtthe4ynzwuQIR6Jr3Q+aEwc/d5aoWnlBkJ403ixqtHqx?=
 =?us-ascii?Q?jo9KeMfql3OVMV1aljfrlnkWghz0LFkLjALdixF4IqOFgQsEHGQYncKmRbSk?=
 =?us-ascii?Q?LNyhH+H1GZK6+nQxOfxeZEFxexlVr+MCM5levAXFtay0IoT/Ejvq91ceVDU5?=
 =?us-ascii?Q?Cv+CFEOMoht4wlctVoZln2skw2kpdcMvLdrEYM6/7YtYT7nb/S8C4RfGbn1C?=
 =?us-ascii?Q?t634SGg9zwpCqdttLW7oIqd4VScfkQtDsvR+KWS2ms7+il64qLOFUltIQhBv?=
 =?us-ascii?Q?dCLPqBk+In1Q+Amd5813U0M01yZbUBrCme9YJb6tc7U6AsNv+4h0Mmos4IfA?=
 =?us-ascii?Q?RtX1JDLG0F06P3BxTViIpjPispUoF+yFtjyTkHQGhY90/Ebrm91FJQV4NLfa?=
 =?us-ascii?Q?DJ+yQLeq3XfFywXl8K6tQWj0QS0oyvwPGL3KyKkq5Rgs+ktCFq1Ykl8Ym/BK?=
 =?us-ascii?Q?QkMxNk7xfZlZ+9osxTQaXKTlBJtFQQ8lZOCDXyT6tnU5nxmd453xa1wR9s5y?=
 =?us-ascii?Q?zgyXD1oVi5aNfpJizzhjqdxXKYJOy1z3h/CmNF0h7Z2EOw7T0b3hncZTnhk3?=
 =?us-ascii?Q?8D8egxNkemfU+HC5KavlruEr1Q/h2twTMXGV9vTnZIRc7C1fCU9gOZGgELY6?=
 =?us-ascii?Q?1dMui3tfJyl24ubwOPA0R2F9zTzJhN1HNYhha2dNR6G4EPe3xgFeILrvRp8e?=
 =?us-ascii?Q?4pG69MqdghkBpLxFIhQ8aGo6SEdWo/oeAA4nAUnA73PJmzKh1eL3Oydqx/fu?=
 =?us-ascii?Q?rW+Fn7XTgV5Uqhvt2NGIcx6JyyJ/fGRyU7ni0KnTzkw1unZDWXLd6PQRj6nd?=
 =?us-ascii?Q?270tkG/lwhsIlzQNiL9HrsARbrKmpg1/V/StIUAxDFrTxNP6DjdbrBXWkvOi?=
 =?us-ascii?Q?DhWtoCE1q4xOY5tUOEzoj87dl0u6OW31RBVWau9D5IdVQrSAP+QoDIq+sM7q?=
 =?us-ascii?Q?zSsVzTzmwYA6D2Hpoabs6GJRRI8x1En+v3uiI+Sbjo40JDzJZQ6K5Nysh8pz?=
 =?us-ascii?Q?EiUIDJO2UnwKhtiKNdwY7Tg1hUflOe4d1VRZqrLJfVPA+g93nkHGBzXiVbRn?=
 =?us-ascii?Q?hMNNN3DM+Ty5IHjE9JlyRFA84Kp6X+4VH0DTtteKaN1snY4W9xblBvrSC1RT?=
 =?us-ascii?Q?IzySKVDYcbna5KyTnb8aEllQE6EysTdc1sDngG/otOLpmlM+nI8EZHYruusA?=
 =?us-ascii?Q?S4hSroN4EIXPs0rCKVV9EALBgmZQ1TbMQU+CWOT4tuTiP18SJ2fVymrJ04Sm?=
 =?us-ascii?Q?++g93Mjkyj9CJDnM0UID6OUyBZaQ3Ep9Jowm6N9KKlCgM4fVbhfW8fcC99M8?=
 =?us-ascii?Q?OxW7GvVRvGhE6bzNxkndGo0EXt1lh8YUfTyQ3gxzxWFxcwqR+OTgzz/s0EFb?=
 =?us-ascii?Q?pp1QOg9kydVrtIQ6+ZIJ9gMuJ8EqqHgBYWkzIwSGxRpqXgMVfxX3ncNc1mv/?=
 =?us-ascii?Q?d9g4Z+dhsoQIExx08eLLpbYEG2RqiYmyXFnU/gE1Ot7u8xqpBq4cUcxcIWVu?=
 =?us-ascii?Q?bdOhNgDXFtUn+sohRjn1la9rKciJawFjkzRzNnTTTWLTJ0miasZTNmTQvVfr?=
 =?us-ascii?Q?aIQwiaO6Kib/1pKzUTOwCmO5sAiWbGXUjULMzr8DY1+rA3NdGgkLKyWqAUIs?=
 =?us-ascii?Q?9x+4s5ip1odnWSXkui8/0aQgmNh4kbc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d52f5c-8a17-4490-c46e-08df37e9460b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 07:25:15.4833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtfUYJGU1lwoG1BMN23fqAYxp2nFvy33XqDpWh++bH23dRYsvXyVQdzwu3kDfEgqqXjh60lFxhMmbj1PWW5mFS6vDMoaHAydG4k08SajcAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5993
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Chao Liu wrote:
> Fetch the prebuilt K230 images from the processmission
> qemu-machine-images v1.2.0 release archive instead of the
> zevorn/k230-boot-assets repository.
> 
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> ---
>  tests/functional/riscv64/test_k230.py | 90 +++++++++------------------
>  1 file changed, 29 insertions(+), 61 deletions(-)

Reviewed-by: Bin Meng <bin.meng@processmission.com>

