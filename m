Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9235EEA795C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnphQ-0002xf-1P; Wed, 04 Feb 2026 22:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphN-0002xO-Qf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:29 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphM-0001Au-C7
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:29 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8230c839409so421486b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260787; x=1770865587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7XhVPo+JomIcnP0HpkwnXCLlcF4o5rlGwj2oE/tS2kA=;
 b=r7Ei/J3gww1qp00W1ySIYLN4bijNGQQPYjxZnIuTUXB1YNzeoDbRzVb51tol7Ch3Mu
 ZL58YlxTJvBa8vopUBtWWUp45rx4cmRHBrR44BnKYZffoQhZ8O2Cy/dYBOLYAItfv8+N
 AcVkXFXHDWiSfbrnibCpEIkOmaMJ0lB7xV8duw0d86AeidNiMAqQfwapP8dmhKltL7kJ
 bMcbzh84hrbbXt8nJtEEzqOr3lt8OROn7eybr+4vXrrLZqi5epqOmojZfoVBNqc56gyo
 7tPJf045s3HK9MRTWPMVzx0S9LXKP551fVbwEFCjmMk02eF5EU5wkAAQzH86wROVU14S
 MxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260787; x=1770865587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7XhVPo+JomIcnP0HpkwnXCLlcF4o5rlGwj2oE/tS2kA=;
 b=kGEzRp0S76mogqDi+TpUKZSFXSbrOdBhMpY5QErnvpJDFT1F0VLtEXzjA8iMiw/c+w
 fFgV8MYwwe3vLOiyn+12T/9s4K0XJQ570QWC/RtgaTWiSBUNmkxegPwBd3Jfr0Mj3lc8
 H1Pk6nIl2ftt4Ah5pLhuUGe3PyVm28P72zwRUolcEW8WMd73G0h7YzlMozKUkggaduIC
 zFpLs1fhxUKKCsgTDXTfZtFfUJXdpbyL97dcZGToVXEFtIq2T2mKVWPlev14DoCty9/d
 abcyB3lX++aIEg5pW7zng8roie032+wCDFIWKQAz5afEiCZKyHq6ppR2kKPhlkqnQ+SG
 WFEA==
X-Gm-Message-State: AOJu0YyJJNDAanmnu9VOQXnmgaH3/uby93XjzKdu8L+3w30TuLf2bxJw
 UnHqKs8ZFvTySRxNUzp41HVVwsz0XJQx9EaY7WuzYtx3yNS1/N/vKPDEpYzG56N9jhT70duCSfn
 gWvwNG/lTvg==
X-Gm-Gg: AZuq6aLNSpqC+0B8JuyCIMC2RLSPD7o+I7mRD/IyHYQhrJLLyKzQ/OsOg9tU2CS/A1s
 nAjRhsm+z1gDjPLHekQ6CRXXTnwDGK6NQyrOdFLEa1M6IToqscoHEwrItMKzfXPwrQ0RDftOB/f
 fKbvhDUzMo05mpt6lxsQSA/OqVV5uMbFPiczoBivro4uQoXoZ2ExiDg/7Am6j/mciRPmhxheV7R
 6OId2cIZJBEeQViTTD1OPAuh7wpAmF0ZgTOp7YRUw6I960urMQbSAeE8xYlA5oZbYjewDWt0FiZ
 tm/3ymvXBDZStLZS7/wLW9xERg3pPXErey8yUnh3w1PO0pvT6/63KigAEG8bm9gIOc337Xv+NA6
 F8FC9YmVulUb+zJlCY5KfZF561UJbY5zoOFNjsoPdAQFLDinULmHjkAqsNsSEIt9E7MzhbVp+ge
 lJEI15x0vfFD6StJp1S6FF7PqJbloayZLo2G0dtYkxdW0eLTm24ihwPV8RrpYpHA==
X-Received: by 2002:a05:6a00:10cf:b0:81f:4f47:c6d6 with SMTP id
 d2e1a72fcca58-8241c694172mr4367678b3a.65.1770260786874; 
 Wed, 04 Feb 2026 19:06:26 -0800 (PST)
Received: from stoup.. (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d1694c8sm4003544b3a.8.2026.02.04.19.06.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:06:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] meson: Add TARGET_ARCH to config_target_data
Date: Thu,  5 Feb 2026 13:06:16 +1000
Message-ID: <20260205030617.266625-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030617.266625-1-richard.henderson@linaro.org>
References: <20260205030617.266625-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8c6c0a9a32..2d114e9018 100644
--- a/meson.build
+++ b/meson.build
@@ -3263,7 +3263,7 @@ host_kconfig = \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
-ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
+ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
@@ -3353,6 +3353,8 @@ foreach target : target_dirs
       # do nothing
     elif ignored.contains(k)
       # do nothing
+    elif k == 'TARGET_ARCH'
+      config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
-- 
2.43.0


