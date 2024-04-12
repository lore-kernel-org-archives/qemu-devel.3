Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406DBC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDlZ-0005BC-2m; Fri, 12 Apr 2024 06:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDlU-00059A-IX
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDlR-0001Yc-SL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712916248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5Llucl1jLUHeO2gAswtv29kQ2WFQbLL8CXHS8kKVi4=;
 b=NJud7B2zxyvh77j0uh8L2V3dnCyxky0xZ1yjbGaNEu+d+4iBLtyo+oQoqTK7YTfcXPgEMD
 dWHt9Dk6p7p1X2scEiIdfX1ACLSlC6S7mdz8Ky8VkwK9TDXxcr6EOuIkhN9mTBYZ7wD16c
 gE8wy9OeI4SZ1BVP9qhCYj2W7EvbZ/c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-WJqSSSvZP-21LgZPLianIw-1; Fri, 12 Apr 2024 06:04:07 -0400
X-MC-Unique: WJqSSSvZP-21LgZPLianIw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56fe77747a0so1951922a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916245; x=1713521045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5Llucl1jLUHeO2gAswtv29kQ2WFQbLL8CXHS8kKVi4=;
 b=CVVyMXvZgDQSaZAavLoXLWy163cjcOar51ldc/TkcrAI6i7rRhIcbD3t2lPYKpPLPs
 B2+aU9G+OE0OY/D7p27yOoPVkKSawxQTW9ynrkJ1wF6KBNw4UKWPhfagjKBkYFO1cgEp
 qZMaAqNBV7qgoRYZlARWq6ON8rN+mJ2MUdJFvNtF01/ZOkb5ZkAfJLmhq4pqL4UxCXos
 N1DTkwRd7w+ey9T/bMXBMwQLEh8UjFNCalJ1KYCZsxn5lnnR41+d6P1E7QziSrl/bUKU
 ts9bm0QpYlt06nEe/5JALF+/ODZMpKjutO27V42iaqjEW4cwsZ+phTtNWtkU/Ga3FDgz
 97LA==
X-Gm-Message-State: AOJu0Yw3XnrYRJfTpLxaEAH1FZnQF4Z4PnW5+HXvfykVQhgF92s8bmb3
 3HLjYx5zWp1XCWXUXHl0AG1XG3hnC6Pd+s2CLN0/OOrY/agmYiJrlrkhOOBHT7C/oumvRbPbO9n
 YgD2l/yYzPY3CoygqooQXhuUy1bHWtZD52+7m0oEKgGH54IfpjEktGdzps9dpoO9HMMM93qp/YN
 meygN3tRtR7itEpEFxdyDoYyje/xzxLGGaWJZd
X-Received: by 2002:a50:f604:0:b0:56b:d013:a67e with SMTP id
 c4-20020a50f604000000b0056bd013a67emr1916308edn.18.1712916245597; 
 Fri, 12 Apr 2024 03:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvk4F6HwlTEZvLA3g8y47IjrnxSeaJ0O4otCmhUZDVCde6k9Ro5o7bIvLOQS8s83DRV+kX7w==
X-Received: by 2002:a50:f604:0:b0:56b:d013:a67e with SMTP id
 c4-20020a50f604000000b0056bd013a67emr1916295edn.18.1712916245272; 
 Fri, 12 Apr 2024 03:04:05 -0700 (PDT)
Received: from avogadro.local ([176.206.87.39])
 by smtp.gmail.com with ESMTPSA id
 dh5-20020a0564021d2500b0056e3e0394absm1504902edb.68.2024.04.12.03.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 03:04:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PULL 1/2] Makefile: fix use of -j without an argument
Date: Fri, 12 Apr 2024 12:04:00 +0200
Message-ID: <20240412100401.20047-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412100401.20047-1-pbonzini@redhat.com>
References: <20240412100401.20047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Our Makefile massages the given make arguments to invoke ninja
accordingly. One key difference is that ninja will parallelize by
default, whereas make only does so with -j<n> or -j. The make man page
says that "if the -j option is given without an argument, make will not
limit the number of jobs that can run simultaneously". We use to support
that by replacing -j with "" (empty string) when calling ninja, so that
it would do its auto-parallelization based on the number of CPU cores.

This was accidentally broken at d1ce2cc95b (Makefile: preserve
--jobserver-auth argument when calling ninja, 2024-04-02),
causing `make -j` to fail:

$ make -j V=1
  /usr/bin/ninja -v   -j -d keepdepfile all | cat
  make  -C contrib/plugins/ V="1" TARGET_DIR="contrib/plugins/" all
  ninja: fatal: invalid -j parameter
  make: *** [Makefile:161: run-ninja] Error

Let's fix that and indent the touched code for better readability.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Fixes: d1ce2cc95b ("Makefile: preserve --jobserver-auth argument when calling ninja", 2024-04-02)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 183756018ff..02a257584ba 100644
--- a/Makefile
+++ b/Makefile
@@ -141,8 +141,13 @@ MAKE.n = $(findstring n,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.k = $(findstring k,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.q = $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
-NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
-        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
+NINJAFLAGS = \
+        $(if $V,-v) \
+        $(if $(MAKE.n), -n) \
+        $(if $(MAKE.k), -k0) \
+        $(filter-out -j, \
+          $(or $(filter -l% -j%, $(MAKEFLAGS)), \
+               $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1))) \
         -d keepdepfile
 ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
 ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
-- 
2.44.0


