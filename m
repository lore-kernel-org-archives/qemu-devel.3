Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB014EB28C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETo-0003b7-Oy; Fri, 06 Feb 2026 00:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETl-0003Zu-BS; Fri, 06 Feb 2026 00:34:05 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETj-0007WD-Ln; Fri, 06 Feb 2026 00:34:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQlt1R1CgYpH+Xg1yCDkLCLkJx3q8pt4r//2MW3ZfrKwe/pbntf0LTae6PS+6TOH6GGnXNUmGinsXbeb/A1FiQeZVLhljLlNPIr24SHZrE07odL4GU/9WHcsV1yJTlkZkzR40cyXk3EL4sR7cwuN1JAUvOLK6HsMv4wf1Wj7wmEiffr/8PvtNVRRBIUtA5Bo67viEwbHoQMLl/D2GPtuoKwQdebP5k6fyNIAwI/T5cFAcVfC+bZiSdSlrDldQMuDhAz7DTb6Qx10Q82FjmBCjuJeBQcqN0JFo6FTTT1caDwWd47vzAeWr+c49JMxqScMU5tD3NehpFy/zVmafn6P1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kSCsiwfPzaYPDN3Zmv7kOGOdaeofZH/ejj/is6IrzA=;
 b=NI8ki/+vDLDsj1nF3PsT1LgtazuVxRzCR7cppPxCJtaXms48Q4WwcBinP41l4ylIOt0z+bvs6dSQMk6Yh/zvE2S72c4ieuqs5KLDwkLHauNBOpAYBqNJ8OOSYPps9GdCyNxlejhVEYpI+IGg3WZAjngm+FGc0bD8rP5I1OE5fxSeVZrDCPMnF2lqeg3uO1aT+5S6Ad22reGIBbR8U1Lm3jtfXDhp1NO9oVG0e+dH+U1Nryqn/WuqwvNE7383st8zb6LiE4Z+emYZuWHqjt7y5B0ZxAf8zYcXyG/9XnJy7nJmC7W/iz2Qv5snytlUDWtvgSlXxty3nuShVz65UI/bZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kSCsiwfPzaYPDN3Zmv7kOGOdaeofZH/ejj/is6IrzA=;
 b=p3e0Z6iogtjWZe7OiX/gKU/F/HWuhILROFSigveQag3MmY9o9pMNMfnA57By7okcQHuuqNtuOlTRzrA3JR/nZauGRNeFfr7RXNDDebBswCNZUIGapAebP7NYJKFf2ii1qx0G7AuDYmP2q/onCc4g1JWgXBgMr0b12WoTifRbsl0ozCvDcbXDJsCwMfpMh8Dm6J73RXDlFwQSiURjOcVPxsqsoae0HhPreVnrSVXUX4KAcHo+LN93F26nJRbhJgMaap7hgnggbnqAkuwygqW0Z3HpF/OxGmoPdogNeoEzbVzW+zmGWb2dCEUqMeovsCxtRnSDUdi/ISjnjAel5VnyrA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:52 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700: Add
 AST2700 A2 EVB functional tests
Thread-Topic: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700:
 Add AST2700 A2 EVB functional tests
Thread-Index: AQHclyotTMSkhEzxh02MKNnGkZXEgg==
Date: Fri, 6 Feb 2026 05:33:52 +0000
Message-ID: <20260206053340.3716041-10-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7165:EE_
x-ms-office365-filtering-correlation-id: a17768ab-0272-4ada-afa4-08de65415039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gjRIZosXOumvfEZ3tzRqN91IsmWwtvF2al5U9Waf1jZ63JLz3wflpqZZ5Z?=
 =?iso-8859-1?Q?VuPpyDTcrIZr6FWdfPQ8+gAoBkUnKt/l8/+cmyCFAaUkjpqzNYDK3ZJ79D?=
 =?iso-8859-1?Q?t27yjvdrwnEgAI5ksaBczg2yeKqdBLr1tPq6iMcpQfhKndiUQ0OepfE5AK?=
 =?iso-8859-1?Q?BsbMYPPYyTUeVjobL/xwdtrc/QRsMgTQtc178ZWtt6TT42KdpYnYgeplhy?=
 =?iso-8859-1?Q?R34GCORZFgwKD3h1IwXABAyEvZxS47d2pekuwf3tGmcRqPkupIO9xd3/OP?=
 =?iso-8859-1?Q?SAZabAC/xVjkt81pXU4zjKjvPNEoNq08BiV9tcpA4fA/Hz/SKScwBXrUoB?=
 =?iso-8859-1?Q?+/MLyk+tPDx6PNa6KkSs+jfBzOP8GcvPCpqBpIXwztxdUaDKI9qC9/A+Kk?=
 =?iso-8859-1?Q?+Ppc9pczVD0q5S4mchp17/pThUr3msLoSarG8NIyH9o7v50w5zuXzEMjTy?=
 =?iso-8859-1?Q?jP36YB2FSkpkVy2wEIteqISWpoeWedveZnXPxh81CnKyp+ecKV65ANoQp0?=
 =?iso-8859-1?Q?51tPx+yp0oqAz7w3mGQTqGmaNYAvTvySZIO01mMgBntJupb3gSvdbOGU+O?=
 =?iso-8859-1?Q?o/D9xi6IbhMjtgCax34qnR9ZvtbDwnvtH7+whHEZXQf5hsVv6/rxoWU7CJ?=
 =?iso-8859-1?Q?4X6SycNkfUbQ39qJBCiFr/uxQOUl5s3eH5dOQxZF+XrVQKCfI4Ca7hOWZA?=
 =?iso-8859-1?Q?hAW4vMnt2tiqq+xN4IkLu/FFTOvCyotUFjYLTW4USGrZo9zXkqHNLj0DTR?=
 =?iso-8859-1?Q?kgzRyuKSAl2yZgmjFCnI6mK0jghedz+G7zMf9r/RCIlP0TtRheUd3E51dE?=
 =?iso-8859-1?Q?mZZgpk3buvKKdpO0vGhmSI+ZS9b0JEwhsGj8taJX3EaP60LbC5HK2ATBI3?=
 =?iso-8859-1?Q?BLJYxydEs3bhtoDnSj2/qNnqtuTmQ4yA5dnpdScVGi+Bs4XcRsAnzeJBqE?=
 =?iso-8859-1?Q?o4lANNNUw/iZL6CcMNnWywlLLIhQNU9/fhnsh1fXby0smqh3zZAvJoqlSK?=
 =?iso-8859-1?Q?I1FoUhh7BgNUGk3F/L4H4DnSR6OuHC/toBzNRKo0cuyK66TIS7AfD3oa5X?=
 =?iso-8859-1?Q?1IE6mhI1ejg/yd2udWUx9KxeAX7yCLUT7zHhijRDVQkkwJGwQKM3Wx4cwu?=
 =?iso-8859-1?Q?1ryOMOgryg+bqORYoy+Uqd9qSUoERwqyZls3wpBdjpBOHY5R2nazaNojSr?=
 =?iso-8859-1?Q?5MEP434DbuGQUJ8agFvx+PfWynqJsga+Rd9klDxJGd7gRyRtH/JtMTQm3T?=
 =?iso-8859-1?Q?+W5DePN7NYyBV3fIfKCrVYKEResR1yBhy1DlQctlHplgJn/mdfMDbHw+zA?=
 =?iso-8859-1?Q?7WcsjNjWNg4aNvwMDgyulmuSX1YjCq/oHk+dpJcfGApQ6bWNSME5+Vr2X0?=
 =?iso-8859-1?Q?ZRIn0VVp85NaM0eLRGpCQ3+YSn/9D+3l/UTGpVXFIE60VbF5utHfP5LskV?=
 =?iso-8859-1?Q?4I85NRbR4LmOfarcG2wOqWNB+vrQn8aMcrPGpPp9Kt9D4Mi+UMCVP4wRsA?=
 =?iso-8859-1?Q?Y3J2UZx0oenGx2kJ0I4SboAUiEUOdpljpFiewtJ+dSaYEY3FwaAPEBWzPO?=
 =?iso-8859-1?Q?Nk9883qqOajZc8pudJGflu9mOJaIXTD4UcmL8kOQ/AZm0CEx4qYzWwsRMU?=
 =?iso-8859-1?Q?OC1XA3ntQ6pmOaziCORCEbnpq0b91CW5t4q6cSxEkZruTXik6oq/x5uA?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pAyJnbs5J4RYK1Rux6ZI5sDfJU/FQTwyHy5enZRM4EuZ75fblB6vvRg0BS?=
 =?iso-8859-1?Q?ETyGRqepkdU8cy93vgNkLO0tWT66u1Yt28bEzcpwjCskv7OyFDN6th64I5?=
 =?iso-8859-1?Q?0K6cXDlX6oyB8HG7beXtPgTu6+lqGjYi34BEVmbZFg8aZKJeocTGiZvODe?=
 =?iso-8859-1?Q?Bw3gZbxguB+vA37MWHwY0L51J4/YQEEdYTRH5dl2Stjlf7jhAoYonWo/ay?=
 =?iso-8859-1?Q?i+AiST6lgP5xLQyZlBVyWnml9pN8oOxHj9L8dy35w3V8iyolkaxa8ao9aE?=
 =?iso-8859-1?Q?MeMrUTsu9qjvd0ZrfNgBJNs0lZd5fd9a6I8S1y3MCJJdvA7HU9eFR2yRmK?=
 =?iso-8859-1?Q?v74Ei+cdYoKhRyaKQ3L5qC+H8/FxS//sAUI800DMePd0tOhl7u/k0BK1Jc?=
 =?iso-8859-1?Q?GoJwFdfip1A7iaa0toIhXlGikynnC4vv6SoeEZK7ecLlRGeVfJGbMgl7NT?=
 =?iso-8859-1?Q?ZbScYrKguhdEuzjvNOuBDB/IGCsufxpaDDScvbWvp0+vuecbkU/c2vnNW0?=
 =?iso-8859-1?Q?U74riWVDol2I4ddE9NutVquzKYFpXM9ZPm4JG2RFIladmoz5E99qRgb2wJ?=
 =?iso-8859-1?Q?0SQl5XypUfCVLxWeFNEinTOvKqfIiDhGCTeqptIAtAihql522G66dmwkSh?=
 =?iso-8859-1?Q?+5vPaNHT0lTvPuQz67Tlbk/hE2KOVCXolFLZBsMH1G7/7RqeinAuXdc1H8?=
 =?iso-8859-1?Q?hxDsS/EEwhTOsMCLri9EPP1TxuTyA/UWttYFWh4jMunBKhF86Unrth6qyO?=
 =?iso-8859-1?Q?7qM1MUyCoHTRCFDTgpb5i9lr7eMmefCh7WOPzjIB4YzdH07eMFRk/eokqJ?=
 =?iso-8859-1?Q?6Bst3wk7K7BY/oR42VHJJNBB/k/ikD5ogm0GiBD6ocAyHqlYxDX7lmcFkD?=
 =?iso-8859-1?Q?WLFw6GtDA0hzaonQoYY660yhNMpPGutBHnyTlcTsH+hmlnoLAkf7v5jt8I?=
 =?iso-8859-1?Q?kiQUR0XhL9FJn7Xc3RTEBIiVi8n5ecfQtqfV2P6kiyeKZoh7f4mUiotJtn?=
 =?iso-8859-1?Q?QvFtViLlf86XI/zPxIY9VLIbOIbHiE9TSntuzvGpzkM8qAtH3FrFIVsyfs?=
 =?iso-8859-1?Q?BzVtvsljML0AFgpShDU1748mOfTCDagUxj1y5+KJFrNgC1XChzQXnqT7aA?=
 =?iso-8859-1?Q?IVDu+CRs9D+UhSXuEqOBGQ+eOr5kkrOY46SfOSpmoihUQybvyD9Zs1CmLG?=
 =?iso-8859-1?Q?bESYKz1YFSTr/ULa6uGKPXIXnxJ5Cy17YfkfbRXJhqfE7ywrOjiJmX8Gt/?=
 =?iso-8859-1?Q?ssVRtw9ditvibhCtdErCtlgNGEvC6XRr7/W8HpTqNQZVimcOoGXv17f8Qd?=
 =?iso-8859-1?Q?gzRfHdkYji+2pjN63RApO9MVZwnTcfOhyARO3K0mvyAAzRXSr+wzE9A+6f?=
 =?iso-8859-1?Q?AvFZtSzIkzYY41Qn1NWQ4PYf85BUoDa+oaf0VlcfGknYmjFVqGg1wOZuwq?=
 =?iso-8859-1?Q?axHuCEgg7zgP4/VimkEY/G4WVCny0BnvemN+ekr758FZN5ZC4xbD2ONkYP?=
 =?iso-8859-1?Q?/oVnA2xXtx7U+PzSF7RsLvYdpTT+/WuVpgCoK/IDw6TJTeQWvFTkXPR+hD?=
 =?iso-8859-1?Q?Ub4gPj6YW2cRb8AKi625QhHxwzc3eGMGeSdMxn4ZodhefJfeNRCao0BxqB?=
 =?iso-8859-1?Q?cEGK/UIB7EtMPeK+G4quZBJpHXKD11a1WFZoSI8ySq8/9qrEw+YJ6MHx13?=
 =?iso-8859-1?Q?T/stH0KNmWArusk62d616dJqw60hLUNEExg6921Vk7YZ/yVoO+lku7JOrI?=
 =?iso-8859-1?Q?qzzhUnkCiY9wv994VAC03nVJ/adDOiSYCG/ixjEivHaHyEMRZ4JqpvfYSJ?=
 =?iso-8859-1?Q?rSLfaiy4ew=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17768ab-0272-4ada-afa4-08de65415039
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:52.5613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z069rakS+ymFV4SLQlftiOhw9F+s1JXbvV5nLgbC0Ekfva/QCml8XefizjWmCAMtPqlVplHIsSaxfl1EzMqo8dsNJm5kpsM4/u1Xn4idlBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Add functional coverage for the AST2700 A2 EVB machine by introducing=0A=
test cases that boot and validate an OpenBMC SDK v11.00 image on=0A=
"ast2700a2-evb".=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 44 +++++++++++++++++++=0A=
 1 file changed, 44 insertions(+)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index 61373ffe5b..68e930ab72 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -86,6 +86,14 @@ def verify_openbmc_boot_and_login(self, name, enable_pci=
e=3DTrue):=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-dcscm-obmc.tar.gz',=0A=
             '4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd55=
87f')=0A=
 =0A=
+    ASSET_SDK_V1100_AST2700A2 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
+=0A=
+    ASSET_SDK_V1100_AST2700A2_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-dcscm-obmc.tar.gz',=0A=
+            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb0=
2d0')=0A=
+=0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -159,6 +167,18 @@ def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
+    def test_aarch64_ast2700a2_evb_sdk_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
+        self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.start_ast2700_test('ast2700-default', 1)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.do_ast2700_i2c_test(1)=0A=
+        self.do_ast2700_pcie_test()=0A=
+=0A=
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
@@ -170,6 +190,17 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(sel=
f):=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
+    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
+        self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.start_ast2700_test_vbootrom('ast2700-default', 1)=0A=
+        self.verify_vbootrom_firmware_flow()=0A=
+        self.verify_openbmc_boot_start()=0A=
+=0A=
     def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
@@ -183,5 +214,18 @@ def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):=0A=
         self.do_ast2700_i2c_test(8)=0A=
         self.do_ast2700_i2c_test(16)=0A=
 =0A=
+    def test_aarch64_ast2700a2_evb_ioexp_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2_DCSCM)=0A=
+        self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')=0A=
+        self.vm.add_args('-device',=0A=
+                         'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
+        self.start_ast2700_test('ast2700-dcscm', 8)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-dcscm', False)=0A=
+        self.do_ast2700_i2c_test(8)=0A=
+        self.do_ast2700_i2c_test(16)=0A=
+=0A=
 if __name__ =3D=3D '__main__':=0A=
     QemuSystemTest.main()=0A=
-- =0A=
2.43.0=0A=

