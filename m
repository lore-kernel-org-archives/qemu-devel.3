Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C0BC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMp-0006NV-Oh; Fri, 07 Mar 2025 17:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMZ-0006FA-MG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:17 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMX-0003b6-OG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:15 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so27161515e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387211; x=1741992011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IuwCf4WRGv3h0tr40swdZHn3OJodO5dUQXcRGaznNRk=;
 b=k3u/8O+LS0s39UwJ54KwjmBxNee5vyeut89tFmivEFbPCN2SBTHVDzm8cXSwkOQDRz
 8CvB9lWIhTy2PoHhY3bUHhw4XWqTlU9/e6MD51llTq3ltgp2lVE67bkbFQPevHmCf4FB
 BzOiTsXoo2Eg6cSgERHM4g/phDtpK0ijYFuEl4Y0qdsEgWpxMsYW+dDnjRP4wMy1vjLs
 /dKeFJ+h3ol1LUUH+ZDlf8K6p/M1EXIvOxWo74h6Cf3qRJkz6rE5Y4yfaQHUd2Kdx3XD
 fTe8WcQW7pmwKXItCqmGDmbj9mUZXVnJtD9tWUqHpfgUrc5oR0DVrJaDLJ32qP3lmHSI
 KfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387211; x=1741992011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IuwCf4WRGv3h0tr40swdZHn3OJodO5dUQXcRGaznNRk=;
 b=nL5XqMhcYekByo0LepGzTyBA59R/05CWIGlUgmOrio2exHBTdcFEqkNTK09K6RNJ0W
 9KhJ19Cl9o+FPetu7K/mskVaCrP85zmhnbSnDlHcCz6pPEZVxgOgO9lPSmIXxht+rrBN
 ej9Cba7KhJil3XOUiyFlWk4fgqGfeGaAW86qPxMzmegh6H1JJup6KvwCxcLIHOiExtRT
 NK3vfU55o3wgMZyqsrFtA4ZaCSTEWUojN7Ln0X4BzDbJ5KcVb91lmDdRR1IjJEbvsPs0
 pg5C5guF/e5sf2LCuGREAXQG1jPaursWVFh3JTsK14PePR7NHNBqTP178fCL4YOD/0Hn
 Cc9g==
X-Gm-Message-State: AOJu0YxuFul/T6+jEL6V3i5X5fTW8t4qJmRgBUZteKjlN1h1rd1k7wUb
 d0rIMvrwKEKXrn41voLxbK6Iz4WqgtmbrQsUz+tAOdfZvtfV0uW5lV0X+ju9z4pgDRJSm67SAnU
 g1Sk=
X-Gm-Gg: ASbGncs5gX4Ecrp4PWN8g1A7stwywMjvwHIZ+xfykDVwJktjM2UpZLMLuL2A0DvgGzn
 Dm3/UcNLOTrCeCoq4yosgvETx2/Oq3I+SC46oOFzr9wva48FXz2MKaF0K5g6pnmK/dp1lUSa02X
 Pgdm+Ny0Y3BrUtm9u5GuIDnnZfOd8v/SnAkVvL49pBdYwr0lpD/9Fu5PIGjL491qlTFEeOEsLt/
 aA281Ez4jUOAtzuMJ71p7FL2bgsH+5aRC2FZnZbcD5j+3J7OoRGfKr9WUmaXB4Nb/Rq6pcYmXqi
 sz0owq9ac7toSmo/QViMubfgVkIlHpqYKyWqrBR5eHQpO06ZIVLqV0yoEfbRpv/9RlRgXgJUD5x
 3vP7PdPV6Ab5w8lc6k0A=
X-Google-Smtp-Source: AGHT+IEcp88EWyq6smiXF2nbjZWjJwR4A+5AKGNnyT7ZmkGKimIJgabejM7fbCKRmdY8mB3aWrncGw==
X-Received: by 2002:a05:600c:46d3:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-43c602223f0mr53786585e9.30.1741387210570; 
 Fri, 07 Mar 2025 14:40:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce9f2d081sm303985e9.21.2025.03.07.14.40.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:40:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
Date: Fri,  7 Mar 2025 23:39:46 +0100
Message-ID: <20250307223949.54040-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307223949.54040-1-philmd@linaro.org>
References: <20250307223949.54040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rather than checking ACPI availability at compile time by
checking the CONFIG_ACPI definition from CONFIG_DEVICES,
check at runtime via acpi_builtin().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/virtio-mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7b140add765..5f57eccbb66 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -28,7 +28,7 @@
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include CONFIG_DEVICES
+#include "hw/acpi/acpi.h"
 #include "trace.h"
 
 static const VMStateDescription vmstate_virtio_mem_device_early;
@@ -883,10 +883,8 @@ static uint64_t virtio_mem_get_features(VirtIODevice *vdev, uint64_t features,
     MachineState *ms = MACHINE(qdev_get_machine());
     VirtIOMEM *vmem = VIRTIO_MEM(vdev);
 
-    if (ms->numa_state) {
-#if defined(CONFIG_ACPI)
+    if (ms->numa_state && acpi_builtin()) {
         virtio_add_feature(&features, VIRTIO_MEM_F_ACPI_PXM);
-#endif
     }
     assert(vmem->unplugged_inaccessible != ON_OFF_AUTO_AUTO);
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_ON) {
-- 
2.47.1


