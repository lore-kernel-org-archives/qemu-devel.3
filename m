Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938B5EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTgB-0008Ju-8J; Fri, 06 Feb 2026 16:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTen-0005xE-PD
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTec-0002g1-4P
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso23184045e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414376; x=1771019176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+b6+TDlKntW7zTY/b8CtNdbrq47FTBf8R9jWQuRs0E=;
 b=quyxR58d7JaWlmvdRjrp5M2IbrlfMrXJyr+m+x7ZE7itueX2Mpf7pN1p266jaTRfNi
 jGpeFOpN3x2qUZxrfK5LGmdZi8nSMacF85lFQC+EhFS9CcnZHnsrv0u8zecUdPZuoUqI
 9ps5KsqjGPeNf9z81tHkbMzfdeYYhKWtrFcpO1Lv3pEP1LmvK0JfENqqDgNm92G5c2uW
 jc40wIF0zn2aEahBqupeh1p8R6V+pvp/x1Lum5sal8e1ZqqjISlYhOCQgnxOm5NOdhzH
 aeFRSOhaynpG0BwMTKHgDOe9YS5iCFcULYavQGbaQahXBkLCHhBrQCAYoJRMu7UxgDaK
 imag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414376; x=1771019176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j+b6+TDlKntW7zTY/b8CtNdbrq47FTBf8R9jWQuRs0E=;
 b=bKEreRn8k+tor7ZW118Bt0/9foy72vfuhEP+4dj9zNNzc6uZ3llZHGAmbxzG7QEpMT
 ec/vWVQGZ28Pz79I/oDCVlJwbeoO7edgFlisCLrCSyQuvlAdW/NBSJoPpqVCeryET8+C
 PCoBOMt6FBQ3gNurGGH9s4wVFTDcY3nM7LbyvCxZRvt7xWZk8N/vpwO1i+LfvjQfkKKl
 4RWUfT0g5pjwzUG/QFoYi3gCuWXeGreNEqF6gmLhjniEpsnJPBMd7oGKLeWmgeRKt9HR
 5Ukm3VBH82xCDicyqFYXaoTN/JyHKzsKdcsfEzqLuGGNOCmoaaB+LvaXuNHz9U/Pm9MB
 B7rg==
X-Gm-Message-State: AOJu0Yy/sMFPvC5wkhlX9gbW2WyZ7bCYoXqBbdJQKe8S0+x4SWp/oBmA
 tJkXAzqxWnmjM+T8vYk/bKTHMY6PXalp9tZ9XBDnbquggLGPDxd47kNjd6bF+PYNNKDW03QlgwV
 nxYzUhTw=
X-Gm-Gg: AZuq6aKa1h03xCNOYYstPBnjH3mGmxTMSXMRSwypO6tRI+ai5Xq8UMQysNQppPont1I
 gMa4XDLzQZI019ra0bpK1SC5creLx2Et5KA/OsATcEdZjwh4XSl/4hRfr7KcU9JeP7TY3wZCc9r
 kLvFfGIYXLcMbTpx5SkIajDE6FZmCamK7Svthx5WunHaR6Jd3KiWAgoh5+06mwJXh8BJnn4L7Qm
 k4blwYiHEmDLN3GfCjWHiBRGrNzp3Y4+0Df0lUdcjLnsYz3JJbJBD3oZxPDUzBUFWK7M5olBoQx
 OYofVD8dLMpgTkXf3BmVOB5zJbyiKVexwu1UWEZekY0cVuQZOy84zkjX71iN5R2l/QPLLnRnbQR
 SVRFN3uCCXb+b+SwQFujVmI1/uv/PgyYDTqz4S2OMeO4wVTuqrXIWHGL8elvmipLo0qn5TWdGYx
 0Jt/lyVpfgZCdsrFQcfSF/1ZX6zUIsIF5PuR5N+ShslQZSicWACW46TGbiNhjs
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483201ee840mr56401525e9.14.1770414376418; 
 Fri, 06 Feb 2026 13:46:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483179dbdcfsm192157375e9.0.2026.02.06.13.46.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 13/30] target/sparc: Remove dubious swapping in LD_code() helper
Date: Fri,  6 Feb 2026 22:44:31 +0100
Message-ID: <20260206214448.22008-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
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

Since the endianness is contained in %oi, cpu_ld*_code_mmu() has
already honored it. Swapping again makes no sense. Remove the
bswap() calls.

Fixes: 2786a3f8d3a ("Use GET_ASI_CODE for ASI_KERNELTXT / ASI_USERTXT")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260203230054.23667-4-philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 3bc6a6827a4..4ec8799d1f7 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1169,27 +1169,18 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_16:
         ret = cpu_ldw_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
-            ret = bswap16(ret);
-        }
         if (mop & MO_SIGN) {
             ret = (int16_t)ret;
         }
         break;
     case MO_32:
         ret = cpu_ldl_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
-            ret = bswap32(ret);
-        }
         if (mop & MO_SIGN) {
             ret = (int32_t)ret;
         }
         break;
     case MO_64:
         ret = cpu_ldq_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
-            ret = bswap64(ret);
-        }
         break;
     default:
         g_assert_not_reached();
-- 
2.52.0


