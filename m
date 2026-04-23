Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1451BFAD40E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSP-0007Yk-D5; Thu, 23 Apr 2026 01:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSN-0007WN-2A; Thu, 23 Apr 2026 01:18:31 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSL-0003M6-KZ; Thu, 23 Apr 2026 01:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEQf1WztwiHnvU3WAat8AtVTVQ8dfr+MWi+lg0QRfGCbu/6XQmBqMVKyNBxZfgK5kkhMzF699ExJ7ZfAt5csn7q8PTxOJKHwG5fGqzvDS/2hF0Y3dMx7ztCn9TRKHcGd/S0Ro3JQjtSTcmjlkEJDZ0aGU4Szdv9LQr2f2lwFz9l0X03E0d2Tm+GdjERoArsaOo3AsrKGFsE+/eO+OFYZ0o+nEUA+U1HM1lQ+8/Ga1ZxHywUL9oMk1U3W/kTozS6COOk10RSsC7qDwguhmPvvI/Mj55H6DTUr9NgMri50dibw9BCoIHFl31CAbrrIhFPKp/BHEXcNeiIMeK/YGOW9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6kJShgNwc7EOpcMbd0ButIrMV8f3NyOSWSt8Ki8ywk=;
 b=w1rJjXQd7nICJHVacBYEvj+ot00kd2DnOVpleqXi7kU1Jn0KTUrf14KI0iBHho1sVCxkU2ZrQsfPBPHSKW572odnwI/f+xbYq7KOq1vHUtcbwB0h7I3dTa0K/fDlpIXxH/wXu+dFYopscWuGPwZ/05V8O22Cvw9I3HaKQeVoBb3T6Ul8GwPbp7LM1FYweqqmHIhedZHONPnEOt4jJ9eAqKcfkNPgGKCPnt5PgaZ7LpLecRrz3BCsIdOyjXH1UgAf24jTla3efEZ+T2Hf3gLJZzZ14eeXvRv5Hhvk9I8uuIVt6q5Axpt8vKboyiur4sHwM/7Eiev7QBys2HFdB9D1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6kJShgNwc7EOpcMbd0ButIrMV8f3NyOSWSt8Ki8ywk=;
 b=Lzif02iJQrSz6a7U3td/G57UTndoWAhzJW/MPHziTEwRsGCtVLOa9evS1BiqOhXJE06to/pxztVVgPmte8zLA/+dfeHX1LWL4wbV56rZ5ofYIUb7/Akg+5XKf4374QAJtov9X3e0ayBLI/tG8VlBQeTD6B2HEqYKEEluKiQvyBzlkpJsc4XdNGwNeq02Xf+2cInyjRjCykY3jA8A5h2NleaX8ziu/dQde0lqnC5zlCmP3Oh1PFiZyBHVMKMziGdSEOKMsTu23UVVdYTxIwmjKJPRS3njEY9qsuQNq43brHW/Hp003uMVfQnHqCaPah3yFGfW05/fyKaolcWdyrbuzQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8111.apcprd06.prod.outlook.com (2603:1096:d10:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 05:18:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 16/17] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Topic: [PATCH v4 16/17] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Index: AQHc0uCcOoJEpE6isUy8zwQGiQ0XqQ==
Date: Thu, 23 Apr 2026 05:18:25 +0000
Message-ID: <20260423051804.362095-17-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8111:EE_
x-ms-office365-filtering-correlation-id: 90c249ad-04d3-4655-d665-08dea0f7bec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: s9BRX6UqIA12WNugLa4sp90PgNTP7JYvPBi3PSI2v48aHFBXCkgkl+SwbzClojDlCkghvE3BAg3AgqdARIInc4H1+EEY7Cr9l6yLJK51DhL3GKyXBpCm11fpdGwVeqFgr2Y7ZQuL2/eVBKnNpDxLKzWQi0DwqWGBg6iGn7dII+9sL/O01lO6bzREdRACiI8hYxR09Kvv2gfCLTU4BTXQccDREhKisnBDeZhJJr1Qdi3/wOcksw+cp9NOHyzozfiTj9VwvxWnJpmcAaQ5R9n2oT1w8Fl1ZRUpf4Nl9FoQuvWJRgsKEvHTRuC2pt7oiw0id/iDytynmCZNiofAvyRfX0mZlRCFvokQGZr1koxTBO1PtMd6ezU9FQxi3JqKj3p7FEmdeF1wKE0qNlxAm3omU7NvIpLfAcrD45I6/TGvWDWl/wJI3H9BONcTQzd+uQq3MIke7NJBsX1Nf9BwbM+k35CsiqLcOdqEBt1p4PxbSlpgOBa03RQ6erJt/xju1bA3WicRLtvf5vp3yVhKKobLM4/L0RtfuR+S2Uqc0wX4C+AOfi7IHnEW7C7Mfijgd89JYBQ+qSb1UKlbDKZoZsaaAFY/+xRv9G3jiRRrR3YQ6YJn2c2QEnCv5MXbD1VCOFW1meNFlKwQFpqYinU+sG24vmS1MNzrbc3Eov6n84OWJke7L+ALo7sT+rVSdJIa+6doLqMHJleWgmQ8OVtRXNBJUR8v4+zQFp/FICOszrR4oyN1CL/RNw1IINH/K5PmHKLu15jfilbt232og2cHSxOVOBsSlHljb/JjPKYR06Ejph5D7zFMcTgiSbCwT2AigRHn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SLt5urOL/saxMyTG7DdhpKkcskdBRl31XXFXfyICzXZNW5xrBLX5e/Kw30?=
 =?iso-8859-1?Q?zRaiO0g8xHJuOGoJ2a7BbBRKtNK1mzmYi+mKsUQAL755baZudTUwNfNnlX?=
 =?iso-8859-1?Q?v7Ty6HfTFoficxbZ0Syv6jNmUUzaNFYJXAleH6jY4NVxdtM5AHiaLt0kSN?=
 =?iso-8859-1?Q?z7isUtCNY2MKrhLG2/dLUCzFYDOYfrBN+EtHV38SlfLYxJKZAySJwbktZo?=
 =?iso-8859-1?Q?ckNtfTtgBrD7IODeFEWhOUW+poPNtVdkaUA7YBsaqOn9bHLdi35sMsIGyj?=
 =?iso-8859-1?Q?H6cm7C4Jf1xgY1ARX+5248yec3XgvZ/SdHF5pfCTNEty+20El3xvmLslRf?=
 =?iso-8859-1?Q?8PsugX6P87MpxQ5b0kSZqDtJHxSrL4+RuhcknafmiLr3TDJasY6wtge3U2?=
 =?iso-8859-1?Q?iiEb8a2LiT2qKa1WL8Og6E97Rkl9iHDGSrOoWZQdeH7/qPY7Mr5FPhirpQ?=
 =?iso-8859-1?Q?kTZc7ZxKYnFlD9uNfso1Wylfr9RJQdDImYfhtEHCI8Tb953xdLcckfj8KM?=
 =?iso-8859-1?Q?Ge+gepg3M7u53ryuCEBGMuih8cfQDwmekRhLMLpf5Yni4KC4Po27upvin0?=
 =?iso-8859-1?Q?XxANhuu/zGGEcGX9o421gx9R8jFwtXH4EfGg2egu9cbqS+jeK+3YVk43LS?=
 =?iso-8859-1?Q?mjU8HrP/9+EIM88e0Vpuq68+Zt+DKdSRoN7NppMzdNIOCddhyygsCdw2Q3?=
 =?iso-8859-1?Q?4gHmGSXZIGWh9jSX4BtVR6plwgM02/PkNi6a2fNsFJWanvXkr3qZHMCNn2?=
 =?iso-8859-1?Q?lecVzOpKZUp5su5cX8Pbpb9J4dEeWS4XBdRo/aSKFFJKEEVkdN0Qhy76fw?=
 =?iso-8859-1?Q?TB/Mw9o3oiKvZOrTn1xX8TH0YXYEPgmtS2q58fFTeykdGjkyCxLhLAKLSR?=
 =?iso-8859-1?Q?eztR1rgt7j70mKBuTq3xLM6lBh0cae8HF8wJ/HtuwQhUd0TIhu+VupXNiq?=
 =?iso-8859-1?Q?npXzztmNxdtH9kDLPkWfv54sq7hIyCrGI8SjeXWi0r8s57gaSYnTvbbCLv?=
 =?iso-8859-1?Q?bOIw9+y7y7x52XyWgLKwl6mpsaTqngqsIeyunF1D99EPakow6762feOUE8?=
 =?iso-8859-1?Q?AhQ8jiuWO6GoG93JXpRPbTxYmm6PaXZpomkZ/s1qCULXzg8cOka8k8vneZ?=
 =?iso-8859-1?Q?vIQDg2HQFziFlCuQ/JOXZSsOpaM+8ig4tgSFw9A8mDEZfgDQna2ui5LyiT?=
 =?iso-8859-1?Q?LGuANs8xivd7d11LwKEnAY9zdC23Mwiiv+CuZeVJ/UE31/GmOAO0fIpvim?=
 =?iso-8859-1?Q?sKCnAVRW8KWCe7Yd6pEnBaHq0C2iuoPmILxGU+0KdfC6znI4E8OL8kdwce?=
 =?iso-8859-1?Q?ZmhFSJYVagHO8V6ozeV4QtgoSDGrJ/4u8RlSt72qAsBAbTmzVx3JItUWkO?=
 =?iso-8859-1?Q?rTa5uwlN+/1K+BX+vWpb7W2AwNBsdIRZwjXbT0EhNLwrJE1oQfdL52PikQ?=
 =?iso-8859-1?Q?ayT7oplKFkz62E0RTR+gx21vUKNJbCNRJPJVr08TLpW7mI7wKvNVk+524s?=
 =?iso-8859-1?Q?vt3wXU1MJXrIlMCP0B22TzBSZNoIbnYIaY4OAZBfIQzEw3d855G5F/OgwC?=
 =?iso-8859-1?Q?XppxyJ3Ef9ChwmDL76KWcaTE1pMX3KU8/kuE8d7T9VYRZ+Bm/VKxy9dcdY?=
 =?iso-8859-1?Q?1hBwgnExU3YmrNYLkrgq7xHaoIQ5tukki76+tGU71EKgagSbabg/vWE10B?=
 =?iso-8859-1?Q?hvL78JK55T3n8nZora8hNVEmFYpFWBTCuqaEUFUDCa9cvHceW9KHWIPtv5?=
 =?iso-8859-1?Q?WJGg/B+eJYrLSF3ndPVeOvkbaAFKTX28dCGuS6TiLN1Gz3oJwCghd3TpMJ?=
 =?iso-8859-1?Q?ZXIWAMWh1A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: btOVcAKcMUCFrQDV1LpFptnmyhjEBqHvaNLvMxqtAyKlWBDG0+WeS6BQzPoQKAdLlZ1R1mQwpBXif3Ebxsj62gr5SlClimKkB6+YvJlz6nf4EP97gAEln22EtL/trAXjK6YRd+u06cqQDWs9/zYVvI2QZuRyNEy4Z/Pki6oJLfuvWAN/kfPgEon4hJj9++QNRuSZ0YW98gGgJk3B9x/elloCuiZJORaLDeYOXCHVafvxDDgvoglYUqzPCxPksbFc253p5uk3hfgb84h0UFy6v0I8mN+aUS2nmEkR1AMcM3Fg5qNEwV6UMBkopgqsdGCDZGWSIPAKY+DvMsIC4qu80w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c249ad-04d3-4655-d665-08dea0f7bec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:25.1133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pVWqC3kXpm/yE1mFVjsnSSsmPGE0CepXv3HtKkVkTZuy8J45TfD6+OlvudRPAOBL4giDjLdvbe/wtPVJI0lGzOFJfA7vikmACU9wF0HC6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8111
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

AST2700 supports a 64-bit DRAM address space. Therefore, DMA=0A=
transactions must be capable of accessing 64-bit addresses.=0A=
=0A=
Enable the "caps-64bit-addr" property for the EHCI controllers=0A=
on AST2700 so that USB DMA operations can correctly handle=0A=
64-bit memory addresses.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 0cb39dc191..4959cc9e43 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -858,6 +858,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
                                 0x4, &error_abort);=0A=
+        object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
+                                 &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

