Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB371C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woj4r-0005Qj-CJ; Tue, 28 Jul 2026 10:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1woibw-00085I-D4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:16:48 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankur98saini@gmail.com>)
 id 1woibu-0004pC-R8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:16:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so2719317a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785248205; x=1785853005; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U2zaWvTtl44HTglvhMoWXik3ygFdc89/lqZhyO6KZ4o=;
 b=fmdlQR1EnIE3B+zwkQmp83zy+hXvADD9xWkYqIS2ASfRoJY+E29cvEy4FmBGjtTSWi
 dwRq7DFOfnOl5KFfNSv0eH5zbFzbEiJbqY+iuQ4ndQtDPIBwXTaob4UrDLC7+XJxKRuU
 gquFCRriNlRUTN7am+WzKLd6OjbcX/cklYVVokWOSPcqDSeSX6j/QiHxVkvyXk60Ksas
 KGgr/wC2BGeldzprWU9QxWmyrFQkXWenT1wFGYNxTBJ3e3uSAw38ohjv6DM/87BFjFo9
 gXBNB/I1jgbw57JzMdR4vQTz0gRhzxHirMlO3PqDRXK1j/DeQcRgmfugX0RCrE+AZvwo
 nIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785248205; x=1785853005;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U2zaWvTtl44HTglvhMoWXik3ygFdc89/lqZhyO6KZ4o=;
 b=ilczNTZ95qk7YdcTpxVhdpkRaDvikeMDwMwHnM7CzkSSz+KNiW+v/q6Qu5StvL+sB5
 vEu7KFJjtsOUioGGokgzcgQ4ccIHzpb4FEouHF2007L6lViFYxnuJt40PxHQKB10UG2/
 iqz6/BL8kzo3Vu8/nHBkdrs+0laoWIOHc+DCVq4AS825MGYs+1copWwgig7abQuSpCY0
 /oi6Jn4hHdzHexnki81msmzs0ei4eyob14O/igWHkF2nT/80FQP75WTr3mKuRzl7uUUy
 TU9xUGr1DDnbsUvzbhb9Dh/rYfW5Ms/46qEPgVub4FuXyNBePbYGY7CiaesWU+ax+Xpr
 8PoQ==
X-Gm-Message-State: AOJu0YwT+CO6PZUe+8b4JOUO5JzVgdg7/QkhvbMex1Q0K7I5rsrajtWy
 aFCSHk+c59yxVFmDISyZCwASvJorF90koMjwWYm0cROZznNOH1kckGLanMZCpxyj
X-Gm-Gg: AR+sD12BXC58HSc2OLFfmfRh7mm2OVjmY71JFcpN29zJtqxRbXKkWe1vnOcUWSGbFBI
 yx7CZee5dBNn7JHzoU0XirvqTcRHlmKHT8+D+lx2zdVgictXnZc1jTm9h7u1Q5cXTXv06HITd/L
 updMp/ZWSRGWw3cjs/Mpr4TOPjiS30C1FdbkGmufAXtJ4s9IT/AIcjv8cFDX2UM4/jINfzN9OCj
 0o1vsBGEdUsRrrRdBSyL68dpulbp0De6+hrIiwSk3PvFJUh3vw/SNduFco3GbHj84J7/f2EIL1F
 5dpx90vCnuTHIsKbqkzMsBEPcBgBLjwwf5782+/KLkugqHZN6mQytmG0ml4KVTFf2iJlTBvBn9f
 hWNtPYQI5xstHJ07LQoB0Mt3eZDv2BHlnqnMbbKr4tx7DhC8eA5wcP/dP1cvhSqJ5hMO02VL/lL
 eXbndsvoshVV9t+ZJ24FdbxQ==
X-Received: by 2002:a17:90b:6cb:b0:38e:e0b:320d with SMTP id
 98e67ed59e1d1-38f6a480a61mr2844239a91.41.1785248204865; 
 Tue, 28 Jul 2026 07:16:44 -0700 (PDT)
Received: from [127.0.1.1] ([49.43.137.199]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc413766sm45998740eec.8.2026.07.28.07.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:16:44 -0700 (PDT)
From: Ankur Saini <ankur98saini@gmail.com>
Date: Tue, 28 Jul 2026 19:46:26 +0530
Subject: [PATCH] virtio-gpu: reject requests with short/truncated control
 headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNaxIpXEYdg0zaLlVRFkN7d4
 viG/1/IrMIZ5uYF5VuypL2ibxvYIu2BUVw1mM6MnTUT3qKnJAzHhTkmPTEyOVYc7EjUO+LBW6j
 1oezl+c/LWsoHVf5LamkAAAA=
X-Change-ID: 20260728-virtio-gpu-short-header-476aa1dae4f7
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ankur Saini <ankur98saini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785248201; l=2028;
 i=ankur98saini@gmail.com; s=20260728; h=from:subject:message-id;
 bh=qIndgFbaTJljNIzm/aezZhwlfPR+k3VUJ5+5SD8sUjI=;
 b=tSzKEL36AkFeodx7ZrcwAfiJshueff6QoTSW0gR69VBK97pWFnp3ltpu+yDX5KvFQ95loLXj4
 zryVNmARLhODkBi+NtIzxUzhuuTVHaaPG+ub1FATGV3LQk6wB9BIIJw
X-Developer-Key: i=ankur98saini@gmail.com; a=ed25519;
 pk=fiA1ENLrWfuTIKes9f/fn/hIbq1fqEHYxopa8LdM/8s=
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ankur98saini@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Jul 2026 10:46:14 -0400
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

A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
partially initialized. If the supplied bytes set the fence flag, stale
fence metadata may later be returned to the guest.

Validate the common header length before dispatch. Clear cmd_hdr and
complete malformed requests with ERR_INVALID_PARAMETER so stale fields
cannot reach the response.

Fixes: CVE-2026-18054
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
Reported-by: Ankur Saini <ankur98saini@gmail.com>
Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
---
A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
partially initialized. If the supplied bytes set the fence flag, stale
fence metadata may later be returned to the guest.

Validate the common header length before dispatch. Clear cmd_hdr and
complete malformed requests with ERR_INVALID_PARAMETER so stale fields
cannot reach the response.
---
 hw/display/virtio-gpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 4d46a4eb10..15a845eff6 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
             break;
         }
 
-        /* process command */
-        vgc->process_cmd(g, cmd);
+        if (unlikely(iov_size(cmd->elem.out_sg, cmd->elem.out_num) <
+                     sizeof(cmd->cmd_hdr))) {
+            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
+            virtio_gpu_ctrl_response_nodata(
+                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
+        } else {
+            vgc->process_cmd(g, cmd);
+        }
 
         /* command suspended */
         if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {

---
base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7

Best regards,
-- 
Ankur Saini <ankur98saini@gmail.com>


