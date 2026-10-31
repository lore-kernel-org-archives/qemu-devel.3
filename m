Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF5606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1SuAF2q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC8P-0002Db-Hx; Sat, 31 Oct 2026 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8O-0002Ca-DG
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:48 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8L-0007ib-RA
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:48 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-1adbf62dd31so1630981c88.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464844; x=1794069644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NpRZPrdA7p4HsMufejy4KcfzX3kqDfNgpM3OElffcBU=;
 b=A1SuAF2qdx016vuak1a3/fYeOBU1JkqyypR74HtUEUWIlAn0asZmLFGmBNSQIHkVFQ
 7bUgAPCnA157Rqz3wgoSYUJeYN0t25oYiCatrDuYts1ujUeoT/3fmrVt3koDvcpDFtSd
 MZTJ3CJ1Z/S2GJ++WQkZPCdez+NyoOF52v8R74NTa7lVv/AAbqjX8fAJUFXmbx0AvjwB
 DKHd1Z/eklLmON7mCI4avI4l9Q/Xcm23O6K9AiL79ACmzPmhH3dXjoE4enrChnReI2SE
 HuhNAmx19G7PM+HqHp61i3KMEzhvvGh4lh48WJPQXJcRoF3fszPmFuTAeYQzwtHIf3o0
 d5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464844; x=1794069644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NpRZPrdA7p4HsMufejy4KcfzX3kqDfNgpM3OElffcBU=;
 b=tg+tuaKU+7bAZ0dZSEs+wPObPnF6ZcyIjV8sBSNFf7lxzHqSDQGxukgEU/KID+V09/
 EZz0V/ynTMP2S9wnPpgTI0i7fXzPrH+X2AvSJcNsJtVz3KXz3Rvfc9zBRhc9WdgwyLgO
 xJ2dfH6aQ3J8fBV2Tn4+HM8Cjxi0TxI+pjr4YD+BODErS6YSqZl+slBgyRV2AC2sfjAd
 iOLUY5wASkrIXzCw502QoEkFAW1siFM4YIbjeb8oB1c7UxiF1TttV2lGrYTHJkcQf8Hi
 eYNOG1/7LnLbjdXkbxw/0oc8Lc+w1NcJnEWbIQXdj8QNCAKydPOJ+yWymU2hVdhN22vE
 5PWA==
X-Gm-Message-State: AFq9FYIhzuGi4XQkaOQd53UK+2YGaQMB4+7d2Vc5e8FhnALmU6WTxjNS
 u8RYEWiGXj1zhsd8tuie0PZRVUEyUcXE0NiPqVOwDFWIUYO3sRSo345Z+jm7kKE3
X-Gm-Gg: AYBFou1Y9fsrGuPCPpGeFxbqpGGgiB1XmFwfUZ4NlgAClhk6KKoDA6P9u/vXxk/b2ae
 SFDvdpixuhVVK/byusvKQV3QgWntap+OqZTOBiRCh+0X4B+dOhO9ZTa3EFGpXKFnBx8WhwwgAha
 5HDY1e4ny1ko+y6PKDJpN7rB4sNWaAXI+NvkFUIP0HSarYN22Z5/+xUuAZTMDpFOc5UW24NINX/
 aFxaL+c8Enox5V3HWbF+FeEQpc80jjLL95Yne1zpwO+90A0WiDh5NmCA1uBSLUG74eB7KqtBbuU
 XmlYnE1ijVt/ameCfb2qc/R8ZjdHh0frkcfAWoiAeukeC653WMXU6f1CwzqBaKm6yxgfjhIy0Ys
 /21aPtsAvZaEr2IsfT3cHeO17quUfX3u6XsGqclNCpYXJ7zCo4NCtQ+796Zpf0Gp7zBN5YKHLSy
 BW0QXYX/VMuKujbLE+idvNWIONzTR0yagXCdMQ8ZVsIxp4u+Fc0CWCi3OU2qw857V6XSUIzlW80
 EGb7VduduCL21zTjkU+KM0HAzi+jjrhB5KsS2Me0Mc/ifTsfAovv3WEIo/ZOEAKeVtZItja2xgp
 VCxkEzrBeDR+Tu6l2wm0hbaEeFtVZkY1ghyD3hq5dxma1cis
X-Received: by 2002:a05:701b:4349:b0:1a9:d04f:1b55 with SMTP id
 a92af1059eb24-1ac5d0da4acmr7576428c88.26.1793464844120; 
 Sat, 31 Oct 2026 09:40:44 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:40:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 04/12] hw/xtensa: expand DEFINE_MACHINE in virt.c
Date: Sun,  1 Nov 2026 00:39:59 +0800
Message-ID: <20261031164009.2048-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1234.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expand DEFINE_MACHINE() in hw/xtensa/virt.c to xtensa_virt_machine_typeinfo
and xtensa_virt_machine_register_types() calling type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/xtensa/virt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..8c8fdad72f0 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -115,8 +115,10 @@ static void xtensa_virt_init(MachineState *machine)
     xtensa_sim_load_kernel(cpu, machine);
 }
 
-static void xtensa_virt_machine_init(MachineClass *mc)
+static void xtensa_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
@@ -124,4 +126,16 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->default_nic = "virtio-net-pci";
 }
 
-DEFINE_MACHINE("virt", xtensa_virt_machine_init)
+static const TypeInfo xtensa_virt_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("virt"),
+    .parent     = TYPE_MACHINE,
+    .class_init = xtensa_virt_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void xtensa_virt_machine_register_types(void)
+{
+    type_register_static(&xtensa_virt_machine_typeinfo);
+}
+
+type_init(xtensa_virt_machine_register_types)
-- 
2.55.0.windows.3


