Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB38C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadJ-0000PD-43; Mon, 10 Feb 2025 15:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thad2-00005R-18
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thad0-0003jM-6R
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso13623315e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220215; x=1739825015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmIIepxBiZLQsNuZn8sQxup5Et3m6InNRnsHpKWou+Y=;
 b=XAM/HyuomU9xEQ1J3Gf+ZMFiLAIqA4xvrvi/6DbpE7mo37NVd+565iXdAeuF2e1CYH
 r+aX8L3Qyo9pK9hQjZqKS2LG3A0d4aauKczPWggGt5ZYLU88J1qmzlJsmD/BOs5nqSp4
 QNb5a8t3hYfz0GT17Q2CbTJCUzCwZoKREBsbcN3ePeMs1dKZIXqcUuuOswZeVZ4D+RjJ
 7uEkaRIwNklkluBc10TLIW3c4/6/0L5iCD3A+3lVYCVvz22FQrJ/UvyF8Mms9AhU99v7
 nY0GfBc6rrfDzBzPPwZFhP6m8TJNoVbm6warmlK2j7/Hhsdkqyp4n3Zpr9pbpA+v15vi
 XlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220215; x=1739825015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmIIepxBiZLQsNuZn8sQxup5Et3m6InNRnsHpKWou+Y=;
 b=HnnwH3m0uEQJ59xItXbYekjEMuTap9ZiEfYhZMVXY/CQEBip7JYC9Xv9O5W7D0ZiUz
 Kte6ch9gGA5HI8tDLJ0J1L55RnxpjpIW8IFYPpVrxCzn2pOTk6OPByqfIsNwVkj3FtQI
 jDesnSz6iQ0/U214Xf0hw3vkBtgQeG6wZ4HKtKaDD7x3L5aDLuAVsEUW02Lp9pNwUq2E
 54slwF8oVJk0IeV1zqLDKBjX4mEEQWpye0ZVfGJ/XQcGyNGQQZ5Y8WC0iQj4CFMw+8PV
 0PCd9PCe2VJy6N8SSjkF8OwE1wp9ybHF07SpzhFygHRpVPp1hs9/Q1s3shm6IevhlRo9
 UyYg==
X-Gm-Message-State: AOJu0YzD1m6Vjcit538jzXQAjyqY/kBLOWvPBitHGAVRie/asi0KpOnf
 Nj7krDnvWLMkfjApCmYFjuSXsd+ycQN6Fl+6bJQO9i5Ph6ENfgiwtEeFo8eErjH2anruojHuOzU
 PZA0=
X-Gm-Gg: ASbGncsur33gn3CFdPxnvJn0KXSq6XtGjWw1U6nTqVCjQj+xikCBFx0xXwJcvrv6s2R
 g2fWoNrqzaJ29Jh2JqWYnjXWucylJzDVvc6FiFF2mDxH/yxSS1GSuxEBJQnGyXuK4VdEcr1iya+
 QwIQ/KC9+ECM4yG2VkQzEVZ+xROMIclOPgorCLqnFiTixtrqR8jSQsmN/+n/u6pLo4YiduThX6S
 Xj8ywMlqTcOIimOfFPgcG1vmWON/AeVDUJiD3Bu8iq6dCcXzUpcESUfx1ID1wOXx8cYoalG4Rm+
 QzU0vUf129HdJK0viKbeiEt+bDK8Xzqf4kfdLdA20LhrN0NBzlGwKOP4A3Cl2E0g7w==
X-Google-Smtp-Source: AGHT+IFJqu0DKdDRN2QlIrSnTEF+9zUa6rnnow21TMw4pVrV/bwKJy9Bk9p2a8DIhTBD3KxxbdOMDQ==
X-Received: by 2002:a05:600c:450d:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-4394cec568fmr6745795e9.8.1739220215210; 
 Mon, 10 Feb 2025 12:43:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d964c71sm188667265e9.18.2025.02.10.12.43.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL 17/32] hw/tpm: Have TPM TIS sysbus device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Mon, 10 Feb 2025 21:41:49 +0100
Message-ID: <20250210204204.54407-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Because the TPM TIS sysbus device can be optionally plugged on the
TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20250125181343.59151-9-philmd@linaro.org>
---
 hw/tpm/tpm_tis_sysbus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index ee0bfe9538e..4f187690a28 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -133,7 +133,6 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
     dc->vmsd  = &vmstate_tpm_tis_sysbus;
     tc->model = TPM_MODEL_TPM_TIS;
     dc->realize = tpm_tis_sysbus_realizefn;
-    dc->user_creatable = true;
     device_class_set_legacy_reset(dc, tpm_tis_sysbus_reset);
     tc->request_completed = tpm_tis_sysbus_request_completed;
     tc->get_version = tpm_tis_sysbus_get_tpm_version;
@@ -142,7 +141,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo tpm_tis_sysbus_info = {
     .name = TYPE_TPM_TIS_SYSBUS,
-    .parent = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(TPMStateSysBus),
     .instance_init = tpm_tis_sysbus_initfn,
     .class_init  = tpm_tis_sysbus_class_init,
-- 
2.47.1


