Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCD0C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Uo-0007oF-Jb; Thu, 08 May 2025 09:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Ui-0007Ob-1o
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:41:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Ue-0004XC-KX
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:40:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22c3407a87aso13358195ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711653; x=1747316453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAafb+dHM0R7U2T8OMZzAcuOcBI3QoaSzAwGll5ygQs=;
 b=O+JrDn7MLNTxze7nteuj+q6kgqyFdjSXaG1BrCcNTkeRrBUIZ2hNFJKS2CdNehcCrZ
 RbSASv9Dw/VZiK+bhEj8qj7qvqyR9aZ4fqetfbjXOTth3F1s6mJsz2QZFd8UQGcDE/Bb
 tJeEE7MuSpqQQQ4Nj3r/+27OQWohhQiCfxnTMWmsNqxLdEALd9PGAxcmPVbGQwcWBGHs
 FMgNbLkod6MBjYFl7JcAip+VRUNSq6cdHa6yJuG/kt01/RE7dASjK+odVxM7vx6vHEyS
 jdglCqb3h53kyM3GqEQci/XRPQOhpbrwmMMlmn5jXp/1dyE1d70rtkLof6wJMAukAiRj
 YRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711653; x=1747316453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAafb+dHM0R7U2T8OMZzAcuOcBI3QoaSzAwGll5ygQs=;
 b=sSJTnUJ6ZhXes9we+rGKlZC1JXF/r9YbRh3yIW7yrjU3P4/5jwU+U1A1uzmZJmlyb5
 8as3I/AHl3vIyDiiL+mL9OqfCE7+DtfUXhBb7wJC3eoYXwrqVcd0XkVFaAZKCnpXVaPn
 5vTebByJaW3QS7tAZnayork0grQ7mVXHcuLTpk52UHmqVnICNB6pbxQQPntq1qPaoLxF
 92MJdFBjX+iYUBjr6ns4xfrxiZqr6LKc7ttnjs8GUDBzFcYvEDweutG7WzVMQY33T7Rj
 d8CjNKYmeaZLW/T0dJzbrbdtvBMPBqWi0wt9n047HOlKiPKNVa8c4zbJWc1c2+jtPz/g
 rPfw==
X-Gm-Message-State: AOJu0YwPPwjvIvI1ruUotkFWLOUIrd1j3GGDq0+YrpVQ9umF3Gelv5MT
 mOm00uHNQUSOPf7WdDYWTcI1kMULtLnBtI8XXxSQc7uyoP9skbhN5q0A11W6lhGorjJl/Rtgu2s
 ZF1LG5w==
X-Gm-Gg: ASbGncs5dvv8dSWwaZsoTGaJf+ZDxXkmSnd3QFzhH1XdX0ebvJyre+Gb7wsbPgLRjt3
 Q2ntQhouDtGdJn6vL9UjZypohcnA7GvwrRh2eLIO7kgWT+jB5FHo1Mc5JVKkBJpTmU5AS4jlAN4
 yYHNcYW2aMkKjhFmPUy05X95/nYydBxSM6Q/+Luay7e7zRh+zIRILyrDL10izYff6dlH5sgxeNp
 VTpvQTBKjO/JDtSC8jmd31qI9wEKn0vU4V20NOtwR91YZ8Yqczv4EGB1yWDCCXV9DMipNIyhY4S
 FCrirSlPo3dl+a3Dw4JzBTPq7R1zESgQYeD4/nI4CkxXnGPQC5P3IySs7OaaEi4li8DSay71e1N
 clTQjCMIoMa1XSDk=
X-Google-Smtp-Source: AGHT+IH2y/VUfyrC8R22FpXXRo/ODUgoWXOAiZYF8dEokDeUe9aZgmQXy0YOuspLaJeraSPMUSaU9w==
X-Received: by 2002:a17:903:194e:b0:224:f12:3734 with SMTP id
 d9443c01a7336-22e8660509bmr47849675ad.30.1746711653500; 
 Thu, 08 May 2025 06:40:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eb5d2sm112359365ad.7.2025.05.08.06.40.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:40:53 -0700 (PDT)
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
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 13/27] target/i386/cpu: Remove CPUX86State::fill_mtrr_mask
 field
Date: Thu,  8 May 2025 15:35:36 +0200
Message-ID: <20250508133550.81391-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x631.google.com
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

The CPUX86State::fill_mtrr_mask boolean was only disabled
for the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Being now always %true, we can remove it and simplify
kvm_get_msrs().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h     |  3 ---
 target/i386/cpu.c     |  1 -
 target/i386/kvm/kvm.c | 10 +++-------
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 06817a31cf9..7585407da54 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2253,9 +2253,6 @@ struct ArchCPU {
     /* Enable auto level-increase for Intel Processor Trace leave */
     bool intel_pt_auto_level;
 
-    /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
-    bool fill_mtrr_mask;
-
     /* if true override the phys_bits value with a value read from the host */
     bool host_phys_bits;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6fe37f71b1e..fb505d13122 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8810,7 +8810,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, -1),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
     DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
-    DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
     DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
                        UINT32_MAX),
     DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index c9a3c02e3e3..87edce99e85 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4635,13 +4635,9 @@ static int kvm_get_msrs(X86CPU *cpu)
      * we're migrating to.
      */
 
-    if (cpu->fill_mtrr_mask) {
-        QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
-        assert(cpu->phys_bits <= TARGET_PHYS_ADDR_SPACE_BITS);
-        mtrr_top_bits = MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bits);
-    } else {
-        mtrr_top_bits = 0;
-    }
+    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
+    assert(cpu->phys_bits <= TARGET_PHYS_ADDR_SPACE_BITS);
+    mtrr_top_bits = MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bits);
 
     for (i = 0; i < ret; i++) {
         uint32_t index = msrs[i].index;
-- 
2.47.1


