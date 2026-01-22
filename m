Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD11D6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1qG-00053u-6W; Thu, 22 Jan 2026 16:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1om-0003b0-3v
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:19 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1ok-0005L8-Jl
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:15 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so11260385e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115733; x=1769720533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ODkndRwX/R09xiWds3ROCMF/P61RrewKW7dQu09WfU=;
 b=QrbgSKyD2Cs62osWaoXa2rjgBytip0xUV/7Nwqfn3T9iNDMYAIUjKOe3pPbxgAS0fO
 7e0QHOQ9X1+2AASyQB87z3vmffLZQW4c7QT/LD+iYEfrMHEFxxrsVA+Sb1KFVR4LhoKT
 TXn29OCZ5F4uUwmoWxcMW/llkyp0uvIvVcfAyN01yPzsLTbAeRZPYqVPpK1p55+pfHYT
 E3CgQz+lc1C0LGz8RD+PIOZKc1dCoQL3xBQIE0E1kSQSBHlCdtdhVjIZiKMTGF1QP7OR
 0/FVMB+fklLnsxWNNtOuKzBZLmJbDOuZyw4QI51nCdS72hAIBrr+UaHZjfpaAyKiOK46
 3R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115733; x=1769720533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ODkndRwX/R09xiWds3ROCMF/P61RrewKW7dQu09WfU=;
 b=wMyWJPfZUPahOdh55sGAZ5lnGDw04e/8y2cH4kSV34CltHO3HQOR66jSmVZCK2VIru
 Cdy/nFJhoYe8n2Ac6LfD9d4jKqVXe68ccz1fdxcd6xBF1MUmxI7GY8IM7afOlQkXSsB9
 8ydrJFhnv51CkRwCJVCk+5zvP/mn5h/oMq9B9ZmzodCfB4/cR9uQX4af4Hb1c8Sm0PNa
 w7nzbVjoJDrO7odFc89tU9EKePY6dZHj6bUbpEpHv7CvdOeJQ60IL5+GGNuZqwsRP8QE
 To6pC3gGhYTMa5XkrYvS1f0FnFoooCY8rU8gJFLBwO2ck5bEq3wEhplkxRpeDuNGhV9E
 nJ9g==
X-Gm-Message-State: AOJu0Yxmv+CWfcfpYwG570+2n2aJkMTMuwYOCd6BcybtdoC87V/N3zQV
 6zY/ahYOcnrrX+p4QaIBbJq+gWtU67XHC257YB5VfWOADSbaG+AW9N5twNUxCc88kHJLwFp/43f
 5Itos/TI=
X-Gm-Gg: AZuq6aJZbG+fct+KGbK1DmmgV8Zwxk8saW5QPfx95adgvIFDIO3tezw8fw6UpCFL1BN
 IwJzH1MqpWxPLUdvwb3WSCBBhUgyxIhcboJpHyCo3YXJ3fxEPzfx7smVyGyLTB/6+fH/HRgdwHK
 NVn+B4Fmkz7coI3x9bUgYFb7e0EdWT5xfzOTBIckgAsV0zHBfsoMl01zIJDRHspOkzhW0W1+mUF
 zBMbkyX6RWkGK2HD6rQfFxY4iKyzrAHUr8BESXnG3ksNrmAKlSsr5yOpLpdQVokc+nrBvhsv/Q6
 83TS2U7oMyex0MkmWxEItdDK1uPXvZbo1UmWrSOQScOB+B5pF7lJ2EMJSPiiEzkmx8TpBImqFwF
 bHUx+kzP4Vfu/PnuF5dOBkLl3l3PmByNar5lKVCIGiwMTdFIISRNdkXHOG8UGzsFYYEYSIijdsp
 oQJFzABY6zZAcx0RZ9AHgwByRn6qwF9CBdtAuMpWqRtaDKyZ7/z5PiVmolO0Dm
X-Received: by 2002:a05:600c:524d:b0:480:3a72:5c10 with SMTP id
 5b1f17b1804b1-4804c95c6e0mr17096355e9.16.1769115732773; 
 Thu, 22 Jan 2026 13:02:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf1acsm93638615e9.14.2026.01.22.13.02.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:02:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 10/11] target/ppc: Check endianness at runtime in
 mo_endian_env()
Date: Thu, 22 Jan 2026 22:01:00 +0100
Message-ID: <20260122210101.55358-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Rather a runtime endianness check via env MSR over
a build-time one.

Now CPU can change endianness at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 714629079b5..7dfca0b41a3 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -31,7 +31,7 @@ static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
 
 static inline MemOp mo_endian_env(const CPUPPCState *env)
 {
-    return MO_TE;
+    return ppc_env_is_little_endian(env) ? MO_LE : MO_BE;
 }
 
 /* PM instructions */
-- 
2.52.0


