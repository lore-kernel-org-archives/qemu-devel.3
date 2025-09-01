Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E7CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n3-0003xX-Mf; Mon, 01 Sep 2025 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mu-0003u9-Sg; Mon, 01 Sep 2025 06:29:25 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mq-0005Km-PC; Mon, 01 Sep 2025 06:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEQmHCljq+gwW6cHIZNsmC01Z8HoY1SnSJErbh/qWxaa6sbUbpeTk02KPge/PbMvQxroauAaHY3+qJy+WDKf7CAZ0TeLa4o/C5oCzNlmlPIaM7ctaMm8NPTtrvWIiRA4fwb/5hiZskN2PlxtX2SLBaIArIs0WZnWYTD9C7T+Rd6gkPq44ExqRPY6dES18QREVxgNMjthFmwnbmkTa3HquG4BcOW9lM1RAGmLd0bDpCs4g6INoTthlejt7p2TRv+g4W0MrAuheMe1c3GuMRIt5M6ZcY7jCvPuKvAjFAUTPKUx/yiewTyisHSzi9LGQ1Ret5ahsl1wN97+3N+SRNhWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pszKEsWnAITSRAPBs1Yh5OKeV46UV+lzqPfrrt/QYcw=;
 b=tHHmEql2pdEQsIFZDZaT95kx/nXTjGdbHc/CE2vXilXRfnRzkCI7iFmIOQKd1GIZlGNYxGQhZ9gbAxaNVBLb0WR+4gaplIlromtscp12pf6ai11N9DbkiNWTUUHXJ6la/DuyBsxywu67c1mVNSBRJasewO9M0VU/aCFggGDE3ur1mWv+YlyK95mN5QrmC7ubziEcA+jbdnHZCAwRZdP4oRvMIT3dvQYEc9qsnv801Di6qGtkxARqwLdqrN1+hVxgI7skBcR14JtKWd+0Iho2/07oed3F6vZJfnvJCNeHOxFalnxDVVrjblxqRaPBZQPmfgrZx9RpLHfxdPMeku8nEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pszKEsWnAITSRAPBs1Yh5OKeV46UV+lzqPfrrt/QYcw=;
 b=pLO65yMwZdLMD7JZed0lDuOcatp8qDApOHJ65FQiZ/2HjxdzbCyFTxFuoiinlzbdcUUeZ0q8KpCfYdf2xwbZvOPD1hlR7G1tnghQxzUk8yGZT4NmpPU944R+w9mC4GtScdBlH6yr6ZaK828AdT/ifdxr/4RelEVdZwmHsY0/ysvS8Ks1jUDNIFBo3mHeBv7rVnYACZSRjTScaeQDf7imcNmNI+iRx72Cfj3PnIXp0pNUoGRE6pVK6nTSsUxKu1SguzZDa4sSH4NK9LWN1+4bRdLelsqRoYM84otSQmySr7koMkngAE+nJBJzFeTj5RZ/XpRIqr4EdMIyOqGrZT+V1A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6894.eurprd09.prod.outlook.com (2603:10a6:150:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:04 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:04 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v7 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcGys8Klg4nakYSUWO+0bMvmC/nA==
Date: Mon, 1 Sep 2025 10:29:02 +0000
Message-ID: <20250901102850.1172983-5-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6894:EE_
x-ms-office365-filtering-correlation-id: fa72d170-fcf1-424e-853a-08dde9426007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DECzePJawUW2Xtv3rVGyjJb4b2c4yKK4LJB/M/iqMccZZLq3foM5Xb5ub8?=
 =?iso-8859-1?Q?yOcq2IfXcHVQi9LhA/z8lcfsy4jtP6PkAdIaIFPh5e5kjq2Fo866GKA5wo?=
 =?iso-8859-1?Q?1L24P/9yqm8Xw6lwOrDU3kTf2rQ2yk7IMpiUknThwtSgshirXOPa6kgiQj?=
 =?iso-8859-1?Q?1vUBCP7zrDftID0lYPW3XZrxAURa1Pat/z4636T2sxz/dssfyabjsQRUcG?=
 =?iso-8859-1?Q?SA6nwFo1zHm60WNmPVRwWiQdlJXkhuCc7pWg2Q3WKbASqVk/SMzajf6RlG?=
 =?iso-8859-1?Q?14+rBeZG+p+k15l+sC6F1h7tXCKSbp4Vd7wJuBXipQue5bGK4nHvFC7nW4?=
 =?iso-8859-1?Q?Et3Fay4XkT/kziYw57IgCH/lWSVB8NJyaAhVi7vXqHcxufQJ2ObAdtJNTF?=
 =?iso-8859-1?Q?axzFU+hWw2poscy/GGsxbm89kULHV0a1vkjyOmj7KhfE2aJSlLpqrsgxo+?=
 =?iso-8859-1?Q?kEfaRRWd+3tLN9qS5EvELj4/xAHv5ELc85E/evO7zVVmh5NXgt7W4V5wph?=
 =?iso-8859-1?Q?BLNRT2XJ77aLgKkxRDLwQtNiy6967JWQ0uiuLNyC5sI2VIaojwHD9+stlw?=
 =?iso-8859-1?Q?D+HdvE/hMc379KbxKr1zJjHVFCb7Zzu/gdNqInN4FyX39/KLm+P2J+UY0s?=
 =?iso-8859-1?Q?snnSP+rT8a4+omw1+mhJe6BGlm6T/zJedXc9a1oMgx46CBoiRVBEdSaggK?=
 =?iso-8859-1?Q?FbK1Fblaa9dGOjW8+gffjBQHyQNoR1e9walZVS/h0FPX13OEV81qlgnBRX?=
 =?iso-8859-1?Q?RyLqKQLpblUi1HkD02ArHuSyME6GebrGuAAPgV7i49C6IibTXV2+1qiLk0?=
 =?iso-8859-1?Q?UkzEeFRtacfEfK65PhyNLPWqSR7RNU0YSfiso/73lexUCFWTiQPCAgZ3cL?=
 =?iso-8859-1?Q?LJHmkAt6kEDXIUqZ/Y8R3RFMXqCHYaW3nh3hCL7WAxCYtO9ieXJneL6c+w?=
 =?iso-8859-1?Q?JF5CPOeWr7dXTdyDji3oMMS6RU3+8fo1H2lbmo/0oxTN7tcqcob+RIFrx1?=
 =?iso-8859-1?Q?xwgg+GxIufatcS+2DAjesUNUN+yrh/ABbDPo4deo6p8E0mdO5R7rGUa6dj?=
 =?iso-8859-1?Q?PA3fYN5HV+PvRmxcfwE9r9CWVgd0WhRNDpJ1Bh7rO2Y9AaKuSWYh5/29Jk?=
 =?iso-8859-1?Q?3NarXcNpSsFgSYVFc2FkeFO1EPYJjra5tF+aCYifp/xSbZPdKJiTnJM2H9?=
 =?iso-8859-1?Q?5wS7/TLrZoXAc7pmxEQDKYFsB0XH3Nu2/JWJLt1sDVzQhafobq4FwJ6S6J?=
 =?iso-8859-1?Q?T4WiHnSAkrHA9rx4YWD4Gu+hzuguzQ2S6z7FBBdzfwWO1U3AP5VAIg9V1m?=
 =?iso-8859-1?Q?eU359jJe295Utss1Ez05pcjxOcj5YVnZArxP8GVPysKOWKShfb6wmM6Rkp?=
 =?iso-8859-1?Q?NVJrjAQflcl74H4w9iKwHn3tGCIQkCfkVHF8K3o3HnWXUDeEAOu/bqYV8M?=
 =?iso-8859-1?Q?GFXdoQGaUc8DhlCCtBxFlCtAtG5krh3TzbI6F4pxbKZxWIWT2PRHw8DsKA?=
 =?iso-8859-1?Q?h5XaGTZHjkKcyAKjaRGrVJQm+62Y8HcjXoEPlgl+EPrNc37G2uggdw3xdG?=
 =?iso-8859-1?Q?e6Q8R4c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uc/r3Xf/R8u0LWa/8mWNTwtoRRkhMJpIesLPvOc0A0VG13NzLp1HLZrqR+?=
 =?iso-8859-1?Q?83YDdVndd89g9oetZybQ8NmRsGSg9oOn21xRqwd/8aXITiR1f7LVEI8fwm?=
 =?iso-8859-1?Q?5oxOeERdNsveiAKJpdpwYgfniiZQZ0be7bDCtDWOxYnWWdiMMuN5fJ9AOc?=
 =?iso-8859-1?Q?6dAfDCQR2rwbOK1rjInjQnFZPjX/2+fnxQxv7nex9b3itOvCNOnuwiUCQw?=
 =?iso-8859-1?Q?Y+SHGlRJVwkwyz5PrXWuyQdKZcCyqtZwG5XgCggcsaIFKzFUb2ZYSu5kAF?=
 =?iso-8859-1?Q?07cibreE/Ij3JYL5VatpWZMyDbzfjkrVQCQ8shyzt9lcR0PJUzrqYlVU/z?=
 =?iso-8859-1?Q?MkdwC1p+81IgaFugvbOi4Srhx1W9ANellJBJkc1Ej7QF8Yty0oapSSfEL0?=
 =?iso-8859-1?Q?0WM789OGdfpq34O/TH+rCNKj/a7IL3M9aOplGOhNwJuYhYPiLTZQIuys24?=
 =?iso-8859-1?Q?1d+1gFTB++bG8wcglza22nAbxemqE6uqQVfRbymwCzgkLAvuNv6NtXiXpZ?=
 =?iso-8859-1?Q?1JCvIpjEuXIG3DYHCmdPr3IJLPkwqDY9rdvjaf59kFcbDFqsXPXSpPH1np?=
 =?iso-8859-1?Q?xN+NFwvECuZcK0S2EHqErUoMPMB9Ti/gJByPccgmNURMUykiQF5r4fakIa?=
 =?iso-8859-1?Q?HeDT6G+zU6wzEuF7SaPudqNNa8CTK6fePniDgyFeDIKHABv53DrNdNSqJM?=
 =?iso-8859-1?Q?hx1J2LBSUWWFMYfQaHDU29DIBKvClzuRFnjJVO4eIJ4n7Qg10I44TNjLQZ?=
 =?iso-8859-1?Q?JT7PA/olW+OeZyTGrbIbRP3lf1xnhXNfSkSbY3WADsaFMw2tEGoeocIECn?=
 =?iso-8859-1?Q?dJchfbFB2F4IKRvkISJpAYnyR0M2sIG1/HIoJMVIyUbbTJTn8gjNT412Fy?=
 =?iso-8859-1?Q?Z0jB/Xa0mEL13R+6cpLUSyxBBbCg9xU0QRkAx4Q10LlQb1qcPlY7FwAZVg?=
 =?iso-8859-1?Q?tu0sUlkMDyw4pfx1azhfAyHZ5PhS6CxcEN6VFZOYBpPAZnctsyrXys00dC?=
 =?iso-8859-1?Q?GMf6jbnIUk8IQfdbwVLrW0EQMamCKLuZ8KxpnNRM/Plkw48UM06FwAiKEy?=
 =?iso-8859-1?Q?k2i7tLF/OUyN/mvqAFFAfRwd3Ops6dMyJKDErwhM/rNB/esC4TjC04wM5I?=
 =?iso-8859-1?Q?uM0ncDwP8fJZNk71mW/H+7YJQuIFr9uTAC2LS9sfLVpPlpXufY/qbQ9Eas?=
 =?iso-8859-1?Q?SbZld/rjHQjN7mWr4Tb9DC2Iuu08ST15aDh7+9EBcgJO0bcaChLseLp5EH?=
 =?iso-8859-1?Q?itnt7i5a4n0fGOOZwNoppmFS/2vbVQ4AhgHdv2TQ9Avo1qVLrzuyk4Goml?=
 =?iso-8859-1?Q?FLqGDVGYB1W6o4AynVF1sFyX5N+RQn4PoHPHqKdHr/7+OZlHdA8FXbaH/I?=
 =?iso-8859-1?Q?dj/RbGFBVVeRvNgR42niDIdm+XK6DIFSczPgd42SIQ8/+ZBjuokgfmiO2E?=
 =?iso-8859-1?Q?qkmRs4WYcqv4UUGfbAJl+z/3ExKV6yRVmdd2cs9j+C1jDHkmN1DehGPYgE?=
 =?iso-8859-1?Q?d7D0RTSa55w9ujW42suAzMk8gzVqyGmcuhTsfhVCbaOONh0NG5sgCdefw9?=
 =?iso-8859-1?Q?lgkj0pnfDmwEm8bRdXoIlXhCkiEf2kwzTm6abnk9FP2SiquEIS+dkdthU1?=
 =?iso-8859-1?Q?ObCIUsUCY3b8HNqLuWlbfeXKLjk1HKjZVmuon8Y2a4zvZLhcIfp8ul96Ey?=
 =?iso-8859-1?Q?cDgftt2WZMy01i0TOEo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa72d170-fcf1-424e-853a-08dde9426007
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:03.0204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+RhOkns9OCltLDsx5b3RTOJ2XQ9o5b0u6wvoVPlRvWyszljf5x+vQhiElZGAzl3Ud7p3bFxvSxWg7nYr4o74SPYnz0UA26YO6sSdddkHDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6894
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 228 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2400623982..ac72e49dbe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3294,6 +3294,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34751bd414..234210c6b6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -987,5 +987,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a..fbb6c8fb45 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -32,6 +32,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..2fc10b8618
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,228 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
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
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];  /* Fixed: was 15, should be 16 */
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

