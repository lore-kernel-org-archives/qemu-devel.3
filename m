Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74348CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglN-000681-Ja; Fri, 05 Apr 2024 06:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglI-00064o-JK
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:32 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglG-0004mz-3j
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:31 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c3aeef1385so1372912b6e.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312729; x=1712917529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vJCsZ3aWtZ3vLFuGCUAHvoUuLKPBCuN/+TiCfXdCNQ=;
 b=QjLPCtnsSeTeJ/kKLuo63zDl9UBsZC57YDJOauvH++E7kQPzUn+lXLIFiuNju+VSwl
 FXbnwr/fD8/enc/iZV583+E+kRFdz3RNJDTiQAIG/UbuSg6r8WV1dqVM7Xoly7TRQwfo
 ZuUH+JPpQhKtOQ0ssXR4jVydlmM7mJDlHL21MJODaWXXXVJpvbeAMxYfrJYPJFzYyb+i
 5aUnn4mFmqPZNvpA0rgt1YiN9CkZF64xU/hUh/m+p4mobhU9O6ncq5nZ7QgldXrEvWzt
 OsfpssANh/0o7zABgYKjHA2yW0DQAbhdBC8yxbl43o7aHNOJ9NxoGJIoud2U/P7NBOtu
 PLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312729; x=1712917529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vJCsZ3aWtZ3vLFuGCUAHvoUuLKPBCuN/+TiCfXdCNQ=;
 b=B2VX6WUqOqWvxA2UforLLnKo0kmrz76Jr9GOW1pF21/EOr5TcnwHfiecEqDM3kB3c3
 rq5QFOgjOdAVTiCp+t4zqybXLx6HZC8HjtkuND8oQCqziWrZhtHemyPEy8frwdO/55TU
 YlbzerX82AZIxrDKM9f5daYN6bOJsCW1TtoSIHFy+7rVYSCIHxbMCHVRk9Z6NoVIV2gA
 zxcb9P4N++i0XgiMRn6zzEQyqYLZz+4uhL9+KjfW3fEOXxNpbVB3M8WdsaZ4zf+dvyot
 FLTUTfXCoo3qEW74aJ5T6sSCm9gvCatcnTIYyQGhTYOGIhU/d2nVmxKIEUqjl23HHjoJ
 DogQ==
X-Gm-Message-State: AOJu0YzcVUd5O9l5fiEmGdN9vm1tTKjPlmLWoKssn01bQHMCkj8Q3i8u
 SNIWgdDN5psQqrvtIj3Oh8D1TIE0ohjzU3ZjMZxvukjU7QZ2KWt9IKrcFRJqRQYrfCB+GoH9B0l
 M
X-Google-Smtp-Source: AGHT+IGpEnTYJ0P5ycjUqHwcNrDUP4siVm441POPz+fLwG+EFshohy7ArNd32WHuE3cnu9jSWXIkqg==
X-Received: by 2002:a05:6358:9805:b0:17e:d8fe:be45 with SMTP id
 y5-20020a056358980500b0017ed8febe45mr1016780rwa.8.1712312728940; 
 Fri, 05 Apr 2024 03:25:28 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PATCH 21/32] target/s390x: Fix translator_fake_ld length
Date: Fri,  5 Apr 2024 00:24:48 -1000
Message-Id: <20240405102459.462551-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

The ilen value extracted from ex_value is the length of the
EXECUTE instruction itself, and so is the increment to the pc.
However, the length of the synthetic insn is located in the
opcode like all other instructions.

Cc: qemu-s390x@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4d308860f3..c1614b8264 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6201,11 +6201,11 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
         /* Extract the values saved by EXECUTE.  */
         insn = s->ex_value & 0xffffffffffff0000ull;
         ilen = s->ex_value & 0xf;
+        op = insn >> 56;
 
         /* Register insn bytes with translator so plugins work. */
         be_insn = cpu_to_be64(insn);
-        translator_fake_ld(&s->base, &be_insn, ilen);
-        op = insn >> 56;
+        translator_fake_ld(&s->base, &be_insn, get_ilen(op));
     } else {
         insn = ld_code2(env, s, pc);
         op = (insn >> 8) & 0xff;
-- 
2.34.1


