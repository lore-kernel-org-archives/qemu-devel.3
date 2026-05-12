Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FACCD4857
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgx1-0005hf-Rj; Tue, 12 May 2026 02:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMgwb-0005RS-9S; Tue, 12 May 2026 02:50:24 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMgwV-0005HB-C5; Tue, 12 May 2026 02:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zfg1+mnIqNARlu+zWsaysm2F90i/idPnZcDcBjv9zVObGcwkm0uISUbqrl+Kce8Mf0CJj6/UkP0POXr91YB3GPrr9BQuAcxAKtP4E7mPnFYQpChSyq2xApyfmhg+QAVMIYdxtwJ4lPG4W3FMwuCWEyelbsO/BwGnMlIfkg16D9YpVm4EY7bSsVjbqHZaE0W1hgOlTUJF5fUBnnR6/4AR4BFQEYwubNorvPFOlLUPweCX8DPovpv1yBBm+siYdy8u2knLiqYtEo7eFduPoKa1k2Qml3NcSAYasU7gDjSquJz8tfL/M2LNr7Fc/9sEMJiBFwEuI2TCtuN2guP6QQEOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC3gb6rxwq9EO/pLhfAKIFuJhpF0L63TTOROS9g7t1o=;
 b=Qp8YRmwbn/WAEWOkQNy0TWI9tgohZwFgAGSBLHQmkAfpW/vfIpI+//w79kzVPcHy+5r/OqKhus1BeiK4na+LdIfe+jQFjXfIJA9opxe3v421K+9owa6nacsO5MtM7h/p7keYPctz2QNl2PiqtuYYWnECvfI416hyapIKz+TGZI71qWMdbd8YF629v0DZJZlqQhekt8/PhpfFax7OJ9U9ji4IRdQjRDKm7zKjrV9nt6Wha/JV/0v7tM05691tCCWgZu3SuJI6L2DStlntWY4pY8AfBiJd9q0pgqGs9C16wRQFarqRir5RJ6UVeh6AGWUJc12ur+AAkExb6jLgnIOaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC3gb6rxwq9EO/pLhfAKIFuJhpF0L63TTOROS9g7t1o=;
 b=jKaeqZijKP3h6zmD9qxDPVrlZwnkordbi2ilBiFChxVfEifpMgX5Et0/wpfPUKtfOCYyG8ay23z6gV03nxDvaG4T9uqdlgAGoEccSEAUgUIFep3nWN14nKRjt43MlYkG9JHHKloZIYyWGDZ1CRXeFBfpAJ+zBmSmhsz2T6FQ3kN1N6ca+q9UajRdnCqNzY+bYzYPct/uwFsjT2Uz8AzkpNGa0INrcUbY6tLp0ELVghbpskYnbLkpvKvmPLiR51KwybufLWqPfOd2ee3ANPH6u16xZprZHbbLLjs818jACREp7N6i5NCsWyTuLLFLLOHdAH1XUgnhP7GrpcQ+xqn8Bw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB5225.apcprd06.prod.outlook.com (2603:1096:400:1fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 06:50:03 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:50:03 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 0/1] aspeed/hace: Fix mapped address may not be unmapped
 issue
Thread-Topic: [PATCH v2 0/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc4duP2Kqpj+X0T0CgILKUOm2C2w==
Date: Tue, 12 May 2026 06:50:03 +0000
Message-ID: <20260512065002.1516704-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB5225:EE_
x-ms-office365-filtering-correlation-id: eba9ddd5-364f-4731-e93f-08deaff2b1b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003; 
x-microsoft-antispam-message-info: wgMiJ7gmP0uaWsUwsF12wyZvoc2f2rP4/GyhNR1OzxsIi5J2kH2ZnRwRXSvNZtVBMhI97c4veBVQcMG2gRBppN143v526Kr+FLtkIH9dEFd/tRwA7GBSRTGqRqD0Ubv7DTH5sL2AnoJx9f1BI9QNyCqGkuWNnqcS95KvuMoav6hErJhDFxfYm2h1qxJZWzzAtUvEk9etv1LCY92uHrbh6nq/MtpAbD71/1Yf0/Ld7hTBO/2NB0xjGwIFyNiu+F7Y0nTvSCM4fxbTYo8Rl0z9YtlNIho2drw2fFktj93+u6JPpzRzdKIIroESOx8WxuuEbDX1U37kjKB4X7026XuDWW+4aeD4VA2SA6Qvd7XAsk1U8uXdvtlAzkT/9JPbfIdHLMWJ4b8nCfHOCDvGQH4BFpJT64OfwI8+mkoNw4gM0dYenYeQfn9Gvg1eOlDRn9y6T5lm71IuNjisiAqrW0SNFS174l3aNfGDcA08aGuF0f3ogcwQ75qJRad3QBYgphcXZfe9Q1gwa0k3oYOMe3uFGVNEn9a+/5nzzbBpnVFZNksKImjlVlHO/psMJD3w4upIOtbHFEYuAV2HTK0QljrOo5h3JY90y1lG93BoZtT4EYHHT/dbGWyLr6tvgaS3NJNkrsbrNj2g+mxT+Dg1yapAiwK2YaoiuS6DxF2KA7PcUIzqrx4BaOW/dt9G6OTWpyCe20zX/VdLh04Thc/646UrWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ID2K9LCsu1Ae0Hcx8R4AX3K5HqMar1IPY3ZYi1zuD7/JDBxVjEhJvh61vz?=
 =?iso-8859-1?Q?dWRD37KgARPY9onVg5MYhGa/w9hbW04M80yiVlUdiIaukbxvL3zuN8Js6Y?=
 =?iso-8859-1?Q?lalg5TtDrxCleSIe/6Yanz4WKiaF5AbzpXrZOPJhX5A00TxOTGoKO0wAtB?=
 =?iso-8859-1?Q?9YGfHBqb8ni162LX3f72spZaqETo0SX/AD3Qd2qzmpwrE3q9JBsQCCHixU?=
 =?iso-8859-1?Q?yL0x2YDygcXuFnI+HZSyH+HNsUBvOO/+5SsfNR/0un5hBobJNypROf9dGj?=
 =?iso-8859-1?Q?NkwsVO4z7axsjT0GIyn0gF8jy2gQs1uUuHqJrLyC5GiQVNOC204f0H/uLY?=
 =?iso-8859-1?Q?CY9LwXD9QadixrBo2R7G9zEQz7WGkYSUoPjXHRl9/6ohitTvbD8SNznfbY?=
 =?iso-8859-1?Q?+fjWF32Ff8DTydQfvBcRJSq0jwt8ucY+wKI1FC2zprpqwpXPjpqbp0RdL/?=
 =?iso-8859-1?Q?FHepNQinQ77EmMdXto2eEPNoHdSY89oSHMXoVUNrdBlgpjCxCzR0+iom0D?=
 =?iso-8859-1?Q?VULu4m/BcwxDFUK2BaXNI1MtpdbIolRuRgTUWbHByZ1FaYmNkFTog8ubfM?=
 =?iso-8859-1?Q?kwpuIy06MA/p0+CPDr6ILhtx6t3yrZrA5Ve4kHv7B39OYOqt0WukVC2dRs?=
 =?iso-8859-1?Q?OQlh3IDApIL57NhcruafhTPz+fELmEkpLcR8gKV93Ek36b80ZtexmRuh49?=
 =?iso-8859-1?Q?TMnQm6wfRqtjOWFrHLULDngSI9sGRFCOukSgY9RkRieKY7jEcULSPl1To2?=
 =?iso-8859-1?Q?Nr1TAsokExIdrtxM+OPxA0b4XhmfwL18cUHaC5uIfRu5xv2ntVrZoz66QR?=
 =?iso-8859-1?Q?XRtRtMYDPbjWsY4zu8Hp9bfmxf+o7flxqBYgaqqNgKAgCBRD/pnUXunHxk?=
 =?iso-8859-1?Q?4cAzp15Fq9C+kVJxymnRJKa1jF9T/2nnwJA2kAUQqYpOPltl//u0Gd8RAZ?=
 =?iso-8859-1?Q?yB4eS3sX4DoCIM4hdX/Rm1OJEa9wqg0s9UBbpBqKmEOk11fiRhsF8waV8a?=
 =?iso-8859-1?Q?L2cJTxRAkCFad+8+LNNXlGaylxKyCdDfmycMub08+B8A+MV2ezrWCdS4iS?=
 =?iso-8859-1?Q?9ipuU72mi6B39559kiFGGinkoNTZAODh0iJVKzIACBfy/bXEqztd2xgNr5?=
 =?iso-8859-1?Q?JvM1qe4+/PPnPNokP71OKvgSWIHmCXogfOdOwN4do/ps7YDvcuz1EWTtwa?=
 =?iso-8859-1?Q?U/0GghAwLZM/0kuObcqrCvL1XIlHU74e28Rd52qcNTbfWxpYm0DgNPTaOW?=
 =?iso-8859-1?Q?w1dLC/9h8lH/GjIM4YW6qvC1aI0J453ZdYR3LE9KTotwhcTHlmZEE3abjL?=
 =?iso-8859-1?Q?MD2RcWgi9lN1m4osBZVE0QwfExWWjLvUGJgLeYUvjoy/CFtcyTNwjzEVF5?=
 =?iso-8859-1?Q?fjOSlxJX1R0rGsA7s0rPW2Gw8Wv9HAPPBaUUZ/8fNX6ykMuc79aElrFZ1c?=
 =?iso-8859-1?Q?2uGk8NgkgtNqkKWeJNspwilIS05J4ATOXau1p53Yf47FbvCOrh3L9GR+/y?=
 =?iso-8859-1?Q?HCHBvv2EMGAlAf7Nukj/3gGPFox8JbCOqMs/aolgNIcyvyBBe2XibpeXLL?=
 =?iso-8859-1?Q?0mYs/w/bl8NL3kuTeTCv/MBoGy4BqbU4+39bRzohFjFVyP7779RqxdGFPo?=
 =?iso-8859-1?Q?nFZmWAPkjzjEFvSDJBFReXofMsA/MVoIhhAbFUSrYUisNL32JvpYQIjPiM?=
 =?iso-8859-1?Q?9k9ScOyJFsKyMvaJ5oynTWh5AHsRULE/Z16bckCrl1hES2w7nmD85IdP/B?=
 =?iso-8859-1?Q?2oipEMVsT7YMQcfMOAdC/ugkFaG3tTYbaj20v9yHkDGGSm+bkWCb+vzWl/?=
 =?iso-8859-1?Q?BFQoy0XZFw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AdAE1hnKkl3oVjuo5388lB/MRQeilcMKuzQBvSGFwnYlFKp8k12mIwUjmd9xHNW/GmaXcuIz9q5Btno0Zd2ejnzPGwwSNWei9x1/d3BncyhU64FcHwfOBmQDC86JU9QCUL6nPAMAII1MTkXaVjaVG2Yxyvu1HLrGU5m7yTsVEBNFutdWMI4kMxzQtm4f0mlQs7AtrKU8Iy6R3e/rqQ9tBGcvHluka2mXzMbdikSDLJPjCM7lptQS2ri40I17isa9mEdlj2otl49VJyE6d6ypmqj78Ua0oOaksm8tNZaC94tKF7WRBkPjHhuXbH4XqiAHKx1Ogh6qIQdw/A+uWKwmRQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba9ddd5-364f-4731-e93f-08deaff2b1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:50:03.1100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkgUAuLsf0Du+1thMErsiTj5nrV5ENDA3VE8ub/L+0dZhmswijVnZPeBzFS+7SGikCmBLqDVNMDvwssFMa966u6leIMAltjty5V0pheHDVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5225
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Dear reviewer,=0A=
=0A=
The Aspeed HACE hash flow may leave DMA mappings active when an error=0A=
occurs after guest buffers have already been mapped.=0A=
=0A=
Several failure paths return early without unmapping previously mapped=0A=
iov entries. This can lead to stale mappings and resource leaks.=0A=
=0A=
Fix this by introducing a common cleanup helper that unmaps all=0A=
previously mapped iov entries before returning from error paths.=0A=
=0A=
Additionally, track the actual mapped length of each iov entry=0A=
explicitly. This is necessary because some hashing flows may apply=0A=
padding during processing, and the resulting buffer length used later=0A=
in the flow can differ from the original DMA mapped length. Using the=0A=
modified length during dma_memory_unmap() may result in an incorrect=0A=
unmap size.=0A=
=0A=
Note: this patch series is based on =0A=
https://patchew.org/QEMU/20260504213421.710035-1-clg@redhat.com/.=0A=
=0A=
Best Regards,=0A=
Kane=0A=
=0A=
---=0A=
ChangeLog=0A=
---------=0A=
v2:=0A=
- Adjust commit message=0A=
=0A=
v1:=0A=
- Initial version=0A=
---=0A=
Kane-Chen-AS (1):=0A=
  aspeed/hace: Fix mapped address may not be unmapped issue=0A=
=0A=
 hw/misc/aspeed_hace.c | 63 ++++++++++++++++++++++++++++++-------------=0A=
 1 file changed, 45 insertions(+), 18 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

