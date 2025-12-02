Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57076D11711
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTIe-00049I-LG; Tue, 02 Dec 2025 11:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTIc-00048s-Jw
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:22 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTIb-0005yG-1s
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3pYT+eznn74YC8yt3jgwTznRTf1+e7V0yeZY8wo75jRlfXpIlnTokg4IAu8Sw/Uj+zNRLEMdRrVtn36LiBhofKlJqQkK1Zk01ZmBfhqZ7jnY7BDHpbD2Ojl7+LX1mnpYqneL96raNDjRh20H9p8rNeqhbA2j/RKWKMVWoAER6P6pq/nL4cJg9k/bjODVL/aCW1V9mWNyGIEmzk5n0i03kUQ2Nha1uaqFIOe7y+mWks1Jn4XniD3Xt9B1u3TJGmJNlxgbBOVwI+qGdaluNRuOHVHCj2hPKiVDm72Kaptpoy149QYATlXkd1swUox/8c7WFJ+S7sihtz4D+Gi0FKg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXbwsgq2K6eVm4heJD3wssEIynts8bL76glfWpTGwrs=;
 b=uODvcx32LYw6Ey7yR/ENOEIldrOr6EATH7H4h0jc1wSndjad/F/h5aIAobzzju46Za8dWkPRQlZZJxKJH811rIuA7b1VBwYbEoAZq8MrsHgvtISZ40CjVs/FPP800PktEFQ3qkNF9xczSDtBA8EtDYe4RFYdU1ULK63KQF4zzR0qdZlNVN2EfacWog/wybRpYs3lDYHVpIAa1+Q52CcMTFQayd+VZYUNSUlJwSViV73IpGZbIZqTu8lqbeFpAMCLh7kGEizAZbz+fsuFuIoY4AHwetpxo5Y4okHsedk8ffp15d3sm8pF+Mpff0T5TvbIfYTaXG42Mb4v3fa2QXTbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXbwsgq2K6eVm4heJD3wssEIynts8bL76glfWpTGwrs=;
 b=HW3IFO11mk3EzqYzLXJ71nJYbG897Bpt8V+wSedYpjnD2Oy3L1JM1oCPq5KRax4VeJ3p2qj9Flcvzx07fVSZBbBM5JyuRVBDFhVm74uJgaWq7O+wopXtJQZrKg3Hapki5neumInaejaM7URbzFx55rdyeh9K7EX2NkqP8+sSxdmB72JESXepwEPiinsxk2iR0AVRtIyROfI6z1IYH3DO/Djy6bhitDlmodV9AM8l9MOoTjRWqPH9DBdDfXM1FQb6dOljq9FFCgnbODbk945ZX0PblOeMjCxLsBLZkPLrxUhnk8yrdYPPqKX6MoaHnWBySdEkVQZwvjfBcmSLOdXlZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB11051.eurprd08.prod.outlook.com
 (2603:10a6:150:1ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:31:44 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:31:43 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 3/4] scripts/qemugdb: timers: Improve 'qemu timers' command
 readability
Date: Tue,  2 Dec 2025 18:31:18 +0200
Message-ID: <20251202163119.363969-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
References: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: a3703955-4fba-4dcc-de9f-08de31c04780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tWB7C+uqiSw7FPPjEPIBIuQUXB/Mh9lhPofCZ7CH6DNid3Nb/S0Nf4yulhKM?=
 =?us-ascii?Q?2DAQ3NRw6z5cxLe+2vjalqZpyf2cKPJZEgktsuxJdGV8FEWBuhq9uugxAXWE?=
 =?us-ascii?Q?iAQf0MxMl2gq2rDTH8ZitRf9crvj8IekaKpvoMqJmLThmlLxuNFTgwjXkYgQ?=
 =?us-ascii?Q?rrq6KQ4ApteTN08wc6uDTzb91ys89ok0PdbeCoY3qPleyrtaV6ZFi9EvZAEk?=
 =?us-ascii?Q?9gvWbTF2Bi7Ik6sj22paGcMT9t3lUapCMYUtg/hzKENPShsMBIvnZSCKy5Ka?=
 =?us-ascii?Q?gdiJleC5vU9IBYc6IesrhfMofNsNdQryn27RtS9a+jWTGCgCyMNEMsrl82/E?=
 =?us-ascii?Q?eWQSG1a4e5iF8ZBUxv/z97YS2VDxmT2NPREbGDPT25FUdulVCbDfFxaewxNa?=
 =?us-ascii?Q?Xe2tE4sga+ocRKqzr+QF9YUL7s+wUh6j2qHJ4/W1y/i7OQxXz/xhOxLCEhwj?=
 =?us-ascii?Q?LYe6iw3lUjwtSF9rCkmphD1y4cHgQfriv+c1IExUIBf16G69E/8Yh+63qiju?=
 =?us-ascii?Q?LTSl3MtDCoDyV5uEhB2ey06UcnYy/n6vLiNYciviUcd2XcYzvQh4YY/To1np?=
 =?us-ascii?Q?cDdVEsT24kz9ZHlj7ikhjb6lzWUNMf+Ug3iFQxJlL1cauhFwDDBQRBanCxtF?=
 =?us-ascii?Q?IwJhbWq8SMBcTZedSu9aSPyJegVEIKusGAdOq5S1zP7cX1sNBuftR7Pa5wiK?=
 =?us-ascii?Q?GmXd/akWyNf6KH9O7gMqc/pkrLm7SC2hoGijMjjBOjGIjeIw+WEmfPb+fpdL?=
 =?us-ascii?Q?pUfZ5/qbD+sjcmqbAp7lplFPP4toy1sXPp0gb5TpuFfQOi717C2GwMZyBpoZ?=
 =?us-ascii?Q?rQ879ztTuLCARhpISq+c2szAwOp0sJp99qucXZ/b0E1GjlXWzIXXJyRL0Lve?=
 =?us-ascii?Q?wC4po14pBANNZg+zNekXgtPVtI+X2gaVby++RT/q9ggI04RApdymL0BPyz0f?=
 =?us-ascii?Q?TMFwO532ISPpKCTO1jYO/VxGN2Dy0bnABIxAJswOIkMbbtuDxijkPC7MFC2T?=
 =?us-ascii?Q?fR4EKu7xGsAzZSzc1PGxPuR0+XoeogesbZcYVxM0iqpjrXP89rKemyiObk8J?=
 =?us-ascii?Q?fbb0t25AICOpS/cF2HSeRYLibikbOh6umb56FSZhIVJSKkDK/SHaBpLHkpJF?=
 =?us-ascii?Q?kBZx4GtgVx6reFMrQ3m8VOWYO9H3NojoU4tCk1jDxEH6ztEG+henkl08P/DX?=
 =?us-ascii?Q?x/WAM91evfTjO8MuRfa/RoTVlTLenQe/gaBeuPnjdMfPeWFRhe3TMK+F5RqA?=
 =?us-ascii?Q?lyxxOtRd/jCBqheCg6m4G8v7Urd0i5giD3+HTtwV2TJiVQZOgyeqL59tjRzj?=
 =?us-ascii?Q?xeBJ0kAtzsfdQuwwoJJm3b0Y0lGfpCs/tj40KKxf6M5UqEoWIeF/LexCxqfw?=
 =?us-ascii?Q?Xj3uoDgq+jzEmhgeOV1WDxy+z2uE4+IdB+yLSIR3eAiVYBbK/whchdtNwBHi?=
 =?us-ascii?Q?mLvFdKUM22iUFPh4aiZ0NVpgq6y5x4NMBqn3osRJVuIo85JOXWNNxco7rH2n?=
 =?us-ascii?Q?Y07N91rcTNsBUMCUMEXdqudUbvdtoScqXynj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yesKUtoiK2akKcNwiHDM93PX1hMh/Yo6EVKT2mqzOs4ie3+WSl19UczRXtT1?=
 =?us-ascii?Q?eFrFAAHJrFATEDDpbsmyIimPbpkry+vwXhFhv4pdsTnwzYxOKc3sVPWw2CaP?=
 =?us-ascii?Q?gY30sUkbDfjX4juaV6HAFjo6wVdyMggcKKHU/udzv/goraEqJyLmfpZnI7Pg?=
 =?us-ascii?Q?kmu5fIpB8iQ3zFA1oRcFlzFVIAXkNuULEfvu/8y2CI6T6OWJQBsWQPnvJrPJ?=
 =?us-ascii?Q?Sv7vt9y93izOc/xDSaiLiOE1rN0GrawpMZ1ls31bq1pd4nCToXi65F67XFi0?=
 =?us-ascii?Q?SlJaeN+qx/1ykqN5Fvbqx5FAM+xZihKZFg/RZG03tqU7QkktvrGK/qO4G1Oq?=
 =?us-ascii?Q?6sU+AZSLZ96GqnCOek9iXaaTYdROosyKFPgYFQalrut6gOVk7hFi5eWs7otL?=
 =?us-ascii?Q?kjhjS0LvaGuVxYQXVtXy0NF9+r0KyDmku8quZv03E4N9iKdPVZ1jhpKQR3ob?=
 =?us-ascii?Q?N0dp2EdkmtrJH9oRNd9NlHHPiSnjza9RTB/2joX3hzFWr5VFJPwqA93At4KJ?=
 =?us-ascii?Q?v1tr8VnII27SntKzMj8R/BugO2B1CnOg8e7XPGOgmrDPEo/Jk/EKg+w9fBJ1?=
 =?us-ascii?Q?LHr9+VUGhFHF0WZRTeySf/vgR4CozOvJvdsCeEkJkbKX/toiOpSBPC5QO2+x?=
 =?us-ascii?Q?f7RlC1+dDFs/PnWLlHDdIhrdj0T2AzRTaXgWkIJE6fFypfaUhdh/By4pU+o3?=
 =?us-ascii?Q?D28hEo3lV8KUytgGQR8juxzSOZUbd9elxYIiEhmGgUuHrcxz2Fc1lAYtuI2q?=
 =?us-ascii?Q?4BTDNCKP8uWyiHfhbY5G8qblflFp32o9sirLdEBe04eEiS15AVIy1wV1n4v2?=
 =?us-ascii?Q?BmqvUl3ndpVDtT5v/CXDx3FTM7aE6yER3hfdjGDjnErmzyEZ4T0US8rCeUJ5?=
 =?us-ascii?Q?v6Ax491TNxPyaoveOa9t1Lk3CqdoCsoMIf615hglGZ4N11NFT1oVNa2MITeG?=
 =?us-ascii?Q?NkvZBivBNQQiOvH1x0ENkuvo2H7PPaRZnkYPqKx9h52J95ag0tRFJqqslvm8?=
 =?us-ascii?Q?XioLb7lK+omXV5YdBgXHu7gEEGq1xcisrF6QMCC7kebM63c4ohUEo1G7yjcm?=
 =?us-ascii?Q?W2jofW9mUWBiYaWxKgFw61ZREGLxrtm7pUZJanoHLbavJVbFFxQZdt0zllHV?=
 =?us-ascii?Q?ynoV4UNyWkt75XQ3rB+kPXINMjlWA7Rzjhwsr8aDnLxG4kPX11Wrp0JQMDbT?=
 =?us-ascii?Q?tu7/OEEeigQ4Pmudc9it4LPCUprsEcoDEAlUjd7CYsP7wufVk8Iar5hxBLr5?=
 =?us-ascii?Q?nSsSQYqQ+vOdw0rNpLTKzF5X7Zw2CLzHBvihIHmnr2x9mBOodUING0DKzGP7?=
 =?us-ascii?Q?5V89pza/eMGnbCgpZS+vmD3Ka2g0/Ld/pJu/Xrz7TsdY8EfI+WnLoqLOuEHC?=
 =?us-ascii?Q?QzXejBkLytwY0151UZCm30f4GZ6U92ix2eJo3cW5q+0wukOFIIdFMtvS4ml1?=
 =?us-ascii?Q?ESROowl4X/YfQzUk1X9/NRHwBy0Ie5HCkhzujgPWVYF4M5sAHU+tLl0ZDnQk?=
 =?us-ascii?Q?SIbuzjLRlzIiFrnffftgNs+2p9ffA4pMFksNSQel6YSjLir5WQ2GBaNOakfl?=
 =?us-ascii?Q?2escbE53Fl+xU5IIGumaTv7lPGcM0qyj8RUZDu+a5nLGK3cNac4RfbSK0kK9?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3703955-4fba-4dcc-de9f-08de31c04780
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:31:43.8598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89+LmZAex99uVWIzRjMLy0mzUg1fmXwEFcCv+CBRYVzKTak52hqMbaA/Ajy0l226AxoI3oSpC5N7nYJ6zBoMT21E76poHkjScGAMhPE8WBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11051
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Add the 'attributes' field from QEMUTimer;
* Stringify the field's value in accordance with macros from
  include/qemu/timer.h;
* Make timer expiration times human-readable by converting from nanoseconds
  to appropriate units (ms/s/min/hrs/days) and showing the scale factor
  (ns/us/ms/s).

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/timers.py | 49 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 1219a96b32..916c71b74a 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -21,14 +21,53 @@ def __init__(self):
         gdb.Command.__init__(self, 'qemu timers', gdb.COMMAND_DATA,
                              gdb.COMPLETE_NONE)
 
+    def _format_expire_time(self, expire_time, scale):
+        "Return human-readable expiry time (ns) with scale info."
+        secs = expire_time / 1e9
+
+        # Select unit and compute value
+        if secs < 1:
+            val, unit = secs * 1000, "ms"
+        elif secs < 60:
+            val, unit = secs, "s"
+        elif secs < 3600:
+            val, unit = secs / 60, "min"
+        elif secs < 86400:
+            val, unit = secs / 3600, "hrs"
+        else:
+            val, unit = secs / 86400, "days"
+
+        scale_map = {1: "ns", 1000: "us", 1000000: "ms",
+                     1000000000: "s"}
+        scale_str = scale_map.get(scale, f"scale={scale}")
+        return f"{val:.2f} {unit} [{scale_str}]"
+
+    def _format_attribute(self, attr):
+        "Given QEMUTimer attributes value, return a human-readable string"
+
+        # From include/qemu/timer.h
+        if attr == 0:
+            value = 'NONE'
+        elif attr == 1 << 0:
+            value = 'ATTR_EXTERNAL'
+        elif attr == int(0xffffffff):
+            value = 'ATTR_ALL'
+        else:
+            value = 'UNKNOWN'
+        return f'{attr} <{value}>'
+
     def dump_timers(self, timer):
         "Follow a timer and recursively dump each one in the list."
         # timer should be of type QemuTimer
-        gdb.write("    timer %s/%s (cb:%s,opq:%s)\n" % (
-            timer['expire_time'],
-            timer['scale'],
-            timer['cb'],
-            timer['opaque']))
+        scale = int(timer['scale'])
+        expire_time = int(timer['expire_time'])
+        attributes = int(timer['attributes'])
+
+        time_str = self._format_expire_time(expire_time, scale)
+        attr_str = self._format_attribute(attributes)
+
+        gdb.write(f"    timer at {time_str} (attr:{attr_str}, "
+                  f"cb:{timer['cb']}, opq:{timer['opaque']})\n")
 
         if int(timer['next']) > 0:
             self.dump_timers(timer['next'])
-- 
2.43.5


