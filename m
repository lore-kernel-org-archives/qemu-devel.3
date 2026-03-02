Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C829ED58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEk-0000J2-9e; Mon, 02 Mar 2026 04:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEb-0000Hh-Ad; Mon, 02 Mar 2026 04:06:37 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEY-0005WZ-JI; Mon, 02 Mar 2026 04:06:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1ypaQwzKPxyOCwK//RMn0Iajg4usz1xBBnEAeEDDXINSEn9WUyTbDHuhqkbYHIybu5odM+eTCRjDmu8b4wpjILHggpZ67mfrqa04HzpFBZzzqYjh5Sih4sJ24Q/Er+zca+BFMA5bfgDIRKPISrTFzNFqzYhfdRUt/LbMa2/V52JFATLxlRA7/b1xomV4Vquu+Y2Kn6Za4ginuahuAsQ+XV78M4G/fhi6JISnCIodj5w14i+Ob+O3xmmsGp094uOlNIfaxvFwQ3YiL9eE0PhqF9jiSUjoCVI9iy8oAEovlddmOPW6jY32fnpCjZOVZw5IV5zaUBH6eUgKTRG+0L4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsShdRwexVCtMMeHSWzaL9MTCXXLIYykDy7QeBcmXcQ=;
 b=DvUZt9FrN7T9h4a1ZWh8qEKaIxbt+5eLWynD1MRTeW8eCLpjL/f2VwvXWfFnQDFPu9QMaEBERQraOOSYVbeRgJDu9jWB94bF1r3QUFybyEvfPIYgFTVzpEntdR9xFmPme5dQAZvQ1wLVCjIlL+j2gZNhZGy4Zknxi3egO+ktpOrrRWb6NOVfqMZm7f3Z5wLxTPFVtnkejUn52z5QH2YUs/JXaKBkVvjBvUDc/PdjRDC77NqsLoEMCRDjgdohsvjNYM/LWRvVUDLUF6P6hQEWPjnRR+V/cMWm4R0BgcXgka+c6uUvOjmaUu7L0UVT7CYEznhoIlzlKMmy0CZUkIyICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsShdRwexVCtMMeHSWzaL9MTCXXLIYykDy7QeBcmXcQ=;
 b=eup9cxiQMzmzH9VlcnS2WJ/LKmK/CbBIjdUZZR4TxM69ijNK0FHim6BGWMt3nQ4wHcEnmyK+MaMQUSdJvfrZTmMwRi0H6XHsXZR8kgBPFVpjTpUnYnSNazEYIjMj2aRY2UQO9lm2SCjGroNukzclu7S+8/2dxLx4ih6UingY5uL/+bPi4MaFqrL2UBdCcF8yfUjn5CgYKRm4cwmJMAUEWJL6FGF6libAb5V6Wh4N017YU/YJN9itXhy3rZVZzJlv9rmIstEN1lI/qm1SnebM7ejSgvuXE75ItRAvOjnaRvEL5RonWBd10V7M1V2puk9WIU4W93oiSzMYYJUOp48V2w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 00/10] Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 00/10] Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqiPZc9fufOBn30qme+8Of+f8BQ==
Date: Mon, 2 Mar 2026 09:06:25 +0000
Message-ID: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6134:EE_
x-ms-office365-filtering-correlation-id: 1ce764ca-3079-4ea1-d5e1-08de783afbb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: DUX3M36aF7CoHMLaCqDug9QV6Cx394mtFKh9z3+4gXJEHSBXSdB2yknVvBPX7isBU/xErv7f16udNmpuf78GiujszSqadC+mROH398aWETJF6fNV6uOq56jaQmbj84YsZ8S+MMB7p0yvAYNKTMLpHdCNZtwbAq/lfkiVh/rRrjs3Plp7LbFvtTkRNuZFo8oY7y2UfZljuMygkQIUmVBshZVD2ZufQ9N9JNPZ6qsd0iqA8MNqk2ss0kFHQE2CZjhPzL0VkvQEYwTYptUR3vdxe4890UAewLE6X78OzQ2q5EKbBIEilx/ljJ7MTTJBFFIMyz1JmqhA0mE/bcaXOi7icf4GschMLrjMsNcFm4JiRIu5YhA5iM5j7L3fTKYTlx9DaXkuqfNd6rh+//8HoANuzaRmU5OmSLbWzKxdcIBRVnRYbn5WKTWuztqPs3odUEYmxWJJUTlpYe8hs5eoczzI0z6VQttWD6Z2U37GbYRXcX+hUZFfjFIvg2kfjhDTqkP3BgTjedEfsuxC+zVJIRJejDA7mDTWxBG1UL20GDxVNN8MgSXe+rpUdUvO2aVc/QNvfidmXdqolmQMDOQzfRklLUQjmoQ3Z2IhsiF4kUu5lPxso86XE/3UK0H1nDmcwn32vLQYXMUCN0w1K1GM+k15XbjsqpUbAaC3KUAo2EpP6nKI+30E4ZqP2eZsSAwyT8KKTcmKHXuXzsnKBJOYP9ZbxvC76bXnK4pXCVAyZq+LjnwFgRTyqmCyRyMCfSAuSFZwPUL0s57yNZCr72niYSn8kKI8oELeZlzT1N1VCNN1WT0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mIiHumqtEOMEzP7NZUJ8kmR/XXmGeNLEZoZQCdpiEgSO+PTJeg6HiHWWEL?=
 =?iso-8859-1?Q?ApaFzzKcc9ER+rfQUfBiRDVmrWVhIaupDb06G2g8+wBPpkxH7x/Z/TmHqg?=
 =?iso-8859-1?Q?43H3zzk+iDPKrP8ErzhHS6uReS4Tg5wn/QpCnGE1axlLxZdxp48wzrFgB2?=
 =?iso-8859-1?Q?4IBg4jdQbeOMdXQ7EZLYVWb0KNi1wmRYuk0t56i693y3By2uXtin+/CSiO?=
 =?iso-8859-1?Q?T7/k73WisulZChEss/zSksjWzk7t2dQNACk+8sXt5SkOQ/Xxf7o5p6SBz6?=
 =?iso-8859-1?Q?EShtmGkn58xaampzFTZXzDdph/mvfE5x79HGPJwNbBxIazpGl9lz7TdZ6d?=
 =?iso-8859-1?Q?OkwiYOECfZY+2/TVvqP8qddhXoBKceiTijvp5aWmAEycH2M4LhUfN9O2kC?=
 =?iso-8859-1?Q?6+UWVttoR7f4JM23sC2aKx0Xbt9ErYOfGRCbIKI7vjLyEyPcPs1E2sT59C?=
 =?iso-8859-1?Q?u618gy9c9qdU9xDSA48KLIRPheJfbNXKvppy8cCdXKxWOnkXQiGRcpWYSA?=
 =?iso-8859-1?Q?nd05FU2pC8WJ7a2n8QAkU0eFNFckcrKI8a3c3qFjroEainDvksNKexbaKa?=
 =?iso-8859-1?Q?JvyKdm+lzgBlklxHESxZRyc4/M3zfYn2E+JNuFm6KTk3AmPJaNVeCOuzNx?=
 =?iso-8859-1?Q?pEpXRmqOWJMsWSLj46aTBpz52slsFguINT089HA3avxs455tXnUcLzCyOq?=
 =?iso-8859-1?Q?JbEem31lEpLkAn1YshpbdVXFYLnejRoqQvTdtBMjWzODPXZx7MI+t7NZMD?=
 =?iso-8859-1?Q?37O3eEX6bhpCof93Nr1n9l7u69AC8DzDropZ9HEzoaoWPAEbEwAsm997Kg?=
 =?iso-8859-1?Q?3YhSrak3g6xDiV6eP7gtA1uVEZ5vSWybcJLCg5iucKmiIs3ONTXR6Qygk2?=
 =?iso-8859-1?Q?khWujsYvskspRFUqJpHmt7nQOmVqupRuk5BQBszxq/alczpPEXwxhU5OBF?=
 =?iso-8859-1?Q?mT/ePK8UZuSL0qhz952UmRXj9B57cEYXaibenrTKKz98iWySpITJsXeKOq?=
 =?iso-8859-1?Q?T8VdZjpmf4n7CJo/NQRq0OfSniuPZFFrHI8/5mNXw0VcsUvExlosK6lmXB?=
 =?iso-8859-1?Q?JYLoJSCeIenv03ELm5Cme+spD6mdbIKv4iiJn3GYENNgSWv22Es2z8EqtS?=
 =?iso-8859-1?Q?F+fKA4Ads/CGUkQeEKyLyH/3W3jYwneISlKadfZueXDpNvUx66Gzp5SDIn?=
 =?iso-8859-1?Q?tRICTaCd3CDpDF/ErxeWOw7hjc4HVks4ADUqx0ST+9KgX+YwoRlf5ORYsg?=
 =?iso-8859-1?Q?dlJB5gxpmFzEfreNNlxF9XRY7+Hndfp+Aqk6lNrHdDdf50cgLZ6W0QvRFp?=
 =?iso-8859-1?Q?GNYINHhIXE2WEkKaaf7r8P5Dk/LrFV7oLWufJNVY65YNoOsm9qSUH5+LCt?=
 =?iso-8859-1?Q?3exNrr6EEnO21czl7U1MlLdsZl4rpgIX/Nex9iHzDXhLfWCS34jBqwAGse?=
 =?iso-8859-1?Q?B+gZfaLKMDTODrUq9UspLmnJXqdNEAlySYlo5ubZbevRf5HnPcVsRyMxG/?=
 =?iso-8859-1?Q?mqWz2Yk9fELZfO8w/u//3h0eJBcc7O8z60jHXgENXYQKtverhRRCKXgGED?=
 =?iso-8859-1?Q?ThhTk9g4CbroOzjIicqPahgH3qYn1T1Wrbw0O8F1eZySUBSJr2hws15AIG?=
 =?iso-8859-1?Q?fs2XWv8rp5sQ8KgYcQiRVilMKJXaA1WJewROr6nKCMTxiy98CSVbX7x3Ra?=
 =?iso-8859-1?Q?5urlHDR5FHJvZzKt2r7AjLFCfObCLqs8SedzH8bmPYuJd8cVv8E7dWroo9?=
 =?iso-8859-1?Q?eqZCdcxrgO9+8afX7NwPj2RovxlAC5zcMIZYNnH/MuaDrYRw8WuhpquTa0?=
 =?iso-8859-1?Q?7e4a5emRfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce764ca-3079-4ea1-d5e1-08de783afbb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:25.9274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4d4ey8uL9kE9k14QB1zLV1gtCWtKeT9qB7mefvXmgh+xT8i4N7eCcr94B1Go+lxZnXkRNBmWzWTWkSZFMe1YHORZIJttBQvhcf2f9GZhRMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
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

The series is based on the aspeed-next branch from:=0A=
  https://github.com/legoater/qemu.git=0A=
=0A=
v1=0A=
 1. Update test ASPEED OpenBMC SDK v11.01 for AST2500, AST2600 and AST2700=
=0A=
 2. Update test ASPEED Zephyr SDK v03.06 for AST1030=0A=
 3. Update test aspeed-zephyr-project v03.05 for AST1060=0A=
=0A=
Jamin Lin (10):=0A=
  tests/functional/arm/test_aspeed_ast1030: Update test ASPEED Zephyr=0A=
    SDK v03.06=0A=
  tests/functional/arm/test_aspeed_ast1060: Update test=0A=
    aspeed-zephyr-project v03.05=0A=
  tests/functional/arm/test_aspeed_ast2500_sdk: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2500_sdk_515: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk_otp: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk_515: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/aarch64/test_aspeed_ast2700a1: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/aarch64/test_aspeed_ast2700a2: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
=0A=
 .../aarch64/test_aspeed_ast2700a1.py          | 30 +++++++++----------=0A=
 .../aarch64/test_aspeed_ast2700a2.py          | 30 +++++++++----------=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 18 +++++------=0A=
 tests/functional/arm/test_aspeed_ast1030.py   | 12 ++++----=0A=
 tests/functional/arm/test_aspeed_ast1060.py   | 14 ++++-----=0A=
 .../functional/arm/test_aspeed_ast2500_sdk.py |  8 ++---=0A=
 .../arm/test_aspeed_ast2500_sdk_515.py        |  8 ++---=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py | 10 +++----=0A=
 .../arm/test_aspeed_ast2600_sdk_515.py        | 10 +++----=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 10 +++----=0A=
 10 files changed, 75 insertions(+), 75 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

