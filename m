Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0435CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rl9-0001uw-Dr; Tue, 30 Sep 2025 00:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rl4-0001td-HI
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rl2-0000yP-2C
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so18992015e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205669; x=1759810469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbEYNZgIU6LqvkF49qge8kIj2C3i6K2S813tsyxbWwg=;
 b=bqxEmSr7uzomIyiI8JmO4qsFNcf+m0ro3odV4UW++TALTSyqxh4pspzjRr//vKm7VE
 fnMZfSis+N+gnM9fxA0H9dA9IdWh0CiBk/ZJ/zck8M9trvGgIJG+BwhYBJTQcqK2X1Ex
 hPS4jZJ0cPSkyOATMiHR67vBtyRMKeWcYOxnIKmY5vgNK/eZfUXwPXJ8UQbd0bS8MaGZ
 7MYSb3GMSbbAEw95gzFy7XPDEsTNFw2Qnl9iWjjOiLn4zZKoUJxDykKfPl5RHMOCZClE
 Vhf9mU2NE9BD6XCSjzGgxZs9HPLXj9+ZStA+yYlw3cuzDEHWNAtO6dhL6CMFGuvan5SD
 lsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205669; x=1759810469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbEYNZgIU6LqvkF49qge8kIj2C3i6K2S813tsyxbWwg=;
 b=ahXZe13kH+JT4qEP2Y3fHfbXXbyMyl6+rSRzyQc7OEUJGVbeW079WSAOVQYpZQRSxW
 WotPhD46smUmAxuwAFMMuzuGIgYhOMk0fMkETgTEmASaIewVsECYBzkhuLBX3XpmSm5p
 aPb/NLVwJR6JXEpHiViD/f2zuZHMs1wSHqsD19H9zaT3rnORLo0Ifg6PbE11p1ddS/Sl
 nYja8ICvACbD9upwXaCPZiFB60iRAqdoQuKDGUJBWNd1PegcX/StdtCApQrnS02OFii7
 H4MlR++PTLl+qTRGwq4vlaV3Z6PZZRRe4mjGt0IIT4Wn4zm0i1ybePipYP2yQeMXiLqG
 5kDQ==
X-Gm-Message-State: AOJu0YxboNbdEl8fZOhnRjnKTmNDou2caZn5qzX7bg74tQ/+xofdZLAs
 BAUnClje0BHRXxEDdCNY33zLyUI5o08oi4rbOCZSMN6jSV6v/D+KBp4lkVcTUeGi0UqKvBA9Xr0
 MTwLwg3gW+A==
X-Gm-Gg: ASbGncsA5hC3h7DnJ3XRjY++15ccD6IW2wVWoJXDbpC/PIx5GgKpVNEgjvAbPM0hnjT
 gy6QW+3Qjq5rQaVySjYp4rGz6Wwb6CJCLszcTRYV8C4ZdTI1VedB52oSwmBes9utWV9JKI4/eco
 kX/OkbtJT3mXn6KyZCTkv2CtvkwQTDoTipcw3Moc1niMQcQYPfgs7AbXdCGlRmawuIW3jVywYlc
 uRaqS+Nge4ovZgRBrhyes9OjvMjJNTF1b39k/n9XfZ7dFrTHqG61Zrb4Z1zFRDct8rSAyrP3nIL
 sNJHT6V01je4PQiog1e6wMpsIEz/eB/kxvXmNrjWyFF0e1fLVG9hxKdx1FvFtZp+OfEPuW73CQ3
 DNj18aCLcZDRkmEb0hhOEqu/o0ymk447dHboV/L03uPHcyeGLe7pxPS+F15i97SKiBNm6CE9pZp
 wRu4jnfD4UYIssWV7seecHoFokwc4YzE4=
X-Google-Smtp-Source: AGHT+IGQV+zsO38iVKo0msrSbqnR/OPqPQnfcFKxd1s907Qhohb0/U7DrOdOWLv1d/ID8PieNnQk2g==
X-Received: by 2002:a05:600c:871a:b0:46e:477a:f3dd with SMTP id
 5b1f17b1804b1-46e477af5c1mr75062075e9.36.1759205669015; 
 Mon, 29 Sep 2025 21:14:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb19fsm21119525f8f.21.2025.09.29.21.14.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 10/17] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
Date: Tue, 30 Sep 2025 06:13:18 +0200
Message-ID: <20250930041326.6448-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
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


