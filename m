Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E96EC35FF3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslac-0003KZ-Hc; Thu, 13 Mar 2025 12:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaX-0003HT-RI
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaU-0005ao-6Z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:16 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso2177947a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883952; x=1742488752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=949DeBQijWmgHqYCdDdupcSTn3rDdND8nLqwkILEwEI=;
 b=pO1qkPN3xq41woDABhcVXxQXEMO51Cno0Z1gcYZyej63JZEb8VkYQKvgZDVMxwixx2
 8dRYsjb1ZLYa5U/zvdYxUXQ8tdxSmXbqwWG65isMWlF3+x+ftn4IeASC9VvfktWcrt1B
 /ZqZBqiay1pBYfxSzdTWa3RH2plY53bVANXtY27WgilGKuyLwDZRpWAalfVkBDyR7JVE
 ykiYZpkU3TU+EsZlCMOfqEML6blvPah395Cu68vjLkJG8uvRDYJ+dKxH+FZuz7957DpG
 9+xsgKa3e/EY1jxxudOZ4vQ+ngPDbCHY6mYdLU1+9cfoRgCGfl71xNp6rU1QDWlSDFks
 kisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883952; x=1742488752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=949DeBQijWmgHqYCdDdupcSTn3rDdND8nLqwkILEwEI=;
 b=Eh06/eTOyXsgcsVLTBR5LGs3zlm729ZMgaVgEnQiFMGwVK1rVeSOB0HGRUnARhdlqQ
 GiOpumaIsjAQ55oPZjJOrBXcUMgB1wJIXQWec0xH2Q4NbbjxZFQZAEinXKrA5eU5uYoz
 ZHerLQC+OuwipvOrxsOebQWZG6QDUSlmf7V690Iw39VShcpDGglaB9Xi68F0gWKRLA2R
 KsVa7HIQh/yRLGS24KvTVNm2YY8xqUOzXBPNV/ym8ieP2PcTKOBiDIDXdY5chtP3qLRn
 COuWZJWNvufTc6C831l5+WU5MYfT4r37GI8/clF9rNxjF3mUQCcGlsBcBYdAOJeUyYLM
 XsCA==
X-Gm-Message-State: AOJu0YzUlgnL+WiKKc4t9Umk1kETNJ4azpENJ3q9gVBLN4euCVoBr2cH
 IutSoxFVYg0u4VgYNoamjUwWgAVIxxnqXLK6hW1QThyRH/WhH4IDwrJ+4PGIkOTJJDAGwTO3yJw
 iM3Y=
X-Gm-Gg: ASbGncvh0IMtGej7LtPmM0Mx948mWHyTIDWABNb4cmbfL1R+bMuIYistrOutUA8C5cP
 /erCNxCgcloBbQycuEjsmV+dK3C4lm7LyEDF0R1GNWOxhbXMY6+0jf07C8FnR8Mxh//TBAy+urb
 8gjjwSKtn/capkvuI/UPcs8jDhz9wEaVdRShTOPW2fchbNSpSPcdzIptlov5yhpT9qpNbizVwUa
 w1I3YCz3luX0zbwU262mE67/VgcBQA+Qa7xy+eW373JxcKo3TF68wQPfOPUiobJ9XKpJkDw1107
 /xELNLC/KpL4jiU1e0+rPG08VaTTE+8vK4uDRSYJ3KjP
X-Google-Smtp-Source: AGHT+IGev37PyaCRPVTSAXm6sa8QmcuQfkCR4AEqF/Tkfr+Zh7Bhff2KfoPULWlCloRr8rbLF7MLgw==
X-Received: by 2002:a17:90b:3850:b0:2ff:7b15:813b with SMTP id
 98e67ed59e1d1-3014e855f52mr302864a91.17.1741883952691; 
 Thu, 13 Mar 2025 09:39:12 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 01/17] exec/tswap: target code can use TARGET_BIG_ENDIAN
 instead of target_words_bigendian()
Date: Thu, 13 Mar 2025 09:38:47 -0700
Message-Id: <20250313163903.1738581-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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


