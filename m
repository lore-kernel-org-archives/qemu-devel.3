Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3DACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckR-0002e0-Km; Wed, 06 May 2026 09:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckM-0002Gr-Pe
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckF-00085D-9A
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so6171545e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075817; x=1778680617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X0ChLyLrnnWxFhFlsorIZFcSiHRTf4Wb3PMdP74ILOM=;
 b=HpUx71KirWsJAcf4pb36ndXLN/j0F1XXi6pGHJ733kP1wlBCDuBM82L9p17Dgo1ec/
 YgU4lJZDgQjqFOJAS77HsHufdBsi2GcUzJVCSC8NfHz29OmnAUNnM/bwfPd3Kuw3qEvn
 CPyneVNve3VBi9g5fRdDVlUQkW2zXo+U6PYI8OdDMwvGM69x7HCZO0h8u9piFpVzd+l/
 Tf8tIalGsmOt+/r2XG0v0Ai6KiDYJ2yGpAAc97YUDQCYSZbZOvmjcTeOMd7jlSdgOUog
 di53EWmIovf2zT93xQ23lddsXjwQMFeccs+S8kOVE2gIqHmPk8S3w806JqDYIRfqN/v1
 opiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075817; x=1778680617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X0ChLyLrnnWxFhFlsorIZFcSiHRTf4Wb3PMdP74ILOM=;
 b=m0tKJBh4y3wR9qytNIDSQ1o/a2AZPcXE/Oki7UOuCC5dioTxsDm/LwcZYEgyiCNjWK
 hIp54B0ideug7xFR/AIy1TYiCZkCHh6ag2qCKfgM/vKTMOWMnE29LEPcmlr/BKOJokqt
 ajjKycgROZFuIDvAUe/2o2qFgdZTU/P4BV3Vcziy0jeZACw+6kTF0Hl8qlFLsS79YXzI
 6eZxnBZX8zPlow9hgtlRzlPQHSr5Riy405NwG6pgNu2/ePMMCHO14+SC5hBQqTcLThTc
 9WC0Vv5cpo4Pkm6dtx+3u0Ar+m1c5Tx5zxCvIw2kZ5C8yoNn1tz7fawfVP6SzWi/TqlF
 7v4w==
X-Gm-Message-State: AOJu0YxxoYcJyqqo950TIR6OeCKY9qQASTNmc6DsQlXlhCgDLyLFcl+8
 q0W9URyUWPmgAP+jOKUhVWm8Ni85XVgMg+YOXuBIP+eHX6AbxMf2rdB1N4JcwQP3ZNJbtgUdEp9
 GZPmPZ+Q=
X-Gm-Gg: AeBDiesvqLeeboPhb+3yhoTpBgbiJlNXymAhrm3Ac8oV8HM0lnUOVAjdvsDZLN/XkXL
 h0jLk7f+uyXJ2MF6SUPcUIdC9BK6v+WBZDbet5TJ7xVpEVKp2GFKd/VHGs0FiEtCYLhWIW7wMmn
 WznJZhqRNp9ZwCViMq+7fzSOPl/PHP29MOAWT9lNSs6sInfhFbW+h3JtckuAIff70RCu7GkhEKJ
 MihKyEaSfQYQyAuL9wEPvu+02lDa3F51PD2R64+0ZodJ702KtEz7/eeGHD+007/sxznruRE6zNd
 yzcl1rML41pcauhEH2IXPZwMcR4zBUgiA2toYUsoqsTo914VL2GPn5xrwEz2t8ZakV85LhE5zDd
 ffBXeOjCyf9lCCTM4K088PkQ6S+fWUJ7wGjhl6u+OAaqmhWU0LxJzZ8S+oeiQTYvTE2C7Gxr1Y1
 NJpqLThPJMqtsEfskOwpi53INW/35n321x7NZotPn9sQCsz9HktB5+sd4CloHQGxY+rtNPgQWmL
 OVeMzNVEAU=
X-Received: by 2002:a05:600d:644f:20b0:488:c21a:4754 with SMTP id
 5b1f17b1804b1-48d143a4c1emr102969145e9.18.1778075816735; 
 Wed, 06 May 2026 06:56:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02802sm12815109f8f.17.2026.05.06.06.56.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 012/110] system/kvm_xen: Include missing 'exec/target_page.h'
 header
Date: Wed,  6 May 2026 15:53:44 +0200
Message-ID: <20260506135524.20617-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The "exec/target_page.h" header is indirectly included. Include
it explicitly otherwise we get when refactoring unrelated headers:

  include/system/kvm_xen.h:41:55: error: ‘TARGET_PAGE_BITS’ undeclared (first use in this function)
     41 | #define XEN_SPECIAL_PFN(x) ((XEN_SPECIAL_AREA_ADDR >> TARGET_PAGE_BITS) + \
        |                                                       ^~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-16-philmd@linaro.org>
---
 include/system/kvm_xen.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/system/kvm_xen.h b/include/system/kvm_xen.h
index 7d0e69f1334..ed8c357193c 100644
--- a/include/system/kvm_xen.h
+++ b/include/system/kvm_xen.h
@@ -12,6 +12,8 @@
 #ifndef QEMU_SYSTEM_KVM_XEN_H
 #define QEMU_SYSTEM_KVM_XEN_H
 
+#include "exec/target_page.h"
+
 /* The KVM API uses these to indicate "no GPA" or "no GFN" */
 #define INVALID_GPA UINT64_MAX
 #define INVALID_GFN UINT64_MAX
-- 
2.53.0


