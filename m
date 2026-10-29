Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB60606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=c+Rs/A5U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJZ3-0003aL-8M; Thu, 29 Oct 2026 02:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMJYX-0003Zo-Rq; Thu, 29 Oct 2026 02:24:12 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMJYT-0003qa-6y; Thu, 29 Oct 2026 02:24:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXduEUJw0jgvY7tAaaPcvLQr1TFxePgC3xKkrpg17MxYl44R4QQQdMqcXzMEhHKa/DT4/Ji6Tm25zP4CzxUTa+va0/qXnZowJc95K67wM71a7YL0kDBUU5jaItXKtp+OQaBiiTKH1zFyP/tSqWustyHIqLwyEyeeC05+TvDxu+kKYLJMi2HGGtG3UiukwYniJWaDtqRnX5euu4F5UlB1+0r6IpcTz7N87PG8QRHMKsofUOkNJFsRMgNrHMunGp6YEbJfcNwjT/6j3neZbZv77pTbMy4RxgvhOyz6QtYCMBnB2FqPn0jofzvueL0sbf/jPRre6WaFsNYMWbpa0xbKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOQmg4ueB7wNXI+leCACTv4pFmDc59BAZJlUDTTfdn4=;
 b=yiDXkZvSi3PIGIrWXU3Y35E4o/mMkDGRUkvTHITEatYZstHNNAZ8yLmblV2vvwnqLPFlFhLPbfw5LHZhVlOgGaAOKmo7yPIVPsAI1lYTpZVw4VJ9zIeakqbUH0kvsoJ7fWBXwYF/dyGhQDbMbtG7sYAAARqDQ15HMSiCE+vcXR/YTSzh38iVEtqPc3xZ+0GyBl/b3oi4OXL3t0ZdNwU2q/IY0pU1FZKKq8Cvosh4/mfw7brwCSfNX/9JWlLLj6/PQ3rphVTwJNbi1H4tNSahFhbF577d/qIZZpCOSD3bc5ugx/KZDBeXLCWUS272XVZIdpnZs4tBaDWO31IyrydEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOQmg4ueB7wNXI+leCACTv4pFmDc59BAZJlUDTTfdn4=;
 b=c+Rs/A5UW0tYDhYZyjY6FUwkB/GtRkijnWklB6s48XYA1fgyyOvZNYBMdK55MiK1PaxNQF9IpaxTOfYg2GtE7doKWtjFXjSLRBysK+xmfJV+9IdC7nMRmsA61NVOiD4Y3JlVbVJI6sGc+La6nNIMy444qAIunRoabDMY9KDm2GOO4U5qD1QSbx7XOx7OQWqV9rjtkdpYQ+3zkD346K+Xo1qMdtNlQugCJTFNb9BNOqhxUVjuOhIa/aklDPfZaAMIedK1lIO0GXjOQfdu6cOjjt5X0d1E5JXRw95QugMrJK2GHqZ+lFSE6rAKhTGwK0kvCJ1ikupVAG4YyRMZmnyVWQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5420.apcprd06.prod.outlook.com (2603:1096:400:200::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 06:23:56 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 06:23:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Timur Maksimov
 <gessingate@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Subject: RE: [PATCH v2 5/6] hw/i2c/aspeed: fix DMA transfer in non-packet mode
Thread-Topic: [PATCH v2 5/6] hw/i2c/aspeed: fix DMA transfer in non-packet mode
Thread-Index: AQHdZky3gZX2jygQoEyijzZ4Wx1g1LcTezMAgACUHTA=
Date: Thu, 29 Oct 2026 06:23:55 +0000
Message-ID: <SEZPR06MB7362625BE5872FF0DA32549CFC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-5-07deed1dff60@gmail.com>
 <d804bfa0-c44d-4f52-b647-f7e8b8c7201c@kaod.org>
In-Reply-To: <d804bfa0-c44d-4f52-b647-f7e8b8c7201c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5420:EE_
x-ms-office365-filtering-correlation-id: 794b691a-d814-42c4-ab46-08df358535d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|4143699003|56012099006|22082099003|18002099003|10067099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261028144727099003|261009220027099003|261009221227099003|261009223027099003|261009223327099003|261009221727099003;
x-microsoft-antispam-message-info: A93hgr8jS5GpoJr3si9EBPo0nTDtyR0s3aow4glIlHc7FUm2QuGN6e3yamaFP71oxSsreHRHuuCURU1ZrqR0ztfQhf8lfAkPgsdbqihXXYGAdQt0zTKh2a7030rZY9a3xdGG/9AAwGwD98o4PPNZNgXCb6PiILXN+T7iJsxs2WWUeB3f2f344xHKv1udKZmAkPUrXaiIOQEUzJnR5lAmiV/X2ITeqZ72iIBp049QoDR2OOxndZBSn+Q7nEbA+7gaKARzUZsSrigjUJNltvVQnexuKwEvoVtVS/Dqi1y/FdkGTIJICEJKI23JY/UazoeGGsTz8SfEPzZsY8GYi6hz0K/E3ghqru82tLvC0BCxoqVeIQrnBeMSIX5xrXK12FUGvjMlcmjLGMxHD+CVh/KGXFBVahcDk4AoojqKGHvBH/fZRTm+qOtc8/rgTpKsjMB/dtjCx5OSTcztA+jIvm9b0JRxEFIV303kKLrCpO/+4J7yYJIYOUqTgZdqP5OZcj2GKYzuiAePIhPpdPsMypT021UViPpDvyu7rg50DR9Sd6kS3iAMN+rTzUKV8k+1w587GJDYptW25KkZqoCnEsSvszNQgFjKGTLcVUcoOTWjUIO5xDBT9CPSSqxulkzdX/vs9FPrkn36ZNXiptx/uMI2Wg3xxzDStk3oQ4/kYAv7eT1MnznmtC1Z24sy9cJJx+X2nAn7yvsDrZVC0sXR9kSuygQXm1y1slxRllr6Qb3pPAs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009221727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkMxQ2N3KzQxRmM4YXZrNGVnbjVjcEV0bzE4a0tFWDlGRG9JR3lGODhmb0lp?=
 =?utf-8?B?Wm9UeW9uR3NxM2lEck5MOUlWWTNZd2pQWkRsTzZ2Z2ZxSFZROXhiaUlxcEpy?=
 =?utf-8?B?bXFKV2tvVkcwYjVMQWx4REMwSGV0bjZ2L2NZTUJHMElKa09DbVdtUjcwMExk?=
 =?utf-8?B?RXpjeUZDWGt4cjU4TitUM1lYbW1kOHB3SG11V2d6QS9qc25CcFkvWHFxVTM3?=
 =?utf-8?B?OXhnbDdlTmpyaXZIZUZGOC9wdmN0UEV1MUovZnlOaUZNRDhrYXNZMlhUUzUx?=
 =?utf-8?B?Q3EzbjBVYUxUT2FMSlNnZXJKN2QveXVpdHQ3MmtxTXFJNnlweTZpaDMvUmNB?=
 =?utf-8?B?V3MyT2czdE9lS0VvZC93NjVnUXlwS29wQUVYYnp4WjZER3FCSzlNMFo4R0Na?=
 =?utf-8?B?azhYNWxpRzlOQzJrMnJHVHJpVS9lN1VJVnprWXM2aW5EWTdSR3dNK0ZwbEQ4?=
 =?utf-8?B?c0ZNU05ENC9IQms3azFUNHBTSFBUL2tpZStYWGlsc0Y2d2hPaVlzOXpjLzZp?=
 =?utf-8?B?V0RrWnpuaEtlSVhRKzlTMGNGLzJzQjhiL2tYV0NJR2ZKMjBYQzB3Q3Z4N2Rh?=
 =?utf-8?B?N2oxVGFHU3Q5VWsyMEl3Y0hEQ2ZjQjNYU2hzcnlGS0VNcVhsb2lwcmFFeXhB?=
 =?utf-8?B?a29TdVZEa21PSTdPL2luNGRSK3RUSHYzUnFSSUFpTFBBbEw1TzZmejZrNFZ4?=
 =?utf-8?B?UFpVLzFIYXdBdXJ6ODBpZEY0ZENqVXB6VnAvODZyd1BKSHhXUmZxQkRVMGYx?=
 =?utf-8?B?NDBOYTRmaHFFVEdzZDQ1Yzc0dXAwSEpUTy8yUmVnU1JXNzc1TnlkZzFjcmtz?=
 =?utf-8?B?NTVHcWxWUzVBSXdpaERjOWFseHJROFozSmZmTitXM1Q4RWhNcS85WmtQQmNh?=
 =?utf-8?B?Y0pscmUrajNCUkM5QTZ3STQxWEREWFlQN21aSVVkOUlHVGFXdXd0RFZFY1Fa?=
 =?utf-8?B?ai9ERHlDaS9wLzlaNUdzcmNJZi9HU0dIT1BOdmV5bHYzUXNYOTBxN0hFRitV?=
 =?utf-8?B?d2plVU81TUlidWRyMjhrTEYwYmxCdnZ4bkNOV3FLU3p6MjIraVN5TGR6cmFu?=
 =?utf-8?B?TmZvOXd4VTZ3ODFWalhQOEpzWEhhTlNxKy9raVpWYUFxcEJHMnZtVjRrci9a?=
 =?utf-8?B?c3poTlI5dzV1aDZzRjVTVktRUmZOVW12SDhWeWs2RGVQWTU1ZklHb0JZa3JD?=
 =?utf-8?B?alcrU0F1MTBVTTNnTzNKVkpUT2hMcEtpZzVSUWFrSW0zTnFFeDhYRXlkM2ZG?=
 =?utf-8?B?RUswSGpNbVBYeFRUc212QzYvNEU0S3g5ZFdaUE1lRDMvaExwSkJRVExNVmhS?=
 =?utf-8?B?c2lYMzkyZlNPZ09OeWRZamVQbzdKU0M0M2JEWHlZTFJBUHlaQXh0a3dqNUtS?=
 =?utf-8?B?TU83ZTIrOGVUMXZTSHdRNG5TQ3p3bGc2RXNzejZ4VEtjOXlVdnBUZVQxc3hM?=
 =?utf-8?B?TE9ZTmZvQ2ZmQWE4RzN5c21oMG9jU3RNT2VWZWdNQjd5am51T2hyNVh2MEM0?=
 =?utf-8?B?VmdYVjlCclh3ZEp1WWo3NkNwZnRqbkNHbXNITTdDSlJFWFlZb0phRGNBWVBE?=
 =?utf-8?B?SGQrOWR0c0Y5TnZsSWg4d1VIdGppc2FlMk1BenJQMUxXOXJJaC9YZ0M1MFFv?=
 =?utf-8?B?cm9QOG1xbXBRS3BmYjgrbEVxS2lTbWtyYVF6enBSNnRxaEUvNXY0SUNGZWRR?=
 =?utf-8?B?TTFqMDdHZUVtRVFJV0Z3NmU1cm9FQm5qSGhkT0hhTkM0bmI1NzZ2ckZYcWhL?=
 =?utf-8?B?TlY5WmFEeDVCTVRldkkwUFZ4MzlsVitvZjVCVkswL1ViWFh1WnNtNDdQeTM3?=
 =?utf-8?B?T0dwSDZCNHVrOFdkM0dERDFJNkxDekt2S1JubEQ2NUt5VXEvNGNqVUJuNmZv?=
 =?utf-8?B?Sm9UQnp3bFdHODVkaWdMZFh5b0dUTTBKSDZSV285bUV5WGZQWFpzeEdZQ3Qr?=
 =?utf-8?B?cGx0QkRKMEx2SlJoUHIrUFlaL3dTdXJ2Ky81eklVQmlwbzJRaDVTTUF4MHdP?=
 =?utf-8?B?K0lWUXFzRmNpQjlldjZleEVVRnRTMWRzbGR1RTNZdFA1T09EZHBpWkhIejRR?=
 =?utf-8?B?dC8yYmZLK1VsbzkyVUxSYXBLZ3hjTC9CUC9rRlRoY0Z6dm9mNmVKUnZKOVdm?=
 =?utf-8?B?cVA1ZGZ6MFBzcmViQ3h0VXl1YTR3UmVLWUcvM2tveitEQ2MwT0FibUZTWnEr?=
 =?utf-8?B?eithK2tZY2NzVUtPbHk0ZHJaTU1RM1BUeGhzZ3lVcThFak8vT1RPRVhmWW9z?=
 =?utf-8?B?eDZFU3VLbGthOTA3ZGJzSzRJRXVQYkxUK3dJQ1U0THMvZ3JJS0ZwWUZxNTV6?=
 =?utf-8?B?aHd5Z1AwdTVMdDBhLzVlcFoxREJvQ1A2Z2ZIc3hZQko4OUZWck5UZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GXM05+YrB27rt4Qp2GyJT6AKJ0WqNlprMS0I5DFZC9tWd64fqnXxqkzl7viaM8RZYcd2Es2t4mX8KG7l0IWu/VN4Y2JxxY8/+L2AAT6XEaJJ8HVUcRQBg/bG4fM1gvJsL5/rKI+KZAqzy7aHNcbcmbBjiVeFSN3HmEgD3IO8FCkGPCemKXfikfywKf3cgGgO3E6PViJS2pvkrkR1alnM3JRVkpFdmA1feNQgtiVboOB4Jh7nyqLBMHB01PagUfLEB9MBAzINqZUCWSAqUiz6hp9vGcrR0TcA1HlS93KnuwPOvStKpO+Mc1Zd0PlWW92nM7lIrQJ+BnTWTELCPOqvhQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794b691a-d814-42c4-ab46-08df358535d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 06:23:55.9989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVVydjGNaQ8llxjNDHl7mBYZoOheAzmnkHcShn6jRhri5w++l0kF1JjktGJn8dSRFlO5D3zST38gOIGgEGzpNr9XpelaZtnc2q6Ys8xTdvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5420
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzZdIGh3L2kyYy9hc3BlZWQ6IGZpeCBETUEg
dHJhbnNmZXIgaW4gbm9uLXBhY2tldA0KPiBtb2RlDQo+IA0KPiBPbiAxMC8yNy8yNiAyMDo1MCwg
VGltdXIgTWFrc2ltb3Ygd3JvdGU6DQo+ID4gQXZvaWQgY2FsbGluZyBhc3BlZWRfaTJjX3NldF90
eF9kbWFfZHJhbV9vZmZzZXQgdHdpY2UgaW4gbm9uLXBhY2tldA0KPiA+IG1vZGUgd2hlcmUgdGhp
cyBmdW5jdGlvbiBpcyBjYWxsZWQgZmlyc3QgaW4gYXNwZWVkX2kyY19nZXRfYWRkci4NCj4gPiBB
bHNvIGZpeCB3cml0aW5nIHRvIEkyQ0RfRE1BX0FERFIgaW4gb2xkIHJlZ2lzdGVyIG1vZGUuDQo+
IA0KPiBUaGlzIHNob3VsZCBiZSAyIGNoYW5nZXMuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRp
bXVyIE1ha3NpbW92IDxnZXNzaW5nYXRlQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2ky
Yy9hc3BlZWRfaTJjLmMgfCA2ICsrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kyYy9hc3Bl
ZWRfaTJjLmMgYi9ody9pMmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+ID4gNTEwNzU4ZmI3YS4uYTJi
NGM4YjU3NiAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4gKysrIGIv
aHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+IEBAIC00MTYsNyArNDE2LDkgQEAgc3RhdGljIGludCBh
c3BlZWRfaTJjX2J1c19zZW5kKEFzcGVlZEkyQ0J1cyAqYnVzLA0KPiBib29sIHNlbmRfYWRkcikN
Cj4gPiAgICAgICAgICAgaWYgKGFzcGVlZF9pMmNfaXNfbmV3X21vZGUoYnVzLT5jb250cm9sbGVy
KSkgew0KPiA+ICAgICAgICAgICAgICAgQVJSQVlfRklFTERfRFAzMihidXMtPnJlZ3MsIEkyQ01f
RE1BX0xFTl9TVFMsDQo+IFRYX0xFTiwgMCk7DQo+ID4gICAgICAgICAgIH0NCj4gPiAtICAgICAg
ICBhc3BlZWRfaTJjX3NldF90eF9kbWFfZHJhbV9vZmZzZXQoYnVzKTsNCj4gPiArICAgICAgICBp
ZiAoIXNlbmRfYWRkcikgew0KPiA+ICsgICAgICAgICAgICBhc3BlZWRfaTJjX3NldF90eF9kbWFf
ZHJhbV9vZmZzZXQoYnVzKTsNCj4gPiArICAgICAgICB9DQo+ID4gICAgICAgICAgIHdoaWxlIChi
dXMtPnJlZ3NbcmVnX2RtYV9sZW5dKSB7DQo+ID4gICAgICAgICAgICAgICB1aW50OF90IGRhdGE7
DQo+ID4gICAgICAgICAgICAgICByZXQgPSBhc3BlZWRfaTJjX2RtYV9yZWFkKGJ1cywgJmRhdGEp
Ow0KPiANCj4gDQo+IEZpeGVzOiBlZmVhN2RkYjQ2ODkgKCJody9pMmMvYXNwZWVkX2kyYzogRml4
IERNQSBtb3ZpbmcgZGF0YSBpbnRvIGluY29ycmVjdA0KPiBhZGRyZXNzIikNCj4gDQoNClRoaXMg
cGxlYXNlIHNlZSBteSBjb21tZW50cyBpbiBwYXRjaCA0Lg0KDQo+ID4gQEAgLTEwNzAsMTEgKzEw
NzIsMTMgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX2kyY19idXNfb2xkX3dyaXRlKEFzcGVlZEky
Q0J1cyAqYnVzLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAgICAgICBidXMtPnBlbmRpbmdfaW50
cl9zdHMgfD0gb2xkX2ludHIgJiBjbWRfaW50cjsNCj4gPiAgICAgICAgICAgYXNwZWVkX2kyY19i
dXNfcmFpc2VfaW50ZXJydXB0KGJ1cyk7DQo+ID4gICAgICAgICAgIGJyZWFrOw0KPiA+ICsNCj4g
PiAgICAgICBjYXNlIEFfSTJDRF9ETUFfQUREUjoNCj4gPiAgICAgICAgICAgaWYgKCFhaWMtPmhh
c19kbWEpIHsNCj4gPiAgICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9S
LCAiJXM6IE5vIERNQQ0KPiBzdXBwb3J0XG4iLCAgX19mdW5jX18pOw0KPiA+ICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gICAgICAgICAgIH0NCj4gPiArICAgICAgICBidXMtPnJlZ3NbUl9JMkNE
X0RNQV9BRERSXSA9IHZhbHVlOw0KPiA+ICAgICAgICAgICBicmVhazsNCj4gPg0KPiA+ICAgICAg
IGNhc2UgQV9JMkNEX0RNQV9MRU46DQo+ID4NCj4gDQo+IGFuZA0KPiANCj4gRml4ZXM6IDIyNjBm
YzZmZjNmZiAoImFzcGVlZDogaTJjOiBVc2UgcmVnIGFycmF5IGluc3RlYWQgb2YgaW5kaXZpZHVh
bCB2YXJzIikNCj4gDQoNClRoaXMgbG9va3MgZ29vZCB0byBtZS4NCg0KPiBUaGFua3MsDQo+IA0K
PiBDLg0K

