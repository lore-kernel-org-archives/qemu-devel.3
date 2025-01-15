Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF6DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCk7-00032x-H5; Wed, 15 Jan 2025 18:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCk5-0002vu-6U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCk3-0003xD-IF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:08 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso2380515e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983446; x=1737588246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io7i2xm+U0wVX8KzyUeFMTwhw+WXB6LZvPnnQ4HQaVQ=;
 b=FfAotW7qMiognxIQRz9XofhycVOiAZeY/N1OSlOtzpSY9L2BCYAxq+5l9WqvfGpfSi
 H0+8YRxvLqgRPENEbFGYo0atnI3nRJQwPN9EWX2+tZxwdeE8lPB7KyPY4Bmmppl8D2UH
 tp257yBVOjGwVMticp0tQ8gm8ej+Uvdd/RAgR9Jzk0ZcedAIcmCuFqgIN8s2l8Uswm4S
 B6i3ZbIWgdk98Jgjj4QWa5oYMjJEfrY/wNlbNfPxQ7JvDvvxrhHNX3yOl6ghMgM+EN5g
 PGgjxqm1FmesBkEUDV7WS9iC4faQkxGFZ9JEJZw4T0AT5g52+k97HC+XEbChwdNrXrQu
 uLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983446; x=1737588246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io7i2xm+U0wVX8KzyUeFMTwhw+WXB6LZvPnnQ4HQaVQ=;
 b=WT4dMicLamStNA7ACeTH9KnhOYYt2V5NlNhox0Z0UKhSsAM6A3NlpJJT48jgedLGBG
 TBf94jUYFTiPvdrMQWkh7DB5TQR/mJVYAsRJWQW1MkOFl4RC5jWN0DDQ8QMsR6VRPwIR
 fLA8leBpFOanl1U0EQ81WjHNbocaolFelalI9RooqOcoGS0LR21IzhH3WA9Lyx2zNmOO
 I7ilDih/NRNkmss2zzZnNhKWBS1eQAmgxuWnnCGO7ueS1UjljazajbUW7I0PSFq+XIp/
 sCcEVupwkLefsrBAnyTrMpkr9Wr++dQ969R+bAlEc+Q3A/eNvQyGZF35tqEk2xtV/fj+
 wBRA==
X-Gm-Message-State: AOJu0YyTfFm1Fptfs18xgNzxCItfrmM37kYkX8OcpX2bpyQUptNr2swc
 0/GJ/b9aRdBoXh3TPmMOzGP9/jHi4RhYHaducDBIHNqOKPNJ+EwJ1SONtjpbNQK1emSgm7wbif5
 zcFM=
X-Gm-Gg: ASbGnctItMLEH0x9Qv4DAxOOagZ1bGEeRSWuGIaYo/3VBhZrRlfsTfDzTZ2V1WtLW5d
 MpBm865RkIr9Bsvy+9XN9Co6AjTuynTyoF8VY0l1ASoNkEJlCX/4KJZjy5EeWPEZjHphg741djr
 0EKCj2iRJSGhxMLyDqzxcnIH6JezfHTrAfwQjt5V1aO06vs9h1gFRp1xvU0NGnrJ6iD3uyHbFgD
 +UFwOHk4Ty3EIYBz+yzEtTocAfr/dl8ClOM9gB9GhcHwGTBMFKD3B6QDLe/w7IaklxgT0lnFtwi
 plmOsELTOwHT8B0YfNwI/vQqfcV1pcg=
X-Google-Smtp-Source: AGHT+IGXqw7aaPV5Y6SY1/DNqGmBR94NsDCI9/mRt6c84z7uK+rOVxVVxX9oanZWjbyJ8ZKdoFbOHA==
X-Received: by 2002:a05:600c:4704:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-436e267f796mr230199855e9.1.1736983445904; 
 Wed, 15 Jan 2025 15:24:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm19148545f8f.97.2025.01.15.15.24.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 14/21] hw/core/machine: Remove hw_compat_2_5[] array
Date: Thu, 16 Jan 2025 00:22:40 +0100
Message-ID: <20250115232247.30364-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The hw_compat_2_5[] array was only used by the pc-q35-2.5 and
pc-i440fx-2.5 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a231c8cecee..505a7ee85cf 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -837,7 +837,4 @@ extern const size_t hw_compat_2_7_len;
 extern GlobalProperty hw_compat_2_6[];
 extern const size_t hw_compat_2_6_len;
 
-extern GlobalProperty hw_compat_2_5[];
-extern const size_t hw_compat_2_5_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bdd4dee3d67..212944c9445 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -272,15 +272,6 @@ GlobalProperty hw_compat_2_6[] = {
 };
 const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
 
-GlobalProperty hw_compat_2_5[] = {
-    { "isa-fdc", "fallback", "144" },
-    { "pvscsi", "x-old-pci-configuration", "on" },
-    { "pvscsi", "x-disable-pcie", "on" },
-    { "vmxnet3", "x-old-msi-offsets", "on" },
-    { "vmxnet3", "x-disable-pcie", "on" },
-};
-const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


