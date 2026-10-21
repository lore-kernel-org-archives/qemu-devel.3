Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DD606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Phy0aMbY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX7m-00033A-Kx; Wed, 21 Oct 2026 10:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7l-00032k-E9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7j-0001TF-TQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so5610565e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592218; x=1793197018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CERIhqkb0oA636lv96/1jDTimpvn3+KmBN0quQG8DYA=;
 b=Phy0aMbY/nGwSxQXu088zcwMe+5cWY3NmnCOsNCWIhqaRbYfznj5fzwsfrisAR1FP2
 xN5JNM4Fn5h6+6gBEJnExwOkSnYEF/WNC4x+HI0U5C5L8lV/1wr4zQVsREI7XvcWCgOo
 dxlDbvgx6SkflYrD16WJE1Z2JvjI5AdCmLHD3KpeLH/TLNHf/cEMGQN6UnCgh8kX9o5o
 9bsP9bscBBEYV0ggkZpO5Oqwi7wCuapV+rEjW62E042vxlVAMdZExrJD1Oc1CjDdmQMy
 3sJE4vkxmaJnrwmiNiOBPwvVAMJnSc1542StW6HAya4RRUfsT+ZXGo6xGRcsLdP24B4l
 mceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592218; x=1793197018;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CERIhqkb0oA636lv96/1jDTimpvn3+KmBN0quQG8DYA=;
 b=p86+fF+8WEcAeHGKXsZvXpCK5ITCXeU9J5fD5Nh+BiKmXACRYvE6VMYemKtdVb8Pio
 8gFos0YBoJNmLCyiqpJ9VGGBVLAIGWgzStCMT9yigrl3EPSeIneM3Axu8JniYBgsE/Tj
 X+NUKaimzefoALVAvRSmAt6pMGUS/GufV+scJ441Z36vVdJ+V2gaZlacNkV4C6LQj4O4
 tEmgjYz/Dq+q3fQWjG+xYK79Vb3W7g3Srq7xAOKTDhDQ0DXnmUxv5hHmHRU8Pb5bOmQ1
 rGY8521RLGiO+Pbe3h2pOK/JNcta4JZSSSkhZvEsafudkC0KHp0fXzcK36jUEsPCKT1B
 G9mQ==
X-Gm-Message-State: AFq9FYLG3oZ4Dk03Xh56EwVAWglPNgwqUDwDJS2Lxef/1MxoDZIVlZJb
 VOZtEyl1cFG88NkQSYLmY1sKHlAI6yLXh03/2qHGIKBGF5ci7TGmXitKUQFFVOs6m8uSA8qY5uN
 cLOGX6hk=
X-Gm-Gg: AYBFou1QS9cAg6U/MXexDqwwCfiDmRX9CaGtLSBQn55q6KZxqbNzwZhIFZr3UzzVlKe
 JpoV2HuCkB5hFB2Gtba9YWBnSFp4Dax/rYhlZOjcI9t5YVZSQCXNMK0TDYmA36m4T4EpzJAVgBj
 +EGIeqGxhC2duq9Ta36rxyydrdLntiGcAHiH2B3JpoFU8de8PVXUUe67Ic0bmSWIxQLzgi1tinY
 BxYFQanG8F02cP7tzyAnodgc2kYTtE3CKeaKqsV0Yq2LclmxrXJ1mJ5LNRz9IvsuLeP+gjqtYd9
 B3FzBoifU3X1i7mExvkjj0C95gbC3J/IwLoHHDCPSz5jZ8wPlsPl8/aT5C6vcBqb955zHaBOfTv
 VmqUqo+q+5oQFT5QERJD0zaXXipQkX86eqM7D3gA915kjIS7k/YMH2VZ6UjL84DwJPsEdC0nl/L
 PSrryL5CvXc8xiy5FZ1XtH+cNsSa9gr7q6ygboaKa2o76E8mEF99dj/B2/MxKfMVHeZLesAMJF1
 wpdMQRhUukm/pRupV0T8L0EBvVoeJXeZmtr9Xvnyoa66FRMP/beqgqQRi3UYn0k/u9Y5kjc+7gw
 tAU6VlEGT/C9o3yggHgHM3/VqL4=
X-Received: by 2002:a05:600c:3b82:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a1fdaf7464mr51553115e9.7.1792592218256; 
 Wed, 21 Oct 2026 07:16:58 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:16:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 001/100] include/qemu/compiler: Add QEMU_*_NONNULL
 attributes
Date: Wed, 21 Oct 2026 16:15:13 +0200
Message-ID: <20261021141652.363109-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 4c49f52eb0..f871298d8d 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -25,6 +25,14 @@
 #define QEMU_PACKED __attribute__((packed))
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
+#define QEMU_ARG_NONNULL                __attribute__((nonnull))
+#define QEMU_ARG_LIST_NONNULL(...)      __attribute__((nonnull(__VA_ARGS__)))
+#define QEMU_RET_NONNULL                __attribute__((returns_nonnull))
+#define QEMU_RET_ARG_NONNULL \
+    __attribute__((returns_nonnull, nonnull))
+#define QEMU_RET_ARG_LIST_NONNULL(...) \
+    __attribute__((returns_nonnull, nonnull(__VA_ARGS__)))
+
 #ifndef glue
 #define xglue(x, y) x ## y
 #define glue(x, y) xglue(x, y)
-- 
2.53.0


