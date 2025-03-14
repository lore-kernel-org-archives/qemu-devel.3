Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04994C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tb-0005qj-MR; Fri, 14 Mar 2025 13:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t6-0005av-Pz
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:01 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t2-0008FU-02
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225d66a4839so27410665ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973514; x=1742578314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=rcCAWRVOqdONLLa9THoKi/dZLe6yF2jipUj1xzob7exTSojrLaz6WcO+Y1MEcu9noP
 ETbQQ/bWjuUN4g5RCJjiSJOjDXNeGGm98n0Wzo5BxoF9W+rPQ3LjzI8VV/sF70+Vhy3z
 X4M27tmJUv5NIZjI6i/l+iaTH5M74wCQ9N299ee6DeDUTKjq6/pzdGnCKKR8X96VcuC6
 gAtMlulzFjpR8GghTP7o3J5wVUmU8ZUtu+JRHnHXvHNvEypPNnvlhkxl5pMY+GsPXMUE
 r0yY8nlPvWzGmqyGhWws+oHBfebZJ0PxoTk4B1trM2+irJsY6vRFVmxc0t+sYdFI8Cgm
 pVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973514; x=1742578314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=VDIElCEG9wkgEToTelfdzedDNY06Yn3e7+NhnXeOimoLYOTEtCEcX4yFuwrkCZOheW
 d0NhOWpxKeiSWb5WL5S7n46TV1rwMcJ+hxfP3yVSMcARcLAkVOXHEP2YNsH0Fx5O6mKh
 wwq7g8/Vn0y9qyFX6qXZwuepzVROy5TiafK0FwXV07qUcdpmiiqMJvwPOHBi+pd3E39A
 tJsRoCDOw5MEHsijY8zDa1ZTSl+S0WxxpLDAnPRZ0hvUn0zsWb3CR8HgUUphGGC5sTZw
 bLPxm0JBHR9bCkp9SLj33AenMCsOQLZOA+Cy9QbkR84OCzwxA83w/5f0ouDi+Gcx+gE7
 Tvmw==
X-Gm-Message-State: AOJu0Yz4dIGhgzDHPtTe+VPLnHJtbAEyjaL77Xf1wng/1mELr0etndpV
 Lyly0QqsKxKG+sYUY3vYEcrQHaTwD7Nlb6L6oeTLLLuD9smHeS6P/wELPem/p28hbIY5mjx87G/
 5hCU=
X-Gm-Gg: ASbGncvRKcS3RiQtavdLCsuGeq/ClUnLfvpdWxmKb1wxekQBTY3tF8f4PCYOkVR2hbS
 jX0cg2jgcrTXGj+50ozUi8HAKU4xAtfwZrUPNg7qVazVRBRxeBFf3ZHbwmBl6oMjbyjwBOewwmz
 5zNlWnJN8XnhSRILUVvjhsgaurKyIEefCBAgn1+MXiMUhU+1YFRtPZFT53OjHeObNFFHbjY7ylr
 0t/S6d1IwkNArrAyLoIq6wD7tvETxku5Gh/IbiJp/EptIPNT/SiGhf51onMVi/+tQwfp88xz945
 odJCpU6inbZfx+MQ+UFXbUXgy6wKCj70HAhv6arfq6V3
X-Google-Smtp-Source: AGHT+IGePgTU4KS0V7kjk76bTSqsHMsJJFpsZKEW9Y9cBbqNQCd9EST3S+oni0XLMdUtO/XVrzydIg==
X-Received: by 2002:a05:6a20:728d:b0:1f5:9cdc:54bb with SMTP id
 adf61e73a8af0-1f5b07bb133mr8380424637.11.1741973514284; 
 Fri, 14 Mar 2025 10:31:54 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 08/17] exec/memory-internal: remove dependency on cpu.h
Date: Fri, 14 Mar 2025 10:31:30 -0700
Message-Id: <20250314173139.2122904-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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


