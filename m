Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19861C48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpaV-0000jJ-QF; Tue, 30 Jan 2024 09:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpaU-0000ip-LU
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:59:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpaS-0008FG-S3
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:59:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e76626170so44756275e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706626783; x=1707231583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kOUOyWnXjxtmGnyfOcTT7YASioH+hRg6Bl9Wed5/ejQ=;
 b=y8/XbltvldIK6eeJ9+b3ENfJuWPH1ffGR0lVe13m8tMSFy1F4X9zqUPn9eQEf0PSf+
 WVWR7jUJ/l/0FfGCa6/rPoXc1VnX1vPsKO0JfZSmvjNq2ehz9gT5A5ZdPDmKEGy7M1zt
 0maSDXDulucJz1YEgzmNiZqRXF7xYPtw7E1EQhWGyx85AxPx91HV7BXvEWZ/4GS/DdYe
 lZFZWBDc1uSByaUhLj9P93yIFHfIB+65/5yrTMMXBqK9mQM3HBUsIJdGxYIocrzXd66g
 kXRTZAr+er8pkxeeqYK+t4TCLPI9uIXwQIEoZEooOf+8otWmt1NHkUxSWT86vj+8IDN9
 dbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626783; x=1707231583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOUOyWnXjxtmGnyfOcTT7YASioH+hRg6Bl9Wed5/ejQ=;
 b=O+H2MUBdHyqAj+cgpBlus8RITeLgpY71ODE6xVPvT8nWCiXWOCQAWO3gzJRkLldnP/
 WhXRO9U+Xa+NJIC3niY5Itlhq4Z2ihUbCfXl3jfgKJsaEtPG7uCLYuzkP1hvSFqh/zmh
 PtpfKJt9f68eOc/uSAoWOgMPNAGPK5OlzJjge7WRmXhBUOiJYsltNo/3cLBjkhBpgFWZ
 ypaursLiYpjkEzffrsUrYS0tRfLgTXgS1v8wsZqMkPtRaDfnhXenGXomsASbWSfLgWAO
 6twrn2oLMdNdz29BRMfQcRPQaHVlbGCtVVA7CnvCWaUrXDqcj1YTC1321ay/Bf2I4Xdl
 woGg==
X-Gm-Message-State: AOJu0Yy7fpYcpgG4SOUFGbRoK0jPWgg4E9YaV6nhWDEjPE+dUyHkruKs
 sEFUHm5etrAnyrsBk1W3pFjbHDblsD8aaupHDvCIbOB9s5JbA5LG2d+UeIz8Bd/64wYEw0I1RgZ
 +W3c=
X-Google-Smtp-Source: AGHT+IGCSIPUiw9eV7t/k25YTr/uau92huCI+1JSIbEkjLBfPJL09lqjasKJc0rqNSVZNnOfL+q1iA==
X-Received: by 2002:a05:600c:1907:b0:40f:afd2:61c9 with SMTP id
 j7-20020a05600c190700b0040fafd261c9mr647792wmq.0.1706626782785; 
 Tue, 30 Jan 2024 06:59:42 -0800 (PST)
Received: from localhost.localdomain (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 fa7-20020a05600c518700b0040ec6d7420csm17078648wmb.14.2024.01.30.06.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:59:42 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 0/3] Fix resource freeing bugs in virtio-gpu-rutabaga
Date: Tue, 30 Jan 2024 16:59:18 +0200
Message-Id: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While testing the rutabaga gpu device, we noticed that if the device is
reset, it stops working and complains about missing resource ids. A
quick investigation discovered that the generic VirtIOGPU implementation
frees all resources, but for Rutabaga, they are tied with rutabaga
objects that need to be destroyed as well.

This series adds a resource_destroy class method that the Rutabaga
device can override and do its own bookkeeping.

v2 -> v3 differences:
- use error_setg_errno in virtio-gpu-rutabaga.c
  resource_destroy method. (Thanks Marc-André
  Lureau <marcandre.lureau@gmail.com> !)

v1 -> v2 differences:
- addressed review comments re: using the Error API for the
  resource_destroy method.

Manos Pitsidianakis (3):
  hw/display/virtio-gpu.c: use reset_bh class method
  virtio-gpu.c: add resource_destroy class method
  virtio-gpu-rutabaga.c: override resource_destroy method

 include/hw/virtio/virtio-gpu.h   |  3 ++
 hw/display/virtio-gpu-rutabaga.c | 47 ++++++++++++++++++++++++--------
 hw/display/virtio-gpu.c          | 27 +++++++++++++++---
 3 files changed, 61 insertions(+), 16 deletions(-)

Range-diff against v2:
1:  5893fb45d1 = 1:  87fb4fa72c hw/display/virtio-gpu.c: use reset_bh class method
2:  78b15e8f7e ! 2:  b0a86630c4 virtio-gpu.c: add resource_destroy class method
    @@ Commit message
         This commit adds a class method so that virtio-gpu-rutabaga can override
         it in the next commit.
     
    +    Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
         Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## include/hw/virtio/virtio-gpu.h ##
3:  926db899be ! 3:  e3778e44c9 virtio-gpu-rutabaga.c: override resource_destroy method
    @@ hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
     +                                   Error **errp)
     +{
     +    int32_t result;
    -+    const char *strerror = NULL;
     +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
     +
     +    result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
     +    if (result) {
    -+        error_setg(errp, "%s: rutabaga_resource_unref returned %"PRIi32
    -+                   " for resource_id = %"PRIu32, __func__, result,
    -+                   res->resource_id);
    -+        strerror = strerrorname_np((int)result);
    -+        if (strerror != NULL) {
    -+            error_append_hint(errp, "%s: %s\n",
    -+                              strerror, strerrordesc_np((int)result) ? : "");
    -+        }
    ++        error_setg_errno(errp,
    ++                        (int)result,
    ++                        "%s: rutabaga_resource_unref returned %"PRIi32
    ++                        " for resource_id = %"PRIu32, __func__, result,
    ++                        res->resource_id);
     +    }
     +
     +    if (res->image) {

base-commit: 11be70677c70fdccd452a3233653949b79e97908
-- 
γαῖα πυρί μιχθήτω


