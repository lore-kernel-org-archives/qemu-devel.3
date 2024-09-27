Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B52CEBF6B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 02:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su0WL-0007pO-Rj; Thu, 26 Sep 2024 22:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su0WG-0007mJ-QR; Thu, 26 Sep 2024 22:15:45 -0400
Received: from mail-tyzapc01on20726.outbound.protection.outlook.com
 ([2a01:111:f403:2011::726]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su0WC-0007iq-TC; Thu, 26 Sep 2024 22:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2UBTayhZ+mn26XT9Ptuw3Vo44Dk5w5Sscu2hncMKChZDUukGNEKK0HH22EVzfsYe8d1VhpfROMvIyByl/Xp1F4VGhF8Em4AQHKYky7ffwQ0lMZD+J5cOIKwloh4pxujnEGMBaRZ/qEHDQRNuf8WExxGg724OoVCCMgatcgSqAKHsK6iu9M4DQc7IS8C4Ip0W+1/Cg0DjwN0a0pwIEPQLeb1Q0JSrWC2d5w7j454nkR7KdmMJUOYM6HdEU5BLPY9dv+Z1drq2f62fNQ1SkYEJa2xJkdwMN/QHWSJsp27BkM5ckgA5a0nQRAUvSSCqLo9UhJMm1bdPKaKVyhEOJAnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4LQwPnnDDGxOd00XoFi44PR0vw42DNRtOU1XYqDIIM=;
 b=QbMdYDwVY4q2n7g7nRBX5fHsMU67dPHdIpdq6sQUk0jZZ4hc4wObM46w6qwYX0R7PVkenVYpBgzifJ7JMH2XqudbAWa9ShcVzQ59Z10U/BCgg++c2e8IgiIJj6Eg+UcL3Ot/7Dm2yx0huCt280Pd+w3/YuMQHiRqpjASOxCOcXNz7uTabQN7Ifyu4jwePYj6ji0cvzIlvWhis8+zFejqcxAWCMY41I6ViOUjEz4BH0BLRUaVlFvOENHkt6JrUTL1rznbrN+38rSFsQXGIKvziFoCvFyG7nW35+f4O949TfTUALnGZKAsmxsvXJqs5XU4ogReAEJ08SVX3N21SoP46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4LQwPnnDDGxOd00XoFi44PR0vw42DNRtOU1XYqDIIM=;
 b=Du0XpuAKcvgsNkbPmv5EiR/jvRnKiQriyKjm9SNxeWa+WdQkO4HxdhXB379J82m805gKhHWfFKkDrr3rwz4mDs/a3aTKK5PsglkM1dRAGizilcNRYmI57Fwy+K+3ptmwBf7fjBCw0JtHlbBCfA7163mL5+2BJiOohzSzIAg6hYM8W0nKkrJkCN2vY04g01BJ3g13KqBDn199e87w4ffXRwEH9Nq1eBbHiY52tGKBRZCm0ak1goZruKCuSZLLVQhlSi1lOrgG5bx8d9f7qlT54eO7moQhMNhvcSXKHoO5Y7fybK6O/drvDBsB8PUMMZQLt2lBd5LfECNzFU/tFxPfZQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR0601MB5799.apcprd06.prod.outlook.com (2603:1096:820:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 02:15:31 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Fri, 27 Sep 2024
 02:15:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 4/6] hw/gpio/aspeed: Fix clear incorrect interrupt
 status for GPIO index mode
Thread-Topic: [PATCH v3 4/6] hw/gpio/aspeed: Fix clear incorrect interrupt
 status for GPIO index mode
Thread-Index: AQHbD+gbvmyvsiHjjE+x0o+izVfPibJq5a2AgAAAbsA=
Date: Fri, 27 Sep 2024 02:15:31 +0000
Message-ID: <SI2PR06MB5041A13C1801D9BCEC5C6EB3FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <20240926074535.1286209-5-jamin_lin@aspeedtech.com>
 <4ca92b4ccaa8d66db990dc51d4d50aa7e648ad5a.camel@codeconstruct.com.au>
In-Reply-To: <4ca92b4ccaa8d66db990dc51d4d50aa7e648ad5a.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR0601MB5799:EE_
x-ms-office365-filtering-correlation-id: e9941dfd-b07f-4d67-5d0f-08dcde9a4317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkxwaG5zeEFSUndmQzB1ZzJrV1kwOUExZTEvMzNUU1FtMlo3NTZBbmpxbWZ2?=
 =?utf-8?B?NWhrZUtxemJhM3NrNkFlSTM1WEVwcHBWeU1ESjNHWElkbW94bzRhN1o5UmE3?=
 =?utf-8?B?N0ZEN21sQ1hSbU1vMmdLTHp5bVJVMzloRG10UUl3MVVQRWkzc1E5eW5BTjFp?=
 =?utf-8?B?bE5EVnZJdkk5ODV5MEViWGZQYXkwZzhYTStnMzlMaENXRXNvV0lqeTFXbDRO?=
 =?utf-8?B?ZnNmM09IdU1NU0ttaUszZ1RlM0RyUDYweStvVXNzTkhRMFkzRlJHNmxUU1BQ?=
 =?utf-8?B?bUJyUzFpZXU5OE1Yc3ltUjQvajZ4UFQvWHN1KzVrUk9wTEpNQXYwRmIvdWZh?=
 =?utf-8?B?TG1zUmZqV0lJVVM1MFBwWFFDR2JBeGMyc1ZoSUp2VTBUOEp4YVovZzVhU1lk?=
 =?utf-8?B?UUxvNktjS3V4bngxcE5KMGs2ZVRSZ1BxWXl4d0plUEZhUnVTNHgrSlc1QkVn?=
 =?utf-8?B?Z21PeFBtZ2NIRERpRDZscFh2YUN0dWlCNitrQnhVN283NU80VVcxYXZyVm5m?=
 =?utf-8?B?cXJQcDVXSjROZFI0TVNMOHZTUno1RmVnK2hta1EyL1JDVmx2NndXZjhCU2pT?=
 =?utf-8?B?NC9uVllxOURDNWlueE9TQVJzdzFTMURsdy9iU2VZOVlGMEN1bXVNNHpPdWRx?=
 =?utf-8?B?Mk1mbG1YUENMTy94LzNBNURPZWlSTjhiMzk3ZkpIK2s0MDNMV0R2QWozdUpV?=
 =?utf-8?B?UHFWNlVIVmFmMFh3WlMrQ3RXZXgwdU82U3BHWEYvbzc3SGhUa2JGV2pHbmVu?=
 =?utf-8?B?YWpTWnFFUW5LSy9yMm1lOVo5YXRJOVh2akg5LzJVT1FXL0lwaHBHdXpMZkVh?=
 =?utf-8?B?V1hVQ2lKZkFPc29pTm9ETjd0L1VHeVZXL0NFY3NyK0tFaGgxSHFranlLcE1S?=
 =?utf-8?B?bUNnYldaMVk1anplVmhqL2xIbjByd2drb05ZZkR1VkdZR3N3YVk2QkxsNFcy?=
 =?utf-8?B?UEhlN1MrUEg5WnhqV0x5UWs0dUtxS2tsL2w2VlVtSnk3Q2hVRnlDOU5memFV?=
 =?utf-8?B?UXhFa1FMdzJ5MGtrcXVNUGpUMXN6bnErYTVtcGJEM3c0eTFJWHNBSThvaTdF?=
 =?utf-8?B?QVk1Q0E0b0V6eWl0UFk5MjkwM0VnaTR4VjFSTVlkazJTdnNkNE5xVE80UTUv?=
 =?utf-8?B?Y3pSR3U0ZTBLRm92d1dkUWZnVndCU2RrTVE2Q1dNajBhMTdBQ0dMWlFVaTZz?=
 =?utf-8?B?dWttVll5VHB3SFY2UG8vZnlBQWNJWElBaEU1dXB5djYwejNRTFFrVlpDMTNH?=
 =?utf-8?B?T3RzRmMzdk1xbVhSRGFla21nc3VmZjRnZ1lOYkZXZTRyQ2FHeUZLTm9vRjg3?=
 =?utf-8?B?UDlOWHBWNVB1VlRPVmVaQm9TMjlKM2k3MzVtUFA3QXNudmFQL01FRUVHNTMw?=
 =?utf-8?B?OCt5aFBDbGMwN09yaGdnVkFPQkhDdWdCclcyL2pnb20yQUpGaTFCQzNLYWtj?=
 =?utf-8?B?U0U3ZVVFODZ6Y1F5TlYydDFka0RNc1U5NThDTTBjbTc0R1Z4aHlxSy9YczE0?=
 =?utf-8?B?NE52UkRPQXpNbGZ0dDlwUi9KWDQwditIcnpNZ0o1Q01nWkwzNDlmTEU0NDY5?=
 =?utf-8?B?aC9ma3pqQ1lBZW5GMngwaitYUzJVWnBBaXFKbHVua3A0WThSQnhINDRmL25j?=
 =?utf-8?B?cEtWTDhYdVMrQW5QUEJxaktrb2tWNUJMKzR6UGptMGZ4OVBNZTJTaS9tR2Jx?=
 =?utf-8?B?U0hUY08rQUQ4SVUzdVBOelY4TUNENXhoYzV4UnpONm1pRUYrOXgvR3ozdlNi?=
 =?utf-8?B?NHBWNDZiaG9hbW80MUFrY0ZuMDh5eHRteU1iaGlyaWZINDVIYU03bFdYU3F5?=
 =?utf-8?B?b09qQWFHMysyamlmZFM1QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDlpUGV1cTJrTlVHKzI2MVllU3JLZ2hWT00xTDFlYWtMK05rRVFna2xxbUZn?=
 =?utf-8?B?Y2YyTDYxTVBaTjQ1Q0ZScHcxbzFNTkNBUVhCcEJ6U2ZJbUJHMUxtVFh6TVdv?=
 =?utf-8?B?ZS9PT2kxaHI3Q0g3U1dCclJwcm95d0drWld1ZDdDUlpOL0xmT2QzakNFSHNo?=
 =?utf-8?B?VTlsU1liTEtUWGd1d3VXUk9mTjU4ZHpNSHVUdDhOMVVJSzQzM25wejQzOFYx?=
 =?utf-8?B?ODY1ZjBlc2Jtdlg2OGpCTDJ4QkcrWVlQNDRkL1N2cUlRbktZYVZ3anI1L2xH?=
 =?utf-8?B?UHZYRXRndVdXcUVHUVBVR1VlbXoyRG56TlIxbDV4S3FKUyttQnFEdVZJY25X?=
 =?utf-8?B?U1N2Zkg3Zk1PeXNFbDNHZlNyV1Q3VkYwMVB2dEhiZVF3S3NvV2RZUXE3RVFR?=
 =?utf-8?B?bmprZVBwSnlYd3o5bE9JRnlxWlNaOEFaSGpwc1lMdHNMRTRvV2hhVERKMTV3?=
 =?utf-8?B?T09sQWI5NmkwK0hQSTkyMlZkY2tJSmw4c2JlY1NLOXhZZUdEYWdlWXhmdkdW?=
 =?utf-8?B?MG96UU9YREJobmJ5enZ0SXN0QjAyUEVpNlJYeUdqamVMT1JQR0k0MjQ5aDg3?=
 =?utf-8?B?cmNEQ2grQXVtL1Q2cHovTTIvUGxWL1dvbktneGRRVGlxcXdOV2pNbk9wNDFU?=
 =?utf-8?B?VXc0SnhlMDNSdkpNRHI2VnFtVzM3QmVqaWFrUFNQUU03UUZVUDFGUUpOY2dE?=
 =?utf-8?B?NGxFSzdnZ3BLRHcyeXNEOFROSk80ZVluRDV1SzBlSnF1ZWlacVFheFZKN25r?=
 =?utf-8?B?NzdhTG00VElCVFZod3Q5ejN4QitHSFR0aTNKbzFGMGhQd1R5UDRoR1R1VTVu?=
 =?utf-8?B?WkJ4Yk95bEsyZEhISjZNNlJDeHRZZ21DVEk1NS9wZlN4dmcvZXNoc3pKUDhP?=
 =?utf-8?B?eE5SWml4QzlERk9USlg2MEFacEYvekdadkN0M3ViSG8rZHRTNTIxYzQ3UzFu?=
 =?utf-8?B?VHM4VzBTRVYwY1AvSHRHZnJJcnNoN056RjB2eWhKc1QrbHcwYW5keitVMDJi?=
 =?utf-8?B?dUNWR2kzdkJyWmYrTGlkRjI3N0NweXB3QUtLVGN1SU8wVWpBbHgyc3dSZFVn?=
 =?utf-8?B?Y2NoVVhrMXdtMGtjQWcxMmVuQnhlTUUrakZPdWd2ZDNiV0NsaGR6YXppajZP?=
 =?utf-8?B?Ly8zS3BYU3JqVERlYTVsaDUveDhudkpSMTlPZXZJRTRkRzhQeWRxd0RVenRN?=
 =?utf-8?B?b0E5elpJaU9tZ0NuVXRXQnRXWUdSNkJReXpjYmtkYjV5TURzMnZmNGI4TTFQ?=
 =?utf-8?B?TEhURmJZbGI5N0dlRU8wOHhzOVh6TnlwSk1YaVNoR1hGeE5KU0t6V2luUU9D?=
 =?utf-8?B?UkV2R3p3aHlkdFgwSnE5a0hwbnVMLzFsSmI3SU5EdlB6VFduL1NwOTN6Nklo?=
 =?utf-8?B?TTBUWjZWOVh1SjlFNjJ3NUh2QkNTWDFoNE9lZ21mejVRNzd5Zmk0aGYvWjlS?=
 =?utf-8?B?M2p4aE93bDZpdzNnSk8vamh2bFpvSkNYYUZja3NRbm5rK1ZaSUJvWjdrczcz?=
 =?utf-8?B?UUhnRGIxc0VEaUoxNGpRbzNjbmxYdHpmVWNlVTBPaWtmTmpvVnhCRGlUZmEw?=
 =?utf-8?B?bmlUd0V2ekZmL3AvQW1lbm9WM3phS3pyYmVtL29kNmFhZ3llZ0dwRXI2NGVx?=
 =?utf-8?B?QzN0VjJ6MjZsMGNkT1ZyTjYxTkRHOGYzZUtlWWQ4Q0J3UlZKVDIvSFhJSHdG?=
 =?utf-8?B?bmNwUGdiSVBuaUM0VHFSQ0RYUTNRZHlIeFlaN0dPK08yZUFRTjlDTUk0QzBy?=
 =?utf-8?B?d0pGOWV6ajFmd2dkalFiWUZLQ2tMTWt2c2oydmtjeGJpaUtFMHNEZUJHdXpy?=
 =?utf-8?B?ZFpGWnBGUmZNMnRXV3daVGNLRExtbEFuOXQyOVdHZUpSZXpONUdJU1F5ZmxD?=
 =?utf-8?B?VmFLYXkyemFHd1IzRldKNEp1V0RIYldxOFBoWVcvY1RZV2hKWjgwYlZQamZk?=
 =?utf-8?B?dTJCQ01zMzFHY1dVNkRsTVZNSjBNMG9oYVBwUFN3cVc3UWdHQ3FNdWZjbEVJ?=
 =?utf-8?B?QjJXbnFMQlZVSmJ0VEpBVGZZaXZiZDJ5WkhGZmx0dTlNNi82VDV3dXRlZFlr?=
 =?utf-8?B?OFJ0SGNoVWpsL1c4ZFlaOFdZZkttTVp5TWxRNFJ1cGl2T2p6OHgwTmkvMVIx?=
 =?utf-8?Q?/4+K9gRUNFvwJ8L3gPUkGn3GF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9941dfd-b07f-4d67-5d0f-08dcde9a4317
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 02:15:31.1083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTJIRMPetYglBrsKTLWKDT4XiVUSOG7wkh9JrH344mhztsKvi/R0mznWi2bsmeIZRI3ZHNp4Cqk63lZuRe0mag49wV+2AhdcFJs77Gw4XOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5799
Received-SPF: pass client-ip=2a01:111:f403:2011::726;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQW5kcmVzLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC82XSBody9ncGlvL2FzcGVl
ZDogRml4IGNsZWFyIGluY29ycmVjdCBpbnRlcnJ1cHQgc3RhdHVzDQo+IGZvciBHUElPIGluZGV4
IG1vZGUNCj4gDQo+IE9uIFRodSwgMjAyNC0wOS0yNiBhdCAxNTo0NSArMDgwMCwgSmFtaW4gTGlu
IHdyb3RlOg0KPiA+IFRoZSBpbnRlcnJ1cHQgc3RhdHVzIGZpZWxkIGlzIFcxQywgd2hlcmUgYSBz
ZXQgYml0IG9uIHJlYWQgaW5kaWNhdGVzDQo+ID4gYW4gaW50ZXJydXB0IGlzIHBlbmRpbmcuIElm
IHRoZSBiaXQgZXh0cmFjdGVkIGZyb20gZGF0YSBpcyBzZXQgaXQNCj4gPiBzaG91bGQgY2xlYXIg
dGhlIGNvcnJlc3BvbmRpbmcgYml0IGluIGdyb3VwX3ZhbHVlLiBIb3dldmVyLCBpZiB0aGUNCj4g
PiBleHRyYWN0ZWQgYml0IGlzIGNsZWFyIHRoZW4gdGhlIHZhbHVlIG9mIHRoZSBjb3JyZXNwb25k
aW5nIGJpdCBpbg0KPiA+IGdyb3VwX3ZhbHVlIHNob3VsZCBiZSB1bmNoYW5nZWQuDQo+ID4NCj4g
PiBTSEFSRURfRklFTERfRVgzMigpIGV4dHJhY3RzIHRoZSBpbnRlcnJ1cHQgc3RhdHVzIGJpdCBm
cm9tIHRoZSB3cml0ZQ0KPiA+IChkYXRhKS4gZ3JvdXBfdmFsdWUgaXMgc2V0IHRvIHRoZSBzZXQn
cyBpbnRlcnJ1cHQgc3RhdHVzLCB3aGljaCBtZWFucw0KPiANCj4gSSB0aGluayB5b3Ugc2hvdWxk
IHMvZ3JvdXBfdmFsdWUvcmVnX3ZhbHVlLyBoZXJlIGFzIHRoYXQncyB3aGF0J3MgdXNlZCBpbiB0
aGUNCj4gcmVtb3ZlZCBjb2RlIGJlbG93Lg0KPiANCj4gVGhvdWdoIG1heWJlIEPDqWRyaWMgY2Fu
IGZpeCBpdCB1cCBmb3IgeW91IHdoZW4gaGUgYXBwbGllcyBpdCBpZiBhbm90aGVyDQo+IHJldmlz
aW9uIGlzbid0IG90aGVyd2lzZSBuZWNlc3NhcnkuDQo+IA0KVGhhbmtzIGZvciByZXZpZXcgYW5k
IHN1Z2dlc3Rpb24uDQpJIHdpbGwgdXBkYXRlIHRoZW0gYW5kIGFkZCBHUElPIHRlc3QgY2FzZSBp
biBWNCBwYXRjaC4NCg0KSmFtaW4NCg0KPiA+IHRoYXQgZm9yIGFueSBwaW4gd2l0aCBhbiBpbnRl
cnJ1cHQgcGVuZGluZywgdGhlIGNvcnJlc3BvbmRpbmcgYml0IGlzDQo+ID4gc2V0LiBUaGUgZGVw
b3NpdDMyKCkgY2FsbCB1cGRhdGVzIHRoZSBiaXQgYXQgcGluX2lkeCBpbiB0aGUgZ3JvdXAsDQo+
ID4gdXNpbmcgdGhlIHZhbHVlIGV4dHJhY3RlZCBmcm9tIHRoZSB3cml0ZSAoZGF0YSkuDQo+ID4N
Cj4gPiBUaGUgcmVzdWx0IGlzIHRoYXQgaWYgbXVsdGlwbGUgaW50ZXJydXB0IHN0YXR1cyBiaXRz
IHdlcmUgcGVuZGluZyBhbmQNCj4gPiB0aGUgd3JpdGUgd2FzIGFja25vd2xlZGdpbmcgc3BlY2lm
aWMgb25lIGJpdCwgdGhlbiB0aGUgYWxsIGludGVycnVwdA0KPiA+IHN0YXR1cyBiaXRzIHdpbGwg
YmUgY2xlYXJlZC4NCj4gPiBIb3dldmVyLCBpdCBpcyBpbmRleCBtb2RlIGFuZCBzaG91bGQgb25s
eSBjbGVhciB0aGUgY29ycmVzcG9uZGluZyBiaXQuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSwgc2F5
IHdlIGhhdmUgYW4gaW50ZXJydXB0IHBlbmRpbmcgZm9yIEdQSU9BMCwgd2hlcmUgdGhlDQo+ID4g
Zm9sbG93aW5nIHN0YXRlbWVudHMgYXJlIHRydWU6DQo+ID4NCj4gPiAgICBzZXQtPmludF9zdGF0
dXMgPT0gMGIwMQ0KPiA+ICAgIHMtPnBlbmRpbmcgPT0gMQ0KPiA+DQo+ID4gQmVmb3JlIGl0IGlz
IGFja25vd2xlZGdlZCwgYW4gaW50ZXJydXB0IGJlY29tZXMgcGVuZGluZyBmb3IgR1BJT0ExOg0K
PiA+DQo+ID4gICAgc2V0LT5pbnRfc3RhdHVzID09IDBiMTENCj4gPiAgICBzLT5wZW5kaW5nID09
IDINCj4gPg0KPiA+IEEgd3JpdGUgaXMgaXNzdWVkIHRvIGFja25vd2xlZGdlIHRoZSBpbnRlcnJ1
cHQgZm9yIEdQSU9BMC4gVGhpcyBjYXVzZXMNCj4gPiB0aGUgZm9sbG93aW5nIHNlcXVlbmNlOg0K
PiA+DQo+ID4gICAgcmVnX3ZhbHVlID09IDBiMTENCj4gPiAgICBwZW5kaW5nID09IDINCj4gPiAg
ICBzLT5wZW5kaW5nID09IDANCj4gPiAgICBzZXQtPmludF9zdGF0dXMgPT0gMGIwMA0KPiA+DQo+
ID4gSXQgc2hvdWxkIG9ubHkgY2xlYXIgYml0IDAgaW4gaW5kZXggbW9kZSBhbmQgdGhlIGNvcnJl
Y3QgcmVzdWx0IHNob3VsZA0KPiA+IGJlIGFzIGZvbGxvd2luZy4NCj4gPg0KPiA+ICAgIHNldC0+
aW50X3N0YXR1cyA9PSAwYjExDQo+ID4gICAgcy0+cGVuZGluZyA9PSAyDQo+ID4NCj4gPiAgICBw
ZW5kaW5nID09IDENCj4gPiAgICBzLT5wZW5kaW5nID09IDENCj4gPiAgICBzZXQtPmludF9zdGF0
dXMgPT0gMGIxMA0KPiA+DQo+IA0KPiBNYXliZSB0aGlzIGlzIGEgYml0IGZvcndhcmQsIGJ1dDoN
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0
LmNvbS5hdT4NCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0
cnVjdC5jb20uYXU+DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGlu
QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBody9ncGlvL2FzcGVlZF9ncGlvLmMgfCAy
NyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2dw
aW8vYXNwZWVkX2dwaW8uYyBiL2h3L2dwaW8vYXNwZWVkX2dwaW8uYyBpbmRleA0KPiA+IDg3MjU2
MDZhZWMuLjE2YzE4ZWEyZjcgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvZ3Bpby9hc3BlZWRfZ3Bpby5j
DQo+ID4gKysrIGIvaHcvZ3Bpby9hc3BlZWRfZ3Bpby5jDQo+ID4gQEAgLTY0MSw3ICs2NDEsNyBA
QCBzdGF0aWMgdm9pZCBhc3BlZWRfZ3Bpb193cml0ZV9pbmRleF9tb2RlKHZvaWQNCj4gKm9wYXF1
ZSwgaHdhZGRyIG9mZnNldCwNCj4gPiAgICAgIHVpbnQzMl90IHBpbl9pZHggPSByZWdfaWR4X251
bWJlciAlIEFTUEVFRF9HUElPU19QRVJfU0VUOw0KPiA+ICAgICAgdWludDMyX3QgZ3JvdXBfaWR4
ID0gcGluX2lkeCAvIEdQSU9TX1BFUl9HUk9VUDsNCj4gPiAgICAgIHVpbnQzMl90IHJlZ192YWx1
ZSA9IDA7DQo+ID4gLSAgICB1aW50MzJfdCBjbGVhcmVkOw0KPiA+ICsgICAgdWludDMyX3QgcGVu
ZGluZyA9IDA7DQo+ID4NCj4gPiAgICAgIHNldCA9ICZzLT5zZXRzW3NldF9pZHhdOw0KPiA+ICAg
ICAgcHJvcHMgPSAmYWdjLT5wcm9wc1tzZXRfaWR4XTsNCj4gPiBAQCAtNzAzLDE2ICs3MDMsMjMg
QEAgc3RhdGljIHZvaWQgYXNwZWVkX2dwaW9fd3JpdGVfaW5kZXhfbW9kZSh2b2lkDQo+ICpvcGFx
dWUsIGh3YWRkciBvZmZzZXQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZJ
RUxEX0VYMzIoZGF0YSwgR1BJT19JTkRFWF9SRUcsDQo+IElOVF9TRU5TXzIpKTsNCj4gPiAgICAg
ICAgICBzZXQtPmludF9zZW5zXzIgPSB1cGRhdGVfdmFsdWVfY29udHJvbF9zb3VyY2Uoc2V0LA0K
PiBzZXQtPmludF9zZW5zXzIsDQo+ID4NCj4gcmVnX3ZhbHVlKTsNCj4gPiAtICAgICAgICAvKiBz
ZXQgaW50ZXJydXB0IHN0YXR1cyAqLw0KPiA+IC0gICAgICAgIHJlZ192YWx1ZSA9IHNldC0+aW50
X3N0YXR1czsNCj4gPiAtICAgICAgICByZWdfdmFsdWUgPSBkZXBvc2l0MzIocmVnX3ZhbHVlLCBw
aW5faWR4LCAxLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGSUVMRF9FWDMy
KGRhdGEsIEdQSU9fSU5ERVhfUkVHLA0KPiBJTlRfU1RBVFVTKSk7DQo+ID4gLSAgICAgICAgY2xl
YXJlZCA9IGN0cG9wMzIocmVnX3ZhbHVlICYgc2V0LT5pbnRfc3RhdHVzKTsNCj4gPiAtICAgICAg
ICBpZiAocy0+cGVuZGluZyAmJiBjbGVhcmVkKSB7DQo+ID4gLSAgICAgICAgICAgIGFzc2VydChz
LT5wZW5kaW5nID49IGNsZWFyZWQpOw0KPiA+IC0gICAgICAgICAgICBzLT5wZW5kaW5nIC09IGNs
ZWFyZWQ7DQo+ID4gKyAgICAgICAgLyogaW50ZXJydXB0IHN0YXR1cyAqLw0KPiA+ICsgICAgICAg
IGlmIChGSUVMRF9FWDMyKGRhdGEsIEdQSU9fSU5ERVhfUkVHLCBJTlRfU1RBVFVTKSkgew0KPiA+
ICsgICAgICAgICAgICAvKiBwZW5kaW5nIGlzIGVpdGhlciAxIG9yIDAgZm9yIGEgMS1iaXQgZmll
bGQgKi8NCj4gPiArICAgICAgICAgICAgcGVuZGluZyA9IGV4dHJhY3QzMihzZXQtPmludF9zdGF0
dXMsIHBpbl9pZHgsIDEpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgYXNzZXJ0KHMtPnBlbmRp
bmcgPj0gcGVuZGluZyk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAvKiBObyBjaGFuZ2UgdG8g
cy0+cGVuZGluZyBpZiBwZW5kaW5nIGlzIDAgKi8NCj4gPiArICAgICAgICAgICAgcy0+cGVuZGlu
ZyAtPSBwZW5kaW5nOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAg
ICAgICogVGhlIHdyaXRlIGFja25vd2xlZGdlZCB0aGUgaW50ZXJydXB0IHJlZ2FyZGxlc3Mgb2YN
Cj4gd2hldGhlciBpdA0KPiA+ICsgICAgICAgICAgICAgKiB3YXMgcGVuZGluZyBvciBub3QuIFRo
ZSBwb3N0LWNvbmRpdGlvbiBpcyB0aGF0IGl0IG11c3RuJ3QNCj4gYmUNCj4gPiArICAgICAgICAg
ICAgICogcGVuZGluZy4gVW5jb25kaXRpb25hbGx5IGNsZWFyIHRoZSBzdGF0dXMgYml0Lg0KPiA+
ICsgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgc2V0LT5pbnRfc3RhdHVzID0gZGVw
b3NpdDMyKHNldC0+aW50X3N0YXR1cywgcGluX2lkeCwgMSwNCj4gPiArIDApOw0KPiA+ICAgICAg
ICAgIH0NCj4gPiAtICAgICAgICBzZXQtPmludF9zdGF0dXMgJj0gfnJlZ192YWx1ZTsNCj4gPiAg
ICAgICAgICBicmVhazsNCj4gPiAgICAgIGNhc2UgZ3Bpb19yZWdfaWR4X2RlYm91bmNlOg0KPiA+
ICAgICAgICAgIHJlZ192YWx1ZSA9IHNldC0+ZGVib3VuY2VfMTsNCg0K

