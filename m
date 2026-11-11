Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79590606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=J7rlHhfL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2C6-0006MC-66; Wed, 11 Nov 2026 01:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2C4-0006JU-Lw; Wed, 11 Nov 2026 01:52:28 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xR2C2-0006UO-TO; Wed, 11 Nov 2026 01:52:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWiQuxdCInAuOwm35L4jfWI08gU4y28aoZ73ZyXS5/TG6AmONpJ0I9Nf7Ea9NzgOPLr0Q+vXKt7wyr9jsgammOhVQ2SxRPE8uYWAYtHYdm84eJx/5tmeE52vhSzm196Ipp00qNP+rhInJPeLlYQecdBvcuXDC/Xe6UkJz3ksryN2dC/XCkdf3oRlIr/WrlpX5c2INDyDR4/myS7Z/SM9FfhSQKDVzA/TgNucsteuI6Dm5tVrZ40cVXULty4zbkYVdSlJ/I5uGXDM0lc2ewrJZTM0Ro5zReeu9ky+nk0G3fVajJxSj1IEYgKIlmhXAB/yXELjbmK7i1G3fouKxkm7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFUixsuYwYx0PZxZyLWH6v5xkKp3grIbR0xpvWqhZAc=;
 b=AM+h4f8EQJ88AcHBQUt8scEYBBPFv2H6R3mCRj5idhl3epPa+fAvz15CFUdxofcuoHSHYw2IYbhcsa+iBd7AawpES/Gz6bozGaSAuXA7UMZtvwIgy84bIjx5/mHVKIuvrw8u6rcVly1Sk2su7kXq/X5Vd9a+0y/BjcEPLE6EZXbsV2RSHnwYszZebNyrEzEB/OWafQJcOO+4TvaFZwl+oPfOf4kzUrLNOMXk7mpqE7ARC00rCxlFxs5t0e8P/WfC+07k6g+TR2j5mOdw3tLgFU3BYFv1PzSKZZOLGOcWRfjAzkcwKH+ybM/iI98urrHGJchQAPK5txeCK38CRBsFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFUixsuYwYx0PZxZyLWH6v5xkKp3grIbR0xpvWqhZAc=;
 b=J7rlHhfLIoOIbq//qMMNXedT0dMrdAGXrDEMINyjObYtyQJ9pNgOnGS+YjuJht1NjrejQEcm3hXJpNhXaOPtIAgyseMpap3J7XftwLfPooKoqV9+yfZKPe4QjnwBi48cc1ldxO0tV78zSDsMyWjpLxjInioAQQf7nc6cCXVV5wv16pj720dbarKx0m5dq7dxyoeTh5ohVj9UnJTzYJG353viucKbNALohIX0xIMYC7J0snxTh+sEdBHNc4O1e2ytz8JbfcRvzMt/gAisx8cy9ahKGsUu1xqGenU8buszwpT1AXnxaHjSERBlMnaOlnteU6IR6lpJfjr2aNJwYvayxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SI2PR02MB5611.apcprd02.prod.outlook.com (2603:1096:4:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:52:21 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:52:21 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: Chao Liu <chao.liu@processmission.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC PATCH 18/38] disas/riscv: Support Zvfqwdota8f extension
Date: Wed, 11 Nov 2026 14:52:01 +0800
Message-ID: <20261111065205.36877-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104194155.679241-19-max.chou@sifive.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF0000409D.namprd05.prod.outlook.com
 (2603:10b6:518:1::50) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SI2PR02MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c99ed4b-a6af-4ca7-0208-08df3fc0558a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|56012099006|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|261026140227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: QF0KLkoIeV3nHhoMXCUpt3Y58E62Hq0egRwUyt53uf4JG6K03S2TssjE6trqoR288EmHZvjPcCs9iTUb81Is5PwHhkhvl1lNFjUaFdFpSRAOvoQvpnl1Ln2XUdDkGeksFa3hc2MwOgNXR+83ndOg6KGGzvYQuV6eTsBKU3mzuPccAPR5eaFePApYol8142Un0o5UxMi6mv14HgzjB8Rg9IwzOdyljwPySaJkQ5Inx0hXlxTnJhSQrqH7GuTn/7PiLsGZIbeznnLBzvV6c7hOXEUmuBh+0kA880Sdp9FPa7LTLXeOyd82Lsm63onSlc8JqfCaqk7cnGP1O+p9JkdNBHz50YZHKWFCgkh1kz0KMCJxiIy90q3xZVyK0IgOGm8qcR7sWkL89/feuL4hL0s/4X7GaL3T25tOsbUaL0i4pSH6tKU9KAO1An2G0ROCXhFigabXbYJcPaOI9iz3rJ3fbYe5maToQz4ftP1XI2bhUuarI6JPV7p5kkwXcpJn7DvyEMdlH7GOrwICMa4M97J0jw6pe4yncPXqpEWmafUdUekGOOp7Ou7ck4uUa995rHAMTc7Tcr/ltZbpVUT7Uf3lGJlh7wXNvmmw3Tsr8HHTTqdGPemGr5a0g8Rfql6ixrSo1mO55vm8s5nCDaMqiGYe6avnBbL+q8iM4bF7PWZzB10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sq3unCgRUfuF2JF3/pITzGiYn2JhDXtIcafKMHNZTfEhJrd4/mdPvLRjzWfh?=
 =?us-ascii?Q?fUEHFwAhrNEZyioj5RD+CPFieuVxOI+Q5SD9WnY3u7Lv7JincU3Pd3STMoWw?=
 =?us-ascii?Q?b+boBvpfJi10LkLTj9EltvuqrskTQ9BT1GcyXVI3j7iwtr9SzUlg37f73ERb?=
 =?us-ascii?Q?luJltlTVhDKsQcerywuzaXdp5e92AQRM4PbxS4wbuWcrVmaiDr+QD7kmLXOC?=
 =?us-ascii?Q?Ko9DkKjb8wMkMrLkfBXR0pNAwVaN9UTgx+mg7cdOqbnlWOlBPYoivYGl/QiA?=
 =?us-ascii?Q?K0wffoI6HiBHhqprVFub5MaixoNEEp2/Dd3++jUOnFJ5lKVk5O0LSgYg/lBc?=
 =?us-ascii?Q?KMQmpMir4qvWW22dXnEO3bba9G842YjUrUf0beyXqLRUDRSEm41NU1zapWKi?=
 =?us-ascii?Q?l+hvkowWByltFioMQ27FoCbsNt8N1yQm/Y0O+WOMuGfOIKn7nu0gIjp0mUHI?=
 =?us-ascii?Q?nziplt7F8mfJscD0pLt3A+fm41ZDI/jjXoNKnBDKIi3QTmhNjlEkJfVytCkR?=
 =?us-ascii?Q?1ipQzRoaE0R6b+Y0y7RA2C7IpJcEJYhbA7MLAni3tj+58JUR5870cy2p3ZDX?=
 =?us-ascii?Q?aBvQ0FD2aUY+ZSRMBWB5nupJe9dGDQtfsAAtM+7NkxGMPknO+Yi53Bjud8ek?=
 =?us-ascii?Q?U3c15+8EkekMRAfxjbdwmeSqyGl6LXyWLG9J/eh8cT3bpkUcc6xTIX+ssKwy?=
 =?us-ascii?Q?J6now2N1vuSmLWtRZye5a9rfdmyy3nuRZM097DWIpB1UstqXiLP8duAoMCes?=
 =?us-ascii?Q?Cfu9up/jwpfDB05rnXbmXdI5e+cOdzF3pPgzPgWmvyweIH5m7MrxpUeCCYF6?=
 =?us-ascii?Q?M5RLA7fIWW+MtgvxamDXJ7K2eBtLz3ntkcU1SIMAQ8X+DYDqE8ajl7EwMSWI?=
 =?us-ascii?Q?Fyp9bNdO6O5GVoT0fdXHQfbp6SiH9eQCRd1arT6XwHtTRYLSeo5SCrRQZSAt?=
 =?us-ascii?Q?F/VY4lB3jIYV74zRL0JO2hcC/VIuk7Ho33AjAhJCUjgArtqv5c+7xQ9KhZjQ?=
 =?us-ascii?Q?9l1R5uoT367O+P7+lKyIIAJO5uSJTiTI5XXMILwM9fgikOkkmf+KC9U+uRYV?=
 =?us-ascii?Q?68xBs5wW6mWhz18I80qtyjUqt9Kf6J7JO3yiFUPP+ACfkDXby980y0T1U2Mw?=
 =?us-ascii?Q?ggvudJPVrpPFnpMsBcK+vP9x952eCDdecCQN0W05YERIoKxriYk9KgXN5hlh?=
 =?us-ascii?Q?jSez4HHPZ0za+8WdXFiPGpFXAuK4jub6dG7cSsr23RU45hMaMFbYCqWG4VUj?=
 =?us-ascii?Q?ee04drE6lcFQN3ztPvu1s2GFoNXJABuTiIA4NI4dkExwAAFhhh0cE4VFkMhK?=
 =?us-ascii?Q?URgqshGCz6UBQ9zvcYcb0cXN8AZPhBv+7ICcKKCSPBlhfIPZW/MCw988y62J?=
 =?us-ascii?Q?rjLMvqKTMercMbmn7oqjEi3K32QYqwxVwbv+jbV4XUBUBSwSVE6fGWy3iQVm?=
 =?us-ascii?Q?OPTRsNlfBMypZjepy6+m8Uqa9cuvRPaaF/1xATkkrjqhjV45pXfuxI0u53mc?=
 =?us-ascii?Q?SaY0OsmdNe0DUcSwxfDm1+slMNdOpVAekOaRNyUqThN2nKFN8lQrYmwyhzkd?=
 =?us-ascii?Q?ba44J/RWkQlddqrOZekMA5llZcWtkXah+Xpc3rIMX9dS+0/+eUfzTvaED6v5?=
 =?us-ascii?Q?BF4u1cHa4ydiEehZkSNIYSqt636WFh6ugXpgkduhwIWgCrsuTMXT5YHxSGBX?=
 =?us-ascii?Q?G2mp8A9mIvaTs5bZzV2jyl6+MhrQd2Sf7u50o0cmyh/L8waji9Lclg9r3ops?=
 =?us-ascii?Q?S+NGhWjc6wK7UZrKiNaCg2N7g9LxBWw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c99ed4b-a6af-4ca7-0208-08df3fc0558a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:52:21.2834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23HXFSD74gRNLbdDO0k+9b99+6bQp5FnyaMADpJCI3ii7zw8/f/MLPbFb/LmxHx8P7idTIFndY9N1GfrcR8uuZZPIRx8FkqxM2L5nhMWEqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5611
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 03:41:33 +0800 Max Chou <max.chou@sifive.com> wrote:

> Adds support to disassemble Zvfqwdota8f instructions.
> - vfqwdota.vv
> - vfqwdota.alt.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  disas/riscv-op.c.inc | 2 ++
>  disas/riscv.c        | 9 ++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index aeb9423f130..5ba29f52976 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -583,6 +583,8 @@ OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>  OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
>  OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>  OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfqwdota_alt_vv, "vfqwdota.alt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfqwdota_vv, "vfqwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
>  OP(vfrec7_v, "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2)
>  OP(vfredmax_vs, "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 62feb4c653e..0f609cc06b4 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2640,9 +2640,12 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 39: return &op_vqwdotas_vv;
>                  }
>              }
> -            if (((inst >> 12) & 0b111) == 1 &&
> -                ((inst >> 26) & 0b111111) == 36) {
> -                return &op_vfwdota_vv;
> +            if (((inst >> 12) & 0b111) == 1) {
> +                switch ((inst >> 26) & 0b111111) {
> +                case 36: return &op_vfwdota_vv;
> +                case 38: return &op_vfqwdota_vv;
> +                case 39: return &op_vfqwdota_alt_vv;
> +                }
>              }
>              if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
>                  switch ((inst >> 26) & 0b111111) {
> -- 
> 2.56.0
> 
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)

