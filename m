Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C868C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 03:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taRXF-0002yi-Bq; Tue, 21 Jan 2025 22:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taRXB-0002xl-Ba; Tue, 21 Jan 2025 22:36:05 -0500
Received: from mail-sg2apc01on2071c.outbound.protection.outlook.com
 ([2a01:111:f403:200f::71c]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taRX5-00082W-0w; Tue, 21 Jan 2025 22:36:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNrW7MavpXPVG22WJVEpXtyCh0+AP4SAuGPmQCXG0h9VgO3QpgrnLuxkc/5+xzFxGukgk5rqwZLluHKbWhcNCXGN656nm3Oyawn8J3W2Ef12FejMG3ZwEQSEhwk7KlHmbLIkBzJj/oyPSDZo9LsD2JEhPsGsAKuN5Xlf/OXE4Mq9NV8H8m808xSjhUOaPFe9viBUXbNGCwG95Et/lG6Tw7XCC5+ksbeGv/OQKlvohgtqUz9MSZfrXbgBhq9GY2Ss7ngEmq1Z+56X6oSlLnEqnLqBVybgUk7qKWvjba/QqJs0X8O2l4+trevDr49Z9ee14W+ikk8TQJGEwVbpC+8WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRa1Z5e9GYgDbm2OiG/dBitoGDms8yb7u0xytfzq0rg=;
 b=Y4m6lbTuqkhKQS20rBZH0vdvnv9rfNpVjEJWAgXFbcG50NvSX+aNlfP31XIkkg5Uk7QYD3UJc2aYxP+sZ5IWdQnPB5unNxOUvEURVhXmoYOEr+FPcwGOm1mA74jsl3ecTIIzoWQjbz9vG7+GWz63RK3uAU5S89Eq87xlS28mk8To4wbTtEkQBnWmMf1tG3g16EoqgoVBS+fdqjkvB9tinuZQDLy7z6PTIgzzFRs4S0yq8bmK95QtlsieYN1ZBUrI20pUFyjFN4frVCNgGK+Y7gNgQhM9bTz5OBpD44KBQNC+mU/uhuJffuM267hM6+ktHzfQGQzH31IEIKsPpoUa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRa1Z5e9GYgDbm2OiG/dBitoGDms8yb7u0xytfzq0rg=;
 b=PzMzloWDOVoOQJxjCn6zdU5a98HdGZjRVMy1xOwDanaxwVZ9vNkjr8ez5+WmU0I7UxuOfBw/B/YqbPLWd4+CUubRJDwAcKzS1TJe2jrCq/5khVCpwBWmAXmdGONnW6BQ/HXsyFmL77QMjQPIcg2upp0sLTrDoV1dunlhEdNvX7xo0m3aNmhIlAc3YrMI1hlx3TqsfbOamHRJJ0+zJ3pZgRqnGjdMXOB09NcoAzBuRqGybpY+erjc6dLY3wy8KxU8OUpqbTFlvZfnfiAK3DjRXUniX+S2hBV6iMUtEbWD1QrBzpiLVgtP2JsGf7bEMO807z6nV9PIS/sfV7ypuMvofA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6703.apcprd06.prod.outlook.com (2603:1096:990:36::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Wed, 22 Jan 2025 03:35:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 03:35:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Troy Lee <troy_lee@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>
Subject: RE: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
Thread-Topic: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
Thread-Index: AQHbayHj1bnQNSChw0S0GHLE5YpBB7MiJMtw
Date: Wed, 22 Jan 2025 03:35:49 +0000
Message-ID: <SI2PR06MB5041DEDC7F75EA997D4ECCFDFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250120095820.516511-1-clg@redhat.com>
In-Reply-To: <20250120095820.516511-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6703:EE_
x-ms-office365-filtering-correlation-id: a91d2fbd-1bb9-4df6-44ee-08dd3a95dd85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UHZPVWdlazNzUnErNFg2eW03bEx5RHZ3c1BWSGFCMzdnbzRveHNSZWh2YXp6?=
 =?utf-8?B?ZmZqNEhjaGZibm5JejVaMGRabXRIc2pEa3c4SFNFN2ZhS0hua3F6eFJMK2ky?=
 =?utf-8?B?b1RXZktOU1FFa1RjT0p6TUpaWFlBVHlWaytyNk5OQ3Z5Y3l5N0tnOFFIQkh0?=
 =?utf-8?B?Q0JaaDNBQ1JxUmRRTGZXaTI0VFU3NERXQnZnMFFzK1c2RjRDYitpSjBxa01Y?=
 =?utf-8?B?VGFmb3pnMVRBNS9aUUJwOFFpU05UbnZYeW1vaUVzVW0zdHVqaWR2WXI4UlVP?=
 =?utf-8?B?Y29jRS9oNkhiN3lMSEJEek4vZXBhUTNEOTJGRFoyczlDVDJtM3RFZGgxVFNY?=
 =?utf-8?B?MFhHYzFlazBTcDlDNFY2Mk5jN3pUYzkrZzFoT21DbVZmc01mcjZxVW5jSnY3?=
 =?utf-8?B?S3h3OXJOR0tvWERpVXlaaTcxV2k1a3A3QkZ5Q2V3VmxtWXhsdk8rRTM4dzRR?=
 =?utf-8?B?Y25CTW92ZHc4NFpJS2JaMFBVb043RytNa210QUYxZTFObjB2Z3pOcWRhQnkv?=
 =?utf-8?B?S0NFVWRXK2xHNitKaWFTWnNqbE1ZWFJlMVlJS0d2VnZpMjB0NkhwWm42OUZO?=
 =?utf-8?B?ZnBTWkMzL3h2dGNSMkQrNkN1RTNMYlcrRFYvWFBvbHIrN2NvNzJVdmMyWmJw?=
 =?utf-8?B?dmdTWWlRbkJCby9OMnZTSGdxa05tREhPczNTb3krS0pMSk5OVG83WTl5UEFh?=
 =?utf-8?B?TUJlT0sxNnpFWmVKLy9EZHdWNXB0LzQzbDBhT3ZicThYZnFDMWl3a0lUREpL?=
 =?utf-8?B?aVFkbUU2dHRxNXYxT2FlU1JLL0RrYms3RWlsQ1ZjWWNUVWN0RHFnamwzWWNL?=
 =?utf-8?B?TFdBU0MrWXZxS25oV3RDMWR5Ym8xVkVsWWoxVnhkem13UzdoY28wTzUySHh3?=
 =?utf-8?B?ZDl6MS9BemY4OWpVdkVocUpsTzR1ZkJwV0ZqNHVhNmkyakVYZWVXbGZsWUVw?=
 =?utf-8?B?cUxjYUk0UnhORkFrM1EvVTdTdWpxbXVhWEF3STJMYXdjQW56V0NQWlI1Ukky?=
 =?utf-8?B?OHF3cjlEaisyMTdOVVN4bU1kcHhVSVRLc0xkbFYxc0xtYi93NStOanJiY3ND?=
 =?utf-8?B?SllaeVRNbjU0a25KV2VCN3JWVmpoaHgwbEJycXQyR2hHZG5pdkM0VU1ZdFB2?=
 =?utf-8?B?SU9TYS9vdmZmSGNsOW42VkNxSkZsdTFrdE56V1FiTjVRVGZVazA5YmN1Qjlo?=
 =?utf-8?B?cEFJSkd6d2ZiTDhhVU9TSFVjZHRlakJkNit1SDlxS2RTOFZBYkhEbTh0VnZL?=
 =?utf-8?B?VVBUMHJSaHZJc3E2VEM4T3hON3BFODg4em92TmRtVitSMDBEUzVBQ0RHQXBR?=
 =?utf-8?B?WWNkQkNUODZHSWo2Z1hweDQweFBIZEpUK0RXWVJ2SDJaalIyZ2ZNQmRrWkxR?=
 =?utf-8?B?bVE0b3p6ZUthUnY4TFFPSHRuQWUrQkhlY0dXRng5cncyYVUyTnJ5OWlkS3pG?=
 =?utf-8?B?QzN5dDJIQ0FYckpTOHBtbHJqTzAzcldIK0t3aDhMWGFuL2hNUFJnS2htSzN6?=
 =?utf-8?B?bUFqRlZGWFYxSDZjZ283L3RaRjU4UmUvVnkxZWxUNmF5bHBCL2hNTkFIb3JK?=
 =?utf-8?B?TG9SdjY5dy93di9LK1grZCtJRlFwbmdwQm9wSG1HeUN4S0hsR1BSbDU0L3pE?=
 =?utf-8?B?Y1F2bC84Wm5PZFJLalBzcmllSGNSc1lBeElNcUdXUWdGYjlZc1RtZXhuaUZy?=
 =?utf-8?B?NitOSHZlMzhRd1BpQ1BCQWswTHAraUt6dmE0QWNqY2NIUzEvUTdtNXB2WVNx?=
 =?utf-8?B?aVc5eitxU2E3L2xPajNWcDQxMXExMU5pRUhiUXFCa3pybXdDZktkb2F1Wlgx?=
 =?utf-8?B?aDNaSUwrVU0rUmJrWk9ndFNQcWFtNzVqbklqcXp5UGxBNGY1UVRkdjU1N0F5?=
 =?utf-8?Q?1vlrLGdLAQgDV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RQUDJod1VUZHo2YjF0aGxNYVljYnAwTmRpSjdrcnRocDJvQTdIbWpta3Jm?=
 =?utf-8?B?bkhrSjViQStmeFFoMFBsNmd6Y2Z6V1hUc0QrZHByR2tVaURrc3E1OFNVbm8z?=
 =?utf-8?B?aU8ydkpROWlVc1BvREM0V0kybEVCMGpXeUpESDhrV09NcDIrWE4yQ3NPeHNN?=
 =?utf-8?B?RDRVdjZwbGlIY2NTSUlPQkxodXVTWG1CNE5mSVVmamZBT0JnYSttaytOVmRP?=
 =?utf-8?B?YnBmTnprdVFudVE2aXFkWEJMN3FJQ0EybzNzRCtiSUFvODBXVTVGbkVEVzUy?=
 =?utf-8?B?eEpPK1dTajhBSXhCZWhsdlVzR0RkNzU0ZEw3dmVoUGczL212M0ZSM1F0c0ZW?=
 =?utf-8?B?OG02MUhVbzhKcFRLSnZvQnVpZDkvVk5VZzR2NU5zM2o0dW43bnZKNThZQi80?=
 =?utf-8?B?TVJTdFd1NzFHQ0JndWNyLzNwMmNzNUw4dGRXa3JyRk1iNXlNZERBSjJsbEp4?=
 =?utf-8?B?ZS9VRmE2Z2h2Ryt2bUtEdW5KSUtLZk0yb0RubHdYdjFBM3QxdVk0UDJBVGFH?=
 =?utf-8?B?TTQxSHpWM2FDbWVUeEI5RGt6SFJsOHkxY3pWUEZ4TktMbkpyOVF4TlhmRE1P?=
 =?utf-8?B?K2NYOW95ME9nRVNwaEtLeDRWVkZXSzdKQ1plOVJKZVl2eU9vY09sMTlZaCtE?=
 =?utf-8?B?UlN4UmpJMnhsU09SMGsrN3dVOWhUSk1vK1U0WDU4TEZBUzVZUXVpYUpmbTFV?=
 =?utf-8?B?Z2pWYUk1UGpvK25Hd1VCN2ZYam9GTlE5UFVTTGhkTzhHWUoyajlWbEdnYitv?=
 =?utf-8?B?aSs3ZEMvZ1M1S08wakNhWXVGWGlEdkF4azdEcU1DTkRGNVVQWFUxYVFZZUlT?=
 =?utf-8?B?dDVuQ1IwaWN5akJ5ZGc3RHo5ZCtRb1pQTDNyNkVCcWFHeUkyOXp5RlNmL1dH?=
 =?utf-8?B?VVJmU1BJTVBNdThTWC8rWHVGY2pobDBSb0hsUlNYSjRJcVp4R1V6ZDRBODdT?=
 =?utf-8?B?bFhOUGZxbjZjTTB2WDBLZUx5eTMzWk9zR0ZTZ3lNK05mQ3pnZlFBL01yUStj?=
 =?utf-8?B?UUhQS1NyVlQyWm5Ec2o1L05vWkU5ditFMGlCeXJ6V0hGL1ZEVXhwV3Bob2pC?=
 =?utf-8?B?UG9OZWF6ZEZWa3Fucmc3ZnVaM0M4Y3IremlmRnBOdnYvamRoMTNBb3hDN0U1?=
 =?utf-8?B?M3AyUXM4U3VhSWR1Wk1UbC9seGxnTUhuZjVRVEg5RlU4SHFqeDY1aU1ldkJx?=
 =?utf-8?B?dVFLa2hCb2F3VkloT2NzbXMzL2tDcnpVdXViRHZjVkNrV3ZhamlqRFhWVHlm?=
 =?utf-8?B?eHF4MjRnMzAyTTQvek9EWHNmMlFZTFNNMHUzQmR0azgvdFpNb01nUUQyVzZF?=
 =?utf-8?B?V3ZtTFJQTTdUcEtmM1I4dFdJVTk3d052QWRldWxqZnVvcFVSTVRhTXNvUGRP?=
 =?utf-8?B?QkhGUGtreXJ2TFQ2Z2pNU0pLb0ZNYktQYnZmWDlhM3JCejd6YjUzY1BEbCtS?=
 =?utf-8?B?TzZja1BRS1FmQ3hQME1nVHNxQXo1eHhSV1lzZWNwcVIrd1BkNm5SRWwvKzd5?=
 =?utf-8?B?VUhibUdoTHRJQjN3Rlg0WVlKWHVMTkd0ajhVVDlGQ3prS05hY0ljcXV2Wlgr?=
 =?utf-8?B?MDZTbDZ3VlpVNGZnQVlQcTg1WDlYR3dzUUVCY0tEL2NGdVNTWEVEOUkyaTZq?=
 =?utf-8?B?bXU2L05yTkhqdkV2YjBaUnY3ZEZ1UVFCdFFvUG1FV0pJY3NBQWZUS0ZCUElS?=
 =?utf-8?B?NmtybCtFdWVoZE94eS93ZTNvV2dQdnFjVGFOT1BhVmtqRGRGTDkva2pCZk9G?=
 =?utf-8?B?RGEvVy95a0JBejRQd3hVdUtNM005bG9adk5HMWFFN3l0T2taczJDRjFkc0tr?=
 =?utf-8?B?K2VhU1FkWXRqMUl6WUt1UmxFNzF5Zkx1Y2xEZnBNNlZxUGgyaUFRNHU3U0sw?=
 =?utf-8?B?anhkYWhvcCt2NGM0NHdNNFRsUnZaR2NoclRyTVFWdlh0Rno3VkdiY2Jxc3Rn?=
 =?utf-8?B?R0RoejJPT2NqWUlnOTlhcHNEbkttNGxKQUJEOGNlbkdtOThhcjZpd3lhK2ht?=
 =?utf-8?B?WVlQTFNNMENOM1NlMjFaR2xhS2VNZ0JEaEZhRVduYjVDSnZ3NktLUGlkcktO?=
 =?utf-8?B?c0ZKRkU4VHVSYWFFN0RZQW95UWp4bCtFSk1Mall6QWtBbXEzZERpZnkwajFC?=
 =?utf-8?Q?kUqhQ8fZOwRE8bHSWq4xXl8gw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91d2fbd-1bb9-4df6-44ee-08dd3a95dd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 03:35:49.6941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBMwi4EGcFZRMC2pptFoHh7fr1BN1d//fP5OdpUi2GsnQ2KZb5eDm+1m7Hf8bHiOGt8Sicr0NY7rF8XmCgUdeoWPDFHgUA0FAA9EJAYWgOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6703
Received-SPF: pass client-ip=2a01:111:f403:200f::71c;
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

SGkgQ2VkcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDIw
LCAyMDI1IDU6NTggUE0NCj4gVG86IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KPiBDYzogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZm
ZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+Ow0KPiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47
IFN0ZXZlbiBMZWUNCj4gPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwLzldIGFzcGVlZDogcHJl
LVBSIGZvciBRRU1VIDEwLjANCj4gDQpTb3JyeSwgSSBkbyBub3Qgc2VlIHRoaXMgcGF0Y2ggc2Vy
aWVzIGluIHRoZSBmb2xsb3dpbmcgbGlua3MuDQpEbyBJIGxvc3QgYW55dGhpbmc/DQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9saXN0Lw0KaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9RRU1VLyANCmh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vcWVtdS1kZXZl
bEBub25nbnUub3JnL21haWw1Lmh0bWwNClRoYW5rcy1KYW1pbg0KDQo+IEhlbGxvLA0KPiANCj4g
SGVyZSBhcmUgdGhlIGNoYW5nZXMgSSBwbGFuIHRvIHNlbmQgYXMgYSBQUiBmb3IgUUVNVSAxMC4w
LCB0aGlzIHdlZWsgb3IgdGhlDQo+IG5leHQuIFRoZSBsYXN0IDMgcGF0Y2hlcyBzdGlsbCBuZWVk
IGEgcmV2aWV3LiBBbiBBY2sgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBDLg0KPiANCj4gQ8OpZHJpYyBMZSBHb2F0ZXIgKDMpOg0KPiAgIHRlc3QvZnVuY3Rpb25h
bDogVXBkYXRlIHRoZSBBc3BlZWQgYWFyY2g2NCB0ZXN0DQo+ICAgdGVzdC9mdW5jdGlvbmFsOiBV
cGRhdGUgYnVpbGRyb290IGltYWdlcyB0byAyMDI0LjExDQo+ICAgYXNwZWVkOiBDcmVhdGUgc2Qg
ZGV2aWNlcyBvbmx5IHdoZW4gZGVmYXVsdHMgYXJlIGVuYWJsZWQNCj4gDQo+IEphbWluIExpbiAo
NSk6DQo+ICAgaHcvc2Qvc2RoY2k6IEludHJvZHVjZSBhIG5ldyBXcml0ZSBQcm90ZWN0ZWQgcGlu
IGludmVydGVkIHByb3BlcnR5DQo+ICAgaHcvYXJtL2FzcGVlZDogSW52ZXJ0IHNkaGNpIHdyaXRl
IHByb3RlY3RlZCBwaW4gZm9yIEFTVDI2MDAgRVZCDQo+ICAgaHcvdGltZXIvYXNwZWVkOiBSZWZh
Y3RvciBUaW1lciBDYWxsYmFja3MgZm9yIFNvQy1TcGVjaWZpYw0KPiAgICAgSW1wbGVtZW50YXRp
b25zDQo+ICAgaHcvdGltZXIvYXNwZWVkOiBBZGQgQVNUMjcwMCBTdXBwb3J0DQo+ICAgYXNwZWVk
L3NvYzogU3VwcG9ydCBUaW1lciBmb3IgQVNUMjcwMA0KPiANCj4gS2VubmV0aCBKaWEgKDEpOg0K
PiAgIGh3L2FybS9hc3BlZWQ6IGZpeCBjb25uZWN0X3NlcmlhbF9oZHNfdG9fdWFydHMNCj4gDQo+
ICBpbmNsdWRlL2h3L2FybS9hc3BlZWQuaCAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4g
IGluY2x1ZGUvaHcvc2Qvc2RoY2kuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiAg
aW5jbHVkZS9ody90aW1lci9hc3BlZWRfdGltZXIuaCAgICAgICAgICAgICB8ICAgMSArDQo+ICBo
dy9hcm0vYXNwZWVkLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE1ICstDQo+ICBo
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgICAgICAgICAgICAgIHwgIDE3ICsrDQo+ICBo
dy9zZC9zZGhjaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4gIGh3
L3RpbWVyL2FzcGVlZF90aW1lci5jICAgICAgICAgICAgICAgICAgICAgfCAyNjMNCj4gKysrKysr
KysrKysrKysrKysrLS0NCj4gIGh3L3RpbWVyL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDIgKy0NCj4gIHRlc3RzL2Z1bmN0aW9uYWwvYXNwZWVkLnB5ICAgICAgICAgICAg
ICAgICAgfCAgIDIgKy0NCj4gIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5w
eSAgICAgfCAgIDggKy0NCj4gIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hcm1fYXNwZWVkX2FzdDI1
MDAucHkgfCAgIDggKy0NCj4gIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hcm1fYXNwZWVkX2FzdDI2
MDAucHkgfCAgIDggKy0NCj4gIDEyIGZpbGVzIGNoYW5nZWQsIDMwMyBpbnNlcnRpb25zKCspLCAz
MyBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNDguMQ0KDQo=

