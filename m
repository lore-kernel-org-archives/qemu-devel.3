Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7E5C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx183-00016m-Ub; Thu, 20 Aug 2026 07:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx182-00016G-CA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:14 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx180-0002G4-Q7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnwI/gAFe4nrE2CtYitxGXQsr1ePOaE82XnhX3K59V1wtLKm5fX7Z41GMwIYPn+f/jTJrs3WMBTeorGIR2YBBO+L9pTV5Rh8mKeu6NIGJkZagYB8WyQZhRGOKVDAgmFIr0Jpql3j6x9IP0nUvF5VGLJZHvd1JMy2GlYtBTLSb3J8PONg22XJrnyPL1s5FnOXgYEB/8c98WbMl5diI5N5MbR5iCYzUyusTcBVEDWPAIAsi7PRK6+glshiEaIvPXsqYLNucwQZZaPBZtmP+AfobNXZi37A+6l83rGYHRixL1937sCqLGJ8Bjb1YDobMKjoruusTAGk/DHdSeY5fGxGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkwgVAaWqdDTpgzuNGPkAV55CgPCBvNOfc5u4DSlHMA=;
 b=MZtYQcBqXsZ6+9ltBZJwG6IREueqag+IbjnUatMxLkGlGOjLE6n8p3ulyNWZPozKV6SZB5UrTgjBO8SSoyrKbiHkHFxwDjeFdXICdAHTHtWv7sRhUkPk6/LLtja1pCQDeG44mBnLUTwSCPJrZeZXk9CX+Jyoo+c9uJw46f69R6ijZEgPPyhkNj6vWSz638+3kCc9l3mXJGdujaNL3IhLM2Ll8wlJ//vQdse8zjC3dptwSEuyIQRcBrq2eYzW8Rm33++poxPzS93MJAhFOFqGnaj5YvZquM4K809iGTNgEDiT57JJSjpcVyfZRr+lLgtsB0iSYwxbD4B/kp6kvSv9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkwgVAaWqdDTpgzuNGPkAV55CgPCBvNOfc5u4DSlHMA=;
 b=fbbxfcoTp/O3ECiZFACNzISV9uM++LAhab75djL4cs6xPa5DXx1dKG4tb1D/J2+5X4EAbwjZYAcGJTJJZSQHk/o8BIFYxP1u9bGnYEAaY3lr7Zb5L+FfjeJPHNLZtwLPCW4+kDSu3my2yQdD064OQUopWm6gd6fxq2PGswZ20PkRTiaaQp87IGC19oX0vSAgm4lBDCMuvvyhdiuFYHS5ag9eGmNeheH+T8BUJCZgMMtg3Aqa/eBp8/NaaXJJDzpzmFkLxRzR1aST7qjbndDMs+qlN7lWGBaesl3tPmyUVCeemJ1u5oyufFl155hdO1xOyfQXsDbw0BjGqesfSv2Rfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB8413.eurprd08.prod.outlook.com
 (2603:10a6:150:c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:03 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 00/10] migration/cpr: support vhost-vsock devices
Date: Thu, 20 Aug 2026 14:39:45 +0300
Message-ID: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0102.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::31) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 8852258d-e45b-40b0-dc8f-08defeafc62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|38350700014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: JQZGCMoMtid8bRl9FGeb9a3RSOtCgnC76t2iz1ZCaKpfHgVMaPAslIoFdz5FuPiOarOgLzKrQiPPZ1VKRfmf5IPyqUw++Z49WkzIQnxdHZrTSFl6y0wTWnsVlAwwT/BXqSFgRgcrBhMjluD4bKeHW0ozYwwow1ONlV+UQRT3vZlr0lsS754rvruRzbtMGEKbP6/BHTlEzF53YH9N+oAIKqEmWOskQl76z1TWkjeONOsyR3bMHRjT87TTNJX2ylTV0l8/FhlXAaqHtcd+byj8m6LHztsa61sJRjU+6iiao/fV8IjPNAmQd4zeyebrpGOTLsA3BVj7Xy1yTX5Em4XMvj4HaTKVF0anaDtPkOn7Ge8smkFeH1j7XqjnwJ80Qncypv698TgYCN7fcDdl0IPd73z0lbPGdUEgdMktsbx+oOqj6h7ZVQZxwggbJevvoOwk875Sf3x2+wGtltjrllxseHKN6rx/aDCEBIv6rYq+U0c8z/srD4dwSfsGQB83y8MHBMHSLvc+RUw1OrN2Gp+NqPdB1+2SVaq1IHVLCnHknT71wcHYqj5R/l246zLlDr2B0xvEye8ccR4aKQeciYLN/gcUXfOWy9sfwt2W0QTnVBDtQE7049KfZ9qvGP/urRU5AKwi45uwnxo+6KMrGoTmgf399em2zxo7K2SODmWiLf7VOohKnwBqaQAZt3BJ8X/Mjap7Oy+NLQI9rEKiFaX7kmd9pGZOJOyzcagR5HI7HPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7I5Rx46e3GwjKwtE1pEM0abumc0iXwI108TTz6YDIvPs9wf/Dcemuv0rN9r?=
 =?us-ascii?Q?wph7zsiefUR3wkHvxywVyrzRYkSS1By8yb8PLh9XaQuJdRP04+Uj4Ve9+zRS?=
 =?us-ascii?Q?B8I1TwEDlHj2IizXfebeg5KLJS6EbSkpQPOidMP2SSwg1udnAyuT06id3/Zh?=
 =?us-ascii?Q?rFabQwN1ISm3H4JM7jHkJffyblria6tq9zt/yvHVojfIBMrfQGzqHnK/3GC+?=
 =?us-ascii?Q?wpcwFr8DyEOrcjP98pc6ROgzAvvpIYLXGL1wQZ8zDONzeQo0QiWlNgJUAKWm?=
 =?us-ascii?Q?q+VO27rgmROBiYiVv7WN4EjMA300rywFq0LqXCehkSSYxrsLu8A9mcbh/dCy?=
 =?us-ascii?Q?mxrPxBzaAbgE7oRTc4uGWSfGHBHY67x13+IJubYTKOf+Zex04M/TXQ3B3Ee7?=
 =?us-ascii?Q?QhFexoNeIGoROSIEZvg0mNHbwynYR2EOWVj4YSgUoZY1ZDs17keMX6atZhXf?=
 =?us-ascii?Q?we6jjH8/s+bXgL3uraNuFvDBbHRr8hOUcuYfxAZI17UdW0aCmaU0be5r19qO?=
 =?us-ascii?Q?Z9nI4fX8o6WI6qpWHC1trssaqHdWvrgrBdOTIxffDLBXFO2AKGSh7rFBiuKK?=
 =?us-ascii?Q?Nyp1yO2Bs1jy8eYWwQrxUl4Sr7k+3lYDlXSwYl5rAmffAfz2hY5GcbvusMfa?=
 =?us-ascii?Q?+oBbnvpxLWd1kqNZ1wQLlu0/SfVncw74Ck7RwChgBLrp9Eq/Xkx009UHMlcF?=
 =?us-ascii?Q?GrE22ovO07ryhkrlZt2mD1k0EMCQcg7n9CsSuDeZYAxQUYNLYA6m7esuATMi?=
 =?us-ascii?Q?HrCNboWXTJEonSXahc3vSYBQy8w6IT9/qCQNmfqaYwxzzWGE1uMsIMHfnAyb?=
 =?us-ascii?Q?73U0xO0XNJ1LOTOmqup+hd6+/4o37VYKbZS5BPc1nwCdJIUlkser0QpmvZVB?=
 =?us-ascii?Q?nQg+YqG02lZvvavVXUtL1SLmUyF8lZLt9jp+X+V+b4HEOZ/6QWYlF3wrnLDb?=
 =?us-ascii?Q?x3gndjNidgAW7Hw2PWwD4drL6gV/te0PwClCeyAYpHuIS3ToRbi6m0rSfQKe?=
 =?us-ascii?Q?PaqY5MUv9tKpOQX1sN7I/pDjCENaywy+F1T2OLR4K2dYIeWF1eYVkqeA9j2j?=
 =?us-ascii?Q?rxg7rRnXjiy0xKFGuO5VYUXUs5IJvai+SX9sba2/5mb2t4ClIc2eIBildcHe?=
 =?us-ascii?Q?0iSCNz9L3QZP4bCtAw6Y1NXtsmTCtbsq9WDXwjmKxyC8uETcPbyTnaOxMAbo?=
 =?us-ascii?Q?0lXHQ7coThCK7IgTKcHrATjqnLQx980fgVyNFa1abC8jZ9JiiA1diimSlh9u?=
 =?us-ascii?Q?Q8pE1B6WZ8cvTPkcLSXeL2geYL2F8uNA9JxIgUdU5MsIWo8T8B/wBNdwSDak?=
 =?us-ascii?Q?YU2G3m+Qq6WmeVQ/XzM9YFlqCUjiUnIwATxoFzPnPPSaT2dqiEwVGsZ9yNvj?=
 =?us-ascii?Q?aB++Edci60vZbsaXdyxokzYsT9LOozpVMBkMVeeibJcsyLJgwCmHaW0I4/kw?=
 =?us-ascii?Q?wHHskiVhaXUW4kneSChL08iQ8S2w0NcQZ/vx3urRmGQmQ3yAV6kcpD5YRlbM?=
 =?us-ascii?Q?GeEjv7Je6BYb4lAxT8IxryxwVkfs9YyglkBcK1k1Hu75gZJNw++ilV7wvz8u?=
 =?us-ascii?Q?TWwyPfJ/Gjt4q8wl1jWbs41cuBOD0Yk63lo3YVMpCbVq3Qj21DiJG7aGmGtE?=
 =?us-ascii?Q?41SgmtVCWI2dz68pCb2m3x8M9VV2aTTk4LZb+u964SRoGJp9n8ftAN6Pj0cU?=
 =?us-ascii?Q?X+Cjg8kI8N0m7Tu/r80d3Skn0YkKrpogn6ghJ9Tk8bYc0SjwSqDbDUJv2n8G?=
 =?us-ascii?Q?2pgiDoCXIj8wol1LDqyvqUelw9RAKyU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8852258d-e45b-40b0-dc8f-08defeafc62d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:03.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgyCZK7yOveT8S8tDcxCm3da3+yfvZ1Ixuhdh74x1viFycFggTidWRBhL8e025dnxny7YuOJbWR0A/VoClljk7GCunynVP+DjoNiSrrc59k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8413
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v4 is mostly fixes suggested by Stefano.

v3 -> v4:

  * Patch 1 (NEW) ("vhost-vsock: block CPR migration modes"): block the
    CPR modes until the support is fully in place.  Make mid-series CPR
    attempts fail early and gracefully instead of crashing;
  * Patch 2 -> 3 ("vhost-vsock: don't reset connections during CPR"):
    write vhost_vsock_post_load() in its final shape, not defer to the
    last patch;
  * Patch 4 -> 5 ("vhost-vsock: preserve vhost FD during CPR"): reword
    commit message;
  * Patch 5 -> 6 ("vhost: factor out vhost_dev_init_backend()"):
    document vhost_dev_cleanup() on error;
  * Patch 7 (NEW) ("vhost: make vhost_dev_cleanup() safe on a partially
    initialized device"): split the vq->dev NULL check out of the
    ownership handoff patch;
  * Patch 9 (NEW) ("vhost: add vhost_dev_is_initialized() helper"): add
    an explicit 'initialized' field to struct vhost_dev instead of
    relying on hdev->mem;
  * Patch 7 -> 10 ("vhost-vsock: hand off device ownership across CPR"):
    - make the start guard in vhost_vsock_set_status() check
      vhost_dev_is_initialized() and vsock->owner_reset instead of
      vhost_dev.mem;
    - call vhost_dev_cleanup() if setting the guest cid fails in
      post_load;
    - lift the CPR blocker (narrow it to the ID-less case);
    - reword commit message.

v3: https://lore.kernel.org/qemu-devel/20260626164643.2526-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (10):
  vhost-vsock: block CPR migration modes
  vhost: add vhost_reset_owner op
  vhost-vsock: don't reset connections during CPR
  vhost-vsock: fix FD leak in realize()
  vhost-vsock: preserve vhost FD during CPR
  vhost: factor out vhost_dev_init_backend()
  vhost: make vhost_dev_cleanup() safe on a partially initialized device
  vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
  vhost: add vhost_dev_is_initialized() helper
  vhost-vsock: hand off device ownership across CPR

 hw/virtio/vhost-kernel.c          |   6 +
 hw/virtio/vhost-vsock.c           | 220 +++++++++++++++++++++++++++---
 hw/virtio/vhost.c                 |  57 ++++++--
 include/hw/virtio/vhost-backend.h |   1 +
 include/hw/virtio/vhost-vsock.h   |   4 +
 include/hw/virtio/vhost.h         |  49 +++++++
 6 files changed, 307 insertions(+), 30 deletions(-)

-- 
2.47.1


