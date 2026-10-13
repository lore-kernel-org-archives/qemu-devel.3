Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA588CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGif4-0005wq-Gy; Tue, 13 Oct 2026 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGiex-0005wZ-Eo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:59:44 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGiew-0002et-0f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:59:39 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so399925eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921576; x=1792526376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n1Kznjn9gwc9J8CJXnPKY6p2oc96M5De/Smwcsx+f98=;
 b=mQJcAXFAUMJ8n+z4hhSPRgeZLObOvSWY+HW4SvGrvPCiKdBw6oavJbvIHDMIDy78fb
 XidNtV1fI4D30zaMlx7Pnh5MQmbC+2Zr3M685u1o9jmdzzmJoIoM7giYmBiDdUFZXrvo
 RCinK2cePyo60lDtU3QygcaPDkA9Vc1uqyEhI+AMsP/wcENcvNaT4df/TH2UfB8Yggy7
 PyNILi6rrmg3alMdlDGRlACoecYoiIuQRRvWYOjCRC1hRo/CWnAaSv4vdKjOZ1PCwvzB
 lfeceD2pjLfHh1jJPdrtYQNSznjyiBRkXcjfSGQ9/RqXvO43s644F1EHtfI9ZMYneFTo
 urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921576; x=1792526376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n1Kznjn9gwc9J8CJXnPKY6p2oc96M5De/Smwcsx+f98=;
 b=QQylUp2rj3xgC7lNENfCWcgE4sLnjdEpnNLukYKieAgReQrqtmitAPh3+hLiHqBmJ2
 mqEWUocAZKBCxq1x/sIFaVn9YjlAcFyGEqoND5WFOUy7BuT3IpBjCzyJ1ySlSsq8bD0B
 iypMTPnMFeaC216re00d7e7XXzSw+/va6BqVRaZLiF8XxmtFZHp+zE9yUoVKj61oPBp+
 cC5gWdIHNMxxMApu3Cv1IUeRxvWBI24BZie8E9220KMWH5Xw0RXJsP12S8TyTZtdT5eb
 ly0vDc8NsKvtwZdWE0lCLAFoQzZxv0EaffuDKkT6yzOAz8f9GupLTd1HKVDK6a5ZO/bo
 mbaA==
X-Gm-Message-State: AFq9FYLWk3JlDkiu1JGTTfbg/vbZ/WY0JynpYGfjlEE6vgCZdcz+e/sx
 bFwpNaFLislsfOWyJ3eRTanG2mcJOHS8ZO3/W0JMBueci0xmInteaDafoSRDnqnh
X-Gm-Gg: AYBFou0CIUOn0Lao4MLKRmUGWgi3wbHfQ1laehZxvo+U5Xw3eRccVC3mv5o9to6MPsx
 MnZpIAjkShRCRm2tRjcNAacAr/NBiVpY0GWW+tcCiIKmFQEaz1sXiwCJC6qEgC4k7ayQe/iWcfh
 O/H9x1wrXbGC/L1PsB1IIrfkrL+pmIxSp/l6UPaQGqRMoCWcta8DWr2RKgdSJ0hZ5DZuftdBkca
 lwrISO41soXA6JAbxOS3Sai9m14d8O7GWuQNNw7XhxrR8SuS+nEn0FmoqCFX6uJw9otCNOQ0gqs
 rJ6NNrj572c3hgNBITwf/BMYxS6PJtQc3I+9uuWNYCTayud8oBLocgdptV5+lfyCvf8NCKmGByG
 fkfkNjWSCmQwKio2LXswtDiEQmAiuuJonZkigIcRXPNhb/ZF/SDZAoL6YluG54uVYwhgSpu5lzH
 5KwNfXLqcHoqpHfaJyRCtehE4vIYm4pFsXKy8uFU6NveyOxVqSu/hCo3ns4DZerITSLPx+yCTQb
 C+H2FTLaRoQvHesqQ==
X-Received: by 2002:a05:7300:881a:b0:351:29c8:643 with SMTP id
 5a478bee46e88-3537dfb8649mr22456715eec.18.1791921576120; 
 Tue, 13 Oct 2026 12:59:36 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-35ca33b4065sm8374297eec.4.2026.10.13.12.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 12:59:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] hw/microblaze: defer PetaLogix endianness default until init
Date: Wed, 14 Oct 2026 03:59:29 +0800
Message-ID: <20261013195929.1648-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is for avoid call target_info() in class_init

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009..43140ad7bda 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -83,7 +83,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
-    EndianMode endianness = psms->endianness;
+    EndianMode endianness;
+
+    if (psms->endianness == ENDIAN_MODE_UNSPECIFIED) {
+        psms->endianness = target_big_endian() ? ENDIAN_MODE_BIG :
+                                           ENDIAN_MODE_LITTLE;
+    }
+    endianness = psms->endianness;
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
@@ -178,8 +184,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
                                           &EndianMode_lookup,
                                           machine_get_endianness,
                                           machine_set_endianness);
-    object_property_set_default_str(prop, target_big_endian() ? "big"
-                                                              : "little");
+    object_property_set_default_str(prop, "unspecified");
     object_class_property_set_description(oc, "endianness",
             "Defines whether the machine runs in big or little endian mode");
 }
-- 
2.55.0.windows.3


