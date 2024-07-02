Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8818EC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEN-0006od-JZ; Tue, 02 Jul 2024 10:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDh-0005AH-Ea
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDf-0000QJ-Su
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1BCTKIu7zTn8KYIwKYaAlAh7ZMPZO9ZVLyIB5EQHjk=;
 b=MwZMYwjZaODlNH8EanL/fnlTi99Zty8KcT0fK4V4tMeAhwq7PFouVAe+C7RTrIAkcbir4t
 5tHhNjMrSwySxGvQCzeu1zWSfx0BgKQjLbOdSg2joAh00sib6QEDQ/JvrwIKotnbuhT6JV
 JqNFekhPJkj5lDRCB3t2wUdULSeYy2g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-4zlfdHNkM-2nFnNmVFLG0Q-1; Tue, 02 Jul 2024 10:10:50 -0400
X-MC-Unique: 4zlfdHNkM-2nFnNmVFLG0Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4256f895ce8so31796115e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929449; x=1720534249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1BCTKIu7zTn8KYIwKYaAlAh7ZMPZO9ZVLyIB5EQHjk=;
 b=gVgy8xU9CF+M4XJlsqERBMIDm2pCQ3JQZEJE3ufjrnzyl/DH/f9rezPwXcSVs7uxzX
 Xo6DCwLmTtg9cJvbJbOAM90cYrPpCSZPPyu11ayyAuw0lt17ciWkFAKUHRnU8/xKupyk
 bOreXtnObe7hpYtH9AzGYZckIfhbHcDEdL4EF7vKcYUhHA8iUH/WN4a3uOkBYOVoDyCV
 1Gcktzh9ViMiDdpJKbGpZeKzcsUmV16hXu2kTJVrz+9GJj9+C+wnK3EbDR3gUVmKnD6o
 hEapq79nU54VDEo58qUg0oGg2rYwKMscqylh4kU8lJHVs9VfP48p4bw0nmro2DLaPtl2
 G8yA==
X-Gm-Message-State: AOJu0YxU7hEcitLZOJvbUlV3P3S/Jaq9TBF45FVxdc5XJ8mSDfVjZ0o+
 HaadA/dZdPQcw/WVTh5dA8d5wTbhvXgHV7myULdM6kID+EdkIhxSGaHiefoOQw0pMvq6lkBXNtK
 LgUJQV22QbiH/8Uvqv4XV71uEVgeLA8tsbELxRsRKP/Epz74TLRibo9Sd8oH9rcxK1+tcNmhftE
 euO5+PD1O2DEb2+IQZVMnsz8Kb4qm17Q==
X-Received: by 2002:a05:600c:1616:b0:425:6bea:8554 with SMTP id
 5b1f17b1804b1-4257a05fa13mr59618135e9.27.1719929448949; 
 Tue, 02 Jul 2024 07:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA/TyojuA+gJdMqFu0OqF53+4p8fcjQ6s1IicICG42SwFCXQCq5jYynweYltGZXY+CzcE2/g==
X-Received: by 2002:a05:600c:1616:b0:425:6bea:8554 with SMTP id
 5b1f17b1804b1-4257a05fa13mr59617915e9.27.1719929448470; 
 Tue, 02 Jul 2024 07:10:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a94csm199702835e9.33.2024.07.02.07.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:48 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 73/91] pc-bios/meson.build: Add support for RISC-V in
 unpack_edk2_blobs
Message-ID: <5d3f12a7d423ed09aff5843ee7e955bd0d0d8d9f.1719929191.git.mst@redhat.com>
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


