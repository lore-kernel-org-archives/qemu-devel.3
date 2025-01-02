Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16DEE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 02:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTB4Z-0007sM-VS; Wed, 01 Jan 2025 21:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tTB4Y-0007rs-1F; Wed, 01 Jan 2025 21:36:30 -0500
Received: from mail-psaapc01on20718.outbound.protection.outlook.com
 ([2a01:111:f403:200e::718]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tTB4W-0001S2-ID; Wed, 01 Jan 2025 21:36:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEM+JKRFQq+16T4Ednic7GBNOn89R/fFLqaTB6GsrkezHumUd3x4bSPMihqN0dFFnJMP7sNtl37Kie+JDE/xf7ZeL3BSfbPOBeAFPSNQnQR45rlkd1sk98gDgfwsYkglfT/fb0JnOu2XpY0CKyHsU0prlO2Eq+T99d1vboODXNah6eIbuh/bwbMJHp3tD1KU5MF4+j8+69CuCg0aXzP5NW40Acmy2qinDuGmnMCIamSXPGI0VSi+pRnwBcrTRWYRJRYPwNMXTq16OTW5LFxAFezczRbin1jF2xlOl8H0ttodk8mWsVg481NfND9A3Rvl2cgWrt+AqnNpsUo2Otf8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+pBxC8yrueBzunRR3wYPRKImqaya0FqPY3yvvgJMP0=;
 b=mM9pAZuVq12QhDaAMlvkE+fJhDVxGcTqREo6cXczuN4bExQ0pwmAxB1oKmS4RvvdC6Ede8Tx0aFbgbXYMi7cMKvunXz7xySHl/osEW5+WhWIhfIZaZ/nbvYWXYOG/8oBeITxbBXsS/io/6Q4pSNVKUPHtCivTTgfSJQ3phtU5n90DnQVlkTmYuWeyRi/ij90Iao5A87aTH1bYvWHEaXlQAa89VNMUxFx79kghiiIUa5HC92O8FdlPQ9jKnd/6NY0C3YIQ6/1ntzceby2AkHuRZ9xs8X7lWcJxbWQ+RMz5tVdUI/O20wT+uAMxrY80BV+QRTBFVp0znEmAoj9SImPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+pBxC8yrueBzunRR3wYPRKImqaya0FqPY3yvvgJMP0=;
 b=HjSzESAvP6q6fP6vEVP9H70/iPZXCIUijL1VAlCtxXebNsNMUkBQnGGbgehoJrx+1m2soAgWg1xVzU1xg8aCh7MBQo340z1JMbuo5+PElG3Ppw7mqreeI3UVO595qrCeOQqg0anDsnnQpv7N7oeFwnwNhjiTGnz+L3j7pW8kHpzgPbS8j+Nc9WZ06CC3JvZ8qlpseG7Ga7EH4ozN7hMP4qhDDLtviq2qzxHt/wF2VOF1ogStEIsOlbiK/1oZMoFjAC2vV69AIG9tlG516PX6B8v4DNZO/69obEeKMD6QBkUUSCo1By+kao3/SbV4ntCCHCB3gwJWXRDRsGE4qvDV7w==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB7210.apcprd06.prod.outlook.com (2603:1096:990:8d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.15; Thu, 2 Jan 2025 02:36:15 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 02:36:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 0/2] sd:sdhci Fix data transfer did not complete
Thread-Topic: [PATCH v2 0/2] sd:sdhci Fix data transfer did not complete
Thread-Index: AQHbTQzNHBtYJPQqZUOPbKsoauUuirMC41QA
Date: Thu, 2 Jan 2025 02:36:15 +0000
Message-ID: <SI2PR06MB5041BF7E310E4C379823330CFC142@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241213031205.641009-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20241213031205.641009-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB7210:EE_
x-ms-office365-filtering-correlation-id: dc42dc02-206d-4810-8622-08dd2ad63add
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LnYxti3pNJth0iW1De1tmpFgVuDYJWbA8wJOyBt/BrC9VUjQQL1el7gSaX?=
 =?iso-8859-1?Q?CEzmJf3BwiBaB8zbwKy9CL7SPGZYrN3VacGwico+SH+d6vDd5Uva812l4o?=
 =?iso-8859-1?Q?mzAkaxdDmYzbZxeMaZka8hELipqxYGDkLTAt0XFI2YeDFw15e0S9tQ7Qvt?=
 =?iso-8859-1?Q?AfATgxFWkK9tvM3Mc6HSXNaEqa0Sw2MQ35yVfobVvy9RNkGksTYZq9gk2q?=
 =?iso-8859-1?Q?djM/h0n0ygm8CGxn0xE6vdR8gH3yEb3a1xjlXpeHfLHf8vbx5ciU+BkKY6?=
 =?iso-8859-1?Q?JaSyINLXPoEHKXYzu80ZokoP+5xz2YcI0JYGYAwHX5eMysPE3Khah4Kf/h?=
 =?iso-8859-1?Q?+Iq9w7xEt5A9BX3fxUinh9sXBbxxhV35wvMhmSBJxm91xOulwhMVlLrWl7?=
 =?iso-8859-1?Q?LIJJ32r7itMl8uCIHakRQaDr8wNfF8TCmHthPR79LCkJkGddNQFd981qKN?=
 =?iso-8859-1?Q?MCE21AH2rHwYndTIpEm8zNZF8UtTiO9I/plliS3xEQoiBCS3i7SegpGdyh?=
 =?iso-8859-1?Q?BTGp2glpoHpdj8FNxYq8TDs1sOjNNJIlsXtTqQu0wuNq1oo/558w7NmKnP?=
 =?iso-8859-1?Q?pZD/V7V5S8CdvB4TkutiFR50DdpA63KyrH06B08Ox8FCC691lq5LiSjNbT?=
 =?iso-8859-1?Q?O+Yk8Lc+NrOaQuBwMz2pv9Ic60r5rXso73VyPsi+tcFuVYhRA7PF+l2UpF?=
 =?iso-8859-1?Q?1m/5MOfas1FtjVkLplGhi1VR0Qwfjwhwde4xZ5Hz1ESF98wti5Nwfc1qay?=
 =?iso-8859-1?Q?AUGOlsWn7Af6alzgDKVfRl3m6M4Yql9El8dnPj9rGn7hoKOY89pAoaRo8A?=
 =?iso-8859-1?Q?tPiYXANWbkbkQgB1aiqLkSKC8v6T3O1nPOME4FFp5/WaTpiz0QvGpbn1rC?=
 =?iso-8859-1?Q?Od4wt7C+gCzd97xsw7r0f7rL5Ve5N05ITlKInEGMebCe6cujmxODBRWy9w?=
 =?iso-8859-1?Q?71jJcAcgNOfVwaUvlkIdjBLnxYkl1T7QoBM/cUkna4X/x2tZKoxG1RnTQ6?=
 =?iso-8859-1?Q?ttuC2WL1OZ18zFMu4vvyqFsMsQhnKGS3dODuTyVRYAfZV3A28khixtrt6f?=
 =?iso-8859-1?Q?/sqUdOOHlejettnzwWuCIdcZDunQ+cHyia5RMGwlsiDm6IMlQoRtAVF1L0?=
 =?iso-8859-1?Q?V22HPRA74iV6OTRq5OnHHh8+iVilLHihimlAVxVqQAf6yp8Gx3hWMyoGxw?=
 =?iso-8859-1?Q?ncOt7aj/3gTWonz1GhutVjTLdSrEEX0N+09W5qhrtxe8pJESJKMyE1czgL?=
 =?iso-8859-1?Q?NVOOIOHimHsyOnlvMxU1jGrderPEVg+bmGVrTZNwgasyxQ2knlpA0D2QmC?=
 =?iso-8859-1?Q?g/QF3yVuPrF9tXRE7x+jp0mcfw7IgZa/jRubF9zEXwu7JhNV0bvEAFtpAa?=
 =?iso-8859-1?Q?RRcsEQ6AkepMQpEY1DmGaRh+HZwWc1djjQ/Y8R3V4R1GhBUq3BoAczEoED?=
 =?iso-8859-1?Q?yWwIzFFkHgqcZiAewMMoOCN5nkzfYQBC47fKPUd7b8+tAFw5Pr8myn4A4S?=
 =?iso-8859-1?Q?Ya8YvIptHbeZwJ0lvan7Sc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m8x84U+MKJH0GWw2fX0ysYiuqoXVgZGqbLeBDMbOvezW4shteZVKHSoOCA?=
 =?iso-8859-1?Q?7/Wf55QE7LSN8Hq4yuUQI65S3eDAzj2efM9aqaaCbD1rW/kK4oB1kX4GJ0?=
 =?iso-8859-1?Q?rjJO0mjdsQuwRP1wIhsKLHs7J40DA9bRn+m6TS+QCBknegfZXNpuo5A9hb?=
 =?iso-8859-1?Q?1ZG2UVf1Nu8RRPeeqJEXjL0DdEhDofMqor5qeFa+pb+0yHmFM2SZv1Sgm8?=
 =?iso-8859-1?Q?nFEqruzDsIAgNgyWijElRlYRwRhlfupdlt5QhlqthSKKc1s9V97b6Itf7v?=
 =?iso-8859-1?Q?EI5k2Hgl+RRkDx3JtN4yBljIHxt+0XVcgnRm6GJsqBDUeZ5ElLcLk7gfXs?=
 =?iso-8859-1?Q?wwcZaBZMXGuRKSnT/A1KmuLzke9xJFtGcUlfr70Qb+b+9y78H+e32uuyEr?=
 =?iso-8859-1?Q?qT/qM8oJS+X4pcnsfAGYJGjwnZBSu8VHJJRfOPlcM6lWhEhfcU6NpkraQ+?=
 =?iso-8859-1?Q?AbsNzcLI1wQDyxRqcKpYgBxbZMI8vA+jzqlEqD2EHEaLadQJVnipiIKUKO?=
 =?iso-8859-1?Q?VvdyK+8+i56DoKM5DfjgOIIQRrformerHij2x+RsXZUiI2j8vy0EOCY61G?=
 =?iso-8859-1?Q?C4VfKIU8J5ToMrA3oV7p61LIrJwMS5t7yDeP9F3jm0THMd5qj11j/BXm7j?=
 =?iso-8859-1?Q?APcV8AF22CfHI+FTLNQyzGfJBNM74P63BDH7J7CRZvQTllgzQ0hOKUMlME?=
 =?iso-8859-1?Q?V1ee2QxwzAXu9Y2rW6Z2rSSE8r8IP/V4VFsJMaGM3hrW29zBVJoIMeF41l?=
 =?iso-8859-1?Q?EEYlZqUF4F5qeZb73koP7Nk2uSqVpoGtl4+hknV/gMKFys/heH+4rRh+Wo?=
 =?iso-8859-1?Q?0xavh8OJ6TP0m3glAEMtNyQ9yb6rpEAfkj4q35mLYGa0ixkAmUkp+wKpDH?=
 =?iso-8859-1?Q?P7z/yhSzyQ2h/TbqxACwJ6d4NnHZirhz37X8zpalmieJxKa362Os9DPiyO?=
 =?iso-8859-1?Q?e5li9q52SRTGjfuC4AwouTFmsgFosqVYPMW+B3vbM6XAGmSArjEcZl8H72?=
 =?iso-8859-1?Q?rROMySol0+/1xFmHytZsvc0f3bqoKI5vGEyV9/Ub9hOlDzqcXFhdOYSz7E?=
 =?iso-8859-1?Q?OM5jwH0l98hZfV+QdXn01BuLBaioqge6VDBogp5XT4KMv6EvrOLRnkj1e2?=
 =?iso-8859-1?Q?bTNVJM1ofV+x165jsVwhifSxCWVcoAYYO4d368B1TL1MDlH7+VTtFWCnW2?=
 =?iso-8859-1?Q?FWzE84pG42mhVYtVKJjVcm4zUeFSzbhHVC0LfgXAAzXgxs43NAaInoFh1N?=
 =?iso-8859-1?Q?X1+lvHHCEqJqJcOzIimqBZamjVoGWYdBOAQHAdABR4t/VuFEUn5j0FjORm?=
 =?iso-8859-1?Q?9wgK89t0WQmIPsUE2I7Wd5nQq7oAbpPYW81idsR9q65UdCpbc7xwG/Q0GA?=
 =?iso-8859-1?Q?wC2vHhHV7Wka/bd0sGAy8u9JrB1M5SKQLd2EBkSNaYYcgzq/DzjmqMUGt4?=
 =?iso-8859-1?Q?l1xb1K74oZ8+IC3U05UtEBWmAkMHLtfWGgQS6iQaHhK963pgI4U6TFhps8?=
 =?iso-8859-1?Q?ai5r2/SFu8inGgJmqD2RfB8plxnOIzVxeA6H7Hjt7gxbXgWqmdfWRfli2B?=
 =?iso-8859-1?Q?cztPxxt+MY3vpt45jk7JouE+JY+Y9agF3pVWKX7ECPLRd4RbmxLn6jEo5H?=
 =?iso-8859-1?Q?7/Sn2FBAWPelltmKLMKAE2bNPABOi5t2Uv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc42dc02-206d-4810-8622-08dd2ad63add
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 02:36:15.4997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzATNgVDR/5Iw45bVP9PtRDaRtXSeWm88PkZnnLWBsef9yhh7J/69Y/0JRsQII3DZzE+LBuYIzpKjaEvCr/9auhLYpSBxGfAbRDMTPKKuew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7210
Received-SPF: pass client-ip=2a01:111:f403:200e::718;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Friday, December 13, 2024 11:12 AM
> To: Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Bin Meng
> <bmeng.cn@gmail.com>; open list:SD (Secure Card)
> <qemu-block@nongnu.org>; open list:All patches CC here
> <qemu-devel@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> <troy_lee@aspeedtech.com>; Yunlin Tang <yunlin.tang@aspeedtech.com>
> Subject: [PATCH v2 0/2] sd:sdhci Fix data transfer did not complete
>=20
> v1:
> 1. Fix boundary_count overflow
> 2. Fix data transfer did not complete if data size is bigger then SDMA Bu=
ffer
> Boundary
>=20
> v2:
> 1. fix typo
> 2. update to none RFC patch
> 3. check the most upper byte of SDMA System Address Register (0x00) is
> written,
>    then restarts SDMA data transfer.
>=20
> Jamin Lin (2):
>   hw/sd/sdhci: Fix boundary_count overflow in
>     sdhci_sdma_transfer_multi_blocks
>   hw/sd/sdhci: Fix data transfer did not complete if data size is bigger
>     than SDMA Buffer Boundary
>=20
>  hw/sd/sdhci.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20

Hi Philippe, SDHCI Maintainer,

Happy New Year 2025!

Sorry to bother you.
If you have time, could you please help review this patch series?

Thanks,
Jamin

> --
> 2.34.1


