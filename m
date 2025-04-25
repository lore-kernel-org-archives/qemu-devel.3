Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204CDC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jft-0004Dr-0M; Fri, 25 Apr 2025 10:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hkx-0001a2-SS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:11 -0400
Received: from mail-vi1eur05on20702.outbound.protection.outlook.com
 ([2a01:111:f403:2613::702]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hks-0001Mx-To
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8mOovwbzXYpL/dADdVgzpdTeGHoFTk9iTtJEOkx9KJYk69YNnkpVkVzSrAt0gZfIa+AQoMP6as7MxEpSav1n7AeulFVlWQWBU9wClFt5QFBv9pUV2V2CbqyfJtGBcip2yyEkTVp69LrRkuxs11TxHJVoHOvvJzVWSIAzQyk+60vvoyu5q6hSu0tOZzLuqh+pPSFXcFbDqB5g88yegRDINsLCGQEoBAxLAHyl7fNCQPVllG7yfV8Q3AhC1VuJD8AAah8+Pkp6ppIIFv7RpqGfjVCewxz+uwP9dImWVskoQMA2xeoNKAo6R79fRt0EqpWoNbBr7yaoubtzwF8WZEFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDeZFIwR8xukKZRCACKs0kzuEFtjltylzaCo5Ohw010=;
 b=hlOHBAM0GPqGW+UOhczRBJPpCxn3gBYdS/metH7lS2LzBXAkpY8mA28K/DgUfXX6Di7bfzRMr9jbYZ+JW2i7feGWKvgLZj3h78aSQrq64xw3hb68TEzLLayvjCJUnTRzQTKisM4ruDAWiTIf+frNCV1mMShNn3OWD/DICKmUV+BvLSpNfhRukEEqvehQ6S8yGOj1ozCp45btPdzcaW5E3sEXYXlnmDWHCicPMgXHa6JlVDEQIQpDuXYef/n6x3keZs6IWttPEunkW8mmC/Qxmzm+fE0jNvorBwzBFh8o9fwe+e2SB1llE1xKfPycamnGLxo8p7Z2TMnbJ2rOs9Cczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDeZFIwR8xukKZRCACKs0kzuEFtjltylzaCo5Ohw010=;
 b=JYIFlnzay8A0/kP5nLER4YqOjH/pPBK/BPQZ6RnXApLM5y247h8gXanEhMzi25JXdKAXIwouo68lqKNVWYxCrFCHz6PefrROgY1KBC9bXhKt74x4bca92gt5y2uOf0fzprdvIGWSl+wY+9N3VmAajxZPBKuCO01/w3nmFKqp9w+VYw6rDp4qxE0Aqc0RIERir2gQjrFwZB+yNWcKR1e5WvFRhTClslvscmIh4KgtU7+kkladU3/k5H0rD81ckoxyO9+oEdtlz+0WOileTpHwwYTPX9IgcgmvqEvyuLyQXcOYML49rcwbJfcWvd3bjjLutneBtSKpm7O2wKE1nQ5eqg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3713.eurprd09.prod.outlook.com (2603:10a6:208:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 12:01:45 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:45 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 5/9] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH 5/9] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHbtdnQufFP2rHMS0iUoaYL1e7RkA==
Date: Fri, 25 Apr 2025 12:01:45 +0000
Message-ID: <20250425115912.912889-6-djordje.todorovic@htecgroup.com>
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3713:EE_
x-ms-office365-filtering-correlation-id: 0db595ef-01ec-4037-54e6-08dd83f0f356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2aP1Cmjo7Y388NRkQqejD/D0bQ7texOlblKrqOooizSwxJHESgICbb3Pzs?=
 =?iso-8859-1?Q?c9nZQZ3c74wBMnazdnb3TAkTEU2Z1+KzBtKwFYsWDRBhPaYdGFFgu/OC/i?=
 =?iso-8859-1?Q?Znx7dkxfQs5Pn7JdInsbQ17JlSKoXaJA+KaalsleigFiMUvHZ+1TVwHi2/?=
 =?iso-8859-1?Q?lMI9MXlM8/HqbMVDNQcXnnlNKRbv3lY+TH+JkjBqrWsQqzhMwP/aYELUCc?=
 =?iso-8859-1?Q?oLxElwF1GNU+RaQ6+oDQfYXiBXCTpGH62ejR0H7yewizw6S636Burb8fJj?=
 =?iso-8859-1?Q?V2a3zLfveCootdRwPx8VwDQRlqpCo4w1yNMfZEcUvOuLZv6tP24XFH9Cyb?=
 =?iso-8859-1?Q?60XGZeZI5lVqCXo4vv8vl+RQQVVQE3gg1F/znP9mE6gtVAfX7HNdQtROXE?=
 =?iso-8859-1?Q?IoAUpw3yTp8BrZdJf2LnNUSAokrJfhcW7dfkl3+THlhLyIhvRh8ERYijuj?=
 =?iso-8859-1?Q?FwhW6efWRUSjLW7csnN2WLSCjpwtWooSHlYGVZBrvlWvXun8/RUHWu4jbj?=
 =?iso-8859-1?Q?yfZFvJMeITpOjLXGaBi6V+L3OTw5is9ALnJSSP8uINFIUkSvLNB/88tbsP?=
 =?iso-8859-1?Q?XL6/NPJ7seKmyroUdzyXtcGWkpHmC/pEblQSzO1p2PdM46zl4hqGKxAAx+?=
 =?iso-8859-1?Q?GAT7ufsLXRwe02KcTLdiDqqe3sw5o1njx4fwFWQGJjs8PvcH0/YAE08jhf?=
 =?iso-8859-1?Q?e5e6/ma7JTzhFviqe5sCOoOZ1K3egXZSgXeBnis6EQR/viOL+y+X7bdTOr?=
 =?iso-8859-1?Q?vmVYCU9LUJJiBH4ncqMcUP1GlarJUwovPH74lNF+a7Hzo+ErkrcahTNxqt?=
 =?iso-8859-1?Q?aea6pJGerxqC5c+jxlSy+YG0KmP1htAmdpLEk/Joch9sWb72Hv+wd2rgWO?=
 =?iso-8859-1?Q?Ml4YhqPhMzByImmdrIJ1BYOje8oE0g2GhtR//1aN+bs7fazk4Os3hPMFQx?=
 =?iso-8859-1?Q?IxSPAXm93oW8QpRB8gvduP1qztbCwRDHw5HwJCD8wTtfunhVJsxCFLU40q?=
 =?iso-8859-1?Q?v3082GPUouKimHCQ3BZgCQLwnSNWCWla+wH+D7z4DUZsV+DzN5KfgKUrY/?=
 =?iso-8859-1?Q?3WCItqs/X5nuu9l/UzOE5QgLFOswRryOHxjQIzusbXXreqA4jN2EYY2kUb?=
 =?iso-8859-1?Q?s+kK2eN60EbqTecXar47K1nPmN84NZr5GHZuX8HmZKyJjX9449xYcdD0Jz?=
 =?iso-8859-1?Q?mjq6SsTmqR0TEUSPYEv4+PkJju61FmQOi7r1pkECXCqxmPZ4TdchR+gar1?=
 =?iso-8859-1?Q?wFqAM7PikW3hIgv/PnWGrH25hbyRfkStWEsbbWedPvmFLiVYlzNLo8HSxk?=
 =?iso-8859-1?Q?6B0TbbfNfVPc08AlYDV6/ve4gNxY9erwnyYvzoXpjQ1X0ZDMyVyy39A6yq?=
 =?iso-8859-1?Q?yby0xftnME5gkr+9AKQD+PTe1k7/yLsmSEtido+Ep0dbUkGRI6AlclWy3O?=
 =?iso-8859-1?Q?JVdWKL4rFjycQK8TP2SMnrrgu20MbKZ8U3bRNH7yYbOjY8NjlqtWCMTboW?=
 =?iso-8859-1?Q?0VZOctE95EPahLiifqP9PI7duMEoMog52KpdP4sEpKy1kePpEL6iFtfljb?=
 =?iso-8859-1?Q?JBzhp7Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U9WjmK6+2tYeY2bNz9KS0CK+OgXKUJIINXcVS9jPAFtJ3Pw2ktHcd6tT7+?=
 =?iso-8859-1?Q?2wbLX6AhMIvQNKtpSBpCynMaGznuLDUv3CdfYx0luui6CabMCEdfmddIMU?=
 =?iso-8859-1?Q?352keP7j2w2uuPkNkWgQd283M+pQC/dhTzlDoRlaO3/yzr0CaIZfJxwaxD?=
 =?iso-8859-1?Q?BuAHUuHO5XC+suWYmGNc8Lr7dAEzS+RdXWTmvh/1iLyIgjXLe9jYn0JxQ2?=
 =?iso-8859-1?Q?vw5Ztm4l2WMlI7qHlu86WurPCYnUIwuy85FpsnQ+Mp0hV16ourB+vw4wUT?=
 =?iso-8859-1?Q?+eD6pnq4HY9lSalYZrlSsZcn2mRBKulKnrvOWdb0CghvQWAKW4Q0Bx6yYk?=
 =?iso-8859-1?Q?IRPig/EminFT46kueb2avcI4fM27C8C7x4J6Ifiel+0YRREkArbdiLwqs6?=
 =?iso-8859-1?Q?VHhfFwCHTpfMk2hyAXzpcLkcw60FCN9W9iuPORlxIi0Oq1SVyWJPWo2ptX?=
 =?iso-8859-1?Q?iEwpKdTWJxHOV1xdh4+SNesQU9Bd6VFRBxUrl5XDdOqov5F3gxqR0Z1HPg?=
 =?iso-8859-1?Q?Ez66NKXHlkSEKj2D1/wBE3XNhDovj2C6QZTPcKpqHxuQOBhYYTLlVKjUvF?=
 =?iso-8859-1?Q?QSAoHZc/qeV97B13PoYU+2MRVOIWNFJz3KyYbgGcA6CMJN8zMLCq/rHPWJ?=
 =?iso-8859-1?Q?5vCtx7Zextx/y5OzI6QMjNDlXiOCqPMu1Pi3E/KC4HtQsBH05fs3wPHuEQ?=
 =?iso-8859-1?Q?Pf4lSb4Z+dQyZ6toe5mPsGGqbgO3qKOyaYHVY12egNmgxOlvI7/LWAzB+J?=
 =?iso-8859-1?Q?BEeLfABLCbJN5X5YnH8bDtvauoMT7D04/YHC/kBSjmnSTWx0JwGSQa3YrO?=
 =?iso-8859-1?Q?muGeQAb0Bu02HWNODrVrKyc9SVF3VRtBnAAGipsw+xVMjMd9tofZn1/ELz?=
 =?iso-8859-1?Q?q5JRYShqr5xFU42vK2oWw5htPR4YV9xzFqwWRg8aVVp4WFO4Sp9hkWGKKx?=
 =?iso-8859-1?Q?hwI/jOkGnK/yB1iKJ5FuTwAOdR2z8kD0IGyZwYb7hh0205hfF/tsOzxW0C?=
 =?iso-8859-1?Q?H+uRRsgR/B9RPyo2SHttXuA6z/AMeZx41RXjVl9FtPTLsrNfKgK7llQSZ1?=
 =?iso-8859-1?Q?qwGmOszPte/dfa8J8lQEKsfbZfUlqb21NzwSoamTPF1QVzvJEeerzeVYNN?=
 =?iso-8859-1?Q?14gMcLNELFebTwQLi+tLbJ1kL8xgNf1TOptQE19+I+4FMJhF1ybU6RQbfZ?=
 =?iso-8859-1?Q?wusxevVM3wiPPv0gZomg0bLObfzWwjr+R3TSxQEliabbs4Tn4ON7kFH84C?=
 =?iso-8859-1?Q?wTDQm7iSjLyhEhmupNBPmrcXSwL8lL4G475FGJpYVqYS3D2F3qC1bS1HiX?=
 =?iso-8859-1?Q?sjA/Ute9Knq3LDv68+ikkbLwRl3xu3tzphpDSBN0UeoJC3jiwKAYbGXU8a?=
 =?iso-8859-1?Q?OVJmKoUdWGoknTbU4uOc1rH/PydXPwutehk6ROpNWnLHmB6JC1xFXJdPIM?=
 =?iso-8859-1?Q?IfyWv2dQ9qRQpD1WyCyaLqLy5gyKMuESFEaokSJxkRUWq2RCtzlDvgaJmc?=
 =?iso-8859-1?Q?5OKTpxZxiLvFri/a7setE2CuJo8zQ6iEARXjfTCc+AtjBk+x99VUk6uJuP?=
 =?iso-8859-1?Q?ham3DA5Ol5LtK68icWWlK5FQRRRNzliO4yGbe0eBdJ4+MEWLh0EFGSEcu3?=
 =?iso-8859-1?Q?PCv8eIekfKZgadhmxLWcvFGCAnqzS/ZLkAx82vhVPv6kR3GGSNRS9u6sSc?=
 =?iso-8859-1?Q?NUTdyth998uBZJFWD/o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db595ef-01ec-4037-54e6-08dd83f0f356
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:45.1030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmljnvzE/5dDi0oduMbnKS+cGisIwWjzpQeULjnFE4WP74JxzUFohiUUxP423gqTp/SIexUDkxkrViqC9qzMbBtVo0rKTyPrWAoXJWfFeFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3713
Received-SPF: pass client-ip=2a01:111:f403:2613::702;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 ++
 target/riscv/cpu_cfg.h                    |  6 ++++
 target/riscv/insn_trans/trans_xmips.c.inc | 38 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xmips.decode                 | 23 ++++++++++++++
 6 files changed, 74 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d22c1baf09..6d866253f5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -236,6 +236,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempa=
ir),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
=20
     { },
 };
@@ -540,6 +541,7 @@ static void rv64_mips_p8700_cpu_init(Object *obj)
     cpu->cfg.pmp =3D true;
     cpu->cfg.ext_zba =3D true;
     cpu->cfg.ext_zbb =3D true;
+    cpu->cfg.ext_xmipscmov =3D true;
     cpu->cfg.marchid =3D 0x8000000000000201;
 }
=20
@@ -1756,6 +1758,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc..e6cce7fdf8 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -182,6 +182,7 @@ struct RISCVCPUConfig {
     bool ext_xtheadmempair;
     bool ext_xtheadsync;
     bool ext_XVentanaCondOps;
+    bool ext_xmipscmov;
=20
     uint32_t pmu_mask;
     uint16_t vlenb;
@@ -210,6 +211,11 @@ static inline bool always_true_p(const RISCVCPUConfig =
*cfg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..a555c94e23
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,38 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2.1 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd], source2, zero, source1=
, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fbb6c8fb45..26cd11ec00 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2b8ddd184f..0dcb9c0a49 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1195,8 +1195,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1217,6 +1219,7 @@ static inline int insn_len(uint16_t first_word)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..94d37c10ae
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,23 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+
+# Argument sets
+
+# Formats
+@r4      ..... ..  ..... ..... ... ..... ....... %rs3 %rs2 %rs1 %rd
+
+# *** RV64 MIPS Extension ***
+ccmov       .....11  ..... ..... 011 .....  0001011 @r4
--=20
2.34.1

