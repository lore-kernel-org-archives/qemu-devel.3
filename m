Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9ACC071FD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqgk-0003qx-Vv; Fri, 19 Apr 2024 12:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqen-0001Hd-Dw
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeg-0001Bv-9o
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34388753650so1027760f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542400; x=1714147200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BWAuiO9PeeT7wJXoLX3l8pOkv9yYOvs9jxN8c0Qe4w=;
 b=ia0anlCwjHODhxg/poAUcqpCB6Ld1f+eUuRpJJuz8zv4m5GUg66XzRiOLRdJXXYlXR
 y8fceJioz/Dxf31mh8myQeT5iSxmW9vcLp61JdT9L1Ke4VUz8QqiZI8QYA7zblwBhOSK
 9baxidZh/r98mDLzNvlAlQ78IYLa9FKULFqfMnqFpGha6CExHm9bY8zzpuw/LhoooOnr
 04SJvWpbrRO84LjYTJal/mNtGchuu9R3EpSNWtRUq9QzgC3T95y08dqybyOyiClmk1cB
 W6zybA0iFJBvLP+J0yquYAEpS9ozhwKxtgAGjHNOQEMM0nowx4g842WX2eP0R97uHPGS
 sNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542400; x=1714147200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BWAuiO9PeeT7wJXoLX3l8pOkv9yYOvs9jxN8c0Qe4w=;
 b=GVJ7MyVQfvepsamaBEtF3FtOufbg065NPl9SeQ9t51b/pPNWBrrNly9NIJdYJxUMHw
 CZkJeMlXX5vMEi5nawZ/ZQ5pYxSkHiENdDeUNcEXxezQWzIElC9CIQTJ9KXixr2cfWrl
 MoErBfzN9u1JMizRrfJovxv295veATUO7t3k9g1kAyFs5zJzngixmdgeeP2bQZSVvQCY
 UF7076k61EMB+z2l1MgklNtfyb5vAv8LtvuohN7rBfLYVtD6DklXmUKW6dPVKFKhER9R
 vtHBTnke+yDDmLEffPlqFTtyjyo98I5kAMTL3OJb3GyPfhM3r7T1NLB2nDBIa4Sg5Z/D
 /UoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwj2tgRBBH6FsRyCC/9pe+bNhDItxEXC6QKEdA6GO44NPpCMDRAbHhP2f1dOSVpRLcVAZa9dm78NEyQJK7rArjtZ32Hgw=
X-Gm-Message-State: AOJu0YyJ0SX063NARDg4fBmduSTB1sEw6b5OpW7k5Ar6XiiHogX+szPJ
 SZ6IgRLNFpMIsCFWCKvgwEIbN/EDzAVytd2kw52O2xqXMDivYwIS5wH1NGfy6W2XhblUL8yYXM5
 y
X-Google-Smtp-Source: AGHT+IHL2b232p3lFzAWlqwCwOnXVcHu34vFIkav0qsljUhtn7NkN1WBCwMvjAVu9roxBgpBo+CyLQ==
X-Received: by 2002:a5d:69c1:0:b0:343:ef1b:9f69 with SMTP id
 s1-20020a5d69c1000000b00343ef1b9f69mr1972749wrw.43.1713542400612; 
 Fri, 19 Apr 2024 09:00:00 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.09.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 09:00:00 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 21/22] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Date: Fri, 19 Apr 2024 16:57:09 +0100
Message-ID: <20240419155709.318866-23-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42a.google.com
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

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eca9a96b5a..bed19d0b79 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2071,6 +2071,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -3229,8 +3231,6 @@ static void virt_instance_init(Object *obj)
 
     vms->irqmap = a15irqmap;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
 }
-- 
2.44.0


