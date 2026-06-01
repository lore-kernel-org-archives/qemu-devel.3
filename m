Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C78CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjN-00035j-8T; Sun, 31 May 2026 22:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjL-00035I-Lq; Sun, 31 May 2026 22:50:19 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjK-0002Y8-3a; Sun, 31 May 2026 22:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voufeXNlhfv9GyXzKcjJ/0A/cjp6bGjiHZoRhArWXh/BbdAyzFlqAzFYF+rr1jsFhhU8aiRjLcNkzJtYg1Mn1hIIsqJ6916Yi+jmiTyhP/SFZ+ia3oa/7HKcdK6LtPydZkjMfPgBN1Y7P6gOfMZLOgnZ1afDBbzT5l2SfNkTbicdd8qvHAv7zGF1JjR7FbzLNf+P/30otEi8B+BGHQKUkfCZGyAPcGt5gW5nQ1ovnudZTZ+cgAoSmKNd8k0ofFnwpzLiUtBGKntaKCsF15ZnIg1UHAKBER1Vkutv4M2dRIjETrPKUPWALZKFvOscI5mZX+M3lYsWF3g7lh+2XNTs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0VCWQfu0GfwRlJHW71kK2JIX+/NzUiIlNPRGvd4ruA=;
 b=ysDlm197RBaICFC0/tD9W0scO53pIsQ8D0w5NvBTr4+aV47j470Xs+koFZXmGKqafgN/NYU2+pQOd011OtfM48Q8MXifdakL6SDBDLVKoiFC54BpKoAcyMp4WEn0O5TR0at2Q7RY9FsRDz+j1IvW3cPhMiSdREP8xgsieJBI5JXpyJ76yQ+D22M90S3XzJ2hd6HCHOcnX1SfIzPyd2ooG5GYJlSYexijqKHyaYbudU1U7UIFNK3XAhuFZpQZcGBXDnrnMfkltnQUBWqAQR8TGSrxNm9pbBSpE/JDJ54SVXFGEPVjXo6zjQMiVufOYLmI6ILW1EAOeS9zkGceEaPrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0VCWQfu0GfwRlJHW71kK2JIX+/NzUiIlNPRGvd4ruA=;
 b=j4YGVUDlLvQkDB0tvHgR/v/EcO0xzOgF+hle9xbjhWmpTaqQvr43Byj88E51mQUMUQ08QPL+TtBAxQ56a2bE9+VqUKKphLJJuvOg3SZz7X+UyjlQsuLk+YG3YX9aSoDm9XXgchSSfZ7pcqx84XpTq2O3mhL2SzWfv6bPyHJ563iKpdP6BoDUfh/2BEsV5cPHO/tJO0rncVbSB0bS3I/9FJo+F3Dn3/Pgg3EQ3KPm8Ccdka+WCVMTvp6VaPUna0b8PbgVRhj7w5SQFcCoHErAj62/+dQoDG5GY0Xf0uoNbVju1v5V93YrWO+rc1XUvgyZmMgwzIN4W86t5g0TF6d4wg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:04 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:04 +0000
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
Subject: [PATCH v1 02/24] hw/misc/aspeed_lpc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 02/24] hw/misc/aspeed_lpc: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFZqWFTyXDluEeog6iTZVPS0w==
Date: Mon, 1 Jun 2026 02:50:04 +0000
Message-ID: <20260601024959.2347639-3-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: ebea0a6d-9397-4835-b256-08debf887ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: hp+oJwEqQKiaZwuzTTeHcA0ntAJS0jtAuvA96+8crU25jLR8NkfBFuMIXDVGS0egyaUI/4PqFRWcBineVYdCb44zgyJJjoEbi8SqWMIB/VRhlrXrdNySoflh7IqAtiw2E+cgpp/3Ycz3AAdeRY1ZEUS/whVq0igoip9xOv50VVj2CRkrLBDL7XIpEaxESiu6EeD2XESIW66elslVoxUZbtmpP2gxVlrEdHY9rKKD7hNycAFuyWte852twU+zGqO6EVOXKkhcAOlRqBR9dNsSHczzymUdNxTXOovznbOcuz5cAko/IEtH1X6S5weQWASwT5jV+Z6RBWXoUeFzHOIPed06Wz2N5B5MgmLOwp/EiQEUup6rDGFsrjj4L77UK8IAmnUaLUPtwogDPy9AzVqel+vR15KeynYX2B3+sgkHO+ctEHaVkDguAG+7j2dD5q/6qOG8DQBsHf92coqSVPUa7tqr3VqY/BhAn7YsHEdSYgMrsFnRlJBaeYbqGDUVhLei1T+12ZPcfljk0NXEh9HUz8aDOQW/peoHpjNtpZu837Ue2GI/U4v8bR1KkR7aw6eWiCft0SnOPOcdnZikHCh9MxnmNYWdSa0BzZjdJ3D63+he5c0DrqcRUl7tNYy6WkRFBpKmxkNsgQfsUJzwF6BvF+/jUm66foGRRz5Qg0xMnAcVlECjacAymI3vOCdCmtJvRbicRaEeJpm/NxDKF6mH+csdv6xiBjItAVMdoODwCKLDKxOrLCnO5jZYA5r0T5FBAL/9P067mNU6rMh7pZGmtg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Kg7PUBqC9KbKHPMZHnRgtokPQ+zWPrvZynlO7//q3dKpEbLNJgb6Tkpavu?=
 =?iso-8859-1?Q?+rwthcl7a00A051Mrf9RLgSFkYgWl7XaM3yZSXiajXWUUeHCCxM8127v15?=
 =?iso-8859-1?Q?cIpY6HJBMPMFJ4HRDAWg1TQ1LIzfLHzqnB4SC/Do2QkBKjj5GPOqblKEtK?=
 =?iso-8859-1?Q?rg1nUjDicXst832cpN9bYpO2X6svDykCuFMgcvlsutJ7oJnRdMng+FBja+?=
 =?iso-8859-1?Q?+1xGWCo6z0vTJRD/xup0bzCSr9lPaV4EI3VRQ3WASXFBVlXfPwO8AzUKXK?=
 =?iso-8859-1?Q?J0TKY07DcyNNNslid8lj9JG/Sg2fOK9wt6Vd1e3X8FapE8WniQevZ5NlWm?=
 =?iso-8859-1?Q?BKCI5idph63eCUaiwiq/i6AN9GoSzSlFkAWYPmUyC5zSPvIjlG1pL0CsOT?=
 =?iso-8859-1?Q?VrFX9u5IsxCsY7em4NZXiOlfXysRXjd0TgJ+YvXRbRovnumt4+y6m4iDz8?=
 =?iso-8859-1?Q?i214QH4lDNHEeuSRc7/WH+d9iOZZQTaxtvOd8RRm98pK9MWC6RZxp4jFRf?=
 =?iso-8859-1?Q?I0RC1BZUvbBf4xrrihUKyLEoj0vsufgSWfrYdrW/47hmWhVf4NBsjhNQYE?=
 =?iso-8859-1?Q?xknYYQtLSaoWfxNCa8lgjW3sw5Ori6Vk8QaswlhNzicZsahcfm3f/nEeRu?=
 =?iso-8859-1?Q?+lhp7DSJ8ca1o6HwTgi2Eg1v+g/jP9jY7uG1TfHi8X4dvCNvzECqcHFGL1?=
 =?iso-8859-1?Q?iYCyto7v6i6mCewixIcJZKMx+sdxXVELTUq3JWG53oQaSjiolC+9kOO14n?=
 =?iso-8859-1?Q?MFlLPW0k7kaiVuWY6ELOxBGlODO0XbEBn5QQ/67z50AULo04LBDe/Xs1qm?=
 =?iso-8859-1?Q?K9XESkncLLse+nekd8ziXYd+2Fbdsu/3M8hzAqcrVLiRYCzU+rpSrWSwkT?=
 =?iso-8859-1?Q?NwB3jQeW4O4Ri2fiUzw9kzwjL5SUFhgVF9eB4CS30CcKK/QLi4qg+GnHlk?=
 =?iso-8859-1?Q?YQb9fHCQFCFMMqGsi+lP2EvcSiDKXUbbWk9fYzR4nr4te9ddiyoBCC1FId?=
 =?iso-8859-1?Q?U1QmI6k1IKHh4fGmubHzO60zxM58RD6OaRJk8C+QC8uWYo+sjEZ7Tq0l+F?=
 =?iso-8859-1?Q?SveM9yqTLTspGbJD7HBoRD+nUtl7j2t3LkvOe5ZDbYRFDGWUag7qKO2sQy?=
 =?iso-8859-1?Q?s7RadZRvrQNAeW/Ra5G9vI3X8L9/BbUnzH8yLgnXw3fyM059yJ/PvjLp5z?=
 =?iso-8859-1?Q?XvwEseYUCXmHo9+iWYJn21976wixwuMCFLXVt9z9plSFAhnUPIgubNHwLf?=
 =?iso-8859-1?Q?Dg4k5/bqEhB82e7BS0Vw9UQoIIcYKCr22gCzlnYabVoicgL7qUVouEWumT?=
 =?iso-8859-1?Q?rzbeWYYcXT+JkSXBptvEoMjnk4xxS+fb8xXDCrIBjXNvRr5rrnZfsFRZzu?=
 =?iso-8859-1?Q?ZydjRFvXPPB7pVnBJq8I4Tj1q0wjfJcbCAq5ra3JHbhKXvPupkIXaqPDLh?=
 =?iso-8859-1?Q?P5AeLpetMPMXJ0L7VQ/68Llk9KnUUQfUOrqtDkAgaxUSHSJI1XdM2uocWj?=
 =?iso-8859-1?Q?LWQp9Rc44h/1Yi77EANBGPQuYiZPluaKVRy2ecAMa22vZK+0KxrFdLEr0u?=
 =?iso-8859-1?Q?njJLr1T4dfZ/Rj32eTtnr4NFOI+MneMvvzz4BUr1w0Ysc5QmlAkADO5tOq?=
 =?iso-8859-1?Q?YMfeDd3iOWyQgp3m32k0axhxIqmRtimeW8YESybjSkGFwMoG8xVZwSBRRL?=
 =?iso-8859-1?Q?O2iRS6nXx2bB0aQCigjsLLjNnVvxpv8jwJgRSulHJus8sXXJSeSAeNINRS?=
 =?iso-8859-1?Q?S/4vAWemXIDGJhmZdENGCAUmP5gNaaZPeW9BnfRUPNJbhf36N1vwJ5BXax?=
 =?iso-8859-1?Q?N//YQvk9Kw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: av/oafIgRQrMfGsT53Ww0zrD1KFq1tIjbFcuhablamt3MV31pfyqmrCoSXNU/xlx6gs7ifb0Ga+KEWOSOKJaC21bhWqzafGIYa2qJH8z1pZdS5HKdAT4ytPLmJZ3rARWzrnv30X8Y2iUq64YC+7dONnH+YQkc0+Pjiv+mOJaegTIdEqJtP3EI7vIZOmA5kp3X43ans+NUOo5vlDxlczxmVkSRe/M9ncIFjHjI4rOJGtHjcBKMrFJupXcRhDtGdineY49mBAQg8KOa6LHMGqfhNjS1o7gDQmKqmuFbrafssK9jmVUPgU94jnGHB0cD4W/hbPVyO6cUKZ/v6EdFa1s7Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebea0a6d-9397-4835-b256-08debf887ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:04.3190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+AXNAUFJMlnxKcLs6dL9hYVijPOiapwduzWBPa18lSDO6ePjgYD4lgvD5mHgoId6fgSFKUI9v8D23wpq7cOgnaDKQPlNhPMJXcg/++SeDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Inline the standalone 'aspeed_lpc_info' TypeInfo variable directly=0A=
into the 'aspeed_lpc_types[]' array, removing the need for a separate=0A=
declaration.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_lpc.c | 21 +++++++++------------=0A=
 1 file changed, 9 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c=0A=
index f69c48da12..7f7e4f1a09 100644=0A=
--- a/hw/misc/aspeed_lpc.c=0A=
+++ b/hw/misc/aspeed_lpc.c=0A=
@@ -470,17 +470,14 @@ static void aspeed_lpc_class_init(ObjectClass *klass,=
 const void *data)=0A=
     device_class_set_props(dc, aspeed_lpc_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_lpc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_LPC,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedLPCState),=0A=
-    .class_init =3D aspeed_lpc_class_init,=0A=
-    .instance_init =3D aspeed_lpc_init,=0A=
+static const TypeInfo aspeed_lpc_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_LPC,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedLPCState),=0A=
+        .class_init =3D aspeed_lpc_class_init,=0A=
+        .instance_init =3D aspeed_lpc_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_lpc_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_lpc_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_lpc_register_types);=0A=
+DEFINE_TYPES(aspeed_lpc_types)=0A=
-- =0A=
2.43.0=0A=

