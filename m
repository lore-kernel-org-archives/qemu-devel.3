Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED21606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vH8IvvGd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTQ-0003VG-32; Fri, 30 Oct 2026 09:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSq-0002ip-8D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:17 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSg-0005Uz-Ia
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:06 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6df5e315bd1so552434eaf.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366159; x=1793970959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qon+B/5TvTR1QAosPUVdPLGJfZbjiJlI+iI5Il3G1+U=;
 b=vH8IvvGd5AHEgI4uXzi+BqGzyACJ6kopHL3SK6WwdExOHtCHnLbUOBz6VVDeaK+LUy
 bpvnOsfELzm7osqoD2J5LBmMSk2hoP7fqPPZTRlo8iU0ZOPfIY2KEsnncZNx5u6uVYB1
 hWVnaPYBIcRQ3VepF4NmJUvVB0KKGR0UsdqC/S5YhpPNvPzmPJo3j/LVs21I8SGKiW/h
 MsecowK+LFmKd6PC3hehvIQj9d92z4NrxPWZHJu1du3ofnf9LCEOphBsURV0JBlObcf+
 qyDEmWhTc4DgPJuyWT9hhga8TUP8099r5BOwDLWYGDh+vDM+I+DU3GpILTTVNSilPfFM
 ykgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366159; x=1793970959;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qon+B/5TvTR1QAosPUVdPLGJfZbjiJlI+iI5Il3G1+U=;
 b=bbK5wMj5mn0LqbnmhzRnyTpHHcHLw7oZdTznzSWKQpvIF9DujRLj4yaP7jAlnz2jPt
 a06HZgEHeLknnMU8IKI0yV0AcpA22vhVuUaLxf0tvQY8Wu/O+E2vkkfFlOTONzNbZEFZ
 /vCk2MM393j9YPjNvyboFh/Y0dueWQw5xlCgWsYSHqP3fbh+0Tp4VL6Bjm9JAJPJK7n6
 I3OEMFAxb0Ka+CjkJMlLw/n93fjAKZftDp6hxLiAajBu3B0vwCT8zLCRhqpOTH2hr2hy
 jCkB/TEPA8HlDKkEX3tpedXAex67rl2wc4tHOmRfihHwV2igRe5pFdIcUpz0eGGzu/r7
 1p6w==
X-Gm-Message-State: AFq9FYIBmDSkFllAVi7e4YJHuv1/6h5zjRU+et9g7DAuc48RoO8NhgoG
 82rfbCRghPSpzUElIrkc9LjEjazds4KVOXRT4rMso+AW+NDFPBpgpRCha/wfTeHUtqaJ2jdq9q0
 LaaVs
X-Gm-Gg: AYBFou2Fb8fLN97gInox111VXAXZB5Am+D8bkONWMzHXeyihtZSklIO8mBuEZKVIzoR
 NZ9u0lazepuNBKAzGtbV+4MRrDTeqvhkSs9vIjCXwZIdx+gYZUUw3DLUTBBfyqNpJYVg5RZTJtU
 C7ftV0w3d0ZQ/6P0x9xQBf26o/g06qi4rA0ZWFxXeAn/34zGHt7UVp7JkH0PEbIcEAHXoj/fGV1
 2XpDntd7OQOSd0s8PjeXCAfMFwv1AkDhm1VxIiJCy3h0u1gN8Q5LbohCpxvKTTh0GR6/BLsRHSx
 gdZOLe2Mn3SAvnF6CAeqqYaY6wEUFQaVRMSjPAaj5/T/dv5lY/bvraGUStqlxLtr2gPHNGh9ErI
 MRpSVCCLVNF8RysuuYafn0dbZwgUncPBa5eoN4oD65ziCmQiegtT/jLP4TZb/4ToACcccw1zc3i
 o1dV7k71fjwgxNwLTdZmSCTkE5r3RIjAS9fmQ3InwV1CSpYI8tGtbi9BeRh5JfG9fFiL6fwxCBa
 qdjWuQgjPFGIHY/701S5cvT98rVMnl5qQglI4zcpmROAgf0MH/MQ4VppTvgbLv6DNsgaUiDCfjG
 kLUzLegS4fBU6rnT+k1OzSHtjvAMNlbGFGNZbiqFoXtstLdgOV8=
X-Received: by 2002:a05:6820:16ac:b0:706:5b0b:4e8e with SMTP id
 006d021491bc7-714f252f907mr1454240eaf.55.1793366159055; 
 Fri, 30 Oct 2026 06:15:59 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:15:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stian Halseth <stian@itx.no>, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/19] accel/tcg: Do not flush and retry in place in tb_gen_code
Date: Fri, 30 Oct 2026 08:15:38 -0500
Message-ID: <20261030131554.41208-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

When the code buffer is full in a serial context, tb_gen_code() flushes
it and retries in place. cpu_exec_loop() then chains its last_tb, now
freed, into the new TB. When that TB is invalidated, tb_jmp_unlink()
follows the stale entry and qemu crashes inside its SIGSEGV handler.

Always queue the flush and leave through cpu_loop_exit(), as before
commit ebf7a5d294a3. This also brings back the cleanup in
cpu_loop_exit() and cpu_exec_longjmp_cleanup() that the retry skipped.

Since commit 25e5c6a320db ("accel/tcg: Allow cross-page goto_tb
chaining in user-only builds"), user-only builds hit this easily,
e.g. qemu-sparc64 -tb-size 1 on a program writing next to its PLT.

Cc: qemu-stable@nongnu.org
Fixes: ebf7a5d294a3 ("accel/tcg: Improve buffer overflow in tb_gen_code")
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 328d96aba3..ea8257935e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -288,12 +288,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     assert_no_pages_locked();
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
-        /* flush must be done */
-        if (cpu_in_serial_context(cpu)) {
-            trace_tb_gen_code_buffer_overflow("tcg_tb_alloc");
-            tb_flush__exclusive_or_serial();
-            goto buffer_overflow;
-        }
+        /*
+         * Flush must be done.  Always exit the cpu loop so that the
+         * last_tb linkage within the inner cpu loop does not apply.
+         */
+        trace_tb_gen_code_buffer_overflow("tcg_tb_alloc");
         queue_tb_flush(cpu);
         mmap_unlock();
         /* Make the execution loop process the flush as soon as possible.  */
-- 
2.53.0


