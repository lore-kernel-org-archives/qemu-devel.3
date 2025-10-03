Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2626CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dIl-0003Ve-RB; Fri, 03 Oct 2025 06:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIj-0003RH-CV; Fri, 03 Oct 2025 06:46:13 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIP-0007P0-2D; Fri, 03 Oct 2025 06:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZKS4eGuoZXA71ooG6xaXytlb6HleCr8I29QLslP80LmrPEOj6PzAkd8V/864IxQY4JXUh4FVkUMUptG/3GHpJjsYAlg3fcrYEuPTi7V/Q58Xjz9+vHqe+bfueBoSE7OCg8Q2CPYTnWOY7WZXH+d2mQ6Rh7CwwcjbT7+BFDdqOrcWlAAIgozmicqHy7DCKeGWMtXRNg2cVkE9X/onIOEqwhO1sA+ljJpLz2ujKPpkjZG3kRh4QZrXxMpMbT694h7cbGBrZJq/ksmZ1Pb1YhOPINah/tTdVNmUkxDnZb9CbnR5EskKGnRYK8siaxgKdmDq7PJb+xT9iq4vr25sgfaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=nwSF40WC2ssDSDcpndmLcaNZS/8Qlc/BVyDRLuS/fuA8DQlMMQf+/TIAzNqv5lN0d1lwYblJ5tz1hEjuuu0h6ujvmL4RhhirXaKVVBdlJ1mujC5UzxL4QzmxW0ZPFcSMsUjJbtzHrf3PK41xJrjnIcCn8oZuecVm5+YOyWVChKgwWBdsbfyohN6zpSKppQkSdVyVybIIgBykyuSEt64XSvuk078IFR1QjMVLpeA1W6fX1C8A4GKlpkBIHhcavfZJmoEy6fLO586FYE3sodD8hJlQe3fFV0ytMotCHmv4uDatP2VOd+RZ3Om3uirYyhgUkeYfon0ANxdgxgvp5Q8fYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=BrunBYz6x+Q+mwNWxqG2TnQMh+buUBCMq2WTQ9zTGfi2tXk6lxY666nwNOnDFHbfTgHd+UvRzGjkxvtxo0dzHxOExZuLYgz3Gn6Hdy+qWm6WR6QSQi924hJpdV8KPOtniQyiqWy+1+DYTHJCKnJQiYIBzCAepw4vKbVPqkdTCJl2r9xn0FI1qZJEd82oS2r0Rb9gZojjX/pFk5exHxhAhLw3k22F+Id2gi9arbIPJ9SkwnSjCay5SlieF42Pz8H5KQdotM8UPIo0MxcieNqrvraLMfyUNbh4Jkme2f0/rTbz9VNIziKfeTgYhoIwISFywekiUsEMOpldZwwEbWkw9A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:20 +0000
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
Subject: [PATCH v10 01/13] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v10 01/13] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcNFLQcEsATdJehUKBbNqiJmuADg==
Date: Fri, 3 Oct 2025 10:45:19 +0000
Message-ID: <20251003104443.51501-2-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: c80bb68b-0d87-435d-8ea6-08de0269f2b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aT3DtLcT6ubc/6tUVz+1hmH2IYl9By5EZujJneEhlYpdINtdScmbrsLN28?=
 =?iso-8859-1?Q?YX3HYDdNJaFd15b/yH62GsRBkUuYGTVWdWRJ6ccayRtTYSdyQM0i+T0Zko?=
 =?iso-8859-1?Q?FqJbVi48D/ezRINNalKMDDzPTYThvVsK2LaK+ByxdIz9mS4WFb//p6hryy?=
 =?iso-8859-1?Q?QEYsIb7lltA4V9BmSCK74ZNMj0U8yAwGmyUSChTOVtwAC/vqznv5BhwurZ?=
 =?iso-8859-1?Q?e90F0x8icPFML40yGVSYxYGcTQCbjw9PINapCdhLGatNyCca0x13ECFNou?=
 =?iso-8859-1?Q?OL/7/qcsUAHHB5kseekBpeTMIDz7yRiLETQJYxT3jkHXgj3YA6ONGT8wJ7?=
 =?iso-8859-1?Q?yF5ZEhKT6BKymXRghSaHFwxeBbcUH6pfzaizxwfxWmYYIXULptbyk2lz0b?=
 =?iso-8859-1?Q?79Dwhy0ER52s/D1gIAXnUnalvh1pKZFb8GOpPf+90YjnrqvxfvTLDJeCLy?=
 =?iso-8859-1?Q?o5lvZkwCOD3RRqppf8pxH+qapvUsThWskfRWVVKbZF431ob2uEAFnGluvE?=
 =?iso-8859-1?Q?7n1elQl3ceB/+opBZRHTFWyXP0Zuv52n+lRi2iFtnhByDXS38HM4zfAmUD?=
 =?iso-8859-1?Q?sf87BzcGIUv7osxu8qSO8Ux2wmuwn/WIWndZXDJfyRHR7daIr8hmumfezo?=
 =?iso-8859-1?Q?szCBXFS8ar0F/8Pdwede9DwJraw7ZfWyTUpyJ/cUgl+nGPkWOZ85knLQrC?=
 =?iso-8859-1?Q?aXE9zeZ1Un01L9W9kdLNSWWf/0ohsXqIIDDkPtgHudY0ZFFpJ19bpwBw/d?=
 =?iso-8859-1?Q?84OMfHF/hDAV6NMCMBXmb7lRytubO/1CPOkvpk/ostECFej50bsxFFQ/1f?=
 =?iso-8859-1?Q?cepKgkZmnPlP4JrmqD3cZ/KxfC8g8NeTsl+X0DJz3nVRTGLNFg9pvXx9yr?=
 =?iso-8859-1?Q?Gm0ZCuRTGyX4OaZ9BC2e4N2FbcTqjBS1usimaCCYr7Vx0iwgaUXtYSsNFI?=
 =?iso-8859-1?Q?0gclWnsgl+GDJMwSUjs+TjRFYQPc32uG/Pyc7aU09+SAcmhRetyEbDHst4?=
 =?iso-8859-1?Q?7lBGQvL0KdrNdOrscVD3Jh9z5hXiAiWvXqrF70iGyh769ntYdaXNsWr50Y?=
 =?iso-8859-1?Q?31d/MQSr5+98LhX63gDIFYTp6kkfQ8Gbn8CKbY7QMgJew/RKAHfghafEvg?=
 =?iso-8859-1?Q?0EVzUwjOLo1yVoxTzSb+midKpePvMPJMoHgFlhJiNALSc5JJjFaQDHORIj?=
 =?iso-8859-1?Q?HnTplGysFEN0Bu14XrChjOwfYRYhdP7nteQY2qrqHA2V/TBXV1D2vpTa9d?=
 =?iso-8859-1?Q?5He0IWeLsVIGI0HOvFpPubchiJrPsNTZSo1ww7dDKd4nEsyIxelZXJj/oq?=
 =?iso-8859-1?Q?xe68ooQi2yEQqxjSd2MJONhMzDjNFyrqvmdOdfN3qGSLOh4x7Oxh1AF5os?=
 =?iso-8859-1?Q?Fo2d86uqCawddac38Y2jSytDcM5hkpWQ2cus5Xu7OzKhO3PL9bq8l/AjLL?=
 =?iso-8859-1?Q?YwlR3WiuJS/ltHvu16SeEaCSt6JYyaMTebyeEyvE3hxe0/Rync8h4WXz7A?=
 =?iso-8859-1?Q?3B0H9jC4cz70rHBxYMrlN483YChVvZ+W+Zk0mFhwjbhZJI8YeOlmfoDofj?=
 =?iso-8859-1?Q?15sW+xFVpL4PyqtfTV6iekDjZkEy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9xhr+TxGslN0aOXUTaxw9rZbdMVx1IMW/GgAl68tR0gGEeUuFV8VHrcrFl?=
 =?iso-8859-1?Q?PW01uKs8wOFTuS9k7rh/AdjtycGxw6TGLdJZ0XZABCO8g0ar9A3zkG/Gtx?=
 =?iso-8859-1?Q?fkxNycvL81daU6ttbYsEtDzA08SkXtCClx/EzPEui6YVsI8DFKLij79XxY?=
 =?iso-8859-1?Q?VGxvRPGo2u0+f/3lGvidni583Y0uaERQDdXfrqsvvuOrB1u2Z+8bx/fqa7?=
 =?iso-8859-1?Q?GVRTjhAxxsA1UFZOmblSuNxKv3lSMloOTr4VU4kSumpHujTDs09g+l7jJI?=
 =?iso-8859-1?Q?5qjkC1tPmdmw8sQ3Ur1X2D3Nmb91kjMumCvnRD7Kx4xP77R71VlilaybOP?=
 =?iso-8859-1?Q?zO/BnUMCobK6sw0fEpxg8GozekcrrEJdRnxa3CG7IdlrshtxcAicYbEwxb?=
 =?iso-8859-1?Q?NMW/FS6uwCMoJfqNrBnTzH+AEKOEpoCzsrPWXl1zwH6Q8m09sT/ZqRrLwv?=
 =?iso-8859-1?Q?FoMlQC+jpFjZ5Kswdx3YU0Y5cTKo1Vt6sohS87pjiCNenL3FiFGi9rywXp?=
 =?iso-8859-1?Q?AjLgo5B0su5iW89M4px41Zzk3ibuQmC74AvDt78+hEs2X71hhVKcANkdm/?=
 =?iso-8859-1?Q?uqIwqV8Z0gX04foPa2P7ATv1+8l2nJpVxj3t11YVaT/mUKnQ2eZgRD6IMH?=
 =?iso-8859-1?Q?wksCZr6oSEdGRv4js+FvHIudRHSeD+G+XJHNa5PYLc1reel6IRtu6ar/ap?=
 =?iso-8859-1?Q?9ylS0OMdqr4TAq478s9tVRrm5/Cegz1efaKch9pVV+1w2GI7HGpxfFeOrH?=
 =?iso-8859-1?Q?4QCwc3EoDpCGFPUZ6X//5l+O18U7WiGstRW2DCo3RCbLlbZZBRoVmPrDme?=
 =?iso-8859-1?Q?IQLdUZ/HIAuYq9pM/ZXp1z0sNTuDvn9EAVObJq6Lh5XUNMlQBnve6BSqr5?=
 =?iso-8859-1?Q?8M7Qhl9euroaGwCTMMoLBBE2yGkpSYg+Qlw4+tcuwbjCJeO0DCjGLt3glX?=
 =?iso-8859-1?Q?nh6L4Wj/AXf5CuF/sucbth1J6I2COoTzt2K6axk4E39I8fxxJCpa7jK9Ec?=
 =?iso-8859-1?Q?KW550qzL2UdXv8Fw+4gZgdtNkEq6f4DtiF5iYO6T42454M/Cl3bIYZ9veo?=
 =?iso-8859-1?Q?88bD8qJ6REp2beQglSeVNZfwdonmjos1fOE6FlR25jY3nsgGxctBem+ccF?=
 =?iso-8859-1?Q?OcnhW0mkBHkzGNB/9THTbA8NhokUzI9H/SPfnCwnc2x3cKcA7DU+vHZwPu?=
 =?iso-8859-1?Q?dYfXqVrAlps8D9CM8Wl2a8eoEFHad260uzRIQC9fg04I2tzC0jpdi3HHPp?=
 =?iso-8859-1?Q?bNVekMsnYeTd60bgecO+7P5KgRkTZtnp5ZfS98AN2c9UsU3iHvgw90vOlA?=
 =?iso-8859-1?Q?XjI0fAthxboMWWsN6WUV0ivqzHuo0f3n1Tj4lL99GJBLHN+9oqIzBuYnNq?=
 =?iso-8859-1?Q?/9846Hn4UbtH66FBLBO6nvbMJZwsGwjvEvAWoXLgkRunY3Bfk3m+rBZf3K?=
 =?iso-8859-1?Q?8N2NyWbk7D6zxg+l+ok7l8pfE6Dkizbjmbq13TWLqfCZ9PKiL0zsx5j4r9?=
 =?iso-8859-1?Q?sXMISpK0ugW2pzAL3Z6XRxLY4dv0KShjeZix8e48wViOV4ZAEI46XXl7K8?=
 =?iso-8859-1?Q?BPavotBhDjYpBWnT4rebo7/2h3gwTrTBtSNfGlKdGUhWqvq8W3j36yDIgJ?=
 =?iso-8859-1?Q?pc8qkzID0bssIWVWr5NVWJW3keQ9cmh+BIQCNBbzwTKwJ+jy+S1qehRk6K?=
 =?iso-8859-1?Q?k+MPwudWJva808ae4q8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80bb68b-0d87-435d-8ea6-08de0269f2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:19.9256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1iFA4YGZMaqcDypVP7ZbydAZZF36oOqGt0brEaHL2jmD3aGclxF6vHItT3/KsgrzND2rHCGh0ltzi5dCTLRrlEPL1vZXFyM2DSo+V+57+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..e3e019e605 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -486,7 +491,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -550,6 +560,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..77cec8ece9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -903,9 +903,12 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1088,6 +1091,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr =
size,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

