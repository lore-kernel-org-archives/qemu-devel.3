Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D57C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtFN-0007cJ-NQ; Wed, 20 Mar 2024 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFM-0007Y4-DO
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFK-0004JL-4W
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlJALeFak8LDWasQZpn/A/aSh2fPuC1/BRI+JrlavMU=;
 b=ANDZ61W0d+r96t8bQXUBhOq8Y5WAxyvQeMc3bw3mT8D1pMG5BCI7N6N/rQT6nnC3dGAUQP
 OGlEMSsGsj6WDPKDeGxTWxNuRiX5bNUsFeEswIwb4amGjoSCerlecTEyQww+AVTtnFv0kQ
 0W9PXPyS5FPJ2x3OACGV06klOckz2KE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-MPOZ_aWnOjyQWkRSs2JBhg-1; Wed, 20 Mar 2024 06:32:32 -0400
X-MC-Unique: MPOZ_aWnOjyQWkRSs2JBhg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56b8c7b5086so1752423a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930751; x=1711535551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlJALeFak8LDWasQZpn/A/aSh2fPuC1/BRI+JrlavMU=;
 b=rn0G0cjTuU8GS7z7LL8mVai8z47F2ec/D1Mi5IlGpuwN3LwKm4TSimRrzhrDWg5jEO
 yPPq0wrk6cLUNcsVOLQ6yiG0Iljm5Z2qq5cD+sTgYiuSG90JLNvJNV04/AirDOX3Dxsr
 nPAbqfQD2z0yvSFoL+NdXtzStSwrKwUchbJM47Fkq4nqx4xEkyL3DQl6iTzCGtmrV5h3
 HZSEOUNBOyKEX8jBRcanmoDNgeuwZANn+MBOGA8J9i5Week2hj9QhlJ0MUljnwy+1Od2
 gkw+XjJjOHPN82tSwOvU3Vq39i9cLRdLZl/A9VNJu1PIccCcySmEskN+pPgkFmJi/2UZ
 dOdg==
X-Gm-Message-State: AOJu0Yw+115CzbGW9qheDgTOPzRsyv/q+NGBvhq0/TuCgmCeGeQ5v61d
 6Pj6TZKfJPQJrGF1+apbTZAIYcV1tOSBv/mO7+jPSGFhGzj9t9/rZvAl5ub2ejUXvLGNtG//XEL
 gx8OPQnbuyJX61XGMpPHTPjHl3HQY0tdsssUGPx/rxPJdDTdWR3ENXxd/Hbd1OBmf7qcfqzUk//
 Zuc/T2a2+VuYuzIwpi9Ea8Er8XG32IJh9FuLek
X-Received: by 2002:a05:6402:3648:b0:568:1b94:fb88 with SMTP id
 em8-20020a056402364800b005681b94fb88mr14589358edb.23.1710930751057; 
 Wed, 20 Mar 2024 03:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpFJf+d+zsYO/sRZbIajE2pUWNHMYh3vNC9vCnJDZxZ1a20THeYcvPojM/h8bnnx734kk4tg==
X-Received: by 2002:a05:6402:3648:b0:568:1b94:fb88 with SMTP id
 em8-20020a056402364800b005681b94fb88mr14589334edb.23.1710930750702; 
 Wed, 20 Mar 2024 03:32:30 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 ef6-20020a05640228c600b00568c2ea2cefsm4512447edb.51.2024.03.20.03.32.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:32:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] meson: remove dead dictionary access
Date: Wed, 20 Mar 2024 11:32:13 +0100
Message-ID: <20240320103213.1048405-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320103213.1048405-1-pbonzini@redhat.com>
References: <20240320103213.1048405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

The "link_depends" key has not been used since commit c46f76d1586
("meson: specify fuzz linker script as a project arg", 2020-09-08),
and even before that it was only used for fork-fuzzing which we
removed in commit d2e6f9272d3 ("fuzz: remove fork-fuzzing scaffolding",
2023-02-16).

So, remove it for a very small simplification of meson.build.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b375248a761..c9c3217ba4b 100644
--- a/meson.build
+++ b/meson.build
@@ -3951,7 +3951,7 @@ foreach target : target_dirs
                c_args: c_args,
                dependencies: arch_deps + deps + exe['dependencies'],
                objects: lib.extract_all_objects(recursive: true),
-               link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
+               link_depends: [block_syms, qemu_syms],
                link_args: link_args,
                win_subsystem: exe['win_subsystem'])
 
-- 
2.44.0


