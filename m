Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E5F4BB72
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC19-0004JF-VY; Wed, 25 Feb 2026 05:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0a-000401-Mg; Wed, 25 Feb 2026 05:20:45 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0Y-0002vM-CU; Wed, 25 Feb 2026 05:20:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX9/6eLPIVrIyHgYYRr81ozcePiuBcTQl29owXNtu4ehN4BP8cAfS0Cxr9kKLPL51rL4aELf/iaJccQatckm+kvoB9rwmyOQqAHNMAnlcyrRG3fA+Lep+CMFGHe81ikxb74kWVgWld5o/ob4bNKSmTY+1ZlkXsOIpF4ahbTQN4P9Rr0xPd8aD3N26nBRnEME8xbfq3g381Vh+QM9ngVEx/tgjsA5nm9pElYnUOTUKJEpbABE9gj+WDUwMB5sPXeZUZNX7iccQ0PrHQyXc70qO6z+mY4mxD1aDsWxdp57cvFeotV2V1nMSeTHo2SymPzo8nx+mIUi8fw+7lguDmC2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mWOIzlC5w2Q86LB4/EiMrEFRravUVFaVh62GzE+igU=;
 b=fz4bfBfQwdG61QvbTAt8d1uoyuFJudOxCUqsXV0Jh7ppP3V1bI95oHHkrnMdOqaJzZ/VDGBsdhzOd8w+QZ8OsslVlV/VGwtGhQ6xOgBnyTmuRN8BjkxzVY0yp+6B4mbZ8p7JzQcy/MjgHplXaBe4CzYfjZ3fEk6vgcHihwzA6UgxhDESKjhYGVX0X+ajMfjQZlPywSdlcGrnZf+Glmgu9ZVWPwvtSaTt/ZHGiGLhE/PQWP4oa6dbawNw/206WVJcjqkV8cc+LeIjodD5TNoPYE81s8BqcvLXbIEIEtNEewdaKa1KxpPXjO3m3uxm5mn94Rs2Yif2rFkfXfqu1t1Yxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mWOIzlC5w2Q86LB4/EiMrEFRravUVFaVh62GzE+igU=;
 b=nup6sHb07el4ePj3rRd/5q27p9I9Egue4Qtc790Jz1kvQiBwBKGYGZNUedRv/gb0kcDQ0/4PJyT6oF1w0KOo4nrytM1GYN9q+M60L6hMffvSzNJNI1q7vYb4rUjTqBlJrf8Lp/SURwHwXuxfa4tHwpsBU8s41PgdGCSl6vXEaNoV8pMpAqT3uzynrQX1m6lKFs0F3JvBYJOZpGEafDDyO0tR3q6Fd7HFsQ32j12AyxKfzPjhCC+6DAK+WmjCmg0ac133jeq5KweTCHph0nqdhYn5jJ7pzsxlxoKUbHkZCTSJUaCwTLecVwoD6LlMVjQiL3OCbNYbTW7ZuxpZr7KzNA==
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
Subject: [PATCH v2 13/16] target/riscv: Fix PTE A/D atomic update endianness
Thread-Topic: [PATCH v2 13/16] target/riscv: Fix PTE A/D atomic update
 endianness
Thread-Index: AQHcpkBdA+0P8leGrk+8Ax7m0jIisA==
Date: Wed, 25 Feb 2026 10:20:29 +0000
Message-ID: <20260225102016.200654-14-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: a485008e-52b6-4818-317c-08de7457815a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 3Um1kWJaMescVqvdWLnmpf0VnxWeMlDMR3TaT7yA2TfpHXt2V0uM6aBVUkWojDJzIctiDhbsrR8eErrP0ir8t8c/PYNUvdYro9LVqcahP7ThBzXuQNNK0BCtz5xHoKH1MvVlzaAWnNSQUjinYtNwdKAp/0hj4ap9LVQWrsUqDil96hV5eQwmjECgoRHBXCWCHdzhTcP3DE3mBCRwpUp+0fFZTEoN+WHoHDPjCw+hrbaeo6D8ZanMCSYJILNqtO1VwxHtJ9BxNOLGp+uxhUsMAsOus2yL3h/Lb8BWLQvRK6MrYVXZIEbRXshyDyZey4Qkw1dylcn0vb0uW2K4/GqMbCixlXbmXiaQGRpeeoZn1QJw1ZMb7SaOChbSOyCP4g0swA9McN8+Uqy1Z5rSDGcMp8SkkmZbLrEmg/CPfce5WLbfgzDM+xcKE2RYgLFnWrimZtaPtAv51I97O6apZ8hZ6SpQnT/zFBU9d7bj9rc5oOwzc6+TVNq4QjaBQy+AI0t+/pc+VzdzVsAiMSYDxAZQ0588Dj0ATiPlW/ar+TPp4vBHDNSScYV30LnjEIYSept7NamL8sWR3crG+NiEaIM2eQt7jpUnkzS+NJro3cAXXV1CnweMiIQ2gSe6p1F4l4T4E2S3XIGs1U3oO2nU6oNsVGgtKz8uW1y7F1r4PhHE2p5oiedTkGnHfSsK7HeBH2n82o1MtUciaVYafwIM9ASyLX/RIpuPowJ5tFZihRfAIxPxVirI+GkW2EvEXitT7lBeP0o8ZDK6ZezsicZuTd4wrxUe2PiaNYUqCOA+mEo2i2E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TG6mXGDb+ujCsJGYbXCOIDevDie68KqAP7/dTH0FRoNpe1Xw6Nl2fzPzw3?=
 =?iso-8859-1?Q?bZ4HMthHXpDEygzXGdLVMA27zDBp01WGybCQb1+IqNdxxHOfD+Vim77P9b?=
 =?iso-8859-1?Q?+j+uTSvob/yzFmxSGP0JQLEzPf9gN9FJszYiC5cL1bSHFm2Q+8++Ml806E?=
 =?iso-8859-1?Q?4Q7MET++HwCslJYRIFpQk+W8dXuNu2xYY4Cbke5LjzegKGNQOkwUNxueTU?=
 =?iso-8859-1?Q?sy0XfimYYWpvWws4mNVoWw+JwjWPu0ULUbQ2LnS7Czsi2pw46TEkWjMgU4?=
 =?iso-8859-1?Q?Vojy3UMi5GAT7F4HJUTsfGsLbeVdMm9rln6YvQbkUw3vNOuu/XrDs1NQEA?=
 =?iso-8859-1?Q?1c7sEs7NWfamJJ/zBIcSEwADWUZ3H5iO/SO95tJYIPA7nbDPFbqVBrSd0Y?=
 =?iso-8859-1?Q?eRBu0uoVWXiF+6cVgyg50fSGvNT5PNxQyhtUsYfJbDaPUwHTZqoZYh8smw?=
 =?iso-8859-1?Q?0ik4s+RxwVGj4jyPdq7xOeBjJKlaDaHPRsL1/VYQ2uwusdMKfvvte4dSZy?=
 =?iso-8859-1?Q?uM6sLGgs9rcAVCm4wD0rxwx3dcmj8t1oQgp0W6Y7LBPJe5KjIJB63wZByT?=
 =?iso-8859-1?Q?RYxbimvPyyYLkESn+388NotpVDON67QcScwes82ZGxDROQX3CErkFC31nt?=
 =?iso-8859-1?Q?J5aCsZRYta0LeDD9Fbiq13i5vIR5Q7q/xIb3qsIaDntNC7UplKkf7vrIFD?=
 =?iso-8859-1?Q?zEsJoVgnd+GyuRDqVFDtzNEVKT0jzS7PugHC77HabxV91MbFSVakLy0P8z?=
 =?iso-8859-1?Q?e7ZWNE1QBvauX/6HlB+mrrB2EO9FIhcwNwBtWSCzS5UHX4/2g7m6Yxw+F7?=
 =?iso-8859-1?Q?Mhq79AyUNMP0YweXNPVbInhCM2Vlu3kkO0ZjYAx+SKgX2SZAn9vlCUANzL?=
 =?iso-8859-1?Q?4MuKBiq8UD3PRsGapjkOPlXUUsurR6leJ7bX/RRB0jqwl9o9Mdj8AVNYGR?=
 =?iso-8859-1?Q?L2cm3awa77WQgBoqRDUfTY62r51h3pdBBcnqpShN1wrV8WKj9Ra+VDLbR5?=
 =?iso-8859-1?Q?YYN+P9qpAKfVQ/gFNXFOkk5Kor0yXC/x0Il1yLejLYq9uGzZERknFokSg1?=
 =?iso-8859-1?Q?gX0PgeE+2GLeYxUWs8TFMv6IcJNDGObEuwZ9lyEGY4oOXE7EUqwIaPR8I7?=
 =?iso-8859-1?Q?+i+PMHPUK9HBplrkQyUsRquPRYzDjymcM/gyTcU9+uKZa5jFf46JQykwhq?=
 =?iso-8859-1?Q?YzroPJV9LcMwtmyeWQxmcNDamWZ6idUp4x65ICrk2t7KDPclvOJb7CyDZ/?=
 =?iso-8859-1?Q?YiNPu9fDxksVQ4Bg7+4d9y1oytQu8nYoVWwIIQIIXNWR6UhVlR/Q5WG3wz?=
 =?iso-8859-1?Q?BLGltaPBgNVP7L5GTNLYpne2jJiUqpiS7HPvdh90z1GGzpKPfZJ+mmJ4HQ?=
 =?iso-8859-1?Q?uNhT0xCuFlA4Bj3Tr7uPNR+CMprzcPEt5G+M15jRqkdhO57lac6R7YgKpP?=
 =?iso-8859-1?Q?vzpssvy5fF0j9p/hUXToSqys6byY7sOQ+12xC8XECnV83+UxHYQMJpP0Zu?=
 =?iso-8859-1?Q?ID62INuZsZWsEQMZMPz9WzlOAc4Qsg1OlXptCS43KTcpizRk6TBDE1rQCy?=
 =?iso-8859-1?Q?571ACu/guLzqQUXdGIHW6dsz3T7+njFU8UIBl7n85qLqGczLNAkEv2MOoy?=
 =?iso-8859-1?Q?01esHRfwFH5QXVj8o2kb0pvz9R/PIppvsDnG7bBhnh65IY5InMrLksdezz?=
 =?iso-8859-1?Q?iOXIPKn/skTJlh4Kn2PiV7Qcs+whJfHR+aeioes5IkTV9tAk1bTB5iJ2c7?=
 =?iso-8859-1?Q?e1IefUNe0T9TZ1+ktyD3p3JwJThYGmLQRtAn5k9TRBq3UWH9MPoysHrGjN?=
 =?iso-8859-1?Q?VdDNty+IqQpZYVjxsjvdbufE2Sn45CXCHpuJofSKxpykPxapPUAJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a485008e-52b6-4818-317c-08de7457815a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:29.0876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/ze4TsqLTw5EcEkiGEHA9B2vxGCN6VeqVHfI2XMmVp3dM1Yr3uMj91d/XzaH/aGssDhZbHzA01SYMjx6ziRLdHkg8atgWtyXKG4BtvNR6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6845
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

From: djtodoro <djordje.todorovic@htecgroup.com>

Use tswap32/tswap64 instead of hardcoded cpu_to_le32/le64 for PTE
atomic compare-and-swap updates, so the encoding matches how PTEs
are read via address_space_ldl/ldq (target endian).
---
 target/riscv/cpu_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..f6990b2dfa 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -37,6 +37,7 @@
 #include "debug.h"
 #include "pmp.h"
 #include "qemu/plugin.h"
+#include "exec/tswap.h"
=20
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -1567,11 +1568,11 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
             target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_block, addr1=
);
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
-                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le3=
2(pte), cpu_to_le32(updated_pte));
-                old_pte =3D le32_to_cpu(old_pte);
+                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, tswap32(pt=
e), tswap32(updated_pte));
+                old_pte =3D tswap32(old_pte);
             } else {
-                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_=
to_le64(updated_pte));
-                old_pte =3D le64_to_cpu(old_pte);
+                old_pte =3D qatomic_cmpxchg(pte_pa, tswap64(pte), tswap64(=
updated_pte));
+                old_pte =3D tswap64(old_pte);
             }
             if (old_pte !=3D pte) {
                 goto restart;
--=20
2.34.1

