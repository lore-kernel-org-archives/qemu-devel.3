Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4649C624C6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEm-0003ly-7D; Tue, 01 Sep 2026 04:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEe-0003jd-5V; Tue, 01 Sep 2026 04:52:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEa-0007Il-3a; Tue, 01 Sep 2026 04:52:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEsZJ9Im/7b3YtfLRR07n2FGpfJKW+eOOxbts5MyI1lHo+OeVw8XkNA9lbZMyoog65EHRp3L7R9PA1yNvPsFisWDoxi4luXxUkfs/JMb+KFrDgP7xmV/aEP7WEAGTrs4U2IToEYOc5j+Sy14hNFis7ih0B5PpA27cEbd850lYSdsFXiiHXsvtox7GWwAO0neUgVrw1E3e6WuL4djWVi+QgW7XHwrWoaHR1jfoaGn4bdPvzGV6FVVSiRg3z9Nqe/PRifjJanORZKw+EH4E833f/MICbaaM5TRabXTUcoe5MWch3xxWPrLdw8vVN0W4b1iL8NkFqS33ez1sFWBo/1wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4154nxi/KfUbz1EvCQl0fJcAJxZkDDVDtmn5pu0zOtg=;
 b=cgmIWVdovlAqbVZlQbRCi+yUVpmZ9fdcmFr0HLUyg8dR0okdtT4VqaVh2UYmrVW9z2vw/dMcZkt57TPQrV8UswaaHDLOVc41URjkczw7Mtpe6ybkIf5CuZTKjhJ/DmdY66+lSnri8YAen4DBgYMAqWf/TPTFzgA6QR0Rch5b7SSqXSe2Fh/XVMgnJ5LnJgZgkKGw6F28jMnNDsJrJ8ZRLneS7znUrfDp05iFS19A0N6rFMlqsVoW+Er6AHBVnHRfHaJo2fy2eP4Xa9M1RaPuEhYZSlzdvmJYreu5DE+tRhOVBBDB+BJsAkcT2KJgncovuaxJPmCx9KA3bRFeq3vF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4154nxi/KfUbz1EvCQl0fJcAJxZkDDVDtmn5pu0zOtg=;
 b=nFbyYOLGgJEbEZCVBs53CRB4zhYe7PvSPCEJq72nNa7PW3QcUVmSJ7R1V6PookLjldbw3UBnC0eFaSrLqt4XnYO3rwpRodkTgpaaO27vaakHJNRxfww+5xqfXZZ+B3y+tbP74K4+KRCWj+7yJGUx2bpyDGET1Gp6x0w2PmXP5ZmXSlZ+Sad7J++BVkgqX9eLtH73T3siPKgKc644tz7XQilL6I5ksnhywqCYF0/fnnHt7R+d7VdigocabLmSvo0wt+XkDpEZr1DGFeW9JvlkcgweS2kNStugVeAPjU4nRcgrNT2K9gOUMkUI1dwJaqIiUG3a2rrkucqchJWH6NFE9A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:52:39 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 0/9] Add ECDSA akcipher support and the ASPEED SBC ECDSA
 engine for AST10x0
Thread-Topic: [PATCH v4 0/9] Add ECDSA akcipher support and the ASPEED SBC
 ECDSA engine for AST10x0
Thread-Index: AQHdOe89I/tvP71UeU2ol9fzCYagmg==
Date: Tue, 1 Sep 2026 08:52:38 +0000
Message-ID: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6871:EE_
x-ms-office365-filtering-correlation-id: f13f76ca-86b2-4d1b-dd83-08df08066075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|56012099006|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: B41rGKtTPgRzb4O+OwsxocW7Qz7RxOnRETMMiTI0qyZFir2v05gezjFFi9R3FDSn4ug4LiGC8BMm/CzRL28Nwzpe6XdORpsmKK8scV+Z4OOB0npxxz+yhUGKaexZBqYufm2hg23Wya+tZcJ6iIgqu2HnOSq7HENietKmyJEvyuHEcfVfuJhyLsUAaUrAK409/uaTASMgxSrQY++vIoULWWCUxZYxL4AxBgjMSZdENSPaYgaR6laHFO1yeSLU0W8hbrCxDJLkDwog+y+Yv1HiITe5HQmyXTi49/3nZ27oltbLDNZq0lXTgmA3hvl4x4wGedqk3zDlXr3MW+HQnoLCdW1mxaYYEGbuof2jWWWrll9GX3ajxySfgSN4W9hJN5CW+wT7QXiq04syiVJiWmeSgG1psKgoQzIhBO5Hs6tYXEvQ2OodNB+dkkVpTD48/Yf9LMH6gj2xi+KH60Ulvd3EFYY2RHUgOCwmzC155u7j/ToXc1uvGpE0c9fDBcpAjTDqCId/DUR2zwqdL8B5bOYgAxC5y33kTtPzH+u6LX1nX243sfE6H8sxVC0RhuFiuetgWIa1ubx0ZQ9vxkzggZWwH1itla4KNO9ZMHP2rsf3CMVOmAf/A+Lr4AM958vr2UMfoJhgw/xUY+qOLTg4aT190PSDdxEbE8yqWY/J8/qQ4mkrHs+F4Bqx5OCs5Kmr6EDsw1IruS/IO70RiW/p3gh2Z79YrU05szpm5GCiFbfm4G8wgyB9vQ+82FfQJCt7ifqY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(56012099006)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s9Syy95dW3aOwuKNXFKIoHgC3wwKvXoFX0f91tjt4Nh5X482DXaxJsEcqu?=
 =?iso-8859-1?Q?Ql+Auq5P1hEnYqDGlYn46S8Bke5BfWxU1YYz7lA9/zghIok9EhKTDHzhoI?=
 =?iso-8859-1?Q?WkTVnO1bCVy+SCOTbsD9OBPNe6hCZt5kFbCbOlJpNdS/LajWnvDJVNT/MI?=
 =?iso-8859-1?Q?jv8DePELIRatQFMGHSPldRboMz2aqdVY5guRXzoLKdGaUlaEuwSejeuNXc?=
 =?iso-8859-1?Q?jwdepNuWUCBHUwTyFndU2XGbxJu+ElDzpeS64aUPFJ4zjOeBAiP85u6mtD?=
 =?iso-8859-1?Q?F6yx9fAHm5UxmueVlk/kNLhEuXLrcb5coH4D70su0REjwoQ5DLisJb64DT?=
 =?iso-8859-1?Q?p897oOB8Zh7jokv92V4kd7Nv8iDZFpDMan1glzjxcwRUnwPw8Yo4ydYyK3?=
 =?iso-8859-1?Q?NTZWlvSjyXVaYK7t0p5IfFahm9xzk2SjLBGV32Lgjr7/vpvXyDNV0893qE?=
 =?iso-8859-1?Q?Y9dXiDYvFzpU8tIS0m8iVHYBKr+qSS5E0Elulo5V/yW9CXF6jZzHQrqkdN?=
 =?iso-8859-1?Q?RweR8j0nh7bGq/NvHCM95dx4Utjd7bcB6BknrhXGfryWbDYtuR7yTtMYE7?=
 =?iso-8859-1?Q?CwDvQoLcQgfD2qvS4UVwFou/YURYF6PhrP+H7bHklvygSigPweIue3D9al?=
 =?iso-8859-1?Q?2hjR7mUoB9S4IkS8tixrtRpG/qWjwyFQXRzu8t0dMP2GYIshtHsSqYHjhe?=
 =?iso-8859-1?Q?yRccI1hRuehkcM6Moep3lMsJwcRwyC5KyMi88Yz2Nf0Y2cmUYuaiebX5Cu?=
 =?iso-8859-1?Q?tAyyyWd5np5K+AwYJxZ3CgxihEImJuoVhTqHlfey33qtdCs/x/i+VcQABI?=
 =?iso-8859-1?Q?d15UPBQO8g5BTH+KQlkB7KUUjL18rLm+k993k+kQkiSoeGqNKcuarGwJRK?=
 =?iso-8859-1?Q?3uCP51WHqiZcxrASy41UqzqdncM2oD2i7VWBNjLyagkQUx9aevvkwLIFMU?=
 =?iso-8859-1?Q?sMdXNy3wKHbfMo9T25dL+NxW+cokQErsilP7ZjptCv2hqPyd4u4btIOVJs?=
 =?iso-8859-1?Q?1JI3ZeVETIKkso4aCAPi7g1DMuxv72v+YaRQ5+2F1VH+qmSw2ll8G+jKA5?=
 =?iso-8859-1?Q?V7IfKADFFhQwO3QBNaPbd6b/1BaajCJ4UQXn3LGIGANypwmDE8VttT4tHt?=
 =?iso-8859-1?Q?/Vw299zbp2bhwkRkXNeKoFe09TgHSpPb63iy+BAOXsLtcX0jdAfhhPODDx?=
 =?iso-8859-1?Q?JrPW5HitRxuYKwZHHwQLsSZCXRqaJVnYGIN47MO8dF5KEENFZlVHl1kqSp?=
 =?iso-8859-1?Q?AeFd1Pc31Or00VoKP9wIO4PcanN+G5kNt8zmOC+V9nXpEVTR/20MepkR39?=
 =?iso-8859-1?Q?wzvbKnZkg4//2D0SEuzHLv0K+5p/Lq+t46h68T3zmbYZ0EACKOmJV2UJMf?=
 =?iso-8859-1?Q?cX+d8cCJ+ApBmUvnsP03lee+iJuZZUUv3LxAJo8tRo4cSr7gcAZWRBoeBl?=
 =?iso-8859-1?Q?+pzZdQ6F21I7rRzuTUr8f6eh0bAwctTIQIFplIH1mnA2TqXcw5ihm23ucM?=
 =?iso-8859-1?Q?XN0dOVrOsCbebcHosVcyJ1OrC5KJPdqZrgwhfjKtgtRmPFGYHDFZ3hg6if?=
 =?iso-8859-1?Q?azLF+Wzb4cVZfdP7sSbxOtpoJREGCo+Y7QCR6PuzXzytlRqE64NZTY8qLN?=
 =?iso-8859-1?Q?DTBdwAmxmNA/1yuXmqfuL0aZltMReh2tQ/uZfrJxCblJrVLYjZk9Yjasej?=
 =?iso-8859-1?Q?GKd+N/YC25zSnUw1mMT7yVymY+aYbVyzlNQrctG5jOl5v+HKEzXIRYzwr7?=
 =?iso-8859-1?Q?PJhivn7162Zz0rie4dWfTaBX9fccIGLLxSv8YHaSpGaozMgbIXz5PHAOk8?=
 =?iso-8859-1?Q?nOgXMcUYIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xS5/yN+L1P2iemkg6sMm2WKBkTDEsniu0WUQQNu4I42KRr9i9lZo2+y/n8bhLJ0VqwfDpngnRu2YxCjffKkKIMk+jM6L/lCbDRfYZAhWOqo/hLCwDHPny8MVE3amuCwlu4kT2LnxgH13z7rGkzUYf4t7D08yOOsy5sVm90H4UU4emlxIxrEmafn0k0cNmA6KHoNS4rofO/LbeWD4sVzdRNu9yognwkesVN2uPQyB+3cVO1xxx7pilpyrqjyS1h8ulbCHKJ6e4yAZUmctO/KmFA39tktRDRt897ElQkEyaoudXQSLjEXWeYOiYpD+diRtrMrSe7/H9qz2T/PLyd/kkA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13f76ca-86b2-4d1b-dd83-08df08066075
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:39.0332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UkiJ1r0aZg/Tzm7uCCv0927it8tXflVYwRMb4YEVlsi5ktFxHGlQ8OLmGgo6MDIXwME2zuf853Q9XwZJqwHDRtG60p9iIcbjy9HqWJhaFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6871
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This series depends on:=0A=
=0A=
 1. [v4,0/4] Add ASPEED ACRY RSA model for the AST2600=0A=
    https://patchwork.kernel.org/project/qemu-devel/cover/20260901081531.89=
8176-1-jamin_lin@aspeedtech.com/=0A=
=0A=
This series adds ECDSA to the QEMU crypto akcipher framework and models the=
=0A=
ASPEED AST10x0 secure boot controller (SBC) ECDSA engine on top of it.=0A=
=0A=
The crypto side adds ECDSA sign/verify for prime256v1 (NIST P-256) and=0A=
secp384r1 (NIST P-384) in both the gcrypt and nettle backends, using the ra=
w=0A=
big-endian form (public key Qx || Qy, private key scalar d, signature r || =
s)=0A=
with a pre-computed digest as input.=0A=
=0A=
Both the AST2600 and the AST1030/AST1060 have a Secure Boot Controller (SBC=
)=0A=
that supports RSA and ECDSA verification, but only the AST1030/AST1060 have=
 an=0A=
ECDSA verify engine, so this series models ECDSA only. RSA verification is =
used=0A=
solely to verify the AST2600 SPL in ROM CODE, which ASPEED does not release=
,=0A=
so it is very unlikely to be used by end users.=0A=
=0A=
v1:=0A=
 1. Add ECDSA akcipher support with gcrypt backend=0A=
 2. Add ECDSA akcipher support with nettle backend=0A=
 3. Add ECDSA sign/verify unit tests=0A=
 4. Support the ECDSA verify command for AST10x0=0A=
 5. Add ASPEED SBC ECDSA engine qtest=0A=
=0A=
v2:=0A=
 1. Wrap the SEC SRAM in a container mapped at offset 0 so the device=0A=
    addresses it by relative offset (drop the "sram-base" property)=0A=
 2. Add a patch removing the obsolete unimplemented SBC mapping=0A=
 3. Add Qtest to ast1060-evb machine.=0A=
 4. Rename R_ECDSA_CMD to R_SEC_TRIGGER, since the register=0A=
    triggers both the RSA and ECDSA engines.=0A=
=0A=
v3:=0A=
 1. fix typo=0A=
 2. Replace g_printerr with g_test_skip=0A=
=0A=
v4:=0A=
  1. Reorder the patches to fix a QEMU startup failure at an intermediate c=
ommit.=0A=
  2. Add public key type validation for ECDSA verification.=0A=
  3. Add private key type validation for ECDSA signing.=0A=
  4. Remove sbc_unimplemented from AspeedSoCState=0A=
  5. Update the commit messages.=0A=
=0A=
Jamin Lin (9):=0A=
  qapi/crypto: Add ECDSA algorithm and curve id=0A=
  crypto/akcipher: Support ECDSA sign/verify with gcrypt=0A=
  crypto/akcipher: Support ECDSA sign/verify with nettle=0A=
  tests/crypto: Add ECDSA sign/verify tests=0A=
  hw/arm/aspeed_ast10x0: Remove obsolete unimplemented SBC mapping=0A=
  hw/misc/aspeed_sbc: Increase register space to 0x1000=0A=
  hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model=0A=
  hw/misc/aspeed_sbc: Support the ECDSA verify command=0A=
  tests/qtest: Add ASPEED SBC ECDSA engine test=0A=
=0A=
 qapi/crypto.json                  |  33 ++-=0A=
 include/hw/arm/aspeed_soc.h       |   1 -=0A=
 include/hw/misc/aspeed_sbc.h      |   6 +-=0A=
 hw/arm/aspeed_ast10x0.c           |  14 +-=0A=
 hw/misc/aspeed_sbc.c              | 158 +++++++++++++-=0A=
 tests/qtest/aspeed-sbc-test.c     | 194 +++++++++++++++++=0A=
 tests/unit/test-crypto-akcipher.c | 236 +++++++++++++++++++++=0A=
 crypto/akcipher-gcrypt.c.inc      | 340 +++++++++++++++++++++++++++++-=0A=
 crypto/akcipher-nettle.c.inc      | 272 ++++++++++++++++++++++++=0A=
 hw/misc/trace-events              |   2 +=0A=
 tests/qtest/meson.build           |   2 +=0A=
 11 files changed, 1242 insertions(+), 16 deletions(-)=0A=
 create mode 100644 tests/qtest/aspeed-sbc-test.c=0A=
=0A=
-- =0A=
2.53.0=0A=

