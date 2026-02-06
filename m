Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0795CEB28FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIHU-0004hj-GE; Fri, 06 Feb 2026 04:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voIHR-0004em-R8; Fri, 06 Feb 2026 04:37:38 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voIHP-0005T2-En; Fri, 06 Feb 2026 04:37:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK/WWamUFIoNATDwEmQQ5CnAYfWP5JyrVxqFQGkyCWKwsquTeW/NHhNyLVwdMKgDivy8ta73WrXzk+lqyagKYiFjX3iN7HGkLOtR3RSaSs2fh/WEImS4VwVW52RIWVZMDG0fwAvY+CPvzfOJvPio0uKcIywWq562ftMca7PGjLB0qHkRIoC9e1IohwVo3hamzM60yA5zbPNplOpQwuQW95VTSLmjUEb2lZmpeLgZZnhLDfXomejwP7I0YKpT8oMuaAjewJm1b+E8SqD1pJjwkilRIv/RO2rc/f28TvLD9fqrElljb/EuLC1pRLNtcDuo33nnvgRUHedrJUUGMRN50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GJ9XJ6HodJ3/Bk6ZpbAAI44wkZOMHisvINDUE3NE3o=;
 b=iEFekKzit2YDQUfDQoCtDlFs1Ra4Pjwi7ocSXosvxYhUUdvMLiiT09vbjbjuxC2ff9TTN4e1yOlw4QQZsN7HRe90pOHPNaf8ihZNjV/xrObZp4y/m89dxvBm0lOf7A13I4ttaYbArGDBQU9V9JsUB9HhbPTnDX/YVL3Mz32FsrthsKOVlIp1zbBsTyxBbhMddWMOA8TWfPb6R4IB8N08WYRGUpuMtbQ7Ijq6+U46QyjOM0GMP5yCHRXXHmxb0/IF+6b+htl6dgbuhMVyF9Ub0lMA6DbkvsNMEuHpDyC9+MCr+2Y5X+Bug4R9SVjeDjMPPN7JDqnmb6GO0o2f6Qg6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GJ9XJ6HodJ3/Bk6ZpbAAI44wkZOMHisvINDUE3NE3o=;
 b=kJ3rG4zqhiDw8hVPkuXIv8fWPN4lQNRnqLX/7NAiCeInFiINwD/mrW6PxK9sgtmvZwt15/cvVJ2fpQpGEgu+ANt90TKEPPgxQoApSsH002GgRxrtWrvY6hwDQU69WKjeRFWmu3eNzb/nWPwp7Vo7v+hqkJ+M1jVNK6uyytmnu7HhoqJHIkBmVXyhHbZvB8w9WDvpfxT65r/jAWwRKdRSwu/Ekiv4v66yFqydYg6EbUeG7mbOq9Xg8VaLUNjtMH+xhhoEYp0/R5fMHMKW3sF6goOFY02l05CriW5rlXY6U5r5wJ1WbD0BRQDKYix2g4KRVQugKiuVVXyw8ubNe3FYBQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE1PPFF9F12DF7E.apcprd06.prod.outlook.com (2603:1096:108:1::432)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 09:37:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 09:37:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 1/1] tests/functional/aarch64/test_aspeed_ast2700fc:
 Use AST2700 A2 SDK image for FC tests
Thread-Topic: [PATCH v1 1/1] tests/functional/aarch64/test_aspeed_ast2700fc:
 Use AST2700 A2 SDK image for FC tests
Thread-Index: AQHclyooWpxRFcR1vE2y+FaNdxBtUrV1aIoAgAAAdzA=
Date: Fri, 6 Feb 2026 09:37:27 +0000
Message-ID: <TYPPR06MB8206E566E737E0599F4BFDFBFC66A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-3-jamin_lin@aspeedtech.com>
 <d2c16b7c-db80-476e-8537-b83e7a625e53@kaod.org>
In-Reply-To: <d2c16b7c-db80-476e-8537-b83e7a625e53@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE1PPFF9F12DF7E:EE_
x-ms-office365-filtering-correlation-id: 1ab2a03a-2c56-48e6-a1df-08de65635763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?L0VYeWhvam9pbnQ0UlllSExIRm5HVzJsdUhQU0YyemVhNExnSTFLK1hDMm0v?=
 =?utf-8?B?Vm5HOERrZDNaUUJsSlpIbU12M054TTkvczFrWUEzM1FIcGFyVDhkTUwxV1NP?=
 =?utf-8?B?ZnVYNmFVRklzaTlHc1lVVzZPVURPKzAyMlkwTG1qVGtsbG5pam1xVlBRYVFm?=
 =?utf-8?B?dDBENU9GZjIwVWZVd3FRRUcxckRtTng1aTVYL2FYdjVlOWRnVUozNE5LTGRT?=
 =?utf-8?B?S3Y4OThKTjdlZW9TOHBmUUQyOFowR2NsRWpIRkR0Rnd2ZlNnUHpJT1Q5ZGRH?=
 =?utf-8?B?Sk4zYk5WZWlqSkZiSTRGcVNmQnlLeHJpc05xUTZlTGZYb0o3aFlUVm1VUzE1?=
 =?utf-8?B?aTJ3R0NWaE05NGF6YjhxK0FIUS9IUCt4NXBMYlFSR1o2S1hJSG5SU3BhczZi?=
 =?utf-8?B?QTdiSDlEaVMvOWlkYWFCOENOa3BsU25Wd1R0UGJ4c05HMkxseHdFMFU1WU1Y?=
 =?utf-8?B?Y0x4NVkvS09MRmk5OFVuUkNXMkg3eG9xdUROUmVtZ2dYTCtPQktkNWNaLzVB?=
 =?utf-8?B?MEhpdW5Yd0hKQ1FhTkIycGNUa3d4YUdmUlZoV3hWRWdzSXZVeG9SK0Yralpa?=
 =?utf-8?B?UkkxT2F4MjMvN0FJWWdpZldkRXI3dTJnRi8xbGRhRGVaaXdmcXd5N3F2ZGZU?=
 =?utf-8?B?YnRlRWFZYWpYU2hyYlZaY2JuMjFSNXJMZTcwbkQxQStXVmh0UUNSc3QyMHJm?=
 =?utf-8?B?eDV0TEhnaFB5MUJ6RGFjRWtmNkFwbVRpNGRXNWRybGZvZDllRWxLYWVPdkhl?=
 =?utf-8?B?UFdrSkFmSHdxWGcwTG50Ti9SeWhIdnA4bEhUT2dIMWZlQ2p3YmkwNDF6TWVo?=
 =?utf-8?B?VDhxTzJTR1l4ekY2dDhGV3JhM3pqUEx2bHRPdGs4VHl2aWRjQU55N2lyNnBN?=
 =?utf-8?B?aXJqbFlSMEdTM2VDczRpRC9hUHpVQkd3ckdnTjdzbW1XeXdHV2gvd29WTVQ2?=
 =?utf-8?B?YklyQ3pHWVZUU3JEbndlV1o5MDRqa1ZkUmc1ZTFoU1lDTkRZM3puc0tJS0Vj?=
 =?utf-8?B?enIvWUN3YXhhZVZjUjdxUFlVYWozMTUvejByczRTQWJpOWFBZkZoeGFmTnBj?=
 =?utf-8?B?VHFXQVRhaGF5NGhYZGN4Nnphb01uWithdGZueEQwNnBOK2NRdVp5b2FoajRn?=
 =?utf-8?B?Mm5HTklTZmlrMzNrbDNLWjAveVRQM3JNUVZrTGZVZ0pqQkwzMFpKYjd0RHFq?=
 =?utf-8?B?SmpOTFM1S2oxR3JwdFZpbWRhOFNNdjJHMkRlbjJ0ckVyalFSRzZuMmZ0R0lU?=
 =?utf-8?B?eDZCcnBLM0xla1VxOHlTVnpTRnN4UjMyQk1xbUlsdWdKeHBYQVhReGIwcXVo?=
 =?utf-8?B?c3pHU1ZoVnJxZFRIRi83S0pMQlhJZDBxR0lJNGxIK0JVazkrMzZLbUNvY1RN?=
 =?utf-8?B?cGd6d3R0VnF4MWxROS9oNTBYWndaWGUyQmx3MFdtYTVpd2FkbGxTMG9YeVpW?=
 =?utf-8?B?U2RvajVTdGZKazVJWCtqUXVQaUNJQlJsbVVGNWxJaUg0cHNaaytHRlRnalJW?=
 =?utf-8?B?N05vQmdrZFRkZkJsTTU2NmVXaWNtNUUyTFU2WXJpQlNmWlR1b0VvUFFHcWxW?=
 =?utf-8?B?a2xpVWx4N2g4Q0JPRTNUeG0rdjk0TEZoRzBLUElRTHNoQnpCSTZBZGtyejRi?=
 =?utf-8?B?YytLMXRtcGhSdTc3dm1tRm9NK2huR25CQitraTNSVmdQUVozU0ROQXNIc1FJ?=
 =?utf-8?B?VmN1TEhzdU16ZTdyRU93alBHRVlPNGQ0cllKRFNqVllwVm9NKzByY3Zibzg3?=
 =?utf-8?B?ODdiQnc1NDlGOFh6STJrM3FpalBiQnAxbGZ3YnMwb2xKeDJUSjJnVUpncWQ5?=
 =?utf-8?B?REFPblNvWG13aXpaY1lHY29EYW1KM1puMGhKdlJXSE5TR0hOV3Btb254NGpS?=
 =?utf-8?B?Z3ovQWEzQXJUNkM1V2ZHcjFxRmV3SGNTVmxRQ2NHZlVXKzB4T21yWkFrVWZ6?=
 =?utf-8?B?MXh5emVGU1Q4cERIYUhIUUI0Z2JHSVhkQXpLYXJ4Ync4WXBOY0VMV09NSlMw?=
 =?utf-8?B?T1pjU3FzQ0IrbGdnVU5EakNmczVQR25PWVlteXlHZ2hSdnJ4MEd6Q3MwTmRt?=
 =?utf-8?B?UkM2TkZjblZ1VkF1SlZRUUdkY2hCYnJhV3hPWFhjTS96SFY1T2xoZmp4QVp1?=
 =?utf-8?B?anpjK3J3V3FwMDFsaU9EdjExREQxTWZXZkdKN0s0SEVJSFRTSEhWdjNZbDZo?=
 =?utf-8?Q?L03+rxh3xmnL+MdUjYE1ytTHLhPKLXtP+npp+u4fMEcC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVcwL3ZMTy9vMDJRNGtuTFBlblJmbE5HZmtCWU5wb0tzM3BTZmJaUXIyQWln?=
 =?utf-8?B?cTRvVXdwbnl3c2xIejlON2pNS3c4U0VlTTBDVURlYjZwdVkzU2s2bk5JcXVO?=
 =?utf-8?B?MWl5K2RpVDhNUDdXZWx4VTMvMlZBSHBpU1NPL1NVTDliTVdYSkF1Y2h3Umdi?=
 =?utf-8?B?OVd4K2U4cXVUVWJ4aFhLOHR1VG12cW01MEVwSE4ydXVaOEIyMTlqNjZGVEw1?=
 =?utf-8?B?RzhjY3FNV1JKdHhBdXN1OTMxczFMbW1TOFNaRFg0UzgyQWkvRDQ5K1JVUGZM?=
 =?utf-8?B?NndadGxRWWFBMGpVNHpXRzhDRGdSREVFTmJadUVzOTBxcjhWVVR2ZUpVSXJv?=
 =?utf-8?B?L3VWZ2ZZYTN2MTRtYTRiK21UYVFwRWxaaTBZTDNMU044bXZPQkxFTFJuT1Vk?=
 =?utf-8?B?ckxCdWlVYnh1QlJUUFhabVVyZTlFYkRPMFFFMEtnL0JlTXNOaFRSWU9iaS8v?=
 =?utf-8?B?YkNqOXowYmlJUUhrYW4wVG5ZaVR3Z1F5bnhBNW9ZVHhjV1BPNXNhckNlLzNa?=
 =?utf-8?B?SmdkMHlyNHljS0ZvTkhYUW1zUU5DY3BvVFVBczZZRS81ZCtJODliK01PS1ZF?=
 =?utf-8?B?WmEwR3NvWkx2bG5pUnZ4QVoyaFNJeUd0Wm01c3NqWWFJM2lZS0J6cU5YdWVy?=
 =?utf-8?B?S1Bna2tIMUdsdjd6UVdQZGxGTXNCZUxFZWdXY0Y3bzVUTytLV1FhRWlzVXk4?=
 =?utf-8?B?M00xTmJ0bjNEb0luME0xN2FhbytXNVYzcW1TcGl6bi9oRnFLaVNvdC9wV0tU?=
 =?utf-8?B?QStmYjlIYldVSks3a1ZEb1UvNXVCWkZJZDA4UXRPSEZPci9BNlNUN3ZWblRC?=
 =?utf-8?B?SzNCUWNLOTIzS1ZDYWRvdjc2WERZcHpRSG53RmN0WVByTU1MdmdVWG4yV0Zm?=
 =?utf-8?B?RGZ5TVRXODhnbHRtSlF6cjB1OEc1dHVxRmZZQWoxcEVpbmhMYStlWmpBZTB2?=
 =?utf-8?B?Wmc1enRZTXA4aEYrLytMOGJ6a0t3b01Wc3EzaXdsR2hNMlB2M1d3RSt1aDJV?=
 =?utf-8?B?b3JoY2kyMGZLQzl4WmpaVENlaVlnRHpiZDZtN29obGVqZ0Y5Y0hGd29aWEJW?=
 =?utf-8?B?Q2FyaXNmeVdxT3BoaHZHdWx4Y3B4c2gxR0EvU1RwMWYveTFnVUNNN2Ruemsw?=
 =?utf-8?B?MWpseE10aDNTYk94c2hNSEZ5bEViTk1VRXh5enhPcXFvMzVOL1dsaEQ5Wi9q?=
 =?utf-8?B?Ym9HbmdHRkhvL2JBb3JTU2JsZU9xWmlVVTI1a2EzOExseTN2clhkaFFTTzMv?=
 =?utf-8?B?VFBCcnZkWll5MXF1c1cyZHFWVVBZN1R3SjJWbU9yaTNSV2VaTFAzNUZtMmRG?=
 =?utf-8?B?T1FZbXVQUmNaY1hpL0t4WFdIZ2t5RXczQnY4bDQ1dWdNZ0VtMUlDMm9Cd1d3?=
 =?utf-8?B?K0hCOUt4NlFSeFQ1U0Y2YjVqWmYxVVJmeWg5REloRHBRN1NhWVZqMFhGU3dY?=
 =?utf-8?B?NDBQU0k0UVBtQjFsTk9hbnlFYUJSWERiMnhXK3BoalozMjBnNW04N1RiOGJr?=
 =?utf-8?B?YWFsbHhIZDBSbW93OFpnaHQ0MTBCM0RzaTErNi9JcFlsa0JTY29URTIxWWpi?=
 =?utf-8?B?a09aVENtb2dJd3NwMFR2ZXZVdVBNenlNKzd4V2NQS2o1WTJrVEwzL3QxdWt0?=
 =?utf-8?B?THo1QmFyOXQ2cWhHRi9wb3NSZk1QN1JsVHNtMGZKQzVJbnRwclA5VjJldkV4?=
 =?utf-8?B?L1k1WWNvTWkyd1BobDNQempPU29HSVUrM1IzdmdtNlp0a0JZZlNZZmJtSkUr?=
 =?utf-8?B?ZTlnV0VwbE53WHRCaE1UMkpDRVlzbEUzT1BHZCtodXgxWEtIS0xnZzRvcGNq?=
 =?utf-8?B?M2Y1NmQ0Q3RGZ3IzdURQQVpISFI4dHRreXJIODdIbjAwbGxZOVUxeEZQQUE0?=
 =?utf-8?B?MmU0T2crSUFVNFJXZXZsOWEvWENjc1FBLytlYVJ4TThPY21tUU03L2tsdjg0?=
 =?utf-8?B?OEZYWmNXdDE5U1AwVVhYQTA2VEdvVDMxS2RpVmNzQW1CR3E4a3NibkRPd3l0?=
 =?utf-8?B?VXRiNGlEWVh3MjZqN1NpWXBXcmJwazNNVmNTWUNpeUNqSm5PYVVhOFErdnZK?=
 =?utf-8?B?VlB5WXBnSTZIeFRUWlNldFZuT0p4ZU9UdjNSN1poUDZ6RmJEMkNOUDVLY0I1?=
 =?utf-8?B?bFNlenJGUU16TjRLSXA0T0pMZlNzMFhSS0Zxb3I3bFpZL0hwRENhTEZBSE1Q?=
 =?utf-8?B?Zllya1c4WWpiM1ZncWROYm1MdC9USkU1QzV2ZDFMQjB1WEIrTDdnZVdIRGp6?=
 =?utf-8?B?WVJoK1ZEYk56dS9LSDhWYVhpZUxmSkFvUkhhOTlDWnJYdmhWRXdTWk45L1Ev?=
 =?utf-8?B?akJrK1dHbmI2WEpiaUhPaXV2Nk42b2dOWGJ6Zk1OYXV1dGtKdUhsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab2a03a-2c56-48e6-a1df-08de65635763
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 09:37:27.5278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9tIJTxKo5HFfbLJN6SCdw4LC9B0PIUDIEv9oKhGfkfjfllxrKMjvjA2cfckW58E0/QaBeAbo7K29SEGLh8yxNzwfrbMapND/1aDZ9wt5VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFF9F12DF7E
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSB0ZXN0cy9mdW5jdGlv
bmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjOg0KPiBVc2UgQVNUMjcwMCBBMiBTREsg
aW1hZ2UgZm9yIEZDIHRlc3RzDQo+IA0KPiBPbiAyLzYvMjYgMDY6MzMsIEphbWluIExpbiB3cm90
ZToNCj4gPiBVcGRhdGUgQVNUMjcwMCBGQyBmdW5jdGlvbmFsIHRlc3RzIHRvIHVzZSB0aGUgQVNU
MjcwMCBBMiBTREsgdjExLjAwDQo+IGltYWdlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vZnVu
Y3Rpb25hbC9hYXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDBmYy5weSAgfCAxNiArKysrKysrKy0t
LS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiA+DQo+IA0KPiBUaGlzIHBhdGNoIGlzIHJlZHVuZGFudCB3aXRoIHBhdGNoIDEwLiBQ
cm9iYWJseSB5b3UgaGFkIGFuIGV4dHJhIHBhdGNoIGZpbGUgaW4NCj4gdGhlIGRpcmVjdG9yeSB5
b3UgdXNlZCB0byBzZW5kIHRoZSBzZXJpZXMuIEkgd2lsbCBpZ25vcmUgaXQgZm9yIG5vdyBidXQg
dGhpcw0KPiBjb25mdXNlcyBiNC4NCj4gDQpUaGFua3MgZm9yIHJlcG9ydCBpdC4NCkl0IGlzIG15
IHBhdGNoIGZvbGRlciBpc3N1ZS4NCkphbWluDQoNCmphbWluX2xpbkBhc3BlZWQtZncwMjp+L3Fl
bXUtd29yay9kZWJ1Zy1xZW11LWEyL3YxLXBhdGNoJCBscyAtYWwNCnRvdGFsIDY0DQpkcnd4cnd4
ci14IDIgamFtaW5fbGluIGphbWluX2xpbiA0MDk2IEZlYiAgNiAxMTo1NiAuDQpkcnd4cnd4ci14
IDYgamFtaW5fbGluIGphbWluX2xpbiA0MDk2IEZlYiAgNiAxMzozOCAuLg0KLXJ3LXJ3LXItLSAx
IGphbWluX2xpbiBqYW1pbl9saW4gMTYyMyBGZWIgIDYgMTE6NTYgdjEtMDAwMC1jb3Zlci1sZXR0
ZXIucGF0Y2gNCi1ydy1ydy1yLS0gMSBqYW1pbl9saW4gamFtaW5fbGluIDQzNDUgRmViICA2IDEx
OjU5IHYxLTAwMDEtaHctaTJjLWFzcGVlZF9pMmMtRml4LU91dC1vZi1Cb3VuZHMtYWNjZXNzLWJ5
LXVzaS5wYXRjaA0KLXJ3LXJ3LXItLSAxIGphbWluX2xpbiBqYW1pbl9saW4gMzMxNSBGZWIgIDYg
MTE6NTkgdjEtMDAwMS10ZXN0cy1mdW5jdGlvbmFsLWFhcmNoNjQtdGVzdF9hc3BlZWRfYXN0Mjcw
MGZjLVVzLnBhdGNoDQotcnctcnctci0tIDEgamFtaW5fbGluIGphbWluX2xpbiAzMTgzIEZlYiAg
NiAxMTo1OCB2MS0wMDAyLWh3LWkyYy1hc3BlZWRfaTJjLUluY3JlYXNlLUkyQy1kZXZpY2UtcmVn
aXN0ZXItc2kucGF0Y2gNCi1ydy1ydy1yLS0gMSBqYW1pbl9saW4gamFtaW5fbGluIDI1OTIgRmVi
ICA2IDExOjU4IHYxLTAwMDMtaHctbWlzYy1hc3BlZWRfc2N1LVJlbW92ZS11bnVzZWQtU29DLXNp
bGljb24tcmV2aS5wYXRjaA0KLXJ3LXJ3LXItLSAxIGphbWluX2xpbiBqYW1pbl9saW4gMTQ5NiBG
ZWIgIDYgMTE6NTggdjEtMDAwNC1ody1taXNjLWFzcGVlZF9zY3UtQWRkLUFTVDI3MDAtQTItc2ls
aWNvbi1yZXZpc2lvLnBhdGNoDQotcnctcnctci0tIDEgamFtaW5fbGluIGphbWluX2xpbiAyNTM3
IEZlYiAgNiAxMTo1OCB2MS0wMDA1LWh3LWFybS1hc3BlZWRfYXN0Mjd4MC1BZGQtQVNUMjcwMC1B
Mi1Tb0Mtc3VwcG9ydC5wYXRjaA0KLXJ3LXJ3LXItLSAxIGphbWluX2xpbiBqYW1pbl9saW4gMjcy
MyBGZWIgIDYgMTE6NTggdjEtMDAwNi1ody1hcm0tYXNwZWVkX2FzdDI3eDBfZXZiLUFkZC1BU1Qy
NzAwLUEyLUVWQi1tYWNoLnBhdGNoDQotcnctcnctci0tIDEgamFtaW5fbGluIGphbWluX2xpbiAz
MzM0IEZlYiAgNiAxMTo1OCB2MS0wMDA3LXRlc3RzLXF0ZXN0LWFzdDI3MDAtaGFjZS10ZXN0LVVz
ZS1hc3QyNzAwLWV2Yi1hbGkucGF0Y2gNCi1ydy1ydy1yLS0gMSBqYW1pbl9saW4gamFtaW5fbGlu
IDQxMDAgRmViICA2IDExOjU4IHYxLTAwMDgtdGVzdHMtZnVuY3Rpb25hbC1hYXJjaDY0LXRlc3Rf
YXNwZWVkX2FzdDI3MDAtQWRkLS5wYXRjaA0KLXJ3LXJ3LXItLSAxIGphbWluX2xpbiBqYW1pbl9s
aW4gMjkwNSBGZWIgIDYgMTE6NTggdjEtMDAwOS1ody1hcm0tYXNwZWVkX2FzdDI3eDAtZmMtU3dp
dGNoLUFTVDI3MDAtRkMtbWFjaGluLnBhdGNoDQotcnctcnctci0tIDEgamFtaW5fbGluIGphbWlu
X2xpbiAzMzE3IEZlYiAgNiAxMTo1OCB2MS0wMDEwLXRlc3RzLWZ1bmN0aW9uYWwtYWFyY2g2NC10
ZXN0X2FzcGVlZF9hc3QyNzAwZmMtVXMucGF0Y2gNCj4gQy4NCg0K

