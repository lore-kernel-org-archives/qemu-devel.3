Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EAFC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4M-00063q-MO; Fri, 21 Feb 2025 07:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4G-0005kn-1V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4C-00076H-VH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2aojgtrZ6esJVqQc5qz1w/JX0CqBotUbbq3GahOTG6Q=;
 b=SkouCYVG3H3YWsXtxXRxkKZIhT5lCtgD4IeWYmscEJPopp5scBlu3/lfrNSYEoqBaS1ugk
 xlo54DGPCs2PzR+3UgfAQlET6aW/Gx4q7nuXVZ9Re+pca7whSJ7otpczicZddIeEB6QByJ
 Q9Q3aujo/Z0AlS0Dmj0RlYjZ/BjFzK0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-ouY0Gy2cM9-ox3TMoLT5_Q-1; Fri, 21 Feb 2025 07:23:37 -0500
X-MC-Unique: ouY0Gy2cM9-ox3TMoLT5_Q-1
X-Mimecast-MFC-AGG-ID: ouY0Gy2cM9-ox3TMoLT5_Q_1740140615
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so10245365e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140615; x=1740745415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aojgtrZ6esJVqQc5qz1w/JX0CqBotUbbq3GahOTG6Q=;
 b=X2s4xShe60NytFAP/QfSHxANyvym18lvVvEQLZAqH7fmB+aRvyHvArL927oCmYDl7b
 stHnrIeX8OJMsV0zzDf8MtT9X9SIyaPxnQYI4ey9FBnSbGH4CG7h0NzNTS8i0VmxKcHI
 qy6piyWcEF5DeLxUH89KnX1xKniHnulE42rp1P4VXKt2HDo/4nYPIOehJVsyajQwEvdr
 DSw9UqsOQp91DJ4Mbvg28nwf1pWtanJenEKKiatB7CcEciA0ShNcLG16yD52BMUTn1Tf
 gi4FCS7BMWt/Bh04PJl2xJtMmtWutATXV1yx+VQZ2R5I1oH4hLMH+uXYb9np33k00MnN
 MCkA==
X-Gm-Message-State: AOJu0YxZVXLu0PdeOqftd9aRrDi5e9sfNJ/9zZRGZCFBjmKrz3T85mbx
 FgCsdr53ZFNZCVATCLeh7mQbyQ+tHP4t+4Qf4ffiuo5QzWfVMS+nl4+bXEgri1nTWkfSFczfyAB
 vPQ7y6hY1M2rwjwABzSrKD6NolxorzEalTywDFX6R1YkCs8spdgHH91cKareellAs9knCWhQQKw
 jmCSdmdTbyCnRiuUJYTIoxKPsi6vZJ6Q==
X-Gm-Gg: ASbGnctWstMWm7N98pK0IbmCAw04WnJbqDP1sNe6lZxsHWInfQOm2pqFwpp6ymiaROJ
 UhtASi+XRsk1v1RePUreswuTpHNtDlVuUdsgfE8AmBuPtVmRC2QbKlosybsTI6mQec0JGBKDIcT
 /8DQzSa4EmvbMyy1NF4IosvFsWxnYEjdGLCx9CVTt9Ee96W8I/v36b6zW82xbdeXPWqG5jjGgFx
 FjP0/zqoO1tl95s3fEa6a6BGev+qO4gDaQemAE3bNXwKT9lezIZyNVrXpeOF8CUHarV2/UiXMFg
 31H4ng==
X-Received: by 2002:a05:600c:4ece:b0:439:9274:8203 with SMTP id
 5b1f17b1804b1-439aeae0543mr22381885e9.6.1740140614679; 
 Fri, 21 Feb 2025 04:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfuQquOBWW5A7tkUGJ2yxc0B2Zlc5AbnX9fc0iisrFfMRf341iMJ09qib/W/y0hD1nrJrhMQ==
X-Received: by 2002:a05:600c:4ece:b0:439:9274:8203 with SMTP id
 5b1f17b1804b1-439aeae0543mr22381575e9.6.1740140614165; 
 Fri, 21 Feb 2025 04:23:34 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce41dsm16307815e9.1.2025.02.21.04.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:33 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/41] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
Message-ID: <de538288e4dac21332cc94ba9727ed8ec8fe5ea1.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when you try to inspect the machines based on
TYPE_PC_MACHINE for their properties:

 $ echo '{ "execute": "qmp_capabilities" }
         { "execute": "qom-list-properties","arguments":
                      { "typename": "pc-q35-10.0-machine"}}' \
   | ./qemu-system-x86_64 -M pc -qmp stdio
 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
  "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": ["oob"]}}
 {"return": {}}
 Segmentation fault (core dumped)

This happens because TYPE_PC_MACHINE machines add a machine_init-
done_notifier in their instance_init function - but instance_init
of machines are not only called for machines that are realized,
but also for machines that are introspected, so in this case the
listener is added for a q35 machine that is never realized. But
since there is already a running pc machine, the listener function
is triggered immediately, causing a crash since it was not for the
right machine it was meant for.

Such listener functions must never be installed from an instance_init
function. Let's do it from pc_basic_device_init() instead - this
function is called from the MachineClass->init() function instead,
i.e. guaranteed to be only called once in the lifetime of a QEMU
process.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250117192106.471029-1-thuth@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b46975c8a4..85b8a76455 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1241,6 +1241,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
+
+    pcms->machine_done.notify = pc_machine_done;
+    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
@@ -1714,9 +1717,6 @@ static void pc_machine_initfn(Object *obj)
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
-
-    pcms->machine_done.notify = pc_machine_done;
-    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 static void pc_machine_reset(MachineState *machine, ResetType type)
-- 
MST


