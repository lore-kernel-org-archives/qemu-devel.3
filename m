Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA8ED7B87
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhY-0003Yt-7p; Tue, 14 Apr 2026 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhS-0003X2-2D; Tue, 14 Apr 2026 04:00:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhM-0005oL-LE; Tue, 14 Apr 2026 04:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esZ4GZqikxOn8U2Di9yPgsDNZZGD/mUyT4xLoaVHIyMQUlKlZWhB8Fkowne6RbhKxQQjqpfJJh1TkGolVjdQJRVqs+hhmyZ3s8eoNRVbdWMduioQmh5ZXUz2R26FpxcpXRwCr0hbi0NaX2rJn12C+NvxiHymvM6LJ5BxbmiMP2KkOw2WY/dfXvO8FAHnIY2T64b1bDo+WGVjrBdSFrAi5OxC/Hg4huZhlk75XeKjb8kJEbGdnRgA05quKLAj0BfQVydwoAOVK1VPhiZdm8Pifsah+iPiQhW5JQkbF83JJcp6mbP6TQcqUVwNzQOrkbHM27J7mVzTWpdqz79m/ntCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+qkXLls/pt40Z1VqrqM0+XkmKAxAHjDWMBW47cohns=;
 b=lTpA8k+hoo8qxizavmA8UAm92b3q1MBxsghrwomXVM805Z0Jer73dBZ00FU3gwdEM3g0x8xnRacZbFcdgbJbl1VKetVz5IuPGZf+6XGsBpmKVI+oxnbqJYu2Mlo+HTcmtUZ4MNSJEIj/DZCq5AwXfxgwYIYRNVY6Zq60/QCNuxhHMDMM3FiiTUBfRQjAO3tn3CdQmaNeqEuHutBEdAqwqK6lGOo6cLZPeql5xViuLhRX1AaEgMYOcRd8fu3slBf0xg5PSAXLQ7WDP5CAufKXoj52HbtpVbAHoEYhaNrsDvWlSR8SR4wCDHv5/VTT3HEjr40ZkPdhHOmAUeisEx0rpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+qkXLls/pt40Z1VqrqM0+XkmKAxAHjDWMBW47cohns=;
 b=McWJvBoJ+BV8XOAP7OO+gITyt/Wf3ffX9MfnhNrVp9x7GnJzYxXWza2e5NstnmDeUKIvsthxe1drnrDkgRodPlpHOAk/+JGyRUdJCISnciOfFTybf0npcHzXT2SPAuOv6A2tWIBCaVxbC9R9Q9vx5N1J4ixw6wWoWC4jUqSoN977m3BUzUbJGoJeldpB/7Ra/Xh+J8zD0WmXRTvGPNlH1C4alnIqLK6mVDrOGkfUhPik6XpMOi7n9IXjiLcD6ozZT04vMSFYR5YipVXVGdr2V0lrxlqP5kIZuWX/539aMkfK1YfXr3JlvRQMG1XjwD36yV43wSFHN0uzqOBJ//5Ung==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn structure
 and dead code
Thread-Topic: [PATCH v2 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Index: AQHcy+TBUiPPKxc1sEqzhE5+L5C51g==
Date: Tue, 14 Apr 2026 08:00:27 +0000
Message-ID: <20260414080025.3005916-2-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6745:EE_
x-ms-office365-filtering-correlation-id: 7f009c84-72c3-45ec-02d3-08de99fbe427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Aak86oRoS53oGy/9YXzmVE25SBQoCzq4b9CmeBMLDwVMdccV1Seqh7e6izxU21M1u+oeJcAU+tDBNsSA1YbAb+qoErqL4uKCnaM4VPiFyhZ+mwYt+pHxSInf1+EIyjDSdusQLAK0oBNYXdhznSb7wjZnDHaM34ar9+Z/43r7dG1akglLshJQ5nPAdI7rGb9aB0ELtBwl8e89Wiq7849KNVACrD/isPBS6BTYb8uVsHqWNE6n1OntZxhsTliP6koRXdWtbb5cRL4fV4QRV7v99CEX1u4dJRwe+2l8xvVr2XLCRSS/lAiynEvgnYczzwTtAZ3nm1hzn0VDh8F6z9Ce6urdwo6utonD9b05axwZdf9ssULN88RuxsZM74U/akXbnRNnQtDjOdywURDEEnGgL7FwtG4XMRDz+rxB1ModZQ6kDAHnQD8ZJFf7rKocVNVX9Kn7suh5D87UeNL/gvgWSCnn0OO/2DoRAGtpH9pZeIF2N+N8OxPAO881LTxJHIolNJYAFnLB+qfhlKOdOS9WO3YjYQTlwRcptXBPZHgLvNApfSQD/gpbOmBpz6SjZoXRidQY+9GLwfIRfF04YkbOKuo/0wyf1uP/NumJW9c4FXT4WAtXKbMQMAhaeIEsMSu6GOqW37LY93C/8XHU5l9vSby/Lz1G8DL6+2TcwQM2RxnoRh2IVjjXoMVb6rzqYLhOO1bbpzXAJKvigLmxRMkg8j9LbtV1N+5FevSFdPh0AXVDLP8I/8rXGTYLWxQyzjHiUSlO945PXsoiesvPJjvDX7pe4UCP0QaRQp4yY+gvdOs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kDdpW5lAKO/fszwQrZxaR3II+TKNl4qnGp3B4D5/UZb48nhjoHd3FeKYpL?=
 =?iso-8859-1?Q?jfdQDBQNRHeYoJPPIGaUcBrMAFSIsHxB5Zx88AVPyqUY3X8PFZYPoGXtPH?=
 =?iso-8859-1?Q?d/4k196CWmBb6KgC+ot3ln/fRXYf51XqCSNaXI0NeeNdYTkHGLWhkVdZf7?=
 =?iso-8859-1?Q?URtPlTMmQoyAR2du/JTCDCsGnP4J24AzBd8Q0uW+mr3MPow3dcZ/diqXlU?=
 =?iso-8859-1?Q?lwTytKBd8vwryoaK3Zy/Q8ZBGWRd0IAwcKD+v4lRbdP7ZNJfqkFJ2h3JGz?=
 =?iso-8859-1?Q?yfRGyK37fufipU7TdB0kKgyBeQiO1dWxVV4FmysJSFPzw+MCkFq6dc7yLR?=
 =?iso-8859-1?Q?UAs/M6vwaWvBuiqHvVkamSR4dw98Q0/Z1mEAuwL9KUVy5V7WEQGxG+FhTl?=
 =?iso-8859-1?Q?Gq8e+NbbbYcO4mIX8cie4EX6ISa30oPfMbZPK47gVVjsInoQCQTm9+H4Ie?=
 =?iso-8859-1?Q?AooYFGOIs+5geaMs0GayTGDFJ60iWslmfpGwIOM+Gw+n+7PFqfWutzUlRe?=
 =?iso-8859-1?Q?PESiM0N82rRWBXheUK1REKVo9DG5obiL5A8pz0Tn2kxjtoyYW1OmvHhurS?=
 =?iso-8859-1?Q?uT9CHSxIsQPcac7ToPjvA0FEAZGtlhMiFgsCgqHCd//S5Xo6HZ7odTSVbs?=
 =?iso-8859-1?Q?wNQ0cB/kQCLZKOwDWbfPW16h/mf40Mv/bvZmg8HQ7gZ6vBcC5TBDURQAOo?=
 =?iso-8859-1?Q?x/9Tv7Q3Vs2+HUuKNqJEdho90RV9ldnLRmvbsK8lSW37u0SF2POu5IgHR/?=
 =?iso-8859-1?Q?1GtUnyoPHTk1EOh0Gm3pH9f5SVqqLbKznKIFwVYYYVdjT1iUt3utbx/UTa?=
 =?iso-8859-1?Q?sPeyETLC81JfPHbsELYYziSj6ApdMHYo2ihGuLtQvuahFtT1UNZiODe484?=
 =?iso-8859-1?Q?0mFfjQBr5qkoOFqKk8Etpq/qL6gSZEg3MqVXyhWDBSUsdhVwGLfCx4fvOi?=
 =?iso-8859-1?Q?SVpC/4+9WRs6/pwAT4SSry0Frpulb62fOJAnGj6UbpYPVriJvNS3OSzlUX?=
 =?iso-8859-1?Q?q2sP6JEZQEmxBibRJ4OnigRL6Ta2//awP9MXQoMXF5bslRSd4Bmr0GKVZY?=
 =?iso-8859-1?Q?gvO7WCBVN1F1gayQb6on0AzTHRZCVEehXgjdZF7jrG+Wf8RCJxlU4DGjau?=
 =?iso-8859-1?Q?ZidHeKaqenKOp3rjf8U2M4gPCxEEc/gn4hOXx4Jhb4+xWBlKsmR+k0E5WW?=
 =?iso-8859-1?Q?LSbRUHP0W+pWWLJuF5iVrCnY/WD6Ua7w+MzAAacWvxo4hADJ/VbmHnbAQR?=
 =?iso-8859-1?Q?t83LrIs1jmtpb7YZ6RX9mqNEeUWWZY6aiIL1J2HYyZHAECgDf5iHRMgIC3?=
 =?iso-8859-1?Q?UZO7YD6+Yx/TRhoScEAJDK73Oa5V2GzRBxo+gJGmeS5JK39F1FisDKAhcB?=
 =?iso-8859-1?Q?Y8kH4/H24g8gI84KvMp+Go1ioiQwYVRVYiK/Y/UgMjpF0WCAuFebCw07bM?=
 =?iso-8859-1?Q?3mmnCNVTB53mW/YO08k13BnRCvOK/X3rjrbUapUGWuuVw0JhJ8ZvBsR7cv?=
 =?iso-8859-1?Q?50ep0IvCkim81A1cA0Q3mlM2Ndl5sdwIHrpBQKaQoaCol8rRnpHqNqAH7W?=
 =?iso-8859-1?Q?Tqm++TxrHtNOOKvwjl1M/pwT9Xs8yWdclQK7l2sJUZcBbhFuDj3ES+80Z0?=
 =?iso-8859-1?Q?2kcZp6VYo4jFsrYHrvR01MlPt+OYfdV/4LFJF7wFFjuUGsqyfDZpt2vPLG?=
 =?iso-8859-1?Q?mLCLq6uaCorkZB7ujf7x/tb+8a4cJPFd8MH2HjddrSW8I+YhpfmAv+r7Z3?=
 =?iso-8859-1?Q?TrudqBOUc751i1mumKY/bh40f4c/LWC/etj77MwOqPv/IS1yyWrEu/LTp4?=
 =?iso-8859-1?Q?fPnVLHZ5Rg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: czZXOIbOvmTKIwVXOXB5zF6MjCqBSgc78aK8Dkpl40qhYsjY5eK/a5upz0jUCcIrLhBRoKb4DC8e/oYpCkUO04kOnUengJTRYdLUTg+OGJQlFLYm2g18dKmMaPrR9JtSGbPIu52qe5XLm+SkUfctOilwGg1/OlcIbGVajN0IS5G5gVdVjb8pVNieYrL/lr5LoKoMXeDDfD83XQrDdxtrmLwP9MqgYkyda0tSWq9y8AzSjZ3keaVTdrv2Wx+YYUlfWrJYa1grNGe0g5tQvxGh1IWaS6Rxiz54FZ9AV9GqPhPHOXjol6NmlZ3Gec0IfxpjxSNHBHb3rmkUwZYqjA6aBw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f009c84-72c3-45ec-02d3-08de99fbe427
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:27.6149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBp4j80pb2Ez1UYtqkidiaii7XrKCfPNY6r0CK2cnKQ8dL9MX00gJkBXpBYHiMrtGMQvr2F54IZuwxYsdicz8wGg2YCiYg+7PrOKiMJ580s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6745
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

The EHCIfstn structure, defined according to EHCI spec section 3.7,=0A=
is currently unused in the EHCI implementation. Remove it to reduce=0A=
unused code and improve maintainability.=0A=
=0A=
Additionally, drop a block of disabled (#if 0) code in=0A=
ehci_state_advqueue() that was never implemented. This code path=0A=
is incomplete and has no functional impact.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  7 -------=0A=
 hw/usb/hcd-ehci.c | 11 -----------=0A=
 2 files changed, 18 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 0ae8c06331..3aec0e047c 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -202,13 +202,6 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
 } EHCIqh;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.7=0A=
- */=0A=
-typedef struct EHCIfstn {=0A=
-    uint32_t next;                    /* Standard next link pointer */=0A=
-    uint32_t backptr;                 /* Standard next link pointer */=0A=
-} EHCIfstn;=0A=
-=0A=
 enum async_state {=0A=
     EHCI_ASYNC_NONE =3D 0,=0A=
     EHCI_ASYNC_INITIALIZED,=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 57f930b099..5ea8461f70 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1756,17 +1756,6 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int=
 async)=0A=
 /* Section 4.10.2 - paragraph 3 */=0A=
 static int ehci_state_advqueue(EHCIQueue *q)=0A=
 {=0A=
-#if 0=0A=
-    /* TO-DO: 4.10.2 - paragraph 2=0A=
-     * if I-bit is set to 1 and QH is not active=0A=
-     * go to horizontal QH=0A=
-     */=0A=
-    if (I-bit set) {=0A=
-        ehci_set_state(ehci, async, EST_HORIZONTALQH);=0A=
-        goto out;=0A=
-    }=0A=
-#endif=0A=
-=0A=
     /*=0A=
      * want data and alt-next qTD is valid=0A=
      */=0A=
-- =0A=
2.43.0=0A=

