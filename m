Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343EEC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofCO-0006aJ-OC; Tue, 28 Jul 2026 06:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wofCM-0006Zw-MD; Tue, 28 Jul 2026 06:38:10 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wofCK-0007nH-Ik; Tue, 28 Jul 2026 06:38:10 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1003014000BA;
 Tue, 28 Jul 2026 06:38:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 06:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1785235086; x=
 1785321486; bh=M7Mv2covBoU0JIe/7oHQC0IX5yHW74bQCd8oTyJplp4=; b=o
 5TM/3iSlrGSxsCBZad836MGWpOoHDkd8E6XPTkIl+Ko/LX+KUfwItqttfINx2AbX
 AWnr2HNmBe8XaKwkGZj6vJt2r5Ihhgbb2SoIBRH2xiP75NXmrAmMTkabbzMXe1rO
 DMbowfVJpKCxC9acHDapZ1X33+uJX1c6EEi+hGbDYy0UvR9v2FrQqhdcv2hDkxm+
 TQMKaBP08Rzx3HMBYaC5+yd0whrIAE7GSMPoy251SpvBVvg3N7KBAvDhZkKSfeeX
 zydvQQm7bp1qtSPvAJWHLcq2H6mgJp6mBEqWDYw7PAGWzEfLs2r9RqYVI5LZcRvU
 C6vACAWogagUgZnujHfdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1785235086; x=1785321486; bh=M7Mv2covBoU0JIe/7oHQC0IX5yHW
 74bQCd8oTyJplp4=; b=f0qYzEn0cNEF//oQOS004+tm2kcuSorORxxKEtjAvpDb
 /3FmwO28YmVYhjpGvk39lN9tP2JrdoLVrK1YG8WWde9qvd5GMAJfoAcr6YqQYBDj
 6S23efs/ZYDbtFhlw+fAuxGXLbSbIekvOywt6r56NhtBxbT73aqJ878Hg5oE7NtW
 oVndxIn0VD7X//1Xot9nSCMZNwOo98PfLahRuchjP3Bk4vcFIiYsdtjig4EmDOVA
 h3rZnys6EOsDGeRNLXlX1kgtsxBoZI69cac7W5KeggUCxyGoV26oznkWUFvQIHyS
 i4l5JgVdNxafSVnmX2fe0tafUWiNnxU6ZwSud0S3/A==
X-ME-Sender: <xms:jIZoavbm3bBhuaschJ2s4Pqp9CFZ93TKY8bKWXOPaiqGH0eHMNLefw>
 <xme:jIZoaqQtqeHl9Ox2j9RUC8lOI943dY31O4_3zl7RmonB1ZDwzW7hKbSKFM56peZM9
 E55bTVeVt3kbG4HywOsQ2rtyNtu48aXcIKR6YncMxzeXU806ryUAw>
X-ME-Received: <xmr:jIZoau_hBC8qkkxRtBly2sPQSnhSAZ3sfGSv4z_UPhFaemuo55hWFr5o65GfyZgbNXxloSvPtsAORRyvPK2-mYo>
X-ME-Proxy-Cause: dmFkZTFWEkuZYqxkI1PM7KajHp9rrAvXDpC89GHVZusGuCZXeRaM0TXFNHvtDsMeJbTPXw
 yhHu1flzyFJkQiEQGMlSPXc9xKfv23HMYkWkEmqd0/n5oyvtkZIDk/4VG67ryd5UuhUdy9
 UkKjvzl8NqNR77Pn2DnMyOFQ5mNLdjY2J2qgSxjqS6KQ4UW+bEZ49qPaQua0EgvYpToVMM
 B2HtbKUkmiyG/o9wZrjgSNPWSwDV66sRlmsHppBu5cwDsIxEWQRrY6LyaIpobe6/k5Lc+S
 RTdvgKp1rZTff7npohhqbMoItzhZStXaXkN/2LoNMxFtWhGvB4MSGrUv+qRTHP2KcUreCK
 gXBbNRy7Wbx+VHpAEAaUctukmL1wl7a++/BIlqouHZEs7v08YZ4Sb2gQLLhwczC4ElRjw0
 61G9QrNKJKA+OAwDxIFk1mVXuy/l0NRvdsdsI0TrawpYe7KKfkWk0c/spzwD43qV/EWl+O
 LS9geQQbuq3dhvK0e8byS5TPE0+u6vZB9Hvl68tnHMKp+/tboCkWAXv+hNwTCYONyZCHGJ
 ckTiFWYH6EVu9vbymukMM7nLTFV1niaxXLfbwoxO36cD31FiueaveYch8Ew+MwqDkDpz+f
 woyFt8VXVf80eFbxqRberac3lJBNHvjrZDJNBr+4rVEpnAL4h63qHTzaL82g
X-ME-Proxy: <xmx:jIZoaqhXlq97R4UbyJ21MItrp_grP6eoYn3CF1wQ72K1Ddk3KGluEQ>
 <xmx:jIZoavZ79RwIcPsWICkRvXgWQQCHaD9y2QQGkePEoFeMnZ4SDsj0ig>
 <xmx:jIZoav8IW6_TBvnSPA4_I-2YHZQ7URdPC_ua5KoPOCKFM-NysRcF4A>
 <xmx:jIZoahOFdifYFFiDFGgbq5aI0Ig11aTO4leau51u93aXTr8I0p955Q>
 <xmx:joZoaiBWMC5X5oKaf5Z3DTmFNv9HYJIchbnOzEdYygfjm6TXCx1SuPD6>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 06:38:02 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 28 Jul 2026 12:37:57 +0200
Subject: [PATCH v2] hw/nvme: fix cross-namespace copy dif buffer overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fix-cross-ns-pract-v2-1-4641b842836f@samsung.com>
X-B4-Tracking: v=1; b=H4sIAISGaGoC/32NQQ7CIBBFr9LM2jF0UKhdeQ/TBUFoWRQapjaah
 ruLPYDL9/P/+zuwy8Ex9M0O2W2BQ4oV6NSAnUwcHYZnZSBBSmjq0Ic32pyYMTIu2dgV1U1erO1
 IXD1BHS7Z1dYhfQyVp8Bryp/jY2t/6V/d1mKLJLxSWikptb+zmfkVx7NNMwyllC+OtcCUtgAAA
 A==
X-Change-ID: 20260728-fix-cross-ns-pract-6934cc8205f2
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Jihe Wang <wangjihe.mail@gmail.com>, boy juju <agx1657748706@gmail.com>, 
 contact <contact@xchglabs.com>, david korczynski <david@adalogics.com>, 
 "Brian Chastain (off_by_one / Curious-Keeper)" <brian@scalingsuccess.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=1nJigRZtBRlzSPtxniqiAgw5y3n0ND5NX5tJEqgohVY=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3BvaG9pOEN6YnVjNks1bXJ3bHBHMm9XZkR1CnJjVTRRMWc4SHU1S3ZhR2dw
 WDVtOG9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcWFJYUl
 BQW9KRUUzaHJ6RnRUdzNwanI4SC8wbksvUTA3RVQ5cGJLcTBJM2hEVGpaZHBDcW5vQ2FTWWJ2MA
 ptdUVIM1ZZS3hYMHh3anNBQkVnVGRxMDNVdDBDclBVVlluQzFPaXVyM3M1bU9iemxUL2dKaVh6N
 kNOajBwOFcvCm1vd2hVOHVpek9xNHFSVnJaQ0dHbnhTRnZqMVpsbmVDeHYzUGFOdXhjUVlVM00w
 UVliQjJvNEFQeXJ1UmNxMUMKc0IrQ3IvKzM0Z3gwME1FNTVqWGoxODdseVpyUURwbWR6N096ZGZ
 GazVaVk9OWDNMMVZmMGFEVitON0ljZmVKbApsM3RpWmFqQktUdnJZK1ZYMS9iTDltelJQdUx6TV
 ByTXBQWFo1VmlBVjVpL0plTklZaFJsQWdKcFBiUlBlcDFwCkw2ZU14TUtYNkV6ZjRLTzlQQXFZb
 0RFVnQ0elRjV3JkYWRLNER2UWRMY0Nkc01rekxuS1hIYk1YCj1YNkplCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

The NVMe specification allows a controller with multiple namespaces to
use different LBA formats per namespace. One implication of this is that
the destination namespace may have a metadata area for PI, but the
source does not. In that case, the controller shall generate the
protection information, but the bounce buffer is erroneously allocated
without space for that, causing a buffer overflow.

Fix the allocation.

Cc: qemu-stable@nongnu.org
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3692
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3841
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3853
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3936
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4031
Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Reported-by: boy juju <agx1657748706@gmail.com>
Reported-by: contact <contact@xchglabs.com>
Reported-by: david korczynski <david@adalogics.com>
Reported-by: Brian Chastain (off_by_one / Curious-Keeper) <brian@scalingsuccess.io>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Changes in v2:
- use MAX instead of the tertiary if
- assert that we don't 
- Link to v1: https://lore.kernel.org/qemu-devel/20260728-fix-cross-ns-pract-v1-1-20f66766337f@samsung.com
---
 hw/nvme/ctrl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..7f28d2e3eb49 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3210,7 +3210,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
     uint64_t slba;
     uint32_t nlb;
-    size_t len;
+    size_t len, blen;
     uint16_t status;
     uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
     uint32_t snsid = dnsid;
@@ -3331,10 +3331,13 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     }
 
     g_free(iocb->bounce);
-    iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
-                              sns->lbasz + sns->lbaf.ms);
+    assert(g_size_checked_mul(&blen, le16_to_cpu(sns->id_ns.mssrl),
+                              sns->lbasz + MAX(sns->lbaf.ms, dns->lbaf.ms)));
+
+    iocb->bounce = g_malloc(blen);
 
     qemu_iovec_reset(&iocb->iov);
+    assert(len <= blen);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
     block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,

---
base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
change-id: 20260728-fix-cross-ns-pract-6934cc8205f2

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


