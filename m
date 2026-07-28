Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF0C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woe55-00056e-Mw; Tue, 28 Jul 2026 05:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woe51-000566-Ur; Tue, 28 Jul 2026 05:26:34 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woe50-0004Ww-GI; Tue, 28 Jul 2026 05:26:31 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BC3FB14000F7;
 Tue, 28 Jul 2026 05:26:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 05:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1785230788; x=
 1785317188; bh=Nbmm/Encqm5GEawJJd484DkzqLKHQCmfWGQazfEZdx0=; b=m
 /eqzRua5y+x0V50hIcYIAu/HI2zQOYBND8QV8lZ7f7gHIRdNjGYfLhEsN9pEimZz
 sd3QGGU5IlkwDG9H66CSqTfRYwgGs1kpPJLwJCoLsm9TG+eLJyEx2AL3/zAc/8Df
 dRolyNDcMsjs5XAlusV7KXd+vh7rd5MXkBsfwDbRWgiAjPE4NeSqmmZXzQz6b7Kc
 W3PLlptjPiAOs3uJJl9XgTvZ4xS8qxWL4ExW7DufnIBFnoimawbIyOCElok+4s9B
 kujnuYngNPdhuywxxKGyhcwda/eqKztilPsx4xKAYz4ObGKRRQY6HmD7WZ/ZGn4I
 y1+8hiBCfJrtGycG4DM7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1785230788; x=1785317188; bh=Nbmm/Encqm5GEawJJd484DkzqLKH
 QCmfWGQazfEZdx0=; b=nUCXa8j53SIRA5DvY7TYW+ILSHixvSmCx5WLgaFvx1Cb
 6rOR0BzE7O9v+DLA9FpT6K6XsEOR9b0e0P+lunvEk7C/EcI/zjYvhjrInJaHqwFc
 kQpnZjRcXRmJAHXkIFVJ5bEhXtQ2xejtq2Q1aAss3Rb0ucc8X+ibuj/XGqTMvhz3
 R3k2HQrSDwpwT8C0m6NYqY8R3+f+7pn4jUmwNHT/XKP79PvzpMNyQVRrOVfK4dZ3
 zNYJ8mfJfJRuizM7LmsjB0XhU/8fwODvtCVPA6V6/zQNgl96Ji32U4bxIJdoSNuA
 HqHR7et24FNw3La5E4nHuCzfG+jMUxbWN3y4XXjHiw==
X-ME-Sender: <xms:xHVoaptgTi-cr2q5Oqvgqj3VHOH4KYiBmPkDh6Evmb83n7aEsQowzQ>
 <xme:xHVoasjDW1p6Go5IfIYt8dgIvSfOW-TLVFNxKV54xYVksmxT6sCMAqllaCUCp03n2
 44zhwVcISeY3wJX58NoA0KfAS1ZBkLYGRUb2D55P_I2nv3JR6JdoA>
X-ME-Received: <xmr:xHVoaspnMkvk8CHYe_V7qM5gKvlFW5bcec7lPVISJLZ9Krw6EN4XIJNxKNbXr8PlWgAyPFlwZesuyUer2uFIsNM>
X-ME-Proxy-Cause: dmFkZTGaISeYzXXWrljbSALThcs7la4SIPsXbB+kjH8zZBNSSbJ36T+nWJYzQnntH/dZqq
 cumFnqV0v1JBZaIyQrn23Ypbxn9Sk8/VfZtFG0xIQA5AHxID7i0j9b70gVfUIodB/wcSdw
 kooXygOi3LkkGct2BW1ouapefkn3NwiCIexyhAAV7VXaZ7rSlF42dztO3cuD7Swz/0btEO
 HdFoUPf2OALeJwG6jLdm0QjMio6q6OiZgakhf44HGPVLtr3ParVbYNTE7AxCOjzEWkxVvj
 QNHOGnPLvRZgaStNTEz+M8ax6tnnqHXL17sQELq8fjSPbMsQ0lxM3LzP7hTDGG9xjH8ned
 BKt08l2Ms5/UfjFC1nJltEFFCeEgrf1zI+RRsd0b+pLPm6gdx4orM6f0WUvm8BH9Qry/s9
 brd/3MSgey/QkEMjuAtHhUKczNI3zeusZOvx7FAirGeVJE9xQxKHMpbMwsDrjjTwAbS9bQ
 5ikYIjVK0yOOwfWRy8Ud+FPhnrrzL3cawTrfPFymIxweH6I3+oRD2cRFZxe0mheyey5xcE
 TEaTYqNHjuVPEruepLI6XJvpVFdD1u6xgI9XMSYhX1O2Ozt5OQJ9+sVka8UaInKaGioJSJ
 0D74+dh6kFSy/8/UNcquELbHBL+R2jHDhycvbfCMXqSCUqig8tPIG48hab0A
X-ME-Proxy: <xmx:xHVoahuoVrZRTTPOU-9YNMsjAJ3DC8-sUJ-QuFUmx09fLNCr-JlOPw>
 <xmx:xHVoanaTXnSpyt51diwi2WjZH2GUhezKZQvKRv6YGRQUQTbJVDNBJw>
 <xmx:xHVoagbrcT6N1aO9j1rzp1fwEwDKsh5jfT822ZltNP54yHDfSuQwAg>
 <xmx:xHVoagkEb_XY0uvKF2VdX6yWu1pU77_edKSQAxs045MpnM4tqxw-Nw>
 <xmx:xHVoai1iDe8_HKMHsZEY8tXMQNuCRv79uMXvkWay2U4lAFi-h5MBSJ7E>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 05:26:26 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 28 Jul 2026 11:26:22 +0200
Subject: [PATCH] hw/nvme: fix unintentional integer overflow in shift
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fix-shift-v1-1-bdb98c205233@samsung.com>
X-B4-Tracking: v=1; b=H4sIAL11aGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyML3bTMCt3ijMy0El1TI9NUU+Nkw5Q0szQloPqColSgJNis6NjaWgD
 yEwr3WwAAAA==
X-Change-ID: 20260728-fix-shift-525e53c1df6f
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=T44NyLLBrZPKAKT4U0tCk1BkmGLRCwuCsaYb/2nd3xY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3BvZGNMWmlaalJJS0cxVlIzZmVnTGxmd0wrCnBBQk5mQlhNTjNjOXlEMHk5
 cWVuYW9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcWFIWEN
 BQW9KRUUzaHJ6RnRUdzNwTStJSUFNQTl4Ym80WUJGeWFWVmQ1elFVWnA1dWZQWVdDZnBQejQrZg
 oxcExWSHE0Nmppa2lhODJaRy8rRHNURi95d0VGU2o0SWtoWE13Nmt6aEZqdjY5ajZiOWpMNnIwT
 0prZkVncVVqClVOdXAxNXpVdVlEWGN2THlWcDIzK0NCKzlYWTdSM3BJQ0RGbzg1dTh5dHpVVWVR
 WjdPaEdBenhuQW9FTVJtMWMKRmZLUUVtMlBBcUlOYzJFUGwrVmNpZnN4OXBrWCsrR0hjQkNhUUx
 DM0owQWJ4RVRjUENNN1AxaTFldGpjS1htNAppckM0UDk0eEl0VjZlYnZ0cEdNV0E3ckF0c0F6Tz
 k4bXhrSmxHT3Z5RFN5VFU2dWY0TTUxZi8zb1RQNGFwbENLCi9qQ2svSGNrTi92YWl4blVkME03S
 DU0VFhlRmxrV3pJSHF6T0ZHcmRtb1BTVXN6MGFYczVFNnVBCj0vMkZzCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-a4-smtp.messagingengine.com
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
Resolves: Coverity CID 1663674
Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..40f22fdc40bd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6622,7 +6622,7 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
         if (!shift && event_type) {
             continue;
         }
-        event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
+        event_mask |= (1ULL << nvme_fdp_evf_shifts[events[i]]);
     }
 
     if (enable) {

---
base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
change-id: 20260728-fix-shift-525e53c1df6f

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


