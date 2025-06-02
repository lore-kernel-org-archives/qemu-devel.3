Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1C4C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4yJ-0008Bg-Hh; Mon, 02 Jun 2025 09:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4yI-0008BI-Cg; Mon, 02 Jun 2025 09:12:58 -0400
Received: from mail-westeuropeazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c201::7] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4yG-0002Ae-Dv; Mon, 02 Jun 2025 09:12:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEuL/ndXc0c5ogxLvKlfmJokORF5A/IgjXgov76jXgSPcrFZB5Zqja30XjXi/P0kRrJbaWyIK2p7677WsBqAQUvBtB1rvIObmRcyNy5lPvBiUWaTDCH80fFY9mwWigIbueqt6P3ggYkps+hpGHReJuWbKTGJl3lLLFCe97ZzH5SGTjUBkSXYo2lFLAvCWVNSvWtqiw0q9eIkffhThJoMKAnFPhQ+65U4Zo7ysGqo5WylJ5khkMwSz5RqyIXerHZ2DU4DDf2CWhcTQAFxcW7SFTR/qExFONUei5UBz+vRJJVp9GGwtrfgnsNRSd7uqkMfQOZTuNynjTAHC0YB8KxKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGZk4duOyqJzp5fe3AIs/DRlCF4z5JwpgUwAiZji148=;
 b=wYtMjFA9kpA+mTA/1NFPC5Qv+c6fnR4SZKnqJSZlc2B8SzefQmMHhg1jH1WoRQ/mgyBT3mHWGwAabNM6IttppJUTDo0UE9NBvSdDzkBL/zjvqQVRDh0Eacki6dsdzvG+YqC95kbUfc8jz3C8J+YAYR+wGhrYmfCFz9CFurhbxTYzMZTirQOtlxOm0OFNJWuyd7Tw1wJWTify5FHuMyZ6dT3721d4LhHeHIO2bA8YgEl1ZA68tBO3NplXGmL8YiFnLWhHSQkfF22+7tteb/batwK/v9vfPLRH12uoaUeLip70no7bnaNw9ENY+peB/rfBbRgpu/8imRGfTrruSQg/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGZk4duOyqJzp5fe3AIs/DRlCF4z5JwpgUwAiZji148=;
 b=fV9lSgHRCFxAsyUVkeX09iPX7qLDDSEumj+qghHIP9oVTOoYGhoEaWAT4L24m9lnR53ACrPmRvQvHmQx8zoQzBqJ3sKBqUMQatXhmUUSmKGfGQ8gUlUtfe/l3+Zei4n0re0rRxDjG8uda8EQm76JTWTOgeXf3K0WOapYbRxC3SbuxPpCxZB0lsritfbfG32gnWB5IelP5gUD16Yfyzva4r1AyZY/hJcxZ2oRwWj+UM8rnptsXGxtSDSjpBDEHqb2AKLq8+lBTvONlYhzZEa42aNKXDz9YYuC7cuGnkTFKstavuAV+KK+4ZFHyOYCYmN7jTShgTZBnncGcbBNi51A4w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAWPR09MB6728.eurprd09.prod.outlook.com (2603:10a6:102:383::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:36 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:36 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 5/9] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v2 5/9] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHb08ACyjuvNwj+a0qMVVAqhpR8wQ==
Date: Mon, 2 Jun 2025 13:12:36 +0000
Message-ID: <20250602131226.1137281-6-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAWPR09MB6728:EE_
x-ms-office365-filtering-correlation-id: c174cee1-6088-4a96-d2fb-08dda1d724ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5n33VNfgRNa9omSIJNEaYHNFciQImKUZ/dLqKBH6tNd9Iq8b/RdYsBLv3P?=
 =?iso-8859-1?Q?jhoA+J7R5DmzhOaSCFBR2EUrJinM+nRPj1lNLIo864SBKa8/ZKjf8JeUV2?=
 =?iso-8859-1?Q?tdrKaYs7Eyc4tGTWLzu0WK9C6MG3Tl4Hr+TqhjdEU7ph+FjGCB03IMcxzi?=
 =?iso-8859-1?Q?+5kLSN4iue1xKQroDW7fJRvbk7ES+Pk4pMOeRoHAlfaAKOECLB8F4tAqB8?=
 =?iso-8859-1?Q?+BJMHmnbQu5uf2BPeQDwu/HFp6aW7MughWW8An5xa6DfNcxv08JmoM9Uw0?=
 =?iso-8859-1?Q?kuLS5QfY6KDlmfwAd4kU27t+weODDl8vqQenN4NRDs52K+2fU3o0bqf+Pt?=
 =?iso-8859-1?Q?9HB3kAlaE17ct4FXSqcIrUl4zYH9rULmWcsh5cAZb1XwSRg6XmhYlQje18?=
 =?iso-8859-1?Q?aFBSDvDM7C6/DqA0ohaKfqjd0Kduqp07wO3LhfoWO+KBUKdiQmuZifMvg/?=
 =?iso-8859-1?Q?U48SNDdcCyRHrJHD2MV5DAPqf1pco8mPK2xAPSeUHu17tDiOKBVo54KyOo?=
 =?iso-8859-1?Q?m4nP6SwAosgEbnvgPU/MNxQinVzWVh4cao5nUeM7EPdv1vVtrE2id9vn07?=
 =?iso-8859-1?Q?Le42nuW2DXxfSPZOqfkNvkUjRjlctleefJI13jw2lOHtgrRwqODtHFErFS?=
 =?iso-8859-1?Q?74r9UwVQE8y7ch3YimPo4jhVDos9K2Xzygcp1aqR5X6bUQbLgssKzl1R1F?=
 =?iso-8859-1?Q?7pmdN3kb/df3mFgev4L1uNm49EZaLFD7MtgoM2SWNku2qCpeQVUNhccUg4?=
 =?iso-8859-1?Q?BYTqNKXV7B+R1ZTN5Cz3IBxjD96MdlZ+tw7PPP1INkJT6F5LJHitprSXpK?=
 =?iso-8859-1?Q?Oyl8nQ6UBXpB29mWUAniCRYpMEESxdnKaAyNP2kqr7MivY/yUt01PqqSBx?=
 =?iso-8859-1?Q?FN0ZqaX7vBG71RMQJdeVhhsIXphg9uijnewd7SUAknnfr6BPbfDZn2lrv7?=
 =?iso-8859-1?Q?Xb880xOmsY1Nde5EQReycpo4gqnG0hXIyidqYr+uc4rIIqLSzJUUE3m6Lf?=
 =?iso-8859-1?Q?uQYdn8tEUtYHW2p0pt6wgMNWF8+DBsvrB19iG+0lIZQgJL79sN4jQVh4eH?=
 =?iso-8859-1?Q?AiS9dQNal0dyDo2cO/Gu5Mvxa4XOvL4xJ0zk11t3+4WpizVBBOPiawJhge?=
 =?iso-8859-1?Q?Vt4c7wa1HVKWpqdZ3z5zqsosomY810+54+PF1IeSIR/LquIZIeojrd7sTq?=
 =?iso-8859-1?Q?yyxAfvHaYPgthpeaTFb6HO1MzdWIV+jLCk+qDy77dttjWvxcJDskkw+S3D?=
 =?iso-8859-1?Q?suAR27MEHFY8GrUOnoALZOowibjZ65sjGzBe5eWIsIR21POXDQQ/p+aZ25?=
 =?iso-8859-1?Q?hwfpPtJ9Pqv8lDzgH67ZNyvTIDqk8RJRAH56iMjjUGfZ0xgS1NZPwZgBnv?=
 =?iso-8859-1?Q?UAxKW7MeHavvgKiTVtWdfiyNgW65bUECl8a7NxqsXo2kqKnVL66toj5AOY?=
 =?iso-8859-1?Q?76eHG/2rv8qJdc22o+Y/i45u+i32tUCu+XpisOxxFrXIt/05dyjoSuXy2q?=
 =?iso-8859-1?Q?0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g5qGoLa7EfpyR/XXCjveY+ZLB9ufqqlt6TirWLk+YfiWXPioK+YN4/MqU5?=
 =?iso-8859-1?Q?3J8cFjkNkPbdf1PXfaK0AVxh2ioETtlMaLquXeiQ/JTG6GwC41+vpLqBlv?=
 =?iso-8859-1?Q?oZDgdpZQLO3HbpqReHYbUYqrC/7pGjIfNAU5xkEFVnyJXrmeI6azft8a1o?=
 =?iso-8859-1?Q?jckdTRCyaDjh5rbmbDdjg5vF1FE1z00gBgV4kOiwoO2M/C7AVe36rM4Fwd?=
 =?iso-8859-1?Q?2BRYly2BGgNjR0phpZwJBwqHxwh3aGOTB/SPIVZ/3Ksp1NWCLaLYfUFMXG?=
 =?iso-8859-1?Q?2UqMsqUK+kkDV3SY8gAZ+ihn0C7I6l7PvCH5/V9qO591x3YdMpw2IUJBVG?=
 =?iso-8859-1?Q?jem7yAqWoDQEY+OwJw/J8QijhINr+h5KwL5YImHfP+v8D8u/5tBXPfCLId?=
 =?iso-8859-1?Q?RxZ1cNE0ylzuQGuJrSB3nl3LJapfX6Gt7+u4VZrkDxzQ+3LDPu6Ls1xd8p?=
 =?iso-8859-1?Q?Ktfj05Jv8lJrmGTW+cMrgrCZ9HlG6iWr5FL7WYexgqDQlsqIzh43EHel2Q?=
 =?iso-8859-1?Q?g/r0PVNlyhsc6JE0Lb3ClH0jkay9iB+P+lcoWMbng0jq9ouYXtKmwYASCH?=
 =?iso-8859-1?Q?SHbkI/lUQiwm/I2rau3kKHox3FFU1ifm7vi7uSKejXHsCpxz8YJhFhvXM7?=
 =?iso-8859-1?Q?UJhEKe5gmsANdcixJYvB1LRhGQISTaQfMowmuq9GYM3RKWY8K+Sg4Obrvs?=
 =?iso-8859-1?Q?LFc2n9WqC38rtiX+c7CrWmiRX/1ofPf6Rcn9HfsPYbtoEla2mdW9+4b5sl?=
 =?iso-8859-1?Q?Yn0rHNsGRCHXX5/siduOq45XvW/FQNSQ8izfTZJ20S6NJMAIw444xrKczM?=
 =?iso-8859-1?Q?YwR38KHu1UfAaKH7B54CcUdkEYo+ukddWissnFStrh8PES3yWNsDJ6j4PF?=
 =?iso-8859-1?Q?KMvmGkyr+kk6JPPwEXv/fnLRXP6HIN6bbIWaS7ZvZGx6MOUU1vN9Y1wEYR?=
 =?iso-8859-1?Q?hAWLB7SuWCn8Yd+kLm6ZlpZZwUrO/tOsOjCUNO6hN1nP+l0HoskgkQPms3?=
 =?iso-8859-1?Q?gS2Nhoycwf5ip0XX+SAGY3WoogXgp+gpjLjq6mrLZPU6vsoh6YGomvgqaY?=
 =?iso-8859-1?Q?CQ5rpzUjifFMGQBOIbeoiocj+YDt/x/rgMPGgSOGJOp82nLflX+Vq0ASyc?=
 =?iso-8859-1?Q?CaZoM8KG/9OHT/gC92uJs9KrqQn6mcvIh++miKMZ/7OP2U2Fapa7fpqFi2?=
 =?iso-8859-1?Q?e6vRF0ftyNjaoq1O6L1nBEfj6PB7c1upBGtW1aeG0TzHPcrk+2RkNP96pQ?=
 =?iso-8859-1?Q?QzGNXO33XduyxeG3XbtTidEXLOA1yjv/z3No+M1iLOmiXWy6ccjUEBz3zI?=
 =?iso-8859-1?Q?qnj70R/sZ1ry3D0bNvqzAkf4Tn/wnL58kiiYqqF+L7DG08hoRZ2OAtksf2?=
 =?iso-8859-1?Q?L9LsX/7oq832HbBthsIKcr/9Tz1BLEDrifYRW1n2OT7Z/4Nli+mnR4ggJ9?=
 =?iso-8859-1?Q?USD1ThMqqvskRtlDp4oaj+T41/ZF3tJCe0lwqCOsxwKJSR09uZ4sT+Tn2/?=
 =?iso-8859-1?Q?ly+bQIxjKA4WsR+sI7ADgHxEHuIEa2I2xMTxlD7JPuicoXU8uB6fh7Tkfv?=
 =?iso-8859-1?Q?qCMqJRH9nzlABSn+bVEGH+HpoK7Uq7AAm/7FgNMBxAE6yF5Kxts3OZEV+h?=
 =?iso-8859-1?Q?wXuQ8KkrO8J3eNNEaSWkLLTDRK6JUEx9YMwqmIYa8EwCeEjfjIAb3RmMhk?=
 =?iso-8859-1?Q?TJkUNsuBJINuaeHA/Ds=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c174cee1-6088-4a96-d2fb-08dda1d724ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:36.3014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jce8E+OdrS1mSBiVvlRrf6xlRjl1TDku4a7RUyolHgwSxLsllDsKTOWgfMdWfkvKJ/rl9ZDGnXS+KZobHmcq7Y/yH0e87l9ZBo0DCGsOPe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6728
Received-SPF: pass client-ip=2a01:111:f403:c201::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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
 target/riscv/cpu_cfg.h                    |  5 +++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 39 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xmips.decode                 | 11 +++++++
 7 files changed, 63 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db2ad1c08d..f5234a620a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -242,6 +242,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempa=
ir),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
=20
     { },
 };
@@ -1360,6 +1361,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3180,6 +3182,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
 #ifndef CONFIG_USER_ONLY
         .custom_csrs =3D mips_csr_list,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
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
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 59f134a419..baedf0c466 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..5437148af1
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,39 @@
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
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
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
index 2cba1a26a7..a550599e6d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
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
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..cb334fa4bd
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
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
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

