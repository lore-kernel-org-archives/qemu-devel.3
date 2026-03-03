Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFBEEB3649
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEdo-0003VX-SU; Mon, 02 Mar 2026 20:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdm-0003US-15
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:38 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdk-0002EW-Mo
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaFUeZqPExAWqV4t02y0vLAmMAGVG9vYtthHY+wJ9cS2YxnNMKs8cdNIJMJlPZBH7as+ZxH3IY8IwcFiJiYRXkhM5lKjmTAyywZSY36NpwZb4BdGYYWUPq8u2rBKavtdzdPwpDSufT/2wxz5YmUGn8CXaQnqQfmN6YM9ZsFJJP9jSGAUq9j4QgTlWb2wLkP8YLilU96zUXHsWWVkn8YJSGQLyx8AiV9RC0gy6aGJ6qxY5lILU3Q77x4SwNR9QDvZOUXCGx/2WpiprnQXC92gCNG+SUKZsavbhPz5WijUlBz7NPwwq6EJ9G1PpLp+xkLYits5k+oUqQ0LiYiprLyVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfvXYpJMFprno6++uMWrXCAq8fS4p6xt/nXKdJmcjPk=;
 b=oX26a08B4Tcg7o8RYMZiT0g3m0VC0Itzj93FA/uU78yrLZ1FLu+8iRVPLDGXzbP/BLOAWhwSVpZWRBYNQfMyPKyjmGUq4z+mO61xX8r8UEE37FxIU5zxK4Mh6MrY+QUZCCPrb5b5Exok2gQ/rcGxhkhpyL9v+5dVbZp3ts65QBK5lziWCZltQlVsngyAmxOpI2JSkrSJaYsYn3163JyG5fV7VJj4+32GDhmOz+ot2iG16qiE2nHzCHuIoYYMdmdZnj+SwymiCgjTGZmsJJJ+r082+sIp4KuAJCk8nAYHgOFPIEK39FufsfYc21HpitSc91LkDwkrHPAHWxWFoGjrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfvXYpJMFprno6++uMWrXCAq8fS4p6xt/nXKdJmcjPk=;
 b=hPoILxION1Zvl3cATVA2pLvWtz7QHmdqvTHNrMUd3ACpZCw8+GR1yedGifSEyp9WmnQQ3hyJ+GJ7qtNYIw3oSqK+E2FWjVzetZp14Gr1vpZ1IOTbW1eHFz1XuBtvWSbrjjQKT07qdbV5yDgpVnXkpGtPjxnD2Sq81njCGbCrx3iRRiH26zH5j9eJo30TG86+60TVB/FYb87pOj0cDHcxjpQJF0SwfgWuhV+SwoR0OU++HdmDrFoCOZogeE7Tbhp2fStCw6INlAR9Jngp+Tzjlr8nLwzdGVWYSOMb7Yc0Ko2BnH3ngu3cTYB5ZAim6WPL1QaYkm5ccrGAkFJ2aU3qWQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSQPR06MB7973.apcprd06.prod.outlook.com (2603:1096:604:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 01:33:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 01:33:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "jithu.joseph@oss.qualcomm.com"
 <jithu.joseph@oss.qualcomm.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v2 3/4] hw/i3c/core: Initialize num_sent in i3c_send_byte()
Thread-Topic: [PATCH v2 3/4] hw/i3c/core: Initialize num_sent in
 i3c_send_byte()
Thread-Index: AQHcqq28DaPG8eN+NEur5cHXdiUJGA==
Date: Tue, 3 Mar 2026 01:33:28 +0000
Message-ID: <20260303013322.1297499-4-jamin_lin@aspeedtech.com>
References: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSQPR06MB7973:EE_
x-ms-office365-filtering-correlation-id: f250d5bc-f17a-402f-ae55-08de78c4df04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 34IBotLWK/zIWL+U9C20WPsIai0lrjILJd4DngibNQ5YZlUBkbZ9GmRhnq44fQx7LyzY0Vq0yn45zBba6HgIRvYH5nj652yERBwxM4/o8gYNLxgOi2La/+toG2G47mODbcMml37p+JmdBVZh5VuClcxJrvYVHfyAOor/xn1ZT05yE91pAkfjqC9QSjMlCSKwwHIp79LgoZcWt7KDY3Oo1Py/T6LoFMvOYR8MxrmbT4+9di49BWEFvpAunhi9hV3CHnPyp0k+bFgmBwmzq9ssYU8L2/0nlc1HjjE1CYQzfw46IAsNocOFeYK9Xm7iD312Gm5Pxgaf679KKC1x9QPAw78yIT7kaZ4v6tlSsZ99zd31xkVtb+DLolhBFtaHH8ODxJ+DsPUsuLYAt1zcRhQY/TGr8Zgv4RuScmo4wAkU0pdHoMN6jC2dbGgbGlCtEwl92tBLvRcL+FxtOCgud3w6uqI2BwMGvEhyAz4mGpFcE1EJx8Sp6p/qsjqQ433I40+HJU/7EjWk0wG0gGd02oYire9dIqswqVIcUo3jb97N+q8UnGhR4fLOaYmMhILhYMiygdgzHvcE3TdKrkUc40OqFFnK24T3hTTepoRypo9JQUzyjj9O2U99UUdhEHyyOM9qG7jMDDL5auGeGz7jj2ftpy3IBmcuf4fjE0IQLIGnDELW59JFPD/B7JX9mmJgRkQTkvSqfoOpp5rp4jeW4IEWOxil8vPt8qcWBEvufeUIGiUvoFUVa8xzLIgScwwXZjfdLqB5gD189q4/tx5tAk1ullHceFSHk65Brac9Zl6KW6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?90xAouxoJBWwbEza+IsoEOzVdPj9mgGZH3cxW/leqk/Kk04Gh/e+CQrJIqXB?=
 =?us-ascii?Q?i0cA9Dla6uWVDrQj58UMVGMRqMguYhE2PNHZOKIIw89xhe2fNLGxoSSEmzV7?=
 =?us-ascii?Q?83k15hyIemdzrWKogmv/ADNy6CfOeIuetyRojwdI85lqUKsMZh34bBlBUVUD?=
 =?us-ascii?Q?0VTR53bqO3RUUaEZJq9uIVC37FPzymJkh88aNbQratznayOMgrQsSwNfNq1j?=
 =?us-ascii?Q?a3ah6CVZC4tuchukmk0SxZ+8rxKBh0Zvdr9PCI3ZwuqIH01B6mQQBw3EKUoR?=
 =?us-ascii?Q?TaiPBRenfE+2/qm1Eia/QSAhAW5MR/Rs6L/jxJaeWmGbiIkuEKL3IeD5QR4t?=
 =?us-ascii?Q?DvIN+oauLN1imclJ8IFxA1QeqSKphoyLAdk6zjOxj0jyAZK4u/S8rey/Txnj?=
 =?us-ascii?Q?PGB0zv193ReoaxpOY1S56u0V4RkpkhzkzUU/i2Nf7NcmetfW4V4dpyH/PS+P?=
 =?us-ascii?Q?qHnlohX7r1pmbxLQ3Vz3eAo4xppIlPkJpI1cHVZukdVvBZ3XvjQg+/DdV+sj?=
 =?us-ascii?Q?e6lr7geaK/FGL/QvbN0/yfVD3OzI2kn0HDMEWi7bbIdZmdR1/cBkZqhXVjU9?=
 =?us-ascii?Q?Zg68amfUt1Q9K6uLC5leajhKXpf330bOI4IEvpwIQfRXzAIMsbtRiIKGPzhd?=
 =?us-ascii?Q?a/hW4eYBrHZv7UDnT3M8E3N2adPgUnRDdkO6vYu+VeOPAqVvmj4ZDApg0Pvj?=
 =?us-ascii?Q?SFCLFJuVI7OUXbUq9oVOuWQZv0Onth02fx13DcrAXqxDRy6fwZW0PXqBrmdx?=
 =?us-ascii?Q?EygLYb7gnwGuG+3WiCECBg5d0dP3EZVob82crXqGoZgIdhykevQt24Vy5r+z?=
 =?us-ascii?Q?NxlKK4uNCkJtp6A2M9niViP7vEiqfIV83i0DRM9h7uE6qkk9BY2IzvnDVDUu?=
 =?us-ascii?Q?mgo0C7TtL4RAtcMFtLM5h6IW2ko4d2wsgpjPY3IEO6H2fb7Emf5I0WmaDSkf?=
 =?us-ascii?Q?ViDt+hpB8p5oMS54i72GwZ0/PeWuLTxCrswLBOON5qR/bsmTpwHB5sC0J6G6?=
 =?us-ascii?Q?o14CdG6c9qxfEseZ3o5F40k4odYNNDY7o0g+bFPaTsWdWEu6PXWO++EqTEbu?=
 =?us-ascii?Q?DT9zFj/V6kuOXKXMEEGvH3638oFZvhKbSeusoBCz8o+EuaFAJhacALagXI6e?=
 =?us-ascii?Q?tNdhfcC6uv7/Xv6ek5nxqbB8zRLuqfJ9S02sbTDtnYxSvP2nRCUl9Vdo/8Gn?=
 =?us-ascii?Q?QtBQzxfT5uv7h5pbSy1QLi3qLz05Jo6YwUfQlU3jiXGj9cIMsoSq4TEcEhu2?=
 =?us-ascii?Q?63yo/rHoWdcNuMyxsA/YXvlaw0yPSBW/Sks3uonGT/LePSJdKFRds6aDPnD9?=
 =?us-ascii?Q?0T0CTtX2/OZKxYSqHLghFa0q58GfGPqSrpRUqCl2IhUVuDcaRMtxWo18fZb2?=
 =?us-ascii?Q?qMTKMIgi8g3R2tvwQFr+vAVAWCeRtGYZKzg8B6ncBO0etAv1wURFuwg1lt9r?=
 =?us-ascii?Q?NGkVMlUUeZkzyKmfKVIcPPQu8RPNh1Q85k+L7AA3oXODoDqF5SOhL4ijmNxU?=
 =?us-ascii?Q?MfJXfsZZyMrK7rx5+jjZ7SQVHvdLcv16PFJYqAG7JmejmtMOHb57VF57d1u1?=
 =?us-ascii?Q?oJ0au1deeJY9gyaonN76smqoNcXu2DPCzPO13rITf/q167Gf91hOGKACs/mm?=
 =?us-ascii?Q?KYAwxFsrI9narPnBg9/xVgA4rwZz5bo5NmerGbZpQ4xV+NLYWEduDxgaG2aW?=
 =?us-ascii?Q?56F25h0zAubaqarpVbwwHg7gp1ADHD/eMeWBSBZtLrleh4u1Sl7XI6lJfIEQ?=
 =?us-ascii?Q?ubF+nwxKTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f250d5bc-f17a-402f-ae55-08de78c4df04
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:33:28.3696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlLoEhNUuZz6RqI+S2Po78iLKcXqrTBMDAe9U2yQUyO59/rblL0fyjX2z378MQQQSXl4omfi6naerDCuKNe+vljBVsW8HmH603gNAh8wilI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7973
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

i3c_send_byte() declared num_sent without initializing it before=0A=
passing its address to i3c_send().=0A=
=0A=
Although i3c_send_byte() itself ignores num_sent after the call,=0A=
i3c_send() forwards it to trace_i3c_send(). If the target send=0A=
callback does not set *num_sent, the trace may print an=0A=
uninitialized value, leading to misleading or garbage output.=0A=
=0A=
Example concern from review:=0A=
  trace_i3c_send(*num_sent, num_to_send, ret =3D=3D 0);=0A=
=0A=
If *num_sent is not written by the callback, this trace can report=0A=
an incorrect number of transmitted bytes.=0A=
=0A=
Initialize num_sent to 0 to ensure deterministic and predictable=0A=
trace output, even if the callback fails to update it.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>=0A=
---=0A=
 hw/i3c/core.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
index 0a266e00a2..168526003d 100644=0A=
--- a/hw/i3c/core.c=0A=
+++ b/hw/i3c/core.c=0A=
@@ -325,7 +325,7 @@ int i3c_send_byte(I3CBus *bus, uint8_t data)=0A=
      * Ignored, the caller can determine how many were sent based on if th=
is was=0A=
      * ACKed/NACKed.=0A=
      */=0A=
-    uint32_t num_sent;=0A=
+    uint32_t num_sent =3D 0;=0A=
     return i3c_send(bus, &data, 1, &num_sent);=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

