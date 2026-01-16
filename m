Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2941D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghsw-0003kP-7n; Fri, 16 Jan 2026 06:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsf-0002RC-LT
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghse-0007CH-3I
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:41 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so11391545e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562438; x=1769167238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KstmbcyqBDmNKiirh3lzOKShkET70rsL+d/5h23NuT8=;
 b=YIcCuywZJgD7wA8zsWip5eLD01xdYXKkyY1NwyHqgRNXyWX8x3Dq5EnG57QcLkaUQF
 hmdrKEOECp30pLdLUF+8d/D00gEW4IG8I2dHfIm1XzEAidIdMNNv6GDiQJ67JYOkSbQN
 vuF/b2WbNh/Bt4i6uCx8crT2fBG+WMu2/7DG1dKVW7GnN6sHG5DAFNWxatZHS2pkJmdG
 k+B+AilJSJ4iS18ap3xNLSPsXL0KrjX9RrJIjWjVVdkIEsKL+r5uXoJazP0VMzHL+v6j
 JMk2L50ASa16dIl+mURUDWtTV5BJBZJnetuSlJKgWrq3MnxvKMDUeELwzrwsvgt8N3P+
 t6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562438; x=1769167238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KstmbcyqBDmNKiirh3lzOKShkET70rsL+d/5h23NuT8=;
 b=Q0sXhB/ZUTYsu01qEUy27DySrgGdXGSOSoi5oYMwKPt0T8FljhuruPGcksYkU/1KiW
 7Gi72HHJ7qIeWeAHMCzEpSnxB1qwyjNuRpdZcLyhWB8UxviXhNfaebyEsZ4WLgP6XFB9
 uYS++go4mpEOpmW+bB+kwB8RAtXy/9TVPDk3sMWpzUzE4G/DZ1X1mK9RCIZC5RknL8u/
 g+xgP8WxORUhR+bmGc0U7Lds+GWkJjkswG+Q7I/fX2sE6soqxCNB5jpIeQ3HAC8SwqSv
 fcCFjhzu19gygK9K1wimsRhRTCK4/BobrIDO4R2Yfe0C/99mzZf/Jnk8YUwF1gTrlRJI
 hqyw==
X-Gm-Message-State: AOJu0YyRV2ZXuCPaMAoIje7Ko6oTkH8voGTKf45C8kQWb3ts6lPGS8gc
 xHotXfsHJfcBcS3ONxqDPE6N0dd9GGjc+wLaq9yeOxuVogwJtC64cZ59DFyohiR6rrE7MVIPlXe
 WEpIw4MVTsQ==
X-Gm-Gg: AY/fxX7M9lj+AmuDfQX8jp1qndolITZFW9cxm2nIziKpvrQ0snv/OzTa5e/wiQDLVSi
 p2xDzCo+QTwryHxF08Hu3iL7fRuFu6wmKoQHWOtXg/pDV0jylEZrCpPlBh0TNpoUMIWKf7Vqhkc
 Z3vQ7x7yfALdbwwcMdCjvTgN+x8fRqxyIzGRJ41lYJDBhBho/MwFOtKxgz3skHQN1Mr8O3wznl7
 lbRns77TC8BOIYe6obtCHlkHPoxLfS/GTFPYmaKrDk01ogQsHOn8nHAJLthMk2wkVeTb2j12RT/
 HZ5QU2r+wF7h9zo80kgsowm2Wm87K7octRQ3Ea+aACaMU3BeZuzAD8lZ4CnfoAyCXO8ZAErFyhH
 spR7yaKbDIrVbECnG1sy7oiGLVgMJFTnGSrusqgaKVTVBHRRaR7y/yAiseF+f6zMn7E6JOU7kVK
 FW25p2JPqN0thsFhTmn2OG+fSf1thyPRH8pCixtU1283QVL5kKF1qzp9MhYuzPDA/aUhhIsn4=
X-Received: by 2002:a05:600c:458c:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-4801e3342bamr23479895e9.23.1768562437787; 
 Fri, 16 Jan 2026 03:20:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm93961735e9.9.2026.01.16.03.20.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/30] accel: Introduce AccelOpsClass::cpu_target_realize() hook
Date: Fri, 16 Jan 2026 12:17:59 +0100
Message-ID: <20260116111807.36053-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251103101034.59039-16-philmd@linaro.org>
---
 include/accel/accel-cpu-ops.h | 1 +
 accel/accel-common.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 0674764914f..9c07a903ea0 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,6 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 850c5ab4b8e..eecb2a292af 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -106,6 +106,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops
+        && acc->ops->cpu_target_realize
+        && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.52.0


