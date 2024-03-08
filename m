Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F56C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribe6-0003L8-5T; Fri, 08 Mar 2024 09:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdw-0003As-0W
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdt-0005Pm-8y
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSLSAV6AzeUGqChFbxsNaHAkQhSsp716NDVyKQt1iAM=;
 b=DsiOWLYQyEjehj/davHMmzLJWdLgrwBXiVEjqQ7lDMpHqbgjjUXpjQZ2dFfrVBGJx4x2pv
 GnnoQ8gG67npfjd6vWjSDCyt3LjPXAEhU3CX8OWkfJfNBzrTU78mCxHQL1//h3cRKDwUTN
 SDpSu2CjApi7LFlNdUHWGMXURjZSKqE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Q1yIcjEmP2CR8gc7cGp6fQ-1; Fri, 08 Mar 2024 09:56:04 -0500
X-MC-Unique: Q1yIcjEmP2CR8gc7cGp6fQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a457ac99155so131103566b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909762; x=1710514562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSLSAV6AzeUGqChFbxsNaHAkQhSsp716NDVyKQt1iAM=;
 b=bhTPcG22Qcpdr6pZqrlJqQrfped2QU36i7FTONx6AwcL5Yld9xEZcwWLQ8hO2DjS6+
 XE5lTB1lLeNmFUP7RFSiNvu4YefDiSTYMlvNNCB2uBObOXMAodOtm/OqFuUa8qBLOJQ/
 fs+qdfjQQh6aTIUoY0yQx2RU9uhyKhzmQdkA8NEJhEHzSJ3G2Qf6DiYwN2yCJJs8CS7/
 2HcOtOZC82nnxxt+3CkhZlvz+yoUbczFkC6fuAtcVpDkx9BcMHMtcDRD1MnGphDv1Cdf
 muq3fVZDK/zH4dbXbbdpFHuf4tn3Q+9F9Sb4bzh5E+6pZX92Jkt6JP7/1r2GpxAQiBmm
 81FA==
X-Gm-Message-State: AOJu0YwYwMayrSsQxyXuqGZ+GnZJ6DyE6eh+0bAC8AdlagK6D8owVHwU
 H7VoPDWBb9sbfiloFh8Sq6v7HkIKny3w5QSs2uGO5RLG52ddxBoPwhnKgsQcY/79FYvbxez2TsR
 1Cq4z/HAE/LQ+neiyQnPNfb7cdaRNMuzjYhHVrh1ulFSkETbqog4Xcc+CKGNrS0wLNNokPzpCKX
 WtxrUnra+4U6j5pbk4gj+Fu/IY4I7B5Q+FKD8C
X-Received: by 2002:a17:906:b00b:b0:a44:c583:dfc8 with SMTP id
 v11-20020a170906b00b00b00a44c583dfc8mr13204650ejy.48.1709909762674; 
 Fri, 08 Mar 2024 06:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjL2A4G507V2UHYAxfkfrPJGD1Nj/8hej7IvqWvzBMm7Q60W9oIUkicLA4E2Lnlj2zw1KO5w==
X-Received: by 2002:a17:906:b00b:b0:a44:c583:dfc8 with SMTP id
 v11-20020a170906b00b00b00a44c583dfc8mr13204638ejy.48.1709909762358; 
 Fri, 08 Mar 2024 06:56:02 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a170906049100b00a40f7ed6cb9sm9406185eja.4.2024.03.08.06.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:55:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 03/12] meson: Remove --warn-common ldflag
Date: Fri,  8 Mar 2024 15:55:45 +0100
Message-ID: <20240308145554.599614-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

--warn-common ldflag causes warnings for multiple definitions of
___asan_globals_registered when enabling AddressSanitizer with clang.
The warning is somewhat obsolete so just remove it.

The common block is used to allow duplicate definitions of uninitialized
global variables. In the past, GCC and clang used to place such
variables in a common block by default, which prevented programmers for
noticing accidental duplicate definitions. Commit 49237acdb725 ("Enable
ld flag --warn-common") added --warn-common ldflag so that ld warns in
such a case.

Today, both of GCC and clang don't use common blocks by default[1][2] so
any remaining use of common blocks should be intentional. Remove
--warn-common ldflag to suppress warnings for intentional use of
common blocks.

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85678
[2]: https://reviews.llvm.org/D75056

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240304-common-v1-1-1a2005d1f350@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/meson.build b/meson.build
index c59ca496f2d..f9dbe7634e5 100644
--- a/meson.build
+++ b/meson.build
@@ -476,11 +476,6 @@ if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
 
-# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
-if host_os != 'sunos' and not get_option('tsan')
-  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
-endif
-
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
   # virtual-devices.
-- 
2.43.2


