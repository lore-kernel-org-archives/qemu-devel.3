Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1039EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTdY-0005Bn-85; Fri, 06 Feb 2026 16:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdV-0005BN-10
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:09 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdR-0002YA-Lg
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:08 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4362197d174so1593638f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414304; x=1771019104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OB6TCDcetgdwZSBCYwkRnjQjQnIk5nvCmViaUlBnbc4=;
 b=sl0FxD9HBfXsD/CGhe1XgNlZdAFzoUFHhfbr0kKcTEbQl1W8716ZZ7OX+QjnTPXbhj
 To3mCp+B6dHRYZuesvi5e0Sl/18bIFhPXbhxG5grUing7il9X8REpuCqPcA+XwUiivt/
 vn9KP5ra5w0Ymg1BjVbqTMk4wtMWTmo/VYHrqiAQSHj/mw5dBs7PMInlBuDL6iiluOBP
 kaf/NFkjtFBtux/NX7CxQEDBS1Fc9D4rmsa/ergNc0xTkVoV7AvDboaFJM37Qh9Hload
 WH/T11AMsTRqa6GQsDadHmI31vNmdMiAC4I5YnRhlAgtKvF3uaAdtv8F2ZZNJe2obmgx
 7hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414304; x=1771019104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OB6TCDcetgdwZSBCYwkRnjQjQnIk5nvCmViaUlBnbc4=;
 b=kM0I+1J9k6oqOgXX19gK7PW+M7/wKDtyZKyfQfiN8Diang28lxSx62XJ1uVKBizEim
 WMZjyulLTQW52XbZ2vzQAuVEdydmQkszSkU7PHZxmALX9xULZiej3ytw8TJu79jQI5Cf
 SBLuhZsbmfmQimCwtQp52kUfkVSyh4Mz4KpXVKcut6lL+Ye6DDLeAjLPQ9gHyN9JG2Xw
 g4d+f8xAGXyEN5GXNLPF33lybC5J7/DPvPvCXZogoFu9L6jNECJiHy2CGneTNhzrkq//
 W+EKL57EXbzlWwC3XpIjFyXTO/DKX82m1yL8f1akzw06z0W5/oa41Q2jgcP3DQ/5JM2a
 tVeA==
X-Gm-Message-State: AOJu0YzhK54vFPPDYLBoII8p9XtcvGUnHnDtkP/Ufz4KyfPvK3K8jx/C
 bDsxDn5lMzfb6zHyZki2183kOHWob1flnyHhMUEQEYKKlNFadn6kVtv6lc/tp8PFgo1fpBnCjv/
 ISr5zRsI=
X-Gm-Gg: AZuq6aJCkSem1uLnyNvVgCx6ceFXHnIRdc1+fZVSSbJnP61ircYgXM8oiiDosJ9AQAI
 6moZo+6gxJ94VS0lDuA2uBgJc1VETnXIZ4OUmW1Xmu3PD4mdsaMDBZuGSqetw/vsBV0VJJK+WaA
 OkTv9g6ApjMybVKiB+DYXEUw3RI/W2L38TKijHIiLhqQ3d26gpaXqj9LwwqESg6IBw3X8SADSv3
 Fg9rSW4jylcrVx1pYAxx0YBm9x5sYqYzkDtWdh+hgmemF9vXhWMJvDADJwuU4HmZYQj6DmCVLUI
 QK96KcI5sklxslm89COmUrC81twkRKqDn41UT6BMM96mh2xrs+nU8wraJO6pP3uil/dg8g1EI1y
 IpJ1JWXtN1bFrxgKKtRm2TmKqrNWVZMdINl0B0oMUE3Bl6BEHX7Nutg+mlEUTiU+TndD3oFExvw
 3LIMfby32FibgAIbCmqgpLzyXVenLNOSJjB0ORPXTmvOjE8xhJqJIbrIh5TO9P
X-Received: by 2002:a05:6000:220f:b0:432:5b81:498 with SMTP id
 ffacd0b85a97d-4362923f196mr7285249f8f.23.1770414303658; 
 Fri, 06 Feb 2026 13:45:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629754c62sm7793392f8f.38.2026.02.06.13.45.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 02/30] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
Date: Fri,  6 Feb 2026 22:44:20 +0100
Message-ID: <20260206214448.22008-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

address_space_read/write() is meant for accessing random
amount of memory blobs.  When the access size is known,
use the address_space_ld/st() API which can directly swap
endianness.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260206181953.18683-2-philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 026502a3e40..30f09ec3de4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -108,6 +108,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
                                     uint64_t *entry)
 {
     CPUState *cs = env_cpu(env);
+    MemTxResult ret;
 
     /*
      * According to the PoP, these table addresses are "unpredictably real
@@ -116,13 +117,9 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
      *
      * We treat them as absolute addresses and don't wrap them.
      */
-    if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED,
-                                    entry, sizeof(*entry)) !=
-                 MEMTX_OK)) {
-        return false;
-    }
-    *entry = be64_to_cpu(*entry);
-    return true;
+    *entry = address_space_ldq_be(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED, &ret);
+
+    return ret == MEMTX_OK;
 }
 
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
-- 
2.52.0


