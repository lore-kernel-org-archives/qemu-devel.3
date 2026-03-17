Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E81FFED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YZ6-00064w-N1; Tue, 17 Mar 2026 13:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXt-0004yv-P3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:33 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXs-00079b-9N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:33 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1271195d2a7so1196498c88.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769771; x=1774374571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQQWpfCkfhdY6LwJcgzOBI0ARhYIsLB8CNzLDt0g+Qg=;
 b=Xf/hqRvfyGQU15sCBNIZMp9Aln9uYj4cYLUMpbuFQmOMxk2DltGrpaxygAZhxghMUR
 eNQ5TLuq+VHXOt0idS4BWN2M8yQycU4qA0vZQxFs3v2tg7pXZIXMowj0bXYk+zHD7roC
 Xc3J8Abylpyh3L0MvXLdRrAQaEiE2U0bcGQmhbVxVwel+wkWiaMaECsk7zcv+J3r77bf
 97Cd/gpBYWgZjpphL8rJjUmoqRLdsXwIaovE5iCyB0EZlto7aegc/GFVJDG8cRaF+NES
 CZg1Uvh15bl9B4VYm1diYBA8qvqm380LeL4Ed5cHI+oZR71XIR4pMWKZmMHiCa27sP+3
 3UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769771; x=1774374571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GQQWpfCkfhdY6LwJcgzOBI0ARhYIsLB8CNzLDt0g+Qg=;
 b=GHZXzFiia5hHXB+zku8zHnn830N5H2kdRsTjOoWc5DJAq0GkI0KJWHb8FriHNuURGQ
 u2M82/fDpXpvThzdCYkH5nOWDPBZKZxNVvTGI5zHV4uGPTN/Hk8EBw92M3NNvgUqd35Q
 u1kL3Kr5eJea1SQZxoP6njtmhAcdUshSPabWgq10JsQY0ALDDiKDzZiLZg0zPsjjG52e
 TqxIAGrQ29p/IhvopuDG5lupwSO2qsdb0A/Q7HWFMg6JD+M+vqV5VKiHpDxIAMLXgNw2
 /YsDO1Vb2ho/HYx4pEYmK1aM440nHppHsM3ty6V7gS7lWhNTSkWQP9R0K3ikwlk29HZd
 BKJw==
X-Gm-Message-State: AOJu0YxZ7baYRPUraq94Eb3podvuDsPyBnJkCsRu3NDAZgFqU+yqBUUZ
 iBShdqHUz6fE/hlhgX4FGCen1yyQ8K7XbiHFalUAvTfMZLNYdoM92u7vePN/fHdy
X-Gm-Gg: ATEYQzzIZ89Jjqx72FlISaTQbjZKXPwqH5l5mc86hyKcod0IR/Mt4aT+r9kThr/Xt0u
 bK2MvCsUEKVl8nVJy76Y/d5GrolGE4/ipkcjnNrvixpqQytLB9V6XPEFeGMJUHirvH9CTcag6QT
 etpR3e6IUcRQvjqahkTMexkYm41iDfMk0UZQoxjuIPdM+IkbXLIOn9PH+0eHnvanlyVRFI1YITg
 8mRUPrzcwCsYFnH2BXghXtn4SARF+p4w5OJbp5Dsow8tlddKLTEPMgYMEcMPDOI7hiEamoYJs/h
 DFJPMBwyfm0UziHlBjiDBCITs5KOD74Cg7Hi0CfJbW1d9bwFfO6eEKDlPN8lKM4mzJoejc0VqVW
 iWwaYqqdTTZ3LN/bpzjMo4Rif/I3t4Bz5HdTHw++npzLcvBcGi9zQSwwzaFOhxu5EJEyIVuhW3j
 1Kk6ShWsK/ysvB8LacbnzAeo0DFGCYK7cfD0dLDjepe5l7NU72qQBu
X-Received: by 2002:a05:7022:394:b0:11d:c91e:3b58 with SMTP id
 a92af1059eb24-129a71b0413mr185894c88.39.1773769770357; 
 Tue, 17 Mar 2026 10:49:30 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e536896csm282115eec.3.2026.03.17.10.49.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:49:30 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 3/4] virtio-gpu: add VIRTIO_GPU_F_BLOB_ALIGNMENT header
 definitions
Date: Tue, 17 Mar 2026 14:49:14 -0300
Message-ID: <20260317174915.31829-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317174915.31829-1-lucaaamaral@gmail.com>
References: <20260317174915.31829-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1230.google.com
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


