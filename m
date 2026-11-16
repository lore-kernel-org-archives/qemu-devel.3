Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56990606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xfP1sJUS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSmvp-0001L6-Ma; Sun, 15 Nov 2026 21:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@oss.nxp.com>)
 id 1xSmvn-0001Ko-6Q
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 21:58:55 -0500
Received: from mail-northeuropeazon11012028.outbound.protection.outlook.com
 ([52.101.66.28] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@oss.nxp.com>)
 id 1xSmvl-0006PO-Ek
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 21:58:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QARclO+J6vobLgw2shk22tviH03IUzpYZKz5Cf3epwA1/Jsb9LMNQ3QL3Q5sTU0lOza+HACPGy7MymfwXwVJ4EMSBQUCB7GDqIKTaJ2ZBIqNZzIM1ROIjGb1OHnwMIM2GlpdqLzaS3KDxcZaSSv5GexUJ6/WEczmLpbABApNNoNbnMmkmnJ4qn8LnawovALf0zs+wAFDSzBJFxDEM69ltSB1X36SPZ8+8dRpJpgHd4VF9+o27AipSV1FLIQXX9fp2Nq0b7eaFo3iH5NSnN5qUzviqUjdQErFvinx9iAGi2T89sNpa+Zy6Juzvy336tb2HHGEjRivJ4Zoz0+73U8g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMmCdE0OiytlNnCWd/SdZVB3tcPh+57VH1H5p/n+pKY=;
 b=iqXY7uQhT2GOA96tNYnE19fyOyYpFBOPS73k7sYCJiPL9LMWjxOYgn3xSS2J630LA0Bq5KjJKummylWPbdHGeyD6nu4DC/jHTTsdV+gYSfCkG5idXo2+YlUJFSoyF9oL2prjaVA0zbF56n7Ao1aEBHfUqnQywrYK9xkNJbZVn+Hnoz7+f3dDgyzL7TGT6fG4xhvYXmxkEqN6bTMeM7TFSLevuIOyXR2JRIWs+FLVX/4ccdqIG17H8GsEp/ulSIeQTiLK2EcE+F9kK3EaWizPQXKURtP0E2opl893j5WHI2SJtKvF02b29+9EbMXRowfZB8mvfHLcbWj4TKVv6BDwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMmCdE0OiytlNnCWd/SdZVB3tcPh+57VH1H5p/n+pKY=;
 b=xfP1sJUSfZndVu4j4+nscWctZnVeiZGWsZ0w4VVaodbE5dOtNI1PMoSN0HtWr4i8n39U4d4B2/EVr6/i0MXmlbgzjOxv+U4zjOyaUm7U5yOvlXVQ0hzYw8bWkRC2KGNDgQWOCf1munmtGA1Vu2iTjIEerFjoQsYyXTBr9KIwjqcfBS7uN352PDipdE0bWN6HyiiW7BjRb4bqSxyook3s8vDrerM7CcCS+ahjxs2Udohq1vlYiBk70409Ghk6t1yZBXR7iYY0zthU/maSOLPV9/OKMafidopFatQedKqpCU9qEhhaG0m0IdJ5dBHeohBXVHe2Z1oT4UvR0iwTrpNGuQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MI3PR04MB12658.eurprd04.prod.outlook.com (2603:10a6:290:7d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 02:53:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 02:53:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 10:49:57 +0800
Subject: [PATCH] hw/xen: Mark legacy Xen backends as hotpluggable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qemu-xen-usb-v1-1-bff36d5b646b@nxp.com>
X-B4-Tracking: v=1; b=H4sIAFRv+moC/yXMMQ6DMAxA0asgz7UUB5GBq1QMCZjWSE1LTBAS4
 u4EOr7h/x2Uk7BCW+2QeBWVbyygRwX928cXowzFYI11RORw5k/GjSNmDUi+dsEY6xtHUJJf4lG
 2e/fs/tYcJu6X6wHHcQKIDy2YcAAAAA==
X-Change-ID: 20261116-qemu-xen-usb-1a36b002a561
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: xen-devel@lists.xenproject.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|MI3PR04MB12658:EE_
X-MS-Office365-Filtering-Correlation-Id: 510dd670-9dfa-41fd-18a0-08df438cd61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|19092799006|10067099003|11063799006|56012099006|261026121527099003|261021121427099003|261102123227099003|261009223027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: IBpJxEW382rs33TQ7N6ZlrtPkedNHwGHlYN3OjcvEimkVqC8l2FcsatBseJwzV7gftMW8x6zmyGXeGDgNaIWko9r6n2RhcWN2gcUtvIfOmxSCOSHsC0b8P7tPL9gky6NJqER9EnyOQavshgYQferQlNaNJxLxkr1Wn9aFq9n9zrzcoZ9xRZRrNFL1Ctusnc/KTPP620pG3X9hjI2enB6CCSVbdJkwwmGQ8hKqYi49QXMNaUErujtXZF6/FIFPjz6cMO00K1VsPqJoc2XscUortA//fkpcf9gqtTsrZicFbX0+GGcv+8WmVB5Eti0guyvEaxZgP4cvkePAgUg+Z+TTFaT4opugUia/nhsoIjeVm5dDMd47umr2W+GPPGEYW3XpSmFvS8k6BaMdMjTdN/Qh42GfpfrhY0PLT+bu4rai3EHIzarMCjLgj0oEt3g0XGA5+9iqoWa9HboU+GY3yK9YggJvXfdi3ILx5nkGkk3xwJ1oM9XkZ8YqEkDJdROMG/MLmF+ehO3HmmGSuok6nnmalwzrcyD3uK1EBfXx08yq/ALfhbYIZUhKVG0EyE0VW9qzuwogVaXpwhq5AEbjZ2sWju0OcQWk7b8VVmi1P6B5wb8K0MB/xWzrpL6OCkWhk3Ee74ohEMl35bZNZrvREn1bnnsQIAU8VKAXu0qGoySv2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdUS0JYTitlZU1uVjludTZmU3NUOG1PNEkwZUZMbjhIUFZFbjZ5TVV1ZWFT?=
 =?utf-8?B?VWdOU2wvWmFjN1Vpd3d1dkthem1GQXBKYkNrZUNIWWtXOHY2b0dBdU94T2Zz?=
 =?utf-8?B?UTJkQk5aNXAzTlhNV2JXMUVxM25aUEJjOEV1MDk5cVVDSTZHNTZtWnh0U2Rs?=
 =?utf-8?B?eWdzTGpJL1FqU0sweVpwUXNIRld4QW5neUpXd0FUNThoT1d0TDBWdzRLcXpx?=
 =?utf-8?B?cThYRkR0c0JXdGxlOWRhaG4yZEwvendXdERHUGl0NHNwaW9rTTlqSnhKa2Qw?=
 =?utf-8?B?ZU5vWTJPTmphOURPM3JtNktZYlkzYWtDWklaZWpOWlE4eTY4VzBhdkg5OEhj?=
 =?utf-8?B?bE4xNExMZVJYNDZubWhIYXE4ZVhxMkhHMEsrU1h5V0VtamJnUmF5RFdiVTV6?=
 =?utf-8?B?dnZ0WVliZFRMT0RrelVGUDZSa3lkaHdEQldabGorbjNjeGxrUjFjYzdFWmJp?=
 =?utf-8?B?elVJUWVweHd6blM2TmV5MmxzbjhRZS83QVZLemI2Mm1lNEd4M1NzVTIvdzcr?=
 =?utf-8?B?UU5IVysxRHNMMUw4NGdqOWsvUS9vTDNXMVByeWl1amE5VFhUT0V2S05vOTZD?=
 =?utf-8?B?cHV0MTh4cmRoeWJoV0NwWEFkK3pJTTZOalcxeElBcis3YllrV0FWOElIRzBi?=
 =?utf-8?B?eVRTL1E0UDFWYU9qUVVScEI3TmZsTERzZGczTlZGaWJleEZnYUF4ZDNXMWRF?=
 =?utf-8?B?WWg4d2pXbHljMUhFNU9HdGxVZDJYc1FBcnltNnVKTzJzaHg1bU96Q0dvTHBx?=
 =?utf-8?B?TjRFdldKMGVXK0Q3TUhTNXVycnlRT2N1SUhLbGJMRUY4UGdFNDVLQUVpKzhS?=
 =?utf-8?B?ZDNBNloycVVDZkpxRFRWeDhYUTlSeTZOb0hHZG0zYlpSalpVVkpwVjByR2Nw?=
 =?utf-8?B?NFFGcjVlbDNhS0JWKzJnUGJmNHRTL293WlhJdkJNODRZbzJHMDZ5b25BbkxF?=
 =?utf-8?B?OEdvQzBpemlQdlg0RzhBZW95ZlZ4OXptMllZK1RHVW54UVcrVGp5Zm1QQ0dz?=
 =?utf-8?B?ZC9mREJ6cUtvU3ZoZlllYlNvQ2laa1JCcVZVdUZCVDlsYUxEZDNsc3lWcVVE?=
 =?utf-8?B?YU1Fd0dWRnRRcEdoOHJpdUlJMFFMOUJJKzNWOHBhYVZGWVRWTkdseS9QRlVS?=
 =?utf-8?B?SEZhVWJUdFZMb3c3aElpTWsxSzNrMENmdDBDMUxOTEVSN0Q4cGxzaXUrS0d5?=
 =?utf-8?B?bjVuYjA4VVdFN3pIOC92d29jUnF5RkRab1VsZWhScGZGSXFxNE9OUVBFQzh2?=
 =?utf-8?B?TUFIaHZzcExyT2U4dWJjaVdGYXBQUkJmQ29VcjZuMjdldUtML0ZiakhBR0dh?=
 =?utf-8?B?aEF5TnlrZUhGTFg5aWgvVkVRVWVFYUFEUUdWd0ozY1V6UEo0aUdsYk1OOTZV?=
 =?utf-8?B?SXVneEh0WjRrTUpTNmp6dERMa1ZlMjNSZEljTDVhZWRzSjBzc1NKTzJhK1E1?=
 =?utf-8?B?UFBnMHl5azZpSHNMeVJhdWlTd1E0dDMxaytHdm1PUnVML3Y1Y3V2Uis4S2pn?=
 =?utf-8?B?cHpRWWdsakRibjcyOTJtMlM4em1zelFoMFdib1FtV2V0U0o5Z0xOZHJqc0tT?=
 =?utf-8?B?VUpFMjF4aVMvNUdGUGxhNUs3dE9MU0VIWmdxS0xTaUtMSVVyS1N1c2t4NlJ4?=
 =?utf-8?B?WnpNaEhKR0VRRm1leWJKZmtrTVFhT1VmWG9JN2NTMUFIRGU0T201R1VFV2Ny?=
 =?utf-8?B?UGpmZmNBZ0x6QVUrRHBZa3B4dXplUXdDSzd5VlU2RDZ6cmxPZHVETEd1M29G?=
 =?utf-8?B?a1VPSEdVYVRJVEx0VlA2SWlrQjAzeGxKNGt0QlVaZERjMjdiZ1pXcVRremZ6?=
 =?utf-8?B?b1BWQW9ULzNUM2VKZEJ3d3RVQ0pUN3dSL3c2dHdQZHZkSENCUHJUVTZJdjJ4?=
 =?utf-8?B?clVDRnRDMERUd0s2ay9FRGRzYnF4YW1LMCtMVUpwZ0RmY1Z0bE9NUTdYU0ZF?=
 =?utf-8?B?ZGNOMHBSVmEzUEJCZEZlUStZZXV2cHptQ2JhcE05QThVYzAzSUVLTTRsNi83?=
 =?utf-8?B?enR2dGZ6RUNDWUdVWVJ6ZEFHckdlUEZPTGh3dzB3enRVOWxlQjFUNFN4TUxv?=
 =?utf-8?B?VmQ3aDBXTkFLSEtaUEhDWHZ3Tnkya09NSVJaQWZxYk1XUEtGRXZqTEpXWjhw?=
 =?utf-8?B?SnpKSm0yYSs0amdDZEVJMjBYbm56N1NBbnRPV2xlQUpHcnUwVkltQ1dEQTVn?=
 =?utf-8?B?Q3A1ZFZCa1Jad1BMSlZFMDR4aTVuT2xiMlJLT1pyYWdGSTBwR0lidURCaWNC?=
 =?utf-8?B?a3YrenVTUnhSK1QycmNVaE1ESjBjajRGV0lDVVRIcDY0eWFjY2ovUlFPTU9O?=
 =?utf-8?B?SHlnb201MnllUzVNT0E0NnRqbVZUQ3dhdEp6eHMxa09OdGhrZ0hjWlpOS3NU?=
 =?utf-8?Q?huhegZgQTV0vR+zI6nPp++QzuZAkNa55wwnHu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510dd670-9dfa-41fd-18a0-08df438cd61c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 02:53:47.9912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utv2YrjbxIusftSP2tJDOfoJXEL9WzZYaFZLersidoNfHtaef46doxDykUMr8mJi7Np3NDdcjzcC/8S9QFRvdK3D3lq/bUHpZIvj/N2IWKFL9X4Ru2zbukR8cSiFQzB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12658
Received-SPF: pass client-ip=52.101.66.28; envelope-from=peng.fan@oss.nxp.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peng Fan <peng.fan@nxp.com>

Commit 250e797ceada ("hw/xen: Have legacy Xen backend inherit from
DYNAMIC_SYS_BUS_DEVICE") changed TYPE_XENBACKEND to inherit from
TYPE_DYNAMIC_SYS_BUS_DEVICE, whose class sets hotpluggable = false.

Legacy Xen backends are created from xenstore at runtime, after the
machine is ready, so device_initfn() marks them as hotplugged. The new
class setting makes device_set_realized() reject them with:

  Device 'xen-backend' does not support hotplugging

Since xen_be_get_xendev() realizes the device with &error_fatal, QEMU
then exits. For example, "xl usbdev-attach" triggers this when the qusb
backend is created dynamically, killing the guest. The same flag also
causes qdev_unplug() to ignore these devices.

Override hotpluggable in xendev_class_init() to restore the behavior
before the offending commit.

Fixes: 250e797ceada ("hw/xen: Have legacy Xen backend inherit from DYNAMIC_SYS_BUS_DEVICE")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 hw/xen/xen-legacy-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 7977b527127..bf4396c9460 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -640,6 +640,13 @@ static void xendev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /*
+     * Legacy Xen backends are created and destroyed dynamically from
+     * xenstore at runtime, after the machine has been initialized.
+     * TYPE_DYNAMIC_SYS_BUS_DEVICE marks devices as not hotpluggable,
+     * so override that here.
+     */
+    dc->hotpluggable = true;
     dc->bus_type = TYPE_XENSYSBUS;
 }
 

---
base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
change-id: 20261116-qemu-xen-usb-1a36b002a561

Best regards,
--  
Peng Fan <peng.fan@nxp.com>


