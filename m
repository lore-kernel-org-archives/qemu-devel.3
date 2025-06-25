Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37965C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxN-00070t-7s; Wed, 25 Jun 2025 10:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxK-0006z3-Jl; Wed, 25 Jun 2025 10:18:30 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxI-00048J-NW; Wed, 25 Jun 2025 10:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7z3bgR3cB8TPkfCHMchpNAjid7SmqBweMFz4wiuKnxh160xb61FhvvF+dpCq4tZAcMNviVZMf8XOc8TTs6zrrgwSXe/hgWtKigZY+0J/oXycrE/dzLXnux3Mio+CAXdC+P7rUznG20Ycl2QgW/sXAHznz6C1wbN2+eyaEgwjKfUWBvVkFBxpvFGNCjY+xgUjFTwq7J7Quq+H7GfzZIile0K2of3fxdxRQMyVnfyPwmrAUwcH9f/2I+KR2yYR0NS5hChoyaoIPZizSlLlJDOimbm1FQTmE47yva335p8H67z+W83+RHBe9yDCnv2NIUrxw5zlpg64G4Bz+b3u1y1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5s1ND7wGepanPIQvZqOj3yeue0gSY076ymvJTnXwNM=;
 b=T5trUGso5RyW+sg2MHed2/foeSqruQNedF5sTRTI/plt04CH7tPC7a0qnFO35AAfyReVrb3tu3sWdT6U4iaqlbgVjHNXPd8Zeeh+M7OYKnpOOBC4TJXnTadZnO9gK74j5cZn5CFibTN33wYTh4H6gZGr5DaPHTOv0dirrJpz834lQY2va4Bkedd8KIN4EefqyeQgxcL4SC2En1FQ69EeisvPnUeN/lvgs4uPfF0FQgoQ6tLiNTrp3d/TbeR6Mw64beijZCocJsyHHCbWwKSi4tEU3LZfyxF5OlSasuHr+fnhWFSGhVDDICGQi8hInnzHJ0b5XAtu4JVPgkSffoibeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5s1ND7wGepanPIQvZqOj3yeue0gSY076ymvJTnXwNM=;
 b=HNLj75HrAxRL7Q7VLvl5U+fS7F19+dq2V3YJtqfr+NXjOuHVv1Hdwe73HgLeMxX5/TB7v5MlUUdQVstFJ56MtMDNq+naMxexQz4pCVWmt9DEDTAdCY2qfFbTBO27Pt7YfCbNCITbhetysH3XDJO1wRkHGeNdbhewjCQjAEWhqMKjtUPhMPN3H/xu5Dy0jvjD1ynlJoP2Qx+q7KCL0jBI9JKXj5MEeQ+lieciFjFO2n5TU/5Z1Jtt4/0fkattT1faYMZTfLQW12QFflbbPZXqPQJpesIEhoXG48vSrQDD0y0fgBANf4zbp9Wizdy8vHQaDRIFwySZTMEcBuncJrE7kg==
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
Subject: [PATCH v4 03/11] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v4 03/11] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHb5dv/5gHYVtcjWE+1IYiHJtPjlA==
Date: Wed, 25 Jun 2025 14:18:18 +0000
Message-ID: <20250625141732.59084-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 070c1fe2-d010-4c8b-ed1e-08ddb3f32206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ui1gjfsIPUeLVrn3GwlTr1saBqy9EsgjK6E022v3mmKF+h8vGHQJsfCDhr?=
 =?iso-8859-1?Q?semeM2ZIOPyAnkoLDIx8uUyo7l2yAxitd2lF+2XvRtmCKItUadjLJJYJiX?=
 =?iso-8859-1?Q?kludIYq/mVkjBCPo6X0y2HV4I8QtjgtcWhlRnywahizeQlIkpORj1Ax7Aa?=
 =?iso-8859-1?Q?mg2KJta99KoY3m5X3UndO3QhvIhidSrTpwJ/ZLOjpBmPaNytQhdHWzaZeE?=
 =?iso-8859-1?Q?P3YczgaJeGM5PMiA3rTtQPsakuAtSGvluU6cTnAlEl+ZBIzSPFJ5MyxmQp?=
 =?iso-8859-1?Q?oOdSy2dVJJzevcpKIJ81lBT3W7w27Buo4buRD8MGX8SQeCl5cWZuzdw9j/?=
 =?iso-8859-1?Q?xVmgZh43I4kh5Y72JzuYb7GOqUggIHE/RU9ajQ91Qifrt3uffBiiQifk8H?=
 =?iso-8859-1?Q?itsneTwq4mVQe/YqlySkriN2BjUTfdirdpRuPGPU8fouGHUpT+xlNum8sf?=
 =?iso-8859-1?Q?66SsQnCjfypBgNPNCoVkqOqX3F2dp4W7BE1vw3KNOZv/ZqqePfe8mkKKC1?=
 =?iso-8859-1?Q?hZ3I6NPOhKoO+2h0fSbhBT2VXJ4f7bYvRzN6QaJbTxXPPd/khJ1j7eL90+?=
 =?iso-8859-1?Q?gXu2+79U9VVjs3DkMtqcS0/zX9L0002Rehiep1DucxONS7t4TJMQJNk11n?=
 =?iso-8859-1?Q?FqgiV7q6uhDA1vcYX03UADVxfDuf6fWjehpRHWQ3TaGQCE9KXC/T2+bK9k?=
 =?iso-8859-1?Q?FCRr6BfJPHQWMGnGwBNdY+T3nMmlD0XVLKd7gEt+5GqNqsWLUngrywi+oc?=
 =?iso-8859-1?Q?Eun7qBZvslZ882X6BZ8XuBDti1wJJig+fZjXh1rPN+dioR0Kl4u9P/WnSK?=
 =?iso-8859-1?Q?B+89CnG8CYhKZmZGoz3s82Kl+PNAUcPqsMJfQxTR8n7RTmdoFaI0yz/ajC?=
 =?iso-8859-1?Q?CAimtZgymh8gU2MD8qZJYvFOeq0qGp2rBkczWANw0pjxFMBdPbNKX2kGDb?=
 =?iso-8859-1?Q?rzNWbXQDAEfq1Y9Z/ba3LoIlI6yaB6iReB/efdCs/5U9Z3LWXt48b0nPxs?=
 =?iso-8859-1?Q?nzcOtyZOqeLGn0r3Q/QRDeOdLcV+ri4Q9wjTVktW/DQLvShe9GaZbx8tEa?=
 =?iso-8859-1?Q?wWOrwRODZht60GZngsn9uRMXtLNulI/SUM1fo1K7dDsVWZ1kwGKElt9Sor?=
 =?iso-8859-1?Q?qQ1Oh4Pbw6B6JbRq/7lEH+m/VjQuR5lSVn6tEZxaQ0B7k9tgtUj9x9S0ji?=
 =?iso-8859-1?Q?IGdCCeti3aQZhYCDWXNKMiNcZzTfpFC3DzSekiRWdwTzF9bHVPahgnlw0R?=
 =?iso-8859-1?Q?ldn7qw+f2SDzCsLUgb3PPgkzW2d0Uysg5mPohedMlD7ScNABhcu+nsTkJD?=
 =?iso-8859-1?Q?hmcRWSM15rR8JZtb5ISIDc4+1AkLbOGnOP46H6osXxaL9X4FgYHj7eQqes?=
 =?iso-8859-1?Q?1gknTMzeTDkwJjx9piRk1h0OSukZTZmpgDdxe48BU1ZOtjGogMGf+Y9lQa?=
 =?iso-8859-1?Q?zzOHEQws797K9Byf8bWgDf3549N8qtD/7JlXbDCqjA7Dmb+gMU0+5sSPxs?=
 =?iso-8859-1?Q?UiWbhm64YfHBbtKtudgrWlklHj4nqRMiqhDxlkUzp7/g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1KLW2dJWc4JtlLF5teX/ioVj2BfOEyR34J5stUYCCqHAZsaF0wRV6oKRfe?=
 =?iso-8859-1?Q?wAewrL94CQGow3Ujc7E7SEU87Ivs8/xzsFJdMV5ukczE1cGsSG69ndWWAV?=
 =?iso-8859-1?Q?/rFdGaNPV7RchWWTY9WKpahjl889IzhdFqv9C98tdY4s0uer7HzQDg22P7?=
 =?iso-8859-1?Q?Mucy9jhoCcLJHQl/3t3d+w5OC8oPTqcK1Xbr08Ln8fX5SqJIsdwoNXf8c1?=
 =?iso-8859-1?Q?RAzSN90vv4l8RQnO2sR6EG3oOtVaOKlydMOkiaWMlddG2ZY0BoZ7LMigL1?=
 =?iso-8859-1?Q?rGKoaBBIUOfCkGuakfH0qk6JWEpH3gbpdaNU2A6sZ+VxaTi2vNljx8Oj8S?=
 =?iso-8859-1?Q?wjo21OCBz/pd4iMz4lR/9HDNRtM+mg2hyqG++PnemiHbV9mmhG7ztZ4BL+?=
 =?iso-8859-1?Q?MdZfMYniP3RJn1tV4jkiDEIEwrzIqIYiu60GOUPKYeOt2usJlFIHZr5RYq?=
 =?iso-8859-1?Q?lZM1u2nmsQdgI/eoN/BdIU5vxG+mJxON6bBOR4XbnWppuqOXqrP2oIEMpR?=
 =?iso-8859-1?Q?6QM5CXp1Po8+HwfaaG4lzPbX8GyPu6MDNVGGR/pUERVvQq0LesnlKrCLzc?=
 =?iso-8859-1?Q?n4LZWAeomeFtxt6+4U43rN7c1r1sFstaZDCoANCxhw3inw+ghGsNBSMCdh?=
 =?iso-8859-1?Q?sGuLabtK7uXKF3tUv9SxsXqMIz3LKI/gXm2HHAEA8RUsnE3R6Og+wiwqqp?=
 =?iso-8859-1?Q?hZT67WiE38HBCPrYoxDjqhQ3N4tX9Jtzk6PCumTfxFPQzaqMqGFmkQMrda?=
 =?iso-8859-1?Q?9l410JAJ6mKIjmVm7iOCq/gv7pAhOqcdwFFy4DUFsN497FHBzUtSqQCEZE?=
 =?iso-8859-1?Q?H+hwNs3Csmxq3S8KKW68pVtfzUE6jMF5gW5brgUkg1x9bAMgGLIYamKdBy?=
 =?iso-8859-1?Q?7lMZrhCXNzIpH+XlBtGP0lesXNZ7zcGmvPmZdbcX9T3xsubQ/qNCZczLNC?=
 =?iso-8859-1?Q?s1dqjGxGtqZM4lN/8c4mPdi7UiRE9ayOk1O3PCd7W0XB4RSpp1EL48/uQk?=
 =?iso-8859-1?Q?4pdth9bLJmeC1ut1D8nkZw3bWWltZ3bkPAulYZHqBSfUZYH6sfowWey0eR?=
 =?iso-8859-1?Q?z+iOmxnmSEzM7FCkZmX/JXFykUR3JmBwfS84TO0aZYCjhZ5+r15QO7KMS/?=
 =?iso-8859-1?Q?KXbD55zqmTj9o5oQ0P5I6AhFfqb/hUHRFoA51LNSN+lj62mZ17g4QEMgsV?=
 =?iso-8859-1?Q?oqVxQddJ1daHjbVMovbD4Xbu9TCi3L3Nkm8jnhYIprv9hs3W/WPzWgUpoL?=
 =?iso-8859-1?Q?qoto6Y4kVvJS+I0zxMmOJi1dzV22S0f4HjhGb4lVHakQVwLDb2U2QA7MGQ?=
 =?iso-8859-1?Q?04/FlY7Xo+npsoYMIMIpXAMASvBpNNEtq5FWggJ50Vp9t9ioHKzyhUyPSa?=
 =?iso-8859-1?Q?pY0o4bBdT14JkDqVbX1uMXRw51HHqxoL1w/Dfqwnx+sir0gF6jt1VLICaF?=
 =?iso-8859-1?Q?ZuSaHdSJ0kY7Q8EZhjtYcHVQBqMdrrXAZlCl/Wt/W89TaJw0aGue3DngzH?=
 =?iso-8859-1?Q?/+v+DR3xYbvwJez7mzLhcxADlRfsv3TwdmkFxp3EJP/suqsax0ywhdoyvf?=
 =?iso-8859-1?Q?BoMXOktcCzt3HxuPqhSXVZcWP9Xv5RmKl85EJZUDXrREia5YhVj5z0DHJb?=
 =?iso-8859-1?Q?jNWLtnOOVb0shrIUIyivNX8IdYX0qgzaLXsbwt49ataTxT4Cz80EGqiEkA?=
 =?iso-8859-1?Q?ua799rUo6VInqln/EhY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070c1fe2-d010-4c8b-ed1e-08ddb3f32206
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:18.5665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIIdtf3g0crbePqmNx/NtCvtWbMCXYrAmp+dk9dPiJyK9i/xGaPfoGTS1xW5/VNoAwArvX0yY9tITbU9omUt8jfhHn7wtJ2Jw+WAVWw/GLw=
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 15 +++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..1e62b96094 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..672e30378e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3167,6 +3167,21 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV39,
     ),
=20
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

