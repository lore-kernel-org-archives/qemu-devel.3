Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69129CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcnS-0003iE-Tj; Wed, 03 Jun 2026 00:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcme-0003TW-K9; Wed, 03 Jun 2026 00:00:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmb-0002QB-F7; Wed, 03 Jun 2026 00:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcprCOj3k+oWKC96apFVD5bsPs01JGHN1fN5JPjbQadq2UGpVnjaZCZLMRNbPzZ4ReNc3+4ZFwHuhAGM66Tdpz3e5e/wOyzCQRzkP/a3hH7aYxBsTGWxHlKYtClTQ6oDKbxTVx0zu7Xxa4VDvc9+dqc7xIKQMOo9UURFCGXmaDXPY/16LikeTyoP5DOW6HpN30uf1xacw87gBbVYWUO+9WM5a3XVomvtIN/TG+J7UUEIlah+uyXVlp+LFrtN5bzcnZC9KqzjZypSb0MaBFTg2fKqqbPmLinCpA0RWqARHhCFtkCLAG2zbUCZ1g4bK6c9uVQRUbuJUNL2pivFReWEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrTG8zd2buClBhqaHE/pk14970IbTzF4v20Qqgtdp24=;
 b=nsSt1IOWS2N8skFyWNOlqZk7zw26vnKWlYkgyelpHtOO7zPxoPKcollnx7ePtXDfTRipBKoIBXRhJCDKbYTcA+D1ur6l81b32gAJYFP4/70TpYZ5A1gj4GtZM/5JVuLxhT18UI3Xt0vbn9imfqkB9bxMiy62YVd5MH8ezYddkYSsoCWAXlP7pNCOSO23OI53ZUS0wCWyHCrvwThS4yqoR9zHqVG1flh9YSXrqu7QtBzg3U3YlGFYwQ82dChrLWWO1jAtu114b1W6rBhYzUO+uV6t1kWKrGFRIjdejP8iuQfja+8l3PaEg638mDEdSJjH9FAqgJiuXo7/LbzET2LgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrTG8zd2buClBhqaHE/pk14970IbTzF4v20Qqgtdp24=;
 b=SISJEzIBzaIwL7jC08nWYSlXqGX8ezsS8MTnpQ1BVttjbo5Zwd0rsWKd2LpIbjMJJ0AN/1e+h51zzi4DsEXOJ+E0theT6/0KZhskUY7stRFPOhSaZMBR4+G5LZquX1QHG433/IMJTkI6hsqALt3kN2Ush6IK9LqGyw6us9vMfgOyAUr+fhTRv+tE+p0Tw5P5j1U77hSviCbxXinw52G3lTeqo+zeVqp7+uKzBe6ccF8faeSz22q5LhowcyV6Tg82/YZHxClw78gzRggEL1VkC4hxx669h5t7I0jyoIdqfjtMT534yArxjutmuYybyitSNZEv9HEJzJLuPRdDoDxQfg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:32 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 03/10] hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
Thread-Topic: [PATCH v3 03/10] hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
Thread-Index: AQHc8w2F2AgyEN45eUGf5gJEVovVCg==
Date: Wed, 3 Jun 2026 04:00:32 +0000
Message-ID: <20260603040027.938816-4-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6921:EE_
x-ms-office365-filtering-correlation-id: 0bdb3764-cc1c-45e2-2a7c-08dec124a86e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|6133799003|18002099003|56012099006;
x-microsoft-antispam-message-info: rZWIiFwVEYzsD6jCV1EeLp1DntWyl1J6udS2T5O+2TeVWMaFxBuxQbiyFh3v84m0GvFn3XU+6X/xHsAxcBTqe1YKUv8QEjVl4MtL9i3xcrZmqfuiGV4Il1Id5ekeqqn7zJ7BsaAEpl4TH4PZLDsW/Mdmsyj1oI0LAIJeAc0GoFPq33jkxU+2A1GxptZcPXCffz6PqCIWxmt9fN9tCTfSsP095jgDv0KDz9lOxRrFsPEXVEpiiL7CwDW9NYmBbR0kL/AiDKS58OaDtJD1fcqnq//g8nZg9fukHKL+c/xJVRX/D0EeuU1K29jDQS9HxXDtSt4AJ02Ap3A2XuPY7cVUUfppcRlFS4ZDABLK7uDdWnFqXH1KoWQnMxyjf8ZeXd0qpmXFiCGnpAHoLPr2gqkywnNX3wxROMznqfjWdB3lm/9zBkesWrghNLjvtgVB5zpFWjhhe1VNT1JHBoDlvEMxjecvzm9KcIs+dD+Lj87AeYFcqJhM2IDcPbTNu0SdDMsjk1Ay8qWW77uJOEOV8yuuiLKpjGRRKDre1Z9//o4dJPTnY3rU0q/OPlztEvpG/zNd5cJXaXNZEiHHkIGcGCJYECJAwejjSl7k6m4mPgFfMwWw58LJv1ukneXtxe8KeDDGnHTFfJt8nN/snoqOdTSC0P3g0FCnQ5SF+PmWDQWPp5/gYzprHDwsRHw5mwHUwvf3CUZnXerBEfzxeottex/dxY1KOENHC91CCtqiUEpk8/dEFflRTNvyVzn78SPsv+CV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GuSqxe8oXqbIttOCQqTRVzhYQZrwomQhyON8mSFCAjN3MLqNFmq55IeZXm?=
 =?iso-8859-1?Q?du/xfcHL7mEjOp9/RaAQK2EBPCPl/UXtmPkAXIrMof2u9uAMUZYg/a5H5u?=
 =?iso-8859-1?Q?Ui0/ghUt3CT43/5VilxbK5/HFkBRQ0UQmT6lsfEliXRBGIMAjbLjr78NEN?=
 =?iso-8859-1?Q?FemUEVSJj0hsYFt8rnQLAU/VgP2r7LKNaPFr6Y0aVriLfMui/gqLnIMtsO?=
 =?iso-8859-1?Q?sZAzZqvgc9GrsEWR1LUgxKGV2PfR0e3sWFqVIYP8+GrebXLnAsKDLdkpfe?=
 =?iso-8859-1?Q?p3n1KUcrvIjTZnjIvnPZ36SwBc3nZGFRrk3UptbQUpFniIOpozT0dRKnRm?=
 =?iso-8859-1?Q?XVlIw3G8e0PDmVvnLj+6DHRIJHpdRZWt3IKM4T5ntbIT9D44w/ih5xlrcY?=
 =?iso-8859-1?Q?YsZJnyas6sCv397whPJ6seC/yCrPTRHAMy++1jU8gxPf5HHK4RboGNFv9s?=
 =?iso-8859-1?Q?g3ffm7t8ufDQbYvyqclfNut/RJO8RU0aabL9I8SwkToZsQt4zVO+drgA6/?=
 =?iso-8859-1?Q?KAI+xyBjvJaeQETlM/H7sXIpL6KsDckyRcjk34mj1cqqI/g0wk6KFC59Ko?=
 =?iso-8859-1?Q?IVqOHq3WUWiRjBNL2WMk85/Fl0RoQMCSGjOabo4i4PuDeWiiVjnGqsWHzY?=
 =?iso-8859-1?Q?rGKkPEKm8DHWAr8XfIEjJaahz7Ftye8kAQARcTGS50pfV2em+QGUQ79HEx?=
 =?iso-8859-1?Q?GqKjChwdKHzY/b6zKQbt1qpLbDCSlTtVJSHLkErOLh/ikg3gVEdBl9VkmY?=
 =?iso-8859-1?Q?/8gJHA89S1D+WmtxuOJs3cwYA5lzJA+TapfCr3vDMTOABajIeh4rjLsxSs?=
 =?iso-8859-1?Q?5D3ip/YkFseB0an0YvyQdepQ9lUEp0Efb7qY5kQJb65bgAfiv2rApArUqm?=
 =?iso-8859-1?Q?unXKoVaSIvg+GqafYKPxt8jYBEZKMCzbL5GpJohfXGaB5UmzHNE/YJQpvh?=
 =?iso-8859-1?Q?lasYlj7zoNeDtdGH7KgdG4ntAxvTL33Te1rTFM70K3eYGUh+7NRfHntQuX?=
 =?iso-8859-1?Q?SSJs7SpYhedJDt2NON/l4iWkufaOH4mJqhAjaSKb0Lr1k4Z66EXTSTGWtS?=
 =?iso-8859-1?Q?JL1GaCCRRd/SfrIYAMJ/WyzpLb3tMPz8fa0OZFtd6CPDVe0WwJDqd5N4T3?=
 =?iso-8859-1?Q?Dk7KwOGKs6BTVKOcaksm7GHq77oHF2XkjrJiOkfTp43BR3VZRS2a+l/tNl?=
 =?iso-8859-1?Q?/KwiKkeRBDaSQIHd0zVYeYzQLzvK9YPjZYtT4e9bLzzU/4K1J+KXcBZWqK?=
 =?iso-8859-1?Q?qgS2nDtk8CyFsJvcuB22XKU7HqA02XnHVhYFeT1iLRokFiQouk+fOuefOw?=
 =?iso-8859-1?Q?Kx8tZVkCq05vPXq9CtPJzORcmFCLQxaNd0takIav1jYLPKkZofft1TxvZk?=
 =?iso-8859-1?Q?YpgSAJBCXVhkQ+46SjuNQvek8qJo2DCbgYPOZhLE2v6okxUdpC9q7JXxEs?=
 =?iso-8859-1?Q?5wExILcBHkqKDQLfvjBj+UK3sDQQCc74mK2IximPAd9KcfFeW+qVVTLmEU?=
 =?iso-8859-1?Q?0zSHl+qN8RJ6UjvPK1icxZx68Jt2uuZYxzF45XTI68R+lIWDf9PEv1uPfp?=
 =?iso-8859-1?Q?LzfWxtxDzeE1Bl2F+yOO9M8RAngw3cwcPdimG7+AK0MPmBbImkWk1TlMYP?=
 =?iso-8859-1?Q?19bBHKT5f9sbo6Cs/zwnrr+gA0jv3l9ZbUzKlsV736+MhONJSV6anJ4VRb?=
 =?iso-8859-1?Q?XgUEeIqcbWhiIEDQabGCNhaYExhTOig+KnaV7CaeX/Zq3zuZagMhaMilSI?=
 =?iso-8859-1?Q?BF/3ZHyfZvmBT8VZ5nZQPypmVBnAUHZgxJ4diGsPkFBTkD9/GpasRKzn7R?=
 =?iso-8859-1?Q?yKovsE7RBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rDIr8TNMTXvFIRx08cpaF0we6XYTRWKpktY+lalgCZR7ngoT8GHMKhLNisQ6tmiQyEK9vV/irZNKFwcuxx9g4FMo5sGEf2LMMwizZBZpGrRVUJEhsSuhSxfuf+EY8UQiqKm1Va4cFKl8vZtkEBeAVTBtVfawTyscrrh6T4FdJXyW8RRF6skz3r4T70RRkB1ziE+NQJtzJ6KxE91VuoQLphXo2oFH8okjOtgSxC4H2z8h7LGRA9E2FoDpv54Qxv8C9nSeapvedUysY8V7zWlEeFK1UfcgQJ8hMG9OxjJMEQ77RON6BsLgZkoRMb9juOKc9+EFD/qIoD5OQY0HAYP7gQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb3764-cc1c-45e2-2a7c-08dec124a86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:32.1561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+GklzLIYft6ZHSx/rb8/gNF8ZbFyt1PInFtXKhmeRYCiMwL0AOFRq3O+Nlod4yP6TMudEhSIt9h+vxADRdwRxVRZnyNoMyALKvWwrAp2Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6921
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

Instead of introducing a dedicated TYPE_ASPEED_1040_ADC model,=0A=
initialize the existing AST2700 ADC device directly for AST1040.=0A=
This avoids unnecessary duplication and keeps the codebase simpler=0A=
and easier to maintain.=0A=
=0A=
Add ADC device initialization and realization support to the=0A=
AST1040 SoC model using TYPE_ASPEED_2700_ADC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 11 +++++++++++=0A=
 1 file changed, 11 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 8efcdad8f6..b736e690e5 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -107,6 +107,8 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_M=
M);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
+=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -188,6 +190,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                            aspeed_soc_ast1040_get_irq(s, uart));=0A=
     }=0A=
 =0A=
+    /* ADC */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_ADC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

