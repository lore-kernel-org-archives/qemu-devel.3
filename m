Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C94EB28C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETg-0003WM-4u; Fri, 06 Feb 2026 00:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETd-0003VU-SM; Fri, 06 Feb 2026 00:33:57 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETc-0007Vv-73; Fri, 06 Feb 2026 00:33:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVv3cux2WqSAiXKWATgY3Q7Pbb5EgBEXjhs8eLNdwbBSJKLkDwCUqkNzVuEGY8eZF3OtaEKxqC8h+PWJ5CMkhbFFaUl8OeC91rCcF1SGGAjqNhSxRXaNmmNGvy086F3AgEN89c6I5LvKogECbdaazItkLfYB/+z65luC9CtW8V2EfFrr+8fYX6enmQH97VZCO/bPPpTpG6drtO94Byu2gRYJAXgpE18RKgu0KJu6I8wh36Mdsp+kLGNow9n4n1MZop2Mh4LPdeysmTlCRpTG+2pw6GOhD0l1a+iInDS8/QRYgM96EV3g8EmqrqELBySHjO8FJ3ybHffI90F3fm5KTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSrsddnDBBDs7eUNKIbSDk6Fc+hnMDe2V4bO8/Yzsow=;
 b=FAjDFLURohOqMWvNyMBmVA6MoX6RuNrN6cLQBXxUkHbnVB0oXUrwfTf7kELu+4p33j6+YzNwzco87G9b4BWnGRjgY3bqKgy8yX8WuutSWbVhDkF6fMKyZtrJq5uhqBX0sKQ7KOIyg2vZMwczPXsc9/xbANHwjKmxXQHRh6RnOsMaVv2EyRu0VthHi1LIWO+1uhqunDtYjYN170aF/5wMlwIOn2VE+NYw9Imb2EnVp+BAROHAW+wXXeIBWyonuYrTIp1t6aN1bQkAeuoDiIUYF2gJklQHpig7+rhEaevJ1qqdDCEL6O91/Suy0585atgmrycd0k3yJmhbbar+bRQeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSrsddnDBBDs7eUNKIbSDk6Fc+hnMDe2V4bO8/Yzsow=;
 b=WqjnkI5LA+xIedmnfWFJUIsMvKrzr3krt2g7H5Bzhc3T0fmZAnihmVa/in2EYpsSTct/jbU6M3zu3TtnpRfA83VR81qBG/NONtE2EdDNx9JJJTkhrRQkEL1hFHYPmF2/isbrJIHMy7MdFUiy8zNWJp4kBqFAJYyuNJ82zCv1Nh4nc4mdfqrN355yiEUbXzQ9M5e4FVJq+7ILPdQ+Wnf6iP1RduvL92u2xpcORVhxZ4qpBtLDQnM/hKcBrqPKOiGOtosCXqnNOQOQ2EOhhlovacwes+iT4ttRXPbKw8EKcaFaHomUVfq3WbG+5BXyFCebMmsvS1WEdR1H7A4JcnD3kg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:43 +0000
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
Subject: [PATCH v1 1/1] tests/functional/aarch64/test_aspeed_ast2700fc: Use
 AST2700 A2 SDK image for FC tests
Thread-Topic: [PATCH v1 1/1] tests/functional/aarch64/test_aspeed_ast2700fc:
 Use AST2700 A2 SDK image for FC tests
Thread-Index: AQHclyooWpxRFcR1vE2y+FaNdxBtUg==
Date: Fri, 6 Feb 2026 05:33:43 +0000
Message-ID: <20260206053340.3716041-3-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5504:EE_
x-ms-office365-filtering-correlation-id: a0affe6b-a519-4e96-ff58-08de65414aff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CytM9gv10gMaxpluZPxXV1J4jNanTP2yF9MOR4W3U18jvPIMZyETED2mEH?=
 =?iso-8859-1?Q?XwWjST0a5tvCISoBKRK0roWjdtQnmZZEoWkYtoaEL0Ldjodb4zWEXa1dgd?=
 =?iso-8859-1?Q?zfhHjVEECk7IIL4mazJ/J38xy3Eru7KFR2NGt9HkkA/6Dz9fEC2nhjqvDg?=
 =?iso-8859-1?Q?+8FsFfZWsnBsx5K/bf1UIh6Tdc3BVWLIxyLa9iuoW9PqQPPKtMsyW7ZedP?=
 =?iso-8859-1?Q?l9x2uOI7N5leAmZqVzM5Nb3g3vV3EKK5U7EU9kbsw9gWTheQlFZ7FQtqfd?=
 =?iso-8859-1?Q?lWQZc4lTPnqdECzSLmTbUI3o+/l0cxMv/baZ8hc2EKPTm+UKZxSLA1ELAd?=
 =?iso-8859-1?Q?jBZx8wl3gcYyNw7M+hFF/a2iSL0Th6tJI/U05681yYGGwS+Myl0omdGMld?=
 =?iso-8859-1?Q?NwHGCoxuY+w26+kgnxG4Vvxy/GaF/WN1tdPtDWky2/1LojqJqE10N4/fhs?=
 =?iso-8859-1?Q?hHbIVCv2J+m1/sq2y0C2hweRbMWJ3Jw56oJhFwArzgPpLqUFb7aHwyHGoC?=
 =?iso-8859-1?Q?NGsKcckP1XwLs7DjiQ1URKiI/2vGuZmNNK4Xj8UqbV/e/ZaLqPfNH4IPJT?=
 =?iso-8859-1?Q?XVQIHuDGj+jgW0HWa3lYLbfW59RqvJu80m+S1YrXfPznmWFaqPb3iY6B5m?=
 =?iso-8859-1?Q?nDV5Jg3CShn6muK/ZS3N7bldbT6DWORK0xMJdJgP5lTpWUXbesZ0H1uZCe?=
 =?iso-8859-1?Q?TgyeHlaBuTi4raVmCWTz3/WSoJncifYHi1HJyRpwF+PtpbV1s7Jeb59Dfk?=
 =?iso-8859-1?Q?8XucCJt+DeS9v+5ZS7mTHKwDP0gv0GKMalwR7Pzax7DrUeYwmqGEzEQk/6?=
 =?iso-8859-1?Q?sbzvsqxolBBspVjNRV2fb7fnAiQMv+7r/HbD9APCnayYa3C2w4fIGYicek?=
 =?iso-8859-1?Q?nPqcQ0QtQqUj8LY5wHyzFc91N/g7HzUhmzGXdKzZlHOrhF0g8hfU0xL6Eo?=
 =?iso-8859-1?Q?CTWDFVDu1ZTK0QjGORTu49TdePyiZE4T7fQzR95kdyVJmg1+I+qYy84Ayn?=
 =?iso-8859-1?Q?vu6e0D4BdGI1e5QQUsmWFRyS+FeofYl19xLVJ+x3oxexOmz8FqS6+ByMTL?=
 =?iso-8859-1?Q?HFZmpcqzTREsgZ2i31Smd0bXHUQeqxRGlScWBnULtCUsDnAH1RQCXsEsg3?=
 =?iso-8859-1?Q?q4vaJI+lxvLUePSCLJthVKicb1knzu1lHWPvb5Sd4nuk1TEKEcdEKdVJIG?=
 =?iso-8859-1?Q?wwW0p71KbMfJD4mQy7AuCnnL8A88uMDD6y/ZSlCs35FyhZyi5kJLsj8X8b?=
 =?iso-8859-1?Q?Bmu3IrmWJEtWHH9P0RJ7eEtNQUAkky3temjtKSrvmUkdY/C+ctrLzZ0E90?=
 =?iso-8859-1?Q?h5tmL1j80eZf9Z5ROOEJhsgwOmbv00SB8JYt9M3X6CaH0Pr1vCIhf4/f+r?=
 =?iso-8859-1?Q?8heGoOXDTyqMmvkkGXld6Kbsx+7LyB54M8rl+yQlSDEEBTpBUnLHtcN8kp?=
 =?iso-8859-1?Q?kLNsDx0r6OPDKDhC8lxAKBoEqH7STTR96/TsQaU53uTg0m6vpBJX6uepac?=
 =?iso-8859-1?Q?7IQSNNBbPyyEqkCtdRVPFZ6/8MfTNj46XqE3hnyvRccI2eT5B1yJRCM7cK?=
 =?iso-8859-1?Q?NUPI9FzzJKEjP9SK5qmRLRLSr7cZmXQzqU8t17vk9naDxH/+nBJX5w9XvL?=
 =?iso-8859-1?Q?Kf9VEHIlV2eudtIjWOL/MpHbkZwwTen6bvg2E0EmVNXJUYB5G9I45eIA?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PGFRDuu3V1gi05kFwZ8PUyTyFpAxhp8RzWXLs8xroZtFCial/r5+ngYu7i?=
 =?iso-8859-1?Q?OKwsJjt4lMZKfp89GMH8syC46w7J/u0In8/R22dUPLq0804vic+xYY2ARc?=
 =?iso-8859-1?Q?8ZfvKSTOuycdv1eFbl0XS+sB28792rDkVWxxqODBgrFOKYiXsq/CyN7guD?=
 =?iso-8859-1?Q?FPaeW+Ns7uhyevJn8msrgnoaYz66Y05j+oqnz4b6q2H9gew/6yZ/NEIYCg?=
 =?iso-8859-1?Q?bJaAgIolcXyvI9AA78r1ryrCYv8V/duB73O/zU8/B52wvSuRUO5fgvdz9X?=
 =?iso-8859-1?Q?6ZdtWimYlfUIYhTPzDGsf7eeefNdREk/OwYrw7fszx1MWa2ZeOndnd8Tqi?=
 =?iso-8859-1?Q?fiicozWlLRgmCrcKKVDlk4XG3fTLdWt3jVUmC5786c/R1ymXPx0eQl9xzi?=
 =?iso-8859-1?Q?mH8dSdoEzMCLClDe2OMZHQaboX0m/RRizXazwTAHuwgG08n0+6THSJdFS7?=
 =?iso-8859-1?Q?RDqgJKAbRq83G8pimS7YFp+G2wEjBisPKR8s5LUc5HQfrfXcXXXmIpnB4/?=
 =?iso-8859-1?Q?kuOLa6NdJhmUjtMTPkJA+K0EbhbFT5z3kELK7rfY9demyFBiEyspXPYMG3?=
 =?iso-8859-1?Q?WIIdbFG3Kro7sHneyXY9uqsZbXJTYd6DeO/gT7hXbl20Oirg1f+RBVCXca?=
 =?iso-8859-1?Q?8n0rfr4urt/MAsUfhyYQtQ30oYUcKOdIvK7uht+AUYllPFgwY7Wg69LWZ2?=
 =?iso-8859-1?Q?FfSZV/QC39w+HLBgbPqZ6CFRvqhlMHO4aa4drocSaxfy0so9y6Up0tveF9?=
 =?iso-8859-1?Q?neSNOfhDooOE2kWaEPtYAFv7nJsAjioBdMzv5pB8qa0+JC29hOwdtB9tZY?=
 =?iso-8859-1?Q?tlH/wQOCeAQ6SN36fZq99ay6MLqcFz+196RVfXwkxNPuJU2Z6VcWwAESiZ?=
 =?iso-8859-1?Q?D4ticxZJg2lSf3KiqnAxkx9CmxvNMz3wJni2nbuHcA3rhxVO5JvajXYFu8?=
 =?iso-8859-1?Q?zBLEMOERr1IKnyap8xjpEND9qTOz5UM+cYaa9hIzoKyJUVcS+Qs0Q+bH5a?=
 =?iso-8859-1?Q?WvsSHC9RsdIjh/q8NrubYALxiDQ7qRin02umz9evjzVTBW8fZTRYIOa5wJ?=
 =?iso-8859-1?Q?Wf+BtBPlMtEhjBoAEFv6V+VgWVyJA4vpKpl7o+a0NsApniowc8X0Elx8IO?=
 =?iso-8859-1?Q?ZfCDqUHg/QcBgwLz9bKNHQ1exrWtgF3oO5AbT2Kfa49rbNCA7/YMcCuCfb?=
 =?iso-8859-1?Q?00fLCHMW/Qd7ernwwKNRuAH5WO43qfkSlKtfZ+dxsIJ9WJt+jL1i9tU07P?=
 =?iso-8859-1?Q?L0y6h8hEG9BznV4IJfQvLVpqtU/OiEnFZ66VrB+BzBI/hZDfoi9c7fGVKN?=
 =?iso-8859-1?Q?71mP5cG0DnaxE3FOltnxMqLRkGFhNiQVo49/HxmjuWRqgqRg/OiiVHDohs?=
 =?iso-8859-1?Q?0RaFoppHiusAs6DNjuF4iWU7GLAzMxShooME7KGvyJcK396k1paIwBOFBJ?=
 =?iso-8859-1?Q?OwK32t+6/OYbpwQV7uyzo2YpHgSb7XDvoXmLfRT0Wrl9STB2hmFBMNAZz5?=
 =?iso-8859-1?Q?ALu7X6nFJJfWT+JgBNKarLwqUM6YoaQ7FbxeuukyAsIipgoUwvtEFBwoi7?=
 =?iso-8859-1?Q?oXdfFuGx8tI37BteYRDHRaoAaiMM3vwvwu855+vmlTj6JVZQ42n2zZQzGS?=
 =?iso-8859-1?Q?4Qtnh6IZDEwRqswFWtBQ+Ghw1BySD4xSbcpZqPzCC0Q/AO/ivchzwrMWW2?=
 =?iso-8859-1?Q?5JnrHSplHJGwmYJS3Bj4D2sVeHaGWyK5x3eHFTM2c1yvs1O2JbzdmNazH7?=
 =?iso-8859-1?Q?h2GBW95XHVDoxnnjjMbdt9Z+CzxLn0H6mBy4iCc3u/uuYlzxLxa9f9EZ+9?=
 =?iso-8859-1?Q?jyZa2RJ/UA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0affe6b-a519-4e96-ff58-08de65414aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:43.8269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRidAXyL4IS1vIYjqxRKiNZNlHwi0Rw90Lv3rqlaMwLGZTNKgPLyWQkNSwCMuuQxqgx7vvO/2Ouc2hUDAD+IJI1KEscsihZKQjpPteqbMS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5504
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

Update AST2700 FC functional tests to use the AST2700 A2 SDK v11.00 image.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700fc.py  | 16 ++++++++--------=0A=
 1 file changed, 8 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 47e56dcfc5..51ee8bc787 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -62,8 +62,8 @@ def load_ast2700fc_coprocessor(self, name):=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
     ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -98,7 +98,7 @@ def do_ast2700fc_ssp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def do_ast2700fc_tsp_test(self):=0A=
         self.vm.shutdown()=0A=
@@ -109,7 +109,7 @@ def do_ast2700fc_tsp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def start_ast2700fc_test(self, name):=0A=
         ca35_core =3D 4=0A=
@@ -153,8 +153,8 @@ def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
         self.require_netdev('user')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
@@ -164,8 +164,8 @@ def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=
=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-- =0A=
2.43.0=0A=

