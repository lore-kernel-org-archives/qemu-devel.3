Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD9FEE645A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeRk-0006n0-8p; Thu, 12 Sep 2024 03:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQp-0002Un-D0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:59 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQm-0000Hh-I0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:58 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82aab679b7bso25476439f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126795; x=1726731595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl+JcJWeB9n4U9owGQI4EbvNVAnzvdcJPjSOFH/LTqM=;
 b=kg2ug93Xwl3nC1MP+jbTve2uDeGVxYbskRbyyi1EGnpX50ewagvLoVlIKKZfWWVfIL
 XSGBQQhNjqvfoXE7Ktt0+UjfcamAKXnBpZhVgGfyOlsbksEPW7RHkaf3OCvFMq6P/t5N
 6FfzwfRAVvykhUE5xIkFkdJI0dhShjHmLcYup/OyJWW9vnAMrrc7f/4Wuuz5oD2DktRj
 oTzR/w7/G2gVDeQaeV699htnuwEEDhoXEYJ7HK33iDhMtXVpP+PbQsjS4wUASoskx0+S
 1M6XzgS2btdJGRgw3ykcrs9bolT3lVNJHPBSBval1OhtAw4eRx7yDDz8dcYHGTymA+cY
 tLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126795; x=1726731595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gl+JcJWeB9n4U9owGQI4EbvNVAnzvdcJPjSOFH/LTqM=;
 b=h0xx84eYhDFFieqKPgQD/UO31yRoIp+ZyB0iu5MNBFKlB76kl3R02/KBHMbw9SAijt
 u0xIyFeOSTx1qYWO2nXc4DRzSjdpjbHOvXFLQQrpTjM4nku1dU0mAunHdViD4dGVoVMB
 WglCWmyxSH2AIoMta+/nwIpMf9R1oUncvGBkXciGrwf5RMI43BdXGfm8WhkfmeNxU6IZ
 0m9ZGFdI89RbhvlWeO1ghg7JF4FvXsUsY6M3D3c9UeBWJeERQ7o/Nq9s135nxO8CkzM+
 3on+iul1RzdGqQ64c0C40pa7OZrxAdUf8Gao642SFgU4rtHF65VdEy98HmJO/+TDTmeR
 G6Rg==
X-Gm-Message-State: AOJu0YyknigzDlJvyzpEPB98+tAoiDkZT51l4FpN4DdVklVbfp4uIgDB
 9tkcpMVwOp0kY5nmFFcBRbUOt6IFPGBrBaat7IR9kvoDoDxpeaGXuU8yUjmtPQICoUG+4x6v+kE
 TEpjZM8dL
X-Google-Smtp-Source: AGHT+IFc2U5w+P2/p0zo+AVbvStN+97kW37ZvG1bComHgG1CrEqJE1viLz5YY6RVesmsw9//+xNbnQ==
X-Received: by 2002:a05:6e02:1806:b0:3a0:1828:31d9 with SMTP id
 e9e14a558f8ab-3a0849736d4mr17121295ab.24.1726126795091; 
 Thu, 12 Sep 2024 00:39:55 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:39:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Klaus Jensen <its@irrelevant.dk>,
 WANG Xuerui <git@xen0n.name>, Halil Pasic <pasic@linux.ibm.com>,
 Rob Herring <robh@kernel.org>, Michael Rolnik <mrolnik@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Corey Minyard <minyard@acm.org>,
 Keith Busch <kbusch@kernel.org>, Thomas Huth <thuth@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-riscv@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller <deller@gmx.de>,
 Peter Xu <peterx@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Eric Farman <farman@linux.ibm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>, Fam Zheng <fam@euphon.net>,
 Weiwei Li <liwei1518@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/48] target/ppc: replace assert(0) with
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:44 -0700
Message-Id: <20240912073921.453203-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-io1-xd33.google.com
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
 target/ppc/dfp_helper.c | 8 ++++----
 target/ppc/mmu_helper.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 5967ea07a92..ecc3f793267 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -249,7 +249,7 @@ static void dfp_set_FPRF_from_FRT_with_context(struct PPC_DFP *dfp,
         fprf = 0x05;
         break;
     default:
-        assert(0); /* should never get here */
+        g_assert_not_reached();
     }
     dfp->env->fpscr &= ~FP_FPRF;
     dfp->env->fpscr |= (fprf << FPSCR_FPRF);
@@ -1243,7 +1243,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
         } else if (decNumberIsQNaN(&dfp.b)) {                  \
             vt.VsrD(1) = -2;                                   \
         } else {                                               \
-            assert(0);                                         \
+            g_assert_not_reached();                            \
         }                                                      \
         set_dfp64(t, &vt);                                     \
     } else {                                                   \
@@ -1252,7 +1252,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
         } else if ((size) == 128) {                            \
             vt.VsrD(1) = dfp.b.exponent + 6176;                \
         } else {                                               \
-            assert(0);                                         \
+            g_assert_not_reached();                            \
         }                                                      \
         set_dfp64(t, &vt);                                     \
     }                                                          \
@@ -1300,7 +1300,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,          \
         raw_inf = 0x1e000;                                                \
         bias = 6176;                                                      \
     } else {                                                              \
-        assert(0);                                                        \
+        g_assert_not_reached();                                           \
     }                                                                     \
                                                                           \
     if (unlikely((exp < 0) || (exp > max_exp))) {                         \
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b0a0676beba..b167b37e0ab 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -316,7 +316,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
         break;
     default:
         /* Should never reach here with other MMU models */
-        assert(0);
+        g_assert_not_reached();
     }
 #else
     ppc_tlb_invalidate_all(env);
-- 
2.39.2


