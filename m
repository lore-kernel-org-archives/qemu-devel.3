Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE316C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSZP-00027n-7i; Fri, 07 Mar 2025 02:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tqSZN-00026o-2q; Fri, 07 Mar 2025 02:56:33 -0500
Received: from mail-sg2apc01on20703.outbound.protection.outlook.com
 ([2a01:111:f403:200f::703]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tqSZI-0006ou-Ve; Fri, 07 Mar 2025 02:56:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1d0kvDjqMF3rZfgC6c64yIjN8FIfOcRWMEsR8+rxyBSgaMzMH9BCrvTEQWk4gOXs9E6ovm68sQ1QrJEn17W6zo29563jX3z1yGAHCQnokIXra2Dsk9ONl3WhDSPwPmaWcKS77js0RAPvLFEWS2MYuj2atHILG/Tr9QA9EImOlh9X/UQbkC7jAeUyfOSfeSztN67UddU/iA1gQ4DQDvRvbiN/SdhAjti1tSVWnL/G02wufwH6gLGd16Q9G940HpPMFaYnt5jOS/d3h8T0A3+B3WGoSco3JOXJ6BvHiReElNMmI+tShIVbaYdOKxJ0aHy8lBTKzHc/WjB15Im8LA+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI9vz5v7oytSGmMUM8qOnkllkAd0HdAKNTRR8xOB2uY=;
 b=bBInzI+VMLEv08T6ogh4o51gzbQLiHPBNPLfV6yIOVCXB4noZh3P23FOTY6TCLd5KYNuX5J1Y97D8cUss2kyaCnpzRYnxEuazmEjE/eEQ1PGiC458Xy/LAYo6XSFg1i0zKlnytUBHHybF835dGGS1o1PmIStAlhg7m/GIg+9lEgpiPkNE31BDl0DyTjUmap35TlDqDsGYZrsVJRbcUXvUEWagnNcx2XVVFzeuq+pE9otgQoyrdA+AmcO+BWTKwh328S5g6NtLozwXfvyeXia/CC4fdbA1EWuOn8pCcQiIYma2Orfd9yjPLdZRzSzIjpOYzbCgSrpHgBdyJF+Gn8COg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI9vz5v7oytSGmMUM8qOnkllkAd0HdAKNTRR8xOB2uY=;
 b=pVJEQATEEGV1ivfuCztKmuj/zXx1xOj9sKNsXKkYI3HAy12E/hCrJMc2SlhLRd2hsavM3Lgq07kj/jVLsQXhOMsq/fAL4vjSoTdNqQ7lyw3bQWNfFjz/pxObWaOn1x5r+dJ7yhlsIvqglo9nHSYHxlrLOkfnveZt5klxYnlPaKa24/feAfdc2WwKYh3ICy8IOpcFbosT7UXoXP1ZGl291ITpeZq02abSmmn8aqpVcyVV6zG4t1QAL97roxnfwzP11tNiJjil9nmK6wHiQWBOUZ/eQwyfYcTw2iWFz3OCAs8M7gx4YHa1Gh89U0WHYIeMaIzTLBcSJLp5KCQ9Val89Q==
Received: from SI2PR06MB4187.apcprd06.prod.outlook.com (2603:1096:4:e9::11) by
 SEYPR06MB6861.apcprd06.prod.outlook.com (2603:1096:101:1ac::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.22; Fri, 7 Mar 2025 07:56:10 +0000
Received: from SI2PR06MB4187.apcprd06.prod.outlook.com
 ([fe80::8e2d:5b5f:4464:bcf9]) by SI2PR06MB4187.apcprd06.prod.outlook.com
 ([fe80::8e2d:5b5f:4464:bcf9%6]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 07:56:09 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Troy
 Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v6 00/29] Support AST2700 A1
Thread-Topic: [PATCH v6 00/29] Support AST2700 A1
Thread-Index: AQHbjxVhxd+P358RV0ixxqUWb/VhcbNnSEIAgAAA9ICAAAIOAIAAAd0g
Date: Fri, 7 Mar 2025 07:56:09 +0000
Message-ID: <SI2PR06MB41873452B148F9CC13B149B985D52@SI2PR06MB4187.apcprd06.prod.outlook.com>
References: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
 <3485cd84-2aab-45e7-a72c-ca1d85e007ec@kaod.org>
 <SI2PR06MB5041DD86414B93AB1C77C759FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <09cb40d5-dcba-40f5-916e-f303eba911cb@kaod.org>
In-Reply-To: <09cb40d5-dcba-40f5-916e-f303eba911cb@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB4187:EE_|SEYPR06MB6861:EE_
x-ms-office365-filtering-correlation-id: afa72643-9d4d-444d-bad2-08dd5d4d85d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?UXdHZjNoN2g2V0FGRzd3SzJZc3k2QVdOWXVyOENRZHNaWXdBWVBJQ2o4S2JC?=
 =?utf-8?B?WmlDLzkzUUgxeWFodUozVjBnUnBWdFFLZUQxM0p4dlRrRkY3SW9HWTZmWlM0?=
 =?utf-8?B?cXIyT0VtZXN0TkhLd0NtUVJ4T1Uyam5QeDVkYTRrWk12cmZtTGFFVngyNXdu?=
 =?utf-8?B?U2xtUDNzQXl6cFRTc2l1T29BTWlYRDd4VmswZGlnUk9JTkN2Qy94d0lYYk5m?=
 =?utf-8?B?MmZia3hEdGV1ZnFDWlFHeVVraTM5KzY1WXJQUXJMejMvVlRINHJCYkZWUDg4?=
 =?utf-8?B?U2FWNTc3QzdNWVllY0VDaW1LRXh1WVhqeS9jQkpXbjM3Um41di9hL2ZTVkdl?=
 =?utf-8?B?bjdia09OZzE0UWQxS01PR0R5anpiUGE5bklmVzVUTWQwQ3NhTXlWYkJRdk4v?=
 =?utf-8?B?eVBqK1puS0JBZFRUcmN2cGs2UC9WbHJYQmV1dktLYS9GR0lBaXFDSWFBcUJp?=
 =?utf-8?B?NHpuT0MvK1hWOW1vM2tXL05lWFMyb2o0d0IxVDl5cXc4VG45UElrclBHTHBN?=
 =?utf-8?B?RUhVL1hIUHRwU0tyYnZsekFjOEt1aWhIdUVSSk5mbmhQQXpLL1poZ0RTbmVI?=
 =?utf-8?B?SGJ3ZzAvUitLVTgrV1lHZkxxd0VhRVRUR0ZJNkhpTjhKTERKQU5jOEN5SS8z?=
 =?utf-8?B?WTYveUNUeUlYUFVqN2ljWFBUSHJxd3dYSGtqNkZwUFlqV05YNjZBRXhBQmpL?=
 =?utf-8?B?SHRiNXd2TStRS20yUEUyazBHRm1RV1NBblY5L2ZlM2x1TDlPUnFKNlBQc0pZ?=
 =?utf-8?B?aCt6UlU2WHhNU1dxeWJQZGpUQTMrTjc3TlJnZGYvUi90b2cvWE9rS0tLZHpK?=
 =?utf-8?B?cHNBdGpqbGVXYlVvWFZsSCtmNnNueVIzT3NwTVhiZ3E0NmNtTlJIMUxROHFv?=
 =?utf-8?B?VWpYQXBDcFQxR29xbjZpRnVnaFVWRUpKSzRuTHBYeUZWMG5PSHhwcmFHVFNV?=
 =?utf-8?B?ekpSTXZqM3VLaXgxTVF0bGVhV3JSdHgvb3FTVFdEcmx6WUF4VFlCNFl1NUlW?=
 =?utf-8?B?bEsrTWZDMjM5eFd0aityV1dHY2pTTFpKSndFWkhvRjlXNThOaTQybWFjN291?=
 =?utf-8?B?SnFVdFBINTR5aGx6cWhPbTNEaHcxRndESm4zZTNjVExIN3pRNTYwV1FpRFRn?=
 =?utf-8?B?aEp2b0F2Q1drNVR1d3lmVzVwS2g1cWR1QUZQVGZWYlRYQnROQ240MndkVmNr?=
 =?utf-8?B?M3B1T3ZsRXU4dDVST0huckJWcHVoY1F6RS91N2NGaVF2U2Mya1pSZHFZVzli?=
 =?utf-8?B?Y21zVys4djhrZlNlR2w2V29mRlMrVVQ2Mk9IR3lxam9yZ1IzYXhwUTBBUlZM?=
 =?utf-8?B?TUp1Uk5JVllkb2RyUURTK2NVbitSeG5lTndWbnlIcjJRbzc2bjFoMVFxQXlB?=
 =?utf-8?B?UmtheE9vZXhlUWVGVE9IaExVS2dSL2duV3Z6VmpHTWFHY0pkaTFWK1g2YjZB?=
 =?utf-8?B?OURGbGpicC8vTFZVMkFIU3hjR25QZGgxcWhnOFV4YnFmWUs4Z3VZVEV2ejdi?=
 =?utf-8?B?bjBteGlxdThKcUkyUTlmalpSVm56NlhGM2xuVFVlN25jbDUwUnV4V3IyL3g0?=
 =?utf-8?B?ZGlZUTZiUFFqSUM0WVY5RXBaZG0zeVhNb00zREh1VTA3dWpxZnc0SHdnSEU0?=
 =?utf-8?B?YmJpU3lKUWJPR00ramdhaS9DTlNpbTNqaWZLNGU4NDR2WVpHQytQckgvUjVm?=
 =?utf-8?B?aERNV1M4Rm9WZVNHQjhnTkVEUnRTeS83TzJRWjBLRk1qa3V3S2JZVEJLNDUv?=
 =?utf-8?B?NjBSajBEb0MycGg4WDVFMzdOZUdOK0JIdjcza2xpMTFTVTlJQ0lCb1VqNU9z?=
 =?utf-8?B?WW1yRnlYQjNaaHN3dFUxdnNCellNRzNicTM3eXB6T3NEUkJRcnJ1clVDazhX?=
 =?utf-8?B?UlZJZHlXYTNDQUhyZ2E3YUdFVHViSGxMcUZEMHZYMDRMclE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB4187.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2hUL21IeCttalFkdlJ6Vi9haTZ2MC9PZk9qaGp0Ky9BYUdidVpNU0lwbkZq?=
 =?utf-8?B?WmRTbVFIb0U4UFlxUldVT2VvRGNaOWU1K3RGNTNSNjM2UzJmWUlRUkM5ekhj?=
 =?utf-8?B?dnkzVG9VK3Y1SjljaHYwZFdFbEsvTnlQdmVvcUdVVTVONGw2MkdGZmxxZWk1?=
 =?utf-8?B?eFp3RFZ5MlBjU2VsSnl0VCt2UVV0RW5lWVpkQ3lkQW1HVkhGV1d5N0pBRVMz?=
 =?utf-8?B?eVJ5ODZaV25zcEVRQ2lPS1JGTVBtSm5WanExUkRQclc3S0pqenMxSkdNMHRO?=
 =?utf-8?B?Nzl5Q08yYWVhSG1nam82WHRlNk96Mnd0S3J6ZDhtRVlLVklFSkczL251bTR1?=
 =?utf-8?B?TEJXa1cwNS84dFdqQ0RPZmRnRjJ3K1N0QzhTN1ErTlRQWldBM2V1UnArQkhv?=
 =?utf-8?B?MWx0aXFNTGg0VEF6WUVodURYK1k4bTJNcmM5WlVNbkxyOVFiUjhydkx1VU8v?=
 =?utf-8?B?Y2RpcngyY2VmalBEUjF0NE5uREZ0enFGZXFyZEwvKzRDVWVNMzZaL3J4ek1S?=
 =?utf-8?B?SkRmUFY1REI3ajQ3TTE4SThZNnFBS09tMEVKR2oxQjJRWmhqQm5raCsrMWEr?=
 =?utf-8?B?dmNpUEdWWDFGREllYlExcDAyOTUzT1hmb05FaVRXTkZWNzdLVytmcngxUXVy?=
 =?utf-8?B?ZHR0MWIvelBSUFJWbTFFaDM5dmxremJPdS81d0RsTk05bGdOTkFoSkNXbWkz?=
 =?utf-8?B?bkZvaDFBSENMeFdlbmtCalZMQ1c1YXNTVnJKdWtjbFoyLzFWcEZweUk1N2hE?=
 =?utf-8?B?dWtEYkN4aENPOWdBWEQ3TjlpUUJaTVZ4WDhrTGJwSUJDSS8ySDUxcXViZ29N?=
 =?utf-8?B?a3Jra1pzZ0loSG9hOGZrYkxRdFhnZWk5ZTJRQkVMckJsT1p5cGlBQ01KUklB?=
 =?utf-8?B?NHRyTS9QZkVWR01BNGQyTVJnYUhxNzJTZzZ5MUtRcE9KTVRVU051TWJMblNq?=
 =?utf-8?B?TzBJTnY2L0FUNU0zZ3d6aUlueFFzUGlDWlZ4QStubHBPbXRCNmMxeEJCQ01Q?=
 =?utf-8?B?Q29zaHpTVUhFSzNmbjlmbzVFZU1JdGdSQ2FiZUhreStCeWpxK0lxZE5ZdDAz?=
 =?utf-8?B?NzlTeEVTZmJQVkQxSG1kbzFkYkpRREZiSkxyUjhnbWpzNUJLcGRXQldtTG03?=
 =?utf-8?B?NmM2UE9BQU5jQzE1L2FzM2RvVENLMklBRTloL1U2bVZNRkNsTDVRVXJUcFBN?=
 =?utf-8?B?TUsvUmJHTHpLSlVJaHQ5Qnd0YmMwQ3pjRFVyYnF3bXFHMThReGZobjVvS0pT?=
 =?utf-8?B?L0RWRkhWTnZBNVZqOElRWUR6dUh3RzVZQ3NjcUNaSEJZZG5HNG5tTGIzajhy?=
 =?utf-8?B?dzM2WUlTZFF5TExFY1p0b0Juc254SjdHU2krU24zeVUvRDBJMGVlMENyajdx?=
 =?utf-8?B?dkhpMnI0aWxLOWZlenFUbk11MzlvOEc3bWV6R2JQcTMrYjVCcDY0VHU4VDZa?=
 =?utf-8?B?bWJtOTVtT1pqNEpydnRkaVRiZW1lQ3NFK1p2anllWG1BdXB6cStuVlk1RUcx?=
 =?utf-8?B?SUV3ZytsNVBZeThrc1pQOGxmejJmcnltcDZENE83Vkl5aE9OTUxyRGNMNUky?=
 =?utf-8?B?QzJhTzhPcDNQU0wxN2ptQ2F5OG9ZREg1VDMxWmtYTERPRGJXeVVkNFF1YWh3?=
 =?utf-8?B?dFIxMFRoVWtadnVzS0ZWUWhuZ2k4cVJoU1o2N08zY0NCSzlsMi9ObXo4WDNh?=
 =?utf-8?B?WkhxVW4rdklXZTg4ODRwUm40TXJoNUtWQ1ArNkJxWEpzb2dORnBXdHZMZFFQ?=
 =?utf-8?B?VHN4V0tEQ1hUdnMvRGtha0ZMZUNLY2FsVmpxU1AwZUlpelNaMTYvMDZPU053?=
 =?utf-8?B?MFArUEVneVFPbDEyWTdROG5ORDVUUkhOUFlLTHM1WGZoT1ZCUnk1bnBPZkh2?=
 =?utf-8?B?MEtYSFdrSmI1S2pDUldxZUdHWGpmOS92SUNJaEVxbldQSEJnYWNmMFNUSzd6?=
 =?utf-8?B?dC9wWE5Uamt5WHdTMWlJTHc4TmZDWVdLQk1GNWtaUWtQbDN5Z1M1cFR4N2Fx?=
 =?utf-8?B?TGViTGwzWVJQeGtNUUROZm0vbHE3dW5mcm9YTWttL3RROUlzcUVuTWZ1bnBt?=
 =?utf-8?B?dUE5UmZLcEVrcTM5UFltM21uQTRJYUtVaFIzaFZXSDdoTER5UWFjbk1teGJO?=
 =?utf-8?Q?uUyAvodEsqHLf1AWtcJqwkvam?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4187.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa72643-9d4d-444d-bad2-08dd5d4d85d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 07:56:09.5552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apSx/xFg0QE0kooohqUx/5NM2EMpkT2dEUrR8uiiYoAi440q8CwNTtMQkShbz5TF37Kav/ZZVlHoLPMk8O5Jo6n4eszX+Esw+83piQII+Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6861
Received-SPF: pass client-ip=2a01:111:f403:200f::703;
 envelope-from=steven_lee@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDcsIDIwMjUgMzo0NCBQTQ0KPiBU
bzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsDQo+
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVl
ZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgQW5kcmV3IEplZmZl
cnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBq
bXMuaWQuYXU+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBu
b25nbnUub3JnPjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzDQo+IDxxZW11LWFybUBub25nbnUub3Jn
Pg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY2IDAwLzI5XSBTdXBwb3J0IEFTVDI3MDAgQTENCj4gDQo+IE9uIDMvNy8yNSAw
ODozNiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIENlZHJpYywNCj4gPg0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIHY2IDAwLzI5XSBTdXBwb3J0IEFTVDI3MDAgQTENCj4gPj4NCj4gPj4gT24g
My83LzI1IDA0OjU5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+PiB2MToNCj4gPj4+ICAgIDEuIFJl
ZmFjdG9yIElOVEMgbW9kZWwgdG8gc3VwcG9ydCBib3RoIElOVEMwIGFuZCBJTlRDMS4NCj4gPj4+
ICAgIDIuIFN1cHBvcnQgQVNUMjcwMCBBMS4NCj4gPj4+ICAgIDMuIENyZWF0ZSBhc3QyNzAwYTAt
ZXZiIG1hY2hpbmUuDQo+ID4+Pg0KPiA+Pj4gdjI6DQo+ID4+PiAgICAgVG8gc3RyZWFtbGluZSB0
aGUgcmV2aWV3IHByb2Nlc3MsIHNwbGl0IHRoZSBmb2xsb3dpbmcgcGF0Y2ggc2VyaWVzIGludG8N
Cj4gPj4+ICAgICB0aHJlZSBwYXJ0cy4NCj4gPj4+DQo+ID4+DQo+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjUwMTIxMDcwNDI0LjI0DQo+
IDYNCj4gPj4gNTk0Mi0xLWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8NCj4gPj4+ICAgICBUaGlz
IHBhdGNoIHNlcmllcyBmb2N1c2VzIG9uIGNsZWFuaW5nIHVwIHRoZSBJTlRDIG1vZGVsIHRvDQo+
ID4+PiAgICAgZmFjaWxpdGF0ZSBmdXR1cmUgc3VwcG9ydCBmb3IgdGhlIElOVENfSU8gbW9kZWwu
DQo+ID4+Pg0KPiA+Pj4gdjM6DQo+ID4+PiAgICAxLiBVcGRhdGUgYW5kIGFkZCBmdW5jdGlvbmFs
IHRlc3QgZm9yIEFTVDI3MDANCj4gPj4+ICAgIDIuIEFkZCBBU1QyNzAwIElOVEMgZGVzaWduIGd1
aWRhbmNlIGFuZCBpdHMgYmxvY2sgZGlhZ3JhbS4NCj4gPj4+ICAgIDMuIFJldGFpbmluZyB0aGUg
SU5UQyBuYW1pbmcgYW5kIGludHJvZHVjaW5nIGEgbmV3IElOVENJTyBtb2RlbCB0bw0KPiA+PiBz
dXBwb3J0IHRoZSBBU1QyNzAwIEExLg0KPiA+Pj4gICAgNC4gQ3JlYXRlIGFzdDI3MDBhMS1ldmIg
bWFjaGluZSBhbmQgcmVuYW1lIGFzdDI3MDBhMC1ldmINCj4gbWFjaGluZQ0KPiA+Pj4gICAgNS4g
Rml4IHNpbGljb24gcmV2aXNpb24gaXNzdWUgYW5kIHN1cHBvcnQgQVNUMjcwMCBBMS4NCj4gPj4+
DQo+ID4+PiB2NDoNCj4gPj4+ICAgIDEuIHJld29yayBmdW5jdGlvbmFsIHRlc3QgZm9yIEFTVDI3
MDANCj4gPj4+ICAgIDIuIHRoZSBpbml0aWFsIG1hY2hpbmUgImFzdDI3MDAtZXZiIiBpcyBhbGlh
c2VkIHRvICJhc3QyNzAwYTAtZXZiLg0KPiA+Pj4gICAgMy4gaW50YzogUmVkdWNlIHJlZ3MgYXJy
YXkgc2l6ZSBieSBhZGRpbmcgYSByZWdpc3RlciBzdWItcmVnaW9uDQo+ID4+PiAgICA0LiBpbnRj
OiBzcGxpdCBwYXRjaCBmb3IgU3VwcG9ydCBzZXR0aW5nIGRpZmZlcmVudCByZWdpc3RlciBzaXpl
cw0KPiA+Pj4gICAgNS4gdXBkYXRlIGFzdDI3MDBhMS1ldmIgbWFjaGluZSBwYXJlbnQgdG8gVFlQ
RV9BU1BFRURfTUFDSElORQ0KPiA+Pj4NCj4gPj4+IHY1Og0KPiA+Pj4gICAgMS4gUmVuYW1lIHN0
YXR1c19hZGRyIGFuZCBhZGRyIHRvIHN0YXR1c19yZWcgYW5kIHJlZyBmb3IgY2xhcml0eQ0KPiA+
Pj4gICAgMi4gSW50cm9kdWNlIGR5bmFtaWMgYWxsb2NhdGlvbiBmb3IgcmVncyBhcnJheQ0KPiA+
Pj4gICAgMy4gU29ydCB0aGUgbWVtbWFwIHRhYmxlIGJ5IG1hcHBpbmcgYWRkcmVzcw0KPiA+Pj4g
ICAgNC4gYXN0Mjd4MC5jIHNwbGl0IHBhdGNoIGZvciBTdXBwb3J0IHR3byBsZXZlbHMgb2YgSU5U
QyBjb250cm9sbGVycyBmb3INCj4gPj4gQVNUMjcwMCBBMQ0KPiA+Pj4gICAgNS4gdGVzdHMvZnVu
Y3Rpb25hbC9hc3BwZWQgc3BsaXQgcGF0Y2ggZm9yIEludHJvZHVjZQ0KPiBzdGFydF9hc3QyNzAw
X3Rlc3QgQVBJDQo+ID4+PiAgICA2LiBrZWVwIHZhcmlhYmxlIG5hbWluZyBmb3IgcmV2aWV3ZXIg
c3VnZ2VzdGlvbi4NCj4gPj4+ICAgIDcuIEFkZCByZXZpZXdlciBzdWdnZXN0aW9uIGFuZCBzcGxp
dCBwYXRjaCB0byBtYWtlIG1vcmUgcmVhZGFibGUuDQo+ID4+Pg0KPiA+Pj4gdjY6DQo+ID4+PiAg
ICAgMS4gcmVuYW1lIHJlZ19zaXplIHRvIG5yX3JlZ3MNCj4gPj4+ICAgICAyLiBGaXggY2xlYW4g
cmVncyBzaXplDQo+ID4+PiAgICAgMy4gcmVwbGFjZSBnX21hbGxvYyB3aXRoIGdfbmV3DQo+ID4+
Pg0KPiA+Pj4gV2l0aCB0aGUgcGF0Y2ggYXBwbGllZCwgUUVNVSBub3cgc3VwcG9ydHMgdHdvIG1h
Y2hpbmVzIGZvciBydW5uaW5nDQo+ID4+IEFTVDI3MDAgU29DczoNCj4gPj4+IGFzdDI3MDBhMC1l
dmI6IERlc2lnbmVkIGZvciBBU1QyNzAwIEEwDQo+ID4+PiBhc3QyNzAwYTEtZXZiOiBEZXNpZ25l
ZCBmb3IgQVNUMjcwMCBBMQ0KPiA+Pj4NCj4gPj4+IFRlc3QgaW5mb3JtYXRpb24NCj4gPj4+IDEu
IFFFTVUgdmVyc2lvbjoNCj4gPj4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21t
aXQvNTBkMzhiODkyMTgzNzgyN2VhMzk3ZDRiMjBjOGINCj4gYw0KPiA+PiA1ZWZlMTg2ZTUzDQo+
ID4+PiAyLiBBU1BFRUQgU0RLIHYwOS4wNSBwcmUtYnVpbHQgaW1hZ2UNCj4gPj4+DQo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL3RhZy92MDkuMDUN
Cj4gPj4+ICAgICAgYXN0MjcwMC1kZWZhdWx0LW9ibWMudGFyLmd6IChBU1QyNzAwIEExKQ0KPiA+
Pj4NCj4gPj4NCj4gaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVs
ZWFzZXMvZG93bmxvYWQvdjA5LjA1L2ENCj4gc3QNCj4gPj4gMjcwMC1kZWZhdWx0LW9ibWMudGFy
Lmd6DQo+ID4+PiAgICAgIGFzdDI3MDAtYTAtZGVmYXVsdC1vYm1jLnRhci5neiAoQVNUMjcwMCBB
MCkNCj4gPj4+DQo+ID4+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVu
Ym1jL3JlbGVhc2VzL2Rvd25sb2FkL3YwOS4wNS9hDQo+IHN0DQo+ID4+IDI3MDAtYTAtZGVmYXVs
dC1vYm1jLnRhci5neg0KPiA+Pj4NCj4gPj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGRlcGVuZHMgb24g
dGhlIGZvbGxvd2luZyBwYXRjaCBzZXJpZXM6DQo+ID4+Pg0KPiA+Pg0KPiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9jb3Zlci8yMDI1MDMwNDA2NDcxMC4y
MQ0KPiAyDQo+ID4+IDg5OTMtMS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQo+ID4+Pg0KPiA+
Pg0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9jb3Zl
ci8yMDI1MDIyNTA3NTYyMi4zMA0KPiA1DQo+ID4+IDUxNS0xLWphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbS8NCj4gPj4+DQo+ID4+PiBKYW1pbiBMaW4gKDI5KToNCj4gPj4+ICAgICBody9pbnRjL2Fz
cGVlZDogU3VwcG9ydCBzZXR0aW5nIGRpZmZlcmVudCBtZW1vcnkgc2l6ZQ0KPiA+Pj4gICAgIGh3
L2ludGMvYXNwZWVkOiBSZW5hbWUgc3RhdHVzX2FkZHIgYW5kIGFkZHIgdG8gc3RhdHVzX3JlZyBh
bmQNCj4gcmVnIGZvcg0KPiA+Pj4gICAgICAgY2xhcml0eQ0KPiA+Pj4gICAgIGh3L2ludGMvYXNw
ZWVkOiBJbnRyb2R1Y2UgZHluYW1pYyBhbGxvY2F0aW9uIGZvciByZWdzIGFycmF5DQo+ID4+PiAg
ICAgaHcvaW50Yy9hc3BlZWQ6IFN1cHBvcnQgc2V0dGluZyBkaWZmZXJlbnQgcmVnaXN0ZXIgc2l6
ZQ0KPiA+Pj4gICAgIGh3L2ludGMvYXNwZWVkOiBSZWR1Y2UgcmVncyBhcnJheSBzaXplIGJ5IGFk
ZGluZyBhIHJlZ2lzdGVyDQo+IHN1Yi1yZWdpb24NCj4gPj4+ICAgICBody9pbnRjL2FzcGVlZDog
SW50cm9kdWNlIGhlbHBlciBmdW5jdGlvbnMgZm9yIGVuYWJsZSBhbmQgc3RhdHVzDQo+ID4+PiAg
ICAgICByZWdpc3RlcnMNCj4gPj4+ICAgICBody9pbnRjL2FzcGVlZDogQWRkIG9iamVjdCB0eXBl
IG5hbWUgdG8gdHJhY2UgZXZlbnRzIGZvciBiZXR0ZXINCj4gPj4+ICAgICAgIGRlYnVnZ2luZw0K
PiA+Pj4gICAgIGh3L2FybS9hc3BlZWQ6IFJlbmFtZSBJUlEgdGFibGUgYW5kIG1hY2hpbmUgbmFt
ZSBmb3IgQVNUMjcwMA0KPiBBMA0KPiA+Pj4gICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogU29y
dCB0aGUgSVJRIHRhYmxlIGJ5IElSUSBudW1iZXINCj4gPj4+ICAgICBody9pbnRjL2FzcGVlZDog
U3VwcG9ydCBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbiBvcHMNCj4gPj4+ICAgICBody9pbnRjL2Fz
cGVlZDogUmVuYW1lIG51bV9pbnRzIHRvIG51bV9pbnBpbnMgZm9yIGNsYXJpdHkNCj4gPj4+ICAg
ICBody9pbnRjL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIG91dHB1dCBwaW5zIGlu
IElOVEMNCj4gPj4+ICAgICBody9pbnRjL2FzcGVlZDogUmVmYWN0b3IgSU5UQyB0byBzdXBwb3J0
IHNlcGFyYXRlIGlucHV0IGFuZCBvdXRwdXQNCj4gcGluDQo+ID4+PiAgICAgICBpbmRpY2VzDQo+
ID4+PiAgICAgaHcvaW50Yy9hc3BlZWQ6IEludHJvZHVjZSBBc3BlZWRJTlRDSVJRIHN0cnVjdHVy
ZSB0byBzYXZlIHRoZSBpcnENCj4gPj4+ICAgICAgIGluZGV4IGFuZCByZWdpc3RlciBhZGRyZXNz
DQo+ID4+PiAgICAgaHcvaW50Yy9hc3BlZWQ6IEludHJvZHVjZSBJUlEgaGFuZGxlciBmdW5jdGlv
biB0byByZWR1Y2UgY29kZQ0KPiA+Pj4gICAgICAgZHVwbGljYXRpb24NCj4gPj4+ICAgICBody9p
bnRjL2FzcGVlZDogQWRkIFN1cHBvcnQgZm9yIE11bHRpLU91dHB1dCBJUlEgSGFuZGxpbmcNCj4g
Pj4+ICAgICBody9pbnRjL2FzcGVlZDogQWRkIFN1cHBvcnQgZm9yIEFTVDI3MDAgSU5UQ0lPIENv
bnRyb2xsZXINCj4gPj4+ICAgICBody9taXNjL2FzcGVlZF9zY3U6IEFkZCBTdXBwb3J0IGZvciBB
U1QyNzAwL0FTVDI3NTAgQTEgU2lsaWNvbg0KPiA+Pj4gICAgICAgUmV2aXNpb25zDQo+ID4+PiAg
ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgU3VwcG9ydCBBU1QyNzAwIEExIEdJQyBJbnRlcnJ1
cHQNCj4gTWFwcGluZw0KPiA+Pj4gICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogRGVmaW5lIGFu
IEFycmF5IG9mIEFzcGVlZElOVENTdGF0ZSB3aXRoDQo+IFR3bw0KPiA+Pj4gICAgICAgSW5zdGFu
Y2VzDQo+ID4+PiAgICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBTdXBwb3J0IHR3byBsZXZlbHMg
b2YgSU5UQyBjb250cm9sbGVycyBmb3INCj4gPj4+ICAgICAgIEFTVDI3MDAgQTENCj4gPj4+ICAg
ICBody9hcm0vYXNwZWVkX2FzdDI3eDA6IEFkZCBTb0MgU3VwcG9ydCBmb3IgQVNUMjcwMCBBMQ0K
PiA+Pj4gICAgIGh3L2FybS9hc3BlZWQ6IEFkZCBNYWNoaW5lIFN1cHBvcnQgZm9yIEFTVDI3MDAg
QTENCj4gPj4+ICAgICBody9hcm0vYXNwZWVkX2FzdDI3eDA6IFNvcnQgdGhlIG1lbW1hcCB0YWJs
ZSBieSBtYXBwaW5nDQo+IGFkZHJlc3MNCj4gPj4+ICAgICB0ZXN0cy9mdW5jdGlvbmFsL2FzcGVl
ZDogSW50cm9kdWNlIHN0YXJ0X2FzdDI3MDBfdGVzdCBBUEkNCj4gPj4+ICAgICB0ZXN0cy9mdW5j
dGlvbmFsL2FzcGVlZDogVXBkYXRlIHRlbXBlcmF0dXJlIGh3bW9uIHBhdGgNCj4gPj4+ICAgICB0
ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDogVXBkYXRlIHRlc3QgQVNQRUVEIFNESyB2MDkuMDUNCj4g
Pj4+ICAgICB0ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDogQWRkIHRlc3QgY2FzZSBmb3IgQVNUMjcw
MCBBMQ0KPiA+Pj4gICAgIGRvY3Mvc3BlY3M6IEFkZCBhc3BlZWQtaW50Yw0KPiA+Pj4NCj4gPj4+
ICAgIGRvY3Mvc3BlY3MvYXNwZWVkLWludGMucnN0ICAgICAgICAgICAgICB8IDEzNiArKysrKw0K
PiA+Pj4gICAgZG9jcy9zcGVjcy9pbmRleC5yc3QgICAgICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPj4+ICAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAgICAgICAgICAgICB8ICAgMyAr
LQ0KPiA+Pj4gICAgaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggICAgICAgICAgIHwgIDM2
ICstDQo+ID4+PiAgICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NjdS5oICAgICAgICAgICAgfCAg
IDIgKw0KPiA+Pj4gICAgaHcvYXJtL2FzcGVlZC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDMzICstDQo+ID4+PiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgICAgICAgICAg
fCAzMjkgKysrKysrKystLS0tDQo+ID4+PiAgICBody9pbnRjL2FzcGVlZF9pbnRjLmMgICAgICAg
ICAgICAgICAgICAgfCA2NjcNCj4gPj4gKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4+PiAg
ICBody9taXNjL2FzcGVlZF9zY3UuYyAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiA+Pj4g
ICAgaHcvaW50Yy90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgIHwgIDI1ICstDQo+ID4+
PiAgICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkgfCAgNDcgKy0NCj4g
Pj4+ICAgIDExIGZpbGVzIGNoYW5nZWQsIDk3OCBpbnNlcnRpb25zKCspLCAzMDMgZGVsZXRpb25z
KC0pDQo+ID4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zcGVjcy9hc3BlZWQtaW50Yy5y
c3QNCj4gPj4+DQo+ID4+DQo+ID4+IEFwcGxpZWQgdG8gYXNwZWVkLW5leHQuDQo+ID4+DQo+ID4N
Cj4gPiBJIHJlYWxseSBhcHByZWNpYXRlIHlvdXIgZ3JlYXQgaGVscCBhbmQgc3VwcG9ydCByZWNl
bnRseS4gU3VwcG9ydGluZw0KPiA+IEFTVDI3MDAgQTEgaXMgYSBzaWduaWZpY2FudCBtaWxlc3Rv
bmUuDQo+IA0KPiB5dy4NCj4gDQo+IFdoYXQgYWJvdXQgdGhlICJBU1QyN3gwIG11bHRpLVNvQyBt
YWNoaW5lIiBzZXJpZXMgPw0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCg0KSGkgQ2VkcmljLA0K
DQpJIHdpbGwgc3VibWl0IEFTVDI3eDAgbXVsdGktU29DIG1hY2hpbmUgdjIgcGF0Y2ggbmV4dCB3
ZWVrLg0KVjIgc3VwcG9ydHMgYm90aCBBMCBhbmQgQTEgY2hpcHMgYW5kIGRlcGVuZHMgb24gSmFt
aW4ncyBBU1QyNzAwIEExIHBhdGNoLg0KDQpSZWdhcmRzLA0KU3RldmVuDQoNCg==

