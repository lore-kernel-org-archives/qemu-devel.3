Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F948C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9X7-0005Gy-0C; Tue, 04 Aug 2026 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wr9X5-0005Ga-7a
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:25:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wr9X3-0001vF-C2
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:25:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2caea3f742bso44611895ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785828347; x=1786433147; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=doSwJYNXHGRfqo8yGRfgLn5gQApsrMjXu3e/tvKuYh0=;
 b=PumUQmRQlIabZ+ldk3rsM1m4Al/4+W355s2OUfPVxgMvEFhjsFrSALDkgg11Hg6nsP
 eapvCG6jGLgkRZO3+zU1Ye+v55riSC7zARoSMw551bpndCgHdWnIJ9a/SwY2s5nP/Uis
 CDx5anxcrMeQq5aFnsWxfjRZg0VwTHuXYFJuJxsK8Eo41LCIe96ITBbx7IbTWxLNvtHj
 K6jVZr3wN97pskHZHhGXFMGwq8l3Tr0yoWdPyESF06NLO66DyJYAVnIAV5p4Ng7vj7GX
 ElMw224+TsRcoycvGz3AFBCkotlDlNFEe51TNEvoQP8w43CzUZfBHzbZ27KP1DpEKBpp
 0nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785828347; x=1786433147;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=doSwJYNXHGRfqo8yGRfgLn5gQApsrMjXu3e/tvKuYh0=;
 b=DL0Ahk5FSVm/oG93pTSdnkYjNgPj0t29E/0PxJlEMkYMFzwP3Iql29QYreNG30ECVO
 4D4vxP4SunK3NfvHlygVJWsZ0PcsIQZTbJ0mOoTAc2JIoOfPpNdjPfkuYgyO60HlEBDc
 9tB4R7kfdAZncD4oSO7ubFZmLnE8NquWNNWnV37iDqvl+KMcTn7kfTDygS8QbhkeNiUE
 3ygQfadWqd849WKxky8v5sLeXlI4hO7rEOe4y6CaWNfJTtrOy7qiVe8Mc0cDTTi5wPRK
 y4VmijidgLmiIRPk69jHoVQhWPTTq8fTyYtc995aeL+XEyKc16Kubx25qK9OIC8sYB23
 s5yg==
X-Gm-Message-State: AOJu0Yw3BKOPD85i+5XLzc3UDXcXoXLTrbvAoNS6W/eBOBbVw9ZyyPHA
 Lwo03EMreW8B/4cPjkg3sWhl5bIT+//F8fbVVMItuc12DUHVb0XYph9P
X-Gm-Gg: AR+sD119Qem/J2Z0XapQxKfHkbJawntTFfu4E6cE4qwo346KuW9T4w7/VZDuHfRGW0Z
 dJMwOcOZau+Qs3SQO1OZGt0jTr20vqdfJ0DzZhEu0fze8+5Me9nJCzUaXwxNdxZ82mvmVVUVgFl
 YCymgaKsy5YqG8QD2NV57cXYclKZmtLf09dXVhuOoP5lzAPV2SdqTVmw/DCr+KKdZKtg5/hVjsw
 Xk8qU/0X++VkWtROmFMnH9jsSSuUkCeg56yeIuwvMnmxntDVgl4Kvh1bXz0Y5x7xnZFz5eH7qrD
 3JML+htOTYDbemNII+qoIDGm71a83ks6KILe+rQ3sfXxWku00OCqnPJTWACzxLnl32rIldY4ndf
 IspLBkG0NLGp4KAHoaSIWKXQcWhoz/7H3RasL1lSQr6XNbPO0VbUXTQFbU+hl8IZKciB79EIRXR
 fNnNZLau1Sy1BXkQvHP3wZHiDAOoDxLuHWJDzeuEKTf1K6MId+iEc2YQ1+s8BSrw2ImQIUb1Cea
 dATIBw6gkJMtE8VBNXM
X-Received: by 2002:a05:6a21:6cc4:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3c92a4c4549mr12921807637.2.1785828346838; 
 Tue, 04 Aug 2026 00:25:46 -0700 (PDT)
Received: from [127.0.1.1] ([49.43.137.199]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158678ec37sm1170997eec.23.2026.08.04.00.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 00:25:46 -0700 (PDT)
From: Ankur Saini <ankur98saini@gmail.com>
Date: Tue, 04 Aug 2026 12:55:32 +0530
Subject: [PATCH v4] virtio-gpu: reject requests with short/truncated
 control headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-virtio-gpu-short-header-v4-1-b3e30a81e347@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPwQqDMAwG4FeRntfRVqm6095j7JBp1MBcpXVlQ
 3z3RS+Tgez4h/xfyCQCesIgTskkPEYK5B4cskMiqg4eLUqqOQujjFW5KWQkP5KT7fCUoXN+lB1
 CjV5muQXQNWDW5ILbg8eGXqt8uXLuKIzOv9dDUS/T/2bUUktodAlK3bRS9bntge7HyvViMaPZO
 uW+Y9jRhUotlLlh7tdJvw5v7TspO2VqK/4TCrR668zz/AGzH96jTgEAAA==
X-Change-ID: 20260728-virtio-gpu-short-header-476aa1dae4f7
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Ankur Saini <ankur98saini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785828342; l=5428;
 i=ankur98saini@gmail.com; s=20260728; h=from:subject:message-id;
 bh=GavOz8unD44YHrwDnmuR9qdr/QDj3La38GjPNZkKj7w=;
 b=/frHavuZgnp4jf+aFXBLR96X/6EiIWB5xeK5+iczgpwz5i5xHtas5m3xFJkRpKb1HUBdSNCQ2
 qz9eQboOcBQB6Jf0+EjJb93m35NFydeDUQKi4KtwqfV1mCrLutg1Del
X-Developer-Key: i=ankur98saini@gmail.com; a=ed25519;
 pk=fiA1ENLrWfuTIKes9f/fn/hIbq1fqEHYxopa8LdM/8s=
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=ankur98saini@gmail.com; helo=mail-pl1-x62f.google.com
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

A short control request can leave command data partially initialized.
For the common header, guest-controlled flags can then cause stale fence
metadata to be returned to the guest.

The command fill helpers detect a short copy but only log and return,
leaving the malformed request without an error. However,
virtio_gpu_simple_process_cmd() and vg_process_cmd() actually complete
it, though its response type is VIRTIO_GPU_RESP_OK_NODATA. Make
VIRTIO_GPU_FILL_CMD() clear the partially copied object and complete the
request with ERR_INVALID_PARAMETER. Make VUGPU_FILL_CMD() report the same
error through the existing vhost-user-gpu dispatcher. This also rejects
truncated type-specific commands.

The vhost-user-gpu common header is copied outside VUGPU_FILL_CMD(), so
clear it and complete the request directly when that copy is short.

Fixes: CVE-2026-18054
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
Reported-by: Ankur Saini <ankur98saini@gmail.com>
Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
---
Changes in v4:
- Correct the commit message to note that type-specific malformed
  requests were completed with VIRTIO_GPU_RESP_OK_NODATA.
- Link to v3: https://lore.kernel.org/qemu-devel/20260803-virtio-gpu-short-header-v3-1-936c1daa8e61@gmail.com

Changes in v3:
- Handle short copies in VIRTIO_GPU_FILL_CMD() and VUGPU_FILL_CMD(),
  also rejecting truncated type-specific commands.
- Clear partially copied QEMU command data before completing the error.
- Keep vhost-user-gpu's explicit common-header check and drop the
  redundant virtio_gpu_process_cmdq() check.
- Rebase onto current master.
- Link to v2: https://lore.kernel.org/qemu-devel/20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com

Changes in v2:
- Also reject short/truncated control headers in vhost-user-gpu.
- Expand the commit message to describe both affected paths.
- Link to v1: https://lore.kernel.org/qemu-devel/20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
 contrib/vhost-user-gpu/vugpu.h          |  1 +
 include/hw/virtio/virtio-gpu.h          |  3 +++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index bb41758e34..8149834745 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
         if (len != sizeof(cmd->cmd_hdr)) {
             g_warning("%s: command size incorrect %zu vs %zu\n",
                       __func__, len, sizeof(cmd->cmd_hdr));
-        }
-
-        virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
-        g_debug("%d %s\n", cmd->cmd_hdr.type,
-                vg_cmd_to_string(cmd->cmd_hdr.type));
-
-        if (vg->virgl) {
-            vg_virgl_process_cmd(vg, cmd);
+            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
+            vg_ctrl_response_nodata(
+                vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
         } else {
-            vg_process_cmd(vg, cmd);
+            virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
+            g_debug("%d %s\n", cmd->cmd_hdr.type,
+                    vg_cmd_to_string(cmd->cmd_hdr.type));
+
+            if (vg->virgl) {
+                vg_virgl_process_cmd(vg, cmd);
+            } else {
+                vg_process_cmd(vg, cmd);
+            }
         }
 
         if (cmd->state != VG_CMD_STATE_FINISHED) {
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 2374eb90cb..aaf2870cb2 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -179,6 +179,7 @@ struct virtio_gpu_ctrl_command {
         if (vugpufillcmd_s_ != sizeof(out)) {                   \
             g_critical("%s: command size incorrect %zu vs %zu", \
                        __func__, vugpufillcmd_s_, sizeof(out)); \
+            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER; \
             return;                                             \
         }                                                       \
     } while (0)
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 2f60c72078..f965defa6b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -315,6 +315,9 @@ struct VirtIOGPURutabaga {
             qemu_log_mask(LOG_GUEST_ERROR,                              \
                           "%s: command size incorrect %zu vs %zu\n",    \
                           __func__, virtiogpufillcmd_s_, sizeof(out));  \
+            memset(&out, 0, sizeof(out));                               \
+            virtio_gpu_ctrl_response_nodata(                            \
+                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);         \
             return;                                                     \
         }                                                               \
     } while (0)

---
base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7

Best regards,
-- 
Ankur Saini <ankur98saini@gmail.com>


