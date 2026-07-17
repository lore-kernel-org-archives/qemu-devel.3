Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E514FC44519
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 01:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkXfZ-000618-Sh; Thu, 16 Jul 2026 21:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfW-00060O-NV; Thu, 16 Jul 2026 21:47:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfU-0001j6-3a; Thu, 16 Jul 2026 21:47:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlci7QIuBbWW9plD4FX6l+I0G4gwZouWy/skX51wqQu16kVNpqJ//pMZ5+OC16Q/5Pi8+ka3TDB1VTOZID6ACLnifwj+ckdPfnYPBYCO5jcR6JCmuIKIkvSlr51wZYqzhVezswBOkYc8/257zdl9mNovjrjeJCpHe1Gc/RDccWhJn+4+l1NzspunTe04bXhkFrFnYDwI9tnoAqtFqKPoZKVVco/9lDCJgw6pMQfj0O1k1pfAfOS3R0pkTUVXsMscf8DCr+W6/8bvsrLVPFPxnTjPQcWtpm5vMmpspLfgV1ezOv/1fvatAr2GNv53v9HASprX1lgBAzODikOmp2HISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1GxNpCyPw8aNHkgA5wePPKPAReKox+oupoLkZza93w=;
 b=oBpmE5PLBMzE9wGPe9aQkhjoC+2Y9rWrEa+UOPS0ETUEpQn1pZ+3wot4vejT8VIDVb+WSsAxE1K+9Gk6Wz7Zfw67/0cJK9lTy3gRHchkkTa1SZ+I6bVJgB1Rkm/qSZDFKAGzAA26QAZF55s7n0MeDDZSybKjSxZ8HUoKaDnxkh8OgrWHd8xFEhlGsOCKrTfcGAX4P6GI/KWfrR4C1TDxTL5cJHFO3dIkoarcoqp1SGdsAqCBHjpnJen7bu/+FOw8XEglF5BG5kqCllznQKgL4a5uFXfF55gBHGaWFOUtiX6FW3rBDXP67Ea5SkaOrwa9mITpR4VfLhCC1jRFnIOSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1GxNpCyPw8aNHkgA5wePPKPAReKox+oupoLkZza93w=;
 b=cEl2ZcvBY6lm4I9XumEB45ZvjX71ntUNWdWbF38b2omDQ+A8z0tblxo6PMWZuzkaVEIp0svHSG3FaJhd7QYP7XnMdqO9r1EcZ3nwxEgMw3OVnfqx6F+xPSbDsK4NM0TZT3smU2V+92wRulU0f4FDXl6Yagu/Koy25n0+PMg5XQ37Pe6VRTjX54wqYoekNAWIoIltFuciwSQW6A/dAD46xgcwvKYNDHc6N+P6dYVw2zMsyBPaYevK9wH0oPUkfRoiqHncsSKuSP7kgE4EYMFiOTTbvVrHc0RKMNy5MnIjKc9aWsEhg/2Kz+ko+qgFwXBd8aPM07cJMwVwlE6RLpOqtg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUYPR06MB9015.apcprd06.prod.outlook.com (2603:1096:d10:74::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 01:47:02 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 01:47:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/3] tests/qtest/aspeed: Add Data FIFO qtest coverage for
 AST2700 SMC
Thread-Topic: [PATCH v1 0/3] tests/qtest/aspeed: Add Data FIFO qtest coverage
 for AST2700 SMC
Thread-Index: AQHdFY4p4zH1qzsU5kaHZqwmbBZTIg==
Date: Fri, 17 Jul 2026 01:47:02 +0000
Message-ID: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUYPR06MB9015:EE_
x-ms-office365-filtering-correlation-id: c4ab9004-c6aa-4db4-0738-08dee3a54c49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|921020|38070700021|56012099006|18002099003;
x-microsoft-antispam-message-info: y+D4ulzFUbeb1TSGpswvEJuj9XmHU3768FTtZ9vW71PRxq/H6kLVsxnFBz6RwMFTID7Ezz4N32E+i1RVmQGABl48vgz42S0NMwr0PGCFQhv0+5eB4355/3IPYdpiuERt6HTokwZaJx3ZTKvg1p+YpjmVL5iPXBvh3w2DkZn9tZw9ey1xhyGBv8OsXJce5vSZz4+h7EgoXM3DuV02Riri1szPEmDO0kEAB+NjOClQTaL4cQcuhk8UlQVUj34B85TBAmJoP04SBccw+rNSbKRkJJ2dTASz5BZEgLeJeVUpYkPmW5zAjHALfC4x++6zUMZmImSXJDWWNZLJXnMZPxCXfJkfYdn08PjWAKwoiuTAGpuI7kjBJ1dUHlKiCcHfPzEBJIxxy7PN2ZaAo8aubISRKEoawcKdWByWh8Kv0gbEfjRgxb4aEEclKr//xVpLZRZSok97zn0sKbkeoypqUkpE7qHXiIfV4ur6Z160zcsUqYzcEe3cZSaFp3G7saBFBRSi3SkHoqz1hHpKQkp3MNB0ThDSFH55wZXzlozUlvdrQyWwSczJrFoYezGekTMFbgpIImjWdzp3WBsxI4lpyRrpOBnyLUonGgtPGHwY8gaEcR+I7H8Eozgn4UF1AG/JQeHUCEF6qYTuSViBAz/gDv4dXPvLVudCKbivBJ/Dvv3LCoA8byI/ZoASf2oqtexZEBS8NXYJy3mxMemktQG622CrijPtv+z3Gfg13LoweLXDoPo/DvgBcf9NPuyPOkxnAdWX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(921020)(38070700021)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8QnRoUk2Buglm0Ob2B681Xd/ZsSeaqaJU2b8CzdvblvlMsOSgWZvTkbACb?=
 =?iso-8859-1?Q?gMmXmB9lxL/pUOYMhpWGw7vNAxPPuP/ss3eBa2yDbo0iNqIPjvfM8UrSVt?=
 =?iso-8859-1?Q?n+UAvN3pHyleOiEBvRFElliLTOaDVq52IcK10SBW82obJQY/soHDDKRAQx?=
 =?iso-8859-1?Q?333tVQMHVZ3rz/rPRF/evhYV5fIW0EsTThn45v8WuWhfmiEUICMB5MN6St?=
 =?iso-8859-1?Q?qw0WPk7SFwf3M7xBiSzY8S14bi4j9pZLguhzvC/+mOmcenl6P4+d+wx8cI?=
 =?iso-8859-1?Q?C3Z0HudSnQR9YaEEBB34X5aFcUctfxevdzOyqoVCQ3HCQBamiNxQGdwA1G?=
 =?iso-8859-1?Q?95QRH7U3gPfZrZTAi90KJRsxwtbQZpMZGNpE87k+zaUyMuJTIatq3ExJII?=
 =?iso-8859-1?Q?jYdCQJ51yJSviiz31/WQQ9QTBYQ+nSJ07ozbqKkSJ4uak9gZ97/my1z7SH?=
 =?iso-8859-1?Q?0QhL9rc4ushiNw9spLx8bQfQ8S/xk+VEMHwn+sl0uH+RKJ0+TYRx6Dbjcf?=
 =?iso-8859-1?Q?HlaRYV3RPI+y97+tZ2E52jjBT5FHYt7qekAiC/ftGSyeYy7+grnkrrJKDl?=
 =?iso-8859-1?Q?PEJ815lyOrB6E+wmky2RTAa9iw41y49NwN27K9EFR/zHRHhqInK2hfoZkf?=
 =?iso-8859-1?Q?LOruHFP5XjUq57unoivc6KSnCfMInTrVSu0A/Z7x5CS/Xg7NszD+bpgOSM?=
 =?iso-8859-1?Q?/0kGVdfKcJxvqbHkkQmmb3qH0vpzf0qm2FQre4suJfILULFnUObaGn5M+x?=
 =?iso-8859-1?Q?87wN50s36/yLfqe33Fq8gmnMDlT4GjZbwwRLxo5sFaC84j9waVAfbSQcak?=
 =?iso-8859-1?Q?ms05kCZewSh4v2nqpB5rviyPDzBEBGKtB+C3llBTw9ttQnFojH7ZpXkInk?=
 =?iso-8859-1?Q?oUkPh8363BjWArEy32vSQhd4H1156137WDHIhZ4YvgsqFZmi5hQOJyBtyd?=
 =?iso-8859-1?Q?qFtrVmvVucSEf2kLEiy5lWnW/+GDt7mO1BdLI1/fntBj4qie6vHsnGC4/N?=
 =?iso-8859-1?Q?f+kbQ6WZOUfDGZibQJYqxa8MPxjnJcvysdi11GHrUfuIfUbyLFv5dgiXFa?=
 =?iso-8859-1?Q?HSY6qdnL/TWp7GCyuu/pLg3VwqxiezYD8mtPbeXah8tuaN5DlTMin6Ycwm?=
 =?iso-8859-1?Q?IlMlE8MN2PGils/TNPE3X8pHPJeQGcLtu6zoQgjVJIRqMcHiycm6ZnM7XZ?=
 =?iso-8859-1?Q?LOmPB7BikN67r9WS5G489Pil9jlgjkS9etQrvnGNMUGiePQCDzPqnVKhn2?=
 =?iso-8859-1?Q?ns/8Ij8UNiS/oF35+k8CfQAr29hPR3f7y2Lc/6dAMwJASdD6z3BbtxfbmJ?=
 =?iso-8859-1?Q?f+vEvyyTPlpiQjUU7/9lxsmjL9kIl06zKnS+5tv2M3ofK4OuU6VfdRXxch?=
 =?iso-8859-1?Q?WUaEEB0mAAA/mHn5eum8vM59NrJEt270DyCD3bN7TRbM45nGLY8NmPfkY8?=
 =?iso-8859-1?Q?ebaiZJHYLicP5XqUXLSyNOVU6/JSDvSWBnlrKKZTjsSX2gKoQgGzjJV39n?=
 =?iso-8859-1?Q?avgUqpX4fuJeDxCK1vuuL6yPKTxhQz8Yy1f/aDpj8XDcDvspBfCBYm7j28?=
 =?iso-8859-1?Q?7m5ubYps7RpaHyQfk07iCg4Jogxpn8X6TxyircLeDPGfT5R1SQqQCSnyDo?=
 =?iso-8859-1?Q?mD27P7CinFI2EmHzgmv9Un64x0l4fLJk/rDpuZocbAzRwaIoisrjBiznre?=
 =?iso-8859-1?Q?FBFLuQuxMZb1bKokvSgwSOBqUJL1PdkkbygylWYBpRg02fNV1lJAHbpTNM?=
 =?iso-8859-1?Q?R+92ZFtYsc9UhysW9i0OYPNTxP5vpdQtQJqBdHWD2GydHnQ7qG69UoZ1NA?=
 =?iso-8859-1?Q?Ae/rzYNbrg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K+2eqJmoVYf47qvD1A7/x6mp7xGNIR6PWaVUi+g7/dW/J5unxi8vmPB0TrktyntRchmPSUFit9ph78h7XMAzSVt+DVQNXrJhZqwAgxzVgvl5G59zghRXZL+0wte0twuFCHQsh0rwldI/cBW178EE2DoBwPyXLFITcBUVMmWxDMmNRdhFrI/2d/FyZpRLV/JG0Y90iHOcqZRsVHHs9K/q+juEpvC9Bk9OvybiM+GmiWivhs3TFleHDaueQDNW8K4XG7OpbQwVOGAj7BLwkMlg7ml5m2JnG8qVvg347aOxO+VicklJ9P4ojxLmJPrwK5rTjAkWPUGp8aCYXzsZeqDoVg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ab9004-c6aa-4db4-0738-08dee3a54c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 01:47:02.1595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /n0Fm+vr66bP/xfpB8rs0vqVwnpzx4v4/PZCPrTmhM6c+MoHQ/TrTr552E2nDAda54hr2viM8cUDDVnPiXKAp6LefH5RVJ1HHejznbRtz+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9015
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

This series depends on https://github.com/legoater/qemu.git at aspeed-next =
branch.=0A=
=0A=
v1=0A=
 1. Add Data FIFO mode test=0A=
 2. Clarify SCU/SCUIO/FMC fields are shared with PSP SoC to AST2700=0A=
 3. Bump vmstate version after ASPEED_SMC_R_MAX increase=0A=
 =0A=
Jamin Lin (3):=0A=
  tests/qtest/ast2700-smc-test: Add Data FIFO mode test=0A=
  hw/arm/aspeed_coprocessor: Clarify SCU/SCUIO/FMC fields are shared=0A=
    with PSP SoC to AST2700=0A=
  hw/ssi/aspeed_smc: Bump vmstate version after ASPEED_SMC_R_MAX=0A=
    increase=0A=
=0A=
 include/hw/arm/aspeed_coprocessor.h |   5 ++=0A=
 tests/qtest/aspeed-smc-utils.h      |   4 ++=0A=
 hw/ssi/aspeed_smc.c                 |   4 +-=0A=
 tests/qtest/aspeed-smc-utils.c      | 102 ++++++++++++++++++++++++++++=0A=
 tests/qtest/ast2700-smc-test.c      |   4 ++=0A=
 5 files changed, 117 insertions(+), 2 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

