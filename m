Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FC7CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7e-0001qZ-9m; Tue, 23 Jun 2026 06:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7d-0001ox-3s
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7a-00075B-UU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so56695225e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209565; x=1782814365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lm/EkmTZzZUIm1flwT8VMm5WScziV8Mn0QozyBxRF9o=;
 b=WNdx83PlxOmkI1ykoIJaqik09Oyh5V6Fli0DSofdEGx4pszYXVogEa5CobChBKt+ZH
 /PPLnsdFhYTSW4shRMutRSIkS2OO3rT5v9uiR81f/r2ALkaFeaP0sq7pW5Ql7Gihx4jr
 NgqrxdDeccbw6974Hl1ggJWXD4WngYWvwVcbfvB3HFeg8HvNDfKHeMNV9H3aYaTREekH
 cL+qRvqU5hR5aGOnoDz3Xjtf17taANi6reuJ3YSCH7XUuE79qey69NRPsBtb6iBESpwU
 Nap7JalfVNy0VGznMw8z1K2pzh8WkPCmjet8T0GGswR7EDYg8NMuZe3UNwShnYBEai8A
 E1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209565; x=1782814365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lm/EkmTZzZUIm1flwT8VMm5WScziV8Mn0QozyBxRF9o=;
 b=Gt7OgxIR1Tw1ejep+t1Ub/Ab6Ux61WE5iwG2exQcFAMFZlLDK0Q8eeRMNz17PmMGGx
 bvaFXqWNG0ll5gY82sFrspqENSnfFmnDel1lNk0gfJLs9jHklCr49S5QyNH8EELkXMRQ
 y/9T82YU2aWBgvSxtLRlqgDtFXWBhCnQj4ihhoohvyP99E0W0gBwhT3lSYZHCkrjOqpV
 hBa9TyVzwljo4kIFRE4KRJfN2/Xncv5NmW24wb5XyjkOartMFks0eXoY65tIAJbkhdIF
 pP4u4o2keBnE2FTv6HuQkWzJZOOwmT1HVU9HNee2OrDjp9VZ9dgMlvnObGRRo7weBmjS
 6MzA==
X-Gm-Message-State: AOJu0Yx73IwGTOu9icLiiooQDUfCaGwq8BF1xfQDTnD+dZwnAN/fs3IZ
 fQvR7R+O3D+ucoAWCSRacCHZzbQJA6l0P2X5r/asLslf2GiJDdHIuDGIhq2fq6jnV2/ZGkkct2y
 gj8P6xe4=
X-Gm-Gg: AfdE7clnj3gSR8qNvw2tnGNI+Pd9/RrTSB4TWfX9+LFAKOzanpObRJaC0yooWNW/pJX
 GYMfv9BOzMA+nwmRjcDanv5CFQ3eip4DbSNbvhThtZshPX+dWtwnWyGQ0EvszYj51q19GalyPjf
 gLmrN5WjSOz0i1CyjzFZpjBjZN/67iy0XVko+wG/1J5hgDF3SabyhphUuKTBiGA/O4wM9kqQkic
 95/D8kiAAGKs46YzqG8odVCdnYi36VLrgAIWwdeNL4kn94rsx+o7SxgfULz/9ia1Jon2/aFkVx4
 D1f6fvKumx6oVNCvhofjJTM2u2SveUsgpzzn2yzyhaxmrYOMEZfmgw+LKbNX78qYf6BHdr1ywNE
 4UhAJ55wlylXgoskH4Pb21tZaQQO0XWQI6U1r8YUE5SvGW1fl031HhNt88329qnWZGIJxo80Xg7
 LSFDWBxcn5QlSk
X-Received: by 2002:a05:600c:818d:b0:492:2f2e:e7e7 with SMTP id
 5b1f17b1804b1-4925b37ec5bmr25529285e9.17.1782209565198; 
 Tue, 23 Jun 2026 03:12:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd30078sm363917445e9.7.2026.06.23.03.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 143885FD5B;
 Tue, 23 Jun 2026 11:12:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 7/7] gitlab: update bug template for sec issues & tool
 assistance
Date: Tue, 23 Jun 2026 11:12:38 +0100
Message-ID: <20260623101238.3806547-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Warn that a security issue must have the "confidential" flag
set and that any findings from automated tools must be validated
before submission.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260619123632.1276476-1-berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260619155657.944220-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
index e20f586008d..faeeb002252 100644
--- a/.gitlab/issue_templates/bug.md
+++ b/.gitlab/issue_templates/bug.md
@@ -13,8 +13,9 @@ older than this should be reported to the distribution instead.
 See https://www.qemu.org/contribute/report-a-bug/ for additional
 guidance.
 
-If this is a security issue, please consult
-https://www.qemu.org/contribute/security-process/
+If this is a security issue, ensure this ticket is marked 'confidential'
+before submission. See https://www.qemu.org/contribute/security-process/
+for additional guidance
 -->
 
 ## Host environment
@@ -49,6 +50,12 @@ https://www.qemu.org/contribute/security-process/
 2.
 3.
 
+<!--
+Note: if this issue was discovered with the assistance of automated
+tooling LLM, static analysis, fuzzers), the reporter must disclose
+that in the description. The steps to reproduce, and any other findings,
+must be fully validated by the user of the tool prior to submission.
+-->
 
 ## Additional information
 
-- 
2.47.3


