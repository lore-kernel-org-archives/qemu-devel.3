Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F50C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNx7-0008BB-RF; Sun, 05 Jul 2026 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx6-00087o-AT
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx4-0001Uh-Oz
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tLo5ValhhX5+3ojK35pEOt1WBonnoMN0bsSkHuXA4g=;
 b=eelMjmBOumefrkXfHE+bYRVrF9uioLQl6xcUI6avYWulZMXzVvh1V6LVpKvGz+SgbkpFyv
 jHLSSwLmut8zRjjjSFQ+OK+/sqLc0HnCe3/QBIV59Ke5HVU5urnsjspCDCWfO6hmH6+03x
 sGWEQN+MfX0kn7aZ4/bLuZGvQi9ZI0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-pScO2svdMnCzmdRLiLf5_Q-1; Sun, 05 Jul 2026 10:36:09 -0400
X-MC-Unique: pScO2svdMnCzmdRLiLf5_Q-1
X-Mimecast-MFC-AGG-ID: pScO2svdMnCzmdRLiLf5_Q_1783262168
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso8825705e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262168; x=1783866968; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6tLo5ValhhX5+3ojK35pEOt1WBonnoMN0bsSkHuXA4g=;
 b=cCh0FtjtfrK1bzGIUTLG4cHtz2TCAq3rv95JCMt1PViEYmr7X6LG374iRTH+k8Sler
 JJbFH6E/Ix81Gk41m+IuEY2T7BegX8d1Q2ovsl3A1lIhM6+B6/tt6ysVn9en3FqvA3Km
 Rz9S89G6qSfPNPuAcGNw8nDDLWSjWs2dKhnAgDyTJjYMTLfLqDA2AYj32oSC+W38AFIl
 dWI1tVpvM4vK76DTGnSqTWyUCADfTCqauyn/kblT0PNkRi3dRAoYMC3Qar9NjSglQETA
 P8urP0e2aw0iTxU8LNBbpPhbmJcw2Go2pxA1UlfoEUMRPJIJrHfLpeUWzwNRaZ18uKrU
 aVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262168; x=1783866968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tLo5ValhhX5+3ojK35pEOt1WBonnoMN0bsSkHuXA4g=;
 b=pzb7EvKwa2yZNJDDSd5g8V7r/rlos8axDCztS6Y50wT3s8ajykv5f5tZ3u1lrziDW/
 TgCGnVIzZDIfmW4IpIMdEjmjC4Pn1av8c9xROaQb705SqIUfbx2Rxj2F8Q630CHmShDi
 i5V0qDSKmF8gAIZNNmpq96UNGc0WqNFPhKCIPj5tPKs0NSVBkxDAnCEeUq7NCQ3QU10O
 0kJrpf1flLvWKFQzpy2ymy23xxVoZr+KnFRYAv1MYflA0nh39MnS92lp+7v8k1Wr4UtS
 eP8lhfX0WH3LvaogiiT1VGEiUIzLARwsAYXxAs7Zg/k10rysK1HC2x0UHkYFmyQmTFgC
 kSWw==
X-Gm-Message-State: AOJu0Yxd86WFRNiGgHbbAfMF6QjtOqcDTankfxMiV0RcAeGDk3qnI/zx
 LgI3tTzClos83zLXSBB/wkTDpQk6QpNUZ2J6vok2lRdk0es6rNzSK7Roowpt9fTWR+V5wwAJ3Zd
 Rec7/ii7cqcmygm/E1v3tTYh6ng4NLPTEbLko+ehefeWN2SGiYVHVzW2gTsqWoKJNkLCsU5xdvz
 k3c+UIbVA0mgihR4bMAjd1cUhoxzZRMrSg/A==
X-Gm-Gg: AfdE7cnN+CkfReH8jLBNhHuea8jtM2gBdxSu6gorWNrPdFAvfK+XZMp9AuXiLaGkive
 eGqeQeiiZ/3QMC9WwE/MXkuN1LgyNv/87m0EPZdeWE3JPe/kJ5+kUNach/Zyj01ERibfvhaCAaa
 iQ4mJiOa0hvIK94XoKY0m/FlgrobQlPyj7JaUJAtWV345TfyAzj0Y9IFQJLg90NgTPXYdRi+Fbo
 fnMD4rWTw9gc4+66ZNQR1GfrscI/7B2zvoJs1V93HiH6dz4DzYsBciYVD42ZEQwIcuGHMJUr9rC
 vpNGlmBwtJ90jFDQkFve71CfdVdiSw2KuVSnEDXNvzKHanmViiHhqSYNChP4Bwk+4GCxJ3bmtH3
 G5MzuXVrW+enJAyRKW8XDd3oKiqWMNF9u
X-Received: by 2002:a05:600c:3493:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-493d11fdfaamr74132065e9.37.1783262167790; 
 Sun, 05 Jul 2026 07:36:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3493:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-493d11fdfaamr74131655e9.37.1783262167295; 
 Sun, 05 Jul 2026 07:36:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba97csm286082175e9.12.2026.07.05.07.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:06 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 35/44] tests: acpi: arm/virt: add WDAT table test case
Message-ID: <a9618086355030ed0629d960659960adc27b255d.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-10-imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 45abd8bd8c..cee3dff31f 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2295,6 +2295,25 @@ static void test_acpi_aarch64_virt_tcg_msi_gicv2m(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_wdat(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .variant = ".wdat",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  "-device sbsa-gwdt,wdat=on", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2914,6 +2933,8 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/virt/smmuv3-dev",
                                test_acpi_aarch64_virt_smmuv3_dev);
             }
+            qtest_add_func("acpi/virt/acpi-watchdog",
+                           test_acpi_aarch64_virt_tcg_wdat);
         }
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
-- 
MST


