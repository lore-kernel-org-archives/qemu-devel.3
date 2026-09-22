Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A33C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOR-0007al-Gf; Tue, 22 Sep 2026 05:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wON-0007Z0-Tv; Tue, 22 Sep 2026 05:02:23 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOL-0002C2-MF; Tue, 22 Sep 2026 05:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyyb9U3cSKYxUy+v1/YHHQUOovSkftDfqTA9gde3Q2j9HZYIc43flmFaY4WErAflX9kFusaG0OYQaG5KPh2BewJ3BMA+oZ+qJj48vmW2cxnTzZJ3l+B4Y5GxuwbUHu2DlPBQZ7HOHDN3kvAJnuAR3YqDcDfUy43Bwk993d7V7a5gs/unSGn/W2on1/w+IFeKFVieL3t3K/qUEDvSqVP0jfSvMCBkzJrtwMD6hYLN0J8GWH+/xjLWfdAb0F/SBUN/Q4d7/YInxmBUpYVumiV9hVocDf4SDvaZNXukbr+8pv0xzz6HVjLQDWqtVAkq5SIeV4mKQWQOTRlFsckgAiPSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duBaD98tIGeDEtk1itxS/Ac9/+/sHyocX9LD1O4Fw8s=;
 b=b78K+7qikOTJ7IVKMpYvkFKtg4CVHGf5o4+V8zUvyORqhSZ8ujGb34yVhqCfzk2Tl/JcQ9h0T6KIri37bKcJHupY7JN9UTWY5M9mMLdDDX8fYFPEbJKRQuJDl0ic2ZCtsUFyjmpPUBpMBLHTVCLWVrFwn2K8jtnQx9kj4QPj6+VVz3MRZOo4DwvUzKaz4qzbI37KJZ77ic9yGZLfAf/xIVCOLzGW/Mzdq99o39O6hZ5R84W2FaaNaO0qWtOBYz0EOKAF3TgfI5BR+Kr9LmyQFN2eEdabNIaZ1ybIIUtnY3ev2aEDBi4Dgqt0kU2ZDnaOTShpopwHXlm2ktYT1+bFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duBaD98tIGeDEtk1itxS/Ac9/+/sHyocX9LD1O4Fw8s=;
 b=o2lvRIHumfl38LfhS+he6JfjqxG5kQ1zCTzKkE+K6OaWQeRU/RJ9DFCZkmHbE6at5cjJCKRRM5sDAScnBuavZiIj1d2tlSU69i0ak6arHKUN0wELj5qcE5dRwOzjs63lOeeCURjFtmJcAr5T1f1eDlgL+0yCUGqdqsaduqpmaaBBQZv/j+nMD+xhQaG8uyJUNa4Rn22bmMPpR1eYXnEq2mRFOLZ04UUJuqD2e1litPL/JftWiD7dnIKz5u6GkqfKlgGFeETOvHx+xOTSeZbun76gl3K29OrPqvaRvJe1jmElvlg268EVe2KiFNwzy27KJcEgyumQ9GOyHN4FuqESBw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:10 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 12/19] hw/usb/aspeed-udc: Rename the transfer helpers after
 their DMA mode
Thread-Topic: [PATCH v1 12/19] hw/usb/aspeed-udc: Rename the transfer helpers
 after their DMA mode
Thread-Index: AQHdSnEN+phEY5CEoE2PkrYnuVIONA==
Date: Tue, 22 Sep 2026 09:02:10 +0000
Message-ID: <20260922090154.1792077-13-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFFE5B965AC:EE_
x-ms-office365-filtering-correlation-id: 874fe988-5284-4ae3-a3b6-08df18882fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: Vo7EsrZ29EFD9zr8/yw4u2YWhlCdu+pyXXciE/QbhJFJ8WU/++Rl46Yuvsj6iv2ho7EZH+VtdeQxHFpFf4Azy9eQJIMAV6OI/KADmKchhQdrbkqEeocib1DBaOtoPANlbn2rYZIVIDM8cM08gnM+La4qSLPsfeyGUSg+EmC90kErNBrxNQusAHyjoyMGRcath7wLLw7gQZluqm3Qg0mSL/XQX9/VmS93SlZ/dN2el/gLmTIfyfPW51E26qjUC9lsIn0Jbpk8g/ojiVd3n+gdWVCjPOv336hmOHvaNRwnBFf7JAciWn7xREznB8GBC+bVUxLoV1u1SJ8YyZ3oyF9i1X42Gd9BjpUiqvkMIFDxan36cNxKk3CQpOupvO9PNHqmzA9jvIbUrvh/88PDmjzxdB7Ta0APlHGmxlqoaydX0KXeSUUeF4KzmJZonyzb4Q+GkH5CIZHcQdtNiwskJ0Xs7hhxmL8csnYUOGCYCFIL6CDYPSMSneQDh4WxYwmVUr+ITw2WnoOgybnqbiHiLGysF5lO6UEtZJ57QzbcHSV1JhJYS/UcZC+SppcO179hAm3SXIPJGGDZefi3PRjo4pQYZgSIUgZe/0FmynXIvsB58dgkWSVrl5Qn+AQuAQWma7TpXYxefT5tUslDTR6z48PhZerK29fAEYPl+wMTaOb90ViNxtBBO4vF1oDOPuBOSjsTTdAjnXCDXzewi01tqEQKcPZYecNpkwFOnNrKD2QynEI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CikBKbJtK88DvM43VibxKLcOVjfjAH0lasgWRHwc7S6ClleJ9a15QRhQPK?=
 =?iso-8859-1?Q?cvtsZq7ggtlrnzAN+7NKU0YGhGKyn0CACzDo4ahKrKQm1utJMLey+7ywKb?=
 =?iso-8859-1?Q?t41pQaC4DRdWhmPrVe8fuIb++dliOO9rgnIGZ5nic7gtw6VsUsMWnmLHN5?=
 =?iso-8859-1?Q?cA5hE2H023503Fdw/IYRB6kXh7EdlRCsjWQCSSORQulUY4/GHfFgLjCKUA?=
 =?iso-8859-1?Q?FJKhKtwsheOSnLiWg7MX+GfIqzCzhQmoG9JG/5qbkOyEGv71ioQkpbT0DY?=
 =?iso-8859-1?Q?iY6pncf9p7E/162qVwZOhTRYi8rxedlZSv9ipskuo+rc/X3MP3pSBJG8K8?=
 =?iso-8859-1?Q?nH95Xpp5waQ/b46roLGtyj6fDXfijibm6pUhP2oLyMEqYA8ukhNSDeOH1N?=
 =?iso-8859-1?Q?/UJw6Xg3zgn3BO0nmsNGFZ5OJZobMwbSvUyPVSZVp783ekxSJU32m34rte?=
 =?iso-8859-1?Q?hkw3X06VdMHWzKzym5wa2/qitlklG8D2gBATnsyTqOqEZSbBpLHUYwCajC?=
 =?iso-8859-1?Q?q0sS1BmzvNBtoLUTBk86/3oqKYnauoSaIjn4MxsIwLsXYytPX/D+7IoKem?=
 =?iso-8859-1?Q?Qagtubpni+VxngmZ8KZU1lFOwPTnNXXReQTh9sni0vOQaL+ZDMtEZBe0xe?=
 =?iso-8859-1?Q?O9HXqddC+LXySasAAzd6FgudvpZPEQcbtJ1Ma2cHTM0jIyY5PiYPFoh82V?=
 =?iso-8859-1?Q?vDfMKTJgnJdrYwzCkLmBJCJeXDOnkG0rxZXIsD3eWuH5xAxKmIDvKbq4p0?=
 =?iso-8859-1?Q?IeZJIBCL539nIrCFTi2wuA3fgC+NanEkfgQQgxv8g8aVKZjJzd30Fea8aS?=
 =?iso-8859-1?Q?MGfgqAaicTu8+noWUA5EXjP/v2/O8pr2xM4Ortmrq5DsY5Clp4xwH2AntR?=
 =?iso-8859-1?Q?B44gfbeYMzvs5B70ovuLiJJbesF7Q1rNMBYAE9q6Hz3VaUcoZ5cI2uoPyH?=
 =?iso-8859-1?Q?U30n3Bq1etyt3wMFIImrZyHXDte4qHZ/5+9Eqi7P7ZYgcA9BRdRLTgTlmA?=
 =?iso-8859-1?Q?K2jiNt25tVRaTfoRXYYQdaBrHjyFS6536e2OQOPMbyfmALu+feWDTDsyzS?=
 =?iso-8859-1?Q?9YH/ksmYu29A9K6ZKjIursOcgcKdNIi4vOVXXcWuAnowPDSMJfmwfTXS0C?=
 =?iso-8859-1?Q?co47nP+5ZD7xNkGA/71uuln3QquMP0Gg9jBb9bTtT2p6z5gU4ZZIdHv49r?=
 =?iso-8859-1?Q?vcnqVS+P6oEMAqLSj7ygsh0P7doYs2N5JU9D8dU3jlTsrRwo048Xv5EzdO?=
 =?iso-8859-1?Q?eBYbrfIRFd9qaS9CI5CAYePTWKb13TbMZ50dNLTFcQH35M+2oLvhCi7wJ8?=
 =?iso-8859-1?Q?tUsIrNJQkITN8YVR9jn3GimbGX+W86ynmaEHpnh3PhSJR98OJM1/yt8HOA?=
 =?iso-8859-1?Q?iNanforaq/uv51d5qExoSsd+4/fW04PpqZa69/UnHc3VV47sV4dZe2k9Qc?=
 =?iso-8859-1?Q?4s+JdO8bZrDJKlvkFcsSdPjHXY3V3rDAighnAIjaCzeMjmvSMruOYLq63f?=
 =?iso-8859-1?Q?jwjBaDshJZoCKWUGVz19LQaDa5nQTXU+ZRE0/USpktREhi6k/v+Fu+fNpW?=
 =?iso-8859-1?Q?sgF9ToWO+5fCvHBvYpGJb1QVG2jWnV1cOcUv400eh/47iBMFV/7wOu9a5F?=
 =?iso-8859-1?Q?MqsaEb0LNNn7KYv33WraS1pWhoCjPkFq/gQpQDSpvf2YXIpFTtrr7E2mHe?=
 =?iso-8859-1?Q?mW2K/KwPfEfwFR0gJp0itUWSLlHaQkY9ymDyY9/vA4InawUGMSZupJAAJe?=
 =?iso-8859-1?Q?Pe0FaXHF5x3Hq1StOkXT5bBL2NLuhJfg/s38tdUPUPIEpSLc7cCP/ENWou?=
 =?iso-8859-1?Q?avaQeGRK0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sk59dmp4PdIMVCUMA43JuQ+no7qTqOV5B5f56eEEe9zWUjj84PQ26QGx4rvGqcSLynvGUi9N2Bw/3H/Ewem3y6Sk3YiMpHrKoQa+F/QwEGdmKDNp6PvzFch49IcLgwZCUYnrw9lf9c1smA0vOXucTYYgacnEBLaLobrV7/DfhdaR9ovepVIi7/v5eb2gbUf9t0wmnLok9OmbARpvyQN6NwJJyzUkXbiZJgSRkmrB+uyeiStScxHfAoA1ro7GuPgcUzqxQkr8pCAs4JlNJhGvMmdpTDyA+Y6I1HfvyaEFEOoDTbX/CdQyJX9pvUL0ApLzcluDEZmlYsF//E6ENkTfqA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874fe988-5284-4ae3-a3b6-08df18882fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:10.4941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x768QTZDv2nCm2SkZpGRi4SxIDm63IPKSqzbo+o+vHcXqMuzUShG+NoNMty0l3fFQT1kRfIZKWH99r71NDQy07zmxsxE8mJ4WBV0q6jB6eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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

The controller can run an endpoint in descriptor list mode or in single=0A=
stage mode. Put the mode in the helper names. That makes the code=0A=
easier to read.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 30 +++++++++++++++---------------=0A=
 1 file changed, 15 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index bdbd1a78b8..b43f077c2d 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -459,8 +459,8 @@ static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s=
, int ep, uint32_t addr,=0A=
  * This function raises the endpoint ACK by itself when the ring becomes e=
mpty=0A=
  * or when a descriptor asks for an interrupt.=0A=
  */=0A=
-static AspeedUDCXferResult aspeed_udc_ep_xfer_in(AspeedUDCState *s, int ep=
,=0A=
-                                                 USBPacket *p)=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(AspeedUDCState *s,=
=0A=
+                                                      int ep, USBPacket *p=
)=0A=
 {=0A=
     QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
@@ -568,15 +568,15 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in(Aspe=
edUDCState *s, int ep,=0A=
 =0A=
 /*=0A=
  * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
- * buffer the guest gadget driver set up (single-stage mode).=0A=
+ * buffer the guest gadget driver set up.=0A=
  *=0A=
  * A host packet can be bigger than one buffer, so we copy at most PKT_SIZ=
E=0A=
  * bytes per call, continuing from where the last call stopped=0A=
  * (p->actual_length). The caller keeps the packet parked until it is full=
y=0A=
  * copied.=0A=
  */=0A=
-static AspeedUDCXferResult aspeed_udc_ep_xfer_out(AspeedUDCState *s, int e=
p,=0A=
-                                                  USBPacket *p)=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_out_single(AspeedUDCState *s=
,=0A=
+                                                         int ep, USBPacket=
 *p)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     uint32_t chunk =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_S=
IZE);=0A=
@@ -619,7 +619,7 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out(Aspee=
dUDCState *s, int ep,=0A=
  * If the request needs more data than was queued, keep it parked and wait=
 for=0A=
  * the next kick.=0A=
  */=0A=
-static void aspeed_udc_ep_in_kick(AspeedUDCState *s, int ep, uint32_t val)=
=0A=
+static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep, uint32_t=
 val)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     uint32_t cur_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
@@ -649,7 +649,7 @@ static void aspeed_udc_ep_in_kick(AspeedUDCState *s, in=
t ep, uint32_t val)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         e->pkt =3D NULL;=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
@@ -671,7 +671,7 @@ static void aspeed_udc_ep_in_kick(AspeedUDCState *s, in=
t ep, uint32_t val)=0A=
  * buffer before), copy its data into the buffer now and finish it. If the=
=0A=
  * packet has more data than fits, keep it parked and wait for the next bu=
ffer.=0A=
  */=0A=
-static void aspeed_udc_ep_out_kick(AspeedUDCState *s, int ep)=0A=
+static void aspeed_udc_ep_out_kick_single(AspeedUDCState *s, int ep)=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     USBPacket *p =3D e->pkt;=0A=
@@ -681,7 +681,7 @@ static void aspeed_udc_ep_out_kick(AspeedUDCState *s, i=
nt ep)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_out_single(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         e->pkt =3D NULL;=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
@@ -727,11 +727,11 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
         val &=3D 0x77ffffff;=0A=
         if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
             /* IN, descriptor-list mode */=0A=
-            aspeed_udc_ep_in_kick(s, e->index, val);=0A=
+            aspeed_udc_ep_in_kick_desc(s, e->index, val);=0A=
         } else {=0A=
             /* OUT, single-stage mode */=0A=
             e->regs[reg] =3D val;=0A=
-            aspeed_udc_ep_out_kick(s, e->index);=0A=
+            aspeed_udc_ep_out_kick_single(s, e->index);=0A=
         }=0A=
         break;=0A=
     default:=0A=
@@ -895,7 +895,7 @@ static void aspeed_udc_ep_data_in(AspeedUDCState *s, in=
t ep, USBPacket *p)=0A=
         /*=0A=
          * No IN data is queued yet. Save the packet and return ASYNC=0A=
          * instead of NAK. A NAK would make the host retry slowly.=0A=
-         * aspeed_udc_ep_in_kick() serves and completes this packet later,=
=0A=
+         * aspeed_udc_ep_in_kick_desc() serves and completes this packet l=
ater,=0A=
          * once the guest gadget driver queues descriptors.=0A=
          */=0A=
         e->pkt =3D p;=0A=
@@ -903,7 +903,7 @@ static void aspeed_udc_ep_data_in(AspeedUDCState *s, in=
t ep, USBPacket *p)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
@@ -931,7 +931,7 @@ static void aspeed_udc_ep_data_out(AspeedUDCState *s, i=
nt ep, USBPacket *p)=0A=
          * No OUT buffer is ready yet. Save the packet and return ASYNC=0A=
          * instead of NAK. Writing now could use an old buffer address and=
=0A=
          * lose the data (for example a mass-storage CBW). A NAK would mak=
e=0A=
-         * the host retry slowly. aspeed_udc_ep_out_kick() delivers this=
=0A=
+         * the host retry slowly. aspeed_udc_ep_out_kick_single() delivers=
 this=0A=
          * packet later, once the guest gadget driver sets up a buffer.=0A=
          */=0A=
         e->pkt =3D p;=0A=
@@ -939,7 +939,7 @@ static void aspeed_udc_ep_data_out(AspeedUDCState *s, i=
nt ep, USBPacket *p)=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    switch (aspeed_udc_ep_xfer_out_single(s, ep, p)) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
-- =0A=
2.53.0=0A=

