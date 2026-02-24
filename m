Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32CEEFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLX-0002MY-8r; Tue, 24 Feb 2026 01:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLK-0002Go-8O; Tue, 24 Feb 2026 01:56:28 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLF-0005Lc-Ig; Tue, 24 Feb 2026 01:56:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqhrffxjiXwT+TdQCcS6rA3RZr+slHP21/SFYHroumnEAcm2HiimdXJnNjDUVP9SXTO+WWqacnTPYP5TkO5srDQu523zpm1Ep7fnjQBxTk4Bkcurhx6pKH68UoMM/akt6gf4Df0QcS5z9PSRSnvcrfRhhEK8ayk4Oj3ua7L23ceRp05J2/Rcub1k4AUBc/iicK5+of8gFMzwWqVpMElyXDNaWpG5WdKr+UEBvtGOuztZqYz40UX/xra+pyZylOV8mysYQAOR2Ni6DGobzWR5kOy2g8SFxJom4uT/CzvC+SKbSsm8e8ldJCZDQe+KqGjvrYWlEkwNBzwAM9rugxmY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiXK2jDGUMyj7USYWr3IJDc8SbJLmQJDnVS1bMUg0kw=;
 b=gGmeGvuvTAdbO6OXWTizMdZFtEpPKkMVr5d/rcA4DrTLjmGilkPDkFpfCfZOLiLrptz9Ru877IOSuXiJugb1I61PBF0fIgORgQIpoQeMypD81IJsvatNFQgFrP3ietdxc0VIGLuQ8axrQbI51xNKTMI0tR93N72NJWAvpGmt5zharhKMdpesg4xhTVBqlqiM9FK9B8e2K9kiGBWyBELpuQo/W59kGaVth4U+o97t0YUj+BVoJ5GrDcY3xvKxFkVduKMRhdlW+4/4kxnYBD7DFzS8IoKXW82wBoTyFpvB8rUZGzWqQPRqnzvZ4o3M8EH1eRQ0QB/51PMImZb5TG3pcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiXK2jDGUMyj7USYWr3IJDc8SbJLmQJDnVS1bMUg0kw=;
 b=oXxkbcWbpRHmZJ9cKlbMZOMSQpC4Yw2THSHc/vt7VAPWrSA11x7J4yLKBf9mWbbgrHk8QzZIncnDEm/lWP+mO9Ei1clXuAOmn5S+/pD3Iov7h8qaZPVeJlac3y6sIuMV1ZDxtlwKNMs8kBHnpc0KSC8ledHMnfB+Dw2WP3piKCjhVc4wB7XDJK8P0iHFsQRaxQJZOvF0+RSPCMWAA7ppsBIXMPvRYaBGwKMnML/xbr/nDUcKULN3WkZACjD4RGBMV+rLieW4nliHxXCfouyPhXToaywJe/1xyPL/5o39tg3yiD83TnPdh5x/Bj8EuCzikCa8sOXAyS845AGofmQlZA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:03 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 03/15] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
Thread-Topic: [PATCH v3 03/15] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHcpVqjQ1MALzMt4kqPeEPEWp2gVA==
Date: Tue, 24 Feb 2026 06:56:01 +0000
Message-ID: <20260224065556.3847942-4-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: af22d2b0-9229-4b54-dbe1-08de7371c6a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hvEgolYH82JBOvdt8a7mQW72fEd95zMAWdl9Pe7y9X02oqLSwC2jDK2YEp?=
 =?iso-8859-1?Q?j9085hXCKWG0OEOgNnhDDUNfsj45VGZ4T5Md1oeLhQfxFX7lv+tIiZK0f4?=
 =?iso-8859-1?Q?3j7+aV2Jxqe+pY8F/Bkh1ZGD/j8yx+GX3Xb7Pc4Ez4R49h0In3f6npiv7D?=
 =?iso-8859-1?Q?YHMejuRY0CV7AMrv/EfFLVKv3vAqx2MUxpu4+kONpWtMUP7dGB9KRW6jas?=
 =?iso-8859-1?Q?jnxWTDbiLs9/DNiLE7xMLaX3RXCEPYH2nMx6bRyR8zLLQ3NSyKIU7BhhvO?=
 =?iso-8859-1?Q?4fIR6sDQp6ZXBW+0eC7aXONUxeQ0SDKk8YCSQpB9r6pugqHlv1RScUfmON?=
 =?iso-8859-1?Q?0XhCQsnNHw5Yfry5+tSSBtwY59Bm4M+qBepqVY9gkwEN/b0B8u1ISqrnbh?=
 =?iso-8859-1?Q?VXr4AA/W429dJ2b4ZpOLjye28WpOeFQohV+p3Yj1Df80n84JvW/5O82l9l?=
 =?iso-8859-1?Q?VAXxC+YyXwhgdyI84bQbpxAH+g59rFVTqISjVK/3S4oUMzcaInw+dJRHKl?=
 =?iso-8859-1?Q?Z4kN8KBLper3mln5ktZ3eqMsehFYAz/ZFKs9M0vgJQf0CcMnnOd0h5Exf2?=
 =?iso-8859-1?Q?JbozwGGZizT9hi9ktS6cgODZNJ96xtl+pEOj59erbVaqECTJvzzFa6/u+e?=
 =?iso-8859-1?Q?MK674nNTAUnWWKKT3qm2NuPgvHOzvubqjXddXam7RTtyIESuWrR2RUDRZH?=
 =?iso-8859-1?Q?BlMX8UD/C/rNyV/wcm7vLOOw8vXyL8RUA+M7KOgYU1YJtU30FcuHC2RRDu?=
 =?iso-8859-1?Q?6lso5hV7Y2VqldzfnU9u9N65DT8UAAU6BnTB/5ztmVF9ku232mvh498nz1?=
 =?iso-8859-1?Q?0XNwZXwZEVLIOLy1wbvGConxh9G6AoL4rLbE2Bxhi7WtgS3fJx8sjj9CY5?=
 =?iso-8859-1?Q?1a9tIOgAr0hFMNL/j7AtRB+08Tl7tITdFJQrpkz+bLF9buWLG2YRqwsXR0?=
 =?iso-8859-1?Q?EgrhITQxtAQLjT2QwGS2N8AFZf6qeOlNl1kHnledpUOESgrh+sN5TqlvTx?=
 =?iso-8859-1?Q?RmTbP3lh2N+26BKbh1SQMc/v9ughyuTtMhBJ3RyDLPf0cE3vp06IhrpN2D?=
 =?iso-8859-1?Q?OeT8L/Slmz0j9F+75g4SRPpRNOgNGTjv+IpeOjc9nV/mmrZiyw8b0Oo9Dm?=
 =?iso-8859-1?Q?c0lWTmccHsQ2s5De30JPtqoaNfavJXGsbqD/ZK7QV388OK3EJSZ3Xz9Eim?=
 =?iso-8859-1?Q?x++bpHumua5GOq+d/wylZOnbuZf/JqFpqnTq6s7/jgTHiCwMvd/zzqCdt7?=
 =?iso-8859-1?Q?AxGlfAxrBwHKJN9bQwRYZY9BhzzpJM3nAyVPLq80pz503ut5QSyX20g1HB?=
 =?iso-8859-1?Q?yPMyWbLdwMciBtOD44Y3XXrKNAb0Maus3gjntHuMVJRqml++xMTDGkcyor?=
 =?iso-8859-1?Q?PSY/nbEHxuRmyIKc7Tx3sPPobEtxTZ48ETOy5WRB7/h0UnOP+xv/Db2+Kt?=
 =?iso-8859-1?Q?kAMXljvc5QKewA6vJr1d+YCLwtyUPQmghqc8jPm1HI0KYK5mwfk7B2taN3?=
 =?iso-8859-1?Q?KQl1O6UY1BzoA6kNhpQ5Dbv1tlOgF8M8DqQN3Lu/npgYiMzaL1fgBufdN7?=
 =?iso-8859-1?Q?sVdA/HKnfh3GE4fG5LcpC3szt4WVEKIrRs00JTL/2agmvXBZWAcD9xs/QG?=
 =?iso-8859-1?Q?9X12s3qbIM3IXA3QlHcniSUjyFZTZVvgqYNSiMq6vMdTogyYG9Ej52RW05?=
 =?iso-8859-1?Q?SHeRbnyEKemS0OqQnYYtMVj04V2GAlG7Ny64WYZf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XtguUZu0klkstHymflMCsAuNbcoDm4x27Y6IR6iWkDO91le/gs5fB7DFqh?=
 =?iso-8859-1?Q?8jicPdYdUet8JTpl/vJ6OsFVaUktVITn6ncqkSF5lpMRdxp1NARTtb+wRi?=
 =?iso-8859-1?Q?453jRPNErUkM5mHbP+JGmW6y0MdCdgLwrqXlSrB0c0QVI+o1LWFwldi+sW?=
 =?iso-8859-1?Q?Hdw9K/0IkdTJDoGRSFYh5nADp7yFOL9jffK+eHZZX8cVTNt0vpsyve8V15?=
 =?iso-8859-1?Q?DZ4hD/s4us/VTSqig0iFDT4QqHS8bbhkZ5XzvKBueZp+qj3hmscM/nB9q7?=
 =?iso-8859-1?Q?44rwZ2yWQT+gXu8YCnVevNzu9lYYTKpy4PVqCKlHzyPTRr7pYhRNQelI+n?=
 =?iso-8859-1?Q?KZcAeYPaQvp5Eqw2lPmBZ0fbiI/UEIy/oe0JKYhLa0SrLl47BjfwoNwO9y?=
 =?iso-8859-1?Q?E7dEzHKUMcq2Mm/odcjjMfbPy/71TM2Tw8izV7YLYXdG+CUCG4eHiX4sGE?=
 =?iso-8859-1?Q?ccSZefYYrRkvm4Fk5GzdtxG5GNutwU5b7PavL2MZwGlt4BDDtXlUqp4DkM?=
 =?iso-8859-1?Q?CAcfKf27DkfJlBH0xzBKNtyetEpc/W83+zn/WuicqbEc5Q0i4IzvG6ivhn?=
 =?iso-8859-1?Q?NdeTnuGVIahyQPj9oNCqUA+RP1tH7Qz2gLaxA660zAfcBeZceTicaSjS/E?=
 =?iso-8859-1?Q?SnkqKWnUcGX0pFyhU57frnVy2kzFbfeqpOn+l5HFND4fJCHmPaOyVLeslr?=
 =?iso-8859-1?Q?A61p6kPHOfdNbsRNW/PxME9kIkzkXweTRpkoYugQd1RGJvuEOndFlLVQGp?=
 =?iso-8859-1?Q?vLLsHgvTuIvivKUyRPMXJR14dXgNtfCaovO3EuDQI/wdHVdnfKTiI3TZSF?=
 =?iso-8859-1?Q?bdaPnX96enFsjA5W/7PrLanoteEYjQeNt3/ly9PyYqfCtBmZs6mLqSTyay?=
 =?iso-8859-1?Q?uLbtZd+mOA1bJIhLtFd1CAFidmZuaBp8lCxWkVEEp1wBKQvQiC4+s8/c5r?=
 =?iso-8859-1?Q?dY1xNjnEQP3G5LbfE9TdfpO3saIwHAbhOz8Th8NF+L0j/3QpMmdAqLaxZI?=
 =?iso-8859-1?Q?eMVui5sKcR20Dz+4G9zHLNXGx8mUyAw9FtAJPQz1nkpux8A/xxUCiavXZ7?=
 =?iso-8859-1?Q?pM/LaLZMn2n/HczyzVovMIRo+0aLo9WH+a3fjjUKjQTF+CgG0PhnMdF2xP?=
 =?iso-8859-1?Q?nAGrP93fx9q9sgDrIWzymmVm4EANIAQCH7v1GmiBGi5m7m3R3EYx+KHlkK?=
 =?iso-8859-1?Q?MPEuJcOLmQjsZJdRbr91hA782qAOgcMcd11OljvfaLOJPEOOaEZdGEEHqx?=
 =?iso-8859-1?Q?bM/nj8hfPEWc0l/6bYIqWrvalX4YqGMlAaWLcKPRO/MW/gWSlyBx0hiG0y?=
 =?iso-8859-1?Q?6TW/dI5rYenPj7nCZyd016xYT5TpSVk5lHkdjjjRtvs6PfZnmnkCvq7f9V?=
 =?iso-8859-1?Q?rdX5MxkNiOKloQ+DWFORE+oZkTH5Yde6mv7T4IaGLV+QEtUNFpi1ZrDH29?=
 =?iso-8859-1?Q?UHYlmk00Ndt9KyA8pVlXHEyo7eZlyY5f7j/Y+Xov8QtMC/WSb71gis9ZKE?=
 =?iso-8859-1?Q?awnar640mGEhl/PBXDLMoao1BaWnEzZBhO18M5qaeaqc0Pgh+TpWmrU3So?=
 =?iso-8859-1?Q?+eBvFUpF8p+4iqOgYwOD4OLvVhDiakNh7pYdVuIca7fGWP2zzaVtOi2EF9?=
 =?iso-8859-1?Q?wkCc6+bWuTMsVIMgxJrFVM7QolpO8yAHqFrW+KvnBO6SoFOp1Ulri0pTvs?=
 =?iso-8859-1?Q?1rZ05/zXicchECPNYQWkC2dQWW5L32ZkMEnbhKopkwfau6y9B4rZp8DPry?=
 =?iso-8859-1?Q?heePcjjbvkgd7oMbpoS84jXfQydr8Y+819vksKRM+uoNLDeVxzqlbWYhyS?=
 =?iso-8859-1?Q?kGUsQRBj4A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af22d2b0-9229-4b54-dbe1-08de7371c6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:01.5190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YknuhLGFlJ4KbIxjYlhMEGh4VRvRdBmhe4+LPLyeCU2d68wvwLNCU5pphxLG/3e68eZplwISCwaY3zlp6zIJQ1I7m+xLoPoBMYme1Mie1t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
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

This commit adds two MemoryRegion aliases to support PSP access to=0A=
SSP SDRAM through shared memory remapping, as defined by the default SCU=0A=
configuration.=0A=
=0A=
The SSP exposes two DRAM aliases:=0A=
  - remap1 maps PSP DRAM at 0x400000000 (32MB) to SSP SDRAM offset 0x200000=
0=0A=
  - remap2 maps PSP DRAM at 0x42c000000 (32MB) to SSP SDRAM offset 0x0=0A=
=0A=
These regions correspond to the default SCU register values, which control=
=0A=
the mapping between PSP and coprocessor memory windows.=0A=
=0A=
Set SSP CPUID 4 and bumps the SCU VMState version to 3.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  5 +++++=0A=
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c  |  6 ++++++=0A=
 hw/arm/aspeed_ast27x0.c      |  4 ++++=0A=
 hw/misc/aspeed_scu.c         | 42 ++++++++++++++++++++++++++++++++++--=0A=
 5 files changed, 57 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index d003955428..9c29ca217d 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -39,6 +39,10 @@ struct AspeedSCUState {=0A=
     uint32_t hw_strap1;=0A=
     uint32_t hw_strap2;=0A=
     uint32_t hw_prot_key;=0A=
+=0A=
+    MemoryRegion dram_remap_alias[3];=0A=
+    MemoryRegion *dram;=0A=
+    int ssp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
@@ -64,6 +68,7 @@ struct AspeedSCUClass {=0A=
     uint32_t nr_regs;=0A=
     bool clkin_25Mhz;=0A=
     const MemoryRegionOps *ops;=0A=
+    void (*dram_remap)(AspeedSCUState *s, Error **errp);=0A=
 };=0A=
 =0A=
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 5eb6680da9..77ce312591 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -100,6 +100,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
Error **errp)=0A=
                             sc->uarts_num, serial_hd(1));=0A=
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,=
=0A=
                             sc->uarts_num, serial_hd(2));=0A=
+    object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,=0A=
+                            &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 437fff3311..4a9c8c1406 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -198,6 +198,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &s->scu_alias);=0A=
 =0A=
+    /* SDRAM remap alias used by PSP to access SSP SDRAM */=0A=
+    memory_region_add_subregion(&s->sdram, 0, &s->scu->dram_remap_alias[1]=
);=0A=
+    memory_region_add_subregion(&s->sdram,=0A=
+            memory_region_size(&s->scu->dram_remap_alias[1]),=0A=
+            &s->scu->dram_remap_alias[0]);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..b914c01825 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -432,6 +432,8 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                               "hw-strap1");=0A=
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),=0A=
                               "hw-prot-key");=0A=
+    object_property_add_alias(obj, "ssp-cpuid", OBJECT(&s->scu),=0A=
+                              "ssp-cpuid");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
@@ -794,6 +796,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vboot=
rom);=0A=
 =0A=
     /* SCU */=0A=
+    object_property_set_link(OBJECT(&s->scu), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
         return;=0A=
     }=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index e4160356e4..84fe88e58b 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -20,6 +20,7 @@=0A=
 #include "qemu/guest-random.h"=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
+#include "qemu/units.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
 =0A=
@@ -593,12 +594,16 @@ static void aspeed_scu_realize(DeviceState *dev, Erro=
r **errp)=0A=
                           TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);=0A=
 =0A=
     sysbus_init_mmio(sbd, &s->iomem);=0A=
+=0A=
+    if (asc->dram_remap) {=0A=
+        asc->dram_remap(s, errp);=0A=
+    }=0A=
 }=0A=
 =0A=
 static const VMStateDescription vmstate_aspeed_scu =3D {=0A=
     .name =3D "aspeed.scu",=0A=
-    .version_id =3D 2,=0A=
-    .minimum_version_id =3D 2,=0A=
+    .version_id =3D 3,=0A=
+    .minimum_version_id =3D 3,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_AST2600_SCU_NR_R=
EGS),=0A=
         VMSTATE_END_OF_LIST()=0A=
@@ -610,6 +615,9 @@ static const Property aspeed_scu_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),=0A=
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),=0A=
     DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),=0A=
+    DEFINE_PROP_INT32("ssp-cpuid", AspeedSCUState, ssp_cpuid, -1),=0A=
+    DEFINE_PROP_LINK("dram", AspeedSCUState, dram, TYPE_MEMORY_REGION,=0A=
+                     MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_scu_class_init(ObjectClass *klass, const void *data)=0A=
@@ -863,6 +871,35 @@ static const TypeInfo aspeed_2600_scu_info =3D {=0A=
     .class_init =3D aspeed_2600_scu_class_init,=0A=
 };=0A=
 =0A=
+static void aspeed_2700_scu_dram_remap_alias_init(AspeedSCUState *s,=0A=
+                                                  Error **errp)=0A=
+{=0A=
+    if (s->ssp_cpuid > 0) {=0A=
+        if (!s->dram) {=0A=
+            error_setg(errp, TYPE_ASPEED_2700_SCU ": 'dram' link not set")=
;=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    if (s->ssp_cpuid > 0) {=0A=
+        /*=0A=
+         * The SSP coprocessor uses two memory aliases (remap1 and remap2)=
=0A=
+         * to access shared memory regions in the PSP DRAM:=0A=
+         *=0A=
+         * - remap1 maps PSP DRAM at 0x400000000 (size: 32MB) to SSP SDRAM=
=0A=
+         *   offset 0x2000000=0A=
+         * - remap2 maps PSP DRAM at 0x42c000000 (size: 32MB) to SSP SDRAM=
=0A=
+         *   offset 0x0=0A=
+         */=0A=
+        memory_region_init_alias(&s->dram_remap_alias[0], OBJECT(s),=0A=
+                                 "ssp.dram.remap1", s->dram,=0A=
+                                 0, 32 * MiB);=0A=
+        memory_region_init_alias(&s->dram_remap_alias[1], OBJECT(s),=0A=
+                                 "ssp.dram.remap2", s->dram,=0A=
+                                 0x2c000000, 32 * MiB);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
@@ -973,6 +1010,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     asc->nr_regs =3D ASPEED_AST2700_SCU_NR_REGS;=0A=
     asc->clkin_25Mhz =3D true;=0A=
     asc->ops =3D &aspeed_ast2700_scu_ops;=0A=
+    asc->dram_remap =3D aspeed_2700_scu_dram_remap_alias_init;=0A=
 }=0A=
 =0A=
 static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,=0A=
-- =0A=
2.43.0=0A=

