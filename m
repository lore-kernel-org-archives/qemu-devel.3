Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28091C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOM-0004No-Ju; Tue, 25 Mar 2025 00:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO2-0003t2-Mx
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:39 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO0-0005to-43
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:38 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3014ae35534so7976714a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878774; x=1743483574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suKjzNx+ro19ZSxlCmxY92LJNBi/ThyI6kfAqCnEFLE=;
 b=PWcmRIvrxmaIoyjQruE48FxCPdRveh3YTNKfiRVtrvw3RkCdDHlqbHVKKzY/MoBfIy
 MFu2TptdoX2LkwqCehAJHrykKTjGNPe50S1NCv4GePda0Tq9ZV1VZGVVjqdziQoQZCcH
 +p4OtsLJ4FvSJtDtY3gnKWi5+XESqOuKFVVZk5ZRpy/QlnYItZ4LAIjqAGk2y+e6HSA2
 AsA56jC/xLlwijWP1dLcQMl91QHhDm1xnpZ8ilECbG/DKeoMgBEywxn2Y+z2hRESGJFo
 WuXKPNu3zHJUZB6FLibXPyUXY6xWp9tUuRRPlehr/h5xSiA4KII4YpzZiiFeIrGTg6QI
 N71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878774; x=1743483574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suKjzNx+ro19ZSxlCmxY92LJNBi/ThyI6kfAqCnEFLE=;
 b=B528iJhY/X+At1vmB477+cmV28ou0qdmlTUBEQy/tEbHIfWMtk+fK7pTbP9B5zKRXC
 gw0BknennPHU3OC7QG49oMjBiheXwkl+qTWkQcw5MPv7eWWArsx8uOCM5au+mhxxi88d
 bz9OulvJ+8uzrOmbYivbmZsQCgJJqU2MRf19EF2q58/vKCGIq0Iyhb+qRPSZa1rYGmfg
 P/UN3jydB+4t9lbvC/rq4tGvRg+EXHnogiN9QMccfkywhACCQ5Bn/qSaeXVegD5Yj7n0
 hNIhb25TLYorKM/O655287RevNtkTC+090NBBNy2fk5ycI33cvzz83ew0mkM2ounAY/z
 SDqA==
X-Gm-Message-State: AOJu0YyraJksizTNGe3EXmVaK1Np3QktPfA72TMnfu2GKjhbNN04hqwp
 MfVLVMQBF1kaLIqLessFl5O3DoaER4lK99tuys5TM/8uYAnM4h+21E51yRE1B3woNruxlRLxcIV
 l
X-Gm-Gg: ASbGncugJ2Va8x7142D7No1k9IOFpOLRryRe8BzYQL7v7nXrC2D59YZvK97gqcHHIux
 ieQUElp06elpM45MRk5T9FxS3uF2gGdwfpSCdpweJmxYWIk0uFog5yUyaptNQYiRNarstGZkuXO
 Nr4H14nICIbE9eQDXVCqN6FvV3GHoDr5s2UqIRtq43ywSaOnHoBLCY2dtVDtu210qj9nxxMnPhV
 LqNL4TJc1VKK4/3ms4ZlsN2aeuGrUcbguZJneDa4OrqorZ4eQ93evFtEH9gcnOjow7QRIxf2wXa
 pN1oHNULcNnOFMzK2vqeDtZsq3ES+f19/XSLax6qhOrXRsNtzd+4BdY=
X-Google-Smtp-Source: AGHT+IHPU4uchBIGiRjkJmhVeK2EhQ4Ui7xYBT+ie5zJXI7wvII1DZ8qGB//kHUIjROeSaKjFRMo2A==
X-Received: by 2002:a17:90b:3e47:b0:2f4:4500:bb4d with SMTP id
 98e67ed59e1d1-3030fec4e66mr25832284a91.20.1742878774134; 
 Mon, 24 Mar 2025 21:59:34 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 13/29] exec/cpu-all: remove cpu include
Date: Mon, 24 Mar 2025 21:58:58 -0700
Message-Id: <20250325045915.994760-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

Now we made sure important defines are included using their direct
path, we can remove cpu.h from cpu-all.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 accel/tcg/cpu-exec.c   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d4d05d82315..da8f5dd10c5 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,6 +21,4 @@
 
 #include "exec/cpu-common.h"
 
-#include "cpu.h"
-
 #endif /* CPU_ALL_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 207416e0212..813113c51ea 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -36,6 +36,7 @@
 #include "exec/log.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-all.h"
+#include "cpu.h"
 #include "exec/icount.h"
 #include "exec/replay-core.h"
 #include "system/tcg.h"
-- 
2.39.5


