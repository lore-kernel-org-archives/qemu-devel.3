Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0591BC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74E-0000R7-5H; Tue, 12 Mar 2024 14:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk743-0000M3-PY
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk741-0001Mg-Vg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd6198c4e2so42112265ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268885; x=1710873685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8yJZyZJiNVVbuKzyGfMGin5zE/uxoHiQcze56MZlR4=;
 b=KZNt0slGng7poeIOdYs+yobdIjOy+smH+WzuHHgnax6BF9psn6o5rTjpZk+IoHRlsf
 ggMpWQlm2+x3PgwgN8Y6Y3jlukd4fFATURSPR91iPiP8ERxmYudOwiQKqapCmtgv9veC
 M8Wj37THjKcVQGRlqtz8o7JF1aq6tNa7dG8bm9fpmkH/tC9miLHW4cQR6UcHC0pTBtLy
 kMCe94t2b/YSLdKPbIXvw8sLWQy57OGVvrA/fCrI5ndzxDABOZ+mprP3Htsy+epxyA1I
 MSCG0kyFQgV0GoStIKSSP0fAwqVuJZDLSQKC6zc3lA6hCeXYAH/aMZGEgblZdPR+kK/G
 6Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268885; x=1710873685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8yJZyZJiNVVbuKzyGfMGin5zE/uxoHiQcze56MZlR4=;
 b=S7AgAvxgukahheNrdbB15KkGXkbE1/F9HVMiOfPF2kj4OpGbpOHDlmlDFZ8LfJC8Rt
 n+vwWCyalOj+V25Y977QMbfonwugJ/QhnD+c7kU3ZhiRyVRWKlMpL3pI6gV+pf9QeaHX
 WmWBX3jLW4d+21vC4Fqm7iatwLQ7qPnyQNBQEG9vOxQqSl/Tg/4PlNjPeD8M93g/y9Zr
 dOp1LZhVAwVFfZV8mtZgv8fxKAUAncPVER1rWuWLyh1i3s6zOGDK1+cffjN8CDFZLGDX
 OOy955jasrnpMGT+xHy94wLUGrf3Arl7qQs1Q1HVEZuMumBVhrhWhgFmk74AqROB98JU
 yXBQ==
X-Gm-Message-State: AOJu0Yxq+53mh4hh/XjgbMTM46gaWQw/FxOdlDDdrVlWv56Yk4oUJ+Lh
 r+613E13v4NKT2VfI4y55q46gFVjD8AOz80BpHlyZTAfHyECcbsbntR9rSY5QX3Is2RCVrMRNXz
 e
X-Google-Smtp-Source: AGHT+IGf+U777NCt5vIKm1BsY+fov+23IUuEjlcYgPW+9qj2VVXSLBCD76nMGW88q3w+m/6MIoxxJQ==
X-Received: by 2002:a17:902:d583:b0:1dd:72ea:58cd with SMTP id
 k3-20020a170902d58300b001dd72ea58cdmr16199160plh.3.1710268884703; 
 Tue, 12 Mar 2024 11:41:24 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/8] linux-user/elfload: Don't close an unopened file descriptor
Date: Tue, 12 Mar 2024 08:41:12 -1000
Message-Id: <20240312184115.365415-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Fixes Coverity CID: 1534964
Fixes: 106f8da664 ("linux-user/elfload: Open core file after vma_init")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4dbca05646..26d4c1d6b3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4522,7 +4522,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     ret = -errno;
     mmap_unlock();
     cpu_list_unlock();
-    close(fd);
+    if (fd >= 0) {
+        close(fd);
+    }
     return ret;
 }
 #endif /* USE_ELF_CORE_DUMP */
-- 
2.34.1


