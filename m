Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B910D1D47A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlD-0000pw-37; Thu, 08 Jan 2026 10:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrl7-0000mO-0c
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:09 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrl2-0003GX-8k
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:06 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81c5ff546f6so534949b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885420; x=1768490220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oyWOE9FTY5wDFOOIfe8Q8KJTIOjdixF1m00Y/7PqF8=;
 b=MqzV2QMuctWKkXCzqHluDGJwYkVucFhaP8RlYw/Erf4ODPalQ1jQos8pgAwFEeVo2I
 d7EYOuXBGtqCJxKMHvlLaiOK0ZJIDO70djcCp9updE5tE9EdvLGxMqyq/hhH5jzg0lwW
 DQG5yrTL/E1XCKA7nxLXcJ+qz1Hhv2nKxYxAAYDmSjqDS0AT0t3FwRj2hYNx+14g7k1o
 jfYf+LP2mQ714BitITOYJnlCnTi3COBY343IKs5uwTIMugoohyJK54/vrBt/uKXufrRY
 j5wUWvxypHR9YlafLiT/l2lIjvPFgbU472oWu0KJdVwYnNT3Ns1bJB79KqhUGgLgap8Y
 dnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885420; x=1768490220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1oyWOE9FTY5wDFOOIfe8Q8KJTIOjdixF1m00Y/7PqF8=;
 b=ZnkywtZIdQZcn3fsAjuhKzpw0Qsx79hfDOrpoTCkxBGNeJeZNe6yinRy/fFnlXPZPF
 20AasD3aY3PsKaMFTNGVtqCXYYi//IRZbNw8DZelenbwvbOIsBpq3EJuElml3zxFKT8r
 pIZUH7g5cuQeQDrJGsiKRIRemw8HqRrK6VHDANn5LKFYPoaDsTldJXRMfL7CTqOvUyYo
 Uc7vR0digrOOT9/dSsQgizQzhzRtnoTOrT3olHS9UD4Ex93E4459sKdP/1JOLySxox/X
 uE7yeYfnX2EPeuNzY0TI6V9iGnlox/eJH+G0EfvlNJTnDbPvSZe9P5ObQ1wot0+EYL4w
 jndw==
X-Gm-Message-State: AOJu0YzRByj1FWeBIts6w+ioS3eUzBvhp+mwx/kcjyirEMH8GQCS9Xvw
 zH/wh/xgPg0iHxZygJlT+woWdWu8TFz/L8+d/T0/U6ovUM3u1sJB3Je1mRJAb9xQ3TNiYoDCpme
 us8ZdnXkH2OEgkMpXep3L/B+5oeW6HkvuQKdkq+3y31SzhJAZFNGjIRuJKs7V1C3RVOic08T/Lh
 hrtquCKnRTBYsjpoxEgEbU/3uck/xVGeC49cdubaM=
X-Gm-Gg: AY/fxX4Dt5tAEivD22WgOvYX6c4zPPj6if4HPNGtOm3z462TiySMJ2C4q0pbqkDckjS
 pq0omZ4Ng1oBrj219GgDfsvcfmjUKnfnPCQyEYaVtoyQLxy2drjDPS0mzmPac0ylV3PaSmOW/Ii
 7eUqyIr8ycDj49rHmXKIkuUcHN+WzbgXKw/ZiT22SnKHRIwJil326dWZhQnO9ePP5uU/0xcSX1O
 Byb5CcrVzg4R9Rgqz5HvGmIK0AqS49I+/22by8LjCzFjNdNo0PlzJptOyv1DYdcAGw6VvpB6hNM
 xwGtipmBATZus351V3BO6AiJbQRUK8HtSH7AceXt4uUjSRveM8Vw+uw1UaYIbgIDF89xhfhsGXZ
 DZ5eroxfA7TKoOvj+y45VpyXinIwwbp6l6eRxbk931MfmqToA0AwGAtawISGdzI2S9E3DqVEvAi
 oMIh5KNHTa/d4ShNyNU6zEi87t+Jj8nF9f+eVBDNYyY8veLJURtnAqSi4=
X-Google-Smtp-Source: AGHT+IGsDvOdYUDmXWsgQGS+hEvssHYXHYNvYG2nu+ExMq0KuswCtKHu1qj+tfcvZD3Ui5ILSpT1Eg==
X-Received: by 2002:a05:6a00:4ac3:b0:7e8:3fcb:bc4a with SMTP id
 d2e1a72fcca58-81b789aa6d9mr6046624b3a.31.1767885419555; 
 Thu, 08 Jan 2026 07:16:59 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:16:59 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 01/18] target/riscv: rvv: Fix NOP_UU_B vs2 width
Date: Thu,  8 Jan 2026 23:16:32 +0800
Message-ID: <20260108151650.16329-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5aea553814..ec0ea4c143 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4972,7 +4972,7 @@ GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
-#define NOP_UU_B uint8_t,  uint16_t, uint32_t
+#define NOP_UU_B uint8_t,  uint16_t, uint16_t
 #define NOP_UU_H uint16_t, uint32_t, uint32_t
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
-- 
2.43.7


