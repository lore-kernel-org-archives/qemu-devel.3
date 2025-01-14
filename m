Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C87E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFc-00054U-Br; Tue, 14 Jan 2025 06:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFa-00053t-Ri
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:26 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFZ-0005Oh-Am
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:26 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso328648566b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854704; x=1737459504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fkCPXOa8A9Xl79fpL/YYXVm1xiiiaH5KvVpCQywK3U=;
 b=wTA7NefvDK6SBU8FfH5jRXOPPxKsc3aYEbgi8Te6fEmgQgButbzMoeBfoVswgGAIrO
 AeH4K4DreALiy+Lc8JplMy4RTushZXtoB/3mZCDYaScPNf+Pc2tQk25vutwzNp3YfkqZ
 t2VozkBmk8lmtLgN5/uSXCJWaeMtsk6AOcRJNAYBFWT861sQaMZnL1WCOrFGeHx4N6Jw
 j07vQqXQ1JxI9+ZVZYncG2R/Mxgo6ViqFXL/EFqCkO0KMyCWt9uy0BEaErzfylA7Uv+C
 /lER7z94T2LsKZb0qSB1pO57vKg/84SYqg4dfiQofSTVURFe7k++s3qtZ2eIJsVyBq1V
 CNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854704; x=1737459504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fkCPXOa8A9Xl79fpL/YYXVm1xiiiaH5KvVpCQywK3U=;
 b=mziYdm5m6fQmfog7+QrB/7nvpSJ7hcm8S/vksvMJov5uXUce/Njl4AWUjgt3x+MhcE
 j2dbPApS9PcXsdnF3B/8YRQKRZupnLTUMORFMm4XK408++NVF8eAT9mg9ic7OUXXwlpk
 FAAyA0YDaG8avkG2m1QaqMbcBqEkXnnLMv7YF9hptn5/R7vC/A7Fa4sGFDTsD13xXeyj
 txwZ38RSCZjZ9X3l6/lIvOxEYLGU1fL/sZ6p0YPr+IRYUleAEdLegJcY/rnetZ9/TzrD
 d3P03JfQEs30eMZtQO9WjnW9xBIBBzcaqONcfLLeWOochg20soh82PAeCgFj2yBAudus
 jeSw==
X-Gm-Message-State: AOJu0YwXZeyD7Ez1/pvDn8fncOY71zVne8uURVIqJ92T0FyfEn2u7EYx
 C3EL6Xyu4xYm0WYOboX+Hwir82mUZiuWCVljM5enjuXxNGvDMW2FmkapwWwWRUQ=
X-Gm-Gg: ASbGncvoJ9xdePXKKK2x1DEi5o1rtVRhjJw4WHLxd1kb5n//dRKCPhXH7aN/fvNaC4c
 ZaFfTiBIF97iPbKpCB60yLInZN28SERw3Bb6n02ghar7K3dB1Xf5f7GIFmepgSQPK6E276AYgkf
 xxSO16AloJup0++QdllLvTw1VET/jn2U+mB3imLRInB8fNjXm3aWWXPE2PmTTjc42Kc6I9QSgo+
 fmi86QLspm4r4AtrQSfTz6rUscSNld97LDPabeumwBcc9l8mHGMR/g=
X-Google-Smtp-Source: AGHT+IFaOkY7aOAcJd7XLJt22LzsNW/qy3PcS9JBL1OexnR3r+9bt6ign45K1yQsYJiMWZejNxuYew==
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:128c with SMTP id
 a640c23a62f3a-ab2ab6a8dc8mr2510336666b.11.1736854703725; 
 Tue, 14 Jan 2025 03:38:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b2181sm618489366b.162.2025.01.14.03.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 256B65F935;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 04/37] semihosting/uaccess: Include missing
 'exec/cpu-all.h' header
Date: Tue, 14 Jan 2025 11:37:48 +0000
Message-Id: <20250114113821.768750-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

TLB_INVALID_MASK is defined in "exec/cpu-all.h".
Include it in order to avoid when refactoring:

  ../semihosting/uaccess.c:41:21: error: use of undeclared identifier 'TLB_INVALID_MASK'
     41 |         if (flags & TLB_INVALID_MASK) {
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/uaccess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index dc587d73bc..382a366ce3 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-all.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
-- 
2.39.5


