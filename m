Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D94C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYz-0007e4-Dm; Tue, 11 Aug 2026 02:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYy-0007dj-RC; Tue, 11 Aug 2026 02:02:12 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYw-0002gH-Io; Tue, 11 Aug 2026 02:02:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUSl2JLozvp78cKKN7WtCAc5ZOsd1gszCr1lSXqlloQr4DK0GkKIcwCY1iMW3D98yL1qYEgF7MKOzg9iMNDvirUpnU36QEiciV6pOSYd5RiD/hbELGbIwJGYtgjma7RCbxUcAwPMjGoxY51S26zbj8pXO98gzB2HS0TKPl5Vo0WV2u2MVnk1rj90h1iKDF5txFaPCW1Ei1wHcpA/oxZn6b4eRBZWBOFqi4WtC86a5p/wjx7GZ1RSAf6gXPj7cknXw5WyN5tUlxwIflgzzI4IKNMmu47N/LQcccw5cMTbcnY711U53QiDncU7gdC7zLB4/qsL8IfYkEYTwn9JuV83SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqBW7h3RRRrRSEQozfoyesfbAwwmAPRjgRrzBhBsKaU=;
 b=rsEGbPcEijHfP8x7JFkG21QZgtcvg5554yvSw6l0dl5Jv3qr0HI45pneCWFFqJNf3V6X1fNSJCdYlHjdEGCZip7WNfF87RWDYQk/qRKjUD7CEcZwq4LW1UTt5rTmOy0nC9vQbLd9SJbTicXKgCYdsv0nyyaSt0vkWQgxihwEiKnVs4/cG92JWGrNA8gHosHnpdMU8OY5VEWvcl2UdGQF/2Xxe8aoqpwWfptoUDvLgPZARzRJsypEYYrThUs4g+eCw+Rd5YFlI7vkQ4HwJygvx93vneiYH3T/g3dTqS/kiHXIu+6Zn0FqfvPXL0XTqlkDoTm9947M43czSHZFwwdVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqBW7h3RRRrRSEQozfoyesfbAwwmAPRjgRrzBhBsKaU=;
 b=a/dXU/R1eZtiwDT0QBCYSunhEHOAu2sy8OiTt6YQCXuqqF9fvoEtptSSFRqUXQyqn2lvJyDldpVS+6UdXihddd3t2PAZOj60TnUnTHFvfL43D7NrD3UjYLVlEpplZut9duAx+6Q3vFrQAmXCOu8cXAMtGMZgUUDZEKtXOYI6AVS8q7AtKuAcPC/oRLhsy9iU6ErKWd8CDAANtfBhtQ21ftBKf0v5bizzvvAROpYexVqXM2X8uyn4RWmCzW8lL6ALS740fdKHaM1sBgIdMpxahdgRMmu7yaz33MXmGckGIURICVIiMzzZlY2aIQ0hf7NDXwFymatPgkUz0x5h/YwRug==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5419.apcprd06.prod.outlook.com (2603:1096:400:201::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:38 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:38 +0000
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
Subject: [PATCH v4 16/16] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2700
Thread-Topic: [PATCH v4 16/16] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2700
Thread-Index: AQHdKVbf8iM/9Tq5IUaLIze/A0PA4Q==
Date: Tue, 11 Aug 2026 06:01:37 +0000
Message-ID: <20260811060115.1849266-17-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 4ebb8f02-e2bf-4d7f-d951-08def76e01bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|38070700021|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: SpIam8vKK63KiY6BsEv1qNiJL12m9u1YT/jBkicm2udnYDI5HlxrBcxlQ5MItPaJiySJBf8GAFkE2IEd3UgRFJZ0B7mJhwAHhw+vIYLTDc+cCJjgMPVctT4S1SIN/AkI/GPiROzps7etnhd/cn5g92s3Roxm9rf3uaaqAncBY5+tSHH2V+uRykYeaDPqUItWWm/RhO9x5pwhIYSMbr+4mMKjPLYzYVn0/By+MrLLOOJU8D2OpCA0uOGGHzpIZHJ81TRUTfQfzwah96/yQDPiHzUh/A/EzNAac3KVPi+LRdTI9DpJADYbbHyz+lwceY2+L6uzB/RSgTCkR3/3BOJdxMW1cL3m/F5QWO0qMMRme2/QgfR6LjEb0X5aUYtOl/H5QnB75tNQihkGAv3PZjEJZEiIU7LLJfgHwEPaxwft5ubVUhd0v8zJ45Xyzl2qTyheFJueVzFRgk24sN+qgIvLgClX4wQT6iHzrtatSq1BTsr5eAWBGRx0SvMI4K7et8Q0rWQakgx+iPYxF2XAyCt7AclC2GU6r7hBznrPVhEvcA1WycMALQ701y6IKf0/fDdsCoEWNWH233fuJnhqSTERWZJijOa20Oi4DusLS4z/hor7HTqaKgWRPom29HsBI6sle5hLVKg589bLK/WjEbcHP99D+uFzYIO67Gn8rc9LFiKDz7BkMehO0H7mYB+vwg1qCKOImcHcV+jf9CKclGiu9iwu0HSlAmbF5kJoEQdHCWz47bCw1CiGKL8QtOCe+wHt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(38070700021)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kPkeT1ZbGz+oiM0X1BpPMCd9M/nmiD+gZmO5CvUe7+L2FTcdofTeXWqgvn?=
 =?iso-8859-1?Q?AhAvwDh6xSov0HAcZiWJ2LJ0bWqdK0VDsHwKvN1ci/ab4nCsc9w83dSLgQ?=
 =?iso-8859-1?Q?8am/jjXnSPaIil3FU46KC26QRDBXogcdUKZaZS9r8UmD9SvcNSId9spAXM?=
 =?iso-8859-1?Q?BzX5EJyyGYxU6ND89Cnzx06ujv+ICD2HkjRldcfSrpZ4BA5zQoEOHQQZK0?=
 =?iso-8859-1?Q?wpPWJvTWJLmfFww7KSs6D182goCFjl3gknP3gWIHUEm+NnibIvAe2/ljAL?=
 =?iso-8859-1?Q?lo748C6btRoDE26OfERBnnr9PPvXWy0E7goOfxtk9MLgsPoDYPgUQUV0cr?=
 =?iso-8859-1?Q?bPUTxByOCyUQ+WFWEAApUXFAvn0y8ZaFulPzlZp2rMrUU7FfkbwJUW8HaR?=
 =?iso-8859-1?Q?KDEcmTBXjVD5vsiypCRRZZvP2tljlnGJ0qLqJMCjMYYl0red1zHtF+YV0C?=
 =?iso-8859-1?Q?NOc8ZPgGXHKLnKxXGIBVrb9XPamIz7lKZg8SF/HnpyE/npEblUWqbXXvbf?=
 =?iso-8859-1?Q?LJ9zWBKU1S7O6wnKJFGreJPU/s9TKucNTDThryAV7lzVCd8Cfdd0/SUbD1?=
 =?iso-8859-1?Q?+f8YmfskKMm6pO1LzRNMYjAIfu8IpiPcBMrMn6TdFEZwiLnc4EuK1dhvI9?=
 =?iso-8859-1?Q?u6VSfvxnFKO+ZpJkDo01Gcawv5R1u9B7l/DDEALVzS79PePffACL20SzgE?=
 =?iso-8859-1?Q?1qsaZaYUtGNDTY/9Dton4KYdCUcxS4owZ3l2YlgjS6ZW5ls4tYYTzwqLCB?=
 =?iso-8859-1?Q?sdXzDttwbkk8quwrEWUCrQEIAnKVg10akVhIFiYzHn2BfZ3oTXZc7jrs5V?=
 =?iso-8859-1?Q?rYILcm1ZXiEGeWwfuTkvmDbN+qeVOrmVuMvzwLltSKSwl5iJtrBjiF64wW?=
 =?iso-8859-1?Q?vsAOyG7ooA/9rIZAym2CBD+j0dyqhHucYrzLU7jwic6Ef+0nJzi3HxPKOK?=
 =?iso-8859-1?Q?uQVyLBngd5dbKxoJhU8p3YLAvq5pNUWV0gbOeJQenmiTRskSlvuHPHqV5o?=
 =?iso-8859-1?Q?4Adqp389ikeOhkRBkrg8zoeYbjywmRH0bAffvqNyLB5SXIwJYn4Fk/Ghc9?=
 =?iso-8859-1?Q?U1ClpaeJmM8W9tcaTHxIJL5sGxd/DQ5JZTmRcWzq05Rftx09i705jIfbdP?=
 =?iso-8859-1?Q?IpgUCuMAo6dzOhhPjcPGIKYoqH08/l37x5EsvgJZPw5UW+SJYIbygmYfl/?=
 =?iso-8859-1?Q?3Ku4f0042sE4HUgZltSgiUxT8B9/IBHwULMT7/MH3TnGah7NwyTwWjPbsg?=
 =?iso-8859-1?Q?uYl1vQEbdXJY4fyQyLl48rFeaK+pm9DpN8HoS0ag8HJBSYVzHWFnYXHBSs?=
 =?iso-8859-1?Q?Y054xx+7rDZfO3Qsq++/9QxyFzkXfr65QwKEWdB+DXY6PmYc+2n+TDGDwQ?=
 =?iso-8859-1?Q?1Wv6dqo7De1ExAkIDzrh3laVA+6Oo5Ak4Q0tOfyW/8ZV6VA/HrBRVQKeIP?=
 =?iso-8859-1?Q?chzjQLmjyt2zQ5C+4AAr1yYnM3dpFRcvWEz4UvnCySga1pcaR90OBqTcfV?=
 =?iso-8859-1?Q?VInkKmZoXA5qGdYPfrTQjnhh8wNTjpFGGD/w58oOrNOQQ5nB0D0WcryLlC?=
 =?iso-8859-1?Q?A1RQr6pekAvH3QqDE1RCAW8G7/hKR5S0m7oCy5Re4prLiw5gc+scRhEB30?=
 =?iso-8859-1?Q?oPA4c2gu5mvSE7kpS/MmMjIQ8bQhuQuWGl6QJldS+v6r5pgNJMXut27NeZ?=
 =?iso-8859-1?Q?Ms8w0Tg6E0PT8eBdx6JttVf1P9y+Ea8HLUckfXerDyGvvBxfDv5koGDCRs?=
 =?iso-8859-1?Q?lKA0g2tid+DDzDRlX1RpJs/7QNpBDz9Y9ykajCszvSmZvX9LzSfFYS86tD?=
 =?iso-8859-1?Q?RT4qO7Zoug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aO70piRiZjGu5Cd7m4KvRK+y/q4+f8PnnkeB8sY1Oz82ERfh2J4ehb7mfOcDxYXPU3Kh36X4J17n7MIvvGNppEj0gxykk5L3g3PxqHqWQoR08ezP1MzF0xER1GmWLg/l/n5pRXSvjYCuhSpvjVH1z5Dr1vu4VbWXGc1E3yLX7NFGbwLdPcmjkZA+oVfUxFy+aXBe30pKsayGeBXlD0qnBoNM/3eiZLMlzqI+8FlKHQ280fhtjrI1MscR+OUpwd4O/DiPETciC+cVeGaYuUX/0heqEeSHz5Txl0WGgHDMfadl9q6Gh3jAbozOv7hIRykFLyzrOaoioWhT0zAKljejRw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb8f02-e2bf-4d7f-d951-08def76e01bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:38.0655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkoqyuJ8+7wUCCg/exG4UQF6rfWmwDrlnSvzwhcstXVHRyh+aTnjGsn11bE2htKSy5OniTu4ZZU8uj2BgrV18kxXXXmF9ZCzXTrSMynwBQQ=
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

Cover the AST2700 crypto engine, which drives 64-bit scatter-gather DMA=0A=
and adds AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.=
=0A=
Add AES-128 and AES-256 GCM known-answer vectors (GCM specification /=0A=
NIST SP 800-38D, no associated data) and a dedicated GCM runner that=0A=
programs the tag buffer and reads the tag back, checking it after both=0A=
encryption and decryption. Register the AST2700 with all four modes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-hace-utils.h |   1 +=0A=
 tests/qtest/aspeed-hace-utils.c | 163 +++++++++++++++++++++++++++++++-=0A=
 tests/qtest/ast2700-hace-test.c |   9 ++=0A=
 3 files changed, 172 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-util=
s.h=0A=
index 82b0b3f93d..a5601a3d65 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.h=0A=
+++ b/tests/qtest/aspeed-hace-utils.h=0A=
@@ -86,6 +86,7 @@ enum {=0A=
     CRYPT_MODE_ECB =3D 1 << 0,=0A=
     CRYPT_MODE_CBC =3D 1 << 1,=0A=
     CRYPT_MODE_CTR =3D 1 << 2,=0A=
+    CRYPT_MODE_GCM =3D 1 << 3,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-util=
s.c=0A=
index f582c88ef5..260eec043c 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -654,6 +654,8 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CRYPTO_CONTEXT      0x08=0A=
 #define HACE_CRYPTO_DATA_LEN     0x0c=0A=
 #define HACE_CRYPTO_CMD          0x10=0A=
+#define HACE_CRYPTO_GCM_ADD_LEN  0x14=0A=
+#define HACE_CRYPTO_GCM_TAG      0x18=0A=
 =0A=
 /* Crypto command bits */=0A=
 #define HACE_CMD_ENCRYPT         BIT(7)=0A=
@@ -666,7 +668,9 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CMD_ECB             (0x0 << 4)=0A=
 #define HACE_CMD_CBC             (0x1 << 4)=0A=
 #define HACE_CMD_CTR             (0x4 << 4)=0A=
+#define HACE_CMD_GCM             (0x5 << 4)=0A=
 #define HACE_CMD_AES128          (0x0 << 2)=0A=
+#define HACE_CMD_AES256          (0x2 << 2)=0A=
 =0A=
 /* Context buffer layout: IV (DES at +8), key at +0x10 */=0A=
 #define HACE_CTX_KEY_OFFSET      0x10=0A=
@@ -794,6 +798,59 @@ static const uint8_t tdes_ctr_ctext[8] =3D {=0A=
 static const uint8_t tdes_ctr_ivout[8] =3D {=0A=
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };=0A=
 =0A=
+/*=0A=
+ * aes_gcm_tv_template[2] (AES-128) and [9] (AES-256), from the McGrew & V=
iega=0A=
+ * GCM spec (also NIST SP 800-38D), no AAD. Both cases share this plaintex=
t/IV.=0A=
+ */=0A=
+static const uint8_t aes_gcm_ptext[64] =3D {=0A=
+    0xd9, 0x31, 0x32, 0x25, 0xf8, 0x84, 0x06, 0xe5,=0A=
+    0xa5, 0x59, 0x09, 0xc5, 0xaf, 0xf5, 0x26, 0x9a,=0A=
+    0x86, 0xa7, 0xa9, 0x53, 0x15, 0x34, 0xf7, 0xda,=0A=
+    0x2e, 0x4c, 0x30, 0x3d, 0x8a, 0x31, 0x8a, 0x72,=0A=
+    0x1c, 0x3c, 0x0c, 0x95, 0x95, 0x68, 0x09, 0x53,=0A=
+    0x2f, 0xcf, 0x0e, 0x24, 0x49, 0xa6, 0xb5, 0x25,=0A=
+    0xb1, 0x6a, 0xed, 0xf5, 0xaa, 0x0d, 0xe6, 0x57,=0A=
+    0xba, 0x63, 0x7b, 0x39, 0x1a, 0xaf, 0xd2, 0x55 };=0A=
+static const uint8_t aes_gcm_iv[12] =3D {=0A=
+    0xca, 0xfe, 0xba, 0xbe, 0xfa, 0xce, 0xdb, 0xad,=0A=
+    0xde, 0xca, 0xf8, 0x88 };=0A=
+=0A=
+/* aes_gcm_tv_template[2] (AES-128) */=0A=
+static const uint8_t aes128_gcm_key[16] =3D {=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };=0A=
+static const uint8_t aes128_gcm_ctext[64] =3D {=0A=
+    0x42, 0x83, 0x1e, 0xc2, 0x21, 0x77, 0x74, 0x24,=0A=
+    0x4b, 0x72, 0x21, 0xb7, 0x84, 0xd0, 0xd4, 0x9c,=0A=
+    0xe3, 0xaa, 0x21, 0x2f, 0x2c, 0x02, 0xa4, 0xe0,=0A=
+    0x35, 0xc1, 0x7e, 0x23, 0x29, 0xac, 0xa1, 0x2e,=0A=
+    0x21, 0xd5, 0x14, 0xb2, 0x54, 0x66, 0x93, 0x1c,=0A=
+    0x7d, 0x8f, 0x6a, 0x5a, 0xac, 0x84, 0xaa, 0x05,=0A=
+    0x1b, 0xa3, 0x0b, 0x39, 0x6a, 0x0a, 0xac, 0x97,=0A=
+    0x3d, 0x58, 0xe0, 0x91, 0x47, 0x3f, 0x59, 0x85 };=0A=
+static const uint8_t aes128_gcm_tag[16] =3D {=0A=
+    0x4d, 0x5c, 0x2a, 0xf3, 0x27, 0xcd, 0x64, 0xa6,=0A=
+    0x2c, 0xf3, 0x5a, 0xbd, 0x2b, 0xa6, 0xfa, 0xb4 };=0A=
+=0A=
+/* aes_gcm_tv_template[9] (AES-256) */=0A=
+static const uint8_t aes256_gcm_key[32] =3D {=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08,=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };=0A=
+static const uint8_t aes256_gcm_ctext[64] =3D {=0A=
+    0x52, 0x2d, 0xc1, 0xf0, 0x99, 0x56, 0x7d, 0x07,=0A=
+    0xf4, 0x7f, 0x37, 0xa3, 0x2a, 0x84, 0x42, 0x7d,=0A=
+    0x64, 0x3a, 0x8c, 0xdc, 0xbf, 0xe5, 0xc0, 0xc9,=0A=
+    0x75, 0x98, 0xa2, 0xbd, 0x25, 0x55, 0xd1, 0xaa,=0A=
+    0x8c, 0xb0, 0x8e, 0x48, 0x59, 0x0d, 0xbb, 0x3d,=0A=
+    0xa7, 0xb0, 0x8b, 0x10, 0x56, 0x82, 0x88, 0x38,=0A=
+    0xc5, 0xf6, 0x1e, 0x63, 0x93, 0xba, 0x7a, 0x0a,=0A=
+    0xbc, 0xc9, 0xf6, 0x62, 0x89, 0x80, 0x15, 0xad };=0A=
+static const uint8_t aes256_gcm_tag[16] =3D {=0A=
+    0xb0, 0x94, 0xda, 0xc5, 0xd9, 0x34, 0x71, 0xbd,=0A=
+    0xec, 0x1a, 0x50, 0x22, 0x70, 0xe3, 0xcc, 0x6c };=0A=
+=0A=
 typedef struct CryptTest {=0A=
     QCryptoCipherMode mode;=0A=
     QCryptoCipherAlgo alg;=0A=
@@ -801,10 +858,13 @@ typedef struct CryptTest {=0A=
     const uint8_t *iv_out;=0A=
     const uint8_t *ptext;=0A=
     const uint8_t *ctext;=0A=
+    /* expected GCM authentication tag, or NULL for non-AEAD modes */=0A=
+    const uint8_t *tag;=0A=
     const uint8_t *key;=0A=
     const uint8_t *iv;=0A=
     const char *name;=0A=
     size_t keylen;=0A=
+    size_t taglen;=0A=
     /* algorithm | mode | key size selection */=0A=
     uint32_t cmd;=0A=
     size_t ivlen;=0A=
@@ -927,6 +987,36 @@ static const CryptTest crypt_tests[] =3D {=0A=
         .iv_out =3D tdes_ctr_ivout,=0A=
         .len =3D sizeof(tdes_ctr_ptext),=0A=
     },=0A=
+    {=0A=
+        .name =3D "aes128-gcm",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_GCM,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_GCM,=0A=
+        .key =3D aes128_gcm_key,=0A=
+        .keylen =3D sizeof(aes128_gcm_key),=0A=
+        .iv =3D aes_gcm_iv,=0A=
+        .ivlen =3D sizeof(aes_gcm_iv),=0A=
+        .ptext =3D aes_gcm_ptext,=0A=
+        .ctext =3D aes128_gcm_ctext,=0A=
+        .tag =3D aes128_gcm_tag,=0A=
+        .taglen =3D sizeof(aes128_gcm_tag),=0A=
+        .len =3D sizeof(aes_gcm_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "aes256-gcm",=0A=
+        .cmd =3D HACE_CMD_AES256 | HACE_CMD_GCM,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_256,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_GCM,=0A=
+        .key =3D aes256_gcm_key,=0A=
+        .keylen =3D sizeof(aes256_gcm_key),=0A=
+        .iv =3D aes_gcm_iv,=0A=
+        .ivlen =3D sizeof(aes_gcm_iv),=0A=
+        .ptext =3D aes_gcm_ptext,=0A=
+        .ctext =3D aes256_gcm_ctext,=0A=
+        .tag =3D aes256_gcm_tag,=0A=
+        .taglen =3D sizeof(aes256_gcm_tag),=0A=
+        .len =3D sizeof(aes_gcm_ptext),=0A=
+    },=0A=
 };=0A=
 =0A=
 /* DRAM offsets for the crypto test source, destination and context buffer=
s. */=0A=
@@ -944,6 +1034,8 @@ static const CryptTest crypt_tests[] =3D {=0A=
  */=0A=
 #define CRYPT_SG_FRAGS         3=0A=
 #define CRYPT_SG_FRAG_STRIDE   0x1000=0A=
+/* DRAM offset for the AES-GCM authentication tag write buffer. */=0A=
+#define CRYPT_OFF_TAG          0x60000=0A=
 =0A=
 /* Describes one registered crypto test (qtest_add_data_func() data pointe=
r). */=0A=
 typedef struct AspeedCryptoTest {=0A=
@@ -964,6 +1056,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)=0A=
         return CRYPT_MODE_CBC;=0A=
     case HACE_CMD_CTR:=0A=
         return CRYPT_MODE_CTR;=0A=
+    case HACE_CMD_GCM:=0A=
+        return CRYPT_MODE_GCM;=0A=
     default:=0A=
         return 0;=0A=
     }=0A=
@@ -1109,6 +1203,47 @@ static void crypt_run_sg(QTestState *s, uint32_t bas=
e, uint64_t dram,=0A=
     crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Run one AES-GCM operation in scatter-gather mode: like crypt_run_sg() b=
ut=0A=
+ * also program the tag write buffer (HACE18) with no associated data, and=
 read=0A=
+ * the authentication tag back into @out_tag.=0A=
+ */=0A=
+static void crypt_run_gcm(QTestState *s, uint32_t base, uint64_t dram,=0A=
+                          const CryptTest *t, bool encrypt, uint8_t *out,=
=0A=
+                          uint8_t *out_tag)=0A=
+{=0A=
+    const uint8_t *in =3D encrypt ? t->ptext : t->ctext;=0A=
+    uint64_t src_sg =3D dram + CRYPT_OFF_SRC_SG;=0A=
+    uint64_t dst_sg =3D dram + CRYPT_OFF_DST_SG;=0A=
+    uint64_t ctx =3D dram + CRYPT_OFF_CTX;=0A=
+    uint32_t cmd =3D t->cmd | HACE_CMD_ISR_EN | HACE_CMD_SRC_SG_CTRL |=0A=
+                   HACE_CMD_DST_SG_CTRL;=0A=
+=0A=
+    if (encrypt) {=0A=
+        cmd |=3D HACE_CMD_ENCRYPT;=0A=
+    }=0A=
+=0A=
+    crypt_write_ctx(s, ctx, t);=0A=
+    crypt_make_sg(s, dram, CRYPT_OFF_SRC, src_sg, in, t->len);=0A=
+    crypt_make_sg(s, dram, CRYPT_OFF_DST, dst_sg, NULL, t->len);=0A=
+=0A=
+    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src_sg);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst_sg);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_GCM_ADD_LEN, 0);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_GCM_TAG,=0A=
+                 (uint32_t)(dram + CRYPT_OFF_TAG));=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);=0A=
+=0A=
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, =3D=
=3D,=0A=
+                    HACE_CRYPTO_ISR);=0A=
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);=0A=
+=0A=
+    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);=0A=
+    qtest_memread(s, dram + CRYPT_OFF_TAG, out_tag, t->taglen);=0A=
+}=0A=
+=0A=
 static void aspeed_test_crypto(const void *data)=0A=
 {=0A=
     const AspeedCryptoTest *c =3D data;=0A=
@@ -1145,6 +1280,29 @@ static void aspeed_test_crypto(const void *data)=0A=
     qtest_quit(s);=0A=
 }=0A=
 =0A=
+static void aspeed_test_crypto_gcm(const void *data)=0A=
+{=0A=
+    const AspeedCryptoTest *c =3D data;=0A=
+    const CryptTest *t =3D &crypt_tests[c->index];=0A=
+    QTestState *s =3D qtest_init(c->machine);=0A=
+    uint8_t out[64];=0A=
+    uint8_t tag[16];=0A=
+=0A=
+    g_assert_cmpuint(t->len, <=3D, sizeof(out));=0A=
+=0A=
+    /* Encrypt: ptext -> ctext, then check the authentication tag. */=0A=
+    crypt_run_gcm(s, c->base, c->dram, t, true, out, tag);=0A=
+    g_assert_cmpmem(out, t->len, t->ctext, t->len);=0A=
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);=0A=
+=0A=
+    /* Decrypt: ctext -> ptext, the recomputed tag must match. */=0A=
+    crypt_run_gcm(s, c->base, c->dram, t, false, out, tag);=0A=
+    g_assert_cmpmem(out, t->len, t->ptext, t->len);=0A=
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);=0A=
+=0A=
+    qtest_quit(s);=0A=
+}=0A=
+=0A=
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,=0A=
                              uint32_t base, uint64_t dram, uint32_t modes,=
=0A=
                              bool sg)=0A=
@@ -1152,6 +1310,7 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
t char *machine,=0A=
     int i;=0A=
 =0A=
     for (i =3D 0; i < ARRAY_SIZE(crypt_tests); i++) {=0A=
+        bool is_gcm =3D crypt_tests[i].mode =3D=3D QCRYPTO_CIPHER_MODE_GCM=
;=0A=
         g_autofree char *path =3D NULL;=0A=
         AspeedCryptoTest *t;=0A=
 =0A=
@@ -1173,7 +1332,9 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
t char *machine,=0A=
         t->dram =3D dram;=0A=
         t->index =3D i;=0A=
         t->sg =3D sg;=0A=
-        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);=0A=
+        qtest_add_data_func_full(path, t,=0A=
+                                 is_gcm ? aspeed_test_crypto_gcm :=0A=
+                                 aspeed_test_crypto, g_free);=0A=
     }=0A=
 }=0A=
 =0A=
diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-tes=
t.c=0A=
index 508a34dd6c..3f0217d635 100644=0A=
--- a/tests/qtest/ast2700-hace-test.c=0A=
+++ b/tests/qtest/ast2700-hace-test.c=0A=
@@ -94,5 +94,14 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("ast2700/hace/sha384_accum", test_sha384_accum_ast2700)=
;=0A=
     qtest_add_func("ast2700/hace/sha256_accum", test_sha256_accum_ast2700)=
;=0A=
 =0A=
+    /*=0A=
+     * The AST2700 crypto engine uses scatter-gather with 64-bit DMA and a=
dds=0A=
+     * AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.=0A=
+     */=0A=
+    aspeed_add_crypto_tests("ast2700", "-machine ast2700-evb", 0x12070000,=
=0A=
+                            0x400000000,=0A=
+                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_C=
TR |=0A=
+                            CRYPT_MODE_GCM, true);=0A=
+=0A=
     return g_test_run();=0A=
 }=0A=
-- =0A=
2.43.0=0A=

