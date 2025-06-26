Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9315C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 02:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUcWJ-0000Br-Js; Wed, 25 Jun 2025 22:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUcWH-0000BA-8l; Wed, 25 Jun 2025 22:39:21 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUcWD-0001Cq-UB; Wed, 25 Jun 2025 22:39:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjthiMkcO8VAT7HVpUFk0MclxI1jnRCJXJrpAvYrvTGh+KJlNwf8gKOSYfxac4Dr4GlmOOtSP10z95AsAkGWjpkEE5todRvOYcVPWqqhgrURMfffGcz5qbeQujA+TsJkj3sP8cWbRRXeLhwUlhx4KZxyPKUweftI854iHBlqt5GI5AnOz5W1Vfxwj58PRHBUffEceHTaCMI4yuSAURjVlFqX5i4C5jsnRPo30thbTr6i2DmJnw5chJJLfNanIklw+Cn6pmwAAFewFV2qW2GwcG+2bPn33/BJsAPwCPbDhkjsxfXSyYrx8zF0jvAfu+563bJZGiHJEGiIDfiPMK3lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LvKfpFCoG46OXUysQBJ1qhAWdLUnDAG0s2QDPKBMv4=;
 b=vSCD6JNNFE7FKuVDLbcRe28ojVYyCvohOZBdXsg/cGZ/Re2sZYG4Get5CQo6eCscHldVolBCEl0g7EDh8+GFzOb0vp9UYNW6/sted2nobLzGcmHgjhag3x9wBQtcS5B3ZbBqT4+Em4vGGMqUhAH4l2TpscS0cUaRipOtXqgytPKjAObj5lW9JytztxOEYtttW2wBYqUgBJQwS7uRKNax+PxJWFvCAjhb2oWuJ/AAxoriAn1X0Dg9iKaiWTND4wRTls3ZKTVq+dzCHBejufc3rhBG3GXObLQbwL0YXk0zOZiB4HxtKTg9i+3Hp8fLiSoguB/gmUx3s864a6JGLyB2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LvKfpFCoG46OXUysQBJ1qhAWdLUnDAG0s2QDPKBMv4=;
 b=YMbL2YpfI2Y9rLDMwmDtP+o9WXzoKOFc5laZDTn1yec87HNadNCqcrXJu1DnUW97m9DrO9aoERzfiGrjH1kzNO9ySEjTNY/6adPMrglBOfd+GiezPT9dQgyojcaHsALM/hct/g8S8558T8gHJUisqB5yKB6hI6KlqNakBVMPSjxkipRKmA9nK9F8KK2w573nyNvEAo+MLFKKJSz5a7kj5B7soXZyC7JoQ1WgUy1dOGrdTowLSwJhemQYVYOryuxLk61aXP9I4D1lagBsT8kzS9SWKUXYQK2wQEJepwC+orslsVBljXj9pWzBPjiF/8TBL0yzLqvElkn4cJToLfrpMA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6345.apcprd06.prod.outlook.com (2603:1096:820:cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 26 Jun
 2025 02:39:08 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 02:39:08 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [RFC v6 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Topic: [RFC v6 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Index: AQHb5K7TOApg+TuBvUGRhcDupkjJHLQTrdEAgADsJeA=
Date: Thu, 26 Jun 2025 02:39:08 +0000
Message-ID: <SI6PR06MB76317A75FE391371D4A5585CF77AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250624022219.3704712-1-kane_chen@aspeedtech.com>
 <20250624022219.3704712-2-kane_chen@aspeedtech.com>
 <CAFEAcA-Kpg1YjdQ9toU6cYmhpo+6GRgAxxF2ny1SG8C2wFz29g@mail.gmail.com>
In-Reply-To: <CAFEAcA-Kpg1YjdQ9toU6cYmhpo+6GRgAxxF2ny1SG8C2wFz29g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6345:EE_
x-ms-office365-filtering-correlation-id: afa8cbea-5fba-4121-663e-08ddb45aa020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aU4xbXJmT1BESHc0Q2RRMEpYOTMrQ2hUK2htL2dQNUR4c3l2eXZiUEdsTXlt?=
 =?utf-8?B?cW4rTFR6QWRxZ3hIT05pUUp2RGUrSkpzbmhNZXY4NE5TcTVWcXRMdTBsRHZq?=
 =?utf-8?B?bFV0T2gwQTVpaVhYVHNsZ2prTDBtWjdUZThuQmlNMmFycGNUbE05UlBqVEI5?=
 =?utf-8?B?Q0xTcFdXR1FhWk5ZR1ZadHZDdVBQS1dabDRndmpjbnV0eEtLdnB6SlBzeDZH?=
 =?utf-8?B?NDVsUU1SS012RW15MTh3TDVpZGQxVjN2WEhTMVllUmMyMEVMaUdjblJUYm1p?=
 =?utf-8?B?Vk5DSURNZ3c0S0IvT1oxZFhyVXJyeU0vWDhOTk40bXZ0QUgvVERDUXZvWmVK?=
 =?utf-8?B?c0p5WkMwQjdYMFRpMmV4SDlEMlRDYmRKYzZQcWVmK09IM1VpZkxEVXRGSmY5?=
 =?utf-8?B?Q0ovUEdWZU82RG5OaWpOdFkrNUoxMVd6NHA0RjlnRERLUlF4encwSldZSTI3?=
 =?utf-8?B?dVdSZk1LZGhLN00yOXhQbHluOURiMngrZzFDRUl2VTNSWENvWDRUajM1dHF6?=
 =?utf-8?B?YitxS00wUEZ6cFlYN3hmZWFVUDF1aER0a04rWWRDbm9veWlmenM5U0JrdFZ0?=
 =?utf-8?B?SUdGZDNPOXdkNUpKUFBXcURKT2lYVWZUdkc1UkRxV3ZJcWJ6ZFNWb2hTT0hv?=
 =?utf-8?B?cEpRZGZkaTVwV2tyaGlSZUN5WVFrbXlRc29xSXJEVlNiS091cHBlUEpqdHU0?=
 =?utf-8?B?ZkxJY2ZSVlhUNGFBNG1uaUlLR0FrMk9tSUEvTVY5VFRvcEExM2xZWG9WcXBB?=
 =?utf-8?B?Q09Hc3NzaFg2Z1B6RzE2YTd3WVo4ejEwa0dNVG9aVy9SeUFzaFdac1dYODNn?=
 =?utf-8?B?K3luSnNiQkJ5d2ZGVEZpeTNMZlN5RDBZZGlMb3hPcDd2VkkyNTZaRzhmdEZu?=
 =?utf-8?B?NzRlUDROaE9HcFhWSEJscmdPc1RJRlZNcVpDalptcFAxTUlSUFQwWVI2akdP?=
 =?utf-8?B?Z2Nvd0lCYlVLaDQ2R3FJN0NxWXpOSm5XQU5JSjNXU2xCSmFkdG90a1RxWG1w?=
 =?utf-8?B?MVdxT0N6bUh5MTRCSkg4R3hDNEpjTlUyaWNkTkhTeWtSVHJZUXZLTFArVjhL?=
 =?utf-8?B?S3orbTJPNDBHNHBhUWhIRGZGenRlVjU0TEt6YkNrMmZ0RXZQTUNpTlZYV0JN?=
 =?utf-8?B?TzBxd09vZGErZlVUZGhzV1VzbU5SSVZqVnVYd0NFa21OSVBpS2toV25EQndz?=
 =?utf-8?B?V01DS01kdjdGaTZGZ3U4TEZ6ZlJHRFR6NTJOVzZYd05zU3RTZ3FDMU1OOTNn?=
 =?utf-8?B?aW03YklSZS9xYTZtYU9BV3lRK21rVWIrYnJQelNtQUFxcXpBY2NPZUF6RXBO?=
 =?utf-8?B?Rlpma2s4ak1yM2NuWlBzbnpDVDc1QzJLRHBzdzkveDY4bDBnSjYzWEphTEJB?=
 =?utf-8?B?RVRrbXdCb2hNbFM3TzRTZzhpekZxNHR6OXgrWVRwQmtaSjUzK1hSakhld0U5?=
 =?utf-8?B?UzZSTXY5TjVaUWR3dmJqaTVoKzNvVmkvT0xRLzZCSGVya0kyVFVLaFRZTENP?=
 =?utf-8?B?Z0FBTnk2STlaUkY3VG9JL0phaE5MaWY5TGdnRlNodU9KMmlENVc1T1BuMWJz?=
 =?utf-8?B?a3pCeWhWc3F4Y1JqWUQxNlJkSG5xMGZWVHJXUjJBZUxmNWxxUFEvVzEwWVBz?=
 =?utf-8?B?MjQrWFdiTnEwZDdDNVpZbitGNnNqb2xoTktOMWZWYmJVdmUrK1FMZUlVV081?=
 =?utf-8?B?REhZeVFjLytQeTZaWmx5eURIbnR0azd3OHA2ZDdpYzNFTkE0SE9sa3FDTElt?=
 =?utf-8?B?NGV5N0lLNXJFMVJKZlV3N3I5djdHSWpVdHdBVHlZQkFRbDdGMU9hQmtrQ0V4?=
 =?utf-8?B?ZmxWekxqU0FiKzdoYUphOXFrZlZzQ3BTc0UzV0UycUEreXZoNXZDMjc2TGp1?=
 =?utf-8?B?UzliUTBBa2c3OWZ0aitTMUdPS08reVVSZzVTNGMrSTN6cFJMMUlpdVU1QktU?=
 =?utf-8?B?WVg4WExyTWllWnRsRkExZmpkbXhDSzJHemRwVnNNU05ZMHZkR1ljYUs5NHUw?=
 =?utf-8?B?bE9ndGUrUVlnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWNGMElJY01BMmZrQ0pOM0t5Y0c5Q0R2QW9ZZ2dyMit4UTVPeDFUeXZ3SUpp?=
 =?utf-8?B?U010T2pNT0xyOGZzWmVkTmp3QVRYRXMwampBcktCcnFjTkZScDc1cjFSMTNh?=
 =?utf-8?B?QVk2RXVtVTE1QmdPRXp6UFAxck9YZE5XWFpXOEdOSW14WmpWcGs4QUtFZzQx?=
 =?utf-8?B?am9rOTYrbDl1NDBtbnlvbjRadXFDWFh6Z3JES2FlN3hEMUtqYWpFTWZ4b0lL?=
 =?utf-8?B?SXJSdXhxSll1R1BKY28yS1NhdUFqMW85aGVjMm1SbG15RlMxcExrdG9iczdB?=
 =?utf-8?B?MjVIRVYyQTI3NGwxVEI4dUJZSHVYZmgwRlVsYTZVeXBpMlBnMmg3SnpMWTFj?=
 =?utf-8?B?RE1KcURoOUxiQ1NnQmszRE1maXQvR2d2VXhxYlR6YTRqdEE5cERJclJrRVli?=
 =?utf-8?B?eFAwbWpHTXFJMjE0WnFFVFBlTWZPNjJTYVRoemdraWsrYXpITWtQQU04alNY?=
 =?utf-8?B?TW1VcnB5MUlQUGtkOGk2cGxrTjBMZEJ0M1ZLMkRnNy9PZFU3Rk5RcTFMR3Yw?=
 =?utf-8?B?RC8zbVRWdHBtOVpsQysxMkxoazE3T3pMRVg2TzZqdHN6ZktoZ0xDaGxMVG4x?=
 =?utf-8?B?YUhMUFk1WFJFU3VFTVU4MlBIMWJFYjJpTDZCVGF6UHNZdWtFUlR5REdNZW1R?=
 =?utf-8?B?dGhkY1FuVVpzTDlsVnFGNHRxcGphaktlTXpqYU1SYjJtWjd6NzlCN1UwOGw4?=
 =?utf-8?B?bWp5VlZvaUw3SlBQemRKMUk3SVdGeEFFVzlaVVJENzUrdUNBa0ViZkFmd1NR?=
 =?utf-8?B?djB0K0dhNTVOeGFyUUJiYmtNbU5JOGJPenB0QmFoRmp1V292akl0aUhFVGY1?=
 =?utf-8?B?bjQ2T3F2aDlPbW9kZ0dyOEY1REFzZ0hYWnRiSmkxMU8xaWVjU2QyQ28ya29x?=
 =?utf-8?B?L2l4L2gzem0xazVKR2FQTmEzQVdXQ3VuZHpzOS9YQTN2cHhKaWMreGczRkdJ?=
 =?utf-8?B?ek9DMVVlNWk5eG1lRnFsM3NGM1Z5OEMyUVcxemVpckFSQzJzU1JERk1WV3JN?=
 =?utf-8?B?R3lIOGZOWm52bnRGWmtlbHhDeHNrWGJ2bGRkTTFtOXFTZEhGanBuSTgyTVk3?=
 =?utf-8?B?UGNIQnhLb0pxcDN2amR2THczU2t3WkJjbEVMWHBjTzZ1UzBHRHFIODhEWFBH?=
 =?utf-8?B?UFRzRGNvaHloellUMDhmcnoxNU5JYWpKWkEwb1ducVV3eGpxNld6VVI5ckpX?=
 =?utf-8?B?RDlOSVV0WjFlREpRMjBJZ1RwK2NFM2I3Sm54TU1jTUoxT1dxT01rdzNCc0NH?=
 =?utf-8?B?ZVdVKzREVTVVVmt2L3RvbUpyTWxRb29MNFFUekIyQ0VwLzRsbE51c2lqWXdr?=
 =?utf-8?B?cXpibWl0TFBNRXFaUXp3SEN5QTZ3aFlCcldtK0R4cU9wQVFZSXR6aVhhM0NS?=
 =?utf-8?B?OGNPcWZ5OGRrbDFjMGFwU0dTcldvMHlBbEd4bnNNQk5EWFZMU25Sb1FEeWkz?=
 =?utf-8?B?anlPcXIwRjJwYit1RGtjQWJDaGFqc2hPSWt0ZlRTMTVPZHFoT0JnTSs0Tm1H?=
 =?utf-8?B?Zm9rZGNZZ2FUZisvUzlaOWptUzRqM2kvbXl5TGdvNkk5UE9tL2xLSVI2WmUy?=
 =?utf-8?B?RHVRNEZlSllOeVAvaDNFdHFObU5RN2RLaXlJZ1JvZjcybnRkcEpXZk51ellG?=
 =?utf-8?B?UkNlYktXNkd6c1VBaDJCVCtrSjhjUmhGQzdFcWJBayt1RVVrMHhXQ1pOb2N0?=
 =?utf-8?B?c2RQSjJHMGtZMS8zblpuQ09Kbld5eFRGYWdZcVE5dUM4U1RWcWtnN3M0ZE5w?=
 =?utf-8?B?S21EQzNkeFBqc3BkS0trdGhLNUZKSXd5YXpEVkdmcmhSOXRjc2dVRGVscmt1?=
 =?utf-8?B?VXZ3bzVTT2pOQzduOEVIdTEydEw2NURoMERybG1zUFVTZXRHNkdodnhjczhh?=
 =?utf-8?B?VWhMbGkzMGpNdXpIZ0g5RGJCQ294WldvY0g1L2JRa25uREJ2VU10YlRqTGZR?=
 =?utf-8?B?bHVVQXh4VGt4OWlkcUZheE5sdldwakR0TnAwZ1hwa0YwaEhsVHR1SFFzaXpw?=
 =?utf-8?B?M0h4UEtjNXExdi9OcVk1VWtoQnprN1MyWG1uczRlbnJrME1sL2JLbEJzNmpP?=
 =?utf-8?B?NE55MUhuenByWG0vTTN3amx0YnNXWEdRb1JWOFZ6MVo5YVJkVGhOTjV2eXRT?=
 =?utf-8?Q?dOZw6c/lvwAAI9qJIp7NWVsCw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa8cbea-5fba-4121-663e-08ddb45aa020
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 02:39:08.2496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcLkllB3sWcsmL2gd07FdZNtAEQn9FjWFFVap5Gslh29GxwvCI9t/cuiYvILWICZdvPTqZg0tO8MWhXAJ61TZ98l2312/nE9NmiqFgp4plY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6345
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgUGV0ZXIsDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLg0KDQpZZXMsIEkgZGlkIHJl
dmlldyB0aGUgZXhpc3RpbmcgZGV2aWNlcyB1bmRlciBgaHcvbnZyYW0vYCwgaW5jbHVkaW5nIGBi
Y20yODM1X290cC5jYCwgYG5wY203eHhfb3RwLmNgLCBhbmQgb3RoZXJzLiBIb3dldmVyLCBJIGVu
Y291bnRlcmVkIHR3byBtYWluIGNoYWxsZW5nZXM6DQoNCjEuIExhY2sgb2YgZmlsZSBiYWNrZW5k
IHN1cHBvcnQNCjIuIEluYWJpbGl0eSB0byBzdXBwb3J0IG9uZS10aW1lIHByb2dyYW1taW5nIGJl
aGF2aW9yIGZyb20gMSAtPiAwIGFzIHdlbGwgYXMgMCAtPiAxDQoNCkZvciBwb2ludCAxLCBpdCdz
IG1hbmFnZWFibGUg4oCUIHNvbWUgZXhpc3RpbmcgZGV2aWNlcyBkbyBzdXBwb3J0IGEgZmlsZSBi
YWNrZW5kLCBvciB3ZSBjb3VsZCBpbnRyb2R1Y2UgYSBtaWRkbGV3YXJlIGxheWVyIHRvIGFkZCB0
aGlzIGZ1bmN0aW9uYWxpdHkgaWYgbmVlZGVkLg0KDQpQb2ludCAyIGlzIGEgbGltaXRhdGlvbiBv
ZiB0aGUgZXhpc3RpbmcgbW9kZS4gTW9zdCBleGlzdGluZyBpbXBsZW1lbnRhdGlvbnMgYXJlIGRl
c2lnbmVkIGZvciBPVFAgbW9kZWxzIHRoYXQgb25seSBzdXBwb3J0IDAgLT4gMSB0cmFuc2l0aW9u
cy4gU3VwcG9ydGluZyAxIC0+IDAgb25lLXRpbWUgcHJvZ3JhbW1pbmcgd291bGQgcmVxdWlyZSBz
aWduaWZpY2FudCBtb2RpZmljYXRpb24uIEV2ZW4gd2l0aCBhIG1pZGRsZXdhcmUgbGF5ZXIsIHRo
ZSBsb2dpYyB3b3VsZCBiZWNvbWUgcXVpdGUgY29tcGxleCwgYW5kIHRoZSBjaGFuZ2VzIG1pZ2h0
IGJlIG1vcmUgaW50cnVzaXZlIHRoYW4gaW50cm9kdWNpbmcgYSBuZXcgZGV2aWNlIG1vZGVsLg0K
DQpUaGF04oCZcyB3aHkgSSBkZWNpZGVkIHRvIGltcGxlbWVudCBhIG5ldyBtb2RlbCBzcGVjaWZp
Y2FsbHkgZm9yIHRoZSBBc3BlZWQgT1RQIGRldmljZS4gVGhhdCBzYWlkLCBJIGRpZCByZWZlciB0
byB0aGUgZGVzaWducyBpbiBgaHcvbnZyYW0vYCBkdXJpbmcgZGV2ZWxvcG1lbnQsIGFuZCBDw6lk
cmljIGFsc28gcG9pbnRlZCBtZSB0byBgcG52X3Bub3IuY2AgYW5kIGBtMjVwODAuY2AsIHdoaWNo
IHByb3ZpZGVkIGhlbHBmdWwgcmVmZXJlbmNlIHBvaW50cy4NCg0KUGxlYXNlIGxldCBtZSBrbm93
IGlmIHlvdSBoYXZlIGFueSBjb25jZXJucyBvciBmdXJ0aGVyIHN1Z2dlc3Rpb25zLg0KDQpCZXN0
IFJlZ2FyZHMsDQpLYW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBl
dGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdW5lIDI1LCAyMDI1IDY6MjYgUE0NCj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVl
ZHRlY2guY29tPg0KPiBDYzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz47IFN0ZXZl
biBMZWUNCj4gPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8bGVldHJveUBn
bWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJl
dyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkg
PGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25n
bnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz47IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtSRkMgdjYgMS8zXSBody9taXNjL2FzcGVlZF9vdHA6IEFkZCBBU1BFRUQgT1RQIG1lbW9y
eQ0KPiBkZXZpY2UgbW9kZWwNCj4gDQo+IE9uIFR1ZSwgMjQgSnVuIDIwMjUgYXQgMDM6MjIsIEth
bmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4gSW50
cm9kdWNlIGEgUUVNVSBkZXZpY2UgbW9kZWwgZm9yIEFTUEVFRCdzIE9uZS1UaW1lIFByb2dyYW1t
YWJsZQ0KPiAoT1RQKQ0KPiA+IG1lbW9yeS4NCj4gPg0KPiA+IFRoaXMgbW9kZWwgc2ltdWxhdGVz
IGEgd29yZC1hZGRyZXNzYWJsZSBPVFAgcmVnaW9uIHVzZWQgZm9yIHNlY3VyZQ0KPiA+IGZ1c2Ug
c3RvcmFnZS4gVGhlIE9UUCBtZW1vcnkgY2FuIG9wZXJhdGUgd2l0aCBhbiBpbnRlcm5hbCBtZW1v
cnkNCj4gPiBidWZmZXIuDQo+ID4NCj4gPiBUaGUgT1RQIG1vZGVsIHByb3ZpZGVzIGEgbWVtb3J5
LWxpa2UgaW50ZXJmYWNlIHRocm91Z2ggYSBkZWRpY2F0ZWQNCj4gPiBBZGRyZXNzU3BhY2UsIGFs
bG93aW5nIG90aGVyIGRldmljZSBtb2RlbHMgKGUuZy4sIFNCQykgdG8gaXNzdWUNCj4gPiB0cmFu
c2FjdGlvbnMgYXMgaWYgYWNjZXNzaW5nIGEgbWVtb3J5LW1hcHBlZCByZWdpb24uDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgaHcvbWlzYy9hc3BlZWRfb3RwbWVtLmMgICAgICAgICB8IDg1DQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBody9taXNjL21lc29uLmJ1aWxk
ICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX290cG1lbS5o
IHwgMzMgKysrKysrKysrKysrKw0KPiANCj4gT3VyIG90aGVyIG90cC10eXBlIGRldmljZXMgYXJl
IGluIGh3L252cmFtLy4NCj4gDQo+IFlvdSBzaG91bGQgcHJvYmFibHkgbG9vayBhdCB3aGV0aGVy
IHRoZXJlJ3MgYW55IGtpbmQgb2YgYWxyZWFkeSBleGlzdGluZw0KPiBjb252ZW50aW9ucyBmb3Ig
dGhlc2UgdHlwZXMgb2YgZGV2aWNlcyB0aGF0IHRoaXMgb25lIHNob3VsZCBmb2xsb3cuIChUaGVy
ZSBtYXkNCj4gYmUgbm90aGluZyBhcHByb3ByaWF0ZSwgYnV0IGl0J3Mgd29ydGggYSBsb29rLCBz
byB3ZSBkb24ndCBlbmQgdXAgd2l0aCBoYWxmIGENCj4gZG96ZW4gZGV2aWNlcyB0aGF0IGFyZSBh
bGwgZmFpcmx5IHNpbWlsYXIgYnV0IGFsbCBkbyB0aGluZ3MgaW4gYXJiaXRyYXJpbHkgZGlmZmVy
ZW50DQo+IHdheXMuKQ0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K

