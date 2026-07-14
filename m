Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A11C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXZy-0005n2-V6; Tue, 14 Jul 2026 03:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZy-0005mf-Bs; Tue, 14 Jul 2026 03:29:22 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZw-0006VZ-H3; Tue, 14 Jul 2026 03:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuwk1DMbckP6lQ6y+J5RnmvWguTCEupZSxbsWy2eSjL9txPCHBEMrFGGHS3EZUEbWeGV0Bw1kLDyzcW+BMVaZhGXnh0fITwyz5HJCS/LXrIjyLs4rWwCuaj+tvTP7aQXRMbAUiyQrk+kir6pV2nDJD97q4E9WLCVPnQJda1YmuoUIzO43q7VpMTG2JAfTmH6D4ZQGwGd5SIvhBTQNcUnUAF1a6qSaXf9fTE36qYOnlyX3nOqN8C8yfpEGEjMq67/REH618YrZk5hh7QpLGoZ+m2EJrd3AQ2uLkFDIODMU7EvDjW3CUTUoZSnQxkeENqkp7/IJpN0qihKmStyjPC3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8w9MhG11Sg/3XvS5/wrYdwpT8uCxyGYK1UPeCsrLm0=;
 b=VVwTtkK6nJZFqYMfpTUFzC4lJIwQer4cvJd13jdMjCn22lmCixnMdgtd9pUXX3EeswY43Ffje8WCilHOcIn/0wh4v+6XfmK/fkOF/EpwEPrV8KTYTouc7vFaxzdtnbMMK2d4L1FmXjL+oUsRhREupTTtO+qPHXvlOyID03365IiSMc0I2mBzEgrUtRSClGVe+v1pboqKf0NhUSBMzBtgD9MpVRmkvCTMWJpoAU14MuhjFngfiPdEHDrHF1maZng20DnXVDvb2v3ZGWOvH1Xkrph4nSr5HV/yxk1bPplIsQV0pwCIyfXabnBFfrLKvUFeVygH5REBpBptYOlY9iJjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8w9MhG11Sg/3XvS5/wrYdwpT8uCxyGYK1UPeCsrLm0=;
 b=g2Ms/S6vKrWvcgMVwNeeI9SlrbAEbvLWuWpWyO4nsYndH1Nx1l89bthLiXJpQfYn9HLlY4D7aB57gXh5AQj/tG7frolkG/npi2CVg6cW3smOAaP/9Ya8dSen33VbigCxijurs9gK22YV2SYoMrHtPdfpANy2VfJIHkIRB/Mq6K1XYKZN+od6qRpRPfE4E+hKJB35EGZltLDjIC8vj3wKnQQ3lvKnsw9iIPZEypHGBv5OvM+LI6cvDLDj/gKWGKLixJM6Ktr/qkVCjsZf5hV+hjsx+/8rQkXoKA++vQsZ/bnwCvY/IM7O5OrJ/+fiysxOlIiyQNtYn7sqRom5yEwAlQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:07 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:07 +0000
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
Subject: [PATCH v1 04/15] hw/misc/aspeed_hace: Support the CTR mode for the
 crypto command
Thread-Topic: [PATCH v1 04/15] hw/misc/aspeed_hace: Support the CTR mode for
 the crypto command
Thread-Index: AQHdE2J0ntHAR2TdNUOCTUkdS2OGrQ==
Date: Tue, 14 Jul 2026 07:29:07 +0000
Message-ID: <20260714072900.3023742-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c42894c5-c2b9-479a-f092-08dee1799714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|3023799007|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: kgUye6yvR1OC5PrWzuu3jaDF1mwTKgeZ4xm7kg2w0i+z2Dx4E83t4elyd0dhEKKLnc9DTOvWCmf2k290E6VQgD+VE8jbM+RF0hV9zf5UkE6uuMw2qTOQw6E9xjlljx6JKjt4HsBcQF1V0T4UI+k7FX6QAHD6ytOB6295Gc7PgyCkJwR6NSJuZ7ecMad7Kei5cPGT3T39qJFZHO8EZ0JIa3tRpYLAb74kTZydseEktL8/F/pSy3mStXv98+CwjK3NvaI0hSsXH/FwE5rhUXTX/bhzgpo88nqOM8JXHlMcKLhn+wJJsxqf5yh38GgabYN3YiumkiUlJcqJcBbjipCLuKhILixdUSTsKo5CaGJ9UO3jOUVJz/2ArJyKkamVAWL2Liq65zpRAURJfPqC1ZX6ownJsk2UHIq3czsb8QmhW2SnAzfFzKbCpW3P60EwNIqGT96uK2GpWQT0KEv/KqgEO88NFZKMHRwUT0+/zpkmJGMypN9mvmSoKehI4m6/2lNLEVAsC39U8mZNMK61T5X3/4i86+tbhilMz8uBZGG63teADGYZ/L8omR1H5nvGAXodZzEK/TNtRJYrxKVuq5BxDpMcunSWcP7BpoXbQA2vxRezeWPFpnjq0FlplsNjcQVzXt4cjxa0XqpstqLZrWyUCc4SXtsOIY48Oy9rgfV8rBEng1BaIRYOLbYwDwSv4PXLzikBSzrARYpKuNkgdXJGjPFsM3dKR2vQIU4/KoY6TKqJXK7QIYlX1qFP0211rqrZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c+TLNhodiyTZ43zeWiZrK9eD3S9tLQ5FcoQxHtf+gqzyrMsk4g1Lfu6qe9?=
 =?iso-8859-1?Q?kOu6Na+KomiIj/Iu63AxBpveW6cO8QD/p1EcqxXbPlqOEwppWxOsxRJLAy?=
 =?iso-8859-1?Q?mzrPhfxF+iFByxUQr2wg6ZkUUXs5GpeLpCgLFQwRgrpgmOY3WCAYFRM1iM?=
 =?iso-8859-1?Q?O9gJSMXCM2wZ4adGByZX2MHDU3WKm1RGnAOFD0N38mpaXGvf0OSRaA3h12?=
 =?iso-8859-1?Q?F/qgp5aKX7HVlTiOx1qac2mnF6pHAclw2Q/p4fld8dUi5gTmkp4E0D4mWV?=
 =?iso-8859-1?Q?PJvEEUaRiQ9N68ssgcuffh1f9Xbce59OXHZjsNi/8Z1vlJuKjPDm0yjjr8?=
 =?iso-8859-1?Q?2eSmErgO/Oo0/Yqvnr12jy2oGdURyTj4eNeO+DgGsN/bPZCagTu3VQJKVw?=
 =?iso-8859-1?Q?c2TJ+JsprI6Tgu76AIgJvN6NsIPoEKP2oMuovndia79fEHqvgn/RDSNzkk?=
 =?iso-8859-1?Q?d4HtoE5ZHbpDjoc4d7k61Iv6Ex2aujYeUhb9yfG3Og07c7FY3TzJEhf4bo?=
 =?iso-8859-1?Q?wjGvHcvhcEt0UcYsnkmxz37K49S9/SpXjaICdEhX4rOz8YH2G+M0+S4Poq?=
 =?iso-8859-1?Q?SIOgOiAYQQLnjQSM9bUDJrlPC0YUNglWxV+U+o7nbFAtljKgAOpF8As28k?=
 =?iso-8859-1?Q?+HVz/z8HmyR4ixjtgEpk2sY5hcc3uMR8jJKGwBrtbKy5FMZn4CwQKQ+DpL?=
 =?iso-8859-1?Q?loPJveMd5Mr4fyMAHS4UFvj13WvnAXUcZ9aWNKLJcXzQrRX19ZK+GBHisX?=
 =?iso-8859-1?Q?b/96hPZuHPjKGyrI9yPFzZQ/bdml7iZ+TGnRlWwvSlpPmFsH7iuySAMfYy?=
 =?iso-8859-1?Q?xW3meNyWLO75cU4hr7vopnZv5a/NWknpOx/b5r1qyCUoy4HfLCLMoqb+wi?=
 =?iso-8859-1?Q?CFP26ziMAs0DMo+DK8Yh2vYT2PeGm5a7teXz9ZHuaOfSLGFLahF8+Nh1U8?=
 =?iso-8859-1?Q?t51nitc0G9Di85vDqKV+40a9AXzABlDRZzJOino4t+ZuZRN9GSRt6VItWw?=
 =?iso-8859-1?Q?7CEge3UOemdF6gS0dJyAnxkjJPD9pSJ1Q1Szjk1ptT5rZBNOW/WyYxoU5U?=
 =?iso-8859-1?Q?iMzATrX9TMXINkx7jA85tuygHemnoi/jQ4yr8PGCK8aUTiqe4UpPVFHDNc?=
 =?iso-8859-1?Q?FC3Xev1VW5cXkW51Jvd9i9eNwWBNtrN2KVfc6GCNuXNjGwGDLb3Ust9MQm?=
 =?iso-8859-1?Q?5iF3hDaFCfGhN6QWlHQi1lhAy2nJ3AE1QCQtbM2bkFDUbIpWtHYTQVI/Bv?=
 =?iso-8859-1?Q?roc+fqWV6a54bK7wJ4kjMxbTRBzc1oaoCjPywuQGzCVpIGEpFWkAVyG5Bz?=
 =?iso-8859-1?Q?4o82mxe5kDqAVb6EO9xY2R/0sPdxCtJ/0mObqS/eLD0tJW+TRmvUhhgjSw?=
 =?iso-8859-1?Q?47FkdBnZoEkWwd96JBDPRW8RJD/OlY3XiOrb2gjDRjfZBwpTl7gXJvNyvW?=
 =?iso-8859-1?Q?czR2UPPlNicKRYiiT5g7mqLhWl169KKxyRdMX/M2vML571j/A+gEEHD0Tc?=
 =?iso-8859-1?Q?8bpW3xeCz4qEXLB2PzkEou5pX8vrd/P+V6Mv4GnD6xAf9df2L2CzvCtmtd?=
 =?iso-8859-1?Q?KgnCsifYC7qXTdc26ZnsmrjzlF0mCvdBig/1qJir7VmtMjZjoXoktUH99L?=
 =?iso-8859-1?Q?cuNDm6fsEjUJVVth2mNx5FHz8uyMyPXAj0W/i5IGJNujdubZ9OEIIMHCJ2?=
 =?iso-8859-1?Q?KAFJDYPFO9Yni61kfYtMg8hayW5gxR8V7PErnWRcBA70QAdfRD0M2KYzeS?=
 =?iso-8859-1?Q?gA0Mt4KMIpFxpzh/rjiOHx/U5b2BlT201BvtFWHwpWSiBs1eOffi3T8vAT?=
 =?iso-8859-1?Q?xRLGXGzGXQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GPbLJZEBHw8agm2bjkEdqLLFcMVjnRhsuzQ57+cPgN1DSWeH/bnzrIkBy3oGz/bdetrN7L06ROceCYA6T8FWVdAdmLq0hM91Ov7lMKYdMYQIMkCTqMmLTtIOMz4MDpELVaL3tn5ZrfRYrxG+TEmIJjBpd0xgAgQrJmKHtuwv1z37cBJNCUFoZtquZe0JHBvl9ODyrArMwy5rxrQjzAXDHHDYhdjOEzFY+8dwWJye6jKrHVB8sQIGioD/yajxoi8E3LsKjd4BINV0a1t+Rxj7xieqG5G6oLNauSk6fAqNo2PWgbvL7c2E6YGKx7SQEqpZei2KUQxw2Fvv/tXzmJfr1Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42894c5-c2b9-479a-f092-08dee1799714
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:07.4804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUEFZBDkfMRh2VpVtD40ksROYxKOinKyH72V57AdFVOg9rxOFkVTHi8q8N0RglJbaiGc4VWT+j0DJu8OBGItfMC/5CQVqYMu4kEdYfkRPBU=
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

The AST2600, AST1030 and later crypto engines add AES/DES/3DES CTR mode=0A=
(HACE10[6:4] =3D 0b100) on top of the ECB/CBC modes shared with the=0A=
AST2500. Decode the CTR selection, round the working buffers up to a=0A=
whole block so the stream-like final block is still processed a block at=0A=
a time, and write the counter advanced by the number of blocks consumed=0A=
back to the context buffer so the driver can continue across requests.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 50 ++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 45 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 59eb1aeae3..b7a7c0b7ff 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -42,6 +42,7 @@=0A=
 #define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
 #define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
 #define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+#define  CRYPT_CMD_CTR              (0x4 << 4)=0A=
 /* AES key length HACE10[3:2] */=0A=
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
 #define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
@@ -589,6 +590,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCiphe=
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
@@ -652,6 +656,22 @@ static bool crypt_prepare_sg(AspeedHACEState *s, uint6=
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
@@ -677,6 +697,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     uint64_t dst_addr;=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
+    size_t buf_len;=0A=
     size_t keylen;=0A=
     bool status;=0A=
 =0A=
@@ -722,8 +743,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
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
@@ -744,7 +771,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     if (encrypt) {=0A=
-        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -752,7 +779,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, buf_len,=0A=
                                    &local_err) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
                           __func__, error_get_pretty(local_err));=0A=
@@ -785,13 +812,26 @@ static void do_crypt_operation(AspeedHACEState *s, ui=
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

