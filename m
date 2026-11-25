Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D37606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J5W9nhwx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW4je-000208-PX; Tue, 24 Nov 2026 23:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4jT-0001yX-1t
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:35:47 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4jR-0008QI-EM
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:35:46 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-71b30ed75a1so3067737eaf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795581344; x=1796186144; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eFzEePy+h+lPXoQ4fYj6KWi5um0bF8/Scwg8izBKzUc=;
 b=J5W9nhwxVx3CpAlJp/cRh9F0inowTLkcZ850l6qeDbhCG/9oRdIAl7umn6X7/Rreqj
 xYIqcTZkzb+K4ELVsWzrw5c9yFkPqOtux/EoKKI3X9DxJcgZFU4+xOdmipDcRrdcd5Lw
 B3xfYt6bSKyhAs9QAFbRPzVUpyRUR47IQYlN78li16eVUhP3W9nXIHhEFECvb+NLGpWg
 afnkRyplxrEPbRb/jWy/fIjxRJY6qFuKL5mkCn/cXxqXyfJNuUq2WnkZzHyRDfy/lvu0
 zKyadw9Iob2EJxNQExMCzn/tBPmWRrJKpgQBtjPRYEn3KrhX/pNoDJ1xLyzgnQ7MYLpQ
 dBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795581344; x=1796186144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eFzEePy+h+lPXoQ4fYj6KWi5um0bF8/Scwg8izBKzUc=;
 b=nFJvTWKxkqYL1juq2DkfQww8zXm4Fy5WrQpJBcYpDen82xcKWh7fqUto2xtOo5XDM3
 j1YXjT3dHmV6boWTSkE/BjhDARdJ6QGtfT/IQiZ08RD9298ZVd92U/TV6gdMA+ZvbyNK
 bDyRN9f7pn7gmjMHAuc3JRj3PCQIgfSYsvyAXE2ibhgp5w1ZvnL2L6P7NL6v2tZgxvho
 8kGOhk/iVFuxtsDue+8n9Vy6SZHvvNdzTFe9zPXIApO4GtagHegy1EV+EvF7M9yPDnya
 ld/JzYEIJIahgz/LaGWkTqLedVU9N4ZUbJaafFOld3Ej3MKn5D2RF2A+uLtubzXvmJ8q
 shNw==
X-Gm-Message-State: APuU4Z+4Ms12QTbGwmHkrzR8RtwnjFz022wB8f3w/r1QeBCgiLXy1mio
 ohnA0vpx4Zl6Si+y7j+QI2dfe8XV7p4NLaUKfmNJgFAgxKU+dgTCMmHoNdPoJOwa
X-Gm-Gg: AZFdTZfFYEV0gY1Jn5E36WVQloXWgLfZ6O0p0wytq5s7tGY8ZkbMRkqPdUfZnhyWvgx
 AsKbzg7N7m+y2IvL0r7HSDHfnleLwCj74FtHvUBEhjf7kF23Ih1roN7vQzp96BOlccaLIqvtj5M
 J9WRdJGTU0RMOWMyAOo0+oZqHS7xf/Rb7nx6Lsfhi1KZ8xavOmRwy21bqRzYShZ32KqN5O6F6E4
 n/A+7XUXIT/m3lj9x26mfazEQQ1AdJAoqjqPwfk9eTrXZdXyUj4mSh7LYPf/bMrWFlebqdt37SE
 nDxYFvluSwcoU6cVtZ+hHyBJ2B/pT2g/+yV7luDP8skQFhMABWW7/cYAZOj/NZJbjgdPGzVrkgA
 +3Yel3nqYdHHwLJ5hPgagoYlFAARAbKsBPTJGL5LstGzsA2Dpo+S9k7Ii+GmndDhiO86S0QqUyO
 RSv+scpT5cY1jqfqCiME5GurIMOaP8CfopCk0Np1q3+6jfu+Kp8eeRFZXrsr4nsaACIEdS/1nCA
 8HdlXXHSWxci1J7dQoHjv2suiNqcRf5fQHK+1VUGU/ugvbUfFiuDNPvkOWtNB1cJvL+9Kq9EkFi
 fD4UXOKbzTkZeiRLexdo6SGd2InTTjWcGThsQwEjt+Ydwg==
X-Received: by 2002:a05:6820:240b:b0:71b:1715:7ce4 with SMTP id
 006d021491bc7-71b391e78a4mr11885477eaf.12.1795581344289; 
 Tue, 24 Nov 2026 20:35:44 -0800 (PST)
Received: from [127.0.1.1] ([2603:8080:a00:9759:77b:471:20d8:44bf])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380bdff9sm11183745eaf.11.2026.11.24.20.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 20:35:42 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Tue, 24 Nov 2026 22:35:33 -0600
Subject: [PATCH v2 2/2] hw/net: at least one TX queue and RX queue
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-2-cd18eec4f369@gmail.com>
References: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
In-Reply-To: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795581335; l=1915;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=sCpAoVb0oZoeogxGxoIQzreZBQXBN/cueJBi0bjzf8g=;
 b=aidZXIFtSuu2rYerApxyrFWcfHRvpEHNFnOeV7hwS69ICUFwIMOUvDXA99iGPxaGjYwwQ3/rW
 myoFxhqzvX+A0wx+NbL/h/Re3Uw+iSWc2LLu60Pwqfy4BMOow03KYOx
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=xmphyr@gmail.com; helo=mail-oo1-xc2e.google.com
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

Require a VMXNET3 configuration to have at least one TX queue and one RX
queue.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
---
 hw/net/vmxnet3.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 58bb7fb869..875c998d63 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1367,15 +1367,13 @@ static bool vmxnet3_validate_interrupts(VMXNET3State *s)
         }
     }
 
-    i = 0;
-    do {
+    for (i = 0; i < s->rxq_num; i++) {
         int idx = s->rxq_descr[i].intr_idx;
         VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
         if (!vmxnet3_validate_irq_idx("RX", s->msix_used, idx)) {
             return false;
         }
-        i++;
-    } while (i < s->rxq_num);
+    }
 
     return true;
 }
@@ -1384,17 +1382,18 @@ static bool vmxnet3_validate_queues(VMXNET3State *s)
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

-- 
2.43.0


