Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE80C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGM-0000AE-M1; Tue, 23 Jul 2024 07:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDG7-0007JD-Ky
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDG3-00030s-OY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0mtOB+kdXXWYOHCvpvehEzKr387KURYV1YXTFOFkqBM=;
 b=aznLcRFW9WCeqzfl1Mj5jbCAjK1RFmNO2Q5dz2yj0kN+XiOmKO/o29bC/SACvDoJ+Hzljn
 0c156Nu+9uQUqKTuME4CBG4kN8NXhHD7Zk0U5rxEi8rSO4Dy6fk3kJphcmFtS2bTl6SlIm
 LgkM4qKIK0saACDvqaJlRFq3OUu1Kb4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-l2uQRFDyN8aQKsgpIszzZA-1; Tue, 23 Jul 2024 07:00:37 -0400
X-MC-Unique: l2uQRFDyN8aQKsgpIszzZA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36875698d0dso3779872f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732436; x=1722337236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mtOB+kdXXWYOHCvpvehEzKr387KURYV1YXTFOFkqBM=;
 b=O1AzPlv6NqaYf4qw0F3PEH2ygyLQcKSGdjmshfLk0w+tV2DtGa5tHBZ9meKTEkVS+F
 nSRgGmJIqqBG883zuNySc+jxB55PS8GUo1L+yl/U5zcDZEDZNncyF0s6y8Db+vzy7hY7
 fqvx9/fmMFUlN+HQ8iyNW1PehrpNeSnr03wOR8++EkizWorBf7ilAEyAMPlEQdsfi5AT
 yvFTCw2eOtlTM++AY7jMBONYl0MlaAzeSS0FbCUm0aRoIviSyjqTzt7GL4rsrGKgEMxK
 5tkybRfKT5PjmlheNell28dzPfBS62zJZfep1WfTAZDVBd4dPNrT0t0oLZ7Ez7MSpK+W
 iCfA==
X-Gm-Message-State: AOJu0Yzixyfe32pTu+i6MAUe6ROSIkTVSUVHbgBhc5HCZlCp4UJ1BgFN
 aQG8WABhbVUy2sIrX+sPjMRWMr1USEHEmkwuPnpTCe+EBBvJIW9EYmlEliLlQPsPxPeDlIatQhb
 FMq2QOchygEqvenM5eXHKizYSJLjj7mASWCeLE5dshx3JWEsdxKpSarrifIfh4B42QroArrWUX5
 kPc+h7xDfdMKUQUUDsSeGPF6l5f8SE3w==
X-Received: by 2002:adf:e952:0:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-369bb2c2a1dmr5823627f8f.55.1721732436022; 
 Tue, 23 Jul 2024 04:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIBQBfFrhcW/Hs11XYdjeLpCXDnds7WpsiyRZtrGlE6eFiyHOF3DzKg38ss9ZwAMqk1ak7zg==
X-Received: by 2002:adf:e952:0:b0:363:d980:9a9e with SMTP id
 ffacd0b85a97d-369bb2c2a1dmr5823593f8f.55.1721732435399; 
 Tue, 23 Jul 2024 04:00:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b33bsm11222985f8f.33.2024.07.23.04.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:34 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 52/61] tests/acpi: Allow DSDT acpi table changes for aarch64
Message-ID: <af09c25199a15925c34ae8c9635a79a81fd9b499.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

so that CI tests don't fail when those ACPI tables are updated in the
next patch. This is as per the documentation in bios-tables-tests.c.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-4-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9282ea0fb2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
MST


