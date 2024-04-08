Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDBFC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpha-00008M-Bx; Mon, 08 Apr 2024 10:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3k_oTZggKChA82489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com>)
 id 1rtpgy-0007GG-9S
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:54 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3k_oTZggKChA82489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com>)
 id 1rtpgc-0001OS-Th
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:47 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dcdc3db67f0so6654547276.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585363; x=1713190163; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0jpBzRSOQx0YT4byKXmmxUIsTrpT0wYz9PuDCeBDXM4=;
 b=Ejg+srfB2Llh7Rd7UcbC4p9JCRpZpWYXILgqi5Z/erwXHGgmPVgHhxPF7bLkRkU2X9
 khcE8kGSGvld/sV9rSKSCYrrC7OJv53Rbvsy8w3mIZQFWy1MJVH5ll75ecmFERbxBnZE
 G5m8B66h68uI4MT+3uKqSxZYunCux0aLXq5bp5RqSxmvDPzS40xZiXoc/YXqIEYuaVvw
 ynVG8Yfe89QovbSvnbYXSrLp97Wj0t4w4+rEaz+1UEhCJ3KOINx6LgzjA+/pSn2U2U/H
 wIOADU83UO9Rs9oJFrpM8UzgxeFeznZ4wWJj+5e/L7Hh3P6tX3yeSR+YUkqgfxAVj8UX
 Tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585363; x=1713190163;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0jpBzRSOQx0YT4byKXmmxUIsTrpT0wYz9PuDCeBDXM4=;
 b=G2f0tTf2AwjI5r4T5U3iWAXk0SQGQsVtvsCPbBCZPoeFq0qNSv0wl+kZQoFRPNdWKX
 jjpB0t5Gsa/VmrE7lNzp9ACsbeAmbveboLffWGVeYoxy8rH4Z1DP3WZJOZJ4Q89M+e1a
 rN+nwmcSmHHo4N2VOARSb6Tfe1nNPdVYVs1JCfAUUkWOarxnIdzuQ6ToPuxc7IvRcBRt
 z8ZvTgN2eVBDh/tCG64D1Kusi9yNyp645SRgp7XyFhPgSoN9UMo2jqUtGkhgGH1NfOJ0
 C/+gUZPxYZi9FJYdgyIUliGN57AzyOtcixmbkTniyYlcF+1Qoijr+4VolDIHuLK+ZO3x
 8dmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWdUSP4KUg+mweZfrtNCIUm5yosDFd9q6JAyHq5B8oDXUKPB1EHUbOp7PL686J7EEqVh+ywJg7SaRhBV1TB3OBDv6BRSI=
X-Gm-Message-State: AOJu0Yy+1XI6u52SiZsDcLQ3Aob6av8dgxrj0MFVnkq9XD4f14FXZPkw
 yUkia3xBHitog5YSacts3o/nsHBNmjKunSZhyr8yASyWO5o1lk4b+r49C9P4gFJDKI/A2sFiX6n
 mLViDX029iA==
X-Google-Smtp-Source: AGHT+IETEqKhx61slYVxF7Pmd96UxbP3g7TDyMwnYPIU/731Btbxiehx4b3mA0OOTFEN8/03TH4D/djrSRoB+Q==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:154c:b0:dc2:2e5c:a21d with SMTP
 id r12-20020a056902154c00b00dc22e5ca21dmr3387695ybu.6.1712585363249; Mon, 08
 Apr 2024 07:09:23 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:15 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-11-smostafa@google.com>
Subject: [RFC PATCH v2 10/13] hw/arm/smmuv3: Advertise S2FWB
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3k_oTZggKChA82489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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
index da47411410..0e367c70ad 100644
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
2.44.0.478.gd926399ef9-goog


