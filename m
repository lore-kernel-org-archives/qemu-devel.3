Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB98EA3F03
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1V-0003Dw-4n; Tue, 10 Feb 2026 00:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1F-00035Z-HA; Tue, 10 Feb 2026 00:10:39 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg16-0000Hj-57; Tue, 10 Feb 2026 00:10:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZPPeulH0H/Kvw3v3V46eACG9Q8a5DbrAXTUUoBgMUKpGMJ8d0JpFDS4fBV9sYEce0mCWPUR9zxVEOL7rY3rL4zI7ebFBNVY4faalq+nVspwNR0i/Bu3lrZmraRUiIfTNbMxgHqpIql8Onh1mYPXUzcoWMpy4MPI+GAhd7R2KnDixa3LV+G/OAL9MXqnQ1qug8AQCwY9rcVgWTGLrk2JOfsjd/1BecOfD+jwEvUmbtheVI/gHeoTtGO2IAIG6CxVwJvs7r76Puo8RfH1GYgEh7CvE62LXNHC7pHAYsFFZfAy2xgcvvXGBucsc1aGYL/Xs6XwS1Qqsp90XzKePteHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPIhaWuv/qFAWGX1GiNrcS7A4TVEKIOZSmi1kUHxZpI=;
 b=oXddU1BTc002nQMvkZ/+ggABE0WLfNnICkQHJpMjcr4WUWis9Fksn5IAqDhkKqUlaKDSiw8i3VmSmNIB4xJwGuax8FmNKCu3KKGywgLI38H3Gfxn2u0VdCqPjkCvi0UZ1N/IOqiHJWeyw8Uo7kgtKsBz6YsS0EQmastVAIpjIcmuQmMRHEsLMdXi9eNDct4qFC2k94yvogKMgnqh0+LYnNlV7WRF+JiXZFTYt+68AsPKAf92oBx6+ki1ZUyd5TPWaKMfWv297gezmve6cxwDhplKEbYvRdKk9GdnM+BOixUrWLEBPvMecXlFy0b1TRogzcBNLFgiWt0ltpUtMnnXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPIhaWuv/qFAWGX1GiNrcS7A4TVEKIOZSmi1kUHxZpI=;
 b=V9hLZyX6lmvKcxt4jy4mIef+RB/ELdLTOyuUXc6AqVM4xOI5m1OefZEoHtROcfFhAHQrfpOAuE6p4fL8cU6wqjw/82YAMvukIrVqVvpNdRleMhhRKGM4W77H9R3NpeuUY+/IucQrTcGMu/M6xtM/ig6BQo1+/gNkfNsYA23CvxBvow+m+2KTPIVJFyWIdfgmwtmRag2xfggBKCFh3BLcZgCl89I2WKFvo4Z9yBOXh2HvQSMc9e6dIuowOTkwcwVr30Oyf6TOMMrn/IVktVuRAwTH8QKXU0MYqOCMtFhZsp5GBhWrx9ZvmoQeNKrWuAUvXaKR7/TzFPcqrrykUltScA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:14 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 04/11] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB machine
Thread-Topic: [PATCH v2 04/11] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB
 machine
Thread-Index: AQHcmkuJxXhLTxX/ME6kz61F0LIeOA==
Date: Tue, 10 Feb 2026 05:10:14 +0000
Message-ID: <20260210051008.355149-5-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY1PPF9851F8D71:EE_
x-ms-office365-filtering-correlation-id: d6c1828b-e7b5-4044-75af-08de6862ac74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ooM0II9nvNbxAb3LWbQ+EyyrfS2PnXy2BPDI5ZPI+ckDEdb3OK6/Vx4TB/?=
 =?iso-8859-1?Q?ck0vXurVVGaBike97ADw7DJje5nRciPWYHLIXXphhDwUs8Ptrf137qolKs?=
 =?iso-8859-1?Q?EuTpdO8tw8eBt8N5gprTI8wP2KLGYrBLIs1xw3s9BhECWT6wmU66mvixAq?=
 =?iso-8859-1?Q?JL394gQi487P7S3PL3njGJHntGmTYf710t08DTA45ucKndhfottkBPImTv?=
 =?iso-8859-1?Q?kFxkJZ0OseDRcH3nxP4QMdBqZGHBjZJ/sKmoZmSIGM49qE99xvVy2tfCvg?=
 =?iso-8859-1?Q?mzORz/kBq3Kp5uF4/xy95exX1q4pQE/H87NmbXSFkR4FZzgBd5D83pbrNB?=
 =?iso-8859-1?Q?mKj24WblaktZlM4GfnqjQyKYZuMeYN0wiFUzQHstVzhq/naZW7zXk12td7?=
 =?iso-8859-1?Q?rycIwP6/jImqKeQEkhKH0AvdZ9sOrohtrN/g45Zs88XE4mHBEVd+X8zORd?=
 =?iso-8859-1?Q?yKvKvXvRyQhv0XJ5bHqMzRZRSxHkNmc6OYxpjcKy4VdtHnfaY+QWULk+Rm?=
 =?iso-8859-1?Q?iYxzIYQXmwQuAucJb5uwMx69tWfbvQj5visl+FPhzHpHQNIAkrJxlyCFCc?=
 =?iso-8859-1?Q?ZlKGDfML5IZ3nNwHMmm//5k1DxRrdt7iFAc5hEwklyETHeVLCXDUxPjhxj?=
 =?iso-8859-1?Q?nfBayeFjOPsfpLpfyf+gmDukXZ9Xt6YRFyuq81YUwsBYGqAWNhyRV+YqgG?=
 =?iso-8859-1?Q?8wB3pE1TCCqFpwsd4SuOHImvEVMu8cbnc9xKBqkcaJZ22/7Cln+A73VoOO?=
 =?iso-8859-1?Q?1/Tz5wwMZMDMhmdfk7NwEzu7as3a69p9wXpY6QYyf2ufRJVH+oIBquCeRt?=
 =?iso-8859-1?Q?nmo2kEj0W5qjQlzs/vXpuyH/B3UtZ0zByqN5IBAi6kTIC2LITPyUAAqAZk?=
 =?iso-8859-1?Q?RVZv6yY2DChrLz3dpnbM09n75S8m3OlbKVFyeaIZJCI6CH1x6Lblq3Efbn?=
 =?iso-8859-1?Q?cRYHRBAkutNG6IR74V3waosP5bEHPB0G08L/xt4J6+eBkhwx7hsxM9G6iJ?=
 =?iso-8859-1?Q?geHUgoAWIn54rh2QxHeXYityEFExi3cFwt426nLdXchUe39urw0F4XPkRy?=
 =?iso-8859-1?Q?1IzQDTSYzpwTV16oGcgwIs6nxdlpBo32DvnFoGovF8HwAThch0MlOLb+M7?=
 =?iso-8859-1?Q?k6rjsshB4H12bgifmyYm4m1SeeJmFaRQICIMIJTzOLLP8CPCNNQvmkr7RJ?=
 =?iso-8859-1?Q?o9CBdkxawk7R11wwQTwOoYAbgG4pCq1ntyXz5k1cR5b2GAIWH4Mk4P+MsH?=
 =?iso-8859-1?Q?xmYHZjBuiwSZoWjtcaYKvALOs1aAlMLYvtBb8meS7ml/GGtASRfnCTuQZ1?=
 =?iso-8859-1?Q?k0nU6azA9glbK5zdFifnR4DCUjfYVQu9zUTVw7HXD+yHqwT36h3DAeDGj5?=
 =?iso-8859-1?Q?uuDzwfRuCXPVL4ghgWl4AiwomFej71ZOfbFNudlEZbMyOPie496gNtKcu4?=
 =?iso-8859-1?Q?PxtynmKNO+PIbvxprXdLyefwdE5169rMr4lstLBYDEDXjjCmqR99MySD0Y?=
 =?iso-8859-1?Q?lb3w3kfC1dm9wbM7VEIGtbynQ2fILmZMSD27t0S/cjF33z66QQ4RuikWjF?=
 =?iso-8859-1?Q?unWcqZwETy0Q7LO8Mvn1vT/kS8d9HvdS15Xtp+rGwXdLfIXZk03u/K4MMr?=
 =?iso-8859-1?Q?arZ+IcsDKBrzu92wde3ML1nqR4vwPw/Ep+10eMt0iM5VBIsq4TeQ+AbUwj?=
 =?iso-8859-1?Q?FLLfRdBHQvA1J7tsLga+MFRO468PWhU3FdvbNOxT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ASdD2dnYur7HE83owAude/+a2C0aNx4EXUCOgCZcz7/g4HALdtaQeVfdlt?=
 =?iso-8859-1?Q?mAaDKLKfVFYcM+sZ67L5uXQSwl0OLSI1FyaT5NUKn3gC6at0/55FWb8ZVn?=
 =?iso-8859-1?Q?q8Qbv8DEDlECnwUDQA0iYXkwtMiEAqfLAi3XCD/u+K8s3ilCyOAXBb5dcw?=
 =?iso-8859-1?Q?bycrGo+Xfm63T3/V67Bmu9Kb/Ehz8GDL7ccWGOysuyhGAR2frb9FTBqmOV?=
 =?iso-8859-1?Q?dR0sVMDk92QMRroCuj0YGgGw0SMi/nnlLr5dDq7SE2uUklNMWjhyILynxp?=
 =?iso-8859-1?Q?kbmyQXKuXKA6POTFsCeRzpuT5OkDRk+Ryj1H80tAaqum5vH9hYadESS7dH?=
 =?iso-8859-1?Q?Id3oZxSA9KZlNoh0aKqwUh7qw8AL5zUBk5OMGCHAU+8wGXEcxpd2cEsQAK?=
 =?iso-8859-1?Q?PE8djWMAizERUKDhYiwRlQbUkEQlWEWzeO2pj0JP0b82LnmfN7Yk6DUHz+?=
 =?iso-8859-1?Q?OGyrYPFd/7HUyFXiRDMts2avQfQDgWOMhH4r2xyoJxHSGucUCMMJ6pwv1u?=
 =?iso-8859-1?Q?/LW8lVfvAjdISccDU9TIfRQ3tDyZgHTN12S2L70nLLnF7kutWD+H4AmVyt?=
 =?iso-8859-1?Q?mxXLExhHxL/oey2ahiKGIl+NB4SixO+ZDNVhrN3clh1GzA19WmXkhfyG60?=
 =?iso-8859-1?Q?FGmiQMgFgs8//r8jTNl98aGQXp8aQdGVG2Fw7qWlxUcp7Y50sogMA9/qNT?=
 =?iso-8859-1?Q?qcU9oTLaG0MQpzfVumdmEwUgARCvnlnLcDVG9KeIv3N7+M7YFpHnsipETB?=
 =?iso-8859-1?Q?4AKfXKLoKy3w7cZYGEHEqnZIFH4FEIAZ0SSoxaiOXz2IuJFW9phbrxgKzH?=
 =?iso-8859-1?Q?ZYYqsGmw5UlaNCEUgOu6Wd8zfn9tI8bJ5Q2TqAzpKbnXo62mgv2B7kO9iZ?=
 =?iso-8859-1?Q?PRjoJpqhn2ot78kUPkytFf11L3tVyc8krYm3bNIcFBMPVWI7N/Knz5biF7?=
 =?iso-8859-1?Q?kS22+Etty5NXas0vOyMd6ghpYTmVwxXX6J+QAA7Wb1UCpcA+YIk/WtrAcj?=
 =?iso-8859-1?Q?JrEAMMxB4aGdH6RL/hBhUnfgCJAi9LKCHpygb3qa0Pc/oQD8+GzOn7XGVX?=
 =?iso-8859-1?Q?AOMVc9lQzW8aCIQgYGJBOGs0Eg6nMC5+icQbjcVzkjEkCCrjk+0VRT/BSm?=
 =?iso-8859-1?Q?x7UlSPDEiFBLk/iLSZwOhkgEurtE64LGEYTequSd+Dq0GDAUUlOmF0Cerd?=
 =?iso-8859-1?Q?7oGRwJ2KvJudJMEklOd+XyMWcMB/FZZIaEubOK2vetO8bRI4xt2Tu1Aur2?=
 =?iso-8859-1?Q?GBrbZDBOffMhhwrb3LGeJ9GTvGmqTAbFWSRMLJPgbh5IkIyHxa6GuHK+h+?=
 =?iso-8859-1?Q?7jn5xZQZkchYOCxVbYGs9K8R9zeZ+p4JxAtRdD4+SbK18JFfZSU8OqO2Cc?=
 =?iso-8859-1?Q?t3xnmaWahlqoaiUgzQXx0Ka+ci8iFPX5bYwwy9x4Xp+P+KhjkCUALLJRoT?=
 =?iso-8859-1?Q?iU4J/hi80LXj+RxGU0d+4wCRNeWiHwjCUZIuAAkD4k39eggrs0QxBIG6j0?=
 =?iso-8859-1?Q?OigIHe9ILEORBE8ltJm9tdWAidtXS4UbVa8xofw9JxwGbqLDAUs+TNidcO?=
 =?iso-8859-1?Q?sk7Eodk98vpAJc+lsMe6Xpd/s/rvy1Q41VtuIQ5qOE1eSYn8YEoEwBH7lO?=
 =?iso-8859-1?Q?71J+XnJk3JxplAF+oMnqkCZ+dNHG2U1azNOX8+JA3hFtwoPk1GkZlkQY+F?=
 =?iso-8859-1?Q?oVErcUSLJBFqqjKBp/8ozrhk6xYN4BsGkmdSzgBo1LPj5es7/5P9N04qnh?=
 =?iso-8859-1?Q?Yvwb32oeCaWPdMaXmzYQBk4XGgyGYwHy6nzizfHeQO/3xjjE4Fz2gnwVza?=
 =?iso-8859-1?Q?WuAoHPRR0w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c1828b-e7b5-4044-75af-08de6862ac74
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:14.2422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKF8bIPJApqFwrvWSJODrBEhb705ZS617g8psefa7w774h/8jOkr4w/WjFoxlFiNSmWbpJM/j+IHzARKlkS8AK5UGOzA5+EevhcIGOJU7RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF9851F8D71
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

Add a new AST2700 A2 EVB machine to model the newer A2 silicon.=0A=
=0A=
The ast2700a2-evb machine is largely identical to ast2700a1-evb.=0A=
The only difference is the default DRAM size, which is increased=0A=
to 2 GB.=0A=
=0A=
This change adds a dedicated ast2700a2-evb machine by copying the=0A=
existing ast2700a1-evb configuration and updating the DRAM size=0A=
accordingly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0_evb.c | 27 +++++++++++++++++++++++++++=0A=
 1 file changed, 27 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c=0A=
index 31f7d61117..32d944848e 100644=0A=
--- a/hw/arm/aspeed_ast27x0_evb.c=0A=
+++ b/hw/arm/aspeed_ast27x0_evb.c=0A=
@@ -50,12 +50,39 @@ static void aspeed_machine_ast2700a1_evb_class_init(Obj=
ectClass *oc,=0A=
     aspeed_machine_class_init_cpus_defaults(mc);=0A=
 }=0A=
 =0A=
+static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,=0A=
+                                                    const void *data)=0A=
+{=0A=
+    MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
+=0A=
+    mc->desc =3D "Aspeed AST2700 A2 EVB (Cortex-A35)";=0A=
+    amc->soc_name  =3D "ast2700-a2";=0A=
+    amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
+    amc->hw_strap2 =3D AST2700_EVB_HW_STRAP2;=0A=
+    amc->fmc_model =3D "w25q01jvq";=0A=
+    amc->spi_model =3D "w25q512jv";=0A=
+    amc->num_cs    =3D 2;=0A=
+    amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;=
=0A=
+    amc->uart_default =3D ASPEED_DEV_UART12;=0A=
+    amc->i2c_init  =3D ast2700_evb_i2c_init;=0A=
+    amc->vbootrom =3D true;=0A=
+    mc->default_ram_size =3D 2 * GiB;=0A=
+    aspeed_machine_class_init_cpus_defaults(mc);=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_ast27x0_evb_types[] =3D {=0A=
     {=0A=
         .name          =3D MACHINE_TYPE_NAME("ast2700a1-evb"),=0A=
         .parent        =3D TYPE_ASPEED_MACHINE,=0A=
         .class_init    =3D aspeed_machine_ast2700a1_evb_class_init,=0A=
         .interfaces    =3D aarch64_machine_interfaces,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D MACHINE_TYPE_NAME("ast2700a2-evb"),=0A=
+        .parent        =3D TYPE_ASPEED_MACHINE,=0A=
+        .class_init    =3D aspeed_machine_ast2700a2_evb_class_init,=0A=
+        .interfaces    =3D aarch64_machine_interfaces,=0A=
     }=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=

