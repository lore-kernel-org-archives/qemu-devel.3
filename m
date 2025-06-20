Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848FAC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6y-00067z-JM; Fri, 20 Jun 2025 18:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZ0-0007Kn-7Q
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYy-00063O-Jq
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so23694955e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440603; x=1751045403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iybpIqNYDXtaxMVwJDR38EuPy+jqkF5Lz6BY7zYgAsM=;
 b=UrJRXwsGlg/MFg2Zm0BTERlzLtzL01E3voLErE2RndiNGnmOhsgoIzyyT28B7o61Lg
 If71nlmN0xJjOcKY+LW18klt1P74TQQgmcK0L46AW0yQNWwwoGVlZhLekCs6vA9Sp5i1
 Uu7llIJAcewkAivJDCP1Y3fpzdicWHH+XTyxvnO4c0MRwAYY8O+K1um/WO9vIzy0pf+Y
 poHk66gUzqtZ+wBSoNWtNRscULgOaet4AiNnKLL1Wq4VxMSWpqzhmdfmmVw9V1mDdhxy
 e6Fg4fukooXks4LtoiFSrhcIaB2/fjpCNskzxpI6mq0XRbu2nHs2XYZzTW6TY9Z+o8vK
 Q49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440603; x=1751045403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iybpIqNYDXtaxMVwJDR38EuPy+jqkF5Lz6BY7zYgAsM=;
 b=U1NZBuG924TQ5gC1UbuG5r0dLPp2h23dQKshwlfuMMkxA9PSpPP7lu8USY0Qta7I0q
 S0eDcEqYQhVDWtXvDXPZPn/fYxQ4Yzw6JNGPMTb7MHyTqgbatlVKuF1tHVS+4Hclphbb
 gGRB9KGSk1sa5IWc1dtLCwuorWk5qKRayUbGtQRadtSapkIdwifpkIzkDJpx2+EwHxes
 3T/ZBBglMMoUGXAuIWlWGaUf7DE/mbW11sl8mpXZtWX34PHtUjE2FTUss7RfzSYvMbug
 Dggk4aAWh8qA7KPx1JP56kyLEf3013Fzg7B0bPMKNT1aQtrUznW62+M1Bn+m2TPbb0vA
 BLpQ==
X-Gm-Message-State: AOJu0Yxkh5uPwHMFHjB0grSZP3DtYR2x+4vU8PctZFIloRDGJz9V9j3D
 utstUqyy9Li9aQduEg2lBYKTzOzoxvL9TG/LOQ0Z82+WRbxaS6eh4Rc4GD0I+a2idg7iVnZvCnP
 08gXaFRzr6g==
X-Gm-Gg: ASbGncvpJLp9Tbsvrmm/u+JmNIMr7+ojTYXrNmhWfqQuZW5enZv7wYIEBSSfN0uN3AF
 oh7GS25VNrH8Wmz9MqP9hfz41/6KiiUztVnSa+u4zUDeBC4v/FP6vsSPfUZHFKqCi/KeY2QVrQy
 64ruWKSqhd/yNYrxZSBztVWuznblQCJRXAB4QR3sVnA+ztumPH6Ry546AcsTx9Iw+zVlVXSgwLn
 +fvMsb782hb1vfoAYLI7/6vJvRMMK/G2nDUga/jiuIzJlPtnfVt/pzKET18CucrlQOpmdfiDRQh
 MEIrYOBVZeoxtmODRx80iubg8oZPMhlx4GLdHEPHDpZBX43uUe2nc1zy8wbuKQJ2YgNiHnwn77b
 N8aNku+8VvwQoU+0TH+GsoYVyKHw6jbjG01w/OMLpYrsgQaLCNzhJthXM
X-Google-Smtp-Source: AGHT+IHfact7wtx+xAYOTYuJuPSmotfWfDLDnvP1qCcpEpCjQbcRlPxzsMMNFbVzVK473f+KbbZPzA==
X-Received: by 2002:a05:600c:b86:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-453659c0bb9mr42706195e9.14.1750440602741; 
 Fri, 20 Jun 2025 10:30:02 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eada7adsm66362905e9.35.2025.06.20.10.30.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:30:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 16/42] accel/split: Implement synchronize_state()
Date: Fri, 20 Jun 2025 19:27:24 +0200
Message-ID: <20250620172751.94231-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 65feb929404..80efbd82091 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -165,7 +165,16 @@ static void split_synchronize_post_init(CPUState *cpu)
 
 static void split_synchronize_state(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    if (hwc->ops->synchronize_state) {
+        hwc->ops->synchronize_state(cpu);
+    }
+    if (swc->ops->synchronize_state) {
+        swc->ops->synchronize_state(cpu);
+    }
 }
 
 static void split_synchronize_pre_loadvm(CPUState *cpu)
-- 
2.49.0


