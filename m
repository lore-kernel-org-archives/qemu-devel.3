Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96714CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LT-00089n-GX; Fri, 26 Sep 2025 09:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LQ-00087n-Bh
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kw-000451-04
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so2035246f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892683; x=1759497483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGV/ovuNyIkegXod3SFApgfQtr3bgHJbOlxaNSaOG6U=;
 b=Xz1R4+0kMysSgfZ0nLThkWZkVCigbvYzAV3LRdf8TFcw+wHGYgAfzpdO1OR6Bu2wJy
 02UG+WXl9CCuXwUMA3ZucPdWnWJWGurcwhHyQMWDKqtD3NKYrDVin3ejx69VjSVGNB+L
 CXllu0o+YUnb1OJTlaF795Ray3LE3erRYG1t9TP47gNjptMExKFNHs3zJh9/4jIObCnj
 nNZZv4rHylSaHTT4ytZIqa6w9jN4no2YL7a3PMrRSNlgZnaJxAeYSjsYhsQK2zrv7SdK
 /tXUH0P08UTmjiMLCcP4ICd1moDnlo8Qf5GSeYGUC95Zd+gp25K2tas9UINMpf4Eyz76
 gY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892683; x=1759497483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGV/ovuNyIkegXod3SFApgfQtr3bgHJbOlxaNSaOG6U=;
 b=gOUloS1GX41qDIcL5P5zKUz8HCGWP68BTRzLKW2XmWtCFwVu/YXGKdkPBQocFYjYNM
 2vp0z/GLgn5c4vbXQXVvKIUk2SnQXyN1/0GpK6BFzzTavH2mf6647wJjkYamNJRnWep2
 Mx8Ih1YrVZko8+bUtY9rJ6ct4aj25bWBAoPOjIz4+RX/z3PnMTk2rcmy8s8yayytMQej
 345jlWWLPEVM09cYIWl0HsUPNnGzJZLRvT2xau/ktv7rB4N1Q6gVIl5uE69T7Q8EIbTU
 TrOCXveQhUlwmYYSdNXhOhja3qaB3flSffsgD0I6nzFl8d/L+fL5NKETA2QqiQbIX2Lg
 wI0w==
X-Gm-Message-State: AOJu0Yw+BkfEJyBdazLsYbum1mNxGGPIm1PxF3eGBtX3mGjbpG6by91G
 lZSjj8nP9lAW1ngKweqCiTF5f9blLLdP6FzQKPuvK2LmVqtOTrxqsGOfLisP/z7ZsGM=
X-Gm-Gg: ASbGncvIq80zQhF0YeqRlLZKvxx/5xYnkEp/b6VU6x5YX1uNdP/bd15id1UR4SeM7mb
 RoOF7UIUfuDnfjKNyCxbuGX7vwgHg+4Joubdhh8vlG8fgx5TProaf2TTCTD/GJxqdBzsgI/g44K
 q2f1W1YAtwkeQiHkP5oNcDSo5YZFOXge8NjmintkGzcNkPhylFgyTjK+MrcpcR8L6JIRCfkLM9q
 eGFTM4BTpcuOlp/CCT3QCGbrnLWd8QzobNiLu+KAMvy69+dzhgrOeTPzpSQ/gInqicpLUWWC8Zj
 JkquR7uUqVraZaJENfpBJtcdVFgUH0PwvUPpxHyWCmM1k+u0kt0S+qOoEQbch64EzD9M1XhWeSh
 RS5pHPZ9EPoWRdLcNM/hzaac=
X-Google-Smtp-Source: AGHT+IGPqn24RRByExxDxg0OKc0IwFdWACknOyFRPsB09p+6WhtGHvZ1oLLR5jkeI+6XoQ9E1OXqSA==
X-Received: by 2002:a05:6000:2285:b0:3de:78c8:120e with SMTP id
 ffacd0b85a97d-40e468e7392mr5964230f8f.6.1758892683366; 
 Fri, 26 Sep 2025 06:18:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9ac5basm138161865e9.7.2025.09.26.06.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26D685F924;
 Fri, 26 Sep 2025 14:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 15/24] contrib/plugins/execlog: Explicitly check for
 qemu_plugin_read_register() failure
Date: Fri, 26 Sep 2025 14:17:34 +0100
Message-ID: <20250926131744.432185-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In insn_check_regs() we don't explicitly check whether
qemu_plugin_read_register() failed, which confuses Coverity into
thinking that sz can be -1 in the memcmp().  In fact the assertion
that sz == reg->last->len means this can't happen, but it's clearer
to both humans and Coverity if we explicitly assert that sz > 0, as
we already do in init_vcpu_register().

Coverity: CID 1611901, 1611902
Fixes: af6e4e0a22c1 ("contrib/plugins: extend execlog to track register changes")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250710144543.1187715-1-peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-17-alex.bennee@linaro.org>

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 06ec76d6e9a..811f3203199 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -95,6 +95,7 @@ static void insn_check_regs(CPU *cpu)
 
         g_byte_array_set_size(reg->new, 0);
         sz = qemu_plugin_read_register(reg->handle, reg->new);
+        g_assert(sz > 0);
         g_assert(sz == reg->last->len);
 
         if (memcmp(reg->last->data, reg->new->data, sz)) {
-- 
2.47.3


