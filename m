Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BADC35FF3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslal-0003SE-CW; Thu, 13 Mar 2025 12:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaf-0003Nc-8I
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:25 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslac-0005eO-Dy
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:24 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so2197840a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883960; x=1742488760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=drne6AO3Azdn6W0gV4JkEWadObzFjBhhNd+0nD0W7YZLVWhRQIwGlObGjzhzgX1S8x
 B78HebcF4oBv7asEkyz7N8bHloLuy8h9t26/Mqk4oYjc6pJdbzzMyrkP+ekKUvWO54Ah
 bDceKaWgSWbVKDhKUCt/DzxGYscLOtUcfdMim0VGbipdYiTJSC3CKFTk1ARJ94tg7LD4
 9shVopw5utvldj/oEcKIcQGweIYXLhY8TxgRvCL8NMVDKBe8+7DsZc9fllZYgCcMeVK7
 CFxDlWWKTwDsXJKr5O0dkFCGLps1M9QD+YZvgNStfYuC3+XcPHyKrSd1SkdTXhuaPqwB
 PZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883960; x=1742488760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=XI0OaRvUwUUF/YuFAamXY3ZPt9SLH6GgorK0romHpTsZcAaVk+3jz65vGFT1JrKqjN
 FFzUZW/VnLK2sjDiH3plSsd2fLTr9cK+Ln0XKYEUivN+D0EtgUU4NY9MszP4WNPNTFhz
 W6fXmnd44FZLwvJHq/UhxD649ceJT3XxEBGkGD2WcpWDLjnZdz0W9KrpPAzOXPysBpvy
 t8l2ZDaeycbkdizgzT9eR++oJRXDuB/mEnFQhEocadITBbwpotLtHP4j2+jUO3YwEcSw
 IuhfhDvVojpGD3z/mnJyk3AafgZ1OYElCOY7BzHfI0HNVkNtrWPwcGGTkUQizQazez/K
 i51g==
X-Gm-Message-State: AOJu0YxSZqtrdiJ9PF6tt9lUJg6ppVA6EKSrjTFGLuHO3IqtCP4Fz7oT
 gTAZuZR+Y5gCsRWXUojoitXsYuBMo888qVkwzaWGmcsgdfYTSppnYaIghFS5QSHdhU+HOIDREXl
 JCxk=
X-Gm-Gg: ASbGncuhKdzIuW1Of1glPOkC2wwUix2oeQS8GqFehPyM5YxzilhApx8ggcTGKqdIqwY
 RxNhquYUydOUqARfLBHhu9Q/W7jrEiz7Dw2tusDh2cVE5DpvqfxmcsECg7Xxgdg5YhBBh44SjBn
 RTzA8I0+hvWRMTpeKJKzH0DohYUU2aL4iqnBNW3e0KVZwnTWmagrG11dZE+563ovW+DOFxdxMgY
 4HH6OUIJdi8eu4+5XunM9nglLD5LIBahufumTbTYvUdm8gbnmCB4lAQA+UXc6QmTaj5dlM5lH3y
 siZGrtOE8y6zV5xGKgavJ4J7H/jzAle9RKiRSKiTUDok
X-Google-Smtp-Source: AGHT+IGZzjulkQU+BByDQKOIMhSKMvzNQK3Jb1Ldmjqqry9imNMjEt/+F7i1NK8ViRkyqUoEaWDauw==
X-Received: by 2002:a17:90b:4f41:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-3014ea23938mr221254a91.25.1741883960596; 
 Thu, 13 Mar 2025 09:39:20 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:20 -0700 (PDT)
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
Subject: [PATCH v4 08/17] exec/memory-internal: remove dependency on cpu.h
Date: Thu, 13 Mar 2025 09:38:54 -0700
Message-Id: <20250313163903.1738581-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac2..b729f3b25ad 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,8 +20,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#include "cpu.h"
-
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
-- 
2.39.5


