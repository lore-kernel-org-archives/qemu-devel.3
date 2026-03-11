Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6708FD0648
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dyq-0003xH-0Y; Wed, 11 Mar 2026 03:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxy-00033z-8z; Wed, 11 Mar 2026 03:26:54 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxv-00052E-QR; Wed, 11 Mar 2026 03:26:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfGBSjOE35ENfzGwjUSZ/Dq5e4UdhgcmP/t7QuDIyszKaQhoWcbWPgXc33dZ/zt9oY8hyejzYFHokNe4+Uwx3Yix8qSk8UtDdAy4Gx/vt7C4uQfRonlKiJ0Qs1JYnMna4E8eDvi5rKHe8iLcDWxmKsqjeeGfAllVHWULWdU+kyysOWPW3zUzV0NZyXA/c2iwyHN1x1gOgdG3jpNAw4tCpButSSSU/pYgu/UDn6zy5Dfd5qCBPls3Cm6iO1kLfRdrYARRmY8TS8pAudPC1ArUeIFOk3P+5cz3WE4iFalkdkIhXkpSAI4MHokJ5PAFZr4PFvBTJj2NmN27PMKZ5a4iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJBCA5XwgfK4rDNiNu9bZxoB9aW6F7TGCk+QpvErKjI=;
 b=boeyCQObRM8hu8bTJ0WMJN6m0hWZFa1haVUNPMwpL8MZc7P1YU3+2tEf2/eI0hi8dajfMjN8Kcg2nHosqpYg0xxCzraMI7XWtIZtJUivXq4iZCHNXLf688pspYk5iLc3vUtJJ//A4qVoFdGOotZIPkHL5LLfxOPUdDgrVlZvyjltm6syVOGHiKMBLFTlvUEw0wp7WRdRtLnPYOxY2xsqLl0vHcRK7PDBJBt9aX9ANUZzA8U1usIfv5vlEO2X0IrAxdDWMKOj7Sjv1jgtrENnuqWVl7Rb5tWHHCbs8L2H0LnsQC9+6IedS+FtWuXB0N0hqmyJ2QgqW6X4d441yNT2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJBCA5XwgfK4rDNiNu9bZxoB9aW6F7TGCk+QpvErKjI=;
 b=JY2h882U6BSXJjtjL997DONe+I/NVHlQNZNUVcoJ0n1+XszFfNOmBALXtijnU4Y0rtm+jAf9q6Qjbnsmr2tZCc8UsOLfzHnADvbrMxxcEAjr7q5pi7mj2PmmUl3rMoXRs0OCT6LAxn/iTTar+fv3U8Zglu/8RHONgAGLs9lO4TsxZ/NWGEflfRzYuBGJ+d0lL3ai9SbWErQzcGvl78XPLrVxwA2hLl7gJ66TcrEby1Xw7tiUvVm52L+QWVR/ZEIlPb4f+hy7ysFtYZUi19Slr9zGgpT7HYb78XcprIz+s7+7B7x6EcA9obzEqVlZQR0YaowzrzXBLhzJCF5WZGWpPA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:24 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 07/13] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v1 07/13] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHcsShdtlTDceAZ10KDqmxaDHilIQ==
Date: Wed, 11 Mar 2026 07:26:24 +0000
Message-ID: <20260311072614.1095587-8-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: de64abc3-e6fd-422b-bf1c-08de7f3f8039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7142099003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Im2axwB7v3Ix8SCYM3GIZLS5r8l39MJZwoBPVOKt5Bl5hntXBYCWr3x5Az8OGdqN+4ORbOnu6BPYT9oL6hdsZJyT4VHOh56vK+Tu5N+ROC9Vctsrf4pxfu4bnIe6AGHwiZ1sfWwuIVx3rJqrB57BelvaI+kEyvQtNgKii9YEHvXIsNUJgzBfHoBieTfPKVoTthaLRmwzK5AYKref9cGXjga8ewfI5wBiHdA6HlWZcoL3cAyLlLUh7vB4blJ10+j5C11I0DhFFhT5uDFm64rHdypZPvIAPtimQWanWh7d11x8BKWYrXDPyOrMF2mzerDZvXiru0xCf6zZ9xnVNtJBB1t1o9HX/AR3ZAtxYT1MPOdbOn/auwSM4sZI3as35INjCDksucd4j5PBR4DyYLOYZ9gMU31oIqiqK5QRgpxtn97LBn898JgxxT29YVYf5/4758kS3PWTzr2oeVdTywY+/n1UYIWQYhJgH7ZvR5iBtJxZvuGUlrr7NQN8xgSOxaiKFF43NdX7vdndTeRvvm3mS6I+mbGy48cdDMqLjaZ7VxQFtucSrhKENfoumd4jjCrFxbY7B7sEuOCsYgAf5J41l/DHpUHe5lFi6kKVs7DBc6/wm7mY82QXFHJAZRmQ898vYlztqnIZ/cKbw5zKSs38BRB1PEqgkyGDaFu5TH92HbJYRSEsBK3QkeBUwCxZ5NxBNN1902p6OLj3Ej06kP9sx3CIm3ZOLjmVmgyrZxwLCc/htxFfOtgBZ+5PMyGrMm1kFkI2or1RcKzmIwar1ytCl2Jl1NQpVeYv7NB02o42EFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7142099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Syrypo/XNqT67Ial6GQlOuz9vSOA/gnHUquxf0nk7nwMHumT9gceQrrVF9?=
 =?iso-8859-1?Q?9QC0fRj6cwI7Ffxn5+SdBViyi9MarH6rJeMoJpnL0VQEPRRSu9WZT8qlbc?=
 =?iso-8859-1?Q?WcUrgs3768aUiFBM1gt19UG1gghU8MesomvJ+GN5+MhcIrPD0AC9rUXP2e?=
 =?iso-8859-1?Q?6HJLCQWOAmpoJMYVgzLM4YAQl5AT3dTG0R2tosWUNGrAbculSuH8uFEwdW?=
 =?iso-8859-1?Q?nfQnu54wWdu6Hxl5MGIewmmUd9eUnMQrG/jxWru1/LCs4gf15UO/Am7CiE?=
 =?iso-8859-1?Q?PNX7TaMLLevJv8/wWdduiMvkR5YWZoRztMPlHN9eNO1nTK/fwOiokC/uuS?=
 =?iso-8859-1?Q?op5fE2xuODY87sLtb2u6ItNSLLPCI+EA7uQHbE37/IPK50BdKlwTDpZGLs?=
 =?iso-8859-1?Q?LS5zNRaFZfi+Ct+mjMGduB0p1ioYtOypBsHE2C2gCwdWIdwYoP9wj8M0/B?=
 =?iso-8859-1?Q?wODJgcjy8EnJIOs1gIdzgAP7rQNorK5ClEFfyd/Kex1T6A4HIiwZXxjpYE?=
 =?iso-8859-1?Q?Y3NOo/SOOGCYNmSnopSO/A5EAJSPSEAHtYtrWsto9SGMhxULSt5Spl64Qk?=
 =?iso-8859-1?Q?bbJ8h1HU3GhPpKopEC9guad+XYmpR+zo8w0EdAdNNFZGJeyec/UV74+Q7F?=
 =?iso-8859-1?Q?wq/t+CXSMld1y1G2DRim+GulKWYmxbFKUR9rSdcFBfyI3+ADAt0jqOaAxl?=
 =?iso-8859-1?Q?3ZCQDx5ODCQTe2Z2HbB/oSioG2iOwyFIUhzZ8u5x0+cZW+JB2Tabm0rZjr?=
 =?iso-8859-1?Q?jk7BQ0fQw1InHvTH2sicQWJ4v6hsbP/pDgYb3LqUav1bWDfKU17gzimzME?=
 =?iso-8859-1?Q?i6xmOHtAK5aanLRtoyyllvDC3A06ng4+KgAb1ziRAEAl1Mgh8+uMYKETuA?=
 =?iso-8859-1?Q?mPdsAIEFnn5Hau54oRNVk85KKZ5Pq3y8468aLy7+fMs57DnclWFUhJnDkN?=
 =?iso-8859-1?Q?U24b3Bf/86a/lTbqlS7G4eTPh8N/flQPjTu54BoxXmh25luWI4m2uxdqEa?=
 =?iso-8859-1?Q?lWMh7SWZT62RjLemfDJr30st2emgcsiv7nYJiiFGnwgvG/fmpZccBZj/4i?=
 =?iso-8859-1?Q?Z3EHSQ+2S0VbLjnh1VsYwc1zpdlMWho/U42nQd+lNhRlfOQRtJ9qMKjfmR?=
 =?iso-8859-1?Q?leamoVXr+x8pTO5HmK2BC7/Xc0zUcTmR9n297O+1mgA/NI/D1TK3gtUZei?=
 =?iso-8859-1?Q?yPZ7ayyScWKmSNLzNhQucezX7VMCa4eRZKCinaz9phX3oMuwNiQrHJhKij?=
 =?iso-8859-1?Q?Bk3dmJKgOWrQU3Wm8Bh+iP7HFUtp5kusfxxOxUp/O2kM1o5NR2sS5EUO8y?=
 =?iso-8859-1?Q?F472YoprfyWpa4jnVbiFWsKsvqDyjGQ1KUddwKqg+wPlr4VvHVkDaXA7Ol?=
 =?iso-8859-1?Q?wnpK/6W48Uy2crf/MT+ZesQdfHLztfRLfwns8vrQGyWCR9CgbtizaWJECM?=
 =?iso-8859-1?Q?a7ArXuRApujSHKCPuDz9RNpclM1+HOnQzwHwEXCgBE3tOCChEc2CP5tOnf?=
 =?iso-8859-1?Q?YJRPKrtr7IGuGOI4WTXbwOJN9SScdHkHHZWKqnGZO5wpdgxgvMefC/XXZZ?=
 =?iso-8859-1?Q?2m6tAoiXz7GWCT4NU4Vt1b9juoDkul/TVxy3Vyb++TbzuTnsziLUe1C9t3?=
 =?iso-8859-1?Q?sYSDywlzZGwMEpnSanoh7+kBm+mgTjvgTXml+S5F0MHX0s6p2dPnF3hhaU?=
 =?iso-8859-1?Q?GQw7E+XL8kOYAMw+zN4rIv3MJc4XqhtVc+invKt7uiI1APogUjEIKODMb7?=
 =?iso-8859-1?Q?R6CkJ1aORNmsVgVsCssf2VQeLK+CJyKY49Gc+ZCosOgDsBAURaAHkv3nKL?=
 =?iso-8859-1?Q?VfzacN8qKw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ca30z3JRpuPqplGJ9rQV+mRB+wcbWNuCdcGVPobZj6G7jvHHzS+2x9wSSJCLZfaGjyShwJfjvUrkbxLtLRVwzyp/MlxdcShB1imvOZvLsjiNv1CQteinwa2flix4zekApOb/IIHDDNuPUU4pH5yksPXR/C/BitJb/tGUk+zOWaYQPB72jGC3EpVYUKXQcXTSGzjlDJw9QMAmyrShTqnSvj4u4633EmlesrX3FR1iO6HiudlfGup+s6M8oEeUs8VigHUf9RrpNg4+3d2kxecsDwcfsxY5oEYRgHYEguoChOHEmHcaAVb9ru4Mln/FJxJN47z/08YQdOBAGaYd8BeccA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de64abc3-e6fd-422b-bf1c-08de7f3f8039
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:24.4011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Af20WYfx+VyCbdkk1dKuSV6Xk/he3KY2sCVUVFcPVhrBEDn7Jnm57+d1oHBal5OKx6XGnoTUogfRCFIfHMqnlumRFZK3QfC4XuHqRfvLU0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register supplies the upper 32 bits which are=0A=
concatenated with 32-bit link pointer fields to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
The current implementation assumes 32-bit QH descriptor addresses=0A=
and directly uses link pointer values without applying the=0A=
CTRLDSSEGMENT upper dword.=0A=
=0A=
Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit=0A=
descriptor addresses when 64-bit capability is enabled. Update QH=0A=
traversal paths (async list walk, horizontal QH link, and periodic=0A=
schedule entry handling) to use the translated 64-bit addresses.=0A=
=0A=
Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer=0A=
fields as defined in Appendix B.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  1 +=0A=
 hw/usb/hcd-ehci.c | 45 ++++++++++++++++++++++++++++++++-------------=0A=
 2 files changed, 33 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 7dc6d151cc..f18150c352 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -204,6 +204,7 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_FRAMETAG_MASK          0x0000001f=0A=
 #define BUFPTR_SBYTES_MASK            0x00000fe0=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqh;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index d7a0917caf..8fd3fd60c4 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -146,6 +146,18 @@ static const char *addr2str(hwaddr addr)=0A=
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)=0A=
+{=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D (uint64_t)low;=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr |=3D (uint64_t)s->ctrldssegment << 32;=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -438,8 +450,9 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)=0A=
         (endp    !=3D get_field(q->qh.epchar, QH_EPCHAR_EP)) ||=0A=
         (qh->current_qtd !=3D q->qh.current_qtd) ||=0A=
         (q->async && qh->next_qtd !=3D q->qh.next_qtd) ||=0A=
+        /* 1 altnext_qtd + 1 token + 5 bufptr + 5 bufptr_hi */=0A=
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,=0A=
-                                 7 * sizeof(uint32_t)) !=3D 0) ||=0A=
+                12 * sizeof(uint32_t)) !=3D 0) ||=0A=
         (q->dev !=3D NULL && q->dev->addr !=3D devaddr)) {=0A=
         return false;=0A=
     } else {=0A=
@@ -1534,7 +1547,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint64_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D 0;=0A=
+=0A=
+    entry =3D ehci_get_desc_addr(ehci, ehci->asynclistaddr);=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1562,8 +1577,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
             goto out;=0A=
         }=0A=
 =0A=
-        entry =3D qh.next;=0A=
-        if (entry =3D=3D ehci->asynclistaddr) {=0A=
+        entry =3D ehci_get_desc_addr(ehci, qh.next);=0A=
+        if (entry =3D=3D ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {=
=0A=
             break;=0A=
         }=0A=
     }=0A=
@@ -1688,7 +1703,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
 #if EHCI_DEBUG=0A=
-    if (q->qhaddr !=3D q->qh.next) {=0A=
+    if (q->qhaddr !=3D ehci_get_desc_addr(ehci, q->qh.next)) {=0A=
         DPRINTF("FETCHQH:  QH 0x%" PRIx64=0A=
                 " (h %x halt %x active %x) next 0x%08x\n",=0A=
                q->qhaddr,=0A=
@@ -1879,10 +1894,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
 =0A=
 static int ehci_state_horizqh(EHCIQueue *q)=0A=
 {=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
-    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D q->qh.next) {=0A=
-        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);=0A=
+    addr =3D ehci_get_desc_addr(q->ehci, q->qh.next);=0A=
+    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D addr) {=0A=
+        ehci_set_fetch_addr(q->ehci, q->async, addr);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);=0A=
         again =3D 1;=0A=
     } else {=0A=
@@ -2210,6 +2227,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
     uint32_t entry;=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
+    uint64_t entry64;=0A=
+    uint64_t list64;=0A=
 =0A=
     /* 4.6 */=0A=
 =0A=
@@ -2234,14 +2253,14 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
             break;=0A=
         }=0A=
         list |=3D ((ehci->frindex & 0x1ff8) >> 1);=0A=
-=0A=
-        if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
+        list64 =3D ehci_get_desc_addr(ehci, list);=0A=
+        if (get_dwords(ehci, list64, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-=0A=
-        DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
-                ehci->frindex / 8, list, entry);=0A=
-        ehci_set_fetch_addr(ehci, async, entry);=0A=
+        entry64 =3D ehci_get_desc_addr(ehci, entry);=0A=
+        DPRINTF("PERIODIC state adv fr=3D%d.  %" PRIx64 " -> %" PRIx64 "\n=
",=0A=
+                ehci->frindex / 8, list64, entry64);=0A=
+        ehci_set_fetch_addr(ehci, async, entry64);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
-- =0A=
2.43.0=0A=

