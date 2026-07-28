Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D382C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeKe-00056n-3V; Tue, 28 Jul 2026 05:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woeKc-00054r-1f; Tue, 28 Jul 2026 05:42:38 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woeKa-0007fi-0v; Tue, 28 Jul 2026 05:42:37 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3710614000F1;
 Tue, 28 Jul 2026 05:42:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 05:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1785231754; x=
 1785318154; bh=F10lZgIhS9fM8xfP8fCFp9Akvi+SjrcoC8HeUz69isE=; b=Z
 IH7gm2S9mNcBRIiYUP+gL05Fdz44EUTxHOLpERlqY1MVqeOKrqrtpuiJSvtT/Lf0
 ePnXf/3zxSJVxTt7udREiofG+26xI/JzoFK0ynQu+9ZZ3dYWBqNSDJAoH+p3k076
 RwiTTauboGy8iHFoXd2m+EkcJt07RUAe6RR5tTSJuHw3jk4XW/2SMHSMbN9HLjG+
 lbU5bBy++P8ErZZnOXJlXC7F80dGvhwWwzpxdsDKO63qNHM33yymhFlkrfSxpKQu
 Cgo8p3mC3E6c1ZLbzU+M1r4jWtmDBB8rsIooJiX5Voy0TjW8Fqd/DuQ7lI5rObCz
 g+bBri4QqixIrAFMudTcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1785231754; x=1785318154; bh=F10lZgIhS9fM8xfP8fCFp9Akvi+S
 jrcoC8HeUz69isE=; b=CrRCK8CgbjJTIBc/fDmctWZbWTQuhtmMjpk+CLYlVHz5
 wTphJ9Br26DJ0MiRHoKOjt8hf6OfLalfKObQkPQVG6AeJw5fP9UZiE8nDBLD1Des
 B+BiGahFoejrHidXHu6xtjk0pkHoCifhVia5WapehvU1WVDExLbW6srebyKAGKj2
 z8JZLMpb5uvzbx/+APDSWeSn/SRuDBPm0YrqPYiIJ0B1d9Lwth5BWp/F1uj5wpD0
 PBv7eeJIZ32I9i8VEvW0yzdCzGwTxIEGg1ZDqg2bYwAthXo5cMO+sYUkoPcM/x6C
 zE91jVhiO7MCve4icpLFympkSumMqxkD5K3qUqt1JQ==
X-ME-Sender: <xms:iXloapqMMzI0sDoW36Vq2-bGtM1XnDhHIFe0ao36HIEl6hlhfgTnVQ>
 <xme:iXloauMZ8Qz92mGAoWg0dkqdKBLG81NGGE9IcGPVnC6_vZ8V9dHQoO6-oTrTkufHA
 gp_UZl1UHBH-umSniqri_6OtxmW1NFdHGRLnkG-Q6C7Pr1b-7NkSQ>
X-ME-Received: <xmr:iXloap3MS16zOiqhThXM7DyfacN5st43rta8hcbvG0iFlLnQrjp_yXz3hH1XWG9zBNcCEzNWbOuSRO98pH-lK5Y>
X-ME-Proxy-Cause: dmFkZTEJMsmRmLdoCPg9YBLMBdtJJPidsyL6ff+pCoXh/HhRV2xt3Q8RjIAvfUl+jbuZvK
 81nEpm2pK3/ZxwdKBrxR40nHjCw7hCpaXGUO5kL42eE2RONMV9C2jZONKTs9vPbfk78Vnu
 4KEEmXDN1SMBUBljWQo3KRuNo8wmWKNkGz+SfPGnWUSakykXrMWwM+P86hNKrNhM8jtam+
 phRuRxPz4GicCOm2ZSNPJ4jSqX2EbOiwDVEjL2a1jQm9LY3x8li8fRpk7ICDMYN7FmAgEF
 Zrq5NE7EFkGbHPCUWZ5O4nmK5g91ek6C8+ojaW9X0LtkvoOxMKEEAgcMdj0LQXHmYUuVGg
 6/3nit8lHqCmx0RJysrv0wittbXv5FeXKU+dyx7BPZaB9ll2EBpZpuwUriUGYzEyC+KSnu
 3QKln3GlkSt5WG+0nabM3qZ6PL2z/Xkjz6y3PjTLk5tveL9+OSk4q/V3B5XmgE8Ew0dQW1
 4Ygd/a1ssefmmmueHC78+b7D03Y0haW1BmHrEh2dcrHrzfapMgLR6mEEKfHkdSwnLlyB4+
 CrabRwcmzIUyCmDtdmxWyHkx+ym3ZssG7lgt6F1mtm3VvXPhyUtorP+X4UM16S5lMEIzGh
 gBpV1rBWStIz+iiRUruL1yXkuQ+XJuMoJVKt/kbimfXWyWwhqILjij1lZadw
X-ME-Proxy: <xmx:iXloalDiYxSublzAB3sYEgz5ZtD8WwO0SYILBU7FmKOyq-CIMTd1bg>
 <xmx:iXloauJrG-_hE2oyjiX984ix48_ZbRB02ANHM32Zt4rz1f_y-oMy0A>
 <xmx:iXloammxk_PO9dYEBQZ4rzWIScfK5zuzQmscHkxJwNbT49NDDqZWUA>
 <xmx:iXloavbbGcuq5Va4o6JShnL0nH_Qi_30VNKeFay7x9WA6ClNCnEbOA>
 <xmx:inloaiLM5bEEMa1UMjU92tSr9N6EHgG2VSFOlCHcH-AnipXHJkHlIKpS>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 05:42:32 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 28 Jul 2026 11:42:29 +0200
Subject: [PATCH v2] hw/nvme: fix unintentional integer overflow in shift
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260728-fix-shift-v2-1-6c2355edcfbc@samsung.com>
X-B4-Tracking: v=1; b=H4sIAIR5aGoC/22MQQ7CIBBFr9LMWgwMoVZX3sN00VJoZ1EwTCWah
 ruLXbt8/7+8Hdglcgy3ZofkMjHFUAFPDdhlCLMTNFUGlNjKC3bC01vwQn4TBo0z2qrJtx6q/0y
 unkfr0VdeiLeYPkc6q9/6r5KVUGKcxmtnURrU+s7Dyq8wn21coS+lfAEweCT/pAAAAA==
X-Change-ID: 20260728-fix-shift-525e53c1df6f
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=/Uis/eaQNNFFqZdLAUDjaB8XzmZD/QmRVGS+dsT8hB4=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3BvZVlqM2pmWWptamxvMGVacE5KSGc3Q1dICnRqY29aT05RaCt6akNEVlRn
 LytjSDRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcWFIbUl
 BQW9KRUUzaHJ6RnRUdzNwbzlnSC8zOXRZbHh0OTdlZ0RnbkNCZDZ2MUxNeGhsLzRWZ09WOHMweg
 p6eHdManc3a3IzbjNoS2pNOHZVT2ZrSkhBNVd2d2hRNG9tY0tvZFdHaVZnMGt1eW54RE40eXd2a
 HByK0hDcUwwClpVZ3Y2V1FiaTFqQmZWdnY5d1d0V1JsOTErZFM5T250Z3F0UFUzdm45enAwVldz
 M1AyWUJzT09ZME45ZmJHamYKcWp0Qkc2OHFWSHhnU1drejVWS3NVd0hQTWdWamFuQmREc0hZVG5
 Pd2doditXbis4SC93blNBMjBzWklxeE5jcgpFak9lSEFsUlBLM09vam1NcmhxUXdLZnJ5RFVpam
 l1R3FnWXNKZkdvR1JPQ3R3THg1TTZ1QXQ5akNmOGZ2RFMyCjJFZWtoekFISTU0V0RwT0EwZXpyT
 zQxRk9OTFdSMGZJL3BkcjBuVzFwQ2JpNjNRUnhGOTBycW9rCj1KMjErCi0tLS0tRU5EIFBHUCBN
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
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Resolves: Coverity CID 1663674
Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Changes in v2:
- use deposit64
- Link to v1: https://lore.kernel.org/qemu-devel/20260728-fix-shift-v1-1-bdb98c205233@samsung.com
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..4f1fe2ed493d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6622,7 +6622,8 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
         if (!shift && event_type) {
             continue;
         }
-        event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
+        event_mask =
+            deposit64(event_mask, nvme_fdp_evf_shifts[events[i]], 1, 1);
     }
 
     if (enable) {

---
base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
change-id: 20260728-fix-shift-525e53c1df6f

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


