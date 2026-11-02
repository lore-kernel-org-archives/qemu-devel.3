Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969D606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pkg4ynre
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDp-0004oJ-Pp; Mon, 02 Nov 2026 08:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCx-0003Bm-30
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCv-0002Hl-GD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so19848445e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626576; x=1794231376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V19gKFWSB/VMXzSwd+FiQPpRV1yPP2SZqVVCkomDGLg=;
 b=Pkg4ynrerytYfkD7k2/WdFjhHVqIOgNJ0zmhYGvyRuqRV+fe7lwGUnGF2/XXs6roSB
 8HA9jUC/ozyNTyZciatYGywr6rBN9LmmwApZBhoMh0uUK3eZapb39QObQR2TPMlLZs0a
 ghzZtJeqsMf/GXJU8SkoodlspQJSS4tkyC/b6fMkSqwu0VhOMdGc23Ixe0CZszI5yXPr
 fj7FMehWxRKbrAysfhoCB/VvR+825FIC/JLfa5JbooKCKZeNYSyq6ttRUgPpy2XzMFDt
 eM7FntGlVpuVY8I8f348uPpqJH9HcEB+9kyboCOq9mRLxu+cyqgfDr+LJP7qegTXZVOa
 aRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626576; x=1794231376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=V19gKFWSB/VMXzSwd+FiQPpRV1yPP2SZqVVCkomDGLg=;
 b=i3uP55Y+9+SA037zzfv2JGwVom1R/5Ke0eAwJrNTCDCHtIMGTmIAXUOQONDmbVXNWx
 Fh01ireiTaj8bOj0GW8scKQprQ3uGIzK3PQPKeb7/87Dtjf/wrb8pHHA4aMcRPiuusHV
 nB0CSNa8kyY8+NKt/XxtOLnnzllkBO7fK+g2vMlT6FxoLCMc7uZ44AfeK2CRVVkziwMQ
 GWNTESp4VTDeZ2A0URGlQNIwYKOQj/OKG5FPtoGQekLfCxtFzhx7GrzfOmwYhu8iTl1Y
 B5/nsVXOPeayTV2DkfT8sd8z4I3c/3Mt2lXkCr3aWkd+WyFss/gR+ORbfIVH1DOBPx/w
 w1WA==
X-Gm-Message-State: AFq9FYK92q0/Mm8A9mIwy/CqpFNCLw9Gzz3LlSf3ncPsSNFY/DOEGVlV
 uG3jFr/8yDnFm9RM4r+mXcLN6Z+O0pk+zGM71orOzJEkW0boYtHgT/Fqg5ERF8nZvGm5lrY5eT8
 NEQJhWic=
X-Gm-Gg: AYBFou1iZJRoVyVQuKrnNNeLL+f9gjqiZTi8oDmFBbOcRDo6zv+02kLgg/8KE2dGjcQ
 W3FCF2DD70BueIZn+dslhg/QVIYqa5d5vAB11EuHoXIcMfmOssELbFPQqYC4LUW5PVNV+9fU9oi
 Cu2akmSiyMxP2mZPEa7SR2lhzS2OQ/L9KxXXzGAhkL/60bX2ivcVSfeSzDLMJnrzNRvm2M5Bsxm
 rLYQZoV6VA4gUe3Y0zj2DmfiYBksVK50ITReligoh8wQoX4AAcc+gn9PzGinsy4xb7JXtfCeF4U
 9raB9p1ZFSUDwU0gIxpxCNZno3MB6bj8buPz5rd1axgmYb6lzwxEklCEQ3q8R2maw6eaeirDszh
 jFZByG7PcAurTZ+Nxjs4zP1NT6wrYmD1HXMM6DLNsjO1Nw6ovBmN0EZTaJMVKfrvnBmrckA7rK6
 bOgh1V6YB3TEhdCHQUQ/v521mYqdCnSVNWEf1ln5ttf7U1eDf1GF5TCAZNKfaGjgiTMI9vh6wdZ
 FcpsOoCo5FMOoHOqKnVYHnF4ONMxG9tPCrp+rzUo4w2q7++srCSOk0oiedbx6OWCknStq75BTff
 UXLB6MS7WZODcjlN7Rtd9sqq8rjcQfeBJEzya9JFNK6E3WPh7oWxnFT+vCXKCtl6mbuvEpsUPPb
 FfbaKyrLTaJAdPs9UblLWJ12ZOCKgq7XNqGz1S+NyJABgYKHjqsBeEYY=
X-Received: by 2002:a05:600c:198e:b0:4a0:2488:71cc with SMTP id
 5b1f17b1804b1-4ac1932a23fmr238922845e9.32.1793626575953; 
 Mon, 02 Nov 2026 05:36:15 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/47] hvf: arm: remove broken ID_AA64PFR0_EL1.GIC sync
Date: Mon,  2 Nov 2026 13:35:23 +0000
Message-ID: <20261102133547.1375701-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohamed Mediouni <mohamed@unpredictable.fr>

The GIC is only realised after this executes
in arm_gicv3_common_realize.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027120135.53048-3-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6085ac22849..5213842d2d5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1480,7 +1480,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     assert_hvf_ok(ret);
 
     pfr = GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
-    pfr |= env->gicv3state ? (1 << 24) : 0;
     ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
     assert_hvf_ok(ret);
 
-- 
2.43.0


