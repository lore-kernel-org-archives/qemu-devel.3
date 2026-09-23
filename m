Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E90C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mzv-0003Xr-39; Wed, 23 Sep 2026 09:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MvS-0003vi-Lp
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:20 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MvQ-0007hx-4P
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:18 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dce6e237so679037c88.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169734; x=1790774534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dE9e1D/hNDaJ+34nzjVxm6PaKrug7kV63zAG9/GlOBQ=;
 b=QA50XHRfjtH6BNR7EywH2iwm+CaNWbqe50tuw+gRh/1642Wsgl75Cp2ru0eHipWkJT
 SzZgA1JL8GKZDdZ4mJKyPyo8MScL431umv+mj9PNlfUT+kI+yANsdn2VnTjLjYjPVwDR
 QClmvFf8SyyYIJ7C28z604Ph7AcPFQv73wC2ZgOMfx48AIsEvszNbE4OZL/GkcWZZfNU
 lJ7UbisaPxJ7bH8QTDEe9314koiMf767J79/LdcF6xvDndlXDlg6YUPzzucLL9ajN15E
 kZAiImhtdfN8j7IcIpdINlXhDwm5i09J1w5PeFyel7YD1JO50u16YRwwP8P5ZsaKKX06
 jVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169734; x=1790774534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dE9e1D/hNDaJ+34nzjVxm6PaKrug7kV63zAG9/GlOBQ=;
 b=C3zcbEIOjUPjoP3695tRjh05zBUnwACXUDnPWkmR5mT7E+jW6jdKGLTBX7kCKtZM8c
 w+V0E5pCo3bzb2lFYfSsgxXuxZ4wN7E90QUhQDhJMDaFgazo6vw52otG5CnLWGbMH1XI
 06s6o7p80985a/nOzMCCR2dJbbCMWILL1pRaHVIOb5fCajTMJlUd9fDigAt/DZTipbWp
 /LESbLCPzh8fE7qlIU2ZrqxF5larl4txRT66KXSmWfERqhZtmMOeh3LbI+Lbf9yqBBKv
 7nBciaJMlBIfdrxnPWZLF1KPXDk08fKGBQl5FUkU2ru8KU9tW448lzlECeCqQqPPOI9b
 uqvg==
X-Gm-Message-State: AFuF++n+X5l9spCDCYRwQ9wZmEaL4pjdd/fsslBCUDT+MBflnItw96vo
 G6uyN2V0FtnkinxB/sikeckMxyj6FgEb3Bc1Ewg+U3Ka9HWYbO4DL7r4s7qPjaWhVMU=
X-Gm-Gg: AYBFou2Y10na5emDWz8hUkxqVO4RVjNL2FcmvLG+tgE5Vd4YVbT7lxkwnwoqHM4ZuBx
 9sX5biGiUk/xJVup9Fep1aMd2DgWrqp0G8h5ieo6+0zlH1hCSEpopax7RKq2Z2zhelSC5bJalPK
 uKMcWCllOvNQSdCsSwO9AbMvVTIH6weD34tb/lBng3EeYLK81aL56oRSaXjAcxJ8nySFiFn8pyV
 2fwJO3mfeKoH4I1ooKqiv15K/7HSkSFRkyu3VdEiekVUOpol7OUpC4UuOJ7MBfII6wa6H7KuoWB
 k5k/n61LIkK0JZyQj6fowqdGzxxSmQn082kcvZY6slEigWARRICl9kSgHXXSPhkYjyZ0nL41yXT
 ZNW8EbfTe2F//HsE7c1CQ3yhJQkUt+IFPXDQJBc5h4z7exlz4MgaJtH4M5LfTkXDVEB9tkMHmpt
 1MMe7IYpmDlo6ZKFxeY9+y3+fySEVcCOj8CpDvBEQsn9jJ+PJqcbMuOoHTPTNegmfuucDb9YIjG
 jpjbyfto5EaBzLTr5PBUGleovimyiw=
X-Received: by 2002:a05:7022:6b87:b0:143:57c1:6242 with SMTP id
 a92af1059eb24-144f917e7a9mr3802797c88.26.1790169734421; 
 Wed, 23 Sep 2026 06:22:14 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:22:13 -0700 (PDT)
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
Subject: [PATCH v3 032/114] gdbstub: drop per-target cpu-param.h from helpers.h
Date: Wed, 23 Sep 2026 21:15:06 +0800
Message-ID: <20260923131635.1894-33-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
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

- Stop including cpu-param.h from gdbstub/helpers.h so once-compiled
  gdbstub can use the helpers without TARGET_* macros.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/gdbstub/helpers.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index b2f41d6d280..7250e457c2c 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -15,9 +15,6 @@
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu-param.h"
-#endif
 
 /*
  * The GDB remote protocol transfers values in target byte order. As
-- 
2.52.0.windows.1


