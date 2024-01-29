Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29EEC48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTpf-0000Am-SP; Mon, 29 Jan 2024 10:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTpe-0000Ab-Dc
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:45:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTpc-00054O-Pn
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:45:58 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40eb033c1b0so35710405e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706543154; x=1707147954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ePr/obO3CogtZ1Wy4mMTLfrIxAtvQ5Zw+V5Az81ANc=;
 b=B41sno2cJqxr8SuZNKCmtJ4mVk5zl/ZXDaZhyJto19sRxrYLElp7C5hxn/3e762QQo
 5ppBLxprpWdkGao9u4Q58nEE7nXhtuVCZt4kFHB7OOUCgFxnrmAIcK2Ef2ua+GYA/EBy
 piVnWgQybMJJY/L19pKhISxDI4RBpI3m7gpsyDXP4y9BZkcCnhDUaG+6q0LMeRblvDkb
 VwvFG5QFC/4wBWbodguJNh6W/TUfTd0PY3XKv+b8XuWdV9odOWQfcWyBOWUzhs8lsKTp
 hhI1hClyksBXXZscKkGDWQwu4dYXOSlf7dnSvbCnpsDcZ4qFKqI5L7cHZltyixxdl2vK
 1FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543154; x=1707147954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ePr/obO3CogtZ1Wy4mMTLfrIxAtvQ5Zw+V5Az81ANc=;
 b=uuwG/+xkynz+nhbri+HWnrN2VKArtI6JITn2rz8S8lxatUc7h5+ekt696NK3QbOW6T
 Zb7uiV7d6Ww4Hjuqce5IjTTTCeGbG6CLnan/oCPk9BfcM6RMU+vp6UY7AZ6e0lTATJ0X
 Y4mNt7Wn/hV7jeTfw8A2lcubrZU+ezfbDX0mKFiXarxulkVXD8wR/CoF5HiHSiwKn3Ya
 rhBlztG0q7iJ1NJ9vM1wKm7pnfd0ViH2Q81fhcGjcWMnwxRxVuuIpMSVifueTMl4LTVw
 LfTToyS+enGwrfxa3mZu39wsMHU9yZHE2w+ZsW+C1vIHrrAAnB9vYLJNEQmNuXDPYAdj
 QFMQ==
X-Gm-Message-State: AOJu0YyIKFy2rf1jrhCK/kvhRLvX06A9HvoOgGIr98/tE1ZVE48E9XRc
 bP8XORGJs+iIwFejrIxkddtttQqxMa4oPrUO0Bj6mxCSyFF/L32GYMPVCdfF49L2TlWKZZq+q0a
 CvYs=
X-Google-Smtp-Source: AGHT+IEvzovWsRoJIDBZKmU9JcfW36qadGOc0gz2SCyzaxmO9tRL+PfRRkeTJ6PrPdy4/S+3gj5ykQ==
X-Received: by 2002:a05:600c:5490:b0:40e:a3b8:a2b8 with SMTP id
 iv16-20020a05600c549000b0040ea3b8a2b8mr5861713wmb.26.1706543154012; 
 Mon, 29 Jan 2024 07:45:54 -0800 (PST)
Received: from localhost.localdomain (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600016cf00b0033aedfc5581sm2852608wrf.32.2024.01.29.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:45:53 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH v2 0/3] Fix resource freeing bugs in virtio-gpu-rutabaga
Date: Mon, 29 Jan 2024 17:45:22 +0200
Message-Id: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
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

v1 -> v2 differences:
- addressed review comments re: using the Error API for the
  resource_destroy method.

Manos Pitsidianakis (3):
  hw/display/virtio-gpu.c: use reset_bh class method
  virtio-gpu.c: add resource_destroy class method
  virtio-gpu-rutabaga.c: override resource_destroy method

 include/hw/virtio/virtio-gpu.h   |  3 ++
 hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++--------
 hw/display/virtio-gpu.c          | 27 ++++++++++++++---
 3 files changed, 65 insertions(+), 16 deletions(-)


base-commit: 7a1dc45af581d2b643cdbf33c01fd96271616fbd
-- 
γαῖα πυρί μιχθήτω


