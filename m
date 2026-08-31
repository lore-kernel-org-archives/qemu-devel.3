Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8578CC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0suj-0006Av-JQ; Sun, 30 Aug 2026 23:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0sub-000686-JR; Sun, 30 Aug 2026 23:42:22 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suZ-0006yh-KI; Sun, 30 Aug 2026 23:42:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ27kEDWzrjIORi8NGaFfD4nmcFUtqCC53ee1jH0PywMZwXnRnB1Ew2+i2HPrEka4qkC1XadGqr1An/8FcaMMmjXeNWldZiMhVLkyqfv7bhszoajOb2c1GhTM4soFREbGDa2zsqJBWTcgG/lOAZCB7QzCojYVmApKOmoJxMG6hTvH3SKLaomSfOyRz0OJ1WZK+6W+Ia4u8AtGTlTy/xWDqi2PMFkIqVTcUFHJyuMmg0OcgAb/nychJ8Xzo94FA/pd1Amc9w23DOJjKYJas6ZwakcvB5pzHnwPsx5xFj82cPzKFDWgkQpHIOVQ7SXj3OT6Jvze5pr4dcNyDoozOsJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly/COslt995cMfTRFT2y5Hq+NlO4rCGv7moCdE2KUe0=;
 b=AqdwA+9MF+bLW7OrbysAAmvujcXAglXKGglysDXUuGe4CLMWSYZgJTqBFnqZjjqd7AMNXaYzm++spZGAESDiaHPrN/0b3vZtlrX7coR8paGlRioq1E5EkV8iZEwkpNuKi6n6gjlm8+PaUBaaUUsPsWWiOvvCfFGwBT7OIYPf5fnMLXwLnuAInIdp8bKHk9JSd2dfU78qIOHD06iIGGV0PuUDgVOO5ouVMrif9Mi/ZLN/eciKAoKLLg+qzNae0lVDF6m2ASe4WCcFN57sLZub1E0kCgtyUWA0E+aakSesykKAgZDfc2h+A2sfZQT8Cu6mhWtfY70LqcWVMGY7U2GFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly/COslt995cMfTRFT2y5Hq+NlO4rCGv7moCdE2KUe0=;
 b=pxxcZRfgsti9XTrfTRk+AnniVDVd8EMIGi7ZkiFinWUP6hz4q2FcEK2H0DXoNzMUXuVKrOMIIy9o+P3Z2JjaXyhpxJT6izzvM3bqZlVgUZZYEQQD0cQL3wXnkKBVFm0kj4srUqVfDRi08i5xLUu2RkqtOnd+Mv4pI3KUqfu1pQs9oDN0dqeBKvJRFkVPTgQGKunskDNR+FzpOstSZWjP2axoItEecbRKxMSOn+84EqIX/2mCJunrGiWcwxt3IZHcB+54JK9L1INNAIe56qjICzBBSFR5OEAHdFekZ/qHyoZwCXz5EwTrGuPBioJGkUHfziQmSbV89AselU7l7xWW2g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6164.apcprd06.prod.outlook.com (2603:1096:820:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:42:02 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:42:02 +0000
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
Subject: [PATCH v3 6/9] hw/misc/aspeed_sbc: Support the ECDSA verify command
Thread-Topic: [PATCH v3 6/9] hw/misc/aspeed_sbc: Support the ECDSA verify
 command
Thread-Index: AQHdOPqu78cMyAsp+0Wr+ymnO58Ekw==
Date: Mon, 31 Aug 2026 03:42:01 +0000
Message-ID: <20260831034153.192916-7-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6164:EE_
x-ms-office365-filtering-correlation-id: 54f4120d-3e46-4996-0637-08df0711d182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: PIlzsatofalAuR0dZgtumPJpdnmV6V/GqjzHft1RDhdPJjcjZGHGv7PRIjetzSPbLV4zSh5iXwORiVH0EDBtM0jVve4xEUYx7M/L8tXrlpkJxxIxh2KQQ+RI1/ekzafevYmBcjYfxQgoI5sY2pfgFLb6nAhQW3uzBH8KhqBHh52qfJp2Qf21LsvvySRCLpLCg6RkSsNDH0PbyHSVWGfeyA/QmndzWXldLKuitrceJum8MPeyC/0ShxOv4gZt/7rkcxhJBKfXbpmdOu5X/z85pHGMOxgodDAcp699vlkIo0pfgnYwsjefcsdoT6AeYetWEc7li3oRWK36LB7r0epV6+YwdJaTpNDUk29vstQAqE3otX3cDSYkN1vC9hjWWJbPK45J+SeiIpFL6V+RJJQTO227uRgJWkAn+s3ke3LgobJaOFDCOWEMBbSoE3pgjHuUNOryMnWdebDzyCeuoRsevPKzo0DS/pueh8OjmTNMukAIqe+5x8lljDw2l7X9MOYZz5jB3qDc0NGNU5QQPZt+9nRY6jUaRJXaDEGCC0hfllHQJkQBkL+KxGMgF+JESOXKLsFuQLEjk+KyCfSuF5mjuYLSHy8/Y/00g2O/rb3K+M1Bn4B9V+8GIDmGRCqPFmfDuCEOwiKDcmCB0a8m0us02zPHc796/uqpcZqXuwWOj7H8sWIq/pfBf1hL4eYlPBmndIoV0rUXh2ndJI16hd9H6pS+1IMuhbbMB7gMoFcmFwqkKbZl3ppgRmV0J2HDTDvY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6J/sbAVtKWcW5/yKyIh4L5KqLwwrnphOI8OgN842BocIcM3EGZ9tTZrFDo?=
 =?iso-8859-1?Q?YVNWdIZmg0QyN8XRznp5Y0N3bqnFYskdm3kQdK0Ud8As/WZV/ZwC92tdR1?=
 =?iso-8859-1?Q?adOQUG3lQMNb6y+Se0lOBpNR/N51eKwm04KwIYY9EFN4cMtyPXnIkKGhsL?=
 =?iso-8859-1?Q?ooCRJGiEIGHiQbu2yH+FGonM3brauIxKmDL6VDG0LkOmla+xVTUjZnX6nS?=
 =?iso-8859-1?Q?b2QP0lvHTIGcZO0MxPKC7ik0udV3uZfvTwwqD49mjMxVI8QzE1FGxusXrN?=
 =?iso-8859-1?Q?B304bzZ6eRf+Ba6OADGE614nFOphKzMW7JNmlX0rW7QSaBJ/4b6vIdqyxb?=
 =?iso-8859-1?Q?YmaBANHIMidsSaj3wGvtJm1qoXL29jjcac5v06ZXoXKPoIeUQf4QZD2rm4?=
 =?iso-8859-1?Q?Ya+x4JVdp0SDFbQduMlbcF1SurQnMaFuOR/IcL4blkjqrDN01rvmQcNqpb?=
 =?iso-8859-1?Q?cj6VIOpZhSlweV3QOY+bMJ7oRE+EQTcWlJTv0IdBoqgbTeMw30qJ0kLw2/?=
 =?iso-8859-1?Q?HlUElU3rTn5MefoI7IV0a4HEgW6E9HmvCsbdIS3gol2Vb0trekvugvbYp2?=
 =?iso-8859-1?Q?zOl5NrFWN2OSsdJ29fdghmYYjLnZfU9tliDbeW9z+sMDbDvxAC5wdtlH5s?=
 =?iso-8859-1?Q?x+ItfSIGX926DcCSN+2peQGnAud7Se+zb+1cFD0pbsLDSawHacYJ3manaw?=
 =?iso-8859-1?Q?BXktXmZ1C+y4xDLxn91I5ZbNoJP7oJN6rcAG5t10e5TvxxvhY54cJ35E9d?=
 =?iso-8859-1?Q?YKzYPbMmAnzBwY3BgXpxW+3hM/43YIUX32aKazkHtDt6zgrRa72WZbO3d3?=
 =?iso-8859-1?Q?1UOacBh7xb6BxTDFXLHzLcDdpDhAj8VB6g/dQES3/N1hukEqfK1L6fJzij?=
 =?iso-8859-1?Q?SMMqFtUqsa3F3sjVfrHwBRU2gctF0tBIPrsKrw1hfCLQ4Iw6B4cdn5sLj8?=
 =?iso-8859-1?Q?f82NqTCVhbf3CzCPVEwo/93ycqBQGe8wdnHnaAu1s/Wo4mYwsRm+zmdH67?=
 =?iso-8859-1?Q?PD5cE77Iih9GAEv62hnHfVN8ZmIBWaphTEOl+D4aBAIU8wkKabv0kc44wI?=
 =?iso-8859-1?Q?76vj7QCfTNovMPf/w7hrH95bUey6tj4X327xECoZ68y/7DAkpHqHAnIgWN?=
 =?iso-8859-1?Q?uLUP0l5ghhL4bQGdlbL3iAzBX6Q3zrL3SDqJnzyLUPaRUemjBKeX2+m94u?=
 =?iso-8859-1?Q?DzWWz1fG9XTweGtVUHU2X/s2oPl3u+dOoZRHdGkNVK/RQtVbTuhTOw3/k6?=
 =?iso-8859-1?Q?RxAxZUIw6TCpNrJXNJNiA7UWPp136vBXLpHEYQnzHPy+bsCNV/CswegmQW?=
 =?iso-8859-1?Q?66+nN/jTSMjmrN7ETMdbgSTONlR7fkNBMD6hJN/TR9orZWECWoJTrGkZ96?=
 =?iso-8859-1?Q?vB8I1oJXbX5goTtYZZabBnnvEVsGDWKMzmhti7F5bAX+/Dl1bHqTt3sv+c?=
 =?iso-8859-1?Q?PwZoIkQ57V2GKDjw4v/7a0STqKU93v1opr6nUrRBtabAen7R1B5G4gGdC3?=
 =?iso-8859-1?Q?O94zkA4x3y/terjCscfqxij2XzAjniWMXh9I3iV9UDkyv8d88pi0tlenmr?=
 =?iso-8859-1?Q?vkmtrlsxjsEEEGMRxIGR/Mjj06Gqw8SGwDVrDjKDDutvzSl2q67daFougq?=
 =?iso-8859-1?Q?39VNjV/jsyO1MfGlWvrLTwqYL6OMa0xiDhoG/3/E/89SUty6U5fXu6v5Lv?=
 =?iso-8859-1?Q?MOREzbchH6eeZWH10ZYqDkdicVZx0Y54Tj9L1/hqvXvrIw90VKgp+pDOZ/?=
 =?iso-8859-1?Q?inD5VKbdwwO+hG+6HJszmZ3EHduNGG5RdCOw8UGp9zOlAj2utYcRziTo40?=
 =?iso-8859-1?Q?62IHuC7o2w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ifOFVpHgAliSHb5hbyO6vfPg0fi2Me7MNrrHKyzRRuS8JcsTcTTzsp7W6USb95AOhHQshVtN9z10m3AkLEi8+WxTf15dJyCaI5NO3KEt2beKEGSpYMaQCMuuCGJGSNYIKkAdfqPnUkIStMNJsr0swUJpaohSucf10zSnR4Prpet49k1SZuwnkUWJvfEqxzUkR06cJDVhhsSo9/JRkfhxUjSMymHjRyg5HndvmH2MjrIKlwYRqN39gK+RioWwWZoBAwdw99YXw1R7cDkCF5+wwAxygumF9hE7rM+nSSNmtUo1bjfirGLfjiK3qwG68MgIAoJogU5aLymiafI0CGR9AA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f4120d-3e46-4996-0637-08df0711d182
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:42:02.0252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +po2EAZGrn3ZXoTO+eAnXUzVugVf0+Qd1Jj4Hi62ZDjp5vYHGtZI2f6gtibhZDBP4IrtlO8Kncp8uSr0XCjniXb/gNtW4HPpKcploRF/DwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6164
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

The AST10x0 secure boot controller register block also hosts an ECDSA=0A=
engine. Emulate its secp384r1 "verify" command: on a trigger write to=0A=
the command register, read the public key, signature and SHA-384 digest=0A=
that the firmware staged in the SEC SRAM and defer the verification to the=
=0A=
crypto akcipher backend, reporting the result through the status=0A=
register.=0A=
=0A=
The model reads its operands from the SEC SRAM through a dedicated=0A=
address space, using a 'sram' link. The SEC SRAM is mapped at offset 0=0A=
of that address space, so the engine addresses each operand directly=0A=
with its SRAM-relative offset.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h |   4 +=0A=
 hw/misc/aspeed_sbc.c         | 152 +++++++++++++++++++++++++++++++++++=0A=
 hw/misc/trace-events         |   2 +=0A=
 3 files changed, 158 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 07c7c22a86..8d3f9207fc 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -40,12 +40,16 @@ struct AspeedSBCState {=0A=
     uint32_t regs[ASPEED_SBC_NR_REGS];=0A=
 =0A=
     AspeedOTPState otp;=0A=
+=0A=
+    MemoryRegion *sram;=0A=
+    AddressSpace sram_as;=0A=
 };=0A=
 =0A=
 struct AspeedSBCClass {=0A=
     SysBusDeviceClass parent_class;=0A=
 =0A=
     bool has_otp;=0A=
+    bool has_ecdsa;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_SBC_H */=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 1dfcf14e5b..aa167be4c0 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -10,11 +10,13 @@=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/log.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "qemu/error-report.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "crypto/akcipher.h"=0A=
 #include "trace.h"=0A=
 =0A=
 #define R_PROT          (0x000 / 4)=0A=
@@ -24,8 +26,22 @@=0A=
 #define R_CAMP1         (0x020 / 4)=0A=
 #define R_CAMP2         (0x024 / 4)=0A=
 #define R_QSR           (0x040 / 4)=0A=
+#define R_SEC_TRIGGER   (0x0bc / 4)=0A=
+=0A=
+/*=0A=
+ * SEC SRAM layout for a secp384r1 ECDSA verify operation. All operands ar=
e=0A=
+ * 48-byte big-endian values.=0A=
+ */=0A=
+#define ECDSA_SRAM_QX   0x2080=0A=
+#define ECDSA_SRAM_QY   0x20c0=0A=
+#define ECDSA_SRAM_R    0x21c0=0A=
+#define ECDSA_SRAM_S    0x2200=0A=
+#define ECDSA_SRAM_M    0x2240=0A=
+#define ECDSA_P384_COORD_LEN    48=0A=
 =0A=
 /* R_STATUS */=0A=
+#define ECDSA_VERIFY_PASS       BIT(21)=0A=
+#define ECDSA_VERIFY_DONE       BIT(20)=0A=
 #define ABR_EN                  BIT(14) /* Mirrors SCU510[11] */=0A=
 #define ABR_IMAGE_SOURCE        BIT(13)=0A=
 #define SPI_ABR_IMAGE_SOURCE    BIT(12)=0A=
@@ -42,6 +58,10 @@=0A=
 #define OTP_MEM_IDLE            BIT(1)=0A=
 #define OTP_COMPARE_STATUS      BIT(0)=0A=
 =0A=
+/* R_SEC_TRIGGER */=0A=
+#define ECDSA_CMD_TRIGGER BIT(1)=0A=
+#define RSA_CMD_TRIGGER   BIT(0)=0A=
+=0A=
 /* QSR */=0A=
 #define QSR_RSA_MASK           (0x3 << 12)=0A=
 #define QSR_HASH_MASK          (0x3 << 10)=0A=
@@ -220,10 +240,111 @@ static void aspeed_sbc_handle_command(void *opaque, =
uint32_t cmd)=0A=
     s->regs[R_STATUS] |=3D (OTP_MEM_IDLE | OTP_IDLE);=0A=
 }=0A=
 =0A=
+static void sbc_ecdsa_hexdump(const char *desc, const char *buf, size_t si=
ze)=0A=
+{=0A=
+    g_autoptr(GString) str =3D g_string_sized_new(64);=0A=
+    size_t len;=0A=
+    size_t i;=0A=
+=0A=
+    for (i =3D 0; i < size; i +=3D len) {=0A=
+        len =3D MIN(16, size - i);=0A=
+        g_string_truncate(str, 0);=0A=
+        qemu_hexdump_line(str, buf + i, len, 1, 4);=0A=
+        trace_aspeed_sbc_ecdsa_hexdump(desc, i, str->str);=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The hardware only supports ECDSA secp384r1 (NIST P-384). The firmware h=
as=0A=
+ * already staged the public key, signature and digest in the SEC SRAM; re=
ad=0A=
+ * them out and defer the actual verification to the crypto backend.=0A=
+ */=0A=
+static bool aspeed_sbc_ecdsa_verify(AspeedSBCState *s)=0A=
+{=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa.curve_id =3D QCRYPTO_CURVE_ID_SECP384R1,=0A=
+    };=0A=
+    g_autoptr(QCryptoAkCipher) akcipher =3D NULL;=0A=
+    uint8_t pubkey[ECDSA_P384_COORD_LEN * 2];=0A=
+    uint8_t sig[ECDSA_P384_COORD_LEN * 2];=0A=
+    uint8_t dgst[ECDSA_P384_COORD_LEN];=0A=
+    Error *err =3D NULL;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: ECDSA secp384r1 is not supported by the crypto =
"=0A=
+                      "backend\n", __func__);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QX,=0A=
+                           MEMTXATTRS_UNSPECIFIED, pubkey,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA QX from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QY,=0A=
+                           MEMTXATTRS_UNSPECIFIED,=0A=
+                           pubkey + ECDSA_P384_COORD_LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA QY from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_R,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA R from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_S,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig + ECDSA_P384_COORD_=
LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA S from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_M,=0A=
+                           MEMTXATTRS_UNSPECIFIED, dgst,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA M from SEC SRAM\n",=0A=
+                      __func__);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_SBC_ECDSA_HEXDUMP)) {=
=0A=
+        sbc_ecdsa_hexdump("pubkey", (char *)pubkey, sizeof(pubkey));=0A=
+        sbc_ecdsa_hexdump("signature", (char *)sig, sizeof(sig));=0A=
+        sbc_ecdsa_hexdump("digest", (char *)dgst, sizeof(dgst));=0A=
+    }=0A=
+=0A=
+    akcipher =3D qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PU=
BLIC,=0A=
+                                    pubkey, sizeof(pubkey), &err);=0A=
+    if (!akcipher) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s\n", __func__,=0A=
+                      error_get_pretty(err));=0A=
+        error_free(err);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (qcrypto_akcipher_verify(akcipher, sig, sizeof(sig),=0A=
+                                dgst, sizeof(dgst), &err) !=3D 0) {=0A=
+        error_free(err);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,=0A=
                               unsigned int size)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(opaque);=0A=
+    AspeedSBCClass *sc =3D ASPEED_SBC_GET_CLASS(s);=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -244,6 +365,26 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr=
, uint64_t data,=0A=
     case R_CMD:=0A=
         aspeed_sbc_handle_command(opaque, data);=0A=
         return;=0A=
+    case R_SEC_TRIGGER:=0A=
+        if (data & RSA_CMD_TRIGGER) {=0A=
+            qemu_log_mask(LOG_UNIMP,=0A=
+                          "%s: RSA is not supported\n", __func__);=0A=
+        }=0A=
+        if (data & ECDSA_CMD_TRIGGER) {=0A=
+            if (!sc->has_ecdsa) {=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "%s: ECDSA is not supported\n", __func__);=
=0A=
+                return;=0A=
+            }=0A=
+            s->regs[R_STATUS] &=3D ~(ECDSA_VERIFY_DONE | ECDSA_VERIFY_PASS=
);=0A=
+            if (aspeed_sbc_ecdsa_verify(s)) {=0A=
+                s->regs[R_STATUS] |=3D ECDSA_VERIFY_PASS;=0A=
+            }=0A=
+            s->regs[R_STATUS] |=3D ECDSA_VERIFY_DONE;=0A=
+            trace_aspeed_sbc_ecdsa_verify(=0A=
+                (s->regs[R_STATUS] & ECDSA_VERIFY_PASS) ? "pass" : "fail")=
;=0A=
+        }=0A=
+        return;=0A=
     default:=0A=
         break;=0A=
     }=0A=
@@ -306,6 +447,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error=
 **errp)=0A=
         }=0A=
     }=0A=
 =0A=
+    if (sc->has_ecdsa) {=0A=
+        if (!s->sram) {=0A=
+            error_setg(errp, TYPE_ASPEED_SBC ": 'sram' link not set");=0A=
+            return;=0A=
+        }=0A=
+        address_space_init(&s->sram_as, s->sram, TYPE_ASPEED_SBC ".sram");=
=0A=
+    }=0A=
+=0A=
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,=0A=
             TYPE_ASPEED_SBC, 0x1000);=0A=
 =0A=
@@ -325,6 +474,8 @@ static const VMStateDescription vmstate_aspeed_sbc =3D =
{=0A=
 static const Property aspeed_sbc_properties[] =3D {=0A=
     DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),=0A=
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
+    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)=0A=
@@ -355,6 +506,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *=
klass, const void *data)=0A=
 =0A=
     dc->desc =3D "AST10X0 Secure Boot Controller";=0A=
     sc->has_otp =3D true;=0A=
+    sc->has_ecdsa =3D true;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_sbc_types[] =3D {=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index bbec0d2178..735d11d447 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -95,6 +95,8 @@ aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%=
" PRIx32=0A=
 aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling com=
mand 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"=0A=
 aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr =
0x%" PRIx32 " value 0x%" PRIx32=0A=
 aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr=
 0x%" PRIx32 " value 0x%" PRIx32=0A=
+aspeed_sbc_ecdsa_verify(const char *result) "ECDSA verify done: %s"=0A=
+aspeed_sbc_ecdsa_hexdump(const char *desc, uint32_t offset, const char *s)=
 "%s: 0x%08x: %s"=0A=
 =0A=
 # aspeed_scu.c=0A=
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" P=
RIx64 " of size %u: 0x%" PRIx32=0A=
-- =0A=
2.53.0=0A=

