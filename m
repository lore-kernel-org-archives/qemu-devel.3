Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF19C67861
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 02:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtHqg-0000kF-VV; Sat, 06 Apr 2024 22:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rtHqd-0000js-SY
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 22:01:32 -0400
Received: from mail-tyzapc01on2093.outbound.protection.outlook.com
 ([40.107.117.93] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rtHqb-0001mi-GN
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 22:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTIkDqh7P52COfD8dBhYc5Zq/ALRrgIgWzyYamO+2naeih6ELamdgGh9Y/GRovyqAOu54sajjJsg3dT72AdngwfwEtZ914JjetsPWxYZKMk/EWU51bVmrUR6zQ0Tqa2pCKOCYagUQzWi2B+fr6UP0b2Z+K1QLxyb8FbYZL9eqLRKFmj0gcfEp4d0qf+2UD7YVQHJ1xdaBDrbX+zntLGdj1zNKBae5a0uh6+zJF0q5+cNA/jAVf/3iIDxFlCp5T6r2papzUV1iSd+2U8d1qnLgOupSnb1r2X2GqurkEgxH4A12YkF1YNmrkALfVz99zjXcDIY8BWEUsbCnuWM3JX6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Xaupiy6G5AxHZn4ASBKHIhMrK2GozhLJEYL8jK1h6U=;
 b=ZC7zCE59uC2b3yUQ+PPaDYzOw9Pghk46agaLsSc7fAIteRuWN6SW3heWYw5bMwcfeepB5wwKpD/MP9Sk8K2ukbeQw0hsyhWhuHX6WLYjrc1gMga0mHKqx0QV+i0z0OSpxNf/TIFt8C1VlQlfY6N6zYdzYTzMQ3eMkcd6QenjO8oX+dWg8pKesblpe5A/UvK0xtYQTRNefEcyEYH9sUZbdtc+cYPUyUoFIgzvta5rvw/VeF8z0SgmmJFnnN1YOmQ+d7UWgeqh62SdbQGJcvhE985FHFmPY2bDuKa9WIkIv0H1B04X7cR3SzpNf2wNszC0o/Y+YIMVZMUqi8oIz10OnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Xaupiy6G5AxHZn4ASBKHIhMrK2GozhLJEYL8jK1h6U=;
 b=OYRT0ylU4R7OF2SKodceaw33juWxwJUwgl7lMdwXjiejssUu3KY+C6hCgbpdUiqiXE+aCV6S66aRmShvdzYIeDmAiV8UhUhSEtorcLBK1VKCcotMlhbVg8AMR270P9Xc94IcCOB7buAwuslmtQZbfOR8WlovpZEG/MORSbanGyfRtL+PBU+44r9x3MHBE3c5rfkUlEiEdpPGW1b+D0Vy2/g1CwfMUGck47N4dDXm/2XFeQvtcQfLwS0CF8xXjVnfFMghFy7P+D97kYWR8RZviBy5s7VoZMc35m0t1k12mMO3Yyt8ZU3Xfvrc+LJyVfQk+qerI/t48lFhdcZ3xB+EtQ==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYUPR06MB5876.apcprd06.prod.outlook.com (2603:1096:400:35e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 01:56:21 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5%3]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 01:56:21 +0000
From: Wafer <wafer@jaguarmicro.com>
To: eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, jonah.palmer@oracle.com, leiyang@redhat.com,
 angus.chen@jaguarmicro.com, Wafer <wafer@jaguarmicro.com>
Subject: [PATCH v4] hw/virtio: Fix packed virtqueue flush used_idx
Date: Sun,  7 Apr 2024 09:54:51 +0800
Message-Id: <20240407015451.5228-2-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TYUPR06MB5876:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2l+LqqCKWfygpnm3JnGjelIGP++YDCDmDfEzzVfJFafMGK4gk9wWNYlf1CHNhpe9rjIHm3LdBQ6uB2tPFsDGobM1WkjDMPRR6KDLqf5WnHofBaWtAfy1wK4es6XK0YSptKStZAj+HWWgqTknC02Gjsr1oHuTktC9uvkrDxlDkQLAMtqXk5ykpy+j+DtYGjFemztNCxlvoPI/Ib1JSSnhSCHPESVdDZ2txvbxlaudHX59NAnd6xmXhcRedh7CMSyrLa1n6WxtcxMFi1YGWhqLsOPPFIjxiqj5C2l9NrSb8mAfHddKkDiD8btW1GufXJYo5Snv6T51SZmtLIfRrrFM9MgHQzFvxV5+3BC86eZCo+LT2uQnBZbZu22H6nf/xgUxEVSfAnmnUguYheXKETK4xxc0gnw1bw9zKtZWHln+A5+t1LbI0MVnNXk1gLmSYmtM4alTkfWeaXU69R4sQbx1Z/TeEcuq8la8yAZe98GsI4A1jt28moghpYCYk+4xJapr7xYV+q4WEf2ipeut4CxtNhhqDIx1wk9zpVQei5lQQDYO42s3k0BOrQBKeXssKLCElhUwF5/ySNaWq3vDspyejVZUVikF+/V5Mg2e7qyUR7Yj7R39fQAEplBl05KUzn4rlmYrRcERsicSAD1R12Qtel6SlMLoLK9RkhIE5Say5+Wd+OrqWHJYZI24mg++sQXMk5ID573BMQd1FQqgJ8dB5P/7ayIzxAjZI0FBjKge2dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(366007)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JuYlAwQXBMcUZKeU1KeWIzd0VlY2JZS1NZdTQrV1pRSUtQYzdCc1lrdzlq?=
 =?utf-8?B?WEswejlKVFZmUVJHa0FQdzNLWDVnUlV4aE9aTmExS1hOaDNESUY0SGc2N21R?=
 =?utf-8?B?U3ptaHFwYVErZjMyVDl3bFkrZWdMT0xsRWg2RlZMTzY3cllLSlZ2YUhnckpp?=
 =?utf-8?B?UmtLZStPanBYUlZBY1FCdU9NQXVqYmFwTk5Wd245Vk4xTWNDSExnQTMxZUxI?=
 =?utf-8?B?OUdiRjJRVUFkWnViSFhPMlNubVBuZlMzQ3NjclYzcmtzdlVIQU1JZVY4QWxF?=
 =?utf-8?B?RTlVS3JTNnJVejA1ZmxTaDZmRFBVZ3FqcEZablpwNzJZNytiRkpLNElkdlJn?=
 =?utf-8?B?Nkd0alRUOTBUeHJqTWlNZGJzclZQNk9pUjk0VTAvdHVha3lacG84QWRnUy9o?=
 =?utf-8?B?Sm80TzVUZHBLeThVYWNoamlreG5yanFvNnd2elU1ZWJpdzFHM0cwWHBTVzQ1?=
 =?utf-8?B?K3pwb0RaZWI4azRLK3AwWGNkVnJxU3Zqa1BGd0srOTVFR2ZuZVNpejd6Z3lu?=
 =?utf-8?B?eU1wZklaNjFUdWQvQ3ZYY21DTTBjVExBMkorZDZNcnZoZkZkdzRqSko5dFh4?=
 =?utf-8?B?RVloaTZjam9mUlMrZE1zYVFtMStzVUpNV2x6dlJCUVo4ZWlmSDF5WGRCZTBj?=
 =?utf-8?B?OHlCN1IyUiszb21ZZ3NIUEVQV21oY3Y3cTg3dFIwanlZZ0hUdjdWck9xT01k?=
 =?utf-8?B?OFVQK0EzcHVaTnh0Y044Skh1RlZYSldVaTVUbWRLanU3Rlc5aGxvdUpsVUNp?=
 =?utf-8?B?QXptMVBvV2h3RGZFVXhLRjUrbWF1OEJFWmFaTjhybTFZbUtGVGhxanZERkNv?=
 =?utf-8?B?RTFDRkUzaFNmd1dIQW5UcHJOOTY5YjZTRXFONUt1M3hWcm9iMjhIL1A2Vk95?=
 =?utf-8?B?VWxXYjBQV2ZXNGlNdXNWdWlkaDFsczFwQ2p4WEtueXIxREREbXJUTStwMHJG?=
 =?utf-8?B?ZUxBb2hiQk5kdjdENVUwSzNVNm8zYXliNWtBS0lXRm5MKzlqRFJJdGdnY2Zs?=
 =?utf-8?B?VkpJMkV1bWpaVDRNL2VUVWpoblNGeGE2dm1YT3RPYk5YT2pXaS9ERnQ0UHJY?=
 =?utf-8?B?R1U5eGViOEFweFBXNHJCZkFudVZ5RVAxeDBoUm1mOW55ZVJZTGFReE5neitz?=
 =?utf-8?B?ZWNzNTVLK0JuajRVY1RrOCsyVUFCOEQ1QzMxR2J5cEd1Q0l0eU5TNzR0SUI2?=
 =?utf-8?B?UkFTVXMwbXVMNHQ0ZUowYVVPbkhmWmJ4d0o2V3pkYW51Q2h4K0cxckFZUzBW?=
 =?utf-8?B?SjVVVDNlRW5PZWV4eFozdXB3NmgxSUdjNVRVZzIzaHFVc0tNakRla241TlFh?=
 =?utf-8?B?TjBQOW5YUlQwdlZYYlpkM1B4YWdoZWlUc0pPQkZWZnhkMm9PTUI3VmcrTFh5?=
 =?utf-8?B?QitYSXc2K00vSC90VTlnRm1uY2dTRjQrRmoyR2Q3OHNFQXZ3amxJaGpHRkpD?=
 =?utf-8?B?R1krd1VoT2ZZQnhnbjZ3S1ZIU1ppZGtQQkZEVWk3cmVZOTh1QXpIVTlsOEgw?=
 =?utf-8?B?bXJuWU9vVFVaczh4YjdwU0NqaDcxZTJnWkpTeTkzZXNVdk1WbnNLTXlGQ0xM?=
 =?utf-8?B?bDJWWUNWZHhzZ1MvRjF0a0xnT3ZUY091aTR2eHhsditHQXlJajZXcVNLeVlm?=
 =?utf-8?B?TXNZN29RcnZRYi96eS92Z01UMmpvUTdTNHZjbHIrdS9oQzV1MVE2R05HV2pL?=
 =?utf-8?B?dWdiaW9majBLNlpmQ0hkWDNZdkU3Z2ZMTXp6SlJ0amEzOHpqZHI3ZGFnSWxj?=
 =?utf-8?B?T2JwbVhkZW1WYkpETFJ1UzFGS1c4MWtSRWJwb0NXL2dETVhSd01qQjZEYW1j?=
 =?utf-8?B?YW9hVDdKenFpT0hMbDB1c2lVcHJJa0FiNVdXQ1V1aHBhS2FyVEpQRzkwSUY2?=
 =?utf-8?B?ZUlkdzd5RGdIWUhNcFFqM25vbTRqYUlhZDkyZTR0TG1LYnBWZmpwdWVYM1hQ?=
 =?utf-8?B?Ynk5eVd5ZFVUaVRUcklFc0l2M3NTRjNXTUZxcWEvbklLbmxBREhCcmNwLzBv?=
 =?utf-8?B?VCtDeFNBVFJMZzJIWERmcnlZZjdZRkg1UGJWTUlzbXZ2M2lGUnF0TGtqM3hu?=
 =?utf-8?B?NHl0YzNmTHFUa2lKenh5NmxsV0FsOEdIRnpVTUF5dmJJZ0VINlVQWWZ6NldJ?=
 =?utf-8?Q?AdpZbV/lCzqbGQfxBXDQn1EpS?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79118e4-298a-430c-e73f-08dc56a5ec49
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 01:56:21.6547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG6I+Y0BQNXYRTdlb0AZ9A3skAolchcH1wvDqK2OvcCXcume8NETDfEubXefNtjYIk8kd2KkcJZWaxhz4PwcOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5876
Received-SPF: pass client-ip=40.107.117.93; envelope-from=wafer@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
but not the VIRTIO_RING_F_INDIRECT_DESC feature,
'VirtIONetQueue->rx_vq' will use the merge feature
to store data in multiple 'elems'.
The 'num_buffers' in the virtio header indicates how many elements are merged.
If the value of 'num_buffers' is greater than 1,
all the merged elements will be filled into the descriptor ring.
The 'idx' of the elements should be the value of 'vq->used_idx' plus 'ndescs'.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Wafer <wafer@jaguarmicro.com>

---
Changes in v4:
  - Add Acked-by.

Changes in v3:
  - Add the commit-ID of the introduced problem in commit message.

Changes in v2:
  - Clarify more in commit message.
---
 hw/virtio/virtio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb6b4ccd83..cab5832cac 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
+    /*
+     * For indirect element's 'ndescs' is 1.
+     * For all other elemment's 'ndescs' is the
+     * number of descriptors chained by NEXT (as set in virtqueue_packed_pop).
+     * So When the 'elem' be filled into the descriptor ring,
+     * The 'idx' of this 'elem' shall be
+     * the value of 'vq->used_idx' plus the 'ndescs'.
+     */
+    ndescs += vq->used_elems[0].ndescs;
     for (i = 1; i < count; i++) {
-        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
         ndescs += vq->used_elems[i].ndescs;
     }
     virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
-    ndescs += vq->used_elems[0].ndescs;
 
     vq->inuse -= ndescs;
     vq->used_idx += ndescs;
-- 
2.27.0


