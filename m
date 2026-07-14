Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15E6C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXa4-0005qJ-Ha; Tue, 14 Jul 2026 03:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa3-0005pL-2a; Tue, 14 Jul 2026 03:29:27 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa1-0006VZ-LG; Tue, 14 Jul 2026 03:29:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uipKwP1iwpLJd7Nbv2Q4u1MWLK8s23jm+8pKADkoZHGSeDJOkv/Hw9BomPEGmTc3JOcG7XdHIK8OHVlcOOM03AxWGuVFD/JNn48O/MWYoXTAdmVWAFRncPXamFMFqkaLp4ZM0NUWOgs0gsLXLw+T/VImA7nw1wJ/g1bIUioIdBgae0JYslOQRx+2Er7tWiqjwhSoyksWD9zuRJtF8HRFPkUDfR/t7lLcFOpEnkyja2GU3sVUCqr2sb8WKldidov/wRmekgAbTIn+iHtWwSijn1ewJHZQPiJw400o6ZgEjksjEyX2SWEppd7ruEm51yJqnd37AgYtjEvk+w8eKGvLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPiU3JkWJB0Wa9KOKojTt0wI6nR0DW9xq29NUJuEaTc=;
 b=O0BU4tCmD7etdgW3OO/YzbRoArrqR8T6wnLx5YuS4ll/HWzCR8DDXfj3mHgQm82VXcbtvkut6ZJ6pe6LL9zNsNey43MLSoE/iZEzZCUtCqg/au8Kmtv16Hp5aOKZT8YQJXuvQ8KJa+4qhQlVjNOu8oQ36to15T3xq9UxwNGGrnQNK0VyITu01KDG+XTYkXJLhcFDxkjza0WFh9qcd881Wyt3BD/oaWB/0x5djGXPluaUrhGk7hKTpLEmTB7HcPtBFdNp/kZHZVvSnPG6b4WegpzA5/6aeYUKut3hQXo5F7JMN6QAv9cSiEn94DhR1kvk4VD7xHuSLZCztNvPQJ+GEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPiU3JkWJB0Wa9KOKojTt0wI6nR0DW9xq29NUJuEaTc=;
 b=F9MgA36obOzg0jmqRLXTcR2tosJppsWjHgsyC6Fk2ymk1GR8vufD61wVIX/5DEZZjpvjemKRv/GTjvfqHkJhhrInP2QRYSxsZ2WbAsJ1WZNfNDBmk1jTP4toq2oyeziC/GEWbsceXyrzV7BHxFaP5aAIc23WixJx2MfvyqHffRG53IbFFbXKJLCfPSi8fj8rsnv9Cym0lMX7VqH3LRVkTJT1CBR6I1eaMvBfOPuFyfbHlfsXCT1RClajUwiTWz8ossrenQb3cyj7yo0cNbbPT4a6pVNI4tkKxtB+9V2vp7itwi9eos82+RoAMeUcY9xwm0J8C9y4/qY3tE+pheAqEw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:13 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:12 +0000
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
Subject: [PATCH v1 07/15] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Topic: [PATCH v1 07/15] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Index: AQHdE2J3rBhk6fqDUE+nrdUltkk9Xg==
Date: Tue, 14 Jul 2026 07:29:11 +0000
Message-ID: <20260714072900.3023742-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 80854359-1ecd-461e-19a3-08dee17999ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: GU9BsZyoA6lbYyo/AxMf9NjnyH3oXArQBJQ5xWNpeBcVmM8Yb94RMoQB1ojjl+B5azwuBa1zAkIIB9ULZgXqIDJIjX6SVEbH7JP3OOzyYZTI9Nwx4NAqbFPn4wZ7PPjJyPRO8x0dYAaG9pGxTWpN9sPNiBDefdsyYMI+MTXuE2IJzQsAjj3bTX81/x1s0n+8K9kY6Sn7JEtKNjyjq0wX/o094xFw2mqS7wF8ZQEazLx0/YxUxfu6mYDCH/zdKBX7lkYHcAtZqcByAYCSRRpyXi5dzEMbCzoAfHjrMAGYDJ+gKJHRxlYsLI86gUCu7R0C8/z+F2QNq+mubnRnfpD72DiqIRUIVxEfCzg4UI2V0m2MnPVGHR4BSSkAgm4JNsO39qAcNjrY0HQcD5KSHBt19Pbv08OS0nzPnqgspSo7GPeZ9XJvw+bRSXKfu+u2kGPRN8HWCW0WhkeMvBb2WYBBN57pPZxuleXL6M/daIN2sP7T/AfAlXJIX0xQR1fd1KjZTXjP/nPMUu7mWVfXpW4G0hDsTzEIkYAPYuKRC2u/hM8hQPwbwdk98Eyq8d5VI6hw07JubsdjsYFfdAk7bwedKtByG7YhUrqt2RS6ZsffAckbso6K+Y3WlGsCK9srdKSD45mHHuIFSlahqEZTN1Z31dDKThtQyaPcbhTQNMbf+TeSn7IR9ruoC16vPPgVNSPZPZHF1zmnM23AMpmv5wsFuDt+hlSD9NwrGESQGumLzjnI/91wEcyVePDvxTR6cg7+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yUgVIoYCCOWuBHQ6J22ryOvK/BS38gmYlGG216LUUdsIISvD9sJuSADvyh?=
 =?iso-8859-1?Q?AzcAFbLTim/Qn+UrymDUzIicAEbeu7drL9zMBFqHzl+dFvZX40bmmn8Zxc?=
 =?iso-8859-1?Q?7XfhVnlRRKF06QsE7kMcTMlYz697x/t3KnGJLhOKDc6a3k9gxedqy1rSDO?=
 =?iso-8859-1?Q?1NzKOA/k3X6h8FHvPqGLXw8hBDjVa/RgdUSrX6kVNzJHBYx0YI8QN58EA/?=
 =?iso-8859-1?Q?E4K1BSFJibomhdEyXqM1ymfTSlj2SmliMcKAgw362JGcmnkCOewFpab2xV?=
 =?iso-8859-1?Q?GOvBFfhvg5I/TPqOgnfHKuErVyJ8u5IKgoUaVYRdNE+cEyor2CfpVjeWNo?=
 =?iso-8859-1?Q?6zC+Taf6NDencla95oCwIdVa+5UbEOLM7vOVQq8/eau6PSduGjQ0btP3PV?=
 =?iso-8859-1?Q?KB91oeopQpS4msbIgtql/1VzEfSwOMNAeVS/8+Jen7GgobMN9xIYd2ROTQ?=
 =?iso-8859-1?Q?E8vTYaWXDh11af/N2K4ealoSUaUzQrxS5YMQ1pDNJSllbUrMPQWivE/0If?=
 =?iso-8859-1?Q?x65DAG7T7Oj25Gjk2k+7rH1DaToq0qSbbDfVThxPYVqzwJICbt5atJF2J1?=
 =?iso-8859-1?Q?bKqMU3Fpzv48jOSq7srLtxHccZkOVtzJtqVxvM9ihSqrPBTER1csDIIWjl?=
 =?iso-8859-1?Q?faetMxUpTg3l4Z2RzNXVf8HOxOXKziSAK4wgZUNsLyoTXv3OZiBYlJHODt?=
 =?iso-8859-1?Q?BF/eOuFqCQYiCjJ4jaeJF9Dg31RJyzsOrQbfev1dNAaGg8PHZcXB0o3qvr?=
 =?iso-8859-1?Q?iYr9IWIbWNOHDNrPrMQ5f7tBJz8wU78AQMPVmE6libgGCM4zWlviWXVufZ?=
 =?iso-8859-1?Q?CEbB4uwPS3mEYOLZPg2yrP2jI6/zOHGMKrRyGJUkhhnV8E/GagLYQBJkhv?=
 =?iso-8859-1?Q?kA+cuzNdg7YsZt6uvw2lRdzuKYHQjNWvW6ahQx3f5adSmjFXBh2WgOYHXU?=
 =?iso-8859-1?Q?gQNoNxPOhYEBwJeCnYWjaXuPq9VBGcbau5GrDAFXJWqsRn6FtMqAKfn0sP?=
 =?iso-8859-1?Q?Pd1A/l0ZRXwugAfVegMxDCqaPRpY6JPhhUJsoUxsGoMoBW20Zquqeap5fI?=
 =?iso-8859-1?Q?MUpjgsWUnpx3kEjASk6pznmz3pdSKPoVzCDUZ1718MIDScOsFbQviWilZI?=
 =?iso-8859-1?Q?JYqK5IMBhNwqRFESugD3zlmsrRQ2YrhVGFLVhvjmP6gs+acp8xFZeGq4XV?=
 =?iso-8859-1?Q?+DGxx88tVJIMsSfLdoJOfXM7GIO4dWrIII2bbEGMdgff10zv99l0cZE/dF?=
 =?iso-8859-1?Q?nD9L23DkdCJLh4Q03NdLdpzbugA96Pluwk/x8llC+R5dP8fjJ6o1jAl9dn?=
 =?iso-8859-1?Q?IvFpqzbV5/Qv4tFG25eIIUZaVKmZaS3trxN2y2/9DACwy5QD/imdH4Ie47?=
 =?iso-8859-1?Q?kIYilq6KHf4gyt++vkBGH+jeVSc1LtJRlrJEloPj5Gc3xJDgyZWm7f+ZNu?=
 =?iso-8859-1?Q?X2ByUKCj3RFSO3Uf/YJ8euo38FupEf/flhIl4TLCUklFKqdpBEK3BM+Sh8?=
 =?iso-8859-1?Q?Ify9VAjDY1p8Dan1kxiuqevY8FwBIfurlNKI9nV+NpRSq906lpYT9h6Snh?=
 =?iso-8859-1?Q?0FRSe65gC6ByU3o3aMUxL0iyIffymYvGz4I0j//028dwuQNe6EEJ67aMcZ?=
 =?iso-8859-1?Q?WJqWjGFGo2C+DBpko+jfuBEcrBFA5J5mpC+zt/j9w21VZv+1Y5GaUUJpTd?=
 =?iso-8859-1?Q?ZC1674EF5EnQVmlomybLeQk2dgme/GMXXOBXPbFsWY48KAjYnWCKGtaVge?=
 =?iso-8859-1?Q?kaXEHaJlIckrP1hkoUlP4C+6pvt6lKBramAnWvhhkjBTUZyZ/17CtfNF28?=
 =?iso-8859-1?Q?SnpBidvMWQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KrozS9XkYWhxoskfQooPB2/wzhiuCtk7QZo+MRhJdKor7tNxBtqzl5aJiW1ueGS+HmyGO4t8/5EH6O3DxLI1BvkXwdZXVPDW/7blt3qN79H0yjZKDtWcXeu7xHIxpGSS5QBtHgRxJ/QN+yoS1tKHAu+1aTiNOCIazvSVSMy2s2K09P/nwz+papnTZR0wI/kE+JtON23qxE/oe/f9GKbJiaBcQI9ldWx/GcZIHM1d2EKU9aCVCV8sSrowDsWcsWu8hJgaO5E3x6mL3UzQ3c7WHy8OyjfUmQkhGpj43cvTVfXeVNAf5MIhU4qSISVVGY9EgDoQmemAXBBai7TMr9P20g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80854359-1ecd-461e-19a3-08dee17999ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:11.8962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvJ0cNddagSTX1Md7hLCQSSo9rR3OWwO5S2IeSqqOvNizkuEuCdVKaHx1rHcczLAjQaEMKd2lclw7bZza92TS3f8pvA1Nsc5bLZerVohYq4=
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

Introduce the GCM cipher mode so authenticated encryption can be built=0A=
on top of the existing qcrypto_cipher API. GCM is an IV-based mode, so=0A=
register it in mode_need_iv. No backend advertises it yet, so it stays=0A=
unsupported until a backend and the AAD/tag helpers are added in the=0A=
following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
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
index 515165e0dc..52d071a90c 100644=0A=
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

