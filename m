Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBB8FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xid-0004TF-PD; Thu, 12 Mar 2026 00:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xic-0004T4-6K
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xia-00042O-JR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso3380415ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289935; x=1773894735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vS70tBBYbFPB6IXfN8audWC5xzob048TiMHoxsESAWE=;
 b=k8L3zRFWIbPwr8Nm7IPuzL865Mhy85hRKpQA+6L7YRjMTPlBkXNIrIxoQGJmYmU9r4
 Jho0WTkr/qbqJFHLTr9upZP7TOV8kFGvyEOJZpYAu48d9UqIWar2gmXxPIHL+EHgCEJc
 eiqjle7Q5qGjipw4XAqULLqS88aqVwvX2O5hfW9vBkmKT/iCr7tH5V6YXZGELYDL8FL6
 +fxqnW5AN0e5gkRwvs1ppTrfx8jx28f7dKR5F1CYr5gObCrvXqS91xbzQSsDU54oeOwx
 7Y0HsGKOZyDLL1lKucQPv4Tya7CUA4T13yR6lKDt6ztrfSuXc7YR+LNRWuWn30m9GV9r
 5s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289935; x=1773894735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vS70tBBYbFPB6IXfN8audWC5xzob048TiMHoxsESAWE=;
 b=QhibHbF8P1WJ86mf4DS1o+kxh9Nu2ynJBO5iWzU6mou6crmc95HpsgnrVTKMezodKm
 3c/dDNMqvZOrmYYWpgR0Z0DI80M+29Nxvxvf2ZKe6pwRsa8YI+X2ZTWf5+px7py3BSl2
 sVsDav+tUJvPqYm0bL3mhRFhYCVn5wTLYE3yHlxQWBE2lBeb7NL+austwqPU/h8PdMrG
 y9CNDPzlAQ6bcCYcEtwqcjvVnkJEYiXGL0T9HEnwOOsrEY8S3BsZYjUbRfOU9039a17W
 vXt/X5KJWS0DyOdsXTdOW3PV0cCzdzbQJJScKhqMPcpli8gONGpePdYkARUCvhKFpVtC
 Fvnw==
X-Gm-Message-State: AOJu0YxQMSYOjJtKl0sZBqN/Ij395TgZN3pqhGwW2xXhmE+6SGd1SKxP
 ugsNDMdpZLh+M4e+EzOrQqHBnBP+sF7L/i6x80x3zLk/Wibw/KEYm6tpo8JeWBzL
X-Gm-Gg: ATEYQzwPev7B2tvqC1vtmMIjxQMaJ/gj9+TTeROFS45ve5VTgdoj4p7ffdjPAbKaNaN
 8kHOFmJpRinJRpUwt7+kGCE9WOZGMfHvyL4dI5vh01GiyNmPIIn8zAS2nm2J9yk8hHPcCDYmyyr
 Pf9toRBUA+MMmh2dbabrM8j/7P+2AwzltvvTuBzL8avHDWNNGUR7iTLoPVp8GMnQVVT8vFDf6GA
 7I6ELMsCQZJ4YyZW8eOypK99RbPkqlvMyIPBpQhsNPnbLBNd2oCvfbcGGtAt/0p/WfJH3y4oVwS
 LU+p0KY7D21vowfCB7oYILcDH/TjP9PIjNDpPFLQmyiRtVBDGXwB2yBBQ/hNB0NcvY2rQuw3PwB
 +sfwujR7WAKiNZXpBMtqk4NC1t02HKbTt7UeAjMn+cuhN3gA7aEqsEXV900y/jmM9RmSoL0A28D
 IznL9FtmhfLUWA72U2UAn3zDYQMF2iI6YS+cpt41GMI3kFmN12yk4o
X-Received: by 2002:a17:903:950:b0:2ad:bd4c:a2 with SMTP id
 d9443c01a7336-2aeae9447d0mr48009335ad.55.1773289934705; 
 Wed, 11 Mar 2026 21:32:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/7] hw/riscv: sifive_e: Don't call qdev_get_machine in soc
 init
Date: Thu, 12 Mar 2026 14:31:52 +1000
Message-ID: <20260312043158.4191378-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312043158.4191378-1-alistair.francis@wdc.com>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the soc_init function would result in
the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-riscv64 -S -display none -M virt -device riscv.sifive.e.soc,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of setting the CPU
num-harts in the init function let's set it in realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 4cb9c07ffb..e41f4f99e9 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -178,12 +178,12 @@ type_init(sifive_e_machine_init_register_types)
 
 static void sifive_e_soc_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveESoCState *s = RISCV_E_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
-    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
-                            &error_abort);
+    /* Set the `num-harts` property later as the machine is potentially not
+     * created yet.
+     */
     object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x1004, &error_abort);
     object_initialize_child(obj, "riscv.sifive.e.gpio0", &s->gpio,
                             TYPE_SIFIVE_GPIO);
@@ -200,6 +200,8 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
+                            &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
 
     /* Mask ROM */
-- 
2.53.0


