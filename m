Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB544C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuwV-00088A-5C; Mon, 17 Aug 2026 06:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wvuwR-0007to-Uq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:51:44 -0400
Received: from va-2-114.ptr.blmpb.com ([209.127.231.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wvuwM-0005Er-U0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786963887; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3uLQeSFk6SZFMOZyjvnu85cmYkGTNcYuK6EjfVSzj2s=;
 b=a437q+puZ8u4IJK58DF2nJXJiwRvbxNNc9lq7sLtXTKmGHGNARyQjnnbAZvqOZaiQggjs/
 nuTMx1j7SZ8k6zgwPkGbvbG0dYrcopIGyklMU3jz/Wn08CaLC8OSbqmX3vZgA2/z+n6/Kj
 J3YXIJZYNkGkn1ZXOv70RgKXpHQX6yt40mTsH9hYqZ/34z9rwBsAw1TrsqyJU06aj/gDej
 CImbxHqclEsAluJ9HnejDkcHCZMdjIeik5T4kP0EwBKavfWbHPwNprTge84BtgkPQ7wHty
 jGy6ON13F3x+x13o5m5UWEeWcS516rYOLsJBTmWYvF9HTank8yLktgxZJDJ8Cg==
Mime-Version: 1.0
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a82e7ad+a29613+nongnu.org+yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
Subject: [PATCH 0/3] migration/rdma: Misc RDMA migration fixes
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>
Date: Mon, 17 Aug 2026 18:51:14 +0800
Content-Transfer-Encoding: 7bit
To: <qemu-devel@nongnu.org>
Received-SPF: pass client-ip=209.127.231.114;
 envelope-from=yanfei.xu@bytedance.com; helo=va-2-114.ptr.blmpb.com
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

This series fixes three small RDMA migration issues.

Yanfei Xu (3):
  migration/rdma: Fix write-side shutdown
  migration/rdma: Post initial receive before accepting
  migration/rdma: Retry control sends on full queue

 migration/rdma.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

