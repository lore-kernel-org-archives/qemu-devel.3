Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E70C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxh-00025i-QU; Tue, 28 Jan 2025 15:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxf-00024y-JC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxd-0001Z9-UI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:27 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4368a293339so69454175e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095204; x=1738700004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hHXxqZ+tVJ7h5O+PcXTioqACZjbfliXNoTPCp+HTPPw=;
 b=NlqGBmAcZiIJTcU8hxpI7uOTXvnZUay9KRqu5l8y1ahyqUWxrTUAhgTVX+Pbc+EExe
 aBFlxPTYZyNsSLr0MhaWBiUDyuqJ+zyAaSgIGSmTPqkHo61SzzbjE3BjX4faADOK6yUv
 mlwffx8CvU7cGrrdicU1hwMsEw5Bp+6s7hB0HO5/wqbphg1hZs60h1Lo7uhIABcmpX57
 u+OIgmZEyEWQUzQ+yY5t9OM/wYsaNoRmNgob9ujLvd92+92+4kTlPCeamn8GFgBvvz5m
 mP2lvQpd/Xvxm4bM8WdqZN2NFZtigWXbPlXgBkFbqRh6swjqgNNBZ4YcGtc/q/qfDmmt
 9Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095204; x=1738700004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHXxqZ+tVJ7h5O+PcXTioqACZjbfliXNoTPCp+HTPPw=;
 b=oH0r4aMLJDUk1tBg+BTeOs1uifk+BwvijKuMppLJESxZyLWYs0OnmqmFVcBuTdtc6F
 JtAIRoNb+c4ovbG42zANaH3mMlRbMVcgRBEW0mqaxCtgRT0xpl1ImkD7DJqo/x9XZWDm
 tf/FIBZonpw3ukU1yNX6ayrpGnwIGkYoRwke+5hFoPcG+gW6Z0KozeOsISeZo/sXZs9m
 RbSHur+Wsk5XOgRe6f+W+GUFYwLEL5h53zZbwdscmQ5gRK7sncIBmz6CfBYc2RkbqVJg
 6qvjc8Y3VRbTJAdfMVPgsYRkrHF2tALEPwQ3qgKz0qD7a0fODS8nwLC/leThcMDxLcU9
 Fb+g==
X-Gm-Message-State: AOJu0YxztFTIrqLpnvYTrl49yNJHdwsd+qBr2OopRe5VtfDpvzTuPtU/
 SvCN0RbZXv+Dg0qYRhqf8vt+Vn8Grshl2KQHzkW9J04mduOiyktuDhLi62F3Q0XW+zrxLNWaxow
 a
X-Gm-Gg: ASbGncu5tIrIydemOZ/NLXeastQwIVLa/GiDQn4aHyuuGd7KOaFV8oMO9m4FDfp859E
 UzxFukWUH+0PrgoePl4+bLlBKDICSmf/8mF4s7di7p2gn6/l+5Ja5+NCOknhQ/hNDW1w6MgMaDm
 Ej6l+nalr5CMSSgvZmoIGAS9H452xuVrkQ8tDsHnR/+sQmZBhESTIjseaNV8sTD1oQ8Cg+NCubj
 YeTqKx2QjVzOIA1sJDQO+n/r48Zd2XsDxLwyg5Dc5BEA/r/KxKSfZR9rvfpwZ4wTGi4bWOTQsYy
 OoXbIljo6bSfCX/Y/yn+IQ==
X-Google-Smtp-Source: AGHT+IGOayBPNYcWSP7Ur4JAWtsu7hOeJ8//EpmkUyPeuSTqr8AUZBt++X5EM8JWXrT0sLP8S2qOmA==
X-Received: by 2002:a05:600c:4594:b0:434:f9e1:5cf8 with SMTP id
 5b1f17b1804b1-438dc435389mr2754225e9.31.1738095203896; 
 Tue, 28 Jan 2025 12:13:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/36] hw/arm/stellaris: Link each board schematic
Date: Tue, 28 Jan 2025 20:12:45 +0000
Message-Id: <20250128201314.44038-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Board schematic is useful to corroborate GPIOs/IRQs wiring.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250110160204.74997-2-philmd@linaro.org
[PMM: Use https:// URLs]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 284980ad4b5..3f525d2dcf6 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1380,6 +1380,10 @@ static void lm3s6965evb_init(MachineState *machine)
     stellaris_init(machine, &stellaris_boards[1]);
 }
 
+/*
+ * Stellaris LM3S811 Evaluation Board Schematics:
+ * https://www.ti.com/lit/ug/symlink/spmu030.pdf
+ */
 static void lm3s811evb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1396,6 +1400,10 @@ static const TypeInfo lm3s811evb_type = {
     .class_init = lm3s811evb_class_init,
 };
 
+/*
+ * Stellaris: LM3S6965 Evaluation Board Schematics:
+ * https://www.ti.com/lit/ug/symlink/spmu029.pdf
+ */
 static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-- 
2.34.1


