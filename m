Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB7FC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNhe-0006Wr-GX; Mon, 27 Jan 2025 06:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhb-0006Ud-O7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:51 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhZ-0006uk-Bl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:51 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so3819358f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978887; x=1738583687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0D0mBXBaLsDF4AjforVcC1QF9ut0pEK5UwN8hfEmGYc=;
 b=QlM9Fqn35rwC3hu59u9W0a5gJXM2fG3GboadZGAnC9qdmI7ahjeiAeMvXJpmU1G5eT
 yugwBkgwBUXIEStfxUrbBDizoL66xfhM1A2buDj008zOT9+78imocxebGASOKde+8WzN
 Mcyn//1Kg/7fQZQl9KfAvIAbinTV0hmKBaKS6TieY1HrbDH801P9AwdIfCOAe2D/AXlc
 4vK3i8XG+mkOir2pGes9viqGbR0QJb6K2bXtYnQUYi+WQ4LWEQFQy3a8vd/GOxMMYA5u
 68Z6gygGQyi/03PR0hAWi+17j62272dohX2F0qtgvEEtyB/vDzX3zUCsVKp+Bef0u5DM
 iMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978887; x=1738583687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0D0mBXBaLsDF4AjforVcC1QF9ut0pEK5UwN8hfEmGYc=;
 b=dDa+zJcPPqDL6KK/okunXzNidxQH+ImLWEGzNmzoeewkGIfNUXtKorbY9ENGgeu6sH
 DH47Dg/g55UXFYcS8ec5xL4F/aR0Xd4+z1nmdpZkfopHMVmAyRaYpDWBnX3OgwMZhuK4
 K+cGL2nZwbmvwkXy29XdPxbFIMy4BtyU07enPTo36i9Irqu6j40OqhS+k5KCSrhELxpJ
 7rZppZENFlO0xiyVHFM+YbbtYvqk6OUr1ByQc2cXvAXXttsbYAlAIIo8fJYHsPGuvIxf
 9PrqqmE1GfK192gXWDfBExV3ywl5E/VLYKQhWzBuiEHFIWTd8xGYnbek51XmVgSo2pc9
 n1QQ==
X-Gm-Message-State: AOJu0YxrOnMl6i1UBwxNDHUelu2pbrN3N9lXPHqJQ140LAG8GYrTDEKW
 BM4HpXDchHOE69dc7iwa+2YD1T+Ukz45ZFf/+iELfaZAfSSD1/bGjHrM2s0zGxVonAO/pwOvngv
 +Bko=
X-Gm-Gg: ASbGncu8ZAVj9qAPug/LZPJ4ub3OrgIPY/ym0p9QpRWFIUGFDYqcYi5XbRFIZGEYa8R
 m/zOCE5MSR2QzKPngUzlZ8aURlv02TWRnFaDe81tVbn48Y0WvCGLsM5TiUjyQgIiPuagEaAkogb
 RNtYyYQz6ueUyasCeeA+YciGARX9Q/wXQbWPgg3iP7qNQfCliuc49yJVRPiBin0Hlr1+l3rKYoB
 GqGc4YAw76MAP9V9SqmJ7Num7OTyjMZoF13L5m5XZ4S4XTRMbkG0Dzft60jXVBdNj8PYggSEG4W
 54uHJHMMtBTEeVFyjO/7X+QtsiArwVb87FpaDTdiWNqLzvlIgJttGcg=
X-Google-Smtp-Source: AGHT+IGPQFkUiA7e3qJST4WmTjeM+k06Yc2GvTtVflUzG9dWKVdEwTse05E8oxwLqW6eaJSSfEh1TQ==
X-Received: by 2002:a05:6000:2af:b0:38c:3eab:2e17 with SMTP id
 ffacd0b85a97d-38c3eab2fd7mr3370033f8f.2.1737978887560; 
 Mon, 27 Jan 2025 03:54:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188928sm10794589f8f.45.2025.01.27.03.54.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:54:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/10] target/microblaze: Set disassemble_info::endian value
 in disas_set_info
Date: Mon, 27 Jan 2025 12:54:20 +0100
Message-ID: <20250127115426.51355-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 13d194cef88..7603d2e8f73 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -224,6 +224,11 @@ static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
+#if TARGET_BIG_ENDIAN
+    info->endian = BFD_ENDIAN_BIG;
+#else
+    info->endian = BFD_ENDIAN_LITTLE;
+#endif
 }
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.1


