Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B44FCC067
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDS-0006J1-PC; Fri, 06 Mar 2026 14:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCW-0004Ep-HK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCT-0000Sl-Nb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:08 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so4263645e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826662; x=1773431462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8nF3OjA0ZKOuKtYP366/rOO+hCQVT28eX6+4MbMNiM=;
 b=iaNlHfdUHsAPnzMe8/Jrf25Qfye9EvYBVKz+WjuD6lsLqrTq9SMtjqrVJ9MC8meTwY
 7iauw0l4dTLxTJlSh54iklFcs2WsmGPevDwoV9U6aX4VFeI4hfJWu8p8N9d8Xk7Miuxd
 IongzbFjgzm2A5YhY+23Rd43JT/aLgKARXyr8J4uBM3OsnPTHB9JjoKWgYqHEC42AdTR
 zPhKprKOR2lKFuO+MHWX2afzIYaVeuPctzQSgaKDaXeyfvI0nDIA37Q3Ia/d7qwvUPcy
 DlGQ1AI5N7myLKI+14nOjL5QgKOGuP6JZItCJd3MGCaG6SpxwR+7zxpPFJWRevt0wkG9
 q3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826662; x=1773431462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A8nF3OjA0ZKOuKtYP366/rOO+hCQVT28eX6+4MbMNiM=;
 b=EWSFp+O4nKylHEzY4F5Xdk6YHfTKwWFcxUCCIizcr4+IBzmGVKPP+GxHOcvL7TJRos
 izHy/d3Jt7yiagZ7KqyT7QDqcs1NEfreZPlTsT2agPf06fjXBQyg85k8/KiCai6GFmES
 9MySUcVPXUKiOutxDJNvrwi6pGiuf8LTr5mAexnqHORCoi5xuH+lWZy/YV5rBv9BeG1C
 wIxgDs/HGYIVru7kcxlkjFxQjwSBZlyBrfBN9KKOp1hTHQ077cr2a8Dq36soMKMEEODu
 TXvUxe92kOwCRHGTIt0j8UaxMfPIjgem0fw7KDLeh582xW+2/gVYtQeohmvh4mNt2yCZ
 smyA==
X-Gm-Message-State: AOJu0YyLU0bWpFEpUQQtrUFhRl6oZHKrxHdp5OOW5IoAoVpdQQFCRair
 lD1uzWPPoH5kWxNaZz6FNtrOoF0Lj0kqhJb+HAhQORfRyazZOaxqDdNZAmOVBXOK6IM=
X-Gm-Gg: ATEYQzwznhuDoB3BH7rdodJWlPYzYzWaQpr6stirzx2aXZrmHBlH3yeYxm4nxv78aDP
 FQYh9Y62oFSUhptTVH/mAxdK0OtnAyzGhW0LvpoVFMvXcvSO5xhc/m/sPEEggbfM4hAwGEhJ2E0
 QUA/k5DQsaf5y+uFMgJgxsjvleaHhRIUkkaBTFgohFRXjGXswcbiq17IU8vlItR2u+Wu7ER25sr
 TTa860yxtvikfUXwMfLDskYtDpDbdKSUP/h1T7AL5GiUtJWWaBG2jL9ws4rw5lSf3sqoUv5g9ta
 +9DbIKcHpYYzWwF+TP56+O4MoSn05SKNcCnh5la7MxX+4heYVAnbSza2866cI86xE3QfKTTly+/
 aemn/VjNYfn8aw924aYHpMj0X/F4MXFVYimDRCPwCLbsZZgBd4qm0NOW35ew5zs0WYMsfcRZTFa
 ZsZNyheBJ5cO8ObaH7nYZEmWc=
X-Received: by 2002:a05:600c:548b:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-485269306b5mr59099725e9.10.1772826662140; 
 Fri, 06 Mar 2026 11:51:02 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852ad0ce60sm46296695e9.12.2026.03.06.11.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:59 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95737689E0;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 17/20] virtio-gpu: Validate hostmem mapping offset
Date: Fri,  6 Mar 2026 19:50:44 +0000
Message-ID: <20260306195048.2869788-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Check hostmem mapping boundaries originated from guest.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-16-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-18-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index abf7c176a65..f4d1113827e 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -791,6 +791,7 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
     struct virtio_gpu_resource_map_blob mblob;
     struct virtio_gpu_virgl_resource *res;
     struct virtio_gpu_resp_map_info resp;
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
     int ret;
 
     VIRTIO_GPU_FILL_CMD(mblob);
@@ -804,6 +805,15 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
         return;
     }
 
+    if (mblob.offset + res->base.blob_size > b->conf.hostmem ||
+        mblob.offset + res->base.blob_size < mblob.offset) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to map virgl resource: invalid offset\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     ret = virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
     if (ret) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-- 
2.47.3


