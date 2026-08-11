Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F0BC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYZ-0007R3-A9; Tue, 11 Aug 2026 02:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYW-0007OB-Bd; Tue, 11 Aug 2026 02:01:44 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYU-0002gH-Nb; Tue, 11 Aug 2026 02:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxHauYWOjamlgcpS9nPrfS3IyzGyRh0+Yu5My5Gh8i8VleBxQvUiz0OpNpDhXLbGKW0MnR4G8EefT8C4Gs7DXU/rIY5Vmi0ZWeNUFQTzSUyiyioHyjFeWrpo32LYHRZzA1w6NS+g+zyWL7qIIw5WbonpDMe80XWBg3CcVbLBnLtvqyrz57e9i/1O8PihFUZsFb4csMDqNbo+pDHyNhKwHf/h3eqwG7iy3gUa6NR4tCDi8zYIf+DuzC9PtRcycDgA9Cmf/g/D56fYC9/22W1g778Av+zGmVPzs2BRbKkzUSMAgXf9mAn0CjfEdok+FXcbMi3d7A3tW1SzZz/xfavpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVfL5dHQN1kyKBvFKQTw5SAac2NRn6v3dquzwdxZ2XU=;
 b=V7rmZsQ3MHZGvYhpwY4HI3neGUMi+7ROP5iVHy0gbLvKfvvs4IRNkx8Q6KpyNU0LJ0aOwI+4n+7shfwZ3XYJgiYxA4E1e/R6526YhBGEKS+zEyxBviMfdbZVJNaGKaUaFOz+rID9718Lu277ZJC69U54LdRTIFb/iahvTOddR/7C71qWZvDvSMyPC2En33plZ97ocrMtHVcZqAoG6VVO8s+kaLUVUtL2QX4YvztteFqHn/WUwThn1Dxt1TOWxGasFhJwV19Ye5e3uZs1LGClT/1wGyotkQqWSK/LLWmMehnGNk6Aaw2NpdMmWDpOAoZPdXXr0ZphWuJNZK6F+5OMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVfL5dHQN1kyKBvFKQTw5SAac2NRn6v3dquzwdxZ2XU=;
 b=V6sM7saYQY3S370zAA1IAX9BXa51YsLBld69oWd55mxRBgHwoM91NsTgFpnJuVqP4RFcz+CYInP8t81JrKaQoil8HenmJEC2DRW6wVNL6tbGyRp0YJiCs1YO6R8cSU/QSWd66/twCvtekMRA53nShYyC01BZTd0XL33m9WN7/knAtjLgs2vR7P4yNlzy+mZ0uUwCMXEwEvmoNNgDljvWKcoU9mpYZ2UF56AtyK9HeYTW44xOYrgnglRYXLzOp8HxP87bM2PPyhXgKH2fxb+R4wU99MDKoDaiBmB+GrrTFmNIMO20nExchpG/aOIRXEaZi14QaAgskA8wQRsqG9yJNw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5419.apcprd06.prod.outlook.com (2603:1096:400:201::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:34 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:34 +0000
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
Subject: [PATCH v4 13/16] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Topic: [PATCH v4 13/16] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Index: AQHdKVbcHY6F5qaWJUGLBwWLm9OfAA==
Date: Tue, 11 Aug 2026 06:01:34 +0000
Message-ID: <20260811060115.1849266-14-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5419:EE_
x-ms-office365-filtering-correlation-id: 434a6fb8-1759-4100-51a0-08def76dff5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|38070700021|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: LFYsEIq5u8ZPJ7SIDFG9/JEhDc6WvYoZlS9pQ0aVb3NMql78PmwLY/kqjvTkKqgaygtB82/MuV49vcJHBCPwzBQTC0kBdT+u232QZpBnWXdMUflkHg5TyiEiVR+i4MyIdjxWvLGuhs12xYml9crm1bQZ+Kx9Yu7qG4xVNeSoKAAXSKFGFQZWbFPEhXRTu8eW7hdewus0/9tIpXnA/WS0/gsyPcH6igOJfeNdDFtExo7rOAA4+Nopnpl6pGFtozFuCyt4WBFf9JJLGcl/KOTqPP2EdIrP6HYe9pq2G/5jn7SXl2s7oHJ2A0Yy8OwBjnRFKPAje7OkUly3+LhyG6imPAnqCFpcw8mCQrV0lVREp5gQLfuq9s/vTmiJ2utnDEqCM3a0vEBz/F+oQLtykoefX2uFLerh53O/tQPK7mZzwGRoM6zqwYLm7+0ps47BQs9CcDNEccsZAWc4fI3s4x+UQ4I4QAm+mdmXx+AhxEFnV3WYEI6+c5ZSyqLl06jUWDNxcutI6iRpxiqfGQEoYhSWKttIB9gw7jPWuzAqtOLkDWS3nN6SqErIkX96dKkdzctJPJrn960xs8dFmZCM6xQ7WpgwPDfubuhCX4/wyTsPqQH7bOB7a9kOh55QGgTPYMllMHOdCMSt7fEUXMC5K0VNSH7hmpDGN6v7cSe1d+2neOVXva7HFlD0B7aDSi7hQA4TGmu2xrXM5XqRbCIOCUBmvXe9suRPeAVyAIbJr9F/TsM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(38070700021)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HG6OlkY95Cq/+K0Yo62dUuZF5a+OygdKW0/i2OWjLFjrTO7QijkgJGo6IX?=
 =?iso-8859-1?Q?HKA1cMUvlBz2llXbk0gRiH2hAj3Ktj5mTiIVHlNA/eCS1bMDBGZDkXJgJn?=
 =?iso-8859-1?Q?6DSi24BtsDbI/1MJV36doVEtZrnD+rS8SoLmKYjkTP4Bi0YNr/1PvG0FlX?=
 =?iso-8859-1?Q?n4Sn4fCZHx5PFPRDzcPpt45iRg6hx9ye1iYDKZJ13F7UL3tcLZFZ4E8Hou?=
 =?iso-8859-1?Q?QFP/fl+wcvXWF++NrNRVruX9H0sFaOer58tSTN26JcdsSHkDspiHJIwWbM?=
 =?iso-8859-1?Q?mOfyG5ACwGe4s/YBcT39TtxEGt5RkxqscJk89i7izUo2DaE/Cky+m/HDus?=
 =?iso-8859-1?Q?wyqMz2AGD31LRHTS4oKkLm5IrXh/C/WtmzVpQllGGZscLNoPh/pE7F7kyN?=
 =?iso-8859-1?Q?mtNldKIlLwtE4kEtc76TeVuHNoSZdiNpSTDafAKl4iiF6bYXE9nJFZpayH?=
 =?iso-8859-1?Q?NJ4oMxISiTwwOSW3WJgB4Uf8Fr6zbWw0Otis+dtgNMtluGV5b3MRx0LHHn?=
 =?iso-8859-1?Q?/llGVTmhHLfura6KFDituO3hVK1Srmrt8/Z3rfLsjGDbaan0Kh0KvON8z6?=
 =?iso-8859-1?Q?wostjGvP9xFI3uvwnaVl9bamnwwv48c0vT8Jtm3iBWS+4SzRB926Y7YvuI?=
 =?iso-8859-1?Q?NO2i34LKygOWtlSc1/i6O0mGPePFWRunt2W3zBu0SON1NL310v8qN1Ud+w?=
 =?iso-8859-1?Q?ySnS3XHeD/5NpyYrPx8ajh36pT2/V0SxrjM+fWcL5eOCdzGO5S8N3VbCq9?=
 =?iso-8859-1?Q?WSsewH43eDprkLx0/Rtvz1JQSUCenqTTYTa/HA32kR2Fni+6/iQvodLdbs?=
 =?iso-8859-1?Q?+J1RpURmhRbDAyu6Hit4MowjJqlpqZR76kQSgVYT3Z8PQD8/tsDrxe3IYZ?=
 =?iso-8859-1?Q?sPi+Ak+R2Wh1kduHhC4/ASJ2AjHbCfl+fovMCEfTrg/MCudeX3cYJL8Lci?=
 =?iso-8859-1?Q?KXXw0n8VTzJVxDS+ZqB8vvMV9k9NyRmSWG0M+UCIoXzVQ2unWqP2ucusmj?=
 =?iso-8859-1?Q?Ltism+JKDGN3Br3pW5ZCgegvLoQ1gjB7c2OFiyjz9iRcNp3hlShzFbB+Ql?=
 =?iso-8859-1?Q?AC+4nDxO/o2670WwZ1bUnzHTvgnwkJNE1OeNqW2MIh/5c2yt/FUwhQ0lnj?=
 =?iso-8859-1?Q?G3gC2kAfAgXRiDTu8gKs45k0ptXs29egpti5vDyrNRhiV85GEAWnynpjKK?=
 =?iso-8859-1?Q?nipXcI9izFuG3aqo8z7mAWShwOgoMGsYsiGRFtWw+xHSXEE4UzlnAnf7aE?=
 =?iso-8859-1?Q?ncha0SK0WCW2tRQdOWkvBj7PudkjVh0BKyL0i4PKC7wiyrrP47UYPjSrw2?=
 =?iso-8859-1?Q?1pFifFpAA6Mh89PrTpHBEcbYvuZi6oYQ0ZGzPpfWR/5zeQ0s14I+OUDyL4?=
 =?iso-8859-1?Q?f5vFfQFYRmqe5mGWZ5URvZkLjTx0OgwbkwuafWMPTxe6DUVvbyqtx/5++E?=
 =?iso-8859-1?Q?ygkGLG6dST05nSnI3X2RlciwMdqmTCR2HaddREXv2Fpx96GbmPkorIYVDN?=
 =?iso-8859-1?Q?cPQBskS8oNqqtjmKh+My4ff/ogzQ3kGsxaR8kVSEmfmrMAgnZx0rGJb7oW?=
 =?iso-8859-1?Q?odpLHteAmp9Lm7ltYDE8H3I0kaQtejJ0eEmSmon0PUcXtKlqZhv1cdW9vy?=
 =?iso-8859-1?Q?i60gWspc91s7k0CK4hzDjJmxEl1XotHHaDZEZnF1gI1ykST4LT2KVPNeWI?=
 =?iso-8859-1?Q?Dri5FMzZLKBSyQCTCE+DWRbTvEcUZHF+IDqgpMqlB2LMZNeN2CDifZBNgT?=
 =?iso-8859-1?Q?FLizVyCMx9vuAAdp7kdH0E/jJSv0n/xRDeB6LgFwZZsQTEzh46i1ZTQKR8?=
 =?iso-8859-1?Q?wfxVfGFCCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QwMCTPlftQaoD7C5/Dy3TVoAdgwcda1M6hXz8ocmAGeBAyoUx+M77Uiz5fnNJmT5ZjHprWRgp407loBdYSWgbxAJJ9y6pOxhSAExuM0RoJHn1pyqDXchQ8qz/sCFdUsOgtAUGOv8p67TKsZPaUPRD+WomMdho8pieEoNL0aMRFW+dEmmuPYWGau/Tbo/rNHzILqRafzUaB2PWxhXgCUU/wOwmtu75CVMfFE4e1w6WiGhiBIAeRuw3J+CRCfHfT8xMGrRJo/+FY7YJIEPDdLfbrRVxbTmiPss9rl53APXAJCShyOxlF0PUrHotM1NJT/2x4Oaq09xRvlv7R0BOl5vbg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434a6fb8-1759-4100-51a0-08def76dff5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:34.0647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wo9DbY4K8dUcsE98BgIBYbQcKEwhvD0GUdN5XFJ4gMmVuJtq2HYcFlb7DwtJ/iCIxl6ga9ejTyuYvUV4ReBva2K9MKCDL/XpJe/DEdStP8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5419
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

The AST2700 crypto engine addresses DRAM with 64 bits, supplying the high=
=0A=
half of the source, destination and context addresses through HACE80,=0A=
HACE84 and HACE88. Add those registers and a crypt_get_addr() helper that=
=0A=
combines the low and high halves when the SoC has 64-bit DMA, mirroring=0A=
the hash engine. SoCs without 64-bit DMA (AST2500/AST2600/AST1030) ignore=
=0A=
the high registers, so their behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 33 ++++++++++++++++++++++++++++++---=0A=
 1 file changed, 30 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index d84f7f9cec..0a6e2fa829 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -57,6 +57,11 @@=0A=
 #define CRYPT_CTX_KEY_OFFSET        0x10=0A=
 #define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
+/* AST2700 64-bit DMA high address registers for the crypto command */=0A=
+#define R_CRYPT_SRC_HI      (0x80 / 4)=0A=
+#define R_CRYPT_DEST_HI     (0x84 / 4)=0A=
+#define R_CRYPT_CONTEXT_HI  (0x88 / 4)=0A=
+=0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
 #define CRYPT_IRQ       BIT(12)=0A=
@@ -670,6 +675,19 @@ static void crypt_be_add(uint8_t *ctr, size_t len, uin=
t64_t add)=0A=
     }=0A=
 }=0A=
 =0A=
+static uint64_t crypt_get_addr(AspeedHACEState *s, int reg, int reg_hi)=0A=
+{=0A=
+    AspeedHACEClass *ahc =3D ASPEED_HACE_GET_CLASS(s);=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D deposit64(0, 0, 32, s->regs[reg]);=0A=
+    if (ahc->has_dma64) {=0A=
+        addr =3D deposit64(addr, 32, 32, s->regs[reg_hi]);=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
  * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
@@ -717,7 +735,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     /* Fetch the IV and key from the context buffer in DRAM. */=0A=
-    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];=0A=
+    ctx_addr =3D crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);=
=0A=
     if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
                            ctx, sizeof(ctx))) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -758,7 +776,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     dst_buf =3D g_malloc0(buf_len);=0A=
 =0A=
     /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
-    src_addr =3D s->regs[R_CRYPT_SRC];=0A=
+    src_addr =3D crypt_get_addr(s, R_CRYPT_SRC, R_CRYPT_SRC_HI);=0A=
     if (sg_mode) {=0A=
         status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);=0A=
     } else {=0A=
@@ -794,7 +812,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     /* Scatter the result back out, per the selected mode. */=0A=
-    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    dst_addr =3D crypt_get_addr(s, R_CRYPT_DEST, R_CRYPT_DEST_HI);=0A=
     if (sg_mode) {=0A=
         status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);=0A=
     } else {=0A=
@@ -958,6 +976,15 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
     case R_HASH_KEY_BUFF_HI:=0A=
         data &=3D ahc->key_hi_mask;=0A=
         break;=0A=
+    case R_CRYPT_SRC_HI:=0A=
+        data &=3D ahc->src_hi_mask;=0A=
+        break;=0A=
+    case R_CRYPT_DEST_HI:=0A=
+        data &=3D ahc->dest_hi_mask;=0A=
+        break;=0A=
+    case R_CRYPT_CONTEXT_HI:=0A=
+        data &=3D ahc->key_hi_mask;=0A=
+        break;=0A=
     default:=0A=
         break;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

