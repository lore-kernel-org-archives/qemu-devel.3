Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A4C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0M-0004kS-4m; Sat, 27 Jan 2024 23:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0K-0004kI-Pg
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:48 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0J-0004JL-9j
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:48 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-290483f8c7bso1322954a91.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416966; x=1707021766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IsJCYKuWrursPA6kPyaSh6Iig/if/7dsXp1H2oDJMs=;
 b=BaOPrRv980yaVACOJTE4DnWzuGl/0lVF+rWL52lIIC7JNOGVEee0Ckvz8Kl7p5tjxh
 Itd9ZlY6pC3z0bdp63LBFXwa7jIpHQYBjuAoFpiDBq5W28cB099b4Zo/H8AiJdyuzV/x
 Ilq0T/BDp2Eq7w0DvxhfhZe2WFrgNBlXgXG8fos3ZEQJwSjuusqQUG4GqIa5ajjBVKfs
 u2oyhz7iJ8wZw4wSyRBC2hZCvzWzYNNZIsc4VENuaqkqhdDBIZSxtW9hjYHxIPRigt2D
 /MjpzO5m2bgEBzhtgwgfPlcUJ8TQlg2LJq+8j3bgaSrm9aOfAvJnP/etTPx9keNBcnyK
 46wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416966; x=1707021766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IsJCYKuWrursPA6kPyaSh6Iig/if/7dsXp1H2oDJMs=;
 b=qX17bqvGgCKkkKlIbA0TkwsMHItEifTGm64THynG/Lul+ELT+1AL6Ymcj76CcLczhA
 kwwDfw9GrJjMOO7oEF0nIeOec6lo0myeLyNlXSqzZemZVJryibDX++OQ95XfbBiDoJEQ
 0fo5vf31hNxXXAtkJ4InllqLb7vJ7QGxGbb48glPr1IRP3vf61yMJm7Auky54U+0dauc
 lWjs+3qJOLKVhpg+MTillGcOqqyG21N3tWDhYDAU7nCSYAQWRPN+PbsdN5qTkna4l/WP
 zx8Z5QhOM5vc6PyRJePOlcPvEVk7jLXnZJd0PV2ar9bj2cmHJvP2j+fr/PRloQcuWyd2
 0kAQ==
X-Gm-Message-State: AOJu0YzH2gntopdIEUkwUKMohly5kzSC4Alf77DF8v8i+ub29+iQUFuG
 1Z3bSC9XMtC+QSXxeNo5JQgDpk/4jifQ9aasJY5cCN6uKA4pHWmMJFPVN1IN5V+n3hUpJO11TuW
 6KIEsrg==
X-Google-Smtp-Source: AGHT+IGDsF25tuBpf3hP1SjogbVqRI7bd1LE/jHwl5HLdeowmtarHEL465tLSaCdsLT6mrc7Wfwr+w==
X-Received: by 2002:a17:90a:5d07:b0:293:e0bf:39ae with SMTP id
 s7-20020a17090a5d0700b00293e0bf39aemr1659675pji.59.1706416965937; 
 Sat, 27 Jan 2024 20:42:45 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 11/33] include/hw/core: Move do_interrupt in TCGCPUOps
Date: Sun, 28 Jan 2024 14:41:51 +1000
Message-Id: <20240128044213.316480-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Johansson <anjo@rev.ng>

The ifdef out of which it is moved is not quite right: do_interrupt is
only needed for system mode.  Move it to the top of a different ifdef
block, which preserves its position within the structure for that case.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-18-anjo@rev.ng>
[rth: Split from a larger patch and simplified.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 479713a36e..d6fe55d471 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -58,11 +58,6 @@ struct TCGCPUOps {
      * cpu execution loop (hack for x86 user mode).
      */
     void (*fake_user_interrupt)(CPUState *cpu);
-#else
-    /**
-     * @do_interrupt: Callback for interrupt handling.
-     */
-    void (*do_interrupt)(CPUState *cpu);
 #endif /* !CONFIG_USER_ONLY || !TARGET_I386 */
 #ifdef CONFIG_USER_ONLY
     /**
@@ -114,6 +109,8 @@ struct TCGCPUOps {
     void (*record_sigbus)(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra);
 #else
+    /** @do_interrupt: Callback for interrupt handling.  */
+    void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
     /**
-- 
2.34.1


