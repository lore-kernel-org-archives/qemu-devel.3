Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8567FC55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqwAQ-0002jM-I2; Mon, 03 Aug 2026 13:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wqwAP-0002j7-0S
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:09:33 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1wqwAN-0002v0-0n
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:09:32 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ca80d708489so80788a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785776969; x=1786381769; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HToaX+isloW5Su/GMIByyeFd2LWF90rLz/Q4Zq0AnFg=;
 b=CueBYAZav4fURBj+ciHfirASSwALynGj5DUQJY1dHKmDNdZalYqWYnxKQbv3suq1wY
 zeUvITEXLciSx2m9hWcj6WTKl3kdOTWJRq2A2gNKoXz6O7M7pIg7pSTOeCPkyqy5RjSp
 l649Q8qX/Pv0tUqtZ1pw7rZ4uTykMXQykXy+rHE4SRL+OYPnwBrsaasqEIAACU8cEb+7
 Qbcb8+c2bn7hLB0CQ/jNl3WqroL0BCS6wIjLhn6qhTKohqg1pTRal6nZZOElg4of+qGP
 tYQH86mgPgBF3YM17O8PX9RwBN3jtsTpUAW1S+Uf0B4wLzyQnwZrCzkZjfjUlFW7HS/I
 EL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776969; x=1786381769;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HToaX+isloW5Su/GMIByyeFd2LWF90rLz/Q4Zq0AnFg=;
 b=E09ll6cjQ+6v3EJQTc0yAynJSzkFJw/lGXO/pVmhpgzl7/qFlzpXYPz0oJ88rSY/Xa
 KyNO0nBM41B+7OPsPkC/PqPHxnthoIYFeI3SCJCi70zr6m/ui/EPJzUFE+8iLbffrkk1
 qbZ7hhdaqQ1A+XntXYIgxSeKCjdK+KKCSna+ZOA3ZfE6lz+HqDCvluk1CGxhz2CYNLPW
 UcFTK1CohO+eLEiHl5GeXEZ/MTAc1wOHD8uCntZi4w9uQrS15Y1PaQZ9nCfS7Cz38m86
 uOXjSFko+Q40GDeSzx/4G9HLB8a7vtpUAhF8h7g+UmdZvNdfzvjiJlG5vdqRR2qpINxg
 eVfA==
X-Gm-Message-State: AOJu0Yy06pIYzk02Ts3IUpcQ70MF3Sj+lgGi5SaltU9Erdu9FeYs7aKY
 +q9U4Kg/PN9O8pppbyZ3qKpATHJpgpiuazFTOcdAxdDAyyuGRv23m6hO
X-Gm-Gg: AR+sD13u2Ramtta6VkqQMU7OcSB4Pzw3ZbMedTMtpb9HIlUx6Sr3sLE1yUdDEcNszsw
 hGsok1LowtRKQNSEwe/3xy2DRecLo78FxVFD16kJwAQHvJrSQ3St22TZ155j4TyjBPTKFL9ydRQ
 hGmwntq4S0i1RBmefM7/RNRCd79UcGE6zHQjVly54ty7L7qgeTyAG6n3LNnz6/oSaVlBo2opUQY
 h3iamLbqKb+5CY9mT33eam56/+Y/VIDYXt5dUPSpglGi6EcujFjRJYMb1UbGGw7cE8Dov1oBbr3
 qOWuLwWbQtuQkvuHniglZTukI6/6AfFnFvfyum9FjAJpsjDvCtdr9PEzLs698w2iNYGSNPK5v1D
 MwU1HZ8kVfvhhxhq1uueRhNqx0riprme8a0M5TZqepeMNAGCagsrnfBSkgfeT9ptYhHfLaM8MxP
 B0YAKJDmK9noDZmOEkTc5W/4AW2mdwjGKJcJtXTLYFPx0xrKv5fWAN/hNIxdJAvJGHgOgLufYd7
 2j88KbL
X-Received: by 2002:a05:6a21:1391:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3cb6c7f4960mr398350637.13.1785776968950; 
 Mon, 03 Aug 2026 10:09:28 -0700 (PDT)
Received: from [127.0.1.1] ([49.43.137.199]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06fe9fsm37193405eec.25.2026.08.03.10.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 10:09:28 -0700 (PDT)
From: Ankur Saini <ankur98saini@gmail.com>
Date: Mon, 03 Aug 2026 22:39:21 +0530
Subject: [PATCH v3] virtio-gpu: reject requests with short/truncated
 control headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-virtio-gpu-short-header-v3-1-936c1daa8e61@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNTQ6CMBCG4auQrh3TFsKPK+9hXIx0oJMIJS02G
 sLdLazYGJfvl8wziwjkmYK4ZIvwFDmwG1Pkp0y0FseegE1qoaUuZaVriOxndtBPLwjW+RksoSE
 PRVUiKoNUdJVI15Onjt+7fLunthxm5z/7o6i29b8ZFSjATjUo5UNJaa79gPw8t24Qmxn10Wl+O
 zo5qpZ5iU2lE3d01nX9AmYEVSQGAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785776965; l=4987;
 i=ankur98saini@gmail.com; s=20260728; h=from:subject:message-id;
 bh=W11FG/ccdeQxgzPgSlNnBqK9L7ctUyxmKGN68cQ1oNQ=;
 b=DQgW9AbGHIjZKJC6Bz68bhPuuSE3Yfz87w1RyrDGbqCVnDWw38+NiR9shGETpsi8xrvG1/bBu
 R6+4S1w8GDQDOUHUt8V0jyT0xhytisIjobJDiopeUiPKQ64ZwBsrpuV
X-Developer-Key: i=ankur98saini@gmail.com; a=ed25519;
 pk=fiA1ENLrWfuTIKes9f/fn/hIbq1fqEHYxopa8LdM/8s=
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ankur98saini@gmail.com; helo=mail-pg1-x535.google.com
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
leaving the malformed request without an error or completion. Make
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
Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
---
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


