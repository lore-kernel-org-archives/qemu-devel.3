Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9725ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEG-0007l3-GT; Sun, 05 Oct 2025 15:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UED-0007jj-Mr
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEB-0006SH-JD
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQccCBnzaI2vbnXja20gty2VSpVTUvCQbKMpL53IPwk=;
 b=NssznSHdTm8jraZGctwD4vXzmQH88spgfsjIDrDij8wanuhe24R6DQjgIUL1Hr0lLzmyeY
 h1ibTxuSIj3YmbxJuYmqqQBRveUu+PtnRBe04im1QM1Iwx5WN7fdyquzgDyPVMc+ggLxdf
 DT5t/1g/b+rF6k1ND3yNdLDZJvRN/wQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-tHv4QRhoNgWgppWrKYPzew-1; Sun, 05 Oct 2025 15:17:01 -0400
X-MC-Unique: tHv4QRhoNgWgppWrKYPzew-1
X-Mimecast-MFC-AGG-ID: tHv4QRhoNgWgppWrKYPzew_1759691820
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso17543905e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691820; x=1760296620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQccCBnzaI2vbnXja20gty2VSpVTUvCQbKMpL53IPwk=;
 b=lMertB5lEijbcle5yK9RrH85bG518wuQAGecrm8TyvK0RW4Q/pr7izIwz57KgPxoBH
 pT8Yvxy2o9gUS6wbDY+PQu9jOf2U1c5kMTn+erjlkMprcAOQBbm/f1juurRjFp+N8VEN
 Ez3Fy5mwzCnHgYn9QyCISoz4/ke3VLrvJeRoIp89046QP/GyVCcIemwtqchNhUO6/LeQ
 vhjPo9Fcz7MujmDYL2rJA9tve6exVIv1dd2u+UBnWL0fsYqHpXAB82YhK+RMMZFscP8G
 5B6Vp1MH9eAxtjUpWMDInXZ7ZL5jRSyMGIPltAZpHm+CI7Q9odc4XWv2g/vLPukQCUBA
 TCQA==
X-Gm-Message-State: AOJu0YwT0zYl8AKIRlXCA4Ek2hQwgOcIJQmiaEgcVXm87AYYvMhc5TQX
 74EtqEt8/iLn19hTaTiV3+0zJCtL/aLZk2KZnGjwjLwzNsUmd6MbfTAoj0V6Glm7c6vhTcD83sL
 nTSJbnjOD2TjHQv7X0fgQ+9Pm1+R0QOKz+zA4aH1Vsgwm6Hdy12YuTPIh3rg/61qAkhm+1052L7
 Wl1TmYxJbBW7VDXU6hNs8g1/MboKuWLKB9jw==
X-Gm-Gg: ASbGncuh0OS/gDFppOQzrMTRJtIcCh8sLCY1hXoJ+UL/fWscu13hS/auYnbbYXWHcg+
 BHP2/Wn9inArzxCRal6MCD5jt80sArdTxjMmkgApchkMOfCLiCuYTZTUtJlYk2mKZ4i9OSa//6b
 Y9GG31UP6ClJSOFIFWvrnfXh2AJ72s1ZnVGQOm6v01fOpXi4YDQmL+mimCQVvQCb5sUNfU5xso2
 XihSNaYIP31kcFm4N3LavEgbxXqch7ldcQ5Q4GhaVaJpK//R5CgXLsd87T5X117M1Yap6ZmZMK0
 QTCdk8IpPCcl6CWX5BDFk4t1F9ajLXRbqySdjPo=
X-Received: by 2002:a05:600c:468e:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-46e71102467mr68691045e9.10.1759691819681; 
 Sun, 05 Oct 2025 12:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGbCnpofifWPAe5hJdopMskr+0e13LIxhzNteStsJu5IOJLR3rNy/zKd/DT6uVpHyMUMissA==
X-Received: by 2002:a05:600c:468e:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-46e71102467mr68690895e9.10.1759691819139; 
 Sun, 05 Oct 2025 12:16:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01a0sm17392040f8f.48.2025.10.05.12.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:58 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 25/75] tests/acpi: virt: allow acpi table changes at DSDT and
 HEST tables
Message-ID: <79b10b6639456d244118cf564214495637494931.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

We'll be adding a new GED device for HEST GPIO notification and
increasing the number of entries at the HEST table.

Blocklist testing HEST and DSDT tables until such changes
are completed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <7fca7eb9b801f1b196210f66538234b94bd31c23.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..cb4b0a9469 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,12 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.viot",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
-- 
MST


