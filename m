Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8888CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEaj-0001PY-9d; Mon, 12 Oct 2026 07:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEPW-0007el-6R
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:41:43 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEPU-00088O-G8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:41:41 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3a80d1c98f5so996255a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791805299; x=1792410099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+xnFkEsgbhMSblobVfa2gVolg6q1b2Mo+aPU6vOhQQ=;
 b=gTj0rGkKnYld9Jzl6M6iKRvXr8kyKA7M5lGcjTFIzPqNVixBWp2QhYdVcIdFIgNjIF
 1wMODQPJ9kqo1sFkk0cBVSFqFByARtDM3KmhBDLlTh4ganap6nQEQFuFt8abafrSAsS9
 D91OwKTGs00B3MFxQHc7buoVowfDP5WozeKSScirrj2gHt1hnclMRlamfPMsL+psrM9q
 Nuu8RvZgUL0pitmircmyRvhQdGuh8ZmPuUgpLMAO8tiIncZm+mxr+oKGChyhLHOx2V1U
 ZOoG8WlC4IuCbxuKE38x98WM/VGyh0LNRoD9X0/byWvZnKkQM2avb7nXuDfS7+8JYZME
 IH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805299; x=1792410099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F+xnFkEsgbhMSblobVfa2gVolg6q1b2Mo+aPU6vOhQQ=;
 b=By9oX1ZeMVJKP/bxA2RQ7uq8OpRq+YQSRWtbfhom7//xM5Qqe2hmijE5nKxLHwizAz
 qblYpBDluR2JRKDJjEEQ8MoZ7/w1EgGRlz1uR6AwyLRzoGJRZbHNtV9gCFz9MrZkWRr7
 P4/ZonNXLRGpGnXd1h2CTYwCIGfVoJ2Rqu70OdFsvlBSq2cvkef9uBfHPch2U7+e1HAb
 vSeBlI4q+Ec6TZtACZqt7XRfYXKRwLNEcGEbGPWQ2XzoVKef34xvrXHb9fcg03D40tJn
 5lI6A6CqEFQekO27lHJX+Bpj1L9iuruEjsRpxMGJDGt85Fdi5FORcnpSAvMSzblrlVFh
 3xhQ==
X-Gm-Message-State: AFq9FYLL6SfMeOEkW05QyUe4H5VBZ5YMx8EyRUrN1ftGjeN8BQZj171f
 fFk83EVcua8mlFcM9llCvP282Y60qdzslr6EF2HGJtSZNIE8jNXtObAZvMNXejYBdikVdw==
X-Gm-Gg: AYBFou1Xzuc4B3z9m1YyhP50wqyDjSs5vv7i2qHX/JFDFmkdc/ROoP3tq6qMEsa5CCe
 c44RnnjqAC1IHHJbcX97hfVLxntlDEpQjBx8iJ6bEjaRYTYND8mGEYnLDdiXuCrOD2qvYfJXFrT
 e+cZ737KvEZDu9zCTkrhA2kTE3rWF9HprsbXNtBXas9blqJ8nKelDFAo4LRoJ+Da6e3EAAWr8u9
 UBnExQ0aI7hLuAmp/YBdwdOimp5AyJaWFh43oONuIW+BG2Q91VHOrl1cyR+oXnx9tzUM0bTi8WI
 6lwW4ZI02P6mx1zmGQhWGVTx8K2dLeGzqffGFjhjkeGLTaHQsFycJ/+1AF+HLV6Fi4PgOupg1s3
 7V/oVNOX2dP3LpzpD8xWK4Yo4D7dsIidN6ZOQ3n0wWr/Dcw2MWrLf5aG2QQlnQ82JZhQMt1QDkR
 LrjWKVBrdLxayJ3nUPjtVG1/mNt/G/O0Y9LXQDc1/PleGe0RPwve9ToYrt1xoAaIDqboQTNRinA
 g==
X-Received: by 2002:a17:90b:4e8f:b0:3ab:c6c:51b8 with SMTP id
 98e67ed59e1d1-3ab3ac91ba9mr7109445a91.57.1791805298829; 
 Mon, 12 Oct 2026 04:41:38 -0700 (PDT)
Received: from archlinux ([2409:8949:4c50:eb:9b22:b05b:94dc:7aa0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab421566acsm8614008a91.3.2026.10.12.04.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:41:38 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH 2/3] hw/loongarch/virt: Fix clock property name typo and order
Date: Mon, 12 Oct 2026 19:39:57 +0800
Message-ID: <8e36ee3baff3e6abef94cda37d564aeb690b161b.1791803914.git.waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791803914.git.waysorrypub@gmail.com>
References: <cover.1791803914.git.waysorrypub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=waysorrypub@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:53:15 -0400
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

The original code had a typo in the clock preperty name, and the
property name and frequency value were in reversed order.
According to the _DSD format rules, the property name string comes
first, followed by the property value:
https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#data-format-definition

Signed-off-by: pillow <waysorrypub@gmail.com>
---
 hw/loongarch/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 54965f0..4081730 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -336,8 +336,8 @@ static void build_uart_device_aml(Aml *table, int index)
                                   AML_SHARED, &uart_irq, 1));
     aml_append(dev, aml_name_decl("_CRS", crs));
     pkg0 = aml_package(0x2);
+    aml_append(pkg0, aml_string("clock-frequency"));
     aml_append(pkg0, aml_int(0x05F5E100));
-    aml_append(pkg0, aml_string("clock-frenquency"));
     pkg1 = aml_package(0x1);
     aml_append(pkg1, pkg0);
     pkg2 = aml_package(0x2);
-- 
2.56.0


