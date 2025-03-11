Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E8C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5kL-0000zW-A4; Tue, 11 Mar 2025 15:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k1-0000uA-LJ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5jx-0008UW-GO
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22403cbb47fso115148255ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723092; x=1742327892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=949DeBQijWmgHqYCdDdupcSTn3rDdND8nLqwkILEwEI=;
 b=w1mlVKH4kEhNempyiiXq96ZE2QOzsOnrItzWRdZwSZ79IRZl/h/qyDHVUpRctSM9ct
 wqPVKDAOGYZFxdzh3zGSKxN5pPD9IriWWhcFH5x/dfULOYYgE+DQ8A3v/M9tMyqokb0K
 Lq1SmPCUey4wxvLTziidBM2OR1EQYQNey52iAlpaq1BrApyt9DP5rt2AriqFGFDfxCei
 Z3BvoidHsSLtalP+nQjSIsfIUWgJT1G76CTE9IdRXYd/GUtWDsmt8uvj9npI3rli+oaZ
 NNUpnLiFYoU5u4qZTg6G2EGX9/YBrOBoSKp0vKiH0V1glIZ6lMxOVMPagWLuGicow83B
 h6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723092; x=1742327892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=949DeBQijWmgHqYCdDdupcSTn3rDdND8nLqwkILEwEI=;
 b=SW7jb0O3UsiMZ73f0Y3tGxbBt2smvCKFYfYc+9C0u1L451yykyKbbFZI0C6UgxI0OV
 PtUldGgZJARabfz+2g9FXfV7gAU1Qrj+fuSXQKCddCdHkRNaU1DxabS3sqc2wMX4A+Y5
 LYAQaKLhEArfpQSi1lbzLDJN1FpNxohjm6jdXLT2b7ECP6ZF/bRqn7UdzKmwMr3ET4E7
 E9Ar+xwgCoLQ7az+ppZ9EWZZJ9VKPZETMcw83KSTwz+xQVro6wejrsSbyy11CGc7WCI8
 BVaUpHTt6BK9GRtfsLXZjm3cBdg2HqoUd92PpugK4vla5AOknX7QiIpojC6gf40qG/Bp
 G9RA==
X-Gm-Message-State: AOJu0YykMG8SbGNI3tjAlwI2Fz3HCeAv4o6COOUmjfpDEly4cb4jnE37
 6z6iEnIJbLVOqkBjgIfQ/w64axN/Kht8Yu9PQh6pkT6r3JplO8kXzTIwXrPvzCrGDC+PlIKrvyu
 I+u8=
X-Gm-Gg: ASbGnctOq933IEFAW7vrdaE7sMuBym5hcA5zhI8LWmeIcnClORpaN94gGlrlXd+EPSn
 oIMD7SGrzxac+vIxtHxIIFrX5d66lry4TepflLVAUwM2iNwE5AJZGLccWOv7IR/n3W/sk+JY8CE
 gx7l0O2F9ix3aHFNKUJ5H00hiWHQOrASBznNbIpObPGEybxxBRbVxOdfuC0AgHxgF5QrJvzPgjW
 YP5lX8P9M9m1PAJ8/Q2S+/SEyspO7XCj3fCzQ4vmfuNWbKdwVFY3S0aXS86V6ig54CJ2y4sSzZV
 zVp2cfHi704594yK+fwtWu1pz22aUBvbgAdlxa2f6EeeD5LI0wIntW4=
X-Google-Smtp-Source: AGHT+IEdn0vUjdqWf+0ft6dtNABWq7WqhDB4TNeuQtg0nIMIUQeKA5OeniZU9oewAupJBz+i092ynA==
X-Received: by 2002:aa7:9e43:0:b0:736:d297:164 with SMTP id
 d2e1a72fcca58-736d29703d5mr9263457b3a.1.1741723091837; 
 Tue, 11 Mar 2025 12:58:11 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 01/17] exec/tswap: target code can use TARGET_BIG_ENDIAN
 instead of target_words_bigendian()
Date: Tue, 11 Mar 2025 12:57:47 -0700
Message-Id: <20250311195803.4115788-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/tswap.h | 11 ++++++-----
 cpu-target.c         |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index ecd4faef015..2683da0adb7 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -13,13 +13,14 @@
 /**
  * target_words_bigendian:
  * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Note that in target-specific code, you can use
- * TARGET_BIG_ENDIAN directly instead. On the other hand, common
- * code should normally never need to know about the endianness of the
- * target, so please do *not* use this function unless you know very well
- * what you are doing!
+ * false otherwise. Common code should normally never need to know about the
+ * endianness of the target, so please do *not* use this function unless you
+ * know very well what you are doing!
  */
 bool target_words_bigendian(void);
+#ifdef COMPILING_PER_TARGET
+#define target_words_bigendian()  TARGET_BIG_ENDIAN
+#endif
 
 /*
  * If we're in target-specific code, we can hard-code the swapping
diff --git a/cpu-target.c b/cpu-target.c
index cae77374b38..519b0f89005 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -155,6 +155,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     abort();
 }
 
+#undef target_words_bigendian
 bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
-- 
2.39.5


