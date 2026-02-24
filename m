Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E98EFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLb-0002QP-HP; Tue, 24 Feb 2026 01:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLU-0002Jg-9s; Tue, 24 Feb 2026 01:56:36 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLR-0005Mp-RH; Tue, 24 Feb 2026 01:56:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBizCRu6NAFtoHggWy8BLHFzDjyLBhV2yiCb8s2WjI0DnQdawIYrVR7YC66KFbwB/dBh4RqutborqWcrhE4odghfocZkhTpw/cqaY8LbMGy65msQUld64AeLiha15vGEj5A7BiHqYrjhObls4EUFLSpB8N4rKDvVnbdbRVoMDwcRGgucdBUDXnTtt9kQsapRe7+G/T4J8F9OA4XO7kg65A2AvoCMan7BSCqB53GGuTdPaBoMyz/mvnlilP4eXMLlk8o3VfnvllihA4n3KnHb3z79AS0tyDMkoprwT0ykuhtgQsQc6zh0Jp96S32zhj6xBYJJ9GaLdsn7+UGIi4H9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0elj0zGmy7KVIEMuVmlIfzrJ5U69tRoaaMBjkQR+hIo=;
 b=u+p3pB/SzvWCgTCVr2N1rlovan29r9uFhjZs+WReANZjLS/FDagAaxdbp+m/PFzMNvA4j2q31fGOIKZ1K+UI69FMHWHv3q9JFhzFPUiZsJKuvm1clg0yFfhHXxQjhkmQuOTc6OEilpvQGi1Cs0LaQnqbiMpye/db6xvyayWs+3YVbhmNVHygQEAWBfuil406W/2CO3+cU8V0cd6Xb1Sfhk2+M+70cDKqvaLRrOYSRPJ18zNQOedAWY9EMfSN1j4ziKnj6aJ4IcSfuXWfpgQsH6fTuwAoD5Edc5KirnJN3rDHFJf60gXW6N2r00G3b3EonGM+LbIs5RzyINARxmDB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0elj0zGmy7KVIEMuVmlIfzrJ5U69tRoaaMBjkQR+hIo=;
 b=PnnoZhdqbzIAinrTiGNrLCN08jDaak8RM03i64okHNanxzwR4Uddjp5iBD8a/RZkW80kKnihDe7GzjeBsV3mguOav9EVG77MnuO7bofw3AwlthyZ1e4NN1HZi0JBflkMV+cCif4iHF48oUq/fo8XJK9vN8FoKGmyB0GtK9wPRwx7hA3XskU0T1a3YbYCy7kP00DQqTc1BCwpcX0lXBpK/jaFlcjMNvZ2n2fbKQzn4jwV5QeRcDscNAjwh2EO/a3gJYU/8U+B8rOY7d9cvfDR226fVamIr59ySRDoZe9xNVteNdh9+j2WeNdVGPQUB3lPgnFcow/JYeGs8SKnu8zLcQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:12 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 11/15] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v3 11/15] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Index: AQHcpVqp/BAOFXeFikaJEeCH6JZa6g==
Date: Tue, 24 Feb 2026 06:56:12 +0000
Message-ID: <20260224065556.3847942-12-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 4e844260-1e46-4c61-1cf3-08de7371cc0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JuqhrnJgHDRHA2Dn5egb+GvXWhN43wNS3lFVI/ST27Yrsxko7s1Sx//M3P?=
 =?iso-8859-1?Q?qttl1sIIpOu1v6WNWvWrfDKeIDeHpDUBPw7uIp14uVXGesEc07B3wua267?=
 =?iso-8859-1?Q?qm1zJkm05h78G7Wh4u5d13OqjTw42j+JG7lUPhLewVtlHyhIr14tJIsVmA?=
 =?iso-8859-1?Q?HuyS1zMrN/pztPVB6vKPztP1qYeT6HZjad3UId/XCQS6Mx45V828dMO1Si?=
 =?iso-8859-1?Q?9hGMcnYsuekylmKCkdk1xy+MSVA89ozc6fd4Qk9dUz8KjGDEvOB5eaq/vH?=
 =?iso-8859-1?Q?FNzyCiJs5xnxb91KRicNZhz68W2JTiz+Vq2OWWE+UXmtkT0qgtRuZ89IGF?=
 =?iso-8859-1?Q?VOjfdkUrP+taihsOLgeFjbFACMxDGhe2U0yP1+1gXca5AUdpkpwKtl3Y27?=
 =?iso-8859-1?Q?JUg5unqM3E01Igq/RZdAl4J965xFtDmXXes8vtvOsQLTXblGxcwWrdbg2T?=
 =?iso-8859-1?Q?yjYLt0F16HsnhomEA38Xj1aiJ4/ANFAdUwFrWsR8LG+VD30Yuse/M2jMHY?=
 =?iso-8859-1?Q?jpTNQV0Jwg/8F4OoXKUuLT0BS5z/aZqEEyCaX8unCVH6XB1/at7/M9vXxK?=
 =?iso-8859-1?Q?w7tX3MqTXcbBsk5wWufV1dobLiSJsuImp4d/AbBEhwkoaokPvh3wUduFmU?=
 =?iso-8859-1?Q?sFAUvh1rOYsD1pnBwN3SYAfqoUdnogwpsATo1O7Gd82+/EnrYjDrBRa7ui?=
 =?iso-8859-1?Q?2dtU0Zsuidn/D13UVrpiQiFmwbeNpzGKPwuojbiyykKA6LpAG+9Xi3N4Wn?=
 =?iso-8859-1?Q?z2pbJWyclIKehmdvS6hSucizYaM3pTaa775GVu71M0AMTy7Cj3Mde9ma3W?=
 =?iso-8859-1?Q?K2EZDoeiDWwFD1E9alnCF4xUnZRX9/tw8OVq/LUUB1aL0uiwtfFH/0gIvu?=
 =?iso-8859-1?Q?hrrVKsO5vTfUUpL3Lg9HoAq50bUNFEUL1OkLw0KiqBQQhY1qnShv7zEF9P?=
 =?iso-8859-1?Q?6HBCsAsHtF4OTLgXiq1qwVkabJt0S6LhprdfuaZe0/JmPKYAq7VHmF7gxW?=
 =?iso-8859-1?Q?Jf0q356DtVgSlEbPuCoKKQNtfHL5yUTwXPQIBZN4caNh8jonMm2hXnhlA2?=
 =?iso-8859-1?Q?FibOqNNgQg2IexlQxo69QqgFyKGQuvayDul/kfVQFrfOJPUjDTDi8pUik1?=
 =?iso-8859-1?Q?Jw8jt2nm5AP+pKWnJeWtYTbpOkOVs+NzMMQ/d3TXLmEpI7baaBUlafpRF/?=
 =?iso-8859-1?Q?fNmZKtv/k4Sf1cHVfr9J6/HwPLENS4sX0uZugXJqGrhKS3Tt+sS67VidVc?=
 =?iso-8859-1?Q?EzjChYLTUwn/Yjh4Vyv1VPP0p3aAVKhJGA2Jfv7/I8LgoZvKBu8wsD44Dq?=
 =?iso-8859-1?Q?tAp9ZSm4Gzr+LJNqSCBdACSfp9fwHFriO/bXOihrvLz8sW/XHCUweT2JYG?=
 =?iso-8859-1?Q?Gq9ln5P7sXelQbszz83ArALiKVqp22Su7JwvwzVfmSwJWKT88QfAJEdYeg?=
 =?iso-8859-1?Q?KHkghOq/zrDiaa8xqcbWBpxut5W5LCAdpmLv/wxUxLCltUO5oC77d+C/bS?=
 =?iso-8859-1?Q?icETHnFs9+wSuOWNV+K8X+5PsoG1qSqRk1h6TQqK0ghpvKbjlKnQxbTCbf?=
 =?iso-8859-1?Q?LoB9JLkiZd0t9z5urBE0JGnHrXQRM0Wb0i0AGdNtooRKL3cpTYUjCV5P4Q?=
 =?iso-8859-1?Q?nwxdvBWpo51oi2FGZCkTCeYY2tKJ8EkFXGR/4EgRJ5HCxZaaSOD1p3pkv6?=
 =?iso-8859-1?Q?hf1AxwsMHaWDmNYmnh3PkgCxuIlbh29Y3/xBru/7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0vDSGfFGvZGudvKPldyBRK5rp7/lzmugO/5N04mPTVdsrY/PWf0OtoILdi?=
 =?iso-8859-1?Q?25VtlZ6UiJtQ4Ioi9sxif/IrfnxX/Ne9WzCRVpqU4KSLndn+gfF0mivSBz?=
 =?iso-8859-1?Q?UaiAwrbHW6ed2HE6nyxsKiAJjDRQFGlqc6z+Lm5vomfCH9N/h7zPM9zqHj?=
 =?iso-8859-1?Q?8MKz41u6NtFPd31gPikbatfDRUesk5X843OS3bfcdbLekGnO2MaiELccbC?=
 =?iso-8859-1?Q?ac7niViBaXf0m+XgGc6TBHc7OH6LiXSVOKkW6RP56I27jk8XNne9mLdA9X?=
 =?iso-8859-1?Q?4u51foBUETuEazUG6WyXAwxiceO4euQi/K/lgH1vqjwDjUiJB/vVUqf04I?=
 =?iso-8859-1?Q?a0e6F1HT36iAM+9Qm7w8Dh3Ugxev3bpOATXVqxJqs9SV3S6yIf/TeWeU15?=
 =?iso-8859-1?Q?riXM3i5Lcn4YeqisDqfDQiXC7AsThZF+BBSwSnNa59e+PxDq5kqG0h8KoW?=
 =?iso-8859-1?Q?xTJmehh9GeaHzpYI7B/Gq3IzqKE2hpV7QPSy+Qe8abW4POAxrlpL51MeYc?=
 =?iso-8859-1?Q?3tSNM3x4nfHio85ocjT4zQrnLVBPqu1w4cbhaCOaEC9Pc4LjvLDJr60HKP?=
 =?iso-8859-1?Q?46izCmsxxbrauH8s6NG2nWvlS9p28gDMPP1VPSGl81Q+i+yBMQsTGqfGnL?=
 =?iso-8859-1?Q?K2v80Z12GMM75Mhmm51uXSxFZXleybAf1tFRyxn5fuvU2sMeGs81W9uQoB?=
 =?iso-8859-1?Q?eg39Fmzr1f1Ql30HfT7UERouL6IRy24TUguaV1CXOecqgyqxfFBedPgvLx?=
 =?iso-8859-1?Q?Znr6z5uwYhoknJX3IBdK0vTW+rcbyjCTkiZxSyhDUWjOSr2TnJdtCU+TjA?=
 =?iso-8859-1?Q?YjNR5ecBvzui7uSDMyIsnSk/dR5UPweg5xjxjvGB4vZGurZyQ+n3osBFSt?=
 =?iso-8859-1?Q?LEI9QsK0GeAHdvXsuXzXTc1TJWrPyY4hYBm3w8zFxM3W3PUgVZwXRNruyM?=
 =?iso-8859-1?Q?LaOQBGSFc3ghMkWf9oU/80bhKQi4Qi3t0mdhrwCbj5tiSW5LOya2GTg2FK?=
 =?iso-8859-1?Q?CDaOUeeDu3fbpgzecU0XXfTT/rpFjj10HPpK21UwGpawN2E+omNt2MOSH6?=
 =?iso-8859-1?Q?6QF52JbU3RZyZuaqEmulx89PnB5yTUN+HF213TQtJ1tlJfXzhQLYRBO0ri?=
 =?iso-8859-1?Q?LWWGSlbMvXfsMCowZxfrGN9UMUR1NPl5TLuWjfWIDjGsFxZztVu3zypRzm?=
 =?iso-8859-1?Q?Ze2t577P+8HNdPrqyPW+2vtcq5y6x9/TCVp7iAeTn5PwJdUSVKZYGaimQi?=
 =?iso-8859-1?Q?O51vHPaYxxcv/6+UPjOztBm1GbpndKBo2xwfdxPJDUwpL+C4Eiw9JlnjQd?=
 =?iso-8859-1?Q?lwvwDrkah+dAsgDWQXfZcJnoHk4kuYYTD0YywslpuUhdN2Qi6RamCr30Gz?=
 =?iso-8859-1?Q?5eYC1bi52CYgebGQLJqfAxi9t7HdR8qJfySaLj9NkusrNIcVoTwZzNnmMS?=
 =?iso-8859-1?Q?xYfm2KNfTdDcYF3HTfImI7xYOvkBZuQRwgjymCONZxYiLdqSsnM6p2cRIu?=
 =?iso-8859-1?Q?0qGfNPPOzXhWgOe637TdFC1kock6b8nvhVnRASZiw0KNV1cZkAx6xJTiCH?=
 =?iso-8859-1?Q?LqYokM5/BU2XoVafawmmW/KPGCJ7k5V/nesD1mmR9hezLOJhf4HZjfFhH2?=
 =?iso-8859-1?Q?w2hApeZALSBSCW/mtRwndklVmDR1xdBk+tGBtuYEVLfFriw6UJ4gTMmM2J?=
 =?iso-8859-1?Q?Hs1dA8t1H5lMhCbF2g92o77jxkRUO/gdHKeZJJnI1q2VJ0uPGcJhiXL8BJ?=
 =?iso-8859-1?Q?gh4ATI+rJN+qxPhN63ODfVzBc3erwe3sh3kZaBULhGlK39RbNOiq94eOuf?=
 =?iso-8859-1?Q?ACxL2L5O0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e844260-1e46-4c61-1cf3-08de7371cc0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:12.4917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFQCLISe5xwBJqEWaZ3id26TFxBsI6eJMEgZJHdCfP76qLD/jsKZjlHMV0lZS03KzW/TCWzOP+NCha3cl3cyl9rNPN57E+giceTSCrOcyjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

The AST2700 SSP/TSP firmware accesses OTP MMIO regions that=0A=
are not yet implemented in QEMU.=0A=
=0A=
This change adds unimplemented MMIO devices for the OTP and maps them to=0A=
their corresponding physical addresses in the SSP/TSP address space.=0A=
These stub devices allow QEMU to safely handle firmware=0A=
accesses and prevent spurious exceptions, while accurately reflecting=0A=
the hardware memory map.=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 1 +=0A=
 include/hw/arm/aspeed_soc.h         | 1 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 6 ++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 6 ++++++=0A=
 4 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 94b5cd257c..4a5a2a6151 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -51,6 +51,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
     UnimplementedDeviceState pric[2];=0A=
+    UnimplementedDeviceState otp;=0A=
     ARMv7MState armv7m;=0A=
 };=0A=
 =0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 5b208a979f..10c1d626ef 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -298,6 +298,7 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
     ASPEED_DEV_PRIC0,=0A=
     ASPEED_DEV_PRIC1,=0A=
+    ASPEED_DEV_OTP,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 8a748b42a4..d4e9cdab32 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -148,6 +149,8 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -287,6 +290,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 5037276f20..d335d01472 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -148,6 +149,8 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -284,6 +287,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

