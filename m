Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754FCC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDF-0000YN-5c; Fri, 17 Jul 2026 04:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDB-0000Wu-Gl; Fri, 17 Jul 2026 04:46:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeD9-0003vk-Uo; Fri, 17 Jul 2026 04:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVkRzIusxh4pgxGSjS2Wgf14Tm9ZwxFXUblvIPDSsDhMfiEp9Je/ROZKa2VF2Pa6IqBmn9smYw9obtdEx8XSjKyFPHiFNSXvEN1HdWyc6oV5VqaqR2Irrr21FrzYe5vcsPd9Nl24hhfWUhOGMVvWfeFa8EEtXUWf6F2alV/kFcIy8fuzwnOTt6b/Yo+qbuFNfazP0HgtThEz89qgSWLUQaTy3Y5KNXt0EvYGxfReW6QupseJ3+yOmwB0OUaq12U6mZr9qFVZ8U96Nq62iZMRCcBYyg0S56Hl/cnWh6e4NIjq3wXaBtFveVoT5d2NO8+oyLkUEtsYrKIAvJX+g6Su1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx3Iojt6We9l2KiNM6vA/h9zsim8zdynz8i4yrlpFBU=;
 b=QsIIbb0GgyGtAmWKHMY3XmGCKatVPRKAU0nRllYCC10xIrrOCkbAwxz7yWJ44hwozYRzKkcP7JybWfsnkVvplViefaP2hB3HxhOeZa8lo494C9Rutdowx3lsbUhzsRItTLNsiwNzW/HUGbHLUi+58anIJBeJm93YTbl+TRbVwNGivuVicgN4vGjPtSEctdv8L86Bq2+gVZSnKKs6m65E2KGt7BT3dIWW5kc5Ib+03BRT/NVoYwxriIzvG0bmUGvG4349DcjMzBzpVonpXsB4hNW4fdV7YZxqXRozB76McFpZXyLl1UomBsf6ADQpk3/lSkW5qg2WKlzOW36GHQBM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx3Iojt6We9l2KiNM6vA/h9zsim8zdynz8i4yrlpFBU=;
 b=ihF2chqxeP5pk3dCJt5ZH5lFXbnhatjtd0A2LmxlJ9xB4wPUKAe3Wtkfz9TM4CHna4RzTGZql1JG8mJEnv8ithomRSoZHE8z3xHNF2ksmoFX/XiHoCR8AJ+nTB8H1O1oY4y90/wEQDoqKe+UpYD4j/B08cCAvrki7nbyBW/quEXofY40LWXYh93Lj85dFpUGJmE0XcKwknveYfAXU30lIU+K+9mb3CaXT5w317LDts9U0MzR1oEEPqZci5jMxRgLRLymUM3Pn1jdSz0iOj/Wl2btbKfHBGPFoDL7anut+YGtieyyp60mV6a6EVzEgyPoNJxISwm8Kes40swygfJLLA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:07 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 5/9] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to
 SSP/TSP initialization
Thread-Topic: [PATCH v4 5/9] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to
 SSP/TSP initialization
Thread-Index: AQHdFci1g/pQkg55SEW2z+WR/PLSxQ==
Date: Fri, 17 Jul 2026 08:46:07 +0000
Message-ID: <20260717084559.3477061-6-jamin_lin@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUZPR06MB8267:EE_
x-ms-office365-filtering-correlation-id: 5364f60c-6002-4161-bc2d-08dee3dfd7da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|6133799003|56012099006|10067099003;
x-microsoft-antispam-message-info: wYPiYJyB//b+bSzIyOd/fqFc6rdJ6JMgbCYjrxHV97BSKVaygkX/YD7zBrK6eZEhX8+QdorIIxVy8eFj5+Ulh26EYYWwnUncpjTOFOPJP74ggvFRfYPOBncazU2LjVlFf0xvzMJ1iiQZBO9zdhQ4Q1adfkGQ7bhEYrloE4UvVweIctwsg1adoiDplgLJIdG+W4xsFZAZNc8pn9z/n1tlpDgLdVsjnI78R762RxvoRR36jwgw82zwxEG/9/Hbg5YTcuKi8IX8Lz3l+a7KvjGFLtJyvhlvnxuTnVJ3XfbkZMD+DDhwryF2U1QFdNYYcuWCaspAkCx7rhfMueDhS2SAyzQjRI+JbrhF3v9Obo7LIKlyqlKLG7aM+BhHlFTZi1OzxwzRFDTMpB7waudMMnRdoYg4LngJwZuY5ZkQdWQx8JyvotmwjigKQGLgz4w6CdT5yJp1b/iHu6zQesKvBwz2K9h3D07QnVEtF/vZA6yWuduaKku2AqB5bh9LuHD8q7IYHGto7ZO0xLYf1sBhYcfTaEKuFtHVVX/sspwn6LiEBtYp7YvfPaZuU4h7pCoJJxz0nb5t1c8nX8lRmeg8Qfvu+TUyZbVb1gnx7vV5GCrlwFnjJNOz3ONdlJVS1TkEiT6977UbbREMmn6+Oa390zWUodGZniOgBAouzIXbbeF8VdPcAPZt1WU+oLGRcBGgUiZlLHu0UEV9257F0T9DzQCXxssxqpOa8Fgr7Zu3VqNPqzKQ3s4ewMEtKYFfL2eMlyZF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xWC9Br7wAJEdB5reexB2eIrcQW8qqtMkXvGnw9vYBhOW75qOeuBnJ0hEhw?=
 =?iso-8859-1?Q?ziAc2CVVQGGxJG79OdXw6mcRQYXdngRQG1ItT4qpf3lxgJp4FNJi2dxRDz?=
 =?iso-8859-1?Q?B+Wy8/epcD/Di57gj/xUOWr4taBVlbDTQ4fCD3+u2ir68GoOPFF9zYZLff?=
 =?iso-8859-1?Q?Ntx2UOH92v8qpbftMJrckPrLCDI0ETTVAeyz8lj63h0dMHMf9Coql593ee?=
 =?iso-8859-1?Q?BiIqa4E5xB+kNSjhOOprL0HSnW7GxvAHI6EKr4P7mwe4dTxHqZO2DMfco1?=
 =?iso-8859-1?Q?bs8AEYaDdw8W6uyy2omsr98+B0N7HnkZS0rHCnnMSkCxEdJBTrQhKO5HuY?=
 =?iso-8859-1?Q?dMWh07TkyOlglytVuiER/aszG+Mvjni239BFrfxlZyPkan3pZTPN+RIO9O?=
 =?iso-8859-1?Q?ZtYhbaEVVjaBB/U2fe8R1ew5+NDCxFU8EokSfsdWNII2XW3N2H/JMqQEj7?=
 =?iso-8859-1?Q?N7vl1yi8H50wrVYJ9Dvf1iZaiXGdaf0WjgwDwZVr3rCjtTUnmBvPbUwx+P?=
 =?iso-8859-1?Q?dCa08Ddmt+YRr3QwzsL5r3BsgTfNWSBKGK5aFuX8jiwj12PI+akKeBkxoP?=
 =?iso-8859-1?Q?tl+R+stPPRUnf2nBEfrLkS2z+xQErl2sh2743kxajMKEmYJe1M4oFT1Hnd?=
 =?iso-8859-1?Q?P41sdaVoAJwRk6cGTePJiuAzxa3kTWxHiUnhHKJapHJ8NaepeUb7u+tbhL?=
 =?iso-8859-1?Q?xVhuFDZdcW65ivkn72wtFd/piyHM/nnRZkmbNwn/O6bTsq2lSpJ14/R2FL?=
 =?iso-8859-1?Q?xIarCKsTIGxhqnAriqFCw5CXFXo1QvmnI+R6EWOJxTUjhJ5wBrlR0qVVuN?=
 =?iso-8859-1?Q?ei+AubFHzBj+GzAUjEeKSO4NlU5/VOXGwG8PnSQGSgE4kussoUFVuL0pPP?=
 =?iso-8859-1?Q?FhRWppp5gWklKCoOOlWAUdQ/71QWIjduzrPglFGo58CjfnvnGSSifPRR+H?=
 =?iso-8859-1?Q?2vlHcR4d9XxItniPx43amc+sUghvg3ZEfqgi8m38D7meYvmEOhlL4rfFSN?=
 =?iso-8859-1?Q?GtPFqJD+en5qEhJxANRD00T0wvafDJuZO/EEQxvIIG8H2GsYBMAlqCugcb?=
 =?iso-8859-1?Q?tyu56V4VqtL1jjrCQ8qlyaQch0xV/Vlutv4Ah061yP3rrhARi3m8IxuyAV?=
 =?iso-8859-1?Q?+vSeIDhsjsKTP2655ZIFenNlCXaiDP8WW5Vj7BC55FaPIs3h6oXoiEkp7j?=
 =?iso-8859-1?Q?GljZmNGLYXKOYFvOkiTSsjl4t2nLgUYUCiCkoKJyjFgzUOIJCD5idNTJK5?=
 =?iso-8859-1?Q?v6OooZ7hPSzGzkzNmXc+x0ltEe/RHxcczQzdCC8sbLmGC+OPmv0isK7rlj?=
 =?iso-8859-1?Q?n8WB7sQ01CR25TMg0LhnofnNYdUGNkK5rP1ksNN5aGbFT+l0pRHK8lL8RH?=
 =?iso-8859-1?Q?c8X6KAo1COFvtuH+mx2s0jLnwuW6K2gBYP3As5o9Dm/HVdWUHaKNvOpf/g?=
 =?iso-8859-1?Q?m5XNjWaPjEcjB4qFDdWs4vDxOYk2VJRKPfQybu2M0dIT5Etl8Id4A1LG/Y?=
 =?iso-8859-1?Q?bwcfBC6RZ8XieI6bBxgPYJLaKwXBqpiLkhZbc9hbh4TRzkjt/Bq/gNzGzJ?=
 =?iso-8859-1?Q?ndAobsWgAvTN3wJb7W7rgxWj4z49Wzntzose00V9Kh82ZtmzEazz5zwHfk?=
 =?iso-8859-1?Q?So9+R0fLMbOXRR5Wi/cLqEL7zie2hZ+IaPAlwfIEP5WT4ulkJJI1s7+XFI?=
 =?iso-8859-1?Q?v5LqpWYq+hlHbv1vernaCs1CAIDJ4S/8rQwHPnFxKm88HmcXK6Us5xBJJL?=
 =?iso-8859-1?Q?Ml5Madwpr036J+sIKhkFdo7doB/xu77yUB/FgO9Z44PjGHC6S3XOgFW6jC?=
 =?iso-8859-1?Q?KMKOSNFwLA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WtCcbpnl0HCW9Ggz7Hl57B0LiJ44ONaHL5oVFHRLR7/XZ+0D7ef/N6H4ZBSJ1ZX46XtJjoNLnTpAmVkCScgd2FCqc8wqBrpkxBz84LDKzt5se4CXQnGKSPUt5yr4ZMRBssOadB734iZySwGUNv9yekZv6MR2/JZpTLYl9Yb9V7KDSp+gY2xqxz1jv5S9Zbtw/brgwS/mLXBL5eWO20YEjKy8nbny8TuTGwjqkVbK/q9FP0DZ6CwLx0qeB1zu8knboS7HiuhAHZd6b4vYVdw+6iorh6l02oB3DCCorAgMz0ZAbaVyJSwF6g6UVNwpbzOJZG5680QFMCso+705Yns+7A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5364f60c-6002-4161-bc2d-08dee3dfd7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:07.1521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4dBgmOKJN0SJLS17knIO1DeR0mW7z+edPyfhtXyL2pz2HwxWV8S3M0BMrXL00jYqs4WmyveqntM8R5+s5nj/kmSrmoFxvpCyg6LFWGmAB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8267
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

Pass the realized PSP SoC to the SSP/TSP initialization helpers instead=0A=
of retrieving it from the MachineState.=0A=
=0A=
This makes the dependency explicit, since the SSP and TSP coprocessors=0A=
use resources owned by the PSP SoC, including the UARTs, SRAM, SCU and=0A=
SCUIO. The PSP SoC must therefore be realized before the coprocessors=0A=
are initialized.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 26 ++++++++++++++++----------=0A=
 1 file changed, 16 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 8d49bb95d6..58d0b4d7cd 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -134,11 +134,9 @@ static bool ast2700fc_ca35_init(MachineState *machine,=
 Error **errp)=0A=
     return true;=0A=
 }=0A=
 =0A=
-static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)=0A=
+static bool ast2700fc_ssp_init(Ast2700FCState *s, AspeedSoCState *psp,=0A=
+                               Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700FC(machine);=0A=
-    AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
-=0A=
     s->ssp_sysclk =3D clock_new(OBJECT(s), "SSP_SYSCLK");=0A=
     clock_set_hz(s->ssp_sysclk, 200000000ULL);=0A=
 =0A=
@@ -166,11 +164,9 @@ static bool ast2700fc_ssp_init(MachineState *machine, =
Error **errp)=0A=
     return true;=0A=
 }=0A=
 =0A=
-static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)=0A=
+static bool ast2700fc_tsp_init(Ast2700FCState *s, AspeedSoCState *psp,=0A=
+                               Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700FC(machine);=0A=
-    AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
-=0A=
     s->tsp_sysclk =3D clock_new(OBJECT(s), "TSP_SYSCLK");=0A=
     clock_set_hz(s->tsp_sysclk, 200000000ULL);=0A=
 =0A=
@@ -200,9 +196,19 @@ static bool ast2700fc_tsp_init(MachineState *machine, =
Error **errp)=0A=
 =0A=
 static void ast2700fc_init(MachineState *machine)=0A=
 {=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
+    AspeedSoCState *psp;=0A=
+=0A=
     ast2700fc_ca35_init(machine, &error_abort);=0A=
-    ast2700fc_ssp_init(machine, &error_abort);=0A=
-    ast2700fc_tsp_init(machine, &error_abort);=0A=
+=0A=
+    /*=0A=
+     * SSP and TSP use resources owned by the PSP SoC, such as UART,=0A=
+     * SRAM, SCU and SCUIO.  Therefore the PSP SoC must be realized=0A=
+     * before the coprocessors are initialized.=0A=
+     */=0A=
+    psp =3D ASPEED_SOC(&s->ca35);=0A=
+    ast2700fc_ssp_init(s, psp, &error_abort);=0A=
+    ast2700fc_tsp_init(s, psp, &error_abort);=0A=
 }=0A=
 =0A=
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)=0A=
-- =0A=
2.43.0=0A=

