Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D3DD6AAF5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LTk-0000OJ-O7; Thu, 02 Apr 2026 13:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTi-0000N4-MS
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTg-0000um-Aq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so1079166f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149506; x=1775754306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acVMLUbyHF8kLnpilbLd0pGtSfhr3LEsLd1hqYU3gOo=;
 b=o7q8ZcyZxc6M/M1TWiKtaZ7eOvnIcUF8Tdg2zLHxU9BB4YyZaeDclNZkHCpyclMiP6
 ELrVFq4zPoCrgsjXOq4AsJRfCmKVaqNZpjzkQffRF2VPkB/mbZCEJZOuAbmwOwBm1q/O
 O5xl/h/RCmOqTo74kxFuil0Y5BBL/yY/0hnziKqeHb6UJvUGf5C3zf/Ctkx0G9V//Bo8
 IuD0KJO2qj7mEqyZp/gbpJk9ISbzSTrHZNZHSRwPSKFmBD/6WortT54iO0dwWpMQj6Kh
 oRttkA5q3BRMlgjBbbG2PFH7RGQu2HjeA0qLmzp3H8GP+rDZL8nOgRh6jkQMxTY4MSy4
 qy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149506; x=1775754306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=acVMLUbyHF8kLnpilbLd0pGtSfhr3LEsLd1hqYU3gOo=;
 b=lT5hKyUhm6NshLhXPhchAvo2yWsnq6X1m5L+wBBb8WPhjSm6p1ADxZUpLyQWcmGtEu
 R52Xrx/PDMJYLonojICJqlCckdGHwYtnmZd5rgjFBwp4wIHq9nZ50Q529UR4KK4Pk48+
 e+nvmvH/3k3bbfb2rg6WCiLDo+6ry4sFgxEYnIW9u3vgnVj8HJO5dL/0recCkj/9BB7J
 ZOM1/+k737QNc+Uri55bxeWacCKt5HXMcET3PzMCBWR+LkLq3UrAua0UtbKVy/vH1CgJ
 iA5B0QQUCiugHZrKIenZaTtFTS13nwZoy+xnpzzvOx1zfD5tyyo/HDmI93oo+PrU6lyD
 tsgQ==
X-Gm-Message-State: AOJu0YyXNETvCDYk9oLtjKcDUWtGyg8YMFT4P4q5xQsKUW+lN5+zXjUb
 uKitUj8QyEddSy69mXBeoKKDvN8gCaXqXw6x6yiuQiEb+gjk1cTLoPM83CL9/cH/OFrjk6XS6eB
 EudWY98A=
X-Gm-Gg: AeBDieuTvamOOg2SdmNUmM45FXSG1JIjwFP5w7/Mgo+zjyPR9SFFO7x/69lLATkTBOr
 jjX2RHbsgPP1mxgbOwWeqyYKrHFbvvZRS1/finnpjgTdymYLWWhFWIQsU9Tny45isth0KI47Cqj
 vW35VwjnJGa0xBK4eqcs5qIKUAYpqE/h7g39BaBFRUgX7X1lOguN/7DdIcg5RdOL7Oa1tpo0nvn
 Sp6vjWPDpVstOuf/wfcV7kKdaMeXbd0gkUOhr/zy7kUq93C94Jqc3oYINRSlpJV76HUNBO7VMOL
 bXChIDyljrIyIY2K4hECgc5WpLltQoEp3OqTurthJquEO1FIz/ZpQ37ECsJmWf5OZFqASN5lczi
 j/N1tZSyCAHP7+xU/oiNNbFeb2KpQRtovo+XyW6+Fy7NVBpja7cnPXhcWsmQKKvSLXep4LwZd1W
 4jRAIW3IvU+cSPGO/5An+SUvY5/tc1UEyJysxRgeSOfaswm8iAyWQLaJvpf59zNhr8+VaWz/pNL
 nQsox62X1c=
X-Received: by 2002:a05:6000:4008:b0:43c:f764:6256 with SMTP id
 ffacd0b85a97d-43d150f6c7emr16029702f8f.37.1775149506486; 
 Thu, 02 Apr 2026 10:05:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a6f13sm9295799f8f.3.2026.04.02.10.05.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:05:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 4/9] accel/kvm: Expose all non-target specific
 declarations
Date: Thu,  2 Apr 2026 19:04:29 +0200
Message-ID: <20260402170434.94783-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

None of the declarations guarded within the COMPILING_PER_TARGET
checks use target-specific declaration. "cpu.h" is not required
since some time (maybe commit 4fb54de823e "meson: build target
libraries with common dependencies"). Remove the restrictions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 9b722ad931a..c33fb160b5b 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -225,9 +225,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
-
 /**
  * kvm_update_guest_debug(): ensure KVM debug structures updated
  * @cs: the CPUState for this cpu
@@ -450,8 +447,6 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
                                        hwaddr *phys_addr);
 
-#endif /* COMPILING_PER_TARGET */
-
 bool kvm_arch_supports_vmfd_change(void);
 int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
 
-- 
2.53.0


