Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C2C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYb-0007Sf-8C; Tue, 11 Aug 2026 02:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYZ-0007Qx-4m; Tue, 11 Aug 2026 02:01:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYX-0002gH-3a; Tue, 11 Aug 2026 02:01:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smEBl2Z8gVxqDnNy7o7CHRN1Miox7RLWJVNmYMWlmmUuKO3KMK0kVmVluf2KWMQiuVGP5B3RNua8AYW9yRy+QV0o+NfTgTcwD+3D2wrDvVdcF20GK3vIYfE2wl6UGy7EC9yiNNNYO19e/ByOD/je6qjRFsEutFmmoAzi0BisNISGpJYp3so1ZwxVZyEA5R1uGtFlAXSM2Zg7i8CwSdL++wPEmb6oX8bd0LFmyX4/IsvyF1mPpAhpcOBZ3cNQNezyVnqiNyI9T9psji4yNfWue006GgQw+34YnyR1Ui4Gy/asLJ7yFEw7iRzGTEnCdz35VYy23798cwehZYOjyfwf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6WGtoywc4Q3eLsh1V4ELyHG2WMpQRO9os4JxCwu4UU=;
 b=DFjHy3xhhYZTBiwCbUofOelvxL5ps7a2txwTQKRo2eFE/dU+mas70/UWMeWOezyGUtpeyXGXsoAvTbGYz0WUjPYuMFkcosw0BhOV2x2RORhWWFULQ/N9Lf9Jo7xbOXycsRMmcZuoWKESK28P5WM30iVhLKgaYtZFlKsQmbUBRYecaa0nUryrcErQN5KwOYEdqmUzKR3OAHg7m+bBJG1n++8QOB8/Pm8xB0xE1XQ7vesyDCzjh3RsDhXent0kuqZ0RUaJ6XRJrKzED4mN/poIHeF69Ldd596q1rAOWQM07aYy1fj2w1duiitCP7ikAcKLVKZgZOtwtjPzspFx0D4sHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6WGtoywc4Q3eLsh1V4ELyHG2WMpQRO9os4JxCwu4UU=;
 b=jYrx1fOkJ/6j6EMKjyUYjf8blC30yWrR9WSiWnO5T3/nKxxcCCz//okRZXn62sYRYeDW46c5xDW2ym6/uYxkv9FrmUTNpwt4+Yde5GnxskdqfnUekUtzzjVaZnBqHRaMmDdxB9gMmPS4Yj8EIsiLKFUUtAN/p36YH4Z4+Mg1denJWH/Bpb+Cg/BQs8Lou+01+Kd1WkI+qN4W1CC9azYOsajRLd0tJGOn+dXsYHOUHsw5qzBtju5ftR1Vs/469vVTRuiHCoDDoE1xAQgFgd73g10UnqPk+QaE7IlYG6BguaiRRtN0ZGJDVEBagaZnElbtXoAqnJSIk7Qea3c23zM+pQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5419.apcprd06.prod.outlook.com (2603:1096:400:201::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:35 +0000
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
Subject: [PATCH v4 14/16] hw/misc/aspeed_hace: Support the AES-GCM mode for
 the crypto command
Thread-Topic: [PATCH v4 14/16] hw/misc/aspeed_hace: Support the AES-GCM mode
 for the crypto command
Thread-Index: AQHdKVbd2Oji+/E5aU2ETjub3Xyf1g==
Date: Tue, 11 Aug 2026 06:01:35 +0000
Message-ID: <20260811060115.1849266-15-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5419:EE_
x-ms-office365-filtering-correlation-id: ef266db0-48b2-4250-2a56-08def76e001e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|38070700021|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: MIFnb+CDj+J1qXr+BR1NkJO1eaVBEPb4rFme9fILP/xL15mUq2SZAGAyWTtVaxJEWU6SmPQTc6929KHTTugKVphdO5/WS0RRBE0tZMzzw6gYzRLZo9v0FMfyFVEW9KaoqhJySTnqYDF9PdWWnpIZ1DeYxqqekkQ9tzkFuMKYgxITixCnuU/PbT5hejTmu+C8CdwwriHB8cGmuVxGgPe2c8AFh00bZZeYGvALyguVa2ghdUpFMQ1YG5k/PgCy4Lyp959zgs37f7CMwLjOHUIbKAokrNp5GE0UQZcXzN9FSkG3CI1cvrNVE5CIWlVKmho+Beplc3AYO4GIoHxDTWrtvE5iJhscDy8dEQtA3kUH4EYVj+9i38G1TgQv31Gpa8g03GH85TSH5BtK1Q6ywUFUAD/CK9svydgC0SnRrENiYXwQUz+RtsN9wz9nFCLl17/lB9gLW9n0sF+k3VKHKUgycV1z/nXGr2tnWAUQ/RuOlKirKeHJDJdzCkecyeQrnaUHEqfcRXimhF5nY07efCqfww6H1JX38CCMN7t+jd++RjRtqVhILBzVXXjd2G5XaDR4HGjMpeRCSg3WdILQWOwmQeSYfm6MQ2bM0YIVc4esyI1aBBWxpCNcDIsE6y66hvGO2nkX06Y6A2LqNqhgwJKxAfGxm8clO5fTKIGZTN6gX+40vsaqXjhtrnTy5Zm91eZik22xyB0bqBQ3LCtpSlssIiaC2QWD9ex/tZk42EbENngRbajcinTiYbZG6V5jtSZH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(38070700021)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uvZwFdnBjdCycx18x7L3J84aiAJwytEvbaTHBTb1AzhoAj2x9YgEzfihZM?=
 =?iso-8859-1?Q?Bms6xpnmMiJChaLpVAFmfRABxJ4br9nNoZ7DcrpBJVJpHHsFV4oi3dYWa3?=
 =?iso-8859-1?Q?WDbh+8h2LCs6RrkOrGNh2HsMezjxKkOHjOuUQVhNWj81AF9Kl1PySrjESe?=
 =?iso-8859-1?Q?7ZK4+Zuc42eNafItyk239GDH8euODOk85XPghdG2cp1bco/A5nhPcg6HbK?=
 =?iso-8859-1?Q?7jYzuvmVQASdRZHAwhCS/y3iYKaqXaq+W3Cv2NbuxCdGBAfkJ3bHi0hz/k?=
 =?iso-8859-1?Q?QTiATGOcObh+eK7a1ylEFLj0tst5LHSU2X8LTS4MQhAppLy08Ih/jwU09f?=
 =?iso-8859-1?Q?Vkur6jxAeYF7i0hYupv9UmtvELYeY6ozVls+aixS51mzdshb9CWNRAqlRr?=
 =?iso-8859-1?Q?iNoBSm7QlPOqrC/WfGLHQ0850I9hT4f5BWGIzjHQ4uI9djanROcfnf57hE?=
 =?iso-8859-1?Q?YPH0jwXBr33p/NYuepBySzvdTkSQyjcqlWMuQZ0q6J/zeIF5+Vaf5QfYWW?=
 =?iso-8859-1?Q?2r2e954KMU0zEBk+o7VDZ4X9z8R0xwq/EgMHKjqDCHeMcAQxQfKVkEib+j?=
 =?iso-8859-1?Q?5Y0xrLmNbM4ddU209w/GyiZezm9yiW28Y7+TmWeo6/iNbwMyzTlbPYwaSI?=
 =?iso-8859-1?Q?xkD1MMbTjsmwhRebSElKWLpDzZOJ1bP5UrJq3cBXfx5E6ODgfT+pTXXoE1?=
 =?iso-8859-1?Q?A/AooCEREuPdfmRdUsGvULgwMGtXgVuTDnBgSMrYBQCZI6aWw9k5UnxYfC?=
 =?iso-8859-1?Q?EI4tP3rtJJG8lsv3XGpibYkLgjz2922l+S2pEt1aC/1XXwuzR2sjGjYpVr?=
 =?iso-8859-1?Q?wm1F8jCJ0MFHtfjsCI5BH6zjU+3H61/3sxTA1LIDpvel9DYedI4+MMbMVj?=
 =?iso-8859-1?Q?+CsJKI+xWqdxyRr6sjMzD3CZ37jUXKpbgXx7J3qYrI0VcNcm4iCM0eZinj?=
 =?iso-8859-1?Q?Is1ANq1bv1pDwKXI9GA4cgzmPPuIVCy3aEDhpe/+cRNqsMPyBvEsbemZmP?=
 =?iso-8859-1?Q?tAXVGCs1gChIk5Va+nTHd04YstFEwCRmUyoAUjRKMAtRMhnvP6FEaIatGZ?=
 =?iso-8859-1?Q?C/Zcj707DBK+obx5aHQipQwQlwO8DL+7R9FL0MkRhASoVq6/iqoteO57cl?=
 =?iso-8859-1?Q?0PEkBriHywciEXF5hmCRHQ9324L3ARAqE1ZvfWDdBKeRtenlCn4suz+cuA?=
 =?iso-8859-1?Q?Rg1aI8K3PBIxn/Z4BDxwI07OjaI1kKc85eKKWGwdMNwQdyiCbOVEdVxksz?=
 =?iso-8859-1?Q?hZDRYPvSkiC0WMgvkoNEnc4CVDvhuaNjEbdALzNv/w96R8x1B3rPJWfs38?=
 =?iso-8859-1?Q?GHwo00gBuBAeRZv5XdhIPa59ft/NnPrp0E/2wSqcxRRkNZ5GVVQHf2S/tb?=
 =?iso-8859-1?Q?Dh01q0+0DPgwN9SFfO8bIllVftlV8fNroEDQzjwm9h+CRCZxTH1wEyntTt?=
 =?iso-8859-1?Q?qWz8jc0UGfDkKdOWFMZyd5ROEQT+j9Ij5kRDy6k22+QjQh+lmb1puCqdWU?=
 =?iso-8859-1?Q?xS/i7mPZQV8fJ6o7dutj1/X3ZiBhlDC5XYYkFkLk0Of4GLwpMRaGDZrGyJ?=
 =?iso-8859-1?Q?mkRKXc4iVMKHHBNP2h2gxxheAZ36Eu8z2EL6Ehdk0sCkg7ygcEj0JZ846/?=
 =?iso-8859-1?Q?Cwi9UyAfRmr9NxOanQLFyU4vq6Y/EpXe4lmqLsSi3ToUG4pHDo5MLubFyF?=
 =?iso-8859-1?Q?y6e6JxUhqJKFgtOXWWi9sO/ROJjkEVRiz8DlYPBSpHPsV60dqAwDuLG5nA?=
 =?iso-8859-1?Q?ALu3XOEdCU+cHx1Fh7p2+X1jCw3VhM5Qmuc8CDsbODbg86Ik4PQXz6GGAx?=
 =?iso-8859-1?Q?wUuH4lGbgw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E+zEgVFnNigTkPvhZCV1t0WiOqJiTf/NUw67w3jo//Mr/1zvIeTLGxOuqWDCxrKRuqOIZZmTvoTRcX0cTAKEZXJuaeB96scbFDeuGwXaa4x3I5f+TnFL6a9EMK8S8/c7dUZ9Hnl9HFYR/XD4nnslvluFEsithRt3GltgzbIfBPPCw9MM0kS4mL+jU9bEPGxGM8b12+WF2TRoKK/XSbYjWPDdceboMhcxTwJB3slryplvKsrqDq27Os10V/IiQDiEsvw5OR9yJk6GRj/+d8ay5seb0HlSGjnESnDQ266mBS2aISwsCp0j4yIJq4Gbc3FHR0d8nQtb9hu48ncCe2ikdg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef266db0-48b2-4250-2a56-08def76e001e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:35.3447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ys1CznuE4tltfBcafwvZFxoWokT8bSO3T5jJ9PxKrtPkkvnDEp/hQtIRztYpUFAiQtYyVZOn6Gy9WFB0eME7lFI6Isnp4MVVeZK2Smu4/OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5419
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
index 0a6e2fa829..23dacc9be8 100644=0A=
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
+#define CRYPT_GCM_TAG_LEN           16=0A=
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
+    aad_len =3D s->regs[R_CRYPT_GCM_ADD_LEN];=0A=
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
@@ -899,9 +950,11 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
     case R_CRYPT_SRC:=0A=
     case R_CRYPT_DEST:=0A=
     case R_CRYPT_CONTEXT:=0A=
+    case R_CRYPT_GCM_TAG:=0A=
         data &=3D ahc->src_mask;=0A=
         break;=0A=
     case R_CRYPT_DATA_LEN:=0A=
+    case R_CRYPT_GCM_ADD_LEN:=0A=
         data &=3D CRYPT_DATA_LEN_MASK;=0A=
         break;=0A=
     case R_HASH_SRC:=0A=
@@ -980,6 +1033,7 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
         data &=3D ahc->src_hi_mask;=0A=
         break;=0A=
     case R_CRYPT_DEST_HI:=0A=
+    case R_CRYPT_GCM_TAG_HI:=0A=
         data &=3D ahc->dest_hi_mask;=0A=
         break;=0A=
     case R_CRYPT_CONTEXT_HI:=0A=
-- =0A=
2.43.0=0A=

