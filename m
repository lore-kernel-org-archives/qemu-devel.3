Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F5ED2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9E-00073e-3M; Tue, 22 Oct 2024 23:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S95-0006zn-Ls
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008MO-KR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71ec997ad06so2082879b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654485; x=1730259285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wtdGS6j59IEw6lp5Sp3jQrC+uEbTCdVdwYMkROoHlk=;
 b=aL/nQjbGpBGfe4vk6v/C4jPc64xwF0zIZRvpdxSkcayoEzMPoC6yUxsS8l5lwyOrkL
 vEk/Nv6cZLxUUp/aD+nHgZ+AzNBDmMm/BhQXnlav52Kfgn0wmtg0wBd2AHZXYEOqJdQK
 CwnacN7T8erKSrVFb0mGKO2VY9eILFlEZ1Ud5DRQ7b+cxD8uXssLkO/Vo2airCKO/Mgp
 RzSNxp4WOT0JuNvSTDZrq1t2OkSRlKout0OJb4gQOhkOUX7GXsYpEXUY8eii8m3w/pay
 2Ahy+22PCwRdRXI603w5cphrcGocBFZzE2Q3Fgd0kKJ2bBZUwUOJskBNM5SReG8gE+Uf
 uBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654485; x=1730259285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wtdGS6j59IEw6lp5Sp3jQrC+uEbTCdVdwYMkROoHlk=;
 b=VNv0jkJerbu1AUhQwRhA8ADqfOKme2BvuDFk8hF83hAFDEvqZSHyGzrEBJo7NyQMCx
 O4Q/p/0xPkgHfLmVmKG1IXqnOVPPJEzQZJG0qVLHYF7BrVpWzotrQGMQ1cJ8iOP9T+4s
 3jWPxE8cWO9Mn/OM09S9Yt1h7Oip83p3e8C1ALvEYP183MQQOR5IXLSDaikYXDZ4/zqJ
 P0HBe+3iZVLtZ8NIe9nNoWdczfcWT6dCuuAM8ngsiJS+4fZ1F7GAu8dFN6GpAnBgC0nb
 yTzbjHOjYkOSJvhEKkHq6AS4m+bItyvR5m2RNHzgGiHYecKswaGEoi4H4GBfAbOwHDxX
 Gzqg==
X-Gm-Message-State: AOJu0YzQnNawvdfoIwHlsEfiYyFeRWsqhNZnWYPbZrD+TgpUdOmUpyf5
 2ANeiPTxWcoC4lg3u6lIU/x+zUZkfy6iWYZpCgPbC/i9XbVcVnJUOTpFWixtUIpSV29dIw/Logc
 O
X-Google-Smtp-Source: AGHT+IGW+3Mk0Bv8LhF6DUu5qzyiDSkx4EBKTaD1L3qtsEE37EVGJXysM/j4Te9H2Uch9b116X+PqA==
X-Received: by 2002:a05:6a00:4f88:b0:71e:6ec9:fcda with SMTP id
 d2e1a72fcca58-72030b67096mr2299377b3a.19.1729654484843; 
 Tue, 22 Oct 2024 20:34:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 14/24] tcg/riscv: Enable native vector support for TCG host
Date: Tue, 22 Oct 2024 20:34:22 -0700
Message-ID: <20241023033432.1353830-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-13-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index e6d66cd1b9..334c37cbe6 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -143,9 +143,9 @@ typedef enum {
 #define TCG_TARGET_HAS_tst              0
 
 /* vector instructions */
-#define TCG_TARGET_HAS_v64              0
-#define TCG_TARGET_HAS_v128             0
-#define TCG_TARGET_HAS_v256             0
+#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_ZVE64X)
+#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_ZVE64X)
+#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_ZVE64X)
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_nand_vec         0
-- 
2.43.0


