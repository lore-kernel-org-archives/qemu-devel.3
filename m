Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BCFC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYY-0007QS-6H; Tue, 11 Aug 2026 02:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYW-0007OD-CC; Tue, 11 Aug 2026 02:01:44 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYU-0002ec-Nu; Tue, 11 Aug 2026 02:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR2rvK4UM+j7hlH+aJh9RfFwhsORaQTirpSXdbot/T5/QCiiefcdyL6VVf2vIbHefhAWXdr3ayWfZGSXOY2DYrxFoYSjNoeobynH+lfqkgwqHT0U9Eqwqr8UmlpZTikIeYYioYFJtoWSL+sr74+ZOX82YDWYMaArHT5ToYUNCkQxm0GHbeXvPXzEYYE8AFhhUJZ7nRy/H+G1qLOTHpTsF6Oeqv29eY1eWPEUrdKUsd6UoVfw4u/XTMOBmr0fKvFzIhABSLjq8modnmz71bz6Wc8SPuM8U8U28QKbhG9TTNkhdzLIyYaVce/kf/1oZhIhJ+KEVyDo28IZHUWn7GerOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxDHixTbFcCnCXqkBaMlb01Sj+zyq+1Pzx6kygNwe3g=;
 b=oliz1Mq818NZC1ZQKzhjWXZn1p+AwZrXNKUjjjZ4IpcxHV/AhuwosiEjH+CJ392ktd5wH08AdXtgb+LJ1U9viNRqbQsG/7g4EQ7wTcyaaJToIH0X9EMz7nLdnjbztiNJn8smAHbzlpynzn12eEI9vDzkRHOLXg1a6wnzrUceMm3zSG1dkgIM4vX/+mLafXn65HhM2JMflp4x6qO805F/J0sydToTIHFsqZY0cehyGtdk9w/i9Dg/t9c9+aXRLjNwKWcvJ7cHT9lA/fO87MNOleUZC0a5/z6nrr5z+FaSzldJnug61E5zI3EqZ4cN/ESO+HE1mFo8K2gavmkTPw0SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxDHixTbFcCnCXqkBaMlb01Sj+zyq+1Pzx6kygNwe3g=;
 b=sBJk8oXaRHrtnNjIb9C08MJwSC8c/aslVpFMcwAyGLtOZPLtLnv2FME4Ph/CsErUXLaAbD4HdHfIchwgnamMEsnrMa0WpTaD/gVji89RD2p4jKMGi17nbCXd/adDwcFdSzoDd2Lp2OlCM/946oOW4v8FZDq6HHTJSE+9Fk4/TCSX4ZR29naqViLf8KNd6YfFz861dinlzwp67ko8tAy1ogzEU9WwEONNIW5wEmUuALdbIrgy7t9JMspKk6l66c4HOMFw52HANqtOtrMtwugAywFf0REeFw0qvHCa62cEie5Xw6AT9QWVUcmpk++Ep6lQZROBcvE1RQ5IrTfl/p9gYA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:29 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:29 +0000
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
Subject: [PATCH v4 08/16] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Topic: [PATCH v4 08/16] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Index: AQHdKVbZzbQqrWtvSEatPUQYYCtOQw==
Date: Tue, 11 Aug 2026 06:01:27 +0000
Message-ID: <20260811060115.1849266-9-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF7489084AC:EE_
x-ms-office365-filtering-correlation-id: 5462f8d4-602b-42ce-3bd4-08def76dfc91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: I7y5RJKsX71Fs2Bg1aslHqOg0IuNv4CoBrgdzMkZc98uWQT1pYDUrV3jra3VMSL0xFgyoVlASdwhRXPHRZ9F4P8p31xnYpIhLt2jrSVV2Qwpoot8DWUPI0AoQbsijpO6AsDiFT0MRtlKvRx7vewe4zrRelMQgouXtBFW2sJbWPzQsmjqMcw/yUrU8qb84zJZHl6yA+z1xKZLIodJPBl4xiDaIn1RLYKVwoeE+pfloTwMlCZrs5Iv2UNfL0zRwdM9f4Zrg8/A7BzO299J2IWnVRjqFKNIfzA1KYWht5DYNMhi7xIlYTPEiBdlY8Tx00oaRBFtkEZTCHlp06TH7MR6RBGe261bXQnpeHG962QofwD8u18AVB79uVo5KWB21WROd01Dr2WcyQtDFoPjDZbCZc7Azz1LOdeaaXNzlH6zc+3eopvVBDLV5fXi06bdtbpY1t5eFPoLGNfQWEK/9pZJ2YoR/KwhHuLMTDSoiWeD7Ly6m2/J5fZUkacL+/qnsspS45ai4fIwjSeZcPdfp3TI5YI7qAjN/u8xPujrxkyiTfvDeMPqVb7mfQwYFXeAi+WjfaBXr7BgcYJUurzb/GmAvPjN7ueCA0BU/RpyiHpaoXKPQ5jo+Q119l0sjgmEMTothHyQPBt61m+wNp2rZQWi9cr+e+A8qpbBa6WjW9BHAu5zXNmiACNOGitaHhCAScVxk4vSnfFa6FMQVvXc/rRUpAbtdmJ9ehK8xD/NYAxGMRoy8HqdktpvovTmOSklT03b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j5BO7Vc7myEMVFuv3Hk2UpqlWobt+R3ShecWOsI7p8jNuBQXS1WH85tzn7?=
 =?iso-8859-1?Q?Cth0FjpXcH/ncg0YOp0Mycryt4ymIUducXkc9QUbRZV4tGMAjMavRt7jp2?=
 =?iso-8859-1?Q?vl+Cw437rH5uU233CB0EhXif7dr3XtKRZNjICtOYw7S8a6J+rGTG0bHahn?=
 =?iso-8859-1?Q?DeiEKf+57K+onFitaDzffxOXCe91arby2SVT6R6kKWN1leQlC1Gy5j3+/s?=
 =?iso-8859-1?Q?YW+aJ5f+bUMz6zPwDQsJzhHI2kN5nVv/LUcr4ibTDl9+9oeHlLnwU1jZud?=
 =?iso-8859-1?Q?2w95VFfJxk4TpNC2OUN3TbCORLBq2e+61koO/MCya1sk8YTP0sVKXX3Lfk?=
 =?iso-8859-1?Q?7n+pUuK9bCK76vefDWnWXViObZlfRiD1FaFRbh11ytYHmrer7j3DbK8dT8?=
 =?iso-8859-1?Q?dsW4uvp4GimjPSu53L8XxkN8tofF6imWeNIWtCGljYwqJnRlA6nkrcdHX0?=
 =?iso-8859-1?Q?KWBWbqdhUBJfpd9MECwypEeAcqzlRJP0zPOc3TZh77aiMyGBi4u0KsIgY2?=
 =?iso-8859-1?Q?Q7FAvYwnY49KFrVL7efhiwCIZV73Ui8UqMVxiu7N1yADs+Up7j36Y2+RLo?=
 =?iso-8859-1?Q?6Gd72l746QubBJDrnnuS6BkcmF3nQj5ZVUPXd6By2FyEJQ3eYfvmqRh6Fm?=
 =?iso-8859-1?Q?BChhuGO4QvJqGIYBOl1AEZ/nZyiGMHG2Fgx+WtTof4cvtd9JXzS5HMNXmf?=
 =?iso-8859-1?Q?f2oBcbIYBkcRcBdWdsQc6yGDZ/Fc9LHQET1enjt9ocwGTow++NG8zyLrsj?=
 =?iso-8859-1?Q?q7pO+FOfi6w2co73zlPzawTMrauwu1+Uy03Kj6AifRapccE/cb/SeUnMK/?=
 =?iso-8859-1?Q?q2cgiEi9VS0t1cd8V7UWj+jzPH5K5d3vgxUlKNgeSCcOcgguwVfuhO0Z7e?=
 =?iso-8859-1?Q?DvdRKZL3TELOt1bvcM3AspXkEMlSDiZAp/X6VXsCiSylgNZXoLY6esG0Ol?=
 =?iso-8859-1?Q?DuM/mkPJirq2iNFvbYhoK5hYOP6X5HLpMzmJJVvJPnCLKwM3AeiIQHeLxC?=
 =?iso-8859-1?Q?zntYIyilNk9VQkLTrEz8Kqgeg51ZZfK17XhRG4wvlnZbkeBpGiuFiG8dNf?=
 =?iso-8859-1?Q?4PKAwc7CDiP4k78fvUjmW/mG+PT0tto/SvurRfWDDTXQPlxEm/ZURLXVEl?=
 =?iso-8859-1?Q?y20aCKaYVoS+T3kL0BREarmrRfCjtrr5a0Tsxr6Y2/pq2whheiFhMcJ9PV?=
 =?iso-8859-1?Q?X6K7kPZpnSr+2J4Qjpb5IAdfiUlG7T0CHS9u2TX4lsGMhp2Bv0F7h5lCho?=
 =?iso-8859-1?Q?7u2JI4fR1Xz9IoiidM5wvh3ACWQam+bQiWqtMreQvyzJcGaUmkL97vgLRs?=
 =?iso-8859-1?Q?AeK1et8gL6z3Fmu4xOmTkKdUSUrhm4uv0+VTPetbhljw2nNlIMaZtxW1d3?=
 =?iso-8859-1?Q?8R0WwdludKp9Br1AQWIFQ4xf2ciqkfE7JJ4T0O6AN2/gy+Jj3ADoI4n9Nu?=
 =?iso-8859-1?Q?sHWQjdVWeplQcka9CRgXBzZBWnlW1O6W6YGwOfAPCT3wbXXRFsh5OUZWX+?=
 =?iso-8859-1?Q?wGvmcCu1duK2tlP4Jo8vXhhvACAD6m3opaAGPuMeaylg7hLZRhRdZXtj66?=
 =?iso-8859-1?Q?Rrko0QdVTtF+68sMHFLPdZAaot2C38SxZy3HM+ma8gFwe5DIV6O7dUxAib?=
 =?iso-8859-1?Q?MH/Yqoy7jRgwRtbXuBINQyoM63ZEKRP8CgWkR7/U9dF9mUJODvInKLsGPf?=
 =?iso-8859-1?Q?TlFg0VVQPSQEKgEcx5/mXOs7QPrMyjZ5OimdVoJ1N+s0WeshYFDu6fB55f?=
 =?iso-8859-1?Q?AcGs0PNM5E3cHW9Dyimeog4zT0VHr9SrPj3+q3wDZsbPOtStg68vbvCI8w?=
 =?iso-8859-1?Q?dzwWTN5uHQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZSYa1KT8OFZUAwzZo1rsTlWN3xwszglj6WhbBs+omr8oLuKLShUaGI+DODKpXxDgzczzpciGZMjQLrb0jNKrJgFqT7bOsRho4gwEORPdjFjJ6JJBKBAjJ1N3FNdKt8bL8BZ7kJ9ST69ANE6pWhqlWwMkDO63wGQA3pz6dzWnpFQq3uwjDUIo52k7wmsRM+MKcdy2culRr1S9I62lGyLtA49opq/G58AwoI/V+PpnlL90EaO+tzni+g+ASDysa2h3qdImTm82chQ1uelIUgAMiBDnd6GGX8p7HwFlqXH7Z/WTgl0GE/1KaGmgLhmTEFjXjB/VzeCq4ddEDU61LMuSuw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5462f8d4-602b-42ce-3bd4-08def76dfc91
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:27.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfKX3et1LDZqeksUsG6W5qYOm1pPCqejdhlexHwGQ3z+iELFfHeW/Ua3IIDvFci82rB5QghqwEFjMtAVevFQTFTgImn4B7ChruQ0zjWRiaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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

AEAD modes such as GCM authenticate optional associated data (AAD) and=0A=
produce an authentication tag, which the block-cipher encrypt/decrypt=0A=
interface cannot express. Add qcrypto_cipher_setaad() and=0A=
qcrypto_cipher_gettag() plus the matching backend driver hooks. The=0A=
generic front-end reports an error when the selected mode's driver does=0A=
not implement them, so calling them on a non-AEAD mode fails cleanly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 crypto/cipherpriv.h     |  8 ++++++++=0A=
 include/crypto/cipher.h | 36 ++++++++++++++++++++++++++++++++++++=0A=
 crypto/cipher.c         | 31 +++++++++++++++++++++++++++++++=0A=
 3 files changed, 75 insertions(+)=0A=
=0A=
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h=0A=
index 64737ce961..c4f995f369 100644=0A=
--- a/crypto/cipherpriv.h=0A=
+++ b/crypto/cipherpriv.h=0A=
@@ -34,6 +34,14 @@ struct QCryptoCipherDriver {=0A=
                         const uint8_t *iv, size_t niv,=0A=
                         Error **errp);=0A=
 =0A=
+    int (*cipher_setaad)(QCryptoCipher *cipher,=0A=
+                         const uint8_t *aad, size_t len,=0A=
+                         Error **errp);=0A=
+=0A=
+    int (*cipher_gettag)(QCryptoCipher *cipher,=0A=
+                         uint8_t *tag, size_t len,=0A=
+                         Error **errp);=0A=
+=0A=
     void (*cipher_free)(QCryptoCipher *cipher);=0A=
 };=0A=
 =0A=
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h=0A=
index 92939310ef..2e361411b9 100644=0A=
--- a/include/crypto/cipher.h=0A=
+++ b/include/crypto/cipher.h=0A=
@@ -235,4 +235,40 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,=0A=
                          const uint8_t *iv, size_t niv,=0A=
                          Error **errp);=0A=
 =0A=
+/**=0A=
+ * qcrypto_cipher_setaad:=0A=
+ * @cipher: the cipher object=0A=
+ * @aad: the associated data to authenticate=0A=
+ * @len: the length of @aad=0A=
+ * @errp: pointer to a NULL-initialized error object=0A=
+ *=0A=
+ * For AEAD modes such as GCM, feed the associated data (AAD) that is=0A=
+ * authenticated but not encrypted. It must be called after=0A=
+ * qcrypto_cipher_setiv() and before the first encrypt/decrypt call. It is=
=0A=
+ * an error to call this on a mode that is not an AEAD mode.=0A=
+ *=0A=
+ * Returns: 0 on success, -1 on error=0A=
+ */=0A=
+int qcrypto_cipher_setaad(QCryptoCipher *cipher,=0A=
+                          const uint8_t *aad, size_t len,=0A=
+                          Error **errp);=0A=
+=0A=
+/**=0A=
+ * qcrypto_cipher_gettag:=0A=
+ * @cipher: the cipher object=0A=
+ * @tag: buffer to receive the authentication tag=0A=
+ * @len: the length of @tag=0A=
+ * @errp: pointer to a NULL-initialized error object=0A=
+ *=0A=
+ * For AEAD modes such as GCM, read back the authentication tag computed=
=0A=
+ * over the associated data and the message. It must be called after the=
=0A=
+ * encrypt/decrypt operation. It is an error to call this on a mode that i=
s=0A=
+ * not an AEAD mode.=0A=
+ *=0A=
+ * Returns: 0 on success, -1 on error=0A=
+ */=0A=
+int qcrypto_cipher_gettag(QCryptoCipher *cipher,=0A=
+                          uint8_t *tag, size_t len,=0A=
+                          Error **errp);=0A=
+=0A=
 #endif /* QCRYPTO_CIPHER_H */=0A=
diff --git a/crypto/cipher.c b/crypto/cipher.c=0A=
index 64c2339d17..1dc912b217 100644=0A=
--- a/crypto/cipher.c=0A=
+++ b/crypto/cipher.c=0A=
@@ -205,6 +205,37 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,=0A=
 }=0A=
 =0A=
 =0A=
+int qcrypto_cipher_setaad(QCryptoCipher *cipher,=0A=
+                          const uint8_t *aad, size_t len,=0A=
+                          Error **errp)=0A=
+{=0A=
+    const QCryptoCipherDriver *drv =3D cipher->driver;=0A=
+=0A=
+    if (!drv->cipher_setaad) {=0A=
+        error_setg(errp, "The cipher mode does not support associated data=
");=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return drv->cipher_setaad(cipher, aad, len, errp);=0A=
+}=0A=
+=0A=
+=0A=
+int qcrypto_cipher_gettag(QCryptoCipher *cipher,=0A=
+                          uint8_t *tag, size_t len,=0A=
+                          Error **errp)=0A=
+{=0A=
+    const QCryptoCipherDriver *drv =3D cipher->driver;=0A=
+=0A=
+    if (!drv->cipher_gettag) {=0A=
+        error_setg(errp,=0A=
+                   "The cipher mode does not produce an authentication tag=
");=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return drv->cipher_gettag(cipher, tag, len, errp);=0A=
+}=0A=
+=0A=
+=0A=
 void qcrypto_cipher_free(QCryptoCipher *cipher)=0A=
 {=0A=
     if (cipher) {=0A=
-- =0A=
2.43.0=0A=

