Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2A6C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvum-0001vs-24; Tue, 29 Jul 2025 21:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugvud-0001pe-Ij; Tue, 29 Jul 2025 21:47:28 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugvuZ-00040j-VV; Tue, 29 Jul 2025 21:47:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNj3RvYXq6ZJ4Erp275hAEJ7cbmigIYOv/lxzF80K3TnRLbQO+LUGrRTwKKdQ4R8AeCXx40EE+NQ0OavMi1E0bOm6WrTOdoNjnG8mLxeW4e4+3r+Vkk3qKjeQIM66zZoUvMNtXHe5kheydVxReIj/UmjLKwcCbquFJRMUyibunBQnPzLa4H03Z5uIFqnc5VBOrTtNxPJgAenL30xSpOhQ3BTJbaCIyhUShWDKcEuIx7nMDbbfcXNudvgyVjQGQzkWQ/Fhr6okevTrZA4g0GCxpPrAiVRtPSQYTuu+RSkvun7cb5cxWC/Ep9dPYmrRTZcTeuilbSQ00jEVkcdXz09mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmCNrZV4Z2N8dfY2DAq8upxYR51EeJ5IyAWqqBYHxY8=;
 b=IXROUI84E4Pf0Xt4OPy67ewQM7byHSe+KY5zf/c+Ly7EYK4a9NtAPc3lNb54haac2twqenjb0VZnWVe87B1ma2TJ99Aaf4d/Q7VwDWz1LuVm1W9dbfIloXxAbnI+pj1RJtSbZ/oaMRV7h0FVWKTVkCO+uiwpNwSX/FEehx5Mnss/ajEJ+kOAUPr/brUOnOQDlggqme5/vNZuywscUB24nvsgZZm3BNJpw7Q/6jdbC81ahwD7iQlbHun3C1sUkqk1tciRyhzr9e1BCPNT2z8Kwoxp+Vmbj/Dp31ekUjh4Z3E3RNkwOpRTJviCD/zglcqRtEO0hhmN50wv9g5GBqf3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmCNrZV4Z2N8dfY2DAq8upxYR51EeJ5IyAWqqBYHxY8=;
 b=Nkfr8wAOBCb8VAzYDWYvmXu3Ol3VovgRjOI4EOzOjYuukbf4+tnOPusQWIowFpb2eOkPQD0JgN3kxB4QoNHYvpEy2rnyNxyLxqJ9duH1RtDrSMQ05c7X1CUMM232dLHRtvo9Au9Q/5KjI7lxvT+iDiww/SHbWjRxMLMa4Sj/joJGsEmFqRZNllhZjv36P7R51HZVCfv59GJSxachUoIGJJICv+oEYqvxTEfypLhiDhcCc8rlaDD27mqm37WaYtOUnbmGvKWkRc0JdiNH02D55nM6To5zj4hpLV53TWImS9gF6T6fCwwQGtLES8y0/hmAxGzFq0spAPcjtSnV2jrwOA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB4991.apcprd06.prod.outlook.com (2603:1096:101:3f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.27; Wed, 30 Jul 2025 01:47:07 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 01:47:06 +0000
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Hao Wu <wuhaotsh@google.com>, Havard
 Skinnemoen <hskinnemoen@google.com>
Subject: RE: [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with SSP/TSP
 SCU initialization support
Thread-Topic: [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with SSP/TSP
 SCU initialization support
Thread-Index: AQHb9sytNnqHTsl+Uk6K5yNks8BQkLRGchMAgAC3/gCAAAHtYIAABDKAgAAHqcCAAaxBgIABEssQ
Date: Wed, 30 Jul 2025 01:47:06 +0000
Message-ID: <SI2PR06MB5041AE22A67A0111F9ABF2FAFC24A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-20-jamin_lin@aspeedtech.com>
 <7e5dc89a-7b74-4a5e-8f51-55f587a4896b@tls.msk.ru>
 <364b86f6-6147-4e63-bcfa-932c39072130@kaod.org>
 <SEYPR06MB50372F288CD26111DD6E0D81FC5AA@SEYPR06MB5037.apcprd06.prod.outlook.com>
 <4e5dcd10-4f61-482f-b232-f29952294d46@tls.msk.ru>
 <SEYPR06MB50373BF4F61F85E10DAC6E01FC5AA@SEYPR06MB5037.apcprd06.prod.outlook.com>
 <b90552f9-e707-4430-b5ee-4a98f4c05734@kaod.org>
In-Reply-To: <b90552f9-e707-4430-b5ee-4a98f4c05734@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB4991:EE_
x-ms-office365-filtering-correlation-id: ececb1de-eb0d-454b-4751-08ddcf0afd9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c0tvSG5GVUhLQ0FqQ2g5L1UxMFJHbnRRNGR3S3d6cGVlY3owM3FFZ0pnR085?=
 =?utf-8?B?Zmp3d08rTU5lQWVKa3NWdzM4TTJsSURqYjRPdUpYai9lUnZxOGdHenR4OVpF?=
 =?utf-8?B?ZE5LZkRhVFlWTDVIRzZ5TEE5bFJVQWl4MnUxUnU2VGkrVVVsSGNNYTFNTVc1?=
 =?utf-8?B?UFRKNVpNZHBYWmFCU3dnb0gzWGRVcC9QQkFtVW9lK1QvRWxpK0RlOFg4dzRZ?=
 =?utf-8?B?QTRYUEdsUHJmUzRzSVRJdnU1akZPRGFMRXI5NzdIUi9EQ3VCWEcrc2lFTVht?=
 =?utf-8?B?R1JxQ1drbEhvSXl1R1Q0TU42aHJZWUtzaGlvTzc1UVc2anRrV0ZiYlRpRDht?=
 =?utf-8?B?M3EvZVlWN2lwMElQQU12WFQvZmlQM0VzZVBaeDYzMnJNUDBFTjFHdkgybTNV?=
 =?utf-8?B?VFNoQXMxK1hhSTBTRkIwNmh0QjNTc1RpMWNFSHltWElWRWdzN1pYV0Y1Wmc2?=
 =?utf-8?B?UVMzbmVjOXhBSEYzdXMySXVOdlVDcjkxZms2SnJXZ1d6aEMxcnRqamlvUVVh?=
 =?utf-8?B?ZmlQNER1T1daYklhUTV3bDV0UUFjKzI4dzIrRmlZUnNNVTdkMlQvTEhEVmFa?=
 =?utf-8?B?ZEZaRXZHK0NEMW91RERvaTlRVjRRRC81TkkvaE9sWjYreGxrdUFDM2pqODMw?=
 =?utf-8?B?dkVzVXdiTldEQTdTSHJjallRY01hbEZSa3JBU09tZ3hNeWVydE1PZmVKU2VF?=
 =?utf-8?B?dGJzUWZzSGtsLzZ1cjMrMXpyaEU0akZCYkRKNm1zWUJFQ3hvSGpHMHNERllU?=
 =?utf-8?B?empCTzc2RFVPVXpBZEdXUk9PcXNiNlBLbzFKUlhEeHhGNDZLaXpZOGhpS2ph?=
 =?utf-8?B?VEExbEtTN0VSZUpDcnJEdCtTWk85aEt2Q1NVeTFybnFRazVwV1N0VUNuNTFy?=
 =?utf-8?B?cTdDWC91aDMrVWRlT2FlWTljV0lXUUQyZVd4LzVmdFU2QXc3eXJMc3NLSTYv?=
 =?utf-8?B?SFlwTjBzd09aWDZtSU1BTklpWGh2R1oxUm1SNTdOcjM4bXY4dnJCMlBXSTMx?=
 =?utf-8?B?RFZlSFRFbWNtbG9IUVA3ZHhLNXc2Sk9ZVnU0QWFybUxxaUdaaTZZUTAxTUJl?=
 =?utf-8?B?bmo4YlhuSkRIZGVlR2JLWjNtVi90cnVJWDJDNUduV21UWmFKNUFObG5uemRi?=
 =?utf-8?B?RllkQUxpVWlEVUVtTzRoQ2FrVFJLM2ZiUWo2ZGNydS8wNnQwRkErQlRKSUE2?=
 =?utf-8?B?Z0ZFSGZncU5LdHAwZkVFdXVXN2M4d0FxOFU3VmVyS082eEFLWDk2eTU4eGlx?=
 =?utf-8?B?UjBtZEJJc205SGNXQnB0NE1wUm82bDBiNHNLNGlQUUZEM0d6ZEd4WnZjSlMx?=
 =?utf-8?B?Y3p2aHNncSsycDJCNHJ5UDlraGNBTXMwYm5rUXZBZWdBdkJPc0JldjZ0MkxQ?=
 =?utf-8?B?SXVLd3pHYURhTkhRNkUyYzhZVDk5YnBEc2Z6cUdoZW1hTkVDOGdPVW85dmRr?=
 =?utf-8?B?ekVYVDVHNFhkaWh2ZGtaQnlBUTYyQjNYdnBMaW1JeHZmSGw4elJCQ0VHVHNL?=
 =?utf-8?B?VUZ1RUw3N1phTXFCUzRscGs3Tm1KVFFRbDhJRGxrcmlQQjRLOExYazlObWhq?=
 =?utf-8?B?c1NRZFhVR2xMZG5rZnJyTXBMRFBBbW1yRlNuR0txNGQxU2dvNFIwVTZwcDNE?=
 =?utf-8?B?aUdPSkdDYnBWNFBOZ0VNS3pYU1htc1J5WWV3Q2tOQVF6VXJlREdVVjk5Q2VZ?=
 =?utf-8?B?cVRvRU9pZU1HQ1JFMlA5M3FqMUJ3b1RFbmNzcTFaMUN1WFNzeXhDRVBJenll?=
 =?utf-8?B?ZzdXSlNYMjFZQ3c4bzRFNDBkaUxRTkQ1bC82N2drVWM2RnhVMVloY3VmNFJx?=
 =?utf-8?B?Z09QNkdJbVRWR0pqM0wxd2pFQllBZjU3ZmNmTjh0TFVrdzVHWG56aGdINWJV?=
 =?utf-8?B?KzdmZmFBcjJjclNVbnVmd2J1a2hpL1MxWlA0bHJpY3dQaXZFRkduaWJ4TXpr?=
 =?utf-8?B?azM1M0loOWF3bVF3MDhMU3J4UzlqY0JOdHd6eUZDKzBMUERDcHhxYmZadXg2?=
 =?utf-8?Q?oOs9Ne4VDQYt8EQs/NiFXbzC547uM8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1FlWUd5ZE96UGdPY1hxdGpoYm1tTFFqR2FqbXBTRFc4dm54ZDMrTFhoMDJ6?=
 =?utf-8?B?Sk9HUGd4WHM2dXRNaTJLSGd5VGRyMlhDNmI3SkdvalhmL2hBa0VqdEM4STJT?=
 =?utf-8?B?cEZ1cEZFODBhdmVBcHZjenMwUUZKVkNjeHVTQTY3RC9IaWdzNGtaUzd5MFlo?=
 =?utf-8?B?VFZKZVFiWmN2Q1J2QVI3ZVRwSS8yZXJhaEZEQmJCK3hoc1pHK1E0RitBL2Nn?=
 =?utf-8?B?NXVsZ0Q0MmZXNlB0aHJTaEZSTlk0R0tLTExxbWFjYlEzSHhVc3ZVUHhPVllk?=
 =?utf-8?B?Y1AwNGo4VWoyTVdzT1RmdHhkVnZ6RVRpYlBtbVNpN29wallOZEFjOWNhVy9C?=
 =?utf-8?B?UmJKdExaYmU5dks5VW1naFNYeXl1UUhrQTJESUlHTlNFWkxhQTJTK2E5WGsw?=
 =?utf-8?B?c0duZU1CQUJVdTdSN05uSmQrSHJCNEU2Y1pCcURncnlndFFCYmlDblJUVERH?=
 =?utf-8?B?bUlES3ltN1FRWnkxaU1PN21yMHZRWWM3MVBnL3h1aERpbUQwMGR5SlkwTzNO?=
 =?utf-8?B?MXppd3ZEYkRsVmxMNWxOWmJrNk9FeXdmRHZ2bHFzSnE5c1o1TTA0R3BKamdx?=
 =?utf-8?B?K0tkMUdOamxSZzQ5ckRXNVp3ZTNMalBxTmNkeERQWHpWdU9ES2FqRmkrNEdo?=
 =?utf-8?B?cTR6ZkxVR0t2UFZjSlNjUXJyN2tLWkdVbjl1VlVGTUtjQzAzb0hiNHN4Qmpm?=
 =?utf-8?B?dnhDenlBa25EZGpIZ2duYUQvZWo3cTRmWThPbXdMNG5MWGxXSGlIUjNTdDY0?=
 =?utf-8?B?Z3lNNktNc2luSlFwcHY3OStHWHV2eHl5TTllc2JuemZ6SVFEMjNsNTBTeVRn?=
 =?utf-8?B?WFVsQmdDQW81Qy9KdWFEQzYwaWJjczdoeUlHRmM3bG9sVG9CS2U4SWJVS2FQ?=
 =?utf-8?B?b3FSRUJ3RGF6VnkyU0FpcVBKT0hWVXVIdFd1U05sZG9BcnVvdy8reU9OVUxa?=
 =?utf-8?B?TjN0UzF4N1Jhc1pNU3psYlpnRzZJeFcraHF5ZElhdk5NWGQ2aGpmdU9iQVZM?=
 =?utf-8?B?TTN2TG1ZQTg1TU02dzdhRzVOamtRN3ZYNzlJSjBhd2NMdVBMWlJYSldiMTY1?=
 =?utf-8?B?ajV3Z2ZjeGhmSFNyUzhaZkpwWDFvOWEvMk5URWF0S3I4L3laOHlXaHpUMmhW?=
 =?utf-8?B?ZWpHanZRaWd2ODViMmRpUzByNExsS2R0MkJwbUhCRkhnckNtcVIvcjBCSTRr?=
 =?utf-8?B?ZC9qRTdmYU9jWTc5aURPK2lsei9DS1hlUnZlQWtqUUpoTVBpUjZ4eDN0c3NI?=
 =?utf-8?B?M09PT2FMUE1FR3MrMFdTQVpWYjJGV0VMQ1BPZEVpSnJPV0gvZFVsL0FNZXp6?=
 =?utf-8?B?T09GdHVzdVFhNTh3MWx6eVcwVVE2c1NtdmxvZWltY3dFMThKVld2WHZiVGZR?=
 =?utf-8?B?cEp1cnlHL3dxUzkxRlk3akdHdzl4d1MyNFFvRURUaE11SDcxK2xkdThsMUxC?=
 =?utf-8?B?djF1U3llQW1hdGxHMzcrekFWYnNJdFFodWRlSWgzOXNjY0Y5UU9DZlpPMWJu?=
 =?utf-8?B?akRRR3BLNGNkT21OVk91M3BnTmh6M21ZczdYSVRka1Z6WDY0UFB5WkUwOHBD?=
 =?utf-8?B?c2xWUXh5OC9MQ2RZWlVLclpNSjZ4MHd5S1VPTThobEtlYVQ4dW4wSDNvWGhI?=
 =?utf-8?B?S3M4bFBXdXQzRURlR0lJcS92MFV3a0FNL2oydThxeXhtMEhKM1BHRm9TUy9G?=
 =?utf-8?B?Q0JrZ3hJQk8vSVJiS2hYcmZNb0lkQys4MTJWelhwTlhBamVySFB1N3V5VW5J?=
 =?utf-8?B?THJXb000b1Y0bXJrZm1pRHpaVldmTjYyajlYVk1nWkVoZ08rVFZFVkN4SlVm?=
 =?utf-8?B?QytRNjlKTHRQNW8zY0N4TU0waXQ5OXJwRlVsekRhSEJjam95Y3RpZWpyY3ZL?=
 =?utf-8?B?T1pnZFdvdmN5bVgxeVZGVE1iSzJtYms5Q0ZWenE2b1l1NDJ5ajNmeGo1MVQw?=
 =?utf-8?B?ZUk3VzhIWENybnAxNjRhK0VGdlVhMENkMEFhSUJDaTdlSkhBWkhzby80cGQy?=
 =?utf-8?B?LzJVaWo5SXJ2d3JiUnExQ0daS3l0TW56ZTd0U01YaU5NSS9YY1VPOXovc3cw?=
 =?utf-8?B?TmxUUjFqSGg4UHQxRG10cHhyRk1ROXlUZHNuTDdET1M4S09aMXU2T2VxNkZL?=
 =?utf-8?Q?+AzTAWcelf3MJ0m4c5JQiBT5y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ececb1de-eb0d-454b-4751-08ddcf0afd9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 01:47:06.7524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKDMKOe8HlFXvy+qOIMBuPfLhL5FcuzRgKC3XRyyepQSSEed74rQ+hByJUWwqPhG9DsWq+7eqb/qpynpWoBKLj78dof1XYigBa2xaEqnDUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB4991
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYywgTWljaGFlbA0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2Fv
ZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjksIDIwMjUgNToxMiBQTQ0KPiBUbzogSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBNaWNoYWVsIFRva2FyZXYNCj4gPG1q
dEB0bHMubXNrLnJ1PjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
U3RldmVuIExlZQ0KPiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0
cm95QGdtYWlsLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5j
b20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVF
RCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhl
cmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBh
c3BlZWR0ZWNoLmNvbT47IEhhbyBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT47DQo+IEhhdmFyZCBT
a2lubmVtb2VuIDxoc2tpbm5lbW9lbkBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDE5LzIxXSBwYy1iaW9zOiBVcGRhdGUgQVNUMjd4MCB2Qm9vdHJvbSB3aXRoIFNTUC9UU1AN
Cj4gU0NVIGluaXRpYWxpemF0aW9uIHN1cHBvcnQNCj4gDQo+IE1pY2hhZWwsIEphbWluLA0KPiAN
Cj4gT24gNy8yOC8yNSAwOTo0MSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIE1pY2hhZWwsIEPD
qWRyaWMNCj4gPg0KPiA+PiBGcm9tOiBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1Pg0K
PiA+PiBTZW50OiBNb25kYXksIEp1bHkgMjgsIDIwMjUgMzoxMiBQTQ0KPiA+PiBUbzogSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA+PiA8
Y2xnQGthb2Qub3JnPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
U3RldmVuIExlZQ0KPiA+PiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxs
ZWV0cm95QGdtYWlsLmNvbT47IEFuZHJldw0KPiA+PiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0
cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gPj4gb3BlbiBs
aXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRj
aGVzIENDDQo+ID4+IGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4gQ2M6IFRyb3kg
TGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IEhhbyBXdQ0KPiA8d3VoYW90c2hAZ29vZ2xl
LmNvbT47DQo+ID4+IEhhdmFyZCBTa2lubmVtb2VuIDxoc2tpbm5lbW9lbkBnb29nbGUuY29tPg0K
PiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE5LzIxXSBwYy1iaW9zOiBVcGRhdGUgQVNUMjd4
MCB2Qm9vdHJvbSB3aXRoDQo+ID4+IFNTUC9UU1AgU0NVIGluaXRpYWxpemF0aW9uIHN1cHBvcnQN
Cj4gPj4NCj4gPj4gT24gMjguMDcuMjAyNSAxMDowMiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pg0K
PiA+Pj4gSXQgc2VlbXMgdGhpcyBwYXRjaCBmaXggdGhpcyBpc3N1ZSwNCj4gPj4+IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL3BhdGNoLzYwN2E5NDNhNTg3
MjQ4DQo+ID4+PiBmYiBlMGZmMDg5N2RlODBhZWU5OGEwOTNjYWEuMTc1MzY1NDUxNS5naXQubWp0
QHRscy5tc2sucnUvDQo+ID4+DQo+ID4+IFllYWgsIEkgcG9zdGVkIHRoYXQgcGF0Y2ggeWVzdGVy
ZGF5IGFmdGVyIHJlYWxpemluZyBvdXIgcm9tcy92Ym9vdHJvbQ0KPiA+PiBzdWJtb2R1bGUgaXMg
b3V0ZGF0ZWQuDQo+ID4+DQo+ID4+PiBEbyBJIG5lZWQgdG8gdXBkYXRlIHZib290cm9tL2FzdDI3
eDAvTWFrZWZpbGU/DQo+ID4+PiBJIHNldCAiPz0iIHRvIG1ha2UgdXNlciBhYmxlIHRvIHNldCB2
YXJpYWJsZXMgaW4gdGhlIGNvbW1hbmQgbGluZS4NCj4gPj4NCj4gPj4gVGhlIHByb2Igd2l0aCBg
Q0MgPz1gIGNvbnN0cnVjdCBpcyB0aGF0IENDIHZhcmlhYmxlIGlzIGFsd2F5cyBzZXQgYnkNCj4g
Pj4gbWFrZSwgc28gdGhpcyBsaW5lIGJlY29tZXMgdXNlbGVzcy4gIFRoZSBxdWVzdGlvbiBtYXJr
IHNob3VsZCBiZSByZW1vdmVkLA0KPiB0aGF0J3MgYWxsLg0KPiA+Pg0KPiA+Pj4gMS4NCj4gPj4+
IGV4cG9ydCBDQz1hYXJjaDY0LWxpbnV4LWdudS1nY2MNCj4gPj4+IG1ha2UNCj4gPj4+IDIuIG1h
a2UgQ0M9YWFyY2g2NC1saW51eC1nbnUtZ2NjDQo+ID4+Pg0KPiA+Pj4gMy4gVXBkYXRlIE1ha2Ug
ZmlsZSBhbmQgdXNlciBvbmx5IG5lZWQgdG8gaXNzdWUgIm1ha2UiDQo+ID4+DQo+ID4+IFNlZSBo
b3cgaXQncyBkb25lIGluIG90aGVyIHN1YmRpcnMgb2YgdmJvb3Ryb20uICBZb3Ugb25seSBuZWVk
IHRvIHJlbW92ZSA/DQo+ID4+IGZyb20gQ0MgdmFyaWFibGUgYXNzaWdubWVudC4NCj4gPj4NCj4g
Pj4gRGlzdGluY3Rpb24gYmV0d2VlbiAxIGFuZCAyIGlzIGBtYWtlIC1lYCBjb21tYW5kLWxpbmUg
c3dpdGNoLg0KPiA+Pg0KPiA+PiBUaGFua3MNCj4gPj4NCj4gPiBUaGFua3MgZm9yIHlvdXIgaGVs
cCBhbmQgc3VwcG9ydC4NCj4gPiBJIGNyZWF0ZWQgYSBuZXcgcHVsbCByZXF1ZXN0IGluIGdvb2ds
ZS92Ym9vdHJvbSBhbmQgd2FpdGluZyBmb3IgZ29vZ2xlIHRlYW0NCj4gcmV2aWV3Lg0KPiA+IEhh
bywNCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IGl0Pw0KPiA+IGh0dHBzOi8v
Z2l0aHViLmNvbS9nb29nbGUvdmJvb3Ryb20vcHVsbC8xMA0KPiA+DQo+IFRoZSB2Ym9vdHJvbSBQ
UiB3YXMgbWVyZ2VkIChjb21taXQgMTgzYzlmZjgwNTZiKS4NCj4gDQo+IENvdWxkIHlvdSBwbGVh
c2UgdXBkYXRlIGFuZCByZXNlbmQgOg0KPiANCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMmE4OWFkNGM4ZjU2NjVkMDc5NTJhNGYxNzQ5Y2FhNmVjMGNkDQo+IDNkOWMu
MTc1MzY1NDUxNS5naXQubWp0QHRscy5tc2sucnUvDQo+IA0KDQpSZXNlbmQgcGF0Y2ggaGVyZSwg
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAy
NTA3MzAwMTM0MDYuMzg0NzY2Ny0xLWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8gDQoNClRoYW5r
cy1KYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

