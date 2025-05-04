Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC05C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRus-00020S-JO; Sun, 04 May 2025 01:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuo-0001xW-6P
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRum-0004G5-8e
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so3044275b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336562; x=1746941362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=jrRdu5o/0ZL16OHkmqtGQSAJrcUn+04DlMRTXpK+K0/oixYRONsFAtiQDLnqLNyZF5
 MSPLI9yXux0I0xueNW0e6Xx60CU3TaR6o2uhHhmwNYKYVrU0i3mKNdIp58WnOhUXbvlP
 IlyOR/pmYndPHnTU65XaYuVx/eTiQHzZHqOC2YaX11UuCKNSmVs5erA+bVvkd3RO9OVG
 PW2ViAUp4yi1flvnkgnswdNwbyRnq29CK/Ndq6+VWD2Q32T6QR68bx1D/ttt2XGeays9
 wKdjjWSDZo2tgZIxcc+mvZ+PWXhv+FqgDKr8kvK5lAbSwk0OwV+qbWidMFsV/aJorp2P
 Pszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336562; x=1746941362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=AndP+OtJCAIxV9B8Qj4Q6GRjJnEhg5s9REbGjZf0O2pRJgcHz0liYg+Pq7MJ0NbSCc
 crMvt9HUaZ/sOODZLT76m+OCvL8dr3GuWqSsC+rh3X4a1/Kyoyv1B6OsYOdn1wi4tU5K
 s768//n/XnbgQIpKPzoHGud2v4L53lvrSAo1XOWkAZZ66ZJNp9Pe9fLJQ5dCyaksHPwl
 sAVP3xol4aDQpEeDw6blQlq6xw0jL92zpD+Tf0DHTVgFI1ixCrMBM64E/gxlwe12xDkx
 BvwvjHcokfGYeDdxWz0tpEAyRNNollEfYLb47H/5cyxezo0IHnUm5oRk4Sr3td+/p9lZ
 5gew==
X-Gm-Message-State: AOJu0YyV9/30KeAVa5/LhpBq6bGaWgZK2urvnSGM7L66gmKjFDq4dIj0
 LMlKctFh91TALYQtQjzm66UxVtz8rp9z5Z6QE5OzE/yCn5F1AZii0SkPo2s2/McRKZXcM+2tDpp
 LNes=
X-Gm-Gg: ASbGnct97BndGATbY31YNt1X961ENyX2aknSob9YgA+E6OAVnZCFnqeoK5oe8dgUv8j
 tJiO+1Kk5TT8j1/4NxDK+3pcBn2q8U0hzAIZ4EXa53R8/TOfK6R/vzMtHwpepcd0HZ7JVH2V8cV
 TFdGhzpzjNRdnKAqbbcC4+WG3m4pTGB6/rqHSAhYEvbpNgw3CcEfyv42zbxy97ohu1YCf49i/CW
 B+HeI0KOCcd47najlAHnhR6cupGFkrPCRoD/1emBr6tDUKbvTUK0j2ojqvv6E4BofKK9A76Gwx5
 vz8TvR7unZ2pzkZ/uZMcGYzMWr/x7gJuPBBr3jtz
X-Google-Smtp-Source: AGHT+IGVK6o8RnQD2bGJOKl+UHtGTQnnp3KoDBZBcEbovmyUrpyvzVjbZzuPCUjgGT+PmS29OCZQbg==
X-Received: by 2002:a05:6a20:d524:b0:1f5:8605:9530 with SMTP id
 adf61e73a8af0-20e97ac0020mr4372318637.28.1746336562311; 
 Sat, 03 May 2025 22:29:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 02/40] include/system/hvf: missing vaddr include
Date: Sat,  3 May 2025 22:28:36 -0700
Message-ID: <20250504052914.3525365-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..356fced63e3 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -15,6 +15,7 @@
 
 #include "qemu/accel.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-- 
2.47.2


