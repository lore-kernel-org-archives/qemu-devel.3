Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD796C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxW-0004q0-3S; Fri, 01 Mar 2024 18:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxT-0004pP-5o
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:27 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxR-0004CG-IC
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:26 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso22774735ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334384; x=1709939184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHvhcE4xVUGsA+1z7u9QEyHKVjaKd5k7EQymbD1rMkw=;
 b=GEJwmsmZnQu65aynPosZz4upVsiwc13h9zIiSXBGoaI20iaH6GV2ACvhgPtpwZB/L5
 3VeqC4grZxzs0FF/04knQYU2RVFTahE72WCk/al0xsFCcEBXGOOQb8HbEKbPLgbyAfAO
 gPnA+2o5xPK/uD95X70NVX54SMWVT0Vh32owOxoIOUAUdwn+/ayMnmUvLFyq20Fl5WQe
 I1rYir96NZhnphnRzOLCEmN9JsMvl74yAukn+XMtvMvfnH6kKbwYDljr0hjHz7CZ4SIw
 DPcRCbvAcymfN4hKSrIB26XItFZx0WewmElLWzDsda5/qd8/lxzXWpmhHJMiBnfaNqFd
 h6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334384; x=1709939184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHvhcE4xVUGsA+1z7u9QEyHKVjaKd5k7EQymbD1rMkw=;
 b=C7eCdMtWdrajWTvsP2OJUSV+0cWlvyQiJId/Inpeug/JnDrsLnUguWjC+LiD+53RIR
 5Cb3Ff0ad4zSO3Pvd2IBvfso7Fr9mRyV+xD1r4iWXj5gtbHpIABVYzFmYuOeowccaFcY
 v16PfU9MOS52oMm14i+gy2+DtOB30k1yJ2Jg7tS312ui417KgxK9+Zc/y49MsBwKQ4nV
 4/gjkz1LdiGUuIkl7A9RpKobDwaAj12fl6CxiUmW/ulbDhLdwS2XUyFHV7DYtWQ7QRK/
 g+pg+QM0Ozu0iknFo4AcP4IUeZwTj/WIUUVFOcwgpC0bDSyuDPAhGSsGOjokMxhbykIW
 tzOw==
X-Gm-Message-State: AOJu0YzIVMm8OYHt2IdgDuqGKvTfu1mluKIMW55SBWMZV/c1UVFrHQLb
 yYD8RJ2drM+90+hfCawyEErx11Fiz8JaSrSQMmTYsZc5FddsKoxEyqRNJJ+j5rAlCrEElXENift
 N
X-Google-Smtp-Source: AGHT+IGXuMzPNCG2ninSEW85IirDktfLrDk5mC0qKi1W/tYxbDeMtNoNu/B5P9u+F0cwLcQNL3nZTg==
X-Received: by 2002:a17:902:d491:b0:1db:c6a0:d023 with SMTP id
 c17-20020a170902d49100b001dbc6a0d023mr3659462plg.8.1709334383888; 
 Fri, 01 Mar 2024 15:06:23 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 01/60] linux-user/elfload: Disable core dump if getrlimit fails
Date: Fri,  1 Mar 2024 13:05:20 -1000
Message-Id: <20240301230619.661008-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Do not dump core at all if getrlimit fails; this ensures
that dumpsize is valid throughout the function, not just
for the initial test vs rlim_cur.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b8eef893d0..fb47fe39c9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4673,7 +4673,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         return 0;
     }
 
-    if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0) {
+    if (getrlimit(RLIMIT_CORE, &dumpsize) < 0 || dumpsize.rlim_cur == 0) {
         return 0;
     }
 
-- 
2.34.1


