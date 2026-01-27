Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0494D34094
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklJD-000762-1F; Tue, 27 Jan 2026 10:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vklIl-0006WQ-6t
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:48:26 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vklIi-0004EF-IB
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:48:21 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so3510716f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 07:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769528899; x=1770133699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xj3uXJy0YX+vXnrU6szpxqRIKY0go5o7p8K2ACV/4tY=;
 b=yPf+qltwnc7jm+1KRWCFrl3JWld28UoDAExg4aA9AHwGwAseA1B39FwtiY8kbpkIOc
 S73zNux5hoPQRqj1LTiZA3JfDg1F3OHY0aMM3qULgjcUD7sB28lgWjNM4+zPV1hYWL5A
 Q75x0cpOAZYRi8vpJf5T5BsCFqC066w4Czo34dn+O9so9V6uCALYtUELmnlLd4dkIeI5
 GaWqNLoJCDXe15XhjUQvB5awEFax6LN8FhaQH4Yn8ip/UZODb6H9aU2iuYtNAX0miY/O
 ZJRyP0xBvk2MKp46b57L7FBuZhiPhV0kxoI8vC3iXNAdWc/N4zmAd3+sZB6pU6fg9WRk
 TN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769528899; x=1770133699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xj3uXJy0YX+vXnrU6szpxqRIKY0go5o7p8K2ACV/4tY=;
 b=U0PXfYvr9/kzTIsu4ySwryXmFMtR6PP9hM2hMQdAKvH7gu1C/29/9vlDRjL8A/a3f4
 2u5qoN6UYNAtPkKpk+qn8g3xiwWW2QZpX/o5bSzIxafFPQAOY0hoN1PNxjaxS6uOcIYh
 n+GzlhthQe5SXGu+B5gjVs8or8bnJZQrvgBuRhWJ9Heg8cEtcSbvP+mGu/gdTAm+B8N9
 5WgQ6tef1ktK7K1P//3VrXek9ECyLqMjM6DDDaOs/0P3F6tRqpS/xl2Zkmd1pSFX5xI+
 FbqONXBr/gO7Xq8LOMUCrvrT84a/Hc8Dwt49+RvXnlJErVJhmpwdB+lKvXrYLj8faNZN
 lrkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2cne4lkiOutkJ0IM4+FDB+2KyyPy/Bcb4pKIpMFMFAAU15kpC+qSf/BhSMVASVvPF0tJNt0snhD2h@nongnu.org
X-Gm-Message-State: AOJu0YxF1XYybEzdgnSpFzbcXV0iKPZ8cZMXujIX6WKB9mMQ5/ouvqBK
 wCAskPH201WjtMnrk4M0/YStkUdXiTC4oIUhPq6KmyAL8nrGgSIHjtOetgUY7euFZLa/quaS881
 g7bv4zGg=
X-Gm-Gg: AZuq6aJcbU+97WmUjgzEjXvTbkrL2hRGJT3+fL+M3FzSTLR7s6GNHaInQjYlBUcB7ap
 KbZ7ACsy36V/LtGueK1ulQim/qntR0OipxJO+1waWjqby+0VFy1dBlOKbT1J3IrcFloEXDFRBiR
 PfGzn1okhRTgTT+/aDzl/foRn4OzhB32JChWbP0/1zi2h5ILZF/KN1AsVyKux/qK0yY+tRXelw8
 IgdV6zP8FfHGmb6HgBZaneq0FEEBPMkVnKjfO/KIyZYfkm5zggJxyw+U3r14/7NEGmQrVhsxt9k
 ySBlIkQu23LqKasfORKZJRuhMU/w64ahHZ2GKLeAjgbtxOYZ/9FzEe0sxeS+H6VXgjzn6HiWBFn
 ByP4pGuWmEbynRUwW9K63tnYaLhHuwKkWnSv9PafSVABq0kGJEuraZK2BdzXYAXeq5T2gsVe0aB
 GeX0e0aUsYv1lS/GFtvYl8ZpJjVwueFg==
X-Received: by 2002:a05:6000:40cd:b0:435:91b8:e01b with SMTP id
 ffacd0b85a97d-435dd1cd103mr3258152f8f.45.1769528898892; 
 Tue, 27 Jan 2026 07:48:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm43080090f8f.25.2026.01.27.07.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 07:48:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 3/3] target/arm: Permit configurations with SME but not SVE
Date: Tue, 27 Jan 2026 15:48:13 +0000
Message-ID: <20260127154813.591744-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127154813.591744-1-peter.maydell@linaro.org>
References: <20260127154813.591744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

In commit f7767ca30179 ("target/arm: Disable SME if SVE is disabled")
we added code that forces SME to be disabled if SVE is disabled.
This was something we did in the run-up to a release to avoid an
assertion failure in smcr_write() if the user disabled SVE on the
'max' CPU without disabling SME also.

Now that we have corrected the code so that it doesn't assert
in an SME-without-SVE setup, we can let users select it.

This effectively reverts f7767ca30179.

Note that this now means that command lines like
"-cpu max,sve=off" which used to turn off SME and SVE will
now give you a CPU with SME but not SVE. This is permitted
by our loose "max can always give you extra stuff" rules,
but may be unexpected to users.

In particular, gdb crashes when told about a CPU with only
SME via the gdbstub register XML with this error:

 (gdb) target remote :1234
 Remote debugging using :1234
 /build/gdb-1WjiBe/gdb-15.0.50.20240403/gdb/aarch64-tdep.c:3066: internal-error: aarch64_pseudo_register_type: bad register number 160
 A problem internal to GDB has been detected,
 further debugging may prove unreliable.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6e1cbf3d61..1cb30076ad 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1571,16 +1571,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
 
-        /*
-         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
-         * FEAT_SME_FA64 is present). However our implementation currently
-         * assumes it, so if the user asked for sve=off then turn off SME also.
-         * (KVM doesn't currently support SME at all.)
-         */
-        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
-            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
-        }
-
         arm_cpu_sme_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.43.0


