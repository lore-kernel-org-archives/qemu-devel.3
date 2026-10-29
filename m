Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76431606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=PQDKQ7Yz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIca-0003o9-TH; Thu, 29 Oct 2026 01:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMIcP-0003nj-Sr; Thu, 29 Oct 2026 01:24:07 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMIcN-00070N-Ue; Thu, 29 Oct 2026 01:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXbG1DAzsORSyCEfAo/aP1meSxslXxw+h2wOQVAiktjZJwxdTC0p0MoVcjaD7i/4FF00W+mYlZnNwQlLzKZr6eDURSbhY01zTm8CrVcltbHxiLixoUhqa0t20LlnRxhwLAD14ObDXgi42YBqrOP9YzAFX4/PHDgweKnQfHzDZ8TaXGv/6zf+Kae05rxqfnWpgNkINdcAkfnnv+r+y7Gx57G+Dtr5zuMJfn/nMpdqCyQzuebLysHq15ca9jPSs/xyxKC15P5PyrBgkWnWc1c5q5Qm/jLDO1fpWJEosruQE1GhkwEfJqvqPuZ9cCv3JJsHnTKdW4oMj2qSYNeqpY6/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbPNoR19DNCHSaGjLFZl6PTAdU3Z6oRHuE9sZrPFHCI=;
 b=dGpHXwdabYoJAFjFGEhyieQ/XMLy1vqO707QcR3AWqWiVqXWlFl88r3y5Mg9SyY68AM/94Sl5sRi69aZbPtVQSE509/S6VP4rt3NXdHhZaLmix5j7jzuA5KkQTCdORdwUlsbKnjjhTLKyvJqvHWoYQ+upyJU8gCuwoonrykWQI2kCnqh5WrRGgxzgA+nBbSMtTMjUJhP1D/bQzeRpJ4WHs/MIi4e9XKjRAALqSKq7EuizgMQtOp9vYO6mMp+BwGpBl6sdO/9QoN+7IjAWxblMfhvdsLVjUJcd8pBA44VroYvF+c4G8zjbQtvLVGIYeGRiqWBe18Fugqg+8HjaPfAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbPNoR19DNCHSaGjLFZl6PTAdU3Z6oRHuE9sZrPFHCI=;
 b=PQDKQ7Yz5d5zGlp23nURTuFQD7rNsBIo11czvL3vh0V0Kp0TneA7wRq3i3rG8PvzGJNzFa3GhehfrucZRtFutc/tHHHy7qP5aj8i8QEXgai2SbC3wZX4x+FCtpkMiIaMEqiBhjGqMW0iUZj8S2g9dfgkgqXuEm2bLlPKTCKloaiAulw6AAW8ukTCz6+UM4ByPmcNjGxYP0eL8nac3dnxrneL2vDjnczLvKjF04w7MM7fZHUTiipt5xh8lRV/D0FAjXOJaNccQzvcQK30mmD19NVN4mS2R+w6lQ7bNemUt5V10j/kUhWI+w8tnheMqrvLTuTbqm4z9X0n5StbZAOiLw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEZPR06MB5667.apcprd06.prod.outlook.com (2603:1096:101:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 05:23:53 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 05:23:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Timur Maksimov <gessingate@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: RE: [PATCH v2 3/6] hw/i2c/aspeed: fix I2CD_CMD register reading
Thread-Topic: [PATCH v2 3/6] hw/i2c/aspeed: fix I2CD_CMD register reading
Thread-Index: AQHdZky15EHBNdyhCke7XWWC+qocj7cT/m6A
Date: Thu, 29 Oct 2026 05:23:53 +0000
Message-ID: <SEZPR06MB73629BD953409492B5A598C5FC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-3-07deed1dff60@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-3-07deed1dff60@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEZPR06MB5667:EE_
x-ms-office365-filtering-correlation-id: 51d6ca43-0ced-440f-88bd-08df357cd295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|4143699003|10067099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: kozkJ+95pKJhjtP2p86K9P+IbnS0XeGRsc/gOmaFNNWpbliM+rKORpjy6CLJZGkX4phqrPFxldcccol9BQe/w4XrIqBLg2pIBWmY/j8Gyhz+i8J803ZVVuAnuA01HG63O+XsfvyptZZJlD0nM0O49zY+1pMdJI0Qou7IGiWFMxxKiSgoZM97gZrfW5TtLqwHd1iNJ8S5U2CSWBoCearEe6hhqZc1XIsb/sIPc3VbQisxwCYyLreZgt1a4R0lezEvyFL1MQEW8VJvBxdetRr671B6OQBI88NgeqAQWbMHObYdeQ7blNCtRIrdSQ7695lKKroKe6eDQU2RZWCzxmT9teSTE0sfFFMzxOzYLVD15VLV6bhfagwve7hcA1+8eYARxj33cUWDiwn2tsAfNQSQLKsdzef4EjEkke2xEuu7d6ZFDk6K5YwmUnNEyaQF1vz7ut6psMDS3b6mXdpocp5fAm6f80acHDz2pSzBRMTCJCipgBq9q7fMtbYvrfrJOBjvlisCBxC86yaqzq+3WxOM7VOsEklxLkZJJzJ4tJX2Z3LLX+bRh0bmwudzoXauOiYdXLU0lMjlHlQ4DnML3gXiX5hA0LGtMoCMqJyFKsaFhxmTSGZEjs03VE6e+OZ3P6k/IgBG0jvbSnWIC2d1cNj8kLflVH/BWZ8MOq3hfqi2Fn+pJYI/hDpeeFFVU+YWSGINLF5vOsShnpmHBsOjnNahX1ejd6h1b8GT9o8UmniHrz8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bURVcEZkeGMzaVl3MWtVOEtvdlQxUEJlRkVZWWNzMzl6b3hDM0ZsaUJ5Snc0?=
 =?utf-8?B?YlNNeFZXUnNRcSttZCt5SjlKNUdFaWZLVi80STFoTHV5cEdLaHJ0cGdEMDRP?=
 =?utf-8?B?ZFZkR2NxdFBCemlPU1BRYnhUYnRSN3pPeGZvMEgxbFV2Vms4LzM4VTZ5TGpY?=
 =?utf-8?B?Q2dhZlRnbVdoMTNoNmZ0dWVrdzBad1dDQjBEMXRpcFAxZHZiSFQvRTk4bmtD?=
 =?utf-8?B?WFRWVldWQ01nc0NWa3FML3hZNnFLY1BBVUNpUGhJMUFmMGVxTm5xTVZFVmhC?=
 =?utf-8?B?RnlLUHorTTAveTRiQXUrYlZpRGQ0VEtFMHdkVDlZcTlxR0tyZzE0L0RYUElP?=
 =?utf-8?B?a1BjSVo5SnNYcUdJd2xDQkQyNXA0SDBhWFpwSUx5akxJTDg2cWM5ZTdwc0N1?=
 =?utf-8?B?M204czR1SXY5SkplOGE4YjVsMUNCd2R0VWRKbjZtLzRGVjNnVVFVallSelEv?=
 =?utf-8?B?dE4vOFlDalNORjQrV3NzeWFxVXhHbkVTQlJuZWh2ajdGbHEzWWxld0JiMnBS?=
 =?utf-8?B?SVVRK0J2R0J2YTB6V3BNOGo5QWw5OWREUmg4dlhOLzBPSVU0TmVYQWpKT0pp?=
 =?utf-8?B?eVQ2MVpXelR3SGFWZUx2Vlh1NmRla3JRVXBpMm5OYStOVGUxQ3hVZTZZTkxq?=
 =?utf-8?B?UXNNWCt1bnBQUyt2c3F1WkRFRFA1YlhyMHQzU29mYWI4VXZMMW1XWkRSVkNk?=
 =?utf-8?B?UnZoL0ViV0lVUVhhT3cya1BtS0NkT1haVWhJSGk4R1dwZnJwejZGVGRXZzhE?=
 =?utf-8?B?c0pPYWZheitLdFgwQTlRZVlLYXV1Q0xlYjBBU3UxNFExdGk2ZHRVeWZ5bzVM?=
 =?utf-8?B?T2lqbkJzSndsMS9TYmJYOUV1dDZSS21iSjRENlVRNmJqbVJNRUpGMndoQkYx?=
 =?utf-8?B?MitpUjFkaERYbGUyNW5hbGMzMEg5ODBvU1FGVEZKWkcwWUg0Tko2ZDlVSGhy?=
 =?utf-8?B?cTFHU2pMYzlxV1VXWklWN3B4TUZpdUdXcXJJMWJCY1dYeXYzZTRQWmdMQldE?=
 =?utf-8?B?Z05tQlBlU3E4NVd5cEJrRnRTSFlNcUoxc2JHT2ErcnJ6UEltVmhzWnhiMlpY?=
 =?utf-8?B?bFpZcHFFT0hGbmhIT0xsc3dOWVJmYmtIYWVhT2VkaS9VNzllUEpoOSt0R3ZI?=
 =?utf-8?B?dC83VUJWQVlRS1Eyb1YxSUtLeHh0eUdoVDBYZ3V1NXVXMGNjdWpVaTYzL3J4?=
 =?utf-8?B?bnZQOFpGZ2F2cUxxRlUwSjd5dTQyYnV5VGh3Z1VqcVVlM0hkOW9CaTA0RWhh?=
 =?utf-8?B?ZG5mYkZrZXFVYW04QktzbVl3bGRvSjFCdzNsSU1JZitKYURDVU92QXhUMU9L?=
 =?utf-8?B?MzE1QmpuaEZhSVFnaDlobDJlajNpTEZRMGc5eXNiVzdyK0l1WUFQT3E5RXcr?=
 =?utf-8?B?Zms3NXAvMHlOUlNLTlpCUW5rL1lBM2NTd092L2NFMzNNSU90L1I0Mkt5TkYx?=
 =?utf-8?B?bWh0UyszTmttYk1NeHNJMHd3QWNFWWtXRHFRMTRmQ1FpNTBPVUhTTEFreFZn?=
 =?utf-8?B?SWlIRzl3TExveGRtQ3hmc1o0RGIwTGZkSzE2RkhmMGtld2VhbkFBNEVyRW5R?=
 =?utf-8?B?alJ4bE9yS3EySlZQSlg2OHRRSjcxTWJ4c1V5QkVrOUxEZ05DaDRRUDhucEFE?=
 =?utf-8?B?UU4rVitJNE9uS1NNYnJYMzl4ZytCU3kwVUc0Z2k5Sm1rUDJsSkZDRXJDYm9x?=
 =?utf-8?B?SmNUUEdOU1pBMnc1cFcxWHFUK0oxWDFjS2d3L3BKNGRGUWlVbzU0a1lsMy9R?=
 =?utf-8?B?aGVSNmtzV05DVW5IcGU4SzNVbjJLamRvQldGYmc0TVFPVXVqWit1UFZzQmgr?=
 =?utf-8?B?Z2ZRUzJTSW9WRng0QXJpUEh4WVhtYmxMTlV2NkJ3TXlQNGswaVJ5QlZpcFJl?=
 =?utf-8?B?YVNpNXBpdHN4eUlnbDIwQXFpVlB2ZWhBQzdwZnd1MnhCRkJ6bURTZHJUVkZC?=
 =?utf-8?B?eXVsNTdRbHh4aHdVQTEzc2hjNVY2eG83bmFXUCtaMlA5aWhFbUY3WURJcHRm?=
 =?utf-8?B?UTJteW5IdUZHYnRDOFd4OTMra0tDdWxjK2s3MllVZ0hJT0l1R2JrWnZrU1p5?=
 =?utf-8?B?WVlQQjNYN3Boc1JzUjdqcm9BREFpbmZLcWQwRWpFUmw5OFJLdTl6S3RHRlRZ?=
 =?utf-8?B?Tmk5NEoxc3d2NTZXaWl1aW5wSE9jL1NyTldla1FIeERjWmRZRkRBem5zMVQv?=
 =?utf-8?B?RWtOZjJ2dnBzMitmMThGUHNtaElhRGV3eGNUM0JiUUg0U2Q0QjNwY1pERG4x?=
 =?utf-8?B?Y1RoV2pIbVBnbWxkTll0Ulh6Y2VoV3BZZXFCMHJXMlA1bWlSamNtdlBMbFFz?=
 =?utf-8?B?c3NNS1owUUo1WWlETUFuTEc1M0VKbHVqTStvOUJGeWk0ZjJsYllEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LmaK26EU0CO7MRvINSFm28CvbplBKAugzWM2Vqkfxv/Sub09+GkSF9RUoQu7HRhnSLI0IoirPc3grn4E2EdAQ+ZpWOoJU1J9wEKvIqTFmGJ58XWw6nJL7nPukwRgaCO5rUz2uFmWDCVAQqAWyCwHjPZnzyCnj2ZkQTObDb9fx9htc8vkCN+AtwC0pcmXqSLbCQFjemb9HTwLOhs5jIwOEZQE1t3+vXM4QgPLzRftb3GDanghNf6Cfxg5v/Imknyt80FfCpy3cbPd5AnNBu99GVjdxUtlVK9WOM++6Bk+jZ7c1c5Ct9RBYvXIc/+gH+BeovF+DF4tjBfqlJCYSZWYmw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d6ca43-0ced-440f-88bd-08df357cd295
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 05:23:53.4482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYfHKWFroPqZ+xMJjxNnie/XooSShELnVuOUqw4cwKt39hC48Jpvm5TIMsXLRbgYmac47d2uMgSqju1HwQz7dr6iNjAjF7gm4EYdRzG0zGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5667
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBTdWJqZWN0OiBbUEFUQ0ggdjIgMy82XSBody9pMmMvYXNwZWVkOiBmaXggSTJDRF9DTUQgcmVn
aXN0ZXIgcmVhZGluZw0KPiANCj4gVGhlIEkyQ0RfQ01EIHJlZ2lzdGVyIG5vdyByZXR1cm5zIGEg
dmFsaWQgdmFsdWUgaW4gb2xkIHJlZ2lzdGVyIG1vZGUuDQo+IA0KPiBGaXhlczogYzJjNWJlZWM0
MmJmICgiaHcvaTJjL2FzcGVlZF9pMmM6IEZpeCBvdXQtb2YtYm91bmRzIHJlYWQgaW4gSTJDIE1N
SU8NCj4gaGFuZGxlcnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBUaW11ciBNYWtzaW1vdiA8Z2Vzc2lu
Z2F0ZUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgaHcvaTJjL2FzcGVlZF9pMmMuYyB8IDEgKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTJj
L2FzcGVlZF9pMmMuYyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4gZmI2ZDE5YzM3Yi4u
ZmY2ZWY2ZDIzYSAxMDA2NDQNCj4gLS0tIGEvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiArKysgYi9o
dy9pMmMvYXNwZWVkX2kyYy5jDQo+IEBAIC0xMDgsNiArMTA4LDcgQEAgc3RhdGljIHVpbnQ2NF90
DQo+IGFzcGVlZF9pMmNfYnVzX29sZF9yZWFkKEFzcGVlZEkyQ0J1cyAqYnVzLCBod2FkZHIgb2Zm
c2V0LA0KPiAgICAgICAgICB2YWx1ZSA9IGJ1cy0+cmVnc1tvZmZzZXQgLyBzaXplb2YoKmJ1cy0+
cmVncyldOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIEFfSTJDRF9DTUQ6DQo+ICsg
ICAgICAgIHZhbHVlID0gYnVzLT5yZWdzW29mZnNldCAvIHNpemVvZigqYnVzLT5yZWdzKV07DQo+
ICAgICAgICAgIHZhbHVlID0gU0hBUkVEX0ZJRUxEX0RQMzIodmFsdWUsIEJVU19CVVNZX1NUUywN
Cj4gaTJjX2J1c19idXN5KGJ1cy0+YnVzKSk7DQo+ICAgICAgICAgIGJyZWFrOw0KPiAgICAgIGNh
c2UgQV9JMkNEX0RNQV9BRERSOg0KPiANCj4gLS0NCj4gMi41My4wDQoNCg0KUmV2aWV3ZWQtYnk6
IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KDQpUaGFua3MsDQpKYW1pbg0K
DQo=

