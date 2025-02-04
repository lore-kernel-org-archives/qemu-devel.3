Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B742C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfCvy-0002HC-Ml; Tue, 04 Feb 2025 02:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfCvm-0001z7-FV; Tue, 04 Feb 2025 02:01:13 -0500
Received: from mail-sg2apc01on2072e.outbound.protection.outlook.com
 ([2a01:111:f403:200f::72e]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfCvi-0000Tx-8m; Tue, 04 Feb 2025 02:01:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiGWGilthHnZVIYIIRBRcXyxnbBHbucivlDr+C3/oqI8pTp+JxOHGzblL4lBMb7C0E8rMOjJwC1x+dgSXLf4eO/SoNqYzILQlEd5GBezMmn/WDlAa1PcL8muJN6VTJsTBle4B5ij7645+mMRfAtZw07M0yJWg6m1hP1OupPjUBwh+jq70Wh9JBhAUogMU5y8tTXDr0JT1R2a3gCNtZGIuLkxxV8U4So8hgc/qre4NGKP6uigMWlkFZeE45jayS/RhBaKIgFYITqF9KK72ymgmsZxfdgKdzim4+O8RmnEBugHj8vX1ALHtEujrrm/4xxhMpE5+3Di06zPjbDcS68zQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq+ryfp/HZslIom3VwEwHXgXOCk1wapllbTYonu5br4=;
 b=mtcnKzqckcE4ZSepgBJINyFydKLLfZsLPzcJRQekoUjXnZmdCgppB6xac5lZV3lJX+IDZmec+XGrJci20h8g5j+zKE7DBBxjTBdjZIM+hYarfQuevGJu6yofXS2vym8uxQ2UtzucyvpnS1c6YLXNtaXLonLLcx8zOZvm7PNidu7RgE4t20KLcjUS/UEAfMn3oSopKCrXUJGwES4zIIfVygoZeYxWZLEVdvzSqBeJLsxHBKDtUQwPsCM9e9nQO8MJyD9Tv7p1C55vggpNl7t2o6GN3sKS0ksZ4a55hB0p5HNTbRWv4kXCQ896ZpteR3XQkcyRNlshSQ7uR6GhMWCi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq+ryfp/HZslIom3VwEwHXgXOCk1wapllbTYonu5br4=;
 b=MUdalaVzXm0RX0EfjGWkqzh3AIi5zVZL9BelLXJ/qrwiiwtfT/2B6G+ZMIqy9OkIm3skZJXxXQ1TmbI9yzvBbPxMXkFNn7RUFvRWKW9hCoy6rl8n3OccykH1+fzeVCLH4VLYfQpPL6OSZ5CpmIrYj3OBH+KhfOird8iqL+f+QUSDgQqjZ+ndNyu3LFRRubLDL/JHJ+wadflWZnGDY61lYMaGZZ1ANfm9dY3afkTvNhbbb2ReRMLrahDMzHBccSK0gzZAWVBAhGTehACgoAlCwsLePECvZDaMJLuQm8BCuySDhekgRP6Yn8ECcYBdKGlaSpumrxPCRBzR5IuLnMA34Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5107.apcprd06.prod.outlook.com (2603:1096:4:1ca::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.9; Tue, 4 Feb 2025 07:00:59 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Tue, 4 Feb 2025
 07:00:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 02/18] hw/intc/aspeed: Support different memory region
 ops
Thread-Topic: [PATCH v1 02/18] hw/intc/aspeed: Support different memory region
 ops
Thread-Index: AQHba9K5UdVbrGV5DE+s49Sgmq/lQrMut3CAgAgTZKA=
Date: Tue, 4 Feb 2025 07:00:59 +0000
Message-ID: <SI2PR06MB504177B5B9B916534237DC7AFCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-3-jamin_lin@aspeedtech.com>
 <ee2d8a35f9fc890091c789cad452e6e0aa915cdf.camel@codeconstruct.com.au>
In-Reply-To: <ee2d8a35f9fc890091c789cad452e6e0aa915cdf.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5107:EE_
x-ms-office365-filtering-correlation-id: 2210cf30-cfab-4af3-8468-08dd44e9ae34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N00wT1AvTi82eXluQkJFeDNtRlEzTzhZNS9aUDhQZlFDcFVGRGNDOElSUnhI?=
 =?utf-8?B?cndiZGRQSC8zQ2dqbFRTUHFtdytXSGUrdjBtSUhGQXhnYXltc1NTa2lJMDU2?=
 =?utf-8?B?MzJVY3BKNFUwcDZObnRFWDhUVGZQOHdrVzJwSnNoWHpVQi9EaUFDRDBoa2Zs?=
 =?utf-8?B?ZjlaOThFaXkrM1VHaStpMmFjMHArTit3azgxcjh2bjJrTWM2RExyT1hzZHF0?=
 =?utf-8?B?Z0ZuMTNrYUlvRHNHdHQreG1KRWtLanBXbjB2b1RXeHNXYlptS2NiSGY2M2FM?=
 =?utf-8?B?RDJ1ZTZraEhFQUxENnBtbVNrUWQraERlOURMeEkrclI0ZVlKVjlERkZIU05G?=
 =?utf-8?B?NDVNMW9SSnozRmdKUFBiTEFBWFlwbVpkQWVkSDBDZkpJOUQvamZ3cmQxeHpF?=
 =?utf-8?B?ZFppR3orNnpuamVMeHFWVnRFQkx3ZDhWYWs1WXg4SCtLOWRjdGZ2T0REck8y?=
 =?utf-8?B?dGFaQnNySWw2MW1uU2ZKQ20xdHpmcTI3S05JZHZJQm1PZjNlR1h3OTFpVHcv?=
 =?utf-8?B?d3FReWRoM1IyU1VPbmNTV1Jpc2VkS1d6ck9sL3N3YTJoOXBNZWc2ay8vclEy?=
 =?utf-8?B?cVFOU2Y3S0VoUEYvMnowWlRFeGEveWJhUmtZUCsrLzRPZFM5S2I2aE5QRko1?=
 =?utf-8?B?b2xBOUtJQ0ZIZU1ibEp3Y08xNk5FbzYzRDBUeHJwSG4ybzh5QlNEaW50bHdC?=
 =?utf-8?B?ZmcwZVJESWFYYlE3OThQNVVYTlM0OGtqQUhZU2pLSFJpK1l0RVYzMFJmRUpN?=
 =?utf-8?B?RWN1MFZ3Rk1CdHA0RlFyRE1Fd3FlUHh2UWI3eWlvMjBoZjhGc3QzZnk2Q3B1?=
 =?utf-8?B?d2dRUHk5dTk4YmVwLzlCZVpsUlc1NzRUdHp1bFpldldHTTBFQnAyUEVFY0lZ?=
 =?utf-8?B?YllwQlhGOHNQM3BTZllBc08wWHd4MDJtTDNuN2M1eWNlU0k1MkNIRE8zQ0pF?=
 =?utf-8?B?M05iV2ZsZEs3VmEwcDVmQWVsVFh4ZDZtOExwZXNZY3o1L1dEVkIyMFNFU2JT?=
 =?utf-8?B?TUlESS9JNjE4M0M2SUptOFJTRUJtTGdjT0JlWGRuRCtOZmVHMmtDbm5OU2Mw?=
 =?utf-8?B?OFM1V2ZFOGs5YkpvNnQxL2F4bHU2UU8xMXpDSjNXa3kwWTBac0dDU0F2bE5N?=
 =?utf-8?B?SHordTFwNHRZTFVGL3lqak5waVh3dm5Mdm1ybVdZVXJHckNTbGVZN2x0Q3A1?=
 =?utf-8?B?QmUzN1RWQzFJUVkxV2FEU01PSzRHVHUxUUNJL0p5OXFSK1lvMkdpTE1iMUtq?=
 =?utf-8?B?cGNldmkrUjNXRGZPYllGeDhsbjRNSGh1R0V5TDNlSHJha3ZPY0VObUVxUm1Y?=
 =?utf-8?B?Q2UvdHh0TDMyMThuQXYzLzlHMisvUlJueWFsdnRzRzd2cUFCM1gxVUdWZ1pB?=
 =?utf-8?B?T1h0bVp3ZldUV3MrZ1NKTmlJWmZBNkJScS9DT2dvaFRtNmdPdFdXRExrYlNn?=
 =?utf-8?B?VXkrVExVTzhSSldacW9DSHlhTTZHeWpsR3ZWQnBhZUp6RUVtVHVRMjcvNk1Q?=
 =?utf-8?B?cXJXYmtlaDl4MzAvcVhvd0x4S3YvSjFxeFBpMFc1RW5UQXhoZ2tMTlpDOWFC?=
 =?utf-8?B?MlRLbE5rSExtMGgvbXU3Z2NUNUEyb3Z3WDlydElISUQ4MXNiSmpTU0lDQ0Np?=
 =?utf-8?B?RmlDanVwalp1RmJjQU9teTRFd3lpN3RDSnJjMDFFL0pmTVRxaDV5elg2Q1BC?=
 =?utf-8?B?SjlLS2pURVBnSVd2dUNpWjVLQ0VSMUhveDNOTVlTdThFRjlDTGt4eE1yUkhQ?=
 =?utf-8?B?TmpOQVNsSXA5OHhpdGJmUkJucVo2WE5VSDcxR2dxZUxEV0ZvR2hENWFTMnFh?=
 =?utf-8?B?a3FmMkR2cnd2ZnF0TjB0UEg2a3E2Um12amVzVHpqM21QT3pHa2NoQkVQdUlq?=
 =?utf-8?B?YWF4RTFKVzM4R01YRG5WcVRVdFMzWFRFK3d6a2ZYanBXWjl5RmNPdk1QWS9a?=
 =?utf-8?Q?b3JrNsPEccK6OalW86tNE3qKdmyHEHbp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFhHcndQbDNUamNJVkI1UnV1ZWdMa05CMUYvQzdKRGsrd1FWTVlWNlRjaWI1?=
 =?utf-8?B?NDEvRW91Snh3N0xGY0lEN1hxRDVEeHZUbUpqN1A3TzVmU3E4S0dneXdNYndr?=
 =?utf-8?B?cklFTVlPY3BHVWFCWXZsZlA2QUFCMEllVlRTc3ZYMGlYMGlpbXNveVVkcjF4?=
 =?utf-8?B?aUlnUVVyVnZmMHlQbGVzYXBBSW8xbDR1WVNaS01Dc2VJMmt6NDlRNW02UXZX?=
 =?utf-8?B?S1plV0VWb09wazhIbkRNb2Q1SWpxVS9BR1UxL2NBWURpbUZXRTlBYWdYYUkr?=
 =?utf-8?B?STNaTnpKN1dKTjVJVU9GV1M4aVNoU2xnb3lEV3lEQnloR2xZZ3hNTjYzU0NE?=
 =?utf-8?B?V2YwQ01vOG1acENoUlorSWxKcngzWnRBYWtNZEVIMmNFRUV6VithbUwwVStP?=
 =?utf-8?B?T1RhTW0zbytTSFBqNXNNZ0tGOGFjVGVKRnFhMjdmMXE1dnRHcTlKY0pESFNF?=
 =?utf-8?B?SU9tWkJWdDRERVA3RS9zcnNKS0x4Ny9hYVkyZUJsL05ONXBGemFiUytUblpa?=
 =?utf-8?B?VmZlaEdsR0d2Q1hwQUkzQkRBTVpRcE9yQml6Vk1lQkJYQk8zNGU2Sm4zZHY0?=
 =?utf-8?B?VXJOSFhnNVh0Z05NcHMwZnI4WHc1eHdqblZhQWVNWXdwZnJFY2JEUTlkMFNq?=
 =?utf-8?B?QzNUd1kxcitTWlFOMmphTHE5RUh2aVlRK09MY3JldlNZN21UeVdYVDdGaUlP?=
 =?utf-8?B?RXlzOHREY2dic0RXaUpuMUl5cktVTG41SjUrbmFLQUlCUndWaXN0UUl6S0g3?=
 =?utf-8?B?WkJRTi9ITXAvTWZZTWhBUUFQTkt1WWZjY3RHYW9RMEV4UWpQZDhwcFlncE5I?=
 =?utf-8?B?K1ZIelh6NHNWd0EyaloxQkZwQmtOTmdLcS9iVjZpZS90bGRwdUVPaHpndlpX?=
 =?utf-8?B?aFFrTm54OGhsb3g2bmNlUVA3YzFpUWJPUUZlbFFoS2NwajA2UDd4emg2NTR3?=
 =?utf-8?B?dFZyWWx6THloeWxVdTluZG9DWGs1MUdDTkp4N1ZlUE51UTIyN3hUL05lNVJS?=
 =?utf-8?B?R09zbHJBTkxTSTRReUhFdUNBai8zamJWVi9lMXBwa3dJaVd0dTNBNVptaUVW?=
 =?utf-8?B?dDkrMjBHLzJOZjJHak5iOGIwektDdkgxQlZ4US9ROHdGdGs2cWxrSEI0VlZn?=
 =?utf-8?B?RmRObTJ4aVhYTGY4OU5lb0U3NEpGVU9ySnJxRnplZ2xJWXc5Z0phWWxhQXZn?=
 =?utf-8?B?ejQ1OW40bDNLYndzNEtIbmMwcm5xeDZ1TkNjWmx1U2pjcFQ0YUZUWDlWSkNv?=
 =?utf-8?B?VU5zTCtRWjU2R3BWU3NiUld4cTdIaXczVElxdlFXOWRkVG0vc0pZNFFnb0NL?=
 =?utf-8?B?WmIyTGV5dzlQTEtrQWNaMWN0TVJkbVhmWXBMcFFzSTRaTitqTG1aUmJ5cDUz?=
 =?utf-8?B?U2FRTDRpYzYyKzdHWVVxQkdZempwcmQyRlI3SHFmRWdLcm1xUjhwZjBidGsv?=
 =?utf-8?B?a0FvTWRjTUI1ckpYdzU2T0J5ZkgwOFpieHlVME9PTGpJMDZobzdVQ0lGc0Rl?=
 =?utf-8?B?N0ZTZTJSWGtTTDBSaFhmakFVN0ZvUURWS3lxTmNha1dRYy9UdGxyQTA0aW1W?=
 =?utf-8?B?QVNHSE5uTmJyTjROK3U0M2tWUnM2WHI2TEFYaUJJa0FZNHRhUzlBNlBkbDVM?=
 =?utf-8?B?VDZtbEtVRlIrVXFVd1RZLzNQYmJ4ZkkxU2I0QUFmb1RlZGVBb214cnB3U0NS?=
 =?utf-8?B?RVErQkZwTzJWM0p0TVBycU5WM2l0VVNqR3ZBN3JNMC8vS0ZINWZJZnlKZ3Za?=
 =?utf-8?B?U0NNR2lnSmVKTGpkcnNTMjVvclo5T2poTVk3MVh6VDYxc1B2bzhCbWhOeU1E?=
 =?utf-8?B?Y01idkZsOGtVdlVZSzBzMllFclVJVTZnUUxGZGM5U2w2aHpZRkZkbUxxeVVB?=
 =?utf-8?B?WFV5MlNrcFUza00zLzVDNjZmRG1HREIrN3lUeXRDbkZzdXFwZDlmck5yUm1T?=
 =?utf-8?B?bTVUNi94VngzRFZFQkhTc0F1SWxsYXFDMXNsdWJGTjhZRVUxRXQxajRVSnEv?=
 =?utf-8?B?ekRXS2g4ejg3M2RjTDg1aE54VFV2MU9na1gyZ1FubTYrR1NUYlB4TjR6dE5Q?=
 =?utf-8?B?bVo3b3h2YzN6bUcyR0phYVE2K2FsbUgxMXNVODczZEdvRW5Wa1J2Q1N3a1JC?=
 =?utf-8?Q?M8focN41pv7AdmIjEqYdQx9AW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2210cf30-cfab-4af3-8468-08dd44e9ae34
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 07:00:59.7197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMMCGz9ijflmoJs9gKR+XiXtiCJByfREztzCA+/Kb+8Mym63UAOqxK1MSLPv4cX2k0EY6R3+9o0AhV/X6TjclpW0IyXNquJKOSiTakfyCjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5107
Received-SPF: pass client-ip=2a01:111:f403:200f::72e;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQW5kcmV3LCANCg0KPiBGcm9tOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1
Y3QuY29tLmF1Pg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAzMCwgMjAyNSAxMTozMiBBTQ0K
PiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQGthb2Qub3JnPjsNCj4gUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPjsgU3RldmVuIExlZQ0KPiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kg
TGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEpvZWwgU3RhbmxleQ0KPiA8am9lbEBqbXMuaWQuYXU+
OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+IGxp
c3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJv
eSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50
YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAyLzE4XSBody9p
bnRjL2FzcGVlZDogU3VwcG9ydCBkaWZmZXJlbnQgbWVtb3J5DQo+IHJlZ2lvbiBvcHMNCj4gDQo+
IE9uIFR1ZSwgMjAyNS0wMS0yMSBhdCAxNTowNCArMDgwMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+
IFRoZSBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiBzZXQgdGhlICJhc3BlZWRfaW50Y19vcHMiIHN0
cnVjdCwNCj4gPiBjb250YWluaW5nIHJlYWQgYW5kIHdyaXRlIGNhbGxiYWNrcywgdG8gYmUgdXNl
ZCB3aGVuIEkvTyBpcyBwZXJmb3JtZWQNCj4gPiBvbiB0aGUgSU5UQyByZWdpb24uDQo+ID4gQm90
aCAiYXNwZWVkX2ludGNfcmVhZCIgYW5kICJhc3BlZWRfaW50Y193cml0ZSIgY2FsbGJhY2sgZnVu
Y3Rpb25zDQo+ID4gd2VyZSB1c2VkIGZvciBJTlRDMCAoQ1BVIERJRSkuDQo+ID4NCj4gPiBUbyBz
dXBwb3J0IHRoZSBJTlRDMSAoSS9PIERJRSkgbW9kZWwsIGludHJvZHVjZXMgYSBuZXcgInJlZ19v
cHMiDQo+ID4gY2xhc3MNCj4gPiBhdHRyaWJ1dGUuIFRoaXMgYWxsb3dzIHNldHRpbmcgZGlmZmVy
ZW50IG1lbW9yeSByZWdpb24gb3BlcmF0aW9ucyB0bw0KPiA+IHN1cHBvcnQgZGlmZmVyZW50IElO
VEMgbW9kZWxzLg0KPiANCj4gSXMgdGhlcmUgYSByZWFzb24gbm90IHRvIG1ha2UgaXQgYSBkaWZm
ZXJlbnQgdHlwZSBhbHRvZ2V0aGVyPyBJJ20gbm90IHN1cmUgSSBsaWtlDQo+IHRoZSBpZGVhIG9m
IHBsYXlpbmcgdHJpY2tzIHdpdGggdGhlIG1lbW9yeSBvcHMuIFRoZSB0aW1lciBtb2RlbCBkb2Vz
DQo+IHNvbWV0aGluZyBzaW1pbGFyLCBidXQgSSB3YXMgdG95aW5nIHdpdGggdGhlIGlkZWEgb2Yg
cmVtb3ZpbmcgdGhhdCBwYXJ0IG9mIGl0cw0KPiBpbXBsZW1lbnRhdGlvbi4uLg0KPiANClBsZWFz
ZSBzZWUgbXkgY29tbWVudHMgaW4gUGF0Y2ggMS4NCg0KVGhlIHJlYXNvbiBmb3IgdGhlIGNoYW5n
ZXMgaXMgdGhhdCBJTlRDMCBhbmQgSU5UQzEgaGF2ZSBkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZSBh
bmQgcmVnaXN0ZXIgZGVmaW5pdGlvbnMuDQpTbywgSSBjcmVhdGVkIGEgc2VwYXJhdGUgY2FsbGJh
Y2sgZnVuY3Rpb25zIGZvciBJTlRDMCBhbmQgSU5UQzEgcmVnaXN0ZXIgcmVhZC93cml0ZSBvcGVy
YXRpb25zLg0KSU5UQzA6DQpJTlRDMF8xMA0KSU5UQzBfMTQNCg0KSU5UQzE6DQpJTlRDMV8xMA0K
SU5UQzFfMTQNCg0KVGhhbmtzLUphbWluDQoNCj4gQW5kcmV3DQo=

