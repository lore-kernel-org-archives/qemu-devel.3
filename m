Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14FFC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2bI-00017p-4x; Wed, 02 Jul 2025 14:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2b0-00015Q-Uv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ay-0001ax-NN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso3067090f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482450; x=1752087250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=iDZ/DRp/ddcI6+wfOL8Iibh6atHb2tb857VklA2NYp5ts8GCXZnreApvDuhm0HBX4y
 OuTKUE5642mMq7oWzXrXSoa1df9dD3kTSqODtuhGvKPa8xaL3NXUl2Yf3KNvhgNQ/tbq
 Imdod6h6BQlZl19aNNSbkHp4wf7UmdseOcWTTsi0FLFovCoh0iRU0Bh3X1qzIRkM3bHR
 NurKI2Ng4wvjvUhPC9CS6qTFsd6b0IO6Yl9vBFJu/rX7YK+98aspDkqVGFyR9k+QKRKd
 70Jn57H8KAuX1beLeQBC8Xm0kl77OgKocoh54fJQ3h7r9ig4YlPaozMTHvVUGk5oX6sQ
 zmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482450; x=1752087250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=F99Tl/LYg45N/AYxd8ucKi2W/ZGrFNBl+LduEPo+IXsCJFGpwgICjpuadDzkcuPR43
 Yx7b0omTmpJfLB+SsOb5m7C2EoDSvjYjvoqNA2uElbZg+whZnnB2r/ZBImifl0Q4xZID
 +b8HHYFVbY7Cq0Jyo6VKjqja8ulvIvHxuwmB5iF5hlHMHSK3uHCYC54NAdDcUpUc7mvR
 lMNZqtsQ2fyt4ID1rBBGOd5A/6h7vOa8NMz1z5NzUiToAt8tOBxdlvrsCgnXNqOia8KL
 JXAwvdkzaHlDTUpy4T0FvRAQzeuenIw/nCKwmOlOJGRlKX9Bg0JkXnU7wHtiNj3aBXGU
 cf3g==
X-Gm-Message-State: AOJu0YyUFz17uVID946ZwNAX1+nyT/U4/t9aEERdJgTM2c3unNTDYI5q
 6Rz3C/dAStCyZbdOpM5N4xfY8gl0fIR77qRrVlROHdAvs+gflKkfbBzJzPEUw5WZOQI4DHGBJna
 cMLeg
X-Gm-Gg: ASbGncvbq0taqMOuo8n9fuzQgLBllhhV0hqcvDIMMHa2/+mloJArZFmymLqM/nwvZ/n
 ipuc/U8ianrcxSuiDXSy5wbHNVZY5u5wPc0SQoh0mRX9EnuvJWi6N0WthNV3NRYqvjeaNY76GTU
 BcK3ui8TjgBcyz+HGxWDe6u9m5W4C5stA3tZNMnkGuigjgbh8Svtc315L70Hmns5fUp7BVRtZip
 hJBq60eUnPLtKNX0Cprvt/dsYxXFh3EYW/hrRI5Z5DJ9/rTjYwm+iMvqNDzXAlKAiwWcy4nNmz7
 zgPLzLipW9KpJ2bGkdAH4PROFhDOGmpLyRV4yahcKT52UKkWf1J31ZWH8YCY5LVKBdiEJu73+6b
 0jh9Ef3MEtDt4Yqjb7sSf8jIeXU6pMY8x2QSN
X-Google-Smtp-Source: AGHT+IEFNJ3OJ7BPhjGN15gtQXl2tNUloyIadggbIW5n7pHv1qGO2xArhxB2JsCML5FNFy7gPqNw+g==
X-Received: by 2002:a05:6000:2b01:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3b32bae0db0mr176693f8f.2.1751482449975; 
 Wed, 02 Jul 2025 11:54:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a998b4fcsm5547975e9.22.2025.07.02.11.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 05/65] accel: Introduce AccelOpsClass::cpu_target_realize()
 hook
Date: Wed,  2 Jul 2025 20:52:27 +0200
Message-ID: <20250702185332.43650-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h | 1 +
 accel/accel-common.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 44b37592d02..a863fe59388 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -35,6 +35,7 @@ struct AccelOpsClass {
     void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 56d88940f92..55d21b63a48 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -105,6 +105,9 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.49.0


