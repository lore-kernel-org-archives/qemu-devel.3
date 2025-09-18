Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB8CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzADz-00016h-Cu; Thu, 18 Sep 2025 04:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzADw-00014r-MF; Thu, 18 Sep 2025 04:42:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzADt-0002mA-MT; Thu, 18 Sep 2025 04:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEx61b7uZoOOsTvv+qN5LlxpF3jLoqj4u1ptizhnjezvy7C7oaVV166+Bl7pEMNfAwGiUbLroO77hNU7r3XOaw7veTe1CBrac+ieeDgH2GokL9PZMM7Qq8OidhnyRFXnag3fdPweaMu/NPkoJj8pRZ8u+niddu8RDBLVsShF0gyLvwdZKaIJliixAFtulE/tamZ6oKM4ZJM1kYAwDN/FUxIZi3ML4zmemGeXDmfKjCTvm9/Vq6epkoiaYNrqVIgF+tohmyMR9nmfsKFhnE52eGFaX/ybf+Qc7GIhEH/OS7Z901t6LM2lVYqTH4kchMHxzUfhqx5CNdSzVCmIcIN0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KjupWJKz9YfhYzzZVoUA3gy9gK+pZPvhNDyCw2Nu8c=;
 b=w0UcAKpbsp1U5TofSUNITxO+nXHeHz3alocDUQVvN80tsaaWG26Mo0iBoG+4S2cRh2p6IJYXZWDeqkNNXbORv4+M/+py3z+A5TX2hZFj9MC49Y4VG6xlq/+6o3hf7ByVv+Y4b6vOr2T5vBMvW6gXc7O1nkN8m7uZI0u5rw177pxydaVDb6fM90v9KVWcqf64Dhf+QKY6ECRRnn+NhAdJWoLlkDSoPJTqKl1mrF1Myr/aYsXIvlKNKm43PWMMysYuhbEZuKtPffGFFnikJ2r69RKeRnJMCshJHY5KGTA5hyXjMbYgTMPGx5duOdKL5qISTYLsK7F3NzPDIG+836ITIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KjupWJKz9YfhYzzZVoUA3gy9gK+pZPvhNDyCw2Nu8c=;
 b=XYyeouDAKBUHSgcbdHc9rdrGRa6QDADzqRGOUc5rm6h9r+WynUyQ1EO8/o4C643Ju4kH5Fss8r9ayb3Zn+hvkownuzEWGUBu23tSAzggHzagxtYg3ITlfNXr6EtnlfW6zxg0IDIMqTmgpqDgr9XvGuRh7B8EZdt5kIiDTIPhU+SuD+IOuhEd9NyfVl3U9tFdL1Z0mShFQx7lNjq1wM+HEuiGatqFz6BWmfO9Dwfl5OSCWK4b1sMGznfAbiBfMlsLIgbbAI509UX4Xcdk/pUt899vQXsrJJBqZiKbisG4vi9cD0rQN7D/DXAyQ11azI4QCOONhMj6rnjLgK42wSVlfA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KU2PPF092A20C67.apcprd06.prod.outlook.com (2603:1096:d18::489) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Thu, 18 Sep 2025 08:42:27 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Thu, 18 Sep 2025
 08:42:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>, Thomas Huth <thuth@redhat.com>
Subject: RE: [SPAM] [PATCH v3 13/14] tests/functional/arm/test_aspeed_ast2600:
 Add PCIe and network test
Thread-Topic: [SPAM] [PATCH v3 13/14]
 tests/functional/arm/test_aspeed_ast2600: Add PCIe and network test
Thread-Index: AQHcKEpMRbDOl4AmRk20yDJVnASaELSYkoKAgAAM8SA=
Date: Thu, 18 Sep 2025 08:42:26 +0000
Message-ID: <SI2PR06MB504112A4D42CA0901323067DFC16A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250918031348.3991681-1-jamin_lin@aspeedtech.com>
 <20250918031348.3991681-14-jamin_lin@aspeedtech.com>
 <2fba399b-4540-4d7e-a6ac-339a89a112e6@kaod.org>
In-Reply-To: <2fba399b-4540-4d7e-a6ac-339a89a112e6@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KU2PPF092A20C67:EE_
x-ms-office365-filtering-correlation-id: e2556df1-e003-4227-99a1-08ddf68f4bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?QXJITEd4M04vUXExdlN4ZG5TQWRQWm5kVFc2dGNtZUVncFdsYU5WbncwYzd5?=
 =?utf-8?B?MUt0V3UrZHFFN0VheGZiaUFCbWxNUitVQ2xZYnpPMnlxaHRUSWxJd3E4MGNB?=
 =?utf-8?B?N2NVcHF6bzRFaXAzaVF1bGNvSTU4N3NSb1dXYTR1QnVMYlhGY1lwR3NLSk5I?=
 =?utf-8?B?dFFkZXJnL09VTzJtTlNHN0xLOXpGcEVUN1ZUN3BDOWlhNGQ4TisxQnlHNXJ5?=
 =?utf-8?B?VnYzSWlFRVBIYjJyV0tTT0JaV0haU2NZd2Jnc2ZYakpVKzFZR3Nrd2lIZ0VC?=
 =?utf-8?B?UE1VLzRJbk11S2ZHMzZRb1JyY0Zzc1FGM25IdGZEeGlUaElLckJqWGlzaStu?=
 =?utf-8?B?WmtzQWo3dm8zRXBCZUxVcVhtbzFHb3VHcGxXSjZPQVJvWUVYckZMSnFiellu?=
 =?utf-8?B?MUxzNkc5cVFURlNESUl0RkJIU1NwcVN5NmhRSlExTlRIMy9VZ0wvY2tqTk0v?=
 =?utf-8?B?YVlqbW9CeHJTb3d0SGdQdjR2cGR0dWFpZFhwTDNtR3p3WTF0eW5TV2NnMmxp?=
 =?utf-8?B?RVJIcDdPNDh6WE16azNQd2lvTzlKbmZoMTVpeUZrYWlvZ3BtVGdCcm9CVzI2?=
 =?utf-8?B?NDZEN08yangyL2ZhSHZPWmd2S01XVFd0b0JDZGU4L0ZUVGthb2Raemt6dUpi?=
 =?utf-8?B?UGNJTkxWWnlOVVB4Tk92dUM2ZFFDSWRkR1Ayck96VFJHa1dKc0IxNk9sVVNY?=
 =?utf-8?B?K0RibG8rZHM2RTQ2aDNDdmF6WjNtWVJEVllRUURoNjFHdVk5Q3E5SDk5cUd4?=
 =?utf-8?B?NmdvUFo4eWNzTWpiRTdsMGE2bjdpMHAwNUdYRHVoNm04UUkxTmhXMlV5Y3Q1?=
 =?utf-8?B?eURLSmVXNjlLOUdOMTRBWDkrdTJVNFcweld2NWplN2o4WjBNK1VqUENjbTlC?=
 =?utf-8?B?azNvcFpkNjU4a1llSVhwZThaNFZiZGFkQ1JWZVBRT0s5c0hNVnBQYnNFekhM?=
 =?utf-8?B?L0pTRmhQeDdzY0RMb2U4UDA5eWp6eHZ5dEZnd0I1MHVpSElvdFhZaUlTWVJS?=
 =?utf-8?B?aHZielhQRGpxZFZ4RVVpRzA0UkhVMC9NeVp3RE9MckJ2VkJNb1MzOGxxTHNB?=
 =?utf-8?B?bFJOd29CS3FqbTBwTk9kSzc2Nk1jd0tzcit5Y29kSk9IUmpsTEhwaWdWSHV1?=
 =?utf-8?B?cDg0Mlo5dnNvVzJ6QnFJM0tBdGU0OEt3VGJZd1JqSm1DY2xjQmUyanV1djlL?=
 =?utf-8?B?MXhCQUptenQzeWN3VGZiWUcveUtIcHZPTUFPTE1oTzU0LzZkZFArcWR4b3Er?=
 =?utf-8?B?LzNiVHpuQ3JFOWdMWWkvZVpCWERzek1yQzkxMVdSYVhBY0QvYld3eG5yUzBE?=
 =?utf-8?B?TkhhcExiKzBManNrMFpMSnpRUUFZeWpoV0t4Um45U2FQY1V3NGVmSXZPR1lD?=
 =?utf-8?B?a3RtMjVuU2xDcmNtbExtMExYbGNKZmFhak00NDJaYXJ4Y0VEa0VSM1lrSnEw?=
 =?utf-8?B?czVBR2w1aU9peGt5UEFBdm5hallKcGk4OVYwSHdhT25sNGNvU2pIaEZGL2pM?=
 =?utf-8?B?Y0RuTHNPWWdTS3JsamREOFl1VGlGdVB4MVlPZWZiVHFrT2xERUk4c05tRWVs?=
 =?utf-8?B?emd1SEp6Ynp2OCtNYTBCdnVCQ0poNTN1TGtjUmNKbUltV1MvSExXbTNJOEtU?=
 =?utf-8?B?bFFubUZ1aHJ4bDk4VzRWcVcxZ3YrUWhRNUdvWWt1NlhlUHRDbWJ3R0RvaVlt?=
 =?utf-8?B?Q0ZyaFVPcDZLbTkrbkdsTmY5QXlaTURFZmY0N2tYSy9PenRoNmRYMFhIM29z?=
 =?utf-8?B?dGNFM1V5Y2dJeU5MUWdHV0JMSDg4cXM5amRjeFd6RWZ6T2hUV1cwRndlUjVX?=
 =?utf-8?B?Q1AvUlRvYm05L3Y0WDA3Ymh3cmg2ckxOUEwwOTJMYTNiTGxicjVBN2hjTVl1?=
 =?utf-8?B?bzNtcHJoOUpINDNiazFhRXI0dVZrcTdjTTZnM25XMzAzTDJHbW9HdkozRk1Q?=
 =?utf-8?B?OWVxV3VqSUFPRHlHeWhqYWNmK3pxTGFKM2hibmhDZDJOYXpLSithUkFvTVE3?=
 =?utf-8?B?aXNrdGhkcEJLa2tuL3BadktCZEcvZ2d3OWl5YjJGNnJRMHNpY0VvTmo1eWVl?=
 =?utf-8?B?cXB1VGxFM2l4eFpjaDc3OENQbjBFMDgxY1FzQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHRadjFOUEQwQlhlMk1GYUcwVFkrR1NjN2hZaHdrWWIrSVcwTkxwL3RPTTR5?=
 =?utf-8?B?WmdXbHo3SVVidmd1ZHBBRERkSW1DdWVSNW5LQmRrZloveWdnaFAyNGZqc1V1?=
 =?utf-8?B?ZjBQOHlBSGRXL2lSS2JYUHRwU3dydVB6eXVtNEZnOUdQV1dwTC84Mndic0dO?=
 =?utf-8?B?OGozMjdtcGxvMkFZaWxqVE5GVFJZRmZuU2RTdHFETGcxczNtR2ovaWptRWRp?=
 =?utf-8?B?QnVNckJ5RHI1T3U5M2ZjK2ttenk0Tlc2bmtyY3BXbWNvN3pIWWN1dktMYXBV?=
 =?utf-8?B?dW1OVENtcFN0Smo0WUE5akJkZkwxYW4zZ0ZEOTJQUkozYlJ3MnBNaWhjemVL?=
 =?utf-8?B?M0RUT3lPZ3h5N2M2R2o3Qm8zMzZkRlREL2Y4bm9KOFFkK1E1K0NabU9kNm5o?=
 =?utf-8?B?V1hJV2d0WVZ5bjRqdHNRRnJ2RHpESDVLeTRLczdXbkdIaEFKbSt6dWVUbmFM?=
 =?utf-8?B?NFZXOG1DRHFxalhPYUJGdkY4Z1dFZUhyZVRxOVBNMjRHZTcxTnVET3JQNlAy?=
 =?utf-8?B?RlJ1aGRKNi9oTjNxaTkrcWcyUHo2RFM0aUErV2RRQk91d0t3bDNGQTR2OThv?=
 =?utf-8?B?VDdSbzlsS2tPZ0IyekFWY0ZicWFLc2dzajcwR0RHV3lLemtQenFISTRVdDVP?=
 =?utf-8?B?VmZwMlRkRU41RldMSjhsZ0JwWUpjcUlJWFJ5SW41SlcydHZMVUc3SGhLRkdi?=
 =?utf-8?B?UTFWUG9VR0dOTXhxTnBjK2JmQlR3UHZYSUlvNFVZZXZMMEZzcWdURzUrWGE0?=
 =?utf-8?B?NGl4MEdZdWhrTmhHZzZidTZJZ1piM0ZGYklHckYyODBpWEVPcHFWWk13NUR4?=
 =?utf-8?B?a1I5ZUtnTHBLWWlETG95TVBrei92b0ZVRmJib0dRYU5USFZmWmhzOTdWeE5H?=
 =?utf-8?B?WVlMOVd1cVNYcHlGOHhhbHEvR2VNM3lMQTJDbXEzdVB3NFZIRzVObDh5L3Z1?=
 =?utf-8?B?Z0x1YU1nb1lUbTFVc1RzRGE5Yk1aQ3owRnZ0TE5lV2hRdlhlTHhQZTRoLzVY?=
 =?utf-8?B?a2IzRVV2SVJLdUdHOU9obHQ5bU5XaUNzLzR0T1F3bkF1VnY0SUY2QzFXWHZJ?=
 =?utf-8?B?Uk1RTE96MTZGQjNMalFxQlVybVdzdmpkTFlDS2pxVmFqdC9meVltOUF4TFJ3?=
 =?utf-8?B?TnJ2ZXFNUmx6cDhaREN6OS9qZUZ6Tk9zc2dFNFBqY1lBcjM1VjJFOW4wT1JG?=
 =?utf-8?B?ajRlUllqaDlvbVJqMHN0TW9NNlR2VGU0eUU0OXhxT29qTHhobEZPKzhaL1RL?=
 =?utf-8?B?ZkpiTE9BdjVwMnE1bW8zQmExcXE2bGRpbkJwL0tpQzJMZEhYWUgxLy9nRnRa?=
 =?utf-8?B?NGd5OVR3ckRvNmRRdnBpeGZLZTZ0UnNmOGgvUklsUjl1MHpZYzJtaXUwaVdF?=
 =?utf-8?B?ZGsxbDZBQ2J4cTJidHRGanoxQWltQVlkL0ZrbVBWNExBMDd5MHU1U2dudC9S?=
 =?utf-8?B?RjQ4RkJiSEQzV1dtTnI0QjBCU2l0QTZGOGdIZ1RuQmxtSG8yZENUdW5jVEQ5?=
 =?utf-8?B?OWFlS2M5MXlqTTZ5YStiTTJ5L2pOVHJWZWNlNm94NEREbTB6aXplekx0aTFq?=
 =?utf-8?B?dS80MHJsK1Q4ZTBaVDd6cGFkUWxuTXU3eFJDbzBzK0dEcVZHMUwyRFplb1VV?=
 =?utf-8?B?a1Zvc1A0T0FjM29mZlRHem5ZMGt6NzQxZXhDdWFrWUVMNE1WN3M2VHA1aXJ1?=
 =?utf-8?B?SU1GQnVKcThTbi8wUHJWU2g2ckZDVkhCTDFDWFJxNklOWDUwYnp4a1VFZjNa?=
 =?utf-8?B?UnBYK3l4Uk85Zzg1QlYzUlFnUGdyL2pManJNL2UxNER2YWd6cWJzNFRUZUZ1?=
 =?utf-8?B?U0lwd1NrbHphYURTVjFvNW92a0FvNmdIbmtZbkZQSGtHQ0FucHE2QkRHL1dk?=
 =?utf-8?B?RlJ1QlNjbmdGOWZERVNyV1lLRUhYWm9YZzQrTXptc1ZYK2FlL2wvVkg2ZER3?=
 =?utf-8?B?ZzA2VWFVbU1oK2JLRlI0WGFyUDVnWTBPSVBUTjY0M3VXU3l2cElIc2JvTjls?=
 =?utf-8?B?emZ2eUVOT2ZLaS9aMC9hWlBwaTNOQysxeWZkWTNyN1k4Y1hnNHRGYU1rTVgw?=
 =?utf-8?B?aVQ1SmNyWEFvTERTZjQ1dWswZjdPeE4yazZqY0ppS0tLZmhuQU5aS0krSWtR?=
 =?utf-8?Q?behMYWj54IKSdUXodVC0A/05z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2556df1-e003-4227-99a1-08ddf68f4bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 08:42:26.8194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2y0YnCqLPFQ4dnGnF9rGDhf3plqx4QDfPSMtpmQrbQ8RaY/JC+sXQ/JIjP+jM9mmd/iMaDOcfeu/DFQcZKcaw9znshkjEMgpnibpxspaV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF092A20C67
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

SGkgQ8OpZHJpYw0KDQo+IHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDA6
IEFkZCBQQ0llIGFuZCBuZXR3b3JrIHRlc3QNCj4gDQo+ICsgVGhvbWFzDQo+IA0KPiBPbiA5LzE4
LzI1IDA1OjEzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gRXh0ZW5kIHRoZSBBU1QyNjAwIGZ1bmN0
aW9uYWwgdGVzdHMgd2l0aCBQQ0llIGFuZCBuZXR3b3JrIGNoZWNrcy4NCj4gPg0KPiA+IFRoaXMg
cGF0Y2ggaW50cm9kdWNlcyBhIG5ldyBoZWxwZXIgImRvX2FzdDI2MDBfcGNpZV90ZXN0KCkiIHRo
YXQgcnVucyAibHNwY2kiDQo+ID4gb24gdGhlIGVtdWxhdGVkIHN5c3RlbSBhbmQgdmVyaWZpZXMg
dGhlIHByZXNlbmNlIG9mIHRoZSBleHBlY3RlZCBQQ0llDQo+IGRldmljZXM6DQo+ID4NCj4gPiAt
IDgwOjAwLjAgSG9zdCBicmlkZ2U6IEFTUEVFRCBUZWNobm9sb2d5LCBJbmMuIERldmljZSAyNjAw
DQo+ID4gLSA4MDowOC4wIFBDSSBicmlkZ2U6IEFTUEVFRCBUZWNobm9sb2d5LCBJbmMuIEFTVDEx
NTAgUENJLXRvLVBDSQ0KPiA+IEJyaWRnZQ0KPiA+IC0gODE6MDAuMCBFdGhlcm5ldCBjb250cm9s
bGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjU3NEwgR2lnYWJpdA0KPiA+IE5ldHdvcmsgQ29ubmVj
dGlvbg0KPiA+DQo+ID4gVG8gZXhlcmNpc2UgdGhlIFBDSWUgbmV0d29yayBkZXZpY2UsIHRoZSB0
ZXN0IGFkZHM6DQo+ID4NCj4gPiAgICAtZGV2aWNlIGUxMDAwZSxuZXRkZXY9bmV0MSxidXM9cGNp
ZS4wDQo+ID4gICAgLW5ldGRldiB1c2VyLGlkPW5ldDENCj4gPg0KPiA+IGFuZCBhc3NpZ25zIGFu
IElQIGFkZHJlc3MgdG8gdGhlIGludGVyZmFjZSwgdmVyaWZ5aW5nIGl0IHdpdGggYGlwIGFkZHJg
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+DQo+ID4gLS0tDQo+ID4gICB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9h
c3QyNjAwLnB5IHwgMjANCj4gKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rp
b25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMC5weQ0KPiA+IGIvdGVzdHMvZnVuY3Rpb25hbC9h
cm0vdGVzdF9hc3BlZWRfYXN0MjYwMC5weQ0KPiA+IGluZGV4IDg3ZTM1OTU1ODQuLmE3ZDliODk0
ZmMgMTAwNzU1DQo+ID4gLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0
MjYwMC5weQ0KPiA+ICsrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2
MDAucHkNCj4gPiBAQCAtMTAxLDYgKzEwMSwyMyBAQCBkZWYgdGVzdF9hcm1fYXN0MjYwMF9ldmJf
YnVpbGRyb290X3RwbShzZWxmKToNCj4gPg0KPiAnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRl
Y2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5LjA3L2FzdA0KPiAyNjAwLWRlZmF1
bHQtb2JtYy50YXIuZ3onLA0KPiA+DQo+ID4NCj4gJ2NiNmMwODU5NWJjYmJhMTY3MmNlNzE2YjA2
OGJhNGU0OGVkYTFlZDlhYmU3OGEwN2IzMDM5MmJhMjI3OGZlYmEnDQo+ICkNCj4gPg0KPiA+ICsg
ICAgZGVmIGRvX2FzdDI2MDBfcGNpZV90ZXN0KHNlbGYpOg0KPiA+ICsgICAgICAgIGV4ZWNfY29t
bWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxmLA0KPiA+ICsgICAgICAgICAgICAnbHNwY2kg
LXMgODA6MDAuMCcsDQo+ID4gKyAgICAgICAgICAgICc4MDowMC4wIEhvc3QgYnJpZGdlOiAnDQo+
ID4gKyAgICAgICAgICAgICdBU1BFRUQgVGVjaG5vbG9neSwgSW5jLiBEZXZpY2UgMjYwMCcpDQo+
ID4gKyAgICAgICAgZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsDQo+ID4g
KyAgICAgICAgICAgICdsc3BjaSAtcyA4MDowOC4wJywNCj4gPiArICAgICAgICAgICAgJzgwOjA4
LjAgUENJIGJyaWRnZTogJw0KPiA+ICsgICAgICAgICAgICAnQVNQRUVEIFRlY2hub2xvZ3ksIElu
Yy4gQVNUMTE1MCBQQ0ktdG8tUENJIEJyaWRnZScpDQo+ID4gKyAgICAgICAgZXhlY19jb21tYW5k
X2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsDQo+ID4gKyAgICAgICAgICAgICdsc3BjaSAtcyA4
MTowMC4wJywNCj4gPiArICAgICAgICAgICAgJzgxOjAwLjAgRXRoZXJuZXQgY29udHJvbGxlcjog
Jw0KPiA+ICsgICAgICAgICAgICAnSW50ZWwgQ29ycG9yYXRpb24gODI1NzRMIEdpZ2FiaXQgTmV0
d29yayBDb25uZWN0aW9uJykNCj4gPiArICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dhaXRfZm9y
X3BhdHRlcm4oc2VsZiwNCj4gPiArICAgICAgICAgICAgJ2lwIGFkZHIgYWRkIDE5Mi4xNjguMS4x
MDAvMjQgZGV2IGV0aDQgJiYgaXAgYWRkcicsDQo+ID4gKyAgICAgICAgICAgICdpbmV0IDE5Mi4x
NjguMS4xMDAvMjQgc2NvcGUgZ2xvYmFsIGV0aDQnKQ0KPiANCj4gSSB0aGluayBjaGVja2luZyB0
aGF0IHRoZSB1c2VyIG5ldGRldiByZXR1cm5lZCAnaW5ldCAxMC4wLjIuMTUvMjQnDQo+IHNob3Vs
ZCBiZSBlbm91Z2guIEl0IHdvdWxkIG1lYW4gdGhhdCBESENQIGhhcyAgd29ya2VkIGFuZCB0aGF0
IE1TSSB3ZXJlDQo+IHRyaWdnZXJlZC4gTm8gbmVlZCB0byBhc3NpZ24gYSBuZXcgSVAgYWRkcmVz
cyBJTU8uDQo+IA0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwg
Zml4IGl0Lg0KDQo+ID4gKw0KPiA+ICAgICAgIGRlZiB0ZXN0X2FybV9hc3QyNjAwX2V2Yl9zZGso
c2VsZik6DQo+ID4gICAgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI2MDAtZXZiJykNCj4g
Pg0KPiA+IEBAIC0xMTAsNiArMTI3LDggQEAgZGVmIHRlc3RfYXJtX2FzdDI2MDBfZXZiX3Nkayhz
ZWxmKToNCj4gPiAgICAgICAgICAgICAgICd0bXAxMDUsYnVzPWFzcGVlZC5pMmMuYnVzLjUsYWRk
cmVzcz0weDRkLGlkPXRtcC10ZXN0JykNCj4gPiAgICAgICAgICAgc2VsZi52bS5hZGRfYXJncygn
LWRldmljZScsDQo+ID4gICAgICAgICAgICAgICAnZHMxMzM4LGJ1cz1hc3BlZWQuaTJjLmJ1cy41
LGFkZHJlc3M9MHgzMicpDQo+ID4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRldmljZScs
ICdlMTAwMGUsbmV0ZGV2PW5ldDEsYnVzPXBjaWUuMCcpDQo+ID4gKyAgICAgICAgc2VsZi52bS5h
ZGRfYXJncygnLW5ldGRldicsICd1c2VyLGlkPW5ldDEnKQ0KPiANCj4geW91IG5lZWQgdG8gYWRk
DQo+IA0KPiAgICAgICAgICBzZWxmLnJlcXVpcmVfbmV0ZGV2KCd1c2VyJykNCj4gDQpXaWxsIGFk
ZC4NCg0KSmFtaW4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+
ICAgICAgICAgICBzZWxmLmRvX3Rlc3RfYXJtX2FzcGVlZF9zZGtfc3RhcnQoDQo+ID4gICAgICAg
ICAgICAgICBzZWxmLnNjcmF0Y2hfZmlsZSgiYXN0MjYwMC1kZWZhdWx0IiwgImltYWdlLWJtYyIp
KQ0KPiA+DQo+ID4gQEAgLTEzNSw2ICsxNTQsNyBAQCBkZWYgdGVzdF9hcm1fYXN0MjYwMF9ldmJf
c2RrKHNlbGYpOg0KPiA+ICAgICAgICAgICB5ZWFyID0gdGltZS5zdHJmdGltZSgiJVkiKQ0KPiA+
ICAgICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dhaXRfZm9yX3BhdHRlcm4oc2VsZiwNCj4gPiAg
ICAgICAgICAgICAgICAnL3NiaW4vaHdjbG9jayAtZiAvZGV2L3J0YzEnLCB5ZWFyKQ0KPiA+ICsg
ICAgICAgIHNlbGYuZG9fYXN0MjYwMF9wY2llX3Rlc3QoKQ0KPiA+DQo+ID4gICAgICAgZGVmIHRl
c3RfYXJtX2FzdDI2MDBfb3RwX2Jsb2NrZGV2X2RldmljZShzZWxmKToNCj4gPiAgICAgICAgICAg
c2VsZi52bS5zZXRfbWFjaGluZSgiYXN0MjYwMC1ldmIiKQ0KDQo=

