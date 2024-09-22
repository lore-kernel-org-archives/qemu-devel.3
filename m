Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679E4CF9C6F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHd-0001Wf-S0; Sun, 22 Sep 2024 08:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHG-0000vC-SB
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:31 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHC-0002Md-N3
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:20 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so492572666b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006475; x=1727611275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Cw3gAeD8wEnk+7LA9VieK3VzfanKWkt65wfBPmlUjU=;
 b=VEQQVb1rbBwOVNMPa5I7hTKW/6hJmp3KeG/ktncHYvuhWLDWRS1paVW+ZAgSfTpL95
 Tpcjn1jU2GYaKTMZkis5SM+hokoMLK701LSP4FOZLmd5FkCpQv5BwbgFdWI5GcXl2jZl
 xg7ptFPlk+NUlgWSKQOg1Q+dZ6NOetVmn/MbNcN3E6GTHrxUATMB0CVNH6qVsuW04FX8
 BYsbGg7xpyYKIzk6fQmxT6cSCsOkxrIpSFaNY9D/v6Co7ToCZRUkhG3HqofpD21YTn4p
 wBZgSevw3P+7iPq0N3uzLN7E5gxrjgzlBe2olF0bTGdidjdwDphcwj9XqhHPmQGKMsUe
 nK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006475; x=1727611275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Cw3gAeD8wEnk+7LA9VieK3VzfanKWkt65wfBPmlUjU=;
 b=Ft78XXUt1kYJBVK/T5Y74smzpqTUoi3rYrTxkHdqEjJPpkqX2XklokX5K0kpAXxe8V
 I7q02iR4gO0yzg+FTbIzWYsjGaCntP6fkUbpQTWdU88PRt0ntLOPyOXRkg7abse2Qzr8
 XJi/MBEsNpB+zUb4erq41rRO4442CmfLKAanjw5VlKX+A+MvfudwN3djvoE+c7ATxzM9
 zjlHYGeZI2e+4cTQwJrZENSpDo8iSifYoee8hSJA36yGzokov4j9KnvfeqIYn0xXrCB7
 YvDyAra2EW1BC/8MCT+y2/rso0Mtk8Ic8UTK2SVnCpAMApP/Ye93liLc1dwe7K5VmLPy
 0ooQ==
X-Gm-Message-State: AOJu0YxRix+6akPadIjS4Ja+9A7uFsTJAbmzDrZ/oaO0IskR1ifstKhh
 jZMWCnWBuGz4CS/e7fyeTb6ln4qIo5W6mC+BnwvwTz0G8LYPnbQNM6/M4NJ36WNQvS6x9Hfbd6k
 f8OA=
X-Google-Smtp-Source: AGHT+IGBCxftqz6ZLHd2pCpCyPSWujIoplxQTmv3WRbpC/7ZKDIqCeFfDeqluIsJNHBfXmb1PNMtMg==
X-Received: by 2002:a17:906:6a10:b0:a90:3492:9ad8 with SMTP id
 a640c23a62f3a-a90d51a7139mr930694866b.65.1727006475560; 
 Sun, 22 Sep 2024 05:01:15 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>, qemu-stable@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/31] tcg: Fix iteration step in 32-bit gvec operation
Date: Sun, 22 Sep 2024 14:00:44 +0200
Message-ID: <20240922120112.5067-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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

The loop in the 32-bit case of the vector compare operation
was incorrectly incrementing by 8 bytes per iteration instead
of 4 bytes. This caused the function to process only half of
the intended elements.

Cc: qemu-stable@nongnu.org
Fixes: 9622c697d1 (tcg: Add gvec compare with immediate and scalar operand)
Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240904142739.854-2-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op-gvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0308732d9b..78ee1ced80 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3939,7 +3939,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
         uint32_t i;
 
         tcg_gen_extrl_i64_i32(t1, c);
-        for (i = 0; i < oprsz; i += 8) {
+        for (i = 0; i < oprsz; i += 4) {
             tcg_gen_ld_i32(t0, tcg_env, aofs + i);
             tcg_gen_negsetcond_i32(cond, t0, t0, t1);
             tcg_gen_st_i32(t0, tcg_env, dofs + i);
-- 
2.43.0


