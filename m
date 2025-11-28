Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2830BD116F3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 04:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOqFQ-0001Ie-CF; Thu, 27 Nov 2025 23:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hdijk@accesssoftek.com>)
 id 1vOqFN-0001FO-J1; Thu, 27 Nov 2025 23:38:18 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hdijk@accesssoftek.com>)
 id 1vOqFM-0002r3-2I; Thu, 27 Nov 2025 23:38:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnYfTAPxCzRZrcU69AEYxA1xWFG/r2XnnlnkkqL45vWggV3QhV368C8k7LCCCimJ2m82LT5bujvXGglaLqpJAZFOE/vdOwyi2s1tcbPZmDDwVcgjOyDOf/EIKJQ27aUlDKc/1e/SRGCWoaxwr6onzpQLW2ujaGh158R6JVzcE4Z0ow+PoYOKX+gfpJPLzPBScwAEEJMbl/izktJDdjZy5gRpiOgh4IIPtuLjW4w+/jrFvxmRxVtkkghhbL5VCVvg4F4xzS0R/d6j7HxtWrRixk4/3VsCqSLXd/ydAVDdzzgUV5KB8RZenqXVsDRBd3eVrjFlR6FCH/rCtTF/yaw6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgsigMoVxhv1xDr1KbXx7c7olwdjZa5snvXV2ipFI6I=;
 b=Tnn+133lTrG7XNEV2eobxSJRcTyA1th7Xl6L6lPvpmMW/zuLkyCJX77ee6yRtZCEMqmUVJHqFANzHWuXyIFUBKJMLKNmZ2EG0bgLhx21khS7I8o9kI2MfK8qFfFdXZdRWi/as/P8ZgbXYYZu/ViQj6YQ7W189EWvZtsD2h0CL717MIHjhn6uulM1ga0oKb2d8dMQCTMgLYEUGscUnbuhn2HkR21tvu8RkbRZw6qCEWjheTxbfEsIepogTBOdkNyJFXMRbB8Fk/jlblM6q0uVHOqY+O6PyWGwl4Npttj4ndITwBmMvlOuFDdktQOsEGSiDHH51V7IdLeoZn7UhZZjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=accesssoftek.com; dmarc=pass action=none
 header.from=accesssoftek.com; dkim=pass header.d=accesssoftek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=accesssoftek.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgsigMoVxhv1xDr1KbXx7c7olwdjZa5snvXV2ipFI6I=;
 b=MndrJZd0YNKBq9OSHgobcrPAVAUVBJYqQSP4HJ+JAsW7PYif3d9G8R7T8V4HAZY6+0LXpdtK4gb5JrXvi54vMxnz4jEMJJh8MaT6Y304yN4yMxUG7+kos7GxFIq4IQosdqOD/r3l4eM4Jap2Fk1KkF6uro3/ckiAMIuVI9heuaS1fDkMt2+poiH6ECsI7RoNJg349cYqC4yrCAH2woTvEmhVzr2Dk/P+k6A3In1p5A2dkcJZf+fSCFaKsslabmsu5UBYSq5m7bf6urrh/qa12XcZF6u6Xq3PYLDxArWGueDO/xdC4zwA4yxCG6hrlb3XyuvpK37sexKXejGgjdhDug==
Received: from PH0PR20MB6156.namprd20.prod.outlook.com (2603:10b6:510:2a1::7)
 by IA0PR20MB5730.namprd20.prod.outlook.com (2603:10b6:208:436::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 04:38:11 +0000
Received: from PH0PR20MB6156.namprd20.prod.outlook.com
 ([fe80::ae6e:9fbd:b45f:edac]) by PH0PR20MB6156.namprd20.prod.outlook.com
 ([fe80::ae6e:9fbd:b45f:edac%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 04:38:11 +0000
From: Harald van Dijk <hdijk@accesssoftek.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v2] target/arm: Fix assert on BRA.
Thread-Topic: [PATCH v2] target/arm: Fix assert on BRA.
Thread-Index: AQHcYCDN0HBeSm74ZEOZ2QuHsADr1Q==
Date: Fri, 28 Nov 2025 04:38:11 +0000
Message-ID: <d2265ebb-84bc-41b7-a2d7-05dc9a5a2055@accesssoftek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=accesssoftek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR20MB6156:EE_|IA0PR20MB5730:EE_
x-ms-office365-filtering-correlation-id: 9d076cff-b1b5-4b1b-8d12-08de2e37efe4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?T01tdjZob0JyMDMxNUxlWWVlZ2hDTGtLazFIV0V2dGpYczQwb0w4anNBeUdO?=
 =?utf-8?B?cDRZWVVQN256YnR0L3FrNjVsVHdBbndUR2dwckl6T1dxcTVVSGV0M1Vnbk8z?=
 =?utf-8?B?ckY2RlJ4aHBsOVNSbkVUTi9uTjVwUmRhMVVJd3ZJQXJxMWxab3d3USsyVFlj?=
 =?utf-8?B?SGM0V1hSRlZKTTVhMXRRRDZXQkU2U1Q1d3l4a0FzWXdIVmhsa1VOejFPY2tX?=
 =?utf-8?B?OWowb0pGMWhEdHBCNG1ER0s4Zm9oN0Jybm1oaXRLQjJRa0FaYlp2Q1k3WGtv?=
 =?utf-8?B?K3U2QjlRbmljMldWcWoyUmVXUXpKMVdVSW5qOWdMNWdPTUJPYkJBOW1GamNs?=
 =?utf-8?B?SzJRS0hZMU4xV0FOemU4RDAyUkRVajRuQWsrODBXbE1HZXVtb054ZldiNWtp?=
 =?utf-8?B?ZGxVWWF0eThlWG9FU2FRSXZQRCtNUUswbzVTakc3NFFBWjZ3bVovamdtck0r?=
 =?utf-8?B?aHE1dWVYUno4c3FBTVBpZ25oN2Vmc1h3Wm9BaGU2UWh2aWx2cVQ0UldlWFhD?=
 =?utf-8?B?VHFwemsxZ05IZkEwNjRCTGw1QnhjQWMxQk1ZT3VLcmlyZTgzZStJTXlkTWti?=
 =?utf-8?B?SUdtaUg3dlR1WFFvVU5ieDl2cjVJQnlpY3hBZ2lxOWlWdGhHbWJXWjNJeW55?=
 =?utf-8?B?Zm5WMmVwOFo5Y3VMZ3ZWQW1tMzdFU0xMTjB0ZnR6VzlMWUs3azRKdk1HSmFn?=
 =?utf-8?B?TWRHU1RyR24zeWY3LzJ0WWgydUFWUjdjUnFwMVVyWXZGWm1vY2ZGTStaUjJn?=
 =?utf-8?B?cXJ2V0llY0Izc1Mvd1dDRlZoTytxdHBNV1VhV09ad014ZzZIczJaQWkzZk5k?=
 =?utf-8?B?Y3lnQk92eWNJaVNndGpkeStSL2FkcUZHZldCV28vQVJzQnVKY2dubUZ3M25E?=
 =?utf-8?B?SDJ0YVZTZVNIb2diYnh3NlE4Tit5T0VlYWZWUkZ5dFRPQnViMGR3SmExbXVY?=
 =?utf-8?B?NlZnQjBKQ2cxaDB0dXNVV0RZcUMrVm95U2gwdGdNdEpzQzE0YnJGb3kzZjll?=
 =?utf-8?B?NjBLL21laVd2a0hrU3kvM1VTbWJXaW5JMHdFSGJWOTN4ZTJVWEYxOTlMcTRi?=
 =?utf-8?B?NmhDUmhPTlQvaDBNM2JIUktxYmtxYW5yUHg0aFV5ZXRVaXBUNkQwYUU5RldV?=
 =?utf-8?B?MFI5djI1bVYwYktKMW14TWNoSEdQL3pqTFFtbmdwWUFvViswdm5BWVJzaXVy?=
 =?utf-8?B?RjNobnVvMURZR3I0VXkvWCs2ZGRPdUptRk5pTU9nSndCSTlLcDBxS0pQWkNl?=
 =?utf-8?B?ZDdhRC9ycmVQM01NNmh6UWpUcmNXVlZRdWlUMisyUmJsUXVlNzhNU3BTVERC?=
 =?utf-8?B?K2tmRit1NTJ4OTNXVFFlNTZzRDc1SE5SMEFrT1RKcVBYQ2ZyRFU1VnJoZnpi?=
 =?utf-8?B?c1FJVFF4OU80bTc4SmN3bW5rMjh4N1pVVHhueVhjZERLQllyaU1rKzI5d2FO?=
 =?utf-8?B?VzhLcGhXY0QwbVgrRGhhbTJMa2Z4RG1laFZvVDhJbFozZVdDK0gybjJHaGxQ?=
 =?utf-8?B?ZUMreE9nNmNORFBNb1pyUDd5cHdzZHgwalZxMEdxVzZlQkVMY2ZjWjVHakw2?=
 =?utf-8?B?V1Z4bC9Mc0I4M0pkYXBkbCs0S3ZvWTNlUUhQVlpwZDgweVQyUUVaV29XWXlo?=
 =?utf-8?B?eXZMdFNIMnFYTWJzUEZBV3F4YVV6Vmc0aDlUMGZrWnF1ajJqTzFLRC8zS29x?=
 =?utf-8?B?ZXZZVWdQN1g1OXJmNmw5Y25KOWkveXV5MEQvYmlNMjVsMUV3UHVaYm9SZXNR?=
 =?utf-8?B?L094amxBdm9QN0VIMSt3QjFxSEpXL3lxVWl0T1I1UjRSTkJyRzJvRW5WZEZn?=
 =?utf-8?B?ZlRJRDAzYlVMcHVqZyt5MG1kb1Y0dGdDV3VIendLeHQxT3ZwY0VTMGZ4STBY?=
 =?utf-8?B?MU9BNTdZbGovaG1RM3lqTDlHUmZGbnRSczdsWnEvUzdRTWVTaFpTbTZkV0hw?=
 =?utf-8?B?TFN0UE9XdVBCdWhqTDVHcHV4L2pHMDJ6TDFxUmRVSGxDbm9XMi96WXhncFVr?=
 =?utf-8?B?a0NEamh2cDFzaS94VThleTFPdElVRlAwY25EdmZRaXAzVjZ2RjVWNFhCZUdm?=
 =?utf-8?Q?tA1s2j?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR20MB6156.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTRZYkY5aSt1ZVNja25QODRrQS9VaHQ4RFk5bkhOd25QY0NTbmkzNm83N3N4?=
 =?utf-8?B?aTVYTTh4N0haemF1ay9BRHZlK3VjdktvVkdINjZTRnRTY29JbVU2QlYvWk01?=
 =?utf-8?B?eGpNQ0sxaFJmOENBbEo2b0Vvaks0bVV4WDlsRTNXdDVSa0tZK0JGeTVhenR4?=
 =?utf-8?B?WkxiS21HQWhtK01PVjgvWGU1dEhCMkJ5eTVWSGgvU1VidXRmaWtGVXdaRlRO?=
 =?utf-8?B?dTlQeC9oalNYNTZFcVc1WE9TQzZTZFQrSm5kUk1sa2dGOUFONU5PdFZ1SVV5?=
 =?utf-8?B?Mnh5dW5zbCtnN21WZk5kL1VDS2ZDZEVoR3lJQ0xYclpwbFNaeWluUG5oWmhV?=
 =?utf-8?B?Y1diR1NmVklVbWcvQkpIWXk0TFBMVU1UcmJNdkUrcTZBVlZaU1ZITlVHRE8r?=
 =?utf-8?B?YVFHcEppT3pjT2o3cWFtZkJqdk1mWjkrM3VSZTBFWjlzcldLR09qT3lnMW5L?=
 =?utf-8?B?Q0V1cEpnTzd2cWhYZjdwUmdkQVpiQml0K1BpRXo4QkY0bjRibTVYSDkvMHUz?=
 =?utf-8?B?S0FxMDUrM0dKc0tzRUpndWdDVGJ4RlYxZ2tNNzJVYTFLdzRsejRQRVdRNEhk?=
 =?utf-8?B?Z00xZlNLK1dySUpiaDREODZ4Rk44UkNyWXVwaFdVYTZkSlFmNVQ1ZTNqcTF3?=
 =?utf-8?B?cnRVUWFFWW4wdkFnM0lDeVhQS3J1ZEFCNkpWMkt0N282ZkhRNjZGL0dHd2Qw?=
 =?utf-8?B?T2h3RFhrZ2FwdWVoSnZOT29hblZmZk1GVmdLQnAySGp0T0tZUlVtazUrUVM2?=
 =?utf-8?B?MTVWRjB1cUtiV1ErdlFDbDdYdWVVZElFNDRaVVNoSTcyVllnVnZmd1d6MWhR?=
 =?utf-8?B?RDNSaFduYk5ZWFVYd21QS3hVS29IWmQrR1Y5emk2K0NrV1BISlViMHNhaFB4?=
 =?utf-8?B?aUliREN1QlNmVDgzcUhTbHZXaGM2b0hHaStxQ3I5NUdsNTFlaWpnYUxrc3hY?=
 =?utf-8?B?TDhWRzNYSzBXK3dpN2tzWEx3YzdpckhmT3c0L0xyMTkvZjZ0U2V2Nm40aDR2?=
 =?utf-8?B?eDh0RE1zTlhGNFlhVWFGOGpVVGlCb2lqN1l6VFdubHMwbzVsSDVGbnlhb0lY?=
 =?utf-8?B?T2t5RGxwb1pCalVDUUpkbmNjOFF6Qk1hRU9SNFJyR3o1VFlVcWJSSnF0ajlM?=
 =?utf-8?B?N2lQRUtDamYycGhORVM5OVVYZzFiVU1PWjVQdnhSNzIwU3dOS1JqWDhwL3I5?=
 =?utf-8?B?cmMxZ1h0NndITlRwczBXeTNTVm9wSmhJZ0YrSzNRSy91MHhIT3NLbEVIT3Bq?=
 =?utf-8?B?bDVncXVHdG5TcEp0ZjNBY1RyOU8rY0tSYXE5NFF0UlBoazhNVzYwVEZ5TWRs?=
 =?utf-8?B?NDJIYmhtcXQwbldmRE8wbGpaVVpBRnBsc3VuRzE4dFhPcmZMd1hudGVyTXEv?=
 =?utf-8?B?a2Y0Sk9tckRMT0hRWDVITEhmbjltMHJMTThFOW5DNXpqVVRpRDdzUDhUVkVl?=
 =?utf-8?B?WW1qaWowQUUwVHY4MWJraEplVmd0NFNFSGUrVTAzZW9RYllIcnhEempnelBz?=
 =?utf-8?B?RHV2dks3Qk16WFB4SzdUQ0ZtRVcybkI0engwanBOVEQxVmRDRWpxQ3JFNU9F?=
 =?utf-8?B?bi9kMVVDV0c3R0ZrMkZVNjE0Z3JTZE4rd28xcVhlQVpHZEJFNXNHL3VPMXZ2?=
 =?utf-8?B?NTlqRThpUlZ5djBUWWFPMURzdFJ3SEFGbGk2RXZnMmU0aVdNZ08xQjY5L0th?=
 =?utf-8?B?dHNEUWxDZFc1K1FLcitRbi8vUGRXWlhScDJRUm1LSkMzcGovNTEwK1poNjds?=
 =?utf-8?B?YTdOR2VQUUZYVlczU2RRV0NFcHBkdUdkdEF4ZER3eWtGd2VYYU1SYlhsVkZ4?=
 =?utf-8?B?WWowRXRSY3p4dVE2dGNDZXhrbEU3bEduUkRoN3pTMmE2Zzh3SG10RGxDOGNl?=
 =?utf-8?B?ZHVtK3VVVjJwOEdmeG1uVnpBdDhCMi9lWDgwaUJabDJ4R3lrZSt3b2l4c1Er?=
 =?utf-8?B?RWQ3RG0rYXRWVlRQNjJMMVkvakFvSkg2Ymh1MklrQUlUU1Jsd2FiQnBlaTQv?=
 =?utf-8?B?R21NcW0yZUN2WFZicjZiREZVazVZaGNjUVJGVllvUG5heGVmUUVManRSalpG?=
 =?utf-8?B?c1FjOW9GZHkwN1E2TkdDZnFGTXgzUVN3a2VMN2R1bmFIeE0zenJ2czVWQ0pj?=
 =?utf-8?B?OCtudDdGVVZpcndKUkhXbGdJY3hxSGxoMXJyV2lRNE85MHNRdnZPdDArRE8x?=
 =?utf-8?Q?7qpe+t6jpT9MyXb7OWAS3Rq9aWhlxcfWYdIgq+DEVLyn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F49BF0BFFE27D43A21413888152A8D6@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: accesssoftek.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR20MB6156.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d076cff-b1b5-4b1b-8d12-08de2e37efe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 04:38:11.5406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c0629ff-77ca-4be4-816c-d880f9e12cba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlW7o4bpVN674skQOMAjRFFWvdoldrvCZrKdT5bn5wJdFTMy3y6wdzWeXQEEsAapSM+FbfAsa4XZiQNclv2ZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5730
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=hdijk@accesssoftek.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

dHJhbnNfQlJBIGRvZXMNCg0KICAgIGdlbl9hNjRfc2V0X3BjKHMsIGRzdCk7DQogICAgc2V0X2J0
eXBlX2Zvcl9icihzLCBhLT5ybik7DQoNCmdlbl9hNjRfc2V0X3BjIGRvZXMNCg0KICAgIHMtPnBj
X3NhdmUgPSAtMTsNCg0Kc2V0X2J0eXBlX2Zvcl9iciAoaWYgYWE2NF9idGkgaXMgZW5hYmxlZCBh
bmQgdGhlIHJlZ2lzdGVyIGlzIG5vdCB4MTYgb3INCngxNykgZG9lcw0KDQogICAgZ2VuX3BjX3Bs
dXNfZGlmZihzLCBwYywgMCk7DQoNCmdlbl9wY19wbHVzX2RpZmYgZG9lcw0KDQogICAgYXNzZXJ0
KHMtPnBjX3NhdmUgIT0gLTEpOw0KDQpIZW5jZSwgdGhpcyBhc3NlcnQgaXMgZ2V0dGluZyBoaXQu
IFdlIG5lZWQgdG8gY2FsbCBzZXRfYnR5cGVfZm9yX2JyDQpiZWZvcmUgZ2VuX2E2NF9zZXRfcGMs
IGFuZCB0aGVyZSBpcyBub3RoaW5nIGluIHNldF9idHlwZV9mb3JfYnIgdGhhdA0KZGVwZW5kcyBv
biBnZW5fYTY0X3NldF9wYyBoYXZpbmcgYWxyZWFkeSBiZWVuIGNhbGxlZCwgc28gdGhpcyBjb21t
aXQNCnNpbXBseSBzd2FwcyB0aGUgY2FsbHMuDQoNClNpZ25lZC1vZmYtYnk6IEhhcmFsZCB2YW4g
RGlqayA8aGRpamtAYWNjZXNzc29mdGVrLmNvbT4NCi0tLQ0KIHRhcmdldC9hcm0vdGNnL3RyYW5z
bGF0ZS1hNjQuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vdGNnL3RyYW5zbGF0ZS1hNjQuYyBi
L3RhcmdldC9hcm0vdGNnL3RyYW5zbGF0ZS1hNjQuYw0KaW5kZXggMDhiMjFkN2RiZi4uY2RlMjJh
NWNjYSAxMDA2NDQNCi0tLSBhL3RhcmdldC9hcm0vdGNnL3RyYW5zbGF0ZS1hNjQuYw0KKysrIGIv
dGFyZ2V0L2FybS90Y2cvdHJhbnNsYXRlLWE2NC5jDQpAQCAtMTkxNiw4ICsxOTE2LDggQEAgc3Rh
dGljIGJvb2wgdHJhbnNfQlJBKERpc2FzQ29udGV4dCAqcywgYXJnX2JyYSAqYSkNCiAgICAgICAg
IHJldHVybiBmYWxzZTsNCiAgICAgfQ0KICAgICBkc3QgPSBhdXRoX2JyYW5jaF90YXJnZXQocywg
Y3B1X3JlZyhzLGEtPnJuKSwgY3B1X3JlZ19zcChzLCBhLT5ybSksICFhLT5tKTsNCi0gICAgZ2Vu
X2E2NF9zZXRfcGMocywgZHN0KTsNCiAgICAgc2V0X2J0eXBlX2Zvcl9icihzLCBhLT5ybik7DQor
ICAgIGdlbl9hNjRfc2V0X3BjKHMsIGRzdCk7DQogICAgIHMtPmJhc2UuaXNfam1wID0gRElTQVNf
SlVNUDsNCiAgICAgcmV0dXJuIHRydWU7DQogfQ0KLS0gDQoyLjQ3LjMNCg0K

