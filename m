Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1083FAD417
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSI-0007SB-O8; Thu, 23 Apr 2026 01:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSG-0007RC-SH; Thu, 23 Apr 2026 01:18:24 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSE-0003Bi-At; Thu, 23 Apr 2026 01:18:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFY55zbQihlTD5ZHxc7kNBDcLLuOQgwIFgmGSiouNWHPiKJJ1dctfOkBFxNQxMkzSDs4q4T5osoSelHxVomdfmmpYcY76w5rd2yLu5+4FT6Z12LQZfgR9twmpA65P1iW69s+G7TnqgdHZOpf4x8drk9XkPaZqse0OnFRDZXhMGzspI5C2kUHpppAb84hV4Ih6Ych7xaczV4sMIH+d7/hneFVdCTW8CDeF71zwFhrcXsTQ4dse+CJNGW97BrQA/cx/lDWfUURVeL6rHEk+N0HRhq2z1qiBC+7qubPmj6mCWyALywu5nbdVA4PAWFuYnBDbq+nW7EIZrI54eq5lTqKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njr4wCoeju2QssBCsergfxNnAQJ7Wb4og1kRDdF9wIg=;
 b=Cp9sYqUbLgKfkoHjaJSwEayfv3ykHdhkLWGsNIMTwDRgMDwEU6ueZiXXX/VhpFtacLX39Q8oqRhPwvN13W8nNbQu3IXXqAW9mw5OdmO5jC6uezrIz2cmRk+X82R97El4SLO18Gb5kmZOO1f8jVijo/2Uvr59d3A820HJ5UwpH+CH+bLndGQ3wQLnZNJ1jWceAKRlYTtn2N9qMtSv22RSdFccZSTCQs6lhbC7Ikx3ai6D05+bqwSYRBC2VV1Q+jyoiWbKSCbVUPeS9G+abnlaDS5xf1jOljCo8uMUEeZ/WEXk9IKlvRBoSIThshhpqXmiyYOTFUb7zF6yXMLsTdD7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njr4wCoeju2QssBCsergfxNnAQJ7Wb4og1kRDdF9wIg=;
 b=lROhp24Kb8nq8wkZ9tkgtENK2ianUOw7rKc71en1AD1AfVBnAF+7AYOb/KEFKvy8HMlPimD1G70E+Dv9sS+mZwh4hZZ8h2+HPSCYnZzP5YcsGOYCJpKSMTa+lkM/m5juIPG+apVwuOue+FhLZIAhaRnytqKzGczxBm26agwZiiqboRKQXwboFkR5oipp2SWVmjxVPDFCKRoqp9ITfOpfiq+3+YGC4YQvIYgOwPrQnQeNwCtXby6QgEhQd0acKDufG4oZJK8NCh+sbhyXQ67gRi6uRYx8JACik6Ph1IhbWTSvfXlRasMq+mbB9I4fWojpAaSdXMW1Tft1nM4Bw7XE7Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:10 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 04/17] hw/usb/hcd-ehci.c: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v4 04/17] hw/usb/hcd-ehci.c: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHc0uCTwyqYk72ua0yM0nO2B2R3hA==
Date: Thu, 23 Apr 2026 05:18:10 +0000
Message-ID: <20260423051804.362095-5-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 7fc11e76-4206-4dc0-5608-08dea0f7b631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|18096099003|22082099003|56012099003;
x-microsoft-antispam-message-info: DUaCNfkTTySk2T2OqI/Idy/S89LyEbpPyR5m4+BiKZbeqp8IhGMNkeAUJzK0HujpfBqRbqOTLjslWwLk2+lVEFGDx6FBNBUvIwfrpEkdk8Al/T7LO1d5tLDrLsEaDEXL2CWhi0ew84vOsB9W4Pb3VMEhaipfrv9yvZZTbYyhNtBqYTM8bZFD1N73nqgzNmLHdTe4M2mHfulav3J/G2xVJkku4iJsw6EGjCgx5dO0HJ+oE5ILS2br+HC+6Klu+9IxiXe3cmWD/Qn2Nb8+zP2eIi4aEC6YUOvlOCowNQ7ku9qHIzKIBvbiirfGVtMQ/p1MzOtDN/M03+FJEFJYSxabORPWmE2oCGry+4KTTH1FuEU4KgM2TArDcsSNvnvwBKCWaSE3QF5uXoIldqdX4E/Fe7VGOpLxlGXVL/m0bwfyi/hOlhgpc7+gdhCxQwWiKxAlFv08inHnFdc2xNmKdgpqYAn/CIkQi6bVp/VXwQC+hKVOAhfjRhfZnmM8+lfxfcTtuAvDrUWkxXwoKCBmQwlo4QQFFUs84o0gcWA6iUlRe/GEEl4ueNSG2dXIiY+JWasLzeOaOH2gyfEuTLa2DI/ZAHGtpoDkRU2Zj6YgJItzDKtr6r252Dc+phJWCvfZxGDYyLksUYwG3+4OIrHS+AgHWGo80QSeoTs79gKIe6f7bGvlTA3r3I/VVSQQS3CJIt59MbAj04r3V400uxEVe8p4LhCtdznPjHEYH0Q7jlL37NmpdljALbr64EmaayuM0cyHHrWjRGbRd8oCo6RTs9occcql7BOvPFwnFXYn4Zgz8q/QJbOdxgBS816O+gf8Mf6I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(18096099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?viu0A0MMMMmO6MtZ5BjAQwUdVOwfMyFehr7S6m/yMJrHA/SGOMsK2jhSAd?=
 =?iso-8859-1?Q?6V92Wl+RUOS1qd0USZoEXdn1PmfH8k+g0n+6Y104ieD7Rt75hld9jAcvZy?=
 =?iso-8859-1?Q?CB7U0BwZw5RCMbYOSkRM6mo7AGtl6S3bmT9muckqNStm4iNUDBRm6bCSZm?=
 =?iso-8859-1?Q?1j6B3UjxYLP3OlRWj/BA32CoAxiXAHWHmDOBQnwdL3ZiBFfp4W/zowYOXz?=
 =?iso-8859-1?Q?gjY+xYh4RRfqYQW0IGYWXmVrTgtmLkU9v/bI9kuya3/Q3PMD66ApGD3uJf?=
 =?iso-8859-1?Q?i7NsBKL9pQweLq3FYge4+jaNikS9eSLaarl5Kj2ZX7sf4W+powx1RLdJ4p?=
 =?iso-8859-1?Q?qG47VH9nFVkwMPFVqZTdohR7jC6UpuUXGyZ5Jt8BDwbiPm31lnD3cinkAE?=
 =?iso-8859-1?Q?elAAL+2vgj6qBV4a1J377Ydv4eiw+z+BZmtLypwcifdlA0aEqCja3q3fWa?=
 =?iso-8859-1?Q?oMOpXihsVpDo7zfj9K7hmkscnGzlBW0GT/uAk/bPIHLeLmdADwwicx+Wia?=
 =?iso-8859-1?Q?fXc8JxI3GVdqTrpDIlbovVixjrQbkBUak6tCdlQvyf+UglTX5lR923KrSJ?=
 =?iso-8859-1?Q?fCVJJfp27wNg7LD2D/vSJl03db7dgu9r6Mg4A3am0YvWALfGV+KTMQOILh?=
 =?iso-8859-1?Q?7pCyd8DI+Xz4wifMSiqyIw0kyvHH/0DMnjqXACHwrv9AIg90VD2RGq//96?=
 =?iso-8859-1?Q?Relgay+Xn9YahxWW6sXtYDTnP585QPXuCsRg7UJjNnM03vNravbhoTFnB5?=
 =?iso-8859-1?Q?6Kauhc8pM2Ov5raeGGAKg43QlJU11MjZRxLqGMj8A7C8zq2Kazo/I+wVUQ?=
 =?iso-8859-1?Q?YiZT6O77WmJAnXOeJD0YwrrIbWZspih5F5QfACqACgNnxVFNz6tJU2YUUN?=
 =?iso-8859-1?Q?Zy/7nRQ3TB42W7STye8M+/yiede2WoQebJR/kmTdN4rfsv138+JA8Grye1?=
 =?iso-8859-1?Q?TkV5Qtc2VPay/BHEf5Co84sHk4sNhVhBdzAfrMPlYZMmDRhHzIPcFT/4VU?=
 =?iso-8859-1?Q?knROp8PcbCamtnyETHTzfrXdwY4qj+y1CtbzzY6OXbKdNTLxcEgOaVpYrg?=
 =?iso-8859-1?Q?KypGNCmrX77O1stvavI34HBzh/Bjo+taXhIf6ccGINbVImgmP2qTzKeCb7?=
 =?iso-8859-1?Q?GJvxYi66Sm9euu83Ew/Umq1eBGbGWH4npLEyI3ck7dDR9GpM/AN2c57zZI?=
 =?iso-8859-1?Q?1heleRrl9ORwxSlJ74PPu1vGmaxdNK10AHCIVDlgQCYQ2tNnvbpQlZiVQG?=
 =?iso-8859-1?Q?B4gd7C/jPDSB4whfahtUSUVBOIQHd3COM5FAKZWrpSFBAKLM9hzBFA7J5v?=
 =?iso-8859-1?Q?uOiGHrDxcjDbGXQj+2gdUJc1GIJv/7iY3fZ6pup9VtZILSVE9jA+77xKu1?=
 =?iso-8859-1?Q?nFYByRr8iD2o25lo+Q0AX2PrtJtndjCzDUlLfHkr0AIChjS3oV5iOM14HL?=
 =?iso-8859-1?Q?zmRO5VKfzngfgtGL5uiihE3EN+/Zi6YMn6Nf6n+X9fDeuy9dF5sD3n03H+?=
 =?iso-8859-1?Q?x6RhOTB4BdHhODvKSRYD9LD5HB/GcrapND0QkFKDUnrotUCmr2heRd10Ck?=
 =?iso-8859-1?Q?iRVDHntJknI3avSGEyYzUzU8bewJoNrhcxS3Hs1UnhnRyrquElL/FuTIfU?=
 =?iso-8859-1?Q?TWL9oyufyrwXZqW5FyfrRJAImzs2svngCtwjbYXPxHXiaVcdWi4tL+g2PI?=
 =?iso-8859-1?Q?QzvTMmdPHXD5lQ3emaARMe3eIDuOm27wuvlSR4dY3NY5GYbrc5YGURRgJS?=
 =?iso-8859-1?Q?OAes5QxBpwhcQ6BzQDbJNBx6NGrrVUriQYnCUmlVNIMxYZHRXjUNWLchPM?=
 =?iso-8859-1?Q?a62pObD+/A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AZsYCCyiwhuEw3+8ph2xcHoPuZ18X9eGa8RhRGf17fDRPr5/KHBNlBGBSXeSwDJZatQ+y7EePPEFqOAMFXW9p3AqZM0UbcKxCGrBamhoS31EfXMyae5iCkpA70JcT0NahMugoM/RuDLBy14Fcv7V535NhJ5kRo8Gomi8HwJYbCzTexFi7SgMCM8dY6kKMN5RBEwdtwRlxlva0tA/hGb5okyETExuCYNIaTNEjgLpuU0zZs9tKzOCFrNmrAZZVHs2Q7dM2/4xzRWoWIIvLenHGYCQQ4R8GqXW58mgGuQP2FtlDEm7TNJR4ocJVNptbPQboWkUFgIAcu/+YhpWO+1XvQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc11e76-4206-4dc0-5608-08dea0f7b631
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:10.6991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7beYCGPWhtZL3YzpyX0+MtKANlOXUNVFXebtUoXuJ93w8jKUNFiid328Vtiz0NtL8bfW0HyzASuf0iq9ubC1ExTg1WW29DJ8JLQ0xT89BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
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

No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 129 +++++++++++++++++++++++++---------------------=0A=
 1 file changed, 71 insertions(+), 58 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 23167bf96f..7e0b767eb9 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -41,21 +41,23 @@=0A=
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)=0A=
 #define UFRAME_TIMER_NS  (FRAME_TIMER_NS / 8)=0A=
 =0A=
-#define NB_MAXINTRATE    8        // Max rate at which controller issues i=
nts=0A=
-#define BUFF_SIZE        5*4096   // Max bytes to transfer per transaction=
=0A=
-#define MAX_QH           100      // Max allowable queue heads in a chain=
=0A=
+#define NB_MAXINTRATE    8      /* Max rate at which controller issues int=
s */=0A=
+#define BUFF_SIZE        (5 * 4096) /* Max bytes to transfer per transacti=
on */=0A=
+#define MAX_QH           100      /* Max allowable queue heads in a chain =
*/=0A=
 #define MIN_UFR_PER_TICK 24       /* Min frames to process when catching u=
p */=0A=
 #define PERIODIC_ACTIVE  512      /* Micro-frames */=0A=
 =0A=
-/*  Internal periodic / asynchronous schedule state machine states=0A=
+/*=0A=
+ * Internal periodic / asynchronous schedule state machine states=0A=
  */=0A=
 typedef enum {=0A=
     EST_INACTIVE =3D 1000,=0A=
     EST_ACTIVE,=0A=
     EST_EXECUTING,=0A=
     EST_SLEEPING,=0A=
-    /*  The following states are internal to the state machine function=0A=
-    */=0A=
+    /*=0A=
+     * The following states are internal to the state machine function=0A=
+     */=0A=
     EST_WAITLISTHEAD,=0A=
     EST_FETCHENTRY,=0A=
     EST_FETCHQH,=0A=
@@ -71,13 +73,13 @@ typedef enum {=0A=
 /* macros for accessing fields within next link pointer entry */=0A=
 #define NLPTR_GET(x)             ((x) & 0xffffffe0)=0A=
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)=0A=
-#define NLPTR_TBIT(x)            ((x) & 1)  // 1=3Dinvalid, 0=3Dvalid=0A=
+#define NLPTR_TBIT(x)            ((x) & 1)  /* 1=3Dinvalid, 0=3Dvalid */=
=0A=
 =0A=
 /* link pointer types */=0A=
-#define NLPTR_TYPE_ITD           0     // isoc xfer descriptor=0A=
-#define NLPTR_TYPE_QH            1     // queue head=0A=
-#define NLPTR_TYPE_STITD         2     // split xaction, isoc xfer descrip=
tor=0A=
-#define NLPTR_TYPE_FSTN          3     // frame span traversal node=0A=
+#define NLPTR_TYPE_ITD           0     /* isoc xfer descriptor */=0A=
+#define NLPTR_TYPE_QH            1     /* queue head */=0A=
+#define NLPTR_TYPE_STITD         2     /* split xaction, isoc xfer descrip=
tor */=0A=
+#define NLPTR_TYPE_FSTN          3     /* frame span traversal node */=0A=
 =0A=
 #define SET_LAST_RUN_CLOCK(s) \=0A=
     (s)->last_run_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
@@ -88,10 +90,10 @@ typedef enum {=0A=
 =0A=
 #define set_field(data, newval, field) do { \=0A=
     uint32_t val =3D *data; \=0A=
-    val &=3D ~ field##_MASK; \=0A=
+    val &=3D ~field##_MASK; \=0A=
     val |=3D ((newval) << field##_SH) & field##_MASK; \=0A=
     *data =3D val; \=0A=
-    } while(0)=0A=
+    } while (0)=0A=
 =0A=
 static const char *ehci_state_names[] =3D {=0A=
     [EST_INACTIVE]     =3D "INACTIVE",=0A=
@@ -472,8 +474,10 @@ static bool ehci_verify_pid(EHCIQueue *q, EHCIqtd *qtd=
)=0A=
     }=0A=
 }=0A=
 =0A=
-/* Finish executing and writeback a packet outside of the regular=0A=
-   fetchqh -> fetchqtd -> execute -> writeback cycle */=0A=
+/*=0A=
+ * Finish executing and writeback a packet outside of the regular=0A=
+ * fetchqh -> fetchqtd -> execute -> writeback cycle=0A=
+ */=0A=
 static void ehci_writeback_async_complete_packet(EHCIPacket *p)=0A=
 {=0A=
     EHCIQueue *q =3D p->queue;=0A=
@@ -733,7 +737,7 @@ static void ehci_detach(USBPort *port)=0A=
     ehci_queues_rip_device(s, port->dev, 0);=0A=
     ehci_queues_rip_device(s, port->dev, 1);=0A=
 =0A=
-    *portsc &=3D ~(PORTSC_CONNECT|PORTSC_PED|PORTSC_SUSPEND);=0A=
+    *portsc &=3D ~(PORTSC_CONNECT | PORTSC_PED | PORTSC_SUSPEND);=0A=
     *portsc |=3D PORTSC_CSC;=0A=
 =0A=
     ehci_raise_irq(s, USBSTS_PCD);=0A=
@@ -858,7 +862,7 @@ void ehci_reset(void *opaque)=0A=
      * Do the detach before touching portsc, so that it correctly gets sen=
d to=0A=
      * us or to our companion based on PORTSC_POWNER before the reset.=0A=
      */=0A=
-    for(i =3D 0; i < EHCI_PORTS; i++) {=0A=
+    for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         devs[i] =3D s->ports[i].dev;=0A=
         if (devs[i] && devs[i]->attached) {=0A=
             usb_detach(&s->ports[i]);=0A=
@@ -877,7 +881,7 @@ void ehci_reset(void *opaque)=0A=
     s->astate =3D EST_INACTIVE;=0A=
     s->pstate =3D EST_INACTIVE;=0A=
 =0A=
-    for(i =3D 0; i < EHCI_PORTS; i++) {=0A=
+    for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         if (s->companion_ports[i]) {=0A=
             s->portsc[i] =3D PORTSC_POWNER | PORTSC_PPOWER;=0A=
         } else {=0A=
@@ -942,8 +946,9 @@ static void handle_port_owner_write(EHCIState *s, int p=
ort, uint32_t owner)=0A=
     uint32_t *portsc =3D &s->portsc[port];=0A=
     uint32_t orig;=0A=
 =0A=
-    if (s->companion_ports[port] =3D=3D NULL)=0A=
+    if (s->companion_ports[port] =3D=3D NULL) {=0A=
         return;=0A=
+    }=0A=
 =0A=
     owner =3D owner & PORTSC_POWNER;=0A=
     orig  =3D *portsc & PORTSC_POWNER;=0A=
@@ -988,7 +993,7 @@ static void ehci_port_write(void *ptr, hwaddr addr,=0A=
         trace_usb_ehci_port_reset(port, 1);=0A=
     }=0A=
 =0A=
-    if (!(val & PORTSC_PRESET) &&(*portsc & PORTSC_PRESET)) {=0A=
+    if (!(val & PORTSC_PRESET) && (*portsc & PORTSC_PRESET)) {=0A=
         trace_usb_ehci_port_reset(port, 0);=0A=
         if (dev && dev->attached) {=0A=
             usb_port_reset(&s->ports[port]);=0A=
@@ -1065,8 +1070,10 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
         break;=0A=
 =0A=
     case USBSTS:=0A=
-        val &=3D USBSTS_RO_MASK;              // bits 6 through 31 are RO=
=0A=
-        ehci_clear_usbsts(s, val);          // bits 0 through 5 are R/WC=
=0A=
+        /* bits 6 through 31 are RO */=0A=
+        val &=3D USBSTS_RO_MASK;=0A=
+        /* bits 0 through 5 are R/WC */=0A=
+        ehci_clear_usbsts(s, val);=0A=
         val =3D s->usbsts;=0A=
         ehci_update_irq(s);=0A=
         break;=0A=
@@ -1131,8 +1138,7 @@ static void ehci_flush_qh(EHCIQueue *q)=0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
 }=0A=
 =0A=
-// 4.10.2=0A=
-=0A=
+/* 4.10.2 */=0A=
 static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 {=0A=
     EHCIPacket *p =3D QTAILQ_FIRST(&q->packets);=0A=
@@ -1145,8 +1151,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
     assert(p !=3D NULL);=0A=
     assert(p->qtdaddr =3D=3D q->qtdaddr);=0A=
 =0A=
-    // remember values in fields to preserve in qh after overlay=0A=
-=0A=
+    /*  remember values in fields to preserve in qh after overlay */=0A=
     dtoggle =3D q->qh.token & QTD_TOKEN_DTOGGLE;=0A=
     ping    =3D q->qh.token & QTD_TOKEN_PING;=0A=
 =0A=
@@ -1170,7 +1175,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
-        // preserve QH DT bit=0A=
+        /* preserve QH DT bit */=0A=
         q->qh.token &=3D ~QTD_TOKEN_DTOGGLE;=0A=
         q->qh.token |=3D dtoggle;=0A=
     }=0A=
@@ -1397,9 +1402,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
     return 1;=0A=
 }=0A=
 =0A=
-/*  4.7.2=0A=
- */=0A=
-=0A=
+/* 4.7.2 */=0A=
 static int ehci_process_itd(EHCIState *ehci,=0A=
                             EHCIitd *itd,=0A=
                             uint32_t addr)=0A=
@@ -1411,13 +1414,13 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
 =0A=
     ehci->periodic_sched_active =3D PERIODIC_ACTIVE;=0A=
 =0A=
-    dir =3D(itd->bufptr[1] & ITD_BUFPTR_DIRECTION);=0A=
+    dir =3D (itd->bufptr[1] & ITD_BUFPTR_DIRECTION);=0A=
     devaddr =3D get_field(itd->bufptr[0], ITD_BUFPTR_DEVADDR);=0A=
     endp =3D get_field(itd->bufptr[0], ITD_BUFPTR_EP);=0A=
     max =3D get_field(itd->bufptr[1], ITD_BUFPTR_MAXPKT);=0A=
     mult =3D get_field(itd->bufptr[2], ITD_BUFPTR_MULT);=0A=
 =0A=
-    for(i =3D 0; i < 8; i++) {=0A=
+    for (i =3D 0; i < 8; i++) {=0A=
         if (itd->transact[i] & ITD_XACT_ACTIVE) {=0A=
             pg   =3D get_field(itd->transact[i], ITD_XACT_PGSEL);=0A=
             off  =3D itd->transact[i] & ITD_XACT_OFFSET_MASK;=0A=
@@ -1513,8 +1516,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
 }=0A=
 =0A=
 =0A=
-/*  This state is the entry point for asynchronous schedule=0A=
- *  processing.  Entry here constitutes a EHCI start event state (4.8.5)=
=0A=
+/*=0A=
+ * This state is the entry point for asynchronous schedule=0A=
+ * processing.  Entry here constitutes a EHCI start event state (4.8.5)=0A=
  */=0A=
 static int ehci_state_waitlisthead(EHCIState *ehci,  int async)=0A=
 {=0A=
@@ -1531,7 +1535,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     ehci_queues_rip_unused(ehci, async);=0A=
 =0A=
     /*  Find the head of the list (4.9.1.1) */=0A=
-    for(i =3D 0; i < MAX_QH; i++) {=0A=
+    for (i =3D 0; i < MAX_QH; i++) {=0A=
         if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,=0A=
                        sizeof(EHCIqh) >> 2) < 0) {=0A=
             return 0;=0A=
@@ -1564,8 +1568,9 @@ out:=0A=
 }=0A=
 =0A=
 =0A=
-/*  This state is the entry point for periodic schedule processing as=0A=
- *  well as being a continuation state for async processing.=0A=
+/*=0A=
+ * This state is the entry point for periodic schedule processing as=0A=
+ * well as being a continuation state for async processing.=0A=
  */=0A=
 static int ehci_state_fetchentry(EHCIState *ehci, int async)=0A=
 {=0A=
@@ -1674,7 +1679,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
 =0A=
 #if EHCI_DEBUG=0A=
     if (q->qhaddr !=3D q->qh.next) {=0A=
-    DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",=
=0A=
+        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\=
n",=0A=
                q->qhaddr,=0A=
                q->qh.epchar & QH_EPCHAR_H,=0A=
                q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1756,7 +1761,8 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
 /* Section 4.10.2 - paragraph 3 */=0A=
 static int ehci_state_advqueue(EHCIQueue *q)=0A=
 {=0A=
-    /* TO-DO: 4.10.2 - paragraph 2=0A=
+    /*=0A=
+     * TO-DO: 4.10.2 - paragraph 2=0A=
      * if I-bit is set to 1 and QH is not active=0A=
      * go to horizontal QH=0A=
      */=0A=
@@ -1929,8 +1935,10 @@ static int ehci_state_execute(EHCIQueue *q)=0A=
         return -1;=0A=
     }=0A=
 =0A=
-    // TODO verify enough time remains in the uframe as in 4.4.1.1=0A=
-    // TODO write back ptr to async list when done or out of time=0A=
+    /*=0A=
+     * TODO verify enough time remains in the uframe as in 4.4.1.1=0A=
+     * TODO write back ptr to async list when done or out of time=0A=
+     */=0A=
 =0A=
     /* 4.10.3, bottom of page 82, go horizontal on transaction counter =3D=
=3D 0 */=0A=
     if (!q->async && q->transact_ctr =3D=3D 0) {=0A=
@@ -2041,7 +2049,7 @@ static void ehci_advance_state(EHCIState *ehci, int a=
sync)=0A=
     int again;=0A=
 =0A=
     do {=0A=
-        switch(ehci_get_state(ehci, async)) {=0A=
+        switch (ehci_get_state(ehci, async)) {=0A=
         case EST_WAITLISTHEAD:=0A=
             again =3D ehci_state_waitlisthead(ehci, async);=0A=
             break;=0A=
@@ -2120,21 +2128,20 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)=0A=
             ehci_reset(ehci);=0A=
             again =3D 0;=0A=
         }=0A=
-    }=0A=
-    while (again);=0A=
+    } while (again);=0A=
 }=0A=
 =0A=
 static void ehci_advance_async_state(EHCIState *ehci)=0A=
 {=0A=
     const int async =3D 1;=0A=
 =0A=
-    switch(ehci_get_state(ehci, async)) {=0A=
+    switch (ehci_get_state(ehci, async)) {=0A=
     case EST_INACTIVE:=0A=
         if (!ehci_async_enabled(ehci)) {=0A=
             break;=0A=
         }=0A=
         ehci_set_state(ehci, async, EST_ACTIVE);=0A=
-        // No break, fall through to ACTIVE=0A=
+        /* No break, fall through to ACTIVE */=0A=
 =0A=
     case EST_ACTIVE:=0A=
         if (!ehci_async_enabled(ehci)) {=0A=
@@ -2158,7 +2165,8 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
         ehci_set_state(ehci, async, EST_WAITLISTHEAD);=0A=
         ehci_advance_state(ehci, async);=0A=
 =0A=
-        /* If the doorbell is set, the guest wants to make a change to the=
=0A=
+        /*=0A=
+         * If the doorbell is set, the guest wants to make a change to the=
=0A=
          * schedule. The host controller needs to release cached data.=0A=
          * (section 4.8.2)=0A=
          */=0A=
@@ -2185,13 +2193,13 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
 =0A=
-    // 4.6=0A=
+    /* 4.6 */=0A=
 =0A=
-    switch(ehci_get_state(ehci, async)) {=0A=
+    switch (ehci_get_state(ehci, async)) {=0A=
     case EST_INACTIVE:=0A=
         if (!(ehci->frindex & 7) && ehci_periodic_enabled(ehci)) {=0A=
             ehci_set_state(ehci, async, EST_ACTIVE);=0A=
-            // No break, fall through to ACTIVE=0A=
+            /* No break, fall through to ACTIVE */=0A=
         } else=0A=
             break;=0A=
 =0A=
@@ -2215,7 +2223,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
         DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
                 ehci->frindex / 8, list, entry);=0A=
-        ehci_set_fetch_addr(ehci, async,entry);=0A=
+        ehci_set_fetch_addr(ehci, async, entry);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
@@ -2240,7 +2248,8 @@ static void ehci_update_frindex(EHCIState *ehci, int =
uframes)=0A=
         ehci_raise_irq(ehci, USBSTS_FLR);=0A=
     }=0A=
 =0A=
-    /* How many times will frindex roll over 0x4000 with this frame count?=
=0A=
+    /*=0A=
+     * How many times will frindex roll over 0x4000 with this frame count?=
=0A=
      * usbsts_frindex is decremented by 0x4000 on rollover until it reache=
s 0=0A=
      */=0A=
     int rollovers =3D (ehci->frindex + uframes) / 0x4000;=0A=
@@ -2320,8 +2329,9 @@ static void ehci_work_bh(void *opaque)=0A=
         ehci->async_stepdown++;=0A=
     }=0A=
 =0A=
-    /*  Async is not inside loop since it executes everything it can once=
=0A=
-     *  called=0A=
+    /*=0A=
+     * Async is not inside loop since it executes everything it can once=
=0A=
+     * called=0A=
      */=0A=
     if (ehci_async_enabled(ehci) || ehci->astate !=3D EST_INACTIVE) {=0A=
         need_timer++;=0A=
@@ -2339,15 +2349,18 @@ static void ehci_work_bh(void *opaque)=0A=
     }=0A=
 =0A=
     if (need_timer) {=0A=
-        /* If we've raised int, we speed up the timer, so that we quickly=
=0A=
-         * notice any new packets queued up in response */=0A=
+        /*=0A=
+         * If we've raised int, we speed up the timer, so that we quickly=
=0A=
+         * notice any new packets queued up in response=0A=
+         */=0A=
         if (ehci->int_req_by_async && (ehci->usbsts & USBSTS_INT)) {=0A=
             expire_time =3D t_now +=0A=
                 NANOSECONDS_PER_SECOND / (FRAME_TIMER_FREQ * 4);=0A=
             ehci->int_req_by_async =3D false;=0A=
         } else {=0A=
-            expire_time =3D t_now + (NANOSECONDS_PER_SECOND=0A=
-                               * (ehci->async_stepdown+1) / FRAME_TIMER_FR=
EQ);=0A=
+            expire_time =3D t_now=0A=
+                + (NANOSECONDS_PER_SECOND * (ehci->async_stepdown + 1) /=
=0A=
+                   FRAME_TIMER_FREQ);=0A=
         }=0A=
         timer_mod(ehci->frame_timer, expire_time);=0A=
     }=0A=
-- =0A=
2.43.0=0A=

