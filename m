Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A7AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtCL-000515-8w; Wed, 20 Mar 2024 06:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtCK-00050w-19
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtCI-0003Ix-Hc
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qlJALeFak8LDWasQZpn/A/aSh2fPuC1/BRI+JrlavMU=;
 b=OqZhmQg9HBXvaApvSbXzFOx/uB0Zrok4Xi/PDRfMTyAyozqh3+4ebu7gBChc5091NNmyn5
 6IpVpRPXzjQodQUVBRupUDiwRXKbu8cRHtjYaAhR6W0vb0UZjbnCJbP4cKHE0cwe9npFU5
 eGhZzBv8+PeGZ6IwvZtHp4f1sGL5zIc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-1LEmhRscMIaNh-QRAz72PQ-1; Wed, 20 Mar 2024 06:29:22 -0400
X-MC-Unique: 1LEmhRscMIaNh-QRAz72PQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5148eaa60acso2755800e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930560; x=1711535360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qlJALeFak8LDWasQZpn/A/aSh2fPuC1/BRI+JrlavMU=;
 b=fSUw/okILaSWaBrHSjvQmoBx1Db5l1RCg5GbnXdRM3ITJTReQrmN3xrYFWoUFKLk5e
 8eGFfe0nc7Qv4CytkZ9st4SKLrAl8JFezTYxGgb1r/UsQ8E1HGK39uE7SZkN6lloE/OH
 7aLGaizNpUFpIoep9LcqEcpVHnDXJVeNsPlUDUJ/LWJlF76juI3KLUy9rV7VRoLQlTdT
 FvotfWN6kh5zMWKxqCvyYODG0xLXpqNP7yQ4Fk9+bAmKEBTRyhVWJl0LKc72hYkOtVGF
 xJ96jqhJ5zDdTnUyeLsAFepLMYtefkXSDzpI/coPR371Z90YtWUF9xqjB4jI6Ncg8VCX
 L9Uw==
X-Gm-Message-State: AOJu0YztXQyUscTKtXU+C9L7zw+pO8doGqh96U2yIQd1HaogyB2FPhFk
 7ObL994eC8QONeIhh644xMey4pDjOqq55XWUlFZgPHwDE9YDdzCYRWEDfbZZZgM6mY9pSfco9zx
 KDTyuaO7US0aXug3xmRBnsayT5h6TvZS49JceHVigIfYwEScWZtH+Hnvy9bv9IHdBNkD/dGUvFX
 zdZSWi5ic77Rr1cPvVcFS8rIf5TIZA9oP2avil
X-Received: by 2002:a05:6512:466:b0:513:201c:5dc6 with SMTP id
 x6-20020a056512046600b00513201c5dc6mr1239000lfd.61.1710930560567; 
 Wed, 20 Mar 2024 03:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSUAVqEVWojnV3/HoBAGGiuIoG8MUSdyjefQ4xN7fBD8X97t8UKNpjYEFlEtciVPY4jPs5Ug==
X-Received: by 2002:a05:6512:466:b0:513:201c:5dc6 with SMTP id
 x6-20020a056512046600b00513201c5dc6mr1238975lfd.61.1710930559917; 
 Wed, 20 Mar 2024 03:29:19 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 i31-20020a0564020f1f00b0056ba017ca7fsm1238619eda.87.2024.03.20.03.29.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:29:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: remove dead dictionary access
Date: Wed, 20 Mar 2024 11:29:19 +0100
Message-ID: <20240320102919.1047984-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


