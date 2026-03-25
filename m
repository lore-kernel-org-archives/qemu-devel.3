Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17E1106B534
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vc2-00013L-2A; Wed, 25 Mar 2026 17:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vbw-00010m-VO
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vbu-0001Jn-Jg
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so2787545e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473473; x=1775078273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/OkQfe9cDqmPmNyowe4I82r/OnDAbDAwbC9U/upN5o=;
 b=qyS9NpztlARIm1y3/3vVWd100C4SzXcd1KhVZb79/PEfysrLGgpPgpe/PsBcyZeqN/
 qhjpBy7is/GWn9DOd+gvzrITPeDN/mXii7tGnYjqxCHN4TiiRcfSzO+YGdlmlTEwawMS
 PK3JJ9CDO21I/PckxRc++rK7Nz8DgYvu7HV6BI6OlZIiw8AGyEAEgBZ9WqZP2OeuirZf
 zHvJxsBTz4NUG8tcZ4F6hP8PUYvLm7pNH8D3qh0bONQhdBgLiY8nSgrucd704d3lHveC
 ZCEqrpUF0mAhsAc2Ac4hxZmjnlH5+iWizAl0bvjziUYUVY9Rujlyqou0ZYG3iqEiZgGK
 oasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473473; x=1775078273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x/OkQfe9cDqmPmNyowe4I82r/OnDAbDAwbC9U/upN5o=;
 b=QqTNXMtEzICSwlfgTIogETCzLPtOCgZAyM5HX2egfpvBIDYkRPxv/jsDua262GRXpP
 dYpUt14BxvBJIK5z3C4zHvzQU1DmkcFBA73VXOzlneGaqIX8ksnsGQ9dl9dDVPWHz+No
 4lXEW7MrnPiL03jts9Z3ZzZ7l3G7TcBI5E6Vbhcv9aqePC39dWrMkyj8pfBIf9RtDm1i
 sEsTyeOLkSM1Ryiw+wJh/cS2l9Wdt8D6D7W2hoBheFbB/t14xs5SHPLRnIDDGPYP/qiD
 B6xCtuoNL7R+Ai1l6ET9o1kR/l/H12nHhhehLBgP3oZxzZ48V5c1aLjmQOoFcmp4X9nZ
 eXvg==
X-Gm-Message-State: AOJu0YyH3+SWtWFK5xPL5mdbL6Dnz7wxvCGpKRbiLVNmq2BVFW0DaqCT
 NOu/jouGDjYLnS84vhjlIXT/VOe1BxKZH4cAUwkdYGmeu3yWs6RyjG5KO6dXJJrF7H4JHPxoSdj
 y+X0RSCI=
X-Gm-Gg: ATEYQzyYoC8QxzD2LgKRssNm5nyZXyZkvDPMSYa5u0r/ZzHWuWqUBSsJa5pdGot9SFG
 TaN6ZMu+pVW+ecqBJp7tmEAmkKVVSkO5Am1HeX6IHUcOy6Y9CiflM5oWJTKOnx7AAjUzhuYlq+7
 +v9f42nPZvd9xftQEc5c/kQTPdjA2sjtm13tiSYG2MwiA3KCvANO3obnAmLHYnWSTrwQeks51KI
 j3geecMZgl02bVHz+ts/h6l0k2ZoQlfTjKg4m6tF3Yzrn1zfJA3G6W90ICd/PMGkOkESdNMqMhP
 zjAKFc2VGEKwk1KdcAigA65e/UOEKMFiH6pbXxr5n5eeJTQSgdvPBPYGxVx3tjctIpdJdiqg5Yk
 vnX20Cq5yN1Zz3vWQTnBeN/h8T4n0B5HMM8AnOS5mtt4Hjuk7KnilrMsspVyYu4Hc651BRqgc9W
 YI2c+bM2QWV0DYWxWEGtgbtiHr+E1+OsrQqYnpDenIjDp96Y+f2hQwhWLUDr4PtOkM+t3yicMt
X-Received: by 2002:a05:600c:8b6d:b0:485:3e20:4013 with SMTP id
 5b1f17b1804b1-4871604b905mr81773315e9.28.1774473472853; 
 Wed, 25 Mar 2026 14:17:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487117732a1sm146035575e9.15.2026.03.25.14.17.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:17:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 03/10] migration: Revert "Add
 VMSTATE_UINTTL_2DARRAY()"
Date: Wed, 25 Mar 2026 22:17:21 +0100
Message-ID: <20260325211728.89204-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The VMSTATE_UINTTL_2DARRAY() macro was never used, remove it.

This reverts commit 4597992f624c015ceb51fedb4628b3fdb1e5bbaa.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 1335abe2230..e3d6c06b7d4 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -23,8 +23,6 @@
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
-    VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT64_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint64
@@ -44,8 +42,6 @@
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
-    VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT32_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint32
@@ -55,8 +51,6 @@
     VMSTATE_UINTTL_V(_f, _s, 0)
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
-#define VMSTATE_UINTTL_2DARRAY(_f, _s, _n1, _n2)                      \
-    VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, 0)
 
 
 #endif
-- 
2.53.0


