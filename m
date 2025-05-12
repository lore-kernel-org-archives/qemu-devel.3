Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E31C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 01:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEIJX-0004hG-Sj; Sun, 11 May 2025 21:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uEIJR-0004fy-NR; Sun, 11 May 2025 21:50:39 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uEIJM-0008KK-Ql; Sun, 11 May 2025 21:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afbO9N4+wOfwa87Qu0ijAP1RZFZJpFhNImgGiDnDuYgtvUbJHe2WW/5XEzgO6Eor32BXMUN8GNAid6uf/yCLU/AS+fzQvi3WZ+/hJTCX62EQzon736MfoUia7LZDsa5ZpFKVbP0ttPpsKElALT75QogM0jBCxJfkAZddaOliotO5BGh7HFSUI8gVLXE4f0m32ISH7cEDYxNw4Rntp7/lYaFzfW9WZIPgMA/fQJr6tCowywap7Mouw0cmziubAFf7mSKBM4ByT2zAZZxy2UtQPmPICJ2JTwGP8Ose2LSvzUjO86tHJXFrdUr7SVAhHm4VqEryoNYT2w00kpYtwCgjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKvrG5r+HZiuf7zcabsuwQ0kghDjEgr72vVX4GiZqYM=;
 b=FV3X12y271/7KxWXTrEcBnugDrAHDnnaU1iLrY0qQb3Ksd5mii1j8i8GgsHJIOqxwEuvnuD6bZRUaKmsgup2UjH7hM05v0tBbBCGwjnxRR0AlYccgSnBOBPuXnmT81xmzHgS5s/upDKRVlWtignKB2fH11wuyKVx6A6oTEIT7htaXDY5T37yCNtvGCB5+SgeUSqmuzRsNGrdFyJM3T5bSCqYlLgUNh/rM3PnOp8WrRVkfOnPpx4AhTfnLi5Ko30VpRNQaqguViMJHiFTPZRa+XsHOuoBgqTJKjDLT5Xzwv+PccKe9cC4/WIpa2yvOrvBsOc469LPtoHXU60NeOS2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKvrG5r+HZiuf7zcabsuwQ0kghDjEgr72vVX4GiZqYM=;
 b=LuAsQ+yfgje9aKjCZ4M+rhFNHMeS/UNG1jZkNBBldh4zzQIVWcqVHEgaCfHelrd9XUT+ujxSDUKknJebwGvCpSsj/9hubqUQoUP5zGDs1o6Dy3vg9hxpjzGWh/O44BtFIsDCJFUxrHYrgOd/FT9iS4b7kjtU3xZe+J1A4Y+mtGDl3pkwcMAhJEayDkZJjiI0/wdS0Y0R5k0BgjiaoF/YNPY4+EpHYQP/kWE0a8rvdw0Tob+klvPwfdxj9Uu1k63/YxQ9LFCTH2Gx5Ugq+chqyWQKHWEELhpIaXE/qSyQ/XkgZSJ5YnYISdJABxgoTncmJm4UWn+PERNz0nUuhs+dNw==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by TYSPR06MB6795.apcprd06.prod.outlook.com
 (2603:1096:400:475::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 01:50:21 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 01:50:17 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>
Subject: RE: [PULL 22/23] tests/function/aspeed: Add functional test for
 ast2700fc
Thread-Topic: [PULL 22/23] tests/function/aspeed: Add functional test for
 ast2700fc
Thread-Index: AQHbvZ0t0Yc9C7DxeU2uF6ycw55mmrPFqUaAgAS5yACAAA97AIADyJ7g
Date: Mon, 12 May 2025 01:50:17 +0000
Message-ID: <KL1PR0601MB41803D777D2948A2B8C147798597A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250505090635.778785-1-clg@redhat.com>
 <20250505090635.778785-23-clg@redhat.com>
 <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
 <ce9162f3-a3d3-4a76-a261-af16384ea82e@redhat.com>
 <CAFEAcA-OJmmKgLrd6P-+Kb=-Zh52GL0y+vfNLrivM97T4DDDwg@mail.gmail.com>
In-Reply-To: <CAFEAcA-OJmmKgLrd6P-+Kb=-Zh52GL0y+vfNLrivM97T4DDDwg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|TYSPR06MB6795:EE_
x-ms-office365-filtering-correlation-id: 9fdc01bc-41b9-4bbd-63a2-08dd90f758cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YTJqb09nL0lwa21hWDY3anBBMDRSU3Y0SjVBTlltSDdpWlNYdE1BdUpMbUZW?=
 =?utf-8?B?ak1iU3M5UmtUQlkrNEdCOXE3b2xhVm9WRko5OW9mM245bGtadlU4WW1XY2dI?=
 =?utf-8?B?NFE4UmtiVGhDMzdtenQwTzF6R3NjR3pZcnJrRG8yanNKQWpkOVNWcW1LTTdv?=
 =?utf-8?B?K0RpY2FJY2hGeFpRNzJjM3ZVYnFWRE5ubTYxREhkZ1ZkZlczT1NMN0pVNkV1?=
 =?utf-8?B?T2x3eU9zSmhwTDlpTE9FTDA4a2hUQW1RalZaV1ZsdFY5bWdoQzFlS2U0S1Y0?=
 =?utf-8?B?bnJuUDJuK0dodFNjUnFEVHJTLzg1Snlyem9nYnZvSWJwRzNNb1RoUERSU1dm?=
 =?utf-8?B?N2l0Y3JNYjhLcHBhNmRwbDFqa3VCblBrVnZDRzU5WDNWbXp4ZTVzSXAxa0RT?=
 =?utf-8?B?NFJ6Z201bmtXMWd0aVQvMmtlT2RwYjlXOE5JTlNhTEg2WGVwTzJIR3JTQXBI?=
 =?utf-8?B?UU92Y0diQlVRbUZQeGZudXpPNTk0Y2VQUSt4dkc2TTY2ZmFMS1JNbURHLzJl?=
 =?utf-8?B?aEV0UThoandXYTIxdDRHR2plU09FWFZhZFJybElDZGw4OW1wRGpMemJOdUtH?=
 =?utf-8?B?blZNUzhoV1dSTHVROHVWNU9kbHhRalkwS1c2RkpSMGxMZkZubkoxRlRmQ3B2?=
 =?utf-8?B?Mm4rUTVhNTV0QkZuWUVKOUh4VkVpNHBsK25JMkw2SmV5QnlyS2VDWkpGTEsz?=
 =?utf-8?B?b3l1bGR3cUlkM1dUVkNKTlU1c0pQdUtrYmVpUG5wYUtkalBURTgvbE5sdGhL?=
 =?utf-8?B?S0JRUVVlMUdKQVhrSkN4RmFmVGxTMUozbTlZSVlZa2xGNHhINS9jdmJheWpF?=
 =?utf-8?B?TGlzRHRZOXBjQzJmMU9FVVg0RlhXR3VtMS9VbUI2blF0amUxOXRCUXV0NUQx?=
 =?utf-8?B?a1RJWWluQ3l4MGRhRFJOcnArVlRFN0JCYnJuZFQxSmFyME1sOW8xRkptSmZ5?=
 =?utf-8?B?VG1VZVZUWVFIVjNxeEV5VW4vTHdLd0p1cEpjZTc3VGppSzczWkZIR3ZrdFVL?=
 =?utf-8?B?MlNUV0lnWmVxSDkyZGxtd1YxeEFXLzUwQWZ4Q2NrWEhtMHBRVk14Tm5lNDVH?=
 =?utf-8?B?VUwvYVprWC9BcVBYZTI3K1dWL2ptdU9IUTNJaTRNRFRKcGhsbHk1ZW9nZEY4?=
 =?utf-8?B?ellBSXRKdCtpQ2owam5Ra1dTK0RJV050Z1ZhVW9vaXVEWkw0MC9tNTVtbWly?=
 =?utf-8?B?eXhSMER1cUNwV0VGb0JudzRHUjlROXFWaDlXSmNBZFZlbGZqTTNNUXV3L2E3?=
 =?utf-8?B?SDZxYm9POGZ5bTJCejEyM21kZUxTNDFZWk9iT3RrbTVJNlV5QUU2WTBwR2Mv?=
 =?utf-8?B?SVRCRE9kcm93UFZ2NVpIdUZFcHhRUG5DeVZsSG5nUm1FSFY4bWVuSk1xSGJM?=
 =?utf-8?B?aDNuWWRmRmxzVEF1cER0UjZNdlY2R09sYUt3N2x3VzdEVU9tNkMrMWFZYXdj?=
 =?utf-8?B?SlJGY1hyOE5ta2UrWXQ0SVc2Q2haajVCd1JRb0w4SU82Vm52bWp2a0Z4elNY?=
 =?utf-8?B?VUExVWl4bUlub0N6ZWZ3WWR0VitkcndqUWZuS0hEUHlMZUF6RXBFNDczazFP?=
 =?utf-8?B?ay8vMTlMbCs2eFRmblRROVhocWI5QU01TmJzNkRvOENTNEt3SG1heC9NZkhL?=
 =?utf-8?B?dkxwUnhRenJXTmlITWkrc29yOUFub0tnOHdNeDJPUzUxZ0IyM2FYWUhGbWdL?=
 =?utf-8?B?TnY5TmlZZW5Fa2NkdnFTdnNXQmp3dTRLWm9UUk50NHJadVl3R3JYWXJSdnh4?=
 =?utf-8?B?NlhFRUg0ak56Tk8zcThVUGZ5MXJad1NRbi9FR0REbHAyVWVkc2I0WXdoZVk5?=
 =?utf-8?B?d25sdVZpUFoyYmh6TXErMEFYSS9pbXEzYXkrTDZwMmlKSkdsUmJhSG9Ed1E4?=
 =?utf-8?B?MTBSNzRVNHNLT3lPOFVvMjYvNzlLMVUvTW9wTHc4ckx4SmFWbWxRNUtrcGpY?=
 =?utf-8?B?blJ6dUl1WGk1RnJJY1k0R3o3RlRFNlIweFFjb2JWSXRlYm5UU2ZKQkx1ZUw1?=
 =?utf-8?Q?01dY5/BlqaNfxsKlEpxJokbj+mMHcA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2ErckdmUTBSRmxoWkFhQVBTb1Nrb0thMi81Z3dFa1lYNkNpU0Y3NU10UUlj?=
 =?utf-8?B?VG95dUp5cTRFaU0xTS9HS3J3bGVVNzFzYlhaTWEvQXJPV0hlWWMrR0g5dlJ1?=
 =?utf-8?B?MGo4SlJtUVp4WWpFL0lrQm5La2hjblFxYkowOHc1di9oWHB2WXRRZ2s5WEww?=
 =?utf-8?B?VDQ4V1ZJS2ptWWRCSWNGUHA2eUladFo5V0FuTVN6SnVjMzNkTnhVbm5hSHlY?=
 =?utf-8?B?NUNXYldWb1VERlY0VGpqN0hDM2N1L09sdHZNMllMVmIxbzc2cTYwejBLa2o0?=
 =?utf-8?B?elpjVGlmbEVmbENtaE9Cbk9welpHOTkwdUNjaE93NUNvVWhtalQvS1NYclBj?=
 =?utf-8?B?NWkrdHREU0ZNT0Y0c0xkVGhQWEFtc3FvTklFUzNjV3A0UGlPWnZ0dWx0azV5?=
 =?utf-8?B?bm4zcVg1K1UzMFJXa3d4aXdxYXlwZEZXQWFaaXVJOTdlSjJjZWUzZHRZaWFB?=
 =?utf-8?B?S21sS1hOS2JOa05CN0hvd2lZYzBQTGZIcU5ZU3dCTXg3WjNUR2I0Q2w1b2xm?=
 =?utf-8?B?RVc5Z04vSzNHcW1RenlzVnZmRlJLU1RtYncxQ09ZMEFIMUk5ODg3V054Y3g5?=
 =?utf-8?B?NDZNYVU5TmppOGt1ZG5xVTNkTlpnajhHdzBnTWpiWnJaN2FYMTNxR1p4aHZC?=
 =?utf-8?B?bTl6YnZrV1ZENjlJa2pPcmF4NU9ic0FYQUF0QytobFMra3liWnJqMG1XdWxo?=
 =?utf-8?B?YktPOGlVaElVZ2YyYVluM2RZSDAxb2VKblZXT3lva1NibDR6ZkVkWTJsM0di?=
 =?utf-8?B?aDJqYVpzZkhYUUJZQjVnY0xRWjFQZ1lVWG53ZkNBZWVqNGNybEtFQ2c2eEIx?=
 =?utf-8?B?NWpJU1I5Q2FkZjlnQVRDRmk0WnhyeWNFWXlPczRESmprVjFNUCtqREJqbDVJ?=
 =?utf-8?B?NjVGUnJPK245aHZreWMzYkJaeisyVzB1eldaUXlsbElyUXpaR2cvYmdBY081?=
 =?utf-8?B?RzFaRjg1TWRIeEVLQWxMN1g1ZzhES0NnaHhzOWpuREdzdklJMUJnaVEzU0d4?=
 =?utf-8?B?ZHExV1pYY3U2UnhLUTRwYkdoSHZoRWUvTGxmTGMrTjd1RmFIMitXWUZSWktq?=
 =?utf-8?B?SFI0ak1RQWQrU1RqaGtOTTJLWFFZRG90c1lFSkFhekFab2lTTmM1LzZjK25R?=
 =?utf-8?B?YmlkRUMrM043M3JtY3hJQXJIa3lXcjU1STdvNXV5ZFVqU1BPZVFqdGpLd3Ny?=
 =?utf-8?B?WmJKL2RJMGtSN083Y1ZWWlY1ejNIQUx4V2dYcUJ3aUdtT2cvZkh0ZkdvNGZK?=
 =?utf-8?B?UkgwREdJOFBYSWNOYXBFb1E0WFIvN0w1YVV1eGVwSGpFeWZsOGIyZXVKL2VQ?=
 =?utf-8?B?UHphRTBSVVZGZXc5a00waE5HYVB4UlNCRklUbTV3aHZZUzR6R1dTNUF4bnVU?=
 =?utf-8?B?N2R3Q1ZGa2VPM0wyMnpEcDI3OE5hcFpaVXZVZzBOaThKUktUbjZBOEM3dWJi?=
 =?utf-8?B?Q2NQTzRpeWhLRE05KzQ5cWY4RDJzclNpN3JNVXRvT2gyRzFkc29zdFJzeThu?=
 =?utf-8?B?OFBuMFlQc2crSUVJbWlDZ2VHSFBYN0NKYzNJWXJ2aGVoUC9tellQay84ODVt?=
 =?utf-8?B?aUhDaGJaOUdSZ2traGQrbmp0KzlQc05Tb2tJSDZHVEZ5YzNYc283RnhwNkZp?=
 =?utf-8?B?WlNWc1Q1bHZSZzdLdWxlSHgyTXl6WllMc2gzN0VVdFoxOXlpeEV1ZExZVUYx?=
 =?utf-8?B?Sm4xUFhCWmlYRzh4N25yaFBjU0lrVlFhUk9hYmxNMU5TOCtpQ3RoSW56ZzFQ?=
 =?utf-8?B?c1RwN0Zuamh4Zzh0bkE3UHhTOXU0T2RiTExvTmNycWxxNSt6Q1R5QWFORTRI?=
 =?utf-8?B?Z244VnNtUnd5UEkrdEJaWmFKODdUOFRWVk13Qm1YdVp1d1RQbmpDL2VVY1c2?=
 =?utf-8?B?aWRQNkpjQTFvVEw0N2N2aEhQWmsvZ3RRV1BxYUdOYVk5b1FLTFV6dWcxa2ht?=
 =?utf-8?B?OHlOeUVoTzJQell4S2orVWdmU3NEOGpzV3BBVkVPUjhqRy9tZGhGUlJIZFlR?=
 =?utf-8?B?VVZWTmNBS1J1MDAzeW1QTG1ncDNncnFHMTdCbEc2TEFKUXNsS3RHSTN5dHN5?=
 =?utf-8?B?VXhuUGx2SEdjWFRkV1I5QXR1UWQ0ekxTQUcvekMwUlBzWmxwOU9TWkl3VGll?=
 =?utf-8?Q?Wu46izeevetrh0FaRXoUc8JCt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdc01bc-41b9-4bbd-63a2-08dd90f758cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 01:50:17.7113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/eA7ufAz4y+89qwKZ/Bh6ZvjWi3V8mHWscoJbEZlG7euInwu+54bResLcymjR24oHHQLc8W867XOJ/Om8EWIHqP5iaK1cf8SN9q1liFjsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6795
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=steven_lee@aspeedtech.com;
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

SGkgQ8OpZHJpYywgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlk
YXksIE1heSA5LCAyMDI1IDExOjI4IFBNDQo+IFRvOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJl
ZGhhdC5jb20+DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5v
cmc7IFN0ZXZlbiBMZWUNCj4gPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUFVMTCAyMi8yM10gdGVzdHMvZnVuY3Rpb24vYXNwZWVkOiBBZGQgZnVuY3Rpb25hbCB0
ZXN0IGZvcg0KPiBhc3QyNzAwZmMNCj4gDQo+IE9uIEZyaSwgOSBNYXkgMjAyNSBhdCAxNTozMiwg
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPiBJbiB0aGUgYXN0
MjcwMGZjIG1hY2hpbmUgYW5kIHRoZSBmYnkzNSwgZWFjaCBTb0MgaGFzIGl0cyBvd24gbWVtb3J5
DQo+ID4gcmVnaW9uIGFuZCwgc2luY2UgdGhlcmUgaXMgbm8gbmVlZCBmb3IgdGhlIGdsb2JhbCBz
eXN0ZW0gbWVtb3J5DQo+ID4gcmVnaW9uLCBpdCdzIGVtcHR5LiBCdXQgaW4gc29tZSBwbGFjZXMs
IGxpa2UNCj4gPiByb21fY2hlY2tfYW5kX3JlZ2lzdGVyX3Jlc2V0KCksIGl0J3MgYSBwcm9ibGVt
IGZvciB0aGUgZmxhdHRlbmVkDQo+ID4gZ2xvYmFsIHZpZXcuDQo+IA0KPiBHZW5lcmFsbHkgc3Bl
YWtpbmcsIGJvYXJkIG1vZGVscyBzaG91bGQgc2V0IHRoaW5ncyB1cCBzbyB0aGF0IHRoZSAibWFp
biIgU29DDQo+IGZvciB0aGUgYm9hcmQgdXNlcyB0aGUgbWFpbiBzeXN0ZW0gbWVtb3J5IE1SLCBy
YXRoZXIgdGhhbiBjcmVhdGluZyBpdHMgb3duDQo+IGVtcHR5IE1SIGZvciB0aGF0IHB1cnBvc2Us
IEkgdGhpbmsuDQo+IA0KPiBCdXQgc2VwYXJhdGVseSBmcm9tIHRoYXQsIGl0J3Mgd2VpcmQgdG8g
Z2V0IGludG8gZmxhdHZpZXdfbG9va3VwIHdpdGggYW4gZW1wdHkNCj4gRmxhdFZpZXcgaGVyZS4g
V2UgY2FsbGVkIG1lbW9yeV9yZWdpb25fZmluZCgpLCB3aGljaCBpcyBhIHdyYXBwZXIgYXJvdW5k
DQo+IG1lbW9yeV9yZWdpb25fZmluZF9yY3UoKS4gVGhhdCBmdW5jdGlvbiBkb2Vzbid0IG1ha2Ug
YXNzdW1wdGlvbnMgYWJvdXQNCj4gd2hlcmUgdGhlIE1SIGl0J3MgcGFzc2VkIGlzIGZyb206IGl0
IHdhbGtzIHVwIHRoZSB0cmVlIG9mIE1ScyB0byBmaW5kIHRoZSByb290DQo+IE1SLCBpdCBsb29r
cyB1cCB0aGUgQWRkcmVzc1NwYWNlIGZvciB0aGF0IHJvb3QgTVIsIGFuZCB0aGVuIGl0IGdldHMg
dGhlDQo+IEZsYXRWaWV3IGZvciB0aGF0IEFTIGFuZCBjYWxscyBmbGF0dmlld19sb29rdXAoKS4g
SWYgdGhlIEZsYXRWaWV3IHdlIGVuZCB1cCB3aXRoDQo+IGRvZXNuJ3QgaGF2ZSB0aGUgTVIgaW4g
aXQsIHdoYXQncyBoYXBwZW5lZCA/DQo+IA0KDQpJIGFsc28gcmVhbGl6ZWQgdGhpcyB3YXMgY2F1
c2VkIGJ5IHRoZSBDQTM1IG1lbW9yeSBub3QgYmVpbmcgcGFydCBvZiB0aGUgc3lzdGVtIG1lbW9y
eSwgd2hpbGUgZml4aW5nIHRoZSAyNzAwRkMgQ2xhbmcgc2FuaXRpemVyIGlzc3VlIGxhc3QgV2Vk
bmVzZGF5Lg0KVG8gZml4IGl0LCBJIGFkZGVkIHRoZSBDQTM1IG1lbW9yeSByZWdpb24gdG8gdGhl
IHN5c3RlbSBtZW1vcnk6DQoNCm1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihnZXRfc3lzdGVt
X21lbW9yeSgpLCAwLCAmcy0+Y2EzNV9tZW1vcnkpOw0KDQpQYXRjaCBmb3IgcmVmZXJlbmNlOg0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAy
NTA1MDcxMDEwMDUuMTQ3NDgyMy0yLXN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20vDQoNClRoaXMg
c2VlbXMgdG8gcmVzb2x2ZSB0aGUgaXNzdWUsIHRob3VnaCBJJ20gbm90IHN1cmUgd2hldGhlciBp
dCdzIGEgcHJvcGVyIGZpeCBvciBqdXN0IGEgd29ya2Fyb3VuZC4NCg0KUmVnYXJkcywNClN0ZXZl
bg0K

