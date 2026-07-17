Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2D7C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDJ-0000eO-1V; Fri, 17 Jul 2026 04:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDG-0000Zu-Vn; Fri, 17 Jul 2026 04:46:31 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDF-0003vk-7I; Fri, 17 Jul 2026 04:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK0zw5q2Q0nJ3Ol6f1l6uofREHXqMejC6BMmbMhUJ6D03V1RAXenTqQWYKNUzRTC4IHAW3R0Hnli/eCzSdsjQifeZN9Kc+nkLlivqCt2KtejMFoLuuhly1BazqadJsnSYu8Ha7vfga0aC78s6NlbtAlAjGUatA9OL2DplaD9oZFpDinEyzM9dpx2idZGKqWbFXN4YGLR9I5Vf9tbO0w/goc+cpDeDtpqkfM397pLxHgqjjZPILIMgnqxZa8MLdNWQTqzKh6+IRtMqFPWLXhNYTYN339OgwCpXqiiSNXExDIiTZxnanamoAZdxxG5aJyVwOb0bjlrnRCEMrWH2BwgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHIJGPs/UHq2h/dtyi4NfdvnJeBGbd8XMiYB/qH9/7E=;
 b=qZ3xcyVbrntP/DixackzZXJnvDyonS87cK3qWALCAyVFDaHEchJ9snlXOqXvnJpItGN1JESpHBdgvI3LRQ3mRmEZPAad6ZhJaSpO3C9ZiXutg6oxFJAX5hRe+4uThq8q/zudqe/tH298ngNWO+Pw1w2vUsfjabePuVpo8xNQT/2mgT0s3Y2RkbW+mfX1O/wKf0f+gqRsGmY2Bbai9bfp3+2YQUAaLHMlNoS4SLHVGwLLBq65i7yAyM0EfHt0n2AEl6W+J3OwrIyEm2rVMHLLkiozpLhUOmfznY/4OAdSU2Q+p8hyNiBHhcTb81dgjudZ33oWN8G/qzwTJ/V66qJFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHIJGPs/UHq2h/dtyi4NfdvnJeBGbd8XMiYB/qH9/7E=;
 b=R3XzvoIEtgzFgKzYNBhCfqyKVoWozECiiZNPRA9FSSUbFs8YxCEj1cW9lqoH4ErQ2lthNqvjBz3DaeUdO5+QdH4wrFHKQHja+/iqv5kbF6UcS/7dGD/eoH4HfIWU3cROtohT+cJGrcnyyj6bNDKhaEv4lBisbrduup4qf1lcWF7+3eNrvrH0k14ULOnn+QkgmZ+tcNr84uXL0X6Lf1RmheuDKqM47J8uKhob72s1VezuaqZZHkWNvz9Db6qXq9Kaod3Mv5e6xNmk4H/v16OlOZJslYXufXACMPKpQABVPokztCWf7vNPNk1nEO9bTGTf6kGKr45iofWDXGln7TX1mw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:12 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 9/9] tests/qtest/ast2700-smc-test: Add Data FIFO mode test
Thread-Topic: [PATCH v4 9/9] tests/qtest/ast2700-smc-test: Add Data FIFO mode
 test
Thread-Index: AQHdFci460f70MgYtUq6+yGlfUx2tg==
Date: Fri, 17 Jul 2026 08:46:12 +0000
Message-ID: <20260717084559.3477061-10-jamin_lin@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUZPR06MB8267:EE_
x-ms-office365-filtering-correlation-id: e11b146a-34df-48e4-3e55-08dee3dfdaea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|3023799007|56012099006|5023799004|10067099003;
x-microsoft-antispam-message-info: f8eWnDbuMvXPvzJejhnjojNZW0oExY6oCbUilMtL9eeJzFUPwABQBD13XMoDm+8HdQoj4WMOMuzVPXpd4HJ6NAgyFn4DUgQbXYoPTPORLmvd5TraX/NnfvJ4oWPpnMKN/CfUPhfzsTBDMJei6U8z8tLg80/0jt4ubpsRdE89u1vRp5g3ehRmU+U3BJu1ulM+dHMY35/Atn7PCPix8K38jejAFRkEDPHUhgRnzNwHpViZX5NoPY7kWi5oZ5ie33f5BvBWMid8Fh/DXPIAufOEAKe4Tvu5E2REpDiqqmjMuQ6fvfFu03uiZI49iv5Vb3Os9aQNtDo1c1+l7jwCIBPo99R010nsnEmXheXOrJBz7HMgXQv8J6vH7YnFruobydwVaJyMMKmI5svRJ3jaN+DtkBvchKpWVbGZCmV35z52RD/J8YMrX2KTqrqq4yrWvxiRvQr/fh+gR2vs5HrkkHWU4Om2VuWDUnUGapO1YHMyRmk/ZgAxQEMZNrwdIgUWC007yt504TjdCKXwQhEBOye2VdzYanwN0vdphC+Gqt4Tbr4OsQ/v6/kLGXkfvv4W6n3WGNbvMA94ILmyjKeGU58Hd7z8RvqHSon00LjJi9rJhpBcNnoWx+s0TJRHUaYnRbuygmEqk4pCCPnt0u9OKuZ4rorjv9hs6GkSMeqOrUcTWo5iNqkbApBe2+tOsndWwtpEU4JuUWxTrfYl0Cm1U6BtdWelCYKVvgKM6viJbuiCGw1PGlH1Chw2h10M1qBjDzTz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(3023799007)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VLsQk8BD78alKL8oRnTcJBwpEYhfDyr+2upS+0H1AfhCaUrZqHqsDx03T3?=
 =?iso-8859-1?Q?RzTwdYBlEnPFB38+oRbhV+Qf11nJLc3Pv78c9YlpG2X7R52GbIHy9b/wks?=
 =?iso-8859-1?Q?dHQTEj+0ocQjkWYkxUcE6d4aELWyw8tHIgRBreLgZcS/cDSd1EEyLuzxRR?=
 =?iso-8859-1?Q?lWjI68HzHWCAOQf1xtPcpIeFjT+EFxXbujieRT+DlcUCszwLQDNHYlozKH?=
 =?iso-8859-1?Q?s9Yz/eNxneSih2+WB68+WQsKsNzOR7HJp84o4TMQ+uqxpIB8pdAFchKDzN?=
 =?iso-8859-1?Q?quNwEMGvRqXVvDMqqAyRbaXRbrJewMuHrxz8UjtFgzgcK2b1M6L4+eI7Z8?=
 =?iso-8859-1?Q?IAu3vsI7QCX91xgwY9nZ0OpEve80oEozAPKwHn7Iuk8kPTADCT5I6WZzo7?=
 =?iso-8859-1?Q?nJ2pjyfPnqQ/wWcOcvDYmC9AyqpnxfNjUo/7C4+cJbMxr0cVH8RaloBVk0?=
 =?iso-8859-1?Q?4TOVWITrK8He4eviYEo1aKtAp/lWmnAFEe6DkHq5evnNlOqz8J2QQZw0b/?=
 =?iso-8859-1?Q?2YvSUN6cTSR5er+rMJ6K1g4T0wOn+UZ6DyOv2Dvkla0TotQjUocJyvfzmT?=
 =?iso-8859-1?Q?DHf+yirspiZ7iyJJJMKRqqcYvjcksr2x3RruPyMuW0erlkiRXQ3uetMe8g?=
 =?iso-8859-1?Q?zIbO40+3r2063HM6K7iB/XlRSrkWo1D2vwa3qEopYhegNmLpNqxaFtiuH9?=
 =?iso-8859-1?Q?flEZx9R3+VHcO9QxKVkS1dnxmbJhz8jUMIhR3StjIf76I4AlqIcAw+0PWU?=
 =?iso-8859-1?Q?qqLIKb8c8/ifahiVcpRsmBVTH4vAlI8BCM8yADJZNSZJa3Ybk6whmdLLYo?=
 =?iso-8859-1?Q?xNd8ae2IrSX+HVkDGx5jaAueeTr4kh65oV1yQyh/WKoZhr9D6UWUwtJhsJ?=
 =?iso-8859-1?Q?yyZt4Ip8Cg98Yg7GJYIXP+lszleRNFqI2TvKXcOBI9Emc28oTO4ATNIb2B?=
 =?iso-8859-1?Q?Ud/8iDxET4r80lNM7+EROeLKiH6pMyg+Z+V0v79CGTkeIusAN0c8ydlsHZ?=
 =?iso-8859-1?Q?IvfeM24dC5IrXh9qw+2jSh7Lrep9PtD4bNQKjNfFZISqZUptc3IK93ZO2V?=
 =?iso-8859-1?Q?aKjo1gYS7pX5/V9xQbmKKH+jA59wgJAwpsGOW9/015ipcY9DWxzVMuG7o7?=
 =?iso-8859-1?Q?7vLoTK375u64w3plbPK6pOhGc/EIAaw05sFnv/qXj30l0ZegCabL60uq78?=
 =?iso-8859-1?Q?lVNITefH3bBW8kn2RspD0oSChIa9twzDbf15pqUR25oYbcKm+1nO6ZVM3I?=
 =?iso-8859-1?Q?tv0JIs+hliemeHBYlBqAw4OqFgv9vAbnlPBxs5EzAXQF0/qvTx8etz7qRD?=
 =?iso-8859-1?Q?AMxJFDxkWrIsWtkIOcP37WQLyT/zfPIL71O3DRyh10+1fTP+8BZ8CcRd13?=
 =?iso-8859-1?Q?e3haYVoD6YC5Xn5/lCwXbSG2A9xtpHnEFfCofyAn8Lv244BHs9Il7ZdHw4?=
 =?iso-8859-1?Q?94Z6nGDl9qFbgFA6LisuH6R9BiHEGEPKeezP4Gkl4asg1mmOlfUHbiwc2D?=
 =?iso-8859-1?Q?D4Vg2XlHj1HTHyXy2YOohGVvPw4TjLJhE//otqirVzrru+c88iG1HtTyb3?=
 =?iso-8859-1?Q?HV5pz8NTQKnKNli6Gu4HFby9nLaTtHZmGDRfARm/k4WwjoCDFRrqTjGysw?=
 =?iso-8859-1?Q?1vzhunaiW7TJpWff5dh3G2dkMiIgR/XpYxe8ka/C0y7zHCMiBWZakdkTVW?=
 =?iso-8859-1?Q?WXXwa2YpCvmGc9iTWlVL1qw7tYJmAWfcdxlHZDnMTh1CsDO1WKyH2M27L6?=
 =?iso-8859-1?Q?gIhI3h9WldPL6IBQH9QaI0yIfBOk2UEl9RBF20KquohR5gT+1g47d3fBQB?=
 =?iso-8859-1?Q?BZk6+OILIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IcEvwVfNHw3iVWQLQOeB3fQgfoNzRs3aBQ5iLMjKBBwBO/tTszlbVNKpnj/RNiv+vl8o6lUnEfwyGqgrLkDki/jeuWqAwt1xYQMXzA2WWkV1uQctszc5WuKW5KAO2qaJHFVwDhzrhAg98V/KSiZNsFCvhgrDKquE5WOYHexvsMkhR3BJZFgGqXlVoiXd8omNG0+TRPG4f+mQmWUOKtLISPmsDLrwFUBS6whSxAIDHxp9bzSm1y+c/gOwnOSNk6DC6LAWsLkVU269WlcaZGzXateEAA9az8AS5Ob9jHus5iSYyJAFstGBdBNaaR1adboH+eEDEGaEeovTLstCqxuEww==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11b146a-34df-48e4-3e55-08dee3dfdaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:12.2645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1Bt3w+9kfUUbJ4H0otCogP4y1lgdbHUpPBo4dkbG81CtsBE9IslxULVboYSuT1uhMVk6gylZ5d06gEvsBVTvJxX8v4QDHLQTlStV/Lr2iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8267
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add two qtest cases exercising the new AST2700 Data FIFO-based flash=0A=
access path (R_DATA_FIFO at spi_base + 0x200).=0A=
=0A=
Write_page_datafifo sends the page-program command and data through=0A=
the FIFO port, then verifies the result via the regular read path.=0A=
Read_page_datafifo writes a page the regular way, then reads it back=0A=
through the FIFO port, so both directions are checked independently.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-smc-utils.h |   4 ++=0A=
 tests/qtest/aspeed-smc-utils.c | 102 +++++++++++++++++++++++++++++++++=0A=
 tests/qtest/ast2700-smc-test.c |   4 ++=0A=
 3 files changed, 110 insertions(+)=0A=
=0A=
diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.=
h=0A=
index 19c557b822..e4f538e579 100644=0A=
--- a/tests/qtest/aspeed-smc-utils.h=0A=
+++ b/tests/qtest/aspeed-smc-utils.h=0A=
@@ -33,6 +33,8 @@=0A=
 #define   CTRL_DUMMY_LOW_SHIFT   6=0A=
 #define   CTRL_DUMMY_HIGH_SHIFT  14=0A=
 #define SR_WEL BIT(1)=0A=
+/* Data fifo */=0A=
+#define R_DATA_FIFO 0x200=0A=
 =0A=
 /*=0A=
  * Flash commands=0A=
@@ -87,5 +89,7 @@ void aspeed_smc_test_read_page_mem_dor(const void *data);=
=0A=
 void aspeed_smc_test_write_page_dor(const void *data);=0A=
 void aspeed_smc_test_read_page_mem_qor(const void *data);=0A=
 void aspeed_smc_test_write_page_qor(const void *data);=0A=
+void aspeed_smc_test_write_page_datafifo(const void *data);=0A=
+void aspeed_smc_test_read_page_datafifo(const void *data);=0A=
 =0A=
 #endif /* TESTS_ASPEED_SMC_UTILS_H */=0A=
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.=
c=0A=
index 6d75a95578..146332240d 100644=0A=
--- a/tests/qtest/aspeed-smc-utils.c=0A=
+++ b/tests/qtest/aspeed-smc-utils.c=0A=
@@ -57,6 +57,28 @@ static inline uint32_t flash_readl(const AspeedSMCTestDa=
ta *data,=0A=
     return qtest_readl(data->s, data->flash_base + offset);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Data FIFO port, in spi_base's register bank (not flash_base). Accesses=
=0A=
+ * through the FIFO require the complete user-mode transaction (opcode,=0A=
+ * address, and data). Assumes CS0, whose FIFO slot is at R_DATA_FIFO.=0A=
+ */=0A=
+static inline void datafifo_writeb(const AspeedSMCTestData *data,=0A=
+                                   uint8_t value)=0A=
+{=0A=
+    qtest_writeb(data->s, data->spi_base + R_DATA_FIFO, value);=0A=
+}=0A=
+=0A=
+static inline void datafifo_writel(const AspeedSMCTestData *data,=0A=
+                                   uint32_t value)=0A=
+{=0A=
+    spi_writel(data, R_DATA_FIFO, value);=0A=
+}=0A=
+=0A=
+static inline uint32_t datafifo_readl(const AspeedSMCTestData *data)=0A=
+{=0A=
+    return spi_readl(data, R_DATA_FIFO);=0A=
+}=0A=
+=0A=
 static void spi_conf(const AspeedSMCTestData *data, uint32_t value)=0A=
 {=0A=
     uint32_t conf =3D spi_readl(data, R_CONF);=0A=
@@ -826,3 +848,83 @@ void aspeed_smc_test_write_page_qor(const void *data)=
=0A=
 {=0A=
     test_write_page(data, read_page_qor);=0A=
 }=0A=
+=0A=
+void aspeed_smc_test_write_page_datafifo(const void *data)=0A=
+{=0A=
+    const AspeedSMCTestData *test_data =3D (const AspeedSMCTestData *)data=
;=0A=
+    uint32_t my_page_addr =3D test_data->page_addr;=0A=
+    uint32_t some_page_addr =3D my_page_addr + FLASH_PAGE_SIZE;=0A=
+    uint32_t page[FLASH_PAGE_SIZE / 4];=0A=
+    int i;=0A=
+=0A=
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));=0A=
+=0A=
+    /*=0A=
+     * Send the complete user-mode transaction (opcode, address, data)=0A=
+     * through the Data FIFO port.=0A=
+     */=0A=
+    spi_ctrl_start_user(test_data);=0A=
+    datafifo_writeb(test_data, EN_4BYTE_ADDR);=0A=
+    datafifo_writeb(test_data, WREN);=0A=
+    datafifo_writeb(test_data, PP);=0A=
+    datafifo_writel(test_data, make_be32(my_page_addr));=0A=
+=0A=
+    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {=0A=
+        datafifo_writel(test_data, make_be32(my_page_addr + i * 4));=0A=
+    }=0A=
+    spi_ctrl_stop_user(test_data);=0A=
+=0A=
+    /* Check what was written, using the regular read path */=0A=
+    read_page(test_data, my_page_addr, page);=0A=
+    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {=0A=
+        g_assert_cmphex(page[i], =3D=3D, my_page_addr + i * 4);=0A=
+    }=0A=
+=0A=
+    /* Check some other page. It should be full of 0xff */=0A=
+    read_page(test_data, some_page_addr, page);=0A=
+    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {=0A=
+        g_assert_cmphex(page[i], =3D=3D, 0xffffffff);=0A=
+    }=0A=
+=0A=
+    flash_reset(test_data);=0A=
+}=0A=
+=0A=
+void aspeed_smc_test_read_page_datafifo(const void *data)=0A=
+{=0A=
+    const AspeedSMCTestData *test_data =3D (const AspeedSMCTestData *)data=
;=0A=
+    uint32_t my_page_addr =3D test_data->page_addr;=0A=
+    uint32_t page[FLASH_PAGE_SIZE / 4];=0A=
+    int i;=0A=
+=0A=
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));=0A=
+=0A=
+    /* Write the page the regular way */=0A=
+    spi_ctrl_start_user(test_data);=0A=
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);=0A=
+    flash_writeb(test_data, 0, WREN);=0A=
+    flash_writeb(test_data, 0, PP);=0A=
+    flash_writel(test_data, 0, make_be32(my_page_addr));=0A=
+    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {=0A=
+        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));=0A=
+    }=0A=
+    spi_ctrl_stop_user(test_data);=0A=
+=0A=
+    /*=0A=
+     * Read it back through the data FIFO port, again sending the whole=0A=
+     * transaction (opcode, address, data) through it.=0A=
+     */=0A=
+    spi_ctrl_start_user(test_data);=0A=
+    datafifo_writeb(test_data, EN_4BYTE_ADDR);=0A=
+    datafifo_writeb(test_data, READ);=0A=
+    datafifo_writel(test_data, make_be32(my_page_addr));=0A=
+    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {=0A=
+        page[i] =3D make_be32(datafifo_readl(test_data));=0A=
+    }=0A=
+    spi_ctrl_stop_user(test_data);=0A=
+=0A=
+    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {=0A=
+        g_assert_cmphex(page[i], =3D=3D, my_page_addr + i * 4);=0A=
+    }=0A=
+=0A=
+    flash_reset(test_data);=0A=
+}=0A=
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.=
c=0A=
index f85077e04f..925dbcfaaf 100644=0A=
--- a/tests/qtest/ast2700-smc-test.c=0A=
+++ b/tests/qtest/ast2700-smc-test.c=0A=
@@ -64,6 +64,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)=0A=
                         data, aspeed_smc_test_read_page_mem_qor);=0A=
     qtest_add_data_func("/ast2700/smc/write_page_qor",=0A=
                         data, aspeed_smc_test_write_page_qor);=0A=
+    qtest_add_data_func("/ast2700/smc/write_page_datafifo",=0A=
+                        data, aspeed_smc_test_write_page_datafifo);=0A=
+    qtest_add_data_func("/ast2700/smc/read_page_datafifo",=0A=
+                        data, aspeed_smc_test_read_page_datafifo);=0A=
 }=0A=
 =0A=
 int main(int argc, char **argv)=0A=
-- =0A=
2.43.0=0A=

