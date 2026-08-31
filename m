Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C858DC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uAB-0006B7-P7; Mon, 31 Aug 2026 01:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0uA7-00069v-W6; Mon, 31 Aug 2026 01:02:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0uA5-0006U3-1v; Mon, 31 Aug 2026 01:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/L5YEMa7MknJoZOvjOnZewl9reg847BcLZPNDRCKYIUen+r/gLXBWy3we3S68ig0SHjxjXPwgiKQDkQ0U8Qt/9qllL21nR6QxPK5mxup8qUUVw0Sy2T1TXlU6ct7E+nmI5fLeclwDVoBvzWOk+w8yPATneqQoGFQRogezJv9rw8O9HX7codCwilJa0e3oCz1aCCBEn+coojMAyxfMyE/4KHGjvv567+1j92ds1JR0zAXz/23TNyyfXVbPpRTwFKP01o7fCdx0ZCUtQqMmXTm7JMqwBQHrlIVdOTn5V0Vx8jE/FUiJG6Bsys7O4zKyi8XUDJYFXJdFzyCZMi6/lKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdJBvunSEuLITtAdujsz10MVLXfdAY68bu6eUiS5kD0=;
 b=pra/U04wkP8VL3+8GK+oRusGEFWtNG8K/NgyYtO2GlTpP1+5d5dgmA7pSJ77deyQvtdDzs4sJRIbR7iS7yq0AHfdz6EP+AX5h2esl86LPxJ276HOq2TCFJ/DoULEy8ZO+ZuvaHlrJUIOykwDfMa72nlwL2LQuujAwYhcunToOYhwDHbSBVSFWTYOIGyxODPj2iUv7q4hEwIOeJD3WICnvOSfCCEHH0gfUuCDmesQOrXrpIkcAs2MgGYJIk3GmETrmLuApWnQduLQvk5e6UZSPCMSUS/9ouVfXG9lotexSelcflovKGH3Qrtg+UOPU4OPbvgjxrhZp2gdrvZlecPk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdJBvunSEuLITtAdujsz10MVLXfdAY68bu6eUiS5kD0=;
 b=CSJZAnpFLm/BoNcK4O0UgEtk3gTPwU4u3jss1Aclugsg5/T13UIC9uLx+TvSSeOcO8zw4WyFQJ+DRT1wTkS9erTahD179KP+GOd3kV5kCQpW+8qeEQQZYT6ek2Bt8O+GPYiL+xYzvcyCtk1tceFccS3AbduMPuR29uHMRJJ9w62wW8sauX4HVKdAVwgV+xUIgBWFLS9fjf6tBBSEtEVN4PY06Pjmn+zQYAKwBZFOfcJ8AtfUC5lNYT2GiTC6Xhzw9/4YB2j8zbXlwzsgFzz+P3qmRyy62IOTx0Ym/Se1ayawMCf4ytZ6Wa6eCmruYogA3p3Thf4kPVm4y/6XSfPt+w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6751.apcprd06.prod.outlook.com (2603:1096:400:476::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:02:15 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:02:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] tests/qtest/aspeed-hace-utils: Replace g_printerr() with
 g_test_skip()
Thread-Topic: [PATCH v1] tests/qtest/aspeed-hace-utils: Replace g_printerr()
 with g_test_skip()
Thread-Index: AQHdOQXjVHoIzqNTlUOrs9aIuTWmcA==
Date: Mon, 31 Aug 2026 05:02:14 +0000
Message-ID: <20260831050213.381443-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6751:EE_
x-ms-office365-filtering-correlation-id: ba8b684b-dbc2-4161-c748-08df071d0630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|56012099006|18002099003|921020|38070700021;
x-microsoft-antispam-message-info: 6TNmIqOBOIptA/L0f6q4AKGkU4vgKiTAO211fAXk96OLzY8qbO5LZJfulWcV8zGOSmvZ8vm+Omt2mYF9ZrjFTCt7OvYjkWLsw4vUQvet9OT5Xg2lep4hmH+ktk7DHAL6lEKmIaeF0nPwk1Sc334vH/UD5ywZ3no9K0BZVsKPRrumIiCkasnT0PuV2C4d7+/EzHwgrzojLMCUQ2GHVjuiq2r5WaLu3Z6meDs8QSTjXlI7JdHCqgeTKxCvnKIe6ZK1KkxU+U6Mv0uX0ub6ayDVbsHpQL50qY+PlJ4ifyYgPjVKL1JYtxkLFiSuP1XDf/6DzXTzrI9L9A7bKV+nonl5WYsb2eYZ6eqGKaz60Yphoo35iwyTw/GzucbsBGggT5I8hUEcZegmJJs3rJS2eSH4ckh1UH0XHU1Z4GCm4Pui1pbGxKazbPDoDkITLlJ/g4217fX8AwflvWQKtdNHDtbLltOFYQXzaxGl2ATjEyko5w98IJVjiZ5oc2gGsXUwFn451QUOxTvINHt+udzMs3yiXAcJ2EDLCoHACpA/Io650mH+Q0R/tRccdVjv871yPShkP3BttnKF0nKITJP2BQEGiq21MPsvwDlM4y8HmmSl9zKUesV/1b7ORuHlXVy0TXGH4Wt93z4afb8K1PlrTcYtMaol/mBZE2cFLPfLgrsPrGlMJLtVhwEDTbPggqzx71moFKJl+7/z0UtSA/Jx3sKh8bEpivOU85oWI6PMC3ScUvuZTO4TnYz30EmOrf7nZUl7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(56012099006)(18002099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vmJ3nKouAE+gkqrbmJnqhIyixmDopRH9l6/tbiQQTK5Zm/EGxFctWB/Qm3?=
 =?iso-8859-1?Q?escBDPNPZbkjxyIjYZoz+0hzFdiQIn/nCSIB5YHJKtFs0PMiLfLOPzv+gf?=
 =?iso-8859-1?Q?uqWVmjRXBnKHLUVyHayihhXpocKsOrQI7bo0bkIkliY5pKh4MF5I01h+dy?=
 =?iso-8859-1?Q?qKX7yITwyEEGuVoFnBEhdrQ9fFzxJFuurfLOzRRHpJjLfBtXOCVoWffqUM?=
 =?iso-8859-1?Q?jNJl/8MfTPdRK5slsaJ38SRqJS5C1OxWPcyqD68KpniHkQw4AC2lJvRimk?=
 =?iso-8859-1?Q?0hLLacBYI3o2g8h9DjHCc327E90sHbXdJkGoadhb0yw3xh4IsHcmSN9jDD?=
 =?iso-8859-1?Q?onprRiJtWicwbBI0REPoylwE/WLpgz3K5+0FehbP3Bt1ufopr60Ee7PDBA?=
 =?iso-8859-1?Q?C/SS+3HeepILJhWc9SSpM6uJ1JD3wjoG4oyK/mIvVM6tzH858rbwm+6egX?=
 =?iso-8859-1?Q?Jjs+EQB4LDuuQY9h7HGj3SXjcvPfrQ/9txk2cdCAZHD/Cpi6fEtmIMs4Ph?=
 =?iso-8859-1?Q?7buR2ZfHRtx3Ue/ypwFd83H8g2BGIxOeeputL3LEAIMwD11aLv53taL1Ee?=
 =?iso-8859-1?Q?28QNL0oRocoBUyiG/HNWBsU01nXtY5vYgAk6WBpBYSz5iKZHQqXE/w/VI2?=
 =?iso-8859-1?Q?nMTK0KVjybIPcPRicOQuRCqFq3JNjUKdmDcXZI/FkBzBnh95P9tUmzOy+J?=
 =?iso-8859-1?Q?iSJApNJ/HeD50PeNE3QQt9N0ySt3LfXnnhS87gOEE7UxOA/a/1NqFjF8pJ?=
 =?iso-8859-1?Q?2mVoqTizLtWHTPr8buIdQmOWMSBrfN1gQxcHlpc15w6rVweCxyDb1N+/tb?=
 =?iso-8859-1?Q?4aakcMf/ZlcrlWo7x//eqLLxpf5woedq05qWWlLfi7da07ZLB//y1Z3q7S?=
 =?iso-8859-1?Q?7pyiQaFvPdHiA/baY5KLuj6XlgNWBxvfMIKc0L5Jtcw6+uEXRn8lOEQUjz?=
 =?iso-8859-1?Q?z7zSY6tB+BPaO433qrfwEFRsmMHYqreNY7iG2z2aYucn3JWFlbHfJAYIL/?=
 =?iso-8859-1?Q?h0GEmM6C57x4YbhwMgi+ooPHNuMCB/jdlFtmCNwIcPlqTRP7xWoagpv2+2?=
 =?iso-8859-1?Q?sIL8DWr8HzAk9iaOqF6ZePSJ+fGmBsPPN+hv7Y5tCLBZiMtWeBPGhmpw1H?=
 =?iso-8859-1?Q?+W6drglM/lszwjkdbUpGVCEroGVqNtpdDn013EaPbcULwGvq2HS2ZnvdDI?=
 =?iso-8859-1?Q?TwVoIowr4NW6PECYKEAjNAa+fGfddUqYSYny0/Zyj+TGlB+8UMEhrYcrnj?=
 =?iso-8859-1?Q?cajGDNCLM8lP3VAfvgUD2SGTxdo7AYjEQZ5curuFdhVLQAo9IRrQWW5dB9?=
 =?iso-8859-1?Q?5quSMmtzkXyda58WYRB6erOyo4/dt9nt8MZuhx65qOjX2ighZGpDwrL349?=
 =?iso-8859-1?Q?u6tvGlvXZODsYpIAJzDxlCwZCITmr0UuWDXC2Sok8ueJi6ntv3zYQlXH51?=
 =?iso-8859-1?Q?L5eXFEdZVHwhnCinumb5p7a8yO7bkpu7ODoL4LKkppJDmQa1IQq1JIus4R?=
 =?iso-8859-1?Q?/8fPkw/s9Lr3IOgujbLzAj82hFbMwcPektCWgJB4f7tgEoUCw82/4O37Sm?=
 =?iso-8859-1?Q?iXWgLoRFnBCT2FjZ2s3J/rb3d+97RtrvTB1nWEdYy1aLgySOCSW6Xb19RX?=
 =?iso-8859-1?Q?KVc6v43Giu868sTH/8de8hlNFNvTcEvbpm9xRH/e2++HZtm2stXknv6X3Y?=
 =?iso-8859-1?Q?n7RGtCKd41AY1V3IKkmzQ+TKcxO7piuebMMem0eYmCkN/fw2VQgxe6daSZ?=
 =?iso-8859-1?Q?dL6QYL/47Uj2xt4ZMOxGMjto5RzQVaxhduYAU73JgSeyjqz+0JKgBOkkU1?=
 =?iso-8859-1?Q?2RiKHzFfGg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rwFnF01eGhxiZlZQOTlpblL8fDAM7rrZfpnZx183A9LFBY+p6Az/tTnmqVZlpfIfcWfKWtNRQvqJlCmRYSr+OX6FDC7Z0YkqF3MgR4FRrme6xqDNIwHcRibqfibd8g4GOVYcviXGBVHd0rPgeisPfVDvkwTGJ9clcCkDhwGkcyRwIKnLIMsa5WJz7ko53fluYLw3u2bO6NrktMa1+E8apqdhYq5Nk8TUoqGPQYezZZAzSrQHvIK7JkZL/weKdvg40oyJT68lGTL+z43rlPqVZ7iy4uyPM/Hah8zjkiYSVfMf9VOJ8xeM1WnPhy3PB+Z9xvIH+KmF43KRt0IlwNeEBA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8b684b-dbc2-4161-c748-08df071d0630
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 05:02:14.8942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypNeS0nlSy/OEVX7BvKc6rufq4pENvI6iUuT3HGvjBzi5t3E2gFZWR9NUbP+dISygtBkItUOoTFXd6LXucQV6FI0rJWTlG3p9WJKf4kMwXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6751
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

Skip a cipher unsupported by the crypto backend with g_test_skip() from=0A=
the test, instead of not registering it and printing a TAP "# skip" line,=
=0A=
so the qtest does not assume TAP output.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-hace-utils.c | 24 ++++++++++++++++--------=0A=
 1 file changed, 16 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-util=
s.c=0A=
index 260eec043c..d20562fac9 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -1248,11 +1248,18 @@ static void aspeed_test_crypto(const void *data)=0A=
 {=0A=
     const AspeedCryptoTest *c =3D data;=0A=
     const CryptTest *t =3D &crypt_tests[c->index];=0A=
-    QTestState *s =3D qtest_init(c->machine);=0A=
+    QTestState *s;=0A=
     uint8_t out[64];=0A=
     uint8_t iv[16];=0A=
     size_t iv_off;=0A=
 =0A=
+    if (!qcrypto_cipher_supports(t->alg, t->mode)) {=0A=
+        g_test_skip("cipher not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s =3D qtest_init(c->machine);=0A=
+=0A=
     g_assert_cmpuint(t->len, <=3D, sizeof(out));=0A=
 =0A=
     /* Encrypt: ptext -> ctext */=0A=
@@ -1284,10 +1291,17 @@ static void aspeed_test_crypto_gcm(const void *data=
)=0A=
 {=0A=
     const AspeedCryptoTest *c =3D data;=0A=
     const CryptTest *t =3D &crypt_tests[c->index];=0A=
-    QTestState *s =3D qtest_init(c->machine);=0A=
+    QTestState *s;=0A=
     uint8_t out[64];=0A=
     uint8_t tag[16];=0A=
 =0A=
+    if (!qcrypto_cipher_supports(t->alg, t->mode)) {=0A=
+        g_test_skip("cipher not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s =3D qtest_init(c->machine);=0A=
+=0A=
     g_assert_cmpuint(t->len, <=3D, sizeof(out));=0A=
 =0A=
     /* Encrypt: ptext -> ctext, then check the authentication tag. */=0A=
@@ -1318,12 +1332,6 @@ void aspeed_add_crypto_tests(const char *prefix, con=
st char *machine,=0A=
             continue;=0A=
         }=0A=
 =0A=
-        if (!qcrypto_cipher_supports(crypt_tests[i].alg,=0A=
-                                     crypt_tests[i].mode)) {=0A=
-            g_printerr("# skip unsupported %s\n", crypt_tests[i].name);=0A=
-            continue;=0A=
-        }=0A=
-=0A=
         path =3D g_strdup_printf("%s/hace/crypto/%s", prefix,=0A=
                                crypt_tests[i].name);=0A=
         t =3D g_new0(AspeedCryptoTest, 1);=0A=
-- =0A=
2.53.0=0A=

