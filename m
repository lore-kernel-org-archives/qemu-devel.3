Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPy9-0006J2-HQ; Wed, 27 Mar 2024 05:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPy2-00063S-UA
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPy1-0006xV-3i
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:10 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56c0bd07e7bso3647581a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533187; x=1712137987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpAaHP47+vZlL1G6hguNwYCAsqH5viF1BvNU/Hhh0/U=;
 b=Qzsw+SCyqgpGgt/UDJfNJ+oqgmAHnfK8ff0U8X37E/Bw6JpgZv9FSA7JC583pB91SD
 lH3AruD4keXlPsspd1S0DZP0pufrdCUyl5lKX6myMoAN+DffMr6tjuagR+scGGUOpXXz
 kT2dommPPqJCFcjBaCN7GEvHh4iwcxsRB/XU9K/8pTO+DZy51JKs8mapALzU5h/r4isg
 7oteI4SZ5Fg4fnFbAGZSHq9ltiJOTb73Ckc0CVsRDz3C96HneIfjPKk/52XeFWCKPI0t
 1zrQwakR+1mGLimdu15fDiF9+SOzHnvIvkyEtDR/c0Kx9Bjp2CVd687xKZtI+2jj1x7Q
 aZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533187; x=1712137987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpAaHP47+vZlL1G6hguNwYCAsqH5viF1BvNU/Hhh0/U=;
 b=cOrDw+UQjWHtkLgMhksEkhp6Lpcm/+6no6a1sble16bdeu3bcROdK7xUqlWO/3nyjl
 M9JleHxBgndF9AhwJbR64QySqJdtj+HV+W893Lv+zL7O6MIcj+vKMC9D1eDZkUXskMqh
 1wU2hcfbcCgknKYJHnpoU/HSGmMNKdmymg6WHT2gNx3ImCiuWJ1uVY0qMOL/by5F08Q9
 6ZRtFXrVEtIMpgApmhrJIQiXvtyIvj4nPrJ3C7goebKP2N3cfkty2C4hT2jscDITN6x/
 QGP/y2x/WbM0hqSxLCrvuutEL/1vv9DtHw4ehtP4UvyXb4oJ3Uh3LsYyi+uO5+a5qjE7
 ptSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8op2FuOnp6VknpscASAJnWo8sOLjcbd/55u2UU2pu9CMtUPEr7zYCq1MrRpUP42SOenHv+AKncHueGCO/Am7fF0qsVXQ=
X-Gm-Message-State: AOJu0YySQ3B0H7Uo/jOe7pmdCTmcX0A8o/A6ETk93AxmXgsP+GXK3vlC
 pEHcsJYR/B2H4X/13xt48HGS6gaAEE98wPNHOrMNzqBIQEBbESo8tcPS8EhiAeA=
X-Google-Smtp-Source: AGHT+IElKhPar7SGPOK1UafW0LelKnWG1yaXQ46WcOllbdN3uWD+H0DKrq+TbK+tCk6ingTIqw/fww==
X-Received: by 2002:a50:9f0f:0:b0:568:ac09:4a5c with SMTP id
 b15-20020a509f0f000000b00568ac094a5cmr1614638edf.11.1711533187136; 
 Wed, 27 Mar 2024 02:53:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 o26-20020aa7c7da000000b0056bf34d656dsm5109579eds.29.2024.03.27.02.53.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:53:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.1 v2 16/21] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Date: Wed, 27 Mar 2024 10:51:18 +0100
Message-ID: <20240327095124.73639-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

PCMachineClass::resizable_acpi_blob was only used by the
pc-i440fx-2.2 machine, which got removed. It is now always
true. Remove it, simplifying acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/acpi-build.c | 10 ----------
 hw/i386/pc.c         |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index df97df6ca7..10a8ffa0de 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -124,9 +124,6 @@ struct PCMachineClass {
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
-    /* resizable acpi blob compat */
-    bool resizable_acpi_blob;
-
     /*
      * whether the machine type implements broken 32-bit address space bound
      * check for memory.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a6f8203460..ab2d4d8dcb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2688,16 +2688,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * keep the table size stable for all (max_cpus, max_memory_slots)
      * combinations.
      */
-    /* Make sure we have a buffer in case we need to resize the tables. */
-    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
-        !pcmc->resizable_acpi_blob) {
-        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-        warn_report("ACPI table size %u exceeds %d bytes,"
-                    " migration may not work",
-                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
-        error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                     " or PCI bridges.\n");
-    }
     acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c37d813af0..ae2d220269 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1753,7 +1753,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
-    pcmc->resizable_acpi_blob = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-- 
2.41.0


