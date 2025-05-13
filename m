Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8215FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeSz-0006V4-Sr; Mon, 12 May 2025 21:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEeSy-0006Uv-BT
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:29:56 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEeSt-0001PD-PC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:29:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD+uAYJOOy8MARUet/upPmYrL3JPI0ygwD3/Lx/yiMRc/mrXsxWrOO3GYSE+rrF8AEhybhL4iffuPNFScSnTzdG70gfnyi+dcTbgvwnIECaKv5ucmfAstsdafbSmA3U1yuvMhk6Hz9y9ddx8iGU6L66DAIDAtv5+joeG/paZNqN2fIbZS8reuVm74v0+6epmarD479iDy82ygY9YGR5fKvyGMNkblRu4nvynxnihEJ/8QXGXDaUQWkrOlaOQ67ZFmjJAFMy+TC1pj5b4FEE/HUgvPesnrvWDhHHXC8ELfTY4mzLjuZFZZZuCVAF4VAmUkp2do1zI+zacNbyXNwjEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+FqZHVoxmG7M+vMd3RIrimdo1B6nKSfBTJX0xisypo=;
 b=mtWPNCcjvsB3jMguW0FHovspt1S6KGl7nQaYB+hAuZ5H2UQ3XXBbzPuuP+3aoMr+0U8ucYJmgfNpbh60UkEEvso0gaAZiR2ptfHidTYLqicFmrvC9q5mO89xtdAbFWHdxWJO30ufzTMT1E43O52+vDSZ13+bF/d+lci3s41DT9Z6LnttvCZmTVBEG28rR7RKSf6800p6P6oELxgo58rpgTA5+o7Xd7ZMXVqKRIPN7E7wl1PwsYJew1kFE4uJMwQc1xG/EnHC8RznnX01yjUSgVSpBqripSkw1wCRrX6BnxErDIkI0b8JAHHax/aPkkrAsUpwqD1mGTkPwLERc2g9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+FqZHVoxmG7M+vMd3RIrimdo1B6nKSfBTJX0xisypo=;
 b=qJyHB9PaCMRyv8+21+xTIfEoKwuLkgjQK3sj/KCaw63313ohJzdSB8lrWcmiojmeLITGDMsc33tYL0zHp+bPQsUivaN2Iz2eTIBg7jLVKdECLcQP4TWUEnhbcXGmEZDo3Sm4k5lbBV+sutzH7JBKH2YLZBWNQhOBK9eFYVSRfcXKcpKyryJs58xQHwoAizSci6ecRZwSd4ztefC3KynmM6BXJVTqimTgeE4IMFo2oYriXPI2GL6Naqz62dJspXA603/25/VimIG1jzlxSSlzOCrpSE2wankpWWhFHXKCRVCEAsVSPcFopJ85MJnkRJds+3L7G9Tv2hXZGH1ggsSGRg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR0601MB5487.apcprd06.prod.outlook.com (2603:1096:820:bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 01:29:44 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 01:29:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Fabiano Rosas
 <farosas@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH] tests/qtest/ast2700-smc-test: Fix leak
Thread-Topic: [PATCH] tests/qtest/ast2700-smc-test: Fix leak
Thread-Index: AQHbwQrsIp2W5SQB1UO81I3e7CiWy7PPIySAgACm3/A=
Date: Tue, 13 May 2025 01:29:43 +0000
Message-ID: <SI2PR06MB5041B9F357835A648CF24185FC96A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250509175047.26066-1-farosas@suse.de>
 <bcd22d12-2009-474e-9321-c22c1aabee4e@kaod.org>
In-Reply-To: <bcd22d12-2009-474e-9321-c22c1aabee4e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR0601MB5487:EE_
x-ms-office365-filtering-correlation-id: 4d39ba03-01dc-4a30-9696-08dd91bda3dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QkJZM2xySFU4T2psbHJaQmJqemRPUDN1eVI4SGoyZVpUNHowNCsyZS9RN1cx?=
 =?utf-8?B?MjBrTjFsZHlmVkxpaEVZK0pnWm1TNUdkejgyUDBMRHIxc2hpYStIcDBoMFhS?=
 =?utf-8?B?dno1eFFnMUI0MUxyb3pXNjRqbFBlVjl6NUo3bTcwOWdTVWZkRlVlb2E5V09i?=
 =?utf-8?B?MlgyK1RuV2x1Y2FvYS9MeWgzbTZxWjlrQ1VHcTlGOVZKZDJvcEJMOW1nbU1o?=
 =?utf-8?B?UHVZRk5GdzVHZVVVYXM5NGdjek5tc3F1ODMxTjQrSjdVMWk4dkh6TVl1Z3hv?=
 =?utf-8?B?T0dIaXBvcS9xaFROaVBiUlRNd1Frc1hiTSs5RVhEYUdJMXM4UVcrTm40TDBF?=
 =?utf-8?B?NXlBclVkenV1WUVIUFpCUlM1U2JZKzRITGp0RzNLblF1cjdUM2dqWUhkQVpG?=
 =?utf-8?B?WEhWckE0RnlOaTR2TmtON3hwS2YxMWJVREJqK2JVK25qeGh1Sjk2bGZFSmJE?=
 =?utf-8?B?OVo4bW9TYzRNbkc4SnVobjBmR1FiZnZEZHZOQnZxVGgyM0VsYTZHKzFoYStz?=
 =?utf-8?B?VEd1YVp3eGNjcDJEbVlTV3VtU3pkQS9pZEt3SXM5NWVsOGMzUEJYVEVINnEw?=
 =?utf-8?B?OGs4RXA1UGIxWUI5K2s4UGp4cW9hRU9YeElhL29DemU1MXg5dFdlK3pMMitx?=
 =?utf-8?B?ekthSXRMUTV2WnJwSkpxS2hxRzQ4WWhNY2FPMGJNUnlKWTUxZzVST3V6Q1VK?=
 =?utf-8?B?MENlWjFsbWhuZUZnMUNCV25zZlFMY0x1NUFNNnkwdmtxNzlBSXBvWjRYYW9C?=
 =?utf-8?B?Qi85R2hGbTVET3lxd1Bua29IY25aZkUzenk3UGo0SFg1Y1dlUHFNVXRLNm9w?=
 =?utf-8?B?S2tyRkhuNEtYbDArTVhOb0h4S00rTFZSakFneVJUUG12QmJTSWxNQzNRWXJU?=
 =?utf-8?B?QzhBYWZHNk9jVnVabDFhVlMrTng1V0diRWsvWVRwbytRdkovSE13WlBhYkpW?=
 =?utf-8?B?UXg0NVlTbG1lbHZVM256Z1JpdG85cHR1R0ZibGNJZ3FERnpDTEg4RnlWT3dy?=
 =?utf-8?B?eGhIaUZQR0oxOHNONzc2c0o3eE9QcjQrUVI0dVlUdHNZd0laaE94ZXZjRjhR?=
 =?utf-8?B?cW9qb0UwbFlrQzIxeHZqVyt6eWVBRSs4ZE9sbTIxZjk1RnhMUUE5akpCUlJX?=
 =?utf-8?B?L0F0dWlWSHNCVkdFaWRmLzlIOU5rQUhMWnJtbUNoa1IrcWZLdmpVNXFDMDVj?=
 =?utf-8?B?cDBObWNpc05lNVhUT3RVYTVqekxsSHYvOWtGOEorc1pTYzhyTWc1emVZRFNx?=
 =?utf-8?B?Y0N2dENub0gvMDlTNGtGWUxXQ0VhaEQyYW9EZTFreHN0SVlzTGZIOWtqWWtl?=
 =?utf-8?B?Y3hOa1FjRmZYdVRRVkZkV0ZGSGgyVHY5R0lPVUpGOEFERnl0eXR4K29NaGRY?=
 =?utf-8?B?ajRSd2tVNE8zZWZTdFZWcDJTc214YmxLa3o4aVEzcmtXNFp5ZmJMYmFxSnky?=
 =?utf-8?B?NnNaUTJJaGVtV3FjbkJmTFMvV2srT0tRSnVqcTFpd2hrb3hBVUs2Z0plZk5P?=
 =?utf-8?B?aEhDeFVlakYxLzRaeE5NbHh1RkhwMjNjcm05Zm4zNUl5RzRTeHRLaVFuS1Bv?=
 =?utf-8?B?RHYxZE5aNlREZ1NGS1JvQnpZTk9oNnZXaXpOeC9YdGZ3WkhjeW9hNFpkNFl5?=
 =?utf-8?B?SFlvWXlrY0tuMHdmMmo3VHRZbDN2SXRTNk5ncSsvbVZ4bUJMSW8rVmF2VTNp?=
 =?utf-8?B?RDJpeVhSSHk0K3doSWdVbGlOSWhvaHdXVmpIQy9GM3JLSTNXWk5jUHFiYVB1?=
 =?utf-8?B?cG44dkUyOXM5aU5Fd012bHZManMwc3o0TE5CWDhpU1daa2R0bzMzOE8xaFpa?=
 =?utf-8?B?NDZkcFcvWSs5M3puL0JLVmR1cEVLVnVyUUVoWUd0eFhLTzEyNkJ1dUdrL29Y?=
 =?utf-8?B?c2xGeDI4SDVBUUczWEhuR1RRbjh3WEN1d1FPVTh3bFFMOVJJek40dEVjT2pJ?=
 =?utf-8?B?ZWY4dmJFN2FyMVhWZy9pU3h3RXFtUzJZWWVZaHNUdWd1Y05pSmhCYWw0Uit5?=
 =?utf-8?B?dzZ1S1hrVVh3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmZGM2toc3laaDFhTDlqODhZbjQxQzdFQXBCMDhkVHJjUnhaWkNFeW9LLzJV?=
 =?utf-8?B?aFQ3MVE3bWFxM0Jpd2VKOFZRSzhONkcxaXlFVlhpa25QRU5LenNST3ZXTCsr?=
 =?utf-8?B?c3RwRnZiSTg1Z3JEWjVvbm9XOUNmQVJNdG5YalNIWkNDYjVxMEw0RzEwRkVE?=
 =?utf-8?B?ejhYTG5Hbm9pSEpHcTRFK3lPRVZzUUh6b1BzY2RFTDh5QXFTcHdKNEtXaTNs?=
 =?utf-8?B?WHlyUE9SQ0JmV214N2tDQ1UwQlBNaVdIUmFwZE53TXNrdU9HVTNFYmhLRFdx?=
 =?utf-8?B?ZU5FRFA0ODZqaTRwRmxLeHBxMmJDQklRdmdQSEoxRzdwWEYxMUFKL2d6T0hx?=
 =?utf-8?B?cENZL2lRWmcvem5WbUQwdlpwY0d0TzB4U2g1dk5LOFIweEFSZzdUTU5QWEt4?=
 =?utf-8?B?M3l4QzF0cDNYV3A4RURjWCtSc0pDOTEzd2pyUEZxTU5YM2xUNHNLK2RMcVRm?=
 =?utf-8?B?UllJT0YzcCtydVJSRWZKQXY4bEhNN29pVU1vaUFlb1VUOFZ0ZHNvU2JIYTF0?=
 =?utf-8?B?bHFjSGdJOEp4MzREUTVZaUZ3dXRWSUxKUG1nYjBQOU5PeUZkZm9hR2krdStD?=
 =?utf-8?B?aEZMd2lVZEtHY1hSVUJWMXVoMWxPMWY1cW9Yc0xuaFJ5cEg0RFp4Z2NTWWpa?=
 =?utf-8?B?cWMvb2ZDUnRZc0VQcjVlR1BBdVV4TTdyYzB2d3BYb1dhMnJnRHArc2hlYzhT?=
 =?utf-8?B?dVBnWUdsZFNCOTZlYkRhZCs0TDNiempCMVFWR3pZQzdSSEhDRFFObkp1Mmo5?=
 =?utf-8?B?aExxQ283ZTNlZDhGdUhsdTBIVUNTWU1GN1NmaVRsSGR3a2ZIVm9SQ0g3dGs1?=
 =?utf-8?B?MloxVi9BWFI3K2YwRDVIaStrV3J2RFprSXhFUE83dVN0RmRlZW9YUW1qRHZ5?=
 =?utf-8?B?cVBodnl0OG93NmxaZUZCKzBSYXg5K1dMcWRiQXNmcmFDUldqUE92V0V0ZmVj?=
 =?utf-8?B?Rko2M0tyOFpqa3hPL0RBRENaVytxQ283VFZ6TzQwVStPS0lGdVdtRkVKU3FJ?=
 =?utf-8?B?ZGtqV3hPa1ZCQ3pSV1FFSGEwb0RkSWcrTmxIaUdyTFJ1dGxBRDRGSm9TbjRG?=
 =?utf-8?B?aXRmWTJyNGJNWXlYU2c4bTdVZ1FURncwR1FiM3VraU1HVWFMQ3huTkdyM0M4?=
 =?utf-8?B?V3F5ZkluZHZBVGJLUi9hU1l3YlJBNFZ5VW8rUlFjSis3MkFLSUg5ZmhvT200?=
 =?utf-8?B?V0hxN3l5YktCZDlOc0ZXQVB0SzlyaHdDNWtpeGVkRXZCenpqcDZQalRsR1M0?=
 =?utf-8?B?T0N4ZDNxWUF2WEJwQXR0Nm5CamQ2U2RmOERhS00wbGU2cEVGSHNtckRjamQz?=
 =?utf-8?B?byt5amRwZUMzSkRuUVdQbTBONnNWL3NMLzVQSDZLaDBvK3NxM0hTMHJsWXdp?=
 =?utf-8?B?eVBycThPSmpLV01JVkZvSEc4QmdscDlseFBKRDlMOVVmOEdUaG00UWtYS0My?=
 =?utf-8?B?a3YvVENqWkx6TzJ2R0hJUzk2RStzdFBGd0tTNFhCZEFzNjF4MjkvY0pZNGFE?=
 =?utf-8?B?ZU1Pd3JYeTVNUVBwa0E3RDhkajFIVDdaUlNMZXNxdDg3ZjV6ZUFqK0tkMWNH?=
 =?utf-8?B?N2h5TlJBYmpsTFVjbEtSejMrVE9HbE5sZ29IU2VlNVBibWs2ZCtlaHpqVlFz?=
 =?utf-8?B?K3NjMURmQ2tRNFZ0SXd5U0NOYjV6SGI5Y2cvZm9NM2p4dmJVQkcwVWRYSUh5?=
 =?utf-8?B?em9sU1dEUlVCR2NPOERHM3N0WkZrZUdCYk1YN0dFWjhWNTR0ZEIyaHlYWnZm?=
 =?utf-8?B?KzRZRzdEZ2xHbzJEcHpOdHMxenUwbWxlT01venJLNUhqOUgzNzBjQ3BNT2hG?=
 =?utf-8?B?TGFLckE3WHZGYjBCTmpFamxva3MxZ2ZwWWRqVG9DRk1lZ3QxOFlEemZjUUxw?=
 =?utf-8?B?SVhQV0Zka0VZWjBtWCtjQklrcUlqdnlzaHZ2U3JTcE9ZQThsVlVQajhXYW1n?=
 =?utf-8?B?UHFJT0R2Z2g2cS9BaVJNMXcya1JyWmd6YUJjZWVCMzZjY3Frd202WVhzejMv?=
 =?utf-8?B?R24xVDdEYmhGb0hneE96QnRwQUU3NkFtb0NKWEJ6VzAzWkVhV1dZVUo2UytN?=
 =?utf-8?B?TEFtSG11TW8vTG54NHZFMTd3b0ZlYXFtbHpjeVBTZXJqUnZYOVVSRXNQTHB3?=
 =?utf-8?Q?G/iznmTu89GrLRH1l17Eo63G9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d39ba03-01dc-4a30-9696-08dd91bda3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 01:29:44.0081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPiVcsvCDz4Kpojd5+tyiB+3c7aZDuujnNmxl3ypVshIoclrR0+wukmj/nzDXwpvakZKHWAH6LvpjrXtZ+mX1gRBpp6dSRlSiCisYoIbpAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5487
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Pg0KPiANCj4gSmFtaW4sIGNvdWxkIHlvdSBjaGVjayBwbGVhc2UgPw0KPiANCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEMuDQo+IA0KPiANCj4gT24gNS85LzI1IDE5OjUwLCBGYWJpYW5vIFJvc2FzIHdy
b3RlOg0KPiA+IEFTQU4gc3BvdHRlZCBhIGxlYWsgb2YgdGhlIG1lbW9yeSB1c2VkIHRvIGhvbGQg
dGhlIHRtcF9wYXRoOg0KPiA+DQo+ID4gRGlyZWN0IGxlYWsgb2YgMzUgYnl0ZShzKSBpbiAxIG9i
amVjdChzKSBhbGxvY2F0ZWQgZnJvbToNCj4gPiAgICAgICMwIDB4NTVlMjlhYTk2ZGE5IGluDQo+
IG1hbGxvYyAuLi9wcm9qZWN0cy9jb21waWxlci1ydC9saWIvYXNhbi9hc2FuX21hbGxvY19saW51
eC5jcHA6Njk6Mw0KPiA+ICAgICAgIzEgMHg3ZmUwY2ZiMjY1MTggaW4gZ19tYWxsb2MgLi4vZ2xp
Yi9nbWVtLmM6MTA2DQo+ID4gICAgICAjMiAweDdmZTBjZmI0MTQ2ZSBpbiBnX3N0cmNvbmNhdCAu
Li9nbGliL2dzdHJmdW5jcy5jOjYyOQ0KPiA+ICAgICAgIzMgMHg3ZmUwY2ZiMGE3OGYgaW4gZ19n
ZXRfdG1wX25hbWUgLi4vZ2xpYi9nZmlsZXV0aWxzLmM6MTc0Mg0KPiA+ICAgICAgIzQgMHg3ZmUw
Y2ZiMGIwMGIgaW4gZ19maWxlX29wZW5fdG1wIC4uL2dsaWIvZ2ZpbGV1dGlscy5jOjE4MDINCj4g
PiAgICAgICM1IDB4NTVlMjlhYjUzOTYxIGluDQo+IHRlc3RfYXN0MjcwMF9ldmIgLi4vdGVzdHMv
cXRlc3QvYXN0MjcwMC1zbWMtdGVzdC5jOjIwOjEwDQo+ID4gICAgICAjNiAweDU1ZTI5YWI1Mzgw
MyBpbiBtYWluIC4uL3Rlc3RzL3F0ZXN0L2FzdDI3MDAtc21jLXRlc3QuYzo2NTo1DQo+ID4gICAg
ICAjNyAweDdmZTBjZjdiZDI0YyBpbiBfX2xpYmNfc3RhcnRfbWFpbiAuLi9jc3UvbGliYy1zdGFy
dC5jOjMwOA0KPiA+ICAgICAgIzggMHg1NWUyOWE5Zjc3NTkgaW4gX3N0YXJ0IC4uL3N5c2RlcHMv
eDg2XzY0L3N0YXJ0LlM6MTIwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJpYW5vIFJvc2Fz
IDxmYXJvc2FzQHN1c2UuZGU+DQo+ID4gLS0tDQo+ID4gICB0ZXN0cy9xdGVzdC9hc3QyNzAwLXNt
Yy10ZXN0LmMgfCAxICsNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2FzdDI3MDAtc21jLXRlc3QuYw0KPiA+IGIv
dGVzdHMvcXRlc3QvYXN0MjcwMC1zbWMtdGVzdC5jIGluZGV4IGQxYzQ4NTYzMDcuLjYyZDUzOGQ4
YTMgMTAwNjQ0DQo+ID4gLS0tIGEvdGVzdHMvcXRlc3QvYXN0MjcwMC1zbWMtdGVzdC5jDQo+ID4g
KysrIGIvdGVzdHMvcXRlc3QvYXN0MjcwMC1zbWMtdGVzdC5jDQo+ID4gQEAgLTY3LDUgKzY3LDYg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiA+DQo+ID4gICAgICAgcXRlc3Rf
cXVpdChhc3QyNzAwX2V2Yl9kYXRhLnMpOw0KPiA+ICAgICAgIHVubGluayhhc3QyNzAwX2V2Yl9k
YXRhLnRtcF9wYXRoKTsNCj4gPiArICAgIGdfZnJlZShhc3QyNzAwX2V2Yl9kYXRhLnRtcF9wYXRo
KTsNCj4gPiAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgfQ0KDQpSZXZpZXdlZC1ieTogSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+IA0KDQpUaGFua3MtSmFtaW4NCg0K

