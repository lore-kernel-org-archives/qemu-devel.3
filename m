Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B25ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhY-0003Zo-Ud; Tue, 14 Apr 2026 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhW-0003Xi-36; Tue, 14 Apr 2026 04:00:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhQ-0005mG-Or; Tue, 14 Apr 2026 04:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyWHAQHqLN4zLVLlYuZn/2VTd0acyS8KvfAAYrtd28TOMMXkyQ/NsoQYmMAMavkIvkimXmZM5Z+soBjGUZ+uZNuVkVqSwACbpAcXqo2WuIz9+w8+M3HmQ4CoNSzfiPA99kpSQ1rDUHgmjokjs9V4dzrtnSUVcL6kCw6bQpKoMPocXvxod0yux85F8a2daK6k1VR7iUAHSQp8QEAgogm/CUm0q89ULnfz2C7Ql+c4yqS8eGgbmpbH0i7ypDWIF4s3SlajeGM5JpKeclTE30F0Znr9Qg+7OzbDHpiNeAezBe3P4JfvxxrMKGT8mIM6rjgfS2ie8x/couoX3/9uydPUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCVYDin/aI2j3cdnv7i8SYpme0GrUJ0vo7kGdjFa8Bs=;
 b=vqYimjFGhOt53R2+AmDWrU9viwR269O6Dzp6ophOniaH4lrZulvc3YZBSPJXDyphSR1A9vTe2HtwT+2KSEEfo5hEYu9yuRjrilqnlLUOGM7HRnYl3S6HW2YiO3j+t7QAAXJk9P7E2xn+exKOj5SyPR8kIdushPIQb/HxzCLsGgdK8NSItzcrGiXEfK3tKPECHBRi6UYIjoapRT5vBYgMC0ViRmRTCBkt6D/L3Amiv2fri9abBXVCmWd284Run3FizoiVk6xGvL788vP8JUPQUGmTWnxzwzyhGNvil8LBm18ivLvPqW2fyfsUcxKo1+3FPxX0AF+gmxo2GPZ8YI8GYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCVYDin/aI2j3cdnv7i8SYpme0GrUJ0vo7kGdjFa8Bs=;
 b=McGoGWTYdKK2jovOXuIf1wErc1BlgM6Dl+ccBn+2SU79A2r/xSTG8XPmtCbEp4UKxFJ3VzIIVBCC8QgdJkmuPD1VgHwzg0Qobu2j68Owzvth1cVt504enbmRrEezQHVbDgJ3mpVLyLf0GnxsDHdlmTZ5H5y/IcU454hPiH4ZcvsZg6tf34Qjo2v9F29BK8u9hI9eXqzkFRE66sQfTOGgZFxU38dIBqR/i6c1+HUAO06GNGQQcDJvmckclHqIQpQ4lzsseBGXEVnHwUlEauNT4O4u/8Fvl7R36uTLj/S2nzw5c5Egdnl9Xp10lMQB5HNJaEhVozb/OtYCKDk/hdTh8Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 03/17] hw/usb/hcd-ehci.c: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v2 03/17] hw/usb/hcd-ehci.c: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHcy+TDy0vA1uWMN0SiUxPy+4xIQQ==
Date: Tue, 14 Apr 2026 08:00:29 +0000
Message-ID: <20260414080025.3005916-4-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6745:EE_
x-ms-office365-filtering-correlation-id: 6761a910-219b-423e-6d14-08de99fbe582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003|18096099003;
x-microsoft-antispam-message-info: dIuRUMxPbsZ4Q4U1VXBkkxNMmOHac7SzELi/UA8eprneLW44C8IGO6TrAEwoBFpqJyXK7DZT5HDTat/iA7NjWjDHhTdS+6yiR/mzTRFMCgfdUj9Qk9SdzocxcjO78FRdlOuyTAoocjhjTmkSQBmFgbj9qU4vLohBrKuGvsJrTb8IX1W0oiOC4kZFVKWJ0b8QlgBztu/YegfZXB0freWMRQijis0S5UfVjjggiFBJJGVyLJ2amI369M/hW+/x9hLrE17gpGmOP/kcAF29mzinbLV7sGLibT99vHcbV1ZJzDoMbvil+H83V3CiM35ofkOtfPQBFgluursXhHBxh7nZ5nj7QqUgB2D0/LsXcoJu9lFjKyd6v0jIDDhyw8BDefz0Z7qkKcg9uLmq2TJXzGfw0wCAMRWNZEPH9K+YqUZAxDQnoaj9OP0w2e+WMz3JfiSR/tzLYReFQBh3ZMrJOnY8lXW0IOo+5EXPQY0rK9bhLaqwnIuDeQpyKnGbiIRa6vpZhWqTQT8vyhRvh942CNNvZ7JOFaXOQoVQnVBNEmVDO9ARhpOCxdvr1Y3ZQt3dmORk2Sqgi1hAxpOR3nwVmZwvuthg1mr+SJ0JQYXiKJDLQWmWwPtXvrj/jXLaqqbkAQ2bTH2FNgebFiNnn+pRguBe9+DuSHsqndvYgWX/dSUzRzsMJrfgfp27r7lmdN9TnYd3FWDkI9RXZl6UZ4YiWAyQeEMzx9aZP8JOudcY40CWUamtA9D7Sxprg883NsCvKW1aLOL6nvLOshqoWTW+myFxzZpPj/BHt7pu0qK5NQZ6Zf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(18096099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CNQKpaobNnriYU0fKtBVFRpLN1YXJMoIi7JBZ3RxfCCUsp4FDGyB6Pk8aH?=
 =?iso-8859-1?Q?mOG9M1uynGQkblq2xrMC329NoulmTsbKmoINmha/H8ZVRnMWoLB90AywI4?=
 =?iso-8859-1?Q?f13jTomz0aCLgEnnQaodjecQlDr0HErwoRztS0/rc56V0OCCvhIl8+oVM1?=
 =?iso-8859-1?Q?FGFODwsqB3T6jyUotaD+ZcwPNac8mW/b2VfDFHgkDLiS+5d8dLLi8f6fQ+?=
 =?iso-8859-1?Q?BwdKacNSOoK8YrXC0RX3j9IOILfY7IxEc5VPkg+VIRUmz9X0h09xW9f3EL?=
 =?iso-8859-1?Q?wSfiGhE46ztk9TR0oEWo8xfQIG222nyi2UJclruS555TWOd+pMHfwvEOi9?=
 =?iso-8859-1?Q?zynOTFaT2tQJNlnurNpz3ucmxY3NvgMvZeZr03ClO2loWNgwadmPZSCg6C?=
 =?iso-8859-1?Q?LucWFVX7fd1OFAmH0PIcK+pJXsOWa/F99LyoAZ3MBhgQ/RZdzKZT1TIEjp?=
 =?iso-8859-1?Q?mMHX/cbylmz21lKK4g7o+lylZgL6ehFeqe285auyr8i2czBgVBky8lYW+b?=
 =?iso-8859-1?Q?GJIGuJIl7bnKlMlv/2Fs01iAYcL1+Jp9OI9LgOcTurQFxz3MvQ2b/DNJdJ?=
 =?iso-8859-1?Q?eRB6VOX8Qbwf91wYNsBIvs6Su/heDtfctYUVkVMi7Zx+XK5zXPyTUCmPQX?=
 =?iso-8859-1?Q?VeKn3tHNgAAQ/YNWi635rgDgX2nIaIqW8bdS5EqCr3OGSpVqZb6wNA+6XT?=
 =?iso-8859-1?Q?rG1pSLtyeVsomewmyyHn+l6qmo6NOVFphX6eebgRzkOIGtDvywcJuehuYz?=
 =?iso-8859-1?Q?U+OvywGOxSOtwuuSqYHzslOKdZZBThLoYzUgkuBWaIqZyP2/8i1fUhoebS?=
 =?iso-8859-1?Q?1npQ/E/1VP09Ify68lJSPXW8K6BpGxdPWkWNdK/gQHNz5TGmCqeKMHjYYi?=
 =?iso-8859-1?Q?Rj5zDV73sxqkrSTBfRXtcUhuRWDF8gyu/OBBJl8nd7RLnFRn+hi5A+rDia?=
 =?iso-8859-1?Q?aLZK016n3Derq7rJsp0d4cYVX0Nj1r/JasaSzD1ojznQuE8Pmj6212+fJo?=
 =?iso-8859-1?Q?8G7AhOpCwkjQ/8lHOXEMFqFGwCpJp+s/1rxxEK1Lt3LMileckSRFLgg/5U?=
 =?iso-8859-1?Q?yTAXE+dASdU7aSjy23QhyMU9uuq1ASBC6xZn4BK4fcaK1T/S/DWGfURmFI?=
 =?iso-8859-1?Q?3IUARCF5eXNs1Mj9LH7MyktEFenZmq2zxhFJ72smxuXYyE6SAZphIWglI3?=
 =?iso-8859-1?Q?6OQk9pEXF493B9rs9YnmlzX4I/+2WuUEQAo4R8nc6gmx7WvHR/Bsy+Dux5?=
 =?iso-8859-1?Q?xVMcQaOvpoUkWBbh0QjDM/N0Ft3zuuoc9xYyfADQr6QV9CAHPixY6wZXr7?=
 =?iso-8859-1?Q?REWZRx7YbSivCZc9C4falM0Xcb9jCm45TyXCHP3yN3AfUaDbYIHqLtJv2y?=
 =?iso-8859-1?Q?niYZl50V9Pb8jNmvkI2p9PJq/qQZNiD3je2MH/tz3US9Eo0DnBHtv75BoN?=
 =?iso-8859-1?Q?zFnT2lP8p2i3TPGfPryMbbAKOnLS7EyBbWn+Sws7znd4Hic68TSz2uPmhY?=
 =?iso-8859-1?Q?VldyROItYsvKsybWmbwszG8r4tCtq2yPU8YCQQoAYda/vPptUTUL9yVz3F?=
 =?iso-8859-1?Q?ciqKt93QzeBT/sA+5K5//NW+Ffx9d2ne1+A0p9AIwuZ1gkyS3fmMkNOzXW?=
 =?iso-8859-1?Q?4i3AvJJBa4XsOxIcd2EPQaEzRJ7bqnjflFF8IZylpm3d7oqFpLQIIJR3J1?=
 =?iso-8859-1?Q?bYQHk/3G3meOoPH9W28S96Kpr/aOF8EENCNmDA84LtINHSr2aORcMlYG3t?=
 =?iso-8859-1?Q?3LRYPxK2L6qdLkC+vMF9neU1fPyhGIDVMr2gwr4KlnlsHYSkvsHUsd0cvq?=
 =?iso-8859-1?Q?29cgPJ4P+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v6P07gQwZrZx+vmzpYVFAjm+Dnrk09kvWn+2pIDLjm8gggKdHcWeW/lPSy2Z44gwlsXIM39EX0gCf1NG/zA9B0bzJQ2pxs04ekuPe0/eznvrnT2m70KaTEcTfh3wik1+8wY2f5STOZ/aDw5BgvzHHW65suwKXUz/jm9aYfZYPf1TWU898Bb9V+EoxtC7y3HytaDsgiaeg+MARgFp9MR4tgerWpi3FhsKKrZZeL+vPxiHF9YjfmCX/xH5gfzFf0tu101AVT8D0yM6vS4n1CasxkrdQARakULiOBHTS2CfCNeAHgWoy8HgBFDHVxZANIB0jsm/GKSKM8TlWuUc7Dl/Mg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6761a910-219b-423e-6d14-08de99fbe582
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:29.9379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdFzTXSkwqLzTQKTYMzLg8SJyquUOZQj1pCh+nJivJVfUynwo1eHtxM6eoLtTHadUZEbDwTfYzS5jRCt9LFczLZkDo+IHurhZ8QN62ev1Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6745
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

No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 126 +++++++++++++++++++++++++---------------------=0A=
 1 file changed, 69 insertions(+), 57 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 5ea8461f70..9b92384bac 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -41,21 +41,23 @@=0A=
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)=0A=
 #define UFRAME_TIMER_NS  (FRAME_TIMER_NS / 8)=0A=
 =0A=
-#define NB_MAXINTRATE    8        // Max rate at which controller issues i=
nts=0A=
-#define BUFF_SIZE        5*4096   // Max bytes to transfer per transaction=
=0A=
-#define MAX_QH           100      // Max allowable queue heads in a chain=
=0A=
+#define NB_MAXINTRATE    8      /* Max rate at which controller issues int=
s */=0A=
+#define BUFF_SIZE        (5 * 4096) /* Max bytes to transfer per transacti=
on */=0A=
+#define MAX_QH           100      /* Max allowable queue heads in a chain =
*/=0A=
 #define MIN_UFR_PER_TICK 24       /* Min frames to process when catching u=
p */=0A=
 #define PERIODIC_ACTIVE  512      /* Micro-frames */=0A=
 =0A=
-/*  Internal periodic / asynchronous schedule state machine states=0A=
+/*=0A=
+ * Internal periodic / asynchronous schedule state machine states=0A=
  */=0A=
 typedef enum {=0A=
     EST_INACTIVE =3D 1000,=0A=
     EST_ACTIVE,=0A=
     EST_EXECUTING,=0A=
     EST_SLEEPING,=0A=
-    /*  The following states are internal to the state machine function=0A=
-    */=0A=
+    /*=0A=
+     * The following states are internal to the state machine function=0A=
+     */=0A=
     EST_WAITLISTHEAD,=0A=
     EST_FETCHENTRY,=0A=
     EST_FETCHQH,=0A=
@@ -71,13 +73,13 @@ typedef enum {=0A=
 /* macros for accessing fields within next link pointer entry */=0A=
 #define NLPTR_GET(x)             ((x) & 0xffffffe0)=0A=
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)=0A=
-#define NLPTR_TBIT(x)            ((x) & 1)  // 1=3Dinvalid, 0=3Dvalid=0A=
+#define NLPTR_TBIT(x)            ((x) & 1)  /* 1=3Dinvalid, 0=3Dvalid */=
=0A=
 =0A=
 /* link pointer types */=0A=
-#define NLPTR_TYPE_ITD           0     // isoc xfer descriptor=0A=
-#define NLPTR_TYPE_QH            1     // queue head=0A=
-#define NLPTR_TYPE_STITD         2     // split xaction, isoc xfer descrip=
tor=0A=
-#define NLPTR_TYPE_FSTN          3     // frame span traversal node=0A=
+#define NLPTR_TYPE_ITD           0     /* isoc xfer descriptor */=0A=
+#define NLPTR_TYPE_QH            1     /* queue head */=0A=
+#define NLPTR_TYPE_STITD         2     /* split xaction, isoc xfer descrip=
tor */=0A=
+#define NLPTR_TYPE_FSTN          3     /* frame span traversal node */=0A=
 =0A=
 #define SET_LAST_RUN_CLOCK(s) \=0A=
     (s)->last_run_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
@@ -88,10 +90,10 @@ typedef enum {=0A=
 =0A=
 #define set_field(data, newval, field) do { \=0A=
     uint32_t val =3D *data; \=0A=
-    val &=3D ~ field##_MASK; \=0A=
+    val &=3D ~field##_MASK; \=0A=
     val |=3D ((newval) << field##_SH) & field##_MASK; \=0A=
     *data =3D val; \=0A=
-    } while(0)=0A=
+    } while (0)=0A=
 =0A=
 static const char *ehci_state_names[] =3D {=0A=
     [EST_INACTIVE]     =3D "INACTIVE",=0A=
@@ -472,8 +474,10 @@ static bool ehci_verify_pid(EHCIQueue *q, EHCIqtd *qtd=
)=0A=
     }=0A=
 }=0A=
 =0A=
-/* Finish executing and writeback a packet outside of the regular=0A=
-   fetchqh -> fetchqtd -> execute -> writeback cycle */=0A=
+/*=0A=
+ * Finish executing and writeback a packet outside of the regular=0A=
+ * fetchqh -> fetchqtd -> execute -> writeback cycle=0A=
+ */=0A=
 static void ehci_writeback_async_complete_packet(EHCIPacket *p)=0A=
 {=0A=
     EHCIQueue *q =3D p->queue;=0A=
@@ -733,7 +737,7 @@ static void ehci_detach(USBPort *port)=0A=
     ehci_queues_rip_device(s, port->dev, 0);=0A=
     ehci_queues_rip_device(s, port->dev, 1);=0A=
 =0A=
-    *portsc &=3D ~(PORTSC_CONNECT|PORTSC_PED|PORTSC_SUSPEND);=0A=
+    *portsc &=3D ~(PORTSC_CONNECT | PORTSC_PED | PORTSC_SUSPEND);=0A=
     *portsc |=3D PORTSC_CSC;=0A=
 =0A=
     ehci_raise_irq(s, USBSTS_PCD);=0A=
@@ -858,7 +862,7 @@ void ehci_reset(void *opaque)=0A=
      * Do the detach before touching portsc, so that it correctly gets sen=
d to=0A=
      * us or to our companion based on PORTSC_POWNER before the reset.=0A=
      */=0A=
-    for(i =3D 0; i < EHCI_PORTS; i++) {=0A=
+    for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         devs[i] =3D s->ports[i].dev;=0A=
         if (devs[i] && devs[i]->attached) {=0A=
             usb_detach(&s->ports[i]);=0A=
@@ -877,7 +881,7 @@ void ehci_reset(void *opaque)=0A=
     s->astate =3D EST_INACTIVE;=0A=
     s->pstate =3D EST_INACTIVE;=0A=
 =0A=
-    for(i =3D 0; i < EHCI_PORTS; i++) {=0A=
+    for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         if (s->companion_ports[i]) {=0A=
             s->portsc[i] =3D PORTSC_POWNER | PORTSC_PPOWER;=0A=
         } else {=0A=
@@ -942,8 +946,9 @@ static void handle_port_owner_write(EHCIState *s, int p=
ort, uint32_t owner)=0A=
     uint32_t *portsc =3D &s->portsc[port];=0A=
     uint32_t orig;=0A=
 =0A=
-    if (s->companion_ports[port] =3D=3D NULL)=0A=
+    if (s->companion_ports[port] =3D=3D NULL) {=0A=
         return;=0A=
+    }=0A=
 =0A=
     owner =3D owner & PORTSC_POWNER;=0A=
     orig  =3D *portsc & PORTSC_POWNER;=0A=
@@ -988,7 +993,7 @@ static void ehci_port_write(void *ptr, hwaddr addr,=0A=
         trace_usb_ehci_port_reset(port, 1);=0A=
     }=0A=
 =0A=
-    if (!(val & PORTSC_PRESET) &&(*portsc & PORTSC_PRESET)) {=0A=
+    if (!(val & PORTSC_PRESET) && (*portsc & PORTSC_PRESET)) {=0A=
         trace_usb_ehci_port_reset(port, 0);=0A=
         if (dev && dev->attached) {=0A=
             usb_port_reset(&s->ports[port]);=0A=
@@ -1065,8 +1070,10 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
         break;=0A=
 =0A=
     case USBSTS:=0A=
-        val &=3D USBSTS_RO_MASK;              // bits 6 through 31 are RO=
=0A=
-        ehci_clear_usbsts(s, val);          // bits 0 through 5 are R/WC=
=0A=
+        /* bits 6 through 31 are RO */=0A=
+        val &=3D USBSTS_RO_MASK;=0A=
+        /* bits 0 through 5 are R/WC */=0A=
+        ehci_clear_usbsts(s, val);=0A=
         val =3D s->usbsts;=0A=
         ehci_update_irq(s);=0A=
         break;=0A=
@@ -1131,8 +1138,7 @@ static void ehci_flush_qh(EHCIQueue *q)=0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
 }=0A=
 =0A=
-// 4.10.2=0A=
-=0A=
+/* 4.10.2 */=0A=
 static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 {=0A=
     EHCIPacket *p =3D QTAILQ_FIRST(&q->packets);=0A=
@@ -1145,8 +1151,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
     assert(p !=3D NULL);=0A=
     assert(p->qtdaddr =3D=3D q->qtdaddr);=0A=
 =0A=
-    // remember values in fields to preserve in qh after overlay=0A=
-=0A=
+    /*  remember values in fields to preserve in qh after overlay */=0A=
     dtoggle =3D q->qh.token & QTD_TOKEN_DTOGGLE;=0A=
     ping    =3D q->qh.token & QTD_TOKEN_PING;=0A=
 =0A=
@@ -1170,7 +1175,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
-        // preserve QH DT bit=0A=
+        /* preserve QH DT bit */=0A=
         q->qh.token &=3D ~QTD_TOKEN_DTOGGLE;=0A=
         q->qh.token |=3D dtoggle;=0A=
     }=0A=
@@ -1397,9 +1402,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
     return 1;=0A=
 }=0A=
 =0A=
-/*  4.7.2=0A=
- */=0A=
-=0A=
+/* 4.7.2 */=0A=
 static int ehci_process_itd(EHCIState *ehci,=0A=
                             EHCIitd *itd,=0A=
                             uint32_t addr)=0A=
@@ -1411,13 +1414,13 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
 =0A=
     ehci->periodic_sched_active =3D PERIODIC_ACTIVE;=0A=
 =0A=
-    dir =3D(itd->bufptr[1] & ITD_BUFPTR_DIRECTION);=0A=
+    dir =3D (itd->bufptr[1] & ITD_BUFPTR_DIRECTION);=0A=
     devaddr =3D get_field(itd->bufptr[0], ITD_BUFPTR_DEVADDR);=0A=
     endp =3D get_field(itd->bufptr[0], ITD_BUFPTR_EP);=0A=
     max =3D get_field(itd->bufptr[1], ITD_BUFPTR_MAXPKT);=0A=
     mult =3D get_field(itd->bufptr[2], ITD_BUFPTR_MULT);=0A=
 =0A=
-    for(i =3D 0; i < 8; i++) {=0A=
+    for (i =3D 0; i < 8; i++) {=0A=
         if (itd->transact[i] & ITD_XACT_ACTIVE) {=0A=
             pg   =3D get_field(itd->transact[i], ITD_XACT_PGSEL);=0A=
             off  =3D itd->transact[i] & ITD_XACT_OFFSET_MASK;=0A=
@@ -1513,8 +1516,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
 }=0A=
 =0A=
 =0A=
-/*  This state is the entry point for asynchronous schedule=0A=
- *  processing.  Entry here constitutes a EHCI start event state (4.8.5)=
=0A=
+/*=0A=
+ * This state is the entry point for asynchronous schedule=0A=
+ * processing.  Entry here constitutes a EHCI start event state (4.8.5)=0A=
  */=0A=
 static int ehci_state_waitlisthead(EHCIState *ehci,  int async)=0A=
 {=0A=
@@ -1531,7 +1535,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     ehci_queues_rip_unused(ehci, async);=0A=
 =0A=
     /*  Find the head of the list (4.9.1.1) */=0A=
-    for(i =3D 0; i < MAX_QH; i++) {=0A=
+    for (i =3D 0; i < MAX_QH; i++) {=0A=
         if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,=0A=
                        sizeof(EHCIqh) >> 2) < 0) {=0A=
             return 0;=0A=
@@ -1564,8 +1568,9 @@ out:=0A=
 }=0A=
 =0A=
 =0A=
-/*  This state is the entry point for periodic schedule processing as=0A=
- *  well as being a continuation state for async processing.=0A=
+/*=0A=
+ * This state is the entry point for periodic schedule processing as=0A=
+ * well as being a continuation state for async processing.=0A=
  */=0A=
 static int ehci_state_fetchentry(EHCIState *ehci, int async)=0A=
 {=0A=
@@ -1674,7 +1679,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
 =0A=
 #if EHCI_DEBUG=0A=
     if (q->qhaddr !=3D q->qh.next) {=0A=
-    DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",=
=0A=
+        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\=
n",=0A=
                q->qhaddr,=0A=
                q->qh.epchar & QH_EPCHAR_H,=0A=
                q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1924,8 +1929,10 @@ static int ehci_state_execute(EHCIQueue *q)=0A=
         return -1;=0A=
     }=0A=
 =0A=
-    // TODO verify enough time remains in the uframe as in 4.4.1.1=0A=
-    // TODO write back ptr to async list when done or out of time=0A=
+    /*=0A=
+     * TODO verify enough time remains in the uframe as in 4.4.1.1=0A=
+     * TODO write back ptr to async list when done or out of time=0A=
+     */=0A=
 =0A=
     /* 4.10.3, bottom of page 82, go horizontal on transaction counter =3D=
=3D 0 */=0A=
     if (!q->async && q->transact_ctr =3D=3D 0) {=0A=
@@ -2036,7 +2043,7 @@ static void ehci_advance_state(EHCIState *ehci, int a=
sync)=0A=
     int again;=0A=
 =0A=
     do {=0A=
-        switch(ehci_get_state(ehci, async)) {=0A=
+        switch (ehci_get_state(ehci, async)) {=0A=
         case EST_WAITLISTHEAD:=0A=
             again =3D ehci_state_waitlisthead(ehci, async);=0A=
             break;=0A=
@@ -2115,21 +2122,20 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)=0A=
             ehci_reset(ehci);=0A=
             again =3D 0;=0A=
         }=0A=
-    }=0A=
-    while (again);=0A=
+    } while (again);=0A=
 }=0A=
 =0A=
 static void ehci_advance_async_state(EHCIState *ehci)=0A=
 {=0A=
     const int async =3D 1;=0A=
 =0A=
-    switch(ehci_get_state(ehci, async)) {=0A=
+    switch (ehci_get_state(ehci, async)) {=0A=
     case EST_INACTIVE:=0A=
         if (!ehci_async_enabled(ehci)) {=0A=
             break;=0A=
         }=0A=
         ehci_set_state(ehci, async, EST_ACTIVE);=0A=
-        // No break, fall through to ACTIVE=0A=
+        /* No break, fall through to ACTIVE */=0A=
 =0A=
     case EST_ACTIVE:=0A=
         if (!ehci_async_enabled(ehci)) {=0A=
@@ -2153,7 +2159,8 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
         ehci_set_state(ehci, async, EST_WAITLISTHEAD);=0A=
         ehci_advance_state(ehci, async);=0A=
 =0A=
-        /* If the doorbell is set, the guest wants to make a change to the=
=0A=
+        /*=0A=
+         * If the doorbell is set, the guest wants to make a change to the=
=0A=
          * schedule. The host controller needs to release cached data.=0A=
          * (section 4.8.2)=0A=
          */=0A=
@@ -2180,13 +2187,13 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
 =0A=
-    // 4.6=0A=
+    /* 4.6 */=0A=
 =0A=
-    switch(ehci_get_state(ehci, async)) {=0A=
+    switch (ehci_get_state(ehci, async)) {=0A=
     case EST_INACTIVE:=0A=
         if (!(ehci->frindex & 7) && ehci_periodic_enabled(ehci)) {=0A=
             ehci_set_state(ehci, async, EST_ACTIVE);=0A=
-            // No break, fall through to ACTIVE=0A=
+            /* No break, fall through to ACTIVE */=0A=
         } else=0A=
             break;=0A=
 =0A=
@@ -2210,7 +2217,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
         DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
                 ehci->frindex / 8, list, entry);=0A=
-        ehci_set_fetch_addr(ehci, async,entry);=0A=
+        ehci_set_fetch_addr(ehci, async, entry);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
@@ -2235,7 +2242,8 @@ static void ehci_update_frindex(EHCIState *ehci, int =
uframes)=0A=
         ehci_raise_irq(ehci, USBSTS_FLR);=0A=
     }=0A=
 =0A=
-    /* How many times will frindex roll over 0x4000 with this frame count?=
=0A=
+    /*=0A=
+     * How many times will frindex roll over 0x4000 with this frame count?=
=0A=
      * usbsts_frindex is decremented by 0x4000 on rollover until it reache=
s 0=0A=
      */=0A=
     int rollovers =3D (ehci->frindex + uframes) / 0x4000;=0A=
@@ -2315,8 +2323,9 @@ static void ehci_work_bh(void *opaque)=0A=
         ehci->async_stepdown++;=0A=
     }=0A=
 =0A=
-    /*  Async is not inside loop since it executes everything it can once=
=0A=
-     *  called=0A=
+    /*=0A=
+     * Async is not inside loop since it executes everything it can once=
=0A=
+     * called=0A=
      */=0A=
     if (ehci_async_enabled(ehci) || ehci->astate !=3D EST_INACTIVE) {=0A=
         need_timer++;=0A=
@@ -2334,15 +2343,18 @@ static void ehci_work_bh(void *opaque)=0A=
     }=0A=
 =0A=
     if (need_timer) {=0A=
-        /* If we've raised int, we speed up the timer, so that we quickly=
=0A=
-         * notice any new packets queued up in response */=0A=
+        /*=0A=
+         * If we've raised int, we speed up the timer, so that we quickly=
=0A=
+         * notice any new packets queued up in response=0A=
+         */=0A=
         if (ehci->int_req_by_async && (ehci->usbsts & USBSTS_INT)) {=0A=
             expire_time =3D t_now +=0A=
                 NANOSECONDS_PER_SECOND / (FRAME_TIMER_FREQ * 4);=0A=
             ehci->int_req_by_async =3D false;=0A=
         } else {=0A=
-            expire_time =3D t_now + (NANOSECONDS_PER_SECOND=0A=
-                               * (ehci->async_stepdown+1) / FRAME_TIMER_FR=
EQ);=0A=
+            expire_time =3D t_now=0A=
+                + (NANOSECONDS_PER_SECOND * (ehci->async_stepdown + 1) /=
=0A=
+                   FRAME_TIMER_FREQ);=0A=
         }=0A=
         timer_mod(ehci->frame_timer, expire_time);=0A=
     }=0A=
-- =0A=
2.43.0=0A=

