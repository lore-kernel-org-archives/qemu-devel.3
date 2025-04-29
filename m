Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B519C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fsl-000441-Tf; Tue, 29 Apr 2025 03:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9fsj-000433-8N; Tue, 29 Apr 2025 03:59:57 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9fse-0001wT-U7; Tue, 29 Apr 2025 03:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qnw2IbDzeyXRRbvG1ay66INKrSeoQst46gncG4Ukg5XpUJVF48JtAFryWT2oLUOtuVm8mkanryR5QYNdK6CU+WZ1gZq9bXcQ+S90wQOMAK36302oNYjs6KnaMuggBCyz1a7M7/iKqWcv76rGNwHTwQO1vRJQ9MSLnunNRKCr6P2jbLVM7i/aqo37HZVGSWWUz9Dd6dh6ibkSz+owgVpFPdE2KujaRjp9/geoTj98dvbznDfLffovr/qwdf+f61xtaL8r0ltps0HqTxS2Y5K9LK+0FVPyly77Nmco6XNhUrf54nE3SE66Oji5173CmEX+aOSplALpp3wYjYODeRsx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFyAVBnf4DXhiAYbQ9MayN6atXIUFE6uyjLKDewfeVo=;
 b=yvhosH8gfDk/bN84Lx6uK0Gq20Qxw12ud+7/LoLdIS2FKEw7+/ksq8wcEnBqmPXoZtToZMhwCljr0bijzskAYGlKTsswXfBehRnQI3rS0+84sWisL0tgEda4FuFFBN3WeHzoyuM18lVp2pXL0gSCdiK5/gctSKIlp7M8LV9BS4jZdyggZg/3KBlZ1JrbE2/MWJt1f16nFou/Dzi+QpzvlXXk2+9XxNeZcy2uH79aF2WiNFckyasotXYHa2Ost4iUPaeAYt3nlflQ6dLLnRN0hQdcP8I5HHci1a70Jpx/Jc1czH36Gms2yfZg+xiM7vQ1I0YWGQBK3pTPAuBflLIcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFyAVBnf4DXhiAYbQ9MayN6atXIUFE6uyjLKDewfeVo=;
 b=CooKXQ7BN+Ub2TmVhYoJydkuK3ut+EYL6nKmN+a6Cnd8GsGxhQ/YET9GJog29iHCPxgnh79onpCMJ6JSBzEopx5B9tNRoB8eDMTrEKyHxjvcBQ3+UvYT+bLJkH53tEgInCZ+daeCTeD2bZrIOy2Qxyizv9ZWIMoywi2gjrbAYjUPb2H1EekCQf664jCIo8foHy86kZadZyQSA2b8Q/VH7MYGtUEb0xpiqsvwMXPPT6I9IUI5XWuEHYAI+1A0MzASV1SGWxemVZ57rCyC4cjLjtXxInXMW8aF4Q3sLxyM4GYr7qp+iq6En/+CkqXIQc8uxCLuhKllVEedirP9miyuoA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB6444.apcprd06.prod.outlook.com (2603:1096:400:47b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.31; Tue, 29 Apr 2025 07:59:42 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 07:59:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbr0arWgH+5S4p6UW9XfH4aQxehLOuolcAgABZe1CAAPNLAIAA6amQgAfrtgCAAABHYIAAIU2AgAFzaeA=
Date: Tue, 29 Apr 2025 07:59:41 +0000
Message-ID: <SI2PR06MB5041A6B85096979430273045FC802@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-7-jamin_lin@aspeedtech.com>
 <85a2947e-6909-4311-8b58-f9eb8045e76c@kaod.org>
 <SI2PR06MB5041D4AD25381C7D1D6A5C1CFCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <a4c178b6-7048-42d1-9e90-58ed87baf9b5@kaod.org>
 <SI2PR06MB5041756942DE834177DFF573FCBA2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <53e66299-ba7f-404e-87c8-2952fb4d857b@kaod.org>
 <SI2PR06MB504102422034DBB6EA8CFFE4FC812@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <55dd4885-9f2e-4a52-bced-b70058f54101@linaro.org>
In-Reply-To: <55dd4885-9f2e-4a52-bced-b70058f54101@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB6444:EE_
x-ms-office365-filtering-correlation-id: 58ba0ffc-3220-42d6-5ed4-08dd86f3cc24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkNPb2ZBdkVCbUJzN2FBdTlzZEZ3WGluNnlsYVRzaUkxM1MyYThHcnJWRFVM?=
 =?utf-8?B?TUpEalhwaUJNeVhnTWJqYld1bU80STN5aEYyejViZ2NFWFJmcXE0OG9WcUFZ?=
 =?utf-8?B?L0gyWTQyMTFmNmVQMjlQbWQvbjI3dTZHbXhYTjRRWmxmZXhSY2Y3dFJEanZQ?=
 =?utf-8?B?WDNqanBJZVNmT3lyLzh5bERGMitwVGlnUXFrTHlEMzdic05JclZUeUlHSW9P?=
 =?utf-8?B?TTlEcXZOV1BaT1hrdVBNdnRhMVlrV3NtdWo1VGFuc3Z3Q1BQT3BCS3A5SXlW?=
 =?utf-8?B?d3FOUG1lVmI1dEIraTJwUHRnTWtZTlJmYk1UTmQ5M0lMemN4TzlKRGx3RzdI?=
 =?utf-8?B?aGIySUl5NGFUR2QyaTNSVmZpVXJmR3VOZnhldVdHcVJFUW5iT2ZUTFFLVnpa?=
 =?utf-8?B?Wkw3VnEzU2o2bVAzQ25OMHNsTU90ZWNZRnh4ZW45Z1ZuNG0wVUlPSDNhdFBP?=
 =?utf-8?B?M0tSRVdSbGJkTmN0cFJmUmdEcU45M3pVRk9vU3paSnh3TXFxUzZ0M0t4Z2tI?=
 =?utf-8?B?YlEvbXNlM0VoZmRBU09XSGxMT1d5d3JQZHEwSzVQRjUrYTMwQVZJelFJVkZi?=
 =?utf-8?B?VDJNNXdpVitMb05WTnRQR2pNK3F2QkJpd3h0V0EyQngzRGpuT0FxbkNjd2dk?=
 =?utf-8?B?V3ByKzl1NFZXd0p0bDk4LzlXUmliTlVFOUtNSEx2blZkTmFaUVB1Yy8wK0Rt?=
 =?utf-8?B?TXFscVNhaWpST2s0VEErOVloMit6dWFtbG5qaUFkMU1kNmdSNllRTmgrWHAv?=
 =?utf-8?B?ZVNmeHZXSDlnb0M1VHFkNWxsWS9EZmZCK1l3NmxBcGZZaSs3eUdFVVUvbHdt?=
 =?utf-8?B?czFIN0FLTk1RV1Y1V2N3RHpWa3U5VW9JL2E3RzlwU3ZzNmZyT1h3WGg2TEVX?=
 =?utf-8?B?SWtER05kQng5cG1HUm9BU0FYY1Vod1pkUHFUNlJkNlJZeTZSc1NiazhBbWlB?=
 =?utf-8?B?UDcvVmp4amxzVlBreGcwZ3pyY0tCUGxMY3pxMnJ2b3RldTQwNnAwSGcwVGla?=
 =?utf-8?B?Q3U3SVFNUGZGQmV3VXUrS09Ua1R2UllCUU5jV2pqbGpiOGY1Mi9kQUU5UGpq?=
 =?utf-8?B?anlPN0hjNjJ5cis2SGFQQ3JidU5nVi9VNGJSWE15ZUx5MEh3b2JPRkUwdHBk?=
 =?utf-8?B?QmFNSWozQTNpbEE1bTgzL21hdktFc3dYejBldkRLcXRxLzhzeGZwaC9WMUM4?=
 =?utf-8?B?clhHY1pLYnF0QmI2VEl5UTMzV084YUZnQ0lSRjlpRVhpd0JidlhSV2VKQS85?=
 =?utf-8?B?V3gwSmFvajNkL29zL0g3S084NVZmNTRucVZpOC9MQmszREpTN0x3U1Qyeisz?=
 =?utf-8?B?S2doYjhkT2J0YWk1cVlJVE9TYVhZc05kYTVPdEtUNGJuR3ZEZW9LZm55MW1i?=
 =?utf-8?B?ZmZCOTc1Mll2WmU4UHd1UzVEekszYXZ2VitaMzZGT3ExUjlBWlEyUmZlRjZ0?=
 =?utf-8?B?SnczNWZxRERwS1VaL1JHQjVUeFVya2hWTVluVWJYb2pCUnZncEpwbHN2UkFh?=
 =?utf-8?B?dDFpWGFTQzNkSENrMHp3Q0EyTWtWeGJjb1hKRVovdlBGN2VWcUFqV3JhaUpv?=
 =?utf-8?B?dUpSUkxXMkFwM2VKNWovVFZhY0lnMm02MEM5ZjI0RCtLQnpDZ3BCTGxPc3pY?=
 =?utf-8?B?ZE84bGQzZWpaeW1oSC9EY1A5RmJRYXRVa2dkQ0Evd0dMQ1ZWTU1UR3lqOXVk?=
 =?utf-8?B?K0EvU0twNm4vNkN1TzlWOVJKNjVhUFFrRTB4RUhSRlZTck5NcmZWK202c1Zz?=
 =?utf-8?B?ZVlHMU1FTkptKzJEL05hWU5Zd2pGR3NiS2tnNjBXVU5qWVd2SmlMc1Uzclh2?=
 =?utf-8?B?QTZ6S0pseGRzYSttYVZLSEJHL2YydUhmb09MUzhtZnoxTXpqMVczTjlxNTF3?=
 =?utf-8?B?UEJXNnhhT0h1U1ZBVURRbVlxN2pCT0pHTWpMUVNuZU9OaVI0TWx6eFNsakF3?=
 =?utf-8?B?M3RHOXJOR09kUjZCK2tYaVRzQ0dwb1dRcFdNS1dNUUdINWF0Q1NXK2tBQVFk?=
 =?utf-8?Q?LFHOEEVbwZL5J3RiS7ozg95mjsjoyU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzRWL0Y3SzJ5SjFEZ0VwOGlWQkdWMjM1dXF5bkVUYVJFaEVqL09QbjBSUERJ?=
 =?utf-8?B?Rlo4YXc3Y05BMXdnalpseUxlN0tKOTBSeUNmK0syUndCcEJrRjl6dUhuQVhr?=
 =?utf-8?B?WjlIQWFGTXh4d1J5RG5lT0hZVkprVHVNTXArQTE5QlhYOU5BWE8xM2grZmRS?=
 =?utf-8?B?ajJINVQrdTdiWjU4My9YMWFxMy9WL1dFY0FYc1FTOEJ5eEt3NmpaaFB0cSt6?=
 =?utf-8?B?R3dFTCtrWXpNVU9OWk1pd3d2OGhtMGhnaTVSaG9YY2xVUVlTWnAwVU1rRUFr?=
 =?utf-8?B?RGZrYlM3VzYxN0lnZFluRFdYbXBhZFRZWjNXaWpabUFvK2FjT2ZYSmVmcmVB?=
 =?utf-8?B?TGZoaG0xVE9wRmVUSXNhQU0wc2w2NHNwSFE3d2J4a0ZiZXZpSjdFMS9JSWl5?=
 =?utf-8?B?ZWFCaHdTbDRGWWNNRGljVUpvSmNBbU1TamZSOFVMUlYvd29PN1dnb0dpZHpO?=
 =?utf-8?B?RlRwbnI4dnlsYkg3Y05vUGZYaFFSQkZRRFZjb1d4VVNoSk1YTzRTTU5wWk45?=
 =?utf-8?B?aVh5OXFJYkpkNWUzQ0pZQVRRVlMzaEEyQmdmRXZaYTNnYkNXN2UxaUN5cUJs?=
 =?utf-8?B?c20xT2dDZXY0S3ZKcjE5N1BuS21VRjE1b1Z5Ly9UT3RFMUZab2wzc2l6L0Np?=
 =?utf-8?B?aSs5RVpkK05iVWwxVGExK0FWd2dVaWNIMzBTeDhFdnNNSkVyVzNtMnJERjNr?=
 =?utf-8?B?b1NUL2o5alBqcEpsQ2RmVFBrclh6TURPUFAwTTdhYmdjWGRkaFJGUzdJNlpX?=
 =?utf-8?B?T0tQVkxNQ3ZyZUFjbisvN3RRazdpNGFoTUl1c01ja2UrVVl0Mi9XZ0kwcXEw?=
 =?utf-8?B?N05UbWlTWDB2QzVJd09rL1EzSGs2dUhPQm1aUVByZ1BSdVIwdTU0QXNLMFF2?=
 =?utf-8?B?SFhEMU9FZXRueWwyVG44SlMrajJxdE9UZ2l2V09mZytOUGxUN1Ixbmp6eUdl?=
 =?utf-8?B?NGFsMmpjUGlISjljY0JBNXVhWFlXOEs4VVJhTG9oZ2c4WkpnR1RPblZwd2pU?=
 =?utf-8?B?WVFSbG14QkJmR0ltQXFwYzlMSFBQcVFhTExzMGR1ODkycXFhMUdCR0x1S3NQ?=
 =?utf-8?B?OGY1ZzdjZVp0T1R5S0FwVXNmaUhyK1BXd3EyVFlneUpJZnY1RWF1YmFmU2dn?=
 =?utf-8?B?Nmc3VDNVVVR1MDZzaU5aVStEZ3RYc3NjMlUrZFlXdUd3U2hVNG9ydzlNU2xl?=
 =?utf-8?B?QzFIZWNsYUx2VFRXQktEd3hwWTdRMmNlTFhoZjlSc3FuZDdPZ2lYZDNmdU9F?=
 =?utf-8?B?VkhZamFibnU5RUdZaFI1MlZPSVRlbTBhS09VR3RMcUxiQklraW1OaXdpR1cy?=
 =?utf-8?B?NWxLVWR1bzhwT0hMVGZBbEIrdmJuRVhONTh6VTBBbC9aSVBGd0s0ODJDRDls?=
 =?utf-8?B?NXRnTTMrZmhjdEtHQU9pYkVsVDd4TlVVcTBnQXJUalRoOGM3cUxaWkFZREsw?=
 =?utf-8?B?bDE0M2NQcnMvZHRpeDk2dWwrcjBRL3lZNjJ3a2tJUWQxUnlja1BzZURHUjRa?=
 =?utf-8?B?TGZoL3NycktPTlFLbXNwTUZsNFh2OFd2d2ZqQlpzb3hvTUFhSkk0dHdzTXFU?=
 =?utf-8?B?WkZFZitMRUtyblBXUmJJeWt0OEwrNUFaZEVhOWNEOUgxeE44N2pibWp0c3Fi?=
 =?utf-8?B?cXVjeHpHV1orM1FoZFp1MXQ0U0VRczhjNTY5RTg3L2d2Q1Z5aGkxaU0rRVJi?=
 =?utf-8?B?dHl1YXpMWWtLNkhNY1ArWFl1ZXJhcTlmTDV4eU9nUHlPM2gzYzhRSitiaTd5?=
 =?utf-8?B?WHFGcnFUeGltZ2dJYm1SN3lhSjFzWUUwTmxUWk5CS3hDd1NlTlZ1VGZ1UXI2?=
 =?utf-8?B?NzRMbDZZN1JENldQa0c5U291dWJhL0JDNkVMMzZiSmZ0eitOTnpwd1lLKytE?=
 =?utf-8?B?WVZGYWFkRVJ1L2xUNENuT0pGYS9HZlo4eHlQTHdhL01nRWFQeGZmQjZiOGxD?=
 =?utf-8?B?M21qeUFpL2JQaHZ2T2VDZHljaENYRGl0NEI2ZlJ1Z3FFNUVFNzIwVGV0Z1pt?=
 =?utf-8?B?cFdwUGI3akVWbXlTR05kTmVzWm51ckJBUmZoc3V0Y3BNdGcxL3dtdDhUZ2Jo?=
 =?utf-8?B?ZjlMYWZ6NGJ2SFZqYjFPcWFjRktTK0RxKzJrR1dHT29vR2drQmFzZDJiZXRX?=
 =?utf-8?Q?xFqJGsJHp0xqB8nM1HI3BjNv/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ba0ffc-3220-42d6-5ed4-08dd86f3cc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 07:59:41.6244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ciMohvDXrKpFXKNguaA5kOSctqOnifuMcHE1r3xgel0ShE0kZzdr+3mLJo5b3gEOHEKmIWJTAGRePHqNtjdmSsB+tlozGlGJdlFHsaXOAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6444
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCBQaGlsaXBwZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDYvMTBdIGh3
L2FybS9hc3BlZWQ6IEFkZCBzdXBwb3J0IGZvciBsb2FkaW5nDQo+IHZib290cm9tIGltYWdlIHZp
YSAiLWJpb3MiDQo+IA0KPiBPbiAyOC80LzI1IDA5OjU0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4g
SGkgQ2VkcmljLA0KPiA+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDYvMTBdIGh3L2Fy
bS9hc3BlZWQ6IEFkZCBzdXBwb3J0IGZvciBsb2FkaW5nDQo+ID4+IHZib290cm9tIGltYWdlIHZp
YSAiLWJpb3MiDQo+ID4+DQo+ID4+IEhlbGxvIEphbWluLA0KPiA+Pg0KPiA+PiArIFBoaWwuDQo+
ID4+DQo+ID4+IE9uIDQvMjMvMjUgMDk6MDIsIEphbWluIExpbiB3cm90ZToNCj4gPj4+IEhpIENl
ZHJpYywNCj4gPj4+DQo+ID4+Pj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNv
bT47IG5hYmloZXN0ZWZhbkBnb29nbGUuY29tDQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NCAwNi8xMF0gaHcvYXJtL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yDQo+ID4+Pj4gbG9hZGluZyB2
Ym9vdHJvbSBpbWFnZSB2aWEgIi1iaW9zIg0KPiA+Pj4+DQo+ID4+Pj4gSGVsbG8gSmFtaW4sDQo+
ID4+Pj4NCj4gPj4+Pj4gQmFzZWQgb24gdGhlIGRlc2lnbiBvZiBhc3BlZWRfaW5zdGFsbF9ib290
X3JvbSwgdXNlcnMgY2FuIHBsYWNlDQo+ID4+Pj4+IHRoZWlyIFJPTSBjb2RlIGF0IHRoZSB0b3Ag
b2YgdGhlIGltYWdlLWJtYywgYW5kIHRoaXMgZnVuY3Rpb24gd2lsbA0KPiA+Pj4+PiBpbnN0YWxs
IGltYWdlLWJtYyB3aGljaCBpbmNsdWRlZCB0aGUgdXNlcidzIFJPTSBJTUFHRSBhdCB0aGUNCj4g
Pj4+Pj4gQVNQRUVEX0RFVl9TUElfQk9PVCBhZGRyZXNzLiAgRm9yIEFTVDI2MDAsIHVzZXJzIHR5
cGljYWxseSBzZXQgdGhlDQo+ID4+Pj4+IGJvb3QgYWRkcmVzcyB0byAweDAgYW5kIGJvb3QgZGly
ZWN0bHkgZnJvbSB0aGVyZS4NCj4gPj4+Pj4NCj4gPj4+Pj4gRm9yIEFTVDI3MDAsIHdlIGludHJv
ZHVjZWQgYSB2Ym9vdHJvbSB0byBzaW11bGF0ZSB0aGUgUk9NIGNvZGUgYW5kDQo+ID4+Pj4+IHRo
ZSBCT09UTUNVIFNQTCAoUklTQy1WKS4NCj4gPj4+Pg0KPiA+Pj4+IFNpZGUgcXVlc3Rpb24sIGlz
IGFueW9uZSB3b3JraW5nIG9uIHRoZSBCT09UTUNVIFNQTCAoUklTQy1WKSBtb2RlbHMgPw0KPiA+
Pj4+IGhldGVyb2dlbmVvdXMgbWFjaGluZXMgc2hvdWxkIGJlIHN1cHBvcnRlZCBvbmUgZGF5Lg0K
PiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gVHJveSBkZXZlbG9wZWQgYW4gaW5pdGlhbCBpbXBsZW1lbnRh
dGlvbiwgYnV0IHRlc3RpbmcgaGFzIG5vdCB5ZXQNCj4gPj4+IGJlZW4gcGVyZm9ybWVkIGR1ZSB0
byB1bmNlcnRhaW50eSBhcm91bmQgImhvdyB0byBzaGFyZSBEUkFNIG1lbW9yeQ0KPiA+Pj4gYW5k
DQo+ID4+IGNvbnRyb2xsZXJzIHJlZ2lzdGVycyIgYmV0d2VlbiB0aGUgUklTQy1WIGFuZCB0aGUg
Q29ydGV4LUEzNSBjb3Jlcy4NCj4gPj4+IEZ1cnRoZXJtb3JlLCBSSVNDLVYgaW50ZXJydXB0IHN1
cHBvcnQgaXMgY3VycmVudGx5IG5vdCBpbXBsZW1lbnRlZC4NCj4gPj4gQ291bGQgeW91IGV4cGxh
aW4gYSBiaXQgbW9yZSB0aGUgaXNzdWVzIHlvdSBhcmUgZmFjaW5nID8gU2luZ2xlIFFFTVUNCj4g
Pj4gYmluYXJ5IGlzIGV4cGVjdGVkIHRvIGJlY29tZSBhIHJlYWxpdHkgaW4gdGhlIG5lYXIgZnV0
dXJlIGFuZCB0aGUNCj4gPj4gYXN0MjcwMCBtb2RlbHMgY291bGQgYmVuZWZpdCBmcm9tIGl0Lg0K
PiA+Pg0KPiA+IFRoZXJlIGlzIGEgQm9vdE1DVSB3aGljaCBpcyBhIDMyLWJpdCBSSVNDLVYgQ1BV
LCBhbmQgaXRzIERSQU0gc3RhcnQNCj4gYWRkcmVzcyBpcyAweDgwMDAwMDAwICgzMi1iaXQgYWRk
cmVzcyBzcGFjZSkuDQo+ID4gVGhlIHByaW1hcnkgQ1BVIGlzIGEgQ29ydGV4LUEzNSwgYW5kIGl0
cyBEUkFNIHN0YXJ0IGFkZHJlc3MgaXMNCj4gMHg0MDAwMDAwMDAgKDY0LWJpdCBhZGRyZXNzIHNw
YWNlKS4NCj4gPg0KPiA+IElmIHRoZSBCb290TUNVIHdyaXRlcyAweDEyMzQ1Njc4IHRvIGFkZHJl
c3MgMHg4MDAwMDAwMCwgdGhlIENvcnRleC1BMzUNCj4gc2hvdWxkIGJlIGFibGUgdG8gcmVhZCAw
eDEyMzQ1Njc4IGZyb20gYWRkcmVzcyAweDQwMDAwMDAwMC4NCj4gPiBTaW1pbGFybHksIGlmIHRo
ZSBDb3J0ZXgtQTM1IHdyaXRlcyAweDAwQUJDREVGIHRvIGFkZHJlc3MgMHg0MDAwMDAwMDAsIHRo
ZQ0KPiBCb290TUNVIHNob3VsZCBiZSBhYmxlIHRvIHJlYWQgMHgwMEFCQ0RFRiBmcm9tIGFkZHJl
c3MgMHg4MDAwMDAwMC4NCj4gDQo+IFRoaXMgc2hvdWxkbid0IGJlIGEgcHJvYmxlbSwgdGhlIHJh
c3BpIG1hY2hpbmVzIGhhdmUgc29tZXRoaW5nIHNpbWlsYXIuDQo+IA0KPiBJIHJlbWVtYmVyIGhh
dmluZyBhbiBpc3N1ZSB3aGVuIGRpc3BsYXlpbmcgdGhlIGFkZHJlc3Mgc3BhY2VzIG9uIHRoZSBt
b25pdG9yLA0KPiB1c2luZyB5b3VyIGV4YW1wbGUsIGlmIHlvdSBzdGFydCBtYXBwaW5nIHRoZSBk
cmFtIG9uIHRoZSBydiBjb3JlLCB0aGVuIHRoZSBBUw0KPiBoYXMgc29tZSBpbnRlcm5hbCBvZmZz
ZXQsIGFuZCB3aGVuIHlvdSBtYXAgaXQgb24gdGhlIGFybSBjbHVzdGVyLCB0aGUgb2Zmc2V0DQo+
IHBlcnNpc3RzIGFuZCB5b3UnZCBzZWUgaXQgbWFwcGVkIGF0DQo+IDB4M184MDAwXzAwMDAgd2hp
bGUgYmVpbmcgYXQgMHg0XzAwMDBfMDAwMCAoaXQgaXMgYSBidWcpLiBIb3dldmVyIHRoZQ0KPiBh
Y2Nlc3NlcyBmcm9tIHRoZSBhcm0gY29yZXMgcmVhbGx5IGhpdCAweDRfMDAwMF8wMDAwIGJhc2U6
IGl0IGlzIGp1c3QgYSBkaXNwbGF5DQo+IHByb2JsZW0gSUlSQy4NCj4gDQo+IE1heWJlIHRoZSB0
aHJlYWQgYXJvdW5kIHRoaXMgaXNzdWUgd2FzIHRoaXMgb25lOg0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsLzIwMjEwNDIxMTQ0ODQ2LkdJNDQ0MEB4ei14MS8NCg0KVGhhbmtz
IGZvciB5b3VyIHJlcGx5Lg0KQWZ0ZXIgUUVNVSBhZGRzIHN1cHBvcnQgZm9yIGEgInNpbmdsZSBi
aW5hcnkgYW5kIHRoaXMgaXNzdWUgaXMgcmVzb2x2ZWQiLCBJIHdpbGwgc3R1ZHkgdGhlIHNpbmds
ZSBiaW5hcnkgZGVzaWduIGFuZCBwbGFuIHRvIGVuYWJsZSB0aGUgQVNUMjcwMCB0byBib290IHN0
YXJ0aW5nIGZyb20gdGhlICJCT09UTUNVIChSSVNDLVYgMzItYml0KSIuDQpUaGlzIGlzIG91ciBs
b25nLXRlcm0gZ29hbC4NCg0KSmFtaW4NCg==

