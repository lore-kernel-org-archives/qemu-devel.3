Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD8BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 03:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFlIH-0004bm-3V; Thu, 15 May 2025 22:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFlIF-0004b6-10; Thu, 15 May 2025 22:59:27 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFlIA-00025h-UG; Thu, 15 May 2025 22:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEuvQiNkoPSEBotJL3xn8CmbIALYp2JMvVH6mVaimnLvJRQb5hD/77AXpC+RPpACtHZJhwYdHLAuLsSvHE+zSuWSCDBWJ4vCTq1iO6AKxQ9gZoAzcXmtWnhcFGJkMR7WBNxzWxYWO4yoqZcczgllUGw7QbTNqm6rUbAzeIarG3RJNfuySD63MWA8Ll/m2ETwGCmoPXdUzbENQorgMMplZzdcvNZ8MV4uZlyHSWRtPV0jwG9mD2XL8fQRd9Z4mp2Vgtw0ZtoDvxIuxejbRwLUu47e5tcZbAVFr/F1alvQc4ZleDZok24tZnGyVhwZWWgie+f8f/8fnhBHJVvwhD49uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A4zh8L+pesKHuMqsF5sODbtSY+mfdbnhkw//XwHI6k=;
 b=mtFudgTLKiaVpksE/AeUQYIy9cw0KpY9iZ3tCgvZELaIz3HPy6FBr4WzmPQ05OKlj36KRC9AQMWpayua8QG8/0h1Z2VHbX484za+0LaZE0pul0i0UJLWqEyvSQfMSE2+yI+TqW+kXM22dNI7DCqt89C+2HLKMH1p+KlAboPfL7ETQKqhVujWXsItHh80rTtp4UOPCcZfLTMLpFrVi/CLNTqwt8lYZnPc4a5b0H9ENlPUPD7wK4VqyXe/Lu0EWzPljqGAdGhDkJrmYwFHt51bjyJVn6pBcI/IMIj011yBI2C8M4wGfAfBVr1c23fsgYTZ6kQnyfKRmjOJZFH3KN0cAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A4zh8L+pesKHuMqsF5sODbtSY+mfdbnhkw//XwHI6k=;
 b=AvQwJkfM20clS/v9GBL9V9HKBBM3u/VlK7w+tf9u3beHwJJTOn14rRB8HBaDBAYRXFJSPVsd1GFgNs/OwU3YH4xF1zys7EhGiDFlUa94Ti3R97o02DRE35FgRF4u8I3eNjwhZmFjAKwWsGAv7Nv7gKrHmBUfz9i3PjhSdZYj8dYpQcsKeB6exQ85E7lBsjkp1+adyb9PA/FYxN1UBLB3sHEMyIyAtbJ+nBSsE0oivv8ZRW/An/0yFYtvigSHmXWvaBV28hjto+HpEPueNceS3ZHuWEYOQVE1mAvgfLHUjZqAzFsE5B7FcN6fG1u2NO5f5nOnTtZMFsWcGQzsLVfGTw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6486.apcprd06.prod.outlook.com (2603:1096:101:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 02:59:11 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 02:59:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PULL 45/46] tests/functional/aspeed: Add test case for AST2700 A1
Thread-Topic: [PULL 45/46] tests/functional/aspeed: Add test case for AST2700
 A1
Thread-Index: AQHbkPqniOXydvp9UUCfny5pz+65h7PUCsMAgADoA0A=
Date: Fri, 16 May 2025 02:59:10 +0000
Message-ID: <SI2PR06MB5041918337B1F93AEF8AE4F2FC93A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250309135130.545764-1-clg@redhat.com>
 <20250309135130.545764-46-clg@redhat.com>
 <81355136-fddb-4134-bc75-5f8baddcefc3@redhat.com>
In-Reply-To: <81355136-fddb-4134-bc75-5f8baddcefc3@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6486:EE_
x-ms-office365-filtering-correlation-id: eff7cc8a-3093-4f0a-a90e-08dd9425a1f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bTg0eUZudEN1bXhvd3k1b3gzWEZPcFo0ZVVxUUcrWVRoRndYZkk2c3pabHFa?=
 =?utf-8?B?RkpTcmtYYXVPM3V4VVRUclRzTUdIcWtuRmdaVTBDcG9RZGJuQzRqS3FjMDFu?=
 =?utf-8?B?YXRuZ0hZT2s4eXE0c2pOWkNSUTlNVXBhYi9ML1pXYTZBWTQ0VExmNDc3YlRD?=
 =?utf-8?B?RWxLM0RySTRna2Jwdk44S1JnZEh4LzY2U3czNlZ3WXhPVWc2bTlvZ3VRZ3Iz?=
 =?utf-8?B?NHhYdVB1RWFZUG1wdmw0V3d6NjRJTi9hOFgrWUprSW1EVythbGRxMTJFbE82?=
 =?utf-8?B?ZG1VcncwTDROUmhTeHRHR3pCZDVtdjQrT0R6aERvSi9WRWNrZXVDTjRqRzIv?=
 =?utf-8?B?YjViRXpGdjlpbkxmbHhxK0hwNFg4UW0yQnk0OVgzZTIzcmNtLzh2dHlhM2hU?=
 =?utf-8?B?Z0QxZGU0Z3N1MkU5MklrV3FDUi9QanQ4QjJvbUJwQk9WdSsyWDEzMmN6SDRl?=
 =?utf-8?B?aXJYS1JXcC9MY29LQlAyWTN0aWRlSU5TNUsxODRrS2Y3c3h4Y1JXQUFxQ0dj?=
 =?utf-8?B?YTYzWnloUkJITVNobDRESjNVdVlOeFJPS3B5UmZndDFIZ3lkWFZ0dTlGLzg0?=
 =?utf-8?B?T2JUQnFQUWVjN1JIbVNWTnBvazdNYlRqV09RV3QvM1pBYzBvaHZ1UnhoVC9x?=
 =?utf-8?B?dWNPaksvN0pNVkEyQythNGZUcnN5S0tWc3owTnRyWWd6OWEwdk5nYm9keDFY?=
 =?utf-8?B?WTdXa2VZcVVqSXYzc2sxVllnMkpBUEZ6Z2FHMzVPZXpmNmdTTWFnMnJESnBP?=
 =?utf-8?B?M3Z4cUlDNG5OOTNSYVl4SGpBTEZoZFc0Y3hSWUxMQ1prMDJTV0UzYXdFcWwv?=
 =?utf-8?B?L1pqb2ZnNXpOM2d4c0NzZi91a05PNC9hV3NydFpmK1hOeVJ5ZElZQlI5emtD?=
 =?utf-8?B?bnJWY1ovZ2I2WS9RdjdkWVJRVkZ3ZXNEdFVTQnZRN0pKTVZ2ckZQMloxVzNa?=
 =?utf-8?B?dnJoR254K2dFV0p3MzB2cFp1d2lNS3dLUWpZdS9sY2tNeGtuQXlHVyt6RTVh?=
 =?utf-8?B?dG82RHR5VDRGY1NWQ2ZvVkRqcTJkUjJ0cExKdE1NcHplSkRsbGlmWkZzNUdG?=
 =?utf-8?B?SFRwSnV6dUZ0WlZVdlNydmpLRDlGTEZ1bndqcFZranZGeWt3MXJZNXJMYWpE?=
 =?utf-8?B?akErWmJGVzZOUkUvMFhHKzhCYlJpdzY4U2s3Zi9iTGRjRFovc2EzYzJlTzNr?=
 =?utf-8?B?WEtySldTQ3ZCWmF4NmhodFBUUktJVFZDZUZHUjgzem4rQzdWZUg0WkFZZ1hm?=
 =?utf-8?B?SzZpczkzS2JLWlZocTY5aU9TaWpnSXZ2eVhaTlBPRCtsRGNrcVlTM25IelFY?=
 =?utf-8?B?YkNKeFhOcTF5R1BJNUxaWkxMUU4zK3dsWUExamoxakhMaVdlRmNhN0Z6YXlP?=
 =?utf-8?B?RHBaSGhCY1JkY0dOUVU3U0xjbk9LY1pFRmlHOEpFYTBONUl1VlRpa0UrZ1dR?=
 =?utf-8?B?MmRobGJiZTh6TnB2L0h0TW1BcVRRbE5leEpkRGpWdWNnZGp0Q3Rvd2x0SkdJ?=
 =?utf-8?B?MU5nTzBEQWQrb1ZibU4rcXgvRXh4eTd1VjF5WEdab1NIV3lDbnBwZHE5ekRS?=
 =?utf-8?B?dDZHbEdUMzRFbEwrMTcvV3NqVUk2UEdnYjYvZTN0RVRYM09nZ21tMFNldzBu?=
 =?utf-8?B?OURob05hSGVBYnF4NW8xYkhPa3VHNkR3eEhMMlpybm55cmRNUzRUOC9PRmlR?=
 =?utf-8?B?Yytxb05WWitrUThxRHJ0c2xtOE1Kem5MSitWMmZNaU9GMkpiWUdjSE1PVWxo?=
 =?utf-8?B?dE42VlhMaXdMU3J0cm8vRHZvajVVSmdHMjloYWdnbHVGTWp0TWtNN2NkcWJU?=
 =?utf-8?B?NFhYUHlhNEc3M2g1Z2c4RHQxUHhKcFplVkRETFdkVU8zVi9PK3FsdGg5MjVh?=
 =?utf-8?B?VWsyNGt2cGZEbGI1aVloWHlVUlNHeTJ5RnhQMmdWV3Q1NzNPSlA5bVlKUjJ0?=
 =?utf-8?Q?oXHFUSQ49NPa4ExtDGMLSN8tGW2UoDTV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGtneEtZSm16bkJnb3ZOTjQ0d0p4Q3NpWlFTdHdIZXBwRHg0dk5YNDNnUTJZ?=
 =?utf-8?B?NkRHR1B2bXZHOUZLU25wYXpUK3FZQ0dSQzFuSERoUytpQlhlbEpxdTJzVGJS?=
 =?utf-8?B?djB3czU5K3BhYUxmdDNOQml6VWVQMXpaUkdkbFk0NU9RRWcwcDZ3RnRuaHJi?=
 =?utf-8?B?ZFA4ZEpzTXdId29JSktWL01IdzlXTENMT3E4ekMvRWozUWptbkFzVWhHU0Vw?=
 =?utf-8?B?dVhzRk5Mb0tlVml6MjYzNU0wdGZEeldna1VMa1U0N2t4d1pkQ3A5K29oOW5n?=
 =?utf-8?B?Mzd2QkU3MzcvT2RHM1ZMVjNrSWlrU3BxamNzaGEwTHNyZVl1Q1FiU3dCaHZ1?=
 =?utf-8?B?a1F5aFlOWjl5LzcxTk9vZFkxbW9HUkVpU1o3Um9aelp5SmQ2K0hHV0I2TWF1?=
 =?utf-8?B?VGhXQUI3NVBpc0xvUWZQay90c2ROQ3UySGNVdVNnVWhiNGpDWUxjTUZlY3J4?=
 =?utf-8?B?UWJWeDgxR3BtMUUwWVZ5WjNrOVNUQnkrSS96ZTd1UjFHZkJ6b2RWcms1WEt0?=
 =?utf-8?B?SkNrZDJXSEF0aWJKUjlsVXFqNE9obmxVenFTeVZBVVV5S2xkN3lhcm9ZVThF?=
 =?utf-8?B?NG95NHYvektlQ2pzL0V6b3dmd2RRQnNIblFyTDVIWEttRFFISUU5dUNmUXE5?=
 =?utf-8?B?VVJ2eW1tV01nSGhQT0pGU25CL3EwUHMwZndWbXZTSFdsQWtkb0VwZmJMTHNz?=
 =?utf-8?B?eHpJRHVuK3pBcTNreFI5bXBGZUxCYVdqVEp0bkFCSmEzcUxDYXZYVStqd3JM?=
 =?utf-8?B?elJxK0N5eVZ1TjN6RlFISWdtdC92S3Bmdjd5VmVOVC8vSVdqQlE2R1I3K3Vr?=
 =?utf-8?B?eERCRDdtRGxEelBOVlQzSEJlSFFRT3d2U2ptUXBLRFZBRy9WU1ZISEZjYTdj?=
 =?utf-8?B?bktmWnlkRVpOaXVvU2RYdzBCa3VvdXk5VGtha2F4by8rVWlTVG5wYUZGdysv?=
 =?utf-8?B?Rm44OHJST2l3MFRrVzQzNEpYWno1MXp5MFVYaGlqTHhxQWloUnU1by9kNDZB?=
 =?utf-8?B?bEYrTVM5UThpdlBlKzkzbnhxbkh4SGY5ZU92ajc2dGh5VFBtMEp2UlFpTDlG?=
 =?utf-8?B?ak1OWGlnNFRiN3JMaUh3TUkzb1pwRmpFNmtkWks0SDhjVWlnNU5EV0ZLQm1v?=
 =?utf-8?B?RHhhQ0J0R25EYU5VRURqUnJBS1NRNStOUk83RHp2TlNncU85cnNNRTAxbEpZ?=
 =?utf-8?B?UExRNlRERXRHUUhzMnBxNFFiRVFQYWJxbjJFVjlOdHI0RVl1c1gzeEtrZ1My?=
 =?utf-8?B?OTBGbmp0bkl2Mk8yWE5SdEw0VTZQd2NlQytaUndqeW1ZNzV6K3RTRmtGNkJv?=
 =?utf-8?B?M1VlVHdpWFVtSmxEVjE3WVVyaWozb2NsWjcrUXBMZlc4MTl3QytXMWhhVjNQ?=
 =?utf-8?B?UnRwckVaL0hlcnRkeTlTYTFhOGpKbWFGd1cxS2NJbklHaFNoVHprTmEzbWRv?=
 =?utf-8?B?TFNyMTJ2ejhXU0QxRXh5Qmw1NlJLS2JzeEM1SFlnZUIzaDhDeFJoNnh3NWxp?=
 =?utf-8?B?ekg1dWszS3ZhV3JrdTdUbEYyZEhwUDR4WDhCTjZQZVAxU0pYekFPRHJIdVVH?=
 =?utf-8?B?K3J4RjJlZDBrV21XWThFSW0yczJCb2NyWWdicG5kcGVPdFNvVXo5TGcydGdZ?=
 =?utf-8?B?Yng4MDRxN0ZsenRyQWdkVFJ0bXFWcHlzdmxYczlVK2RQd2V1TmJzK0FBUXg1?=
 =?utf-8?B?eFpQNTZiQ0xicGxaRndCY2FobkhSbUpDbDRha0czZmNzWkd0aEd0ZXpieXQr?=
 =?utf-8?B?MklLOVByaStFV01ZdzZSNlBVbmorTXBkYVVTclFCcWkwYXFpdUU1WmRMeHlX?=
 =?utf-8?B?aEROTTdvc2tPYkwxNlgwTWExMzN5ZzBQSG9qcUprczlDcXphNVJNWE44Yi9q?=
 =?utf-8?B?UDBubjBySmYzYStUUTVRVHd6b0p3cWVWOTA4Y3Z6eW1zeVRMeEQ2Z0lpL2Ro?=
 =?utf-8?B?ZEZadHloV3Q0YnFJVmswM2g1MTlFdkk5a0I2REdHSnQ5TU5Yd2hqWGVPZ2pt?=
 =?utf-8?B?Q0ZlYTJJekk0Z3c0RTNmMDdGcnNzMXppZ3ZYcGo2dk0wbnc5dG0zMlZZQUpC?=
 =?utf-8?B?QUk0c2Z5eFJxdXdBN09xcnlvMnAvb2tDcWMzSDMwemZBVW5QcFI2dWJSWSto?=
 =?utf-8?Q?IpZH41MFxydnv7KfTwNjOKCrQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff7cc8a-3093-4f0a-a90e-08dd9425a1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 02:59:10.8160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twJd4GWdHhEmo3vPbRd/HJ3K88Mz3VyERMVikiIHHeuJZUP8NOsrkvrZspk4yd77kNIbU/a0o8DotpSSitBum0LWL2a1yGF4WB/cZ1m5xJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6486
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IA0KPiBPbiBhIEJFIGhvc3QsIGlmIEkgcnVuIGFuIGFzdDI3MDBhMC1l
dmIgbWFjaGluZSA6DQo+IA0KPiAgICAgJCBxZW11LXN5c3RlbS1hYXJjaDY0IC1tYWNoaW5lIGFz
dDI3MDBhMC1ldmIgIC4uLg0KPiAgICAgLi4uDQo+ICAgICBVLUJvb3QgMjAyMy4xMC12MDAuMDUu
MDYgKE1hciAyNiAyMDI1IC0gMDU6NTk6MjYgKzAwMDApDQo+IA0KPiAgICAgU09DOiBBU1QyNzAw
LUEwDQo+ICAgICBNb2RlbDogQVNUMjcwMCBFVkINCj4gICAgIERSQU06ICA4IEdpQiAoZWZmZWN0
aXZlIDAgQnl0ZXMpDQo+IA0KPiBRRU1VIGhhbmdzLg0KPiANCj4gSWYgdGhlIFJBTSBzaXplIGlz
IGRlZmluZWQgdG8gOGcNCj4gDQo+ICAgICAkIHFlbXUtc3lzdGVtLWFhcmNoNjQgLW1hY2hpbmUg
YXN0MjcwMGEwLWV2YiAtbSA4ZyAgLi4uDQo+ICAgICAuLi4NCj4gICAgIFUtQm9vdCAyMDIzLjEw
LXYwMC4wNS4wNiAoTWFyIDI2IDIwMjUgLSAwNTo1OToyNiArMDAwMCkNCj4gDQo+ICAgICBTT0M6
IEFTVDI3MDAtQTANCj4gICAgIE1vZGVsOiBBU1QyNzAwIEVWQg0KPiAgICAgRFJBTTogIDggR2lC
DQo+ICAgICBhc3BlZWRfZHAgZHBAMTJjMGEwMDA6IGFzcGVlZF9kcF9wcm9iZSgpOiBGYWlsZWQg
dG8gYWNjZXNzIGRwLg0KPiB2ZXJzaW9uKDApDQo+ICAgICBDb3JlOiAgMTI1IGRldmljZXMsIDI3
IHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBzZXBhcmF0ZQ0KPiANCj4gbWFjaGluZSBib290cy4NCj4g
DQo+IFdoZXJlYXMsIHdpdGggYW4gYXN0MjcwMGExLWV2YiBtYWNoaW5lIDoNCj4gDQo+ICAgICAk
IHFlbXUtc3lzdGVtLWFhcmNoNjQgLW1hY2hpbmUgYXN0MjcwMGExLWV2YiAgLi4uDQo+ICAgICAu
Li4NCj4gICAgIFUtQm9vdCAyMDIzLjEwLXYwMC4wNS4wNiAoTWFyIDI2IDIwMjUgLSAwNTo1OToy
NiArMDAwMCkNCj4gDQo+ICAgICBTT0M6IEFTVDI3MDAtQTENCj4gICAgIE1vZGVsOiBBU1QyNzAw
IEVWQg0KPiAgICAgRFJBTTogIDEgR2lCDQo+ICAgICBhc3BlZWRfZHAgZHBAMTJjMGEwMDA6IGFz
cGVlZF9kcF9wcm9iZSgpOiBGYWlsZWQgdG8gYWNjZXNzIGRwLg0KPiB2ZXJzaW9uKDApDQo+ICAg
ICBDb3JlOiAgMTI1IGRldmljZXMsIDI3IHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBzZXBhcmF0ZQ0K
PiANCj4gbWFjaGluZSBib290cy4NCj4gDQo+ICAgICAkIHFlbXUtc3lzdGVtLWFhcmNoNjQgLW1h
Y2hpbmUgYXN0MjcwMGExLWV2YiAtbSA4ZyAgLi4uDQo+ICAgICAuLi4NCj4gICAgIFUtQm9vdCAy
MDIzLjEwLXYwMC4wNS4wNiAoTWFyIDI2IDIwMjUgLSAwNTo1OToyNiArMDAwMCkNCj4gDQo+ICAg
ICBTT0M6IEFTVDI3MDAtQTENCj4gICAgIE1vZGVsOiBBU1QyNzAwIEVWQg0KPiAgICAgRFJBTTog
IDggR2lCDQo+ICAgICBhc3BlZWRfZHAgZHBAMTJjMGEwMDA6IGFzcGVlZF9kcF9wcm9iZSgpOiBG
YWlsZWQgdG8gYWNjZXNzIGRwLg0KPiB2ZXJzaW9uKDApDQo+ICAgICBDb3JlOiAgMTI1IGRldmlj
ZXMsIDI3IHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBzZXBhcmF0ZQ0KPiANCj4gbWFjaGluZSBib290
cy4NCj4gDQo+IA0KPiBJIFdvbmRlciBpZiB5b3UgY291bGQgYW5hbHl6ZSB0aGlzIGlzc3VlIHRv
IGNoZWNrIGlmIGl0IGlzIHJlbGF0ZWQgdG8gb25lIG9mIG91cg0KPiBRRU1VIG1vZGVsLg0KPiAN
Cj4gDQoNClNvcnJ5LCBJIG9ubHkgaGF2ZSBhIGxpdHRsZS1lbmRpYW4gaG9zdCBtYWNoaW5lICh4
ODZfNjQpLg0KSXMgaXQgcG9zc2libGUgdG8gcnVuIGEgYmlnLWVuZGlhbihQT1dFUiBQQykgUUVN
VSBob3N0IGVudmlyb25tZW50IG9uIHRoaXMgbWFjaGluZSwgc28gdGhhdCBJIGNhbiB0aGVuIHJ1
biB0aGUgQVNUMjcwMCBRRU1VIHRhcmdldCBpbnNpZGUgaXQgdG8gYW5hbHl6ZSB0aGlzIGlzc3Vl
Pw0KDQpJZiB5b3UgYWdyZWUsIGNvdWxkIHlvdSBwbGVhc2UgaGVscCBtZSBpbnNlcnQgdGhlIGZv
bGxvd2luZyBsaW5lcyBpbnRvIHRoZSBmdW5jdGlvbiB0aGF0IGRldGVjdHMgdGhlIERSQU0gc2l6
ZSBvbiB0aGUgQVNUMjcwMD8NCmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvYmxvYi9tYXN0
ZXIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMjTDMzMg0KaHR0cHM6Ly9naXRodWIuY29tL3FlbXUv
cWVtdS9jb21taXQvNzQzNmRiMTA2M2JiZmVjYzJlNDk4YTdkNzk1NjEzYjMzMzEyZDY2NSANCmBg
YGANCnN0YXRpYyB2b2lkIGFzcGVlZF9yYW1fY2FwYWNpdHlfd3JpdGUodm9pZCAqb3BhcXVlLCBo
d2FkZHIgYWRkciwgdWludDY0X3QgZGF0YSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzaXplKQ0Kew0KICAgIEFzcGVlZFNvQ1N0
YXRlICpzID0gQVNQRUVEX1NPQyhvcGFxdWUpOw0KICAgIHJhbV9hZGRyX3QgcmFtX3NpemU7DQog
ICAgTWVtVHhSZXN1bHQgcmVzdWx0Ow0KICAgIHVpbnQzMl90IHJlYWRfYmFja1s0XSA9IHswfTsN
CiAgICByYW1fc2l6ZSA9IG9iamVjdF9wcm9wZXJ0eV9nZXRfdWludChPQkpFQ1QoJnMtPnNkbWMp
LCAicmFtLXNpemUiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCk7DQoNCiAgICBhc3NlcnQocmFtX3NpemUgPiAwKTsNCiAgICBwcmludGYoImph
bWluIHNpemUgJWRcbiIsIHNpemUpOw0KICAgIHByaW50ZigiYWRkcj0lIiBQUkl4NjQgIiAoYWRk
ciByYW1fc2l6ZSk9JSIgUFJJeDY0ICJcbiIsIGFkZHIsIChhZGRyICUgcmFtX3NpemUpKTsNCiAg
ICAvKg0KICAgICAqIEVtdWxhdGUgZGRyIGNhcGFjaXR5IGhhcmR3YXJlIGJlaGF2aW9yLg0KICAg
ICAqIElmIHdyaXRlcyB0aGUgZGF0YSB0byB0aGUgYWRkcmVzcyB3aGljaCBpcyBiZXlvbmQgdGhl
IHJhbSBzaXplLA0KICAgICAqIGl0IHdvdWxkIHdyaXRlIHRoZSBkYXRhIHRvIHRoZSAiYWRkcmVz
cyAlIHJhbV9zaXplIi4NCiAgICAgKi8NCiAgICByZXN1bHQgPSBhZGRyZXNzX3NwYWNlX3dyaXRl
KCZzLT5kcmFtX2FzLCBhZGRyICUgcmFtX3NpemUsDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCAmZGF0YSwgc2l6ZSk7DQogICAgaWYgKHJl
c3VsdCAhPSBNRU1UWF9PSykgew0KICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJP
UiwNCiAgICAgICAgICAgICAgICAgICAgICAiJXM6IERSQU0gd3JpdGUgZmFpbGVkLCBhZGRyOjB4
JSIgSFdBRERSX1BSSXgNCiAgICAgICAgICAgICAgICAgICAgICAiLCBkYXRhIDoweCUiIFBSSXg2
NCAgIlxuIiwNCiAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYWRkciAlIHJhbV9zaXpl
LCBkYXRhKTsNCiAgICB9DQoNCiAgICBhZGRyZXNzX3NwYWNlX3JlYWQoJnMtPmRyYW1fYXMsIGFk
ZHIgJSByYW1fc2l6ZSwNCiAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQRUNJ
RklFRCwgcmVhZF9iYWNrLA0KICAgICAgICAgICAgICAgICAgICAgICBzaXplKTsNCg0KICAgIGZv
cihpbnQgaT0wOyBpPDQ7IGkrKykgew0KICAgICAgICBwcmludGYoImphbWluIHJlYWRfYmFja1sl
ZF09JXhcbiIsIGksIHJlYWRfYmFja1tpXSk7DQogICAgfQ0KfQ0KYGBgYA0KQWxzbywgY291bGQg
eW91IHBsZWFzZSBwcm92aWRlIG1lIHdpdGggdGhlIGZvbGxvd2luZyBsb2c/DQoNClUtQm9vdCAy
MDIzLjEwLXYwMC4wNS4wNiAoTWFyIDI2IDIwMjUgLSAwNTo1OToyNiArMDAwMCkNCg0KU09DOiBB
U1QyNzAwLUEwDQpNb2RlbDogQVNUMjcwMCBFVkINCkRSQU06ICBqYW1pbiBzaXplIDQNCmFkZHI9
YzAwMDAwMDAgKGFkZHIgcmFtX3NpemUpPTANCmphbWluIHJlYWRfYmFja1swXT1lYWRiZWVmNA0K
amFtaW4gcmVhZF9iYWNrWzFdPTANCmphbWluIHJlYWRfYmFja1syXT0wDQpqYW1pbiByZWFkX2Jh
Y2tbM109MA0KamFtaW4gc2l6ZSA0DQphZGRyPTQwMDAwMDAwIChhZGRyIHJhbV9zaXplKT0wDQpq
YW1pbiByZWFkX2JhY2tbMF09YWRiZWVmNDMNCmphbWluIHJlYWRfYmFja1sxXT0wDQpqYW1pbiBy
ZWFkX2JhY2tbMl09MA0KamFtaW4gcmVhZF9iYWNrWzNdPTANCmphbWluIHNpemUgNA0KYWRkcj0w
IChhZGRyIHJhbV9zaXplKT0wDQpqYW1pbiByZWFkX2JhY2tbMF09ZGJlZWY0MzINCmphbWluIHJl
YWRfYmFja1sxXT0wDQpqYW1pbiByZWFkX2JhY2tbMl09MA0KamFtaW4gcmVhZF9iYWNrWzNdPTAN
CjEgR2lCDQoNCkl0J3MgcXVpdGUgc3RyYW5nZSwgYmVjYXVzZSB5b3UgbWVudGlvbmVkIHRoYXQg
dGhlIEExIHZlcnNpb24gd29ya3MsIGJ1dCB0aGUgQTAgdmVyc2lvbiBkb2Vzbid0Lg0KSXQgc2Vl
bXMgZGV0ZWN0IHRoZSBEUkFNIHNpemUgZmFpbGVkIGluIHRoaXMgbG9vcCwgIA0KaHR0cHM6Ly9n
aXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL3UtYm9vdC9ibG9iL2FzcGVlZC1tYXN0ZXItdjIwMjMu
MTAvZHJpdmVycy9yYW0vYXNwZWVkL3NkcmFtX2FzdDI3MDAuYyNMMTE3Mw0Kc3RydWN0IGRkcl9j
YXBhY2l0eSByYW1fc2l6ZVtdID0gew0KCQl7MHgxMDAwMDAwMCwJezIwOCwgMjU2fX0sIC8vIDI1
Nk1CDQoJCXsweDIwMDAwMDAwLAl7MjA4LCA0MTZ9fSwgLy8gNTEyTUINCgkJezB4NDAwMDAwMDAs
CXsyMDgsIDU2MH19LCAvLyAxR0INCgkJezB4ODAwMDAwMDAsCXs0NzIsIDg4MH19LCAvLyAyR0IN
CgkJezB4MTAwMDAwMDAwLAl7NjU2LCA4ODB9fSwgLy8gNEdCDQoJCXsweDIwMDAwMDAwMCwJezg4
MCwgODgwfX0sIC8vIDhHQg0KCQl9Ow0KdTMyIHRlc3RfcGF0dGVybiA9IDB4ZGVhZGJlZWYNCg0K
Zm9yIChzeiA9IFNEUkFNX1NJWkVfOEdCIC0gMTsgc3ogPiBTRFJBTV9TSVpFXzI1Nk1COyBzei0t
KSB7DQoJCXRlc3RfcGF0dGVybiA9ICh0ZXN0X3BhdHRlcm4gPDwgNCkgKyBzejsNCgkJd3JpdGVs
KHRlc3RfcGF0dGVybiwgKHZvaWQgKilDRkdfU1lTX1NEUkFNX0JBU0UgKyByYW1fc2l6ZVtzel0u
c2l6ZSk7DQoNCgkJaWYgKHJlYWRsKCh2b2lkICopQ0ZHX1NZU19TRFJBTV9CQVNFKSAhPSB0ZXN0
X3BhdHRlcm4pDQoJCQlicmVhazsNCn0NCg0KUGxlYXNlIGhlbHAgdG8gZHVtcCB0aGlzIHJlZ2lz
dGVyLg0KPT4gbWQgMTJjMDAwMTANCjEyYzAwMDEwOiAwMDAwMDAyOCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAgKC4uLi4uLi4uLi4uLi4uLg0KDQoweDI4LS0+DQowMDEwIDEwMDANCkJpdDAg
OiAwIEREUjQgU0RSQU0NCkJpdDoxIDogMCBSZXNlcnZlZA0KQml0OjQ6MiA6IDAxMCAtLT4gMUdC
IA0KDQpUaGFua3MtSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQo=

