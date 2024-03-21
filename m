Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B31C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFJv-0002KP-7t; Thu, 21 Mar 2024 06:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFJt-0002Gk-H4
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:06:45 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnFJq-0007xd-TF
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:06:44 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-513da1c1f26so1064996e87.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711015601; x=1711620401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jT8f5WSwiPj+GhT1K0UkKzrSEj04lWZe59MdYABXgNc=;
 b=GNIZuBOlGpQfI9SvvLtOhjnAResjveDzHD5Y5sIBfY4wbkOs1NZzBzx4KiW/h3L9Iq
 U4xv5NQB+daWrMCCJPUBIcrgtHmGrlo6OUGQ8Udt8aQktJP8ObJPZPrMzAs4R3JLUMOt
 WnInAkMaI4N6B49X29QtmrxFDnn0Ccnj7f4Vdizc3ofSeBpfo6VXGoucD87x/lPQUgyZ
 Cywz+1pDbNhmCV2xc0+vHHoMA7oPruSWoeS4rFoA+5xe+11Ezs5m63dVcAGdQxlRegWC
 uE+EC99c15tXD9jBHpMiK2I0rCPRsjWL1VK0RfXFCimxa/DWpzn5VTuJ+xYvRGvLLKV2
 vdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015601; x=1711620401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jT8f5WSwiPj+GhT1K0UkKzrSEj04lWZe59MdYABXgNc=;
 b=Gt2VK94sud00uzOhdqgV0uMs/Bx6w0un22DCIaiu93qHuSqL4AYcRuGXaLkBXFxkgZ
 L5wkuNc4CAf5oVqkQU2dPA35c/5FremixJfzlY4Mlbsgwe/n/PDhF9BCsOC/k0Bzr5T8
 Q8WppiML5uCbs0QXftMN78nZVRePzP5F7n8YS52fMJsHyQf+X8G3okbUNormOWy3lP1u
 oeIO+Ys3a+wVl5CoLeHXy4DLMW6MhjnqhbIo9LfAJdTBIHGRbRhSkceSQ4NdmtpDeQwa
 gzO+3LHdUJsMwLGivC6lFYXIKYS4AkdqZF6IQTyJz1FPU97fIIJ3Ry0lHra3fFFtzs8v
 UjCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4eqDFTGn0Osv/slLH3TuV2J7zTwzVajGKV1BXUCTKo0tQcuMTZ9NQNYuOc1ZPran8mIcfeBLNe6OMJDFTqgppyAW56zg=
X-Gm-Message-State: AOJu0YyH+swm1F7YQF1JRT9hU362osszAzjBvw3aeFMhN8sUjVtcuONN
 2EDLu3bWsu73dDMja2tabTq8bDeuT85xAxCjhfCybdFA3Tc0Kk7C2TggcyG08ys=
X-Google-Smtp-Source: AGHT+IHQeSHZMCbvLrPdPpwE8rKg7MUH3EPXUpePpJx0xHYucWPNvIQbBnQavqAFMkCQk4TfFjwM3g==
X-Received: by 2002:a05:6512:456:b0:513:dadd:2a83 with SMTP id
 y22-20020a056512045600b00513dadd2a83mr12033754lfk.35.1711015600826; 
 Thu, 21 Mar 2024 03:06:40 -0700 (PDT)
Received: from localhost.localdomain (10.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.10]) by smtp.gmail.com with ESMTPSA id
 fc16-20020a05600c525000b004131310a29fsm5040487wmb.15.2024.03.21.03.06.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 03:06:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Dongwon Kim <dongwon.kim@intel.com>,
	qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/3] ui/console: initialize QemuDmaBuf in ui/console
Date: Thu, 21 Mar 2024 11:06:32 +0100
Message-ID: <20240321100635.64950-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Respin of Dongwon v2 split as bisectable changes.
Unfortunately last patch breaks vhost_user_gpu_handle_display.

Should dbus_scanout_texture() use dpy_gl_create_dmabuf()?

Dongwon, you can use it as a base for a v4.

Regards,

Phil.

Dongwon Kim (3):
  ui/console: Introduce dpy_gl_dmabuf_get_height/width() helpers
  ui/console: Introduce dpy_gl_dmabuf_get_fd() helper
  ui/console: Introduce dpy_gl_create_dmabuf() helper

 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  2 +-
 include/ui/console.h            | 10 ++++++
 hw/display/virtio-gpu-udmabuf.c | 27 +++++++---------
 hw/vfio/display.c               | 35 ++++++++++++---------
 ui/console.c                    | 55 +++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 33 deletions(-)

-- 
2.41.0


