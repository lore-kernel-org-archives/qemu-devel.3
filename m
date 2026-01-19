Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8601CCA5FFB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhk3y-000830-9r; Mon, 19 Jan 2026 02:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vhk3Q-0007qC-VJ; Mon, 19 Jan 2026 02:52:05 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vhk3N-00042N-Jo; Mon, 19 Jan 2026 02:52:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XowBfcK9myRQEKliQ/TIkeHpzBOt511rYkDHRgwXVjrWEI4E5OEAmAT0Rf4dbgjjfpRs62bc3w22pY8qKXDp7X6KTWeV+WPVggK1rozjIaHsteJYACVarDresNyAWigCfJmzwWwjHaQzlpjTXMPGchBOuwGODt1HUm9QCtX/EbviS9RYdQ8c6W5IbfxaRS0yzuXN6VjIxLfrBFae5aPYjAXw862tRQfDnFsHYbjK//VLMAa/PKEqwDP3Vfm2YNux384n4PgnM6tr1YH89ICRi+jQCX/tsVld3qhHesEpUlMKwEDEBSD0LUo5i+8o27LWBw9lUPiSGP3gonSFg4ySPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRkjXYYQCMhQP32+siwKUcme5BKpTj3Bhd5+U0gMQLQ=;
 b=USxx2VDNJ5xNMpFutMwspfIh+uBajoKwghXc6T/jfY4Rbbm77cw9e+b6z7t61m8muFJk5fBk8KOW/APu7w0FXsd7rFF8sgRiUHXKsAtKd21hkBoNHec9BlMq57fo+E7SUTC2sQvy0weolX3GhkSAT2MgIbMG9nLYapItHzVyS1/U7i65jTsV9daaPnMd9yZPNNY+1pxEFILzKGRp1L6OBqW+nsblUHoQBdjfejjJVihcsIlfZ7s+lkm3ScUlBRiKvm9rjbEa2TQBVCl4Fyn8rGXNLS1RCa/sX8aAb6PFJok16/wjaeIpi20+8greh7hAcw46JoiGxBEZKklft06I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRkjXYYQCMhQP32+siwKUcme5BKpTj3Bhd5+U0gMQLQ=;
 b=FqYXqxGUZG+em/pbj7NIhLFSmpuSOjB4YNzrN71VX96SMh8HQBoa3yAFJS9rMA+NKOL2QzMsHYb2qw0P/Q56T9e8l/mIulgAEc4oMWXbvY1dXZUwndYEm+ySNPs1+kI5ApJcP+XO+N0WGOT5x4T5u0QhpYhbsL14peytwQLrQT5VCweND7zkaRHrXyQ9pdpyi+nUzlpiRQqlSB9fHBFjEK/zTDmrxvWl/crTdIVvvSE0rFiABwoWiX9azURWhy7j+o5pNr9eTQBEaueRmsniCD5fuB/ezfPZ3lcwnrKZlnbK8iQwvjX6qBsvGgUUBpyt1YDQRKSauXpGkOEVFKSbDQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5620.apcprd06.prod.outlook.com (2603:1096:301:ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 07:51:50 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 07:51:50 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 00/19] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v4 00/19] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcdHaFSEvznMw9U0yiFxo41x4TQLVZRimAgAAAb9A=
Date: Mon, 19 Jan 2026 07:51:50 +0000
Message-ID: <SI6PR06MB76316C5AA167336CA56912FCF788A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <ee63db86-2981-42d4-b0f0-f20245a2203f@kaod.org>
In-Reply-To: <ee63db86-2981-42d4-b0f0-f20245a2203f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5620:EE_
x-ms-office365-filtering-correlation-id: 7a2f0e11-8f1e-4fc3-ea02-08de572f9ab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?REFiSXhyMldsc0R4dDhSSk1LTjBoVWYvS0I2c2dSeVFwblhHdXdRN2d5NUFC?=
 =?utf-8?B?bkpJVDZ6ZVhlekhiWk16K2FSWS9IMzh5MTFLdUoyVXFZMkZsQlR4UUJ0OTVT?=
 =?utf-8?B?UnN3cUFhU2pVNWxtbGh1S0ZDN0hkODhUL0s5TVBJQ0tueXNaMGR2NkxFOUpN?=
 =?utf-8?B?UlFoU2QvVFcyV3U3eE9lc0pjeSsrOTRwOWNBZUxyWUpMVWxmdWlnanIrSkFv?=
 =?utf-8?B?Yk9ycGU3WjRhQVRxK2phNUVTeXd6S3hHZDE5TmVSeFVHNWIvUzBQam96VFUx?=
 =?utf-8?B?elZKeWI3TUN5STloNXBVamxYcWlxcEhKenRhQnZrejV0L0ZGalhUeHVMSWFo?=
 =?utf-8?B?ODhxTGFOV3JnMzlCZEdPYTNEeHp6Z0x6eUIwVm9NSm1uK2tJQ1YrbHMra0NK?=
 =?utf-8?B?bDh5ODh3a2hJb090V1lma1JpWHhIc2JnZlJLK3JzTnN0cy9Oa3V3clNROTAv?=
 =?utf-8?B?dGNPemgzaHBRMy80RDZqUGZCUmtSM3N3YWFSWUVwOThWNllxRWZkdW9jdkRY?=
 =?utf-8?B?WTFrTDEzT3RCMzlLT2FmQzNPd3hCM1FCYmtvZnY4TFpISTFNRXdpdm9Cb24r?=
 =?utf-8?B?cWtOaWM1TW1RZXpiM3RETFF2clNKa2gzZitLb2FiK1Y3UE9wRXlNYktUcFlm?=
 =?utf-8?B?UGxtQ3pOSWE3aXIxTi9NZWJVNEVKZENxYVVGQUdQa1NTRkg4Y2hBYi85RnFH?=
 =?utf-8?B?S3JhUnhmQ1FlWVZIZXJrczdiQjNobndONitpVGVVQ3NGZjJnL2x4czZ3UzhC?=
 =?utf-8?B?TkdrQWRvVE1zdHl0MTI0T3pXbEdCRndtbm9GUW5vbStpbXpVNnkxenRNWGZi?=
 =?utf-8?B?ODFBaEZIaDJMT0xGYUk0UER2TWxOWlpEd2VaeVMyK2xRV3dObHhpWXJnSVNV?=
 =?utf-8?B?Z0VUUFZsN05GQ1Z1TFRuL1d3cFBqQzZzNXdRMTdxRUJoQ1JXVWUxcVpudEFH?=
 =?utf-8?B?elpuWitoaVZGeTh1N3hnTEN4NmY1a1R0Q2FxK0RuSHpyTTlaODN2U0g3QWhC?=
 =?utf-8?B?VDFucDlBc2pTMkxIZTFpK0h6aXk4ejVnNkNDSXJ1NVAzM0VtbEVwKzladnU4?=
 =?utf-8?B?Q1VOdEpSTlMzYXZmdElrUVc4eHZCa0UwcGhKeXp0alNDV09MUlUxZWxMU2d1?=
 =?utf-8?B?dU01d1lpQSt5cGRDYlppZmRxNWpCT2s2Wis0SEZNWnZvV3BSYXNmbUdlVXFj?=
 =?utf-8?B?S2hPbDUvR1cyUURrSnZTRXJ4Wm93NFRqaktKMmpaN2lnY3FadXpOb0k3K2s5?=
 =?utf-8?B?czk1Vk1jQXpxcXlaRGE0M3B1MERZcTJZQlpVN1N4Z0l5cll0ekRRTDY1T2Nr?=
 =?utf-8?B?N1gxUUtzVnM5SXBEYjVxVWd6NHZqTjEwSHBNSDlhcUtVckRlQ1lpZEVKREhC?=
 =?utf-8?B?TkNPNmFMQlpZdXVUdkpmZjV3WWk3V0FjMnRZWHZEV0VYNDMrRzYxOGFwM014?=
 =?utf-8?B?M0FpeW42cStURyt6R09ZUkliSE9UZUtGOTdpcXVnV04wcE5rMFlDSUZKNXRx?=
 =?utf-8?B?V2czNXp6clc3Vlhja28waFJQcEk0SUpQTHdCZnpYYm9jdFRDTGIyS3A1NURq?=
 =?utf-8?B?dmdpYWRKZTlNYXcwbURvTVVmazNteHl6Y2JIb3Exd0NpWThSVStSbmJTTlRC?=
 =?utf-8?B?bkYrU2tzaTZYUCtNTjF3dm5uckI2dlFnMUw3cjh0ZlVkek53aS93Qy9ZZVlm?=
 =?utf-8?B?SW5EU0VrQ0RUU0F2Wmc3UFhtTk9DUnU0TXc2L1hxK292dERyelVwdWhucUcr?=
 =?utf-8?B?d1l6b1c1ZmxmTlZ2akdLK2Y4eVgxcnZob1EyZlFwWXhCMjA5eXVmNWVpallz?=
 =?utf-8?B?Y1VtUDF0RVZLQktOM09JRmlMKzQ3THBiQXM3Y0I1bTlHVWNIUlVJamF3MXIw?=
 =?utf-8?B?Sk16bE5ITnFQYkJPWkY4aWN6NEdXN3pON01pRmRUblhJbGJUM1JmZnlQclNa?=
 =?utf-8?B?Smp5eDZMT0ZobEZYSWlLdEl0QUZxT1g4M2dyYWRBV2F2Y01BbURYZGI4ZVFS?=
 =?utf-8?B?cUc1cFpMWWgxTHZjTVVRdFlHcXJBaVBmQ0JpQTR1dUJwZGdJVno0aWlqTHJU?=
 =?utf-8?B?MG9BdUpJSFNpcVRBOFJjUkNZN3FQMEpwY1FoSlBNLzJjZ1FYNkFDd1hWSCtx?=
 =?utf-8?B?aEFyRUFmWHp0S05WVXRpWVhjSTNrMWZJcExyemw5YUQ2WlBYNHp1ZmNPenUr?=
 =?utf-8?Q?A5a4sAfH4wvHPr/MAOtyEm0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ni9WNG8xdmVkMmdsUVo3c01CaXNrRVlpRDg1Sk1kaG0xMkRtRGl0UnJuVVBG?=
 =?utf-8?B?cWdEL3RsVTA2Y0o1L29wUEt4ak5lcDNEWWlHVzVRWDdBaVF2a0hPRHo1MkRG?=
 =?utf-8?B?TXZKV0dVeC9WUU90dG1zTWtFM0tjV1FWa1V6ZGdqS0N2QjZqTlRpbDc1Qkw4?=
 =?utf-8?B?cjhsLzFvdktydFdJZlRJYUxDWEljc2NsQlBpRWtkdk5ZT0FLUjlGTXFDbDRW?=
 =?utf-8?B?aGhDZ2lwMzhad2pqL3QrVjRvSENyNHJkWUpLYWFLNHcreXdRVFN2cVRUNUt5?=
 =?utf-8?B?dElLY1o2OXFpYkxGMkR1U0xRUUhydmVudTg2UlVETkVBU1JuQi9YMS9nNGVP?=
 =?utf-8?B?M08rZGlwc1JaRnI1RXU0NHRYVzdKYVFoSVRkU2RCZ0RnOXNRcXR5elltMmNY?=
 =?utf-8?B?YjVsRmRuYUYrbTFIb1NCUlMyM1lqTXlNTDRUcS9ySlNVOW5VbHBxV3BmcVNB?=
 =?utf-8?B?eU92T281czcxcVNwbnF0MDF1RHg3MGJxMHpJRlprOFVJcmFLOXZFb0ZHVGEv?=
 =?utf-8?B?UUZiSXE4Rk1UOFpKcWVzN201aUtjSlRWclAxUkZsazlTUVlsajZPeG1BVUh3?=
 =?utf-8?B?Sm9aY1BUWWJKUzRYWmZ1RTI4S0F0SzJKalkzWEZWMll6ZktGUnVXOEZ2b0tW?=
 =?utf-8?B?dnQvM0dnRWFFNWJ5aUV4QnRZZ3dWdDhvOTNORFlNVjM4NDNaVllEb0JzRzB0?=
 =?utf-8?B?Tm8wOGVkcUN6cnVERnNFWkU5UmdXNk9GNW1CWEwrclorZFRGVGdIS1VmaWNM?=
 =?utf-8?B?UlZ4SHRmaXJVZU4zMzB6UWJJNFlqb1hnbzRnYlJXNXVFazJaZDFtTHcxdHlC?=
 =?utf-8?B?OUFJTkxEM2pzeFFmOUMrQjZoQWlRY3htV0kwNFNsZktnTjV6aDJlZjRvcEtF?=
 =?utf-8?B?MjVCcU85MklXeEpXaWFqQlM3SW41M3JYOHBTSGxzRHptRHlSL3RYVi9SRTY2?=
 =?utf-8?B?UlBNUHFlQ2o1MkJ5VXE2dnhlRWlaa0JPRHdrMnY5SDVSUm9ZZklxMHhmNVVm?=
 =?utf-8?B?VkxhZ3dBNUxZS2laZWwrVkliL2tTVG1IRExta01rblp2ajgxUklVU2ZySzBs?=
 =?utf-8?B?a0dmaGNrYmk5bHM2T3FCWStkdWpRb002RDY4czRXL2l2TWhqWmJnekd5ei8x?=
 =?utf-8?B?QmlDTEVtYlZwODFwTmhlZFZIZEQyNW0xS1Z3MGtodUREMU0ramtQTHVWTDdH?=
 =?utf-8?B?bWtEejFCNzZwMXhkV3NrdlhhOTBXRE4xVGpSRFBKSDJNREZnWnJmS096MnA4?=
 =?utf-8?B?TFFsaXYvNFZJdU9xNWYzcURpaTJRUHVoVWZLcEZmRDdOd0FXWkpzWk9EL3po?=
 =?utf-8?B?eE1WSkpLb3BhWEExUDk5RUVQcDVScDNRSjRnKzcya21xK0VKV0VvYXJhcHVW?=
 =?utf-8?B?WFpoWkt2RnNGMFgrU1BLVHlzcXB2b0RzU0M4YjV5YXlKekhobUxLMmxjdlRR?=
 =?utf-8?B?UktWbVJXM1hrOGxKNi9iL0FKMFc0TnhmVmhUODNGbDVoV1NuMGMrdjkveWtu?=
 =?utf-8?B?b0MyTGVYTXJmTlFyTGFRaVZMUXJhRlg0Q01pZDVWa1BmNzc4MVdwejZQVGp5?=
 =?utf-8?B?UWd3Ly82QXRZa1Y0ZlZoYUxWWkszQVUraVJpcFFYbzVabm5KZzVjdXZUT1kv?=
 =?utf-8?B?NHlsVHRVcmNoTS9CNWx4em5vUkFXcEdvRW1iREp4ckVkLzBZQ1ZMQVNDTGtF?=
 =?utf-8?B?YkVRZlVYQTRHRkVkRGpiNEpia054SEpOYnc2eU5xbk9wUmlENmk0N0YvSld3?=
 =?utf-8?B?WmF4ZnVFRlZsR1FBcU5XS1U0cGRPQ0RnT2dpNnJJNUVEdjBiQjNaSE8yRDl0?=
 =?utf-8?B?NWpVRmUzamk4Vmx3Mi9XL283NW5WcHVPL05rVmV6QXFKd3NBRDdCQjB2U2cy?=
 =?utf-8?B?eUlTRHVVdzNNRlI0eHFSSGJPWWlsOGR2LzVPMTZYRXdpNEN3bVpqbUlIQm9K?=
 =?utf-8?B?SUwvOU1YR1IvbS8vZ3pVbE9mSFhTUHU4Uk9iTytURWx5ZDNsK2F3UE1FREtM?=
 =?utf-8?B?WTkxRVQ3UTJUNGJVbzUvWWZvRnZ3TUVldnlBdUpDRmlmOXFDZUNNZlAyU05P?=
 =?utf-8?B?ZzVlOEQ3RWJLbWRNMjRZQnRLazBxNDBQc0FVM3pOalZTWkpid05GT3FVYjll?=
 =?utf-8?B?cUJmc3JDam9Fd0R6c05YVk1iZjJ3c0pQSXFVMk5mcGowaVdEWTN3d1dSbUVi?=
 =?utf-8?B?WDRDaWxtbFlxOWE2bW04WjJmMFNDQ0t0SEs0ZlRYaU1EaHYrd3A3VW1xT252?=
 =?utf-8?B?R3hyT3kvUGwwNmVxZVFZcnpiS2JKR2JuMnR1MTkrUG1ESjQ5d3FzY2E3ZDRz?=
 =?utf-8?B?ZjAzbEFjMzhhRjRHeTl4dEpJaUNaS1hnTThmWFo2TXlXczV2Q3J1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2f0e11-8f1e-4fc3-ea02-08de572f9ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 07:51:50.3838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ylcro9D9q+ieXOI44CZgPBGqRbEF+t4LbknADgm2BSTRV0EJycBSel23XJ6bTvZGnQScObLW/vASaWHvD2TGOHQLE/7zAt3osYDtzYRPzMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5620
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMTksIDIwMjYgMzo0NSBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFz
cGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IG9w
ZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwg
cGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDAwLzE5XSBody9hcm0vYXNwZWVkOiBBU1QxNzAwIExUUEkg
c3VwcG9ydCBhbmQNCj4gZGV2aWNlIGhvb2t1cHMNCj4gDQo+IEthbmUsDQo+IA0KPiBPbiAxMi8y
NC8yNSAwMjo0MSwgS2FuZSBDaGVuIHZpYSB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4tQVMg
PGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IExU
UEkgKExWRFMgVHVubmVsaW5nIFByb3RvY29sICYgSW50ZXJmYWNlKSBpcyBkZWZpbmVkIGluIHRo
ZSBPQ1ANCj4gPiBEQy1TQ00NCj4gPiAyLjAgc3BlY2lmaWNhdGlvbiAoc2VlIEZpZ3VyZSAyKToN
Cj4gPiBodHRwczovL3d3dy5vcGVuY29tcHV0ZS5vcmcvZG9jdW1lbnRzL29jcC1kYy1zY20tMi0w
LWx0cGktdmVyLTEtMC1wZGYNCj4gPg0KPiA+IExUUEkgcHJvdmlkZXMgYSBwcm90b2NvbCBhbmQg
cGh5c2ljYWwgaW50ZXJmYWNlIGZvciB0dW5uZWxpbmcgdmFyaW91cw0KPiA+IGxvdy1zcGVlZCBz
aWduYWxzIGJldHdlZW4gdGhlIEhvc3QgUHJvY2Vzc29yIE1vZHVsZSAoSFBNKSBhbmQgdGhlDQo+
ID4gU2F0ZWxsaXRlIENvbnRyb2xsZXIgTW9kdWxlIChTQ00pLiBJbiBGaWd1cmUgMiBvZiB0aGUg
c3BlY2lmaWNhdGlvbiwNCj4gPiB0aGUgQVNUMjd4MCBTb0MgKGxlZnQpIGludGVncmF0ZXMgdHdv
IExUUEkgY29udHJvbGxlcnMsIGFsbG93aW5nIGl0IHRvDQo+ID4gY29ubmVjdCB0byB1cCB0byB0
d28gQVNUMTcwMCBib2FyZHMuIE9uIHRoZSBvdGhlciBzaWRlLCB0aGUgQVNUMTcwMA0KPiA+IGNv
bnNvbGlkYXRlcyBIUE0gRlBHQSBmdW5jdGlvbnMgYW5kIG11bHRpcGxlIHBlcmlwaGVyYWwgaW50
ZXJmYWNlcw0KPiA+IChHUElPLCBVQVJULCBJMkMsIEkzQywgZXRjLikgb250byBhIHNpbmdsZSBi
b2FyZC4NCj4gPg0KPiA+IEJlY2F1c2UgdGhlIEFTVDE3MDAgZXhwb3NlcyBhZGRpdGlvbmFsIEkv
TyBpbnRlcmZhY2VzIChHUElPLCBJMkMsIEkzQywNCj4gPiBhbmQgb3RoZXJzKSwgaXQgYWN0cyBh
cyBhbiBJL08gZXhwYW5kZXIuIE9uY2UgY29ubmVjdGVkIG92ZXIgTFRQSSwgdGhlDQo+ID4gQVNU
Mjd4MCBjYW4gY29udHJvbCBhZGRpdGlvbmFsIGRvd25zdHJlYW0gZGV2aWNlcyB0aHJvdWdoIHRo
aXMgbGluay4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIGJhc2VkIG9uIHRoZSBTR1BJ
TyBjaGFuZ2VzOg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11
LWRldmVsL3BhdGNoLzIwMjUxMjE5LWFzcGVlZC0NCj4gPiBzZ3Bpby12NS0xLWZkNTU5MzE3ODE0
NEBnb29nbGUuY29tLw0KPiA+DQo+ID4gSXQgaW50cm9kdWNlcyBhIGJhc2ljIExUUEkgY29udHJv
bGxlciBtb2RlbCBhbmQgd2lyZXMgaXQgaW50byB0aGUNCj4gPiBBU1QyN3gwIFNvQy4gVGhlIHNl
cmllcyBhbHNvIGFkZHMgdGhlIEFTVDE3MDAtc3BlY2lmaWMgTFRQSSBleHBhbmRlcg0KPiA+IGRl
dmljZSBhbmQgaW5jcmVtZW50YWxseSBjb25uZWN0cyBjb21tb24gcGVyaXBoZXJhbHMgb24gdGhl
IEFTVDE3MDANCj4gPiBtb2RlbC4gRm9yIHRoZSBJM0MgYmxvY2ssIHdoaWNoIG1heSBjYXVzZSBr
ZXJuZWwgY3Jhc2hlcywgaXRzIE1NSU8NCj4gPiByZWdpb24gaXMgbW9kZWxlZCBhcyBhbiB1bmlt
cGxlbWVudGVkIGRldmljZSB0byByZXNlcnZlIGFkZHJlc3Mgc3BhY2UNCj4gPiBhbmQgbWFrZSB0
aGUgbWlzc2luZyBmdW5jdGlvbmFsaXR5IGV4cGxpY2l0LCBlbnN1cmluZyBzdGFibGUgZ3Vlc3QN
Cj4gPiBwcm9iaW5nLg0KPiA+DQo+ID4gSW4gdGhlIG9mZmljaWFsIHJlbGVhc2UgaW1hZ2VzLCB0
aGUgQVNUMTcwMCBmdW5jdGlvbnMgYXJlIG5vdCBpbmNsdWRlZA0KPiA+IGJ5IGRlZmF1bHQuIFRv
IHRlc3QgdGhlIEFTVDE3MDAtcmVsYXRlZCBmdW5jdGlvbmFsaXR5LCBwbGVhc2UgaW5jbHVkZQ0K
PiA+IHRoZSBmb2xsb3dpbmcgRFRTIGZpbGVzIGZvciBwcm9iaW5nOg0KPiA+DQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9h
cmNoL2ENCj4gPiBybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtbHRwaTAuZHRzaQ0KPiA+DQo+
IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0
ZXItdjYuNi9hcmNoL2ENCj4gPiBybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtbHRwaTEuZHRz
aQ0KPiA+DQo+ID4gQWZ0ZXIgaW5jbHVkaW5nIHRoZXNlIERUUyBmaWxlcyBpbiB0aGUgQk1DIGlt
YWdlLCB5b3UgY2FuIHZlcmlmeSBMVFBJDQo+ID4gZnVuY3Rpb25hbGl0eSB1c2luZyB0aGUgZm9s
bG93aW5nIHNjZW5hcmlvczoNCj4gPg0KPiA+IDEuIEluIFUtQm9vdDoNCj4gPiAgICAgUnVuIHRo
ZSBsdHBpIGNvbW1hbmQgdG8gdHJpZ2dlciB0aGUgTFRQSSBjb25uZWN0aW9uIGFuZCBkaXNwbGF5
IHRoZQ0KPiA+ICAgICBjdXJyZW50IGNvbm5lY3Rpb24gc3RhdHVzLg0KPiA+IDIuIEluIEJNQyBM
aW51eDoNCj4gPiAgICAgUnVuIGkyY2RldGVjdCAteSA8MTYtMzg+IHRvIHNjYW4gYW5kIHRlc3Qg
dGhlIEkyQyBidXNlcyBleHBvc2VkIGJ5DQo+ID4gICAgIHRoZSBBU1QxNzAwLg0KPiA+DQo+ID4g
QW55IGZlZWRiYWNrIG9yIHN1Z2dlc3Rpb25zIGFyZSBhcHByZWNpYXRlZCENCj4gPg0KPiA+IEth
bmUNCj4gDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIHJlc2VuZCBhIHY1IGFzYXAgPyBUaGUgbmV4
dCBxdWFydGVyIHNob3VsZCBiZSBxdWl0ZSBidXp5IGFuZA0KPiBJIHdpbGwgaGF2ZSBsZXNzIHRp
bWUgZm9yIEFzcGVlZCByZWxhdGVkIG1hdHRlcnMuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0K
DQpIaSBDw6lkcmljLA0KDQpTdXJlLCBJJ20gd29ya2luZyBvbiBpdCBub3cgYW5kIHdpbGwgc2Vu
ZCB0aGUgdjUgc2hvcnRseS4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0KPiANCj4gDQo+ID4gLS0t
DQo+ID4NCj4gPiBDaGFuZ2VMb2cNCj4gPiAtLS0tLS0tLS0NCj4gPiB2NDoNCj4gPiAtIEFkZCBt
aXNzaW5nIFNpZ25lZC1vZmYtYnkNCj4gPiAtIEZpeCBjaGVja3BhdGNoLnBsIHdhcm5pbmdzDQo+
ID4gLSBSZWZpbmUgY29kZSBzdHJ1Y3R1cmUNCj4gPiAtIEVuYWJsZSBBU1QxNzAwIHN1cHBvcnQg
b25seSBhZnRlciBhbGwgZGV2aWNlcyBhcmUgcmVhZHkNCj4gPg0KPiA+IHYzOg0KPiA+IC0gQWRk
IFBXTSBtb2RlbA0KPiA+IC0gSW50ZWdyYXRlIHRoZSBTR1BJTyBtb2RlbA0KPiA+IC0gRml4IEky
QyB0ZXN0IGNhc2UgZmFpbHVyZQ0KPiA+IC0gUmVmaW5lIGNvZGUgc3RydWN0dXJlDQo+ID4NCj4g
PiB2MjoNCj4gPiAtIFNlcGFyYXRlIHRoZSBBU1QxNzAwIG1vZGVsIGludG8gYSBzdGFuZGFsb25l
IGltcGxlbWVudGF0aW9uDQo+ID4gLSBSZWZpbmUgdGhlIG1lY2hhbmlzbSBmb3IgYXNzaWduaW5n
IHRoZSBBU1QxNzAwIGJvYXJkIG51bWJlcg0KPiA+DQo+ID4gdjE6DQo+ID4gLSBJbml0aWFsIHZl
cnNpb24NCj4gPiAtLS0NCj4gPg0KPiA+IEthbmUtQ2hlbi1BUyAoMTkpOg0KPiA+ICAgIGh3L21p
c2M6IEFkZCBMVFBJIGNvbnRyb2xsZXINCj4gPiAgICBody9hcm0vYXNwZWVkOiBBdHRhY2ggTFRQ
SSBjb250cm9sbGVyIHRvIEFTVDI3WDAgcGxhdGZvcm0NCj4gPiAgICBody9taXNjOiBBZGQgYmFz
aWMgQXNwZWVkIFBXTSBtb2RlbA0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEFkZCBBU1QxNzAwIExU
UEkgZXhwYW5kZXIgZGV2aWNlIG1vZGVsDQo+ID4gICAgaHcvYXJtL2FzcGVlZDogSW50ZWdyYXRl
IEFTVDE3MDAgZGV2aWNlIGludG8gQVNUMjdYMA0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEludGVn
cmF0ZSBpbnRlcnJ1cHQgY29udHJvbGxlciBmb3IgQVNUMTcwMA0KPiA+ICAgIGh3L2FybS9hc3Bl
ZWQ6IEF0dGFjaCBMVFBJIGNvbnRyb2xsZXIgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgIGh3L2Fy
bS9hc3BlZWQ6IEF0dGFjaCBVQVJUIGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICAgaHcv
YXJtL2FzcGVlZDogQXR0YWNoIFNSQU0gZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwNCj4gPiAgICBo
dy9hcm0vYXNwZWVkOiBBdHRhY2ggU1BJIGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICAg
aHcvYXJtL2FzcGVlZDogQXR0YWNoIEFEQyBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAg
IGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBTQ1UgZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwNCj4gPiAg
ICBody9hcm0vYXNwZWVkOiBBdHRhY2ggR1BJTyBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+
ICAgIGh3L2FybS9hc3BlZWQ6IGF0dGFjaCBJMkMgZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwNCj4g
PiAgICBody9hcm0vYXNwZWVkOiBBdHRhY2ggV0RUIGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+
ID4gICAgaHcvYXJtL2FzcGVlZDogQXR0YWNoIFBXTSBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0K
PiA+ICAgIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBTR1BJT00gZGV2aWNlIHRvIEFTVDE3MDAgbW9k
ZWwNCj4gPiAgICBody9hcm0vYXNwZWVkOiBNb2RlbCBBU1QxNzAwIEkzQyBibG9jayBhcyB1bmlt
cGxlbWVudGVkIGRldmljZQ0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEVuYWJsZSBBU1QxNzAwIElP
IGV4cGFuZGVyIHN1cHBvcnQNCj4gPg0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3
MDAuaCB8ICA1MyArKysrKysrDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggICAg
IHwgIDI1ICsrLQ0KPiA+ICAgaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oICAgICB8ICAgMSAr
DQo+ID4gICBpbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaCAgIHwgICAyICsNCj4gPiAgIGlu
Y2x1ZGUvaHcvbWlzYy9hc3BlZWRfbHRwaS5oICAgfCAgMzMgKysrKw0KPiA+ICAgaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9wd20uaCAgICB8ICAzMSArKysrDQo+ID4gICBody9hcm0vYXNwZWVkX2Fz
dDE3MDAuYyAgICAgICAgIHwgMjY4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgIHwgMTY1ICsrKysrKysrKysr
KysrKysrKy0tDQo+ID4gICBody9pMmMvYXNwZWVkX2kyYy5jICAgICAgICAgICAgIHwgIDE5ICsr
LQ0KPiA+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAgICAgICAgICB8ICA2MCArKysrKysrDQo+
ID4gICBody9taXNjL2FzcGVlZF9sdHBpLmMgICAgICAgICAgIHwgMTkzICsrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gICBody9taXNjL2FzcGVlZF9wd20uYyAgICAgICAgICAgIHwgMTIxICsr
KysrKysrKysrKysrDQo+ID4gICBody9hcm0vbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgICAx
ICsNCj4gPiAgIGh3L21pc2MvbWVzb24uYnVpbGQgICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICAg
aHcvbWlzYy90cmFjZS1ldmVudHMgICAgICAgICAgICB8ICAgNCArDQo+ID4gICAxNSBmaWxlcyBj
aGFuZ2VkLCA5NTkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaA0KPiA+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfbHRwaS5oDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9wd20uaA0KPiA+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGh3L2FybS9hc3BlZWRfYXN0MTcwMC5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgaHcvbWlzYy9hc3BlZWRfbHRwaS5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlz
Yy9hc3BlZWRfcHdtLmMNCj4gPg0KDQo=

