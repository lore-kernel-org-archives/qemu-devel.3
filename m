Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878F2C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5H-0006GV-Sw; Wed, 07 May 2025 17:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4z-0006DG-FT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:27 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4x-0006Fw-8L
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:25 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso400701b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652402; x=1747257202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qH2OoJWwqiQyZOMZJFsx9bUBclHaoHUtvvMOgxzsEc=;
 b=XJB4P5btO62BTqI9teJrJ/6lr9oku+5EQW9Dpsqa+vuzflJyBA3PG/+EdxVagqxiT9
 LMDi7XAkv2k+YVTQFAkTp5j/WYAGBusoz303HuhG6QtplD+xy0E32oTk+vLNGK3J24tm
 yE/blxgTTjHUzL82sCw6Z3Z/TpahOSVD2Ygye8f/4Nf01qk1Awfi2/gOXtuS8A3dB7YN
 XsfNL8+F7cn3cC7R/N2GhxrDUEgs1QVu3BlD+f+nO+E5ryf/GOLGrB/D+Ya23KeosLVZ
 /19XP7OCoDYSPWgdsohkMO+BrWKEodD+eLIE6n8gqauhPUR2Xpd+9lVoIOws/PpbjMzK
 xwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652402; x=1747257202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qH2OoJWwqiQyZOMZJFsx9bUBclHaoHUtvvMOgxzsEc=;
 b=ZvtY2A3JJyRqkd+aRa7PEeLv2eIyZy+Yzgk9w1hJVwiDuNufQNrioeZ9ZyEMWTHXba
 TP52BhfbPwBBhB2f8usuDHRMA8gFcXNfLR+cZWNXjcNs0R6/JviVwUCNjDovafFYIvpv
 waHPhu4QBkbNkJkmdgtlr29OEj9XVrfi7unOMU7ZHfGE05zRAY5cNTa6AV12rdK5wRiT
 6x+Bj7vQYAjCHfWNcU7tOfzj7bQksaGUlAVA49M++tyYW1AsiDgO5l6Pqg8Y92SbkO0j
 TerJAyn3dSRLmWiaKGpvPQdXFW9kXCq4FjO7TAxs7IXtWzAk8E4eAjFyWAm/0My6SdBL
 LnFA==
X-Gm-Message-State: AOJu0YzswMp/wevYbqJ+7maYlM+OsJJKp2o2lfO3xhzjhtwAIPHjAMo+
 LtVZsxrwkwLUUPk1sf2bnnv5b8trxDyDBV5wp6t1vItdd9Dg8KE1Gho/hiLMzJS1IK9frki6cae
 C
X-Gm-Gg: ASbGncuZNX2wblaRiTOHqVtSdVfFCKvWvrayCLOFlA9QmEzaxSkkLRewhzA57qBA2AK
 kkztlDVxmEcZRXKj1kIE7KRBAqc5gMVzOJnVuqDYr6arFdGXC7r/79aJ63Qx4rpwcx0+FT2mXfz
 LHI941AtEODMjY/wv7KKet5rs7XjrcQvP+009WA+qY0r8beAHlumwvmXqFvTqC8PONICw3c49oj
 thXq7Rvbks6yqd7JMTmmm5ZZDJt500NyUdz3CXvz1Xe92Lf9wXkdprR9LdRAZ9Gp75nEchFDC0b
 lbtVEYSP069cVgerct7ZpoLTLsd+4hFg3SrCP8u5olBts+s8LNiMblUZpIM7/xqzdeLXMMoWXHw
 =
X-Google-Smtp-Source: AGHT+IHe6Uv833qqzK6LFPYyYRM4d1FYrLUeblJzcSsZgD4VPHcD5QP0bQiT03M9pm/ksmbbOPFcJw==
X-Received: by 2002:a05:6a00:35cc:b0:736:b3cb:5db with SMTP id
 d2e1a72fcca58-740a94f8e34mr1559406b3a.11.1746652401882; 
 Wed, 07 May 2025 14:13:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 23/24] target/m68k: Make vmstate variables static
Date: Wed,  7 May 2025 14:12:58 -0700
Message-ID: <20250507211300.9735-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

These need not be exported beyond cpu.c.
Fix a typo in vmstate_fpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 866d32fc9f..fe53572542 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -478,7 +478,7 @@ static int fpu_post_load(void *opaque, int version)
     return 0;
 }
 
-const VMStateDescription vmmstate_fpu = {
+static const VMStateDescription vmstate_fpu = {
     .name = "cpu/fpu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -500,7 +500,7 @@ static bool cf_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_CF_ISA_A);
 }
 
-const VMStateDescription vmstate_cf_spregs = {
+static const VMStateDescription vmstate_cf_spregs = {
     .name = "cpu/cf_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -522,7 +522,7 @@ static bool cpu_68040_mmu_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_mmu = {
+static const VMStateDescription vmstate_68040_mmu = {
     .name = "cpu/68040_mmu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -547,7 +547,7 @@ static bool cpu_68040_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_spregs = {
+static const VMStateDescription vmstate_68040_spregs = {
     .name = "cpu/68040_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -583,7 +583,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-        &vmmstate_fpu,
+        &vmstate_fpu,
         &vmstate_cf_spregs,
         &vmstate_68040_mmu,
         &vmstate_68040_spregs,
-- 
2.43.0


