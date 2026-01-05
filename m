Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF69EC2A077
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcgFl-00059J-2T; Mon, 05 Jan 2026 03:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcgFh-000596-Hh; Mon, 05 Jan 2026 03:47:49 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcgFd-0007Ab-Tn; Mon, 05 Jan 2026 03:47:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw9BCdl/fHOMW4rQlgyqD49cv7HPn9mGQ12iJufXWS8iDnGu1PS/3vAego1bJDg8f8AWDbuyWAg4o9XC2ttDyROIhZU/QA4DREMFYrovu6uDlJtbAX8yecWZfSfLapbHV21pFtJnGzrpONsRXx+/ZcmOhdKBPg5LTciG2DPd6wKdxmFId6FSvZSHjLbBvVJtOXgOki0o6XXkQu29vVb1eVVgUkQhPi2lnH31AwFyFYYiQz3qC6xPXWp7hUYtaRqUrf8qJugM3pN24pPseEbhBMlY9TK0N713zNg3Fh/P0USQzDq8phsOUNUfbzCj4YvA6Y9DccAWYqu21vaWVS1KAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XblZ5HAISkwKyNbqnP2Wyv0TBSMnEQkvNHWHpqw4oM4=;
 b=yrJpsPDJGSqL0cXybdx+5zf5aFx9Fxe6cgWpRWeARbFIu7x1RFU+KsSgwOzzUdMK26c+kUKaK2vWXidi5za/y3Li29kPWiusrVrBVKTa4CF3HkxcPywibI8ljYrUbYSIgCl4/4VdyebnG6b4eT/wUGNmQP3Aeg8MIsvsXSyQGxZwid1LNoc9vn1KZAe3nRJcdIHRNFTD6knfLiukyWp0Lkl5x33vpsUQUdvYdJBEXli2D6ip2ANytC7r8oEwE0BmQhXfKRPVFyRFG8f/MIcxAQhkYqjFuE7piSO5jLPSj6egR11hnMnUjxr3v8bXtttkGopL58d652A7W+JY+RXvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XblZ5HAISkwKyNbqnP2Wyv0TBSMnEQkvNHWHpqw4oM4=;
 b=UWRQFCTy1+TsU223+dxFpusvn/P2sUQ1ooKTn6+MbpDCc/shHzXtfaRxmj07CdL9YGmYambSurK123N9hPfJfNqM7NLBuTWvkqaaljRCPmHpRKAni7XXyrucGlomAZISQtNbDip5tarIq91tgrYEUzZdx2wSUV4obhYhbfBQPfAo4YwMg+ahi6vdI6hMPgIlkLwVPqib/T4Lli0MTtckJ0MX/IeE6mNFT6paZPThUh8Rcfj53CRPCsuindrV8xie8TE9UIMoZcSmANt0WdbrtdN8MkQ7ebM/N4JEloK84ahd6iAsteoGKdGXIJ2pUXByhSuaTUWy5h77c1+njeRXtA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF1C65AA8C1.apcprd06.prod.outlook.com (2603:1096:408::787)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:47:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:47:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 00/19] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH 00/19] i3c: aspeed: Add I3C support
Thread-Index: AQHb2/a2CcL7KROFtkqdhplaCpqsBbVEhicg
Date: Mon, 5 Jan 2026 08:47:34 +0000
Message-ID: <TYPPR06MB8206E110D0A959596D8E9DC0FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF1C65AA8C1:EE_
x-ms-office365-filtering-correlation-id: 43f5ca36-ef35-4364-e512-08de4c37123e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VnhsOUt4Y1BPVjYzRktkSTdQcE1mdkZjUTV1VDdPRjVHa2MzNjc5blc4OTM1?=
 =?utf-8?B?YUh4eHhLY3Rlc1pRM3RmczdGWk5QUXJFM2o4VHk4ZFNpbGRacXVUL3ZOUkwr?=
 =?utf-8?B?S0x5ZHgwL0xBRGpicEFlWXQrVHVVT1lVcFU4Nm1BaGlwdnFuR0MxSk9UeGh0?=
 =?utf-8?B?dER3emYydFZydG5wWmR0eUVuUjV0d2lOWUhTeWFmcXdOS0E1a2hTSnJhNTN2?=
 =?utf-8?B?QllVd0VwTkdoYm1HMFRsV0NneXpYTU9HMmN4bkhoN3plTDFrMGVxYndSUEtX?=
 =?utf-8?B?elNhY1dWTXh1a0FBNnZMbW9wMDRNR1ZlWGdYYzhRU2EzM2ppdWppa0VjaVJQ?=
 =?utf-8?B?UkZvOVh4cFd1Y1FKTnBqd29kcCt4dVZrc0x1cy9tZ2VKa0hEZHpYbWI2MnRC?=
 =?utf-8?B?ZTlBd29mL0VpVGM3Z25Jemt4dUpDODhvcjBra014NkZiWVIxbUoyVnZpTzBy?=
 =?utf-8?B?TFRtbEQ0K1p6eDNtcXo0RzVxQ2RRbGpTeTNaU2k1TmJkYXg0RnRZV0wrWC9E?=
 =?utf-8?B?bWdJRHZYazlGaUE0dmFGMGFDakFNcytlLzFiWWVjL1pTNU5QeWRmTVNTdW5t?=
 =?utf-8?B?ck1LbzIyNGtnaUNEVndXNm1VZEZpakRGMkJlOUZxY2JDSnN6Z2kraXVYUitr?=
 =?utf-8?B?OWxIaURzUDBaWkxEM2x0NURRa3pERTA2UEtHYk44SWtQbWZMUDFQZmdOSUs4?=
 =?utf-8?B?L2NpZFF1UVNKWVBjZTJPSmdtVWVrZTdEdkFIa2xpOTJBV2xMNElhYXN6bGVs?=
 =?utf-8?B?L1FITVNHdkplbnJnNVVIdFdvK1VPclpnL1Njcm1jU0h4VjJBenlpVWEybTBN?=
 =?utf-8?B?Wmdzd08xaElrdklpVlFaOUhQbUFVUjhnRFFEUXFjTDRMZW9OQStTeitudmNv?=
 =?utf-8?B?Y0xqVHY3b2srUUovM3lXVnhBQnI5eE1UMDBWdld2d3BzeXZkaDZDb25jYngr?=
 =?utf-8?B?dFVmQkxEcW5RNHV4anVpUEU5KzN2YlVOZU9EakdEOUdDUzAyb0xUeWF2Nnd6?=
 =?utf-8?B?SVlaZkZheEh6MWlYVUlXNU9QSkNKRWNWM3VrcDIyNGE1NS9FUkZyR1BDNnRq?=
 =?utf-8?B?cC9uUjNad2FOVy9leGs5Y2VQL3kyZkwzUktwWjNVK2FHSHN6QVZvZXgyd1o5?=
 =?utf-8?B?STVWSlJrbHNQUW1HT2x4T1VtSWhoV1VQTUM1amg5eTdnRDZWUW9ac2VQK2xj?=
 =?utf-8?B?SFdvbVdtK3RGRUxNZ2NmQVdMUXYrSFRDOVJrNXhsUUl5ZE1JRzZJRGlNanFY?=
 =?utf-8?B?S3NrZ1k4UHY3ajI2VmFUZDlMdGlqSUIrQUgvQnh1bWhtME5LbzFrc0gzLzRw?=
 =?utf-8?B?eWFpdVRQaXkxQ3lWU2t3VUhKZGdQQkZmZTFvZDhXempWdktSMWZwNmJvTzd4?=
 =?utf-8?B?bXZwOGd5WVVIM0dTL285ajVQUUREUUVHM0NWdjBsdUdVVlFOYXZvMC9KN0tE?=
 =?utf-8?B?cUNzbGN3YkZ6WFdMNitpNExlK1VvZzhOZEZ2dDc0cXY1bTFwcTc0V0FSSkhP?=
 =?utf-8?B?Q0VWSkhFOEo3TnBKUWx0RlROc1ExelA3NEJxUDM0RFcwckp3MnZ0VWxINFF4?=
 =?utf-8?B?U3o3UVVmYmN1amJ6dTcrUzEraXZ2d05ySUtPK3BMMjFoY0g1eWhOSEN3TzYv?=
 =?utf-8?B?VHVueUsyb3NxcXVVSnVmT2VnT3NTNW02bXVqbWloaE9vb0RhS2hZaXplK0Vu?=
 =?utf-8?B?UCtKeFk0ZDd6YVJTdklIaG93UjN1NlNyZmtnT3F1Zm05M3B5ZWtNN09heGw5?=
 =?utf-8?B?T3dsT2twVllUSkFER1V3Mk96VVZPSDM4Z212RWVtNnRkR1dmQTIvU2ZsTzFX?=
 =?utf-8?B?M0RPMnF4ZytNM3FvdUpMWHVGeUdLcytpbW9pNVA5S2Q4Q256RmhRYnAvWi9T?=
 =?utf-8?B?RVVibXBoQ2xTK1dhaVpEamVCUmZpc0V3NU9BMmZRaVhhck1JZ1o3WlNpWUc2?=
 =?utf-8?B?dzh3MGMrdnRteFJmWkNnbFc1K2pycjZCdEEvRFo0a2lvVmkrR2lGdGJSaTV0?=
 =?utf-8?B?Wlgzak9OSHBNM0lJbVd1V3d2emFIK080allaaUIyL2tvQjhVZ3gwM2wxZEZJ?=
 =?utf-8?Q?QJSWg1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVlVVUE2ZUdsRlRQamljRjkzL3JqVlFmcTlqU29uOEl3Tis4cEdmY3hHeUxv?=
 =?utf-8?B?VmF6bkI0aUNHQTZSeWozMDJhb2hXREVUV2h5dG5mUTZQRUpTbS9LLzd0aFJz?=
 =?utf-8?B?dUxsZGtwdTZkVVZXQUZhM1FjWDJIa0k2dStFWkxMU2Rwd2ExbVFVeStlWHBT?=
 =?utf-8?B?ZXpNbVRZZytJM3RaSTIwWHVUOWoxSTBvRFJ0NjQ1RkwxZTVMT05FUTVJakNr?=
 =?utf-8?B?Z2dzQ0dTUVVOVFZsSWFibGo1WEtKeFhFelpQYUJyVTltb2J0Z01pM1RIQ1p6?=
 =?utf-8?B?T2NzTHJ6MmZweTdCK0h1R2lvcmNVTTlKZyt6Zk91WHdlQnA1UGRPa1ZQTEtv?=
 =?utf-8?B?VkFGZHdZb2hpcm9kb3hDeDFMU29yUHRwWjdOeitjVWkwdmtablhaYW9jN0Zj?=
 =?utf-8?B?ZVdVd3lGaHhOTFV0dDRqc2pVc2IrTnZUWGhHNTJRMWduNzgxVXdMWDNZR0xN?=
 =?utf-8?B?OUFpYkF3TEY2OVZnOUFrb05WNnk3S080cDN6YWVmQjBzWi9ZTi9DVytsdFRq?=
 =?utf-8?B?ZUx1WEIzUyttQXNPaWc3RzNIK3VOWklPMnBNV2l5cHYwWXhaS05rT05PTDdS?=
 =?utf-8?B?NnVTSUl0M3lPZ2FZRHZvUzUvclJsRm1xWldHbEZzOE9rUlhyQjdvMTUxUU1F?=
 =?utf-8?B?dXRpNmJMSXV2RFh4MDg1ZjJxTGdHS1EzaGh4N0JaL3gvTEZZRTJWZVFvZDhB?=
 =?utf-8?B?dnVmWVkrRjZURWQzRUM4K1FmZmxCb2JmajBiVkRKd21wY1oxZnd3aGtyRHZl?=
 =?utf-8?B?ZlpTNTQ4ZjBwZjJpYU42d01QRVY2Tkg0UWtNM3dWT2YrVlkzZTE1eEZ5bDZ2?=
 =?utf-8?B?anpuT2MwNU9KZ2JrMndzV2x1czJUTXQwVCtneTd5M1pJRm5xdFcyRE42ZWxo?=
 =?utf-8?B?cXZqODdRdmZwcGx3RnVvTnNnSUVVVXNrRUtpbEJ1dXYzS0ZkMTZCQS9xY1Q5?=
 =?utf-8?B?a2dBdmlZaHp4cm1heFFsNmhmVkhXTENWSmg1dG4yUUh4NW1yWUZySHNTWnJJ?=
 =?utf-8?B?Nys5UXhUYmxESlA3NWg4MW1TRDAva2NXczgxRitzbTRsOEFENGpvOG5Iak5X?=
 =?utf-8?B?Y1dzWTdKUnprNTlzYjFoelY3Yzl6T3FrbDNsc3J6ZmhNSEttcGlLQUJrWC9X?=
 =?utf-8?B?endKakZ5MnZmcGVLTUNNRktKSmVlTVg1dzEwQm02Wmh3N2laQlBET1ByWnRG?=
 =?utf-8?B?NktFR3g1cHoxcTJzNWdibmUzQ2JXcVFOY1N4WWVseFVqRm1sdThROU5oTW1C?=
 =?utf-8?B?UDlRVjdncENweFA5dVdxaFZocUhyam9ya2RHSlpEU3htQlFwMUZ6RDhWRDVN?=
 =?utf-8?B?Q3A3MWpGY09YRURrSjdVYlV5aldHaFhQMERhc3lIazEveEVJN0s5ZXk0d0Uy?=
 =?utf-8?B?WmtxaUUyUmIvMTdHRTcwaWc3Mi80VWVNYmNUTGxrSmlsR0xWNkhNZWIwbjNI?=
 =?utf-8?B?YmxkVXc5Y2ovM3lLS1NDR25ZdGh0VDgxZjhvY1RSbEMzYlNGRzlQRWZqMlVD?=
 =?utf-8?B?K2JBRnBIejh5L1BJZzdub1NSVW5ZZTR0cnJNZHhSUDVCSm1HdCs2bVRmTHBF?=
 =?utf-8?B?RWl5U1pERzR3ZXZXZWI4RGxjWHArUFVRUU5pcWJqNk43MkE5VHovQ1E3M0pN?=
 =?utf-8?B?bkEyVGFCZHVNdE1FdHQvemFXMExINXdqN1AzTURIQmszT3RCU1Y1VFZXcVFv?=
 =?utf-8?B?dXlUNzh5WGdRbTNLNENkcTBYK3UrQUJVSUlRUmlaRVhFNFhublpYWXFYMnR0?=
 =?utf-8?B?L0EvT29WZmNsUm9MYWZ4UmUwTnJkZktBZHdIaDd4Nm4zcnBLdmlqcE5CUWMx?=
 =?utf-8?B?c0pVUFhmT3R2aVNkVmwxYjRncnl0bjk0TUhkRGowRW9JZW9PWkpiZWRNZ3hN?=
 =?utf-8?B?OVErLzVIblJoYU5vS2JITk1KSXpXNXYxQjVLdkwvVWYwNWxBRHJ6eGVzcklR?=
 =?utf-8?B?Z0lwQVBYWmEzaG1iazZHV1FzanNTZVQ1QnBmYzVGb1hubWRqTXh1VWxUbUw0?=
 =?utf-8?B?TlV2RWllTzNXNm9hQUxlQSthem5Va0ZldnNnNkt2VXQ4V1oyR05hK0xIdlhs?=
 =?utf-8?B?Z1FlN3ZTaTJlT0d2UVd0ZUdGaTFlVFBXbTg2Mmp1eGwySDFBdGVFVUNWQ3ZD?=
 =?utf-8?B?OXh0Y2F0SVZPelRyZGRKeitiQllpVjFtZnBFZWRaZ1JpbUI3U1dESTNyU2ph?=
 =?utf-8?B?R2lTK0xoTm15eXVja1Nkd3o3Ny9KZWxsaHcrMEY0cU55VnYvSTB0dXIrZTND?=
 =?utf-8?B?YmRPc28yTFRIbEVSQ0FwT2FsWnJscmFURm5DSm5zNW15aW90bzlmcDFWVldR?=
 =?utf-8?B?MXAyMlprT0VSU0RJZVpOQ2RFQUR5UGZRQmZlNmJFNEFWaFhwK1F4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f5ca36-ef35-4364-e512-08de4c37123e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 08:47:34.6148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czd+hshqPRW0O+twNxfvlf1Egsa9TaG86qfLlSyPiuewFqSSWNSNZfyH86nqoE2s2V2pIB5e1oxdZkxGvCwWHoFfKIdgl2oagHD4fPu//Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1C65AA8C1
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

SGkgSm9lLA0KDQo+IFN1YmplY3Q6IFtQQVRDSCAwMC8xOV0gaTNjOiBhc3BlZWQ6IEFkZCBJM0Mg
c3VwcG9ydA0KPiANCj4gSGkgYWxsLA0KPiANCj4gVGhpcyBzZXJpZXMgYWRkcyBJM0MgYnVzIHN1
cHBvcnQgdG8gUUVNVSBhbmQgYWRkcyBtb3JlIGZ1bmN0aW9uYWxpdHkgdG8gdGhlDQo+IEFzcGVl
ZCBJM0MgY29udHJvbGxlci4NCj4gDQo+IFRoaXMgaW1wbGVtZW50YXRpb24gaXMgYSBiYXNpYyBp
bXBsZW1lbnRhdGlvbiB0aGF0IGludHJvZHVjZXMgSUJJcyAoaW5jbHVkaW5nDQo+IGhvdC1qb2lu
KSwgQ0NDcywgYW5kIFNEUiBkYXRhIHRyYW5zZmVyLiBBcy1pcywgaXQgZG9lc24ndCBzdXBwb3J0
IG11bHRpLWNvbnRyb2xsZXINCj4gYnVzZXMgb3IgSERSIHRyYW5zZmVycy4NCj4gDQo+IEZpcnN0
IHdlIGFkZCB0aGUgSTNDIGJ1cyBhbmQgY29udHJvbGxlciBtb2RlbC4gV2l0aCB0aGF0IGFkZGVk
IHdlIGV4dGVuZCB0aGUNCj4gZnVuY3Rpb25hbGl0eSBvZiB0aGUgQXNwZWVkIEkzQyBjb250cm9s
bGVyIHNvIGl0IGNhbiBkbyB0cmFuc2ZlcnMgYW5kIGhhbmRsZSBJQklzLg0KPiANCj4gTmV4dCwg
d2UgYWRkIGEgbW9jayBJM0MgdGFyZ2V0LiBJdCdzIGludGVuZGVkIHRvIGJlIGEgdmVyeSBzaW1w
bGUgdGFyZ2V0IGp1c3QgdG8NCj4gdmVyaWZ5IHRoYXQgSTNDIGlzIHdvcmtpbmcgb24gdGhlIGd1
ZXN0LiBJbnRlcm5hbGx5LCB3ZSd2ZSB1c2VkIGl0IG9uIExpbnV4IHRvDQo+IHZlcmlmeSB0aGF0
IGkzQyBkZXZpY2VzIGNhbiBiZSBwcm9iZWQgYW5kIGNhbiBzZW5kL3JlY2VpdmUgZGF0YSBhbmQg
SUJJcy4NCj4gVGhpcyB0YXJnZXQgaXMgc29ydCBvZiBsaWtlIGFuIEVFUFJPTSwgYW5kIGl0IGNh
biBhbHNvIHNlbmQgSUJJcyB1cG9uIHJlY2VwdGlvbg0KPiBvZiBhIHVzZXItZGVmaW5lZCBtYWdp
YyBudW1iZXIuDQo+IA0KPiBMYXN0bHkgd2UgYWRkICBob3RwbHVnZ2luZyBzdXBwb3J0LiBUaGUg
aG90cGx1Z2dpbmcgZG9lc24ndCBkbyBhbnl0aGluZyB0b28NCj4gY29tcGxpY2F0ZWQsIGl0IGp1
c3QgYWRkcyB0aGUgZGV2aWNlIGF0dGVtcHRpbmcgdG8gaG90cGx1ZyB0byB0aGUgYnVzLiBJdCBp
cyB0aGUNCj4gZGV2aWNlJ3MgcmVzcG9uc2liaWxpdHkgdG8gaG90LWpvaW4gYW5kIGdvIHRocm91
Z2ggdGhlIERBQSBwcm9jZXNzIHRvDQo+IHBhcnRpY2lwYXRlIG9uIHRoZSBidXMuDQo+IA0KPiBU
aGFua3MsDQo+IEpvZQ0KPiANCj4gSm9lIEtvbWxvZGkgKDE5KToNCj4gICBody9taXNjL2FzcGVl
ZF9pM2M6IE1vdmUgdG8gaTNjIGRpcmVjdG9yeQ0KPiAgIGh3L2kzYzogQWRkIGJ1cyBzdXBwb3J0
DQo+ICAgaHcvaTNjOiBTcGxpdCBEZXNpZ25XYXJlIEkzQyBvdXQgb2YgQXNwZWVkIEkzQw0KPiAg
IGh3L2kzYy9kdy1pM2M6IEFkZCBtb3JlIHJlZ2lzdGVyIGZpZWxkcw0KPiAgIGh3L2kzYy9hc3Bl
ZWRfaTNjOiBBZGQgbW9yZSByZWdpc3RlciBmaWVsZHMNCj4gICBody9pM2MvZHctaTNjOiBBZGQg
bW9yZSByZXNldCB2YWx1ZXMNCj4gICBody9pM2MvYXNwZWVkX2kzYzogQWRkIHJlZ2lzdGVyIFJP
IGZpZWxkIG1hc2tzDQo+ICAgaHcvaTNjL2R3LWkzYzogQWRkIHJlZ2lzdGVyIFJPIGZpZWxkIG1h
c2tzDQo+ICAgaHcvaTNjL2R3LWkzYzogVHJlYXQgbW9yZSByZWdpc3RlcnMgYXMgcmVhZC1hcy16
ZXJvDQo+ICAgaHcvaTNjL2R3LWkzYzogVXNlIDMyIGJpdHMgb24gTU1JTyB3cml0ZXMNCj4gICBo
dy9pM2MvZHctaTNjOiBBZGQgSVJRIE1NSU8gYmVoYXZpb3INCj4gICBody9pM2MvZHctaTNjOiBB
ZGQgZGF0YSBUWCBhbmQgUlgNCj4gICBody9pM2MvZHctaTNjOiBBZGQgSUJJIGhhbmRsaW5nDQo+
ICAgaHcvaTNjL2R3LWkzYzogQWRkIGN0cmwgTU1JTyBoYW5kbGluZw0KPiAgIGh3L2kzYy9kdy1p
M2M6IEFkZCBjb250cm9sbGVyIHJlc2V0cw0KPiAgIGh3L2kzYy9hc3BlZWQ6IEFkZCBJM0MgYnVz
IGdldCBmdW5jdGlvbg0KPiAgIGh3L2kzYzogQWRkIE1vY2sgdGFyZ2V0DQo+ICAgaHcvYXJtL2Fz
cGVlZDogQnVpbGQgd2l0aCBJM0NfREVWSUNFUw0KPiAgIGh3L2kzYzogQWRkIGhvdHBsdWcgc3Vw
cG9ydA0KPiANCj4gIGh3L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAx
ICsNCj4gIGh3L2FybS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAzICsNCj4g
IGh3L2kzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE1ICsNCj4gIGh3L2kz
Yy9hc3BlZWRfaTNjLmMgICAgICAgICAgICAgICAgICAgfCAgMjYxICsrKysNCj4gIGh3L2kzYy9j
b3JlLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjY5ICsrKysrKysrKw0KPiAgaHcvaTNj
L2R3LWkzYy5jICAgICAgICAgICAgICAgICAgICAgICB8IDE4ODENCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgaHcvaTNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAg
IDYgKw0KPiAgaHcvaTNjL21vY2staTNjLXRhcmdldC5jICAgICAgICAgICAgICB8ICAzMTEgKysr
Kw0KPiAgaHcvaTNjL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICAgICAgICB8ICAgNDcgKw0KPiAg
aHcvaTNjL3RyYWNlLmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiAgaHcvbWVz
b24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiAgaHcvbWlzYy9hc3Bl
ZWRfaTNjLmMgICAgICAgICAgICAgICAgICB8ICAzODMgLS0tLS0NCj4gIGh3L21pc2MvbWVzb24u
YnVpbGQgICAgICAgICAgICAgICAgICAgfCAgICAxIC0NCj4gIGh3L21pc2MvdHJhY2UtZXZlbnRz
ICAgICAgICAgICAgICAgICAgfCAgICA2IC0NCj4gIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2Mu
aCAgICAgICAgICAgfCAgICAyICstDQo+ICBpbmNsdWRlL2h3L3ttaXNjID0+IGkzY30vYXNwZWVk
X2kzYy5oIHwgICAyMiArLQ0KPiAgaW5jbHVkZS9ody9pM2MvZHctaTNjLmggICAgICAgICAgICAg
ICB8ICAyMDEgKysrDQo+ICBpbmNsdWRlL2h3L2kzYy9pM2MuaCAgICAgICAgICAgICAgICAgIHwg
IDI3NyArKysrDQo+ICBpbmNsdWRlL2h3L2kzYy9tb2NrLWkzYy10YXJnZXQuaCAgICAgIHwgICA1
MiArDQo+ICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+
ICAyMCBmaWxlcyBjaGFuZ2VkLCAzNzM1IGluc2VydGlvbnMoKyksIDQwNyBkZWxldGlvbnMoLSkg
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBody9pM2MvS2NvbmZpZyAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGh3L2kzYy9hc3BlZWRfaTNjLmMgIGNyZWF0ZSBtb2RlDQo+IDEwMDY0NCBody9pM2MvY29yZS5j
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL2R3LWkzYy5jICBjcmVhdGUgbW9kZQ0KPiAxMDA2
NDQgaHcvaTNjL21lc29uLmJ1aWxkICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL21vY2staTNj
LXRhcmdldC5jDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvdHJhY2UtZXZlbnRzICBjcmVh
dGUgbW9kZSAxMDA2NDQNCj4gaHcvaTNjL3RyYWNlLmggIGRlbGV0ZSBtb2RlIDEwMDY0NCBody9t
aXNjL2FzcGVlZF9pM2MuYyAgcmVuYW1lDQo+IGluY2x1ZGUvaHcve21pc2MgPT4gaTNjfS9hc3Bl
ZWRfaTNjLmggKDYzJSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBpbmNsdWRlL2h3L2kzYy9kdy1p
M2MuaCAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaTNjL2kzYy5oICBjcmVhdGUNCj4g
bW9kZSAxMDA2NDQgaW5jbHVkZS9ody9pM2MvbW9jay1pM2MtdGFyZ2V0LmgNCj4gDQo+IC0tDQo+
IDIuNTAuMC5yYzEuNTkxLmc5Yzk1ZjE3ZjY0LWdvb2cNCg0KDQpJIHRlc3RlZCB0aGlzIHNlcmll
cyBvbiBBU1QyNjAwLCBhbmQgdGhlIHJlc3VsdHMgYXJlIGFzIGZvbGxvd3M6DQoNCjEuIFFFTVUg
Y29tbWFuZCBsaW5lDQogIEFkZCB0aGUgZm9sbG93aW5nIG9wdGlvbiB0byB0aGUgUUVNVSBjb21t
YW5kIGxpbmUNCiAgLWRldmljZSBtb2NrLWkzYy10YXJnZXQsYnVzPWR3LmkzYy41LGJ1Zi1zaXpl
PTI1NixpYmktbWFnaWMtbnVtPTB4NWENCg0KMS4gRGV2aWNlIGVudW1lcmF0aW9uDQogIEFmdGVy
IGJvb3RpbmcgaW50byBMaW51eCwgdGhlIG5ldyBkZXZpY2UgYXBwZWFycyBvbiBJM0MgYnVzIDU6
DQoNCnJvb3RAYXN0MjYwMC1kZWZhdWx0Oi9zeXMvYnVzL2kzYy9kZXZpY2VzIyBscw0KMC00Y2Mz
MTAyMDAwMCAgMC00Y2M1MTE4MDAwMCAgMC00Y2M1MTE4MTAwMCAgMS00Y2MzMTAyMDAwMCAgMS00
Y2M1MTE4MDAwMCAgMS00Y2M1MTE4MTAwMCAgNC10YXJnZXQgICAgICAgNS0wICAgICAgICAgICAg
aTNjLTAgICAgICAgICAgaTNjLTEgICAgICAgICAgaTNjLTIgICAgICAgICAgaTNjLTMgICAgICAg
ICAgaTNjLTQgICAgICAgICAgaTNjLTUNCg0KMS4gUkVBRC9XUklURSBNT0NLIEVFUFJPTQ0KSSB2
ZXJpZmllZCBwcml2YXRlIHdyaXRlIGFuZCByZWFkIG9wZXJhdGlvbnMgdXNpbmcgdGhlIGkzY2Rl
diBpbnRlcmZhY2UNCg0Kcm9vdEBhc3QyNjAwLWRlZmF1bHQ6L3N5cy9idXMvaTNjL2RldmljZXMv
NS0wIyBkZCBpZj0vdG1wL2phbWluIG9mPS9kZXYvaTNjLTUtMA0KMCsxIHJlY29yZHMgaW4NCjAr
MSByZWNvcmRzIG91dA0KMjAwIGJ5dGVzICgyMDBCKSBjb3BpZWQsIDAuMDAyMDMyIHNlY29uZHMs
IDk2LjFLQi9zDQoNCnJvb3RAYXN0MjYwMC1kZWZhdWx0Oi9zeXMvYnVzL2kzYy9kZXZpY2VzLzUt
MCMgaGV4ZHVtcCAvZGV2L2kzYy01LTANCjAwMDAwMDAgMDRjYiAyZDg0IDBkODAgNDVlNiA2Yzlh
IDNkMjMgOTM4NCBiM2VmDQowMDAwMDEwIGY1MzQgMzMyOCA1ZTA3IGFjOTQgNWNkNiAzOTE0IDg2
YWQgZTA4NQ0KMDAwMDAyMCBlMDQ3IDgxZTMgYWY1MiBiYjg4IGYyMGMgYzI4MiA2MTQ4IDUzNzQN
CjAwMDAwMzAgNmI3ZCA1OGJmIGZiMWMgMjM4MiAxMjFmIDFhNjAgYmZiNCAxZWJkDQowMDAwMDQw
IDgwMjggMGE4MiA0NzQwIDgyODcgNTczNyA5ODhmIDU5N2UgOWE2Nw0KMDAwMDA1MCBhN2Y3IGIw
YzggZGI4NyAyNjMxIDgzMDQgZGY4OSA2OTc3IDJhODINCjAwMDAwNjAgMTJkOCBmYjczIGJjYzcg
ZWNkMCBlYmEyIDU3NWYgYTA1MCAwMmZiDQowMDAwMDcwIGFmNGIgZmZlZiBkYTViIDVjYjMgMTRh
MyA3MDQ3IDE3YWMgZDIzOA0KMDAwMDA4MCBlZGE2IGFlM2UgYWM3MiA2MTEyIGJiYmYgZmJjYSA4
NDRkIDAzNWUNCjAwMDAwOTAgMDk3MCBmNTkxIDc1MzYgODMxMiAwNTUyIGQ0ZmQgODE3YiBiMzIz
DQowMDAwMGEwIDM5OGIgZTYzMyBkZjc3IDU5ZWUgZmQ0ZSA2OTIyIGU0YTkgYTE2MA0KMDAwMDBi
MCBkMjA2IDk2ZTEgYTkxNSA3ODJiIDFiNTMgYTliYyA3MGM2IDU2NzANCjAwMDAwYzAgNmRmZSBh
M2RlIGNhMWYgYmQwYQ0KMDAwMDBjOA0KDQpyb290QGFzdDI2MDAtZGVmYXVsdDovc3lzL2J1cy9p
M2MvZGV2aWNlcy81LTAjIGhleGR1bXAgL3RtcC9qYW1pbg0KMDAwMDAwMCAwNGNiIDJkODQgMGQ4
MCA0NWU2IDZjOWEgM2QyMyA5Mzg0IGIzZWYNCjAwMDAwMTAgZjUzNCAzMzI4IDVlMDcgYWM5NCA1
Y2Q2IDM5MTQgODZhZCBlMDg1DQowMDAwMDIwIGUwNDcgODFlMyBhZjUyIGJiODggZjIwYyBjMjgy
IDYxNDggNTM3NA0KMDAwMDAzMCA2YjdkIDU4YmYgZmIxYyAyMzgyIDEyMWYgMWE2MCBiZmI0IDFl
YmQNCjAwMDAwNDAgODAyOCAwYTgyIDQ3NDAgODI4NyA1NzM3IDk4OGYgNTk3ZSA5YTY3DQowMDAw
MDUwIGE3ZjcgYjBjOCBkYjg3IDI2MzEgODMwNCBkZjg5IDY5NzcgMmE4Mg0KMDAwMDA2MCAxMmQ4
IGZiNzMgYmNjNyBlY2QwIGViYTIgNTc1ZiBhMDUwIDAyZmINCjAwMDAwNzAgYWY0YiBmZmVmIGRh
NWIgNWNiMyAxNGEzIDcwNDcgMTdhYyBkMjM4DQowMDAwMDgwIGVkYTYgYWUzZSBhYzcyIDYxMTIg
YmJiZiBmYmNhIDg0NGQgMDM1ZQ0KMDAwMDA5MCAwOTcwIGY1OTEgNzUzNiA4MzEyIDA1NTIgZDRm
ZCA4MTdiIGIzMjMNCjAwMDAwYTAgMzk4YiBlNjMzIGRmNzcgNTllZSBmZDRlIDY5MjIgZTRhOSBh
MTYwDQowMDAwMGIwIGQyMDYgOTZlMSBhOTE1IDc4MmIgMWI1MyBhOWJjIDcwYzYgNTY3MA0KMDAw
MDBjMCA2ZGZlIGEzZGUgY2ExZiBiZDBhDQowMDAwMGM4DQoNCnJvb3RAYXN0MjYwMC1kZWZhdWx0
Oi9zeXMvYnVzL2kzYy9kZXZpY2VzLzUtMCMgZGQgaWY9L2Rldi9pM2MtNS0wIGJzPTEgY291bnQ9
MjAwIDI+L2Rldi9udWxsIHwgY21wIC0gL3RtcC9qYW1pbiAmJiBlY2hvICJQQVNTIiB8fCBlY2hv
ICJGQUlMIg0KUEFTUw0KDQpUaGUgZGF0YSByZWFkIGJhY2sgZnJvbSAvZGV2L2kzYy01LTAgbWF0
Y2hlcyB0aGUgb3JpZ2luYWwgZmlsZSBleGFjdGx5LCBhbmQgdGhlIGNvbXBhcmlzb24gcmVwb3J0
cyBQQVNTLg0KVGhpcyBjb25maXJtcyB0aGF0IHRoZSBtb2NrIEkzQyB0YXJnZXQgd29ya3MgY29y
cmVjdGx5IGFzIGFuIEVFUFJPTS1saWtlIGRldmljZSBhbmQgdGhhdCB0aGUgVFgvUlggZGF0YSBw
YXRoIHRocm91Z2ggdGhlIERXIEkzQyBjb250cm9sbGVyIG1vZGVsIGZ1bmN0aW9ucyBhcyBleHBl
Y3RlZCBvbiBBU1QyNjAwLg0KDQpUaGFua3MsDQpKYW1pbg0KDQo=

