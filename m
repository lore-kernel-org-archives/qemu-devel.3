Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79796FCB611
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfv-0006XE-4w; Fri, 06 Mar 2026 10:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfS-0004qd-JR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:53 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfQ-0002p3-Vo
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:42 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so78506655e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809239; x=1773414039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vI3tRfXieJ6LwXxwODwDB21++TaLOLVhoaShPSqksNE=;
 b=fm2RfRF1KP8YBxphLPQUGEPjKPLuZloLA8dhibyCYsy7OGezRhBMMvxKKf965UXYTJ
 QW6A5kXkNx2r5RX0TzMf6UNf4eu7zTGVTzQQxSEa8SBtXRdmM1aSKgArHsx/JYCvB+HX
 6g9mAtRxmQCW8kTebVlELH/QLlBv0CwdC7dhxkUfSVa3/FGSLMpvy7W/noEjDaQ6plXp
 crCA3hwrSCn7CyBob2z3tldmY8DtzJ1yTJfAnw5nYcZ8ucQN5d5m/AQzr2v+QG53AKXQ
 Fs6i2/E5q3kHksMIt2tWTfd5bfk5BZ/Ib2kA3yVDRR8OI8o4ghRo3Qtdcu8Mgh26ad1f
 RfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809239; x=1773414039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vI3tRfXieJ6LwXxwODwDB21++TaLOLVhoaShPSqksNE=;
 b=ssRVRfJiis6pSnVCq5ByP27ehIH9a7Za23sqOLPhXGfB+6efshdniLcrgic1KDgAn8
 lgT67SjruvKUchfo+oK0cU+PagZPeHImHiaWARCuZxpi1MChNYF5kW9JhOoherhzGDPA
 gQVW17nwwNFNiZmVghBDPxQZFJsmNVRSox+g8fH4vi5lz3Vq7LamYlvIvgQw2vE5L83n
 AqEZwMfbzKcibtrly1V5OFv1hYaxNEdV7usnALO90ZmKGXQErl4j9oTtQQ3IxoI4u0mp
 EGz+iBb17DrNcpkSa4UpYn7vWFjtAwkViaAo6jRPEPBuoB6RsX4oLJRnhOvjNzS75Egr
 q46w==
X-Gm-Message-State: AOJu0YyqD0GC2l7bELyvi7KW/TqXsfX2Aab0pgvmvfnBUCurKppG9ACp
 cJxrMuJgX96ve+waT0f9FsguC96weI0aqcpdJKqmhp0ljgv1HUpBoNtJHgU1ZBfFtcXjCTquyCm
 Can4J
X-Gm-Gg: ATEYQzyfEUJsaXK2cJcGFYP8BGc5fEnPccINVbiIpZmUxe27oyrxfknYLj8bqkuRKTs
 nRu2hHrfNmFj18CRkikZJ9deg97pMG3UmdlQi+Bz/2uLe9Cgp2fg1uZrkHrxVK7+8h29VuH7hNj
 Ep9KVLDJ5ynW4rCefUtkuCchffm82myTfgJp9gTtWcei1zew6tuExVnpmBbYAWVsvZ1y6t5EvIx
 tc8J2crCx2ffw7Gf2zhVQ4xVNkr/XF+vecb/oKeUuOJWQjjIuvuCSOmH/wr0GU18pXIpBiMcts3
 yHejHeyZaDyWa6Qci0Nxm2/APdAYLQU1KdQftFDEA/KHQRXoRxZ2Dj969eFc22hrhkDZ7UV7tPJ
 wDBz5tkK22mXUwKNPrbc2Wu8mYf0NlfOWAfyxVZaG43zFEOAXxPX9qYOSCt5BvtnmV36sNCJ1X7
 wR9Mb8PcN7sxWtNOH8cgb7KUEreoJwxbo29sENXaT/YuGzjys0S0W/4ZAmkeig8Zgcss7JSgZ8F
 UUUy0aLQrR6PFcVMFWcF5dAAhLip1c=
X-Received: by 2002:a05:600c:8b68:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-48526969730mr43771035e9.18.1772809238787; 
 Fri, 06 Mar 2026 07:00:38 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/49] target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
Date: Fri,  6 Mar 2026 14:59:37 +0000
Message-ID: <20260306145939.2162189-48-peter.maydell@linaro.org>
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

HVF traps accesses to CNTHCTL_EL2. For nested guests, HVF traps accesses to MDCCINT_EL1.
Pass through those accesses to the Hypervisor.framework library.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-16-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6e41789ba8..0183dd8a60 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -296,6 +296,10 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+/* EL2 registers */
+#define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
+#define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1684,6 +1688,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1972,6 +1984,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_LORC_EL1:
         /* Dummy register */
         return 0;
-- 
2.43.0


