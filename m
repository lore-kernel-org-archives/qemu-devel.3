Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEBDC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFb-0003D5-H7; Sun, 04 Feb 2024 16:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFR-0002jD-3k
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:58 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFO-0003ar-Dg
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:56 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d9b2400910so1721715ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082913; x=1707687713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edCRhkheTbWQuXgwAiS/gonGTZ3kw+g3zID7Qd9CYvo=;
 b=P2pMkmVleiDXoiuFTahCg5mvh2hAR+xZ09QwFEeFbTls1C+G1pf8jFYT5Uz3u5lv4S
 S3vkFh2bNkDPAgzkCfw8yjzjVqQuhWg77uP1CU5YgeGgDWdxVLjOC9bzmZNTqvS0wf51
 NNyZZSboJiMOy+IH2WnShGlbMh5OvtK1OQ6BAPY5dYGdL+VF96rP9QfIBkWRz6qm6018
 00n0JXJhsFv5U3VLIFvQGNNJooluQ4KZXNAF66sjLCsXxNaHxuqoh89o4OajZl5fb2DD
 lwCYCCp/ENROXI+TLbKmaR2szu4IK0X9ry3q5bMQQo7ErdmosR/SOEch8dEzrqjOsys3
 lwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082913; x=1707687713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edCRhkheTbWQuXgwAiS/gonGTZ3kw+g3zID7Qd9CYvo=;
 b=GQkCkWzlDUjaazyfTA65DS31L0xwmGmER46QFl/E/syt5abf5eucwdxGXgZlJAIrY0
 ug9KHlhUYXXrgUFSVKKXPS/U6Yf0MqUZxej8TIh9bjk3ZXVE4ojf2+AJFDzDUTe9YCpw
 VvR39QoxyUipuMWsMH2K+/PDynkfzuTDzO3tF+82Ddp4Edz6zRSoohNl9F4uzdPGf/Dw
 USCCztDhERur8tbd6ey9jSHn3rU4kIRN/ZFaiDmJUbuuY4cTBvzsUUyEmZM5Ksvfpay6
 Gv6jWd1PHZ0xt0jOFJ9fdMBpixZL3b1AacDTLEqX61coO3HNB1FuSHANXdoOghpRNNvH
 RVVw==
X-Gm-Message-State: AOJu0YyZ/Sxf+cLa0TJrwGNE9J3m4aGEYGMCcBaQzTIFrkVpvuW5wuCi
 AMhjn3LGq3yGtY6NSjyDN94kIIU1KTZafnpLsVMwfQAjCiwPlozNZOh1KoDQ58XDmU+crVQnh+v
 ehUM=
X-Google-Smtp-Source: AGHT+IGr8HlsKi6KYTko4/mA65HOA1/HbzBY8gh89/9e1ucZCPZPpR8OhOaFE/0hZ4llU7VI6SovZQ==
X-Received: by 2002:a17:903:41c6:b0:1d8:f6af:77db with SMTP id
 u6-20020a17090341c600b001d8f6af77dbmr5557498ple.12.1707082913232; 
 Sun, 04 Feb 2024 13:41:53 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVidpJ+iI7gT50DufGL5Yz0fogQzJnYYlDnMat1HNEPWOygrhd1OQdNFQPT0psZRb2sWlmZ5G+wKa/mImin3RZb+A==
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/39] tcg/i386: Use TEST r,r to test 8/16/32 bits
Date: Mon,  5 Feb 2024 07:40:40 +1000
Message-Id: <20240204214052.5639-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Just like when testing against the sign bits, TEST r,r can be used when the
immediate is 0xff, 0xff00, 0xffff, 0xffffffff.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0b8c60d021..c6ba498623 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1501,6 +1501,10 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
             tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
             return js;
         }
+        if (arg2 == 0xff) {
+            tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
+            return jz;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
         tcg_out8(s, arg2);
         return jz;
@@ -1511,11 +1515,24 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
             tcg_out_modrm(s, OPC_TESTB, arg1 + 4, arg1 + 4);
             return js;
         }
+        if (arg2 == 0xff00) {
+            tcg_out_modrm(s, OPC_TESTB, arg1 + 4, arg1 + 4);
+            return jz;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
         tcg_out8(s, arg2 >> 8);
         return jz;
     }
 
+    if (arg2 == 0xffff) {
+        tcg_out_modrm(s, OPC_TESTL | P_DATA16, arg1, arg1);
+        return jz;
+    }
+    if (arg2 == 0xffffffffu) {
+        tcg_out_modrm(s, OPC_TESTL, arg1, arg1);
+        return jz;
+    }
+
     if (is_power_of_2(rexw ? arg2 : (uint32_t)arg2)) {
         int jc = (cond == TCG_COND_TSTNE ? JCC_JB : JCC_JAE);
         int sh = ctz64(arg2);
-- 
2.34.1


