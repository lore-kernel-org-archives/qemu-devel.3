Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E2DC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEG-00069u-G8; Tue, 02 Jul 2024 10:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDj-0005Cj-IN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDi-0000R2-27
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dp+XdzPzdo45On8QxmeO3KbH8ukLhYQRI6dbRMmEeEA=;
 b=ax+NCpcAegEY4L8uGtvloZ7awSCjBqp7vV76PyFa5Kr9Q4PFZKApNf8UzmzXsCdYItWxeJ
 +jzRH0NBhWzsCewn44m+Gqga58iCsjYFFPbjRYX9fcmOPcuI11p+3OXhOiTKOuBUsfu+/Y
 rkWRqNH0iBxW+itCTc0BOKHoin0FXJE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-A3gurigOMOCR_zlV-SvH0Q-1; Tue, 02 Jul 2024 10:10:53 -0400
X-MC-Unique: A3gurigOMOCR_zlV-SvH0Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3648793ae51so2853032f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929452; x=1720534252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dp+XdzPzdo45On8QxmeO3KbH8ukLhYQRI6dbRMmEeEA=;
 b=biAXx8sq+Mre1S26zcCYYInsDVDRdvkk//maRWFFwPhrAWN3k0jzKxQnmAWrugaKBB
 gZ64HsCVn1hBcdIyPFXsRQqW+qC4GbwUArMRwgoQ/1wi4R8OXoVhrlLxqb6rZ2/Tg59c
 N2Yd6W0FmiMp4s0oB2/WcpKr9x0JNdpyRnRgXGHxaSFTLcZrnQxu53BIgXdKNLk9Bi0A
 6Wbw1K9oRjpAhx+DD4ipN4XfPUcrMGA1mviJ1zCjrOftq1izuA7Nd1RrsLZCqnGBc81h
 RdHb3YKEauJzSGM9B0LlbOpK6YuKM8uZQR/DOPaqmLhjx8gJFTfgz0XrpRf/4WFduIC3
 OpyA==
X-Gm-Message-State: AOJu0YyErLnpTDRHxKzRa+tDx+8ESS4IhjaBICHnZrCui/NXcCTzd4Uy
 j5F9wVgu7EKyFYmJuuGvRL71nnKIn5hzU6pHtfNC8lec/mBJhy1D3skS9bjdZ/eDoLhTZWSqq5e
 Y+FuYr0YnOYVxAJc539U45sR678xEgnfymN7vsT9Ycejqid7M+sTPtakZgKlZLq66x/mgNz1/sb
 sUlgH3n0NVdbgyfNSUVTa/A242f/hO6Q==
X-Received: by 2002:a5d:4487:0:b0:35f:218a:ea60 with SMTP id
 ffacd0b85a97d-367756ad6eamr4985710f8f.19.1719929451809; 
 Tue, 02 Jul 2024 07:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaVfIPMlxCcD/zXEDodQ4i+Q9OAWvlTaxtZYKGS3ps4dtVcEtJidlaC689nHpgdInozezujA==
X-Received: by 2002:a5d:4487:0:b0:35f:218a:ea60 with SMTP id
 ffacd0b85a97d-367756ad6eamr4985690f8f.19.1719929451306; 
 Tue, 02 Jul 2024 07:10:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8cb4sm13332736f8f.25.2024.07.02.07.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:50 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 74/91] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
Message-ID: <ca5e2726dd86e10d15a54665fdb26245d151ee0b.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


