Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43129EB104B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubr-0008B2-5W; Tue, 10 Mar 2026 06:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubn-0007yP-6X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubl-0005ux-Di
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso11049895e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139595; x=1773744395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fr3NyAUolqOYYPj/CXrK8V2pM1QmPg3oIcr4E743MsA=;
 b=v0HzjH1osPZQaLhW+mMtkRBDtJH3o8Pb6Vnoqq+u/8VLx3OWKAW4FJrHif6rB2UFww
 W4zV5ziXHZzeddG5+Hx+KOk/CuTKEcvRgJFZ1QhesmvB20PcB2nXQNbz4XTD5gY32G+y
 JYuSDctfekzlptoWd8m9686AduPOrawQhky0Z05eUGC+gjRBSPeAz+xeOJiUkEQyEU4M
 J3J0G/UdtM2xXM6GwwIdNeBpS/MuH33Sr97qlHm8RHKmCPTcveVO/s8oVYlKU6VXms+K
 cE2n/DFJc65i7IDxsmyWt1KfmxGq7//5/phdu7+Ji2uqI33ITWCvhObth3sR3/A9MTwl
 RUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139595; x=1773744395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fr3NyAUolqOYYPj/CXrK8V2pM1QmPg3oIcr4E743MsA=;
 b=wVZIIlaGTRmy6+ShbF8++OtMZhSkiftBAGLMYBwGy6PPm9gewEIxClmK6oW8dsABym
 +Y3kHOroJrgZGDnpjdUY0EZhU61SSl7rFju3dwSTdIxSQmhpgX5a6gF2x686kc2G4mtV
 xwTv1rzZ/ISi4mN7e8rDJ/sFjkB0j0n48HAEjcz20M95sUusSuy8MbTNhdy8ZQUr2Zmg
 /soTbTL6xexp1ZsEvOgQyYVlC0lL+oBZ62u5oYLtzO/mJnNmfcYbA2zFHZMp3JuC0kIC
 MaBI4J9ufdOgIlHUWQhOfkYFovgyExkqJ5vEFqt22rFudN76Q2bX4jGGa0U5K998Kezy
 8UnQ==
X-Gm-Message-State: AOJu0YylnLmm1Iw3lLPkWaHeLlS8QAr8+cutfaiRUaTpRi9AK3P2cuVB
 izYMRkEQpVaNlNTaSzGyZmHJi5Ln0NanUqRun8uU1nywM9ilR890RWEH6RT82ARDYnXXX/TU51/
 +kFtdCYY=
X-Gm-Gg: ATEYQzyAEUkfUakulVacV9LjOFQusF/BjqmJNt1xJvy2rSsJUk19bujCo9DLTdBdZBP
 lYplj/yD844JWYRgKQalsnUNzvC2ZeZxiD2hvQq5M8Ypq2YvJ2WZimTHok2jSP+VISHNfiYAGAt
 srXvFL6BWQsLzQfyMjhfiChGUn6+F3yHC2bNEV8Za1W8jWAQPSxy671Vf9BqoEvtt2Oin4qvrSs
 fHUbTL1MrFz7eIDl7/tzu1fWdilDfXlQQB8xBkREDESECYFFefkoq6Fj3mMv0xzqTGe3jKttsHd
 Zws+SZ8alvAKtnWaslGSQWBJpXIpLO7lI669qoB8cP696HDpx7+r791kCBxuYuOqAJqFdQ2YK15
 pb+nZxuL2b2n4+kTY5k+VdBGzniZIGChvDEMwPUy7W341dxEUFCdFvUV/knnqDifP4UjvXM1Az9
 7xE92a+vrdnL8GtJ741H9dxet9KQNKUGw1qm90YYDtlaNAB0MCyjDOmba8odtEYWQJPd9oat3f
X-Received: by 2002:a05:600d:108:10b0:485:4552:8fbb with SMTP id
 5b1f17b1804b1-4854552922dmr14898125e9.22.1773139595467; 
 Tue, 10 Mar 2026 03:46:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a6bb86sm62654675e9.1.2026.03.10.03.46.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] accel/mshv: Forward-declare mshv_root_hvcall structure
Date: Tue, 10 Mar 2026 11:45:07 +0100
Message-ID: <20260310104511.12670-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Forward-declare the target-specific mshv_root_hvcall structure
in order to keep 'system/mshv_int.h' target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225051303.91614-3-philmd@linaro.org>
---
 include/system/mshv_int.h | 5 ++---
 accel/mshv/mshv-all.c     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index ad4d001c3cd..35386c422fa 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -96,9 +96,8 @@ void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_post_init_vm(int vm_fd);
 
-#if defined COMPILING_PER_TARGET && defined CONFIG_MSHV_IS_POSSIBLE
-int mshv_hvcall(int fd, const struct mshv_root_hvcall *args);
-#endif
+typedef struct mshv_root_hvcall mshv_root_hvcall;
+int mshv_hvcall(int fd, const mshv_root_hvcall *args);
 
 /* memory */
 typedef struct MshvMemoryRegion {
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index ddc4c18cba4..d4cc7f53715 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -381,7 +381,7 @@ static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
     }
 }
 
-int mshv_hvcall(int fd, const struct mshv_root_hvcall *args)
+int mshv_hvcall(int fd, const mshv_root_hvcall *args)
 {
     int ret = 0;
 
-- 
2.53.0


