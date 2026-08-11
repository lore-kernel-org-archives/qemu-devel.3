Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D90C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcyb-00030l-Gt; Mon, 10 Aug 2026 23:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtcyR-0002sJ-Dc; Mon, 10 Aug 2026 23:16:22 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtcyP-0005fC-7b; Mon, 10 Aug 2026 23:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRwhh9XB5kusNmQxXasBIY2akvx6ND1OYA0BB+8YeaMblXOx8t4hGGiqFHYs/okTAzACJPCciUmesO/7TN5q+tyHMBoLnRcRPnyjzPLcMhXAiSp4ZgRCFYv4S9U9MXnEFtGp10c71hTyRsPj4HytuF/5yjET0ps5ihBipPO5ykODe6SFuna/4G5EeJgVH9ibqfseZ5PZ+XWHoJVW5RCUDnU1Qlr6ZKANlR8Kx6FYBdanrE3GUdzHEKJgRjglsTXx7aIXeiUshexRHdzc4rezzyYeBDG0KCN1+XHbbq3MjsG7nHnCRZvaTnllvC3n0PsSeFYJ2zfPy1TnkeNU38oyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IClWpHxiV0+wDJCZEKBdjq00b+YjJbn4nm3ZL0oUh0=;
 b=EyFUs9ivw/gdiUBmmNOyoKg5uWWSVJNYKr5xGFaJPqB2RbBLWdUc/TuvS1MCjmrhR/fbz+43Lyhum72qhzRHc3xh5TICK+EmXinLSh9zNhmuLHcZcixt5WTWBzPfj3Bm1P/6R6cfn4KhrdtwwbMTNpZNwoYQIjfrEwX9WydzghIBn52cucwZzbM2cj4axx+z6EGJoc6/r0gVYTF60ZtK42bqaM5R7otSdU7IMYkZa8OHQtAcC1j+TXNBp/WYUp5HcC31WTcoHuXcqDVi4ESe1SrnBmDMrCzimnT90xS9dIuJRk+NlCwmUCuozKcnY5AP4GzAJzJdu1WVDUpGXg1CVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IClWpHxiV0+wDJCZEKBdjq00b+YjJbn4nm3ZL0oUh0=;
 b=q5ZfOYXtZRyT8kLh54TeJc9SOAy5URPrY1TPbj5vtbEP6bV37rflll2NB048z8T+9ZIRPanUW0qkBgaaCmJ11Cg77mOROGvHT63wtZDShfNCydc4ee0haMi4nfjh+WqFWDawey+F9ECcQgWWs4+LJ+RNQcm9FDlkjsq4vlIXc8F80RDMxrf8CPLHqYf9vsBgEg4NPOqlohxOdKBgcx6/D0c6QFzzyRWvtQnq7T8cyjnFVsRabe+lMxNgsW+Vwa8GH1QEx6lXb8rvTeK4MyUlMQrImyeQlfDnFEzoVUJaM3GyMDuirnIB8urQDnv0ei3P3fzyU4IDHuG0bH0a/hnRZQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB6105.apcprd06.prod.outlook.com (2603:1096:101:de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Tue, 11 Aug
 2026 03:16:12 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:16:12 +0000
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
Subject: RE: [PATCH v3 03/16] hw/misc/aspeed_hace: Support scatter-gather mode
 for the crypto command
Thread-Topic: [PATCH v3 03/16] hw/misc/aspeed_hace: Support scatter-gather
 mode for the crypto command
Thread-Index: AQHdKT74zFu+6TcLZEOvQZZZrZO3MbaYLPeQ
Date: Tue, 11 Aug 2026 03:16:12 +0000
Message-ID: <SI6PR06MB7631B92531CED76C4C358857F7DD2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
 <20260811031025.2784489-4-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-4-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB6105:EE_
x-ms-office365-filtering-correlation-id: 17dfe06a-4dbf-44ee-d3b3-08def756e5c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|38070700021|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: HOtz3DmyEMucU4Gh0uEt/DE04KB+5iPWeNti2z0BwWYZ3tHP6dCkzTkzlRsqAL0+mTbiXTlrnAqOACzHPZxEetuMIVbpYcT/BNFmIbLk/bqrCx8w65NDEXl6dHwJMBsPIExN6PzYUc2/pADH67zGpeXuj1WCBjUqBotCTiqWpcA1PslM3+Ez9+U8nBwlsLMFY6iFJjwOIAkTuo8l9eo0o2vtwewnHK0PfrLOjy0UQGTYtS1hnPSsODiYDETL//KB0ZgsZJcw7xK9zBwIfN3PEJT29RUfUEtKJqd305cxbBpxMV/MrjFkW+6Zm2m2FOA3fNwZ8IvSZ80pA0foC0R/OpP8LGhxi4GnFPac9WZbLf6dw/ZZJRqX1IrqohZGxlkYozR+DNGRSSVBoxlmRy8J5v5Kg7v0LCrUrcLKtlYCnkENZTIRGTl9Pva1y9z7gsS6xqcaGriXcKt6pFdtXtLpeIwidQIm0Wsg5Qs0cgOsKm2utUxK8TQ1ZjegXpCkOsBAmDrLN1A1Gk9o7cOKlTkacUgso6i7Y6e169HIw3rOUtxESJys5+TnybcjIJ3EItS8f3dHuWic0kAv2x9wpcHxAXB6BmmPjEIi6Q+zFv2YKEJ8DLVmGrB+Nr9SYSFxZaoZm5aiB/5Co1sRRqoqyFOl0CbQF0jrPwqHTvhU94DKxpG0QlDme9rTnHSxm8hZIZJj7QDxcv5iWlQqhJbiXEXOrvxr4Caojm+8mJk1pEpyV0KP3hF/WUOz3YAPVrMggPJB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MfthI2Mb8Ki/jXiJ5Jb0Mw8raIMSdXR054yXKiieIpcXSw3q9qWBIc3fF7?=
 =?iso-8859-1?Q?wHS4uBYDfaufcxWgm3+rctGS4KdCWS0y5mCdU0oUUNba1qaIPAtaqG8qUZ?=
 =?iso-8859-1?Q?89bTK3BpWUjp3kmcTwe2xp6BwngeWrKu+ayOtnP5bkaUzbA9/cOiSoFIL2?=
 =?iso-8859-1?Q?TvXrJkDUpDR2N7IzA7aMnJpbY13rrnLqhhYbzEqzCzOrZ9fN/FfHS+G6CB?=
 =?iso-8859-1?Q?EvECi5JgjGKIZxLsZ2Atv9HKGB0fB3fKoTHHw0G+fS2TshtP7wn8rj9MwH?=
 =?iso-8859-1?Q?5CzCGELupmH/X1B9xpsVvm0FcKF0K3AVh8Co2yybiOoloe7JpDVbTGvSaF?=
 =?iso-8859-1?Q?xPtkVUWQlDPQDUyHpsSIywvWKVJ9jB3MYoONPUiO5QQrtBgjY7UVKZ/+vh?=
 =?iso-8859-1?Q?Jwe0g/8RrQD3FA7At1+947mRITSX0g48xkjZCMxz0o49WuuCxn5V+Hv+1C?=
 =?iso-8859-1?Q?hWHGLf0nMnsjyVPQVVV33VkPNdPCyj8Nslb3BzzJHABlRz/thtay4FNu0t?=
 =?iso-8859-1?Q?5PD2qgGrJVZ8dEnVHwOf+XbGGxBJmTpKR9hSay6tAzByWJQM6+flRpHBiH?=
 =?iso-8859-1?Q?RXiMdIRjGluBJe+GAn9eMI4UqoIT9eAdcIS8Yi1sHQUU6Kfjbefqf7Rlr0?=
 =?iso-8859-1?Q?/cDsrffjwPVKpJ4ipxtcJLzYZj0L9JhZ/i5f4mxhVy7K3DUSTGzd7098+w?=
 =?iso-8859-1?Q?+HZUOIuUOw1Bllpf80Z2RN42f7I0C14ciJyUP0PpNXb6G+aOZLEY5h5T/c?=
 =?iso-8859-1?Q?4zPaZqPcm0PenIJXvjR2EN/oD9KY1reboOeCbFkvO395mU0NUxR1JAkNmz?=
 =?iso-8859-1?Q?7hezMZIJRU/e/o0lZ8YJouDE6jtdsujDqFkV6sy/Mcc+sv3/+8BEpaBrwO?=
 =?iso-8859-1?Q?4V278ETxJ8Poj9FnCZh6vo4hGAdspDmRsF5WtUWXCx4Iyn4tVQjojuHpZX?=
 =?iso-8859-1?Q?Eb1uZsF6E7D38TtaVB4CagqZZ5KxmCaTIeU9N6fmSlTthrIAOfm7Kb3qOz?=
 =?iso-8859-1?Q?8Lyc7u2dXtBoeIhESEPea7QHzb4HcHUeWkVrxo7NcDB/7Zaasi0Pztniwn?=
 =?iso-8859-1?Q?ceeSFjC6FcLVtap9vXITLsD6dXcRpXVhYs07BFITbbrT9uH7LjeaHwlF1X?=
 =?iso-8859-1?Q?0pTsQo4DeVa+PiA0U4nIEkjFAxYvDsGI/Yxv6G17AfhXbHeghGZGoRToD0?=
 =?iso-8859-1?Q?8yUzvqd9qA3K9lWcreHUHwXyC/r3ybQGjBRQfYj0RqM6v4eQIEtRn50zNT?=
 =?iso-8859-1?Q?aaLM2mE79MFIJSrDtftvfcxkWAKkNW9ZcyXC2TFv/8LHecDgdPWYLdeDKT?=
 =?iso-8859-1?Q?WIjrUz4etQ0lxwWgHj2G/jpXAp6mkcXFk0YP6Iw344B57dIRIsFGNZBBte?=
 =?iso-8859-1?Q?WSp5xqBux/UKhAR/BPkLDQ7ZIWB1guUooKsvlzNM8ai2xPj863yc2Jyijb?=
 =?iso-8859-1?Q?yHDVK1RJsTvphIclsXLlVpEjv0Ze57CmQSSd91FgDajDcfdGf0xNFH6j9L?=
 =?iso-8859-1?Q?Rsw7Lij8jpfNCqWEfFwqB8JGwu1CA5Oja8iFeM6WZjFkuaisjKTYKPu1rG?=
 =?iso-8859-1?Q?swsLwjTCzNVdJ29RiZuK5t/DNLzYy92svXa5RxZnwnhNAR8A4joxsBV400?=
 =?iso-8859-1?Q?nj/C12cxkWIjGv/02yvIVyrYG6seeWHUUweY0hkHKmkD/egD7DM9scwpmP?=
 =?iso-8859-1?Q?kgMR+Gxw4SWKe94XuHOS+r/cc6UWUt8xLRSGn9TVjmG5mxpyNpJ6GLqCqE?=
 =?iso-8859-1?Q?yDCM7F1y0+uTx/1oM/pZaFTh3wbiFPH7bur+AKGQ130yts1IDjwNGfWAJ/?=
 =?iso-8859-1?Q?l3AxsTOBIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o99uyzdAVNU1R/yxp0/Em7hO/o7ZcFit8NqVSmgpfCoIhYjYbPVDWuIS46XSMaIHZPwKETP4pZOK2Ff1n3A/Apwl/sphSFpxHL54y4xqlx5snvdSACOCu6DrnDUJKT1sK6UgYQu5ZdTVgr5o530M44Fm17wBNcX9/X1/5kBoNITWs+1Fi5hyiaEk5/bzE48NDeuT38PjQjgfge5oD57qQFcsrVQkGmE879UWsA3CmD0PM2i0brN9ugei/GB3PoRHRAYyW9NPd9ohwjwK/PtR6WyAdQN5S9YcIJyMUqshK6UQWtk5fo1C23scwLLHXYdWuyymLLCAmBl4JAIvaymvHQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dfe06a-4dbf-44ee-d3b3-08def756e5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:16:12.7213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0M+jfuH0qNO43gd6wZLfD/Nv3wH+qCojTXzyU8CSrnExpcr0xRSHqujaP9X57aIUPmNJbDrItIlBv2f3CAC4hX44by4x7pcE1BH+LNDnQy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6105
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
> Sent: Tuesday, August 11, 2026 11:11 AM
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
> Subject: [PATCH v3 03/16] hw/misc/aspeed_hace: Support scatter-gather mod=
e
> for the crypto command
>=20
> The AST2600 and later crypto engines drive the source and destination thr=
ough
> scatter-gather lists (HACE10[18]/[19]) rather than the single contiguous =
buffers
> used by the AST2500 direct access mode. Each SG list entry is a length wo=
rd
> (SG_LIST_LEN_LAST marks the final entry) followed by a DRAM address,
> matching the hash engine layout.
>=20
> Add a crypt_prepare_sg() helper that gathers the source into / scatters t=
he
> destination out of the bounce buffer by walking the SG list, and select i=
t or the
> existing crypt_prepare_direct() from do_crypt_operation based on HACE10[1=
8],
> mirroring the hash engine's direct/scatter-gather dispatch.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 70
> +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> 0f35d74137..646ff50476 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -608,13 +608,58 @@ static bool crypt_prepare_direct(AspeedHACEState
> *s, uint64_t addr,  }
>=20
>  /*
> - * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the
> source
> - * and destination are single contiguous buffers (HACE00/HACE04) and the
> IV/key
> - * come from the context buffer (HACE08). For CBC the resulting chaining=
 IV is
> - * written back to the context buffer so the driver can continue the cha=
in.
> + * Scatter-gather mode: the source/destination register points at an SG
> +list
> + * whose entries are a length word (SG_LIST_LEN_LAST flags the final
> +entry)
> + * followed by a DRAM address, matching the hash engine layout. Gather
> +@len
> + * bytes into @buf, or scatter @buf back out when @to_dram is true.
> + * Returns true on success.
> + */
> +static bool crypt_prepare_sg(AspeedHACEState *s, uint64_t addr,
> +                             uint8_t *buf, uint32_t len, bool to_dram)
> +{
> +    uint32_t copied =3D 0;
> +    uint32_t sg_addr;
> +    uint32_t sg_len;
> +    uint32_t entry;
> +    int i;
> +
> +    for (i =3D 0; i < ASPEED_HACE_MAX_SG && copied < len; i++) {
> +        entry =3D address_space_ldl_le(&s->dram_as, addr,
> +                                     MEMTXATTRS_UNSPECIFIED,
> NULL);
> +        sg_addr =3D address_space_ldl_le(&s->dram_as, addr +
> SG_LIST_LEN_SIZE,
> +                                       MEMTXATTRS_UNSPECIFIED,
> NULL);
> +        sg_len =3D entry & SG_LIST_LEN_MASK;
> +
> +        sg_addr &=3D SG_LIST_ADDR_MASK;
> +        addr +=3D SG_LIST_ENTRY_SIZE;
> +
> +        if (sg_len > len - copied) {
> +            sg_len =3D len - copied;
> +        }
> +        if (address_space_rw(&s->dram_as, sg_addr,
> MEMTXATTRS_UNSPECIFIED,
> +                             buf + copied, sg_len, to_dram)) {
> +            return false;
> +        }
> +        copied +=3D sg_len;
> +
> +        if (entry & SG_LIST_LEN_LAST) {
> +            break;
> +        }
> +    }
> +
> +    return copied =3D=3D len;
> +}
> +
> +/*
> + * Perform an AES/DES/3DES ECB/CBC operation. The source and
> +destination are
> + * either single contiguous buffers (direct access mode) or
> +scatter-gather
> + * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come
> +from
> + * the context buffer (HACE08). For CBC the resulting chaining IV is
> +written
> + * back to the context buffer so the driver can continue the chain.
>   */
>  static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)  {
> +    bool sg_mode =3D cmd & CRYPT_CMD_SRC_SG_CTRL;
>      uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];
>      bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;
>      g_autoptr(QCryptoCipher) cipher =3D NULL; @@ -631,6 +676,7 @@ static
> void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>      size_t iv_offset;
>      size_t blocklen;
>      size_t keylen;
> +    bool status;
>=20
>      if (len =3D=3D 0) {
>          return;
> @@ -684,8 +730,14 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      src_buf =3D g_malloc0(len);
>      dst_buf =3D g_malloc0(len);
>=20
> +    /* Gather the source into the bounce buffer, per the selected mode.
> + */
>      src_addr =3D s->regs[R_CRYPT_SRC];
> -    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {
> +    if (sg_mode) {
> +        status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);
> +    } else {
> +        status =3D crypt_prepare_direct(s, src_addr, src_buf, len, false=
);
> +    }
> +    if (!status) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx
> "\n",
>                        __func__, src_addr); @@ -714,8 +766,14 @@
> static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>          }
>      }
>=20
> +    /* Scatter the result back out, per the selected mode. */
>      dst_addr =3D s->regs[R_CRYPT_DEST];
> -    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {
> +    if (sg_mode) {
> +        status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);
> +    } else {
> +        status =3D crypt_prepare_direct(s, dst_addr, dst_buf, len, true)=
;
> +    }
> +    if (!status) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx
> "\n",
>                        __func__, dst_addr);
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

