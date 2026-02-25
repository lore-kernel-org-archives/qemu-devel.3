Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1215CF5545B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7D4-0006vC-6r; Wed, 25 Feb 2026 00:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7D2-0006uq-Uc
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7D1-00046U-Hq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:16 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso8442475e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771996393; x=1772601193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqrb1njuSeGzwFOqvJshYg5hho1sLouIHptMUptf6Ks=;
 b=AWQXZazXmeZbOmU0Y0CsT9IY9SxA0pkL+tQhrC7tRQOq3XsrswJL/HqYS4nl4pFu0+
 j7Bgdtq77BTXj/Ww0iwshQqylbKNxiQ7h1P/PvU3xlc0DLEJYGa4Cw3N3X67hhNFm9qj
 2HfaPKwkfJTwSf69j3yb+J790jUaCnj4z47XeI2vxkazTqn4LpGm4AfLqwncraNN2pQ8
 +VoqCAU108H/02LhIr9n5P2f7utMI6s9q7SxAfA3JeE2CwWPrCyx1JKEZOfGLtdBUCvr
 ypDzAhunCQqr8kLVI2GjabqyXOcOzxI95IvSt907EyxwhEtl+uZNNIA2ljMLCiOlT4vl
 Vsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771996393; x=1772601193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yqrb1njuSeGzwFOqvJshYg5hho1sLouIHptMUptf6Ks=;
 b=l7NsLdnm6HrZLuUkw8ANSiCoynaQPl3qnKx5uvB5jj2lXwGR0x99sEsm9IXnf/tNq/
 iM1ix9+oTJe5KcqmgEWfqUcBFq1/ymqALBSdSZrL7+N8jXrOsti3qCDN8F9mz9adKOnH
 VigBFiSHzPYreFYuqDb52fxWPox+BwQSwDC49U1aIfzOxys0bSDHdXWeAyVcFw/Eodza
 eyYuvhNLEUsNQr8/0xLzrkcKcUbBwShjBvjPqP2HD8F3WHEdKeuqPUTGpcQzh0qTiNd+
 3iSJQe0hHR8JtXKp/9XnJ/00pr7eojBDHbzfMBxCuekAa9kM4uLL6upPxCPRJ9dvXeMV
 Fjpg==
X-Gm-Message-State: AOJu0YzNhtnQ1SMzF0F9YntRQ6EfvkogF7jpbLSkPkPotGO/QEW56jGc
 Hwhh2AnTYXSCNt+x1OLiBcbfyky7hxM74CrXH5SGwcjoUwagkcfE2L2ekAwIpI0WFpqHEzfC73A
 /U3ed2ts=
X-Gm-Gg: ATEYQzz4TGirt4Mgss51AebAAp9ywbgo733pLAvxd0zuUQVgGyQxvv+fISspjWUeM+X
 y1RGBQP3GOvJRUhVu7NYOjG/ADuc46ICV28RPkZ7vzgyJyGHHZusKliyNKk/eYDshYhqm9XXzt/
 ZbQPGSMiBnTLWkEdF74fokY+4ZIOZkc5Or2c8ILu5+BT94YF7FQlnIurtGQEUykCRNRyGVMn6P2
 PFt3oO56R0arYrkh9necLQrRqMddSnnzK3Q6X/76j1/B/qPIG5sxzToHyNt+BycYOfccUxZBQuV
 gkVpi2C/LJ6qLhHgIJ09y01uIRppbDbrPr+kcdEJeueaqxUEOeueYRs1A349MO1+SBG+6aDafSZ
 H5OBjOL3gEB27Bgr+cB0s76HpfLVYrHMBFhcvtmu3PntBLEjA9E20B3NJilRPI+yqbFlk3QFdyO
 Yb9ZO5ahuDnJuwpPsXIs65kgpce7S5TSZUWK/2JO/i4OkpRGvR8xFwbLwL//w99Zta6buthRFC
X-Received: by 2002:a05:600c:4692:b0:483:6d42:25c6 with SMTP id
 5b1f17b1804b1-483bef54059mr19754265e9.23.1771996393138; 
 Tue, 24 Feb 2026 21:13:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf894sm2825775e9.16.2026.02.24.21.13.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 21:13:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] accel/kvm: Include missing 'exec/cpu-common.h' header
Date: Wed, 25 Feb 2026 06:12:59 +0100
Message-ID: <20260225051303.91614-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225051303.91614-1-philmd@linaro.org>
References: <20260225051303.91614-1-philmd@linaro.org>
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

kvm-accel-ops.c uses EXCP_DEBUG, itself defined in
"exec/cpu-common.h". Include it explicitly, otherwise
we get when modifying unrelated headers:

  ../accel/kvm/kvm-accel-ops.c: In function ‘kvm_vcpu_thread_fn’:
  ../accel/kvm/kvm-accel-ops.c:54:22: error: ‘EXCP_DEBUG’ undeclared (first use in this function)
     54 |             if (r == EXCP_DEBUG) {
        |                      ^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-accel-ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 8ed6945c2f7..6d9140e549f 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "exec/cpu-common.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
-- 
2.52.0


