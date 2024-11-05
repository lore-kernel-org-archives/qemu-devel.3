Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64FFD1268C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hig-0006zR-Q9; Tue, 05 Nov 2024 06:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hif-0006zH-FH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:27:33 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hid-000825-JF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:27:33 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso879638366b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730806050; x=1731410850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B9iPPGInxZFEJeivG1/w0WhkOP2pUxlITSIJKqo2Kuc=;
 b=GK0tnZQnTpvnX9vPYj2PH43AIf20eEaqUsfox6UPpfojp9NrSOuKq3M5m/VoZKiLxj
 na2M1fuPqLe78u6TqQ4t/Wgfloj+Pvzamrz/HT8qvsU0t4zgLelw6ApO02b1vTrhfNxo
 L804kMPK7VzIlgH7fcyHnVPLf/CQW1LFnDq9VqTYuLDdNCw6hRC8nE0gy5EcvWyAyYAv
 haO3kAZITXYGrxoDTT/ULhanYE1mcytWMpnqktca0+LWJFky6LsurqjrVNqUrFo5JYYN
 /ulBoT3wj8nFVeUi6W8RF6RsSXISgK0mlDl72xsrZxVRuRuae0DJyLJ+dH/HEXN/7/5s
 Ic+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730806050; x=1731410850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9iPPGInxZFEJeivG1/w0WhkOP2pUxlITSIJKqo2Kuc=;
 b=pWtR6IaTODbPFuS+2GKbdTmuuW1I+MUXWNWWdUZwtDBvA27OOHaHsdPwAc+n8QPy14
 WjfCEOgKUpg7kh1Nu/yBXfABu4ui+fhTpF9YI6gtdEYP6gxLSfluIbn+HMHeISlsZ/UE
 ocnYM7CiBID9n4hibeShnzEa67tW92BwIEZmfFiXsEZL47TJBOAI7Kq2IIZs6ssl/Mh/
 3ylipe84tWzbKDuVjOo7dtnLk1T2ad9VID2mVlKsOpbeHqxm8yH8PhvAD4Ah1CP9vn3G
 2Zp1H5hpXiF0mtsQdJuwkufExQm76DtgvnPJrMWnsSmJ5z7LEpA0ZpVJNr+3QRQn5mv+
 b+2g==
X-Gm-Message-State: AOJu0YzQNWtZIaXxvbioiNOYZDueY+G04TyoKMDCE4gE+dCj2p8p0rZ4
 cFDa37FNbpJAjB7sesOVc966wKdgxl6RcRZqWdqUVbzJ2wTH2npZURGFuvMyc09Nnlp2Z9Hwu3h
 S
X-Google-Smtp-Source: AGHT+IEn6E7yXEFj50GjefAMjWW/EWcA6sBtcmsJNc9vIQ27FsBd8LCo3FK8/BGcqbS+yVLgSwCTGQ==
X-Received: by 2002:a05:600c:46c8:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-4319acb17a9mr329518575e9.16.1730805587592; 
 Tue, 05 Nov 2024 03:19:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/31] target/microblaze: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:22 +0000
Message-Id: <20241105111935.2747034-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

Set the NaN propagation rule explicitly for the float_status word
used in the microblaze target.

This is probably not the architecturally correct behaviour,
but since this is a no-behaviour-change patch, we leave a
TODO note to that effect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-19-peter.maydell@linaro.org
---
 target/microblaze/cpu.c        | 5 +++++
 fpu/softfloat-specialize.c.inc | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6329a774331..14286deead9 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -202,6 +202,11 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
     env->pc = cpu->cfg.base_vectors;
 
     set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
+    /*
+     * TODO: this is probably not the correct NaN propagation rule for
+     * this architecture.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
 
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index a5c3e2b8de5..40cbb1ab73b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -406,7 +406,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
-    || defined(TARGET_I386) || defined(TARGET_ALPHA)
+    || defined(TARGET_I386) || defined(TARGET_ALPHA) \
+    || defined(TARGET_MICROBLAZE)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


