Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2224ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoN-0004ba-C7; Wed, 24 Sep 2025 05:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoH-0004Z7-AJ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoA-0004lE-6Z
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxLN7RzrnIG6H43LZkavcvPiQ5d1T/R4AZOxvLvIHQQ=;
 b=A5klvJmjDDXvs6TXCQBl086Hm/00gC0zm25glLBovcI6Na08lhTGKcE5kRIuRI99q7vQuO
 GUoRv+U8ncAOPoKMMaok4N2HjhnSQykVSft87OoQu6/kLZPsjuGoNmnEj45uHw8PkCZE56
 cvUoIffMAQf8eXFMjALl9vm/bfzMIWI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-JQwrumkLO8WiLb0bbYtUFg-1; Wed, 24 Sep 2025 05:28:56 -0400
X-MC-Unique: JQwrumkLO8WiLb0bbYtUFg-1
X-Mimecast-MFC-AGG-ID: JQwrumkLO8WiLb0bbYtUFg_1758706135
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-63359dd377cso5207887a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706135; x=1759310935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxLN7RzrnIG6H43LZkavcvPiQ5d1T/R4AZOxvLvIHQQ=;
 b=nX2ICj9zgkPIinnjDwRAJt8iH2Rw7HE+GRlFy6iXlA5DUR0C00lgzSi7k/r7WdKdnP
 IUX2CiPytuaqP+1VUHkVfVeuAM6XcCd8SL7vx80yRvwlG6sFYUWuUATkFHQII/F7JKXj
 4pNEh/QIcoGcm9rwxuN8P7SnTqXQw2hBB8mZmqfU6ZkhpcYDnM38L+ZCoPxMorfBt7ei
 G1AWMESoeoYq21Taj2czZldQiuc4lYGIFPb9CaGRimrfW/Er7y97l9NwM1vgedFQEWau
 lUQCRa0dZtJZ/jgSi5v16uAYCELivr8Q650iQttLXx0A93wYQ1iBsM6VSUZz8P/TUiZ1
 rGHQ==
X-Gm-Message-State: AOJu0Yzw+WFfENl+8YnSiPGfWud3W/mLXrbzKjCITJEYBgx1eqgYw3iD
 L2egB7+v07+5isY6rJy2loRd9tnvwQN+f37g0UxxjwJPVnKthLVPkVdBLiu5U4HEF/UeGI5z3xG
 +IC3/VvUzILQX6FKaICSb6kuZ+Tijoa8Ksaw3S3uLv+sEmrrAv9Kjfloadt3G6tVukRHqrDGMIm
 x4skVlPYEfW/gKOLpIlTIcG+TOtyz+UnIfJ/OopuSV
X-Gm-Gg: ASbGncuppVu8U0uXS8e7uHwihczEvU/T7CFe2VQhtw/9T0gRxVEbYmgGUux0zhz51NT
 e1uL/tVtYr1urZtzHCtpgbdH4BG1LEKVdOZv5ZcEZ3Kne9jFRV1zIQq2raS2MsKsaswA2IdeLW9
 JERTUF5cHyW8TZNw/L4t0pJJ/NEgNTOBkCybhTlJNHTsO7UYh7uvGWoN3BtKkWxctmXSARTmDL3
 LzNNRSmkrw7G8kjILC9f3kjk7JNYq+4Rd7XfdWbjrlqycwrQPd1laHksw1ap7FnKc4NPTwlnSat
 cHM2e8/1Ty9h3StJkOCMes8eFd6dmTKaY7I/PBx6MVpFpoPCfNSiwt3KI6yIefPONu4raupDYOI
 zDwtiwNa6z55F0SRm3ZWRVIvNPgC9OABTgZTQczcSgRcmuw==
X-Received: by 2002:a05:6402:34d1:b0:634:b40:a0ce with SMTP id
 4fb4d7f45d1cf-63467807609mr4857120a12.34.1758706134592; 
 Wed, 24 Sep 2025 02:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuXyR1HUpsoER9Tam99y9GkdCDLQpTTr92c79H8aqY+3jrk9sv9YJjJXjH41I+1P64Qd417A==
X-Received: by 2002:a05:6402:34d1:b0:634:b40:a0ce with SMTP id
 4fb4d7f45d1cf-63467807609mr4857086a12.34.1758706134028; 
 Wed, 24 Sep 2025 02:28:54 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa5d4357esm12689164a12.23.2025.09.24.02.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:28:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/29] docs: use the pyvenv version of Meson
Date: Wed, 24 Sep 2025 11:28:21 +0200
Message-ID: <20250924092850.42047-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The version in the system might be too old for QEMU; this will be
especially true if Rust is going to be enabled by default.

Adjust the docs to suggest using pyvenv/bin/meson, which is in fact
what the "make" wrappers will be running internally.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 2 +-
 docs/devel/rust.rst         | 2 +-
 docs/system/devices/igb.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 2c884197a20..6204aa6a72e 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -450,7 +450,7 @@ are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
 with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
 tests for all targets.
 
-If desired, it is also possible to use ``ninja`` and ``meson test``,
+If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
 respectively to build emulators and run tests defined in meson.build.
 The main difference is that ``make`` needs the ``-jN`` flag in order to
 enable parallel builds or tests.
diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 13a20e86a16..2f0ab2e2821 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -66,7 +66,7 @@ __ https://mesonbuild.com/Commands.html#devenv
 As shown above, you can use the ``--tests`` option as usual to operate on test
 code.  Note however that you cannot *build* or run tests via ``cargo``, because
 they need support C code from QEMU that Cargo does not know about.  Tests can
-be run via ``meson test`` or ``make``::
+be run via Meson (``pyvenv/bin/meson test``) or ``make``::
 
    make check-rust
 
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index 71f31cb1160..50f625fd77e 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -54,7 +54,7 @@ directory:
 
 .. code-block:: shell
 
-  meson test qtest-x86_64/qos-test
+  pyvenv/bin/meson test qtest-x86_64/qos-test
 
 ethtool can test register accesses, interrupts, etc. It is automated as an
 functional test and can be run from the build directory with the following
-- 
2.51.0


