Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7B9D232C7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 01:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve1D4-0003zx-W3; Thu, 08 Jan 2026 20:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve1Cw-0003zV-A9; Thu, 08 Jan 2026 20:22:30 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve1Ct-0002mQ-UT; Thu, 08 Jan 2026 20:22:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgqD3ikrFnZgMp6P3hTt+whL3kEabNn8tZeMyaiT8PiQexNXlwLkzTfw8MUAzkRNQUW19peXnobmqOcwzn+02NwK/YxEflNtulXZNd7wuvc2NRSgC8uWD1x/LYu5Okau87PlZvOyW0PNpTRPVC9PUTgCBbCqhStGd5/TlVlQz6LOpbArkDXqsfj7gyZZKY+Tqhg8Txn41zXZEuVvPz9Sbz+k0JZoaI62OxhjNxGocEuXfud51E3bduI7PZCd2K4Sz3iX7f8UPSqxmcmc2OEHNViL+RoIsQlUc7NdslbPDjamINTm1DTxU5BtFi8VjhAfoDrSyo14GMnV6zL5kuVv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONbl3I4Y9zoCfCtJRUF/R0T7u7mdak27K0UdtL+OH9g=;
 b=cQBDvzkQfq4wBYg1klWxuZohoVNzBVagHOhfTAeGK8no1xUzozUrvkJFvQhKnHK/e0gJTTQ8QLszwUhzmwkxUp4NiJNMyExYXNLg5KUFAkewlh2sRGa7nPgMTIVflr2FOCflw0x7s9tfm/WmIADSkqi+xVB2bQIyAMYUUWn/frvHnm9teyUzcIHoXmXqVaJ+nUDITXG3+/YOiM4S3VfuWHQlg5GM7aQoRyVNLd7x258RaOFeTiJLjsgP0l3l7hKOH+IbsoYmz/jrR88KUoaw9JDfuA6WpH4Ql6NtgrKu+EOl12DfuwTpGwnxfHw2NM/5uRoVt5yyIaabXoXHHz7fXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONbl3I4Y9zoCfCtJRUF/R0T7u7mdak27K0UdtL+OH9g=;
 b=BVaBBbug/LGeYbqgauJil0o467IGceAmban3XSpPBraBgmbRchoc3RK8q1ghgemYZa1E5VQSDBb0S0UOnkmnS0r4EaBJcR5MNjfrSu9fVmu3wLJS6ytRDCDBFv6ShWeywb9P/1gYajk3wpjfbMoenwyZ+T3qg2YPZne0Za+TuP6JZnxb5GndsocOVpEznYD3qI4to7qz7sYnTaiku+8AOSan0JgVNy5CMIv4eiPpE13ufzki1/dXmMyDimyl22NAiuKkSynRNzJvvjcUx3RKaZko+hpULhyOIg5AH3WCXLZSyu8FVU/ErE8WSjunSztr70ah6JfVK3XKgF1/YOtZeA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7179.apcprd06.prod.outlook.com (2603:1096:990:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 01:22:17 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 01:22:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: RE: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
Thread-Topic: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700
 model
Thread-Index: AQHcdHaLolfkRaHxzk2g38Q5LCUPSLVG4dYAgAALpoCAASH/AIAAGX+AgAD3c3A=
Date: Fri, 9 Jan 2026 01:22:17 +0000
Message-ID: <TYPPR06MB8206873F6718E29517AEC90BFC82A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
 <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
 <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
 <SI6PR06MB76312CC4E874C642DA879F11F785A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <6f0e285f-4921-4b18-8dac-f80b435dc1b4@kaod.org>
In-Reply-To: <6f0e285f-4921-4b18-8dac-f80b435dc1b4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7179:EE_
x-ms-office365-filtering-correlation-id: 9a9373cf-7e92-48af-2bab-08de4f1d871d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eStpb2NZLzh3eWJBQzJ0cjFlbW5iaTFTVFVMUG1lY3IvR3ExQWxoK3BpWmN4?=
 =?utf-8?B?OUFRZHdvRk5WRDB3OCtzWURMNTltTEllK1FYSlc3VThnTlJOeFZYcjNoaE9D?=
 =?utf-8?B?bFZ2YjNLTUt5WVhDaHkreDNvSktmL2xIcVM5bnFUTG5TZE5tUmtJeS9hTU01?=
 =?utf-8?B?N0dJMzdvMmdpRU1MVkpON0J4bDgwUUw2T0FiTDMyMEdGOERPVVloQm01U2tC?=
 =?utf-8?B?ak95bWdKRmYwRjQxTVM2ZHA5ZHFoTGR6Wnlyam9LSnpIRS9RWDc5ZHJNNEho?=
 =?utf-8?B?U25YdjJ4S3RzWGtjM1pxWnhkWDJEalA2QktINWhHQkFnaWEvZE50MjdJTW9P?=
 =?utf-8?B?NFY3NGdEcGNnU1dOQTlRcVlsWGxTMjAxZy9DV280UzZ4OGxBeW51VG1TNDZy?=
 =?utf-8?B?MXVJOXdaRmEzRHQ5dldRaEd1NE1YdFhNTlloYVlpY0tCR1RxTldmdFJWbHd6?=
 =?utf-8?B?MTFVVUF6NWZPUVE0NGVsb04rQ1dUdG5xOEluZU81blBQR0hHVTNWMVVib0Uv?=
 =?utf-8?B?cmJsWjVXQ09rcXRPRzJYaFlneThHS0QzamVjclhNUFVuY1BqSDBFeGp2SkN2?=
 =?utf-8?B?Q3hiVWJScCsxZzQ3ZVlBcE91b3FoMkdvb242bTl4RFZGNkNSUWh5d3J4bS9k?=
 =?utf-8?B?aUVWb3dmU2xrZ0lFUkVNMkxUU2xKdzBpaHYwYk0xYmc5YVB3WnVieGtqSVh2?=
 =?utf-8?B?dzMrLzJMMHNCL09NZTA4d2xuK2IvYm9IdHJhbkVhT0RzOStqVUNua3IvT29L?=
 =?utf-8?B?S1BQc3VYOHZwTnlBOTNVQTdpcUdpU1pOeXVDalJpZ211N3M0eklFTWEyREJj?=
 =?utf-8?B?YXYrK3o3SHNLZ09vOWJLY1JPWk8zUy9PVEpzYlJkMm5lSWdwS1RQdkVZeXFM?=
 =?utf-8?B?T1daWGxIZEJKazFKdm5MOEV0RHhFUFRIUlRSNzRPVFJiYVZaSXM2ZXVHd1BS?=
 =?utf-8?B?UVRMdlFpR2xLZ1JINU1QZ3gwNVVhRVFNcHZ0NVlzVm55VEwvVUZPR0E2aDVZ?=
 =?utf-8?B?WXFNUW8wd1JEZ245c1UzaEhUd2VVNlFIZVU4ZEZsRWJlMktaSWxQQi9wbkVz?=
 =?utf-8?B?c3JSOW43eWFidTFJUDdVZGJ0bUpWWkwwb3dUam9HRTBjcnlwZUpVSkkzSTVX?=
 =?utf-8?B?SEszeGpaTHkzWHRKWXhmeXpmVEJjcDg3TTEwRDFGSTJnSEE3UERTTStZM0c4?=
 =?utf-8?B?cFZRN2p5dnVmZnk3eW5zVmE2Z1J4QlE5SW5xMVU2VzQzZGNJclo5bjR0dTJC?=
 =?utf-8?B?UDV1SzJTYjVFMnladm80b1dOV3RaaXhTaEJZWlVZZjIvVkNZdUZ5OXdmRVJx?=
 =?utf-8?B?TE5CYkZvbTcreE5jZVlWL2tVcmJtUzhreVZGeXRMT0dGWk84NlFMTkFXMTIz?=
 =?utf-8?B?Y2JuL29IbDNndG92RDVPTzVDNHdqQzY4elkyR1hZT2VZNHFFdnlBTkI5S2Fp?=
 =?utf-8?B?QWkwejA2elp5OFlDcXordW9HaFM2bVVQVGpOQzFJY2swN1QzL2hiRVV0eWRa?=
 =?utf-8?B?Y3F6elNiUzBER0JhVVR3b2RBWWNMREd5SHduWDZxM0hnQzNvK3hiWUFCckt5?=
 =?utf-8?B?ejRUdE9xTG9LUGttN1RuYlBwaHc0eStkWlR2V1RHOU52SGF3WXZSaHYrWE9k?=
 =?utf-8?B?Sy9mQ2tqOWFjMWdQSjN2MzJyaW1WbEtXdWNsdFc2ZUtSMUVPNk5OOGFwSzQ3?=
 =?utf-8?B?VmtrcFprZGFTTitPRDYwdm9RUlhJYTVoMFVzTTFjc0pIaEdTSFo2OWdCckk4?=
 =?utf-8?B?Z3lUL1VWM1Q5ZnBNNUp3ZmlDOERHUHpkMko4bHhDc0ZHVzZTemYzdUV4ZHlu?=
 =?utf-8?B?WDcvakdwZ2xxODh6Ny9qMlJXdHpvYWJhQXZ1cWh1cThKNFBLOSs0SE1qWEJL?=
 =?utf-8?B?Yk5CM2t2cjIrMXcvdlJ0Y08ySFdHRFZyTWU1NGZjc0dLUW5CQ0Z3VjlGZ2xP?=
 =?utf-8?B?Q0NLemFJbEdrWGFxR1hvV0VrTURBYmVCWkltUlBrM1dGK0llcXFlencrc2tv?=
 =?utf-8?B?M3J0bkplY0Vaa1NvNUh3MmVQTkRMdmVpZy9wUnZSUDdwbVhJQ1hhL1ZERm1M?=
 =?utf-8?Q?/DJ3uX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1pwTEVSS1dXbkhTcUJ6bkZrUmpBZXU3Q0g5Y2Uwb1g1U3hQaFVVNnJYeDBs?=
 =?utf-8?B?RHkxVFdJQ2R6dWg0MmpYaEFZR21SRVU0U2dZMDFOREhoN2c3QVdjMGl1M1kv?=
 =?utf-8?B?MUh2YUs4c25VL1hJR0Z5NUZYTHl3eEJ1K05XNmZ3VVZyNlFwWUpVR0VYU1FV?=
 =?utf-8?B?QnFqQzBJM1Z0dkc3VFVIVk44ZDVnUEt0NUhSWEYrdVdjVzdDK2RFcWkwMUR0?=
 =?utf-8?B?NW5qRi96cGd1aFRLRktlbSs5UmdKT002RXQxMkQ3TXBNZkVSMVVPb3pRekR0?=
 =?utf-8?B?dnJCVTdmbEkxbGNocktRRkE3Z1hyT2d6b2s3YkdxK3B3ZEpyK1dWUFpESDVH?=
 =?utf-8?B?T2ZxUDdSS25SS1Nndm9BQldmOXVsaXpvcWpFRWtmWnRwM1BWdW5sMDlUcEVu?=
 =?utf-8?B?ZHhCYnovRXRVWS8wK3Z2V1d6N3NMNzlLbzZUNVVXTURCVWNqVnZXTFR3WXR4?=
 =?utf-8?B?NFB3VWdORlBSdjA3UE52T255RE5MTENRSHcvcytxS3ZCZTcxNkxLUEtVaVNa?=
 =?utf-8?B?eHlJc0hVbmFzMVlnRVNlcGVLRFZJS0wyQWpwQzVvclJVenF0d2JJc2xiK2I4?=
 =?utf-8?B?RFdvc1NsZHM3Q3hMQmxHNUhVSUxMZmJmc25yS2drOXJ2KytrV0lmNDBnNmpT?=
 =?utf-8?B?ZDF5ai9FQ2dxVXdwcXN0MEwzNmFhSXFwTmZJZkFwaTZ5VDFQenN3cCttVG1i?=
 =?utf-8?B?Qm1qTVRRRktVVXBRVmR5NWNUTTV3THlveFgrNy9nNkpkV3VlY2phTTY5NWlS?=
 =?utf-8?B?Z05TSXh0TUsySGZzcFEyTzBJQ1M1d0lzcUhxUk10Mm45RERnQ1V6dEorTjVp?=
 =?utf-8?B?UVppUCtEd2dPd0hTbTBFSk9QTHZ4WG5yWjkvbHBGNS9IaDEzME5OUzlGemZt?=
 =?utf-8?B?ZVdSWlN3bnJvdFA5NWJHOG5DQWJueFFUOVRQdm9rUUMwNjkrZk5Ia3BCekV6?=
 =?utf-8?B?ZE5XNnF5SFdib3BLNk0yVDZKTjdZNDJGTmMzeC9vbERqaW9Rc1lMcU5UMmVx?=
 =?utf-8?B?THFHZHZaUzZWS2JkQ1RuMUtQbnYzQ0NLMWVSajlpSTU0Q0E2MW1NWHJXdmxC?=
 =?utf-8?B?bTY4Mk5Bayt5c0N1M3BVckdMOVdoVDZ6V1NGcHhFNUM4V0pDMW96NkpCRXc0?=
 =?utf-8?B?ajJIN240a0hmQkJpY2JheXFsM0lvbG53MmZ5NFBueExUY0pacGJzWjRNS09l?=
 =?utf-8?B?WlRSRjBkMzVkTW41VER5eU5tLzZlUUxMZUpRNUdlRGFQZ3NRL3RJblNSSE1F?=
 =?utf-8?B?ZG1DQklxZjdFcndSbkdTRm9RTm1CaW8vTlZ3dUVBdmxadkJPZ1Z6bjlKbXpP?=
 =?utf-8?B?K2o2clZMMmEzT05NdUkwYVczMVQ0NTkxSUVYUi8rNVNienZOcEZWMlcxUHBw?=
 =?utf-8?B?alJMOE5pSzcyNHVOSlRjOURZMlppeStaN0VXL1dYK3lOaEhYM09xU2tHaGxQ?=
 =?utf-8?B?aUtpYjI2U2JsN09SU1FFTnlxUjNhMUcrVXdJMnE0cjJEamMxUlZCeE5ydGda?=
 =?utf-8?B?V05zdUVSaE9RRk8wRVlVOTU5TjZRQ0pWWW1DenFYZ0ZXcDdyRzFyZVlYVWhu?=
 =?utf-8?B?QmM0Qi8xYmUzdzRWTGpERGZ6akhrOHFURklCeVJsYThOeGx1Zm5uemljZ284?=
 =?utf-8?B?NVQzMHZlZVJhUHk1TFduYnNFQ1N5T3o4V05nRWF2VnNoTGQvMk1BNHV1RzRt?=
 =?utf-8?B?Y1pBRExOeDlBQVgxN1ErV1JSbnpaYmxuSis2SjNuOWFOSm93WDRFaU54cWoz?=
 =?utf-8?B?UERYSER3THJld0RhbVdaOWQxbDU3T2gyb0RaYkk3amEzZUVMUysraTRaeXNK?=
 =?utf-8?B?a1pVcUw3WWlhdlhkeEZkWWs0NlFTRkRGY3VETG52aWF4UnM3cmY0ZTQvWW1D?=
 =?utf-8?B?MnlxcXdhdjlNZFZsdnB0d3p6WFI4dzd4K0tEazdMTnJ2dGJFNHVTTnBHY2tt?=
 =?utf-8?B?U0E0aDVOUGZwL0NrVm9Rblp3YzdHeUlHbTJjV2FoU1FUeGV2MGJ1TW5id0p6?=
 =?utf-8?B?STRJN0ZvT2drK2R6Q3d4a01YUmdVL3l1eUNmVDJkeXdIUTMydWd6QXA3dXpo?=
 =?utf-8?B?aDhNblJTdWVMbVB6QjkxNTRNcUJTdGRZTzlwWEVURHM2MmNXQnVzOGVzU0sv?=
 =?utf-8?B?MnhXS3NiN2FEa2JFaUhLM05heUYrNGdMNG1QeWRxcXNHSTl5OTFYcjVWN3lW?=
 =?utf-8?B?WjdCaGNBRFJEVzE3emNRK3ZEaHFoeTRwaVZmLzd6RDk3ZVhvUXBuTE80YVda?=
 =?utf-8?B?aVZXWW9nREJsbmhBcTY3TmxmTzd2Rng2ejVWS0VlQzFLZlczanFRNTI3Uktw?=
 =?utf-8?B?M1phWHNFUGVPUnBPSGRhcG1LSWZQUWdQcUY5U1NqTHJnSFBFK2drdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9373cf-7e92-48af-2bab-08de4f1d871d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 01:22:17.0936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Q++B16aRe7p7HyeL6bCXG1UYk6byj19y+3E6PyLVNCjkbrJsynHt3qnAY+xUXAcWpLLaVB+7toXJCYg+dNe9HNLV0csvGLyaMBte8v8cjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7179
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDE0LzE5XSBody9hcm0vYXNwZWVkOiBhdHRhY2ggSTJD
IGRldmljZSB0byBBU1QxNzAwDQo+IG1vZGVsDQo+IA0KPiBIaSBLYW5lLA0KPiANCj4gPiBUaGFu
a3MgZm9yIHlvdXIgc3VnZ2VzdGlvbnMuIEkgaGF2ZSByZWZhY3RvcmVkIHRoZSBidXMgbmFtaW5n
IGxvZ2ljIHRvDQo+ID4gYWxpZ24gd2l0aCB5b3VyIGNvbW1lbnRzLiBUaGUgZGVjaXNpb24gbWFr
aW5nIGZvciB0aGUgYnVzIG5hbWUgaGFzDQo+ID4gYmVlbiBtb3ZlZCB1cCB0byB0aGUgU29DIGxl
dmVsLCBhbmQgdGhlIHJlZHVuZGFudCAiYXNwZWVkIiBwcmVmaXggaGFzIGJlZW4NCj4gcmVtb3Zl
ZC4NCj4gPg0KPiA+IEhlcmUgaXMgYSBzdW1tYXJ5IG9mIHRoZSBjaGFuZ2VzOg0KPiA+IDEuIEFk
ZGVkIGEgYnVzLWxhYmVsIHByb3BlcnR5IHRvIEFzcGVlZEFTVDE3MDBTb0NTdGF0ZS4gVGhpcyBh
bGxvd3MgdGhlDQo+IHRvcC1sZXZlbA0KPiA+ICAgIFNvQyAoZS5nLiwgQVNUMjcwMCkgdG8gZGVm
aW5lIHRoZSBsYWJlbCBkdXJpbmcgaXRzIGluaXRpYWxpemF0aW9uIG9yIHJlYWxpemUNCj4gcGhh
c2UuDQo+ID4gMi4gVGhlIGJ1cy1sYWJlbCBpcyBwYXNzZWQgZnJvbSBhc3BlZWRfYXN0MTcwMF9y
ZWFsaXplIHRvIHRoZSBJMkMgY29udHJvbGxlcg0KPiA+ICAgIChBc3BlZWRJMkNTdGF0ZSkuDQo+
ID4gMy4gSW4gYXNwZWVkX2kyY19yZWFsaXplLCB0aGUgY29udHJvbGxlciBnZW5lcmF0ZXMgdW5p
cXVlIG5hbWVzIHVzaW5nIHRoZQ0KPiBidXMtbGFiZWwuDQo+ID4gICAgVGhlc2UgbmFtZXMgYXJl
IHBhc3NlZCB0byB0aGUgQXNwZWVkSTJDQnVzIHRocm91Z2ggYSBuZXcgYnVzLW5hbWUNCj4gcHJv
cGVydHkNCj4gPiAgICBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZSBidXNlcy4NCj4g
Pg0KPiA+IFdpdGggdGhlc2UgY2hhbmdlcywgdGhlIG5ldyBvYmplY3QgaGllcmFyY2hpZXMgYW5k
IGJ1cyBuYW1lcyBhcmUgYXMNCj4gZm9sbG93czoNCj4gPiBCTUM6IC9pMmMvYnVzWzBdL2FzcGVl
ZC5pMmMuYnVzLjANCj4gPiBJT0VYUDAgKExUUEkwKTogL2lvZXhwWzBdL2lvZXhwLWkyY1swXS9i
dXNbMF0vaW9leHAwLjANCj4gPiBJT0VYUDEgKExUUEkxKTogL2lvZXhwWzFdL2lvZXhwLWkyY1sw
XS9idXNbMF0vaW9leHAxLjANCj4gDQo+IFRoZSBuYW1lcyBpbiB0aGUgb2JqZWN0IGhpZXJhcmNo
eSBzaG91bGQgbm90IGhhdmUgY2hhbmdlZCwgb25seSB0aGUgYnVzDQo+IG5hbWVzIGV4cG9zZWQg
dG8gdGhlIHVzZXIgYXJlIGltcGFjdGVkLg0KPiANCj4gPiBJIGhhdmUgYWxzbyB2ZXJpZmllZCB0
aGF0IHRoaXMgbmFtaW5nIGNvbnZlbnRpb24gZG9lcyBub3QgcmVxdWlyZQ0KPiA+IGNoYW5nZXMg
dG8gZXhpc3RpbmcgdGVzdCBzY3JpcHRzLCBhbmQgYWxsIGZ1bmN0aW9uYWwgdGVzdHMgcGFzc2Vk
IHN1Y2Nlc3NmdWxseS4NCj4gPg0KPiA+IElmIHlvdSBoYXZlIG5vIGZ1cnRoZXIgY29uY2VybnMg
cmVnYXJkaW5nIHRoaXMgYXBwcm9hY2gsIEkgd2lsbCBzdWJtaXQNCj4gPiB0aGUgdXBkYXRlZCBw
YXRjaCBzZXJpZXMuDQo+IA0KPiBQbGVhc2Ugc2VwYXJhdGUgdGhlIGJ1cy1sYWJlbCBjaGFuZ2Ug
ZnJvbSB0aGUgcmVzdC4gSSBhbSBleHBlY3RpbmcgYSBmdW5jdGlvbmFsDQo+IHRlc3QgY2FzZSB0
b28sIG1heWJlIHdlIHNob3VsZCB1cGRhdGUgdGhlIHNkayB2ZXJzaW9uIHRvIHYxMC4wMCBmaXJz
dCA/DQo+IA0KDQorIEhhbw0KDQpIaSBDw6lkcmljLCBOYWJpaCwgSGFvDQpBU1BFRUQgY2hhbmdl
ZCB0aGUgYm9vdCBpbWFnZSBmb3JtYXQgc3RhcnRpbmcgZnJvbSBTREsgdjEwLjAwLiBBcyBhIHJl
c3VsdCwgdmJvb3Ryb20gY2FuIG5vIGxvbmdlciBib290IGNvcnJlY3RseSwgYW5kIHRoZSBtYW51
YWwgbG9hZGVyIGNvbW1hbmQgYWxzbyBuZWVkcyB0byBiZSB1cGRhdGVkLg0KU3BlY2lmaWNhbGx5
LCB0aGUgVS1Cb290IEZJVCBpbWFnZSBoYXMgYmVlbiByZXBsYWNlZCB3aXRoIGEgbGVnYWN5IFUt
Qm9vdCByYXcgaW1hZ2UsIHNvIHRoZSBzZWNvbmRhcnkgc29sdXRpb27igJlzIG1hbnVhbCBsb2Fk
ZXIgY29tbWFuZCBtdXN0IGJlIGFkanVzdGVkIGFjY29yZGluZ2x5Lg0KDQpJIGhhdmUgY3JlYXRl
ZCBhIG5ldyBwdWxsIHJlcXVlc3QgdG8gZ29vZ2xlL3Zib290cm9tIGFuZCBhbSBjdXJyZW50bHkg
d2FpdGluZyBmb3IgcmV2aWV3Og0KaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS92Ym9vdHJvbS9w
dWxsLzEyDQoNCkkgcGxhbiB0byB1cGRhdGUgdGhlIGZ1bmN0aW9uYWwgdGVzdCBTREsgdjEwLjAw
IGFmdGVyIHRoaXMgUFIgaXMgbWVyZ2VkLg0KQWRkaXRpb25hbGx5LCBBU1BFRUQgd2lsbCByZWxl
YXNlIFNESyB2MTEuMDAgb24gSmFudWFyeSAyNiwgc28gSSBhbSBhbHNvIGNvbnNpZGVyaW5nIHVw
ZGF0aW5nIGRpcmVjdGx5IHRvIHYxMS4wMCBpbnN0ZWFkLg0KDQpOYWJpaCwgSGFvDQpDb3VsZCB5
b3UgcGxlYXNlIGhlbHAgcmV2aWV3IHRoaXMgUFIgd2hlbiB5b3UgaGF2ZSB0aW1lPw0KDQpUaGFu
a3MgaW4gYWR2YW5jZSBmb3IgeW91ciBoZWxwLg0KSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBD
Lg0KPiANCg0K

