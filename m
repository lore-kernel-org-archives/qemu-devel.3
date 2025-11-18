Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE2FCED63D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQy9-0001M3-TC; Tue, 18 Nov 2025 14:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQy6-00018I-Pg
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:22 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQy5-00066D-AS
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:22 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso1215705e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492539; x=1764097339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZNZo9fJs9S4N7ZWdwKkpgdguDs68+sTGv97Y8m+r5SM=;
 b=H9ocuRRexKyu1ObiQMg764kiVTkGQR2kkDuuGdQuSnkDpxF0EhE8bTJEiMGimwnfgt
 tVODPcn6fgFWvXwI9EXQEbfADZKa9IifHq8HSkME/2T7qd1VaYcFHn8QC/XAexQVvmDp
 fimfe3uvkpOqL6yPqlqGA6Jblx9jwwfPLT3XXwPAQvzJT8ptxCUhSmHrHKiJIB2tMGO4
 BlN1aYg9zuai0lMJc2KUu7CU1RdEnZqOPJYuoygx37rOwwaB3oh4cMf5iSLtDOjlE8em
 JDxJXFGM3daqe33UviPKALqREP0mp7vucKEQlNf9NRzRBSMTlSl9mDEwYlaM/IB2ARLL
 mI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492539; x=1764097339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZNZo9fJs9S4N7ZWdwKkpgdguDs68+sTGv97Y8m+r5SM=;
 b=dTDk8y4DUO5AMthODS8YFbpHxmETbmyoQvAjQEJBhunEIIx8WhKzCvZBXAQmBGu70U
 iNANRFZlZFX0FW7LQ+55zDv+/avEuMpqWGqcge0sBvHN5e1wAcLk0hf9p0pYHXMNiLqU
 oYb1r/+C5NWuie6tj1DNKVI+K68i6CK24rtaM4+q+E4I5N+OOpBPBE5lZSvhqQ44fSxO
 PEI8ioccbiqhyyO5A+tTVgTpzxZnSBsglrvvClgRboeWplPQFo63W4f9dHFkoCGl7o2G
 5C0Cgj9hnS7zTt3nI2yG+Xs2hczvzYTeziQcgMkMt0JVRJ/mh0aOlGHaaS0SuQ8OE6nO
 8eZw==
X-Gm-Message-State: AOJu0Yzqj8zLMdAnPnwo8CGhspEsbYm6gZ/LFBYr/tQ+Mk4VTrdqMqE2
 lnOp3cn4qE5T1d3QVJMq4Sj85EkENw80q1rnNjJovaJECMc1Y2C8nGExZUWzSIThdTkI7JXtCEV
 l+Y0wq8ZNGA==
X-Gm-Gg: ASbGncv/5svorsdMe9U09NP/2vDpefuDJrQ2wQZwVCOexUGnQOvme8RA8sxGIPJoiFC
 TbDRxOP8XlMfT8bqs9Rog0Sjuy64sJ1G19UIhEJRYTWd9n6As0Lrxnk3FztXBBWwhv37vXlRSay
 lfu7FJu0dIEWQ0sm1YyPxEClfHbmael6T2bAcPiuuUWuqOZ4JLb+Basc+zKq4x9MaZA1cYcivoT
 1scJcEpGmprraMJd0jbZPVbUoXCxAIC0NPKLwfrnYEEo5iP1sO89fDdp7pLsnPA0Ox1tntErYy4
 cRFlUB3YwTk3nAXsdiE3vnY2/Vrlp4TZUX8AWVrZMt5nAO924d9TEaz7FvvjbavI7Jfe0JrClB5
 hisUfmEp9Qf+irQtv3RUMgLiuzmWqficIH6mESgoU1PjBy7ieOHInzB2GTjzX1VFDRmanQ6ScOk
 UU+JcHbuZxzY1Mg2eXem5XGGp7ecf3M650E9crtNScukYYTF0HOYyyeA/2YRs5
X-Google-Smtp-Source: AGHT+IEZAer+RrGb5oFdpSd8pizypiZh5wZsdTI+CrKcXmDg3IUEpc3Isp81xs4i2QWJx0rEldj1Zw==
X-Received: by 2002:a05:600c:314b:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-477b0cbe7d1mr5926305e9.12.1763492539522; 
 Tue, 18 Nov 2025 11:02:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a974cdc8sm25469535e9.2.2025.11.18.11.02.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] buildsys: Remove dead 'mips' entry in supported_cpus[]
 array
Date: Tue, 18 Nov 2025 20:00:46 +0100
Message-ID: <20251118190053.39015-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Remove 'mips' from supported_cpus[], forgotten in commit
269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20251117114200.60917-1-philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index df4460035c3..5ddec8afd7b 100644
--- a/meson.build
+++ b/meson.build
@@ -52,7 +52,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32']
+  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
 
 cpu = host_machine.cpu_family()
 
-- 
2.51.0


