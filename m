Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32322CD6E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjp-0003NI-0y; Sun, 31 May 2026 22:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjn-0003MV-01; Sun, 31 May 2026 22:50:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjl-0002lH-2m; Sun, 31 May 2026 22:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTLN9RlhIAFjrZtnKm0jM2K33UICU3SF5U92Xt3QmzP74EMnA1zV7HsIuVIxMraysV961yWXizM+4KeGNuwLiVrxphh68u9dRE/yXxjEwZSy9gW7PWjNtEjHDSd3kvkDSY+77L1Kx3Z7jIrP+1K+lJhDjAwxcOjOINy+NV4l9g4llULslUSVrb6Ufnx3wCKR9RAozSJVgfltNLDIBoPYCd4AMfPLXbEFoxH35VC5lv/ZrgCkX4ePV6lERCLz5xWucBwTCtJsdst6SYD42DG+mZDZwpEuT1qweVUJ4+/w7/x+bOA6klPVbYQtF2GTudLs7x6CfGfOaKNV4r6SMbmE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlvAza/tk7R8hwC9t7BL2HAMsdnpnLXtntiDm170MJw=;
 b=uXYtLVPF9IrVjbuaM1Y0TJFVlw29mTNrFV8ysGKCpNKeE1GuL8n71H0ietFpXcBBQYWizj+SNiTRrKp17yNFd6l3UlMeKgG8cuv9z5hemyogVFL9L9PEB9XI0KZwSkgH15G+HqlgOzv1IGBQ+aimsndlaxtwZ2u1EayL7SFnuY/2i8a3om0FaPeM5QbTQsXGlL3vKruMFN89o6mj7YpJn3NXTMh29IR55d4lv7F4XZqB0kd7g+tVRWhFfhAy6Lfw+vupOiTh6QY1XchQbqaX0fTNEp8IGoAonhI79QyuIMEaJbgUCVJboCYEjCSCsSp+N1XM1637g3dJf1/srqqMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlvAza/tk7R8hwC9t7BL2HAMsdnpnLXtntiDm170MJw=;
 b=ZltPd6KPh5/SosfUfFdpxAa3RsL2UoyZ6JigW25X4ThT3UrSxWXTgwJ4Ny1iyYnkIS5Q++TEuBPOdZqxOzDKZluNBPvBjdNWCf8ovqoVVpCggX3GoRfO0fW35hGZuN38g+REHQsDHTgRXiSeui3si5DdRZJMs7Nq2CU9Wy1ncnfSvOoianejackQwmXuBwhaTQ48pVQFIiEtsaR6Uj9tkarOnpe4WNTxPS170ubLzQJ0R8p+VhYH7bJRxpC2BsrzuJn1+ar39sEQXdFYt8QntAXGfcnD6CRS0I6lRN0zU15WyWvEGb+SCvM+Oq7rfC716fl8HcdiZP9YdJ2tSSgykw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 22/24] hw/i2c/aspeed_i2c: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 22/24] hw/i2c/aspeed_i2c: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFqwonuIVWYeEy3wftH9TPHaA==
Date: Mon, 1 Jun 2026 02:50:33 +0000
Message-ID: <20260601024959.2347639-23-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 26060526-9d95-4204-9108-08debf888d41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: U3HHV8CAmLTx1mQgnsQgCaOVggOjTTmZ7CM0FjEdEFZLEiCNi1sJkTVQJdRoYl9alTrWLAzbVZ6j//OVHAhii1XYaC/+anvREu8SGgGEi1JlkLxwhXE8gI0wVDRwyeOxxRAasw92J10O9nI6VoXo+BwtotQnAysPMHfpwCs2CrgTgO0cYaVGA8iRQ4MoY2MI76WEYOxBhI/nZKxgyC4LMI0xBPc+8XcB5mqX+pmrUKp1Hk7McBKRV9l77NucnVPqmAXu7xe2pbKW81vfrW6k5tcjStmQWQTw6X9wY0UgGebKcMoRTbnslwKxQuYu+nvwe/4OmvB5CiVM/4GttRlOgHCGkn5tt9ry6Thrr0XsCInTxaHxAHk+nNN2KqSJ6uaAmusqt0WzR9ReIuiFXlMloko3pE0ISbzvlQ6uPU3ag9+nZ3/4FwVgLnnb0enrsfVYwokrNjjvNmW3WMbe7Woe1Sju8OuNZXXr+LQRyBzL2KZtLGvSKLSRbOULmFn56axFAaEJTE0ETM7WFKNZqnclDKvp3n25ow6smBdR2kG+NzWoYIQ/v5/2SxSaUwHPxXEl3wdT1aIyJMbS7FNvHI0/PxtfTSYKiEsQ4gz8OE9W+BZ0J4XOxvF0RKgu+CDTnNgrFd0l/GfMG36iVJuXGRYpp5q8z4lSjwA6b8KYWjmdm9RrCmqkXJygQg8hzjUIH1Q2nNW7RTu9/KRUasWaSZYj02sDrbZjgXWiQVDZeKBu8HrorRQW64CMeTos4pgNKXd2q1dSiYkIb/bke/EBQut4NA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sodwDxAe/DfqU63eOJ73o2GZDPp7fPAEl8ZvGQqMI5EPp4VXlcf+SBIwzT?=
 =?iso-8859-1?Q?lKNUzwO6AFwjwhtXurwfMq7TW1Wlejnf6DHsMIZjsFM1D+B657cxQpUbEP?=
 =?iso-8859-1?Q?BP36DZ3V9hAD5UWPpZqGQcDXsE9HS+xzjzyzar7GsNcxLr7sOPk2RxtKzC?=
 =?iso-8859-1?Q?alf2UVvQ0HXpECzooRxMO6HMUoN8oGDKra6MenjjIxW86yNbPBE/z/lYoy?=
 =?iso-8859-1?Q?VEJWmxiShJMbV9sj9/FIVvYUXO9wpuMFaVjvUgyOpI6bSr9qiLooJ0phWD?=
 =?iso-8859-1?Q?S/tMR5vPkKnZE0iz4K3a75re1arJ+v2ro48/rbv5xu4X1J5k3Kfb9wtei9?=
 =?iso-8859-1?Q?ybhz9P3WCd/Tbw3JOMlqx9qdoV1zdw2oREHSzhbgBnYLo86elDykaRPN3B?=
 =?iso-8859-1?Q?g1LxXsbOVu8ji2ZHQ7KIvnpb8P6BHHOvVl9jvGM1CH7LOK1eOwNiD410m/?=
 =?iso-8859-1?Q?nE9uPU/Ab0P4mAJKnd9d11yrnpZuADIwFKIJPVWOX+u3/S/iYpJ+OlB7Mw?=
 =?iso-8859-1?Q?OxAoQXlcU0utqf+ZJfCnjZBAfiCFaYh3eAFuhn2NbwuTmk5yYM+XihZnR1?=
 =?iso-8859-1?Q?ZXyDEc1brKcMaG1ClcTjodH2PW9lniJLksn/9VPRNUhJyW0eAJX3aVUD35?=
 =?iso-8859-1?Q?fZliHdWonzeMz4QIYH7GObrmWBYacnJXMpoLdey0UKPqSRzGekG5zA6Bl2?=
 =?iso-8859-1?Q?OpKkc+rEIYeXvAhtrO7ABrvvBE72xQndVjSom9oosAoPbwmgIk5VJNqxyZ?=
 =?iso-8859-1?Q?NBjwpiVvnWibeYC98/VnzpNcs5FHxdFkh2EMlvmFCiK1m+grCBNAzkMgq/?=
 =?iso-8859-1?Q?Q1t7tQ7U64YQdWix2aQx8qMQ+umcRhZIFs0bH5FBf7DH/HN6xwziR+yCp3?=
 =?iso-8859-1?Q?2/LwRIZR5c+9UUyWBsSPmx4R0rjPOdzSei1P0T5Pb0kENA8sgaD9i3Tyc3?=
 =?iso-8859-1?Q?Xtp2o4ttgcJ7NbLe4hPDyFNOx2h8brxaibLI+znb4ZbKoWtgiO5Xb/3cP0?=
 =?iso-8859-1?Q?DFG9RE+lj6CZLxTW7Lf7ZtKpmL8RaNunVEiGTnz7UsN3uEYy1N5HGNlYRC?=
 =?iso-8859-1?Q?c59BTpnMaouQ727MnFWT1jjbs1s69z3OxHyzIwdrVRXUg8HP/7f9M/PGqk?=
 =?iso-8859-1?Q?c0TS+39wi+6NzlOEaTDL/IzGQ6H0gGNN1f5VRtavzU7VwA4sM2nRo88l5s?=
 =?iso-8859-1?Q?o6DyhabxkptgJN27nieZ5w4+Oh/SjwFJ9tm/R66Z4IwWNhI/nSQ1pMU0gG?=
 =?iso-8859-1?Q?GVDn8kYoAou9bqZmlVFKCTyIiTrBqA88TLrHNGPLMzKrDhC6kjgaFllSjh?=
 =?iso-8859-1?Q?iVmREwC8j1+5ZFfOaa0HbU+dTtCVi/AQ4d1CHzTrHDyVQbvLHTMhKBzqw5?=
 =?iso-8859-1?Q?GDyXTicCkYAse/2IwRFyFDYg3N/q20Ue8JeBmm8MjzxCKyE8u4j5Q8HcLX?=
 =?iso-8859-1?Q?GyWSo6+NCukUWlqtNTDxvJgmEyNFrV9FHgJJf9ymmoAKR41sImIEP8bqSp?=
 =?iso-8859-1?Q?dJzDfMhUawVyk9pq7Z2ekEl3DP4OEVWpXZp0rQH8leXJUTOYnevGTqEmHl?=
 =?iso-8859-1?Q?3pZTDm44Mt6GyOUDcbykXr1elIzy4TO3akKPVlE2XBD29okVjNTvOECJos?=
 =?iso-8859-1?Q?eT8AOmYDNsVm1zLFWP77I5IfljizB7GPx8DyK2JtfkHW5wLH6dPigh1X4M?=
 =?iso-8859-1?Q?8zYAOW6UsM5VvqHc8BedccWlDi6RgfN8jIJXv+K+pxDhK/i3f4ng8fAp3a?=
 =?iso-8859-1?Q?aeYPW9Ugt1aEPGIgs+O2bO7I8gVmbZ3s6TuIRjb2eZVyAUhhxNO+f11BLY?=
 =?iso-8859-1?Q?Jb/0o2JsoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AmMRPcPQmzyubXoTdqqhlCClzY81IPiytVkMxD2zg7w8aD4EoUCPYb22l/1V3wf8z1dHc0futKWCEA814eGlLVBIr8dSyJiLfi8shwRMFyjQrvkUxZ5quXn9PaB3HU2GTC95000H13rlPRaDUDbZU3zWSLarKLugWQuby2d+8zgmVSsyinmbpUuA8vPbwP06ivkBurg8l3nBFUyevZwYnOjXvjaaK5qO5sxIsONGbpw+RdBrdVB/dWZ+PPbxkpzKjVwxUFy3ZcZap/evBzOX0V+PAvdloEyPlYu+xWot57AU7XtHRH+Qzaku9ZJ/TScMxemeweI7z1PorwA4wUjfcw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26060526-9d95-4204-9108-08debf888d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:33.9034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eH+/aprQxauA2p4NtK29tIzjxomahgvAgjAzsgPKw+o+j3SuNXVRpiR1YHSmQcVtDV6jVLjNemissFmLPMr8r3fMtdbqwBL6Q4NbuXpdHGM=
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
Inline 9 standalone TypeInfo variables (aspeed_i2c_bus_info,=0A=
aspeed_i2c_bus_slave_info, aspeed_i2c_info as abstract base,=0A=
aspeed_2400_i2c_info, aspeed_2500_i2c_info, aspeed_2600_i2c_info,=0A=
aspeed_1030_i2c_info and aspeed_2700_i2c_info) directly into the=0A=
'aspeed_i2c_types[]' array, removing the need for=0A=
separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i2c/aspeed_i2c.c | 113 +++++++++++++++++++-------------------------=0A=
 1 file changed, 48 insertions(+), 65 deletions(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 80c4457500..4a6732a185 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1372,16 +1372,6 @@ static void aspeed_i2c_class_init(ObjectClass *klass=
, const void *data)=0A=
     dc->desc =3D "Aspeed I2C Controller";=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i2c_info =3D {=0A=
-    .name          =3D TYPE_ASPEED_I2C,=0A=
-    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D aspeed_i2c_instance_init,=0A=
-    .instance_size =3D sizeof(AspeedI2CState),=0A=
-    .class_init    =3D aspeed_i2c_class_init,=0A=
-    .class_size =3D sizeof(AspeedI2CClass),=0A=
-    .abstract   =3D true,=0A=
-};=0A=
-=0A=
 static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,=0A=
                                           enum i2c_event event)=0A=
 {=0A=
@@ -1500,13 +1490,6 @@ static void aspeed_i2c_bus_slave_class_init(ObjectCl=
ass *klass,=0A=
     sc->send_async =3D aspeed_i2c_bus_slave_send_async;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i2c_bus_slave_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_I2C_BUS_SLAVE,=0A=
-    .parent         =3D TYPE_I2C_SLAVE,=0A=
-    .instance_size  =3D sizeof(AspeedI2CBusSlave),=0A=
-    .class_init     =3D aspeed_i2c_bus_slave_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_i2c_bus_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
     AspeedI2CBus *s =3D ASPEED_I2C_BUS(obj);=0A=
@@ -1565,13 +1548,6 @@ static void aspeed_i2c_bus_class_init(ObjectClass *k=
lass, const void *data)=0A=
     device_class_set_props(dc, aspeed_i2c_bus_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i2c_bus_info =3D {=0A=
-    .name           =3D TYPE_ASPEED_I2C_BUS,=0A=
-    .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size  =3D sizeof(AspeedI2CBus),=0A=
-    .class_init     =3D aspeed_i2c_bus_class_init,=0A=
-};=0A=
-=0A=
 static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2CBus *bus)=0A=
 {=0A=
     return bus->controller->irq;=0A=
@@ -1605,12 +1581,6 @@ static void aspeed_2400_i2c_class_init(ObjectClass *=
klass, const void *data)=0A=
     aic->mem_size =3D 0x1000;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_i2c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2400_I2C,=0A=
-    .parent =3D TYPE_ASPEED_I2C,=0A=
-    .class_init =3D aspeed_2400_i2c_class_init,=0A=
-};=0A=
-=0A=
 static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)=0A=
 {=0A=
     return bus->controller->irq;=0A=
@@ -1640,12 +1610,6 @@ static void aspeed_2500_i2c_class_init(ObjectClass *=
klass, const void *data)=0A=
     aic->mem_size =3D 0x1000;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_i2c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2500_I2C,=0A=
-    .parent =3D TYPE_ASPEED_I2C,=0A=
-    .class_init =3D aspeed_2500_i2c_class_init,=0A=
-};=0A=
-=0A=
 static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)=0A=
 {=0A=
     return bus->irq;=0A=
@@ -1669,12 +1633,6 @@ static void aspeed_2600_i2c_class_init(ObjectClass *=
klass, const void *data)=0A=
     aic->mem_size =3D 0x1000;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_i2c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2600_I2C,=0A=
-    .parent =3D TYPE_ASPEED_I2C,=0A=
-    .class_init =3D aspeed_2600_i2c_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1693,12 +1651,6 @@ static void aspeed_1030_i2c_class_init(ObjectClass *=
klass, const void *data)=0A=
     aic->mem_size =3D 0x10000;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_1030_i2c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_1030_I2C,=0A=
-    .parent =3D TYPE_ASPEED_I2C,=0A=
-    .class_init =3D aspeed_1030_i2c_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1720,25 +1672,56 @@ static void aspeed_2700_i2c_class_init(ObjectClass =
*klass, const void *data)=0A=
     aic->has_dma64 =3D true;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_i2c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_I2C,=0A=
-    .parent =3D TYPE_ASPEED_I2C,=0A=
-    .class_init =3D aspeed_2700_i2c_class_init,=0A=
+static const TypeInfo aspeed_i2c_types[] =3D {=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_I2C_BUS,=0A=
+        .parent         =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size  =3D sizeof(AspeedI2CBus),=0A=
+        .class_init     =3D aspeed_i2c_bus_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D TYPE_ASPEED_I2C_BUS_SLAVE,=0A=
+        .parent         =3D TYPE_I2C_SLAVE,=0A=
+        .instance_size  =3D sizeof(AspeedI2CBusSlave),=0A=
+        .class_init     =3D aspeed_i2c_bus_slave_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_I2C,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D aspeed_i2c_instance_init,=0A=
+        .instance_size =3D sizeof(AspeedI2CState),=0A=
+        .class_init    =3D aspeed_i2c_class_init,=0A=
+        .class_size =3D sizeof(AspeedI2CClass),=0A=
+        .abstract   =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_1030_I2C,=0A=
+        .parent =3D TYPE_ASPEED_I2C,=0A=
+        .class_init =3D aspeed_1030_i2c_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2400_I2C,=0A=
+        .parent =3D TYPE_ASPEED_I2C,=0A=
+        .class_init =3D aspeed_2400_i2c_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2500_I2C,=0A=
+        .parent =3D TYPE_ASPEED_I2C,=0A=
+        .class_init =3D aspeed_2500_i2c_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2600_I2C,=0A=
+        .parent =3D TYPE_ASPEED_I2C,=0A=
+        .class_init =3D aspeed_2600_i2c_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_I2C,=0A=
+        .parent =3D TYPE_ASPEED_I2C,=0A=
+        .class_init =3D aspeed_2700_i2c_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_i2c_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_i2c_bus_info);=0A=
-    type_register_static(&aspeed_i2c_bus_slave_info);=0A=
-    type_register_static(&aspeed_i2c_info);=0A=
-    type_register_static(&aspeed_2400_i2c_info);=0A=
-    type_register_static(&aspeed_2500_i2c_info);=0A=
-    type_register_static(&aspeed_2600_i2c_info);=0A=
-    type_register_static(&aspeed_1030_i2c_info);=0A=
-    type_register_static(&aspeed_2700_i2c_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_i2c_register_types)=0A=
+DEFINE_TYPES(aspeed_i2c_types)=0A=
 =0A=
 =0A=
 I2CBus *aspeed_i2c_get_bus(AspeedI2CState *s, int busnr)=0A=
-- =0A=
2.43.0=0A=

