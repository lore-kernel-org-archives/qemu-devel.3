Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B24C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgJ-0003xu-Rt; Tue, 02 Jun 2026 01:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgH-0003wF-BG; Tue, 02 Jun 2026 01:28:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgE-0002gS-Dl; Tue, 02 Jun 2026 01:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkST8Iv+X40eNg8Y+VytOpNCf9NI6EoT2Aqe7Np9qby44f5Y1vy2dfBxtms47sVMEPEvqN1kLsvCJ7xZebeWuSUKTkHFB5BYFm/KR64gZ1vS7lPOmllecgn2/cvBPSt2xOol+mRYrRsxjRorkLIQ0xmS1NxP+LXPg6/AWAquw0awoORc44s/cCGVVNXuOnCyJhQWsSSyhXGXHzesbYEJixl0VkkfI1ajQcwuVzOyMwH0gUwkYL4R3SygVxhnl5fpsTyTrIHijQQi8uGq8UVPD0buYKbTmkgSJXFeUs+OKIAVyLVNswviDTnybXQ0CkzM+XyAHKO2hZ0/imBTNfExEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sQFWHVUXY18uniuXWWtKF9n764bQm6UVtavQBNUvvw=;
 b=g2Jg/qcgEYvUv/DAOb32eOjCg317wn5WreUIjhpwgWVUrozajmBABq1G1wtkJBlb/n56vC+yZy4czgwc/cfZJjW9rnwK1yqHKwjnbKA16Byigf5ckta0rOFFwz0u2D/gPG/mpJerr9+fY3ESesBeX6SemCZy6UXA/4OqlObZOJj49Y9jg8HOnKY0/yuanh9pgAlW53zrnxpyFQ/5EZAueAhcxEo5w2TH502/8XfzkUNFr4nfAftdslqp1yELytk2A5H9m175M5JdE4tuuzoyifELrJHmUfAwy3t9bp7IyHyjlRTRN6DYtXX8edKdfTGpimZ97/gsTmuJbkSPWpXa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sQFWHVUXY18uniuXWWtKF9n764bQm6UVtavQBNUvvw=;
 b=iTFtialvXRk5kNJjDpn90GG0c0kv5aN/Pyt7Ed8qWA+N+gaUbaeTtPt54cK+OQn+LxjX4J/lUIjE/vPPJL7cad0auOQRmJ1QbSAwDiUK4fkDu0JUj7kjEJbMjABz4u4UpaIeGpqLcJ2fJdrevBokMS/OHEhVWuCdvuYm9djWFweOw5B0NEWTOu88Tcz7SkgUCqXg7h+Zqtz/1geGRO/c7kM+uuTO5/MwTtF6Oni5lBNVT3F1D+ri9chOLaPkloHlOsGa+SvZQ5b+GRv2McgZPFmKuEnDSFPba6TMiOp8VDfODgcoQKMg2ol8G/G7koC12MF/CbQGnSQqL7vONDmizw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by OSNPR06MB9190.apcprd06.prod.outlook.com (2603:1096:604:493::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 05:28:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 10/10] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models
Thread-Topic: [PATCH v2 10/10] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog
 models
Thread-Index: AQHc8lCrHYFiMY5pDkuQB66IJp8DvA==
Date: Tue, 2 Jun 2026 05:28:40 +0000
Message-ID: <20260602052827.1535299-11-jamin_lin@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|OSNPR06MB9190:EE_
x-ms-office365-filtering-correlation-id: 2bbd4275-c3eb-4522-5334-08dec067ce25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: KNPZIa5PrD1kcjpyThhjQh+hKtxD9kaR6NqsjwZf+l0Vd2Qe4yMVlxho6TbQbNR6wLNJMfmeqLzsiWbQf++U9jo32YnJ+uxZSYmGx6T72Z99czcBbNmlOAa0AgFA7TPPIo2z0xuTZeJ+YrXapW77PT15XYFUMrWqwYUKxm5yZfYfT35f5swyYHwZTLNkvNS0fM2IWkzxtR6yx5NVaCKGthh4+cEIiy9Nh+jDs1PaL7vENXlvgNbbudxKIcljqCTQy2ngHZsmEh+jDeqxq2W05ApeQwDUl7Ryy4zWTiqSA+gTDMlgkyflUxbXMzFvi41K5Nw7YcuyhMnYNgDspI+24ABUWOy6WuU/E7p9h8YPTOxYJGTcygWOQZU0zeCj3RmZZ7w1Xtk42kwEuwBdKtiP7sbJtkR2b/gJn4tvKsPkXF6bKG/9z0V2benGm0yQqgbVTmEyl/YxmM7EZV1gADRRJ3KISKkXl9MbHSOnQOQkQ4XoBzZyMDaGqXvF/XmeCh4Essav2JsoWjBVrTjv4+l+CcCBzjWBl8S2Rm5K8/NKynlSi4PIbi5YX1WRPxUkyYACcCVM/T34F24+ciKe5mI+O6bAuwO9ckBb9XtsZrjyuo4gjQoBvHtsbeoy4F90fWvKFJCgSiD7pfFc3yFutNKZgzgw7XYOthZJQP7DQPlCM6qKoh0zzn1pxr0IhhMHZOpAqVKxrtX+nqhJlMZHpinB6qsJLi1oO6BM3/wMYecpKqA5ReF4RwOEjI0y3NjFfJQ2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y7f0/sMA0nkqyFjTwyfWi1GL8sw5upa1mOFf7Qzeyu17ihM+X/R2+/q58f?=
 =?iso-8859-1?Q?XTz9MrIKbNtzJQR0ULNelQjbajUxpMnhnF3kPQbuLBp3jYnkkfBY/zFjsq?=
 =?iso-8859-1?Q?Ee1AeCR2DFOq89MHP6pB75TwvyGEVvzBNDvONaVkq/5Z8EU/L4I2vNmidD?=
 =?iso-8859-1?Q?bumpUxRKN1jP+kLf9EwUxJBB/Fix8oF1r2YRYtFZ51Cz4g+7AmckpRpYHK?=
 =?iso-8859-1?Q?L6ty46AvOn7NdjvlBrwXc6aYew54/xV/eTV/0mSwgRf0Og9PQA6o1HCfN3?=
 =?iso-8859-1?Q?eFXMQgcwvt/+In0tTMSgwehlBkfF4aHWUOZ43lLGdH8Flb87kVDQ9bWmU8?=
 =?iso-8859-1?Q?6/I+doMi/0GuRjXLVfMb7iHltQz3tYxzXQQlA6gyvtEqZlKiMzj5thhaJA?=
 =?iso-8859-1?Q?8AKK8tRPUDmE6VHa0vYFKc2JTT6sgiEo6kKQjndYAv4Reiqp/O98mi8HKI?=
 =?iso-8859-1?Q?6jKxAObm/zOHQSOrypvKPHojEU+QTfcL2XzK+So6Nckk4RJR11fytrQ7zx?=
 =?iso-8859-1?Q?BigL2hRZtxhLp58s1TYuWiuwbhYcnyGc5Fzms1VszHSHnNChnuhMrTJOA8?=
 =?iso-8859-1?Q?GXBlLEtfhWiHFri8MOFyKh8Z8XHtmd+U0+a+i7TUAtHXBJwNoBugJA9s1n?=
 =?iso-8859-1?Q?8dPsBXfOmt+zvQTIntPvbB/Kn/dzUXGwzsAYiwz8IoVX6TZoPISCIqQGJb?=
 =?iso-8859-1?Q?mnTR78VcYwSoNc51vb51I6BYQpT0uq/wdw3SIM7SP8lZgMeAP/tUDMrGEN?=
 =?iso-8859-1?Q?CCTqw65J1kuHWpBSgDUU8TmNOY5jSReXn3KvmPp7j9xQ1phqnoPjbmbnUZ?=
 =?iso-8859-1?Q?IvSCYZ877oyQ3Tb0EZbiPFOlbmM5DCAGcIrKsJlEQK2REO/7Xv9ttviUUD?=
 =?iso-8859-1?Q?K5ZgHv1CQ7tqdNKiQpHEgaoA7i0QRIj7pBOaIXJXQ+jom1FvV7nUsbIJFm?=
 =?iso-8859-1?Q?hhpuaukVaVpWIoxFGd3y6Q7dtyfZdx+69/6UfrANSe1weSUEl3AobQ3bg8?=
 =?iso-8859-1?Q?BCSPbjIvdHy2/Jg3FXRvvmINEPmxet4lezgppJBB5kLPOMkBWEBqUhq7JG?=
 =?iso-8859-1?Q?lt+hDX7wxKPGNpzSrzo6JOUj6eZ8g12J+ZIiLdMyQ+S2U9qHK/oUKH0bpc?=
 =?iso-8859-1?Q?C4ukv+2bnxufTLJ13B1+IAyxzYAIgXrNAARGW+fMJMS5qsQkvrQW9FfN2B?=
 =?iso-8859-1?Q?6hq3N2hgtWpyLqtviN9CVqmk0NsJjYo1qy6r53IBSISZA74SNtkqK17ko8?=
 =?iso-8859-1?Q?hMCTpifys0u2h2YybzHGShpekJW9xMScsq8S9VwgY0b8aC2Oxho06QwKC4?=
 =?iso-8859-1?Q?55CtqkHhJ1fe7MSwW1t2siWE1M5BeYG6R4tRfFR8AtVOwlU1dWADyQamgK?=
 =?iso-8859-1?Q?fKcjpjlj8tLo5fW0LP+X1Sq7SZk28DYm+H7/YeV1vQxnaLOYJ24gJwTfQa?=
 =?iso-8859-1?Q?W9qe0YNRniqO6XVnBnRPJqAdZmwaw2Y0k9p0QBpRTtwxt0Iz6OX5vyhp0O?=
 =?iso-8859-1?Q?IzKyalQEIx3xgcf658A/830dyGABfYEn2wRoS0V6NJMnzg9JpNJytAuQq1?=
 =?iso-8859-1?Q?Da/qI5Io6uWG8PJTHSBIsHE4EzD+PqX2JT070Bt5TnHrnDuvP2oq0NHJmk?=
 =?iso-8859-1?Q?QniTa94cKN7UXQliWHUpts4pSC+o9A+2C/mrACk4MYkrMR4nYru63isuDf?=
 =?iso-8859-1?Q?9bScxbzXfVnXL8q/Gik7EH7Gm9uVFXdZl5Sv0BXwZNNrDmSoIRV3ipbe0t?=
 =?iso-8859-1?Q?1cQuIEA17QagzUfi96bQOpENeOcM14zzYOIAZ1aw/d23CsWVz+9COydJpF?=
 =?iso-8859-1?Q?t/OW8R09Xw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YY3MJMFsFj2sgRzye4nB+zCFxVTpliiEzo4ZeVZrC/ofEHcCBfQIlEDlI3rp5MJX+U1pozy2zR1ETtStI74gR4ya4pbz2n/bACs4Tg/xCWezzVOxXJutm8DpD7dkgC7+1oHIaVp+rLpcyb8SOESHZTN3liewseXRisQ+m5Q3Uh7lPjHSQAO3TTBS9OHwcQv+3wzE0eDa6d6JtWNlmrGVAJ90GG7Wh5yHnvY639/5rQ71TXT1jJOMlUMXgHL1M19Ieo5cspPK5Iwd9KuEaNtILxA1sLC3KWzOcGyySfd+swqMQb3pgZGyZP5PlmXcDXxXVtahw/vkYSVCg+69IxmWMQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbd4275-c3eb-4522-5334-08dec067ce25
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:40.5696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pODJ0x26VJ/4UaiA8QjxUhrKmyxpo0r/GZUxb1bGQNdOOo6/T6BeGQEjdYKqpCjkn7R8N4I4fVGLilGgwdvA1uJbAuJJMiUJali54vY3Y+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB9190
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

Instantiate and realize the watchdog models for the AST1040 SoC.=0A=
=0A=
The AST1040 watchdog controller is compatible with the AST2700 watchdog=0A=
controller, so reuse the existing AST2700 watchdog model.=0A=
=0A=
Configure the AST1040 SoC with 8 watchdog instances and map them to=0A=
their corresponding MMIO regions. The first watchdog controller (WDT0) is=
=0A=
located at 0x74c37000, with subsequent watchdogs placed according to the=0A=
controller register space size.=0A=
=0A=
Each watchdog is linked to the SCU device before realization to provide the=
=0A=
required reset and system control interactions.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 19 +++++++++++++++++++=0A=
 1 file changed, 19 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 6d1cb9b102..57ffc0807a 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -119,6 +119,11 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     }=0A=
     object_initialize_child(obj, "i2c", &s->i2c, TYPE_ASPEED_1040_I2C);=0A=
 =0A=
+    for (i =3D 0; i < sc->wdts_num; i++) {=0A=
+        object_initialize_child(obj, "wdt[*]", &s->wdt[i],=0A=
+                                "aspeed.wdt-ast2700");=0A=
+    }=0A=
+=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -249,6 +254,19 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);=0A=
     }=0A=
 =0A=
+    /* Watch dog */=0A=
+    for (i =3D 0; i < sc->wdts_num; i++) {=0A=
+        AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
+        hwaddr wdt_offset =3D sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize=
;=0A=
+=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+                                 &error_abort);=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offs=
et);=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
@@ -290,6 +308,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
     sc->uarts_num       =3D 13;=0A=
     sc->sgpio_num       =3D 2;=0A=
+    sc->wdts_num        =3D 8;=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
-- =0A=
2.43.0=0A=

