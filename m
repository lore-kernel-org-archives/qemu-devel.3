Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9405CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmr-0005ux-L5; Wed, 01 Oct 2025 04:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmn-0005uF-VT
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmI-0006Bj-BR
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VTQDRhx35WZbHde5Mr6+wFWJHKfg1tDAJgNYHuAiso=;
 b=Te1k8Lnr6rDb1MYo+pDpL+B0Ux1OPpgzLIi2ihQBD9c8o3drKxwR7JRHucreSQe6QF3zkV
 +sIL7hiAozIj/w+4fTIlij6NzObnMDxNVoEp433ctDbyTgWJTFQrpTgl2uuWK8fbsPm9US
 Uh4x4yp6ZW12dV5F4ESn1kC58tkSDYQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-J8i3-LaDPCaNvOS_nH9sYQ-1; Wed, 01 Oct 2025 04:01:30 -0400
X-MC-Unique: J8i3-LaDPCaNvOS_nH9sYQ-1
X-Mimecast-MFC-AGG-ID: J8i3-LaDPCaNvOS_nH9sYQ_1759305689
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634b661347bso6676446a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305688; x=1759910488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VTQDRhx35WZbHde5Mr6+wFWJHKfg1tDAJgNYHuAiso=;
 b=QFsrZct2Qwz10TEsRkGDsFqevPcOHIHdqzSgUh2pmDnQc3avThF6gCrq6faPVdSqsy
 7m+4v/HMCnpWX9c2qnqwRCi4+h/3mEhsjvnJvCijnjbXcb5R/umbcJlcRWcaYJcuLq4Z
 WACEGQJz55qVPkQxqAh2iyWQ9hElSprwbVf/rhen1I1WqJ5cx3SC2Cih+0OO9/yECW4C
 CkXE54jkTMsTyApA+wlDuzIOol0AK0XpYdxdRxxb98M3+T7Nn5K9wy7oA+gRD7XjDvGd
 h7J2U1bhN0XI+2OzQNee/GiLDrDsOLrHjRObb27u64zeGw6yILfj9gUHXMXQ7YV/B+UJ
 wXMA==
X-Gm-Message-State: AOJu0Yzs+WWggNqActJjszt4t/nOrijRJ1zxL5DMnum4wZ/bry1E/Cku
 hQk11+1FCCj+qa94O9BnICbhTj0M1unRSFma3HWXeF/6UjgDrqVsx01BrU/6X/pHzz3DQt+Du/B
 dDdscAKCeaULwXFqvq3HQJ1VwZWJ9jsw9FfqagWyIyY2OowGWyowfwIjaZ7/BzpjwW6XZy+drRF
 RD5y1mauyii+JJiAjE7gnJwDGuq1q5Nz3jkeKlxSw+
X-Gm-Gg: ASbGnctg7xrkCj+ZKXb3CG68BbUm/M9zwz5P0iywwHC/9iz/TtrpP9YFYcz2QnDd0YX
 ivJlPjUYQ9x1SWUs9TNiR74fI2GzoUL+XRw7Bnl3J1chD/q0oIdFRTIDPMMwsDs2KY89xVVeyOL
 Aa19n3JM+3CKzoCUbPvMbwwiLBqEjW5dtSYk2Q2xHNY5nV8zkQICTURYlIA+G9odGDyRPh6vrOA
 RaOIWlkBiRCCp+E2IP8Jwbvt0NjsNBrHCnFwNZ5rMfqvfb+zpK/cgS9vFQ5on8oDmqkH8I4NkKw
 awzPh9fPwKQEiPTTRf7FQYiPH/hoglgzrMnFE9M82e6BE1GDwK/WPdlkQAfF+9Dv+8RDs1EZhQA
 svPZIdWZL6VbNVWvXDoHMBdxHemcoC8AO/mUXKZna1m6pfu6D7NU=
X-Received: by 2002:a05:6402:d0e:b0:62f:5b56:423d with SMTP id
 4fb4d7f45d1cf-63678c35d1amr3061439a12.14.1759305687703; 
 Wed, 01 Oct 2025 01:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBhZUoyzAoLafyKGpv93i4OVNhbldjJJXNhr57MNWxJilswEObaVoYuu296FmUVSxVfOEgDA==
X-Received: by 2002:a05:6402:d0e:b0:62f:5b56:423d with SMTP id
 4fb4d7f45d1cf-63678c35d1amr3061396a12.14.1759305687221; 
 Wed, 01 Oct 2025 01:01:27 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3ae3080sm11534670a12.34.2025.10.01.01.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 14/14] rust: start qapi tests
Date: Wed,  1 Oct 2025 10:00:51 +0200
Message-ID: <20251001080051.1043944-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/tests/meson.build          | 10 +++++++---
 rust/tests/tests/integration.rs |  2 ++
 rust/tests/tests/qapi.rs        | 35 +++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 rust/tests/tests/integration.rs
 create mode 100644 rust/tests/tests/qapi.rs

diff --git a/rust/tests/meson.build b/rust/tests/meson.build
index 00688c66fb1..c36cab1886e 100644
--- a/rust/tests/meson.build
+++ b/rust/tests/meson.build
@@ -1,11 +1,15 @@
 test('rust-integration',
     executable(
         'rust-integration',
-        files('tests/vmstate_tests.rs'),
+        files(
+            'tests/integration.rs',
+            'tests/vmstate_tests.rs',
+            'tests/qapi.rs',
+        ),
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
-        rust_args: ['--test'],
+        rust_args: ['--test'] + _qapi_cfg,
         install: false,
-        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs]),
+        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs, qapi_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/tests/tests/integration.rs b/rust/tests/tests/integration.rs
new file mode 100644
index 00000000000..ebc17cb5550
--- /dev/null
+++ b/rust/tests/tests/integration.rs
@@ -0,0 +1,2 @@
+mod qapi;
+mod vmstate_tests;
diff --git a/rust/tests/tests/qapi.rs b/rust/tests/tests/qapi.rs
new file mode 100644
index 00000000000..3a54d37edaa
--- /dev/null
+++ b/rust/tests/tests/qapi.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#![allow(unexpected_cfgs)]
+
+use qapi;
+use util::qobject::{from_qobject, to_qobject};
+
+#[test]
+fn test_qapi() {
+    let sa = qapi::InetSocketAddress {
+        host: "host-val".to_string(),
+        port: "port-val".to_string(),
+        numeric: None,
+        to: None,
+        ipv4: None,
+        ipv6: None,
+        keep_alive: None,
+        #[cfg(HAVE_TCP_KEEPCNT)]
+        keep_alive_count: None,
+        #[cfg(HAVE_TCP_KEEPIDLE)]
+        keep_alive_idle: Some(42),
+        #[cfg(HAVE_TCP_KEEPINTVL)]
+        keep_alive_interval: None,
+        #[cfg(HAVE_IPPROTO_MPTCP)]
+        mptcp: None,
+    };
+
+    // let qi: QObject = 32.into();
+    // dbg!(&qi);
+
+    let qsa = to_qobject(&sa).unwrap();
+    let _json = qsa.to_json();
+    let sa: qapi::InetSocketAddress = from_qobject(qsa).unwrap();
+    dbg!(sa);
+}
-- 
2.51.0


