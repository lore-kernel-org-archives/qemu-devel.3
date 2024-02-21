Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A37EC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqTg-00010M-13; Wed, 21 Feb 2024 12:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36jPWZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com>)
 id 1rcqTR-0000rE-Rg
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:33:38 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36jPWZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com>)
 id 1rcqTM-0002TN-SL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:33:37 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc64b659a9cso12258012276.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708536810; x=1709141610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=nKuGCA+rZrH/qIGJuQohJmMqyiRVPoofVS99+gBVcJQ=;
 b=sPvojojgW7X3XYcZTD8yWIUet2A6vd0ce6d/QLmmtO3Psovi11zBbgaz9zuQnW0Gb/
 s7tJdjE3a7ryXVORAGxByP228spyBDZEH0woMjB4kgzQhpNoRMmuSgK7IKaYaSxSokr/
 nfeQinkNmtimVSFFa+2NE9/aaPAQ2dploOK0o/9I+g0/7YGPQ96EHojahNhj5c1fkquV
 ARpx4wleJpr1s1Ni/efkWaSLPLh6Vq9YrXjYUE3eUmw6Xt53UUF1DBYVZDPbGaqAUd6Z
 MZpAY0cpWgtj4LNnPmk0OkgNsvT+CnKfHvDpGFeH80VLcXQFdQXgHvrbzV+PijXhN5EM
 qhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536810; x=1709141610;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nKuGCA+rZrH/qIGJuQohJmMqyiRVPoofVS99+gBVcJQ=;
 b=AoNXmV/Zbs41URErvEmlqRJd+Zd4LWsWAmYcfD4OnndiNLJFoTi+u6U2tMWyX3be8i
 wXuIPLfj51LGHrM5Up5EESuoMrsu/lEB26daJ9EhNofLMb6xfN6FdYcU3NAPj4CkuHKy
 6pUYJgu3JRT/Qp/6k1V4jXiU6HgEbg7ieasvnhr3emaqgxPzRxrrFnLpOW1IIOdivXQc
 /Hr/Ou+CC+UITvdwrrbpEEWoD3Tt0wT4bY5b2kGhtXQtp1lKZdbkQ58mcRIWtLlFnuBj
 uEMvwc5WwT3LsEwGRN8oqPFLXnJzzr2+ZGBzFlFZQhoWxluPVk5aWzHlbmXMCzD2AU6+
 r4xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq5gnFGPBNf9kLPiZSM17i9j1Mj/WDyipsgZt8pmzI1tYBnJ1Id4FLOzOgcTYsytUxycTc5Amgph8HuUvNFeofUaFBQ/s=
X-Gm-Message-State: AOJu0YypAcozbFh6LXNsoah3h3/8HoU0fvOlLxeQGN4zL3ZQZZRcgp1j
 rbNV/2Cmdy2iEMIu82brq/4LPcXAYQWv4dyvG0Yiqit7V4MINM7W0/QVMAAGnaDyEiTMldeqBeN
 oYXP+rniBnDl6z6T8qiRaGBnREw==
X-Google-Smtp-Source: AGHT+IGTHqk+zzw6Aei7T0+8dlIobwB5c7dlCZCUi29oW+vxF9+KTvziSZt++jDWEbvn339bKgv32C/NIsWiwrdp5M4=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:aba4:0:b0:dc7:42:ecd with SMTP id
 v33-20020a25aba4000000b00dc700420ecdmr4655431ybi.6.1708536810474; Wed, 21 Feb
 2024 09:33:30 -0800 (PST)
Date: Wed, 21 Feb 2024 17:33:24 +0000
In-Reply-To: <20240221173325.1494895-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240221173325.1494895-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221173325.1494895-2-nabihestefan@google.com>
Subject: [PATCH 1/2] hw/intc/arm_gicv3_its_common: Increase DeviceID to 32 bits
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, roqueh@google.com, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=36jPWZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Roque Arcudia Hernandez <roqueh@google.com>

According to the =E2=80=9CGICv3 and GICv4 Software Overview=E2=80=9D the De=
viceID is
IMPLEMENTATION DEFINED. This patch increases the DeviceID in send_msi virtu=
al
function to 32 bits to allow the possibility of a redefinition of it with a
bigger DeviceID.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/intc/arm_gicv3_its_kvm.c            | 2 +-
 include/hw/intc/arm_gicv3_its_common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 3befc960db..4eaf1cfcad 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -42,7 +42,7 @@ struct KVMARMITSClass {
 };
=20
=20
-static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t dev=
id)
+static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint32_t dev=
id)
 {
     struct kvm_msi msi;
=20
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_g=
icv3_its_common.h
index 7dc712b38d..e072c36cca 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -117,7 +117,7 @@ struct GICv3ITSCommonClass {
     SysBusDeviceClass parent_class;
     /*< public >*/
=20
-    int (*send_msi)(GICv3ITSState *s, uint32_t data, uint16_t devid);
+    int (*send_msi)(GICv3ITSState *s, uint32_t data, uint32_t devid);
     void (*pre_save)(GICv3ITSState *s);
     void (*post_load)(GICv3ITSState *s);
 };
--=20
2.44.0.rc0.258.g7320e95886-goog


