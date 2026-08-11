Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDF7C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcsx-0003eW-FJ; Mon, 10 Aug 2026 23:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtcsv-0003eF-7a; Mon, 10 Aug 2026 23:10:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtcss-0004JO-Hx; Mon, 10 Aug 2026 23:10:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlMVNe2bI4HKhI7AMqzTx7Xhuv14ElFTfycPwdRIa/VUsuFK9IBjQ7iEKPxHiewl5+AJ84aETKmLomTsSWQiGM93WkJGUKC43FwWT79So28guFfrgZi6LVZ49SB/w+/pIeC7VSXGPIRrLSt8VCKTn6qX9xS/EbNtkAO2eTlVncmFQlu7UxxeZ/uU8JCOrT+99jfLS2FiHjyyD9u2BW9r8nKFZQl4QAGYDuTCZGh+dagOieko36gyuJuX1oypTcDqH8K6lARuqY5Md4UFq8UXJsmkmkFtAmPXedb37XdLvb/conw7ObB7nMi8c65sebP1FtDK61Sey+IaS75j/9hhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcTqyUUlxxwyFH+8XvFBbgBsOI38OI1BBw966N3pzWM=;
 b=kcTBO76d8/kmOJKpmSqSxz5+n4ARFga5sy6Bhz9i9bz6I72IfyK1rPlz698WHLLoKfwYUgECF6taJtRwaa01ZhubQK8BO7txhP1HVmD4KgDjVpquzRnzLL1Vguq5JSuoL5/Jm1zZeS3a/vcKHll9Ek4AfWnLu+l+DNK4yf9Mis8HA178HlwMhoHYLdIBvjBdG9rbQPaLQ2hoXqGTiyaXVi9f3jQZZR/MOc5bdzEsONKPCOs13cZojJUUIUnHjQR/dxCBQBYoBIhEj9TkI/tNi1UAuOOH8PocjFm5L2Om1s5KLAkCCZ6SJUtT8CyNHJKhy5mNE7Cy3UYj+TEq+lu3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcTqyUUlxxwyFH+8XvFBbgBsOI38OI1BBw966N3pzWM=;
 b=ZgKau0akjp9PmymJ8NAkG0YMV5XWn/skegFCftJToE/pN3KfuQFzVxQebKOWvDmY2ACf33OHg/hhkzf7GuzBKU6ljG461XOxSPaf+z5r1wLhTeEUK5W3QMZEonBiARzz+5saLFg+xwrI9OKY9xl0cfWCoBE74Rc3n0JbIqDYLUKBO+N71m2xOcNF7dt47j/FbUioXyWsKcCNNczyLRtSTHYbKtFammzXr5/jUFEse1/tI2ZBqHf6Ljc3EKwzamStLuoY9Bj/KlJh9e4U+BxoQrDn06v7JkPaIW4MXOxfWqGunnCloFR8XJ0MwLl3UjmqnDLtH92BY/ZGmhHFxf0XkA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:27 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 00/16] Support the ASPEED HACE crypto command
Thread-Topic: [PATCH v3 00/16] Support the ASPEED HACE crypto command
Thread-Index: AQHdKT71HIeySLgUaU68+RexcXipmQ==
Date: Tue, 11 Aug 2026 03:10:26 +0000
Message-ID: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: 4369ef6b-8f97-4813-b156-08def756178c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: GEoQglT8xybZ+Ak7Qadd23OwXOdLZBWdN3o9cxTWxMa+lmmN91lHFoPftpge1PfZj8lfoq90LWJS+Z5pb8P0jTSO10iozp7BQ/DIK+EknBhSdiREkjT+RkdirxONTUIBvuZx2PMCwR+9MqXFrpJVIZIRSj8YoAQc6F0Ycm4ccrpu7/4uim10nKdMdvbIPj5M17bTQI3upfio8osUgLQXyoojJ5zwuTxKRagCUXlpc8K5gKaLplz4EupgiLnbyIKGL87sfBRmaHf4sPUnntECyCzSaMpJqj2509GypEZB9fJpBayMOu8LkEDKpN4NyfiZmb3ejF1B+JUmYTyhWO5uuAcH5nH4Pl3HyDeM40H5ZSSnXUZCbkrtB2nRl0SCCnYVKKWZTKjUbFS8TtUMJlNqV0d8gjXojcp+728TrFEq997IFGAKtdK/0igcx7cUOvqtMTVjotvHdE7+JH2V6ejpZTgEQ+MbNMZQygcPIwsC8BpDclhv1Q9XsQvHjSqyMnnZxkTM5hP7KGSJShl4okflkmfkQOig7MYE90bjw4QYzYp0e4xb2XDD/trkrMi8qPAGpAHwdWEcmBWb+vx/n6l5fSrxLM/dKMZPQr3ur0+OsOU4isSzvJr62UTnuTnJY23LCAKzLfsnYDokXAuUIKlXJyQXYsSKcxDkOkzoliZjqs0Hs3LtwNoQ8lnfs4YTikoEqlMTpMead9qq8ICzxyMDl4VLc9k4p1qpzktygCOY0PXEWrodfM1/GPP2V7Ms3NHd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Eq5sBe+ZNKlufe+J2uz9ZDEsMRnedtOruQMAxcL2qIBkzRzUzm75y+gBMF?=
 =?iso-8859-1?Q?AIuR3NdGGTj/ZxbrhLrkXXJaP5hEq6V/kLWNHjjuAQ6LSTrxX6GxHMv3jK?=
 =?iso-8859-1?Q?sRJXOPZDc/2eB8gMKQwGLEOwWeRo6IfxKYdmLDgE5fNl6c6vvV7CRVQN1n?=
 =?iso-8859-1?Q?C4qtlOSfm1CznR0jKDDz9Nw/yXxpV7cIuaiglX8KWM6CQIIsKn6gR1KAoa?=
 =?iso-8859-1?Q?I2Wu2+sW5S/tDgnJW1EXf8cT2Hx4yKusTMi/NIN6KWa5r5Nkh3fUnEIMGl?=
 =?iso-8859-1?Q?7DNzcJk5K4HO1Ssytw9qOmdk4V9gEdG3cabZMtkePqss71z2GBTKeh3mFl?=
 =?iso-8859-1?Q?SPmrpN/Av+cEy+GvsIFAqCxmnt4i3zr3DJKcQDiv95X55DH4XNt0bC7eta?=
 =?iso-8859-1?Q?hmnGM7T+PqunNgnLWudsYjdRoFiyroiphlzJXNbv7IWHkSyVE7+YkRwQy5?=
 =?iso-8859-1?Q?2n4ADIDQlR9WT2Ch3H0EWcEl8942NVlff98NTOx06e3hEOrS4WVQP7/qTk?=
 =?iso-8859-1?Q?fcuwhOgCkDK6R0qF5kHrBGrB9Q4QmxM6WH3C7ltpWDw9Jxz44i/kkZkj0C?=
 =?iso-8859-1?Q?3L3uGXClsCd8Qkrb7vEiFsb89rO8YDO5UIENIaoxnl46CE4P20jkiif3bs?=
 =?iso-8859-1?Q?uyte5r0GxT7z6Lg+QidPJKtDRhJURDok3CbEIOARiKpDik9JWnbuCStCrL?=
 =?iso-8859-1?Q?PbGQfLWivAdecuRym6RsLbEMbC8oTUEmbEZ58K6s5j/mA3yxINjStVKYdm?=
 =?iso-8859-1?Q?RPUB8F7Itj9pZ++1fS7K4N4Kcyr7IIx3GiPdgkQ2D+JkPLp0MGDKICH0Dl?=
 =?iso-8859-1?Q?yD9fwbP+Pk0CbmhwhQj3LOMu+IiXV8cBGpoiTjvJetJRLip0KM9JaafIUw?=
 =?iso-8859-1?Q?dlrkBp5VvnjzXEKGb5rShQvCMbtOsyEnHsPtAvuFPkbkb8idR9qrLAmuCb?=
 =?iso-8859-1?Q?kmQjGj3k3lGT1n8dGfBBHxHA1+Xe8WkNz7X3wEDDc1KRUUS9cKelIbAk3i?=
 =?iso-8859-1?Q?AjG629rvJhj0tSsEW6DBhS4mlsTqFlX6x0IqXwzYyL/JckSKRZFhoG4wXM?=
 =?iso-8859-1?Q?6Gy6GWy5pzWPi1QZQDTvcsjuo2k8qF8lsFKPuP6FuK+MvGBwpJCeMkGXFA?=
 =?iso-8859-1?Q?N5lf+Bp2zwUA8NIOM3Q83uoBDaGQn+w0eBc3lmZwTK5kgtXQhBfemUKZ1M?=
 =?iso-8859-1?Q?DuU/jKrwO2KkVs3pbfqKrPL/Ef61C8AkaeSEGxmgKrGGBrB1gWLF8cdbYd?=
 =?iso-8859-1?Q?64rKP8HOCZLTDquzVPP8Xc65q129W92Z3AmaeFxin9vK/yrJT0aGHd4a6i?=
 =?iso-8859-1?Q?lXhnGMvhQ7cwsb9poMeL8k112PkO72Uv2JFliHqYEW5RJ6yPdVJSeBcI0F?=
 =?iso-8859-1?Q?zJK2ILKyXQPHjTRY58fWQnuciURx0XNIuKFHDgWy2PgB1tUEB3hn6L0Ctk?=
 =?iso-8859-1?Q?8On3Xfc7ZDLAmhzQG/YQ/8ofBgNkV7XXXk7dOUxYMuwmugrMaZK/ozZNdH?=
 =?iso-8859-1?Q?TbMaX15rmtHRIGcCuVHYU3MdF3qCy9Vv0O9qnI+G3+GgkrqTJvtAtbfu4u?=
 =?iso-8859-1?Q?WgEbNX0n2Ma1S0OM3B7u2kjZBvbpwJif0XfOpoAIgQbg9FEAvVyiUhmpug?=
 =?iso-8859-1?Q?cf4F5E5UvCw7iDIOdRafc+G6C1cbAEHvW+GVDR+xgRsweOYbxZoX90mpr2?=
 =?iso-8859-1?Q?dBl+jjUB8V/mi+fZKzgsinfAdLSCx+04xV+M3xymxYO/SwoGrYqY+47l4g?=
 =?iso-8859-1?Q?recSNR19GLLkoI+rEs0cWmyUqwAPNm8JW2A4ZzEkLAZS7f9U4fk1Oy0IAZ?=
 =?iso-8859-1?Q?2ClGrX/zow=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: raDyxq5poA4OUCfim1MHgcg4kA3NAp7vJ7LM579IC3eBJLZC6l3VOuhZpenZSRNrS97riMTjCweI2pamaJDJX3QuLmIIHrZvD04jRh5yxVZiyVUi/kovj7MksF77H29XYqpWcf/PUyoHLp8CiLWw7j1FEcbr3/7z3X82Eo7paLL9Fmz6owcqLGMZaJmAfFoCjWRFWAqdbHRLp2JEkzZKfTisRcohM7D1m9run4Cr7br+EJeYnx6JMF+cDesMHWhiqK4z1SMmfzYnmTqSw7DPRc/GhwJYZ9s1j5eFt/RvJ6xYTEFINMtR8Wbo7Ri7m2ZB3KfpoGSOt5sn3fTfPmwSKQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4369ef6b-8f97-4813-b156-08def756178c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:26.7189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5FBsF8tobbq73ln31OKwJ4VLvmhKOIhqXsGgTPQdTd+ZlJrdglAHdzC0WQiV4S0GOgXO8afKDJ+zkjZlLobSml832DTjY5iBwwpP+HktrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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

The ASPEED HACE model only emulated the hash command; the crypto (cipher)=
=0A=
command was stubbed out. On the AST2700 the kernel runs the crypto driver=
=0A=
self-tests at boot, so without crypto emulation booting floods the log=0A=
with failures:=0A=
=0A=
  root@ast2700-default:~# dmesg | grep "self"=0A=
[    6.078446] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.079295] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.089924] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.090629] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.100134] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.100416] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.100576] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.101411] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.152954] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.153701] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.180101] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.180747] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.206437] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.206910] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.215313] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.215698] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.227173] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.228027] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.276878] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
[    6.277541] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
=0A=
This series implements the HACE crypto command: AES/DES/3DES in ECB/CBC/CTR=
=0A=
over direct and scatter-gather DMA, and AES-GCM with 64-bit DMA on the=0A=
AST2700. It also adds GCM to the qcrypto cipher API (gcrypt backend) that=
=0A=
the AST2700 path needs, plus qtest and unit-test coverage.=0A=
=0A=
With crypto emulated the self-tests pass, the warnings above disappear, and=
=0A=
the temporary 'cryptomgr.notests=3D1' boot workaround in the AST2700=0A=
functional tests is dropped.=0A=
=0A=
Note: the GNUTLS crypto backend does not support AES-CTR mode.=0A=
=0A=
v1:=0A=
  1. Support the crypto command in direct access mode=0A=
  2. Support scatter-gather mode for the crypto command=0A=
  3. Support the AES-GCM mode for the crypto command=0A=
  4. Support 64-bit DMA for the crypto command=0A=
  5. Test the crypto command=0A=
  6. Drop the AST2700 crypto self-test/model workaround=0A=
=0A=
v2:=0A=
  1. Add AES-GCM to the nettle and gnutls crypto backends=0A=
  2. Skip crypto tests for cipher modes the=0A=
    compiled backend does not support, via qcrypto_cipher_supports()=0A=
  3.  Check qcrypto_cipher_supports() before running a=0A=
    crypt command and report the mode as unimplemented when the backend lac=
ks it=0A=
=0A=
v3:=0A=
  1. remove the duplicate CRYPT_IRQ_EN definition.=0A=
  2. remove the unuse CRYPT_CMD_DST_SG_CTRL definition.=0A=
  3. Drop "Drop the AST2700 crypto self-test workaround" patch because GNUT=
LS=0A=
     backend does not support AES-CTR mode.=0A=
=0A=
Jamin Lin (16):=0A=
  hw/misc/aspeed_hace: Support the crypto command in direct access mode=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2500=0A=
  hw/misc/aspeed_hace: Support scatter-gather mode for the crypto=0A=
    command=0A=
  hw/misc/aspeed_hace: Support the CTR mode for the crypto command=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2600=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST1030=0A=
  crypto/cipher: Add GCM to QCryptoCipherMode=0A=
  crypto/cipher: Add setaad/gettag for AEAD modes=0A=
  crypto/cipher-gcrypt: Implement AES-GCM=0A=
  crypto/cipher-nettle: Implement AES-GCM=0A=
  crypto/cipher-gnutls: Implement AES-GCM=0A=
  tests/unit/test-crypto-cipher: Test AES-GCM mode=0A=
  hw/misc/aspeed_hace: Support 64-bit DMA for the crypto command=0A=
  hw/misc/aspeed_hace: Support the AES-GCM mode for the crypto command=0A=
  hw/misc/aspeed_hace: Enable the crypto command on the AST2700=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2700=0A=
=0A=
 qapi/crypto.json                |   4 +-=0A=
 crypto/cipherpriv.h             |   8 +=0A=
 include/crypto/cipher.h         |  36 ++=0A=
 include/hw/misc/aspeed_hace.h   |   1 -=0A=
 tests/qtest/aspeed-hace-utils.h |  20 +=0A=
 crypto/cipher.c                 |  32 ++=0A=
 hw/misc/aspeed_hace.c           | 461 ++++++++++++++++++++-=0A=
 tests/qtest/aspeed-hace-utils.c | 693 ++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed_hace-test.c  |  18 +=0A=
 tests/qtest/ast2700-hace-test.c |   9 +=0A=
 tests/unit/test-crypto-cipher.c | 240 +++++++++++=0A=
 crypto/cipher-gcrypt.c.inc      | 101 +++++=0A=
 crypto/cipher-gnutls.c.inc      | 154 +++++++=0A=
 crypto/cipher-nettle.c.inc      | 128 ++++++=0A=
 tests/qtest/meson.build         |   6 +-=0A=
 15 files changed, 1886 insertions(+), 25 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

