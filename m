Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D457AE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyym-0002dv-9B; Sat, 04 Jan 2025 02:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyya-0002AT-Cg
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:41 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyY-000383-Rk
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:40 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so18348944a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977217; x=1736582017;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vnOMtN50C8qTZil8w9g4J3opxb/Gn/jEvUw3KiKXfx0=;
 b=fSl/lwnxxIB6ltVxgJCKIUNrPiqdB8k0CT5+stRGOFHxzsMTtLcgBIdX4+1EHNZ023
 D3tzf9cGwCZnDykivG6dqIJf7F6tdAlRWJb61DIe+c4uGnQFqNokP13rXMuhIqf3GFrq
 njJU4V3lV2K6yhKoBVDAWWJgTNPyvBAxPH01mp8q4fKYnUlhK+xHEiHrtSXJ1NE237ae
 7oxcj70ir66JIOP94ik/y7Br6NNKZ+vPiCyqyeYeAbvlPqjgj4nGhYdnabp28pzLFUMt
 Vqp54Xxu6L+3IgflNlf46KssCQtMDIRkNOvSVtd9eUmZoM/mZtI4FNW6kOYkzFlwhfvN
 YbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977217; x=1736582017;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnOMtN50C8qTZil8w9g4J3opxb/Gn/jEvUw3KiKXfx0=;
 b=N3x2YURch7mBOrqZSgfdCbYDUHICkN1zFy4/13RyXryeCH/pVTtk3Ns9FR+d8lhXx/
 FnFRYffZoaXl5tB1qHfnv4bUwP8vSHGa/01EGE1o925QY5N34G71BF4nBduZ9sLoTigZ
 pa/phbABmp+zUDM0H023Al36yl8Q9DqtlRI+Voz1UfZxusqygx+U5dKueX1h1mcYmJSh
 pkCSAGYVEk+ztups++XipZ5GX9LW/qKI5LiCBPKrUdOONX2wb2XOhywq9kIZEfSmZlUB
 S5LoiJO7z8GTNLarMCaCkSacaUkOtM3FVvStMkSjpHbK5ga15XlzlddR6Q2MqXyJq2hx
 i/0Q==
X-Gm-Message-State: AOJu0YwYgkRqEPhkgw7BOHwS0FM/VsnKO8j9Qr+Pza45AlUjoHojYAL0
 0xCf5UbE4leR0XFOTo6b9jLNEMZH03DXvm5JszEs8gOd/zSLVv08B9GRc1zsF9o=
X-Gm-Gg: ASbGncsOpqmv3JuTx1oa/NkbcK62KPUD5e51dfAbcUrVtEC6eB43hixGHLUG++Ir6/M
 mmXeLiDJehPILgaORFAaDQarO59DW0ti3E/cL7jcGpXx/+eV++Ol75zSgTtpfuU/zVNFoZvB+ME
 gSvNKLqmgHnw/dXzv/R3X0zLEeMbWmvM1D+sKD1oU+f2Bhsr6T7Il+0WoM7kG6d6tgEkiVo/Q+x
 /Vl7wuvfFPrlZ1/Se8gJjPnZGfNCv364cwtYz2WmaRjS3Qcjw6aLRagprD0
X-Google-Smtp-Source: AGHT+IE6r+QSxj0FJiKtdRatq4Erd8Qc8Sj4Fgp4oK3wmvyKdEh/jeD1uywfKCbwc1g03F+yUfDhgg==
X-Received: by 2002:a17:90b:2c83:b0:2ee:48bf:7dc9 with SMTP id
 98e67ed59e1d1-2f452e14ad7mr84714934a91.15.1735977217029; 
 Fri, 03 Jan 2025 23:53:37 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f447882af6sm32796739a91.36.2025.01.03.23.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:30 +0900
Subject: [PATCH v18 10/14] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-10-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index f1993bc553c0..db087bb9330c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -93,6 +93,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.47.1


