Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68701F428DA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6jj-0005tU-4r; Wed, 15 Apr 2026 16:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jg-0005t1-Rw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jf-0002J4-7M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so4343225f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284476; x=1776889276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUkjDs+mtkxR+/O5PV1pe66NoNJBydx+UdKWQ2gp0U4=;
 b=KRCpEhTYgFbsWwRQLY3R0kSGswmPrRHU6S5TtQUVnXm5DmOZpeBDHGl5/8bFLnHVxV
 1MvdhnVo7v6TCJpVUV7MgiWhyBZ8UKrRaRkV8fiQrrxo9P3fLcnG0V7DAKkpGPsiDce1
 j8OidaKnE4Mi5LkJ1/TDj5fWjgCGFWkrSNWi9siyDXePYRdDy81iybaopDeTLoxgOqYc
 qxB9dyQqrm9s1lOSOmSlfE33iqRgr97FBz9b2XO4qq6Qs112kk8HJzvcWRhGSF8cofbu
 VC4huB24Gle1Vl6WcOMy1XF02smwpeZvabUXh1oeA+IaqNYqHnGSszVMtD8DEXjOHC0D
 epug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284476; x=1776889276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MUkjDs+mtkxR+/O5PV1pe66NoNJBydx+UdKWQ2gp0U4=;
 b=sjEyqL3u5XbUXRp+u81JjpEtq1k/9p2VsLjLNKKYnqP9ZARtWQYiuFInigUkKbY8Xk
 UuNtprFAxVpzNNW+8iQQWPlvO++mBrehvDUST8oKCIwshUDpYzakkWCzpAg9rv0n0VTY
 uWpFMoDKtjwlyO10o8+fh9FGfzmvJD1XMT9oSamyjiYErAvHxGEna5ygxEtd6rww8CaQ
 RwlDSudBilxSSXxR9o3NIqCSPjDi0S25BAELdimUIkqOGq96GOEK+vSzJ6rz3lR4QhCM
 asgqILDXmPAafGLSrMamfQ+vfFkwT2Xe16Dli64H05ERUCInqpPlYMomwo0Q4oEJlAey
 8cUw==
X-Gm-Message-State: AOJu0Yy1GtDD+drGJxdyfnstS/FujvSkNKbLhQvLxSJlhTGMpV3VE0Bc
 IKmLfxpyne5fl/aFXAtkjfazsnvQ8CSrJPx/oHbs/3sIMO0QYoyyLV4wLq2P7qvMRoGsTdHybY1
 +h8JFhFI=
X-Gm-Gg: AeBDievglnStlW04m8NVxxqek2dKgj1+CRxJw5EuscIiuy3utBCRylv5wkP7TLKwwSz
 JDNKnZFf2OlCTKWmujfwrGsWkvnIJnQzoKkUAYLa5Ma82Q19Mkfky0Irl25YUTJz63lu407JoWD
 5ZhGbLek7Ehl2DxRsUIH0yORRQnXAR1zNfhgei8bjmrrbJ8WLpINCceUq5VzXEZp93VAEGh5MMO
 yhD3E21epbm0I0NlFTERkrY4V8vn2zX+qzMVOCuVXfdTZiXqUTz9XwBS1ZmcrEEuXCuwJrX1m2g
 ttAG62wXw8by+/6LOwyL9L7USR8TO+oHR3qtbxSNPJfoBCUerHN+PU2iECduED7Ncg7KE/3Vedv
 kRemxs+u7r+2f/cWkVawSa2KSLzMHDCsQJHEbIslEdHakddy4GMPUyoGFSzsx08defETPjWAcOP
 +NgswJLVaSt+mZfeaxrZE8GtRAcXLMixWhgtUe4tOSuHhC1hp/T/WfP5yJLHpNF5FjXEnBYi7z
X-Received: by 2002:a05:6000:60f:b0:43e:a69b:d814 with SMTP id
 ffacd0b85a97d-43ea69bd9fcmr12556111f8f.28.1776284476381; 
 Wed, 15 Apr 2026 13:21:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e00b3sm7132251f8f.27.2026.04.15.13.21.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 13:21:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [RFC PATCH v5 6/6] target/mips: Endian-swap MSA LD/ST.D (Doubleword
 Vector)
Date: Wed, 15 Apr 2026 22:20:26 +0200
Message-ID: <20260415202027.83008-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202027.83008-1-philmd@linaro.org>
References: <20260415202027.83008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Doubleword Vector entries need to be swapped w.r.t. endianness.

Fixes: 83be6b54123 ("Fix MSA instructions LD.<B|H|W|D> on big endian host")
Fixes: 6decc572dce ("Fix MSA instructions ST.<B|H|W|D> on big endian host")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Probably optimizable since tcg_gen_qemu_ld/st_i128 handles MO_BSWAP.
---
 target/mips/tcg/msa_translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index b1d764bd179..63d797a39b7 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -822,6 +822,10 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
             gen_bswap32x2_i64(d0, d0);
             gen_bswap32x2_i64(d1, d1);
             break;
+        case 3:
+            tcg_gen_bswap64_i64(d0, d0);
+            tcg_gen_bswap64_i64(d1, d1);
+            break;
         }
     }
 
-- 
2.53.0


