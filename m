Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00D8C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDFR-0003TP-0M; Tue, 23 Jul 2024 07:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFP-0003Li-56
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFM-0002Wp-HW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcyBRXkTTTsoCZ0FToTwoi2W+WoWKXejjiio+24ADX4=;
 b=CuqXedyF7KzDQ2MdY6KVPUjmga1Kzlp8CPCiIiVi2ngleVBZpYgiChaWH66GSV+ny4b0O+
 /7O8+llLwPd0Q1HNn0Wo7gNEVE84Jmu5x0Mz6Bj/3gZe6A2Il3rBliFRJKV6BErDS5Dg7l
 6/DB5Xa10nSWvkULXPocFW0ZoAJbUxc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-PcpjAzY7MMClMxH4unmj4A-1; Tue, 23 Jul 2024 06:59:54 -0400
X-MC-Unique: PcpjAzY7MMClMxH4unmj4A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso36725305e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732393; x=1722337193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcyBRXkTTTsoCZ0FToTwoi2W+WoWKXejjiio+24ADX4=;
 b=r231hgxjepeZ+TsCYYH6SaxKHcZz45NDyI+Q+ENXZKYCwILOyOFNQOdzdaJYe3tJu3
 d3moAQ7N/hBPVbliu+/VyYLirVHhAtWrNZtIXtFqUjRCe2P4XzFSSNNprIQsVO2dj4j8
 gvWN8MEUlr/hMM1OJf6JQMyNMqhKtKCmwTdOxBnUwDaCiw+25PAd7BN+KAS/I2NtpgIW
 o5Q98HeYedTFhDce0CsBfUlKBjWwn9Vx1JNu8kjIPlAYY1z1zsdKwHJpYcAxVxsfOPVL
 p5sDl7VOFO04yCi10pF55qnjXQcsz7gwp2wcanJ5+kdHiDu9AFkwIsviDoVYS2ibGSS/
 i5rA==
X-Gm-Message-State: AOJu0YxgO4fV18uiTNZ/qC44XxPLcYrjpapx86Z6BdaHSkfyrLaWDkbR
 NSZBTRKf60W0IFLOs9nxb34V9uCeSExJWK8/Db6+1EFj+TeSr6N/DG0XEzsBcHDJJQGqDFtHtj7
 2IpIONHtUOKC1pFUed1Yeg5LHnBWJ2kCHd9HLHMDljj2tq38qm1SACG/VfAk6rgtU5Ymugad81d
 EyIRv9bhu/J05tdyd+oSEg45G+HaVRZA==
X-Received: by 2002:a05:600c:4f45:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-427dc529c91mr58119835e9.17.1721732392755; 
 Tue, 23 Jul 2024 03:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLHMq9/6jWi11FGt/bR/SNRFSuF0pCPecl27meNHsd3fFidFx8pz35N13KmEvHnv6v1vk+zA==
X-Received: by 2002:a05:600c:4f45:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-427dc529c91mr58119475e9.17.1721732392020; 
 Tue, 23 Jul 2024 03:59:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6902a1fsm163973385e9.20.2024.07.23.03.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:59:51 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:59:39 -0400
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
Subject: [PULL v2 43/61] gdbstub: Add helper function to unregister GDB
 register space
Message-ID: <242da18082abc9310ecd528c528501acbcf718c7.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


