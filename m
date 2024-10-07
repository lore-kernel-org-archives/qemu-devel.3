Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E491CCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlXK-0001ph-WA; Mon, 07 Oct 2024 07:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXI-0001p5-UT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXG-0006Xn-4a
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LRI0xIJx0eVcqyQ8rbuR3b680cFD6gQYtFnqRaiaLw=;
 b=PBip5eDMaOm1RQRD4d+doIxeHU2EJjzTxSy3VDQsSvKd4POyHQKT7609lXRDTK7v5/pPEq
 EMq2dD3L2GmtEU9dK36k0QE1rh0tEPiQzLVLV5DOg2+3VZbbMq3rYaSRuxZbySHHr2sdAk
 BefIehQVRlLDakGIGXtU74Y+Yw4WXLM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-v-m4h_FzOJGw56po67W3lg-1; Mon, 07 Oct 2024 07:04:15 -0400
X-MC-Unique: v-m4h_FzOJGw56po67W3lg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb2c5d634so28359125e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299054; x=1728903854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LRI0xIJx0eVcqyQ8rbuR3b680cFD6gQYtFnqRaiaLw=;
 b=hqbiHmMCSXuz79+u7ltalzFsZPbVEjhVwPQhCQbCF3RUU/5IJtMQ8G7HsWzs8wwMYO
 kEjzmOEeopVCD3iXpFa6wRTdLml89eZToo9dVRK+o3f4tHFWZzN20gvs+5/jCOoWAtgc
 tvojMUOkLD0KUYQVZXVAMmqh1ZFMaO3ypnzlpWn3xiZDfagMWuz+SVzwpdKS1p0EADup
 /0KjCF+cS8MriCC0pGG5B7bfLM5Mq7PPySQrqugxFesRjmgWJAKJEZGalKxUPNgOjNn3
 iQo8BPKIOcbeB7oydmo6YhjD8+mKdI2q5TYUED2FiHYN2KJ7gpmDfjajszd2WA0tUHAv
 /Row==
X-Gm-Message-State: AOJu0YwNdc6nPxSSyeVcKLoYbxzQjAwYv5sCyelMlAZ4+mLgRmdK+Y1y
 JmHW/fqqnSbSLUHEYxg1CsaecPx7jAN6ny66sk8FRYmondNQbnUWr31hD3GFPPPQCSOx6VMTJTN
 0bpOU2PwVeExJWIfukrFxDemAyJysLOStzDkV2sL0Ksa1PsB+8Qjud4rr6qItmUZPdltLs5wGYJ
 2zhrgaEsZg4o3h0JOeUnnJT6KPwz0QZ/XYAyGXlbk=
X-Received: by 2002:a05:600c:4514:b0:42c:c37b:4d53 with SMTP id
 5b1f17b1804b1-42f859b14bcmr81081085e9.0.1728299053668; 
 Mon, 07 Oct 2024 04:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQl3RdQS0Ey+XMrmGbShDy9oClz+Idenz6hCA8QBPQblVLqjFJnpSQlPuPXC6Aezx1NlVRjw==
X-Received: by 2002:a05:600c:4514:b0:42c:c37b:4d53 with SMTP id
 5b1f17b1804b1-42f859b14bcmr81080695e9.0.1728299053165; 
 Mon, 07 Oct 2024 04:04:13 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b4aa8dsm88978755e9.43.2024.10.07.04.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:04:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Subject: [PULL 06/12] meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
Date: Mon,  7 Oct 2024 13:03:34 +0200
Message-ID: <20241007110342.1298598-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
2.46.1


