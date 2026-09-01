Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB19CC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEo-0003oX-9D; Tue, 01 Sep 2026 04:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEg-0003jp-V9; Tue, 01 Sep 2026 04:52:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEf-0007Il-EF; Tue, 01 Sep 2026 04:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/aYqIQpsAUibyxH35i5yKhbYKSI7bB8XtjzX/QYb7CPxxBHhiTxAozVwRqaLxFC+V9Scozd3CK6Kttz1UIuETZ3tMOhw+1twsOUyPcC2aGjIHk6Vf+E/ir5eLaEtrY02CipDxMBnMr2MGeAevDvXc+hdgZQn5BW7ilIbf34vKWvIYzFJg2V6/8yXt3NHLMk9mbCKI1mnXh4TGYEF0M7v6/OyFytu80jzITXRhCU8DWkFuRRPdhxaYoubZD2EkCFsR7ARSIGbSS7O0pPmdBIySvcxxjsWYXpOJC2UKtbIn99c/s0VJN9hEPLqVHiyIw5lYcjK3vIe4f/9pRb3jc5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWP2WCxZg2x7I6hZDy/TQJCYMPMstHxv8wsqtMGXNmE=;
 b=hyVTlZVlTeWgT5066FFyvUjuwfk259Um/Y2vWbAAWgeP4X3HT81TcQLJovfgyE96rvDInB+VBRon3VOgpD+eI3oyMOF6BocM9xk9/MBUyBJhftUJmcROBEvqRDZJJSElLIEq9XDujTN3iNQQ83wMcUf0qPUUOW44MNpBZd/lJQuXK/eYAIK6eAJl8LJkZqTef+Vc/0KFDmx0fqBj1syOdSDyIoro8GcWFd4NrzEM3ajD9FIvvKLUQGdR6HUkllKne24UTJOo08sr5c7VPpVBJJqnfbnAXQ/cTpVZ/3rlPIK8NSzxwHrxba8hOGSD8AQ4tz9z0BBUqHYFfJLUyqDDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWP2WCxZg2x7I6hZDy/TQJCYMPMstHxv8wsqtMGXNmE=;
 b=AgRqVmDI8S2NYYm3gOe6n0idJXIoJlB9LzGXpe0B8VI9xStz4xs0qA9MvPJ8cocF5QZeRESaLCB8sauyoylwGLctIZgXhwLcrFEbClDfAC6mp7omDaO9N3sIf15Bfui7YVyjSYTVSQroWlVZyaoMt0EHeyULf3Y8Zh4Asimxnstdr7eWdqui9aGrBQ+IKS/K8EGoS4YBgVpsu8514WmDzCDiDZ/6VzL4PM7aCc+t255m4N608ppFRwUmb66403tpyCxGq9VVFhxPlYQWNu6uAFcV3Oaa7DEeHbZweuT3+pGKLNv9ACCni/gkqIOdYqgHYIojvpaaz1SYcJU5QRUTwA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:52:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:40 +0000
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
Subject: [PATCH v4 1/9] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Topic: [PATCH v4 1/9] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Index: AQHdOe8+9Ii00L5nyESaes/GCAu5hQ==
Date: Tue, 1 Sep 2026 08:52:40 +0000
Message-ID: <20260901085238.995968-2-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6871:EE_
x-ms-office365-filtering-correlation-id: 21ebaccd-65f5-4b11-d5e6-08df08066119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|3023799007|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: cxiEvHX+IjHuL+x6qQf1eloI4IRmv5AeU4cIKvjg+EQWAq/Xxh3eWJmgoTR50kg3TnaJIg2Irk+F6gO4L/VBurME1DTWhP7y16TZrNtU4SdA/SlnRfjh8lzf/CYVlZ0nMvUvB2PEACH3mOSQkYdnmaTTq3czLpbFCp6eSWvjcwZBcfmv5+SglBkUz2H7rfQMcWE3Czc2fbavNZqe1sAxStKU6X939skPr27wehmyyOlT4OWlhQ7XF+eh0vQx4hcM/Py5oTFlg1OvJvhkDQJBj3+QxZfcN3H9969HoC60PfLVBMMNEDW8w0xcXUnqourRpxPr+B5DUttsL/iyZXRq/E04VAxVBNPsy4tI7lWsLsiZ7XN01eN3qvfDGVcpcOgMFs36hGrg6W1sXtmxOWXXywj0xFKFDrv01r0dvT6lvcFlumeVpfznovXE0ygtTfx5PnIzVhVKXp3pibBeiqzDUCz+sW3EWCebWbZPZPPr3bIQv3gqQd5SmNe6XfdnR694hsgiuwz1nKhf3y7T45qPIgUcGq+w/GQWoppNi9IW04pyj4cBorfWIxOJPgjYl+idI1jLcOlwL0Mg3XL+o2pC0gv9JokXd3Nack+QaNJo3BOAuX7GGZJ60zhWzARqdwmKr2RkI0csADkKI7mlmS0m2QUKF8F4hqS41UtMf4yJiExgRHgg3QSeNTXfRpil0QJGtsqkGe3JumG9ksQdHQjLVlbWd/M0qJuXgY6F9n8Zx0iLFz1Uv0mhBWr/7nggaLFW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aIBsU5PPWADTdwPd8xiwJLronPfralnUBXop8dJtbwn1GiULlazRGkKfca?=
 =?iso-8859-1?Q?YykUOL88vQMcDQAMcQIjQIkQIa8ByEyKE9VKvjV2sbBvI8pEPTgLUmw4+5?=
 =?iso-8859-1?Q?CDeyw90g0HKbBRZe9I8cR+6XsuaeW2SdOKBEWCyNwFx7QZJ2hw/rBwSPsh?=
 =?iso-8859-1?Q?hnd5JPHUAGO470TVxzZEOiLRKs9Lz7vUp0gMx+OysmmB3Q/nzQUOnxFWlh?=
 =?iso-8859-1?Q?/yoM+xovSzh3Ddlh1SlvdBj7x+coO9dm4PJWJ0zhOTq7jnjz8rHzJSJ+iC?=
 =?iso-8859-1?Q?bNli+z5Boh+5M60H/30F5LQGcR5raoPV2Uj7/c0avqZFWr0M4cmWmxI8zN?=
 =?iso-8859-1?Q?lLYwuGOTTvvcWm2B6rDbHmgsQiXfxOrLh6lZNNH2RoxIarxPHY3YXDXi3e?=
 =?iso-8859-1?Q?GEsVcJHvECxhhDxrCd821oi7nuH1daQ5A4PftDWfBhsLW+I/6hEMjGxq4a?=
 =?iso-8859-1?Q?85IoEykF7nMtmxgl8zJRmB3X6W93BHIhvavTzf9I9b06w+cEPJYLLbU03r?=
 =?iso-8859-1?Q?p7Wy9sSAWwP9gmR7lYmSamFkCLHVR4dhLgd8GAqqEuoCgu7/gRASCoIbJx?=
 =?iso-8859-1?Q?FNt767WCFwPDiOmv8bUVdnYazXRYtKp6FjTCnbvVkSMKphaaJu/v2AwtnG?=
 =?iso-8859-1?Q?3QE6tbzF2a6J6c3ccMltTG7ZhlZSAQtLkX6g4TTs1pVw4Opu/KKKLzXiO3?=
 =?iso-8859-1?Q?cft5r0qGj8DuZ4Rt/LXy5S6F+EGXdFSY3eetWDKfn8x+DWFOna6DlHZWNJ?=
 =?iso-8859-1?Q?groU6LysyqXAM9dOQt8xDR0v2SKlHRJQfZ70aq76Ll1EnOWEefUzDbojfw?=
 =?iso-8859-1?Q?A/bwZ4LFNwQ3pfFGCOYmbRc+nhi9JWfDQHCOKbq6OC4eCCDM23hU3TE+4Z?=
 =?iso-8859-1?Q?lzKnO3ZU2CFSmSZzx6ycQsOnyy4ml8c0SzaopMJ+l/4kLcA0hQnzw+3dmr?=
 =?iso-8859-1?Q?mqVUW7rb0xDFhsOdlqooF3h9cSA9diu5cU1L6K+w5/vhKHCOljzVtyj/ct?=
 =?iso-8859-1?Q?sFf64Q5j3UgTV26OUy1L97afbkNLy04qtTqn/Lvg+z3oZOuaLde+wCwECO?=
 =?iso-8859-1?Q?iizyJnQDXYwaVbquKGJ3Rp5Ky0s1NHHYHT8z9Nj31DjjHMOEdYUx5W6PJr?=
 =?iso-8859-1?Q?9j20jHt1r4lGpYnrN4vmzHnmo+e12lTKCpmwTVAv/Jd65brcwsvIC1hh/O?=
 =?iso-8859-1?Q?Mz6T6ObjnXGXp9ACYPzZ7B7yg8C+R+0/H0PJXsaZ9IY+5JQZvpFXCEGyJq?=
 =?iso-8859-1?Q?8R57+gAQkY/wFyMor6XORBrGRBiATD3AXsgs48y6EXNfQvNo9BwuxV4FwG?=
 =?iso-8859-1?Q?Mu0EpEIrkFsZy4d83Vgbwq9MYBeMqUFbRmFy3JN4khIwCcD34xSyQZLwKJ?=
 =?iso-8859-1?Q?kMqd8RGEeXQtUjm4sVxfW9+91jOi7StJhXN5d/+dhR1BwbDrm4niD30KrA?=
 =?iso-8859-1?Q?jPCyUDSQlmHT4WEQCNuoXUF4uglpVDMnCWPPTmkkxo6RcSOls4KFTaxcWU?=
 =?iso-8859-1?Q?AtlM4rsU9KBNh3n9brgTlEExTfGRqwBBE8cV03+Le9A4gACOLPTLjWM/W3?=
 =?iso-8859-1?Q?MLON47P8dIaOHZq1psq00N63rD6vFFZIM8byNF77DmJH49vcRGr5QCihLZ?=
 =?iso-8859-1?Q?5bTulqCRBjSpmZvlbWIJhViuHz1n7GhfCxrGE4J4riN2D09tBIBf6cqptz?=
 =?iso-8859-1?Q?qxkcwcV2WXfN02NKhMNCOtmUbGVTkaUpXwAKU2xyRNAkai+IK2pSWnGfJa?=
 =?iso-8859-1?Q?bnaRdM1JZQJQ5tmw5r0v8Qbp4apVmMztFfNcqRv95gdQJmy1A2U0NhvIS9?=
 =?iso-8859-1?Q?f4Z6LsohPA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1tR4xIwbL0pFrdNbqpGq9AeadTKYjw1ePA1rvLwKCofbm/O7KtEo9Rh+bqhvJY3a0QvDbFi5ImTdEGuqmR/sShkQ+Fx6vfopw0s/HCUSzinxwazQ/xytmpmNDFLSmeRzeYtGpFDBa/QhviSfSL/sQY4vXgCgCRt3QPONWVGKYmPyDh5Nr1vmowi2i4c29zm1xR5oacg11UXCfBigwsUg8eRzAMg2a6RX7Nz4379oEU3SLB20tw3qYIBTMpf3ViCV0ukMLZ3jFkJht8Iki6GO5SqOqEr49uaSuC9p1vbSTp38GvCIvvtZpAT5aWt8IbdOWowqkcAkWe3KUSmdwoKvLQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ebaccd-65f5-4b11-d5e6-08df08066119
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:40.1710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPgBv1SUKJ3mcl4PdHxc8pKpDBJ4LYIJFH64N764lZe//90hLZNqC2nI3crAKFgc+DvEMM96etBaXAogyTIYHG7Bm6PHdUr3Pkuwwmb1xOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6871
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

The ASPEED AST10x0 Secure Boot Controller has a hardware ECDSA engine=0A=
that guest firmware uses to verify secp384r1 signatures. Emulating it=0A=
requires ECDSA support in the crypto akcipher framework, which today=0A=
only implements RSA.=0A=
=0A=
Introduce a new asymmetric cipher algorithm, ECDSA, a curve identifier=0A=
enum (prime256v1 / NIST P-256 and secp384r1 / NIST P-384) and the=0A=
per-algorithm ECDSA options. This is the QAPI groundwork consumed by the=0A=
crypto akcipher backends in the following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 qapi/crypto.json | 33 +++++++++++++++++++++++++++++++--=0A=
 1 file changed, 31 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/qapi/crypto.json b/qapi/crypto.json=0A=
index 6e3a98ff68..cae2c678cb 100644=0A=
--- a/qapi/crypto.json=0A=
+++ b/qapi/crypto.json=0A=
@@ -557,10 +557,26 @@=0A=
 #=0A=
 # @rsa: RSA algorithm=0A=
 #=0A=
+# @ecdsa: ECDSA algorithm (Since 11.2)=0A=
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

