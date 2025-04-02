Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C32C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05HD-0006KA-7I; Wed, 02 Apr 2025 17:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gu-0005zu-0h
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gr-0006Ss-JR
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso1779615e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627912; x=1744232712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fKiAT9ky4NbCgDpJx3V7AizfrJaN1GeEWgzIKLY9dQQ=;
 b=M6qkOubSnz69+shXgHSG9UT/+j+UkVlfv6s5yJSbgFF2PwvC2erRxV673Er7vKg+Gz
 FflcfBa7uzC4yq3bOEWroh2NUbL0CNzLcaDWTSdW+oVgoQyPJp/2YMZiqLtHW/9r0gn3
 Ev7/NISVFoS0bLNk3Df64aHIv/0haA8HsPu4GZhqH85tqMbSj+E//2zU6P7QcxjWrMFg
 He0DxoHaZg8QlJcDkGRLEFSKQkCnYstUFtBSN1PQXJqAVDwitURXZqg9ZDpjQgR61HgA
 ZA8AD0ZKIwPsdMGMXVWe4qlik+bCWjmf3qauTkreBoBvnMiF3+G4VYu0147FIh2usmVv
 MtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627912; x=1744232712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKiAT9ky4NbCgDpJx3V7AizfrJaN1GeEWgzIKLY9dQQ=;
 b=oKuxWgMb2fmHq+OAX6DHiMM1ZOzuukTx9WUTSVgERzwkYjHqQTLmffVShuV3qyhWrf
 dbCEdr/ply4+23v59wHwmWNBewWeCqFcDbMmb1Yx+DM38bnWrgikYq5bJpHyts/T1YSo
 JDofYX+0fg0JBESp4suOyKHUuxS2gfEWSBa+/j3ewCSDUpgZT38whfvQi4BEUhsebdcD
 CsHwF5X+bh5+zc5eF2i3yD+rhfRw2mITywEEiyLw6gVUEGBDa1A6+uJx87VtB1008Tv2
 qT7DYJqfGsQvHxkVYGWBnFvhP5lpqaTMt6m+jh+peaFQenhamX42VNKoRwFArTEliD7K
 Jo0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwPgDY27pN9vAu2wyzKHwiNzz+zCPtST1G4nziTtVA9SDr+4oGzgfriirW6R1R7evqwL3ir02SemeC@nongnu.org
X-Gm-Message-State: AOJu0Yy82k1uKfa3FA/OmqdMOKddFlcxYRqkkDcKQebkGOG9+ML7fDbw
 wZSXmdWyJZ5f1M96dNUYuNCD5enIr7Z8gtjpq2F4EZqtbOrCHtFG5mmeVVi3HsNLO1rAqIiYN6L
 /
X-Gm-Gg: ASbGncs+rYgopdmxFN4Tu7iPvuDuqov1QVYmg977oG7VoVxKTYzTG9em8BxygwVSiaM
 c9cL2nuHLkG/14qycN5U3wjyiXt+MSXHkA5ymYs1AM3dRn2zSunC/68pJsCKGEToXUjwSDMU1Jp
 RxkudMh67u0xJnfXhAZz8DA8g3xg6NI61WhYfHqC2i202uRhpug2jurd2hpMLNwu9dIilsdYWLo
 GqwV/E5jgeF6GyoGZmI+jJy2d2OaM173iGq9YimbjxLbIzdxQm+NKh/nGUBjYONP6j+4RwiNlpd
 WbPZJ0AwAnuS8acKKMbBkMlUiQk/qUM6QUSBbr0ujAcETL84BYBuHN7YX9+4U5xLFN1dC947Byj
 dPt8q/KfIhqlRXBQJhHQ=
X-Google-Smtp-Source: AGHT+IHjw3SYU8GNxaO5OFrRUeYr5sgmRB1hFvym28qc2ysm+Zg+NoxxcK5BN4tlkJS7fYcfHdzYjg==
X-Received: by 2002:a05:600c:a01:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43eb5cd1a5dmr36370625e9.27.1743627912083; 
 Wed, 02 Apr 2025 14:05:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658a32sm18185373f8f.19.2025.04.02.14.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 21/43] target/s390x: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:03:06 +0200
Message-ID: <20250402210328.52897-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1f75629ddc2..320ace67198 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -348,6 +348,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
     .restore_state_to_opc = s390x_restore_state_to_opc,
+    .mmu_index = s390x_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = s390_cpu_record_sigsegv,
@@ -378,7 +379,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
-    cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
     cc->set_pc = s390_cpu_set_pc;
-- 
2.47.1


