Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80943CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl5R-00070C-Vv; Fri, 04 Oct 2024 12:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl5O-0006sr-JB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:23:22 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl5M-0004TR-0V
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:23:22 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-537a399e06dso2649118e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058998; x=1728663798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EXxbN9xNIe/fch86Xk2ysVTGoSQLunGFBZDl5pFX4s=;
 b=zABwxirR9zGdwUzNB/qmkeoWOcE3czRgqCE2MIUHprD3ravoGKBCjx5giPQ7RvDxH/
 +7IKAzXLZi9pJ16MT3lXH0KcsqZmApWb6U/CdnCiZ9Den5F9HK+MwtGAY1YQxAlUK4H1
 yt4UTmbdT4JNXlIZHHaIJquoiwaSg+yiHTDEh9Gy+P3ypCnYKA5aR7s98HvmNrz94UIw
 PUiz8xkyDZoFnnbBUpR4aq2/15PQOLmo5Ufhcr2zT5OMg4GYln1FPf2VDlpWYYwgsGl/
 aMTwBLPaexHCXtwpDRakeYteYFjU1oqV8G4H/2A+MuFOM9oJIxnHclxJ/L02DL1pZYKA
 Ul8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058998; x=1728663798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EXxbN9xNIe/fch86Xk2ysVTGoSQLunGFBZDl5pFX4s=;
 b=sYIwpqWIoQEawMjzgEDeDllyua54rDas9BVHIqv9QTheDcXXdHbMrpdMLQ3U4oj2eh
 ocAM6fnYf+OE027NzKmnn8kXcdJUTy7fKEnQ7Yyg74vgzgGmAFgTpmP9YjVaFoVSJKFl
 hAARZdMFbv8yDMoaBYIMT/EVL6APoj64uPSH6WtqNgxisJlCVYTwtdq+P5DAZwhoeouj
 RNE1hcJkW9pVlGGuD5mAhTeCPq2XN4L0ETKtIL/1/zSCv+zyH6eK3MZh+iZ8cKDt0wOz
 i31jKAeHxa68xmVbvDw2Jg4PrPzsjSy0mAgU8VyKOWGO+GeOEkU8Ohqp6cQz4XUysezb
 k4mQ==
X-Gm-Message-State: AOJu0Yw/rftqwp6jJP48vcEptZYB+AMqPiDf3m1/A701aKg1Or7gJLau
 MJJS+UYLCszzJjJ7LBfYOQzjGCr6f9lChp6PPMgvvnbaQFScWwEep5nbQRo1mRzsTxAEVXwM+aX
 CGo/M6g==
X-Google-Smtp-Source: AGHT+IGP7Uyh8a1ixCMHilUdIZTXQ+7/tEjRyL1vshJTHe+hR8Py7IE1VpZXDXFtgzpo7y4SOWMAzQ==
X-Received: by 2002:a05:6512:33d0:b0:533:cf5a:eb32 with SMTP id
 2adb3069b0e04-539ab8741c0mr2171775e87.19.1728058997637; 
 Fri, 04 Oct 2024 09:23:17 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539a82a4f83sm458713e87.236.2024.10.04.09.23.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:23:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 6/8] target/mips: Implement CPUClass::is_big_endian
Date: Fri,  4 Oct 2024 13:21:16 -0300
Message-ID: <20241004162118.84570-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 89655b1900f..ad70ad802a7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -132,6 +132,11 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
     return cpu->env.active_tc.PC;
 }
 
+static bool mips_cpu_is_big_endian(CPUState *cs)
+{
+    return mips_env_is_bigendian(cpu_env(cs));
+}
+
 static bool mips_cpu_has_work(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
@@ -577,6 +582,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
+    cc->is_big_endian = mips_cpu_is_big_endian;
     cc->has_work = mips_cpu_has_work;
     cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
-- 
2.45.2


