Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C66CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoQ-0004d0-Cz; Wed, 24 Sep 2025 05:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoM-0004bb-IX
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoB-0004lR-9D
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mGe1RNZOMFuiqKM/TEXFkBBUfbfbrXn7gTWkrNC4UA=;
 b=Ybk0pX1Z6SvjcEiqXgxO9A3aQj61yzXlZrzXUgp+utsb3qmzsfuRZDIdBQI/Al6sUas1c5
 syYCoZBRHcnUuSXFuJ6jsvNouZUpesoLYYj2Cj8GfrOm8bRdpEN0ZAGQVnF2RTutyUStFX
 MMPSNmMAIXYaGXREZveZ3uHfvEHJMeo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-Msg-lM61MhiHBs2frcFGTA-1; Wed, 24 Sep 2025 05:29:04 -0400
X-MC-Unique: Msg-lM61MhiHBs2frcFGTA-1
X-Mimecast-MFC-AGG-ID: Msg-lM61MhiHBs2frcFGTA_1758706143
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b2fca156551so75321266b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706142; x=1759310942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mGe1RNZOMFuiqKM/TEXFkBBUfbfbrXn7gTWkrNC4UA=;
 b=uUI4f4uHdcWvKUF1dIoPvZPds+uUyc502A/D83FFWxq5cBW8r2B/vWDDlKzPsWVH8x
 /NIKfyzsMlGCwN4gXU+Ul0t3F5SVgd05uqpfQ+S4obBkqTxyUCLvxHBKToomp4Aztj75
 tNU9sfQJGJsQqMOAFB3frfp2bINaCa1fZ/FApl9uivcx3Atof0GrdX8rz42eFyZ1lvrV
 1cjarAITCGjBGWCk0rTO5xT91Q49d5db7tgIuzjQ4pq7DzmcWHBQSgnpH1WK1J5vf4K9
 Lk6Tk9dfNH853q0SIS8t5I/kPitTCNajGZ2eT6QF7Jd6lY3mtJY+tLSS4w3MR8MBPBVq
 f1xw==
X-Gm-Message-State: AOJu0YwOVppIufYKsT7qmaIITQ9ksod88IMIOfCXaAblVFhnwTZg9xDM
 XhOYxLgmCSN7FZyFGJl0aCYKgetOp5RUkEqCAPtvp1y7I1c5s3K9DHZgWrx5fwDcMHuflcX14iI
 BH489qFsK5TBWCIwhZijRUPYI8u7mPrJJU9mduh6uvOkLF3CsxSIbtl3x67qvGEFh1/RkujNjyc
 z7ZFSiyjGtZ1BtLv5PeT7kiMSr1OQ/ZCR/AFaLWcD3
X-Gm-Gg: ASbGnctWtExwr/sZp3TrN/F+HpvkelNRpRawPPSGbd6QB/JdU4/BSr0aKlzmPuELAA6
 Ec3Fo7HFZEhIYS+4fjMtU9U0Ok1MeRDg3lNJD0SUBQT1UYaeo+lwOJSDfDTOetsnhaQ92RPdECN
 L04GFPPH8u7UFAvUbpqa4iEBp68uQ4atWhpyzpMyZrKZmEM22G3AC+91Z6HakSobBenzTD0Xp+F
 MftIjCxl4OXP2fXaJyTaleadS0cstCT1FI0YMZmHOMIqmSvg+1PmvpJGS7XKn1/MdwhwniIjQQq
 68rn/vlhy0eiMk02chUFe+wJzrDwnP7hd4+EzFuco7eUz+ROnvPbx57faYSwxLtBXDQcwI9golb
 A2BdEr1KEvD/9dRFAjzgFDEoz8Vv5dV2pUpx0dE6K9e7C3A==
X-Received: by 2002:a17:906:7953:b0:b2a:47c9:8ff5 with SMTP id
 a640c23a62f3a-b32c9898862mr206071666b.10.1758706142207; 
 Wed, 24 Sep 2025 02:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnFUqr714rN43b87P1Pk5M6M0dHEWb7no3YtufmOcSFtpQIFVGypgmJPP3vB0WNKLpL/B5bw==
X-Received: by 2002:a17:906:7953:b0:b2a:47c9:8ff5 with SMTP id
 a640c23a62f3a-b32c9898862mr206068366b.10.1758706141716; 
 Wed, 24 Sep 2025 02:29:01 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2713332a68sm1096623066b.99.2025.09.24.02.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 04/29] rust: build: remove "protocol: rust: from doctests
Date: Wed, 24 Sep 2025 11:28:24 +0200
Message-ID: <20250924092850.42047-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is added already by rust.doctest.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/meson.build       | 1 -
 rust/common/meson.build    | 1 -
 rust/migration/meson.build | 1 -
 rust/qom/meson.build       | 1 -
 rust/util/meson.build      | 1 -
 5 files changed, 5 deletions(-)

diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index f369209dfdd..7214d944089 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -47,6 +47,5 @@ bql_rs = declare_dependency(link_with: [_bql_rs],
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-bql-rs-doctests',
      _bql_rs,
-     protocol: 'rust',
      dependencies: bql_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/common/meson.build b/rust/common/meson.build
index 07d073182ed..aff601d1df2 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -32,6 +32,5 @@ rust.test('rust-common-tests', _common_rs,
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-common-doctests',
      _common_rs,
-     protocol: 'rust',
      dependencies: common_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 5e820d43f50..2a49bd1633e 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -48,6 +48,5 @@ migration_rs = declare_dependency(link_with: [_migration_rs],
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-migration-rs-doctests',
      _migration_rs,
-     protocol: 'rust',
      dependencies: migration_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 40c51b71b23..21e12148da4 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -38,6 +38,5 @@ qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qo
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-qom-rs-doctests',
      _qom_rs,
-     protocol: 'rust',
      dependencies: qom_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 96330504459..7ca69939ce5 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -53,7 +53,6 @@ rust.test('rust-util-tests', _util_rs,
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-util-rs-doctests',
      _util_rs,
-     protocol: 'rust',
      dependencies: util_rs,
      suite: ['doc', 'rust']
 )
-- 
2.51.0


