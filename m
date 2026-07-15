Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438FEC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNd-0003CY-Cc; Tue, 14 Jul 2026 23:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNH-00035n-48; Tue, 14 Jul 2026 23:33:31 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNE-0000nz-UZ; Tue, 14 Jul 2026 23:33:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Saixbhjy3sncIH2Z9HQM3j6WVDR/20MUOXC1rsyP/qJ6xLSezj41I+Nnj6XuWYJEgQM4CUE2Bv9podbKZMifIIeOq5P7vHGHCM+PTT0Ao4DTkZHBMcdHh0fATdue0lxOPj+OQpRe2dDPjwRhXoERUpbsmrc14sZKr6ykqBEYlXXjihk2NbRxeLjDam/EtrMvN4LCST/z7h88LxDB/3jk8uNfWukLuzNTYE8wuwmrSck1GQizMR39HFvO+LxNOCh2HVbge+wricVDBwaELZZYjwD/rbUy7I7TAjkBKud5C4kFlfBsfY7w0fme/DptKbMqCxoP7rBIVVXjjXEDh4kYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJJj6wGVcUuiBOD/MnCuKP3Jdx7Zvaaa1CZNBt+15fA=;
 b=yGoqbnJg5SMtklXACMmR8tBQpyeYCQc1FxR+cz7EJzHqpB957FND0lUU0FPabzyzwAQivZJfOEXemoOJKYFQV3vA1DacWxA2exAoNkNN9ejj6G70d7hzaw7Su2CyQlhp1+0sVPcWQz+MfuZKQRUE/zmRuJ6AVaR6yHcimp0AjZ7uEtPOGmRJs6QWVgTF7Gzis2UYWcikjRcJ42rEzzbs5v56M6iD48uMNb9cfvutWZjDFiQrzhdw/JaUDXPhnqDakgCOF2/A92wJICW4lqou7eLFc5RSbXNumSb3+zQ37dAiorwevrVITfscbY+bGC9xvpCJUYY5wfAIUiRDA2oIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJJj6wGVcUuiBOD/MnCuKP3Jdx7Zvaaa1CZNBt+15fA=;
 b=pRszqg/vpBxTYcyBjqnRz0tw9+TJpXMJZjFqBl03zp+T7LjyW+u1WcOK5VVeRciZWACbQSeNz5bYC1EAg9mlOho2alhOaQAtZG5tupfSKt7BL2MPy3lHe67ghKj9g0aoo068wyNFdGx16zAmm5Xrh2Hk0NXVXNPKVCFbAnOcYIDktpQR6PirbfGZ4q5gj46NuOhdiUyHNhGKBgUeDfTZcKprlId8U5Ifj2I2hetiUNnB2gETs1b1G3oudG/lVLDfoFMk+K9hJRqU0JPZEqwBtL8HmzLfcmwj6G1ws5OdD2WUBGSNv0f9zEoBtMemDUJLN1Svgy1ySENKap539mugMQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:19 +0000
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
Subject: [PATCH v2 04/17] hw/misc/aspeed_hace: Support the CTR mode for the
 crypto command
Thread-Topic: [PATCH v2 04/17] hw/misc/aspeed_hace: Support the CTR mode for
 the crypto command
Thread-Index: AQHdFAqt24s0eSdzuEOMeIzmJ9g2Fg==
Date: Wed, 15 Jul 2026 03:33:19 +0000
Message-ID: <20260715033311.1648424-5-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: 507a344a-0f4c-4fa4-31ac-08dee221d065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|3023799007|38070700021|921020;
x-microsoft-antispam-message-info: YT5/+n+fqbZcicXBmH+RcPURU0yTGdwBpyfpsdpnrfgWm6dGPFcTNCCzopPbDIjMkp1/xJWVukbWF92yIGUORKUUf1VJe+lf5+4qQmUBLLsbEMRSK4q/tToYIRxilTdHO7PT+8HkqYcMry2XjTon1NbG0KpAnkhsUhYYUk/z8s8SE7CLiDcK4OeDGNap4RuBGTSbFUr3Fmj2RQDdFQT/I9xBizAE3IO0iPSH5STYt07rC2QyVlUvaOMpL4OSH+PgC1i++VbITPd1hKoPLE0aXe9R/J1JAUcjZ6DWcZQJS/OVZ3xC4wV+KtaznyRuhtMVIH0tLCTapTKKdajU+wvs1Rs+E5LFxgNNVajoEHOS0JisV0LUtKDE9SZ9qF5I1kJee9Lf/k7FN6cbDov70UHsb/A0Hv8/QPFNnyrrOprM5fsRlOvYGjjmlNiC3OWKPCulevYy4Q0ODqjy1kwdoupxTJXPJAcqARbw9maZ8rmtRSHtRw4ZbWAYQZj9cjOooSJ2zmWznc0Uxo8/TQGovj0WKm5BR/QR2kqXLqLyA/KiZj6w8r++uBdsDIXBWC4CDkWRijlbrGjZGtJl3AeBZQPjE9H5PJ11EvfplYgoJgi0Ly+LzVOfx7FdhLqfSiHyqLn8h965ZT2lvCNy512Bsthlrwz8uFB+k1V3Brw609MUaW/r5MVyHhORDmdA/piByukyqwnkNcM0O3Jd1vBFcxFc68ia7Lb3q1k+DN6upAyiVBS3IMkJ7dT9Ta2S7GmpMDPD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(3023799007)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QkI7j37aThmcEj7CLPwAi9/bGZw2O0+NF4xVhcfOvEqUNbB+Zhmk6PV+98?=
 =?iso-8859-1?Q?YJaDHxQ4tIEE0evTx3wxpEWJCzKVCanC6Ds3c782y0bO3fIO3RHYQ0+BoN?=
 =?iso-8859-1?Q?gIcQU47tvJi2JT6QspDJci2+0ZaKW1yTFyMbioRV5KlVtDNLnouxsoLBdW?=
 =?iso-8859-1?Q?OxLmnkKJp1L8GOahjWKI8JUfzqYxXOZ/I+j4jeGWW1my4bOOjsiPAnwyLV?=
 =?iso-8859-1?Q?SCNO7nDSQEcbM6y/maa05/WvselWxRIz1EgdyNSNcime4wP7oNTZTzTli8?=
 =?iso-8859-1?Q?o9JQkQPxZI/us+gRqB/y38QWF6lfYM27ab9SQOxqcrJksxrWA8su0Oujh5?=
 =?iso-8859-1?Q?LL9v1XFOjWX+0AoDUnkg2vQI6xxwciZM04flER6FPFVrTzhlibdYCm6SKp?=
 =?iso-8859-1?Q?UsNlkDS2NSe87c4GykUhbtP+3nRvSolrscNB+BFqm4hA4miC2cW2wbygeZ?=
 =?iso-8859-1?Q?hslABJwON8XUgrzTsSdqPMxiUZGmtJGzlXhLDb1b+5FFgGz7uAno2Dd3Zr?=
 =?iso-8859-1?Q?hgihs9ZwfNdWdYs+nEPgJDlU+2yL6OJb31G68qvovE2ZaM7YbdC5eS+XRi?=
 =?iso-8859-1?Q?A2qD27z/uSi0LUZkIFJkT4oxCW/Airc5yTju8VKU1pmLpZM9IZW0Vm/TUX?=
 =?iso-8859-1?Q?6V9CGhW3D6HtWxXx4m09fR4bRzHCbdoresbO9Cl5QzzRxLn0Y3wU8d8nG6?=
 =?iso-8859-1?Q?NAFT7lRueTA1BcKjl+dRLFTEpv7Y7fTotyTrgIFXW6PKxMaeGCP8WwnY8U?=
 =?iso-8859-1?Q?dx5uSky67jyn/PauSY04BWV4l2XCXR2hJL8F/92726/QjKh5wOgRfeONaK?=
 =?iso-8859-1?Q?KBsRGk1oZ6xdPmZH3QadZz17ggo80PH5v1NdrZOB3YaR4MY3dpWDwIMeKG?=
 =?iso-8859-1?Q?Vu+McbgBKpXCdHIjCVEB2moow7HoWegPhJZb1AXRlC+2TzSkul3sjsF3P1?=
 =?iso-8859-1?Q?nLj+Y6npIp851AbisojlSWy79VZ6Rmu9+tNTrdascAAPxnMgvIFq4StkXn?=
 =?iso-8859-1?Q?zrR0Auk7kLF3nLRQ1qRWM2tzv8mHk10/Ym2dRykym95rO9uw+UYrFUy8qu?=
 =?iso-8859-1?Q?BuKuNZVT/pg9+96O7rLs5BWXrBijlAeIyfsocFlZDiVxrEeqgRuGk1WaKn?=
 =?iso-8859-1?Q?esPlFo57i3G7bbqOPqkMgmHwYBL7MO9AEFAku64y2MjPBbY+QdvoT5UVY0?=
 =?iso-8859-1?Q?wC7NozdBD+8s6tDjGhF5lknw6rte0upOrM1J60i37pl3WQIxN6M2OwR0pn?=
 =?iso-8859-1?Q?Ma9MUUrBdOeveLN3tZ9uvS02QvrOU74LivaBCly8k7Rj0RuV1QRbjCN8yX?=
 =?iso-8859-1?Q?7HJ00amSU/EsK4EqKBftes21nx7gxWETpAY5sOXVkPz11GdhOktiTMKHn0?=
 =?iso-8859-1?Q?pkkeSjlXw6+9blyUkeDsLlnKxjm70zsV5EOCRFFe0W+S8xLlPR9owApFSe?=
 =?iso-8859-1?Q?zPIKci/e19hQCOOdTQpm1bQqBwglYnAmaBWuwFDXsY/74kXlmnZYOQ9jiR?=
 =?iso-8859-1?Q?r5O3qFnshLxe/5g7HreHpAY088kmVzYB5VKuYFQu6mxJjDBJtAUv3Ut6Pa?=
 =?iso-8859-1?Q?VIp8G0dfqEcHYcgGifsaYqAfIc/U2c0Phg/1YvBmETXl7RVJO3G52f0o74?=
 =?iso-8859-1?Q?n29wC3OTD/h0r9qojo5kVexdepH18o+s5PdMMMsEiTouGZcvO3EV8UCDjy?=
 =?iso-8859-1?Q?cDuq+s9Da6INK4l4oikitzYaaDek9J+YOt3rDIzmPwBqzkLXZGhmg+rHiW?=
 =?iso-8859-1?Q?wutzNVPgv62JnrvF+bDX3/l/9pTgvrlcYbCD9rrZxy1wrtN7YiMYgvEquo?=
 =?iso-8859-1?Q?Ag5b5WfFqg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LTU6oTlgOQyXs98eawwpBZtbmltPI4y8P7HbO9PGzcfWHz2CQ2l5PZy+ZtvnvvqhQJDOVQGkq+6Nt5Q+WjUOww+CpFQjY7e3mRwoat62R4AS83XXxw+X7TdaKeBLRe2NvsYCjvD1kneZXUXNdvuwpRmMQQk1zJ3qQoBcMu15mPXulpSZhcHxuLSvMIRKqIbYGjxKzs+LeK5VNmCCdWBAqH21Q/j+XbMo8XWtrbg4aESoC41dT1YjHM0MixvF2012xKzfOrXQohZU3MHUj5ENCWPrySVQPof+7N1mb6eUnxv+4kqVI347pD5hVPHbLmx46GjFnuziHbJ11oOWVId02w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507a344a-0f4c-4fa4-31ac-08dee221d065
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:19.1238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxwLupBN4FqR3gOTe1hC1U/5fkS1fE9XHvW0rsJHt6KlZTpciKHtVhaE4sUkUTcZ8v37Ty74gxqkoFMibOfTw8l6ATdEq1fxfPndk2ODPoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
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

The AST2600, AST1030 and later crypto engines add AES/DES/3DES CTR mode=0A=
(HACE10[6:4] =3D 0b100) on top of the ECB/CBC modes shared with the=0A=
AST2500. Decode the CTR selection, round the working buffers up to a=0A=
whole block so the stream-like final block is still processed a block at=0A=
a time, and write the counter advanced by the number of blocks consumed=0A=
back to the context buffer so the driver can continue across requests.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 50 ++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 45 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 3d3f1fc8dd..09d0515271 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -42,6 +42,7 @@=0A=
 #define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
 #define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
 #define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+#define  CRYPT_CMD_CTR              (0x4 << 4)=0A=
 /* AES key length HACE10[3:2] */=0A=
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
 #define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
@@ -589,6 +590,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCiphe=
rAlgo *alg,=0A=
     case CRYPT_CMD_CBC:=0A=
         *mode =3D QCRYPTO_CIPHER_MODE_CBC;=0A=
         break;=0A=
+    case CRYPT_CMD_CTR:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_CTR;=0A=
+        break;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -652,6 +656,22 @@ static bool crypt_prepare_sg(AspeedHACEState *s, uint6=
4_t addr,=0A=
     return copied =3D=3D len;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Add @add to the big-endian counter block @ctr (@len bytes) in place, so=
 the=0A=
+ * CTR mode counter can be advanced by the number of blocks just consumed.=
=0A=
+ */=0A=
+static void crypt_be_add(uint8_t *ctr, size_t len, uint64_t add)=0A=
+{=0A=
+    size_t i =3D len;=0A=
+=0A=
+    while (i > 0 && add) {=0A=
+        i--;=0A=
+        add +=3D ctr[i];=0A=
+        ctr[i] =3D add & 0xff;=0A=
+        add >>=3D 8;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
  * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
@@ -677,6 +697,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     uint64_t dst_addr;=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
+    size_t buf_len;=0A=
     size_t keylen;=0A=
     bool status;=0A=
 =0A=
@@ -729,8 +750,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
         return;=0A=
     }=0A=
 =0A=
-    src_buf =3D g_malloc0(len);=0A=
-    dst_buf =3D g_malloc0(len);=0A=
+    /*=0A=
+     * Round the working buffers up to a whole block. Block modes are alre=
ady=0A=
+     * block-aligned; the stream-like CTR mode may leave a partial final b=
lock=0A=
+     * that the engine still processes a full block at a time.=0A=
+     */=0A=
+    buf_len =3D QEMU_ALIGN_UP(len, blocklen);=0A=
+    src_buf =3D g_malloc0(buf_len);=0A=
+    dst_buf =3D g_malloc0(buf_len);=0A=
 =0A=
     /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
     src_addr =3D s->regs[R_CRYPT_SRC];=0A=
@@ -751,7 +778,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     if (encrypt) {=0A=
-        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -759,7 +786,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -792,13 +819,26 @@ static void do_crypt_operation(AspeedHACEState *s, ui=
nt32_t cmd)=0A=
          * output when encrypting, or of the input when decrypting. Write =
it=0A=
          * back as the IV for the next request.=0A=
          */=0A=
-        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;=0A=
+        next_iv =3D (encrypt ? dst_buf : src_buf) + buf_len - blocklen;=0A=
         if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
                                 MEMTXATTRS_UNSPECIFIED, next_iv, blocklen)=
) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
                           "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
                           __func__, ctx_addr + iv_offset);=0A=
         }=0A=
+    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {=0A=
+        /*=0A=
+         * CTR chains on the counter, which advances by one per block. Add=
 the=0A=
+         * number of blocks processed (buf_len / blocklen) and write it ba=
ck.=0A=
+         */=0A=
+        crypt_be_add(ctx + iv_offset, blocklen, buf_len / blocklen);=0A=
+        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
+                                MEMTXATTRS_UNSPECIFIED, ctx + iv_offset,=
=0A=
+                                blocklen)) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                          __func__, ctx_addr + iv_offset);=0A=
+        }=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

