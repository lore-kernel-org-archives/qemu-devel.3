Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BE9C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKoy-00017J-Js; Wed, 26 Feb 2025 12:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKox-00016w-B9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:43 -0500
Received: from mail-vi1eur05on2071e.outbound.protection.outlook.com
 ([2a01:111:f403:2613::71e]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKoq-0005r6-Os
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACw/AY50xbz37fYuwg6OBYZyi6UNX/3EvvTE6nmVYLAVnMEcMwSHUE8dCjN4C+NFGUxPTsQDEXxi4ap/c2Ee2DF09tCiKaXi/XsT7WTsF4zDfzTe0SzOnJ1avJDULrI4WvA//ScVCFPjCKM/3vgb2UxijFGvmadzOCGKhrb/2dGvKtb7EwS8AxVSwWac3btCokf3vMHrW0jkVsd5jlGEMk1+JBfUnEDI3GB6HuS0PEYmPw232EjBSWxaR5FYHBa4pDY2xJAygRkswJxNzP7TcbgZXMv38LpHd6wG4OOtVO8qvZLWOkd07l4pNvXbFLhlNUpkhSxpEUWpaOau5fwv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0+fVucN9sC3FZX9uNbFAGGqYwGLZ3OPIFGHBTK1mWg=;
 b=zLk5IlyGtBWGx7tcf3scdRsG+zFYkEzjsJ7Jk6/OUrjX8qEzqngP9V08lhlUwp1HiFORYsKylo3B6QRVE7/YJ1vz9sp3P7Qvs46x0kZXeUeyAqBTC/6aggOxswwKnSvbu9NHeItWJvZ1G0QzUwkvGC1heI+vHw+fwOw9UEEakeYEla80jSV1iSDn4tv3HqknmxdUhFOP3x9oZW1AtFDgUqxWNULfhtkRHxyx9TB0IVJpbEv+x6sbNrajiCoImQkmd7W1SiLtz6PS91GyY52RHWprUdH21ANw8PdX6CaTDN/lfHlGW8yJXwHtAeSz0YZuEOtMOkZN2rsBH0J7o3AiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0+fVucN9sC3FZX9uNbFAGGqYwGLZ3OPIFGHBTK1mWg=;
 b=Ljc9Psgrs3qfxI+4yAkHqHnma+nF4TzsI/C74onjvsaLFOIyfylXY6fGb4NLzDy+pUjNylcABtPBA8W0f24/nib8IKF3ZjTp4HspYJ36Hx9O4ZAE/WSp90/n04rrJmmpMkmkTMaKuz7Ld5CeEzhWs8+v7W4GVuogMnU5PnIrJQg7bf9CHZ5bbDsxdsGwvJEPjpJG404MrD1IdemZIHTIMnrJhA+bJaxKOx03dEHMqGa/cE9a7cga4zShl42CvWtmLHBN0wSAl3jPTp1VFHAEe+RI58L52q/tKw5CS1i+raAcO0evUrZC9RR/IzcxPc8e0q53UV9NLenIDbooTie+Mg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB7419.eurprd09.prod.outlook.com (2603:10a6:800:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 17:03:03 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:03:02 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Subject: [PATCH v5 0/3] Improve Mips target
Thread-Topic: [PATCH v5 0/3] Improve Mips target
Thread-Index: AQHbiHBJvA4pfGMeIki7asRyZOfO2LNZz5+A
Date: Wed, 26 Feb 2025 17:03:02 +0000
Message-ID: <20250226170246.1971355-2-aleksandar.rakic@htecgroup.com>
References: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB7419:EE_
x-ms-office365-filtering-correlation-id: 647911a2-1c75-459c-eb4a-08dd56876e65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cX0bHo3HOafG/yCtr/7h9aBusUeVbH7oUlfFnr5iAIgcWL2PPVO+aosucn?=
 =?iso-8859-1?Q?8dSApe9DIdbh1nVH/+oNabuj1bpkFxe56Gv8jmQnUk5O3fljdb6QQuP0mu?=
 =?iso-8859-1?Q?vCEwYe/YpH7fZ7tsHwZHjjt1YBxwy0xkNLn2xuugPuvYBY1PVsxn/6Ydxe?=
 =?iso-8859-1?Q?jwM42+D6FoYGY/2cgEFMrDlPN+W7Zi5bCfhD0T04HamyZ2H2JJYgp4/gWn?=
 =?iso-8859-1?Q?lCiTuYLtV8xRb9UVk29NMtoC6duVCuW+SOmp7QA7v7f+lRPp1/e+oLHMJs?=
 =?iso-8859-1?Q?ANZoapEuNfrfuuMAEb8jYJe8QEBUS7bhfOPV9E0RWYv7Ei4HoJJJunMLy1?=
 =?iso-8859-1?Q?cW9huz48s07NuwVu0htWty9FUcGy3WPmzOWYJJb98ZosiUl4PH0ufeAIB9?=
 =?iso-8859-1?Q?e23FLy6UmSoo154JodlfBNchmZiCRn9CWx/DDMNXZ4/vccc+3dWeXMXx2E?=
 =?iso-8859-1?Q?8mm8/b0kB2qYzAJKe4ykfTlG6WGzDKLwd/oO0s2onpNNFl3uO459CGl5ff?=
 =?iso-8859-1?Q?YzpiQFJQ9/NtBMP0Ce8xv61OXDyEiunSxcmgr9xB0N6n5RTeYHOgcFdqK0?=
 =?iso-8859-1?Q?Jjngv+TkPSVRsGA3evxzfKufXYr1qb8yhaiCMBU9JZGDEPe8IJjpQ7fain?=
 =?iso-8859-1?Q?QxANfLKxIMvj+kawHlxZbAkR5lCSwUhhCzwFkGOZdusEdcXk3DkHlhjl7k?=
 =?iso-8859-1?Q?9XPcMIuU1s3ecKZ5MNLIsbn9H50Kl4b46c5yfZIJGtN768jnhtH2Bh4BRT?=
 =?iso-8859-1?Q?6dtqI7188jaQ9D7DQJ+CCKSpWGnfL6v4Wl5Zp6vvAJ7pDCNxrz7E5GXhfj?=
 =?iso-8859-1?Q?SqVqV3MTnrZHuYkKRDvodinaVIoDItnoUCZ0cwJ94ikTt8KRW0uiQTzzTp?=
 =?iso-8859-1?Q?qvHU9lqZA5dYlyLKeiJn+cJO3Nqeko8m8NN0+Ws67ggEZOZ4VuUzMr/671?=
 =?iso-8859-1?Q?NgPyx9NYZ92Gd9x59AoHc83psDGKnlFfrbSlPYmytX2WHB724MDz0BNRpr?=
 =?iso-8859-1?Q?XEwl3wC9/7zBrmw+RKUf5B3slF29KJ2PxIi7unXPWckMsXxTgvko6xY1mM?=
 =?iso-8859-1?Q?bw9CjXZ+Y3lSOHlqEr+n93c9+fGvCi0bf1EUMvmA0ut9s/wLSOImVwuHGY?=
 =?iso-8859-1?Q?Yb4wql+U5lbvKA3Bo+XZxoAK1qvhF0phL1zlK8njJ8hSV9mXqlc71phzge?=
 =?iso-8859-1?Q?6diXV6YYDIvBX4AUe/a2msyc0L3++8huSHaI/oTu9lXlb6Ew2G2+t7YbKp?=
 =?iso-8859-1?Q?B+RBz1gEjlImcShJbiSZQPxEvTX6RG0KBkWn9AV487bDsqOLAEXsrAgcU+?=
 =?iso-8859-1?Q?NXZgWbLnkhyygESHuxm4iCAjgwoSSwdUODEmESdutgnzUTk8tYhWmUs9R9?=
 =?iso-8859-1?Q?gkraePq1RPNc6PQTcT7NI2G8eAywj/nzvb0fTEGUR86kMPy35gA8hS6HFr?=
 =?iso-8859-1?Q?TErvQIvnszVVCUF7kUXeGTnJDLn1yfETqgbXSt+EP6RnULChEQQNykbXoU?=
 =?iso-8859-1?Q?LdTlaSz6Tq7VRCp7yDwZyr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7ZXCGrvN9kx8K2J1hmwiLFWcGAgbCq39Vgx1WHyKKzKs+aHGATV+r6RMn4?=
 =?iso-8859-1?Q?SWpMDMvcbM9e3SuA+w2fFrnowvtlRTCNuaifypZthUZxz+vkmYJHBxXdEW?=
 =?iso-8859-1?Q?rz9MVuU6hbhFRrmUeEnuMzbeiXRssmuMoBolKDQeS5UjUuKQVLZuScpCWF?=
 =?iso-8859-1?Q?5FG9lAvxCWfhYMfRhJabnNHaa7VzGVsBFNB/mjxDjHlO5JUCPK4WAXvH8J?=
 =?iso-8859-1?Q?wEboya2EHOw0TJLQHwqexbBbN/ikYlGlFAUjnL8ptKNnrOVL5k9Ym0kzl3?=
 =?iso-8859-1?Q?lVnrh/OsbfMQNlRenAeTSe5EioNp2+FY38doWgKRRBEPEFK5cnIGV3Nhmo?=
 =?iso-8859-1?Q?x5Mvi/fxKUEfmAfBTbXl0ohjjRGXUx9otPpv4CnNvGwTtG/GVHR1Zdxp3w?=
 =?iso-8859-1?Q?55SEJjzcCnF85JfwfKhqanrAkMoFuEYUi7U2BALuSRgeGamZ5DRV1XtFyf?=
 =?iso-8859-1?Q?6FWBeb6BvamMLD8Y3JpK9KkcbiKOL8sM+nqHznInnSNd2e4g+mJDU/RoI0?=
 =?iso-8859-1?Q?kKdggl4S7hHgmhKCQf4/X4Y/DdnoT/pHnN9nxXvMi2pioIaKT+iU7gHaWH?=
 =?iso-8859-1?Q?Qz+oQK0pIoGjQ60SFhJwEzEyD70tLtZBlaYBSZM5SpumYNYAViA4tYDXTI?=
 =?iso-8859-1?Q?bvvhR4l52oXn5zcMJTtYRrG1WiB1Paqa/RlGK6y5aDrmf4MBVbT2VvYyg1?=
 =?iso-8859-1?Q?1Es42sm/gI8nKPCBTuT18R+hgwaL/YyC1/9ECaEJ75Zo/K3ygnrxJ8F5Jl?=
 =?iso-8859-1?Q?ubNPwTZoDBMZHfpWMWMFRRq4PQMnQfPp49lJnLDK/zGlh5kbvo6AOHc+cy?=
 =?iso-8859-1?Q?3AktBn3yLDgYDzJSo9gMXDiWTZOiHwSeRIhX/rOY4wKvQq/WaB3UVRw/7Y?=
 =?iso-8859-1?Q?O/aHZXwMwjrACoavZ4qwCG60utKKzrilJxp0yGco8fdv84nitD8VOXkMXN?=
 =?iso-8859-1?Q?lPJfDWSXMTn3FhHQM33ShFoOVsfITxx9NZgF6Kvd4NuRf43fpd/irbIKGh?=
 =?iso-8859-1?Q?aGP0CAvnaNtMAlk6MYptFa3gZ2CkMsWSeFMc7QfXaw2VQ0gm/Dzl2GgV8z?=
 =?iso-8859-1?Q?Ac73pUD6qs9uckYiNcw8IcniDBrJrp9RBqYETA9tmOCo0ax4BZ1ohrLFKA?=
 =?iso-8859-1?Q?6PZYOV01Ph5+oSRD+E2sLL2Nq94TC9aZwygWFJAvzc+mYB+g8V6a6mPKnK?=
 =?iso-8859-1?Q?lhglOGF1meEs82PsqVmgRALev3Wlc/p//hj52GZBMXknqm4oIR9JeiA6DP?=
 =?iso-8859-1?Q?lTFBt5XD5AzkMyKAn4VETdRfGq8x5ZOLeMoW0GIv7pynfNOPJBet11dQXf?=
 =?iso-8859-1?Q?fs+Vs4ZSgTj4TdGMfJbptxmLPP2SKbB8CYW7soHSD/v0iIzcS76g6UEd5w?=
 =?iso-8859-1?Q?V8n+OVXCpDG00XbF/Pd06VSVmeDcjJzQCKVso4SOxKUdq1bq8k9L8JsV0B?=
 =?iso-8859-1?Q?T1WrkMpQ2pnz1yDswO5aKnaPwRxpjNeXy7tfKul6qWoc5MHWK5qP00HFCA?=
 =?iso-8859-1?Q?exB85UMVZvb9W41z7zkIy+1jkaGxw89ORR8PwHv03HRv3cP4ZjXAtBGPOC?=
 =?iso-8859-1?Q?u4ShOtjFJ/X3KjhWlUJGF7Ue3vEcbtohSVNc4lOOvEsDnCz67HirLbwKUo?=
 =?iso-8859-1?Q?6lu6RGqktw+N7kljZIBuyS620pnzndChyD4oey4nSlJBqN0R21FMbg+07B?=
 =?iso-8859-1?Q?QYNXOcOn/iIAXpwkh0U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647911a2-1c75-459c-eb4a-08dd56876e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:03:02.8755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qq8NfmCOfsfs1b4quT6Cc3UhouyMV5GSrDzvIN1wia4dA1VcvKQzkejrUgT0hHKF3qA9qehnAvnaRWStk1AOYMUQysDAU8Gw23LaUuRSZpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7419
Received-SPF: pass client-ip=2a01:111:f403:2613::71e;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Aleksandar Rakic (3):
  Add support for emulation of CRC32 instructions
  Skip NaN mode check for soft-float
  target/mips: Enable MSA ASE using a CLI flag

 linux-user/mips/cpu_loop.c                    |   6 +-
 target/mips/cpu-defs.c.inc                    |  10 +-
 target/mips/cpu.c                             |  16 ++
 target/mips/cpu.h                             |   1 +
 target/mips/helper.h                          |   2 +
 target/mips/internal.h                        |   2 +-
 target/mips/meson.build                       |   1 +
 target/mips/tcg/op_helper.c                   |  27 +++
 target/mips/tcg/translate.c                   |  37 +++++
 target/mips/tcg/translate.h                   |   1 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  35 ++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  34 ++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 154 ++++++++++++++++++
 20 files changed, 1397 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2w.c

--=20
2.34.1

