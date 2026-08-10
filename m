Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0CBC5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK4r-0003qJ-Ne; Mon, 10 Aug 2026 03:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK4X-0003TI-N4; Mon, 10 Aug 2026 03:05:30 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtK4S-0000Eb-LQ; Mon, 10 Aug 2026 03:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIAUpVvSb8xt/xlUhELfgoGamF/deDqqpapBBgiOQTQYyuHbbHLzKNt/IotmuyJbLNL+mCkWXsJOt4NWPtYklFGFGJz8SbsMP/Q071Lo+3emEOu8A4zDslqaukPjKS7uvU2JMtzdOAIVb7wlpoFiUIkMa3kOdk67sSyc09ZYZQbV7Gq7d8iKwiK0nJwW62X2oBBbIerHfahTJgg0KgrFQuZcjh385x45gIjALsiSoojWDuLzb/aIr3y1ap0IYg8euT1mlUnflx4i9/WYy91ZQHDbHgCmbqujRZ6K5cMh/a6SXKuBQGZlCqCQHgM6p+JHlI2nfmne5BaVCS4uYJML5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL4wUY/zlKSDFlirlPqLxyzchxrtqZybyDaA/x0upIQ=;
 b=MtH7G44lLaCUSIrvHgSkvYM7Si5UwTn4V4ntaDizOd+I+MvVMkDnLYPYILI/zxGBoc2paq+gw2dYiO+xCppBpcWM4GrnG/uJGL4rp0XH+g948etcs6cYWjTJAdFkrxLFKfQklEbp8HAl+SKj6kH310qm9Z+gkYapcMyrIVqw8lkM8wsTuMkYxQJNrbBKiGSLltn3ScBrglA2T44R5WwftjYeluRvtGdxhcjVVAItefNSxY0Gucpjv7IOpz/oEw+fQnjcPRpqIrgAHs3Mthd5HS9NjTqQOy1o1EtUczGF1RyOm+TwyRhF2hwCKAKubtuL2aQgwqJBBIIJIl5b7r/OIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL4wUY/zlKSDFlirlPqLxyzchxrtqZybyDaA/x0upIQ=;
 b=fTW+mpAr3eFQPipCsy6R8RSKtbRErlRceAEsj0gCTfCeyvk5n1LS4lPz0ysvp4Xa07qEjdkL6aRU9AMdvF4OcpaL15VqnV1cUS/xQ0X4atNBk1wKqULfap8xoc8tYtRTDvavQ3fowMEhC4Dn5YVt0EQ8kKlfX50NwzLU60nsvmhQwq1iqCp3JA2OFhE5N5XxKOmqKXl6iRigaKCf1x8p0AkUMwt26J5roNwlbK2bPnNMqBFVQGh7+0blRYCBvZdXxLkeoPYzHYIWBCHgq0Tmtm+Ylfw4uNzhRhp8jmx5tvD2hr1kUe2hibqX1kgESQeaEzh01RYvvKusquiDQuBaOw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by JH0PR06MB6534.apcprd06.prod.outlook.com (2603:1096:990:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:05:09 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:05:08 +0000
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
Subject: RE: [PATCH v2 14/17] hw/misc/aspeed_hace: Support the AES-GCM mode
 for the crypto command
Thread-Topic: [PATCH v2 14/17] hw/misc/aspeed_hace: Support the AES-GCM mode
 for the crypto command
Thread-Index: AQHdFAq4vC6HNEpuFk68VyuEP/4i0baXBQKQ
Date: Mon, 10 Aug 2026 07:05:08 +0000
Message-ID: <SI6PR06MB76317E683525A5CAC78EC7A0F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-15-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-15-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|JH0PR06MB6534:EE_
x-ms-office365-filtering-correlation-id: 2da39116-b783-4414-9ec4-08def6adb6c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|56012099006|38070700021|10067099003|4143699003|921020;
x-microsoft-antispam-message-info: gne7rWujaN32Prlqhw+WaK0YErKSOARmCxJVKhx5cXduYgBDEmbnWBhtcRvzyQbhlpNnj25sP6IS9Dn0ch1geHiC8MIoklxgQ8c6yJWwGtKIGJAUENbRGeL7OCesdb+v6CYGuoFFTmw733aUH/nDVSfjExyHIWEjJHIkr1c6U366uABD6oGD7n6zctMgESm8cTSw8VcowI9maS6pzqf6amUMw5VDOd7SK42PA/eKsgqZOM+9roWL8iKCp2fbbC2eCuT41I5C//nNcS/TUYEPMMCY2zlWeLmdU20a25toJLYbB506vmo1NsolXMuAEpziqut0hfxjZ5qClwCX4XfFv93OZQq3hjVP8EM8M4ZxJzl7Yif9ZPieceyzchuTvrv8xj7Yy6eJT7H7GseaNxKWwvowrg3bOtkXbYF5UkO9hhe629YOeGpBbL13RF20tqtzHXB45PSkjNN9kNFVLkZILWA7uDfu09etZws6EMJnsZ5Ooi3kwfvwNKWSgnneQcHmydUNLlJ+cPgvOhMucPFk1+SlWS5M9LlUfSmuC5HuJlsDXEtvoZVBTtrCK2cB9Dw2B1a157Fve8Z2cbMQoEWvf/sa0fri3Zt3sLCh0RPRXRslwfqGtgYQ2odMH3DHZi1/JBmU4uV3rcF3C3ZfAsHgqNbDehHUR3HgiYgZ5mEH0glavbNHP7A+mbRqz+OgqTySGJ0gpaq/07AGppoMVfzu8zb0B0IMRbm3gXGxcSncC+RqwINTckSsCwDOfxrXxpWG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lAxu7dh/OAgArG6e4PHAmUzXCJncKcmeusU7J3mAs08Zfw9S/ZVNiYgAdo?=
 =?iso-8859-1?Q?13iYkflA19eF4a0ZGYSKIA/EwZGMD65icn94ZDRnKDqUQFnib+MNU284Rc?=
 =?iso-8859-1?Q?f6nkp1L/uv8YjMJDCUKgjYZfDgDGU0/8Db1ibwJ+LTIqfZmr+0Mlmh5vJU?=
 =?iso-8859-1?Q?LsV9VCW+u6RSPlt5/uAoljCA1vYfrpaEynHh1zo4/rETqA3xp74kNjiaTr?=
 =?iso-8859-1?Q?+LyFRTobTECOs3lmxLytjbfDqIaDpv6z37OahX2FzoyI9get8lsu7dT6yn?=
 =?iso-8859-1?Q?007N9AwI57MBw9CB4y0yzsgrPjtZ2bEv0bZ0Eb++bSkgF6NLDeI+fMLs/u?=
 =?iso-8859-1?Q?BhdOzA4FsG14Eo9KjF8Y+MIElSdrOIRWuaNFP+pqPA/MFVePNAfDSv5b9M?=
 =?iso-8859-1?Q?cLaPn2yJ1cA435w4HdOHL7KQ6WMQT0R02CS1eaP+YICditoRLmmsPpwjbv?=
 =?iso-8859-1?Q?IDsG166HwwGAxlipgAAamcVth04PNMuP85UrpaIP6QyukTidURD20wV0Vp?=
 =?iso-8859-1?Q?jYBgxe8re6BbDrymxj6oZJdz/+3W/eKvjpAQOlkypbQTnHchWcGF049bAW?=
 =?iso-8859-1?Q?X474XvKl+KN5seN/Z9p45TxfynCumP70dE5fJ+7ay6u8TVaJI5d3uBc0HW?=
 =?iso-8859-1?Q?0vP/XIVuUNyb29/lFsjh+RILWCy+1r942+lKH2WObg4QnDkO0CH13HypnC?=
 =?iso-8859-1?Q?uqtiMfsyO8veRVigBDvWzwtjYvaweWiOqf1haibYKbVQVZydCr2dfRdB7m?=
 =?iso-8859-1?Q?qgp51b0345kXb7NCBZnuyskzTQd2dKD3dHrL8LOWru2uWCR9NDmj99w/U0?=
 =?iso-8859-1?Q?vRLkx0ciBa4gi3nhbr8wJBq0DEE3jj/kCcS1QEJjSv1k4XRKoQL5Y3ER6V?=
 =?iso-8859-1?Q?b1GiWNbx6loeg5+MGJgpFebY/qDGq5u3ECmRAgvKNqXi71vOk8S+jgQTLM?=
 =?iso-8859-1?Q?yFCIO3iYMc2LXADLAx438SfmNg2cFLPyV2Vq0jlPbxwQpX5oYbvw8fMogC?=
 =?iso-8859-1?Q?eTl+HgklRiqt5j2/8f8sp/KNcQjEUM42nQcDYLdOhrfUDqG66Q20YcGlSO?=
 =?iso-8859-1?Q?RXfn1n49owazOYFWePSTGdekJtkcPH+jOCgKi86LJluGy8Q68MEXzW/bl/?=
 =?iso-8859-1?Q?rrx8iIJZGjuw+H2vC+cKISXt5ooO6j3aaDT6GTNUQVxTBozPB0ERy55TM2?=
 =?iso-8859-1?Q?kt3X79WPm+N5c6qR5lJGVgxQkfUziSXkx0R40ZWCZbbffiFvE6YrkGFpyD?=
 =?iso-8859-1?Q?0Yfs5MR+0A+VJ22gF5vEU71h1A+wIoyz4JAXZD1YBCvXIZxzKSAf0kmIDh?=
 =?iso-8859-1?Q?IeQGWw6gY1Qfl30qb4HYeilsNx5n9BD2t8+zAPcWmB1Q/K+gtRlydszCEB?=
 =?iso-8859-1?Q?RWSJUm3dovp6kZt+Yc+x/NlLWx28Ta0QpfzE4SXgpnLXl+u3tvIR1Ej5bP?=
 =?iso-8859-1?Q?nXgTetf06TX3k4fdj4gKEzY1qg+7m2pW/qO0PCI0jleq6eit6J/Nuhg0uP?=
 =?iso-8859-1?Q?KUENU83XjkW5R72cL0EWVK+P4TIFoH8bClr0OdHBl6O+TBwAPAlHXeG0qv?=
 =?iso-8859-1?Q?jghDzGM54feCk+4nau5gfrznTcLOOuDsl8/OcGqoJZR2g1PEWM1GQd1Q5K?=
 =?iso-8859-1?Q?axjn3VShfKWegHv7H0JQkRQQivZvvVnc6+Wh/3LKu0Mkh9vDlWjWZpSOVW?=
 =?iso-8859-1?Q?bu2+Bf1s+Ckc1Tch/R/gwXV55eJoYzbJuKiTuQDIEx0Mscgj7oEE7AAcfn?=
 =?iso-8859-1?Q?xqSHTTH3yW/PT3C+/y1+3YZWfYql6sfw+0jF7zRLkg2+8TVo46bdqi7qFd?=
 =?iso-8859-1?Q?6tXcv4tkCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hMVLz0918FA29CUALbyXD6b2x1eg2YHzG/P2srIBhXqPR0aIGtE3RuirQFmerAs0U1yxX46LBPcd01H3YSNd3ogifNuk0/niQt9NMkk1/6n7caa+uD1GhjA3xYU3VYJQjBpy9FKaBgb/WeV30jtLb6ZdnkT8TJaRPEZ1dpY8fa3H2KfWDNQgAWO0EIcR0uE7CvqMDp4vWYk2eHhCaQnV9Co3EOAoQixvNuS8QjVv8E9hSZBT3i7g4L9Ey10fB3eSE+LDK85xLQ+ofYJN8MKy7bD8+8eahGFA5sqQMLBJDSuhyGSU50hlTGVZMq+cg9sKFz8QH7lMcfuoxA2FiXBqGw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da39116-b783-4414-9ec4-08def6adb6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:05:08.8660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIThAQsLILZae3UFGCXO93WL9g5IOf0ZeWAwY5GkdRDH951HQYG51xRfMrdD5D2I1uwWYh2eWVEranhGyh7h/mSwRR5RiJAoLA6AlUPwegQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6534
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
> Subject: [PATCH v2 14/17] hw/misc/aspeed_hace: Support the AES-GCM mode
> for the crypto command
>=20
> Implement the AES-GCM mode (HACE10[6:4] =3D 0b101) used by the AST2700
> crypto engine: decode the GCM selection, read the 96-bit IV from the cont=
ext
> buffer, operate on the exact data length (GCM handles a partial final blo=
ck
> itself), and write the 128-bit authentication tag to the tag buffer
> (HACE18/HACE8C). The hardware GCM path is only used without associated
> data (the driver falls back to software otherwise), so AAD is not modelle=
d and
> a non-zero HACE14 is reported as unimplemented.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 70
> ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> a807cc1422..927759b48f 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -31,6 +31,9 @@
>  /* HACE0C[27:0] holds the crypto data length */
>  #define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF
>  #define R_CRYPT_CMD         (0x10 / 4)
> +/* AES-GCM associated data length (HACE14) and tag write buffer
> +(HACE18) */ #define R_CRYPT_GCM_ADD_LEN (0x14 / 4)
> +#define R_CRYPT_GCM_TAG     (0x18 / 4)
>  /* Crypto engine command register (HACE10) bits */
>  #define  CRYPT_CMD_ENCRYPT          BIT(7)
>  #define  CRYPT_CMD_ISR_EN           BIT(12)
> @@ -43,6 +46,7 @@
>  #define  CRYPT_CMD_ECB              (0x0 << 4)
>  #define  CRYPT_CMD_CBC              (0x1 << 4)
>  #define  CRYPT_CMD_CTR              (0x4 << 4)
> +#define  CRYPT_CMD_GCM              (0x5 << 4)
>  /* AES key length HACE10[3:2] */
>  #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
>  #define  CRYPT_CMD_AES256           (0x2 << 2)
> @@ -58,10 +62,15 @@
>  #define CRYPT_CTX_KEY_OFFSET        0x10
>  #define CRYPT_CTX_SIZE              0x30
>=20
> +/* AES-GCM uses a 96-bit IV and a 128-bit authentication tag */
> +#define CRYPT_GCM_IV_LEN            12
> +#define CRYPT_GCM_TAG_LEN          16
> +
>  /* AST2700 64-bit DMA high address registers for the crypto command */
>  #define R_CRYPT_SRC_HI      (0x80 / 4)
>  #define R_CRYPT_DEST_HI     (0x84 / 4)
>  #define R_CRYPT_CONTEXT_HI  (0x88 / 4)
> +#define R_CRYPT_GCM_TAG_HI  (0x8c / 4)
>=20
>  #define R_STATUS        (0x1c / 4)
>  #define HASH_IRQ        BIT(9)
> @@ -598,6 +607,9 @@ static bool crypt_decode_cmd(uint32_t cmd,
> QCryptoCipherAlgo *alg,
>      case CRYPT_CMD_CTR:
>          *mode =3D QCRYPTO_CIPHER_MODE_CTR;
>          break;
> +    case CRYPT_CMD_GCM:
> +        *mode =3D QCRYPTO_CIPHER_MODE_GCM;
> +        break;
>      default:
>          return false;
>      }
> @@ -691,11 +703,12 @@ static uint64_t crypt_get_addr(AspeedHACEState *s,
> int reg, int reg_hi)  }
>=20
>  /*
> - * Perform an AES/DES/3DES ECB/CBC operation. The source and destination
> are
> - * either single contiguous buffers (direct access mode) or scatter-gath=
er
> - * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come
> from
> - * the context buffer (HACE08). For CBC the resulting chaining IV is wri=
tten
> - * back to the context buffer so the driver can continue the chain.
> + * Perform an AES/DES/3DES ECB/CBC/CTR or AES-GCM operation. The
> source
> + and
> + * destination are either single contiguous buffers (direct access
> + mode) or
> + * scatter-gather lists (HACE10[18]/[19]), addressed by HACE00/HACE04;
> + the
> + * IV/key come from the context buffer (HACE08). For CBC and CTR the
> + resulting
> + * chaining state is written back to the context buffer so the driver
> + can
> + * continue; for GCM the authentication tag is written to the tag buffer=
.
>   */
>  static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)  { @@
> -705,6 +718,7 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      g_autoptr(QCryptoCipher) cipher =3D NULL;
>      g_autofree uint8_t *src_buf =3D NULL;
>      g_autofree uint8_t *dst_buf =3D NULL;
> +    uint8_t tag[CRYPT_GCM_TAG_LEN];
>      uint8_t ctx[CRYPT_CTX_SIZE];
>      Error *local_err =3D NULL;
>      QCryptoCipherMode mode;
> @@ -713,10 +727,13 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      uint64_t ctx_addr;
>      uint64_t src_addr;
>      uint64_t dst_addr;
> +    uint64_t tag_addr;
> +    uint32_t aad_len;
>      size_t iv_offset;
>      size_t blocklen;
>      size_t buf_len;
>      size_t keylen;
> +    size_t ivlen;
>      bool status;
>=20
>      if (len =3D=3D 0) {
> @@ -736,6 +753,20 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>          return;
>      }
>=20
> +    /* GCM uses a 96-bit IV; the block modes use a full-block IV. */
> +    ivlen =3D (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) ?
> CRYPT_GCM_IV_LEN :
> + blocklen;
> +
> +    /*
> +     * The hardware GCM path is only exercised without associated data
> (the
> +     * driver falls back to software when there is any), so AAD is not
> modelled.
> +     */
> +    aad_len =3D s->regs[R_CRYPT_GCM_ADD_LEN] &
> CRYPT_DATA_LEN_MASK;
> +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM && aad_len !=3D 0) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: GCM associated data is not implemented\n",
> __func__);
> +        return;
> +    }
> +
>      /* Fetch the IV and key from the context buffer in DRAM. */
>      ctx_addr =3D crypt_get_addr(s, R_CRYPT_CONTEXT,
> R_CRYPT_CONTEXT_HI);
>      if (address_space_read(&s->dram_as, ctx_addr,
> MEMTXATTRS_UNSPECIFIED, @@ -760,7 +791,7 @@ static void
> do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>      }
>=20
>      if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&
> -        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,
> +        qcrypto_cipher_setiv(cipher, ctx + iv_offset, ivlen,
>                               &local_err) < 0) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv
> failed: %s\n",
>                        __func__, error_get_pretty(local_err)); @@
> -771,9 +802,11 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>      /*
>       * Round the working buffers up to a whole block. Block modes are
> already
>       * block-aligned; the stream-like CTR mode may leave a partial final
> block
> -     * that the engine still processes a full block at a time.
> +     * that the engine still processes a full block at a time. GCM handl=
es a
> +     * partial final block itself, so it operates on the exact length.
>       */
> -    buf_len =3D QEMU_ALIGN_UP(len, blocklen);
> +    buf_len =3D (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) ?
> +              len : QEMU_ALIGN_UP(len, blocklen);
>      src_buf =3D g_malloc0(buf_len);
>      dst_buf =3D g_malloc0(buf_len);
>=20
> @@ -857,6 +890,24 @@ static void do_crypt_operation(AspeedHACEState *s,
> uint32_t cmd)
>                            "%s: Failed to write IV, addr=3D0x%"
> HWADDR_PRIx "\n",
>                            __func__, ctx_addr + iv_offset);
>          }
> +    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {
> +        /*
> +         * GCM authenticates the message and writes the resulting tag to
> the
> +         * dedicated tag buffer (HACE18/HACE8C).
> +         */
> +        if (qcrypto_cipher_gettag(cipher, tag, sizeof(tag), &local_err) =
< 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher
> gettag failed: "
> +                          "%s\n", __func__,
> error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +        tag_addr =3D crypt_get_addr(s, R_CRYPT_GCM_TAG,
> R_CRYPT_GCM_TAG_HI);
> +        if (address_space_write(&s->dram_as, tag_addr,
> MEMTXATTRS_UNSPECIFIED,
> +                                tag, sizeof(tag))) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Failed to write tag, addr=3D0x%"
> HWADDR_PRIx "\n",
> +                          __func__, tag_addr);
> +        }
>      }
>  }
>=20
> @@ -987,6 +1038,9 @@ static void aspeed_hace_write(void *opaque, hwaddr
> addr, uint64_t data,
>      case R_CRYPT_CONTEXT_HI:
>          data &=3D ahc->key_hi_mask;
>          break;
> +    case R_CRYPT_GCM_TAG_HI:
> +        data &=3D ahc->dest_hi_mask;
> +        break;
>      default:
>          break;
>      }
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

