Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5342C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUj-0001Wl-4E; Tue, 28 May 2024 10:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUh-0001VX-Si
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUg-00072U-9c
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-354fb2d9026so761319f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905280; x=1717510080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yISSHG5pyQA29zkBCoQV4o7C+tL/0qrYSueTe3e1ZIE=;
 b=MSuPn4vMNdreeioxo0Xi8JzhsQZozxn9C18cDiQcdEd1FcJuYLhY9oqclq6tcMPnj+
 o4101bo0rXaj96U3X9yJ3wv3cwEURrAJRCFiCICd98nv6YGPFKymerM+YEmaJ3/Zu6oo
 nir9C/0aoR8+5KFAPO1tcl6C7ofoWWT7PqF62peFb0FFnrJzP8IzX+PIq+mG+HFienJu
 +YElKhqr9neevEY4rckaC/x6txxOs5lvfwB/6AoG5nRPfikh3Xl4uvP/JNTGqFRZj+T6
 TnwnNlMLigO/qVx7I/gPgdd8V+nDS1GGVh1svPlsxG4bAvMzYAzwHwaNFGLNYFbOyLZ2
 jKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905280; x=1717510080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yISSHG5pyQA29zkBCoQV4o7C+tL/0qrYSueTe3e1ZIE=;
 b=II0VDff2atUH59EkrCHbf70SdpRFJ/PyrK7NDqVLHFr8wcgEG/aZywNZx2nyU19KoI
 bSLaZ+I/gb/GXFjY9fxBn5I+9WzcKmiEecXzWwdCjKIIxDgY4HDVOEL0uNN9bEng8psr
 qUClqgtE+2s1q4RC+C3UWGdhK4SdClvGdEX0iMcN5qQ/7OGhALxNCRUzV51ZVp+F7K6I
 uLEEE9OfzBrgN/C4sLdSa7B3fB/lx5JPHgwU29UYdf25wzAx+8COZF0+CuQHencSseXd
 6fs/oYU0aw5qs8aSnsUipHBPtCswwGLpWS/OxXxDa2iblJ5w/7j9JNMkg+92i28Xq1sz
 y91Q==
X-Gm-Message-State: AOJu0YygE+7uhws+06RsMSlytYY482Rn/y5UFvxikxk0+NulU93KLxUb
 if5bYsrOmdKVeiv6BtDxrWYLnCYQtKlS5q/vH6vr7FFgTF+69v1zQUOA4AabAW0A7iTGOjqEt1c
 X
X-Google-Smtp-Source: AGHT+IHun8PTYUwCJm5PHduLbE8SLLbAxH+hM6tkEadGQoeYMPnugQPAXUkGOEDxOUav1KZ1VME8iA==
X-Received: by 2002:adf:a34d:0:b0:354:dfd4:4f4d with SMTP id
 ffacd0b85a97d-35526c2b6bcmr7451490f8f.16.1716905280603; 
 Tue, 28 May 2024 07:08:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/42] docs/system: Remove ADC from raspi documentation
Date: Tue, 28 May 2024 15:07:19 +0100
Message-Id: <20240528140753.3620597-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

None of the RPi boards have ADC on-board. In real life, an external ADC chip
is required to operate on analog signals.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240512085716.222326-1-rayhan.faizel@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index fbec1da6a1e..44eec3f1c33 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -40,7 +40,6 @@ Implemented devices
 Missing devices
 ---------------
 
- * Analog to Digital Converter (ADC)
  * Pulse Width Modulation (PWM)
  * PCIE Root Port (raspi4b)
  * GENET Ethernet Controller (raspi4b)
-- 
2.34.1


