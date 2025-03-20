Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C78C35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 13:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvG1S-0001No-Kt; Thu, 20 Mar 2025 09:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvG16-0001Bd-N4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:33:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvG13-0003R7-Qy
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:33:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso8276245e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742477573; x=1743082373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZxg8BppI9WvT0Dj1sY+qDwOoI0QIu58PoW6AIBPva8=;
 b=XATm5mQaRfy2pBKpz6SW+Qo5FviYfzxhBvP4PIwT4NOJ4VFemdLH1SFxHkinoXAorq
 mnRq0dWvxeeCbEJkLEjZZWTlXKTEifyQFDseMko1+iYR236nAJkvydoNlVvxI0wKtiKR
 05NwrMoEtHzc4i2Rcfo5FmhdbK22f0W0NeYg2gSg02OPvvehw4ibi9sOZjnvGf8r4g2k
 W4sM2wzrRwN9qK7hfGR/Sru+yTOULu7gY1v69cEp4RNhCsRExdpwY+epr7EfifGSXQC6
 OhI43qRVrjD8JJ7C8rfUhoSmewOTAae4QsI+ERHROJlD5MzlVEkMik8UiuIR8wgLNMce
 SpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742477573; x=1743082373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZxg8BppI9WvT0Dj1sY+qDwOoI0QIu58PoW6AIBPva8=;
 b=BMhgxoXbuv0//E7MVmhpjZY4DTe9HXKaNe0w4Q0v0R1iuZj/CiylWGdN3M3XKg8t1a
 L2srybB+0jAwJZ0WuNOih93O2Ait8j7skQx72XlZFqGXkoo3Xjskm8Sg1EcpprFqJk3S
 cXRoH6UwQ9fleivekTm5HfOD+B3HTRzZsnAnFTMYYbCnaHlrbZTXWDC3BjudGYEX5FRU
 A77GI3HGwwZDJNRMcpfO3EfkHVaJOY5KyVIUGGZJHOQQpmW9uJVqDHOVTcIqXZlvU6pY
 v5QZN2uEnCU82zyrFrjSvzK+lS4iP3Ekr4U0MAz0WxLtyNRLxbdbY24KoKmx9Cb+naKx
 Y53g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwD2d6aoop0BD/RyZzoKzPar7kqo7m37MBAA4Gr5FPG3bEQo/igJfeGuaJfXi2E5NEZA8C/mFTgtQJ@nongnu.org
X-Gm-Message-State: AOJu0YwjKvVIf300VG7+M9tacHUFOEoNMfildNfRHdc+IH63N2FGZGTO
 +YA9ewkx95c63AGliDDn8H5fLIi1CByaHJ2vL1Q0o7Abz0CK/WUaBJ3arl1zabM=
X-Gm-Gg: ASbGnct8vKcAUe/mgrk5w7Pg4168NPfkyNAioIKP/3UqUy5Qt/5qVBasTY+3Y76rv7+
 ZQP1LuUHqzy0naru2H4OWAH7cMJzKjjqQFQgt270BtYP+cDdvPq0W5TfuJMbPpd8v9+moipt143
 iDS7KZOQqPN/HOQgjLGpntdhd9dw6VHCKQr3uv3Y7+7rc+ELuwArgsZfLuG7H/CtFBfi35HPCd+
 FH9R4MgWRWFmEqLqa34VIYVXlOyzrY6bdFiWOc0STG3zkWS/nkJvcRkeJLeIefLYgKkcvnD8qP+
 nmxMDORSRT0CeHqYpPZKmScoxWwXY+/Qx33tY2G0jb7+43dpy4Y=
X-Google-Smtp-Source: AGHT+IF3B4NlHCSoVkcZaVr7LMsUhBCXLf+4xkU8oS5vEVIzDvuj7yynIEzDeEJSr+oKgnQ/jU4q4w==
X-Received: by 2002:a05:6000:1882:b0:391:47f2:8d90 with SMTP id
 ffacd0b85a97d-399795a8f16mr4008254f8f.20.1742477572535; 
 Thu, 20 Mar 2025 06:32:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdeba1sm48804525e9.32.2025.03.20.06.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 06:32:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] rust: assertions: add static_assert
Date: Thu, 20 Mar 2025 13:32:46 +0000
Message-ID: <20250320133248.1679485-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320133248.1679485-1-peter.maydell@linaro.org>
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Add a new assertion that is similar to "const { assert!(...) }" but can be used
outside functions and with older versions of Rust.  A similar macro is found in
Linux, whereas the "static_assertions" crate has a const_assert macro that
produces worse error messages.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Supersedes: <20250320113356.799412-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index 104dec39774..bba38cfda11 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -120,3 +120,25 @@ macro_rules! assert_match {
         );
     };
 }
+
+/// Assert at compile time that an expression is true.  This is similar
+/// to `const { assert!(...); }` but it works outside functions, as well as
+/// on versions of Rust before 1.79.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 3);
+/// ```
+///
+/// ```compile_fail
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 2); // does not compile
+/// ```
+#[macro_export]
+macro_rules! static_assert {
+    ($x:expr) => {
+        const _: () = assert!($x);
+    };
+}
-- 
2.43.0


