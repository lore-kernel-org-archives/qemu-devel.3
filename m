Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB74C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 03:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEhcd-0005A3-TU; Tue, 04 Jun 2024 23:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEhcb-00059P-F1; Tue, 04 Jun 2024 23:47:33 -0400
Received: from mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c401::3] helo=SINPR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sEhcZ-0002wR-0G; Tue, 04 Jun 2024 23:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5lmuj9eqcA8NYkSxV1BjW8avFMwqIYxB45Ths0RCEA9Js3EuBaeryT3e6PZ9cxgFdIHnQyeskrnYNUXBLYT9bjMmaCR5U9JK3/l87jLTcSswBLZO8aTjTLavCEL3SdaKYPyzXnzcF34Lp1BBSKzAxyJdsBe/+6IlUCjvmnCEIYWRKWrWuKjog4OmM57IoTK1toUab4tyIRcmK9gtU94v2sazwWw90QSVRanYR4Du88GjjK+0l8r/nk23XrSMeYgjYZ2oy09MtHzLULaX8O60XnqW5n8MnWwo42BSZ5DpaWljNw4HkxImz04zY+AlpW/7xGtBwT5pmAZQTHapEAmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z1bEz7ZTZTc99/jWCZ/gm4C0FJZlYcacuryhtV1Avs=;
 b=dTFyWE2wSqIosYUP0YMXnJjZzNi3VzDghlexHj12N88JcO9wjNko9G7BwT9GChlUd9o59+zWc73tAhKj8TRx7qkEZVKm65poLeB+upVmNOusJKlxtVTNnNkE1aULBgxVzIG2DbGnmKKyGSKPpDq5r8bBLk3y87KbWWrEKSi9vKIp2VgbGcO7mouwyG4Apw2hG0iwvZFhhQFMeA7YW3RLzPMHhxonP9x6Vq69yyyfpa1gjmMHqaCxdB0Z/oFtsyr7TDNdt8a4l9qseWg6csJqZq6cBW22OFSwNqMdqK5hnERrKlQBMFiOOhVFeIZ9uOqU4TuM6PGb1Zhlxs6CObu6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z1bEz7ZTZTc99/jWCZ/gm4C0FJZlYcacuryhtV1Avs=;
 b=a+T7zuLfGjh62L5CKgBXH0m3bk3ItkVivBlTi+uj4SryQ6vTkP+dZ7xN/CBwnscPWRs7ic4xMkJllmEUSxbs/gZNl+nLLCQ09V1ub4Mt76ZgjkKtCokAXdXnWlHQZKibAzUsZLAH1yTNeI/uYgm2vMLjRXpJAAw9mYNhFuPmgVRX0oIRVNMqzqzvGdnnvmUkp+Xo+7jxzbR3gxOioksLRkZc1Wrr2zLo01PGvndJzCL65HZBe9J8w+QOfbdP/A5tKh6PsG9O5S87IOfiejv5QH0nOt2C/NFEOYt3EkbL1G1aP7HaUMSjgUXWs51dgsyqW3onnE58b0aeNYHPFu/UXQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6814.apcprd06.prod.outlook.com (2603:1096:101:197::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 03:47:19 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 03:47:19 +0000
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
 <yunlin.tang@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>
Subject: RE: [PATCH v4 00/16] Add AST2700 support
Thread-Topic: [PATCH v4 00/16] Add AST2700 support
Thread-Index: AQHasAw9vuAr/T43PEue8t3w9svr7LGsamWAgAAAoaCAAASJAIAA85HggAsyo3A=
Date: Wed, 5 Jun 2024 03:47:19 +0000
Message-ID: <SI2PR06MB504129FF83B8C6A40A1E87B2FCF92@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <f2c66f47-af78-436b-968c-c267e84b9a18@kaod.org>
 <SI2PR06MB5041C99C448D21D6DB8D8053FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <104095bd-c492-49f2-887b-e97b4a030e5b@kaod.org>
 <SI2PR06MB504156ACED014A5DDB091479FCF22@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB504156ACED014A5DDB091479FCF22@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6814:EE_
x-ms-office365-filtering-correlation-id: a309ab12-724a-4d49-251f-08dc85123357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|7416005|366007|921011|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?T3UrdXJJZG9ibWp5TWhMZ2F6Q1libDFTZlBTR1dMRTR3TGJNcmVSU2E5U3pM?=
 =?utf-8?B?eXd1SHBTVDUrRGowb29jVzlxejkxd3NWaDJ3OHhRaUhaTXlMRG9BN1NFVGQr?=
 =?utf-8?B?OHZOUjl4c2dIT3p3a3VQK1Y4eUpXN0JHVE9yN0hYSnhORjhIV1E0cDlxbUU5?=
 =?utf-8?B?V2FPVTlaMXEyWWVoeGVSNjVIZTdibnhUSFcyTEdVeHZlcW01cDQ3SENQTDFZ?=
 =?utf-8?B?elJhYTRFR2lmMUF5dkZEMS9NbE9lTnJ6RmdGY1cyUExmbkRjZk1UeGFGZnpa?=
 =?utf-8?B?VWVIazNEb2hRL29ISDZsc3JLZmhJVXJzMjh3eEgxRGFTaThVa2xVcFI5MnJD?=
 =?utf-8?B?Nkl5aWZXTWs0WjQvVlpYMUd1TEN5NWU3WU84eXFOMWN5cUlSTWprZWhpdVUr?=
 =?utf-8?B?WUlFK3ZVR3FoSmdzMlErMnVldjdVYXdkbWpEdGQyK1JLMlRsNXYxYXBnNkxw?=
 =?utf-8?B?OEpCVXh4T2hEeWNYZUgydzZ2dVNyMXA0ZS9tWm5XbTdWcVBqTGE3RU1QUm9L?=
 =?utf-8?B?UUVvWWs5SHpvemFQT0NUWXM0T3VsUTNHUnozOS91VmFXVHVnbEc4NnBjcnFV?=
 =?utf-8?B?RCtzUnVwS2M3QzhlZWFyNXRmNDVDMkhYRU9EWUhnU0g1NVI0Qnltam9qaytu?=
 =?utf-8?B?ZE1NaHhaVVNrWUx4cHM1aWs3NDFaakdtaGJmUnN5ZzBORE9tNFhSSm90UkY2?=
 =?utf-8?B?dXJ6eGhQQTg5R2twaEI2OHNNK25tdkQvTXloL2JRTkhoSkZXeTZmeVdXaWlu?=
 =?utf-8?B?RlUycjhLbzloS296QVFXbEJwWGJHK3VVeVRzSEZjbzJJTzdiaXNzVEYrT24v?=
 =?utf-8?B?RnBjVStXQW0xcExwRXJiR0dBTzhQeEhNUlpLa1NiUElBelhqdnBZTTFrTDZS?=
 =?utf-8?B?djJYVnkwNkRUYjlJRUt3ZUFWWTNvTmFDTGFPN09IUGhrQXk1b0o4MUhnbVls?=
 =?utf-8?B?dkhGUnBlS3J3S3RsOEQxZzMyajRZbHE1RjJmck56bVpVWUF4VHBrVUZFMFV3?=
 =?utf-8?B?K1Z3YndqUElha3VWODNKdFJIYmE4aHhRaC9sRjRmQ3g5a2o2Q2p5bDBEbkcz?=
 =?utf-8?B?Y2E2bmp6RnBnK2lWS1BOeVBZUis4VXFVWWxBclNGb21qYnQ5NEtRdlY1WHRS?=
 =?utf-8?B?NUd5YTZYM05UeFBBU2V3VkZjTFdzZ2lldUJ5b2NiTitRamNIL250RjlDOExj?=
 =?utf-8?B?T1RpMkRWODdObHVCQ3lkaExNemwxWlJNemIydGoraDM2OFY5SlIwS0R0WDlV?=
 =?utf-8?B?bFlIVExpV3RjU0ZEOFlNL09XRjl2OVFYVnkvSmxHNEVmK014SW1RZ3Q5VnI3?=
 =?utf-8?B?ZGt3S1JFbEZ6amtkV2kzb3E0U1VzZmlnWVA4RHgrT3YwYkRGcFRhUjR5RHJq?=
 =?utf-8?B?VlJzMCsvOG9QNW9XaXlkVHFDMmgxRE9Nd3lCOUt5YXd0SEFsNVAxRk1veVI0?=
 =?utf-8?B?bE5ZeE9OQStlaVBodjl5MVIzandCZ3ZzS1VyVTAwRVF6a21xclR2MVYrUzl0?=
 =?utf-8?B?eGNuS05XOFNRSVJubTFjVTdRSlIxWEdUZzNpeVFqaThYcXNodkh3djlGMjdS?=
 =?utf-8?B?WjV4QzZNa2dxQVlyU3JXdlo3RnZrZmZLSE95b2JJaG5TbWM1cURiQk9TZ3BU?=
 =?utf-8?B?ZWE1NmI2V1JVbW11QURaM0VURW1aSGVZeXV2eURRZ3dqcm0vUklwSlp1cXZW?=
 =?utf-8?B?THpscEtIK281Uk9sU3k2RzIzRGpxQzVHVzRsTUU2SFlOMmpSL1UvQ2FXeDFV?=
 =?utf-8?Q?nr+rFexpLSw2KsTLa0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFZiVTFDWWxpSDVKd1JhVFRyVUhWZ2FLUDhWbVU2TXpOMGk4c3hWdGpHcTZG?=
 =?utf-8?B?TGhsYnV6S28xb1RXK1hSSlFCUVJkbUw4a1VReFJiVlkzTVBlNGZwS1MwUDNo?=
 =?utf-8?B?Qk1MTHdmL3lpdkNucjhRTEJHWXNQTFdzd0JVbUN1RWhCSFBwQ2IvWDkvM1N0?=
 =?utf-8?B?OG53UGZ4U21lL0dUQnp3RW1obnd2Qm5rdG9CM1ljV25abzcycjRWbjRoRXp2?=
 =?utf-8?B?OUcwTkJGQVFRa1dhWFZJWm1XVndveTJTVjZlODRDYlA4TCtCMTNtUmRwbkxh?=
 =?utf-8?B?bFBVMXVHMWNQVW1WNUNqMkx5bjRnMXRaenorTjJ6b2FyeUQ5b29EQk4ranpk?=
 =?utf-8?B?R0Q0d2RNelh5U3pzWUxzZUxOaDBadVpNNi9OT1MwU1B4Ly93VncxNVRZa0Rt?=
 =?utf-8?B?MXE1empFRERXVTdWL3RJY1NLcEtmNmhxTmFXY0JBMUZWV2VCMVdmSnlvWjkz?=
 =?utf-8?B?Zy9WWUlHMFBFWm1VeUdSb1o2OUdTNC9oclJxalorTXlCTEFHZlZRZGJDYWY2?=
 =?utf-8?B?OHkrZkRIbXowVkRpRzNQOFRLSFFDUWtDY3hnWkJGSUxtcGFDazhhRWFlakY2?=
 =?utf-8?B?VmJwNzVHTnlUR2s1R1kzZ2NrV2hLUmVPbWg5OFRlcVFRbDZzeVJiZXBlMlc5?=
 =?utf-8?B?bTJnZDl0cHJtUm1jbkVsaXgwbEZaSkZvM0ZENUJXTldXVG9WYlp5OFZSUjBt?=
 =?utf-8?B?Z0NQd25ueERjL0RlVGlrejlpZEJtQ0R5TWd2dVdDSmhKOFV5UXhwcXYrcDhI?=
 =?utf-8?B?aFRpSGFuR0QzUkNMY3U5SUJlT1N3U2F3RG56bkNnb09MNW9wUTliV2tsejI5?=
 =?utf-8?B?WXBad1dkWWZmakdjVk1ndktJT1paUWhaM1VBem1paXhxVzJtak9teGZBS1VG?=
 =?utf-8?B?QWQzR0xTTUhnNXpXZTZDamhKTzJ0YmwrRHN6bjJZNUFOMzVuZ3YxWWVkc3RJ?=
 =?utf-8?B?ZlZJWXM5OEJmWkhFQ250dEEweFRqWlpvZ3ZVNVlFZngzN09CdVVVV2M5T0tP?=
 =?utf-8?B?Y3g0ekcreU56NmU3dlBlNkl1Mjg5WDZBZURHSmVTdEx2TGg4M1JlTjdRaTds?=
 =?utf-8?B?VFFIQmdWa3Bhd21Qa2lVQXp3TWxTWVBMTStaYWJKaVNlZlZudVhVN0NBY0tm?=
 =?utf-8?B?dDMzYkd1ZndTUVN1b2R1enNjbjAzRUs4Y1NrZklRWUdTN1hpZ01uT1BHZUhi?=
 =?utf-8?B?bVZjRVROY3h3Nng0YTJiVUJKUEJ2Z2FoWXcrQ3ZTVkxHTE5Vcmd5YlRJNkVN?=
 =?utf-8?B?ZGY0WUEyMkJVUmdMWGFNTXJqWTBVdmNha0xONXB3bG1leS9rcktqb3dlNGZG?=
 =?utf-8?B?VjBid0xJMmY5RlpsRzRreVFVVEd5RFp5NFlJT0J5V2xQSUp0SHQ4WlY1aUlU?=
 =?utf-8?B?Smd5NFUwL1FiUWIxdnJXZkVicVlhWFQxNm92c0ZVY0VMMVd3QVdPTUdNemlq?=
 =?utf-8?B?WnowZEtqZUFzNlhlM1RSUWtnMU0raU41TWd3SzF6cjNlcWs5Vk9sL3BVL1Q5?=
 =?utf-8?B?UG92NzJNRlp6OXN6ME5JSVBZeGk1ZGtTVjI5VUdFOUtJS0hHd1Y0Z3Z2NmVK?=
 =?utf-8?B?aW83N2NVWGlxZUJXWXNla2gzOFdmTG5TYnluUzh2Zktja2hObU8zZExaZndC?=
 =?utf-8?B?VUNxa2V0Mmp5OEZYVlRFc0IwWTIvcDBUREZwWG1RaGpUUExwdHNTNjVVM1Jn?=
 =?utf-8?B?QlJYMm5NN0plQldXMnQ3a204aGpLUWUrRUlxcXZLekVxeG9kdjU0SGNUWmd4?=
 =?utf-8?B?TkVxbXN4YWxMY0xJa3V0V0dvNlhpL2VkTmpCelRpRU5aRk1jbTVWVVJMZFor?=
 =?utf-8?B?RWw5VnVqREwwQmk3YU9NNko1ckR3amhvQ0F3dU0yUUkycEp1S3cwQ2trWnNy?=
 =?utf-8?B?WnROb21mekoyMjI1RzByUGVXNUtqU0IvK3REenZQYVV3OFpzdUVuUmowdi9v?=
 =?utf-8?B?RFZ4ZlduZ1NWeC9vNmkyUmY3cDF6UE94Ky9pTWlZWS9IYkc0NW9BMFp3ZkpD?=
 =?utf-8?B?Z2NTWGszMGZXbGNEenFMSGZRbFo3VE83aWZpT1ZHZGhqNlJTQTJSMEZ4TkE1?=
 =?utf-8?B?M1graHpaNVUxVXpqamZvdWlEdCtZQzJCRmNYaFl6QjJGMC9WOGN4Rnc1NTBm?=
 =?utf-8?Q?HL5i8ZXMMGEHpZ7J6tnWMWaVD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a309ab12-724a-4d49-251f-08dc85123357
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 03:47:19.6579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+CbDQRsYScY5dND1p7jeuEOTub2BPVOIuytTquS93lqjgjOAUg+xZQtE0izpiwjYXxkJBXjIREJqoMkmz4XJU3yGctY/nkpNbpJ5lQe4sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6814
Received-SPF: pass client-ip=2a01:111:f403:c401::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SINPR02CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBGcm9tOiBKYW1pbiBMaW4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2
NCAwMC8xNl0gQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiANCj4gSGkgQ2VkcmljLA0KPiANCj4gPiBG
cm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+IE9uIDUvMjgvMjQgMTI6
MDIsIEphbWluIExpbiB3cm90ZToNCj4gPiA+IEhpIENlZHJpYywNCj4gPiA+DQo+ID4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiA+ID4+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwgMjAyNCA1OjU2IFBN
DQo+ID4gPj4gVG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIg
TWF5ZGVsbA0KPiA+ID4+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVy
eQ0KPiA+ID4+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpv
ZWxAam1zLmlkLmF1PjsNCj4gPiA+PiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFp
cjIzLm1lPjsgQ2xlYmVyIFJvc2ENCj4gPiA+PiA8Y3Jvc2FAcmVkaGF0LmNvbT47IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz47DQo+ID4gPj4gV2FpbmVyIGRvcyBT
YW50b3MgTW9zY2hldHRhIDx3YWluZXJzbUByZWRoYXQuY29tPjsgQmVyYWxkbyBMZWFsDQo+ID4g
Pj4gPGJsZWFsQHJlZGhhdC5jb20+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5v
bmdudS5vcmc+Ow0KPiA+IG9wZW4NCj4gPiA+PiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPiA+PiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVl
ZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPiA+PiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5j
b20+DQo+ID4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMC8xNl0gQWRkIEFTVDI3MDAgc3Vw
cG9ydA0KPiA+ID4+DQo+ID4gPj4gSmFtaW4sDQo+ID4gPj4NCj4gPiA+PiBJIHRoaW5rIHlvdSBz
aG91bGQgYWRkIHlvdXIgc2VsZiBhcyBhIFJldmlld2VyIHRvIHRoZSBBU1BFRUQgQk1Dcw0KPiA+
ID4+IG1hY2hpbmUgaW4gdGhlIE1BSU5UQUlORVJTIGZpbGVzLiBXb3VsZCB5b3UgYWdyZWUgPw0K
PiA+ID4+DQo+ID4gPiBBZ3JlZS4NCj4gPiA+DQo+ID4gPiBDb3VsZCB5b3UgcGxlYXNlIGFkZCBt
ZSwgVHJveSBhbmQgU3RldmVuIGluIHRoZSBNQUlOVEFJTkVSUyBmaWxlcz8NCj4gPiA+IHN0ZXZl
bl9sZWVAYXNwZWVkdGVjaC5jb20NCj4gPiA+IHRyb3lfbGVlQGFzcGVlZHRlY2guY29tDQo+ID4g
PiBqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20NCj4gPg0KPiA+IFlvdSBzaG91bGQgc2VuZCBhIHBh
dGNoIHVwZGF0aW5nIHRoZSBNQUlOVEFJTkVSUyBmaWxlIHdpdGggbmV3IG5hbWVzDQo+ID4gYW5k
IHRob3NlIHByb21vdGVkIHNob3VsZCByZXBseSB0aGF0IHRoZXkgYWdyZWUsIG9yIG5vdC4NCj4g
Pg0KPiA+IFNlZSBodHRwczovL3FlbXUucmVhZHRoZWRvY3MuaW8vZW4vdjkuMC4wL2RldmVsL21h
aW50YWluZXJzLmh0bWwgZm9yDQo+ID4gbW9yZSBpbmZvIGFuZCB0aGUgZ2l0IGhpc3Rvcnkgb2Yg
TUFJTlRBSU5FUlMgYWxzby4NCj4gPg0KPiBXaWxsIHNlbmQgYSBwYXRjaCB0byB1cGRhdGluZyB0
aGUgTUFJTlRBSU5FUlMgZmlsZS4NCj4gVGhhbmtzLUphbWluDQo+ID4gVGhhbmtzLA0KaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjQwNjA1MDM0NDEzLjEwNjQ4NDUtMS1qYW1pbi5fNUZsaW5A
YXNwZWVkdGVjaC5jb20vDQpUaGFua3MtSmFtaW4NCg0KPiA+DQo+ID4gQy4NCj4gPg0KDQo=

