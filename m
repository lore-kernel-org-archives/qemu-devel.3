Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B87C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwok-0001cj-9E; Sun, 27 Jul 2025 04:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoc-0001SR-CQ
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:08 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoa-0000Bv-Df
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae9c2754a00so681632566b.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605183; x=1754209983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OlA+ob74f5T4fFIB6Rp3n1iUC1Mv/XkkIeKTnYYocg=;
 b=q/34DsYM4FBc/KY00YKyvtriGva7e2YXj2j0vww2Arzv7jKUY+VSm9C+2y1PeVZq9a
 jeAW799MVASCMCdGoaCs2/SETj878nNkQ37TAc029Qc5hg1904utY0tvptO2gQargHTm
 rqFI5c3nJkeOfbFkhqMJP2+Lun52t5zMOsaXrxVLYswFpN11m8KzGcXlDyr+F57gmvRQ
 rSLICVX35uqeAGIzn8EVTOlRSfsTZrENf03rh9bKafa8D3rJH3uYYqDsBwPGW9m0rqJR
 u9yU/40XKFEolCFkO35WNtZa8In+I7lBUHv/UrjPhEL5/hz5QAYRwOWimBisdC2n2djd
 hBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605183; x=1754209983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OlA+ob74f5T4fFIB6Rp3n1iUC1Mv/XkkIeKTnYYocg=;
 b=pv91OONGYyo2GwPiktqOafa7J8OYqpnTGAJ9maon3CWbrV6aNGj/0eDaYJtuq6YKF+
 r0EDc96SajPe8yZtaoZ1nt10zR7APk5GWW4Ei3yYFtoq+3R/MeCQGBq5//jkCJCundpu
 m+kpP7HrQAShxomo/Rd2dS0t3Tb174WAN0kLuNQXcKYhy/eLaRNhmeXfecIDWRoofYnv
 GZqd5zX53iqfPBAk3tNPJ0P/qvyNuZ3h7tGuzK/kK6oLD6PJ4VJDh1b2QQl/PRMFPkxN
 51H684yUWoa7RqduTZyVXNVm+sC5nh2eJ+CI6ii53VNNyn0rq3JfdWrPlCU7cJ7yFaZ1
 OaQw==
X-Gm-Message-State: AOJu0YwZyIZzOPTHXaw3rL61D1J724jm0mC37SWS3BYMDTQ6dc+LEzdr
 4ycHJhuDA2yXALYAINYQLhuQN6OfwvrSrO+bgQSw3kQKPU0oWyN+//OLPNLCbMKRTSTEKxHluMi
 z8w0S
X-Gm-Gg: ASbGncviJtIIvb2hyhv3mzNeu/6116WBpgkA0Pz/3Z/HPAk0duDayCwo4Uv2FDeWT1E
 Gmtv95V/c2M5yeO746+FJIaWrYfnQLnWbZwElls41IPXlD8ghUL1IHvh3v8WKeHdIdo/ogyub0G
 hXWH5XNx9cw6v2D5zS21pDWqk69yOLG0qB/a3/jwn7FCAj2GX0j+EL5RPrCUWzWbqXFXx5J7RmG
 ciGnNsspjefrvIjW1OLbA70KBuVLPgYj6QDGH3xn9PuDGc0jmUBrx3KaehvK+62NzHoTUdGFEzO
 0+Odu+RqbasyATEAuvThDYw96FdGBjTnG6JZPbyqbPhUBNKEeAEZrCZFcpH8+NNxVwzozlbh1DV
 J0ehV7r0TDLHJ+qUoFw/S/bc=
X-Google-Smtp-Source: AGHT+IGOaCe4525XSZuTRKtS5UCWfxefw3vcJ56x7IIcJZPvUzf1uBax1vxGLqgwqxufmjMrZbiftw==
X-Received: by 2002:a17:907:7242:b0:ae0:e18b:e92f with SMTP id
 a640c23a62f3a-af617704758mr842378066b.23.1753605182825; 
 Sun, 27 Jul 2025 01:33:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635aa3ff1sm256753066b.101.2025.07.27.01.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83BB85F8BD;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/14] docs/user: expand section on threading
Date: Sun, 27 Jul 2025 09:32:44 +0100
Message-ID: <20250727083254.3826585-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Potentially too many weasel words when describing atomic and memory
order issues.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-6-alex.bennee@linaro.org>

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 05de904225c..347bdfabf8c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -46,9 +46,15 @@ Threading
 
 On Linux, QEMU can emulate the ``clone`` syscall and create a real
 host thread (with a separate virtual CPU) for each emulated thread.
-Note that not all targets currently emulate atomic operations
-correctly. x86 and Arm use a global lock in order to preserve their
-semantics.
+However as QEMU relies on the system libc to call ``clone`` on its
+behalf we limit the flags accepted to those it uses. Specifically this
+means flags affecting namespaces (e.g. container runtimes) are not
+supported. QEMU user-mode processes can still be run inside containers
+though.
+
+While QEMU does its best to emulate atomic operations properly
+differences between the host and guest memory models can cause issues
+for software that makes assumptions about the memory model.
 
 QEMU was conceived so that ultimately it can emulate itself. Although it
 is not very useful, it is an important test to show the power of the
-- 
2.47.2


