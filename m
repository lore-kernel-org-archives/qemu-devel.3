Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2B2C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOErS-0005wo-NF; Mon, 01 Jul 2024 07:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FI2CZggKCnMjdfjkRWRXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--smostafa.bounces.google.com>)
 id 1sOEpa-0002XE-Fb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:28 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FI2CZggKCnMjdfjkRWRXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--smostafa.bounces.google.com>)
 id 1sOEpR-0005TA-3J
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:18 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-63c88ec6b76so51156877b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831829; x=1720436629; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=6TR1HS5bWU2AxlHLeEesw9bRSeiZbSyPpeNrZyRvosE=;
 b=UxxmDdtug0sutsHiPzZCGCOJlwZ4Y3L3xRejOQKtsMYGa9Md2I1fGYv6g8xvBkhZwO
 bzIl1zXZmZrwqVRd0q16a6scUn3H1N3Wp9YgU2hOp5fpnNH/f222JrpgavQfrr8wNnat
 awUxz0Afm2Lfvopji6z+5fL9ed72ETkq4ulmb3wAv/1Iy90rHw/EMT6UjbI2LcW+8bMV
 Z8k4BmbsXBZK6mMa0tUdr+wb2WA0JpIhK/EJJxXh22nlgrwI8/9d7N1T9FqD9v7TYAgG
 b2vopXwY6tpy+QzHF7VE51RuPyytmCSxdBR9Uw07QNsznlh9EloLhk9M4YVkA5h7kt0z
 00Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831829; x=1720436629;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TR1HS5bWU2AxlHLeEesw9bRSeiZbSyPpeNrZyRvosE=;
 b=LVDvmCLQtCtT9165eQFcB7PEMrnXluwSuMiunstm08KfSXjPA8xquBuw24pTauMmU6
 5Ay+pd1FQre4ov/c5YGNQEA8pDRYDPnEOzh+ota6ErDUSOK5gcxRuRWogqEkqjvNkZEd
 7rQ1vRZg7kQlGW8dRt/Z89H+x2Ot3QyIMDpjw2hfOjmApX+KIFA7ddayKXemK2ELq/LT
 n0YG7sSRjc6AaDSHH2PrO1DdY78MC7V4Lhd1/0Q/cH7yGAmXgXExbMD+q0+zOWK2CkPf
 bNuh76T9JkWh32pXLYNVXq4PUVLg9pbFFRuLv5M/BbqlXSYwhodofULXvfxbUgqSSCch
 tDcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvYO89yDws5o+f7wnUdObP5EkOB4d0h6LlvaV96SQJu9wPlxKN1yiHw8PmuDaPCKLlhPrNVB2RYOCB1V1F6MAgdkLPsg4=
X-Gm-Message-State: AOJu0YxfJDIAObDcq22HtrplQ/cd+ob/aC7jEzqRJagyMUuX56X1uehS
 CJLfgJeFkF0Z+EFjhfqHxl3b6i/AlRh2pYmsE3zcAUMYtNhYZYdn61ebQGTHJHfDy4+AXXIQIxZ
 SkH+pOliCsg==
X-Google-Smtp-Source: AGHT+IGVML7+woJDQJX7i+rDLaTenKLiX9jbgODjdeZvesO9hvvTUdn/HObsiOXs3fIFdg3+lF6FxyYdnqVR1A==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:dc90:0:b0:df7:9ac4:f1b2 with SMTP id
 3f1490d57ef6-e036eb485eemr148053276.5.1719831828787; Mon, 01 Jul 2024
 04:03:48 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:40 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-19-smostafa@google.com>
Subject: [PATCH v4 18/19] hw/arm/smmuv3: Advertise S2FWB
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3FI2CZggKCnMjdfjkRWRXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

QEMU doesn's support memory attributes, so FWB is NOP, this
might change in the future if memory attributre would be supported.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 807f26f2da..88378e83dd 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
     if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
         /* XNX is a stage-2-specific feature */
         s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
+        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
+            /*
+             * QEMU doesn's support memory attributes, so FWB is NOP, this
+             * might change in the future if memory attributre would be
+             * supported.
+             */
+           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
+        }
     }
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
-- 
2.45.2.803.g4e1b14247a-goog


