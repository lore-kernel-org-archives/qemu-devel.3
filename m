Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C67CA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRI-0006cK-8k; Mon, 05 Oct 2026 02:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR6-0006Vt-SE; Mon, 05 Oct 2026 02:44:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR5-00004z-7t; Mon, 05 Oct 2026 02:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrP+651I/G0hTFMtvKu4VlcxIXOwYg6IS7tF76Jr+oaGE1MFj+T3lBgLfjt3HBIPqpJ+qjktuelmjDCgemertua90dBT0vaI/KrOCp6amK1aqxXnxdRmQQcEXWhaWMP5kcPdIny6slVnWue8UkKQrTeMO8sCWCdqUDGWY8meXNtxNbGsvEt2756CXrJqlNZy7Ffun60C4DhrqFZ89Wg397TV5Io40/eAMvWoQ8NQ/kDnREOyzjp2JrEyBGBpEr73kqqn6B1wtRuWnmCI7nHeTHJjm7etEwZKQdIkbw547dMJwv1/TQz5701gMLCYSzkalfMDTQtcQHFoq02zCt5p/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmyVF+kf3r5FpR0c25iEZY/EXOlx8OvvzR/pYWN442c=;
 b=pbSb/JHAQDCYAtLjo71s+cV8z9+RwkiZVb465swlwqlASV5uQmTI+fs3F60aiYMjwGmaebZ7lUcGnt23YA3Xe4pI/PCft7J016k6+NyP8CN2FQK2yN2+jfLAgFCQvjQctiUgUKAQeafq++EwF/BZXue6AH93y7zCh9KUD+B0YeFIFJ31TjFii16kpte+IsdBYUJlL/zjBi8rnWJM9ofL5ZHaIz+fi74PMR3v8pAAr4xvGnk5CsNgpGBduy3kTHhEiOLpU6rBR3sQvD+L4z0fh0O9qUVFBS7CbplQwkYOGkKfcx2hjZoLI7ELDi3yUchIKOOOIPnuemhy+I2kn+Dl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmyVF+kf3r5FpR0c25iEZY/EXOlx8OvvzR/pYWN442c=;
 b=B8UszRDER/9DtpYceTOTRzOHjM0GN/Hj9i5Gn5D05MjOGGuKQht040ZSQh4AbWPtIK1voqsLSqcknwzGMnmU9GMQaa7g173Wk7u1KExGHRL9LKjfUPGGk8ssSkefMv4gW3SiwTKDM3yDAKUU7PpSQCJWTN/GFuIdHr3zrUryvqpgaFVE3zwtScYoUYP+KwrgX1yMzqY7Msm3qYitF/scsgayPrkJMNnG2x3AL6R9XLdX9ZqloSklSSM6RX3Cl83uy3K8p4iMD9+MFIcyri9eVEYTm2Mx583GtQTs+GnwVZbAwxw8Xl+9FyV6NcffTxwREAHPyyNDmvB510qaYI3izQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:25 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 02/11] hw/usb/aspeed-udc: Mask the reserved bits on
 register writes
Thread-Topic: [PATCH v2 02/11] hw/usb/aspeed-udc: Mask the reserved bits on
 register writes
Thread-Index: AQHdVJT08A1grkdAhEGwO9K8ilAh/w==
Date: Mon, 5 Oct 2026 06:44:21 +0000
Message-ID: <20261005064418.3060881-3-jamin_lin@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7166:EE_
x-ms-office365-filtering-correlation-id: 82f99eae-e12b-453c-2347-08df22ac1889
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: UqkvHXiGH8E12R9A3/yveP1rq7eMS0wZ0xS9ICaG34wH29ZkuRKB0aePmukHtewZGVTMfa7FhoMXug1iBbS7PHLmwwrb+c5SoPAQgStboikhy58W/i67NSGSiJB5KR5bdfHUVJLR/OCuvHSNNgZPyJzB2X++p/V2MLE83lHfpym/bzumqLWkjwIrCLNmEjEWHqNK7RJup0s747ymL9ty5HiKGoFwce6rS4KCE3K6E0joWtIIUwXk2IEnv14oDaTRgSGxJacJ2bsIxRmaVG3nX0ZW7l4DnZCOkLnyXl2d7FVAH7RJStevgnHqLZgLh6Bh87Mc+PHnACWA+X6YockSLuVFH1sWoB/EnBSBLt5YWlIa5y3RTM+Vy8KVFmHDw7Q51la98UG211yMLnvP2dwQjPZSDC/oxuiLFFZqFp7oHUOWwqHX+ZbEN9E6vvjn/LxQ2jD8ViG3GKypS84AiLSh74D9fymg4ubuzGpie/lTRGviMepNK7toVzyoK14ohqcBPVEVX8hSA+eKtBrDdFWMII6aOZmUSmFYzmHArKE685R8TTzDm9UgWO8uPAkVfRVYu5RGmmAZ/gcAXxuHC8x0rkm03GrtU64PXEIyNHw+0cjMsYcjP+EnELHqDTJ21C/mS7uT5tYSRJKDRHrUDagu2Sa+sLVrjdgLomfnkpWvjR5MheKXgmkGasWItKVIeBCBuCdvHM5KBRPuKnOs737EYOr2C5G7F62nCu2vjMamydY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1RyeFBm5f0B6ek4VjhKyRzNrPeOQjuXSLUq3VzQhVfA02DudcFb+Rs6OdI?=
 =?iso-8859-1?Q?6cTs8rMD5OMhZHbR5lS7EIvsucU48sZinV8Cxf+/BUtVmaW0XotGjvnNDz?=
 =?iso-8859-1?Q?J4RPO+0+TG64quMSMfk8a8MGSMxXYPBmqBL8h8sLj+tuZEtsJfFE3rrw9d?=
 =?iso-8859-1?Q?Co4u/7kRS+ag5359NxX3SA34mvbbJ0fyxLp4+PpYRyqijT8jMpAAd+hdET?=
 =?iso-8859-1?Q?sxgs6tdvdYiQRDgOfoQFp55x0Mo0DQ2SA1qn/77TuYQ1umsswOG8qLZB2r?=
 =?iso-8859-1?Q?EOhv0oqsWMoFcD1OIGg4G3mbtzPYUqc2vZk5QvuHvrsMVhRgJR/jT/sihK?=
 =?iso-8859-1?Q?XCBuxqE0WyITjnOcjTbZR0wjzg2v0kyzt7Lf5sOWe5cshuuUhe9aC23SBC?=
 =?iso-8859-1?Q?FX5HZrYHAoH0WA0yRAg1p3Lktp/NdAiQBsPUZeTG5q/T+ium/Dg9rnQulV?=
 =?iso-8859-1?Q?3h5wjIF8RyixSOKCOMXMq7dcqFR96daGv+USvUlxNiIGmbAKv1VtzzmNCB?=
 =?iso-8859-1?Q?TbmZU+0c+U5AZGFRQ4zw18WN5mxbb+/X46iva3ggSD9QvxKPUhUYhm8nCp?=
 =?iso-8859-1?Q?7tt5G/8JJFxMjVRhnxMrL+5NDhFf0FbMQJJ3r9q5Vo1Cq+fJoEcqDNeR5k?=
 =?iso-8859-1?Q?lwj3mSBUTYO+kqcDZKTKDkbjPkizuWJBaAH3TnGAIoycSYsCRkjqad+E6N?=
 =?iso-8859-1?Q?k/5BnGvjfT8M9TmrIkMQ30rGB3YdroYtls1w5y8FZd0Vo/Np2JP2kpr9nG?=
 =?iso-8859-1?Q?6V/jAKfZAYS//DrQqonD82ovLnqRU2HJJhFwV9UGeFLmfAsGRm5VCHQ7vU?=
 =?iso-8859-1?Q?5aXYZmGlIk+QYAdTUUldEr3nDwQn0CvXDnH7NNF1SIbsOdNvYiDFNZ4piP?=
 =?iso-8859-1?Q?5R61i8NhtGeR6t3+5nvQBajaLc3tGg4eLJ47dInACc1IXYOTfsRhIvyMg/?=
 =?iso-8859-1?Q?DwoqCl/BMBTGj4VN82rYTDYXnwl1GOWeW3G5Y4pWNrgOZPq1F99R42mws6?=
 =?iso-8859-1?Q?N+sOFZhDz8SfNiNlD3Rg0/Gc4UCwpc/q47RQXVLDa/nsSSPl2KRBNEPSB5?=
 =?iso-8859-1?Q?0tnXA8a1T2Cqaf6hxhV3xNSUU6pfoavVVS7V/MaM7QB8xnr7enFkvLpCAr?=
 =?iso-8859-1?Q?45jlR2JDyvuH9NXzh/1bN6zJzvUfg4l00xEHEF3J1DjYO9PgLsRnQVCucf?=
 =?iso-8859-1?Q?9kAHM/Dx0qX7pa57E+1nWCwfmd8TnlixSbgk2SXdZZ1w5whU7pXvlrJFvq?=
 =?iso-8859-1?Q?V1XQXeLnYF5uyp9Bt5YNNBPopG6RraNTPxSsWhzcwk2J6u9o2eYt1FE/DJ?=
 =?iso-8859-1?Q?NgIPvfkJkdhDfte846+xXRhOUAX8gEPUQgF9lhrrWHBNg8s/cVyiF2xm4g?=
 =?iso-8859-1?Q?pRVDL8grItS4cPq8oa3v1LdtK/NVR3dpBztaDhK3tDT7NvW1HGtYvRRi00?=
 =?iso-8859-1?Q?yWgixAqIjErX9jvFrlryqVkKIodWCh+DL3dhQdi/OkLO9tyshFSDR6lut7?=
 =?iso-8859-1?Q?UKiXUMKxRlAx5nOZQYPaeeNfJ9b3VDyS79/XS5xWm0NEQ27cljqveb7X/0?=
 =?iso-8859-1?Q?GsbeQ1Tdj/E24YCMGNnlsceUdReMcCnYfdmzuiYJHeGRKOUErP5Pa+YJc4?=
 =?iso-8859-1?Q?C8MtY973+OWqkWzHcJGYLZ0PFlb1BAcp8xQrYMf1XF0LsghpgMa05o3VpQ?=
 =?iso-8859-1?Q?IpH/idLZeSpA0fysirkdfE4JLdSbpDKwylf7X1f5SeSZxZ/tBkNfBYmO31?=
 =?iso-8859-1?Q?yFcRDLqMrNY20q1H9Xw5Zgs0ROMueyepyWtdejPLju0B8LeCqeGK2br1Ms?=
 =?iso-8859-1?Q?aBVN46Puig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vjytpRJtyvEd+go9LwWttK107wqeIWCpw1slpnXxaPUtPN/NP/AslYVMeB12IKcWu0gvS/noRaIEeCpI+n2F0gnNOjmGaGQxP5WslS/AZOebOf1Cqq2F6JmI+dwTmfngZz+i2a4qt1WAbjQnDSBy36MqUPacV2bl2P8PDBnVnrKnEOqaOdpejqQiDlrU/26HUYC7BYzBPLoUS/toRtlBFuDjAwTV3BRoiB3uzyizD0QrWBt6/RuTm3CEn783svO3YKELW+5HUSbrACeasiOggRSV2wUFgV7/LIXT6xiMOEsAZBo6wZ3673+dDUoo/HpT/Gn42WOP1MWkqDr8Bomgog==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f99eae-e12b-453c-2347-08df22ac1889
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:21.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b72RR5AbT1oP3BODEGVu3ScBGxFi3sUsFcs+jNwdCBWu88aJkUjp4DtbuHu5xH8Mj+Cnrn/hpyT91iubuPu8vXqtmm1b3h/Sy2Xmno6iYCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Writes to the interrupt registers were not masked, so a guest could set=0A=
a reserved bit and read it back. The hardware returns 0 for those.=0A=
=0A=
Mask each one to the bits the datasheet marks read/write:=0A=
=0A=
  UDC_IER         17, 16, 8:6, 4:0=0A=
  UDC_ISR         8:6, 4:0=0A=
  UDC_EP_ACK_IER  3:0=0A=
  UDC_EP_NAK_IER  3:0=0A=
  UDC_EP_ACK_ISR  3:0=0A=
  UDC_EP_NAK_ISR  3:0=0A=
=0A=
UDC_ISR bits 17 and 16 summarise the endpoint pool. They are read only,=0A=
so a write cannot clear them.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 355512822b..95fe823534 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -319,14 +319,24 @@ static void aspeed_udc_write(void *opaque, hwaddr off=
set, uint64_t data,=0A=
         s->regs[R_UDC_FUNC_CTRL] =3D val;=0A=
         break;=0A=
     case R_UDC_IER:=0A=
+        val &=3D 0x000301df;=0A=
+        s->regs[reg] =3D val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
+    case R_UDC_ISR:=0A=
+        val &=3D 0x000001df;=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
     case R_UDC_EP_ACK_IER:=0A=
     case R_UDC_EP_NAK_IER:=0A=
+        val &=3D 0x0000000f;=0A=
         s->regs[reg] =3D val;=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
-    case R_UDC_ISR:=0A=
     case R_UDC_EP_ACK_ISR:=0A=
     case R_UDC_EP_NAK_ISR:=0A=
+        val &=3D 0x0000000f;=0A=
         s->regs[reg] &=3D ~val;=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

