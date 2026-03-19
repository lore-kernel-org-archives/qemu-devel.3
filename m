Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87723109191B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KTG-0006i6-DQ; Thu, 19 Mar 2026 16:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KTE-0006hP-9i
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:59:56 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KTC-0005s9-V4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:59:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35a1f549e7eso7681a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953993; x=1774558793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBRdioarDBlwzHg1xa4ywHaBWAnWfXCcdobe4gbGus8=;
 b=WCgbVlcg5Qg9nlNiEJ8EfYAT8zFikZay8mFy/sjU8/OjYrx+ujCwtaKKAvJMQF4moe
 rVCs+I9t+CSjpc7r/O6jXVYLG9Oyx/I/mmKWoYq2nHmty6l7iU8sNVJoWIsxV9450F/M
 24XU+Oy88mD/PhXoufqEsZmz0sflluERgI6Icy6iaDcKGhI3cV9KkQb2DSljYeYAosxd
 4aE4vAbRv3LrekN8oOOwXU2NPVGgLaFXDlvd3N6Ng+BjI2p5ew5bloWcPb2ykNj/SyZz
 JvQrSbjxdCNNStziUIN+eRoFNhxe39st4hnWVsq7q+tOSlupGY/VD6kp3ZqDNTNvPfps
 yTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953993; x=1774558793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bBRdioarDBlwzHg1xa4ywHaBWAnWfXCcdobe4gbGus8=;
 b=IEYJn6BSMHQ2It57pGvrnjaQhtiXJHxEZ+IqgZXlwBbo5Y1GRnSb8s02JJiTS3h125
 B809egF8atGU3xTqB+iQJl2uPU+M7Tf/f1U5xMmwFFzFWSE5OyXrYqCb/PJfPmwQ/uCM
 6nBMqCfdakYr4zk88Tla8gL0xQW4eBNu5gOF4iGyRG6wetqmwiCrmPdONjrQlhbpxZYj
 0II65PCe2bsWqCrApl2tyXh9ON2DZ+mKcaMd5GZP7SvYWGMhNColzriLZZj8EJvSjiIQ
 od/inIaPUlvbcb8Kewo9cbrnYClKaC0pWvXG1Hv2K5Ox8yRREb2y86PNyG//aLUzYuw4
 6uRA==
X-Gm-Message-State: AOJu0YyG8ufSQWBex4A5xz9ZnkLEcQ5d7oB7xCywzRjvSHfD0wo4rUKh
 0syvWU5LCneZaYjlJYkbRhPyPL/j6WtLhp1Jr/CpMrXRaDr6ThvmMJWEHLNQkcKkdZ1Qnt1xabi
 nYpGQ26k=
X-Gm-Gg: ATEYQzygd+622VxRqvtgpcLZcCei5ZJYVIiZ7e3BcFs15VN/B7Aw2RKmOKcbar/kjed
 Atr9yYNegNKUvln2PPN8isz1TYHbLddi+drK6xOSOTAGBi+5eBU2oy55He+t5sXhUvlyJ/Jk4Vi
 oAHG2A5+fmM+vOkdiiALMeBNb3w9stLBmA8t7iTYMPH5dtSke4IUm152WGloJAL4rmtKgiC1r/l
 MKFvjJ5ldLuLrkAnnmnweuFiWA3bugdM5M/6TWKQEbq1TLm1A7qfC3SQ353CD6bTGfDebX3ArM6
 u5S3bJmtjZNC9F7vWBRvEJHnX8eFCpFgNfArKrJlm0vZK42tBtNrklApC37c8yMnDSTEB/oH48I
 7ni9PZRz4rvKlx2hH1KtHeMlQXLfpGlNfhD62e8uFePeH3Jw0j/6coZTgbBDZxvVf6J4DeimFQo
 s3gHWH2kJWMFNdIm0RjdaFDSt/fMiZB98Fy29p4Vkb1zjbvm9SawH+tQIG4uIpReR95SsBppRLR
 Vg0
X-Received: by 2002:a17:90b:288f:b0:35b:9a95:dfb0 with SMTP id
 98e67ed59e1d1-35bd2ce31c9mr392221a91.25.1773953992731; 
 Thu, 19 Mar 2026 13:59:52 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd40e4bfdsm31273a91.9.2026.03.19.13.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:59:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
Date: Thu, 19 Mar 2026 13:59:42 -0700
Message-ID: <20260319205942.367705-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319205942.367705-1-pierrick.bouvier@linaro.org>
References: <20260319205942.367705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Give a hint about missing kernel config CONFIG_VFIO_DEVICE_CDEV.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/iommufd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 131612eb836..3e33dfbb356 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -274,7 +274,10 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
     }
 
     if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
-        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
+        error_setg(errp,
+                   "failed to load \"%s\""
+                   " (is your kernel config missing CONFIG_VFIO_DEVICE_CDEV?)",
+                   vfio_dev_path);
         goto out_close_dir;
     }
 
-- 
2.47.3


