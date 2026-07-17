Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66241C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDE-0000XU-4E; Fri, 17 Jul 2026 04:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeD2-0000Vi-Uf; Fri, 17 Jul 2026 04:46:21 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeCz-0003vC-MJ; Fri, 17 Jul 2026 04:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkCkHmrLtU7Ixo5nsMX6NPo60xChhGzaobDZL0IFE9PghxbwPmPM8e+BtJG1bw6wGXZm/oloL8NmLMggo0w7u+vRUrsEtE5PsVlNULPfGDHEDnOSDw8emqLRSuRUVoFoFn+uOqckA5B28A/IE60aW9MJr6u8hS9W6d/ndRcQWp7NG0RJLIZfbYpkqYFeLS1FKX8ORswcsnHL9zq2KUqeTQjQC+KheaVvCUCct96UfKvVf029hECTtjGxF2Xvz7E1AKkVxL8u+7Q8eFOLsEeSRS6mSpFA9+sZcvhzict+SPqW6alcioJl1poXbMin4+f4whfuezZEnQJLJWouwfvfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7gt63c+Pu+s/ti3iTdz48EKwrmeSevZzE1iGlCcMHE=;
 b=VFs6NC/qwwV4GReRFAx7E5DMcdmSTQftdmyhvQpkXC3/6AB3q+ryVA/N1SFvdzyTlHMZ/5hLHEQMBQGjXKl730qLeSisXiZhxSa0OHgXPD762uNIkmep0mHbsxu3z+HWFP7sc7QjKbKE8dp+sdJS5vTyp/k0Tsx4GW8RacPgRSaVN5mZBBpfJZD9Q/xq5XX7GyNEpP4We0H/6E8HYcCYakWREMoLWlEvXWB6SeMI8MOrb/O7Hkhz5b2GIIdT+fPpwg4ik83RUj8aiQX1AGnGgAkaJhLw+Re9U3Q24N+7ehcM0Rgk6TD76QYvwlM2q+nq7WEtJ0eV9NFPZFhGwyoIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7gt63c+Pu+s/ti3iTdz48EKwrmeSevZzE1iGlCcMHE=;
 b=DZSO9HbTDwePwTG+A8g6DyBxPZWNDllrvkepSdI0MJUD/RmU0bs4jBG26QF4jj2k3Z2yazewZaYHDKM+Bd5OC541o4FuD4IAATw3AG/GhmeyTRDA1Owfr2KwTO5ogRx1KyfOlysmNnk8Cjpog8Pw56LSUDPRuIdVsWRgDNHWZUev64zqlgMCAm+XXSxyDk4q1J1OJcHokt2JrMPu1A2QVVNe6i8Zo44CemzaGT51xPCRJDReylnWciBoWeGXmnAUKIl0FbemkBeQ7zAkA7VbLsjU/3xWuDzGW202ViyD4S3VAppJZMtGJB/ppzcqPMxZp+EySVlp5cjyJv+aYV1+QA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 1/9] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Topic: [PATCH v4 1/9] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Index: AQHdFciyKO+oxReK1kK49WRxa7rndg==
Date: Fri, 17 Jul 2026 08:46:01 +0000
Message-ID: <20260717084559.3477061-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: dcf8406c-cfb4-481a-782a-08dee3dfd496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: 1kBFg1xrTI73lvoQsCzeEaU/9cr7B0bnHOSeIYFFUCkXW313N+X6vyN+J+6HxAc8LNIrNNzlDs654joEg0JxShwB18z6aphFlEvnwQ0YPrh0HWR+YkjTqYJA17c3pp7OvhIuIsIAix0Pee0XZRAlAGfL/3W0cqE9K+RJVZE88yyvhm/jYkHiESgZUzDUtJwLyf6xIOKY2YHDGMfoC8jmbRSCfGSake0vk/Ncx9cv+lL89Zv6t8U/PPuniCRXQVuIAVlq4N5s1DphoRejejhDSxem4OzRG1nshFneEK3OXzmPTRNnIe6xw4d6rfKflSNTu9C+qg8XEC7LyXTFNFiU0TMNFtIPMkVDjO6Tm8Mb4XGao+lTTNSnurTzzQVWIh8RjY3qxa+/GrC7NkVQRxJCgS13ORDJ0aMiLW6f6C90qy5lwMGmoltX7fcEm/n5qO005lANsZV4VkCYfWq0tST2QuS163qHnWCcudAGkKTdf+eU/+W+CDbGBq6hdGm/lOkUHyh2fKwA5AXn46VakMSJaeG1Nj3h4/oPzKFafeDsHorqvqmZnyegdm5JtKzZkXa45Itnm4rT5rq0deySGhol399En5RJ7la3YmRqcMIC/pLVfm5bwZ9mZme/NA4l5zGAN8Qjz5HJ7SUO2HcUYXSJAuAcqws0At/5uU9MnbeDvKJ6/qqTccBKI9zxpvs5CO6jW20ZYtCXeiuT9Ncj75+VzeAhDMIloCxUCsRjQrgT1LUVGTTlJ8Xbi4l58JNQCUaC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D0T9L7e8OAo8mMZEl2Fe2sX0+l8So2QyXH5xIHgHhRPCHd+sayt8S5x1QF?=
 =?iso-8859-1?Q?Psz3NNFZDQpKZvE6dtYvH+R6Zokle/y1nDeuXXS9USjLT2Les3AMR3iDTY?=
 =?iso-8859-1?Q?ImSbZs+CKba0S5XypJSlDbP5K7TEsoZhAGSibnaCqCy9z4R4PhXjUHJB/a?=
 =?iso-8859-1?Q?fdcbiOqUBw/eP6G5gnoPX2kRVo/mEngLORwQKy7VYQnWv1T2Q3joBTQHhC?=
 =?iso-8859-1?Q?NdRM3V3i/jSYTEghGsiEFyI5345s9bsjZNzgPjW6EPcuEWjJKJF2yng3xA?=
 =?iso-8859-1?Q?iXVWAnqHIibqZ7cMKKvNIWAeDDVhbu2FcGtYjxs6hJ9/zDdlor5q7aWrus?=
 =?iso-8859-1?Q?sgjkj/RSRBR6ao6exnfLBj/4VnH6eSVsSzbW6qTXCzUOE5J9RDI3tabyjX?=
 =?iso-8859-1?Q?T/UI5vpqRrhEFGORz84avFB1gFYfO8xs8AQbJg45XtV3+6zreLd3SFfjBm?=
 =?iso-8859-1?Q?nvMk22XAbinuH+lcBVx6gEE5vVtsTGGqIcZQOdgAN+xAZfXRkJg8aas5dN?=
 =?iso-8859-1?Q?TgI9zNinWlsPOMnVTeBlJsHFWj8o3xGFbSf4LiktjfSErDfO0Zw7Wv/JV4?=
 =?iso-8859-1?Q?b1alUvrfV+NW0xwqyAWVfPir/p4lXvJQy9/fpxqytvjKSJzGlVwfRtajKc?=
 =?iso-8859-1?Q?3Yv21tYvs4d/cF6rv+vNImEEdEzmX84IZr9fXK+GvM1DTs59gSC3m2CRd5?=
 =?iso-8859-1?Q?kitTNpBeWs+Xq3OxFdlM5dQ7yB8lzWIjxud5o11OUSqs6sm4/Ysz0Sm9qv?=
 =?iso-8859-1?Q?X5lmPayj9SuqXh/W6EHP0JNNjUo0HiH2Udm/wmjfPxv+IWAEKwqKyzm5hY?=
 =?iso-8859-1?Q?QD3cvHgGPY8isDepAIvLZMwl7TnKxWzvQvkdx+OG7yOsGsFNPDkgcdna23?=
 =?iso-8859-1?Q?2N1yy2gDZF1HUnm8gsKgNjKZF+Q2ZV1UiR7BpqWHOHr2W0azDEwz93gzRf?=
 =?iso-8859-1?Q?0jDoeYwGT716B9TIgaTq97/r/CbyT/leaIprwteuUPsCiNR2Se6qDT1IO7?=
 =?iso-8859-1?Q?r2stnoXXRB3z2JXIKbzUyQkdBIXvehyq56EcgiekVcMEEb7SssCyz3N5c6?=
 =?iso-8859-1?Q?dobPFX/19ojaCGNk1eX1mbktCmTgj/ZuKyqfQHN8u+d/a38fidRS3FNaPC?=
 =?iso-8859-1?Q?T9d+XIwnHeyq5vV1kT00LTRvtibql7Ijid886zpt+UyUYPjW2uf5BoVECy?=
 =?iso-8859-1?Q?BC5LVIh4oQ7U+YlMU6R38WCiT40i9nCDvUa6BSt45Kk2wzY5j0NTaq0Vgo?=
 =?iso-8859-1?Q?MyvBgIdgNQU6BHWz5QSax2td+y/vm+L4ZAF74KrQOelfd8GaOMLNCjtOhl?=
 =?iso-8859-1?Q?1uF4vRd838zcsEAHErmivgMgbzOsMt6apYE9/B1QaW0NRqI3OSyOcyOzxY?=
 =?iso-8859-1?Q?4UyBNEot7trqJUVo3PdDPULvBPnFmNOJaQx3iG7j1HqZQhqnHPsZcoHW0H?=
 =?iso-8859-1?Q?lgBnp24wW69JDFndpbsqhJ6ssHbVD7ea3oRYyGTCgAvF8Wgjghn6EpTcBW?=
 =?iso-8859-1?Q?4D5TjUSiMylXQlH5oaleyXo7BoGtjD9hnxwvwWIHaiSyX70tGmG62po/W0?=
 =?iso-8859-1?Q?5s5is1nymcYWKvybNLCARUp2uyChHRLmdD6+/87yKkcDSeJG/JxMo9P6LN?=
 =?iso-8859-1?Q?0p1fQfG0Mdr3oKXHJUEq3ObRer55T+8iT2/eaBfq5zl4sQJmfgKUcxTRG5?=
 =?iso-8859-1?Q?j1kPn2//tIcVVz/mEW5CbQQDQsletYz5JA9MAj5tpGn0Vi4KMOwBszj+wQ?=
 =?iso-8859-1?Q?O4VT+h8f4yh3fXqcVk/2zz2agXLIXHMXl9Oi8dNQ0eTncETCVvGOQrXdzg?=
 =?iso-8859-1?Q?onFZ2ezx1w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CSgMzixYeeQX5DvIUeMHtF1JhajemCp+SAbYstmlPWir0sdqHG2cHd9AB+r7mXxRvUUrHsJEFXSflSRgDgrL2+sCIeWMnOTB9NLWewnsd8/OIDop9aAoti3Xr8wabP5/bS+S9PVqM8VRxOUu/icmWoLbpxeP3AZkqya+tcvJKHU9X+iWgveUNFu0jjsixvs8X9oMHPXjaNYKtP6+X//Mm4F5ObOtx1G+qqA0p0a0Y0TWzffp4ROdANfvHhrhjtwKkByBlZD9gqZM6qgkarm0Y/VyVLIrze2BjFLEJ41RrxaAA0n61J89SQAktd3yL8gmgUnx5KwbTxRdH9GkH8yMDA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf8406c-cfb4-481a-782a-08dee3dfd496
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:01.6831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tRiaP/YXmM1VFFiISFhivyqmqg6uISulAPTGO21Tkx4I9g7NWRnkyT7WOqke0qaYYFkx7o9rYgpwLIl1gWn7NegDgMjA/hapW7f+rMGeLo=
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

Introduce Aspeed2700SCUState as an AST2700-specific subclass of=0A=
AspeedSCUState.=0A=
=0A=
Currently, AST1700 and AST2700 reuse the generic AspeedSCUState.=0A=
However, AST2700 requires SCU functionality that is specific to the=0A=
platform, particularly for interactions with its coprocessors.=0A=
=0A=
Introduce a dedicated Aspeed2700SCUState to provide an extension point=0A=
for AST2700-specific functionality while keeping the generic=0A=
AspeedSCUState unchanged.=0A=
=0A=
Subsequent patches will migrate AST2700 users to the new subclass and=0A=
move AST2700-specific code into it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 5 +++++=0A=
 hw/misc/aspeed_scu.c         | 8 +++++++-=0A=
 2 files changed, 12 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index c30940ab76..904549465f 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -20,6 +20,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEE=
D_SCU)=0A=
 #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"=0A=
 #define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"=0A=
 #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2700SCUState, ASPEED_2700_SCU)=0A=
 #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"=0A=
 #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"=0A=
 =0A=
@@ -41,6 +42,10 @@ struct AspeedSCUState {=0A=
     uint32_t hw_prot_key;=0A=
 };=0A=
 =0A=
+struct Aspeed2700SCUState {=0A=
+    AspeedSCUState parent_obj;=0A=
+};=0A=
+=0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
 #define AST2500_A1_SILICON_REV   0x04010303U=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 5dbf81c0ce..efe1d6315b 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -930,6 +930,11 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj,=
 ResetType type)=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
 }=0A=
 =0A=
+static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    aspeed_scu_realize(dev, errp);=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -937,6 +942,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *kla=
ss, const void *data)=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
+    dc->realize =3D aspeed_2700_scu_realize;=0A=
     rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
@@ -1161,7 +1167,7 @@ static const TypeInfo aspeed_scu_types[] =3D {=0A=
     {=0A=
         .name =3D TYPE_ASPEED_2700_SCU,=0A=
         .parent =3D TYPE_ASPEED_SCU,=0A=
-        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .instance_size =3D sizeof(Aspeed2700SCUState),=0A=
         .class_init =3D aspeed_2700_scu_class_init,=0A=
     },=0A=
     {=0A=
-- =0A=
2.43.0=0A=

