Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13BBC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 01:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkXfa-00061S-M6; Thu, 16 Jul 2026 21:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfZ-000619-AJ; Thu, 16 Jul 2026 21:47:17 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfX-0001j6-Kg; Thu, 16 Jul 2026 21:47:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQYmaAyl7W+WKnep3/3l9Eh7kJaQumt3IFoqQCTHz0uf00K49h/7fFk3kAMOae5CX7xx2+HeO0Xd8SujVF96ch1YKKoPJ8Y/aTM70v/3IauHvlCAXqVX8G+bo/g9/S2yfQAtFU/InK7B0hxI1biHRm5pq2McjQmx3a11qeuvI507cI7e1QmVfXI93GQpNpCbSM5yVcrqq1lETvFdhPJGaRjniMn8NfhwwuXlu8NY9Dff1gXNtuDg6FlIjGoDGBIE800lLoDTebGSWoYlsl0gy2Hs12reb8Bw54ydptHVeeXCh1cS/yR3pa7GryKf2g3EnLydAZzOPk7vpmlPBT6fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gFhdE37jxGY0F0zgQQWydIf9nlbeKqplrQErJc8RlQ=;
 b=yienp8DOYO4qsdH97DdCWfWBXhHIG3UQXhSjPYNjGqe5i0Kz40G0mAIYlQ3ubSqwNYvWWa8/67sBGAFczxYStTy15r664fmb8QGvlRhooF9V4R3zYaM3T9XVbOYZWpe8WRZHAXogFE2wqtlRpeI8WDDrQRdz5BdE9RPC//v4Oc97LkI7pG8DFvsPBcFyav1FEEuc0gRHxZTYxC+BR6RDfJ6n0AWfJ2ALBzrX1bTOGtJ/9l3bn5DIrjToaz4oNuxB7qbiKU5iTSZi76sOuiOepJikYOjwL1SaMMD83BzBN8llSbHs/meU1wq3KNxcsuDglv0Ojpw1BkKjCzd0frWh/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gFhdE37jxGY0F0zgQQWydIf9nlbeKqplrQErJc8RlQ=;
 b=V0zNcBNxzF3Dnl4X8ekvYS2eqf1X/2AkqcsU3shkaaUOfEdb1GcN4JwHg+dr0KzRvP3BARR/9sEPA4jtikZiTa2nUTLShU7Fs1PL4bv2oCL7Nq1SepnF2/7YOc9fAZgBnG5xCGAedKiFycxXBk2NaSLghh9MpkNEcDMz2FwzR/K84VvheTGiTSUrXh5NqAxxUI2xZMulxrCMn0MSkyxIjAv/ScaXrCqPjW3HVwS4NebQhZ4OTzQrYCTxOEVIknVHCxPNnTYP26qJq2VR+whoZ8oHW3jKs3V0HopnG2reftFC/jOq7BsiWj2apZiZEERzBJqQeuHg2QIeYm3Wp8Mz1w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUYPR06MB9015.apcprd06.prod.outlook.com (2603:1096:d10:74::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 01:47:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 01:47:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/3] tests/qtest/ast2700-smc-test: Add Data FIFO mode test
Thread-Topic: [PATCH v1 1/3] tests/qtest/ast2700-smc-test: Add Data FIFO mode
 test
Thread-Index: AQHdFY4q0yXGjpzV00CALja7dvFrpg==
Date: Fri, 17 Jul 2026 01:47:03 +0000
Message-ID: <20260717014701.1683876-2-jamin_lin@aspeedtech.com>
References: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUYPR06MB9015:EE_
x-ms-office365-filtering-correlation-id: cd8014d7-77b5-41aa-a1e0-08dee3a54d03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|921020|38070700021|56012099006|5023799004|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: lnZrWtBpf+yvMZb2m8FM/TrMR0RY4RejwM0f14MwILJg1V5X9koKUnVanHBhOR8h/JWoHnBVzeMqqScvxhN+uttSeRGBxPBDCV/ljWMKmQcLRIx7wn4uQEikHWqZVgwt+kvn9nrFfgyQRu0cSDppLudXS4vrV9R08xpgdiuI0T63IdTwQR+DbJ023zqzJIXukTxj5zNSjQOD+BkNzmc5G97+2f/3PKCU9XNgD5tZcZ9De9WnegqFdmKZKkbB7l4msrRY5PVuImXcm20rfFni/6lnRUD1Ge15EIZSPfefzqKVAQmN42rBLdLTeuqhpgd5fZaJx92jupTte1GWdsW0hltjCwv1c4govh3AMZ+5i8jH2pn3ry6oGJmZkevqjRluClCSfXCUCAJy2D5FNgKmWzYuRnXysakefuZjaev9cITh79yjl9bi5aEipHg8j9Vct13ZrK542FWvTsk+ZVdIvbzO33ydhFfzj92zbSWNbyOYugbtCpEpPzlAeEuxD1Yq9Lo15cqdF2646JamViLJZ+p1uNCqSqtYaPfezzCyQ7DNJhU/U1D7pfC6YLGYDoVe6iNchYOEGc4wPiAFtu34+OFFuT8nwPYLfchxKcKTY5fihBjPkrrAR9y5ap6uP6q6yPHmSXaiwjHTzNRsqPhhnEwtrCrNFBL2Q3DuTlnjT20RvbaX1C/Nb2S3VwX+k8xfElMioWfZpWeyoAgDSVAuyuVLwo9533cXNrQm9IXEdS3Wlp5WLvwedQ4iyOvw6uoX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(921020)(38070700021)(56012099006)(5023799004)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KANrDSaamsUHBeRFc1zOJ1QnA3h7kyZ3oKjLI6qh3DEaLtQuip9gxoBX9o?=
 =?iso-8859-1?Q?leQwjPKFEgQHR8GUCUx52zVo6norp2Tm8hOQqPoGi3lwfyWNOxpp02L0xY?=
 =?iso-8859-1?Q?4CsUah0t2t6Hkw7UfwOV+b9qeBSkP7EnepacXUtM5l7ZIP4zIu3tdcGYmt?=
 =?iso-8859-1?Q?URQJjZ0SCy7kuV/ZfWV63e8gmUkSFbjF44vkSYyUY6DpW5l164Vld/QNdN?=
 =?iso-8859-1?Q?kfu4S8sOmzQZlf+t8T+6PLcPp3C3wyEifwYi9E6iVBZHowJ+0oYTdQRIWZ?=
 =?iso-8859-1?Q?Dv97YgbyEuStbmoy3eDji3AEiH1pqiKyE11a0uDc7xao/rO++AqP5L6bSy?=
 =?iso-8859-1?Q?iH50h0yehtzbqOtRSk+kC5NHLU25UioqXdUeKjihmKRaPvVFhNH/HFCXTs?=
 =?iso-8859-1?Q?eVFbgHnJ6zW4e+MiWc6vUQiv+qpxk6sFnI0v9Egn3YpX0R7P6Q1kjOhBNC?=
 =?iso-8859-1?Q?evgGLnkapCibXOOErwjzOWS1opXE1hKg5aXXTCadkkZ9WbOtpP+BVjtxeE?=
 =?iso-8859-1?Q?EK0NOGE5t7wTjTPQ1s4vFcd3ozJBfNwmuHvEHG1U99FxYpbvsg5vxRHLww?=
 =?iso-8859-1?Q?Z9p0RydHqtQYOxBxFAz+gPynVAaY9Omu+X1BM9zdEQkleJSMZNCo7Wh5MC?=
 =?iso-8859-1?Q?XtVI1H9bCqnq7gkNOr9UX+SkmWw1U9Zjjeef0GX9vJZlxCZRVI5zKq4cFx?=
 =?iso-8859-1?Q?fi7Ef71obhcSyZ5HmjFuN3A+fl9K9vhvWxy/9q3aNvvXRCXHXtCoyFJtra?=
 =?iso-8859-1?Q?5FKYDDlH/bggT+pph/GmyYiAHZLtYJeR/YWAMagGCTtZciUlfh3/zEWNax?=
 =?iso-8859-1?Q?LcU3tiY4eWa0jKtqCLsqt+I7UzT2VqM66V6vTdfF2jBoNapjRiwL82v1uQ?=
 =?iso-8859-1?Q?hltbDQzEmpZXcqcoCxg5I2mvNXKL43kFkPuejifGFHyu7wwv3Zy2JzGJjP?=
 =?iso-8859-1?Q?0WfZ36CzWJlrHQEETgxNluOldW7sKktFlTdEqZ2/CVYjwIunZWDIdAu0gG?=
 =?iso-8859-1?Q?0UQ+EpMuBe9i05CrZipPBwrmyWwr6Kg8PSXZw+b4+gMBF4xVaCQ+K8kaop?=
 =?iso-8859-1?Q?icYUh7XEK6UVYaYlmWGY5ACtMJ/QorEZvuqcCTON2bxI9kbTbKgm9LmpbG?=
 =?iso-8859-1?Q?lOCIf9SU4ae4EbOovRXc0JyinlIgCW8NszBd6j6/dERm4RrGYh4mlBeqrp?=
 =?iso-8859-1?Q?rWuBeFuPRL1W+in/a+34Nw1ruBiatqeuzD264scqi9kPvv1HdX5K4rfmhj?=
 =?iso-8859-1?Q?PjQwx0r+vpnfpOA27MJPxwKyvwtPwWB54riyTwgBMVAvst3gov+BvE8ZQn?=
 =?iso-8859-1?Q?mMpTcbU4wNQhUNINnyE1sIJZGlU4uUdtnGsYLLuzrimhOMkj66SD8xmy/q?=
 =?iso-8859-1?Q?mZNYRu6MBfB0+eIG9aGYtT0zrU1MVos5dq7ocgsr4K6/L7N5Ic9lu7AXAq?=
 =?iso-8859-1?Q?dyjSFJDjkwALBbS0CT9jEqUTCrKCArdKcA6FB1M7p7oAMaAMeQ8eYBzEjk?=
 =?iso-8859-1?Q?4x+GoDxwN82Pa5uMaRjb/7U6e1KhUvf5JpANe+C53H/bX3WZ3dTH0luxpH?=
 =?iso-8859-1?Q?SczQeiyY4Oe+wHoJpl1MPD6ytTvkKeohl3zUxGJEaxml1AS6a34zfcplhu?=
 =?iso-8859-1?Q?30/uNcFkitW2t0XZ/hD1zPelNSieYpMZu+Y6x9bDPxQaFjppFN1Dyn52rc?=
 =?iso-8859-1?Q?Re6thJLP9J4R1QCSwu9HcfP8QiB1KcVZgADyKKuHI7S7uJ695VwRrq1Iu2?=
 =?iso-8859-1?Q?AM3qpUTAE+LWfv4WqSewNnr8SJCwmnqsx2AZK13m/y2qZiHoecFFj17QHe?=
 =?iso-8859-1?Q?j9ouXpIp5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L/tZvlFL3YWiAdY+0jAlYz4Dxq6WPNl7sYiNCiwMmBUGQlPPR4rzvGavokYHVVGQZJU4GE0bNcdSZsqA9hfdxgOlY4wbcDrz13Wk4Lf5TvC0bFClaJbGE/5KU1/pM90TQ7D3PSusX5qHq09NoWBezUKc193tbHfbI22vg8T+sOJrUsQhyokomCO5BrB+90gYkCdGruPjvlsR8QgzRM8AF0IHa7SRZz4+W3utyJcVTyZrVgaNlkHeAifotTQ1xF/Ekev1mZlujcF7PWh2MgsNa9etZtjKXN+3TJIJQgNwyOFyOYK097Z6O8O7Nh7Q5ytur40EeIvFvy4NP8dXhRkLig==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8014d7-77b5-41aa-a1e0-08dee3a54d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 01:47:03.3820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZ9ke/39E8mIHlS3eBQNXKFf9+O/Fr1NUtip0w9G0A17S3xUHGQ+U5pd8LShXnAs9+/1Fb8YXADKIjcmjgeH/FXNuoUw/5B/RyURVRTlpBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9015
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
index e2fd8ff1bd..485cb92ede 100644=0A=
--- a/tests/qtest/aspeed-smc-utils.h=0A=
+++ b/tests/qtest/aspeed-smc-utils.h=0A=
@@ -45,6 +45,8 @@=0A=
 #define   CTRL_WRITEMODE       0x2=0A=
 #define   CTRL_USERMODE        0x3=0A=
 #define SR_WEL BIT(1)=0A=
+/* Data fifo */=0A=
+#define R_DATA_FIFO 0x200=0A=
 =0A=
 /*=0A=
  * Flash commands=0A=
@@ -90,5 +92,7 @@ void aspeed_smc_test_status_reg_write_protection(const vo=
id *data);=0A=
 void aspeed_smc_test_write_block_protect(const void *data);=0A=
 void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);=0A=
 void aspeed_smc_test_write_page_qpi(const void *data);=0A=
+void aspeed_smc_test_write_page_datafifo(const void *data);=0A=
+void aspeed_smc_test_read_page_datafifo(const void *data);=0A=
 =0A=
 #endif /* TESTS_ASPEED_SMC_UTILS_H */=0A=
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.=
c=0A=
index c27d09e767..a1be4e02f8 100644=0A=
--- a/tests/qtest/aspeed-smc-utils.c=0A=
+++ b/tests/qtest/aspeed-smc-utils.c=0A=
@@ -73,6 +73,28 @@ static inline uint32_t flash_readl(const AspeedSMCTestDa=
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
@@ -684,3 +706,83 @@ void aspeed_smc_test_write_page_qpi(const void *data)=
=0A=
     flash_reset(test_data);=0A=
 }=0A=
 =0A=
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
+=0A=
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.=
c=0A=
index 33fc47230e..58f796ce0b 100644=0A=
--- a/tests/qtest/ast2700-smc-test.c=0A=
+++ b/tests/qtest/ast2700-smc-test.c=0A=
@@ -52,6 +52,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)=0A=
                         data, aspeed_smc_test_read_status_reg);=0A=
     qtest_add_data_func("/ast2700/smc/write_page_qpi",=0A=
                         data, aspeed_smc_test_write_page_qpi);=0A=
+    qtest_add_data_func("/ast2700/smc/write_page_datafifo",=0A=
+                        data, aspeed_smc_test_write_page_datafifo);=0A=
+    qtest_add_data_func("/ast2700/smc/read_page_datafifo",=0A=
+                        data, aspeed_smc_test_read_page_datafifo);=0A=
 }=0A=
 =0A=
 int main(int argc, char **argv)=0A=
-- =0A=
2.43.0=0A=

