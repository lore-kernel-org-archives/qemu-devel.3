Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2057DC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZ8-0002HS-D2; Sun, 01 Jun 2025 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ7-0002H9-1T
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ5-0004eS-Ie
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=406buaJv8mgg7FCF8JFusePlvpZgWOp9GQT5SL3Z3sQ=;
 b=IsESnY0+UmHfQbOhBiC2ySvdQMaQsq9M8K4gZaMiOel1ZHAq9OdPJmlYPHM9IHeEw/AOSH
 Gyd7SqSEy9szhB5hRA9/RSfn7AylXfn46MzkDBPVlF2TeEtB05z8YSmWs9sLKp23EiQql+
 C+kxaBumCPrYif1C3zpujAHuIzXE0/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-fWm_WLvWNaWIqwegeNGMIw-1; Sun, 01 Jun 2025 11:25:34 -0400
X-MC-Unique: fWm_WLvWNaWIqwegeNGMIw-1
X-Mimecast-MFC-AGG-ID: fWm_WLvWNaWIqwegeNGMIw_1748791533
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so190232f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791532; x=1749396332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=406buaJv8mgg7FCF8JFusePlvpZgWOp9GQT5SL3Z3sQ=;
 b=JtoeByshDdtvKEQcijzFX1qcheLGA3XojQ39U+PITz9TWBzO3CZqTryB2xCP5YqaLw
 1uxfD0FEkpmEPnYFkf8/Vo8teB3qrPdyfdzhV/Mp9s2bQMDAoqelXjnFhdaSHaveuhRl
 +r4H/XjPAN42xkgVy5z+D4fEUajhfbG4VQGwZxNihBn4r21J9S1Wi2GZPyBujRruWA/O
 5DEvJp8jIGwGIHi7vpioaECXQ6NFSWGnD7Gyg3iZT1cUjJBeR4oAsY3QTiqPNy2xp8fq
 TAYF1c2KpfIxij9zmVs3CivwLy0nTVt04tKiWMscoH7gzhmwKZMy18IJ5AVOdMpK7KK3
 im2w==
X-Gm-Message-State: AOJu0YzRtSN04YjJBtcRGm74aKmBFM4I1zA4w1OpYTTjQuJdXHshtnSN
 5M86Cbfc6wJzSDtsq9R4JeEZF42s7XhTbkPRgjXBu9PcjYYlEdSgnsTtIMM0TYNVo1caC4mDwWy
 pIhCWYqyRReEB08H/LLpntDXTnl40HpmFYUCW2r9bLMzQqYJb7s+sOuoZD/qEGFzxLuAStXnK+X
 ZBymikHK4VItuoe6GT9thGbOPF8NvIvTzpmA==
X-Gm-Gg: ASbGncvGtfWI4cfPdF6xOvv78Ab1hxh+H77AZyf61VeFG96Kf2Oh3cUZMrckeIIuqFS
 457IUBJYOEz2AyVdKI7T0V3x++S0ngPjBj5p5JLpc8udw/dYyeWtCiY5xq2awzmQJ/cBqeqsUfe
 dO2rt0eeJkM94Io7CjEB8VoEtLkiDOqUKjoP1AcXdgBHw+oLSy7cazkH99su7jxoDN0UA2g9MSO
 I3QnLQP5y6i5VMTIEjE2UrYe58F3m4y2scrVyOLMW+xOSq9TSfZ3jxBgegc349EddkFjND0jsl2
 UA/xBGElVi3vOkI4
X-Received: by 2002:a05:6000:230b:b0:3a4:d915:d652 with SMTP id
 ffacd0b85a97d-3a4eedd4eefmr10326820f8f.29.1748791532274; 
 Sun, 01 Jun 2025 08:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47DOQmrpjqaXWX/LPuKSMJ/BU8irFFKeS0BEwRXrFJfNb9ShpPMLXjINuUlu68WWlaPLkxQ==
X-Received: by 2002:a05:6000:230b:b0:3a4:d915:d652 with SMTP id
 ffacd0b85a97d-3a4eedd4eefmr10326800f8f.29.1748791531784; 
 Sun, 01 Jun 2025 08:25:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f0097813sm11929263f8f.72.2025.06.01.08.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:30 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 18/31] tests/acpi: Add empty ACPI data files for LoongArch
Message-ID: <adec726cf8f953705b83b46daef8e1b0aafcb7ed.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

Add empty acpi table for LoongArch virt machine, it is only empty
file and there is no data in these files.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250520130158.767083-5-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 8 ++++++++
 tests/data/acpi/loongarch64/virt/APIC       | 0
 tests/data/acpi/loongarch64/virt/DSDT       | 0
 tests/data/acpi/loongarch64/virt/FACP       | 0
 tests/data/acpi/loongarch64/virt/MCFG       | 0
 tests/data/acpi/loongarch64/virt/PPTT       | 0
 tests/data/acpi/loongarch64/virt/SLIT       | 0
 tests/data/acpi/loongarch64/virt/SPCR       | 0
 tests/data/acpi/loongarch64/virt/SRAT       | 0
 9 files changed, 8 insertions(+)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
 create mode 100644 tests/data/acpi/loongarch64/virt/FACP
 create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
 create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bad1380eec 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,9 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/loongarch64/virt/APIC",
+"tests/data/acpi/loongarch64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/FACP",
+"tests/data/acpi/loongarch64/virt/MCFG",
+"tests/data/acpi/loongarch64/virt/PPTT",
+"tests/data/acpi/loongarch64/virt/SLIT",
+"tests/data/acpi/loongarch64/virt/SPCR",
+"tests/data/acpi/loongarch64/virt/SRAT",
diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/SLIT b/tests/data/acpi/loongarch64/virt/SLIT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


