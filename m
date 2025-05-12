Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB191C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOjX-000091-BT; Mon, 12 May 2025 04:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiE-0007K0-9e
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiA-0001j7-Jp
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so26150355e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039232; x=1747644032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGMxhkM+K1151m0Q6w06J+pb43qtIIW1myqQabt4VNk=;
 b=DPhw2QhroO9B7NPTfzDv5ekVm63wxzrG9tcgTvXs9U0BLfe3bwSJkWhAMi+gEu1Vm3
 VsNRcvxIiUrja8ZPfiBqf9KLOo5TRwNYAUmeALgGrU8NbFTs06kGqz/6Hba1tAm1VHyg
 ObWL6PtNz1X3xx3V/FLFr5/uNPqrLWZQk1mHaA+s8trNnkeQmDi38y7xHlbMY3xuhSDh
 jQxfLmDC9DpeonX8khea1Cm2NIvz+Qe2Hvuf2wjZ41dkwb/KE7/eeJNBORcmsi34N0Rp
 C6PJEf1DZ2m5K4e+Qd5z9aMCfBL+tzqgd+8tDsVsk2/almqNe+XfqmS8j7MyeYvye83R
 fWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039232; x=1747644032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGMxhkM+K1151m0Q6w06J+pb43qtIIW1myqQabt4VNk=;
 b=Zil1wjEKsELpM30/pQeAEUosTsYlXJeg/FYHGiGAVhraJBgcizFy0hT5gy8PsYkYi/
 5fI/axyANfZY+Z/TPH/1PsrC3sMLfWif/M1Ofyk8PFJKDkHXV3UyVdQFmGpYg4EJGBKj
 9McZkZem2FFbwS+yV32QFy9JtCS3Kl5NoaWy15otg0Ew07F5LNrbF65MlGpMm/aecBSg
 VYblueDN4PmR02ulPHT07m1XmKECZDKPMyxeySfyPc+0QWcvAUjnt48oGVsKrMKOOCUp
 bD33XD4L8O0wdVHzinS7p0rDNr+pxfPkgWiNANo7F4Jqg8kRzOHWFk62U3Q6g8vjetP3
 4pew==
X-Gm-Message-State: AOJu0Yyy3/C6Frs+WX7jl9e6S4F63mffkZJ1G+69HtN2IBgs9C79QTql
 YWI3XCtADoZLvQcdLZByun88WMYc2HZ+4Zu3kC/2tQx/hTtv/Rsh43c+o5Moq0gjfHNGo/GDkws
 Ybs9jLg==
X-Gm-Gg: ASbGncvg7Gi4Lf4Xi7q7sFwW8+XVyW3VkiX7UwP48sSamxLAhRE3cXaisD4MvuQSfxA
 R8g7PFG5f3LI0F7Cs40hnyo0lSBrT/5IHxR2gNEEdX7PkbFWb4sGsLJED7aAKFnn1+c+L8/2Bjr
 pVW2YGGyJjgyKXTcBa6lkEdR8PobqsHSsW+VRtON42xvzSga0m3YvsgiecMR/yV/DMFqxUj/3GW
 9PC+Hn1qHMdzGWWGTqSVLuekVDOR7ZmKg9V+K7V5ZRzlMnx24mePecI+bVbW+eYPFuxegf8D7HP
 P99l8PucTyU39KPNfXoDXGf404TGIEj4tVycdcnoaBhxhgW838FrAqrdFZ5kOqtaWt+C1TgG5Uu
 upghHUppNEEYvnq0E0RVz3YY=
X-Google-Smtp-Source: AGHT+IFTvCsc8kZdDOOaq1zeWoQm29l5giS03mfWn9wUC25RFAfpi8saX8RAUrEHPljarbWYPpe6xg==
X-Received: by 2002:a05:600c:4745:b0:442:cd12:c68a with SMTP id
 5b1f17b1804b1-442daebf181mr85667105e9.1.1747039232284; 
 Mon, 12 May 2025 01:40:32 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7dd5sm158810895e9.35.2025.05.12.01.40.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:40:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Date: Mon, 12 May 2025 10:39:33 +0200
Message-ID: <20250512083948.39294-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The X86CPU::check_cpuid boolean was only set in the
pc_compat_2_4[] array, via the 'check=off' property.
We removed all machines using that array, lets remove
that CPU property and simplify x86_cpu_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h | 1 -
 target/i386/cpu.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4f8ed8868e9..0db70a70439 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2164,7 +2164,6 @@ struct ArchCPU {
     uint8_t hyperv_ver_id_sb;
     uint32_t hyperv_ver_id_sn;
 
-    bool check_cpuid;
     bool enforce_cpuid;
     /*
      * Force features to be enabled even if the host doesn't support them.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ca6307c72e..cd4361b4227 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8174,7 +8174,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
+    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid)) {
         if (cpu->enforce_cpuid) {
             error_setg(&local_err,
                        accel_uses_host_cpuid() ?
@@ -8813,7 +8813,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT8("hv-version-id-sbranch", X86CPU, hyperv_ver_id_sb, 0),
     DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn, 0),
 
-    DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
-- 
2.47.1


