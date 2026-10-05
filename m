Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A16CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRJ-0006cj-Np; Mon, 05 Oct 2026 02:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRF-0006XY-03; Mon, 05 Oct 2026 02:44:41 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRD-00004z-MR; Mon, 05 Oct 2026 02:44:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUq0VaP2CUQmIg1k5BxEzwJdKMLldMTFMEuejyXtEcjHTftaVHNrjuO0PocKdUBaMScVAYS//g1ikvI+o5dvhWQkaD4UEImtcJcxkL99L/UUrdh80585ACOYUILdnLx55S322csbUyN+RKeEap/gdmeg6tHYiMuJletLsG3vmul52HNGDXpDSTv8CLwWeRoEMViOlVhY+MGGankX6ZNtsOmxulJS5c79w9Wyn7CwPjwvYycjIik5+tHAWtLCchqU/soZNomh10swYevrCNEEptDJpw5hDLYIWQ3GVDtt/ZVQIPD0uxSIfM6UVoNCFPzHdNl9c6orqeQ3rOdZS+f9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jTFnadiYrBbbx9VO7zpY5VJKIGuJ6UGuhrJA0IcS1Q=;
 b=HUOjxDVQ23n66kUojK5KwALH7tGfgzbem+sFPe78z5q4pVtUvAl1VinksRzE1rFPrfEcvcq597ek5a0qDTupw2U6VDIBIVcLtdlvwWv4j2zDFfcK3SUK+6YHJ8KHOzDOfZWQJBQYW2oe9YyJl9A+uuNYkRwo2G/pNPLDkOuXHnx8OgnFE93WUWgn+yq5t8BYMPlFP1PPczL/3Df0HwTl7gKP/NPaTtOwS7SQrnnjp0XFOh6QiqVP/3F09yr9ItHeQYFGrXsplcR2HwF6nIWYM+yi1lvtjYAeu/Q/hMMBrkIWcnLLAhpQwuDE5SiDQ+kCDyOgBAkTKaizBfa03oM4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jTFnadiYrBbbx9VO7zpY5VJKIGuJ6UGuhrJA0IcS1Q=;
 b=XJhhmk4i6M+JW6TXv+FVAfiIHcPrddjs6QGFhuDGnxY/pWCp+1NALnf/x7sfLSJCUM/oMo4Ed7mEePuGhwATYw9X4D6EzK7iaA6nJWc95AdDIupsbVX0v5dI3c48NwPQ0Kh0eupGo5Aen8y5oilXt/q7FTXep5yybzKi9DHgvGRRz8bztT4v6bT9nLkPD6UDoSZVVd3YfUzry9VHiMjsAHCRBRR9JzW+r6s3WOQW2BSb8FQW2Wf4ocPDpHHvgVqb8qaPcQ6L76a75KNtOzs8JXdJLDkwkZY6CqdklHbU/j2sK0l7Vxu82h5gJV+jKYsoszpsSgM6J12V0h7PX49dRg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:28 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 06/11] hw/usb/aspeed-udc: Pick the EP_DMA_STS path by
 direction
Thread-Topic: [PATCH v2 06/11] hw/usb/aspeed-udc: Pick the EP_DMA_STS path by
 direction
Thread-Index: AQHdVJT20Uo3mjtD4k6HyYsjBy00UQ==
Date: Mon, 5 Oct 2026 06:44:26 +0000
Message-ID: <20261005064418.3060881-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c1e38ff1-b369-4538-bf01-08df22ac1aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006|5023799004;
x-microsoft-antispam-message-info: hmg3N7mfj1X7qYGTMiP02WRjm8H+4Y9R4hlAqU5lGd1iGL3EdmoS3zJEPuM1pPjvYRQUSKwdhNYRU0k0drlDlXhDUPfU+UTJt9UCEhv2+D86bW0ouSCmD/nDmg0j82t7vK4G5d7t45SIUUqHAs67JlWt80bZAsQsiO1FnBdVsPZYylH45DCnKdlunR3I6oSjzfXbXSWs7/sv8yl1oc8768/HIfr4oYPnd3aHJb7jl8eG+di/udTXLogu2k+58sd1akifVQ2catYaKvE+EsOoAlD/O7hj1ZjAzuuWFr6FXfv118gDqK1M/0vEN9H9t9Ibe70cQSNCzRVUOrHbSSbH+m1XMbja1FyMprHgxP7/q/j7BeaR+WnUeHd3SgnaQl6T2hk9/wzCfff4II5C7ktv4Q1ov0BmMa/WAOdPRA5cAZ8aXoNYU94ksx2n4w5iBardXPatNUnJpK2HIZxhaiYKn1pRIYqTxmRKir1V4SK7BRo/f9jOQ6SByj4HMYoWKsdMxZYgWDVYaVu5sZhZyNooVL208nIT9V73oFst86yiIovMzMzsjWNpHD8pnDo+Sl+Ph5i86bgnL/Xcs2MAGVLfYLbIuUPUGvlaYiVpE9Qj40iErivxgJzEKNeikYkvLwZMW3RLvie5hpHYC8blTXYtoCyTyYECnKWEeQ4VVG+NDKmbqOdVihIU2ZDWTugvv/4clRfyuN/dWjzrJkywJ3JGcS8ETzR2naFTpwY4Zb6BSrI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+idz8tuo1y2JsTHLJifoQQAEDF+NxpQGlvrGVdhaN17FEc6qF/VVV1fyOx?=
 =?iso-8859-1?Q?bnfz1s8XZ6/C6GJFMe2s7Xoyr2rWWIUcuiD4H3tUjQDRL3RQBUsbzbdTkk?=
 =?iso-8859-1?Q?Q33f/GoQOSgxG59xCe0FltNn4PbL0AY0VvP23WLIByKeBUoAElFMgQrSo5?=
 =?iso-8859-1?Q?y3qCZ1iIHXFPrKmFn4ICDNWJ6bHboy92ugcBWMWZ6kdkmuZMJ7OpuUdGpT?=
 =?iso-8859-1?Q?oOi5g3TetR0h8crLMhghnfcL8qCHGfo8T1VDbaDxO1zjOFeN+yq7gQPuvt?=
 =?iso-8859-1?Q?96pG1GT+dKwiHLwR+OLAJmr5kaAZhv8B/ejjEcbwyUVGotbtoc40QklTSq?=
 =?iso-8859-1?Q?+MQxRGLO2zfU2yuOkFKzVOdR/v0bSXrB5qLzhecWEyEmmkY7aforYQnrSr?=
 =?iso-8859-1?Q?waL3GEz4AlrajKbnVgdVw8BeiLCGu+mJLNbX9sy5ZUznXnq25WB4NP16pm?=
 =?iso-8859-1?Q?vtxRERdzN6kveBRhuhZDug9YaCI5dZZ0MKK42/12XLiIPqy7DcIDx8euux?=
 =?iso-8859-1?Q?c56VXGdEwO8c2xnNUEaB7k4yCCesCcQeox3RbobPt5j2th2JlfohuEZWaT?=
 =?iso-8859-1?Q?XQzr6W20eR2nAtIh1o7I6Ve0BdQFnWdgmMzv8HPJXOUQ22y6Llw0D5fGBv?=
 =?iso-8859-1?Q?gLaM3kC2qmDzVb7xn4+Y7lfCnCsTdj5tu+EURAeNdjXlYtw+BtZ4Enkipm?=
 =?iso-8859-1?Q?/pHhcP+QJ1F3sG7XBX19OnNqcW9j6q1RBqbSj9Pi2vjys72fu2vdaMNIQc?=
 =?iso-8859-1?Q?79uG2/0r0DnqwbI083K/ulCYpDlE7zbS7iBseTXFo+ILZniv7fNwVZs1GZ?=
 =?iso-8859-1?Q?f3VOuis/D2OmskqzMftIxAAflZvSC8QiCGnhIif0hfUwtXs52WJQo7IQS6?=
 =?iso-8859-1?Q?Y1ttJOpUO/G483RC2MsxjisFuKdXQwOagWaOHbHD15u4VfSKk9K0DyC/d1?=
 =?iso-8859-1?Q?8n872tET0wH21bg2RbgzJMZsCQsNX6yIlVTkuckZXq+KK5MAS2CmsoiPFK?=
 =?iso-8859-1?Q?Qlv444IQBpARACgAIo3lix6SZ0kVmBQwGPIArR9blkrf3jKVK7ALjgxdKP?=
 =?iso-8859-1?Q?HRblgLpbAdIthMrLvRJ8wOzSVSTZbTp5+nzGDQ6cAVexer5PmqXAD0mTpO?=
 =?iso-8859-1?Q?c+wZ+ZGoFh3S7J3NGj+yKPG1ltYxkSSBW0nUnvkyzKdPdW32H3yez+QdC3?=
 =?iso-8859-1?Q?MPnlwPYowDz79GrRkwSDbuilBTdCcaCyAII3a6NRS2XqXzOizOoLbSxZkt?=
 =?iso-8859-1?Q?qXKjVemF/OKOyEdA1uDqEHG816cv2BxMqsq6FpuTEtzo4D+dFVbxaFQEz3?=
 =?iso-8859-1?Q?5ardMn32hma1JmsgIvYXrqaTJfpt2+GuvjYu9VhVJrc3+trOQN4F0nTlZi?=
 =?iso-8859-1?Q?lll6t2qf5oIuQhuiEff6jXcpBcxJh6Jq9ON5rUo0FEfzaRTXmp5Nh+7GyV?=
 =?iso-8859-1?Q?LTISQK8rRyZIs6Qb80AGdV2EVgLwPSvB2wAjzoTzEyADgQG3Eb/fwcHEKF?=
 =?iso-8859-1?Q?oVQpXG1gN26d6krVjqMpb7JPY59VPGj61dg0/mjji27Fxs9RGpVnAf+oFx?=
 =?iso-8859-1?Q?5JWdJW4HJNlhe7PHrCZDdENmgH83dGMqEHweD0ViROEpIgQd9/VagpYP23?=
 =?iso-8859-1?Q?dyZBj5Vaox6h4lDvwcvF/YD7Wcu1wRZyUzfhMuSFGSdM3pE85JMBYp1DIB?=
 =?iso-8859-1?Q?QHfpZOJO9b1rSsqyZ3JTG0QbsZ319w06AcI3BPQFSmgvr7EUXzM5raGl4Z?=
 =?iso-8859-1?Q?8LHeNRsETsclJVl66ZAxgHssmFJ6K/FSOIz0AgmtnpeRetWGsidbpJjKN3?=
 =?iso-8859-1?Q?yvEsWVNz0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 05aWfR3x2b80UUQ9SpyL891S1Iv9cfJg3WIzIw+CcywiiZrZIQCq/IWKu5rnU2trpDGfT4kAyJcf5fFi5lUUUKg9UK0IGtFDRprT8qO51F7DF6HzGlEnINSsJ49WR6YZ09yUY0A9edg8TiD87nT1aku2YG8YmjUJ71hG0/1Oh9rfoMRPhNmm+bFVUjQIYYPIRonWf/IxzgPOxeDfZcAqcRYe9LFkn78QUe/+B2WfylTsgo/X4R4kbx/9cszq7f3x+L8bQBfs6P7DhpP2MOkBYb3n3sA4p1if/23QwXCiF1W8MsCKkIJXxvRhnejMz92RzKeygbtNeru8l53xOXgjOA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e38ff1-b369-4538-bf01-08df22ac1aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:26.1636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dG6PE7wL0Jco1oQCFQCIz1CF5A5LYgwXqjt+zSNXqWaiMRFdqTWqXt8IWl8fBn/pjekOghVLJ9S3K64PAZGBp+l3OvPj/I+L60uoKM8ZHXk=
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

DESC_OP_EN is the DMA mode. It does not tell the direction. The write=0A=
handler used it as the direction anyway: set meant IN, clear meant OUT.=0A=
=0A=
Both directions support both modes. So take the direction from=0A=
EP_CONFIG.DIR_OUT first, then take the mode from DESC_OP_EN.=0A=
=0A=
The model does not support OUT descriptor mode. Log it as not=0A=
implemented. It does not support IN single stage mode yet either, so=0A=
that path does nothing until the next patch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 15 ++++++++++-----=0A=
 1 file changed, 10 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 4572914e16..c48e2c5f1b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -729,12 +729,17 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
     case R_EP_DMA_STS:=0A=
         val &=3D 0x77ffffff;=0A=
         e->regs[reg] =3D val;=0A=
-        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
-            /* IN, descriptor-list mode */=0A=
-            aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
-        } else {=0A=
-            /* OUT, single-stage mode */=0A=
+        if (FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, DIR_OUT)) {=0A=
+            if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN=
)) {=0A=
+                qemu_log_mask(LOG_UNIMP, "%s: ep %d OUT descriptor mode is=
 not"=0A=
+                              " implemented\n", __func__, e->index);=0A=
+                break;=0A=
+            }=0A=
             aspeed_udc_ep_out_kick_single(s, e->index);=0A=
+        } else {=0A=
+            if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN=
)) {=0A=
+                aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
+            }=0A=
         }=0A=
         break;=0A=
     default:=0A=
-- =0A=
2.43.0=0A=

