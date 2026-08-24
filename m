Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66922C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZB-0001ve-70; Mon, 24 Aug 2026 01:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYT-0001N6-Nm
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:09 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYS-0001sI-2t
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso2515982a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550547; x=1788155347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1lmUdEov6FqZsd0VDIKqfsQZY33RKDRt1qK6/MBemXQ=;
 b=i4AKhD0p0Q07MaSq8bKFBkYiXfzCnltX96eP2ZcbES419quQTpNngnWcZq8z2HFMi2
 14LO+QyJ2HNgQq+s11vuLd3pqKD+JT3wFAUI65v21LFTflPFJ4f48ayYDpBrq0SoloWq
 bUr+2TJ5CITvO/K8XrIl7ryS23Lu8dWBKvRb5OlyuuAS9Y+A1yhUq6q8zQbvOSVrTE9H
 WQqVUlUk2ekxPi/I7wAaQGROlX9IBPTtlmRHqFTYVaSv9TJfHowgYW4eB7BgadZw4xeX
 5Q/rq0vUSxDnz2TtdxbYIfqAe9YzKt1wBh1dXDyBl+UVXRkm/Reueag7wMhneAtdie6H
 d0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550547; x=1788155347;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1lmUdEov6FqZsd0VDIKqfsQZY33RKDRt1qK6/MBemXQ=;
 b=XNp4XmVKgBaw0IykugxmCEWabYCp/Bc8Quvua7xGd/T0yIx+FZHQfdzkp8QOJkZxMj
 oRiDgljQb0PpXgMm3VfZPHpT+kW+av4u58ZY5NFgZ3U1uH/Zl13KcOPW613hQe8ZDNdf
 fRRiqGdDhNqxY2NlFdb/T/0jDd3th/HUFwsRxdVHa9JYjNGtk0/JJYLDM7+MoFwN7M8j
 9T71Nj4TyJf6qgoZijfKUk9OsTYyD6zCLRMvP6He/OCNAQ/k0k8enOk3UcoW8Q0dcJm3
 J56XYMcRrUO0iEdipnfKA+ev4AigZ3QgWdrFpD7Tt00mrvN5TjZyQMu1EQeHGj5L9Rig
 bBBg==
X-Gm-Message-State: AFuF++lONPZJfA9lfOw+/MVaoiZ60DMHdMK8Er4vfOf0vE7GUi6ArVpm
 c1AW+YbHv5ANuZpfa6+UlEvasg2O9IOzHfz6dP7Xflp090gcuGElxJbyo7sIOw==
X-Gm-Gg: AR+sD10ycBWkjsSTknZsCveiu//8K2fnipBgRZBsMEUmAL6L1H1m9sRq23xM4UAPvVt
 9PEfjicxz+d7mXGPFzG4T/e8HpbJfv6+PduhTLythGLPQnbV9lhN1EQLMKNn4vhBUpft+9NGpt/
 4VeToWuxPCcseCdFZwlecbpPt+9kYGhxJcFnQWzCdgLM/AA5Nctxc+mdNSEEGhU1Qe6VtZDaQim
 fHKUIaHal6w56DBQoEeX3J32gNLufjIOPlOUmcMVjHxtevZmvVfw02nMPhz9zbtGBhFT8mtm53k
 8hpiGTe7YOhYaX6iCLUXitmybRPY6fBua4UdVgKFnf5tAeMYd5XS0zkoeK4JTsDfSVrkBQq8+R4
 BZKUvhyJ8sDb05ATGXTwThgRljLynAOJMDSZuYPoDn8m6XS8suuMeO53yMFvLrhVSSdejYwUBMY
 ww5N+ImEHfdvAaMDYovoxM2YbK2LlW0tJY8LhGaK2+DGAG75IZSMP9mpl/eFUSzjiSqobJfw6ff
 uttQQ==
X-Received: by 2002:a17:90b:5823:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-395c4bde19amr22147475a91.2.1787550546854; 
 Sun, 23 Aug 2026 22:49:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zeng Chi <zengchi@kylinos.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 15/96] target/riscv: Fix memory leak in
 riscv_trigger_unrealize()
Date: Mon, 24 Aug 2026 15:46:45 +1000
Message-ID: <20260824054806.2790041-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Zeng Chi <zengchi@kylinos.cn>

In riscv_trigger_unrealize(), the per-trigger QEMUTimer objects are
created in riscv_trigger_realize() using timer_new_ns().  However,
unrealize only calls timer_del() to cancel them, but never frees the
timer objects themselves. This results in a memory leak every time a
CPU instance is unrealized (e.g., during hot-unplug or machine teardown).

Fix it by replacing timer_del() with timer_free(), which internally
cancels the timer and frees its memory.  The separate timer_del() call
is no longer needed.

Fixes: 820552a92e32 ("target/riscv: dynamic alloc of debug trigger arrays")
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260724063927.3360599-1-zeng_chi911@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c0fe70101..5ab29f6945 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1080,7 +1080,7 @@ void riscv_trigger_unrealize(CPURISCVState *env)
     g_free(env->cpu_watchpoint);
 
     for (int i = 0; i < env->num_triggers; i++) {
-        timer_del(env->itrigger_timer[i]);
+        timer_free(env->itrigger_timer[i]);
     }
     g_free(env->itrigger_timer);
 }
-- 
2.54.0


