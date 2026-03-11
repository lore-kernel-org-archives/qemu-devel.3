Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B81062871
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEI-0000I8-2C; Wed, 11 Mar 2026 07:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDw-0008Gl-95; Wed, 11 Mar 2026 07:59:40 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDu-0004do-Oa; Wed, 11 Mar 2026 07:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9kQQi2vIaIU9IIy8cHIs8pbrEjZkv/0CfFfkDcKdK8iK6de0lwoKLC7ljyPoTmWttQWJ+xYDrz13Tvsds5LINYuMOIU2QYX//e8/gbmboiS8U61WjsjnaITXndrsm67c84kYKnGMulrCXFaMZ0wp/fQ1q+JLI7C4Su8jBESs5m63NdbFfYto+yBuvGfsQRUab5i4S7VwdzVNSEzxnUa68VOHV2Mj2XxrXmYXh+3MoJQfiYA5GshAgpmCgpw3VLDzwU7DByPeSN0nOY7QncSyI9h+dKNOV0x+966SgrkYIEatom7qTO0iMaoO9i1GNIN2ma0jIFaYvri/X9si9bNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n6E2MSxiqkKsSp7HrCz7LjmyI+FmXyYjxobjKU8SxI=;
 b=lBfbK8afOV/DMNfGG08NHTthpTGAKXbufG1a1DSYnyJ88ARYH8r5xxQhlks9sOgzm6X2TESjiXY8bxDDfmf6mzgzHpb82CC4LivMN301bklQwkLY1Hlj7NuYLjIWHVQ8nc/Z+iP1BgHZgLDNmJQCXdHq5Mf1OX/y/vH4DXvkDTderfUfkg9UEY6UMElBbcjxCpRXPoR8N6yJ1IjavWzZKDOfSqtFC/CYShBnm83Zqzp8Aj2bEJf1fd/3bOYiaAsTOtpBQ/lDqUPpl1gBQKoJD7aV5Iit+pmZ8Nuh8oJxc3jYWrR3Q1ubfTufcG2hZHv52gWHXxOSfGxy9sjyBkecTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n6E2MSxiqkKsSp7HrCz7LjmyI+FmXyYjxobjKU8SxI=;
 b=KeWq12Z5N/DXsGZLmzNcw7/9kFTfA1TcRvb8ae/CMH8pIYM8zOZ59RZ2kZ7FUCGLjYKOX8HfhfHRUO1C9IlKLwQRLy9fOhyrPB3m7Z9ZqEwRURjf5gp9TBy0WnGAT52ErR1ztWbtJFfhdemlwRlPXqcwx+CQLc8W52KNrcC0Y6muu9QsPLRAtoiql1gsN98YoFnOdkBiIbVzFLbvzI7f3h8Tr/edgJGg1Mf2G4zZsunjq3tRZq29ZIWOaMFcq8VeO5G34EIzQUjUNmzI/fMM4JKA/FXVGnZK/w1NLQI4x2WydwthcCzRONqhqt0WJTh5n+84TVMoTL2EJWEKPqvnzA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:20 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 7/9] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v3 7/9] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHcsU5+8M7u1FBfEUudHg0nX57WTQ==
Date: Wed, 11 Mar 2026 11:59:19 +0000
Message-ID: <20260311115910.564481-8-djordje.todorovic@htecgroup.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6069:EE_
x-ms-office365-filtering-correlation-id: a5920a16-efb7-4059-9dba-08de7f65a117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: LY7emsi9f4mp1Q85MyMdGxXcPVlXT5glqn0O4D78A2/31hcfKeCpNJwIjp8ji6RyOy7dBzllIkI0Vf7m1R3dLIcipNvK74iNhKDfS5oUAFGfZZFHlcLIkKV2SvjDtR7g42eDBkqBsAPF+eHLSaopfcyFjN9hzbytYek/T7KnqRXnkYFfr68/4se/WW8tqGgyMm75q7Ags/VpNgtGId3b8FmBCJFWNDYanjsZYqC4WynZx2Q8g+/674C3sxIGyDBx3noxSJUU28jKadmJs3bQy5Ug10tsspzkfWJBsqOYnWrqx1dsQOrXv1/o1dAmTcg3F7nMdr0Y4zo//4gA3d6g539B/7dwk4mV+w1wVYX+/vlwWN8CaMTohx94411Zd92OKTrVMcNv/R/Uhp6cLfK96ie0RS48ckMVOpz31kvUwF0odNVXRaG7Os22YBNwm8JJpQP+Y242RLiVW2vL4TDkouQK7rXPLbCbZyT/N0+Nuc5YBsoNhhkUImJ9zMJ7Wqi/w7cyiv//snJnqeR/Syzg05VHT1vfiV4XbpdrFXpeaPmENf+F8/5XnyQG6Cf6yePVoAcikSQVdAw3+jm755NPh8pmOyyyFvpXWNQBEYlhbwY1QdrzErME1+Kp1xhbwFMwZ/9jjP88kVaKjTn5dgFkwjJwCzgwLXAzk+XcW1tEtLkBsl98UFt7DZvJs45/tUyEkWDAAJNQMP2ksiLG3zdLQG483UOLbn0eu7wysFflfEwRDVz5kiJMy+MW4S6lC7hjIFPa4pksxea+eShVDWICanPwGFVUfgnD2nVbkU0WhPo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yN483l09jZvegKA4fP0nHFximm5/tTPhs6q5jeXfUM0QBl5p1voQGPMXHe?=
 =?iso-8859-1?Q?7OwsvulZAzeZ3t6UegcEZT+mjTgcYpIw3h1RpuVqT92VjzDaGfjZyeCAeJ?=
 =?iso-8859-1?Q?mvQ8dNAen78Uz0mQ+ymLAGziy95yYG8UD+hINYm8hBJ7LZq7FYpZOS+hge?=
 =?iso-8859-1?Q?K2ZQyyncQipUws4JsC5K5byYwUYk8zsaQQCTRpkmydxY/JzyLXLMNRJNZQ?=
 =?iso-8859-1?Q?ZHdFRCugbiOaHBHGQ1U5ykAhv9VsZismGwjDlQ3EObo+h2nwhIjgBY6PxT?=
 =?iso-8859-1?Q?brEXpFGyJNM19CS/R7Ycx1wySCJeHH7hlWJ2c5z1CygkyvCXhRvDsJdIck?=
 =?iso-8859-1?Q?cB/f4TvOsNpbWAlRiKpnr1zZIaBpOq6UVBYBsS+WA9/c1pCuI6+0vn6Iua?=
 =?iso-8859-1?Q?pSSE2O89Oj5YIN88qkLbUoSJFN8Cs/ocoeTf2SaIfGK4ZS3chRNJO5qCsn?=
 =?iso-8859-1?Q?hmykdYb3K3ua384nk065FcocyYqffWnpp3hKmQpAoO3O7GGroZOCbjsIx3?=
 =?iso-8859-1?Q?YvAq78IpTlLMgRGyQAlHi3JL6hUuFsQ7UG4JcgzXfoaw8vGampb5yt1dmK?=
 =?iso-8859-1?Q?WlpSh++Zmd+StZwACOE0X42s2xQyMSRJpKvKx6+H28MfqFZjz9rmdqQFBn?=
 =?iso-8859-1?Q?ExNvP93rk6jXHIqMYbLM3+657PPfy3ZRieeJ7gytRHh0y3voRg1oMiIW7p?=
 =?iso-8859-1?Q?ndhkxqixTlTCYZsiH/PdjK9yM5lW/vYo8fGYyB1WVyg2wrz41a19Mj2cVi?=
 =?iso-8859-1?Q?do93kF6VDhJ3rNznIzoyFJeCHofmt4dNHmXyGKLFh0dd4tydkSbaT+W0NN?=
 =?iso-8859-1?Q?YgEWkWeQOkghvQtkY101UCPXcTy7i/j7kakkHtFwClUUq5O2+Q+tZU6x1o?=
 =?iso-8859-1?Q?1cOWC6DrDZX6wja4W1X0Q0umliOcLW3Jyl3fpHnO3ololNVNkfT/Xhkj3T?=
 =?iso-8859-1?Q?GheCwoieDmH+lv2WA53ccprUd5fqv/hcwdsnARJDn6AtDCAqcePxGzCrXR?=
 =?iso-8859-1?Q?OVk9LItoWe4Z3o5SB27JJZ97xoJ+pYbdFKOVs0WlVGJFYA6LlptLOdfzME?=
 =?iso-8859-1?Q?BviQxkhHx895zZoq5HK6nmY0nzPWIyIcHGFU5t8e9tYvA4APeq+Ueavfq4?=
 =?iso-8859-1?Q?OMilycIvEHVderEcXw+Bkuy1810U1KEIYTRpM7Wu9NhJI4QHJrlPyS1yFj?=
 =?iso-8859-1?Q?SYG7RXiVl2zX1xqIl68uAYiWX8ZqA9m+ui0ijm0bUQ3ot5/PZrhzVqRf9k?=
 =?iso-8859-1?Q?LnmjYZyLwjZPfCOl/ZolxTIiZbvDq1OPesDH6EsT39pdMENu1z0NcsTqhw?=
 =?iso-8859-1?Q?NcpIxRMjFYN5LqGlMBHOV3M5CeHgwbVHKCGENOqw0GeEScAueYvvSMV3hr?=
 =?iso-8859-1?Q?uc6gdotT0EsWwqj+wn3z9ptvetaWC91pNQQHNkwYpthO6PQbKpf3BFJ5o+?=
 =?iso-8859-1?Q?n+qRF9ejDvKiKB6+POXqQJ/n3sJe/qk6L4nH/yeQLNwc1k949aKMeWN9Re?=
 =?iso-8859-1?Q?oXbNeqUOmzgZr9X6WjZ3R6ghzPceUEN6Vb8V+NPJYSOXkzls8AiM6j4jDs?=
 =?iso-8859-1?Q?16ebJnYxywETfSGstpwLud0iGOc7iPUVA4lFM/MZgKN32gF0hQHjqbLpbL?=
 =?iso-8859-1?Q?G6tBhnnEi5coLHs4Dxdrrwsyy2RO6qidvv64vwiuo/ZjctBWOWwFILsE1O?=
 =?iso-8859-1?Q?9B4cZAajtglTSelndIJX30iw8I/DirTF5rkVv4c6t69BKmPuxCnplAnFgm?=
 =?iso-8859-1?Q?Vxva5almq4jPyQXAEZlQwpTGMlk8amqaXrfKvVk24czZoiU9vBE3qvXB1B?=
 =?iso-8859-1?Q?Vj8Ne+APYjNuUckHCpHm90dwl1BXcawOXHfKsrZCntn4aAGFGeo9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5920a16-efb7-4059-9dba-08de7f65a117
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:19.6260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OkpBLNINf37aesq6T/g+Ta98VdkRDiWSfaenibtRLFp99VQ0hftB5I8ETU5/HVXCi08uaVwiwuwIE2oRXeOIlN3X+Czr/3ECqDlMZwxrs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6069
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

The page table walker reads PTEs using address_space_ldl/ldq which use
compile-time native endianness (always LE for RISC-V). However, when a
big-endian kernel writes PTEs via normal store instructions, they are
stored in big-endian byte order. The walker then misinterprets the PTE
values, causing page faults and a hang when the kernel enables the MMU.

The RISC-V privileged specification states that implicit data memory
accesses to supervisor-level memory management data structures follow
the hart's endianness setting (MSTATUS SBE/MBE bits).

Fix both PTE reads and atomic A/D bit updates to use the explicit _le
or _be memory access variants based on the hart's runtime endianness.
---
 target/riscv/cpu_helper.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..052ec19b23 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1365,9 +1365,13 @@ static int get_physical_address(CPURISCVState *env, =
hwaddr *physical,
         }
=20
         if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
-            pte =3D address_space_ldl(cs->as, pte_addr, attrs, &res);
+            pte =3D riscv_cpu_data_is_big_endian(env)
+                ? address_space_ldl_be(cs->as, pte_addr, attrs, &res)
+                : address_space_ldl_le(cs->as, pte_addr, attrs, &res);
         } else {
-            pte =3D address_space_ldq(cs->as, pte_addr, attrs, &res);
+            pte =3D riscv_cpu_data_is_big_endian(env)
+                ? address_space_ldq_be(cs->as, pte_addr, attrs, &res)
+                : address_space_ldq_le(cs->as, pte_addr, attrs, &res);
         }
=20
         if (res !=3D MEMTX_OK) {
@@ -1567,11 +1571,21 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
             target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_block, addr1=
);
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
-                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le3=
2(pte), cpu_to_le32(updated_pte));
-                old_pte =3D le32_to_cpu(old_pte);
+                if (riscv_cpu_data_is_big_endian(env)) {
+                    old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to=
_be32(pte), cpu_to_be32(updated_pte));
+                    old_pte =3D be32_to_cpu(old_pte);
+                } else {
+                    old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to=
_le32(pte), cpu_to_le32(updated_pte));
+                    old_pte =3D le32_to_cpu(old_pte);
+                }
             } else {
-                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_=
to_le64(updated_pte));
-                old_pte =3D le64_to_cpu(old_pte);
+                if (riscv_cpu_data_is_big_endian(env)) {
+                    old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_be64(pte), =
cpu_to_be64(updated_pte));
+                    old_pte =3D be64_to_cpu(old_pte);
+                } else {
+                    old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), =
cpu_to_le64(updated_pte));
+                    old_pte =3D le64_to_cpu(old_pte);
+                }
             }
             if (old_pte !=3D pte) {
                 goto restart;
--=20
2.34.1

