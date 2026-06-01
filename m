Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15260CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjS-00038a-6J; Sun, 31 May 2026 22:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjP-00036r-NJ; Sun, 31 May 2026 22:50:23 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjM-0002en-OJ; Sun, 31 May 2026 22:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkHdEgg8S4aNgC14BumYdX3vwgHJjI4eh0ZfS5jfXjaY1ktqWSoGDldS1+O/6vVLsW9ypDNZiuVIR4Vky245vMpOmxCXyUnWxAERiTvTuSC3UfbAQ38Nac8Be0PAIQyoj7qD0igu2U9zslUb0OTFFI+h2tgglGvItdS4F+a4qVuTCktpRLC9KIMygwQjJm8We4Br0UJEzdxbkFm8EvyLMlavt6eqNwtXl/IOxgl9ce8Tc8YXh9YTbbMOgr67Gk7KjcLCTWRAyDNWHhR4AYxqQw21OFlPvinrURU+kjORpjn0pVk+24M4fD0N6TK9BaWLY9uQ5AmMEtwPslCXKkL7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9yN3RaDtoudX/CPc8ioIrLqnPnCzmnS23lG84k91v8=;
 b=c5KYwbUjeAIlZEhZCJ2eyPJqIGx9VNMgi8p3chpXuiHxKk55qp+Xh0WPBIoqgFAl0600a3wnHjjYRRqRo8evi754f37oFh58Ht2cG6Vyvz8uMsn1ZXvyO5udjgdFwVtffrku3rR0VYo5TJbewGxqNLoVHQBDZDECphVdCL4M1fZGPwClbWSUsKnPnV8aurAQF3bEPifs8lzjf16GJxpnZNl1uGwWpxZ03abKpfhRPIJ2eqKpuDxH6EhxN8/t2Ipg9gAA5g9xMUjovO7Uad9YSu6DOkKByXULuL4Ys4nKQQCF79zJ0xbS4NPJBvEk4bgoySgxfsOpqW5gHqdl6EbPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9yN3RaDtoudX/CPc8ioIrLqnPnCzmnS23lG84k91v8=;
 b=fUsDRVIBCs8WXMdQ6uUFx8+llBUpmXbug6fQNLyge/5/Xgjm2TmxeuopTVZ/VjpogZpbHGnWX+omOs1vaQZNT/Ig3RpzEL/PloJLAkAFl5oRi79eTYcxxhaeb9ftRfA080OqhCaScr0hP8VwmnzOku8ArINBlQhO6R3coHNu6rInhdP9DtZCFRfjDgMsIBjKBcIjOmk/c56FHWnWW7ZN8SFN7Yiwi7fkBQ05CRkYMaPolgEGCv6KMd2S70ogh0oKuDojXwn/bRR2KnDyCXzhRcBvDphT8pXSJr1KhMEqBOGCg/KCbzitJ9FVJiDEASVqkXFSWZ1uvZlicoT+PgopVQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:07 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 04/24] hw/misc/aspeed_pwm: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 04/24] hw/misc/aspeed_pwm: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFa/gzyX3hZUUqYpl2c8F5GlQ==
Date: Mon, 1 Jun 2026 02:50:07 +0000
Message-ID: <20260601024959.2347639-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 1e708d32-a9fd-4b49-5d39-08debf887d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: 0FW4076i9vgG8JDru1sm59Hhett9RTUTYLlWsLkzlQYX4Fa4pZHkGwJ3K4shPXEada8w0OuSgnbwjrP6RniZ39bLNJUfzGHwEwoxDcVLR96E/XT5RMcxjM/7uj95YaUTLfbu8B9YKZDj5bktYPMQDJy4rt6MhX5nUJPvorJPEumA64QizKrO0Xl2aDi7YJLWWtuLzEQW3Thq4BcsCEqihRP7gK/64/lEXZSpFBsq56vLkd+Ad6Xd/fBQJbGfp6C41wcMwlHbwWl49OEciGJvU6ojpdS9PJZXQXxwhUu7epKoBsE1wMWebezN1BvpqpfKA847pQN4Kj0xLRSOAT67GSU/hgTVSglrwHmksfxyeu11RoLVwgSyQdNjG5IpTQZA3u67l7hty7dRSZeJY/9iChkCCOw0ipK98YiVOPuLgBp8+lvNiAx85qJvHg9yoWvo6PTJ1wt7e62kw4D+dYQVU0YSMecoCNFJA5Bo9d2F6OutQwZuvvBf2gYqvRyaqMRTKEa6G62LP4Lw9+6xKz3eAY8amfNph5MgMifBK78fcC4ImH3xm55nYJMgIG+dIP7JEORbIRTLLcqO9yQBvtTnOgn4bxymj4EO7tLiNW9RU1rz4KbHUfYLKjeEXv9ckmZuSKO5JgoNBKXKCE1ltbLTIgjoCxN4X+OwHPMu1MYdiSyNa76EpmCNhnWV+dSsaOYSiVqPX3AAfOnQgYRqtBaOvsJiK7i+ifweSz1Wwn8OtCEhfzlNTrrf9/UjGh69bBvmEGtwAiX4P53XWuv3yaUZ7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5qzZpbLP052Y+N5VjsAba7j7UX6TeiXlkQqSfhTNR/vuTP73+GkHLWYs4v?=
 =?iso-8859-1?Q?n5SvpMtHp01aL90TeAgQV64AS+12PgYSJdJaUb6W+HN96acy3gENFPAeiD?=
 =?iso-8859-1?Q?XhRqeNPiMIztrk69PD9H7PazTukp5vPn2E3+h/RG9wEx6u2Kqpd0Mo/Icq?=
 =?iso-8859-1?Q?9OkKGUZjRP1P8uXRKF8XDh9zIS/+M+mCgAPs7XQl3an/afUt7duMQZYxRo?=
 =?iso-8859-1?Q?1J4Ly6yzfp0jHscp2epOCTD8t7Rw/+cu/GozQFtjxA/7Id6obuFfs0ZDwp?=
 =?iso-8859-1?Q?+Jl35sfrl5BJh6rXpBj9heokI3Ahx73gD6nsYClvXOJpZRi6Kmj0fd0bVq?=
 =?iso-8859-1?Q?T7Z6X1RaqTQCXofRMnZV4z2HxhH8HSbU54Xkxd1Oe9wmqCtfJrgCgmkUu9?=
 =?iso-8859-1?Q?6cZrudZS9w0yzwLMqUmvzvSfwZOM2VrcA+I38BVP8rzFuotL4OZ4A050af?=
 =?iso-8859-1?Q?ztlhwTg1oLf3XABzLkfqFm1ATL1wLhysmx+N1KNI2/6yZLquonh2fci2PC?=
 =?iso-8859-1?Q?qSKGpsqyYIzzDwRVLVDnwrSI6VeT/WZWz09eGcX+Gk/Dm/kZC1V6jaDww7?=
 =?iso-8859-1?Q?7v9I6JQC59UBec94B5GUw/rqEChBdao4Aucv2owmQJCAmHkIxVZW3Ym0X4?=
 =?iso-8859-1?Q?eqQERGQ/tj6KOh/KX8IV3K7xz6MC8sQFvl5bnE+Ixz41HuhEYbS9L3DfJh?=
 =?iso-8859-1?Q?85xxCzS8f4CSN6tZX2V9jDrFzXe/mBqGN0uQlwLhJnUlYFx7xPXxWln6M3?=
 =?iso-8859-1?Q?ewGjeLnLOGrH3wR/O6/QNf8+uE9n+hkaPZaEALlBvg8P+N0uYjcZiLf319?=
 =?iso-8859-1?Q?ljEph+dZe8/87j7chvmGhA4Y69lcUs8XxY457zGuMPBzjYwSneyJ1sKwS3?=
 =?iso-8859-1?Q?Y+z4BwS+SoH2eN7KCmMoeZpcqNjKNipPsq7Bf85NtmRxsp4k3GJppL7kEU?=
 =?iso-8859-1?Q?YGtl5d0rlYt66AST1Bj4+I/ONeqzl+wBf2pg7VLEOHpn6J6ozOoEjx3Sii?=
 =?iso-8859-1?Q?YSXJFSBlUV+IfZpTptUdGKpLcPP+4QjtWC3ZemlpKU9HRkZUticdrNr8ga?=
 =?iso-8859-1?Q?s0B9OsW11b9DUWpp565DBYgHf44W+8mDSv6dHRrScDPQhS9ULqgp4pyt+W?=
 =?iso-8859-1?Q?RhClu/J3gT1k5AYBwEuiN/jzL8j9XzHcFA0Ctb9woyKHW6YTUdQYYk+6x/?=
 =?iso-8859-1?Q?D51DqGbTKGzHy+Z5tfJoAuuFho72YSoksaVANdZV53vLCsys+SfHlTVZ9H?=
 =?iso-8859-1?Q?obiCgHNUfPhOUpWBEUcp8HS4lONbe+hb6jkrRl7SrP0Jkm4vejry4duY+2?=
 =?iso-8859-1?Q?jExkLGXU37+PYM1j/CkNCd4/vEwHozI361X4kD60V9jOacD+Y+BdrwnOhf?=
 =?iso-8859-1?Q?PHxH2ViYcwD9C+mptaocd4oWZx/9lhGikzBVXtEMFkSgQfv1Yz5MML346c?=
 =?iso-8859-1?Q?TEKGn1QQyG/IRaly2ixD0rYukX+C7cx1cZMVVw7nmpSbSOgB27D6ddOAed?=
 =?iso-8859-1?Q?BN0/zLPV+GDTZMwY8TLPKz1HEL15gSOt3yZZqvOsCvnveNgto5UqZ+mwF+?=
 =?iso-8859-1?Q?z8hTRKYmN7Y3jjSTiSGVm62QM3jnUs4dtfuW3ODWYRQeZ0p1Syg2K1xWrg?=
 =?iso-8859-1?Q?JPQRd9w4SCooZfDR5tUyaT2ldlark46m4xia0wBjQVZJqJc8Q5Cg6aNe5D?=
 =?iso-8859-1?Q?+aiDASf0EX4/KgiJi0/qqoiPcamnWXpYBmKOtZMsV25o0cpU3eqWRV3c2m?=
 =?iso-8859-1?Q?AHUMGLtRZDLXFrcnsdai/EfAUcCRnIBNbj5SsstUuJz92hmuO6YR/cbETR?=
 =?iso-8859-1?Q?eBsgwHT0rA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cPvGo+9/hVpZLoycAsLMDKTPZFwVJXKS7Wyyg/Nk9N1Dku4gnV1Bp8VLYg/BDUEms2DnIDSETvS3/eKxSG5aqKTTpNnUdFxk5V6jmVkL/yLLsbUaBancmqMgYEkrWBDFgMmfQlSEB8oulcDremn1dsNjbYVlIj/NwzjQUtiB6DYCaz9rwmghyx2JZ1mFs6XdEfcPIvsKCye4kHHiQeRK7B3D3HC6mba2ht8tDrnk0tz6HwnW/ZGzsVR3QUTVYkqr60E82iYj1jd17QYFv+J9HBJvjv1/SqNr2bH/fKJpHWs3T1o5hF+TMC6e69xLtfYcxvXM7UevttKcALYk8oRohQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e708d32-a9fd-4b49-5d39-08debf887d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:07.3589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOOvTRn2He7cZipzLn95iAU9SLU1rjvIW5VF37IZCuDcfgM0L8bWOHWQlpbXrRzBm2sYm/68hZV9FAo45RN6ba0jPiob9yNDS0lI1vlcceQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline the standalone 'aspeed_pwm_info' TypeInfo variable directly=0A=
into the 'aspeed_pwm_types[]' array, removing the need for a separate=0A=
declaration.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_pwm.c | 19 ++++++++-----------=0A=
 1 file changed, 8 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c=0A=
index 673a0f1346..dfb93ae7fb 100644=0A=
--- a/hw/misc/aspeed_pwm.c=0A=
+++ b/hw/misc/aspeed_pwm.c=0A=
@@ -106,16 +106,13 @@ static void aspeed_pwm_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_pwm;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_pwm_info =3D {=0A=
-    .name =3D TYPE_ASPEED_PWM,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedPWMState),=0A=
-    .class_init =3D aspeed_pwm_class_init,=0A=
+static const TypeInfo aspeed_pwm_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_PWM,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedPWMState),=0A=
+        .class_init =3D aspeed_pwm_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_pwm_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_pwm_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_pwm_register_types);=0A=
+DEFINE_TYPES(aspeed_pwm_types)=0A=
-- =0A=
2.43.0=0A=

