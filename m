Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589B0C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfM14-0002N3-E3; Wed, 28 Feb 2024 10:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfM12-0002Mb-MC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:38:41 -0500
Received: from mail-db3eur04on2062.outbound.protection.outlook.com
 ([40.107.6.62] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfM0z-0003Tz-AI
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:38:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmAy3p2NARkwmk6G2BjwMWUnZDVZS/sl2P6aXpzL+Sb+d99Btr0bb32J2jI96XvqPkD/DxGJKdxa5IJHZYJrUe/Glk69BBWf8B9MPMdJKriVxkmSCzvKFK/OKIEjADvDRzeAQS5f3oLdlhY7jcrvU6uTpM8x4yyVZmvRRWzBj9ppJpbhqEfGdr2EdHQsliDtlEr4ysnJqeu/uYphOGPpeZCKvjqy8hBYHZ/7jMyTmTiaXovlLHwZq/LH7VN7Dnk7c5RLxKkg8HBrUow5i6nsOqjberLenLYwi2ccW8LraPynqcYLvJ22bAZnK7CjIeLNNs7EZNgglQJ7RHITtxL8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4ANqQ4gnYX1/72i535Q2jmSQsf4MJxB1gIZlwr8ivc=;
 b=c8Fk2Cfq1kd0n88rRX4Wy5+fVwguf8Rh5k77lVHs2pspmUE1pa6JhxKP3HtgHmhY+FBgS9gGxRuPmi4rpwlqKdR/zJvdqFxXW7qPCILtl9jg70xLYi1SPxtH62lqEijm+8NmUBdqU9W7HuKT/3PesR4NQq0E6Y3LwQlnn3JCLjqrGa8Z2Xb5Y4FybSiSf79vQYcEugQ6AUq/M0dRBJw0eDaOGvtHAeyD6PEhNBRAOnuwp5grdFFd/0QerTFgoPKoMaMf5gTTIRPkYC7D+LPeHigr3HklWM0BvJrzeDOEE3i3L1d8FoJ1ctzNE/zwsCfWLiiHpWBbD1I+RNrC4sZLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4ANqQ4gnYX1/72i535Q2jmSQsf4MJxB1gIZlwr8ivc=;
 b=gU5j1a8XVTXa2iSkD8DJAu+iIUSCRmhV3Mr4Gh/D1WI3ZWTm+xcI6i5YHOuz6sx/96ToHGpj7jQ3pOlJ2q2FuXGnAYsX/H5YmzK+qye2UpnRG0lDZECf3oLBi0V0n+k5MIjsqJDQH+GcHLMYYoGKTTOy1LkXF9funtUuGdqYprHkkbydWQvr+LJ1Jmy5/WunB8YOVH0ilxhZg81QZMeBBH35njOU1dNvure5PNehukU2rzAjen78dtaFe5Qvt5qPEcVQU/I+GHax/9+P5vhKO/+8+gGYmc9ntsmZQg+RX5EcF0pbYezXjDN1+2wecpz/XPN9FvSMGf94YJ1HyuFGsw==
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com (2603:10a6:20b:4e3::19)
 by DBAPR07MB6775.eurprd07.prod.outlook.com (2603:10a6:10:17f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 15:33:29 +0000
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c]) by AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 15:33:29 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] MAINTAINERS: Update Sriram Yagnaraman mail address
Thread-Topic: [PATCH] MAINTAINERS: Update Sriram Yagnaraman mail address
Thread-Index: AQHaah0KjGnse1BTZEKdaG10QRle+7Ef4EyAgAABVSA=
Date: Wed, 28 Feb 2024 15:33:29 +0000
Message-ID: <AS4PR07MB841212D830F253167DEBFFD890582@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
 <3ac7d304-6bf4-49fa-b19e-74925409e736@linaro.org>
In-Reply-To: <3ac7d304-6bf4-49fa-b19e-74925409e736@linaro.org>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8412:EE_|DBAPR07MB6775:EE_
x-ms-office365-filtering-correlation-id: a02617b5-8cde-4dfe-76b0-08dc38729d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EynEvXLlePTmxyqxFeLxCKFXygLg3IPQiWNl36nPHynyuqC9D2zmo2S33Yip0z/A+VGRI84ln14SZvvdBGNa+w2gfwAtnQqiYRrQVuv8rApftKCEKI38BymwffNVbzuxpjPmS+N9sUCUj1AEYgm5wodd/L760uWL3qx5QScyI3gprQzosC4hpMBdC+WnIVTF//ryu1qFnD2gqiyt9K+t0MtjoHHNIZR8DB5b05xzoRvGMIBOHWGrLh6roE4r37/Irvq9i0GztfwH/DnXAMa3/o4DBC+Pep93pYwnDwgdgufEpD8UDgxGM3r7H/N8qW3KNqW1/HrahUwO/k5kyCZIkAizZtHVSa9pK4f+Oktcl7nc4X28jPR5W4X7kIPYqT16F1+A8X/i6srMILic4Nmz8tfqT+H/HZfu+3f0TAl+m4onk//IeiGU2DZdvMcR7czH61/eF4afXCx7hC5V1TFkXpNItnxLnC7x+dHf0QNu5s3n3KBuIBlDxKKR6eG3N7YleRQ/ltBysxfmIZbWMKy5jDzpLnRmOKNUehKKw1uN/75p9keuwBQLdshyrb9njtb1XGeA1VrTM3FIFIj3vJVzH3DiQ3OSqkPZ6n7puDyhDeJRyYmyxp5OkPGSOMwxMPZKLPG1BE8VzLFxg1pYAh/42uKB1jpx/Xmr7MCyvrzTQKShLj431oMJM8J5xO6PueDFb4WfZR+yN3sNZl9oHw2DG8WShTXs1vYN1DfrMW2naGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR07MB8412.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVU5Snp6SWU1Y3ZKUit6UnZwTTJUOE5wT2ViblFaSVAxWVN6aWtZOW03b1E3?=
 =?utf-8?B?a0ZiZHUzK3Z6QUlpKytVVENNQUlwM2VNOTUwNjVlMVJvbUdxTHpDR2xOWkFs?=
 =?utf-8?B?REovaFdZZzdtakM0MDdIdnF3TnU4SEg0bTBqTG55KzVsYndFWld0M3h2REh6?=
 =?utf-8?B?VVFYRG9HNWpKQ1VFNERwRytaUEFYT2h2cUxlWnR5MERmc1pkdnZTdHBLR2tJ?=
 =?utf-8?B?a1FQSFA1d1BwUDI1SzYveVBFYkFQRGFSNHdIaThJemh5L1JYVWxXOEhRMXk1?=
 =?utf-8?B?VlB0V0lKNEhESmdUcjQ3NlpqcVEvMDlFYkRFY1dOZDZaQ3prRjlQdHVMbm5h?=
 =?utf-8?B?djA5cjRtWEhTM2paMWxVV20xWjFFRm55a3h6VGRLMkNjQkxhZVlWWS9jazJ5?=
 =?utf-8?B?cVJQYWlpQjZFc2IxVnNQSEtxTTJ4c3J3c3NvVmNITmZHcEdUOE4vQ2FESXhL?=
 =?utf-8?B?UEFOaVBldyt5cmNPV050Nkc3czdEWFNtZUMvU28vQSs4TjE5OU9wL0tPQk45?=
 =?utf-8?B?U1dscWR3RDFGVHpBUEo5M0pJZWNJRDA3UHVOZm9oTGZMaGF1TzVPV2pwZUw1?=
 =?utf-8?B?Q1JHVWxSWSs2d3dHS2s1am5neFMxNUpadEFXYlZUeWFuYmhPcXdtd1crMTE0?=
 =?utf-8?B?alJYUENkbThsdXhnajF3WExhVDRKYS9qTFBJQlZqVFR0Z0tSdlBmNi94MDUy?=
 =?utf-8?B?dHc4VVNlRlVGL2NySmpCMU1TMGtRN0ZsYWNTOTROTmkwSGprNEJrcUUvUjV0?=
 =?utf-8?B?ajUwSzFhUnFDZFpzc1lINi9hQ1BDNWVQU1l0d3YzQ2FQU0VvMHYwNzVUaGsw?=
 =?utf-8?B?YzI0aW9RUWIzZ2EwdDFmVlhyaXVLRFdSTjhRcjZaeXJPTWFIV3IvendZdDhQ?=
 =?utf-8?B?Z3BpNnczbHBtcEJ1V2crek5rTGtVcVZQTmk3S2JwcUwvMVRhQnZ5cDBjcDVx?=
 =?utf-8?B?N2svNGVYdGZibEIrTlFIOEtVVDhVUHUwcXNrSDVhZHk0NUZ0cVRldlFLTXp1?=
 =?utf-8?B?R0J4MlVrN3d1M0t1RE5OVG9kWkhpMVJFdkFEZ1p3R05uNFlxYURTWkhNeFhQ?=
 =?utf-8?B?NU8vbVhqUEdVeTJhT1BJSUlLT29WVFdEN04xOFNlcENtWWswbC9OUXN3NC9a?=
 =?utf-8?B?UjM5aEJ6bGlmbXdLZ282Qzg1aW9RN0UydElrdURoRld2RStuaE9OaDJMZCtI?=
 =?utf-8?B?cWZaNm1yWndWWFIvYlNxRzlSZXhqYWpWWlJkVjk5cUd5K0xOcHRsbDFZOUZD?=
 =?utf-8?B?NnBEV1dGd2VtemIwT256M3MrU2pwbk85SkxicytBNTdTUVRwRWFsbWZBVzJR?=
 =?utf-8?B?UEJmQnh2T01IWWlGME1iTWlpajZDMVVtcEhTTWRYMzZqcGNOOEtSa1c4QjJZ?=
 =?utf-8?B?ME5EbDJQZDlaeFhDM3dpZ0k5NDdEbXcyTGxTcnhiRWVYZHZOMVlyMnpFSzJs?=
 =?utf-8?B?eEdvbEJaejVuMk1ibkxPMkhpZlRQbHV6RkQxcTZjUUpXSkRkZmc4UHJsT1dT?=
 =?utf-8?B?Tm1nekl0Z3JqWDByT1RpL0JNM1BZNjZmUVJqSlpMUzhvSW9lTDMvWXVlaXJh?=
 =?utf-8?B?WklMYXFDQXJBTnV5WnZrQXMreUg4b1VPY3ZJRkFKRXloSDZaT1VabVpiMGpF?=
 =?utf-8?B?a3FPVFd1dFFKdjFPUlVDNXJBQVF1UkJBRFArZElxTnFWclFKY01HSG9rM2hk?=
 =?utf-8?B?SE1pS0M0aFQ1anQxOUk3dVFCVElOcW9jR2NILzdBdFV4d1VjbUVNNWhlUzJx?=
 =?utf-8?B?M0RoaG5GQ09BQVBHNGpMWXhVSTI3NGJDM3hXbDViOGhZb0t6UStJMjVSUGdY?=
 =?utf-8?B?TnF0R0c5S2J3LzU1M3VtMjAvbUMzc2ZtNTlyUDlQMDBzc1JJeWk2QVN2TkIz?=
 =?utf-8?B?dWdmRHljK0pieGo5WkRlQTNMZGVZZW9ocmx0RW8wTHl5eFMxOFJBcGpaTlBi?=
 =?utf-8?B?Y2VDL29ic0ZZMzdLcWlPRDZ1cmpSVHF3NFZoQ3BjTjMrZTI0U20vQjRxSmtT?=
 =?utf-8?B?d2xXMWxkZy9UVjBraDBxVnN3d1dZWmR5OStsYXVYd2F4d1V6bGRCTzR1Zllz?=
 =?utf-8?B?VzAveDdSNnFUQWFvVERFcUU2SmRHd200MW9OTlRTUm9WU1YzSzk4TlJZK1dr?=
 =?utf-8?B?K0d2TmpzTWlxVmtLb2tIZ1Z3RmFheUtYNUE3bDVBZXBINjJwQWdtZ3RwM3Jx?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8412.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02617b5-8cde-4dfe-76b0-08dc38729d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 15:33:29.5760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfAX3tP+QoI8Tyo2AtPMkezBJ4lJAU6fgXjdACNKL8F6xoL4IDt9fUV9R1ex4Js5xGRNeqV/2j/TfP62NjRUAYvQuM1lbQxPI/edVniKOnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6775
Received-SPF: pass client-ip=40.107.6.62;
 envelope-from=sriram.yagnaraman@ericsson.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

SGkgUGhpbGlwcGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIDI4IEZlYnJ1YXJ5IDIwMjQgMTY6MjUNCj4gVG86IFNyaXJhbSBZYWduYXJhbWFuIDxzcmly
YW0ueWFnbmFyYW1hbkBlcmljc3Nvbi5jb20+OyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIE1BSU5UQUlORVJTOiBVcGRhdGUgU3JpcmFtIFlhZ25hcmFt
YW4gbWFpbCBhZGRyZXNzDQo+IA0KPiBIaSBTcmlyYW0sDQo+IA0KPiBPbiAyOC8yLzI0IDA5OjA2
LCBTcmlyYW0gWWFnbmFyYW1hbiB3cm90ZToNCj4gPiBEdWUgdG8gY29tcGFueSBwb2xpY2llcywg
SSBoYXZlIGNoYW5nZWQgbXkgbWFpbCBhZGRyZXNzLiBVcGRhdGluZw0KPiA+IE1BSU5UQUlORVJT
IGFuZCAubWFpbG1hcCB0byBzaG93IG15IGxhdGVzdCBtYWlsIGFkZHJlc3MuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXJpY3Nz
b24uY29tPg0KPiA+IC0tLQ0KPiA+ICAgLm1haWxtYXAgICAgfCAxICsNCj4gPiAgIE1BSU5UQUlO
RVJTIHwgMiArLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTIGluZGV4IDY1ZGZkYzk2NzcuLjBhMzI5NGY2OTgNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9N
QUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTI0NzQsNyArMjQ3NCw3
IEBAIEY6IHRlc3RzL3F0ZXN0L2xpYnFvcy9lMTAwMGUuKg0KPiA+DQo+ID4gICBpZ2INCj4gPiAg
IE06IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4NCj4gPiAtUjogU3Jp
cmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPiANCj4gQ291bGQg
eW91IGNvbmZpcm0gdGhpcyBmcm9tIHlvdXIgPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPiBh
ZGRyZXNzPw0KDQpVbmZvcnR1bmF0ZWx5LCBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIHRoYXQgbWFp
bCBhZGRyZXNzIGFueW1vcmUuDQpJdCB3YXMgYSBjaGlja2VuIGFuZCBlZ2cgc2l0dWF0aW9uIGZv
ciBtZSwgSSB3YXMgbm90IGFsbG93ZWQgdG8gYmUgYSByZXZpZXdlciB3aXRoIEBlcmljc3Nvbi5j
b20gd2hlbiBJIHN0aWxsIGhhZCBAZXN0LnRlY2guIDovDQoNCklzIHRoZXJlIGFueSBvdGhlciB3
YXkgdG8gcHJvdmUgSSBhbSB0aGUgc2FtZSBwZXJzb24/DQoNCj4gDQo+ID4gK1I6IFNyaXJhbSBZ
YWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlcmljc3Nvbi5jb20+DQo+ID4gICBTOiBNYWlu
dGFpbmVkDQo+ID4gICBGOiBkb2NzL3N5c3RlbS9kZXZpY2VzL2lnYi5yc3QNCj4gPiAgIEY6IGh3
L25ldC9pZ2IqDQo=

