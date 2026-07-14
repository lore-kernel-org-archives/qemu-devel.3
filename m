Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CCFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXaK-0005w9-D4; Tue, 14 Jul 2026 03:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXaA-0005sD-61; Tue, 14 Jul 2026 03:29:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa8-0006WV-6N; Tue, 14 Jul 2026 03:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN80l+12ncab5tkb0Ame2PB7VRY8KWhbwBOjvm7+FNoOCdJpaHAEMoR7y35rrvfKPEc4EVBNXyLbH7Uy+DcGf+PoLRloLLIpV43Rv+XwRk49rZEy6xBRomPvVvDynCPV5pX8t4YgHoDjkyjfNxHhF9qNkooqrxDeJzdMTFYpbuu4mNQ+kickksMA3kVDFhxeqjdEYHWnGMLJkQY9Qr/rHMLZ47DGj2TQJVChzEdemze1IRPT9m42fJ93JcnwFqi/e5j+YTyxMeMMOtqcYcPh6aguHi0e571XHPRgsdpVVTJkjq+tVDu5itbqexPa9DPZKxs1OJacP4Q3T8NTwdjgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eHk75Ab4w0nY/JpyBHUvyAkBW2Cyy8H28AmJ0u6atc=;
 b=HLNJ3uldHFsVDHmi3DI3V/ZyiX3UsJ4IZ3uxoiziFuLj/inkqmW58frXM9BRvR60qRygO94D7f7U0z/sAzNfUEg8cPaYiFst2iCLSB3MVH1MkdAjXe0ltqp7EiZDKbM0h3DGoto5bw8fUxB/fB4eBFTRhA+taJ/pLJo2zWITJF34dvxuzEr6/yOmFq2WXAvu0LrxtJMJyq6+kLkGThNsjUHvHHqX2l/4CNdhWsmR/BwnspXIbhQb+ReOdqkJDsehvteUZCyv+5KxmKuRpkScbbkB4sq9mlOOK6GoqHCuisr8Z0CDCfAYSyrAw1Kix03tMbRxre5zValPnxIfS1mEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eHk75Ab4w0nY/JpyBHUvyAkBW2Cyy8H28AmJ0u6atc=;
 b=mrUk4HjqMWgEmAZxbez880af2c1NAtu7f3uC3nAX9wnIoR++zSKoMHBDYX1w+5PEMac4Vpf09vhPLaf7f4NSyIPTk/r7CpyRmO5veu/dFwntfUFiPPXdWzdQPnr754hiEn35OFCzxUXSNGihxrrbeB70wOLQB5+zpXiCBvTAS9Lxph4x1oz7fHSafMCYvFalTdw26NKchaXx0+XKQ9bVmvOfwhKFjQN8v8UDuOGL2YTuR2Ak1aZ1C0BJ2nybFwXHE0f5oufcsrcANco3gbfMSyj637G5NwUYTbbzK1prUQ/9aQ0Lmd9pCIynsbIs3kILlXoZf2XhHCOYLTtA7qUwag==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:19 +0000
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
Subject: [PATCH v1 12/15] hw/misc/aspeed_hace: Support the AES-GCM mode for
 the crypto command
Thread-Topic: [PATCH v1 12/15] hw/misc/aspeed_hace: Support the AES-GCM mode
 for the crypto command
Thread-Index: AQHdE2J7h1m7BosknUGpGGXQbFxPng==
Date: Tue, 14 Jul 2026 07:29:19 +0000
Message-ID: <20260714072900.3023742-13-jamin_lin@aspeedtech.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: 6fb82142-55d9-46cc-0500-08dee1799e62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 3UmFdFtLRW/fypRSXC1ISGs7R+X2usZ6OwbO78fvgoIdbKTpbHs3Z/9Of+rV9peuPd1kaAZl/FQQ9nSp5FS+JHbtM41HVtmqf3HS2SLtlqQ09wyplsAFUP2gIN/xC/duCSaw/nBwV30JIAGI9eRN7iAvCe19ZYWCPsGY2MZHafeHf/8mrY8uyQNnwZG8TEnO1WULsWIUkeCZbY3Xlbb7lEq8JD5wgAr2dtImyTNCf8IOlk5dlA6MKJS9TZXm5EWEvLesYF2L2EX1EfjjswYjwujUAUIQ+0vaB3enZhG4qVsAuXuhIVmXWCMFW103kb5f7S4m6LpAWhBq8RZBdmKTmWyPZ+2ufEHBOiQZgWQFgRIXKEe56U0AofF3oJyVr2K6Emhm1glLMBzEKGq04kXuifNXCBwuVhVy1qF3pVIVcCMwDf5JOmDeIpcj0PQo40O9N9m4W/EpyCQaSY92O4hRC5tzuXRdP9x7n7WCDLUSgbc9M49emkW4dKys+Mwh9sC+/yKyeAXE0BGwDTrHsjW3BS3YoZ9ST7XgJPNojf/axINYXCHsl+E0JQn2QgoveAYw5JHJPnE4y51AVeZk3zfgjBcdXpaWBzWkETFxPwe7a/dgnAGcTZX9uKXjYb5qdjnIykZgENiU4dBc/gPlo4fZjDMVpyMGN0MqVmH2ixDfdM+Knt3AIcUnuBm0iG9VFElaE6pb22wFrdpVX8BIo2fQkjdIr6DUYvhw+ayyZND5j1hk9SQG6TrPzWfGwY1fm18a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RPlZJfaj640h2W1r+UstOsrRkrQXc/Lv58nYnGORY/8xBSGcziu6A0esBB?=
 =?iso-8859-1?Q?jDSqkaeTVj5f9nvIWPnMKDNaCIrHDfUp8kDq2exSzyveM8IMIkYZyncQSr?=
 =?iso-8859-1?Q?AOXOLDkt/qj/zqrynu4N5//1W2ffhGxGkyBco3FSnlZvGUnXYhr9M0XW58?=
 =?iso-8859-1?Q?N86XWOWC592j5mo+Ge+T0TRW14p+d4oWA8zs3arGePyrU7k2v54FIRe1Wk?=
 =?iso-8859-1?Q?qNGLDnUP7PTC1uOUeTShUKITKy1RifGs0cEFOzlXuzmTJmfFN0IuLorf19?=
 =?iso-8859-1?Q?Bn9G5Fw4GGvvLZuAwKtoTwRDy6HKgQ8KbdqzAc3Fyn+ptz5hEFaTQ6i0tG?=
 =?iso-8859-1?Q?GQ17xRHkgHWzhVjt+ifKzlUG/AR7vVN9jMkyN7Ug3q5kPdSJ48fshwkmfk?=
 =?iso-8859-1?Q?r24zQVAVzbG7R+QHGqvIS/jFvPrskn1bIpOEwwI2T0zw6vyopVVtektXNd?=
 =?iso-8859-1?Q?oYEDiVfnEbRBwZrgJ6plcr1iSS9mliE+g3m9hbtAgl9jDvBuoIQJHzi0BE?=
 =?iso-8859-1?Q?6aDRT140Ko8ypeqTVOIKdTIZo9aVccMsY6Tr0n2SK3UzL4VLeu+VSSdMF3?=
 =?iso-8859-1?Q?Ci8T/yDjafc0gHMk4to2RPiZA08rIomv8+ua6kwiVueT+GVP9fu7mhooCh?=
 =?iso-8859-1?Q?1GWyo4LOqmw41cABekTF03mEV65ooJGhWSmk6Z17DZaLhDjTNz25zD/wNU?=
 =?iso-8859-1?Q?JcF0cFDEIzhkBOfYVAxau+wkV0zk4lPis/1HUC/M+PnAjeS/wiQOzTkgRO?=
 =?iso-8859-1?Q?BZK8t7R/ige4W9eYsRICcypuiFZFqamiArEHt8v4/Hu7Qj+wtis1r50PzA?=
 =?iso-8859-1?Q?gwTdE0ScKj35VxwJkcINhnS6jCUeHpoITVjt+qWIdhjWfWoxqNEq45PLJw?=
 =?iso-8859-1?Q?93EIPaus8ws+mFDUEkI6jyl/H0BPkzU9xGaGCoIVK08xNyq9u1bopeEidO?=
 =?iso-8859-1?Q?JBpXL4POYhTGKrTPHuoPuWjsCF1WanXnyS7XkoGEcY3boPQ+shfNTqGToq?=
 =?iso-8859-1?Q?aoSwjFRgbGh5PvqV4MF4VHntiJ5FaaqG5oQMcVKkb+QdgZi2aXx/5qG95u?=
 =?iso-8859-1?Q?YlpDQYI/jpKrfnFXLDA/H4POsU7hlNpClNwLCUIxTdCvYXWhBnyWyv0V+F?=
 =?iso-8859-1?Q?eklfWUQlIVJQ4lzgfwDmaaVJnrMXZsoKJEbvPovn9RvkEgcsdRlIAoOg0e?=
 =?iso-8859-1?Q?xXOYCQWxNl63GqowQsQEvusnCJKWz9HSzFWk3Tt7rxmmb0svBWKhkRaSz9?=
 =?iso-8859-1?Q?hdMmrqHSTiuunZusoaJ6GQ2S+iYrttYc/c9Klu0vBBnSUKCkXvDa2EWPKw?=
 =?iso-8859-1?Q?2YuuX08M2eR0HO8dTKeFQgg5pQRKVRrzh74apY5gZvF994cN+6cJZXhbBW?=
 =?iso-8859-1?Q?VNK6jAgqjbKb50WuZeK3GkY3XwlDJ7f1CXehml0MFTVdtT6J9MJdTc3hsg?=
 =?iso-8859-1?Q?ArdgD+gnFgRxrsangoVmjlnYfjEENZH9LFA9aVv/v6+6ClICYiLedYWwJD?=
 =?iso-8859-1?Q?UGGx9K+CH2DjPUSxvyV4yYiQwZkK82POhkmEHxUvTA9Ds2YVGCb6XoWl+p?=
 =?iso-8859-1?Q?CW5dP3KMJUqMSXfvL+RONM9o1bojlpRnlMr/Z9XwmfHHnMUimZSkHlEkYE?=
 =?iso-8859-1?Q?e2312cqukE7igE1gQjl2xOsMHs6f5KHzzkn+tzKeJfNhAex53qFO1vr8n0?=
 =?iso-8859-1?Q?TXlLqVfpU+z4yN3XvZjd1QORh7FgDL+tEWhOHoPriYuj29q+rnu3eWvrpI?=
 =?iso-8859-1?Q?K+24kvY1WfvOf5LwNXhNHkjZKoQRTrHv1bZJNQERWbol17iZ6CkFYF+E9Q?=
 =?iso-8859-1?Q?7wIIP3WcPA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s1kLLwuK7byYFiksYPIhqLYmS5zF1NnWS6kjE3VyZVx2KIgEelylLtOMOlh6pfKgXKYtrFex/BtFZd8xA18j1ASOFRdSludSUjRNdHi59S3HDU/xRyGzQWkBhXhO1DynMUwUBkyVD2bR5C/rN2uLc8yqKmxuz+tuss+dLGmg+G3mHoFFiHcFZz/5tHkECUGe2QKzjOz0faN/bkSE1tL0kP7e14oRURjIHTl4StASr+fgs6qGaSqNu3QDBmgxv7MRVhH5O62vhpP9Lm4oXAXiv2z7xt+o+TR0AFDRAkfx71NZJ16iWcPIs6clSlST/fQ0CIIXQh0CU5MzMPaZ6jFIYQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb82142-55d9-46cc-0500-08dee1799e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:19.5585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NzvUULwYDVHlucxz7K29MYWE8dDhXQviIawa3/gU21x05NhBMQawuYTbnUnCT31WZ+lXfWB5fNE5gGKM71jzyjoMLUdDkvvjIz+cJ47kII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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

Implement the AES-GCM mode (HACE10[6:4] =3D 0b101) used by the AST2700=0A=
crypto engine: decode the GCM selection, read the 96-bit IV from the=0A=
context buffer, operate on the exact data length (GCM handles a partial=0A=
final block itself), and write the 128-bit authentication tag to the tag=0A=
buffer (HACE18/HACE8C). The hardware GCM path is only used without=0A=
associated data (the driver falls back to software otherwise), so AAD is=0A=
not modelled and a non-zero HACE14 is reported as unimplemented.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 70 ++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 62 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 60dedee6a3..b84f83c0d3 100644=0A=
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
@@ -43,6 +46,7 @@=0A=
 #define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
 #define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
 #define  CRYPT_CMD_CTR              (0x4 << 4)=0A=
+#define  CRYPT_CMD_GCM              (0x5 << 4)=0A=
 /* AES key length HACE10[3:2] */=0A=
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
 #define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
@@ -58,10 +62,15 @@=0A=
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
@@ -598,6 +607,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCiphe=
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
@@ -691,11 +703,12 @@ static uint64_t crypt_get_addr(AspeedHACEState *s, in=
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
@@ -705,6 +718,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
     g_autofree uint8_t *src_buf =3D NULL;=0A=
     g_autofree uint8_t *dst_buf =3D NULL;=0A=
+    uint8_t tag[CRYPT_GCM_TAG_LEN];=0A=
     uint8_t ctx[CRYPT_CTX_SIZE];=0A=
     Error *local_err =3D NULL;=0A=
     QCryptoCipherMode mode;=0A=
@@ -713,10 +727,13 @@ static void do_crypt_operation(AspeedHACEState *s, ui=
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
@@ -729,6 +746,20 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
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
@@ -753,7 +784,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
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
@@ -764,9 +795,11 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
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
@@ -850,6 +883,24 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
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
@@ -980,6 +1031,9 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
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

