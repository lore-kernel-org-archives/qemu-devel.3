Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D7C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtct4-0003hl-CX; Mon, 10 Aug 2026 23:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct2-0003gx-9g; Mon, 10 Aug 2026 23:10:44 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct0-0004JO-Cm; Mon, 10 Aug 2026 23:10:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2UJBNJ3QQomCOTwYWe6iUXHTTtj9A+TgrjDHJfm60E3cKnaFRjPY4vUQzIa91BeNt3fbpVNJNB0TbSb2W5FujqCEQSEdQeDRQ8NYN4+WlbkQIgbFHyrJSaHKDJtq3C56dPvvrCLbTw0ONEb+Zr8uUv1gZl8E7V2/LZEr9wTKSoV1tRr8sKT8nEFqVK/0+aBnZ5wBs44xwmIFyRt1w065QkiZ25Ir9eTgmdu/I4nMpp1qxgPm1sEr4sohOj/e8n/ezBW+IJEwQ8HtouoYmdtppjbszipv3JdCLNmLwWQOeKv3U2Ym/b8IWR6kg0klhcccfOeiNiqNNbEZc6FGjDe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYCK6pCifmARPcX/ejm7hMe1QesfvjTRs0DiibupZ8E=;
 b=PE0Eo3s3Hwp5UJ0XwajRfxNR26S99IQzH9K7iEbtAEthyvZgfWd9d28jpbWmqGZkcLQFkWPT7WDkpwQQxK2kW098I3pwkP2fFND5tfGpZJxT2YyTDecLpXAq31GUsxHxPVERnKIgu3IeTIaMbu5WwxJ7R+1eWl6m9agQ2DJb6LE8k5r7FkmRBsaQc9FMtyRI+hxOn6G75wXdtlAPUq2f1RMebSXkndquNBctghx8HSoBOmY/PrdL1s9S6SPn6JZsUnzEDWx48NAoNFwcP5ClyT3XnlFD7SSUZ5kbfRj6ShMq76g/nYUwUmUhMZiSN+rkFFfSIFp6qhblYiMnO2AB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYCK6pCifmARPcX/ejm7hMe1QesfvjTRs0DiibupZ8E=;
 b=WHHNSACPshBpfsqzs1LVjiMV7ZM3lvLbs6rPooT53/wjzZmKq6YotRYEYilfiB7N+rimlQcbXx5qtGTHqxKlsXF9Aiuzq+OqB12fbz+YnwAQw7y/v8gJWWRpLWknacQyZ7cFMtlqlnjNeEv/iuHhVEKRLySVAc+ShokMPiVmVUTzSbfF/P0baQFsrpXLNavu30a/X20a+C8J9UMiDav6qb9NRHBRk5dItXSZmOb2DRwYSFYttllbg0TxuMJFS73O7GlE39mHOCJ8jHHuKF7xD6L2MvgLmamvjCwKZLtahuuRw/HkD1RAvzK98rUlTDYi2nFjA4tbK7X0VCptvdu3DQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:32 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:32 +0000
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
Subject: [PATCH v3 04/16] hw/misc/aspeed_hace: Support the CTR mode for the
 crypto command
Thread-Topic: [PATCH v3 04/16] hw/misc/aspeed_hace: Support the CTR mode for
 the crypto command
Thread-Index: AQHdKT74xMqUG90vmE2UC8cAwlWCGg==
Date: Tue, 11 Aug 2026 03:10:32 +0000
Message-ID: <20260811031025.2784489-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 755b2b44-13cb-4396-f86f-08def7561aca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|3023799007|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: C2p/bRe2UmXyBvvsm5TNnoXapLAHzkJdANRz5FbyTwu7+sSk6tu0X5g+uYwy07ntiRE+bWqCwhQtEXg00kah7A4XqsoKF9q5iSOUjsg0cqLVihs0oWaW/OPnl4JSfnQn/0hoeGREsqqQaOkp9/o2rGhU4m1Oq/lGyhZQmRRxCeUG5ptE3NX0UOuBc462IVNOoorNkeZ/37OjssNVyun2jiP2/HUKhEhfEVotp1jtixOD6Rs/hyD1oeKAhHkm/Z/2hsqDaFC+mjv16W+ZTOlf2nLLUCCQPQUfF/Fk+HNqHCsNqgwIQGVNMAzyUfCTkQb7GCVtJQ9QLTwlxIJbVXPF/zmluX4PdI9rz9cnP/dZJ7vSR2jNiDpyx3XSCVLouyoHjlp+Xr3Y6RGCApwDYLcdYwQsbCh5bA6bHZ4AfMcwHYfqel3EGPYXpQLEXgnYmMOsFF2a0shqvjSZi3Fyx+ENGodRk1ndbEUjmxkbFFn2NtuJiFuf9xTrFMR7OTp3/1a4fuIL9z8iQoM1r2qq0kZ3rYo2y2SjOs9QkzwWhfmRZ2dfTkelc9Zls3P8E3YX/hxnkfz+THmMSPkakuQolrRzWT/78GJ235IHP90F0gLMyWlIgWLKeDKNUlXF8Dw+dO3SfXycuh9CKt99pjctOKZ2JlLW40oS8koOxXKt+MSF+u0EWiuTDiOxxd/G55xG/Y60Ts/L1V26RvF0o4jcNuwMfmU7KCTcP9ryOVKb6CgvqVTALO1z8z0f4WNEsi7Kwcb8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(3023799007)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2ZIPbBmyeQv+qnwVrmOtY3gNBl5XtpuoefT3gd67yi6HL1/WQEOG56EhvF?=
 =?iso-8859-1?Q?fW3bFjOvHksPLnqkxNWyyiA1ZEASsEC46bpscsi5HPn/tJHxwMH4zjRO4c?=
 =?iso-8859-1?Q?9AGWFLU40Bk7ADVPJN8EyqKGL6Sf4JKjX0U2+9B+ErQ7mzkWRXpR5ptN5/?=
 =?iso-8859-1?Q?ZVh+pzdI2NTPMyYnUx8Kmk5Kpe0KP9EK7Aw+tY1zvpRYS7tk4lr8dGSy+Y?=
 =?iso-8859-1?Q?/biEs58ibZZEswrT0AORBHZWOjzrIMjZQHpfZmy3DgWiAC2GR/lFktwsrr?=
 =?iso-8859-1?Q?Z0kzUHYPOdmP8cICrEWVt1FjpYGFcdM2CvirOg79imFBO2PuP/5Qmv4QB4?=
 =?iso-8859-1?Q?e/kGSvL00KinHYm1Cod+3n70+qf/v6Dxd+ozh/Is1IpD4/0Yqd+QtTurHM?=
 =?iso-8859-1?Q?O8NGTRCRgyaWAmtodx6oS18+uFZuy32YDkE10g238DhaSMJC/lbYv1Vfxy?=
 =?iso-8859-1?Q?jgwhhuJjWOVS4AoyXpgQVP2uxoD/AbCpEi8dMYtgtBgax4amP1jSRdy4Oh?=
 =?iso-8859-1?Q?3V+p6ZZzA9CW8ziVrmV86Hh9O0P3uIA68ya1FnkHudXpSv6CL+iOelSdjs?=
 =?iso-8859-1?Q?H+/a4tB9Y9Z/cbY4kLPUHRZqMyqoXshgMQOueMPnx7h47MT8RLEJCWjCx+?=
 =?iso-8859-1?Q?W4k6SR8MMAfxrFARl+JdIclJ9+JG32mcBaEPVe9nFsdSrOEt5LFXLloEpR?=
 =?iso-8859-1?Q?4zgLByJs80tAiwbBUOEZjVFhg8kDUpSxU/WxcpgNDt3Z6MIlzsgBzfMX6s?=
 =?iso-8859-1?Q?ypNlc5r9vAKCjuQZXZ9nOVvtRfH5j+3YRqmoxpVY/v8IMmwAuY/BLJiCkd?=
 =?iso-8859-1?Q?nbi3Up5Mg181H6WbIe/zmKAa0ApcOnA+MujgIlSq1m3ByOKP9pgJx6meS2?=
 =?iso-8859-1?Q?vdKzdqUeRlX3qmKDE2/poeUK+YkIDdazGFQuxatDrVoRx5a6InunW1EljE?=
 =?iso-8859-1?Q?dMSwtjXu8IdB81hADHd5eIWKgOraqDInSiLsgI+ld4PjMoXYtL/qJNbfzf?=
 =?iso-8859-1?Q?VVMujqtBaXXydQWoTwGSJX+mltSdnts18mAa1DHP1GvoEUYKgpbHxrtMhy?=
 =?iso-8859-1?Q?9jXmkmsG1+yVBmoWRxG59gIBkAySLGjLxFhzOPt4ttmws7W6lSVkVh3sJB?=
 =?iso-8859-1?Q?XAT8EUT27/p8kvwQj1U5Uh5Fx7/XVDlVjo9+Em1TkHia/JXHhvg2zUBvlQ?=
 =?iso-8859-1?Q?F8Z6P2ZJcPtOU3pnB41cssZDjReXwO2SGn+uEmvTMEOLwtEyA26rA+0y6v?=
 =?iso-8859-1?Q?FiOaVritEKh640ZBYGRRHgtIDMuknA9Bm0w/khwOISFqsP7o5yhtYEtZ3L?=
 =?iso-8859-1?Q?ac0GSeZeBKpZ56b9p9B953vbpYYSjPPjHCdQpoI0LLJwhnViu9o+I5qx2K?=
 =?iso-8859-1?Q?/yOBsY68tI7kI4D9z48YebAKSyNgkzRZ6SnnqSC0EfYEhfeuv2Ea9oNmlQ?=
 =?iso-8859-1?Q?mLpo8D5l3E2OWJ7ow2qR+pytT9fhaTcrHy0ys+OS6IykyKNWzzOo1eIP/3?=
 =?iso-8859-1?Q?rmffSG+a78fsJBn9BiAfVhvNnIPxjAF0uqsrEOJ30lB7J7GIBqJna8FYGx?=
 =?iso-8859-1?Q?auz/qmD+mALijEqXf5J3E7n1TKj9jkwxYc6Z5n50uE3Gznmvbu95KYIDs+?=
 =?iso-8859-1?Q?N9RCWlQDIdvOlyuNnxHbR5FOQJURuaRbHiD8hn/SRn1atnjMPcvUPVxU4h?=
 =?iso-8859-1?Q?cAmx/VBKxC13InZjcYxVfcGCFETCxXYeparoQj5NYVTL4wJQqmysyBL/lx?=
 =?iso-8859-1?Q?k5E2K1V5sBQB34gdDeEzFBJZ6xoJERdpazkZrEbVegbsIk79GqhEfKzMEV?=
 =?iso-8859-1?Q?glFgEMn/lQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jsa4x5auFKeqAPW6LuqPZC33wexlckQsYGTAfZ1ucFJh7mr2hFZOTm+3Yhvf4AEun0R9+Rhd0Awc6mo5zt7m+0FxC7D8nsz6w82pj49OwG4QEnx1IDNRqL7cmM8eLmZmkR712VNcW7C/0q0uQTRZar8EoJZBLZl6PIVfiwCVmW9kp/FvKlShzYO0OloW18Eo5FQzE4IHC5FsDAJalIkqRk0Fhrs/jjFJvAYEPLe+FN9mfRLDHVeQ+Yu3+y0QUGVdz2dXa4SxQWwCgH1410iVdWOGzG68RzTFerYPo6nfXdorosVQe8jIwGHAXVtDANVomMxdhoq9lInOwd/OpF8TQg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755b2b44-13cb-4396-f86f-08def7561aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:32.1574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c12EUjab0w7tE5HawxU+zP9WIX2fU5LP3VPHAtCScK4u1y0p+shQkU9JCW01yrmcQaTDLLD2KkoeYPSREpzhKW0JWxyshHabnwnL8HJKoS8=
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

The AST2600, AST1030 and later crypto engines add AES/DES/3DES CTR mode=0A=
(HACE10[6:4] =3D 0b100) on top of the ECB/CBC modes shared with the=0A=
AST2500. Decode the CTR selection, round the working buffers up to a=0A=
whole block so the stream-like final block is still processed a block at=0A=
a time, and write the counter advanced by the number of blocks consumed=0A=
back to the context buffer so the driver can continue across requests.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 50 ++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 45 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 646ff50476..d84f7f9cec 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -41,6 +41,7 @@=0A=
 #define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
 #define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
 #define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+#define  CRYPT_CMD_CTR              (0x4 << 4)=0A=
 /* AES key length HACE10[3:2] */=0A=
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
 #define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
@@ -587,6 +588,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCiphe=
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
@@ -650,6 +654,22 @@ static bool crypt_prepare_sg(AspeedHACEState *s, uint6=
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
@@ -675,6 +695,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     uint64_t dst_addr;=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
+    size_t buf_len;=0A=
     size_t keylen;=0A=
     bool status;=0A=
 =0A=
@@ -727,8 +748,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
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
@@ -749,7 +776,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     if (encrypt) {=0A=
-        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -757,7 +784,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -790,13 +817,26 @@ static void do_crypt_operation(AspeedHACEState *s, ui=
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

