Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9705DC88E79
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIWm-0006Zf-Cf; Mon, 26 Jan 2026 04:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vkIWf-0006Xd-S7; Mon, 26 Jan 2026 04:04:51 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vkIWd-0002TP-GE; Mon, 26 Jan 2026 04:04:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYfBh+JTX535uhnoHgQmPE647EjQog608DLNYPFS9JGOF7H9q6EtiumE/452c0WuuYRVoMLdDK0vYOp4ScDw7ltofilcCDk9uVAWoJQB2VWio3zD7NeM2EG+flP1nkzmtMs5pWRIZTxUh4eTScGBV97QlsVOcI20smKsJZo5lLJfiedTBoBdqZuoMHoJEWPFcj0xc7xBiC1tZjgJ3dwq8zFiUk8JcMciABgzu6g/8tvjr86cajDVSbo2cF8oQGWfXXGn2toqJz2m38HcBzDm41/OLHV/eLFc5mWB4Wm6eYIYMxwQKXfVbtXXVXaBXhAViJbGRWEmyE+O4EtyMacvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyxGaixk79iAA4Dy8idCw+UWQFyh77Zn6vKT0dg41vI=;
 b=gnUwbyxBrU9VABePg7uK6dlhdJ3fpT3Y4DHQTht69Gd2yPzIivC/6rVLYrPZdlPtBsWFYT3zOQdB0/B3Qm1gVK6++2F6Np7FWg+x1u3ah3A+Q2zhxamDxykfSpX7ihjOKXY2icmO8kG1+mV1AhOup4YigVMsaF/h/bg2UIBh7S3skmqxyLwmhVwJZhmD27V7cXhCoV+VfGZOcUsPnhF4aZrItVZGCslkWZtVTXcaeg7CmNJ8ZBOj8sG7gK6TTDUzE+kAl6Idz+bQH1fTjFv0KASmbDhcEliG70XPUwuxyiZWgmHH5zP6lyBAC1lkq8xGDM6NFHKu8OGECd88R4o9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyxGaixk79iAA4Dy8idCw+UWQFyh77Zn6vKT0dg41vI=;
 b=E1Rv2uxD01m3gIPhL3sBgYptnM/GHRwVJJ3dluN+hlTu+ikk5LnQHVcz+j7Z0UQyL38Rb/vNUgKeXEmF8iJfnvDHAydb+EEqN/Kbt3o6U/9cb7si+MCSo9Wu9ZaokoMLYL+0hjruLmPT820PcBE7NpOPhMx3+JPW1UKQ+JlV5QYjAQFrZnfcd/DzYTlfuRy4lZs7RZQVd6LWlQznscsSPyTfuLm9ua6rJgYEinfIoDa9Zkfj4nAoaRg13+Hmam52LlNExki59kXlfvMnpZ5QRaen+Haz9+c2ACI2PVGx1avnm9VUqKctbNODuTgNQ2+G9RKXwXQ0bOgvfn66NYDmZQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB5166.apcprd06.prod.outlook.com (2603:1096:101:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 09:04:37 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 09:04:37 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, Nabih Estefan <nabihestefan@google.com>
Subject: RE: [PATCH v5 08/22] hw/arm/aspeed: Attach UART device to AST1700
 model
Thread-Topic: [PATCH v5 08/22] hw/arm/aspeed: Attach UART device to AST1700
 model
Thread-Index: AQHcicxP3J71ft+vIkyv2f5cb8VNsrVkKzoAgAAFr3A=
Date: Mon, 26 Jan 2026 09:04:37 +0000
Message-ID: <SI6PR06MB7631F5D27EF338972CC4DE9AF793A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <20260120051859.1920565-9-kane_chen@aspeedtech.com>
 <45c2a602-15f4-4dfd-a228-490f8e1fe85b@kaod.org>
In-Reply-To: <45c2a602-15f4-4dfd-a228-490f8e1fe85b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB5166:EE_
x-ms-office365-filtering-correlation-id: 3fd7b68e-025b-4c6e-4575-08de5cb9ee5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RzJzb3NucHZnMmpmdzYvSW9SSFVoSmV1a3QvSG8ydTZXR2VGRzR0cEswWERE?=
 =?utf-8?B?ZDlnYzZZSzRCRndiNG04KzlFdWIwT0h2cEV5OXZlblZpTG1UQkRFWnh5NUlY?=
 =?utf-8?B?OHhVTU44bkFqL2pRMDVsQXN4WVc3TnIwalVpeWYzZy8zNFFQOURoU1NOL3h4?=
 =?utf-8?B?VGMxdFYwVlh6QjVseFlxUVBVa2VnQ08wV2d0ZUFRSzZiSDBGNWxxQTVpYXZ1?=
 =?utf-8?B?RmN3dC9vRGkwVWk4elA0a2xUdnVRWEZtblVlQS9yMm9ZNHdEWDdHRGFNMXFk?=
 =?utf-8?B?OEdEVUhNUzExNFpkK1ZLcGhQNHlZWkdTaFpzMFlaTHl0QS9SWEI3NVBmWVdC?=
 =?utf-8?B?VStyQkJUcFV4M3FWcUJwRnc5T2RsRFNzRzNFNXgxUDlUNm9IWjZkZWZSUTlz?=
 =?utf-8?B?ajNESktnT2s3a1FqQ29XOXJ2dFhnUEkyMXZqSlY2Wnp3UXE0QXFNNklnem8v?=
 =?utf-8?B?UkdTQUdQZG1sK0VuZVZ2MFplTkNJK3Y1eXV6b0Y2bHpMc05CRjV5YzcvMUNs?=
 =?utf-8?B?aDZsRVM4Q0Q0ZXB6aXY4K3QrTFdybWtza1dmWjFHNmxxSnlFWGFUdzd2aGI0?=
 =?utf-8?B?dGNEdWdzMEJNdWZzM2xqa2VDVC9Wam9ieVRWVkNscy9aT2M4ZEFuWGwzMGhQ?=
 =?utf-8?B?VFI4UHNjZUI5VUlxMzRDNEdaaStIbWUvQm1BY1EwTjNKaWtYL3FQdVFIK0VR?=
 =?utf-8?B?T2NhRW9hVjlOWGVlMUhiVXpVTFM2UWxQZWh6cE9XSTNnYWpSNVlJVEpKS3Mx?=
 =?utf-8?B?VDFLdHhGaS9MeVhOUDFFSjZDSXFIWC9ucU41WnlnZkhPZmtQT0FsTmxoWUJX?=
 =?utf-8?B?SUtYT2xORDlkRmpWNlZHOUVqSFM3eUV0QTV1Zzk0UXgxVlNmejJrOE91cWho?=
 =?utf-8?B?RUszQmJiSk0xSG0vbGFNZ1puaUF5dXhUNEkrdDRKSk9kVTBzeUFsTWVhS3Qv?=
 =?utf-8?B?djlzZXVjUEtHNWRHVlRnbGlONDgvR3BucmtkYXF2R05BRGdaWXhkRDNKU3ZV?=
 =?utf-8?B?eHJDanJrSGZ0cEJPdXRoSDhKWWVwbDF2WkpVNDJXMjg4ZTFGTmk1NW5SV2t0?=
 =?utf-8?B?V3UwT1k4aEFzc3hhZUs2eWtpem85TElqdHE1YXlZa1dkdGhQeFdQaGt6S2Jo?=
 =?utf-8?B?MStpT0I2aGpkODh4Uk5YekJ4bWdlVWhoMktwV0paNDJLUWRWYXNzenJqalZ5?=
 =?utf-8?B?OWNSTWwxN1hRL2FoUy9CMnFnbVgvL2hGc1hWWlRJUFZvMkJpemNkT0RsV1Y4?=
 =?utf-8?B?QTE3ZHIvNDVnMVNRRUVuRFNxV0k1N3pJTEQ1MklyV0Ezc0ZUVis0bVROam5Q?=
 =?utf-8?B?WkpnQklzcHNpOVBTb2dYNHRJZkk0ZityR3RIZWRDYlYvOTkydnFtUEVscWhl?=
 =?utf-8?B?UXJvRW9PMjlqNGhRcCtoRWhsbmN3aktqNTRjUTNQVlg2TlJMMDhEOVNvTFNz?=
 =?utf-8?B?NHZWS3k5bGJ6SXhXNnRkaGtiNTJzVlFTd3BaZGR3ajNyWmJZQ1dmc2p5c3Jp?=
 =?utf-8?B?Nm0xY2RSaXNWZFY2M011M1d6ZEVodHRnNitlbU5QSm1hVjFkWGJqeGQ2TDVO?=
 =?utf-8?B?K25yMG1wN2c3Z29XMlVSN1NJQlhEblFvYTJZVmVqQ2xtMWJDS1YwTEkvdjFv?=
 =?utf-8?B?RXVPR1BpQWZjbHZJb3dHR3NDTWI4SThrTGNlM2hlQ2tNOGswWGxpU21IMzZX?=
 =?utf-8?B?dDVPa0pCWHJFRHJtVlgwelM2enFFNzFTNE5KUGJVcXRvNnNvVHZWOWlabDcz?=
 =?utf-8?B?SXozdCtTYTV4V0FueEpLMi9XbllrSTdndFlHazB2Rktoc3lMT2hzREVPWHBR?=
 =?utf-8?B?YTZycFFFbHJCSENaYXdFQnR4ZTl6NjFBbEk1Z2VnZEg4cFZnaHhTSmJ3VTZX?=
 =?utf-8?B?YTRjSllicnduRmplOEhSSXVkSTh5aGRzcHdPUmUrY1Y0SVVjTzlIQTI1eWhJ?=
 =?utf-8?B?UUltQ1dmalpPdlpKYUZEOURKY05MUjFOYXE4Ukg5bVhuTTJRWDJPc214Nmd0?=
 =?utf-8?B?QWJzNURuVitQcGFOcDhzODFDTG1nSTZxOGthVU5UUW1QSUYwVEtiaTZzWnB6?=
 =?utf-8?B?NGZUZEdmZUdoeDVQanZlUkc1SENTcU4rTi9BNDV1b3JEOFZnNnl0VVNUWXZ4?=
 =?utf-8?B?QmRSdnpEc0x5eGFwdjNXZFgzdDhhcXVMTDdody9YWDlpV1IxazJ2WTFuMnRk?=
 =?utf-8?Q?0Y4DkHkp92GZzcf5i57Yzu4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi9Sa2s1OHNSR3lBRjJUS0hOTW1YSExSbHVEVmllbE1EU0F6VXZpYnZrQXJr?=
 =?utf-8?B?aVIxVVRvREpDbTZ3SzA3NmxrVFIxY1Nqc0pUVHM1U21mZWgzUWloS2xLMXd5?=
 =?utf-8?B?SnBjeVhNT2tvWTNNY0pRSXpHRGVSNzJsZDhyWWRpcktxdUMrd1pzWEN2WmRG?=
 =?utf-8?B?SEFLdm1YRmNwUmkySzErK2s4L0ZVaDdsNkJFU3pFalZLSkRTNWFSRkV0c3ZO?=
 =?utf-8?B?SFFzNlJudEVTMjFPdWxKMTg2dGRWQTNMbkYvQ2pDTjM4YmFXcVVvWDArNXJh?=
 =?utf-8?B?TUYzTnZUUE5iQ3V3UlFpcEI5U2RJK05aZnozZnMwV0t5a3kvNjEvYU4rWTdF?=
 =?utf-8?B?TzhxOWVacm56RGJPbERocDQ0OCtRdk9FbGhNc3A3ZFFJL1JCNXdEUDh0L0t6?=
 =?utf-8?B?MC8yQ3k4UGR5QWRNMTh0SmlWcDF6NXZEcXNraEhVb1kwdmk4OUVpc25YZ2h6?=
 =?utf-8?B?TlpUSlZVMmpUVU1SZzZBei9qcUpGekNoMGw5UlhyTUpDanhnaGpXMEhUSDky?=
 =?utf-8?B?ZkxJQWNyY0hvRHlyVVVZdjN6L2VBVTA3MHk4bXFOLzZQUVowQU1MNVhWOXhV?=
 =?utf-8?B?dUU1SnMvTFlFbkhYaHRhMEFoOXp4TldOOVU4V29lTjZRbnhwUmZhcFRRNXlj?=
 =?utf-8?B?VDh3bkRiQTlacEtQbFZKYXVDbzhZcFI1SUJFNlJodDV4Y21xS0x6eWVkc2FJ?=
 =?utf-8?B?KzQ5NVdYWGVYWHBGelUramFiN3lXS0I5M3ZlV1VtWEorMGphcjNRUUs3N1JH?=
 =?utf-8?B?ZWxDSEl6RFc3TnUvYW13Z2hvaFFBbHlGOFBjeXdJQnNsUzhDMmovSnZyaktt?=
 =?utf-8?B?aTlVWExIcS80Y1FZTVFVcHRjcUZMVWl4ZFpWMHNsa0UxZjRmUU55VXp1ejd0?=
 =?utf-8?B?bzVsdURjSjZHQVFza0MzM2xaZGRIckViT01jdUZIVk1GOFhzQUlWM3lJbm14?=
 =?utf-8?B?aTBKWUU3WjM0SXV5VFk0RjNmVVJmc2JUaS9Sek5Pajc1cStjQ1lTTEwwcFRH?=
 =?utf-8?B?S0VoZ1pVYklFRGpaSjZXcXM1cE5KcWpxZ3BzaVpnbmg3RHVLckU0d0YxUjFO?=
 =?utf-8?B?M2prWDVMaWdjcGc0WnhTK1pnb1l3QjdKcmZNVHFVQnZCUm5WNnZTN0M4d3dn?=
 =?utf-8?B?c1p6aGpwY2hXZk1JS3UyakFpQmJ4K1V5WVNPREtvNDZxd3RXdmFSRGZkVTRX?=
 =?utf-8?B?blpFdUE3YkU1dmE0K0piR2QyREJoaTRaOG0xQ0p0YzVYblZGTnB5bU4zSDZi?=
 =?utf-8?B?R1hHMURNVnNMOEt0NEgwdkN4OHBqNENCS1YrUXNJbEN0b2d3MDhzVWo4WGJV?=
 =?utf-8?B?eW5CWFZQYm1vVEEvM3dLSkc3clZGVDhSSThyaWJrTUw2R1pYTE9rTDZ5UXg3?=
 =?utf-8?B?aVRGeWZjMHdVakNaRDFEblFjOXNqQzIwM2w3NktoYVlRQXJ2cU12SFkrbHFq?=
 =?utf-8?B?YzBxN2JlQVRTU1U0TU1VemtFUFZVejNQKzY1T1F0OUpBc3VtaFVtUFhOVndn?=
 =?utf-8?B?WldHQjJSeXB0aElFN2RIdmpyR05jeWRmMWFRcVBFVTdXdTE1RkpDOXVQNGtZ?=
 =?utf-8?B?Rk5TcVAwM1ViVnJvNmE5cmpDcEMzdnQ3SENITVRJT1lWdExXdlFGaEYyclZO?=
 =?utf-8?B?K1daRE1Yd0lKbUM4N3AyMnNFVVJpUXV1aU8zQit1bC9jbzdKOGN4VkdCbzcy?=
 =?utf-8?B?ZVBuYm5SeWJ6TXZJcUYrdnM4U2lUZFliTGJaWVlGRGVWWEFDWG5kTXh2LzAz?=
 =?utf-8?B?RzRNMldIODRFY1d4enRNKy95SmQxRzM0Vkk1Y0ZMZm05cEdBdjlyUTZqSzl2?=
 =?utf-8?B?Zmp4ZXlkU09HYTNjQTUyTDZXelFhODBRaGltZEpDTTZybW42d0NVNXBiTXhM?=
 =?utf-8?B?RXNvb1AvTmxjN3dxeEQrYXdHNXNQUjV6cEpxSXZQc1FSWTJSNXNzcC9jNTM0?=
 =?utf-8?B?R0JmM0dPUWFlTmpGNjlKOWJXRnk2ZU5icnBuSnpZbzJrUFRubXprR2RveGZt?=
 =?utf-8?B?UHVYMlBhbnJhdVRBRzg1QWpCK2ZsZDJyWFZWSllkNDBxbmdUcUlTRlJVekd6?=
 =?utf-8?B?MHg4VHFzY1NMNS84Z3J4b2hqODZmTHBzT2JpOWRMMEVFaEUrRE5NdWZ5S2pj?=
 =?utf-8?B?TXhqcVMrN2hlV3dzVmVEejZORXdTc3RzV0xsOTB1SkduRVl2eENaOFNJSmN5?=
 =?utf-8?B?ZnlwZ3AwcVU3UklsV1EzeGNSWG9pSzBSOEs4Y1diNUNKOHJyTlJyWDB3ZEpL?=
 =?utf-8?B?SmpZRXllcGc2S09naEFib3JKcVlQMkExSmVEdXhXTVc2M0YxUHNJYjRSUFo2?=
 =?utf-8?B?RFI5T0tIaFZSZjl2N2RvSEZ4VUsvWmNQaklXaTNjUjB4RURtUC82dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd7b68e-025b-4c6e-4575-08de5cb9ee5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 09:04:37.0408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUyPVZNGvTV0zDk510B+FcX9u1XDBYPEv4I/1PMBpBOlYNT2vCL3Ik4IArWWANstDeRwnZgc0cg8ppfio6hQespTBP3naBgCP4/Q/GRw/BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5166
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjYsIDIwMjYgNDo0MCBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFz
cGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IG9w
ZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwg
cGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA8Y2xnQHJl
ZGhhdC5jb20+OyBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NSAwOC8yMl0gaHcvYXJtL2FzcGVlZDogQXR0YWNoIFVBUlQgZGV2
aWNlIHRvDQo+IEFTVDE3MDAgbW9kZWwNCj4gDQo+IE9uIDEvMjAvMjYgMDY6MTgsIEthbmUgQ2hl
biB2aWEgcWVtdSBkZXZlbG9wbWVudCB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4tQVMgPGth
bmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IENvbm5lY3QgdGhlIFVBUlQgY29udHJv
bGxlciB0byB0aGUgQVNUMTcwMCBtb2RlbCBieSBtYXBwaW5nIGl0cyBNTUlPDQo+ID4gcmVnaW9u
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVk
dGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2ds
ZS5jb20+DQo+ID4gVGVzdGVkLWJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xl
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmggfCAg
MiArKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDE4ICsrKysrKysr
KysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaA0KPiA+IGIv
aW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCBpbmRleCBhZGRlYTNhYjFmLi5iMTViMTNh
ZWRkDQo+IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgN
Cj4gPiArKysgYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oDQo+ID4gQEAgLTEwLDYg
KzEwLDcgQEANCj4gPg0KPiA+ICAgI2luY2x1ZGUgImh3L2NvcmUvc3lzYnVzLmgiDQo+ID4gICAj
aW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRfbHRwaS5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvY2hhci9z
ZXJpYWwtbW0uaCINCj4gPg0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVFRF9BU1QxNzAwICJhc3Bl
ZWQuYXN0MTcwMCINCj4gPg0KPiA+IEBAIC0yMSw2ICsyMiw3IEBAIHN0cnVjdCBBc3BlZWRBU1Qx
NzAwU29DU3RhdGUgew0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBpb21lbTsNCj4gPg0KPiA+ICAg
ICAgIEFzcGVlZExUUElTdGF0ZSBsdHBpOw0KPiA+ICsgICAgU2VyaWFsTU0gdWFydDsNCj4gPiAg
IH07DQo+ID4NCj4gPiAgICNlbmRpZiAvKiBBU1BFRURfQVNUMTcwMF9IICovDQo+ID4gZGlmZiAt
LWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMg
aW5kZXgNCj4gPiBlNGM4NTY1ZDNmLi40NTBjYTZmNWM3IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2Fy
bS9hc3BlZWRfYXN0MTcwMC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMNCj4g
PiBAQCAtOSwxNSArOSwxOCBAQA0KPiA+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gPiAg
ICNpbmNsdWRlICJody9jb3JlL2JvYXJkcy5oIg0KPiA+ICAgI2luY2x1ZGUgInFvbS9vYmplY3Qu
aCINCj4gPiArI2luY2x1ZGUgImh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmgiDQo+ID4gICAjaW5j
bHVkZSAiaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgiDQo+ID4NCj4gPiAgICNkZWZpbmUgQVNUMjcw
MF9TT0NfTFRQSV9TSVpFICAgICAgICAweDAxMDAwMDAwDQo+ID4NCj4gPiAgIGVudW0gew0KPiA+
ICsgICAgQVNQRUVEX0FTVDE3MDBfREVWX1VBUlQxMiwNCj4gPiAgICAgICBBU1BFRURfQVNUMTcw
MF9ERVZfTFRQSV9DVFJMLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IGh3YWRk
ciBhc3BlZWRfYXN0MTcwMF9pb19tZW1tYXBbXSA9IHsNCj4gPiArICAgIFtBU1BFRURfQVNUMTcw
MF9ERVZfVUFSVDEyXSAgICA9ICAweDAwQzMzQjAwLA0KPiA+ICAgICAgIFtBU1BFRURfQVNUMTcw
MF9ERVZfTFRQSV9DVFJMXSA9ICAweDAwQzM0MDAwLA0KPiA+ICAgfTsNCj4gPg0KPiA+IEBAIC0z
MSw2ICszNCwxNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0MTcwMF9yZWFsaXplKERldmljZVN0
YXRlICpkZXYsDQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
QVNUMjcwMF9TT0NfTFRQSV9TSVpFKTsNCj4gPiAgICAgICBzeXNidXNfaW5pdF9tbWlvKHNiZCwg
JnMtPmlvbWVtKTsNCj4gPg0KPiA+ICsgICAgLyogVUFSVCAqLw0KPiA+ICsgICAgcWRldl9wcm9w
X3NldF91aW50OChERVZJQ0UoJnMtPnVhcnQpLCAicmVnc2hpZnQiLCAyKTsNCj4gPiArICAgIHFk
ZXZfcHJvcF9zZXRfdWludDMyKERFVklDRSgmcy0+dWFydCksICJiYXVkYmFzZSIsIDM4NDAwKTsN
Cj4gPiArICAgIHFkZXZfcHJvcF9zZXRfdWludDgoREVWSUNFKCZzLT51YXJ0KSwgImVuZGlhbm5l
c3MiLA0KPiBERVZJQ0VfTElUVExFX0VORElBTik7DQo+ID4gKyAgICBpZiAoIXN5c2J1c19yZWFs
aXplKFNZU19CVVNfREVWSUNFKCZzLT51YXJ0KSwgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1
cm47DQo+ID4gKyAgICB9DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMt
PmlvbWVtLA0KPiA+ICsNCj4gYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAw
X0RFVl9VQVJUMTJdLA0KPiA+ICsNCj4gPiArIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JV
U19ERVZJQ0UoJnMtPnVhcnQpLCAwKSk7DQo+ID4gKw0KPiA+ICAgICAgIC8qIExUUEkgY29udHJv
bGxlciAqLw0KPiA+ICAgICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMt
Pmx0cGkpLCBlcnJwKSkgew0KPiA+ICAgICAgICAgICByZXR1cm47DQo+ID4gQEAgLTQ0LDYgKzU4
LDEwIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX2luc3RhbmNlX2luaXQoT2JqZWN0DQo+
ICpvYmopDQo+ID4gICB7DQo+ID4gICAgICAgQXNwZWVkQVNUMTcwMFNvQ1N0YXRlICpzID0gQVNQ
RUVEX0FTVDE3MDAob2JqKTsNCj4gPg0KPiA+ICsgICAgLyogVUFSVCAqLw0KPiA+ICsgICAgb2Jq
ZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAidWFydFsqXSIsICZzLT51YXJ0LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9TRVJJQUxfTU0pOw0KPiANCj4gVGhlcmUgaXMg
b25seSBvbmUgdWFydCBkZXZpY2UgcGVyIEFzcGVlZEFTVDE3MDBTb0NTdGF0ZTsgc28geW91IGRv
bid0IG5lZWQNCj4gdGhlICJbKl0iIGFycmF5IHN1ZmZpeC4NCj4gDQo+IFRoaXMgaXMgdHJ1ZSBm
b3Igc2V2ZXJhbCBvdGhlciBkZXZpY2VzIGFkZGVkIHRvIEFzcGVlZEFTVDE3MDBTb0NTdGF0ZS4N
Cj4gUGxlYXNlIHJlbW92ZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMs
DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIGNvbW1lbnRzLiBJIHdpbGwgcmVtb3ZlIHRo
ZSAiWypdIiBhcnJheSBzdWZmaXggaW4gdGhlDQpuZXh0IHBhdGNoIHNlcmllcy4NCg0KQmVzdCBS
ZWdhcmRzLA0KS2FuZQ0KPiANCj4gDQo+ID4gKw0KPiA+ICAgICAgIC8qIExUUEkgY29udHJvbGxl
ciAqLw0KPiA+ICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImx0cGktY3RybCIs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmx0cGksIFRZUEVfQVNQRUVE
X0xUUEkpOw0KDQo=

