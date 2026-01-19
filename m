Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01211CCF2E6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn3O-0006P6-D9; Mon, 19 Jan 2026 06:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3M-0006AR-DB
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3K-0006Vw-Rj
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:12 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so27080015e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820649; x=1769425449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbQjc8ZYqWORXyizHA7cHB2eAOXerMSR4t/7ALRc1wY=;
 b=CHSBINrkzFAqdfJYxOC/tzkhKW8yRjGStoTU2uTiVCMt3Na/T5eVoIe1QlxzlpuTt4
 kpipMSSvtOl02flwJe9/XmKVqUjHQeYV9dRSKC6E3yB263UliHJp1mAgfsoO8QTSuDGb
 L3yW0gnVrYDJvicWhweZ0+5LxJHQQIsy/vgKkiI+1CFHh+ChOb0QQ9R4yBGDYaBFjOyn
 BgvqtL/FKwPWivsOdIzwoKPdII5Joei0/3450ZHqB/NymyQEOlcyFp7+SI2jA3PLz2lQ
 3K4owoF2cJnI5xMXWhVYmlj4M8xzrmik8vvkgLeNweGv9xhLxj28sPV+L6Z3b0dyt+rE
 xPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820649; x=1769425449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XbQjc8ZYqWORXyizHA7cHB2eAOXerMSR4t/7ALRc1wY=;
 b=EgUzQQWIiaTnYJYyuqJA8uC/eDJpn0PDkjCtqjfjL3ZZ+ljfI8gdG6lqq0b8q3uWZO
 PyMTwP/zfhcLufehTnOf5b30vEKBt7T9WS4tDo22VqMTzCpfVdru22C+9DFIzpXJTS58
 jvsRB9RJuA0v0exsrR8+I6SZKGAR90id2M1arHWoSadTfue9ldMlEqQlDtd+qKR+kXbW
 F2jeQapBeW0/u7/qUw/X6r+4NLd3420Ti68xmASdF+gPnGcBb/WUFrQTa9tWjouI75+T
 t41XT/tJWVN4uLrdimXzXBFDFWyUPmt9SOamJYZ6fAQa4ctgZMMvktAshh5zxA9bNRxi
 K/yA==
X-Gm-Message-State: AOJu0YwqAfIgvPMMXUL7NN+r/VkUPAjy5fwJgloGWipi5XzCTNLnSR2n
 etBqu74weKeZwdpgRgTwWEePZlgO4+hAbYbO1vydr/yUnO/zA0wcSxbwUsyacVj4A4sG43ken4c
 RClNEWGk=
X-Gm-Gg: AY/fxX7UAXWk0gB2lev+8MwdrUYKOX29VQPtjl90B02G3bHFlVa+CUMtL89X6D/ol7c
 OCLkAZ1ONVq9CpRxBe32P1pdgFvTLaI/rIQKduAi9rTU3judAsDA92JGBrnWZp8hQABCb8ns6xN
 5k040eAj4zaRhrFV5BnftdLxj5DTObk6q5hapUG7IhF8V/LPPr8Y7CgE7UcE/1eYOtHfhOewlkE
 wkLYjN8reNN1FV/GTBv2e4IFFMtsFcENaUn4/J1mle7oxXYqmWrMv1qtfI8jAhtS35m9a2uD2bx
 mcz+oD9/wuS1iRhAIcsL+AWITCFKPRGiuFUKqafNQ3y8wo7rrqps9F1SxmeklI37zTvEPjxNMTF
 zq6YfzrSk6Os+6nCgmM0cxlVe/KanbjQSaPicX3dQ+x4O/HCxPMf6FN2STpG6MekiRlWuAeTkGW
 0LgR+nwGJOE00jw/yGMZuAA6X1WxmZvOYLbzqKPbfJLahHq+O2ocm/xRayqCSb
X-Received: by 2002:a05:600c:c16b:b0:47e:e78a:c831 with SMTP id
 5b1f17b1804b1-4801eb14ff0mr118218625e9.36.1768820648670; 
 Mon, 19 Jan 2026 03:04:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b267661sm245742745e9.13.2026.01.19.03.04.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:04:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 1/8] target/i386: Include missing 'svm.h' header in 'sev.h'
Date: Mon, 19 Jan 2026 12:03:51 +0100
Message-ID: <20260119110358.66821-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119110358.66821-1-philmd@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

"target/i386/sev.h" uses the vmcb_seg structure type, which
is defined in "target/i386/svm.h". Current builds succeed
because the files including "target/i386/sev.h" also include
"monitor/hmp-target.h", itself including "cpu.h" and finally
"target/i386/svm.h".

Include the latter, otherwise removing "cpu.h" from
"monitor/hmp-target.h" triggers:

  ../target/i386/sev.h:62:21: error: field has incomplete type 'struct vmcb_seg'
     62 |     struct vmcb_seg es;
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/sev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6b..4358df40e48 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -14,6 +14,8 @@
 #ifndef I386_SEV_H
 #define I386_SEV_H
 
+#include "target/i386/svm.h"
+
 #ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
-- 
2.52.0


