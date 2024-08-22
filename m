Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27592C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAZN-0005iP-0N; Thu, 22 Aug 2024 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZD-00057n-Kr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ7-0007Kr-JX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42808071810so8020365e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724343692; x=1724948492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AY1IW4T2DNcuGaXu8tbq///494SrbvPqRCnm6aioH7A=;
 b=Fl1OuYOWFDeQlOlcI9XVmcXAxU309m/nzgchKo+6ZRffcwtUQgsljiJ6V8Oymsigw0
 uKTvsbXz5si2DB52mBM8hFsfIIZRrhwagUS9/SCpQx9wEqxFzXhI1vYRsS2VF2QJ2EH9
 0IIEs5DY/RByp97UQOrWANDntiTGlo1cuuTe1pqDTXboqhtJOMCZonUBA6jYLMWBoB4k
 qzQKO0UbLhdY59XZiLWNFWEOWxbk8TWZEekLbwuBm41iWOB1Vpf/VdbuSH+qicQjQf6O
 KCkcD3UErJN5bUoDzkbninizZndayvFaTZ4WZSlvqbAlaf2pu97ZGvuzP09avNtVlThS
 wdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343692; x=1724948492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AY1IW4T2DNcuGaXu8tbq///494SrbvPqRCnm6aioH7A=;
 b=Ammk4tlhGhHwB/EV9XdUikByBdko7supaZ2jIwVcKI1EMlYaIpa8PM4saJfLEkQj/o
 3hnlfwP1lBDNhmvGbB5JWYoCcbo6KNEmoIw6edRTiiaJB+8TN0HLUy68liW8ShGsC39E
 2AFhyGqu7xti5lUbLUR2jcrikjozja0dC+6NjC6Yof6o8NpMMiBnf+8hiJOrNQIsl6ZV
 /8AnwXLBFmqHgJG25OhOpBP+y8qNm3EFQ3dPgQZTG9ExcxGEH78lgkZWuy5jk4QCi2AA
 4f8venx1WOrgf3oUp/8d7GY+QIekFukMrG2WYlpd1YY1Uupul58UtLv4n1mchKWWxEAm
 /f9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHLbyLb6v8i/umffuvAj70UC1afXRxYEF2ynz980Is+MQ3SI9CgWHZ1nF/ZEx3QVYpORab5F/xvREW@nongnu.org
X-Gm-Message-State: AOJu0YykQKyN7IvUJTnqraQy8ZTCVwDtWfhu5nfpLnyNMkt6qAsgyP/d
 IGuzMgRSAOzR17i5Ir1koPOxfqQCqV+OG8qdLnMBdHvRdbAyxLUWwJ1WfA4uAI8=
X-Google-Smtp-Source: AGHT+IH9HuJWtSiRclkG35EY6u0WggXWPFLhmvaqtf6d2Cv7MR0vmfP119z75PLeipkLoOgm+oZ2qw==
X-Received: by 2002:a05:600c:468f:b0:426:68f2:4d7b with SMTP id
 5b1f17b1804b1-42abd1121bbmr47556815e9.3.1724343692582; 
 Thu, 22 Aug 2024 09:21:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5162347sm28928485e9.23.2024.08.22.09.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:21:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH for-9.2 6/6] hm/nvram/xlnx-versal-efuse-ctrl: Call
 register_finalize_block
Date: Thu, 22 Aug 2024 17:21:27 +0100
Message-Id: <20240822162127.705879-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822162127.705879-1-peter.maydell@linaro.org>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The TYPE_XLNX_VERSAL_EFUSE_CTRL device creates a register block with
register_init_block32() in its instance_init method; we must
therefore destroy it in our instance_finalize method to avoid a leak
in the QOM introspection "init-inspect-finalize" lifecycle:

Direct leak of 304 byte(s) in 1 object(s) allocated from:
    #0 0x55f222b5b9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 420
43d49e1139e3f3071b1f22fac1e3e7249c9a6)
    #1 0x7fbb10669c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55f222f90c5d in register_init_block hw/core/register.c:248:34
    #3 0x55f222f916be in register_init_block32 hw/core/register.c:299:12
    #4 0x55f223bbdd15 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.c:718:9
    #5 0x55f225b23391 in object_init_with_type qom/object.c:420:9
    #6 0x55f225b0a66b in object_initialize_with_type qom/object.c:562:5
    #7 0x55f225b0bf0d in object_new_with_type qom/object.c:782:5
    #8 0x55f225b0bfe1 in object_new qom/object.c:797:12
    #9 0x55f226309e0d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/nvram/xlnx-versal-efuse.h | 1 +
 hw/nvram/xlnx-versal-efuse-ctrl.c    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
index 86e2261b9a3..afa4f4f9960 100644
--- a/include/hw/nvram/xlnx-versal-efuse.h
+++ b/include/hw/nvram/xlnx-versal-efuse.h
@@ -44,6 +44,7 @@ struct XlnxVersalEFuseCtrl {
     void *extra_pg0_lock_spec;      /* Opaque property */
     uint32_t extra_pg0_lock_n16;
 
+    RegisterInfoArray *reg_array;
     uint32_t regs[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
     RegisterInfo regs_info[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
 };
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index def6fe3302b..8252a5cabe0 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -712,9 +712,8 @@ static void efuse_ctrl_init(Object *obj)
 {
     XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    RegisterInfoArray *reg_array;
 
-    reg_array =
+    s->reg_array =
         register_init_block32(DEVICE(obj), efuse_ctrl_regs_info,
                               ARRAY_SIZE(efuse_ctrl_regs_info),
                               s->regs_info, s->regs,
@@ -722,7 +721,7 @@ static void efuse_ctrl_init(Object *obj)
                               XLNX_VERSAL_EFUSE_CTRL_ERR_DEBUG,
                               R_MAX * 4);
 
-    sysbus_init_mmio(sbd, &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq_efuse_imr);
 }
 
@@ -730,6 +729,7 @@ static void efuse_ctrl_finalize(Object *obj)
 {
     XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
 
+    register_finalize_block(s->reg_array);
     g_free(s->extra_pg0_lock_spec);
 }
 
-- 
2.34.1


