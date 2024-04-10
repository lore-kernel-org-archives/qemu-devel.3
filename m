Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DA1CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1e-0005mU-Io; Wed, 10 Apr 2024 05:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1d-0005l6-1X
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1a-0005Yx-O1
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:48 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso7273348a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740424; x=1713345224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcCYZ0ICkBKBb87mzxsdf9nmTwmmEuaTsn4C58m0KwA=;
 b=aS/e5d5SgNWtgf6Nj2rGDJQHJfapXyVAnltTsda5O+X4Z/WGVcqwz65LTqdCsBGgoi
 7wCQOTsYowWo9sLeECtjxzvSu6aJuSXWXNELY5Dki+aY71CpPKPsgHyFH4cPpu8Qfu74
 9qgaNfXjXE+bshp9ynWh4zTzmxrv0VzubPOKyfNWSw0v+YIQVc3JgAMp0n/AXjl4iuiV
 Fj39Ys+mIQhsqfsU/LrLdXjlv19YFJ9Y9eugtVW7Te3QscrXXAWBf345fZpz05KtHrw8
 6xGM3oPSBlv1onypR/94aU3Sf9WJlvpvgiTbufDwZd85NJvPJqCYjDGGfET/yu8Jsq4C
 s22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740424; x=1713345224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcCYZ0ICkBKBb87mzxsdf9nmTwmmEuaTsn4C58m0KwA=;
 b=EKnn8W3x7IJYfAjnuu7YMdN7zk/i60hYNRAt+xBdU9e7LDHS69i2Qkg22sWnH1B2FB
 g1lxKmUkPc2e4yfH/I+hR9bMDGrpt6+TjbxXUgePPs1U3U4yID4SCcgztwaCk0bYFSJW
 4NFbNeDT+0j+N6EJMcZUSqjJ80j+x1RDnvX6fnWtBkEGlT+53cTvkxVwPRL3RqJN8+F9
 AaGEzGXAHqPLn8f9X3QjDkiH7aVGFfP/LgIW1AIvBJV7LG+tltqdxbak5fQNoLD/a9ZF
 LepzzmdoVGcnQiSDhEs+eRr3pl4TGQD4771BWixyCrXgVHYbRpWagvaYTvCJqlCKzoB+
 B3pQ==
X-Gm-Message-State: AOJu0YwKiL49ajDrlghWq+oOzPfqVvHMJojL8wVBdwyAnLNGO0DdGI92
 tazT50auL1kF7ylvxX004Vk4XxR5B38YTYml2KLDDSYKQZ61sMt0OJLQRpK71nE0oFEFXcUjlKn
 j
X-Google-Smtp-Source: AGHT+IFDjLHPBNAYm9Erw9+ciQqbdZrsdWOIKKgNeZ0U4PmnCNqCV8V9gPqSJ3jjEMYMUYJt4p2Kag==
X-Received: by 2002:a50:9b19:0:b0:56e:238e:372c with SMTP id
 o25-20020a509b19000000b0056e238e372cmr1315225edi.26.1712740424537; 
 Wed, 10 Apr 2024 02:13:44 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 b93-20020a509f66000000b0056e0376286bsm6419677edf.24.2024.04.10.02.13.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:13:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 04/16] hw/virtio/virtio-crypto: Protect from DMA re-entrancy
 bugs
Date: Wed, 10 Apr 2024 11:13:03 +0200
Message-ID: <20240410091315.57241-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

Fixes: CVE-2024-3446
Cc: qemu-stable@nongnu.org
Suggested-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240409105537.18308-5-philmd@linaro.org>
---
 hw/virtio/virtio-crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index fe1313f2ad..bbe8aa4b99 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1080,8 +1080,8 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
         vcrypto->vqs[i].dataq =
                  virtio_add_queue(vdev, 1024, virtio_crypto_handle_dataq_bh);
         vcrypto->vqs[i].dataq_bh =
-                 qemu_bh_new_guarded(virtio_crypto_dataq_bh, &vcrypto->vqs[i],
-                                     &dev->mem_reentrancy_guard);
+                 virtio_bh_new_guarded(dev, virtio_crypto_dataq_bh,
+                                       &vcrypto->vqs[i]);
         vcrypto->vqs[i].vcrypto = vcrypto;
     }
 
-- 
2.41.0


