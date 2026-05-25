Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6A6CD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8R-0001e2-SX; Mon, 25 May 2026 00:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8P-0001d1-Nt; Mon, 25 May 2026 00:41:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8O-0001Fm-6c; Mon, 25 May 2026 00:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRRBJGMB8L9ZoYhql6VHPolZBFfbJ0fyBt8q8yNnZ03y36K8TkPfv1wzyqteBCgDCgLBWW3lYPV7PsqBiX6aniiiYQ+QT/CBStVufuc4DS6lct1hCxbl+ODJSi4S3goqwguznlKWMllenfm76NGO/16pseIQeeSDazyS7oVaqyl8ZTSQMvk1Yks2Qr+lrq/f/hB2QXYUozQD7roI1jH/aPCL5qfy1Wg2tFJRMaKDrfTl7WUANqqPqkpidW6rZTP6E5TDmw23Zpvba+agatF8S13vDM4yT0JXknpgS++RA9kIhsE0O/HqrCrK/dIa+Fta1ZQHYorb7GpYTtoWtmmVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nt8etLA1Gmey1l6cPuIH5eIeeXKIjhC8LDzowf5NfA=;
 b=S6yACJ2eaorJ3kgm5vm19KldcZNnB7a1dm51K6PrPZhDSRuvyehcMysDPv+OnTCD+Q9qaPN9sLfU31vfi04xOkdxPsBOCSlkPe4NURo0O5azCQQD59t3GKuLHxcsN9obgCT8O7Oq8cxWKLw3JhMViBmTUJ9xfGE4FmTpjqJ1UpQ9w17VNOF3lfH3mFm1+VtX7Wo26Gh68BMTjNQKMEqzzFf1ke2NJn99W4og2OADxcyF6yD/ptcw2iXt+zVHFRJmBAm2DojMzx5WVAbD/8cugjKilFQOchoar/BUnJUH07SYcsf9JxVWxFDA3VVKoG1YEF+nKcB27L0hWDUKfWmqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nt8etLA1Gmey1l6cPuIH5eIeeXKIjhC8LDzowf5NfA=;
 b=MzGFg3Wjfri78PHf0i9SK9ef0htPu+p2ix/l8fPgWlnR0y8jNZolaZHmW7oePWSA/cas7sbhqTNI1vE3+M3ys/6VDpeJN0j3rlb4WUxC/ri5ojTuZWXzVAGw5C3Ep7q+Duuod/MfeXVuGHQ5M6XUNnklealCZYvs1dXeyjKKTD9pv6mP7RbFxDovkkpRXsMHA5ud3pKX38znvVHMJGeWXDE/U+jbibZkkOR5kV+L1pwdgS7p9Mu9bC2TsmjyLwWJ7dXvrrHeaaAgAUyseSIA6CtjkMlbGIs+k3M6GBXBJ9fWuFJHhfBCWuxQQJdLZO7sevPtoNsRbCBocVpoP0OD9w==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:35 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:35 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Joe Komlodi <komlodi@google.com>, Nabih Estefan
 <nabihestefan@google.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 03/23] hw/misc/aspeed_hace: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 03/23] hw/misc/aspeed_hace: convert to use Resettable
 interface
Thread-Index: AQHc7ADE/LmyOaJX3UCGmpkTBZvhlg==
Date: Mon, 25 May 2026 04:41:34 +0000
Message-ID: <20260525044129.3133916-4-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: aa7eef50-9ce2-4c78-1194-08deba17e6b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: 0f6TL7truLj0J4RiYFzyvK3qC4vI04bDuAy+XJ9io0nkElCo7cCvoCqqPM/TbA1HIXJNA44TkjYgYw/0ryK/8ezl35yGlgyVHCyAR7M9N7+eG7UxRKfPE7yWmq8HwDFjwMnsLCKmsFf7LGKsGZT2loJovH5iIh7fbmhpnjdRhTU3R01cLIpf8CFNnZLoryhuViFWmbHXEpLM69JyL40KfFohafhvSlOGZKvnkMOJvS2aPb1qLzLmyp2z1iyIz90vbAzS7WJC9B5poqU/uT/3aTGlKp8B6kSiXUwNtsZphwWjx9480ZkwZoabhQuLgj3zdaXttJpTf82BqTr4Lgia2duMsxYT8jfvIMS0sYwm8GWLhYHZp+L0XNPd0tQqEqwvF247yL1j14+waHNIeeG8c/rXAqdQs+ZxRY5VNvyPCH2tlYKpSNN8T33bKdB0oaSfv5yxLxv8Lvcq/mWG3W0kfEd/DoI443XVGc7UnakvS+VIstaADh8wDtmo9JZTIZ8MW8bsJuaBgnPHuT8uCtUtMvb/I9QE6K2e0LzaVZyxlpmDnHw0HLbmD6I1RJRZ2Poj0dUWsj6tsnb6Id6i3xun9y6A05icMZaAyHR7kiAuqBey8RpKhJCnVXh9etZvanloXBzyiamEt/+7ChTshtHgx/ftRVK4S3NdlD+RFRNT1rYPD5S8Yy/BZW1RSlkqyaMv40e1VIrRVFP9ZFsC0TySPsriITarw6a+oK2C+SqTBrruMIUeNcSiBiOUvG5MUv9Dte1o+bYK506/F1qbxvAR/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gl0CAiLWMPTYRojBS3z8gYxfA6mQDu2jGoSZqnlaO33AkFOQQjug5ZNbUS?=
 =?iso-8859-1?Q?LZb6rLyIxmUn/keWrtIPNUk7YyFHvHL2jUMOhTrdOjvvpbPY6DEbWYUwah?=
 =?iso-8859-1?Q?+319JxJsyFDKdH49Pp4hcdEsGqnymZ975X2z9mB+T0EHk/gx0PdFySCmTv?=
 =?iso-8859-1?Q?1NhtzvrdTwALP//HkBGfSszpe/80qo1D9bSH74F333Tq4P03O0l9nzknRN?=
 =?iso-8859-1?Q?xGcI0nTPDBixnJhCPno05cZwKk/w5Yuspy61k+LVYy3voPz9VdOw2IFQJ5?=
 =?iso-8859-1?Q?dqq9acb/169pAa7MoF9VxayrAWh2/KNPy6Vo45Ia0D0Lqn02zR9Z3JmM2/?=
 =?iso-8859-1?Q?iLxaxGNNoVYIWtSYNtrEnGfhQkvpf/nKRmZTufZZP6MtFW8BAOWJzyFncx?=
 =?iso-8859-1?Q?B0kegk+NYCxUHUsu1iBL4BdXb4yNvyV3WLJq491+0mp8stBBrpe7MlKV7q?=
 =?iso-8859-1?Q?wx41+nW+UuI/x901pfsNyZODK/YgyjyWmdsJ6ozQJ6zaZmyHSL+Pi6bgFz?=
 =?iso-8859-1?Q?KHYBGAf/bK+VQOg1IrowtqiceUEYUkTdyMe4ltf41zN2RWJ6ouqwi6vrFc?=
 =?iso-8859-1?Q?GGG4MYsTmH+GwYSbl4YnI6/T2crjIa5hw9moueWRIrNuxyMIs0iPeayOPT?=
 =?iso-8859-1?Q?pSB/DJwHAduhBT4+9x4G80EYWcTS5LqCdQ6Y+TJKHPbqX6JTlLnOZCxtkw?=
 =?iso-8859-1?Q?WrA8PUsF/SYra/U0K12jUp2fbLWX+lfRcdleJWSz3XpsRSn8NdKhCEFiOt?=
 =?iso-8859-1?Q?SRR8zZbP4ktiCD4hdSiv411+UqSmGykxmyXhcvBTguRlUh2pvSgJBvNvAH?=
 =?iso-8859-1?Q?bEunZJwlb0WoRU2dEoKmyVPKnzpjuDs/JskUkwu9sTY8O1Uc9qwk0j4xJ9?=
 =?iso-8859-1?Q?66FOaDsk20WqrqkBIjHa+4aUYZ1GxhzRWdppTN7/UOMoXr44kpb0q9B2xN?=
 =?iso-8859-1?Q?6C1nsy/jhTXfw1jHE/9DrbWzmmmhh1uyZfEAVMgAaLil2LPVwZxq6CEWya?=
 =?iso-8859-1?Q?y5/M4eQbS/2KmMpITSTHPu++cW2smRl6BJC6dYDJB8Cjxirp8L6ErOp6nZ?=
 =?iso-8859-1?Q?ys3zA4dZOzVJPQBBhsjACDuCV3iWlSoqcFOBQ83RtfXO8Wl9qYRC6sRGp1?=
 =?iso-8859-1?Q?5xx8PjYSNDNUBQGvvEcBhDqHCd/96Y8oYsqwMWKwbnWXvt5RyLWM5FwO/I?=
 =?iso-8859-1?Q?vyWbrKEGeGjsLNtH3FF9PEq9W4kZoF9L0awLXaOr21LJCjtX7VG4s913tJ?=
 =?iso-8859-1?Q?t5iHxf23avhjJaJboaRDCdpbCS74DcHO/4xvTe93t2sIQfEIcmyTRGrl2L?=
 =?iso-8859-1?Q?qE8EpW16ZejDLojufP64iyTN9SO5/SkIxr5XvdIYX8cgd5Pcz3m5OMGaoz?=
 =?iso-8859-1?Q?AtLFjQliT0UoZ+JhufhTS5SB77SSfdnOvCXPCCLKX2Ub1jmRil/sG/uJEb?=
 =?iso-8859-1?Q?+YhPsI9FXkxzURKjDXkk1RL/DXO0n23vmh1kKF14pc6lG6QEoCnPjEQZp3?=
 =?iso-8859-1?Q?3XAbNjNl//W995i9ZMG27GA1tPNxVVzJiFEQseMu5WLfQ1Huj4JbSaW9cU?=
 =?iso-8859-1?Q?4UXUjEGvWG/iW9bWSKmh1T9snAyvoUn0rJOmxAcF1RUZTTFGFqlEWA8hlB?=
 =?iso-8859-1?Q?apowy/LX5u+kjdQweuHPPdyvvvUzfRdS7bWnrR99tomh/dBRFggljIi6QF?=
 =?iso-8859-1?Q?aY0lNPY6LcqzwE7cx0okzSw1U28phG1sXlVIrEp9SdtVjD9dJbyJAGlBGf?=
 =?iso-8859-1?Q?T83M1KmaTAV1QvwfIZxRd1DK3KxlpAUkLuwbdOpDbhI/qBXJNxbRug//3T?=
 =?iso-8859-1?Q?NJzoOwzVRw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dclfdsSCVJIOcH9epjBQOPffh5A69gPnS+j0cMVCjaUpOOa79Zdf4drdLI4+7jKigEWC/iUkkq9QOE6IB/Hp8zoOA7WKWzeRFA9WrXt8aU8pG4JQpY0eXJw6ABPv2sXlfry92eP3GQJdhHFrjr2cdNiAFczFRFFTC8itikICUYMF9JwB2vCu59Y9rK9x/B70x0xPxJ2fQz30/9bPXt0JlzABZkSa7pM3qEd29Qi/WpnQpr6JNeSEdDtbG7pG38Y0e+BYPUEfEOVegQPXZuPBdpwuDCNK6E+tO+gjIli4duXGUuZFrwOTjoMBms4Xrdt2ZxwRtvIuPl+0K9fe9j307Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7eef50-9ce2-4c78-1194-08deba17e6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:35.0927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZTpAAwwa4hELFx/rjzWiA3gx4fzUbuNzlaVK7UHTw7GGjF6LOh1rFFtHMv9T9umcyVREHRv3MhLPH/faGaRCgn+i/T6jxeibLASY/Uw68E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index a322905cb3..4c9e913f6c 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -624,9 +624,9 @@ static const MemoryRegionOps aspeed_hace_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
-static void aspeed_hace_reset(DeviceState *dev)=0A=
+static void aspeed_hace_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    struct AspeedHACEState *s =3D ASPEED_HACE(dev);=0A=
+    AspeedHACEState *s =3D ASPEED_HACE(obj);=0A=
     AspeedHACEClass *ahc =3D ASPEED_HACE_GET_CLASS(s);=0A=
 =0A=
     if (s->hash_ctx !=3D NULL) {=0A=
@@ -687,10 +687,11 @@ static void aspeed_hace_unrealize(DeviceState *dev)=
=0A=
 static void aspeed_hace_class_init(ObjectClass *klass, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_hace_realize;=0A=
     dc->unrealize =3D aspeed_hace_unrealize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_hace_reset);=0A=
+    rc->phases.hold =3D aspeed_hace_reset_hold;=0A=
     device_class_set_props(dc, aspeed_hace_properties);=0A=
     dc->vmsd =3D &vmstate_aspeed_hace;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

