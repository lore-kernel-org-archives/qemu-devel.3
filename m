Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B12606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U28XKRCp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTO-0003Jk-Mc; Fri, 30 Oct 2026 09:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSi-0002YZ-IM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:06 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSe-0005Un-Fv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:03 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4a6fb4040cfso235623fac.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366158; x=1793970958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kflzdU7DETJFjXbwtdoyvY7Xj5HZXyjjC9ZJcSFVySw=;
 b=U28XKRCpQPugeB9F2kybSLcNBms91Iho7Hh0hA7RMED7DOByHfXIT7wNshoa7Bh+uI
 32Dn5d/X5ObsQPgkAbCQmNIEFAJERUjeVnRN2OEvH8D1RHghkehjXXINMLdWXI5b7gK+
 nlqLToRYwYk9vOoGPdxvhY0vI3pc3iqiNRgKmTxnCVPnpCnFr8gNuRRhr4kjStd6nFP+
 qNf5/KvFX6Xgv9QXbfbiM7wwfYwtR5ySkODaVSLtnTApxvR3ed02KrUMJa+O2fNJUvbf
 tBZkAk3FYrRVfon8bixxKpZoveLHF08pyZJhheNXvXIn3lAz9imen73jf1wGMQHXsyM7
 fzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366158; x=1793970958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kflzdU7DETJFjXbwtdoyvY7Xj5HZXyjjC9ZJcSFVySw=;
 b=gxooIUFGKtmey8EIqLvhmstfKw+6yGRJ2fUf1nnVKSy5kW5g5FfQCr9hzQ6ykzFoLs
 u2avcH822VpedbsuZdvC4AHkW5k7hICtWbTilR0SWZ8itOcJsfaNt2ztRwv4ovHa36NW
 C0iCfH3+2n2byA/nh8fOKeiIRfZrh1F/PaLbiSm5qP4WXZpp84SB5l+fQ73OydWTqkAM
 5c9hzyfcdHVFDqLNF7+XjBV4AinLVWSfceTcosYk44ID3PI61buVJH89IzuF5YdYiH+L
 jyhtnxAW5pPC4T/EljrnsRNVmOB30IlNkKuQFF/+w62BzZ9Tn8WQHkH2OJ15KZqHXbtK
 2t4g==
X-Gm-Message-State: AFq9FYKWSi5H3rT752jFw/CsNwpT93l4nFaux2+5WgGQoNGhApngTukt
 Q0NbSmCy7kKM8YgFLw4lTf1ezMIZwSipUGltB1B3/KAeogvl5zqz0EvvmA1cEeCFBF4K25IZb8w
 9t72t
X-Gm-Gg: AYBFou2grLelYBJv5RH1JYgmg5plhhWryAyhHNohdPxdMmuvIMqSNkmES/JBuUof+aD
 O3rbogDz+rhlfwLOPK8Zkdfyjl5d03wQ+H7Fk5wvIp36Yv7Zh1gwAgQ3+edbBzCo1ixpxK8jjgZ
 W1VMx2ocuqB+9mqybff59rxFtS4cf8k5IoBrwZ+qeqmUn9uzuMYdc2R3PUa3Zuqgulhw3vhFhNu
 duQOvG6mbE+U9oQ6gpsLmJ2sMnEteVqrqfoTn7ZSgfNhRZloPzeNpBOrdhVB5WFRiRcVLwIsopu
 0hHjrl1YtQraVDZJ2CTDD+s28zDFOhFiWqaRonS2mBdOUemSZT04SxmvYFaq0NHAMohNVqcR2NN
 t2LSzjQfr7TlULrgaLfc9aJ9inNEI6wopZqPiMp377I/o5SIVG7tBnXlujmFgyIfnXoN0G6/JZY
 Mt65eEDWOAYgRf9IZtlyoQ8L75O7yRQ/Qna+ahwOB7jN1OHM62mPCHcgeehX+JVJRumdjCbsMa1
 bBUhIXSAGtvDbPZcSSLqQ/g68ApV8uxlCc4L3ZoQKs7oJbTux/cOP+VfGWFLENuUtx/IriBOz2w
 Kv4E4THVwGx+AT3NKVt7I5DmMe9hJQ==
X-Received: by 2002:a05:6870:1b16:b0:455:adbc:2154 with SMTP id
 586e51a60fabf-4a906ca95aemr1257070fac.0.1793366157801; 
 Fri, 30 Oct 2026 06:15:57 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:15:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [PULL 02/19] accel/tcg: Fix false awakening of gdb
Date: Fri, 30 Oct 2026 08:15:37 -0500
Message-ID: <20261030131554.41208-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261028072308.839836-1-al.sergeev@syntacore.com>
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
2.53.0


