Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162ADD625F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT6-0007H8-Me; Thu, 22 Jan 2026 03:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqT4-00070L-4F
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqT2-00063r-BM
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so5865325e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072102; x=1769676902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PLy9U9N+zNIDOmVZre5ciztW2ac844m+QGWQdo+/gF0=;
 b=CBsMI7H7IBRrdBFASDBJ1SeZsO8+ZvDyEBRMjKfPhWMPxPku6gPQUbHBH9xNjKl7sr
 aDh/C9ncUlmOOcgNjJ/MaAQ52sAo7Ddwa39QwRg5cn2XB0wcASEATmkBM6OuzwmtE5+M
 2yYGYy6PEFoFVqaym3Gdc63dw40Uq9YXYqxL4VrRwIQqyQTxnxqdjYhMmCpgOKgomjKg
 OLl76VPU9FGZAa0srp1s8h14wizU5F6CyG8kS2PbO4UqLM5TmNQyQzLmSeaUd4Si5fZ1
 ib4s5KSmp0jn1Ck+p7h6XPd+ReviWv67bprrzm64dx7yjnwHmkCpGFmMGwfQvMPWI3W5
 PVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072102; x=1769676902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PLy9U9N+zNIDOmVZre5ciztW2ac844m+QGWQdo+/gF0=;
 b=DyVyQ4hvQOABClNB8otrIEjVERBpXZjSMUOQmUfxJcbVdQgHIzv1Sh6bUwZAP2aBjy
 PXUADcF8d6JXLlsyKYToCBfiWXrlOK30o8flyItWIjzYmrvo8Ng5Usp5FzDid5J8HppX
 gp/N6rKiSkEraewQWCcvs/Z+BNASJR57BKujjjUlnh9dyVdOHOmVMJ7NincDyVCGkWq6
 uQ9Tq5n1CS+6hiHp+nMRF6Jc4bs+UVYAWp5H0zlANpNV+w/rZ4B621ZY31AVd9H3w0Sn
 RCt8zzJXUBDR0wGpy8s10GRin4svslZxzrfP4nxukAallVzalHC7pQjfPXEuh8F+MfO1
 IGqA==
X-Gm-Message-State: AOJu0YxX0w6W8a+p8zV08MsPRh6HXzKsYFDBYB14Jx+wZbPUvguqjxmz
 1Gu1ytzZPXHPhjIRhBBMNXd4/M+0zC4iiGEnUAHzwzbzbE1rxAyloOJ6Nb6FPWbnJwsWA8r6/Xo
 giWwBmmk=
X-Gm-Gg: AZuq6aKEYs2GHqGY81at+GsBEGnIIrTfUR9ILMIMJGsyl+w+dKtOxQhuOapnIa899yE
 ekdjX3qeGZva4neJOWeIYCtwz/leYcNkGtX4cvqi1HST5kTpjwJ1NyrUoq4cV50LAUjhz27sxOu
 cPqCquktDv8ytdkIe+os7PsYZlMPqFaW7w0WfY/RqGz+iIxPTVelmUYlXuakD48Bcnrmurzee3k
 IsylYidQvZOYAZ1X6b4lVIIQyjT6BZGcRSzid/1SFlkLoZdjV0sinqP2q1uOdgn2FXBRBlRy5Da
 Cxdt2o2JE87RRkQ1lYbez4jXsb7cqqcqsS7wZxc7nYkEACRbgtQFM6FS+5zu5lrj03UuREwvyne
 jcnZhNHBAWIOYVEl8nfe1PftP/pbA8SKhvAQ6GJdS/pzXb9APi+aCUhf8yzK53NTCCSjkiiiStB
 qw+QEDNy3j28zqHK9dHO2+QVVi7LGuKrapLaUVfC695Bero1hvOB2TndwDySDj
X-Received: by 2002:a05:600c:3555:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-4801e2f8e63mr306721295e9.8.1769072102388; 
 Thu, 22 Jan 2026 00:55:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm76433875e9.2.2026.01.22.00.55.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/31] configs/targets: Forbid Hexagon to use legacy native
 endianness API
Date: Thu, 22 Jan 2026 09:52:42 +0100
Message-ID: <20260122085255.95035-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The qemu-hexagon binary is buildable without a single use
of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to
forbid further uses of the legacy API.

Preliminary commits allowing this final change:

 . dffb3938aa4 target/hexagon: Use little-endian variant of cpu_ld/st_data*()
 . 989b25c73b7 target/hexagon: Inline translator_ldl()
 . beb38fda0f0 target/hexagon: Replace MO_TE -> MO_LE
 . fdcb7483ae0 target/hexagon: Explode MO_TExx -> MO_TE | MO_xx

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251224160708.89085-4-philmd@linaro.org>
---
 configs/targets/hexagon-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index aec1a04d1b4..6763e2111d5 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


