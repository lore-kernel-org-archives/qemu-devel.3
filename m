Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DF6CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeQ-0000rP-Df; Tue, 30 Sep 2025 04:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdx-0000Na-AF
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdP-0001Bt-Oj
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so3303236f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220571; x=1759825371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5u2B/lBOO+ZT0vBm0zXHtehU3SXYck4J+kjqZup+Gg=;
 b=u57byfSkLMVOt38DgYkaSESuWDEVizx3oTgW+QilSbFLoqSrMOdC4cC/n16CmOzM/c
 Z5UZRhqfUSgjGDrApDnjs+FYmykeYq3EbZmH9Bywf3LnZpawHn8cUHi+qRWuIc6BewAY
 RZ4MjoO4SnJ5SgsQ46TtQG061JycLoGz2ViQmwdOZ5GUY7ikJ0RG6G8cgb8KAVjR3r9O
 qAMRev7yLlVLsKcx/Lb9FyQdbFs9W7CKL2JiYztBU21QS5fraSuPmBnNg3HTBDxkBfN8
 5JWMIkF7JJ0OwRirgqeME5mqTN7dqrVVxt8fo/gZTB7/YUXSoUm2jnIg0987ccaI8cKy
 wjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220571; x=1759825371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5u2B/lBOO+ZT0vBm0zXHtehU3SXYck4J+kjqZup+Gg=;
 b=TMzd+jqjzBz3ONCRRQw5mtwCO5+QHZ/+7W96mXG3tBjehAdoxL5zPzABWCg3zmMvEP
 8CqCSVY455wk0lsOiTko1UOh1S1LKfUWB/NcO1InNGhfM+mMkhH66Nlb0mrnGtmoKVI+
 nnnAs4bswNGx+MPNUYfkUW3BaJJoLg/vMFZcIw1NdzhHPe3tGrtm0gJPBD3Ka6Kmw2cI
 L0jbk2LOUHHHeZX5+QAx4FKj2Hn7Q/uGEHpF4XhjCn3sHbmP52auYpYoMOPxeum0o0bq
 rTtzQx6v9TQLxQjOg8Y/73SHzNEepP7Kfftl5CDtsfli3ZEoD7J8g7ofTslmmu/tDzM4
 IcNQ==
X-Gm-Message-State: AOJu0YxsEJoL25tIabHHUM4yo9fJRFecl5duBBoFIt4XTJiKg4xio8a5
 0E9LtLi+z40HqLA1H4jjen6kAAs0MLqIb3zUBJmdm8IwYddRCEVhSlgKNhD6wpXhppUjaFxxuAZ
 dAxLtkDO46w==
X-Gm-Gg: ASbGnctAnfnK+rZ1wtbLNGAaP9F3R07TW3ZYBaqFl6nRaDBbm/Df4NRIUqCUAyDZa5j
 tTfL1bJM8sb4/RKKRZDeQef+qnkAWt6/JaI5nse9ci1SuzlRz/VN2KKpCGILjnvopppw0F71XJ4
 XpD4eNdtYYVTB+CbmZO8XPjcpEkmExdREO2USMOdKCZh2guszfTYIVmZP4afWPCww5R9t9KrYiU
 eN90a1QfOR+51mdyEgLU6RMv9wI92MCIDYlZGJ8gvhSYSebPurc51zZ23I7NSYAa6oglZfe7Usz
 VrZllRUnf8xINjCKdtu5oUwYHd8AGsngnbNiEbQaLxkqYjGBqm1DCpGfHMe03yvvAsXJjZtr5ZN
 vx7GOa9KL/8GaUjm69Fc4rWNPoXCZ0sSohD9EdU7BjZUmWq6atMY3n7/+eS81lraNvyBO8MidzT
 GUxE7aNpWbqZZ74IzPUQgv
X-Google-Smtp-Source: AGHT+IF27z6BNMVinFPf1IUIruLrE/uTdfyqnRZ7rQ19Ax6aGtKGHkRUD8xTP4t1vKCXsfORDSUoIQ==
X-Received: by 2002:a05:6000:2507:b0:403:e61e:82e6 with SMTP id
 ffacd0b85a97d-40e4b1a07admr17394709f8f.46.1759220571045; 
 Tue, 30 Sep 2025 01:22:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41855fc661esm13882477f8f.45.2025.09.30.01.22.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 15/18] system/physmem: Avoid cpu_physical_memory_rw when
 is_write is constant
Date: Tue, 30 Sep 2025 10:21:22 +0200
Message-ID: <20250930082126.28618-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Following the mechanical changes of commit adeefe01671 ("Avoid
cpu_physical_memory_rw() with a constant is_write argument"),
replace:

 - cpu_physical_memory_rw(, is_write=false) -> address_space_read()
 - cpu_physical_memory_rw(, is_write=true)  -> address_space_write()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/coccinelle/exec_rw_const.cocci | 12 ------------
 system/physmem.c                       |  6 ++++--
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 1a202969519..35ab79e6d74 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -62,18 +62,6 @@ symbol true, false;
 + address_space_write(E1, E2, E3, E4, E5)
 )
 
-// Avoid uses of cpu_physical_memory_rw() with a constant is_write argument.
-@@
-expression E1, E2, E3;
-@@
-(
-- cpu_physical_memory_rw(E1, E2, E3, false)
-+ cpu_physical_memory_read(E1, E2, E3)
-|
-- cpu_physical_memory_rw(E1, E2, E3, true)
-+ cpu_physical_memory_write(E1, E2, E3)
-)
-
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
diff --git a/system/physmem.c b/system/physmem.c
index 033285fe812..51abc4cae96 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3191,12 +3191,14 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
 
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, buf, len, false);
+    address_space_read(&address_space_memory, addr,
+                       MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
+    address_space_write(&address_space_memory, addr,
+                        MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 /* used for ROM loading : can write in RAM and ROM */
-- 
2.51.0


