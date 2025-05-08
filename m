Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D9DC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Wd-0004W0-8d; Thu, 08 May 2025 09:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1WU-0004Q0-N7
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:42:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1WR-0004jj-Hz
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:42:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c3407a87aso13408265ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711765; x=1747316565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gg679U0oeTq/CrQiB/JmPwYk2e2+O7nBapgQj4COJfQ=;
 b=VCLuXgvoFb4mjBA3mHRP7790++foWnuIb8qexm19n/uuzXW3ybcunp9TonNPNGhUw2
 b9itChusjpb6dxe6CiIjlUeLZTyEHfp+FQbrxBa74cNw+hgY1OBOBRXXuqEkTsUvVE14
 PK0/xPHFJZw1HwRw180/adto8dysyMSZmH5l0vf7+ceA6PptajxTBlAFtC9wtjrGBZSv
 4lzAm1O5fjAbWtfgjMp2c8oygkHmJ9stlYvbSA1E7nwpb85L5I8eG2NkqTBWB9CnE6GV
 AazqTUkRrdeUxgQi8mZD76xFg6mU/5nPmJW4YbLT99GWQc9VCgdHZYOWbBUYKsgxk21V
 iTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711765; x=1747316565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gg679U0oeTq/CrQiB/JmPwYk2e2+O7nBapgQj4COJfQ=;
 b=jvOnDIVuJKTj+InqwQ7w11P+HPnh2GjAluIo9NAj8WnKnZFXsAPPhhhvryzC3jOyQ7
 LcwbnkfYMPOoA+mPMxe4LpFHcNwIFqWlaDbrid86KVW9vIW0NNwAY8XoQ7c0SWPmukum
 p8vKby8rdWqpDM2o/jBvgkKtNe8SF0QFQs07XjZGEY3cdJuN2aS5NoCAMDmzd+WMnPzp
 hsYQEeOWDP2AVTET2hznOMC6f4Xgt88xzPReHq2kyg5ayJ9hs+73Du4i2Wh70Z9uLrtH
 uFOaZnWSz+oxG1UdmCCoLYzKqXgkrgXLxp+BW7jb/yyK3KHpOykZ+rus0f7FX8vxhKKh
 +6Mw==
X-Gm-Message-State: AOJu0Yw2HtIGfts45NLk7/KwY+9vLwKFVGuEu9Jfp9/FvPXna0T+09PE
 uOVhof2L2h6V0tQ3oxOVENqYYKEdvYTIGa33pQpO6UNZ/tGM4lTFYoGOQj/nTtZ7Z/WDnJPmONt
 vKdSdjw==
X-Gm-Gg: ASbGncuS3mFgZYpItwL9ax1Xod1bNGRHqqkMuRkELaBcHt8CgrIONKA+8jVbNUj0YzS
 I/H5NScTYqHZoJe1FufbcP8RDnkeLXD+BJOZp5s4P/5hsa6znRPxWBnoFu1jEjcCm8rimYmPRDz
 ofaW1/amNER9RZuDmeV6+i5x0leftvE67c/JWsdyPoXCA9nDXKTFjrn/BrUmQWTIP7FAZeBqLca
 TXpPFDMhQH6ylWT9IoR8S6VJee/U1ZDUrNAaT+EvkF0mXyfIRQcgdDKWHUujLfQCD5GeR+Bxlgo
 qEGEs2WONNqGzYFvPn6ZfizzptiGgX6OslG3goIJienC1d/RbBeY2U5E8wI8Iv8GGYxqj742aYB
 44rzPK0Nk8NUtq6cqAKViJFWZPQ==
X-Google-Smtp-Source: AGHT+IGd2BdAYJt/pgnYduHUiEhOTqQEnoUCxH7HrPCg6BSmtWJTrp7/DQ1i/MuAD3g4No1s3jElvQ==
X-Received: by 2002:a17:903:41ca:b0:22e:421b:49ad with SMTP id
 d9443c01a7336-22e8f0b60a9mr53754775ad.46.1746711765042; 
 Thu, 08 May 2025 06:42:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15232655sm111626845ad.259.2025.05.08.06.42.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:42:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v4 18/27] hw/i386/pc: Remove pc_compat_2_7[] array
Date: Thu,  8 May 2025 15:35:41 +0200
Message-ID: <20250508133550.81391-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

The pc_compat_2_7[] array was only used by the pc-q35-2.7
and pc-i440fx-2.7 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4fb2033bc54..319ec82f709 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
 extern GlobalProperty pc_compat_2_8[];
 extern const size_t pc_compat_2_8_len;
 
-extern GlobalProperty pc_compat_2_7[];
-extern const size_t pc_compat_2_7_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 65a11ea8f99..c7cdbe93753 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
 };
 const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
 
-GlobalProperty pc_compat_2_7[] = {
-    { TYPE_X86_CPU, "l3-cache", "off" },
-    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
-    { "isa-pcspk", "migrate", "off" },
-};
-const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


