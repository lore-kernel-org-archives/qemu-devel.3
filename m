Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D31C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWG9-0003G6-HB; Wed, 13 Mar 2024 17:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFh-0002zq-RU
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:35:11 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFe-0007vA-Ka
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:35:08 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-512b3b04995so356662e87.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365702; x=1710970502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31zF++x+VQQo9AGiWpkgP+Ino/mHE/CG+2PFzlMwNbU=;
 b=caRXtBOgrpTqofTa/j3KCP/pkng1SKpnNsH0MQBM16qEINRXAGyrdN24Sv9teBLA/S
 mKkrXWaAPkWRaVsYcd/cewdxFcF2wf1p5yWEbb2C7g3GLzW8rXxbwxQRgYAHD0fGn158
 lxfKlohGsMfXAXtOvwsGwlfTqkhikddraZT79sESyfBZL0OMbsEE62phcZMgUGVIj57+
 N5d22tWLtFB0uFKXWb5kG55yvrTj+Q/K7f07DsI3fjuAShCMVB/fEKO+Jww9VSMbzJ3f
 QRir78/YEzT0tj2YScwEO/JBNIkXLX/BziQJlhnuwPLkhLaMEUkx8y0w0p6e/FfXNvm3
 eFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365702; x=1710970502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31zF++x+VQQo9AGiWpkgP+Ino/mHE/CG+2PFzlMwNbU=;
 b=EcMvvo1KVf4Qp5QfTp/5H5wbjLACrE8mBd0vX0zXoP1skX4tVzf2NwwAwEFBJt6Ff4
 3KgU/qIZjJJdK6kYygbvvb74BzAHNVt/Kt9Z9a0iV/u+v6ATDp3C8AHbovAZOxw8/5Pz
 chv0oz0/yNVvlC3QfYAoJ65c+00Hzxq1YpVeOyJOIbZ9yp15STkKerxF3xihG9LbQWnE
 bbk8oarxOdnpb38zGMuG64n3Ve3qPwG/0iHXQw9h9GT0ZSsN68XjBwM6qEU5akpU518P
 JftLn6f396alwW3Zy1oS4gx5xyvG6TgHQm9hqgho0k3O2Z1TZcIspJywZRARjN5tzUID
 lszg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxL77DsgbLbHZwFNbPyAwVVZ3nKBfN3E8OwzzkNnXmRNBaSs3ekG+kCd7xVANVONq/FpJaqOBXUrvfR3iKgERq8p7X68U=
X-Gm-Message-State: AOJu0YwteM/z8IpJrjnSInarM9SYTJSgm139TouYvARaGk4MmbFg8WiZ
 6UTHsB3qGTmzuNq3LYYPjD1HTVsttDThXOI29tMQz7eFrsLO3zSt1grS8N6b1Wo=
X-Google-Smtp-Source: AGHT+IENjgTkbDmHD4odtigZZx9um4s4oV9gcrnu6fxYPuVirjtadiYvHnfHzFN/KbHI2xdwYfBEeA==
X-Received: by 2002:ac2:59c3:0:b0:513:c826:c25f with SMTP id
 x3-20020ac259c3000000b00513c826c25fmr2090451lfn.2.1710365701890; 
 Wed, 13 Mar 2024 14:35:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c4f9400b00412f8bf2d82sm3467209wmq.28.2024.03.13.14.35.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:35:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.1 12/12] exec/poison: Poison CONFIG_SOFTMMU again
Date: Wed, 13 Mar 2024 22:33:39 +0100
Message-ID: <20240313213339.82071-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now that the confusion around SOFTMMU vs SYSTEM emulation
was clarified, we can restore the CONFIG_SOFTMMU poison
pragma.

This reverts commit d31b84041d4353ef310ffde23c87b78c2aa32ead
("exec/poison: Do not poison CONFIG_SOFTMMU").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/poison.h         | 1 +
 scripts/make-config-poison.sh | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 1ea5633eb3..fbec710f6c 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -84,6 +84,7 @@
 #pragma GCC poison CONFIG_HVF
 #pragma GCC poison CONFIG_LINUX_USER
 #pragma GCC poison CONFIG_KVM
+#pragma GCC poison CONFIG_SOFTMMU
 #pragma GCC poison CONFIG_WHPX
 #pragma GCC poison CONFIG_XEN
 
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 2b36907e23..6ef5580f84 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -9,7 +9,6 @@ fi
 exec sed -n \
   -e' /CONFIG_TCG/d' \
   -e '/CONFIG_USER_ONLY/d' \
-  -e '/CONFIG_SOFTMMU/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.41.0


