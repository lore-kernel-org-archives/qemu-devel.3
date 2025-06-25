Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03567C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxJ-0006yG-Pz; Wed, 25 Jun 2025 10:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxI-0006xk-0H; Wed, 25 Jun 2025 10:18:28 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxG-00048J-CL; Wed, 25 Jun 2025 10:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPwX0lkVUvqlV+4cWejspbwEsPocin8BBwGgt4h2FI/SaEXuiIQzjUfmpk4d2EJ4a55EiaOxUOG4QH17ccXzoQoZRRkLsgo1T2CDmBT7xwqBfIDedKca6KhmAsoQZ53F3IKiJBioOYRW7ICW1wPOd0ZsDSZUf/KExjesZuWEJm1S3pwrA4GpMwFD87pi/q5jvLuyRI0atta3AV/Jw/yt82CgAgNRlGg/oKXqvRNgXjz0yPkp32oM7RU51T3g2jqIQEvy3Nf27c8mjf0UW9SdMLtTw3fqtX+8e8OyEPU6VfZpCW6JcVJuhrltvwE55+BrCwPgYUP0/aQDVAZW6lmQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEYGVvnb/qe0vUA1JPAHcR/nvKhAuQenLqIe8H2Pzks=;
 b=Q9Mk+EvIJY9d/evjImxnHJRG5wAFLK/UiUviVmOlAaboRlnv9C1j/SPKlJ1LOa8dUea2+veKgbKVZMSOIqwHx9hcFRmH2ATd4TFWW1fxJWhz5iIuyOme1UufsqTNHQJk4kxYG03cDXH/y9WswAFUBwdpxUH3myHXmpF5njJn6SCbBA5AhHOWBVV4fWjlEZEIBR5aXs/SuEGUOZ9ZbpfINWREWThy9F2voEUqbex36OvTWNSdVDZ8S0DMOeGbNPpOIwkATFSkIpHnP0meaGdy8iwgdVDn1Q22VRNrElMvthh9W3AzLnezihV/N/ap91EnsZijnXwd/SEUo1vmNDrwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEYGVvnb/qe0vUA1JPAHcR/nvKhAuQenLqIe8H2Pzks=;
 b=NQQwBT081gjB5pFF0xjk2OiE24DkiOglGhdnoIVLprcjpEalFFw/LmCirWBHFpV9z3dp5E19zoF29eKnM+a/R7ZL9971w7b6xIMWAMb6jzE7pjTS2BKyCFpMG6ClmH3MkcPmvZ59//pEyN9S6WM+SurY1F/lHqSyB20EMQnJ7qQGXDNwiFbBUVTEHpdpplE8BtTYR5KdJ+KuNmtwI6GpX+Cjdy8Kgbp5ConH2KB0qgvduOQ6q6C2dvH9RYl7/BFP88bmW1O2CPRdwaijSb3Etf7dJIhyaYrwqdDcOXRqgvpyy+ay1RNvqIZo0FmlRpt6VWh+N4Im710NuFjqiNjlUA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:18 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 02/11] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v4 02/11] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHb5dv/eo6FA03CH0m9kqdhYcCufQ==
Date: Wed, 25 Jun 2025 14:18:17 +0000
Message-ID: <20250625141732.59084-3-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: 3f9567b3-7186-45b8-27c6-08ddb3f321bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ug78G59lc0CxwSUlUhLH/uirOeR7DZX63dLubAdyys9X2eQjKjxs/Q4AFr?=
 =?iso-8859-1?Q?AddD3HIbvPv+k5BzOpJO6Fbf+sgW0wCt5D0URzX8gsrssgzUT5xGqfbSE7?=
 =?iso-8859-1?Q?oa8xWpYrQzAPQpDOWmrGMlV4J4YbVzou09NgL2aQZxpXeNCnme7Y7O8R0C?=
 =?iso-8859-1?Q?R9o+J6sbDzC0xz3vMYR4XlYXnnltosgT0OWqM2luiOd43OTkuHHdgmCo7h?=
 =?iso-8859-1?Q?07UW+PPuIDgchIHaLw7IUqK34sg/0LcjMUF2CSNYciOpekI6WM6mX83tCD?=
 =?iso-8859-1?Q?XCFDfIVXpKEaqJ3KyQxkW2c45IbGUlsH7l9U7Zxzc6wDQ67pFpLsdfvdpR?=
 =?iso-8859-1?Q?RGelSXV3mumTe8WpaHYb7W/BIMPtvawogRy2l41tea8UNPtW7FRCreztvr?=
 =?iso-8859-1?Q?tdkWoS2IDA1LNWkpyDz293t0a8Wnve/rBlF5a/O3c/82gE5kWYih30sJqv?=
 =?iso-8859-1?Q?+2myUlsFXTZqavZzfiYC2CjdvwrdgB4kLnErHtCQ27xseZ/XFI/0ULIq2+?=
 =?iso-8859-1?Q?9wNiHREEse5gDBP3dzvnHiAT4QK6De4uDas5ipN90uoYwTlFtUfC9U85in?=
 =?iso-8859-1?Q?itaFY07fNfkFB9VH14LqcIQegfi28EQwrKuHAA3+nr/E6UTE75SB/vUOBH?=
 =?iso-8859-1?Q?V0D5bKaXsVLE9qc5tqaCCJFppNw7YTBZhsRs/dX8FT16jeaKjNfEg0lleI?=
 =?iso-8859-1?Q?9TxO37vsopXaypuJU7mEXBmRtCXnpytYlYIQwjBIlmG/ig/WUKpDemFyYf?=
 =?iso-8859-1?Q?NNxoONiRMyvb40fCDNGXwVq3ODP6toVzQGD670ywWhO3pPkQAPLhUFjgEX?=
 =?iso-8859-1?Q?YAbAoyewWaCv/N8uZoEcdM5BZjLdR50RJC0lLe21Cg74CV8SqwN7Zl6wot?=
 =?iso-8859-1?Q?72e3SZF50/vyie+5pJisxAD3rp10pnNCCWNznQNfQnvcCk3Mf+trv/hbLC?=
 =?iso-8859-1?Q?dKNB/UTIbTVObgmjXl7OLb3X0E4n0KbfWTil6oNw3gD1F5MWlP/wfoXuoo?=
 =?iso-8859-1?Q?uBhn+jKJ8GlrxT9SCBGPWC67Qmu4y4nhhwUSx5ckd12bJCGZvfkT3DXzWJ?=
 =?iso-8859-1?Q?7LcbgxBkz8YCeDJd/LotGvhN+N7A6H+7LltoGWDRkYFVUVlmk75EXRZfxG?=
 =?iso-8859-1?Q?D0LBTkUYwvKwHxzH+Kr5wzMq9WsmqcRepa1gbCbAte0mYI9Ev6bewYI3cX?=
 =?iso-8859-1?Q?wenO885+sIErcfMeAvIdThTZQ1Lbn6AORIB/lI8Q0bpvuHqB0ZD/dVTYE+?=
 =?iso-8859-1?Q?d2+WjGz64V50eljUG98vidKTofJFZPdcuCBWOIxAt0aVY2V0S0RLmx0OuG?=
 =?iso-8859-1?Q?RlIgokISXNE3YFsb61V4E6kRdTBZT+HFNgFo1YUtxGlRJZ77nOM+sCTagU?=
 =?iso-8859-1?Q?r8nPI5OBRWGlNt9XEKIlh4iQ/L0p7fP+gwULXnYXrI91dZHiPKHKOKscp/?=
 =?iso-8859-1?Q?K7CZX/Ly7Bz8VOEVdzFsA27hLQHCEvpIc2NiVLqwwECXJtpJbxk0dtDjNk?=
 =?iso-8859-1?Q?pHN3vqga+aftWdRIHNuWqjrLVunsF2mUOzpdo71ahEHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1x1G2saIDnhgK0xe0sC55sf/REtjNMHn3SfhJD+8HCn2GzTTsuLR034qW8?=
 =?iso-8859-1?Q?vPIpihfXDc/GqEQhysK/KEfz1CXP15PSQ1qnbTqPJXVYL1GCA+BbzY/FMq?=
 =?iso-8859-1?Q?cYdD9fYELTkCherkJizhaDTzQzlFP1Yt1noMLseZDlb7RSYwMS6Re47UL8?=
 =?iso-8859-1?Q?A+S9zKK4mKKLgCKN8IwNOoDJla0PDjBWJ+QxTnsCo0F/BB2aDorehVnMJv?=
 =?iso-8859-1?Q?6/+8iGDVqVv2/9ws5dIwhmK2c4Fmjfh4vhxNqI0aLXbmHuk1YKTUe96bH9?=
 =?iso-8859-1?Q?WWXTCPUS8qvasO9AJp0CIX+0CzD4t6ZWUG63MfrfaibnF8xV5VaBEyHrjC?=
 =?iso-8859-1?Q?KIezd9wLAZcKf9/Gxw4/W0g9sJGVH17l1FcFKxOB/PSAAv8VRcJkQoRKVn?=
 =?iso-8859-1?Q?9XARlSIGY51mTC3OQGtADVBGNYvju4/T8/ZRAKE4h5MPCoA7Z3nsBEZtf6?=
 =?iso-8859-1?Q?DFUyg/F3x5RHqGi0rsyfRb463eXup0aw1uVf+JOKGw6FO3NcRo32/AkHzm?=
 =?iso-8859-1?Q?sZeHWr+OjSpNSnnUcN45tQzpuCnAODxXmZtXue5l4swxaZr+Ice9svegg9?=
 =?iso-8859-1?Q?uE5YCGvVC1r9XffIFE4aDk8ktFkyxNWGV9zuwLBbRWMno6umAji0FooY6Y?=
 =?iso-8859-1?Q?rQPKfmbfhjv34Gz7leRzZ8Ejw2aX8pD986MTrD52oCzl3iArIiL9fEIBYD?=
 =?iso-8859-1?Q?Sjf1JurUh39gqPTluOTeailt1xYbkoKqnjiITFpSiTfC8t2wbCJCPw4yO+?=
 =?iso-8859-1?Q?JS1vUBwxRUjmWRV9tzhwTDMbV+R3DR6C6S3jx6wUGzYE6j984fXvo5M5YK?=
 =?iso-8859-1?Q?sUfBLl+PvorZR0zDapgoKSqF96HexiuVftLOeB9xlfsPE499gHI76LrOLz?=
 =?iso-8859-1?Q?+G0b+4+Cqp5otLMheo3fAiOyDPO6yuSepjQhkCR9jRTIUzNYHi0s7a5CEd?=
 =?iso-8859-1?Q?5Kfo5eDVwsP61e68g5q7Q08yFAOM6VJy52BuYCbkc467ionOMn9WjRF73G?=
 =?iso-8859-1?Q?BUQ8JD4ep5drKW5zsHNJj6ZtioiPZOtE1itQ5u/e3AiMYOu2HXF8ICLKiO?=
 =?iso-8859-1?Q?/Y1ux7HL89Uz/4zaVnTr+pMZ39Ali1B1f2wQ5kPmmN4B+lDDkxrTzufPRW?=
 =?iso-8859-1?Q?uzX4GEqkvo5luM6r0Lnt0+n3VLlrdLfDxxObE1TPFMRAJ9KozQOtjImsri?=
 =?iso-8859-1?Q?mlK4b1JdIRpwEsM3U7M4aOCdfOrLF5QPIWhURlMGN8VWkuef4L25O4Uyzd?=
 =?iso-8859-1?Q?B0AVMkKo0pd5Y7BCRpPHjyjyd3GLFpjZ1aE0Dam/pqOJII6GMBc0k/JDsd?=
 =?iso-8859-1?Q?la+cgZgZrYquUeK6Hy2Q1gxDgMVNKT3s7fbLrVl4TJL2GjIINTeItn0d6K?=
 =?iso-8859-1?Q?eHb6Bx035qQtii57mMI3V22USQ9gpwWtW8V0gH0g3ITtnFdixzuWKOg0oE?=
 =?iso-8859-1?Q?tuEH1kPLd1fw02eRv+4ClGBGgao2H4UHgr3KuUFYvgsCzOWVjm2xdfPUP5?=
 =?iso-8859-1?Q?3QtyXv7mOP3d20qRsnmsE2/sWC1glyOZrdSMkyvaIPBbIlch/63wEpzn/6?=
 =?iso-8859-1?Q?zU3np5YL6rb+ykumC+/gAfTChYhO0IKExgZsynhh+3VehRAYVGqxdyi65f?=
 =?iso-8859-1?Q?qnoQ7rYb6uTkCln5upPNIXsJ1YtWGW/V56kOI5ealUvex2tj/ercPGSiPy?=
 =?iso-8859-1?Q?ekSDI0Bookf1q5dC3l8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9567b3-7186-45b8-27c6-08ddb3f321bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:18.0239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoIEj1ZkkJX2zGS7DTedPtKVHuuh7juvRm1CrsLlg5ino1Q+l451VfOxfq+tiq2DhlgqavA6drxVM0xnqRTuw2w964bR56Sdw5XZTypFT20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.h       | 4 ++++
 target/riscv/translate.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 229ade9ed9..fba0b0506b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -656,6 +656,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
nv,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d7a6de02df..c3fbae7cfe 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1427,3 +1427,11 @@ void riscv_translate_init(void)
     load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_=
val),
                              "load_val");
 }
+
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    RISCVCPU *vp =3D RISCV_CPU(qemu_get_cpu(vp_index));
+    vp->env.resetvec =3D address;
+}
+#endif
--=20
2.34.1

