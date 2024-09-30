Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5FCCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 05:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv9LC-00038F-81; Mon, 30 Sep 2024 01:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sv9L4-00034R-5c; Mon, 30 Sep 2024 01:52:55 -0400
Received: from mail-psaapc01on2071c.outbound.protection.outlook.com
 ([2a01:111:f400:feae::71c]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sv9Kt-00027i-TA; Mon, 30 Sep 2024 01:52:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7e8YbyZBrijDV+372vamI6SqEFIR7n5xKDa3WiM8wP60Y1ojjzbbYzgkdLGeb0pn9lJEShE6wVjOVj64ybxmQ67taenLuoREcjy+/CuUcY3Zq0odT82xgIpmhLfkSY53cuAk+jITlAH9Ga6rTmwflImr9v84ZUiIQfYfV+6AYmJ7pWe0HIUhOEHkM+LeKJ3hj6Vhv9sN5MiwpSl1qYXBt2OjNwD68UwWt0YA/01ecvv5kSUbe6zR11Kttt+rewVq3kAo7k8oLgmZiYyOxJkG0YkUCLAaIwLbkT1Ku/p2iFhnYK4UiBjSXtMXkDuHtFHa4zt3gKMYPMQpdtgBqVy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RNEJxm1Dat9VSjpTxlfkBbizuYJBTBFfp26uW6Ig20=;
 b=QLYshJNHY4dFIrp63hiDMC6ypppDdJzgE3W7nxmduEHJXAYKngO5Mqy4rF7zwBe1+ZkFkHgyVlQOU7mz9EL0TSotmK85wOM3EETXBp+xUIz9RcmUYvEzBUAPyyG3S74Hu3TBE1A+AX2yixdDFaNGRC5jub4r1FtakDB0oQRGxYspIDam1UUSzqcO7la38lDUM7fdEt3giAAkLF9hyLkvM/L3J86exrF1eEdceGCwG6qeHb5zC62iGKdrBqBOKMTCz0YHhQTg11udCGoAGQ1eILWKDLbtMbV68Vfq0FQiW9Vj+/6vfiY0LtFVwYBfakWx4CfFzj5MA5PYEvz5Alz4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RNEJxm1Dat9VSjpTxlfkBbizuYJBTBFfp26uW6Ig20=;
 b=USoSUweXHckQZwcyzoWjxDSs3bECIgD3jJ/AUuUxmAMP9AgXvL6syld4oC2lqVW1tIDAMMCjevL0Zh8xNjKQe/oIcjyY5jpz8408BJH/uyoc7qRyEi1OoWeY6tTGv5NdDEZK0QyCAX/c8W0q9Eq+J6CZu5kK6dPQNeheL2lZxSd+hONEqsoAFEw+eKCDw1dxRJA4XHoyx9XfnH7IqxtGqNaFSlv/KmMS2dpc3wHz8lHSzU6nWAnsPmJpkYLhIZ7Km+Y5eXXAvqW9aQU3qlAvZH4huURAjahF/08azi4NkI6c051yBhf5mfEYFC15iqw8FfCiqwDajPjx/NsswaN3PA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 05:52:29 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Mon, 30 Sep 2024
 05:52:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v5 6/7] aspeed/soc: Support GPIO for AST2700 and correct
 irq 130
Thread-Topic: [PATCH v5 6/7] aspeed/soc: Support GPIO for AST2700 and correct
 irq 130
Thread-Index: AQHbELgAmmlHHufB3U+CQM6c2glst7JrXgmAgAR6MeA=
Date: Mon, 30 Sep 2024 05:52:29 +0000
Message-ID: <SI2PR06MB5041238576DF09A6FAC72D84FC762@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240927083351.2637798-1-jamin_lin@aspeedtech.com>
 <20240927083351.2637798-7-jamin_lin@aspeedtech.com>
 <a3ae007e-2e82-4370-84a2-63c06719f47d@kaod.org>
In-Reply-To: <a3ae007e-2e82-4370-84a2-63c06719f47d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6134:EE_
x-ms-office365-filtering-correlation-id: f7bf2172-5bb1-4b11-84c9-08dce11411ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?SjZHYmtTWFdjSEhNMkRzWVRGRllYb1BsR2dFQ3BlQkxxUUNJbHBycVBRYnhD?=
 =?utf-8?B?TGFIdGI1eE5kOU9CRGdjV0VaWUhKdlI0bnF3eWR1WldWZFAyZG5LdVp3djR0?=
 =?utf-8?B?VXdvRENVdHZ6QWk3QytHVHg5TFh6QkFMNm52dlpkWWRKamF6ekJxa1ZSYitn?=
 =?utf-8?B?SXhhbTNOWSs0MkxHS0dkaWxqbFV1ZzZMNDU1NHpHOWQzWTNYQ25Fb0VVSUla?=
 =?utf-8?B?TzRXaFR2SnE5OUJUczNKZVpuOWEzazVibGdad20zdTZSZHVrSDludG5WQlg2?=
 =?utf-8?B?Z1UyZUxZb08zTURxTkR0OEk3ZExCa2RKQkExWnNPZTRHcS9UUnFRbDZNTHpq?=
 =?utf-8?B?Kzh2RjdEd2dtaHoxZE5FMHBXR0JvNDFqb0NTdHdjWXRTcytjUm81QjI0M2lK?=
 =?utf-8?B?MlBNRGRvZTFLSkNMRkJrVzlreDRnODlPaHF5emMrT2tKbGJpZzg1R3VVUzFI?=
 =?utf-8?B?NkwxNnJxSjB3TzV0RStSSCtaaWJzTHptd3BYNUZyMnMxZnpIcTc5UzZFcUs3?=
 =?utf-8?B?UkcvSkhpYnJHbXJFTks3Y0JzMXdJTFpiUWJRdlZXSGIxRUZWY0dCcnRrTkgv?=
 =?utf-8?B?QnZQazFQY1lzblBqSmV3WklsdWZ2TEF4LzZDSFdaUEtUYjRtZ2dyUGxJd2NR?=
 =?utf-8?B?MW8zUkMwTWZieEVZSHU5L04rVWllTmp1QndCSExLRHBDSDIza0FPZ3hCKzRm?=
 =?utf-8?B?SlFMYmZ4WXZJcVRwQVRReElPNXg4NjFJa3BOTFNnd2xQbkFMWjg4aStITENH?=
 =?utf-8?B?ME0vYitJZFU4UmtMWHBqZzdoS0RtVURpSnJ5ck1MYUd1aXNvMWcwaU9UdVdk?=
 =?utf-8?B?Qnp2OS92R2lQVHdudzJpOWFQTno1dW1UZjhoUEdTK3Y0T2Y1Z29nVE9ueXpN?=
 =?utf-8?B?Um4vd2NHc0VEdkV2U0pVUmkwVFd4QzMwbFJFbjNlL0VGSE9aZDN1eXdrclpT?=
 =?utf-8?B?L09sTlFxR3NKSDJKM1NlRjVJY0tGQzZnZERpbjF3dTVCeVBLQ3FDdUd1WGd4?=
 =?utf-8?B?RVFoZEwyRGdwbzE0MStNRzR5ZUIyTU1CbEVFVnFqQUR0TUlwRjc4OUFzbUtK?=
 =?utf-8?B?cEN1bUV2WXRoUVh2N1V5RzBPYldoSzF6d08zUk5rYSttckRpRk1LVFJxRkNz?=
 =?utf-8?B?TllIb203RUZ4UjAzeXlwYnpaSHB5cmtmbS9LaW5YeTB3V0pjU2QrQk1UREFS?=
 =?utf-8?B?eDY1eHVyWUpmZFU0OVVNWkl0WXV5OUVLaHdSSjNKaGo4NFZuRURQWW5IbThm?=
 =?utf-8?B?ODZHemNEUGMyR0dNZjNEZHRsR0IyN0pXQlE2TTFqenlaQ0R3UU9qVU8wbW1M?=
 =?utf-8?B?cHdwRWdzMHZPekRLaU4yS2VCa0I3VDhJREdUNXo0c1JuRzFKSG55T0NJSkJl?=
 =?utf-8?B?dHEyci9CWWFTSnNvUS9LczRRVm5BR3ZNL3VDMGtwS0R1OEJJd01xamR3bkxh?=
 =?utf-8?B?MVhCZURQU2g0UFU1RFJCNkZhREhlZmI2VllUd1VwSyttY2swUzlUNmFHVy93?=
 =?utf-8?B?eWVjSkQzU0RoL2taTHF5VkxEN3V6dmJrbC8yVXNwaytRdTN3L2o4R0NUTmlr?=
 =?utf-8?B?UTJkTHFTTEtOUzF6UVA5TUp4K1g1eTl1MThNdG56RmV0bW5USGNla1ArZnBN?=
 =?utf-8?B?cDNaWXltWEZFMHpUN082cVNjYmIvQ1F2RWVxRGg3R21DWFpZWjgyWEh3UU1F?=
 =?utf-8?B?eEVsWXYrZ1gwNEF0MnNpejlOaGNIcUwzSzd0bmJDcUszNWFGWXo1azMvd0RP?=
 =?utf-8?B?MERTQmVvdU42emt3Wms5Z1FGV3RyaHZObVBTSGNzK0d6SVpzL2NDUktrWFlJ?=
 =?utf-8?B?dnV0MmVSN0tVSnhHU041ZDd4SXJwdGhnYmdwaTdLMFIxdUE3aUtZNEpzU1pS?=
 =?utf-8?B?dDJGMVA1R0dDWXFZdjE2QXN1bjM0TGhqc01ZRis5bnh6V0E4TjdjYkhTOUYz?=
 =?utf-8?Q?L8zUFxFu9tU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlRlQXdUbVdWSmwvR21ra0xkY3h6R2pnQitxbDVYWnlERWFkaHB1M0s0WThR?=
 =?utf-8?B?bXdLZllBZXR6azdkNEpFc0tWNXVuSHRyTDZvQVJrbHBYWGNqS2I3VC8xQXo0?=
 =?utf-8?B?RlJZdXhoTS9rVlVaeVY5RENkRnkrRDRQUUd3cVJCeFJBR1VFOXpxNHdER01D?=
 =?utf-8?B?OVBaWWhlVHhjcUFPTjdsSG15ckZXdmFHMlBzUU9hQ28zSjlWRXJBbHlxTDRR?=
 =?utf-8?B?bDVhSE1VdU5DWFhrYVhIbnpGaG9NK00vcmVYT3F2anI5dTJXcnlvYmVsVzY0?=
 =?utf-8?B?UWh0ejJHME9mRFpsbCtvR2VVSm1KVjlpeGttNkl5TzIvL3BaRTI4bkorblFW?=
 =?utf-8?B?QzNPNTdvNVJ1LzgvbkhiTWl2SmtVT0lBSU4yQlBmTnFLYS9yUlVLTXkxTmdQ?=
 =?utf-8?B?MkJNZnR4RWdGVUFiRlRUM0kwRjRXV2NVY3FtQ1pFQVMxZGRYaEQ5blBDYmRp?=
 =?utf-8?B?M0d1ekcrbkdsSGxaYVdNS3NiWU5jMXI4cDE1WmxXYTRBOXA3a0ZiUmNuclk5?=
 =?utf-8?B?cEFybmEyNU5Qemt1b1hJV3ZEYThzR0U5R0FremhyWHVCQVdRdktpeUs4cEhT?=
 =?utf-8?B?bFdXenoxckdIdjRJVVh0WHRPakVTMUI4am9PWVN3MlFrdG1FRW14NlNRbDdj?=
 =?utf-8?B?Ykk1ZW5Zb3l0NUJxaG1OVnU4Tnc0Tks1NENPUWZoMG5TbnlVa0x5UTE2dkdP?=
 =?utf-8?B?S01WUkRaeVJ1L2N3bkY2dEpGRzAxZHloTE8reVRFVXh6RWc0dm1tYzUwOVFk?=
 =?utf-8?B?aTdudHVJSThybVZnS2lpUGlxRzIwSytuUWtZdmN2QnczTjhBMkVNQUhqQkZQ?=
 =?utf-8?B?WTFNU1pkaXZkSmJkRjVWTEVVVHBPRU1LRUdROE13am45VjdIZXhHQkNjMUNS?=
 =?utf-8?B?dngwTVZJN045Tlc2TjRMd2QrNEQxU3BVcmh3RU9RRzF3eHVvM0dldjRHTnJs?=
 =?utf-8?B?R2pYSFl2bkZqVk43UXpHNGdEY3NFZ1M3bFdJbGVPVzJDNmpxN0VocmxpQlla?=
 =?utf-8?B?M04rOFdncEtiZDJ1M0hsZFp2azEwbEd0TkVJU3RtZHhnRVI2SG5sdGF0SnpM?=
 =?utf-8?B?b0lIWlZuc0x4WHJoVFI0NzUwTXlVWTJUT0VlTm4zS0VDWHU2UktPTm1hN2R1?=
 =?utf-8?B?UVplQTVkS0o0QmxBRWhrUVhiaVIyRjIrdXVTT0hGNjFWNm1iNWc0NVZ5Uld4?=
 =?utf-8?B?UDBEYlhkaDZLSkZIWUdRR1VESTFnQ3Y0bUdrcDVaZUtjcXM5ZEZrVXF5amJu?=
 =?utf-8?B?TzQ3THg1REZQVTZnWHZJY3pScWk0bU1UYTJmTnU2LzJjQTN3U1cyU0JEbVph?=
 =?utf-8?B?REJ5ZzhiWE1VYWliWHpZWFJPY2lTOE13aFpNek5yck9WSU56MXlsMTgxejd6?=
 =?utf-8?B?MGc1THBMNExwbnQ5RkxKa1I2NlZLMUVyRURYTlgzYVFPY3dVU1ZDY1hkSGl3?=
 =?utf-8?B?YjJTQ2RrWmtuVlh2NUE1K0h2WXAwbzZZNi9BcEZWWTVVTU4raHhmbkRtTUZ2?=
 =?utf-8?B?U1Rma0Z2Smh6ZmRNdGtRa1FHTlFmVmw1d3d0ZXU1NkZxQXcvVENaR0lHOGtF?=
 =?utf-8?B?dVZGakFlbm5sc1RaUHRWY3hOdkFuelJ5L1VRd2t6ZzZrV2tsTytKYmo5Yit0?=
 =?utf-8?B?YVhEcCswVXd1REQvVE9hdnVuLzlTS2xPV29xWXVIc2FUMmxkenZKSmJnT3VV?=
 =?utf-8?B?L1EvT3RHOTM3OTNpQ04zcXRwRmhHOFRHQ3VUN1ZjV0xma1VQYnBLSE5xOThy?=
 =?utf-8?B?NFpGbVpRUk5OK3FacisrelR0VUVCVnlDemtGRWFiUmJLd2t6MnNBdDJrZ0I3?=
 =?utf-8?B?NksxcjZPU1NWVEd5Q25ZVys0WlYzTVVqb01IdTlveFlEdEhlcXFBNDdRaWxy?=
 =?utf-8?B?OVplZXVhU3JLYXhzaWFaUm5XZDg0SWIrVnprVExnRytTWVZzcWlQTFhRMjJ1?=
 =?utf-8?B?MVVGUS9YOWJmK0pRUnMrNUtNcW9kWFhEUlY4YUNIZUcwNmMrVmdmdmtqN0xR?=
 =?utf-8?B?UjVDWklTc2ExV1BwOER3WkkyN3F5NTR1T0dTRHhISHJDVmFWVWpiVUJJU3Er?=
 =?utf-8?B?c2hDV0lPb1JKQ1BVSHorbmlBaTlxUnQ3MHlPRWxZVWVHRzl3OWZZWnRoTTl0?=
 =?utf-8?Q?6oZzN6Khg1qv1tvy9w4GzPBv/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bf2172-5bb1-4b11-84c9-08dce11411ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 05:52:29.5899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EopoD7UUOcfKmEmk4LRYibhHhbHeXQO8VcM2Wxh+w+Xo+Ywm1cgAJwnttcDgxFks7NAyK+0BroYZ/TPXGqGAWly5rYt+vDniHOVKHjqmrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
Received-SPF: pass client-ip=2a01:111:f400:feae::71c;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNi83XSBhc3BlZWQvc29jOiBT
dXBwb3J0IEdQSU8gZm9yIEFTVDI3MDAgYW5kIGNvcnJlY3QNCj4gaXJxIDEzMA0KPiANCj4gSGVs
bG8gSmFtaW4sDQo+IA0KPiBPbiA5LzI3LzI0IDEwOjMzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4g
VGhlIHJlZ2lzdGVyIHNldCBvZiBHUElPIGhhdmUgYSBzaWduaWZpY2FudCBjaGFuZ2Ugc2luY2Ug
QVNUMjcwMC4NCj4gPiBFYWNoIEdQSU8gcGluIGhhcyB0aGVpciBvd24gaW5kaXZpZHVhbCBjb250
cm9sIHJlZ2lzdGVyIGFuZCB1c2VycyBhcmUNCj4gPiBhYmxlIHRvIHNldCBvbmUgR1BJTyBwaW7i
gJlzIGRpcmVjdGlvbiwgaW50ZXJydXB0IGVuYWJsZSwgaW5wdXQgbWFzayBhbmQNCj4gPiBzbyBv
biBpbiB0aGUgc2FtZSBvbmUgY29udHJvbCByZWdpc3Rlci4NCj4gPg0KPiA+IEFTVDI3MDAgZG9l
cyBub3QgaGF2ZSBHUElPMThfWFhYIHJlZ2lzdGVycyBmb3IgR1BJTyAxLjh2LCByZW1vdmVzDQo+
ID4gQVNQRUVEX0RFVl9HUElPXzFfOFYuIEl0IGlzIGVub3VnaCB0byBvbmx5IGhhdmUgQVNQRUVE
X0RFVl9HUElPDQo+IGRldmljZQ0KPiA+IGluIEFTVDI3MDAuDQo+ID4NCj4gPiBBZGQgR1BJTyBt
b2RlbCBmb3IgQVNUMjcwMCBHUElPIHN1cHBvcnQuIFRoZSBHUElPIGNvbnRyb2xsZXIgcmVnaXN0
ZXJzDQo+ID4gYmFzZSBhZGRyZXNzIGlzIHN0YXJ0IGF0IDB4MTRDMF9CMDAwIGFuZCBpdHMgYWRk
cmVzcyBzcGFjZSBpcyAweDEwMDAuDQo+ID4NCj4gPiBUaGUgQVNUMjcwMCBHUElPIGNvbnRyb2xs
ZXIgaW50ZXJydXB0IGlzIGNvbm5lY3RlZCB0byBHSUNJTlQxMzBfSU5UQw0KPiA+IGF0IGJpdCAx
OC4gVGhlcmVmb3JlLCBjb3JyZWN0IEdQSU8gaXJxIDEzMC4NCj4gDQo+IEkgd291bGQgcHJlZmVy
IDIgcGF0Y2hlcy4gT25lIGZvciB0aGUgSVJRIG51bWJlciBmaXggYW5kIG9uZSBmb3IgIlN1cHBv
cnQNCj4gR1BJTyBmb3IgQVNUMjcwMCINCj4gDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24uDQpXaWxs
IGZpeA0KDQpKYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIHwgMTggKysrKysrKysrKysrKysrLS0tDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC5jIGluZGV4DQo+ID4gNzYxZWUxMTY1Ny4uZGNhNjYwZWI2YiAxMDA2NDQNCj4g
PiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRf
YXN0Mjd4MC5jDQo+ID4gQEAgLTYyLDYgKzYyLDcgQEAgc3RhdGljIGNvbnN0IGh3YWRkciBhc3Bl
ZWRfc29jX2FzdDI3MDBfbWVtbWFwW10gPQ0KPiB7DQo+ID4gICAgICAgW0FTUEVFRF9HSUNfUkVE
SVNUXSAgICA9ICAweDEyMjgwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0FEQ10gICAgICAg
PSAgMHgxNEMwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9JMkNdICAgICAgID0gIDB4MTRD
MEYwMDAsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9HUElPXSAgICAgID0gIDB4MTRDMEIwMDAsDQo+
ID4gICB9Ow0KPiA+DQo+ID4gICAjZGVmaW5lIEFTVDI3MDBfTUFYX0lSUSAyODgNCj4gPiBAQCAt
ODcsOCArODgsNyBAQCBzdGF0aWMgY29uc3QgaW50IGFzcGVlZF9zb2NfYXN0MjcwMF9pcnFtYXBb
XSA9IHsNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9BRENdICAgICAgID0gMTMwLA0KPiA+ICAgICAg
IFtBU1BFRURfREVWX1hETUFdICAgICAgPSA1LA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0VNTUNd
ICAgICAgPSAxNSwNCj4gPiAtICAgIFtBU1BFRURfREVWX0dQSU9dICAgICAgPSAxMSwNCj4gPiAt
ICAgIFtBU1BFRURfREVWX0dQSU9fMV84Vl0gPSAxMzAsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9H
UElPXSAgICAgID0gMTMwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX1JUQ10gICAgICAgPSAxMywN
Cj4gPiAgICAgICBbQVNQRUVEX0RFVl9USU1FUjFdICAgID0gMTYsDQo+ID4gICAgICAgW0FTUEVF
RF9ERVZfVElNRVIyXSAgICA9IDE3LA0KPiA+IEBAIC0xMjQsNyArMTI0LDcgQEAgc3RhdGljIGNv
bnN0IGludA0KPiBhc3BlZWRfc29jX2FzdDI3MDBfZ2ljMTI4X2ludGNtYXBbXSA9IHsNCj4gPiAg
IHN0YXRpYyBjb25zdCBpbnQgYXNwZWVkX3NvY19hc3QyNzAwX2dpYzEzMF9pbnRjbWFwW10gPSB7
DQo+ID4gICAgICAgW0FTUEVFRF9ERVZfSTJDXSAgICAgICAgPSAwLA0KPiA+ICAgICAgIFtBU1BF
RURfREVWX0FEQ10gICAgICAgID0gMTYsDQo+ID4gLSAgICBbQVNQRUVEX0RFVl9HUElPXzFfOFZd
ICA9IDE4LA0KPiA+ICsgICAgW0FTUEVFRF9ERVZfR1BJT10gICAgICAgPSAxOCwNCj4gPiAgIH07
DQo+ID4NCj4gPiAgIC8qIEdJQ0lOVCAxMzEgKi8NCj4gPiBAQCAtMzczLDYgKzM3Myw5IEBAIHN0
YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MjcwMF9pbml0KE9iamVjdCAqb2JqKQ0KPiA+DQo+ID4g
ICAgICAgc25wcmludGYodHlwZW5hbWUsIHNpemVvZih0eXBlbmFtZSksICJhc3BlZWQuaTJjLSVz
Iiwgc29jbmFtZSk7DQo+ID4gICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAiaTJj
IiwgJnMtPmkyYywgdHlwZW5hbWUpOw0KPiA+ICsNCj4gPiArICAgIHNucHJpbnRmKHR5cGVuYW1l
LCBzaXplb2YodHlwZW5hbWUpLCAiYXNwZWVkLmdwaW8tJXMiLCBzb2NuYW1lKTsNCj4gPiArICAg
IG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImdwaW8iLCAmcy0+Z3BpbywgdHlwZW5hbWUp
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gICAvKg0KPiA+IEBAIC02NTgsNiArNjYxLDE1IEBAIHN0YXRp
YyB2b2lkDQo+IGFzcGVlZF9zb2NfYXN0MjcwMF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVy
cm9yICoqZXJycCkNCj4gPiAgICAgICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNfREVW
SUNFKCZzLT5pMmMuYnVzc2VzW2ldKSwgMCwgaXJxKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAr
ICAgIC8qIEdQSU8gKi8NCj4gPiArICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJ
Q0UoJnMtPmdwaW8pLCBlcnJwKSkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0N
Cj4gPiArICAgIGFzcGVlZF9tbWlvX21hcChzLCBTWVNfQlVTX0RFVklDRSgmcy0+Z3BpbyksIDAs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgc2MtPm1lbW1hcFtBU1BFRURfREVWX0dQSU9dKTsN
Cj4gPiArICAgIHN5c2J1c19jb25uZWN0X2lycShTWVNfQlVTX0RFVklDRSgmcy0+Z3BpbyksIDAs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYXNwZWVkX3NvY19nZXRfaXJxKHMsIEFTUEVF
RF9ERVZfR1BJTykpOw0KPiA+ICsNCj4gPiAgICAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZp
Y2UoImFzdDI3MDAuZHBtY3UiLCAweDExMDAwMDAwLA0KPiAweDQwMDAwKTsNCj4gPiAgICAgICBj
cmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoImFzdDI3MDAuaW9tZW0wIiwgMHgxMjAwMDAwMCwN
Cj4gMHgwMTAwMDAwMCk7DQo+ID4gICAgICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCJh
c3QyNzAwLmlvbWVtMSIsIDB4MTQwMDAwMDAsDQo+ID4gMHgwMTAwMDAwMCk7DQoNCg==

