Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D1FE8B364
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOX-000131-Rx; Thu, 05 Feb 2026 22:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO9-0000Vy-UH; Thu, 05 Feb 2026 22:20:19 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO6-00006q-Sn; Thu, 05 Feb 2026 22:20:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5skSJFvtVoKFqRpP04xSomQHOxzv9sn8hz/xEAlSiMQwX9yAc2Z500RcaXYR/+X2RSoZKSzO+D0ckEbcFa7h8e7xx3RTQH0O5kCWVIqA/wUiFM5lKZ5JniyF6NY1U0HaLoImnDBwJX6Fi515GQn0a1fF4DbOWQpfAi3gfvjL4m3WrvlCK62xTxdyF98lDAfdqSz2mr9/C1xvY49wwFP6bpLbJrHl3irKuigL+fqzcF50i2E3NrmKDjlGNx8VaLEpEiGxv1BLO/JaDpkngETMftDBrRyqAcmSeJEWa6Ow6Dy9tiruDPuW3kFBbI5wVryCc0Bp9YhfpDnfOa88S7o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tbCknTwi1xjuTpO1/FC1i14aztT8D8fNB9TBEDoEAE=;
 b=JkeXHI0Ex8+7aix2MBdj7k8wXD4CasUB8ubPpQEt9UojQGzXeWitJdEVePQ4TPkPFifUGOL3tszdEQfdfCiv/zHBr/iHJ1+vQFUdVcyzRjxKsy2GFuZt2v0vuigqJr84h0cME2A8U394rf0ZYVjucTAxmGaItC2qw0yOaRAHazoZQZ6ifuVzPreC9DMpa4nxv8hu6QIGzF+IvdwmRIhDkRbcFNoYs7EVQwFIpGH82L51KQDz8P0uKpmkxFePhPMjI8ssA24fAoKsY+Q7BlxNpx5WjNtUzy5uONzMLh2P2yhImyt/EEYAptlQQAe9g6xl13SsPoWHf4tmWz3HoY7hdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tbCknTwi1xjuTpO1/FC1i14aztT8D8fNB9TBEDoEAE=;
 b=mLFgGZIEw7uOjh/CAdSbiRK2ItNHtnkz75TqiM6QJ70TIrkRIYjDfPkdLCkwDKKO1KpaxWOkb5ZsrkK1fNylTRJWCTt3ALhhqx0ofZxYAJvxmmvkzHjaL4SsT8mWJRWPQ8gPXVrLiED1XSHBdpDRBF9hlt8mZHPkTMV2dgyp/ls4LZajpmCbKFjW05ft3c9ADaMOIqxedLCEj5ioEW26EBCBgDLb0EXpMyo1i6Cxt/a+Gd2vGAHfASdEAfI3Vlen4FZbKsoH4qEZ7ShK0HqYOotsFw4sOmbVWiIe9EUnlmjhD937Cl0eNhn5js+CGcrxAoTR33ErACz/6iuWn6M9pg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 03:19:55 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:55 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>
Subject: [PATCH v3 19/20] hw/i3c: Add hotplug support
Thread-Topic: [PATCH v3 19/20] hw/i3c: Add hotplug support
Thread-Index: AQHclxd2vd4KwCoQqECv9FjvPu8Big==
Date: Fri, 6 Feb 2026 03:19:54 +0000
Message-ID: <20260206031926.3227848-20-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF4DD1DCAD3:EE_
x-ms-office365-filtering-correlation-id: 8092f389-d74e-4276-33e8-08de652e9965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ebbigJSnnb3PU2/b5bLZSah0ptr+kzBeDf40ygZwSIYw0c31LhM4qiKxYX?=
 =?iso-8859-1?Q?+dWs7oA9WdAudoKE2oh+tnydqXAqDyQmdQGtJrEknpnpSLYQXYWy8bo6z2?=
 =?iso-8859-1?Q?ngz+Z1CWxMemK+n7OhqcP6eolNTOEnGLePOUKjDbkIbUK08lO4hQo5wCOI?=
 =?iso-8859-1?Q?QMoIgLVBx0AdZFHHlU5SrGrE3Z/brC4WCiqHzEW+m6HAf14YthcXvbQ2Ke?=
 =?iso-8859-1?Q?3/0zIBDeIXXGthNYOwhiG9F+t+J7s3x6+DQBxnMTobWujThWqqmgAYNkFh?=
 =?iso-8859-1?Q?Ou3dYVDQ6s9H+jmw+n93spFN1eIuiwNNL0X/c2JvbXtDtrQafh8B3VNf9C?=
 =?iso-8859-1?Q?ftN23GSrg/grSLOiXEUNJeXetncAwBJQ9aJqZKylmE4CgGDTCIqD2AmSWo?=
 =?iso-8859-1?Q?XMVsvSIEHhO8ZHeJTdox5r/7uZCKI+goBHVuWsKsqDMhpDm0n2Q0tZrCG1?=
 =?iso-8859-1?Q?Z11iZAvIPRc6KVkDdQkPPX2+d/eN7amvXpDJ8ccJ5jGuVoWumKac7SsgEZ?=
 =?iso-8859-1?Q?QQ++oKH0n6KW8GjOuV+Jx9jd6z2JZdJWBE9aZB3G4Gz3sd5Kdiz7Z3vp0d?=
 =?iso-8859-1?Q?KZvYP0q2Kwvae5CaTzuywvbFTqok+zVX+pmVP49CobXDKoo2delcEhkWwg?=
 =?iso-8859-1?Q?HaCZdiO+C/4oY+t/bCg1rCFXJmYJD+14qfwipobusOoDbh+UR/FGXJQsFO?=
 =?iso-8859-1?Q?b07g4PEQ9VdEUlYmcUteG6j1DjWgDTLVLkeLqhiJIBfhgZW4ScOFq0wlUd?=
 =?iso-8859-1?Q?iW0oDWFoD/ghzGEXiLYhMTSJNqE2Wip8drcyG+2jS+A8FfVNpIqF6t0lum?=
 =?iso-8859-1?Q?Ucb2KDP7ewiJL2ljmIsia2aKvYZI9XJOOoL3OwWDSAOekWxtYB3OSEHlQD?=
 =?iso-8859-1?Q?umQoxcCmJDt8cgIrV97H91DHVDQOgtJ+/+5N0+xz40hQNk20UsDZGtok9G?=
 =?iso-8859-1?Q?av9xznVhSsPBbDUtAZs0t1Wz7qZx+QY3Ja/mmIt0uNXIccSds0o0e7x6gw?=
 =?iso-8859-1?Q?C5MSsXsdmMXd2yXjYRfHXlvTN8XvfM2DyN2a20w1Kp0AN104gTXdEyOQ2d?=
 =?iso-8859-1?Q?OMEY4S3Dz6D+YczMQUp0gXB1jPZEt2e3Lo5hcAjLIl13xJprFiiC5BKes1?=
 =?iso-8859-1?Q?9jDVFEglCG1Dm/SwPzAWObpNBR33s6HvxAkRdhKuO5wl66NYCGW6jOXhyU?=
 =?iso-8859-1?Q?yU2MLu3qBU8zCaIyPUXdwXVksjY2WeDPxarDHbfb3vhpyklM83+2THpYtb?=
 =?iso-8859-1?Q?RmzKoOr12vnEz5Rs09IRgU93lE1sj1XIiM1lzaVxi/t+AQ03alEzcwwTY0?=
 =?iso-8859-1?Q?9Jmnnd9H4K0MSJ73w1Mo+Y/OaWW/q5VLlhkWdbKL7hkdXRP/mz8uLoQ59B?=
 =?iso-8859-1?Q?PpznPtU4LcrA0SsjqylsPSkXdx5eqwxpd6WPaPs4Xs/nRfrljOzca1z264?=
 =?iso-8859-1?Q?4u0m8dJx2vj+umg7V0LQoW7/+vuTcImbKJJUYlHlAfPDK1ISnzNnz4Hnft?=
 =?iso-8859-1?Q?EVwQGLOnR0qI9EtgIl+5J8ljbAL132sUyTuSGwLHZvdRTk6JtNlTzypcg1?=
 =?iso-8859-1?Q?sPZZaLm30ypag7BUXbAAwzj24wRjVsy30dlO8fSYnJkdtac/n2sq8yCEFl?=
 =?iso-8859-1?Q?DVrRqJtMMTQPJXo6Vlejmq3EhWEKQXLdMHMGVRkj3k51KwstUmi6z4PeWz?=
 =?iso-8859-1?Q?bFHSDBLUuGEAS8dicZtXJTfnLV2omnzM+FImc9EM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pSwa10DlG4lruZ8MoKOySy0ZmZAyxxAh6OBfmPyhhhP2u1xfd0xrIvyo+t?=
 =?iso-8859-1?Q?kSNj827R4/UE9jkW82N2RquVrL8B48stvbwT6Mfr2/fIad5fTGllwOKr/S?=
 =?iso-8859-1?Q?jyltF4Cv8nSVG1155Ft/XBTB6EKUooFdlfBZtNwjh2CHTMkuFMpYyZRjaQ?=
 =?iso-8859-1?Q?VxvxGONarAzuZclNouyN6P1aug4+Wt1Kg7ahnY5RHA99Uc63mCuxm2113y?=
 =?iso-8859-1?Q?2KUMNSLhhIDmZ7dLVeNi5DqLDl2Cmkvq6Do5sJ6+EbBmwH/6DIh6dGsB91?=
 =?iso-8859-1?Q?TxF9y6ZHvmoSEC9xoImZqrcmheZnrfNIiDjQnrMWm1WJYkQTIshoWPpqEQ?=
 =?iso-8859-1?Q?bEtQqbxyloo6ramoXgOgYk7d7q7vw/nASZbpv+tB68b8qmwty+vHJmhAKU?=
 =?iso-8859-1?Q?wbNHBFApBWb18ApILH9h6tBFTNNwq+Pt6Q65l/URYS8LM1SSQSGXwVqYVu?=
 =?iso-8859-1?Q?QqAgM8HhKGxm3FEqmwbsVovnexKMhMolGnskUbbhbU6j9JYAlf9DtyTouA?=
 =?iso-8859-1?Q?9bHKA8EnJ7K5DTsVXsq/3t2v/UnVTirDamdCOAE32X7whpNNk6F6x34fnm?=
 =?iso-8859-1?Q?VzxSLEdrAfxs3lfN+y2BHozsT9pPQL7LXGpK2QV65st3yv5zX06yQ+Gjiq?=
 =?iso-8859-1?Q?tu51z10Si2xQD4nxp4WZ43KUkhlV7Ar7c432BuA2DOA8JHG/wzrLp77/Up?=
 =?iso-8859-1?Q?S00Q8sPMjjWNPcoZJahJ7gmAVR2HogED4/D2TxcgqvgfoWPK69d/9EgifF?=
 =?iso-8859-1?Q?/vR8xwFfsWbhS40BOOhEaIiJtgwsO3P7hVNt+s7/FeeLXl3I2d/fZgge0x?=
 =?iso-8859-1?Q?QOKF2pu/+ZAWRtOwg8WCSi6Z3Q99XrKymjxyiYdVM0ucCnp0dJXyIXR9gL?=
 =?iso-8859-1?Q?4Tbk3RYQzqcyXAMEOAo742F7x6GoojGiHiUGOyvP0V+3TzeIf6nq43qlfw?=
 =?iso-8859-1?Q?xVMF3TgLzz5VzkmmW+QnqfCS5aBHA5ZnsL6O3yKxrTZhd8Ily9t+bn3RKm?=
 =?iso-8859-1?Q?tXSznoer7WyRrI8ejNg5DgihDqxgMVtHMDNF1R9d33eT35dgODwvjpvAnO?=
 =?iso-8859-1?Q?7wNje02hpYoZT4uZBXhsVmdqWAtPrc2KNYX0hzf4lpHDWYr4KJRParN02r?=
 =?iso-8859-1?Q?3B4e3X6yC6/Qex/i60u+fFMU+zVfJTF+3U852x0grlLTKNqw3rXoAL3pBd?=
 =?iso-8859-1?Q?PgetenNpmm/n00Rz4AEfaoDxiyC211ReukR7FG9ee0Kn6rnVY9zvQH+kdO?=
 =?iso-8859-1?Q?Wm4K090uK8Ns6CDR2ISa3ZOx2rsKUvGs7Na5J8oLX4vG82BuIqq1BvqMiv?=
 =?iso-8859-1?Q?IaTOufJppEeQy32toEZBLSVMq4x32/ir/Z+/JVj3Z22lJDfSCzJCIUOQb/?=
 =?iso-8859-1?Q?nVQCa/xty/v1ZLQGTFwHO4s+JAVXWgFYz4WX6eAxxwmdq8l1H17/t8JEIx?=
 =?iso-8859-1?Q?bxvOX83UnAHNM/fqsSctggZr6IxqMcJq8/+tOca08NYxd6becHzIuA9wLX?=
 =?iso-8859-1?Q?1f9M2F2bY/UaeFIB0JL5IP5o3uoqjOWVz+KR0HobJMTcmaa2I5iLQtlb/V?=
 =?iso-8859-1?Q?u0vUAVyfN6x/2tlnQ+sDR9sSuZKlsUgQYCOqgBn9l+dKpnFBw32/7EywEx?=
 =?iso-8859-1?Q?0AjOMumiceAqsxrzxccmzXfS3kab6U7W++UnvAn7PFd0JpvxG3/Nazq/n9?=
 =?iso-8859-1?Q?2e5R8Ywj3YZWY0gxxNRKZxChaGcvMt0BMjiCENbJp5L4aoNKWMak0V8aAf?=
 =?iso-8859-1?Q?6GECSgZkEv9liusFb03JTay8LrNiaRtobh0jvEilSE+D1SowOO8WveRdAK?=
 =?iso-8859-1?Q?BLf1jh+mrA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8092f389-d74e-4276-33e8-08de652e9965
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:54.9276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOfFOVNmeuftVlb1YmMoslk/E1wFUFVO0S5sjHkMj+A4I4QsCcWz5y4/Z2bkzB8BI+RAeXeHI1QqLqDnq9HF0g9OgEm2QTvPZjztWl9i0g4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3
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

This adds support for hotplugging in I3C.=0A=
Conceptually this can be thought of as an I3C target being physically=0A=
socketed onto a board.=0A=
It is then the target's responsibility to go through the hot-join and=0A=
DAA process so it can participate on the bus.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
---=0A=
 hw/i3c/core.c | 17 +++++++++++++++++=0A=
 1 file changed, 17 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
index fb4bfe5aec..1ab95c4866 100644=0A=
--- a/hw/i3c/core.c=0A=
+++ b/hw/i3c/core.c=0A=
@@ -11,6 +11,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "trace.h"=0A=
 #include "hw/i3c/i3c.h"=0A=
+#include "hw/core/hotplug.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 =0A=
 /*=0A=
@@ -26,11 +27,27 @@ static const Property i3c_props[] =3D {=0A=
     DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),=0A=
 };=0A=
 =0A=
+static void i3c_realize(BusState *bus, Error **errp)=0A=
+{=0A=
+    qbus_set_bus_hotplug_handler(bus);=0A=
+}=0A=
+=0A=
+static void i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    BusClass *k =3D BUS_CLASS(klass);=0A=
+    k->realize =3D i3c_realize;=0A=
+}=0A=
+=0A=
 static const TypeInfo i3c_bus_info =3D {=0A=
     .name =3D TYPE_I3C_BUS,=0A=
     .parent =3D TYPE_BUS,=0A=
     .instance_size =3D sizeof(I3CBus),=0A=
     .class_size =3D sizeof(I3CBusClass),=0A=
+    .class_init =3D i3c_class_init,=0A=
+    .interfaces =3D (InterfaceInfo[]) {=0A=
+        { TYPE_HOTPLUG_HANDLER },=0A=
+        { }=0A=
+    }=0A=
 };=0A=
 =0A=
 I3CBus *i3c_init_bus(DeviceState *parent, const char *name)=0A=
-- =0A=
2.43.0=0A=

