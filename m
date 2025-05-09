Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AB3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHfx-0004cn-9J; Fri, 09 May 2025 02:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHfu-0004c1-D1; Fri, 09 May 2025 02:57:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHfs-0000pE-Fd; Fri, 09 May 2025 02:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKLsrqZDEckYaVe31++yWTx31f7KZfgJYrHtXiwMoFwb9L3WfN/9hauNcfu2OeId63ah8DiClM9sAtthUG+yPDwzuCpfvp8uyF0YY6U6fBVofGpB8mTm9Cb+PrVjI0hnQnwPH1sBcfgnNum5UVeUiscyVStzXOIXX789QArYjrLSL3TxHu2RZeUSPYbqON+7klAZgWeZ8DMCwQwEujEKo4htxiC/ikkZ/7G5lR9yXE2Z/4dgf5BlggpI0iWjibcuf8wXjJRQuC2xIrSTodmvv9k2jVuHUu+2Upac0AXKFwcRsn3BF0CKwcF+btPI7NZV8VeTd2kjaFiMpYTkSbDBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0BalzaPzhn6lh7uk9zPDtXGUva7ZPcwBvh/cV1i7hA=;
 b=J2SR32pe5pMieFURR06h7IvS6BifpowUs/kLVloMPWTjlppj3u7kUuU52ZpSv/sqgBjX2WUuEvMFgtLCpkGsYM+7T0i/SHk/R2ONGAOpgK4IhX9YaiPJJgeLtUMQKCKyxfIgLGtUe3VDRNd7U70yFEVoLhVNXI1VDTbN7yyQjHSy2gaqHPvKLR2GcCRva7M0O0J+4/nos2F3eYUzmN+gfjkMTYzVTTZSBtQaS1fQlyuSh8XotLqtzTU2Fbkjdzvv5OztDzqTPkBIFlJvLNO9rcBx4borBeqpYZnXThTkLPyxj6ZjAb7yFJa8IDHB1N2S4sn9++9V5u1CEYyWxklMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0BalzaPzhn6lh7uk9zPDtXGUva7ZPcwBvh/cV1i7hA=;
 b=MtT5EOxRM73127iYd4LaFXdtLsU4eM1JnHB0LtZVGK8t1RGXy28US4OrcJas8ehJph3mFkWP481CZDEM/rf3SggE6E+KkUDI0t0ZaQaQ3zg72T2z85MVEAjF5x8ZqVZPCnUU0mygMXtq5Rjx3n87/WOy5i+gGGsmH3UD7mC2rGAPTmqtOn6QDoXHEOMaygyxONG5+P+uftL2cGOktD0Q2Bd49h4/+oyOwKcEiY8DA8MdOP2986/SO6KoT5Gi2j3w7rvxmz1zpgUgK3P3CoU5dL3UGGzgrngeJIGMsGrGDKHVw1Rm5i1PBM8c0Fo78m+NuLMn16XsHwzvFRKPT6vadg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6445.apcprd06.prod.outlook.com (2603:1096:820:ef::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.20; Fri, 9 May 2025 06:57:28 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 06:57:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 03/22] hw/misc/aspeed_hace: Improve readability and
 consistency in variable naming
Thread-Topic: [PATCH v1 03/22] hw/misc/aspeed_hace: Improve readability and
 consistency in variable naming
Thread-Index: AQHbmkNTHXCajfX/xk+M/N0jZ2hHNLOO3G8AgDtN+4A=
Date: Fri, 9 May 2025 06:57:27 +0000
Message-ID: <SI2PR06MB5041AF7D7D325E3154F917A5FC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-4-jamin_lin@aspeedtech.com>
 <b6b0d7c1-4992-4ea1-ab1e-6cad29ae07c0@kaod.org>
In-Reply-To: <b6b0d7c1-4992-4ea1-ab1e-6cad29ae07c0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6445:EE_
x-ms-office365-filtering-correlation-id: 47b7b61e-e72b-4942-a74a-08dd8ec6c2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?ZldFcmU4WENtSHBDc2ZLZnVTbFpMeitxOHJXWFBYdHZPOTVvcGtIMS8zQ1dk?=
 =?utf-8?B?ZEcxMnozM2VubFNaN2o4a0swU2ZoazlsRDlBU0d3anNSeXg4dVJwT2I4R1M2?=
 =?utf-8?B?Nkw1UHpIaXc3K055L25KS2VzRUsrdHk5NEtweWJpWndXcmlRQUlqN2RWU1FZ?=
 =?utf-8?B?VUZPTWUxR25RT3lrNDRLd2VDTEZsT1hqSjd2RlNxa3Z0UlRzQUwxelpvKzhx?=
 =?utf-8?B?VDhWamdJN3pHKzJudkNUZ1dsT0M4OFN2cmEva0x5NW40ZWdGQUlwVStBWnJP?=
 =?utf-8?B?MWpPV0V2dmR3MmZyajVFNDNGL3VjOGVHcktOKyttUTR6clFvWlBzdGpqZGJW?=
 =?utf-8?B?WGc4aFo4WklzempVdVZmSHJJeXY3cUZYNVdtdk5lTUxyNEg2UDV4aTV2ZXov?=
 =?utf-8?B?YzZGcFgvR3V4VEVyNlAvR3pmNFhTeXdXMHFia2x6VTRmcVR5aWt3T01LeEds?=
 =?utf-8?B?dmNmcXpJeDMrdHRwSkUxUWFYRDUxNGdxNlIvSEcySU9vNk5EMFNPUHVVaEh3?=
 =?utf-8?B?VVB5N1ZDUW5Ec1dxd1dPTjNyU08xdXlMR0U2Y2pYYVVzRitLOWtLd3B3R2ZV?=
 =?utf-8?B?VjBPZE9lY25sVXdtMkdmQkxldEhsZ2hMb213MGlrS2RoWVEyU3F2emFhQlBF?=
 =?utf-8?B?NjA3UldYUlJnL29UN0tjbDBIWHFZbmsrK0hiUkZTSzd1SGU3SWRsMzVpK1hw?=
 =?utf-8?B?VmgxU1ZiWEptb0hwbTNFNGlsTzlwVFRuVHJScENEQ2ZEQjkwaThBWTJESXVV?=
 =?utf-8?B?TTF0TktLSTY4WVlhOEdrR1J4Ti9XTFVRVkNRRHBnRDkzaDBzcmlDK3RNcUVG?=
 =?utf-8?B?eUE4emxVd3ZVWnFaaXFqNEVnejh0KzNaSzU2UDY3aGpTMXhmdGhHc1NWSmVX?=
 =?utf-8?B?RndDTE9jUllzY2RWSHl4dnl5eXlES3RqTnNsQVg3Y3RFRkVvbzV3ZGFISmNi?=
 =?utf-8?B?Q0hoLy9hdjRrYW52blBreXV1SlI3OHlWVWd2Q0gwYWNsamRqK01scW95WWNG?=
 =?utf-8?B?aDh1V21oR0JXWkE1cDROemxHVVlnZHN0ZEFJTnlxNXI5SmZDNVdnRFM0djNk?=
 =?utf-8?B?V2xQUGdHaWdFNFIxSlpLazNIQVhBc3V5NU1mNHBocWZESnVqYUJpY0FGZGsx?=
 =?utf-8?B?YUpJMGpuZ2U2Q2xBNGZBdHhySUk0RjJWZE1XVndnZWdSeXFxRXZWb3RzQVVk?=
 =?utf-8?B?cDhUNk5aVmhvKzhLMkFsRzEvUnI0UUtQRFRCTmFDSHY5cXQvcTdhUjRISmo4?=
 =?utf-8?B?ZVkvclZaaTNCejZ1b3BPaTYvQS9ac0dQNkxmR2JNR0pRYmt3c2JVQWtxYlRh?=
 =?utf-8?B?c3JtUThwSS8zZEltQXRJVVo3dG0yQ1NNcERRWkdxd3YyblJiM1h1YzFhNGR4?=
 =?utf-8?B?ZnhTaVdnUEdEQ2tNWFFNZ2w4VVllUkJQTXpXaExROU9sdE5Wa3ZjQng0ME0y?=
 =?utf-8?B?VWVWL0NWSUJ6TmVqckkzdmVqbGNCRkRIbkpIaTN5NjVHSHZNcnRwVnhyK3pu?=
 =?utf-8?B?Ym9WUkdpY1B1UWxjaXRhMGp1QVFyQXJtYVpYUjhPaGkzMk80YVUzZ1V3K050?=
 =?utf-8?B?SEN1Q24rejRpTVU1UVM5RkZKUnp5S1Y3R05YOW5NTStSMWMvSEtwbUxXVGhp?=
 =?utf-8?B?UWtCcmxBYlBGZms0ZEpwM0JJZW1BVGRSa2VNd3lrUkpaTzcwTHljemExS1Vj?=
 =?utf-8?B?RGhJdVRxWXFScDgrVjRYaSthSERtemJPRTg1SjZlS290ejliZDhWTVZKSXds?=
 =?utf-8?B?YUxQR0thbXdVUlVvTG9vWEMwbng4OXVRS1NXYTdWalpFYnV3MHVKOVZDQ3c2?=
 =?utf-8?B?algrSXBMK1JSdkNyN2JmY1l1K1hZRklTK2tzaEh0NXRFY0hQODVEcmxUWTM1?=
 =?utf-8?B?cXlqdGViaWtqMWM3YnhNbVZGUk5xYmZ3SDZqTmxDZCtMTkNBV1J3by9ncVRi?=
 =?utf-8?B?NVdBY1hGL3puTXhzcHhLemZJTnVjYXJqVnV6S3YwaGhyL29PNjh1dFZQRFdo?=
 =?utf-8?Q?zYD61uEIPILt6xZuenVhY1YhyaQZzg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bENzakptMEswRG1kcDdiVlI1OEJxTk5nTlg4U2dWOXlKWHdoRlFaTkpSWXVP?=
 =?utf-8?B?RmkrYW5Pek9icm5pTUxKS3ZBbEdaSXBCcDZjMUI1cFh0TldVdzVFb3A4Z29q?=
 =?utf-8?B?WlhVQ0k3TEVYb2NoRlB0R0V6T3RvclB0Y3J0YVFzMklyNW9iL1dsL2NaZ2Jp?=
 =?utf-8?B?YW9vWnk3VGJscE93TnlhcE5IK1VueElFV2k3MGFVMkpuZ0xJKzk4amJWRWNz?=
 =?utf-8?B?OFY3dE5pSnU2dzE1cGh5Y1BpRmRRT1hIT2NNN2lkbnJ1dEdJRTJ2YWQzaTZU?=
 =?utf-8?B?MU9BRG43T29nN2R6QTU1anRocHA0UE5RYnI3UDh3c01CYnNDMFpJTTlTOHYr?=
 =?utf-8?B?NXhJcmhKdHRYTlh5Ym9NOEZVQWw0cmdyb00vY1JsMklXK3VlUXBjUkxnRzRE?=
 =?utf-8?B?ajR5SndZR2NhODBTeXZNcnRRdzdraHNaSXJObHlPTUdTLzRTVzMzdlJXMGIw?=
 =?utf-8?B?YnBrUTh0WjFzMHJzbU4wVXdJdWFuS1N3dVdWQlYvTDh5MFVYMnM5K0xieUo2?=
 =?utf-8?B?STFNeU1YSmJIYWE5NFFpeUpWMGREZktBR2VZL2EyaXFieVcweFk5dVVleGVx?=
 =?utf-8?B?OCtRdmd6QUpUdjlmUUZ3VFZyYlhGRnZ5RXREbE5EVG5ick5GRzNXNlhKVHJC?=
 =?utf-8?B?dlJ1dnFkQTRVMkI0ZCtNcFZTcDd4aFBUcHJVV3VlUW1JRC9yYWhhQlhFWFVM?=
 =?utf-8?B?OWhKMlNwMkdockpBVmxkdEFQWHFHUDNNSnA3OUR5Mm4vRWVRWFlBSlhGNllk?=
 =?utf-8?B?VlFRelNqSmZrU2lrdVl6Tko2VCtwa1Q4S2ovNFZKdUdpWGdSNURXdGorL0xo?=
 =?utf-8?B?VU05ajNaWldhUXJMN2Q3eDNPVG1vRnZSUEQ3aDZhZlNGWlh3QXdmMkhnSTdD?=
 =?utf-8?B?ZE1jV0MrN055aUlydEdEZ2FaOUk5eHhLUk1RSktUM1VFelE1V3B1Z2lFemR3?=
 =?utf-8?B?NEpSd2VHZ012S0FuS3Vid0hsVzUwUnFScmR1alRXUzl6TEZsVUxDdzRXZ3pO?=
 =?utf-8?B?d3M1K3dDaXBVSVNQaitqNnIwakhBaHBxRjBma3liSUJNaURKaHIzNzZ2VmNC?=
 =?utf-8?B?aFJ4OXd4ZGFZMnd2VGRGOW9PckFvenRtb3BVNkY4SENoaVJVbG4zM3FTUlhK?=
 =?utf-8?B?dUtKVXBZVjBIcUNacEt6ZHRIRm5qTnJvTHhGellmM2xuaG1QQldSZkFxZENh?=
 =?utf-8?B?M0FEaXFzSC8zMm9ZYlQrcHNuaVdvdkI5MzlkMHRkQWFiTDV6cHZqb21Cb3ZW?=
 =?utf-8?B?Z21BRi83RS9Lc2I1RG9OekMvVi9QZXVJWWtJdjdYVHlEQThrcXYzZDNxc0VW?=
 =?utf-8?B?T2tBaVI5MllQY2RoYk9JT0VDZ1V5a1ZmNTFYVlVlNGhSOGlsU2pBM2ZHMmFn?=
 =?utf-8?B?NDNYQ0dsTWZJU1IxZzRQOVlaZnQwRjYrdlVJWE9JNThzWGVUWVY2KzVyOWgr?=
 =?utf-8?B?R1ZzWGFwOGZRUTV0WkZrM0RiWnBIaEMxSnNoK3lYQmFXVmZqYmVuUkVFUHF3?=
 =?utf-8?B?VVF3c1c0SHAxeW4xbkpIMWZkaERzSFAwZEZ4dXhSUXFrK1BZWC9TekxYN2w4?=
 =?utf-8?B?OHYwSm1odjVsNGpnSlpSVjFxc2NyRzZwS2Ryd1EzZndGUWhkM2g1UnBGL0Qy?=
 =?utf-8?B?S2gwcVhtVDhVVENobkgxSjY4SmRoTGNiWjAwYnBUMjlnb1QvVDZ2Y3FkbGxD?=
 =?utf-8?B?ajl1MDMyWmRMdm9WMStrajh5WXhkMnhCNnByQTQ4UnJaRjZ4Sm00SWdPdkZv?=
 =?utf-8?B?Mmg2WE5UL2tqNnB0Z2F0T3ZXRW5RdmY4Q3ZBamhhUlg5MTNpMkc5TXc0ZGlK?=
 =?utf-8?B?Z3RJdjlOSEdDRjEyNzdhZ0pIN255cnhmeUYwZmpJMXk1Q0FLTDBtcU9iZ05Y?=
 =?utf-8?B?ODh4VSt6YkRnOVpSUVRveGxWZDB3SEtKVlRBSnR2RlpIdFNpc2p5MUY0em5k?=
 =?utf-8?B?N1FPNGJZVWVvM1dyY1NDdUhDNzN6V2xDNS9FYVZQMVRBQzJOdWRXK3ZCeENy?=
 =?utf-8?B?VDMrMmkxb1FUWVQxcjVJK3h6T3BlQTJKeDZTT3B3NVlxWUZKRUFwbm55bVFX?=
 =?utf-8?B?WlRBWmg1UlFBK0pZb2pNN3d6ZklWMHNpNnVHQ2VDWGlEWDJWT00xODR6a0hZ?=
 =?utf-8?Q?xVu/EBRZpWVn7UrK69rJ0Gd1x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b7b61e-e72b-4942-a74a-08dd8ec6c2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:57:27.9037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4F4KP1mE7W88rH0g/5U3404ZMdxW/+oEyXYr86uWPieL6tV/fEHbpeF4HO5Nv4ufacizZSwE9IW1LmlpLLLGpRrtmB5ZCAzkyhiELGHv88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6445
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDMvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IEltcHJvdmUgcmVhZGFiaWxpdHkgYW5kDQo+IGNvbnNpc3RlbmN5IGluIHZhcmlh
YmxlIG5hbWluZw0KPiANCj4gT24gMy8yMS8yNSAxMDoyNSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+
IEN1cnJlbnRseSwgdXNlcnMgZGVmaW5lIG11bHRpcGxlIGxvY2FsIHZhcmlhYmxlcyB3aXRoaW4g
ZGlmZmVyZW50IGlmLXN0YXRlbWVudHMuDQo+ID4gVG8gaW1wcm92ZSByZWFkYWJpbGl0eSBhbmQg
bWFpbnRhaW4gY29uc2lzdGVuY3kgaW4gdmFyaWFibGUgbmFtaW5nLA0KPiA+IHJlbmFtZSB0aGUg
dmFyaWFibGVzIGFjY29yZGluZ2x5Lg0KPiA+IEludHJvZHVjZWQgInNnX2FkZHIiIHRvIGNsZWFy
bHkgaW5kaWNhdGUgdGhlIHNjYXR0ZXItZ2F0aGVyIG1vZGUgYnVmZmVyDQo+IGFkZHJlc3MuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gDQo+IA0KPiBUaGUgY2hhbmdlIGxvb2sgT0suIGRvX2hhc2hfb3BlcmF0aW9uKCkgaXMg
YSBiaWcgcm91dGluZSwgZGlmZmljdWx0IHRvIHJlYWQuIEl0DQo+IGRvZXMgc3R1ZmYgbGlrZSA6
DQo+IA0KPiAgICAgIGlmIChzZ19tb2RlKSB7DQo+IAkgICAgLi4uDQo+ICAgICAgfSBlbHNlIHsN
Cj4gCSAgICAuLi4NCj4gICAgICB9DQo+IA0KPiAgICAgIGlmIChhY2NfbW9kZSkgew0KPiAJICAg
IC4uLg0KPiAgICAgIH0gZWxzZSB7DQo+IAkgICAgLi4uDQo+ICAgICAgfQ0KPiAgICAgIC4uLg0K
PiANCj4gSSB0aGluayB3ZSBzaG91bGQgYWxzbyBzcGxpdCBpdCBpbiBtdWx0aXBsZSByb3V0aW5l
cyB0byByZWR1Y2UgdGhlIGNvbXBsZXhpdHksDQo+IGV2ZW4gaWYgc29tZSBwYXJ0IGFyZSByZWR1
bmRhbnQuDQo+IA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KSSByZWZh
Y3RvciAiZG9faGFzaF9vcGVyYXRpb24iLiBQbGVhc2Ugc2VlIHBhdGNoIDYgY29tbWVudHMuDQpU
aGFua3MtSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+IC0tLT4g
ICBody9taXNjL2FzcGVlZF9oYWNlLmMgfCAzMyArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9oYWNlLmMgYi9ody9t
aXNjL2FzcGVlZF9oYWNlLmMgaW5kZXgNCj4gPiBkOGI1ZjA0OGJiLi40YmNmNmVkMDc0IDEwMDY0
NA0KPiA+IC0tLSBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNw
ZWVkX2hhY2UuYw0KPiA+IEBAIC0xNDUsMTUgKzE0NSwxOSBAQCBzdGF0aWMgYm9vbCBoYXNfcGFk
ZGluZyhBc3BlZWRIQUNFU3RhdGUgKnMsDQo+IHN0cnVjdCBpb3ZlYyAqaW92LA0KPiA+ICAgc3Rh
dGljIHZvaWQgZG9faGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLCBpbnQgYWxnbywg
Ym9vbA0KPiBzZ19tb2RlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9v
bCBhY2NfbW9kZSkNCj4gPiAgIHsNCj4gPiArICAgIGJvb2wgc2dfYWNjX21vZGVfZmluYWxfcmVx
dWVzdCA9IGZhbHNlOw0KPiA+ICsgICAgZ19hdXRvZnJlZSB1aW50OF90ICpkaWdlc3RfYnVmID0g
TlVMTDsNCj4gPiAgICAgICBzdHJ1Y3QgaW92ZWMgaW92W0FTUEVFRF9IQUNFX01BWF9TR107DQo+
ID4gKyAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gPiAgICAgICB1aW50MzJfdCB0b3Rh
bF9tc2dfbGVuOw0KPiA+IC0gICAgdWludDMyX3QgcGFkX29mZnNldDsNCj4gPiAtICAgIGdfYXV0
b2ZyZWUgdWludDhfdCAqZGlnZXN0X2J1ZiA9IE5VTEw7DQo+ID4gICAgICAgc2l6ZV90IGRpZ2Vz
dF9sZW4gPSAwOw0KPiA+IC0gICAgYm9vbCBzZ19hY2NfbW9kZV9maW5hbF9yZXF1ZXN0ID0gZmFs
c2U7DQo+ID4gLSAgICBpbnQgaTsNCj4gPiArICAgIHVpbnQzMl90IHNnX2FkZHIgPSAwOw0KPiA+
ICsgICAgdWludDMyX3QgcGFkX29mZnNldDsNCj4gPiArICAgIHVpbnQzMl90IGxlbiA9IDA7DQo+
ID4gKyAgICB1aW50MzJfdCBzcmMgPSAwOw0KPiA+ICAgICAgIHZvaWQgKmhhZGRyOw0KPiA+IC0g
ICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ID4gKyAgICBod2FkZHIgcGxlbjsNCj4gPiAr
ICAgIGludCBpOw0KPiA+DQo+ID4gICAgICAgaWYgKGFjY19tb2RlICYmIHMtPmhhc2hfY3R4ID09
IE5VTEwpIHsNCj4gPiAgICAgICAgICAgcy0+aGFzaF9jdHggPSBxY3J5cHRvX2hhc2hfbmV3KGFs
Z28sICZsb2NhbF9lcnIpOyBAQA0KPiAtMTY2LDEyDQo+ID4gKzE3MCw3IEBAIHN0YXRpYyB2b2lk
IGRvX2hhc2hfb3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywgaW50IGFsZ28sDQo+IGJvb2wg
c2dfbW9kZSwNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICBpZiAoc2dfbW9kZSkgew0KPiA+
IC0gICAgICAgIHVpbnQzMl90IGxlbiA9IDA7DQo+ID4gLQ0KPiA+ICAgICAgICAgICBmb3IgKGkg
PSAwOyAhKGxlbiAmIFNHX0xJU1RfTEVOX0xBU1QpOyBpKyspIHsNCj4gPiAtICAgICAgICAgICAg
dWludDMyX3QgYWRkciwgc3JjOw0KPiA+IC0gICAgICAgICAgICBod2FkZHIgcGxlbjsNCj4gPiAt
DQo+ID4gICAgICAgICAgICAgICBpZiAoaSA9PSBBU1BFRURfSEFDRV9NQVhfU0cpIHsNCj4gPiAg
ICAgICAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWRfaGFjZTogZ3Vlc3QgZmFpbGVkIHRvIHNldCBl
bmQgb2Ygc2cNCj4gPiBsaXN0IG1hcmtlclxuIik7IEBAIC0xODMsMTIgKzE4MiwxMiBAQCBzdGF0
aWMgdm9pZA0KPiBkb19oYXNoX29wZXJhdGlvbihBc3BlZWRIQUNFU3RhdGUgKnMsIGludCBhbGdv
LCBib29sIHNnX21vZGUsDQo+ID4gICAgICAgICAgICAgICBsZW4gPSBhZGRyZXNzX3NwYWNlX2xk
bF9sZSgmcy0+ZHJhbV9hcywgc3JjLA0KPiA+DQo+IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsDQo+
ID4gTlVMTCk7DQo+ID4NCj4gPiAtICAgICAgICAgICAgYWRkciA9IGFkZHJlc3Nfc3BhY2VfbGRs
X2xlKCZzLT5kcmFtX2FzLCBzcmMgKw0KPiBTR19MSVNUX0xFTl9TSVpFLA0KPiA+IC0NCj4gTUVN
VFhBVFRSU19VTlNQRUNJRklFRCwgTlVMTCk7DQo+ID4gLSAgICAgICAgICAgIGFkZHIgJj0gU0df
TElTVF9BRERSX01BU0s7DQo+ID4gKyAgICAgICAgICAgIHNnX2FkZHIgPSBhZGRyZXNzX3NwYWNl
X2xkbF9sZSgmcy0+ZHJhbV9hcywgc3JjICsNCj4gU0dfTElTVF9MRU5fU0laRSwNCj4gPiArDQo+
IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiA+ICsgICAgICAgICAgICBzZ19hZGRy
ICY9IFNHX0xJU1RfQUREUl9NQVNLOw0KPiA+DQo+ID4gICAgICAgICAgICAgICBwbGVuID0gbGVu
ICYgU0dfTElTVF9MRU5fTUFTSzsNCj4gPiAtICAgICAgICAgICAgaGFkZHIgPSBhZGRyZXNzX3Nw
YWNlX21hcCgmcy0+ZHJhbV9hcywgYWRkciwgJnBsZW4sDQo+IGZhbHNlLA0KPiA+ICsgICAgICAg
ICAgICBoYWRkciA9IGFkZHJlc3Nfc3BhY2VfbWFwKCZzLT5kcmFtX2FzLCBzZ19hZGRyLCAmcGxl
biwNCj4gPiArIGZhbHNlLA0KPiA+DQo+IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpOw0KPiA+ICAg
ICAgICAgICAgICAgaWYgKGhhZGRyID09IE5VTEwpIHsNCj4gPiAgICAgICAgICAgICAgICAgICBx
ZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgQEAgLTIxMiwxNg0KPiArMjExLDE2IEBADQo+
ID4gc3RhdGljIHZvaWQgZG9faGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLCBpbnQg
YWxnbywgYm9vbCBzZ19tb2RlLA0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICB9
DQo+ID4gICAgICAgfSBlbHNlIHsNCj4gPiAtICAgICAgICBod2FkZHIgbGVuID0gcy0+cmVnc1tS
X0hBU0hfU1JDX0xFTl07DQo+ID4gKyAgICAgICAgcGxlbiA9IHMtPnJlZ3NbUl9IQVNIX1NSQ19M
RU5dOw0KPiA+DQo+ID4gICAgICAgICAgIGhhZGRyID0gYWRkcmVzc19zcGFjZV9tYXAoJnMtPmRy
YW1fYXMsDQo+IHMtPnJlZ3NbUl9IQVNIX1NSQ10sDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmbGVuLCBmYWxzZSwNCj4gTUVNVFhBVFRSU19VTlNQRUNJRklFRCk7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcGxlbiwgZmFsc2UsDQo+ID4g
KyBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKTsNCj4gPiAgICAgICAgICAgaWYgKGhhZGRyID09IE5V
TEwpIHsNCj4gPiAgICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAi
JXM6IHFjcnlwdG8NCj4gZmFpbGVkXG4iLCBfX2Z1bmNfXyk7DQo+ID4gICAgICAgICAgICAgICBy
ZXR1cm47DQo+ID4gICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgaW92WzBdLmlvdl9iYXNlID0g
aGFkZHI7DQo+ID4gLSAgICAgICAgaW92WzBdLmlvdl9sZW4gPSBsZW47DQo+ID4gKyAgICAgICAg
aW92WzBdLmlvdl9sZW4gPSBwbGVuOw0KPiA+ICAgICAgICAgICBpID0gMTsNCj4gPiAgICAgICB9
DQo+ID4NCg0K

