Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A050BCCD197
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909n-0007lv-1Z; Wed, 15 Oct 2025 07:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909j-0007ee-4N; Wed, 15 Oct 2025 07:59:00 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909S-0007nK-54; Wed, 15 Oct 2025 07:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okZsWe6Kn6QLinZrlINNNR2zqLZZxCUVl8AieXNfhuy2/i/d4Ydhv9QMeuuB+HoAZ2bAg2M1K8oYrsC8PS402rAwxIIPTbC8RHpLjEexz2UcnFr123I0sXzuCZYWlHtt+VywygW5A4TNDZmh/BC5BNdGnWjrgMJtL9hacmQYtRK3QtTLua4qWAzzWNh+uXqAe9bBYFubEqyZdMEgZtdkYlHKSrWIEZKhRQBxVt/BvG3bcCX/hQhVmMo0HKKyqbqf4CJD10EKDVkgbaRl43CxGPMmnguG81CiV1y3vHr5SKkHrXj9EtFVS3J/HXpEh3sXQvyQp1iaavUX1jjqEvh/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=NA6tnnXzjKzfJqE979Me+UIANZ2L/JXUKKquxZJnWCcYxU8bYaWYNZlwFhjQIhTbcFGQotJ12/nPcGDx4F/FN8cRSdeHUULnyg5X6JWmJrBzpD0r9RJsTxsg40cojet2ekUsCo3TOQLjFlFhh2DO0uWw6jDqz5XXJeMOwi01ckn+5MI/KBQS/u8kqAZqe4oSFB/Ifb95gwOCUojS1bZ60E0g0C2EUeYjeaen+3Iv/DzT0Y+m3Eplrl5IaUOGKi1fan8uyIf+pChi2L5iExMfbIXs/PCMCWz1ohx8YSdshty9p2xf6KZofBaoEaZv9cO/t6JY5Z+8O6kq3xORRUj57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=n+4xfhPqT3psHywqvXmSD7w8TPDCAP7j2VZAg1wj9qj3O5U44wpY7iQQxgZO77gAW/3+JzGfNDpCe6rIkyPzj0swbxRbsLJWgKsqHuLYxluEbuuM4i3+j/YcJOldHPjPu9vfbw8P4xnNtbQvAch6ZYnMn7MlIDG2mFQ6uM7MmJnaEs82Cfs0cLrKK4Cl19Jf1QS+tOOvW7SDjN8bTt+f4XYjPZLT/LKP6IzgkqJaCOLr1IgpmEexvwVh0ARD/vRxR3FwJEH4vEYzGehhBwFrU4CU//DgmU29z5JOo7hZ7zhZMZkyzsjqTP5zauRmoMZQxCyfGAotMSJ1i3Who8096A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:17 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v11 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v11 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcPcr9M/w7IF3zn0iW5ovfahua2g==
Date: Wed, 15 Oct 2025 11:58:16 +0000
Message-ID: <20251015115743.487361-5-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: ece2a6e1-f358-4d8a-e090-08de0be22091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AWEVQCXI33NM0RVZZ9lGFfQmtskMYTEQzx9xmuWmFX+IR34lPLPNr5BFaT?=
 =?iso-8859-1?Q?xVjMK4a4G7/aEdR0GZYRSz2bYLpHaShXzUF+nPwtscYh4reT4gyDakY80r?=
 =?iso-8859-1?Q?guobd2x2I4x/mnL/vBb2m9uMenS0KX8Be3MrtzpeMgDi2CLlX803A8sqh5?=
 =?iso-8859-1?Q?IYe3SIlIoYNnHPSXPmrzh504nYWx+sS9C8VSseYSAYHdQRfz9MhUzquUN1?=
 =?iso-8859-1?Q?O6W4E0kE6PbGaV7fyWMC3u8OAo4vhAvW12cFPxjdtlHCpjuOsH2Gba5NbN?=
 =?iso-8859-1?Q?KiK4Ajud9ZL4SqqAg0fRGAiAhiCg2cRYs9QY82jEug2VMXiZCuNgYy9IwH?=
 =?iso-8859-1?Q?WyIDUIZqrY3k1Uuk8vPk95PtQX93VxfNrfihOb968uOvN6Fwi/xqMDPXe0?=
 =?iso-8859-1?Q?ibznSMcg17UdgLwL7ulo1y/oYL2S0J0Uije//mqrL8jx7E/ZxFf9N43b9p?=
 =?iso-8859-1?Q?VD4OrKDBnF0BRTdKoUyR/ZYOGtiWDACdhnstXZC7t9mYNeVnzGexfsjc5F?=
 =?iso-8859-1?Q?gDZC0TZTBWSNHQ1AIiOOHHXa5p8RpHeV4XE4OJzjivDmVU9miZJJvikkHS?=
 =?iso-8859-1?Q?F4y3tYg9l2SLlHAEt3IVlzWOl2OhqngC0XQkpfjy7MkbV/k3opAmPz3PBP?=
 =?iso-8859-1?Q?Yzk27VuGsu28W5TBir1hyQ9GQ4UtzFAE2vpd2blnbvwQ9nDGuzopInz4Kc?=
 =?iso-8859-1?Q?srXLjmnJoqFFTqUYTbEDpWakjKdfyxFN7MSSaMNfXf+mgsfsW+hSkSAa7n?=
 =?iso-8859-1?Q?iaQLUxgcRl1kkEg5qLT+bCkyzdNBix3HHCMBGYiuLBQ4OD1zBUx63pYuMZ?=
 =?iso-8859-1?Q?GxW/jiv/9Pcu8E3eCHNtj43uvo+G2HUfNkJO7GVKnriwt8am9AvBNoE5gm?=
 =?iso-8859-1?Q?ym56xX1m0aCm5cnehTSOc803TdAvQNJ7NxTK57U3TQmBA8+kNOSQe1fPUJ?=
 =?iso-8859-1?Q?IUBFFx3nCOiUjNFKdQqIPUfq3hJDcmIk1zPmtYFSIX9pL6j/nQMY0L1XL6?=
 =?iso-8859-1?Q?I2twwzIGuT+A09MJipMehTBtW9XcI0jgmnfFrVxuyp0uAPg4nmriL1Z99q?=
 =?iso-8859-1?Q?JTC8EowuJrVmZlZtS9ox1cSzF8YZxLx72jxNuxGTkSYygYgiivoOyEZDEx?=
 =?iso-8859-1?Q?lnRy1jL5IcXOImsk0eINXL7+yeW5SiQQHqrgr+OiC2TLY8hclT+Mkppvcc?=
 =?iso-8859-1?Q?vbI2nldPMQHQaI/BPr/xr/CZs3rVO+jccUYozVDGQ9GDyAGPb7e2qdAqmu?=
 =?iso-8859-1?Q?cuxawr+/h3nCdWnTEmV6El48aKqMFeAYt52wcMLPCYEY7TkdYktPyMEUr4?=
 =?iso-8859-1?Q?6kfRFcpNyBX3Kd+NwoBqqPvSWPVHM+8H4iM+TLpsypmSio5JT7qqq8iKty?=
 =?iso-8859-1?Q?BxxOPHkUTIKuycz78jxsitDzXatN66MGOpptam7ED1Re8Zd4XJ4xv3YHPD?=
 =?iso-8859-1?Q?WAogYpMVAqVKjpGvv2+tjzNu4El50nm3WlPXHwPQTzi83dMPKrUl05sAtl?=
 =?iso-8859-1?Q?1dBKulU3qDRuwJrvqXEThIfZ/x4M2iTVwA0ATuzfQ7uuzaQANMwHDVPJFY?=
 =?iso-8859-1?Q?MqY7jLs2bkjtf3BNgFmJS7v254GK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f36tPSVplYGeeS1Nq/W+j3dsPUQZC7Mn7GlvPQ8pH8dsgRA+VbxYX7hNUw?=
 =?iso-8859-1?Q?17iYy3DInKHanVtkejuGLJtIeGtnBGJNAp3ekQ/D8zZT0/Bpc8Yk6N/V22?=
 =?iso-8859-1?Q?N+aYLTAjzCG0+TqxBVNlQ4CzqHM5Ft0o2zFUJGiDv11UURErKQZnB0QgbH?=
 =?iso-8859-1?Q?2XdKPdIEHkQy3yTYqQCHKn/nHDqK/9SnnJnanK8j7OHVuPUcRaQot3cjMj?=
 =?iso-8859-1?Q?IIs2apm/PX5Y2HogWcyo8mWljCE+NJDVEndLPX3iAL0s69vQ1GkhxsdN8Z?=
 =?iso-8859-1?Q?BKQteHQvZoOB7gtiumv+ick7wTmDyENS/ATgYXpiBMGGJnKkAW521Fjwwz?=
 =?iso-8859-1?Q?mzZpDS83YEG+vKiVOouMUvc3r49I9WD6jvcPCs0EyUt7jScNwy9eXBoM/Z?=
 =?iso-8859-1?Q?mV4Nfl0NFJlEHczXhBCx+yOTXAHPh9MzJQqeS9xCNo8c9Kip7gLhFcuxMf?=
 =?iso-8859-1?Q?3gKvfXbUyG9CaQA9qMlY7uMopNMqiW2g1HEkaZXOCPcM7w7mE/xlZPR8n8?=
 =?iso-8859-1?Q?c69p60WTsVTa0OOcJ3nBEYpxYsZ7oFNNfclVViQcKtd9ltRcvta/tIQovp?=
 =?iso-8859-1?Q?aKGdQrS6MsiEAbTrTf7ivxGWom8BURRBUSI/WAHt5/sJHAkDRndmhjiRTV?=
 =?iso-8859-1?Q?/WlB7ThQ1dqcLvr6qEi2ItVarKKFUlIluFUfoCzEqm9+orQCDyvNNRZgZF?=
 =?iso-8859-1?Q?91bjuHHL20A4Qpc0P+zsZ8xKmKr6az9/0dNRSs5eKdZ/yFSpmBOr2Xw742?=
 =?iso-8859-1?Q?3qZGthWgB2ftOrnqhQr8AeTQi9BPbPLjCP9WmcWyN8Jr8VMibV6uHPRYmS?=
 =?iso-8859-1?Q?2wicg/gB2y7nCda8LHpyERLKJJyzumwucidaKU/FDxk2Ss8i5CVag1TSaa?=
 =?iso-8859-1?Q?Pxolw29VvVB7xaHYZRr/gyykZWtndaFlr2YgKqpDWY9TL577ixk/UmeM4V?=
 =?iso-8859-1?Q?xZXFVGM1CUK4IqGqJzUBvFLrpDiYtCUaoEc9bSdIeqMVf74tSbo8mVmNP7?=
 =?iso-8859-1?Q?yjZta/ErC4Cssn7u4oMDasqsKKatJ67MlUUF1N6FmkHId2YFM43CdSyNvl?=
 =?iso-8859-1?Q?wNKlmJMAeyYIdpjn5v8iEFKtVVjobsIjwD/k+sJcfee+G26R+vsKE737VN?=
 =?iso-8859-1?Q?6HwV+q/Y/fPkbJRwERPu1F6RrLJgWAlanlhd+h67Is9Ebq1BiY69+lj3kI?=
 =?iso-8859-1?Q?OgC3F4gY8FkYoC8EfEjy48FCGAn25Gi2PYS9TlP2C2xr02NFk6GH+AwWjn?=
 =?iso-8859-1?Q?Nz/tYSUZXHkIjS/SQwABBp54J1fyqSu+iQwG7PJPGs01x2KkuaACQeAV7B?=
 =?iso-8859-1?Q?blDhSr3Dtn+sb00DNSFnai506OUua0ExKrFhv/LoL6D6qXcIz7ScG370uR?=
 =?iso-8859-1?Q?M55kBlPCGaUdjIOr18NYUuzAnMxLXM28d4E3vmF27yFxuABBJAHRxpmrQ5?=
 =?iso-8859-1?Q?OderDuKx22Ussx6Zj/7vO32LBhQ1ZMaIfmpi0S0TTupk1pPUyrZR3dgL7h?=
 =?iso-8859-1?Q?arCag9pg5w2Fu/Ku8RmdFiOgwX5JOwDSWV9Cvv2hkWGOssWW8QuwXvebUP?=
 =?iso-8859-1?Q?HxpF5OmbPq3lpQ63uiFXwYZvaKvdX97PiqsX43/a/Osn9C52g4gTmoj7IR?=
 =?iso-8859-1?Q?omfJ2qKX9q3Omu5x6F+O7SdGfjhzfwmXsrIHkrlPWWUaPnBml2Gm7il/dZ?=
 =?iso-8859-1?Q?p2jU203o0SKk/i4DjLc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece2a6e1-f358-4d8a-e090-08de0be22091
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:16.2119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbmdKj1ioUjvsxwZbjddoZ+VTd6kO0LllKrWwLM3H5tGTjw3rkzlz2t1wCpEjr0DisUmm48k+j82SnjRJ7FJUZ/cROhylHMPofnuU7URZOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cd4e442bdb..2fd0ced25f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3297,6 +3297,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
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
+    uint64_t pmacfg[16];
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

