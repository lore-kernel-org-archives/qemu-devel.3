Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83595C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWO-0002Yh-IN; Fri, 28 Jun 2024 10:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWM-0002Xj-QT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWA-0004Vb-0W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-425624255f3so4494115e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584635; x=1720189435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DsjR+0RdxEM7QF1viCRug7HBVlIRYxe8thi8uv984vk=;
 b=Kg5kfZXwB0NCAdmBhi6t8fNXEr+W7I+JIbgo/uzzdFUA9Ynau+0BrKs8ygj7uG5ZEq
 48ZdSKMvTuOLUJ5WOJdy2Nr5IZAO/SBStVgzdPxday8s0LrzdVpBNX1kzIVcp+PzBcot
 6fyqMlfwvhb5GDa/6g1bs/JWFE0eXp6Q662FD4e9jO6sCnmWBug63AtOdF25htc/vpBi
 XYpO1SH5xrbwNdu4wviAjZDaMx3GEVjWEG3YbXzKoqmqZC6AUZf9RRq/r2uf+o9HIBrE
 pQhvty46Bv7f6heDdeJXG/yU5YJl37yzZfnUjyArc0F0CUDSp22hVQ5TtPTRbhuADde/
 J1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584635; x=1720189435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DsjR+0RdxEM7QF1viCRug7HBVlIRYxe8thi8uv984vk=;
 b=cuQT8R2PGFiD4MRP8dIb+/riNn72aV8Vz1UQ+Tc3QjFwfDyxAssonFXdfw/HzIY7P6
 xUnl1SzRxeTjaExcObe8acOK2nYob3OF1dTlV55MBZUJSihU3nDBwuEolF/FTEFx6ZVv
 KZw5lPsw8B7trPqPUxbrildlycmdaEch5jBpCm8IpEIc2W1Hg7Ed7dh8PFnFEv0mGWnE
 9MHK++WNIg8b7cZlmLnGuO5Y4Q+bDBUeRu4iFyffLRq/CST6QDVSfWUEQUYbCOMEAsZB
 zrqk55eBUEgOxe8zmo7pZpDqb322q3nV/ewyQhy8pwj8RL9K0QT79JGz1KZIExqIj1/4
 R46A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQMA5ChF3EIYSMkZd4g1rrzKlpk81y0kATTCOcPjsnlMht5z/iigwgtY+gcm3x2JjC6BAwk7FkPqCn3X+8dQKjpS465Lg=
X-Gm-Message-State: AOJu0YxnFj4Ao73mPYu2gWK8O6IV7/HGc6098TMzj/gjISgVRApzkLOY
 R24oHNw8wKNP452h4wRwQcF+z4BzCkrjvVEmyjO4TpPQXl4pFcNdJ+ITLeMX7t4=
X-Google-Smtp-Source: AGHT+IEwxcQ1zoNOE7ET7i8LU8l/+ueExFR0HltXq8q+oy2wBT/ppXxMZ5YiO5x5w41OKzIvYlsXhQ==
X-Received: by 2002:a7b:c40d:0:b0:425:6055:34a4 with SMTP id
 5b1f17b1804b1-4256d557031mr15527935e9.20.1719584635214; 
 Fri, 28 Jun 2024 07:23:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/9] target/arm: Implement store_cpu_field_low32() macro
Date: Fri, 28 Jun 2024 15:23:43 +0100
Message-Id: <20240628142347.1283015-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We already have a load_cpu_field_low32() to load the low half of a
64-bit CPU struct field to a TCGv_i32; however we haven't yet needed
the store equivalent.  We'll want that in the next patch, so
implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a32.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
index 19de6e0a1a9..0b1fa57965c 100644
--- a/target/arm/tcg/translate-a32.h
+++ b/target/arm/tcg/translate-a32.h
@@ -83,6 +83,13 @@ void store_cpu_offset(TCGv_i32 var, int offset, int size);
                          sizeof_field(CPUARMState, name));              \
     })
 
+/* Store to the low half of a 64-bit field from a TCGv_i32 */
+#define store_cpu_field_low32(val, name)                                \
+    ({                                                                  \
+        QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, name) != 8);        \
+        store_cpu_offset(val, offsetoflow32(CPUARMState, name), 4);     \
+    })
+
 #define store_cpu_field_constant(val, name) \
     store_cpu_field(tcg_constant_i32(val), name)
 
-- 
2.34.1


