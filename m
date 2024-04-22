Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33F2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvyg-0007GU-2p; Mon, 22 Apr 2024 11:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyc-0007En-KK
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:07 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvya-0007bi-A8
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713801184; x=1745337184;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+LHzGGTePn0RaqptDHEDrSl1w04MX+QIm9g9KSw5pQc=;
 b=KmnyE0vNI6+c/bn568bZgrNIUcG9g0L5PsbQwEdTi0aR+Ff6w9Xb02NJ
 LYdhRRpmd1lIuCKI5DzdnenJOQDCurVrvh/RrcGoJJ8jb5UyBoNX/4Jvx
 qweGOSUPAOxbrnIIn1bkdOm46jpn525fko1S+6ww5lBHFqxfnI72L5rON
 L68VYtXujDRKhhJbQRcguOdjY6pOmKXdhkosapmPwe309RAASM6sPEVDx
 jSBdyxt3q74j6vyJunCIDaTM2z2HgK0NgfnCNamPvdscencx3eNYgsp0s
 ZU+LJommxAJJcz8Q+da8jklKcdUrH6LlRa/PWnO6cjDlfxAKnQ68h5hnM w==;
X-IronPort-AV: E=Sophos;i="6.07,220,1708383600"; d="scan'208";a="11027676"
X-MGA-submission: =?us-ascii?q?MDF9dV70uxgRkGjiilNgkvw3ImfiopoTwfS/FU?=
 =?us-ascii?q?tF847X224Ro7b4qpqXqEDKjGqUJWYM/EFfm7j3EG0N5R8imFoDdqVSIW?=
 =?us-ascii?q?LN+o5JefLoShLPJ9fErWw4bdqCVAJhDxd4N5IQLSdV+u9/QFvIQmyBVS?=
 =?us-ascii?q?wSTnJkOmrACO9S9tK2LQGvyw=3D=3D?=
Received: from mail-am0eur02lp2233.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.233])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 17:52:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsZgWHNybD8GTzbjdZcT9/G4Iq/m7dZxj4LIfaaeDp+/tjaw8yB7bK4kGBamBl9DjJ6ofrw+fgK1UxFCIle87qYCYRJMZl92Vt4X46wVyE8/RQip6x04ZgnFzKdsLuqDFK8zMFcqhDPYrd2aJvFp0R2H88fWqu/hduZWMj4TSWbnYNBYdqWSoNUwTr6DCpZRhzYoXJZn39uMqAO3I57tSDj+1TNPR6ulRHwJBQGTLeIEfFx3PYDZl8x1z8sOwLzfk/i6fKLSBqc7iBzyQNkGt9gZ9ZAx4p6Cur8Tt7l4HRl4NXq1e13aqRg1n/7jibKaIr8eIP0Q/KZCSahrNHw1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LHzGGTePn0RaqptDHEDrSl1w04MX+QIm9g9KSw5pQc=;
 b=JFzXi9BQhTQ+NYxALULqdpTHYafUtf+N/INn0sneQHi8Ko6NCij52TUvWbqcg/E40W0x4KNm68EfTdipS9Htab1LSmkYIzBVvfW9Vw35ZampKSMbJSre0j+Ryy45uG3R9plWK/AR05udVbVCKELTRWSFexBmg/8Ur2HWb2J6XmTXu4wHb3dZIyXZ37hTbl8M9ZO+BThKnxMluKDprmiTenln7V3vP+n60Q7EWI0mP/PB87tB17wzXl10zu+I1Yw47L2Xr79FgtHcgnJj9mkNOaJ7MfCzKws5xB1xMe+yECNcPB5M1Db/CVRD4QI69ur2LtrZ7d/fNXq5o+xN7UH+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9626.eurprd07.prod.outlook.com (2603:10a6:10:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:52:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:52:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH intel_iommu 7/7] intel_iommu: add a CLI option to enable FLTS
Thread-Topic: [PATCH intel_iommu 7/7] intel_iommu: add a CLI option to enable
 FLTS
Thread-Index: AQHalM0jTHnuMRmV0kmlngTXDZeiHg==
Date: Mon, 22 Apr 2024 15:52:53 +0000
Message-ID: <20240422155236.129179-8-clement.mathieu--drif@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9626:EE_
x-ms-office365-filtering-correlation-id: baf614a6-9162-4e33-b458-08dc62e446de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?U1hvTnBmMHZRRVRyK3hIV254YWV5dG1VV3ZsNFBSYzdFSG1Fckhlb25oeGdn?=
 =?utf-8?B?dHdXUlkxUmorbXNuU2lENWl1bFJuY1RFaGplcm9EYkVyajhVRVFoQzhBdmNY?=
 =?utf-8?B?V2xWREtLUDdTZnVzKzVqK0FsU3VWcE1tSWFHVmxPTzhuZWlFSTR4eFkxUklT?=
 =?utf-8?B?MUNNQmtjbVkwQWRnOFlMZ2Z1cFpXb3hMak1PVS9oQkdLSzJaL1V6c1dpUzdv?=
 =?utf-8?B?Qy8xenQzZnRGN29wNUNoSmdzMkJ5V3lGSlZ4Ui9PWUl2MXM5NEpaVFZNckli?=
 =?utf-8?B?RGlEM1JSVUEwMU9kdk5tRG1vWGRGZ2Y5akhmdUVPVjZ6YTJiTEhGSmJReERk?=
 =?utf-8?B?ajhDenBiUy9GdjhkNmRRRktkcjZQdmF5cHBRU3ZER0prY2RUWkExY1ZLc2lo?=
 =?utf-8?B?dFFoQ3JZWkZPanBQT0VsejNWZmJISVJpL1dTRFlpU2NsM0ZPYUxlRlRJQSsw?=
 =?utf-8?B?Ly9BcjJXalh3NXRrZUNTOEFHMGFzWlhCTCtSMUpqVHArU29vdjk5Y0pSblU2?=
 =?utf-8?B?RzBBaFhMM0owcFZYNEVBanNoWUVvSFVjSWFZNmFnd0x0TVh0K0IxcUE1aFJs?=
 =?utf-8?B?MUxudTdydWg0MldBNVYwTjlnaXlDSG9QdG1Tckp6Umx0S2JvcVlCaThMcXp4?=
 =?utf-8?B?eEdSSHBYUE0xTFJiV2NtdzBybXRMZDZZQTdndkxHa2o4czVnamUxYlliaEt4?=
 =?utf-8?B?QmFrWGgxZ04xSXowMWVnT3Fib1VHekZnMVp3a1RQelJSSGQ2K0dCVTBFMjJx?=
 =?utf-8?B?Z3hEVHNjZDE0WDdjajhQbEh3UGUwUW54TngzWDhiRStDY3J4dks1a3VUTEwy?=
 =?utf-8?B?NFFmZmFMajBFVkhBZlJ3MnI0M2Y2bk54UUw2OEpTUmRQTi9FRCt4cHBvcnli?=
 =?utf-8?B?N3dqMEZqdXYrSHZtWWlncWJ1T2tKNk5lVkZQMUs4Uzl4TDNuZlhmNFNQdm1I?=
 =?utf-8?B?djRkeE1hVFVNT1Fxdmw3Q1AxeGpORHVXd2RTT3VueWJHRlhMN3d2bWJGTTBv?=
 =?utf-8?B?bHo2ZG5lTzRHNStTZUZSRFcvWldSOGdEMmM5MUROZmF0Umk2SyswUGhqbFBm?=
 =?utf-8?B?VEJTRW4reHBVVjlnSGR2RkM1aUNSZWN2Smg5R1NNL3dnaitJem95L3lyeUhi?=
 =?utf-8?B?dktTYjhRV3hWVGdFbm5waUFDMlZ0Y3h6U3Z6a3A3TEpQb3VZTGRFVzdPY2FS?=
 =?utf-8?B?OW8rck5wandRbWdUTmp2TVErLzh4aGFoeS9EQWl6VnIrN1RqbklCQTZTL0ta?=
 =?utf-8?B?dGJjREpJdVlKL3d0OHlJT0FyWHJlWDBYcE95bE4za3VQNHYxVU9nZExaZVdZ?=
 =?utf-8?B?TXJyZlh2eWFkRFFjR3FSa21EcEFkVVJHYkYzc0owS2VMd3YvdUw1bDkwdTFL?=
 =?utf-8?B?MFcwZEMxdmp1c0h0SkNUK1NXUysxRSs4N01pQmxqVVQ3eitxdnpOQUUyTTFI?=
 =?utf-8?B?U21XWkVtb2V1QW5WSmJaWlV2clF1Ung1VHl1NENKRlYva0N4NEIwTmxDcUg2?=
 =?utf-8?B?L0V6a0QvYVVNR0FKVTU4ZGpQa2gxQnFkYVdoV1pqbE8zcFF1TDN1Um1GK0xQ?=
 =?utf-8?B?OXV3MXphSjZzUlo5RXR4ZWlMVUM4c0pYRmRVc0ltUG04WTIwSU5GUFcvYnRT?=
 =?utf-8?B?VXhLLzlMelg4aG50a2NLaHVoK3JNbnVVblFjWGJQcWdBeFRpK2t1ejVWaFcz?=
 =?utf-8?B?VE5UOFozS3NRZVF4K0NXODU1eHlXQ2VKa1RuNzhwdXpzL3pKWThHYzR1cEFX?=
 =?utf-8?B?cUZTR1RnRGxiZWlzeVpnZzJiVWZsQjgyeEZnV1VGaTQvRDV3UVpvVEpPUll1?=
 =?utf-8?B?bDFrd1NiQVdGdGJvTFpGQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkhNZkU4dEFzS0lIMjhIdVNyK2tsc1RBUXpFMlltazlZUGFjRGtWSHlXUEEr?=
 =?utf-8?B?clRTN2hWN2drWFJ5UFZsc2FxemxJNmNGNVRURFh6ZlFoMXdEUE9NTFJZUUpG?=
 =?utf-8?B?dzFNNjhML0lZTkx2TWNRbW84eld5Y0hyejdIN24vb0YyekFKL1d5d0xERU90?=
 =?utf-8?B?TkRKY2dNUEl2UWVGMDc1MWh3SEtDWDAyT3RkSC96Qlc4TUs4UzVzSHBaWDNo?=
 =?utf-8?B?VWcwTDlMSHdyRlFFUXNvUVdNRERNMWY2Qm5OdmJDcUg1cGttTDZaYlRJVWtG?=
 =?utf-8?B?TXdxUFJ5eFJZaTdIYUppam56eDI5VTRFRWNYRVBjYWhJSTdUbkx5TGQxZk5t?=
 =?utf-8?B?Vm45RWhuOSsvQXp6cnB3YnJYdkZQbUpHRm5HZHNPTG4vRlo1TERFVWpTNGd0?=
 =?utf-8?B?TW5Sd29oMmhVVDA2VnhsL3B0TUZyK21SK2x3MGFPWVFaMy9wVk83cDVCQlZX?=
 =?utf-8?B?YmZsRFNySDNCVTR0MG1XeiszMkFqNmhjL1c2R1lqM0dkS0NOZE0wS0Y4c3hC?=
 =?utf-8?B?U3RiY1ZWYWo5QzJMaWVZdjdDZ3hPZFNsaWR1WFJvSGprdnlMdmViOUVLdUVq?=
 =?utf-8?B?VEtFU3JJdE5PZWFWS0ZvMWRlMVBjdjZib0M4OUk4MVdCanI3UFgrMzlBd3ZV?=
 =?utf-8?B?bmVOeWw2RTB2cXBJYkJ3TXpLMGlWRk1SVWVNc2RxTUMzWGZGOE1SRTBTYmlw?=
 =?utf-8?B?QXVISjExZkVEdU93d0xvRnRBR005ZnZ5dGc1SVZPd3MyV1ZGTFNzLzJ3dnQz?=
 =?utf-8?B?VXpMaGYwUisvWEpobkdNeHFaZXhpTVBUMklJaHIvdFl6OU1iM0U2cWRDQk04?=
 =?utf-8?B?ai9DR1hlSFJEb1YzYWd6amhTajdLVkRPcEc3cGMrQ0htbHQ4aUR4V0lWMDVG?=
 =?utf-8?B?aEdqZ2RUanVOTUp3dmVpdnhTOW1IQTJrSHJNNVZSOUFrUmprNnJNdGVXbnhr?=
 =?utf-8?B?OTYrQndXbkIrUjhGZ1g3VzFwUjRNQ1h4emFyWUZFOSs4QTBVRnFJdThEeWxl?=
 =?utf-8?B?a2JCeElsWEI1VzgzY3ovTWczdloyRG1sNGhsYnNxYXEyb3Rua3V2VHkrUjJD?=
 =?utf-8?B?cWtOMlBBNVpRZWtTSWIzc1ljYVBPTitlblhzWkc5M0srZkVUUXYyYTUwOUFT?=
 =?utf-8?B?RTdsMXBzbTllNTUzTi9iaDhsYXF6UUh6QkJBQ3pIL1VPU1BDMEN0QTJYbzBo?=
 =?utf-8?B?bk9mVEtKZ09EOSszcnk0ckxZeWk2akZiSWY1NHJwS3hTU0U5aWxFK1l6SzZv?=
 =?utf-8?B?NTI4dlBBQkpQM01XdFhYRTNuUFpwdDVTSVFHR2xDU25MLzR5ZS9Tb2dMZmNR?=
 =?utf-8?B?WUIvRURaQUVMMDgxRExmN2xhY0xLMnZTQ0x1U2RKQXBDVWhJWGhvVnhzTEhy?=
 =?utf-8?B?aFBxMlo4QVhsRW45L1BYRDVEUkMwT1J5Um96QkNKYjVjMHBIcjFqVnVnZi8w?=
 =?utf-8?B?SEVyK29XMzJXSUthaHVtZEltd0RLVXFZWmVSNEdCaU1mMWNZQkZxRy9wc1l5?=
 =?utf-8?B?WUhCRVJrY0RLYTVsZkJYd1ZXY3AvVnJxMnRBNys3a25VakRLYmd4dGtDV3Nl?=
 =?utf-8?B?UzAzM2g3L2NBWUJwZGdjRG9wSHBXUVZOVGtvM1lJeTJ4Q04vVkVLV3NDaTU2?=
 =?utf-8?B?ZzJmY0llOTN2Z0lSalVQbWFxdVJrdDB1NVRsc0dTd0J0YktwNll2SzRMbjhh?=
 =?utf-8?B?UE5iRVhKZE1qZlJJK1ZlWkZ3Y1Z5cWp4L0k4OFNrTjlWaTFmQ2g0SWx5aFJ1?=
 =?utf-8?B?SngxYkt6K25OSWx2V0ZYUlVIRWNFODVQUkVudlZhVE9QSlNmVVIvL3BKWFox?=
 =?utf-8?B?VHVDVXgyeFVLYkU5TGxYSEdLSDJmeE1CNGc4Z1EzanloeTExb1pYeG9VNVZj?=
 =?utf-8?B?RUlsd1YxY1p4QmFjSmpDakh5Z2Y4OVY2eUFLU20zdDRyRXNKamN1U1FINndy?=
 =?utf-8?B?MUVvZFdwNTVTbHErUVN1MDZWcXBsS25zSmE2dGEycTl6YjVZcmVCbkR2Zk5j?=
 =?utf-8?B?RTNwQzhtUUV0U3c5cnZaazhrN2FIaE9ZZFVjbmloWEYwRWRvL0Voak5yNVBT?=
 =?utf-8?B?MlJmTHMzbUphSURiMVF5eEkrc2pwb2pxK1J6eWhRZ2pBUzcrbngvc2FyRzVT?=
 =?utf-8?B?cnNPYmx5TVF1NVVhdWJPOWdLeDlmWUxVWTFlWkRXTk02NUowZ3pKMkFKZGlv?=
 =?utf-8?Q?YY7Sp8zAqNxPl3UaXHtwemc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C12FCDACB584794AABB02E7577707339@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf614a6-9162-4e33-b458-08dc62e446de
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 15:52:53.9903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNFH02bBBIs0P2Jhc8nUZotgs4Xn6HPW7LHFwyza29EUxH0aKhIXpyhHnAK6Kfr/1lV5eztAtRGCpM5efh7MdKXU2BkYkU6PAI8w43lecvQaO2+Vj+lC72Gn0iQWaB1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9626
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDYg
KysrKysrDQogaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAxICsNCiAyIGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCA0YjU0YTQ1MTA3Li5jMzVjY2MzYTk4
IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCkBAIC0zNzA0LDYgKzM3MDQsNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3Bl
cnRpZXNbXSA9IHsNCiAgICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50
ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLCBGQUxTRSksDQogICAgIERFRklORV9QUk9QX0JP
T0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2wsIGZhbHNl
KSwNCiAgICAgREVGSU5FX1BST1BfQk9PTCgieC1wYXNpZC1tb2RlIiwgSW50ZWxJT01NVVN0YXRl
LCBwYXNpZCwgZmFsc2UpLA0KKyAgICBERUZJTkVfUFJPUF9CT09MKCJmbHRzIiwgSW50ZWxJT01N
VVN0YXRlLCBmbHRzLCBmYWxzZSksDQogICAgIERFRklORV9QUk9QX0JPT0woImRtYS1kcmFpbiIs
IEludGVsSU9NTVVTdGF0ZSwgZG1hX2RyYWluLCB0cnVlKSwNCiAgICAgREVGSU5FX1BST1BfQk9P
TCgiZG1hLXRyYW5zbGF0aW9uIiwgSW50ZWxJT01NVVN0YXRlLCBkbWFfdHJhbnNsYXRpb24sIHRy
dWUpLA0KICAgICBERUZJTkVfUFJPUF9FTkRfT0ZfTElTVCgpLA0KQEAgLTQ0MTMsNiArNDQxNCwx
MSBAQCBzdGF0aWMgdm9pZCB2dGRfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQogICAgICAgICBz
LT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEOw0KICAgICB9DQogDQorICAgIGlmIChzLT5mbHRzKSB7
DQorICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX0ZMVFM7DQorICAgICAgICBzLT5jYXAgfD0g
VlREX0NBUF9GUzFHUDsNCisgICAgfQ0KKw0KICAgICB2dGRfcmVzZXRfY2FjaGVzKHMpOw0KIA0K
ICAgICAvKiBEZWZpbmUgcmVnaXN0ZXJzIHdpdGggZGVmYXVsdCB2YWx1ZXMgYW5kIGJpdCBzZW1h
bnRpY3MgKi8NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBiL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQppbmRleCBiOWEwMTU1NmVjLi42ZWNjOGJiOGE5
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCisrKyBiL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQpAQCAtMjYzLDYgKzI2Myw3IEBAIHN0cnVjdCBJbnRl
bElPTU1VU3RhdGUgew0KICAgICBib29sIGNhY2hpbmdfbW9kZTsgICAgICAgICAgICAgIC8qIFJP
IC0gaXMgY2FwIENNIGVuYWJsZWQ/ICovDQogICAgIGJvb2wgc2NhbGFibGVfbW9kZTsgICAgICAg
ICAgICAgLyogUk8gLSBpcyBTY2FsYWJsZSBNb2RlIHN1cHBvcnRlZD8gKi8NCiAgICAgYm9vbCBz
bm9vcF9jb250cm9sOyAgICAgICAgICAgICAvKiBSTyAtIGlzIFNOUCBmaWxlZCBzdXBwb3J0ZWQ/
ICovDQorICAgIGJvb2wgZmx0czsgICAgICAgICAgICAgICAgICAgICAgLyogUk8gLSBpcyBGUyB0
cmFuc2xhdGlvbiBzdXBwb3J0ZWQ/ICovDQogDQogICAgIGRtYV9hZGRyX3Qgcm9vdDsgICAgICAg
ICAgICAgICAgLyogQ3VycmVudCByb290IHRhYmxlIHBvaW50ZXIgKi8NCiAgICAgYm9vbCByb290
X3NjYWxhYmxlOyAgICAgICAgICAgICAvKiBUeXBlIG9mIHJvb3QgdGFibGUgKHNjYWxhYmxlIG9y
IG5vdCkgKi8NCi0tIA0KMi40NC4wDQo=

