Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F9606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RD+I2klC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA4l-00059R-UQ; Wed, 28 Oct 2026 16:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4b-00052c-TQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:38 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4Z-0002Fe-8I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:37 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-369f33df08eso2610865eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218594; x=1793823394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NuBToxGTKV+VzeXb2lZn4OChHw2LGBi0yxV28yWFalg=;
 b=RD+I2klCz3R1BipNv7t+heexbnZftLEpRW9eCIJlb7TZ3c1CCOLM9IqhCuivpjj3Dl
 yC7pjvKwGNmNYH8NBPD5nq2Y5MhMmCV0H+QR7bwUgwrWjiCFH4qG3W8NxddxjB6Xf2B+
 xvlldFnXNkL4qmixOakR6Njzk9HrqCyNpO5INU/Bacz0/5mCw5K+F+V3+nTbhtErCps2
 AScPNaXwhbi4546aKcxeBqD91jGRwjWET0pD7/Xc7pnWCSwNVisxk5vKi/UO/wokH7yI
 /gIbfvz1zBLNljSe7i/MIWEfRQv4jjXX3gxbslOjP+QadmMtl3OGHRcS0TaX4RWTzKEk
 Delw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218594; x=1793823394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NuBToxGTKV+VzeXb2lZn4OChHw2LGBi0yxV28yWFalg=;
 b=fhm2pZX70gAOQlmvuqEuD7L/UXYyepMHxoiEC3lgh2Mbp0pULG1FV7BIPj9f5BCz7E
 u18n5INSTdz0/zRLyXTlPv68ME2qeRwHbN8bMKRCLCqT00RO/HqA6ppIugwZ+/b/7LCU
 G6wB/wHEpEE94ofa0ERin3i4GpfuxvBx4iFTQhz80FwpEHA0fKYkk+h0DzSoriVqRpFC
 k+TaG8ZW0OYgtTXtp1fZeosdjX16ICJdiMN5GK6WGgg/6ExLm8lSbwKjA0ZVey7O6grN
 qY4V2vmNlURyHjvqj8kHnkyGjJPraTUJNoU59ZAJK6lckFLjwck/AjwXf5naSnnW87Rv
 TAOQ==
X-Gm-Message-State: AFq9FYJljPqwyaX/rVOXfOXoGXw3UXtFqmbUaLUbGMTvfuEkfLhQ6Ytp
 cR5wRqrMUPGmFJAKsIEaz0u6k5ImX+f2VwYgMpSnRUVeFuWaNh1N2gnvULQVKSsm
X-Gm-Gg: AYBFou0NUECHl2wyBPraMPYpIXPuZP42s0xIu77muS/adrZK47NzUtKuUThdC6V6xmR
 6JVbroO3mj+rTPbUnugBt0OF12EZnszyRfnQ0pDJtu/TqjRzI2bZCDvbS5W/gNL39tNuaFL4/jV
 SdlxrdVQRs3A/Gd13yHwbNgoZfHP5TS/LXw4hUxGrDooh5AINloW3eWPN8S/Zrks45oNiwenQfU
 gnZeqXH7l6ndXPGZGdGehqxMp7P20qaU74zbBFeUCBH0jeIhkLl8g1/cHFmdpvKeONg5A8wxqMj
 /ZQlQqAa3fG+128d8N7M4ZFWH7G7syWfxNzP/ZIcHKvSRUj30Vmy88QONDnnJP7Q5ZKxjd4Os8l
 9G469sUAwNXMreRGXRxvmobi1K+VE+syQ5SBfuIAkgOswzWW94ry236JBqf80VdHQgSPnJTz37k
 pyrVZISa+NWYJOdrVBSc7YwE1MfdZYMn8iUD51ADo5GPef1yWwf1vGMGOY3hjizm3mDmtQK8elD
 bPfj72/LOnBgBuyhUvZG7yIFr1Cor1M2Uo2W8IUknGAYVSIv8BoRAq/1bBQ9k5498BJiOuA45Gl
 H3MHPgQ4I3aALSOS54fXt2FBGD3rJWlccpeKxaKeRup9gzih
X-Received: by 2002:a05:7301:618b:20b0:360:e2e6:f849 with SMTP id
 5a478bee46e88-36a20138550mr5188420eec.28.1793218593540; 
 Wed, 28 Oct 2026 13:16:33 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/12] hw/xtensa/virt: select virt machine types with
 is_available
Date: Thu, 29 Oct 2026 04:15:48 +0800
Message-ID: <20261028201557.2688-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Xtensa virt machine uses the QOM name virt-machine, which other
targets register as well. Register it only when the selected target
is Xtensa, via target_xtensa().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/xtensa/virt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..2b30cb863d4 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
+#include "qemu/target-info.h"
 #include "hw/core/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "net/net.h"
@@ -124,4 +125,22 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->default_nic = "virtio-net-pci";
 }
 
-DEFINE_MACHINE("virt", xtensa_virt_machine_init)
+static void xtensa_virt_machine_class_init(ObjectClass *oc, const void *data)
+{
+    xtensa_virt_machine_init(MACHINE_CLASS(oc));
+}
+
+static const TypeInfo xtensa_virt_machine_info = {
+    .name = MACHINE_TYPE_NAME("virt"),
+    .parent = TYPE_MACHINE,
+    .class_init = xtensa_virt_machine_class_init,
+    .instance_size = sizeof(MachineState),
+    .is_available = target_xtensa,
+};
+
+static void xtensa_virt_machine_register_types(void)
+{
+    type_register_static(&xtensa_virt_machine_info);
+}
+
+type_init(xtensa_virt_machine_register_types)
-- 
2.55.0.windows.3


