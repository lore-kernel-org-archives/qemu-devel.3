Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4F7CFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTI1-0002Af-3n; Wed, 07 Jan 2026 08:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHv-0001oi-2r
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHt-0008U3-CI
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so18205405e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791360; x=1768396160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4PaD430EGXIEVzYZ6UquPoib7etUUnvv6hu8bCFULA=;
 b=NYN+QEZmnjq3lxfK2ZgN+OCSI/k6iwvlYl2Pi0xc3+VxkaF97nTl6vDL/Uaj213ilL
 8ZEeW7+eEXOQjs89HVlhPmcciOD7QIci39P3X5ZGUkwuwbz/0W9MSbo4qOr0EcHBMu4i
 Cy8B23y1fa35VZWwSIva0k/4DL7LWjDhSN5OBHBAzXtSleO3ZTrgmeT1RcXOTXUirBwH
 07M79FfxBJ+Qj7aLm91b5RzJHmhV6rcvP5m5BM8CWN0USn7HS3+Onat5bAJT2htEfaWQ
 MWcLrkc4kVl2So3r/sVBz0+UKvr6E8RN1vsYgLI/W35pbWK+Nn+NvFzePJvZa6Os6fPu
 frpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791360; x=1768396160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L4PaD430EGXIEVzYZ6UquPoib7etUUnvv6hu8bCFULA=;
 b=LBgaCvho6HsFFMfzBbQB+GMjRIAe1XkvA7C/NIIB2FGlOpfMA5LiX4gT97bqIAKu0i
 8GqTRabrx/3GuEZpQDz0nrc69C6PlNcSlZ5c2VXbn2DP+G1QTTzWuJu4pSc6s+3vxVJ8
 pi35s6H3VcFN42i7cic7v08biejSn801KxYCUbaA6PV8HNorS8OjqCIUXKLqCYdyMp6S
 Ekc54hepUoJgX7veyiH68fK6YqQ/itrftA2VtooNvzxARQEWfp1+nKuYL4RuyyRANbXW
 QJo0SOjExTbNv1qo0bnh2r0Xeb2yql6qwE0K7KccEIRm5HetYAV6cuXAkaJ6jvrr81mo
 4O5g==
X-Gm-Message-State: AOJu0YxzGvSKJz5OF2AenEAS7jyVqoqrtte2awfYHDUG+5Hg65t9Eubu
 ubF5IrKWXwLZ3ubonx5ooQcWRHL8C/M65CO8CZghxcigIc3/IBp1H8NbxqFK/0ULFghn556d62m
 zPWmg63c=
X-Gm-Gg: AY/fxX6qLIDOLMJE93CG2iSEXFpuDhM+PQETCl8E7d4jZYSjwOzK9sd+HFtRIcvM8bL
 yVqM5qSM73cJz+xvEfYdGnCHqvwJD341c26+bfVi1zhmA6CxOJdjFWpClbb4Kxbop/eM5VazT4X
 8LD20ssrLDPm1pssfMf/+magBH/0ru4amrBvS4/RkaiKfzI7w73/7GHHE52Ubx9ZGB7/Nt1CFcn
 fGHnU+ShWZgRjfOXrf5h7lFXPhdhz3gqi/+sCXxe6YzO+uKo4tq3RtqV32D7fG3UswowxoHrTfE
 NESJ2qwGC6Ugd4T/60ExdRdpCsBc7t63E1gNrqGCJ2G4MVk/mqlHhtdgloXAyZ1DtUo+MYJNoFB
 Fr5bQW/e1hmYfjZpWvfHAwDSFiy81J6gwzmpRhL1DihsDVuWhQeBZAX1dzaNK1WIRXGqF0oWWry
 HMmnI0WACBH4OG2qD+TY0zXMWy834mHsRGYEIMjXVVsUPB7lexw5eTE6LcpeiZ
X-Google-Smtp-Source: AGHT+IGJHm3AIhTNX1Hx+55SqnCj4e66tLAuqWhX+DF2Aj+zd6vsnU+EaAgI8iahpZfbU3DZG0ZFkQ==
X-Received: by 2002:a05:600c:6287:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-47d84b17b7cmr28061995e9.9.1767791359613; 
 Wed, 07 Jan 2026 05:09:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41eb3bsm100064535e9.7.2026.01.07.05.09.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 10/18] target/s390x: Replace target_ulong -> vaddr in
 get_phys_addr_debug()
Date: Wed,  7 Jan 2026 14:07:58 +0100
Message-ID: <20260107130807.69870-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
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

cpu_get_phys_page_debug() takes a vaddr argument.
Rename the @vaddr argument to avoid confusing the compiler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 59e1fd0c4fe..f124b16d1b3 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -68,14 +68,14 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
     return raddr;
 }
 
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr vaddr)
+hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     hwaddr phys_addr;
-    target_ulong page;
+    vaddr page;
 
-    page = vaddr & TARGET_PAGE_MASK;
+    page = addr & TARGET_PAGE_MASK;
     phys_addr = cpu_get_phys_page_debug(cs, page);
-    phys_addr += (vaddr & ~TARGET_PAGE_MASK);
+    phys_addr += (addr & ~TARGET_PAGE_MASK);
 
     return phys_addr;
 }
-- 
2.52.0


