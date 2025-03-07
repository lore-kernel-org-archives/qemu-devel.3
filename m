Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68703C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd5Q-0002UY-Jv; Fri, 07 Mar 2025 14:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5N-0002SS-LL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:17 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5L-0005tP-WA
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:17 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2243803b776so14385415ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374614; x=1741979414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUvuEjETtAwgjY+HHVzD3fRoYrhNXj1rMDKPunM+tus=;
 b=oRbZAMptERwKgN9vr8yycj1WTFLoKreqTRL7vPREKYNOoKgutSX306vaxtioCHiBTp
 Cv/AO+XNohghEumv2rMgaelYiVTRe66B9TRphPiYnYDypn1TwvtSu6oPponddCSVWqiA
 Tq3yJM382Ogx7TrhVsHFGldwFsYeVqIbn6lSvC6lCYTHYvqX4gc4loiHoi0ngvbNZGFR
 sXM6ADV3oVq+7bcirJnvnk1AYde4aEpFF6M7pa5eC9Uenrm6PWFNaXCLIySNcfGLvujN
 0m4HCisVKVT0aYOLI6HwQKveNet4AUn8pkZxOdeL7D0SQQ4jBiGfDhVN75bk1ifzf8ad
 yVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374614; x=1741979414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUvuEjETtAwgjY+HHVzD3fRoYrhNXj1rMDKPunM+tus=;
 b=WHnMEo+1t76aua4mo1J5ftL0epUSr3JmZ7Rk8fYBY+yRZQQPRC+UbhDzJUB9c/+jeL
 G1CGeVvgEE3aGvUC3WluFhdvlVQWNVYGMCZlniexGzJf14qYZxqaxCjWd2G9ZlRbGqQp
 BNjvhpcFzgb6U6cjzHIvi2xG965J+K8dps4CH4/WFNsXfxBP/tcGS09OxqpcY36NA26L
 nNxHrknsGaLDgUAogIZzsS/oPWdTJKtXxuWtn/RdzLp+ly29dWTPyM18FaXoaAaJTnvX
 tKFNQfudVY92Spmx1yWa40NNz1gxbKFF6imlbzYg5FSD1KASHZwe/Fdej25iXPE41UvM
 cscw==
X-Gm-Message-State: AOJu0Yz+i993mXLfaAXrsVQLefsrKFcp8rIkrWILv6YeNW2znRmy9eDm
 gqnZEgU+z4FLK5AdNeektK+ef7uw769frmnqxX0Dx6mznBG8h+b2UmhTahlArlqaFwAzmuxwzca
 +
X-Gm-Gg: ASbGnctPXJSyHaEP2/IFckasUXqlZLCQUjG59yjWV6laZfuEOsMI3iUEnLYOUL/k7UI
 5UsojGLStyS5az7IqLDWDesEPfT31M37AkE0FPPByI6eZbZ99WWF1Y+ek+36yKbuz2gE6G4jQLa
 KqV4Phn6BE2LjG72+C6oiIcOlzQO/48Y40WkckZK3MpIAYTkcf2ztsS+A30YBpyahRrwdemop3X
 WkT7yKI8MegtBIPeI4d6RCsJNg+6aoueCkw98Dc7G61BMeNO6Ce+ENkCk6+R8cyE6m9Co32Ushm
 78KHcwPFBkoksx5e70emifVW8GMrugCSwErej5hV741e
X-Google-Smtp-Source: AGHT+IEbWI3ew4dnMWaB90EaFVDpeNVLWqjEG4CtmHYP2FlvgISb0XWr+8NvwuKEf/16oY50uVRpzg==
X-Received: by 2002:a05:6a00:2d90:b0:736:6268:9ec9 with SMTP id
 d2e1a72fcca58-736aaadf12bmr6908832b3a.16.1741374614354; 
 Fri, 07 Mar 2025 11:10:14 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm1449895b3a.149.2025.03.07.11.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:10:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v2 4/7] hw/hyperv/hyperv-proto: move SYNDBG definition from
 target/i386
Date: Fri,  7 Mar 2025 11:10:00 -0800
Message-Id: <20250307191003.248950-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Allows them to be available for common compilation units.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv-proto.h | 12 ++++++++++++
 target/i386/kvm/hyperv-proto.h   | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index 4a2297307b0..fffc5ce342f 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -61,6 +61,18 @@
 #define HV_MESSAGE_X64_APIC_EOI               0x80010004
 #define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
 
+/*
+ * Hyper-V Synthetic debug options MSR
+ */
+#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
+#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
+#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
+#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
+#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
+#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
+
+#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
+
 /*
  * Message flags
  */
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 464fbf09e35..a9f056f2f3e 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -151,18 +151,6 @@
 #define HV_X64_MSR_STIMER3_CONFIG               0x400000B6
 #define HV_X64_MSR_STIMER3_COUNT                0x400000B7
 
-/*
- * Hyper-V Synthetic debug options MSR
- */
-#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
-#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
-#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
-#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
-#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
-#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
-
-#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
-
 /*
  * Guest crash notification MSRs
  */
-- 
2.39.5


