Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B75FD0644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dxl-00030j-AX; Wed, 11 Mar 2026 03:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxf-0002yD-F7; Wed, 11 Mar 2026 03:26:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxc-00052E-GG; Wed, 11 Mar 2026 03:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMN+Xs+SLlYxki1+27qd51UgR7vV/y6mAo8eT2WmrDYZmY3x0nKAJ8FBqvc+C33IdAQhs38zEBnaqBTjo6tjbdJI1GDWE5G6zCbIcsp888oH+L614nToMXIBWeugltaEjOp8nOORWymI8fFADzvk5phu0NNt/P17HdVf9antX3XQmtrLoRs9FOU3uF4Gb6w3UReuxC0nShzOIKXG0kfKR8tJER4pvFnOGd5I5BcZGRsrGl6RB35vdic+NODux3zPZR5KJ3zFJ+OeJ8D4BeKTikpcbvxiJ4/CpVEin7fMVp30et7pVsy28mB4zr5fJNznrAUnact2O7QLCqIHOwK5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4awKrVCB/aZWgqUVw/PdrxRFMfaZJ5JiBQL3hHi8ZM=;
 b=gOljaEglP5r32S6g9D1txV9ciygFPHAw4zKZ19Wz6S7IeiS/CghZFMe7Vi6faEW1bsKvjHO2BwH5dW8d0EpH7GP8NKr301uGhlaztqncLckRB98FaCPCXx1NWU7XI/0hu2gfMRvIMplhpZyPEP/Xd6snvk92Ok1pFufTEivyzlZjmK8ud2Ubq2hirk0hKZTTbCOaZll3NXcXNkmZOsyM3dkKiUdgX4FTv4ew0IukuvPo/ZA5yDKUGEP2YIa/6sNry3YKbuY5YSCyHSI5mzLUAgjZqe7n49xCiE5Ijp7e0eLbF3EzTNCTaMCYFrHyKwPlYpKc9TLfCTBbFsFlyiM7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4awKrVCB/aZWgqUVw/PdrxRFMfaZJ5JiBQL3hHi8ZM=;
 b=In3INpO4RwJiLiSJ+uP1J2ACB2y/SpAX/qQaLq69BBLOLpsZFZ+X6Ry09yO8412hUXM8b2ju7p3/6fYsAGubCdKn6DTK5CkGmmT2TMyngzMFCkKfnncX6FbLXoy/VCWv1gTk5+itj1eUMSTDLujuX4zad1wxURq2RQQ3hLVckGSlBs3XIpnLScGQhPzOzxj9GAd7XCs2tydu6O0Dag0Q3XGjYF4SsELjABkftBWk0nB2kMBIMZ0Frx8IVhoBQ+WfljjAP4jCyut2isaIxwOZsceb4B9LtO8UHufq770/FVDpKogd1Myy3XTaZFKqgAL3L1qbeI9Z8CfbFGKcIAkRAg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:18 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 02/13] hw/usb/hcd-ehci.c: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v1 02/13] hw/usb/hcd-ehci.c: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHcsShagWXSol7ixEyYVsjaS3J/lg==
Date: Wed, 11 Mar 2026 07:26:18 +0000
Message-ID: <20260311072614.1095587-3-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: 403bf2e1-fa90-4b46-d1a2-08de7f3f7cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7142099003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: wAhl0HLBedK0e7kuiH5lcRzgpJCMTL22+1/12XmAu33viVTzX5B6g/hiS/z+OKDoh1Fn8Pq4tet2qH8UstZ/AP9I8O0JLZrEzQRAlnOakF54PrkQlhDYX77jGhURIBQmrfGS5b3XwiMeFbHJZJhNGD7ktdFSIrvMHHZCQFHCTGgcq5Q9gzIiWYIUN3Uk8aQiUiemrJ2Rbh9yTwg3XKyuS0ER/9Ow7mlCJrO4Sr7fWcM59AyxC+oG5kLgAYLr6kGg47ekwenyJj24GaR0xhLJnuBuAOiepcSZ7AuXMrHx1Kvskppl+jLHjYwCW3Id05FLup+IB6IuprpjnPQWYsn3TVmJB1vhpAmzQRUQyucIw/o7VwOnVQOnov1TmLRTEZ39n83XvqPRysEQGJt0HtzczmJDy8gRgCpgz/4M5ZJHE1R81kyW2xqlYNOks1d2sG2cwts42BRdHsren8pWt2HbVbxRC6K8epPQmIDhmvhpyn+eMad0u4ZY3chAD2fwZSHIq8O5mdA1KLmEn3j2um9seNiiSnpMkDK+NaCyhg6k+7x2sMntXV71yFCB6WO3AjhibHZOhqUcLTumZp7MgoDz3YhfV/CdHMdxO/YyfmmBXH2aHUuqyFZZoTbuv8ZOQr9atFrxewXiMsceOan7AILswJQshLV5DDHOv50jR3j10ZhcX8sbKe04b2xoWiudUG5mRz1l206uYXFCyAg48R17gDkgUyT8Y/yfHkxGYll5DgET3wiGrc9GntHZiJNRrobx14OQ0vNFSKd0CV7JSjDi8qx7d5nmZeWP2fhmbaLT8+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7142099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XkRjPh9MG2W9fz/wcx5InQAVdS0EF/4q3+X1gO5NVYz3Zj9sGy/nQn3M0U?=
 =?iso-8859-1?Q?djlBAhbNS5U0qYpSflr9XZcF7wzWDU1r1hmPryOP4AtlNTJY2DCKYVBFJx?=
 =?iso-8859-1?Q?RdAlxNHcE/ouB1nDaNY8V3hKS/XZjIBAmZ8JWgjQ/zafsIjjGjyRjfyoFm?=
 =?iso-8859-1?Q?ohZ4+A2lv+9yMqbP+wHz7tqcNuP1T9aqmTk68Db4OHcIDfGtdZTbu7Hzhl?=
 =?iso-8859-1?Q?ksFNozWbXySf/E9BXdL/ycObG4sXHtku0GA64aJHXwRnwLmYhOVkGtz+Wc?=
 =?iso-8859-1?Q?XmAFPNE0cl6KnS5qNVfPDROcKK633JbIOHIl07YtdUsdnPI+hG1BP6i1p9?=
 =?iso-8859-1?Q?P50c3sWs4UgVDAMpsrdfW0kMKuQFF1TGEvnfju+VyPZzXNVyW9uEH2bZ3n?=
 =?iso-8859-1?Q?2bdKs9RN0I4SrBSIZtKTgs9/aaetkZ5AvmoNP9UsULgNwQr9DUa1DjLPHN?=
 =?iso-8859-1?Q?Mr3XMPRGyO3HKSR48ZFPwV/GrHcMNt7AToUtwqS3gG0BoFRATG/qhuw0rx?=
 =?iso-8859-1?Q?YKDalwvj2A5iV6a4Sf7/KOS//waFEA4QdiqL/7i98s3U7VoyJFoT6G4F3Y?=
 =?iso-8859-1?Q?CUYhtUpyjyX+oLuxP61rRjgBTO1tpqxWgfMuRywiU8+YiE9OjcDHwfdRs2?=
 =?iso-8859-1?Q?TyLvbRdwgIguoFY/qXY1TMjg5SuvgOBxbPISMCvaALwsJkjZQyW0+eD0bs?=
 =?iso-8859-1?Q?pPZB2UDOIf6/eUF5KT4vA/CLg/uOwbcW4JBSTEDk31ihK+Ovp6ZS59KUYY?=
 =?iso-8859-1?Q?4qUCrSojnA5sscfgq/n+UXtcZ601K3yYGEiTgPXLsVE0EWQt6oVZXSBOfh?=
 =?iso-8859-1?Q?uXR/hgd13r9ijQqjkdD1qaZG6o2IeyrQlpxkmMevF3Q3PeCbKT1cz0DzPD?=
 =?iso-8859-1?Q?SxlUHXNEw+bLZxDevUIEaqCyKNY4lXSyBeC1U/lGpXrpw7kRmZpC1QxnrB?=
 =?iso-8859-1?Q?iYXZ7jLLs5HMG4C4qw5ewRTVUiqwcTvJuApVqfmhDvQN8kJKGkLFyKIKCK?=
 =?iso-8859-1?Q?oKtfrFGDIz5O4eyvelMN697KLqpkX1Re0L9CH9TuFum1d6bLeJOhJz1G5J?=
 =?iso-8859-1?Q?he9uiuT7oymphos03xCo+alcZX5ktg1i0KK2cEGc0UHtkqmp2xcg+Kr3hl?=
 =?iso-8859-1?Q?pDCHaEgYVuvXKEO9YKHYzpmYgwjVkqFJSu6Vx9H++Y+KXKEjy3+Z88DEFY?=
 =?iso-8859-1?Q?4/XUOqQ731bSn02OEA8VwpPRHs8sGBgj7hwu2foUB4dM8Gr2BO31syQR+f?=
 =?iso-8859-1?Q?O2QQ3Cfzgy1H5D/vinxlpc6tDSmALrVxJYN41597BzY2HZxZuWoP4rx9ZC?=
 =?iso-8859-1?Q?CRytqudqVtwV4gYB0H0s9v6x+yy5IZrYA1nfXOuk4iS/p6gZcKicvalDo/?=
 =?iso-8859-1?Q?WpXwIp+UiS1KSY+MG7+zEXTrDWU7Gb90p3x3QUipXUICmDqsotiOZGfSMm?=
 =?iso-8859-1?Q?fhN8wZOOMExClOml1w5/5f1vi2D48xx/3AqGYcJ/exVWU5w7OZ8BfPUZa2?=
 =?iso-8859-1?Q?FQnzSnoGaC8oGNUFkA9a+NwniDPa1ulFNaEjFeyQv4D+vR8oG6mIOlwI1o?=
 =?iso-8859-1?Q?XRYHkodL9yqgMPBxXHl2WYrg9rKAv/JkN0Gh+jlAg4vdl9SvuKQG8DVPD0?=
 =?iso-8859-1?Q?tn46SKN4HJNtFhh6X/tQN2qXPKrMrsl4MuakPu/7YUlBoRgLvCoJSE9r4j?=
 =?iso-8859-1?Q?R8337bo4x/9bqeuBV5UMmLlasasBpx6iWhQkz8j7EssZejM7imu5BEcMnT?=
 =?iso-8859-1?Q?lYQz2X1DX/Cpc77Aw3oYSBqwdAoDvLfdKrUikBqWpNkSl0V0/dLOg8ZQPZ?=
 =?iso-8859-1?Q?S8Y1ljWd7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f9ESzWRTWJxykHR1Ob6kHCe+jn/km6m/HZwucqUM8AeihBNP6UsmfqAuHb8uZrPJ4L55rACNIZIVUsJQi80nhHUPmt1xULxZCEOmJmWEaqAVBPYuqUIdG1HPEMJ0G3fy14GqW0ynyzJqOBTJj7DonbqgjY+sWIH42ZnXm6pjU0ghd9BZr/xvxsOWcUEdjCthPQ1zFfBIPJpTmfYFa96wEIbYhVW8wEUGuRKiWfV/R3Quf/ToK82c38hFyvFK8yYvIsF8huo1+zTkvLec4uL67PyY4sNyp8v8cZkyCJwB4lMwINnYfelPpntu0Sn2lpFnMY/v9f+qrss4muaU5kTg2A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403bf2e1-fa90-4b46-d1a2-08de7f3f7cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:18.4196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7vnDd6eA4kzedkgkNCdkPec7r23NLqBUlQmwjHnO+mGwV8stsUgIwdiBzabpXhrrsu6JloDT4wNzEf/s2O4OZ/P5Mu1nuUjdNzRvqVHF/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 hw/usb/hcd-ehci.c | 129 +++++++++++++++++++++++++---------------------=0A=
 1 file changed, 71 insertions(+), 58 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 57f930b099..e2ff0f5874 100644=0A=
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
+     *The following states are internal to the state machine function=0A=
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
@@ -1757,7 +1762,8 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
 static int ehci_state_advqueue(EHCIQueue *q)=0A=
 {=0A=
 #if 0=0A=
-    /* TO-DO: 4.10.2 - paragraph 2=0A=
+    /*=0A=
+     * TO-DO: 4.10.2 - paragraph 2=0A=
      * if I-bit is set to 1 and QH is not active=0A=
      * go to horizontal QH=0A=
      */=0A=
@@ -1935,8 +1941,10 @@ static int ehci_state_execute(EHCIQueue *q)=0A=
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
@@ -2047,7 +2055,7 @@ static void ehci_advance_state(EHCIState *ehci, int a=
sync)=0A=
     int again;=0A=
 =0A=
     do {=0A=
-        switch(ehci_get_state(ehci, async)) {=0A=
+        switch (ehci_get_state(ehci, async)) {=0A=
         case EST_WAITLISTHEAD:=0A=
             again =3D ehci_state_waitlisthead(ehci, async);=0A=
             break;=0A=
@@ -2126,21 +2134,20 @@ static void ehci_advance_state(EHCIState *ehci, int=
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
@@ -2164,7 +2171,8 @@ static void ehci_advance_async_state(EHCIState *ehci)=
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
@@ -2191,13 +2199,13 @@ static void ehci_advance_periodic_state(EHCIState *=
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
@@ -2221,7 +2229,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
         DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
                 ehci->frindex / 8, list, entry);=0A=
-        ehci_set_fetch_addr(ehci, async,entry);=0A=
+        ehci_set_fetch_addr(ehci, async, entry);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
@@ -2246,7 +2254,8 @@ static void ehci_update_frindex(EHCIState *ehci, int =
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
@@ -2326,8 +2335,9 @@ static void ehci_work_bh(void *opaque)=0A=
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
@@ -2345,15 +2355,18 @@ static void ehci_work_bh(void *opaque)=0A=
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

