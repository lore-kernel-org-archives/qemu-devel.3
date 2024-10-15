Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88994CFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlB-0002T8-Rl; Tue, 15 Oct 2024 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkU-00012m-NJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:17 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkS-0000p9-VZ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:14 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea7e2ff5ceso1792256a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007171; x=1729611971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Snu/XbO5DWXIOAW758ZcEcsN6Qt6EdTKtVraeirV4SA=;
 b=VtnSe7yOTyK9LIpZCZcYzsn8evD8gMpr9i7hBSmJIJFJDmXzdFgMy+bak4FxkZ+hmD
 fwuuYB3Wn8IGdj7NA3tNwPn1GlretOAC+Bl0TAbzApFe+4xFpaBM2M1wk7kqY1VCMe4e
 jUI+sYlqLuHCFpij+Fy8zmRCWJKKITEKQy6m4GUFvoOD4B80t72GupBGaO+gTaQZ7fRh
 chQOb9O8fwi2qXls6Rl5dujQoOTiXF5jj9nFF6qeBjb2j0fqR83cedvXi6wuw1aX1no+
 DlXVgXqxSjiXLMHGgMXeHuCQ+dOlspEHZEFRykY8s89bbPUCSx3UTM3ejYMgEIPWT6Nw
 H6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007171; x=1729611971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Snu/XbO5DWXIOAW758ZcEcsN6Qt6EdTKtVraeirV4SA=;
 b=gmEnVB4+x/ie1s+dmwoSOeVEuFo0wtWXgWTpQT3ji57Z1WnzCXD6iJbSW2XSnNpPv3
 qToqFM5uj1+HikJ272C+qqAS6oBBfTFgIVA3s3gwUFy6qgNSAlvSYhMMLb84/EEryDkQ
 hGYDEd+9LEe2d94k+WoT4R59JvWmlEZPewgalhKbTR8SRs6Vd8zi29c+TBfzztAeOPJM
 1U5YfnfnncO60FuyynoOFW5xgwNNxaUCJLTCg13KLM9xJJMESrsQldMIAJlgrJCVbOBO
 37Qc8QCGiRP5GP1jP2+4BDe3grCXoNv7h8CliUwU3n71OZQB2mhfUM48omxTXyNE+NAf
 nqMg==
X-Gm-Message-State: AOJu0YylrW/Rgn0pSR/ffmZoTHk1qktcXKYMnpJEpbq0lEwHBdTROinE
 KBBlC73GfVs7SsMO/W8hoZ7fOoszHBNVmhHm8hOn3cKxLUChSk18jlx2i2VykeUWXYG9p/ERRLD
 9
X-Google-Smtp-Source: AGHT+IHZqN4p43cCqYs2KuLdeVSQnz0NRMQlJ+DbSHB9oVkD3ZTjUfbi3c0E0azFSdrJQW/wEpow1w==
X-Received: by 2002:a05:6a21:168e:b0:1d7:7ea:2f36 with SMTP id
 adf61e73a8af0-1d8bcefde33mr21415030637.4.1729007171317; 
 Tue, 15 Oct 2024 08:46:11 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e7750a524sm1402861b3a.200.2024.10.15.08.46.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/33] target/loongarch: Use explicit little-endian LD/ST API
Date: Tue, 15 Oct 2024 12:44:21 -0300
Message-ID: <20241015154443.71763-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The LoongArch architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/loongarch/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-13-philmd@linaro.org>
---
 target/loongarch/gdbstub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 3a03cf9cba9..dafa4feb75d 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -67,10 +67,10 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     int length = 0;
 
     if (is_la64(env)) {
-        tmp = ldq_p(mem_buf);
+        tmp = ldq_le_p(mem_buf);
         read_length = 8;
     } else {
-        tmp = ldl_p(mem_buf);
+        tmp = ldl_le_p(mem_buf);
         read_length = 4;
     }
 
@@ -106,13 +106,13 @@ static int loongarch_gdb_set_fpu(CPUState *cs, uint8_t *mem_buf, int n)
     int length = 0;
 
     if (0 <= n && n < 32) {
-        env->fpr[n].vreg.D(0) = ldq_p(mem_buf);
+        env->fpr[n].vreg.D(0) = ldq_le_p(mem_buf);
         length = 8;
     } else if (32 <= n && n < 40) {
         env->cf[n - 32] = ldub_p(mem_buf);
         length = 1;
     } else if (n == 40) {
-        env->fcsr0 = ldl_p(mem_buf);
+        env->fcsr0 = ldl_le_p(mem_buf);
         length = 4;
     }
     return length;
-- 
2.45.2


