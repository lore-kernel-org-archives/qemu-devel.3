Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE73AED7B8B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhX-0003YB-4N; Tue, 14 Apr 2026 04:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhP-0003Vp-8g; Tue, 14 Apr 2026 04:00:43 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhL-0005mG-C8; Tue, 14 Apr 2026 04:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/BKG2YJUOoylLGTzLMQmukcXEwCm9UhY0x5+4jR0kBIfEH6YYd7nqeMUeXhs57Wj+J9TyU0H9De7fg8k1Ek8hFwWOvb+qmt7s25ETVNzsN7wQpkc/5Apq0qJMiWJ1nHzU86GEuzSuB3E4FthA6qzy+KF2xq91eu5VNjhNdKQkgfcdBM5dkAw7DhvnqY6xvRm9dUIgBEXPe8/nPsbpAhZIojPUZCfj9stQvKq8NSq8vo6Qbn7hySG+Bc9+/GcgtuSrikEsemMmM5gsWPOlGDDLTgH0B+GG3QxYX7I5prTGDZxtY7l2hTbFzXJDLI2bxYxivaSZ0JJzlbN99r3xQB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTu2IAjLcue9nOqgFQF/jmkPRZ3iMUww9o8bDsUQs40=;
 b=xNQx8hvwyoV7ScGoAZc4juBFOr4iaSWdK4cigvV0uwI0tgT1nI+iN0ur9egisa6D8bEn69NYmzmWwyblM3jGoIJEXmoClPNpD3oVHu5g7MIk58SG481UCNOWFAt2a/wVX+NQ8WMTfKexq2DNTB6eJpIgozP01LDMSIE2gBA6xkSzfIAV5dRPeZyoTE1PviA2KfSmxPhOfAh1gb3QC83deQwdIcx5E6rYHVqdiXl6P4nCNN3Grti+Ny34c1WeluEnd+0pSCtnlfre5Oq3ChWQDpDwuVdL1e3dniCCBqs0jNAGwMVDFamFVrXlsilixlY8tw88IWfWwiadhxVGt2nG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTu2IAjLcue9nOqgFQF/jmkPRZ3iMUww9o8bDsUQs40=;
 b=d+U0S/PSbSUMGHCNSUV7SG5zmWUiki63DdrQQa9pQs3rEygOWRc8K/o/BbnHJFm88YMd6yXAsRNUsuvfldEuE7pRi7Vc4G+VDI8o1LvfNODVL1wlB4Iqd2BFSRH9Dk09Uc4evEF+f3n+IsE1XYTNljUZhUAFRe6fRVizcfAjQ2rGL4JWC4dYJ6Up9lvhLxP2wJmLjy0pvEdSAqr8e59vha8Lf7MjgxYsc7s6++/cyxocRdWGPQEObOuOtcOCErC/c9XnuVoWYUnFgJUSjZ4FYiOyenCMqD2Hok7mNpPZmEBbiEG8G2wFSXOJ2hS8Tu8te6vF2fE2F1PsnnmtlcZYFg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 02/17] hw/usb/hcd-ehci.h: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v2 02/17] hw/usb/hcd-ehci.h: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHcy+TCNOgV2TLDAkutiizYczb8+g==
Date: Tue, 14 Apr 2026 08:00:28 +0000
Message-ID: <20260414080025.3005916-3-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: eae767dd-de83-4cce-d333-08de99fbe4d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: j+RRBju21TgI6YcCKgESSJx9ImjX90yjAWAEUV8+1ku22X0AMfEBhFWFEoI8397JhqnVfyzuXWjIE1ZAlwdkJX3h3NBCa9tJXDnkjSFt3NUdDj1qo2LgfkJ9HNOhlfEbeOfmzHkn00ZAlBHKsc3Rd40jjBafjy+vUM7zmKbgQuGDlM5incIIlkbBXVE10Qjs7E5E0ENWHx2LdIcUxKHzsH6QLIIp7+6zwnL1gTbtG/f1p2N3Dlzrgj5j7fdnL4NGyZcUS7j2ZnzbOF7l4Z3DkRrHRJhobb3kR7Vx/d5i6fs2kNcterBj0ENH7bMsswhi7kPVRbpxk1aVG3bfFkr7nrZllVGRkabyuoCXtwcvJrIQMk+VyL2Doc13gPR0XwmvwWxxERtIv+7pVqdo7vM4huC7qZ3x0EwuWaFRBGvstKvi0fI76KSaFobuylv7dPXdNx45/qJgzwaEiw67C+FM+XRDHykESby+5FZxHIDss8KwW6Qm7HmelZnHL72y//AkkHuIvQ+dcYH5aBeyxnYVMGUNU/6I7Yt3joYRdILPLEw/8mfkGxuCWGZSZa9uRsUM3ljjVnt/ySXMZCm3y08WBWsFFGkVRnbaLaTDs0RXmLhEqgYvJzXhOSJJs2FaAt3CymJu6YZvrzusgnwNoR9lLyCfkK27cLaktvuxnDuqockfZXo3Pdh+3Xe0gvpLzXeCpcv/WXKhUVguTo8UB1XwG32rgrB0LpkHoU8dEO2YWxtVMn+OE0ufViksW1XLE06/Xn1tcOrmzBEXRwNKWhMW8C6fd0oPHyWKL3bFVcfYLoE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7N/BU17QhaaHVmJAzacwYcW9udeTsn5FbWE8FOC/piLNWXL+Su1dslQZRf?=
 =?iso-8859-1?Q?BDGIXoGV4UZygH3vj+DdI4545Eg20cv9Vn50XcUlZae59j05S82x9zhl0f?=
 =?iso-8859-1?Q?zgZp7Drj8gD0+1x9Lxq0oDxDm1Mb0lzT3kwMSYhI3Op3e8C60/1G0VwQBw?=
 =?iso-8859-1?Q?pTXzBCCY6CL+CxafIB08gJd4bS0Cad47FuW0NP0yZJnAljAFjwtg1UAxg9?=
 =?iso-8859-1?Q?AiPnq3BJASd/6YdNeB13oS4EpjMA26ny+FnYVLqYglk7P7hI5CS7+JFq3j?=
 =?iso-8859-1?Q?ue4s8wmTpHlSGTjxOsqjEIAvaI2d2duDwErTYYwVw7w82BVY/VY927WPIo?=
 =?iso-8859-1?Q?JFLwQQjCcbK+MWfe6/mJ2vYohN0TGirPTp35fyB0WijR7SZ9YfzUXwmZbe?=
 =?iso-8859-1?Q?M3geGyrQ/IFID9nnxHEvDJbEaFFNOd6bYwknR/S/KQxnG30xc9eVHwUYhi?=
 =?iso-8859-1?Q?bdQO3hsaKObaEQdB0IoIoGf3OqFu+RaqkmcTcBzmNOPAbLlUYGXs36Vh/W?=
 =?iso-8859-1?Q?fLERfiktQ9fwdpqo95pa35D46On4Qvouf3n9ngs2kqPXt8kXYubZTAFcV7?=
 =?iso-8859-1?Q?GZdeP6S+HTL3gF3DYgvhGcPzzHPXtXtRsPpAPoJHt8mCNRUsgTdEZb0nv2?=
 =?iso-8859-1?Q?xkdqOBg/41lgvCH3AOtIbF0NdhpHbnnj4Y8AUudWsWw+m52f7HdaFIlcRU?=
 =?iso-8859-1?Q?9IC7MC/RVOYNQfkBlGbNDohRG3d8U2ABjMEhO1pz+DjGgRL0L8iCvl2rX3?=
 =?iso-8859-1?Q?/9qnK/oCcmXxZgiIYYAH2TYX8ZoFLc3cx/kXymPatlnqaaAPxRIi6Jr4d5?=
 =?iso-8859-1?Q?YXEcjRs1/ATUCOMuQJDP3xqdF7ntkwkEM2qugJCktc5BSodNQ5V6W/DBUk?=
 =?iso-8859-1?Q?xZX+QYubwjlDZftTKD3Rf88+5f+HsOCiqwVF7cgA58XN5HsGKsyMTiBgF4?=
 =?iso-8859-1?Q?u2NZaadJwHvD65OoQODG9kQLf6FVGuvt8jygSc7oGOsFV+47k52lqCHcXY?=
 =?iso-8859-1?Q?bey//ni4IgeKnJM4yDfqnFeannWwze18nJMLocdLo2wOr4UVxh7AQTbp6k?=
 =?iso-8859-1?Q?C/CuX0Rd6qKCC0e4ErPWQsSt8ldcrIu1uVo6M9LXqFHgz8iSrPqdFWfHW+?=
 =?iso-8859-1?Q?QODDg1X8OVc0VxFby40/sctsUrKEy6352B8fZYyvz1LIomB6XvkmsDdyOk?=
 =?iso-8859-1?Q?Q5kFsHyOgjfXWDUS+3v6CrbzT2h4MbkEl0F5SmWJLKNasmv4jxURIUJR70?=
 =?iso-8859-1?Q?eC37EhkLLM2gbCJyP8HdtYc6c3iWXK+d0oL3+CJfEW5bfWx/bHl9ZFBErq?=
 =?iso-8859-1?Q?sulnKzH3j+5X7SMYWT2MNbom5w0spuIGG8xWFTBY2qrI0OxnAymoBw653C?=
 =?iso-8859-1?Q?fZT2BKzKuh56E7l9uxqJR9etV/aHuV/LbSIL+zBk7lGbskISGjaXrEQYYC?=
 =?iso-8859-1?Q?b9kO7eGqSGjINc2dhvzF+vjnR9WR7KltykFC7Idw0R13zjN7t6bg6Nx6s6?=
 =?iso-8859-1?Q?QiD1bxa5o+R6+kex9lwPDVujriMBaWqHcAGRBFWLJN/j0OYU3eAOfj7G5G?=
 =?iso-8859-1?Q?0lUw+Tk1jb6BMbkC2qy28Jmyz3lJi35aKfDqY5XeAXOQEIB9pJgedWD+EF?=
 =?iso-8859-1?Q?l5w9CVWKUI9Gf6Env3iUKC5nxVcE/mWZjI0B4LJHc0oXfxn51GVJRew/xH?=
 =?iso-8859-1?Q?njtpUD19fQ9T0yPLbFGAcCrTet5/n9Dac0zNfOCXQGBYPpFPGElL6eZ6M5?=
 =?iso-8859-1?Q?JRQxtAIb3cOoc3bngsJEARhLjy1DWEQdVkVnLPfjVQvFi+abulOAc4xi5Z?=
 =?iso-8859-1?Q?SvZBJBD1dw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qkII6Q+OInMIryu+ISWAiocUFAYpqD7E5g9wP7ThRwzws9IMqWd70dEFpUzRQZ0D7l3TMpDJAVt1iiVos+ol1rPBfhvj24wTtP/E8JXltLyDQqnps+sEs0+GT6pUMvY/ioo6Aelser6+P+FHhYvkdOWFnNDknqI5ImmLp1qbiMaouoypWJNy/Tk+tsn15RauDYBjKzlfO3yRKzsE6NlnQv39/RDekYrBo7V3wGwQZAOB0ELcg2txSN5gdj/IE2IhDIi7GLZ6cRLj2ubLPAK7fr0s2LSEHrv2bIg4lya5xfqOLVxbiWAd3TlPDGygSve3bfKtoDKBAS1gtLl4ly8JmA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae767dd-de83-4cce-d333-08de99fbe4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:28.7660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIm+AJ1a7Xvuuu3zubKBxS9g+XsgGB5oMzwK+Q3PxRyreQBuxIl5YFs8aD1DaY5dDXohgD0QuDxTSrlX4fAMQ7b2zHXmYM5S3TvhNNqlBdY=
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
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 17 +++++++++++------=0A=
 1 file changed, 11 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3aec0e047c..736407fd52 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -43,7 +43,8 @@ typedef struct EHCIPacket EHCIPacket;=0A=
 typedef struct EHCIQueue EHCIQueue;=0A=
 typedef struct EHCIState EHCIState;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.3=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.3=0A=
  */=0A=
 typedef struct EHCIitd {=0A=
     uint32_t next;=0A=
@@ -74,7 +75,8 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
 } EHCIitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.4=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.4=0A=
  */=0A=
 typedef struct EHCIsitd {=0A=
     uint32_t next;                  /* Standard next link pointer */=0A=
@@ -118,7 +120,8 @@ typedef struct EHCIsitd {=0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
 } EHCIsitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.5=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.5=0A=
  */=0A=
 typedef struct EHCIqtd {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -148,7 +151,8 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.6=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
 typedef struct EHCIqh {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -230,7 +234,8 @@ struct EHCIQueue {=0A=
     int async;=0A=
     int transact_ctr;=0A=
 =0A=
-    /* cached data from guest - needs to be flushed=0A=
+    /*=0A=
+     * cached data from guest - needs to be flushed=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
@@ -268,7 +273,7 @@ struct EHCIState {=0A=
      */=0A=
     uint8_t caps[CAPA_SIZE];=0A=
     union {=0A=
-        uint32_t opreg[0x44/sizeof(uint32_t)];=0A=
+        uint32_t opreg[0x44 / sizeof(uint32_t)];=0A=
         struct {=0A=
             uint32_t usbcmd;=0A=
             uint32_t usbsts;=0A=
-- =0A=
2.43.0=0A=

