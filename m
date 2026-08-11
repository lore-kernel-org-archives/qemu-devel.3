Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF4C5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYX-0007Pc-9t; Tue, 11 Aug 2026 02:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYV-0007MR-34; Tue, 11 Aug 2026 02:01:43 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYT-0002cm-Li; Tue, 11 Aug 2026 02:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAEDulhSuDMkScCXkqvRYWhIHU+9P84d8ZmFA0NNsVqWQvH5igwW9HaMvpwdNzn1XMGk1FUWBS4BfHItVyCCjokaZd0Py/ywMAOUey5XxP0t+PM/hBFhC2V2YCRJ5i220U1qUX5NZX0fZYTh12AKUeT8iKqUdK0GOhwwFUzJaHu0Mn7TAGhx1cZbhCXz7d6jYVcsObav6pEY1Xthsl1Ce6bDuPqEiLAmgKvRJUUMIFwopNVwYEHx2b1aKPNHb9WIRx7xEU3IcaVJttv3hO57Iw3S4kFlWPf2+ABXnSEvbrl3JMtTukal5qx3THSwA4bgFx1e7eWtuXcagqHX9y+X6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7MKGiOv6przKsAtCaIX+547piZmqccGb15nbMZw+84=;
 b=ctMcNQfWWk8nv4zH8xS/sROHD+sANoOEjYC77QD27d+SoFF2t+odecSebLSQu0V67ZbgyZiCHdgeH0z5AnuSLHTZ32AvfOWAlZZgcMk2orzeJzEWLP1BUnbFl3YuZjK4M7IT2v84DsQ1+8PoiaqS0Lv/7xDz5d54ESaqUBeyOJg9T+FbwywlUtzLiDsjhbUBFS2vfqr+d5SPWTcakeeZ6Cwfw949biCRkOssbUN+rZpGCOrYR7VgiTeZvLDxJGsn02f7AI0gkJIs+xH/bVP00wUeORBo/gH4jtOPbB7c9Ddrg8RzeUZYNRXMIwzfTApJlf62hN/IkzhARTr9rGPxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7MKGiOv6przKsAtCaIX+547piZmqccGb15nbMZw+84=;
 b=S5/MYO7piajImnTheJ0OFwf4ZmYjA1R33kgzGbl7W/g83LpGCtKIGj1dIOdzfZMD1rEKqkt9F87qIcq4cWVysJFWaIMY3Ndp27KrmcF93nE/yUFxIE9v5nTRIOGi77hC1Zb4IR7JyAciQ89IhksRO3NnYIPTHFGe/fRj95R8M4QJZ089FhxnKV7oc37z0QC7f+ywbRlq1W7OEWuJK2/NVrjrZ6eMUjIBa5UzvpyE52Zb2Fah07CVh0Pcn852FJv4zA8IzwVHXcENgfhHbZXhVjB4hUdvxEDtr0iZS/dNW8X/ca1BNsgi0M2gkEkUivba4cbwAUjDYxW7LsJ3+mPuDw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:29 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:26 +0000
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
Subject: [PATCH v4 07/16] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Topic: [PATCH v4 07/16] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Index: AQHdKVbYmWOugrEsB0qDlPmnFkYtRQ==
Date: Tue, 11 Aug 2026 06:01:26 +0000
Message-ID: <20260811060115.1849266-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: b63fb260-d3e1-4d5c-fda2-08def76dfac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: ko7S9Un8PyrkmFbnhvFtPdJOkJ1Su4+hyGvYL7/1I3osrhRdEsQpJN4JTVaF65q06PUayQTD16EV686VNSjthwsC5P/Cyb8wwJoIpAN0C3lD+DYwjjrxvg3p5RLdD9krOyVZVrKnHXY3AYRuO6IboQRKSNX6YlOE/Nj21boq5bRbmXvpJHs9uk+gX75UsMdBStcaShasBRXoTb/I0VXEdtYl5VBPB++wKduIPiiKuM78FVF23S76yrqvGAtUiddXte/toV3+gmoYrKUAfH6I6yOEmJPD/JfB+vk+24rio1Ry8aJFaFZQWR18lFftEwFTx5CJS/aKjFYqJsmp+N/qbm0OgdmWNGwJw/sMQvFbDOp1Lvtq3dB/dCRdRxq2GNI+nuMV3TecU4AkTg3kNwCfbWh9OIfaYMkzRb03DLO2D0kOzACyxlgr2GvWqUAoOsQIu0xYdaiD+X50t6eL9QOxQ1bL2nzmthm44DRDBFXrgomhHypHJ9pSEiKYjiRanjxuMTaxdFHycApz9G9R1lMimPTXmugi1nbDrKu3JvzPKmgPVUDIr7tqYgfpEwPl7POj0NebhtKjY8UmYH7Yo+9mbhvn+Kl2oL540DtfW1D0Npna3TiYiDSybwG83V4uogef9noAG4GxhHXaDED6hkNxRrYFOAf48TXSkQkENeTV/SFpUDVi+M8C9SsRrYoYyjs2t90MmZoeV8pfUNp9NgG1bsiwBdfjLpzM9gAzgQEcXEZkM0oBMMPOOgw0xsArvTff
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iMbNpL7tcDbCurDz1hsddhBXuZ4NRzQm72pt4ExQrI02zloJGqXq0DsqTP?=
 =?iso-8859-1?Q?PUX0n+Nc1v7IuhL9Zt0hhKDIGrJyzPBt+3TT5y9Z1YrBiX7k861BUErSxl?=
 =?iso-8859-1?Q?6GxBlwj06oy7e1CfJ9mQjtRlFatyBAwGVQoFL7mTA/aNARDp1FzTY+kqpA?=
 =?iso-8859-1?Q?QHaK4/S/thaPKxTbYki5681/NR6zgoR7WFxFBMNDXzEm7ATFSh7/mTAclR?=
 =?iso-8859-1?Q?cQXVW7/m50KQkcgzAy9ZF04S6jMXD1G3lJxoNSr411z1njFlCTjsCOiz/s?=
 =?iso-8859-1?Q?RZ0Vjc/cIDhHm5bFNkw72arR5JqMfz5E1ZNa22WMfoIWk2SGcWoiIK6gEN?=
 =?iso-8859-1?Q?8c7Y6NegC8j0a7636eiJKXYXqqlnmGJiYC2FNLpLbp1nCmGM2Sn0/+PiSV?=
 =?iso-8859-1?Q?vG3jBjHKWLr5ISBRT58JHkNoZa118h5IcfG7tBdPJS1J5dJpTL1NYSIiol?=
 =?iso-8859-1?Q?aODgxQIva+ewydUTe0Ye3eqJmqpKFjRjnhoutfOFuG1SeExgL1SP8N7OK6?=
 =?iso-8859-1?Q?pQHch1Wo1ixh7YieHOs3YgqEQ21Vj2l9W+9c5P7mE8oQopyv3bpy8VwCzc?=
 =?iso-8859-1?Q?fPV9DCxUWeZCLFbRW+vH3WNtRFcuwnbYtHID3OquTMCiwWINNTyWSzkf0U?=
 =?iso-8859-1?Q?D206fmgoKrPNM2TiBYOCJRc/PIAkoYJLubl0BD7K+Ezw5Qkm1HtnDWXIJ7?=
 =?iso-8859-1?Q?SWJZH0UwnJpBPF64YN7mGZg0lWlGmZXvJXMl6N235D4UD7/jU5KZRtxwbT?=
 =?iso-8859-1?Q?wMcoTOT1w7GNxIBD1vkaSy1NZEAJPXQrncc5VbO4tQjo1F9v8TDFuYi+Di?=
 =?iso-8859-1?Q?EHE1+CZKDIXFHrnyIRLbJy3ui9QPwwsdFamPSOWP+2IgmhaPWNgGLOFOvz?=
 =?iso-8859-1?Q?drlV1wecY+R9oeTiLMxV4ioDKM1IrqH+xd68hnaGj5MxkZ5xJ3Ch6fo7TD?=
 =?iso-8859-1?Q?9v7W+lmWrsaNaZayRHDr+ubQvI/1IxdmmFw8Jf6IxgMPQ5tycXvh+Yodks?=
 =?iso-8859-1?Q?mSEOLO3IlLP0gQqnnY1vNdJihANZoB5eMUN+Z9YiTlmezFoXzCZlAK+vlR?=
 =?iso-8859-1?Q?OlMe84qHVShxJHEEtlY/Bf/6ICqSP6CYt1gX40s9CMPMu6X/RAkQVZYhcq?=
 =?iso-8859-1?Q?UoDKjkcDB+rlj5U8LNNg8ui5t1Pqs/6ZgsyBgp6LP26oFkaW56SyNzPdb3?=
 =?iso-8859-1?Q?SmeJliSipiPGUmxr4EsLYShNDmbtaPKNcf93qTT8abvL4j5md71tkfTUQG?=
 =?iso-8859-1?Q?z+oUbVjxswHB+JKaTaUFxWGAavKasJwujq/cJFee9ksGJi/zsNVEHk4QPi?=
 =?iso-8859-1?Q?DOyaG8u6XmdmigVk2U+jHLAXrw9Kv3HjDjJUw1qQZMH7KvNtoeEiHiDPI1?=
 =?iso-8859-1?Q?OoeOXFkFZP5oLrs7DEndmfjCZlS7QUX4+D8P4ZiQ1CSwLTMXKSVuN0kOca?=
 =?iso-8859-1?Q?HIa91Op1nhGRSqHxZHA0j68PWPA6TRdcdE1+y6xqN2jtcDlckeX58ZDbuq?=
 =?iso-8859-1?Q?O/oQNkQQsU7UKvYJs+e4eAEpgX4svHklvZEDyDzOBVQzqcjfVgcaHo7syB?=
 =?iso-8859-1?Q?q0KeB4IMj3g0vMOvg5E0yR1VwiTY6xbvoNOW3T84AflFBxCgMDarTtGZB6?=
 =?iso-8859-1?Q?XDa7KQ7XPPXLH+tNmgH7VxLlO2/gCB09PKMUtxkj4qGfWys0CvZ/6i5AQc?=
 =?iso-8859-1?Q?Zhq0yWTXru9Etn3Q1UjOer3SD4s1d/6hnZSDekyx8+rUSsPsRKnzjhsNkd?=
 =?iso-8859-1?Q?wYqvbXo+vnzxyttUVsGi32QzjIbOY+Yb+15JUc1db0kmVElibqlEFDqurP?=
 =?iso-8859-1?Q?iRTCOJRJVw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ezf9sn63kkx1PEx4KVKTYg1wMHh9DGrwJPxrMpoBL6CQP03EOXUCtBESYaQz6n2QQ2RdQJyPOFClL1tmIFB9uT7EEdlRCU1vf1WC4hCy6qQPVc8okpFQIpOS/AIkBObtDS2rqatb+CFQKe7ypkFcpj02alId3buTXGCd+yVuplUnttKmvrVWXCVjUKF0aVk1yjwA4p7zxW/bVMoHD7F76XGnG6LcJXCZUQBK5h7TpAemu5MvJcNlQOJiM2rc96xqGvCh6Pl9F7Lgd8wOu29KdPWxevUvh0owEjY7lWZTM1vpMaC/Oc/wcf8jabQwVOVzdx0XWZVteMn/TxOgtS/pJQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63fb260-d3e1-4d5c-fda2-08def76dfac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:26.3267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PylDj+lsGNqS9s1TfL8CbD4ippBvBCvkBriDIJuCPgeSO+stLgpLWHQvfjkNi8bkRyKBhtRSNHE/bixyYpbRUCmloax/0tbXN0Uw94rdlzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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

Introduce the GCM cipher mode so authenticated encryption can be built=0A=
on top of the existing qcrypto_cipher API. GCM is an IV-based mode, so=0A=
register it in mode_need_iv. No backend advertises it yet, so it stays=0A=
unsupported until a backend and the AAD/tag helpers are added in the=0A=
following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
---=0A=
 qapi/crypto.json | 4 +++-=0A=
 crypto/cipher.c  | 1 +=0A=
 2 files changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/qapi/crypto.json b/qapi/crypto.json=0A=
index 2b55befef9..6e3a98ff68 100644=0A=
--- a/qapi/crypto.json=0A=
+++ b/qapi/crypto.json=0A=
@@ -121,10 +121,12 @@=0A=
 #=0A=
 # @ctr: Counter (Since 2.8)=0A=
 #=0A=
+# @gcm: Galois/Counter Mode (Since 11.2)=0A=
+#=0A=
 # Since: 2.6=0A=
 ##=0A=
 { 'enum': 'QCryptoCipherMode',=0A=
-  'data': ['ecb', 'cbc', 'xts', 'ctr']}=0A=
+  'data': ['ecb', 'cbc', 'xts', 'ctr', 'gcm']}=0A=
 =0A=
 ##=0A=
 # @QCryptoIVGenAlgo:=0A=
diff --git a/crypto/cipher.c b/crypto/cipher.c=0A=
index 229710f76b..64c2339d17 100644=0A=
--- a/crypto/cipher.c=0A=
+++ b/crypto/cipher.c=0A=
@@ -66,6 +66,7 @@ static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] =
=3D {=0A=
     [QCRYPTO_CIPHER_MODE_CBC] =3D true,=0A=
     [QCRYPTO_CIPHER_MODE_XTS] =3D true,=0A=
     [QCRYPTO_CIPHER_MODE_CTR] =3D true,=0A=
+    [QCRYPTO_CIPHER_MODE_GCM] =3D true,=0A=
 };=0A=
 =0A=
 =0A=
-- =0A=
2.43.0=0A=

