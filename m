Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B65C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCxZB-0002OM-S4; Fri, 31 May 2024 04:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sCxZ9-0002Ni-L2; Fri, 31 May 2024 04:24:48 -0400
Received: from mail-psaapc01on20714.outbound.protection.outlook.com
 ([2a01:111:f400:feae::714]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sCxZ7-0005XC-59; Fri, 31 May 2024 04:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ8IjP2EhL24WyVmm252AbLOorAIB/dBQ8re9f2ee84w2LEFNCkfrpI+1y+KdQDenQJy6aVQOqB0aRkHL27OQSSoFATFxSd9kXExMd5PZfMlOF9roRJt+b1oSDzysBH/mtbBSKUb2RjaFpo/T0liTpckAXqzXc01X54EYz0UQFpxA4Utmo/utKh9iaDppxU8kP4E/7GsLqzRa+asdoZ+CqA4STrOc42ET2XHp7lhUxOwMLXkdnrHaxfAIyZWEWcZIeU8a3chG44NVIUwmUqJ2BjDAWR+K250Ye5QSBvRKx7dVmCbhyxSpngeU2eFEzUhud1aKVSfSJBPFKCzkm8pIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqMy7HAKTs9HRh98TdUYXyJgKoDZWUr5+zK737K7Q6k=;
 b=MLGepp9yKJvz/jmDx9la2dD1qcu+GjAdRBGBjmY86rinDVZoftQlSAxpeWC+b2iK+k85qIw5UyIgo6w2oG/eDLbEdsiWHjPdrrwU4CGh5Z3NJLYrww2WQJq/VQwMuC8yLO614aGtgAJm9Cg4InGWy12KKB1Jsa/kFnuYxPncNxFGB7dgNTlWbXUHttnHIEuKXCeDRhPV0JrsDEb1R/EuSMMkMjsUSLt+aGC3/BSWD2ocEHcLkygfijms6BxaH4yYsUfdO+P7sv7LNAIl/tMYX7tq1OFKU4LxUXvq9ewnG7Ys1kP7bTKreBgPd/PKisk064YncZONlcn6ICfneMJX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqMy7HAKTs9HRh98TdUYXyJgKoDZWUr5+zK737K7Q6k=;
 b=GrsYIzTMDlp7wQLSKrCEiKY/9OF5Uq901AcMGphy413GwrdN/M/bS1bm7/8o3cG1WLULe8WJ/VjHXdoqyUPtfaHMYBKenX7d3Wsyttb5GnlKsV5cwVHb2apLQb2LCn5E2aRIJPMsj6I5zx66kMU6Y0ZkXYDSfrchMhx8MJWW6eCTNtJXIA9vT+JkjopH1NbPE3KU74oVdcXIieAXLHRkc/Z17TXtJInizzpg9mVlOmxDJ3sT5kDX5PciL+7xtQABdB6gwWZcR724dLowqHHdK5mghWwUQi0AqxbCsnlpybkRBSdSc9v7OJqAhD9bzO4nyTgNgLDL6eHvgEKRkDXsIQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB7237.apcprd06.prod.outlook.com (2603:1096:101:238::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 31 May
 2024 08:24:32 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 08:24:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v4 12/16] aspeed/soc: Add AST2700 support
Thread-Topic: [PATCH v4 12/16] aspeed/soc: Add AST2700 support
Thread-Index: AQHasAxEojDAJ4aj6kmyTBS4pP0HPbGsUe2AgAR/QkCAACv3gIAACAAQ
Date: Fri, 31 May 2024 08:24:32 +0000
Message-ID: <SI2PR06MB50417A566C3CC568DF24A2ABFCFC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-13-jamin_lin@aspeedtech.com>
 <7ea55928-e61e-4112-992d-b899c65b4652@kaod.org>
 <SI2PR06MB50411ED51276574422E07948FCFC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <a2aa3c01-51dd-4517-9261-038fff11f091@kaod.org>
In-Reply-To: <a2aa3c01-51dd-4517-9261-038fff11f091@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB7237:EE_
x-ms-office365-filtering-correlation-id: 9141cba6-78c3-497f-4df6-08dc814b1919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|376005|366007|38070700009|921011; 
x-microsoft-antispam-message-info: =?utf-8?B?U2s0Z1JpYkNzV3dDQmx4MEVQOVZwNE9POVVjdThwUGVkVWxxVkRtdnRvdXFU?=
 =?utf-8?B?clhteGN6Z2M0Ykpib0w0U3IzQVpWeElBcFVKSU5LcjlVVFEzVkV1K0l3QzM5?=
 =?utf-8?B?REZrQUZ4ZkdaNnh0UWR6MHd2U1lVKzNwVXRnSUQ4endrTC9kRkdkdEVMTk9H?=
 =?utf-8?B?UTlYTUVmRnh6ZDh0bThEMDY1WXRiVDUxZHlVbUxuOHpQRXUrSFU4R3lxaTdn?=
 =?utf-8?B?L1UyOGZaZmJweFdIUEUra0RkUUVsUno5dE02OW94bnMwQ05hSnVBMjJSeEVj?=
 =?utf-8?B?aENnbzZaU21JMm1YN1hEWCtnNXZwWUFISHZHS2JiaDg3VkpIUlNuTDZkUm1z?=
 =?utf-8?B?VkFkSGNTakVnUjlkZnRJVkYvZHhRS2JRTUZ1WVM2L2pyVVA1bVIvNERvRFJS?=
 =?utf-8?B?UTgzSlcrMXJGUnF1eXZham9iRzlORkpjQnZ6WmFJTnFjczd5cENrbm5GRnNE?=
 =?utf-8?B?K0ZSUWZhNGQ4NW05Mm43NDB2SCt3WDRobEM0MjVSZGxwanhIOXZCRVBQMnds?=
 =?utf-8?B?ZXBna3dISEExSnJBTlZ0bEMyWXl0VG4wL1d4SGJIcVpVbHViVDAxRnhOWnpG?=
 =?utf-8?B?S2lTQjVlb2dpLzZ2b1VJeWc0RmMvZUVzcnl6czh3L1FMdHNqdGNEYVNnNW05?=
 =?utf-8?B?N1NCZkIyYVlsWUg4U1lZdFRwV1kxdGt1UE1HcFVOdXV4eXZxdC9SeW1TU1pD?=
 =?utf-8?B?eFltdkV1ZHoydWFxM2l0azFtWmJSS2Z6c1RKMXB0ZzNydStubk8wMEY5dys0?=
 =?utf-8?B?ZzlyMGlJUHk0MkZ3YVZSb2p4dktrVnBtaldRZkdyYkR3Sk1leEV1ejdUT01s?=
 =?utf-8?B?Q3VZSEdYTHlaeDQ4NGtqVkk5UkZraWZpUEk3alJkUWoxZERRVGtaSTV1Ulp1?=
 =?utf-8?B?eVdDTWNJeHVuTURqTU9Wb0o4RmM3elZXSzR0Z00zcWZoc3FOcExLNkRzVmJ1?=
 =?utf-8?B?b1cxVzBJdmFPdXlBcFdpWTlpM1FFSDlpdjdJdllQT2JtL1YwOG0yRlJtNU5a?=
 =?utf-8?B?OWIrZHNtdHZCNGUyN2tXR3pMODNhazFobFFTNmNSVjZrQlhGNnVOUzBQNGZ4?=
 =?utf-8?B?bS8za3V4RTZCMWtkTm5KejFYRDQ5RGJHd1Fud1F6UjNrUnNEd1hNdENiczZn?=
 =?utf-8?B?NGJSQmFvK0dZMHU4cGQ0K21OL1pFTWRsRVdobjVqNjF2YWJYRVVQeGkyYjBu?=
 =?utf-8?B?MktSdDJEYU9ldjhQZ0hEd0lvMFc2MmdHREQ3NndiSS8yNkIxMTBXWFRmckVW?=
 =?utf-8?B?N2VjdDFBRy9Tb1gyS0h1TUlCZUJMaTQ0NU0zeG5KTTlUVVBoS3NDN3VzS0Uy?=
 =?utf-8?B?eGZxMk9YQ25HcDRJUUhoZFh3WUF0cWhmY1VkQ1RyTi9lL0FzVzdLaVFHMGNz?=
 =?utf-8?B?ZzBzeHpqVXc5S1pEZlUzY3cyYnhSVWZ5T214SVNNUmVMaU1pK1JwbVBHaHNS?=
 =?utf-8?B?VGR5K3JXV1kxbmtOYktTeStOM3JuWC9NTnZBdGdxSWZNY1hHN05GbU8xenlD?=
 =?utf-8?B?eDhPQncxYjhSbmlacWdMaDg0ajFZdDF6Rm1GUzRJY3VPaFVmNmZEb2g1Q3NE?=
 =?utf-8?B?SWhDbnFsZHN3VkczektaWmV2OFVGS05adTZhUzhZVlJEcXFtOGhCbkVXT3JC?=
 =?utf-8?B?VTRwbzRPOHVOajF1cXBlcEN3bWR1Y3FHRW93OHBSZERKUDFMV0lGeFVpakE1?=
 =?utf-8?B?QnFSUGt2aFdTVTlXcStqa3F1N25mRGVVb3llb2F6Zjd1bkY2K1pNa00zVUZM?=
 =?utf-8?Q?DbALmwyPzmk/Kc9G54=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(921011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tmw5b1oyZ0tNV3ZzeTFQbnJhcXN3d0RNTTY1OU5WVE5lU1d4M25QK3ZvaWpL?=
 =?utf-8?B?TExUYnArSTZlMmdQa0U2cHR0VTlFUk42dHZtcVVablV1K3hJejMxUTc5eWlM?=
 =?utf-8?B?L2J0UWE2U0NxYjc4ZW11N0FHM1JMUVNUV3lLb0wzWnltZlkraHBobWEwOStT?=
 =?utf-8?B?eFhXR3Y1N21GeW5lVVg1WmptK0hmNlFaYzkwYXh5OHZYUW5kTTZGMm5uMlFH?=
 =?utf-8?B?bW5TRTdWWnpSNSt3aGlVbGtaOXZaNHQ2QS9jaG8rMEZiQWFLem5FVFhhTVl3?=
 =?utf-8?B?SUgvc2c5YkxuNVNMdytIeDdTci96bFZqUGQ5azRpUUlUNkc1MVlCWFlKSWxw?=
 =?utf-8?B?RGdIZ3AybEVQbDNiT2x3SmF5NTNGQnhBcUZ0QmpMTEdRbVJaQ1llTVBKM3FL?=
 =?utf-8?B?TVE2RDZVYndqd2JjYStJcitYWDRMYjJ6WENOUk1CK2ZsbHRWUzVHeFJaTFhm?=
 =?utf-8?B?ZFNqaWFTdGhUM2ljWks0d04yWjRNVVk1VHVETVh3bVk2RkVEOUJ2UjJvdko0?=
 =?utf-8?B?WjBzTzdibEpyNmVROVltMlV4MVAzZ0lPL2E5aHpnTlNLUEVyNGRtbHoxaFhQ?=
 =?utf-8?B?eXlCZUdvTG42OTQ1aTR4K251VEpGUG5XbEk5eU5OeFZ4NXovVks1dUUwSFlT?=
 =?utf-8?B?S3Yyc0pOc2NsTkFXTzl1dWZUbDdzUGpzVTNMbmZWcjBEMUR4dzhObFV4dktH?=
 =?utf-8?B?UkM4OHdOaW1HRjFJVXh0aFoxWHdUdnlOSkdFUjV4K0hYUHBCQldacUVFaGQx?=
 =?utf-8?B?c1BHcVdHazB4VFhUaWYyZ09CU2dXMG9qd0Y5OW5BR0lwZ3FETUVwdWlscUxO?=
 =?utf-8?B?NXJqc0JkYkRtcFA3UnhpL091aHplT3NNVjB4a0hsZ1pGMmpEWWMvci9HNHgv?=
 =?utf-8?B?a08yS0lGVjNRMEptZmt3NnFibVJzMmxJY09JeFkrMzZ6MEdEalV0L1FNbHQ5?=
 =?utf-8?B?NytybGs1U1gvdFdVVEtoOVR6Y3c2N2hWemVpYmY4NFQrdFR0bWFOcUc3VG0z?=
 =?utf-8?B?T1Zqc1lVVUM5ZUFwU3crSDNOallUNXdnYVkrMXphWC85WmFlZ0UwcnpMb2dh?=
 =?utf-8?B?TDllVG91ZUo0R3c3eUZud1RESTdveTVYQkZLRzkvbGthVTNNcjRHQUNkZHNo?=
 =?utf-8?B?ajdHTmpBSGdLMk9IZi9iQW9HYWlqV1lIM0wwaDh2ODdnTXRITVA0S3h2Q05h?=
 =?utf-8?B?MTRXcWVtMzdQbklEYnIvbTI3NlhucjBTZ2lUdTI4ZEUzWU1NUlJQNzlybUp4?=
 =?utf-8?B?WXJ1SDk4ZUlDNHJMYUt4NndVcmNJYzE2U1UxbGNURG5XZ0g5TS9meFhRYm5S?=
 =?utf-8?B?RXpGK2tZTEpDa1h1ZVp6NHRHbi9SajJ6aTVTbS95TmtnajgrQUVvd1Q5anhj?=
 =?utf-8?B?V2hkQ2haYzVMeWlVRDExTHd1R3JRbGViL2hvcVVlaUVNM0VYS2p5TDhpU2ZI?=
 =?utf-8?B?UXFvdm5qZzdRVU9vdVhMWDZmREovNllvY0JUczRNLzhCQTRSV1FQaXN2ei9o?=
 =?utf-8?B?Rk9LaTFmaWdNZkFmTStzTDhqaEdQaFkzY1pGaW11M1d4UDV4U283WkxUejVQ?=
 =?utf-8?B?SzNDYjFyMnlwa0VHSjhiNFV3MHM3S05VLy9zTk15TUJpQlFWVnhsbmZqb0Rn?=
 =?utf-8?B?QVN3M3Z5K1ZrNUYwcXZOSjR4WENUQzJmazdtNHM5ZFZJTGRiMkVOczUvRWJR?=
 =?utf-8?B?UXdrd2h2NmtMZzM1MXFndkdZcE1kbXBKdE94TllvTS8zV3dhajY1a0NIYTRj?=
 =?utf-8?B?OVM2bFMzN3RkbndQc21LQXJOWHhjc0ZZcktVZFdwc0xINDViQUM1d0ZaZUNM?=
 =?utf-8?B?VkJMTk1GWHdXZG16WGpIRTJUN1lKVXFoOGZ2MVlET3lQNDk5OUNNeHZYM2dU?=
 =?utf-8?B?dG11THZZUUJIZFJaUklvaWp0Mjl5ZzdtT3l5RHpnYW9HSEJzSE1RdDFoc0Ey?=
 =?utf-8?B?bnBuWEM4TUtVK2hjWnJjN3BtSmVrT296ZDJna1NBOWYzU2l6UnB6dmZXYUc4?=
 =?utf-8?B?TDQyRWRvbHBvaUhxRm00MlA3VkdvQ2RGQWN0QittKzZzNWRTWWNjTzFYbFdh?=
 =?utf-8?B?YTZsZGh3Mk4yblB0QXpGM3Z5Rk95NzlqbnpUUlF6SGhQMTNweGxlSEROWUxs?=
 =?utf-8?Q?vgwQobkA0ki8TMBj/tlyzxx/t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9141cba6-78c3-497f-4df6-08dc814b1919
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 08:24:32.3316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OcPmablLLhJIvwL9XprCyDOVRaHVKT+mkROAqOG7GJkBIyNe7iZAowxc6+9YdcbGtgEe5ZRFXP3fQscQEdNNrbzetbgM6SamM40gUbEe3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7237
Received-SPF: pass client-ip=2a01:111:f400:feae::714;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTIvMTZdIGFzcGVlZC9zb2M6IEFkZCBBU1QyNzAwIHN1
cHBvcnQNCj4gDQo+IA0KPiBIZWxsbyBKYW1pbiwNCj4gPiBJIHJlZmVyIHRvIHZlcnNhbF9jcmVh
dGVfYXB1X2dpYyBmdW5jdGlvbiwNCj4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9ibG9i
L21hc3Rlci9ody9hcm0veGxueC12ZXJzYWwuYyNMNjcNCj4gPiBhbmQgdXBkYXRlZCBhc3BlZWRf
c29jX2FzdDI3MDBfZ2ljIGFzIGZvbGxvd2luZy4NCj4gPiBJZiB5b3UgaGF2ZSBhbnkgY29uY2Vy
bmVkIGFib3V0IHRoZSBuZXcgY2hhbmdlcywgcGxlYXNlIGxldCBtZSBrbm93Lg0KPiA+IFRoYW5r
cy1KYW1pbg0KPiA+DQo+ID4gc3RhdGljIGJvb2wgYXNwZWVkX3NvY19hc3QyNzAwX2dpYyhEZXZp
Y2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+IA0KPiBQbGVhc2UgcmVuYW1lIHRvIGFzcGVl
ZF9zb2NfYXN0MjcwMF9naWNfcmVhbGl6ZSgpDQpXaWxsIGZpeCBpbiB2NSBwYXRjaA0KPiANCj4g
PiB7DQo+ID4gICAgICBBc3BlZWQyN3gwU29DU3RhdGUgKmEgPSBBU1BFRUQyN1gwX1NPQyhkZXYp
Ow0KPiA+ICAgICAgQXNwZWVkU29DU3RhdGUgKnMgPSBBU1BFRURfU09DKGRldik7DQo+ID4gICAg
ICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBBU1BFRURfU09DX0dFVF9DTEFTUyhzKTsNCj4gPiAgICAg
IFN5c0J1c0RldmljZSAqZ2ljYnVzZGV2Ow0KPiA+ICAgICAgRGV2aWNlU3RhdGUgKmdpY2RldjsN
Cj4gPiAgICAgIFFMaXN0ICpyZWRpc3RfcmVnaW9uX2NvdW50Ow0KPiA+ICAgICAgaW50IGk7DQo+
ID4NCj4gPiAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVChhKSwgImFzdDI3MDAt
Z2ljIiwgJmEtPmdpYywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdpY3YzX2Ns
YXNzX25hbWUoKSk7DQo+IA0KPiBhbmQgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQoKSBjYW4gYmUg
Y2FsbGVkIGluIGFzcGVlZF9zb2NfYXN0MjcwMF9pbml0KCkuDQpXaWxsIGZpeCBpbiB2NSBwYXRj
aA0KDQpNeSBuZXcgY2hhbmdlcyBhcyBmb2xsb3dpbmcsDQpzdGF0aWMgdm9pZCBhc3BlZWRfc29j
X2FzdDI3MDBfaW5pdChPYmplY3QgKm9iaikgew0KLS0NCiAgICBvYmplY3RfaW5pdGlhbGl6ZV9j
aGlsZChvYmosICJnaWMiLCAmYS0+Z2ljLCBnaWN2M19jbGFzc19uYW1lKCkpOw0KLS0NCn0NCg0K
PiANCj4gPiAgICAgIGdpY2J1c2RldiA9IFNZU19CVVNfREVWSUNFKCZhLT5naWMpOw0KPiA+ICAg
ICAgZ2ljZGV2ID0gREVWSUNFKCZhLT5naWMpOw0KPiA+ICAgICAgcWRldl9wcm9wX3NldF91aW50
MzIoZ2ljZGV2LCAicmV2aXNpb24iLCAzKTsNCj4gPiAgICAgIHFkZXZfcHJvcF9zZXRfdWludDMy
KGdpY2RldiwgIm51bS1jcHUiLCBzYy0+bnVtX2NwdXMpOw0KPiA+ICAgICAgcWRldl9wcm9wX3Nl
dF91aW50MzIoZ2ljZGV2LCAibnVtLWlycSIsIEFTVDI3MDBfTUFYX0lSUSk7DQo+ID4NCj4gPiAg
ICAgIHJlZGlzdF9yZWdpb25fY291bnQgPSBxbGlzdF9uZXcoKTsNCj4gPiAgICAgIHFsaXN0X2Fw
cGVuZF9pbnQocmVkaXN0X3JlZ2lvbl9jb3VudCwgc2MtPm51bV9jcHVzKTsNCj4gPiAgICAgIHFk
ZXZfcHJvcF9zZXRfYXJyYXkoZ2ljZGV2LCAicmVkaXN0LXJlZ2lvbi1jb3VudCIsDQo+IHJlZGlz
dF9yZWdpb25fY291bnQpOw0KPiA+DQo+ID4gICAgICBpZiAoIXN5c2J1c19yZWFsaXplKGdpY2J1
c2RldiwgZXJycCkpIHsNCj4gPiAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICB9DQo+
ID4gICAgICBzeXNidXNfbW1pb19tYXAoZ2ljYnVzZGV2LCAwLCBzYy0+bWVtbWFwW0FTUEVFRF9H
SUNfRElTVF0pOw0KPiA+ICAgICAgc3lzYnVzX21taW9fbWFwKGdpY2J1c2RldiwgMSwNCj4gc2Mt
Pm1lbW1hcFtBU1BFRURfR0lDX1JFRElTVF0pOw0KPiA+DQo+ID4gICAgICBmb3IgKGkgPSAwOyBp
IDwgc2MtPm51bV9jcHVzOyBpKyspIHsNCj4gPiAgICAgICAgICBEZXZpY2VTdGF0ZSAqY3B1ZGV2
ID0gREVWSUNFKHFlbXVfZ2V0X2NwdShpKSk7DQo+IA0KPiBDb3VsZCB3ZSBhdm9pZCBxZW11X2dl
dF9jcHUoKSBhbmQgdXNlIHRoZSBjcHUgYXJyYXkgb2YgdGhlIFNvQyBpbnN0ZWFkID8NClllcywg
SSBjYW4gY2hhbmdlIGl0IGFuZCBteSBuZXcgY2hhbmdlcyBhcyBmb2xsb3dpbmcuDQogIERldmlj
ZVN0YXRlICpjcHVkZXYgPSBERVZJQ0UoJmEtPmNwdVtpXSk7DQpXaWxsIGZpeCBpbiB2NSBwYXRj
aC4NCg0KVGhhbmtzIGZvciByZXZpZXcuDQpKYW1pbg0KDQo+IA0KPiA+ICAgICAgICAgIGludCBO
VU1fSVJRUyA9IDI1NiwgQVJDSF9HSUNfTUFJTlRfSVJRID0gOSwNCj4gVklSVFVBTF9QTVVfSVJR
ID0gNzsNCj4gPiAgICAgICAgICBpbnQgcHBpYmFzZSA9IE5VTV9JUlFTICsgaSAqIEdJQ19JTlRF
Uk5BTCArIEdJQ19OUl9TR0lTOw0KPiA+DQo+ID4gICAgICAgICAgY29uc3QgaW50IHRpbWVyX2ly
cVtdID0gew0KPiA+ICAgICAgICAgICAgICBbR1RJTUVSX1BIWVNdID0gMTQsDQo+ID4gICAgICAg
ICAgICAgIFtHVElNRVJfVklSVF0gPSAxMSwNCj4gPiAgICAgICAgICAgICAgW0dUSU1FUl9IWVBd
ICA9IDEwLA0KPiA+ICAgICAgICAgICAgICBbR1RJTUVSX1NFQ10gID0gMTMsDQo+ID4gICAgICAg
ICAgfTsNCj4gPiAgICAgICAgICBpbnQgajsNCj4gPg0KPiA+ICAgICAgICAgIGZvciAoaiA9IDA7
IGogPCBBUlJBWV9TSVpFKHRpbWVyX2lycSk7IGorKykgew0KPiA+ICAgICAgICAgICAgICBxZGV2
X2Nvbm5lY3RfZ3Bpb19vdXQoY3B1ZGV2LCBqLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgIHFk
ZXZfZ2V0X2dwaW9faW4oZ2ljZGV2LCBwcGliYXNlICsgdGltZXJfaXJxW2pdKSk7DQo+ID4gICAg
ICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgcWVtdV9pcnEgaXJxID0gcWRldl9nZXRfZ3Bpb19p
bihnaWNkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBw
cGliYXNlICsNCj4gQVJDSF9HSUNfTUFJTlRfSVJRKTsNCj4gPiAgICAgICAgICBxZGV2X2Nvbm5l
Y3RfZ3Bpb19vdXRfbmFtZWQoY3B1ZGV2LA0KPiAiZ2ljdjMtbWFpbnRlbmFuY2UtaW50ZXJydXB0
IiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgaXJxKTsNCj4g
PiAgICAgICAgICBxZGV2X2Nvbm5lY3RfZ3Bpb19vdXRfbmFtZWQoY3B1ZGV2LCAicG11LWludGVy
cnVwdCIsIDAsDQo+ID4gICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlvX2luKGdpY2Rldiwg
cHBpYmFzZSArDQo+IFZJUlRVQUxfUE1VX0lSUSkpOw0KPiA+DQo+ID4gICAgICAgICAgc3lzYnVz
X2Nvbm5lY3RfaXJxKGdpY2J1c2RldiwgaSwgcWRldl9nZXRfZ3Bpb19pbihjcHVkZXYsDQo+IEFS
TV9DUFVfSVJRKSk7DQo+ID4gICAgICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKGdpY2J1c2Rldiwg
aSArIHNjLT5udW1fY3B1cywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9n
ZXRfZ3Bpb19pbihjcHVkZXYsDQo+IEFSTV9DUFVfRklRKSk7DQo+ID4gICAgICAgICAgc3lzYnVz
X2Nvbm5lY3RfaXJxKGdpY2J1c2RldiwgaSArIDIgKiBzYy0+bnVtX2NwdXMsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2LA0KPiBBUk1fQ1BV
X1ZJUlEpKTsNCj4gPiAgICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEoZ2ljYnVzZGV2LCBpICsg
MyAqIHNjLT5udW1fY3B1cywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9n
ZXRfZ3Bpb19pbihjcHVkZXYsDQo+IEFSTV9DUFVfVkZJUSkpOw0KPiA+ICAgICAgfQ0KPiA+DQo+
ID4gICAgICByZXR1cm4gdHJ1ZTsNCj4gPiB9DQo+ID4NCj4gPiBzdHJ1Y3QgQXNwZWVkMjd4MFNv
Q1N0YXRlIHsNCj4gPiAgICAgIEFzcGVlZFNvQ1N0YXRlIHBhcmVudDsNCj4gPg0KPiA+ICAgICAg
QVJNQ1BVIGNwdVtBU1BFRURfQ1BVU19OVU1dOw0KPiA+ICAgICAgQXNwZWVkSU5UQ1N0YXRlIGlu
dGM7DQo+ID4gICAgICBHSUN2M1N0YXRlIGdpYzsNCj4gPiB9Ow0KPiA+DQo+ID4gI2RlZmluZSBU
WVBFX0FTUEVFRDI3WDBfU09DICJhc3BlZWQyN3gwLXNvYyINCj4gPiBPQkpFQ1RfREVDTEFSRV9T
SU1QTEVfVFlQRShBc3BlZWQyN3gwU29DU3RhdGUsIEFTUEVFRDI3WDBfU09DKQ0KPiANCj4gVGhh
bmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KDQo=

