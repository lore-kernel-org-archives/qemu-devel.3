Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAADECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so06F-0000hu-Rn; Tue, 10 Sep 2024 08:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so05y-0008NJ-UV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:47 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so05x-0004qY-27
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so9971239a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971742; x=1726576542; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HKQ+Tr9nd7UKxDYpE7u+hcEQP2VtRBhfmqRFJl+mGfQ=;
 b=VJM/ryfmEiRLyHAE0qrH6tt9ZZIcOU2hB5EFOGL9QUg5EkPALe9IN0AqxTkQuQF7rl
 8/9HhG+Dl97S0b96tC72prdp5j4EHPd4SO/L22QsHkr6l22w+nZhcMyIx1UtnIu0q8yF
 s7nL4HiqQ0koGb+uBX14RDWT3VmRiIl0scED+hZS0OwWsqsWmIMa3cKAoefcYObbJfh8
 4HajLPaEO9uklFb2iPH0T1ELWKip1GswrYOqXs6GMQcP4mZuQqEUhzgBWMgEeLA/2a+u
 1Tjn/QdvqYl1KTq0ZdWSlr7ZiNgSh7RaGwcWb5R6MYJYJv6bj5IdGfdha77WPozM/+WX
 mY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971742; x=1726576542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKQ+Tr9nd7UKxDYpE7u+hcEQP2VtRBhfmqRFJl+mGfQ=;
 b=q1lygw0/epo04Yq+qJp4b5tsykHlXH0fcESyZ0J+INhZJyBNbAnoMVlY5bYp9X3fZR
 FaK1vXdS2JYUQy8D8beOd5n0bvV/r79oo+9bEyPy8ekn2yCD90kXQaPeHIz9Jg+O3u1C
 Ws6eC/xJpTdgCEQgRxvYOjQPii1SVV5sEYwD59iQWdorJ7EaRx94jXXuFFi7yPauFW14
 mGly+Sp5pqFoVfEs/1wHVVhUlDrmuMDMZebYxWC2sAiDJLoEgbJasePRClA6EKY0QgLf
 dzJTrvnO8JWj4IxVMbjJfWmsvsL9ZeYYOSk/EmRT6WVFzIY/rzcC8GWi8UbifLy5Y8+z
 lCrg==
X-Gm-Message-State: AOJu0YyOVtdw77iry/XAMVyUsWB4nlm5AH7J81R9d4/tYU+14XG4kFiG
 GpAfBVOsMbyoyOgpvayY4PwdRGZARky3e2Lr5VsN0QETOpzDOwf9WaHTCyKpj6FaNgYeYKbdqtB
 jHLs=
X-Google-Smtp-Source: AGHT+IEVSPykWMZ9Z/shkaJ4YoprIRTSvJPbzwXMZ3AskobBgVmAtIQFdriLsTbCS1EFKzIXZchzUQ==
X-Received: by 2002:a05:6402:5209:b0:5be:e9f8:9ba4 with SMTP id
 4fb4d7f45d1cf-5c4015ce12emr3119613a12.4.1725971741720; 
 Tue, 10 Sep 2024 05:35:41 -0700 (PDT)
Received: from [127.0.1.1] (adsl-234.109.242.225.tellas.gr. [109.242.225.234])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cd7sm4242994a12.3.2024.09.10.05.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:35:41 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Sep 2024 15:35:11 +0300
Subject: [PATCH v10 5/9] .gitattributes: add Rust diff and merge attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240910-rust-pl011-v10-5-85a89ee33c40@linaro.org>
References: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
In-Reply-To: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
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
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=cb5hfvQlqbMpu1WXDHeHVpn8WY1kxaNKXHZwF2lZXrU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm00RDBNR0Yrb0hwVjVqWXJNYityRmNmenZpMVQ5CitMcnZCeWorRVVPaEg5N0lr
 QnFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnVBOURBQUt
 DUkIzS2Nkd2YzNEowQXJlRC8wU3FlTERaTG5wQ2NLN0lFMWRGUU9hRVpXU1k5Z3pFaWFFdlJKNA
 poa1V3VU1kUitqS2FZOTJ2VzZQN1ZCdExXSmpOVVJMMWpLdko4NEQrZXJweGpTQVBuYXdzcEdhY
 1RCNlVLYzMyClI1Zk5iRXZtQ2NXM1BoT1FlR1hiZGJjYkhBUXUwT254bkkvYS9kZzhPbTlvdmxY
 U1l1ZjEwNVlpZTlaaGN4Wk4KMTQ0QW95NmthZmEyVTlhT2tLTlcrcGJLTTlPTFdBbkJ5V05NVzd
 VOEFXdWpPa1J4MmJFMVFuby8zdDdHSThIbgpZL3RScUJsWVRoWUVuUE1kYzJpNlRlc09NV2wydH
 BuRUtmd0FkVkNWWjY5Tzg0cHJTVEhXbjJpaVhTb3BjOWY4CkNnSCtMMlpUMGs4M21uQnJOZHVxV
 ndCRjc3K1lkdGpMb2pWMGVaV055LzV4aWREVjN4YWRLWG55R0JNb3ZBMW8KUkZScXg1S1FTY280
 b0VyYUY4VGxKQ2IxUTBYUDdZb0l0dGk1bEhqUy80QjB1bER3WjdLY0RqMWVNUWFJMFZTcgp5clp
 GVVh6QmJtT2tSZythRDNlQW9FMVlzRUU3T1AwakR3OXpRdUVURHFBaEt5b1VRUzN4eWh1WFR4Zm
 VCQ0x5CjQ2RWhQSWtGSEJkMWdybTBpZWxUQXk3RGIzSFRFemgyUStkOHRhWFFoRTVFc3cvaTd1V
 3VBcVlhN0t4L3QwcTEKdTdDY1ROaGNXWWtvNWRnN0tLVmNBbE5QMUpuY2JQMlhTK2ZkOW5TRGRp
 eFR5WGNTa3l6REcyaEpnWFgwZzQyaQpEd1dxdlo4RnB1aTRjNHJXQkp6TVJVUEd5N3NRYUg4SEp
 6OGlVY0VUaDYvL0YzMS9iMnFDT3QyZTVobUtzelFwCmM3MnZ2QT09Cj1CMEtJCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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
index a217cb7bfe96ff6c8548f510c62c6e16b2d5faa9..6dc6383d3d1199eca5479353cedb6d83d98d95ce 100644
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
2.45.2


