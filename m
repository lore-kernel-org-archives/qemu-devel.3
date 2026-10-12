Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB422CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEeU-0003gW-Rk; Mon, 12 Oct 2026 07:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdx-0003Sl-TV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdu-0002M7-TW
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a02753c04fso9359695e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806193; x=1792410993; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3qc+m3TuYOGQD0I78puHWALWD7CmUetuHlHfjJWUiIg=;
 b=U+yFZOJD/Oav4ljZLwA3tLO/hpcLU4c8kqp3oNLm1ECfX6E52Im3ExZf9kwlVwM32d
 xMONE/fktBr3xfMZic6ZmzP4PQxu40VIQKpSUcdEUNgvWImzznm+ncmTUAhkAKUrMgOU
 7XL45/RVmowGY5V4xpgoda07ktDZ+mg0R0rQw2kq1JOu8dmXEKBXikQLXN3hKAntqEjk
 gia2BE0G3cmLNHHro0Hvb+lnMj0N7VWvv+uHkSe6AQU+U/DiSElvGU0ZkvK25sFnOYXb
 tHt0/yb+DWaN6r6RpEErLzE/kams9HyR5QYqhV0AXeqoKb9VTSseCIhxuE1LUSS2cpez
 1CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806193; x=1792410993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3qc+m3TuYOGQD0I78puHWALWD7CmUetuHlHfjJWUiIg=;
 b=i7wyOLPpMZZersoaht1+On4EQtiaNai5xFD8+4v/FnZvmz9HNnRVo96HqcU3HazDrJ
 rVSNERcGyIoW+3xXthrpen+5G5WOvitoQv1bbFV8m8NNBBa9XnxoM0UMPTH4V3JDrGBn
 MVdnuelBOClNXwz0H1z/Rc7rZPpe3lua7ZixaXTKfEoGJJy8wkwWcWBN8FQiihHCm8vM
 WWs5JbBtiwpD1OCJ/Fn9aSWGNVPAHtwYiYH4THSEHU1OIVAa6sm3cKR0nSzP85/a3AEV
 BM0drYfyCQ+c1Lw/D3fV/ZfZ5QJ6hNQiaMVFKEXOJSR8lfB7ZGbO2dGpFTrPCIoaG9Gm
 5bvw==
X-Gm-Message-State: AFq9FYJfyKcnRrn/DQMbwHU1PB+ebw7bm7bNZUEEHsbYoBPj+CLeeHjb
 F7WO6tVxRGfVndnxH0dbnGurfmyHnBOcpmN+7qeFexMUWhi+jDVpADBw
X-Gm-Gg: AYBFou0mBG1IlCgz5njg2zI9OtlhSWd/2p/dHap6dWgGiUglxItBoogumtKPWmSIZHr
 F345fWW5gbyaNau53qTbhTLtZsIzRYt0wZUKAJS/k0m3nac6qbveHAAv9WDv8B2JJcwzu5MzQ/h
 2Q/j5LW6s4Ht9cG+1uPJ0K5m7fmtVnipJ+8aYUuRMhuZNL3cOFhctKnW9TyojHzfXYK+/mkhGKr
 NK7+XuAflS65ftg/30vN8ApFuyc8FLCo4og+YPpqYKfuwbtStehjSTndAkhLVXMffOIeD3i8/SX
 3frD1qWJUMOCxDSXGJ7AxUSRXI2kbwljHqRjbnOGy1B1U4WDhN6cFUqhBlyGRE7+0mxwnfYftDF
 D1mf1DZW9gK0zeQdsoZxQ8GtjtBXkB1vpg7qvsp2naflVvpVQL9Ol7fARcHSpTYjUl2X0a5F5sc
 v8RgJp3KME596H9TooacY7/wxi1bK3CeW1R2vbpcpe6dfZiTzPIZwJfjOdf+MvlsS0PmLLHDFW8
 kkIq6rLY2TvPe0D6ev9uINS6A8=
X-Received: by 2002:a05:600c:1909:b0:4a0:2391:6529 with SMTP id
 5b1f17b1804b1-4a18e4d3f12mr191103145e9.29.1791806193314; 
 Mon, 12 Oct 2026 04:56:33 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm530298455e9.9.2026.10.12.04.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:32 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:53 +0200
Subject: [PATCH v9 02/12] chardev: add CHR_EVENT_RESIZE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v9-2-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=8913;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=GU1RCEPjAeOZRrN0OqfylK7FcG0ExiEXC1iG5jiUuaE=;
 b=CNPxF4VBpIMN0coD/u287X1BN4zSWKOAkXZ/NrIsPPl7R/SJuC8T9itKmNzg2OIJ33rfOQE+a
 Ea/5i+h/RjHDExlenZHH0ozys8s4OEfChtHYWM1ie5REZpNEQdRdD3j
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Szymon Lukasz <noh4hss@gmail.com>

Add a new chardev event, CHR_EVENT_RESIZE, which a backend should
trigger if it detects the size of the connected terminal changed.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: add note that only the focused frontend gets the event]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 backends/cryptodev-vhost-user.c | 1 +
 chardev/char.c                  | 1 +
 hw/block/vhost-user-blk.c       | 1 +
 hw/char/terminal3270.c          | 1 +
 hw/char/virtio-console.c        | 1 +
 hw/display/vhost-user-media.c   | 1 +
 hw/ipmi/ipmi_bmc_extern.c       | 1 +
 hw/scsi/vhost-user-scsi.c       | 1 +
 hw/usb/ccid-card-passthru.c     | 1 +
 hw/usb/dev-serial.c             | 1 +
 hw/usb/redirect.c               | 1 +
 hw/virtio/vhost-user-base.c     | 1 +
 hw/virtio/vhost-user-scmi.c     | 1 +
 include/chardev/char.h          | 6 ++++++
 monitor/hmp.c                   | 1 +
 monitor/qmp.c                   | 1 +
 net/passt.c                     | 1 +
 net/vhost-user.c                | 1 +
 18 files changed, 23 insertions(+)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 3334e280a2..b0e325e47e 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -173,6 +173,7 @@ static void cryptodev_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/chardev/char.c b/chardev/char.c
index 9da0911e50..40d2180ce7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -75,6 +75,7 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 3dade143c9..1352a0cf57 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -441,6 +441,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 989b6f6ee1..acd754bcfa 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -169,6 +169,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 4737b9a56e..36ad2ddc3f 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -165,6 +165,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-media.c
index 851af8ddc2..3d76aaba58 100644
--- a/hw/display/vhost-user-media.c
+++ b/hw/display/vhost-user-media.c
@@ -241,6 +241,7 @@ static void vu_media_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index fa08ed6c21..bd7c61b2d2 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -436,6 +436,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5070178dc2..7687f2804f 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -225,6 +225,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 5ab7855272..3f4052ec82 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -323,6 +323,7 @@ static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
     case CHR_EVENT_CLOSED:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index b238cb7937..98d2abbd56 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -576,6 +576,7 @@ static void usb_serial_event(void *opaque, QEMUChrEvent event)
         break;
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index dfd9e8bb50..a666b1e8d7 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1390,6 +1390,7 @@ static void usbredir_chardev_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 1a377016e7..3cb59fc173 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -277,6 +277,7 @@ static void vub_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index c4692bd6aa..29d37716b3 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -215,6 +215,7 @@ static void vu_scmi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 6394ec2ffe..ee9f24038b 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -22,6 +22,12 @@ typedef enum {
     CHR_EVENT_OPENED, /* new connection established */
     CHR_EVENT_MUX_IN, /* mux-focus was set to this terminal */
     CHR_EVENT_MUX_OUT, /* mux-focus will move on */
+    CHR_EVENT_RESIZE, /*
+                       * the size of the terminal connected to
+                       * the chardev has changed.  NOTE: this event is only
+                       * sent to the focused frontend, so you should also
+                       * update the size on receiving CHR_EVENT_MUX_IN.
+                       */
     CHR_EVENT_CLOSED /* connection closed.  NOTE: currently this event
                       * is only bound to the read port of the chardev.
                       * Normally the read port and write port of a
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 488ec23937..7b80d84800 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1587,6 +1587,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
         break;
 
     case CHR_EVENT_BREAK:
+    case CHR_EVENT_RESIZE:
         /* Ignored */
         break;
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec0315775..eb44012643 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -663,6 +663,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/net/passt.c b/net/passt.c
index 45440c399b..e65198960e 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -428,6 +428,7 @@ static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 2d0fc49b4d..b849de92da 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -363,6 +363,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }

-- 
2.56.0


