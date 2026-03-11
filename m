Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F176106286D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEG-0000BX-Oj; Wed, 11 Mar 2026 07:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IE3-0008L9-8S; Wed, 11 Mar 2026 07:59:44 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IE1-0004dU-KD; Wed, 11 Mar 2026 07:59:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcTmyxZF1KBEenljZ+SI928YL/T6kX2+Mq34ncsJtNcLL9EJZbQE/GV3TzZJuRo9CRhcWH4LH5VdTZQBDtsFYyHxdlJdjVpEYz+97r3Y+rX8u13SfLzJdzSPXf+lTQlWj1mJBPLC5eVUdwh9C1I1+rLNm8hm5lqwOJGJBigrlqGRtDwqpfrPLreJv07yHpisSGJ5LvC+9N6N1lkt0j5Ajd3A4s89eQ4tKv7zxwJ8uNLUnvynx+cRE3+VjpLS/PIuVU59IxXKF1ftzvN9j8rSse7cjiBfMGcHgHJfzfhUD+HYmQUUQDCmUe/sbuNeLxwAKj6eSyKbXFDmX5qv3ybBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBzxtKLY3GASShKyHU5lxuF6BWzoJXWLEaL/nUZ9J9Y=;
 b=tS661BHCfLz3Pvz4pEbFnzqWQqnE9Jr2zg133DGbtvTdbdjDCNdW5NrULDMLOnkaR/p18bSoYuJMeUjmEP4Beu6NGx5P1QyDDp2IHvQ9/i0cVb6TINLq6o03uKsHxTacaSuLBJ6umqAZ4Z49oK56XMdoNIDEf1Z1OeQCYF8TIubIfjCs5k+I/0gIk0cfJWsS5XAf2mePiFMQvyrhb1LKdK7e6U7nzpaWfAtdVFtUjlGB15HS3DBl7g/zR3x56OLsKW7V/xWnxIy4BsIPLqnzjhxixa9eWRzemI+FuFkiGfKX87nlLYWHg0kUKM6eXeVl/+ZqUVrnlKKoopbWU0g6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBzxtKLY3GASShKyHU5lxuF6BWzoJXWLEaL/nUZ9J9Y=;
 b=tScVI93En9Zd48RRWSAA5LL4AZiLlr1fYpSapiTXHYj6GKJ1LX/eXwhG9S98NHDDaTFoQZb2ovBRYR47UHaO5Y2IdJfuXWLsKQdS7BglyoIg0wXkQ2GfVxmvUDzg8a7YCX6lF1vlWj8dijQqaf1ahvtzvcNAieCoXCp6tm/YeLD1htqz2KSnvUmuQ2ufwP9Mz689VtnT162XNV70wKKqyHiQc+D7wuYNSDPiB2prKDrpeZ8G7KYsZjWyWLsEyZuLNZCmcH4naGcyJEpzb9XZz5eu66BaSuVrYmZJI2PUm9TnD/1jpeQ4ElKOKxwy9A5FnTIkXKhIKH5hXeiL54ByIw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:21 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:21 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 9/9] hw/virtio: Support runtime endianness in virtio access
 helpers
Thread-Topic: [PATCH v3 9/9] hw/virtio: Support runtime endianness in virtio
 access helpers
Thread-Index: AQHcsU5+9voeSU0fEEuP4wmL1ve81Q==
Date: Wed, 11 Mar 2026 11:59:20 +0000
Message-ID: <20260311115910.564481-10-djordje.todorovic@htecgroup.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6069:EE_
x-ms-office365-filtering-correlation-id: 73154ff3-4558-47ed-c146-08de7f65a17e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: GnKfZOlgoXcNEdzVCjQdzvmbu0YzJmt8SZ5GYzClVPus+hv7e/SBG9STZF3/PteyWgqmTgHu+CmdCku3SELl+auj8fXv0uVgrJ1wIzKOw1un3LDoLNRTqv9DTpmqG/r2GiK5QfRvnnaN9YwQLNMqYgJ1KhnR9kEjCKPP/6WFIYR3pxNGOrdLB7J7yAFrCs15BhxW4hXHMzMXK40TsTYhkmmwalbLajvtdPTEPZEs8D47pRbresUiLjOpPHtVaCzpq7DEe8yihysA7QpifiBEyfAWcwOz4lgZB17Q+i+9jZsB9Oa6QZRkMwOdMM+WxDoytMHB1bnif4l2podUOKejX47V2U9D11RjDQKe1V8WPjpW421xh6TMnJFwRNcs/H5b2mClTDS3T0eocWkWTTTACsQUgG0DCTHhWTtLdSvYxYRqVJtg1Fl9D6SJD0nyZxcfV5bhn4oicNH45eSphWHEm6UoFGz0i/1kirdljRsmA8ChQb7W/Vg+1GA5nunvgdtgmJJ1oJ8OM1fyIFHL3CCJqnT6vEZc1wA78GATHZ0xQieDlq7Gy3aIyTbSz5oQd6JGcx3HBOHb1gI5yLbSE2ZCprj6OOIXG9GpO5D6QvchRAJHhNys/sG7Yczk1Oo6d0EHPeFc2ldDk0FaoeMNMWbOy5hMn9YhSA/wpOjgc4v5kaLjyLXf7qpHyhiwnn3pMZCPkKInqNIIPAf9QDcEvEfbWH4WqZz1zdNE8Jw+u/LddyG6UcwA7Dx7mohJesvpoEq16rgXXQVFGN5owh9IKYVk/xZaLsJ9ZO2oQP0X1sQMFkY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+mYyoe3cdotYR8mHL+G76ObnRcU5dS8ay1Gr3SLQC3akdhYn9+u/UORdXq?=
 =?iso-8859-1?Q?cfsRs7V7bvvT2nVbOrwPqOCGSHLTnwjzgjCNUNVMsVimSnQVcgLsRIQa0x?=
 =?iso-8859-1?Q?W4n1P+UuK2kbW4sQs8CyaHSuqmeK00+rSVCh/OiW/WjrNzmqF3q4oJunSb?=
 =?iso-8859-1?Q?492MSLGFZPFzkYmm6DlqvMW/cCYR94LhxYbiqkrjvrk8wETe9pcrCkn2m8?=
 =?iso-8859-1?Q?aBHVP/hsCd36kH7+cF5m0YhYH9cDINP0+TW8HAo3p0O0+u4pBBVfPDFkU/?=
 =?iso-8859-1?Q?2JWrBz7tHt4xGIGOzuZBCNI0ruponhFNanfQ3O7OQhkcYYrK9wnoplkYbB?=
 =?iso-8859-1?Q?PYyRzxG/Yo+bZoiIWHDHov2kY3yPmTM+Wy0+AAz5UJGwtNcVJLk/BK0MU2?=
 =?iso-8859-1?Q?tMmFW8pK3itBMQsSewQLKEK+hu9xYvrCjbfZHg6+58XqcFnxmCRIfCtTHM?=
 =?iso-8859-1?Q?FP8NhVzwwjCpw811l+sQTFzC6bCmzMFuRjkY/bjspusnkVjI0SITqDQEzG?=
 =?iso-8859-1?Q?+aNvwmZrZb+ON5TLIgp3Qdn1pdmb6dsWzTxuhBw12aQEoQaZGO/Y92S7VM?=
 =?iso-8859-1?Q?Qm9o85aAcoINIBNs+wouZ9f7frJubpgOxV5Z9ngip8K9v9+N6ePy0UW5mh?=
 =?iso-8859-1?Q?wriqtVYDLDdGLmiiU27qeAz3d1WKeI6WlzpakyM3INPMzXnQRem0eAmiAi?=
 =?iso-8859-1?Q?7r3ttNmvxUfNpsf4hqqXBTlpIKtQ9HyfriYRmRixvr2bYcfPNGGpbyYS9n?=
 =?iso-8859-1?Q?B1Ylfd7PD6D85pZVtQdERTXJCIFpwGl4VuNYjSnA32ots3wEYeCC+CifPA?=
 =?iso-8859-1?Q?G2XYs3ZE8EKLvuw96hCcebJXBKPSnWpHyhBcSsaamycy2MDvasAj7Zq17T?=
 =?iso-8859-1?Q?7EVdajRfAx1PYO+psb+WVPPxZAcGBuTjNwwJxY4L6J4sJLd75t6xb0Zv6G?=
 =?iso-8859-1?Q?ep37MPVGrWIcGKrWqc5sOOkml4aoHi65BsJS9uUrylfidCoRKMfIs78vYF?=
 =?iso-8859-1?Q?4Baln+ishYXda7xVczN+geCQcG2sP8/0a9+kBDuT23BMKM5Galrsb08yt5?=
 =?iso-8859-1?Q?YtGn3y8LFvGBKOe2vkAgFtcK1uzMcS6gohhjBovbeJToxVYynKS1a5eq4Q?=
 =?iso-8859-1?Q?5BbYC2Zyaq1jSUFYQBmewvE/XJ509zE31C6QSTudhaBTX+QDkzpeBq6nAm?=
 =?iso-8859-1?Q?hhImPG45zbQTrk+DM4P+gCHNq5gF2NUXhJpqxtp2w7JXqWnlP1W3no3PON?=
 =?iso-8859-1?Q?fPFPOOPkXOGS+93K3GDa5ywKRUx4JVxqF/+6CrHPGrqOLjfkBkwlrLVimO?=
 =?iso-8859-1?Q?orZovrOjkypStVSpr+6yiISoKuDIBjYUFIMwVkgRApGSIr7zepfSV52HBV?=
 =?iso-8859-1?Q?tHJHR63z264qLt01c+6d8IF6K5Jb7qzwJABK6esE7+cqDD+KcW0WLzzlfJ?=
 =?iso-8859-1?Q?xqG4XLoc3Kslhd1GdTeB0F1BHrHM3HynKy1jYCv+c3S1c+0Nlg6UQw9JmZ?=
 =?iso-8859-1?Q?9GTO+enoSJfmUaRtTc/h1SnLlscNLuw6q4wktwUJr9pCy3zRbvNecE+FAr?=
 =?iso-8859-1?Q?cO7AIHmJnvC+K3/XHXIGbrxrloR38M0VQp7j4xIu0n4CF5OIVazPxaMtzQ?=
 =?iso-8859-1?Q?r6POyr09bGMqeuzeeLYDyfHCGhsycZMeZ+WRqRC1gHJeG0owW2oiTl+tIb?=
 =?iso-8859-1?Q?UhMSxoClDbIfsQ80Yvkf2LOWTi5mX+SiRxVk9drxlQBDXvRyyUjgKl6wqb?=
 =?iso-8859-1?Q?koS3JfvuAs892lCol11QcaULyY+VUloU0MHcbLToQozu2gzSytSSlS9MQ2?=
 =?iso-8859-1?Q?NYQBZF7HTFKxSgcUyjHvKS/fyWQKVPiIX0/fpVd/MhiS1JpVsoOQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73154ff3-4558-47ed-c146-08de7f65a17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:20.2730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otcT1Ik50hBbvFrKLvHDLqbp92yGk6KXc+MOOKN0ma+dp4kU5El3NQpgbBcvfZxWb2VJLqt1U377KSRCwiuS2hxl3qNxJkkAdh68VUr/W7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6069
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

For targets compiled as little-endian but supporting runtime big-endian
mode (e.g. RISC-V with big-endian=3Dtrue), virtio_access_is_big_endian()
unconditionally returned false. This caused legacy virtio config space
values to be stored in LE byte order even when the guest runs in BE mode,
leading to byte-swapped config reads (e.g. virtio-blk block size 512
read as 131072).

Use target_big_endian() in the #else branch to detect runtime endianness.
For LE targets that are truly LE, target_big_endian() returns false so
behavior is unchanged. For bi-endian targets running in BE mode, config
values are now correctly stored in BE byte order, matching what the
guest's le32_to_cpu() conversion expects.
---
 include/hw/virtio/virtio-access.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-a=
ccess.h
index b58fb6ed7e..a3f1b9f5fe 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -20,6 +20,7 @@
 #include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
+#include "qemu/target-info.h"
=20
 #if defined(TARGET_PPC64) || defined(TARGET_ARM)
 #define LEGACY_VIRTIO_IS_BIENDIAN 1
@@ -36,7 +37,10 @@ static inline bool virtio_access_is_big_endian(VirtIODev=
ice *vdev)
     }
     return true;
 #else
-    return false;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        return false;
+    }
+    return target_big_endian();
 #endif
 }
=20
--=20
2.34.1

