Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89CF1088E63
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w335t-0003jR-D5; Wed, 18 Mar 2026 22:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335q-0003hu-1t
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:38 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335o-0002qU-KD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:37 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79a535e7c00so5724777b3.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 19:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773887189; x=1774491989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUjOedTJILydQY7f/OfkEk8wUHENkhFnJJVe3/bR9qI=;
 b=X7tUH0O6MNGJ/D9GNofqJeuPBXZLB+eclOoR5lO1i2lnmoLaPvH4OCfRTJNqhKxa+B
 hHVqQi0JJqriXilrNGy+KabXlcLYWfuVP8Dny1QhZYhF+Ly1W42vUYEGwIcstTOenPwE
 Q8iyPoY67RcPmjZVC2a9Fj/BkjU3Ii2f0IXDG8JWYaqkfCKTK5tGjFZ7xDIpIpZXXQD5
 CSaeovXrh9KP5+L2RWLaByvWmoGTQQ7gzj7E4osgUTmYY7fWCAC00uOdfasa9jBDHDVu
 iGQwblC52UDbkq78Vj07DXQp0UWSpMEMkI7Rxa1/17d20lWIvXLBgk7/sijXFz3dm5Sk
 xHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887189; x=1774491989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OUjOedTJILydQY7f/OfkEk8wUHENkhFnJJVe3/bR9qI=;
 b=fth1fAmnu0DjPJoyssDk6Bp4h5VEyYM3p5LHWoWvM6K4GwzHANLJ/QJTS9f0k9DnOk
 XkTeCDxUrlVPjGviTw5WJ40M3dXSPFVpzu4rTgFfiODCCago+tsf+zbQeYvhZU2r6Jkv
 woCzqexufaaab90jf3alFlhO2FMWxQDAmBFOb2FK5OCgDFJpaUwQgUEAdbPmH5D/pmj8
 KjLfBpAsXiO5oOAG0+mnw+q+Fqk/g4CipR8oWxhSIso88SSXSjDDFrh1xeF6aEgBJ7Az
 bFK5G+E9izyfZeWAq4KyYxi1kC5m3/+9xkgv+u8OOkJdYrWWv4lFnlCyNv1QsmEHindy
 PZJg==
X-Gm-Message-State: AOJu0YxOdOkIkIW7vKIY4LF3d0Pu39C5EdEUd/486nRXMkMlEoIumW5R
 pyGLvGsFEbEFUVWKPCQSFSz9FolsvQMGIrUPiSu3x1ZNk5jkGCVtseY6lchyYOMtVFj3a6/vZTL
 ZpXAUyso=
X-Gm-Gg: ATEYQzwpbizzK/U4erpRLQNcaxPAtaV7wBF2+tSo4orYgB3iKLFI+b98p+S/29nMeus
 xLw7ZJgzngQDOeqaP5SYypZGEDqSQii9gqSWLeCgHnV4DT3GvE8KVQG91O4A3j3/+To+P1nT/fF
 HuYwVXNU40H3G3W/+5VarojPMtPy6OHTEYnpT8TDYg74QZRw9XNLOAqinh3TMfYJlJI8m+Fgzl1
 +AmZuOUMUhS9ICGMRdWIWGOkhgNEyUHW3vZ4SF7n5qB5GfG4J0JcM0sL3a6YDfJ2DOhRNcRTqIA
 wNQHJGcSv8MpifJrF3QaELpqo+fySQMrNuQWndFhNKJWJxb6i/u1I9pVTwn3zVwpl5uDxQxWGQF
 wEwAtSkC0mE50WzZNvmOf9Z9yN7EHYAyBlJ3ZC2MIQROqayPPUfMJIfPRNdy++AjUA5WFbYRizD
 8Jrztzr8GNHlQx608aoCwgH8K5N9kN+g==
X-Received: by 2002:a05:690c:c4f1:b0:796:6df5:485a with SMTP id
 00721157ae682-79a71ade093mr57741587b3.39.1773887189009; 
 Wed, 18 Mar 2026 19:26:29 -0700 (PDT)
Received: from gromero0.. ([177.146.137.168]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a7141eb65sm28159417b3.21.2026.03.18.19.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:26:28 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, gustavo.romero@linaro.org
Subject: [RFC PATCH 1/7] target/arm: Flush TLB on MECID write
Date: Wed, 18 Mar 2026 23:23:29 -0300
Message-Id: <20260319022335.22523-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319022335.22523-1-gustavo.romero@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x112f.google.com
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

Flush TLB on write to any MECID register. This allow us to take the slow
path and check if the MECID is the correct.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6bfab90981..ec25ec8444 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5125,6 +5125,8 @@ static CPAccessResult mecid_access(CPUARMState *env,
 static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
+    tlb_flush(CPU(env_archcpu(env)));
+
     value = extract64(value, 0, MECID_WIDTH);
     raw_write(env, ri, value);
 }
-- 
2.34.1


