Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695E7C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2ID-0000uz-FZ; Sat, 09 Mar 2024 14:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2I8-0000lj-0L
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:33 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2I5-0002bd-Mt
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:31 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5682ecd1f81so2170412a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012208; x=1710617008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLHD9GT6b5p3TJG9MYP2E7Mrw1kvuaLUPhHVHq70H4k=;
 b=VWo6lxN8yLys8ueQbO7F1V6Bgnp4UmrW/FJ0ZVFxeWgvRGre5Ao6i6Yh7J1FIxGfSl
 +kg8zqjiL2gDeSUZlsLTOfEr+x/MD/1UG551bdcqauSMyVWOdCCDXcnYy8oiK1ZiLXhr
 DUCIxsB2f1QJAIYqYXS/49Y1/DhxXWQWNV5z2XwcuHgg5YcH2LfzELWmmJM+d6c9cQiM
 NcrTbDjRVePdpLJ9lq+VrO8R20+sUgUIEiC4/UdgoQq8qO/nTmvPbZS6zxIfzcknNV6D
 A59rlmlpJDzJY4OZ9yAbi6EcvFMYQRYanGzuWfQCdPZOyRuOA1x58wG/pcoRtGAobv+X
 KsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012208; x=1710617008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLHD9GT6b5p3TJG9MYP2E7Mrw1kvuaLUPhHVHq70H4k=;
 b=Tri4MHX9BRHOOA7gAia0V0MJLLfYqgpEGxPnBozryywGbUkFXpJdQqdDB3I8ePstgc
 RaVPh/K5/Fg8c+Wfm+t6WkU4YvVh1ZdkVn4P4V+GnFhPSAAL+sEj5OhfA/3JOcbD9RKj
 UjUfnZcw7njp54jn7DH84ZwrH72uasfp+uIIeMYPnJo3icsLAW/NAUIy55rfmzTLLQhS
 TlkF2PizCK2AKcQwx6kEb2a35UDx+55l1MdlgIcM2rgsAB7ibgQug8TrmIg8xTuwYEnd
 y7wIbOV4AVVdqhOXhntTxeNfIUXaOKzZQmfq79Vd9Gv1sq0LB9X5uZIb5qLVsNV6fXyf
 OoSA==
X-Gm-Message-State: AOJu0YwabIfotfhriSTzlOWroYe4gIeZXk5b7dH7y80k6kxUuY4vyOdj
 mBb+Ouuet2zoLj84r3dcmZ3wj6607OWOmDNXFu0/t0TMyKJtlPSVby51W1uGNVyg7ikTUe1nObu
 u
X-Google-Smtp-Source: AGHT+IElag8KDyPQHd/yd7cCq1cSr3wdf4BCFyMPlhbecbflegKHRhCxKpfa2+2S5Xx9q4YSEt6pXw==
X-Received: by 2002:a50:9fc9:0:b0:568:1b94:fb88 with SMTP id
 c67-20020a509fc9000000b005681b94fb88mr1660926edf.23.1710012208009; 
 Sat, 09 Mar 2024 11:23:28 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a50fb12000000b0056486eaa669sm1182154edq.50.2024.03.09.11.23.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PULL 12/43] hw/xen/hvm: Inline TARGET_PAGE_ALIGN() macro
Date: Sat,  9 Mar 2024 20:21:39 +0100
Message-ID: <20240309192213.23420-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Use TARGET_PAGE_SIZE to calculate TARGET_PAGE_ALIGN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231114163123.74888-2-philmd@linaro.org>
---
 hw/i386/xen/xen-hvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 1ae943370b..8235782ef7 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -678,7 +678,7 @@ void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
     trace_xen_client_set_memory(start_addr, size, log_dirty);
 
     start_addr &= TARGET_PAGE_MASK;
-    size = TARGET_PAGE_ALIGN(size);
+    size = ROUND_UP(size, TARGET_PAGE_SIZE);
 
     if (add) {
         if (!memory_region_is_rom(section->mr)) {
-- 
2.41.0


