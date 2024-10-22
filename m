Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E4D1CDBD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AOd-0002Tr-11; Tue, 22 Oct 2024 04:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOc-0002TT-9s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOa-0001X2-Ul
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso4112360b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586259; x=1730191059;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yHyVTHJya0M4L8kbxrtNFAlxGXTEO3Xl+9QYB8h5VeY=;
 b=1LFpOX9bD4ribv3V0tVKb/yiEN0tkKDPKahYz5gPTtwaMplcBmlVNXDQ12/PARE7Me
 CTO7T+cd5EhkrYCH95+gp43C0qiq8KXDLZaDWs+6iijJtwGzheQyosJkf4PiZOVOOEqN
 kG2OTjZ0vKt5DUkp9htLW8ka9AMPE5VOytQZMNga6eaTWwLFwiL5aKhAmGuLA6Etp760
 CnMoAFhtiwRKTjTbGkdNpUeY1JyKbwFPFhbDAl3gACA/0TzSpiR2jg9q06pdJbEUkiSq
 j0cOZeepMaF/RXOtKLc9phJnH/BoUrnhZ0Cpi/NlK55JMXqbIYfkFV6o6AL5FJV7TUSo
 s5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586259; x=1730191059;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHyVTHJya0M4L8kbxrtNFAlxGXTEO3Xl+9QYB8h5VeY=;
 b=ECpA+HoQv/crkCgjtK4XM6EoQojYNEanOpNh0ZzRBgGc73jN03/Xv5Hn2b6ADchRSi
 q2IZvxIibbEKkTPhc3s8z78HZl38G2JE1oNJbl4pZlJIV8CA9jHFfRIqZf+i/LteFg9s
 c+FphhMdGH7141lvhl0UCzN65ugdSnTEz+X3ZEFk24GmyPztW/XSQ90CeCtO8lrSOiy5
 W8LsTOl6zDSM/4FF1A19s809dDzHpDBNAFFrk31GkHpYaC5lCyxafob9aarA3khDXbJl
 Ug1Pns0evynoUXJVOfCHqDsJYPukjUdZ30woepiCPy/nVbEisthEGVKsA7mE+B9c/JEZ
 YpqA==
X-Gm-Message-State: AOJu0YwUKP/I0WR4XqkS/9/GpTz3epoC9dxRdx7ZaV/R2xBHEFzhPW0e
 VpWG1ZjS/zD4VG6YfxItX92uDL2zhjbl5w+7SCL/Ud8onITYwjqgRG9ZgxIyc4M=
X-Google-Smtp-Source: AGHT+IHGF7xk4LfbQ6kp9ZzpDbUhpcOLaWlTw9YQ0T/ksEX8PSmTk0IPcOCU4N+CNGpQi3KckZTobQ==
X-Received: by 2002:a05:6a00:640c:b0:71e:b4ee:960d with SMTP id
 d2e1a72fcca58-71eb4ee9b46mr11209211b3a.10.1729586259413; 
 Tue, 22 Oct 2024 01:37:39 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71ec13eaae6sm4315332b3a.144.2024.10.22.01.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:37:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:44 +0900
Subject: [PATCH v17 07/14] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-7-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
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
2.47.0


