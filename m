Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E54FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXv-0005Da-D6; Fri, 24 Apr 2026 04:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXd-00051U-8Y; Fri, 24 Apr 2026 04:05:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXa-0001Eb-RE; Fri, 24 Apr 2026 04:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGnbn5sFb8TsxYoq3MOPbSbns1wTbiYpHfeVre+pJW/jdl+KKfpOkI4dORbBz4Z/lz/IU/pYDUFq/BRQ9YC9Al4sofC9fR7GPOK0YWmh8Q4NEOYpQsAAUcMV97SIqqHj/8RMxfMMZ1Tyomzhc2Fe+hs03cskOSAQttH0WWyI2EmcrAa7GllcoNQUgcvgJycdbAga00tOZ1WFBo/2uF1wpsOOo8JkZIYvbcnyyU/XpVwWSuUYC626yCAMIdWphuNe1BqFDFSM178906f/+3CsXAlvCCcTK3ob1u/BJB3UFe9ikwwJDCmcQGZN7brV9/bftRCA1rqCaQKm4THSKXLV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIY1fG4h3zp2izRpjJocKSCoNpoYrGe5n8/GcTDKgfA=;
 b=DvmJvFbL6wWzFPFUoPWlII2c3z8CNt/9eH0xqPRYi0Hbr8+Z15vo1y71XMpjeMWIa6NaSg7ugBSHkLHjI9r/8YI1r2ET46mprggAyvAIonrNSRQbATnYQRftHVMRXhA4XfUj750o8FWxQ8m86s/6b4ocr2FmwxCvu6NSKAEF0jbvHa4XECtGBw2G4gEXb7z4Was/nfPhQwOTM/uxIAZqdSHahp8TJkkqamdqkDfc8doPK03W3uECtPeMyMSVgv0ckLSL6kY5LyFEMomUufKrBVfPjDLzXDvJT1eJtlk5N/P3sx6GzqgrHJCuOX6/ncrGukzaQj0eocMjWSUTEl4kgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIY1fG4h3zp2izRpjJocKSCoNpoYrGe5n8/GcTDKgfA=;
 b=byajdaLYe6m17ORLV5VNu2U6+nLXaRnYNWzx/uTNeycbh9W9caT5GyOxlCBF/JypzneQY3dz+Us96ePBZB5k7IdiaImSdgzf+5/GZnSouKXxVr+0YgxwCsDga4Er2CEtA1bX9OLGxwTWg05l0KQ38EDp6wBm1Jl0bgv9997xbzjGJsWWxOUSmZ+zY8bIuFtjAEUZSXKRDRnHMrhGn8gUQQg7XyuleaevopF+ZOWm/DtB64+E71gR7qTvVW66Y0p5VBRyN074cY4WYBBuLvcUa1wKygKhvc/rPOOm+P1Mv8/6UoFdvQxRiVzZjVCYxjyky7xcieJW3v76EtzGSVWqdA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:17 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Eric
 Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, "open list:sPAPR
 pseries" <qemu-ppc@nongnu.org>, "open list:S390 TCG CPUs"
 <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 06/18] hw/usb/hcd-ehci: Replace DPRINTF debug logs with
 trace events
Thread-Topic: [PATCH v5 06/18] hw/usb/hcd-ehci: Replace DPRINTF debug logs
 with trace events
Thread-Index: AQHc08EW2owNv3gcH06vbnzuE3Wtzg==
Date: Fri, 24 Apr 2026 08:05:17 +0000
Message-ID: <20260424080508.53992-7-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5790:EE_
x-ms-office365-filtering-correlation-id: 242703fe-d2e1-45c2-e7a0-08dea1d8391a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 3hEeS/RHMxA4s5bMJjqY0X6e/SfQWSHGzT+mjGw0oQwzVY2ndu6xrl9Kfy2yW+RnFE3dHfw/1yEbV4XlT312diLFXROr+TAcv/g7CLYXwYhAgPKdwLEFOtplmcOvlmnZpFI5bPiRrWCSE2FPi4hcdhRO9nog6obVJXE2Bo3Z6ZEwygQwGsqnJPhOqw+MtSbMdlYkSXInbqdoKAv4OwNxlm5qVnxuMVJ6D8griU3sYrIOAJCu3eB2xV5iIIbrKVdhc+KRzB2loL+F+AKYddc8V0wd7UTJ0wG94eDpK8aZAUKh++wp+a2w3HJi+gCTWZR8AZMHVFa5kVW5ttwn0Nvwp/LLluVyfmx4S5dGpawQVJf7/ABpC63zFNQSdCA2x87SSF9ia88DJfukWN4foiCxjMfgtl9vUkR+274LMmQXWCdyOdPJTP7HYZCAGweUmdDoLWuK9CtJ04WLT7iO4/KJBdGGtftrXu2MzX0zT16odiCCZSbyA/K3fLWwnMvL45oSvAAaiLO9Jl+sRXY0Hry01XhI+npr8s0WDpJOspsYmI3wrKc+7dNzV0qA2vz72+fg4gPu67mSQ51eDSx93OPk67QjGNMD76l4aiFPTte3MqNn7i8juMepGF+oR5Dkll4elF50V0FGMRUNTuBqffWN9QLmm0vBmJ2LVd0n8DDO/CyOSPNd/n8jISn4cLwHfP5WJqhnreymqx81bwKCQBSN+9H9VRSOITIeZXj8pCPnLLoUiZPwCHdaXyIzp/ggPpY6wRrY/9DnsT6LEpku4Ja5HXv8CC52aaEX7s+GEQG8R3IcP2aE0A24WeutBfmKx8pZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xA/1kVKT4Z1z2GDiX9HQntKBhYFEeI6wECyT+VDQM9yKc1Crb4o1zlCzSb?=
 =?iso-8859-1?Q?obYJHUFRRku9Fa9Z67DcpMXygJGC4VmW2eTf+QX2xcFZf0atT3VIqzAJjb?=
 =?iso-8859-1?Q?Zs+tUHEVfIE3sGn968M1T9wUIevJ40w8P4uYgckmdI5bX3c3cH+mqTbcyL?=
 =?iso-8859-1?Q?CPSZCEQF2TPzrYmEtr9HCauNNsNNi4HwCqjt3T1Yr0Y2L5aetcdgZrRg/I?=
 =?iso-8859-1?Q?ivzVDC+rqO8bxBAcghcLTO/ld8/NxtwFUNzJnPEMxNfx2DY50772/2FJKf?=
 =?iso-8859-1?Q?2viNj+KN5f6Onisw522NG5LgXhU4ApL/AMk11aSWi3zIi3P57vtzxkgsey?=
 =?iso-8859-1?Q?/ysC5ZCPpnAF1FlIZS33R2NKg/WGEVXg2/ifNNhgv/yVII29X0vpV1AjuU?=
 =?iso-8859-1?Q?UiHDtmJQQoy/IeOiKeuizw7ine+9XfqG87cbpvtd8OVXgMtEIC0q2MTc/w?=
 =?iso-8859-1?Q?gz3WfLbz1N6fouseJjnhSAgWs8RnnsW4shFJlzeIkT5zd+PFSmkBtcZjbE?=
 =?iso-8859-1?Q?jm29yGv+iAmwjYvfDcXAE3iWYHkjz7vqzDWQd4LrVOoMPa9Yz7lH1HKKUR?=
 =?iso-8859-1?Q?GUFEdPW/hfXbwMxkmkaWMVhhPc87sS60bXjM/zj3WX9JtssiAax4LaL4Qm?=
 =?iso-8859-1?Q?kxUSKQruHQP6q7AyWWdtIiNpNnY13AEhKo8UG7Fd3MXj5c6zLnkbhrCCO9?=
 =?iso-8859-1?Q?oKlwCdHfCqgtR3kr0vY3PXtSX3BqEcQ4GeGjTpZ3wlywfWqC9v8IJBktHd?=
 =?iso-8859-1?Q?WbbHXJrUgXUFW1CbQWPMlMxLJvzevjqrXxORs1HbbN3no7g90S5xnLfzIu?=
 =?iso-8859-1?Q?RQjS+sHqgPQR5253QSNKjeyI+MYiZw6UkIumJKxFRQzWItnxy9A2+bvM60?=
 =?iso-8859-1?Q?IQq9KZzFOrljAjY4z0y01iEUJvISvizhcUBD7wBnf6KoasruDXeXKxOseH?=
 =?iso-8859-1?Q?VQl2KU3EZajEIyOd9PH/+btbyDW7xcnE9JXcgKbptv9RLAvp3ZIJ01TbzN?=
 =?iso-8859-1?Q?boCN+DxZ8XOY7iKj+GAFv6s6dIVFNCe3ebpvMISaQVlQ/x4qwB+crFWrnj?=
 =?iso-8859-1?Q?mzMTvuba1+NpHqX7do9uUQPrLyOfK8dA4giC95oJLGoCgFL+7pGEpZ57DQ?=
 =?iso-8859-1?Q?aw80sWaTMAGOx0fCfKuFTgou3NWSiIYks+3l3ePowgCi3+N6/3x1m3ZKLM?=
 =?iso-8859-1?Q?1zRzIMnVKCSCLp9qSaqtHy33UOF0q7X9ZwLNROEQtjmLRQNiQS/5rwKkkC?=
 =?iso-8859-1?Q?pF4fyfkzeSTNDZ0tN4ssa7iYInBIITZLva6pZPH1sUp+BbZjyQHwrZPZQB?=
 =?iso-8859-1?Q?lX43f6zH+WiNStwIX9Bjuz5MsvZKrWVN2aJjtWerCITkQqd3XpMhnudocn?=
 =?iso-8859-1?Q?RWxWSEPExvu2TcuDPlFWP1NajNUBEwIV7ALvEypYP8O9yZLq8XFGT6MG/5?=
 =?iso-8859-1?Q?Lh7h/+QpAAaiRY60CQ+A0G/tSJRCdaK41ozmeKofdvggKm4gpc9h5BWhYa?=
 =?iso-8859-1?Q?qPKlDtdUyHUiOWduSHTjM1zbyvysOfwpc5BRcRRmpatPCufeaY+61ntkY/?=
 =?iso-8859-1?Q?16t9gLaZ/A8LFzD1A2EikwRFYvhXt2Higx0pEjWi48DeFywCFbcAv5u7Gd?=
 =?iso-8859-1?Q?jIY9/scepoXc/x+/ZlTgnLWjJvLFB7NkUP719VEG5clGY09DPVe0ylrDFn?=
 =?iso-8859-1?Q?Tmz5Bi1FV6mJ1IsuS/vRlGgRXl/6k0kUId9Lvb2aAnRHPvqmc5JGglXtf/?=
 =?iso-8859-1?Q?24esdGEmf07ztoaBRuX3+txt/9Td3jy7A/gJVFsklq11xRwhjH2nER6za4?=
 =?iso-8859-1?Q?9lOQL6Z/Sg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RLAYCqm28rNHUpkK5tQf/j8sE2zVDogZPRS3YI2Jkjkq6sW+DBauYbm0IB9JC2XC7nv1BevfOr91NP9HQjp2soWTWoVH+B5QCFYdXT8iCm9chlgQxGZTbmQuiEdvo/2Sh7fIOqe77fhHQjbXqAbioXewL/zBAgk+xamjW63s49BHeBTkxPNPqjHNGp/kqkASnQIQbNtcbmFmLoJN5nM2u03tRhrHrTR5y/FB6O2wuGg5oG/gB6FzwsGDsaqCaFN57M/zg/KGDZkqNzEme3Stv5wDvbK+3PiP3A2r+O6ACbzaxtoKwgOAA4cbF5dITOGptvWMrQpvclrgKbhLh4ntFQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242703fe-d2e1-45c2-e7a0-08dea1d8391a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:17.6191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNYsPucNxeil6VYzaxB+dpMEx8L9T13LbiSZTHBP5dDSRxD9LFeIyeKYvD/zAyH6ClV21bJtZfPSte4d5bqhnMNixCRJclZAY+73Hw8Un4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790
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

Replace legacy DPRINTF() debug logging in the EHCI host controller=0A=
implementation with QEMU trace events.=0A=
=0A=
The EHCI_DEBUG macro and associated DPRINTF() definitions are=0A=
removed as they are no longer needed.=0A=
=0A=
Trace events are added for:=0A=
- packet submission and completion=0A=
- queue head execution state=0A=
- periodic schedule advancement=0A=
- ITD error conditions=0A=
- port state handling=0A=
- skipped microframes=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h   | 10 ---------=0A=
 hw/usb/hcd-ehci.c   | 49 +++++++++++++++++++--------------------------=0A=
 hw/usb/trace-events |  9 +++++++++=0A=
 3 files changed, 30 insertions(+), 38 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 736407fd52..4234591cb4 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -24,16 +24,6 @@=0A=
 #include "hw/pci/pci_device.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
-#ifndef EHCI_DEBUG=0A=
-#define EHCI_DEBUG   0=0A=
-#endif=0A=
-=0A=
-#if EHCI_DEBUG=0A=
-#define DPRINTF printf=0A=
-#else=0A=
-#define DPRINTF(...)=0A=
-#endif=0A=
-=0A=
 #define MMIO_SIZE        0x1000=0A=
 #define CAPA_SIZE        0x10=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 8acaedeaa9..28a60e4c1a 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -839,7 +839,7 @@ static USBDevice *ehci_find_device(EHCIState *ehci, uin=
t8_t addr)=0A=
     for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         port =3D &ehci->ports[i];=0A=
         if (!(ehci->portsc[i] & PORTSC_PED)) {=0A=
-            DPRINTF("Port %d not enabled\n", i);=0A=
+            trace_usb_ehci_port_disable(i);=0A=
             continue;=0A=
         }=0A=
         dev =3D usb_find_device(port, addr);=0A=
@@ -1281,10 +1281,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
     assert(p->async =3D=3D EHCI_ASYNC_INITIALIZED ||=0A=
            p->async =3D=3D EHCI_ASYNC_FINISHED);=0A=
 =0A=
-    DPRINTF("execute_complete: qhaddr 0x%x, next 0x%x, qtdaddr 0x%x, "=0A=
-            "status %d, actual_length %d\n",=0A=
-            q->qhaddr, q->qh.next, q->qtdaddr,=0A=
-            p->packet.status, p->packet.actual_length);=0A=
+    trace_usb_ehci_execute_complete(q->qhaddr, q->qh.next, q->qtdaddr,=0A=
+                                    p->packet.status, p->packet.actual_len=
gth);=0A=
 =0A=
     switch (p->packet.status) {=0A=
     case USB_RET_SUCCESS:=0A=
@@ -1327,7 +1325,7 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
     } else {=0A=
         tbytes =3D 0;=0A=
     }=0A=
-    DPRINTF("updating tbytes to %d\n", tbytes);=0A=
+    trace_usb_ehci_qh_tbytes(tbytes);=0A=
     set_field(&q->qh.token, tbytes, QTD_TOKEN_TBYTES);=0A=
 =0A=
     ehci_finish_transfer(q, p->packet.actual_length);=0A=
@@ -1392,10 +1390,9 @@ static int ehci_execute(EHCIPacket *p, const char *a=
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
-            p->packet.actual_length);=0A=
+    trace_usb_ehci_packet_submit(p->queue->qhaddr, p->qtd.next, p->qtdaddr=
,=0A=
+                                 p->pid, p->packet.iov.size, endp,=0A=
+                                 p->packet.status, p->packet.actual_length=
);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -1472,7 +1469,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     usb_handle_packet(dev, &ehci->ipacket);=0A=
                     usb_packet_unmap(&ehci->ipacket, &ehci->isgl);=0A=
                 } else {=0A=
-                    DPRINTF("ISOCH: attempt to address non-iso endpoint\n"=
);=0A=
+                    trace_usb_ehci_log("ISOCH: "=0A=
+                                       "attempt to address non-iso endpoin=
t");=0A=
                     ehci->ipacket.status =3D USB_RET_NAK;=0A=
                     ehci->ipacket.actual_length =3D 0;=0A=
                 }=0A=
@@ -1677,24 +1675,22 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehc=
i, int async)=0A=
         if (ehci->usbsts & USBSTS_REC) {=0A=
             ehci_clear_usbsts(ehci, USBSTS_REC);=0A=
         } else {=0A=
-            DPRINTF("FETCHQH:  QH 0x%08x. H-bit set, reclamation status re=
set"=0A=
-                       " - done processing\n", q->qhaddr);=0A=
+            trace_usb_ehci_fetchqh_reclaim_done(q->qhaddr);=0A=
             ehci_set_state(ehci, async, EST_ACTIVE);=0A=
             q =3D NULL;=0A=
             goto out;=0A=
         }=0A=
     }=0A=
 =0A=
-#if EHCI_DEBUG=0A=
-    if (q->qhaddr !=3D q->qh.next) {=0A=
-        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\=
n",=0A=
-               q->qhaddr,=0A=
-               q->qh.epchar & QH_EPCHAR_H,=0A=
-               q->qh.token & QTD_TOKEN_HALT,=0A=
-               q->qh.token & QTD_TOKEN_ACTIVE,=0A=
-               q->qh.next);=0A=
+    if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
+        if (q->qhaddr !=3D q->qh.next) {=0A=
+            trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
+                                       q->qh.epchar & QH_EPCHAR_H,=0A=
+                                       q->qh.token & QTD_TOKEN_HALT,=0A=
+                                       q->qh.token & QTD_TOKEN_ACTIVE,=0A=
+                                       q->qh.next);=0A=
+        }=0A=
     }=0A=
-#endif=0A=
 =0A=
     if (q->qh.token & QTD_TOKEN_HALT) {=0A=
         ehci_set_state(ehci, async, EST_HORIZONTALQH);=0A=
@@ -2161,7 +2157,7 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
         /* make sure guest has acknowledged the doorbell interrupt */=0A=
         /* TO-DO: is this really needed? */=0A=
         if (ehci->usbsts & USBSTS_IAA) {=0A=
-            DPRINTF("IAA status bit still set.\n");=0A=
+            trace_usb_ehci_log("IAA status bit still set.");=0A=
             break;=0A=
         }=0A=
 =0A=
@@ -2226,9 +2222,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
         if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-=0A=
-        DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
-                ehci->frindex / 8, list, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
         ehci_set_fetch_addr(ehci, async, entry);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
@@ -2294,8 +2288,7 @@ static void ehci_work_bh(void *opaque)=0A=
             ehci_update_frindex(ehci, skipped_uframes);=0A=
             ehci->last_run_ns +=3D UFRAME_TIMER_NS * skipped_uframes;=0A=
             uframes -=3D skipped_uframes;=0A=
-            DPRINTF("WARNING - EHCI skipped %"PRIu64" uframes\n",=0A=
-                    skipped_uframes);=0A=
+            trace_usb_ehci_skipped_uframes(skipped_uframes);=0A=
         }=0A=
 =0A=
         for (i =3D 0; i < uframes; i++) {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index dd04f14add..0d4318dcf1 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -89,6 +89,7 @@ usb_ehci_state(const char *schedule, const char *state) "=
%s schedule %s"=0A=
 usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0=
x%08x,0x%08x"=0A=
 usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
 usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x=
 - c %d, h %d, dtc %d, i %d"=0A=
+usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"=0A=
 usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"=0A=
 usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
 usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacte=
rr %d"=0A=
@@ -100,13 +101,21 @@ usb_ehci_port_reset(uint32_t port, int enable) "reset=
 port #%d - %d"=0A=
 usb_ehci_port_suspend(uint32_t port) "port #%d"=0A=
 usb_ehci_port_wakeup(uint32_t port) "port #%d"=0A=
 usb_ehci_port_resume(uint32_t port) "port #%d"=0A=
+usb_ehci_port_disable(uint32_t port) "port #%d"=0A=
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"=0A=
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %=
s"=0A=
+usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%x, ne=
xt=3D0x%x, qtd=3D0x%x, pid=3D0x%x, len=3D%zd, endp=3D0x%x, status=3D%d, act=
ual_length=3D%d"=0A=
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask=
) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"=0A=
 usb_ehci_guest_bug(const char *reason) "%s"=0A=
 usb_ehci_doorbell_ring(void) ""=0A=
 usb_ehci_doorbell_ack(void) ""=0A=
 usb_ehci_dma_error(void) ""=0A=
+usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%x, next=3D0x%x, qtdaddr=3D0x%=
x, status=3D%d, actual_length=3D%d"=0A=
+usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, recla=
mation status reset - done processing"=0A=
+usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08=
x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
+usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
 # hcd-uhci.c=0A=
 usb_uhci_reset(void) "=3D=3D=3D RESET =3D=3D=3D"=0A=
-- =0A=
2.43.0=0A=

