Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA28CD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsl4-0003oc-W4; Mon, 04 May 2026 08:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsl2-0003o9-TG
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsl0-0005Er-Pl
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so65762825e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777899041; x=1778503841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpmouEf/XLMMEhR1aW1EPVUMlLvv8CBIVjLR+SbR+pI=;
 b=S42H6EiHJE0g6QKHoMWqmN92S9GJdMvns791ghB8ISkq9dGTqM8C8T7sIpfzPxPXcS
 uI+12SZrqlcY6NvFwcbFaChN6koRFjkcPDV+udOa1dSULXSiY8v1kFoKqKUPSOoMc4QU
 BjCQ5dNsnjWXI3B4LRBSVevHNgvoERXH+GvI684E/amNo5E+bM+4UG+2sJCw/y6JQAfy
 2tfzcj5+4B0X+aYlf6+lGB/pW8ckbe4mw5mxlXHEc7atEBr0f4BXnSIwmSQatRtiJvnv
 +JvNODO/4oLLew1ydI2svtx171A1YmxsCaLLE+sxTiFFS6iyB4GZNiSorsdV9OQgMSuE
 zllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899041; x=1778503841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DpmouEf/XLMMEhR1aW1EPVUMlLvv8CBIVjLR+SbR+pI=;
 b=ifOMmlfY+V2UAf75djmAo2H8iVRULecVJ14gnELQDbc0WeunjoVV7MVA2fQ8o3kndJ
 uqmV4YxgQxStjXDdcX2WpIpHDGVdJKEpU7x2o9VXmIy62DJRx+q8nV/Y1dj/m9KXmMjK
 PVtm24/DJhBhBKEJ/+Q0TavZDAeyciI7QXrvAlLrxXaUCC8RwV9L0N/oKD51l4x/1G5+
 QdkQ031iOj01xRayvfvmNxVDUGmcmbsF4RHPdGUWg1QnQUKuART5J0AgRpDYPTcy9EyK
 slvX+tVxnkAAGBP87FepkqH2aOWR4ljUcRaibC8x2JA0sFUjExtDl6TFHi18Eah/KiYE
 jbyQ==
X-Gm-Message-State: AOJu0YyRe/Z8iOFdUWVtlNnQKdzvw6tj5M/7WQj0OIJk8AbaFf0Xt9GQ
 xOsbpw2R+MX6ID0k5AlW5GrgifEkXSpFVG5+zsQzWZHrcqvfSW4Ry5K5r0jllV9X4Rxxfz1VsI9
 4SoUQKeA=
X-Gm-Gg: AeBDiev3LZ7VUim2hu20B1uQYeg8KVHm6BhthtzTlJdd4HcumNWaN48vS7+1z2ieD2a
 51C1DA/6acpubDmIyPzQ5RJYfTRQjuWD8c3yYpp6WdLLzMr/iLKb86NITmeuhot3K3O/imAwNSf
 wPXkOSF678Ou1RwIDEI/CvEqEtz50VwUC+MafKVf2qqmePnFmhQXbOBaS5XGzIRnSjHMg0jdZkj
 fHPAOrli23XC1HQ9JDLiek4guoeKSawBqV2Qskh65uVFaHyqENhyqFtiAKSng/AP/XObemdNaDd
 vwbpqxMaXqGJzHXC34VBmD0igyiZOLiiztZJJBMJvRYkAkF29FfwwgYj+31NL12vaUNsxj7sDcE
 zXNtS46kuqIbFwasggobhau94dg0auxslgd3+JA9/g0vz8uwE0AOuGwMVQ2Wssjys439ysAYG5V
 5KksSBhJ8EMpiOyLzweosRFras4fPupvMHt/PmTPX2F5+JDo/3wie4LqxufZaeVWI6s8pp0VuKR
 kuKY94uMU2qvNIeUcH9hQ==
X-Received: by 2002:a05:600c:a411:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-48a980fc5d0mr113442525e9.0.1777899040816; 
 Mon, 04 May 2026 05:50:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fe3cd18sm78542275e9.0.2026.05.04.05.50.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 May 2026 05:50:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] docs/devel/tcg-ops: Stop listing dup2_vec()
Date: Mon,  4 May 2026 14:50:29 +0200
Message-ID: <20260504125032.35465-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504125032.35465-1-philmd@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

dup2_vec() opcode was removed in commit 6e7b13936d4
("tcg: Remove INDEX_op_dup2_vec").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fd3a50bf4c4..c417ebe65a8 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -769,11 +769,6 @@ specifies the length of the element (if applicable) in log2 8-bit units.
      - | Similarly, for a constant.
        | Smaller values will be replicated to host register size by the expanders.
 
-   * - dup2_vec *v0*, *r1*, *r2*
-
-     - | Duplicate *r2*:*r1* into TYPE/64 copies across *v0*. This opcode is
-         only present for 32-bit hosts.
-
    * - add_vec *v0*, *v1*, *v2*
 
      - | *v0* = *v1* + *v2*, in elements across the vector.
-- 
2.53.0


