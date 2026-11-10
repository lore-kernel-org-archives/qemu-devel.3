Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9260A262D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=XSfNgXP9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOh-0004Pm-Oj; Tue, 10 Nov 2026 10:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnOQ-0003Y8-D2; Tue, 10 Nov 2026 10:04:14 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xQnOO-00006X-ND; Tue, 10 Nov 2026 10:04:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8AHjdG9OztPRNbNqQi+20D+NiUk0XKS/n/sC6xnWgLclhJHEZHotqNCdW5dBc48G/xxo0xN7B1ThI5XfkM8BIiMFV31xbylXV13/Gqalf+ImYHKnigrselh16mZRSs1p/HcBOsKEWQGeFWQ3vHQTpY+ZCbj+VrVNq/UCi/iZP/PcDcB6nYnmcb0GCG42vG6nPrURgEvPHsknQO2RnC5BHxF1u3E0oaj8zunM9WW8BYaFk0aTMxCVRpEUQKkvIAFpYI/F+n+TxsB4xOYuX+W2/65zQCfumYt6AdDjaHJKF5awJqnJmS2CNKX3amux+x/VCTbA1O/O+EL0khnFmUMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB3zs9flSthozt1SPNklKeGmidVYeVO6+Pd0bILzUmc=;
 b=b3bojwYeM9ji0oHVdFXUmYX77ljZCeVdy7xUi1P6IkT2BsSUq1irDYchI3LB+PIKDn700gfeHhEpUsX4a2fMUqjDMzelbqeP2kI3QKsyu65p4PwHua59pzLfZATmVjUxdVmnCn/rCdZbOdzxJf7QcxeeyEc2B07Ai+z7CD8qdXHBghugw2qmU2n9l4mtjPHbPPDU3D3oTXBWpbHfYhdHyw6qzH4tdMvAai20tKgvOOEYH7HIw+pvyKTe1l5cfML7D7iYHZM02FnehcrR0pyFOMUweYvLZ3rSbBaRcW3ylmPbLd4ZkdrRJyM+jSVH3MatmMQ/I/Yif82f72stB+Ebsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB3zs9flSthozt1SPNklKeGmidVYeVO6+Pd0bILzUmc=;
 b=XSfNgXP9YizmqjjpYzrhSsneSunJ/sa3zdsmkPLvwdFDKff0TfpC84LzxbPZrCmLuZHJHCAAr4DOHAj2LOElfBVZOIN/N7gTMRYCzUN+cAEC9Su6MwCmguKPS1Xph66Coj75FyK3KjMEeWtVV7xt038XCyfs57so9mc1kZQrJSjfGB9VqZSBD2LFz4zuesSr/wstZMuIUrKgi5XYWtsvIwMYMOYQNGAxxtPyT3P6FILfvbNLL2zbGgA7LlE72PGPVzg9yQgdPRNRRuhNYIc/CcyTsEL7yY7n1ZUz/rgr7CCnyK1u5FyluioPycJ8picGbFWpGFzq4G9TpwU6L1kJrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB7369.apcprd02.prod.outlook.com (2603:1096:405:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:04:04 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:04:04 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC PATCH 05/38] target/riscv: Add implied rules for Zvqwdota8i
 extension
Date: Tue, 10 Nov 2026 23:03:43 +0800
Message-ID: <20261110150344.3684-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-6-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd1dc76-561a-4644-7da1-08df3f3bdc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|22082099003|56012099006|10067099003|261028144727099003|261102123227099003|261009223027099003|261102124527099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Ods+rdIFUmEfVyt5eskd1hPKINUiizk8JoIzOpOY8PPHZWgHNL78zaoChGHu7Y3qQHzSKpnDbZcHj+G/H9wCz9KD4shiX6n81BdoG5AVSutKZL9KbJbzgY1j9vjMSAPxXdSc/in9zM4cJc0e30DTbMBfrfI91EapV1wI0+8CQe0AsOX7hKVFqNVLgKSJ+OOofilmwiuFlmdNJ4UeJr1yl4CgJtAHh5V3lJnPj7DUUuULB7vvI2IGT8Ww1h1YQ7sJmMZEI4iWTyYr90MGh3R5KAbbxwkajV7WFfrMFD23gazYCxDnciuli8srI7MLDEwWQzQSYuyMe9mHbokcoZ1wZFW4tbMB+ikaQFM9pEH5KnZPNn2B9Zly/5Vz1Yg6D/8JLC8z2x/jEct6N1/2kVNOtvfZsCs1kdFuqXo6xw9Icnzan1ZoSIuWp+Qq3HkpdRmWZE1lZ7yAQChvX3wQYXl+3i8G4hfmiK8sg7N9ClvUQ7QGGDMblMRwhbaO5iW6BRZY+AWGxXWgSbZ/xxyfcNzcm4SUcEF3EORqgciIOKFJmeCqN82uegCyd3M/gKJ/UY0QR9pw7Pgi7bXMLd8Y21gVlr/fUbdieCB46OhIi7Tl7f/p0X6MexcAeoZiDbz5BxCbGWg6zs2i8HabDQARH38uhFL+fzf6n0G76MGJlAMdyeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099006)(10067099003)(261028144727099003)(261102123227099003)(261009223027099003)(261102124527099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D0KGHwib5RcKZ7WhsEsbN/0HTgAmnA3U+oUxymtOrz2nGTHxHHyTHYoVSu4k?=
 =?us-ascii?Q?SLyRXzMPmGVSfpsze9ocNoPFd4o5RKQDQ9/VN9tNQbaxhWvXe4aX2SKNCLMC?=
 =?us-ascii?Q?OTut4sXERcg7g9YwPeDJe1fMH5G15ngu+qriHjDBzOMg249BfA6PxkGgpEWM?=
 =?us-ascii?Q?sjzqsPOFaf4H5gPY/l6/+lJ81lsTwvoPWUY1JrMeAXvSI+VkCmuOBJUAajtu?=
 =?us-ascii?Q?0yKi4tBW4zaeYszarhVIQgo6I/tSZfBFXX4ZlWBJR9xgaQYw8rdwlY+S75sx?=
 =?us-ascii?Q?2U154tUbTuJahTfN8K066P3LbN2XHLbu1IgcHMgiVwIiClkkxGA+T7ZV8TH0?=
 =?us-ascii?Q?c5ezfGVdPgmiIQBHTsARTVqLpXOUmrMdmlFjrrMRigX3718Mv5h1OKFyYWFo?=
 =?us-ascii?Q?LmjOF9lOPspbZt3eCzVebUtNHdsrJC5lp5EAGlsirt6h4Im6D+BnHkWp/CBl?=
 =?us-ascii?Q?mYVNp36+7s03xYCcKXlicIVfeMG94QisBuV3rNA4X7zeOfRuG14rXeL+3DjK?=
 =?us-ascii?Q?YYIoh7I1rtQPoGDNdk8y8OOSFGpAXYbNKaQhahrlNJt3/GFj3LARpGXCTzNb?=
 =?us-ascii?Q?tHXG5fxeXMx4MZJ4WfaXaLfchcbXbXBVe2YyfCGoEJBiPvhn+Ij8xcq99eiE?=
 =?us-ascii?Q?n+78uCjzHwIHsqOsAYBz9iN3rAmW/9WRZvGA351Sm3AsgXEZYdHA1kBgPnSs?=
 =?us-ascii?Q?Y+MUrCipEgevcoz70H7nTOzUcQzzbphAqiZs9SrnyEqaaL5JdvQV0LEM4rj+?=
 =?us-ascii?Q?fLJjdSTotUkA9IT8+7BNMeOypHcuIStaV2aQ6ZLqaZ1KN2/rb+j0mYVxbn0g?=
 =?us-ascii?Q?uV9EXWM/rlvQ7v1HVmzKvps/wDWsaHgEArt7IAcFsCZRsQ53wQ92qhz6dzUS?=
 =?us-ascii?Q?9VCB3H05NAJ/zVuyRmcPJaaIS21YtEDTr+2fY8LsbFG3MZmvJSBLKxoKbY5b?=
 =?us-ascii?Q?HBYG0Ida1KwNSmmuRVdvOxcuKKnOLaLz7cbL+TUoDDuXvRqG0axa+Rnp6vgz?=
 =?us-ascii?Q?W9N9vfU1KHFHJpZTa7NpYnviXr/xaPqYrXw4v2/A/58G5YOmY3aNWDVL5fwU?=
 =?us-ascii?Q?+wVXH0+Uo8h8KHacool+BEwwlna31/qDvvZPCclEwSkxnKxqyZ3RDSDckkSO?=
 =?us-ascii?Q?eIAT2xzAdklXUDISpQizAUjcptNeknRmuCSGJE3Jlp2AkM8TQidXENJUrP7b?=
 =?us-ascii?Q?wzNearmkEUGwbLGKKFdtfirYo2xrOZB6f2PtFDv79zD9j+MsycYSeCRaQZq6?=
 =?us-ascii?Q?wHVkDolC6lDCkom5U59XI9xdAWYiFSGDpvAI4udUY98LORQeZsiTYcngxSLU?=
 =?us-ascii?Q?nrmOvU/28JYHENzjXkugyODQbwV+4J4MT+iDIRS0tUyfVOpMFfhu1qVVK4UD?=
 =?us-ascii?Q?/FfggA/0DkKc+W6BjcBWVlb7t222t+9J8z25J8nyAJrHeDOLY6rgthClNJ08?=
 =?us-ascii?Q?0K+gPaCilFN8npTYzUsR7oqX45mqESuOARmQoOWxUcK9kXGVe403sXiBBSMi?=
 =?us-ascii?Q?yX+mjKzjl4D2WTSbfn/RCOR22Rhx2plquO29AEva6rWSaqpkh6MFk/JNLFiJ?=
 =?us-ascii?Q?/1d3T5RRtnlOCQwgJs8aBk3L2ey5WCo6HbCRnJy8XtHd7iHxJWTyRGQ+5PU0?=
 =?us-ascii?Q?olBfW/2YIvVhArkDoTcltlFLTLGE6qzAV1CH8ae+b4Wh4SEchCr+uS1JPmgq?=
 =?us-ascii?Q?JaYOFIBTTU73qcGzThKM0GhaNd8fveVHqG8gZu7XtPkwBbK/H6nnrr4yvWyZ?=
 =?us-ascii?Q?8eGEIgCljH4zij8kSbylsKCZbzUqsgk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd1dc76-561a-4644-7da1-08df3f3bdc75
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:04:04.5858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG2IX1uHj8RoCx9NC6RjHQNnFeUx+0Qq6BLjcYNU5l+FEyvCybX1/2azttB0MRHLY9GuUbqf4tKFxgFowKni/MRVi9avgeOpzl/dBSjcURg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7369
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:20 +0800 Max Chou <max.chou@sifive.com> wrote:

> Add implied rules to enable the implied extensions of Zvqwdota8i
> extension.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 96a1d76c5a2..08b14782451 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2851,6 +2851,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
>      },
>  };
>  
> +static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvqwdota8i),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
>      .ext = CPU_CFG_OFFSET(ext_zvkn),
>      .implied_multi_exts = {
> @@ -3055,6 +3064,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      &ZVKS_IMPLIED,
>      &ZVKSC_IMPLIED,
>      &ZVKSG_IMPLIED,
> +    &ZVQWDOTA8I_IMPLIED,
>      &SHA_IMPLIED,
>      &SSCFG_IMPLIED,
>      &SUPM_IMPLIED,
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

