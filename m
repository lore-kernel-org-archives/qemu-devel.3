Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F58FEDA04
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z2U-00013o-3y; Tue, 17 Mar 2026 14:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2R-00012p-FC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:07 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2P-0002sT-2d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:06 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so5479869eec.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773771662; x=1774376462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQQWpfCkfhdY6LwJcgzOBI0ARhYIsLB8CNzLDt0g+Qg=;
 b=hTnvDrt7W2yilqo7pHolCWe7iUkgobSNgHpJ1Qb0VJjd3COGH/pxJMyx8hIRhUM7Hg
 ueOO5ksklyF4kHYyr02uRFhhKoRCWFIeWALdXB4a72bAY5Djapi+0rW/NItKTKBvooFc
 kVXSVmgXYDCuLLq2b4PzDkZkVWqqGHOhXNzkQKfLPG3uyGqJg3OYpeNni+dXI978Oy1j
 ar0ChjACt0G8/BXC1290pf3zawPsrp1vxUDzITpuT0Ln0f7yMwaIsZ1MCoVgTZ0cPC2z
 Td0wy0m7lGzpYmcv8v7tP96pntGepJE84PtW+t5JVgNTAqjA4Buzxo8Rc1ZBtvmaioww
 9KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773771662; x=1774376462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GQQWpfCkfhdY6LwJcgzOBI0ARhYIsLB8CNzLDt0g+Qg=;
 b=pXGI8oTYXDVMZEtswFTm29MBClhvf1NZizcLfvHVOo3oI6a4fJUAQQZmF+Lx4IUUL7
 lANJkJQTF+JWJVPxGXTwWcZsyJJZkNY0fmpqOptIFZ4KdZHSicRjVSPYwSxUa5a8qcQP
 L2Ub2MRjdWymZOxA4OopidT+2vv1/EfxCjnEQhZvhecc/YV2bwiqlUzIR8UB9vzhrEUW
 ZzXrIWuit+XlpJVawKZJb8lxsszp95Om3adtZqL3R0Gb2iLLd2ZIPtXow/TjcIZGgGvc
 p30sALvr7I1p6GqK3vTuoFAHDmcrv0yC8DUvWR3tGl3WFYFJWIDzC75PbfdAOFMUXuOD
 DCAA==
X-Gm-Message-State: AOJu0YyveRPV4yiSxsjVsDjPmaWjRAvTqLivTeG5bVQo6+JhXjVCbMzf
 1iL1vpSl0/STl0YaQZ6LnUoQaLCjtR+FyhRUKfSLVAOQk6BBSajPpxOLt1hDt08V
X-Gm-Gg: ATEYQzxskr0fpd7EyZAdfJbBv8SQayYjX51kajpM9oQ+et0QqxtGkHhTGMn14TI1DPC
 Z/yN3rjvgg/TLLEDYkzHlwefhO7chrgz5hvluiJPHDUK5tzP0hhsZSs6u7Zn3TQW+ybRAeWXl7a
 DFHVXgBaqDVWanRwiC+x0A9thAsCy4QOYnxj7eiwZj8/k2wsIMzQXJU+Oi+XRTEVTSW66Gt6ndG
 6+XviFpEAwjJ5V0rFx9E/z7Mg8W2a1adwH1BTn3crppGNca6lHWsqqSgS0iSh5c5jMcZgq5kahi
 /9vhcDBJf+q4OPKlz2VS6mCyCJtpgRrFU8TxPbzVE4mahAhWQDkBYiV63jikjX8TFkXjdQGxe+a
 7DzASyBcGueBgP7E6o/nFlbqNRYWrWCaaMk6LpE4cLgSLvcowtUa+rLpCDDIA6FPH1Rjq6ea8kA
 J2no3pkH3BAbAac6+vpcXEbINPv/aK8GtRUMHx1VV/3B2pzM7GaIUI+7vtNgk5mXE=
X-Received: by 2002:a05:693c:2801:b0:2be:1f56:ed21 with SMTP id
 5a478bee46e88-2c0e4f9a462mr112365eec.7.1773771662491; 
 Tue, 17 Mar 2026 11:21:02 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e55a53fcsm457367eec.24.2026.03.17.11.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 11:21:02 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, visitorckw@gmail.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 2/4] virtio-gpu: add VIRTIO_GPU_F_BLOB_ALIGNMENT header
 definitions
Date: Tue, 17 Mar 2026 15:20:47 -0300
Message-ID: <20260317182049.33848-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317182049.33848-1-lucaaamaral@gmail.com>
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Define VIRTIO_GPU_F_BLOB_ALIGNMENT (feature bit 5) and the
blob_alignment field in virtio_gpu_config per the OASIS virtio
specification.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 include/standard-headers/linux/virtio_gpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04..252704e7 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -64,6 +64,11 @@
  * context_init and multiple timelines
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
+/*
+ * VIRTIO_GPU_F_BLOB_ALIGNMENT: device advertises blob_alignment
+ * in virtio_gpu_config (OASIS virtio-spec feature bit 5)
+ */
+#define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -365,6 +370,7 @@ struct virtio_gpu_config {
 	uint32_t events_clear;
 	uint32_t num_scanouts;
 	uint32_t num_capsets;
+	uint32_t blob_alignment;
 };
 
 /* simple formats for fbcon/X use */
-- 
2.52.0


