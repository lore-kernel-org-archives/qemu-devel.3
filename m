Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93A0D625F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqTq-0003Em-Bf; Thu, 22 Jan 2026 03:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTo-00039H-Nk
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:52 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTn-0006JC-83
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:52 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so481007f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072149; x=1769676949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TuJu/lqEa4HSpg8bNNxgbevMWPfOzV/4hLPmHRwlUV8=;
 b=R03WgIbNGZUNhwDSHd0ha13kp9B6xDVnCFzMDR2rGWHLWuX25VVf5IcbfYZU/fbCMT
 shmyyfDuO0YlpqIhivj6CItTUH0WrQFqSh+VTMvjPu1EvSyz6nvv/U+r9aS7ZU/nSu8B
 3PvJXVJIC3JLlpsArBx1nyBBNTn2ptH3hDGdognVxN4hwBZezaP7vGBU4RAe06n/X8Ok
 fb8K4imcqZDii8NEGp1u1/t7Ggebtx7p+tyqQFwLRmjxCrbN5ZtuPRy63uS7MtbzTXVi
 Qn8a5viTIp0yZFKChBIuPfmjUB8svSmgCc4m8W4dE/zsuCWJD3tsxGgzk0aljqDF6mSf
 1BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072149; x=1769676949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TuJu/lqEa4HSpg8bNNxgbevMWPfOzV/4hLPmHRwlUV8=;
 b=mhNecn0D138lOOkDDt2JDgPOBsVDDvYiHWnI02apAxEgEMFOqgUm1Dw78lzuieNQLw
 D9JOa0c/bzb1t82J9c0F5u1fNbakQ+o9J19hpxNWlJ37A05eL1wZj0fcvWU+4hagZjf3
 rW+tmcjj3dvSTXW2AI0finhKYtVj2OdzXXyeRXfDlyXDegiOKZ3tbvJTE7j4G8CEGXsq
 2AUw5Sup9zLvDYG+6jT+FspDN1GoEu4M2xCpUiBRAx9+jeSP6mcSjNvYptF6Hz+D3IrK
 gfZYx0SHfPcFgPClSumQlzA7dO3ugRjMzX39GQOeynBEsOfxMemolJ+ypjNagaLNwW2A
 Rlbg==
X-Gm-Message-State: AOJu0YxacFHPbanYwWgfxFCMeLHF3mk3nbcJgisyPOzBvtE2QeRupHix
 ve/+AvPkaN9AmFTbtA3pMsoPF09wcywFnPSKDYZB0q9V1HRceGgr0y1xeru63lF7JCVxyrOtuaK
 NXImf9lY=
X-Gm-Gg: AZuq6aJDcA30I7zEC+LOfqNfSRphsYcz/o+tzjH33sGcAhM2tEfJE1YnjW6WkeaaNXZ
 G6Dw7vjQbSlWmznnyfkk8p1GcTb/wItlLKZERMOmzpDoyAptt02qtT0B8EGLqYIHGMHhs6fqNdx
 plz6t4lQHO/M6utsNEJiIGzqAg0cDc895xbKGOBehMLhfc+RNPxyBWI1gV030RVMwRZ7X1R5KFm
 n7NCMH4tpUqrYoNPWdFZmwM94uVtwtJGQKbpDsHBweJmxx48zHrWEvQv8PPnTImAFgA2tWzGrOn
 WDQLMO00S4o9OqqCKHr0fljW/mA40YMCuuJV8KVdKTdgeFnPYqyO5Z0hqydhnlxfYx/h5/q6JQ+
 kVF8EiNFWHjwHww7aIXaOvq1Q/4iO8fioQy/o3S3pgYQQSR2e9CoDOvO+DuMLEwAKQiVK4FwZVE
 ADXejmj1tNJFwUCyXgjxaDDcV9+7LcQdE1hkNbotXHo5NZjvn7FnDouXxjjp7p
X-Received: by 2002:a05:6000:2dc5:b0:435:8f1b:bb28 with SMTP id
 ffacd0b85a97d-4358fe9d0fcmr11814655f8f.0.1769072148935; 
 Thu, 22 Jan 2026 00:55:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597ae9f37sm13662525f8f.8.2026.01.22.00.55.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/31] dump: Abort in create_win_dump() on non-x86 guests
Date: Thu, 22 Jan 2026 09:52:49 +0100
Message-ID: <20260122085255.95035-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

qmp_dump_guest_memory() checks win_dump_available()
before calling create_win_dump(). On non-x86 targets
calling it would be a programming error, so abort.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260121215622.92966-2-philmd@linaro.org>
---
 dump/win_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index 3162e8bd487..6e07913dfb4 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -489,7 +489,7 @@ bool win_dump_available(Error **errp)
 
 void create_win_dump(DumpState *s, Error **errp)
 {
-    win_dump_available(errp);
+    g_assert_not_reached();
 }
 
 #endif
-- 
2.52.0


