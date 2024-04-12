Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA4C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 08:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBs6-0003L5-Hc; Fri, 12 Apr 2024 04:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvBs4-0003Ks-KQ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvBrz-0004K1-VT
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 04:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712908966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A5Llucl1jLUHeO2gAswtv29kQ2WFQbLL8CXHS8kKVi4=;
 b=SjAgnY8GRyKGp7YSVmhnqrV8l4HGqzTzezOAnF/6hbu9q+CNCDVv8JWBX54VOMh3ueP4ro
 5lSPva4d5LEhr0FmJB5rrBn4WOODICOcHTLUQ+BKiEvpYfD1NBJkdy9AElmXHePDqrRVdd
 ig0xfaMdQJae7fPwIs7DcEN6bsbPbBk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-JP5lpbHiN1GS-J5tbQCdjA-1; Fri, 12 Apr 2024 04:02:40 -0400
X-MC-Unique: JP5lpbHiN1GS-J5tbQCdjA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a523c6b9639so11540266b.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 01:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712908957; x=1713513757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A5Llucl1jLUHeO2gAswtv29kQ2WFQbLL8CXHS8kKVi4=;
 b=df7gQjUdsTxTti38j1sr3gXg2htjiBpxx0S26/t4kbeuty1HMFMwmiBCkRYrnQU4gM
 UC2An6EkCtvtzj2G/WuuAHNZa83zxLWU3poNRLmYl7Kzun41DpCrkvFPqjS6ZWVsRrL5
 2ILboixskUvCX6bmoR/g14Flfbh2JPj5fARRNVCqXWOnGgK/ZqhhbtDWz1WGLLEYzJeB
 U6G0lZPPMJnivOq149oKA+jFLWYMGFX9nCoUYtgwHG5qmO7ursBGYVWDpG0X1NXOKhPV
 yymziSqe60x/f+08fc48jo/6MiwFKFMzI+nb1qVACy24REX0kObRGCNnXoClxY7VXrxA
 xBuw==
X-Gm-Message-State: AOJu0YzFXirfDbz9CNGkLi+cVXeShic484MsWwK5Jm2wNSm5+yJkNX2N
 qfAWESt213Di34f9yxl5LfvWHGu/yovr8V3fsbC9yGZ8ofLWlIEOw6VVNV0MxKDf53w3lXOnpmu
 IsxZOMMUuTnHFgjC4gjyexHhfuJUgvWQaKww22q1zlBV9cYtyOANti6dEbT9FUlExAk2FARPVUE
 fPYeVEyeB2D6NSMvYI+8lz6LoNwSHFOWiMkOXF
X-Received: by 2002:a17:906:5fc2:b0:a51:ae51:5206 with SMTP id
 k2-20020a1709065fc200b00a51ae515206mr1062252ejv.42.1712908957514; 
 Fri, 12 Apr 2024 01:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErYet4bg0RW0ZUFW5vbK0hieqtx589Pl3BQxJEIVNRcGIFWcxktt9Y+3yogZ4bLyEvdBLGIQ==
X-Received: by 2002:a17:906:5fc2:b0:a51:ae51:5206 with SMTP id
 k2-20020a1709065fc200b00a51ae515206mr1062236ejv.42.1712908957125; 
 Fri, 12 Apr 2024 01:02:37 -0700 (PDT)
Received: from [192.168.10.117] ([176.206.87.39])
 by smtp.gmail.com with ESMTPSA id
 wp20-20020a170907061400b00a5226f9542dsm1178675ejb.27.2024.04.12.01.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 01:02:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v2] Makefile: fix use of -j without an argument
Date: Fri, 12 Apr 2024 10:02:35 +0200
Message-ID: <20240412080235.11478-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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


