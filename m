Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF5CCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48h6-0006nT-Eo; Wed, 01 Oct 2025 22:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48h1-0006m7-Lv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:15 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48gp-0004gH-9N
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:15 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b609a32a9b6so298886a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759370696; x=1759975496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuyHjwseD2/webFaCEvZMus3te6QjmI6epiQChOk2KM=;
 b=kN57Vc2OgniOm7M0ExI1GQ+jP/KsN+Uo3lmTFlZ0JWkFmjj6mcJLpDO9K8Hz5QfVVQ
 KX+lqWGTrIJll8JugrF/uqRwe/M8Ol4qb1Wn3Xz17V7pn/EqSIHW+Ukby8tf+626joHg
 2TuuH9hp5A5wVGUcjJgl2WR3wN8fW03uPmCwoYznjQ/C39cSXJekDq0UtOtraar6F2TA
 QpxGf3Yq8M5HzUpe0ZEPOJXo4yfXiBUwCWrbUUgnCVruQh/txaoqCO8/9JatJa1eThIX
 SnsncZp0Icot1js0mz/sl36ZTTabR41TSBTq1Fhu1GCIxUnpYDXzdo5DbyOFI9xQOV51
 R/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370696; x=1759975496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RuyHjwseD2/webFaCEvZMus3te6QjmI6epiQChOk2KM=;
 b=CkchOQsFA3Ex+vzkbrkav/URZa0bUXZDZ0Ikk5RT8Jv/+CXvYb78PwO8UDjBR+zj1i
 wTt2JewaYjV3oF4YreMtxs+GexRQKAtqiym9PJh2acWdIMDkghB6cCzLHVanYJ4Fpb28
 Fo/NptMTOYe3JvDqP2/ZuAFnNDF/gEdo8QovtfFAG4p4tWvQHIf1Fb25qArPO8qwhGZG
 Tj8x/fPoeX4OrBpbFmTkeispwBfpYUVFSXhE6aJH4H9u5HzVVc41dhYKPY6wCMeU47Zs
 +FJd0nCMdP0shaeTTist/6Z8Xa3yCMEpmxqb5bO7tYWnerP1EvOncE32VpiNkbcM2SWL
 03pw==
X-Gm-Message-State: AOJu0YxeUKHqOGIMM/A7Ojmis+ZWhsDGfAwOCDNOR6GV80DEoIC4+OQm
 ehMZi8iofl5lx4gCvs7s5DL2kjVdyxObpLBST/q8GPwSBlOd4eTS9JQQJtlMsSDE/ivaNj/1+4L
 1Jmzb
X-Gm-Gg: ASbGncsS6LXBYcXIM6WxTr4YS6k0MB/af6YIkwfDsLzOboUPRuSgTIaabHIdCqnd3vU
 F6Nxfui7IhUMfdDPb6jPfD6ujH8rn2WTxxV6t6T/hCUqo5T3rMW1ss2LdgVVIXOhDka60PD+Y79
 MMszGzXDjgn5+m+jdD1cgArJUgSKcuteD4LK1j2utmvTP4ea2ViWQOhgsgdGSIJ6wDpuE2hqwho
 pWmE6KtyZ0Xt6bbwRoyOKn8OKogB0rkTToY4P3LYK06KqvRTUQcZ9/paw9M3+WrcQ+pyOE5ka90
 /NvYKX1lPniBoUffQoSBaOwDRoLsaP4elKswZzxgZo3pogKzousDjH1cMTalEODgcQU0uN1Svkw
 cRuI/YvektNOgR9w3zSZ8zw6dnvTo9ReTXk5eF4Z9GXlSCFzzgCJu2ODq
X-Google-Smtp-Source: AGHT+IHPxQ4/j6ljkaWyQ75GYLD3b1nqQ5q6TOdMh5Xzn06EsW6kPtx+D4u57o7FuVamTZhA71vUFg==
X-Received: by 2002:a17:903:320a:b0:267:99bf:6724 with SMTP id
 d9443c01a7336-28e7f330032mr63742645ad.31.1759370696370; 
 Wed, 01 Oct 2025 19:04:56 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d95bdsm9476735ad.119.2025.10.01.19.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 19:04:55 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 1/9] tests/functional: Re-activate the check-venv target
Date: Thu,  2 Oct 2025 02:04:24 +0000
Message-Id: <20251002020432.54443-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002020432.54443-1-gustavo.romero@linaro.org>
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add check-venv target as a dependency for the functional tests. This
causes Python modules listed in pythondeps.toml, under the testdeps
group, to be installed when 'make check-functional{-<ARCH>}' is executed
to prepare and run the functional tests.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 62a4fc8ed3..e47ef4d45c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -105,11 +105,11 @@ check-venv: $(TESTS_VENV_TOKEN)
 
 FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
 .PHONY: $(FUNCTIONAL_TARGETS)
-$(FUNCTIONAL_TARGETS):
+$(FUNCTIONAL_TARGETS): check-venv
 	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
 
 .PHONY: check-functional
-check-functional:
+check-functional: check-venv
 	@$(NINJA) precache-functional
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
-- 
2.34.1


