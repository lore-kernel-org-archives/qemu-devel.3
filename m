Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2A606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=fYYq7Ww9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8c-0001ib-2u; Wed, 04 Nov 2026 10:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8b-0001iF-AK; Wed, 04 Nov 2026 10:42:57 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8Z-0001DQ-Ia; Wed, 04 Nov 2026 10:42:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJxfgoSze+bCZo9SSUbC2XrV9YThr+w0dGkwq/gxZzImAhvySUp9taLREE+CCjzuVJxVL7PDCYkcVyPY7D4fVJ3/5dy2zLaMoJFlrz/9INigwsZ+bFumhgzmSgaGS7r6hQMvBY9vVgxRU0cp0bHhSl6ix5psIIS0q//qhLJUIDD0Y46vr0utPFFFwwpjBbzNi/FNBR7XtSLD4flaq5DwnRJrZhdumYBHsakfVcfyu/JskypePzHKIpK5nQAGCfdwQh1OSpiXSSqdUmvsLS+uqWRL8eDoIZtrUM7+xgFdx114Z5F0AGvgg8e2L2mTQMJ8iruXTjoFhWIy9cpBQfNo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzUBfT5kzqKRQP8EXaUTehDtIrunVDFLc00FvDKk23E=;
 b=G+iFnjtgj4koCTD8EAxzkWXV9SC4pqtv8ukPPO18VkRNsBGc5PpVlXfI0wfJzpQcCksvAcYpKBFAetIDTlM9P2obyvbHg1A350XFiLZarHmI9zNv4voKSQ+qJcOU4Bu6N/e0A2QGRddsFxoJ38qSlU4BlOXWhpWtsRUKyS9h5KXHd2yLgubWlPWbBXrNwwr42TSFF0G970Kkz6BPHtLG1FHdX3L84CUzkfIo4MlGILl/0X231DSTrGnIC1HY1k/gp2jbViEV7T1hqlOE9kfnuhdFIIm4wtQ1bC/Kkw9yP9tfKGQaUCPHTLRDdq/qm84+dMfb+GQkyjKKZ+0wSj3Ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzUBfT5kzqKRQP8EXaUTehDtIrunVDFLc00FvDKk23E=;
 b=fYYq7Ww9prCCut+8TfnA0JMD7v3wOw/PELPWQhQj3PpoSmSquKBB2l1ZQnVI7EAwQTydn3IfkNI6S6j2roMuuaz2TDme44KeAJszBtZ1MrJXf+hJ3mZW7RVKZv9qPfIvtdKrrMTkfPOY+VqiUYxDsUYtpN+CRVcgWeaXelXCEcuJ2psSd3JE4cL4f+Yw9PUfj0/KjsS2SWxoY8+/NWNE7ZPdst1jfwjFQDYzFsN59dGkkY3/vmhe/OEHH7dJTJMox5v9bEWjigKsFNXu6G8UHHxIYh63ImtpFnBUILpMXmQ50RfCG5BRiEyi9mVCtH7IGi9Ly2mqXGlh0R3l7O5r/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:47 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 12/26] hw/riscv: pfsoc: Enable 64-bit SDHCI system bus
 support
Date: Wed,  4 Nov 2026 23:41:39 +0800
Message-ID: <20261104154207.641511-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e28e8f-26a3-468f-7a0f-08df3a8a46c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|366016|56012099006|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: DqfGRxrdMpd+yV+HIIfZ2Tlg4ibtXN8NqPc0T6Gy7z6eGbou3piT2KpjbFk3coJozbRMi7OR6WU5BqhkQsMErMnTFrFnt+W5lCf3LhFkCBNIPDVVSJc4tPu1jVAc356aY2FaLzQRDKq5qCa8FtB0wo62Wsk7sXReEGIpxb9nCnuPKuSBMwcE7R4nXzI++Eq02NZzUtWFMxV9zQOW9NItjI2OLGzChW/lNCJClqZSbBH0YLOUNiH7OALh6i/n8sOt/HSipIQxIE2Sq8HeFZxrLOJJIInKFec/v1bYL7YMYdwE/Sfm/jG5zrxJENJaJ430Ms5Km5r+LPc5YgHJngLEpe5cluEGMoP3prKt7uF6OJHUsDmloBdsuB9BQ5i1lNWcKqezLOC8gyIyksgyoVM/BIDiZTdpVzRfdvhaOY4uDviFhnHToSxyaUNng/CDcCYhpNRmIx5yr7IILApGpvEu+FGp/1Moa8tCDZ9knygxhqWMM2g6Xf1W8KpHtst8TVFu1DWttlavVoZrfELZezCoxsfAP5eeZee6xFd+HzIri5uWqdY4C6Z/GgSSu/KePEQwbkNEmE0OUH0wQV+zjLPOH66lNGngRd4XBvVJ5Nfn4Jn/cddKviFtLHIyR3UQfIWQTWiP9JQti2XPIl7tktHAcR1hUf8Ot1RD64waR4RzQyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfJ99iidbZIPcDe67fBcYo6J74k0gt8U3co4vvVwQVlqMZF/j00mznxcj5Ro?=
 =?us-ascii?Q?lRuRUkc3xv0pQrSSDohtnaLfCeQhLMqqv7Vs0kU8oUGX2eOGuLwpQN66Jb81?=
 =?us-ascii?Q?dcXCLjfD5APKe2tAQh+9Wy7NJuXUS5eBIN8e41V2GRHyjPNOorEj08KeX13g?=
 =?us-ascii?Q?n/zT9SAkQudzjdBhnF46pti6xP+DnPdiMwv37mBEDVwYfKqfR3oXGx6U46Tp?=
 =?us-ascii?Q?t1nbZ7QouPWa5Nqxp0LTj/q0IW+saPaIFHuw3GXR4A2escgVDhf0eon6nL2R?=
 =?us-ascii?Q?4JuBvXD7kTMzafEFJFHC1Ewnnvd4dFKfIihPaW32Q8M5z42OII5yiemfCrbg?=
 =?us-ascii?Q?3hf403Ik8x8HLhXbO1Z9DLo79xVSSf6XcD8LXSH3HboDvhcw7AXa4s/SpVWT?=
 =?us-ascii?Q?zNv2JJp9faEjPe9X3Yo5ftv392s/MKJEL1frpWwxSkpTQ6a8ouSObzRhPdot?=
 =?us-ascii?Q?903a4LCowTCOOe1cbm71Sts2vOxOqZjHsN4GPbjNMS70dLADNF5BB3AlOX3w?=
 =?us-ascii?Q?K3v68++YV8aLdp/7odrpvI2JZPHU/GBIIe/cLbJT0kU30uhVuUJOEucuy/uZ?=
 =?us-ascii?Q?LGTE/scAM5GeR7ZAOJLkXxlpXq55uL/jmpGfJ+Ps3j2c9XpW7zqmdKKe7ASP?=
 =?us-ascii?Q?Q9qVoCM16X/TIv1n5CkGQtyGjiwfmBSsVyCBk9VT11oaIUwPn2j9z7uU+9HB?=
 =?us-ascii?Q?ltnFRyG9sjUArKudo8Ju0UkmNRSyq781ekGqoAWoVM6ijmvRd2uzSrSj1p6X?=
 =?us-ascii?Q?eZayP5yzE1PX44Z9OzsI2y+59l2OntAAStlZXmzwQP8cxRxvqffOG62d6Hmj?=
 =?us-ascii?Q?+nIQomFL64pOaf7+w86vAkTgwtEWmVvQnlYpjtD4NkKIThLvkIN8NX6FX90y?=
 =?us-ascii?Q?Ds8JJZeaqbgQg7nodMU+CQC3GY4Ft9Z3b5/jWD3qiWwZyTLjmgWK4Vjy51zS?=
 =?us-ascii?Q?vBKxH8fsHb8BCtGXi+iIces5tQQSvL9uCvWbuBCfywOT1/0QBbc9GuFHefpB?=
 =?us-ascii?Q?VfC3P5sM94nb4V8sY+Gxdv+p126JO0XLlXlGDg01bevd3O3Lq8WE3htFjq+1?=
 =?us-ascii?Q?oL21JwNlGl+RtOjD9+q//mWZcSyvh3SPWvyrRs6tveu3rDIN1NlX2JOKqGWA?=
 =?us-ascii?Q?h51hJa3mB/ZQRdb/Kl3yW559CMIhoHZfBUXSwSx71PIczeo6GVzyzNzquzR+?=
 =?us-ascii?Q?F81/YNJUgcSAkm9bTnQhqWPk1syVt47ZhWKf/xRjkjliqPTdN5+DjSRMYi48?=
 =?us-ascii?Q?IKY6UjirCTffqlQvIpyJpieUoeJk8/BMVzvxfXfUQSLI5wk/2ERlO06fr/iP?=
 =?us-ascii?Q?06WQ3XO/DffFvEXYxY/kbPl2/jAGB9SP0g7PuZsGYuaojWomyzoNSQ0R/1sA?=
 =?us-ascii?Q?2sfzRVYVTDSkEGDFmureWllkN/YzGBOeIPHlyn7y5WmS5nr0X5S4R+A+hAD7?=
 =?us-ascii?Q?TugW4GAmCC7fbNoK0KPbRsQt+mtAECOjcxyKJWZo6Ooobl/Ew3MmfPEel+H6?=
 =?us-ascii?Q?5vq2t/0IiWo0zmwl1Q+QQLWS9k9EaALPXvuu+G6hlLe6io+4WzIYcBhrJ9dK?=
 =?us-ascii?Q?tfvOvPsl0OKYlXQCNrRvFjFwQpnD5xfzd5B9vRDD4otCOyA34sUIFexmRl7o?=
 =?us-ascii?Q?pyOVMksEdket9jyXEN3kA5v+FeuLL2hNzw1WP0XQdSRCd98snWJ+fOZDAnuv?=
 =?us-ascii?Q?7Gmt2SQAgftJUCrHSK/Gpgt43d9SjcK5qPqP3pCVBSXy8YPBF64WfrxjLNFe?=
 =?us-ascii?Q?sIBeRSjGHDHM4gXrNL/q6xhsJ4bK1nk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e28e8f-26a3-468f-7a0f-08df3a8a46c8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:47.8169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmbQz8pFhq9+RFV6SG2xiteDdGE7FCTwXA2iF5E6IHyPzEEOAaUWuJ6XeJDtnef/WHTkdMZRBajSw90WzXS778Vx1z0kUJi3T9uT8YM2gVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PolarFire SoC software selects 64-bit ADMA descriptors for the Cadence
SDHCI controller. The controller supports those descriptors, but the
Cadence property remains disabled by default for other integrations.

Enable the bus64bit property from the PolarFire SoC so the generic
SDHCI descriptor engine can execute 64-bit ADMA transfers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

---

(no changes since v2)

Changes in v2:
- New

 hw/riscv/microchip_pfsoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index d7613496f8..6d943a224b 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -194,6 +194,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
+    object_property_set_bool(OBJECT(&s->sdhci), "bus64bit", true,
+                             &error_abort);
 
     object_initialize_child(obj, "ioscb", &s->ioscb, TYPE_MCHP_PFSOC_IOSCB);
 }
-- 
2.53.0


