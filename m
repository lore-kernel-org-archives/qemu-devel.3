Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F06C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 05:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shMQP-0006oQ-SD; Fri, 23 Aug 2024 01:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQN-0006i6-P5
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQK-0008SP-Sx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7142014d8dfso1301797b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724389279; x=1724994079;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5CGZuhv54KbzzZfkN6AoDeKXUOhgbsQVkrQ/COnk478=;
 b=WFFaD3fKJk9rocYIMYoeDJHBaQOKllJxHOwNZZlIUn3GIp+SqLvZjhtlhk5Xsr5657
 13PbUgCyOsarHqkp7adhAIGaT5FswyAnjMtViHg/Oi3ZZ61+lAMsXEIowsRnMwYm2HPA
 KK/E0pD3+NorC4ZNQgHlRUavqcS8lB2fOtGGJPXRxHhO9SZKX1C3Y8vBCvX2dLR784/k
 x1NxYUaa6eWBh8a6/8kkuPRCnLv2RO5ZpDkKLZu+g1u1fmo1xbmmzGzUPAl0L4OxNThb
 FllxfO67Jj/Hja10LuY5nahL1DCxbkauozyI+AawWMQO7VSJ9mrSsEdJDuceINAwB6XD
 VQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724389279; x=1724994079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CGZuhv54KbzzZfkN6AoDeKXUOhgbsQVkrQ/COnk478=;
 b=dWewzzWD8MVodZ8RfZAPhvk1yyGUkDQQiVgx7S7gANZXcWp+aE2Y9mA9Db3E+2RjlQ
 jb1iDgpEV23aSVbhXcihFZXtm2gXOX43BCAFbM2t4lXhn6J6nqO5L7GhVnfBAFd+UOIh
 QKv9bak3dFmdr/IiXF68g88SQgEBAriiQb0Q5RSZO9MN+4HlYVwGVLiB8sKzh9KDjIsO
 YW4iv8iB6Q2faqGBUtrNbRGXF/Igc2m2CpNZQxvoxzwhNGPl1UyDNY56p0ptmsDgR1ez
 b8wdYEKK1uzao5pbiaN8ySlj8bGWG0w7Aaor+aE6SwlKcC+258fxf7ZHBoL4BQ06LTuF
 eWBQ==
X-Gm-Message-State: AOJu0YxeD9wJpLncMvVwnE6vPUOqT/vapQ5YHmYmkCQKHKDx/xCjph11
 XbIBavSztB8Zp6Y0cfYP5UJryxcihe/BUYH4JoZGLQcjZ4ezdu8CQhv/k2CfVeI=
X-Google-Smtp-Source: AGHT+IHaSIlmjSouYnYSZ5QD6oEIMDboa6ojwS1ygG4HobIHc1tCF9yYWt4dXLm9ssqm+qu8VDXMwQ==
X-Received: by 2002:a05:6a00:2789:b0:704:2b6e:f10b with SMTP id
 d2e1a72fcca58-71445d5b19fmr1110462b3a.15.1724389279317; 
 Thu, 22 Aug 2024 22:01:19 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-714342e09d5sm2186029b3a.123.2024.08.22.22.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 22:01:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 14:00:44 +0900
Subject: [PATCH for-9.2 v15 07/11] pcie_sriov: Release VFs failed to
 realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-reuse-v15-7-eddcb960e289@daynix.com>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
In-Reply-To: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 4bffe6c97f66..ac8c4013bc88 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -87,6 +87,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.46.0


