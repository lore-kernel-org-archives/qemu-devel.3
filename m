Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADC7CAC5BD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3PGH-00031z-AG; Mon, 29 Sep 2025 21:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PGG-00030Q-Dx; Mon, 29 Sep 2025 21:34:36 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PGA-0002fL-6B; Mon, 29 Sep 2025 21:34:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR7WSvuApb5jTV0jLuyktbKXGcHrosDjyliYNUSHQylqJAdziCjY5Lp3Pw50QxSEnUgzZ71eBgI1H3Do5tcgHZLa/GVw1tIPNo02yZWxU5eW+ieUrqcNhx2PH1DzK6JscDUYp2YjhdLUsDIzdIg3dr7R4qZbZZAHtWa1w/0FAs/x15cjnhPKSg9xkbCUVm6FqjYlD0OPHB1j35Geu7R5S+PyWTR8K0C+EShSqvrUNKyPl5jED4IBAe4ZOZoO+yAo1E4YVrs8F1mHvYbxE4lQir+G68YThihv5emnPjs+9Ih+x/A/eEZm2zL6xD8SmaAD90tq9WZclPhvJjADfSCdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftJErMsIbBYJV8w6xN6hqEDPeHPYl0/dZ9GR6m3SyFw=;
 b=snXY2hG8bPFmqFqUWcI3oWP3EqXmU2e2lTVOjlIOjjMo4gyZ4G693iiUg2v5QM6+jXhy/0TfJYM7QObJzc2h6msS0PRAOxQiW2kWCMpD6sYP2Znvv3WeM5bhTyify1gnVO9Yl59X/7M6XNYUNCZgfLucToQakHMLuBTqcXld0ipSfLigSwZQwJLyr6ZzO6p/lr20Q1nwAi2mfqOqekcaCo5ZfIYSuDnSIPcyzH2IlQ6PQGnijaAWu6QIBblq50iU2EWf9mIhr/rtpzQWmO07WRMPN3aNLb1EeG6OsU0L6rQsm8NbjPVKAKqrASejsHQtG6vPUKnb2JE46elcgpPUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftJErMsIbBYJV8w6xN6hqEDPeHPYl0/dZ9GR6m3SyFw=;
 b=rXFuTMCo4XRE9Y3k44ARzMZ+F3jVJ/UxL98e87TXnmOTi6c3T+moL99yaNGcSS46gdQAgJPIY2yVEyo4+jOid8yk9mDQZ0dJFRKc6xbwLIOJA5D0VoLzAuAchZmIDK3EobDdNsa3nOabiJ3qoq9S6EfqV0NqsCjAveCa7xg8KRMtuyUzv9NAigw7K1U1OClUS41XGbMswb+jf9D8DeY54CRLrxRAA48wXLQ/yuUF9MYY4ded+c1ylo+Zxuy1rl9Akt+mh6rdw7fdYxYV9dI0YImUTbSkF3DhZK1IvsgWDAr4j5xIdUzyt7h9pexJVjXJOQi6OFxYVO+FZ6qcBL7knQ==
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com (2603:1096:405:319::8)
 by TYQPR03MB9459.apcprd03.prod.outlook.com (2603:1096:405:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:34:16 +0000
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956]) by TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 01:34:16 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Peter Maydell <peter.maydell@linaro.org>, Titus Rwantare
 <titusr@google.com>
CC: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Hao Wu
 <wuhaotsh@google.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, "CHLI30@nuvoton.com"
 <CHLI30@nuvoton.com>, "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>
Subject: RE: [PATCH 2/7] hw/pci-host: add basic Nuvoton PCIe window support
Thread-Topic: [PATCH 2/7] hw/pci-host: add basic Nuvoton PCIe window support
Thread-Index: AQHcIdaz/HqpKI3U502iJVMB6p6ADrSkZLsDgADhnwCABcqBUA==
Date: Tue, 30 Sep 2025 01:34:16 +0000
Message-ID: <TYPPR03MB9497B3882A87D309F0C5309ADB1AA@TYPPR03MB9497.apcprd03.prod.outlook.com>
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-2-d85883b2688d@google.com>
 <CAFEAcA8QAj54xxTfk087=8dERGiM28Bz2mw9eVtMd6qNOd7aYw@mail.gmail.com>
 <CAMvPwGo-PpapVgYG9RRdtzEOzFzgn1++f-uTHyyDHzfjyNTPfg@mail.gmail.com>
 <CAFEAcA_-3GeW5Y0WNXXqDJn394vyp9FfHPLZSx6J3VRZBW_kjQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_-3GeW5Y0WNXXqDJn394vyp9FfHPLZSx6J3VRZBW_kjQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9497:EE_|TYQPR03MB9459:EE_
x-ms-office365-filtering-correlation-id: 9cf2dc2e-e5ab-4aad-2af1-08ddffc17840
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VUxDN2diR2Uxc1B1R29MV0ZsMTFtSTJkS0R5MGdSTnFRby9yTUgzLzhsbDNC?=
 =?utf-8?B?L0JVRXBTK1gzdzBKU3N1YmxJbFRzbmdKRVBLelVLd2JNT2JYNUxNK2VnQzB2?=
 =?utf-8?B?NGpGY3laZFBneXM0RzNSaHBqUy9FaUZKYTBHTVZISXpMTzM5eXd2RkZjVHVn?=
 =?utf-8?B?bXZ3dkJjRTY0VVNYc25taklsVWZScjNRKzZMdXVlWkFQTFpOVGJyVVJqUjQv?=
 =?utf-8?B?OVhJaG1GOXAzYlo5N2xKaUVLM2NXdWp3cW5JenYwT1RvV1VXUFdpOEVCbTFS?=
 =?utf-8?B?SFo3TndrT0dzZGhxWmFDQndVS0hKTGMwYkl4OW9CQWU4cmZKQm11QWxQdWZw?=
 =?utf-8?B?YXZDWk1kUTJQcHRRNDllQTl6azhGS1RtUDRsMWFXUVhIcmFEL1pBeUowcHBy?=
 =?utf-8?B?OFVLd0RoYXJrUzVVbmE3b0VSQWNlamY2ZjRpMFRGT0diQ3d3RmI4czBsZVZI?=
 =?utf-8?B?eGhsamVYR2JpQlRTaEp1djhuKzhRSTd2N3BsTWpqK3RVV0tjTDRQTVN1UmIw?=
 =?utf-8?B?cGwxZWhUSHk1M3NpdGVycjJFY1pacWN6azlMLys4OUdGZUJxbk50eGI4Z0p0?=
 =?utf-8?B?ZnlXVWZISFhJTDlZMDErajFjeC9OSEJGOGpFWlVwbndnM1dSbWZNQXdud3Rs?=
 =?utf-8?B?OFhlUENTWlRVY3kveGJ0ZStIekJrbld4K2dxYWtxaTlFTTVDYTVlTXR3ZENH?=
 =?utf-8?B?OEM1L3VFcExWelN6eXpEMzJtMk5hL1dxeHVWbjZjZ3N0Qmg0Z3B0RDJzaFVO?=
 =?utf-8?B?SUVrbXZ3QzRSQldDQlJWeUpEaUZKUFd3aldYUnNRcFNCVmZCY1ptaHJRMEhO?=
 =?utf-8?B?Q08wOWUxaWtHM3l2Znp4VzBLcCt5YWI2MjV0SVlSeHA1YkFsQ1ZEaEkxT1BJ?=
 =?utf-8?B?UDZvTmVKcGQ2SGo1Tnp0d3hSK1UzTWxXczhRWmczTU9SYUpSNFgxMkNoa29Y?=
 =?utf-8?B?UkZYekFTeFY5ZTFBcDJ1WDMrRmNDWVA4UVp5S1lqajlYU3IrRFNCeDZZUTBi?=
 =?utf-8?B?aS9HSEZia1B5TXB5TVZmdm1vekxPdlArQXVMUzR2UUtzaCt5aEEvNjFBSExk?=
 =?utf-8?B?NWNSQkJOWUhLMFJUZlJSQmJhRFhsUDJXbDhqbFZyY2MrRzJtalNZV3d0OE04?=
 =?utf-8?B?K1lCWmxHb1FPekpNZW1GS3ZmemlCUXNTcEpaWW4zL05lcEV0OTl4YU9BdTNj?=
 =?utf-8?B?OGR2ak9jMHRrblJxSUJSOEhUT1RXdXE0R3ozY3g3cldiblJLSWV5NUtHSXBa?=
 =?utf-8?B?MXJvamFvWnhEMEM2R3pSdVpUYjlRb3VDallmUTY5aTVTckFoRG1SciswV2RG?=
 =?utf-8?B?N2xjeUtDMHpRMno5MWZRZU1UWm9haitQVVA2QUE0bkRqV3hZZFN6cms1am92?=
 =?utf-8?B?RGtGOGtTSW5zZThhaGFXUGxKcWxuOU9TREJMRUdWZjZ1S2pKb1FSa09OaUhZ?=
 =?utf-8?B?OEFLV0ZQUUQvS1FNVVpabnhDSVFiN1RMU1VZUUV6UkwyRGZVdVZ5SkN3WG1k?=
 =?utf-8?B?SGhWOEJYcmdSWFdTY2pScVZXWS9kK2dpYXYySmp6eTMvYmRkazQ2MGkrSmpR?=
 =?utf-8?B?QUxMb0NXbXZ6Y3hFVTFlVmRVbWpCcjFUd1VuKzNMK25WYXQ2Z2EwNG5iaWZO?=
 =?utf-8?B?cVdjNlY5NDFZSFA2dHNvNnV3VXJjdDQ3dytzakpESjhDcU9UZHl0cVAxM2lG?=
 =?utf-8?B?V2Q1MWtnSXJka2VyRitDUisvbmNna3c4SXJhcWpDNmlNMTJqMHg0bVFSZXlp?=
 =?utf-8?B?MTdTL2xUUXFqSE5jZVY0bUFmWjBIcFN5S1NUYUdCZC9rUFRPSDA3cTFhM1BP?=
 =?utf-8?B?TE1DU1BTZ3d6L3BoUFJEZ1dMYkMzZElTSkU3blV0WWpWRGxpS2c0cm9DbE9y?=
 =?utf-8?B?L0hmUkJKb01xaEZQZ1Qwb1ZNVENHdjA1cmxVcC9yTUpKeFo0c2ZtT0RhQmps?=
 =?utf-8?B?SWlnQVBjYVE1RDFVM3NsakVKT3Y1OHljTzlPZ2NyNTgzNHptQWhYeGkvUUFU?=
 =?utf-8?B?bzgzam9jbjkwMmJjVHJ6dUp3eGZTWDlXQkpIWmt1bDJ3dkhJQ1RYbmtMZEVN?=
 =?utf-8?Q?fohPCy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR03MB9497.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z25pRGFLd2IwWGRINld1cjlzTUZmaHp0L0Z0T2xPd2EyWFAwUlZWcnkwWnpJ?=
 =?utf-8?B?M0dhUVNlZ1VIczBtbldTWDZEMktOdDF3NExQcGhqS3M5NnovUVFROGlsbVdG?=
 =?utf-8?B?U3BRRm1OSUc3MGRjOWo5TC9DS3FpZXowTy9kUE9xWWdPei96NmtoeHo3aFZx?=
 =?utf-8?B?eTQzZUdZRmxxZTU2UzhRMERDUGV0Q2hTaFBOUmRPZDEwMG9JY1VvU3IrdTFw?=
 =?utf-8?B?WXFSVGZYVkJPcU1RRTdCTzRudjdmSE13SndKdllzUnRWUlNBK0tWY2RaQTN1?=
 =?utf-8?B?dVVybE9TeTFyeG5KVmFIU1dJaC9tRnVCZzFvNTVaNDdnWTMvZ3J2V1VHMkR2?=
 =?utf-8?B?enorM3JTWUNnTmk0K3NLYnFndVFaWTNtSi92SGp4WmdKbGNraEJORktnZndU?=
 =?utf-8?B?L1VpWi9wZ3Nnd0t5VDh1MU42UDZSSEJpdFVsbzJ3a05jNFJKWndaYlphbDBv?=
 =?utf-8?B?cHlWcGdqK3dxakc1cXNPUnJLN2JXeThWaml3K01TQmFzaEJNaEhNL0JtaUxO?=
 =?utf-8?B?c0w0NWpwVnBJQjdCVjRPUDdaa3Bnb0h5MjlCbnF3aVl4Y1FieG5TTGpRL0ll?=
 =?utf-8?B?ampQVDNEMldqTy82WWpwNEVJbHBwclZlZjlPcVNkR3F5dXU3VkZxYnVNVXJ3?=
 =?utf-8?B?ZzRPWGJ3dVVhVllCOW43N2VBWnh2SDlkbWJFMDJMVFp0KzJhZ2RZSElMT0hy?=
 =?utf-8?B?bjN3RVRDZjBNU0JQOXdiWk9mbGJLcFNaK1dnQzhLSk9KbEpFRjAveHg0SDNi?=
 =?utf-8?B?ZWM2WnRuaFF5NnhJbFVFSHA2WnVpcDdycmdrR1JHdTQwaitweUxoek5Ya1JF?=
 =?utf-8?B?eFNFQUhpajNKdGhIQVFrVURkMkMzWXpUZVNRMmVkckxnSUdVQkdDSGxCQVI3?=
 =?utf-8?B?dUtIRVV1MzFyeENPTEYvUXFiKzhFZ0ZEUXo4ZWxJeXJHWGU1dmZjZmFNKzVK?=
 =?utf-8?B?ZkpDOFdJSjIyQ0N5SVB1eUhJYkViamFpUnZIQ1NNcitsbXpCTzg0REZWN2xw?=
 =?utf-8?B?enJUMGY1MTVZeGRHa3Z3dEFIZmRqYnkyL2JhN3JBdTcvSWtLK2VFWVk0cnVW?=
 =?utf-8?B?azc0NTJnRVVXUU1kOUV3ZEdvT1p5WWRuSFNlZzEzaHRjbS9uM1J4MnRlbWxp?=
 =?utf-8?B?cGY4NG9TelVxUklmTXJWZ3g0NHgzWHB6TmpYaFIzVUF0SXUzbmhWUCtIM3ZC?=
 =?utf-8?B?RUlpOENjaGtsejZRRk5QSUZXd3RoWmg5RElUOFlFK05hSCtMNHlqa1JKelZo?=
 =?utf-8?B?QjFUMDNEdnZiQ2g5UDl5bDJRM2lMRHBxd3Bic2FxS3JnTFJuYmlCc25HRXhP?=
 =?utf-8?B?NzZzRGJxU3hkZnM0RjBaSHV5SFhnTEhlMHQ4ZVFIWUl6YnZ4akdEczlNSTF0?=
 =?utf-8?B?czFxUU5wZzRRV0FMalEzcU9pZXJGTGRHMEl4b082VDRRU3BabnhKZWJJNm5p?=
 =?utf-8?B?N1c0akpkeHc5Y0VpbDVET29ZWjJvZnN5QU82eTRrSUNKRHJEM2xya2lLSFNv?=
 =?utf-8?B?L014aFdpSjE3cGxna251SjlGS3BXbEUyaWpmVEt2RWdxQWxkamxIejhvU0xt?=
 =?utf-8?B?RDdmRUUzSkd4WUovejNxdmNUZ3F5Z01uam1FR0xPLzNLZVBVZFRxOGpsTzNJ?=
 =?utf-8?B?Q3ppbzBMYU9JS3BydG9FZCs5cFlVcnlHWVV0ZnMxdkJlMHZHdVNWQjNYTHJY?=
 =?utf-8?B?RkZyQU5mVjYwN3V0cEhDUVlLZXhhN2pBLytMSlpuRkhaSGpFRkN1OC9CKzZU?=
 =?utf-8?B?TElNL1IvYTc5SEFZQ2xmVDhmSlhkLytsbkVuRDNubGZ2cnhpbXczaDMxTE5y?=
 =?utf-8?B?R1Vsc2dlc1pPQ1R0SzhIVmM5Tzk5WGdtRmNuc3pZekFLTlZqdERoZHpZdG1v?=
 =?utf-8?B?UVo5czJvNEx3VnNneXFpUGttcTBjd25rOVFxL3prM3hPcVpXNzZrM0oxU05Z?=
 =?utf-8?B?QzBRc0NsVVhkWkx1T0pLV0l5bTJDTWdjaWZMUnQrd1NYNmlsOENkNDIxdENu?=
 =?utf-8?B?c0xDZlhZbjZCdFN4NktqRlZQNGpzQVhnWllUdm54YUFVbGRDSWVGRDBaQzNF?=
 =?utf-8?B?NG1ydjZDb2VHY0lrZzVXM1FUS1FzQTJRcHRFRXBLMmJndEJOTy9rbEFzeXFq?=
 =?utf-8?Q?9sIEUW4dDrQIUzRqNPGNnm2Iy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9497.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf2dc2e-e5ab-4aad-2af1-08ddffc17840
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:34:16.7244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiRN6TUFMJQglSx+cu6KdBrI13ggGc77C4uy+b0/0qGHfku98UfiVPAdFUJNVSIMlQby+9WKxVWdAoQMoQQ/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9459
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=KFTING@nuvoton.com;
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

TG9vcCBpbiBtb3JlIE51dm90b24gZm9sa3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQpTZW50OiBG
cmlkYXksIFNlcHRlbWJlciAyNiwgMjAyNSA1OjA4IFBNDQpUbzogVGl0dXMgUndhbnRhcmUgPHRp
dHVzckBnb29nbGUuY29tPg0KQ2M6IFl1YmluIFpvdSA8eXViaW56QGdvb2dsZS5jb20+OyBxZW11
LWRldmVsQG5vbmdudS5vcmc7IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBD
UzIwIEtGVGluZyA8S0ZUSU5HQG51dm90b24uY29tPjsgSGFvIFd1IDx3dWhhb3RzaEBnb29nbGUu
Y29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzddIGh3L3Bj
aS1ob3N0OiBhZGQgYmFzaWMgTnV2b3RvbiBQQ0llIHdpbmRvdyBzdXBwb3J0DQoNCkNBVVRJT04g
LSBFeHRlcm5hbCBFbWFpbDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBhY2tub3dsZWRnZSB0aGUgc2VuZGVyIGFuZCBjb250ZW50Lg0KDQoNCk9uIFRo
dSwgMjUgU2VwdCAyMDI1IGF0IDIwOjQwLCBUaXR1cyBSd2FudGFyZSA8dGl0dXNyQGdvb2dsZS5j
b20+IHdyb3RlOg0KPg0KPiBPbiBUaHUsIDI1IFNlcHQgMjAyNSBhdCAwOTozOCwgUGV0ZXIgTWF5
ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwg
OSBTZXB0IDIwMjUgYXQgMjM6MTEsIFl1YmluIFpvdSA8eXViaW56QGdvb2dsZS5jb20+IHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IEZyb206IFRpdHVzIFJ3YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNvbT4N
Cj4gPiA+DQo+ID4gPiBBZGRzIHRoZSB3aW5kb3dpbmcgcmVnaXN0ZXJzIHdpdGhvdXQgYWRkcmVz
cyB0cmFuc2xhdGlvbg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRpdHVzIFJ3YW50YXJl
IDx0aXR1c3JAZ29vZ2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGh3L3BjaS1ob3N0L25wY21f
cGNpZXJjLmMgICAgICAgICB8IDIyMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPiA+ID4gIGluY2x1ZGUvaHcvcGNpLWhvc3QvbnBjbV9wY2llcmMuaCB8ICA3NyArKysr
KysrKysrKystDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOTcgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaHcvcGNpLWhvc3QvbnBjbV9w
Y2llcmMuYyBiL2h3L3BjaS1ob3N0L25wY21fcGNpZXJjLmMNCj4gPiA+IGluZGV4DQo+ID4gPiAz
YWZlOTJlMjY0ZjZjZTQzMTJlOTRmMDViNWU5MDg4NDAwMDhkZjY0Li5iZmZkZWM3MWFjYWJhNjU2
Mjg1NmIzYmQNCj4gPiA+IGQ4YWVjMDdjM2MxNTMzMjMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9ody9w
Y2ktaG9zdC9ucGNtX3BjaWVyYy5jDQo+ID4gPiArKysgYi9ody9wY2ktaG9zdC9ucGNtX3BjaWVy
Yy5jDQo+ID4gPiBAQCAtMTYsNiArMTYsMTkzIEBADQo+ID4gPiAgI2luY2x1ZGUgInFvbS9vYmpl
Y3QuaCINCj4gPiA+ICAjaW5jbHVkZSAidHJhY2UuaCINCj4gPiA+DQo+ID4gPiArLyogTWFwIGVu
YWJsZWQgd2luZG93cyB0byBhIG1lbW9yeSBzdWJyZWdpb24gKi8gc3RhdGljIHZvaWQNCj4gPiA+
ICtucGNtX3BjaWVyY19tYXBfZW5hYmxlZChOUENNUENJRVJDU3RhdGUgKnMsIE5QQ01QQ0lFV2lu
ZG93ICp3KSB7DQo+ID4gPiArICAgIE1lbW9yeVJlZ2lvbiAqc3lzdGVtID0gZ2V0X3N5c3RlbV9t
ZW1vcnkoKTsNCj4gPg0KPiA+ID4gKyAgICAvKiBUT0RPOiBzZXQgc3VicmVnaW9uIHRvIHRhcmdl
dCB0cmFuc2xhdGlvbiBhZGRyZXNzICovDQo+ID4gPiArICAgIC8qIGFkZCBzdWJyZWdpb24gc3Rh
cnRpbmcgYXQgdGhlIHdpbmRvdyBzb3VyY2UgYWRkcmVzcyAqLw0KPiA+ID4gKyAgICBpZiAoIW1l
bW9yeV9yZWdpb25faXNfbWFwcGVkKCZ3LT5tZW0pKSB7DQo+ID4gPiArICAgICAgICBtZW1vcnlf
cmVnaW9uX2luaXQoJnctPm1lbSwgT0JKRUNUKHMpLCBuYW1lLCBzaXplKTsNCj4gPiA+ICsgICAg
ICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXN0ZW0sIGJhciwgJnctPm1lbSk7DQo+
ID4gPiArICAgIH0NCj4gPg0KPiA+IFRoaXMgbG9va3Mgd2VpcmQuIEdlbmVyYWxseSBkZXZpY2Vz
IHNob3VsZCBub3QgbWFwIHRoZW1zZWx2ZXMgaW50bw0KPiA+IHRoZSBzeXN0ZW0gYWRkcmVzcyBz
cGFjZSwgYWx0aG91Z2ggc29tZSBvZiBvdXIgb2xkZXIgcGNpLWhvc3QNCj4gPiBkZXZpY2VzIGRv
IGZvciBoaXN0b3JpY2FsIHJlYXNvbnMuIFNob3VsZCB3ZSBiZSBtb2RlbGxpbmcgdGhpcyBzb21l
DQo+ID4gb3RoZXIgd2F5Pw0KDQo+IEkgY2FuIHVwZGF0ZSB0aGlzLiBXaGF0IGRldmljZXMgYXJl
IGRvaW5nIGl0IHRoZSBuZXcgd2F5Pw0KDQpJJ20gbm90IHN1cmUgZXhhY3RseSB3aGF0IHlvdXIg
ZGV2aWNlIGlzIGRvaW5nIGhlcmUgaW4gZ2VuZXJhbCwgYnV0IHR5cGljYWxseSB0aGUgZGV2aWNl
IGV4cG9zZXMgc3lzYnVzIE1ScyB0byB0aGUgU29DIGFuZCB0aGUgU29DIG1hcHMgdGhvc2Ugd2hl
cmUgdGhleSBvdWdodCB0byBnby4NCg0KSXMgdGhlcmUgZG9jdW1lbnRhdGlvbiBvbiB3aGF0IHRo
ZSBoYXJkd2FyZSBiZWhhdmlvdXIgaXM/DQoNCnRoYW5rcw0KLS0gUE1NDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiBU
aGUgcHJpdmlsZWdlZCBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMg
ZW1haWwgaXMgaW50ZW5kZWQgZm9yIHVzZSBvbmx5IGJ5IHRoZSBhZGRyZXNzZWVzIGFzIGluZGlj
YXRlZCBieSB0aGUgb3JpZ2luYWwgc2VuZGVyIG9mIHRoaXMgZW1haWwuIElmIHlvdSBhcmUgbm90
IHRoZSBhZGRyZXNzZWUgaW5kaWNhdGVkIGluIHRoaXMgZW1haWwgb3IgYXJlIG5vdCByZXNwb25z
aWJsZSBmb3IgZGVsaXZlcnkgb2YgdGhlIGVtYWlsIHRvIHN1Y2ggYSBwZXJzb24sIHBsZWFzZSBr
aW5kbHkgcmVwbHkgdG8gdGhlIHNlbmRlciBpbmRpY2F0aW5nIHRoaXMgZmFjdCBhbmQgZGVsZXRl
IGFsbCBjb3BpZXMgb2YgaXQgZnJvbSB5b3VyIGNvbXB1dGVyIGFuZCBuZXR3b3JrIHNlcnZlciBp
bW1lZGlhdGVseS4gWW91ciBjb29wZXJhdGlvbiBpcyBoaWdobHkgYXBwcmVjaWF0ZWQuIEl0IGlz
IGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIHVzZSBvZiBjb25maWRlbnRpYWwgaW5mb3Jt
YXRpb24gb2YgTnV2b3RvbiBpcyBzdHJpY3RseSBwcm9oaWJpdGVkOyBhbmQgYW55IGluZm9ybWF0
aW9uIGluIHRoaXMgZW1haWwgaXJyZWxldmFudCB0byB0aGUgb2ZmaWNpYWwgYnVzaW5lc3Mgb2Yg
TnV2b3RvbiBzaGFsbCBiZSBkZWVtZWQgYXMgbmVpdGhlciBnaXZlbiBub3IgZW5kb3JzZWQgYnkg
TnV2b3Rvbi4NCg==

