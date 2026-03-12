Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9837105A596
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0fcv-0001XW-3U; Thu, 12 Mar 2026 08:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0X-00049W-7Y; Thu, 12 Mar 2026 04:03:01 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0U-000305-BY; Thu, 12 Mar 2026 04:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZO
 uxEAVYNxPlsPaUykH2t4HChR6lZP1Nb89sPk0LBk4=; b=I0/k0eiul7Cth70rtu
 vqqggCFbfU+NuZiuLWmb0F5auEN3WGhY8lcAL1rQRS/C0Ms7i1jbPY0w94sxfUsJ
 ssvzRtb/sItXdCElyv9BIC3uImaiE031k3YekomYDU3gP+6tnlbCc+B7znnPlYxA
 9QPhzgrQUDATDpFyzIEhL5z2k=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wBXHlMcc7JpkIIcAg--.55484S2; 
 Thu, 12 Mar 2026 16:02:36 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 0/3] Fixed bugs in pl080
Date: Thu, 12 Mar 2026 16:02:32 +0800
Message-ID: <cover.1773301927.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXHlMcc7JpkIIcAg--.55484S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF43Ww15Kw4fGF4fXFWrZrb_yoWxArXE9a
 48XF92gr1fJFyvkFy5Cr1DGF90gFW8ZryrWF1qqayUGasxArs3XrWvqFWfury8Wa15Kry3
 Xr1qgrn5J3s7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUl1vPUUUUU==
X-Originating-IP: [175.152.130.74]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-R3qKWmycx0J1QAA3K
Received-SPF: pass client-ip=117.135.210.3; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Mar 2026 08:58:55 -0400
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

Hi all,
When I tested pl080 using the existing dmatest tool in Linux, 
I found that pl080 could not output the results correctly.
The main issues involved are inconsistent source and destination bit widths, 
misalignment of LLI, which can lead to incorrect data and even cause qemu crashes.

Tao Ding (3):
  An interrupt is generated after the DMA transfer complete.
  The swidth and dwidth of pl080 are not equal.
  The LLI of pl080 should be aligned with 4 bytes.

 hw/dma/pl080.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)


base-commit: 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455
-- 
2.43.0


