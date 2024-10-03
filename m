Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7477CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMrI-00065F-On; Thu, 03 Oct 2024 10:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrH-00064w-Lr
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:31:11 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrG-0003e7-1o
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:31:11 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2facf00b0c7so19575431fa.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727965867; x=1728570667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8C4nrNcSwpJCvhGlbR4nfMYnpTDxaR88Y6Ftc/fnJec=;
 b=X7hjEoKLpL5mlbcUeBaE+bpke0DZfxo3xgjz6t49k9oYpKX0dJoMAbD3dEcwyb/NMz
 Y7lfl2xFVbTPN2xb0Dkn5qcjjdaDq0eR1zNXsMdH7b9H2g7fAI4iZdwuj5BmIWCMFvgO
 Ssi8t5juxML2LDw8+0qjrVzx1acmvCvH6P6W7E+7UBfmwWioI0fvKRypvAVpm3Pdv8Mh
 6DYi+s3c0LIAEhJRSnIwTXyDlUfkOfNu/S79eXprd2E4GBE0qzqAOQ5An5WS3U6McLde
 PeCQknFYhVKp+9Iz7PdUuHbyfecEBVLITH1D9CkgibixWVkmHHNvzXGRle53DnzQViD/
 69Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727965867; x=1728570667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8C4nrNcSwpJCvhGlbR4nfMYnpTDxaR88Y6Ftc/fnJec=;
 b=XRPj/5LBMEZhQ15wqP0gLLV3sKBCxusyu1Z16d7q8zGRgX5/bq1btrDRtdfnq7y4YV
 4arsz0LCGiUCSLD+IUK4uMHoSMUPNf22wXHXzznD5vcbWeqrrsbMPqTQIjyGsDZesW0r
 5TrZk1v1gL11OVTTZzdHOdSqGOzzrEUESZ7n6Ew6t84ULzjlZj7uMCeNV12RcLkYgxUE
 8kjMc0UdNzhRB4o8OVFAzK/grBvd7NmdU2qOY562ntpcZXcZtuGLYgJUgJngg2JN2zLu
 vLl25jCcP/u83T/mkN5SpxkCfj+hF3w4ZXMfIYE6AyBRKk6JiUVixbRAHkpOendU7/EJ
 WErQ==
X-Gm-Message-State: AOJu0Yz28jve4XGLwTpUEZozkKHgMJ9diNUdRenCJEyeJ9vDlArQaFnN
 maHueZ9HCOmFXrwO0tKd9IaLNnm8DDaH3YZ/9DRLOu2mfgOT6/xRxSouJW9U
X-Google-Smtp-Source: AGHT+IEPodM5ZEmWqwQcLk3Nzn9ipU/whmdCEXyUk1Yq/FAtjqQ4wTbfCBEYct8NK3LaRXLoVZ8Q7Q==
X-Received: by 2002:a2e:5159:0:b0:2f3:f1cf:5314 with SMTP id
 38308e7fff4ca-2faea223edemr10746221fa.10.1727965867122; 
 Thu, 03 Oct 2024 07:31:07 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faecca88d9sm2299871fa.125.2024.10.03.07.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:31:06 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PULL v1 0/5] Xen Queue
Date: Thu,  3 Oct 2024 16:30:57 +0200
Message-ID: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit 423be09ab9492735924e73a2d36069784441ebc6:

  Merge tag 'warn-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-03 10:32:54 +0100)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-10-03.for-upstream

for you to fetch changes up to 507118c2a066b70e8069702c120461ad8c98ccd5:

  hw/arm: xenpvh: Enable PCI for ARM PVH (2024-10-03 15:24:42 +0200)

----------------------------------------------------------------
Edgars Xen Queue.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      hw/xen: Remove deadcode

Edgar E. Iglesias (4):
      hw/xen: Expose handle_bufioreq in xen_register_ioreq
      hw/xen: xenpvh: Disable buffered IOREQs for ARM
      hw/xen: xenpvh: Add pci-intx-irq-base property
      hw/arm: xenpvh: Enable PCI for ARM PVH

 hw/arm/xen-pvh.c                    |  17 ++++++
 hw/i386/xen/xen-hvm.c               |   4 +-
 hw/i386/xen/xen-pvh.c               |   3 ++
 hw/xen/xen-hvm-common.c             | 101 ++++++++++++++++++++++--------------
 hw/xen/xen-legacy-backend.c         |  18 -------
 hw/xen/xen-pvh-common.c             |  40 +++++++++++++-
 hw/xen/xen_devconfig.c              |   8 ---
 include/hw/xen/xen-hvm-common.h     |   3 ++
 include/hw/xen/xen-legacy-backend.h |   5 --
 include/hw/xen/xen-pvh-common.h     |   3 ++
 include/hw/xen/xen_native.h         |   3 +-
 11 files changed, 133 insertions(+), 72 deletions(-)

-- 
2.43.0


