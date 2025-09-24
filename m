Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972F4CAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeT-0003hx-1Q; Wed, 24 Sep 2025 05:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le9-0003ex-Nw; Wed, 24 Sep 2025 05:18:48 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le3-0002zm-7P; Wed, 24 Sep 2025 05:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRlNkIwrlwXV/mVXhurWxo4Tump8qR4AxFYBk0NMqN3MH3GyNhwDxcbFD2ctX9TJZJMjuwm3G8QVfs5vqL6Q6lDh1Lq7lA6JjB0S9LWjW6tEqWrEd4hNAuW216sMNJsaOsSXl70AD0c9Hm4YbgzDLCRBv/QSIzYltRApXFxvm2DLZDXhBjrsWcGZ8YlfRYkjCbYRiHIqbkvbOLSZJfblk2CG4FGAarw9FznASwC/+FWwxZmq0n8pqqTdYgdHDtdb3LPpvMW+4kjqthETzfeVj2un2rHJVpn1a9Tm+du4uHBm2ht569mAT1aNM4Z+j/YXaywZqiNO6KWfHymccckpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVzNj46qYwZ5by72V5UfGZY80cXVX2JDNGf6lS+EGEo=;
 b=GkxB4bFTY9bxw+BgoHrquNXklEEc+55+91djRe7P/1ZofzMbsHH3L+f+PVL9Q4sh47YWIVvmbpdLckY7LX8NaEWQM1tR0LADNPmtNRGjdVDK9taPa9G6bhbmYjoj5yS47oSl58gnkhgYkZONFUfVx7C2Wi9WGJF6YmcUr7HMSZfDHBDBY+rKXlu9YVFOUfPIMz4xK8LkudOUBlXaifobFHbBiv7u0sugxLsCX/RfLrxMGsXs5+7aGqYF6NZA/vDzVphzoEfAKUcbJyhU+pLPb6HDGU5VHusBGgB6MXK/dTv7ZCObwbIneQfW86mCxMNvjXYGFFxq3vL7AOaWmX0xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVzNj46qYwZ5by72V5UfGZY80cXVX2JDNGf6lS+EGEo=;
 b=Lae2Mj9DtxHOELlnsbu9xbVFdQ/yQ4dD4WFT1EdWvmjR9I92pgD3GtAV1P7raO1g3+kGtEYtDVrP032EjlsVmdfq1nnjrzRZMb/8vcJrYgY7IjiUlD21kkE5mEZBWatcRq2QtQccPw1AhXQlKeWQHlrmACzFoaA/xXD5daEziSmPgvBmgbqL1uQQUNVxp/6C6tRZII6m1sGwp7Lo75s0TNbMUWJ+Pk0f1LQAuH4i1AXVXwY0QF447Xtq5Q7nLQyTqm9BQcWLNNl5f4F1DqXIucFsJGZ6vBcQpRS9bJseCn+wUhMKKkrHt6W7+pimZwhddMpk+qbFRCYYf7CMm6Pe8Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:17 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v8 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcLTQnKnlSMJtKfkKm/ebXEzTaAQ==
Date: Wed, 24 Sep 2025 09:18:14 +0000
Message-ID: <20250924091746.1882125-5-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: 263866ae-c2d9-4bfd-2140-08ddfb4b4bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cpyRbYfz6LjkBbf2djY6JTZ/qbneDiagdax1a4YKF6+TqpVr0tVaQYgd83?=
 =?iso-8859-1?Q?4+msjIZbgHQJFIEHNsy5u43M2JoG03ldC73SF40dgyp79L1cBRzyKz85v5?=
 =?iso-8859-1?Q?nX3CwdUBP01EGZAkqh2UP2oBpI1gA1EERJVFXatDF4DtEwjEYXe/kSdd2N?=
 =?iso-8859-1?Q?wD1W2bCk9LxQU37F7ccsiCJYKZSBMas+4cmssY45PZAMGHsQLf63/JfKrO?=
 =?iso-8859-1?Q?OEBMy7Ho0TNvNkKUnYhCDoVv/JrvrgohrKOKzFFywANKkuVoavPoA5QgqM?=
 =?iso-8859-1?Q?6F82dpd+BUSoyQYS4XgFaUMrzrIlBzLZtd4Hik/6jPaHoz8m3GgsPz8D2J?=
 =?iso-8859-1?Q?sqdNerjcvI6GJybEehPFd2ZEzMKd50hZ2QeHX6zw/pmTedTpOcD8jTYv1U?=
 =?iso-8859-1?Q?L4QJ2Hp+nWQCoeQyhP86FduXFDsp2J1augg4fJ+d7HnfLduCHV6MW/qFiz?=
 =?iso-8859-1?Q?wtxF2Cz+p8JufyzCGrMPt8v4eHJsltpg1Xod5CCb9faQPvCaHH4eqTNNeB?=
 =?iso-8859-1?Q?lT82b7oigxqk9GFpJ4voNyTTfBgkINCX1QcYRjytZ9mr0hcgjOsH/zAU4T?=
 =?iso-8859-1?Q?4N+j2mh1rEMCSJZZJIQ3G/qyjlYqlDeHDJlVvFN2DtXv8f5q9oRVKUPP6T?=
 =?iso-8859-1?Q?0cCownhveMqvC/7fRVKYKi7swZG0Lenij5MqwP5lrNAU8/dYEKx2IMRXiJ?=
 =?iso-8859-1?Q?WxWJwJT+xjZFAoDfCL1K7kcl7G9T3a4d0MdyCy64QdM9YGUQeULNiR3WxS?=
 =?iso-8859-1?Q?JjNixsN4uDBk1m1q6tfAIrWJkjrZh7C8uaDEg17KYqYSpM+Wdy3aGNrTn+?=
 =?iso-8859-1?Q?FqOCAN8Mpu354gs1Z+LCx36KdvgXd2bbppUAf3YOLW2+YZaq5JM4caOnMt?=
 =?iso-8859-1?Q?wVFH8UsiunJWrsEVYRmhC77in+47dnU2pDsG8Rw/YRrLLZLEbRfbAY256N?=
 =?iso-8859-1?Q?/1YDsQs7B9XV+YGk97gPSe5ycocJdLQkB3Ro+aqCoBjla8Iz+1NUEa9MrH?=
 =?iso-8859-1?Q?dwa918M8IEtYudkgX6zajNle3OprD42pu/nVV/tBTLxTx4qEnpmMsriCDt?=
 =?iso-8859-1?Q?57Amaaf6miGbvDBXHu/mcDkfIRzj6DzkXa6fv7/bowpg1EEwZav0ARnJxA?=
 =?iso-8859-1?Q?lUWhKtnfIMeYeCE/lQQT+cU3GD2b4f/mmH/If/rToYY/P/pZ/pS0jrXTOJ?=
 =?iso-8859-1?Q?WFr1iHIPYgeBys0G+GbpX7lPobPPytqxr7/O9Ce0pmmyhhidKz1wg/2aAD?=
 =?iso-8859-1?Q?13pjhW6XOPw+30d90hMtyCio1TKmjdlLpmovOK/ROyriNhRmKNyAf9xoUk?=
 =?iso-8859-1?Q?8vM1V6+5odp9YiRJLWMNl9TFN+1Fph+NVJtax1nuu+bdHGMNj+vuoQXsWz?=
 =?iso-8859-1?Q?h5HofWev8KZzm+iCHVnPojros9u2qXpanNoTMIMXCBN/cOHJ8/E7z8Huow?=
 =?iso-8859-1?Q?QLlc223F3N7qlDaQA2uY5T8n3dmA/gaHOn9+0NjTJ8FkAHWNsvzxhWCHCK?=
 =?iso-8859-1?Q?zSVRwH16w2MRm1QMyojkf50LOgBEsDWivOFNUNwnKPBQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mr/p2KXEf7kyY4lKURD50VFaF+mSNCenZdec7DOKJEQwgsmR0HOlcxrRwA?=
 =?iso-8859-1?Q?d0US69bHk//ec/fnoLbE58nFmuHLhqEs7fgOR/wHoH+GiusKTyb/G4VQo6?=
 =?iso-8859-1?Q?HQDiZpsoykBJsFQKzWQmL9/jIcziBQuv9XtAYoxpke5IZTPrxF5/O+vw/5?=
 =?iso-8859-1?Q?rxoIS23uL9u/czVWl2+Wj3Td9UsbDkAlNTe5kvdw9XGpIUGuIORMhQ40lD?=
 =?iso-8859-1?Q?phN0VK6Ox5u8ZdIjtFbciu1MGVVGXwYWaq06RQ9kGTkr63ziOrXrLNolVi?=
 =?iso-8859-1?Q?nfGvtv0g/SUY4hMUqiJ0U/6CeVHXHts1t3dDvGDbNE1hThVCIpqAU1xKqU?=
 =?iso-8859-1?Q?1A7UWmMxmN1DkuKZGnTUWCDYD0mfrcEifwysBPa+oekYy4EkB+YXY3QqyN?=
 =?iso-8859-1?Q?BYZO/bVm73sUbUgZOwW6xDf6NtZ7HeSD2cGBKhTtUzquTMNF86fW9ZWCs2?=
 =?iso-8859-1?Q?Eqijd4nbNL5WSoqDMd3DsgihjKJlUByLRrYMhusq6ZBbQPEANUPZ8FX6/B?=
 =?iso-8859-1?Q?EVsi3sfaQxt+ppXc+K7ebtj32J1/GvelpGMsobttb0ezkZZm+ppfmkY7uW?=
 =?iso-8859-1?Q?CHqvrHx907FrqNON1lzRbchG/YcTDo/axjOmKZkgIj2yyeNBU55fg9rYSL?=
 =?iso-8859-1?Q?0Gq0qdrN90L/amtS2iHGphnyzAzb/u7tfyvqyTKvUevkJV4TxzQot09nu3?=
 =?iso-8859-1?Q?HCjxgZ1zsblxqco0Ni/CUTCr+9pDZVRVhw5n/ikgpne0RgYKApGScg9LtE?=
 =?iso-8859-1?Q?/93BhNcJ2ic+XSZ3kSjy/I899MQidDc+2roDqmuDSTGzaObMPIc34Gzn5s?=
 =?iso-8859-1?Q?x9M5CLnABHIX8rOADA9MdoyXqvNxSl/DKG8wJZB+wSXhKnW011/hsjAjks?=
 =?iso-8859-1?Q?5QJHUcJZzykgsRXzKtly4YH1ueCqMohwnTPKOxYZhabeYMlfG6M+UF121e?=
 =?iso-8859-1?Q?2TkV2fy9shnMIjoXR6nMbh6Ty64ykWc5BLUpzNdeJbXmywo1TnMiw+fbQp?=
 =?iso-8859-1?Q?CP4e1nkq3bacDzTiwNGXhEHwQ4Cnn+9aTSYCc+rvHVqEq/Lbyws1tT2oYR?=
 =?iso-8859-1?Q?V2neAZ67bk/WIHVfU3N5g0lBHGDaD64FSikS3vyCaem762aEuk0+V/tDh0?=
 =?iso-8859-1?Q?FtD0wxoAZ634VzZZDSILg/iiUbMKEFRFrGhuF0k6kCK7K2by2qnM1KOKQy?=
 =?iso-8859-1?Q?v52rOtMcdDKWpX1hJ3UYB+4wb7P73znacMiBSU49FjsGDr7BF3cKqS9Ogi?=
 =?iso-8859-1?Q?hZ8xeSqFCgFH7ZursuQgiHa0SBa5MwdDGqtym15uALeU6yUlCmPtFPbwPu?=
 =?iso-8859-1?Q?9HoH4JpP+yAvaNJkAQRRFP+wfwS9aZsrzwpVIUho0w2Zh2SyfW186bGtHm?=
 =?iso-8859-1?Q?0VUB1DDFwpaHLogv9ZVhs1DdDYOvgy4qU/DencdaGQyGyGwBBIuIcHQvJ2?=
 =?iso-8859-1?Q?xBPp5e+Y/im8x+5UA2P75XnVbF7upVxb+HRQ9/UU1+g5M0iKzuNBYOfsSN?=
 =?iso-8859-1?Q?FrYXicRfiHzK2t8uGtWD/76JfDfBhkJ5pTAk88KlNOc5+75oqw45guYMKk?=
 =?iso-8859-1?Q?4iy+1IDo4gNF+AoxX866XxDKQ+5RuEX2KblqzP9zMuavUgXZwU/fNBgONk?=
 =?iso-8859-1?Q?yjtNUrwRihbsyRD8fbw4IH40AXeThV3CDUv8Fin6xJNo/JEV3H1YZ5pzrK?=
 =?iso-8859-1?Q?8p84EN3Fbe96yVDnd0c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263866ae-c2d9-4bfd-2140-08ddfb4b4bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:14.5913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBCLj3VrcCb0/TVy0KROhEqTYThzqNug+RxW/LqJSgvsXohP/nYm9A3tTRSJlrX6VbY/B3gcugb6GEvuvzIeArMrDIgZ8D81Et3Ijui2aZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6e0bd6b798..1a1ea7fe9a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3295,6 +3295,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index 0000000000..4b2f4eeabd
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

