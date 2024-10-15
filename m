Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF0CD1D882
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlE-0002sE-Pr; Tue, 15 Oct 2024 11:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkc-00014T-4W
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:27 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jka-0000q9-2B
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:21 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso3572872a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007178; x=1729611978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJ9wROiE5L2FprbXeD8aDG0nJOd3bETYw217/JvIATA=;
 b=HONkcfJCpWMGGUqKH/DlPPbbBhN8HB3vYF6JAhzGRvg3TTZtVCHJY/R1bu7kqDLp3P
 TxpQm9/k/J/Hb0peJhUU6PPu1EM/rpc4V9HvrsP1YwEN5c4pOu6Jp0DsXuZLEYX5slrO
 Q7LCdjZnRyEd6DmbYq1ZmOpotJ0pFavgwDX9WQqsRhMpsP09uls8nljfrZLOWVfWGF3j
 OjhuXBM1Bhe5/6yG6ifabNzRApkj09dse5zB+Whbw2sGZDTvCi6VQ9dBiYkvZokCZfdV
 kYO3HX2pWhWwlR3/D7geP1Z9xDcftR58EDgefctRka0fui+/BpDT8lylOZD7+fsm6gyw
 vzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007178; x=1729611978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJ9wROiE5L2FprbXeD8aDG0nJOd3bETYw217/JvIATA=;
 b=w/bIDNVp089lPdyjM6RxIizwckarc9nzr/OLNWJuZL2LslJ7BnvYg5gqFNQFgZa4Z/
 uqEo8heRW/5pNUHLJheQU6SMqNB6MX5bC/arDXhBRyDM1cKP3/Vg2zJ6woYRIMcxQKvm
 yL25rpuCbNRwSkXkA4k7u/58SyFrs2ZcAOk42kgmz/vVf4RRfTFZhZrzZEDBNnGHbqWS
 X4Qblg+Mj+HPmulfk2wu7P94cMPQzJMpfckMkNePeYlyknpL7lw5/v+icjt/p9lxgxu8
 QlasZvOBiOZyKKtQ5ebPSvN4yM6mY11OGLcByrcTUlMu7PLPzIP5rQsBW0ontfoYIZbk
 96vA==
X-Gm-Message-State: AOJu0YxeAaOkxSd0Cd6icPfWXUT206fiQYhCZ3kYFzHb8Gy6YQUgwJTn
 oMyk2iQ/x87Sm1GNUJ/SUGk1PjiVJQk3H5fPBwuABistTigfSyDrvOAwSBTddRj4Eub0mF+2Kco
 y
X-Google-Smtp-Source: AGHT+IE61FUE6FkXT6kb2g1gsbTca+OBIGuMOx2CC2b/viDnw7r71KZWgwBu0LDgxkfqf8oPk8/+JQ==
X-Received: by 2002:a05:6a21:390:b0:1d7:1288:8338 with SMTP id
 adf61e73a8af0-1d8bc8126a5mr23516679637.8.1729007178180; 
 Tue, 15 Oct 2024 08:46:18 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774a28d5sm1413705b3a.103.2024.10.15.08.46.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/33] target/tricore: Use explicit little-endian LD/ST API
Date: Tue, 15 Oct 2024 12:44:22 -0300
Message-ID: <20241015154443.71763-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x530.google.com
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

The TriCore architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/tricore/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-15-philmd@linaro.org>
---
 target/tricore/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index 29a70051ffe..0b73b1280e0 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -124,7 +124,7 @@ int tricore_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUTriCoreState *env = cpu_env(cs);
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_le_p(mem_buf);
 
     if (n < 16) { /* data registers */
         env->gpr_d[n] = tmp;
-- 
2.45.2


