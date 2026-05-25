Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669CDCD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8Z-0001ge-Vt; Mon, 25 May 2026 00:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8S-0001eG-5t; Mon, 25 May 2026 00:41:52 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8Q-0001Fm-Lk; Mon, 25 May 2026 00:41:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSfURX7FEf3EwEcfDznn2wuYS/eQWbvzekJ7CJw2pyd3WlBA1+N+oAOyTVjMBEjiEONaiditHJfpb1GjVOX9UztJHzb/IEnikdFDQmi2D6+hZhREY8gCYEx/mOWpqfOxVbdMORGECrE1KRPx33UEaS07WlGTSkXI+hUJXc+00QrcV6JyQj4MXqa0u39F3X6p6GiE8i+ok1hvmLWBpb0gcmYNvT2ChFCpyU2vjvTl5XuP8zbSXN9cRd6LloN58y6DJ+Qaryj/ie4m3y8eqcPhMqIb5beq8y/uXFfLKdTnti7fFTbOqn8Rh0NvrBm9QeGoTz2MS0yukt/tCAwV9jM+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGb2EysffLV34LmKXXszCPZa5GJg2f4qGPCrldOivIc=;
 b=m0v+0ocvcxtDmrPv7Wb7ukO24iSnOSO6EUmsUM9p252EGmN6jmyxTglaa7zFKCLiErweQLYodHFW2si6a3kSzvc8H6mVw1o6MTcwDHJd8qPsqqyXu68z+W//Y4qExGpWgDl+BTGcuQlP0Sxl+F8UQmUcsuuoIPtLPSLbmTES4AbmQU+NEro0xfnM7TmSOR4p5710SWtfXDPMftpn6BKFOKUiNUTbmYsnyrqPgSoDK8tIG7LysUn95t5v3Bs66JHK2KCa++ppU6q4iRuFXp/7ClX1VIsZ9NMIjqYgmpU1rFWTpyVoSqNgAmWzGHkwDRrU1O12/10ShTaYbLAY97a9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGb2EysffLV34LmKXXszCPZa5GJg2f4qGPCrldOivIc=;
 b=TrsMredCmWsrfmuyEbztBPGTcJcPtZl95OoFA7b+spDRj+Kx+innSQXtWH4AgwQWblBTvm9YZA+PeucfbAZrFSkHJW7vKVHTqP7Hn7hpCuTpB8rni2mPwRZhjUJGbEQygOiphy3xpBwpCG6EDZf29/p3lnkE1oU4M8auJdQPXmtBDNPGCOl/obujwE8oMCbXfRP82pistMkGoI8rNxyzftZ8J2YWaYKJ5D8aMeTazMEQYM57UWMcW3KQXaVSGSqXJs9SduWDp+J4gZ3mMaJryHU8OWvyG3iKVN4R4H0oKB4q+nHIc/J2aXnR4fPWl1+TnVjhOKUgI5frPQ7AKvmCCA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:36 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:36 +0000
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
Subject: [PATCH v1 04/23] hw/misc/aspeed_sbc: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 04/23] hw/misc/aspeed_sbc: convert to use Resettable
 interface
Thread-Index: AQHc7ADFYsCxAl1eI0iBzqGIEcyFOA==
Date: Mon, 25 May 2026 04:41:36 +0000
Message-ID: <20260525044129.3133916-5-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 1b0d374d-db53-4c04-2ca8-08deba17e78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: 9NdKq2iahsEJMTk8+toLu6t6gh96Y5L4mAdnONqNtXHUoPoXtaPzHcX93g5BxTqZ5S2PrInuPwUlZuvTwE/H+haQQ0YOna9d5ptpcI7serf4DCyi1WssVqPCU8A/mAJd910Yj/bod6u6RUAvFd8ZahjdRiatPWzHnuLfPqGBvjzsMmAM+VKrsGDighcTH12QRTsYHzBclVduMmuvbduU9NJK/QzCruHWjA8WfqJOLAgaU5QEob5frp7U9m5Dx3U8a1iiwjVlt7hB2hV6JDNK6Rw81VfWlszYFdWLpCF0QeObGI0QH/NJyMtURxwh/kuy4IPP2wc5BLmrMcnT/n6Cup1XXvCVe5xqNAk0GOEgtJ1elBW69qPnR9CvENkMShE6uOF9UiAVTfeLBC4duSEioYo7BVZayrITuH6ssQk+iYYPfgQMhXlk0Wi4yBvd1APFoSotMlqLUekH5LRwk3kQy6jHs5RsSg6ClVMcoFV8iZJ1PwjAVfrcxlJSUkmbNOfZenSzv5Wy8zlftZMV1xGLZ0J5KsKiFyE4u5GEVuapAreBpVPAPHXZkeS3DZvMh0MU1r6RUQ9wR6pWvazTb90IaNuAr3yk2alJFP555Nu8gLBoMbiYpbTnQLhr5/YPaWdvGQ1BjgYpy3JR8ctp4qyItWEO3SrnKKfHvxHyfaZdh5saPpyEEFuHeRDL/sIUG6Pvus36Trxn13UrrJ4XR9Wlhyoi1QmUzuDf5zP9mMFZlf+fsYLX7MvIdjbRM92FyOOU4w8sxEuhyEdjft3wCyKJUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yqFMgXWfHQ2pVkqHSUEVXD6BiFGQiQTAgpqwTWF/sg3c1uL141oM81LgEm?=
 =?iso-8859-1?Q?HLO7yp7eXkF1AEBIrPqf2onsmZiJ4LmUkZ2s+WQ/dpnQQXl5fA0eLanKF7?=
 =?iso-8859-1?Q?U0dmML98JZ3XFZocvnHl+fioGXwe2oEksCk3Wgsl6D73bI0SBJ9Rqg8FhE?=
 =?iso-8859-1?Q?KFjt4mwW7D/N7zGzGuNC+c2Oe810LggaE/v3OZUwep/SJgKP2SpcgGwfbM?=
 =?iso-8859-1?Q?TOrFMuAobg89XpYf02Lzm/WtRmO5h6hQEGX9eZjz3Gobq4hf9bzSlkpoTG?=
 =?iso-8859-1?Q?b2zikZP5dUYHM5HMi6Z6fsQXK8or5OD8dRUaEuhDNkjcZj3Cj+B6bfmi9C?=
 =?iso-8859-1?Q?JgUggz7DwEJik8kclPkE2lQVVT/cg3oSy3fx7oGXN+0cOMmHXGzxXk8auq?=
 =?iso-8859-1?Q?lai5WKRntoBeXQXYQLJL+PAUgozH2Mg2WLUP7LS7QoIV6hM2Gr3TGZlIDa?=
 =?iso-8859-1?Q?lqmAt4UBOkAz7eLh8spve4cCbZY0/k5yYL3K2rtB7EJ1EWFkrElC6f0v80?=
 =?iso-8859-1?Q?mqdoi5gzsSxivuzHImDs3O7L4CpA+3muUeISZptT71TY7/RQGoNCUUxl/e?=
 =?iso-8859-1?Q?/HA50OlYJ/QlzKwlcmzFHK1mOW9bVZHWPGNsJR5Ww/6Jmgs/8bwGLPYwlG?=
 =?iso-8859-1?Q?UEPqfouHkBpvtE5xL8540mMnqLnavhm9WU9u+tV41/blsgOj9D6KsDm43p?=
 =?iso-8859-1?Q?E0ZovZGiF+3aD/dL2ytir1gQduoGMBEf6T6Yt5XNBDMGoUgfFQHYWsNvM8?=
 =?iso-8859-1?Q?dDs5QOhEQ34HkKfNZcfMblOmrsH64kBKO0MPeWvEzf0af5RANkKNbLCh4w?=
 =?iso-8859-1?Q?I3TxJJxwpl3cDtEO2otj76zL2bZgvpNHjVuynL8B7FcdEVj9eipieVhGb/?=
 =?iso-8859-1?Q?KB1kDm0p7cc/ktB+N3hIv76d2VOMn1X6IQpNS3urDRbBjrKKGwIqLCBs15?=
 =?iso-8859-1?Q?xa4PVhereifJK0qPi7PT4kmBRUZQ9ru8WYGl7gTVXG5EZSePc+dQLTgZfw?=
 =?iso-8859-1?Q?JN/klRyufhejW95PZde5Hes8xWKQZRLjiK37xgwys3UwYRIkMoGrj6Ac75?=
 =?iso-8859-1?Q?xxB/OCalJ2LIc+akrPNwTXzIZMiRD97nn9gzLYfIBnV7agEIBfPyVY1+Zc?=
 =?iso-8859-1?Q?AKxmWag4KFUBg/yJlGG9iwJthoeZiHkUGoi7dwMcN4iN+mIobRg77SvguN?=
 =?iso-8859-1?Q?GfR1IxIPyIWz9mshTBboqR5HvpWPJZKzBfi992wPb2SlofYJhcnHCXZa/x?=
 =?iso-8859-1?Q?JMLcrcrzniecXVNSfsoUEHK/vFy7qLtAVbEjoOYvTPd7yUfjru/09sAlC1?=
 =?iso-8859-1?Q?7RT5cwtcD4Zpan5w7mGv6XAKE04seeC+wyVUSKWsKvys7IAsb18OERz9Y0?=
 =?iso-8859-1?Q?J++3DOhoTSqCTd2Crh1cMmra/IF6A9rfNmd+x74vFmIIM02hSO8b4YusFW?=
 =?iso-8859-1?Q?YCxfRQFmLr6GyAYsk8FizSzHSwMLNPO9rupqwsDs2TjK5+gmf4OoW1Tg8f?=
 =?iso-8859-1?Q?Jqz/coL0OIHxf9ybumHga3oJby8ze+bcedyn2oEl1Tjft/PnICvgA+QEjf?=
 =?iso-8859-1?Q?qhlq2IM5Mlkuz37mpsG6vdjVc3Qt6lBES29iBmlKANi5vVkJsA45gC8c0D?=
 =?iso-8859-1?Q?4yokHCyTTPG7I5MnhJA446iJY7wQrpocW6lzTbZCxviJV+Sx/JQQV82g8k?=
 =?iso-8859-1?Q?tSNTEIBlqo3BP0yDeORNuvYTCLh9YCVKfO0e+AnqnaOHqjlqSdqIKE66Kl?=
 =?iso-8859-1?Q?JhDzsiD2KZ6tTfk32b08WA8DJlLQyAFWQnEFJcHCnvBJF5FzpoqWAh8sax?=
 =?iso-8859-1?Q?5cCoz1UgJw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pkI7IYlO2rlj2UlpusFZpsZyHaTOd9fkYsD0h0U9kTIBZAhSUSzsulDTrFrfZjrkdN5zReXwFwxX/2XWb5UI23+0wtShYcbQRR/b49zBwtuxwVRVqs354jGcSaSo+/nLuOKIM4UVuIgaNCb1RmHjv//jbQx+3g8w+tBeAffTRfvIKVHs8LtX2AU359JhYUvI90m3MLub9bZ6i1FmoV1C1L7gDe5Fn68UE8I8MbStr09jrUEP07hhliAryS6eF9dbDQ1W8fW2QvS4X1uyBmIAwQzpfzOEpl43o4xkky8BvrKcIYq4BZuGNVHUYEV0rsYljWDLwCTxWtqDMkcMeLWhMQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0d374d-db53-4c04-2ca8-08deba17e78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:36.4707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqskJeyW1qYenbNh+j8gZ5DURxs5mCAjdhtP+pPAtB3trfbI6WFXfhr6EmHw9KnU9lNy4So6BmX5TtJ9LjAiM+C7guX+am6RGhkIxcwas34=
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
 hw/misc/aspeed_sbc.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index e5dab1c7bb..6125d2f134 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -261,9 +261,9 @@ static const MemoryRegionOps aspeed_sbc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
-static void aspeed_sbc_reset(DeviceState *dev)=0A=
+static void aspeed_sbc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    struct AspeedSBCState *s =3D ASPEED_SBC(dev);=0A=
+    AspeedSBCState *s =3D ASPEED_SBC(obj);=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
 =0A=
@@ -330,9 +330,10 @@ static const Property aspeed_sbc_properties[] =3D {=0A=
 static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_sbc_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_sbc_reset);=0A=
+    rc->phases.hold =3D aspeed_sbc_reset_hold;=0A=
     dc->vmsd =3D &vmstate_aspeed_sbc;=0A=
     device_class_set_props(dc, aspeed_sbc_properties);=0A=
 }=0A=
-- =0A=
2.43.0=0A=

