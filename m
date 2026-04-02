Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095A0D6AAF5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LTc-0000I1-MZ; Thu, 02 Apr 2026 13:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTT-0000E9-Sl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTR-0000hB-DN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso356735e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149492; x=1775754292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpwa24XgbbGnpEc9o84kjwJoQeIsKIVNHM7RwypFzUQ=;
 b=v+mZgVG4ShNmQWZh0fYqGG6DlMrTdCpVdyi56Z0de4MF2Onw6rXMEwHStWpAKQjT/W
 0nOF/VTS7ryypEcN/pbmN9pbLGhnCZdCHtkA+dFPQEu95Biyutabi3wNrjtXGY3sXa0b
 w52N0NzCCDb5Mac2PvjooL0Ug3kIHPKUZLI6tPzSQVF+3mhBc6WxwR5z2JJpzUGAExMQ
 0o0O4Nig4gkZbdk+dGCQog3am7r5Z7vN0LN849m5a++D5DwLcQE/Mdg+fGJjsItGZBTk
 vvbL8auGYrDvUVqaKYATAN49S4z0aSk0vnpQiBfbUsD2HRQsstY8z7k8qM9bAIgdXuIE
 QpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149492; x=1775754292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vpwa24XgbbGnpEc9o84kjwJoQeIsKIVNHM7RwypFzUQ=;
 b=auiKv8Y9vvCwqYkIx0AjhlibfZoXtltdcUU8+65aXhFEpAHL5U6tgjoUJY6nHWo8uD
 GWxR6LRsEgoZISBBA6ZMeH/C3u146j7bYgj4kv9JaxbgdMDeP/DyQmULnFh1GiMNUCG4
 jSpvlnPyk+ScZj3vwQ3BMrt4/xx6G0J3yU7lhS2kl/6dah1oKgpgVdboIaOnFphDR3s8
 cBzNZAGafA/whBpFUrDCkfZDLnA1CF+NeKZ3pZ3R++6pkN1P6y+yIprrQOyXHGnLVUzD
 JSTm5VG/X+7J6BKhlo63m0nDre/diU5rOtpPEzM8v8XxIcPAfkZb6KTCv4AIbFkfl952
 JvIA==
X-Gm-Message-State: AOJu0Yy95SZbqS6joX3UrP8vcRLbbw5DLhZsJSoEfo1qc3w/BifmtsOB
 mBhgyJIjV8gASD2A0FPaFo8NDgTUqxsGZeYcxM/RVTpjo7t1wSz5euMCuJ6hbKGE9cwDzZAsjdX
 aoVesDoc=
X-Gm-Gg: ATEYQzybcr0W006sQG+KufKEQfJ7lfBNpw2jMb4Yb8G6QmzPZuMbJWvqLq6vTOvwU1C
 P6VEwBB/2serI81JkEQS5S3PfeI7S30lq+a0X98YxNopQ0u/iE3Q08LZFx76GrbZju26ZEsouLP
 4Z7zmQgf3fPXvNYcEFOUEWQhNsju+K6xFFajyc5EZ8bDxSKqNGu3sYxUKKEmEhNVuc1jxyMPRbb
 vRmqAwJsuWmIt2t1wTgot0CNvGX76r1oVay7PFepNWKnOuuNbO0n3lZlLveg7hB61tQupiE8GTS
 gL+h9ZV8GlWJ8rg5KDV7HfQnWZFycV6USowVuf9iXNAjAEaSAZLMFnKqVmY7A9127533XHz+l1p
 aGapB8YZwrKWXXanyxqUvJUeFhGn1zxtoBUriVD2Bg0sc3z2iXcTwYmi+Vk/YOyfF2rXNh5gfQC
 ARFK7JA8TL9cINJVVRE240IEnY6F6Rwu9NYAs8sC1yKlbjmeriALP3VenhcQA5pWYMmHhsC1AF
X-Received: by 2002:a05:600c:c056:b0:485:3a86:6392 with SMTP id
 5b1f17b1804b1-488835b75c4mr102142295e9.20.1775149491541; 
 Thu, 02 Apr 2026 10:04:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48897b82b50sm2140515e9.0.2026.04.02.10.04.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:04:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH-for-11.1 v2 2/9] accel/kvm: Include missing 'exec/vaddr.h' and
 'qemu/queue.h' headers
Date: Thu,  2 Apr 2026 19:04:27 +0200
Message-ID: <20260402170434.94783-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Commit b67be03e3ac ("accel/kvm: Widen pc/saved_insn for
kvm_sw_breakpoint") used the vaddr type in the kvm_sw_breakpoint
structure but forgot to include the header defining it. It is
however indirectly included via "cpu.h", which we want to remove.

The QTAILQ_ENTRY() macro is defined in "qemu/queue.h". Include
both headers in order to avoid later when refactoring unrelated
headers:

  include/system/kvm.h:398:5: error: expected specifier-qualifier-list before ‘QTAILQ_ENTRY’
    398 |     QTAILQ_ENTRY(kvm_sw_breakpoint) entry;
        |     ^~~~~~~~~~~~
  include/system/kvm.h:404:5: error: unknown type name 'vaddr'
    404 |     vaddr pc;
        |     ^~~~~
  include/system/kvm.h:405:5: error: unknown type name 'vaddr'
    405 |     vaddr saved_insn;
        |     ^~~~~

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..b5763a562d7 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -17,7 +17,9 @@
 #define QEMU_KVM_H
 
 #include "exec/memattrs.h"
+#include "exec/vaddr.h"
 #include "qemu/accel.h"
+#include "qemu/queue.h"
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
-- 
2.53.0


