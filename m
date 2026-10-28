Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C352606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aBdR6Wv0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLy0V-0005Il-Mf; Wed, 28 Oct 2026 03:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1xLy0U-0005IZ-Je
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:23:34 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1xLy0T-0002BZ-0A
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:23:34 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso368036a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793172211; x=1793777011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bAfYHUCTtC9a1207MszMH7Ii6eU31mCJuYVSET4NeNw=;
 b=aBdR6Wv0+2uPZ8qn0CjcKyMKTbTeQ0dbYLhf7GvZF7kqvJuBllrZuNfX9NKdQVtsPB
 T4xSudzS86g5lv7174uYZYzeQUpDizPgy6sueZkwvYIogI67WxrlKcRc4S3Tettbn5Uj
 Gi//m1hrx2rk3IxPcMDVjaR4DtDPSOZ9BPT117O3gy6o8ClzBVEFcw3ZCzpjDOS7j7U0
 /lPxcv4+nTIy7Fw2hLgIuBl4/saHni+/1JyV+ZRqWF4whjOkwMjWMrW+R4fOND6XkFBL
 7bxO26F6EDs/ENqN5Igf59sXY2OsCOPGH5xW2WdjGl61t+MKzVy7P0FlVYDDJ7i5eXc3
 6mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172211; x=1793777011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bAfYHUCTtC9a1207MszMH7Ii6eU31mCJuYVSET4NeNw=;
 b=YojehLDniGGdcdB7tn0TlcB3uCIN1f77yRBjwG76owx0g3UQXg8ZH4ESKw+OtbjUka
 36dVb5iJOWW7288aeuGkSet3M0w3jFWNG4diz0hFcmMBlGGf5lAemi2Zg/+84/QOOKXd
 dZD84F6uj7ZmVVIN/Zx43Rh8LK02xl96x4NHDWKJK52DoNAqjAFhkzwopgNRRQhP7XsK
 LFbeZILZD/7AWL1JPz+Fk/KzgRfqzIfwYxqYHVnY3szF+d7Vnb1exlm/Y6x2VOyoRVrd
 n/Vcm0CctkXOnoi/b9x0EJxkK3TAMhhHc7RcSceQeloM5T/prkYP9pH+iiEEtnUJfQgC
 RquQ==
X-Gm-Message-State: AFq9FYLl9me6k8ZmQbh1d0eiEg3wyxiDnH6xwCqHPRoRIwHnN7NbyEIH
 qk/QMD1CTS84aklRLGACacxbU6Bu7amFNzDnuBu/iEJMaQaR6CTounfg+kJeTcW4FEI=
X-Gm-Gg: AYBFou2Wyjw8ic51SvJz5yysMrlKSsRwn0hw0oZxlf3pTIccKEm9Rjp0971fxhJSZXS
 cx1waxDbjVNrfuHKFl48l+7jDpa3eCjkO5j1++MDk1o4YCahETcIMPJol3VVCx4HUC9GKpTUgkE
 8KdIe2PoeH8ZYySBWlysHO3OjEZtkvr7pIfCFjezu2QQobAdpbCDD7X+NRtNWrxJ+A8SjyCi1lb
 EnepfFSSB1FNmWGMpOkya29e/5Lqhcq9CRoPxTUjXicvUHB2ut5sv3KhnTSNYIEpc9Mh01cVohj
 MWnB4JsZ/QOCZpBj676feVM4oyMSicOSs2QvcOMKEJpYiHngdD2uFXAXXnPSXJ21uVc3G/eunVu
 rOP3VOyHdenjLQ1+ng7dZe/N1x0EUXnOsecceqJqu7VcGxnFds0jtwhD4JfK5Fx5F5xuRt+ikeR
 nI3Pk7GF7RVnL74cHLKgRbRvbVzK02Adk1NT3ePprokwzSxIe4i/F9myDEGHTjkbzHowEfH1XHz
 6l/2eR78BXHWfvNw/73Ogt9tidQ2qqVX4pq1ZCyn/MyLgCI9JmHpnUECATdHtRV+BZUn6prWwAf
 8R0f0L6N3CzAD92uef0sTnSj76H2SC+3XRs8qxpCtmxZELl88V4UAfI=
X-Received: by 2002:a17:90b:2ccc:b0:3ac:9a5e:9ce7 with SMTP id
 98e67ed59e1d1-3ae5824ffafmr1226677a91.49.1793172210774; 
 Wed, 28 Oct 2026 00:23:30 -0700 (PDT)
Received: from NB-8855.Dlink ([5.144.120.41]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a4ff103sm1723210a91.10.2026.10.28.00.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 00:23:30 -0700 (PDT)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
X-Google-Original-From: Aleksandr Sergeev <al.sergeev@syntacore.com>
To: qemu-devel@nongnu.org
Cc: Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [PATCH] accel/tcg/cpu-exec.c: Fix false awakening of gdb
Date: Wed, 28 Oct 2026 10:23:08 +0300
Message-ID: <20261028072308.839836-1-al.sergeev@syntacore.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=sergeev0xef@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Aleksandr Sergeev <sergeev0xef@gmail.com>

In qemu there is a mechanism to cancel execution of tb.
If `cpu->neg.icount_decr` is <0, translation block
will exit in prolog.
E.g. such may happen when RCU thread kicks out vCPU.

If tb is not executed, we shall not raise EXCP_DEBUG,
because no step actually happened.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4766
Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
---
 accel/tcg/cpu-exec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9ead35418d..4497701486 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -478,16 +478,16 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
                          last_tb->tc.ptr, pc, lookup_symbol(pc));
             }
         }
-    }
-
-    /*
-     * If gdb single-step, and we haven't raised another exception,
-     * raise a debug exception.  Single-step with another exception
-     * is handled in cpu_handle_exception.
-     */
-    if (unlikely(cpu_single_stepping(cpu)) && cpu->exception_index == -1) {
-        cpu->exception_index = EXCP_DEBUG;
-        cpu_loop_exit(cpu);
+    } else {
+        /*
+         * If gdb single-step, and we haven't raised another exception,
+         * raise a debug exception.  Single-step with another exception
+         * is handled in cpu_handle_exception.
+         */
+        if (unlikely(cpu_single_stepping(cpu)) && cpu->exception_index == -1) {
+            cpu->exception_index = EXCP_DEBUG;
+            cpu_loop_exit(cpu);
+        }
     }
 
     return last_tb;
-- 
2.55.0


