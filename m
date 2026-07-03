Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CF6C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYZ1-0008Ri-LW; Fri, 03 Jul 2026 03:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYZ0-0008RL-6x; Fri, 03 Jul 2026 03:43:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYYw-0004IZ-K2; Fri, 03 Jul 2026 03:43:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq82XDjoBZQizwlKxz1o8j0w3CJOumHU0XqKMzukoVsa46vrIDKcw7ote1UEtxUXZ0iH7C/ua3PvMAgVZEfNV1FXOiR3+6uiX6yAAmntUg7x7yDcrsmrpqH/+WBgKJxZBYxXsJg/NUPM9UWPz1tSsy66VJZpNVoQhq1F7fv8yHnQtqdHmzwmqjsFOOxeK9ATnNSvKISl+ibnXj6NmVmcht2wooiKMZsb7gTvVnANwUi+FxNSTGJusPnHSon8WpDj03BjxLGd6QjM6Gcr8nyaAOXIY5JZifvbC42dE2W9HvovWwJh/Erb0z6Xv33YlcNvEU5aMBSN6WXj2LvmIDV3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+h2GRZ3xxPsPO1dXKa/rMEySOYcbepV89G6qzZJD1M=;
 b=K7A72ZZHunS3JveEG2UAaVtXrXgQzac4vfRV8KE2eZpYfg+KaCrXDotlikApbY6MA7adD45G8iTRi42qrVafDagCQXIQpVks5H6qCLdcrxYyIFJLhOx8P5C9al3WIr/g4lwwNex/TNpwpHM8ducSWj/xC2O3AoJP6YXO1T4qXj+fjvfLbzQAqFKmriw1sWLAXruLcoIWkkK1EWwK8gfeCZ05j2leC13xoN1hGtUD3Hin8AUvYG23bwIhdSEJnmtqjHHm6vYcXXnqHc3CJ0CVX9nJdqbAKKtWC1NywAmMPlE2gU4R5PWTX+hC4bOlmEVSoz0fbrcSp0/BHN/8Eo3CcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+h2GRZ3xxPsPO1dXKa/rMEySOYcbepV89G6qzZJD1M=;
 b=aE6RYSe8WnQO7bbfmrF6zScVWX+oZKnE2cILdw7bfuy4tMUz7RuWI1z2CmQnXhAjeHVGD1LYD1JYaWLdsGgVO9EXFAWxqvxQ5D1nbk3iEIF6F8FPEynZcAMpIG4AUuHmBLoas8HHZBcOV3Gx9kbP+AnMokOWFQ9FiLMKUJ8STLzJQEzHaQSnNkT/f5m2IsQhQHUaPUJ+nqnrK3CaO0Ux2l/4CBfdwPVLd9IZk8Cq4P+b1f9qUXJdrISJR958scsTCZB+2g0cihecb+Ws4B3z5w9SGphB34aVPc4ICG729bp+iOHzydLBYHQctZ603Afifof3BLnNVkBIFCGLoXSwNA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 07:43:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 07:43:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/3] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
Thread-Topic: [PATCH v1 2/3] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB
 device
Thread-Index: AQHdCr+nyhYtVwGwzUqRRDy7oe8CXQ==
Date: Fri, 3 Jul 2026 07:43:36 +0000
Message-ID: <20260703074332.1049473-3-jamin_lin@aspeedtech.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5040:EE_
x-ms-office365-filtering-correlation-id: 07edb5a3-da38-4327-9c8a-08ded8d6ca55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|38070700021|18002099003|22082099003|3023799007|5023799004|56012099006|6133799003;
x-microsoft-antispam-message-info: G654ElE8VG574sBxU8ZErQ6jlOyDEzJVNlwwnM96KBeRrb6R7/hQmeig5v9ao9Pal5M8xTcjgN/grZaqH+BBrb5bk9J6ZhCEKiV0GNp3dfcGiLfq0RZ+sfK7lwXioPBk2lLEgTqK+vy4HgGDgUH1WtGN/zzCYOetaboPAtNMEj6xMv1jvDnAzVhgu9eN5fm7R0Pr59WpCRpNd+tuWtK5kKJfaLKW4gVd4hcj1YNv/b5KuMhz8ShkrAs0k3kzaWtX/uTudEXwKnSD99elniuRSphH4CknKj4fuoYA+l3kqGPmADvHRjaZtCCneXRRdjwmBebdqJ3VlizOz2mOnEcWlWrE0b31Unlv5CoTxxvcJT6x2RFfnY0c5IVz7WFUfPbsFZ+phncpsGtKbofuXJFc+M+88s9QbxGHyLAyLwNvg91GNuchbpnJffVxUwMi1HOheNJKtZT1SkHUdlQD7PspX285VhT1UvvMGe+1f8FuUsokZUmeno1UwNWcaePux0op/Eq1UvoMDR3hNXZ0ogYvaHXgB4OxzDlvK8cfdfsd2sQkstRnOZAJWT7iVxhcL82OHTTLXJS/50mnGxmgHfZFQo1WRUDp998HMUR8RRkE3Are67Xs1qB8iuxteqjwvTBofovYK+Lvop2SAN0HeWc6QqbZg1OOTooV13btkQ40MH//djYM2GBySQu4HhfPMwChsPGht5tfKCOv6ZJqlFnBLCDnFwCeM2d07lnRH1MQUryUIVdrYcCv3XBCNkd3SCHS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(3023799007)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?11ZPWtUAIaTTiJrokkvC9XulfeQT5AOiwoOVKZ//Z7xADiSa580ybbImC0?=
 =?iso-8859-1?Q?WZFgb55BZU1YzWGlskrsI5XjG5ywXF9tLKjqnpxOqqk+hYuUdV45e8e28/?=
 =?iso-8859-1?Q?LQviz9o0zNhsC9VieaaNwU5EucRv0HdB3aC+GA0wLj9/xGnFifHi2LvDw8?=
 =?iso-8859-1?Q?mrryXeN7u5N/lXTO2AL+q1FsLQBANlFSKULjEjNW8rSF0ptVKcekWKSZ+u?=
 =?iso-8859-1?Q?GbYSlfzWu0Jc4pLdbGyzUhz1muQgDUXlYm5mk6+7ttxGHB/ZjArVod6WR8?=
 =?iso-8859-1?Q?1rqxP1g1RqmFDwvcKUuf5erW/a+2zbqG9Oj0e4kJTrwsCo8bIwQhtjYQlK?=
 =?iso-8859-1?Q?0x1j9zaM3LxDWh9zdaILIgNUXX4jAjnz7LzoBTaNLdbwjGYQUxyah0+7tN?=
 =?iso-8859-1?Q?qwqxwoIlE/Vf0Wjk5y6qNAMHT7OnILsy9Zklnv5+kyzCyUaEGPKujMLpDu?=
 =?iso-8859-1?Q?ng+06oLQu4+gNTp8PRD0ofx52LxwMMjGlLIyiqUe91hd4OKckKjBi39XaQ?=
 =?iso-8859-1?Q?of2Sjimc6CZLuEVLrhJbDMI6q3FeK0D+J7FrdkiN+q+hJ4127rfpxHHlEx?=
 =?iso-8859-1?Q?hMXmX5qas14N4ITml2ZaYJLRxi39nBtSUtdyv6pE3CpQwq1St7/oqEKgPp?=
 =?iso-8859-1?Q?IMgQPVdUob+D89p8NMqfEJa6qrSIZzapVIq0FPDS3mD617nu7qpU7y6nYH?=
 =?iso-8859-1?Q?KPI6rO7wF5qyB0hzQmviYDHkfUH2ptG9TTMbBjR7/gOCu1GYj1GzwkCjH3?=
 =?iso-8859-1?Q?C3592tgTkoGbNaIzvMsCDNJbxidCwwUgEzLqcZxVBL4RPAHBLm52g3QLzi?=
 =?iso-8859-1?Q?QUgaBwttn1W93hT1Kkf/y6iBLfrmAlIEtYA39QyMj7HNxyH8rwBSncwp6Q?=
 =?iso-8859-1?Q?8OOvRuvQSotOJrTfxvM8z/pe1ZJl8mEHPBGpVUe8320NyQLOXikQpz0q0b?=
 =?iso-8859-1?Q?YPtip2Jhgeaw+OPzNMXrE9zcYQsVAPnO376tjK+5DPpsB1tQuOthV/ppPM?=
 =?iso-8859-1?Q?UZf2+c5HCV9pGborQ42J5CSxunTNe4YAPOFhJdH9P0M6hN1G789L039MDF?=
 =?iso-8859-1?Q?NbMsilThkThAxoHpokQFYs0wVmEY9eg0w26ikrPhq/2YrPjCnWcm6Uk8SG?=
 =?iso-8859-1?Q?ZZBKBYL1+txlKqEZ0E3RZ6XsvtfpbXG7dBo3wA1jxH/RafztC+roC+yK0z?=
 =?iso-8859-1?Q?KCNykSLxQc+bnr9oLhxZ3IKBO55EKDsN3QDLuy/MEUL+gUqGt6VKpnpOmz?=
 =?iso-8859-1?Q?S9P0KJGBjN4/w09LWZCTcZLT+NWwA/Q6q/UpVeZ4VY22nkfW1WlLeIfTBp?=
 =?iso-8859-1?Q?3/ryvKFesxXCTUxF+wXQBZ5PRit8mtH1TDLGmUslUgbYuHuWUW7G6VTlzR?=
 =?iso-8859-1?Q?3SzVV5gqIsW4xNvVjXG296P4BjdEJihEPulwOt9rvHjbezZn/HkGe2XZX7?=
 =?iso-8859-1?Q?aLkIllVw/mHrChsPw7xBd+YhsdRu7iScG1M2suRhZAglEXtkSTYjLlqV4Z?=
 =?iso-8859-1?Q?kZwcW5MnUH9LRvpxRGSEwTfyD+4kv5zFJNlhKM9SFnjs/Cfif5B/PMlSqp?=
 =?iso-8859-1?Q?l9mFQ1gi6QkTLG7so1ystXQaqjNBOfYclY7E8MwH1XgyE8CqFfZShjvPLi?=
 =?iso-8859-1?Q?4leFFWrI0US6Dmb2/yEUEEF6PFDv1HhG9UIiuCnp72JCyA2ksq0L3EOX+d?=
 =?iso-8859-1?Q?1Cls/NtU3J7r++dRfqdJPKj/w+bhNPgITU2cmNbj2+G1b8oLq6wiXrZr3q?=
 =?iso-8859-1?Q?ppMnOHEuajV1ZFIORm0nz2skCj7uSE6sMwJbZB7/Bzs7oXCzAM2Az931fO?=
 =?iso-8859-1?Q?U51aT78rxg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U7LsENe7qk23K+26Ay64EQVLwBa9/zrBjxA85bjDTakfIqBPW8R5uhZDy1+3TtFC7r6Jw171Qcsxp3Iy8u8e546TLG46YvgmOozpmkaEvnG1yibPUWKcbKWCSoWEZhc324/w6mYFYUyMW8jAojfKrO/39ikVT1/pbz+CMX/YkQehEGW13BKedeikTNqO7Po/DRY/ksdYSHPcdZuQeAun6oW+98bVd2P/bFpggaMloZhasj2jiJc/JZfJ0bgAc1TbsVr/B8Y3u1vfwNObapdQ0r57L/JPlduWhZrACZXBSsLW0n8vO3/rPfpae/1Y72ryDWsStp14ez/eODqk2L4HpA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07edb5a3-da38-4327-9c8a-08ded8d6ca55
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 07:43:36.2064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iju7xdNBaxAzPtSHt9u1/IMah/WV/YB/TI5+bhVnLl8pZOiWzkiVJJ5kiyTjwdLa5YNknHGoXThL9sQdmVJkPataP4A59Qf2cSs7uv9TbNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040
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

Present the UDC gadget side to a USB host controller as a USB device=0A=
(TYPE_ASPEED_UDC_GADGET). This is a normal QEMU USB device, so it can be=0A=
attached to any USB host controller bus, not only the BMC's own EHCI.=0A=
=0A=
It forwards host transactions to the guest gadget driver by raising the=0A=
matching controller interrupts, and completes them once the driver=0A=
answers through the device-controller MMIO registers:=0A=
=0A=
  - EP0 control: the SETUP packet is mirrored to the SETUP data buffer,=0A=
    and the driver's IN/OUT data is copied to/from the host packet.=0A=
  - Bulk endpoints: IN uses the descriptor-list DMA ring, OUT uses the=0A=
    single-stage DMA buffer. A transfer larger than one host packet is=0A=
    served across several polls and the packet is parked until the gadget=
=0A=
    queues more data.=0A=
=0A=
The gadget connects to / disconnects from the host bus when the driver=0A=
sets or clears the upstream-enable bit (pull-up), and is detached on=0A=
reset so a guest reboot does not leave the host enumerating a gadget with=
=0A=
no driver behind it.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c         | 678 +++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events         |   9 +=0A=
 include/hw/usb/aspeed-udc.h |  30 ++=0A=
 3 files changed, 711 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 9be9cfcf13..3d69e33516 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -9,18 +9,30 @@=0A=
  * "aspeed_udc" gadget driver. It implements one control endpoint (EP0) an=
d=0A=
  * 4 programmable endpoints.=0A=
  *=0A=
- * This file is the system-bus side of the controller: the MMIO register m=
ap,=0A=
- * the interrupt and the soft reset. The gadget USB device presented to a =
host=0A=
- * controller (and the endpoint data path) is added on top of this.=0A=
+ * The model has two faces:=0A=
+ *   - a SysBus device exposing the MMIO register interface, the interrupt=
 and=0A=
+ *     the integrated DMA engine to the guest gadget driver (the "system b=
us=0A=
+ *     device" section below);=0A=
+ *   - a USBDevice presented on a host controller's bus, which forwards ho=
st=0A=
+ *     transactions to the gadget by raising the matching controller inter=
rupts=0A=
+ *     and completes them once the gadget responds via MMIO (the "USB devi=
ce"=0A=
+ *     section below).=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/error-report.h"=0A=
 #include "hw/core/irq.h"=0A=
 #include "hw/core/registerfields.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
 #include "hw/usb/aspeed-udc.h"=0A=
 #include "qemu/module.h"=0A=
+#include "qapi/error.h"=0A=
+#include "system/dma.h"=0A=
+#include "system/address-spaces.h"=0A=
 #include "trace.h"=0A=
 =0A=
+#define AST_UDC_EP0_MAXPKT      64=0A=
+=0A=
 /* Root / Global registers (offset from the controller base) */=0A=
 REG32(UDC_FUNC_CTRL, 0x00)=0A=
     FIELD(UDC_FUNC_CTRL, UPSTREAM_EN,       0, 1)=0A=
@@ -90,11 +102,29 @@ REG32(EP_DMA_STS, 0x0C)=0A=
     FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
     FIELD(EP_DMA_STS, TX_SIZE,             16, 11)=0A=
 =0A=
+/* DMA descriptor ring (256-stage mode) and descriptor data limits */=0A=
+#define ASPEED_UDC_DESCS_COUNT  256=0A=
+#define ASPEED_UDC_DESC_MAX_LEN 4096=0A=
+=0A=
+/* DMA processing-status idle codes (EP_DMA_CTRL PROC_STS field) */=0A=
+#define EP_DMA_CTRL_STS_RX_IDLE 0x0=0A=
+#define EP_DMA_CTRL_STS_TX_IDLE 0x8=0A=
+=0A=
+/* DMA descriptor (DES1) fields, in guest memory */=0A=
+#define AST_EP_DESC1_IN_LEN(w1)     ((w1) & 0x1fff)=0A=
+/* interrupt-on-completion */=0A=
+#define AST_EP_DESC1_INTR           BIT(31)=0A=
+=0A=
 /* Device-reset default: root, DMA and EP-pool soft-reset bits set (0x301)=
 */=0A=
 #define UDC_DEV_RESET_DEFAULT \=0A=
     (R_UDC_DEV_RESET_ROOT_MASK | R_UDC_DEV_RESET_DMA_MASK | \=0A=
      R_UDC_DEV_RESET_EP_POOL_MASK)=0A=
 =0A=
+static bool aspeed_udc_ep_serve_in(AspeedUDCState *s, unsigned ep,=0A=
+                                   USBPacket *p, bool *complete);=0A=
+static bool aspeed_udc_ep_deliver_out(AspeedUDCState *s, unsigned ep,=0A=
+                                      USBPacket *p);=0A=
+=0A=
 static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
 {=0A=
     bool level;=0A=
@@ -107,6 +137,159 @@ static void aspeed_udc_update_irq(AspeedUDCState *s)=
=0A=
     qemu_set_irq(s->irq, level);=0A=
 }=0A=
 =0A=
+static void aspeed_udc_raise_isr(AspeedUDCState *s, uint32_t mask)=0A=
+{=0A=
+    s->regs[R_UDC_ISR] |=3D mask;=0A=
+    aspeed_udc_update_irq(s);=0A=
+}=0A=
+=0A=
+/* Signal completion of a programmable-endpoint transaction to the gadget =
*/=0A=
+static void aspeed_udc_raise_ep_ack(AspeedUDCState *s, unsigned ep)=0A=
+{=0A=
+    trace_aspeed_udc_ep_ack(ep);=0A=
+    s->regs[R_UDC_EP_ACK_ISR] |=3D BIT(ep);=0A=
+    s->regs[R_UDC_ISR] |=3D R_UDC_ISR_EP_POOL_ACK_MASK;=0A=
+    aspeed_udc_update_irq(s);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * System bus device: MMIO register interface (guest gadget-driver facing)=
=0A=
+ */=0A=
+=0A=
+/* Connect/disconnect the gadget from the host bus (UBD00 upstream enable)=
 */=0A=
+static void aspeed_udc_set_pullup(AspeedUDCState *s, bool on)=0A=
+{=0A=
+    USBDevice *udev;=0A=
+    Error *err =3D NULL;=0A=
+=0A=
+    if (!s->usbgadget) {=0A=
+        /* no gadget device bound to this controller */=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    udev =3D USB_DEVICE(s->usbgadget);=0A=
+    if (!udev->port) {=0A=
+        /* not attached to a host controller bus */=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_pullup(on, udev->attached);=0A=
+    if (on && !udev->attached) {=0A=
+        usb_device_attach(udev, &err);=0A=
+        if (err) {=0A=
+            warn_report_err(err);=0A=
+        }=0A=
+    } else if (!on && udev->attached) {=0A=
+        usb_device_detach(udev);=0A=
+    }=0A=
+}=0A=
+=0A=
+/* Complete the in-flight EP0 control transfer back to the host */=0A=
+static void aspeed_udc_ep0_complete(AspeedUDCState *s, uint32_t len)=0A=
+{=0A=
+    USBPacket *p =3D s->ep0_packet;=0A=
+=0A=
+    if (!p) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep0_packet =3D NULL;=0A=
+    p->actual_length =3D s->ep0_dir_in ? MIN(len, s->ep0_setup_len)=0A=
+                                     : s->ep0_setup_len;=0A=
+    p->status =3D USB_RET_SUCCESS;=0A=
+    trace_aspeed_udc_ep0_complete(s->ep0_dir_in, p->actual_length);=0A=
+    usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The gadget driver drives EP0 by writing UBD30. Translate those writes i=
nto=0A=
+ * data movement to/from the deferred host control packet plus the matchin=
g=0A=
+ * ACK interrupts the gadget expects.=0A=
+ */=0A=
+static void aspeed_udc_ep0_ctrl_write(AspeedUDCState *s, uint32_t val)=0A=
+{=0A=
+    uint32_t buf_addr =3D s->regs[R_UDC_EP0_DATA_BUFF];=0A=
+    uint32_t store =3D val & R_UDC_EP0_CTRL_STALL_MASK;=0A=
+    uint32_t txlen;=0A=
+    USBPacket *p;=0A=
+    uint32_t n;=0A=
+=0A=
+    trace_aspeed_udc_ep0_ctrl_write(val, s->ep0_dir_in, s->ep0_offset);=0A=
+=0A=
+    /* Gadget stalled EP0: fail the pending control transfer */=0A=
+    if (val & R_UDC_EP0_CTRL_STALL_MASK) {=0A=
+        p =3D s->ep0_packet;=0A=
+=0A=
+        if (p) {=0A=
+            s->ep0_packet =3D NULL;=0A=
+            p->status =3D USB_RET_STALL;=0A=
+            usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);=
=0A=
+        }=0A=
+        s->regs[R_UDC_EP0_CTRL] =3D store;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (val & R_UDC_EP0_CTRL_TX_RDY_MASK) {=0A=
+        txlen =3D FIELD_EX32(val, UDC_EP0_CTRL, TX_LEN);=0A=
+=0A=
+        if (s->ep0_dir_in && s->ep0_packet) {=0A=
+            /* IN data stage: copy a chunk from the gadget's DMA buffer */=
=0A=
+            n =3D MIN(txlen, s->ep0_setup_len - s->ep0_offset);=0A=
+=0A=
+            if (n) {=0A=
+                dma_memory_read(&address_space_memory, buf_addr,=0A=
+                                s->ep0_data + s->ep0_offset, n,=0A=
+                                MEMTXATTRS_UNSPECIFIED);=0A=
+            }=0A=
+            s->ep0_offset +=3D n;=0A=
+            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);=0A=
+=0A=
+            if (txlen < AST_UDC_EP0_MAXPKT ||=0A=
+                s->ep0_offset >=3D s->ep0_setup_len) {=0A=
+                aspeed_udc_ep0_complete(s, s->ep0_offset);=0A=
+            }=0A=
+        } else {=0A=
+            /* Zero-length status IN for an OUT / no-data control transfer=
 */=0A=
+            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);=0A=
+            aspeed_udc_ep0_complete(s, s->ep0_offset);=0A=
+        }=0A=
+=0A=
+    } else if (val & R_UDC_EP0_CTRL_RX_RDY_MASK) {=0A=
+        if (s->ep0_dir_in) {=0A=
+            /* Status stage OUT (zero length) following IN data */=0A=
+            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);=0A=
+        } else if (s->ep0_packet) {=0A=
+            /* OUT data stage: hand a chunk of host data to the gadget */=
=0A=
+            n =3D MIN(s->ep0_setup_len - s->ep0_offset,=0A=
+                    AST_UDC_EP0_MAXPKT);=0A=
+=0A=
+            if (n) {=0A=
+                dma_memory_write(&address_space_memory, buf_addr,=0A=
+                                 s->ep0_data + s->ep0_offset, n,=0A=
+                                 MEMTXATTRS_UNSPECIFIED);=0A=
+            }=0A=
+            s->ep0_offset +=3D n;=0A=
+            store =3D FIELD_DP32(store, UDC_EP0_CTRL, RX_LEN, n);=0A=
+            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);=0A=
+        }=0A=
+    }=0A=
+=0A=
+    s->regs[R_UDC_EP0_CTRL] =3D store;=0A=
+}=0A=
+=0A=
+/* The upstream-enable bit connects/disconnects the gadget from the host b=
us */=0A=
+static void aspeed_udc_func_ctrl_write(AspeedUDCState *s, uint32_t val)=0A=
+{=0A=
+    bool was_on =3D FIELD_EX32(s->regs[R_UDC_FUNC_CTRL],=0A=
+                             UDC_FUNC_CTRL, UPSTREAM_EN);=0A=
+    bool now_on =3D FIELD_EX32(val, UDC_FUNC_CTRL, UPSTREAM_EN);=0A=
+=0A=
+    s->regs[R_UDC_FUNC_CTRL] =3D val;=0A=
+    if (now_on !=3D was_on) {=0A=
+        aspeed_udc_set_pullup(s, now_on);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size=
)=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
@@ -132,6 +315,12 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
et, uint64_t data,=0A=
         /* Status registers are write-1-to-clear */=0A=
         s->regs[reg] &=3D ~val;=0A=
         break;=0A=
+    case R_UDC_FUNC_CTRL:=0A=
+        aspeed_udc_func_ctrl_write(s, val);=0A=
+        break;=0A=
+    case R_UDC_EP0_CTRL:=0A=
+        aspeed_udc_ep0_ctrl_write(s, val);=0A=
+        return;=0A=
     default:=0A=
         s->regs[reg] =3D val;=0A=
         break;=0A=
@@ -154,6 +343,70 @@ static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Descriptor-mode IN kick: the gadget wrote EP_DMA_STS to advance its wri=
te=0A=
+ * pointer (queue more IN data). Adopt the write pointer, keep our read po=
inter=0A=
+ * (the DMA engine owns it), then serve and complete a parked IN poll if a=
ny.=0A=
+ */=0A=
+static void aspeed_udc_ep_dma_kick(AspeedUDCState *s, unsigned ep, uint32_=
t val)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
+    uint32_t rptr_w =3D FIELD_EX32(val, EP_DMA_STS, RPTR);=0A=
+    uint32_t wptr =3D FIELD_EX32(val, EP_DMA_STS, WPTR);=0A=
+    uint32_t sts =3D e->regs[R_EP_DMA_STS];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+    bool complete;=0A=
+=0A=
+    sts =3D FIELD_DP32(sts, EP_DMA_STS, WPTR, wptr);=0A=
+=0A=
+    /*=0A=
+     * A normal kick writes only the write pointer (bits[7:0]); the read-p=
ointer=0A=
+     * field is zero and is ours to advance. Only an explicit non-zero rea=
d=0A=
+     * pointer equal to the write pointer (the driver draining the ring, e=
.g. on=0A=
+     * reset) resets our read pointer. Testing rptr=3D=3Dwptr alone would =
wrongly=0A=
+     * match a normal kick whose write pointer just wrapped to 0, resettin=
g the=0A=
+     * ring and stranding a parked packet until the host times out.=0A=
+     */=0A=
+    if (rptr_w !=3D 0 && rptr_w =3D=3D wptr) {=0A=
+        rptr =3D rptr_w;=0A=
+        e->desc_off =3D 0;=0A=
+    }=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(sts, EP_DMA_STS, RPTR, rptr);=0A=
+=0A=
+    if (p && rptr !=3D wptr) {=0A=
+        if (aspeed_udc_ep_serve_in(s, ep, p, &complete)) {=0A=
+            aspeed_udc_raise_ep_ack(s, ep);=0A=
+        }=0A=
+        if (complete) {=0A=
+            e->pkt =3D NULL;=0A=
+            p->status =3D USB_RET_SUCCESS;=0A=
+            usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Single-stage OUT arm: the gadget wrote EP_DMA_STS to offer a receive=0A=
+ * buffer. If a host OUT packet is parked waiting for it,=0A=
+ * deliver into the buffer now and complete it (or keep it parked if the h=
ost=0A=
+ * data phase is larger than this one armed chunk).=0A=
+ */=0A=
+static void aspeed_udc_ep_out_kick(AspeedUDCState *s, unsigned ep)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
+        return;=0A=
+    }=0A=
+    if (aspeed_udc_ep_deliver_out(s, ep, p)) {=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned s=
ize)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
@@ -167,9 +420,33 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr o=
ffset, uint64_t data,=0A=
                                 unsigned size)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
-=0A=
-    trace_aspeed_udc_ep_write(e->index, offset, data);=0A=
-    e->regs[offset >> 2] =3D data;=0A=
+    AspeedUDCState *s =3D e->udc;=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val =3D data;=0A=
+    uint32_t ctrl;=0A=
+=0A=
+    trace_aspeed_udc_ep_write(e->index, offset, val);=0A=
+=0A=
+    /*=0A=
+     * A write to EP_DMA_STS is a DMA kick. In descriptor mode (IN) it adv=
ances=0A=
+     * the ring and resumes a parked IN poll; in single-stage mode (OUT) i=
t=0A=
+     * arms a receive buffer and delivers a parked OUT packet. Every other=
=0A=
+     * EP register is plain storage.=0A=
+     */=0A=
+    if (reg =3D=3D R_EP_DMA_STS) {=0A=
+        ctrl =3D e->regs[R_EP_DMA_CTRL];=0A=
+=0A=
+        if (FIELD_EX32(ctrl, EP_DMA_CTRL, DESC_OP_EN)) {=0A=
+            /* descriptor-mode IN */=0A=
+            aspeed_udc_ep_dma_kick(s, e->index, val);=0A=
+        } else {=0A=
+            /* single-stage OUT */=0A=
+            e->regs[reg] =3D val;=0A=
+            aspeed_udc_ep_out_kick(s, e->index);=0A=
+        }=0A=
+    } else {=0A=
+        e->regs[reg] =3D val;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
@@ -206,6 +483,7 @@ static void aspeed_udc_realize(DeviceState *dev, Error =
**errp)=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_UDC ".ep%d",=
 i);=0A=
 =0A=
+        s->ep[i].udc =3D s;=0A=
         s->ep[i].index =3D i;=0A=
         s->ep[i].regs =3D g_new0(uint32_t, ASPEED_UDC_EP_NR_REGS);=0A=
         memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,=
=0A=
@@ -226,8 +504,26 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTy=
pe type)=0A=
     memset(s->regs, 0, ASPEED_UDC_NR_REGS * sizeof(uint32_t));=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         memset(s->ep[i].regs, 0, ASPEED_UDC_EP_NR_REGS * sizeof(uint32_t))=
;=0A=
+        s->ep[i].pkt =3D NULL;=0A=
+        s->ep[i].desc_off =3D 0;=0A=
     }=0A=
     s->regs[R_UDC_DEV_RESET] =3D UDC_DEV_RESET_DEFAULT;=0A=
+    s->ep0_packet =3D NULL;=0A=
+=0A=
+    /*=0A=
+     * A machine reset (e.g. a guest reboot) wipes the gadget driver, so a=
=0A=
+     * device still attached to the host bus from before the reset is now=
=0A=
+     * dead. Detach it, otherwise the rebooted host tries to re-enumerate =
a=0A=
+     * gadget with no driver behind it and fails with -110. It re-attaches=
=0A=
+     * when the new gadget asserts pull-up (UBD00 upstream-enable).=0A=
+     */=0A=
+    if (s->usbgadget) {=0A=
+        USBDevice *udev =3D USB_DEVICE(s->usbgadget);=0A=
+=0A=
+        if (udev->attached) {=0A=
+            usb_device_detach(udev);=0A=
+        }=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_unrealize(DeviceState *dev)=0A=
@@ -252,6 +548,370 @@ static void aspeed_udc_class_init(ObjectClass *klass,=
 const void *data)=0A=
     rc->phases.hold =3D aspeed_udc_reset_hold;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * USB device: gadget presented on a host controller's bus=0A=
+ *=0A=
+ * These callbacks run in the context of the host controller. They transla=
te=0A=
+ * host transactions into the controller interrupts/state the gadget drive=
r=0A=
+ * expects, then defer (USB_RET_ASYNC) until the driver responds through t=
he=0A=
+ * MMIO register interface above.=0A=
+ */=0A=
+=0A=
+/* Locate the programmable endpoint matching a host transaction */=0A=
+static int aspeed_udc_find_ep(AspeedUDCState *s, int ep_nr, bool is_out)=
=0A=
+{=0A=
+    uint32_t cfg;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        cfg =3D s->ep[i].regs[R_EP_CONFIG];=0A=
+=0A=
+        if (!FIELD_EX32(cfg, EP_CONFIG, ENABLE) ||=0A=
+            FIELD_EX32(cfg, EP_CONFIG, EP_NUM) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        if (!!FIELD_EX32(cfg, EP_CONFIG, DIR_OUT) =3D=3D is_out) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IN endpoint, descriptor-list mode: serve the descriptors the gadget que=
ued=0A=
+ * (read pointer .. write pointer) into the host IN packet.=0A=
+ *=0A=
+ * The host controller coalesces a multi-packet bulk IN into one packet wh=
ose=0A=
+ * iovec may span several descriptors, so drain as many queued descriptors=
 as=0A=
+ * fit. A descriptor bigger than the remaining room is served partially an=
d=0A=
+ * resumed on the next poll via desc_off; the read pointer only advances o=
nce a=0A=
+ * descriptor is fully consumed (so the gadget driver, which reads the rea=
d=0A=
+ * pointer back, learns exactly what completed).=0A=
+ *=0A=
+ * *complete is set true when the host transaction is finished (packet ful=
l, or=0A=
+ * a short/zero-length descriptor ended the gadget's transfer) and false w=
hen=0A=
+ * the ring ran dry with the packet still short - the caller then keeps th=
e=0A=
+ * packet parked and resumes on the next kick, rather than completing it s=
hort=0A=
+ * (a maxpacket-multiple short read is not seen as end-of-transfer by the =
host,=0A=
+ * which would then wait forever for data the gadget considers already sen=
t).=0A=
+ *=0A=
+ * Returns true when the gadget should be signalled (EP ACK): the ring dra=
ined=0A=
+ * (its descriptor handler waits for read=3D=3Dwrite) or a descriptor aske=
d for an=0A=
+ * interrupt.=0A=
+ */=0A=
+static bool aspeed_udc_ep_serve_in(AspeedUDCState *s, unsigned ep,=0A=
+                                   USBPacket *p, bool *complete)=0A=
+{=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t mps =3D FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);=
=0A=
+    uint32_t base =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t sts =3D e->regs[R_EP_DMA_STS];=0A=
+    uint32_t wptr =3D FIELD_EX32(sts, EP_DMA_STS, WPTR);=0A=
+    uint32_t rptr =3D FIELD_EX32(sts, EP_DMA_STS, RPTR);=0A=
+    uint32_t remaining;=0A=
+    uint8_t buf[1024];=0A=
+    /* des_0: buffer base, des_1: control/len */=0A=
+    uint32_t desc[2];=0A=
+    uint32_t copied;=0A=
+    uint32_t chunk;=0A=
+    uint32_t dlen;=0A=
+    uint32_t room;=0A=
+    uint32_t seg;=0A=
+    uint32_t off;=0A=
+    uint32_t w0;=0A=
+    uint32_t w1;=0A=
+    bool done =3D false;=0A=
+    bool ack =3D false;=0A=
+=0A=
+    if (mps =3D=3D 0) {=0A=
+        /* a MAX_PKT field of 0 means 1024 bytes */=0A=
+        mps =3D 1024;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);=0A=
+=0A=
+    while (rptr !=3D wptr) {=0A=
+        copied =3D 0;=0A=
+        dma_memory_read(&address_space_memory, base + rptr * sizeof(desc),=
=0A=
+                        desc, sizeof(desc), MEMTXATTRS_UNSPECIFIED);=0A=
+        w0 =3D le32_to_cpu(desc[0]);=0A=
+        w1 =3D le32_to_cpu(desc[1]);=0A=
+        dlen =3D AST_EP_DESC1_IN_LEN(w1);=0A=
+        off =3D e->desc_off;=0A=
+        remaining =3D dlen > off ? dlen - off : 0;=0A=
+        room =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+               pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+        chunk =3D MIN(remaining, room);=0A=
+=0A=
+        while (copied < chunk) {=0A=
+            seg =3D MIN(chunk - copied, sizeof(buf));=0A=
+            dma_memory_read(&address_space_memory, w0 + off + copied, buf,=
 seg,=0A=
+                            MEMTXATTRS_UNSPECIFIED);=0A=
+            usb_packet_copy(p, buf, seg);=0A=
+            copied +=3D seg;=0A=
+        }=0A=
+        e->desc_off =3D off + chunk;=0A=
+=0A=
+        if (e->desc_off < dlen) {=0A=
+            /* Room exhausted mid-descriptor: the packet is full */=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        /* Descriptor fully served: advance the read pointer */=0A=
+        rptr =3D (rptr + 1) % ASPEED_UDC_DESCS_COUNT;=0A=
+        e->desc_off =3D 0;=0A=
+        if (w1 & AST_EP_DESC1_INTR) {=0A=
+            ack =3D true;=0A=
+        }=0A=
+        /* short/zero-length stage ends the transfer */=0A=
+        if (dlen < mps) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+        if ((uint32_t)p->actual_length >=3D pktiov->size) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(sts, EP_DMA_STS, RPTR, rptr);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
+    /* The gadget driver completes its request when the ring drains */=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        ack =3D true;=0A=
+    }=0A=
+=0A=
+    *complete =3D done;=0A=
+    return ack;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_in(AspeedUDCState *s, unsigned ep, USBPacke=
t *p)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t sts =3D e->regs[R_EP_DMA_STS];=0A=
+    uint32_t rptr =3D FIELD_EX32(sts, EP_DMA_STS, RPTR);=0A=
+    uint32_t wptr =3D FIELD_EX32(sts, EP_DMA_STS, WPTR);=0A=
+    bool complete;=0A=
+=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        /*=0A=
+         * Nothing queued yet. Park the packet as ASYNC rather than NAKing=
: the=0A=
+         * gadget will kick shortly and the kick handler serves and comple=
tes=0A=
+         * it, waking the host immediately. NAK would leave the host to re=
-poll=0A=
+         * on its much slower async-schedule timer, collapsing bulk throug=
hput.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (aspeed_udc_ep_serve_in(s, ep, p, &complete)) {=0A=
+        aspeed_udc_raise_ep_ack(s, ep);=0A=
+    }=0A=
+    if (complete) {=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+    } else {=0A=
+        /*=0A=
+         * Ring ran dry before the request was satisfied: keep it parked a=
nd=0A=
+         * resume from the kick that queues the next chunk.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * OUT endpoint, single-stage mode: deliver host OUT data into the buffer =
the=0A=
+ * gadget armed (EP_DMA_BUFF + EP_DMA_STS). The host controller may=0A=
+ * hand the whole OUT data phase as one packet larger than the armed chunk=
, so=0A=
+ * copy up to TX_SIZE bytes starting where the previous call left off=0A=
+ * (p->actual_length); the caller keeps the packet parked across re-arms u=
ntil=0A=
+ * it is fully drained. Returns true once the packet is fully delivered.=
=0A=
+ */=0A=
+static bool aspeed_udc_ep_deliver_out(AspeedUDCState *s, unsigned ep,=0A=
+                                      USBPacket *p)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t buf_addr =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t chunk =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, TX_SI=
ZE);=0A=
+    uint32_t remaining =3D p->iov.size - (uint32_t)p->actual_length;=0A=
+    uint32_t len =3D MIN(remaining, chunk);=0A=
+    uint8_t buf[ASPEED_UDC_DESC_MAX_LEN];=0A=
+=0A=
+    if (buf_addr && len) {=0A=
+        len =3D MIN(len, sizeof(buf));=0A=
+        usb_packet_copy(p, buf, len);=0A=
+        dma_memory_write(&address_space_memory, buf_addr, buf, len,=0A=
+                         MEMTXATTRS_UNSPECIFIED);=0A=
+    }=0A=
+=0A=
+    /* Report the received length; clearing WPTR disarms the receive buffe=
r */=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(0, EP_DMA_STS, TX_SIZE, len);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_RX_IDLE)=
;=0A=
+    aspeed_udc_raise_ep_ack(s, ep);=0A=
+=0A=
+    return (uint32_t)p->actual_length >=3D p->iov.size;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_out(AspeedUDCState *s, unsigned ep, USBPack=
et *p)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t sts =3D e->regs[R_EP_DMA_STS];=0A=
+=0A=
+    trace_aspeed_udc_ep_data_out(ep, FIELD_EX32(sts, EP_DMA_STS, WPTR),=0A=
+                                 FIELD_EX32(sts, EP_DMA_STS, TX_SIZE),=0A=
+                                 p->iov.size);=0A=
+    if (!FIELD_EX32(sts, EP_DMA_STS, WPTR)) {=0A=
+        /*=0A=
+         * No receive buffer armed yet. Park the packet as ASYNC rather th=
an=0A=
+         * NAKing: delivering into a stale buffer would lose the packet (e=
.g. a=0A=
+         * mass-storage CBW), and NAK would fall back to the slow async re=
-poll.=0A=
+         * aspeed_udc_ep_out_kick() delivers it once the gadget arms a buf=
fer.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (aspeed_udc_ep_deliver_out(s, ep, p)) {=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+    } else {=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_handle_reset(USBDevice *udev)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+=0A=
+    s->ep0_packet =3D NULL;=0A=
+    s->ep0_offset =3D 0;=0A=
+    /* EHCI is high speed; let the gadget read the link speed from UBD24 *=
/=0A=
+    s->regs[R_UDC_STS] =3D R_UDC_STS_HIGHSPEED_MASK;=0A=
+    trace_aspeed_udc_reset(s->regs[R_UDC_IER]);=0A=
+    aspeed_udc_raise_isr(s, R_UDC_ISR_BUS_RESET_MASK);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_handle_control(USBDevice *udev, USBPacket *p=
,=0A=
+                                          int request, int value, int inde=
x,=0A=
+                                          int length, uint8_t *data)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    uint8_t type =3D request >> 8;=0A=
+    uint8_t req =3D request & 0xff;=0A=
+=0A=
+    /*=0A=
+     * Reconstruct the 8-byte SETUP packet into the SETUP data buffer wher=
e=0A=
+     * the gadget driver reads it from (controller offset 0x80).=0A=
+     */=0A=
+    s->regs[R_UDC_SETUP0] =3D type | (req << 8) | ((value & 0xffff) << 16)=
;=0A=
+    s->regs[R_UDC_SETUP1] =3D (index & 0xffff) | ((length & 0xffff) << 16)=
;=0A=
+=0A=
+    s->ep0_packet =3D p;=0A=
+    s->ep0_data =3D data;=0A=
+    s->ep0_setup_len =3D length;=0A=
+    s->ep0_offset =3D 0;=0A=
+    s->ep0_dir_in =3D (type & USB_DIR_IN);=0A=
+=0A=
+    trace_aspeed_udc_ep0_setup(type, req, value, index, length,=0A=
+                               s->ep0_dir_in, udev->addr);=0A=
+=0A=
+    /*=0A=
+     * SET_ADDRESS: adopt the address and complete the (zero-length) statu=
s=0A=
+     * synchronously, exactly like QEMU's generic control handler. The gad=
get=0A=
+     * is still notified so its own state machine advances, but the host=
=0A=
+     * transfer must not depend on that asynchronous round-trip.=0A=
+     */=0A=
+    if (type =3D=3D 0 && req =3D=3D USB_REQ_SET_ADDRESS) {=0A=
+        udev->addr =3D value;=0A=
+        s->ep0_packet =3D NULL;=0A=
+        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);=0A=
+    p->status =3D USB_RET_ASYNC;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)=
=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    bool is_out =3D (p->pid =3D=3D USB_TOKEN_OUT);=0A=
+    int ep =3D aspeed_udc_find_ep(s, p->ep->nr, is_out);=0A=
+=0A=
+    trace_aspeed_udc_handle_data(p->ep->nr, is_out ? "OUT" : "IN",=0A=
+                                 p->iov.size, ep);=0A=
+    if (ep < 0) {=0A=
+        p->status =3D USB_RET_STALL;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (is_out) {=0A=
+        aspeed_udc_ep_data_out(s, ep, p);=0A=
+    } else {=0A=
+        aspeed_udc_ep_data_in(s, ep, p);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)=
=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    int i;=0A=
+=0A=
+    if (s->ep0_packet =3D=3D p) {=0A=
+        s->ep0_packet =3D NULL;=0A=
+    }=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        if (s->ep[i].pkt =3D=3D p) {=0A=
+            s->ep[i].pkt =3D NULL;=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)=0A=
+{=0A=
+    AspeedUDCGadget *dev =3D ASPEED_UDC_GADGET(udev);=0A=
+=0A=
+    if (!dev->udc) {=0A=
+        error_setg(errp, "aspeed-udc-gadget: 'udc' link is not set");=0A=
+        return;=0A=
+    }=0A=
+    /* Bind this gadget to its controller */=0A=
+    dev->udc->usbgadget =3D dev;=0A=
+=0A=
+    /* Connection to the host is driven by the gadget via UBD00 upstream-e=
n */=0A=
+    udev->auto_attach =3D 0;=0A=
+    /* The ASPEED UDC is USB 2.0, so it only runs at High-Speed for now */=
=0A=
+    udev->speed =3D USB_SPEED_HIGH;=0A=
+    udev->speedmask =3D USB_SPEED_MASK_HIGH;=0A=
+}=0A=
+=0A=
+static const Property aspeed_udc_gadget_props[] =3D {=0A=
+    DEFINE_PROP_LINK("udc", AspeedUDCGadget, udc, TYPE_ASPEED_UDC,=0A=
+                     AspeedUDCState *),=0A=
+};=0A=
+=0A=
+static void aspeed_udc_gadget_class_init(ObjectClass *klass, const void *d=
ata)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc           =3D "ASPEED UDC gadget device";=0A=
+    uc->product_desc   =3D "ASPEED UDC gadget";=0A=
+    uc->realize        =3D aspeed_udc_gadget_realize;=0A=
+    uc->handle_reset   =3D aspeed_udc_gadget_handle_reset;=0A=
+    uc->handle_control =3D aspeed_udc_gadget_handle_control;=0A=
+    uc->handle_data    =3D aspeed_udc_gadget_handle_data;=0A=
+    uc->cancel_packet  =3D aspeed_udc_gadget_cancel_packet;=0A=
+    device_class_set_props(dc, aspeed_udc_gadget_props);=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_udc_types[] =3D {=0A=
     {=0A=
         .name          =3D TYPE_ASPEED_UDC,=0A=
@@ -259,6 +919,12 @@ static const TypeInfo aspeed_udc_types[] =3D {=0A=
         .instance_size =3D sizeof(AspeedUDCState),=0A=
         .class_init    =3D aspeed_udc_class_init,=0A=
     },=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_UDC_GADGET,=0A=
+        .parent        =3D TYPE_USB_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedUDCGadget),=0A=
+        .class_init    =3D aspeed_udc_gadget_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
 DEFINE_TYPES(aspeed_udc_types)=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index fb79e24fba..77958fe79a 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -383,4 +383,13 @@ aspeed_udc_read(uint64_t offset, uint64_t value) "offs=
et 0x%" PRIx64 " value 0x%=0A=
 aspeed_udc_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " va=
lue 0x%" PRIx64=0A=
 aspeed_udc_ep_read(int ep, uint64_t offset, uint64_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%" PRIx64=0A=
 aspeed_udc_ep_write(int ep, uint64_t offset, uint64_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%" PRIx64=0A=
+aspeed_udc_pullup(int on, int attached) "on %d, attached %d"=0A=
 aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x,=
 level %d"=0A=
+aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"=0A=
+aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t i=
ndex, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bReques=
t 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"=0A=
+aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val =
0x%x, dir_in %d, off %u"=0A=
+aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"=0A=
+aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_id=
x) "ep_nr %d, %s, iov %u, ep_idx %d"=0A=
+aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
+aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
+aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index eb279dd9c3..cbfd1e30fb 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -10,11 +10,19 @@=0A=
 #define HW_USB_ASPEED_UDC_H=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
 #define TYPE_ASPEED_UDC "aspeed.udc"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=0A=
 =0A=
+/*=0A=
+ * The gadget side of the controller is presented to a USB host controller=
's=0A=
+ * bus as a single USB device that delegates back to the AspeedUDCState.=
=0A=
+ */=0A=
+#define TYPE_ASPEED_UDC_GADGET "aspeed.udc-gadget"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)=0A=
+=0A=
 /*=0A=
  * EP0 (control) is served through the root registers (UDC_EP0_*), so only=
=0A=
  * the 4 programmable endpoints get their own register bank / ep[] entry.=
=0A=
@@ -36,10 +44,20 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=
=0A=
 =0A=
 typedef struct AspeedUDCEP {=0A=
     MemoryRegion mr;=0A=
+    AspeedUDCState *udc;=0A=
     int index;=0A=
     uint32_t *regs;=0A=
+    /* host packet parked until the gadget queues (IN) or arms (OUT) data =
*/=0A=
+    USBPacket *pkt;=0A=
+    /* bytes of the current IN descriptor already served */=0A=
+    uint32_t desc_off;=0A=
 } AspeedUDCEP;=0A=
 =0A=
+struct AspeedUDCGadget {=0A=
+    USBDevice parent_obj;=0A=
+    AspeedUDCState *udc;=0A=
+};=0A=
+=0A=
 struct AspeedUDCState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -49,6 +67,18 @@ struct AspeedUDCState {=0A=
     qemu_irq irq;=0A=
     uint32_t *regs;=0A=
     AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
+    /* gadget USB device bound to this controller (set at its realize) */=
=0A=
+    AspeedUDCGadget *usbgadget;=0A=
+=0A=
+    /*=0A=
+     * In-flight EP0 control transfer (host side), deferred until the gadg=
et=0A=
+     * driver responds via MMIO.=0A=
+     */=0A=
+    USBPacket *ep0_packet;=0A=
+    uint8_t *ep0_data;=0A=
+    uint32_t ep0_setup_len;=0A=
+    uint32_t ep0_offset;=0A=
+    bool ep0_dir_in;=0A=
 };=0A=
 =0A=
 #endif /* HW_USB_ASPEED_UDC_H */=0A=
-- =0A=
2.53.0=0A=

