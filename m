Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E33AEF99C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxJe-0006ND-KP; Fri, 13 Feb 2026 12:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJc-0006M2-G9
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:52 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJb-0006F8-2q
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:52 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-436263e31abso1123244f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771005049; x=1771609849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0+uh7YmJRy4d+3ZUUskUmrjdGP/UXOy132eI02Y5GA=;
 b=J5Wt4lyTW3xHvlnU81esAB/nPrrpewsBwjidNEPXZ2bk4L/CvEZ80TSZqSFRVNyDNJ
 D/9uEf5kLdoTZFbqdIY538B5A2gPo9AqZHBP0WkiYy7aMF+HDmhi1NxQrx5fv5EGwkCL
 XXtjYrrB8fJcq3/+2gyYhLySl5M0sNq1VoEnQSkmPm2Fmp8IOFOEbwwUrvZU35NdLmIt
 N4v6kY7fDMXnPSXzVkYZDMofLJks9msP5vZfGDfECb06friS92P2kLTuqddPwWtU87fm
 D8E6ICrsTOospPjrFhc9u8I+iZyT7rbABIO9F7CWLEVVq7LJItDTV3i84TEyEiD3BL/y
 Ctdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005049; x=1771609849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p0+uh7YmJRy4d+3ZUUskUmrjdGP/UXOy132eI02Y5GA=;
 b=Sd7MNEYhaxju69rPbAUvimSlBIO7ugG4zISq+0QSMBqHkACBPcn8VD4yedmKwNq9SE
 ALNdpU1Xrif3RM2stwbvS4o4mrdPXnVPzqzw0Y2o7Fmb9dw8my5AiycMb/rbK+8CKB3T
 TjHZMSsfVszfkMD/C5GBaLVRh0msH1QsN6Ri/9JCV/nEU5Wkn6sRq1fe1kxGm7SnihPN
 rR8EXBb290W+txWOyLwRdqAOsX8bj+/OS3ethtTo9vur9R4tEOaYw3bArA8NnaxWl552
 O+7el19FJ5f7N60O7KYW1Xk/gv0BIx+upQepiPN2pzrw79/9i/jVrjjLWMjMmzq5InRX
 Vifg==
X-Gm-Message-State: AOJu0Yw8JuVd7gdG6iqMn7fEmj0xl5cS6KoG2MwEREMC6Uy7bT0rk3WC
 oKmHN9/qm0A1+4AktMb5a+USWe4UH4diFMZ3YayP+AJ/687Qfn9dipSQNGdcXX/uqqaGhCW0LA8
 OlJELH4c=
X-Gm-Gg: AZuq6aIrrkG0945M/j82LFQM8shaozhNFxfwWwquYq9676wstqH0Bj7IxTx67XWG74q
 3ulDnqMtJV+vh2/qgmnB+LoSI+C3joD/RzjUDQz70sKT/qUKroNSvBtmqrMDvIFPi/wOrFas7jE
 cBvlsPqj+qnVPOUbkLbc9obbZOwt/I8JpzSqMxJpoLjEXTIXbezvfAB/nfngrlm6fthaUo3b6wq
 WUfWrW+/9LK2zhtCMh4hNazHlLQ/fDeMaJLukbupKHpfj0zfz0gTWkCNsumvDuC3fgnctYPwYbC
 dhoAtg7J2HrJT0SuXGn6DRO56odKXR/of3RIO9li3nfbw71WcQPjd64Re3WQuCiQ8Atvwg/9RyR
 J9Kbfj/AVzQfGP12uYxQ6xtE6fWlgSiZeEGI+vZPGIydl/NfRKQmGXlWYNwjD0jKobFONcYBbHi
 HRyppvAX0HEa4BoIm7c2+d4jaeKZTVJp2WR7hu/gr7dW+fOPQbaQnbs9gzvEy9+c7IkZFMeI2R
X-Received: by 2002:a05:6000:2881:b0:437:6e55:a740 with SMTP id
 ffacd0b85a97d-437978e32b3mr5250061f8f.28.1771005049240; 
 Fri, 13 Feb 2026 09:50:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abe3b3sm8755776f8f.18.2026.02.13.09.50.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:50:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 2/5] qemu/target_info: Add target_s390x() helper
Date: Fri, 13 Feb 2026 18:50:29 +0100
Message-ID: <20260213175032.32121-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213175032.32121-1-philmd@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Add a helper to distinct whether the binary is targetting
S390x or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index e3287334304..23c997de541 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -92,4 +92,11 @@ bool target_ppc(void);
  */
 bool target_ppc64(void);
 
+/**
+ * target_s390x:
+ *
+ * Returns whether the target architecture is S390x.
+ */
+bool target_s390x(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index a26532f660f..28c458fc7a7 100644
--- a/target-info.c
+++ b/target-info.c
@@ -88,3 +88,8 @@ bool target_ppc64(void)
 {
     return target_arch() == SYS_EMU_TARGET_PPC64;
 }
+
+bool target_s390x(void)
+{
+    return target_arch() == SYS_EMU_TARGET_S390X;
+}
-- 
2.52.0


