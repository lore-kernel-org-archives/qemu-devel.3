Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2AAC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYQ-0007JZ-0u; Tue, 11 Aug 2026 02:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYO-0007IP-08; Tue, 11 Aug 2026 02:01:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYK-0002ec-Ie; Tue, 11 Aug 2026 02:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnf5bSVw5YDQ4pIwozKWb23CieiibptZWlVf3pogZpT4TFyRKjV9W+cw2/ReuLbPoz43u+HTmmIqpYaZ9CgAgUGuQ1Bxr5LL6TXPR1wWaNe0MIEMwPTFilwE2u6fgB4+urYno/L9XDJ0PaVHdrQ8kQo0tiJmKzxQiWMYp15X2phik6+C37+zJQviiwFZmi6q3hg4nsgxqgiN1NsdQyizbdUlzmm+6bIHX6yKEiROu3UVuLj+cnoTebAPq0CfpcaedqCO990k2L/vhqSjBlP7ySQLJhLc9eHLP5XeAALLeaAEy68A6O4z+p3RX4ad/oIuu/FVjaWPUInApZmNE/JMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8h4UsQBC6gUpt4QE318t4PM4jeUKWH//yrWHx05m7w=;
 b=yZf5A2DcwtsbIkfFuG4wwkTZTZZUbnLPLIjq8jsgWnjAgUCXJKCQQs7YyZ6QmkakT0drKnB54xwu+SmfhiaNOsHQYpPSrCyVHHQyPMTxYq+izV8wt6XH2haJkaxchd6IOPuHjD+xHdx2YTObnpgxxWyAE61gewkzMn0iKjiSZS/AYdwBGtYcpqbXN4Fk7YPfTDrf9ou4hHUUXRKs8yF4yuvUIXDXWfpj2FIyto4Hw4zAkEQEx+eR+4QId4KOp6WlKZVSZ3C7tCm2DeFtJxjoK0FuESgwmY3xqW3Jpf4MUS+xCNbfx/iwj9X4CpTExE4/P10WE5HACPgowz8GGY5r0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8h4UsQBC6gUpt4QE318t4PM4jeUKWH//yrWHx05m7w=;
 b=aiLb22pnldE1UP9iCRZllJTD7XhQiJtirgwrf6X2Bq7blqFb9dcj0RXKCl7ovpOhbjZ77N+7rGLNV/gEeKfbfL+tmUMeHQEBvlKN+8CTTOXAAM97beKoQxLX17+p26AnPzSibt11siTrqZTPdeR6d7RBAPT14+MWoi1z7hkbqH+cysLY9T9FMiJxveKubVgz5g8Cj+ZVAvSEI6pv4mB0vxmkE/66iDSm9Z410F7jrzbEC0j2jN+9nT5Hg0KVne2bpn6bGUX5yvyhItVnQb96uVALJqoPgUiy/QD+SgtloxFnG+A/uMVsmVczMWTiHUxDvNGAXqRWG7f98ZHaCCCsvw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:18 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 01/16] hw/misc/aspeed_hace: Support the crypto command in
 direct access mode
Thread-Topic: [PATCH v4 01/16] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Index: AQHdKVbTYFeCmjmnFUilh4+MnK6Qjg==
Date: Tue, 11 Aug 2026 06:01:18 +0000
Message-ID: <20260811060115.1849266-2-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF7489084AC:EE_
x-ms-office365-filtering-correlation-id: f1d6592a-5226-484c-b7d2-08def76df5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|3023799007|38070700021|921020;
x-microsoft-antispam-message-info: NffmHqhdUCSt6VtvKrtmsDiDHtFu+lMcl8amTP3Ap40qa2dQdI2hsO0mCxyDF0gNBjJj57UaoZrsWR22ZFhm+Ge9W4fZJkY13GyEZBfSLm7fSTJkUEdeJw4XVnn9ssE3U95lCm/r1ElzyUIJEGOBe/3ohPOk2OLU3Y5Id3C19igqAaX9KXZb1ApKsi61XX+X7tp2iTlWNc+HtxyAhdpqQAA8CflcDv/NFBgoKb1dV8Bb7tsGHsICgWkUQixk6IttJMwFJPjgX8D/WHQRLSc5izUt32l3kgMwsdOnazRVcjxO36YYqGUt5bAKB7DWS+Q4uS4Ypq3e1XtKWYlHMqTy1y1njzTZiew6QopqqQviGZY35wrhSuGxnVQzJS2Wz0sdPXcXHenICgb9KgfBMtLyRdkb1X9MGxhDiM8kLzXMfHGsAlN2Xq13qW9wlBcVyUxmAmKGiPSjHaATdHvfkK/LGAdsgnSb4ITcx40LTXHud1yoyqsYrKPhf+GYZ5cvxTWH6cI2EcGN6+H1b9r6SXiPhER/glPQeuLDm69Em+i+mCrY+neToLIobc6/FXIXVPfElha94lnfZq7a7BDy8u29piSHihdnk2hAqEjS9HEWq5y3eKhu62Ys+DoUkCw8QVg99+T+agO0wWPtMGjTh24J6H6ny1GztkZt4mAYXLAgDz9up6vwEUpmoeYNybpVppII2IyDDRccXTd6bjtQhmQ76creUZFXzyNMVKwcLzj+XdArbkXl2LxKI0YrMblZuQR5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VFWyTHVEBCTmBKTd+SR+yzUFh74kRAXSuu5Z4I9BAYtuZE6Yj+ykvFPpds?=
 =?iso-8859-1?Q?d3wwGH/IW9L4p+C/OWA/qQr14AVZct0CWyMNXrysBbuuXcwEBVIhVZSf/e?=
 =?iso-8859-1?Q?WC6GNtsZlxp3W4BP1yAhxzO+0Z+SqdGm0fohQvkaKWrpCaLad7Q3rwjRuh?=
 =?iso-8859-1?Q?gbaVojqdveQ7lh+K+rwMLgaJquElVZciq+B90JEg4QA8cs5CGMW9cqWL8Z?=
 =?iso-8859-1?Q?r6SLAaUqvJhzAU3Va9YHv4JSCnlhxMeIZ0KGbOYEkseudH23fhrgPL70Hu?=
 =?iso-8859-1?Q?BtIiqEoH5IxDdtRNHK8q0MzbcG37C/GjqF1qNB9I9yYnPAcAciHY8FjXTn?=
 =?iso-8859-1?Q?YUqQSvPZIpZWybVy7MxfEXD/Y3FjZNgJmyRq//q3ST1MzXlIWukclL9yPt?=
 =?iso-8859-1?Q?mWRvUnzwyW1kXb5ZCwDIBQeNNHF775ppKegwFfGJudL4mx0jyRHKkPNNMu?=
 =?iso-8859-1?Q?9Kg39SShcN381xGUFVwFfhak5A3JkuA9j3EBmMDCttiSIPpk88dSWeYljM?=
 =?iso-8859-1?Q?x2i8zSzZQVktJ8a9St+rwYiVzNAEtWiYwjtCa6YQw/cI74hC34EuXf8eej?=
 =?iso-8859-1?Q?xOM9S6uf3odBecI4j30GLNiHsUR0HfANW6wxiLa3BAbaMgS6VHdJ5QXehX?=
 =?iso-8859-1?Q?F/RokhtveppPFR848gKX1jFSdKMlKzq6HZuTUuxNESHW5bVIlT8mryGiNW?=
 =?iso-8859-1?Q?xk5U97hQv9kI0mPWKTKV47183e9K1OouuYDJDISsj8XK6sETEOpC41WEb3?=
 =?iso-8859-1?Q?LGS2mD+ba988Rm/VNOT/aEZPcurOMBf1fFYDBWB3iMp2fg3LypXprwbb6p?=
 =?iso-8859-1?Q?oi0SP3C36RorrGR35tpF7WCgX3wXx4y/8V+aAKOcb6hTj5YEvDn18RvCwR?=
 =?iso-8859-1?Q?G0wuF7sKykwtyo3FTlsHyptpBH/NnVIvGYQ9iJddpD+zN76CsXzwaLkXMa?=
 =?iso-8859-1?Q?kwetxxfPQEbHu5QMOZSAxaaUDnFTeXNj5UxvaFrsZDTxjApNsmjKmGkwuW?=
 =?iso-8859-1?Q?1IjpUbPdnYUwaVXRRrukcDAzsF9lY3QOQCXgBhAHR98TQNJqDnlgMqUaNV?=
 =?iso-8859-1?Q?s8IelqMhkJyPcEw/b7LV+Ya5CoGI62P1Rf84Th72KWbj3JEhpMCLL4vG3C?=
 =?iso-8859-1?Q?/o6kY+GRDOo+Mx8g8sHzDXlDDRQeweivPZAZUESSkLLEM9cd6PZ0vtUHEr?=
 =?iso-8859-1?Q?mpCrava1ux9jmTRmdNX72+F+JPYE6XSN0swAMyRaKOaqtSQCghnDgyfr56?=
 =?iso-8859-1?Q?W+wdxDuMIrJ77Cj1gjDHd4qJhYMcleMA0FyEJH9pSRVFI+ab8DMWZBEOR1?=
 =?iso-8859-1?Q?yqlJI/HaLRMS0vofwTOtc6w4Cr2jTZmZYKU2kAIUCWu/EEkj7oS+jo5iNB?=
 =?iso-8859-1?Q?zoA8aPov9iEcX5uQ1RZRnNfPW5TQnuX5yIekXio5yUknedWwV+gN8BBl/e?=
 =?iso-8859-1?Q?ddeziipSxVLfXwX+Kg6uxFc/jzzmMjMUx+e2WuJevSUyfW8aFmE2fKEUU8?=
 =?iso-8859-1?Q?PrrUqeAlOyOTOmilEnCIlvvba5k/71097lByYd8NpETE72oQzzJkqexhfv?=
 =?iso-8859-1?Q?vzowrDIDXERwHZWUbkP1olR3mQHNb6z6IiHMHLMfSGUGDrEoDybvilaWpa?=
 =?iso-8859-1?Q?MUdh+Iz0Ow3/jZDSWhr919oLLbiP/yKhn4MMUaveY8oO0fZcEXSf816BKn?=
 =?iso-8859-1?Q?yW42jvnWpQhX4yqwk/qxUkN9p07HpOKj/w122wLB0zQqCSKSLGKVwW1iJS?=
 =?iso-8859-1?Q?IphqktruW2qxCnFDuWcnF2EzcL7igip0rMuJgsUdfFX6+5sgEOeogiPO9Z?=
 =?iso-8859-1?Q?/I3vYIltCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: laiSW6qrPzhnF/2GtJWVvqLQxlR0q+Fr6nWFYqEPhNS3oFx0AH2lm8XCc0GDhzt8hCeUwODGffss8dzeGdxqUFcly0tNrz88wwUF5qlHRlS1+Mp+UiJUrdzJviU0sPiQZO3rLnuuCXArO7pIEDPPit74fMhP579Tme9otAIQH89OJ3oIs+wXD0bezFmq0ugr+LvsEAZI7Jl5WqMWu/ekitQgkx7aUfiXgQ+WoDq8pbnfxig85SZjElavteuFFkWLOOmMhr2PQyWPWDOBKeMQFrmbZ1jbSGiiiaCaX8HfioBjt4urL9+PrKVRXYOh3GMW/KYZOUrA4ifpmwnV549kWQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d6592a-5226-484c-b7d2-08def76df5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:18.3180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sZKdRKQyarbJinK7W6VLBOj4E1FmFd50H98tgMQxKus5+lufEOSAFFZnHsqsN4y8g8PLU1han+4V8b2pIbXY3Bh6sqP0uDg63PKA7SqO38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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

The crypt command register was previously stubbed out. Implement it for=0A=
the direct access mode, where HACE00/HACE04 point directly at contiguous=0A=
source and destination buffers. AES-128/192/256, DES and 3DES are=0A=
supported in ECB and CBC modes via the qcrypto cipher API; the IV and=0A=
key are read from the context buffer (HACE08) and, for CBC, the=0A=
resulting chaining IV is written back to the context.=0A=
=0A=
The completion interrupt is now raised for every HACE variant as the=0A=
hardware does, which fixes the crypt command hang on the AST2500, AST2600=
=0A=
and AST1030. The AST2700 crypto engine still needs 64-bit DMA and=0A=
AES-GCM, which are added later, so it keeps its temporary interrupt-only=0A=
workaround until then.=0A=
=0A=
For debugging, the context, source and destination buffers are dumped=0A=
through the existing aspeed_hace_hexdump trace event (disabled by=0A=
default). CTR mode, scatter-gather mode and AES-GCM are added separately.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 283 +++++++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 268 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index c61efe50c4..0f35d74137 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -18,11 +18,43 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "crypto/hash.h"=0A=
+#include "crypto/cipher.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/irq.h"=0A=
 #include "trace.h"=0A=
 =0A=
-#define R_CRYPT_CMD     (0x10 / 4)=0A=
+/* Crypto engine registers */=0A=
+#define R_CRYPT_SRC         (0x00 / 4)=0A=
+#define R_CRYPT_DEST        (0x04 / 4)=0A=
+#define R_CRYPT_CONTEXT     (0x08 / 4)=0A=
+#define R_CRYPT_DATA_LEN    (0x0c / 4)=0A=
+/* HACE0C[27:0] holds the crypto data length */=0A=
+#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF=0A=
+#define R_CRYPT_CMD         (0x10 / 4)=0A=
+/* Crypto engine command register (HACE10) bits */=0A=
+#define  CRYPT_CMD_ENCRYPT          BIT(7)=0A=
+#define  CRYPT_CMD_ISR_EN           BIT(12)=0A=
+#define  CRYPT_CMD_DES_SELECT       BIT(16)=0A=
+#define  CRYPT_CMD_TRIPLE_DES       BIT(17)=0A=
+#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)=0A=
+/* Operation mode HACE10[6:4] */=0A=
+#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
+#define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
+#define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+/* AES key length HACE10[3:2] */=0A=
+#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
+#define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
+#define  CRYPT_CMD_AES192           (0x1 << 2)=0A=
+#define  CRYPT_CMD_AES128           (0x0 << 2)=0A=
+=0A=
+/*=0A=
+ * Crypto context buffer layout (HACE08). The IV is at the start of the bu=
ffer=0A=
+ * (DES places its 8 byte IV at offset 8) and the cipher key at offset 0x1=
0.=0A=
+ */=0A=
+#define CRYPT_CTX_IV_OFFSET         0x00=0A=
+#define CRYPT_CTX_DES_IV_OFFSET     0x08=0A=
+#define CRYPT_CTX_KEY_OFFSET        0x10=0A=
+#define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
@@ -65,7 +97,6 @@=0A=
 /* Other cmd bits */=0A=
 #define  HASH_IRQ_EN                    BIT(9)=0A=
 #define  HASH_SG_EN                     BIT(18)=0A=
-#define  CRYPT_IRQ_EN                   BIT(12)=0A=
 /* Scatter-gather data list */=0A=
 #define SG_LIST_LEN_SIZE                4=0A=
 #define SG_LIST_LEN_MASK                0x0FFFFFFF=0A=
@@ -501,6 +532,216 @@ static void do_hash_operation(AspeedHACEState *s, int=
 algo, bool sg_mode,=0A=
     }=0A=
 }=0A=
 =0A=
+static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg, size_t *ke=
ylen)=0A=
+{=0A=
+    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {=0A=
+    case CRYPT_CMD_AES128:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_128;=0A=
+        *keylen =3D 16;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES192:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_192;=0A=
+        *keylen =3D 24;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES256:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_256;=0A=
+        *keylen =3D 32;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Decode the crypto command register into a libqcrypto algorithm/mode pai=
r=0A=
+ * and the block/IV geometry. Returns false for unsupported selections.=0A=
+ */=0A=
+static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,=0A=
+                             QCryptoCipherMode *mode, size_t *keylen,=0A=
+                             size_t *blocklen, size_t *iv_offset)=0A=
+{=0A=
+    if (cmd & CRYPT_CMD_DES_SELECT) {=0A=
+        *blocklen =3D 8;=0A=
+        *iv_offset =3D CRYPT_CTX_DES_IV_OFFSET;=0A=
+        if (cmd & CRYPT_CMD_TRIPLE_DES) {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_3DES;=0A=
+            *keylen =3D 24;=0A=
+        } else {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_DES;=0A=
+            *keylen =3D 8;=0A=
+        }=0A=
+    } else {=0A=
+        *blocklen =3D 16;=0A=
+        *iv_offset =3D CRYPT_CTX_IV_OFFSET;=0A=
+        if (!crypt_aes_alg(cmd, alg, keylen)) {=0A=
+            return false;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {=0A=
+    case CRYPT_CMD_ECB:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_ECB;=0A=
+        break;=0A=
+    case CRYPT_CMD_CBC:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_CBC;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Direct access mode: the source/destination register (HACE00/HACE04) poi=
nts=0A=
+ * at a single contiguous buffer in DRAM. Copy @len bytes between it and t=
he=0A=
+ * bounce buffer @buf; when @to_dram is true @buf is written out, otherwis=
e it=0A=
+ * is read in. Returns true on success.=0A=
+ */=0A=
+static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,=0A=
+                                 uint8_t *buf, uint32_t len, bool to_dram)=
=0A=
+{=0A=
+    return !address_space_rw(&s->dram_as, addr, MEMTXATTRS_UNSPECIFIED,=0A=
+                             buf, len, to_dram);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the so=
urce=0A=
+ * and destination are single contiguous buffers (HACE00/HACE04) and the I=
V/key=0A=
+ * come from the context buffer (HACE08). For CBC the resulting chaining I=
V is=0A=
+ * written back to the context buffer so the driver can continue the chain=
.=0A=
+ */=0A=
+static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
+{=0A=
+    uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];=0A=
+    bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;=0A=
+    g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
+    g_autofree uint8_t *src_buf =3D NULL;=0A=
+    g_autofree uint8_t *dst_buf =3D NULL;=0A=
+    uint8_t ctx[CRYPT_CTX_SIZE];=0A=
+    Error *local_err =3D NULL;=0A=
+    QCryptoCipherMode mode;=0A=
+    QCryptoCipherAlgo alg;=0A=
+    const uint8_t *next_iv;=0A=
+    uint64_t ctx_addr;=0A=
+    uint64_t src_addr;=0A=
+    uint64_t dst_addr;=0A=
+    size_t iv_offset;=0A=
+    size_t blocklen;=0A=
+    size_t keylen;=0A=
+=0A=
+    if (len =3D=3D 0) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen, &iv_offset=
)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: Unsupported crypt command 0x%x\n", __func__, cm=
d);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!qcrypto_cipher_supports(alg, mode)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: cipher mode not supported by the crypto backend=
\n",=0A=
+                      __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* Fetch the IV and key from the context buffer in DRAM. */=0A=
+    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];=0A=
+    if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                           ctx, sizeof(ctx))) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read context, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                      __func__, ctx_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("context", (char *)ctx, sizeof(ctx));=0A=
+    }=0A=
+=0A=
+    cipher =3D qcrypto_cipher_new(alg, mode, ctx + CRYPT_CTX_KEY_OFFSET, k=
eylen,=0A=
+                                &local_err);=0A=
+    if (cipher =3D=3D NULL) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new failed: %s\=
n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&=0A=
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,=0A=
+                             &local_err) < 0) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %=
s\n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    src_buf =3D g_malloc0(len);=0A=
+    dst_buf =3D g_malloc0(len);=0A=
+=0A=
+    src_addr =3D s->regs[R_CRYPT_SRC];=0A=
+    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx "\n=
",=0A=
+                      __func__, src_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("src", (char *)src_buf, len);=0A=
+    }=0A=
+=0A=
+    if (encrypt) {=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    } else {=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx "\=
n",=0A=
+                      __func__, dst_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("dst", (char *)dst_buf, len);=0A=
+    }=0A=
+=0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_CBC) {=0A=
+        /*=0A=
+         * CBC chains on the last ciphertext block: the final block of the=
=0A=
+         * output when encrypting, or of the input when decrypting. Write =
it=0A=
+         * back as the IV for the next request.=0A=
+         */=0A=
+        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;=0A=
+        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
+                                MEMTXATTRS_UNSPECIFIED, next_iv, blocklen)=
) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                          __func__, ctx_addr + iv_offset);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int s=
ize)=0A=
 {=0A=
     AspeedHACEState *s =3D ASPEED_HACE(opaque);=0A=
@@ -531,16 +772,22 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
                 qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            if (data & CRYPT_IRQ) {=0A=
-                data &=3D ~CRYPT_IRQ;=0A=
+        if (data & CRYPT_IRQ) {=0A=
+            data &=3D ~CRYPT_IRQ;=0A=
 =0A=
-                if (s->regs[addr] & CRYPT_IRQ) {=0A=
-                    qemu_irq_lower(s->irq);=0A=
-                }=0A=
+            if (s->regs[addr] & CRYPT_IRQ) {=0A=
+                qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
         break;=0A=
+    case R_CRYPT_SRC:=0A=
+    case R_CRYPT_DEST:=0A=
+    case R_CRYPT_CONTEXT:=0A=
+        data &=3D ahc->src_mask;=0A=
+        break;=0A=
+    case R_CRYPT_DATA_LEN:=0A=
+        data &=3D CRYPT_DATA_LEN_MASK;=0A=
+        break;=0A=
     case R_HASH_SRC:=0A=
         data &=3D ahc->src_mask;=0A=
         break;=0A=
@@ -589,13 +836,19 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not implemented\n",=
=0A=
-                       __func__);=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
-            if (data & CRYPT_IRQ_EN) {=0A=
-                qemu_irq_raise(s->irq);=0A=
-            }=0A=
+        /*=0A=
+         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
+         * added later; until then it keeps the temporary workaround of on=
ly=0A=
+         * raising the completion interrupt without running the command.=
=0A=
+         */=0A=
+        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
+            do_crypt_operation(s, data);=0A=
+        }=0A=
+=0A=
+        /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
+        s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
+        if (data & CRYPT_CMD_ISR_EN) {=0A=
+            qemu_irq_raise(s->irq);=0A=
         }=0A=
         break;=0A=
     case R_HASH_SRC_HI:=0A=
-- =0A=
2.43.0=0A=

