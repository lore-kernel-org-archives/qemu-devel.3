Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8C7C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduyK-0005b4-V7; Tue, 13 Aug 2024 13:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyG-0005K6-RR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyF-00037C-5p
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5IupmQd5DA2WBQItPa15ZG/dQuCisWLsaX6Mj1XqWk=;
 b=iPWGfHs1xalyCKngNe6Jjyctrt/wGGZH7UwFncNX2W/cUWsvUw16Bk6KfuKbiw30ELPyRV
 VVLgjbri/6Atgvx7De6xWTg0Rh+TQBGISeuoXz2UdIUpHdmiDuHn/ure4xbMZgFND0Mfp5
 dkAk0k/mIIaBcbUFjbJaUqPZHsXSudg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ocsJMI25Mg64RbkLHE5ZDQ-1; Tue, 13 Aug 2024 13:06:04 -0400
X-MC-Unique: ocsJMI25Mg64RbkLHE5ZDQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2f0276170f9so52537091fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568762; x=1724173562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5IupmQd5DA2WBQItPa15ZG/dQuCisWLsaX6Mj1XqWk=;
 b=AKMcWJ/ta6oEUtOWMmVvQt1DdBkL6wmmSZYTUzssaoRNyuyu4VW+vglDpE/xVqbuae
 PZBXXfpYXuzei4H3tFnfHp7U6uGudpsbq4BHtZUkVw/ckjzKwc+UFwyr/6Iq9ZHk7At4
 EiHwnEWeAOeveTa9GmqJpCWIvlqZGKdyFr91Oes7SEFuldhL6zNfgZabgjXv2E9jIhp8
 73TlcRP3ttdSjj172LCAAizwG1HxjSsWGwslpjc61QRCd0LKkICxZPhqHz5bHAQ5CUlr
 IfSFXGnRUtpsV9o3d1WhIXj9g9lgn0diYxBJcXF9NlZda9xom0lzD8awF7uslXuD7q5U
 JmDw==
X-Gm-Message-State: AOJu0YwM6RfU45f8UlksTT1Z1LkmLm0ZEPN+x2tn+mpXB0EBp3pqLsE1
 D0/AmQTm8ESYJhTOekIG8u7iRlV+cLEYn6RwYiO+KPYn1CFcFZOphPZqhqjjv4bKAYH4Hj6ZJ1M
 NudSfiW20Bo8dNeVApq/Vu7PaP6hRi+DWvSplaQLfIOzgA6ooDS/1NCg7jxFnDJMhxAFuYAuWBw
 vJS9VaMWQtu24LUhIakSgpouvO9siltAVQtvdS
X-Received: by 2002:a05:651c:154a:b0:2ef:2b05:2ab3 with SMTP id
 38308e7fff4ca-2f3aa1b3775mr338911fa.10.1723568762495; 
 Tue, 13 Aug 2024 10:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH6Ro6X0imBx16c8+0bX9MVI0UyhzZv0KOmNjhbCtmXS9h2LM7UppiCMZ7/VcCfr+H11eUHg==
X-Received: by 2002:a05:651c:154a:b0:2ef:2b05:2ab3 with SMTP id
 38308e7fff4ca-2f3aa1b3775mr338661fa.10.1723568761759; 
 Tue, 13 Aug 2024 10:06:01 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5be9feb7528sm147091a12.82.2024.08.13.10.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:06:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alyssa Ross <hi@alyssa.is>
Subject: [PULL 1/6] target/hexagon: don't look for static glib
Date: Tue, 13 Aug 2024 19:05:50 +0200
Message-ID: <20240813170556.104193-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170556.104193-1-pbonzini@redhat.com>
References: <20240813170556.104193-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alyssa Ross <hi@alyssa.is>

When cross compiling QEMU configured with --static, I've been getting
configure errors like the following:

    Build-time dependency glib-2.0 found: NO

    ../target/hexagon/meson.build:303:15: ERROR: Dependency lookup for glib-2.0 with method 'pkgconfig' failed: Could not generate libs for glib-2.0:
    Package libpcre2-8 was not found in the pkg-config search path.
    Perhaps you should add the directory containing `libpcre2-8.pc'
    to the PKG_CONFIG_PATH environment variable
    Package 'libpcre2-8', required by 'glib-2.0', not found

This happens because --static sets the prefer_static Meson option, but
my build machine doesn't have a static libpcre2.  I don't think it
makes sense to insist that native dependencies are static, just
because I want the non-native QEMU binaries to be static.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
Link: https://lore.kernel.org/r/20240805104921.4035256-1-hi@alyssa.is
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/hexagon/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index b0b253aa6bf..9ea1f4fc594 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -300,7 +300,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@']
     )
 
-    glib_dep = dependency('glib-2.0', native: true)
+    glib_dep = dependency('glib-2.0', native: true, static: false)
 
     idef_parser = executable(
         'idef-parser',
-- 
2.46.0


