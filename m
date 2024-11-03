Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A04FD11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7akw-0006FF-4I; Sun, 03 Nov 2024 08:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akk-000683-H7; Sun, 03 Nov 2024 08:34:52 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akj-0001Dz-3j; Sun, 03 Nov 2024 08:34:50 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so567669866b.0; 
 Sun, 03 Nov 2024 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640886; x=1731245686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n35w2VDiQsxwqNroL2qJeQnt4HfjJdNE+pLX1JQDjcs=;
 b=bXj9bESHfZlMcsANApGRivF1T0DldMkyQ1AZ2cTpsky7bNE1nSMHMaBbVum27oer4f
 yEunFHGBXAgKzBLQifRQWf19ZpBoUXaRpZF751CgqECtdvPS3U26GZDEKErgYUxktZcY
 YlJh/vuBTIR1/IJzsGIUI57eeqhESEdn5EcCzdEHlBeiSpRNSZX8WWJExlG88JwLFN5s
 rDB8vQ/N+AWUD7iHdSkDPO8rbm874hjDzeixTcvaalUU7YIxlo9BkFcDRV5hjmB9O7XG
 Kgsr766yun6jODb536ExwgQFUaeShKzBbbv9bjU+UzKpJbMo/7LYZViPNewNLhPlwzhR
 H6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640886; x=1731245686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n35w2VDiQsxwqNroL2qJeQnt4HfjJdNE+pLX1JQDjcs=;
 b=fejhgkgTAhDWyXxgcitgZ4HYMEeI68f7/3va6j7TvtTKes2NvuNrvqXDw/RF6D3Pbp
 aRssPJFXF3PEMb2YUicluBsZKzg1GwmEPmhfPn88feVni+/XgPPelnQPiPpxcLA+IMKs
 BZFrD6jAhqTXm5hgEZZJ3CPzXdK3TjbPnqoJuS2BX+giAHAh8pvjIdJ2M2Hqxvy8o2Zz
 4HUkav7uMfZsD2l8FhuOGelDwDRY8xd2WesOJZP7V/qwtvEaullNXaRnE+mtTPhISD2f
 KkohgWee7VeDV8kYdbCWHu6QbvwxFv/y8/d01uq/MZE5ZJRlHEwl16nPpo0bP93EwIyM
 vjOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOo5Ai4lJh0GLH16k+fCEyi5zysXzOb+O4Tok9suMSgZ3h9JAHeg2Vb1wGQGnzb3fikeStOP3LvJ3Z@nongnu.org,
 AJvYcCXZ47FhZqGA+MrpvocaG9Q8IlZk66ztxuR9tNaPREcbtWl3vd/SRaAR3rKKM2fZl/w1dLBp+m6k4jY=@nongnu.org
X-Gm-Message-State: AOJu0YxJejqYaoSLMqk++9FJAcZYTOP4ra2ET2aSDqLe/r3eH+DUbw6c
 M0/9vS2uxSuWmO9RW/cMjmFApBzA3jfhQmRSU+pzOdE41FLvMVXR+vdlaw==
X-Google-Smtp-Source: AGHT+IFE4YH+nm3DMUKu3TZJUMhXar2OUlimOXOmtOAn6GEIK6tHsaB4eF/qR9pxUTbit9f3eneNaQ==
X-Received: by 2002:a17:907:7e96:b0:a9a:6c41:50c0 with SMTP id
 a640c23a62f3a-a9e55ade680mr1042711166b.26.1730640885841; 
 Sun, 03 Nov 2024 05:34:45 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:45 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 04/26] hw/ppc/e500: Remove unused "irqs" parameter
Date: Sun,  3 Nov 2024 14:33:50 +0100
Message-ID: <20241103133412.73536-5-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 964a22c5b7..ecaaab1558 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -825,7 +825,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 }
 
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
-                                          IrqLines *irqs, Error **errp)
+                                          Error **errp)
 {
 #ifdef CONFIG_KVM
     DeviceState *dev;
@@ -865,7 +865,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
         Error *err = NULL;
 
         if (kvm_kernel_irqchip_allowed()) {
-            dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
+            dev = ppce500_init_mpic_kvm(pmc, &err);
         }
         if (kvm_kernel_irqchip_required() && !dev) {
             error_reportf_err(err,
-- 
2.47.0


