Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F6EC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmL2-0006RE-9r; Tue, 30 Jan 2024 06:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmKo-0006H7-0f
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:31:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmKe-0005Oo-01
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:31:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e9101b5f9so42775345e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706614270; x=1707219070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcqZ31sxniLOzI3SY0/z0idfpzeqrHKXR2vxwlvPTP8=;
 b=CXIFYq8ZZnLuzdCp3s/q6Lc4uagJiP1FvPKC82t//zoTuNoIvMYS3j+7PH1fEObg2V
 7vEvFaqUm9YBNXDsVkW+w1iKbp5rrVMgwJbo0o+HIPcU/0x1TiV8VezzRFerZ5FD4WD1
 TBJd6URmJZOkB8pmLKm2d5SXQd7rARh4531NDQERaQoVFF1RGZckY4fao/mg8ji4d1QL
 Sk+5NMds5vlGZE0jdy6yGADTlN9+Erx+qFHGAUe8iOOfwXFeo6b9jzNiA5NBhkR/8g06
 N6TPOcu3O5HUOFloJgxUBpbr7/rQeBxGJzs1I8wCthRLm9PJ7FbgIStIAaruzJeDHHK8
 c3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706614270; x=1707219070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcqZ31sxniLOzI3SY0/z0idfpzeqrHKXR2vxwlvPTP8=;
 b=KNxGkzpsIrU/LGW+YGNmsEpja3N4hIkUnKNQ+AiHgChC4aKXzAp0JANM5ekSVbiybw
 /0IC9sOd5DkKieLa/H/oZywRFA8uAjZI7LmMuk2E9S6Zm3B4zMMOu53o3Nzx+O+AtKcZ
 sEgKBik0FJyqk/TH18mVvIOfZ6/HcDbaBZKXb19/K7E8NdNYxd778Z4ZuaaP5QexOxPQ
 IyYcvpA/OrkKylaIx8E3t+Scn8QYjpID3pKQi6biSiF6tB5Q4y6j+/gzS9FqDz52rr1q
 H+TC8U4i+IaUVjeMryLAppkNv3lZnm1espxHlhbmHy0xwzKn8sVSS2gwRyA5QUH25oLp
 Ol3A==
X-Gm-Message-State: AOJu0Yz2EqUS8Fu3WiqeGye/yewbU/aTlHx9RQ4zO38glDkVWh/cZI1x
 jCJUSQ3Iv9IzPLqlB907OZqL155wJpFws2Pqwx2PtgCpWsXarRIwul0w6AQbljtdCx9DgnHudLG
 k
X-Google-Smtp-Source: AGHT+IGTRTlV5tJ2vqnH0C66VusvvAuoNIPvu1+ybBeRUSp0hkL+Pfylnt0R+zAm34U3IUJhWDqnXg==
X-Received: by 2002:a05:600c:1396:b0:40e:d425:85a with SMTP id
 u22-20020a05600c139600b0040ed425085amr7573143wmf.17.1706614270186; 
 Tue, 30 Jan 2024 03:31:10 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c314d00b0040efb445698sm3937420wmo.5.2024.01.30.03.31.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 03:31:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/sparc: Provide hint about
 CPUSPARCState::irq_manager member
Date: Tue, 30 Jan 2024 12:31:01 +0100
Message-ID: <20240130113102.6732-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240130113102.6732-1-philmd@linaro.org>
References: <20240130113102.6732-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

CPUSPARCState::irq_manager holds a pointer to a QDev,
so declare it as DeviceState instead of void.

Move the comment about Leon3 fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 12a11ecb26..d02684569a 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -548,10 +548,9 @@ struct CPUArchState {
 #endif
     sparc_def_t def;
 
-    void *irq_manager;
+    /* Leon3 */
+    DeviceState *irq_manager;
     void (*qemu_irq_ack)(CPUSPARCState *env, int intno);
-
-    /* Leon3 cache control */
     uint32_t cache_control;
 };
 
-- 
2.41.0


