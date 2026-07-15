Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D3DC4450C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNZ-0003B4-UA; Tue, 14 Jul 2026 23:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNN-00037N-BY; Tue, 14 Jul 2026 23:33:39 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNL-0000oW-Gr; Tue, 14 Jul 2026 23:33:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNtvnh0mCSDYLUeVvAiAKoEC17b/6Q6JTI/r8grcWVIBMhzU0MbMECrVaz5bmZ32SjEiN/wL/Apg4DKUtU826XI37g6e/ncKnEkupUU1JuOw4wz4l7cKLGdiqUaHTWBjSPnYZqNU/lddkGIyKlBCTflYy7ldZght2xnpZRJB4tDiF6xegNBVIBY+5GSATp7/pe+jfk+5Z9a5Ti+NojMlchMjR0KWMzsu6qfGIv034UxSBwXAnSbBayyg5vfdn3ZNHmNKmoPLmX1aVJtOsTAPmobe1HhJCHov/pEPicg7WS+tC/3UJP8otiyRpPR0crHJ30YIERir24F/hRaTU0+bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cac0a6Uep3e3shBIHUrm9AMlDFZQ9DRl10gs5CRpiNw=;
 b=eC9CNLbPa6z6cMxAk94gXXECPO+itSUY6HVQ70Z6CXD+z2GhNtFBiq+6Ii100UKiKQ+kB1hr9i9g7syJfyx+rHrRwPOD/w1cDwgLxiSorczAcvEBpP1mL0FHNFJfdGHIUylkfPLj+0pqu0cvxFcli6koPXIJ5FkzT+TUzLNjXEeyzxeyHVsVhSksuecOoMZeGMcZ2DaINR6JSpXJyzkTzP6mqRxWxEQ0sDBNziyRi9h2Gxyy06Lchuqb959fYYyOHOVbuBy1pSyybV8rxK/VPaK6kyAVHvgpzJYWtQozT7Wv/Li5v6CWa2ODfOTWPFljfJSFfkCNGvONEkm+dlthiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cac0a6Uep3e3shBIHUrm9AMlDFZQ9DRl10gs5CRpiNw=;
 b=r99nMS7U/DH9BtvLZqSgd8g4tl2NhMPO9rtW+DMUxeXLioEcJbThiSrb3ET3P+9PsvSlq1uPzSd6T79RK6pRqE3PCjpgSGZDRxu1zKNwrvepv9Xl8Xy/TfDqKJW590RMKKJC5EF5pe2ff/FxyyTxBJ4tD5CEzkRu3p7/JO5blRmz4CEuYINLu3zJlrN3G5GJ2CdNt8BpeQYbfmhXAzRfUPePLwetq8EI338DrEfXBu4fUDhkB7ZPIG7DyjZde2CHejqJTLNN++ItXqBhfA/qqnGt3SGJKk8T2LmG8mjeR9bln8MW2R5MWXVcIMEH29bujuzHDquc2JAf5ChrWA4gqQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:25 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:25 +0000
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
Subject: [PATCH v2 08/17] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Topic: [PATCH v2 08/17] crypto/cipher: Add setaad/gettag for AEAD modes
Thread-Index: AQHdFAqxWedOU6pRL0Oc6AVs77tDTQ==
Date: Wed, 15 Jul 2026 03:33:25 +0000
Message-ID: <20260715033311.1648424-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6c802112-c5e7-4058-a340-08dee221d41d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|6133799003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: HHaETSkMYhG6lkIre5I0m4ZuDOotas4cbIxCe3D4UqM4BEcHkSn15NL+P+UkfsfZdwI5owJr2y7woOriwhTdmfd37w+eLvXgw3EheN1OenTF+i+P7JunZTafX2MJXgFPcKKYE6jRDNWoMgK+AxKM8WDyZQTs+9tjjWmRLtoTKCxWPNbp/Regi5tlCrD0MFCzLotN++1YfExMdsge79HtxNdBnH388SQwLFbq5UrP2u0+rpYvonKYqLTB5HNyZovX8ztaec2DKHCNK9dlLR8PLe4mDzoaRNX0qVYTQgiYdHQMyK8s379vDFDdbzNV2LgRwMR2JaHZTq9g3eszPVYEgczYF2vKzBzaisO4kIfv2dG7xPkNeNAxVSR9l5pfBhn34WC+BgWDu3Eas6MYO2tSo0yIjdL15MK73xsDw912qBtFUoiL6lFHkLRPvBqdF94pUZlcnOyCpKv+Aops53JCZqTKm6dJDO0+7RLJ/90+cQ3M2YKXypD402HBRAQr3vbPnGF+jLy3r0N8NxJpaW7zC4yrbJMNmYcpylWeO/wf6L6GqiC3/PS/agiXNmJn1Atmnk06zos/1skVbPt8l9Nuo6w0U7I77yT3nBUHoAZK0tcyvZ91mZYDDXtC8JP9odkSjgmrXb2nHtZeJir/0dNnz5qpm2Q5YvqW4COASbm04sjUA3oHVsjRSmZQp0tuWsTpx799W+p8SLK2XjgCFvhOiwNiOpdziPzbFj4WZxwvI6Ep+UCsfVfzQFbpL8Fb+Ke/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gQjVxeY5SFg4iXEKXBta0CpWBW/mDEktm7WOiOkTWyo35WUgAvL6TtZ8WR?=
 =?iso-8859-1?Q?x4/sbfZkDcyFoB/I9Bgw2VUiHoL6UGl/DTI6sThwa7rglHEHPw+PK/iifH?=
 =?iso-8859-1?Q?nVKaeQDrJOnhFImoixfzt5kLjXo8vehzC2MkiV/TwEnP8vS/Vm4T4iDESA?=
 =?iso-8859-1?Q?YDtLFWnoMmkWpJ8uUMfPIg/mvClsiXhgdQib/GaA763b3JDP78WHARwoYc?=
 =?iso-8859-1?Q?3V41HT9+DMlAtHHjMHnC38Eb0v8IAZ+0z4/ytrN1Hx8HxU120jp+5aUFWC?=
 =?iso-8859-1?Q?iJkdh9aSVhkKQxPLt3G5Z/3nOxo0b4vOHmPIWptCyNM91pUoViozvWVInA?=
 =?iso-8859-1?Q?P8aLRY1WhFiNLp4z6IvZyQxFnr+PjPCefcMZUKeLRALsykOAqgmwUf/EZv?=
 =?iso-8859-1?Q?028/slaro1n9riFuPsabPQdJNHFh/aXcUd3VZRbuPOV7tQCzxZ3oDmRp8C?=
 =?iso-8859-1?Q?pSTVnO3hV7TNtyN3w6tP6EOySlb/MZ7F2eDqgTXImfDfmlNTU3C0ouCOpi?=
 =?iso-8859-1?Q?lwB5RCOcPOWnx2Q6acaN40peXlCMIjXlM11E/OEUO7OVdF7pIta/lpSnrj?=
 =?iso-8859-1?Q?MNLvMPtHqgNWcyxvpQaz/HGo7GKC3GXlCOc06edNhSCOJGMBCEVWs6CVPG?=
 =?iso-8859-1?Q?thqWdsqgwnoWcQWGd5tO4eoFb4R6tYrvld+pB6KkjerrsJkNGo157a/O52?=
 =?iso-8859-1?Q?da4/mmI18Um03PDFEm02MoVgLVbA3Uga8ZiR1a9eEokj6fZ0YCF76/QS00?=
 =?iso-8859-1?Q?s8ghYJcLMVAZFMG5NreEyFjPUnKTP8ZtR/q3QzwjtSPI08TEIJOYEo5IIR?=
 =?iso-8859-1?Q?XLJOPeNYL/GBPMNaAicEuQxkGTLpfUL5jApu/LX2azP+RdYIL/9sF3shZz?=
 =?iso-8859-1?Q?//7PpvBgBpll76GJgpGVqB6/lIppAT21BR3UO2REltXQ0XrpwpjEZfnDWe?=
 =?iso-8859-1?Q?WMvpurQCLlkGhMRTAo+TvRdRPVwmr4Mi6K/fOWUiYuo7bt37ESAmsjq5pR?=
 =?iso-8859-1?Q?7tfOd4kLanHdhn8XD+J3o9kuZC59K+dxm+hQt95lA9QFEo5L9W+qaQa1qk?=
 =?iso-8859-1?Q?zDxC2Snl+UrT+Es8Avp/P+5AZZwgY0CaJ6h3Gd0UuXnpZ+1B2mrj5pYTIa?=
 =?iso-8859-1?Q?qAeaxq1OqnvJTFsBqQ5qTQ8vEMiZiICZ/53zPMBYYqjs0sCY7ZVMMU0ZQ3?=
 =?iso-8859-1?Q?i2zOIgEW0bswDzkcoVAMgzOAX290zqFg+lUO4iDTcs2xtAFfkLmQPvRIs1?=
 =?iso-8859-1?Q?zHnFpqKleyUz7bwymsjd/IjVjG+XDOdyQJ3FcnXB4v+8OauN3MZxG2q6jR?=
 =?iso-8859-1?Q?sXRIFWViPnRbqA347fPsvLRxXFZTcTUbr8MsQiXfy8SLO7c2Zasi1+35pk?=
 =?iso-8859-1?Q?vlStSeekUsV2M6+Kfy0dKsFGQLaXaJW9we62RnL3fUoGmlTj2B8aWDxlCC?=
 =?iso-8859-1?Q?SAFiidgaQr4GTt00lKWI+rMoEPiyQ00NyvQcb8f45n7Dpkjzs8pSWjyeoF?=
 =?iso-8859-1?Q?t6iUdAwuV5N66JIhQdW2M1uj1mFc83YXOmQe8tTtzs4IV/KROhSfWVwvgF?=
 =?iso-8859-1?Q?yiNaky7kEWoILwIkt9TWrgi3Zd7X1domg4jTWnoEIDQa+VEyyghdMlGPIb?=
 =?iso-8859-1?Q?tQf7MITbAN7xjSvSNWNF7ssJQY1aSelNzjLH/UG0HacLnNsiPAGZ1By/ay?=
 =?iso-8859-1?Q?lVIAWVezrkY84ykkrDFInRlACr1T7JW2tNPE85ux4hk6fS7rGTKKa2kyh0?=
 =?iso-8859-1?Q?ACjDa/YjFOZ3MebNlfjWIIu9IDO9a4uLOWatMsqQybKzF9hgpGUOzfJVH4?=
 =?iso-8859-1?Q?hoFwAqq5NQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MpAlRqRKed3t9YcZ1ZxbezrJvcBJ45O7d18mJK429EYP3YxlPUFkQyMcOTcwgdgZQ5Kzua1hO08TBvNknQfg3c4olV1sWzAhlLnV3i4qxLppY7oZBGRYp2tbF97EF5iOUeoowc7BQpXmxfFbE47hkaK5ka9NSw+OT4WqJ4yvmDvv7x67MvLdKXI+utV9HIp92rVkEThaVtQ0gv3D9AZScaPMqXIurakwo3aO1H1Uz3kQMFoUGiSj4nwpvRbbCOl3wmfFehpmDRBOx/LGIk5nJ6+Q9dRvVM9SIYPORjlrVuWNnjGHS1gM9/anue1IOf6n6/+XfeeL+LWCq6Q0YQUesA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c802112-c5e7-4058-a340-08dee221d41d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:25.3216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpKm78oceiIHBOGd0CvRB4kmHFYr/fxiJT6phnBkOGUveG4DdMAnylzJtPjHCzmbQqKfly9Ers2N0IZN3aP7UVOScmDlDb9WkeG7r/le4pk=
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

AEAD modes such as GCM authenticate optional associated data (AAD) and=0A=
produce an authentication tag, which the block-cipher encrypt/decrypt=0A=
interface cannot express. Add qcrypto_cipher_setaad() and=0A=
qcrypto_cipher_gettag() plus the matching backend driver hooks. The=0A=
generic front-end reports an error when the selected mode's driver does=0A=
not implement them, so calling them on a non-AEAD mode fails cleanly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
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

