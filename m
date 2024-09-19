Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A40CE8D49
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr94y-0002RW-23; Thu, 19 Sep 2024 00:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94s-00023q-5l
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94l-0007Pd-2U
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:37 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7db637d1e4eso259265a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721250; x=1727326050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5Ewnrr/qjz52ggXP5z2OAFJ85TodMlAQJmzdk5fJ2U=;
 b=G7fby94guwakQ/YJZiU1hAHXDdeUahYgfU+6B+871e1M/As5gVA2LXg8I2OrXKTffv
 m450Ne/TC9NMmBn/ddx17G/B3KwRiyF3c+oxSKxdJzxUbuYV0OGFTZcfHeCoaMkGRjjo
 7odTlRY1SS73T/hgmMDg0ahrNYwIwd5D4wW862vqP80qWhBpyUnkjDKkOKRkULlGtGOd
 7+PxZitXqbZUKpyKIaOe9lW5r77cugESNDYPOfikGf0fFLOFTd+7deHsJ3aJ/PCDBVfw
 AANpBBTRF41D5uEftiE4buy0LS9eJjHor8fcDVAR35fSISKCJrUaG8Q0DueZR+PgfNVN
 PXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721250; x=1727326050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5Ewnrr/qjz52ggXP5z2OAFJ85TodMlAQJmzdk5fJ2U=;
 b=Y6GvNk5Ot+9iumo4iI7Jr6iKruSAMWjMHjLU1dxhBOxMCSJQ7LwpfzKMag5TLDJEif
 TIMc8S91/Ky0iFuXLgIudQs5pVkuy3l1IxSe9PsNpERbG1GG3JyjPq6SUbxyj9PpDhaP
 AU3YRm89m5FNhw3tmoEa6Ag2N5soWZvvydtJlVLdXT9PL6wQ+99VEw1jedAL4H8Ha7w5
 dLr3O9tWAZPCuszW4anHvEe0eelf4YSY5zJe5kDJmW2JQnJMEBB4EtWLDp8JNqORim3c
 XnyyvpAYHJUtC650AcanldXsdCByKD9+ssV/FMNJ8tO/F5Uq78o7YZgs0NUMVqWA6+xw
 Z6Gw==
X-Gm-Message-State: AOJu0YzsNpXRwmBA2O/4WYycm+Ru3FggvMc2LQeLUkD/QKWh7J1esGGl
 hiG10Y7x/Nu4BpZKhW9eSPiVyPKTdwzFf4jJ8l3r7nXi31xASK361PmwhnLVg+Y3KACHvL2Ed1O
 K4Jt83A==
X-Google-Smtp-Source: AGHT+IHOtMj/Kr5ExQ1Dywx7ERrNLhz2hVxVxQFKG+INI6zzOgF8wrQsA7qvcA3V9hiv+CFRCBs7cw==
X-Received: by 2002:a05:6a20:b58b:b0:1cf:3838:1ed9 with SMTP id
 adf61e73a8af0-1cf76239c73mr33120242637.50.1726721249781; 
 Wed, 18 Sep 2024 21:47:29 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:29 -0700 (PDT)
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
Subject: [PATCH v3 22/34] target/riscv: remove break after
 g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:29 -0700
Message-Id: <20240919044641.386068-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/monitor.c                  | 1 -
 target/riscv/insn_trans/trans_rvv.c.inc | 2 --
 2 files changed, 3 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index f5b1ffe6c3e..100005ea4e9 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -184,7 +184,6 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     /* calculate virtual address bits */
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3a3896ba06c..f8928c44a8b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3172,7 +3172,6 @@ static void load_element(TCGv_i64 dest, TCGv_ptr base,
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 }
 
@@ -3257,7 +3256,6 @@ static void store_element(TCGv_i64 val, TCGv_ptr base,
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 }
 
-- 
2.39.5


