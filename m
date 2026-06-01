Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640ACD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjf-0003Hv-BR; Sun, 31 May 2026 22:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjc-0003FT-LL; Sun, 31 May 2026 22:50:36 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjb-0002lH-2G; Sun, 31 May 2026 22:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOrwro/2e0kuen0MJIq6Fu/d6+js9wpCnittnh15I2Zn8qPgUuqsJmVt2rcTDq9BPDTP3b8Su4v6+ozKZSvE+e4Fyc7NT9Vlt6UBzBQupfpujXRmNL6aalG/CxaJzDol0HTU16WcvJi1AGzvm3DT6BeW711tSDG+JXg0VmVSEfGJAc0qvJaQF3CmY5DHlBWlVQQHixh3XT5LVS3kHxillvP7DvoDh21Dh+sg+GKgONp+p7tJm6i7070yS+uqyMNpTKTycotnA3BhcJE5zdzkRgx4sBOfYFN+eLD+kaYkqJWJNeLC3fTdCfBCm6DDifaEG9dligQOi/62w4zowcTdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTD1hI4WA+PKEt9dhc/JyNrCpa/BHneNFUdMhYMCark=;
 b=v/2uW51uKLJ5G+l+RWkSAfOJutHgFPvQJMoGsUp/i3ydYSgXRsHZWGuBLbUCFN2VF7YON8HzcMp8o77QDOjumn3h59OZpswj6MRiegFWr3Zr8QuU8k2kctCeNfa2h2aru/u+rP9h5WQEsLTi4LCgh0wSYkXhJysEQfW+THMfF7XA70fKPc/A7pBbz6Aqq5p0sKp0nTKuF10DL09SM1VcwmRGFZ1/zkT57u3ZTLXS64OriAOV4O/ZnjX7ZhJe/mluAN3PQJjJtU3lMCw6WDGliYk2sw2XEPeve1O0zYqvnlOk1SE18+dlNKKynvbWfIX5rSP1slGUQrvo4U1EJXzwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTD1hI4WA+PKEt9dhc/JyNrCpa/BHneNFUdMhYMCark=;
 b=iwZIE7tWpCmccO351KlbYf4zmX90EUEYLE/FOXvki0cqCX74vpPhnrK/gkSBFLFRzzLfzu0Yj7Gas3x5/qKsZWWGD+04s027qfhi1VD/V8avkZMBacByiafq7FMlsRM8pX+Yecbhrb+9F+CpZhKMWqttbuRicvwk4WtMRy1N8q1Q+3YR7eQgAj6dT/VjlZ7h97V9ZDUNVyq5kKfV8RIL88pDjHN+ydONs50Di8pfWg7kuvc2EU6lPhbfUiX0Mli4Z+VLexY/ahcuCp8KAkni5TWXyruRCU3bUWyILADnRMOxOzgX0ipRkgWn3HfrjeoYLmWNX0vxkLz8GeP0cXF+EA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 18/24] hw/nvram/aspeed_otp: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 18/24] hw/nvram/aspeed_otp: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFnA6LlJofAyEiy7vhquQL8Mw==
Date: Mon, 1 Jun 2026 02:50:28 +0000
Message-ID: <20260601024959.2347639-19-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: 479deb42-65d0-432a-9350-08debf8889c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: L9FtD735SEacV+2PJuOtzlntnkZ6A9jBvzxb1n/pCipz5FjIryKstdkJDZ/tZ+K997iO9FhWJr9gOsHFjv2yJdzW2VHhWjK3guVDQTA3uKqNxclqcNHYOJXHkrtf9AT1lOj2WddMWpnm7oqEPc27iBk1BuZ2C6AA+XZxiINjsKOl4vKgfI9RyZ+yldV7/Uc5FFBkU2PhsRQ4vUyhkkGTEh+K0UWzVOQvo34Cd2TqMRXlD2AZfcVyZoLbKI6gtpUkMwgY5PuipYbMg715y0QaioYuIh6QVMEWydpjAWVYWoMzg+JjIy98ursqpDvSK+Nxj6aqKx2IzTbE8RDfenImsbM8N8ART8oeZzZcZKKTN9NDhL8WSTi5d5+sNKvC9zDLys1kPsmH9mfzCsOtL8EvR8JT/O/YXVm2Lhx4P5pWRsutOFph5ybBOyV4XEVJMpjp70iTbkbx/tjWfXP1xyNFsOxXgxnzU4VLa+wKQUXwku/BPCIW+zQkKXa5q0pvj04KPyobpiRGZ2BoE5K9zxbOmNK1rRrAYZHR43WqtlUIRr+9S5KH/SInr4xmvfKeqMvEFyUZk/Nky5yTtekDvIqhkZusoNvIULPEpC0cRszxNbWCAa4h8k4dDrnUWL5S3xDSxGEgJf/hk2Yd8v98t+JiTpzWy3yxceWhcr8lZVkXwwcTR4npjoSkt7h6ZkCYPFuUCT2+dhgp5aYABSWz/JBd4rkA7FcsHJb7ogGyM2difIpOcJWI/xsvw2V4wiHPMrVCfVrKfuPUVuJfcf2+2aa7Bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hKCm2zdB0ryGgfh53K7jJx4XqM8gAPTcGdDx9emjFRVdPvZ29fJTNFQsxE?=
 =?iso-8859-1?Q?ZsZIgj3fJnvS60VSH2SgZjiyjm7s2zZgqMS7z6WQSSprWE9g3hocjZWYf5?=
 =?iso-8859-1?Q?N1cUTyny6ENDt+mnoSOkPYrl5Vbg5edk3hhycG3bLq35ASxsMnGaTqYvZO?=
 =?iso-8859-1?Q?FRy2kVedNQ23+yPl6YUXNe7Mh7OYkY9p2KoZG1mdaB8WFNb1BgXlTKKpnn?=
 =?iso-8859-1?Q?2b68UtlhPJRs/3ubWg5EFbMrmy3PSBlPS3Dz+B/7Okilm1ErerrGSo6T8X?=
 =?iso-8859-1?Q?dOLZ4cNB5kXhVaPRw+cWpWwACtBDImWOBCQ4KJiiPE6gdqajPRSLWuOYIB?=
 =?iso-8859-1?Q?trNi1iQFn66IDPQgAqNjYZIa0qwmxFK4q/gejz+QNTeprHjrSBXF1Ey0Xk?=
 =?iso-8859-1?Q?XKXiADBil2GEMz0QjOXVEDB3pjiZ203hFYXIsI0FsXw5c3cnicM7OQhQY9?=
 =?iso-8859-1?Q?leEVuX6tkP02SaghzVhLYYekrDy/38F+t3X2aYRbAR0DAr0kF1o1Mais+e?=
 =?iso-8859-1?Q?Ya8MVcdiqVoTFkXucGwYZ6PZSvIzYaaII+kOxjLWMWeg+J2/svccLRJrUZ?=
 =?iso-8859-1?Q?j3XSZWLk+8Bzy3Rx8zMOffHT8Z0FHQmLq7PBcv35FEInqW+y6mENcC2uXE?=
 =?iso-8859-1?Q?7wZY11nUam/bpyACxcLgS2LHbIlU5NTWNvD3bJaFvwsGuv+NBXEXzFhHG7?=
 =?iso-8859-1?Q?96PuNlhKSpjpr/Si/+lkM1TLpjjuiX4tfC/WROs8aYJjBQPGtw2Lj5+GJ9?=
 =?iso-8859-1?Q?vy8LtEjrS0O1U4ij1jh/tcc9xdOiNYjTBF1PUxlzSghEsLeoopIvbQHcwm?=
 =?iso-8859-1?Q?oW8SkKMSDfDq84Yw4d4ohz0gq5QmQoTKOtVUpCivLzNUlHFEmEWAo/vm4S?=
 =?iso-8859-1?Q?dd8uZbZSsUNna0h3GzaW0RXyw1zMVyRYszHLHvTAQV19murigjbYSWLad/?=
 =?iso-8859-1?Q?c+4ixX19fTXg8dshnT3q1lU5gmuVn2Sdnrl740Oq0PmVO89ypKM86WzM9G?=
 =?iso-8859-1?Q?vN/MWHpGGOnk1yhtT+5yoixjRC9jj9wqv+y8iK8f6u04F3cuogOhBAMKmB?=
 =?iso-8859-1?Q?1TijmV2jZ6SW4VUzQ2tjedHhix8kPunCJQWy1ZBJmPyrLLvezyFm2yX2YZ?=
 =?iso-8859-1?Q?KDPuBbahSX4NCSkPM5juR6w5cIWg+gEaCBFPYbhFHLMyBeAjttXxzIn7SO?=
 =?iso-8859-1?Q?UpyzfWf60dOIvtWxQKpexmQmvwhOx+EX8t6d6pdcOz3+PDEOdNJ8ZOinfF?=
 =?iso-8859-1?Q?pQiXgzqiX8YcsJLITQ/8oO+uLMWn/3Da7iL9ZzjKhp1Lge93zppUqmBSOH?=
 =?iso-8859-1?Q?fjVOaiEQjuihutXPgRhqDW5t+qczT9SY0a7fxyx0bRCOrUY/cw/VaH0EwS?=
 =?iso-8859-1?Q?GgsKRPBbOGfuBk3DA6qLBnihXZkLObLXEsaZXPOwPOo969S5B8gr3QvRoB?=
 =?iso-8859-1?Q?LB353U2D7PFtU6Ncqu3g3MccKQQAmheOPId6/EtlIAol7eGkUTzHL4YPXq?=
 =?iso-8859-1?Q?cTnbEm1FAwEnMAw4NDRYv6WI7cz5RsD1ZkwxfMnr2fXLGRZM2NiPIMcO0j?=
 =?iso-8859-1?Q?npyiM9/RyzQ902OtFixjF1IycteAghoKQAZ0l+Bs1kzR5LTJsPrkg5xGQq?=
 =?iso-8859-1?Q?hNbczmP00scPK4pLasG3berxCDhErgXU0/WzCiVXO9994+AmlDnXX4XjO4?=
 =?iso-8859-1?Q?AC2RoDAPbvW8oNqmvRzbuuQYPKNu3iRdKtK+OvioFJ+ukRZdN+omCesrJ9?=
 =?iso-8859-1?Q?cSuH0n+vBezK+JS0h+E6ywQjAmpc/cnzd13S4O9XHvEyoPVCx82PMmBHZB?=
 =?iso-8859-1?Q?VADWIBWUfA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: acQdB/38CQ89QXk1jrrddlxZlM5JjjmHGsClzOnRONT22jdTEEaLBP5TdRjdvmr28gJhMzONuolYZWJSiT4m8sv4GuEQMshPjVhTYWO7W5UiNLpWgy9WPBMzkzoGgwSMePCeN7WIyC6fvvS6ulZGMlGRzXHgURFYft/r3YyahayKbf3lSIkZXBbUMIJuZpHHOehR44euInwh6vT4IkigqmV+qOxPls0/PldM1edEv3d0ru3ZUcsECTcwDoQNjKF2Ia6RBNyjWiZjpMYvc4IqrBLe+rjsK0E4QEnYxt2Or4qVqcnuHAXfE3dI8RKjnrcPDgf9/CWRaGEozzpcp/Jm8A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479deb42-65d0-432a-9350-08debf8889c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:28.0888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByrFWv4Tyje0jR+GjMSqzFltCb23rwcYMZwcKqrJSCQE8aP3ywriNuAAlV3ZYWow1S/z75k1qXw3a4mXr7oRYuFehAwp9npp+YxbgT5G24s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline the standalone 'aspeed_otp_info' TypeInfo variable directly=0A=
into the 'aspeed_otp_types[]' array, removing the need for a separate=0A=
declaration.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/nvram/aspeed_otp.c | 19 ++++++++-----------=0A=
 1 file changed, 8 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c=0A=
index 1a9d3841b8..81304bda3a 100644=0A=
--- a/hw/nvram/aspeed_otp.c=0A=
+++ b/hw/nvram/aspeed_otp.c=0A=
@@ -174,16 +174,13 @@ static void aspeed_otp_class_init(ObjectClass *klass,=
 const void *data)=0A=
     device_class_set_props(dc, aspeed_otp_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_otp_info =3D {=0A=
-    .name          =3D TYPE_ASPEED_OTP,=0A=
-    .parent        =3D TYPE_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedOTPState),=0A=
-    .class_init    =3D aspeed_otp_class_init,=0A=
+static const TypeInfo aspeed_otp_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_OTP,=0A=
+        .parent        =3D TYPE_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedOTPState),=0A=
+        .class_init    =3D aspeed_otp_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_otp_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_otp_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_otp_register_types)=0A=
+DEFINE_TYPES(aspeed_otp_types)=0A=
-- =0A=
2.43.0=0A=

