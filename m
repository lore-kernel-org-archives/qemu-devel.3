Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20739606A980
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=h+fEYY4/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhFj-0000g7-Q4; Tue, 10 Nov 2026 03:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEh-00005F-Hg; Tue, 10 Nov 2026 03:29:48 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEf-0002zI-3l; Tue, 10 Nov 2026 03:29:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOj6MRk5umTQxg3A4KkVl1Uwi4j/6I10U4mlnHmZz4Rbth6CaG9KH0mLX+6R4x932FecucxDyZGmAkwkMTwSQKe8OC5LcWL7+Yqg085ZW3J0KBXp+abq0oyaWefMkGD3Q2m2Ux5iyuV2nCQ0AQCOnglnrrM2B9LWbjdrmhwsmnY0E+ySu7F2LbuXto1vjVt3hFtK0a/r8Yr3AdXLLXsAB46Wpq1nP8bXt3JMRRO4hG8iqCDX3/D1abrZNxgP1lJDR2swOl0LyZPxjAIB1K0YQ9ApHXVIoLxpSTUh3nJ25Yrkm+dg29kCyR76pARjKo62jc0G0KeVKI0A9NkoJBLvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmRmHpQWi4fShva0E81wUJzMN0sxwff3lUkR9iFS7X8=;
 b=ByDyO46x+etMwRUi3v31RoP/z0d6LgH2pfGxmyAZPjPfwFJfyUMw75I+qKJdauabO/X7zNF6JgPqXrA0rJP2T/McDOlE1juazKaGlfkWcP0QGXEQ1pRrKihX1MSBurrCEHpCxRUv6rhMXZxuIu4jcOp9HGQsxA/JT2sYtIkzi2a6EtuXsLrgSWxLO3YeKchVd8K7R0SQUvW4Dc5sMmgeyo4jhJxo5OTlwdj+U3TjTXobnu7TDEwCmGXrt/RH/vrxr4i8tyTTwypG5BmMf8ufdSdgQos+HeYAE7koj7n4Twy4BSAenqFrtVfktv5EMyeajN3QTA7MwQbQo5WbxqlWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmRmHpQWi4fShva0E81wUJzMN0sxwff3lUkR9iFS7X8=;
 b=h+fEYY4/F1MOw+dgNNUil0WvjXda+m1UV56cLrZGIkM1Q/VBywu2FjnwlcgEPQg6wgkv88nRim3MC/XoIB8xRlPM4EeYrPBu/D0XshBbyrXyJU89vsK+2J8wR2JdvktTMCAiH8jV0nmKSwlZVxUqKNHxXWqFdTfvaZKIDIsNCyHHrHoCBN7Y4fh+l5LpAcIMzRehtv8WvIVy+aR0X91E4G4VLGkuyJ0OqIOFK7jkoRGusFOK0QLohG8y/FTwAPZPiCZl654LZCe4KPWZMCMTH3PZi4xQrjL6wV8Vdl87hFUDTD6DEBBRJ7MdsIZnKE2j1/2CBbsCIXIEOfLwBQkFdA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 08:29:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 10/12] hw/usb/aspeed-udc: Add trace events for the transfer
 paths
Thread-Topic: [PATCH v3 10/12] hw/usb/aspeed-udc: Add trace events for the
 transfer paths
Thread-Index: AQHdcO2aSBkT4+z2dkqd8aJF41uZyg==
Date: Tue, 10 Nov 2026 08:29:29 +0000
Message-ID: <20261110082917.240329-11-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6047:EE_
x-ms-office365-filtering-correlation-id: 9e8ee0e0-3e29-45e2-7a0b-08df3f04bd1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|261026140227099003|261028144727099003|261009223027099003|261102123227099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|10067099003;
x-microsoft-antispam-message-info: 1jlgPRRCnePL9CbRyG4qqzY/FneLArEslcARYGt7VOdBlTrrQS6FrI6LxY+CNyBjozrbO0R9jvItFxoiZ4p4JTycC2LfrE+E+o8uNGbNEE/r+MiOBIKfiPYSe7OEtKD8Ms/shkfqnCKs46RTO2GthoeaSSy2Tq1RioAmxF1b3+s9wT4aJBdJIWn6/1SlQnDNxHHo/M/fQ3QgQD/32UP4kidR/VibiZO7rvDqcNqBuuT9zm0FM2m4LQmqXFDL+EzE19z4Q6buosO3/AGEYyCasibZp98mM0MKSvHT9QU2Y4cbnxWoGRLXaudrDxRdiIkx1rBHHyoHgHG4jfzWzMPM7fsEZm51Qj9sjktDWaaqEGzievMZQAYc6rYj5M/dUP6279k6T9ukIlisc3TvKrElBkF6dhJf0fvYzUx1rKFxIA4pVvFBlGuTPgzX6VWq9ulUXCuffWX3ZZ4xkQXsqXJTN/9iWVTRpkSy4OoKqONu9cA9eHtO5oW1SFlXOsb/okZRnS9tABP32qH+NXQquQWJrZ4Pt3EuiGdU3d2RWM1PagmMMB0sR0pTCaMie2zMRb5EodKnNoyJXtk6SgefTFKqsVCkNLMKF2QaGb3ufS6CBsuMF5esCi96jmh8puNyYScIDxHrr4cx1jWcMrOXhzHGPi4DV2ZU/uxEq/AImr10UzqLJCCRL/CixYAVEZbASm19iXRU+9Yf5gnAw5IAW6NC2GPZ1aEyiM++GFbRwJl1zeg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261102123227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZgF0USsbBnUUrgUFmoANQkge41Mb91zh/zfqoCHVmNeWx4ThvoOG7ISGJ5?=
 =?iso-8859-1?Q?Lupoy5Z6D5E4ibmPNMFCdGddZ6O14iHzXYnAOkOaM+kEaO6f2Osnk/erJs?=
 =?iso-8859-1?Q?hCAabgN7HIDSeQCa7zr6SkMELH5lTymqOL2vMoT4RartEQhpo2J9Ng1DUY?=
 =?iso-8859-1?Q?pCDgn10FT2jvEugImzlBBcVvKLJ3YGPnNXEE25g9/NrMxahHDR46ShjqBH?=
 =?iso-8859-1?Q?8lLV4tgEFQJ0OxiASbtx44QzMMIv/ph9tyh8deZT5naZ0AsCYRRCdOTSj/?=
 =?iso-8859-1?Q?FTNOLjOmw2ifd3rel+R/GG6Z/5/59gEd76V/ChXIu+Qodg4/Yb9L3tkIPM?=
 =?iso-8859-1?Q?/e1iFWPfFkcSpX9cmefEwXCdt3ghfmqmtBjTUPJYooG+2aLRwUcAhuTR16?=
 =?iso-8859-1?Q?OYodSuhQ99kU63++/F4ViZKf/6trPS44SygSRZUzkpqsoLNW+s6LEW3Z25?=
 =?iso-8859-1?Q?7GugZ9Ubbq6u1P+gff5LBSFEN+if9Lb1OxYmMM4fpHt19gs2wRTkYExaoH?=
 =?iso-8859-1?Q?fVj5BPPcbjmikaWDnkRWo44lAAc6zTYqp9MJo0A9SbtDoTjrF1Zear7ei7?=
 =?iso-8859-1?Q?EZo0RYC0FqxueewlyEHJLQRZoKo95cJFBYlP94MCWfv1rXYuc5TzsLeGsj?=
 =?iso-8859-1?Q?hlmeYkDFK/UfqqTRMqfIq5o/hVvF1KLXbQfVlJk/eLeQFguP6SiwcI142y?=
 =?iso-8859-1?Q?rDmhn8jUVXcF3YoyXILTUYwLqZctT46Ncqmbi9kLQPUKFUtoj0Av3OQZJu?=
 =?iso-8859-1?Q?wexR8pbO4284yLPtFfOYjUM0jpZg5RHxsHbnBUbJIZtExVCIdism/9jdIr?=
 =?iso-8859-1?Q?zT3e2mbbbac/SgzI8GrUtZLQx0SWsEe67bmQkJc2pdG96fNokECOKV2S56?=
 =?iso-8859-1?Q?fIlNb208LqI46x3WU5TS2Q8mL1rjcnIsTvUBIEdOFo/Cz3rNZ8W6dB3qa5?=
 =?iso-8859-1?Q?vHrd8vHEA4Pg0VmLN3UTHiXzaEFM+AVJKTVS2poI5OWilTghwyeYB6zuOb?=
 =?iso-8859-1?Q?MDN9H82rKS6SMEqL+9wGLyY8gzizephF6DHeUqPcWZfDyAoZoj4GP14gXO?=
 =?iso-8859-1?Q?qfbq1HligH0Vv1TUo/HkLWh7BoBeLWdnXwYB4s7zHzT++ce+P2EylBCWXm?=
 =?iso-8859-1?Q?a35M5vlmfStfCxyaAe6BQbaEBipqohRRX8bRDiF7heOhwZ9eXxb1lbv+UX?=
 =?iso-8859-1?Q?UCnGliSKb25ShFKOserrvZLaOi/KeSePBAMVVcngy0hn9PEsG0agYNRez+?=
 =?iso-8859-1?Q?kLgjmjBAVtSNkXGmzogBoJbonl6DZVqiWGtbIp+7gDJ3vtJsFLA7h1ZyWq?=
 =?iso-8859-1?Q?xJIU4/KPqoFtMCk0oTBUEi0MkUTzNNKCVTrtElgOM+CI8mKCzC76Fm2NnR?=
 =?iso-8859-1?Q?joBmB/zAMzGGZMiTwBYYi1aHFWT0wTYSwvXmVMDJA2pYq+jrCowJsDedEC?=
 =?iso-8859-1?Q?LMluReGegh7tGgvRnC6rZzBgr/yQn1k3qiVnxXjHhFjLkFU8saPJOuelin?=
 =?iso-8859-1?Q?EnWt7jDE6ZB4yDF+FtayzGpeNWfEM7VG2lnFNyWCcgHPcUq40hGLNUaemq?=
 =?iso-8859-1?Q?CEf3myxlZ65eXzP6EqyJc7b33ZVR63nfOtnAWrS5nm7/J0Vewq2WwVgj5Y?=
 =?iso-8859-1?Q?tRxCiWWDz+j2+Tr0AJQsWii1GVO9s4EA1cFJS9YZCHC6euRikGz2YYxrKe?=
 =?iso-8859-1?Q?4IH00kcnH18WsCCsMC+h97BBwtspIBINpiXbfGBXf7+IaAy7GjV2Wgaoat?=
 =?iso-8859-1?Q?5qlMRIrdyxKBjOR/qjoco3ygdUW87POuiTxFidM3poa07qou18dr46amlT?=
 =?iso-8859-1?Q?ZFZVzZoqFw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8ee0e0-3e29-45e2-7a0b-08df3f04bd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:29.4595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glHJUPjMU/+B+ZUwy9ScrBWXPplLt1ZuwCnRof1q8rAZBhof1hytvDYKDylovbeAYHkcjuJB/lJy2aH1JqGy18aPB/eA91l/NE2E2jWI0D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6047
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The register traces show what the guest wrote, but not which transfer=0A=
path the write chose, how much each call moved, or when the host gave up=0A=
on a packet.=0A=
=0A=
Add one event per path, so the name says which path ran and a single=0A=
path can be enabled on its own: a kick, a transfer result, and a=0A=
cancelled packet.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 23 +++++++++++++++++++++++=0A=
 hw/usb/trace-events |  7 +++++++=0A=
 2 files changed, 30 insertions(+)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 4ba55fd86a..b7aff1b31b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -575,6 +575,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(A=
speedUDCState *s,=0A=
         aspeed_udc_raise_ep_ack(s, ep);=0A=
     }=0A=
 =0A=
+    trace_aspeed_udc_ep_xfer_in_desc(ep, (uint32_t)p->actual_length,=0A=
+                                     done ? "done" : "more");=0A=
+=0A=
     return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
 }=0A=
 =0A=
@@ -616,6 +619,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single=
(AspeedUDCState *s,=0A=
      * buffer, and the next IN request sends the rest.=0A=
      */=0A=
     if (e->single_buf_off < buf_len) {=0A=
+        trace_aspeed_udc_ep_xfer_in_single(ep,=0A=
+                                           (uint32_t)p->actual_length,=0A=
+                                           "buffer left");=0A=
         return ASPEED_UDC_XFER_DONE;=0A=
     }=0A=
 =0A=
@@ -629,6 +635,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single=
(AspeedUDCState *s,=0A=
                                         PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
     aspeed_udc_raise_ep_ack(s, ep);=0A=
 =0A=
+    trace_aspeed_udc_ep_xfer_in_single(ep, (uint32_t)p->actual_length,=0A=
+                                       "done");=0A=
+=0A=
     return ASPEED_UDC_XFER_DONE;=0A=
 }=0A=
 =0A=
@@ -674,9 +683,15 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_sing=
le(AspeedUDCState *s,=0A=
     aspeed_udc_raise_ep_ack(s, ep);=0A=
 =0A=
     if ((uint32_t)p->actual_length >=3D pktiov->size) {=0A=
+        trace_aspeed_udc_ep_xfer_out_single(ep,=0A=
+                                            (uint32_t)p->actual_length,=0A=
+                                            "done");=0A=
         return ASPEED_UDC_XFER_DONE;=0A=
     }=0A=
 =0A=
+    trace_aspeed_udc_ep_xfer_out_single(ep, (uint32_t)p->actual_length,=0A=
+                                        "more");=0A=
+=0A=
     return ASPEED_UDC_XFER_MORE;=0A=
 }=0A=
 =0A=
@@ -696,6 +711,8 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *=
s, int ep,=0A=
     uint32_t cur_rptr =3D FIELD_EX32(old_val, EP_DMA_STS, RPTR);=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
+    trace_aspeed_udc_ep_in_kick_desc(ep);=0A=
+=0A=
     /*=0A=
      * A normal kick only sets the write pointer and leaves the read-point=
er=0A=
      * field 0 (the read pointer is ours to advance). The guest resets the=
 ring=0A=
@@ -745,6 +762,8 @@ static void aspeed_udc_ep_in_kick_single(AspeedUDCState=
 *s, int ep)=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
+    trace_aspeed_udc_ep_in_kick_single(ep);=0A=
+=0A=
     /* Do nothing if no host request is waiting, or no buffer was queued. =
*/=0A=
     if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
         return;=0A=
@@ -780,6 +799,8 @@ static void aspeed_udc_ep_out_kick_single(AspeedUDCStat=
e *s, int ep)=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
     USBPacket *p =3D e->pkt;=0A=
 =0A=
+    trace_aspeed_udc_ep_out_kick_single(ep);=0A=
+=0A=
     /* nothing to do unless an OUT packet is waiting and a buffer is ready=
 */=0A=
     if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
         return;=0A=
@@ -1166,6 +1187,8 @@ static void aspeed_udc_gadget_cancel_packet(USBDevice=
 *udev, USBPacket *p)=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
     int i;=0A=
 =0A=
+    trace_aspeed_udc_cancel_packet(p->ep->nr);=0A=
+=0A=
     if (s->ep0_packet =3D=3D p) {=0A=
         s->ep0_packet =3D NULL;=0A=
     }=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 7a84786fd0..95548eda67 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -395,6 +395,13 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uin=
t32_t iov, int ep_idx) "ep=0A=
 aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
 aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
 aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
+aspeed_udc_ep_in_kick_desc(int ep) "ep %d"=0A=
+aspeed_udc_ep_in_kick_single(int ep) "ep %d"=0A=
+aspeed_udc_ep_out_kick_single(int ep) "ep %d"=0A=
+aspeed_udc_ep_xfer_in_desc(int ep, uint32_t sent, const char *res) "ep %d,=
 sent %u, %s"=0A=
+aspeed_udc_ep_xfer_in_single(int ep, uint32_t sent, const char *res) "ep %=
d, sent %u, %s"=0A=
+aspeed_udc_ep_xfer_out_single(int ep, uint32_t received, const char *res) =
"ep %d, received %u, %s"=0A=
+aspeed_udc_cancel_packet(int ep) "ep %d"=0A=
 =0A=
 # redirect-server.c=0A=
 usbredir_server_chardev_open(void) "chardev opened"=0A=
-- =0A=
2.43.0=0A=

