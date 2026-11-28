Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994D606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ky3ih0Kd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xXBX4-0006y8-C7; Sat, 28 Nov 2026 01:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xXBWy-0006wd-6j
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 01:03:28 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xXBWw-0004x9-3M
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 01:03:27 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b595601695so11642307b3.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 22:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795845804; x=1796450604; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TO1PFy6qUIc+DSPIw27Ov5FlUt4YQoaSWcVzmDZkbxo=;
 b=Ky3ih0KdnRkeXToIhqfdp+X8t9Db1EuWX94ix20fe0Cqsb0RWsFGkc9tzPmYYuDXQU
 QVAw8omQmO5EwDc+Q0pasoHk2cmugiJG/mxSrC3tmvMkALOZyq7OlDENis+ZhzY2u2zb
 pfHiWgDFRyWvkUEENRUqvv2rbG7EarZZMlz6pnulgri3ATnRUhfJJ4lU/fmt1bFmSpws
 Oxiachb944yzAZG6hLsVGrprEZnE9NoL//WSRNRHJiUmYaCva0neNhwwqkSnPyLVN+5X
 qw/8v0Weus9PCN0cWGyNNNDMfUoOv21Pp3+GwgbKR8fSfOtmKKTEqLO265hkGPbVJElX
 yzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795845804; x=1796450604;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TO1PFy6qUIc+DSPIw27Ov5FlUt4YQoaSWcVzmDZkbxo=;
 b=zZVvfkdXdyoqPpAabzyzF5IdajWuBKKg7BWU3ErEGFYy7ZtNPTrC1bogNkSyfsB7rA
 M51fYIe1ljLlqZ4+gSQ3r/EW34hyVDn3Qb15in3KKrMeL4GuSI9Zu/TZc+mxASc+1fr4
 b7VUz/v/tCe/IBQWGDpRZrIUnYkvfzSKgRk5HjXsIt9Xt9QMoB/eO3cDbIBZdAByZ93Y
 STv9H4kxcjr3OZbbaJS6XVDUiAqZ7k8r2lUQyVaPkyVLha9m4RuPohirEEclX5NqVWY+
 JR2uJ3aGuZTmowy6mqDklBn0ftigHgtWwAMAT4pMOsZqvn+4vV2tuowjzL30pNx+QrvF
 mgWQ==
X-Gm-Message-State: APuU4Z8SheyJ8D3+Tse2nhGfzIgwgsqkl4ZKkOdCE0uQLKUlfgYd8Vwh
 S7ot86H158L1o+KkZwd0ghLbYcpNQmDhGcXZhDALROOSytickyKZwnpE
X-Gm-Gg: AZFdTZc85xGii76o6vi8GpBQiqfBphGZMLJ4cH1TqFjmrRJ/wlCQZWJnWJuQohwQztS
 xQmpNcEO0CxHjEpb/69SZLrxDGuUX0cM3FaUgaWAc3EYdeBjp218Qqxjb1QSbY0Za/8y+Aj8Z/G
 B8kQ2LzYIMNuu0phnRIShHfI/ywxdyVfiCLz9bmDB8WtA2zK+JJ0PioopL5LPjFgswt9UhudmX3
 IAQHuNV9gAxg0yAgwxf1JMI70kASlLq/34J9RNw/OGymGg7mL2cBj45CDRZxmkIlLFJscERONlR
 8n+8NWiZY836GBm3kZtz8REwlO0O8iBJ8eoZLjP/GKYoEYNeCzxmapjHOqlC1SChlXvtUl+upN/
 95UU6saAjlSDkM8W2grzOwIsQzb35RRjNj4veMPjxNYry0KO5nRaz+GZvgOrh6Oxoe1cWxQepV8
 hxf13siiL6JSa+NTnja7pZVGoh38/lzPuAlJNcgVa/czkDk0dzmr7Vk5hn1TTBbvLcs6TxYAYlM
 SycY5mcZ6UxJ51jpDvbaQAuIi4s1fuG1bl/kJtexqr9e532lcvXt1msh3gDFzG43ue6KXnphrRB
 GdVDv3qGp8gfprHQxshzw299jnj4P+uPXCeVDyavZU3ljS9mLw==
X-Received: by 2002:a05:690c:b99:b0:8b4:da1a:8f6e with SMTP id
 00721157ae682-8b520436e71mr90883477b3.17.1795845804527; 
 Fri, 27 Nov 2026 22:03:24 -0800 (PST)
Received: from [127.0.1.1] ([2600:1702:6f22:c490:8152:3b89:1fc9:b438])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b56fc6131fsm41507227b3.34.2026.11.27.22.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:03:24 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Sat, 28 Nov 2026 00:03:13 -0600
Subject: [PATCH v4] hw/net: at least one TX queue and RX queue
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-4729-out-of-bounds-rx-interrupt-idx-v4-1-039f71402977@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKBuCmsC/5XOTQ6CMBAF4KuYrh1Df2yLK+9hXGA7hSZCSQsEY
 7i7xRVxhZnVm0y+eW+SMHpM5HJ4k4iTTz50OYjjgZim6moEb3MmrGCSUnoGoVgJYRwgOHiEsbM
 J4gy+GzDGsR/y+QxKW1lWymqhLMlSH9H5+fvlds+58WkI8fV9OtF1+58/UcgjhS6pkmcnzbVuK
 /88mdCS1Z/YxmRin8mgAGOpRjTCcVn+mnxr7uzJ157acqWc4A8stuayLB8/Rpz9fgEAAA==
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795845801; l=3144;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=NypgmdWlSPi5a5s7YXliCWod5uQGH/iSs/SQFt7yTIs=;
 b=JIopch6yHBCUpU48ne90a8BgFLAtHjI9IwMRJ2FLycQdjPvhmb7gPw4uhVRSvmMxyNzsbjdUt
 5kh3LrZ560vCvm02HN1XM9+kHH4Y6KhZl3rEViEEPfMSpjsvWCkm3tI
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=xmphyr@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously, there was no check for a minimum number of queues when
validating a VMXNET3 configuration. Therefore, a migration state with
zero RX queues and zero TX queues would be valid, meaning there are no
interrupt indices to validate.

This change will require at least one RX queue and one TX queue. Although
there's no public specification for the minimum, zero queues just doesn't
make sense. Guest software doesn't tend to program zero queues and other
parts of vmxnet3.c implicitly assume a non-zero number of queues (e.g.,
vmxnet3_indicate_packet():1052).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
---
This is a resolution for issue #4729: 
https://gitlab.com/qemu-project/qemu/-/work_items/4729. The issue is that
a VMXNET3 configuration with 0 RX queues is loaded. When one of these RX
queues is accessed anyway, say, rxq_descr[0], it could have an invalid 
interrupt index that was never validated in the first place.
---
Changes in v4:
- Edited commit message to be more meaningful
- Link to v3: https://lore.kernel.org/qemu-devel/20261125-4729-out-of-bounds-rx-interrupt-idx-v3-1-18d377f43be0@gmail.com

Changes in v3:
- Deleted the v1 commit
- Link to v2: https://lore.kernel.org/qemu-devel/20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com/

Cahnges in v2:
- vmxnet3.c: undid v1
- vmxnet3.c: when validating the queues, not interrupt indexes, check for minimum of one
- Link to v1: https://lore.kernel.org/qemu-devel/20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com

Changes in v1:
- vmxnet3.c: changed the RX queue interrupt index validation for loop to a do-while loop
---
 hw/net/vmxnet3.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 24c551a054..875c998d63 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1382,17 +1382,18 @@ static bool vmxnet3_validate_queues(VMXNET3State *s)
 {
     /*
     * txq_num and rxq_num are total number of queues
-    * configured by guest. These numbers must not
-    * exceed corresponding maximal values.
+    * configured by guest. These numbers must be at
+    * least one and not exceed corresponding maximal
+    * values.
     */
 
-    if (s->txq_num > VMXNET3_DEVICE_MAX_TX_QUEUES) {
+    if (s->txq_num <= 0 || s->txq_num > VMXNET3_DEVICE_MAX_TX_QUEUES) {
         qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad TX queues number: %d\n",
                       s->txq_num);
         return false;
     }
 
-    if (s->rxq_num > VMXNET3_DEVICE_MAX_RX_QUEUES) {
+    if (s->rxq_num <= 0 || s->rxq_num > VMXNET3_DEVICE_MAX_RX_QUEUES) {
         qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad RX queues number: %d\n",
                       s->rxq_num);
         return false;

---
base-commit: 9751c62358073580cbf330a4df22077a7c6a407c
change-id: 20261115-4729-out-of-bounds-rx-interrupt-idx-78d69a7d847d

Best regards,
-- 
Andrew Nguyen <xmphyr@gmail.com>


