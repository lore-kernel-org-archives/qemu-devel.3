Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB70FCB60B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfx-0006tR-Ow; Fri, 06 Mar 2026 10:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfR-0004qb-AI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:53 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfO-0002oZ-Vd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso81294755e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809237; x=1773414037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b8W8+eBw/lWn8DHu/Zy0SVCpq9P1i68RJXoL2hbLTTM=;
 b=UKQwNkkE8FSnTummu8EezL1wb95xKKnKyLjSi3U+gLSHmfGw4ltxr5yIKfeJ+TrzO+
 /TOEZ4Pghy3oHA8SpxsUJTUQXCZ81nBA5Y0N0n15lfO8xRhzLgRR+hiKElzq4krlXNwq
 TADybDr3ol/slyibmk3k+sh6+4f6r6GsORZJyd1mo4XerjfH5wObxgvEpq1BQZvL2ntX
 9xXQbS7efBfmRCYVJ2LtQjtfCSnZjlfF9pt1UQBYPln8iVxr7yAfKUMWSqnUjZSQgoIp
 weu+NBkwdIV02vY6F6qmk9VbVvCkF5n1o8mcMnrkTwrDEM1M/mhkPJpVdkLVr3WlkM5d
 WAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809237; x=1773414037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b8W8+eBw/lWn8DHu/Zy0SVCpq9P1i68RJXoL2hbLTTM=;
 b=HhLUOAwOOMlGySRfmJfax9MHsaurtWCBpOzD4FAotzj6FBPNxsvJTBHYQbLYYmoFqz
 z8fuiDl4KSzlP82Fswheo5Nj7FPPzIFxM7IpBy4lOlqlvlPpbES8ZAOoQ3hva5oXiv9D
 FdtNtF+27Vhxo2TWrfGJgFcwmvl7qAJD9LlGPnG5Mncekd+cJUwVp98bCGCjF5nJ1oLX
 xvr68fKoGFRsuUjsSWrF9mUBvEGKN0QFy68eZmBh3bYxa/oNd/J2fgSdAXmaFMAVtkaH
 8TTW3YnrSKpo6rGKivCe/S3Lv9gAf6vITxyLC2Qz6jmRJJx8ikS3sC+K/dwp9AoxrSkT
 PLPw==
X-Gm-Message-State: AOJu0YzB/PZnMxwk5jymogGxOHzmveiXrLsFDeMxPKDEJsRP0IPc8+Fe
 ARYdkggkTR6/AEsELP7aGl56w38+pUj9jicBglaXAGm2gwPuzjRD7/420qTbcHnf8/h/rZOkgxV
 AoYFZ
X-Gm-Gg: ATEYQzynNR0QY5sCeg+R68C+P+TxS8GMgUe4Hhx7Fk32d91ASq1jBwp7WC8xRnt+Ni2
 l3r6IkjCaDuQqF94xoC25CNXiWZ7Nc2F+PfJ7CAZ/HuaGeYG3BVXaUBG5PUc+IL6IvycyrFhez7
 SP37TvuXWkmBsj6HHvdviIM6OLUcp7tVJYyg3VDxDtt8g1MxFOtQ1R9ojuNQuegnQuKTdqnfyOh
 Yr4bWmId/rR0DxTxXVTo3LPN/Jh0LFTMKTE2X+3tUeJXKia92OkBZ1PQt1AxOi/Rgp3m/h0thQW
 zaqQJ8CYLfT7/lXvGtAx8sfgWoP2vx3DkYTAElJr2sZEV1Cgi1Y4Q7wX0VDVB856OKKDjauLi+P
 y36t7N15QFXnmHKbnMTQw2UjcLFYsULgukvvqrsnTRPtIM6Ma+U30F/3Ijr+gnLZfdUv7M9RB+X
 92zMWvQgeuCIKzdYiANQuSPocOnAf/JlWTlSPDKhpAvztppKkRVeNpnaHnnzolX0ZqZSm2IReAM
 aZtFv1zJghptJvIUzdxevgOhte2PM0=
X-Received: by 2002:a05:600c:1d1e:b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-48526951ca9mr40185925e9.22.1772809236667; 
 Fri, 06 Mar 2026 07:00:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/49] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Fri,  6 Mar 2026 14:59:35 +0000
Message-ID: <20260306145939.2162189-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-14-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b50400d295..f8d5a4f596 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1669,6 +1669,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1959,6 +1960,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2366,6 +2368,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.43.0


