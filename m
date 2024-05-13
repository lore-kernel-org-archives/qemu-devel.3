Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E48C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPY-0002yy-LU; Mon, 13 May 2024 03:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPF-0002nQ-F3
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPD-0001MG-Dy
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e6792ea67eso9358521fa.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586450; x=1716191250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPgByWxwzXGsjb5cyHbmkgL2AJQKmGydyfbe4dpBirg=;
 b=Y5dqXoAjCVhUMjg1syXcbPmwixvNmTovBHqbR5MrBTQ5D5fC2SZ7qCeIxL6HW+w8G+
 iAntUYkPCHQRvv5icmX/2LvcTpeeEAUcB4J3cuZMsqH9DTJ6maWmGDgrZtwpRCwKU09k
 NYwTa8QhmQ7nxu1SDyYNYgVil6ALzwuEMQ5jZEd6yLBAeyK0HlN8jnRWYb6nqD4M7F8R
 C3dVFTJ9bl6rp6ZAO+1LyIYSdWpJWmAxUUkSc7CK2DIy2UZnQ+agwjkLhLDkf1ydQf2F
 NFfq1u4N1s9u4arZqTl8y9c8ULIo3qS1K+I3L/u+muD+figbyU/mD5SRkC9iArkThDSC
 ozLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586450; x=1716191250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPgByWxwzXGsjb5cyHbmkgL2AJQKmGydyfbe4dpBirg=;
 b=Q20ttAUZ9yyy2oQM30uR8kRRQ1CPgjDFel/6TRYDCsA+juzIypa/9S3DUHTv4Y6em9
 usi0E9Q1kVGr80HLUFdyMWdEVKRr43BW+cV8HVyYZuVfPDp8ibFciF/Runr+G5Q+2Snj
 Zs4WyaAlEmKLH3XnFHdfjnubY315MrsNpHFJmaLFOM/YugQ5zP+1yVw+4qe4XDHKCEdx
 qIoHKFTg7RQK1a/OWl4bfhfuiCPfrU5RLmdTP017cu7bRW+0kI5z52CwbPdG2kPzgl+2
 Js9GYQGL0W7YORDLhHer36lBGlC+Sm6Fp9b82n4f1IUGWSJ5Z/ubBRJ3NhaCwnyHmwDj
 5HhQ==
X-Gm-Message-State: AOJu0Yy83mMuVSyZYRGm/If6LoruRSWMsx9f7iKQ9ZITXAMcxHoMUuRl
 jzCJuTYvJ+9Ov5zD6s1FigXXc0UaG/CkFZslOdnSHuN1YixDqiI+QsnBX7AodQuH8YY/NE2oxd/
 wSy4=
X-Google-Smtp-Source: AGHT+IECyhqUaF5pI5fV/5G3pqisQxJPYGyPKfsZfn/s55oAF885b4UVL4izPzptyo3pkaHfIw9QSw==
X-Received: by 2002:a2e:8748:0:b0:2e3:4f79:4d26 with SMTP id
 38308e7fff4ca-2e51fd3fd73mr52184431fa.11.1715586449892; 
 Mon, 13 May 2024 00:47:29 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 15/45] target/hppa: Use umax in do_ibranch_priv
Date: Mon, 13 May 2024 09:46:47 +0200
Message-Id: <20240513074717.130949-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ae66068123..22935f4645 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1981,7 +1981,7 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
         dest = tcg_temp_new_i64();
         tcg_gen_andi_i64(dest, offset, -4);
         tcg_gen_ori_i64(dest, dest, ctx->privilege);
-        tcg_gen_movcond_i64(TCG_COND_GTU, dest, dest, offset, dest, offset);
+        tcg_gen_umax_i64(dest, dest, offset);
         break;
     }
     return dest;
-- 
2.34.1


