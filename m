Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEDECD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9I-00080c-15; Tue, 05 May 2026 13:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ96-0007xA-F0
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ92-0003Tv-Fb
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so53184495e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000473; x=1778605273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgN89KaSyxSAefXPH8ZQnVFNA6F32d/CG9VXqM5uJNg=;
 b=HGQg9S2A4/0A1u3qkRbeRJgWkeKkHr7ag74WcvpzYspp2sr4ohTLjNdA+xg/Djp9k/
 9zStc/aYFC0Ewip0I4FVRVTGgbGBP5G8qsuHtTYkPDlJBTujh2221d1Rx7dtFcPmUtPG
 QfeFZkeBCWRAEQ5EBNYV+Vltk9KI0ZdAUoE334GE4BxTpe400Jjg0lMkDIKajoGlvBcJ
 9yKquIE2Qn5Udv4f3JpstmLg1FiUB9c7rp/cOEgqQAQ9aywBrQWZbDTh5Y6Dgs7STJbI
 iev69z08aOMBPLc3QpCJ7cUC6wtznTFm2cDWPdnU8rKO1FD3XDgIFKHYiKj6L9NzHoEL
 xsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000473; x=1778605273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zgN89KaSyxSAefXPH8ZQnVFNA6F32d/CG9VXqM5uJNg=;
 b=qyXRbOqf1wt32C5y1zke2aFqqR/kBFFl4PorBh3UJqKZUpw9xzBskq9r7uvAbalQ8q
 UftRhqhcmxC1UagJZ7vvRnIAvl4eDrXZ4HbU5kLTEA/P+9ep/Zj2wTIDZEGbtkkbDdBd
 aWQsOVDUn/egLpLhDvYAgSYM6TbpvWZVDBwwIAZkIyp3ab1g+rfimMWTAzYxCmH75Irb
 xOkOHMxeNPBrfGvKe0LU69iO43ld9M2GrxqMHHAkTPdVYWINgm1adTo0dQPOXmVVHxPR
 /sbZ68sB9823i9hMAIPbGuqD3RIgoxHXkL/vyL6BYVpvds8+gXnWlc3xTFytdUBixikx
 ISvQ==
X-Gm-Message-State: AOJu0Yy+KuINgkp57ES/zJHbrEbdrzg19n5MQ8bnV1huQy2cxFrw2ioT
 lLNLsOkoYNHLYE7xlrBd6MlSJjI3GhDkXNe8caOoOSf74Vjj0LDEMtb+eVso21d10Iw=
X-Gm-Gg: AeBDieutPAH0R2Rq1oOJuTvCYL7uHVTLOiTgkyvfz1eBq6lCC/HhS8FCnESjoIspL/y
 SsRR6JIsz/IYlb+RMxRHq4MX3lZUheYYyRut24VvNfRaBCtSeS3zaIvQwRU19ZQufa23fmb+PLw
 Lm7xijs/lq2XhGT2sZwmBlXmVm9UIVbn+S3Cnsx5yQ6/jgLtmgRkfSxFi9znsuobD1Av71tEKTT
 /ZqH1mVqepvZY/VCth5WU2BssYKfu6kh8ibOLamYtURmB8Zs2nslB1FtgsdHdNB6HdKQIbMBaWq
 AB8Puo9sIE7oBqkgMShRng/XQ1epl8fos6vqVM1Ee44AB31sLFcHqOuyysosCEO2tQ0+sue2fDT
 k0nv8l5zocrIfmF8gALHO6/v939XnxvaMeob+QT/faJgfyj0T/qIEb/VU3TZXz6fMygoxRHxdEk
 b2CJCS2FVaUtn6/FB4gDQCeXGiU8yXLVBjMsGFnVZ8sCAk
X-Received: by 2002:a05:600c:2d43:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48e51e166a3mr1027025e9.7.1778000473294; 
 Tue, 05 May 2026 10:01:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb69800sm356218795e9.2.2026.05.05.10.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D36806095D;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 09/10] .agents/skills: add checkpatch agent skill
Date: Tue,  5 May 2026 18:01:04 +0100
Message-ID: <20260505170105.228162-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

This is a very simple skill that tells the agent how to run
checkpatch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/checkpatch/SKILL.md | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 .agents/skills/checkpatch/SKILL.md

diff --git a/.agents/skills/checkpatch/SKILL.md b/.agents/skills/checkpatch/SKILL.md
new file mode 100644
index 00000000000..1f0f84fe6b7
--- /dev/null
+++ b/.agents/skills/checkpatch/SKILL.md
@@ -0,0 +1,10 @@
+---
+name: checkpatch
+description: run checkpatch on a file or patch to validate style issues
+license: GPL-2.0-or-later
+---
+
+# Instructions
+Run `./scripts/checkpatch.pl [FILE]` to check a file for style issues.
+
+You can also use a GIT-REV-LIST to check against git, e.g. run `./scripts/checkpatch.pl HEAD^..` to run checkpatch on the last commit.
-- 
2.47.3


