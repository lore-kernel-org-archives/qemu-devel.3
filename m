Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D857D74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbs-0004DL-Bo; Fri, 23 Jan 2026 09:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbq-0004Bf-O8
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbp-0007lU-4r
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso23333965e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180279; x=1769785079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6NU5AE3VX/tDzo/APFGw1cTyeCNWfrsQQFwWWIR/64=;
 b=EalMJ8QnqOcy5xXAKyMbJyJkhXgMvUrWe5T5zfEOy/So8kZigLpQqpdK8bkYsxWI7J
 KJSU7wkMcsCpdcsAEnKrcfbnesy4e4HiL2HL4/D/Q0lNLNoliZkDEu4wFP4jrr6kKW7z
 J4FRJd9m442sV67Iqv1bZBbqffEOVpEiUU0KLbW2SnVOZAOF3Cfu96I+qU8bph3/cwFe
 l0DfPlyCuPVXSf2kHKfrhaDi2zSdCQjuMkPFuCUfO7Rxdh25yREaCQvCf0/JF6AXXqTZ
 czvUiBm7U+OXVq90kOkew5I6g/lLbmm4lgqV2H7UFCHAv3KTmnTEHfFTjlY74RbKXRx8
 aeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180279; x=1769785079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j6NU5AE3VX/tDzo/APFGw1cTyeCNWfrsQQFwWWIR/64=;
 b=AKZ/5IDo6eHS+n9LnJHl66wavgwpNemrpKShQ3IoRVY+Y500Ro99nhZAm7wo8jK9zb
 6UkhfFr6x7N9Qbh/aIPqhdiVLdGvJT6T6y2OyAOb/MjFaWbYoWaD7sVe6RrWs/IZFBQB
 BS3QwZvy0YNKimP+rV+LkeqItLJe0bgpkSjN3EH99EqGptacaacCZ6Efk43F5l5ZV7Gw
 yvuCYxRaiYz49EW3YRGxSNnm1klLYS220K7lCTtL7rvRc0cZK/mKgTzb+4DYlxnxMkZP
 GwDpfReTjG7tW9TS0Cz68YxQY0bRkypVJGJr2VJSn9NkkNSw7nPNfMvY9dwqIBQoVAJ8
 MIHw==
X-Gm-Message-State: AOJu0YxRtZVGJGeMfu9Ww0M/KqRWU6HsaLN6F6vvb9E5dwjAdwbXebNf
 gfPOgoZd2FJlE9bwB2J6e52MJHBo1FpxZQjctuuTt2Xc56prUAjHHNlCX002owQp/dA=
X-Gm-Gg: AZuq6aL6L4Gnv1wdrMqbHcVo7hNkO7x+PajD5IZjbryCS1oxwCw2+FC3qHK78FY1nxw
 DP1jhHOwqNICLKD0A0/VRfCXfN5+FINSG2WeAH/xULVoNe/G6PNqfii2/PcMFgWiI2NtlD4/a1t
 KuLpahk3FyUrCEfoQsD01ZXgltxohJ0HpVVqztOAx+PGSBwb0vRx3yTdXUSoi7+8VpV4og1MgWf
 KtjK1jlhhibDjXUZdLsUTqogfp1WJIHkHLy1IYhFRS6KZ7OCiJJ4VsLT03XhNbHNcTETYRe/JPQ
 EBKNnE705YmphVP3m+CISxSLW7N7DVL8aLc01ZZTleAK7PBBLwgWFKPTcUZSb6eAvqbokdgS37M
 ZuT49jRyw4SJgQobimAtlnsjh0msM6G++ijS/JGz8IQ91LPEZh6DfSoWGHrC0Fu2+/0z4GJZ4qt
 gbvysMVnnqN6jN
X-Received: by 2002:a5d:5887:0:b0:435:91ab:c6e4 with SMTP id
 ffacd0b85a97d-435b92f94camr3232812f8f.12.1769180279364; 
 Fri, 23 Jan 2026 06:57:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02cd8sm6949998f8f.8.2026.01.23.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED4A85F8ED;
 Fri, 23 Jan 2026 14:57:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 06/16] MAINTAINERS: update Arm to Supported status
Date: Fri, 23 Jan 2026 14:57:39 +0000
Message-ID: <20260123145750.1200879-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

We are involved in lots of areas of the QEMU code base but as I'm sure
most developers will realise we are actively funded to support the Arm
ecosystem for both emulation and virtualisation use-cases. Lets make
that clear in MAINTAINERS to keep parity with the other Supported
architectures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a691e3511c9..87ec6f3595b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -200,7 +200,7 @@ F: disas/alpha.c
 ARM TCG CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Supported
 F: target/arm/
 F: target/arm/tcg/
 F: tests/functional/aarch64/meson.build
@@ -462,7 +462,7 @@ F: scripts/kvm/kvm_flightrecorder
 ARM KVM CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Supported
 F: target/arm/kvm.c
 F: tests/functional/aarch64/test_kvm.py
 
@@ -1102,7 +1102,7 @@ F: docs/system/arm/versatile.rst
 Virt
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Supported
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
-- 
2.47.3


