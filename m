Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8112AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbre-0003IH-MA; Mon, 06 Jul 2026 01:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrT-0003Gv-Ly; Mon, 06 Jul 2026 01:27:19 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrS-0007PL-3Q; Mon, 06 Jul 2026 01:27:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvwSBE+2mspX8DG79kL2XwbzTjmhKO1qIrjslvuQD95GChlmka68VfTUfjG3QURsNVq4IX1OgQ+mbvjCLOB8x+ZlY4AHcktQ0AUWR0KZHMKo0w3Y+CcF/JwNwcCsuzf2hPf7HzVa9lkYWkiF6id05FF0IaebVpI5szJ+R0A9XuEUVjLcZT/SfZjW1/nkknqCiPimRObzDj4wNt+tl3V9upzltpc5toBu/NcEY3pPMzH1X1/39vt4B3ViTQyNmNrGSdc3yt13uCyr+IOC6w8p71M7QvENJ3gfKp+F+O8jQqz7lpSX1DkNzDDfzuKbaavDOTePQX4xZJO9+nwx6dfRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAqxNnMXm35AdjmABG9q2/VzsJXdR6rfpZPdpg0LM0Y=;
 b=qJmQVmoCJN8bMvOkhXb7Xv7A40bf9bToMdXU0D6u+ukIAe+F6jDa76lsMqWlY2AWHs8YYF7nt+uSNCRzM6ks/wI7Vsjr4PRVBJOnm3qQaPCOK2OADGd0Ya35PsQ/9SRxb8GVg0bKWP3y9iV9Z5CwYEGqpg2Ixm0HwdLA/kswLw5B1HDNBbwj4da62HdwKjxo922J9bsCQPXk/bPuxSU4/sg6iHGbGDTsgAF9415MAiA5IqHZr/N5Ap5dPnpjdmYM7QXvUxe+6qATFuzhsHejr+LF0CIkab+tiI/lZ5mfBUkeMPmY45dcallY/sYI0z3PqRqXWKmsMhuyidqoroVmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAqxNnMXm35AdjmABG9q2/VzsJXdR6rfpZPdpg0LM0Y=;
 b=JM5qqNwKecq7XFiibz2L6OHmdZqqQ+7KtTCUKl9ParUUMEgDSL98GjP2KLX6Xk6Kg60GMjOa66bjZ11GBLuAzN1bkMFACTQa/5wmgg2u0D5NzOt7FC+FNjeTjkMh6GwfVarHrO30pCTsHdS9KwW2ymuik8rhykLgYGtd+8w+O/AMd/aDu8IZ/UzQ1g73q2Jrktw144cwucutBCvBps9DCKckSgvmmTKn2JAEIHlt1hgWYYZeo/FhLUwRR/WMfooRxWp4cl/FV7Lsubgt9D8JnwPeH8BcdRtPYeX3D/DJj9I1dZKrhhWmCwlhofL07riZSTSTombal7K709OBjFo6/Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 05:27:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:27:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 2/5] hw/misc/aspeed_scu: Drop noisy unhandled read logs for
 AST2700 SCU/SCUIO
Thread-Topic: [PATCH v2 2/5] hw/misc/aspeed_scu: Drop noisy unhandled read
 logs for AST2700 SCU/SCUIO
Thread-Index: AQHdDQgU8xetfL9AZ0u01hvZsrfrSQ==
Date: Mon, 6 Jul 2026 05:27:04 +0000
Message-ID: <20260706052701.1141740-3-jamin_lin@aspeedtech.com>
References: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: de4a74d1-2295-4e23-11d9-08dedb1f3709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: i4JW4G7yNARfxyB+twI1ZF6r/ghn/YWOp7SdSXfd8n8a/c984XMJOibnCORJbU2P9W/+ZPn/6IvsFPlGSabttkpghmiATIMPrHOlF+77hnzbIYTZz7DM9yJ40mz4c+UKq0E/8BXx1q018rAt2N8x0ftq/ILY2tMUFvAtGI1WwUh7HI0hWxVKwZ3oWNmDxWkhdO88cHDuiP25CYjyeunN/Yy4D7arUIpPk/eibv2u9fjL5Be45CUtm2zEd5nnIzzypbczmJ409UyRUUtzMdjdM6lj3MK277snEgRm+8WYjDZmDBnws29Dq6E7gT0grulkhLonPDY/It07h4IcPKPcvkh6N3T4i4N120i8HPHUPYnjyj+McHFUPk7fYZ5H6HGCBiNUGbFTE+gRAMKYRcq2xfVwoC5P1oN9VQNsJLKe75MylavyXedBTgj3N51n4QyAIvwYy3PScgtp1WluM9nbpR3vr45vKwPNV9uD8MjHvapSKpgtq0hsnGKBDaJfAph9ukcY1EIDdQcR39kGdY6T9L6PhRd/XI6VsCuB3OeLbGdpZBaMaLlhyPNuaU+NdJrRdHTser4uBIOWgYJy2gVstuiXldd0j9n72HQbTeVOKKZZjPW7yo6BUtQcWoAtbkIl9zvwYOq2tGtg/6+mD4uAjq//+NK991uvRdvvafdQ666b5TxvkjBRtPozEpGVIjaK0DfvWBvho3hmaUARtbY0AM8vsz6B5aQauRYKwNzvb3U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n0X8HSR1cO7tEALW1vU+iK6O20Ore03TQptHgRyMc7SkH9I9FIT94wHJ3E?=
 =?iso-8859-1?Q?uwh5rge/TMS83BZChtpN1KWZtuFFaa1gUHGOIpC5Wmi6fyvS7SF7HgYVeK?=
 =?iso-8859-1?Q?3ejlDOGfZ9B9ztkPyNRs39wRBUI+eHmPZ3Se6UrXAZdXClJRfiNw9uK91w?=
 =?iso-8859-1?Q?QRgGJfcm7iypICWK6D8NJMjv21F/SinXiER9M8uVbvM3LCA9g4pnG/9cS5?=
 =?iso-8859-1?Q?P5j65JafEY8detQkiq3+9IQJQZlSezvtNnTzkBP23VOy8YDTqw4ONtBLMu?=
 =?iso-8859-1?Q?ef4J6/PZFeVq+XlSdn/9NqICGjJ1GVAw7Uak/EFM6MRb9wRzfW6HfhwWq6?=
 =?iso-8859-1?Q?bHQVjNtM8f0MOILPCLNjDrPix4Lu5kP6e6J0a+Zww0xY2XKFc6f6Z3QBbq?=
 =?iso-8859-1?Q?QTO1WexrcybSIvt6SkaJ1IUDf5ulT8orT5SaycumauqL5iYoqmeL+LJnxw?=
 =?iso-8859-1?Q?UIOub3fqcO0KjZoHieu/r8D0CywJixsji357/HqCR4lhJ70V845rDtFWZI?=
 =?iso-8859-1?Q?eNzd8aw3MUBYt467vu16dgyZZHw7JoCX8CbZ913o8iW8csUxayp4udxw81?=
 =?iso-8859-1?Q?vyp6Rr/K8i9n+iU7kgiASbT5f4rA7ib1skoBBv7Tlvd5XEqvyqX2RT9i4U?=
 =?iso-8859-1?Q?CP2G2p4BzfgZgHPdX5gVt7ioTgrsHi9Y1T3/JXqKbObCaH2NChyL/yr0U2?=
 =?iso-8859-1?Q?uvjJ3mVaj7dDfU4nIkuKNmexCUHWj/8hx13UdhZnvz/qbEa59G5ztJHnQ9?=
 =?iso-8859-1?Q?caHHeHsuShiq2e/Hqvh21qdSvyaYhWwO2g0FbiQuMqoKVD5qESqUIez5uy?=
 =?iso-8859-1?Q?nz9q5JAjvosP68C8J2EST8oVLrAvvlZXWmFtOPhDyxH0V0GTa9NIZPPWg7?=
 =?iso-8859-1?Q?bfFNe8C2HH4qgDoKUhJcp2NnoyYK5mG4f7XHOkKps4uK9puDP4YEY25riL?=
 =?iso-8859-1?Q?apYTsIbw9zbx+8P0NF6xGJfC4vk6VbDZZpwlD5oY0/U3Tf22dY0cOGqGhn?=
 =?iso-8859-1?Q?G/tRI1aeQ5TtgvrJWk3/DZ+FmrZFzESyF5ZqgMJ9tQmrfY2kT6ptV68hlN?=
 =?iso-8859-1?Q?o+LubDeMbCXn9nQEGYzOPii7X3FzcLVkATGp2AvraOYlEhtbXzhufPqDH9?=
 =?iso-8859-1?Q?DsqilFlSZKDmyPl/2qXn6cLvo9k6ZZ6IfhmE0XFoNofXNEAsL2srMb6ElU?=
 =?iso-8859-1?Q?kZrlYn8AK183zYbSADWsNiT8iFnV5rcjn/6HybnJOwbyNkxjUA+9L2BqSk?=
 =?iso-8859-1?Q?8SakRmZadr4rHxsD6bgzCIR8i3BZPgHt0m1RX+4XYAegkOKIwlPb7VlKDD?=
 =?iso-8859-1?Q?W2zvfbE9RLxAUz69kMUjl0xpvI+X03rl6Fqmc5k1NqTrbDAKJcvXbXuTHt?=
 =?iso-8859-1?Q?QNfkN+HaoCfXRvA0JcmioZvirvFxfZGvLxCjYgoWqxPQ0XFCwA5DZUF/kI?=
 =?iso-8859-1?Q?Ml7cdLYc/HEm2fUFOaFDtwG/adfZ3xmLqBJZenbmGXqNT3yD98I8s/S1B4?=
 =?iso-8859-1?Q?k+EH3NnG6lqWSN1DWsQXYdQV8LkTz6ntK/lc1j0vxZYs6iIrAvT5z3hNyb?=
 =?iso-8859-1?Q?jZDjaM+NFd571FWQT3RC5inbZi2vrLn6u1++4Llu1pWwMlSoiMCkcuE3gA?=
 =?iso-8859-1?Q?kWxFeOkjBMPYrz/diTTzTPUaFGnvt9/f71g+v3ySr6DVAI53W/y5qFEB+j?=
 =?iso-8859-1?Q?cGUPlSDvK5WQjXAnBuz3CaaChdYnx8rpMIfKEnYIBfHiBQqU3iBWmfxFY6?=
 =?iso-8859-1?Q?iTR+ySiXSNw4HGzMLkMG2kOLiWTSuSPPKpJ6uwFNO98iOylPYecMiY+Q5q?=
 =?iso-8859-1?Q?1b7GxuZ3Ng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mTLOrRHNtQsobOiKIq14tE5ZwRaLpzxl3+t8kukxSEcJLKIuQobg3efJGHrt0IsaxwSLaPFwkt2eVj3Eucn57h74iWy1fIZ3BNXa5Rl/IV1i21LZXuJq6QG4pdKpqJvcBu8OBMbUX9IHyF7bPbJNv6ZdzJ+H/kM0qKXL/LyaDli34h5OPEJvMMIlR09syagYKWUxWuWr8Uoms6+KXnUF8Hlnads12ZOB1rent42gKfPPRJJt1YPqegjHMxAllPEQhvvKA1IJ+mcdbwEHObv/KqejS3uIla6QsikIXrC7JnQ1AE8pYGotvOzmytVNpYn9nL7m3lN02pDELf27iiQltA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4a74d1-2295-4e23-11d9-08dedb1f3709
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:27:04.6791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwN9X3IqCuAYyGSnCs6OwWuxxPXXnB6a0e1GTelfht4+HZGQ7RbmrGYW2WFYu7c+ox/x4vxlpCMm7V3/oJWrfx5y5Yy9fKA4LigZKEhI/Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
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

The AST2700 SCU/SCUIO read handlers currently emit LOG_GUEST_ERROR=0A=
messages for all registers that are not explicitly handled.=0A=
=0A=
However, most SCU registers are simple read-back registers without=0A=
side effects, and do not require explicit handling in the read path.=0A=
Returning the stored register value is sufficient.=0A=
=0A=
Emitting "Unhandled read" logs for these cases generates excessive=0A=
and misleading noise during normal guest operation, making it harder=0A=
to spot real issues.=0A=
=0A=
Remove the default unhandled read logging from the SCU and SCUIO read=0A=
handlers to reduce log noise and align with common QEMU device model=0A=
behavior for passive registers.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 14 --------------=0A=
 1 file changed, 14 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index fe731a28bd..ed7f5e648d 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -849,13 +849,6 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, =
hwaddr offset,=0A=
         return 0;=0A=
     }=0A=
 =0A=
-    switch (reg) {=0A=
-    default:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",=
=0A=
-                      __func__, offset);=0A=
-    }=0A=
-=0A=
     trace_aspeed_ast2700_scu_read(offset, size, s->regs[reg]);=0A=
     return s->regs[reg];=0A=
 }=0A=
@@ -961,13 +954,6 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque=
, hwaddr offset,=0A=
         return 0;=0A=
     }=0A=
 =0A=
-    switch (reg) {=0A=
-    default:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",=
=0A=
-                      __func__, offset);=0A=
-    }=0A=
-=0A=
     trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);=0A=
     return s->regs[reg];=0A=
 }=0A=
-- =0A=
2.43.0=0A=

