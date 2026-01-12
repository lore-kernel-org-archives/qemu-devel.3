Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F71CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoy-0005eT-UW; Mon, 12 Jan 2026 17:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQow-0005Db-9Z
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQou-0004II-JX
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so38371255e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258531; x=1768863331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=seqD4GII2z3t3svY5KvkPxVlc0r08rOflGB+0QkgCUg=;
 b=RGd5qslH44bjpiCOLPcpjyoNMD0g+r16ZYZABz72jvxysfm0ln2fSAfLdGeGlHOyx8
 m0tEGaFd+vIaBkqbbd3jLPdigcnB/6DK8cPtNsatFXs+kXByjEkiKRVCIU1HgujgUq4b
 Hx+m5W/tWTghtyLyjI0CwDxXAerr/GpI7DRJl/5hRs+d/9IaryCd76FUASGO/D4rSyIK
 i0uBjxmL0WQ9Wa+VBRd5LYr00JvMJDmTKu2Y7Jyc8HKkc8aaIDtdlQbfMGM/RVvsUl+S
 2aTP/aNOUACaFdML2xZ8rWL0nozzJEjtL6MOXzmuHwJEC9MHAk3eTmTs+B6qYiY+//ag
 LBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258531; x=1768863331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=seqD4GII2z3t3svY5KvkPxVlc0r08rOflGB+0QkgCUg=;
 b=Okn2M0yGIU4qMyxhsjjv3cX2Hxg1K2vMLA16X8gZr6E4YIHhOjrl4Xa7mNsKsrlxEk
 +HlyQl8ROBTxco/cTNKZOy7TgI4hwCScUlBvHtMisk3wTRZo+UUA3hDApjKNfwMvp0cf
 I1w5Xl7OtZHQ9I2Y6nBosIDZL2sMombh9eO8a5wXDf5PALp5Yr+yaXc0r08HU6VKj+fM
 N+j1MUKIR56FgRmcXaX+wu8qCZdAOb8K8tviK8sKql0TqaUA6NJ5tVKjqYUpJN9Wcihj
 t9p612uw9C/lhUiMPzBkmf9J12F90KPMWE8wxyZsb3qKbaaqmensGxQhkQGx6Agx+XUw
 4aPw==
X-Gm-Message-State: AOJu0Yz11M7dgL7tog0GgnBar0FTftOr/ZlNFQbNVvnB8EiZ+mZC6/R4
 GNsX8jMt76NSgzbWu1LjUE0Ek5WWX+bVBagcgQKGHyK6JooCi3vgGuDL/cEfRIEUgvcZeZrG/MA
 D9SPzuik=
X-Gm-Gg: AY/fxX7QfpK+I5qmy5A0wEpN8UATi02oY3zawmM9x5hV73ut+FVZFhwjn9M+437vLJw
 mt+WQwOkey5pQYQ/T6XnR/UwK1S4Z/lhPV9kj+XTOGa9fZvOn+SknPZytLfWZMevzM6zFqz3rbH
 kTR6pAzMinZ2zRQmWa98Q9nAFdfNVSpHKKXfztWz8V9jlJOk06GUXw3wkSr9RPubLS8kWOUWf+h
 7PZ9/8NGq2WPoa0gn4beoPLtPTx2YjX6g2bSO4h9opGxrOR9y8wuBXQwSZTMNiKaJcGT4vn96zn
 5qHhH6eLmxpNHCIf8+h0uZ3nmSywqMuh4sDS8fy9BkSMHLDtvcwB7iQfSINduMlOPiTCLE8GmjT
 EMGp+LIT7GFKbfn8dI7FRSRv19ejiSluRVrFby2y0EsH1VI8nqpIzEzvmcnxZLJiuxUVZ1zVAwn
 hl1Iwn3Al4Vu9Qi/B6AgvgFQHluxINk381TD53zy5PeBlZYrTNMcoFICX4nb4s
X-Google-Smtp-Source: AGHT+IGjJXBNx1nM5NsTI8uhawhVzHTEK3+Oebvs3EhgvYR8Zbhv7iZJU57B2vi99mwxzJy10ae0KQ==
X-Received: by 2002:a05:600c:4e88:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-47ed7c15ec3mr13153565e9.10.1768258530706; 
 Mon, 12 Jan 2026 14:55:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm388250595e9.14.2026.01.12.14.55.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/61] target/tricore: Build system units in common source set
Date: Mon, 12 Jan 2026 23:48:52 +0100
Message-ID: <20260112224857.42068-58-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since commit range 809b460f305..cd08bcaa36b we remove all
uses of the target_ulong type in target/rx/. Use the meson
target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-4-philmd@linaro.org>
---
 target/tricore/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/meson.build b/target/tricore/meson.build
index 45f49f01288..f40daee61ed 100644
--- a/target/tricore/meson.build
+++ b/target/tricore/meson.build
@@ -12,4 +12,4 @@ tricore_ss.add(zlib)
 tricore_system_ss = ss.source_set()
 
 target_arch += {'tricore': tricore_ss}
-target_system_arch += {'tricore': tricore_system_ss}
+target_common_system_arch += {'tricore': tricore_system_ss}
-- 
2.52.0


