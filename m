Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E283EB1043
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubN-0007OE-OK; Tue, 10 Mar 2026 06:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubM-0007Mv-Ax
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubK-0005sC-Ng
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so14918465e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139569; x=1773744369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ADnbZuhLO1Afcl1KkyrG1KqMNO/xTB7IWOHNNOxfuN0=;
 b=WpirCggqrrEONSpsc9Jc56xZ7TGNRCcyk8JORVEpquaKKoVePTqPJ/6ujut8jIHU7y
 SuDmAudcfnGiJG0nCEPXKEjjAGscJ5hXEqfAMB3i7/+d7iXDW5MrL4DUKQ2HUlGm0sOn
 spsp1MhmaxtRC+zHZR4eVMhjssNfVSyIOgjegzv2n9zkZOc77mMlqv4HRtp9d1mpJddT
 ISOWr+NskyTP9oWO7CxcAopt8WshRaeBw2skJUUatUlvEkKr8uW7lLmGTeleeKJ1rzOr
 bIKH23U3YuJPB6CsRWl3eP2J/exk5zhWMl716z8RAlqIJgE9cxkGY4sw4eYa2cVQ/FXq
 2Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139569; x=1773744369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ADnbZuhLO1Afcl1KkyrG1KqMNO/xTB7IWOHNNOxfuN0=;
 b=thmpA4m2f1z+/c4Hp+eGD/O2kTjHOqz6IfO+G1XsLxeL54IqnpeZ/ey9G6aW1IJvPm
 KIboJYwT37zN8iJ0B/zi1ZsOOeXEgTLkBpAk8gS7/R35xvWepnaHSF0Ufzno7x1h9/hK
 uUQWW+aXRr22uoDRAQhTOvPMzJENhQ7DTdkQ6v92VayDGgyINjkwh+mV/wcKkJiBsdwB
 3yls/0gve5xWIRprTZofgHXs8fyJJLXf+kWs/r1Uz07MWFq2UHWqDCNXPFnrDgEniCJG
 VZ9/0bDHHsK7bx4LjXsy6z0wM55K9rG6Oo9dsNyjlWfM8pVInG2YMuw1Lz6epULMP9hx
 87vw==
X-Gm-Message-State: AOJu0Yw5VWOY3x85qtuHH9SQ2MR2eMI0y4NuMXh6chz7dIps5Iy0wB+3
 nnG2KjTZx2etFbCNQI3R1O4h5g2auC0L4PAsVRI/yQI/4BYkR/20lB4pi2tXvqtMrSYj5WI8pXX
 DktuemIo=
X-Gm-Gg: ATEYQzzwwnik4W+TUI86+HRCqUOT9ak23RygvnqLhmTSHZ4Nd6f9tjT0h12C7Eh1HOW
 3J6pYihNIJz3s3FJN9NcanNHGeCWx/hyCxoe4z3l6izQOfbtKcfO/z/OI1CSrEt3Q0hzEiMolvr
 eUCEfjOaB3h/tFV/FbmxkycJdnGekQKltCymEq1BaWMfkrenjBBvXf6rSaaBy+iozO71+CXwG7D
 YbntZ2Hix+vEg/RyxlBoz5wQIziI3EhVZ5na5sUdbEZHxIinC4oTEbgONTFXUuWlCqxTOO4GrJq
 GOtaF1cawW6/YRqG0kk4cBsh1QNGBFMWJS23qxZjiOeyO0A5aBHJofYCH16fUGCRFTVtxqbwNaF
 JnpWsKC3ccijdhskkVJAvu119eiIqiOD84IsB7Hq1ulOIPdSUZhbLXaDxe1VI/amHn03WTVFTb+
 mTAZqq/1jCZa8AvFrBIR0e5iyNI6ER3vgdla1q5wjqBQMZIdBr7t2WYsz/twRL4GtPkvLFU4Xm
X-Received: by 2002:a05:600c:1e88:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-4852690f599mr265637965e9.7.1773139568821; 
 Tue, 10 Mar 2026 03:46:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48531818b5asm128216735e9.3.2026.03.10.03.46.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] target/hppa: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Date: Tue, 10 Mar 2026 11:45:03 +0100
Message-ID: <20260310104511.12670-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The HPPA target is a 64-bit one, so tcg_global_mem_new()
expands to tcg_global_mem_new_i64(). Use the latter which
is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260205212914.10382-1-philmd@linaro.org>
---
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0f8a66f7732..70c20c00377 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -307,9 +307,9 @@ void hppa_translate_init(void)
 
     cpu_gr[0] = NULL;
     for (i = 1; i < 32; i++) {
-        cpu_gr[i] = tcg_global_mem_new(tcg_env,
-                                       offsetof(CPUHPPAState, gr[i]),
-                                       gr_names[i]);
+        cpu_gr[i] = tcg_global_mem_new_i64(tcg_env,
+                                           offsetof(CPUHPPAState, gr[i]),
+                                           gr_names[i]);
     }
     for (i = 0; i < 4; i++) {
         cpu_sr[i] = tcg_global_mem_new_i64(tcg_env,
@@ -322,7 +322,7 @@ void hppa_translate_init(void)
 
     for (i = 0; i < ARRAY_SIZE(vars); ++i) {
         const GlobalVar *v = &vars[i];
-        *v->var = tcg_global_mem_new(tcg_env, v->ofs, v->name);
+        *v->var = tcg_global_mem_new_i64(tcg_env, v->ofs, v->name);
     }
 
     cpu_psw_xb = tcg_global_mem_new_i32(tcg_env,
-- 
2.53.0


