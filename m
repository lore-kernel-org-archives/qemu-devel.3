Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B12BC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2E-0001ik-61; Tue, 18 Aug 2026 05:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2C-0001iJ-6n; Tue, 18 Aug 2026 05:23:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2A-0001Yk-Lx; Tue, 18 Aug 2026 05:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTyjN8ErNs1bdOYBdQQU5Se2pESc9kvwjhQEmal+45Du0dyJn2l962RnOhCaOqNR4DH7sclgQfkmlWwYL3BKQrEqyRYzMnqz5tbLWQQowH6jPYysATUkEAGfQfN7n4ylLZgq7f3dmCY/Mps/0n3L/dvfZjH15RX6wLdjz342axiJdIw3HGGRdFujndPzRzuXXb4fzyCvzY26vun9MQ9MkUx6FPM5Uuqh45fu76h5bZif/I9zZHVk6YjaiRJ6Fo4zaAAWsSzDtm/Ql5+5Ftw3baCESGZji4fLUILCKqUf/LvEpJZBe6aerc4+9zjChe0wVtHKK/eCsRmAyWT3jOK0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLJ1M1EFhz2scnyTGnFPXkT2wurmb80ItIxChGlL0xY=;
 b=TSCaKDDNqrVoPrNy8oA9uVr3sfSiKueVtpUoYcZsfTYAXBP9bqVsbDBvffT1+SZbtercaV0C3kFkXfWDvRUTO/r+OK/4SeutdeH9gNTUTye0cxEfYA4R9qgaADpbhTfksf1BvOeHHF15iSmdBZxaB0xJoAOpKmbzrUMngNm77MRM02mVhII2xoOVXFA3p3fLB9prfEaxaThGeDT15zDBYAkKrPvQGWDNjglwlTUzJpmcmSgCumKjnUhkXJf9dlqcUzTkka3JiAhW4wg+MvPiO45V5o4oz1dyX7aCyq8SYtkDAjnZkipf9cNAy6/2mxDoLxgE2c4TnOJHnGDLSmJA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLJ1M1EFhz2scnyTGnFPXkT2wurmb80ItIxChGlL0xY=;
 b=BShuSEeBWbXdkOO5w4UZ1+65A9fjgJNBndEDqm1YPPdNVqD38vfBP0qljEt7dKRLZQyk4Ra/6zd+CTYLqOxf4FVbr1WqD44hRJcLZt8N3JxCxsXaBav2iFBWmVZhSFJOpMlhyWueisUkhLv2UYwkuqB5Jw4SoHGlqQq1YnilMUbHifAvGRPQT118GtmX6jrpNfv5frIX4pfnn1k6v0yt2p8c88M/BzLY/7Q4MsW4z321WUNhr2bOEMFQAdWs9m3IYThIZG3Ho5A8E2XhCq4JKxWQsxX5FN7cYiDMLACAJZPg+9XJ5uSjy+XdXV/NMPW9C/+k3N9TYTVjQUQlJQpFqg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:22:54 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:22:53 +0000
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
Subject: [PATCH v1 1/8] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Topic: [PATCH v1 1/8] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Index: AQHdLvMlLO0xzXFb20GZfwuaSkpR/g==
Date: Tue, 18 Aug 2026 09:22:53 +0000
Message-ID: <20260818092249.602137-2-jamin_lin@aspeedtech.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: 6418c7e5-65af-4789-19a5-08defd0a4845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: 3097mTKBk+JCnVaLXQzeCZPXtrgHOsIgqP2ZCHzSAUnV3IIW9wrtxxoaRM2wAaEQTzP2Ekq2+CK+XHiwk96xYBAIY/h/TtOwXOKQWo/sX3Gke3F3ljVy+AJS8YrKywgkGRQ4GSgdTze8C0Lm2bsl2+W2futTgRueuVfX+4AJOoYGp71T+1C2iBh+05qu9TuT+L0LULsEW1aTJjsiOnywvuKlAskz3XwLWQo15TRCxaWiIriPBK5QI+zmbcMOxe1ep0FffL0XYm+DUHrS/3JjKHXSkO9InHDjLE6xq2ZFx51oxaPpqo1RLaDHY1+kVbbzqN0+gYHnlPPpwTYL+Ccod6i6y796DBjAHNbyGkJhY5tiMRx9qMs/EWhFSyMqHa74/Szvrre62DqAnYey7VMY/Lye9tdZisTfZuawYgoYsIxXve/80Mt4KyEgs93g3XzT0Zv2GHECMRoQtkL2SHJvTgRnK3QJTyoLvYC2epdxjuBkmT3GvCnYclB2ay2QByKJGacC2lntXScKRpARRPgxHW9NeW8AeW0cqIv6t5z9muYX2L+OFXZ7jTOA+4s3nPNmgVWp4jxJRtuQS/xvGMqYkUHWq+vv9HA9kgZlPX8L4RRAZRABJoT2Ip+zuMUShzthQ4BpXsmul9GpyP5KnKmHpFNhnL9BXxyy5iJbRnKS8SbGso1cz91FhnLWKDxUSC+IvdpHo72HBCo4y0b4GlAImXg+vErGjQU0WmiCYMKejB1M8IHpWzJmKT6xUn+Tozqj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+hqu5hZFpqR/13ZC/wYzF2XPONtHMMW2WD3Mz7JXapX8xq2li7THUDw+UI?=
 =?iso-8859-1?Q?gLj48BXjRTb793YZhu5xGA/wAwO98wQsbEEBWJPHeLFH8Bo8zbXItelV2r?=
 =?iso-8859-1?Q?ahhF9knfAUUR/46muNrufO8L6sRM29nEvFUw8XU43/dAcsFidyhLDxC6zp?=
 =?iso-8859-1?Q?WpKN/ub6lNACB7z676frRDWRpGFl3ynkEhXzKK5zpTbgIiNgn1RMq4HQAu?=
 =?iso-8859-1?Q?jSugDDetjRmzJMBVDkWfLkVC40q+gx7oMTHqrSHQTDGkoBn0a9NYPem2n4?=
 =?iso-8859-1?Q?ule4S3uehIj1MbkR/gpzi/JCr8YcT8l92GQuDfpEjWCKnmQyiuL7+hFPPh?=
 =?iso-8859-1?Q?1ob7pri7TAYksCXvCOL8V94TdF9Xfn1EyX9kEjzCPAqhVF1axOiZ/bDQlM?=
 =?iso-8859-1?Q?GOoQBTad//tHFnCZsHnpvRmRMYpvLt/j8pG97T4u0zEBL+cKemdN1XEWQl?=
 =?iso-8859-1?Q?jWqQ7D/p+1sS7ozeN1HLZx05w4s+09pW0NEij1gc+XqnlGbyxfGCNB1PHw?=
 =?iso-8859-1?Q?QKFpipftkGQeZ7/eBgUDqDsbzYb2+prKeN/c6eNoENq+mGbQOkxLFJcbPq?=
 =?iso-8859-1?Q?JLKvuY3V4EtGpolVXPftiNowAVEXCEWjbReBjaQV0KV+oZYvzv5kFA200O?=
 =?iso-8859-1?Q?psLkUgfjqG9+I887jaz/vt1lqqrUmIopZCPqazFwY9IuPsAu+wqtO899eq?=
 =?iso-8859-1?Q?ZtCOrVWWSxVavJxa/eQWuiZ/zowq+oaBmm0MLYbagpZj8pABpgzhk4qNHm?=
 =?iso-8859-1?Q?+Sppe/laG8+HNYc/03HMGOSD6/uLrV6Yn9LdhNPif8kHhgx/SDImAbzP3D?=
 =?iso-8859-1?Q?qaTHALc5XxW/RwO/0R5n9NU4vVpGSO4dULKGuJSKwiy2o0mY7XvgwMXFG8?=
 =?iso-8859-1?Q?T+XvheGkIJPI0qFvyG0N4yGSWUChBlj6aoWK7GxH/k+DjepXyiqfIIbWTN?=
 =?iso-8859-1?Q?T8PPqt/B5vq/R0dXK3NFoXvXF8XWcctx4lKyASstXeeBJ2Ru1UKTQe0cGZ?=
 =?iso-8859-1?Q?siutyNNUh00jVp6O3E9unmKw+K5XeOfNyuGiyAm2vGTEb4iNI63uwElIkq?=
 =?iso-8859-1?Q?f1binhsIjoxneWDm61OlOBLNNbgnfkQ8kfCtJAF42SxKUUBagjpRd8yVmh?=
 =?iso-8859-1?Q?nipU6DX8bv3eY8qDod8kpJaXUcRrcNlmBdzxsXLI2rdXJeX01V/qnefWFF?=
 =?iso-8859-1?Q?/9wJN6p1OIx9pJ83vpcJtWZf7pG6j3jCldN9wEnnL0WuAJoZhNmmyzUaGf?=
 =?iso-8859-1?Q?IA2fLQk/OQmu4iZsWlqrn7JWCT9DT7f9F48dwU3AAlHfDNnYEVRykNYM/x?=
 =?iso-8859-1?Q?xO3tzQ9rrnOXT/Vwba125P6VK0vCRVdull1BWMRW8RQBI+XJOkf0Yc/oA5?=
 =?iso-8859-1?Q?FMW3rvEWoCMs4TB28FhwMqPyPB8UXKDq1T3ia2qfcFMf/FvMvRvjhJQTWp?=
 =?iso-8859-1?Q?mp7hlyTAXGoZdPFJb1NE4d9zHuBTDZdRBFyKQGCKjnIk53kYEWNmB8HGGO?=
 =?iso-8859-1?Q?J269jIlxogYa1jqYjaS+dpY2tDeu+JDTF5PZJfvzL/U96zl30+zvhFlyws?=
 =?iso-8859-1?Q?9SrO/2sQM00XqjSv+vWXskUgFCIQutT/IatRvXSVPJBbDMHcZEtlG/xPt6?=
 =?iso-8859-1?Q?p4/u4wjZusKeQNm6E7s2K2Ph/lMj8hojI09rjH/iQU1rMhmNKYMGUTymsc?=
 =?iso-8859-1?Q?s36kpfxDTUJdTnGZQhdSvYIveGNQ6jwHg58lOGtSKao46wKQo31yJCD2K6?=
 =?iso-8859-1?Q?oVAqbSkgO35IMtBn517meOWmoeNybAAmC/GcffebcvSExM4kLQOnQK8eJS?=
 =?iso-8859-1?Q?7ah7f6/57g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GPpZl8ZQSRTJxEmXki+SnPbHiiZXTovfUvYdKhMaCCnc+t9t7CAdktXHYPw/yA3A6kFnGDK6OPG0/zrUlXncryanJf7eyEhXP5+0cDQV8jkApe9xSr83cNCLlbLcTOkamEofUmnxVRIxDyq0CYIirh/uaV5KVBJ16iUBG0aGhIGQ3zkcKD2UMgleAWRjPp0yJ9XLBT5F1C2++TterTK9IS79hmgxRl6WMECAJdOeg0auilwvOL4rfXkbum50Y6GRLiQScgra5NuE1a6XdLFKRisQIiDJJeoY54ybUASQwZftVFaIcggD9yfKcjQ/5ByQ4yqHuTCM2CAIEOXyLzAOig==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6418c7e5-65af-4789-19a5-08defd0a4845
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:22:53.6350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfqDL0HOrSb0Jjnr08epRKC+HelXC+ATFeQ4xAzMyqvcW7nTF5OTqvkwvlsHrgJybwEggJ4vsSktC0+0Xb2n5HAJyknK7OZK1ihkkwaHLIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

Introduce a new asymmetric cipher algorithm, ECDSA, a curve identifier=0A=
enum (prime256v1 / NIST P-256 and secp384r1 / NIST P-384) and the=0A=
per-algorithm ECDSA options. This is the QAPI groundwork consumed by the=0A=
crypto akcipher backends in the following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 qapi/crypto.json | 33 +++++++++++++++++++++++++++++++--=0A=
 1 file changed, 31 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/qapi/crypto.json b/qapi/crypto.json=0A=
index 6e3a98ff68..016d7c65bf 100644=0A=
--- a/qapi/crypto.json=0A=
+++ b/qapi/crypto.json=0A=
@@ -557,10 +557,26 @@=0A=
 #=0A=
 # @rsa: RSA algorithm=0A=
 #=0A=
+# @ecdsa: ECDSA algorithm=0A=
+#=0A=
 # Since: 7.1=0A=
 ##=0A=
 { 'enum': 'QCryptoAkCipherAlgo',=0A=
-  'data': ['rsa']}=0A=
+  'data': ['rsa', 'ecdsa']}=0A=
+=0A=
+##=0A=
+# @QCryptoCurveID:=0A=
+#=0A=
+# The supported elliptic curves.=0A=
+#=0A=
+# @prime256v1: NIST P-256 curve (prime256v1)=0A=
+#=0A=
+# @secp384r1: NIST P-384 curve (secp384r1)=0A=
+#=0A=
+# Since: 11.2=0A=
+##=0A=
+{ 'enum': 'QCryptoCurveID',=0A=
+  'data': ['prime256v1', 'secp384r1']}=0A=
 =0A=
 ##=0A=
 # @QCryptoAkCipherKeyType:=0A=
@@ -605,6 +621,18 @@=0A=
   'data': { 'hash-alg':'QCryptoHashAlgo',=0A=
             'padding-alg': 'QCryptoRSAPaddingAlgo'}}=0A=
 =0A=
+##=0A=
+# @QCryptoAkCipherOptionsECDSA:=0A=
+#=0A=
+# Specific parameters for the ECDSA algorithm.=0A=
+#=0A=
+# @curve-id: the elliptic curve to use=0A=
+#=0A=
+# Since: 11.2=0A=
+##=0A=
+{ 'struct': 'QCryptoAkCipherOptionsECDSA',=0A=
+  'data': { 'curve-id': 'QCryptoCurveID' }}=0A=
+=0A=
 ##=0A=
 # @QCryptoAkCipherOptions:=0A=
 #=0A=
@@ -618,4 +646,5 @@=0A=
 { 'union': 'QCryptoAkCipherOptions',=0A=
   'base': { 'alg': 'QCryptoAkCipherAlgo' },=0A=
   'discriminator': 'alg',=0A=
-  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}=0A=
+  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA',=0A=
+            'ecdsa': 'QCryptoAkCipherOptionsECDSA' }}=0A=
-- =0A=
2.53.0=0A=

