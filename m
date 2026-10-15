Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CBBCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESX-0001lZ-Px; Thu, 15 Oct 2026 01:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESV-0001k5-7r; Thu, 15 Oct 2026 01:56:55 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHEST-0003Cu-NU; Thu, 15 Oct 2026 01:56:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W76/vYLcElYEib/3pdrijm7fp/+4xFF2TZtYNaLAJD7xtTEKK+Vh5AgOTasD9uUCF0jjoehznzddTmyMsPJgAXV50oTGo9Dl/vkoAyKSf/XyBHMVxh78VM5BqTuQRG1ORG99QsotyUKTmhAQScyv0/2HAG2AqU9M/hNKY6vkYT9irRzZDPkOrbhbR46vIYzhlAWCllNEBnF6xkwaFs2G9SuCkDFJNSfYznUQpn8cZUmk9sEr1iQMSUCc8wvBPl3ThAB4h6padgrB+H/VCBKPx42Fj1XEzEzo1vld+vEmI/Z6kuBojpPTGFKvej080r4AEmRu2g5UEeMRcj1aq+mZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqrCAmvXboXqXnYMz8dQVekRWu9evDgtqJeIIPo0MoQ=;
 b=uxD9gOFG9NxQOiKRul/FwYnaEUlefSI09IsasHBwsqjNOhXXaToMBtVS+MS1ub0FDmsb4Nf0/CgzIk3ttPW2Xryn9IFni5iDV+dMFSMQcCIcDqYAVDOlgiEtNys6+izO2hMQZNBGOs8S5DgjlHVPbpK3OXPuMnL6kHIOy7Rtjk+x/QKvuPR1PcHERdiXidQnJbZceFz7dQqnGbIcsHTN+cR4qpZ4uMllxCU2bVRO3PFej0jEsJHIFsriMxNrHCvTtCgbIndgf3Rj5/OxV9y0BEa3Iq4OZPzBjydaSzJV9ZQASGYfArmHA3zEa8DgFlVdLTar5MZDy9gdNQltCcgHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqrCAmvXboXqXnYMz8dQVekRWu9evDgtqJeIIPo0MoQ=;
 b=Lj9JM41z1Mmlgor0hJsvW+DJwb4G5wj6n6beIH3fEUXkTIhyeVOAYJlYIgI1nQgwSKNTd4WYV9CiY0k66c0zO+79YbceQdJox0Mf6RnGftWka5xEf0MizTGEDtUegHLJAdJaoBEwXOp1RbcNuZ25QIQ8CY9rSvkMQf7QokUb5WWwSeUstUEnvb9oGnaerhf7R2TeQdaQ4dk3y6YiKYViI3WyW22wpxnc96v6vscv+d+aO7ZnButrmBhEahR0aPYj5xVmiYmhV4ap9IjLZSKW4dmzYTQCA4MrBgfS2MFHw/1oBjhYi5whZ4wPQN0RZXmbMb47wqoEdKtljtTYBybCsw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI4PR06MB8777.apcprd06.prod.outlook.com (2603:1096:4:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:46 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 02/14] hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask
Thread-Topic: [PATCH v1 02/14] hw/ssi/aspeed_smc: Fix AST2700 DMA flash
 address mask
Thread-Index: AQHdXGn1167OqQlZnEiiSGkUXs6Avg==
Date: Thu, 15 Oct 2026 05:56:45 +0000
Message-ID: <20261015055642.106204-3-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI4PR06MB8777:EE_
x-ms-office365-filtering-correlation-id: e44dfadf-21da-4142-8f85-08df2a811860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|56012099006|261009223027099003|921020|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: X+rpT9bkZmkSolcwh3COxxYXljy5FuFVb2RfGgKcsWSGfyAzP0Xaomp9vBW3GiujuH48SG7uRIZ5Y4kPShYVPfgBHGxhogYpeJUxrcML/bT9f4nYENtSYeLkOoMK07mw7VQI9muYpJBKpn26Pej2muQYHN0gLdvpjdeUruiNKiP6NPbX6Or399WLT/ewtr4zGbfXcUmu+CtmJbrxKWXTX4o48fCD6C+7Ol5KTf3le+9UFc1yoPJXnIKKVJshUxDe/Mtw6sz0o6z+1YhukCD4Mwe410qNDtHeoC73per4588FO+c2u3c9S5bu4cHYpPKubkR1lDsIsBcIuZXzRIOM7LZOua1oqTObqmKe4014X5nMc1KCI4jknYUcovgmeQZj2Wgeb0cQ+AoAGtQTJf2r9Skb364hypgzFAFUDvWn4q1dZHFUNMc9dRlI9L8UykapXiBrDCjrPXM/ead/x5deuqvFALNovjiwQAICBgMTiyxqzM1ejoYHC4EvapNzINluxTq3IXVDTRuqsXc5eGVptfxreU+22EGNDwQKiRoHiNpIbWa1pZ3UmeVVBJOYVxEa3tRvFslKf+csOzrrB76UB3Ps6UlN/deboYIWAUW56Bcey/OZyw0Ul61crpkYhSSfc5oGuAe6ptGjoPvJPUyU6oEHoVVjBmJYtAn3qCee/1Kyla8EBWyP3y7GGQjc/tQyCQ6ylXRDrTumZGeinv3aS122weoRyggIc4/bOk/duY3wqBkiJFK5qv6j493X/x7x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(261009223027099003)(921020)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lxyAmP8MCAOeZwUs6DLmgTlikg449kAuL9gCUQSCBtXRPtrVExvB8vxGWC?=
 =?iso-8859-1?Q?e403HC2xsy3KYI5ZjW/+OfEs0gk0fZMK/1MPWHWdlHm7Kt7C2W9nXPR37l?=
 =?iso-8859-1?Q?qIS1JYdAFxFnW1kJUEacHsvCkFIsfVDomvQVXHKBcL940+QVfqqpZNMDCp?=
 =?iso-8859-1?Q?NMmOReSTFf8KVJK3BvfoFhC2nboJdSjYW/b9dtFAboSPc60tC8Ky8sUCeN?=
 =?iso-8859-1?Q?2oersvckKCd3lI0hhsIZdlI4oY+4EFy412egdjdHp56p7dOk24moZKWkgt?=
 =?iso-8859-1?Q?r9dM07TCHE3mJC2bnXAEWm2k2TBNcp1xv5lBIiWVoxP4/z5iLJQ7scrUf8?=
 =?iso-8859-1?Q?KB+k2fs0W2SN4SQQmZpFoXvidZWr/pqvW6q6UZ/h5QWp/oXeOJ2SUP4hjN?=
 =?iso-8859-1?Q?TvqUolcRiSU2hGAvpC0OuNoLCh1o/efwt37wY8cIsJteprA9pjGrSfzJtN?=
 =?iso-8859-1?Q?2AmXJaJYqNkhhF45hs2U7LlnMJc0xgP+B8nCfwunfPuzIg/zo8a5OsM9ea?=
 =?iso-8859-1?Q?vAGsuChtDUKJO/o1C09j0lxCvUhdn9ZSAK6xxMidFGg3kTHMvz5iIui9Lk?=
 =?iso-8859-1?Q?eqJWFodLQ3k+YjHtasVua5mCzqCTIsF3a4+OXZwQqyyEeTYg/GxB0w6jdP?=
 =?iso-8859-1?Q?trFzHIlFJ6DCAOj7ByAVSOkZG4LoU5RNXCNl7cKMrH6K+PMpbhGugQ61zL?=
 =?iso-8859-1?Q?W65FtstYQVtJL0jj73CXjYQCugOye1evLrJinrJMiR07NHXIRvwbiisjBI?=
 =?iso-8859-1?Q?OVwKkYucZsiMeeBWvis5jH4v/jSBTGnuaBIoWL75cTaT0s6yQzlxlCMQbm?=
 =?iso-8859-1?Q?mM/SYchnIZG2G8yYwjFmM0YWsTmXLn3lEhFTHbu62j+LCQMZ7T81rDFfKv?=
 =?iso-8859-1?Q?mskQmD32LiSP8h24eylA1oSujYtRdWPeFCquF2kr+V6rXDgVQUJu+Yxubb?=
 =?iso-8859-1?Q?UIsCOXzHH2QEOQEHg8uFpM70D9BXIzGJtHu1BOSq0aIfQFjzkHZK7o4KdQ?=
 =?iso-8859-1?Q?MZQG/9TkF/dSq2hxtRxaSE1aZ7U7QdQH2CZc5i7MxzItDdupzhX/dp6WTM?=
 =?iso-8859-1?Q?1AbLgqZHd3kczJO34h8vLUdYeiA4OHwmmT5K8MTuVpFqeFU1yAevZH/g72?=
 =?iso-8859-1?Q?hFv50LPCoMYl4HzeOuSrKw3eNWGbjw2ctuSqBwVpvRflRvIiybD0bYn8yq?=
 =?iso-8859-1?Q?fLwvDkkEadGuHflDfW5pe6uJaLJslIZCXS+6hC69fkvpvx6ADjGwLHWzZb?=
 =?iso-8859-1?Q?F3CUdIFjbuIF04Vrwtd3rqYHqdHx7HnPKWgki406h6PWGHmzhZFqGOOSKZ?=
 =?iso-8859-1?Q?rBH8ua8gJei62wwDCiayGfn13II0gMorm793QUUHV0qkkq7J8pdsOs5uaH?=
 =?iso-8859-1?Q?staFyq/L9e8rBTMEmy+0S+jKrJ2TNa6nnuM2ch4IiGvycDISvjXEuSxhQH?=
 =?iso-8859-1?Q?VvKTt4+cJuLyPSd3/8pdIZDxHHG33FNHuqGQuZWdKJiLSrKqV9kWJgNesM?=
 =?iso-8859-1?Q?wOzCHUc+y3RRlG3PuzdqfebLEmaUqaAidaLorwtQTv0ytap8pTsRvOk+xu?=
 =?iso-8859-1?Q?1sF98Gz/Zso96axsc/4C3kfiqeM+XexOSzZ0PL382WtwnbICRXzVOAJhMY?=
 =?iso-8859-1?Q?nNZ7cfdIRyoO+rIMyWCQ7zJzfbB2a+gYbDCkg9qqLYywr4kWrbLpGcyBzu?=
 =?iso-8859-1?Q?uXnfPVR0dd+I/hYAtvRbd0eEB2gklMmdk1Ep3PcPFAGddXVSSeLZwn2TQj?=
 =?iso-8859-1?Q?bS4qaoqQxSCq7mAvDUFH+sM4h9Q2NQedgyav4oHSxL4/HcIbsc8oRMzkHx?=
 =?iso-8859-1?Q?7uL9Q+qf4A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kU3TS6JCT9o+SdrH574wejgX6HsaWEkxHT0N/qRL37sm8zlvl69GI28gixRYnTuGroY31D0AZxqUFQT+x9yaQruTj56qnmZHsJltAFnlwzZ32p5gAAm9bwZgGUKE0mm7AHRlyetJB3M9Ivvf6I+SA/55b16K4T1uiBcPMz9lUm3zQHhePfS7egqkiYU+1+/kK7JChElvEbPUm02PVJsXaYgjlRxfZvindQJw/qxX06Dc85GZw6bBSw22+pAc11ztLkBM0RCVXW5ZsLkmdqv6FoeW6cOQ4kAP7znd7Zri6mREbf6WwtsZdp8fSkMFt0vfPbCn9pPKUyBUjetxwpsSKw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44dfadf-21da-4142-8f85-08df2a811860
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:45.6845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pzmWwvfjoBE4js9lUbNg3vyQI4trLoE0FfZLiZv6sxJl/Qww0HWBiFw7Fwzm+6JNEBhwTYk4nyh3FROgEGHMk6e1qxsCRj1IF6OXd5cvJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8777
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The DMA flash address register (SPI084) holds the offset of the=0A=
flash access within the controller's flash window. The AST2700 FMC,=0A=
SPI0 and SPI1 controllers use a dma_flash_mask of 0x2FFFFFFC, which=0A=
clears bit 28, and SPI2 uses 0x0FFFFFFC, which limits DMA to the=0A=
first 256MB of the window.=0A=
=0A=
With the default segment layout, FMC CS2 is mapped at offset=0A=
0x10000000. A DMA read from that offset is masked to 0x0 and returns=0A=
data from CS0 instead of CS2.=0A=
=0A=
The Linux driver programs SPI084 with the window offset masked by=0A=
0x7fffffff, so bit 28 is a valid address bit.=0A=
=0A=
Set dma_flash_mask to 0x3FFFFFFC for all AST2700 controllers to cover=0A=
the full 1GB flash window.=0A=
=0A=
Fixes: bdb3748dba30 ("aspeed/smc: Add AST2700 support")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index 10ea9e5aa0..c0c3666dbc 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -1952,7 +1952,7 @@ static void aspeed_2700_fmc_class_init(ObjectClass *k=
lass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
@@ -1989,7 +1989,7 @@ static void aspeed_2700_spi0_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
@@ -2025,7 +2025,7 @@ static void aspeed_2700_spi1_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
@@ -2061,7 +2061,7 @@ static void aspeed_2700_spi2_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
                              ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
-    asc->dma_flash_mask    =3D 0x0FFFFFFC;=0A=
+    asc->dma_flash_mask    =3D 0x3FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
     asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
-- =0A=
2.53.0=0A=

