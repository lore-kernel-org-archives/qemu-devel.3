Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36057C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDk-00050Z-K2; Mon, 12 Jan 2026 05:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDj-0004py-0L
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:23 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDh-0001sw-GW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so2910380f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213940; x=1768818740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Kh+4Sh/zRQ8CAg3HJCYZrKZcr0kD3MOt1nUSLo1u/c=;
 b=XZm6ohN/EYBPszut/DO8jHneEEIvDFsv020Pcljyb8dQfEcKsP+zG6n6NMvCUrsoDk
 Nm82e2yZ+1RpJh8Hc9rsYLIUz54OQMffW07dlyKO096lwFHRWaZ+AhIyi6p93qtniopA
 Emc9iSSfesY873NpN1hNNmBeGXJoBOJaJKJNbn73iu70rTWl4LlUH1IvGnNWuC/DFLva
 PMjddLtZxygocD8BeoQZba3uk0/lKUwLmTkcN408gqJhqQ+1HAD4TUxsZVTfYJJ6tK9Y
 bGX5n0/o8mXU6hJGAvCAbeDwB0BcUIz2raQX89HjsFwiEEvyBvExzWZL1Uvf3LT6JLAq
 gdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213940; x=1768818740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Kh+4Sh/zRQ8CAg3HJCYZrKZcr0kD3MOt1nUSLo1u/c=;
 b=lmjes2lEtqqPpClQGxOLAbFjhD3k1nmqJX0Y7SY80vJGgTcBb+T/j8XbJgR5tLM1fX
 MvDA96WLHxzh/5IKi9C9OCcxRXhdbx1E2B3ncxXY6kPmAZcseHKweeZpMUml11EkDggM
 D49VDECBGu1c1rTdZV2qE9RvThyF8UkZqDNH7TPZMrJDhhZFNYqRWL10fvrF2xY4mGJd
 ZNpi317080f8MlPEK/hYWTHPe+XzQH09yfv4YVRsJbBJ0g2eTnZJgLK2uu1hXa4xbzye
 SKJHFPJxNhxdeVlr15QafWLXzb1dcO5GYPFOmFvWlzYfMAhS8KXkgP2pMWK8fxbkUioj
 2JGg==
X-Gm-Message-State: AOJu0YzqbsgNm6JAHbnRnyplPTY4tnJSvusQt1+0C6r9MGa/eEcjbuVe
 dC9HGMlYKkEpU6k/54bd1/R2ern/OEK0+PcWfvQE/hreomPsiIBNjPLUQ3GKiDqkEnQu5ioWlLj
 Mz39DD6Ngmg==
X-Gm-Gg: AY/fxX5lAyK47Y6iSdWP4xV76s2viW6W010Ejl5G1xJT1PP+58CPK4vYchDIIfi4hTF
 Lb6HADFkBRgDl2oKjFGq4gSyYvuP/CaVer/jhWqbP4RQDo6I1QjboJu/i7OJq0PNXjUGNhoGeTV
 uLlKP5dPUILddmAz2LfWiSgtuKhzwfVmCB4QGQniOFH/2yGXpk5tJnORZA1QcvH04+DhuscwsHy
 0UIi992rVrLh4CbPj2wWsD/1tlkdzao36BeWwQdm/p/oAILSEnJm0M9t3PZN8MLbVPbomTASd8V
 RgK/oU1ZlWVJs7hC8mPIgFns/lnU/ggI5+nmBaBPAS0mBeiQQCPtLgI21HqxAo1kpLgTS919t4t
 onbsyB2lPLy6lt/zaj4Vys/BtpjDa8SMlu7dFjH351Gb+L4Akwtkf0eJq2jMCck6XCwe88jW6jE
 AMC0dkM/aewhQu9QXA+q083O4fTQAWYmydx06/vWs8uvRHztjWpNjElHWsgR6R
X-Google-Smtp-Source: AGHT+IElMUYyHZPj4L30whtEhJ6TJuZDnl5hgM97hyaM0UUHuFgTAGaAfSYsA2rAnUhiwpZkjvH3hw==
X-Received: by 2002:a05:6000:22c3:b0:431:3a5:d9b8 with SMTP id
 ffacd0b85a97d-432c379f4f3mr21648932f8f.52.1768213939678; 
 Mon, 12 Jan 2026 02:32:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dfa6dc4esm16087003f8f.23.2026.01.12.02.32.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:32:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 15/19] accel: Introduce AccelOpsClass::cpu_target_realize()
 hook
Date: Mon, 12 Jan 2026 11:30:29 +0100
Message-ID: <20260112103034.65310-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


