Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC33C9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mzv-0003eJ-QD; Wed, 23 Sep 2026 09:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mvt-0004K6-Uw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:48 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mvr-0007kp-BI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:45 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664dbdd2so296496eec.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169752; x=1790774552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqXX4SX3rjdHTToJvg98g4i7PWcyKUf7129uvkL7/uk=;
 b=A3ubRTPFXn+gaF+WSe23G+iYOx5xI/zlN5xfU4teR70rvQOHq/duPa3UbtUTW0IoHY
 Cy/1p0ON+FfPJFB/qgcq7JMvBH+kbIDivYLDMvM+5XYqttpmsLCbOE01aumu3DHlenB2
 ICwOlcNFBowwrymRCKZ0E5Nn8f431qOR+0dhnGwaLM9tWuANjDFC5rdTl8UM2G22Oyrv
 VurbRj11+9Q/VTJS1w3KYe3ayywUNpVmB7nepsj5xy3ll4is4RecC7J/NXMLKILOIdm8
 HLNmBNmuJBpDA5igCK2Gyhce8Xtsx70iiWP2CNoo3qmODGg0tnS4qiHuUclg17aHYyqM
 p77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169752; x=1790774552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WqXX4SX3rjdHTToJvg98g4i7PWcyKUf7129uvkL7/uk=;
 b=B6lr/PnRbGuL5Hzo0bbQjGbx5SN+XcT2Oi+UwAVBgXwwAWdl+NXydTCBYNh9HMEodF
 u54SOBOffkcXc3ycS3Ow6iyQ1FUELQ3JqxKTxMr+E/zda/qrZVr3NcK6SRUaIdlZIOpR
 YlI+i6gJ6O9kgcfPjF1uV5OO86/5N5oQ/C6+RjXRzE6UjKR7GyefZTWELq3q2a7iJlCI
 zlpusV3c8+Vy3MN/VkLG+C9xShKD6srEZYKiE/SMNJYfybF4k9xB+Hht5mSfPDwIRq6O
 i9JNyo5jUn0yLUbVu9QoNCUoDM1btS4f4RdNb2CykbrCeVUaKZt2nd6Ij+BUvD67s+WX
 inBg==
X-Gm-Message-State: AFuF++kYmZ24crJtP0ugzOGnVdJIoiOFhS8Z/ltNp4qk2ZDtt6BkhpSX
 5/6yu9wT6SXEU3xWNtmO2ogGaWg1CUfFDxscdTt37YdRx/fdiSKHtjys0rRUknBJ9ak=
X-Gm-Gg: AYBFou2bE2PbAStFKwIzkIkKy4ttMrVzY9t1qfiV0rh6sJbnZOfwVPWz55l1ZdPDe8m
 xSUXuxqEFJBlh/3FqEBsWjn9W2zgQALc5+LJIFdfvVxbJSHcC/DmsbTGLvePSw7GHNx6mca66e2
 7JmEnJRWsmQDRm4aqkYtP/CpZmm3FmGufqJRUUiRIu4HuxM4pcXJNQ550Gq1Dy5F7dg40agHEvj
 i96YqICHjIpUrYi1qcODlUXL+AK1wW9yII7PSrXPhs65mnD+TBEgYT+LVFiDcutXCKKRt20eKpM
 Upw+OmNCR3d6OkJ7zbeBDzRVaLjGiYYjqNi1i+ikhThexVdGyMCVHWwQzOF20mMNQALzlYvhrmO
 D1B7ucXAg5+OZ38l/q8Y09j+5E/y8lIjrlJtFIGMG8cFIHKZP8nnn+al5EWyiHkMT5UBM4D35b8
 IXK/NnsX+XKPmxG3+dkKsbiQGh1RUywDO6Yx1kooyBecj421nIZHHuGjFcoYAT4Rg9hTjbp6A7u
 Uh0NypGQtisiPZa
X-Received: by 2002:a05:693c:8814:20b0:33e:5e42:e0f9 with SMTP id
 5a478bee46e88-33e7a4d6cd5mr2603893eec.6.1790169751387; 
 Wed, 23 Sep 2026 06:22:31 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:22:30 -0700 (PDT)
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
Subject: [PATCH v3 034/114] target/riscv: Include migration/vmstate.h instead
 of migration/cpu.h in machine.c
Date: Wed, 23 Sep 2026 21:15:08 +0800
Message-ID: <20260923131635.1894-35-luoyonggang@gmail.com>
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

already uses fixed-width VMSTATE_* macros and does not need TARGET_LONG_BITS UINTTL helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffcef..00805745fbf 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
-#include "migration/cpu.h"
+#include "migration/vmstate.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
 #ifdef CONFIG_KVM
-- 
2.52.0.windows.1


