Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE687C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjzD-0003x8-1B; Tue, 02 Jul 2024 16:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjz9-0003hu-US
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjz3-0001WU-1V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1BCTKIu7zTn8KYIwKYaAlAh7ZMPZO9ZVLyIB5EQHjk=;
 b=Bd2WN6hzJmjTtl+c3fMljp9s/PmOalLbVVzuo1/H9nPgpdqE+cEkJqYEKd//ZgXfEqWDQB
 7i3P7Pzd4skFi8i/ahqdkvT2jmpG0pIdS1B6RyrWymJEhh0vxZKpdVtwWqO63+aZuQuYCc
 OCy4N3SUYDb5WyokoCqSQLA5bAxHL3E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-vnYDNjUCNOy6yDbyzSa3sQ-1; Tue, 02 Jul 2024 16:20:08 -0400
X-MC-Unique: vnYDNjUCNOy6yDbyzSa3sQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52cdd8ca5a8so4683058e87.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951606; x=1720556406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1BCTKIu7zTn8KYIwKYaAlAh7ZMPZO9ZVLyIB5EQHjk=;
 b=Y9Khth4bzo3NCJ2oY8tTeYeaR9ZWUVmlU7ForFx3jcN7aE5FQXzJ1w0LxNE6ST8ERF
 eFeD0/52rAUkdBT08xAoJTKn5Tl9Eyj+1HQmCo9sWxRxa9cqCesElR4XddDAkeZP43MI
 NCqdFuF54/Ao3WP71ybAim2ekfBAZiGBzwtt/8GdPQ6zBISK3YkHr3EtSN879HzQGuEt
 sKDBydaw0RM5c62X6NntURVf7FGV9HWxDwOELybTqWa/fd4JLfPns2Ox/fbnaiT71A7x
 /H3/r+0Y9mt6cnrn4tOvvVidTWRgpxCIoUQW6aqTpu8vLgAVXmezdLEc4kLJYqfP6q9v
 EPTg==
X-Gm-Message-State: AOJu0YwUFeWPqYHZOgfMPxzQ6vG8oErEDjY7FmBSm4YETZnXS/VrBrw9
 xcCZQCH5zKAxTSN1D4SwN+bgtoE1QEdTcy98jmLdyoazaoJgs4xWwRhAd7ohbwhzojTDKwCcMzW
 NYdvR94va216FXV/YOyWYCreEF09zYR4AsyRKe4zeZ8IpLyRsi/rU8N/CxHEMUfZWeuL2GZxlB9
 N2fZtUR0lVrqueqV659dFcqWVFyOWt+w==
X-Received: by 2002:a05:6512:e97:b0:52c:cd7d:4e7d with SMTP id
 2adb3069b0e04-52e8264bcc0mr5622044e87.5.1719951606452; 
 Tue, 02 Jul 2024 13:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQdcJn83d1MAcxWSS7aSrhwqkgS7XopI9M1ZemrWgnDFz5oDPQV7TIFGNB5gh4PhckfdQfJw==
X-Received: by 2002:a05:6512:e97:b0:52c:cd7d:4e7d with SMTP id
 2adb3069b0e04-52e8264bcc0mr5622023e87.5.1719951605760; 
 Tue, 02 Jul 2024 13:20:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af552bbsm212110615e9.13.2024.07.02.13.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 73/88] pc-bios/meson.build: Add support for RISC-V in
 unpack_edk2_blobs
Message-ID: <60eae0fbce9e4049aca4cd078e20fbf83c488551.1719951168.git.mst@redhat.com>
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


