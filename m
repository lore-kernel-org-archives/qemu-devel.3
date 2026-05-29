Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97E4CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgs-0001iI-KL; Fri, 29 May 2026 07:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgq-0001hW-4Y
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgo-0008EN-Dj
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so262831f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055265; x=1780660065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OmMyNqDcnuHo19CGH900J404XhaIWbyUs/leN5tQe+c=;
 b=MPD/UGch1tlg6TjH66P1jEZPRc6zzNiour6KINQufeK5bXjmbnB+yCBDg3VRD0E2ZV
 pZDRI7hN/RJLZVDf5HHSUdGOowk00j83/qM6Ks6RLuO2s+dfa/ng+oTtW7vev/HxhVYy
 qt+qhM4mx60u9VHjOiMJTtzFbVxePRdJhXF0osj4gWPSvSdG8bmfkkZ+yhLJejdfbuC1
 KR+g/cDnErvHeQiDgQ3J7z4ZfnSwX5grZ3GONSp7JG2h0qUYxgkjIyKeBetshO2+IZK9
 yx5yYKN3DP79ndkg1oDBc0ztFJ7hVUBnvZ9ZrHySrZq+eQB349mK8SUrhjk3areTWaN2
 1ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055265; x=1780660065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OmMyNqDcnuHo19CGH900J404XhaIWbyUs/leN5tQe+c=;
 b=QHELzUP/76lZ7sd6UC2ZteO0AjFMaW7sb3zIFUbHnEfBbFVkSmUSFDaWyU1IZ+myz7
 fJkkV3p0NDJfmpMNK0SusbA7yUoC3nUhszR0a4hM21FvwcK0cGFlWlt+puScU6+IarGV
 wht4ADN5AKykCybYrg/YOU00IuMjRfQHb8N7v100sexchUZ3IuaTzS8+1wz0L41CVwyD
 w3xyMZfIyU3g6YQ/ouHDYMPe6vFcJK0tPkDh4bymf2GJBwx72spmdMw/4Ku+OZW7YK94
 J1c6BcXzeXXtZMUTYLFUkFhOg5GvTh/RVThPjLAWl4U58SYoSRnXY4t50t1xKfH2U1An
 iOUQ==
X-Gm-Message-State: AOJu0YwxrfEg/dhwe3dsiX6soSP5LScTJzCkRa4kaOtkBbpO11smSbJ8
 4vLpalFL1ttEQvX+mkgNn3jvVPny3FioLGHIxKOA0lO9XQUh0DwdV9vnquKFr20Kc6JwZy3KL+M
 kr4UI
X-Gm-Gg: Acq92OG4aNWu+2MJnymDIGN8jpNaa5Iv03V0mBeEjyT/s2eVIdzZLR9PSyxQkCDIXgn
 LXrlHOT4+h+9uVQ8fKVOXUMQoVBGrffAWoCRJwtbjvIolCQCcnU1GqpgECk7XyuiQBz/GposaQX
 9aZCNdmPtJpIKMx+4K8R7oX1Jl0Q44J3R0RML0GpdFpWa4Wxodizx/OBAN2cn54G+z/ftKz8nT6
 wpsCIBAcMaynzs983Cib1ARGa/di4MqX9P4Kk4b+76iQtV+cYImwc0Qqlw9G5uLPgflEmeoy3re
 klLK0WXI7zQAyZ8S0tyJouEyCYngm8e4GjSk69DS741DI+iJx+SXoQnWR+vGe6ba+8+YZpavnmt
 kYAjwcb6ZDH463KQ8LL5EhQnSctugtv2kKD55HFvMaEdNS9z9ou3X307oEdpQWPwEUEpegq0nYn
 MLY8n8CMg8it9ahMk0+Y6pQujWxAq8LLTDFxVSt2dKe0wfhI2H59yjfO4pfRw4W1s+UkxHg2qlp
 XgMKfqGhS1G6SyvW2vSKPV5OiVh04WhrM45etZmgw==
X-Received: by 2002:a05:6000:41f6:b0:45e:f585:2b7f with SMTP id
 ffacd0b85a97d-45ef5852c9dmr925922f8f.32.1780055264649; 
 Fri, 29 May 2026 04:47:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/21] target/arm: advertise FEAT_RNG_TRAP on cortex-max
Date: Fri, 29 May 2026 12:47:19 +0100
Message-ID: <20260529114723.42040-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Jason Wright <wrigjl@proton.me>

Set ID_AA64PFR1.RNDR_TRAP=1 on the max CPU model so guests and
firmware detect FEAT_RNG_TRAP, per the Arm Architecture Reference
Manual for A-profile architecture (DDI 0487), and document the feature
as emulated in docs/system/arm/emulation.rst.

Signed-off-by: Jason Wright <wrigjl@proton.me>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 37ca4e47b8..18c6355967 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -136,6 +136,7 @@ the following architecture extensions:
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RME_GPC2 (RME Granule Protection Check 2 Extension)
 - FEAT_RNG (Random number generator)
+- FEAT_RNG_TRAP (Trapping support for RNDR/RNDRRS)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S1PIE (Stage 1 permission indirections)
 - FEAT_S2PIE (Stage 2 permission indirections)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ce76e09d52..1a4f50486d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1292,6 +1292,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* FEAT_RNG_TRAP */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
-- 
2.43.0


