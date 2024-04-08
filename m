Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B865DCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 19:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtubL-0002oK-RF; Mon, 08 Apr 2024 15:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubJ-0002nj-VM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubI-0002gi-Jp
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712604255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vSBMhBtj/sj30aw89QcZUxPaC4m4Acoc8GD/lzDGIo=;
 b=VnOkEc5L55uqRU8LeV6vb0FJu0tiFqcqu+Fdh+gcNj3r2kdw+XfjNtQE3OvNAq4ZsXrba8
 9MJZqc2dUL6vnsP0zq5sSa+F2/TU0tEtTHGov1Zxo0jYWwAqbW9CL2yVUr9PTcqS1JCsTT
 +/UV4B6F6ZIY3gi2wDgB2VPBY3pLfkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-gbRVjKFVNhK7hWMvT1WDhA-1; Mon, 08 Apr 2024 15:24:14 -0400
X-MC-Unique: gbRVjKFVNhK7hWMvT1WDhA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343d3e1ff1eso2605608f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 12:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712604251; x=1713209051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vSBMhBtj/sj30aw89QcZUxPaC4m4Acoc8GD/lzDGIo=;
 b=cfC2ay6ztJfOzuh3SIWNODAAEoiQYugvEWG2zLfVMOi0YkKQIchTqD2IiRLZbASgA2
 6AIdrunjxWz5IhOPubM9+P7xo6xrdIeULZvWSUenkSMRTFzE/54pEY7/Bvy4LtcFIYcH
 ib7hb3W1j14YV1mSWfSNbQ1qRyge7fQF21Oh1hDeIrbstu08TjarjX6UAT4lDxhdhMxD
 gf4Wq5eA43a+CBAmhxGPgu7IpvKMj0DO5PFsa7F7L8RIcjmKJiRxK2wiqBMndpEcbobT
 G/83aOrNMaxFSIK/SjsG58WzsvhX0B86f5hRHxqWgx9+9s87Uu+EZ1YIGGqG+xSuVOBl
 WJ2w==
X-Gm-Message-State: AOJu0Yw53I9DVak+kXYPdIASfrazYUl3X6wBrhUNnxidaqOEs9xD8mTT
 OCZsWIeP5fQzHL3QelL4JJXOJheTyJ7jM/2J6S9Xurc8J2YgwjTwIt0j5bHEgsbyckhoTiNJ518
 FOE6PTw/U6MYtUCU1edFeO1kdv+TRPF2tSnZpjpDvPBC5eHMiuWGEYrgc/nv7REEhJgLtNFXe5Z
 tyfXCYW+KoBbZA50yv3T8g451NE/Sadk4xNvnw
X-Received: by 2002:a5d:588b:0:b0:345:ca71:5ddc with SMTP id
 n11-20020a5d588b000000b00345ca715ddcmr3333177wrf.26.1712604248500; 
 Mon, 08 Apr 2024 12:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH03hJYMolhqCr08p62c+tIyp6+Lvu/CihOtpQkorPrlhfUQFJfYtLBflaXf9451hFQHWXK5w==
X-Received: by 2002:a5d:588b:0:b0:345:ca71:5ddc with SMTP id
 n11-20020a5d588b000000b00345ca715ddcmr3333156wrf.26.1712604248068; 
 Mon, 08 Apr 2024 12:24:08 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 jg25-20020a05600ca01900b00416928e239csm1587990wmb.35.2024.04.08.12.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 12:24:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PULL 1/3] Makefile: preserve --jobserver-auth argument when calling
 ninja
Date: Mon,  8 Apr 2024 21:24:02 +0200
Message-ID: <20240408192404.542506-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408192404.542506-1-pbonzini@redhat.com>
References: <20240408192404.542506-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Hundebøll <martin@geanix.com>

Qemu wraps its call to ninja in a Makefile. Since ninja, as opposed to
make, utilizes all CPU cores by default, the qemu Makefile translates
the absense of a `-jN` argument into `-j1`. This breaks jobserver
functionality, so update the -jN mangling to take the --jobserver-auth
argument into considerationa too.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
Message-Id: <20240402081738.1051560-1-martin@geanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8f369903356..183756018ff 100644
--- a/Makefile
+++ b/Makefile
@@ -142,7 +142,7 @@ MAKE.k = $(findstring k,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.q = $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
 NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
-        $(filter-out -j, $(lastword -j1 $(filter -l% -j%, $(MAKEFLAGS)))) \
+        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
         -d keepdepfile
 ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
 ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
-- 
2.44.0


