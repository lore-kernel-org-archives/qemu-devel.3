Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126D4EF48CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqmHj-0002xk-U5; Fri, 13 Feb 2026 01:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cuichao1753@phytium.com.cn>)
 id 1vqmHh-0002xT-CJ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:04:09 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cuichao1753@phytium.com.cn>) id 1vqmHe-0000uY-HT
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:04:09 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3PprMvo5ptMgZBw--.1467S2;
 Fri, 13 Feb 2026 14:03:56 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHXuvEvo5pWw0bAA--.32545S2;
 Fri, 13 Feb 2026 14:03:48 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mike Rapoport <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 dan.j.williams@intel.com,
 Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
 Gregory Price <gourry@gourry.net>, David Hildenbrand <david@kernel.org>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, qemu-devel@nongnu.org
Subject: [PATCH v4 0/1] Identify the accurate NUMA ID of CFMW
Date: Fri, 13 Feb 2026 14:03:46 +0800
Message-Id: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHXuvEvo5pWw0bAA--.32545S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAFAGmONAkAtAADsp
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
 3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=cuichao1753@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Changes in v4:
- Condensed the impact description in changelog.
- Added Gregory's Reviewed-by tag.
- Added Dan's Reviewed-by tag.
- Added Cc: <stable@vger.kernel.org> tag

Cui Chao (1):
  mm: numa_memblks: Identify the accurate NUMA ID of CFMW

 mm/numa_memblks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.33.0


