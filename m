Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE44DCA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRF-0006XJ-HA; Mon, 05 Oct 2026 02:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR9-0006WC-3e; Mon, 05 Oct 2026 02:44:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR7-00004z-MW; Mon, 05 Oct 2026 02:44:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcZCbigiAMFjz3Zqod0PMru9R2cV/8YoGJMvEba0TukVuAnuxELNFj1Ezc/5WTnsg4paaqj4Wb9zeCVEKKlK5GpZwSgIhpObg6Y0SaZ3aLz4Kf02q3DpyGzoRBU6atwpuYbmZxuLjn1PqXfPZSef0cCX1K/y+GxFa1OKMCTIM0i1fmv73BIfe8fcrVNUAIcPwbwXFMSJVtwZsYqSkKB8OCQkEAzFCiGGFgXbPqSh1nkZAJzCjrCQcymBf2Gdteb0zpUzs407E2lLzv1xgliNaHrZoqGo3AG2k7iyrNWIYTdXhrYyYxd14T/XT/oOyTOyK6dh0E0k303uBquwYO2ApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8orW0N24o0d2zu1LrALrJ23PsgF5N0yYZL6Tcbp9lw=;
 b=SQtzfIr1qEmK6FBSkgFHSnTK8Lz/tYlnQMjnTLXOZqr1rukNdV5hzJQSeV3ruiXeEhm8/0DEk8tOgW5z3PFULZxltNWlHf+COaBDi0DeD2cM8iEde8YKoT8rliVtvHTiAHm/8bmP4s+Jh4mhBaDaknDTMFzdzkjnE55Iofh+458tkytoA857SHBOMbwedMbyhwyGjRExngf+7dkmPvS0Uoc0XlGQntJ5eGbWmDJdqLN3Rx/oR/eL3Yy4oiNn4Wpo1+kKirIdEzbQVklfdGWQGsfPyEmLTedbNMtvPj1s2zYB4irrE41LrlYYbezKn7othVIvRa1DjteKRM/ce7zAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8orW0N24o0d2zu1LrALrJ23PsgF5N0yYZL6Tcbp9lw=;
 b=YVhzuFUB4ioGjf2shTV7ByrCW0puEiDJ+FcLUFI+B7gy9EUORkb2yKDIClyU7m77dXBNbPBiRFq6rQ976rhHhwMu9R+P1Ru3R9sMoxJZb20+2p2M5hPBt43drrUbbCp05Yn8KF4mTGO6uGgWRmu2hdhXeb6L5rOa4DCum/ZkXjf6ZhkhFmhq7m2UUF4SMUtlWGPboAtdLV9ukFbOqyg2eugsePxLNHS/l9jkc+trpLSTMO/kdZtoU94jt5V7+ZKr6mmdv7XDuoEPu2TMP3kGW1dJWGXcQJAxsoHLsO1AiMeoERi2RdHUWG0FZ5KOxWHOaq9nKlR3pxxD2eOt357qhA==
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
Subject: [PATCH v2 03/11] hw/usb/aspeed-udc: Clear EP_POOL_ACK when no
 endpoint ack is left
Thread-Topic: [PATCH v2 03/11] hw/usb/aspeed-udc: Clear EP_POOL_ACK when no
 endpoint ack is left
Thread-Index: AQHdVJT0p/Pa3xYa7USLUGsAioifyQ==
Date: Mon, 5 Oct 2026 06:44:22 +0000
Message-ID: <20261005064418.3060881-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 7455030c-995f-46a6-ac01-08df22ac18f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: xuSM6Hr+Mf/qqub+1VmEioa1G+XcifZc2hiSPaHtSLDTl9+Mp0YGgksXhJVyFMmzr1rXepXySg4omY7nQdHNZHHng6ObgQtkV5CI1wGMGjlP3Sn9HocepMA+WQbAx9EbMM6fIXoWXhB18Y5bEJuLik47h/gLHinKZGZU/DVXXPBw5YDjqrJwTY8PkSDHDB85Spo/OHVY4WZk2jDtjAwIMM9zUAJe5UKhZ1wtmXvVue76lCR+FIZwf+XSGBHUoRlT0mziyWW2miWfN1iSznPPq7nofwUePFHSc8ebzEjkweWBALBhVx263fK+VwAbpxA+gxY4NqoTKOZ6DibgYiQ6ANbIs0VSmLdRIowiUzZGu89B9y6zmYlkA4gtNHgMsWayJArc9RcJtjF3e+IccP5mrcJTtIL1e0WO2GaCplFF0vCc2nAH6VBcQFaLYuO7CbZjyPS5hG5fd8AcwqWXMvyUoXxLWCrTmPAQmyvS6jLSz1Ca1/5AeQLrLxTFt3Hn0A95c2eOvbwKfo0rehGtIiMsb+AsX16YcJMU+ufOCujXxIkaS0xM8pTueiFV1BR56wFZyLHnyU+C1FXuKnJrH0vIsoBxc+3M4sib5WLFCMyaQcJdxCyOja64LJ86gWYEiYVbLY9VBQODNtsCb94wkSByPmIu4IrlnFLUAdFDsmfIJbwNKLg0jacJAnH/Mo+JI4JWeLDq2LPrgjKUdgjRVz+Uhhs/HE5lkbXyf15Bgo435bs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ug7VGhK6PhH/badolyXlirzXFUQxYcqyWfRqJe627Y2+wqJLvghdYE3Vpw?=
 =?iso-8859-1?Q?ta8Oa1vRDtgmcG1VnJaknyYMTAWqaeoV4rLSTNH2OScuB/TXe5To3Q7mPi?=
 =?iso-8859-1?Q?vxKi2QPgUWBUhx/jRKgO8fm6FR4BSK46rI5ZwpdoRKreetWzOgpbCAOtNg?=
 =?iso-8859-1?Q?9NPkETQD2t+9GBPSoHX0bFu6iSHFJ9peUT5DTR6DRyonZ/1ZnYpSm425OB?=
 =?iso-8859-1?Q?GI2cO7TxsDKi7EXOqHIFqviWxTmUHaoPtPIJ9Wn+yNMLmelHJ9WSOE3kIv?=
 =?iso-8859-1?Q?5AYhuKmb0zHvTF6cYQAZKlLV76iJcBqVPl/2aalPW3/cJM0/AEsmYs6uOJ?=
 =?iso-8859-1?Q?9uG0hsvlGspF6H/OCuBOMQ0aJXLLWC0e1FNRocll0OjEeclMgEScttADC1?=
 =?iso-8859-1?Q?m5ll2W6CxJU4dnWflm9Ov4mYLd3DMl+1KZsxy5ubSaPksfUk3c8h64C1FY?=
 =?iso-8859-1?Q?dcbadJhEttjax2vrrhlZAhOolNPxO9p+ri5sYDIlj1QrfyEDqHFqUQOaRm?=
 =?iso-8859-1?Q?o4wXgNAl2MWVqJNSgHgiQgTZu1D53GDhnG/7GrjfEdlvRDh1j4L6YGjlOT?=
 =?iso-8859-1?Q?mk5alNvVuaSt8veMkLui2KFb6yK8WEQdAOlRAgypznSZcaQLCtArJOWpuA?=
 =?iso-8859-1?Q?hqlxjrlFO/xTPH1vApUYEK2gttgJ/8BUZi8d7NTh52M4Ngdj7CGGcIc3bR?=
 =?iso-8859-1?Q?f3u++QEPBhgx01wQY9aCeuc8DtoJ0u1XgG4FPS7OTEMvptxlnKfliU4EIf?=
 =?iso-8859-1?Q?1gGnhkDWy1C+VSvflbELylzVIKaLrGB/n4ohA9O+nd3m15vuQYeNbobEWx?=
 =?iso-8859-1?Q?bR+pB8PP65qNHoP8Zwn7zo0nG8v/KdtkljqaH+/qZFBOZcX+Ff1BVU363J?=
 =?iso-8859-1?Q?2OI+mcGwS78jGinur/r0d49wn6qBmogDPk/NHq4FCpN0aAx6vM60+yNLk4?=
 =?iso-8859-1?Q?22As1mQ29PeFUWrdz0iLz5BE4EcgbTslMfkUb7Bnnl+U3Q46BNI7WEcJon?=
 =?iso-8859-1?Q?yo7opr/GfUMLmOjhGvejmNfse0/y0rF1sr9GEAIGWkWZGhEUAWFfLGpOGO?=
 =?iso-8859-1?Q?8hvorXkKnIfYDBCjIPUfSYhSr7f2mUHyPyau1j14Y4VxMjyUx4w/gdy3K/?=
 =?iso-8859-1?Q?1dnKWEmaK6KzaATAD4FnlAilIWUkzzhBPY0NhCkmXP/iK/iyoOOP+A5hzT?=
 =?iso-8859-1?Q?F65Ci+IBmK41TWUiWErAX1cUWeQQTQtnSOeJURgGPiFJNZHZ9yZbITI759?=
 =?iso-8859-1?Q?dsOLWcMbn7JgJqPWjsMpMinjCFJJODbUZmdUeTB9KvgizQtzMTLVd91LvI?=
 =?iso-8859-1?Q?n1EDDiKzu2xEBqqmnU1k8FflAtRLCs/ar+Xwq5Mq5YR12mty3CTGkavDuT?=
 =?iso-8859-1?Q?aMnnqM7Pc5+P86QrzxZXeJkh0S5x9tE6Kz2mnCMPrPLgqi7VEC4ZrVTe+B?=
 =?iso-8859-1?Q?pmWWph0icgofCtGP6ummEDKxs0+qC73DfsRBWMvPtYxlPLz6sXJywhJyWA?=
 =?iso-8859-1?Q?CARq3H2BeB8poHKxcNyBG6L7d2IUULFL+LmRXZYr8hdWHGwD2CtJvftRyX?=
 =?iso-8859-1?Q?m2+qraVnSLT2keiYoNi20D/B2amupnnVlhWhAA+b3gdR4FoVha0MphkpzB?=
 =?iso-8859-1?Q?dmf9q75yz09IIzmCuOyDT6jzhUCH3LxBfJapg9nEIsLbbqZnYwiF99yOqL?=
 =?iso-8859-1?Q?5NOOx3QxPLhXdEkVPnXVDnsIu96r/7F75w/ySO+BlHsr89aovluEn1qMDs?=
 =?iso-8859-1?Q?bOeyydEWLqynhkDqufXLYYI6zWdWbtv8SSmoUB3g2iApbZWcYKr+I2w72N?=
 =?iso-8859-1?Q?933r44VtbA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PYmbXRmEnhdvdKhaXRsqBAky4WI60sF5qxYGfGL6wbf8l/YOz7GylgWCb+KrqXtS8/SluZCDOEB72a00BxsTlu6Aq6omhr3svZJpD+4kHEGkHwuGzu8IAW6vtu/zrbVuXkIx7I+F1lkz1dKED/fNExd0gkTgwD24yjVPS7/fuaqzZasQTU/EQ3RZwpzk/q7JL1RkoRUTwtdRApZKfxQGkiaCDsdun4H1G/3ydFKT0a0QcMu507r9YaYZL7j2DbDB8BrafxGuVjTtItlVfXlT52ABhOjVsXSM5+xU77EVvPfs4s7K7fPPyWt2T5VWNe0zl7YcqPSnukDDg7lTE3uUfw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7455030c-995f-46a6-ac01-08df22ac18f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:22.9422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4jKs6W3oIO6MfsVnhcpg5MPa3gyxoTggwdSCOc+qf7xywqsLk8az69yQE8KbKThIbrTjGptDmEeOgyCQykh/8t/wmB969kz9Zonfp3IrJ8=
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

UDC_ISR.EP_POOL_ACK says that at least one endpoint in UDC_EP_ACK_ISR=0A=
has an ack. It is read only, so a write cannot clear it.=0A=
=0A=
Clear it when bits 3:0 of UDC_EP_ACK_ISR are all 0, which means no=0A=
programmable endpoint has an ack.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 95fe823534..bdbd1a78b8 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -335,6 +335,13 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
et, uint64_t data,=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
     case R_UDC_EP_ACK_ISR:=0A=
+        val &=3D 0x0000000f;=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        if (!s->regs[R_UDC_EP_ACK_ISR]) {=0A=
+            s->regs[R_UDC_ISR] &=3D ~R_UDC_ISR_EP_POOL_ACK_MASK;=0A=
+        }=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
     case R_UDC_EP_NAK_ISR:=0A=
         val &=3D 0x0000000f;=0A=
         s->regs[reg] &=3D ~val;=0A=
-- =0A=
2.43.0=0A=

