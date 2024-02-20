Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEB2C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPBz-0005FF-8R; Tue, 20 Feb 2024 07:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBf-0004oY-DC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:35 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBd-00064M-7R
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:26 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbb4806f67so3708159b6e.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431917; x=1709036717;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U6xQkliuU6eOM0QvuV0WWcKEWCKwljQhzYcjj1xV+Kc=;
 b=jXGRP+bvHuPQHvoO8/4izt1bugN5X/0B8mQDfBkML2CzJuucZz5bUtbb9PsRhFvwJ0
 XytfpHX6TrnvLWtsB509UDQtFZj5HN0YYX6j7+dQ3wUsDsh+KPxWIfrbIJq2Xa+oCcVQ
 /sYAQ0cuplq2vhXTg3om2S49NsqgL4XUjg9kgPathu3ZvFmNbY5E2C/g7MqxJx5568Ps
 yrqZHxNdeXh9cYMpm8rLMejXccF9wMyE15SXwy3JPXqBNosIQ0mSj8BQbwGUFe3YvjUY
 VVnj6ZjUbGw3S9S/zcFhnTXdXjZmNkRIbdNjt6o1mrONoke73kzBM1ed5iu1wpk3X9oT
 /akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431917; x=1709036717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6xQkliuU6eOM0QvuV0WWcKEWCKwljQhzYcjj1xV+Kc=;
 b=vyQGWhiix9+nF0Mc/zUCGpOOAgOLKgEOSa8mDqGYRdK090d/4VKnJhYmqf+Ntp3kSK
 RrVqjVIPYj5O6AztYnTnosQv7qxcNXZfLwIuhUu0mY5CUuPTII0Dq6cDs3r/HUN/AgRY
 RB81mLirNSsZHGJySVfEX5oGw23PoqfqZxAEwrSkprpvxc+JUk+me3bDWx0Kq4hjJU5L
 X4xRus5moxqqJcYWl6mWXYRfKXKMJcFHiWOvECwa+q7yDg/29mr4ocBhH82L7iO+F9/9
 utcAI6tpTvIMxiWreipUZFUghFI1dui/Z+Rk8ZwuFSDto7ofBVoThJcj4lrPsE2bBjoW
 3yuA==
X-Gm-Message-State: AOJu0Yxi3V2eT3ShEJb6V/uBRU4FdBjp4fvnvxWGjz2Dw5zZAPWF0o1d
 R13fzpSxnyaeR7QY9nXIXqyiMt+Jgq/14S4UOrk0MATYrEGGKm8ml46rOXOR69g=
X-Google-Smtp-Source: AGHT+IEx5FX6CsBMKGLSOhm5LnDZUGHVIz4kuh1bFvSTyN9iJOxup7w7OSX9E9cW/0LTaW+uJhLBlg==
X-Received: by 2002:a05:6871:5b03:b0:21e:e091:7709 with SMTP id
 op3-20020a0568715b0300b0021ee0917709mr5140879oac.45.1708431917225; 
 Tue, 20 Feb 2024 04:25:17 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 k15-20020a6568cf000000b005dc5129ba9dsm5478284pgt.72.2024.02.20.04.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:25:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:42 +0900
Subject: [PATCH v6 07/15] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-7-2e42a28b0cf2@daynix.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
In-Reply-To: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..8b1fd2a89ad7 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -17,7 +17,6 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
-#include "qapi/error.h"
 #include "trace.h"
 
 static PCIDevice *register_vf(PCIDevice *pf, int devfn,
@@ -204,11 +203,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.43.1


