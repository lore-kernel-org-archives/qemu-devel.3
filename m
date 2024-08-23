Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF89FC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 08:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shPPL-0004pb-C4; Fri, 23 Aug 2024 04:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPPE-0004Nd-Fk
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPPC-0004q4-T3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:24 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7ab5fc975dso195152166b.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724400741; x=1725005541; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gZX6jsnmmIcrh3iDFhCFFrxE/sOzMmJohzr4pZkqYN0=;
 b=DNUE/6wZ6Mpc/5heq/2aUStIZbwrHvQ87aT1PI4bhLPwVpNeO1U1veaaTFDljYvM3e
 E4cWUbeC/aeRY5GYL73oZeO9gp46Jk+8dBcDYGiESiYRv2sjZb/5Uk21yt0XPUEKvBKo
 8wZpjeJBR/WtmDtR81BZMHhNIiY2K/hk7S3YbjHZGtYAAgl8o2DXgFEBVggS5bgmLNTh
 04bVfFgJhxEF2Qla0mWgut9DZX8ubFThqNeQSkOG0zOGVhwMQLNpyhzZtvQH0YNd1SZ0
 jUaOer3L+quXFyTCjbBgDIyFVxRw48PQJx3zG7dxN0RcFwOo22FDS2CAENsxCUvmEmKg
 BlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724400741; x=1725005541;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZX6jsnmmIcrh3iDFhCFFrxE/sOzMmJohzr4pZkqYN0=;
 b=DyUZxypCNcWDWWJEx9pQFd324Q88Z7iFDpKcDoV7eacvCilHRlWMFY6ikLtylWMBDQ
 +N3Eh+x1XdveEajCIHYGvSc3tsJLnc6pnShG7fJXujLgTNqRdkPOoHVZy/heTfjB0ql9
 1DgBa/3RvuQr2jcnc6ESeSgTeh5nzjzh+jOP5WSm4bjwM9Pto+EdH+U3H1QKLmOJcu2o
 DhJNKZ3UwWOal0w72df4o4Q1725R87dfAd0D8Z6lFzw0fBDWeSWeYxDIJGT48iV3w1+o
 uy9GPkolklWBlnXGhSqpR3hcHv1//G8/Xuhba43f28oZlFr1MMVcguzJ9No5SpJeZ8HL
 QNFg==
X-Gm-Message-State: AOJu0YyxDd0lIe6EVNUwWBaBxXkV7O8p1sYSVtIwm8abfquHleL1xhjh
 bMEK2kSWI5e15LAtsLXErQy3Xx1BB7bmPwNIrvPdApOI8JKgzOdw/mh00sXsm+k=
X-Google-Smtp-Source: AGHT+IHQlTjM9f+lahunz9FF43M4QXcOX/UZjwNdQJwSOOsnl+oXPfwEjGfGldZvkrSVqrO2fgdjOw==
X-Received: by 2002:a17:907:ea3:b0:a7a:a892:8e0b with SMTP id
 a640c23a62f3a-a86a52bb0a8mr83556666b.19.1724400741045; 
 Fri, 23 Aug 2024 01:12:21 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868ee6b390sm223620066b.0.2024.08.23.01.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 01:12:20 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 23 Aug 2024 11:11:53 +0300
Subject: [PATCH v8 5/8] .gitattributes: add Rust diff and merge attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240823-rust-pl011-v8-5-b9f5746bdaf3@linaro.org>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
In-Reply-To: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=r9fVbmhGtXasriKuB3hw4s7B3j9kUJZLR7F1C15PCwI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm15RVJZcVhCZFBTM2JBZ25WbW1vTzR1cE1iWXdDCnM1Sk9Zc21tN3hiRDN4NU5R
 RmVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnNoRVdBQUt
 DUkIzS2Nkd2YzNEowR2dlRC8wYkpDZFlYT05ma1BlRDZHYVBpczMrYWxhZTF0Wlp4UXQ3eTUrRg
 prSGE2dDU0Q2x0K1lKak5RcUxQOVNtRDZJUEhVM2kzMk0wYzZUaXh1Q3RGN0ZnYnJCdnVKWXdke
 TlhNGxPeGFaCllITXUrL3g3V0Q3WmtlYllYVWhMUjh0YUdGN1Z3QkEzL2hhTVZxTmxTZm1uQzQ0
 ZzRabmpya3Y3RHVqVW56M08Ka1JTRHM3S0RSU2pnbk95aGpjclNUc0FKN1EweTBpaUtJU2xNQ2p
 OODdVQmQxeGpuQ1B1VUs4OHBQWHMweFoyeQpacVVLRGJxaGNLZXFPOWFKcjMxN3drTzFSZW5WWT
 lvQWo4YXk2elRBUm9PTTNkelF1elNqUTZtUWNvMktUUHBHCisydHBGd2pOMGVvRHZ4V0tzdGRMa
 XJFeUtzR2pkbEFWVFh3R0twUHhJeS81anh6VTYyY0srSXd1UWpMMk1PdzIKNGp0Q21vNzkzZkMw
 a1NkakY2a1J6c1RITWsyck1PV0tteXBSYVIzbW1qNkhiZUJpaEJqazFRV1ZFeWZEeDcxNwp0WVR
 ZeDQ5YkJTdFloZ0NQNERHeXQvTEYrVjZKRTE1VkFodHZFOSt4aVRvdTR2cjVGVFI4UVp0ZTBzRS
 80ay92CkZwT0xWb2UrdnlFaWFTR0s5V2JGY2hkS25qRWRZVWUzRDBtQ3NGVnB2RUpGQmlTS0Mxe
 VM1SnFrTlRNNHFJaDkKMlh2SGF0aVRzUXhQR0FlQlVYK3ZKbHA4Zy92QWxwQUFpLzZKWXl3d09x
 Tlg1NUVOWGJTUE4xalZzQ3ZnRWhENQpWa1l2dnpmQjRsU2krOHZaQWNXS2N3aFJCbFJSc1U3V05
 6RlpSU2hDSVZjNkQzR3QxUFB0WGpCWlNCU0p5V1ZYCkUxb1lrZz09Cj1QZS8zCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe..6dc6383d3d 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,6 @@
 *.h.inc         diff=c
 *.m             diff=objc
 *.py            diff=python
+*.rs            diff=rust
+*.rs.inc        diff=rust
+Cargo.lock      diff=toml merge=binary

-- 
2.44.0


