Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912D7E92FE3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaM9c-0001ql-1k; Mon, 29 Dec 2025 17:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9K-0001nK-K5
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9I-0001CA-FI
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso42243515e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048935; x=1767653735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Glk6odzhkf8FIU+Nc5kkfY3vO4Zh5tzcQ51PDqT1zWg=;
 b=Kz0u0hB+D/+w/II0J6S8vRRhkTPVk0cc4R19W1OBYbbayEzpiLxUVps9xwabjG2Hws
 9prvQEeo/healIAJyFveHLUVSvifDhtNj+JPgR3LJbe5R7aiHNQxhcQEXlpFB7l4Lofi
 vGE7VxY4i8jivCbLJNzpoLXOYKvyaCf2dCOmJJYwg314pLi97Jak/eL0nBFxFp87DcQu
 dzz9/ugU1/C3T/FOjJCR6xCm7v4aF0OmTSPetQ7YD+dNOIeTq4nSf5sEUuxqrdlX3+NP
 fGwmGW/YUOy4EnkEbW2X+zx5dB2XBYUfmlEXAPC8CgvWNJ9U7w25we1FYLx62RY0d7Tc
 ZTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048935; x=1767653735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Glk6odzhkf8FIU+Nc5kkfY3vO4Zh5tzcQ51PDqT1zWg=;
 b=NABdhs/DKuso8Qv+LLkyYBM/BCfL1mZVH/7SbuS55TNBIZGKB1Q5wrYagql32N+0Jr
 dZULp9J9sazbUvfHJYmVuDIj5ZAgWeN3RW5Mv6yn1nZ+L5BvcN4nFKwbX+DuvxcqOZXY
 qP63mX+VGi9wvf9yD7ht1EWvUChX7h/l9W1yyrByzKZFPxKkYjRvpVVLR9+D77V/aJ/l
 0aS1T+5sIasrdgp4KDIBMiY2Z8TpfrEhQOQUSvoH0xfZ32fnw8YTiHX99cj7yTtwN2lM
 9cIpz6kEAB7aBIEtDvKPBkqYxgdOdPNaHpyE/nwvELx/prPLVl36gLy2PffS4c2E8nQ6
 LOMw==
X-Gm-Message-State: AOJu0YzoXUPlcf1HblIU2h6y+hVPZnBAck/3yfJYVOk4uERWEbE1GzPg
 LEwvakGcB0DkvVnEC7SKmdvHC8G11em8zwdHtO0TiZZxX6w0MPa6mLMguYVuQyV5riLkMSM9hSL
 zpSi5hww=
X-Gm-Gg: AY/fxX7acD1N7/TKHwNgUTD3Aes/l6v5Aw9CO/6Wvt4TiRaKRcDyoL1aoIsGyav2FJ3
 JiagQpaeQA7B7ITkOKbmg2x3lNipz1H0BhzNBbjxuyJyipfgHe6TlcdRjPw2GSsWZ2nRr3bhZf7
 XbKkSGWXNjKRJIhBEf8peFBpezSwgolOUMluK8rWflG+yiMnAoa4yNCfkkv0BmQgtgZwciNg//k
 PPm/Y2ApuZOY9qvNkSamT4X8l42Auin3jJpQtY/jUI0jyyUrv26d/HRBwT3hNRDLAvZ9Kn392mn
 aZOmgOtvx/YsGsGsJtU2KJA8UPYvW1xsZ3nQ6bCycO+VpwIw4FCtE3Ux0FOH0GzOBp58vyzPzbr
 zCeAJMPWS0vz65P/X2tzqVhOlXpKJV0ju8OROFpqCbupL2MaKhN+AlGMdNldNKcpysq/ZOc2And
 9q+alHTKc3XDIF/EHog0gySF31gxw3RcaZz+eRp2mMzwQrouE0Zc6eiF2rtcYo
X-Google-Smtp-Source: AGHT+IE79kgEV5zar5H3aht2o2vhy2vyFf2iePal8Z4TaH3FlhNBkWhyTPI1CWm3MtIMCjKtntRXZg==
X-Received: by 2002:a05:600c:8588:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-47d19975bb7mr297624305e9.30.1767048934646; 
 Mon, 29 Dec 2025 14:55:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbc0bsm575887955e9.11.2025.12.29.14.55.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 14:55:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/5] target/hppa: Remove unnecessary @cpu variable by using
 cpu_env()
Date: Mon, 29 Dec 2025 23:55:14 +0100
Message-ID: <20251229225517.45078-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229225517.45078-1-philmd@linaro.org>
References: <20251229225517.45078-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Partly revert changes introduced by commit b2c2d00f48c ("target/hppa:
add 64 bit support to gdbstub"), restoring the cpu_env() call and
removing the unused @cpu argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/gdbstub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 777f4a48b99..0c5e41410a0 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -33,8 +33,7 @@ static int hppa_reg_size(CPUHPPAState *env)
 
 int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     target_ulong val;
 
     if (n >= hppa_num_regs(env)) {
@@ -162,8 +161,7 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     target_ulong val;
 
     if (n >= hppa_num_regs(env)) {
-- 
2.52.0


