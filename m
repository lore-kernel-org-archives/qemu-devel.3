Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B0BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaho-0005uC-HM; Tue, 04 Mar 2025 17:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah1-0005Og-Fk
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:51 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagz-0006Vb-KH
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:51 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abf4cebb04dso47557266b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127088; x=1741731888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZvYp7FSlelG8xgQuaTWht4mgcpsKdckID5yTml3+ZE=;
 b=SY2B9LIvLw53PYW3XUNPozfdyJjmZ87iTgcYRdAz27AVFN1Ye+fcorKqVxjY8boA5P
 WGWHSlfAZkCZXVuIQ24anpT52d0ULdLDrn+v7PIdDWbj3BKwQE4qZx5T1TJ+ecQCY4z+
 Ji6+wwKrJOTfTmrYPSPmfVxj67ilSjxUyzoMIfppFw1sGMh6cD1TDdYTAhdkjCZxgI55
 3o6fOZaOddPi+YjB6ghxWZjppSKG7jeB8pdDQRuHLzu8QF54RxxWgJH48d3xtDOqwavs
 NpCvtCbUmCf2qEpexJRVcA11XSLBxHdup6HBRY+U7BrfwClim6Fg7iK51t1OOjgM/PZc
 a8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127088; x=1741731888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZvYp7FSlelG8xgQuaTWht4mgcpsKdckID5yTml3+ZE=;
 b=S1qhO1F6qQBIqkdrFBJPaTd+iaMsuIrrdCiCAVQJUqMWg8D6SpUbjMu59S77Rb4FVO
 Hf49wikpQXGYmDworNULySR1Yrzxizbe9e/ST70z4XlzDVvZJKedJLAhlbt1IUMMjpEp
 TT2yhdFbDkD6Hbx8kf4jlPm0xLB5iOExb38fzGaMc3eJKr1j3w7U8Lzl0bovwQC2Be0G
 /vyVlxDuTZcHZzwwFp+Tb4x5wd1Q96ERbz+fAQHZQM9+edA5NoLUcrbtDIxfuhqqbaKF
 1xwVyvj5bpVP2sPTwiOBtviKqav0TCutDesgyHGPZq3NZR7lcIkIN/RkeL9gmTFxOKXO
 PgfQ==
X-Gm-Message-State: AOJu0Yx7co8vJX0rdD9/xJCetFmc41/AzL5hkLZDcT9jk93vbN8JXFwt
 eLtubXKjlepys6YSEtXn5ZvMEEgNXSbBp6MBJP4n4/a1Ody/gEbiAbV1an8xGFA=
X-Gm-Gg: ASbGnct7Gads7FyquKblrWkx77ZIQ1kf/PILYcfSQVm0DlnXKCNOuzhJXyu9p3SqR1T
 /j3jzj8761WqoBDrq57AKXSateCah5ZkO6Vaxsdg/ITwMJjKuqN2GN5CNLLcDGbXGPQq9ryHodY
 q1BX7rImjYbRUYwo1VbalCzsy6lZ8cD1hi81SOz8ju991bPbHdrYkUjio2kqnmdwyrVk+nu7eDA
 /CvkDhBC8Q4U984MkIsRTP5p5EEb3reZzHT44szEO7oWKJmpfRssgrinPzOlmbpaRCuR24cLhCD
 qjVUZ8k6run4ZBfyNd5xi+Cdg1ui1Qb2uN9Q9k3efdt+aXM=
X-Google-Smtp-Source: AGHT+IEW620O6/PzN260m4MOEMNjBvEkYO621jVnwMaTgFfnOqoSCKbWg5B0P3rKLghYiOEMmeIwSw==
X-Received: by 2002:a17:906:794f:b0:abf:7a26:c473 with SMTP id
 a640c23a62f3a-ac20edb19c5mr90649066b.13.1741127087550; 
 Tue, 04 Mar 2025 14:24:47 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e382a04bsm277988166b.163.2025.03.04.14.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E509B6007F;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 15/32] tests/tcg: fix constraints in test-i386-adcox
Date: Tue,  4 Mar 2025 22:24:22 +0000
Message-Id: <20250304222439.2035603-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Clang complains:

  clang -O2 -m64 -mcx16 /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c -o test-i386-adcox -static
  /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:32:26: error: invalid input constraint '0' in asm
          : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
                           ^
  /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:57:26: error: invalid input constraint '0' in asm
          : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
                           ^
  2 errors generated.

Pointing out a numbered input constraint can't point to a read/write
output [1]. Convert to a read-only input constraint to allow this.

[1] https://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20101101/036036.html

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>

---
v2
  - followed rth's suggestion and removed additional matches.
---
 tests/tcg/i386/test-i386-adcox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/i386/test-i386-adcox.c b/tests/tcg/i386/test-i386-adcox.c
index 16169efff8..d653fa86a7 100644
--- a/tests/tcg/i386/test-i386-adcox.c
+++ b/tests/tcg/i386/test-i386-adcox.c
@@ -53,8 +53,8 @@ void test_adcx_adox(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
         "adcx %3, %1;"
         "adox %3, %2;"
         "pushf; pop %0"
-        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
-        : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
+        : "+r"(flags), "+r"(out_adcx), "+r"(out_adox)
+        : "r" ((REG)-1));
 
     assert(out_adcx == in_c + adcx_operand - 1);
     assert(out_adox == in_o + adox_operand - 1);
-- 
2.39.5


