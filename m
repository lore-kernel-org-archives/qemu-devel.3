Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCE0C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcte-0003yG-Pk; Mon, 10 Aug 2026 23:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctb-0003vw-6S; Mon, 10 Aug 2026 23:11:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctZ-0004JO-Ee; Mon, 10 Aug 2026 23:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZecxcoGCb9qcYsrmhN/FPAniGoei+nXsvBj9Twnqe9Kl2MHzQjPLSEuiW5Ds60vfrLmE6EX0O65ocJHSbDXI5gNTutapLR/5cC8ORmHVgQWPtfOwWOd2d6zJykDM08xQqLcz9ImQFEs07V/2vd0Ii55uhEKbleTBPxEDqFP67yE7KUjcQpX5xiu+3pu6Hi6G/N5dgDZUwP30i1h9i8DS4ruq9wgAzcOqA0Kj44vlrZRDEjIwyxXlIUmiLBs0eT4NTijCnzOySulDU5ZHrZZOJgRDNMxO9KjXn/5hAl86F004a43ZQZ0dV5dIVl/3r03JD/u5AvZQlHO86JDjrjfE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VvkCchWe98bBN3EpDFezWSOjE3CGydahAaCR8o9ryk=;
 b=ZBs0420cxGwz6GOmxgGpQFvO2B10x7Hbb7B5B6fDoJhPrQ9aWNase0gJYB1tKgf4fgtjKToPBw0V+6IfEK/CZbhmYo11yOUz9Vw7oA+skmy1v46MahmQRz5c6gnIpNoIbClEDv6wNSPBJrOejQpVULZEmcKn3aHH3sKD/zfGk6Um44OXQL8HJj2Rp0dFRjPjUluLVSq8j03xKftoJcQh0ndC1/CQeSTYdjdK6oe0FxHbA+KanO5hphwtBoyEBBoJOHWtYeGBt4VsdyLB4Rnoe7OkGc7n98WGvOA3JKRDbxFxAUi1c/zPq6YJVWdxRulSD9RBXCfJdGz4dyhG41eTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VvkCchWe98bBN3EpDFezWSOjE3CGydahAaCR8o9ryk=;
 b=WxohQoor1qWTUwHV3qadxRpxrpyugLB/R5L7uatthuHoubEq++wUrxY44qV5xgfF7ojSk+Degs5MgDAw1uv5LucL0MgVnyMcYfiHcPnXW74ugTJa5OEJgK4uBzXEP4zZYqSdPamnOBkM6vkitWTQlbRLMd2wR/0AXalIqwOyb5TWlMw3H723jd9c19MdIuWnKBQ3UNxn4wP2AS02D1H6/pvkshT5zo+Q+5nwlDYIqDW1YRSrHNFpVp8AN5+F7RzR/pA9HtVSgjG9FrquipGGCH0I+JMs/DJl5FpX1g5PuqR76A6WYUnytlB3zJod4oHi9ifTya/OD377GCfHfQLxzw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:45 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 14/16] hw/misc/aspeed_hace: Support the AES-GCM mode for
 the crypto command
Thread-Topic: [PATCH v3 14/16] hw/misc/aspeed_hace: Support the AES-GCM mode
 for the crypto command
Thread-Index: AQHdKT7/yU9AJ19l1UGHr4fFR8BPGg==
Date: Tue, 11 Aug 2026 03:10:45 +0000
Message-ID: <20260811031025.2784489-15-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: eb8e4a34-8c69-410d-5f14-08def7562283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: dTFmtdYayTqAy5CLkBICZCG7mVDHRryDDQV9/GAG2CJGvfm6u6HqdBCmK7yo88NLU3tDfkIsz9j2fDOBNflHHlDSFTb4iWVDnk/uped4XFybCUVv0Y+ndrr8rgItLLlcXXSZe1+VtOH6UyMhB5gNfCWT0cRbBJF4TVUlb6RQ35n9U5aNPd1xSDrLoRAmC9kuXEw+ghgmL1PYIT47r7sad3z+/lW+tbgBaIoccgR5mmI6pFfkqqwwQE88ybAWOXuU4eciqR/ZSKRAIRBFNAwRdO9X4+hJJD0os30kOoXEiPdgRYM0d976059Cyz6vQnUdV6aW1KQ+WO65YcFq9z/rCAGWfc0TGApux4xscROcnnl545osD5TkZ517wTzhABZg0GAsBuhCK53/6tacE17Vz2KpU6Un2Zin4ULu9xbfO2hxM+JOfJogGxWLxYxz1xd6G+F7Zxo5V4V/WwAo1Uv612JSCGX8mZrinFuJnHqZJpF9/Pcz23lDQ7MRkl8+MPdnoaIVWelrouuxylEf2LRdZOCBE4fQHnBnIJ7IX6qIZU80Zu1EIsPpnaq8jbkz4C7LqspaCnmwk6hVpcMWNzSMIb3fSE9PkOvNrKnUr/yJIGJIuIznYpvx07ld3buospYlZ0zgwV6/hcS6GKVUDXBrzNlDc87AVmWY+xpsHxeIxMwq8pq/9JDQEo2ZiAAWFynV8JjUxK4K6yiKrMatPNY7g9bB867nwNI3+T73vQAod0uZEopjEAw0oAA/1MXoY/ee
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jxd8KiAXY9/+qK7kmAgl1THxNZQF5+E28Xfzzin7JSm+zxYVR6bfwvLNX/?=
 =?iso-8859-1?Q?ksA82Bsy+PS9/spFM/2o4tHGTlhTheDtMZjGny3p503ygCy58YLMSuXh5g?=
 =?iso-8859-1?Q?/OYpitPT89voU+unHwRCafHucm1TrS5miGnIwAupLaD+J3/xIbE1YXmfMP?=
 =?iso-8859-1?Q?QFAsSBDOAsHYL5AyWAGb2dbwjeDnQ0oDkrun+XzSCzRlcfNEl60PNxwWD4?=
 =?iso-8859-1?Q?uF1W4cvzzoM5jWkjFnFh/5c7B8svbRtVgVTzn46Q4+xODvtGFrRYkUXFfb?=
 =?iso-8859-1?Q?rkhmNpcqFaMKKGskBt3uLeposUMMPZI2lpaCxHWFGVs2nZIPSPwGq3ItJk?=
 =?iso-8859-1?Q?pHSAPyiOxZH1d50aoPBVQi1ZNnZJ7kUAgu0bCFaViy4K7JYIzKE3WnsHvn?=
 =?iso-8859-1?Q?QuehWdHeuSKLJx5Mgdoa0XmmHnLlplZLJ72mXHf1o9WM4hA77v787LkgJ0?=
 =?iso-8859-1?Q?LCfph8xz1hdvtZC3NXt0/leQDXKL0rdODVMcx36lPdH2iqEnlexEDRzD17?=
 =?iso-8859-1?Q?OpiFCazqflkSFmlmmLDekmJwNgYQhBrZP+7pZYJShKhapMnEQ0spFx3Yk0?=
 =?iso-8859-1?Q?JmbPOQSEEffznh4Itl5yzNVwkqL1FYJ9OYcvykij8cBeZ9euGjbOL5K2u0?=
 =?iso-8859-1?Q?9kX8a0Ac5YKS8Qvm0u2m+djgd4YzVrEnHwG5MWaYjNwh3NJc458S8mF2v5?=
 =?iso-8859-1?Q?CXeizvj4+iDHzBftYKEREq8UB6ln8GHmfqC6cPc9wnhuOEOXRYOkWOB7uZ?=
 =?iso-8859-1?Q?pFMM8LUBLISHjuezGICGMQ3NonkN/YdL+z0W0bVV4QkKYtj2bVAcltNe7G?=
 =?iso-8859-1?Q?Ye81mkkdJUyEEa9O+fE5olfmJUzMDto2EvooptWAfRqD30+yAUnBLtb+Ho?=
 =?iso-8859-1?Q?Gv1fh9z5AxWm7Sp4AiL7wmL05HEVLE2SvRd9ecom2Jb3RjyUtFpXiYZq6D?=
 =?iso-8859-1?Q?rRKZTm8Ix1P2e9NWEQiU6v0eOt/njXO8fJhkJedHPPK6UUhCQeH9Ln4IPs?=
 =?iso-8859-1?Q?0OjX2g9ZkgOvTaL3KDok/lT7bqGXCEhpcaSxfvt59qJNFlZim0rwEFjo3X?=
 =?iso-8859-1?Q?H5F40YbQrm8ObVGN4/wKnuQm2KUd98HYj8QX6zEAxOCB+ZKoD+c3YgQmhs?=
 =?iso-8859-1?Q?+ritdnpGoBqgJu1dPoaYPNeRy5D3MHzNx/Nm+zC1iYXyWnxL/NQpfRmN7l?=
 =?iso-8859-1?Q?fuuperIVes3rJ8mUyJEaS0YnT5aYIrPyGbC1iIg6x26mcfyfM4g1ykm5q1?=
 =?iso-8859-1?Q?mpYRSkQpXCx/9bQc+twwUbTZfHyd0mHuZVN55EdXiOIlP5hD9HLUK6lPe3?=
 =?iso-8859-1?Q?AAWlE9/W7Hs7ByQIeh5WM6B5lff8iIxnHKxD/Qz6cGa0RZ4AxwacFrhIkn?=
 =?iso-8859-1?Q?nbdcwOQnH5LNMax52vUgCVitf/hjZn29bjsPeGS6b501i6BFSoxY77hmCS?=
 =?iso-8859-1?Q?yqSMHxrLee2JrOlCfz+UXTTjnZ9VnV0PSn6jZdrdAwemKLDGHAvk39OBFH?=
 =?iso-8859-1?Q?AtnfO30UdeuHoi7oosZUhYABdjOueI2cCy9P7foNswXqvguweiOC+2q9bf?=
 =?iso-8859-1?Q?USKC8q9aGEPXrH1Qcj/eTsWT3wtSxOgZPaabCsqQQ80eVcJkOlvC+VVmaP?=
 =?iso-8859-1?Q?CsyE05HbVfGsdKmlMx5JNPmgnUuS1SAtPBcC6WcuX+g4BnvbNDY+IHt+XP?=
 =?iso-8859-1?Q?5hO0o17JqiqUgfAaUgupS1xp7qJVqjmUnXdcg4MjFOD8wVLaBSSXEkM+ZN?=
 =?iso-8859-1?Q?xNFEHi+ta4zuLmOwExKCmxgfnGDbWtzntRSKAbcWpCDmib3AuI3Hn0pju0?=
 =?iso-8859-1?Q?19TbKyirnw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dMaahNV1T9mksG3RGnFAxFJSBadc2Knu03QISwgzqzZrzb91q3JmX7hRrGWcqmJcln4bLPW8Ds7V26ftXP1uX7VkQ/DTUFrvC5L/xhmE0jgVWkJE7092+jzFPKX4VOM5B+CH08YaE/3jhGDOWfUzIllfpMafGbzvp2ZDHwHD7vE6noUm9F3SgnODzE/0+Pj+msT/aXb+5kDSw3HIly9SF95PVckAspMcbZLIDjCQvucnFUmVOe1WCggQbiNjmAR74eIePWiBvalHOsKdfWH4ZbwrBSRyHMYv8KGcR7LMudWXiwxCIAV2Yg4vgwd/HE04DDi+vdiJZXU9tIeOSHQ6Wg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8e4a34-8c69-410d-5f14-08def7562283
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:45.1012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLeCZmgrFqvxYkJ4KziJ3xX6lSsXWmpZ7XNvPRlor5kv4DD5Wd0cbwu2dZnXmZ/ALvpYMDKKkEI3JsEOgxaJQITx8uVBqMuOmZBl4Y9xUf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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

Implement the AES-GCM mode (HACE10[6:4] =3D 0b101) used by the AST2700=0A=
crypto engine: decode the GCM selection, read the 96-bit IV from the=0A=
context buffer, operate on the exact data length (GCM handles a partial=0A=
final block itself), and write the 128-bit authentication tag to the tag=0A=
buffer (HACE18/HACE8C). The hardware GCM path is only used without=0A=
associated data (the driver falls back to software otherwise), so AAD is=0A=
not modelled and a non-zero HACE14 is reported as unimplemented.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 70 ++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 62 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 0a6e2fa829..e455216dd4 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -31,6 +31,9 @@=0A=
 /* HACE0C[27:0] holds the crypto data length */=0A=
 #define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF=0A=
 #define R_CRYPT_CMD         (0x10 / 4)=0A=
+/* AES-GCM associated data length (HACE14) and tag write buffer (HACE18) *=
/=0A=
+#define R_CRYPT_GCM_ADD_LEN (0x14 / 4)=0A=
+#define R_CRYPT_GCM_TAG     (0x18 / 4)=0A=
 /* Crypto engine command register (HACE10) bits */=0A=
 #define  CRYPT_CMD_ENCRYPT          BIT(7)=0A=
 #define  CRYPT_CMD_ISR_EN           BIT(12)=0A=
@@ -42,6 +45,7 @@=0A=
 #define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
 #define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
 #define  CRYPT_CMD_CTR              (0x4 << 4)=0A=
+#define  CRYPT_CMD_GCM              (0x5 << 4)=0A=
 /* AES key length HACE10[3:2] */=0A=
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
 #define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
@@ -57,10 +61,15 @@=0A=
 #define CRYPT_CTX_KEY_OFFSET        0x10=0A=
 #define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
+/* AES-GCM uses a 96-bit IV and a 128-bit authentication tag */=0A=
+#define CRYPT_GCM_IV_LEN            12=0A=
+#define CRYPT_GCM_TAG_LEN          16=0A=
+=0A=
 /* AST2700 64-bit DMA high address registers for the crypto command */=0A=
 #define R_CRYPT_SRC_HI      (0x80 / 4)=0A=
 #define R_CRYPT_DEST_HI     (0x84 / 4)=0A=
 #define R_CRYPT_CONTEXT_HI  (0x88 / 4)=0A=
+#define R_CRYPT_GCM_TAG_HI  (0x8c / 4)=0A=
 =0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
@@ -596,6 +605,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCiphe=
rAlgo *alg,=0A=
     case CRYPT_CMD_CTR:=0A=
         *mode =3D QCRYPTO_CIPHER_MODE_CTR;=0A=
         break;=0A=
+    case CRYPT_CMD_GCM:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_GCM;=0A=
+        break;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -689,11 +701,12 @@ static uint64_t crypt_get_addr(AspeedHACEState *s, in=
t reg, int reg_hi)=0A=
 }=0A=
 =0A=
 /*=0A=
- * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
- * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
- * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come fr=
om=0A=
- * the context buffer (HACE08). For CBC the resulting chaining IV is writt=
en=0A=
- * back to the context buffer so the driver can continue the chain.=0A=
+ * Perform an AES/DES/3DES ECB/CBC/CTR or AES-GCM operation. The source an=
d=0A=
+ * destination are either single contiguous buffers (direct access mode) o=
r=0A=
+ * scatter-gather lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the=
=0A=
+ * IV/key come from the context buffer (HACE08). For CBC and CTR the resul=
ting=0A=
+ * chaining state is written back to the context buffer so the driver can=
=0A=
+ * continue; for GCM the authentication tag is written to the tag buffer.=
=0A=
  */=0A=
 static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
 {=0A=
@@ -703,6 +716,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
     g_autofree uint8_t *src_buf =3D NULL;=0A=
     g_autofree uint8_t *dst_buf =3D NULL;=0A=
+    uint8_t tag[CRYPT_GCM_TAG_LEN];=0A=
     uint8_t ctx[CRYPT_CTX_SIZE];=0A=
     Error *local_err =3D NULL;=0A=
     QCryptoCipherMode mode;=0A=
@@ -711,10 +725,13 @@ static void do_crypt_operation(AspeedHACEState *s, ui=
nt32_t cmd)=0A=
     uint64_t ctx_addr;=0A=
     uint64_t src_addr;=0A=
     uint64_t dst_addr;=0A=
+    uint64_t tag_addr;=0A=
+    uint32_t aad_len;=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
     size_t buf_len;=0A=
     size_t keylen;=0A=
+    size_t ivlen;=0A=
     bool status;=0A=
 =0A=
     if (len =3D=3D 0) {=0A=
@@ -734,6 +751,20 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
         return;=0A=
     }=0A=
 =0A=
+    /* GCM uses a 96-bit IV; the block modes use a full-block IV. */=0A=
+    ivlen =3D (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) ? CRYPT_GCM_IV_LEN : b=
locklen;=0A=
+=0A=
+    /*=0A=
+     * The hardware GCM path is only exercised without associated data (th=
e=0A=
+     * driver falls back to software when there is any), so AAD is not mod=
elled.=0A=
+     */=0A=
+    aad_len =3D s->regs[R_CRYPT_GCM_ADD_LEN] & CRYPT_DATA_LEN_MASK;=0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM && aad_len !=3D 0) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: GCM associated data is not implemented\n", __fu=
nc__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* Fetch the IV and key from the context buffer in DRAM. */=0A=
     ctx_addr =3D crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);=
=0A=
     if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
@@ -758,7 +789,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&=0A=
-        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,=0A=
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, ivlen,=0A=
                              &local_err) < 0) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %=
s\n",=0A=
                       __func__, error_get_pretty(local_err));=0A=
@@ -769,9 +800,11 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
     /*=0A=
      * Round the working buffers up to a whole block. Block modes are alre=
ady=0A=
      * block-aligned; the stream-like CTR mode may leave a partial final b=
lock=0A=
-     * that the engine still processes a full block at a time.=0A=
+     * that the engine still processes a full block at a time. GCM handles=
 a=0A=
+     * partial final block itself, so it operates on the exact length.=0A=
      */=0A=
-    buf_len =3D QEMU_ALIGN_UP(len, blocklen);=0A=
+    buf_len =3D (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) ?=0A=
+              len : QEMU_ALIGN_UP(len, blocklen);=0A=
     src_buf =3D g_malloc0(buf_len);=0A=
     dst_buf =3D g_malloc0(buf_len);=0A=
 =0A=
@@ -855,6 +888,24 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
                           "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
                           __func__, ctx_addr + iv_offset);=0A=
         }=0A=
+    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        /*=0A=
+         * GCM authenticates the message and writes the resulting tag to t=
he=0A=
+         * dedicated tag buffer (HACE18/HACE8C).=0A=
+         */=0A=
+        if (qcrypto_cipher_gettag(cipher, tag, sizeof(tag), &local_err) < =
0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher gettag fail=
ed: "=0A=
+                          "%s\n", __func__, error_get_pretty(local_err));=
=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+        tag_addr =3D crypt_get_addr(s, R_CRYPT_GCM_TAG, R_CRYPT_GCM_TAG_HI=
);=0A=
+        if (address_space_write(&s->dram_as, tag_addr, MEMTXATTRS_UNSPECIF=
IED,=0A=
+                                tag, sizeof(tag))) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write tag, addr=3D0x%" HWADDR_PRI=
x "\n",=0A=
+                          __func__, tag_addr);=0A=
+        }=0A=
     }=0A=
 }=0A=
 =0A=
@@ -985,6 +1036,9 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
     case R_CRYPT_CONTEXT_HI:=0A=
         data &=3D ahc->key_hi_mask;=0A=
         break;=0A=
+    case R_CRYPT_GCM_TAG_HI:=0A=
+        data &=3D ahc->dest_hi_mask;=0A=
+        break;=0A=
     default:=0A=
         break;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

