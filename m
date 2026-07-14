Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0124C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXa8-0005rT-6R; Tue, 14 Jul 2026 03:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa4-0005qI-H6; Tue, 14 Jul 2026 03:29:28 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa2-0006WV-MY; Tue, 14 Jul 2026 03:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpwrjHydfe+nqZz/Lievl9HB2pVdRKKtpydWC4H5T1nRSSCCOGnyXF+f6J6G9RBV5OYokr6dJDdD4roc3U50O1oS0qvr/LDnaGmXCarUqWYHUOfybr3g0KKdfgEZvUCmxRrzGT5wwgG7s3n/2X9jIRU9lQozSK0EWk9tvB4161YpB8+6tV5oqRbwjG2mbJzXq9OLKeiSzxNqQPBMdsnagdW+hVlLDVx5j95j986hQ29228J93elNF5uSEU6FxmZyYn0SVKQ73RlDg/e4osqN7iuvWNDzI3z7mNBYCRJvYEDQrDgra1AuDfSjqcMlOnd/14G3zbyVamsk2O5RtHmznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHDOcYpSQCeiBu0DGhdVsdWJkNeDlZ6zM+BxWOrBJZE=;
 b=wbA6oGiyRG2yOp2ZL6QhinN5YIQxYY2a4xvR/XOlwpQHDOPjkJd4tnqZXUCOGkI5l0s93miq7k/Lj7f6zZzH5XJaTV6dtPF93go7VpIBr3ijoGFHClNpf0VhzJouCpfEH2we71x4ZSY+Xb3D9/k2KNXX9RC5UamX4JzFJreCgcKDW7Dl8MnriM0AYDOzR/vOkDneOVCpuk4BpffgM7VjsYQxWIZDpNpEZWPp+J/d/nf1WWmLakVxrDKgT8TuUhk8IBTNB8pdn658+jvAZ9gPkyQ2lxkE86gP7ti+KHYtS29VyDPzGpSId3eMY9WVOx+K2A63VARuIWp2Rmju7iu81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHDOcYpSQCeiBu0DGhdVsdWJkNeDlZ6zM+BxWOrBJZE=;
 b=ieURE2zfVoSDD4hy/alWm86byKIwaGUp4KIRpEUwR5KLVI0jCeqGmcWk85ljgL+e2Npw5FR8IUhjY4EKQlOv+ycD3emwMlbNA2fugK8Y97K2nkAV9bxWNaYmGeqSEVkOve3OUuNR9AYALuVr5ahKMvSqhzN6SNgSIcL/9k/Id3af9BXGP+cNsE4T0BuNVJpaMxi1z/xCWkDQ/knHugieRPj6BO8Snqf1olOKDvwgm3834jdTX0WKWcIKIj0MkqbsVH3gD6v5aajseQbWrwpF2hofHkpR5YjJXCFViPxrJh3ymLomfnKfXiXqTaengJ2YCXpIcwtwDljuiECNO50k8g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:13 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:13 +0000
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
Subject: [PATCH v1 08/15] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Topic: [PATCH v1 08/15] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Index: AQHdE2J4BDeYN29QKESbldEIhTDvKA==
Date: Tue, 14 Jul 2026 07:29:13 +0000
Message-ID: <20260714072900.3023742-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: bb596b3a-b94e-413a-1be0-08dee1799aad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|6133799003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 48YxcA07Bhv/QZ7xJbAUYgorddaEA1NUKtXNwDeyTDVA6veKDn+pwy7NK5YG2JJGEKJA/ABsBzhh2OvXPfDJs0p7zY1twTZfVUrBHUxHXcEKlc/g8rHbVhLLt3QQG4/swPyAANmVU40Az4mlEKG1cWjwcYW7+AOQFEm+Xe9xjRTLF4KvgbzH91swfdPMpLxR2i8mChnqZLD/0d8LOLNvoc73yJXjSQkh6vLsRGwzYcQjefdEvWLpd7ODb8MIW+UlvyXJH+djqv1ywRXFtJs9OOisCJgHU7+z4tKIegVFzbouAEPQgFVdz7h1cyXhV8wjuZte4gNNLF/NALdxlveDaJRRDgchA7uK8HgDyoGNOM0vogfsJjmGJeW+4WpIhchCEkSCpN3uT4NWu7cJM+wQzO01rzI8doNhjNiL3qzEH8IbIuaWpCrOV/KBlzZw6OJHXtbTw7oE98YUcLDUIb73C9Ed9Z/FkBc0i5se59KZV54AI8FMdqtVyP4gYXCAqrtzlR4Ic1CoNrRshOxAYPAs6aiTGSPChTAj7vcVg3kDZXqGl01uZa7hrNC7PjxvHM5ufC+0cHLXk09kSdWaupWqa1VZyAKGNU+UgrQw2U0qJL+ILI7O3MISEsIe7t9dwMiWol3ABJaNo6e4Tqek4Lf6tDQEfigl9rsOkBvOW5yw+vi26tJ9vKX5lvDEdD+MevSjYIf3rRpmDgwGjUc45PkA3EEIhMD2a7eIjvNWPwcWfWKw3mjgsvQsbGBQRpTwzyIq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vojzuTIPN5F7AHREozkmu2spO275CEDrmNi9iBD7gFTErBQJVTWhg+Gdm+?=
 =?iso-8859-1?Q?cQ+k/4TnFshRXVWADQmvNdfHAWa+J42H77h3Yc/ZvAB3Z9RmMVukWdkado?=
 =?iso-8859-1?Q?HCgThvdaO2cxYR0/AA6HLNEblELQJ8OTCRTwA5M1rsOfdxyfY6QQyG2Op9?=
 =?iso-8859-1?Q?mGJ8/Mg4vbOsh9wggUkzTXBGn0ygN9q+6o40v7NAlOWQ5IadiQUm9luLpW?=
 =?iso-8859-1?Q?6q4O8mPwjDhSgn28X3kSt/PlSH7NDuKm7GABTHur4HWyhVfACYF2O4k+dN?=
 =?iso-8859-1?Q?ycyuD7pr7AIy0Zh7kDmTHgQFJtEcwfxTvgGyJU5dZ/jl1cpdsVE+/S7DGj?=
 =?iso-8859-1?Q?ysra8U19FF+rt0wkzaDIMFfALuPIhZ4yHB1oDWHBsKhRluf+vclRf7wtww?=
 =?iso-8859-1?Q?bTnX/4j+PlQ72PQvDBpt7/m+ba7FHirVh5Z+b4KFnlfMvr+ia8MmyOP4zJ?=
 =?iso-8859-1?Q?uvHK4xa7d90ac4s184lroNV4c1f3cW358vcXfEGOsACHQPSQnrwJtSRhEO?=
 =?iso-8859-1?Q?6SFcEp+Sfxpqq9dL5MvcigJUVPKizt71j9sDJ8Q7goJkAOgXjhFdJlvyo6?=
 =?iso-8859-1?Q?ZbokqLxIKwLVQ1meIF5q5vrBPgaCDAwIlpiNFNzSEuKuQKL30yGN0dBMrE?=
 =?iso-8859-1?Q?pbj39WQhWmTzaiOCi+bKYm4lWh7yNfL4qIeO2cBUSq6aCowgTVKRJKY6BP?=
 =?iso-8859-1?Q?wM//Id/ev3BVHZwHJ4E4DpRt9lbqJ4d75Sv9G/3dOwivphyzE4DwJ6QZ7T?=
 =?iso-8859-1?Q?1EBOUP4G4J1suKleX7Z8RAie+7wgmPveYkniqN8eB+0QnumFyr6jamGveu?=
 =?iso-8859-1?Q?Mn8pOZM3uX2W7UHmc6MBgDEu/DgLEeqs5q3xCDCMnC4H+QUH8U80cXAbZ5?=
 =?iso-8859-1?Q?UHr1QMeox2RTjVeygG7ip/IakRHG6zIO4m7vEf0tZzw59YzS7eQGiaTKjv?=
 =?iso-8859-1?Q?DISjY+PL6rauwwQaabNhhnbtTAHQocOzrl0/LOB1wNEKPVjYVKYnIO82kL?=
 =?iso-8859-1?Q?qMFQbgZ06ctZx/ug4TVaBOK1VjkKkzuZtyeQK2xvLEL5ACSYqtZTjG5Taj?=
 =?iso-8859-1?Q?0+uz7dIdV2LlHbzgDjG80hvvgvYLiSZyOcOC8dx4yRNcMC3QcPPRkZ5bSp?=
 =?iso-8859-1?Q?NZhsvIXpRH2KZE8mrtZgDkByIs3eVEmQZxRAv+7DSaYn0Zaq4exmH7naRb?=
 =?iso-8859-1?Q?NI3keu1/nRy+r/uY0aTVigTkETL5rdAsTHsotT4GUoi1KiMDsUBoIpahYI?=
 =?iso-8859-1?Q?IJYRsfO4S2AJRxmLUY6jbeDAtyD0d3We6RUGB9eRDE47uWvc4chwJ0BO17?=
 =?iso-8859-1?Q?/dai3EwM1Zrvmy4Yas9VoDbDsg/Th7wZ27I5W2EZIyySQZuf07IvhAMHZv?=
 =?iso-8859-1?Q?da6dK94X6rwEm2xWKV9T8bDwLKBy3fFw61MiIqH6xoyPcCTWL1p6rpoPO/?=
 =?iso-8859-1?Q?V2lcFmnTBISE+TLRU0U+oFBYmZl02SNtzLNw5nZZOIIfT8mpiN4q+cODh0?=
 =?iso-8859-1?Q?Qo7U6zouvylrdq6xGxU1tPlaOmhdI7BbbMjTKU7+ZtSHIPCmV8xVW/3ftX?=
 =?iso-8859-1?Q?/uDOkXIkzIsm7Btnh1y3BRMO7Y81c8Q5Yg518QUf4tBLE8+0v48/ze5bkQ?=
 =?iso-8859-1?Q?7ntwYdPODYzRKrZx35PFQYkBtZjBnndHDVsq6HZgk3Bem9weFpLaDt0PWn?=
 =?iso-8859-1?Q?ETR9BXgI1eUPmUHbKBCj2mji2pVfhWbyFLu78MDfv9ILOTds+wlkvGvcLT?=
 =?iso-8859-1?Q?KtUGBVf6N7EP1Md69rqE2YkV6PQgZzqfdcRLfl1SX1l2IMUaID4s6KKqUP?=
 =?iso-8859-1?Q?T6iAsoCe7w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YfDp5s3Ftp0I9VRAVVwl1lQ4N+Rm51Kcu14YhxAyWacQ2pZt9RX3nnbDmhD4EE5rNxF+9ZnLn+9wfq7qSAWMDzUdiCwlzY6RjSwxom8ELnVNcOopwhzeDjemSk1Gj992m5oWTMSEVyqU4IFYUpwUE1s9LfwscDur2tVOG6Q77HX6RiEkura935Ol2sSSJssYloYRmiwpyA1XaneytdIugaYK1ej8XxJI9bYgQcrxB1ilotzmBShRvaEAljrYxMMzGuQQuriXQSfXVVFXGwDrbyFx4rkp3+dDqkiCAgVhNgIUigSFIZgq5R+ngww9tQAIg8I77Lf6JdGZFZ9v8PtSpg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb596b3a-b94e-413a-1be0-08dee1799aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:13.4432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PV26vCzAyRBIUmxJ7HRLXBQg057q2HYl9LrjLZYWzX61Xg5RBj4voqZye5A/zuMWhO4CltFR5fmTm52dvnMHMpq/CR0W86Ipcn0ZpsdQik=
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

AEAD modes such as GCM authenticate optional associated data (AAD) and=0A=
produce an authentication tag, which the block-cipher encrypt/decrypt=0A=
interface cannot express. Add qcrypto_cipher_setaad() and=0A=
qcrypto_cipher_gettag() plus the matching backend driver hooks. The=0A=
generic front-end reports an error when the selected mode's driver does=0A=
not implement them, so calling them on a non-AEAD mode fails cleanly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
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
index 52d071a90c..67014aad6f 100644=0A=
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

