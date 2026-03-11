Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E6CFD0648
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dy4-0003AM-IY; Wed, 11 Mar 2026 03:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxl-00030a-7E; Wed, 11 Mar 2026 03:26:37 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxh-00052E-9R; Wed, 11 Mar 2026 03:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9kFohjdz2tYKzJ4TdnB/IeHq+ZwxNkK0naAMPODFRgMa4Z//nmaf4HwtzZu/OZhq8jiQUUy39wR8BYAhxQlc7njoKZ5ad4/7hJbkvhKVyloBgJBrCeFR3lAlZQa/j2xsE/Gt30Y0mxLLDHBUudmc46RH7Jq8Vw0/g3dDfidbX08owuGcPRuyrt/dI08vdVi2l6vWF94I9S6kVSUtMw22Ph0EBheAKST4/f762hFWQklnuXSWTSKli5BymHwZbVQ2Dzl3dl8fCm7HCCgTqXHhrodtCLlJOGZe9uEuQrARbGzBlwTEg9zG6a3uAWf+8z5WvtqpIH69/itEbZDXKwJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXVriGQlrCjHX2dqzuaTRY7bL/1pesiQkAJDd6l5txc=;
 b=cA+9hesGTM6Xx4vde4TjLaDNrBrmge3AW/7kfkjAZcgEubn+hJ+a3Rr6gVieLv7kiVxlsccHUGcMiF+aSXciLcVEjXgRytEgmRZHckfn6/AliXP9SSmll/sHQI8U8jXpxh7NX5D5vIYQ4RuyXxQmTBgbRzue5p7w3+HhenHAGnPHRbUPZ1yfMmkO79bs57zbeZ4NQVgUAWO0z66Ntnq6u00HVXR+Aq/cGmE97x2nLX1EbvRCc1NjerMIgzRyNTMh+1ervvYuwGPaa0WO+I2SzNPWvwFrSXm2tL22QY/sGL8Ic6yekvbMndMrt1NCiGBV94txBjpJmh6lhckam3Dj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXVriGQlrCjHX2dqzuaTRY7bL/1pesiQkAJDd6l5txc=;
 b=LMcB1rDbZMB/HneEJxT6wannhOYFtzaxRUM997J01Gx/ZlN3tdv+DdxpCKGty8JzVt+ENR6hhlcMCyPUCGo9B1cXerwVH2FaVL4NOTjW2oCpz8zaL+w9h8pCP63kt0qAoh9KAK4J6QTWgj5lV9E5oFYXWcPAlfKPNagdKuMdxVNpEbnzL3tX27LRPuEeYr8v8r0onfkMPOny8ZR8hxEt96YNkfHMjlyJSPBcmxVkPA+PCeGz24/a4Q91y+umb2kSUeXe0A8jQ31IGo+XVVOX8Cz4DxqJrFmwh9LDnjBWGgXEUAB3AT34w95duen32BgOznlOShbg2/SYkvKzi0QyNg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 03/13] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Topic: [PATCH v1 03/13] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Index: AQHcsShaZnUucCOzr0mk+y9iYEFGBQ==
Date: Wed, 11 Mar 2026 07:26:19 +0000
Message-ID: <20260311072614.1095587-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 25ade40c-bff6-42ed-0cb5-08de7f3f7d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7142099003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 0aqyeD6lRnYhLre/DFB6VjmrPbKv+gUZjQyhbl0PJACsc5JefnEntpdb1MYJKFq+B+XdZsZITpqJM2qfCNVmgI7VwY0cFTpkO4LLRKAPEq4IZtZqtvnyzhQLOU3k05E0bQjqVp8OyY9cntzo3SqbsUsRsQ//yNIO9LqwbQKX9umclkcyxHY6knOghQcRupd9Hhe/RllozoBA6mF7bfptEg6nzgkh0gLKnyctFHYt9TI8IvEXGcAhPrQHpbua7tXLgyMOAKoWQzy2P8plMoS7rLiwm32kUV8tlUu8NZaKySmUJW4Ob0Zoa6dS22uSXHy+9A6jRs6po0wan7ZGHI3vQ2W/ASmKMT1t1ZUZKOLYCSYgA1HIn9hPBdXdlca4/9UKxNcKFdOQVMXRn1mPtXRGrYO5R5TviWXOdCcoUOzgVjpkKRcG0aFkbJdPEYBS97y1gA5aMsRiF2OZ0iqRQsu9q5Tdo+DdIQ6PSXcDBDrEtHTmrsivARwMC5GJ7fGRhN0lRVJcITWgytkm6myp3N5y0IdAgq6NO2PuUTR1bCIcimgLcOzmSWjhGJi0un/B5H8dnmdTEnKn1BD5pdi8oST4MOCT4Iw6Qzi6wbTGnxpHrKO2vi8ZZMdjzbJqlTCaJ8mXf04N9soBHjj9QndFir/zs0SIxjyxgBevm9qa03B2Hfjw5hHe7mk+M0ZdGowVx0bNgRvCYe6S17oeGXW8poY+cUMmjYpLvT3JAz3+uKTfIqf0q3SXSvzMxoxR/HqAJ4x+ewwB5IE5cEa2lOuo4iKk1ggO2XDb8LAWf2WQA2MUeTI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7142099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8xeQLc3V6G7Iadc669sHkpnqyQFsun566esearhaTxS+Kg+hwRQHskei+w?=
 =?iso-8859-1?Q?fIvVKf7NJJny8NaG3YFYXt356hyxhyR4kaVQzYW4cux9MO1Au55HuHG2g3?=
 =?iso-8859-1?Q?EeQiJgN3m6vIvNfS3bFgeOy7bPekS5JjDns9yTB7Vu1vC5dP82peOETIJ3?=
 =?iso-8859-1?Q?ulDHFgXoYnvHuBRelFgxBQqsWG9+7TxLKJnpv/M+URW5YtqkAxexFA8cGy?=
 =?iso-8859-1?Q?O7+0TO4UyUPUH8gRiMh9V1p7de9Du2oSC/t0Drh3Fs6IIYdNY44hcCL0XS?=
 =?iso-8859-1?Q?I04AWh29N43Wd6ci3cGwrlZcp4UYoNDtJBqbbeX91v5hQdmYuO5mzXjROx?=
 =?iso-8859-1?Q?2jclB9horuT0lpeWCbIJI/9K74pGqZy0+07OECiWDOc9UjxDwDQ+/rlFgB?=
 =?iso-8859-1?Q?I2zYG4NdALZBLmC/MYzEHeU6J36nr0HywwJHi0FS/HiUu2MI6acD+Uisw3?=
 =?iso-8859-1?Q?wI17lT9Sc/+X1qKkHZY7dwNuAcECzVPaOB/eH3scj+4qyRgfOpRvl5Hm3S?=
 =?iso-8859-1?Q?WcKZuOEK3rhyDJRgYNvOYhNuuAQY+jjIrSH/+VfWBdauOgdQQbVeOO7XNI?=
 =?iso-8859-1?Q?nQqTWar2rk/sjMOKZCYtuEkvWm5bIlxIgPHR6f7EVooaA7SBk2FsMnMAA7?=
 =?iso-8859-1?Q?4ccKi26nWytwk+GuSL7FsdaHRcMPGSdDMRTFIAYOd8AvOeSqPL+wx0WwRf?=
 =?iso-8859-1?Q?zK8hjdzKoGPmrzP2m+j6ZYVEFSkT8BexLGMPO6nrrIRIvDnvioh67c5KJm?=
 =?iso-8859-1?Q?jcXDw4yJe7taOk45+r3B9LYv6vzDhPFuTg2uPAJStFrk7XVCUX1G3m9EzQ?=
 =?iso-8859-1?Q?UYsgcdQFvm8stlT3/znSHoIGoANQ2J8eAbHaQigLUwq6YQ5Ut2ppAsSp+V?=
 =?iso-8859-1?Q?qrA85k4AM1VYtDPal1M03ex2ElEddbyJBS0XWMyde3GJZpgUZ2B3KqWRBH?=
 =?iso-8859-1?Q?2ccGGWJ63Hy5hP0RxRaMqCZM4yJ5anD+80KH4rVN5tB/LS+aUhSA2Td5Y2?=
 =?iso-8859-1?Q?REEfBcMe5vg7CUxRqdAyRKA/3XcGQWCChWI8jsZKo4QfET3VVgHrLRn6vy?=
 =?iso-8859-1?Q?COmEyYqArJkegEZKf56jbP5kHaCJFZIsdub218HDHCZnJJ9aXruYwwwYK/?=
 =?iso-8859-1?Q?lwUVSGPfNQEd+xtk+hbkRFN6a+csxS8irPZQ3QN7B72N5qm6O2CeGOviKh?=
 =?iso-8859-1?Q?xCoJ1VIJEz32giiYkRAPw+ThXa86s0zPYDxlnzBvxSP6+IXubuvKO4wV5+?=
 =?iso-8859-1?Q?n5K26pnii5Vysw3vqmoxjP8Ff9VVBtT/ltR41NIgdXS9DHnqN9iYIVaOJn?=
 =?iso-8859-1?Q?3xrGSJfmBQEuBArpNHyVOUme00aEuAqI2ylby14WEk9BIj77iRkrIP1EtI?=
 =?iso-8859-1?Q?XIwQaU8ykgiwmExbqkygNwYX9weg7GP6lktOK3mkCLMy98+FlUA9IMfXlc?=
 =?iso-8859-1?Q?kxIvlorfHN9sAsV8bjSgrdVdMX/zpi7enk3vliTUzeVjG1T51JJNw7Q4a/?=
 =?iso-8859-1?Q?aKcoJ6D0BLnfnZnIBnENVaZl+DenXejNHmE6yQh7GVFwIanEc97C/NExNN?=
 =?iso-8859-1?Q?KLkfuFb4K/i5K+UaMCRyrbMnSOwKvv6VyRUgMjEsMM9BFB9X3JjWprpFLP?=
 =?iso-8859-1?Q?vHDhmBUEP3FRk7l852V3Gge+WkVkNPMp6XIMl2l3ts+RZ0XpC3vkMef7gj?=
 =?iso-8859-1?Q?sPiPumrNJiVAekqcb8Drgv6O8b8boYf8r/T9z3KzAOBRgVeAdXDjT55uOh?=
 =?iso-8859-1?Q?7XBuFJ24wt+bq5jV89btTc2t8ofVrI7S98OgyWRxw0LqqccToCOAZTssx1?=
 =?iso-8859-1?Q?mBfw79Bshg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CkortDjRlhjeflZiZ7APW3f0eeaDYNOafVYrv+/zMcL9pL+KuRSB53SBYS3qcJt/YI+IEVExnq4O/WURFWPvlyf29t9XTG6vkyhrAQpMtVRGyIHbIiRB+q2bwLP2d6sRoYmr3LOwxqYDH11kF5RNnsiv1QhI0cpqIvJnY1vip0SU6GMCN0UclL8A5LzrB9trBDrkVsTiUt7J94JO1FW1BOchzOnEiuT6cdiZ/0ujFJ2gC/b8f+qJEKOsjcTr5wiLfmq0nQtmxIqXmJ78HJ/Mo9Z3vdVFSwFTmX4W8CMHdcAfhtw5yZTUZ6vqMD2araYkdGmZC0SoKquVDPpBiMHozw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ade40c-bff6-42ed-0cb5-08de7f3f7d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:19.5984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9BFI9+PCYlQ5bj4UF6jOFnUQejUdqgZoKY9KEb5JKQBFRDrRU7WjVInLzgOTsUlXLb5h3cOZ/BECdpH1JK9bzqv5JOYbhTDbXBlf1uVv8o=
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
    #define NLPTR_GET(x) ((x) & ~(uint64_t)0x1f)=0A=
=0A=
so that link pointer masking works correctly when descriptor=0A=
addresses exceed 32-bit space. The previous mask (0xffffffe0)=0A=
implicitly truncated addresses to 32 bits.=0A=
=0A=
This patch does not change the on-wire descriptor layout yet.=0A=
It only removes the internal 32-bit address limit and prepares=0A=
for later patches that will add full 64-bit QH/qTD/iTD/siTD support.=0A=
=0A=
Since the type of fetch_addr changes from 32-bit to 64-bit,=0A=
bump the VMState version.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 10 +++----=0A=
 hw/usb/hcd-ehci.c | 67 +++++++++++++++++++++++++----------------------=0A=
 2 files changed, 41 insertions(+), 36 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index ed44935302..df87f8145f 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -226,7 +226,7 @@ struct EHCIPacket {=0A=
     QTAILQ_ENTRY(EHCIPacket) next;=0A=
 =0A=
     EHCIqtd qtd;           /* copy of current QTD (being worked on) */=0A=
-    uint32_t qtdaddr;      /* address QTD read from                 */=0A=
+    uint64_t qtdaddr;      /* address QTD read from                 */=0A=
 =0A=
     USBPacket packet;=0A=
     QEMUSGList sgl;=0A=
@@ -247,8 +247,8 @@ struct EHCIQueue {=0A=
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
@@ -312,8 +312,8 @@ struct EHCIState {=0A=
     EHCIQueueHead pqueues;=0A=
 =0A=
     /* which address to look at next */=0A=
-    uint32_t a_fetch_addr;=0A=
-    uint32_t p_fetch_addr;=0A=
+    uint64_t a_fetch_addr;=0A=
+    uint64_t p_fetch_addr;=0A=
 =0A=
     USBPacket ipacket;=0A=
     QEMUSGList isgl;=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index e2ff0f5874..87c3991313 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -71,7 +71,7 @@ typedef enum {=0A=
 } EHCI_STATES;=0A=
 =0A=
 /* macros for accessing fields within next link pointer entry */=0A=
-#define NLPTR_GET(x)             ((x) & 0xffffffe0)=0A=
+#define NLPTR_GET(x)             ((x) & ~(uint64_t)0x1f)=0A=
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)=0A=
 #define NLPTR_TBIT(x)            ((x) & 1)  /* 1=3Dinvalid, 0=3Dvalid */=
=0A=
 =0A=
@@ -286,7 +286,7 @@ static int ehci_get_state(EHCIState *s, int async)=0A=
     return async ? s->astate : s->pstate;=0A=
 }=0A=
 =0A=
-static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)=0A=
+static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)=0A=
 {=0A=
     if (async) {=0A=
         s->a_fetch_addr =3D addr;=0A=
@@ -295,7 +295,7 @@ static void ehci_set_fetch_addr(EHCIState *s, int async=
, uint32_t addr)=0A=
     }=0A=
 }=0A=
 =0A=
-static int ehci_get_fetch_addr(EHCIState *s, int async)=0A=
+static uint64_t ehci_get_fetch_addr(EHCIState *s, int async)=0A=
 {=0A=
     return async ? s->a_fetch_addr : s->p_fetch_addr;=0A=
 }=0A=
@@ -372,7 +372,7 @@ static inline bool ehci_periodic_enabled(EHCIState *s)=
=0A=
 }=0A=
 =0A=
 /* Get an array of dwords from main memory */=0A=
-static inline int get_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int get_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -394,7 +394,7 @@ static inline int get_dwords(EHCIState *ehci, uint32_t =
addr,=0A=
 }=0A=
 =0A=
 /* Put an array of dwords in to main memory */=0A=
-static inline int put_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int put_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -548,7 +548,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
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
@@ -621,7 +621,7 @@ static void ehci_free_queue(EHCIQueue *q, const char *w=
arn)=0A=
     g_free(q);=0A=
 }=0A=
 =0A=
-static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint32_t addr,=0A=
+static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint64_t addr,=0A=
                                         int async)=0A=
 {=0A=
     EHCIQueueHead *head =3D async ? &ehci->aqueues : &ehci->pqueues;=0A=
@@ -1133,7 +1133,7 @@ static void ehci_flush_qh(EHCIQueue *q)=0A=
 {=0A=
     uint32_t *qh =3D (uint32_t *) &q->qh;=0A=
     uint32_t dwords =3D sizeof(EHCIqh) >> 2;=0A=
-    uint32_t addr =3D NLPTR_GET(q->qhaddr);=0A=
+    uint64_t addr =3D NLPTR_GET(q->qhaddr);=0A=
 =0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
 }=0A=
@@ -1279,8 +1279,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
     assert(p->async =3D=3D EHCI_ASYNC_INITIALIZED ||=0A=
            p->async =3D=3D EHCI_ASYNC_FINISHED);=0A=
 =0A=
-    DPRINTF("execute_complete: qhaddr 0x%x, next 0x%x, qtdaddr 0x%x, "=0A=
-            "status %d, actual_length %d\n",=0A=
+    DPRINTF("execute_complete: qhaddr 0x%" PRIx64 ", next 0x%x, "=0A=
+            "qtdaddr 0x%" PRIx64 ", status %d, actual_length %d\n",=0A=
             q->qhaddr, q->qh.next, q->qtdaddr,=0A=
             p->packet.status, p->packet.actual_length);=0A=
 =0A=
@@ -1389,9 +1389,10 @@ static int ehci_execute(EHCIPacket *p, const char *a=
ction)=0A=
 =0A=
     trace_usb_ehci_packet_action(p->queue, p, action);=0A=
     usb_handle_packet(p->queue->dev, &p->packet);=0A=
-    DPRINTF("submit: qh 0x%x next 0x%x qtd 0x%x pid 0x%x len %zd endp 0x%x=
 "=0A=
-            "status %d actual_length %d\n", p->queue->qhaddr, p->qtd.next,=
=0A=
-            p->qtdaddr, p->pid, p->packet.iov.size, endp, p->packet.status=
,=0A=
+    DPRINTF("submit: qh 0x%" PRIx64 " next 0x%x qtd 0x%" PRIx64=0A=
+            " pid 0x%x len %zd endp 0x%x status %d actual_length %d\n",=0A=
+            p->queue->qhaddr, p->qtd.next, p->qtdaddr, p->pid,=0A=
+            p->packet.iov.size, endp, p->packet.status,=0A=
             p->packet.actual_length);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
@@ -1405,12 +1406,13 @@ static int ehci_execute(EHCIPacket *p, const char *=
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
@@ -1525,7 +1527,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D ehci->asynclistaddr;=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1575,7 +1577,7 @@ out:=0A=
 static int ehci_state_fetchentry(EHCIState *ehci, int async)=0A=
 {=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
+    uint64_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
 =0A=
     if (NLPTR_TBIT(entry)) {=0A=
         ehci_set_state(ehci, async, EST_ACTIVE);=0A=
@@ -1606,7 +1608,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
 =0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
-        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "=0A=
+        fprintf(stderr, "FETCHENTRY: entry at %" PRIx64 "is of type %" PRI=
u64=0A=
                 "which is not supported yet\n", entry, NLPTR_TYPE_GET(entr=
y));=0A=
         return -1;=0A=
     }=0A=
@@ -1617,7 +1619,7 @@ out:=0A=
 =0A=
 static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIQueue *q;=0A=
     EHCIqh qh;=0A=
 =0A=
@@ -1669,8 +1671,9 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
         if (ehci->usbsts & USBSTS_REC) {=0A=
             ehci_clear_usbsts(ehci, USBSTS_REC);=0A=
         } else {=0A=
-            DPRINTF("FETCHQH:  QH 0x%08x. H-bit set, reclamation status re=
set"=0A=
-                       " - done processing\n", q->qhaddr);=0A=
+            DPRINTF("FETCHQH:  QH 0x%" PRIx64=0A=
+                    ". H-bit set, reclamation status reset - "=0A=
+                    "done processing\n", q->qhaddr);=0A=
             ehci_set_state(ehci, async, EST_ACTIVE);=0A=
             q =3D NULL;=0A=
             goto out;=0A=
@@ -1679,7 +1682,8 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
 =0A=
 #if EHCI_DEBUG=0A=
     if (q->qhaddr !=3D q->qh.next) {=0A=
-        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\=
n",=0A=
+        DPRINTF("FETCHQH:  QH 0x%" PRIx64=0A=
+                " (h %x halt %x active %x) next 0x%08x\n",=0A=
                q->qhaddr,=0A=
                q->qh.epchar & QH_EPCHAR_H,=0A=
                q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1708,7 +1712,7 @@ out:=0A=
 =0A=
 static int ehci_state_fetchitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIitd itd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1734,7 +1738,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
 static int ehci_state_fetchsitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIsitd sitd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1804,7 +1808,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     EHCIqtd qtd;=0A=
     EHCIPacket *p;=0A=
     int again =3D 1;=0A=
-    uint32_t addr;=0A=
+    uint64_t addr;=0A=
 =0A=
     addr =3D NLPTR_GET(q->qtdaddr);=0A=
     if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {=0A=
@@ -1887,7 +1891,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
     USBEndpoint *ep =3D p->packet.ep;=0A=
     EHCIQueue *q =3D p->queue;=0A=
     EHCIqtd qtd =3D p->qtd;=0A=
-    uint32_t qtdaddr;=0A=
+    uint64_t qtdaddr;=0A=
 =0A=
     for (;;) {=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
@@ -2010,7 +2014,8 @@ static int ehci_state_executing(EHCIQueue *q)=0A=
 static int ehci_state_writeback(EHCIQueue *q)=0A=
 {=0A=
     EHCIPacket *p =3D QTAILQ_FIRST(&q->packets);=0A=
-    uint32_t *qtd, addr;=0A=
+    uint32_t *qtd;=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
     /*  Write back the QTD from the QH area */=0A=
@@ -2484,8 +2489,8 @@ static void usb_ehci_vm_state_change(void *opaque, bo=
ol running, RunState state)=0A=
 =0A=
 const VMStateDescription vmstate_ehci =3D {=0A=
     .name        =3D "ehci-core",=0A=
-    .version_id  =3D 2,=0A=
-    .minimum_version_id  =3D 1,=0A=
+    .version_id  =3D 3,=0A=
+    .minimum_version_id  =3D 2,=0A=
     .pre_save    =3D usb_ehci_pre_save,=0A=
     .post_load   =3D usb_ehci_post_load,=0A=
     .fields =3D (const VMStateField[]) {=0A=
@@ -2513,8 +2518,8 @@ const VMStateDescription vmstate_ehci =3D {=0A=
         /* schedule state */=0A=
         VMSTATE_UINT32(astate, EHCIState),=0A=
         VMSTATE_UINT32(pstate, EHCIState),=0A=
-        VMSTATE_UINT32(a_fetch_addr, EHCIState),=0A=
-        VMSTATE_UINT32(p_fetch_addr, EHCIState),=0A=
+        VMSTATE_UINT64(a_fetch_addr, EHCIState),=0A=
+        VMSTATE_UINT64(p_fetch_addr, EHCIState),=0A=
         VMSTATE_END_OF_LIST()=0A=
     }=0A=
 };=0A=
-- =0A=
2.43.0=0A=

