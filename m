Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBF5C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL0I0-0004Ja-P0; Sat, 22 Jun 2024 08:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wendland@live.com.au>)
 id 1sKvSR-00087m-Au
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 03:46:48 -0400
Received: from mail-mw2nam12olkn2099.outbound.protection.outlook.com
 ([40.92.23.99] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wendland@live.com.au>)
 id 1sKvSP-0004DW-Kq
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 03:46:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdZddKEMhqZvYEu+r0mf5fWqWqdHTeA6TFm7MPOSiq3JFyEPMZ3j5eKPUY8qQIo9l55iMngPoyypKKRdy6PNHpJ8gOdLdnUcg9pumwWI4uS01PM4b2Iq2yqtvRq7XZUfryFvMMb69rKgh5jSpjvszJBmTnIS+L1r5eRajNjWsjEesKUx1ShtrhlCVCVHrK5ITCldW+lDNG2lyo0Qx1Ao68/FyF5zJ6ZUIZ8budzS3lCqj5GvD7ObgJWOS3wYwQ6j8DeL2PpmMrJd4y0IYFThK3NwveYLhZQl85WTWRh64M4XY+3OeHCoJ/FigNR1Q0XXbb6LJeZ1wsmkoINZMtxlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmXQ+Op3WrTaHYmcHws2XBqeNaH/0dqs+mSMStfK3XQ=;
 b=Kp3IX5eXTkjDKS0RgRFwG/YvXkJvnaGDn+4kWXGY5sZMd9J8Y7GwnGMQb/j242mFp5bC+qkULzB4uqi0JbQyKk1koYyOS7FB2Df74Js4Lq2GRr0YzRpXyvA/4gYKHwuiT8oox+tdgjMilz9JzwpRi1Kx8snIL24MAJJwqvOO3EyNX+DBLHkwsCSF4iaqyuyNKCivYBTZsiL+/FOXdS6MPg6aS1vbYWjHnf3bGBcN/NZPdnZOvGE0ahDjcGs+wp4bldg5DqXC9wPr/+y0Z0Z1YcoG6n/xevglRJBMWWC8yZMdflhVCJyI32Ukhxyytpq37/0Xr0/t6zt8GKVoWGefTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmXQ+Op3WrTaHYmcHws2XBqeNaH/0dqs+mSMStfK3XQ=;
 b=HvJsBOmh81KCVbrGQKLmOSZzdVV1RCn9twmWQwfnBGqwrSHpIFstB3F7pPE9Et8Ab36WRzneUlImRGs6qedtlMLB2OO/xSvaQWC2VESxJ0aV5cjbmJiUM/gI9M5i4syOg7AQmiPI8SqsDtqny+5iLoEnmyaLxtWD7g5Q3T0m6qZMat4wkDm+CzZ2g3N0/RX1seeWXTr1yjARvl0oajuNiDeRwe0QCYsLrc4Ku3kqFUsKg+qKXyLhMSW2mcU3vvvg1BALXed50ZXOXhfDCNdgW5ihOfnN1JGJJ9m7FLXcrqEX38rBGOFP/36tvGEWTkjRFi1gkUJVguoByvr7IEQcmg==
Received: from LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d7::7)
 by PH7P220MB1534.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Sat, 22 Jun
 2024 07:41:38 +0000
Received: from LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM
 ([fe80::f559:6351:749f:b7fb]) by LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM
 ([fe80::f559:6351:749f:b7fb%6]) with mapi id 15.20.7698.017; Sat, 22 Jun 2024
 07:41:38 +0000
From: Ryan Wendland <wendland@live.com.au>
To: qemu-devel@nongnu.org
Cc: Ryan Wendland <wendland@live.com.au>
Subject: [PATCH] hw/usb/hcd-ohci: Set transfer error code with no dev
Date: Sat, 22 Jun 2024 17:10:38 +0930
Message-ID: <LV3P220MB18680A6716082003FEC1846386CA2@LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [r6V9/W9nYR7aRexWS5h6rf4X4+TN+ZB0]
X-ClientProxiedBy: MEWP282CA0176.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1cd::13) To LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1d7::7)
X-Microsoft-Original-Message-ID: <20240622074038.62758-1-wendland@live.com.au>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1868:EE_|PH7P220MB1534:EE_
X-MS-Office365-Filtering-Correlation-Id: 4302ff5f-6851-4e9f-f48d-08dc928ebfcb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199025|4302099010|440099025|3412199022|1602099009|1710799023; 
X-Microsoft-Antispam-Message-Info: QKwoHX8jOUbeSoVGeWJIZqSWnmBsamgE8MZhiA2yZqnn8qFALw58oIF6oZFG48BgOg8pYU0Fo8gxbqwHWIKRfZf8/7DV+mchXUvHaH7VYXs+1UmI6XHvuQUylYVFNZ8l/LjBsFZjTbvc6kjaLNQ0BFZfyM96wGiuSoNAU2pT8Ycs1q55aToujBwlX5R/L+0pecwTwfIdSiD8D0R4HNshPBzTzpsjE7dmagTP+ogvPY/NBfkHU2FKoeKAsyoeEyR4sZm+sNrOyZa2b7jVZnCUF+vGWjtcYaGjzfxw5anMJMRU0XoVdBL0wUBXnnZm7/QMaDT5WfEujap+MT8OTtA3WGOk63cHcgT34UlF3O2hdMAjxsXmFCHEVejwBnZZl7WYeDdWG+pd9WGFlqI7mhgT0nunxwEpyq6GDkbTvLyjhwLH2uI7ych0WntanZ1yC6G5LwWzdY2aRHypwN1UWs2bcSbQ/4vu3hWP+pgFFx9F3CEdHrRY+7BTnCNCT9ClzYGlyFIp5IJJ1VPN8l8D4OHCm6bQWwfJvPHa+7XO9C7Zyo54jPrpAj1eFsjL2sNEBLJEGPNPpmeXBlBF+6620Q2suc1pLNi607OONGq4QfaIBfPLl8SUTm3h3Y5SS7sfMYplmkjWgALSoVFAruclOC2Q2JhGZi/UVnwxQN1fXXE1/KOACLDYxXjcxZCHn+A41tu2krhWxL226ovX+Cf7jhMxMR7UD59qzUnlTyoXA71iibc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oiaBUa3i0mVh98DYYh+/qRyOA7HRVSzfmD+j9ATCZ/6rfHISP17gI4ieE7wb?=
 =?us-ascii?Q?OwwmTcSU87jcZ1ZsCqKJoOlrALfXOM3ajtEavqTQ/QCkjtVTO7df0fDC0jT8?=
 =?us-ascii?Q?4rIZatFoTSJMuaGvNFWsP37TX5jOJh1xBP5pRLqVg8gJmM8+qQEs49S8U+W/?=
 =?us-ascii?Q?G3mPA4XyjyVYD+FIxytpuM2ZRKSIIs9Wrz/JZPAMOBkSoUrswINYcvdUN7nz?=
 =?us-ascii?Q?yC9aeQPiFR38lwoTIHU9YnwJtB7rDjl+kM6Hkcf1BhfsuoTqCgacDusXgwq4?=
 =?us-ascii?Q?YbJbcvbfNdi6GFqKgaU71iQt4sqiXBV8vbGxTfmwml6A9k16Qccm3MW7RO6X?=
 =?us-ascii?Q?QwL8j/S1JU8UDmRj3ht/9MIo+acA5OoFUy8yB9HxV3rIk7uoaoSwTaSUNoxE?=
 =?us-ascii?Q?DgepA1UX2tuFbYtO1Kvyllg8GEpzmsxazeK82VFQpBrJpOpSP6jp5EkGFPrX?=
 =?us-ascii?Q?AbSWUaNnlQ1ydOBPOT0tNJ1TjDJjeU861dX4wWFt16yqQTtpbIO4cXkmejXK?=
 =?us-ascii?Q?gPc65MKHSmjeyGn4dU3Zew8sCB/j1/ur89wGSE8Hanf7iGCsUym0Uwuq5rYk?=
 =?us-ascii?Q?eIoffvjrTQF2uN6ktLHJAuVfuNhrp8fJ3YfaWUSe9wy6aIBHxVbB/zJ3Zq/+?=
 =?us-ascii?Q?5SQgFJX8iEZOa6S4f7Zso6U6hgXm12xshz6J+dyxMAUaw6scMuZR+FzjmaXr?=
 =?us-ascii?Q?8i3sXfmOZqYiPHBZDnjHVk4XdD6FUHdVvUGS26G5ss4yKEeR12e7jSS01HsB?=
 =?us-ascii?Q?E00WF2UaRVUngwvksc1vqFUAAovqopX2oaIiOCX3Kumrn5OTCrqupD6qdLfi?=
 =?us-ascii?Q?5mh9wJVS+YjyA8XXFcP6QU2u3ZDR4fEci2Pec13VS2XJkjXsmVJWbJi/2KA5?=
 =?us-ascii?Q?w70TbgH3hNB39XwLP4TQqmNgoNlpa4sPUvMZC1UmVOgzVq94eACVNcbSQsBW?=
 =?us-ascii?Q?BkxeleWfq0cTzFtBY130O70LnqfDHaJLNwHKcupXDDWZB514YgOF4uSCuN/4?=
 =?us-ascii?Q?082j/e07HYAvKx7aUzXTFhyD3Q0TF+MM2BsFVefMee1uMaCgfDLeJzJYxemW?=
 =?us-ascii?Q?Rc2ODV05r9utfkV89Ca2ayEZ1SiOkluXnNt4WQ4u64+1rb33rG4D8ftNs0+Y?=
 =?us-ascii?Q?QABi4fY4eD0+zZpBxFfaHeCKtvDuyuwIlMg1ChAFCXgP4NsyRPc7Ny2Arh36?=
 =?us-ascii?Q?0ZpKKVU8GnGi9w1dxajD4QWl31ndCyXMlITgxCPnzQsJobd33M94uJAns68?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4302ff5f-6851-4e9f-f48d-08dc928ebfcb
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 07:41:38.5203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1534
Received-SPF: pass client-ip=40.92.23.99; envelope-from=wendland@live.com.au;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 22 Jun 2024 08:56:19 -0400
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

When a usb device is disconnected the transfer service functions bails
before appropraite transfer error flags are set.
This patch sets the appropriate condition code OHCI_CC_DEVICENOTRESPONDING
when a device is disconnected and consequently has no response on the USB bus.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2081

Signed-off-by: Ryan Wendland <wendland@live.com.au>
---
 hw/usb/hcd-ohci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index acd6016980..8cd25d74af 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -980,7 +980,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         dev = ohci_find_device(ohci, OHCI_BM(ed->flags, ED_FA));
         if (dev == NULL) {
             trace_usb_ohci_td_dev_error();
-            return 1;
+            OHCI_SET_BM(td.flags, TD_CC, OHCI_CC_DEVICENOTRESPONDING);
+            goto exit_and_retire;
         }
         ep = usb_ep_get(dev, pid, OHCI_BM(ed->flags, ED_EN));
         if (ohci->async_td) {
@@ -1087,6 +1088,7 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         ed->head |= OHCI_ED_H;
     }
 
+exit_and_retire:
     /* Retire this TD */
     ed->head &= ~OHCI_DPTR_MASK;
     ed->head |= td.next & OHCI_DPTR_MASK;
-- 
2.34.1


