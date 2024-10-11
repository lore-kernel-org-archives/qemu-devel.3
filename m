Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3ACD0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ6z-00042F-8I; Fri, 11 Oct 2024 13:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4U-0000hD-3Z
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHdX-0007DQ-Im
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DbehZlttuAvRWwiYZMnj8a7+ZQoZJPyuQGCQjndPlg=;
 b=GLT8TaFnksScPdM6/Rl9KX1M0vpAjRR/tx4Ht7MB5rbCdgsnQ7zhMWkEkrniGSFFPoY7/c
 ALPWfZo+9IHa/PePgYiXWN6FP24gzLZztCGJGwJYBQygqYVXmZ3Rxj4RYIDIjQ+epknoB0
 kzhLFt797B1sTgU5WG43Ot4SAIkETFQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-YRpffWhYMVa2hLL6YqNgKg-1; Fri, 11 Oct 2024 11:33:01 -0400
X-MC-Unique: YRpffWhYMVa2hLL6YqNgKg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a9959df649aso160986766b.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660779; x=1729265579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DbehZlttuAvRWwiYZMnj8a7+ZQoZJPyuQGCQjndPlg=;
 b=igVCv+04sIey12XzTsrf4Tm0empC0uIBh+9XG4kRxIz64c+sTaL67otvz4gZHIPYCV
 eU9NEepDiO1jZBLiZI9c/aiIQ+dqbOv7ZGkMkvBBSv3H1FZdJy2gl5qcT+CCJZ/EJCTD
 DIHbCOXxxNX5jHKp9m1CiNozMocC8Gcc5sLXq11EynCF4cSE5WJ7M6GhQtDn/V6ZAKGd
 C14Ql3aNhwQlK7WNGOG89413/NYNQEo3qLdMjW66VzW5vQJQST5qYZfF3Snkgbtm4G29
 Sng+6j5d2ZIZUKIlzlIo1WIekxFY1zKFXvYjWVEfTypfmBRG6iEusBYNqRLlbBc5q7UR
 FsHw==
X-Gm-Message-State: AOJu0YwUw1LSiKrSggDVV53VsCzJWn4nJOPIA1SNXkO+lvBvBoAel3M+
 X9R5G0vHkZFOg4lGFccD7k+SpeEjRETgaU2T0ODmItlXt2KFYG0FvPBqixqLgp6c5QUtGYsqfvP
 1uNWKrQ6ClAa8VmD70jWWp+FUSJpEDojZQNvD9++NbrNFGHm2rx9Z7xf9pobYZKvs9+EzFPPjeB
 rqrote3Ok/RdxgKnH9JLPiH7i0sTOXC7AvN5pUskg=
X-Received: by 2002:a17:907:7ea0:b0:a99:4e35:9a25 with SMTP id
 a640c23a62f3a-a99e3e448b8mr4951666b.44.1728660778992; 
 Fri, 11 Oct 2024 08:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd6dKcEVQeXImMg6X2cIvVnP9H1eSwNVOvD6ZxjT4wnGLbhw8L2jOuH0AQyoTiwzBFpJXa4w==
X-Received: by 2002:a17:907:7ea0:b0:a99:4e35:9a25 with SMTP id
 a640c23a62f3a-a99e3e448b8mr4948266b.44.1728660778444; 
 Fri, 11 Oct 2024 08:32:58 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dcdc3sm226799066b.172.2024.10.11.08.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:32:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 06/18] meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
Date: Fri, 11 Oct 2024 17:32:14 +0200
Message-ID: <20241011153227.81770-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Rust crates, introduced from the next commit onwards, can optionally use
the glib allocator API and need to know whether g_aligned_alloc etc are
available.

This commit adds a define in config_host_data that depends on glib
version >= 2.72.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/23f7b0cc9801d315f5d7835e30d775e133ec2fb9.1727961605.git.manos.pitsidianakis@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b9a83dfc744..aea419a8317 100644
--- a/meson.build
+++ b/meson.build
@@ -948,7 +948,9 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
 ################
 
 # When bumping glib minimum version, please check also whether to increase
-# the _WIN32_WINNT setting in osdep.h according to the value from glib
+# the _WIN32_WINNT setting in osdep.h according to the value from glib.
+# You should also check if any of the glib.version() checks
+# below can also be removed.
 glib_req_ver = '>=2.66.0'
 glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
                     method: 'pkg-config')
@@ -998,6 +1000,9 @@ glib = declare_dependency(dependencies: [glib_pc, gmodule],
 # TODO: remove this check and the corresponding workaround (qtree) when
 # the minimum supported glib is >= 2.75.3
 glib_has_gslice = glib.version().version_compare('<2.75.3')
+# Check whether glib has the aligned_alloc family of functions.
+# <https://docs.gtk.org/glib/func.aligned_alloc.html>
+glib_has_aligned_alloc = glib.version().version_compare('>=2.72.0')
 
 # override glib dep to include the above refinements
 meson.override_dependency('glib-2.0', glib)
@@ -2529,6 +2534,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
+config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
-- 
2.46.2


