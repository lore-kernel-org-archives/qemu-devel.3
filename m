Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE53D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SX-0005Ny-7o; Sun, 11 Jan 2026 16:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SR-0005Ls-GF
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:49 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SN-0003sP-Nk
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:45 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so47662075ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168722; x=1768773522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHti3C71LUbVm5pSNWQt/BFwUr/ys/K/zILSxw8aQnk=;
 b=AjfXhlkC9+8j0WWgo8KrFTPiidxb5xi9EB5CWUUtLizzztkC/X4cY6IPyU4ljoZ41A
 sFryu9hUDoV1uKPw6RbWT8DpNqqGL7hHvom2zDKXcL9/nGDcInffIRFbifB7ocoCuqd0
 hwY0VZGGpduOBuxBq/AZhAmj1tDbMcTTSwtsWEdEZdrb8otOg12KnRFJf22g7cBLtdZY
 N3rsGWP5fk9QE0jaLSpnDeXfT25jE8ZGTXqBjAn5Q/uNPV9IZ4/THwpm6IFamPUZLtdo
 VlQmghZaTQe2qUAzsoTzVzpaEwYNJLGLL1jllKvcCpdWJB8osC3PIJb/w2b7Inq5NfDN
 SilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168722; x=1768773522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OHti3C71LUbVm5pSNWQt/BFwUr/ys/K/zILSxw8aQnk=;
 b=l/JD8RokbJT9cEoxY7amgK9LU/N0Z81iGkCJZAvC5TgoGivF3H7S42kMdudwIWDa9t
 S3ty47flt0ofT6VRbFK0Jq5D7Dja9uM7f4SYiO+N2f5IzjAldk714dz/OjLcWHzkeiA7
 PqUTmLg2adFXjbmmLCHRVabfxN7VJpLDxC4U6FB5zINSX7R1ZVAmwik4fqlrFBcTjqgj
 q9xYQOE7uaqoWa37HRg9f22C6E4knTFMLpMwlKRkr6B/DxereAT6I0SAQ539xbs4wxfo
 oiNmj7jle4UP3p3LaZW0mmLyhcVvyKE4eaNEuNPViTHF8GYpaWA7gxeSu0Gj8eqBZBVD
 VJUA==
X-Gm-Message-State: AOJu0YzW3CIuXeaQWUL2vUfIpkBVaiJVe0WHpe3PtGFnDDQTDTsxIlfB
 Xvr71tbNk43WKAiw3P+iEyNrvAtUJ5oA6WsPd1f9guWBYXkgao7Z0zHFMsXCD0BdlvuG2tjWRhs
 3oBejnJk=
X-Gm-Gg: AY/fxX4Jg66HK1xUDsZgrfkwULbl2uMigV0cyo/Zfe2fMWQKfEJc9evHfMs70HeSJkA
 bKja1W7ZRexCZzXIX7vzwQYOuDfm7rN7VWyLaYHkS781qYaaZkt2TJ/jTdvhos+UZ6vKCWEmR0e
 GNc/ljFGeUSmu4vdB2h0Jpw4ST8fmYOWnfF7X/gOe0aLteP14GOdR6cftbM7e1C+DTQjdYNJnro
 OrmifztQWkOiLDrgg/BaQqPf6E4GhBupKaShXyFzGhqAZCvSVj/Vnu1eW9b/n/T4v+8/rwGOygo
 4oTnsVYM4DATvr977K8CRfNnGrqf6gS/eQulNQPyB0d19YJHCvL6qTs3fUu28NTst6SFHoaix5z
 9/u+7bPRfSmLV/UlzsZK8XO1wAbj5drCjnuueB8yvbyTZZY3D5DxrE0v22okPQnlqru5JtdPmYL
 w125uNLNtxpj6z7aA=
X-Google-Smtp-Source: AGHT+IFSUvgI7sLZEb/tSS4Wn1T4u3iZRHjJOYvGgkXyUIHd1IXLydx2vidLq9ev3NHxHJcZ6h0W2w==
X-Received: by 2002:a17:902:d491:b0:2a0:b02b:210b with SMTP id
 d9443c01a7336-2a3ee4fe86bmr154410095ad.41.1768168722214; 
 Sun, 11 Jan 2026 13:58:42 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/13] linux-user/elfload.c: Correction to HWCAP2 accessor
Date: Mon, 12 Jan 2026 08:58:11 +1100
Message-ID: <20260111215819.569209-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

get_elf_hwcap was used when get_elf_hwcap2 should have been.

Cc: qemu-stable@nongnu.org
Fixes: fcac98d0ba8b ("linux-user: Remove ELF_HWCAP2")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3259
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260106-fix-hwcap2-sve2-v1-1-1d70dff63370@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0002d5be2f..35471c0c9a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -708,7 +708,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
     if (HAVE_ELF_HWCAP2) {
-        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap(thread_cpu));
+        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap2(thread_cpu));
     }
     if (u_base_platform) {
         NEW_AUX_ENT(AT_BASE_PLATFORM, u_base_platform);
-- 
2.43.0


