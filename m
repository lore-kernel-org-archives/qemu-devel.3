Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20560C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtctZ-0003vI-R9; Mon, 10 Aug 2026 23:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctX-0003tm-8T; Mon, 10 Aug 2026 23:11:15 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctV-0004L5-Bn; Mon, 10 Aug 2026 23:11:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTJjNUjLm5rI+hXe4PbG/5DpK7Ax23O46dg47xFSu2ePqzORXbxRxVzU8ezW09rX7FxKQAeWwk+eFuKUX1BvhCg2dOclhyWrFQB5eN2OxF4FkrCjr69UqQkyCAOVtvjJGM71yD0dC4TP8cL1q+R3xlJk/OEo7ELYMV70UTinLLknyliezs8e62m+GesHMryX2RE78FCbWT59jz+B99HiLOYEuuKfikctKzvWrk/QZww8LSKhtdPLqi9o1U9/1MkGCJVqQaJz/Tny3gssD2WElUj4c8x6LNQw36uwWWYa0WYsrQ1Ax7PA6ls6kRilGuz2XhxXLJQl2wQBQRhecCKSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTC7ut6YwVEwF+IAwlfwDPid4eoWB3dHvtOkd+o9Fmg=;
 b=W7RO9BHZFF/HBJfeaoId8nHCaYsrLZdBfzrrpbNY0ECqP+qDIC8fQez+J+Q29UzdFq5j4beyiE+Ylk4Fe0KH9txvIOLfvccRiRm1DbZO5FMVRQKnSpe3hHDgH9v95OAEhxLJvM3tNOkLOtSvrh7XPQmgtL7T+hM8PhJQSsd/AQ8T7VBCWmPnoSwNHB57d5Y+Ecs0bVrpMYRidBZZieGzdwUytxOeLL6MOm4Rtg6WrTj4nYONTBwAUmMF7hXVYM3DSCzjhhBG0FO63edLauP1n9JcOmfJkiQyAFLhsuzxJH9oYF0YwnCQQe/tzBKqMXI+PqS2ylHtkYpZzKQjZzd/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTC7ut6YwVEwF+IAwlfwDPid4eoWB3dHvtOkd+o9Fmg=;
 b=EVSEhsFTq7onjZ4riYlRzCqqvesDGSLTIlE4yixmeITuXTWgD9vQHzXrSA3DWgR7BuS3foqugYZj0Hgg5p7loU7GFbygCnmXXhRGEOOpzZK4R49gcohOTkUK5TYE0qXokk8Sv7jPG1GALYYs2GY/A1l56cB3G3HtaehpbcUW323zrQ+PBmFQ6sE9/x3n6pNsY3zB7bzWWZqt9BSDLG3zeM1wvghDI9QXiJekcWddK9N3Nx7ysmmygwnHoZ3IirrV06XI2oWqU3DZAgj4ekjPhCQNsBtdiDgryCKLbiiS7FcrvKw58AgKD1lgtiLVqIlneioRITRHzPboB8ThM51noA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:41 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:41 +0000
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
Subject: [PATCH v3 11/16] crypto/cipher-gnutls: Implement AES-GCM
Thread-Topic: [PATCH v3 11/16] crypto/cipher-gnutls: Implement AES-GCM
Thread-Index: AQHdKT79fUVE5Yoh5kSVZsw6VNoktA==
Date: Tue, 11 Aug 2026 03:10:41 +0000
Message-ID: <20260811031025.2784489-12-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e52e085a-0bc1-4478-bfb7-08def7562030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020|6133799003;
x-microsoft-antispam-message-info: L+jpoF64jPIjeKl9U9vBLWW0xqfbU6T6+3UwkMRAzTyq9kLPpYzBPi9xRAshS9Ot9zc9YkgT1KJEXFkzWpiE9/e9dha3v1eAk2P20WAAgWjN5upUkvqXU7AFXsppRcDhrQ6CTQg5WGB4kB5p18VczPoNHMXojfBkLqe4zEuCg5q+rAEa0VzMexaqyG3uildg3poCTpkPofG1E18g6Pcz5V7Kf+xiptZwh4aD3rgy0l3RVl8TQRFoohfuG54JwWyTqGoCi4YMyYmpHyDkNFfF32MFtF6P0UrUv3IYPCb6/rCKNVjj5ll4o+dBfBz3vsYRt7bM/XpOO4kWhJzcUCzewERiMhT6Uvvjcoa4VbYOmEygeiAtBfJ+hhsl2rpdvB04MKn9rb6l5IX/fe92ISOCocNdXHwQPiVMdy7sjVYk/9xIRFPvLyyufaZAs7Fh1+1ghmuCRXX8Bwg3LV4KJ0uqza1qRK5Q045Caf0P/YreaLgP0/X7jurzcvfqsoUjjvY572SIkstdYe2BLCtha5yCOOSpP+bDqzk+4eJjFD6yVqD/W+YKFp6UqJlD7uU9ia2cfLvB2ZtctdEjv7or6jl6bO162f32HiGL4KTMcGN5m2jsUJTBAvrXAiC3KuXsm0kEwTE77u1iAEBhfoWf2eFuWXoBAge/lLIcRJzUw0Bb57j3iyLpxGjqYN2fB2hyGWLNJEN5PEoRkNgcx1/msJdfAo9zpCCxrxLX6nRwrELEXAg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Qf4T6xqFABRzy7IeelwDKspeyDHySJDdgmX//dPY9SyWR159KPubR2cGPc?=
 =?iso-8859-1?Q?bBM7LV9AVnVIc1PcMIdg6Bj9zfBHAmJXz89kZIj4Htdwfx69mnKPZLNIOP?=
 =?iso-8859-1?Q?wlFhEjx6wWW0GxdNZpuQBMsOtuEcikkF+vn4k5lLMlEQkQNZhFWF7Z5/lP?=
 =?iso-8859-1?Q?nutnGExuIE+8qFLbmcIYZc2O7bqdBcLAESuEszbup00LbftISfZ349nqdz?=
 =?iso-8859-1?Q?OczEkBnIbb+8guS/hZ2O9rWdL/BKlNG9bcZLYiBG08tf4DI1No2fIT40Zj?=
 =?iso-8859-1?Q?W6ajX7ww79XFLAn3zByV281YYI2SbpJL/VW+MUlDUFxuEm3lLWTbLev8ok?=
 =?iso-8859-1?Q?wRbBf0RXp/0wTyjfxYJKHmYySgfKna/mqp5/RBxeo/nB4JINSyFR7I4OcC?=
 =?iso-8859-1?Q?kFl62vjYqigErAzTeLX17r1laVmlQeCgF2yRYghg01I0o9MeuDcpnw+79n?=
 =?iso-8859-1?Q?epSH2QYwFMLzAkoTaZYDUk8ir7s5R323nAfoCfikH16Zr3Xym+m/L8U+YA?=
 =?iso-8859-1?Q?UU+3s1cmGPaHeyqowjhKvjCd9lvRmqwKsOzE36sbj8SHyuFtHVQgUpVYgw?=
 =?iso-8859-1?Q?mhdm4jZbkEmxkjBSLw0VroC1BUxIYbloENPpfkvL010JTIgGNt6mTPDhGM?=
 =?iso-8859-1?Q?lHW5vlWYW8k+z24cRXIAe6rRICTP4ZA5Vyrb6CDaoSh3TTXHRPs5eV89iz?=
 =?iso-8859-1?Q?RxXVcVn8DtXnXEyM24hpucc+aslqhFcNRTOD4/kLsh5+3mFlOzmbQNGRej?=
 =?iso-8859-1?Q?3HOFH6ClkzE2uGlxoD1jgwApfKNZ+AASKObA/wK9DM/WO8hLET0YTicPsF?=
 =?iso-8859-1?Q?U6RfbW7JhVlmQPw5GEExV2Xiy5vh4oB+gl6rKVH//c1rfrGMS18/TdMlIK?=
 =?iso-8859-1?Q?qYrjaId9pGIKFWU3i9fJInWp0vtDlFgi9izMe88sufLG3/PEMiV5ssD93H?=
 =?iso-8859-1?Q?SjhrFx43DY4xGG33Eq3KT2aQBYKmNSblWcZnynq6wBveWY82siGHof2/IX?=
 =?iso-8859-1?Q?PBmXt+tIU17D49MWMixa2ZRTD+h5Z+R8gz/pf2LcH5psQCtPOhzEyE5wo+?=
 =?iso-8859-1?Q?M6Zt0Cg35AkwC7ofCC301A5GcsrkcZpQTFxaMjK3ev/qA6AJv+Vei3IkG5?=
 =?iso-8859-1?Q?G30WDWMPQK7GOKxhTgrK25Tm77Ba36Hx7ofeM1momOA/K1zGS/TW3XjVKY?=
 =?iso-8859-1?Q?y1ZBWK0zs533QSKoLptNopAYC/OaG9XYqOeCFEKGmxR2+vZ4/XjwUKw2ZI?=
 =?iso-8859-1?Q?2bTHI1o/Urqc5GYV9fqohu1WT8qWvlmMTEUc1azZ3cFfzgxxWgyju1NP4p?=
 =?iso-8859-1?Q?xXTlprwiKae7Cuoat+iHkt6H77Am4OtW1Ttdro0keLSI/JXt7iWnySUnB2?=
 =?iso-8859-1?Q?COmtFOPkmxZ7RmrBDqlCccLlOgoCZU1KdgjztTX3gxFNBR6MuPg40aE8za?=
 =?iso-8859-1?Q?WqpxjOAlhxfuVzeaTtLlS/D5KW9Z2uNQ28Q6gZGvH3vqpEEg+mQg9gnu8a?=
 =?iso-8859-1?Q?3FYG1cnXguayqc5c3MCZEdRgeynU3ejvnP5BzT5QCCzCORyMARPIvGhpvF?=
 =?iso-8859-1?Q?DskU07uucDiZKQMHy5aC3AjRbaE+hZH2pyR3khz1BWXGUr8yegIaA0BVwq?=
 =?iso-8859-1?Q?AdqA9k9ro2lbis0t6/Eldgr9HYAg8LRpx61VcfuI1OChylr+BSLaxKb7Gw?=
 =?iso-8859-1?Q?au1SLV5yti3lcFaSsTSdP00vB3OliHB5n9rExvE340SvWj2A6hogBXtcbC?=
 =?iso-8859-1?Q?0ByxLTWvYfUpREjM4v94UVg2unWNK+knM6JXqkC5sWCST0eBHga0Zm0kvP?=
 =?iso-8859-1?Q?ipP4kQKjRg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VkUo9YumEXkurmPZHRs2YPOX6BzBhizslF4wa78oG+KQYj2FE1nsAm3zArrbI/FWNwFK99ZlaWVudOaba+vJYsp8NetOciwywdgdlD0efCwSFBwZp1n2LH8UsbFhlvKlxvUmuJ2VzAyMpCZVoA3pQZUa4LnZAB1gcMF4VK9FPmj6oXtSlNCkZzkhCZXQ9O8k5Wp7xd93tWvExasxrGFIicY/L8F0gtOEHMohBecCd9Dlcl+MNo21xWH4gG6h3TQJ5ZkvJrx+Y1jlUQ3EK1wd4O/9d1MFdPM8hoYBCNEqu8Z2+8ngILB+Yrg4W+OeC2RZnJLdzoVwNSJbppA8UT8krA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52e085a-0bc1-4478-bfb7-08def7562030
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:41.2080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZXKktw+AwuEk3o2rJsBjPQv5FsexvpUsBIaz8W5A4maXUOAh98vz6j48bFL02Zsgx0Sg3G82KO99NzGuni8z2KRkxH81WUTWrqbQ7Zbi4w=
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

Add the AES-GCM AEAD mode to the gnutls backend so it is available when=0A=
QEMU is built with gnutls (neither gcrypt nor nettle). GCM uses the=0A=
incremental gnutls_cipher_* API with the GNUTLS_CIPHER_AES_*_GCM=0A=
algorithms: gnutls_cipher_set_iv() sets the nonce, gnutls_cipher_add_auth()=
=0A=
feeds the associated data, gnutls_cipher_encrypt2()/decrypt2() process the=
=0A=
message, and gnutls_cipher_tag() reads back the authentication tag.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 crypto/cipher-gnutls.c.inc | 154 +++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 154 insertions(+)=0A=
=0A=
diff --git a/crypto/cipher-gnutls.c.inc b/crypto/cipher-gnutls.c.inc=0A=
index a8263fff6d..963b328fa1 100644=0A=
--- a/crypto/cipher-gnutls.c.inc=0A=
+++ b/crypto/cipher-gnutls.c.inc=0A=
@@ -48,6 +48,15 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,=0A=
         default:=0A=
             return false;=0A=
         }=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        switch (alg) {=0A=
+        case QCRYPTO_CIPHER_ALGO_AES_128:=0A=
+        case QCRYPTO_CIPHER_ALGO_AES_192:=0A=
+        case QCRYPTO_CIPHER_ALGO_AES_256:=0A=
+            return true;=0A=
+        default:=0A=
+            return false;=0A=
+        }=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -223,6 +232,147 @@ static struct QCryptoCipherDriver gnutls_driver =3D {=
=0A=
     .cipher_free =3D qcrypto_gnutls_cipher_free,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * GCM is an AEAD stream mode: the nonce need not match the block size, th=
e=0A=
+ * message length need not be a multiple of the block size, associated dat=
a is=0A=
+ * fed with gnutls_cipher_add_auth() and the authentication tag is read ba=
ck=0A=
+ * with gnutls_cipher_tag().=0A=
+ */=0A=
+static int=0A=
+qcrypto_gnutls_cipher_encrypt_gcm(QCryptoCipher *cipher,=0A=
+                                  const void *in, void *out,=0A=
+                                  size_t len, Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_encrypt2(ctx->handle, in, len, out, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot encrypt data: %s", gnutls_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_decrypt_gcm(QCryptoCipher *cipher,=0A=
+                                  const void *in, void *out,=0A=
+                                  size_t len, Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_decrypt2(ctx->handle, in, len, out, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot decrypt data: %s", gnutls_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_setiv_gcm(QCryptoCipher *cipher,=0A=
+                                const uint8_t *iv, size_t niv,=0A=
+                                Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+=0A=
+    gnutls_cipher_set_iv(ctx->handle, (void *)iv, niv);=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_setaad_gcm(QCryptoCipher *cipher,=0A=
+                                 const uint8_t *aad, size_t len,=0A=
+                                 Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_add_auth(ctx->handle, aad, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot add associated data: %s",=0A=
+                   gnutls_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+qcrypto_gnutls_cipher_gettag_gcm(QCryptoCipher *cipher,=0A=
+                                 uint8_t *tag, size_t len,=0A=
+                                 Error **errp)=0A=
+{=0A=
+    QCryptoCipherGnutls *ctx =3D container_of(cipher, QCryptoCipherGnutls,=
 base);=0A=
+    int err;=0A=
+=0A=
+    err =3D gnutls_cipher_tag(ctx->handle, tag, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot get authentication tag: %s",=0A=
+                   gnutls_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static struct QCryptoCipherDriver gnutls_gcm_driver =3D {=0A=
+    .cipher_encrypt =3D qcrypto_gnutls_cipher_encrypt_gcm,=0A=
+    .cipher_decrypt =3D qcrypto_gnutls_cipher_decrypt_gcm,=0A=
+    .cipher_setiv =3D qcrypto_gnutls_cipher_setiv_gcm,=0A=
+    .cipher_setaad =3D qcrypto_gnutls_cipher_setaad_gcm,=0A=
+    .cipher_gettag =3D qcrypto_gnutls_cipher_gettag_gcm,=0A=
+    .cipher_free =3D qcrypto_gnutls_cipher_free,=0A=
+};=0A=
+=0A=
+static QCryptoCipher *=0A=
+qcrypto_gnutls_aes_gcm_ctx_new(QCryptoCipherAlgo alg, const uint8_t *key,=
=0A=
+                               size_t nkey, Error **errp)=0A=
+{=0A=
+    gnutls_datum_t gkey =3D { (unsigned char *)key, nkey };=0A=
+    gnutls_cipher_algorithm_t galg =3D GNUTLS_CIPHER_UNKNOWN;=0A=
+    QCryptoCipherGnutls *ctx;=0A=
+    int err;=0A=
+=0A=
+    switch (alg) {=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_128:=0A=
+        galg =3D GNUTLS_CIPHER_AES_128_GCM;=0A=
+        break;=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_192:=0A=
+        galg =3D GNUTLS_CIPHER_AES_192_GCM;=0A=
+        break;=0A=
+    case QCRYPTO_CIPHER_ALGO_AES_256:=0A=
+        galg =3D GNUTLS_CIPHER_AES_256_GCM;=0A=
+        break;=0A=
+    default:=0A=
+        error_setg(errp, "Unsupported cipher algorithm %s with GCM mode",=
=0A=
+                   QCryptoCipherAlgo_str(alg));=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    if (!qcrypto_cipher_validate_key_length(alg, QCRYPTO_CIPHER_MODE_GCM,=
=0A=
+                                            nkey, errp)) {=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    ctx =3D g_new0(QCryptoCipherGnutls, 1);=0A=
+    ctx->base.driver =3D &gnutls_gcm_driver;=0A=
+    ctx->blocksize =3D 16;=0A=
+=0A=
+    err =3D gnutls_cipher_init(&ctx->handle, galg, &gkey, NULL);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot initialize cipher: %s", gnutls_strerror(e=
rr));=0A=
+        g_free(ctx);=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    return &ctx->base;=0A=
+}=0A=
+=0A=
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,=0A=
                                              QCryptoCipherMode mode,=0A=
                                              const uint8_t *key,=0A=
@@ -234,6 +384,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCi=
pherAlgo alg,=0A=
     gnutls_cipher_algorithm_t galg =3D GNUTLS_CIPHER_UNKNOWN;=0A=
     int err;=0A=
 =0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        return qcrypto_gnutls_aes_gcm_ctx_new(alg, key, nkey, errp);=0A=
+    }=0A=
+=0A=
     switch (mode) {=0A=
     case QCRYPTO_CIPHER_MODE_XTS:=0A=
         switch (alg) {=0A=
-- =0A=
2.43.0=0A=

