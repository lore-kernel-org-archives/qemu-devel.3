Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF9CC3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmR-0007pi-0j; Sun, 21 Jul 2024 20:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglC-0001j3-Ab
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgl9-0005uy-EE
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcyBRXkTTTsoCZ0FToTwoi2W+WoWKXejjiio+24ADX4=;
 b=D5ko1VLSyrXHqLQHPKj/Pa6u9VC3gXupl2mZBw3by7nz1I33k3hEGKEFKrcDK9xE/YtW0d
 EvuETaTltG8FQffAGov+1KR0ieoQ9QBmQ3jDHoG54xheiiEfxCGa1mQEZakL4hZpAJH4tI
 9yRou/6GnWmBlo8H+ig1oubXYWxzmko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-gDCpH2F3NaKIhYCG9HD-Qg-1; Sun, 21 Jul 2024 20:18:28 -0400
X-MC-Unique: gDCpH2F3NaKIhYCG9HD-Qg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42668699453so37768895e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607507; x=1722212307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcyBRXkTTTsoCZ0FToTwoi2W+WoWKXejjiio+24ADX4=;
 b=MXLynDPsa17xgrrHkBygb3wo5tL039IulxbTKFcY7X7DXn+kkokQaQx/xIOeMelFFA
 VBfrPFFM3XKdQCmU4lDHZssIEEQHM8/tGlxZWJerOh0Acw+0icfpPswGF/JzO+knByXC
 AYwGyNHmMwoRB65UmNCXezE/SR/DsbXqd3ku3UxO//CeuU/KZ++8v2n3q/MjjSz76MEC
 EWmLHuAhhDDJkwGlvbs/vtnVipSamYlTsuX3MGIgh2+qpSQu1PCAVP0M/lJ1Fj1IW7FK
 Xhg8Rbx62diFCDoAKg7+TF7t1ojAG6ZJJzy6GECqk2K+Sjrjpc4XEIztRpRvieu/T6iL
 pTgQ==
X-Gm-Message-State: AOJu0Yy4C6XRRvf04z4shxFmghwiAn188XUblQjvbiHKt7ax+yJilg3B
 eSqBsEQRFoF3rtrevMC/N/DR0+oh5mOT6CIf8htSQxxS6XaSqFqiKzwqF44Ycv92zjCZgFPmzp8
 vWN4vbkJ43gVwrO6yX3JuSIh2O9pJ1M0cb6HxppIZz/3HoBbBAwSA6a6oIA02G5UMs+5tUFBHPz
 QWO0G2H02/AfzXIBXwjWAe1+C/OgJXpA==
X-Received: by 2002:a05:600c:4ed3:b0:426:690d:d5b7 with SMTP id
 5b1f17b1804b1-427dc55bb09mr37066355e9.25.1721607507015; 
 Sun, 21 Jul 2024 17:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsouKXDGxkIdMyPaPINBJmjiQT+Suo0Ny91y8xgXjnhkmksE7uwx7aHFzR8O8q72lm/20CfA==
X-Received: by 2002:a05:600c:4ed3:b0:426:690d:d5b7 with SMTP id
 5b1f17b1804b1-427dc55bb09mr37066145e9.25.1721607506421; 
 Sun, 21 Jul 2024 17:18:26 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a804a4sm62340195e9.1.2024.07.21.17.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:25 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Xianglai Li <lixianglai@loongson.cn>,
 Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 44/63] gdbstub: Add helper function to unregister GDB register
 space
Message-ID: <1f08da5cf90c3e0d60487ac13ed7079ff3735637.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

Add common function to help unregister the GDB register space. This shall be
done in context to the CPU unrealization.

Note: These are common functions exported to arch specific code. For example,
for ARM this code is being referred in associated arch specific patch-set:

Link: https://lore.kernel.org/qemu-devel/20230926103654.34424-1-salil.mehta@huawei.com/

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-8-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/gdbstub.h |  6 ++++++
 gdbstub/gdbstub.c      | 13 +++++++++++++
 hw/core/cpu-common.c   |  5 ++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 1bd2c4ec2a..d73f424f56 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -40,6 +40,12 @@ void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               const GDBFeature *feature, int g_pos);
 
+/**
+ * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
+ * @cpu - the CPU associated with registers
+ */
+void gdb_unregister_coprocessor_all(CPUState *cpu);
+
 /**
  * gdbserver_start: start the gdb server
  * @port_or_device: connection spec for gdb
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b9ad0a063e..5da17d6530 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -618,6 +618,19 @@ void gdb_register_coprocessor(CPUState *cpu,
     }
 }
 
+void gdb_unregister_coprocessor_all(CPUState *cpu)
+{
+    /*
+     * Safe to nuke everything. GDBRegisterState::xml is static const char so
+     * it won't be freed
+     */
+    g_array_free(cpu->gdb_regs, true);
+
+    cpu->gdb_regs = NULL;
+    cpu->gdb_num_regs = 0;
+    cpu->gdb_num_g_regs = 0;
+}
+
 static void gdb_process_breakpoint_remove_all(GDBProcess *p)
 {
     CPUState *cpu = gdb_get_first_cpu_in_process(p);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index d2e3e4570a..7982ecd39a 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -282,7 +282,10 @@ static void cpu_common_finalize(Object *obj)
     }
 #endif
     free_queued_cpu_work(cpu);
-    g_array_free(cpu->gdb_regs, TRUE);
+    /* If cleanup didn't happen in context to gdb_unregister_coprocessor_all */
+    if (cpu->gdb_regs) {
+        g_array_free(cpu->gdb_regs, TRUE);
+    }
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);
     qemu_cond_destroy(cpu->halt_cond);
-- 
MST


