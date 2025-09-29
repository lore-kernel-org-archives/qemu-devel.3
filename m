Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0451CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Iid-0006TE-Sz; Mon, 29 Sep 2025 14:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ih5-0005FX-J4
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igy-0003N8-8I
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so3962738f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170821; x=1759775621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbEYNZgIU6LqvkF49qge8kIj2C3i6K2S813tsyxbWwg=;
 b=tARWXuenr2RIVs6njr4/DsN0S4C9A3OJZ0OtfwKYLG6OSev3IKguQC0i/K+MBOcnfM
 3kwkA0iZIonfdtwslTnRQkD06dbrr0RkOBp0U3vJ/9F8K/uTco2R23dJPAcAHJtNgNNl
 l75ya8/rz+LDSrcpbri1Ow2xOlZbCGG7YrB3j7NfLuqdiUqL/nQVN9oITFRlfyAzolN7
 HyBKPqkjs+eJcyv+rw6Q6ZZnmKvwxkyFPOrsfumBiwxLoeN9fiF8CbMKEXKLbWFUznFW
 cw1cb2v13SbtTfR/6ou3W/FcBygRC+ShJByZCcl1UZwHv1RfHo0f1qwcmw4bSl+hFc0U
 NyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170821; x=1759775621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbEYNZgIU6LqvkF49qge8kIj2C3i6K2S813tsyxbWwg=;
 b=vCvLvvCfFgG75aD7Snhx+sXWj39RiBI9LiEo1H3mZBgT9CtgqwxnLMccW1cuH797/5
 E3HIBIosM1I+9Do+4aA7Mj3srNXDfYdZDVZhK4W84SsaM11sPNmg2aOzh5WfZB1InP/2
 FTbMdnU2DmoBlpqADSWI386XEQ8ju4/WYanbdTi4jZr7QrfIZC4B4b73P7ljzvuheG9W
 DUCVYE7kgBA3mineLWQ/Awb3A3fKl7uyClL9PY6bv5tRAhVOjqu+Nm8o9BbzQQqypdvA
 bxBgXakjwDcTk/l07utHU3NqahI+buwsO8csNHntNI9zorGdlYzDzVXnLBeGPRBvUruN
 VFXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT3EpMXKUHlm3vEv9QqqL7AjV/8sMwWIatKnT3sJOkeqbLgKUBowFnk4m5Q+oLdLqf+0/bKwDJhBYR@nongnu.org
X-Gm-Message-State: AOJu0YyKUFX3s6x4UNHKyxfpfPEGVV6zHFUPRnsILlgI3SQXQXUJHAWi
 QgfhKpPA5iSHGcbX7SsVA0dqia9Fdni3T2veYZx7wP+4ypQJmuW5muHNS7jVWjIYRh8=
X-Gm-Gg: ASbGnct2bF5fTXkrkbSfCyYLTD/CkD5cWyLn9Yjz+TVMGNtgphisx1LbvWIQW7Qtw8G
 mZHW4zVdNnsXRBUj0L5rKqu1Vg/jKH5LP9UNvYyISLeUrnCX8m324iai8R/fYKcixWi/G2+pGwo
 izAW/hjI7jntpZguK+Z972/lXl7Wnio7/I9B8shIAn69RBPBAGsH8dDwh1vCxceeyZfuH/wvV3y
 hwqOVtd/XTDSLaxbn58yfBqGukfOOR9v+e6vdqwfn4qb/HJ/7xNGWkX+l0QZvNNH9y0jRPk5AXZ
 kc6U+u3oJEjPit2vn5fUYXVW14cM55lcdzb6xoY6Ur33FnRmVQd/2E5n5TMp5QsyuVrfhrIRAzH
 60CdKLYOUGUOYDsFv0uqaYcQ8DtB9ULsYh5/NNar/BPnET9kDHeh91XEl2SgFXWr4J5Y/aodZqS
 anoCkUMGJ11MjfE8ie2A==
X-Google-Smtp-Source: AGHT+IHaOBKfpBuD9vwP/E//+ppjcdL0t+dVKZj3FJZtAkNcYom3O6PaZLYCHSxxg6LM7gcPXW/sAQ==
X-Received: by 2002:a05:6000:2c0c:b0:405:3028:1bf2 with SMTP id
 ffacd0b85a97d-40e4d0372cbmr15214118f8f.62.1759170820742; 
 Mon, 29 Sep 2025 11:33:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3d754sm23909085e9.4.2025.09.29.11.33.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 08/15] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
Date: Mon, 29 Sep 2025 20:32:47 +0200
Message-ID: <20250929183254.85478-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2a85168ed51..82ba177c4a5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -788,8 +788,11 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
     void *ctx,
     WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
 {
-    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
-                           ma->Direction);
+    CPUState *cpu = (CPUState *)ctx;
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
+
+    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
+                     ma->Data, ma->AccessSize, ma->Direction);
     return S_OK;
 }
 
-- 
2.51.0


