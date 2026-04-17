Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB12F8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtI-0002Nq-BN; Thu, 16 Apr 2026 23:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtF-0002Lm-9M; Thu, 16 Apr 2026 23:29:09 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtD-0005tG-Py; Thu, 16 Apr 2026 23:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUtsgsOVHpRguLzdoSDR/htsz7/rKFavPnp0Yzd47LpYf3nEt6ml+dcmRI82UBb+4m//3NBnZbuZMLa/9WytVQF/Ye4XA5/9bVlRTy5B5kKR/8Re2i0T/EFSSFVg7ukJOssb/6VS6bC1UarPqKQ3ydhtfmGJbqdMZU1NXKy7m/De92rcUA9F/+L56n0sZTQRxOc2qXBPgWswUFkolQY4UKjtar5v/fKfzH9UUsKF5Wm30pt3k4p2+/xgE0/Ij8SJYohhAnIZcSEcmbzSn1n2d8OmOg/9ebsAGKgwYjYKE6HFrgZ+fPvkziey8mVEQ86qFzsbLhYEZUneg2IuvHJBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wlXeN6Bi3kpAISo1jmWzKojIm70NqKVO5G9u76HCh4=;
 b=BAXWJrC67yQeTK4efYjDaHQzlMCkCKg86OMiEDwO384W+FbJ4fMn5lp84Keg3i6msq613jHyen7p2Sb1ftqCElax3/wTXyz40RMBq84zRCPnYud6tYWNVTDwwPAFPor/4U5ger7avHRBH7455vLLnBU5U2JeETPlsQtIWmDqhFl/VQIQv+VgPo/HDN2wecKK39DpaxkuaZWeBN6s8HdbmyzcO1eXQUNq3QgmC5whwMYFfjkeayPjJEcNjRfsC8Cxa9OG31RmoSm4C0X7r4HFutDJSSAp+hY0uliWlvUyNkZb7Il6RSLvcI1EgR3cJh6fk8phfV+VV+9MwpyZgvr7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wlXeN6Bi3kpAISo1jmWzKojIm70NqKVO5G9u76HCh4=;
 b=jt3EsLC0bembZvuqAL5olBiwjaddpbvK/XSPjMDkuAntEavqlCSTYvft5kTCtyMdeqsfpU5LzDQv7vHZpY3L6i7aN6vkUzi6v9XPTBvj4qySrkxswqvbmpZSN0L5apiDAw+9/l1zmvzt3rA1I+aVunMl7Pky3bUmcrH8sXQGdl7362xGE+eVCAFz9cTEKn3AnqxmyqCt/tKkIb3viCdBgL/fCg9FW5HobHrE74CUy/CCJ7cOzxWi28CjJXa5yAFrKb6gOnhEAN72diDOZ4/ZrSOAzKmtfF9/SbaoEyK7sTnoUB+Vps5yaLKAgCaOcf8+p3/K1XW7rfl4Hn1r1nq/4w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8076.apcprd06.prod.outlook.com (2603:1096:d10:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:29:00 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 16/21] hw/misc/aspeed_scu: Drop noisy unhandled read logs
 for AST2700 SCU/SCUIO
Thread-Topic: [PATCH v4 16/21] hw/misc/aspeed_scu: Drop noisy unhandled read
 logs for AST2700 SCU/SCUIO
Thread-Index: AQHczhpU3cM9Z9mdvkCBPFNuzI8AJQ==
Date: Fri, 17 Apr 2026 03:28:59 +0000
Message-ID: <20260417032837.2664122-17-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8076:EE_
x-ms-office365-filtering-correlation-id: 3a2a35cf-4bcc-4b74-4579-08de9c31771b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: BZG8YKovnEIHJvJpKAmml3OLOHlqcEHuVLJtiaynoR0lMPo+/w9ZGBgLnq4RhrZI5t1E91LxLL4IgdHg+ypBriw3rcMXV0WjM3pFuUqdcPDa3d50TcwCDg3zCEcmP0EBZb80lRckAbS137tQdetlnycxk7evNWiQLqErL2OVAxKUhUYzM7Y1kuHDtT0wWMWndUFKe2CPm5fHQLaNjcVLIt+51TNBb5ZETtvQGYwtbvuLK7XRvEvnS8hjFGTRejkGKNiD41VoUtvfCrKWcQh3R/y/cBv1Ln6F52vC3ouCWfbjuK7psEwkb9GiGJZce8lMMreRd3vjLWwrH4pHu8fU+LqM0AhIhEgcmMqPCmz1KCG538aLuulIMWx6BXDPr1/qMh63MDyFaQ5rA+kU2rpiNTUFQsxBtHxxeTl/VeCG8D0fXBTeCEwEZ48nuqWyH7hPgnzyBAwhmHt8lr14TriDf9vi+dBXLs8x4WG3V3qB0vXdQHZE4eSzdazNAAnMn8Mt3uElR+xY8pNPZRziqoUEYXgUClNU/GRrOwWvpjxIxakro7u3Uy5wbaCI0TlWYOTNPxFYqrxacizTTAJvXV6wrsFsbTKEJzw4rYjkfu58hTVSJBwy65pP9kGt7/BsKzO0SMgX8Au1SXzEckn9geAHRu+/tPtyQZV4YVd3u4Ap7o2j2ha6fI92/iLSEL1eitl4p6C9fTVrtZg7j4rzzYonSe0nD9dHdjvZretWgF0yGBXi/E7Ucl9CvsuosYJlhgCjOjsv9T4LUWyQKh5P5vzFTRdfwuhMBidjXEYTkPPFynY6jI/zLye7ftsU4TJpyMcM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?trZ5FJRYliOKknH2L9QnB/O++e1QdbIe8IloUQHmoprvs7tUZhQIYBXwke?=
 =?iso-8859-1?Q?+thonGJjfgvuxvmbKeIuxNlBEQ2ODNpBAqHFB3y/Gizr93ELLUyc8T3rf+?=
 =?iso-8859-1?Q?0Su11pfaqAcbo4kcHtaxN7+Hawf6Yu7WDH2lLDNyezBBmiW++SA3gJRGqt?=
 =?iso-8859-1?Q?q3gUq0/GR2Q+o7HhWjFJ/CauW9H/pe/mk3AXjjGfgirfTqfarCV+W2u9lW?=
 =?iso-8859-1?Q?mwHDm0eXumN2sVY0YqHXSl5K/xKQjPuvhzfYQia1iLDFg6AKwVedpPut6n?=
 =?iso-8859-1?Q?cWmlf0DdYX9rm2WSkNEIavKbYOWI+CD3RFo/NYcyCMS8tXYBiSjav0wgdy?=
 =?iso-8859-1?Q?k+1ZjtT+h2rRyifEd6ZR0z30GQ2HkHg1CpYrULHgsO8T6wqG089d2LgRDg?=
 =?iso-8859-1?Q?4jK62GSLS4N2rBCZWKd/IQI089euWRjB/a21xGy7NrxNJDKlc4KXJ1nrgh?=
 =?iso-8859-1?Q?IW+zFwe9hLN/HyfoG5DHtT1h9+yXf63j9npJPJFnMS0k5OpkDLCkRN8KaZ?=
 =?iso-8859-1?Q?TFc10e8WJCgy9nh8lB1jWS8eQEqC5PSXjThxRQ2Tpsv/oZ4xcgGtAZ2ksW?=
 =?iso-8859-1?Q?+sWZckI/Cop5VAC9qCN+n+t1BJblD6Y1jpR4aVmCcyc3mL9y4k7q/WjHIo?=
 =?iso-8859-1?Q?VxtTsNzNRrYBxiyTvqca6EX+E1kj4M82SC+37wUauhR2//xblpigex+Hkf?=
 =?iso-8859-1?Q?P74BksAc1O5fzIv4hsMymSH46A4SzRhujh7l6P32pY3PSW3NHMEyK4+Kw9?=
 =?iso-8859-1?Q?DaCohEWxsOS4otI1HEn+tcW3Qswmg+qd5ZMch5TfPiv0JAxN78FNghXI2v?=
 =?iso-8859-1?Q?9HTOesaT0x+DdO7fWwuRjkotBNEYZEBlUXnxxc1bWwu5FNvkTb/MBMPD8q?=
 =?iso-8859-1?Q?0EWgCWcEHY95sWgdf8E3GAnmr4SfX9R6NqYQDgGovZDjuMOAtAtIHd5Kg4?=
 =?iso-8859-1?Q?MiYsPc9Swwdx7l3gVC970Islk4RgcyLXVQ16BotaeBM25u11CY4ux0IRAf?=
 =?iso-8859-1?Q?+u8hf0kDtQaQ4qVUWM28cXgSyqK4NWJQiGIHZLz0iNYX+2irBdP14jjwZn?=
 =?iso-8859-1?Q?bzF2SCaq8y/wqF3qBgmT1gr0c2dLNXh4K2df0vHEBBGByJqPNUqm/GFltB?=
 =?iso-8859-1?Q?m+uf6d9bLnhlY8/HqRNVAig5/fK9xlam5GNM/Jq+CaVhka9iMOcTR9gAZV?=
 =?iso-8859-1?Q?ZV7bFB9zVFVz6EAS1206nOEL7+j0ZwYw6KHvPqY3bmj3VBlsEc6JX9NOJl?=
 =?iso-8859-1?Q?tiA9MTtopgxN3m7IPoOBKiktNacJaT2gq7vbjMBcTTCO4d3kKMYNM4K33d?=
 =?iso-8859-1?Q?VK5an+RfJ1SzzEjfoGtNkuXbIu+G7khMnabvdkolNbutq8jrXHQ0CLI8Mu?=
 =?iso-8859-1?Q?+b0UxGDILtUKfiT1dvUBjHlY4VH9v6pb2LZnuqJRjGsY/5NwKyU2NZwNve?=
 =?iso-8859-1?Q?9DcxpdsiSZMplghH0fW7RLxmJUw8DVfs7mQykW2PoolQUq1Wq/QAv/PwUw?=
 =?iso-8859-1?Q?QSvqLvI0N4ZRRtnrEUo3UpdB8l20e3UvfS6VYvf5edF5xyfWaRbOKRC7mL?=
 =?iso-8859-1?Q?xfGG42tOHpb2Za0lOK+ANzbGEnfNnoSaEwYUcol7MfsWt8YKanU/aYQRIW?=
 =?iso-8859-1?Q?3Vl1nTa3bH7yzqb4Tm1QlEwaGskoyIhvDRbRtQSjX/LMOUlXQ6YdwF7NC1?=
 =?iso-8859-1?Q?2JMYuFhhOd8SATG7UO3+5j8IRQ4MKhi9KAFB73ZyGP7gsnxvYm2d8FprEX?=
 =?iso-8859-1?Q?VAJbG/rgiLdFAMuhw1K8Hi0EFD0SLcbjBTfXIzxKhr2z7Bb4c1qkP1Ubw2?=
 =?iso-8859-1?Q?WADJ7VxPHA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a3lIsQ3+cHaI3GgKfVylL0x75e31uWEpOogKEH9V4XZjlNYg0alBOq2QJrDSBTI3KdAqD93RSmpMa51A1xjxzaYii4YDI+yISTZwXudCVaS/MOPvLyOIVfhxNvJztEi1oew7moGztv9guInryfIjRGFldvKG0++9HSuNLxwEvyFZ1I9C0y4hoSacRtuWn9PbTnxd/iEJf0e80v+jcUxKTGPUZhCB2TSGoBIAwYJFVG33k41xIuLYSlL2LuQNUGpOZWDuShmYheHhVtbj2/v/z8jWNqGOzncO4d6V8jZSfOuSHgDlGWgNOyCuPqyElFkHNqSeLmdZBM9VEy0hmMazFQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2a35cf-4bcc-4b74-4579-08de9c31771b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:59.8530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVwHjCVXn7U4Whc9S6bSE91WTUcDIFRTKZ2AwrmGRHP8v8FHLXm4PteEyivbg5hO5xaKJmT7+/cMJ3csAaFRUB24nokte3WKxbuxO7XoRPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8076
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
---=0A=
 hw/misc/aspeed_scu.c | 14 --------------=0A=
 1 file changed, 14 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 251c23def0..362733ba11 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -932,13 +932,6 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, =
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
@@ -1264,13 +1257,6 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaq=
ue, hwaddr offset,=0A=
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

