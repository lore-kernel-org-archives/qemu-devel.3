Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3336FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBY0-0005KN-He; Fri, 24 Apr 2026 04:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXj-000555-Op; Fri, 24 Apr 2026 04:05:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXi-0001I1-6m; Fri, 24 Apr 2026 04:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyw7qrSkXwwPMmakcLjBNEwWbCoHLJA1VImle49dlGjHqsWmVOr6ovF5xO2xASQrjM6U1KEkvIeV+mUFQi8oAAhaWGX1femuHCMso3zYBuTYQJxmUtAa4DrDufgbVCAY99F7cgsbRH2YPE4de2YSrZwZnia0ASnxZfKbmfRiQTTqYeE08Lt80hhZu8Cv6Fso9uuDDiLTWSRvgRR2xoV6aSATruOXaut4pw+DgxHBWZdd+0VXSO7jLVtWSyLbjVA+AC/Gq4vjf9+1jS9Wr0wutuHmzt1yi2YxgNIIdU6S9KKnoXjEZXDdHT8oy3Xx3G5urwEu8Nl77xXvh72Kmzc52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BKsRXVMs7h+1dZJ/njXNJKH4N4rYup2Am3UmnfBNkM=;
 b=uCLmHtVO1nTv0PH1EoLou0yrRbqphrAOoV87GTGgQNBIgVZ9L6OzTuLNPPa2JYQ8MtgZm+2Lqa+HAUiViLmmTIHUbfHAq5RKRAYqru+6n6zR9hnLpBgEkN/L1Os1pzBYE07l5QJynceokdF7id8jL2igPdHqmsalpwAQsKWbFkMF2Rfe80UqWHz5X34zUjaTN6lEDSJTUhh7RXYWN2y6ZAtKfR/hbjgYlMH522w8gPy71c+7tL2u69DRWu1Gd+hz1uMOjCqArMSFO3jSvfddxsontGOSq2/UCeIWTG4Dr1z8bW7RpxkFCDKTqQQ9xnpx1yhVz19Qgkm7zUTrqBxJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BKsRXVMs7h+1dZJ/njXNJKH4N4rYup2Am3UmnfBNkM=;
 b=E/3gQMUjy9hg0NkvZezzD/HC74II+Wf/FoZlqCizLIJOfUUar+SfHFYhj+gzPobu7MoHt1MbsMU0hl216lTXEGhnW4kgl8axzAZSjHeMkKYOiT9Y3pRneGsF1pJpN3EiqbUt6KZT7ECwJN/Lx98ZZmaRhMwwS+dJsz8YDjIlEQ0ImfJGyEscGyGIN6WWlkWtEoyjqWH/B1Xfugfzql2f/x6G45ojHD+HZfrTAgI5uV6rzC2YOKGsBK4uq18g5k+2Y7r2wPwU6JqI6M0+eDW/ZYGkuEbdxpL1apKm2tqUNQ9nBgMOPG2xrSMstiM9m/KS1QvmvdVMeHqj67sZUc6jpg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 14/18] hw/usb/hcd-ehci: Implement 64-bit siTD descriptor
 addressing
Thread-Topic: [PATCH v5 14/18] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHc08EdGjOODJrvJU6g371VfmgVgw==
Date: Fri, 24 Apr 2026 08:05:28 +0000
Message-ID: <20260424080508.53992-15-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: 8850cb47-c264-47ae-66ca-08dea1d83f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 7ayZ83vKXdeJRpA+UJ7FrRh0tSCCcS7rCaapZntCFSQgwqe7/Ox5aXCc8GfCYXdgfVcAH4vs/0dERJ8z6/IBff7ecMqifIcZW6bDWhGIbPPS842+gJH76Gr0gh2de7F3tH+SjfvhQvGIXKhqVGRs3W/Zm2JlZCzO5ZwLvGbXJ+XfGnmoAGXs1x31Eg9bBYrJZHNEUOWAE6AGCEEf9WGBaOY7vd39/5O4/OYOaICKqMF/N47PF4njnkR96srNmIHXQHp770CQt2HNRpornH/+xZhsZE0HvZRCFw5+FGUs/MxZoWWNCQGXb3vp7TnT9hPnI8NittXKplUkjaClhqQ0cTen1kTH3ZnLrhT4KunF/uo2g2vVABJikGHzE8+LPgDMZ1EoFVqz2aUP70A5cVrB8cUCoGfPJXCvTBuMRFz+S+hwlVXMqn5V7kBORyIIGeKoUW6yvZ3dZinKXMaRUhIayuDK5QcOVddW7PkRBVQZYkL34EeKfF8VqBh2xLlM5XJ1jcCoaGEx1cJ4FRLUX9hXZ5DGYnhkgcpvJy9hGx96opfZ1pdPQ9D64YfrilW3Eb6rYnX3v9JCsr9FQ/Wv5ylp551MNAqEoKL2wMNbac6sZfT8iowujkxk6qj6g+LjNLrNw1j1tbLUAIcDMZ+Yx00FfLyAGdYn77WWa3QMsESHGvv1W0dYcQpKd/Ise9KLZwiZglG/zYIsQZTCmX/LbKXALooCPH1LGkM+bFO8WHOPPwW9ZCpSrZKUiaKuySe4kG7Yhr5vBZEVKA9BSsOZsbPMVMv36B26OyfRfxP0jtaPZvJchFNPAWSKPxutrBvgbmoO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/6ogzO5A3sJQjJ1wV/csFXj3IVehFDV2rp6gN9aLDCaHDELeteuOdLWC3C?=
 =?iso-8859-1?Q?s7P1SpcOB/zzdAlkvDhwKekv6eWdAKy9aImv6tUGwE5w3oEM0oD4+P3XXl?=
 =?iso-8859-1?Q?u/sWAuzcXYO7B123Ur/O3y52o3NhHAss0GI7PdaQnDEdNU8RTr/1MuFQUz?=
 =?iso-8859-1?Q?vxTAxJvJeKM8vd30xf2S8j3bf2hf1BAzhSBYF4Z0DNENiolX8sZUGMmNes?=
 =?iso-8859-1?Q?Alzt5jCR0cmP2ll1JIquMFUUbspcCopsAd49h8MQzTO/KgDZwhRxgK6nDX?=
 =?iso-8859-1?Q?LCPt0HCDcNDP95lq10dRNlKdqEj5xXmmYk422w2fikitjPxEJl9fexMd/l?=
 =?iso-8859-1?Q?qsKAb8vytzBZBPtYZa/a2TXHaZgFxy0LEKmnmUldc82jn/IUVvXeXhvPnv?=
 =?iso-8859-1?Q?/e6j5CwbG36pv4duXIPlpXnKDqehQR9lfHVt91zmT+VeMYqKV5hcit5TWr?=
 =?iso-8859-1?Q?/jBcZPEkuxTKbmJTAg2MxqONVFcYyDFTZfCx6v/F3IIJIG0sHXP3sGU1kb?=
 =?iso-8859-1?Q?UPgvGeylnqrAYkkaHu8lmjI6NBYSWRQVxhBLZPoPhP12GkaE7OOqfVVlYh?=
 =?iso-8859-1?Q?aBVVjy7+sCJqsuYCkOqcRW556Q61acTMTeV+UsOSZiG+7ExZszvnxlb+Ae?=
 =?iso-8859-1?Q?pEN6sCXP6QReDCx4Bb4LkL+PjSJWsBgoMGBw5+lFkmR8FP0aVLvyBoeqKr?=
 =?iso-8859-1?Q?yiJyhGTHplrRBrnl8etWQ5JU0BcZmErkUBDMXKxLb6a87PV76aWH0pBUyT?=
 =?iso-8859-1?Q?beXZb8md8KdTix7kZWSmoIb1omGk9tN5UncTLegiKVgLPCOH8QAJxpZzN/?=
 =?iso-8859-1?Q?ufpjHeWXv2t/HC3Mf9oLhaG7XNSPkkCW7lqrK/mLXB1gvO2FwRefG5r0VE?=
 =?iso-8859-1?Q?A6sUD5FyJLwJxxwUBUEyPvFK/8umku4+l3OVwjlJeCuCruzJD+3cr0HU7b?=
 =?iso-8859-1?Q?0D6fXoaPYxbV4QSNNb/nKaVabvsICCxkgbGzEe4s5mRMIVDwecgZoMpyJY?=
 =?iso-8859-1?Q?ie3fEOeJWE8q8BOIhfMtqEJo+Pi6JBJESBNU3lJy2pwX6Ttkw1hgc4DY62?=
 =?iso-8859-1?Q?1/gLpyR1Dk+j34GSQu9I65b/IPl0n3RobfhL4PHKXpBgGhYC97jlA/YLFM?=
 =?iso-8859-1?Q?jmjiKSJ9Fw+/3ckL1sOupkffq4vMJ1gZ3cxZpbXjkqGz6yeYPl6hTw4RwZ?=
 =?iso-8859-1?Q?9iTOS42VtHO/n5JAt8jTqeUbTQHaO6OmW+cmnqyvX0/sQe2g65WHs9yAfU?=
 =?iso-8859-1?Q?b7Z7gEblcEbSCip1RwvGgygaorv3N/iFdxWFzvvt9HakIwS8RE1/NZqJ7i?=
 =?iso-8859-1?Q?MJs4VCDKgpZkVdnneOzGb5IiCBE/Mj+J3h5eYTCtvuknu2FgtQ/X8duHQJ?=
 =?iso-8859-1?Q?GC87Plby8tOoMO12I8FbiIBkX88Qm7lRrejORDxWowLJVoSzzcNKe4Z/ZY?=
 =?iso-8859-1?Q?Lx9gpqK/cuF+UezyCKUhxnir6fqE4vJg0lPakCpmIIXLvgmNyKSe89SWwO?=
 =?iso-8859-1?Q?8qH1yzsDcc4swzxfN2JxYVYmxvjyf6tKTFnVp50qHx4A5G3wf0fFe2x6cF?=
 =?iso-8859-1?Q?TjAiaVy+7lPHU4AIRCBCw5q+GYAnvCT+cpM2FqenVlJMC9EeV6BLaUxVSb?=
 =?iso-8859-1?Q?Quef6FFOqbOPiwD4WmOvDvZQ6cxxbNzoH5UR6P3t7leBppMDIwMrV9G9Fr?=
 =?iso-8859-1?Q?nj5Wc/3CvcWd1OBA5Ay/PcZBsFL4EQthDFg2uRdCtmlrtbJTPYQ8YbVsQN?=
 =?iso-8859-1?Q?TtVnAqhrmAXIai1Bux79Dadl6sNfs6HNo8pzRBqkGBbimL49Y8dkCzTW89?=
 =?iso-8859-1?Q?h/5DbYG6bQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SSrUneN5p2e993WtSeHp5wpYvH30VtNNZt7Is8qLpy8HPYoAfMs9ax0ja22J6B/JGiOgKPbGMN4Sm/YXHFNHyUXS/6ToyshnwcnTdsa3yZzURBJOkcb8lUTPOlS71zITXecEJ28/Q633Jkii7VIv5fQmY4olADU1hn64DWth/llZ+TjT7J0YBNj7o/nYkgw4bBzDXpXKvq3Cro+whcjKIRhYcW3K+oPjTaWPfe1C2a+ACbNTuK/VxsdPW1ZqJNKO8ZDN5bRuJfKMGNAWzIBHg4Su6z/xtOntW32abL9SyB1gOBYVF3dD/Xbs8QKGsKKX9036aW/7HN+AYuhl9vRFSw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8850cb47-c264-47ae-66ca-08dea1d83f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:28.4622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjTicUWbGzg+O0cw/ovKeuvTxyGU3HIBFVjrBJuGA1vfOHiu5x6gs5/BlGb/fQEHYNMquIR0Qtu6nNaqgQhg1te40XC81ugpJDuVjrZofBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
siTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the siTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 43a01a796f..dfeb8ef70f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1792,7 +1792,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
         warn_report("Skipping active siTD");=0A=
     }=0A=
 =0A=
-    ehci_set_fetch_addr(ehci, async, sitd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, sitd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
     return 1;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

