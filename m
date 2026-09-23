Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AFBC9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mzw-0003hN-6l; Wed, 23 Sep 2026 09:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mvl-0004HW-Dw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:45 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mvj-0007jT-GQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:37 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-32ba4885063so579992eec.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169743; x=1790774543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gZLlHjgFKGd97ZAl0jDOPJ4J/L8M7/uJxBZfNAi1MwY=;
 b=pYDVamWjKU9mFRVaoshoVZzxslMzVtSC/VY7u9aDjmjTALt8ZfhEQMoQOwlubIT+on
 FhtF6UX7VuaHu3p0LkE37XipfXjSvDvNJ8PQqp3FPEwZKpai5h2TAn4Vv1zEhx6Su5g1
 46S1Inssnd/upUPE8U2Ij43YsiW1kxTLqIiap3kLlwGm++qO/7gGWHWU5R1yag/xuaqc
 U336iZ+4Zdhvq9lFLKWGCmiLrLHj7evAAzlrIGpEqsl0fUHQqLp6OihkXsQhXPxIZjqp
 ZDzqBtJyyotmgW+nEyRWgGSnxYE28qhxPAkd5+50AVgHwR96Vsf6rWvPlUSD79IwhHtq
 FyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169743; x=1790774543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gZLlHjgFKGd97ZAl0jDOPJ4J/L8M7/uJxBZfNAi1MwY=;
 b=Ioll+HBQ6hysxBouEUY4Cn5T5+wuo3Pq+YI4t+v7FkSmAlHgooNjFuzEnDUnGgb6ZV
 K+5+cs4x96RkNtfnxSKegAtGaw9Qhw/dW/CLuLcMYRB68OTJByE0VMEXRa3BJFyqCDoq
 T0i3drxq8SPJbOB9soOn2ADf16XA1Wds5gSpTjXTqMLM3/pL+Y8nUanJz/1KB25V/uUU
 mFRTzgfbp5gyTp+nTL93o3IWlMKWba7pgRfJdIeSE+AAK3OQATSszpF2jt5Ctm9uAABN
 ilanBA7riVtBxRDRmbyNrwbfdnlLcBr9DrCVqcneQupMxXX3/UIvFDuZ06wNFyOv30W2
 O0zQ==
X-Gm-Message-State: AFuF++k3l/VLDxENldAk1ieYqeshck6O5uwXptxvcef63HoB6bUM1Z+v
 H4j9Fvb+YqcSfeRLIzZR5WVt96NXk8HD1p+TRuyD/AYwO/1UijgqVayNyY8Xxu+SdXs=
X-Gm-Gg: AYBFou0WQuwro+6/5s01tViX4Waq5NZCD7g+f0Ip7bl+lXOjMWtc/S3Rmi5j/QTPypE
 jDrMYTEc0FXF9jX59LlXrzaHxPXSRfAf4sFHZ/Ki1/BkpDHhTxfy0vtlfuTY937HuSFRgqeR6j1
 KyrczJ8zk6CoxnPZBgdSCEYTu1VYWorBHNUprvVKrwZLS6bqiBKP1XmoY5noW/9SForwiq4SZMb
 GkMUVpBZYn0j8ixnFGfttOTXFEtWuCQaPo2eSNKYDT95UFqM8914YI3hgVWn00N9uZbMpo2+RHn
 I+3zqATDv7Mo1liOGcqbq509vxsmQAd7hP7MLnAutAKCMAGJBp9K9ufR4vJd4fcstRR1WjyN+T3
 FaZgt6XgWvzqn+h/EPHLTsu8/yFS3EuM8PZnv6rYPvwsa9h7BSoTSKc71AtjWbUAyL66m9NboN1
 gFqDpmO1qFTA06kUSoAk7LWEbkzVgF+dWWanCSBAS6jj442esv8JIdefdmJQfLNfpl7/CzJO/+X
 aRkGunLRfkRqkQdGkrWBNZzbJ0hBgmwj3L1sU8+Kg==
X-Received: by 2002:a05:7301:c016:b0:33b:d4c9:561f with SMTP id
 5a478bee46e88-33e8bb7c1ffmr2536095eec.5.1790169742689; 
 Wed, 23 Sep 2026 06:22:22 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:22:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 033/114] hw/riscv: expand boston-aia and
 microblaze-v-generic to TypeInfo
Date: Wed, 23 Sep 2026 21:15:07 +0800
Message-ID: <20260923131635.1894-34-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace DEFINE_MACHINE with TypeInfo on boston-aia and
amd-microblaze-v-generic. Set is_available to target_is_base_riscv.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/riscv/microblaze-v-generic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 3f07ab21328..9b60a955152 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qemu/target-info.h"
 #include "qapi/error.h"
@@ -177,8 +178,10 @@ static void mb_v_generic_init(MachineState *machine)
     create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
 }
 
-static void mb_v_generic_machine_init(MachineClass *mc)
+static void mb_v_generic_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "AMD Microblaze-V generic platform";
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
@@ -188,4 +191,16 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
+static const TypeInfo mb_v_generic_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("amd-microblaze-v-generic"),
+    .parent = TYPE_MACHINE,
+    .class_init = mb_v_generic_machine_class_init,
+    .is_available = target_is_base_riscv,
+};
+
+static void mb_v_generic_machine_class_init_register_types(void)
+{
+    type_register_static(&mb_v_generic_machine_class_init_typeinfo);
+}
+
+type_init(mb_v_generic_machine_class_init_register_types)
-- 
2.52.0.windows.1


