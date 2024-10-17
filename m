Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A066D3C536
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 21:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1YQy-0003WZ-36; Thu, 17 Oct 2024 17:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3TIcRZwYKCt8SPRVFIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--roqueh.bounces.google.com>)
 id 1t1YQq-0003Vt-Uk
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 17:53:22 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3TIcRZwYKCt8SPRVFIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--roqueh.bounces.google.com>)
 id 1t1YQp-0006nz-Bl
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 17:53:20 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e35d1d8c82so25244077b3.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729201996; x=1729806796; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=XZExVi71o26Ins9oMFqKY0JOcAyR9ohxuTaL/vBCCyQ=;
 b=ArcE6PiuQ+tsGCMc6qaVD9oVbLmgLxy6DMWpz80nnfzfAohsDvWP4khToit+A1ZM4z
 zyT6m4iUSAK/5M4W/7Ue851bqmuxj43AG3yLbe6hmTDF8xeQgxhSFnmeSeQDYGwu5fPA
 +QzWoXmKuHZoRecH4kdgG4XEDeFNj2TFH673v8gb35zQz5F958LACUwaYLuURLvqI46I
 Fq1OSTMnlQkoxvz8PFHsdrKQrPOWM214yRMPqCrRert6jhaVrruLvjXIA3C5D1upvYNW
 qwelVayfU0/AM/fhKQP1lEWXLsmjr1m53TMCX3WXkXsTQYJqlUN54ia8TocIY8RVxG2r
 O5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729201996; x=1729806796;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XZExVi71o26Ins9oMFqKY0JOcAyR9ohxuTaL/vBCCyQ=;
 b=WuyTlHYg+BeJqNFqkgZcA+zkDI3VR3mB1HOje1OVyQIodatRSIoQLyiM/s6HWPvy5A
 Tw3t5ExJsEg5KJwaDj0iUPYzYdJY0uOKk/vj68eNnWVEI8mSOqcLJcpLHTijGa/Z05fn
 5DyPYVt419UHyDqjl6UJ+jacgYH3ptqXWHjvwTjL4UOyb1TAyt6Gl0DgiRZkXEwrKFE+
 C4S2GvdRU2nErcz/Im/1iT7LRJUW6G31VwLbS5bPKQlebJ8Srxh365Ym260oNZktnHX6
 LmbrwJsaRQZAxAQMHFPDkMq4Rf565OymvZ22jC9Q3KZJJIuAOaM5Pb3EqyPF6P2Ia50z
 glSg==
X-Gm-Message-State: AOJu0YzQrqloNkBtzWkMaZp3V13Nky3fKhREUcjzk0111L6G5cVSdFhm
 xKyi4YuMFdnPIMG8WuQCSARh/aNI8CfhIrOdzsqMFjZ7atfoipJMqtQb9wWkPYNU7M6Y94QqcRZ
 duQ==
X-Google-Smtp-Source: AGHT+IFi/Yla/jpLIwCTvlM6EnFcxYQIl1HnPBm1ldPr5S3NyqCfpWX9NgqP/9rHagn6XStvl0RCdyvgSbI=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a5b:641:0:b0:e28:f35b:c719 with
 SMTP id
 3f1490d57ef6-e2bb16ac4aemr787276.6.1729201996391; Thu, 17 Oct 2024 14:53:16
 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:53:04 +0000
In-Reply-To: <20241017215304.3916866-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017215304.3916866-3-roqueh@google.com>
Subject: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
From: Roque Arcudia Hernandez <roqueh@google.com>
To: ankeesler@google.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, venture@google.com, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3TIcRZwYKCt8SPRVFIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Andrew Keesler <ankeesler@google.com>

Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Identification
Data) is propagated by QEMU such that a virtual display presents legitimate
metadata (e.g., name, serial number, preferred resolutions, etc.) to its
connected guest.

This change adds the ability to specify the EDID name for a particular
virtio-vga display. Previously, every virtual display would have the same name:
"QEMU Monitor". Now, we can inject names of displays in order to test guest
behavior that is specific to display names. We provide the ability to inject the
display name from the display configuration as that most closely resembles how
real displays work (hardware displays contain static EDID information that is
provided to every connected host).

This new behavior must be enabled by setting the edid_name boolean property on
the display device (it is disabled by default).

It should be noted that EDID names longer than 12 bytes will be truncated per
spec (I think?).

Testing: verified that when I specified 2 outputs for a virtio-gpu with
edid_name set, the names matched those that I configured with my vnc display.

  -display vnc=localhost:0,id=aaa,display=vga,head=0,name=AAA \
  -display vnc=localhost:1,id=bbb,display=vga,head=1,name=BBB \
  -device virtio-vga,max_outputs=2,id=vga,edid_name=true

Signed-off-by: Andrew Keesler <ankeesler@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 hw/display/virtio-gpu-base.c   | 4 ++++
 include/hw/virtio/virtio-gpu.h | 5 +++++
 include/ui/console.h           | 1 +
 ui/console.c                   | 8 ++++++++
 4 files changed, 18 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 4fc7ef8896..778b798c45 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -64,6 +64,10 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
         .refresh_rate = g->req_state[scanout].refresh_rate,
     };
 
+    if (virtio_gpu_edid_name_enabled(g->conf)) {
+        info.name = qemu_console_get_name(g->scanout[scanout].con, NULL);
+    }
+
     edid->size = cpu_to_le32(sizeof(edid->edid));
     qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index e343110e23..186355d0b9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -97,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
+    VIRTIO_GPU_FLAG_EDID_NAME_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
 #define virtio_gpu_hostmem_enabled(_cfg) \
     (_cfg.hostmem > 0)
+#define virtio_gpu_edid_name_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_EDID_NAME_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
@@ -163,6 +166,8 @@ struct VirtIOGPUBaseClass {
     DEFINE_PROP_UINT32("max_outputs", _state, _conf.max_outputs, 1),    \
     DEFINE_PROP_BIT("edid", _state, _conf.flags, \
                     VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
+    DEFINE_PROP_BIT("edid_name", _state, _conf.flags, \
+                    VIRTIO_GPU_FLAG_EDID_NAME_ENABLED, false), \
     DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
     DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
 
diff --git a/include/ui/console.h b/include/ui/console.h
index 74ab03ed72..ce90802e0e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
 uint32_t qemu_console_get_head(QemuConsole *con);
 int qemu_console_get_width(QemuConsole *con, int fallback);
 int qemu_console_get_height(QemuConsole *con, int fallback);
+const char *qemu_console_get_name(QemuConsole *con, const char *fallback);
 void qemu_console_set_name(QemuConsole *con, const char *name);
 /* Return the low-level window id for the console */
 int qemu_console_get_window_id(QemuConsole *con);
diff --git a/ui/console.c b/ui/console.c
index f377fd8417..329688858e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     }
 }
 
+const char *qemu_console_get_name(QemuConsole *con, const char *fallback)
+{
+    if (con == NULL) {
+        return fallback;
+    }
+    return con->name;
+}
+
 void qemu_console_set_name(QemuConsole *con, const char *name)
 {
     if (con == NULL) {
-- 
2.47.0.rc1.288.g06298d1525-goog


