Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21332C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpj-0005IW-E3; Sun, 09 Mar 2025 13:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpg-0005I8-Hy
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpe-0004sB-IX
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso1847821f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542776; x=1742147576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nnG7evLaW4FN2zMyzjZlPjb99X8Ma3vdFtseYLpz0k8=;
 b=JZWCB/uYXMBmkGNheWQ8MzuRERAx6+7kXONLJ0hdzH7brdp7ku8qYiuYZGkU6jkQTU
 ZYtN+9hqft7osCbiLeUegtEd2IkD73sGhoR7HQzkr3x81Y/1QhvkOMyvCWT805xtIrJj
 Ng0sNB9WRT4NfX8Ik/x3lLFJnh/WD0luseyMH7FaK5meZDIHhOQg71Ec5OGUEEkZ1KqM
 Zq+3B3j2LJhRo16/0w2RlLcxp4ZS/ZVn3LTzS8KiBgF8b3wMpLJSjAwq343ikGCCcDb2
 b++ZsvK22nA0EX0XExnDPOIflBJF9K34O+M7zobJ5UeXVTJ9jRgEA0NAU9pWX8Jd5nm3
 yJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542776; x=1742147576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nnG7evLaW4FN2zMyzjZlPjb99X8Ma3vdFtseYLpz0k8=;
 b=TyRuXfUGF2Zd+LcWzI+ChnvOMOAC2wxVE9grEd4LIlx/hQw1PCy0Bl8ocj9yG9vixO
 5bnofZKlWLafBXciUk+BgyrQ9zcfl7NL7RjocHVR1xNr5JgMj0h+zmSc+8p4+LmVNtiD
 IOkyQkGFtEDCyxLu30SBiV+/glbtKxTaBblx7kuU9wluIY/dp5SU11LCWAo00lXoL/pQ
 x7eJqzdvc9eMusmSKTUvT5XNii+nOELyxruQ0wgIcTkcLPowSiqLNOpMgmBhIZR0f3Zv
 Kl70Fzxefbx7rZdzmZdatv8bwDCbyIN/bqPL3YWF2Md17ZERShDR/h4M24jWSeJcfql1
 6K2Q==
X-Gm-Message-State: AOJu0YyibPnV1JoSRCTRQ57I1GFJ2wB/YwoeyGm0n8W/X2qQSGlBBcFn
 hvByTBZOMqFqJYT/2oTHYbkKZUH4E4fYhWkXngQSXKqKE6RpfASAzN44kEvGbtmnqyjbyUWDOwe
 kQiE=
X-Gm-Gg: ASbGnctXJI56c4vpjnicYu7hoXYN63qRk+MZZp2rquPOFEhlInLHgu8A3TXycu6XWSf
 wLtN6JpZNAtfoA8beGGwrw/8s8shFxjYhj2Sr4trRxdXc4s2sjtR4Jt7p3p9bgL4rXTGMVu3A7/
 ZJeI/JgS/h2RO6WkI1wBmjDa9sTPY4HDyShngfFU5QJy7ywJ+SrQYUbcrJphanP/Bpuh/DYXsnT
 i1HXo/5SkaZOQWxtnMwWhw71YdtvNqfminDT8LhW46x5xeY0SszjfMDp1Hnlla8vj9aT+zzxeli
 NRc/Bt7Iiwo5DXpmwRYL9uvUIpeCrjk47lxNWTK0pjmBtWfT2kerKCA1knPd0AiQpxXeZk1CENK
 XVKlvTSe5nCv0T0WhnkgA2dBYpoZexg==
X-Google-Smtp-Source: AGHT+IEkNP6zSKWwH80S2o/eg3moHlcE3jDng2uX/wDen/7FQFwpxmoYeIp/8HRsqoomcERaJKSs2Q==
X-Received: by 2002:a5d:6d0c:0:b0:391:9b2:f48d with SMTP id
 ffacd0b85a97d-39132d89abdmr8099116f8f.33.1741542776254; 
 Sun, 09 Mar 2025 10:52:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcfbsm12152141f8f.28.2025.03.09.10.52.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/38] disas: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Sun,  9 Mar 2025 18:51:39 +0100
Message-ID: <20250309175207.43828-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250122093028.52416-8-philmd@linaro.org>
---
 disas/disas-common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/disas/disas-common.c b/disas/disas-common.c
index ae3f9e46ea1..21c2f03430b 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -62,9 +62,8 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
     s->info.print_address_func = print_address;
     s->info.endian = BFD_ENDIAN_UNKNOWN;
 
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    if (cc->disas_set_info) {
-        cc->disas_set_info(cpu, &s->info);
+    if (cpu->cc->disas_set_info) {
+        cpu->cc->disas_set_info(cpu, &s->info);
         g_assert(s->info.endian != BFD_ENDIAN_UNKNOWN);
     }
 }
-- 
2.47.1


