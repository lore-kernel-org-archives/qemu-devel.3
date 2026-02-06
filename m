Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D15DEE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh6-0001pe-0z; Fri, 06 Feb 2026 16:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfZ-0007Vo-VQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:18 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfY-0002l0-5R
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:17 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43590777e22so757485f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414430; x=1771019230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fTbdseFac75qijP8tqpFqMIQVx8MzamHm81dt2uo58=;
 b=zGHVeVdp0UYvqWzrv5wQ52zwczPP9VX02sDTaXAEr8lqpu0ZabwCVSJ7xmCqKWN/Q3
 LtIdDcNt7YakK8AkJ9VsYeHf3P64ch4I7E6eSBn9av+yx+LlOVQ/+gbpAPHnHcJ/WgZ3
 TaeGUCFY8FqsnPz6txEm5s6O68/RL/MM9U0iw0twbsoEyJU2niIrF3BpLzUEpTl1f+c6
 VqJ9C7UIO903kdy1MG9srdXrD1xzLkhTAd7SMyzZ9B+B3eM/c+7swjUH0SaBw2RQL4Yg
 mWp17GF9YEiXvKBFtJJlBPQ4Gplp/s0eqiHxCYMNd6iw1/42o1aEqEj7K+0kV3DLPTye
 lOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414430; x=1771019230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4fTbdseFac75qijP8tqpFqMIQVx8MzamHm81dt2uo58=;
 b=anqlgyNTUB+9zYHK+mKpT5uVmusXBd9DpBuysS1UC8BkpAYMGBSyZ3rcN/lBK09F40
 /FuCWHMZBy1Chlg5zGhzZeheF4x3GIGCHJ7blG77BD+hlKyYR2htjaDhM9iKEM2/KsZx
 gfdGRBpyxaDDUGN+WuzYm7IB9klYaOiU8gj+qd95sOPrrbcyrV/SlE9Mg6oEsWzmIUow
 GnFq1S7YKwkR3+bNczkNFUwcB4o1+f6u0Q+cgLDWZo4L2b2QNmZRieJayiNOxFIgh6I+
 6ARm2Q81HbAw9f8Wsnd+759vjoBGYZrwbbPQUZC4XzRRjwkM/QdHvGrHwKaSEgUxji1t
 B+jg==
X-Gm-Message-State: AOJu0YwgbJ7hV9Td6/g3dCHoDAq/4VeqDTmZSPKwbhwh3QJJ9U8CEWqz
 FRf8f2OQbv9at1nt9HqG3ly16P9FkK9VpeADepbgtmZ6a7tu5GrzCjHlGq8ygt4Rita9JY6TWwY
 nEzX5fDI=
X-Gm-Gg: AZuq6aJq8J0trE1cJUDLdCb6Qn+Jg1RwiZkP/Ju5rqzg8E7L1Wd8/J5pNOP/7IdODbT
 1hVtKFEz1HoPhQgzIebyIj54Hies9nFyg+xQhKCxjA8/phaMejw1e4tz9gshwIjLyYXsjNncuvQ
 Ckt9r4uwebzeKtc4RqttYEjFckiZjo9VxdgdLDl55o4cqpAPX9GloMCHtEp+9ZAoy4bXq34u9Ya
 kHVw/ntHOtl1gXOBjqkmk7SM5xXz2tpiwvMsqE7w6y0MFCxDOw7alSNTg/2lg5Sv3D0pJX2Lbes
 WGLrIWy3sN2pYq/FKklF+Vk/ZICoCaJfIVsK/cY9H9b6xnSNV8iWyepVvcC0Nz+4RWVmjX0hG0X
 y9EMNlluhbSRfnSYcdoK7fhrbt32S1xB4E4rELU3I7dCbcSOv+p3C9qRmuDaCuzWO/oagkkjiIq
 X/OxOBVHAbmsS4jr8Fq6X6F6+lOfaqp8U6eYBUVMhbBAgP+rDlujWcnPB8A3/U
X-Received: by 2002:a5d:5d13:0:b0:435:af8a:2a6d with SMTP id
 ffacd0b85a97d-43629349fd2mr6740822f8f.11.1770414430569; 
 Fri, 06 Feb 2026 13:47:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b25d5sm9170067f8f.2.2026.02.06.13.47.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 21/30] configs/targets: Restrict the legacy ldst_phys() API on
 x86 targets
Date: Fri,  6 Feb 2026 22:44:39 +0100
Message-ID: <20260206214448.22008-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

The x86 targets don't use the legacy ldst_phys() API anymore.
Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to hide
the legacy API to the x86 binaries, avoiding further API uses
to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260204204103.46343-5-philmd@linaro.org>
---
 configs/targets/i386-softmmu.mak   | 1 +
 configs/targets/x86_64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index e9d89e8ab41..19ef4a6690d 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 5180560d4d6..151862158c7 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-apx.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.52.0


