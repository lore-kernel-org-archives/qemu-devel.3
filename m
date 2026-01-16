Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC099D4A5F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabp-0007Wy-5C; Thu, 15 Jan 2026 22:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaba-0007D3-DL
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:36 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabY-0005jL-Ee
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:33 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81f42a49437so814573b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534471; x=1769139271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92HxQ69qgo/2VgbhtKQwCIAt9EeS2yQ9NqJlStKghbs=;
 b=xDBXwA4PuXWc8tsBP9t2Xa6kNpUI73daLhz0LXm7rBRK8QmfvFMBSyW3SyudguXTFY
 ErG1Ogojl9oqORI10rl0byoqHeN9eAm7yjrpLPRVbPKqgvLvB2cNGaTsnmvCzzSvZIU0
 tMxKo3e5xTIlH0cxtc0YuSKz5SAI62BJKvTGYiyrDNWmax8ufhk9CG4zgn2XzHTXlrAV
 +qsFxxTDGqGzGqFVGsEIlJkMwDn+hBguMdmXA/GrmeARJLL3KTtGLOHplGRB5lg4B+lA
 lf62NUxlWC0Zm7RmdFze5DiPJa9gGZEjvG2zn7UsAcfBj8NWpX2ysXOxKcJZn44gJMRX
 cv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534471; x=1769139271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=92HxQ69qgo/2VgbhtKQwCIAt9EeS2yQ9NqJlStKghbs=;
 b=hGLqIBmp0wYG0jxSo2TuU/QU+1hFVYqIAKmPpcaCWj2EzSO5+h1oGlAZbJu/5ShykD
 x8q25jwSzbydPPA5oCdow0u1DComAY26s/U8oW8xKuoWuMdESzVfHg8TvW+gcaPktVvN
 AFW3triTn4/Hscn2OdgHOV53ovwruNf/QS3IdHbpaBaQTQW9jm/rofizfxQT/swgO0QZ
 LayE/QwuyOo3O1OhOarXwpskSleIJBfoT6wD5bnRZo/PDIE4BsvPVxV/qrs9fi+U8Pti
 Ai8/07vz3Gw4oKZbPGxpKnKRIBVjiJagWrDTowEdyiE1/yxSlwObiRhjLhI57K5OgmSv
 0mqQ==
X-Gm-Message-State: AOJu0Yx5lZdE0SubB3gfaE3MaslP2s0namJyplw37bwC0J72zDgAkABU
 +pg7jcfVaFYJDh0KaruQ9542E+t6+crnDOk5h8lifZueWYWqD02aMa273rqxbR3KLBvHgGyxCQA
 pv3eGmfuAbg==
X-Gm-Gg: AY/fxX6z2YgrKR7rXQitNTKHYCxwPxjXd3NbI9aV1Cf4bz4xbr2Aa3GitJXAFRHc0Qy
 WyzRgGGvd8NV7o1LsPXGZQZPai93R5IIuBWRaXixbEHrlwTBIayvN2eCVnC4xgsKfySh29h8ekS
 MDO8asJQiw98bHdNh1lFpoSz+KOiwulbiRTxhLoSHZgkRqF0AfD/wKLKUpuII/o9LHepKaUnlHg
 9IbEZlK3sVD4I++yqrgq15drUaKhA+ozxbRlYdQ9h2cTQaBQTfPRSS0qSJCq28EXhWRKPlsYUAR
 qgqQHvXVgP6FJf/stob7N/6xOXeK4ccUBloIEGexwIqiEZsBEAH59oJcWuu+ru4WhgEAgFbOU0+
 uH7vwd20ZOW1LTORfq0K2EvbX4XVB9XER+z4TokrFswwdEIB+GeTDtN095ep5pHDtvnnkZLs0E6
 y40xm8xDWejgRBqGpssw==
X-Received: by 2002:a05:6a00:1da7:b0:7e8:43f5:bd40 with SMTP id
 d2e1a72fcca58-81fa01e2082mr1468693b3a.44.1768534470926; 
 Thu, 15 Jan 2026 19:34:30 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 19/58] tcg/ppc64: Rename from ppc
Date: Fri, 16 Jan 2026 14:32:25 +1100
Message-ID: <20260116033305.51162-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Emphasize that we're generating 64-bit code.
Drop the explicit rename from meson's cpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/{ppc => ppc64}/tcg-target-con-set.h  | 0
 tcg/{ppc => ppc64}/tcg-target-con-str.h  | 0
 tcg/{ppc => ppc64}/tcg-target-has.h      | 0
 tcg/{ppc => ppc64}/tcg-target-mo.h       | 0
 tcg/{ppc => ppc64}/tcg-target-reg-bits.h | 0
 tcg/{ppc => ppc64}/tcg-target.h          | 0
 MAINTAINERS                              | 2 +-
 meson.build                              | 2 --
 tcg/{ppc => ppc64}/tcg-target-opc.h.inc  | 0
 tcg/{ppc => ppc64}/tcg-target.c.inc      | 0
 10 files changed, 1 insertion(+), 3 deletions(-)
 rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-reg-bits.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
 rename tcg/{ppc => ppc64}/tcg-target.c.inc (100%)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc64/tcg-target-con-set.h
similarity index 100%
rename from tcg/ppc/tcg-target-con-set.h
rename to tcg/ppc64/tcg-target-con-set.h
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc64/tcg-target-con-str.h
similarity index 100%
rename from tcg/ppc/tcg-target-con-str.h
rename to tcg/ppc64/tcg-target-con-str.h
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc64/tcg-target-has.h
similarity index 100%
rename from tcg/ppc/tcg-target-has.h
rename to tcg/ppc64/tcg-target-has.h
diff --git a/tcg/ppc/tcg-target-mo.h b/tcg/ppc64/tcg-target-mo.h
similarity index 100%
rename from tcg/ppc/tcg-target-mo.h
rename to tcg/ppc64/tcg-target-mo.h
diff --git a/tcg/ppc/tcg-target-reg-bits.h b/tcg/ppc64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/ppc/tcg-target-reg-bits.h
rename to tcg/ppc64/tcg-target-reg-bits.h
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc64/tcg-target.h
similarity index 100%
rename from tcg/ppc/tcg-target.h
rename to tcg/ppc64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index c39a8f54e8..c58fa93fd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4079,7 +4079,7 @@ F: tcg/mips/
 PPC TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Odd Fixes
-F: tcg/ppc/
+F: tcg/ppc64/
 
 RISC-V TCG target
 M: Palmer Dabbelt <palmer@dabbelt.com>
diff --git a/meson.build b/meson.build
index 594e7d42c0..0647ca0c89 100644
--- a/meson.build
+++ b/meson.build
@@ -907,8 +907,6 @@ if have_tcg
   endif
   if get_option('tcg_interpreter')
     tcg_arch = 'tci'
-  elif host_arch == 'ppc64'
-    tcg_arch = 'ppc'
   endif
   add_project_arguments('-iquote', meson.current_source_dir() / 'tcg' / tcg_arch,
                         language: all_languages)
diff --git a/tcg/ppc/tcg-target-opc.h.inc b/tcg/ppc64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/ppc/tcg-target-opc.h.inc
rename to tcg/ppc64/tcg-target-opc.h.inc
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
similarity index 100%
rename from tcg/ppc/tcg-target.c.inc
rename to tcg/ppc64/tcg-target.c.inc
-- 
2.43.0


