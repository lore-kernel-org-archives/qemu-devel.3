Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760CCF433D8
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsO-0008JH-5A; Wed, 15 Apr 2026 21:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBre-0007rS-QD; Wed, 15 Apr 2026 21:49:56 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrc-0007PV-B5; Wed, 15 Apr 2026 21:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqmBhFUW5U7cV3GWKYLZ25JdJbkKzGFuR5fRNYa/6fJFLUOxt2jFoQlPmqbo/DJYKdcdZSiaVqh1F/DFzSNAXMhEImaoReLPMaxEvCL9eYd0EiCjoP6IAxRZ0Q/l7bdVoKjpa5ELtU8IAMP7kIAq5aefb8AHjwfjr+K5q2yC/IXjK6KMSuQPmHrG8SXTjbKQofq/VNefrnewV0dqG7kVi9fa6ufpcdo9mDbvgPrr9YjL9dnAUZS6OpNQZL3NeEowGk7A9OyjpY9OKxJ2vqrd2/Iot79qTp/ef15XrSyxujzxrlPS11miZ3ll9G1XIjD4YVc3GVYN5VewcBgPIfv80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCVYDin/aI2j3cdnv7i8SYpme0GrUJ0vo7kGdjFa8Bs=;
 b=pweO5TjSHIyN2e2YAYT3lfRVkYFv9QEZenl7Vq20mtuyxMDu3kUeHLTHA0gJ+g9NtVocOF8evubjuxiI7O0KeGG/wxxYfvu+vb0DeolXDEHNO7p5PMA2aNcmeU/LhkrCB0ITbW3RUheAl+FPWRMaxhZOsPhYm89s+urEXc/+7nOJ569b6MnujpR+wH16LUnXO8x8Cch7JkXGe5cc3bbXwZncl6GHkMfqfnySPeWgns/+BGfGI5XWvypm1WIVNpLqx6GisJACbjC7dwxQZXrqxZw+wtToT8TC7/1AzyCHVu/QWNIFvU2OqItdbYl+mzmHsNZJImA1noCLSxtrsgkA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCVYDin/aI2j3cdnv7i8SYpme0GrUJ0vo7kGdjFa8Bs=;
 b=ER2nfHDPUQo4atHlrmKO9CFFYH7TwZODT5uWxmbeMBmAeDoAXBWzC1b0FkHImSSHHDZlkbsAIPxu1/xhysgYYWGJLJkXrCtJ0mRxdsp3dz6ndvso3fqGp5s9Amx7s8IHyJHrcMIOn4u0jWqZBDOEhBENDrUqGzntqoqVoHSfwx6rnzABtvd9nEcQeEfia+/DwVHJCHJ1LH6Bj+mX+PIXSynn+/xIgxxoNEC0BdkvhiPLFvaeVuznI8yjHudLzjOf0m4lBPQNNL2TdiUnPq7A4Y1ZitB53W0ryg9GZEiEDviOHkkBj24mnTJMVLqUk+USSODLYbKk8O9s3b1lMA7bvw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 03/17] hw/usb/hcd-ehci.c: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v3 03/17] hw/usb/hcd-ehci.c: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHczUNIuFbPgPlki0SfG8stynbviw==
Date: Thu, 16 Apr 2026 01:49:36 +0000
Message-ID: <20260416014928.1279360-4-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 76bc55e3-245b-4966-3b2b-08de9b5a6a96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|18096099003|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: HU8mgoG7zy1UUCruJRDMhp0tScbJYP0ASaR7aA8MJkSxFUW7bbfduBLKOIZEfo0IsLndZC8VMHVHKzG31Tk+vJFdQmly9u1eTnopr0BHRX43oQEGTRje3WeRE+lWRKE8RWvEi1F4Ae1SeTtHMTDDpzEs94m3hOJerq/A72fSdwT5UHSsPO+X496jHuxlzHRAqt1A0LbpZtiZemoUxOnDMTdCc3nXksvgMOeS3LjPv2zeD9FgOMY9Q/qvsq52GDOBovXk+94o/94OAwzGNsH/UwG9EFpRxv5r5esrRqPh/0AZym8CHYl5TWG8lSV6wqMV9mzOWqdVWSFsPGOsOzunra4yuMeHvxGDNBXJOAp/08nzLzqKTSq0EwTh+ozpogmyzu7IYnTLPzVnO3/XJdCGi8ZpDau8XubDO7FgrvtA/t2PDKuybL9lF2Z9fuOu37pPMP6WrN+K/eQn1iNTF/49NhUpjbmX0iQIN+METkYcs5DDl37pq2p7En08bz8YgStwj+gcsl4Q+M3DBM8be+jVW4y60PeYYTrtd/gpWl6vp8LHo+sPjteVTs9eDVnrg6I9yu4PnAImo5M6dIq6sylDMw23ZRF7d+UDpakrFXouTRm+4nbf061KCZNwwxUp2m/24LnlaBv78gfXDZBa48FHSix4ue76fNT4HHHfZlfQ2OaM8rt4NL9HxXDuGeIm6/Kuq6xuf9dwtLnH94PGSdom+QN+UwxulP7eOAhT2kyE4djYgcXyKhyr7l3IjdRQaKPFH0vcqorL7dpBMQLnRPiTIgRde845TwDSL6BhIoNqwhisrXnX6w+/IPX76WDTUR/X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18096099003)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+nYG2MR5hZstK5anq0Z5ueIsIqFCjK/cytZO7Knt+PBsJxVt9+mbYf0Csp?=
 =?iso-8859-1?Q?2G/v/5qVfmBiW0RUP+rKitIwdUuSTUmszdC7k3rdADUm7G0FSGtNEU6vu3?=
 =?iso-8859-1?Q?kgJ4Z+Yu8Lperrcsw5SDAbeGnOiH0MmO/YEgGhksEKrldnlkt4pAPDjp4f?=
 =?iso-8859-1?Q?c6wSTne7U9HSoirZWTAsqUQrB8hvH4ZqRzU87rugb4xjxyWaacfzxvVG3q?=
 =?iso-8859-1?Q?x8/keyuuGCncsLNYQLDBT2Z7iWBVrRSwofwTAsTERVDXJq6MMixUflX/f3?=
 =?iso-8859-1?Q?ezPoJFBxrjeye+ticOtGwZtcva/kSd9DqolwDKMVRrGylbBsGGIMHn2Qqv?=
 =?iso-8859-1?Q?9/aoz3+T3okjSe81Le0eRhyU1EqcKtKRx3osGKlkvl2iHPIUm9zLW5MGO0?=
 =?iso-8859-1?Q?lXHs/TbnCy+oCzhvwutWQ+0789Me1MbmfsKgjYuMTZb9+XJGWA8b2JJrVm?=
 =?iso-8859-1?Q?i8Pq4YXcS9Y21aDCi+MIk+k7qL56owuXYHmlHO9mKhTGIMTePYsWVDk4In?=
 =?iso-8859-1?Q?D16BetIJdRdAsGTq/Xh1sLBbY82r/AqcAg0uCo1z8mVUXr8pqZVm8YU6i5?=
 =?iso-8859-1?Q?U1k4ZcSwhr/gtRnRayGeREy7r50R1WxVQNm85FqNOHnkkcLmGxuc+ESZuw?=
 =?iso-8859-1?Q?poy5zMmhWTyTW9sy+PYCWOPxNQgpJRweciF0h5jm/NnZo6uE8v3ZYRMVkp?=
 =?iso-8859-1?Q?FG2Xhw4HTPebwoLSkb5tmguAo2EC8a0KxEWm84CtqQhVamAyIZeupjczmJ?=
 =?iso-8859-1?Q?QmDTW+rqBB2ZIjIdqRqT6yt+JS5jUKEg0jUEyv6fYTGwLnxQObmzy+qfYn?=
 =?iso-8859-1?Q?XnHo/jE/RQByeWdeXz9UIiLmJfGXCSLEwOi6fwVDeqNwnGx1yp1LuBVT2R?=
 =?iso-8859-1?Q?nQZg4QspVKokunNg1XOeOe39fcPgfQJJDinlHKegv5/2aUiWeK3g2ssipg?=
 =?iso-8859-1?Q?fJqBy0L2SYOd4M8Wci3+KxIu23Knn/Br9nfT6kyB6SvdntHO9vcWFJdCDi?=
 =?iso-8859-1?Q?KUoUqGs0u2cts8vs55OHwmgwaTfiPfW/cAYwXfrp6zlDhw3DeWV/C9Q2DO?=
 =?iso-8859-1?Q?efJbcMPz8SMXjR5F3kOPMwdSsW1Fi2wsGjUt5DFWefVB0YQE27iQoY8i09?=
 =?iso-8859-1?Q?+4PronbEi80cR0PqXwib2lSWsuHoluEfHQUqykAD24HnDbHq3anvLhTzi8?=
 =?iso-8859-1?Q?kwu9NWLr8yN/ObUZhgCSzZeUnpqqDoaI7WTP9v6Pd/8qwQTOUANXawWoFu?=
 =?iso-8859-1?Q?2v4+dacF8rBC1orvjfj6pvaH8tNS2sj+uVXg9QxuVC3oJP501qZ4nSUNa0?=
 =?iso-8859-1?Q?MVowoOM/+yF3YkqOEm9Rk4zjqAQKRDeCWUygQ7YaBIiI7t2U3ewJUVNaWt?=
 =?iso-8859-1?Q?h8d3wtdSBPQq99XDx7CF/BOFkR6OIx+zxS5zqFjGakX78Te8aGKJ6Mdy65?=
 =?iso-8859-1?Q?QtQIODXPoXd1FDVB0RHQ0WWH4q9Je3I0oDWCUFh6CUEtQ9Y09CfC2HlHnV?=
 =?iso-8859-1?Q?JdDu1ay4cvU7SU44e7oJdQu/kyTXEGUx/yqT/F9J9SQ0MKNpUkulD0yO/Q?=
 =?iso-8859-1?Q?JrEcBY+Stzlsw5jzOTp8dSz4NbeWstNrrKhI2cvmmB3uAyHqqJ1XO4De/n?=
 =?iso-8859-1?Q?mM7WV0i+to9X8soy3HdTmKk8fTt8gj31kBZpxc+Z0q2rBQlAuHpj/pHURz?=
 =?iso-8859-1?Q?zaLW2spub/DIM2KjxcXCde//SBE0BKUOBzlAYXKCssqfPJC6mR9IUvrUoh?=
 =?iso-8859-1?Q?boRTbzxkvdkQvDxPYOLZWq4LDqY/0AxF1j34lPATidwnIxh96PKju4mdS6?=
 =?iso-8859-1?Q?f10aWMrXag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TTPQsGgNi35gLsmgvpZ3pZfcEvTyhCiAcIspspwR99eHxdqCHycZRcPbFPg3rZseE71SriCjFttCf0T7ngvZE2+papmRpOJL2W/5JJpC7nwPshtbpcmIdbod/8IugYyWbCVTn8783ao8C2taqKIuw4ad1x7BrCNO8JoGtmmaFrlvR8ukDBMbwANSEk3coAggxqNGi4Y5UayauXH6KOKT6AThcsk6iZn+GYxcPYz962/OFrWfUOghQHPzQjOHgA30DX6Viu2lhuD/ZhkFPyJmvawyH72RF4N/KbOy9jUiY2hqVpoQsJPohH1fUiyPrHm5FKqV8L53S56esGltz2kFqQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bc55e3-245b-4966-3b2b-08de9b5a6a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:36.9579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bj11OlVFg6Lx7AVLjEBtGN3gMUDtClsCBne5Y+OspN4KpsdfKKyWPPDJABwg6gr/xQe/wYWKYnAOaJTY8n6hIxRsEPenJu6wLRiIlu8eMZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

