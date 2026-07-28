Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59AEC54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom6b-0004bg-69; Tue, 28 Jul 2026 14:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6X-0004U9-JV; Tue, 28 Jul 2026 14:00:38 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6V-0001Xf-Sw; Tue, 28 Jul 2026 14:00:37 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id A5A59EC03EB;
 Tue, 28 Jul 2026 14:00:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 14:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1785261634; x=1785348034; bh=/TtEQXPk16auxIOaY+Xnq34xyZiCgmr4
 O2lVrdENHxQ=; b=k6Kj+p6PABr8scqutt3/3emTOXo2GaRUwed03aE0hs3vMTW9
 rosc31BKyYMH5zzUlW3+ZhU+yu2MgR49jrLMIJkfo1J2ybgALSIbB+b1pmO3L+Mf
 PMX7xwDXu8lsC3AdCxu/7TRVO2iOFe7uByVODD8Sa7OooALtmzpyn1MxIteUQ0go
 i3x4fW0FFJPtz0ag6qJiQH6qpgeJtCWLmM4sHvo6mjCNB91bszJeHpmG/1HjtrQ5
 tWHF56EKhyYmSLbXm3g2giTsb2Mc01hQHq9inN2iPvmtFyVgcHnZBgSpvLVojLq/
 kFubZ7Vf/4yK3Hy6xm3Cm5PXBcqGYxPFOahR/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785261634; x=
 1785348034; bh=/TtEQXPk16auxIOaY+Xnq34xyZiCgmr4O2lVrdENHxQ=; b=i
 dgDuHkKSPjtmrjjF/qn/fWqTR508nMoo9fvLglMsNRIHk6ze7WE0fzuqeB1IQu3K
 eiluW8yN+4Ob/OjBLY4rXw4OJxETR4LlzSb0JEl+VX0jHqSaWu8UqBqdi2Rv4q+c
 OyzVY9xHbDPP6jPczlpOctwWReYWZ4XRIP1IGiI6Q0XGOR61fDOhb5Gnz5Lh67ny
 DKAN3JgbO3vXBkEyjDZfrVOR8eqqOUYMLJmLBgKGdUcQSB1HLOvkaN+A2Rl5i226
 jjTCfycFuBU0YuToUl2MYOSGn2QbkxfVuC1Up34C/HznGfhJdJo0jC4mICwzhSuB
 yNQdfl8QKqwWKS2HIgU8Q==
X-ME-Sender: <xms:Qu5oaqKbTqJ9eK7Bmgd6HZuJv1qlCvV9SPjijg7mDVkXBYateappKQ>
 <xme:Qu5oakuwV-MfMvRSK_7_a5mi9moPLMT7st8haEQvGuuwGTtrhHQtwkRdN5r3bfM0i
 JYYnZfI7FxCVy_bSF6rN5PLHHDzSXKDYtsRV99H_zyP0S4oFBaHkHw>
X-ME-Received: <xmr:Qu5oauVG-6pwYYJX629clZleBNZOMGqFEPibhJ1HkIrlsxdw7kfTrGpsc434G50OMmjrwxJ3LiwsfCvBKrkEav-nyVozrmmSweb2zxgFvzCp-EyRrTEcDcHUXQ>
X-ME-Proxy-Cause: dmFkZTFObtFZ0S9XoA6JusdJFz/Dpr4TfI7w4J2+u3NKGWTHrUpO2Au3H29XjmsbbVfgUZ
 pOSlja/qDFIsPO5UBlnFGkOafmj8IgESJmVIyVH35db2pxDBz6HGywBEzXLBezr5pyG/1P
 77+Ny2ne1a2rQL4qesFFaK9wZOhV9dLwtFUpCkOha8a25HmNc4WBCeTswNdjTOyOimuriW
 UCBCSOh7U9YqRwTDZstEFU5hrBqQtKTK6KJU+RqZ60azzRBmknC90baCGSIE4dUzb2mIb3
 PFwWjSn2BRjk5PZuPZaRMrxSywOEhIYs/8CzmuBALgv883dhiEzZeCqgMsoQiB5o++l0Og
 uGiboYRqPZbiU2AbcU5HT2E/TNbPKA8nTgZznT/9VKmRlsRG8oUHvhCXdGSHtNYugDZff+
 81fraaxaRoO6wc5nCsdWXWB9Ll9uz0WvqZ+HajM919H4HhiRYm1H0NuVVsdgwht0gVJPz9
 wtDj8rxpYW6TlUvCeKawwbdLKRQHmtRN0IFJ710ctcDNWAjXq+b+nBpOg335Q10eTtrDwS
 icoTCrm1NGA5PyifAOxo8tDEOT6rzudjwa5Kg0uQYg5beSK7SmpQqbGR5WqwYtWsL10iDc
 wkFUboA3/Vp0kJ/dnmnGIb6wB1CJF/Po2HNQOZ5xExhGF9wfYT0KeyMUxJLQ
X-ME-Proxy: <xmx:Qu5oaviiV41AHxbHSLD4F1rFD4Zdb10aYt6fX8WjAKuZyy6I59rCWA>
 <xmx:Qu5oampj27hxSZ_dNxEmZT9umLiyvNR66qoi8rIWRobP4O4LT2PRLA>
 <xmx:Qu5oalFGFHQQZlJ0tT-1UepQ8SIWMDj52C-QCcCXVKl2Hxy3Igm1sQ>
 <xmx:Qu5oar6ygX3yo9GazRNOl1zso7R5s7LUvbkR4_GDcBSoQDYC54wsnA>
 <xmx:Qu5oaoqy9VK42-RPJWDPlJutPZOxnQ0bpYQ5e3jArCyd42_WyVB5OMcC>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:00:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 4/4] hw/nvme: fix unintentional integer overflow in shift
Date: Tue, 28 Jul 2026 20:00:18 +0200
Message-ID: <20260728180018.3574-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728180018.3574-1-its@irrelevant.dk>
References: <20260728180018.3574-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.146; envelope-from=its@irrelevant.dk;
 helo=fout-a3-smtp.messagingengine.com
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

Fix potentially overflowing shift operation.

Cc: qemu-stable@nongnu.org
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Resolves: Coverity CID 1663674
Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index acd10fcc67fa..bd6ad64b2000 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -196,6 +196,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -6625,7 +6626,8 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
         if (!shift && event_type) {
             continue;
         }
-        event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
+        event_mask =
+            deposit64(event_mask, nvme_fdp_evf_shifts[events[i]], 1, 1);
     }
 
     if (enable) {
-- 
2.53.0


