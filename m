Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C68C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK10-0001DX-MI; Mon, 10 Aug 2026 03:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK0l-0000yH-7p; Mon, 10 Aug 2026 03:01:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK0f-0007qu-EY; Mon, 10 Aug 2026 03:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCc6aNVtwwedODg31RrZO8i4J0WvoqES8uEK2fv78fpplyXXnwQFRxJzP42HwU78un3qEtGGFOg35g/kjQMIm/dAKmXWsqTE3f4945pcXfr6JVhXaD3jp1QgaDn/NfP2gRF4Kv4ImU1ragf6NYrMlAYbfsYEy+vlpUc4R3gDLO9XfdCBz2mqwKqloRNP0vbfdotkErJX0gSvzK4vmVOI4U0vgLU1qLWLyO3MEuf5k214hYmXmfgn2KZZtlZP9BQ3KavFQEc3shW936MsyHiLC2tQ5nr/zxfYP/dPyrXS26KsTIXJtsk4Xth/rVOu5pfXFn3oE8d83JueYP59L2s0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCy0yB/jKI04yApXE/n6OXJGemM3HSH8a2K6AuxH1ts=;
 b=dW0ooyvUl8sXtsqsDM4sLN/5VUNOnLO5pHt4SDnWySBm7NDgFQGsoWxbInFrgfUKi/rqpdBmgkKwmfq5Axpb0f7Iza+RAoVRJAva4p0nwHDk7NR74rqeq9ZIpxdvh61V8Q4pUgdjhvXS38oY+Yl6WQa5/2Ayo7TwFGfRS3ZajO+2PDjnma9MTqwWbvE+/KnX44lqAquBs4IE6ZUjJWVs207AdDxRXLD/r/wHugOjLgVQa4LVOwQbZirtVvt1KOiKCuWZaUpJ0zUq/gpGny5M4euJ0rp2KxzheOzh2L84S2ns62rJPmRFsMGlwxJyrJ6pM66/eDSNIXMQtesgeqbx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCy0yB/jKI04yApXE/n6OXJGemM3HSH8a2K6AuxH1ts=;
 b=ZHauxgpwzav0OTygah0C+vvO5anU8J1qwCB25wXTELMCZevU2ReyIvAoXAHGiOkGO4f1oCVVqrYBhobkb16QdBE+73qkacKtGlMtWW/f1MNOjGcMJ5U2v/Ho/gHru388L18MHBTvMqYOQyHvrWsRM1glC9MRJqRuQkdOVDFoIHNeLsrTF4ywq/9nmeL629Z/+goo0rwQKw9Xx2rKUREuqxbFvxb8V3WCjUJp0A/cI+s11EC1sCw0nSUE/h9u2ALiXODyG1QJtNXIoCc/dxSQX92HIO/bYWXkZdqDyBp5SfMbc0TIgLXM3BUfdh+tEuvQEGV9CPxg9FTTmmiZD+DYOA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KUYPR06MB9111.apcprd06.prod.outlook.com (2603:1096:d10:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:01:13 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:01:13 +0000
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
Subject: RE: [PATCH v2 15/17] hw/misc/aspeed_hace: Enable the crypto command
 on the AST2700
Thread-Topic: [PATCH v2 15/17] hw/misc/aspeed_hace: Enable the crypto command
 on the AST2700
Thread-Index: AQHdFAq6tUctEPir4k2UmVrhvzuzrbaXA+Wg
Date: Mon, 10 Aug 2026 07:01:13 +0000
Message-ID: <SI6PR06MB763100A2E8DE4610CAAF2EFCF7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-16-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-16-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KUYPR06MB9111:EE_
x-ms-office365-filtering-correlation-id: 3c8010e9-c1c8-4a9f-134e-08def6ad2a4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|10067099003|38070700021|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: cJ1jUKX22eYJM5WSp36RYYfutfXBVatBABgpdvWKukHysHei8OZVAf6QDXvNOV8mg2XJCT0Pb3wQsCa0NHxMwalLAKIfLszHocKQALkYE9ci7W/8/LItUtBW+GztI1P+h2/P/+GhUNsktQnQf0g0eRdlusgSG1ejejbAnY9vlshYIBtMK/MjY4X4JWvO8vWuc8gxguwQhh8D98H9eWbwnhneJGyjI3KxcNYTUCKhMVzAvS9e+FJqF42nXruyGn35KeKqZktggdJMgVPEzpETtih42+yDp5bD2YD4Y4NqZTKTngO822DZso2oN3ZTFTioVV71IS4Sgd3rlKxecbBo39vVQOluV1Ysg5mUzQWbW5p+/QMvKJDUw8lmk7RFew3PRlIzq0uJcHDQtCGkwR4Llzod0Gqg6TVcxWpwCisoHIjMb/8Ajn+NACRP/7QHFICv5rfueil8H/CD/tvlb//Dh28vHpUxmnQ9Xc6WdnCSnfMBAKWCWevTB5dn5Bv4Xv1a0MK/Y9sAFLNFKvVbqhx3cavj+m3zizuYObHP20jNvwDaGuYKrRsSzfV6JmBXBTLYF88X0lX6oNvDo6DQPMOpbX+IScXmuP7toMNQ2gshJXpHkWGFAU/bIRigrJFsVx8ns52tNp7CScsEK8lUIR80g0LyiZXTcWLee2LKPzTU68ExUcouXdRhWKxXw8s32L0PnmjsMSezZzCovKMejTpQNRJlgT/+SjXCS5r6aWzh0h5tMf+9c6MK4VDEJVOidKk9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(10067099003)(38070700021)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ie/bmfKpvlNfNTPZEeqDKrcNU9Cdeh0/zIECVGDGEXAzMUT0IpB//XUDCj?=
 =?iso-8859-1?Q?PD3ZppIwhTxIjnIgsQT4eftAPG6l4VpjB2R9vpnGS8wlOjaQteqbMgYdjY?=
 =?iso-8859-1?Q?ORBYMzbJ0to6EMMzdK3waO8TuL7HXwWab9EXsPkii50nxJhcwra2o2sy+W?=
 =?iso-8859-1?Q?KEgRZG42UdISKhxONCjqGYcib4WS0w7qbBHCso2SvzfXbKwxRsMsfbbdIz?=
 =?iso-8859-1?Q?SQNwdfU2B09rJ8rtJijoLuIOTlCVqM2CaoSfo1bKQF21pSY3Gx8mg3eCRo?=
 =?iso-8859-1?Q?GWX2SQHdb4tBmLF5MjtHL824ESec9pd8qaJ2VK5lxj7Tv77HVrOP7fZWqP?=
 =?iso-8859-1?Q?gfvNZQt54aSwdu9eCU5nX68WKKIsqTaYcaQXDS7/aZv48DBYCACBQ3TI/R?=
 =?iso-8859-1?Q?H+A2M9CQcN3IqUNfG0MRbyklZJiGml9avtyoZH41O8UGJjYDTS1IdqCnZw?=
 =?iso-8859-1?Q?AoJYL2x5+PlksWRYcN3BxxU3eoBFO7pe1nMs3HBYoz8ifT6szACFb0b6pr?=
 =?iso-8859-1?Q?GBh1lGOk04vy4C4S+pA0b8ZoxhjYRE0/xakLovBU2wEIzgtQj3TWekxfyH?=
 =?iso-8859-1?Q?Fz+BpBaOJ4LpeUWekw+MLDTwld2Cegs9N303eXaZ7HHKdzfQ/OlmQGo7TR?=
 =?iso-8859-1?Q?wNayEqi255GLArZMThnBCdSb76tJASs0f+Mpt4/U56L5eceVws7ygYILR5?=
 =?iso-8859-1?Q?WJsLGsQz225Qs74iX9l87SjURA8OpHsB/+xpZGKpyt7zMw6Q7eaYRip8O5?=
 =?iso-8859-1?Q?gDJdLXyi9VTLL+Tj+Jtol2GSez9jcm2I74QfjPlSvLbH9gffLB/Xg6Pkrj?=
 =?iso-8859-1?Q?0WKwNiGXb7Czce+t7wwCdGyMTeEWwy2/KtRkbNVMoMpYffCVk8q9NP80BT?=
 =?iso-8859-1?Q?pyBXhqaSYDCM9yR/EJ3lhnSQQ82WemOv3o9HlN9D/6LX9oFulmNFL6nvq/?=
 =?iso-8859-1?Q?ysNd0jwLvU8Q5wskGRCwN0+k3mMHNkgzT+n9bCzSvP6SD12TUHk+Sa7H4u?=
 =?iso-8859-1?Q?gFYUWWLu/lu30CjhUcn8t8L1gB9nxndM2Yyjax2UVzdcmY2OhThi6hLjoM?=
 =?iso-8859-1?Q?1Y6XyHSwARewz71NC2/mVGofgI3a9w+7e7rgNkKYHQnAZK1d0ltjoa4ap4?=
 =?iso-8859-1?Q?3Ubl+vNdRo3Zq3qEqvdUIJTIkcZlvqiZ+xC9v61GSHDQ7/uas+nGNz4Uo5?=
 =?iso-8859-1?Q?TRmk611YxupKz+zZwBj9TD1D0sZZhWZ6feewtCY11x+o5AxTnBQ8LBuBtX?=
 =?iso-8859-1?Q?BIW0qDviQmBzkq2BMVRbZo88TeqdZRW6bQ8E2Krs/VqAF3Lix2pjxh2GN8?=
 =?iso-8859-1?Q?W/72KkknNJUB1+ejdKR2dfmxqCJfeFX7cut3WzwZKCkAn0HOzY8D/6Wwhc?=
 =?iso-8859-1?Q?tIa8mvW68byW/o5X9eDDNfc8K4PuM9yuiPYpEhSA4rA6FMeZylHmJReuWz?=
 =?iso-8859-1?Q?p+g+YaTBfFZeG3Y735iOBlrrb2g4MCnEgNfdowKOvWYXiVJAHiK/nFT9tt?=
 =?iso-8859-1?Q?nMtaM2owSw+RsLaRLMASPMlYN43HX8UTvwJhAxSTm4rYeGtKHETNaWtWTa?=
 =?iso-8859-1?Q?tpyX3HxOu/QfPMqXG4ux5XfGLzhoj8SU8cBKZjUj+HbLIvmPxuYFElad/U?=
 =?iso-8859-1?Q?3z9h1Aizi5pjE+RYbwtx0aLeniV7P9iYwr1OwaFtOI54KJ2GSUFdeZZ0R9?=
 =?iso-8859-1?Q?s+JmgrQJOJeY3cRJCairC/40HtS6Rc/PTaGH+BTZ9wrCGm5D+SlSLY4q7r?=
 =?iso-8859-1?Q?rl3kf54zipuaEdDkhbKHqzGihUBd5EPp+M01WQWELckfkjK8+QL4Zl4MFj?=
 =?iso-8859-1?Q?Jpd8nitobQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qAlnRHSiCjcOqOfh76mx/kh3TOM3aQ4cqq4lqOpMe7vjxJvEPmxCOEEn1ejbdPpDzJk/34MEh8n9ErxA3SZccSbmhbY2l70mAuSDwjHcXjQ6HlsfvM6ZMYihsdbe+PQOwTL48tG0IO0umwFJ1Jye79U9+e20fq0oSfElWGDheONZXHVDZiloC8RYwhgxrXquPbp7T4kr6ZwBr0FuFPp6AeSh0JLUoJEBV1QRzvQfUKThMK9nXtNwuLz8gKiX0t5dbpux2H7nvA41HJf29oCLB+q76ZTwKsRk6s7G/9EUsWDsrIFeilvvfkOO7r/1+56ZGb5R0X9NPVjxsodI9Rykaw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8010e9-c1c8-4a9f-134e-08def6ad2a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:01:13.2491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M67EQ+TSYimW9pZ38Jsbe8JoS+xbmNwolwm8ijotTORriWIBry4CEvLTznQyChp+gWHKP6Ho1Cuf23E0ZSAqVtjtLzC42nfBHtKsoF09lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9111
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
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

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Wednesday, July 15, 2026 11:34 AM
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
> Subject: [PATCH v2 15/17] hw/misc/aspeed_hace: Enable the crypto command
> on the AST2700
>=20
> With direct/scatter-gather access, 64-bit DMA and AES-GCM all in place, t=
he
> AST2700 crypto engine is now fully modelled. Drop its temporary
> interrupt-only workaround so the crypto command runs for real, like the o=
ther
> HACE variants.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  include/hw/misc/aspeed_hace.h |  1 -
>  hw/misc/aspeed_hace.c         | 15 +--------------
>  2 files changed, 1 insertion(+), 15 deletions(-)
>=20
> diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.=
h
> index b5416b0cb5..9b0e7683fa 100644
> --- a/include/hw/misc/aspeed_hace.h
> +++ b/include/hw/misc/aspeed_hace.h
> @@ -49,7 +49,6 @@ struct AspeedHACEClass {
>      uint32_t key_mask;
>      uint32_t hash_mask;
>      uint64_t nr_regs;
> -    bool raise_crypt_interrupt_workaround;
>      uint32_t src_hi_mask;
>      uint32_t dest_hi_mask;
>      uint32_t key_hi_mask;
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> 927759b48f..90d43c0676 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -1005,14 +1005,7 @@ static void aspeed_hace_write(void *opaque,
> hwaddr addr, uint64_t data,
>          break;
>      }
>      case R_CRYPT_CMD:
> -        /*
> -         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM,
> which are
> -         * added later; until then it keeps the temporary workaround of
> only
> -         * raising the completion interrupt without running the command.
> -         */
> -        if (!ahc->raise_crypt_interrupt_workaround) {
> -            do_crypt_operation(s, data);
> -        }
> +        do_crypt_operation(s, data);
>=20
>          /* Hardware raises the crypt interrupt once the command finishes=
.
> */
>          s->regs[R_STATUS] |=3D CRYPT_IRQ; @@ -1216,12 +1209,6 @@ static
> void aspeed_ast2700_hace_class_init(ObjectClass *klass, const void *data)
>      ahc->dest_hi_mask =3D 0x00000003;
>      ahc->key_hi_mask =3D 0x00000003;
>=20
> -    /*
> -     * Currently, it does not support the CRYPT command. Instead, it onl=
y
> -     * sends an interrupt to notify the firmware that the crypt command
> -     * has completed. It is a temporary workaround.
> -     */
> -    ahc->raise_crypt_interrupt_workaround =3D true;
>      ahc->has_dma64 =3D true;
>  }
>=20
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

