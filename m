Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41BFC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjss-00008F-CR; Tue, 19 Mar 2024 20:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsq-00007s-C4
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:44 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsl-0005Ya-O5
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:44 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5a4817189c8so2641977eaf.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894758; x=1711499558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhOWQohjArqAQE2458CrIktVxPOWZvRPD9t4+1OeJxA=;
 b=N85ty/y/u6oN3Rd6/FxduBnywisHKLKODM2cqMrHHmVO65S1FU7QeP5Fb+t8oi0yiB
 +Mqp0tXVuGQAgxhpK079RAZDYo7E8VryP9uSFZFPst1SPM0u3RIxovjJCsD9KkRsjYj3
 qdUe7U6u2pj4yLLFgjpLMIuHNlg/qzlN8657RfKQwKFbmJZUERXmcGAQOkFo/FfHjqVS
 BTvzh/JzWw7nDmAdh8/oeHE0e0iqlh79I7U/teBekhw99X30oiFkdC7JqMyuzSUWR0qL
 s13qBKJrC1VaE/8AHhQeoglkxsO+fW9eQM4BCDNRVcpDTGCw8yDOwP7t5moGlsDVO66U
 H1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894758; x=1711499558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhOWQohjArqAQE2458CrIktVxPOWZvRPD9t4+1OeJxA=;
 b=pT/YZ2oeQtV4FMdtG0/O79mhEl6kntWliA/GwbbibRjcNvZxNFV54rQ/C67o3SuXY1
 FwKcMpMxEzYNjreFfiPUiO8Xt9+OqSST3P7GSRRKbcMttwY/0HbYsp29E2sNtO4Fhiwp
 SG6gSF2OGXjork6ksZoQKPZwqVkR/aHbJELFl15qsuxD2+viAD5WrriTmX7ufdsayy1a
 kl1mJ6Sf7CP4nOl1RfN3w+1dduZDY5Np9o5dUZUn4PNb7P8BqHsGX86GSGoIoPQ2GTUu
 K06pyUDJyzXlb20/J1MbNyCMrZpkut4YByxrJ+3gl97i5aGNFyUfFRkQwXoP6mJvSHhi
 pIhg==
X-Gm-Message-State: AOJu0YygYLm2BShxXvZCX0HLF/oaAvO97JxWkcoz4c/AXlLD19Q4rnfZ
 Ck1X+PlEe5YS+LMsQtEcplJAurMnNGGyuVmgcc+l6SjZlhGmMCUW287grKLIgvfJ4fjNQPphO+0
 Z
X-Google-Smtp-Source: AGHT+IGswSzZVWeIz4Wgdpkxs3WR7PR1MIVk4iY9pZo/EBhIdY2ew9uSTlVuNEzOgSvjoRbxvKuk9Q==
X-Received: by 2002:a05:6820:2018:b0:5a4:d7df:9233 with SMTP id
 by24-20020a056820201800b005a4d7df9233mr4038772oob.2.1710894758554; 
 Tue, 19 Mar 2024 17:32:38 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PULL 9/9] target/hppa: fix do_stdby_e()
Date: Tue, 19 Mar 2024 14:32:23 -1000
Message-Id: <20240320003223.554145-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

From: Sven Schnelle <svens@stackframe.org>

stdby,e,m was writing data from the wrong half of the register
into memory for cases 0-3.

Fixes: 25460fc5a71 ("target/hppa: Implement STDBY")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240319161921.487080-7-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 480fe80844..6cf49f33b7 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -281,17 +281,17 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
     case 3:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
-            atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
+            atomic_store_mask32(env, addr - 3, val >> 32, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
-            cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
+            cpu_stw_data_ra(env, addr - 3, val >> 48, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 40, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        cpu_stw_data_ra(env, addr - 2, val >> 48, ra);
         break;
     case 1:
-        cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
+        cpu_stb_data_ra(env, addr - 1, val >> 56, ra);
         break;
     default:
         /* Nothing is stored, but protection is checked and the
-- 
2.34.1


