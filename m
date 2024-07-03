Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD59C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nP-0007m1-Mw; Wed, 03 Jul 2024 18:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nN-0007Wp-AB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nL-0007AR-GL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1BCTKIu7zTn8KYIwKYaAlAh7ZMPZO9ZVLyIB5EQHjk=;
 b=eMJ+VCrAISPwhMOrSLFgZlhElbArLj5m3mg08RbFyIxlv6Ghhxr3hFJ+i98o7Hbj1arYVi
 Z+XAnFmGVyWepbivn9XxC7V9L31Utvb83SJpThTwigYwJ/jN0sr3fTNRS0siphIMY+6YsJ
 2HsP0a5M3Tf4igy2/qD1tes/E64FOFw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-RO3i55C9M2-6SWBJKPn4UQ-1; Wed, 03 Jul 2024 18:49:45 -0400
X-MC-Unique: RO3i55C9M2-6SWBJKPn4UQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4257f95fe85so21265e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046984; x=1720651784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1BCTKIu7zTn8KYIwKYaAlAh7ZMPZO9ZVLyIB5EQHjk=;
 b=hOOtSvQyNM71xon4Le+3h96SoP4oU+ewAeFihoZXjKlDfHJGNAyXe2OIGh/1ig/Kzz
 QVu0VRMFSdeKn4+mqEyKcKx31JK9RIGilj0JJxGmlZ9vDAFOeeBtXXxUBBf/o0nKPB89
 rY37jn9opS2k4UeMwIvaYiXbPWjV0rsXGYRP3mAep/seiSMWIkc7IyDwKjeV9Xc34s7f
 YnHUDhZ8YkVwJzDbVioY6JTMPo/vJcByHnN6w6TbYZn22Z3rQuLazVdC6TV0iB2vQ7PJ
 KkzyZt+PyRaDfPOsqSKi4U8GMxKggGDqaZ7vpT2v1IQzXvth1s5w1g7u3NSFVlBvvpm1
 xq6g==
X-Gm-Message-State: AOJu0YwNg7PidZpaUhv1ApJhOwuTNHj+Z4rnLjrRYfoqvv7BCUsptTAE
 dj29yCEg0mMEhqCToqq74atVF5NR5MRCd2rnIWsD1TZTSoOSeSJKKvfI7F1/P55IwylTIEDLQv6
 cb+pTywMN/zFDLnCMcsd0kLJXKypzHmrDl3Y6tAest8kDxIdviqL07cFPC5D9CbvxPc+m8oobmT
 nswDZBrO8psfHgILi6PbzReA/70YnJAQ==
X-Received: by 2002:a7b:c84c:0:b0:426:47f5:66ef with SMTP id
 5b1f17b1804b1-4264a48cea4mr216405e9.40.1720046984002; 
 Wed, 03 Jul 2024 15:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdhuLVsoiWVx8mB7byFmr85tdMU3KTuTy3lsurMZLVFjYMNZl2q+tsxaxcaNZWLQzQrxjJDQ==
X-Received: by 2002:a7b:c84c:0:b0:426:47f5:66ef with SMTP id
 5b1f17b1804b1-4264a48cea4mr216275e9.40.1720046983516; 
 Wed, 03 Jul 2024 15:49:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f2375sm1215675e9.27.2024.07.03.15.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:41 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 70/85] pc-bios/meson.build: Add support for RISC-V in
 unpack_edk2_blobs
Message-ID: <ce7325c160953e717ff662eabdc7bb911029760f.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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

Update list of images supported in unpack_edk2_blobs to enable RISC-V
ACPI table testing.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-13-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 pc-bios/meson.build     | 2 ++
 tests/qtest/meson.build | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 0760612bea..8602b45b9b 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -4,6 +4,8 @@ if unpack_edk2_blobs
     'edk2-aarch64-code.fd',
     'edk2-arm-code.fd',
     'edk2-arm-vars.fd',
+    'edk2-riscv-code.fd',
+    'edk2-riscv-vars.fd',
     'edk2-i386-code.fd',
     'edk2-i386-secure-code.fd',
     'edk2-i386-vars.fd',
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 12792948ff..6508bfb1a2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -259,6 +259,9 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
+qtests_riscv64 = \
+  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
-- 
MST


