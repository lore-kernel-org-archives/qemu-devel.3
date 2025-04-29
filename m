Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6E1C369D5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 03:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9bCc-0001LU-PE; Mon, 28 Apr 2025 23:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u9bCV-0001CN-Bb; Mon, 28 Apr 2025 23:00:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u9bCS-000867-Fs; Mon, 28 Apr 2025 23:00:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9d0pJ/d39mOPJ1NXIhrCgoZvKJvRAt92aX6veb407qKIpNmez7/n42co+OPtTTKnwYIwew4iVnvdJlffBXlTGfJ9kEfV8We/2wksPfBzbjqDGraIXsGq6hy/fjT/7qVBOagF/n2dAdPMbsI4+czmH9B2LaYgQ5vHJyEUwoeeMMjuGFXBDgrwHpS2e4I0iCfUgAAzjUVssbJceY/QzveUyrt6jsg1C7RwDuQQ6yp8QO/ci2cfgerzOSrS5LHnzPfEGJv6zGH3gaXTGGhHTqRL96Zlunt/P+cgw8wjkGYWWM22uiDSx/5IDSeUA5NXVZ9fZ/ZUiVxS0RiP/cwML/jnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDQ1miu90gLoo/0o8u05p0b+o+LBhU7423GMxczX+q8=;
 b=zHdvIXrc+MWNmMcO/ruWZZU3Apftoyis/H17Y5i4ij/z5ovVVfU4G+Ye3/U9qdJ4157b12fTkKJRuxLMYxejnaG+0H5l4EwTrr9E9dwdmOw9qIwo1Qk32gRO3/aiUZ0MIL4oOIGxtvLQ0NqjwM5m9rIQobaW6MrkfyVn8BFPJUuQqNU+AUUHmpY46WnltjoJ6Wab0QRgmYMmNi9CPJ+v3/YgDHtbbxip6JMgLIBJ6yd7yJHYY6YzR/XyqEL84ZxH/ADG6cJdwgu4B3ebTlYV8XaUUd+OKtOsRtaX1aSyhWMepaDWl5pyipjVBJEa2/IJsTUhs5Dk4KMvnttU/Aerfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDQ1miu90gLoo/0o8u05p0b+o+LBhU7423GMxczX+q8=;
 b=KRnNobLgfH8i3W5Ic78alVbRLmiddPXRCOgsIfyPUCB52mvVLYLkOLe2QiJnhcUYuuUedodmK1cBWb0lyQt6a9Namv+jdFjvY1E2tFavF9L+7/CUugWhb/VCeLj8NMFcLLSGqV5piPP8YE3jjFddSqy/Nq+wcOecO+ZtTJ/y0CzCC8IykLYeIMrcpd8S844YYq5GxV9Jeoj9TbzHwXt479PSBBOSOR44K9FaACb21VNHuEAN5zYsinC6DkJnRiQlnTEBT5e/pvQxwmAcFj3X3gZbNHOeqs2yxej5TflwqxOTKMJLLgwH6sEack32d2NIo1tQlWLon6cxGSRJZ5+NYw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SE1PPFC3CEFDAC0.apcprd06.prod.outlook.com (2603:1096:108:1::429) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 02:59:49 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 02:59:49 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 3/3] hw/arm: Integrate Aspeed OTP memory into AST10x0
 and AST2600 SoCs
Thread-Topic: [PATCH v3 3/3] hw/arm: Integrate Aspeed OTP memory into AST10x0
 and AST2600 SoCs
Thread-Index: AQHbs/tcXU6vRffvC0+zacS0f0KZJ7O4ueyAgAALyLCAACv3AIAA6XjQ
Date: Tue, 29 Apr 2025 02:59:49 +0000
Message-ID: <SI6PR06MB76310DFCE06AC5FB55CD3AE6F7802@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250423025651.189702-1-kane_chen@aspeedtech.com>
 <20250423025651.189702-4-kane_chen@aspeedtech.com>
 <e3d35357-de8c-44da-b54e-7ec2761f513b@kaod.org>
 <SI6PR06MB76317C8FAC3EBF18AAF632ECF7812@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <2a85d0c5-0606-411d-b8c5-4b8806182384@kaod.org>
In-Reply-To: <2a85d0c5-0606-411d-b8c5-4b8806182384@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SE1PPFC3CEFDAC0:EE_
x-ms-office365-filtering-correlation-id: 43ee7a35-08ae-47d9-6bfd-08dd86c9e7ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGR0azJsMEZjd1R3ZGQyUk16YUIzdVNUb0dhaFZNZlhRUGFqTzhPTzVOeTlN?=
 =?utf-8?B?d215ZHRvbmNNQnpNUnJzbUh6ZDFzQlcxb0t2MFprMHVxMS9yOXJLc2R5WStr?=
 =?utf-8?B?b0t4Qk05VE1ZZG9PYWFiNE96SW0xZEJxemRKQ01hOGtDNkY1UktEMFJJZXky?=
 =?utf-8?B?dXR0ODlzb2dJeVJKTjJTUFE2dWNYaFRXTFF2eDQ0eVhBUVd5SEtKaDFmWjR6?=
 =?utf-8?B?Q2JLU1ljZDRld3k2R0lOL0VxMFRCdEtEamtUcGFaN2dpbmJ1Vysrb1p5SW1U?=
 =?utf-8?B?MXNZbHJodWYyRTRwYllJTHB2RCtCVk44b1NzK0VpV0RqVTdZeVEzVzEwdHJx?=
 =?utf-8?B?VGVROEMwR2ZXQ3dhczhuOEpRRWpKeWlXUkl4K1ZoNU1zZ1ZMNVE2Tjg2b3R0?=
 =?utf-8?B?bUU2OU1HOXgrUmFWOW9HamFKVEtCV0ppenlMd2QrbWZ2dXRFZG9zVm1JRG9z?=
 =?utf-8?B?Y3VlN283a1d6RVkxQkE2SGVhWDZsRXlkcWxTZDh6ZEV3Tmk3aUNBNDY5K3A4?=
 =?utf-8?B?VTQrek1BczlnYVRzeWdmUXdoblcrZmlIbTFTbUhLUS85TDhOVlVqcENLMDZk?=
 =?utf-8?B?WWZHb0VHZkYyMzhJd1ZLU3JFZkpiQTlkd01FNEZOa2RMbEZQbWZWTWhWRWFU?=
 =?utf-8?B?UUFpQTh6WjVLaVRib21PNCtLZ1lrdzA3RUpSV3ozVUpOWHdnd2NLVS80b2M2?=
 =?utf-8?B?di8vVEs2K2d3ZDhOVnhFYVdNTVExaU1KeWxod1hUQzkrUkZ6SG8weExCcjJk?=
 =?utf-8?B?UHoxT1ZrZnMrbUZnZHdROXRlMUE2UzhOYmhUUEVYdklHM1FlTlZaTGVBNkdY?=
 =?utf-8?B?WndpeVF0UXdpaFFmelVwZGNxMzhoZ054cUFxb2gwVk9jbXk0YlVMLytSR3pj?=
 =?utf-8?B?RmozVUtjc21PWStMTHkweERaQzNKY1hPTSsxYy84UVZUN1NJWUtSQVZZdkFj?=
 =?utf-8?B?akFqTW5lSmRpb2c1VUlBbXFDeThpZDRWd2xnZ3R3d0thVHhxbEdhN3R5SzYw?=
 =?utf-8?B?bEh5Zk9aZ0R0MGRDMVlZVzBqU1hyRnM3VzFMeU1Oc1p5TmxnV3lXS2hYNkJX?=
 =?utf-8?B?NXNvd0xNNnI1YVE5WW50ekdPMWc2OWdlU0g1cER5M1A0aEl3SnVsWkVGekov?=
 =?utf-8?B?cFhjYU9HekRDUlBGY0p6eWF4UnJnUDFCSCt6akdjWk5RVXRIcFNGb1h4MDVa?=
 =?utf-8?B?MGEwWnR1dk9YaUJiRFp6bzliMWhOS2JEUnMrK2NLbE9La3M4TkhzaTJmTVBH?=
 =?utf-8?B?d09UQWVlNWwwVFExTHp6UkJrN1lORklRZWgvalNXSkZMZmN5OFhoUVZoaGJh?=
 =?utf-8?B?T0t2eUVGZXM1SHVJa0laUDdzRmJOaDNDMTE1UXdIenRWeVRBVFZkZGJOMENI?=
 =?utf-8?B?a1NGbWNvc0VhRVNiQ2k2TjN0U1JabVdkZ2xCVG52OW42M3NTRlc5QmJZVWpv?=
 =?utf-8?B?ZmdvTjRDZTdoSHE3QkdaM2ZqRUVGYzFMK3hWR1BqQTFrVFd4SkdzckIxYWcz?=
 =?utf-8?B?cGhSSjA5OVllMnRzOFdydkRNQWtPV2RTRXkyK2R5bEhXVEtWNlQyZmRLUGJt?=
 =?utf-8?B?dVdHVTRnVGxiakpVV2RCQXZ4anY3ejJhV3RLNXpmRVFrWEpYSkJoUVlLNnYx?=
 =?utf-8?B?SVVCOTZra2FCaUYxSW16NWhoeGR2L1VQNmsveTRmQXJrbDJNdUFqMDcxay94?=
 =?utf-8?B?M2JNZGhOV2pSNUEyTTZ3TGY0U09JSHdaOEN1R0o3VFc0ekowQnRoelpEOFRI?=
 =?utf-8?B?VTc1VEpTS0FNa3ZuVlNvKzhCeXhKQlExaGJsaW5NcG5yeXZkNDhYb2NTeThZ?=
 =?utf-8?B?WGp3Q3VzVjBQMlNCUVlaZVFOWm80b01xNkl0Q2Z6TmVVSEFKSldySk5Tcmoz?=
 =?utf-8?B?cHBBK1RLajBNbVVVWVkybkZ4U1VaTGxjNUhMcG8rSCtZRTUwYVVnM0R0NGlo?=
 =?utf-8?B?Wi9Obk1rRjVkUVJZZTIwMy9odkpkWXcwR2pwc3p1KzBmajQ5aEovQTVxdC9Y?=
 =?utf-8?B?eVRBdVBEWGNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWUwRkVmaXhvNDFIQ1ViN1F1VjNIdGFtMFJUQi9MazZ5MndlNDJkajV3UHpC?=
 =?utf-8?B?Mi9XbUFPcjFHMDJEWkQ4UUhLcGhFelNPWXRjd1JwZXVHb3pUcXdxYm81SHdZ?=
 =?utf-8?B?R2hLU2xvdUN2YUwrMUNkTEZ3T0YxamVTNEg1ZGMyaGExUnhpcTFjUTVCT3F2?=
 =?utf-8?B?WWZjaDF5ZWE2UkRYSjhJcEFhUFU4RzlOZVBiSUEvSnltMUoxZmsvS1VTZmpz?=
 =?utf-8?B?NXgyS2tMT093Z2kyVEhOOU1ZOW5NWEY3UDliMnRyWU9OVkc4cnhjMWZvU01a?=
 =?utf-8?B?YUMrT0prM0FNZi9OMGh2cFNseGVSZ2kwc0dWNGNtQzhQLzNLZzBITStqTFp3?=
 =?utf-8?B?SUdCc3RjOGJsNzVUMzZkYzNaL3dseTcvSDlZc3R3QitXTkI1ZVduTEsyOXJ3?=
 =?utf-8?B?QkptakdNT0ZraVpnUGppOW03SGhQbFRWUW4wMSsrbFNHU01TVmY4eGRmSjFi?=
 =?utf-8?B?R1IxQVJqaDJoenQ0bkR3TW04SGVtanRqQlpNMllFOHp4ZGJxNGsrQVhlczlW?=
 =?utf-8?B?am1yaGNRRHlFN0lqQksxcU1QeE5MVndZNWFuQlVPbGRuUGdFNEJOUHMwbWxR?=
 =?utf-8?B?aGhkcGVyVDdKKzNoSEorTk1YUlhCSTJXRkwxRkR1MWxobDlJTVoxQnQvZFg1?=
 =?utf-8?B?ZU50MlFjTTlwa3JzMSsxU09sbms1TUR2cldqQjF2WTZlU3FZMUxKMzBFNFdi?=
 =?utf-8?B?N2l2bjc2d1dKSkxJSXpTK0JQUHhRcVRDVnFIdUJiaVJ2dEhSTHJDSTZNM1Z2?=
 =?utf-8?B?YmhtSStra0RwME1SOHV2TEcxYWJPTDFNZFNEMnNjZW1zd2U3NWR5VHBkYjVR?=
 =?utf-8?B?WmJQU0VSSGRRaXdvVHFvQWFNZGdXN0FNU1pwbU90R1UvcjkxOFprMTBPVjhm?=
 =?utf-8?B?ai9md3VFZGlZQmRYc3pjQlBsT3cybjNNTXJiVUdCa1R2TmpDVlluS1FUODV1?=
 =?utf-8?B?RTlEZ1pERXRqWlNyb1pqU1V1ZzNsQXMvR3Z1RXJsaVlidW40SWc0akMzaG04?=
 =?utf-8?B?WEFjelMxUnlFMWFCOGREVXFmNWM4eXRZZTRWcHFTRW0zMEt6SGhTcDczNmcz?=
 =?utf-8?B?TStTVzA5aVBtNVVqMUtUdTV4OXBQZ3EzZGp2aU5hNXNoNTgyZE84Z1VRMEtQ?=
 =?utf-8?B?RFpURlNZY3RkQWdKbFRMVEl4Z1YxWFdDRm5QRStWZlBjcTFQZ2t1d3lPVFRQ?=
 =?utf-8?B?YzJPMzR1N2NtSnhIay9JNEx1VkIwSmFGRHFaemhYQ3JtLzFWMzNIdXJWZHRK?=
 =?utf-8?B?UHdrWWF4Q2dwVWx6Q1Y3eHJldnlZYnUzWWhXaUh2aUNOTjZ6L3RsVzM2VjlD?=
 =?utf-8?B?bnBNVzl2ZUhiUkpXVllMakNZMVgzejVmTXVIMWJWZHBnNkhSQzVsc1dnVGpD?=
 =?utf-8?B?WU81a3FyQ29lbjRFcDFEM28rNmRtTDZXdzJ0Y3dwaFZQeXhKWE5iMmovcHc2?=
 =?utf-8?B?WG9MdDZ0OXJmeVArMVBvTFVaVHZaakVKMkl1SkRNdFZXMzd3SFlQeFZPZm5k?=
 =?utf-8?B?aURIcXFYaHNKam9acGQzUnRxTU94YitUUE5TS3puZ0lSd2s4SE0rNGE1TzdK?=
 =?utf-8?B?QUNOTzIwYkwyd1VxSDhQb3lLa3o3YWpFTFRNVm9ybG1meEdkaHBpUjE5MTZP?=
 =?utf-8?B?VjZWSVQ4Q3pMcjN6dzAraStWNFZUcWFJcE5oQ2tET1JHV2VGNldtOHhVb2NI?=
 =?utf-8?B?S3JyQXAvUis1ZnZpYnRoYlM2RllRekFhbjhuM2tqZGpwVEdCQmhyTGJrdEhY?=
 =?utf-8?B?YTJYUlJnUlljbkhBcVByZG95K3RzVzN6SFFsMnpUalZxZm1YMWVGWmcrWk9m?=
 =?utf-8?B?STVnRjVPUzFnaHVnUlo1OFM3eWxrazh2WWpYelZDdTVnZ2tBRzRmSjlFVVY5?=
 =?utf-8?B?SkJsYVg5WDE4bjlsaisvTW9XNG1FSHN3cmpSc1VndUlYTG1TOWM2R2hpOEp1?=
 =?utf-8?B?NHVGMWo2ZWcrQmFobEFmZzdBWlA1SUN3MHBRbFB2TmtPaUZpaU9IbDBveklk?=
 =?utf-8?B?Sm1WbSswRkxQNnV0RDRoUnJ6bXlvYldjWnFwRnFvMXdLQjMyWWhyb0xBRldN?=
 =?utf-8?B?ZnZXeDI2YU1UTWNGeXdudkdUR1RNN1NBeEtEdktIUGZMN0d6RWZYUElQamdz?=
 =?utf-8?Q?5YTfqzSvGihReL1Y8By+ujGhD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ee7a35-08ae-47d9-6bfd-08dd86c9e7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 02:59:49.3991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0DzqMSk1nkpRuiavxhHY/gEaWsq1hQD6QcfBZdbcydjNu7dRzY/bppFu8jwZh1DB8MUKwtzc0oBPTCc4rC/4ERSN12r0Bdp4lG2i3g2ypQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFC3CEFDAC0
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KSSBtYXkgaGF2ZSBtaXN1bmRlcnN0b29kIHRoZSBvdHBtZW0gbWFjaGlu
ZSBvcHRpb24uIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9y
Zz4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAyOCwgMjAyNSA3OjAxIFBNDQo+IFRvOiBLYW5lIENo
ZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+
OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBh
c3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5j
b20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVF
RCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhl
cmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBh
c3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzNdIGh3L2FybTogSW50
ZWdyYXRlIEFzcGVlZCBPVFAgbWVtb3J5IGludG8NCj4gQVNUMTB4MCBhbmQgQVNUMjYwMCBTb0Nz
DQo+IA0KPiBIZWxsbywNCj4gDQo+ID4gSSB1bmRlcnN0YW5kIHRoYXQgdXNpbmcgYSBtYWNoaW5l
IG9wdGlvbiAoZS5nLiwgLU0NCj4gPiBhc3QyNjAwLWV2YixvdHBtZW09eHh4KSB0byBzcGVjaWZ5
IHRoZSBPVFAgbWVtb3J5IGRyaXZlIGlzIHNpbWlsYXIgdG8NCj4gPiB0aGUgbW9kZWxpbmcgdXNl
ZCBmb3IgZmxhc2ggZGV2aWNlcyBpbiB0aGUgUTM1IG1hY2hpbmUuIEhvd2V2ZXIsIGluDQo+ID4g
dGhlIHJlYWwgQVNQRUVEIGhhcmR3YXJlLCB0aGUgT1RQIG1lbW9yeSBpcyBwaHlzaWNhbGx5IHBh
cnQgb2YgdGhlDQo+ID4gU2VjdXJlIEJvb3QgQ29udHJvbGxlciAoU0JDKQ0KPiANCj4gU28gdGhp
cyBhcmd1bWVudCBpcyBhIGdvb2QgcmVhc29uIHRvIGxldCB0aGUgQXNwZWVkIFNCQyBtb2RlbCBv
d24gdGhlDQo+IG90cG1lbSBtb2RlbCBhbmQgbm90IHRoZSBTb0MuIEl0IGZpdHMgYmV0dGVyIEhX
IGRlc2lnbi4NCj4gDQo+ID4gYW5kIGlzIG5vdCBkZXNpZ25lZCB0byBiZSByZW1vdmFibGUgb3Ig
c3dhcHBhYmxlLg0KPiANCj4gWWVzLiBUaGVuLCBpbiB0aGF0IGNhc2UsIHlvdSBzaG91bGQgcHJv
dmlkZSBhIHN0YXRpYyBhcnJheSBvZiB1aW44dF90IGRlZmluZWQgYXQNCj4gcmVzZXQsIHdoaWNo
IHdhcyBteSBmaXJzdCBzdWdnZXN0aW9uLiBCdXQgeW91IHNhaWQgeW91IHdhbnRlZCB0byBiZSBh
YmxlIHRvDQo+IGNoYW5nZSB0aGUgaW5pdGlhbCB2YWx1ZXMuIEkgYW0gYml0IGxvc3QgaW4gd2hh
dCB5b3Ugd2FudCB0byBhY2hpZXZlLiBQbGVhc2UNCj4gZXhwbGFpbi4NCkluIHRoZSBIVyBkZXNp
Z24sIHRoZSBPVFAgbWVtb3J5IGNhbiBiZSB1c2VkIHRvIHN0b3JlIHRoZSBjaGlwIElELA0Kc2Vj
dXJlIHNldHRpbmdzLCBvciB0aGUga2V5IGZvciBzZWN1cmUgYm9vdC4NCg0KVGhlIGluaXRpYWwg
dmFsdWUgSSB3YW50IHRvIHNldCBpcyBzb21ldGhpbmcgbGlrZSB0aGUgY2hpcCBJRCwgd2hpY2gN
CmlzIGEgZml4ZWQgdmFsdWUgZm9yIGVhY2ggY2hpcCBhbmQgc2hvdWxkIG5vdCBjaGFuZ2UgYWZ0
ZXIgcmVzZXQuDQpUaGVyZWZvcmUsIEkgcHJvdmlkZWQgYW4gQVBJIHRvIHNldCBkZWZhdWx0IHZh
bHVlcywgc28gdGhhdCB0aGVzZSB2YWx1ZXMNCmNhbiBiZSBjb25maWd1cmVkIG1vcmUgZWFzaWx5
IGR1cmluZyB0aGUgU29DIG9yIFNCQyByZWFsaXplIHN0YWdlLg0KDQo+IA0KPiBJZiB5b3Ugd2Fu
dCB0byBiZSBhYmxlIHRvIGNoYW5nZSB0aGUgaW5pdGlhbCB2YWx1ZXMsIHlvdSBuZWVkIHRvIHRh
a2UgaW50bw0KPiBhY2NvdW50IHRoZSBRRU1VIHVzZXIgaW50ZXJmYWNlIGluIHRoZSBkZXNpZ24u
IEJlaW5nIGFibGUgdG8gZGVmaW5lIHRoZQ0KPiBvdHBtZW0gYmFja2VuZCB1c2luZyBhIGJsb2Nr
ZGV2IGlzIGJldHRlciBmb3IgdGhlIGxvbmcgdGVybSBzdXBwb3J0Lg0KPiAnLWRyaXZlJyBpcyBh
IHBvb3IgaW50ZXJmYWNlIHdlIHdvdWxkIGxpa2UgdG8gcmVtb3ZlLiBXaGF0IHdvdWxkIGhhcHBl
biBpZg0KPiBhbm90aGVyIGRldmljZSBvZiB0aGUgbWFjaGluZSBuZWVkZWQgYSBmb3JtYXQ9cmF3
IGRyaXZlID8gaG93IHdvdWxkIHRoZQ0KPiBkcml2ZXMgYmUgYXNzaWduZWQgPyBkZXBlbmRpbmcg
b24gdGhlIGNvbW1hbmQgbGluZSBvcmRlcmluZyBsaWtlIHdlIGRvIGZvcg0KPiBtdGQgZHJpdmVz
ID8gOi8NCj4gDQo+IEFueWhvdywgd2lyaW5nIHRoZSBibG9jayBiYWNrZW5kIHRvIHRoZSBkZXZp
Y2Ugb2YgdGhlIG1hY2hpbmUgaXMgTGV0J3MgZmlyc3QNCj4gc3RhcnQgYnkgZGVmaW5pbmcgdGhl
IGJhc2ljIG1vZGVsLg0KSSB3aWxsIG1vdmUgdGhlIGJhY2tlbmQgdG8gdXNlIGJsb2NrZGV2Lg0K
SSBwcmV2aW91c2x5IHRob3VnaHQgdGhhdCAtZHJpdmUgaW50ZXJuYWxseSBjcmVhdGVkIGEgYmxv
Y2tkZXYgYmFja2VuZCwNCmJ1dCBJIHVuZGVyc3RhbmQgbm93IHRoYXQgaXQgYWxzbyBpbnRyb2R1
Y2VzIG90aGVyIGlzc3Vlcy4gVGhhbmtzIGZvcg0KdGhlIGNsYXJpZmljYXRpb24uDQoNCj4gDQo+
ID4gQWxsb3dpbmcgdXNlcnMgdG8NCj4gPiBzcGVjaWZ5IHRoZSBPVFAgbWVtb3J5IHRocm91Z2gg
YSBtYWNoaW5lIG9wdGlvbiBtaWdodCBpbXBseSBvdGhlcndpc2UsDQo+ID4gd2hpY2ggY291bGQg
YmUgbWlzbGVhZGluZyBjb21wYXJlZCB0byB0aGUgYWN0dWFsIGhhcmR3YXJlIGJlaGF2aW9yLg0K
PiBJIGRvbid0IHVuZGVyc3RhbmQgeW91ciBwb2ludCBoZXJlLiBQdXR0aW5nIHRoZSBvdHBtZW0g
bW9kZWwgdW5kZXIgU0JDIGZpdHMNCj4gYmV0dGVyIEhXIGRlc2lnbi4gUGxlYXNlIGV4cGxhaW4u
DQo+IA0KPiA+IFRoYXQgc2FpZCwgaWYgbWFpbnRhaW5pbmcgY29uc2lzdGVuY3kgd2l0aCBRRU1V
4oCZcyBkZXZpY2UgbW9kZWxpbmcNCj4gPiBwcmluY2lwbGVzIChhcyBkb25lIGZvciBmbGFzaCBk
ZXZpY2VzKSBpcyBwcmVmZXJyZWQgb3ZlciBzdHJpY3QNCj4gPiBoYXJkd2FyZSBtb2RlbGluZyBm
aWRlbGl0eSwgSSBhbSB3aWxsaW5nIHRvIGFkanVzdCB0aGUgaW1wbGVtZW50YXRpb24NCj4gPiBh
Y2NvcmRpbmdseS4NCj4gDQo+IFFFTVUgaXMgYW4gZW11bGF0b3IuIFdlIHRyeSB0byBhdm9pZCBt
b2RlbGluZyBzaG9ydGN1dHMsIGJ1dCBmb3IgdXNhYmlsaXR5IGFuZA0KPiBjb21wbGV4aXR5IHJl
YXNvbnMsIHdlIHNvbWV0aW1lcyBkby4NCj4gDQo+ID4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGNv
bmZpcm0gaWYgeW91IHN0aWxsIHByZWZlciBmb2xsb3dpbmcgdGhlIGVkazIgZmxhc2gNCj4gPiBt
b2RlbCBmb3IgT1RQIG1lbW9yeSwgZGVzcGl0ZSB0aGUgc2xpZ2h0IG1pc21hdGNoIHdpdGggaGFy
ZHdhcmUNCj4gPiBiZWhhdmlvcj8NCj4gDQo+IEFGQUlVSSwgdGhlIGN1cnJlbnQgcHJvcG9zYWwg
aXMgbm90IG1hdGNoaW5nIEhXLiBQbGVhc2UgZXhwbGFpbiB0aGUgbWlzbWF0Y2guDQpUaGUgU2Vj
dXJlIEJvb3QgQ29udHJvbGxlciAoU0JDKSBpbmNsdWRlcyBzb21lIGNvbXBvbmVudHMgbGlrZSBP
VFANCm1lbW9yeSwgY3J5cHRvIGVuZ2luZSwgYm9vdCBjb250cm9sbGVyLCBhbmQgc28gb24uIEFs
bCBjb21wb25lbnRzDQp3aXRoaW4gdGhlIFNCQyBhcmUgZml4ZWQgYW5kIGNhbm5vdCBiZSBjaGFu
Z2VkLiBJZiB3ZSBhbGxvdyBhbiBvdHBtZW0NCm1hY2hpbmUgb3B0aW9uLCBpdCBtYXkgaW1wbHkg
dGhhdCBkaWZmZXJlbnQgdHlwZXMgb3Igc2l6ZXMgb2YgT1RQDQptZW1vcnkgbW9kZWxzIGFyZSBz
dXBwb3J0ZWQsIHN1Y2ggYXM6DQoNCiogRGlmZmVyZW50IHNpemU6IC1NIGFzdDI2MDAtZXZiLG90
cG1lbT1vdHBtZW0tNjRrLWRyaXZlDQoqIERpZmZlcmVudCBtb2RlbDogLU0gYXN0MjYwMC1ldmIs
b3RwbWVtPWZsYXNoLWRyaXZlDQoNCkhvd2V2ZXIsIGluIHRoZSByZWFsIGhhcmR3YXJlIGRlc2ln
biwgdGhlcmUgaXMgb25seSBvbmUgZml4ZWQgbW9kZWwNCmZvciB0aGUgT1RQIG1lbW9yeS4gQmFz
ZWQgb24gdGhpcywgSSBhbSBub3Qgc3VyZSBpZiBpbnRyb2R1Y2luZyBhbg0Kb3RwbWVtIG1hY2hp
bmUgb3B0aW9uIGlzIGFwcHJvcHJpYXRlLg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQpC
ZXN0IFJlZ2FyZHMsDQpLYW5lDQo=

