Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72507606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lrSoMV5v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aE-0006U6-ET; Wed, 28 Oct 2026 12:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aC-0006T7-EH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:00 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aA-0007XE-TP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:00 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6deb848ddd7so944455eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205177; x=1793809977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UufAhb1eCSDnMmYHzX8h68pmrDRUz8YER2QPgDo1oN4=;
 b=lrSoMV5vzyYaf04rew4RaaY4oAjOimy6Qna04SO15F4fEvQyUKIegjJlitvQxwcVIZ
 tQPumNcljISQw/ltvWwx7PO3f2NuzujgFhZepwOcSQJ122Mag13l9Wr2Wpe8d+nN9WzQ
 ufgIjc4HLFsclhHncA2HfsJrGOfVakLsShh3/44BwI8sT4UzdAFEF9ZZ2Ew9egUn8mc6
 c2CB9DD1JiQ2WW6fpzELABjkXonzJwFSlwX3CbYCZawDKwFvYqEy/osWrNQ53ORd9Ypr
 DIvPV51n8LBqiMhbfQJ9kxB8/xuRx6X3W3lh2AkN+i3zk6pd7oEzEITeVfubCjaZnmhb
 w4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205177; x=1793809977;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UufAhb1eCSDnMmYHzX8h68pmrDRUz8YER2QPgDo1oN4=;
 b=SkVyW5iHsO/0xNB+/tcBlsOicNCwGzmHDcVrKd+pWBXuOSunYeMKkrttyuNHP/G/Ie
 syadK4KaBvXZv6JjRPLEKYLtzW/bv79AgmFcn8HtewKw8sZ8zh93dAZEbzHq5BQhiHr8
 1JTpYqHBDVo0WveqEnzdGVwoGPDc39ZyO1tpYiSYH/jy6rJQba+cuGeN5y3yeLguIrfF
 bJ1KFMHxfBGzReFbxbUktun8ZxMzTmHiYe9ReACd4ZyoQ/a7PrKnjRXg5YMI+A7rMDM6
 zuMUiqQFZZPjvZh0whZ4oSykZ3Hb928bBAbNTTjHMqIhejT2w3diHVeI59CiVbxGCZHb
 CfBQ==
X-Gm-Message-State: AFq9FYIUE0tNZtwx4KEbtCoHOHnV9VeIde5r9RbLsIb/zkKEaPjB0LDk
 JD9qmOvddAMqjMuKKcx9QHMXvd/jlA1ED1/Ia3AI7u27w4e+vwa4ELXAjWJOGoIcvWBlv2GIoXq
 JOatr
X-Gm-Gg: AYBFou1n6KJM+hs/vdBiRNGEn4dUF/LG5gfbcgXqpEZ6OWib9ARG0wM/1los70bjhis
 G2dYccyiqoN/aLCFD1MpahvEAaS5G2Kds691ml301raInYmfOBsT05bLedfN3xZai7doPDLoQKc
 yPA20PSvuRjcHJ/xFyRSKg+GnafuaTpZT+9vZIodFwPgZ1a6UYWRi5T/I6Nvd/zeQAj+t2IepzW
 +/caHXMQWTtENjDvwpNbaw3xL63xwtpr3bbnCFOttwV/Y9bVo8jJQzC6Mly3Pp3aBwSPbarPuhs
 YHgUjNb/pzYfxjDKz3q7w4IlOQ/aLt/r6une3kao1RX41NgQgnxlWWCq9yNqbp4IZCyW0i2owML
 gJdVO7UiAytm5DFP9Lv81k9d6hBDN834nOP9bcjspKcoNANuOyAXX9BASmFxbuASkRKcPMMpgfG
 6sK/Ggy8F9VdmWRCJMLtYL8JQUO/AOriOVUUv+fhZsra5YWsYTDCcPiwizyxMFs6W0g36opPqfU
 mGTHbD/RE0H0OhznQs0gOvYGi5REF7lx7xY62dvqwbyJy/ptELOFqQchMETy14zpp+P5Fr5l7k/
 fV8wOtDH2lKbFC3g8/uUDKcXiwXeBZHiDBfQBnju0G/zsCzbieYY89k=
X-Received: by 2002:a05:6820:c2c3:10b0:6d8:3caa:a469 with SMTP id
 006d021491bc7-713f07c932amr1149431eaf.88.1793205177408; 
 Wed, 28 Oct 2026 09:32:57 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 08/16] target/s390x: Use tcg_gen_lea_i64 in get_address
Date: Wed, 28 Oct 2026 11:32:37 -0500
Message-ID: <20261028163245.1031673-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While there's no actual shift, use the compound function
to add two registers and an immediate in one step.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 474d604ed1..ce55edb93a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -460,8 +460,8 @@ static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
      * displacements early we create larger immediate addends.
      */
     if (b2 && x2) {
-        tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
-        gen_addi_and_wrap_i64(s, tmp, tmp, d2);
+        tcg_gen_lea_i64(tmp, regs[b2], regs[x2], 0, d2);
+        gen_addi_and_wrap_i64(s, tmp, tmp, 0);
     } else if (b2) {
         gen_addi_and_wrap_i64(s, tmp, regs[b2], d2);
     } else if (x2) {
-- 
2.53.0


