Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A78CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr95L-0004dZ-1n; Thu, 19 Sep 2024 00:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr958-0003Nb-Ow
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:54 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr951-0007Y6-VQ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:54 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso302952a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721266; x=1727326066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozWlgV20eXCZ0c9b/13N/LAwE/BLpMMoDcMJfurfVNw=;
 b=pTyfUHFOarO4HD5UZoMTnHS+DyzveHU8Bpv/maYRKbx3sjczZoDu80G4grXw+uKgSB
 ZBaEKsMrt93cu3uxDk3dKdxRLwmi4bE/xnaTH4RjN52e3ruHat+TBeTRgSyupFFxgLEk
 4WkwZMBg30B6KXojHFOqc9yMyfEKAsjMh5JE39J6HPKqbftjg3XkPbZc/oLVnw6OjVZU
 aGCXP0ueF8SgEy59f8JlyCwzqECIfluZIsZZ57deMKdS1l0osUQzQ5HaDTv+Y0PXI58U
 cEuhjk+3gxD/9l/2kbLCIb/TXcnvBvYgXPeEDo0t4Vc00uIkFeOM13clf/+9fuQYdN4N
 3meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721266; x=1727326066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozWlgV20eXCZ0c9b/13N/LAwE/BLpMMoDcMJfurfVNw=;
 b=DxTYlP/6+YtKNTvLzf74+ebIqoLjbOz2FlYcv0hgvjKnHRREAiMCrXIYd4817ntajw
 RuagvIbKPeDI8LzLF72CcvZLhWVZsxPkOegN/dWR0oLN+JTn06+jkNxfeHE5w73gWfVt
 dVE6AtQMxFqQI+MMwcRyuWc/RVUjZKnJPpywSxwwJVDnAR+5ArAXC89vlv6mmuUPltbO
 tDP9UbvBgdGKiy4MCMEpSq54MOs4bLw9ymAIwDEiq/ABiSiV1M8NykK3oSXrdnYz7K20
 plTOUws+4GKYDrc/LMJgmEhJe/CqwyO2ofDnTYkx0b7SUmXE3n1USTXyH8NDZOfPLLJ/
 U0yQ==
X-Gm-Message-State: AOJu0YyUd/KK0zZg9XTwqr06Uv2luR0UY1ZQksJQpvnHGfff37hu8c84
 dyUHzKfxVqZMuQYMTk0kjTUBHdO7BP6idPkknxHccKl6ZhK6+Gee/p0rCygKbA8aODAOs1S14B6
 xSMbcoA==
X-Google-Smtp-Source: AGHT+IHsHP2GkF8PiOM9Z52fH8cAj4VN2oMaI0BFSJQoP5lyLdMB2INYK+7wocFS7jMYdV3UCDnxug==
X-Received: by 2002:a05:6a21:38d:b0:1d2:e945:77c4 with SMTP id
 adf61e73a8af0-1d2e94578b5mr9976706637.2.1726721266025; 
 Wed, 18 Sep 2024 21:47:46 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Hyman Huang <yong.huang@smartx.com>, Halil Pasic <pasic@linux.ibm.com>,
 kvm@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
 Peter Xu <peterx@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Corey Minyard <minyard@acm.org>, Laurent Vivier <laurent@vivier.eu>,
 WANG Xuerui <git@xen0n.name>, Thomas Huth <thuth@redhat.com>,
 Rob Herring <robh@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Weiwei Li <liwei1518@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Helge Deller <deller@gmx.de>,
 Yanan Wang <wangyanan55@huawei.com>, Michael Rolnik <mrolnik@gmail.com>,
 Jesper Devantier <foss@defmacro.it>, Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 30/34] migration: remove return after g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:37 -0700
Message-Id: <20240919044641.386068-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/dirtyrate.c    | 1 -
 migration/postcopy-ram.c | 7 -------
 migration/ram.c          | 2 --
 3 files changed, 10 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index c03b13b624f..5478d58de36 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -229,7 +229,6 @@ static int time_unit_to_power(TimeUnit time_unit)
         return -3;
     default:
         g_assert_not_reached();
-        return 0;
     }
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f431bbc0d4f..0fe9d83d44a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1412,40 +1412,34 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
 int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                  uint64_t client_addr, uint64_t rb_offset)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
                         RAMBlock *rb)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
                         RAMBlock *rb)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 int postcopy_wake_shared(struct PostCopyFD *pcfd,
@@ -1453,7 +1447,6 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                          RAMBlock *rb)
 {
     g_assert_not_reached();
-    return -1;
 }
 #endif
 
diff --git a/migration/ram.c b/migration/ram.c
index 0aa5d347439..81eda2736a9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1766,13 +1766,11 @@ bool ram_write_tracking_available(void)
 bool ram_write_tracking_compatible(void)
 {
     g_assert_not_reached();
-    return false;
 }
 
 int ram_write_tracking_start(void)
 {
     g_assert_not_reached();
-    return -1;
 }
 
 void ram_write_tracking_stop(void)
-- 
2.39.5


