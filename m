Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2813C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf5sD-0006tl-QU; Tue, 27 Feb 2024 17:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GGHeZQcKCokx1zy1qvt11tyr.p1z3rz7-qr8ry010t07.14t@flex--komlodi.bounces.google.com>)
 id 1rf5sC-0006t2-3B
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:28 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GGHeZQcKCokx1zy1qvt11tyr.p1z3rz7-qr8ry010t07.14t@flex--komlodi.bounces.google.com>)
 id 1rf5sA-0008IW-IZ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:27 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc743cc50a6so6763164276.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709072664; x=1709677464; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=RLGdV4kCAjCSXP14B/AK52peEdH2FKlj4vlWN33bwOc=;
 b=ukz7GQZe8VZZK9yv4+c2s6BQxMT2CekAdeEtjt4U1tWHMCSE33MFAJQAGsvzmfV8k4
 UtGyRS9AzW8Jqvmu1DakLk/kGcRfZLiTjef5d3sLUNsgNxhYGaqGJitE8bNq14dSZe60
 GbN3q/dvyHKH8apRKiE5W68ZebfxdZYrY1SqiTeQtBzs0WNzlH5K6dByb+dNTJwXUsQX
 vm09KGrCO5T3b+twcSdQ1mHMBGWNz9ssEo28UBZtSi9YAFSwonnUMslrFAAEXcfLgr4r
 vf+tn5EkoSmE7UgfQDf3NH6VTuwHu6HPo04YFv0bZir1HWwjtWzgRMq/YhlRUtPJ1l0z
 WJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709072664; x=1709677464;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RLGdV4kCAjCSXP14B/AK52peEdH2FKlj4vlWN33bwOc=;
 b=WbckIXJ78xzICF/bmVX/9e7B98fhb2vPpVsqGjjxxF4emZyANu2wpTbpixxrNJ+29E
 GFDP2BOE1y0xN3T4eVqW0qlVmqWJgGKrLC38h+yvm8+Oqmrznt7fwBvGujm8yMUQgVM6
 AWCna2FzZDRXG2jbbYcRJN/IkIBKAjjxpNsZTaE8+ZM/rZC5xwT6B9W2GNlBOUxZc5fP
 GglknDumY6afpQsCGZhruiWsvQXy8zYn/DNOaIv64EqVaYr7x1NGXy1z6s2ZnhpJoFZi
 Db2RG0GEjMyzREljUGytITZSv9YCWZD9HIJAnQaVp8zLLXrm4MZO2z7KnRElcGwyGN0D
 ut1A==
X-Gm-Message-State: AOJu0YxhfGrX3s+TNMKfpRSEF6/lkZ/JF4p3XPmpotngcJ13l8G8lxvr
 vPT9+c1Ylssml7xt9M24Q1oeoog2GQ0qME6kgAkgZ/vWvHDqTrASiESaz+Iw+2ux83bRfu6SD5C
 EXmRGHoJGoy1YPhARmFgt1Rc2HUqnbz2fi/ukyBwfneKDyQXxogX7T7P5QWv+y9qx5PA7uc+13j
 IgoS3eRe05e0LpBV2RnVVOlJeJQXSjMnKLX7o2
X-Google-Smtp-Source: AGHT+IGOIeOaCJokdUWxsKdM3W8tMcD8kS986lskqyEK3eyiSELwVShX7PIVcdLubRrrH16sEI0dsMF+NW3l
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6902:120f:b0:dbe:d0a9:2be8 with SMTP
 id s15-20020a056902120f00b00dbed0a92be8mr81176ybu.0.1709072664329; Tue, 27
 Feb 2024 14:24:24 -0800 (PST)
Date: Tue, 27 Feb 2024 22:24:15 +0000
In-Reply-To: <20240227222417.929367-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227222417.929367-4-komlodi@google.com>
Subject: [RFC PATCH 3/5] memattrs: Add user-defined attribute
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3GGHeZQcKCokx1zy1qvt11tyr.p1z3rz7-qr8ry010t07.14t@flex--komlodi.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

These are used to represent implementation-specific data.
These are based off of AMBA-AXI user signals, but can be used in any
implementation.

The length of 4-bits is arbitrary.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 include/exec/memattrs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 942b721be8..a38645f881 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -64,6 +64,8 @@ typedef struct MemTxAttrs {
     unsigned int target_tlb_bit0:1;
     unsigned int target_tlb_bit1:1;
     unsigned int target_tlb_bit2:1;
+    /* User-defined bits represent data that is implementation defined. */
+    unsigned int user_defined:4;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.44.0.rc0.258.g7320e95886-goog


