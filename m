Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ED1C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWEw-0001TD-2B; Wed, 13 Mar 2024 17:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEu-0001RT-Cq
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEr-0007pA-Uv
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33e8e9a4edaso271771f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365656; x=1710970456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkVZlzl/unZoGeVbI26i1HdVvdJ7WXs7uWwXIhdDAMs=;
 b=gB7ip64r1fdNpnHsSjG5CdD8P922Cnz0a82bUpmC+KxhBJP8JGhIvQtuqzBSXDTgZj
 GEkR4/fbsmJLj6YsXtpKXTIltVT0lGGIajLQY978/pGNNcXcQVIxiW9gxo9fdzqYjzro
 QsHe92zj248IurTwK4MWF0DQBJx8h04tzDxvi9cx0/W1n20R0aUz9OKrRvXY77y1zytf
 fcMKe5KQoTqUKC6kgS0ZUstW7sU+NjgYmOACkrRpn8m5e9ZBO6EaHQMkxsXs7/Vt3UMg
 fJOsilg3d3bhiZvnSbqcbgq3VkXjLpWYx/p2zfBJiXU3cGmAvHFAe8jC6eVyLQGM3Zro
 kZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365656; x=1710970456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkVZlzl/unZoGeVbI26i1HdVvdJ7WXs7uWwXIhdDAMs=;
 b=t8buDaftgp0CEOeaeffM2KzstBhBMePeIn75lxS2n5PyBSkv9mKbdx6g2zZq85J7Xs
 8qpp8rLChuqVI9ylFNe/cZg5v/dkNwnPr8dWgZPHJDvinPjX2aUh7UolSo5DANObCNhR
 7o4FSb1qWIruTebwUqVRGkydhlkt6m9v56QiSLpMKr6PObdLREGh+SK2ciD0QnQm0WVw
 E9OBTIPYGnUNPxjkY/ystH+HR7tT1E7KbQlLG8/TeA2jVZeHpt2KLlt1NILTac0spEti
 S45KKnnYd59g8eXTXFZLT8AqZAry8MGBw+EZauTFs+T/G9qMdL9hhZcq9EYJIKcMNgPA
 dYkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc5Y1S7BA0wJXSdB33cFiHDNvYrDjYsZ6KhrMK5TV+v26/Yhr+hobdxMlbEpzjkjHjwTTnkEjd9VC1C9/izP45zO2+m6c=
X-Gm-Message-State: AOJu0YxqJxgbLJ1yrbtt+m92l36bN0OUNyocrpkJjV+OVoe12eUL2qg7
 h/EEtXvsCqHDiB07p2Os23D5Fez1ifhzLww0K8CJGjUbg+p2aK0wrh8uwXoR6zY=
X-Google-Smtp-Source: AGHT+IF5WsGDrQo+P8+wndsqpq5rlWIg5Ja2k0U+H9QTbYxLwXBZ95dP9G4hsSowSlDC1YwVTcVYWQ==
X-Received: by 2002:adf:f801:0:b0:33e:bb5c:f60a with SMTP id
 s1-20020adff801000000b0033ebb5cf60amr1934560wrp.66.1710365656644; 
 Wed, 13 Mar 2024 14:34:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a05600c46cb00b0041312d21a35sm3550340wmo.7.2024.03.13.14.34.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH-for-9.0? 05/12] target/ppc: Rename init_excp_4xx_softmmu() ->
 init_excp_4xx()
Date: Wed, 13 Mar 2024 22:33:32 +0100
Message-ID: <20240313213339.82071-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Unify with other init_excp_FOO() in the same file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7e65f08147..b208bd91a0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1642,7 +1642,7 @@ static void register_8xx_sprs(CPUPPCState *env)
 
 /*****************************************************************************/
 /* Exception vectors models                                                  */
-static void init_excp_4xx_softmmu(CPUPPCState *env)
+static void init_excp_4xx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000100;
@@ -2120,7 +2120,7 @@ static void init_proc_405(CPUPPCState *env)
     env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
-    init_excp_4xx_softmmu(env);
+    init_excp_4xx(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
     /* Allocate hardware IRQ controller */
-- 
2.41.0


