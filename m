Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF03BC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYS-0007KU-BF; Tue, 11 Aug 2026 02:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYQ-0007Jv-FO; Tue, 11 Aug 2026 02:01:38 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYO-0002ec-QO; Tue, 11 Aug 2026 02:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhiUL1yHbnk4jGPkm0m55Xwr467re1zjOtLvTo3eDhmCNr68xobd/0nzblOlptFPsP1GNTAx0YM6c2vediEODtwgbBluoC2Itr5HFdzm1Ut826ulP0TGf4ULEQbJAth+0IZqu2+HqVpEnjZ7RJMhwNxahIet9/gEo83XGW3oiBwTE6n419lxLNvJFRNVE8+ymnDfBbJGNKfCiaruMmroZ8/06RugWBfu5dfnkYguv+u5I5Crc302dtOVeLpGmXY2NMKF+NHFSXxodWSY3cQwra9lcpkD+CT2BM0Q0SXwRFG0IEF72Cjs8uEAI8uiEoBsvu4tgZlCbw49w26/4JVlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYCK6pCifmARPcX/ejm7hMe1QesfvjTRs0DiibupZ8E=;
 b=QkSkkLmz4OMOtNJY05aBroZllm82YAcZBSt10l5Qo6CB0An8Yex0F1qkW3GUxMz49dCaUJ0wqwNQwt/X4keGxiAUfauiOSCNOaBdvTzSQ0hK5EAu+gCBrmXFiMO6l8xOzaJ1WgL6THw3BOTp34Q9paL9yLjTgSnb9Ut6BerpIvT6+R0Rg6X9UOQCYVNP8DiRr2RCflNO1ivHV9eu90XayJsuPKXvdBRgXjcAldrJeFVXfNfApGF3z8SZqDGIF5s37KlFTOf4ZWrNgJbFIIs2lAZiUdHLvz8SURP4tCoPzTA0Ge8Hi5UDDhheucD9B1Y+H61CsauLqwguPKTH4MIjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYCK6pCifmARPcX/ejm7hMe1QesfvjTRs0DiibupZ8E=;
 b=Ph91k81q8hlau4kdgW+pOl6hBwomW+2Xuvza8DsgQlZs7aqVBbE2X3lWrUndT5Cx/qk24wUE4OaBqLrgDLP3FGaU7r1nctIuzvyNYuwcGN2IMiyjcPXNh+GI77FFjOJTjvyFWj0fB5uQXsXsFh7eh5qngbTKlXfKUWbY8iL9Y13AlH2eed75MF/43Pz/LHt1YxAOx5oCtQhZniG/OJt9DvTcRcv/f4MaJrZCptHN62ZxRcrRD9eFTWvBnbuCvBttWR1X/xlWCzwGAvSA7FgSCDJ8/4aO6OenHojVJ3KX5cvDnnwULcggvhtYuFie++A63RQfSn300f6B6mHyzJoQcw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:22 +0000
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
Subject: [PATCH v4 04/16] hw/misc/aspeed_hace: Support the CTR mode for the
 crypto command
Thread-Topic: [PATCH v4 04/16] hw/misc/aspeed_hace: Support the CTR mode for
 the crypto command
Thread-Index: AQHdKVbVS+/VSxtQUE2zAw9jOGn8Xg==
Date: Tue, 11 Aug 2026 06:01:22 +0000
Message-ID: <20260811060115.1849266-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 9e61954c-82a7-4583-501a-08def76df857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003|3023799007|38070700021|921020;
x-microsoft-antispam-message-info: h2H005gJAE7t2gQj0VtcWZHF2LDI9Q/IMuWzqFmkLeAs0z6vx6ZsvktKdbiyNl+dnBU9+pBVI2jMfNlbO6kkFMZHk4/nW/aEsJqcjhwoLkLwlo0L7ab73RLPojs35nfQwRa14CCFjjVnxWg4gHh4POdjrqMIcl72HybjCDuO1a9GH3I2VxklJ/LENgmab37mtfwW4o3ZxfZJR9g8r/9X8pYx8wvMgQf4HNEuLdo3XpTTy5ikr2F+0OSsSNM3dMtvBUgWHGvwoaEUpWDHDX8uc5egEumb3AX/Fn3TdecCQKxwdIosv5yR/ajI2dl0fhkTmG8HjdeP08rZB2TAY860QMhb22Xqa/amlXGMEkKELVj7F57FMLSUgsZh9/c22AKdvLLe5GxQFvFCWvK4pdrB3CiSS3O00sbvN7KAC6d1rS+dORaypUj3q7tYBYLzvtNX5qZHKJmfEcMvYCjDV10nZcNV7sMpcTkwxVjWNCfGEzorM4drQ6Fte+DTtIJyznm+5j4CEZHpS06zzvx5eQxM+xw1rpU8Uq9TOZuDzrZdW9baMTV32+AOXzuefP1Hekr497uquuCfSoHyx02a0aC/v8J+dsDgRFP4UfEptSF/AizHK8Go4lx0uveuQ372eLZ/JWLGQMAH+B60IEoPzsGDk6g7DDWAzoFwhlGpANh3Ac3/CruPj1Q5l+pkvRYqrZT5PdoFWDRmZF3C8aG+oMrQ3MQ1iVmMq+dljuPs4f5H8eu4oUCT1skjX+mApZDdmtuO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jPoXHQshQh+JJmknOCFrGWYvzJnq8/6mVWlDTt8OFGYluPHWpqOYsnAy2g?=
 =?iso-8859-1?Q?oRlodZvOVwMGDIifg30iczZanMQz8+VsGYL9+ZX5rx09FYrPfJad/ZLG+u?=
 =?iso-8859-1?Q?4vdKyaWqoMxVveC4Xt8n/VF71F1MAZO8Z8pqD6NEKpVbuIggGv2gugEyJg?=
 =?iso-8859-1?Q?5UIbPPENXzUMRVJDMQnW3E55+dhwCU614aIu+Wfowat7a2+WSvIe3k45D1?=
 =?iso-8859-1?Q?hzrH+mwkT6JDNRcbzWMTH8eOngsGSeBLpYkfR7/+Z+V9r46TnqmXfS4Zp8?=
 =?iso-8859-1?Q?aCj3REwFEGARNXx+Q3bDSA8E1Uzli6vv91HWzQeisL5wDuUf+MOOIsDe+r?=
 =?iso-8859-1?Q?Uiw+iZCS58KkeHWZpqLil62nFlLijrO6K36p+94XILd8f/AIUdjPbIbuH4?=
 =?iso-8859-1?Q?xG+9dzFDCc817hyg4w8vbDeoOYTBYf2Gf654xfoYUcSrkTiC9tyzDmKDLq?=
 =?iso-8859-1?Q?o4XPxHWX1yJR9YK4iEKhT82eyvMW90DtIRycQZUQB4Wb+P7l7OjJB9k1pb?=
 =?iso-8859-1?Q?KuT5011Yn4xWKmr3IxJ/LNfzaWsfwEPZOiXRXLOIdiHkq0KygkhtkpKHPb?=
 =?iso-8859-1?Q?JDSefKoBkyclE+1TZMrLyu7zZ1JEBTddY4n/ivBx8QsWvKms08HWihGaIf?=
 =?iso-8859-1?Q?AD21FzfLz+xNuKuZeQRgLa6cIWSeLcrIvhpsTlTP4hxvQmCsIqG+/e4uG4?=
 =?iso-8859-1?Q?MeW4BTXwviSqplZooQ4HxZcBBrIDaBJh9GBTqXLU1rVkNA7bXD/rD3FN9N?=
 =?iso-8859-1?Q?DtreH+4pAew1jjx7vPugqSAW7cH1q7NQ/JDn6gBem72lBVrsoxqe86PNgn?=
 =?iso-8859-1?Q?wa271BVnzuOR1cQBMOj7L6S/b7uOdwg2ICSZ3mE2BBUym+DG1g0elJOVIp?=
 =?iso-8859-1?Q?F5ZK2DdROMIxbzD0QVYTzA45CyAv6nfLwI7034lTgvVopJqrsYZIPP3y/p?=
 =?iso-8859-1?Q?tNg9UBB00+cK/RiknWakBf9MAcCZid7MVL4xgCQg1B6LbpRBGa+oFigk5a?=
 =?iso-8859-1?Q?66u0GMPaBGkdctyopEe5rM7iDwAitZ2khVzFtuhMYp53N/xKqvc3GQiSXc?=
 =?iso-8859-1?Q?m0tfCBPzaMUmwzTJM+Px2bQyiArTQPUT/MhJ9bIp2J2Fq8qnZLPHT3FDNC?=
 =?iso-8859-1?Q?ZZLBJxRBDvG08SFqEjvV3fHP2FfVfS1H0D6VbtNprGuR1jZEiJqSMZOuYN?=
 =?iso-8859-1?Q?PpNMBP6i+UbJR7VzjC1gXaw1DM/yQT4etDYVHp+4okU3OCuDqV4OdqUgNq?=
 =?iso-8859-1?Q?ke1UdmQiZWGhTgRvEF97s564fxru+0FTDfKM2vRl8iU1Uwqk4A1mf0+x0h?=
 =?iso-8859-1?Q?Tse23/QC8ifTe5otkE4xfnp+/Tgnf7abeGcQyyghjAIv7FhV3pZZp5qHPT?=
 =?iso-8859-1?Q?3KoCNCAL/U9prrw+udvH5BpBy9ksPrb1Dgk5gIFO6NgJqW6tj1mtwQM8Md?=
 =?iso-8859-1?Q?4IPhSYm/m+mVnpaOS/c8pmoh9ThzqItQLofs1DsuEzhilGEUKxJtz6eqLq?=
 =?iso-8859-1?Q?SKuFnNUCtlPZp8S56/fEm4nzNx3mfLO+kYd+B7n6697cADZe9xYs0X9IPQ?=
 =?iso-8859-1?Q?wa8mE4e7wDER5C3KLOs0O2u/Nus3Tu7WSu6bfWDka3jT5MtnVBOdf0SJ/G?=
 =?iso-8859-1?Q?LPYRiXxsQqTYSP2DDPAMD/+T/wqRsuHK0NYoeM+9s+LlLuyTjRXQcYdGmh?=
 =?iso-8859-1?Q?58aZUfB8h7sMqwhOwUa2tC4m8APWeCHxPmlNJiO4aWdCbgbpr6hvx/8Ynh?=
 =?iso-8859-1?Q?tqf3q+zQf2ekilQuJgVkR2C8ejH3a47SL271JAUtwjB9AVH+vXG3XbactS?=
 =?iso-8859-1?Q?or0CAHleeQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: clhAm/aomZMWxIbp4l9NZtfpWYOmxYT/1yZdZ0xM0hYZ0fH0/H6ST7FNIbGRMVmXRAW7F1tA92FXX3AF4MKk3lXrU8hzWg3iDF2zVofSuq4jWZyduFbMLvPA4pcUM5IJjopQ+XyFxDcj/Lju7fEErcSuQywlQybdYEhVtiCRyBmmodv9BQwwHzrENJedjtu6pMXr7t6mA43U3kYJjU3D3Dh6BMNxHGvRa/GmRHcsOY6M046vwRU3uYb0295HB4GSmCb51w0E8GA55O0YFWSkxVrq4Iyp9ghuxa27mldvF3PFWOarNja1E1+F8YULTm5JZhM58DNNsxKSHjpgt1qkEA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e61954c-82a7-4583-501a-08def76df857
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:22.2734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PUIMydkJekkbSZko1IoB94bkzgs/lLddWO53ERrkyBtWKb311qSgpJfufl8I/GlbZRRFIxhiAiUiOvchf8xW8PDDqX0QOWF0mCplrm69Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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

The AST2600, AST1030 and later crypto engines add AES/DES/3DES CTR mode=0A=
(HACE10[6:4] =3D 0b100) on top of the ECB/CBC modes shared with the=0A=
AST2500. Decode the CTR selection, round the working buffers up to a=0A=
whole block so the stream-like final block is still processed a block at=0A=
a time, and write the counter advanced by the number of blocks consumed=0A=
back to the context buffer so the driver can continue across requests.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 50 ++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 45 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 646ff50476..d84f7f9cec 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -41,6 +41,7 @@=0A=
 #define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
 #define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
 #define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+#define  CRYPT_CMD_CTR              (0x4 << 4)=0A=
 /* AES key length HACE10[3:2] */=0A=
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
 #define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
@@ -587,6 +588,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCiphe=
rAlgo *alg,=0A=
     case CRYPT_CMD_CBC:=0A=
         *mode =3D QCRYPTO_CIPHER_MODE_CBC;=0A=
         break;=0A=
+    case CRYPT_CMD_CTR:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_CTR;=0A=
+        break;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -650,6 +654,22 @@ static bool crypt_prepare_sg(AspeedHACEState *s, uint6=
4_t addr,=0A=
     return copied =3D=3D len;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Add @add to the big-endian counter block @ctr (@len bytes) in place, so=
 the=0A=
+ * CTR mode counter can be advanced by the number of blocks just consumed.=
=0A=
+ */=0A=
+static void crypt_be_add(uint8_t *ctr, size_t len, uint64_t add)=0A=
+{=0A=
+    size_t i =3D len;=0A=
+=0A=
+    while (i > 0 && add) {=0A=
+        i--;=0A=
+        add +=3D ctr[i];=0A=
+        ctr[i] =3D add & 0xff;=0A=
+        add >>=3D 8;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
  * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
@@ -675,6 +695,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     uint64_t dst_addr;=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
+    size_t buf_len;=0A=
     size_t keylen;=0A=
     bool status;=0A=
 =0A=
@@ -727,8 +748,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
         return;=0A=
     }=0A=
 =0A=
-    src_buf =3D g_malloc0(len);=0A=
-    dst_buf =3D g_malloc0(len);=0A=
+    /*=0A=
+     * Round the working buffers up to a whole block. Block modes are alre=
ady=0A=
+     * block-aligned; the stream-like CTR mode may leave a partial final b=
lock=0A=
+     * that the engine still processes a full block at a time.=0A=
+     */=0A=
+    buf_len =3D QEMU_ALIGN_UP(len, blocklen);=0A=
+    src_buf =3D g_malloc0(buf_len);=0A=
+    dst_buf =3D g_malloc0(buf_len);=0A=
 =0A=
     /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
     src_addr =3D s->regs[R_CRYPT_SRC];=0A=
@@ -749,7 +776,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     if (encrypt) {=0A=
-        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -757,7 +784,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -790,13 +817,26 @@ static void do_crypt_operation(AspeedHACEState *s, ui=
nt32_t cmd)=0A=
          * output when encrypting, or of the input when decrypting. Write =
it=0A=
          * back as the IV for the next request.=0A=
          */=0A=
-        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;=0A=
+        next_iv =3D (encrypt ? dst_buf : src_buf) + buf_len - blocklen;=0A=
         if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
                                 MEMTXATTRS_UNSPECIFIED, next_iv, blocklen)=
) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
                           "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
                           __func__, ctx_addr + iv_offset);=0A=
         }=0A=
+    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {=0A=
+        /*=0A=
+         * CTR chains on the counter, which advances by one per block. Add=
 the=0A=
+         * number of blocks processed (buf_len / blocklen) and write it ba=
ck.=0A=
+         */=0A=
+        crypt_be_add(ctx + iv_offset, blocklen, buf_len / blocklen);=0A=
+        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
+                                MEMTXATTRS_UNSPECIFIED, ctx + iv_offset,=
=0A=
+                                blocklen)) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                          __func__, ctx_addr + iv_offset);=0A=
+        }=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

