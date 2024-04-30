Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C68C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qhK-00015T-Qb; Tue, 30 Apr 2024 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgl-00075i-Ti; Tue, 30 Apr 2024 12:50:43 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgk-00066Q-3n; Tue, 30 Apr 2024 12:50:43 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2db13ca0363so95568181fa.3; 
 Tue, 30 Apr 2024 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495840; x=1715100640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzipat9jfi0juaK8DzS+Vl1mWo37mk7jTOq9poKtbag=;
 b=eyp4yrWJ3EK3PlXaY7Z8w9cc9tNZdj9yTSZDBKynFcBOAniFRHRGZ/Dvt5JNjIhKym
 NMwHb733HRfSALHk8Tkh1kHm4m5nLNUH31/53VVXuWYWtC0mfxa0aYqNCgmSBXa4Xnek
 mNbdw1RXAS1lSr/YG4Bp7URrnXLJy1nX7/MXkA5MK07iPVYAIDnsrc+KKQvs9hz5C286
 +OQ2u0pTFqQEjNGhvcbHKBYqu65/nf6W+MJrjoDeelAQ/X0wG+O44KKiz7p2G1gOT1O/
 q7FZi/PuGbr/bJfuhudoYtKfRrnoUQ+yjuKEqn7CcBXvQh4mn2C2LtLN0gGGgiS15P2r
 CCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495840; x=1715100640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzipat9jfi0juaK8DzS+Vl1mWo37mk7jTOq9poKtbag=;
 b=fQcY8NNkayUY5rTV23s3C5nu9JoWhkfe5+tQsAIgqyR0KzF1M/oLS70l0JLH27JYHZ
 CkydfqPax9D3TS+F86OvF/Jy/D3LXxyQMQYDasw1KLyDtUXyVOjMQ3wEzW9QmqhED13L
 2oh7L9zeYn145qww/AaHQ7WWgulnKsga31YxakAek7aH/EdWo9zyW0JX3VQbyuM+dr7t
 oCZ8DI2pGzLFJjXUNNuk+uRP/x8XfqoPxyBfzR2f6oZsJHaenJAcd8RJo555hSocQCwM
 O8a3b1I4I0PGHLUMt72XojAyRhMkwN1HMwLik10D2is35ytVFyJuRRQ803UVMr2DvOGy
 iRSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHMchipmxIb6VMi/cEdMdiImZd659zMGLNvXukmKal8q5fbUxO2dVxiBaPsp7jblUvlq6u9N+795fFXdqaT0Xq8WEy
X-Gm-Message-State: AOJu0YxycYJar5i1RzSGfFQcWV11zFfG+wFBR47ecIyMcNm/+VoN2yYI
 Hl2dyukx94j2mBsYztKDs3Fh00OHvDMP56BI46L+nDLz19sHnNdjpR37iqOf
X-Google-Smtp-Source: AGHT+IE5I0psn0q10FnxlP3BV+p1w3O9Axel6EVi2qAM89LYPmK64ZWaL7a/7ZWVOltawOLUNQAxyg==
X-Received: by 2002:a19:ad09:0:b0:51c:732e:4e1a with SMTP id
 t9-20020a19ad09000000b0051c732e4e1amr26295lfc.68.1714495839514; 
 Tue, 30 Apr 2024 09:50:39 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a19760f000000b0051c144062eesm2198113lff.273.2024.04.30.09.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:38 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v4 17/17] hw/arm: xen: Enable use of grant mappings
Date: Tue, 30 Apr 2024 18:49:39 +0200
Message-Id: <20240430164939.925307-18-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen_arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 15fa7dfa84..6fad829ede 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,11 @@ static void xen_init_ram(MachineState *machine)
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
     }
+
+    /* Setup support for grants.  */
+    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.40.1


