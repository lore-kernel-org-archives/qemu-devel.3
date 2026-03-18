Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F47F10775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vIB-0000fa-Mn; Wed, 18 Mar 2026 14:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vIA-0000ee-KW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:06:50 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vI8-0002b0-Ql
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:06:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso806035ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773857207; x=1774462007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xi3wtUPnsMLrMdL/4p8TEAcOyvC9o/Wnl59+X7cTCTY=;
 b=WVljVcJCZzLa2l6eEv7f7KEY8f7X77jpB++7U9BwEpoufD7PBX5WPLxQq/i42uhUdZ
 m4CX9Sk27pFDEklXtvo/57RcmEYjPHhFl6jPgm8++KTqLQa47au0TCyvbnQDTphAUoS/
 /bbcThkFepWN0zM/qd2WkcSZenMoVuhm95PGuz1in8/1fYPIHu5T0rtaBjAB/4lQo7WF
 cpvcYKrPSfLd/b7eA/o4mpf+Jhz5p0X8IOpxQzKLIWmqmRsUezgLC7wDP5PLZP0dkIZ3
 /vK8iXreBEX8jobIInnoq657lqMkm7N/JSRG7JjbvEMmfdhsvBE1B9IPVZyKMpWEqjY8
 jrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773857207; x=1774462007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xi3wtUPnsMLrMdL/4p8TEAcOyvC9o/Wnl59+X7cTCTY=;
 b=MymLl/NZTI9/xZIIhDXreUKCZDUeXtADKtINwBemeDDJ77RYF32DVqIrLv2KS5VU3S
 ZN6CHWGm5rKNN5eTiCrElpDT57+PvBy9jqpy+j1JbG23BEgCYL1MFvfiSAAcRD7Uuq49
 zgiughUZaNN/Wq7ilQdC6gSyL9TPx70st1p7/BnqoRyv55TG1CpVzEku1fNrl7sJT1FL
 HnNA6aN/1pSOXeoXTkTbLYEol79cVmRLxuP1tdQFHlbd81NH5nXWuH4X1PAkDxO9WUrR
 VQFIeqFuna96tckQmz1IBDQ/l0xgJ2H8Ke9SVSdQmVaIZWVobwiw/5xTGwXnaTG+uZ44
 1PgQ==
X-Gm-Message-State: AOJu0YxZgUb75coborCF4hy0xTNmXSPG4D+GY/KMrtQnBltxeOHLPGgg
 2Oz6Jw2aK0a0NbZBhGDH/uWhHzycZqBWlACAv6D6iDYaYLArByEqRCEmuVqslth77wT53H5p3Tv
 TiObCD08=
X-Gm-Gg: ATEYQzzULL5sgLko3LXYacFADIOvU/bd3+ge5meP/WQQklI1gKWz1f8TsW0ssteBr0z
 lhxjuGS6nFNXE3tIeQOEpxip+/oNZ5IqQx1S8KVNe1aBg0fehIAmOSVD2EfUQuXBZpJcwc95Yj4
 Nrbr6QdlTt8o1ag7BPo7M2OxHYIl9pyZFSUVzSanPIJvP6TSv9IOQNB6RT09W0lKGFtrhV/5V3v
 R7MI6dFSa2qE1Q7xbH4R3pu+HaaG2RmTYgFH2iBPIsgTZUMfZ+XLu4DuO7+HsaoY88VZt23wDz7
 mP0JdmdZmnS8lj+GDOvXHeFIzHJxjMlrj5qGjyAdliuqz0VeiuU0rJ5ubyRw+uGy/dInRewI/Mv
 32iZYjkOWU8c7Ve5Wc9UcuWJGPMJikDyMxTxCv9L1zB76xjDrNrtBy+F9XfngCzSUCpXbAm/jxw
 clo2qq4iLEGcex2kNVRCpD0SRRJIrCl8wixWhGVtKS0jHpUsGCr1T4synco2rKMRYqj+rj54STy
 iki
X-Received: by 2002:a17:902:ce89:b0:2ae:c9be:5f2c with SMTP id
 d9443c01a7336-2b06e32bfdemr44563255ad.21.1773857207084; 
 Wed, 18 Mar 2026 11:06:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e4314easm47354355ad.21.2026.03.18.11.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:06:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Date: Wed, 18 Mar 2026 11:06:40 -0700
Message-ID: <20260318180641.1797902-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
References: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

In case current kernel does not support /dev/iommu, qemu will probably
fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
since QEMU opens it before /dev/iommu.

Instead, report an error directly when completing an iommufd object, to
inform user that kernel does not support it, with a hint about missing
CONFIG_IOMMUFD. We can't do this from initialize as there is no way to
return an error, and we don't want to abort at this step.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 backends/iommufd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index acfab907c03..2c3ca23ca0f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -72,6 +72,12 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
 
 static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
 {
+    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
+        error_setg(errp, "/dev/iommu does not exist"
+                         " (is your kernel config missing CONFIG_IOMMUFD?)");
+        return;
+    }
+
     IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
     const char *name = iommufd_fd_name(be);
 
-- 
2.47.3


