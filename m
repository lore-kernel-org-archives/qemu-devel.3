Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4BFCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91EQ-0003Nq-0h; Wed, 15 Oct 2025 09:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EK-0003LG-1l; Wed, 15 Oct 2025 09:07:48 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EF-0000nK-7P; Wed, 15 Oct 2025 09:07:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEztOYoVGPMCNBNkOi+EmnyoavtvyaAPU5ZN0Uepd50ADaNnnn2F3Z/rtc3matyFGgBgmubyyDc7JAfgDnNt0OZKSorpFJmKik0HLCCNr5DrOMvdRXg1DNbFC8YHTXn95yr281ZiynLwuwsgLte9kGAPUAVB56GnvLmk1DnUO+J519IcHtvoh2PNyNT/Cfk6FWJprj4cF7jqbFKehe5QIWiwxABPuDKTuecc0GOsuqpf2dPTo95bzbRDbv5yQn+pm8l5dLeNf1jGs6RnvVdVLnKvyYf824O3Snt6K3gVz06sAw9T/PsHy0OLaQL5bOZGxpVuitoougIOdJADcv3JxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=ns7nO/XHbIvCN0vJT1Toi8KquLD+fITFbIEulBbHSgMwnRDS6kIpU3Lwol9IEg82NLJ8QXkyWObRGwIOnjIwd0TRZKSYQoS/K0F5xAjE3zNZcu31JrTJyi8xPfEkAIrQSqR+vbmaVae5+GMpjyWSfW85egMExFAa2HStDzJsEWidJqhiaebpxB9Gbwld6U5NdJA1r288ETyoJpsPTE7c1XJrKWJzFPwV7C8na5K+nTVSKxgS3cB2eBVKj80+hWftvmltUOACftgEosKaMtEXLPBHq6ZZzotjBthAc6TOhw92qBDc028fff1kwDyi/cYYlCoYj4BpNdQTNvtCXTCwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=E7KqrkLVfKFiottb4GncKotsBT9J1F3mj/gceNVd9z8La5Hn4kEirZczwGUc52PEoR+xAaFdVruM+fHdrn/oezy09lCKvOq+xhA89q6HLQebA2DtTXyMTjSZZfe3Afje/5d1SyIOBJ/w83wQ4S3WWsTzaSrujj4xM4f9tpjb4tmxX8dx12e6VoEsurXLRh4O93gfZKASjrip95Qo+i90rMeySz9YgodCQMzJyErssF0XYo22K2DC0alCmGvstVnmvZEselTLLrEKDj8ZL+7K/44WJ8NUBpvxh/LKyKj98z7ELu4BS/xE2GpXEekUqs6TV0tBoimgKwW0pqzYZkod/A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:06 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:05 +0000
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
Subject: [PATCH v12 06/13] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v12 06/13] target/riscv: Add mips.pref instruction
Thread-Index: AQHcPdSah4DMQ4Hf1kuuyf2Oa+X4Tg==
Date: Wed, 15 Oct 2025 13:07:05 +0000
Message-ID: <20251015130657.571756-7-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: d5fcfbea-a1a2-4f68-859d-08de0bebbd91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mXssCH76Nj71sNcBTZCSfbica5VvioRW1Z4PM1fRObMN0QHRpq7mkSnH+c?=
 =?iso-8859-1?Q?/DV8RA56rD0HKmbTgVs08EEM57d7VOnp6IPmWBi3TCPK1sKKS1h/xpJYdm?=
 =?iso-8859-1?Q?lVOb+edRqwf++FXsIcZ7U9wTitfryGGSuMixAFDgQPxYCVW5VUfHX5K5Du?=
 =?iso-8859-1?Q?XpOGuJRrM3rYykug8GXHlU5jxXyS3bYCapRsj9PZn5lMrQ7tA9qIR4FVtl?=
 =?iso-8859-1?Q?f/Y7UL5AgwDGllFi4dcXdO72F1SCGb7mNx8+kq2dPXHAQqlRpah8lEz0Oz?=
 =?iso-8859-1?Q?uYPa6/64CViGzD0FHD5IDGELZUPNmzRemjUa/3rBuX4Zt/fDghPjjzPBWt?=
 =?iso-8859-1?Q?6hCY0CJ3fYalqOs+fEugUXvs15aGcPTCa/Eq75frZDNTiBmyGx+cNu0FZ1?=
 =?iso-8859-1?Q?AOMRUyNk0uR3HtBEtKD0daJ1JO1T8QU9ymSCzkPjUidIFwf3f/3EzjOD4u?=
 =?iso-8859-1?Q?FU4DlLTcfF12zGl5R23gaAmY/m4CyqkAVMKh6JdSUyT4rTAE0LvPW+nDL1?=
 =?iso-8859-1?Q?nUrl/OQWRPsDAb0c7z1pKz1DUOKMuQh7sl8LretuhaSWkPZE7bf+8rXqag?=
 =?iso-8859-1?Q?cF+DuVDuUD5/AcfqCEr/HjWyQzsKCAJlD3Ni3CcXqM6eude0zLS9LX/lce?=
 =?iso-8859-1?Q?dm30Betkv7xZCmxPz+ccKCDnASOd1VmW9KKwJ5f+OtIRN8eb8AQrcjeFyQ?=
 =?iso-8859-1?Q?yGHowPoBEhVLdmLd69Mh74rw+PveuyyF6fvmnJy0J4+Ey00Z1oxwBYYr3z?=
 =?iso-8859-1?Q?JsLg0cWcx1yMA7EtPl5s4Gqzx+6QSRV1WLxP4MHANX4enDku80guis+fPY?=
 =?iso-8859-1?Q?jDZekKl1knCncXceciHMJSmXfwnitHn5gH4goKzLc0sHnBAWtTHQs6bnwb?=
 =?iso-8859-1?Q?ey+vptGNaGjhm6caMkY6qlOy/eYr457wo45LbyFfRwJ/C5ekdpQFlk+YEb?=
 =?iso-8859-1?Q?VJ0Ru3muDZtg2vdnmtRJCQMYa/tGOvQOmes5HjDGSeDV9MIsOhKL0oaUFc?=
 =?iso-8859-1?Q?qhs48wxWmdVChkeXfjPfB8kz+3u84P/KYvAMP15AGjSqxk0jSfr7Eg4rZT?=
 =?iso-8859-1?Q?GpplHizGraucs90fes2qW+6u7BttN7HIDYe93bSkiy6EtHPC0Fiy0hU5un?=
 =?iso-8859-1?Q?Q+QslhggGbvB+qMEH/2QSIP0C5WVxuPnwNeUdfxIWbaGZqwxpkbwjnn00f?=
 =?iso-8859-1?Q?MNpJwFfNaz9fUDbfrScBXSqQOLnVZ1ClPuzZLzKAxhPGA4pSuoBrMqTaBa?=
 =?iso-8859-1?Q?yO/eVZrbwMts4mR1naplP7WwhLxn86Ukauqbd+RcoAKpi0YgdmM6MOfyF1?=
 =?iso-8859-1?Q?pO9cne2poCQ+34lQm2GjZtlM6XgkWP9+QYlMGx0rnkrX/qRs26xMqduNNZ?=
 =?iso-8859-1?Q?mTa/4kR46h+AW8gQWSUW4xItx5dlzSMOC2qrBJ2nEX+lDMDiNN4Sp7rKb/?=
 =?iso-8859-1?Q?W8XV0UqeJz+hYO2BaxiKJnuECJQhm5DaZPhAMnozEX7e2kALTkEnJwkq+N?=
 =?iso-8859-1?Q?vsE+pE44tbDNU+HWEQR1vTUQvsiOnQOn36vDg4VAlB7yXc6oF+K0OgSuTk?=
 =?iso-8859-1?Q?5rUoXxCpMiJp+xQ/uYmHP9kb+7gx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OH2oObirB96sqiTPuRM5thxfoM5kgBiEAujZbiXOu/fVaPoJCiO1GKgUg9?=
 =?iso-8859-1?Q?53NzNAbOWLFf0d7RzAEBBzDYu2WVmTl/ADkLNrSpoiiWv+jLYgda/PWRp2?=
 =?iso-8859-1?Q?WJeqcm9DEPE7d2Xdx9ShCOzhqgY0iq/wq/NR8Gg2QnJ4dpUL4I3PS1g6O3?=
 =?iso-8859-1?Q?zOC0vhewltI28dq/RRhevB3TI4yOnpxBnSZmiOwjKviLxzh54SAirnw9hn?=
 =?iso-8859-1?Q?oVLFvrcTPUsYEgiKwcvb7XXqKlPOKCoO956148WU2iFRdnbzeLkvWCXBr/?=
 =?iso-8859-1?Q?qgZ8BE1y55HSSNmeYTHMJ9QqCtXzlm0yC+Jdspu7IJQuYOIsHV0dQ/4RG4?=
 =?iso-8859-1?Q?y1Q3z8zmGE4zhgQqOoCyBd9CyHaTfJCwCKUoL0yOI87iaZ+O8BEgFGAU8s?=
 =?iso-8859-1?Q?aye73HhSPXlUrMnjvhcuiBWV4+5ll52/RulhnCtHOTkht0ZrzwmFUX8Ecu?=
 =?iso-8859-1?Q?LSkkt1QkXJ1kvC4/9JvBErc96HeKOK6mXof7weAigjPM9IMvfMmnkUg0at?=
 =?iso-8859-1?Q?LhNvhdqN/IlBqODjgz6mj3m3hd3j+Wj/ZGbLju04SsP4e3shmYiOUBT2qC?=
 =?iso-8859-1?Q?WQqRM+N/jn7kU8TQWcsTBiVd4KTNopzN3L1QtqZ+D5DwMmO8hlbhWO/Ha0?=
 =?iso-8859-1?Q?ti2houkFwTuAAJJD15AgC8dKIyEZa1qqM8uJG5nEGomatnk/AlmI77a4G/?=
 =?iso-8859-1?Q?RhQlpFRgqawL52yutpl0mHcwHP42JG6YCQ6DfUPvo9CGqQu2iTyxn5TV79?=
 =?iso-8859-1?Q?kC80EURtr1+obfMm5OOb6aLAvRwcdCq4W0DWJ6fexFzcYkDcLh9Uufvthx?=
 =?iso-8859-1?Q?lqsSik9rbHZaSgDafd71XbRGuWbp2TKWlAmkoKUpjo5efO4vnvaxdAxGPI?=
 =?iso-8859-1?Q?2pFwIbzsLiLhlDC7eX1M0mwDsLutzdZfaOf2brL4ON2EtzWRn5JIiRjSxi?=
 =?iso-8859-1?Q?8p+7jbtqkkz4GBrE1MKhgrB/cYNAoLS+QGn27auHq8D3y8+jDzO9jz7PYG?=
 =?iso-8859-1?Q?PguUki8C5+OId1U5RHgf41BYEZm2vh+FtZ1AcM6dkPtznIXe/NyE4yeQ4E?=
 =?iso-8859-1?Q?h51OhBaABnipdEbKk9K/G1GX9ltY8mvLhE4Rav8E6Os7sZt49GZY/dVmMx?=
 =?iso-8859-1?Q?fHX8NlyEqEs3qep5iGHY/ZlwrWo5SrP6TXDqVV1vqk51ewRHFsXmYmoVKs?=
 =?iso-8859-1?Q?6rUaTd2xh80VBdu0tQOq+br+bb9fFcRidO+oB4jgs39OTse4y/QDvUHmjQ?=
 =?iso-8859-1?Q?ODdaB2K7t6FP0UY0QWB/J9xWfh9daWHcdu3jKcIiVr/RAkvbTQ9xrIULJu?=
 =?iso-8859-1?Q?4rxI3Xb8yeNKzZV6dAL9e2Zdvw7j46U3QRxDzzfZ5L8X07zbDP8LjK2WaL?=
 =?iso-8859-1?Q?UUiylPbzpDP8lRJ3NPL5/a7igIDrjxrge3pUxuHB/G+eAFlJ//qxUCFMuu?=
 =?iso-8859-1?Q?Ewvcksp2zfl7xy8bX2I8XEv5QPnDnX/Ht8Fun221dNgmbFb6YaUdSqV5Zb?=
 =?iso-8859-1?Q?ph/ZvIZwG6vMwGOf5PVTf4cHA0ialeQD15iG+EAp/eQ2X2kRKloQqvs+5h?=
 =?iso-8859-1?Q?cZDVLZ6Y8Ra7nsz7xSFOyu/0k4Qsnz5zZv69k0OukMufeO4TPotSJTsBKO?=
 =?iso-8859-1?Q?mDen3rhETPuY3Ujrx/FW7vB1ibghXD1XbcMLslzAyX44iXBMaEoCq9BuIV?=
 =?iso-8859-1?Q?7LFe/XmvzNX4Bdws1lQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fcfbea-a1a2-4f68-859d-08de0bebbd91
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:05.5660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eG8smB2nkgN7VhBmJ6en/rO4gyX91DzWOG8Kq13948inrAuUsxcJ2jGmV7f4gcPbSV8s/CEI1D3LMiQ5mKk/vZBq/Xy98Ceg1gMx1E12sSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 87cb367676..9fda450683 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1382,6 +1383,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3297,6 +3299,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index a290303ee7..dd3ee7ba2b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 3202fd9cc0..bfe9046153 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+/* Move data from memory into cache. */
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

