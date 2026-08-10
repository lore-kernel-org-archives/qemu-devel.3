Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1767DC5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtK00-0000Zt-GX; Mon, 10 Aug 2026 03:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtJzj-0000QH-4i; Mon, 10 Aug 2026 03:00:30 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wtJze-0007jc-0H; Mon, 10 Aug 2026 03:00:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aemEqE42T6e0mtv6G0gv8p9efXW9S4g7T6fbLu6W93o2+qLpkKwCEw4bK0RZGZkSrEgmFmRZZF0nFsMWF/YYzJbmvlSTO2yxhQ55fw3OA5IgJ/jdNkyufvJikGBdahsvt0u353EzYZSGszR+2ECUwTDvr4K0zY9cKHleRl7wStNCNYkkZarDxqQE+MziP3yWsYs5KPdrqpQBYeCXF4Cyo0Awb8mIS+Fu3sN0UpqRDHA09JD5Im77ciOnx46TDWc/ZQldBZN7KmY6sjB7u6vwW1/rq1QNUkZo9rJUlyFBmFmHIFetE+98opqtFmnn1BC8yx/oUSdhbQWyzplHr27yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN7DT98qf4dKZYLfkXt3v6PoF4Os1KkIQaayfErHVHw=;
 b=B4XXFHhdt0HTnLOER1x7C/bkewUHhUZohY0yVgc+Fmxwi4/hEcfJ/UWcPlfISCx3IP8yLvb6OuvpP09GabLvnn85+wqPWz0Ukf+l7dgvmJxAJfJwz15HG+7X1uiZXI34rbF2vIzb+G0pfXJNN2RcX7n5/NCPX3RQDhPc/bVPCUJagPt0qLBt3WhFIJ0a/RxbNnteX/DjdOV4quRVfaeI4mfItYsMCIT5LU1O8rAiZMm11t1Q2b8cn5d3BofHgrxsUHTTCCpa1dM08QJEvWl3LV6ePSIU78sVOq6Nkd9hihV5td89WCKhj+DiLH5NA4qFwMYZMywOQa7zm7wyVFZAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN7DT98qf4dKZYLfkXt3v6PoF4Os1KkIQaayfErHVHw=;
 b=oa22dpufR+0IqnPdjehigs5k03aonGAZuBqCYjjdDqWQJawLltQD23+NNTyvCxzZZvT26lgUlP1MdUiMMul2vss4BvJ7IrBv73g8cfkfryRk6o3hdLKGJPq77a+hqmrdFtgAsBKsA2LYacnGHDRh7Ed9K6JVLBz1giunBLrjK6KNEmQQP8Kb3HLnujCEDL14+6Ug/uVMKGqyo9I7O5c2yT46ykKUmEMyC9n7BzDL2wxFTXX+TsmKWCLLbTJ99XXbgdnJn0aQapruQCqkbrlV+EWJ5iXWvM8MQXqU+G2GlA3KvCGOqTk1LgqJDzbA/fiAk0BkmglMgA4LFSGG4c07UA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SG2PR06MB5105.apcprd06.prod.outlook.com (2603:1096:4:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:00:10 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:00:10 +0000
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
Subject: RE: [PATCH v2 02/17] tests/qtest/aspeed-hace: Test the crypto command
 on the AST2500
Thread-Topic: [PATCH v2 02/17] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2500
Thread-Index: AQHdFAquj+Wz5jlD0kW7yEzgF8D3c7aXA5Aw
Date: Mon, 10 Aug 2026 07:00:10 +0000
Message-ID: <SI6PR06MB763127262D85DFD67755C7A1F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-3-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-3-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SG2PR06MB5105:EE_
x-ms-office365-filtering-correlation-id: 35873191-7e61-4771-84c8-08def6ad04f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|4143699003|921020;
x-microsoft-antispam-message-info: ElpO/vY2zXdwmXLwq5C6J9a6xs8oZgF3P8YY0ZHzk0F3/GVyRNytwz92eursxc9giDCAf0g7aMdDhSDanfS2ZUr1jGZmkfCqdV0A8EjbO6zLImw00NLUJzW52VmZOfKVeNO0J67B8VY590kfOibgW25kIg0LDrWXrgEDdtuile1p4gXabF7XwJr9+jVnmSDSJpaKFaL+GvNLxU1oq2hOM4V3VejvY8pciY6LeYzBDRrNDgXsdN5OhNBw0pY9nOv3Ds9CvJMsLGP1/ui4nz8Gnjeqi+jV22Z7xtMxYSnUSBosAGmfmGNm3SN8Q942J2Y7M612Lw63AGoHWvmqzGGSYAbapTy+kLzAgAzzcfqbML5PX4TDB2hycj4iIAwUNACA9UoUTGzFQX8j7Z1x+RGp4J7eKsvrsK/SjboeLGL24/R+AYAJvUxwOD9ffeBAEukMFZnBXtKvZxWnbc9zY5AWeZp4+JUoUZgHSaN/2VEKKKrtQ1E62aSjQTpiayUMnyuDvaBAXCH+K43JvBGokorIu4L9onprD6uzBIs7L+t9jAWML3hJ2V5BrX6YE+o0YTe6PWd/bLT2a7cW72Z/IC8vVv0Tic+s1RKQbSZorhCLi0d38EL8GKru2DsPcUG+1R/mItIiHogn5GAXa8VdEQlfKFr6S79/G+MF1xSk9kuLfCTWCVIOaIy+MG5B534vpcWWMlGrWrR7BOXhAI/2IDVbLVhctvqI3DB+cimbcERm4Z2RBBaf1u7WvhdayoFJoknB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e1mWjWg+UQ+rNed063ipJ4hjZRkek0XelcJPywsh62iNlIK4nlMiRp4JX5?=
 =?iso-8859-1?Q?q2Qfh+omFOTUHlerjXfnJO0hVHCDUdMZUkEPbVbjk4SW4FF14pyPum423G?=
 =?iso-8859-1?Q?CFOgT+3gDf/oxxDr4Ik1Rk+Cpwj0PfY6OOEU2SW92Prrv5To6ARCrtLz38?=
 =?iso-8859-1?Q?9W8L+6ziKO5lEGyHfgLVu1zm23UzotEqdYVv1k8UbKjnFCKPd440piaP6i?=
 =?iso-8859-1?Q?UVo9BWwtRn8NmBZ85ETGB8KOupQLKN/1k54vc306ToynJ4MYu29kFtFvkg?=
 =?iso-8859-1?Q?IG0T4jVmorG5HMLam8UdpXuOqTJc2qqt4BdlpRG8TR40xU9L5BJFInvZvM?=
 =?iso-8859-1?Q?e5pikv6xjRP24lrHcJYnYRq0vZtKhirTisC15vprwp6QS/GmcRGDJVPl3K?=
 =?iso-8859-1?Q?esaWHCH8vE0Gw15rror4d/4q4uJa2ilpx8ZizVdj7Sehgcq9LRpInqfVs3?=
 =?iso-8859-1?Q?DXRndDfEiSZu2DZJi/Fn9j4+a7koBX9lpi7Y2yuk7woeiUueUekSzVXf97?=
 =?iso-8859-1?Q?0tMNsPwJL+ivSjIny4+s0napNls0ePEtbWsi04Wg0gjvhDVLQibRE7tTsI?=
 =?iso-8859-1?Q?pWVwMrdIX+7PH54936hDHGO+B35IIo9V7HsezRrF0OQcCmA/FAEeLucd9h?=
 =?iso-8859-1?Q?N3RjJtYSWFu/ASfgrZuyFby6KGi0szK1TGqI0VVgpKNUq5Rvb7wJtKqXxf?=
 =?iso-8859-1?Q?jkIi/hkTNsFo3PSDvfoH2xXMrifk0uM21m5wG7F9U1KawTbCTza0fVfd2n?=
 =?iso-8859-1?Q?8W+zocppfy6AEa/voAu4U21IhIkWVq6s9lohSmDBMWHBHIBK1YJW5rca+/?=
 =?iso-8859-1?Q?SC8H1P5VCvBN7TM6W+QMAnbwKdndmA+3uV6kY6W0k9ZTRhjQH47S5CLkPz?=
 =?iso-8859-1?Q?9LUdPdvZbk+hT2wM8fZp/06cGczCifD08Blq3+z7poDyqKIyMPR/2BWTnW?=
 =?iso-8859-1?Q?hJNWCopDOE9QB39u8aFUqTuHntGyiPjlyUFCE1UnuOOoC0EFPmbRGrGx+R?=
 =?iso-8859-1?Q?w9Gf4hzbiqyViDFPupL8B86uOfHy83PQYnMdRgsNauOMVaCM854xlOTaoC?=
 =?iso-8859-1?Q?dcSg9h9jb7vJTayfBg/I37XRM9NCd7LnwArm229IS45azeL6W2vptJEzgC?=
 =?iso-8859-1?Q?UNJf2COCvlGBs3od+Lfvqv7k8od0XLi8oTSEMJh+cFmSAxXnUv3UF2JOEk?=
 =?iso-8859-1?Q?28BrivbzkKt+yDohxbPVKUCqrxW8pKpIm117cVeUYEPVt8sxaP3jp1pe6z?=
 =?iso-8859-1?Q?4wFz7wS8FWpsxypdkBSNB9cr7pXFJ2K9NhwI2H2wKdx/o744CV8sMdcqev?=
 =?iso-8859-1?Q?oB3cuOUikbNmEFgoNfMWs963WHtL92kP4BXRbi7jKCozzx5fSJhYmMtRrE?=
 =?iso-8859-1?Q?jDdlzqclbLUzmriST/mWiWxoXapPAyPdrMfFpPgKU997AOlb2pqTWvao/v?=
 =?iso-8859-1?Q?fgffsbXqimrf4pPyPvB5ZgtYba6Rap3GdXy1Z+Lti8R+pQblSKcggH5+st?=
 =?iso-8859-1?Q?X1v0/t5v5s2hvLpPGJBSSg33DinOEze6Aq2tjHm++7ORltJeYJvnbAoCIU?=
 =?iso-8859-1?Q?IUM88+m/qUjL390pOLZb+EHCam8ESw+hRInmAkSwsrU0hG2zRLjXkEbDN0?=
 =?iso-8859-1?Q?xWXTO6GG6o00GPmxGyKK8ZP8zoRnxgNITO5QGCW5XLvp3p00PM4aO5A+HB?=
 =?iso-8859-1?Q?UVgZeTarLl56cx+uhno21ZNQOY/FrI54MYjaEfCSvbuaFNWl5GK3khHi5O?=
 =?iso-8859-1?Q?aluqFIzMzrcEoPFjmUJpJWSBLimKDN0ogsWUX5osqk9kYwtYiFLH2/zmf9?=
 =?iso-8859-1?Q?UbWBMTxvug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aQvQPaXuIWmsW437DLkYlcPIYUCdUZ1sLRUOx22kxMinwR9hZKMYLNbO76AoLOJxMnJkzUcP/pOGaLF1bXpigPhNr8lM6jzLk9OETbfHLdz/DzJ6FWCluV4mQskgI8eR4Xe+r4rA8/M7Tc3zv4q+WvLrI818+5HurxjnnXrtUDEmlY16l0sBYG5c/m2JoUfz892LVhOqMvjcpWlIzFHQ7L0BU3a1v5g/eyg8aflTmukZv4r3eL8ZLGhw1KlskqAFY1TZR4oROLCEmMO2Q4dO7IRvzqUE5LmBgn3mlATCmVxUXiqE+oISU53ZJRiwpJqzXCGbQltMXNChvKGRVtDdZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35873191-7e61-4771-84c8-08def6ad04f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:00:10.6180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pQpcxHH+PgL+s1kZQsJz2+5MwZH1h2s4GTZuwmTdv4AG+/Zobm2jSlUh/309ttcYZaR7LN25zm5Hgj8zGRqSuZJ66Vv2G1iwiAcwqxvez0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5105
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
> Subject: [PATCH v2 02/17] tests/qtest/aspeed-hace: Test the crypto comman=
d
> on the AST2500
>=20
> Add a crypto known-answer test harness and exercise the AST2500, which us=
es
> the crypto engine's direct access mode. Each mode (AES/DES/3DES in ECB an=
d
> CBC) is a separate test that checks the ciphertext, the plaintext round-t=
rip and,
> for CBC, the chaining IV written back to the context buffer.
>=20
> The key/IV/plaintext/ciphertext values are taken verbatim from the Linux
> kernel crypto self-test templates in crypto/testmgr.h.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  tests/qtest/aspeed-hace-utils.h |  16 ++  tests/qtest/aspeed-hace-utils.=
c |
> 325 ++++++++++++++++++++++++++++++++
>  tests/qtest/aspeed_hace-test.c  |   6 +
>  tests/qtest/meson.build         |   6 +-
>  4 files changed, 351 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-ut=
ils.h
> index 27ab2bb975..13feaa61e4 100644
> --- a/tests/qtest/aspeed-hace-utils.h
> +++ b/tests/qtest/aspeed-hace-utils.h
> @@ -79,5 +79,21 @@ void aspeed_test_sha512_accum(const char *machine,
> const uint32_t base,  void aspeed_test_addresses(const char *machine, con=
st
> uint32_t base,
>                             const struct AspeedMasks *expected);
>=20
> +/*
> + * Cipher modes a SoC's crypto engine supports, for
> aspeed_add_crypto_tests().
> + */
> +enum {
> +    CRYPT_MODE_ECB =3D 1 << 0,
> +    CRYPT_MODE_CBC =3D 1 << 1,
> +};
> +
> +/*
> + * Register the crypto known-answer tests that @modes selects (a mask
> +of
> + * CRYPT_MODE_*) for the given machine. Each test is named
> + * "<prefix>/hace/crypto/<mode>".
> + */
> +void aspeed_add_crypto_tests(const char *prefix, const char *machine,
> +                             uint32_t base, uint64_t dram, uint32_t
> +modes);
> +
>  #endif /* TESTS_ASPEED_HACE_UTILS_H */
>=20
> diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-ut=
ils.c
> index 25450a296b..0355dd47af 100644
> --- a/tests/qtest/aspeed-hace-utils.c
> +++ b/tests/qtest/aspeed-hace-utils.c
> @@ -9,6 +9,7 @@
>  #include "libqtest.h"
>  #include "qemu/bitops.h"
>  #include "qemu/bswap.h"
> +#include "crypto/cipher.h"
>  #include "aspeed-hace-utils.h"
>=20
>  /*
> @@ -645,3 +646,327 @@ void aspeed_test_addresses(const char *machine,
> const uint32_t base,
>      qtest_quit(s);
>  }
>=20
> +/*
> + * Crypto engine register layout (offsets from the HACE base).
> + */
> +#define HACE_CRYPTO_SRC          0x00
> +#define HACE_CRYPTO_DEST         0x04
> +#define HACE_CRYPTO_CONTEXT      0x08
> +#define HACE_CRYPTO_DATA_LEN     0x0c
> +#define HACE_CRYPTO_CMD          0x10
> +
> +/* Crypto command bits */
> +#define HACE_CMD_ENCRYPT         BIT(7)
> +#define HACE_CMD_ISR_EN          BIT(12)
> +#define HACE_CMD_DES_SELECT      BIT(16)
> +#define HACE_CMD_TRIPLE_DES      BIT(17)
> +#define HACE_CMD_SRC_SG_CTRL     BIT(18)
> +#define HACE_CMD_DST_SG_CTRL     BIT(19)
> +#define HACE_CMD_OP_MODE_MASK    (0x7 << 4)
> +#define HACE_CMD_ECB             (0x0 << 4)
> +#define HACE_CMD_CBC             (0x1 << 4)
> +#define HACE_CMD_AES128          (0x0 << 2)
> +
> +/* Context buffer layout: IV (DES at +8), key at +0x10 */
> +#define HACE_CTX_KEY_OFFSET      0x10
> +#define HACE_CTX_SIZE            0x30
> +
> +/*
> + * Crypto known-answer test vectors, taken verbatim from the Linux
> +kernel
> + * crypto self-test templates in crypto/testmgr.h:
> + *
> + *
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/c=
rypto/t
> estmgr.h?h=3Dv6.18
> + *
> + * The originating template is noted above each block. CTR and the
> +longer CBC
> + * vectors are truncated to a single block (still a valid known-answer
> +test as
> + * the first block only depends on the IV).
> + */
> +
> +/* aes_tv_template[0] (FIPS-197) */
> +static const uint8_t aes128_ecb_key[16] =3D {
> +    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f }; static const
> +uint8_t aes128_ecb_ptext[16] =3D {
> +    0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
> +    0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff }; static const
> +uint8_t aes128_ecb_ctext[16] =3D {
> +    0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30,
> +    0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a };
> +
> +/* aes_cbc_tv_template[0] (RFC 3602) */ static const uint8_t
> +aes128_cbc_key[16] =3D {
> +    0x06, 0xa9, 0x21, 0x40, 0x36, 0xb8, 0xa1, 0x5b,
> +    0x51, 0x2e, 0x03, 0xd5, 0x34, 0x12, 0x00, 0x06 }; static const
> +uint8_t aes128_cbc_iv[16] =3D {
> +    0x3d, 0xaf, 0xba, 0x42, 0x9d, 0x9e, 0xb4, 0x30,
> +    0xb4, 0x22, 0xda, 0x80, 0x2c, 0x9f, 0xac, 0x41 }; static const
> +uint8_t aes128_cbc_ptext[16] =3D {
> +    0x53, 0x69, 0x6e, 0x67, 0x6c, 0x65, 0x20, 0x62,
> +    0x6c, 0x6f, 0x63, 0x6b, 0x20, 0x6d, 0x73, 0x67 }; static const
> +uint8_t aes128_cbc_ctext[16] =3D {
> +    0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,
> +    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a }; static const
> +uint8_t aes128_cbc_ivout[16] =3D {
> +    0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,
> +    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a };
> +
> +/* des_tv_template[0] (Applied Cryptography) */ static const uint8_t
> +des_ecb_key[8] =3D {
> +    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef }; static const
> +uint8_t des_ecb_ptext[8] =3D {
> +    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xe7 }; static const
> +uint8_t des_ecb_ctext[8] =3D {
> +    0xc9, 0x57, 0x44, 0x25, 0x6a, 0x5e, 0xd3, 0x1d };
> +
> +/* des_cbc_tv_template[0] (OpenSSL), first block */ static const
> +uint8_t des_cbc_key[8] =3D {
> +    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef }; static const
> +uint8_t des_cbc_iv[8] =3D {
> +    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 }; static const
> +uint8_t des_cbc_ptext[8] =3D {
> +    0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x20 }; static const
> +uint8_t des_cbc_ctext[8] =3D {
> +    0xcc, 0xd1, 0x73, 0xff, 0xab, 0x20, 0x39, 0xf4 };
> +
> +/* des3_ede_tv_template[0] (OpenSSL) */ static const uint8_t
> +tdes_ecb_key[24] =3D {
> +    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
> +    0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
> +    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 }; static const
> +uint8_t tdes_ecb_ptext[8] =3D {
> +    0x73, 0x6f, 0x6d, 0x65, 0x64, 0x61, 0x74, 0x61 }; static const
> +uint8_t tdes_ecb_ctext[8] =3D {
> +    0x18, 0xd7, 0x48, 0xe5, 0x63, 0x62, 0x05, 0x72 };
> +
> +/* des3_ede_cbc_tv_template[0] (OpenSSL), first block */ static const
> +uint8_t tdes_cbc_key[24] =3D {
> +    0xe9, 0xc0, 0xff, 0x2e, 0x76, 0x0b, 0x64, 0x24,
> +    0x44, 0x4d, 0x99, 0x5a, 0x12, 0xd6, 0x40, 0xc0,
> +    0xea, 0xc2, 0x84, 0xe8, 0x14, 0x95, 0xdb, 0xe8 }; static const
> +uint8_t tdes_cbc_iv[8] =3D {
> +    0x7d, 0x33, 0x88, 0x93, 0x0f, 0x93, 0xb2, 0x42 }; static const
> +uint8_t tdes_cbc_ptext[8] =3D {
> +    0x6f, 0x54, 0x20, 0x6f, 0x61, 0x4d, 0x79, 0x6e }; static const
> +uint8_t tdes_cbc_ctext[8] =3D {
> +    0x0e, 0x2d, 0xb6, 0x97, 0x3c, 0x56, 0x33, 0xf4 };
> +
> +typedef struct CryptTest {
> +    QCryptoCipherMode mode;
> +    QCryptoCipherAlgo alg;
> +    /* expected context IV after encrypt, or NULL */
> +    const uint8_t *iv_out;
> +    const uint8_t *ptext;
> +    const uint8_t *ctext;
> +    const uint8_t *key;
> +    const uint8_t *iv;
> +    const char *name;
> +    size_t keylen;
> +    /* algorithm | mode | key size selection */
> +    uint32_t cmd;
> +    size_t ivlen;
> +    size_t len;
> +} CryptTest;
> +
> +static const CryptTest crypt_tests[] =3D {
> +    {
> +        .name =3D "aes128-ecb",
> +        .cmd =3D HACE_CMD_AES128 | HACE_CMD_ECB,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,
> +        .mode =3D QCRYPTO_CIPHER_MODE_ECB,
> +        .key =3D aes128_ecb_key,
> +        .keylen =3D sizeof(aes128_ecb_key),
> +        .ptext =3D aes128_ecb_ptext,
> +        .ctext =3D aes128_ecb_ctext,
> +        .len =3D sizeof(aes128_ecb_ptext),
> +    },
> +    {
> +        .name =3D "aes128-cbc",
> +        .cmd =3D HACE_CMD_AES128 | HACE_CMD_CBC,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,
> +        .mode =3D QCRYPTO_CIPHER_MODE_CBC,
> +        .key =3D aes128_cbc_key,
> +        .keylen =3D sizeof(aes128_cbc_key),
> +        .iv =3D aes128_cbc_iv,
> +        .ivlen =3D sizeof(aes128_cbc_iv),
> +        .ptext =3D aes128_cbc_ptext,
> +        .ctext =3D aes128_cbc_ctext,
> +        .iv_out =3D aes128_cbc_ivout,
> +        .len =3D sizeof(aes128_cbc_ptext),
> +    },
> +    {
> +        .name =3D "des-ecb",
> +        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_ECB,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_DES,
> +        .mode =3D QCRYPTO_CIPHER_MODE_ECB,
> +        .key =3D des_ecb_key,
> +        .keylen =3D sizeof(des_ecb_key),
> +        .ptext =3D des_ecb_ptext,
> +        .ctext =3D des_ecb_ctext,
> +        .len =3D sizeof(des_ecb_ptext),
> +    },
> +    {
> +        .name =3D "des-cbc",
> +        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_CBC,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_DES,
> +        .mode =3D QCRYPTO_CIPHER_MODE_CBC,
> +        .key =3D des_cbc_key,
> +        .keylen =3D sizeof(des_cbc_key),
> +        .iv =3D des_cbc_iv,
> +        .ivlen =3D sizeof(des_cbc_iv),
> +        .ptext =3D des_cbc_ptext,
> +        .ctext =3D des_cbc_ctext,
> +        .len =3D sizeof(des_cbc_ptext),
> +    },
> +    {
> +        .name =3D "des3_ede-ecb",
> +        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES |
> HACE_CMD_ECB,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_3DES,
> +        .mode =3D QCRYPTO_CIPHER_MODE_ECB,
> +        .key =3D tdes_ecb_key,
> +        .keylen =3D sizeof(tdes_ecb_key),
> +        .ptext =3D tdes_ecb_ptext,
> +        .ctext =3D tdes_ecb_ctext,
> +        .len =3D sizeof(tdes_ecb_ptext),
> +    },
> +    {
> +        .name =3D "des3_ede-cbc",
> +        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES |
> HACE_CMD_CBC,
> +        .alg =3D QCRYPTO_CIPHER_ALGO_3DES,
> +        .mode =3D QCRYPTO_CIPHER_MODE_CBC,
> +        .key =3D tdes_cbc_key,
> +        .keylen =3D sizeof(tdes_cbc_key),
> +        .iv =3D tdes_cbc_iv,
> +        .ivlen =3D sizeof(tdes_cbc_iv),
> +        .ptext =3D tdes_cbc_ptext,
> +        .ctext =3D tdes_cbc_ctext,
> +        .len =3D sizeof(tdes_cbc_ptext),
> +    },
> +};
> +
> +/* DRAM offsets for the crypto test source, destination and context buff=
ers. */
> +#define CRYPT_OFF_SRC   0x10000
> +#define CRYPT_OFF_DST   0x20000
> +#define CRYPT_OFF_CTX   0x30000
> +
> +/* Describes one registered crypto test (qtest_add_data_func() data
> +pointer). */ typedef struct AspeedCryptoTest {
> +    const char *machine;
> +    uint64_t dram;
> +    uint32_t base;
> +    int index;
> +} AspeedCryptoTest;
> +
> +/* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_*
> flag.
> +*/ static uint32_t crypt_mode_flag(uint32_t cmd) {
> +    switch (cmd & HACE_CMD_OP_MODE_MASK) {
> +    case HACE_CMD_ECB:
> +        return CRYPT_MODE_ECB;
> +    case HACE_CMD_CBC:
> +        return CRYPT_MODE_CBC;
> +    default:
> +        return 0;
> +    }
> +}
> +
> +static void crypt_write_ctx(QTestState *s, uint64_t ctx_addr,
> +                            const CryptTest *t) {
> +    size_t iv_off =3D (t->cmd & HACE_CMD_DES_SELECT) ? 8 : 0;
> +    uint8_t ctx[HACE_CTX_SIZE] =3D { 0 };
> +
> +    if (t->iv) {
> +        memcpy(ctx + iv_off, t->iv, t->ivlen);
> +    }
> +    memcpy(ctx + HACE_CTX_KEY_OFFSET, t->key, t->keylen);
> +    qtest_memwrite(s, ctx_addr, ctx, sizeof(ctx)); }
> +
> +/* Run one crypto operation in direct access mode and read back the
> +result. */ static void crypt_run_direct(QTestState *s, uint32_t base, ui=
nt64_t
> dram,
> +                             const CryptTest *t, bool encrypt, uint8_t
> +*out) {
> +    const uint8_t *in =3D encrypt ? t->ptext : t->ctext;
> +    uint32_t cmd =3D t->cmd | HACE_CMD_ISR_EN;
> +    uint64_t src =3D dram + CRYPT_OFF_SRC;
> +    uint64_t dst =3D dram + CRYPT_OFF_DST;
> +    uint64_t ctx =3D dram + CRYPT_OFF_CTX;
> +
> +    if (encrypt) {
> +        cmd |=3D HACE_CMD_ENCRYPT;
> +    }
> +
> +    crypt_write_ctx(s, ctx, t);
> +    qtest_memwrite(s, src, in, t->len);
> +
> +    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src);
> +    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst);
> +    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);
> +    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);
> +    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);
> +
> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR,
> =3D=3D,
> +                    HACE_CRYPTO_ISR);
> +    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);
> +
> +    qtest_memread(s, dst, out, t->len); }
> +
> +static void aspeed_test_crypto_direct(const void *data) {
> +    const AspeedCryptoTest *c =3D data;
> +    const CryptTest *t =3D &crypt_tests[c->index];
> +    QTestState *s =3D qtest_init(c->machine);
> +    uint8_t out[64];
> +    uint8_t iv[16];
> +    size_t iv_off;
> +
> +    g_assert_cmpuint(t->len, <=3D, sizeof(out));
> +
> +    /* Encrypt: ptext -> ctext */
> +    crypt_run_direct(s, c->base, c->dram, t, true, out);
> +    g_assert_cmpmem(out, t->len, t->ctext, t->len);
> +
> +    if (t->iv_out) {
> +        iv_off =3D (t->cmd & HACE_CMD_DES_SELECT) ? 8 : 0;
> +        qtest_memread(s, c->dram + CRYPT_OFF_CTX + iv_off, iv, t->ivlen)=
;
> +        g_assert_cmpmem(iv, t->ivlen, t->iv_out, t->ivlen);
> +    }
> +
> +    /* Decrypt: ctext -> ptext */
> +    crypt_run_direct(s, c->base, c->dram, t, false, out);
> +    g_assert_cmpmem(out, t->len, t->ptext, t->len);
> +
> +    qtest_quit(s);
> +}
> +
> +void aspeed_add_crypto_tests(const char *prefix, const char *machine,
> +                             uint32_t base, uint64_t dram, uint32_t
> +modes) {
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(crypt_tests); i++) {
> +        g_autofree char *path =3D NULL;
> +        AspeedCryptoTest *t;
> +
> +        if (!(modes & crypt_mode_flag(crypt_tests[i].cmd))) {
> +            continue;
> +        }
> +
> +        if (!qcrypto_cipher_supports(crypt_tests[i].alg,
> +                                     crypt_tests[i].mode)) {
> +            g_printerr("# skip unsupported %s\n", crypt_tests[i].name);
> +            continue;
> +        }
> +
> +        path =3D g_strdup_printf("%s/hace/crypto/%s", prefix,
> +                               crypt_tests[i].name);
> +        t =3D g_new0(AspeedCryptoTest, 1);
> +        t->machine =3D machine;
> +        t->base =3D base;
> +        t->dram =3D dram;
> +        t->index =3D i;
> +        qtest_add_data_func_full(path, t, aspeed_test_crypto_direct,
> g_free);
> +    }
> +}
> +
> diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-tes=
t.c
> index 38777020ca..4cb4c475e9 100644
> --- a/tests/qtest/aspeed_hace-test.c
> +++ b/tests/qtest/aspeed_hace-test.c
> @@ -229,6 +229,12 @@ int main(int argc, char **argv)
>      qtest_add_func("ast2500/hace/sha256", test_sha256_ast2500);
>      qtest_add_func("ast2500/hace/md5", test_md5_ast2500);
>=20
> +    /*
> +     * The AST2500 crypto engine uses direct access mode and supports
> ECB/CBC.
> +     */
> +    aspeed_add_crypto_tests("ast2500", "-machine ast2500-evb",
> 0x1e6e3000,
> +                            0x80000000, CRYPT_MODE_ECB |
> + CRYPT_MODE_CBC);
> +
>      qtest_add_func("ast2400/hace/addresses", test_addresses_ast2400);
>      qtest_add_func("ast2400/hace/sha512", test_sha512_ast2400);
>      qtest_add_func("ast2400/hace/sha256", test_sha256_ast2400); diff --g=
it
> a/tests/qtest/meson.build b/tests/qtest/meson.build index
> 56ff860e21..d5bde77689 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -389,9 +389,11 @@ if get_option('replication').allowed()
>  endif
>=20
>  qtests =3D {
> -  'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c')=
,
> +  'aspeed_hace-test': [files('aspeed-hace-utils.c', 'aspeed_hace-test.c'=
),
> +                       crypto],
>    'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
> -  'ast2700-hace-test': files('aspeed-hace-utils.c', 'ast2700-hace-test.c=
'),
> +  'ast2700-hace-test': [files('aspeed-hace-utils.c', 'ast2700-hace-test.=
c'),
> +                        crypto],
>    'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c']=
,
>    'cdrom-test': files('boot-sector.c'),
> --
> 2.43.0

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

