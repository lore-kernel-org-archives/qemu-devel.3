Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDB9CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogx-0001tR-I0; Wed, 30 Sep 2026 03:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogu-0001rn-3s; Wed, 30 Sep 2026 03:25:24 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogs-000289-Kp; Wed, 30 Sep 2026 03:25:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlJXRQ7sbXPBCqAHnNbWJaXYOUIQykLERkMQUEBRXix1AMOU5b5IkHQ2T5k+MmCREQYvHxLOvJxSY2fxJKP4NIjPylo4FZIJgXota6/DvDnk/Nb//ZFJb51rHZoBGExmcXdGjj2k2xED+z/o+i6fT0SCUBbuVziWtcY9uj3O16Nys+R45Vj92CubpEvtJfuzC44sftIhRESciYriMOtnq/5wI7hTqUMArSdfsjMgze14OxqtfEtPsPr2F7eQ+sqYXSCmnd5hpCw4yD5DoPMFKD5N9MXdbZIFNOma+gTzoOigp3+UioJ3xuxicKC6njuRNxSEVktiJeicyCJTw3vLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI92TtQRFaqRharsQUEJzz81dtOZmj9ivAzXIFwax/U=;
 b=qWzggXkzlFjC0vwowrF989h568a7SbfUPFyR0zKALmd0y1dIda5tLcuIwfLtttMCaoStMNMM33h2AIA2bfaJW1kwwE289EWU2pGx7RCdBCipRSDFc2CFkxUpw8VthCa+jwhQAlmyKm6VtzFjFBH3x+AX5BNaoGRX7djRY4NgzM2dkYGmfrF7L/cApXkYmju329qyUvn2jEYr/Oc5vDK8J9tjeSpoh1FgouNhsOPn8iLClo9BZXZTJkBf8+06JDVovM9xfFynlsota7sbDGF8NpKgdMjwWArV44uANnMNfCsr7wn7SL0tDtyLEefQTrpAHKWT70bC5rPN7cCf6XY1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI92TtQRFaqRharsQUEJzz81dtOZmj9ivAzXIFwax/U=;
 b=NVGdd7Nf19pZ5AAyMuFApukk6kgoj1geD9Iwg/sPwpn8mMlyNOeQTDmz74Q2IYB2EXoJY1ov9kw8IPiNs+Wcyy4DGFZ+bR+YLFJlGKmlymXawbdaVlu3YV6PjUNRqhbwXsItuxQXBXOrI0KjqAK6ojeQ6YhGin/JtJF6Cq4LG4WRRbFhmGh5P4cMZMVv2g+Nx/h3783BaTJCCPliQyf6OEYCdKO6NDN2+V9xG4pNEZAcBw9O6U6Q71bQ839MJquX4qYisbXDc50Vo6VXhQa5L6ISsBtdLkOVmWmycRvPTfbomgt8FFvTUxj1QyrrUnk5Tj4bPNSqEjqM5j0NrK4X4A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:11 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 08/11] hw/arm/aspeed_coprocessor: Remove unused
 unimplemented device fields
Thread-Topic: [PATCH v1 08/11] hw/arm/aspeed_coprocessor: Remove unused
 unimplemented device fields
Thread-Index: AQHdUKzU/W4SbNhDyEKmjSkzgoxidA==
Date: Wed, 30 Sep 2026 07:25:11 +0000
Message-ID: <20260930072501.2612119-9-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6616:EE_
x-ms-office365-filtering-correlation-id: a84902c0-2537-4508-bb41-08df1ec3f6bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: a5rL1yflOWTMbalq1l6EfLteB/7I1YOqn/AM2s33vquhM1r5SB1hCTF+1eev8tONnAqVlUk5gz7ZWhQcpn7GGDSu3p+y+6G3j16qLlOi6ID1+G7oHCvpFDBGQYlYKZ17n7S8YCcxYkOJrHA/g1L4/yB5/12qwcEPTPKIJMCMd/0I/bhuiWJacNRpcTzfBAxctvPs6C2d4/u/LqglNUIKmM2tFMzREUnlr9BCegyqbrzhUbwvE8yjS6eJ29hzfM1zAT0Zpwy3nybKUjaZGqf5oHxn78SdHncgICAS16FZ3jKgE/fnIub4gTttCQU24rn8421aoE5v5b8sHYzo3PbV4/eeCse4cJCoeG6+vFlyfvD+C45tGi4kBwxGyL7UIsE2TaNQcDyiwm7Z8erLRa22BCv3Ez3q/vdJ47bBJlZP22sLG0J6KFDiGkkXCqbQBbTt8pvDvf3uHxTSS62n34gTGCoygXaR6OMVwyst2LZC8+vgFzyoithqzlZ8mGFlGsSl0und7jRpGcSYS/i27u7wlJxj8Djek+/Z7Ru0rkRlBgsUaEO8MxBEejh009IKGe+nIi25rwzK5vbhq+Q+E2lLMOJ5mheLQkLG8JlG2Ds2zvOCxe5WjbfAsYhuiNOMLMkJ2ChvnzCffXF/4e6kohjxhlVKAJVj3E7lJeJzm3jz1WIYf8UGsJaP3CaO1khKYHLJtTHRlFRB2aCaCaeamNW7f8vez+WkCs91Iw7DOVw4xSk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YWgXtd23hwWOenJ4UhAgUO0SmtzzHcFYNK5vf9H4FUcs3cUWMWLaDfx99v?=
 =?iso-8859-1?Q?HdBb5fuH6cYPq34Xc2KwoTnGKhlrAHZX7Jy9dL5hYEF5SVtKh+FU0Flbi2?=
 =?iso-8859-1?Q?ykleF6H5nd6v6psWK0WuyAgxfs0K474Z3auUqup7AQjFfC82JcBXSlDmZi?=
 =?iso-8859-1?Q?EwIjatDqxMEGmvuAF73KfYdOenilN9qYFp1FTgAGxQ1GGJW1YMe9PkxhCv?=
 =?iso-8859-1?Q?uRop4ZO7Flcc+xLnmgH1mraF93FPI4awUTyUee/ogSTs4tBS5dLMWNJhS7?=
 =?iso-8859-1?Q?oCV/f1JS/6iRo3cT1pbWcBy/KtscGFGX92c3zeUj+9eECHk7cX8FT/EON+?=
 =?iso-8859-1?Q?ZLbh9/LWIBrTRlpFgb/4qNBwGAhm0n06vZJMYKjQhPl2LFvNxcSNlm3b9V?=
 =?iso-8859-1?Q?k3zheFjUB4qPlcLyxtrbp8DOlvtT/t4JlH+Mxfj1YV3LwoE7+K7FA2SYm/?=
 =?iso-8859-1?Q?AUn1HVi1y5kk0XzF5UZcJxR3x0fNjmWC5wKEkBrZI27mePx6DRORSYqp8F?=
 =?iso-8859-1?Q?zrm7aBmPGSkCdMWJvJO8ROFdhPZb6PN+GolwxT8UKxBWkW4sf5u1e4Ds6O?=
 =?iso-8859-1?Q?WgCS0/CCJJqHs2TSfxEko3Yezu+T+OqGnKuWOcGEy/shHhpUiivWtfcSD5?=
 =?iso-8859-1?Q?wZhOcOfczIW8nYDORD/atkjP0AYmYbjtNm6WIyNxHsnDL4MQOCiNrY4Vsk?=
 =?iso-8859-1?Q?x9ynGhW+eJu121Wlb3Omh1TRH46rpTbsgMFWKXHiRCoQosktnMVgwAJzHD?=
 =?iso-8859-1?Q?nphRP5o6Ns31/Ybi3prjOjDpiS8yElt7VuwLXA05YjVPGA7LcKdmiNORvb?=
 =?iso-8859-1?Q?zc2orv0T/H4pz43wdBiDjcCHHfrGUDTQi0twnlmEgIct20VArjJGvdK7zK?=
 =?iso-8859-1?Q?ryZEnV3RxecTQV304FTBdhmsfDzBhhs6A/jfERb1a10LKG1yc9sE8P8zK/?=
 =?iso-8859-1?Q?Ipu//ZPK3vYtFNgsJix7Dxw3BA73k3/weKQ6H8dWVg8pVE90rfizJ6+fn+?=
 =?iso-8859-1?Q?PeiVvy6Snm7hqd5Md5TBA6K1gnEmk3LZ+aSa+5wWnFMtdrfqXWxH9f9VL5?=
 =?iso-8859-1?Q?SfrEpLTLHoiWt0pudfXoA+OHWgq9owpFdF8trFp1EXFv5b2yVFwb6bYNlC?=
 =?iso-8859-1?Q?7ad5bWq4R6hviYV++372Lz/NWUIKIcb/rr3rSkb1TwDPutuoz8hsXaR9rD?=
 =?iso-8859-1?Q?Bn7/GucoFYG6e4ebojW8XeBCwtqUSK1mUoj9jQbxlX+aDrGX14sRl0RZ4u?=
 =?iso-8859-1?Q?d9N1Jvl8W7pfQoAufNtdpTftdhjuDg2jfT/AojSHSXMvLPL61POzRYTf5S?=
 =?iso-8859-1?Q?n/Nlcp3lixEI13fDrlVNdvC5Ugzl7qwjPeSVr8gr5FPnK3nBvepoJ0Utv9?=
 =?iso-8859-1?Q?xn40R+8nMK5vqy5Hjd8EhwpR6GWe7wDnZgzZdyOsiEF98vGOG5YMKGptBI?=
 =?iso-8859-1?Q?1DdVGD4UqhZGiCl4iSwUqsPnG9otOv1dLVCGdymq9lGvlswOqWZMiMnvWQ?=
 =?iso-8859-1?Q?ppx9PhLhk+ClBdicpfOlbmr1PA+Qw3z54LpOouy3pr3anYgLdtLWfp/amZ?=
 =?iso-8859-1?Q?oWIago7l1UtR0l3hBt2MqMH7YJctS19frJxQSgYyzgNIUOLrUsYgDaS0F2?=
 =?iso-8859-1?Q?YGT1Lg5BWTK4BALYu/qCZ4toaIF60pO/MKiBNEiN3b+QcU1VGG04kFFL4s?=
 =?iso-8859-1?Q?S1Tyy2XExnpCwTz87sWlYxOEaTKMMbTaUZajrfi1eJOkAIS0kbWb7KZcIR?=
 =?iso-8859-1?Q?4Qmu8pzMePeA6F0LpQNpR/Z11rB/lJfHoyMun1FX5q6BDvNJB50fEYVPqW?=
 =?iso-8859-1?Q?1UUi7zbHBQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gytCIAfZjPtgoH/36UPiPB6z7jGxbCYGonqajV1ePkeZi5EW59g0HbrMuFHhHpoZC76WR8chDku/FR/OrTmQkEOWsMjrMSAwBzMGsO5hiNQpgVjOQAiZGJ50lbKwbXyawdQnr+5V5qzOY+j3JC7Z3qidsuheD9RDkODkvE/9wJw9sXVj/cxuTFlj7hoPBzwu1MZN5FeSxK899gKLfcT7qnJQhtf3cLOuRqkSekEOdfDfrDLVMOB/2MSp/5qLBK9ZajepfTHXcruAwLstFE/VM7OgXKisOecBchfzqqQpyxsxk9pCjHYciUas22QUE/GQATUHcoAUD6qEe1mt3mGqVg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84902c0-2537-4508-bb41-08df1ec3f6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:11.6733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nz0hA5S+hYN4NFUCkD9NaWfxQ42HBkyBYI4JtJRNtqPWaPbJoKuUw4t0L9PsNJmRjGAeEaXtB6UXrZROM4vrcGcHPJIe7/WcnHtNiC31Zl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST2700 SSP and TSP now use the "unimp" array and the AspeedUnimpDevice=0A=
table for their unimplemented devices. Remove the old "ipc", "pric" and=0A=
"otp" fields in Aspeed27x0CoprocessorState and the "timerctrl" field in=0A=
AspeedCoprocessorState, which are not used anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 4 ----=0A=
 1 file changed, 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 29b66cc810..fe1f576874 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -22,7 +22,6 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion uart_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedTimerCtrlState timerctrl;=0A=
     UnimplementedDeviceState unimp[ASPEED_UNIMP_NUM];=0A=
     SerialMM *uart;=0A=
     int uart_dev;=0A=
@@ -44,9 +43,6 @@ struct AspeedCoprocessorClass {=0A=
 struct Aspeed27x0CoprocessorState {=0A=
     AspeedCoprocessorState parent;=0A=
     AspeedINTCState intc[2];=0A=
-    UnimplementedDeviceState ipc[2];=0A=
-    UnimplementedDeviceState pric[2];=0A=
-    UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
-- =0A=
2.53.0=0A=

