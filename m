Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B54CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Eu4-0006ps-Sh; Thu, 02 Oct 2025 04:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etk-0006hF-4u
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EtV-0000sm-Fb
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so6474715e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394544; x=1759999344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2534c4RtZyXLI9bpIizaZmKA+am5Tc7GXq0BfJ3FTIY=;
 b=KI+cYzVnf2ZESeBdBSfegymZLAVA1P8VRJwg0z9PeBsF2QfDJDUinqz9S6sEI7yw7v
 ZTawCimwXkrKqaeCMpXGeuRukh4tdsNE+xutV2HbcG0Fhb9M6I070WEXM2d2BjMuyQb+
 2DmqxGv+BjGw+Pgi5Mb9acFWPJHVqWul+ahdfAGqWThROMqF/UY6kk8QMiF92mATX8uz
 bqOrKsHQLxwUjcc9Ff2yU41x8Cg7xy7L9v/c9/Lq9qwNvBrbkj0RyVg/f5LLBGzsL3IJ
 uperVCFT7OCm/LZKungTyy5pD1ni14c2V20kDUvooU4Jf72cALoPpK07vWIXYYaUtCYJ
 jRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394544; x=1759999344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2534c4RtZyXLI9bpIizaZmKA+am5Tc7GXq0BfJ3FTIY=;
 b=oEc+rzOrTA4QBmcyMT59X5yiIVYuUuYDef/Nf8oR1Fds5FcLw1qGCAVdFkZW8QHqMD
 KeLessd6TOkWe4VGmr1K8T3MXKeBcLvh+pvGt3SIsxt6Om1z6OUSK2NotvV1PE8nCAOp
 gvxD/3FwT0VOxhs7syTOmEmZkh8/NCKBKiK78QSwKUrns+xwMdlICiahBc0Ewr27ShfZ
 DmzjNYnzhou+X3a+bHQQVJXMa37+tgA2ssoMd4pdE6M/RXqc7daQTgyxO8/PBYb2MBzn
 epD8/o+dAx+sJPEqP50gItpaGNqNU/n0u7emXr/pTgkifYoNDWNmn8wu/iieR7hMyKCT
 W2Zg==
X-Gm-Message-State: AOJu0YxRPF07aTf1A4un0fG5Yc/Q6yVVVhBX6sScX2rU3lAolhy2kuKi
 AerHDUKcqPStOdBssnXJhwRUBMNk8WgyJ2pRtzSsOQgSPag9lnAfRzM+Q2wLvXE3wS0eZhM6xnU
 DOloz7F4afg==
X-Gm-Gg: ASbGncsRfPaHB8Cw7F4jX8xqLcbr5KIvstJE49PJ0gyQnRYkiaRiozCkGmhaIG+w1av
 zvamTpLKgPzq6i3pEJPSK0rYHOYnVUCOLtrW5VAbGxd28y3y9hfF3UxENdEaADWTVuAsq7hZc7v
 OCJKF+5Gm9xc2OMyrfLG/jtGI37X4I8nqBrh13POWKjH2UeROAy0n5wJVTvci6mC73a7m/wL8qS
 5qrpYAVGHrW/ZlhTr79bb2eWdrTxuGSj7A6+bAG7eE5ElQml3ey1vRwocS+Rm5iFb52qP1gYnaR
 wNizlhSQgFe5oaSYcALyOZZ1K8hST1543p6SAFXw3GU9AYqXEI0ico/iRgEewF0vEleenmt3Mbw
 dTdRpfndM+3tmMllUMttrarJJ1xiD5fFo4Gz+foYzPWXOR+yK0rHg4W3Ug4a3iP2pcJQOljWRpe
 A/BxLRZWYfUQug8omKVf07U0vth2ESxw==
X-Google-Smtp-Source: AGHT+IFP18ee6bgm/ejyh8kmRYFVi1hqLlMKkbtTf3ZacHJyOl7EopZwJsToQT2tvIjzxTw/P2KdoA==
X-Received: by 2002:a05:600c:3149:b0:46e:3b81:c3f9 with SMTP id
 5b1f17b1804b1-46e61269212mr56566845e9.17.1759394543997; 
 Thu, 02 Oct 2025 01:42:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693c2e6fsm23962295e9.17.2025.10.02.01.42.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 04/17] hw/s390x/sclp: Use address_space_memory_is_io() in
 sclp_service_call()
Date: Thu,  2 Oct 2025 10:41:49 +0200
Message-ID: <20251002084203.63899-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(), cpu->as
points to &address_space_memory.

We can then replace cpu_physical_memory_is_io() by the semantically
equivalent address_space_memory_is_io() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/sclp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9718564fa42..16057356b11 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -16,6 +16,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
+#include "system/memory.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
@@ -308,7 +309,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     if (env->psw.mask & PSW_MASK_PSTATE) {
         return -PGM_PRIVILEGED;
     }
-    if (cpu_physical_memory_is_io(sccb)) {
+    if (address_space_is_io(CPU(cpu)->as, sccb)) {
         return -PGM_ADDRESSING;
     }
     if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
-- 
2.51.0


