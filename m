Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E650C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7Ks-0000Mp-LT; Sun, 12 Jul 2026 23:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KO-0000A0-Tl; Sun, 12 Jul 2026 23:27:33 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KN-0006VO-ID; Sun, 12 Jul 2026 23:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd0wtzXzbfBWzZcATvnojZvc+O0eyMSLu0DebOBIJCD+VYXX7kb+TMoJKVT+Sr6Pd24Wtwvms6QAy5BW8k3cQ0YdqTZvo5Ud0ceu5i5wOV0cQF0aEYSmFpU6jXRu4F/QAja83je3KVw1GTTkMb/ayOzFWdP6g+8WRzsvirVE1LGl9xXXdBzM0UhsNJglX25istNN1n5fHEylhRNJY7O8Dx+qMq9q5wzcdJ8ehSGLQiaYnrC4gR8diYoAsziqxJou+FNQ0m+0EBnERf+CdcRpLA/jBLz0QTwwjVSV701sglMAke6I+2urD01CbepXujLDaV0R32mLFAw8Z1PRO54iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3y44iH9R7kzBMWF+/wDWdL7b/FDmL9f6aR48fR3eGQ=;
 b=iST6UdMLJ7E2+OlddoaQbrMbTqbuqH8RC3j1n7GzFjUp9lvBZKxMz7RJhVejqMRC8re3zUWCTusdWwaz3eJhKbYZVnYLx9Quvc3RHKIQUD3NQmM/2ySyzUO4nzSauk4aogmKvy8n6MuTw4hKb+Pamck09LXph61K+vxZjBbKVuMn8ZLrBJSsaxPw9CYmeCV6e/rEogFs/IRatklrA3jbKz7ImpOJA1CFUfLxwtOG0Ku1bXKmdWm+yZmzmELn+b7hGkYrNvSTBZWW8V7qfc4Mmmfqrbcd7FknH3MqaNo5UfamWq6E4+1pIJkhvi5ucG0UD1uJO7wO99zbiKO4QBebCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3y44iH9R7kzBMWF+/wDWdL7b/FDmL9f6aR48fR3eGQ=;
 b=E/YFqsgsPTCEaxaFZGZhdhO3ZjomGYUSyfWtSDIDK3SjcMjYP2729i1eisg0LG910bqKOn7AnUeJiYkBaArxb1lKMyGL0StQl0t8Wbc3Bm6n+8BRuiFCSv/hKgQ1suTQ83kwmBYWdfRdP992Sv/fMg24bkBLjwaU+N6yZlKqM9A4W1pMEYEyW8N3tcbOqVPYlF60jFfrqzTfre0gQ4XU8U/FOPH1yxjVpGCpqXRfHV/WXaXIR9nf2bZ07biUjz9k1mbZdOYv3bmggfctfNJwPBJWyW9A6MorD8QYaGa46gOCZlvnfStxQVTUyB5Reer1VOy+xDzOX7O4PI9ySaa6ZQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:18 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: [PATCH v7 08/10] hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
Thread-Topic: [PATCH v7 08/10] hw/arm/aspeed_ast27x0: Set EHCI
 ctrldssegment-default
Thread-Index: AQHdEneBPSBg4Sm2lUW1Nxr+OjSkPA==
Date: Mon, 13 Jul 2026 03:27:17 +0000
Message-ID: <20260713032704.3583103-9-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: 0d0a6275-00cd-4d79-30ea-08dee08ea42a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|921020;
x-microsoft-antispam-message-info: Vpif9evederA0ZLoEB2DZA5wfCGfv+3IQcWVcGrJ/WwXgK7gJeS/5NDw5Tv01ZNkREQr9uNHGOAK6TZYzZ0A6EpXUsilX2tSVhi5Ad4dCTeKN+Q/SdP4tPlhkOMdSRiFBIoCMNlr2XmzojpnbYlSfaKgfyAKvjBKeFWvf+rrf/f6+mXXeAZ8oFwghE+X/rFDkgg0WOmoH6lOjpIrD4XLUjHT4ZdJWWWYz7CyyrSBGJWU7gGwOTRUJSv/8b/uSrN8H3qQGQbnfrQrM5X5cwsCHEdul3OzQhCc+bDuptiuudqnQGNzwCBnuQHJrBvtytwQNWFe5uFj5UuAvd3yIXXGzhYBCKn+it2ujl6M5vCK3G4XcLbVYpc6yQCvx9XAhKAM26SBuChtTOrUYNXmFPaDI3UAiqflHhLT6lgO3tOdjttRwLQxUnoFYG1JvV0A289N3qgfjEpehCnj5b68bt+EvwmJCgJAOTfkrbaBqy9b64h/sKLEGLc9F33LOFC4qW/de/uVSPe1CY79g7OG6+4R3TkQBhqiuTyT7qcS36PaROwZsAi0+7Hjd7vkJ0Mu5n4UwEy4tj+TZBOi/zP1S52r/qLwq/nXQJDZrRAXeqA8RkS614HmnqAhxmSAw0jVYsBrOlbKsNMrwNPEN2h/pk8nMdjk9QPPBpub/cIQYx385X7VW9GZfea9b2oi16X7EXwK4vRVoa6GbUrOdzhWuOsn0SSG3gAgrpej5V++4Y4ylaUbGzNDgtBBSew8jBBKNqtw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z4fQl3svXekRkyjaFz7xusEQWS5qkPLAUQGfsIMbn+bQy7gliwfD1/IRNA?=
 =?iso-8859-1?Q?Qj8vB7ItgH+21H9GtcwY8VyigO5nq4RAN3VvtzWyUiJXHa0wnJDcbRHq1+?=
 =?iso-8859-1?Q?NQ7FL3JjmFlwJbgrLSoDD2vje8IGPxxLuJugjDCSEIjvgldnbuEQo2Plm7?=
 =?iso-8859-1?Q?sklUj1LMpWQUci2hcLMYp3/b7m7VbwTldgy5Q+KxCABpZF2YKV4+jOhAqq?=
 =?iso-8859-1?Q?TkS4zBeD5EJqlOFrd3uqIUia6cCidSQZEAafLOc8ky98zqYuKsrpSoQlWZ?=
 =?iso-8859-1?Q?n+siRqg85gZDETvY9h6DwK6zl3JPn3HJpnmv9afjkpqPbqc+0QDC+3W/8Q?=
 =?iso-8859-1?Q?DLlRtzKxoObWuFQY0yUAGTtG17DmYVVZMcQ+tKJq/nD8Kguv5t6/Y30w7h?=
 =?iso-8859-1?Q?jvDFCheSTiWqMGVo2WZXPyrKKJwjgdULw0GfJhrYoxryKAC49tHbLT91ii?=
 =?iso-8859-1?Q?zpkz/Ofzvlbnek/WToGyTqOY6Bbat3jkQRPAraK/fVOiQP5qotXJex/7f4?=
 =?iso-8859-1?Q?+ZV3mV/cKLjxOxMYZWo5yb7kopru23MKuPjxGn9Cpvf8QluBs5bKV6mZJT?=
 =?iso-8859-1?Q?jBR7ot6r0nFghDAFJ78xP7EFDFxLexW1RQhs0sn+RBJrj5yae1Ic2cxMeZ?=
 =?iso-8859-1?Q?IDl3TFfnQbrT+eqexsMiCQrX8PvUrxvCgIt+Bon1qPA7C5hVY/Y3gq3Sax?=
 =?iso-8859-1?Q?UEiJju9T4hSlmZYCW51idIoVN06S4rMylgcV+IY8bes1zrI1NFmaK+nOqu?=
 =?iso-8859-1?Q?+QTUYZMETYcIQ4SDdCBI3geOWb1bklwkSS9dHgquZ1sFnmCtZcteaWiM7u?=
 =?iso-8859-1?Q?oNLXxXL9IDDDcolhd44FdOM2ydfLv8IjF8ms2G1cR3yWLjgmx48Q1EDwlM?=
 =?iso-8859-1?Q?fm0TWJmbbAYUrZLrOUDAOSvoT6zG9BRIjuwcWbO045f8vhSNuJC6DukkyC?=
 =?iso-8859-1?Q?cyVmrRvPZw2UyeHCSLPVMRSNcfSk5vY65C4fBqrPwrcX7Ubjq2FFvIcvoY?=
 =?iso-8859-1?Q?JlwEHv7MfsmYVM7KjLmOx7iopplZFhhw3m4DKwDFGl02veFIexGjlEu7Gm?=
 =?iso-8859-1?Q?t6hKGPVtTsJ3FdUOjoEVkYQE/58vrcBw215Nu9mROIivpf2jjkz9pWngKv?=
 =?iso-8859-1?Q?KvslpGQ4Dk1rClSFqvWDllBNvrDnZwW3ofapTThH3Q1EV+HdDgPNfVFZ8f?=
 =?iso-8859-1?Q?kmkvpmOCzbyMEZFu5f3GTr+zWPcHzZaozH2YRfBMo+j3uH6QkJ9hSNrZl0?=
 =?iso-8859-1?Q?RHCaSIRY0YDJ0cpsba8Xgh+T+2gJ6yha7niKh73c+oiHb7C//3erM2VcoK?=
 =?iso-8859-1?Q?gX5PpOWTKnFRhMLZePQMn0miCBQzNYuN2AG7EaGqADuXWKjD8HoWSgpF2L?=
 =?iso-8859-1?Q?1/N8Mk4+6PQN+REjTRq1UvESR8dZ0nXChmnbiEgYerLDQgupAwcpG84e1o?=
 =?iso-8859-1?Q?vRJ+O6kS8obb6h521N1z1IR6MOLEuoaxBciIuriXOM6pmMuvdRIl28GTL4?=
 =?iso-8859-1?Q?cmT0ELB9srFCt/aY8GEIhqOg4tZLOeEZeVkHMbSOcb3f5lY3pGZ8szeyjD?=
 =?iso-8859-1?Q?t4+lme/MCuoKnrJy9H9Co2zzcrnlUXwMEGMDX+Y1h/YRxzaFs+DCp7ORr9?=
 =?iso-8859-1?Q?gIw3jygHuM4KIXwiTqdYxp6b/oUGGZx8IewoupKBIW4GSSemxUcqXOoNbe?=
 =?iso-8859-1?Q?39onMjXnD+G18GWumNRAno1ZPr+cdfzHxNp516TkfUZDBQPdBi/6bsZFLG?=
 =?iso-8859-1?Q?gbVjNYFssnAdz5HvQF9XCpFFU4fjF7XW7EAPjX5yK7WMoqsYv67ToFOtKn?=
 =?iso-8859-1?Q?Sd5TQv2pcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N6mV7l4SoXfDRVlCGpcrsUdQGU7GM2brojAHTApAi7uYzrYeQ9aKvFbJYZXypQtCByzHdX4ztphQ9KOhJGll1QzE8XgRvsaNN3tpyyE36EY49UD2U5uqqKKnEcdGrQ62f1jWBJf/h3BHmgmAasCKZaoITdD6P9daaFjPWzuphKSX1G+wgSz9dfPjAgiKsdcnn40Z7KJOoSKdlrNQjXiUZMJvYvl/6cEVO3/JOr9CTqS6GWmahMla0IiXcPQpoS05h+aqQCyqA9rl5V4TUy1w+l2MxQsqtRKaBL1GPa5eeiODMOLDLQHcIIZvXx813V8hWgVFDs6kdODiIQnhD08t0A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0a6275-00cd-4d79-30ea-08dee08ea42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:17.6927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCIE60xDV0bBrDIoNUSGi0r94WqrOzVYB2iOwxMtQRazWE+dRNgUTNqBb+mFOwerSaGWw1hN1wJhEH0uohpq7qwYi43kjJ19fjw/8J+9X5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
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
Set the ctrldssegment-default property to "sc->memmap[ASPEED_DEV_SDRAM] >> =
32"=0A=
so the upper 32 bits of descriptor addresses are adjusted accordingly. This=
=0A=
allows the emulated EHCI controller to construct correct system=0A=
addresses when accessing descriptors in DRAM above 4GB.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index dddd7d2106..0b56d2bb67 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -870,6 +870,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
+        object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
+                                sc->memmap[ASPEED_DEV_SDRAM] >> 32,=0A=
+                                &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

