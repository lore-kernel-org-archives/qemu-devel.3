Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C7AC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKF-0001eT-Mp; Mon, 27 Jan 2025 05:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKA-0001du-FV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMK9-0001wV-37
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso45246295e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973591; x=1738578391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bH5J3cRQDjcVRgPq7zp3SpsLhqrv1PdlyvsdQnQjIBk=;
 b=hO4QeLnUNQzmx1/A9EnbkSxkQdplD/25G00bDnbdJvh0Kf6ywRWEgPtZiUP6IqQ/V2
 GHAyWGotNNyyDjPg7IOeBW+RyqrH3PcXbDwNArrg4yj+kvvsgWrfvRanl1mh4jN5oaRe
 AQOBpx3RyTCXtsgL7lIFSCjNcCfvGffqMwulKU/wd8PiEXoJ9RHRi+OY2tfmQDiVm2gj
 JnDoxODhXn2kWrHh7NOJA1YsqRI9yTM7pmemiqDkRK0OrDZJPPXTnM7/8KUhAR8m2vkI
 jEfpSsR0rbAT1Fz0dDXPHCfbjni6VFQ2pJLwSX7oeHm1okSfoG8WGxL3o6WZ0r4QylIY
 BSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973591; x=1738578391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bH5J3cRQDjcVRgPq7zp3SpsLhqrv1PdlyvsdQnQjIBk=;
 b=QI22fMu0NNUz1R5SYT1gokyAiX69x4simBygeqtESIADeQAo9EteQB8LArgAn19aYJ
 KOz4KfkVPxaN6Ml+uvEQxaopfmA9a3yivyJyyKr0iVkVeH23ZG8PLXErUaMIwCkw2ERX
 sLz8CWQNMBqyt2VXY3V9T9dkzNlGovQXsmdh6TwpTf9vhIDB4r27dwjSBXno3wfNFYnr
 0Cd8XrFUqI3q5p1A1TOiLle4gvPmPq+MamE1kpXUnLpfO8IucMh8PBUPoxbePHZ+UwZF
 sve6fGoePQ8O5j1IlM8R1CwFMupJih7rnbGaPo4tNgbVnAuTZS1aGYHt3yNoP8drQwYY
 lfMQ==
X-Gm-Message-State: AOJu0YzXhUu+ZxiSE6UqJgs1RYWDyfpJyoqK9D0bZDpQqSKzam0RwSkm
 7TEJPFGvN6DzS45ik03DAdzdIMNOYYGS9HCVGoCOmy+hdWQx6w3IvEYqqtw7ljHjHTP1JmZDIxU
 e/VY=
X-Gm-Gg: ASbGncu3mNt6S4OUvD0LUreroedlj9nNJo9HRet40nstp5knv0QVQiCffRlpdeMe5mi
 19BhpEfp7McwbLLMhkwJuG3zFNoUkepFFESx+P8UjuKfEQiaWHWJw1Wy49xI+LdDjD1BIOhK1rA
 6/GNSdGCmoRfz4rVrrnTQtGU3TKGvf4H9Z06WapFGUGuP+DVeWtILHP6HqKmDu8tr6zmla+Mk6b
 eUgWfLzyG5h3Kx+BajyHRnepfXsHHrd17cZaxeVE+dLOxFexLj7L0HvdwanYoYikneq7DTr3XeK
 weU+EsB4XrnnjjAl1HqL6IGW3PlDfZYW9FZJWhHNAMv7/n8+4S9q4cs=
X-Google-Smtp-Source: AGHT+IGr9lQbhGahkO9jo8M0wLf/25ncd/5hvWg4XE25yr5OCDq3oZXUCQsyehE7qygf2wHzNr4wyA==
X-Received: by 2002:a05:600c:4fc1:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-438913dee3amr354620255e9.15.1737973591413; 
 Mon, 27 Jan 2025 02:26:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57325csm127482275e9.34.2025.01.27.02.26.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/15] hw/ppc/spapr: Restrict part of PAGE_INIT hypercall
 to TCG
Date: Mon, 27 Jan 2025 11:26:06 +0100
Message-ID: <20250127102620.39159-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Restrict the tb_flush() call to TCG. Assert we are using KVM or TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_hcall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index dbf30358a1a..4f1933b8da6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -299,8 +299,10 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (flags & (H_ICACHE_SYNCHRONIZE | H_ICACHE_INVALIDATE)) {
         if (kvm_enabled()) {
             kvmppc_icbi_range(cpu, pdst, len);
-        } else {
+        } else if (tcg_enabled()) {
             tb_flush(CPU(cpu));
+        } else {
+            g_assert_not_reached();
         }
     }
 
-- 
2.47.1


