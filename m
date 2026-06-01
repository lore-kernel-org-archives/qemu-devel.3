Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2519CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjX-0003Az-7Q; Sun, 31 May 2026 22:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjV-0003AE-1s; Sun, 31 May 2026 22:50:29 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjT-0002Y8-95; Sun, 31 May 2026 22:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3Elf1hf5cSJSf459ieg0+n9SSh+pYGb4wAmPF9+jZoUDdqfyAjA3wvr7C8bIth6vedOObibVa0RCIWcIBvAg2ioFFNrzdBm8s5/556zf5rkITezX69ny2tBVDqMWdUQTOYWT1RJOlacjmg/Re7kO+2EJLnyiippSiGrvCsUGfr8XsUYZwUpe+xuYjTksQddK2gIOaUUt5sAcHbUm+tHBJctmogIRbkR9biZv3uPLzXPVElwbpc5LOW5R/X0VDGQ2Ff2l6LMvDrnzRZNGwhkl7/3Dpvl3+Y8BqEcjnOJ4qoQBxTyoX1xwcjljDzIs09syhdYaAoW3SgVVqEzfPtCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyy50LVywkF1qN4MSkKuqIIwCAuaseZgRHzszbQLK6k=;
 b=w/g3oly0UIpStpc7sf7G9ss2XOn18iMdEHw2hv2mJP3YR0YI5weVpnQI91ZNU66jbOMmPsEOydp2nHsp+NoXViS6HzUZeBm2ZXmBTLDYRqdEb7n7FpZw1brLugUcGp2YfPcXUuWWCWFa439Nt+088qCpycXyrUgo3eSEBM1AAO9faZapQIsdsGMXSTQ0pNKhiCZQKrdhulIGyRhz70yJnR1lmDd9t9kIF4QA7onbhPQ/XbfaLRTrYz/bYLsjThdlZrERrvEikgceE0z95IAMuxuRWt8CmwFdveIhIGXJ4RD0/Pz7f/lgsE9/QZzDbGpSOSU4utYFriBLq3O8DSHqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyy50LVywkF1qN4MSkKuqIIwCAuaseZgRHzszbQLK6k=;
 b=mmvOxi1uUxEeEnFd7NARrQraTojYC7loMp79VKnhxR4HlsoBv1qMYQDjQq6ksCj9l9uG2aO3XqknJcOM6WcNFRmWGuM6V26T+NI6Bxwh4Zi/kN6IFNGLnyEZ16kz1tTR/bUfPPJqnNpUCN8YZCAelh53d8RSngEmrJmbXnsSdjlncMF4yRNqynVYagskVH/FKaZmt0BCL0hZod4/aHgAntTk+jdjqLfiA+ee8h+/0CH42u49V9sX4rWzuU31e6CcUDM7j6d7F2eSWMfaMxSkIUDBKWEz9BN1uVy33BAd+/nEXtNq71xMJa8+lwoqTfUtoe/Gay3+2NZsC/K5h52o3w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:12 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:11 +0000
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
Subject: [PATCH v1 07/24] hw/misc/aspeed_sdmc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 07/24] hw/misc/aspeed_sdmc: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFdVeqPWvCuN02p/sqJ6WCcmQ==
Date: Mon, 1 Jun 2026 02:50:11 +0000
Message-ID: <20260601024959.2347639-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: f736178b-6c91-46de-56e6-08debf88801c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: 3HsQGwgTlM+Nf+Z6QEyGYFPJEJokJDtX+SZMXM9bgQz5B6CUNxuamRX3UCNpuEWamDHsUjdaOpUX/+1J4leHkMASyEpzL1FyR7bdIMaD9zlvvINU1hy3kcmgEI8WbCQJCy1blPHQTxj5gbRngYdchI5D95bnaEUZKz1BIuVgzltRTocSesd8rPV5bEpME7USxJ+u2l5k1IH2xy6DrvDGMVoo0Cq28wyuJ5cw2qHXHPj9EEKVm7JPQIxrIarF0RaDZsqmj7ritVsL4hrexQt978oxxQpdf+KYdfQLdbcxeGBCm8dJBJ+FwTtvCEmPBLAq91tprn6splkbYMA97zS164exLrIHWWMaOOD6BSFqd79oTN6BRVJ+WrO4A+pez9LZGoJiYK4m5rGztnHD3hZ8Zj8U3sB9IE4y0sM0XHA2W9NpSovbNguVftfnJuiTLOsim9Ff11+/EJDfzlacO3jUuPK9iAZ4Hc+hM/vkJvugQQubGeVmboOz/757KMkhubM6AV9WOwG42HOhHUhzzXuACXqwls6Y0aoTAvwJZGKQzsviq42ZCiHETRa5mhsJuoBs9LPyhcoVJWzpoK+dbkFcRvuI70xtBdwJrPtmZehpdTv57SBeb84bgortt3/V4zrcmjSBqpMQGP/osCuxtc26XNnIlmy2qqrvKaigorGrk6A/a9TdZHBPvga+yLFYXevdaLvYR+dLg6m7S8kdDKccCJMPiMicybs0F8FbSXY+pCrYjv7FpGi6qp+aRcg0GVC++e1gQ9ruojRAWpu96B65lQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DWMh1qzji/a8uC5s8Cu6H/3nnIbq06LC1A/6kyEFhkpxFbBzqc3NyDjaWZ?=
 =?iso-8859-1?Q?cW+PM9Dz2BY4uJAxLeYRIkc464onJzXccYGraQpzuSG9ieoNpfjXlIBJEH?=
 =?iso-8859-1?Q?2RsuMl8qrOekcSyX+KVRSZ//+SWiOxsMPgFGR3VL/5QjAPdky42uxUJGik?=
 =?iso-8859-1?Q?PmW5yyfGmv7HzPE3NWZd0323S7W2xnCsm3QDSURlDREpyx5Aq1EuFhaz6W?=
 =?iso-8859-1?Q?YNxhdGpl/DQ3MrrMPWWntAFsJeCvjfcnonmAvZn2p/CQNuwfRaDyxseezc?=
 =?iso-8859-1?Q?2wD2lt/ALkA4jZEVf9eOjc6X4wIv+NmyG0f8UaLnBVXRcVlLMNp0kzZC6k?=
 =?iso-8859-1?Q?JOUJdz+llFfZyrhCDH+ZlYAWdfNTNfyclIbNbLGHZHWgjxT4zOMTBv2WUt?=
 =?iso-8859-1?Q?EFXo/sebkV3VlBJQufnAVDShsdwLFfipxEIqpZmBCeQ5mvlFOIaoVKvUT8?=
 =?iso-8859-1?Q?H23F8h4NxQTzzzk1CkeyMFOduOi2YCIKJy+qWyE0805vIwN7Q3WkPt+oQl?=
 =?iso-8859-1?Q?hNYCUi3z/lPurIbh86PWM44kzyeLbP3IrBBQDWA4YedPPKpO8w9kUIaOJ1?=
 =?iso-8859-1?Q?cDQ5A49t+ftvrGtYdE6Us+vo6ETZUnbylPTe8c06sBSL0RgEHCQ5y0iyIX?=
 =?iso-8859-1?Q?QyZTgY+9HEn/ImlMdQynJVkyXS+iUJNSSIDDqg5JVqhLQEwvl5VmuWzpV8?=
 =?iso-8859-1?Q?ORLTowCWDhdfB/NGuK7UQPgRZDNrPGISwpkM/EH5oihaFprEUnTkIzt0ah?=
 =?iso-8859-1?Q?+f4geXdxuwzg+SyiCMn8ewVLyi+r1JWs2NNEin9s5uranULQkAg4vcKSx0?=
 =?iso-8859-1?Q?Wc+to5THiN42X3cjtdMdTOhWq0VLc2M7ZW63nPy1mgTY8kELGg4tw73iCn?=
 =?iso-8859-1?Q?crxft+g/aQ7W+9lM8texjmz930WoUHNbDXfZ50lesTGAqbIhbY4LCdcei2?=
 =?iso-8859-1?Q?y4B4K8ocTW5+eIEzm49DdhIry33EgO97mLFTKretIhHRAsDpqwXm8CMxbf?=
 =?iso-8859-1?Q?8H4hAYpAcLI4YiDLPh9df6oGWzv2ZAm+csqpF8DSyhKDSCN1/1mau7/X2G?=
 =?iso-8859-1?Q?kU7m8YIcYDqraVSvNdnSdX/TZsYKL36JusWhK8OrQyNr8w5UXFVfq3fD87?=
 =?iso-8859-1?Q?VdTUKkXGVyh/2bipfnIqF/a9gYRa8cdeU2UCTNkae59FkorhnlXPKW96sp?=
 =?iso-8859-1?Q?X7NoFPez8NDNSx8tgmd/f8RXrfh1ybwJ226eDhNb/BRb0D5HVhb6Exqqfl?=
 =?iso-8859-1?Q?3hGCuzMlwJ8OBdbp3BtKwi2PWEl+zvJjmh3aDs3AWBhIOYWpbnk6yef+QA?=
 =?iso-8859-1?Q?jx23CM4C5MINeXpjKl1MpsUA3whhnTbW8LKm+aJk/HkF4Xi1FsjLJgQ27H?=
 =?iso-8859-1?Q?ijZw2VloZEg5tqme8UMS+oYI8fqCUge9Tx3IJzaLI/rOGMOC+SSWBU6UT2?=
 =?iso-8859-1?Q?yLSaxsy1NZdiI41CqqdBUjsI5EK0EOTpSszIVOHgckx4pThjXILh/IT4QE?=
 =?iso-8859-1?Q?GXTbVdFOVKrRF8rjx/Lqps+W8YIJa/OI6SuzMOcveQuggYELs/hzkBESmW?=
 =?iso-8859-1?Q?bUE5fjfOYEmCdCeNHz/JU5KRzeDvRn+uvq8KuiqPaDHDfcP4S9uxnCuBb1?=
 =?iso-8859-1?Q?kWv4gi2AnzyC445u05BXEjrJqztrd6aYc2on0A4kC4OZQOByOS5fILr3uu?=
 =?iso-8859-1?Q?zH7RWR1I5+DThRaIsC+GStNajAtZ8wSh6ChxGlKW7BibeyaxFLNhXFDn23?=
 =?iso-8859-1?Q?JDy8r3OCexw2dzexMgOr25cANDSkdwMiQXKl9qoImtqtNWxb8SAIYsNzG6?=
 =?iso-8859-1?Q?bkE6sG4eMw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lHOky1+0masvFEJh5Hp5wiDIh3JWwIsde4hKo2i65pOP6yhX72kPfQXZKK+GNcfqU7IrZPuwBLO+qpkx7GU5oLq7PevGq8IacPW2thAvKHSQXFsWIKnHx5m5kLff/LFF4BtwV0aJoq889ke+7xbF2s0QH8TDSAI/zybgoDHLX9qNC/QgjeaatyvxulgS8ykWo2riiqEObXX8uv85yxXA5v4oJZCB4ImlQFnKVEDTnBKKejQwcigM/6xhUEE3bbBYSZbujb8ABHrBTcpQte9axbLtDSDKgQhPSOEkBxsz6xsSM5C60aoJfoIcXurjfL5gNgDi2UPn3Fq4265OEt+0JA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f736178b-6c91-46de-56e6-08debf88801c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:11.8470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7tIAkII/x+eXjU+Vm3TUNmjGxZDWZ9J+P6+T67sUeYJdiBiHSQLdMvhwGfMDXSiLdrrics83vbd4vr4vRpYSPZlP/0f4M6S1608VhwcgcU=
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
Inline 5 standalone TypeInfo variables (aspeed_sdmc_info as abstract=0A=
base, aspeed_2400_sdmc_info, aspeed_2500_sdmc_info,=0A=
aspeed_2600_sdmc_info, aspeed_2700_sdmc_info) directly into the=0A=
'aspeed_sdmc_types[]' array, removing the need for separate=0A=
declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_sdmc.c | 73 ++++++++++++++++++-------------------------=0A=
 1 file changed, 31 insertions(+), 42 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c=0A=
index 055abf7f50..f8fbaebee6 100644=0A=
--- a/hw/misc/aspeed_sdmc.c=0A=
+++ b/hw/misc/aspeed_sdmc.c=0A=
@@ -310,16 +310,6 @@ static void aspeed_sdmc_class_init(ObjectClass *klass,=
 const void *data)=0A=
     device_class_set_props(dc, aspeed_sdmc_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_sdmc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_SDMC,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedSDMCState),=0A=
-    .instance_init =3D aspeed_sdmc_initfn,=0A=
-    .class_init =3D aspeed_sdmc_class_init,=0A=
-    .class_size =3D sizeof(AspeedSDMCClass),=0A=
-    .abstract   =3D true,=0A=
-};=0A=
-=0A=
 static int aspeed_sdmc_get_ram_bits(AspeedSDMCState *s)=0A=
 {=0A=
     AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);=0A=
@@ -393,12 +383,6 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *k=
lass, const void *data)=0A=
     asc->valid_ram_sizes =3D aspeed_2400_ram_sizes;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_sdmc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2400_SDMC,=0A=
-    .parent =3D TYPE_ASPEED_SDMC,=0A=
-    .class_init =3D aspeed_2400_sdmc_class_init,=0A=
-};=0A=
-=0A=
 static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t=
 data)=0A=
 {=0A=
     uint32_t fixed_conf =3D ASPEED_SDMC_HW_VERSION(1) |=0A=
@@ -461,12 +445,6 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *k=
lass, const void *data)=0A=
     asc->valid_ram_sizes =3D aspeed_2500_ram_sizes;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_sdmc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2500_SDMC,=0A=
-    .parent =3D TYPE_ASPEED_SDMC,=0A=
-    .class_init =3D aspeed_2500_sdmc_class_init,=0A=
-};=0A=
-=0A=
 static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t=
 data)=0A=
 {=0A=
     uint32_t fixed_conf =3D ASPEED_SDMC_HW_VERSION(3) |=0A=
@@ -555,12 +533,6 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *k=
lass, const void *data)=0A=
     asc->valid_ram_sizes =3D aspeed_2600_ram_sizes;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_sdmc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2600_SDMC,=0A=
-    .parent =3D TYPE_ASPEED_SDMC,=0A=
-    .class_init =3D aspeed_2600_sdmc_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2700_sdmc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
     AspeedSDMCState *s =3D ASPEED_SDMC(obj);=0A=
@@ -690,19 +662,36 @@ static void aspeed_2700_sdmc_class_init(ObjectClass *=
klass, const void *data)=0A=
     asc->valid_ram_sizes =3D aspeed_2700_ram_sizes;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_sdmc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_SDMC,=0A=
-    .parent =3D TYPE_ASPEED_SDMC,=0A=
-    .class_init =3D aspeed_2700_sdmc_class_init,=0A=
+static const TypeInfo aspeed_sdmc_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_SDMC,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedSDMCState),=0A=
+        .instance_init =3D aspeed_sdmc_initfn,=0A=
+        .class_init =3D aspeed_sdmc_class_init,=0A=
+        .class_size =3D sizeof(AspeedSDMCClass),=0A=
+        .abstract   =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2400_SDMC,=0A=
+        .parent =3D TYPE_ASPEED_SDMC,=0A=
+        .class_init =3D aspeed_2400_sdmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2500_SDMC,=0A=
+        .parent =3D TYPE_ASPEED_SDMC,=0A=
+        .class_init =3D aspeed_2500_sdmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2600_SDMC,=0A=
+        .parent =3D TYPE_ASPEED_SDMC,=0A=
+        .class_init =3D aspeed_2600_sdmc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_SDMC,=0A=
+        .parent =3D TYPE_ASPEED_SDMC,=0A=
+        .class_init =3D aspeed_2700_sdmc_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_sdmc_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_sdmc_info);=0A=
-    type_register_static(&aspeed_2400_sdmc_info);=0A=
-    type_register_static(&aspeed_2500_sdmc_info);=0A=
-    type_register_static(&aspeed_2600_sdmc_info);=0A=
-    type_register_static(&aspeed_2700_sdmc_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_sdmc_register_types);=0A=
+DEFINE_TYPES(aspeed_sdmc_types)=0A=
-- =0A=
2.43.0=0A=

