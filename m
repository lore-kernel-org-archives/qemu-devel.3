Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D687FAD40D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSR-0007ad-PO; Thu, 23 Apr 2026 01:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSQ-0007Zi-8R; Thu, 23 Apr 2026 01:18:34 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSO-0003JZ-Po; Thu, 23 Apr 2026 01:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4wvk0juDmpZ4cMOdlIeIWVl6MUD2wfBZS+7drydgAnKFNmiK+Npfa0GPbpf/Gw6cijg5PCL3C2JtY1u5joqWdP0wkcTzGJXfPqA+ylf1kDVNqpcyDE8rBL+sv1qW4DecEOmF0uljaK0aJknesEEX/m60DeJm4WxDdmUTVEgys2h5M6glEKvjht73svXSK4EY4cOwDqAWzYtaxjgpLrAJOLIg95U+/9nGCQCVcqVdn0CeFzvTLP3Nbt2Pa1HYm0SzGckgQhkb7I1f7j12CcnxNv8FbwI/2TP4KmE1ZxsFR0yf29GAAGAnyDXklgm8WLIKGadtESkU7+lQZrxvhJskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f2cd3fthMEmZMuyPoZj1dkySjhKi943N1RlHzcvRr8=;
 b=Tf0rc2mkEj3GjnAtBnsPUYPzPvDb6OR3uNEEDeHoO2z3s/lnbJRca75LYLfLONAXDvCS5A/iDQh+sZf1bH3lb+R93EYeu34I9pZ0w0mjxPhUK4lxVfTQeQM3tBSY6x6g2TlzwIAEtzU/q3jAeWN/rWBzxdcVmGU4JpVTh/NehS1r16db/6ipfEaIhhLbbvZICeH83tvrOeMiFjKLIi9KsIX40rfcXlToegm44+VjvTZjxtkJOnqF0VZ2HE2n8CQh4Wja43rElxDHWAnQX0qn03M2qhGQGi7sywHbueQQsnG+3PeBRO+9emKRDyL43te2RGcKTqj9PMvFz0lAMay4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f2cd3fthMEmZMuyPoZj1dkySjhKi943N1RlHzcvRr8=;
 b=RyJbbEz9qQycpZOkNpyISUSWC57ErodQCikWo4LLLH5yWC954q9Ln69NO5gmcrE6mBfIKGtsHAbJLR3blGMUs/rElZ5xg6uXvogRqicalk7KHANrGUV1OyOhITC8g7G+us0STpptOCZvM2UDxxpYoc9ujUPoLKRMpFKu/qB4GRgxvnaDNXeWDFbD7kA4XgTiB3AadNU8nhdwxDz0UJw/MY8Ib0bnXm+LOu0MScqViQVEw1Baas+y34Hfxbb1aFelmtHC3q/BsCSiR1uZpSuXjMXCxdxY0JfeaTxnDBOkaa1Ll5hSd+N9v1EFpwskzqcnH73nNrZt50oW/+y2Yjmm0Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8434.apcprd06.prod.outlook.com (2603:1096:d10:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 05:18:24 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:24 +0000
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
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 15/17] hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
Thread-Topic: [PATCH v4 15/17] hw/arm/aspeed_ast27x0: Set EHCI
 ctrldssegment-default
Thread-Index: AQHc0uCbSyMG079kM06VmrlH+yoZFg==
Date: Thu, 23 Apr 2026 05:18:23 +0000
Message-ID: <20260423051804.362095-16-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8434:EE_
x-ms-office365-filtering-correlation-id: 9b9492e9-273d-42d9-e5c4-08dea0f7be1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Y1w+UZ5jkK7TsQoHNbednIfXOR6KjVwD3+Rxu0b8NQwwHdATbEZ+tGZAwnw9LCK2LDWOMro0yz/CtDHE0df4817kdyqaeH5bCqL7GYRzkCq7rA9RRZLwgMq8X2mfFdKCSOjZuFfMtERDUBDTfgaosqcENVs52UtNELsHKEBXUp05R+EIJF4oeDy15aWYJOYMoFv8JZ9a03HnjKXxU6PqPfbtVDoBHZtYFuXu/lrKbF5H7pAcpkWdOMIyhshQFB6F7SCY84Uxw0O4nbz6PzKhdlziemgwocAsMCNOJuuEaTnMmBnfjwPxOye9NXYFIBThb/dObV1KcszqZ7/lmbCKYMivkKXeAixWsOTrqAd74jZKBIFi14nOl2dycVeBRCwUoBWY9kErYC55CL+QetQijCdnerlpHbFYEPaqfdMSPn5TJhipjcdTgdFH1epyRXV3rpa2q4jNdZTAU2LCMF/uu2EZXo86oKsy4uufXIfCSng6jX2NYmtE2GZ6J8i3qvIEumF/6OGwK9qxeHYmLYJZLbpSFG4tISjIBsZDfe3NB+i/B/SuhKR3mB3Exd7WiTU7fUde7tz8Cy4wEWq/z7lQhQjU8GkJy9pT4jAuZg8J8DCX3vRUPCjlFoKti41MrdLVotqFe9YCggKM/w5xuiD4eg/vn+QB3IuTDZO6Qwyi1/D4di1AtkMGCqQP7NgwsTeLWXxboNVhdnQPMKkrMbtWMy6xbSKLywFgaPHNV8hb5GWwySa+QwhHr/fnMOx8jgCLLNvicZ4IVI1I13uKevJNoQ6gv8xNlJm9VppTXaSwDqLjI3Ep9PURuIOWil19uONj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1pQDzVQ5S3XrYZe5YrOswmSTxQOR4aIcs9PcqEF1JsUO+AB3UMN02vWrAS?=
 =?iso-8859-1?Q?wJpqWZHa5nAoaGIdiMgw5M6DzdhS7W2KIBO6P0GNmRDHW2vUliyUf9QZ4a?=
 =?iso-8859-1?Q?0WoOJyyVrlLXhqdhNTxq7HBP80oYEyaz9Zap4LmBWtTSDd98nh6ArFVQAq?=
 =?iso-8859-1?Q?nVxeRjRdz9DXVj1IHoYpGO4ra8gf5YkB3OSMiFPCFnAiHo7b4hZt5gXw8H?=
 =?iso-8859-1?Q?2h75RfPIaZHpK8u/e92+rl6kC9St8BFMMinkr5HzRpN/+AssSC8bcqDt87?=
 =?iso-8859-1?Q?G8VmtC5/MoBXlXrrq5Cm/MCudiuvEod2ilxYwWMBGcuztx6bpOsmkxz7l+?=
 =?iso-8859-1?Q?+qkOmxWEEqsw0eJxennKgR+PLPP6D1uUsNBF5xhqTOD+wTBnvnOKtXWppK?=
 =?iso-8859-1?Q?+Aedfza1Syf/7Fdc0ddi+cUK9By6J7pMG7IZwz7FWz62OLX/h/Nts8Rsw+?=
 =?iso-8859-1?Q?F8H0LBDNMULz4F7LS36WN87uxZcZ6RwYGoUbEpMgGCXVcOyBewHuX2K0d2?=
 =?iso-8859-1?Q?U7xVfuTi4Qx11yXX+ukKXAdm1UdG/VdgaqoVa7oXeMAIve3B1MglSNHc/h?=
 =?iso-8859-1?Q?hus7dNn94h7h5s0ufAgWjh+e5/pML9ZiAKO9y1WdrblxSjoQ8dqIdfnNPp?=
 =?iso-8859-1?Q?VOn5IkwdrzQ2ZxNJJyZJXJj7jbmu2FHPbiWumH0euxk5TSBYK8eicL+kUv?=
 =?iso-8859-1?Q?djsFsUPHAtTb2hm52G3Dw1HEHdcFIl0NncbXRan7L1II9nl/OJy7ZIQpQP?=
 =?iso-8859-1?Q?Fo5kJZ3W92sC4Fv5SwARGz0Seyk3dfYX2Tuof/5Mzn/V0XJk7KOB0HH0Tn?=
 =?iso-8859-1?Q?yjXNH+Vkll1Kut7DzB4ZRc95f3FGp3vAt7ZxdE8H+WGesITPijA4blzG31?=
 =?iso-8859-1?Q?qwrYZAL7AJcbu5Gz/VO1IbhTbD4WdNQcTHoLjevYjJ3cWn57WHFGTW16Pt?=
 =?iso-8859-1?Q?NgUFwqjwyzGDRmrr6QSJpGQCxtYzVzYl2q1+jUWQN14Wn3Ucrltx/qjNkJ?=
 =?iso-8859-1?Q?NBnBB5y6zzhFctEFnf7hHcdzqR3XsTEOHIPq8KIO8hLgpzJWMpxA5wsQB1?=
 =?iso-8859-1?Q?Ep1jFPbhaxv8+/4Kt8fRkpPh4LPTiqTuMCLHjj0AFjQqJQJOKaf16s1gxm?=
 =?iso-8859-1?Q?+OPyr4t3RZNJDPuxJbF+qvNzCydCrg6Zyb1ag9GuzZ3YuUA3xM3JwaKksi?=
 =?iso-8859-1?Q?RCUs6qqz026mbVNNr/6Q7f4C8XmVp2WGnFIqXPH1nRRtHvFXLxuujvHcJp?=
 =?iso-8859-1?Q?mwzdNaRp7KCLbBYdIctp+plzz765E78bNuAWMqZBZF9BfXwgE5qKkmA8wi?=
 =?iso-8859-1?Q?qw5McFyX4GxumLVHBAHzQy4lL1N5g/qu3p+6N0FZn/2XIKUHNsIjnM6pIy?=
 =?iso-8859-1?Q?EdFrC6NlmVuw4PhQvbPfgUOeWMBYsJTZZFW/xe7N8AmOe3QPpdb0vxhD8u?=
 =?iso-8859-1?Q?2uI9fPv+i4WtUQQ1FWxprnZckUAgx+6SK8sR6eq1jZ+G/68Fis68GuFIoN?=
 =?iso-8859-1?Q?c5npthJ2bYFxMr3iJy5o6DZKk+e+uLRe2CHIsPk+ozON1aFtMNOjt+Ef1a?=
 =?iso-8859-1?Q?7d9hJAEKj6n8iJ3r7FmBg8x3w+DVR7hneIQyxJreq6h40CsOaxq1PWEtoY?=
 =?iso-8859-1?Q?5sBWDi1gaPY1NEp+0xbrptFkLVrkWeOrYTxvJ1IXm1Rv6ougVe/dIH8Z6I?=
 =?iso-8859-1?Q?k2lSLMroUUfPIVAxh1JMY2q2856k7AYqRRVV5Anrn6RInoDm2mE1hnhtW8?=
 =?iso-8859-1?Q?jSGIpelyb3snpS4pcr4gId2a7YfAJ25Uup7HMx7fRdKc4YZBxxcIhj4rUd?=
 =?iso-8859-1?Q?QGK3e/yyog=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M3GxHnr9FjcknVXcgQo4OIS62X3jrdT/Yku71y1DvOCa8imiCD3LR/arRNMRSJDcIidAPLbFs5eqU90gwawZ5IxYxsJoSooKx3MzUCkK7/sK5tYv5KHU4HbzmyXk56fqdQXb1Ho2+fXAaVA7XKdDoz2685kxDTR506RqXz/JfrmFcqyc6G9yGY2wRccG+pXP8NptyF2c0uqt1BvUV8jQQTmr5PxIrBDvaIrRvoXtGJiU6jerXhUfdu+VuYfxknlkNjIZZyaj5M3jVlOX1GV1QOlY0+exi1/1rMYPfz0lpS2R1ap2aR7uAg5OP16fGzi3wgVRY8miVVtX0gn8gBNVZw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9492e9-273d-42d9-e5c4-08dea0f7be1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:23.9697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yFOxi13EkntPuxqMPsNjeS2DXpl9rdfxpJGbrDSI5BISuZCsnHyOUDvm44qk7OlVIKQs/ciHOWkdABq5t6zClREYDA6HPG9PJQkZ0xYDXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8434
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

On AST2700 platforms, system DRAM is mapped above 4GB with a base=0A=
address at 0x400000000.=0A=
=0A=
The Linux EHCI driver programs the segment register to zero when=0A=
64-bit addressing is supported. As a result, descriptor addresses=0A=
derived from the EHCI registers do not include the DRAM base=0A=
address.=0A=
=0A=
Descriptor memory is allocated through the DMA API with a 64-bit=0A=
DMA mask, allowing descriptors to reside in DRAM above 4GB. On=0A=
AST2700, EHCI queue heads (QH) and queue element transfer=0A=
descriptors (qTD) are therefore placed at addresses starting from=0A=
0x400000000.=0A=
=0A=
Set the ctrldssegment-default property to 0x4 so the upper=0A=
32 bits of descriptor addresses are adjusted accordingly. This=0A=
allows the emulated EHCI controller to construct correct system=0A=
addresses when accessing descriptors in DRAM above 4GB.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..0cb39dc191 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -856,6 +856,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
+        object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
+                                0x4, &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

