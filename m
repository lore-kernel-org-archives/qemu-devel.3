Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D1FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 02:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3mSe-0003rb-Hc; Tue, 30 Sep 2025 22:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v3mSa-0003qy-Jp; Tue, 30 Sep 2025 22:20:53 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v3mSM-000877-98; Tue, 30 Sep 2025 22:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxK3oJMeVtJFXHTJIf9z4uy3X04OjkIGJW80iVpak7QC+03L+GmfFSi3+uB77lyQHJZ4pEYSDGwICEDAT74RIBjoHfN+0xKZfUhxj8UQ+qH4hMv8cv9LEcw5tzhs0AVGw0GQzBKuiYuYwRllJT4sGQ1FvqgSuvJPiJx8SnBAUenvjnaLfw98BstmQadDqX40n1vj7PN/4ukI2eq80cSgGWsCFvDObelmLdaQUrHnpH8B0x5Op3c5w1AKrgB6zgWMG72aSLpz/Mnoxza7qwyqPEgJLT+5kIAH0nxiK7GgKF/9ruecEWEeJAyrZgug7uLh2VJ6o8+50NG4szlIs0umaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QAUZf3upvqq2uGPxdKF9lB/A8buvKKKYKlxwFXtSQs=;
 b=bKWSUs6vEg6bkCvF/twwCWHpaAcxdj5Hw9CZmtZKMsxG5FlIB2zCZkgT9fwZAGrR8paL6qCezlRAyADh526SB8sAyLU6B3ZerI3fuXXgo/g7SMx00t0Hx1fx2zH2ZFumJfi2c3028k3rL3805IyNWywJTQTtmUa7RzgTcEKjvp8qP7OtFKdj2PvAGe+AqG3DhXwUSbcDAU0oofBuNC7irIwV4MqoHvQDUojgNOTwhJqOfhXGaii3v9mRwLC14HCVmsg7Ewl2x1VgtkQFvh8AtgfveiovtJHDAv1MF8D3c8/FBjTKtKteELulpFtcyZ0LKv1b8x7ncdcu7Vlf+TyL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QAUZf3upvqq2uGPxdKF9lB/A8buvKKKYKlxwFXtSQs=;
 b=ppEEoHcTaZEPaeH66vri/uzuJ+JbWMUawm+be9onaxH+2ZqrItrtZTqFlLYE5xpkqsJz2sv3QNcOTQPnLn9nUE0UbjirsEbNMT+Sq6TNm7qAaW1V7PhgWpld5OQE/ZD95fM9wy0MGgR6qvR9vP3LAmOsQbylqe0Psi1inWlEUGhCNC7ZVqJFL74m0fLPM1qAgTyZRvWDAOPQ00Dph/qcV0X0UXnpwiMSmk0OdophXgGrgHMqxGI5XWCBMpnT5+rIDsfdFeY/g2Z9RM22JGdE3gF4IcIti4pQcBVlcTB8pMez9JwyMnR1b6LXwm6MyocTSCpUmgp+0FxTRzwXQiM31Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYQPR06MB8044.apcprd06.prod.outlook.com (2603:1096:405:2fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 02:20:20 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 02:20:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
Subject: RE: [SPAM] [PATCH v5 00/14] Support PCIe RC to AST2600 and AST2700
Thread-Topic: [SPAM] [PATCH v5 00/14] Support PCIe RC to AST2600 and AST2700
Thread-Index: AQHcKUgHgxOv8TAKAUSHKItPZwoT8rSaQ6IAgBJcrvA=
Date: Wed, 1 Oct 2025 02:20:18 +0000
Message-ID: <SI2PR06MB50411B9E75AA4EEEF40A31CFFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
 <12fb1c21-d53d-4418-8782-791ea97dd54d@redhat.com>
In-Reply-To: <12fb1c21-d53d-4418-8782-791ea97dd54d@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYQPR06MB8044:EE_
x-ms-office365-filtering-correlation-id: 69f6ec22-c555-4ddc-72c2-08de009110fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?VlF4M1I1TjZZd3FpNlFRcmtPWSthYlNhK01XbGFzdVlOSDlldmZHQU80SzdO?=
 =?utf-8?B?TGxWZlhVTDVuZjBiV3Rtb0dBNUZJaThxT01WbklZZ0lPRnU4Q1lXTmdyUDF5?=
 =?utf-8?B?WWtsSzloSlhEYnFoUWtaa1ZiZm1SSU9OVnpha204WnFVNHJmYmxGNG80bVZ0?=
 =?utf-8?B?R2FtS1ROcTk4L05BRzdJT01XT2creFpBeGc1VCt4Z2FSS1ZPemNweFpwTWRR?=
 =?utf-8?B?RjJhQzB2UFZrSzcrWmdCSU5Ia2M2UVpJZ21xaWt6UFNRaGs1S0ZJSzEwbTJy?=
 =?utf-8?B?T09EdzNGT0VaRGpxOU40SkkxVXZjN01EbUZxTzloald4Sy9ScWJiZjE0WDdo?=
 =?utf-8?B?TXVwUVV4Y1M1Rzg1K2Z0QTFGSlN0Qyt4NytiNlRKeUgyZGN5cEJOM3Blcldr?=
 =?utf-8?B?YVBWYUUya01keHJaZENtcndXTjJhbG9Nek9GRjBiTG1vdS9DR2x2YnRVYUx5?=
 =?utf-8?B?QU54M2xkeis1WjlEdUd5LzczalZmWEVCZDliQ0pNRXV1L1pRdTNoeEJlQS9X?=
 =?utf-8?B?N3U1eUdPS3NNUXZwMjluVUZhMGg1cFc0aWUxN3hMc3NzbEJROEY0RjFJUm9W?=
 =?utf-8?B?MTRLeHBOdDM0SlFRcUZHVUVEZzFldG00Z0FSeWMvdmlDeHhDMzg2RmNLRXBw?=
 =?utf-8?B?NUtSbFF4eEkweGxqUmZSTlRSYXJlQ2E3NDVxWTA1ejRmN3dKU1EwSHhHWjFS?=
 =?utf-8?B?QWFGZXY0L2ZGb1JiNmNTY0U0SFl1aWs5WEN5T0t3Mkxlakd4ek51M1RZTHZF?=
 =?utf-8?B?b2hkeUdZYmRWNHBrQStKUlpzQ2dNTlUreG5rTno0RU5QWDRVcmVlNW1kMmFD?=
 =?utf-8?B?eDM5b3VCQU94bWcrbkV5dFpVeFRTeXNZQlNJOFB1WjMvNGxpZ3huakNoQkxM?=
 =?utf-8?B?dG56eFBlSU1EKzhGdEZZaWMvbGFvNVVhVC80Wlc3MHdSSDhDUi81WXE5QjFX?=
 =?utf-8?B?c01nWUlXSEpsU3hkZDVETzBQc3lBNGRRZkord0VkdnN4OXBGU0psWHhmYXhK?=
 =?utf-8?B?dmxvWVRZbWdhSU1MOCt6T0dlbm8vTGRWWGpldHhCOW5tRThMdmxGaFVNNmI2?=
 =?utf-8?B?RElXYXJDeFlMYnlaekFCUG9OemNaNUtZRzEyM0dtYkJyNFh5VXdZN1oyMFUy?=
 =?utf-8?B?d0pQQ0JTTzVUVkdjejhMeVQyRkVSQWJUQTJwdXlJNGZkdEpyWGM1T0dXei96?=
 =?utf-8?B?c0VCbTlsV0ptbFJUZFVwbXVYY2ozeml1aVQ0dmxEaDVtVFpBTDRxY1RZMitF?=
 =?utf-8?B?TFJyRzBxUGtNZGNJWUg3ZzRydG1qaSsybmJpZ21lM044TVlvVWFCbjlOWkhM?=
 =?utf-8?B?cHJHcmltRUR2R0dpdk9YV0E3SmlBbnlocXBhdDhFc0tidFF0cW1uY3BsTHdD?=
 =?utf-8?B?bElnYWR3aGNSb1RmSW0xK0V0aWNTZjFleDRkRGQ1UzM0MEFQQ3gzZGNYNi9T?=
 =?utf-8?B?VHhtV09lR1R4SEE4UEZQOCthOE5wVHRWZ3AySzdxNlJHc014RUlVUE9kc3hu?=
 =?utf-8?B?cHd4cWhMRTVRUExMUGVHN1QrSDA5T2wyNHB4SFFrUEFBd0ZmNWQwUEN6a3JT?=
 =?utf-8?B?aTA3UHlZMTc0dmkzY3lZMU5UbFdJTWp4d2lJaGpkckZqOGVJcHUwZU5mWEcr?=
 =?utf-8?B?MVo1ZUdoQUVHV1I1SXU2cGNVR0NManNuTFZKcEZoL0RPZXJmdDdSamNvQ1pl?=
 =?utf-8?B?Zkh2RVkxMmxsZm81NUk4YlNabGRuVWRuTXR3OVk2cWVZY3BOTit0TXhCZDRy?=
 =?utf-8?B?WnJoT2ZvZ3FhcXQ1b3FrR0NMVkI1UmthMS8zM2kwQk1JN0htclRnY20yMDhO?=
 =?utf-8?B?bjg0SjBoV3BRSDZVS3BVNnc1SEZrSjVuWHZzMXpRdDA1WGIrQ1FDeURuZitT?=
 =?utf-8?B?SG9UK1BySDlJdjVnRGx5RGRRSjQ1RjMzZmQwck52em5tcEQ4TDZ3QVI4L1Fm?=
 =?utf-8?B?R1RLMlNEUkw4MU1ZKzFZbUZJNmV3d0NTY2F6MmIwKyswVy9mWHQrNzJYZEdj?=
 =?utf-8?B?MW9pTkY0Wk5Id3BTQ1ZMSVJDRU9yL0UvOXBadWJ1cy92bVZMdlZPenkrajNt?=
 =?utf-8?Q?D3Ihpx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjZBOWl4clplT05vZk5JNDJkZ3FnblliZVZiWTdhS09sWjNvTnFmekcxeWY1?=
 =?utf-8?B?LzFQSXpMSnN5MTM0WUwyZUtlaFk0R0V0ejNtUjB3OFZqcUpGT0p5ekdUYWsr?=
 =?utf-8?B?UE5xVk5vRGNPY29DRnNiU2NuTG5OZGtuUDkvbzJuemVWemE5UFA2Q3JyZU01?=
 =?utf-8?B?b1hnMVRrM3owaVhOcWJKZDZqd3R3a1BlcnNNZ2Z4ZlBaRVJCZSt0U29WR2RV?=
 =?utf-8?B?S2pzUENrNldrUXF5eTFkQzRETys3eU1XT3d0MitYamhJbUpHMHFaV3BwUmMy?=
 =?utf-8?B?Rjk3Z1kzTkdUdnkxaGwzdFZPbjA3WllQZFJ1a1BKUWcwdHppRTRXc2dObytm?=
 =?utf-8?B?bi9RMVhoYW50ZjBIK2VoNW55WDNENythRXIwUm54OXBKM0tQOVJpcjVrS25S?=
 =?utf-8?B?ZFBmcGZtMlZ6VnVNZis4VmZBQzVKaGF6ZHlvL252WWxoWFd0Zk1ablhGSnYw?=
 =?utf-8?B?aGVsU2MrMXpvTUVnMFBFR2s4V0YrM0F3V095ZWozclgvM3ROM2MwdVdzOEtX?=
 =?utf-8?B?RGRtNlhoZDNkWjExQnRnSmlzRThrSnpoMEljVDJSaUNrMVJ6VnF5U2k5dmRB?=
 =?utf-8?B?c3ZaMXh5UG5SWmpEa2lFbWNyNGMrVTVZVGhLa2lJNGdla1BQUWNBSFdBQ0V4?=
 =?utf-8?B?bTVMQkJaUXFHbi81Mm43MUc3UUpxenduSWczb3JNVGNmTnVZNmRocDY0WktF?=
 =?utf-8?B?MVBaN28vVjNqVUo5U3J0aFZESm1STXFCYVd2bmhLVmpwbkgzMjd5ZUJ2NDkz?=
 =?utf-8?B?Z2dzS0pLVWVjNWN5WW5EVWNRRzhwbUdVVXlZVFh3OG12cW4vVzdaMXU5ZmUv?=
 =?utf-8?B?OWFXWGFRbFRXT3gybjlhWjcvMTVTSlgyQjJqUldrOGJUMlVYNHBQTk1QY1pk?=
 =?utf-8?B?UjgyeEhEM09mZFkzOXRDMzFSVzdodHo0TEtrMDEzc1JWVk94Q3k1TFJ4enBB?=
 =?utf-8?B?ai94WkJlcnZ2MEJLcTZ2MzJPNHNKaGp2Q3V6V3FVMmU2QkFaNjVWUURUb0w5?=
 =?utf-8?B?NGlxTHlHbUVHN25RVytOTGVEbWpsaktLL0tVTVpqRDR3RE5QV0NjY0ltVTgz?=
 =?utf-8?B?a2MxcmgwVDF1dGFUSVY5TVdBZ3RKWlRoelJkK3VuYzc2N2o0VGdMenlkU1Zu?=
 =?utf-8?B?dDJPc0Y1bkZ5eCsxdWk1alh3ZEEvMWhHVlhmU0MvMW91d2llNWJWWVZEZDhO?=
 =?utf-8?B?Mk5mQ25EYmIyUFZab3ArQWgzRm01Y1NpbUx2NmxsRTRUc1phL1hGNHl3RXBV?=
 =?utf-8?B?Zlo1Y3lkZ3JJbHZCMWJYTVllQnNTT3AycXo2QVhDS2cvOVpEQndldHpyNDd1?=
 =?utf-8?B?OVduVGxkRUw0VVNmbVdmckZmaWRsSTlXSjcrc3hiVG9WZk9kOWYwLytraUow?=
 =?utf-8?B?RXVQa3gyUk9ycXM1RytxaXcrTGN1T1NMdEpkejlWTXpFa3l5ODdWb2pQT2dQ?=
 =?utf-8?B?RXlYSTJoaldEamxKSVh5R2w0d3dXZmNsNmo0NEY0andROVowNitzN3NZWExv?=
 =?utf-8?B?eTlsYTZnUFZOUXdNYnYydlE3RXp2Z01QeVBYK0lUNjRqcXQ3bzdxMnNLOXFK?=
 =?utf-8?B?dmwvZ2k0UTg5UkVqNDNVTThoYzVyZngvY1ZvYmlhbU9OaTJGd1JHSWtnMk9k?=
 =?utf-8?B?cmZIKzhBOHJSQTF1K2xSSkE0ckMvY2hOSUhCc0M3eVBSVDdMSFdCelJIenRo?=
 =?utf-8?B?Z2JMLy9GcUVJMVpGVTJBRmxkZHpoUE5aTGFMUWEwRmJDeGhmanZYL3ZXcllN?=
 =?utf-8?B?dktva1puNDNvZVJlYjJ6Y3k0QmpLTyt2WlMxVUM1azRnNmFpY0JIZytJc2VT?=
 =?utf-8?B?aVhuL0RZVUs4anFVQmc3dHlHOG5EOERpUVlUTEsyRG9tLzRjb3dNMkZoZ1hL?=
 =?utf-8?B?S1VuK1hCUjlYSENYcm5wV3dNLzNTM3lLekpqNVpuUlJSTmwweU0vTy8vbGUw?=
 =?utf-8?B?RWVKL2p6b1hwZjI4NUhzYStkV2F6L1FWQ2YwRUZMQ1VrVFhLZVFJcU4zNkZW?=
 =?utf-8?B?bXVzQnZkUXNwSlgzeWpkMHViT1ZKR1NobTYwSG91dzhEYkRLcG9lajB3Q1VQ?=
 =?utf-8?B?dTBmb2JRR0JuZjdWT29Eb0JVa2Z2bnRpeEpIeHJRWHlwNWkwTldkcXkxRVBO?=
 =?utf-8?Q?7gDA8mdHkl8SeDelf9r8b88BG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f6ec22-c555-4ddc-72c2-08de009110fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 02:20:18.8083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBlOCWKi7k3CKjypqQghYL7domlpmWp+b3JxmsfGYCCev58sqS5hP+OKKGnVL+Mu1CL/yg7RwQY0Ia1dryLMHS9mCscBnH7v0l7G5lv4k3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8044
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHY1IDAwLzE0XSBTdXBw
b3J0IFBDSWUgUkMgdG8gQVNUMjYwMCBhbmQNCj4gQVNUMjcwMA0KPiANCj4gT24gOS8xOS8yNSAx
MToyOSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IHYxOg0KPiA+ICAgMS4gQWRkIFBDSWUgUEhZLCBD
RkcsIGFuZCBNTUlPIHdpbmRvdyBzdXBwb3J0IGZvciBBU1QyNjAwLg0KPiA+ICAgICAgTm90ZTog
T25seSBzdXBwb3J0cyBSQ19ILg0KPiA+ICAgMi4gQWRkIFBDSWUgUEhZLCBDRkcsIGFuZCBNTUlP
IHdpbmRvdyBzdXBwb3J0IGZvciBBU1QyNzAwLg0KPiA+ICAgICAgTm90ZTogU3VwcG9ydHMgMyBS
Q3MuDQo+ID4NCj4gPiB2MjoNCj4gPiAgICAxLiBJbnRyb2R1Y2UgYSBuZXcgcm9vdCBwb3J0IGRl
dmljZS4NCj4gPiAgICAyLiBGb3IgQVNUMjYwMCBSQ19ILCBhZGQgdGhlIHJvb3QgZGV2aWNlIGF0
IDgwOjAwLjAgYW5kIGEgcm9vdCBwb3J0IGF0DQo+IDgwLjA4LjANCj4gPiAgICAgICB0byBtYXRj
aCB0aGUgcmVhbCBoYXJkd2FyZSB0b3BvbG9neSwgYWxsb3dpbmcgdXNlcnMgdG8gYXR0YWNoIFBD
SWUNCj4gZGV2aWNlcw0KPiA+ICAgICAgIGF0IHRoZSByb290IHBvcnQuDQo+ID4gICAgMy4gRm9y
IEFTVDI3MDAsIGFkZCBhIHJvb3QgcG9ydCBhdCAwMC4wMC4wIGZvciBlYWNoIFBDSWUgcm9vdCBj
b21wbGV4IHRvDQo+IG1hdGNoDQo+ID4gICAgICAgdGhlIHJlYWwgaGFyZHdhcmUgdG9wb2xvZ3ks
IGFsbG93aW5nIHVzZXJzIHRvIGF0dGFjaCBQQ0llIGRldmljZXMgYXQNCj4gdGhlDQo+ID4gICAg
ICAgcm9vdCBwb3J0Lg0KPiA+DQo+ID4gdjM6DQo+ID4gICAgMS4gRml4IHJldmlldyBpc3N1ZXMu
DQo+ID4gICAgMi4gdXBkYXRlIGZ1bmN0aW9uYWwgdGVzdCBmb3IgdGhlIGUxMDAwZSBuZXR3b3Jr
IGNhcmQuDQo+ID4gICAgMy4gdXBkYXRlIGxpY2Vuc2UgaGVhZGVyDQo+ID4gICAgNC4gQWRkaW5n
ICJCYXNlZCBvbiBwcmV2aW91cyB3b3JrIGZyb20gQ2VkcmljIExlIEdvYXRlciwgd2l0aCBKYW1p
bidzDQo+IHN1bW1hcnkNCj4gPiAgICAgICBpbXBsZW1lbnRhdGlvbi4NCj4gPg0KPiA+IHY0Og0K
PiA+ICAgIDEuIEluaXRpYWxpemUgcG9pbnRlcnMgdG8gTlVMTCB3aGVuIGRlY2xhcmluZyB0aGVt
Lg0KPiA+ICAgIDIuIFVzZSBkaXN0aW5jdCB2YXJpYWJsZSBuYW1lcyB0byByZXNvbHZlIG1lbW9y
eSBsZWFrIGlzc3Vlcy4NCj4gPiAgICAzLiBVcGRhdGUgZnVuY3Rpb25hbCB0ZXN0cyB0byB2ZXJp
ZnkgYXNzaWduZWQgSVAgYWRkcmVzc2VzIGZyb20NCj4gPiAgICAgICBJbnRlbCBOSUMgRXRoZXJu
ZXQgaW50ZXJmYWNlcy4NCj4gPiAgICA0LiBJbnRyb2R1Y2UgcGNpZV9tbWlvX2FsaWFzIGluIEFz
cGVlZFNvQ1N0YXRlIGluc3RlYWQgb2YgZHluYW1pY2FsbHkNCj4gPiAgICAgICBhbGxvY2F0aW5n
IG1lbW9yeS4NCj4gPg0KPiA+IHY1Og0KPiA+ICAgIDEuIGZpeCBtZW1vcnkgbGVhayBpc3N1ZS4g
UmVwbGFjZSBnX2F1dG9mcmVlIHdpdGggYXJyYXkuDQo+ID4NCj4gQXBwbGllZCB0byBhc3BlZWQt
bmV4dC4NCj4gDQoNCkkgc2F3IHRoYXQgdGhpcyBwYXRjaCBzZXJpZXMgaGFzIGJlZW4gbWVyZ2Vk
IGludG8gbWFzdGVyLCBidXQgaXQgbG9va3MgbGlrZSB0aGlzIHBhcnRpY3VsYXIgcGF0Y2ggd2Fz
IG1pc3NlZDoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVs
L3BhdGNoLzIwMjUwOTE5MDkzMDE3LjMzODMwOS0xNS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20v
IA0KW3Y1LDE0LzE0XSB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvYXNwZWVkX2FzdDI3MDA6IEFk
ZCBQQ0llIGFuZCBuZXR3b3JrIHRlc3RzDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCBjaGVjayBv
biB0aGlzPw0KVGhhbmtzLA0KSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

