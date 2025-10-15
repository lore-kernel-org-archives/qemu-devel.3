Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7964CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909v-0007tT-Vb; Wed, 15 Oct 2025 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909t-0007sJ-IU; Wed, 15 Oct 2025 07:59:09 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909j-0007nx-ID; Wed, 15 Oct 2025 07:59:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft9dIRrJ+ktvTqT1oZIagD0wUQ0OkntBX2Xho4OJQjCr8EBAp7Yz2cQQfuySKlGRH9P0nSEFtrkRGpgXd92WkxAfUjpufZBFOTtJ/EfFaDJnv1qmF8ypIxcaq0sWxA3Wj6/kf77+Joow2NubeaqJ8+/xUlPp0E4Hv/VblRJqp1s5NhbKHlb5VtqbgFt2HUzSt5oBG81G/OlfHPtlu5hUIzq1xZmI+KinKAhmxlkWsFmwY1LLntw7BcmQcaYJhNGR1iyDkui6DDYkyjULv7LjnkHf1lpalhKM5NwL9buGYqGGT7VisoIPnv0TcpXVWnjPMkxorbbf73ehLluX+yfzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=m5BnmJ/Bf7o+tLT96RQP/V8AaRfz7U/7cGYtkmwSHLaoA3Vjg+RMnlFDrOW4SS8/rhkL3nqhrBkZQx7lxAKzAWv6UPvb3v8y0KOfVlBBvtNkBDY0bpEnvBls6091czbGH+Rsjthf1I17rSpW/sKdtCWSltx/OPjAKaQDscAyyyfloe3TbqwRvSPQ/06nF579G62eef0HjDiHpIwGSNQMsAHv2N2FWLCGMgvmLF7Oe29reEnGn5e5cwVtr4GpWCq53DX77xyIPcnjQC1RkR4G872EDQQ/FhGi31CmEMsMxPzNGLvWS04c9RIqXMnI28siTPM6jpxldej0BSdhQIl7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=oTdiNSBduJnRq5n/7VZj5bgwiPFNFT6OVttEOcVlKVQOPTvHE3W2vXbmvWzVDNP0P0FrPsOU5cDk6RzS4VET5OrN8yIdoDXypIoI+A69ZjYsv8LSf+1g4bf48bqJsY8GMRP+v3ooMF+vgUtMGVFk2LkfUptq+izf3rK+6CSmpDdpNJQB5GGf2enlfUgRsUqHMwRxv1oK9+nJKZUynS1CT4pkTJVjhxLLO/xMwAbpGR739ww3QfU/EonnLUgZWPkn8N2FNxfbWws19wsBxjwHel/fXIPWkf2Uz/DB6ajBo6NTAW7rYUIVjjWrwehaNRmCfC0d5J7Fxs+AsCm2il5law==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:19 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:19 +0000
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
Subject: [PATCH v11 06/13] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v11 06/13] target/riscv: Add mips.pref instruction
Thread-Index: AQHcPcr+MtV6efD3JEWZxtR//kDndA==
Date: Wed, 15 Oct 2025 11:58:16 +0000
Message-ID: <20251015115743.487361-7-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 186a1a18-5b2f-4c6f-55dc-08de0be2213f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Iy5T+bupdZJ2uzTEdlPfMREIrc3MoA97+xCti60fSaZUos2bq2pa5ygDI7?=
 =?iso-8859-1?Q?isdgCszdJiWJSSYIKGbVx5IFtIzlnh3KnOdzlahHsXHEva/+MAgLTdt90F?=
 =?iso-8859-1?Q?JG/bss0JS+kFknsxB1MZRM7ibuV6WLY8pzhsSTtG4HtLsSmjEJlti1mWNL?=
 =?iso-8859-1?Q?7qKm6YP2AdiKf2xV5GTb0D4sSM8TNqeOVmG2ybP4nXUk+W+J/LyEV9UJ2F?=
 =?iso-8859-1?Q?ygMBs4rajfXaNle3SM2PHNFN8qTA4YYRqlHSlt/mmCVMJvG2P80IMtHEjf?=
 =?iso-8859-1?Q?oxnVro7N6vDlBgoauyY6Faa2O3runAvcEjZKWz1pM9/jHPBaP8BZ+RswVa?=
 =?iso-8859-1?Q?HjQ1ik9c7p+K7AHHMVy5ViGVwRXyDnhzh/wSxLPB4fiLpRDuVwDF7ZjqFX?=
 =?iso-8859-1?Q?+tx4d80YE+d8byrsRWS+IWrr/keSbJ+cQwZVbbQ8YnJC7K5o5HNN3KEPpp?=
 =?iso-8859-1?Q?diUphPkijNqaJVyxHE8aGHrSEfJ47XC5mLcVRbualdyIrUc3CL6RAqmRn+?=
 =?iso-8859-1?Q?AS+rNvWUByaqDtDTPglFFMT5Wx76RGwhrUTe0x28as5tuxp+7DotxhwNjP?=
 =?iso-8859-1?Q?3+dNbC61/QCcGxuTUfV7MLOOHGEhcpbv+cxJIhW5Er8+MPD1PdW2cHofeB?=
 =?iso-8859-1?Q?udqKbzEQCY8Tchj4PakBAwQjUqmvp9Kb4u9lM/FZEH9HUXVMvNikdxPsoD?=
 =?iso-8859-1?Q?07MyXvXJGZhqSC3S7p3nXLX1Nagug87/S0gb6wVi22iFZS4agnGX+Ur+W4?=
 =?iso-8859-1?Q?/CucseY/eXRpippKInP75XzwhOiT7TGQrLvmhHI6HvVpe3JSbsVGtYgJQz?=
 =?iso-8859-1?Q?jGdZo8T6tcqAFoGsURi6y7mTNBrbPlf/BbRfHb9txcUg93BnAHD072jOeH?=
 =?iso-8859-1?Q?RkC+bsuQUG0drInk5d74HpBkXM7s8LQOUQDg9y1+gYlkSoZpstN1hL5Hb2?=
 =?iso-8859-1?Q?maWI3OifuP2GwO6LBnJqD8Mw00YIKTCy8wzseX+rPmPZlXHW4SJTh7wzri?=
 =?iso-8859-1?Q?tqPswx99XIUcldZx6GJxImhAG1EeMY4dNW1Ljxeq6r3qCt8e6EWw/JZQaZ?=
 =?iso-8859-1?Q?ruPRsjNJI3UOFcnbL7V7dWiWcabx/CENJu/KghzaEsP8UTE3HHF8uHCeAE?=
 =?iso-8859-1?Q?JZkjblxpHR9f0tIbDhMSd9EfvFANlM+omYoDjtOPrA1NPFGLO1t47GtTeS?=
 =?iso-8859-1?Q?QLdnSlZEy/TFVhIfVJlOPKLOOzMd6LzhUsQZaefF1PtEMDwep0vbQ8fuh9?=
 =?iso-8859-1?Q?Q1M06OHkRpUs0om5lLWdVEyMJzWl271N0D+PZ97pPt6l6r6Tlp9IT4jNS1?=
 =?iso-8859-1?Q?3pPnpvKfrdb7yengOoA/G2XLj2o4sMlvNAE3l7cXhX8U3Hoi6oStAwflih?=
 =?iso-8859-1?Q?k+iUq+EUM/P98/pCA0CptpVpipN3kyAxbRohwN3KYrn1pg2hNWvCLt13H4?=
 =?iso-8859-1?Q?hwn2v7mM9/mEQD+Sk4QfZPLR1kf33QKucbG9UVRABYfZa4v95UjhUi8DhF?=
 =?iso-8859-1?Q?TTXHJoAf9ifvc4ZA4a2R62uKKQWBTWq6zKD5Rp1iRYG0TaZPsQOBI+Ou1o?=
 =?iso-8859-1?Q?4rs24jd6TlA5eXqoayiPrI9hTCGD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CsdtWN+nVv13dUxN+ft8iYtpMjwMOi/hqQyioqGQlrDOgB8T2//B2tyIij?=
 =?iso-8859-1?Q?U+i7jPqWbDiDt1bjFmWsk3XMvPj4n2pDyT0SlKTVjfwrlsD1NMPiFet5kI?=
 =?iso-8859-1?Q?AWFFA83lIpYrsDYgC/y3AI+NeLF3cjc4AppI7k39ucG4k0nfJAiZwlhpqN?=
 =?iso-8859-1?Q?Lz6VnQbqyHFnmu/Humt0fZwYTr8KL53Ooda/kDehwt7bJ16tYnu7gfb47n?=
 =?iso-8859-1?Q?UtUwyJpXXAT3ISu0rPBT9uynL3poTdzbuBZGqGHpc6SnBc5X/dFRzJ00RX?=
 =?iso-8859-1?Q?Anz383HGqVhlIEu5RUQoSZu013QbpnUmr3BB0Lk/gq9PK4WnU91eY0jeGc?=
 =?iso-8859-1?Q?ZWx0Tw0xF7b/cm7JXQfyzihhcegyJMvtfQ5c6qrVF1XnFsARi9XAKp4/Jg?=
 =?iso-8859-1?Q?fP9sxee3Fo2NOZArBEeTFmUMBN6FqFb78bWLQ7PyXUDWME2aRKENwiEana?=
 =?iso-8859-1?Q?G9UWv41TmemIglkSQI7HRbNYAcb3b957Ziu28Ui4BzbR5ng6i/9yrgRE1S?=
 =?iso-8859-1?Q?RFY+2vaGjZU5PnaY8gt+24bmBecHOuAicEwnyNgBWlT/lnP+GjlKdkqpuQ?=
 =?iso-8859-1?Q?oMK4osNrL9x/VHVIZHwUElSXGhhC7SG5vyF1ah8sEuutYSXIrTUNUuBO1G?=
 =?iso-8859-1?Q?S008sw3UdvvuhWVFIijdfURnJe7El2hUYvRl2Z4D9EpNwZsZdSKTY4GKro?=
 =?iso-8859-1?Q?sT7saJdvqAvxXZuILCnR9CnA5lKUxwbX+azWG9+cFZda0TE9aMYyT5Ucdi?=
 =?iso-8859-1?Q?dETPO7f9bY/6paz61zZBdmMc17JtoX9C8zvB4mcYlA9n11OVd+6QeLCdxA?=
 =?iso-8859-1?Q?fE6YDnnzT3wSiMPg1WUHLAf52YmbtqmKRbudZ4rp95hAnjc8GRiV7ub8/A?=
 =?iso-8859-1?Q?AFdpBcMlw33SJH3sO1EOX7zsjL37xD0d+zPldtQ0JRWnl9ZX1CVT8ip14K?=
 =?iso-8859-1?Q?W5Dvi2cubI6uCpxXLB9VNTRop0EjF3PXXrCusdvFe00EFL15BJzwzuqpxp?=
 =?iso-8859-1?Q?iXu4yyn+CEsmWTuz87A7QrGSIeSOJWAYOESUahnhpGKCqEP16ynojVtQYP?=
 =?iso-8859-1?Q?jSfZg/KVdKhxvnO3BK2CXggpV+z5E2AwAMPTKRfThdqm1gHCdlOJoCe9JF?=
 =?iso-8859-1?Q?lmW2XVmUPVxr7ZVTQM8OiMPn0Y0/JbYVlusRvYLFce7c89oFaGpLc6G6zR?=
 =?iso-8859-1?Q?JUIYmzRnLRgBlMmzx7Pas1In/Tdbn+geKshFLW1LpLdt+eYmuCZ+UnVdll?=
 =?iso-8859-1?Q?NasH5Xdk7UsV2Dk1AHHuJ2Or0riGc/w7Rb5kS8w05Lg4CveC8H2anZ1iMG?=
 =?iso-8859-1?Q?fYICNHdzMHujHmglj6uQiMLhbxu5v0ALMOw4XvwguWdV0mltH9v11Q60Ji?=
 =?iso-8859-1?Q?CNWHh147z+Ae8aVHc1heLtOQwTh7BsVLngcRv7pJfMNr8fcKtORyiDIu1y?=
 =?iso-8859-1?Q?wBrCAW8P1l3Oh41mAPRYJdpHG88ouF/tBICsG7kte7lpSWLgZVX3FXxP95?=
 =?iso-8859-1?Q?QvgTHNdzNc6bv3NrEON5IDa5cuCuRsx5RBQT7cf9ThPGSRI5B50H/DfHez?=
 =?iso-8859-1?Q?HBooYdWKGD4OaxZbbVONhqTsNPPbAf67VmaH5SHsKzgaE5Blhc4DBNSIZx?=
 =?iso-8859-1?Q?9DFmFk3CPLY1IgzNBYbLNZiSdmGtXfj+crHr/28uSQeQtJZVYH1BVeDsZY?=
 =?iso-8859-1?Q?Gdk+iA0bSV0cCX5Mt2Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186a1a18-5b2f-4c6f-55dc-08de0be2213f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:16.9516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpzIsNYA2RZF11hGMP24XKk5jo58P4DAae9bQUrxjvvJ8mf9PAevUrHtBEj4T9Hqag9WAhRz5zImcTy/y3iXFeQWJ/QSgZfzeHnBPdccETc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

