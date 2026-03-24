Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5847BF54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54o6-0003nQ-J9; Tue, 24 Mar 2026 12:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54o0-0003lM-2E; Tue, 24 Mar 2026 12:40:36 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nx-0005LR-FW; Tue, 24 Mar 2026 12:40:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7uY1Y58vPAR9B7eme46vtCgSc+wpnOGRpH3W6F3eT90T9l5SUbKe4Si2HbyqGlQWb9jV4Xz329Dxe4uqZMeLgd6fR17ib58xmMRm0H7F35YhFKVVl87lSF8fcS08W6an18eLsi8YGeuHBRMoyeRF+cqf9WLwm3EiSlESD2HtRIibE4pay/rSUuUcxt69Fhp2tIWNJD7KflQFAjopYUTiMB/r1oTr1rsS4HQ0Fv0mkaIDpcHlY++lqt9onqbFzsmOBvwjU/2EPupvHH//UKo4eahZwCZ2b7JTxAL47cqbPQlEIfiz4DKBdwfMlYPS0uLznX7Y0+7QL21SWP00Sn7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbfVXWr9+U6etvsznPf/5+PQydUm4sQ3DPy9B4dJuEk=;
 b=airhLJ/FSH9KeFP3dzAkZFVswL5R5z4GfZpqtVUTsbQrDw/SnbvvggIEbJE7q5QSa85JnTmIoGtnQausKryiEkK58iEHUMHTyfK0ufJ0EENWpEZ3WYOELAPxJliXia338N12LvlW2XHY8ZeLdBWJwwLHjjlp5fQYsdJ8DQLhJqYoXaZI+LW9Yncd++RjwRbxx5Hbdh2mLY1CwAZohoYTtVp0Tg50H5LYXu4eGeEse4HQ3nzvHVEGNnsEzv7ye4ePG0U2I/i9ojIRffK98nunbuiWmAueIRuBlHiq1jG0ueNKDs1Jc/rTAQGgyQ1CJACEgmtww2Qt6AFm2X+QkCxlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbfVXWr9+U6etvsznPf/5+PQydUm4sQ3DPy9B4dJuEk=;
 b=N3LqF6bcKAXiNmvS8ZXjxORJlyd8e2ipvMowzWlidJ0TlktYP/ONubpgv3N2CRshIK9ihIutCZjyaema0xdHJoPhIkGvdVinAzM8NvdTc/bT043uwJsH4T/66qpyR5/BcRT+yhhqhEkfh+hL7TrBWm6N2x5qnCKeWVqYoSzOdisY2dNC9x4cVcN0WScfF2NZB1ogOQHkl3A37jf2QPzkkWhMZ9hjCjvqETllK8dDSQyD52FFyG7vzHSn8svKSIRChc+EV6TT5RcYssCE7GZhtz3OpIPC/TSsWLnEpWdCkPwSsS0+eg5hSXL5j/zPollBiFAvazYDXasW8hG8prX9KQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6145.eurprd09.prod.outlook.com (2603:10a6:10:475::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:40:16 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 4/7] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v5 4/7] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHcu6zkp4dl2F3i9UaTc6hdecuzUQ==
Date: Tue, 24 Mar 2026 16:40:16 +0000
Message-ID: <20260324164007.549397-5-djordje.todorovic@htecgroup.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6145:EE_
x-ms-office365-filtering-correlation-id: 7d162eaf-bffe-45e5-5f42-08de89c407a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 7Qhlh7qN9bTH3QeWv4WtvSeVHS35/KX6yXrg41ZBIrukEwfYvhFLB5GjzPvZgM6QdnS48OfY30bIlNAC5MlmnLpq80I33DQ3+4pgMzcyBcbkHqLM+T4nvY6R+DQbXA43O9C3jmwefydzGcHz1eBM2+NioAIi/O6D0Hi7f2X2nHVkQuNwJie/5/dfkjWBTujsMLmsasZpdyIBHI1yF+98oMQGc+FcWxtDFES+pRwuN+L3f8WK4qBFGfU7j1l+KWXGxbedBYyZl6o/gfC8gyYSWPWT6fX+iC90IpyasCGBwZC4Xt+Un/LVT/zTcLaGyatWuwlnpMxeIa8oZ8fwL7lNvvBazSgPjmWBLKYg4Hp/VIpYcxQxTFpdoQkHmaTSqfSgPYPZeVwoeAyJnZaGZYtd28krfXHOgy5RGZGCFxsWMYmxpTlOIzQ1t8rduAFFCHHITGTDISYTUlHJcOgeoO0dLOHpOsRlKexhTQQ0bSxtnesauz8Y33HRwXMU/7OXMpfdBvVvhj+VC3J0x2g8Ny5CyeOkGTvfySD/ksSLlM/59+Fx/ee3FfFXUx+OwDSmqg9gYQSthK7iRX4WdjPcSZXb5UB/IjhNlJ8D8U4+OlswXNkeokfZNfMkKFEZllt3SBvHTiZycIXil9rwCNJvXNmf+Qf4oNZb9ohmtfGZfrBvvdLWCmKVXiFzgqueedjiyUjW8i3AYiSt2Fu3jdgeSXgyVIbwO/B2kFRFDHYKGt43TGA+j9MK6OkLLi0pPfE4tqTrJQgCWRf56Q+OLlZJMcRvNgLfXVshrVZiEN+17vlA/so=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nBsqJV2C/BI2Umc3qbLaELnr9VdotfN4DKBaVc9Q67IgpOHp+27/NtdXCU?=
 =?iso-8859-1?Q?zXYl9uHTHsUHWGsWmQO53SgEIQ0frJAoXO+mCnXuP9pBEDzxoVcC1f3daG?=
 =?iso-8859-1?Q?M2gAbXJKXLL2kl85a7Fu4b6eCuCXkvjZet5qnHntud43S80aD7sgLeoYTQ?=
 =?iso-8859-1?Q?DDx2bGYijKXWIslEw3hu8IHNuUrHFnIteSHyfSMsA3FlbZ5owuTATCP/D5?=
 =?iso-8859-1?Q?a4ibjL6dOckXhRWRLe8O5jJCWsJdiOGeKDvHaUoG+CsrmBS6swYjtUq9j+?=
 =?iso-8859-1?Q?hJhoYVM/P4+4m9GOsBFijohVcDcqKwVqzmvCUpie+ou0d9AADbdoZJQ0On?=
 =?iso-8859-1?Q?g2jnKjlwKMkQZQ1JJVmQ9P6zlG5xSn0Fk7ZodnudhxXunGEy4KKAM2lc4m?=
 =?iso-8859-1?Q?8eyrFxTD1g1BtNx+7iP3UQVWWoCrt0bOB6Hjo4cdQfBkAJPNiAHOOi8/pk?=
 =?iso-8859-1?Q?Y68awAbEefMbUkl3lODH5joQTUWGc9jwWL3bUTn5cYMwEFaIj4A1uvUzrB?=
 =?iso-8859-1?Q?B23U8Zz2Ni8DTTJobd/QZfmYSSyY0AD18wtlNHQTHc3jPDblG/R/pNvJT2?=
 =?iso-8859-1?Q?brgCIOhmiJdBwlDwrg5mH6DxvRxbDBEZ4cq8uOmtLmCpkMsGNTPrrpNwHo?=
 =?iso-8859-1?Q?zXE7Vgp2Bnxa5nZgw77knrIYLEVNv3KjyFmWlBEQWoawPnykl6abgqf0yW?=
 =?iso-8859-1?Q?xbPodf5lU5J1Ok1OxoJ7p5ADVh6i774AblnOdoojm1RGugcbSl1M8mcJjf?=
 =?iso-8859-1?Q?Dya5ivyJB5bwbWsammWTN7RIrWwNVUPGljfKYDTAUJ5Ga8t9I5H5L9m77y?=
 =?iso-8859-1?Q?1bm8xjxwzWvi26D5Mw4ChUdyCQIyBf9FA8PnYGUqPPkD3GqvGDJmDpSLRw?=
 =?iso-8859-1?Q?FZNSuBv9EZ+ANKlA7AZxhtDtPfkSVabqSlG79HKYcPfr6AWnkMIsOzMsgw?=
 =?iso-8859-1?Q?7yETskriL40RJPcfOhs77ilSpoF78UV89G2wPFamz221ZR3fkdxJ1Lga/g?=
 =?iso-8859-1?Q?Z7vL2ho+IkGpbXFl+WqNqIQXiOTLNjJ9Ai5DUHRd+fanIsL6pDBA9srTiu?=
 =?iso-8859-1?Q?b9JxSBXCam4HT7682gb9BFM6RkI/ltwP6Ec4gjGf564ZNVeJvET07/oZXe?=
 =?iso-8859-1?Q?1QVuP5S97ztvZ/ZmuR6qDAPZq4iG6FHKfuXLvU499fxFtBkzr3YrStLdfG?=
 =?iso-8859-1?Q?XtJ3FIXBavEGlEzVPLHQ/M9xCrv4V4R+KMnITm4inQ5tJtpr26A9AU89wt?=
 =?iso-8859-1?Q?XZR5ixvNQQRoztaSOBAS8+Uwld00ZAjGiug+xKlKLnO6NGPkkSzn4EECRe?=
 =?iso-8859-1?Q?uDf67RC6DOHUgjWgyUvHZDgYeC8msrrAftvGufq110tf3XMDWdJbw7EVFw?=
 =?iso-8859-1?Q?E41u4/zT+H0OP1np1Z9zVnce5uEKQnQNY4h6vSIGoZZDKtpQGbKmJ7U72H?=
 =?iso-8859-1?Q?ndFnr/hyQEQqZkffMF77XchMQ4Wy7et98YOMCRk5mBnRl+1KQhwatP1a/+?=
 =?iso-8859-1?Q?Y+KxurCFgoFf9neu/5wfVErO9vewq56rzQCELYroUvFD1+CFEG4Zls7w68?=
 =?iso-8859-1?Q?Z56nZBIiVFO2udP8Bqadn/LNaYWbxoAEqgOl1awx4x/SQVux9mOev6YGI/?=
 =?iso-8859-1?Q?Db5IoXr7FnmlkPDaobZlZUxahSxJInJe60BCyoS0XJ730/6IjFkVxYvftW?=
 =?iso-8859-1?Q?axLepj+uEegOTpmcIUmRbEct8U2Mbwdghmuhq2YI/ybur+xLbki4DEW2RE?=
 =?iso-8859-1?Q?a9wdkK0CYjAHVwZyflxCpV0Emljl7abrf0vckz9a9WmLIsE6Zmqt+dvUak?=
 =?iso-8859-1?Q?Jx4HUAvbYIxaTgCjUrB7obyc9jDPCJ9rngLLV4evKgLHHL3yzDsp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d162eaf-bffe-45e5-5f42-08de89c407a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:16.4489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4902d83BDxSC96jrBLH7kwi/B2WymZv5u7L1asJfMSoQN/iyDPR/O6DXjlBJSnCSZ8CO04yoxcT/dBLUrdeGOK+Hf6m7RDJsVL6nzoGMz2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6145
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Add riscv_is_big_endian() helper that checks the hart's big-endian CPU
property and use it throughout the boot code:

- ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
- Firmware dynamic info: use cpu_to_be* or cpu_to_le* based on endianness
- Reset vector: instructions (entries 0-5) remain always little-endian,
  data words (entries 6-9) use target data endianness. For RV64 BE, the
  hi/lo word pairs within each dword are swapped since LD reads as BE.

This is part of the runtime big-endian support series which avoids
separate BE binaries by handling endianness as a CPU property.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/boot.c         | 82 +++++++++++++++++++++++++++++++++++------
 include/hw/riscv/boot.h |  2 +
 2 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda0..c7558b904f 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -40,6 +40,28 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
     return mcc->def->misa_mxl_max =3D=3D MXL_RV32;
 }
=20
+bool riscv_is_big_endian(RISCVHartArrayState *harts)
+{
+    return harts->harts[0].cfg.big_endian;
+}
+
+/*
+ * Convert a pair of 32-bit words forming a 64-bit dword to target data
+ * endianness. For big-endian, the hi/lo word order is swapped since LD
+ * interprets bytes as BE.
+ */
+static void riscv_boot_data_dword(uint32_t *data, bool big_endian)
+{
+    if (big_endian) {
+        uint32_t tmp =3D data[0];
+        data[0] =3D cpu_to_be32(data[1]);
+        data[1] =3D cpu_to_be32(tmp);
+    } else {
+        data[0] =3D cpu_to_le32(data[0]);
+        data[1] =3D cpu_to_le32(data[1]);
+    }
+}
+
 /*
  * Return the per-socket PLIC hart topology configuration string
  * (caller must free with g_free())
@@ -72,6 +94,7 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartA=
rrayState *harts)
     info->kernel_size =3D 0;
     info->initrd_size =3D 0;
     info->is_32bit =3D riscv_is_32bit(harts);
+    info->is_big_endian =3D riscv_is_big_endian(harts);
 }
=20
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
@@ -247,8 +270,9 @@ void riscv_load_kernel(MachineState *machine,
      */
     kernel_size =3D load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NU=
LL,
                                    &info->image_low_addr, &info->image_hig=
h_addr,
-                                   NULL, ELFDATA2LSB, EM_RISCV,
-                                   1, 0, NULL, true, sym_cb);
+                                   NULL,
+                                   ELFDATA2LSB,
+                                   EM_RISCV, 1, 0, NULL, true, sym_cb);
     if (kernel_size > 0) {
         info->kernel_size =3D kernel_size;
         goto out;
@@ -391,21 +415,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
ne,
     struct fw_dynamic_info64 dinfo64;
     void *dinfo_ptr =3D NULL;
     size_t dinfo_len;
+    bool big_endian =3D riscv_is_big_endian(harts);
=20
     if (riscv_is_32bit(harts)) {
-        dinfo32.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo32.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
-        dinfo32.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
+        dinfo32.magic =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_MAGIC_V=
ALUE)
+                                   : cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VAL=
UE);
+        dinfo32.version =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_VERSI=
ON)
+                                     : cpu_to_le32(FW_DYNAMIC_INFO_VERSION=
);
+        dinfo32.next_mode =3D big_endian
+                          ? cpu_to_be32(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                          : cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo32.next_addr =3D big_endian ? cpu_to_be32(kernel_entry)
+                                       : cpu_to_le32(kernel_entry);
         dinfo32.options =3D 0;
         dinfo32.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo32;
         dinfo_len =3D sizeof(dinfo32);
     } else {
-        dinfo64.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo64.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
-        dinfo64.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo64.next_addr =3D cpu_to_le64(kernel_entry);
+        dinfo64.magic =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_MAGIC_V=
ALUE)
+                                   : cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VAL=
UE);
+        dinfo64.version =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_VERSI=
ON)
+                                     : cpu_to_le64(FW_DYNAMIC_INFO_VERSION=
);
+        dinfo64.next_mode =3D big_endian
+                          ? cpu_to_be64(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                          : cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo64.next_addr =3D big_endian ? cpu_to_be64(kernel_entry)
+                                       : cpu_to_le64(kernel_entry);
         dinfo64.options =3D 0;
         dinfo64.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo64;
@@ -474,10 +509,33 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
 RISCVHartArrayState *harts
         reset_vec[2] =3D 0x00000013;   /*     addi   x0, x0, 0 */
     }
=20
-    /* copy in the reset vector in little_endian byte order */
-    for (i =3D 0; i < ARRAY_SIZE(reset_vec); i++) {
+    /* RISC-V instructions are always little-endian */
+    for (i =3D 0; i < 6; i++) {
         reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
     }
+
+    /*
+     * Data words (addresses at entries 6-9) must match the firmware's dat=
a
+     * endianness.
+     */
+    if (riscv_is_32bit(harts)) {
+        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i++) {
+            if (riscv_is_big_endian(harts)) {
+                reset_vec[i] =3D cpu_to_be32(reset_vec[i]);
+            } else {
+                reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
+            }
+        }
+    } else {
+        /*
+         * For RV64, each pair of 32-bit words forms a dword. For big-endi=
an,
+         * the hi/lo word order within each dword must be swapped since LD
+         * interprets bytes as BE.
+         */
+        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i +=3D 2) {
+            riscv_boot_data_dword(reset_vec + i, riscv_is_big_endian(harts=
));
+        }
+    }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
     riscv_rom_copy_firmware_info(machine, harts,
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca122..a54c2b397d 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -36,9 +36,11 @@ typedef struct RISCVBootInfo {
     ssize_t initrd_size;
=20
     bool is_32bit;
+    bool is_big_endian;
 } RISCVBootInfo;
=20
 bool riscv_is_32bit(RISCVHartArrayState *harts);
+bool riscv_is_big_endian(RISCVHartArrayState *harts);
=20
 char *riscv_plic_hart_config_string(int hart_count);
=20
--=20
2.34.1

