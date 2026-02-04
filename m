Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAD9E83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8z-00061S-1m; Wed, 04 Feb 2026 02:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZG-0004bo-OY; Wed, 04 Feb 2026 01:40:50 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZF-0004HR-0W; Wed, 04 Feb 2026 01:40:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHy5yQr14TD8YTtToL0xkwuLBGlzxqWYloxerfyxP3YhbR7jJXa6wiUYAzSUJw9tkxMmb9zIBw9v07UuU8oG5flvr/qZOarDUpywuBAD25gHG7ci726LIv6NqKZFJ1o3R5SUjpFdkdYrPQtQzRxOZhGav7Oqy+0VgaVfng+X+4VTg5iyBu4RYCuJGMByvaGveUQU6pgLnvO5gQX6mVufKoLIbXPKZFhW7PEaDPYNoVU1DeEqosbpGKNZ07F67UJLDmmta3Z5FbhgpxUI35U1hyFgJSd9jto7Qn0rU1HIZsCFZApM1HcAeVGA1F6QxhbZfY6XeBRhHu/yHH+zY6cEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFRwfk54CGxzy7JC71HBDhEd3EWKUg1rsO0nzUW9IOY=;
 b=tow4YEW30XtPBrfd4//COqOmhHNHdAmp/tm4cckY//glS5lQjFubGlEPye8sBdjHl7rWn+rYljAnGAUDlIBBv5C04+SVSuEoX9SMhB6JTsdp93dxVg/0GpPf6goieiJcXlM8veTyIib7uZAv1ZnrzPAcbPm3Dg9bzZ99Y6ZzTLh6SAk4jLhYDjmBQWgdDmy0IAvpUN6bJbkr8YwRgRjhbkxRRJaDMt6fwCnfvNJtzganGRIAKqM9PBfZ8ok909p86QvwfIEolunV/Re6Wx/Sy0l+pZaxXcSPxnABpuJEZBo64D2mdJQ7W8GR3DRLcAmDduJLer0JR1bnsfxVWoCsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFRwfk54CGxzy7JC71HBDhEd3EWKUg1rsO0nzUW9IOY=;
 b=fYMUSKAbaOgBeABa1FtD/Jd9bcC+O5c6jBl8dWE053jbKR49J5fPt1Pd0annq9BUGJ1GZ2Z4zC0823JT2lfgaIOczw/SlAN1NSBi3xqiYr9MTs8nHumaiVcMkgdRXyJPE15WY5Xt50pyCDE2pxYSLKABsplpzJwGw3YXbSt+8B0D2R0v27vMimvVO/BEhEBzdzlnNsz8uq51/zGuOhuu1zsNN7cV3ncP+a5Il7IV0n7t/7dWfbMhn56Lt3Wyshrq5sHV0IJtvua0EC4/eCOpOZ0WJDI2ZWE31B1r0eZmBYhQtfrVQ9RSxGU9bUazBuumDdOh8ADyCoSegL+n+unbTg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:33 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:32 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 11/22] hw/arm/aspeed: Attach ADC device to AST1700 model
Thread-Topic: [PATCH v6 11/22] hw/arm/aspeed: Attach ADC device to AST1700
 model
Thread-Index: AQHclaEpykj3RjKi2EuKmzWoL8yu8g==
Date: Wed, 4 Feb 2026 06:40:32 +0000
Message-ID: <20260204064016.3515639-12-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: b1a26c32-9a65-4679-1291-08de63b84bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MnQyRXJNMzczekJZQmY0aHE5R0VLbDNkNHpOeWcyOVVCTm83elY2aGJiSjJC?=
 =?utf-8?B?bmtKRkVRT1p5RlVxL0tqWmdZTG5ScHU0dUIyb1lqL0QyRU15ODBUS1FPeXVt?=
 =?utf-8?B?WFJDVXhCMkdUOEJ3c0NkaEozMFl0dU1HLzhxMTVCcXBZRS9NTW5zNlc1elli?=
 =?utf-8?B?TEVKSm1IcllMYU8rWkZVSGE3eVY1eEw3ajZpbW9wTnViMzBLQ2NielJUWWcy?=
 =?utf-8?B?SFo0Mk1ZS2dIbjd2YkhVdkdBU0pWdVlFem0yTDVwVEpMY1lQZXZ2dW9McmRB?=
 =?utf-8?B?RFZnR1Z2S0dud1lzcThaamJDcHpSVWhUbjlQcUhqSlVpaEs2eldqajJIVkFt?=
 =?utf-8?B?NTRqWVJkeURCTUl5VEtCNGNwTlRFUUJLZEJMclFWb1hteW9NeGFmdlJzTXhF?=
 =?utf-8?B?NHZjWGM0QnpwdVpmMHpMNkJhUm5EbXlpMkprSzMvYnhRbmR0a1dpTHBTZGJ5?=
 =?utf-8?B?a0tRekd0NEdIU0xUdzlYYmEzY2ZnZmgyR0xGNEhjS3BWeTRUaG5uS1NGQlc1?=
 =?utf-8?B?SVBXUndhWTh3VVlZdjdteGhoVVRUUjRFUFozTmtBdE4xY0lVekV2a21PNFIx?=
 =?utf-8?B?dTVNZGx5eG8zalZKeFoyZnZpa0NSVmdRNnJKUDByaFdrdTU5bG1pMkNDWnpw?=
 =?utf-8?B?Y0dUQmxDamtFaVQxcldwZHdoTEFEdmxrVUZReWgxVnBPQS83WndPOUxkRDdD?=
 =?utf-8?B?NGZ5eHo3MnBzMXlyTGVaRkE5c1J0c1BXSWVBVkZnVnV1ODhXeWxYSXRPZWJj?=
 =?utf-8?B?SHl1WSs1SFFDTXJZVUw4OXlZWGV3SVYyS3V1RzNZNG5CV0picGZEYXk5ZjYr?=
 =?utf-8?B?UENTb3JVUzg5UGs4bmo1Lzl2TjVqS0I0dW43UWV2SHVld2RVcGdYN3FnSU5s?=
 =?utf-8?B?MzEvTlZSU3JmSHhWalorUnEwVDBZeGZFb05teGVMREhWaEtsWE9hc0R6KzVj?=
 =?utf-8?B?ZjcyWFVVVWF4bUgxTkdSeFVjMUhvT2VSV01SNWR4QXY2ODZ5cUlJaDFDd1lN?=
 =?utf-8?B?T3BRWDRxQ2NLSXBYOG4wL3BybWlvbk92ZzRpSlNjR04zQUV5TFJ0WXRXeDFr?=
 =?utf-8?B?Zm5UUk5BUFJ3bDhtRmtRNmtuMmxhQnVOWUV6OEJMbmhUUDhzWVBJNitFdWEy?=
 =?utf-8?B?NTBlNE04bWdoMU5uQ0ZlZlh4L05DRlZ2YzlCb3pKVlR1L2hPZzFhWm1NZGN3?=
 =?utf-8?B?bVpTdEw0RW5FeXI3YWtCMkpjR0NadnM1OHR0QlRGRklpUW81RWVTWEhFeVE5?=
 =?utf-8?B?bFlqNzFicTB6Y2F5dHF0aHJJTHRxL1lXeVozSmdqVmdaaGdzRzFOUVJwR1VF?=
 =?utf-8?B?Qlg5RTAyLzlUZG1vK1ArVzVsZ2FzUUJzcldZZGh1VUFpSGpnMHl1UHdyL3gx?=
 =?utf-8?B?VTQwSkx4dkIzSG1sZ2dTa1IvOHZvbHFZTEdoOVhWdUpzUkx6YXpPQVdVdzdp?=
 =?utf-8?B?MFV4TCt0OEljZHFFclNhL1ZiL0pSSEtsd2luR0VaRkt0RDI1VWpjODVKMEhW?=
 =?utf-8?B?bGN6d1EzZnRRemZzS3ZVZkZRMkF0MWIva3JDK1B2SW5ZYTVDb1h3UFdKT1Nj?=
 =?utf-8?B?OFc0SW9qSUUrNHM3M3dJVUM3VlBhOFY3STZkMTdjUWw4bnRaKzFRK2o0N1pJ?=
 =?utf-8?B?RXRQUHRMY2szS2FmQWVUNVFMeGJUTGNXS201K2dhZFJTd3I2Q1k5N003MkFm?=
 =?utf-8?B?SHh0UmNob1NVUldHMldVSi80VkVwdzNqOVhnb0ZtUVdWWnU0YStBSDROaUdG?=
 =?utf-8?B?SFhlZ3RCSTBiMGprdnJGRVh2YnZ5U0h3TmRmZ2pjRTNRSThlaGdLbUdWU2FD?=
 =?utf-8?B?U29hckRFUi9aTmhlNThBcUlKOXFDUlorQXArcWhXTUw5bm5kUlZTVjNwcUFC?=
 =?utf-8?B?Z0E0RUhqUVR0c2U1TGdRNFJaLzlyQ2xHdTFjZlA3eEJQeFNoTTdyV3ZiS3ZL?=
 =?utf-8?B?bWZFOFBIRlBjaHB0TUhrSWRMRmV2MzFrNXJFS0NrVVhyTDJodWJ1N0J0VE9v?=
 =?utf-8?B?a0RNSFRaTGYrRjFCbmFrSlZsR0RDcXRtVE9SQUJvYytnVzhSNjFmV2wyYjJ2?=
 =?utf-8?B?bjlvODgwdnRnM3hVcXN4bWNkZTBtOHlCZ2RmTkJmanRyQ1FQMloveTNGYnlS?=
 =?utf-8?B?dGo4b0FkZnlKOFgxMFFNaHR4OUROYkIvYUVMeTV1R0hmT0F6ejRrWG11eXo2?=
 =?utf-8?Q?i8kciUk8MgOVucAhDrkbAzM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckd1RWo3bFpnVHdDNk12RGNETHcwOTF4R0JWR2xaZXpZdm5xU2pkcFJjMjJE?=
 =?utf-8?B?dE1Za2dvQzlBd25DeS90aFNTS2dtekd6MDVUODVQU2tNYkxyeS9seFo2WUNm?=
 =?utf-8?B?eC8rQW94ZWRsaENGdVlqQnhzdFlBWDJMK0VIRVZmdXRsaCtNTUpjcHJYelov?=
 =?utf-8?B?Z3pDL2x0aDBURGNHQi9UZ0pXOWxtYU9DU0RNM2ZHVVZuTWZRM0hyWTNZUGJx?=
 =?utf-8?B?M2NDZVExVWJaa1hEdEVmd0taaVNyK3VRc3NrUERuQU5CODlldndVNGFjVldY?=
 =?utf-8?B?TFo2MmRwQmNyeGVHUFBEamxKdVgwSmdlU0VFa2wxZFZCYUdRYVVZYUJja1dj?=
 =?utf-8?B?a1JBVDNyOW5RWnQ3a2FBaFFzaUs0d2VKNGE3TlYzRkhRNmErazdBS3cxYTVq?=
 =?utf-8?B?QUJXUkl1WHJIcWRMYnVwaTlqenFlcGM3NFlqYWdYSFpGS1pNNXR1RktHUUpO?=
 =?utf-8?B?Rk1Ob3J0eG5GcTBzTEswWWNsOWpiQjAza21CZEN6R0EzcmhkUmVySUdrSG9y?=
 =?utf-8?B?eVFQTVkzTVFkRGxrUkNPVXdBdFR2Z2dZUzFJV1BGQzA1MG9XMURBQi9aeTBj?=
 =?utf-8?B?Z2hHSlU2L0NuWUNIZ1hlalFyZG9HZ0tJUVU1M3NUMTRQY3R6cGhjNVdHay8r?=
 =?utf-8?B?ejZhQU1ZQmk5SWhhY0craWNLVVFGZEdGU0d4TVo5c2hMMzkrOEppa2tISHhS?=
 =?utf-8?B?WVdML2xlNWJHbmNXR3dxUE02N0pwUDhYL0VyRjE3MVljeFhKcDZ3MEMzUkhy?=
 =?utf-8?B?bGtWek1KY0Jva2luUEx0enRZM1dFYWlmdVI3OGhtS1J3QjNIenFBbDFmaUZN?=
 =?utf-8?B?cFF1VjZPcTAvQlJUQ1d6d25COEVPRW8xSVQyQUtFbUxKUWJNbFRQK3dobzU3?=
 =?utf-8?B?VlZCTVNJWGNyVXFhei8zN0p4N2VLalljbEplNW5LY0VlaW01NjZwZDF5WGY5?=
 =?utf-8?B?TW5lT2Fzb3lnUEJ6Z0JKbS9ncng5QU1XV3Y0czRSZk5qN0F3SWdIQ1hRYmNC?=
 =?utf-8?B?dWhwbk4vNnBtTUxrQnZ1c2YrazdnTGI1Ukx0aFdYbFdvS3J4b2crQVJYejA0?=
 =?utf-8?B?TlZYaFVkLzJwSThtZU45anVTMEdablc3dldaSmpDMlYvOWtYL2hwQTE4cDQ3?=
 =?utf-8?B?eTQxRUU3N1NnN20vTlBkNnBJRGU1cmdtSnhxS3pXdUFIeHNwRTFGdXZrcU1I?=
 =?utf-8?B?VTF5Q0k5V2pUeUN2Slk4eDZXd0g2T0p3Ymd4bUtOTHFKcG1LUzJuRFh6emNM?=
 =?utf-8?B?dk1oWDZGMm4zU0xsbnRWZnlzY003blpYWW1Qd1Rrekl3QXBHeWc5UXVCcFVJ?=
 =?utf-8?B?V3hNMXlNL3g1akt2c0dlOUFYQ2VkWFBJNXNrdUxncVpiOGdZNlVJdlYyWGNP?=
 =?utf-8?B?ZEpIQ1U5YmdpK3BmZFI1K1g4NXdYai9KdEhiN3ZSWGF1cEhDY09kbFdkQkxN?=
 =?utf-8?B?Yno1dlpTWnRqL1N4SCtMR2JEbDM2MHNHRFZTekN5QWFwb1NEMXlFbWJhWTZ4?=
 =?utf-8?B?ek9SSENla3d5MFZPTlA4Wk1jU1d1WnhWcXlCZkpBSExuZDZ5OEFYZGUyVHVT?=
 =?utf-8?B?WmpqTE16V3orSEhSM1B0QjUxN3dxSG5Pa1J2ekpvRXF3YVlCaHVBa1RrRGJk?=
 =?utf-8?B?L3kwSG9BR1haVXZNNE9vK2hWcnZwcEQ2aWFZbjNUS1haaEV2dmI1cXc3bXZI?=
 =?utf-8?B?eW84b3Vzd3RPejdUaFZvMzg5OTRHVVBCbk5qTFAwTWJmU0R1SVhDU2pGa0Np?=
 =?utf-8?B?anpQU1dYQzFEZlFESUg2Q0M3M1FtWktackVRTCswbXBpckg3VU9zY1hiM0dj?=
 =?utf-8?B?Z002cSttbFRUSTNXa3pkaWx4SDBPVjlPYmZQRlFSMnYyT0N2L0hxVFU0NTVN?=
 =?utf-8?B?NXl2VFY0S2thOVhuUlFWbEhqS0tuZWZnUDFCMEd3MGV4UTBZNUpZZG4rUGt6?=
 =?utf-8?B?Y2cxRVZBOC9lSG5hY2pYR1BwakJ4a3g4ajFxRWpzb2hjczUrVFBSNzJzNEFo?=
 =?utf-8?B?OGtWTDkrb0wyUVllN3YyZUx6bG5YTjBEQklRMy91V0lkc01RdXcyUXdrbWZK?=
 =?utf-8?B?SHhzT0V3OXREUlpHaks1TUN3clRWejdHdkR3bGhUUktHZWszV0JvMEl2QnBF?=
 =?utf-8?B?dlp0eUtlOVM2Vk5mZlVTR1Z0SlZ4UXI0MEdoQzVxd0hBeWU5Q0Jpdm5wSEh2?=
 =?utf-8?B?bCszckxMTnlYcjV6TFcrZDRyWEs5UzFLeUxYekVIUm80WjZhRXBmOVp4UkEv?=
 =?utf-8?B?eFAxSzkvSkRXNlJmdlVFVXlRMEpjU2VmcEQwWkxaSEdoUCt3MDZ5WnVXbGRK?=
 =?utf-8?B?ZnJVUnR4dGl5cHh0a2RiYUNsSXNweWZiM2FNSmJYck5sRkdwdTdJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a26c32-9a65-4679-1291-08de63b84bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:32.8806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bo2usfGG6FMK/phCPz1nQ5aHtbHFQR3+vw69nlMSzowjyC6tOdgUFC3PXndIOe+1Vpsv44iLmsq7VvNyKcapF31iOk+NA7dIITVqVRxE9b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:20 -0500
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

Q29ubmVjdCB0aGUgQURDIGRldmljZSB0byBBU1QxNzAwIG1vZGVsLgoKU2lnbmVkLW9mZi1ieTog
S2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2VkLWJ5OiBD77+9
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZh
biA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFi
aWhlc3RlZmFuQGdvb2dsZS5jb20+Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAu
aCB8ICAyICsrCiBody9hcm0vYXNwZWVkX2FzdDE3MDAuYyAgICAgICAgIHwgMTQgKysrKysrKysr
KysrKysKIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAgICAgfCAgNSArKysrKwogMyBmaWxl
cyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9hcm0v
YXNwZWVkX2FzdDE3MDAuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgKaW5kZXgg
ODk1NjJlYjY0Zi4uNDQxNjU1Y2VlNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVk
X2FzdDE3MDAuaAorKysgYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oCkBAIC05LDYg
KzksNyBAQAogI2RlZmluZSBBU1BFRURfQVNUMTcwMF9ICiAKICNpbmNsdWRlICJody9jb3JlL3N5
c2J1cy5oIgorI2luY2x1ZGUgImh3L2FkYy9hc3BlZWRfYWRjLmgiCiAjaW5jbHVkZSAiaHcvbWlz
Yy9hc3BlZWRfbHRwaS5oIgogI2luY2x1ZGUgImh3L3NzaS9hc3BlZWRfc21jLmgiCiAjaW5jbHVk
ZSAiaHcvY2hhci9zZXJpYWwtbW0uaCIKQEAgLTI4LDYgKzI5LDcgQEAgc3RydWN0IEFzcGVlZEFT
VDE3MDBTb0NTdGF0ZSB7CiAgICAgU2VyaWFsTU0gdWFydDsKICAgICBNZW1vcnlSZWdpb24gc3Jh
bTsKICAgICBBc3BlZWRTTUNTdGF0ZSBzcGk7CisgICAgQXNwZWVkQURDU3RhdGUgYWRjOwogfTsK
IAogI2VuZGlmIC8qIEFTUEVFRF9BU1QxNzAwX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2FybS9hc3Bl
ZWRfYXN0MTcwMC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKaW5kZXggOTc5OTA2ODhmOC4u
MTc1NzdlYmI1YSAxMDA2NDQKLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKKysrIGIvaHcv
YXJtL2FzcGVlZF9hc3QxNzAwLmMKQEAgLTE5LDYgKzE5LDcgQEAKIGVudW0gewogICAgIEFTUEVF
RF9BU1QxNzAwX0RFVl9TUEkwLAogICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9TUkFNLAorICAgIEFT
UEVFRF9BU1QxNzAwX0RFVl9BREMsCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX1VBUlQxMiwKICAg
ICBBU1BFRURfQVNUMTcwMF9ERVZfTFRQSV9DVFJMLAogICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9T
UEkwX01FTSwKQEAgLTI3LDYgKzI4LDcgQEAgZW51bSB7CiBzdGF0aWMgY29uc3QgaHdhZGRyIGFz
cGVlZF9hc3QxNzAwX2lvX21lbW1hcFtdID0gewogICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfU1BJ
MF0gICAgICA9ICAweDAwMDMwMDAwLAogICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfU1JBTV0gICAg
ICA9ICAweDAwQkMwMDAwLAorICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfQURDXSAgICAgICA9ICAw
eDAwQzAwMDAwLAogICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfVUFSVDEyXSAgICA9ICAweDAwQzMz
QjAwLAogICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfTFRQSV9DVFJMXSA9ICAweDAwQzM0MDAwLAog
ICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfU1BJMF9NRU1dICA9ICAweDA0MDAwMDAwLApAQCAtODEs
NiArODMsMTQgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfcmVhbGl6ZShEZXZpY2VTdGF0
ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgICAgICAgICAgICAgICAgICAgICBhc3BlZWRfYXN0
MTcwMF9pb19tZW1tYXBbQVNQRUVEX0FTVDE3MDBfREVWX1NQSTBfTUVNXSwKICAgICAgICAgICAg
ICAgICAgICAgICAgIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19ERVZJQ0UoJnMtPnNw
aSksIDEpKTsKIAorICAgIC8qIEFEQyAqLworICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JV
U19ERVZJQ0UoJnMtPmFkYyksIGVycnApKSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisgICAg
bWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKCZzLT5pb21lbSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgIGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BFRURfQVNUMTcwMF9ERVZfQURDXSwK
KyAgICAgICAgICAgICAgICAgICAgICAgIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19E
RVZJQ0UoJnMtPmFkYyksIDApKTsKKwogICAgIC8qIExUUEkgY29udHJvbGxlciAqLwogICAgIGlm
ICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPmx0cGkpLCBlcnJwKSkgewogICAg
ICAgICByZXR1cm47CkBAIC0xMDIsNiArMTEyLDEwIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3Qx
NzAwX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopCiAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hp
bGQob2JqLCAiaW9leHAtc3BpIiwgJnMtPnNwaSwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiYXNwZWVkLnNwaTAtYXN0MjcwMCIpOwogCisgICAgLyogQURDICovCisgICAgb2JqZWN0X2lu
aXRpYWxpemVfY2hpbGQob2JqLCAiaW9leHAtYWRjIiwgJnMtPmFkYywKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiYXNwZWVkLmFkYy1hc3QyNzAwIik7CisKICAgICAvKiBMVFBJIGNvbnRy
b2xsZXIgKi8KICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJsdHBpLWN0cmwiLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5sdHBpLCBUWVBFX0FTUEVFRF9MVFBJKTsK
ZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMKaW5kZXggMmZjNTBhZjhiNC4uNTA4NmQ0YzUxZSAxMDA2NDQKLS0tIGEvaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwLmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKQEAgLTEwNDYsNiAr
MTA0NiwxMSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI3MDBfcmVhbGl6ZShEZXZpY2VT
dGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEo
U1lTX0JVU19ERVZJQ0UoJmEtPmludGNpb2V4cFtpXSksIGosCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaXJxKTsKICAgICAgICAgfQorCisgICAgICAgIC8qIEFEQyAqLworICAgICAg
ICBzeXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJQ0UoJnMtPmlvZXhwW2ldLmFkYyksIDAs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICBhc3BlZWRfc29jX2FzdDI3MDBfZ2V0X2lycShz
LCBBU1BFRURfREVWX0FEQykpOworCiAgICAgfQogCiAgICAgYXNwZWVkX21taW9fbWFwX3VuaW1w
bGVtZW50ZWQocy0+bWVtb3J5LCBTWVNfQlVTX0RFVklDRSgmcy0+ZHBtY3UpLAotLSAKMi40My4w
Cg==

