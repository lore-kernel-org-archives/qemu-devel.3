Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3535FCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjr-0003Nc-Rn; Sun, 31 May 2026 22:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjp-0003NN-9L; Sun, 31 May 2026 22:50:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjn-0002lH-QD; Sun, 31 May 2026 22:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDun0aQyzpqmCiRlxVpwqagVlBk5EEE7UszNuh9qD/8nJt5liJ64NbRafLO15Xvx+2copbFvqrdtcbKZK4f/Ks4J9XpzhVSVz0HAOvIJy7HHLVl6Cu8gJqfx5ZMTfWPbKjOfiQjkuARPnXZaDBokIhjAHMXw5lfJaEsOAX8V8X0H3xjk2IJ7PcT6vxzKecwV7y2z5Pg7mk6ZvlcsP7MnNQHCVSslLjv9c8+XXFyuQzRItGOwZRGyEe3n7QzX4lWit8NUfJmG3fqj+zXC7xWjnfZi51rqqqPNCYenzYyOypyRWAJVCOAI5qnvjqKyjgkBoTdc+FCDdjdwdPWdinN7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae+afk6TEAuUlCt2zCT23PQ8AIk9PxatdKWKRGsOyak=;
 b=DpD88bKV8If3xHT40AvLQ6DjzgLOjAodYI6LCxKmEXU5TTbxoAOeQGBXqRfbeD1QvwPDxRICeC48wMKwhPvb1jbJBNFb6B2GAdIyCi8czyxBH7u4vo7CEmm+SKydjfG9eltPryrqs0UfE/cVyXYVh/3nR7baGEkbaWbocyf7JEbxEnuhNTxBLT998G/iiGeRCEEAqHAzLgZ+G80+ulaOrblkfcXqSCHrhA5gGGvJLZMczNlhFLbFW3opd4AbrLvBnxOKFrWoZ4FJcWtPQT4vr0bag87hl0Ybi4t5lPwZfumZ8j3BuiWKEZSJq4DCMq7TefR1eJZijZoA7AU7cFXUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae+afk6TEAuUlCt2zCT23PQ8AIk9PxatdKWKRGsOyak=;
 b=Tjt1mDu3uwc8z/ZFiAGUpQOaVOa3bG8ri+3QMqeZR2KVquKRGeA3IkTDHpiQjtl5OAQ1aTtPVtUNl+aWHXaGPJ88BWRLAfUKMykBmMT5NjUn7iudx2gzzwwndtaOwpUx8ltS+FrsRRodHN999h8MiKegUic4ozLWyIXawisT7Oy1rAmYls9kVNSgu+BvS9iiu3+cKtYQCeHwSJeIACgmS0Jn9wjVuttcXdmzJazKb5ISuZd2L8AvO4GIirMaDxUTVwyDAIO/nKApNr0wc9uqOI3fpO8ZZZenY97ga76kEe5epfbKHbaLTx+u//KLk5AtdpqWeM+QWJcd6BpIwpvPog==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 23/24] hw/net/ftgmac100: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 23/24] hw/net/ftgmac100: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFrTeOvxi7HdUWvDoRmyoHifA==
Date: Mon, 1 Jun 2026 02:50:35 +0000
Message-ID: <20260601024959.2347639-24-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: aad6fcd4-e57c-4087-4eb6-08debf888e32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: KuMpicfcwShw84eG1i51+9VMgmeRo/gTHh9GFSIzP6URyjEFtklnC+1OrizV94y1+O1nMmGT8hOBdzCUX4OjVrOmifuqlEoM22/6Zw7FDJvxXh+gG7T6A1NUvklQv+RQr4XLwD734W2NxX8eUkv8NHxu0FOakzwmhPYIK/9Ok7yIUS0aTRTluDyQP6MGEQ0ByMWTaTpj4xQi7ptbexMdieBkhRf9XFvpoxjQG3ylKyE2kD5zE3pV1i20fBK9GjlK49xZ6pICLwGLrHrBZ4Ndb2gtGqYv6L3alEfsgC7BTxO8hwo6vpZL8EvnnKEkVEs604vJbwhHCeghBBgoXEqhKENEMD5EAHy9qRqpsQFFmFy1t9nk03/JBlPeiPPSnfdNJ8jlxem6D29AjYJhprrZ4IgDzutZDe5R4tSGuldCEl5iUtfrs+rBxguVLMn3VlcoCtSsGuIweQxy+FJHLt7ZBb2zaBTCEqzifDG0PA5Bb6gUM9SV7reOPxSc7XRgE62x6GBejAMAuijgtAnU2BWELh9fQR1tQI0tbMLANeHKl1auPcP7XF615+6jTQ+pZWlrC/EcnMpQZ6N8XyyBQfOgkI5HWb074Jqcx+rkftm6LJj3T9mBYUUKN82Kr4xSYSST4FF7skp+SjJ2PlgqMsJqbG3MQNJadwmadtSf5+zWbxPKaqK50QTI4mFu3nQaMotoU6z9VHvloqBuT3UYHzXaVr1skTpqP+d+j+d1tbO/evMhDphBI+4mSrdDIKIEhWIg08tuD1am/YkWa8h8bxq0aA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xbM51x1fW8PxlrIk8WW8p5KCpkx8/ZGdMYOeCgCEB0Lo107EQxpyT5UzZ2?=
 =?iso-8859-1?Q?dJJUCpwS9UhjOpLPHqCC2gtWP3hA54wqhw6o7LGNkvqt0BiN4yBsHYiS5Y?=
 =?iso-8859-1?Q?NRFwbe9Knc2QcJd/1WQbvjBbeFJKReiSKTaiQfhtboa6OYkxB4ZxJpxY0T?=
 =?iso-8859-1?Q?7W8moeoNIW5ZqTYF4gho+U/YdKuDWPv+NGRqovzz8axFbJRekLXxczANqS?=
 =?iso-8859-1?Q?UAN13dHSj4rIRC7Lan4sf3J0felhs9qEsbmwQ8PJIUHueDtWXX2BilbEas?=
 =?iso-8859-1?Q?2Qk9RmCl3xr/9T7iJiecxakKJlluHKfulhD+MISegPuQSj/DV65wohiotI?=
 =?iso-8859-1?Q?9XTvvU/gfZXpS9Sxuv/tNpT7Uzj1QdMUDW5PVk/4ux2SwoMklVOCfw7ghc?=
 =?iso-8859-1?Q?NnWXUiMsB2Kk9JCM4k5ydB7BI6TUMSrWqmBsmYPf6a8J60qJHqB9Ct4b9x?=
 =?iso-8859-1?Q?jpWmLIkrGDknKmYzoAyRFvJ9qklkQBDZLBx0s2zfm+pBTaR5inmOZ5dazm?=
 =?iso-8859-1?Q?LE3atuUEoyyxa+W3k+6jIJPgCjHX9WOjw/kZGES9C2AxkGJjvcN8zr2QOz?=
 =?iso-8859-1?Q?AMnISNh33IefLqIyXrtgHqTQGrjZgDOWB3nh+x9znmhlWuVyvJPWORjEI1?=
 =?iso-8859-1?Q?LQA1jGAKHrVVr4KcQXxV+kXE4xCPEHHCdFZj3iY7KsjLOfpwvfHAGNCDFi?=
 =?iso-8859-1?Q?3HC0HcUKxPcBvQ0W4y+i+81NPLY63rBxBsqRqokwtqitf0Ioan3MjF140J?=
 =?iso-8859-1?Q?83MQYWPv3PYmSoqCES5dS3iVAnK6Es3I1a9bi7SuUf4FffO/wwzDyW5zHa?=
 =?iso-8859-1?Q?boyqb/7gDQFXvrm72zNcEqZ8lP0qZxsDWhFRslJB250iD5D1rkZuFuIlUy?=
 =?iso-8859-1?Q?KJpDESmj4eduuCHg4yjKgLR8dBu/loFWzO6GPM7s4DQXTgFJhO8m343ZGf?=
 =?iso-8859-1?Q?1W8EHWaXkxgRVJKKmuwNSihuAWvubSQQtXS5t8GMskmmqlHYfw1qJ5mV7U?=
 =?iso-8859-1?Q?SiHdVxS+KqQkK9zcUfyRTMyAAA0324+sI1EewF/l7mpDtKEkvsDAzQuMR2?=
 =?iso-8859-1?Q?BonP8IIGKTbzpMGxIVQbF0CqOXen+r4wvej5fITER7pdpOFkWUM8nEB+lD?=
 =?iso-8859-1?Q?sSuXJ+S2Zud5iRL/fVMZ5JFh4IVB7+Fq0tkQnozBzNNQJaxO7X8f5/w+iL?=
 =?iso-8859-1?Q?WQgUG7ixogwPmCjTSZAS8AEp+NHXsaCxK3Yrvv5yNF+obSZ32NFKqnAmzg?=
 =?iso-8859-1?Q?G23A6Ns1VJ6rjM035VcgRU1Xqd/5gHgBNlijHlM5IpQ/dTvqtof21NNcuO?=
 =?iso-8859-1?Q?CeabKlTObVbwnNz7r8ch5orAozSQ/OS/3N2ssudFSBSJph5N0i3mwuIaCs?=
 =?iso-8859-1?Q?mZVi70nJnenDB6eVjxzT5VtKauiIC/4ceEvb8agpl6pXAJjmYIWKr9vb7P?=
 =?iso-8859-1?Q?Gm0FNnfyhwitcbESCEoQWCtsJABgBuS2Egg1xuol5fBb7buGh8OkMLnWE2?=
 =?iso-8859-1?Q?ZTIymcVOtJYr+wyUC+O84PKw+rTSN8MaB1M68pEwSxxdRXX6pC/vr46g2d?=
 =?iso-8859-1?Q?awWeEMPEYzBkfZONWpsNPggMeq9yu0AK6NiEnlt76p9R9IdnAP9zazRjVR?=
 =?iso-8859-1?Q?OP5DqSdQDQXroLUh6ZtGxo99Qz3bDu5Rb1RifirkyNSOnjkKbUCLQdGEJ2?=
 =?iso-8859-1?Q?hs46PWIPDfd3khhQZ8ZqmXQzzkz81UWc2waoXqIikK4SfiGX4lFUABfRSq?=
 =?iso-8859-1?Q?qrwY2AIL5ZIFNVxOtUfB1h98GEJ57U4ZYRPnAFmkcnMEN0RgP08W/AZOnh?=
 =?iso-8859-1?Q?Tvg0DRk+VA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: km1PlAiNpDs/GKCMstogAGDb0PtSGv3Z9q/3BIrtPSOe8dvm7Gj0OAE/bOWxc5aLZl1v8YoXtE/CZmBSW7YgdUGhPUDa0R0i7D1FJyQ7xtYHGEp6Ry2a+j808yXi6iwd+alDn/iyi9VSOasXRwsdZLxHKHVOx8KNSe+sD/AY8EbKmIp+2bWyfRBTEw3VS2/GsZVt6CIvKhrHD+Ug6aR/vwLYkQL+SN6YP6mvfDWucBQ5HJ8vVGmTE+gwkftUbq8VvicuSUTITweK33/3oZ2pyExu4MfVlLl3OaoS3fW0Iwx7zEaruUqUMtnIBRR+oUfsUgxjBOxgxigEQiJux1HRhg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad6fcd4-e57c-4087-4eb6-08debf888e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:35.4896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dyea4tfKxE0cL1NhPYSD1Rbgif4LxGNyS7Tk1963S2ZavfFY3uLgDDV4W8S40nQ2Xde7V/mM0uNibFdgndqwnsYaHnjbWVM8kXZRwox4zw=
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
Inline 2 standalone TypeInfo variables (ftgmac100_info,=0A=
aspeed_mii_info) directly into the 'ftgmac100_types[]' array,=0A=
removing the need for separate declarations. Note that this file=0A=
covers both the Faraday FTGMAC100 Gigabit Ethernet controller and=0A=
the Aspeed MII controller, which share the same type registration.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/net/ftgmac100.c | 32 ++++++++++++++------------------=0A=
 1 file changed, 14 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c=0A=
index 2bec817b9d..a53c840c37 100644=0A=
--- a/hw/net/ftgmac100.c=0A=
+++ b/hw/net/ftgmac100.c=0A=
@@ -1279,12 +1279,6 @@ static void ftgmac100_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->desc =3D "Faraday FTGMAC100 Gigabit Ethernet emulation";=0A=
 }=0A=
 =0A=
-static const TypeInfo ftgmac100_info =3D {=0A=
-    .name =3D TYPE_FTGMAC100,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(FTGMAC100State),=0A=
-    .class_init =3D ftgmac100_class_init,=0A=
-};=0A=
 =0A=
 /*=0A=
  * AST2600 MII controller=0A=
@@ -1438,17 +1432,19 @@ static void aspeed_mii_class_init(ObjectClass *klas=
s, const void *data)=0A=
     device_class_set_props(dc, aspeed_mii_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_mii_info =3D {=0A=
-    .name =3D TYPE_ASPEED_MII,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedMiiState),=0A=
-    .class_init =3D aspeed_mii_class_init,=0A=
+static const TypeInfo ftgmac100_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_FTGMAC100,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(FTGMAC100State),=0A=
+        .class_init    =3D ftgmac100_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_MII,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedMiiState),=0A=
+        .class_init    =3D aspeed_mii_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void ftgmac100_register_types(void)=0A=
-{=0A=
-    type_register_static(&ftgmac100_info);=0A=
-    type_register_static(&aspeed_mii_info);=0A=
-}=0A=
-=0A=
-type_init(ftgmac100_register_types)=0A=
+DEFINE_TYPES(ftgmac100_types)=0A=
-- =0A=
2.43.0=0A=

