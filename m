Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D7C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 04:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj8dY-0002V0-Pp; Mon, 13 Jul 2026 00:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj8dI-0002Tl-B4; Mon, 13 Jul 2026 00:51:09 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj8dF-0000LP-PO; Mon, 13 Jul 2026 00:51:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLK2FIfWNMv7mQ80wQ0Hqlsc9MEGaSRhhwPU6DOEHeF2Vi59WxTmztsymbmI4O2VM4bucIOLODAaXX/FFBMyUAi8Hf1ODrWv9eWGqbfLojyjRgNo4ZklsElGRi5hg6BbQ2x/v3NcJIOSE8yy4Mur7SIA4Z+YUmisPS6Dzx7rz7dP98R8z+wbXQ6Zvv22DdCnI6qjHNiTGneF24LAwgeBM8+mKfUbMeCSAtwX8PbJ/g3wGbEbFc2O+1CPi/EQtGFXSmv3FtZKMwqZD6KO96GGGng6qTgWxZ9cCFJsyLnStxhdLRChOuKUW7007fb2Qek/I+IMj2eQJ2eW3pRRfrTdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpxdxTKWJW0RGcBs/V2E9+MA12M7Sg5lloThRbEgYFY=;
 b=tjrfV11m7ZUkLkupDKLk9VG/QsRJ0FKmQGlBgwYvpNv3x+hlNj9Oh/xDKyQd0LWhYXY70NU0pWr0f6c4gS/NRckOgQtcf5fpDKLPe47i6jWdOfSg/7AnfuGZgMGKk+PzNYlLZrpQ17IQRRtRj6x2wHEk/wvxsKpawLxu7ibq9DCbp+EW3PNIEJzezqpVeRNgmqxMrtHf0IeH/L0cqMIp9T07xmsHC7hQ9vuPX4E/9F2r8bYYkQc5/2qME5SgV5qsSYDryv3E/kyY3W9KCSJ7HNVaSydWgb2AVPc+FGGdo9UsgxLpEzdyNjKTsKURhV0vQrYIXgbTSGnauSbDWAfj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpxdxTKWJW0RGcBs/V2E9+MA12M7Sg5lloThRbEgYFY=;
 b=Xh9K6wLEQ6k24NzaEVssw39rmDzznpCaImPAhY3PLzgpThpk9egtGdwp3QxG41MFAWXnG/nVbitw+6wEPyrtpB1lAv6/qZvhZ1zqWkrBQA1XoUolxFIyU3cYE4wJQswwuNvUwZdgBCfJc12iYmHGymwhoR59BC+zAaB6xJlKSfQGhO4BRr3qBcAvRyP1CozmxcwWBhz6qYpPHI3wH7T7aqgcEmGVNQeRCfw5modz2FxVxj1f3Jn4/OzvRhxitoBIIFI5imPeex7PexjP7radPpFFmmUVpr1xaz6Zu+vs3Ap8XjFsp0TR7azwS4XKeEGD0wAav6WwPW3edK4vLycShw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by OSQPR06MB7183.apcprd06.prod.outlook.com (2603:1096:604:295::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Mon, 13 Jul
 2026 04:50:55 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 04:50:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "Murray-Pitts, Lucien" <lucien.murray-pitts@siemens.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Nabih Estefan <nabihestefan@google.com>, Joe Komlodi
 <komlodi@google.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap support
 for AST2700
Thread-Topic: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHdDrsB0PfBWMtPU0KIoukeQI21FLZkPUyAgAAhSYCAAAInQIAAAcfggAaF8qA=
Date: Mon, 13 Jul 2026 04:50:55 +0000
Message-ID: <TYZPR06MB498029A178D5EA97F51A08E5FCFA2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
 <3d2d869c-d1a0-40d1-83c2-755c080bd17d@oss.qualcomm.com>
 <TYZPR06MB4980E558390882926C5263ABFCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
 <TYZPR06MB4980C0620EBAB68031639EB2FCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
 <PUZPR06MB56188114958529179B1BB185AEFE2@PUZPR06MB5618.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB56188114958529179B1BB185AEFE2@PUZPR06MB5618.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d287feb2-f2df-4361-abf6-240bd501e101;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-07-09T01:12:19Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|OSQPR06MB7183:EE_
x-ms-office365-filtering-correlation-id: 121f8344-aac8-41d6-1f55-08dee09a52cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|921020|38070700021|18002099003|22082099003|6133799003|4143699003|56012099006;
x-microsoft-antispam-message-info: 4f6n3P5Z6RqlbkZqCHTgmQsRy5bL3nsmRa7p/NJQ7zz0NRQkMrOZSNxTvtOMd4af2XanRUekPmB/Nd8bEVlusXEFDikNmzDaddDxnxsifctFDFjFf7SIFM2dBJ2KFtgGCmNNm7yqoyD94TuM9cAsuEf/VdE6jFH1VoMZW/F2zGVi90nPbR7ses40OcKRaABXFzs1YTdkDvh3xgNlPtfkF2tq3QrZttEkpvMVbCS4lyPt+auIbkjwBVDjlodotV40uaivJKJqtZDSvKAdwDTCG1IngPWr0qk3kJNHz1lSB0u5JOrNKrQUYj+RRgoetP04tRB3guEsw0pM4Q6GDJcjVaPSZf7NgXACfH+NoZ2DOeUwknw7Z4hDFqmnarSCDMVUXbxpDU8c4K/01r9l6plyAJxmY2NwtAXaqkjG1ewesz5nN89DAggQZyjKMuGAeTLGd6EVXoZfpUhinQzORDxCdEiUryC8ABhK6555EvC7I1gIkWsXVILsnFhjrxYqFMOvrvDx91Q4b61bI/OZJGOPrTQd6Vr41VwqjyJ+yvwE7aGir0z76VMxbZE5gW+U8cafLFMwOLE5+sKqS7BVxU+yDRSEmNiRqRi1RPTCdULfrYnzMpI7QWUprXNtJFkY6Wl8fA8F9RR52IlmPRAWf3HSMLaAtWGmgejcDEPxc10UQlrHVvuovA5gdVBdfetotFHn1YxTWGxuw/LzwKAlIHCb6K+hKCAUbJ0kECBJAnXu3mAjaCjgW1Rr7cDI+UCjzVI1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(921020)(38070700021)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2NUVFJ4bHZzTXc1anJIdjhFVFd6cWgrZ1VoTjZDbDZsZ2ZqSWRtYk5JVEZG?=
 =?utf-8?B?VUhEalFYWW5TcXJGNlF4NlY5MEVTYmlRUzUvZDVndmtOclorS3pvRjZxZHZ5?=
 =?utf-8?B?YkdnSTRJSy80ZkZHcnc3SHB4cEtvSmo0Rk1vaFdRNWFoQ1ptY1V6djdNRzNE?=
 =?utf-8?B?a0NkUnJLNWJmT1JqVEI0Y2dOOFBBYUZTWGxVVEI0RzRUTVNsMmZLZEFYYlVs?=
 =?utf-8?B?c29XLyt6M1pZUDVtVUM2NXV1dGFnWXNVbENLQmdvbHB3UFpxeVNLQXdaNmhV?=
 =?utf-8?B?UDhUaXliV1ZZaW8xZERmV0JxeFFod1RXcGtjTXF4d01QT0FzYUZmMTdyUlRS?=
 =?utf-8?B?N1FRUjFuVDBLZmliZXAxcVU0M2ZiVERTUG0yTHBMZDFuZFFXc1g2cUJJaDFN?=
 =?utf-8?B?MktPYk5RaFZMYnZmQWpKYkVTQXBFSS82cFB1dzhwQlhhUUd1YWt5SzlGeUdm?=
 =?utf-8?B?bkZFNTdBNmM5dlNuMWlJWHFBdERvdEhQMUJ4b296UEVFZWR6c2h0cGM5R3Vm?=
 =?utf-8?B?UHBwb1VlRURrVjREczNqd1ZwLzVpWTlqMmpKYktlUkJvNElncy9YcG9oNFZ6?=
 =?utf-8?B?N0tmUGZiRGo1Uk8xTW1Sc2ZhcmVZVGNSdzBuZjliZ0RlVlFxS3RxQkhFaXhL?=
 =?utf-8?B?ZUxLVUxnc2M1NkpQaUdlbHRYQjBNRXZtaTFxc3czbGVGMmVBTHh5emUvSnZY?=
 =?utf-8?B?MmtQWFVtTEJCZm95TTdESXRyVFFhY3FieTdPOGNqUzhSMzNuWktHU0xoOUdm?=
 =?utf-8?B?K2VHWVNxNFl1NzdCNzdCdUhCTllpTnhyNmVTNkFLdHB1MFd3NDZJaDhHYWtV?=
 =?utf-8?B?azdaNnBhQ2g1cklDcW54RHFQSEI1YWNPT283UEVoVUgzVGo5Smx0cTdaSVlP?=
 =?utf-8?B?Tm0rVDBRWWtReUN3NEx4bjYvV0FjK2p0ZkRHZURMUDJlN0ZYR1NNSDdlZFdR?=
 =?utf-8?B?ZEVvL241bEdoU3d0WVpKd1FDZDNiTzNLcnE4bnZpMWp5dkpzeVh3U2U0SXhv?=
 =?utf-8?B?TFo0WFYvaWNkdXJ6U1R6VTR3R3NGcFBhSEdtbCt4ODJDdzVxVW9UTmYvcCtG?=
 =?utf-8?B?R1dJQnRvekF0eERNMlJtWjNmMFQ2MktkNXV6UVZMMEt2ZCtOUGNETGNxNWRk?=
 =?utf-8?B?c1BPNmpheVQ0WE5Kc3FvMnNjMEFKN3JrMUNac25USWdFUFdoQS80OFZyRW01?=
 =?utf-8?B?d3VJMDRHalRoNCs2RkZOZ0srWTZQNmg5OTliY3pnNzhBSXJ2YXJZaGZ4S1Fo?=
 =?utf-8?B?TWwyZnpuZmRzcXpxdzlxY09YZHdVdENHa25rZTdnc3E4anE4UUdlK1Vtczds?=
 =?utf-8?B?cDhON3UxUWlidGlmYVZSWVJEV0NPN1ZrcnY4NEZpVmNxU3huY1RldTk5WTJK?=
 =?utf-8?B?RC90NENjNDZrOFdUSjZnSnJWeDZhcXFjWWt2Y1BxSWR4NkVwNDhaYVVxS0lM?=
 =?utf-8?B?VDd5Z0d2YkRkL2hnNmFQYStTRUtYdXFKZ01nUWxDZXpNOC9heiszWHg3U0p2?=
 =?utf-8?B?RThCZ2haNzZKbERITVRYYnVIWVcvYUJObnZiZE5Ld0ZRN3gzUm00ZTAxTjJV?=
 =?utf-8?B?WUZDZWZVU0FaWFhXN1dRMTNHUkhKUUY5b2FWUW92eWhVNzMxVzQwandEQjhr?=
 =?utf-8?B?NTVqVE5SaUVTajlxcHFzcko4cWVHQmw3Zlc1UWhOWnlNd0tpMFVIVEk2ZjR5?=
 =?utf-8?B?dS9TNFo5dE0vdzV4R0NCTFhxRi9Kekx3UUxnNjkwVXNBczVhR3VBOWNxOTdj?=
 =?utf-8?B?MiswMmZ6QXVkbmI4RURsaDZqQy9OSGtNenp1dCs5NzZFN3ZodmNKRjNyaE1M?=
 =?utf-8?B?d29sV21rODlJcThybktLbTVzZmNBNk9LUGI5MExhaDNjdlhybW9GUTlqZG5o?=
 =?utf-8?B?ZkNVN053SFFJekUyVXp5ZU51T1hDWHFpUjJnMHVZcVhBMUMrMUZXNlcyQUdn?=
 =?utf-8?B?c1FiN2xIVWZsSm9XSVh3a2crbFhaRjJzRjdNeDEwQ3Jjai9iZTVpSjRMWkNX?=
 =?utf-8?B?d2t6UGRxRTBLVFd2dFdSaDZ2dHdPQ05DMks4NkRpam9CcmtxR1F5VTZnL29n?=
 =?utf-8?B?TEdmbnlKcWptRGRGSm42K3Awd1VHdlNxVGJwTmNVeHhqUlNRek8zZXZqYjBq?=
 =?utf-8?B?MjFFeklOSXBNdGtkS3VKZHNNWGJxZDh0SERUbDBDYTVuclZiTnI5NnJvUEtO?=
 =?utf-8?B?WWl3bFo0UkxTNEQ5b2I2dWs1akl3L1lzWm9mMVlqZFVpVTNsSHdGYVdYZjJC?=
 =?utf-8?B?ZHlEV1phQldyUzBYYXdIVSs1aFo1S01tbEhwYWJBVEJnQzhrZUhwbUVETFdG?=
 =?utf-8?B?TlZXT0xGS054NEo3UUNqdEZBbU9oNFpSbHJtWWU5cmVPYmpLODFadz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B4JYLTZKwxtkIxOhBXbgxpFYeYvfOL5zJiUNnW/X6eyC2KICBu3kIFMapCI891Pp4Fzc1eK/S+DTfZwEclvxhlKQ66B+gYEb7ijW1/BTJH/oetzdp1zzDNVrwojfMiQKa7L/Tk3RIe3PfBVPDugDrGdmj1ERI2ChcMP5Dcr4epmbZrBzYTlinyROgHFs0t2SeqsileSHKdUhMjS+0qLNebLCAo1owoNZMyOQ5WIJqCTSSNctSzfUlbRtNPEcyMQAz74fOfD1awVlIMIPeRG9lHPSnBjSZ6kXqJFPeGOjr8FAXv/k9jmWAbD9Dv/2/hGCUofpK/foPK3gFeVhAwLsJg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121f8344-aac8-41d6-1f55-08dee09a52cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 04:50:55.1844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxgLah9e3ZpvVVsSUX2CbPX2iPSs87GFqViWitJES/HD50UBcC1escEzWZMjXJq1ouePJzxHwd+oNisMI/4kSPXyznaa0iEmXoeKbhvpsuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7183
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

SGkgTHVjaWVuDQo+IA0KPiBIaSBKYW1pbiwNCj4gDQo+ID4gQXMgZmFyIGFzIEkga25vdywgeW91
IGhhdmUgaW1wbGVtZW50ZWQgc3VwcG9ydCBmb3IgdGhlIEkzQyBIQ0kgY29udHJvbGxlciBvbg0K
PiB0aGUgQVNUMjcwMCBwbGF0Zm9ybSwgYW5kIGl0IGFwcGVhcnMgdG8gd29yayB3ZWxsIGluIHlv
dXIgbG9jYWwgUUVNVQ0KPiBlbnZpcm9ubWVudC4NCj4gDQo+IFRoZSBtb2RlbCB3ZSB3cm90ZSB3
YXMgYWdhaW5zdCB0aGUgTGludXgga2VybmVsIGRyaXZlcnMgc3BlY2lmaWMgdG8gdGhlDQo+IEFT
VDI3MDAga2VybmVsIGRyaXZlcnMgd2Ugc2VlIGFuZCBhcmUgbm90IGdlbmVyaWMgSENJIHZlcnNp
b25zLg0KPiANCj4gV2UgaGF2ZSBkaXNjdXNzZWQgaXQgYnV0IHdlcmVu4oCZdCBtYWtpbmcgYSBo
dWdlIHJ1c2ggYmVjYXVzZSBvZiBpbnRlcm5hbA0KPiBwcm9jZXNzIG9mIHVwc3RyZWFtaW5nIGZy
b20gdGFraW5nIHRpbWUuDQo+IElmIHRoYXTigJlzIHVzZWZ1bCBhbmQgIGlmIHRoZXNlIGFyZSBh
aGVhZCBvZiBvdGhlcnMgaW4gdGhpcyB0aHJlYWQgSSBjYW4gZXhwZWRpdGUNCj4gdGhlIHdvcmsg
b2YgdXBzdHJlYW1pbmcgLSBwbGVhc2UgbGUgbWUga25vdyB5b3VyIHByaW9yaXRpZXMgZm9yIHRo
YXQuDQo+IA0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQpJJ20gY3VycmVudGx5IGludmVz
dGlnYXRpbmcgd2hldGhlciBjdXN0b21lcnMgd2hvIGhhdmUgYWxyZWFkeSBpbXBsZW1lbnRlZCBh
biBJM0MgSENJIG1vZGVsIHdvdWxkIGJlIHdpbGxpbmcgdG8gdXBzdHJlYW0gdGhlaXIgd29yay4g
DQpXZSBoYXZlIGFsc28gcmVjZWl2ZWQgaW5xdWlyaWVzIGZyb20gb3RoZXIgY3VzdG9tZXJzIGFz
a2luZyBhYm91dCBJM0MgSENJIHN1cHBvcnQuDQoNCklmIG5vIGV4aXN0aW5nIGltcGxlbWVudGF0
aW9uIGlzIGV4cGVjdGVkIHRvIGJlIHVwc3RyZWFtZWQsIEkgbWF5IGNvbnNpZGVyIHdvcmtpbmcg
b24gdGhpcyB0YXNrIGFuZCBjb250cmlidXRpbmcgaXQgdXBzdHJlYW0gbXlzZWxmLg0KVGhpcyBp
cyBub3QgYSB0b3AgcHJpb3JpdHkgb3IgYW4gdXJnZW50IHRhc2sgYXQgdGhlIG1vbWVudC4gDQpJ
J20gc2ltcGx5IHRyeWluZyB0byB1bmRlcnN0YW5kIHdoZXRoZXIgdGhlcmUgYXJlIGFueSBwbGFu
cyB0byB1cHN0cmVhbSBhbiBleGlzdGluZyBpbXBsZW1lbnRhdGlvbiBzbyB0aGF0IHdlIGNhbiBk
ZWNpZGUgd2hldGhlciBBU1BFRUQgc2hvdWxkIGludmVzdCBlZmZvcnQgaW4gZGV2ZWxvcGluZyB0
aGlzIG1vZGVsLg0KDQpJZiB5b3VyIHRlYW0gaXMgcGxhbm5pbmcgdG8gdXBzdHJlYW0geW91ciBp
bXBsZW1lbnRhdGlvbiwgSSB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgaXQuDQoNClRoYW5rcywN
CkphbWluDQoNCj4gQ2hlZXJzLA0KPiBMdWMNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgSnVseSA5LCAyMDI2IDEwOjExIEFNDQo+IFRvOiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA8
Y2xnQGthb2Qub3JnPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
U3RldmVuIExlZQ0KPiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0
cm95QGdtYWlsLmNvbT47IEthbmUgQ2hlbg0KPiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsg
QW5kcmV3IEplZmZlcnkNCj4gPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3Rh
bmxleSA8am9lbEBqbXMuaWQuYXU+OyBQaWVycmljaw0KPiBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPHFlbXUtYXJt
QG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZl
bEBub25nbnUub3JnPjsgTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+OyBK
b2UNCj4gS29tbG9kaSA8a29tbG9kaUBnb29nbGUuY29tPjsgTXVycmF5LVBpdHRzLCBMdWNpZW4g
KERJIFNXIEVEQSBIQVYgU0xTUEUpDQo+IDxsdWNpZW4ubXVycmF5LXBpdHRzQHNpZW1lbnMuY29t
Pg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBS
RTogW1BBVENIIHY1IDAwLzEwXSBBZGQgU1NQL1RTUCBwb3dlciBjb250cm9sIGFuZCBEUkFNIHJl
bWFwDQo+IHN1cHBvcnQgZm9yIEFTVDI3MDANCj4gDQo+ICsgSm9lKEdvb2dsZSksIE5hYmloKEdv
b2dsZSksIEx1Y2llbihzaWVtZW5zKQ0KPiANCj4gKg0KPiA+IEhpIFBoaWxpcHBlDQo+ID4NCj4g
PiA+IE9uIDgvNy8yNiAxMToyMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+ID4gPiBUaGlzIHNlcmll
cyBpbXByb3ZlcyBBU1QyNzAwIHBsYXRmb3JtIHN1cHBvcnQgYnkgYWxpZ25pbmcgU1NQL1RTUA0K
PiA+ID4gPiBwb3dlciBhbmQgcmVzZXQgYmVoYXZpb3Igd2l0aCBoYXJkd2FyZSwgYW5kIGVuYWJs
aW5nIERSQU0NCj4gPiA+ID4gcmVtYXBwaW5nIHJlcXVpcmVkIGZvciBwcm9wZXIgZmlybXdhcmUg
Ym9vdCBmbG93Lg0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IEphbWluIExpbiAoMTApOg0KPiA+ID4g
PiAgICBody9hcm0vYXN0Mjd4MDogU3RhcnQgU1NQIGluIHBvd2VyZWQtb2ZmIHN0YXRlIHRvIG1h
dGNoIGhhcmR3YXJlDQo+ID4gPiA+ICAgICAgYmVoYXZpb3INCj4gPiA+ID4gICAgaHcvYXJtL2Fz
dDI3eDA6IFN0YXJ0IFRTUCBpbiBwb3dlcmVkLW9mZiBzdGF0ZSB0byBtYXRjaCBoYXJkd2FyZQ0K
PiA+ID4gPiAgICAgIGJlaGF2aW9yDQo+ID4gPiA+ICAgIGh3L2FybS9hc3QyN3gwOiBBZGQgRFJB
TSBhbGlhcyBmb3IgU1NQIFNEUkFNIHJlbWFwDQo+ID4gPiA+ICAgIGh3L2FybS9hc3QyN3gwOiBB
ZGQgRFJBTSBhbGlhcyBmb3IgVFNQIFNEUkFNIHJlbWFwDQo+ID4gPiA+ICAgIGh3L21pc2MvYXNw
ZWVkX3NjdTogSW1wbGVtZW50IFNTUCByZXNldCBhbmQgcG93ZXItb24gY29udHJvbA0KPiA+ID4g
PiB2aWENCj4gPiBTQ1UNCj4gPiA+ID4gICAgICByZWdpc3RlcnMNCj4gPiA+ID4gICAgaHcvbWlz
Yy9hc3BlZWRfc2N1OiBJbXBsZW1lbnQgVFNQIHJlc2V0IGFuZCBwb3dlci1vbiBjb250cm9sDQo+
ID4gPiA+IHZpYQ0KPiA+ID4gU0NVDQo+ID4gPiA+ICAgICAgcmVnaXN0ZXJzDQo+ID4gPiA+ICAg
IGh3L21pc2MvYXNwZWVkX3NjdTogQWRkIFNDVSBzdXBwb3J0IGZvciBTU1AgU0RSQU0gcmVtYXAN
Cj4gPiA+ID4gICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBBZGQgU0NVIHN1cHBvcnQgZm9yIFRTUCBT
RFJBTSByZW1hcA0KPiA+ID4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3Bl
ZWRfYXN0MjcwMGZjOiBCb290IFNTUC9UU1AgdmlhDQo+IFBTUA0KPiA+ID4gPiAgICAgIGFuZCBs
b2FkIGJpbmFyaWVzIGZyb20gRFJBTQ0KPiA+ID4gPiAgICBkb2NzOiBBZGQgc3VwcG9ydCB2Ym9v
dHJvbSBhbmQgdXBkYXRlIE1hbnVhbCBib290IGZvciBhc3QyNzAwZmMNCj4gPiA+DQo+ID4gPiBT
ZXJpZXM6DQo+ID4gPiBUZXN0ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4NCj4gPiA+DQo+ID4gPiAyIG5vdGVzOg0KPiA+ID4NCj4gPiA+IDEv
IEkzQyBlcnJvcnMgaW4gZG1lc2c6DQo+ID4gPg0KPiA+ID4gWyAgICA4LjE1MTIzMF0gIDE0YzIw
MDAwLmkzYzA6IE1JUEkgSTNDIEhDSSB2MC4wIHIwMA0KPiA+ID4gWyAgICA4LjE1MTQ5OF0gIDE0
YzIwMDAwLmkzYzA6IHVuc3VwcG9ydGVkIEhDSSB2ZXJzaW9uDQo+ID4gPiBbICAgIDguMTUxNzYx
XSBtaXBpLWkzYy1oY2kgMTRjMjAwMDAuaTNjMDogcHJvYmUgd2l0aCBkcml2ZXINCj4gPiA+IG1p
cGktaTNjLWhjaSBmYWlsZWQgd2l0aCBlcnJvciAtOTMNCj4gPiA+IFsgICAgOC4xNTIyNTBdICAx
NGMyMTAwMC5pM2MxOiBNSVBJIEkzQyBIQ0kgdjAuMCByMDANCj4gPiA+IFsgICAgOC4xNTI1MThd
ICAxNGMyMTAwMC5pM2MxOiB1bnN1cHBvcnRlZCBIQ0kgdmVyc2lvbg0KPiA+ID4gWyAgICA4LjE1
Mjc3OV0gbWlwaS1pM2MtaGNpIDE0YzIxMDAwLmkzYzE6IHByb2JlIHdpdGggZHJpdmVyDQo+ID4g
PiBtaXBpLWkzYy1oY2kgZmFpbGVkIHdpdGggZXJyb3IgLTkzDQo+ID4gPiBbICAgIDguMTUzMzIy
XSAgMTRjMjIwMDAuaTNjMjogTUlQSSBJM0MgSENJIHYwLjAgcjAwDQo+ID4gPiBbICAgIDguMTUz
NTg4XSAgMTRjMjIwMDAuaTNjMjogdW5zdXBwb3J0ZWQgSENJIHZlcnNpb24NCj4gPiA+IFsgICAg
OC4xNTM4NTNdIG1pcGktaTNjLWhjaSAxNGMyMjAwMC5pM2MyOiBwcm9iZSB3aXRoIGRyaXZlcg0K
PiA+ID4gbWlwaS1pM2MtaGNpIGZhaWxlZCB3aXRoIGVycm9yIC05Mw0KPiA+ID4gLi4uDQo+ID4N
Cj4gPiBUaGUgQVNUMjcwMCBJM0MgY29udHJvbGxlciBpbXBsZW1lbnRzIHRoZSBNSVBJIEkzQyBI
Q0kgc3BlY2lmaWNhdGlvbiwNCj4gPiB3aGljaCBpcyBub3QgeWV0IHN1cHBvcnRlZCBieSBRRU1V
Lg0KPiA+IEN1cnJlbnRseSwgUUVNVSBvbmx5IHByb3ZpZGVzIGFuIEkzQyBtb2RlbCBmb3IgdGhl
IERlc2lnbldhcmUNCj4gPiBjb250cm9sbGVyIHVzZWQgb24gdGhlIEFTVDI2MDAuDQo+ID4NCj4g
TmFiaWgsIEpvZSwgTHVjaWVuLA0KPiANCj4gQXMgZmFyIGFzIEkga25vdywgeW91IGhhdmUgaW1w
bGVtZW50ZWQgc3VwcG9ydCBmb3IgdGhlIEkzQyBIQ0kgY29udHJvbGxlciBvbg0KPiB0aGUgQVNU
MjcwMCBwbGF0Zm9ybSwgYW5kIGl0IGFwcGVhcnMgdG8gd29yayB3ZWxsIGluIHlvdXIgbG9jYWwg
UUVNVQ0KPiBlbnZpcm9ubWVudC4NCj4gRG8geW91IGhhdmUgYW55IHBsYW5zIHRvIHVwc3RyZWFt
IHRoaXMgd29yaz8NCj4gSWYgeW91IGFyZSBwbGFubmluZyB0byB1cHN0cmVhbSB0aGUgSTNDIEhD
SSBzdXBwb3J0LCBpdCB3b3VsZCBiZSBncmVhdGx5DQo+IGFwcHJlY2lhdGVkLg0KPiANCj4gVGhh
bmtzLA0KPiBKYW1pbg0KPiA+ID4NCj4gPiA+IDIvIHNodXRkb3duIG5vdCB3b3JraW5nDQo+ID4g
Pg0KPiA+ID4gWyAgMjQ2LjQwNTI5N10gc3lzdGVtZC1zaHV0ZG93blsxXTogRW50ZXJpbmcgZXhp
dHJkLi4uDQo+ID4gPiBzaHV0ZG93bjogcG93ZXJvZmYgLS10aW1lb3V0PTkwMDAwMDAwdXMgLS1s
b2ctbGV2ZWwgaW5mbw0KPiA+ID4gLS1sb2ctdGFyZ2V0PWttc2cgLS1sb2ctY29sb3IgLS1leGl0
LWNvZGU9MA0KPiA+ID4gL3NodXRkb3duOiBsaW5lIDk3OiBwb3dlcm9mZjogbm90IGZvdW5kIEV4
ZWN1dGUgcG93ZXJvZmYgLWYgaWYgYWxsDQo+ID4gPiB1bm1vdW50ZWQgb2ssIG9yIGV4ZWMgL2lu
aXQgc2h1dGRvd24tc2gjDQo+ID4NCj4gPiBPcGVuQk1DIGN1cnJlbnRseSBvbmx5IHN1cHBvcnRz
IHJlYm9vdC4NCj4gPiBJbnZva2luZyBzaHV0ZG93biBjYXVzZXMgdGhlIHN5c3RlbSB0byByZXR1
cm4gdG8gdGhlIExpbnV4IGluaXRyYW1mcw0KPiA+IGluc3RlYWQgb2YgcG93ZXJpbmcgb2ZmLg0K
PiA+DQo+ID4gVGhhbmtzLA0KPiA+IEphbWluDQoNCg==

