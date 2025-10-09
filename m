Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B2ACCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 01:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6fIt-0004WG-Jr; Wed, 08 Oct 2025 21:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6fIr-0004Vy-9c; Wed, 08 Oct 2025 21:18:45 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6fId-0007uv-Rn; Wed, 08 Oct 2025 21:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpBbGBV18A/UQYFmhcFnDlr7hRgBzNIB/sVWP1KGfQVr6NjiuCX/rXaXT4Xxtn+XIu7jzR0dQQBlymVwMEsyeEl3NVgB20gT+Vh2gx6Lm5yUY6hVkCMkn6gcVhvYcnFkq3QJ6p4LE6YRqYtBbBu+cLW814DK29oHH7Q6NNQHh52qX3FUhOIKVX2Q8gHOJaZzCtLeKkClfnxusE45i0na3o0uUQK19zC5fNJtRmbyR+jgH+FgV8r0FlN0eb6L8x2D1mnLo24ylVGbZZ2i/P7JVKY2o3CA5eEhZATsjLShgwF3kDB8LJUEUcgemc6o9Q+UfmtSwmtcVkR64niRZgxPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xGPPCnxh1ZbSZ6Zx8W0/G5XJEukK1ZwDbmOJz9z+/k=;
 b=REQOgCBboudAAcZ8XWyOImjEFHGQW5cVCr+RmT2GQitFn7v+0OuupCU4TXh382gzzXvxySKF/rQcSzpanWG0XLFFFfVoDjg/LHbHAHN8n19VfFgO+sdyPctMHmvsVVGTh+ZU4rAHpwTS2R8PXEXNbjCulvY9IMg3SH3pIqGagSpMOVtx+LY55RPOqCwLGU3xr9+ae4pk9Q1nM73fjrrUEZq22kXYdVFzvLWdpyBsRqcUAWm8UN6X8sLI5zf6AsWhDeKEioHbz6WztGu1pT7pU2L4+8zfgOcyDjNCoxjCoQRNhNwzhdYHI8RnhPDEI9GbUbLsW53cAaDRIBXwXxaaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xGPPCnxh1ZbSZ6Zx8W0/G5XJEukK1ZwDbmOJz9z+/k=;
 b=mMjcz/iKiXwGvn+tJ8hpemcLOkGWDmh8OXUAOfX/LIIfyYmbj2+BRUYbMnqLYuQexh6Ust9SpndoETWsExiz1hUkjaRTcZ65fTsNt9a9yrphRO00afesxFmbW6xPPTNtrMdhNJlx4xsFEIUzMbIprnTrlDfjTTaExnWa+8K5UaP4Z1wsoKqhmaJR7oNjzT09l9LF8RFMO0/XH9rG4NJTf2Jx6BAk8+arO9QLdbPP/1WAh6zLEAszOM+jAiazW7BJL2iKvCQ+led3YaOaBsVw8rLJkxQpPmqjWjy3fN6CegY9eVWoSFjtU7759/BYek8JJa/A0eFVIDb0Co4FhYRssA==
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com (2603:1096:820:30::6)
 by TY1PPFECF6DCA7C.apcprd06.prod.outlook.com (2603:1096:408::92f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 9 Oct
 2025 01:18:08 +0000
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156]) by KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 01:18:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 09/16] hw/arm/aspeed: Introduce
 AspeedCoprocessor class and base implementation
Thread-Topic: [SPAM] [PATCH v1 09/16] hw/arm/aspeed: Introduce
 AspeedCoprocessor class and base implementation
Thread-Index: AQHcOALBM4w/0GRf3UeQ4sfVXx64lrS4bSAAgACXbGA=
Date: Thu, 9 Oct 2025 01:18:07 +0000
Message-ID: <KL1PR0601MB41961FD3E7FAABFBAA7ECF5BFCEEA@KL1PR0601MB4196.apcprd06.prod.outlook.com>
References: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
 <20251008032207.593353-10-jamin_lin@aspeedtech.com>
 <73c1f147-8251-48ff-8b3d-84afeb6b3186@kaod.org>
In-Reply-To: <73c1f147-8251-48ff-8b3d-84afeb6b3186@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4196:EE_|TY1PPFECF6DCA7C:EE_
x-ms-office365-filtering-correlation-id: 4a6dc1ca-f6ec-48e1-2cf0-08de06d1b48c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?UGkxVEJ4a0N2ajZGeEtKdHgwY0ttek40bWRrMENoanU3SXJuQnRObllMUmJJ?=
 =?utf-8?B?L1J0UkJQTnRFVkI2d2FhMll3NERIeUJBY1FaRUdJRlJpUFU2WW1lV09MWTNU?=
 =?utf-8?B?bU9VNzBub2txTnNHS3VvQU5DMzZHblJTUFBMM3FVQ25sRFA3aU1DNHlMZlNK?=
 =?utf-8?B?T3ZBODl0Y3NBTVF5L0RXZE9wYzdRQmYzQXYxczVOalpsbERTRm82ekw4eVRX?=
 =?utf-8?B?SDJDUVdIWngrNTh4Wmk1ZVNqYkpWd0cxMUR5anhaSmtBeTdNWHBnbnhwaFBR?=
 =?utf-8?B?OUlBcHJNU0ZiendWWWxmZzJ1SGEwcy9LaUJ4N0NFL3pYTmxaa21Za01mYWJr?=
 =?utf-8?B?b0dnUWgzK1FlSFJzcVB3U21PYVdKMDZpMnFMUTVvVTVNV2U5UlFNR3hBKzFW?=
 =?utf-8?B?YXd3UXloN3hXWVpyQ0dyZUNMRzNtalV2L1d5K0tRY2dqdUwxcFB0VS9CWlJQ?=
 =?utf-8?B?cXhsWGt0YjZIOHRPenEwV3pjbEkyQXFVcm1Ucjhjanl1TEpVRGwvR3JtakRL?=
 =?utf-8?B?OUtoWGY0OENWT0VydnRmZEJ3TUgva1BwTlNZSmFiZ3hCaisxRW5VYjYvRjM3?=
 =?utf-8?B?MktPdmFXOVg5a1RZYXp6ZzgxWGhOWGNqaGhxZGE4MXNXM1JxZXN5WHNDRy96?=
 =?utf-8?B?dUliVVhMQzYySGxHVno4MG9BZnF0bE5JbE95OXV5dTcwOVBSZ1pydjBVR0J1?=
 =?utf-8?B?QVgzZ1l2Szh0SnpjclZJeWIrMm1JR1Z5VC9ZZExIV0NoM1VWODVCL2VTS3Rs?=
 =?utf-8?B?WjU1MG4rZnNrRHB6M1BwYnhUa2xZS0Ewb09DUkpMdU1GR3RvL2oxdGFUSzgr?=
 =?utf-8?B?RG1IMUNvNUkycjBWOXFIRFJkdnZxSVFZWTdGbi9NZmxjUUZZQmFtbDF3MG9P?=
 =?utf-8?B?NktFckFGMEhLSktOZ2tFVkg2OEV2TU1IMms4cXMzSDZCckprWVR5NFMxZTNt?=
 =?utf-8?B?bENZczMwK01aUENNSTZEdEEzQUZEc0czUXlBV3M1cDZONXp4cERyZWg5V3N6?=
 =?utf-8?B?RE9zcnZEL1BNWk5qR0s1RHpDVjNBalVNeC92Q1V0bDUvd0pyRzRpWjYzcXVj?=
 =?utf-8?B?Y1o3T2ZTSkdnNTI2eWdoeWNJZmJIQ2RXM3FSWE5COXdYb2JMRWhBZHl4WTdB?=
 =?utf-8?B?Zjh0ZmgydGh0M2NEOUk3NUd4dEIwbFBobnFraHdlTER2MnE2Wm4ybjZ0L2o5?=
 =?utf-8?B?bGgvcTYvZVg1MGZJT3NpYjdNQTVCSUs4T2M3amw0ME5Xam5MVmY3RGNxakNC?=
 =?utf-8?B?dHFLZzdaK1dEL3JnN2hDVlRNRnJxb2VTOURmVUlaWG1pemRLVzl5eS8xZENo?=
 =?utf-8?B?MEVTSHZMWWswalFQRjFBcndHT3NaNk9Gck1RTTB5YnRIT0lVNjZORGMySXVx?=
 =?utf-8?B?WWZ0SEp3QUM3ZVBDbHRBempHNWRvam5qQjJZUCthT2tiZkF6cUFHNG9DTkJJ?=
 =?utf-8?B?YUtFVWRtd3lsZEkwRkZKTlBZb2l3cXJZSnpyakMxdCtldHRobDgyKzQrNFI4?=
 =?utf-8?B?Q2pJOFhLKzBLVTM1SjRvbUFIdDVOVm80ZkcwcS83SGIvWHJPdE8zZ3B2Yzda?=
 =?utf-8?B?d0YxSmVRWll3NEgwQmtwcVFYb1ZKUWdoWUJjelp6TlJnblQ3OXV1MkFwSWlj?=
 =?utf-8?B?OUpOUm9hcVNsKzdVdmtLSjYxTEpQUDZqTUIwQ2dNekhxcjNQcGdUeWZBd1dH?=
 =?utf-8?B?TUZaQklKNnRMckxkMDFLUEx1blh6cVhYNnRmcEx0dE1ZYVJYYmNYeGJWS1Rj?=
 =?utf-8?B?M3NiUkNmdmdRRzF3cFNGRnZ3dWpDRlhYS0xwSjZxNWFFemxhUjdhRzEvMTF3?=
 =?utf-8?B?aytqU3gyTE9HR1BPdHRkZDBhL3FJTmpGSFA0Q1U5Qmg3cmY0cTFOQ25Fazlt?=
 =?utf-8?B?NWZjUWR0dWticWwweG1wK1lxcHE3R21ETnB1QVoySDFEYTM2SC8wRDdRUXl5?=
 =?utf-8?B?WUZ4emU1V1ZIa3ZaRWVmL1RaanlOVTVkQWdmdEZRMG14T0J0aUlyM3ZOWjNY?=
 =?utf-8?B?NC9PQmIvMzNGa29vZnhET1R6MzVDdGU4ZUljY1doc0pvN2pIcDZZWWcyNEgr?=
 =?utf-8?B?aWJ4QU15L3BLTlJNb2lSVit1MTZjb293eUVmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4196.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEFSZHg3bFROZGNxNm4ydjZJVjd3bk1nZU9meTZ3emo4Y1BuR0czTHNzNWxT?=
 =?utf-8?B?OStyYloxc0tDRGlFbGJKMm4zTEVpeTFybzhNSW5BMjl1bjBrT2I3Rit0TXp0?=
 =?utf-8?B?OXFpQXh6STdUOGcrNldoVlJXUHJBVjlHbVZGUU1PTFZLU3lWL2RLM0xKSkNO?=
 =?utf-8?B?MVRjRzVVbVYwbFVud3I2L3R4ek4yUmQ1Wkp6WnptZFRydVdhOVFXL2FqQnBG?=
 =?utf-8?B?Z0s3UVU5aHhzVVp2SjVnWjBQWnVDM1J2N3k4TjZXaEtaRXRoblJTWmVxTisv?=
 =?utf-8?B?SWFEMG1JcWtPcFAwcUpXemlNall2Tkl6Sy9STTdRRTl1OE9haHFVY3ZZd0lP?=
 =?utf-8?B?cjNDMUx5YmRyRHRmZENsZGM4MzE2RXBDVnMycUlkNmRVd0tqNGprQ0FqMU1C?=
 =?utf-8?B?eEFHZ20xZVZDV09YWjhDQ0V0blRoNHBkWm1EbDBxL1pDQ3dlWHdBNUgwT0lh?=
 =?utf-8?B?YWxyYk5rN2pqMFFmWW1nMStFOEloTmFRWlp4S0dMaURRRFU1QWYxTUlUZDE2?=
 =?utf-8?B?dnB4eFd6M25McG5yNEtHKzB0RE9Pbi9JM3hTM09UQUZnNHpZMDBTU05RVktn?=
 =?utf-8?B?RTF1dTNUK0lEdWIzMHRNTHRqUDhPelE1MDQvMGJWT0R5Y0VUTkhaWkxwVzNi?=
 =?utf-8?B?ZmFXWlZBdkFWUDdkVDYrYjhnZG9XMEpNVko0TnBsU0JXVTFZK3VzVGF4KzZn?=
 =?utf-8?B?bjFvcHVjajVvM1RjOUk0bnAwMFMzMHptdStvU3p3c3VKK2hPTHlPODFRVU9H?=
 =?utf-8?B?NW50K1o5c1lNMjB5SWc3bkdYT2JtOU1LTUd1alZ3bFR4NXdFek50bmw0Q2RE?=
 =?utf-8?B?MWRUcExmNFBjaUpicWtKdjY1L3hFR2N3cVV1cjFVNlI3UTB0dS8vWVNoNlFn?=
 =?utf-8?B?YU1nSGREK1NmeXF0clVoUnNGRUVnT2dvcjloK0IyRnJGcTdXbjlJN3NISnEv?=
 =?utf-8?B?ZnRpd3JyYXF1eDB6S2VhWDVGUUpTNE55UzVJbjY0dDNxbkMxSUV2VmYvbHFN?=
 =?utf-8?B?SzkyQ2JibHpJT29oT2FjTms3VGhNVE1ocjdlZEZENURSSjV4bHVmandvK2tk?=
 =?utf-8?B?T09yYjVxTCt2RmcvWG5iVzdvNEZ3OURBQ0dtRlUrbG9jdVV6Q09uV3FPNXk1?=
 =?utf-8?B?akFtajBkMnltOHhTbUFFVVplTlR5R1ZmK0FBeXk4SlcyVTViZGFYTmVScURX?=
 =?utf-8?B?YmRXcEJ5V2pJbWNZVUxXTldGMjdpeVJQV0hxSDVrTENsaThhNzA1Z0RFZ1NC?=
 =?utf-8?B?d3dGSkF1VTI5NDlzcjFXWUZkWWFVeVNTWjRzTU9NbmV2a0RidUJwOGoyU0Rt?=
 =?utf-8?B?emRKNXN4bFJNSmcxTmdlTXA2TUZsRDlVeUVuZjExbFBVb0N4cXBHR3Y4RnJT?=
 =?utf-8?B?dmg3OUpDUXlOTDIwNlVadEVCcjlmbUFFUWR5MkNhdXd1UUFpcjVDTDMyeElZ?=
 =?utf-8?B?YnVRTWMxYWE4NmdlUW5IZGcvdi9hamxqMStPcGtDdjdWcTBNTFlSSkFsZ2g4?=
 =?utf-8?B?TXRZU0M0TkRwOVBVcVIxa3Rhc3VBNysrYk9OK0ppSWZ5c1VyZGM5R2dHUm5U?=
 =?utf-8?B?UU9Wck1FdEppM0dNUnZkWC96NHRhRW5RZTVuZjN0UkxLcjFaMTAxNkh1TU5I?=
 =?utf-8?B?TG9CY2lnRlZSR0JpenpPS2VNQVBrdVlLNm5OVHFyUlUvTHc1TlJFL2hEM2gr?=
 =?utf-8?B?R1Y0ZjN5VnM2Y1l3NEVDczFKRzFzbXhNUVFRaFd1RGpwS3lKYnNVUXhBMHph?=
 =?utf-8?B?NGlmZy9NYmFmaEZyMjIzaXV6aHVBVEN2bkkzSTM1YUpzUnBSYlNWbXRXeXZr?=
 =?utf-8?B?clcxM2JMaFlnZnlzdzcwWTcrT2g3ZCs4VnNqMW1rUVl1YkVZd2NtaHVZd2th?=
 =?utf-8?B?Rk9vR2QvWHV0QVoxWDlMUVdJNzZhakNSSFdiQWEwNjZhNnVaOWUwV1pOaUxG?=
 =?utf-8?B?MjRrbGdMZzMrLzlPeW9FT2pZd1QwaktYQ2xnY2tTbm5MT2FHaHVTMWtkenN3?=
 =?utf-8?B?V2hPZGIzWmZKODJYZGNnb3AvUktLbkxIUUdpc0tsaTE4RE44UDlkZXRlakZG?=
 =?utf-8?B?OUtyR21BeWUvSnUxdFpmeVd6WEM3NFc1Z2p4cjBBa0d3WUhGOWkzOW9GUnBr?=
 =?utf-8?Q?+8y0wf/2ExKzWpCs/taGhrSIK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4196.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6dc1ca-f6ec-48e1-2cf0-08de06d1b48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 01:18:08.0094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fvk1qTb8aCsDkcw8CavW+XfMz2gWHqIX/oSHJ7OiAU7+dhDDeHqOfcXd6V2gVmgaZ0uZhwJc5bESBdV2Nn9NcTDaBYRINoDNd+ZbIhwONYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFECF6DCA7C
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IEFzcGVlZENvcHJvY2Vzc29yIGNsYXNzIGFuZCBiYXNlIGltcGxlbWVu
dGF0aW9uDQo+IA0KPiBKYW1pbiwNCj4gDQo+IE9uIDEwLzgvMjUgMDU6MjEsIEphbWluIExpbiB3
cm90ZToNCj4gPiBBZGQgYSBuZXcgQXNwZWVkQ29wcm9jZXNzb3IgY2xhc3MgdGhhdCBkZWZpbmVz
IHRoZSBmb3VuZGF0aW9uYWwNCj4gPiBzdHJ1Y3R1cmUgZm9yIEFTUEVFRCBjb3Byb2Nlc3NvciBt
b2RlbHMuIFRoaXMgY2xhc3MgZW5jYXBzdWxhdGVzIGENCj4gPiBiYXNlIERldmljZVN0YXRlIHdp
dGggbGlua3MgdG8gc3lzdGVtIG1lbW9yeSwgY2xvY2ssIGFuZCBwZXJpcGhlcmFsDQo+ID4gY29t
cG9uZW50cyBzdWNoIGFzIFNDVSwgU0NVSU8sIFRpbWVyIENvbnRyb2xsZXIsIGFuZCBVQVJUcy4N
Cj4gPg0KPiA+IEludHJvZHVjZSB0aGUgY29ycmVzcG9uZGluZyBpbXBsZW1lbnRhdGlvbiBmaWxl
DQo+ID4gYXNwZWVkX2NvcHJvY2Vzc29yX2NvbW1vbi5jLCB3aGljaCBwcm92aWRlcyB0aGUNCj4g
PiBhc3BlZWRfY29wcm9jZXNzb3JfcmVhbGl6ZSgpIG1ldGhvZCwgcHJvcGVydHkgcmVnaXN0cmF0
aW9uLCBhbmQgUU9NDQo+ID4gdHlwZSByZWdpc3RyYXRpb24uIFRoZSBjbGFzcyBpcyBtYXJrZWQg
YXMgYWJzdHJhY3QgYW5kIGludGVuZGVkIHRvDQo+ID4gc2VydmUgYXMgYSBjb21tb24gYmFzZSBm
b3Igc3BlY2lmaWMgY29wcm9jZXNzb3IgdmFyaWFudHMgKGUuZy4gU1NQL1RTUA0KPiBzdWJzeXN0
ZW1zKS4NCj4gPg0KPiA+IFRoaXMgZXN0YWJsaXNoZXMgYSByZXVzYWJsZSBhbmQgZXh0ZW5zaWJs
ZSBmcmFtZXdvcmsgZm9yIG1vZGVsaW5nDQo+ID4gQVNQRUVEIGNvcHJvY2Vzc29yIGRldmljZXMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9jb3Byb2Nlc3Nvci5o
IHwgNDUNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L2FybS9hc3BlZWRf
Y29wcm9jZXNzb3JfY29tbW9uLmMgIHwgNDkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgIGh3L2FybS9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgIHwgIDMgKy0NCj4g
PiAgIDMgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9jb3Byb2Nlc3Nvci5o
DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvYXJtL2FzcGVlZF9jb3Byb2Nlc3Nvcl9jb21t
b24uYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9jb3Byb2Nl
c3Nvci5oDQo+ID4gYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfY29wcm9jZXNzb3IuaA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMC4uNjkzOGRmZTI0Yw0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfY29wcm9jZXNz
b3IuaA0KPiA+IEBAIC0wLDAgKzEsNDUgQEANCj4gPiArLyoNCj4gPiArICogQVNQRUVEIENvcHJv
Y2Vzc29yDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyNSBBU1BFRUQgVGVjaG5v
bG9neSBJbmMuDQo+ID4gKyAqDQo+ID4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyICAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBBU1BFRURfQ09QUk9DRVNTT1Jf
SA0KPiA+ICsjZGVmaW5lIEFTUEVFRF9DT1BST0NFU1NPUl9IDQo+ID4gKw0KPiA+ICsjaW5jbHVk
ZSAicW9tL29iamVjdC5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvYXJtL2FzcGVlZF9zb2MuaCINCj4g
PiArDQo+ID4gK3N0cnVjdCBBc3BlZWRDb3Byb2Nlc3NvclN0YXRlIHsNCj4gPiArICAgIERldmlj
ZVN0YXRlIHBhcmVudDsNCj4gPiArDQo+ID4gKyAgICBNZW1vcnlSZWdpb24gKm1lbW9yeTsNCj4g
PiArICAgIE1lbW9yeVJlZ2lvbiBzcmFtOw0KPiA+ICsgICAgQ2xvY2sgKnN5c2NsazsNCj4gPiAr
DQo+ID4gKyAgICBBc3BlZWRTQ1VTdGF0ZSBzY3U7DQo+ID4gKyAgICBBc3BlZWRTQ1VTdGF0ZSBz
Y3VpbzsNCj4gPiArICAgIEFzcGVlZFRpbWVyQ3RybFN0YXRlIHRpbWVyY3RybDsNCj4gPiArICAg
IFNlcmlhbE1NIHVhcnRbQVNQRUVEX1VBUlRTX05VTV07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsj
ZGVmaW5lIFRZUEVfQVNQRUVEX0NPUFJPQ0VTU09SICJhc3BlZWQtY29wcm9jZXNzb3IiDQo+ID4g
K09CSkVDVF9ERUNMQVJFX1RZUEUoQXNwZWVkQ29wcm9jZXNzb3JTdGF0ZSwgQXNwZWVkQ29wcm9j
ZXNzb3JDbGFzcywNCj4gPiArICAgICAgICAgICAgICAgICAgICBBU1BFRURfQ09QUk9DRVNTT1Ip
DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgQXNwZWVkQ29wcm9jZXNzb3JDbGFzcyB7DQo+ID4gKyAgICBE
ZXZpY2VDbGFzcyBwYXJlbnRfY2xhc3M7DQo+ID4gKw0KPiA+ICsgICAgLyoqIHZhbGlkX2NwdV90
eXBlczogTlVMTCB0ZXJtaW5hdGVkIGFycmF5IG9mIGEgc2luZ2xlIENQVSB0eXBlLiAqLw0KPiA+
ICsgICAgY29uc3QgY2hhciAqIGNvbnN0ICp2YWxpZF9jcHVfdHlwZXM7DQo+ID4gKyAgICB1aW50
MzJfdCBzaWxpY29uX3JldjsNCj4gPiArICAgIGNvbnN0IGh3YWRkciAqbWVtbWFwOw0KPiA+ICsg
ICAgY29uc3QgaW50ICppcnFtYXA7DQo+ID4gKyAgICBpbnQgdWFydHNfYmFzZTsNCj4gPiArICAg
IGludCB1YXJ0c19udW07DQo+ID4gKyAgICBxZW11X2lycSAoKmdldF9pcnEpKHZvaWQgKmN0eCwg
aW50IGRldik7IH07DQo+ID4gKw0KPiA+ICsjZW5kaWYgLyogQVNQRUVEX0NPUFJPQ0VTU09SX0gg
Ki8NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9jb3Byb2Nlc3Nvcl9jb21tb24uYw0K
PiA+IGIvaHcvYXJtL2FzcGVlZF9jb3Byb2Nlc3Nvcl9jb21tb24uYw0KPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMC4uOGE5NGI0NGYwNw0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2NvcHJvY2Vzc29yX2NvbW1vbi5jDQo+ID4g
QEAgLTAsMCArMSw0OSBAQA0KPiA+ICsvKg0KPiA+ICsgKiBBU1BFRUQgQ29wcm9jZXNzb3INCj4g
PiArICoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI1IEFTUEVFRCBUZWNobm9sb2d5IEluYy4N
Cj4gPiArICoNCj4gPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIgICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVk
ZSAicWFwaS9lcnJvci5oIg0KPiA+ICsjaW5jbHVkZSAic3lzdGVtL21lbW9yeS5oIg0KPiA+ICsj
aW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQo+ID4gKyNpbmNsdWRlICJody9hcm0vYXNw
ZWVkX2NvcHJvY2Vzc29yLmgiDQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfY29wcm9j
ZXNzb3JfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPiA+ICsqKmVycnApIHsNCj4g
PiArICAgIEFzcGVlZENvcHJvY2Vzc29yU3RhdGUgKnMgPSBBU1BFRURfQ09QUk9DRVNTT1IoZGV2
KTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXMtPm1lbW9yeSkgew0KPiA+ICsgICAgICAgIGVycm9y
X3NldGcoZXJycCwgIidtZW1vcnknIGxpbmsgaXMgbm90IHNldCIpOw0KPiA+ICsgICAgICAgIHJl
dHVybjsNCj4gPiArICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IFByb3Bl
cnR5IGFzcGVlZF9jb3Byb2Nlc3Nvcl9wcm9wZXJ0aWVzW10gPSB7DQo+ID4gKyAgICBERUZJTkVf
UFJPUF9MSU5LKCJtZW1vcnkiLCBBc3BlZWRDb3Byb2Nlc3NvclN0YXRlLCBtZW1vcnksDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIFRZUEVfTUVNT1JZX1JFR0lPTiwgTWVtb3J5UmVnaW9uICop
LCB9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX2NvcHJvY2Vzc29yX2NsYXNzX2lu
aXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lkDQo+ID4gKypkYXRhKSB7DQo+ID4gKyAgICBE
ZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Mob2MpOw0KPiA+ICsNCj4gPiArICAgIGRjLT5y
ZWFsaXplID0gYXNwZWVkX2NvcHJvY2Vzc29yX3JlYWxpemU7DQo+ID4gKyAgICBkZXZpY2VfY2xh
c3Nfc2V0X3Byb3BzKGRjLCBhc3BlZWRfY29wcm9jZXNzb3JfcHJvcGVydGllcyk7IH0NCj4gPiAr
DQo+ID4gK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfY29wcm9jZXNzb3JfdHlwZXNbXSA9
IHsNCj4gPiArICAgIHsNCj4gPiArICAgICAgICAubmFtZSAgICAgICAgICAgPSBUWVBFX0FTUEVF
RF9DT1BST0NFU1NPUiwNCj4gPiArICAgICAgICAucGFyZW50ICAgICAgICAgPSBUWVBFX0RFVklD
RSwNCj4gPiArICAgICAgICAuaW5zdGFuY2Vfc2l6ZSAgPSBzaXplb2YoQXNwZWVkQ29wcm9jZXNz
b3JTdGF0ZSksDQo+ID4gKyAgICAgICAgLmNsYXNzX3NpemUgICAgID0gc2l6ZW9mKEFzcGVlZENv
cHJvY2Vzc29yQ2xhc3MpLA0KPiA+ICsgICAgICAgIC5jbGFzc19pbml0ICAgICA9IGFzcGVlZF9j
b3Byb2Nlc3Nvcl9jbGFzc19pbml0LA0KPiA+ICsgICAgICAgIC5hYnN0cmFjdCAgICAgICA9IHRy
dWUsDQo+ID4gKyAgICB9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArREVGSU5FX1RZUEVTKGFzcGVl
ZF9jb3Byb2Nlc3Nvcl90eXBlcykNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL21lc29uLmJ1aWxk
IGIvaHcvYXJtL21lc29uLmJ1aWxkIGluZGV4DQo+ID4gZGM2ODM5MTMwNS4uMGIyYzY2ZTM5MSAx
MDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vbWVzb24uYnVpbGQNCj4gPiArKysgYi9ody9hcm0vbWVz
b24uYnVpbGQNCj4gPiBAQCAtNTIsNyArNTIsOCBAQCBhcm1fc3MuYWRkKHdoZW46ICdDT05GSUdf
QVNQRUVEX1NPQycsIGlmX3RydWU6DQo+IGZpbGVzKA0KPiA+ICAgICAnZmJ5MzUuYycpKQ0KPiA+
ICAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogWydDT05GSUdfQVNQRUVEX1NPQycsDQo+ICdUQVJH
RVRfQUFSQ0g2NCddLCBpZl90cnVlOiBmaWxlcygNCj4gPiAgICAgJ2FzcGVlZF9hc3QyN3gwLmMn
LA0KPiA+IC0gICdhc3BlZWRfYXN0Mjd4MC1mYy5jJywpKQ0KPiA+ICsgICdhc3BlZWRfYXN0Mjd4
MC1mYy5jJywNCj4gPiArICAnYXNwZWVkX2NvcHJvY2Vzc29yX2NvbW1vbi5jJywpKQ0KPiANCj4g
SSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGtlZXAgdGhlIGVuZGluZyBjb21tYSAnLCcuDQo+IA0K
PiANCj4gTW9yZSBpbXBvcnRhbnQsIHRoaXMgbGlzdCBsYWNrcyBzb3VyY2UgZmlsZXMgOg0KPiAN
Cj4gICAgJ2FzcGVlZF9hc3QyN3gwLXNzcC5jJywNCj4gICAgJ2FzcGVlZF9hc3QyN3gwLXRzcC5j
JywNCj4gDQo+IHdoaWNoIGFyZSBhYXJjaDY0IHNwZWNpZmljIGFuZCB3aXRoIHRoZSBmb2xsb3dp
bmcgY2hhbmdlcyBvZiB0aGlzIHNlcmllcywgJ21ha2UNCj4gY2hlY2snIGZhaWxzIHdpdGggOg0K
PiANCj4gICAgVHlwZSAnYXNwZWVkMjd4MHNzcC1zb2MnIGlzIG1pc3NpbmcgaXRzIHBhcmVudCAn
YXNwZWVkLWNvcHJvY2Vzc29yJw0KPiANCj4gQSBwcmVsaW1pbmFyeSBmaXggaXMgbmVlZGVkLg0K
PiANCj4gUGxlYXNlIHJ1biAgJ21ha2UgY2hlY2snICBiZWZvcmUgc2VuZGluZy4NCj4gDQpUaGFu
a3MgZm9yIHJlcG9ydGluZyB0aGlzIGlzc3VlLg0KSeKAmWxsIHJ1biB0aGUgdGVzdHMgYW5kIHJl
c2VuZCB2Mi4NCg0KSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiAN
Cj4gPiAgIGFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfTVBTMicsIGlmX3RydWU6IGZp
bGVzKCdtcHMyLmMnKSkNCj4gPiAgIGFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfTVBT
MicsIGlmX3RydWU6IGZpbGVzKCdtcHMyLXR6LmMnKSkNCj4gPiAgIGFybV9jb21tb25fc3MuYWRk
KHdoZW46ICdDT05GSUdfTVNGMicsIGlmX3RydWU6IGZpbGVzKCdtc2YyLXNvYy5jJykpDQoNCg==

