Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DC6CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsji-0003Ka-0x; Sun, 31 May 2026 22:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjf-0003I5-D7; Sun, 31 May 2026 22:50:39 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjd-0002en-OH; Sun, 31 May 2026 22:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIWqjAq9GEhhzf91mMz6e1Bq23f7eSW/SfFJcrSvUC68itLqbC/5/AZRnBvkjJG0wASfZu3ls5g851m6UrsoQZPg+os4C9Y7Kc9LjitWJ0UyfuAH/b3nhc3/niqjbZA/IA5xWhwip292Vu2uWukobsOoiLP7PGKeZMmQU0IMDtOsCetUO/tMflNS+wH644IC0llqLqGIjS4MJi+j+3TBb3FQDNTjK8V5vhpssYGFETO4eqn6qrS/6Sk4s53DPENKdtukjUVRHb5XGJBI3ZRS63xpYY7nnBAPMM6FyotYQh2EiRRYNHqXJaIwlFtrtFXCsFWXIo3lNK9/k2vCKvs9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU8kNaJTRysVTpRhbiGvxkkftAdbd53adQU7zl5aMYY=;
 b=amkcmLpEaXZL/gu+y3VoIguxgtedta0sumFc++FlZLN1JR61yTObT7kf3SRm2kd/5ymUxFaJAhBCdgemKDmm5PZF6J7OI9RPMByZfR1wVhF3GNQoM0ZKc66+BJBfNQvF4KLf3x5SfWtBWIr6dDKKMpdyXnSeqG8bMzXY4rcSsxuGRUCP6cjqbnLr4yW6QKazJ3FoyXpRzWPr/5tuAba0gftQIReCO5r/ZGY0GUlyPniuWGUxblIN7c/6QE9mL/UvO3mnMH1+kUGo5S7zvGQcGpam79MfohzZJHJ4nriIH0riosZhIopYnI5hTfrQXZC/Uf68f8XMLkkhCZ5OTS6BtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU8kNaJTRysVTpRhbiGvxkkftAdbd53adQU7zl5aMYY=;
 b=ndDHH/MzV2mprVpmXaGjzd71gtXtmR0hcDlPE2iGyZe4AJVGvNIU8n0GCy35lolRSjoXsEJK7WTVWWUhJMgwAdoSZsGWXWp1dNJ+vkbjtdQg50Mz61GbcYbhFNhkHMHLvwFv+gdbmPiLxuz7c6rr8Q4CU7elMsX6cazDsWZrmQglQlmu94+PQxv9HpMbPTqLqLQklKFIqakTOtcK1QozC83hK6QWEKk+kUIVWxF7YvYS3Y8IVOw12EyEGhn3DeRsDwm++Kce7zG9oLvJxs6Ot8jjxSE8es+RHVSLp25UwYmFDEjiSnQshDhiCJoyy2yi9NOnqcaI8dT+Dw8m6cNVcA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 15/24] hw/intc/aspeed_vic: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 15/24] hw/intc/aspeed_vic: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFkTayCM1ovIUeDeezKh+AjVQ==
Date: Mon, 1 Jun 2026 02:50:23 +0000
Message-ID: <20260601024959.2347639-16-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: 0b3b5542-8b71-4875-69e0-08debf888723
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: uf3gc7CWequPtSTk47W2yrPyMphL6kYPJsd5ODNbO4hfQ9jO/F6vhmCnF4snN1d1j9s1TYXI2r+FFvYziVbZoSNZlIQNbdNU4i4LczDkmDci1lrfntwtmdXuP91ivmyObIs0t5WhlfkVLwexljcGkBQgpldbN/iTSpWPgEbqO9qwu5bW9NJIwTXhs66LFSP79diOOe/I4MwNeTMFdPYdHkBrq94rSFTiNjDDxWFGl6+/KjDFjTp7tc+2uX+Py8U4bZMTPjPQznMyjDtyoMPDGrajTnB+GhtOW7hSAsxKHLhESsxlqooLnkpuj5ue/XUo8YhGzmSZiqxM4cLq/rLmjVaKsnFqyIyf6FABY3hhQa2AtLRequ3nWLr6+zXkru2k0Y/WR9QBJcXqXdBND3/Jp3JVWfzMg3vHN4nA0+pQG7uR6w9O8Is0tbNd8nwNR7DVd9ctzbfDCR/E4ZvqfXLDoTby7ttQXwcPSCXldfc4jcaiJsU8Ab0m/5iSh9uZhfTAlcYtIDzhzB74Jl/Ri1mpIYfxUegfEY59XUjHYmLYGJ/Tzh9RI0hP9BKs9Qp3JBS+QU1A2G4z0e119i2kc+hwHEm9fW6tSjYZGEILfegrU9Bgmt5C0FqYieIj0O3yNZMNWuAA7jmG3noP6elLuDdLNHCiX1yq9qU6zlUgiZw5UYHpWgPMCpz9MYs+AYrCntUwlJUAAblDczPTURdYv0pFeQ8zSZtci6xwpS4oz7wHNQWZ1/pHTvY4px51p6WwPMvEIOFpgjv7ukdsMmSg5Ei4mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EUVRFt+9pDtzv5cOLZT/T12k3AUGmMenx1nU2GW239RURCeNQg0rZscOa2?=
 =?iso-8859-1?Q?0BXTct8TqsqoOYeD+WPbYkxvfYCxpdGm+h5THo6mM2lhC/MeZTF0PIlSWt?=
 =?iso-8859-1?Q?2q/+/CDVDG/5KRB+7yd+0yIVdBLex1fCe9ttvzN1AqWbi+VaMWluJSmgV5?=
 =?iso-8859-1?Q?pv0KZr6m0TAOc6HhsqOP5qfKgZUk5l9sCiZGl3nW31jhkVlg6TBIBgi4tG?=
 =?iso-8859-1?Q?ejlhi6PEnijxjTdZb+VZapuF+zhfdHoBkiYz36+7ACZck2hnVIlb0vylTg?=
 =?iso-8859-1?Q?/n5xC/nK9FOGJLoNiLswZ0aXCyww84mtYjel7umzlsx3v6HEoW+uNe1pF+?=
 =?iso-8859-1?Q?Fv/SQxwH8fWdDySnLEqcV3Ju6u/jcNor8+6UPeFHiF9cmfsLJJPHbaHi0/?=
 =?iso-8859-1?Q?643gHmcXfNKfxzGlTT4QieNvAzpC+RxjC97GE/ZQ+ztpQR7eTxbdjkt5UB?=
 =?iso-8859-1?Q?bQuAMkiZaIgTnCtZHS/mI1sVaKhkrxC954nWnt3rY/Ynpsbdq7CKbOKht4?=
 =?iso-8859-1?Q?LcZjMW2shAPiVBZAswSxP5Q2vn1PzQ8QTM46CO1lNp5SE82N1gxezl6+WE?=
 =?iso-8859-1?Q?D/IU8nlLcH5Wzy0KHNF9QeIYQtsOR7SsHP+EKTHVz7Q5Bja4L2DMJm8M2m?=
 =?iso-8859-1?Q?Hfz307sRgNylN7iSJ8G4EZEmgmV1xalmmVIcO1kw0H9Emdj8BZogB4wBKX?=
 =?iso-8859-1?Q?e/VfWt1ab5Slec8zKhS6rDu1sL5MBdgmUprXkxcyJ7Gs1uHPXX1hOkPvnO?=
 =?iso-8859-1?Q?8gHo37esHW5+mdIN671bedVxcY3HDRjuFncNIVHqN/CgMKzta33js2aCtC?=
 =?iso-8859-1?Q?5GafP2MSR+52mZvAwAPLKY6lcYYfyqwUPsZu6N9SV08kIH2JcM4aGeHiia?=
 =?iso-8859-1?Q?qpHtbssqP/X14pmxO3YqVWmnuUqqKjCCpxCEOXEmt8S1tWmahdzvyeXEyc?=
 =?iso-8859-1?Q?rXc37I0ORw5A11ONsJVYUELNfSrOCR7TDhu63Envsrc8odQ7g9eZG+mYnG?=
 =?iso-8859-1?Q?d/64BTZTwOY2lH88n5mzuID88Gi1X86bh1sneFFDXLa0R9DJzoNi+jUfEs?=
 =?iso-8859-1?Q?8vIReZ1RKhIxXqF1uD/YTsFgE3zIl3pJXnzeUNsNzdIViHjmU+/AmJNJHI?=
 =?iso-8859-1?Q?E/u8+IstQ4JloGrs5iEMktJgOwksg4djxEfb5PMqN3TYD0lueWENr66+aN?=
 =?iso-8859-1?Q?uDwL51p8QnWL5GMXA1qJcYbF3F9RRxt6TnoWSuhgIx8zW/dODE+8va5o9Y?=
 =?iso-8859-1?Q?FqEabX0Oor6y65U8SN0rlRb/SqYK1rY4NXEaslto85ZV3EhLVMj40xp/4K?=
 =?iso-8859-1?Q?7Jv/aqATieSbs/uF/xGkjD6fG61Kru+CbFpQ+weYGgtCyF3G0eCJPtAbOd?=
 =?iso-8859-1?Q?/SRSTSZbYYs7qA01E1+QK0eCA6dlLcuLp8P+1I7IA8SVRL0eH0ZXqWvwar?=
 =?iso-8859-1?Q?ks4u9SxsE0/BO8366zs6kNmHyViNEkNOCmaI2EM1lbM8Cf65+lsOfTEGfT?=
 =?iso-8859-1?Q?ozATo4F4HvCLl9xGRlVt4V+YXrGPJ5o9HlSxVL2IjAwsCJyXl+lMwuYoJk?=
 =?iso-8859-1?Q?W80ijQ0y2NQ52nO0Q7jBRFFsL8PVBmRdTLjDV4QaNpaAPjIIGDXOVGrLNu?=
 =?iso-8859-1?Q?D8SfXLj+pKQKmofvMa4DVyLBaKnPYATSp1gLGAbjtpowJxcD9jqrIUeOBL?=
 =?iso-8859-1?Q?UOTJ+jTG9sakR0Vd79fxxRiCMEsyzuTQe/O0uEgq8r2qiUaJnJj1jockRd?=
 =?iso-8859-1?Q?pKFE0+oU7vTf5LIZGQSY3jlITsL2gE0u+yEv43cnGugqmTGLSRzqdJ7faj?=
 =?iso-8859-1?Q?Pi7t2sruhQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eGkN3GjE45aEb5qba9AMrp/TTdLUhY9hajWx6DJMp3ajxaykZdgE+OellaZ783469juf0rkwOWOKSvqE3IxMW3I1QGuN+rbfSGuIgVQImwCi+aCXpLzaLXKfDXs8DnP2siBc4r7X9p+QeFQhdDO+qIKoNSwqFmLH4ReV4w04wByryInpG1zX0gfUK6ia4k5fZZ1JbKW9QAkwST/DwvP6IRxyeETDnWBcdhsJBAJfBmPQ0jxqnQmOS4AAc54r84WJ4m3R7QNG2P/9xhQpeMHauvt11CeuKaMSo3GeZix/7NQqqigkwP4Yh13TiP3Z/VTL8mZBHyGNsaNeRtqQ5W+1BA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b5542-8b71-4875-69e0-08debf888723
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:23.6343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQl/C+tqolQqtEEkShTaDefH81c87nj3tw4s+1+n0JH454TZWCTHud3OSa20L5fDXp5+1kcDLD/22lGZ3bxqkYffL+x2Kz7NzG/0kAiCsjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline the standalone 'aspeed_vic_info' TypeInfo variable directly=0A=
into the 'aspeed_vic_types[]' array, removing the need for a separate=0A=
declaration.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/intc/aspeed_vic.c | 19 ++++++++-----------=0A=
 1 file changed, 8 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c=0A=
index 13d8423d83..bd0c87802e 100644=0A=
--- a/hw/intc/aspeed_vic.c=0A=
+++ b/hw/intc/aspeed_vic.c=0A=
@@ -349,16 +349,13 @@ static void aspeed_vic_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_vic;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_vic_info =3D {=0A=
-    .name =3D TYPE_ASPEED_VIC,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedVICState),=0A=
-    .class_init =3D aspeed_vic_class_init,=0A=
+static const TypeInfo aspeed_vic_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_VIC,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedVICState),=0A=
+        .class_init =3D aspeed_vic_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_vic_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_vic_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_vic_register_types);=0A=
+DEFINE_TYPES(aspeed_vic_types)=0A=
-- =0A=
2.43.0=0A=

