Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F53D149CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4OVQ-0000iC-30; Fri, 25 Oct 2024 13:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OVO-0000hv-T6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:53:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OVN-0001fr-66
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:53:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e49ef3bb9so1556629b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729878823; x=1730483623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQVMbrxmPIorIA9abFZvz/SY8sgoMq+7si1O9+uYYos=;
 b=Nd4S9TYeajJt7aklvplgzFkIFScQPqb52dRsujXV6R8nLK/l1X9yp6CxX7nD8lC59e
 qDFSaLT3Sms6ovAtznxFMi5MLpPDhKCa0qe9j2VoDwTioFJ0f1VDG+wMyIZUicFHwfEs
 FD4cYjA8+9WsXILKzNYgGZUIpF5sBq04maPKPSBmv+Z8OlSE9IdQc7EjP3GiEkjhwPXl
 sXlGmkslB1FPZrpcdaKDA2tNPk+vQULe/u60zXa3QbNk06HYlpGKWNe14pCqFbCSwKDj
 2SPg7iuHImHTRl3W3c8mC+rtRn7P51EsjoiiiFvJSa74wC43N6J2bjKwHr7xAsrGyG9f
 p+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729878823; x=1730483623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQVMbrxmPIorIA9abFZvz/SY8sgoMq+7si1O9+uYYos=;
 b=oxmTX5ctvtsHzdEeHEkdSO+PO+FsK+OJaEdSk62T0TpMo38gNlGTI9YKPUrlOzLxol
 tkO3BHulbfyfByet6wBlTf0QRpdr+47RxerkfNm+mJLZUHV0vwZpWg36hXY/b3j+Mf+D
 9TaRMCyFp+KGNJmFcbf7UaVwMB9gLoTE8V9O3vcmlHHRrRZ17cI61L8flq0Ob6X2+DDZ
 Q5VOyHv8Pxy0+zoIUiBWIoKvEZ2gl7AfpwX8vH0y2I8QAbsRVRg98rx8YGAcpV+O0TNq
 Kz09Y8vlN6k1OIWh1HQrS3jwpnXA43+AIIQmbOTmid0/C4+QAfezFshrmC6OZQihF1J9
 hVEg==
X-Gm-Message-State: AOJu0Yw5NuhfuQK0Jsth4UMQlxmj0Ulol/0MOigAY/v3+niEAxr2UjrI
 YTiwn7O/hNvEkdEUzQ0hWN3+zikszqLTgV6IyIc/tDunxzfG5aEl4xwQgi3Y2uCpsAdK3eyT/sn
 yv6RVAg==
X-Google-Smtp-Source: AGHT+IFa0E+hsTawLWlHSPtBNM5P64GPpZnPdzRdzf4sVXpXdb3PZxCb+sbtHj404ioZoQjyDyMAUA==
X-Received: by 2002:a05:6a00:2e26:b0:71e:5573:8dcd with SMTP id
 d2e1a72fcca58-72062f1ed40mr548084b3a.2.1729878822762; 
 Fri, 25 Oct 2024 10:53:42 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a3cf5asm1329416b3a.201.2024.10.25.10.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:53:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/2] target/i386: fix hang when using slow path for ptw_setl
Date: Fri, 25 Oct 2024 10:53:33 -0700
Message-Id: <20241025175334.2549425-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241025175334.2549425-1-pierrick.bouvier@linaro.org>
References: <20241025175334.2549425-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

When instrumenting memory accesses for plugin, we force memory accesses
to use the slow path for mmu. [1]
This create a situation where we end up calling ptw_setl_slow.

Since this function gets called during a cpu_exec, start_exclusive then
hangs. This exclusive section was introduced initially for security
reasons [2].

I suspect this code path was never triggered, because ptw_setl_slow
would always be called transitively from cpu_exec, resulting in a hang.

[1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
[2] https://gitlab.com/qemu-project/qemu/-/issues/279

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index da187c8792a..e0436c7a672 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -107,6 +107,9 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
+    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
+    g_assert(current_cpu && current_cpu->running);
+    cpu_exec_end(current_cpu);
     /* Does x86 really perform a rmw cycle on mmio for ptw? */
     start_exclusive();
     cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
@@ -114,6 +117,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
         cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
     }
     end_exclusive();
+    cpu_exec_start(current_cpu);
     return cmp == old;
 }
 
-- 
2.39.5


