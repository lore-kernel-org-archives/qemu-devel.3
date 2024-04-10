Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13601CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaTM-0000I3-I5; Wed, 10 Apr 2024 12:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaT9-0000BT-I1
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:41 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaT4-0002c1-Cj
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:38 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso9181186a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765189; x=1713369989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDZo3IQYGRSUjwFMJgZFbdPKp1+CCXvSyhVLfSqq00c=;
 b=GVIQLZUfYb5YWk3EaBhzF41rlxWxBYtLa3btodEuOi8AnkW33w6CWn9t0kCSe3WwPI
 byC6IHn6hHHuJJXxhSsJZQsgJcPUDaafqUdPd+5SGZYZj4w7n3Une4Ji4XVLJgcJRo5J
 i/zJI1eh9GE1RoYLzGvz3Xg/uumKUZMGPJHecZdOi29L7C36VJG9Sa85i7PEEngRfaF4
 s+SmuQzmteLVH122xlFEfz5c/TWIAGKss2yXCagKVrTkqqMDMjPQRNz85D05sQxBLIpv
 FUlObDXf06wavEINCpNICd/SE0Gi/4t5w8F4B53op5ZRl1jTqFqrpSq/6/0TgWp2AFKp
 ddRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765189; x=1713369989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDZo3IQYGRSUjwFMJgZFbdPKp1+CCXvSyhVLfSqq00c=;
 b=nv9eRjtGqmZi3HFszgfLOU8QLGHIdELvFpgQ1LLxv8ZSTdFOSHi//K1B5LXzc0MSmB
 5/gwqPQ698t3VVlavebfsMxBh7Xvs8+sejkJE1qDuSBitsHckcQq1/hn/kaKPV/tjYGs
 LLASWIooqvCjKgW+2oWAmLbrFD9JQzcQ9H8WImn9kaIrLLyHVfNrVCEqadd/8xeXAd8V
 sbXv2Uq/j1YSnSVHc+U6OBP2eLRddxVszoSbj3dVZ0UyaVd6O6bRzaOh/kutT2OaXUbS
 VnDgejaJ6lOH/aVNTrDGui7cXfETvIKO7Rc+OWmvHOiMk0+mmKGEFcgF9EKP/pcWKjZk
 e0Rw==
X-Gm-Message-State: AOJu0Yy6ldc/bHQd810A+aQjbK382b2R+OVYrCbSCZr673BN3FC3IRfj
 hQPI1svisDuD6xvy6qW3dj2hXU82dogkF6GFUkPmWn81UvwtVpirW89xA8SJTOl4nuNtQ2UfpAj
 3
X-Google-Smtp-Source: AGHT+IGrN0AGW8T694ISVr1qvtMzErPe2EDhLVU80NuaT77Fsg9gwCuOBJZRefQxXLlJO/qZoWbFQA==
X-Received: by 2002:a50:bb07:0:b0:566:47ee:b8b4 with SMTP id
 y7-20020a50bb07000000b0056647eeb8b4mr1995538ede.17.1712765189165; 
 Wed, 10 Apr 2024 09:06:29 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 by15-20020a0564021b0f00b0056e591bb644sm4078733edb.45.2024.04.10.09.06.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:06:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 02/12] hw/vfio/pci: Replace sprintf() by g_strdup_printf()
Date: Wed, 10 Apr 2024 18:06:03 +0200
Message-ID: <20240410160614.90627-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use g_strdup_printf()
instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 64780d1b79..cc3cc89122 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2442,10 +2442,9 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
 {
-    char tmp[13];
-
-    sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
-            addr->bus, addr->slot, addr->function);
+    g_autofree char *tmp = g_strdup_printf("%04x:%02x:%02x.%1x",
+                                           addr->domain, addr->bus,
+                                           addr->slot, addr->function);
 
     return (strcmp(tmp, name) == 0);
 }
-- 
2.41.0


