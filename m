Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB091D2E02B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XXM-0000LU-0Z; Wed, 23 Oct 2024 05:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3XXG-0000KR-RS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:20:11 -0400
Received: from mail-tyzapc01on20713.outbound.protection.outlook.com
 ([2a01:111:f403:2011::713]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3XXD-0002Yy-Ox
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIR2Z8/WBhlU/oy7Jpnl25WE8rIOn9rpY8+6QBi/RhxUQYXeLhTnXb9jh42VsvE8qP24NADrBBfcJ2tKgEQMVAh5IZRddl4MPZPO67S4D2KGBrqFSbC/xe+SxqJFGiGSEypUY4bIYVrOgNXgKgZLtd1jWoos/ylRv2vwi1CqXK4QMS6NXl6BWYiBWsnMcKVuXGoCJ0FfT1LxSi+4XlRDltbGEKtRpZ+G5gVNxfH6xi6u+wE5tVuyziZXU5pA29WnQy01VXFKdEpmextZbXuGGnFtigdcQT90gglTp/H95klM01nQvcmnvfhcLov3fzLNKU2Xscy69RX9zOrVf/S0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqJ4fN8szsiFTiK2sPj/wFRPOK89XhcyILKff0oSeOE=;
 b=La14XRow1nrpd7YnVPFoYzxPqiZowyrCm6A9nzTZKZjM78dcHP5R2Jg+2xzJRS52JJw9kZFw02+5SHvv6xIDylcqqbvWpixnOUbYzTIqb2HZv9KgsjYPzp3sCbPI+Xiv8vU/1y3p4m08X9Z/aXSr6+liJ3RibaiLfCjTUp/e7pr96a6wMXUg+fUMHkr5Q4JstXX1Y7ylfTPcBNGHwkThCoky2Hj4pvR23HL3BrTLR77AX7v35ZpAaYSjMALfMu4gbDmaIWVNq29DCiUyiVpN6Cm4p+e+oQTVZzDIm/yHHTKKTpYyScCPXy5JD9+5PZAefxBo0TLakESy/qpA710HIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqJ4fN8szsiFTiK2sPj/wFRPOK89XhcyILKff0oSeOE=;
 b=IqqSCNyiqbTBE5zTAy9iK0X5b5mlIwWdpich80nBy/0tZR4ixJEvnHOiN8NpwY7a+zG+1i9poa+SAwiPtAFQL7skTnFiboK39+4nVKzg70lMwkgvP8MUQ4jbmDA6k/dh3tsi75l0meSKsJ/tHJkICsGxSFamWzSZfvkIJwV3FG0spwhzrOK9dfFgV4qIJHrwYXDKd4tXV6C91ZkO+gCdkM0/gYDhbpW9vzCijRGWvj+7aqA8ht/Q5Tb+dIDwYJH3msfqWpDaVBbrWKzFd9p4O08mDdTv5HMUNaOjRR4RudZXSIBCWbzBA/qeGt2HUQgNUe4bwqRGFAK9mnFjWz5foA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6919.apcprd06.prod.outlook.com (2603:1096:990:66::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 09:20:02 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 09:20:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Joel Stanley
 <joel@jms.id.au>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "kris.conklin@seagate.com" <kris.conklin@seagate.com>, 
 "jonathan.henze@seagate.com" <jonathan.henze@seagate.com>,
 "evan.burgess@seagate.com" <evan.burgess@seagate.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Alejandro Zeise
 <alejandro.zeise@seagate.com>, Steven Lee <steven_lee@aspeedtech.com>, Troy
 Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: RE: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Thread-Topic: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Thread-Index: AQHbG6AF47XTFA0rXEGHsN6P+pHCeLKCpmaAgAVDfrCACtEjgIAARfaAgAD4JYCAAAKEAIAAIihA
Date: Wed, 23 Oct 2024 09:20:01 +0000
Message-ID: <SI2PR06MB504160BC5547E56C9C108077FC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241011053825.361544-1-clg@redhat.com>
 <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
 <SI2PR06MB50412DF87611BDBC21003BF6FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CACPK8XfB=tfSBnPVUjJgAR23W3GXS_hxMiamPJT=7qL5Pgw8zQ@mail.gmail.com>
 <f7a8c0ed-27d2-4a0b-af2a-30f427812896@redhat.com>
 <CACPK8XdM-RrT4wJFEokD+mbYU_vus_Pwoq9kiUwpQbdM9WLVWA@mail.gmail.com>
 <b54e4ef3-2619-4c5a-960b-f57c4028e72c@redhat.com>
In-Reply-To: <b54e4ef3-2619-4c5a-960b-f57c4028e72c@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6919:EE_
x-ms-office365-filtering-correlation-id: 170c284f-8c43-4f1b-5ce7-08dcf343df74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U2ZtZi9EdFFOYVY2LzZlSDVkQk5mMUpGSncxNWdzQjdDV0VoS2NTTlhQK1A5?=
 =?utf-8?B?NzdFaExXeE1hSHp0bXExNTNpR3h0M0ozVTNjTmlBYVlEUkhQYVVuOVdnamVk?=
 =?utf-8?B?c3BYcHJsZTZhcmNpSTAxV1Jicks3eGJ5WXFyV09ybC9uSnBDcDZmeVVkUHNa?=
 =?utf-8?B?eWNhRTRzdGg5b3B2YzNZby9kc0VqYWpVRURJVDhPWjZVWk05bkpmdTBURWs3?=
 =?utf-8?B?ZGFoZHV2UzdweEoxZVR3Z3JTdGFsLy9JUWphRDRwRkQxSEdsc0ZvbDY4NDdB?=
 =?utf-8?B?S3podEVacTBOTDN0ZmVoL2FJbHpRM2RrZnhKUE45OVovQUY4cGJxanJYakFQ?=
 =?utf-8?B?Q1ZBQllNQmdVYXRQejM3dVZReUdkQzRGcXpTZTlPdGhqRGtNQUEwZWVxMGFi?=
 =?utf-8?B?M29uaVdUc1lWTkFhMkxpL29DekhSQXdiK0xXS2ovT2FDa2NHcUVXVFZBL3Zl?=
 =?utf-8?B?QmYvVVdWMHNYb3RTdmxMKytpWUZib1F4VUJZbWJXMGw1MG8zdDlNVCs3NmhM?=
 =?utf-8?B?NmlPRjJmai90VWc0bUZMM2FEZ25CQnpLaVVIMWZ0Uk04Qk84a1p5azlNOEkw?=
 =?utf-8?B?YXpQQjJqMVFBTEpYSmg4ZU1wYkZhUThrTGJVVzFIcUUyZ1U4YTVYaENSYjdX?=
 =?utf-8?B?YmpadGwvREI2akNTRFAxN2Fkdno5Zzd1VkRuejRyUzFzV2tBcWJYY3NpUVZX?=
 =?utf-8?B?cVVFSTdiZWUzUVRMYzdtMDBGOU9uc1dERTFzOThaeEpUQkE2SHdtWUVSRFk5?=
 =?utf-8?B?dzREbXYvYUVlVW8zVWdjQ0dTTHR6d2tjbm5RakxTdmdqUGpQUlZoZUl0aWFT?=
 =?utf-8?B?enhDOXpaV1FtMWJuU29tc014RENuOVN0SXZUVy9jT3RPbHM0K2YwcXlYOWNR?=
 =?utf-8?B?YWZ4b3hRVCtadTVxWVBwWjZtTGI4U2ZRK3dmaTJnYkRBcjBsR09XLzhSZlZy?=
 =?utf-8?B?Q1JSS0NTdC9laDZlSng3UU9MSWhuMUc5WTd1OXcrMml5a0FzcUpSN1BsUkZC?=
 =?utf-8?B?Nlg2bmFTOWFKRzI2VTd6eEZ3TTJoR1RpM1cvQ25vOGJReGo2UEFvZC9oSTZt?=
 =?utf-8?B?VTF3SFpFajVTWUcvVWFlcE9lZEtaUnFvNGNsemhMYjQ5T216b0RPZFZFT1ZB?=
 =?utf-8?B?WGhPV1p5d2lVRzdLUDQvOEprdjhLZjVHS3pwOU9ZR2VKb2QrZ2pFamlJUnMz?=
 =?utf-8?B?UkhoVkVabklWRndET0Y5SktBaE1tbmc5YjBSZE5JNElBRWYvRDE0cWlmNmF4?=
 =?utf-8?B?ZXpmQ21zWGlLUjVWbDhJVEMxaXZUYi9MbEl1d09wcERLZS90SDhnZ1BrTmg2?=
 =?utf-8?B?ekFDd01BS3VSb0ZzRmh0Q1lWYmtVMHNxRzR5T25PRHV1YXgxMlRsRjNUbUtx?=
 =?utf-8?B?SHlPdzRJNHdJdW5Ma3dUdTMrN1lEVGdFeFMwMmt4R1dTd2hNaDZnVFdvN0gx?=
 =?utf-8?B?bXY2UTdIWW1aSkhJdko1THQvWDZEZzdEQWNMQURxNWlJZnpwYUovK1lFallP?=
 =?utf-8?B?OTRtZkRta2FnOVZJV3BBSUIwWWdpVGcwVUZjRDFiaDZ3ZkZTSnFFRE83ZWY1?=
 =?utf-8?B?cVpWWmY4Ny9XZ2hlRzRjbHRITTZLUU5LVVR4WGZPVktETmVuZWY5TWNDNis5?=
 =?utf-8?B?VGFzNkJKRlM0UEwzNHZXemQ3WFhPNWlJYVBnR0hPc0hSR25xZ1RORHhVSDZw?=
 =?utf-8?B?S1ErTkhDNE5NcnpxTVBZUTVmL3UrRWQxclFNZzRHY2tJNUErWXF6V0d2N3lR?=
 =?utf-8?B?ajFaQ2FpdWEvYzFVN25KRUNKcUFVT1RQSUt0SDRsY29qS1RoYlJTNXVlM3Yv?=
 =?utf-8?B?bnhad3BpSUUrTDdXelgrZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cThjT2JrdmxsbmNjKzJ1My9JSU45U1NBTUpqdUlPM2ZEQy9hQWdNYlRVaVE5?=
 =?utf-8?B?ZjQrc09FSHNWbm1FTkR0MG4xS0xIMEpiR21RVDhxUk1PVVNZWmZRQ0ZVeWlR?=
 =?utf-8?B?REVRVEljMHNtd2pDTWJJS05JNVZNNGU3aGFzZzJidE5Ec0kxcmlUY04rcWlB?=
 =?utf-8?B?Z09WV1dqMlFYejFicEVNRDVBWFZmMkUzNlg5cVRENlZmR3l0bnJ5TitDUnBp?=
 =?utf-8?B?UU1iYWdkNDFPUmkvZkZTYW9uaXVFL2tyK0tveEMvRlcwWXdRaXVtSEF5ZXZp?=
 =?utf-8?B?NjR1b1l6aEI1ditHU2dtT3N2b0VicWIrRDc3WmRZTnM4bjd5Q040emNkalNH?=
 =?utf-8?B?M09qRHl6cVEwYlkvWEFpOGMrWGFSOUo5RnRiRFJrMldsTEllOGlGN1VvemNm?=
 =?utf-8?B?UG5kWkpTWVhFb1p3KytxZzNkOWRKdndDaWxOOFlYK3JRRXR2S0RWSUJMSDBS?=
 =?utf-8?B?bVRJWDQwcHdPZ012bmRKaG55eUx4QVJaL3VqclZEbnJ4RzdXcUxmTFp5ZC9U?=
 =?utf-8?B?MW82RS9Vc1gxNkI3aGJJRnZST095aDZkY2xnamlFcXVuWFc5Yk5rUVJqNFg1?=
 =?utf-8?B?dTFSb2M1MVNXYXhQTmFqK0JXQmVKTUs2REJEdTFrNkFCNnhIaGN0cVhkUG14?=
 =?utf-8?B?TEpCSW5tekVaTS9RRGtOMTBqazB1RWVvbDB3bkR1YTB4OXFLZ0J0STBQT2c3?=
 =?utf-8?B?aFFFZkhieFd3bHU4NFBlS09kLzhpN0VmcC9oMlluTitiK2tHL0lKaGI0RHdi?=
 =?utf-8?B?ZmtRaWIraTVlVEEvU0VwVi9OU3JBRHZjV2dOeVZaQ21NSndSN0F5RUd2alA5?=
 =?utf-8?B?UllMTU5LcWhXak9MSjlLeVZWckUzNHJ0MmlvVXNuS2oreW0wQjZKaHdzUDli?=
 =?utf-8?B?ZW9JTnJTM2hucnVLZU9hTmZ4MFBXNjFsd2V3b3pSUE5peFp6YjBJakhOSVEz?=
 =?utf-8?B?cjdjcUdTczNBd1VMWm14V2FtMXdXNGlCL1B0OGVwMTJMMmd6RmdYSFZsS1V0?=
 =?utf-8?B?ZlpkZFVGR055Z1FmZ3puS0o1WWZuVjNxazJHc0NqRTFzbTlVQ3hETXhVRXAx?=
 =?utf-8?B?OWpyWU1CUk56dFJ3ZmpBQ0J3U0NmdGtLMGxQd2RZK0JEZHhHOUszMSsvY21D?=
 =?utf-8?B?Zzh5bm5kb2I5OUNPTi9tNVUyc08xTXQ2VFJlaXJ6dnVMbzVZREovUzQ5RWYy?=
 =?utf-8?B?STFDZkhEU01mT1lhc0VHUUdzQWJldnMveEQraHRyRU9iTHo2R0FoWkpsRmJV?=
 =?utf-8?B?T1hPazVtUk40VGtQY243ZEtJUW4xeTZPVjFEWmdWZHVLems3di9qa0I5emkr?=
 =?utf-8?B?UFZxc3JWbTF2bnlBc3R2TDNXaFNiekVieGtZbThSZmtMa3I1S3B3TnN1eEQ2?=
 =?utf-8?B?ZjhNTzhuaWwwRndSaUZIZkxhc1AwZ0NBUzRaQ0ZZdlVmWHBld3l4R2pmazZJ?=
 =?utf-8?B?QTFCWlVPMG1YT1FURWFHMkJHK29ZYjhaYUc2Tm9rc2VRekZFOEpFZ3J4Q045?=
 =?utf-8?B?RTNLcnNOTzZEMGNYeHg3T1dhcGhnNWdlVGFoa3o0NjBDc1pSWFhBNU1pbkdG?=
 =?utf-8?B?VTNiU2RTYmY0ZUd4bWlyMGhvd1lkZ1dlWWZIRDBGS01JaDlVSTlYQ3U1SkRm?=
 =?utf-8?B?T2pGZm1uN1BmU1dvNnJjM29uTjRQenBzbmVHODd1UFFYWStiYTE5YWtWSkJk?=
 =?utf-8?B?TGhZanpjL3pCb3VyQmdXblFieWR5aDJnd044eSt6THFQVUFyRkF6bkJSZ0tt?=
 =?utf-8?B?WHJFL0xGZ25ZL2xrcVAwSmYrTWxhc1JYT2NSLzhSMjVlTnlVeUI1M1dPK2ZU?=
 =?utf-8?B?UDVHK2ZEVk1ZM2N1U2QrWGgydEFEMlZnN2lwK1lFUDJjYitsa2RDTEVIbjVW?=
 =?utf-8?B?eUlKTzJ1dTR2RnVwbWRWQ2VySzkxYzJCaVdZcWM1azR4dHRsNjFmNUZ3aDBy?=
 =?utf-8?B?UUxLMGpDSmR4cE00c1ZXdGtjc3JVUEJzajRWMFBsRXF1OXF5aEhsSnc5bXBq?=
 =?utf-8?B?cWMyR2hzOUtBcVRaaXRmYllFUjkrTEJlci9UM0VDejJWNGIxS0h6T1lZYWFv?=
 =?utf-8?B?NG52YnY3ODd4cnd6eXlQa0g3aTk3d1ZIQU1NMGJpZkZ6T09KSURJd3Z6c09s?=
 =?utf-8?Q?JSXSHaGYlD3x+m94umdl3TzQj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170c284f-8c43-4f1b-5ce7-08dcf343df74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 09:20:01.6847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2W0AhZglk7avXNwaBB34nw/KgCL4/KEY6pY4wApAzXrjMnb7lVrxJn/+aghH23VY89Zbr8slx879VfGng55mO9uKxnS0R4E8Gy/L/dRCLBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6919
Received-SPF: pass client-ip=2a01:111:f403:2011::713;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgSm9lbCBhbmQgQ2VkcmljDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Nl0gaHcvbWlzYy9h
c3BlZWRfaGFjZTogRml4IFNHIEFjY3VtdWxhdGl2ZSBoYXNoaW5nDQo+IA0KPiBPbiAxMC8yMy8y
NCAwODo1MiwgSm9lbCBTdGFubGV5IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjMgT2N0IDIwMjQgYXQg
MDI6MzUsIEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4+DQo+
ID4+IE9uIDEwLzIyLzI0IDEzOjU0LCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+ID4+PiBPbiBXZWQs
IDE2IE9jdCAyMDI0IGF0IDAxOjIzLCBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+IDMuIFRlc3QgSEFDRSBtb2RlbCB3aXRoIHUtYm9v
dCBoYXNoIGNvbW1hbmQgYS4gbG9hZCB0ZXN0IGZpbGUgdG8NCj4gPj4+PiBhZGRyZXNzIDgzMDAw
MDAwIHZpYSB0ZnRwIGFzdCMgdGZ0cCA4MzAwMDAwMCBqYW1pbl9saW4vMzJNQiBiLiBnZXQNCj4g
Pj4+PiBzaGEyNTYgYXN0IyBoYXNoIHNoYTI1NiA4MzAwMDAwMCAyMDAwMDAwDQo+ID4+Pj4gc2hh
MjU2IGZvciA4MzAwMDAwMCAuLi4gODRmZmZmZmYgPT0+DQo+ID4+Pj4NCj4gMWRkY2NjZGJhNzQy
ZDc2MmUyYjhkYTBiY2VhZjQ3Nzg3MjdjNWViYTU0YTI0ZDdhZTBjNTczYzY1NDE0ZjczNg0KPiA+
Pj4+IGMuIGdldCBzaGEzODQNCj4gPj4+PiBhc3QjIGhhc2ggc2hhMzg0IDgzMDAwMDAwIDIwMDAw
MDANCj4gPj4+PiBzaGEzODQgZm9yIDgzMDAwMDAwIC4uLiA4NGZmZmZmZiA9PT4NCj4gPj4+Pg0K
PiA4MjVkOWIyNGJiNzk3Njk1NTQ1YjNjYmQyZjM3M2I5NzM4NjI3YzdhMTg3OGU2MjA0MTU1NzBh
NTdjN2ZhZWQ3Nw0KPiA5MQ0KPiA+Pj4+IDZkNDcwODRjOTU0MjU0ZjEwMWZjMGYxMGMwNTkxDQo+
ID4+Pj4gZC4gZ2V0IHNoYTUxMg0KPiA+Pj4+IGFzdCMgaGFzaCBzaGE1MTIgODMwMDAwMDAgMjAw
MDAwMA0KPiA+Pj4+IHNoYTUxMiBmb3IgODMwMDAwMDAgLi4uIDg0ZmZmZmZmID09Pg0KPiA+Pj4+
DQo+IGI1YWU3MjViMmRjMWU1MjFmNDhlYWUzN2RkODJjM2Q1ZmM5NGY3YWNiNWZmZjNkYWJmMWNh
YTRiYjRiNWJjZmI0OTgNCj4gPj4+PiBlN2NjMWZiYWE5N2RkYTI2NjRiZmY5OWY5ZjhlNzc4Zjgy
M2U5NWFmYWY3NmZiZjA5ODUxODE1MjJlNDc4DQo+ID4+Pg0KPiA+Pj4gSSBhdHRlbXB0ZWQgdGhp
cyBzYW1lIHRlc3QgYW5kIG5vdGljZWQgdGhhdCB0aGUgJ2hhc2gnIGNvbW1hbmQgd2FzDQo+ID4+
PiBub3QgdXNpbmcgdGhlIGhhcmR3YXJlLiBZb3UgY2FuIHNlZSB0aGlzIGJ5IHB1dHRpbmcgc29t
ZSBwcmludGYgb3INCj4gPj4+IGJyZWFrcG9pbnQgaW4gZWcgaHcvbWlzYy9hc3BlZWRfaGFjZS5j
IGRvX2hhc2hfb3BlcmF0aW9uLiBUaGVyZSdzDQo+ID4+PiBzb21lIG1pc3Npbmcgd29yayBvbiB0
aGUgdS1ib290IHNpZGUgdG8gbW92ZSB0aGUgImhhc2giIGNvbW1hbmQgb3Zlcg0KPiA+Pj4gdG8g
dGhlIGhhc2ggdWNsYXNzLCBzbyBpdCBjYW4gYmUgdXNlZCB0byB0ZXN0IHRoaXMgY29kZSBwYXRo
IChvciBhZGQNCj4gPj4+IHN1cHBvcnQgZm9yIHRoZSBvbGQgQVBJIHRvIHRoZSBoYWNlIGRyaXZl
cikuDQo+ID4+Pg0KPiA+Pj4gU2VwYXJhdGVseSwgSSBhdHRlbXB0ZWQgdG8gdGVzdCB3aXRoIHUt
Ym9vdCBieSBlbmFibGluZyBoYXNoDQo+ID4+PiB2ZXJpZmljYXRpb24gb2YgdGhlIEZJVCBpbWFn
ZSwgYW5kIGl0IGZhaWxzIHRvIGNhbGN1bGF0ZSB0aGUgY29ycmVjdA0KPiA+Pj4gU0hBLg0KPiA+
Pj4NCj4gPj4+IEkgdGhpbmsgdG8gaGF2ZSBhbnkgY29uZmlkZW5jZSB0aGF0IHRoaXMgbW9kZWwg
d29ya3MsIHdlIG5lZWQgdG8gYWRkDQo+ID4+PiBzb21lIHRlc3RpbmcgdG8gcWVtdS4gSSBkaWQg
dGhpcyBmb3IgdGhlIGluaXRpYWwgdmVyc2lvbiBvZiB0aGUNCj4gPj4+IG1vZGVsIGluIHRlc3Rz
L3F0ZXN0L2FzcGVlZF9oYWNlLXRlc3QuYy4NCj4gPj4NCj4gPj4gVGhlcmUgYXJlICJhY2N1bXVs
YXRpdmUgbW9kZSIgdGVzdHMgaW4gUUVNVSwgd2hpY2ggd2VyZSBhZGRlZCBieQ0KPiA+PiBjb21t
aXQgZTBjMzcxYTBkMjNiICgidGVzdHMvcXRlc3Q6IEFkZCB0ZXN0IGZvciBBc3BlZWQgSEFDRQ0K
PiA+PiBhY2N1bXVsYXRpdmUgbW9kZSIpIFRoZXkgcGFzcyB0b2RheSB3aXRoIHRoaXMgcGF0Y2gu
IEFyZSB5b3Ugc3VnZ2VzdGluZw0KPiB3ZSBzaG91bGQgYWRkIG1vcmU/DQo+ID4NCj4gPiBJIHdh
cyB0cnlpbmcgdG8gZmluZCBhIHRlc3QgY2FzZSB0aGF0IHNob3dlZCB0aGUgYmVoYXZpb3VyIHdh
cyBicm9rZW4NCj4gPiBiZWZvcmUgKHNlZ2ZhdWx0PykgYW5kIGZpeGVkIGFmdGVyLCBidXQgaGF2
ZW4ndCBoYWQgYW55IGx1Y2sgc28gZmFyLg0KPiA+DQo+ID4gVGhlIHRlc3RzIHBhc3MgYmVmb3Jl
IHRoaXMgcGF0Y2gsIGFuZCB0aGV5IHBhc3MgYWZ0ZXIgaXQuIEJ5IHRoYXQNCj4gPiBsb2dpYyB0
aGVyZSdzIG5vIHByb2JsZW0gbWVyZ2luZyB0aGlzIG9uZToNCj4gPg0KPiA+IFJldmlld2VkLWJ5
OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiANCj4gVGhhbmtzLA0KPiANCj4gPg0K
PiA+IFNvbWVvbmUgKGFzcGVlZD8pIHNob3VsZCB0YWtlIGEgdG9kbyB0byByZXNvbHZlIHRoZSBI
QUNFIHNpdHVhdGlvbiBpbg0KPiB1LWJvb3QuDQo+IA0KPiBJIHdpbGwgYnVpbGQgYSBicjIgaW1h
Z2Ugd2l0aCB1cHN0cmVhbSB1LWJvb3QuIFRoZSBvbmVzIHdlIHVzZSBmb3IgdGVzdHMgaGF2ZQ0K
PiBhbiBPcGVuQk1DIHUtYm9vdCBJSVJDLg0KPiANCg0KSSB1c2VkIEFTUEVFRCBGT1JLRUQgT3Bl
bkJNQyBwcmUtYnVpbHQgaW1hZ2UgYW5kIGhhcmR3YXJlIGhhc2ggZW5naW5lIHdhcyBlbmFibGVk
IGJ5IGRlZmF1bHQgd2l0aCB1LWJvb3QgaGFzaCBjb21tYW5kLg0KaHR0cHM6Ly9naXRodWIuY29t
L0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5LjAzL2FzdDI2MDAt
ZGVmYXVsdC1vYm1jLnRhci5neg0KaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL3Ut
Ym9vdC9ibG9iL2FzcGVlZC1tYXN0ZXItdjIwMTkuMDQvYXJjaC9hcm0vbWFjaC1hc3BlZWQvYXN0
MjYwMC9zcGwuYyNMNDYgDQpJIGFkZGVkICJwcmludGYiIGluICJkb19oYXNoX29wZXJhdGlvbiIg
ZnVuY3Rpb24gYW5kIGVuc3VyZSB0aGlzIGZ1bmN0aW9uIHdhcyBjYWxsZWQgaW4gSEFDRSBtb2Rl
bC4NCg0KYXN0IyBoYXNoIHNoYTI1NiA4MzAwMDAwMCA4MDAwMDAwDQpqYW1pbiBkb19oYXNoX29w
ZXJhdGlvbg0KamFtaW4gZG9faGFzaF9vcGVyYXRpb246IHFjcnlwdG9faGFzaF9uZXcNCmphbWlu
IGRvX2hhc2hfb3BlcmF0aW9uOiBhY2NfbW9kZQ0Kc2hhMjU2IGZvciA4MzAwMDAwMCAuLi4gOGFm
ZmZmZmYgPT0+IDY1MmRjZDc5NGFhYmNiZGUyZmU0NDgwMzk4YWQ1ZGEzOTE3Y2ZiOTBkMjZiYWE2
NDkxMGZjNGJlYTQ0NzE2NDYNCg0KVGhhbmtzLUphbWluDQoNCj4gQ2hlZXJzLA0KPiANCj4gQy4N
Cg0K

