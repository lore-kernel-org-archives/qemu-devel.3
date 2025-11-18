Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4618CCEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQyU-0002V6-IB; Tue, 18 Nov 2025 14:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyL-0002LY-7h
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:37 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyJ-00067z-Bs
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:36 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so64145935e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492553; x=1764097353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NSqRQ4ojfQt+N4Y7QwQa/NNLGa5GocKkvTSMNpgIAEg=;
 b=tcYI2NqCv9S3CXy2z9Kr0WswMSw2RzlRDho4z7uosYqcefyu6VS8S/X+WfwUySoHOh
 6bYVIdbfoij4Cgl7seuSphos3J6WH7h/ZRuMkjcaiplsISqXsrPD4mHoTwZvcZByWAdQ
 88UjJZLyAEYUT8HI87HUqqS79VB/Arv/jsiWs/LUCdhY6WslxiieL6mG815wfM/LyjhH
 7uVAMaH9BlhDTdiExzTAU7Boz/RVdRyZmX3alkl8gbyCbUNQydpWxckgukLKVjKjCQTP
 pX4Qn522JyMxrcJk5Hyww7ZGMoopC9PyTrE9SknU+j9fP4E4BEQZQ2Ox0RmuZY9QRkXB
 GkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492553; x=1764097353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NSqRQ4ojfQt+N4Y7QwQa/NNLGa5GocKkvTSMNpgIAEg=;
 b=Te0kFXp5eafJFydOZIGwNUCJHg2ez3spzPahBp4ZLUzhymuoNS6W0YpteM8jLljgkL
 qD9PVyNW+bg/xLE+wL9ziFAIjmHf9JrJCgwCQSzguTWc8BlfaS0mDUrcSnIKkUmOF/Qi
 rVwQRSBREbhw+Ym7Rmb8B+DnDm8ma1fTU5Y6dTNEJ/sPIvcrwevegE1BDqekkG0O9jhU
 2yHMzBq3RwWbbBSD+8qv2ViZvdCr3TXLpRMGRs8QXZQAeQVQhqaTiliUJQ9LpAG327O9
 MgMrObViAP+XXgWlxqctSBPRE+++4qFCiAqLM9ASLDH24lm5bKSCWCa6W61XeQ7OELs2
 Cfqw==
X-Gm-Message-State: AOJu0YyhQ4UbKcJO66pNBDti70i7uke86g25vRf3rcEXyxijuLrPkZ6b
 LwKRstz+lyOKYtujGks+xGBcKFcZEsfPETNM8fEJqO28wYOh9cs5PJelRU2bZ000obHFeU4D5U4
 UfU6Uc5QRbg==
X-Gm-Gg: ASbGncspiDPITkOKRKMu/PbGjBg5sDU7gHRfxmIQc9EZGCaZ+l3Vb/deVzN4sL/xqte
 D8HJfwmFSFqqTv9j30pqkuUHQpSFCmMvUhqAONhOgcbnMPEWryH/4S0s0ILpvluTVW83jydELut
 dFsU63oZKM/zZNqTj3lHPOrCUOCAKKMpLfh4SPeMm7vd7aK5o2erDa8C4SemA7uw4H44Gf5p81q
 FYqNXvOCim5sXigb/TkhE8A4WW8VkWnqx3rZSmJ04fBL9iMWTYgXaTNfo085U1tRMDmp2eBzLiE
 pc4Wd2m1xYQd49Ni3WWOlwISkutZU92rnFFCp1JjTupZadwYX4nnuIqvm5zixv0S7bE/lvAnT7M
 L1Ymgo49YdSrN2SWH1r1wcpafKzQlZzvvqH52R+PDCLMSvd6dbeb+OLUM82+0jG9zd3SwhC54ZZ
 UHi4406HC8fmt6JBALJbLF1f11b5eJ/LMh2IeWd3fVSQHxbl1EDaDHGSAeKh/I
X-Google-Smtp-Source: AGHT+IGWe7Ks7mMbrLQ4HbZGe+IrW2Tk2me8upDgDQnkO9I7cxQxhrLjALUbgHRlg/QEBLn5JI8fag==
X-Received: by 2002:a05:600c:3b13:b0:477:7b72:bf9a with SMTP id
 5b1f17b1804b1-4778fea6797mr164520805e9.28.1763492553400; 
 Tue, 18 Nov 2025 11:02:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0faed71sm6469205e9.0.2025.11.18.11.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] docs: Correct release of MIPS deprecations / removals
Date: Tue, 18 Nov 2025 20:00:48 +0100
Message-ID: <20251118190053.39015-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

We are going to release 10.2, not 11.0 :)

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251117171236.80472-2-philmd@linaro.org>
---
 docs/about/deprecated.rst       | 2 +-
 docs/about/removed-features.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03e29915f0a..30ab72b2a4c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -192,7 +192,7 @@ The ``info capture`` command is deprecated and will be removed in a future relea
 Host Architectures
 ------------------
 
-MIPS (since 11.0)
+MIPS (since 10.2)
 '''''''''''''''''
 
 MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 88ea0dc4edc..a72df26dd24 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -896,7 +896,7 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
-32-bit MIPS (since 11.0)
+32-bit MIPS (since 10.2)
 ''''''''''''''''''''''''
 
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
-- 
2.51.0


