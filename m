Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B259F4BB93
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0k-00044v-Du; Wed, 25 Feb 2026 05:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0e-00042K-DP; Wed, 25 Feb 2026 05:20:48 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0c-0002vD-NG; Wed, 25 Feb 2026 05:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/v7IzCImqgLMz3nMWtKx0cYJzjpLft2CWlJLLZMoG3pe3GoUb7CGoDlDVPve0YlfzFWw8KB4E/bqdQJnj1FqbTdK0kbhRXvrXTJKm8t0dd65+woun9fsZL3V4WAqneTh11xJb0OsTFunueMFXdaDgIy/x4olUPPHxIpm+0bEz9b/lbVDLCsv9O7nhdMiQsq2E40h9qCfQ3reT6H9wvVjL9U5222sp4VOsTOo8idEXqoimE/AS9QfEgtdl9vQx77nFY+dypyWn08nEw1p0kaubqz1dDBloChTx2koarNar5PgqYczs3HaAAS0a+nvoFGSa5FJ2aDFvw0wQd6lOdgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvYKoRbAWb+Zoi252l2b+OhYoncO8Q/WFZjt4ok/T7A=;
 b=KsWx3qeBE+daIC9KEKkjf72PCaoJrjW8JBxfib5keXZ5c1dnGasm45i4VAQHMHd9gU/NXe/P3rHgYfeq/z6YRxG/FeGpTM16y5xTCnHsAofsxSWxmDB6bfJ4NV8U/jWPuZVMOWwVhsVEOv1m9UJeZX1kmhXxN1JdzLyz6HGP6GkO95XjfRuHXU1t5tJxzLXpdi4d6+fRJSsfM/goAR42AQuYGiLo0w5YWfGPc2kUm/nVTgDHkd2X3NvpgYJqoEhjXxpJxQBbM80IwR7VyS1zLeSMGdXe+VU02yHDNvEHYyeXWM47cDoufQ0L412Bgil7Tn6QrWJ0Q/DlvicZL6vgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvYKoRbAWb+Zoi252l2b+OhYoncO8Q/WFZjt4ok/T7A=;
 b=g3qkSUE8HxGC2FzTABbGvYo++HMYpmpZQGpSCRCBMh/WleDdxEw2dKg1+MfdWeqvNGR/kOQR9yUCeqmzBuKzVdRW7ET5LW2jwkswjnzTKCfhB6RMP1CGhhgt5/Fpj6xuBXMCPOiS42mJg1mpLgOAOx2cncjv9IMk1BfHqRMjvkGpFTpzXerap2hmOLWbFXJS8UEipXGaxVkg0wZDNfTo6kQRSN9OSPoNnqyyYirFCjXKoMqx68Wehpo2ej0NXbw+0abqDwG8Q3tnmxDE4yi8gzVy6AQD8U1v+/ZC9VclbwhG77ZzHGgKgbpVQTP6QxKaTRrB0Km3sdwUTnmYzb0mdw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB6845.eurprd09.prod.outlook.com (2603:10a6:150:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:31 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 12/16] target/riscv: Set SBE and MBE bits at CPU reset for
 BE targets
Thread-Topic: [PATCH v2 12/16] target/riscv: Set SBE and MBE bits at CPU reset
 for BE targets
Thread-Index: AQHcpkBdaQFGmbVIwkyyP2IjDdT68g==
Date: Wed, 25 Feb 2026 10:20:28 +0000
Message-ID: <20260225102016.200654-13-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GVXPR09MB6845:EE_
x-ms-office365-filtering-correlation-id: a516f002-eb66-4d57-c829-08de7457813c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: T3dlnAyI5JZG1gEa+EhRcgjWAO/MsycUz1osgrecJnLpRr4Yboxm49bPaF/bsy31WULTr3cfgNM1CEcM2UK+0nVESvxMn678nFyNI0zKbcjA3dFnji+YxPMXLArAOHRTikjKbp3+SOr/Wo9nAjxKa5Uv3Waq1Jq1W0N6KDARf5qs0ArHkEhvG6ZUrc/8yUHwl/9LXpKqwqAllZ1a/3zJsDFt/039Mx4aCRPd66Bt+uCHbuncraEvZmbEgGgwimHyVp4y82GhWR0u4V6UqKLAYcsnja6mRaolatUihu4ucsY8QplxnFFUThCtDjAayfETRlUR4E3hJeI13Nktvk3pL2rtl9DuS+w5QEa7y2s5uxVPgzi/Q8JqCfOlrN3jKw9mT876E/QOmnP0Pr+NKpcQTSglgngw5yo7UMp+Uvpaayu4GLf9PzMmtvTi4NtyVeolRaLzwtK3tnJagntu++jY7P5OeqrZo9hjHAcG2lwZqpvdSjk+I6frfBUss1TtjIGYFl21drWQf929UY3YPaq6XHu1Yw6NhgEkbT0TKxZKrlURXql7B7YNTGkh2LWiXm6HsU9FKyvojKGGCuf6HBq2KSuqtEdQw2fX05oYp7VXcSib1nzaIV8K0zxxCs+cjj3oacdZd9EqL/ILioWFmWdSbW2IfFNzu8YslSTysVRIHIcxy4X2/K+aRMiRGe8hLzbSFYEkdhNFrjTVDU/CjwVRn+YvzKRjyvEM9rcjj6azHt9eYDwxPlp4y4iJkAp2R+XbGqqkl6LbfKUjgUZCrhdiyLiNXwQBjZq4IS+fXJ1AzB4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?18j2GaaJgqhXnHfIOftw/mck/G8wgzvwXVI8Xsb983JxV1LLkm3IRbx1RR?=
 =?iso-8859-1?Q?Udh5HD1DVifhSjlycMmj6eXFWsBnPteCkofaXXZDqpD7gybs8UDC/BcdOx?=
 =?iso-8859-1?Q?fRxCAqIcKR315aNlVSeR/rlPgQvYdPBTy6sJ1yhv4jdxzSWSrqdtWTsXvV?=
 =?iso-8859-1?Q?3ZDu92OcPmSekCyQMoJBzAAsRwGjJwjuQAmPc4Dw9secdRBrHqC2OE0Ajr?=
 =?iso-8859-1?Q?0UbH0I164wbAH87UFSQHR83SZLzz8asUtL0zBk0hIScVQky9irrH50CLFT?=
 =?iso-8859-1?Q?7xvsAwyZUjWPlVNPDO9e1VKoWMzz5Lce8AXv00CA3Qz4Wp9chgttVqbfdk?=
 =?iso-8859-1?Q?VVlvitmmMl+iG/szZ+e5BEPxzMFgKmkAfRQesFW7gobiABcgJyzN1aGSrx?=
 =?iso-8859-1?Q?ltM+TRezL8NFbw73TPs0o/z1D8GXJJTc82OIC25H3+q0QKeNne+QVtPG+z?=
 =?iso-8859-1?Q?u9/V63CUdR+3m0di9Ht6xJ7v0roCdBRxjjw0lpv0Fa4BbnSmrigvkZI9wO?=
 =?iso-8859-1?Q?61m/4EJc4EBSrwV44JsGauDF0xbxwHhGVSQxIdX9NUdt7FGJpgUwHP9QR2?=
 =?iso-8859-1?Q?TD1C8OIsM4hzDRb7nA9iWVorFQ2A/RPGNkIjFNaEnlpVs5ceBHHFOALWAg?=
 =?iso-8859-1?Q?duP0vRAPBBuvYmUpxe67S1aDr2mmqCkfiTJgfvwZB761bLq4TA33Wgs1RY?=
 =?iso-8859-1?Q?Nl4c0QmUtLgDExY3ATfMMXdSxR4pFcEdBBBQtvkd7IJ84zd4pBA2sDPbCe?=
 =?iso-8859-1?Q?oIh15lshG42LrgrQiPTyzXEU+CiukBuoYrJDBUkULVO6JbYmHNJyxlEU56?=
 =?iso-8859-1?Q?FTkEEGJqVNdeXd24XRyY47Qq5DBoXfwQ5zMLQ1MYgDBl83ugBSqa5jgetc?=
 =?iso-8859-1?Q?GOYCxZ2iq7ENfcEgyjdNLLb97RhpsNkzOoxGz0ToqDe3KB4GMjpEwNvB0x?=
 =?iso-8859-1?Q?1p/Oh21y9I2BhI8B1BQpcvOkLMnTbH1fjN467tt7Ys9fGOKs3uwTpW+6Cn?=
 =?iso-8859-1?Q?NRa7DdrjZeDeLvHjlvjCOFXWxRYydG3dYd5mm+v5EY77qCangWFZXyG6UR?=
 =?iso-8859-1?Q?nt8IkGroKtSj+W6pEsgIZOxkqUJHWVmUnzhWWXGkz6LyNu1BSf89bG85I4?=
 =?iso-8859-1?Q?msmJ1VW0WIRwM4JL3It3DCqll51Hj7ej0hOATgpsn62t/TivJvm7DHInl0?=
 =?iso-8859-1?Q?XbrZ+97b8/xY/vlFnezxTFq1K+PKhNoK7ml9VfImeSJtwWeMyBwXyjpjGG?=
 =?iso-8859-1?Q?VWDO6dLd/UBcRx0P8X/LuJykgoNuFPZkTZmtK8QJtzNszxo8orjh358sl6?=
 =?iso-8859-1?Q?X/mYLQbYQVMcjYRZP9yH0athbsIQpI+jnRd0EFwIwkFmo/tpyX+s5QvdTt?=
 =?iso-8859-1?Q?reeIVsOiExHe6XSk9Im2j/VZ3HDo9nZowmajnk7LjHeo1qwWBTK7uj7VtZ?=
 =?iso-8859-1?Q?CR4RBMpALiLKMEfdQgCazXzYaok3KrDVPbIhj/yt95RXRWRu/alQc2qY3F?=
 =?iso-8859-1?Q?ut9phisJAfGkP+fJZS+h6+U/XJhGiPF94Wu61BqOUx7ETEC8uQb4Q3tMn7?=
 =?iso-8859-1?Q?KBVrEvLXq0k+ZWh6Vq84MVZTjkZ3JUDPpdctRN56tp7bxtjWsTkadODdyD?=
 =?iso-8859-1?Q?N9TnqSUPdqUBaYwJqRliJCQHjiSp4OqaUKOOtt4uARAQhLO+GOrv7dV8ya?=
 =?iso-8859-1?Q?tx2t1vvjiu8QU2brBKYklX3GjtJLbsm7n56DBlz/yqpSXihfHVcmRaFG/w?=
 =?iso-8859-1?Q?lx9kg48mwRIEQHXajxgJlITCNQ4lMvYvPtjCDLkPBiCLEmfr4f+aGxxFgb?=
 =?iso-8859-1?Q?E405ZxFLPMJB1FSkQ0QkpVqMfsJzvDTrXJIF+qr3zPi1SzgPNoWz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a516f002-eb66-4d57-c829-08de7457813c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:28.6531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdxQpU2YPYbT3iYE+ggEDPQOYjEL0IKMTzZPXIGdgopM8A3so6xkEOiV4KDDa+LiJm3Pcn/7yeSI/5MoLItcwkI+tXS4NaDxD3pVwADvm6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6845
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

From: djtodoro <djordje.todorovic@htecgroup.com>

Define MSTATUS_SBE (bit 36) and MSTATUS_MBE (bit 37) and set them alongside=
 MSTATUS_UBE at CPU reset for big-endian targets.
---
 target/riscv/cpu.c      | 2 +-
 target/riscv/cpu_bits.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0e24f2cbcd..c446cae75f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -717,7 +717,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
 type)
         }
     }
 #if defined(TARGET_BIG_ENDIAN)
-    env->mstatus |=3D MSTATUS_UBE;
+    env->mstatus |=3D MSTATUS_UBE | MSTATUS_SBE | MSTATUS_MBE;
 #endif
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..3f146a43fe 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -629,6 +629,8 @@
 #define MSTATUS_SPELP       0x00800000 /* zicfilp */
 #define MSTATUS_SDT         0x01000000
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
+#define MSTATUS_SBE         0x1000000000ULL
+#define MSTATUS_MBE         0x2000000000ULL
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 #define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
--=20
2.34.1

