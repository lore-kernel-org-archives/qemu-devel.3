Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFFEC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmS-0006s0-7Z; Fri, 17 Jul 2026 04:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmP-0006qh-Op; Fri, 17 Jul 2026 04:18:45 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmM-0000E6-7Z; Fri, 17 Jul 2026 04:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrWqZDtCi2He3qMOKIbB06PMArEHOy5RpS9Akfm0gQJm2BaNQXxzJLELdEXm8EoE+q0D/Bcfefe17nmm68D5Adz78OEoU63iTY0EHj7ELu7nU7CKrfNIASe96qd2Y6KeHk4ZUB37p8Nilulz2nUs6V3EEWJrVsyXXEt+JVatUwONabgFPXduEuQKUCN8TSEpTGleS225pEhdzuKClX8aWfxWVPbCTQUVNuqMXTd4S0SEWUEgIGf9GVHRz64EIh7ruC7yjCutkH8oqfAH2bWDXJDYHTYOUKBRLnOSXLLuE4XeN6UfqzHIcHKOA4bzqK2PJ7kpUnO155x7jUB98GSZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWUyU9dHlk1ToplXvL8Hf7o63dfqkyNamSZD9EQ9EXk=;
 b=u5YJCsDTjkeAfh8KqjO0q7WSSwMfQrj4vQ+xfFH3KF2Vk7RWrIUimHwQDe0VLVfxwdxxhRtA96Ci2Z5EFgstQGVLI3Uv1jBGwVCc6jFbdrXHKAkmM6l7eDRlMwgnk6U7oO6C6YAPa+JwsfsLsEBC4fak1bdVsm/9Ojon6vk/qq+ARgNkPVFEvVqcvADWW6OvoEmIaisJW9ohEpBJN67SKVIc3nQPi5AyUuIxONOfAyKljmtzgVd/2m9kRnc43aotiCQFRsN1+reQmrZL3cXQEOv8z+5hqL9MojnwcxhWEVzIXL8xviHI9czTREhhkI2sYAw1hfpbumNVtaSvV4aqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWUyU9dHlk1ToplXvL8Hf7o63dfqkyNamSZD9EQ9EXk=;
 b=WMV0YyoPqwQwOFiuFl+8+McOgcu6ahwNNI4PNLD6QsOCqC6aq2GAtGy34T6CQHkBGEVcjCpj5FcpL+cnZgdkWXfQnhtqHyFaay4S0gM0BeP71UUeiSZ5Zq4FFS1H8dah+3cuncLtqiR8bdYIkYLtKws7/+iaAsS+cBXqEo3rkcZ0m1bwfHkE48VL/3QASH6bmfojM7ugRVLYezeC/T0bn0zJe3LaxV1tZCPHEW+yyRnl1QJTfnx6UPjWgDtuxIM8h8t+Nw5/M1ACtu7M1d3BOtocFOLp7xbSZ0YvAXLpWmJfmET2grclz6IgDTq57EMwErRiOj6MygRCROstmNqEzQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:25 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:25 +0000
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
Subject: [PATCH v3 9/9] tests/qtest/ast2700-smc-test: Add Data FIFO mode test
Thread-Topic: [PATCH v3 9/9] tests/qtest/ast2700-smc-test: Add Data FIFO mode
 test
Thread-Index: AQHdFcTXpJaMuEyUxU+Po3S6sKMyaw==
Date: Fri, 17 Jul 2026 08:18:25 +0000
Message-ID: <20260717081813.3407862-10-jamin_lin@aspeedtech.com>
References: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8339:EE_
x-ms-office365-filtering-correlation-id: 1dfd30ca-ed16-44d1-6b27-08dee3dbf98c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|56012099006|5023799004|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: zhIzg9SfnXGQYGyfCGZcIH52M6oFocjlBp4BhX2UT1PufKoehRihdstcCDaD3XKZL5lTZFYoEYMF09hLZ+qng6dN7BFQfaZdVAb0gDfFpKMzIEvpz+gMBp0+cQiACGv7J5jD97u8zd9U72fb9V8oWxBWzAX2H8vNcupiaHo31gJEK3uMPHNWxorRLHOeqbVdJej9E+VN+lY+bK7EUdz7dSMOI14LnuykQkzQzfs39mXXe0vG6MsaPb3js4ul5gYN9fPFeXOR2bakSjbEON51ePNkv9hWBnpN6ji2VC9A91YrRVr0lOcMESVGrTd4t1q3LvzlW7daX2jHz7uQDoG2bMdURany3YWIhupb5glcQQdX/SvnkcugggAfh5eIIg/COsNsntQ2hE1Q4T8KUEPao47P/42KWR48hL3wkF5NMiJsJ9mmaATHLJoJOIlxiJa5DhfG6UvI9OZfeHsimOQyeHbt7bUrl9oIMhDao/10eBQveBUOwh7AEab8gaLq9yTpghLZEN8vs0BWRZIg3BgklxkxNYOuXI5HvxLh0Wh6prEPN/ZjEBZeIGkQyuWAwCFLkdMCaGJxe1XUF4ovg9NPYjmpa7mctB4VuHbGtG35iMhibewAgZOHSKmHVYKBIoLN1C3hs7fGkj28fUN943FSiGqTEclCNdFhPpyPSQ6KtmFxtJ814eh1lmDBOy/M4E5AQChpqlNyqL7Oo2wKz9YWVBofCVRPWeTvOh9rsOr+OaMK6JLsV302FUzRKziq5ZQH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099006)(5023799004)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GYgvjLsxROBIwEkdJPrQLVvm2+4uWQIiL7MLQo6aqZ4O+BEBzmZOePJSZa?=
 =?iso-8859-1?Q?AV5V4PNluhBpyP3FeRWdLY/7Fb3WZpYzADu8zlUaf59eML/QKnX3eRnnI5?=
 =?iso-8859-1?Q?u2p89KPYACDrvLuwO9MfJztAWrpPxoXzXiL+FcYpYYl6TEsNLYksAY5Cl6?=
 =?iso-8859-1?Q?aJLsF6eRtLfyq5WAZhjphzoMpEboFxSaxAhrO0skGbrjhArLAj/zrMPxht?=
 =?iso-8859-1?Q?PtmwtI8BIR9xyIhP0RnQterC2kiQF4BFSOITdcO4AYnlVAXZKSraVhEY+9?=
 =?iso-8859-1?Q?OeFqnPjPEo4EbFRcsef2ZZPPn+BuGco7b9ZQNHohcbnUJ68eo0kgIOTnMh?=
 =?iso-8859-1?Q?EtFTYKnHOjzvim8JT1kavLhDs6WlJFxweLSv4JFpGbVAYx3SaRzDd4m5yL?=
 =?iso-8859-1?Q?s7PWA6lo3YWQggyVYkRYHxaGZXky/1tBs/xf6X7v/2afeO4EjHBh5DvbQ7?=
 =?iso-8859-1?Q?oG6UIQvgvm1ZOG1TexF3V3FL0AnA+jGMHiFkK89Y9nVhgBOBw1gwu0cumP?=
 =?iso-8859-1?Q?e3PjOlGaMQUb214SafVn9miVpiRQd1XUQ4WSLw947FaaTzpkW4vrC14eUX?=
 =?iso-8859-1?Q?MWd9PgTmvPOy/cnL5biLWdWTIpYoTWA351Wml1m2isakPU4HZ1l8b3lIhl?=
 =?iso-8859-1?Q?fBK28QBTeatdjdg9fFin6eof2zvBKJEV6b9O+Uw8VTipBDY1z2jGwqOG4r?=
 =?iso-8859-1?Q?FrPcxAohFmb3bRDrDrVlea6gt3csNcDWbnY7HgaqHJGe9eCIbRG9LUxbyA?=
 =?iso-8859-1?Q?laxrH+3FNXIjhJF0T3A8S3p05HDa/wuBBrwPloMDjgA5ja9RGJdZgo4pE/?=
 =?iso-8859-1?Q?oGTvr7rU718Grbj7cYOG33YmwBRI7mRbljcX7aMLSBJgay3URCaWA0GKNY?=
 =?iso-8859-1?Q?z6gNoJLDZ6pALhLTsadJ1Y0hntM0/YStytgseZNkWUeleAAqNRXuiMswLF?=
 =?iso-8859-1?Q?lPyWg+V6wnsy93z/5W5e812Fb3aIR8OCjvCrqXdvFUiaOdjiysgMOJKwlb?=
 =?iso-8859-1?Q?81CgrKo5TJ7ygFiBUWALXWNIG7V32pCnsSpoN594H+7LHN4+6++M2klSbl?=
 =?iso-8859-1?Q?efyQAtU7Dn2t1wsHthkDZQxZDsci+KMZSZeBUy6FAtwxkrbSXXu0UF36ak?=
 =?iso-8859-1?Q?/jfqmgV9sJttxeYPO3xNf2Iw0Rh212ZM7JzdhRv9JiKgW2Rv0YRObBOf91?=
 =?iso-8859-1?Q?Nxl60vwXO9kPw0fKjDr414SKRiyKjjOt0Q7EAjbEnqbELiK/rYjEzIBSi0?=
 =?iso-8859-1?Q?LqvpLptxNThLzaz8a9f6Vvy2Qc2AKLugVOgaGiFbAYVs9OAbPqiooTzeP/?=
 =?iso-8859-1?Q?+CtZC7YF2R0uQpIPADdWyf68AnmPJzH4nI+LL0dd/cz6wOmdM94tyRcyfu?=
 =?iso-8859-1?Q?v4Tip/l5ABA8LA0i4HdL8a1cYD9ugrSHRNxsNuJrCffI+uzlqLYkdgWd3N?=
 =?iso-8859-1?Q?XqcmDlV5UnxxSE3QX0T9QvP4OlWtOq1THLtOuUd/4NyOrAncLLZ7jfbCHR?=
 =?iso-8859-1?Q?fKG7P09SBj0/N/moAxfbrbY122eZ8+lzPXJwauBt+wvfrt/LnJzVD1fYuG?=
 =?iso-8859-1?Q?j8+7tXip6aGHYJgk6ePVwBRVZziLLg5O7Ws2WbcpOGFXy7NsL1h1GV8Mvv?=
 =?iso-8859-1?Q?8nBKVu7QnhCvWcflcc5n2Pn4pkycVuJy3QXdbao6e6tnFoO/UHfE74iezf?=
 =?iso-8859-1?Q?ibRdlv08YmodcNkkPdPPGKG336v7TohgHJ+6YXgMAhYAAqy2knnNx8AY0l?=
 =?iso-8859-1?Q?S4uuDz+AGANnkQacoolk0A4M3RZkCbOdCnuo/NBle47SseHFhi5Kf75iVB?=
 =?iso-8859-1?Q?LuFwQ0nN4Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DsxVs7YT2pFPmAhXyJBlJfZouE3EH7xLE+uTmWzRUOSwt3o90gxekbD8T+VKCUt1e588OL7BgAlsI9AuwsJ1LjHX0iVjiGzi7K1IjciZ+G95i2ifvRe6FyRFO6QvfsxPmtwcOjes//K+dCeRI1YWBjHtcBS1RKJ73C8KvTenNCvMgU4BveK5BXUypiVlhM0nf8PBadqJP/Pe1xl04smR6PnIbAxR38IdVi5+GALfyksNjfBHYqmzk2BKtiTg56cY8Fnf1nuFDei1RKppXiHj8gz9s9i88F2UwIxSWZC1WmGkJbMbuBoEMkeuAymAuYW8FeVd9gPXDqxs2Y0JvU2ZFA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfd30ca-ed16-44d1-6b27-08dee3dbf98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:25.6614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PG/fM8LNlznY2/FQ2JFSjwmn0oUkBG4hOnEbXINpF6+1iY7VYkAo5Mc+6GrhFD9X5tLlhahFnd+QUixDjOF1VFTWXuqdmF8h/+oJ0p0RAOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8339
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
 tests/qtest/aspeed-smc-utils.c | 103 +++++++++++++++++++++++++++++++++=0A=
 tests/qtest/ast2700-smc-test.c |   4 ++=0A=
 3 files changed, 111 insertions(+)=0A=
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
index 6d75a95578..6f1a4b2ec7 100644=0A=
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
@@ -826,3 +848,84 @@ void aspeed_smc_test_write_page_qor(const void *data)=
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
+=0A=
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

