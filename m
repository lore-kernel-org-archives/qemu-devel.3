Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EDFC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkh-0007Fq-3t; Mon, 27 May 2024 17:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkf-0007Ee-MT
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkd-0003f9-MG
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8e98760fcso107786b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844766; x=1717449566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOGunUtRSioDRpx9DXryp7ugeSYnTIPtLbqA1hbe0/E=;
 b=kcaTtvVGjwGuBlvXm+CFKZNDMKPuA4SBkatr1fPyxta749yQEzarKYJ2VMdGbwjSq9
 JVeWAwfQ+ZIE0KlLDHVtUHh0d7Np/zZx280gVgSkY0E6Rq5vji4ANoRK47NN5BzX9mu7
 T64NGZ/fyTQEK2xA4Umq/Qum+14aNLDAYg4Opy7eYW4oHSP2OWItMhcy8Vz1Rjr4RzHf
 Ss67JgsxF5InK+VkRoFsw4PDfItfyKcIEn2qi6uWPc8yyd3Tg1BfMG2Gj5NZAr97jNZG
 fcGtWN9q+aOix4zh6GWno2pKq3cQOuiABLIZPfueRzgGnKI5KIGtJ3BxfH2maCDqrqm1
 j6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844766; x=1717449566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOGunUtRSioDRpx9DXryp7ugeSYnTIPtLbqA1hbe0/E=;
 b=NnntLxWOGJKi5HBwuufxzdmT9/csvFxSqBZ0Ch9hHTAzdIuhwGpg4pEg/TS8zJV4iR
 lfdNm33mCm7aAi5BJN6AlcKKRLKjRXSeYXJmf2kCDE2OdgagNnTBn1WScr8xgzpz5XIt
 qqQ1gs/Lpdv5Qu88tbCvWbYpE/2drsXavUbXNoLruWPeE/MenJxcQ4dj4mTA9gWfQ1m1
 sqq395W6P5dfT0NTszVk3oPetv6+d0tekZu4YGkjw4TyYPsKzFk17v7FDjtz1qF6E++o
 iBbygS8Y/Rh6FwKaJ6GeCZI00HTyDQcB9Le4rbbq3Bd1/Q/i9tsyN4y1l8MgBBDmMXVR
 jIQA==
X-Gm-Message-State: AOJu0YwxuGulpY+th1lJI1+v2G669s869Ys5FWKuzC1DwTWR9aTOHqgm
 lQE2EiiMte+1xHYMsMhYk/MnKlotKfCnyaNBtdqgoKO5cPIUQuoWnoXO2R5b8XylwLm4197Z6op
 j
X-Google-Smtp-Source: AGHT+IFDo85jbQ28IiRjqGAPe4+zUBE4CLf7NYpNw2FIEwEKW2fsCjJ399NuW4PmcNbMV9NyclTR+A==
X-Received: by 2002:a05:6a21:3417:b0:1ac:3b5d:a3eb with SMTP id
 adf61e73a8af0-1b212df0c63mr14015366637.39.1716844766277; 
 Mon, 27 May 2024 14:19:26 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 14/18] tcg/loongarch64: Support LASX in tcg_out_{mov,ld,st}
Date: Mon, 27 May 2024 14:19:08 -0700
Message-Id: <20240527211912.14060-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 tcg/loongarch64/tcg-target.c.inc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 5f4915c6ac..e633d268d0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -325,6 +325,9 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_V128:
         tcg_out_opc_vori_b(s, ret, arg, 0);
         break;
+    case TCG_TYPE_V256:
+        tcg_out_opc_xvori_b(s, ret, arg, 0);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -854,6 +857,14 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
             tcg_out_opc_vldx(s, dest, base, TCG_REG_TMP0);
         }
         break;
+    case TCG_TYPE_V256:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_xvld(s, dest, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_xvldx(s, dest, base, TCG_REG_TMP0);
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -886,6 +897,14 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
             tcg_out_opc_vstx(s, src, base, TCG_REG_TMP0);
         }
         break;
+    case TCG_TYPE_V256:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_xvst(s, src, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_xvstx(s, src, base, TCG_REG_TMP0);
+        }
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


