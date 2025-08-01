Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D006C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnd-0007d3-V3; Fri, 01 Aug 2025 10:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhV-0005aU-S3
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhU-0002oD-4w
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUOuxsFcKExXqP/V7LZEk0bWxeYWJUworvF5GqipL/Q=;
 b=HfMBku3n/f9bP1zUpeVeiUxuOD0+x35nQuOR14EMvoQqheSQNg9foVtYjQONrUKO4oHySx
 hWKKnoPUXmyr6IgcKtqjNUrV+6Z+IZHhmHlyro2Xy/68OhtXNIuItu0Ple/FN8sN6zZk4h
 3gcwavYVMEmxs+LjGOzbxJDSi/eKwgM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-BAeRgtRnPy-0MSNiHL0knQ-1; Fri, 01 Aug 2025 10:25:32 -0400
X-MC-Unique: BAeRgtRnPy-0MSNiHL0knQ-1
X-Mimecast-MFC-AGG-ID: BAeRgtRnPy-0MSNiHL0knQ_1754058332
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455e918d690so15301905e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058331; x=1754663131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUOuxsFcKExXqP/V7LZEk0bWxeYWJUworvF5GqipL/Q=;
 b=fMven84KneBcXsW/PqLaNeEp1mJGsLm4m6rNS0gLv4QWVdWs/LPp9WZpyIgqyDhLiM
 dPgMQPmss63hvXsKhSxPIZambk0agiHuLEElZC97Mjm1dhmBQLFlKsS5L2Bx6HwrBalL
 cqmH21G7Xr3l9AI7zRKPAtICuEOIczI9+G8nR4hS6w4cNWY5AM6+bVuOyvTKeXYJGjqs
 Ys1vtpXd7B/eBK3kPfJ6rXjVyfBMEcSR8cbNi+/c/9nVd65P0Z6iAkbIL9yq7Q0lX7Xn
 o0o0Kzy4EnGVoVH0CSz1YymTjB4F+zuoLRJ+kM7JAG7wCHQFiZl5+olZcLp66kigM+Ut
 xANA==
X-Gm-Message-State: AOJu0YwogsU6+3fy0y3GEytrSJ/vslr0v/zKQPBMM60Wny4irk1vHXB5
 FqMSG8tN+wBT57iv3WEC8oN+vlbVxldlmvuhegrXxu3L3JzOZzbAc9CTRE9Lmj+5EDLUQFMnZb0
 LYD8GG3qpq6OJgpdlmydmOyYFx0QoQfy1U3ma08MPypuPpLZnrGVYc/vMFsCqaYz/r5gKiVnTji
 EeKBGJbogCqtXK+Kkm+VLVx8ZpryWd/3Aimw==
X-Gm-Gg: ASbGnctx6qOHN76XatC24qGhRN3cPOxffyPfAUb1WfUemiquXyv5+4Wj6HqMZEQaovC
 1FKLl0zOCdRzGt9jEEKcZn7ILIVoXMYDStkPvVtfBH3nhYHiU8zvWdPsW5TmHrLm9/c4o2fW+Ul
 Af0QZxKlS49dby7t1FspbLzSipm3f8XcXgggaIQp+280D60PPwwPILgupVqEngCOXFLLIw5IKKN
 gkVEV5VoxwP3K5i+VgSx8MW6boCm8mX8eJRSHgJ84JiOkwVJt86YhaEyQN57YE3zmU4CsvHqegy
 RBWQVgF29t8zgesqIoO4epyroqDuY5Y8
X-Received: by 2002:a05:600c:3d8d:b0:456:f22:ca49 with SMTP id
 5b1f17b1804b1-458a17e6e41mr60183125e9.0.1754058330914; 
 Fri, 01 Aug 2025 07:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrBGKjIoyHawiA1OZmeeyJE46mA4tkAg1c216rHjJOdUx5wWs8ZJXB8JcgPwvMPPtp9CesYQ==
X-Received: by 2002:a05:600c:3d8d:b0:456:f22:ca49 with SMTP id
 5b1f17b1804b1-458a17e6e41mr60182845e9.0.1754058330488; 
 Fri, 01 Aug 2025 07:25:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a6f6fsm6306298f8f.74.2025.08.01.07.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:30 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 12/17] tests/acpi: virt: add an empty HEST file
Message-ID: <8d5613d2eefa6ca94b3c642583488e20915c48f7.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Such file will be used to track HEST table changes.

For now, disallow HEST table check until we update it to the
current data.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <e25ea751a23c7d8da812233c83ce943efbeaaf91.1749741085.git.mchehab+huawei@kernel.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 tests/data/acpi/aarch64/virt/HEST           | 0
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/aarch64/virt/HEST

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..39901c58d6 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


