Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D479FEB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubp-0007yC-FP; Tue, 10 Mar 2026 06:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubT-0007Zi-2o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubR-0005t3-Bq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso7195067f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139575; x=1773744375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jsdKwF0sV1Hvjy9u2Bqou7scED5WI3+RblAjwY8Y8Lo=;
 b=DL0LxXfgkWEfWfOieE8fELWHRlPcRxONd3icgqQogLw221NZv6WaIqsqHd2cvo61Sx
 7Fd5keTvBO8PuKp5D7FJaZbsYhnLSIfToIUqXuz06BW1aGCm7mgJRrRnAPaP72/s+xoL
 gpWfim8Dgb2Ve/LEnxa/snJGoG0mA8bp6BkmeW6AiFqIMCRgRxTs8zRNNpKZPzYy+e3p
 uynF5M68ndl2vMRsJmUgQWaSi896CzthoOIBAzhO3qPl2EHsVBFjSaf8EC7SylZchiNW
 +JmVLhFu8iUaCidS0TIs3tOpKlu6eQF0rDgZC2Dn4Gn3Iltj5rxOIWwvuUGAh7krLG3c
 xfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139575; x=1773744375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jsdKwF0sV1Hvjy9u2Bqou7scED5WI3+RblAjwY8Y8Lo=;
 b=uxgVJ09puT7Caq0sxdcld5LIZsBBXZS19VAVBYb6QXkt9c6bqmndE+nfHpjVUClxyl
 aWDDafUk34ZnCmnqnxpk2hEizTfqLFEA/LAbNW9epwEvooLRH2Kn4oMIGw5pxYV/KIHu
 yvovLtJR24Iy64UBIp8KjvVJHcTUYN2S784jC2HfBhlY1JhEl82wAgqwzSAZ2v/QA9Zy
 Rw33b4KZbs9AFRjCQypOmA6Yz9wIE75xanlQ6DZUssrqXZE0Iab9Y50P4H/UtC1TVocl
 0peui+6Yszcytan5dHl4GChsQw2w2U7Tm/oODJ2fKSXCGVuBLj6VG9eZHB1fY3qbtMRl
 9WQg==
X-Gm-Message-State: AOJu0Yz57SnXiJq7TVbMgRapbMN+P1YLuZiFVtazZ+6UEgWA5+kuFQCt
 Tp1hRBfTvb6BZy5yROGAPvsHD74AThrhPNi7NBAQD2JNt0O6a8gdEXtLCNLed7TgclPmkkacMID
 ifRes9js=
X-Gm-Gg: ATEYQzwO0lvZ7tM1eCwCc+83lCd9oVguOgWdcBJm5FnWTTuHWZfl596Loq+Pmsgxbu9
 0ENOsLDdxTNATY6HiOhUwIF4AxWRH2IinOfIruLaSn98fhqRIfjXtoUHvO8oauULiGj0jxcSmt0
 Lxdzc3ATkY4RILZajEues56V26BVqwOTA6aFfSvcPI8SlYzVbjvDUCQps+dJI6RXaH5u8XgdPu2
 vl1Qv3MJOKHcRQ1Xv9hShP2j87lmbJyNXCb/PR7lcOWvTXjQ6FcF9v+Ysg0oNgXJVt1AxJVj8mI
 CqmlDXQTtPye43++UYstga/AtdtqHhfmv2vPoI+YrfPUiLw+mx5PSiGg8R1sFy0nZNF3wVZBcnB
 VdCcgfll2RdcsEd22FKE0rRK3T0NLtQe+MY+KjLaopB2fIBrbGBgjCUvjjkUR83vdaHs1dkAwuE
 Kln4HQ7icagA23XPEDrf4E9hF0kOQdq1NPhCttqE+XSOnhikxyXdjCjwV4QQkGPq8+RBy8FspJ
X-Received: by 2002:a05:600c:c173:b0:485:3812:36dc with SMTP id
 5b1f17b1804b1-485381238b3mr138286625e9.9.1773139575469; 
 Tue, 10 Mar 2026 03:46:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d840sm37215917f8f.8.2026.03.10.03.46.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] accel/kvm: Include missing 'exec/cpu-common.h' header
Date: Tue, 10 Mar 2026 11:45:04 +0100
Message-ID: <20260310104511.12670-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225051303.91614-2-philmd@linaro.org>
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
2.53.0


