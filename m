Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40456D1D882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR41j-0004QB-Pn; Thu, 04 Dec 2025 02:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR41P-0004If-2O
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:45:04 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR41L-0008RH-AF
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRuqeU1qv/PnJ7xUdxAHxzuQCFu9n8jgs1b0WN89nqxcYY8s2fpePqa8Nj1QT2voOeHeV6Rc+AXtL/dBBcKcg0YKvJrJUFgsn820fc7g1HACny27V43trrcGy8miFDQNtaw3OnpZQcZzjfHxGomrbbFZR++M3gkGQmutoIucN1hmyYI3nuUacTOB8pEjPX7QkUBwNC1/btGIm6QyEcITlinookfgooMR98xSojTYN3Zx4qdQb2J8VsVcYZbGwwSzFJqtITt5vjNJwBacd1gZks1W5sI1hvt7QD4fKvz7uAVXz+2RCb77U1qKCJqwgTR5eFuBwDaS+jscff+K9y0RVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC5o7FrDxeeCpl0mhHTqjPO7vULHA0hEA3PjfP6MdhQ=;
 b=IQsxo5zD68gwfAuooTzkXR5zy/ZV8GDcDxBeRLOyzHYb7HmsrYlZZ+GEEIB0CDCX+Y45B50MoqWex1pxZ5xkm8lIOhAXiLXuuZsQEl/Eb88DASdKf2HXWLDIo//mAFd2b46ULjjIx5T4HvOIQ8geWL92fHmV97t6z1Jm8l0HV8d/ZeWZ5bTHVpkf2UnJAqVRC1BZRqF5bBAZrkawuTL3EPAfL9nn4wp6nK7IgajOE7VFCoRcSK5NvMhSsLVg2O1N2WHWx171IAV7fFIIk1dKEM0FlbcGq1FRP8YBudAvrDvfYiaWkWRbI8OfS6FDRIhZi4+i88SsQBW9C9++IZvIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC5o7FrDxeeCpl0mhHTqjPO7vULHA0hEA3PjfP6MdhQ=;
 b=b1rkRKI2jV+W4be6BahjYHeGGuPDVhym7J6ItQ/QOO5oyZ5bIsluqKmRI+kSTkOLWx93ZDlbiTF34YwRSiEA9zKJgjWCnj0HNnv426Za3G/F/Ck0rpnjm+1vAeF+dawNhbkrSZf2RrXWpzpqx6DvDFYQw+2CDI4MGNT8FOA+sU3mpCqGvDoEMCvARjZbk3PK8Uky4qw+bh6UnJlavkf/G42WcijGWOblRMMG1ZRE0ou6ngxNAhWIHZS2seSWRydcYeODuS8+SkZIHd34O9Al4MWhE+eiYhymwrmmYlQOfCFVupSn1vH6NsDkvC91FXiP8XsJ/34aT9VsXamWHnNYIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TY0PR06MB5730.apcprd06.prod.outlook.com (2603:1096:400:272::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Thu, 4 Dec
 2025 07:44:53 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 07:44:52 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH 4/4] vhost: supported the virtio indirect desc of used ring
Date: Thu,  4 Dec 2025 15:44:16 +0800
Message-Id: <20251204074416.9350-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0078.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::10) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TY0PR06MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b875d0c-5c2e-43b5-409d-08de330902b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ud5L8xO/5BT3SlDPUEInaOAC/C8nI8PKB+6m2dXeJM6nNC3pQJGDV4zfb7t0?=
 =?us-ascii?Q?ya4lc5D8ufyUJdJjUCUGbVDd2Zl4CUp2smI2ce8d3wFIpxkWMVnQQj/A8Mln?=
 =?us-ascii?Q?Q00mXXuk+mgSuX2CCIcTXPm7F+cX64oeh3t887SCNx4y2pkZ7JydH80psw0k?=
 =?us-ascii?Q?PU7s9Xqtx45QaufSOW+oXb3101+tC/UEowvVoQirIiJ3COl/mUTGX/+pAFVC?=
 =?us-ascii?Q?dWXaEW1TWDOGaGzgLA07dn6tLiDsNPmQghy1nI1Pt56IjsPi5hv3aAivVpN1?=
 =?us-ascii?Q?gdwWuM8IEqGIuKG2K0i88jP+ZjQZSVlv4KDzfAE1PgIFp3Rid6jmmdIFV72k?=
 =?us-ascii?Q?YKYc4RHe3QulM7YLQKMWunSdzBHnRrn2T+WF90NMVrm3DMPLbrDyGMoAssjM?=
 =?us-ascii?Q?wbh2LY3NwehKrc8UZE8N9P2P5ff0F0IZc5nePLVpOJ/KalVosDE6LP+SB9y+?=
 =?us-ascii?Q?LsyvyvVsQGTGVg6CKjHvslg1hdFAuSOcCCzQEDdHk3boOVGVVcY6S09QKYFA?=
 =?us-ascii?Q?gAEmvDYodwMt9BroguehMFbPgBBEsH7+1tDpSCtcC/6I7h3kVRBLqVNG7fxh?=
 =?us-ascii?Q?oY+Xx/sg0OgD7no2YqEOMw0gEqL/JQncdKIpLlGjSwM5lOcQ2c5S8UygoH69?=
 =?us-ascii?Q?qWbMrBpc1ksn2fzPibNNzvvtCcjCFib6mxs3wX3CYYbuFLXa4KbAxtgsNa1y?=
 =?us-ascii?Q?6v8Q1AuB1Tc4ZQPkNrBdUXDN4tClul+bR5W8j2OmcLwQlzMqL6XyfLU/3Eun?=
 =?us-ascii?Q?hJYlrfLsUAts0h+coRFFqhP8gxVHYxrl2B/ISnkz2WNhu/fMZAYuyygrH0bs?=
 =?us-ascii?Q?Rji2oKLzIxsZW/czEUCzmo6jh92bzzMRH8EYSxjXD634wRiVE5fhsO2pB3ZM?=
 =?us-ascii?Q?W0Mr+zT7yQRPLA+/AmZvXd+zWxbxw07kQOvikarHpThXxP9Q5J/qdrtpbXgy?=
 =?us-ascii?Q?o1UA7xSwPcSJhMZSL/4UUqlyDLUsR/+tnhjAsp+beXccrS+Y8IuuVsyiufFB?=
 =?us-ascii?Q?J16j/myieCGOFRw5CYbOyTrsKNKXE6Au/no3+hgKP2+BOhtzzloLrJ/OHqi7?=
 =?us-ascii?Q?lVrOaFGbitN0hh1yEUHQMif8rvUCmdQDY4+QUkRcAvrKkZTQ/egn0Doj7ZTO?=
 =?us-ascii?Q?HSlBilGUA3r1KNgOlqtKYs1Ez52wfzLX5vuc+/FzTfKHFwabTapvVMUx0fUj?=
 =?us-ascii?Q?D1a7CeC9PyF5LtPQe1gfhzj1acBmfPxCeDJ6c6kmifmmge1zwKHaQUpRfIDO?=
 =?us-ascii?Q?br0kqnVoTQNhAWWgxD0VzCVPp2rgB6WC+A7XdmRjaes3+Xw49nRl+7LsxYiT?=
 =?us-ascii?Q?g0oQq1MycqK8J2/nTudHeJnzP7XNF18nWr7Lep0jjBVlcShabfADqJQcWCYJ?=
 =?us-ascii?Q?VSfz8FIxg4OZkSLtVQGLdHRStCWYb/fO/7OzlusA/G1gysFIhb6B6pcnDEHi?=
 =?us-ascii?Q?ZiI6oyTUcmbG4F3nl052d1vgxq+KXwcoDe29pWsVAhjG/Kf9a+BxqHMyNZ09?=
 =?us-ascii?Q?HCZQsfmwg891PuEo0RP2YqBK7u7pRqE0I4z9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aha/p7WDQ+n6lMbXijUP9x7To4A27eJNDCCkucKUvNN7LKlvMUcq2/zF2ZJF?=
 =?us-ascii?Q?wNl/f5tcxQ3zWZ+MxrRY5j9MKWT7d+DCglQeZbta1Lisz91sMNiegvzBukm2?=
 =?us-ascii?Q?87Q/lYCsNPoj2fmbOY6XL+Mqe90MXS4C/Qy4VeBcPS0OSsNokJpQWiS2bd/F?=
 =?us-ascii?Q?C4QyfuveE3w3PxKvwGtGnJpjdMMsUnr+rtlOT3eHU0/Vj8MY/98upJBFQi9A?=
 =?us-ascii?Q?KIHb3mKmNk3qK+WP67doWv0HPHHAOOYzt5jobsMlRNzANnitLzArUhaI3EuB?=
 =?us-ascii?Q?RWvG3t0Bkbxz1IKNIym0iOEs4w80icqvPEjHsG01TXop0zn58/8uRJDiPTGq?=
 =?us-ascii?Q?IcybZhkELm18sSBKQJVk+rl5+4Hwk8yXj8qHKLDQIPfXVuXDmhwwlo6pHI1+?=
 =?us-ascii?Q?XRuuFqqTKoNJWRcmRfpYvBTwcw1ouhFkLdVR3xlhaIyOPCGGfTc86oSQEuUk?=
 =?us-ascii?Q?CTGy/s2ocmdlNaVGJIYoKLwu/lr3h5tok876D+H9bmAOu1BeRUnRGBIol4cR?=
 =?us-ascii?Q?E1DLgrxbxQ0Wku7TjRZ752R60OsiATbF16yGB4b4JC7hZPqu5mSaUyyY5U84?=
 =?us-ascii?Q?9zyP4gsi2gBvsX3UrKTOA/DWccTDB+atpqBLzx9UCtn3SyK9jVvJtHHnU/kS?=
 =?us-ascii?Q?fJL5y56iPivzpYWHE74fmFng6tCPwdWxj4wg5lECa8crT0WQ6U8dpUuB3x11?=
 =?us-ascii?Q?e7DsHp8lY0APQ5odbk69mL9UDuD70hlcIZPjdDxSMmLLwUNJR2gkItU+361i?=
 =?us-ascii?Q?rxHYg1nXj6CByv5Du0gxZd8Xsxy+uq/fppltLs5C+2EqJuWBlNJXEeeOBzJM?=
 =?us-ascii?Q?Fy0Z7QgIcxHKNm/HHATmA7q8jh52LWNrN3E+9hjEIMkV8FQA35xYFo/D3A4y?=
 =?us-ascii?Q?pnEI41SbbTPRirF+QBZMZYLWPwuLDCdFK6qo0svTcR8WajjuEDPY3RwN573/?=
 =?us-ascii?Q?iMkO346VphnEL2OOsgOu54XyMzWBOInxvwE3CRCsYTs8zloj1a+XvQz6trqz?=
 =?us-ascii?Q?76o5KEY+x2YUDB2Iz2i/TtcCFUE4zFh8ML0SAr8hDQwGIkVDYSwoB9ZIFPRw?=
 =?us-ascii?Q?nnkQa8apan7nL9zk/vXZ0IpeQdXf0b43NeJJApcuxFj+wY2Zpumq/aKphVxn?=
 =?us-ascii?Q?8FcHMKTB2YsoX3iVsrq3A6qA42+IthPn6nemQkFdVED4WjncSJXYQaIr1Sy9?=
 =?us-ascii?Q?PsOTwQGbW9JN4wo3DIOEjVgr7nWyfDMcGOsJY+yU+ISg/NFxrp+2kMpSIcib?=
 =?us-ascii?Q?smoa5RWpYTOrFsRjl1Vb2YQYO1Ylgx8qN9HQdWpl8OVC2i57FuCNjCNZPVxD?=
 =?us-ascii?Q?rBTN8gnJPs1PuAuPInXHj0HXWn1gToDz7qT6jCf+ryLNIuzKNqh5f7rFWhfs?=
 =?us-ascii?Q?YAwja0R1QqzxEqV9fUbF+IJtU9qwN1kHz/UreWKjVum7kTXnxTZIPfkj/gh4?=
 =?us-ascii?Q?zlhqY7ne/GhrWGGJO2c/Fz/wlTPf0kD+T2vMdtxZnxCEjjRlChzCgra975zy?=
 =?us-ascii?Q?4piD5wr8iu0VzVV/cpUSJNy7ZyqFBP4gvalaCOmydmCLw/zIGok2ZS6LeiEa?=
 =?us-ascii?Q?+eew3u+pN+L01zOdDth4QQ5rTRHQOiTI4XaM6lMt?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b875d0c-5c2e-43b5-409d-08de330902b3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:44:52.8332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWO9zmUkZMtIe2mbKsLSlbbayBTERJsDaG0nzYCpNQS0hrgpzlM63lvuyIrXHrm+7e52ajZArqNN06ZdU0PyTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5730
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=wafer@jaguarmicro.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Retrieve the used ring buffers in the indirect descriptor area
of split shadow virtqueues.

Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 36 ++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 94ad5c3a57..0ffb884196 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -636,12 +636,40 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
         return NULL;
     }
 
+    bool used_indirect = (svq->desc_state[used_elem.id].indirect_desc != NULL);
+
+    /* Free indirect descriptor table if it was used */
+    if (used_indirect) {
+        if (svq->indirect_ops && svq->indirect_ops->free) {
+            svq->indirect_ops->free(svq,
+                                    svq->desc_state[used_elem.id].indirect_desc,
+                                    svq->desc_state[used_elem.id].indirect_iova,
+                                    svq->desc_state[used_elem.id].indirect_size,
+                                    svq->indirect_ops->opaque);
+        }
+        svq->desc_state[used_elem.id].indirect_desc = NULL;
+        svq->desc_state[used_elem.id].indirect_iova = 0;
+        svq->desc_state[used_elem.id].indirect_size = 0;
+    }
+
     num = svq->desc_state[used_elem.id].ndescs;
     svq->desc_state[used_elem.id].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
-    svq->desc_next[last_used_chain] = svq->free_head;
-    svq->free_head = used_elem.id;
-    svq->num_free += num;
+
+    /*
+     * If using indirect descriptors, only 1 main descriptor is used.
+     * To maintain consistency with `add split`,
+     * we used 'num' as free descriptors.
+     */
+    if (used_indirect) {
+        svq->desc_next[used_elem.id] = svq->free_head;
+        svq->free_head = used_elem.id;
+        svq->num_free += num;
+    } else {
+        last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
+        svq->desc_next[last_used_chain] = svq->free_head;
+        svq->free_head = used_elem.id;
+        svq->num_free += num;
+    }
 
     *len = used_elem.len;
     return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
-- 
2.34.1


