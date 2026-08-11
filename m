Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDBCC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtct9-0003kK-C5; Mon, 10 Aug 2026 23:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct7-0003k3-U1; Mon, 10 Aug 2026 23:10:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct6-0004JO-7f; Mon, 10 Aug 2026 23:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzdtsntBedm3e2bBlew3ghdAq9DQlKRl0iQPVQGs07rJUL1rpz2k6BPhkCdpstQMJ3RZmqvglnNHdhy+haaXafv9y1a2q0DUb2CsyPoTmw8qiaw7eNph1TJ3uCqqzPT3qxzbIOzV3XHEWybLfjknmoNgKVb/L2d8dUwW8lPrqzacKnQvXH/XMsPDHY71PH1uWt26IOmH4ZOYDzIu5SMUcuqeplLDiuRaQOyfORNMiFY0oYestbf00262gTiHyOmJa4Tss4YJhRvYVvzsKHnFXj/0B11/VT1KNWq58RirSQM9t1GIIuBcjYcpebzmJ9mtrDwWuVrGfdMI+qX1++3O9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxDHixTbFcCnCXqkBaMlb01Sj+zyq+1Pzx6kygNwe3g=;
 b=wyXJPXXJqT0vlkXPHd6h46YAWhmoIcledj8emfms2DR2XIKwYOTWQhF+FVkc/9qDfySqC+Evex2DrGgMdZRuCOdpeTmxbEvu8EcvFFG8weClNizu/m2EoyQ5mr2iSpJnRWZwK+gOGKgcTIFCmOyKe3SfEUShOTytCpFNzGtK3ihS/0f6CQC4eEgoi5eplWDW2jlEu4yul/w2t7944su2mXC6mKlyGSsYE0Pt34g0dBqYT7YI6Ii+Gt+EHi4CHM42yyZi+pwOFjBNqXiQagUPrkzV0HotBgc1tC6SQWz4r96EMfblMCvH3S2aWuLEYRImgIaycGcxtDm6hWUq0xXfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxDHixTbFcCnCXqkBaMlb01Sj+zyq+1Pzx6kygNwe3g=;
 b=A2I9QrxzPntGIVFO4dOzc25GCo8VNP/q/Ri+No/8+U6K4zYYNg9fr7HyRJhfpFcevSL0UHH2qA/zrfEZ586FrlIRE89z65fQxUDWhmjBVt5bxHNbqcDL5ArnUdgo9v0LFpuJ5EGifN35zS40HtfluYp1mPWw8Uks/9LtrcelryU4fm8fXKoH9EK8GcNrvHH4U2qzkJ7V2Uh5AY5nX8rxf8ALNJVD7smXu1DDbUXgiwkcxlnELF/fblZJtdFNVxkTLSDNL7633fTenw6eW6oIsK675RO5gIudiBuSy4ZVW+ar1vrVpsqx46EHkz0M/9aKzF+T9C8wYZwnyK3GlEoqIQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:37 +0000
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
Subject: [PATCH v3 08/16] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Topic: [PATCH v3 08/16] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Index: AQHdKT77pXSnOMw11k2GWAVztsDaNw==
Date: Tue, 11 Aug 2026 03:10:37 +0000
Message-ID: <20260811031025.2784489-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 16934b00-64be-4319-1e58-08def7561de2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020|6133799003;
x-microsoft-antispam-message-info: h14UkT4T/PlcqYCaibDdCTTmRE305hXMz2w8GtPcIilSbYwWCNaF7KdWjm4COSOYewfy19vOkb27KrZKC9Z8obBfKgn7BjomYtEXArvlDhRzZWAXWYVTr1QHY4L0MvZGgUqaR7cK6AlpL3Kbf9/8ceydPAFVwXkl4V2TDuOlxs8E+ofttcmyHDpUMHKuHnf4R6Qn4LdEAFq+2ObhOnfYlYE5Q6UsdmZlFs2uRAF7DFhfWLWXr41W3GyuyAJEvp7PAL7+gkWWcoBL0V9CkMqYm8C+zf3QRpkTFCbAAe6VOSux7YwsLJgm295QQPbXtWMB1QN+NS/pGURSBk8nONXs+7AE4ENAOCv29HZz7FZk0TcTKd2XbkuWjxlq59aFj9now4bPL2i1IQ3+5z6TboWBUglEybAykzOO8jvkEPz4m3aEbWHy/nkEtv6dL29CVP65pz208Qpvxawz0e3TTqrcCBrztDANtx1hUjOWI7qruZPXeg/VrB5f5ek2sWiGCO8cLii7nimt3d5d6kbChifS4OU+DZXvk8vAQ5CAtYdDzgRGfdlIIXHxAY4nggdr9zi3976upYzTM5Qe2TXBriag8RwDP+uD7yuh03mmRnHtRkz1t/9FmC+S743/RZn0nOglQTccDM4USBbLPY1DTjiUOIqgvoblTgJTPiUblRG7rGiNXM1clUa3l/ZCywcvM3sNhXoUL39Dz6ojVhGB75v8NnleSsQaDL/X1nMcDznNVQkt06BuqdJVaA/M+t3JLlel
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7VkFVn2v1QUjMem8ikVwy5hFotsnI7nFLWtcPbjUiG62QLxXteutmzCTcH?=
 =?iso-8859-1?Q?qYQOD2qmkDnp+C2yJOM4LIpXCNaajiOboQV4U0jSVcV52wh5GrUP7CdogI?=
 =?iso-8859-1?Q?Eyi3yE33+SKJCqWsBezHaM+MuvjMgzipg9HU9LBuV9Nv50ZW0DXqN5qixS?=
 =?iso-8859-1?Q?PSHm1kg/xZ61vTPaCfVkMZWyAqzWxtEfDnQHU8SQFSd8lp4EoXJTOVSgvo?=
 =?iso-8859-1?Q?gggXubzUjY11IBUNDjVYfi0l/cwNanTmEIdxUbDiA+qjF/uJgJsKeT9rua?=
 =?iso-8859-1?Q?368h27tYHvZ2DN2WgN6ZmZHb/uHDa8s/JHOsNgkg5cclSQSI2PXp3iJp1h?=
 =?iso-8859-1?Q?7NFq3xcsjHgHHjpSxjnycB3+p1DhN51k3oqHTU7M3MHwfw9fvFh/KeCM7I?=
 =?iso-8859-1?Q?ygQwdiJ7SimTO9N8Nrgrylfe002OHPhKT2ICRlDvoouBdMnwhnEY9iDL/Q?=
 =?iso-8859-1?Q?9LKcNyCUGCO39IFjUrGlqAb+R14P8RIMXlvviVV9sV6FAQ3P7OMIAzRODx?=
 =?iso-8859-1?Q?FePIYrZUtxLlb2zCKw4WrjkNx9QNgbKNSeQ8OKWfNQk/vm3NsqkTVGgcqD?=
 =?iso-8859-1?Q?aumMPFLa8rNS/XlsR6NG+LWC3/m+2I/2DTUhZ3A+p+zhTrm0QhLJ7b6DdD?=
 =?iso-8859-1?Q?8wvD5Wm61+ZouYYAROpevaOz/3CTGSYPzSkePNDoclp4z17OjpNlKzbbAy?=
 =?iso-8859-1?Q?BoN7ZIg8a77Rt0x0EjyafXxXrrHKODcryk+h/UaBlOQdjQiIz65KlBGdNX?=
 =?iso-8859-1?Q?XhZfQnIn3o1CDFIneqiXylMoxUPH9LDN/NQgciZlo7jGHReBVvddB/m/i7?=
 =?iso-8859-1?Q?PoDlxosNdVP0pmLd59B2BQWcT0oj3MEyX76t0xIQvpeLSaKIWEYtfKCYDn?=
 =?iso-8859-1?Q?2V508GGCsebNfl8lrW/w7BFhrL6+fkXddqFzx4Z88sziVmb/RiD/1Jyr8D?=
 =?iso-8859-1?Q?Y4dQMaZGCwU0/m1jA+sc1YoDszbS/mXyQHLr2PYsTKdgv4asaJImNxb1C8?=
 =?iso-8859-1?Q?FmsEc1Zx0prRaeSfQPM4H4Oh0b6n2GHbIPwMra3MEXKjDe2jYZQk+Pis2B?=
 =?iso-8859-1?Q?SsXfY+diyUX+a6LvUqzkcaeKjL6vJV+glZd4gFeDnMBUyst3fHQYWQckpq?=
 =?iso-8859-1?Q?VMJOt6dFD3JlP55udHc9DAOxRvTLlBz3yPjvj2VR7MwrvFreat0dXY75co?=
 =?iso-8859-1?Q?rm3ams9JCDiwbX99v2Mw69hjLKKA1erTYJDKrFLnxfd7t7uh72ah86HGIE?=
 =?iso-8859-1?Q?I1nPwLTbUZDSgE5uS7KftsfvoIiOWLDd5sRlnbj1j+sMDrMR69xHRA1LB9?=
 =?iso-8859-1?Q?qWzFp6LVBjTkjCRsbDz50QAVW9SiwCqXQgaEyEX2Hc2R3B6OJLpOL5rsEu?=
 =?iso-8859-1?Q?CvujKUcxHFllRr6bRVystd8RqP6xNoqrV1a3eWhGX4KLR5E0omwbcEjGcn?=
 =?iso-8859-1?Q?EGReT286101L5NbXpaIhn7ZpaTAsUCU3CM3cywydiiCH9qUqlevCdiYeIW?=
 =?iso-8859-1?Q?/j7I9vLYj+XXavdn8LeH1/ge7OXtV/ez6coJgbhkmRKgXbqmlk4mal6DMw?=
 =?iso-8859-1?Q?VNU/ZsWfhhJKNeCMcTYvZ07cvMSlDXUIjHVNRwBtIkWny0oS/vLBxo7YJ6?=
 =?iso-8859-1?Q?SOn8gWxe9vHxTPWZK9nNIu3iAobFu4iBRIwhk8HTx12jkPKjLHbtBJYjjS?=
 =?iso-8859-1?Q?NoaVwGEl2WamrtkWQzhL1QHtkg7LCO4cGFEByUL9g60tikt+AvjnHDuFWH?=
 =?iso-8859-1?Q?ba/E+bYroQgWtLKUbBpiIZK6QZ0h55h2RfGMGBvZMcbiWtzkOmBW6HMxBj?=
 =?iso-8859-1?Q?K+rMSyeWQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z0w7r3V646+JCvjRXQiyw+dyAeEAwso4B9hYTkDHj/nPsEs1fRdtntmqsy03+NqoETptUXv7+5UOTt6qMyiHM3JuvaNKAgL5ZH4q2F2F6dWKtXAPj5YHh1mPzShsQkSa0gxXHqm/qZrNHyudGt0RFmU38kfBaUVwLfFiHcVs0EihJY58s0gJ1A8sMxTDwCYUJ7lVm7pfAnqsX2Ud1q9ET78bqczEeOqTz0puNu6dWzOVZiEiEtSCky3rTUlNJegfiDPG0PFgA6Oa5j7OAvVUcv8AtXBwQ8FJC2Z6qkz3RvR3cTIeB43IeBiGN5Fu7D51qr+yLdUBNnbqQdC5gc+WkQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16934b00-64be-4319-1e58-08def7561de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:37.3718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wt9SBl+2fm/L/LtQqPifF90ldRoHlEmE5DppEm38v9FXOiBUziNSCaZ2UT3eFmvxLGleVGu8qmnqaRbYJNU1+LQFKjlKJDVKNSwit1xWzQ4=
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

