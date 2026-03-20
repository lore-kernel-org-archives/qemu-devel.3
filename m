Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4525910987A3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cP8-0000Ct-56; Fri, 20 Mar 2026 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cOo-00005K-Af
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cOl-0008Tu-Tw
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so16249175e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022909; x=1774627709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqZSn4rWpHYuunVdESaCorjxnRKhbpVEjXem54koGI8=;
 b=XMdCtTwgAbBytaMlyxQQf3GSwlVFOPBTf6igfBBRHuv5WFhJZPmq9+u/lkWlzd8wkZ
 dlwwIanHQrHfOoOT0reXKbkWwflSuh4BPf2pv1dZftNwZb1lI5o+ItVzts95pDYBVI2A
 h2mN/fPihPFv5gmRxj6o+sJqzxtZpsqpIXy4XKpW+JAniJ4HATN77IMdjPfOwPAJzQ/4
 QyyNSVuZU5dDRKttp2DMplp0AvAVoCYjRPqAZnLy7xJ5uV0tGDlxL4QWlWTm3dczj4BO
 mkNsWsLWgN/wKWsYrU6TIEbjf1ZrvLQ3B9m1A0L0yknaloteL4AjU2A1N2s83snwz//9
 j7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022909; x=1774627709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qqZSn4rWpHYuunVdESaCorjxnRKhbpVEjXem54koGI8=;
 b=K1mv0ann0rGTzfbYk88xB9//+DctcinpEvwGxMZz2JqKSGfsCo6g/Uk/rCLudXsB2Y
 qqrcla4YKHEPKUg2dgFqr0ux89DkpViquuMKJOo2mIM3qERfEtYWhRromLRiEHsM6CwI
 s4DSQnUy1lM9IAlflgffEV2CunUuqVvncbY49ExSQr20wQMuevy6UDRXeoLU94KeEu7j
 zVEEWflkukOlyrfypD22lU6IlUhParue/oqIkVabbmD/d2w7wGTlal+XxZK7Chg+nqVR
 UWtgLAxrEbNBuDyBVC5ryIO5oqh7GDgq2rtumoAa4dNo9WmUQQTti1ME73YLi3nwDUMY
 IWpw==
X-Gm-Message-State: AOJu0YzzFVtqaBOWvvdNTzJbh9Wakjr2/w4qz88lXHi4pd1wzsusCrGz
 JZ5iceYKHfcyF3KDL6AtjQEoL63zcXlb/SXYo5hMiZNEYKfCnJ3yfMxPeIZpXY8wNEKUmzoaUNj
 NowihnLo=
X-Gm-Gg: ATEYQzyZrYAeoiDeI587+5jXDQapTCqo7xC17bYFD4duQpRIbM8SnrknAiaw/KdPU0S
 rrelORClzsbPNeK9rPyvXjMrIEz9CWaNZGfG/uDVKnPyishMToqYJXIOafhKa2wjVXOu74Qki7I
 32t82Ok7ZJ3JQTWBkf8DUAx+mGsWS5J1jLLIFJjS37Sc5BjmcJhb9mGIH4OkEfm1MNtUDwe5069
 WC3EZDLCmnZNTCMv0hgnvFLqQCwi+aoLJpLjwOt0oDITjaG+KXI8VQP35kYlWUyRgVtHzzYgiaS
 +WLngyYwkDGf6RZOMzm4jrSPnoMadDLio6UWI0M/o6jy59XJp3ULJg1jrSif/8h8gWig0IET5lX
 Rw+lXIe/P2vHjRPK03bQYF+wt1B3kiAeIsx1h8WCwtx+SQOy/rdvnSMV6r996rIytHi7VAk67LN
 jia/EigqHWQSElgW/SFOxYYmK0qkIDVbMWZ4xqNDpdS7M/u7+aQKxhnADIs84Eje4cdwfJ1tID
X-Received: by 2002:a05:600c:4705:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-486fee04f94mr52097595e9.19.1774022908812; 
 Fri, 20 Mar 2026 09:08:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd38bsm7612924f8f.10.2026.03.20.09.08.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:08:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 02/10] monitor: Forward-declare the MonitorDef type
Date: Fri, 20 Mar 2026 17:08:02 +0100
Message-ID: <20260320160811.28611-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rather than having core header forced to include "monitor/hmp.h"
to get the MonitorDef type declaration, forward-declare it in
"qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h   | 4 ++--
 include/qemu/typedefs.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index f17a50a3fed..a22cab4ae37 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -17,11 +17,11 @@
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 
-typedef struct MonitorDef {
+struct MonitorDef {
     const char *name;
     int offset;
     int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
-} MonitorDef;
+};
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acea..07f2ae7c9f1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -72,6 +72,7 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
+typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
-- 
2.53.0


