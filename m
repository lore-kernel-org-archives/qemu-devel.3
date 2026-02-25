Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D69F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OE-0003SN-EW; Tue, 24 Feb 2026 21:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O8-0003Qr-S9; Tue, 24 Feb 2026 21:12:33 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O7-0000Bm-4M; Tue, 24 Feb 2026 21:12:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkTmk2Qa4fkp3b9kOfMgF4hE6djNcDqb/GzzjFiBhA7O0uYu6PxR7Jjo9qOR8iC1LnjFP3EBXBmuffe+vH0YSnUhwX8HWnQYTPTRuHaQmylku4aomBxJ1d4xG+x4A2ROJVVXe3g3vn0yJpfx1M9VNNOLbjceMhiC43htg5akrvcxm/eaJpYa2f1mYC478ZPILdYuy6mqZrUaRc9DlKZSaQUGOCpV/QNRi8IoXFLuzPJ0Yaq163F59tzn8iuTTQ9g22xT8FvXONFfLQFmbG5CozoZslms35DdchcgIFML0jnO0+/MfOESJUJgz6jAafJhVImTFvbjNMv/E59cLqMVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8T4CbWyBuPs18YbU2Li2vnvCWPChLJuktsjf2Wjv/s=;
 b=MWVJJ+q7nUsWPRsqlCTzOqRzdOzSssLnQrCXXAw/0KV4LYE56t/FIyofwKIJx+ZD/e14IVlR6lEVq/2oEdNXQVGW3V5Xe+6+97Kz/vud5VXALIZiskNIUymKZp9Q8PMy21qWdTl3yxpC96xUb476hfyPFWO9qo147majNLtDD8+S/57W/kmkpiH+H7I+tH1U2oKSxX6nuINeVdWXQ9jxvdEeZfTYUrq/yePIsNA6MED1kNpyFKdEY8zAifR2oztGfHBsg0BdS7lzNSeM+S48q+ol2UMevWwRR704MCsOrPI6xGSTK9gPGvj0WaE0NxfEKkqGf71WUgL693qKrG/CnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8T4CbWyBuPs18YbU2Li2vnvCWPChLJuktsjf2Wjv/s=;
 b=Hiv/+ldjdL2P6r8RpKS2YqfvVSF0MJGmArHiPgGCfQxsLZQddSKh62px0twIu2fSiq/rSNQGDEP0Qz6Or9Dn06OEEM0tTzBzE10EW8VSQjza2Q8fgF2HytJUYpIa38sLsD4+h4BJxvALTIRTJlwFG3ni9hwvC/7fhoFJiOr5hkYhbJrJEm2Ez7luAFDJA6iU1bgMNg5a14MWbEN7Gs/uPqXqoZuowZ0hUf561EoobGJ/wcQViI2zZBPvUxt9UV0IWZ9dKtXaqUIV2WTsU4Vd9bw5JKscwZW7c1Y8fl9CUFo4NHlGcor/YdvsG8MCdHWzRjnIV+Rl/jIu125EefbGaQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:21 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH v7 12/22] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Topic: [PATCH v7 12/22] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Index: AQHcpfwspAArPkfbbkKlj/1JOFqYAg==
Date: Wed, 25 Feb 2026 02:12:21 +0000
Message-ID: <20260225021158.1586584-13-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: 2b7a86b9-b2a4-4cb8-0083-08de74134ef4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8pPF5mgKjE48LmM7VYg5tZBCXOVBPgkb0AxhMu/epWHdbEuCHgbCs49fp8?=
 =?iso-8859-1?Q?9uqKQmzrFDt9Xr2HCVncoD4qriOd20hc1w4IHPZY4v2RJWJObbRPxBUPrl?=
 =?iso-8859-1?Q?+LG2kUtagjsHb4E3TEUVs/k/4qudKt61alkuBk4938cGEZVMFJ+RKesRKd?=
 =?iso-8859-1?Q?ou3ri9jcqbjgr9yl8B0SxreXqBBLkfCuz368aY8yFmb2kmt6nZle1OENbZ?=
 =?iso-8859-1?Q?tiC93h6KJ+DdF3rQm1qI8UUzN0NAM8dB016J4ta9wU2pIljj1G3VmXc7j7?=
 =?iso-8859-1?Q?BJ87T+50HyKfoR6rKcFD3Cdk1w0DmSC8cgrl9pDjJ3Ab4ih4Ru0uheYKGr?=
 =?iso-8859-1?Q?6ebiRNM4iB3nhn//AG/U0T0fkw9dM5n/zzmwzAsKFjRQ07O4D9HNvkvOEK?=
 =?iso-8859-1?Q?6eCWOXmPVTXxL2c6/2syEHZJrw5zVWZnipR9lUu/4uW12aFny+IMq6lh3R?=
 =?iso-8859-1?Q?uiDLOgnV+V8XlugGPg7lOiwKfdYIUAmXrFWdlvUWYCnBu/quzJzhpTccxX?=
 =?iso-8859-1?Q?7pRwcGaIkjhGHTdTBri0qVUrBXKrT2AQw5tudtKrkE+zoTpvYqHwEU4tes?=
 =?iso-8859-1?Q?h7g94o3Wy7lkS27v2dI0Dvu2uFTWE7Cf5y3fe5VS32K88X9FFj1tBuYCBH?=
 =?iso-8859-1?Q?kGJ/6H99oChwEsZGpp+ySjBBhl3SMXh0hQPjNBai+FlmRB32Q3Vv+UIH3B?=
 =?iso-8859-1?Q?uS//JSmqym7dkKFmeKks+mAyPIStYDsWtRDRFYs/sConQa9EB4RifI4bLo?=
 =?iso-8859-1?Q?DG4iOYv7ABLsECskKONS9swUsucxS7djwMEqaO2U9W+Gu9e3kLS8gNzF9E?=
 =?iso-8859-1?Q?Ws7uMAVsnYH2zZCBZsQyY2mqOfxGdO2dvIioTePaL7C7Vg1JOCe+4Abuze?=
 =?iso-8859-1?Q?/RQGWTgvK/adXRTM1T37WgRwCdmA/BvEtjA2FYA31rcoPwBGJUV3k545Iq?=
 =?iso-8859-1?Q?ujR4gjnNgHePDNzO1VbYU3nwYwFt6gf0tWo5dx0ENwVSnRdfydixlvkWCR?=
 =?iso-8859-1?Q?y+ffSSQLCnzCqHxs/WP/6pEf3+jtWnKXPEFFtRj0cCHWrblSJutNqSBxBF?=
 =?iso-8859-1?Q?x2U58mwkgOlo0z6cpxk4/fVNHB6Mjytt4aIvvSnzx//I8lWG/oFnXx5p7h?=
 =?iso-8859-1?Q?I1ZWoUf2YluAyET2eOs3s6lJFDi/VKOufhSHrjVUOV1Sq+djPeycPfqPt/?=
 =?iso-8859-1?Q?ChI+usaI7bIjzhSuf4bugO6u8pcvQ+eWfsVN55BAD91SgaGe6TPFfhbAva?=
 =?iso-8859-1?Q?ZEEvW7oEgSlm2GTHtpGpQpM9jUSFWwt6rOmmpsLQg2WQssPafbHPdIys4Y?=
 =?iso-8859-1?Q?17Lg12YVjUjmFejvm/Eg4xxC3NmsmQUENdssGvyuR1VD4dB5X+x6aULyEy?=
 =?iso-8859-1?Q?wguJrQ/d2cvWHe04elpFkBbOi7HR5F5X2KDfMP2JBlQx5x079paTiL1bPZ?=
 =?iso-8859-1?Q?Fn7z9Lks/BAiHqjjnwiyQIQBB6qc0eg9k8KNgb/nA9ikAkG6yOl0bHX1CK?=
 =?iso-8859-1?Q?fMfbPi0Dfael3EPLPkBs0u9p0wbnZHxfWHTI8ntKsvvCRHg8O3FcAquH2B?=
 =?iso-8859-1?Q?P0YwqhYXQYSaKPgADHRLpqy4B0DvRkazpO/rDVJ8nSayIKTy455tv+7TUI?=
 =?iso-8859-1?Q?rUyRTN1KSYfKEXFmwEC54/2v0iUSPDn9GwFgc7LRSOGAFPyldwB9oJbrHV?=
 =?iso-8859-1?Q?w53kJgV5cLDyRob4q+aHy+KvNMA2uVhuQ+VnsAT7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kXuqMwtFRPCtTqJr1pnm6NVaQrjfWtwKwoatzYUPB5tfcpyl6QuzA3oiWF?=
 =?iso-8859-1?Q?PUTc+dpTqZTFk91yPJEApbQS1xMJywN1bGpO0GPo35jbvWHewY+o+luq64?=
 =?iso-8859-1?Q?FaP73IaNe247xZkcOYGg/9mDqFr4/e/zW5VqZkVUuVzK2mmDuXtRgJ/Lhe?=
 =?iso-8859-1?Q?J3WDJCnWnFTAw5agXnQQvTD1v+oynCGOvJECF0b4RUz3KlfEgxocoCIHLQ?=
 =?iso-8859-1?Q?KQICC64OLt7na1NAjLPpWhAyp8K03dHbq8NJo9GuRD4Fd1Ax4z8tYXWMLO?=
 =?iso-8859-1?Q?yHysi75hRcYZGYI/GolbzS/SAEwJC6tOIqh5p29ZXd0nv9VJZmMCsjsi6R?=
 =?iso-8859-1?Q?deCDI+qgLsqAHyKVPTZ1i6EiNvqtfFyquDxf/M1z6CqQF1Svy0nd8kqREb?=
 =?iso-8859-1?Q?aAP+Pnz8/M6PxwHTb84VmmLzn6xXP1Gw7LWCvjZIq5HY0FUqs4c9g5a4A1?=
 =?iso-8859-1?Q?IZE/Sh3ndlMp0XrrH4WQdbQ8XAETy3sULY+oj1Ov2ogSyfKpGLRmCKhzHT?=
 =?iso-8859-1?Q?Yo/7ZMCyRINb5jILcrNipEQC1qRFDNfU9W9cc/YaO0lS+ehRskxZx7SuqK?=
 =?iso-8859-1?Q?8RIguVj6KxR+9Dj+jnI7Bb6fp6s2nLdQtp13ZkX4ut2j4bIihjqRjRJb1p?=
 =?iso-8859-1?Q?iOzK5EA+Y+PlyOmipZBVJt8PaQOTKQnjkICIJaX66spDaHMMHg0gsgHCDb?=
 =?iso-8859-1?Q?AAHmoVp3Q80nPkkgo34IGjJJ2prpl8bS4bt3v09CcUaQoO7f2QogGRm410?=
 =?iso-8859-1?Q?yhjxfndRaQUJTpOdp3AaaNcKf6Z/UzHVoGhiGT8p0VBduO6V01TMmy2PDn?=
 =?iso-8859-1?Q?9c4XbgLIkPHt0Egw43FlWpprUh9YpN8eFIyZCLe3wm75XO3ttgeikTQLaD?=
 =?iso-8859-1?Q?mwKEQcmq14zvjLMoKGG68d7WyBTKDOWLLA0bolc/4usZ5uenj/w/W2hu7R?=
 =?iso-8859-1?Q?RTFs4uz9nDPWSYg6vEtU/xwnEjKY6590Ml6ZnNcYLar3qiSSU23tpurEZR?=
 =?iso-8859-1?Q?BT5nPbpZzuAZJmkr3BcTKvSc/tFYj/dSbQEn1LicV0wUb35ziRw1oAVLxs?=
 =?iso-8859-1?Q?zxkSJZYqkjCk7RTVKH+sgI6dEJaB5oEkEK7usRhyUJIi7rJF1ycm8HJSyb?=
 =?iso-8859-1?Q?9s8P30+yaRRWiwoN6Xkbf8UaTVVFJyirpRkDNNqdKbRH5Okj2Iam7OMkwx?=
 =?iso-8859-1?Q?NLo6IGeAN6PlIogy8rHafmx3qlz8TXs8Byaq+ykJpWWjdDXXQsVjYYpdhv?=
 =?iso-8859-1?Q?K1OquueqE5FUAQ+5eeQEa0xObghSIrFfAhtdpLDa2WwCN/xMfNYySflCJ/?=
 =?iso-8859-1?Q?1RCXU0toLwhom7NXtadJSUgGnspDutFwsbecVylGJxWqBX1eIWQwE0s5Ej?=
 =?iso-8859-1?Q?YUqKh8X9vtHV7ZYyhPrWy86MZp3IU5oBO7NDFIyVAIApNh2h6EG7nLXcYz?=
 =?iso-8859-1?Q?UZnUJWc7znhYd/olTN1eszWdkgjeS/99bgEsZYlcWwXQ/h+jFXaE6O8Xnl?=
 =?iso-8859-1?Q?sgOCxQt1GedrJOUt2Au1PktmAb+4F8KHGkthTv6SggJykuSZq9y4tiAYAN?=
 =?iso-8859-1?Q?i1aEJd77HOen7BofxHon0o+DseiM2MmXC3sgHbVXgqJXFJl251SCI/dA5D?=
 =?iso-8859-1?Q?iLOTdNyYHkyF0Sal79vM58gXV0t7mZ84RD9mD2vQzNQgbF9MoDoRbA+DyK?=
 =?iso-8859-1?Q?BYsMNavwPUB+WAJo0S0Cm3gxe0xRcc+4mvRHC/gqxhch6rUcaCRl8cFtYV?=
 =?iso-8859-1?Q?4JU8t8fcUJUj22H6Bk8KIaGDYwGVH9tYrzm9Xb9lGQCjyxKIpJxZodRO8D?=
 =?iso-8859-1?Q?SMGyxUIL6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7a86b9-b2a4-4cb8-0083-08de74134ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:21.0819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /quFPY8M3ZF0NWwD/IRhMe3cEptG2pFA1kLNWB6SwkF1MOTO2zNdkXad16UKp3W4IwUlGgCMjMEC2k71+B70hekUNa6sN//DsOfTXllBLMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Hao Wu <wuhaotsh@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 56 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 7ca99fb87e..0b99c7edfb 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -17,6 +17,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "trace.h"=0A=
+#include "hw/core/irq.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
@@ -335,6 +336,46 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_update_irq(DWI3C *s)=0A=
+{=0A=
+    bool level =3D !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
+{=0A=
+    /* Only return the status whose corresponding EN bits are set. */=0A=
+    return s->regs[R_INTR_STATUS] & s->regs[R_INTR_STATUS_EN];=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_STATUS[13:5] is w1c, other bits are RO. */=0A=
+    val &=3D 0x3fe0;=0A=
+    s->regs[R_INTR_STATUS] &=3D ~val;=0A=
+=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_STATUS_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_signal_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_SIGNAL_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_FORCE is WO, just set the corresponding INTR_STATUS bits. */=
=0A=
+    s->regs[R_INTR_STATUS] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -348,6 +389,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        value =3D dw_i3c_intr_status_r(s);=0A=
+        break;=0A=
     default:=0A=
         value =3D s->regs[addr];=0A=
         break;=0A=
@@ -392,6 +436,18 @@ static void dw_i3c_write(void *opaque, hwaddr offset, =
uint64_t value,=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        dw_i3c_intr_status_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_STATUS_EN:=0A=
+        dw_i3c_intr_status_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_SIGNAL_EN:=0A=
+        dw_i3c_intr_signal_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_FORCE:=0A=
+        dw_i3c_intr_force_w(s, val32);=0A=
+        break;=0A=
     default:=0A=
         s->regs[addr] =3D val32;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

