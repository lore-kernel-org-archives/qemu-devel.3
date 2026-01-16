Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4189DD4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacc-0002qT-KP; Thu, 15 Jan 2026 22:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacb-0002oY-6Z
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:37 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacZ-0006NC-Hg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:36 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so814807b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534534; x=1769139334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jt6epgzk+hjWVFj/7ojbUiaxuIhW/JGBZIUcf+FDUAw=;
 b=A/B1HllsicECcJqaCUCxzpydBYKs6dr+iBzb4mO1Ks+9Fr8v52PkcCFo+HqVHVNdI6
 +PMADd65J5nX5RHbJnYHiwyXYr8i3B2fBIy83gaOgdyrXlRSCWu+a1S6mWUBdnM3Vy49
 lmyiUTUPUtAcdKF8lpNbufETW+i/2uA0pG5GI3iMd1NqlLc9AR6lIYyCJVp8pS2AaIen
 WzGDrnjxFlm+0a6ppbPrbS2p08IEBR1JCe7UM7nZTXB1xZXFDYYjZqFJqB21qkeFyW5R
 MjHfONZSUAbylsi3GRShzBQ5RG3hVxw1EXa8niAhcRoqYeS/DULn8PFkYwhyNKjxQyuy
 iWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534534; x=1769139334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jt6epgzk+hjWVFj/7ojbUiaxuIhW/JGBZIUcf+FDUAw=;
 b=JtjrMnwnsrR0OwJiAyqceRqWrT/2CAeC0I8pyEhZ5CNNXxRjzYml+7QUUcigvS7Pcr
 UrGizIWUWd1+SM0f3fN7qFcZpW7D2OOW0IDnxJCtTVaHUeCtoKzB+sh865QrTzsv+uWT
 GDz09IXthaKzc957xxgehsLM96zn5f9MtV0z4e1ic9X/gkgliNpvONhhXfWWj54Thi+v
 D1Emu4rajnfgMIWV+duREd5L+z2Wo+Tq7OAeiiX5yIku8a7JcSG8GZuJBSeU0XFFnwBw
 itZ1TOKzsIkpSl5gDfzcr96tfRAWn7huxlh0lBjE9P4SbSGcEJhjJ2CnfMTTnCvTRfyg
 gcuQ==
X-Gm-Message-State: AOJu0YzjTehLKWqNdyaCO5+LFTN46AsibzLX9jp1nFmjFodAsS0yF1kd
 XZsgbevM2/9o+LqCJy2S6iLDQCdUtI3MYaggd0NwnLFly2cxEUboYXo0EgV0D+QQEmPyXAi/bRI
 cRfzoZQ6wug==
X-Gm-Gg: AY/fxX6tWsPldeKoqEjr5Bl3DMeyMmAoo/T50ciEeZyuxqPqwhZ0+juFxIzKZTfzY3o
 OzeAgB50MmZE3GaXikCazT/24iLRcpMUYWvyUyWSB1bLZRw4NOUg58Yl24saUPwcvKN7VUL7lzw
 PhcOH/MKnr52IGhTGNUrjGyeSWXAoH7vdOGA/2detLEDwrbb3X/KsL+sZ0cU/7ROVZJOs4YLp1q
 9iDwpyTwIKzNcuJ6LJkKSVFwNetSzdesV+umhgsRTmmgNAyOHD1dbqdBfguqAwuZol+MH5lFfxt
 QunSeZntJuWK6DJfPi3LImOUNeEsk1S3VkfjaOUjHuoDs4EJbeZGIsmcFZ2infreq16XUooWs+9
 Nz4EX6SHgCCIjkQAclR/HGDt5MqrRQGDIEPb/KloBr13cxKrKvodmFqpz8YSOQd9Hj8N31uuNwF
 ikztf1Uz/Ug6N56vSG+w==
X-Received: by 2002:a05:6a00:368c:b0:81f:4abd:f15c with SMTP id
 d2e1a72fcca58-81fa03b4312mr1453373b3a.70.1768534534105; 
 Thu, 15 Jan 2026 19:35:34 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 36/58] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-internal.h
Date: Fri, 16 Jan 2026 14:32:42 +1100
Message-ID: <20260116033305.51162-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d6a12afe06..2cbfb5d5ca 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -54,31 +54,14 @@ static inline unsigned tcg_call_flags(TCGOp *op)
     return tcg_call_info(op)->flags;
 }
 
-#if TCG_TARGET_REG_BITS == 32
-static inline TCGv_i32 TCGV_LOW(TCGv_i64 t)
-{
-    return temp_tcgv_i32(tcgv_i64_temp(t) + HOST_BIG_ENDIAN);
-}
-static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
-{
-    return temp_tcgv_i32(tcgv_i64_temp(t) + !HOST_BIG_ENDIAN);
-}
-#else
-TCGv_i32 TCGV_LOW(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
-TCGv_i32 TCGV_HIGH(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
-#endif
-
 static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)
 {
-    /* For 32-bit, offset by 2, which may then have TCGV_{LOW,HIGH} applied. */
-    int o = HOST_BIG_ENDIAN ? 64 / TCG_TARGET_REG_BITS : 0;
-    return temp_tcgv_i64(tcgv_i128_temp(t) + o);
+    return temp_tcgv_i64(tcgv_i128_temp(t) + HOST_BIG_ENDIAN);
 }
 
 static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 {
-    int o = HOST_BIG_ENDIAN ? 0 : 64 / TCG_TARGET_REG_BITS;
-    return temp_tcgv_i64(tcgv_i128_temp(t) + o);
+    return temp_tcgv_i64(tcgv_i128_temp(t) + !HOST_BIG_ENDIAN);
 }
 
 bool tcg_target_has_memory_bswap(MemOp memop);
-- 
2.43.0


