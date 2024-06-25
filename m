Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD3BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0Y1-0000zC-5o; Tue, 25 Jun 2024 03:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sM0Xz-0000yd-Do; Tue, 25 Jun 2024 03:24:59 -0400
Received: from mail-psaapc01on20726.outbound.protection.outlook.com
 ([2a01:111:f400:feae::726]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sM0Xw-0001nq-3C; Tue, 25 Jun 2024 03:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU4tzTiXR/LETPJuGHjrrWvpTTLAvkfbdkgFlTeTNpe5JbIMtPc4S/S7Xse6axtQKC8R0RTW4RPl1RGAjkTNDiFU9AOeokI1I0ptW4jRgwnPWeuShHJcICXM3xIVpABVQEDluledoPGl0O3ajxiu9tawZyN1/bTUlwuiJYCN/0anXnw0Ybno7CYT6Jp7kcUL9I4mxuIZ25geRDLKuGOkdVdWdWJXqE0DRSpO841Nn5xVCnprlP8MI7ilM0T12jkhEpEVD1RcPWfJi+n0/arh2qras13PFffAdHL4C4GOfTTXW7butJsKKOsDOyHE9bb4n/eQ6/eylXVjqiP8x5NCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+IjUiJoUAGuCSYdInzjAPKSjLPG5pqGo9f8iozl2F8=;
 b=BhviFhUtiK1PzJsLIEvhol54OamM4SEEky69l6+ZhBPc78mghrL1Vi/hYzbP4seQy/xxgO6AvICWUrZOeBEC3wuAZe89c5HcNvfYoe1yEwURyiZIMi33gnGZZjr4lgMPQlPvc8ijnJd1znB0GKmtO5DqcRVq1/mCOo6I2VvzFrO7+SF/Qg2PJWtPpHOPU6vY5kPFgTEye9Qe2uiDL2izCU1lxzayOJCE6SvQa1y6wgTQ46VPDWq5QFE/l4l2o7bgSBuYtyB2gsZlbntCu9J0Wp6ei+fk2j5MkG5/w20AEMBNqMdO/uhTTVLIulsAHoIM3cEGqHZgR42KKS2A3+7UGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+IjUiJoUAGuCSYdInzjAPKSjLPG5pqGo9f8iozl2F8=;
 b=atQgvsdveGOFP6K6w5mwDFpS2Kcw3rZWRK0PY+reFHEGCEjXzwYp6MBj8cNQHMfeDnIvxzh5dKGyVdj7cllbBfY71vA4U7sV/MF6ZhiVO6Um1rWXQOgxOg3LLwh9tjS6pEKeQEVgNySw+iIDv1anoP/vdahJkB0KoJ8H4I1JkPD6EkTvzyqcY2dDxGAsI/drih4QDDxmlvtkULkm7Bv2Lu1F6Z9C0NCpl5YehDETH+QJWtYZWzgVJC3KAUIzhiez/lhFyQUyqbDXeMSZVpq/JCdC5WX9SlFSpw6v/lzS3/hqHDhUoJ1TGGoA7LreKecxn9c1szi0QcN27/doNtx7Vg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6835.apcprd06.prod.outlook.com (2603:1096:990:4d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 07:24:46 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:24:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: RE: [PATCH] aspeed/sdmc: Check RAM size value at realize time
Thread-Topic: [PATCH] aspeed/sdmc: Check RAM size value at realize time
Thread-Index: AQHaxs0sqEDb2jgbrUauli/ZZ7QzG7HYE3ag
Date: Tue, 25 Jun 2024 07:24:46 +0000
Message-ID: <SI2PR06MB504116B8D8051FF7266EB002FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240625065839.485034-1-clg@redhat.com>
In-Reply-To: <20240625065839.485034-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6835:EE_
x-ms-office365-filtering-correlation-id: 3d3a16a7-5436-4401-5e0d-08dc94e7e3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?TTM5Tjl0ajlnNDdUTy9DQ05saEVZNVpwRi90UmdEQ0FqSFBOQmt5cE1IUWQ5?=
 =?utf-8?B?ZW44RzBnblcwajh5elgyZzkvZ2J2YVZwSWhPVDVSc1N6dENGZE9WUnloV2R6?=
 =?utf-8?B?MEo5M0lEYTFRUmJxTHdiRGlDVnJZVEZIQ3ZYaDNCbE9HS0YvbHlkMURrYTNY?=
 =?utf-8?B?dkh6Zy80eHNjVG5KWjVpQ0R2ZDVQMWdCbWxZd3l1VEZQdG9EQ0lVTUZhRklw?=
 =?utf-8?B?bEl5bjJzMUcvSEdXcnRvN0E3N21SZkFYKzAwMGlwbC9HYTZJYmJZWE5pbC9h?=
 =?utf-8?B?bndMeldIYVZ0OWwwVmpES3lLbjVqWUVxejRZQ1k0S0Y1UXMrbmpsMG9TZmZh?=
 =?utf-8?B?c0pscW8vTlA1eUJpakxCK3JaaVNGcCtPUENZaUg5b3ZTbGdOYXhEbWM4aGxD?=
 =?utf-8?B?dVFVcTJSMXV5Tlp1QzVpUGdZN2lVeEVhWmJIRFp2WExDQ1pxd3cxN0gwa3pa?=
 =?utf-8?B?MC85dGtlbFBLQmorZ3J5L255RVVFNVpOdUlQWFRiZWVkTExyaGNOcjVsMTZp?=
 =?utf-8?B?UEhzVlgreHI3MlJzN1lRNGpJVmN6V21JaVRiMnRDMXlmMFRSai9MV29Ndi9T?=
 =?utf-8?B?SVFSakltVnBTWXJJZ2xhOVpZQWE3UFM2eU5YV1Y0U1hURkdQbFZXdVZCQ0ds?=
 =?utf-8?B?QkJQTWVSdXFLRlJEcnFwTU9Sd3FCeGtQbGlBWk5wWUlLajEyeGYvcTZtTlRE?=
 =?utf-8?B?Mmg0MkdGY01SL2NncVYveDIxYUhZRUtyZVpVU2c0emIyZTU3eU5BeUoydDJN?=
 =?utf-8?B?OFlBV05sZFgzYWc4NUlERzVjaEd6d1pzbC9xa0hseHd4bFBTZ1lFblI0RGdm?=
 =?utf-8?B?clJ4SEM2bDh4S0dWU1VxYWNZQVRpdlhZeFg2aTNXRjRXZ09BT04xZG41MWFU?=
 =?utf-8?B?cWhkVzcwcnFLbTZFOUdrMzNubnJON0VhNW9SY1o2VmJUdHNvT0xrYlE3NVBu?=
 =?utf-8?B?TktQZWEyM2FpRnNieU9PRE1vcmxKdHFXSm5rN3E4OGxYY0xwK3dkcUtoMDM3?=
 =?utf-8?B?Z2VRSWFpcTFRdXlYNGZXeGhnZXNST0V2MUxqVGpTUXhxa2FHU2YvNTR3UFRw?=
 =?utf-8?B?OUllc2tkRDQ1bEQ1aHl5TSs1dnVybUZMOFUyeGM1NzBNVW9QTTUzK3R3Slcy?=
 =?utf-8?B?WG5aUUoyUEZCeXdib1VKSUtyV2lDbzVUMFdoZUR2UmoybiswakZHNGR2Z3RK?=
 =?utf-8?B?T3VXUnI4QVFwVGRaa3ZDRkFMdmFuM3o5U1lxY29oYUR5SGlmZWx1OEtKUUU0?=
 =?utf-8?B?Y3NEdmZTRzhPVTYxYnlvNU9OTjBFSnJsTkR1a3pmVzlxN0NaQ2l0UEpoUVNV?=
 =?utf-8?B?cm1CdHBUZ0RKandEd0FNRnNVQm9jaTRmRUsvcTU5dEJqc2ttVVFweEppcllF?=
 =?utf-8?B?aGMzaEFLR01zVE01dGoweTA2QWF0MWlaMW5QTzF2WHB1TlJ0dERnMXArNXlW?=
 =?utf-8?B?em9mWlJBM0xLcG5NemcvSDgzTTJHbEQ5NENTVUR1WmhvMmY5NU9xb0ZsUlRD?=
 =?utf-8?B?dHJyc1JqSlB0cmNadngvUjZwOFFUcXVVV1B0T3ZYc0x2aSt5SFJjbndzV0pl?=
 =?utf-8?B?ZWxUbDFZZ21vcm9LMnF0cW9tRitYS1RiK3gvVXIybVZZRWl5MjFXcVNxY0JI?=
 =?utf-8?B?b0d3VjVSU2pnckNYRWZTc1RpRHlJM1pIY3ZMdHN2R0dQZ2tCY0ZpRW16cWtW?=
 =?utf-8?B?UnQ3T3BBM210bG1hSEQ4aFVDa3EvZjBWTmh1RDNKcEcyU0pMZ0hyVkhxNFdG?=
 =?utf-8?B?eUZIS0NrS3VjdjEwckEwbDNNQ3hQbFovbWdkam50SkhMbDRHRlhRQ2t4d0h2?=
 =?utf-8?Q?fAIF/pdu7k5lOX0FwlM7x0SvJeS3TBzm4zRoY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVlnVHNmaUFYWWNMOGl6RW1lL1AyaDdJaHRZcjh1cW9SeVROTGU1R3lya1NQ?=
 =?utf-8?B?T3NPQ29ObGtzRElLYjZTWDRCbUtYbzFWbGRiSER0dHlhL1lla291b1E2RjRY?=
 =?utf-8?B?U1VPeGRPTGpqNTFzcXo3bWcvcTlOdSs1UG1BMkM1WjcrZ2laNkxtdnA0TDlm?=
 =?utf-8?B?Um1qNEpwbXhLbFhiWXNYejExeG5FNkQyTHF6TG5XUGU4WWJVaHZNZkVoMG5n?=
 =?utf-8?B?MFlpTCsvQXo3M3U4RjF6TWZBMVBNTm1YNWUwL3ZGcXZxRmtJLzZEYzI0b1VB?=
 =?utf-8?B?cXl0VmFRVFVET2owQmZFQU1XUW9SRERNUS9QTnorMzlLblQ1aFFMWjdWeURX?=
 =?utf-8?B?Tk9CRStOYnNwZWhVaDQ0bUVvTEd0eDNRYXUwbzNIRDJSZm02Q2c3Sm51Z256?=
 =?utf-8?B?S3g0eU42b2pISmNJVzFoT3o4YkhUL2d2eWNzNW5FbDRPSU5QZWJjamo1TmFt?=
 =?utf-8?B?OVE4VzF4akUvaUZwMmJ5aVNQU3FqNTRJNjluYVJ2U0EydjRjaTlwMlVuYy9p?=
 =?utf-8?B?blV5TkZka29jbTFINm5jeWF3aUFnaEZMdnhQTUhocHlGY0RLNWlBUGpXN0sr?=
 =?utf-8?B?S1phSUNkUGFQMnNCc21Tc0RxRUdsTGd5UXFJbmhjNlZCWFd6TWIvNytZdHVh?=
 =?utf-8?B?SEp4ZkZwb29UZ2Y1OEhLNjRGUFd0TjliTnN1bU5VSnFxZ2hHa1hPdWMxOVp4?=
 =?utf-8?B?bnJwT21rS21QOHdXb1ZPUWJtTG5udkNDTzR4NG5WYmFmMHg0YVJ2dk5LeVBL?=
 =?utf-8?B?UVNBRGhZeDVYL2NlcUtDdXVadWNMdDEzWkhLMEZsakQ1Q21sQ0FESHNFWEZF?=
 =?utf-8?B?V1h3ZlZVSkpLWC8xMGx6STl6SjduNVlleEdjcE0rWlRjQmZTSGg3V2J1VGsr?=
 =?utf-8?B?Yk12cTdhaUNMOStQbW9IbDdWUWgwRkFFK1RpWGNCOFdnZTJmbldBcGNaajZw?=
 =?utf-8?B?c0JDeUJuajhhdmVQWmNMYXpoK0tvdnNjZ25oWjYzWnJzZWxhb2dPbVFoaDdt?=
 =?utf-8?B?RGY2OXh0Y0pEZ05YOWlWS2p3bVBLaitIMU5NaituZ2hObi95N1pUUThGNGpq?=
 =?utf-8?B?MjlYQzRhYmt2YndZeUNkZzJ2K2hFQ1J1cXVvRndSeWswOFB0dU1FVkZPNlZF?=
 =?utf-8?B?L0xZL1FtaGVSRTk2U1VqNW5BK2hBMEVPZ1hXeERkUXJLVFVabW53Q2Y4NWhx?=
 =?utf-8?B?K2xvSkRHbUlGUFlJRmdSSVNOcnEwWStKbEVDOXFmYmJML3l5SmNOcUVURFk1?=
 =?utf-8?B?V09kWEFHSEVBcWd1a0JBU1ZvNVcreXoyUlI3ZWFGKzE1Z1F4RTZUK1RBNHJq?=
 =?utf-8?B?WnYzTitoV1FYZG1JUjlMY2htOVk3NGVETjhmb3J5Y0pPWDNJbjY3R3RnaW5t?=
 =?utf-8?B?TTVneTQ5czN5STROa1FRUnJvNmZIbVV1dTdnZ3RqRzF3dHF6ZlhDSlZGQURT?=
 =?utf-8?B?ZjcrWTN3ZkhReTArcWZYMkZTT0pLQktDMU9qR0ZqK3RLWmRSTXcySGV5NEpi?=
 =?utf-8?B?OHZKQnBRay90ZWJBNVdvOVZQQW1rek4zQzM0QUx0dTZWUEZITXRZVWorUG1U?=
 =?utf-8?B?bHZsQUdQZ1NmZ2NQTDlYYngzaHp3REFvR2hJR0k1cjFqMmpXMWZTNFlSa2cy?=
 =?utf-8?B?ZVk4UHoyOTg4Q2l5RUpkZ3AwQnNOZkoxckxZZS8wTU0zQVJ4b0M0R2dSYjhX?=
 =?utf-8?B?VERYL2Q5K1h6WXV2Z3dGaDE5VEQ1MmhPUmYrbVVuTWNQR3A1c0ZMMy9MMU8r?=
 =?utf-8?B?V1VmQ25rVzVOTE9PNisxdVdsL0NCbUhBUWo4aHBsSkJ6dlp4ME90SXArcHE0?=
 =?utf-8?B?WHI3VVdsaURxZnVJck5NTnoybHVCWmdBdTJzeC9iaGR1cytERnZtQkpYazdm?=
 =?utf-8?B?djlFOHRZQnJRMEx0K2diaURZWTF6dU4vbStVRzdWR2NqOFl3Y3BZUG8zMXBR?=
 =?utf-8?B?NWx3VHBwZ1VHOHlKSlZpeU92ZThSL1lUL0N1QjJmT1Q5YnRvcUREeDd2dmMv?=
 =?utf-8?B?d1BDVDJ5OUxRTlduR1UrakdLdVQ1NXZrVHZXL0NUU21TVExld2FHQmw5WTJQ?=
 =?utf-8?B?a1lmckFNSzRRVE5XQVBFK0pmdHJrU0IxL2FpMWVrOTBFdktGd0dEQWhoT0sr?=
 =?utf-8?Q?AGrXZwmCdCD+XvOLZma3mp7ug?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3a16a7-5436-4401-5e0d-08dc94e7e3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 07:24:46.2880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9wncIG3AKDf/v3fBOJJGDHnwnfuSOzJ/iaB105lR0dmx/8NiScoClxZjHOpIS39x2Oy4m2vul2pnxW9FP2I4UUhESsEE1aGuPFyTz7qDDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6835
Received-SPF: pass client-ip=2a01:111:f400:feae::726;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjUsIDIwMjQgMjo1OSBQTQ0K
PiBUbzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBQ
ZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBKb2VsIFN0YW5sZXkgPGpv
ZWxAam1zLmlkLmF1PjsNCj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNv
bS5hdT47IEphbWluIExpbg0KPiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQ8OpZHJpYyBM
ZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGFzcGVlZC9zZG1j
OiBDaGVjayBSQU0gc2l6ZSB2YWx1ZSBhdCByZWFsaXplIHRpbWUNCj4gDQo+IFRoZSBSQU0gc2l6
ZSBvZiB0aGUgU0RNQyBkZXZpY2UgaXMgdmFsaWRhdGVkIGZvciB0aGUgU29DIGFuZCBzZXQgd2hl
biB0aGUNCj4gQXNwZWVkIG1hY2hpbmVzIGFyZSBpbml0aWFsaXplZCBhbmQgdGhlbiBsYXRlciB1
c2VkIGJ5IHNldmVyYWwgU29DDQo+IGltcGxlbWVudGF0aW9ucy4gSG93ZXZlciwgdGhlIFNETUMg
bW9kZWwgbmV2ZXIgY2hlY2tzIHRoYXQgdGhlIFJBTSBzaXplDQo+IGhhcyBiZWVuIGFjdHVhbGx5
IHNldCBiZWZvcmUgYmVpbmcgdXNlZC4gRG8gdGhhdCBhdCByZWFsaXplLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3
L21pc2MvYXNwZWVkX3NkbWMuYyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9hc3BlZWRfc2RtYy5jIGIvaHcv
bWlzYy9hc3BlZWRfc2RtYy5jIGluZGV4DQo+IDk0ZWVkOTI2NGQwOS4uZWJmMTM5Y2I1YzkxIDEw
MDY0NA0KPiAtLS0gYS9ody9taXNjL2FzcGVlZF9zZG1jLmMNCj4gKysrIGIvaHcvbWlzYy9hc3Bl
ZWRfc2RtYy5jDQo+IEBAIC0yNzEsNiArMjcxLDEyIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zZG1j
X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4gRXJyb3IgKiplcnJwKQ0KPiAgICAgIEFzcGVl
ZFNETUNDbGFzcyAqYXNjID0gQVNQRUVEX1NETUNfR0VUX0NMQVNTKHMpOw0KPiANCj4gICAgICBh
c3NlcnQoYXNjLT5tYXhfcmFtX3NpemUgPCA0ICogR2lCIHx8IGFzYy0+aXNfYnVzNjRiaXQpOw0K
PiArDQo+ICsgICAgaWYgKCFzLT5yYW1fc2l6ZSkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJSQU0gc2l6ZSBpcyBub3Qgc2V0Iik7DQo+ICsgICAgICAgIHJldHVybjsNCj4gKyAgICB9
DQo+ICsNCj4gICAgICBzLT5tYXhfcmFtX3NpemUgPSBhc2MtPm1heF9yYW1fc2l6ZTsNCj4gDQo+
ICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5pb21lbSwgT0JKRUNUKHMpLCAmYXNwZWVk
X3NkbWNfb3BzLCBzLA0KPiAtLQ0KPiAyLjQ1LjINCg0KUmV2aWV3ZWQtYnk6IEphbWluX2xpbiA8
IGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCg0KVGhhbmtzLUphbWluIA0KDQoNCg==

