Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8288DC5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtJz9-0008Ue-RO; Mon, 10 Aug 2026 02:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtJz3-0008UL-FK; Mon, 10 Aug 2026 02:59:42 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtJyz-0007RW-4o; Mon, 10 Aug 2026 02:59:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRDx/f4bai1oEdeF045d8sJtrlEuaiugJRHuWL0KjOuTNbn2peAAwtlUgIjkOUxrLN3oRacBVpsOvYMqodmg51AQiA9wuialFu/ZRb5EXEMUfvnAWOoKPojRLUg+xM013XIbxa6LywjT/2n/Kod5JOXSPvg3jAamMUeX4/mlA6nhN4Db+6D5IvvmYN0HEFvqIzv3Jz+bMgM9Sch5QPzn14wekjinsXXJkIF08yyTwjWfAg/TaJPJxb6ukGLL7lXrR0vIjG3e7rAvuRJWI8nPCsDfI1mIauvpQ2NrQCQGcKYOQ+PZqVW8alrz9NYTKTxOW6FD0yLSJGT656lQ1mSo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/QA2fzKje6kBRWJOnNKDajiBU0nbb21f9/xjrB84pY=;
 b=yRIpZPDiMjdKsT6o/qM7GY+r1SrdxBbgtozIAyl0p9BtI6B2uF0peLEYwSVAYTGJs/Xr4qnHbDDZqiur7fyJ9Ah2PjtGigAU5fGK0zcaf57zjuPLrwD3kC9YYl5dy82BRxNd5p8AiiZoRhWzEFElLxi9avmAPhXBGDfNbNmn1FuO0gyHi95q8df6BAsBBGAwl+PmvAan2Jb5APmx0e9qLXGefX9rI9eGAnpgKwiGzVs2CqjvdHNjqQB4M2DpbMeEUIv4/jzx5Pmpv+NbILYIigmR7mr9Bp8OF5UBXMy3xLYPMMdPd8dHwPSpZ90y0RMGEmn7yl1+GUyNjcb2r8+34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/QA2fzKje6kBRWJOnNKDajiBU0nbb21f9/xjrB84pY=;
 b=Z3qs16eEbnQE7e+gMg5lM9T7EVrkV5GzlcIxQVjFnA2WTuX3aBneP5LJV77Npjt+/cpa+yUCQE5nySNthGWRxD8/JbPzndGauX5cVXu+gWJL5d3xfxrbB7Fa111W82ycfosroHQ2Hxz3cls8oTxMkGQzACXxKr9zCaB2/es3CI4659YjKY5HrgGZXLpp9CCNl0URvAFOR1iQEAVQlzlGnQ+0dQ2eMSqHCW4EzYG3AQugcvOO2R19pomWTRTF3WxuZg88VqEuotBXEi2yb7M0h5v5MhDzp9X5yVAr1jKGURIXFu/knGkXQYAYDbvsND3chTt0xud47kIby4IXnuNL6w==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SG2PR06MB5105.apcprd06.prod.outlook.com (2603:1096:4:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:59:24 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:59:24 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Topic: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Index: AQHdFAqsmnhYLzIyTkeDj1ZTaDcyKbaXAMxA
Date: Mon, 10 Aug 2026 06:59:24 +0000
Message-ID: <SI6PR06MB7631D594BB6D342FEC137AD4F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-2-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-2-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SG2PR06MB5105:EE_
x-ms-office365-filtering-correlation-id: 0f1ff05f-75fb-4c12-4c3c-08def6ace93d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|4143699003|921020;
x-microsoft-antispam-message-info: wxnzyWXn3ydVXE1HN9eKLSMJTpKdMRoc5jWoQa1+xisBMSXvVxbu5LwX5zRTQmT706vC5kkdE/pvWEXk33U4zgHN3D4EyGaWcs7qhKORkoKsbE7eBStO45tEEuiewxXoa4d3GiEPhIwilnwF5sZT+7reS3Cyfu57cAX4ImLoT/9uQIhi9qCm1V1lMwFyfOKlb+c5Y+XR/H7m5B43VaHEM/HPmfivw+cDPeY0uvuirZIPJA61eDBronfg/oNKALjPKIlFDm6X/LlH292SJM+nAgIvAYdXiE97MBySISKGFUipguh8gYfuk+s/2uLK7bGUtQTg/TigoXeAhN31KaoIHBXF6l4oEjFf5NlEJBqAmXhFHUOF46SEd2Xp9IzuHKq6sh1uCX39YTFl/TESgWHI32uUu9bpNUSQj3JaGigireqomHW8JHihGByyzyHujUgyhnDm1IjeU4s8OPtpBvmzGDKLN9IpGzi7/p6Hn7aE2buzKkxVukO6GFkJrw/hX0dEmNSZazRUS+0gRZLQ9GUpJwdkUiJAG0gELfw9HG2BBCMfi8uAyCaVrkrTy0oYpZblUbSLJrzDnZk4G+BT2CTDTW9AKUI7KEVLn0lAu0hE5PFjvSgwok3cnwZmd1UVKa4BO/nWN03wIv1wuNi8MTu30TVhXsG+b/D4Qh7pzNnRhRjcQjFiw4CbkJoMiNDMypFyOXg7/5kYDdBLZ+B4mxS2mVfUfjzQGKrWkTVRwIm+PZR38muCL2VF2Dr7uzrj2hm9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HS1VdhDJv3nUCCdOT0qmMb+f1+E9+bVMKl9UJbeiAETmw40xNh7p/ylb2z?=
 =?iso-8859-1?Q?3PiIkery6ZwztUUneZQ2m5Cll/IsNFJM15hIeZTr8zG8/jfxCy83mEsGp0?=
 =?iso-8859-1?Q?CvHcJcGKh495vk0Mka7+z3pwYkrT2RgYxfqqJyLoPf4aT3FbrFkBGyDyad?=
 =?iso-8859-1?Q?psfN4wkw7Ll4e96IXmX4mEvTHVkRyg+pOR2/QVr+gaDYVBX3Qqbp3wYrq6?=
 =?iso-8859-1?Q?b+mW++yM/YFMBpRr/ejjg5tjuHNX3TCbcaCVwFPCn7r4Gy0nKeQEVMU4ZV?=
 =?iso-8859-1?Q?UIH84kwrpueCo/HMNtvT+fbyOYOGgObWTmCuBrdjKnKSIlI4Mo+ipl1cWr?=
 =?iso-8859-1?Q?Mqh4bOT35bNN3wezvwNfM3LScmnyd4yC2kZgJnoNLLcO60NL2mi9SMZPxO?=
 =?iso-8859-1?Q?pn8bSbgFXxvdmqp2mQJ8W64/t8tpKszpxQIAxSpFEEMdmbF0xz3bIVN75m?=
 =?iso-8859-1?Q?6pWQ7xFx653n45vUGQ4qb2PVzMbR0/OEIVFjpF9lb/GKg9LBUX7Ri6yn3q?=
 =?iso-8859-1?Q?kvXcDvqwJDTEpAgQkv+675iFJnposw1NZ0yMOQjg3NZDihZpC7u3CFF0KM?=
 =?iso-8859-1?Q?+sZEwlc0r3J4bwUjgq1xNNYOZBsl3Xos0y01EaeqtuwLAK6nzUfB+91LQJ?=
 =?iso-8859-1?Q?fSoaePUWOhfDuflhmBy9gMJ6rBB8QvttjLkvB39arU96jRI/uBH1r3AOtL?=
 =?iso-8859-1?Q?G+N7BhpVEw+AKFNkXB+DjUm+kIwIKVZt2hX6KbiISi2v86co4dGXE5MRF3?=
 =?iso-8859-1?Q?S+o8RDC4gYZGtcZOkqS6u1cmLkDN07cwoHwWtdOQzbyRafyJ0rNETEQDcl?=
 =?iso-8859-1?Q?7jpr0lUTcd3+Kc+T4NbWkJu9IBGUhBO5MxvaqXI/+S+vNbwm2L8Ub3i4K6?=
 =?iso-8859-1?Q?hJPxq5PykAKSbb5sYg9vGwK1/yWAe+mh8f9WBvOkCQl/Es8/SK+TOMEq8z?=
 =?iso-8859-1?Q?DpjQfPEu426KMmH+vYujkYoDK6SWgqEU9M/ZaLHhTzOyJjz1WwqhPKXqI+?=
 =?iso-8859-1?Q?LQDQwBiPQzn90gq/WpoA7Cue2h+H+gViZOOXgW9ySQZNxvyRjXIYMbx1gx?=
 =?iso-8859-1?Q?znAQsPHbBU0LuUn83S66KmFhO/9FXx3IgXKeo5byeswHrbcaEmvjQiC8FM?=
 =?iso-8859-1?Q?S/MtR6jfto7YIBECGXJbKe1h8NYP+PNzt4IXZGO2/mK3lhsZVMWdJHFeUc?=
 =?iso-8859-1?Q?bpavkcR7yGlGNsOxeCg+FXu0UnZAHIGAjz8PRujgllzDC/zIKxBY5fgOir?=
 =?iso-8859-1?Q?EExUJ0qXKKuFtUvNDuxiV322a8EPS7zfuCM0Yw18126ddUJ3w3yJA6HGrQ?=
 =?iso-8859-1?Q?JW2UlDxayR1CzZV1bS/FdMa2QVygxdlHRLIT8NTX0qZ8/jGvZ0vpKYRTFZ?=
 =?iso-8859-1?Q?vGFvF7OHaDbSR5iZ8DEhkRBJqJZwl59PrMA5mJEaK5PxrU+bBmpDh3xrLO?=
 =?iso-8859-1?Q?6CDHIloftiCFCqrtRgPb622yk3UQ22pPpCJabKfSci23T9czr6AHNft8gK?=
 =?iso-8859-1?Q?Ew8EP7dQjNYfX3ETmunY7rGG8/3D0sJobIRt8vEPA+D2Q6e+A+WSz+5Df+?=
 =?iso-8859-1?Q?402ASM49q0U7gL3nxvt0bMyGjwKv+fEkcy/ntIwW1HZwXMqke1/7V8dfu0?=
 =?iso-8859-1?Q?YKhNl2bljqo878yrYTT5MFYUknnKgh9I2MrogDY8dgqeABWh90neBAeypX?=
 =?iso-8859-1?Q?zi31DOmhZvFp31PxhwygvQw2GblZeVBq6VLVCT9+gSdnXK9x9ybOymfV4u?=
 =?iso-8859-1?Q?OtU/dQ3qddo2KyPISsuypFv8fTX19RSf5cYh8OpHiLlAX2BwGGQEEWuQWC?=
 =?iso-8859-1?Q?b9wTY/QOLQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f7GFT6mC+j7VcRyFolf7kpLVRmthLRYxCt5/nr6MMJPMdgXyORZkF2OcG4hQpLURQW/yF0s+59MTKIJ1zbTDHXfYRDzJmqvMVuol5msPKibhZkD2oAfSDK8AtiPZ9kBDuVvKDTcMNzUPlFPZyA1aewaUIlUFzurlx/pkc+RKDI6MHzj9kSmRiazwpcEh6iVMD6q6v4nTLYhsY41gp/8oi3JPEpQCbdQzoyHblIOQqUxr03GIryuh6C3p0cDtBHB06i70hosDVE86RJUK6x4WtznuALbOj45AUU5zy00zrAqQvXY0R3gA84Svj7+cFWRfvP0cVDxCgvve6k3Ot9m2ag==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1ff05f-75fb-4c12-4c3c-08def6ace93d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 06:59:24.0674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pNiu27uLnPwntrqjNB+DJA39WePvrx3bOBYiBCIFxtOIkLqcb3jzfi5A+ytf4MC0c7MpdLcNkxeFmOSEmfYjNHmnkKq2vqZjCfsBrtyq30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5105
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Wednesday, July 15, 2026 11:33 AM
> To: Daniel P. Berrang=E9 <berrange@redhat.com>; C=E9dric Le Goater
> <clg@kaod.org>; Peter Maydell <peter.maydell@linaro.org>; Steven Lee
> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Kane Chen
> <kane_chen@aspeedtech.com>; Andrew Jeffery
> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; Eric Blake
> <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>; Fabiano
> Rosas <farosas@suse.de>; Laurent Vivier <lvivier@redhat.com>; Paolo Bonzi=
ni
> <pbonzini@redhat.com>; open list:All patches CC here
> <qemu-devel@nongnu.org>; open list:ASPEED BMCs
> <qemu-arm@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> <troy_lee@aspeedtech.com>
> Subject: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto
> command in direct access mode
>=20
> The crypt command register was previously stubbed out. Implement it for t=
he
> direct access mode, where HACE00/HACE04 point directly at contiguous sour=
ce
> and destination buffers. AES-128/192/256, DES and 3DES are supported in E=
CB
> and CBC modes via the qcrypto cipher API; the IV and key are read from th=
e
> context buffer (HACE08) and, for CBC, the resulting chaining IV is writte=
n back
> to the context.
>=20
> The completion interrupt is now raised for every HACE variant as the hard=
ware
> does, which fixes the crypt command hang on the AST2500, AST2600 and
> AST1030. The AST2700 crypto engine still needs 64-bit DMA and AES-GCM,
> which are added later, so it keeps its temporary interrupt-only workaroun=
d
> until then.
>=20
> For debugging, the context, source and destination buffers are dumped thr=
ough
> the existing aspeed_hace_hexdump trace event (disabled by default). CTR
> mode, scatter-gather mode and AES-GCM are added separately.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 283
> +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 269 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> c61efe50c4..de4399f322 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -18,11 +18,44 @@
>  #include "qapi/error.h"
>  #include "migration/vmstate.h"
>  #include "crypto/hash.h"
> +#include "crypto/cipher.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/irq.h"
>  #include "trace.h"
>=20
> -#define R_CRYPT_CMD     (0x10 / 4)
> +/* Crypto engine registers */
> +#define R_CRYPT_SRC         (0x00 / 4)
> +#define R_CRYPT_DEST        (0x04 / 4)
> +#define R_CRYPT_CONTEXT     (0x08 / 4)
> +#define R_CRYPT_DATA_LEN    (0x0c / 4)
> +/* HACE0C[27:0] holds the crypto data length */
> +#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF
> +#define R_CRYPT_CMD         (0x10 / 4)
> +/* Crypto engine command register (HACE10) bits */
> +#define  CRYPT_CMD_ENCRYPT          BIT(7)
> +#define  CRYPT_CMD_ISR_EN           BIT(12)

Regarding CRYPT_CMD_ISR_EN, the current code already has similar definition=
s, such as CRYPT_IRQ and CRYPT_IRQ_EN. Would it make sense to migrate these=
 definitions together for consistency?

> +#define  CRYPT_CMD_DES_SELECT       BIT(16)
> +#define  CRYPT_CMD_TRIPLE_DES       BIT(17)
> +#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)
> +#define  CRYPT_CMD_DST_SG_CTRL      BIT(19)

CRYPT_CMD_DST_SG_CTRL is currently defined but not used anywhere. Could we =
defer adding this definition until it is actually needed?

> +/* Operation mode HACE10[6:4] */
> +#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)
> +#define  CRYPT_CMD_ECB              (0x0 << 4)
> +#define  CRYPT_CMD_CBC              (0x1 << 4)
> +/* AES key length HACE10[3:2] */
> +#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
> +#define  CRYPT_CMD_AES256           (0x2 << 2)
> +#define  CRYPT_CMD_AES192           (0x1 << 2)
> +#define  CRYPT_CMD_AES128           (0x0 << 2)
> +
> +/*
> + * Crypto context buffer layout (HACE08). The IV is at the start of the
> +buffer
> + * (DES places its 8 byte IV at offset 8) and the cipher key at offset 0=
x10.
> + */
> +#define CRYPT_CTX_IV_OFFSET         0x00
> +#define CRYPT_CTX_DES_IV_OFFSET     0x08
> +#define CRYPT_CTX_KEY_OFFSET        0x10
> +#define CRYPT_CTX_SIZE              0x30
>=20
>  #define R_STATUS        (0x1c / 4)
>  #define HASH_IRQ        BIT(9)
> @@ -501,6 +534,216 @@ static void do_hash_operation(AspeedHACEState *s,
> int algo, bool sg_mode,
>      }
>  }
>=20
> +static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg, size_t
> +*keylen) {
> +    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {
> +    case CRYPT_CMD_AES128:
> +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_128;
> +        *keylen =3D 16;
> +        break;
> +    case CRYPT_CMD_AES192:
> +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_192;
> +        *keylen =3D 24;
> +        break;
> +    case CRYPT_CMD_AES256:
> +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_256;
> +        *keylen =3D 32;
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Decode the crypto command register into a libqcrypto algorithm/mode
> +pair
> + * and the block/IV geometry. Returns false for unsupported selections.
> + */
> +static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,
> +                             QCryptoCipherMode *mode, size_t
> *keylen,
> +                             size_t *blocklen, size_t *iv_offset) {
> +    if (cmd & CRYPT_CMD_DES_SELECT) {
> +        *blocklen =3D 8;
> +        *iv_offset =3D CRYPT_CTX_DES_IV_OFFSET;
> +        if (cmd & CRYPT_CMD_TRIPLE_DES) {
> +            *alg =3D QCRYPTO_CIPHER_ALGO_3DES;
> +            *keylen =3D 24;
> +        } else {
> +            *alg =3D QCRYPTO_CIPHER_ALGO_DES;
> +            *keylen =3D 8;
> +        }
> +    } else {
> +        *blocklen =3D 16;
> +        *iv_offset =3D CRYPT_CTX_IV_OFFSET;
> +        if (!crypt_aes_alg(cmd, alg, keylen)) {
> +            return false;
> +        }
> +    }
> +
> +    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {
> +    case CRYPT_CMD_ECB:
> +        *mode =3D QCRYPTO_CIPHER_MODE_ECB;
> +        break;
> +    case CRYPT_CMD_CBC:
> +        *mode =3D QCRYPTO_CIPHER_MODE_CBC;
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Direct access mode: the source/destination register (HACE00/HACE04)
> +points
> + * at a single contiguous buffer in DRAM. Copy @len bytes between it
> +and the
> + * bounce buffer @buf; when @to_dram is true @buf is written out,
> +otherwise it
> + * is read in. Returns true on success.
> + */
> +static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,
> +                                 uint8_t *buf, uint32_t len, bool
> +to_dram) {
> +    return !address_space_rw(&s->dram_as, addr,
> MEMTXATTRS_UNSPECIFIED,
> +                             buf, len, to_dram); }
> +
> +/*
> + * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the
> +source
> + * and destination are single contiguous buffers (HACE00/HACE04) and
> +the IV/key
> + * come from the context buffer (HACE08). For CBC the resulting
> +chaining IV is
> + * written back to the context buffer so the driver can continue the cha=
in.
> + */
> +static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd) {
> +    uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];
> +    bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;
> +    g_autoptr(QCryptoCipher) cipher =3D NULL;
> +    g_autofree uint8_t *src_buf =3D NULL;
> +    g_autofree uint8_t *dst_buf =3D NULL;
> +    uint8_t ctx[CRYPT_CTX_SIZE];
> +    Error *local_err =3D NULL;
> +    QCryptoCipherMode mode;
> +    QCryptoCipherAlgo alg;
> +    const uint8_t *next_iv;
> +    uint64_t ctx_addr;
> +    uint64_t src_addr;
> +    uint64_t dst_addr;
> +    size_t iv_offset;
> +    size_t blocklen;
> +    size_t keylen;
> +
> +    if (len =3D=3D 0) {
> +        return;
> +    }
> +
> +    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen,
> &iv_offset)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Unsupported crypt command 0x%x\n",
> __func__, cmd);
> +        return;
> +    }
> +
> +    if (!qcrypto_cipher_supports(alg, mode)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: cipher mode not supported by the crypto
> backend\n",
> +                      __func__);
> +        return;
> +    }
> +
> +    /* Fetch the IV and key from the context buffer in DRAM. */
> +    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];
> +    if (address_space_read(&s->dram_as, ctx_addr,
> MEMTXATTRS_UNSPECIFIED,
> +                           ctx, sizeof(ctx))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to read context, addr=3D0x%"
> HWADDR_PRIx "\n",
> +                      __func__, ctx_addr);
> +        return;
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> {
> +        hace_hexdump("context", (char *)ctx, sizeof(ctx));
> +    }
> +
> +    cipher =3D qcrypto_cipher_new(alg, mode, ctx + CRYPT_CTX_KEY_OFFSET,
> keylen,
> +                                &local_err);
> +    if (cipher =3D=3D NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new
> failed: %s\n",
> +                      __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +
> +    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&
> +        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,
> +                             &local_err) < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv
> failed: %s\n",
> +                      __func__, error_get_pretty(local_err));
> +        error_free(local_err);
> +        return;
> +    }
> +
> +    src_buf =3D g_malloc0(len);
> +    dst_buf =3D g_malloc0(len);
> +
> +    src_addr =3D s->regs[R_CRYPT_SRC];
> +    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx
> "\n",
> +                      __func__, src_addr);
> +        return;
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> {
> +        hace_hexdump("src", (char *)src_buf, len);
> +    }
> +
> +    if (encrypt) {
> +        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,
> +                                   &local_err) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed:
> %s\n",
> +                          __func__, error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +    } else {
> +        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,
> +                                   &local_err) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed:
> %s\n",
> +                          __func__, error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +    }
> +
> +    dst_addr =3D s->regs[R_CRYPT_DEST];
> +    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx
> "\n",
> +                      __func__, dst_addr);
> +        return;
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> {
> +        hace_hexdump("dst", (char *)dst_buf, len);
> +    }
> +
> +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_CBC) {
> +        /*
> +         * CBC chains on the last ciphertext block: the final block of t=
he
> +         * output when encrypting, or of the input when decrypting. Writ=
e
> it
> +         * back as the IV for the next request.
> +         */
> +        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;
> +        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,
> +                                MEMTXATTRS_UNSPECIFIED, next_iv,
> blocklen)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Failed to write IV, addr=3D0x%"
> HWADDR_PRIx "\n",
> +                          __func__, ctx_addr + iv_offset);
> +        }
> +    }
> +}
> +
>  static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int
> size)  {
>      AspeedHACEState *s =3D ASPEED_HACE(opaque); @@ -531,16 +774,22
> @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data=
,
>                  qemu_irq_lower(s->irq);
>              }
>          }
> -        if (ahc->raise_crypt_interrupt_workaround) {
> -            if (data & CRYPT_IRQ) {
> -                data &=3D ~CRYPT_IRQ;
> +        if (data & CRYPT_IRQ) {
> +            data &=3D ~CRYPT_IRQ;
>=20
> -                if (s->regs[addr] & CRYPT_IRQ) {
> -                    qemu_irq_lower(s->irq);
> -                }
> +            if (s->regs[addr] & CRYPT_IRQ) {
> +                qemu_irq_lower(s->irq);
>              }
>          }
>          break;
> +    case R_CRYPT_SRC:
> +    case R_CRYPT_DEST:
> +    case R_CRYPT_CONTEXT:
> +        data &=3D ahc->src_mask;
> +        break;
> +    case R_CRYPT_DATA_LEN:
> +        data &=3D CRYPT_DATA_LEN_MASK;
> +        break;
>      case R_HASH_SRC:
>          data &=3D ahc->src_mask;
>          break;
> @@ -589,13 +838,19 @@ static void aspeed_hace_write(void *opaque,
> hwaddr addr, uint64_t data,
>          break;
>      }
>      case R_CRYPT_CMD:
> -        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not
> implemented\n",
> -                       __func__);
> -        if (ahc->raise_crypt_interrupt_workaround) {
> -            s->regs[R_STATUS] |=3D CRYPT_IRQ;
> -            if (data & CRYPT_IRQ_EN) {
> -                qemu_irq_raise(s->irq);
> -            }
> +        /*
> +         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM,
> which are
> +         * added later; until then it keeps the temporary workaround of
> only
> +         * raising the completion interrupt without running the command.
> +         */
> +        if (!ahc->raise_crypt_interrupt_workaround) {
> +            do_crypt_operation(s, data);
> +        }
> +
> +        /* Hardware raises the crypt interrupt once the command finishes=
.
> */
> +        s->regs[R_STATUS] |=3D CRYPT_IRQ;
> +        if (data & CRYPT_CMD_ISR_EN) {
> +            qemu_irq_raise(s->irq);
>          }
>          break;
>      case R_HASH_SRC_HI:
> --
> 2.43.0

