Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59A6D6AAF6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LUr-00024J-Uz; Thu, 02 Apr 2026 13:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LUD-0000mF-RW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LUB-00016A-Cl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486ff201041so11258645e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149537; x=1775754337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRPUYAczpQfrNB7NESGbjTZhQXyZHZILb2QpR9Q7LQM=;
 b=mxKkzdpXtizb9ttrALIN4oO3fvnLv7t1mbWuPFbJCYxt4cfzKSenqD1CID7kqHgfVN
 O4q/VbL/UYk5tq8WYEZEvCV3fJWl07XHcBgpEfR2EIjYYKfVWJEY4eLZjwqf4yvQsNP6
 macHuqaZW72M30mSkzBRQM+mkS+nUDNyiQKuBpcqYgrhImM7LrFThoY/mILDOx9HpFAP
 HDRpnrRG+y4sW+Il6+mWI+afAV65xTXlAzUh3KC6urFzuye9+RHHqzho1KzcnNNQd9ip
 CH+ENUD1hpppIvu2bi6xmI2WdEKEyhNOiGR1CK7VkJ11PV5qSWmU9JDeZgqqDSjCTkx4
 XTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149537; x=1775754337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BRPUYAczpQfrNB7NESGbjTZhQXyZHZILb2QpR9Q7LQM=;
 b=S/Vv/5uEMOGWf+sZUy4Xk1GrkUv3n6g3vVhrYrAYzYRdq0QIjDOSFDI8udT9lFs7MM
 05fBAfW0CWXQrH8L2SNoXv4cUP6sf0qdw16jVQtIm2/dg1wETJ326cyN2wHtgndbd+OT
 aQkgoWjjzr/hZxBeqdxzJkAPbHl/Mummd0l3XoTi2HoTMsoLCX7YcSD4RBN2UOBd53WQ
 JdttFp4A7juMdVUAbvtD5t/9PA/YpkvTPCNlvz8aoMp3XpSHw3ezaBV+uqew6SrEpXFH
 O9gw5roOaKpqGoW6LzNNXndvUuaAJ+wDza0TP1UTo3VA3d6VTO5cETf22s9Ki2wSrusg
 7wfw==
X-Gm-Message-State: AOJu0YwNhx99TVWIfpDhNxkiWMFAHoH3CkeQMIowSvedXf2jZmdbyez6
 okccu7d4R5yHrzEoOHnKj53XwJzJRuk6XlMYUawm4WBI90QmMRR8Dk4Mzb9f5IOB7e/aigLJ/n2
 mgcOt/qY=
X-Gm-Gg: ATEYQzxyn3NS17l0PSsQkPTsFbhZ9vlpQi3Id91BDjVUY5BuvUE9WsAy4d9i6Ws9sHt
 8ydRzWlugESCIab9GqdfE/RWjK7ID6TPNKMFUX+yruzOaYRJz+4v5ecNu/yWuoay8WYr59nILS6
 3jIwHxmztE2li8wgruuqQ/KulL/tZumTdNO0CET229oCn7S9K/e0Wu0QqonrxNU0ioVJVUm4VQn
 YJL8js5sTkX1a/L1YZIdxsu8lKUmNrivFQWxoMhsuwdrJSm+ivjd/vQhT7BAjs3B+Kg+eyja1F6
 OIZeYMDynv8sPVhPPWwncfgvItzZRzq6JNxIM7tsShKz/JqNHvtQ4RQkAI8Fxd3/Pd9vpRDl+rs
 hJH0AvvgdC2K3CSWm0H7d66yFtNFNz4wvje5zZo0X2BdfPC4OMdsLDktweKnChOEhlndF8u2bcy
 1CT1zdxxiwi+s5z1zh8Sr8ULk3/6UroaCd4VMTxa7JbMledludc55WTt9tae6wEJmkVCJc8vx/5
 NYcFFtuc5s=
X-Received: by 2002:a05:600c:310a:b0:485:3d3e:167b with SMTP id
 5b1f17b1804b1-4888b6d4a4fmr70694155e9.5.1775149535919; 
 Thu, 02 Apr 2026 10:05:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a705ebdsm94510025e9.10.2026.04.02.10.05.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:05:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 8/9] target/arm: Remove target_ulong cast in
 kvm_arm_handle_dabt_nisv()
Date: Thu,  2 Apr 2026 19:04:33 +0200
Message-ID: <20260402170434.94783-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
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

kvm_arm_handle_dabt_nisv() uses a uint64_t type for its @fault_ipa
argument since its introduction in commit 694bcaa81f4 ("target/arm:
kvm: Handle DABT with no valid ISS"). Use the proper format and
remove the pointless cast.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b88..c09dc4cb3dc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1453,8 +1453,7 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
         }
     } else {
         error_report("Data abort exception triggered by guest memory access "
-                     "at physical address: 0x"  TARGET_FMT_lx,
-                     (target_ulong)fault_ipa);
+                     "at physical address: 0x%08"  PRIx64, fault_ipa);
         error_printf("KVM unable to emulate faulting instruction.\n");
     }
     return -1;
-- 
2.53.0


