Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFDACCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kCJ-0002uo-5j; Fri, 17 Oct 2025 09:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCF-0002sw-0K
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCC-0004RF-14
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso14663505e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706512; x=1761311312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KxjeObRk1P1HK21h4eui2hE+ps24ke9aec+CgRBzl8=;
 b=PflJfOW0STWKgr2cuRbCdivk7nDUlS03LgX/eorMYgRm4U50RMDs1gjlnFlHDxkQJq
 Xvyph+wt9PXZxljOI6CdaYSgeEIvZF3wv/XbRbuo1S+eKpGtxLAmJz4nyfrSQiHpft13
 8MT1r6/owruacFOPXasqk7AGGuvmCHleUBu2wPU3toJUfJPREWkoHtIoEslqjf7RZ4IM
 VFCuwjaCdQHURY5F73ysz3TmxqBjKixndbsIGmOIHij2kG3F42s0mXcqpKG7P5xLJGRW
 IGslDpoFrWIDIOWIHKmauQVnp3g6pEhNjcR3l5gUPPQpyhYbfJ4Ui1TeXuobepPYtVl/
 NoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706512; x=1761311312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KxjeObRk1P1HK21h4eui2hE+ps24ke9aec+CgRBzl8=;
 b=mj2U1I4XDqCGUbIqKnQFlZ95G7CCYP9fUiYjR+ajCQP/5zPkJXvLRhKhDvmP7UIV4F
 mhurboHcLHAB7uDdbPsVUtVVwc8bY3jRmKSLpunR2gPKnthK9QKMf3bMzZpB4XYBoYUz
 hj+i4dFXvoISkQR3JpfiM82kr2ydLKSoZAzOpYw+11OxaTxwMdxrt84Opy/M3Kk3IHGS
 tVPrsHjXs4/hG34Y0YXlhKMNv1CcuXVtLnZ1nN9pja4J6WzVHLbPlVbX0GFCaLqUVrjO
 3MZZ7jPBh4atFo/8BS/id/oq8Uh5Aa5TXPjjsSfmI2cun0gCGgVEHKOG0TwoRYBwCwKY
 ZZQQ==
X-Gm-Message-State: AOJu0YxpCq+aYDYormkLzXMzUXGSC+d/B28JaOflsV4J3NyqkiAzOBNr
 GbfC016OQM0ds3XfP+vgY0hKkddJb7OD1i0hH8sxkwEXy2XfjMTYtp3pmXdAPANPTSRAitYk8KE
 BNnMWwsc=
X-Gm-Gg: ASbGncvi12p/43arKGY5zygPijA+irf2HW4VKMANRNz4SJ9UrxQQCANKRHw4Gj9Iklf
 I/5jwjeMHRa5yqmX4VVDVEuzbP+EKPtP4YhRclCvfgH1FAAJRK1awLumf45sViM8kOol6yDXe30
 tkcfXMENRoorwyH9pWY/5DLkPh9kcQXiO4y9hVl5hDwYqOYUZgkM+LE8LJx9hX04JBf5+K0TCSS
 /BQ1oQ6bSfLZeeNfmuDKF6Jeag73DhAHp4U5JNPe8VFC1xulcu0Uz6KaTrFNsgHLRqt28SpW093
 5TMwh3hduvzVBAegbBKQ1RtC6tgIeTnlbLPDZVJq100+PWkaDu0wH7wYz5Z7uG46s+Bf1UhExMV
 RrqR8b4uliy/gReqzttj2XrSGIJNdLbm2fKHmYQy8EE9CAEh3hiwDuEo0LtqDKEzU76La2K/sUW
 qLIqBlIq0SDJ8hjzoNDp6F9GZykIasM2MCgxeuN/R+jQ6v/RzEek4a6Vc0We2N8kfjTuZXVkY=
X-Google-Smtp-Source: AGHT+IGL39sxfoZGMKlkfVGqRmbnyd0GVrJeU9TSq8s7PV5tzE/GffjJEHNnRiXoYTCVSRxfZRd9sA==
X-Received: by 2002:a05:600c:458b:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-4711791cb4cmr36639665e9.32.1760706512477; 
 Fri, 17 Oct 2025 06:08:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710e8037aasm49332165e9.2.2025.10.17.06.08.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:08:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/20] hw/arm/virt: Remove VirtMachineClass::no_ged field
Date: Fri, 17 Oct 2025 15:08:01 +0200
Message-ID: <20251017130821.58388-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The VirtMachineClass::no_ged field was only used by virt-4.1
machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 04a09af3540..993872bb680 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -123,7 +123,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool no_kvm_steal_time;
     bool acpi_expose_flash;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ed81f3fe8d8..2eda2d43974 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2210,7 +2210,6 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     bool firmware_loaded;
     bool aarch64 = true;
-    bool has_ged = !vmc->no_ged;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
@@ -2512,7 +2511,7 @@ static void machvirt_init(MachineState *machine)
     create_pcie(vms);
     create_cxl_host_reg_region(vms);
 
-    if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
+    if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
         vms->generic_error_notifier.notify = virt_generic_error_req;
         notifier_list_add(&acpi_generic_error_notifiers,
-- 
2.51.0


