Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36010C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkc-0007Cf-JV; Mon, 27 May 2024 17:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkb-0007BO-3q
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkZ-0003dc-HM
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-681a48efe77so147874a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844762; x=1717449562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRYxm+mzEgnKfkaE8FWZZUzYTFv/kMXq7XWXtqSGDA8=;
 b=EFJvNDcuaShEkqEcaT/Dw2wcfYFOzraPieDiELbQMd6hNNGy567usClhJDMRuSVa3R
 kdQTBOF91fA9pTgJaNEg1N0cVYHznBwYgSV8IKP9Y0HRdyyW9Wc81QemLnmi+3MQ8QyZ
 /934aDA9WxVQC2SwtQu7Tc+HeOLEapbJyuRc8kbxTxNOVnJFooIIISAgWtRQfocMkSN5
 7132x7pY6YFlBSB/k4Sg0Ka2gNIzfnWi2hqgjOlfOzel77C3K9+Z+D0s1xwFrPioDb4L
 WHCGLgJGYWlVcSAieWvr3G1eZIhV5A7kpiAxaA7nT4yTmpyzxJEkenp97JeLL71ANA+s
 6UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844762; x=1717449562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRYxm+mzEgnKfkaE8FWZZUzYTFv/kMXq7XWXtqSGDA8=;
 b=jtmBA7I81UB0WH0MjsvmSZskhBMZApbPE/wLXDBBKFB5RsDIzEXv5E1dzOX/mmQwTC
 rmT2zfVQ9wGtKwLXoC0ft3y4DMRyWUnyIK4mxgvgIyidq6Y/IPrp4jriONXauDmaniZh
 3ECGHQeCHLMaD2UK1hsjGtSc5B2FAfWX4pfC9hH/O/XC/F0vPK0k9G/0F22L/GSMAo1H
 q+jU3WpEA0PMKk6Xior1SeGGhOBH7Je9Rpp2Ou2CIhLKnfEjzIT1vLF+Ipp8WjskLlJn
 jtFXOJoRxL7Cy3VNNvlkG9s+MA0BcC0zUDv1BjCNM2CG8VpDjLysmu9WsU6VbTIhBZNd
 fOqw==
X-Gm-Message-State: AOJu0YxKMPZHvBXg1HLs0zV053KLxZABq1meckPdVXeA0/j6hFpFXD7d
 MIbxBMZ3P1fFKSZVHDMDvMslg19hxxiQxSFKe0dI2mRvnAXqvP3CZfqbaRG4JIBp0uqqha+3OB6
 w
X-Google-Smtp-Source: AGHT+IHTc3Ik+cdbwnZE4mYZDuJTXQ5TRJzhePd52m5AJJbjYj7QYHuatscmfOscrbVZUKLubX8psg==
X-Received: by 2002:a05:6a21:802a:b0:1af:839c:d335 with SMTP id
 adf61e73a8af0-1b212e651d3mr10177687637.55.1716844762029; 
 Mon, 27 May 2024 14:19:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 09/18] tcg/loongarch64: Use tcg_out_dup_vec in tcg_out_dupi_vec
Date: Mon, 27 May 2024 14:19:03 -0700
Message-Id: <20240527211912.14060-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1e721b8b20..9a8f67cf3e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1749,24 +1749,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
 
     /* TODO: vldi patterns when imm 12 is set */
 
-    /* Fallback to vreplgr2vr */
     tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, value);
-    switch (vece) {
-    case MO_8:
-        tcg_out_opc_vreplgr2vr_b(s, rd, TCG_REG_TMP0);
-        break;
-    case MO_16:
-        tcg_out_opc_vreplgr2vr_h(s, rd, TCG_REG_TMP0);
-        break;
-    case MO_32:
-        tcg_out_opc_vreplgr2vr_w(s, rd, TCG_REG_TMP0);
-        break;
-    case MO_64:
-        tcg_out_opc_vreplgr2vr_d(s, rd, TCG_REG_TMP0);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_dup_vec(s, type, vece, rd, TCG_REG_TMP0);
 }
 
 static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
-- 
2.34.1


