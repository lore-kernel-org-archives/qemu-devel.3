Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F488C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXaC-0005sj-QN; Tue, 14 Jul 2026 03:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa5-0005r2-NZ; Tue, 14 Jul 2026 03:29:31 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa4-0006VZ-17; Tue, 14 Jul 2026 03:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wciapx1ti5GFtqQI3t35J9WQ6JyZJgLwUZcGQexs39M+ehKc8UYHbXnh5p+OXwjKTodPIdBqOITjEIKN5uXsa6K0XKWLp7GeSRjrxc3go5UkiODQMKXeGDjQQc+3JdwXTrSWNN818dTjfedN554KaLXe4hy/o8oMiimUAGdQfPvqvhIxfm+lmNGQtwBPD4xQErklQ5E3crjBcxLkwcUGsOE0XsMoNJuo/R+60Pfy6w4AuuITj4k3yJts2qpuxZCIrcIgetTGybNE/PLrbVmThPcoQkxoFXdDifppQM1htQdK7nQy/Tz5K6Kt2yWVJCbi6XVIb3Ntyz0uVDK4zNU/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7wYXyRoYpqK6eBRIQ5YtoArQoYI7m8ZmkUoX0rqD3s=;
 b=qLMjnyF71KyE2r5XUIQe2L6n3GVQUbYVKa32WIQclZE+xbch52qG+8GzjpJn4sFbohbHqtfxHbB16LA4gjbBiBAuEJUj4ViS6lWSI7gsl1eKLcxJvjtD5Yr7myhXGGbn15pVudTXUWTaXyh5LkYIrIrNERbqC3+219G092IOVdknISbNWpIPhRJd560l+13bX5TC7HEwd+RHrmxfVO3grdtisfhowtRRze833i0xuHZLyN0CewelAi+Xnyu7T0MT4j9svc4d4IwKQtkXEHa1PP4xCZoxVT3KT9HPcrQIp3VHxdoa9X6MT68Ltw7/GwEOu++q//0ZmG+WYfRdH51uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7wYXyRoYpqK6eBRIQ5YtoArQoYI7m8ZmkUoX0rqD3s=;
 b=PgoRtV+GCE7nIfcxUXqum9U3t1GSBAk2XlAE4Ld63l/x0zddnywN8UhD8TeAGAgoGbLyJU/oDp+/mdlQU+BcoupLgb99mCgLGlXoMHKmwJvluenguLjT/8MWVzDsmI6SY6fwWeBXtCju/g2Fkw+zhdv6xq5kSu74dnHixUCGJ8wEMPS0E5ad+dimq0MPa4tchDlMMOPgExRbMepXfQQMDZGBlqpo5HV2EJzZUfWqJrvhv0BZEKGD9i75+MiDsK5xJAeuskaGpXhE8KpDE7KrwYINXW7Mo3fT34j379KDBw7zNL2fZy7fB5iBVU5M6O1alCWEQNxTLqEq+ziyVt08ww==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:15 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:15 +0000
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
Subject: [PATCH v1 09/15] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Topic: [PATCH v1 09/15] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Index: AQHdE2J4sGl5DbtMwk+MdOQEAPtj7g==
Date: Tue, 14 Jul 2026 07:29:14 +0000
Message-ID: <20260714072900.3023742-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 445c0dd5-c3e9-4e2d-8e2e-08dee1799b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|6133799003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: vbZmHy8txuC3aOOMpuZrv3fp1JCaT0aTp/tCgkNUSZXKNWOkG7u01jlzvNqm+tMxgU7oAz53uIJcPkE3UqQnu++Ye+ypr6E418TcBme2cSLzfAX3ystt+UoN0l1MDkSSTb8IFGXPNDz4G3j7/tuZ0H6vG44+vq6gXDHsSCItS9T6MMbdBoL1URoHQ71mdfbq2hhwWyPJjjOLUFUyqvH6bsC8QXGMdwg04Di8jmBtTP2ojutoSaNEFjNJU+2fi/iT0s3uBqeWOroXHD5eg5IN0n44TRoWDuyfiOLjl6P1llFzX7EFRaWzZPIxooHb2KD7IXWc38bSGkXT788DUaWxhPIQ6Ugg+7JHfnXz4vWbUr0UYIDIqRKD2Zk44w8gijjxi71MlDihOuG3JepvaZifWuykqP4StMXFrfVMQLoeJ/6ua93HQNHMGdWpMSu7iIk4e1WOa+QLvFMV883CVD/JhUfPSK71U/2WwQ6Hr3gd/fzsJBxQCYDiIIzE5EAWmqzbZWYq5XoID8cccaZJBtCa5CuXuXgpAUmMUsAAntZff6FolfliquHZvYBrMPuLxbuxcmK3E/ZOxiE88zqO+wTDfwIhqxHs1fcwTH4E4JCT/cx3iB5dzgYhxxbMQmGjsLCUOjYTvrtU+XTRPjfdx8BqExuayHGnEBzGXy6TjCPNcuq0vyc7j4zwQYQDl86pSHVEax6rAfW/o2bgXbEN4LQBRJfjzqG+hF7kguUs00pZkCYCPz+b/3ei7AEt5cH9YaOr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hiEUs5jHutb3l+Sh4ZNHJLZlQ2xS4vCYIw8Yb5sEnDo9DSqhgXNa63tqB3?=
 =?iso-8859-1?Q?w0Q4TnQyrhHKAnC5tM7zz1OMet87WBArashk48fFyQqpdiVArO1z0jIV2T?=
 =?iso-8859-1?Q?eKvZk3yLmJ9wT5BYuomykJj32HILR5805N+cEo8CoAMjN+SVWV2LFaxJgM?=
 =?iso-8859-1?Q?yVtZQuVzvnrshYJz/WywS23Vc7PJ9hmpQgPa2ZHjW2Uc5zxPyxGwmRheVs?=
 =?iso-8859-1?Q?vQRh/ASV3wsgP1E84vtL38VCq70UIgQlkpBUhorr3L6KhTgTO+o1q0OK1p?=
 =?iso-8859-1?Q?nkvl4E8DrkWMabvxaxwPdmfYOZVya8uRSFCLP4IiL9F6jI/pTHq15r0NzA?=
 =?iso-8859-1?Q?iCV//bgVUUzQDvFzpYVnGhqJxySQ9hyduGo7xxpOEgBjYFHREL7YiZZ+Ui?=
 =?iso-8859-1?Q?6mLH32GFv7BWypgFO1hYqEOwFpohwksTFHqxbmT8S6lwauOTd77D+uee86?=
 =?iso-8859-1?Q?8WdRSN3a+D/vJOGDAlHP25QyAUTjrHpH5RvSCtzDl+72qgCSBDkqOzrYKu?=
 =?iso-8859-1?Q?p7e85Iw4fg/gTO0ApZBQWZuYQiGuLo7Qf11vgBh6DIBwibNGy+g8EVJUNz?=
 =?iso-8859-1?Q?pdAAmRzqFwlco2Awxdd7Fd/OWT50FDth/m6YBBrie2K/2WV2iBUC2HZL6s?=
 =?iso-8859-1?Q?k3bt3Zw/rnEWDjwY6KOWHTjWJPRmi8xBpEB+SIofBJiMEynIf/+NLIz5mj?=
 =?iso-8859-1?Q?aQdY6/7FlTXCicw+I60rP9EwIsxjkOcrU2wC+7ornkjKX80ONTnSHpBus5?=
 =?iso-8859-1?Q?PJrNf7VEGObvwObQUW5NjwVdpN1TRrBvYyiBdW33uUh3yQh89RPlzSe+Jc?=
 =?iso-8859-1?Q?m2hF92WWH3RO0qJ30lKSXT16Q++VSVUk7bFhXSbshONaj39do2qK2YO5Cd?=
 =?iso-8859-1?Q?LtI1e8/J6u9RDvVg3F1jrHikUCU5NmygspvcfZprk3pyGfdFtPNMTKK20v?=
 =?iso-8859-1?Q?f0tSnzZs/0TQoSiZ6xKDKxghyZGfTWB1Dd2vkYqAy76VfP5lkd4h37Zaq+?=
 =?iso-8859-1?Q?cZHTxnJePXsye9NsehQomuKO/2pw9fIP2+4CnBUxVz5FbBG6CiCpK6bGUY?=
 =?iso-8859-1?Q?Kx1NrOYJA5B/mWXqup8lYfHGNOZlIju0q2zG0dpGaoCQwJdEyyOVItkObs?=
 =?iso-8859-1?Q?ZzQXyp3J1Mvpgozv+/JUkP/4aP24gDDwsm3ZBMV0H1722ZnC5zPkZfdrB9?=
 =?iso-8859-1?Q?jWH5gQtQubnZnG6ZzXPDgL1JchZeYU3lNAllQ+raL6xbQfhdAINlu54Y63?=
 =?iso-8859-1?Q?e3ZSFLqFMNK5BiABmVTBtCMBF9pO7AKX/53Iehh9jrNqwpCfhB3bicL4FY?=
 =?iso-8859-1?Q?2m2Wa5Pp6rd7D7k/9a1r0hcRQAvbL0UpPWl8CZWZ2QSyjugd7a3Vn0Qunz?=
 =?iso-8859-1?Q?beqibjx8thzXVTjX5G6dgIdAAeKuIyMthc+4uaJ+fLF8aYyMxOAwz6edHh?=
 =?iso-8859-1?Q?8jZG3WJVXmirJ1PkURaxfiA0r/opqjyGRZmfuq0i5iIR69OPGEcFiRk/GC?=
 =?iso-8859-1?Q?n46MMTpmyp1M2H4QSc0CHTkbtSoXHq0xBmXMWBmf3Y41ANdNNWFgMExrNe?=
 =?iso-8859-1?Q?RB8KsQhQXM0lA6tjtNKJBZEUfSDwibUdBc29L329uwYHdKpPVaCdPI1Zo2?=
 =?iso-8859-1?Q?UWIbv2NFyiPyjCeM6d1Jo3Xdz12V1m6d+LF5Oypi7p8WqMWxek4U6p18mn?=
 =?iso-8859-1?Q?dgytbed8f4tj76t+6pTf4v48lenI6QxvmjhpEOs/VvCTKfqDtYsq+wgN0I?=
 =?iso-8859-1?Q?/in/t48RDXeh6BGl+YyXlqIhG+zfTNpcwhCGZOzT7PW7///7RSp1aBuVbl?=
 =?iso-8859-1?Q?Lw7ZhhiB9Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fv+rmTMwSM1P8WLgkrjSy8eoUGK2a2MwE/x4gn/ipqnPSFM6+GZOY19aF/CQ762mfdzh1Y+5KY2F7Enk61qpTrL8zcQYUMDB/plaMDZL9J47OproY+nYdSM6zvTKL8bLmkWrYvc57itZ8ygBthyLelxryFVpzoZV2afIw6cgOwLzz5+zr/XBvLJa9FVQI4YHd/jRDi/+G5ncghoGNkVyJiULqxUsFRCiMKGXNnW/gfVgLp9XQHEWXhj5LpgMVVS+CFZUZxdQOvYKdoobs0OsLo3AAb/yOOa7uZvIrItGY646I8ZDK2tSHJCZo7uwXoR3H7NJqibrc8GfNsj6HEu0ew==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445c0dd5-c3e9-4e2d-8e2e-08dee1799b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:14.9729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+qwR8hO710WDzaNfCAgEKRbuRs4mjJoHimvYsEyyn2KtLNhe9QZifSAJCBMl66alReNh9cNlwRAt/scgZCyrsvNdXuSfMwX5jkreqGQEIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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

Map QCRYPTO_CIPHER_MODE_GCM to GCRY_CIPHER_MODE_GCM and advertise it in=0A=
qcrypto_cipher_supports() for 128-bit block ciphers. Add a GCM driver=0A=
whose setiv accepts the (typically 96-bit) nonce, whose encrypt/decrypt=0A=
do not require block-aligned lengths, and which implements setaad via=0A=
gcry_cipher_authenticate() and gettag via gcry_cipher_gettag().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
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

