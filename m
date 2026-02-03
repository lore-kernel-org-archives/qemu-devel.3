Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D46E7317E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e8-0003Vl-6j; Mon, 02 Feb 2026 20:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5du-0003N9-1d; Mon, 02 Feb 2026 20:55:50 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5ds-0007rl-BM; Mon, 02 Feb 2026 20:55:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSC8VWf4hE617JAym19ep52OJeW1XpVhi3pPSwkEmv3+qlk+fRx+5rmo6joAuEPvOoMnyxeinAYiSFasDbuaJLH1tqheFw2WE+zDA6LdfUqzY7VDe5cUp6zgINtg1OzI743fA4Lsa0U3HF4ywbXhvW2p+wzRVebu5447n2f2gJq8gNOqn40+qjCotPKyjIxvkNo9KYEHKHekU13sk5/8R7gA8VC2bYK+0riMASsBgN4EQwiBG53T8INkE8TYQeI2X9rJiAyLBw8A96bdJA156MIzYkj2uUiZr797c3oDgPmnEwN7nA8/VtkQ+F4wh+UE3UiNgje2tAM0OvWnnSNA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+3JL5epuvbaOiTTDF3RUP2RfcPBV1uAvzIvAjXrh3s=;
 b=xp6+1HSvevCqIc8eWr9P69k8SBpzEMWwFQF28b/3dI5DxP6caYagCFAHkZUOo5Hku0ZNO4ClHKiGol6oLi4kXO2bfzigGTAucswEm4ui0Ze2L+VAaw4VOKabMqYvIx/Yd4lz6c+COAUR9muGcbEVdoyE5NgHdhjudnwV3Uw0QtHihT6i7G5lQUooxcJ73Q1Lv3R85tjM0vevc8+gQftjtroo2IPfL+lbG/QStkZwsTVP6ho+PSGJxuGLVYxdr4y8cgIQH0QC0JOK1JXEwySgRPKZl4NQ14Cas/VZwgYjFydszCACDGTd/Vfzp0HOixIi5jOSOw3KvY/IRzRY319Eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+3JL5epuvbaOiTTDF3RUP2RfcPBV1uAvzIvAjXrh3s=;
 b=ertpHdFKIS2SjuNsXlBMfsqkmWJQB+YHQg+bU+k6cLQKKqbV01sojzArfuHZOj+oN4iLNsbyrRdY7XwQe43CsAZC62uTpoC6tBdLolyVACa+X+HarLN8OUMkzgB3lpvCZD3qtk+TmpXOr1ZS0u9nFpIxjkhQw7y+NrfQBlTpD1apum6o5uSIJ2g+hXr/8v4/rpvuCWZIGbP3AN1ta9DvX8e2ABqGk5H+OB4sPxCgfc6l2lPinqBVmbswKe4qYrpbFSXuB8Em9y71gIJu0Io3Qc4N3KDKSFZ15Xlnk6HSt8K5LnVA7GjIrQdXINN6vMoRDiDeI84EvarcHztX/5c5Ww==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 6/8] tests/functional/aarch64/test_aspeed_ast2700: Update
 test ASPEED SDK v11.00 for A1
Thread-Topic: [PATCH v2 6/8] tests/functional/aarch64/test_aspeed_ast2700:
 Update test ASPEED SDK v11.00 for A1
Thread-Index: AQHclLAw+yo2N3f+rUqgF1DaG8JEBQ==
Date: Tue, 3 Feb 2026 01:55:35 +0000
Message-ID: <TYPPR06MB82062FF44138D2F1EA26F4A8FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: 2a332253-1dcd-41ee-1c7d-08de62c752ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7142099003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Vcqsree74ypdO3TghIlgUtykd1PS4bKRbyqOf+UrXw7WyLh73t0TprR5GgV5?=
 =?us-ascii?Q?KsU734QzM0JMq5b2depreIVtZusxirr3Wui23qrfZbyQGYRJdOcSehMyCqrj?=
 =?us-ascii?Q?PKQ8AUp7dD3XgLeFma0MkCHVFr//w5r3F+mvShSVh8MvkuIwh7+ERfvKDVzZ?=
 =?us-ascii?Q?mAUsvpCRIoxfWXSHskC0h3iFcCTMyU0JaAAtEwShyBpIyTp/rJDKzBXOKHgT?=
 =?us-ascii?Q?ZduT+veWIuHtYz1AUNPz9j5gh5nwilBVjyjYc8kwDjhGoPKHp/TnKF7s3y2x?=
 =?us-ascii?Q?F92KWfUJpsOmztZ2o5I/d3gYDzSOyAb47TKb4y++tiWVFA2MjTpYORkxtqBC?=
 =?us-ascii?Q?LVsy6goJguslolHwXkPxeW9F9Ug2LdyY83TnArtWHxaAbFTQEYifLMZOBvuM?=
 =?us-ascii?Q?F3p2Hxe/AnPNpQmjO79bOvY90ddXt+db0Zg7FuMOnSBSGrXuKA52CuQX/CSC?=
 =?us-ascii?Q?cbnTC9qpb6QgR2S0sI2/ZVPW8cHsMh/O2HY6sStdHusB+qoPgNHE8NwmRFqU?=
 =?us-ascii?Q?qw1AmlhUiVldV8XiFUYhOEGgjZig3A0u7jTuiPPUXxB8AZst4JaF/MkolMbe?=
 =?us-ascii?Q?mrpa9ec+42F9vuoRXOuQp/Y3IGWvZLIx+hrMzVxrKr3OFMrSKVcAm4ZNKGxZ?=
 =?us-ascii?Q?Yj6bQAt7FgWIPBMeXm4idwlSamzRg4dfeSfKhr3G0iOEAYjXIqWEBXKUJIlK?=
 =?us-ascii?Q?WpuF5DwCjihMNI+Hgp8bjXJGYyE5EmpKFtK63xQQs0mpUWYGGsXaUwezIa70?=
 =?us-ascii?Q?eCYPlcLLPdMaYCEmcGDRjE+KKg3mP6GYOJ0EfobR8/ZPnTC8vNiSWeTi2RjY?=
 =?us-ascii?Q?9gG9FZCnYoNvBAieYI6K1iHRSmcGhUKNzg62e/GOobZ5v9SnT0bhjHNtBpid?=
 =?us-ascii?Q?SDWJ+I8rWX3FbwoDaomUPjZFx+4/rPmYiwcVqvqTOmB0B5ZkgzV7wzyxh19u?=
 =?us-ascii?Q?mRokX29pXfW+JGTZMK6zz/h+6moN1Gx3PkPGkiWNgVLCxlrxHHOodPQZpANt?=
 =?us-ascii?Q?OTdlDpuaz0xssO/ZqzvVtx1hyuphPpjAvlOZV1u8Oxq2WQOTOoCxMg3/XCCO?=
 =?us-ascii?Q?Vif/4kyCqoIPxp6iN9bDjiCU7+q1nAo/WMMskweeEHubQQOzSKspryiucQeF?=
 =?us-ascii?Q?n5p7Pznwg0apGKbIQXb04uIGsZUhAjTNewm0MfMwOWr6MlRuYNnE1tBENlql?=
 =?us-ascii?Q?DnSLe7mwGfTQwljbbU5A3V9xHDF5TWRKp+Q+TFsUyRtdx3k5CsMOitfkzbdK?=
 =?us-ascii?Q?Pw2LU6dCQeBN1T5o4YsCKClfKZL3e+8R6CAxbAAXfQEJD0i+yc3/B+1tqGBK?=
 =?us-ascii?Q?hIKYVHusq2lsWnXGTN2TjYAje1IE2EGVNuZQYukOVuxIljNkQhRLOJ68OIjc?=
 =?us-ascii?Q?k6F8z4Tp1vGnSVwDN51FIu1ajaX3UyEAOUGVDAcYQg4sx44PbjsphoGvH00T?=
 =?us-ascii?Q?2IGRzwqqXNdVPyrYp75GWLwOiCBRtBiUnyJfFWbsrRDFFyDnMAm5i6Snm96c?=
 =?us-ascii?Q?CsgGmtRLeD5UqWfIxQ0lU9JpziLSYUQMO3CjgMWHd/B9k6SsvH8h9E2gdMBt?=
 =?us-ascii?Q?wT7Q/Om+YRAtlbN9qTTx2YYL0U8/YBG9XDzWWs0Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7142099003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1C3MTFVmNQoRSbzazMgMfiUh9eTwh2EA/AABqyHxc1CTqxTqIORJAV0lNAN2?=
 =?us-ascii?Q?TfWJFaCD6p40te7eOag3AmCSWsUMyyGouagfbZHalwfDBCoJKitwZ18LABfc?=
 =?us-ascii?Q?1c1Ucl4kN/Go2xJcOYyVjnaLdOB3tWxRUlffohUkKuyu2P4FClyqYqLBuKCa?=
 =?us-ascii?Q?kw0RWTbOGWbVhkxYHLsqxEibF1ZUNZoyfQwQRXof+AtT4/tSCkpfO5k6oqWf?=
 =?us-ascii?Q?mpUAhAEDhhxBVJhjPnTEgpW2TVLzDUjweqZGQzD04uIN+nQFw9CkKzHsiOxF?=
 =?us-ascii?Q?zAfhs986dxijK6nUN8hGD6DnvC+WRyLuGuNKtLhkUYB1iaHKiT5VzPx6WqiT?=
 =?us-ascii?Q?5ENUdCuFcJHIqTDCf5CK6JuUDyBKNH6hOq5x6W9b++h3zo81YkqeYYUwjXBM?=
 =?us-ascii?Q?r3F9erUtXHeELnFBDgvNHQdQKNMSglZrsPlSms8sDAIJLZ4tumkF0cFnsi0S?=
 =?us-ascii?Q?KRMqQ7OKW+2ug5Jt94ffLfoYNwYwpCWVkZd0sBZo3Tf0HUcQxO5XwO6vujQD?=
 =?us-ascii?Q?TeK22DTWd1tfrSU7lUkYyf9oaiE1dslUM3+bZg8YCMj+zeDUTeXvssysVe9y?=
 =?us-ascii?Q?TblG4wCImpNsku2GIdN4JaJBaULhvyQHHJGdGqnmXmgp1ptMUrjJBdwMth14?=
 =?us-ascii?Q?MKrJGe29DuAFzR/z+EV+YtAPL6egbQq7QzxkQ6xTPTEpyZTlI/gnytgh/lX/?=
 =?us-ascii?Q?fojlOdM6i+Ip9gVC98CMAr9uEq+8SpsdisdZ11FSWFb7HbahorQtQ19R9Mhj?=
 =?us-ascii?Q?hgHy5tS7HOE1+1SJptSaGp6VC3MtEr5dJ0RmXsYTRFXEyH5hyjDR7VvIyZpy?=
 =?us-ascii?Q?GlFq47PvA9lM9qyW9dkyC0vBCMz11R/8HTWm3WCK9UCqObzLdWU5O77IvOON?=
 =?us-ascii?Q?PBZcdM1owumKPIbIgGgfBxtdRQ34/C6uHUE5pdgUPz0KyyGeVVA02zY7Ouqk?=
 =?us-ascii?Q?U0l7VecldPe/X9XmGy7GnfZUInJk4h3+dWccph5NEAQMsw8mOr0lRiG3KxtD?=
 =?us-ascii?Q?Qh8/1C3zRoHS8BghesEuzt4ZK7qbjuUzcGdrLjA3I/Ecu51rmzrHOsvb6TXG?=
 =?us-ascii?Q?FeS5k6htNzeBsEX2L+t7Wjuf0sIl1PYYsp/7xfHfmSiZQD0UMwaN+aLMGfEH?=
 =?us-ascii?Q?ibQccFTKikGLs1nF2Uheaq6xrUbgAWn20E02YCR5LYSCG6ctpa7PjIiQ2D8O?=
 =?us-ascii?Q?D43Gu40WpoylvhAH3eAUFQcQH1HqYVs8ZQetEO/EctQVzna/V3uWg9q3mFjM?=
 =?us-ascii?Q?cmA73RmwGoAVPLV9ijGWkiU5uPdK3+LcpVg4YtLDasRgbmFP2LGgAI+4O3Jk?=
 =?us-ascii?Q?0w08r7qtfy7UjvZp2zoiSjcflTIY18ZZjs548h+spyWbJsK2dYF46zM40uhQ?=
 =?us-ascii?Q?TvEc9cjkYMG56ccZGWs5wt2TD9Wd6J5GKjkq/10Qi0yNolsr4X/CjwgxNn9G?=
 =?us-ascii?Q?3uxTl460oNminLLa+taxv3Y38CyKmHh3zkfkbkgcHPF+rAeMSGRK3SKZmtvW?=
 =?us-ascii?Q?bbymmSrLw8SC7akNh7KDYdjrDydtuoyRyVTdiqCy+RJmO4Gz7VNWaZPQYGnX?=
 =?us-ascii?Q?V7dr3mYn0ukpzgM0l1N5IeB9tJIhHBTnuRUZ9xb+teMfB5MSstAfM91ITfVs?=
 =?us-ascii?Q?hVewTVtgi8vrf/eVdnbtHYbSCrnGMCbOAbnEXhnlh0PTWP2XbqT+RlDc/s1l?=
 =?us-ascii?Q?TeaVV+hcjPgVwnq+7cJc1PqnkRmFb5H+5lVfdqvpDosng2sRC4sBKjase392?=
 =?us-ascii?Q?W7n0ey8Lhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a332253-1dcd-41ee-1c7d-08de62c752ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:35.7673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNCizlHJYaax7vqZFvzid4zFiNTxKKkVTaJ4nTp1ILFeOx0CmT9E1HZlOotyzT68dPXHMMRYUed+HLxt72/WvCtLGoJVB3HgrD2bPQAEK3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 60 +++++++++----------=0A=
 1 file changed, 29 insertions(+), 31 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index 1f1b5749f4..828ea1ca53 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -26,15 +26,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
         self.vm.launch()=0A=
 =0A=
     def verify_vbootrom_firmware_flow(self):=0A=
-        wait_for_console_pattern(self, 'Found valid FIT image')=0A=
-        wait_for_console_pattern(self, '[uboot] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
-        wait_for_console_pattern(self, '[fdt] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
-        wait_for_console_pattern(self, '[tee] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
-        wait_for_console_pattern(self, '[atf] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
+        wait_for_console_pattern(self, 'Found valid caliptra flash image')=
=0A=
+        wait_for_console_pattern(self, 'Check flash image checksum')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read abb header')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read soc manifest')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load atf image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load optee image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load uboot image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load ssp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load tsp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
     def enable_ast2700_pcie2(self):=0A=
@@ -63,9 +71,9 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V908_AST2700A1 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
09.08/ast2700-default-obmc.tar.gz',=0A=
-            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e=
2cd')=0A=
+    ASSET_SDK_V1100_AST2700A1 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
+            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -93,19 +101,10 @@ def do_ast2700_pcie_test(self):=0A=
 =0A=
     def start_ast2700_test(self, name):=0A=
         num_cpu =3D 4=0A=
-        uboot_size =3D os.path.getsize(self.scratch_file(name,=0A=
-                                                       'u-boot-nodtb.bin')=
)=0A=
-        uboot_dtb_load_addr =3D hex(0x400000000 + uboot_size)=0A=
-=0A=
         load_images_list =3D [=0A=
             {=0A=
                 'addr': '0x400000000',=0A=
-                'file': self.scratch_file(name,=0A=
-                                          'u-boot-nodtb.bin')=0A=
-            },=0A=
-            {=0A=
-                'addr': str(uboot_dtb_load_addr),=0A=
-                'file': self.scratch_file(name, 'u-boot.dtb')=0A=
+                'file': self.scratch_file(name, 'u-boot.bin')=0A=
             },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
@@ -113,8 +112,7 @@ def start_ast2700_test(self, name):=0A=
             },=0A=
             {=0A=
                 'addr': '0x430080000',=0A=
-                'file': self.scratch_file(name, 'optee',=0A=
-                                          'tee-raw.bin')=0A=
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')=0A=
             }=0A=
         ]=0A=
 =0A=
@@ -137,26 +135,26 @@ def start_ast2700_test_vbootrom(self, name):=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_v09_08(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-default')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.start_ast2700_test('ast2700-a1')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-default')=0A=
+        self.start_ast2700_test_vbootrom('ast2700-a1')=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-- =0A=
2.43.0=0A=

