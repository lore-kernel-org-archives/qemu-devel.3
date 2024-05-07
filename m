Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58959C25B10
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 02:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Ava-00054x-On; Mon, 06 May 2024 22:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1s4AvY-000547-4M
 for qemu-devel@nongnu.org; Mon, 06 May 2024 22:51:36 -0400
Received: from mail1.sfc.wide.ad.jp ([2001:200:0:8803:203:178:142:133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1s4AvV-0006uL-Gm
 for qemu-devel@nongnu.org; Mon, 06 May 2024 22:51:35 -0400
Received: from k8s-worker-01.tail087753.ts.net (unknown
 [IPv6:2400:4051:3e03:2d00:1e98:ecff:fe05:4840])
 (Authenticated sender: mii)
 by mail1.sfc.wide.ad.jp (Postfix) with ESMTPSA id AE923C582E;
 Tue,  7 May 2024 11:51:12 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sfc.wide.ad.jp;
 s=mail1; t=1715050272;
 bh=FyRiK2ZMk30Watqon1bKo/zb21o9rMhAG3P7ShCq1f4=;
 h=From:To:Cc:Subject:Date:From;
 b=BtbeDaFo+7G2XWbt0Gw1cKfLaiMRK3zFTnrKjITOCXkKLLyVeJNuBJDpK1Mjom9/M
 +f91pAXgISBvldMrLnuPK5jsYRhCTl1stke5ZYIrRzpnC/4GsXgeQVGRrzV2I9WDVy
 xhm82CReaWzMemLtRzRBBdsx9uGWvcUcDCD/QwJ2kFphP/rct9K6MRvAe4mhrgSfEH
 hdx2GvASeykbFcYrkM0PGtw+wR2E/HAcGrGlKpVwFf07GbuazYxpvq7bwpztN1dB2Y
 /e1OqOdr8QCaVOoiWT4eBz1z99VrZeyN3j8vEtuEszbtaiutesRweVHilopzT5YR9Z
 kH6zC8uAcFqlg==
From: Masato Imai <mii@sfc.wide.ad.jp>
To: qemu-devel@nongnu.org
Cc: Masato Imai <mii@sfc.wide.ad.jp>
Subject: [PATCH v3 0/1] accel/kvm: Fix segmentation fault
Date: Tue,  7 May 2024 02:50:09 +0000
Message-Id: <20240507025010.1968881-1-mii@sfc.wide.ad.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:200:0:8803:203:178:142:133;
 envelope-from=mii@sfc.wide.ad.jp; helo=mail1.sfc.wide.ad.jp
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes from v2:
- avoid segfault in kvm/accel instead of migration/dirtyrate

v2: https://lore.kernel.org/qemu-devel/20240423091306.754432-1-mii@sfc.wide.ad.jp

Masato Imai (1):
  accel/kvm: Fix segmentation fault

 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


