Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00903CAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyhL5-0001U1-AS; Tue, 16 Sep 2025 21:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyhL3-0001Th-W6; Tue, 16 Sep 2025 21:52:06 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyhKx-00011G-HD; Tue, 16 Sep 2025 21:52:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh++oKzkVddMNRJELIz6DcIvhC00PpH6/cNlY8f9luwTjjca3t4/k4uRIvcj8FSpbHLYZIV1z2RDkpXN73oaHhpNGqXBxrcVu/64eKqxfr86aDgd6IZEp7jlt8nYplVHX2B+5YC0XRL+AvXQhkZ4lgaFkKHYbsxCFvPOP/KAMSyHAGOluPo0eVU2Xbi8kh56fcPotsspjnoUl+qTtF7QyeT+WXmHfM3tEHauCtPuJkB4uWQYoELqsTKojpmGMql+Yna4O+5YskES/D8a0Bk+dQI3CTKUZmj588LegL07g1dJQF96Pu6bvFuolgCRl9C+3iA1Kl4hGkh7Xkm7WgQUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQSWzEuYQXJxcocdlUEdRHZGLfSXGwpmxeG8EB3coFc=;
 b=BeU6mD8826GXvnwLXIpOIDbIjItGw+TFRaqi04AHVz2sb8sSzE27Sfm+LhQpK4ffIyNI9FhWxEveLEYk85N4Qcy9AjSu22OwYiUpxY/p2wa6fO2kXbyKaoWPU8TCpp0MFtIx8MkIcVPEYzsyWMJeAuyyF91qe5Velg0RxWWFAwmZqk9s9MeLjXZxiakZokgjbgM+eMmfz48r8ahvMsX+jct+8Xo45eQ99Ka2MpbxDRkhPVkfvWZCihifWRc/INFKtpdxs2RKjS8F6FJKn+wkDpg2l5Y6t+TT5L4RZRzOjI1vft5PSiuvoH/7i9fCKF/Ebqgm3pw/xD0IkgN9zTTReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQSWzEuYQXJxcocdlUEdRHZGLfSXGwpmxeG8EB3coFc=;
 b=aUM+UaHyH6e0y726WXYSSOev66o1lQ8abVJlqDKvcCmMaxT7T14fwr3Z9cDnGiialQUYGZgO3DnDqoUpo7WK+aUUxVTFS8eabi1Y/A0AZkovY7XZxCHgMEc/3tvbFN/sIjNDS4nmFCQlWGiptQvxy858tfNFJvrhOJtGda3fPiAm7buCMlJCqDMw+e8arPtOXP5ULxs7AwXgzynVOPAu6/HwAWQ4ovxi1s0uoobIS+D2WGW/YEFdsLYx5FuB9JdRnqjBz6IqhzjA14v0Avn00IlbFtegrpOGU/D0mZDDlkftXak63Ry5n4gb7hyLT1QW5KMCW96KDR4TE1bFeba8dA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5320.apcprd06.prod.outlook.com (2603:1096:101:7f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Wed, 17 Sep 2025 01:51:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 01:51:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, =?utf-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: RE: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
Thread-Topic: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
Thread-Index: AQHcJyUFLWsLp5hCKkGgrHFhcPxYFbSWnItQ
Date: Wed, 17 Sep 2025 01:51:50 +0000
Message-ID: <SI2PR06MB504121F7EB05BC5CF5A64A59FC17A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <48930c1092424d22dc2171140378de19e0814ef3.1757854006.git.jan.kiszka@siemens.com>
 <c144202b-0d99-4507-8a57-35df1ece3cc0@siemens.com>
 <2070f7bb-cd1a-448f-ba87-50d75e24f4c0@kaod.org>
In-Reply-To: <2070f7bb-cd1a-448f-ba87-50d75e24f4c0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5320:EE_
x-ms-office365-filtering-correlation-id: 6866174a-b722-4046-f6b9-08ddf58cc51c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Q2JZMHN3QWp0bkN4VjJxbmNZaDRGRDE1UGdxQkF5dzZ3RnJ6MkxYTTVRRUFv?=
 =?utf-8?B?SU9rejlZbmxONTRqL09TbExNRlFFak8vNDRVM1FHektYaHR3SXNwamhJMjVF?=
 =?utf-8?B?UXE3SzdGRmptZkV3QS96dkkwOCtsQi9QSjUyNlFoYUc2VmlQQlFvWENNUExE?=
 =?utf-8?B?ZVV0Vk5LUWxVZ3dmWmhrdWh5ZldzN0c2VENIbXVCRHRGNndSRktqY29BUzhJ?=
 =?utf-8?B?bWZSQ0hHWTZtZkx6TFNYd2lCOW9UeTRLNldCWU1XcldOaythUDN5bXN1ZWxZ?=
 =?utf-8?B?d3A3bjdBV1dQeGtNL2lSTG9zVmZpMnFacWFyK3krc3g5aUZnOUtRVVBmdCtG?=
 =?utf-8?B?c1d5YzI4cUxyb2E1YnNmSFRSaXFxN3V5NzBzUUl4cDcwNGswbzF2c2kvSzhL?=
 =?utf-8?B?c0k1dG8xY0s1bThiU2ZCM08vRUo1eVBLcHQ4RC9ESk1OWDF0L2pxaEJTaHFB?=
 =?utf-8?B?UnhEYndCNi9GN2JqcStsWVh6TWIvZzI4Q01mQlFmU016VFhXL2F2cEdLRGcv?=
 =?utf-8?B?VEd3Y0JGYjRwYk40ODF5dFBqc25GZVp6Ly9CQW0zbjI3dGNGVnVTZm04Z0s5?=
 =?utf-8?B?QmRhWVBBSDRvMks3WGZDOVFsY2VsQytXLzd6RUJEaGdyZE94T2wrSzVZT2dD?=
 =?utf-8?B?V1BnT1FtUjhzeGRSM0R1cFZFb0xSS3U3ckdUMFV0bllyeUgvTE5aZTVnRWNw?=
 =?utf-8?B?WmpHNlpwQmJmenlDdS9ZVjBzNEljenFSTnhvNXNEVlFDclZpVzJzd3RJUjlQ?=
 =?utf-8?B?RURRd2hHWDJvUi8xWUhvenJyb2Z5eGk1NzNtRk5FZythYlJsZzJLNHVpL0Q3?=
 =?utf-8?B?ZDA1dm1yamdMNHY3T1FFcitvMlBKd204YVFsSkNvS3NrbW0rdEsra2JacU9p?=
 =?utf-8?B?T095dTZ4akhMVkJTbUZ3NGkvOWpZMVhGL1FwT3ZxRXMxdC9TdDdZWGRrTkhk?=
 =?utf-8?B?eDUrUEx0R2l4MVF5aitxQWpmYmZYeVI2T1NNWE15VlM4ZS9Jb1pwd1g2OXNw?=
 =?utf-8?B?ZU1CcSttN3hCZTJMa2wrNnM1WEU1QUFmaFdIUmhZbzhoOXQ3YWFYSWtnY1ov?=
 =?utf-8?B?MGpySkkxVU9uNGluUnBsQVp0TGtEd1BxVjVQY3BmUzFHbkRWMVNIL0xPS0NX?=
 =?utf-8?B?MjMvUmJwTWtjbkJsdE9wdEE5TkJReDRBQjY1M2x6SExybkdqQk15bkVCNXdN?=
 =?utf-8?B?NjhwZzJORTBCN1JqWW42dzAvVllrNGhzeTkrQmpRRWJ5Mnp1QU1Pc25sWnhr?=
 =?utf-8?B?dWcxM1dSbUhvQkhqbGRDUWIwTTlxVkFmdW56dUJuM3AyK21oWEpYTlZtdVhs?=
 =?utf-8?B?QW5zWU1QTHp4LzllU0ZUNVFXYlFFOVduZG9pQURiUWNlaXU2anQrUGpYdkx3?=
 =?utf-8?B?djc3V0ltR3BoUTI3M0NrQ21KOUJMRzF2dEx0WFNYM1NHUHVOUythZ0g1L1ky?=
 =?utf-8?B?c0ZoLytJdkk0QmE4UjBLOGp1ZktTaVNBd0ErcnYwaHVJL3pCVzJCM2pMZ1pJ?=
 =?utf-8?B?Qm81RUxHOC9GbW0ycTJvRzhSZ3owQlFhTWdVd1JNVUtVNzc3YTRUdlRzRWJz?=
 =?utf-8?B?aXFtQ2N5bjNzU2RxNHFSYkhnM0NMMFF6Z0VWMjB3dlREK3NKbnBrSm9vYkk0?=
 =?utf-8?B?WjVUKzN2UEM5a0ZkZlhtdFpKTXNNdXd0czRkaFhUc2hLZVVlS3ZCRnYvSENn?=
 =?utf-8?B?MjhsZWF6NDUwaWtsKzF0TmVBRHJIZXdxbndsZGtsU3BVZUJYVFdheWxvczN4?=
 =?utf-8?B?R1VlYUJkbGdzL2tvU2R5YXRaSmc5Tlk5RXA4MGMrWFo5b0ZrMUNydTFhWXdC?=
 =?utf-8?B?MjNxcER2aHJmbDVieVhIYkFGOG1MU3Vqc0diYWRpR1VtNjRkWWZtSm8vcFdC?=
 =?utf-8?B?ckpLMUZxKzUrRktNNFBLRnBISlpMcERmditubU9Ca0Zha3ZPWHllNlNZSEVW?=
 =?utf-8?B?K2JkL2tSWkIzL0cxb2hHMXlDelBRK1RsUXpHQXJQM25adTVmY2JlUUlyYzJp?=
 =?utf-8?B?eHJ2aXhPUElnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3VMSCt5cUFsUkxwZlVIVUhvS0lkTWNjRmVtd1lGSWpKcnJJVVNSbFRiRk5S?=
 =?utf-8?B?WHgrZmR5UU9ic254dmU3MEFuZ2EwbTNCbG5KYWZzb2RVNEh6OUw5STJjQXND?=
 =?utf-8?B?aDRrbG1rcFU3bjU0STBmQjVyOEZVK1Z3VDRWb2lvVnNoWE8wVFZKVm9ZdGF5?=
 =?utf-8?B?SmpER29ERmg5OUtrNEN5QlhYZnZwblJyZ1FzejloQTBUWFBsQTJ5cGNmK3hM?=
 =?utf-8?B?WDM0a1psblFtTFBTejZ3cjFhNC8zc3JKM3owUTB1OVBvYWZDUkpUS2Jjd0p0?=
 =?utf-8?B?VFNqa3ZiZUNWR29XaVR2enhTNlZrb0dtQkljYUNkMWg0ZTZNT2h3VXhoYUtn?=
 =?utf-8?B?eGJudTNXVGoybmkveUJIaXdDZ2tMRGpWMTVYQWE0N256cERDd0VYYzFNL2VR?=
 =?utf-8?B?VzQyL1hycy9EdTZ6b1dQMTQ4cGlkcUVyTXBvZ0FRVlRaSENFQWsrRlpvakZl?=
 =?utf-8?B?eW5RYlJ5OU52VjV3MWlPRDZBM2xrWlRYaTc0bkl6eTQ3NDVqdXdSQW5SZFlO?=
 =?utf-8?B?aXhyY2d2MElsVXBIRlNrTk9JcDlXTXBQS0VhaW1vNWVTTmx1Q2lWVlN1eDlr?=
 =?utf-8?B?MUwycXVCSkdFK2NsSnZFN3M0Wm1abEdtWmxuVUNEQTNna1Blakg1eit3ZmJX?=
 =?utf-8?B?bGJkN0hmNTd5Y1NDZXM5UFNvM3l6L3M1ZUx4NDFrTTVuVXRKQzVraFdHUVVy?=
 =?utf-8?B?anNKOWxkdGVGSU9XbVlPQ0F1VHVJRGZFOHJaYmY1am1TL3Y2UGZHb1Vqdy9R?=
 =?utf-8?B?TFlKNllmRmNJTGFXNi9BQVI3eWt5WVNQakRFUm1LYURDVzhzaXUzbkljNUZF?=
 =?utf-8?B?U04xR0NTOFZmVnQ2NTMvMFh3dStkUVUwYURIRmhqK3J0cVlFQ0hHRERMNFJi?=
 =?utf-8?B?S0VwdlhyQWhDRDZERmpneEJjbTVnNm9mS0x0d2xqaW4rb0JldjA3VVRYL2xq?=
 =?utf-8?B?TitCWU1iUEE3QmhFbDNVc1hWMHhpUitFUCt2LzJhaUVPTVpmYUlQYXFwWFZL?=
 =?utf-8?B?UE5uWG1kaFQ3RWNpQ0EwQ2xhWW4vV1haQVdyVDg0R25GcmVRaFpmL2JDZXo4?=
 =?utf-8?B?eUtwelMweGVKeXFOMk50SXEvdU1qQ3g4UnhsTXRCMlZpZjVoNHZtTG5XZTha?=
 =?utf-8?B?R29LVC85TmVXR2R5YXZaYW11cU9JeFFOaVNCakpLbGZuZ0laRkZyS04rQndt?=
 =?utf-8?B?ZjIrRVNNejlSdU5GRVBXYW42SXVISWhqUmEvdVBrclpNM1NXbFBGWTJnZzRV?=
 =?utf-8?B?YTB4NzVxRytFNzdzLzh4NzJlQVczRWlNdU9BYlBoTFhwdHZBb29uNG1TSFJK?=
 =?utf-8?B?TVZTRmpiNytTbDRCZGl3UkkvWGZaL1FRTDhoazdRWUN5TFVKdFZ5bU5NV3Np?=
 =?utf-8?B?Q1h6aSszQ1luNXJhZEJvd1Irbysyb2graSthcXZzdjlia1lXTXBtR1dGTVEr?=
 =?utf-8?B?YlA4eFhVTnVNd0doUEp6a0xZWlRmU05uZjBpTE01UUlBWXVsb1EycTl0bXV1?=
 =?utf-8?B?d284NVdVOTdiakdJMHk2S0tmbUhyUHViRTVRVHl5cGlvMVdvK0M0MWpHTVE2?=
 =?utf-8?B?TFJUZ3FnMlEzRzFuOHVYZkVlaUpHdFc4Q1p4eGNFeEs3WWhjUFR2V09MS2di?=
 =?utf-8?B?OTc3MFJVTTZtZ1VqeHhQeE5TSkNZUkFrUlc4aFU2dWlpQlBwcVNPNmxrNk9q?=
 =?utf-8?B?Q0dHaDk1TDVac21EOWl6eVVVSjFsRUdYR0t0WHFCWFpicU9QY0lFb0JqMW5q?=
 =?utf-8?B?aFcxUHBNMGxHNHZQQ0w5ajBSNkowVnh6Z3lkczk1bjNFQUwvWTc5ckdGZVFH?=
 =?utf-8?B?eTk5Vno2bjlSbTN5L1IvdXRsMVhwT0h2RFNYUlFMQW4wdTRleVJubWZQV0FC?=
 =?utf-8?B?TmJSeXUyUVUrTG9IRVpkSktHUk5DYkF1R1doWGh4cXptZWFURzBRQVgvTVdJ?=
 =?utf-8?B?K05saWxVRURObDlZZmRMbVcyNUU2WjdMOFdHb0ZGVitENHBlRnpqWEpLK1BG?=
 =?utf-8?B?VXN6aWpMd0wyQW85cGJzaTF3bG1UcHFFcEk4RVR3OTcyeXl4UmFoRTFnV1Zz?=
 =?utf-8?B?UExtNUVYbG1ibDlNWE9Tc1UxZE10UVUvMEZlVFVHOW9IYk9KWHI1MGp6ZGl2?=
 =?utf-8?Q?SwjT9zsJLrNgWzFJN2/7/nNug?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6866174a-b722-4046-f6b9-08ddf58cc51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 01:51:50.7481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3V3cacq++7Pyy2nZt42jdgP55emrpwBdeoXSN6jtpldnyelkBG2bGtcgnhdEv3U6794Y9MOCyDT+Y1FMXMeZUDjAcUfBmMW2ppyNVoHtKok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5320
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

PiBPbmx5IHRoZSBhc3QyNjAwLWV2YiBhbmQgdGhlIHJhaW5pZXItYm1jIGhhdmUgZU1NQyBzdXBw
b3J0Lg0KPiBJIGRvbid0IHRoaW5rIHRoZSBhc3QyNzAwYTEtZXZiIGhhcyBlTU1DIHN1cHBvcnQu
IEphbWluID8NCj4NClllcywgdGhlIEFTVDI3MDAgZG9lcyBub3Qgc3VwcG9ydCBib290aW5nIGZy
b20gZU1NQyB5ZXQuDQpKYW1pbg0KPiANCj4gDQo+IFRoZSByYWluaWVyLWJtYyBib290cyBieSBk
ZWZhdWx0IGZyb20gZU1NQy4gTm90aGluZyByZWFsbHkgc3BlY2lhbCBhYm91dCB0aGUNCj4gaW1h
Z2UsIHRoZSBmaXJzdCBib290IHBhcnRpdGlvbiBpbmNsdWRlcyB0aGUgdS1ib290LXNwbC5iaW4g
YW5kIHUtYm9vdC5iaW4NCj4gaW1hZ2VzIGF0IGV4cGVjdGVkIG9mZnNldC4NCj4gVGhlIG1hY2hp
bmUgbW9kZWwgbG9hZHMgdGhlIHUtYm9vdC1zcGwuYmluIGNvbnRlbnRzIGFzIGEgUk9NLg0KPiAN
Cj4gVGhlIGFzdDI2MDAtZXZiIG1hY2hpbmUgYm9vdHMgZnJvbSBmbGFzaC4gVG8gYWRkIGFuIGVN
TUMgZHJpdmUgKG5lZWRzIHRvDQo+IGJlIHRoZSAzcmQgJ3NkJyBkcml2ZSksIHVzZSB0aGlzIGNv
bW1hbmQgbGluZSAgOg0KPiANCj4gICAgICAkIHFlbXUtc3lzdGVtLWFybSAtTSBhc3QyNjAwLWV2
YiAtbmV0IG5pYyxuZXRkZXY9bmV0MCAtbmV0ZGV2DQo+IHVzZXIsaWQ9bmV0MCBcDQo+ICAgICAg
ICAtZHJpdmUgZmlsZT0uL3YwOS4wNy9hc3QyNjAwLWRlZmF1bHQvaW1hZ2UtYm1jLGZvcm1hdD1y
YXcsaWY9bXRkDQo+IC1zZXJpYWwgbW9uOnN0ZGlvIFwNCj4gICAgICAgIC1kcml2ZQ0KPiBmaWxl
PW1tYy1hc3QyNjAwLWV2Yi1ub2Jvb3QucWNvdzIsZm9ybWF0PXFjb3cyLGlmPXNkLGlkPXNkMixp
bmRleD0yDQo+IA0KPiAgICAgIC4uLi4NCj4gICAgICBVLUJvb3QgMjAxOS4wNC12MDAuMDQuMjIg
KEp1biAxNyAyMDI1IC0gMDg6NTc6MzkgKzAwMDApDQo+IA0KPiAgICAgIFNPQzogQVNUMjYwMC1B
Mw0KPiAgICAgIGVTUEkgTW9kZTogU0lPOkVuYWJsZSA6IFN1cGVySU8tMmUNCj4gICAgICBFdGg6
IE1BQzA6IFJHTUlJLCBNQUMxOiBSR01JSSwgTUFDMjogUkdNSUksIE1BQzM6IFJHTUlJDQo+ICAg
ICAgTW9kZWw6IEFTVDI2MDAgRVZCDQo+ICAgICAgRFJBTTogIGFscmVhZHkgaW5pdGlhbGl6ZWQs
IDEwMDggTWlCIChjYXBhY2l0eToxMDI0IE1pQiwgVkdBOjY0IE1pQiwNCj4gRUNDOm9mZikNCj4g
ICAgICBSQyBCcmlkZ2UgcGh5QDFlNmVkMjAwIDogTGluayB1cA0KPiAgICAgIE1NQzogICBzZGhj
aV9zbG90MEAxMDA6IDEsIHNkaGNpX3Nsb3QxQDIwMDogMiwgZW1tY19zbG90MEAxMDA6IDANCj4g
DQo+ICAgICAgLi4uLg0KPiAgICAgIFsgICAgNC4yMDkxMTddIG1tYzA6IG5ldyBoaWdoIHNwZWVk
IE1NQyBjYXJkIGF0IGFkZHJlc3MgMDAwMQ0KPiAgICAgIFsgICAgNC4yMTE3NjVdIG1tY2JsazA6
IG1tYzA6MDAwMSBRRU1VISEgMTYuMCBHaUINCj4gICAgICBbICAgIDQuMjMzNjM3XSBHUFQ6UHJp
bWFyeSBoZWFkZXIgdGhpbmtzIEFsdC4gaGVhZGVyIGlzIG5vdCBhdCB0aGUgZW5kDQo+IG9mIHRo
ZSBkaXNrLg0KPiAgICAgIFsgICAgNC4yMzM5OTVdIEdQVDoyOTYyNDM5MyAhPSAzMzU1NDQzMQ0K
PiAgICAgIFsgICAgNC4yMzQxNjFdIEdQVDpBbHRlcm5hdGUgR1BUIGhlYWRlciBub3QgYXQgdGhl
IGVuZCBvZiB0aGUgZGlzay4NCj4gICAgICBbICAgIDQuMjM0Mzk5XSBHUFQ6Mjk2MjQzOTMgIT0g
MzM1NTQ0MzENCj4gICAgICBbICAgIDQuMjM0NTQ5XSBHUFQ6IFVzZSBHTlUgUGFydGVkIHRvIGNv
cnJlY3QgR1BUIGVycm9ycy4NCj4gICAgICBbICAgIDQuMjM1MjIzXSAgbW1jYmxrMDogcDEgcDIg
cDMgcDQgcDUgcDYgcDcNCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

