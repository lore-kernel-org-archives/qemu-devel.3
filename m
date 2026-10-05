Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F125CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCL-0008KZ-Pc; Mon, 05 Oct 2026 11:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCE-0008Jb-OK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:46 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCD-00058M-1u
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8KB0Lfv0//7i7tzE2HKjPLhjCLTkjah5flvZHasTU3z/r4e7dcnncid/iKfe6iedW0uyDVwiAB2rHPqDXzVpyhls2EtDZVLILwkIQKOFkGWMH533u7XaXTqd+4ewOnmqQTwoswX3vigDRxVqM+vnRPgILTPvamoTThrDJJE6e4o5jlAwCg0JW2kMQKCaAfcaEsa9RZ4pnOl+AdN2o7K4TZTmDdtWGgYE1tA19IdLN514vLUq4ql9NI7vU+sO1/5vXbhMbKX+0+L+UP98Tja0Z8iSi6dHoqT6zfWPeH678+M2TqSF+sCaN9LWXNwKJ/t46kmvacPZnVnE8WNPUia5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbE34RnEsgNrP/6xdOelQTJXhbgpwqH9Sdjp6AaY4UE=;
 b=KB7jqWouTOr4TF8o2yV0+CM1RV29mM2rsdpCEo4xx0DzwBCHV8lQEBpylBr3h/NVmlQ26+14z43vCNoKLCNehP5FFLNXctk/yf5LEmFBqcaVxOMIx0hcjad0TOq/qGGMdDGMLp4kQ+maomfjt3lTtYlAED8B/bCEN9MHvoUO5tfvVeS2bqfyoAkDjA8oLonhA6qw61Vvgluv2jqCoZD91j2SwTWU409RANokjrZ7QMSrOfSU16Zzi7LsqxcqMHDBITYTUNnBvjJOZWobgp6yX2YLHrYeDHvO3F1Meks3VPXNoifvNHGZMmSVdxbln0cklGfuJCaF9Jt7dJ38XQL2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbE34RnEsgNrP/6xdOelQTJXhbgpwqH9Sdjp6AaY4UE=;
 b=PmBsrGh/mQAP46Ifvif2o26/bQc8HldOsM1drZqj3om7aXWXtwwbzn+ox0vvDhfhJSGEkwm22903kpYJ8JziMjuVM0qlidv+fJfDG9s368ccsxjEkoU9uqFOrwXJQ8xRDLIulxwMtbBcN4OnT257b8bf9aH4skSvfdMjtdnvuImFcqgbXNcFRCjTb/oisBoJeci2Ei7uxbfxW0Zh//RYwEdWGWUNMuF9qTPi/DIwyVp9p92KUIWIZrcjiDbVlUY//0LC/W28RzdLuj0lpkk6CLrXgq/qRJO9dzUMrs+4Z+bDvaltnsy4rDHHxLljlCM2qnuBVan2f6JUkHoborhEyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:56 +0300
Subject: [PATCH v12 17/21] vhost: release ownership when the incoming
 migration fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-17-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fa2ea2-9d13-47a5-49d1-08df22f18741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wbAkEaitoj0I0IZZ8I0rwMEFw1D8FVOmaJXZjf1zpAwrqDuuI3v/t5/GDjdgE99opcbnhkz5/REp/rAKNIqpNSu6gJJCvGssv6URBf7pWyOLoFFAdj62wCKEuEmqrDb7xoDmhMlYxjmlrD71wxtIjvkt1kH08VQs3V6DJu+4ytULFbCoB2i7nwYGg3Wyiluy90h341/bvSNqz93SMDbnESAyYh7mT9xo/HSeWe36zXgjlsU+heol1n+vdCkZ4V6AikfCWP0qLe+Q9YNy620mUdmJeGL5glGgByVGh1rIBsytTfzNdURVAUCn8jJ6QTkkVA4KK9U2hLWVk0M4nXsWOm6OcPIdgy2yvbxhyJzmqoy/gPx4nRHcgnHq9gQrWdF9gZDVMIxEie5SbFbjbXVFHixYnamHPJ80fDRngNOgK+xDyFynpSAmlbg1cILNa71J1TfX+VEq5+dhPowzZoKhe3CP2Bc4uBZv6sGIixmR9SzSyufrcKqYnChhHKHl+VsifJhMhs+s9fTZO64ZiE5R+6d6KEMDBcSzN7sKBaxlR4VaXdph+sIdTdZtmzt5cMlArnIc0m05gjFjqBJyB2OmgoO8yGA8X5crX6lDVCOv7yV8QBmxoSdi8bLYIZtW/gad5H1F6C8j6mocf3LR+5j9nyjJJySV8PyPSl9eb+tJc588vEPUYMxkftdmR7wTNSFOeKjYdDW4btSznLSJXbbrV8laBI1ELIjGVWEMV2qvO/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJ1c0c3U1RnZDJWQnVwelNTZCt6WmdIQ09kY1FPZFBUNTkwVGh4TSt2ellr?=
 =?utf-8?B?b3d4b0k4Sk9nQklFNUNyM1RMYUhWRXJvU25mQW9QWkFObUV4d2RBRTY3czQ3?=
 =?utf-8?B?MzF6ZmpCWWcxeDkxOC9aSjFJaitZRHIxUDJidWVLYWdueHZSc2p4N1hjQXpO?=
 =?utf-8?B?aXpZamppVWJ1aEllaHFwbzdSMURMY3RqRU0xOURObmd3dFpuL0ZnanRabjgw?=
 =?utf-8?B?bUt6K3R0V0d1cFVjMlZNUUhQUWcxSzVVL0JpK3IzSCs0ZGYwMXZMWnRjNUMz?=
 =?utf-8?B?RmoyWHYzMm05NzJ1cWRwdWdQMVlPOWdta0g1dU5uN0hKSkNrUElHalhLYWRX?=
 =?utf-8?B?OVBhMXlITlJKaXJBMFBkNlhZcjRTWFNwRERNb2gzaktsRGlmTmZYUGo5UW1m?=
 =?utf-8?B?dVZSRTU5QXRBM2dZN0ZPcFZNZ1RheEl5WlE0dVBRSjJVT3BLbmFONHg5UStH?=
 =?utf-8?B?ZitXekczN2d4S0dZZDEvWC9jZjNKVWFvODJSVGFEOVd0Y0JLQnViQno2cE9H?=
 =?utf-8?B?WTR5QlBzM21PdElmTFFCTGNNenFndzdxSllqNThpcUJFY0pWQVZsbnBpbHRx?=
 =?utf-8?B?bXhWVFd6V3NYN0JZWkpRUjNreUFFWmx0UmxQNTQrc3poR1Jsd3VwRGVFSytD?=
 =?utf-8?B?c3NQRUM1T0tWSXdibWpjSllnS3I1cVhOQUVjQW5LUlNKQVQ2UG9GYXBYK0pk?=
 =?utf-8?B?aCtlTE0xaU4wWkY2dEVsTlZxT01NTkdwUWcvL2l4a2o5cUZTNWVRdUlSQ1RC?=
 =?utf-8?B?d3JMTTdGaWtsUlJEMmZOeHE3c2NNK2NYVkV6Wlo2bmJnQXV0bnlTQ0Y1MlNY?=
 =?utf-8?B?NDlLTEhWZ3JwU2NVdS9mL013a0YyT0JhNWRhYy94ZkZUTXRmdWFiZC9IMlN3?=
 =?utf-8?B?THljTGY0cVlLVm41V0ttOWdubkQzbTd3ZGh3MDE3dTkwYVRVdUpsQzR2WlV6?=
 =?utf-8?B?bVB5U1g3dk1xbXc3RFVqNmZDell3ZTlGTXU1cnRybTMyN1RqUTJEOFdGcDEz?=
 =?utf-8?B?TUFxZUt6MmNUQXhMa0wvc2NWMnRjNzZlYU0yaDFQaHY1dmtrNkFNdWNYT0V0?=
 =?utf-8?B?UDFXSC9obFhWOGlKNWxiME42SW5HMDlnZDQxRXZzMjFWaDRGblRqSlNCaENF?=
 =?utf-8?B?RGN0dVFUa0RPVE5JbzRpVE9sU0dXY3ZIUXdiZVlNNTJ5YjFFMStWdEN5ck45?=
 =?utf-8?B?M2Z0R0pNTXlMMHMraEExdUVjbEc1QzNLZDU2V3RRZ3VpckgyaFZ0UG1pRkFZ?=
 =?utf-8?B?a3lYN0FVWnFLcGJPSzRvY2hYUXdwVlZONGduUG1VKzhicENDR3FUdzZMWVJh?=
 =?utf-8?B?bE9kZlVLMnZObDFSOUlON0JzVzhLVHdxSlRMenlQOEZqZW5KL3ZiM2tGMUtR?=
 =?utf-8?B?VE1ZZlRwbjdrWTIzblBXY3Z5RlBBQndQc2tESXNLMlFCcWdKRDQrcGN2Wmw5?=
 =?utf-8?B?Ly9sRDhpTWwzT01Xaml1NGRLTE52c1k0TjZTUUdFYlM0Wk5JSHJYcXpTM2pV?=
 =?utf-8?B?WUpJUDd6NWhZT0dZeGR5RHc4cnBaZXZLSFBpaWZUN0hjb1kvOTJjZEhBQ3dn?=
 =?utf-8?B?MUhVYkZmUEk0RFhsSk1sN2FIdWdnblN5UXpUZTlzU3p6dUs1WFEvY2lpWWFB?=
 =?utf-8?B?MHM2V1BHVlNrK29md1p5alZyYWg2OFl1dGJxSzF3SklXSkloSThLbWtuU2Rm?=
 =?utf-8?B?MWg5czFHUlRXMXlSMHhHOVh3dGNsbDlIa05ETVZ1VlB3RWVBRCtLQmZPb0Rh?=
 =?utf-8?B?bWtKeEcvSnRZR3I1Ly9tOXN0aEE2NGxEbzZuS0VYNmdlMWpmaFlsYmd6YStS?=
 =?utf-8?B?emh0b01ZZ3ltT2ZzQ3Bpd0E4Y1ZmSHBobXpsRHA4RllzRklZS3UrazVnZi90?=
 =?utf-8?B?djFpQm1ENEtZeXRmVnFSWm0rb2J5cWtCSDNRbXdLbFJySHI0VVVId0VOUU5H?=
 =?utf-8?B?Y3Y0NFU0dmpEa2Z3bXd3QkJvTTdyZkZQWXl6cTNZREpkRkpUVTBUQTBjZllC?=
 =?utf-8?B?eXduc2dCUmhKOTFuT1Z2bjdPOFN5c1RSendGejBKcHdEMGVuUitVUGYrY2dC?=
 =?utf-8?B?VmlXbXJRSHcvdTRSSTBPUnN3Yk5hakZNZURjUlJhOTBPZkMvQXV4eVI2L0NW?=
 =?utf-8?B?UUdlU0dSNFZmR1hFZGNEdHZCQ1lpeUlBclZVNlpqRVc2WkRtaHFYUGhlSTA1?=
 =?utf-8?B?Mmx1dldwZ2lNKzMvSmZMalUrY0E5UlJiYzRGS2REZVNoeVRVdW05TVVmN2dF?=
 =?utf-8?B?SDFHM2dkaTdJYkRpUXo5Ym9HQzJqa1Z4eUxpL2pHNXNaZXMrb2dYQkFQQ1Vi?=
 =?utf-8?B?SjdKZTdvVHZ6SmVUelBPYjlaY3N4VWR3YlNGdWhRMVBWNTdiYXRTSjAvc1Mx?=
 =?utf-8?Q?tUXCpJWN29wPDqQ4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fa2ea2-9d13-47a5-49d1-08df22f18741
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:26.2611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8XqJgBbB0pscpoNjn+lJ0xk4DDbMNyOR8Ec5s5zn/UEPX3/ltHBGkPsk+Q7GdpAHjtGfW+BxMXe2r/faGlEeNgmcYsKZ4urolhMx68jgi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
truncated migration stream footer, makes QEMU exit() right away, and the
ownership stays with the dead process.  The source still holds the FD,
so the kernel never releases the device, and the source can't take it
back after being resumed -> SET_OWNER fails with EBUSY.

The exit notifier is not good enough here, since in case 'return-path'
capability is enabled, the target reports the failure to the source before
exiting.  In this case the source resumes right away and is racing with the
target's exit() for the ownership.

Add an incoming migration failure notifier to each vhost_dev, registered
for its lifetime, that releases the ownership if still held.  It runs
before the failure is reported to the source and before the target
exits.  A target killed with SIGKILL or crashing still leaves the device
unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 24 ++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1241c5a954d..86e9a234638 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
 #include "system/memory.h"
@@ -53,6 +54,22 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+/*
+ * A CPR target takes the device ownership in post_load().  If the load
+ * fails afterwards, release it before the target dies or before the source
+ * learns about the failure and resumes, so that the source can take the
+ * device back.
+ */
+static void vhost_incoming_failure_notify(Notifier *notifier, void *data)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          incoming_failure_notifier);
+
+    if (hdev->owner) {
+        vhost_dev_reset_owner(hdev);
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1823,6 +1840,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->incoming_failure_notifier.notify = vhost_incoming_failure_notify;
+    migration_incoming_add_failure_notifier(&hdev->incoming_failure_notifier);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1872,6 +1891,11 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->incoming_failure_notifier.notify) {
+        migration_incoming_remove_failure_notifier(
+            &hdev->incoming_failure_notifier);
+        hdev->incoming_failure_notifier.notify = NULL;
+    }
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index f6e32b59ab2..6df012859a6 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,6 +3,7 @@
 
 #include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
+#include "qemu/notify.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
 
@@ -116,6 +117,11 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /*
+     * @incoming_failure_notifier: releases the ownership when an incoming
+     * migration fails, vhost_incoming_failure_notify()
+     */
+    Notifier incoming_failure_notifier;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


