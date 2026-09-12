Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F571C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5u-0005E4-P7; Sat, 12 Sep 2026 06:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5C-0001OL-Or
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:42 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5A-0008UE-VP
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:42 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cbee846deecso2545264a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209339; x=1789814139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QyGkiurvnoAYjYLquOStBYPlS72W2sK6OBBiB2KbEZU=;
 b=SEhijHEa1QHkMmzLFNv27NOoKUQhkkjbulPiaDHuCOwdgPTsAD5zrcylXad0k/5qu3
 qoqEdsx0e0mh5qeT5YO3jaw9BIQqk6T44v0vxSTEauhhmtvH9P5DFzmrlZlWZp+EvCcf
 DkXBklLO6XZbqNgFkxbqBe+RizgNscleIgEe/8FU2J0IWLHyrrCcxaByqydWlr71lID1
 T2QafQGLunjhrs/4qhnfzH1/OtSVToDYvFKF9KFYPV6mf2xAmINS9TK7jbchm/9xhHiR
 13DIhYDicMpOhDyKz0Yi50B2uGaYROlFVM80qyFLSJEIjmnp/S4q0SY6H7FUXmUfOjwZ
 OoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209339; x=1789814139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QyGkiurvnoAYjYLquOStBYPlS72W2sK6OBBiB2KbEZU=;
 b=ADrJauq+IRnn7WnNNxMbXCqL9MNexYrEndHkICOAwnnlwrIFdp/+Zbg+vJzMQcn5nZ
 YfeyPLZpcyzgPop9ZIO1c71kW6BrwrctPEw6k4FCS3qrEstLNUvKDv3eJrIP06Kifjb2
 jC/hOMxWZ9smjs3h0U2Trhtgz0xNHBZi3lvgA6NoPVa5YzlcCv2I8wdJmuwK5bN9WPyA
 zm1OEJe0X8YwKrNQMu1C/upg8cIVN5uo93+azlL3aeJmv9Fl4pXgB8OPPedZTinm4Y/M
 wvANFofFxWEYOT+BajqJu7MJuzouxsA6/b5jMu5mOSdSAdTzEiYrAtZH94iXMwdiCeN4
 qQkA==
X-Gm-Message-State: AFuF++mjIbOkuEh0Z+5XzZvzPLYl/99G814qEOix4v8JbRY4zevEWun2
 ADzOAZmp3VqwXHex42gdzYxywTNMxLkHa51DTRq9ejU1KUQ0z5FLsHGlePKp7F5nzt6DtCrRA8O
 2Y0X9HSI=
X-Gm-Gg: AYBFou0LbqUkxvVvUUw/e6SIhvXm8fiQGyJzdwpIZPfXTKFLJFDRmWLviOXBXZ6doN9
 X28OutLvquJRPC85RmYVKp57q+3wdkTomQCIEX/MUA1ks8EDudmZFyf++wC7PQt3fTeT/tmmjmj
 wwCZ6t/ez4L1y5aGDMrXkaoFnVYnPk9z59CwyuRGcSq7rG/BbRFTKWxrAdRoF0QpGK+PT9sal+t
 iwVrsZ2rr67iqB0zIf3Bzxs3RZGO8Qyb1KcRqLBOXFWJEPZZH6gelBA3XHzfJ0MaRQYHPEJMdHT
 HYzHrdzaJJMmJhrMApV7ey9r2rk59lGqX/AkCxafM6ZwsW6F+q/kOOkfoR3TpF5dgpNRM9sVmB9
 WvybvSHduZzYt01+kMD3HBAy6REulG7vgs0TS7hHgUm91G/ANzEeUW83DGBM4sJzyH/2+K/Dw2g
 sOgCOOF3VxRYmCfSxW+nFQQC0PXKTTO35bBelvNIoOuUabIeA4ZbeUnGj3BlgHpXF9oIWGASXQQ
 p00FfI=
X-Received: by 2002:a05:6a20:9f8b:b0:3d1:9166:5c68 with SMTP id
 adf61e73a8af0-3daed592b5bmr15798223637.8.1789209339456; 
 Sat, 12 Sep 2026 03:35:39 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 73/82] tcg: Use smax in abs if available
Date: Sat, 12 Sep 2026 00:31:17 -1000
Message-ID: <20260912103126.598030-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ea99a8842d6..566349e8a9a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -370,11 +370,16 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 static void gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
-    int width = tcg_type_size(type) * 8;
 
-    gen_sari(type, tmp, src, width - 1);
-    gen_xor(type, dst, src, tmp);
-    gen_sub(type, dst, dst, tmp);
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_neg(type, tmp, src);
+        gen_smax(type, dst, tmp, src);
+    } else {
+        int width = tcg_type_size(type) * 8;
+        gen_sari(type, tmp, src, width - 1);
+        gen_xor(type, dst, src, tmp);
+        gen_sub(type, dst, dst, tmp);
+    }
     tcg_temp_free_internal(tmp);
 }
 
-- 
2.53.0


