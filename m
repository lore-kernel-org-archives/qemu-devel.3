Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1387C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMN3q-0002Nl-8z; Wed, 26 Jun 2024 03:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sMN3l-0002My-1E; Wed, 26 Jun 2024 03:27:18 -0400
Received: from mail-psaapc01on2072b.outbound.protection.outlook.com
 ([2a01:111:f400:feae::72b]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sMN3f-0003e0-VG; Wed, 26 Jun 2024 03:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9lJEuTIJHRBh1ty9y6BcAID2Ig/VoZdI9Kjju6fBFPS/Llb+so5pL8ravoCfb8EatB5BYuNL91ahVVtVgZmGz/tD3+h4RDq7xtwMc+9Yyq3RNB96dDU38VpYedf06YtoHTGU5/mWHXSAmxR8MCnPpZSJjM6qngyswpLEe8FOiTu3gNZ9UctiWK8netV7LLOE3Nl3nribi4Z1rXXwjlHggqZ7xrL9P36F4X0XncfTmXzwi3FH2AtAgHuj8CB2EuO1IQPZ6SDFeZPwJMtdnv8UTVrNm5uhxQWTotE8FWxP2V8I4bCeCItc20ohpTI2yWaBfnkLQHq9s4s1fer0n2gPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAYKWh41qHbE9dfYbAqdgq7IhRusk421yl1BjGFNJE8=;
 b=Y8D/EZdI3MXfbd9nSxOK2oCXYznNCR5O/XRSV/bWRN213tG6I9Mrg/wRibb+hDLHYSZF3XDcAY2FA+2HHzP5w5lXUENE8Jpwv+31rGTUOO4uoaoiwRvqd05WIqqeiTuvH/nRDXmI11MXCFe3vwICgSKtqArGCSLbCxb+c99WtPNmYe83Euc/BIvQzNmowwuT1XqRdDhYyrhCtbfAMCfbpnIAxClNksU3ZtsTzgScyxcFeNVZ693/MZbDtZ1oba5yC2c9U+Dr9HyzZs905v7Wg71G/dbXRBGuZDVBbSs8AzpSWmoSCGzp+fJxFvZVtyT25VIM9ukjZ/dSAvMsxNvLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAYKWh41qHbE9dfYbAqdgq7IhRusk421yl1BjGFNJE8=;
 b=qcwR3XjlJx2Fz8OfXitV0pWz7YuX351wltRMCb/RmqY1cEs7DAPOWLWDNXorGld/4h1WotD7BzvzBhUI81RdQtLUe2nCGc8BSrhgO+EyLv+CBh4C4VC8z5MFSbt4JWMvqKjjs8YIaBQSiP/cktD9EfEUayY/Bv1hJxbjmn2MZkexftoef10rLkPttz22aVKrLAexLOyJ5fQe7LsDbYmk55es4CmZKUit95Hvi/OeBfA/6ndK2UTgOcwY2F9KFrZ+RoHojKHvLiQRW/RGmDyQfPlQwT3C38DLA78ZOuOeXGc0i5+PUEQAAJOlrMzG4itdRTFA5+e83JV85iPYdRHIWQ==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by PUZPR03MB7209.apcprd03.prod.outlook.com (2603:1096:301:110::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 07:26:58 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 07:26:58 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "bin.meng@windriver.com"
 <bin.meng@windriver.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v5 1/4] target/riscv: Add functions for common matching
 conditions of trigger
Thread-Topic: [PATCH v5 1/4] target/riscv: Add functions for common matching
 conditions of trigger
Thread-Index: AQHatjXH08A5cw20Qkm/CxIYQMY3XLHZtXAAgAARk1A=
Date: Wed, 26 Jun 2024 07:26:58 +0000
Message-ID: <SEYPR03MB67005F5CD419B6D6D76DE64CA8D62@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240604041445.244768-1-alvinga@andestech.com>
 <20240604041445.244768-2-alvinga@andestech.com>
 <CAKmqyKOngPTAyno29HNBhFZ-GdU+0Jw2ymSadmTc3oR7r5P+MQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOngPTAyno29HNBhFZ-GdU+0Jw2ymSadmTc3oR7r5P+MQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|PUZPR03MB7209:EE_
x-ms-office365-filtering-correlation-id: fa1cc9ab-2f98-4596-1b77-08dc95b15d19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230038|366014|1800799022|376012|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?SE1OWXJyM0dEaU1aRkFTQjIvajNXSWs1b3lKWWRDMzdwNmRqZVJhTXFRalhS?=
 =?utf-8?B?VituRWFCcEEvL2Zob0VKb1lhUGVxcjZ2b2JJbXhTdUhQUjBXZVd2QmR0OG04?=
 =?utf-8?B?TlRGNkJMM0VDR1paRVdlVXQzMm84RmNXNWVyRGhRSkk4aVczYzJod2I4VCs1?=
 =?utf-8?B?Z0pTTis0UTd2czlMRjc3WGVJQmhnSmJsVWFqUDdrUVBaWG54Q1AyNzl4aEpu?=
 =?utf-8?B?VFI5Q1JibzhTZklrUDJxU3o0dWhQdlR0OTZ4SmdFZk1ZUm1uejR4Mkg1aDF2?=
 =?utf-8?B?dGROeXBCTUM3YXR4bVZCT2pZUVc2aWtiQk9yZGdYUkVQQWllZnE3ejczU2RW?=
 =?utf-8?B?L1N3OTl3ZmdFR2ttZzkzMzVUMjF6TEtjbkU2YzVDb2RGbCtaQS85MVBublpJ?=
 =?utf-8?B?dStTTjUvOXBVMHc3QTY0ZlQ3ajd1emIrMVhBOFFQeHYwLzk1MTVnN1VlVDlE?=
 =?utf-8?B?L2E4Sk15enBHRGdnTDQ2NFBwR3pSaXY2djFQQmJCc0hLelZnNzcwYWR2Slow?=
 =?utf-8?B?SnV0SXp6NnhrTFUxNzlrUGRKVmY1VGlRendCenhUMm9nWGozM3hoak0reUZL?=
 =?utf-8?B?MnUydzQ5VTZPYnQwbVk0RTNpaFYzM2RreWNuVS9SSU13eW1YanpSZjAvc1lv?=
 =?utf-8?B?bHVzYkRoT1lNdmZva3ZGWngwZ1hFaGlmWWRiRWlJd0ZPUDU1UDRINjhVeUd1?=
 =?utf-8?B?Ymw4Y0dnaEc4MWxhN2NXbXJPQy9OUG0wN1g1Tmd0bndRNW5XMks0S09hVUFj?=
 =?utf-8?B?MFd1TFl3YXl6K2ZjMlRaWmlvOTYvV25vZHJtRFpLbldld3hUZnFpWVZpbGM3?=
 =?utf-8?B?SkNYR2ErZDZxRVRLbi9JTFpoNjR1OTVrRzJvb3lTSzBkVy83ekQydmJTczBM?=
 =?utf-8?B?Smc4Sy9pYW5jOVlUUlp2SFVPNWo3cjdQT1prdWdQNy9WNlB0QkxETnFiZkhB?=
 =?utf-8?B?UHZsMzhZb1F1dzNVa0hRWC84djdSWjEwQmphMkFWUzdBb0lnWVlQRHMySEJi?=
 =?utf-8?B?cUJuM1FiM2ZkRFFISzVWVEV6STUxeTkzKzVZNUVIOTBiU1VMdG5Zc0RxUnBt?=
 =?utf-8?B?Mkl3RmZYUGcwK2drc2RTb2RZS1ZmakRJYURqQzFLWkd6dUNmMzJSVkxzUmRx?=
 =?utf-8?B?a3BhdmlJeW4rSnY3TU9iUEFTcE5YTSt3MjIwL28xNHRKM0duai9LT29GVThp?=
 =?utf-8?B?MG9NdHR6THdhV2wwdy9zd1oyblh5UUxqQzhuMkE2LzdnOG9ZUjBBSEpSdGtp?=
 =?utf-8?B?QXVUQzZaR1pkVTRjYVFLb3RSUUNYYktOeCtnSUFLTXNJNk5McUUrcWloeW9m?=
 =?utf-8?B?YmZsTnFKdkNXdlRUUkNKZ2tNYWxGb0xPaTR6b0NCK1RXVFdiZW5EYlZENlNt?=
 =?utf-8?B?cTFodzBVK01nbG56RElLa01XVGRENXBORGZtdTNDc3Y0bVRRdFhwNVBiWkhY?=
 =?utf-8?B?SlZNOERaRU03TmVpUy9TT0FtWGdlYjFweDdraHBzdW5vMm8xZEpqaDR2RlNz?=
 =?utf-8?B?RzZJQTBvM0NETlQwenQzSEZHZjlXTm9kY1FsVko4Tm8yZVd1MHVSWTIvMTFK?=
 =?utf-8?B?V3Y1ZFdxMmRBbnZGa2kvdURIcm1nRG50UXM2RXlBdFFoczlFb3hybUVpMmxB?=
 =?utf-8?B?UC9UYTVnNmhOR3hPUmxXUlVkMXMvVGVtbDF3UlpPVlVqaEJkT0x4b1lBODhZ?=
 =?utf-8?B?MlZnaHFTVVNUaXlUR0QvRDdXaDRPVEFCVkJYSlBwQUZXbHRYOHJFL3VBekk5?=
 =?utf-8?B?NE9rRFQ3a3UxNGcwaW4wSmFsbFZzRkJLS0lPT3ZFVjBvMEYwQ3BCdm9NdjUw?=
 =?utf-8?Q?502dWUgsccRVhWDlbM/8FES3VHvUdjqayy8bY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230038)(366014)(1800799022)(376012)(38070700016); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHdVYWZTanFpN0pUQnc2S3FtMm9TdDk5d1A2cUV2NjV4M01zMi8yQ1AxMWFt?=
 =?utf-8?B?TitnUVJEcmV6aHB3K2o0cW5yOXpFWVJFRmRuUHhXV1hnV2had0VTeGMxc3RZ?=
 =?utf-8?B?bThiUDdwZnZrT3IvOG9wYWpMUmN0ejdzRU9OZHk2MnNhWGVNZjZLekpJNGFY?=
 =?utf-8?B?NVB2MjlIU0RhZHdWRDBkejA1UDNSK2hkdkNWa2RrRGJSY0NIZjh4VC9KOGxK?=
 =?utf-8?B?TlNOdGtPQTdQeTUzSjY5RkZBdG9LbmpmaVg5VUNwL2t2akJjZlh3L0Nvc1hi?=
 =?utf-8?B?UC9mMDRNb2ZnWUZxRm92bmcvR0xWRElwcmd5Y1VhQ2xaMHN0ZStjZldmaHVt?=
 =?utf-8?B?c094MXJWT1J4SFR0NjZiYlZub2EyL0VKYzQyYW8xN2I2NnFteFducFRBeG1s?=
 =?utf-8?B?eG9lYzBvTnYvSDVYdXpWeUorTldjUFlQNG44TlhSN2xjTlV0STFsSDJOYmpj?=
 =?utf-8?B?bnBKVG44U0FUZmpDWkVoSlFqNEloVWxZNDJ1UkVjc0FaSi9CWm9FOFV1Mkgv?=
 =?utf-8?B?MTRnYnRwbFVSNDlWeng4dDF0bHEzVm5iakV6S0NIUkdoUndta1NucHFtanNZ?=
 =?utf-8?B?UGZSa2tPZTRnc0o2MDZpcTI2MGxjWURZQll2c05jem80R3dqcmRQT2Q5UDQ2?=
 =?utf-8?B?SEpZRFFyUjZKWDFZQ0NPUHVDU0pwMlNRME9mczNIVHM4bm1RUE4zK2lCV3dB?=
 =?utf-8?B?OStYZmRFeFpaOUdmekJGa3FkaVF3OFdnSm1oOFM1SGxoMWt0NlB5cFZYaGkx?=
 =?utf-8?B?bWt1ZUMxQ1lFMnVleURCMTU4T2tWTUtLdjZxMG10WUU2T0swRjcvYVlqZTBW?=
 =?utf-8?B?Y3FDdENyTXJRa2tSc01TQkRHb1I3Z2M0UzcyYnZnd29tbXhXQVpKVTYrZzV2?=
 =?utf-8?B?RHJ6bk96SzMrMDZmblVKcmY5Q25xZElSSXFTdnVETUFrQVVqU0g2RXFmYk5o?=
 =?utf-8?B?UGhyZjU5VE9uTlovMlRLMFFWdkNUZXJTY0NUeGdhazlRZzVnYnhNMXUwclNW?=
 =?utf-8?B?bzJTWXFzTVQ4bzdHQm9SV1dYOExxUGNHb3BaT2VZbWdqSXMrSERMcjJRRTZG?=
 =?utf-8?B?M3p4cm1NYkw0SWRwWG1tTHlNU0lGR2pTZU8rT0oreng2K0c5YVBWSlJMdktP?=
 =?utf-8?B?cmU4cDNacFJEU3RvRSsvTC83cllCaTZiRVp6M2l2NVhsZkpIYUFKMmJxa25s?=
 =?utf-8?B?ZjE3dEFJYXlvKzhvRFRmdkxIMzQvU2JhdUJVVnorbUFxeDVUc05tM2RIYVhu?=
 =?utf-8?B?VFMxaFVGOFhtcFQrdU1EK3M5N2kxQWpxWEZaY2hkd21lU2dlOWNFUUVVYjZM?=
 =?utf-8?B?andTUC94b1JLWGV6K0NCVnViMXZVRUNqM3JIZUs1NHc3NEViVGd5S2QreGFN?=
 =?utf-8?B?Y3dWR0xCeWdDNWEwNFRCQ2RBMERiVXBPR3BlaHpTMjMwYjlHclZtbTNzSGFV?=
 =?utf-8?B?NFFuSDl3ZzNqWXNHVmRBZlVCa0lNNVlaVHQwWHFWR0JOK3MzeUplM2ZkTTYw?=
 =?utf-8?B?TUF2Tk1uWWFidmJMVk5ZOHFKMXpzMTJZK05TN0ZJVTFVZVEwNEVWdURWN09o?=
 =?utf-8?B?c0xjQ0J6TS9yNlR5UmM5Y0QwT2FSMDhNZkJ6c3Q4YVFKdzFzd0JqeCtEbXk5?=
 =?utf-8?B?SGFxTTYyQm5Ob0FEVkJFZWlqQTdDaFJxTlY2RzJKbGd5cUs1cW5ISU1MOWJO?=
 =?utf-8?B?dGxTcmVDdWd0SWlFWE12cnNYS2QrdkJKVDNkb252bnFjcXdSNDJ0QnE0ZENC?=
 =?utf-8?B?dG1RWHUvcUpqdnJ2S3h1cW9YM1pUZ0VsaUhLTXV5ZVJ6WXlCcVRlcVhTWElv?=
 =?utf-8?B?enBMNVVrRGhLeXNxVjRFQkhaNjF5blRySXZ1SjFSdlNGS1R4Y3BDVTBwVlBD?=
 =?utf-8?B?dlhiL2t6bEsxYm1vc2NnU3M0UlR1QVhVc1FROUpzMy9zNUtLemVYdEdqS01r?=
 =?utf-8?B?bnVuN28wUWtITGt0akQybE53R0JuMUljVWd4ekhyMkxid085NTBYd3JUWWJK?=
 =?utf-8?B?dm0wQ2RmeFM1WE5hd215OXRoT05ONTBWSHhwRWsxRXlTN0Zhano1Y2IvVlZR?=
 =?utf-8?B?aXN3L0d0dDRIdEgxbG04dVM5Z0VjR3hIWmQ0TjJsN2lqbmowSml5c2tDRjZz?=
 =?utf-8?Q?/bg645f1rUPXE3qy9lof1pX7a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1cc9ab-2f98-4596-1b77-08dc95b15d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 07:26:58.3083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iSundYA2QU0aGTixfiaM8aGM5Cxb4SIYyj0N8yDjTu75zJwVsjE40lpULVQlWz0/9KkHfkgJuRQhRjlCsMwiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7209
Received-SPF: pass client-ip=2a01:111:f400:feae::72b;
 envelope-from=alvinga@andestech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
SnVuZSAyNiwgMjAyNCAyOjIwIFBNDQo+IFRvOiBBbHZpbiBDaGUtQ2hpYSBDaGFuZyjlvLXlk7Ll
mIkpIDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+DQo+IENjOiBxZW11LXJpc2N2QG5vbmdudS5vcmc7
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tOyBiaW4u
bWVuZ0B3aW5kcml2ZXIuY29tOyBsaXdlaTE1MThAZ21haWwuY29tOw0KPiBkYmFyYm96YUB2ZW50
YW5hbWljcm8uY29tOyB6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjUgMS80XSB0YXJnZXQvcmlzY3Y6IEFkZCBmdW5jdGlvbnMgZm9yIGNvbW1vbiBt
YXRjaGluZw0KPiBjb25kaXRpb25zIG9mIHRyaWdnZXINCj4NCj4gW0VYVEVSTkFMIE1BSUxdDQo+
DQo+IE9uIFR1ZSwgSnVuIDQsIDIwMjQgYXQgMjo0MuKAr1BNIEFsdmluIENoYW5nIHZpYSA8cWVt
dS1kZXZlbEBub25nbnUub3JnPg0KPiB3cm90ZToNCj4NCj4gVGhlIGBGcm9tYCBhZGRyZXNzIGlz
IG1hbmdsZWQgaGVyZS4gSXQgc2hvd3MgaXQgd2FzIHNlbnQgZnJvbSB0aGUgbGlzdCBpbnN0ZWFk
DQo+IG9mIHlvdXIgYWN0dWFsIGVtYWlsIGFkZHJlc3MuDQo+DQo+IERvIHlvdSBtaW5kIGxvb2tp
bmcgaW50byB5b3VyIGVtYWlsIHNldHVwIGFuZCBzZWUgaWYgeW91IGNhbiBmaXggaXQ/DQoNCkkg
ZGlkIG5vdCBhZGQgIi0tZnJvbSIgd2hlbiBJIHNlbnQgdGhlIHBhdGNoIGZpbGVzLg0KQW5kIEkn
dmUganVzdCBhZGRlZCBteSBuYW1lIGFuZCBlbWFpbCBhZGRyZXNzIGJ5ICJnaXQgY29uZmlnIHNl
bmRlbWFpbC5mcm9tIC4uLi4uLiIuDQpIb3BlIGl0IHdpbGwgd29yayBuZXh0IHRpbWUgSSBzZW5k
IHRoZSBwYXRjaC4NClRoYW5rcy4NCg0KQWx2aW4gQ2hhbmcNCg0KPg0KPiBBbGlzdGFpcg0KPg0K
PiA+DQo+ID4gQWNjb3JkaW5nIHRvIFJJU0MtViBEZWJ1ZyBzcGVjaWZpY2F0aW9uIHZlcnNpb24g
MC4xMyBbMV0gKGFsc28gYXBwbGllZA0KPiA+IHRvIHZlcnNpb24gMS4wIFsyXSBidXQgaXQgaGFz
IG5vdCBiZWVuIHJhdGlmaWVkIHlldCksIHRoZXJlIGFyZQ0KPiA+IHNldmVyYWwgY29tbW9uIG1h
dGNoaW5nIGNvbmRpdGlvbnMgYmVmb3JlIGZpcmluZyBhIHRyaWdnZXIsIGluY2x1ZGluZw0KPiA+
IHRoZSBlbmFibGVkIHByaXZpbGVnZSBsZXZlbHMgb2YgdGhlIHRyaWdnZXIuDQo+ID4NCj4gPiBU
aGlzIGNvbW1pdCBhZGRzIHRyaWdnZXJfY29tbW9uX21hdGNoKCkgdG8gcHJlcGFyZSB0aGUgY29t
bW9uDQo+IG1hdGNoaW5nDQo+ID4gY29uZGl0aW9ucyBmb3IgdGhlIHR5cGUgMi8zLzYgdHJpZ2dl
cnMuIEZvciBub3csIHdlIGp1c3QgaW1wbGVtZW50DQo+ID4gdHJpZ2dlcl9wcml2X21hdGNoKCkg
dG8gY2hlY2sgaWYgdGhlIGVuYWJsZWQgcHJpdmlsZWdlIGxldmVscyBvZiB0aGUNCj4gPiB0cmln
Z2VyIG1hdGNoIENQVSdzIGN1cnJlbnQgcHJpdmlsZWdlIGxldmVsLg0KPiA+DQo+ID4gWzFdOg0K
PiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi9yaXNjdi1kZWJ1Zy1zcGVjL3JlbGVhc2VzL3Rh
Zy90YXNrX2dyb3VwX3ZvdGUNCj4gPiBbMl06DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2
L3Jpc2N2LWRlYnVnLXNwZWMvcmVsZWFzZXMvdGFnLzEuMC4wLXJjMS1hc2NpaQ0KPiA+IGRvYw0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWx2aW4gQ2hhbmcgPGFsdmluZ2FAYW5kZXN0ZWNoLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3
ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQvcmlzY3YvZGVidWcuYyB8IDcwDQo+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDcwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlz
Y3YvZGVidWcuYyBiL3RhcmdldC9yaXNjdi9kZWJ1Zy5jIGluZGV4DQo+ID4gYjExMDM3MGVhNi4u
MDVlMDAxZDA0MSAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvcmlzY3YvZGVidWcuYw0KPiA+ICsr
KyBiL3RhcmdldC9yaXNjdi9kZWJ1Zy5jDQo+ID4gQEAgLTI0MSw2ICsyNDEsNzYgQEAgc3RhdGlj
IHZvaWQgZG9fdHJpZ2dlcl9hY3Rpb24oQ1BVUklTQ1ZTdGF0ZSAqZW52LA0KPiB0YXJnZXRfdWxv
bmcgdHJpZ2dlcl9pbmRleCkNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gKy8qDQo+ID4g
KyAqIENoZWNrIHRoZSBwcml2aWxlZ2UgbGV2ZWwgb2Ygc3BlY2lmaWMgdHJpZ2dlciBtYXRjaGVz
IENQVSdzDQo+ID4gK2N1cnJlbnQgcHJpdmlsZWdlDQo+ID4gKyAqIGxldmVsLg0KPiA+ICsgKi8N
Cj4gPiArc3RhdGljIGJvb2wgdHJpZ2dlcl9wcml2X21hdGNoKENQVVJJU0NWU3RhdGUgKmVudiwg
dHJpZ2dlcl90eXBlX3QgdHlwZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCB0cmlnZ2VyX2luZGV4KSB7DQo+ID4gKyAgICB0YXJnZXRfdWxvbmcgY3RybCA9IGVudi0+
dGRhdGExW3RyaWdnZXJfaW5kZXhdOw0KPiA+ICsNCj4gPiArICAgIHN3aXRjaCAodHlwZSkgew0K
PiA+ICsgICAgY2FzZSBUUklHR0VSX1RZUEVfQURfTUFUQ0g6DQo+ID4gKyAgICAgICAgLyogdHlw
ZSAyIHRyaWdnZXIgY2Fubm90IGJlIGZpcmVkIGluIFZVL1ZTIG1vZGUgKi8NCj4gPiArICAgICAg
ICBpZiAoZW52LT52aXJ0X2VuYWJsZWQpIHsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgICAgICAvKiBjaGVjayBVL1MvTSBiaXQgYWdhaW5z
dCBjdXJyZW50IHByaXZpbGVnZSBsZXZlbCAqLw0KPiA+ICsgICAgICAgIGlmICgoY3RybCA+PiAz
KSAmIEJJVChlbnYtPnByaXYpKSB7DQo+ID4gKyAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+
ICsgICAgICAgIH0NCj4gPiArICAgICAgICBicmVhazsNCj4gPiArICAgIGNhc2UgVFJJR0dFUl9U
WVBFX0FEX01BVENINjoNCj4gPiArICAgICAgICBpZiAoZW52LT52aXJ0X2VuYWJsZWQpIHsNCj4g
PiArICAgICAgICAgICAgLyogY2hlY2sgVlUvVlMgYml0IGFnYWluc3QgY3VycmVudCBwcml2aWxl
Z2UgbGV2ZWwgKi8NCj4gPiArICAgICAgICAgICAgaWYgKChjdHJsID4+IDIzKSAmIEJJVChlbnYt
PnByaXYpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgICAg
ICAgICAgfQ0KPiA+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgIC8qIGNoZWNr
IFUvUy9NIGJpdCBhZ2FpbnN0IGN1cnJlbnQgcHJpdmlsZWdlIGxldmVsICovDQo+ID4gKyAgICAg
ICAgICAgIGlmICgoY3RybCA+PiAzKSAmIEJJVChlbnYtPnByaXYpKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgIH0N
Cj4gPiArICAgICAgICBicmVhazsNCj4gPiArICAgIGNhc2UgVFJJR0dFUl9UWVBFX0lOU1RfQ05U
Og0KPiA+ICsgICAgICAgIGlmIChlbnYtPnZpcnRfZW5hYmxlZCkgew0KPiA+ICsgICAgICAgICAg
ICAvKiBjaGVjayBWVS9WUyBiaXQgYWdhaW5zdCBjdXJyZW50IHByaXZpbGVnZSBsZXZlbCAqLw0K
PiA+ICsgICAgICAgICAgICBpZiAoKGN0cmwgPj4gMjUpICYgQklUKGVudi0+cHJpdikpIHsNCj4g
PiArICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4g
KyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgLyogY2hlY2sgVS9TL00gYml0IGFn
YWluc3QgY3VycmVudCBwcml2aWxlZ2UgbGV2ZWwgKi8NCj4gPiArICAgICAgICAgICAgaWYgKChj
dHJsID4+IDYpICYgQklUKGVudi0+cHJpdikpIHsNCj4gPiArICAgICAgICAgICAgICAgIHJldHVy
biB0cnVlOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAg
IGJyZWFrOw0KPiA+ICsgICAgY2FzZSBUUklHR0VSX1RZUEVfSU5UOg0KPiA+ICsgICAgY2FzZSBU
UklHR0VSX1RZUEVfRVhDUDoNCj4gPiArICAgIGNhc2UgVFJJR0dFUl9UWVBFX0VYVF9TUkM6DQo+
ID4gKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJ0cmlnZ2VyIHR5cGU6ICVkIGlz
IG5vdA0KPiBzdXBwb3J0ZWRcbiIsIHR5cGUpOw0KPiA+ICsgICAgICAgIGJyZWFrOw0KPiA+ICsg
ICAgY2FzZSBUUklHR0VSX1RZUEVfTk9fRVhJU1Q6DQo+ID4gKyAgICBjYXNlIFRSSUdHRVJfVFlQ
RV9VTkFWQUlMOg0KPiA+ICsgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAi
dHJpZ2dlciB0eXBlOiAlZCBkb2VzIG5vdA0KPiBleGlzdFxuIiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgIHR5cGUpOw0KPiA+ICsgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgZGVmYXVsdDoN
Cj4gPiArICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ICsgICAgfQ0KPiA+ICsN
Cj4gPiArICAgIHJldHVybiBmYWxzZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyogQ29tbW9uIG1h
dGNoaW5nIGNvbmRpdGlvbnMgZm9yIGFsbCB0eXBlcyBvZiB0aGUgdHJpZ2dlcnMuICovDQo+ID4g
K3N0YXRpYyBib29sIHRyaWdnZXJfY29tbW9uX21hdGNoKENQVVJJU0NWU3RhdGUgKmVudiwgdHJp
Z2dlcl90eXBlX3QNCj4gdHlwZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW50IHRyaWdnZXJfaW5kZXgpIHsNCj4gPiArICAgIHJldHVybiB0cmlnZ2VyX3ByaXZfbWF0
Y2goZW52LCB0eXBlLCB0cmlnZ2VyX2luZGV4KTsgfQ0KPiA+ICsNCj4gPiAgLyogdHlwZSAyIHRy
aWdnZXIgKi8NCj4gPg0KPiA+ICBzdGF0aWMgdWludDMyX3QgdHlwZTJfYnJlYWtwb2ludF9zaXpl
KENQVVJJU0NWU3RhdGUgKmVudiwNCj4gPiB0YXJnZXRfdWxvbmcgY3RybCkNCj4gPiAtLQ0KPiA+
IDIuMzQuMQ0KPiA+DQo+ID4NCkNPTkZJREVOVElBTElUWSBOT1RJQ0U6DQoNClRoaXMgZS1tYWls
IChhbmQgaXRzIGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kIGxlZ2Fs
bHkgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBvciBpbmZvcm1hdGlvbiBwcm90ZWN0ZWQgZnJvbSBk
aXNjbG9zdXJlLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJl
IGhlcmVieSBub3RpZmllZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmlidXRp
b24sIG9yIHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLiBJbiB0aGlzIGNhc2UsIHBsZWFzZSBpbW1lZGlhdGVseSBub3RpZnkgdGhl
IHNlbmRlciBieSByZXR1cm4gZS1tYWlsLCBkZWxldGUgdGhlIG1lc3NhZ2UgKGFuZCBhbnkgYWNj
b21wYW55aW5nIGRvY3VtZW50cykgYW5kIGRlc3Ryb3kgYWxsIHByaW50ZWQgaGFyZCBjb3BpZXMu
IFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4NCg0KQ29weXJpZ2h0IEFOREVTIFRFQ0hO
T0xPR1kgQ09SUE9SQVRJT04gLSBBbGwgUmlnaHRzIFJlc2VydmVkLg0K

