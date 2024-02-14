Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A4C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7bU-00061K-FW; Wed, 14 Feb 2024 00:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7bS-0005wx-G6
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:38 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7bC-0007tc-Mj
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:38 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so4198250b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887660; x=1708492460;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=piL6B6HF9busd7PInV89zPspNU8uUf46ErSiJR0b42gexzOnSxm2X4B6eBB2cEXFNT
 vdiVS9WPmz87YMjQ1dUDQnugZBOXklaBUidBr8fLX6HhtDQrrI2OrB5lr1+ooWEmM72E
 XbkXtjCG6rjVt09gP3VMZlxOqFfZpz7LPEevx17hQFmKeCOa/8LMcgtNni2RX+daPTEl
 1Lp9lREPI43FwF4U1aZfogp2BDsRknaYZg9BShCO1t5ZilSAGChFb4wUM75pULd7/SJi
 7bJUK1N85j9YQxmkDBtbZ1DI2uO9zzrHhPT2WIOPLlw1A8p+kmHhTF3m3ehGsckfu5un
 GvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887660; x=1708492460;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=fPefMhVNDQuhF7s5tU324LvZkm2xjVfZQW8lUG+0985Vw5pwNzmesvvfAzlE6+epqE
 SAWpmIw55VfNq/DPpwTHJNB0To9/QVNK+s1Ef/Q4xBjoQdJi2k/1yo+GShcTdmi60exQ
 hJCPRH5ElWM59ZFs54oa8xQuSsoQwWhcKFvz64v1UODjVHAJOeFE8vXunGM6q2DGqXyG
 gQUVX4GVRB+qLWG13twXbIVvPfVmME0fdJg8fxtLd0bV4yjWFY+og3t6b4xJ3uabsVrl
 FkhGzGXQu1IR3nUxTtfOQJ83wwckRBJwdWSiEVL3do3ZnOvHoqQ04MJVgKJORwwwlzjW
 IsSw==
X-Gm-Message-State: AOJu0YxllD3nrziIs2Dgic9u4SksliEnlYz6/QHCnjofFaO+QyXdGrKw
 s46mEjhHJpzKuebkwwfYPnrBgZ5UxuPsC9GY0IN0b3hexet5Ki5GPb9KkVlMZ1U=
X-Google-Smtp-Source: AGHT+IFI+QZhX9t88wBI0BG2my7wAq7GuidFmjDjGR70paVTgD0NZECmadhnw/9hJRtkCPCL6df37g==
X-Received: by 2002:a05:6a00:80ce:b0:6de:3b41:2845 with SMTP id
 ei14-20020a056a0080ce00b006de3b412845mr1081770pfb.32.1707887660436; 
 Tue, 13 Feb 2024 21:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVAXE/lMtHTK3L5UD7HWBbf5Yy4ikOEY6AEF4XiW9CVu3BIpykXC364tYTrAnzLAbdpnT68ccae/NtGSNDBJNPNw6RWOP0RneLJEP2ADc1M7JEjRflBjuj1dbHQThG9NvOt3JceHH/xLwiNODQZ0j9RTH3kV/p7UYv9yJxIIHU6IJFfoQ6yMXukZEG+DcmaK+scSaYLadp4pA1Q3gpejtAhsiMis0YXB4mncKCy5M2KBZdHtC9lgksZWUMVbIh6K2MXsVejC/lEXE0rvdwnjNmQiPify+6HNJ/0Jw8CuG8q6MZy3P3xLfT79RxdpzRawh48pgCIlOrFUMHaZ3Kwl+poBHOMZhYn0h50KgTRx4uJdoXl34yHYlb+Gisq1FG2CfTauEUIvcK+UwoCt2iKvacD/H1cNfOZBtQoNFEgrL0rqhxDom5sfkL/OquOiZ4=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 k192-20020a633dc9000000b005bdbe9a597fsm3231306pga.57.2024.02.13.21.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:14:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:45 +0900
Subject: [PATCH v4 7/9] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-reuse-v4-7-89ad093a07f4@daynix.com>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
In-Reply-To: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index 9ba34cf8f8ed..9d668b8d6c17 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -91,6 +91,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unrealize_vfs(dev, i);
             return false;
         }

-- 
2.43.0


