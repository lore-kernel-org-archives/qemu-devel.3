Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA09310775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vIG-0000hU-W4; Wed, 18 Mar 2026 14:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vIC-0000fi-VZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:06:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vI9-0002bJ-D1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:06:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a9296b3926so1012615ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773857208; x=1774462008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBRdioarDBlwzHg1xa4ywHaBWAnWfXCcdobe4gbGus8=;
 b=L/+JLHPCMx90WqsTBuV41I4VMvtKAlYG/EvuR631TU7mpxn1YhRDZWP74Rc+jBzX7L
 hhKaoQTHTSGWtsy4pOge2WRcgnWLc5w6NZ0uaFfbUNUJ9LYXXSatUHOlevyCANuSaVOq
 /L6n2evRW4SMxdjrjc7K7zMZM2IiAsubaJnz/e/OMqDo5RmtG5PcpJpevntEkv13Io6D
 /KMR4NqrgF3EZBHAHSFo5SgfxXdjcOJi03YvVqq0hMAIL79N4cGgIfACZeP7W7WfA2XT
 y6dEZMkL9UcbmEWkf5B2RRVwBtCe8nHO/7zjduGPDvhic+Ii6x+Fcoynhf28EYYlGOXI
 m0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773857208; x=1774462008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bBRdioarDBlwzHg1xa4ywHaBWAnWfXCcdobe4gbGus8=;
 b=fexVEa1f1NMOiJXUYhurXybi+uv/O8ZIR+j3NrPAR7vvC/tL2i8NE46yCMvI82rBsw
 yodouYfIeAWKi1kgfOeVcSqbr+5SMHZo9byla8qdHkuYNrgUlBVQ68drNmpdGYwZv8FU
 iu0SVDbpddEqtK+dK6yFPXE0vdNfm1aSY2oa+MJMXefHRrhDJVErdaDYjdeFW0YhKRbh
 IC0EgFZ06W240SLf6Mk3jqEBjYLilT44v/hvgpvo3WRc2DXC0ZCUoewaG/k3+4n+y2F+
 /xLVMNcwoSeMHwxOOn4RK0smzQ2GRsoPrGb/9YsED6arFjk4lE+/iwowUIXij/a3xepb
 70Gw==
X-Gm-Message-State: AOJu0Yw1h2Y8SvkySGXWCeTWIT5+s1oESYeLvTjfW/7x1Dku1LJMJ5v1
 AIjEmYMXBLK6CjPaUaJajkXaWBx4i0VTBWU0SmNKaN0ejuSgEVxkaY4jY7TBXRegtZ+aIGoJMhP
 udXmZDlY=
X-Gm-Gg: ATEYQzw9lElNbmchDD6LYbU2WRakEwpAQ14xCnC46/zfkF1X6pFfpzT6HFVYBjq37MG
 VJYAGmbUUQDX73vDeiM/jZ7h2yvkHm9xlgN1SvZecS896gGKV2/rjtFT6q79W16X/E4sYAVpbVl
 PymaCW1pgsFUE4fhdvPQcbZRvq/ggIMGvqXTkkvOKu8xW3CMf50wtaLue3l7oNpgS8OR255Cq7L
 D5bfOO+JBoeXCt3iZ4gjvyDzi2ZlFnFMEFSDwyVBt2GLFeZsKLCUYRapLhCejaDg6moo/Yt4dsV
 40T3IoNxVtc+9RjUi0MBd05Bq4KXbOA9HGzUSMNGVoJmhe6YC4mzqp+1veRGKk0KVRJznhrWW9r
 Hp1othfxodL3uuSmgOmOJcNYL4dXE63EozomX8h5X6Nn6j2U6cFTENAPGwvQY8rQ7dTGSeeRmYM
 AeiREWXgdwy+D2pE7cFwniqvuC3/EdeKXxnx5/+yohG8/ssAWBLWTuTzBVKFDBeDsxkTzhO8FvT
 fWI
X-Received: by 2002:a17:903:1a67:b0:2ae:572a:9f19 with SMTP id
 d9443c01a7336-2b06e3562d8mr44315545ad.21.1773857207938; 
 Wed, 18 Mar 2026 11:06:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e4314easm47354355ad.21.2026.03.18.11.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:06:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
Date: Wed, 18 Mar 2026 11:06:41 -0700
Message-ID: <20260318180641.1797902-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
References: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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


