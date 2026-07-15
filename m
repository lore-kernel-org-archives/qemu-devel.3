Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5577BC43458
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNd-0003Cj-Qx; Tue, 14 Jul 2026 23:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNO-00037P-Pw; Tue, 14 Jul 2026 23:33:39 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNN-0000nz-2d; Tue, 14 Jul 2026 23:33:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5H8T3DYc2esSIEayJ5wa2KePkXkZHyvWJu9TT8fWKcqmC6MNFD4sa2k77hPOQK2sumTrtnz8n3w+cUB0DnNlGZ2jjel9z4b2AEvaUVOHEMrL16YYjuhc4Bl8YKZnqG1cdXCGR1cDjEuDwvTAeehEel7LU0dNu+WvLuCp69R6XOJwvfFO05+uaF7vywGcIDCZbyJa1nQNZJyZTLQjUX3i37wMuSevgTB1BwW7VS2IMxo2AH7j/m+V6oeN8FD96FLMfpNoEmgDnH86R8NWyKotKkmcw7wDiXAMMM66rDqFY94OOSM2bj9oGkZzGYg+5+U1c4WFDT4PFXD2RlzEG2M0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MExgluedEg6+JvI+ulgp6DQLZn4mSeKDSDWwe/C/N/Y=;
 b=FxCAdXGS5GkSfradQCxQXwWpWsIqSrkbxrKGc8hdjIOekmfQb4AH2wMNFLkFVhos/4kSXkYcNiLJqhZrxjICf5V8mRwDd/CZ+hNeOye8DfUo794PBsXhaQXeHuUISBvRaP50IRJuDdZg2Zh4Sv9kcHZrxkcp9cjqeCKCkLIX0fCu/YNH0bjI15KC96Gc229nebr6LxVZmnqIwYEiAcBy0mdU937OtN9Mz079MavBWSEe8J0wFy3YlG5DUiasg+BhIiuNYEqlwDvLtOFevupafzUX7eEoAxnSa9ohivioVd2U7yAZInD8YVH5H/83+XMehl89kqWuma9gj4NKxMmmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MExgluedEg6+JvI+ulgp6DQLZn4mSeKDSDWwe/C/N/Y=;
 b=KSQhG627m4p29oaPXE2QNz1zqRzbcWGXmHaWsAvlJ4O7CW74660LmUir0VFvwRF549+C/cbtk4V1zX1f9eJ06J6NNIsMsf0+cMHOGlV0XLw5I7xFKtJSKslY2sMjlBpp49oV5mPKrMF2ahbpA3djlV3wodLJCAwZ8GsALTxMKu10Z6446PRfbsUMuRURN+kFchlFUzQxBvkvfcbXRKv+oYpWrKACX2Ncix2OCBjKY7H7aJFsKIZG7WVo6+lGPRH9c/v1R7DVEHXuPoVEBXxs18JPf5u0fX09ebsBlo57xQs8+x+5VVKpsji/DJwXdfqwgv/BWNSj5ikhn/M+sK8HtA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:28 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:28 +0000
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
Subject: [PATCH v2 09/17] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Topic: [PATCH v2 09/17] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Index: AQHdFAqz240J/2w40kK1T3SnLmJG6A==
Date: Wed, 15 Jul 2026 03:33:28 +0000
Message-ID: <20260715033311.1648424-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a727f354-d0a7-4793-234b-08dee221d5da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|6133799003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: LAfaD8lHjP5P82Se98uxc2lLY6243HTNC1XfSlNLGvkW1sFe0xvTVku3+5UD+QdhRAgj+c1Qmugswklu5hfDtvWxTPyAOtvmLUDq3aYlYgDYEXTgpvbvQzHBEYtpmOp5bfnJ4/M8MBg5lyF56G9vZgNZxkFRwcHHilY0q2qBmuL2XjjFN2P6ASz5vAGrzrFjz4CHdFz60bFvgpOGEGd9/fCUuZO0llMFL359EKnjW8PfG8+xCC0Fc32WOc1/LEJ6609+Rwmw0gvOCyQzkumRQC3SWKV6+1Y1zHOZayv73cVg3qQ+A8viLf3ZkG8CQ4UqoXZAsiBjTxjFEWru0SXnvkHHYZE/7pi8+W5xwzm0DQky5aoNqYbo/v23iDjJHB06f3zGaVOjiUycKK6VtCg1l2TQ+7zXMn/hj/uAsXj3cGRGjfGKf3RafEh51QhfOoXuw6SFVdUrm66JJoL2yHceE+bssAbC+CMmLD3DObut1FAzQgKMqIBdWwwwyvY9Oig6b+9eSaxhuZLtPKyogIi0sfdPWUQ1Pdtne7D/dou1Zhf/0/bW7o5fJDc8bW7Be57U5rgxdtpqc3lvkw+CMkJkD6LhbVl7M1B8jXAaDLK2J/9ltokMaNfWy05BXLccMMKBFmpCvOcx+laWkOHb3GuTsuwtOnysTmcrOyNLHpBuwWgv/DItioB2cZSfBPWDa0+4nRt5enjmq83OrcH/ycB3jBzI+YGopV93vu76xByOO2D74mvbJrP5S1/yUNuFbjfG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OwNFTp5gmBpCX3hx6NfZv1xd7MGoG6n0RQBjTs5KyKxOzki1rXitXvvfX8?=
 =?iso-8859-1?Q?/7KtOUwlQi6DgrqCLaiqZn0kyO5GVDfO8NkE4e++9QZ2Rrj9Xa0QzEC4eY?=
 =?iso-8859-1?Q?DpqwgBK+bmQgKZT5NfqB5H1PmenD0WLJWKXlzpQsRr6Zg0EsvUqq2sVDrC?=
 =?iso-8859-1?Q?qW3mQHZtrsZWoF1fEZgc7HM8o3aYBkRfoq24R0JKiVOzKsaAYfeEvrfRrw?=
 =?iso-8859-1?Q?85nmeHghvAI+gME2YJ9LZKl9hJg60CEfcJq0vBsjSoZyT93Do9OT5dBewb?=
 =?iso-8859-1?Q?l/QDW6NVC7ooB8WrxhbFgSlb8w+xeWtUCGwsqXoA84mH/qTrcojkjDLoYZ?=
 =?iso-8859-1?Q?DEoQXL3ZMCu0YQJdh3m3UVtp++liv9CbsHCaIfzCW+fne0p7guQx+/qoKc?=
 =?iso-8859-1?Q?ShqJr3O9h/UFow8V83XRXT5BMYRdl8Go0H5SIdR4SlwpWnJxYnKsOu8xZp?=
 =?iso-8859-1?Q?Zc02Kt38Epjzj5fI/aw6fH5kb89P/RFOLYRzW0gHl5aVwTS1/VJKegH5n6?=
 =?iso-8859-1?Q?xezgGrB+2G1o/8HHYW1fvhThAVhiO2kgh91od0leXKgqUh/LF6aILFrJwf?=
 =?iso-8859-1?Q?zwZMyX5I8hn8G4IaUdtDJ0HOBqd3xKwKVIpEB54PAYBRRgrbylTFbooRVk?=
 =?iso-8859-1?Q?VJ1IiruiAFXPGQhIvi3/7upM8eOGWt6nhCEtBb9ODzTriGr9OSjZJ9c9Ff?=
 =?iso-8859-1?Q?j9xJl96cNzNH01pmYdfAECG4I8AONNWvuqpDfCVRYPFgN6p8eQH2l5T2L0?=
 =?iso-8859-1?Q?3n/CDqn8LiIzWIveGodjpo9KUYHfYoS6eiXPAuFtdydI5ZlzdLTrk8xNoW?=
 =?iso-8859-1?Q?7M57ES4L+sxBNr867DPBfYLaxkSyp+SlabUCbvD96bvTH4Y/pHwl34WfgZ?=
 =?iso-8859-1?Q?ogqxHii9TSVIbduwDw91MBjyJJh5FOFj+mkj0PPd0ERICqslKdeLpgt2OU?=
 =?iso-8859-1?Q?gyev5837qik0A4s2qkuAzfYmFIz9k42g+gKPw+1OW+NgPwWYfCgyujN/up?=
 =?iso-8859-1?Q?Yfcoszeo5aHKmJtoY67MjhB0xCS28TvnQxzToLiU6wA92WyuFEHWWS2v++?=
 =?iso-8859-1?Q?VzxgDmie5eSCRlZLTzGIt8pjCxf+Rg+omqRSSPIu1usxmQo83xRwfnAHzz?=
 =?iso-8859-1?Q?NbND0mp+UCYJC34SH0U/9KhikRH0cTFjxzZBQAO242KHHpreuIf1nfwX0Y?=
 =?iso-8859-1?Q?m9pXlRi9UEkUExXvGQSK+tMPNOc7frCekZ8SxNEf2OCFrbikkJiSXCOoFa?=
 =?iso-8859-1?Q?rbT8b9d6xK4LotTNdsgEHWIfQ4kuPxwM76MjIxGBgH0u6bJswhcJIDIKaJ?=
 =?iso-8859-1?Q?flBHx1Ra1pAP43Z7NwmEVkn2h5VFsktP5B7al6FBxgyYJ71wZXH2aO3fBW?=
 =?iso-8859-1?Q?8VGHIpHnZaQpOe+6ojDsjnni6DggH/iToxEucaHmv9ls5U1IMELQ09wwOW?=
 =?iso-8859-1?Q?P2aF8jX3sFFv2y5g/yvtPGlK/QD9FqJ1OGFv6n/wlKJJNrELNz3l0Va3jd?=
 =?iso-8859-1?Q?LoCDqM85lK33ox6tZIFyFNzKJXIBEjSlszgVsrJbYDQbOnVR3Bh4M7+dvS?=
 =?iso-8859-1?Q?NvLp3dxvnMcB1deeG2cnaGVeAy/TZF3DGuUFrguGTx5K615Tr4qzFaYAnW?=
 =?iso-8859-1?Q?Wg5A552dXKhNoHaJqJpiq2tIWifd6kazzoyUfxgKmsgoAZDc6g0Zi3B5sj?=
 =?iso-8859-1?Q?yUum/4Q0XEsrCOxa9lllpMsOWHNcthp4CXHDM4BR5GZak5/WXaieDSBGdP?=
 =?iso-8859-1?Q?uGGxiqqSNGOjriLwzpatOJoa/YpX1F1yO/luEUMqwdKswfFOVj0dAxDNE9?=
 =?iso-8859-1?Q?kEWvZvmpMA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mQpZRqVcBsPygr8TIw4ehLvVpn913NULDFxKtYo2+fnj/Lt0UuGC1QKFglLwguW3S2NzvTKGpVvYeQNcC9mibZtlnx3rB2ulJQH/Q1v82dvjoD8yk/jGaRU/28Qr8TFzq0W+2Q2RcWNeLaW/odM9YkNAdjYIeetiSlwKFHjGCO/kqlZNRBHZ7CfTCJJpSuPJIr/0sjXMEpjf5y2pS/MHKphu49QiCde9iWFXhMER0wEwiAG50m5ZAQJK5pM4/r0q2f9NvnRSbLPC0oGXo1CiBrQY7kPByNM/af0XxnB6NE1sGlXjATBN7m4Q/bBzWkXbN9gw/9OsxfEfAqYfK/N18Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a727f354-d0a7-4793-234b-08dee221d5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:28.1752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADNOAJTw/qBaoEGtYT7ou6Xkr6g9WhiiwCRIQ1xagdvk1CzpqMSoJCV+0hzpmG1Xk075ZgIXCPEAVWZa3FOoNN57tIpbqrjwYJu+L548wec=
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

Map QCRYPTO_CIPHER_MODE_GCM to GCRY_CIPHER_MODE_GCM and advertise it in=0A=
qcrypto_cipher_supports() for 128-bit block ciphers. Add a GCM driver=0A=
whose setiv accepts the (typically 96-bit) nonce, whose encrypt/decrypt=0A=
do not require block-aligned lengths, and which implements setaad via=0A=
gcry_cipher_authenticate() and gettag via gcry_cipher_gettag().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 crypto/cipher-gcrypt.c.inc | 101 +++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 101 insertions(+)=0A=
=0A=
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc=0A=
index 12eb9ddb5a..fce09a3c77 100644=0A=
--- a/crypto/cipher-gcrypt.c.inc=0A=
+++ b/crypto/cipher-gcrypt.c.inc=0A=
@@ -65,6 +65,8 @@ static int qcrypto_cipher_mode_to_gcry_mode(QCryptoCipher=
Mode mode)=0A=
         return GCRY_CIPHER_MODE_CBC;=0A=
     case QCRYPTO_CIPHER_MODE_CTR:=0A=
         return GCRY_CIPHER_MODE_CTR;=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        return GCRY_CIPHER_MODE_GCM;=0A=
     default:=0A=
         return GCRY_CIPHER_MODE_NONE;=0A=
     }=0A=
@@ -104,6 +106,10 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,=0A=
     case QCRYPTO_CIPHER_MODE_XTS:=0A=
     case QCRYPTO_CIPHER_MODE_CTR:=0A=
         return true;=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        /* GCM requires a 128-bit block cipher. */=0A=
+        return gcry_cipher_get_algo_blklen(=0A=
+                   qcrypto_cipher_alg_to_gcry_alg(alg)) =3D=3D 16;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -228,6 +234,99 @@ static const struct QCryptoCipherDriver qcrypto_gcrypt=
_ctr_driver =3D {=0A=
     .cipher_free =3D qcrypto_gcrypt_ctx_free,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * GCM is an AEAD stream mode: the IV/nonce need not match the block size,=
=0A=
+ * the message length need not be a multiple of the block size, associated=
=0A=
+ * data is fed with gcry_cipher_authenticate() and the authentication tag =
is=0A=
+ * read back with gcry_cipher_gettag().=0A=
+ */=0A=
+static int qcrypto_gcrypt_gcm_setiv(QCryptoCipher *cipher,=0A=
+                                    const uint8_t *iv, size_t niv,=0A=
+                                    Error **errp)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    gcry_cipher_reset(ctx->handle);=0A=
+    err =3D gcry_cipher_setiv(ctx->handle, iv, niv);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot set IV: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_setaad(QCryptoCipher *cipher,=0A=
+                                     const uint8_t *aad, size_t len,=0A=
+                                     Error **errp)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_authenticate(ctx->handle, aad, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot set AAD: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_encrypt(QCryptoCipher *cipher, const void *i=
n,=0A=
+                                      void *out, size_t len, Error **errp)=
=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_encrypt(ctx->handle, out, len, in, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot encrypt data: %s", gcry_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_decrypt(QCryptoCipher *cipher, const void *i=
n,=0A=
+                                      void *out, size_t len, Error **errp)=
=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_decrypt(ctx->handle, out, len, in, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot decrypt data: %s", gcry_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_gettag(QCryptoCipher *cipher,=0A=
+                                     uint8_t *tag, size_t len, Error **err=
p)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_gettag(ctx->handle, tag, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot get tag: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static const struct QCryptoCipherDriver qcrypto_gcrypt_gcm_driver =3D {=0A=
+    .cipher_encrypt =3D qcrypto_gcrypt_gcm_encrypt,=0A=
+    .cipher_decrypt =3D qcrypto_gcrypt_gcm_decrypt,=0A=
+    .cipher_setiv =3D qcrypto_gcrypt_gcm_setiv,=0A=
+    .cipher_setaad =3D qcrypto_gcrypt_gcm_setaad,=0A=
+    .cipher_gettag =3D qcrypto_gcrypt_gcm_gettag,=0A=
+    .cipher_free =3D qcrypto_gcrypt_ctx_free,=0A=
+};=0A=
+=0A=
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,=0A=
                                              QCryptoCipherMode mode,=0A=
                                              const uint8_t *key,=0A=
@@ -259,6 +358,8 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCip=
herAlgo alg,=0A=
 =0A=
     if (mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {=0A=
         drv =3D &qcrypto_gcrypt_ctr_driver;=0A=
+    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        drv =3D &qcrypto_gcrypt_gcm_driver;=0A=
     } else {=0A=
         drv =3D &qcrypto_gcrypt_driver;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

