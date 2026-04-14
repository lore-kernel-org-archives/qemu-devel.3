Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD7ED7B87
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhg-0003gd-Nu; Tue, 14 Apr 2026 04:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhb-0003bT-1i; Tue, 14 Apr 2026 04:00:55 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhY-0005oL-Ko; Tue, 14 Apr 2026 04:00:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBRL851vpr9H5S7iH5fj8wMIK7s6fi/GJEJPY7rzovI6kgRm3Z+tsXUzutgJqylywhPSpHF2oChvwJJ/sREYOzCVCOQwn8ZPfu/xavTMwEyxm5p0K5uAuOnT8yRbHCCD+drriD3VnC+HOXp63Kp2HzWAU9nl0D7IoN8adKQ/TAmO4JMAvRJR6vTWPV864UThClCCpiDeN6H+noIarnh3+Vd4zTFqDC1GyUCQUBUxySjxW85rZnwoW22TTcN5tJpEvI+VHy5gYD4PsslyDltNidTDMZ5jWAPxgXP+39zoo3NVEG6YtTWPGBrmcozxwiX1et7hGyUCI6upTIQIQ+Gwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv6QKdzh9Nm4FFVP4g5cAlSzrWOdTp1N1mcV47oO0zI=;
 b=gDE60W1hvrv7CCaFrG4URHNIyzB9oHX0ouVugESDf4EWC9TfV90ioXNiVmh5rxuQmS3mKwpqIcfFPQ4/GOSRsfOVjBOe09nOHEA3SvvkFzQA13XOJ8LCyii3JLPw99IhEYB7M7fnJ7ECViRbCZ2uZsN9dNz7ieRTP6DU8JlZVQVAjiSMtuAwFEwC9uuVRBFj0zKeQkIPd2e6y5lcufUjFWn/hcImoQcnK5DJ/qeCQmfN/o3VeZo1VeChL2SvK+UKAw0+a1uxBvkzzODrQs3BcbxX/rKdRhamKkafbfIPdn7GE9CYqFp78+rkcq/n4kdNA+xDoOdh8ENuOby+kOUe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv6QKdzh9Nm4FFVP4g5cAlSzrWOdTp1N1mcV47oO0zI=;
 b=VoPjgrcP1Y8FWPPjxfqk4SWimHrRtfg0rIZCTqyw81zDO32euqIwcHSb8WkKZ2+MUfS0bTsSqD3iFQlnLLMGx2wH11YLGob8wnqa8Bew758ZDKIIowtwKB2znKsgHLCFQkRakkoU8gPhWjTl1gMg1cjdCc7aNJXdO8pZc92n6zk+pdyyznvyKHmCCpea2CtAl6/4yPkYnKTMrGcQOynnYy02zGYcTUyMesQKQiHrpEiQh5BOD1Z2xqjxnbc0RW4S+7CJYsop3K52l3HtelCodqgtov6SlD93vl2vnggGip6ygpqD2e+DROJGeBRIn0gJj7Vvoqgj1jZOsKB/4Y8SYQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:33 +0000
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
Subject: [PATCH v2 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Topic: [PATCH v2 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Index: AQHcy+TF38PfbBLNdk+9bahbf3ZsMQ==
Date: Tue, 14 Apr 2026 08:00:33 +0000
Message-ID: <20260414080025.3005916-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: dbccabde-b665-4d79-05f0-08de99fbe79e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: EFOKpB1GbMtWxeQ22BvBLTNGnOBu6GDYEhjF1yA0EQgjQrzC2et3sj1aFrAYq0aNi+2kKY0XUYo2OeCowhC6Tem4tKlOeNXE7IjqIYN0+pgQ3BnUYcH5P+baNhTkq1gH7ujGT3A9e/DfPwR08qkl1MH5jLMX2vKGfyMUnCKf5gEqGovrkMBnB3ChJwM1+BcjWEGuEcUd6yS/bFkgzyuEMqVGYdQYhRIfB0Rk9eolO+5QG1dqusSFptQ7IHodjuWlz1geSuZOBOTK32sfTp0+bi/P0pHdI+7ss24tJNcdWjiQBZGosSfJaPlGA8XjL6VwkOHKbj54NhlIfbNh89XA4a5WrNjiC2o0GLRncxwZH8m6wntYpirDqqmbdTfgXr2IAQtRJZZbEj5mHTCPo4EeUKfydmMHa3i2wRCIshsTfFhnW1Gz7O/sGnH/HF/TFipSbgLPg9JKRbpezHvZWWaXaLkUc46z6VozogFjYbp2IYnR+0fez+KO9/etV/ZXxb8uUhm+7o5HWdH5OcJTblj6eBXVmiZXOEAdZg6o/4qHAgiC9t3fj/7/v8vzFUdWtB2gcjgStamNApG97fQ8MHrgtVyNUm75/emM9BpkoCL8ZyklSUx1uK28SorbNcL/Q2SZrZSCGloT+nGxvftuAwBXlbuICdIR7YLqXncl3MWNyzC4qbT19166pXqLiXZ8bX0AInwn3iULQ6pjKNqQ6imk1RRd26MFp9eVj4ogrRzgMYzzYpbHMU3iaBWc4UPFgyk4k4fN/v4UvliT/uPrNVgD76aSEFqLM8onZujin7/c++4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bzMF6AnCGH49qVtKmsWYmPeDI5+Vn+iBF7klGJ23KROgB1I6dJKKAYYJAx?=
 =?iso-8859-1?Q?N8EFaulkHs+uAIlU9Gq4k9bD6RvAeYncoEAx5pyX4MIeZd9hzDJOR4O+7I?=
 =?iso-8859-1?Q?npwl31RO0t4X926g3HKUCXxo4wtQJw3foZPmeNJ9iQaHabNZtQHlO3FhzD?=
 =?iso-8859-1?Q?dUwnIbNIErxxRbFFJ+ftaOoe8eQjED0uEysHRq/Wh2oZbMSU4adso/GaEa?=
 =?iso-8859-1?Q?h92Aaq0eP6Bx3XC+kCbXH753L8jmNs0828txRYU/nt29J+7fVsPEVgqCzX?=
 =?iso-8859-1?Q?8RNdXU2NmRC32VQ/CbbEyP8LsO8E7Ul2TSK2jUD+5N+FuARhMDyOaOBkPU?=
 =?iso-8859-1?Q?a+Bp3SGOaLJuICyU5R+WS1JT2yEaGYXMPfQYnBCLvqyvlkP3uNXO8vtykt?=
 =?iso-8859-1?Q?3uqPE+I1WtAX5W7dLMv5tevEsxe2thofamyo0dvAD5XI4YegPoDQFvCBBh?=
 =?iso-8859-1?Q?6WzeKbUsoQEldqN6pdVYCXzQ8YdDy1ytor7/TAQOGIycl16YPvBNlfFOow?=
 =?iso-8859-1?Q?wwvzwv0zSe2R7WbHmlPq9Z0wegtxYjcJfBGBIVqrEDpt6NLlNAprJCXmQh?=
 =?iso-8859-1?Q?pyjIIykKO1JlApWTLusfJRyds36DjhYWs+Sa0dUa6jS44kApbRhhKpt0ZS?=
 =?iso-8859-1?Q?6BevNFToHn/Jdk8NmC1veLnUrGcrEZCkTVrVR8Dgv75ElJBwQZ0gVFYR6q?=
 =?iso-8859-1?Q?ntcJyDiBONwufIw7g1/vfZSjmpVRO0LCAaQmaRwioizyhpa4/IBi77fbES?=
 =?iso-8859-1?Q?IMIzOoQ6NKIaSO5v9+xfajuUbYKCI4FEGd8FT2yuCs7D5i3Wn7leO9CgGC?=
 =?iso-8859-1?Q?OLo9aVELjG2Vc2qGeUp8vh2V19Bdq9tc6kUV/B8pg1vK+yN1Oy7F/hinfx?=
 =?iso-8859-1?Q?uPlsrnxaBC6gURG50V1LKcvUZhz3G0PeERoBnLk29npkUMZjh2bwqBe1bn?=
 =?iso-8859-1?Q?7Y/9iCX0u25MG9NZKxNAlHedx2ahhLjwRAlXfwVmU/1ARXT/HwtQuc0Ixq?=
 =?iso-8859-1?Q?Lj0OZdk96RJQGaVGPVNb/ZMPUsxhgq/uwXLGpxHj7V5WmKXHBpXT1paE99?=
 =?iso-8859-1?Q?XJn7Ern49OFql9uhXsUK8yuKGt5adJmQ4YTMfOamaRv5/UeMo11KIXiRZM?=
 =?iso-8859-1?Q?qh2GOZovifIrO+cdTDKMZh30ycn3q1I54oZarfeL4PXcNvDBir5+JHQp/+?=
 =?iso-8859-1?Q?nHMXeulVfQ5AqAjwooa3p0MZEWJ8KrHciO4OqXn0pdw8cWzQu2NyS4MDWw?=
 =?iso-8859-1?Q?ReJCMiMyzp5BDYDrYvMiCfoFZSiB05PITqn4VSKFZpBqi8LbmWwbpilFcK?=
 =?iso-8859-1?Q?GrXdggT+P9sbLmhslDLUz5DbQjoQsguPwCGMTrMSSxf0U2sVNXNAZdRlda?=
 =?iso-8859-1?Q?C7FZXUBbkhi0JLBX3QFYNCV8C8pUsz1+SrUCETa9kFhelUrquNhuW6YzVM?=
 =?iso-8859-1?Q?R8sqtc8QkUWg/TDK2BoaEu8cRzEiQ082hiVSDfnFcqoQs2SYahzau81f9S?=
 =?iso-8859-1?Q?+IdVgh30RFePax2bTnjDfkYi8FbIVAT4EM8xA/siAe4krsWw9rNW4GFHgv?=
 =?iso-8859-1?Q?gLzK57jwKMFMyv7Uube8LBZHQw3KaowMUz6LcOCIE8INVNUQ8QCOTdMFoK?=
 =?iso-8859-1?Q?RwIf2wHzSBFqWZxWpmaAkCfAJlpe1Iimcxyd+SFXXP+tYtLi2fhnyv9kpp?=
 =?iso-8859-1?Q?d52Dwao3tvcrTl7CuRk6oTO36osiJNk8wkEqLD4FjwdTMNmvl5VzzXv+1m?=
 =?iso-8859-1?Q?Pw4ikmgeinWEaIm17qPvc2tI35Xpg4MpyVZEvCutdhb/7fhxHXhyPJ24wk?=
 =?iso-8859-1?Q?9U62t17ZhQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V4fwjy8dhM1EThl5tykGna0myuoTdXcLrBHnksqKUQwbikEr0V6MW11/y2tSLA4BT0MH9pAagyR/aagD7A3IvNI+rVoKQ5dFYrDVXBPpLQpClyyGPbIzJHe5mh1g3/tkS3TOArjpu/pnWhlSTLpMJiJQRAnwacrp/k/mcfQDfgoC+grQPgibvsLzrVd7l1DMBbBbwT13rTNf8YaH1d21wdgwVL3Rwd7agntILGNnRfAlj0Yjfb/OLMVMnYqtk4lt61I5BZGVRiqckKV2rH/4bQLJyaoLV5qiJLS1e6BqNsDw8RsY8C1+DoKTUSLcKvWKT2U0xuRk1TmJbbIn26gP0A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbccabde-b665-4d79-05f0-08de99fbe79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:33.4582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RH9TIFmHuGM2oEWagX0yCKFGhLVBr7elFRUn+ot77u0OaDkEjR2/bIE9Fwgp1hFcogCTwLQULUNot7NBSTU2Ol6REnKjLISiNZGxaxsxY14=
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

Change internal EHCI descriptor addresses from uint32_t to uint64_t.=0A=
=0A=
The following fields are updated:=0A=
- EHCIPacket::qtdaddr=0A=
- EHCIQueue::{qhaddr, qtdaddr}=0A=
- EHCIState::{a_fetch_addr, p_fetch_addr}=0A=
=0A=
Update get_dwords() and put_dwords() to take 64-bit addresses and=0A=
propagate the type change through the descriptor traversal paths.=0A=
=0A=
Adjust NLPTR_GET() to operate on 64-bit values:=0A=
=0A=
    #define NLPTR_GET(x) ((x) & ~0x1fULL)=0A=
=0A=
so that link pointer masking works correctly when descriptor=0A=
addresses exceed 32-bit space. The previous mask (0xffffffe0)=0A=
implicitly truncated addresses to 32 bits.=0A=
=0A=
This patch does not change the on-wire descriptor layout yet.=0A=
It only removes the internal 32-bit address limit and prepares=0A=
for later patches that will add full 64-bit QH/qTD/iTD/siTD support.=0A=
=0A=
Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to=0A=
use uint64_t for the address argument and print it with PRIx64. This=0A=
ensures full 64-bit addresses are shown in trace output and improves=0A=
debugging of queue heads and transfer descriptors.=0A=
=0A=
Since the type of fetch_addr changes from 32-bit to 64-bit,=0A=
bump the VMState version.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h   | 12 ++++++----=0A=
 hw/usb/hcd-ehci.c   | 57 +++++++++++++++++++++++++++------------------=0A=
 hw/usb/trace-events | 24 +++++++++----------=0A=
 3 files changed, 53 insertions(+), 40 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 4234591cb4..24eea9d23b 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -208,7 +208,7 @@ struct EHCIPacket {=0A=
     QTAILQ_ENTRY(EHCIPacket) next;=0A=
 =0A=
     EHCIqtd qtd;           /* copy of current QTD (being worked on) */=0A=
-    uint32_t qtdaddr;      /* address QTD read from                 */=0A=
+    uint64_t qtdaddr;      /* address QTD read from                 */=0A=
 =0A=
     USBPacket packet;=0A=
     QEMUSGList sgl;=0A=
@@ -229,8 +229,8 @@ struct EHCIQueue {=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
-    uint32_t qhaddr;       /* address QH read from                 */=0A=
-    uint32_t qtdaddr;      /* address QTD read from                */=0A=
+    uint64_t qhaddr;       /* address QH read from                 */=0A=
+    uint64_t qtdaddr;      /* address QTD read from                */=0A=
     int last_pid;          /* pid of last packet executed          */=0A=
     USBDevice *dev;=0A=
     QTAILQ_HEAD(, EHCIPacket) packets;=0A=
@@ -294,8 +294,10 @@ struct EHCIState {=0A=
     EHCIQueueHead pqueues;=0A=
 =0A=
     /* which address to look at next */=0A=
-    uint32_t a_fetch_addr;=0A=
-    uint32_t p_fetch_addr;=0A=
+    uint32_t a_fetch_addr_pre_v3;=0A=
+    uint32_t p_fetch_addr_pre_v3;=0A=
+    uint64_t a_fetch_addr;=0A=
+    uint64_t p_fetch_addr;=0A=
 =0A=
     USBPacket ipacket;=0A=
     QEMUSGList isgl;=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index d0ea4949f9..315e8813f5 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -72,7 +72,7 @@ typedef enum {=0A=
 } EHCI_STATES;=0A=
 =0A=
 /* macros for accessing fields within next link pointer entry */=0A=
-#define NLPTR_GET(x)             ((x) & 0xffffffe0)=0A=
+#define NLPTR_GET(x)             ((x) & ~0x1fULL)=0A=
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)=0A=
 #define NLPTR_TBIT(x)            ((x) & 1)  /* 1=3Dinvalid, 0=3Dvalid */=
=0A=
 =0A=
@@ -287,7 +287,7 @@ static int ehci_get_state(EHCIState *s, int async)=0A=
     return async ? s->astate : s->pstate;=0A=
 }=0A=
 =0A=
-static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)=0A=
+static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)=0A=
 {=0A=
     if (async) {=0A=
         s->a_fetch_addr =3D addr;=0A=
@@ -296,7 +296,7 @@ static void ehci_set_fetch_addr(EHCIState *s, int async=
, uint32_t addr)=0A=
     }=0A=
 }=0A=
 =0A=
-static int ehci_get_fetch_addr(EHCIState *s, int async)=0A=
+static uint64_t ehci_get_fetch_addr(EHCIState *s, int async)=0A=
 {=0A=
     return async ? s->a_fetch_addr : s->p_fetch_addr;=0A=
 }=0A=
@@ -373,7 +373,7 @@ static inline bool ehci_periodic_enabled(EHCIState *s)=
=0A=
 }=0A=
 =0A=
 /* Get an array of dwords from main memory */=0A=
-static inline int get_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int get_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -395,7 +395,7 @@ static inline int get_dwords(EHCIState *ehci, uint32_t =
addr,=0A=
 }=0A=
 =0A=
 /* Put an array of dwords in to main memory */=0A=
-static inline int put_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int put_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -549,7 +549,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
 =0A=
 /* queue management */=0A=
 =0A=
-static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint32_t addr, int asy=
nc)=0A=
+static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint64_t addr, int asy=
nc)=0A=
 {=0A=
     EHCIQueueHead *head =3D async ? &ehci->aqueues : &ehci->pqueues;=0A=
     EHCIQueue *q;=0A=
@@ -622,7 +622,7 @@ static void ehci_free_queue(EHCIQueue *q, const char *w=
arn)=0A=
     g_free(q);=0A=
 }=0A=
 =0A=
-static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint32_t addr,=0A=
+static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint64_t addr,=0A=
                                         int async)=0A=
 {=0A=
     EHCIQueueHead *head =3D async ? &ehci->aqueues : &ehci->pqueues;=0A=
@@ -1135,7 +1135,7 @@ static void ehci_flush_qh(EHCIQueue *q)=0A=
 {=0A=
     uint32_t *qh =3D (uint32_t *) &q->qh;=0A=
     uint32_t dwords =3D sizeof(EHCIqh) >> 2;=0A=
-    uint32_t addr =3D NLPTR_GET(q->qhaddr);=0A=
+    uint64_t addr =3D NLPTR_GET(q->qhaddr);=0A=
 =0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
 }=0A=
@@ -1406,12 +1406,13 @@ static int ehci_execute(EHCIPacket *p, const char *=
action)=0A=
 /* 4.7.2 */=0A=
 static int ehci_process_itd(EHCIState *ehci,=0A=
                             EHCIitd *itd,=0A=
-                            uint32_t addr)=0A=
+                            uint64_t addr)=0A=
 {=0A=
     USBDevice *dev;=0A=
     USBEndpoint *ep;=0A=
     uint32_t i, len, pid, dir, devaddr, endp;=0A=
-    uint32_t pg, off, ptr1, ptr2, max, mult;=0A=
+    uint32_t pg, off, max, mult;=0A=
+    uint64_t ptr1, ptr2;=0A=
 =0A=
     ehci->periodic_sched_active =3D PERIODIC_ACTIVE;=0A=
 =0A=
@@ -1528,7 +1529,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D ehci->asynclistaddr;=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1578,7 +1579,7 @@ out:=0A=
 static int ehci_state_fetchentry(EHCIState *ehci, int async)=0A=
 {=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
+    uint64_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
 =0A=
     if (NLPTR_TBIT(entry)) {=0A=
         ehci_set_state(ehci, async, EST_ACTIVE);=0A=
@@ -1610,8 +1611,10 @@ static int ehci_state_fetchentry(EHCIState *ehci, in=
t async)=0A=
 =0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
-        qemu_log_mask(LOG_GUEST_ERROR, "FETCHENTRY: entry at %X is of type=
 %u "=0A=
-                "which is not supported yet\n", entry, NLPTR_TYPE_GET(entr=
y));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "FETCHENTRY: entry at %" PRIx64 "is of type %" PRIu6=
4=0A=
+                      "which is not supported yet\n",=0A=
+                      entry, NLPTR_TYPE_GET(entry));=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1621,7 +1624,7 @@ out:=0A=
 =0A=
 static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIQueue *q;=0A=
     EHCIqh qh;=0A=
 =0A=
@@ -1710,7 +1713,7 @@ out:=0A=
 =0A=
 static int ehci_state_fetchitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIitd itd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1736,7 +1739,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
 static int ehci_state_fetchsitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIsitd sitd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1794,7 +1797,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     EHCIqtd qtd;=0A=
     EHCIPacket *p;=0A=
     int again =3D 1;=0A=
-    uint32_t addr;=0A=
+    uint64_t addr;=0A=
 =0A=
     addr =3D NLPTR_GET(q->qtdaddr);=0A=
     if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {=0A=
@@ -1877,7 +1880,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
     USBEndpoint *ep =3D p->packet.ep;=0A=
     EHCIQueue *q =3D p->queue;=0A=
     EHCIqtd qtd =3D p->qtd;=0A=
-    uint32_t qtdaddr;=0A=
+    uint64_t qtdaddr;=0A=
 =0A=
     for (;;) {=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
@@ -2000,7 +2003,8 @@ static int ehci_state_executing(EHCIQueue *q)=0A=
 static int ehci_state_writeback(EHCIQueue *q)=0A=
 {=0A=
     EHCIPacket *p =3D QTAILQ_FIRST(&q->packets);=0A=
-    uint32_t *qtd, addr;=0A=
+    uint32_t *qtd;=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
     /*  Write back the QTD from the QH area */=0A=
@@ -2441,6 +2445,11 @@ static int usb_ehci_post_load(void *opaque, int vers=
ion_id)=0A=
         }=0A=
     }=0A=
 =0A=
+    if (version_id < 3) {=0A=
+        s->a_fetch_addr =3D s->a_fetch_addr_pre_v3;=0A=
+        s->p_fetch_addr =3D s->p_fetch_addr_pre_v3;=0A=
+    }=0A=
+=0A=
     return 0;=0A=
 }=0A=
 =0A=
@@ -2472,7 +2481,7 @@ static void usb_ehci_vm_state_change(void *opaque, bo=
ol running, RunState state)=0A=
 =0A=
 const VMStateDescription vmstate_ehci =3D {=0A=
     .name        =3D "ehci-core",=0A=
-    .version_id  =3D 2,=0A=
+    .version_id  =3D 3,=0A=
     .minimum_version_id  =3D 1,=0A=
     .pre_save    =3D usb_ehci_pre_save,=0A=
     .post_load   =3D usb_ehci_post_load,=0A=
@@ -2501,8 +2510,10 @@ const VMStateDescription vmstate_ehci =3D {=0A=
         /* schedule state */=0A=
         VMSTATE_UINT32(astate, EHCIState),=0A=
         VMSTATE_UINT32(pstate, EHCIState),=0A=
-        VMSTATE_UINT32(a_fetch_addr, EHCIState),=0A=
-        VMSTATE_UINT32(p_fetch_addr, EHCIState),=0A=
+        VMSTATE_UINT32_V(a_fetch_addr_pre_v3, EHCIState, 2),=0A=
+        VMSTATE_UINT32_V(p_fetch_addr_pre_v3, EHCIState, 2),=0A=
+        VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),=0A=
+        VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),=0A=
         VMSTATE_END_OF_LIST()=0A=
     }=0A=
 };=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 0d4318dcf1..8c90688bb3 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -86,15 +86,15 @@ usb_ehci_portsc_write(uint32_t addr, uint32_t port, uin=
t32_t val) "wr mmio 0x%04=0A=
 usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_=
t old) "ch mmio 0x%04x [port %d] =3D 0x%x (old: 0x%x)"=0A=
 usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"=0A=
 usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"=
=0A=
-usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0=
x%08x,0x%08x"=0A=
-usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
-usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x=
 - c %d, h %d, dtc %d, i %d"=0A=
+usb_ehci_qh_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%" PRIx64 ": next 0x%08x qtds 0=
x%08x,0x%08x,0x%08x"=0A=
+usb_ehci_qh_fields(uint64_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%" PRIx64 " - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
+usb_ehci_qh_bits(uint64_t addr, int c, int h, int dtc, int i) "QH @ 0x%" P=
RIx64 " - c %d, h %d, dtc %d, i %d"=0A=
 usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"=0A=
-usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"=0A=
-usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
-usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacte=
rr %d"=0A=
-usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%08x: next 0x%08x - mplen %d, mult %=
d, ep %d, dev %d"=0A=
-usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ 0x%08x:=
 next 0x%08x - active %d"=0A=
+usb_ehci_qtd_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%" PRIx64 ": next 0x%08x altnext 0x%08x"=0A=
+usb_ehci_qtd_fields(uint64_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%" PRIx64 " - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
+usb_ehci_qtd_bits(uint64_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%" PRIx64 " - ioc %d, active %d, halt %d, babble %d=
, xacterr %d"=0A=
+usb_ehci_itd(uint64_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%" PRIx64 ": next 0x%08x - mplen %d,=
 mult %d, ep %d, dev %d"=0A=
+usb_ehci_sitd(uint64_t addr, uint32_t nxt, uint32_t active) "SITD @ 0x%" P=
RIx64 ": next 0x%08x - active %d"=0A=
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device)=
 "attach port #%d, owner %s, device %s"=0A=
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, o=
wner %s"=0A=
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"=0A=
@@ -104,15 +104,15 @@ usb_ehci_port_resume(uint32_t port) "port #%d"=0A=
 usb_ehci_port_disable(uint32_t port) "port #%d"=0A=
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"=0A=
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %=
s"=0A=
-usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%x, ne=
xt=3D0x%x, qtd=3D0x%x, pid=3D0x%x, len=3D%zd, endp=3D0x%x, status=3D%d, act=
ual_length=3D%d"=0A=
+usb_ehci_packet_submit(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%" PRI=
x64 ", next=3D0x%x, qtd=3D0x%" PRIx64 ", pid=3D0x%x, len=3D%zd, endp=3D0x%x=
, status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask=
) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"=0A=
 usb_ehci_guest_bug(const char *reason) "%s"=0A=
 usb_ehci_doorbell_ring(void) ""=0A=
 usb_ehci_doorbell_ack(void) ""=0A=
 usb_ehci_dma_error(void) ""=0A=
-usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%x, next=3D0x%x, qtdaddr=3D0x%=
x, status=3D%d, actual_length=3D%d"=0A=
-usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, recla=
mation status reset - done processing"=0A=
-usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08=
x"=0A=
+usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
+usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
+usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
 usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
-- =0A=
2.43.0=0A=

