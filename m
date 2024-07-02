Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE166C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjzF-0004BO-6r; Tue, 02 Jul 2024 16:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzA-0003kW-Af
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjz4-0001Xp-21
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dp+XdzPzdo45On8QxmeO3KbH8ukLhYQRI6dbRMmEeEA=;
 b=K2Z/tAkQCxYMFh/IZi4BRvjhZ3ZHoTGoT/LlCCfvmVQCoahpDX1Q19KNv4dIewDVUNMWxE
 oVsIEYtrYkRnYT6E9JqzHHoxmvm5Ssufzaa+tdOFdd7i+yUoTay8N2ts6iGbKcDf+lyXE0
 m9QHPJ8k30jN7hOHRXw4z51FDG95LQ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-WCN3tHwvPsOl2VZ2dl6gJQ-1; Tue, 02 Jul 2024 16:20:11 -0400
X-MC-Unique: WCN3tHwvPsOl2VZ2dl6gJQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678f832c75so400839f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951609; x=1720556409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dp+XdzPzdo45On8QxmeO3KbH8ukLhYQRI6dbRMmEeEA=;
 b=hLv3bXXY2cRLxzv09iLG1aq17VT11ls89OWpyLnm9Qn+gM29f6IDMgqMSDmIEuO59w
 6hysSYtmNnts65pfi0J6BA82MLG2bPMw9yFLogZnfDX4gGfhXeH3hXlcoK8E+kFNhxzX
 upse805rDDl7Mts2121n7MzYOiWRI54XIFtR9BNFKSL1KBzloDG76Qmg9sEKJLZkWXDA
 5tnvtT3XJ+KEJD7xrgLJYxpVH0t4ONinWO5d3ueLNLk5bArEoMtwo7HVSyy+BgIZpbQC
 0oDSQq7vyS77nBTVsamgdJ9TzyKDaUkwgvKDIaaw7b8Nc6gL3B6OYdIx2dfzaYzpuMLM
 WyBA==
X-Gm-Message-State: AOJu0YxJRCPaa87+hDso44aIHKnFtBbbWvC+ptng6V11oleixfIsaHul
 zWeaVoCXbr20YxVCd4RqhiwbYgQEuvyslAbF85ors8e3AJ0W6D9F4MiE+VgtZng9b2KXi9xXHUe
 WS6zSE62lFm7DWL2PR9nbR9aj0n2ATrbGnPN0jt+zrGEFuMhgcL7YhsM14Iq5RrYzy+HW0KmraV
 XiP8YX7QhJpJOChEU/JFqF6Jf2SBsvbw==
X-Received: by 2002:a5d:4b4c:0:b0:360:9dd6:cd04 with SMTP id
 ffacd0b85a97d-367757302c5mr7648665f8f.67.1719951609729; 
 Tue, 02 Jul 2024 13:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvmtFfBhGN26u/fK2aB6K8p2fGfc40+p1ojp++UYCJByI/yRHLmyW/oP5qevNqOgt+0dpJyw==
X-Received: by 2002:a5d:4b4c:0:b0:360:9dd6:cd04 with SMTP id
 ffacd0b85a97d-367757302c5mr7648639f8f.67.1719951609092; 
 Tue, 02 Jul 2024 13:20:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10337csm14058915f8f.97.2024.07.02.13.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:08 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 74/88] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
Message-ID: <475305d63a17f5ae7371ec94f614bfb5cc984d01.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Update the list of supported architectures to include RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-14-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index dcf2e2f221..c1092fb8ba 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_arches="x86_64 aarch64"
+qemu_arches="x86_64 aarch64 riscv64"
 
 if [ ! -e "tests/qtest/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
@@ -36,7 +36,8 @@ fi
 if [ -z "$qemu_bins" ]; then
     echo "Only the following architectures are currently supported: $qemu_arches"
     echo "None of these configured!"
-    echo "To fix, run configure --target-list=x86_64-softmmu,aarch64-softmmu"
+    echo "To fix, run configure \
+         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
     exit 1;
 fi
 
-- 
MST


