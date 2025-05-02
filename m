Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D514C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYQ-0001Au-SL; Fri, 02 May 2025 06:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYM-00019R-V2
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYK-0000ei-Pa
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgDIE30XzoIywzR02KFIEjUl2Fse4v4IpzEPr0mViA8=;
 b=I4QWKjFOUQdXa2xNqwy8ynwHj0PJyTObTcHuH4T0wd6sb/eIwEQEHfscB0RCsYx6lc46ra
 XU/MYoBn1HXKh1ZZ1V40rKzg0RTBuyDTURN63KW34wjfBlZ+TbgU9thzt6yfkTr0JuLAuR
 wR8dfGzEf+ARkz7BRHORv6DJjTwU72U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-_sS6UGewOpy-ewFtK0RLCQ-1; Fri, 02 May 2025 06:23:30 -0400
X-MC-Unique: _sS6UGewOpy-ewFtK0RLCQ-1
X-Mimecast-MFC-AGG-ID: _sS6UGewOpy-ewFtK0RLCQ_1746181409
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39131851046so391379f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181408; x=1746786208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GgDIE30XzoIywzR02KFIEjUl2Fse4v4IpzEPr0mViA8=;
 b=fXOvRvWdJOypTDTjM1qgEZQrUok7XWfNPqECGfY+FKDVWn9RAWl4sQlRf9NMFoHGV2
 g4T6aQOyK50wHFZDEeMOeZz+tmNZmhj/ajhcV+I5bB/KGDUoDRiO6AlGjJzOTkZUjoFh
 kTR4VC0eR0dLCwm70iQXWinus2ZkeDw0PsR5+Hm+rpwQeZGuZmBKouxK7TLOHjl65Trs
 wXDPH06GTZu4/txhPJdQC+GDnrA4AFn7h1hCFYRRsy8z4tSP5UHLtYoj2KV8ExPVGK+L
 2omwKzZqQlLDpyBdEbopc1I2lp4nv+CYeOZj+0eKZRisZbartlwlEKTygBG2iWRKG6Ot
 iiKg==
X-Gm-Message-State: AOJu0Yxjp2A9BzN5NRmpcjBfCtZ3Py+BlSeIpwAZJgQ2fkeleFN0WnK+
 r12wK/XDl4A5qxN8lt5CAlvln3HXl01G/0dJKDchRxMBn4iEPkR12SFOrUZxifJ2RFTftS7l7ne
 9WknyQe0sqXVSsZH0JlZLWLRbiBJcgWtnFXPVCu1buso+Q2B3GGfNuxc/S69z1XKuLAxke3p8L8
 ia0HACQ/+EW3XUSPlp2n79tftfylV8O1VoRLgF
X-Gm-Gg: ASbGnctOlEiWiuksAT8n+ltwwtgM9+TFoe1ptWgDOwVZ1Jg4HiN5WDxcCC1WN7f1yqZ
 4Kzi7nW1yDkHiYFUB9dVBC+rohDBzGNHg6HpnVz1csxCR8ha4ExRT0z031V8cR891MVhm4O6psa
 g+925bBdMhG3a59iUvqHGzOcENce6Ms4eqH5S8IarQTkmTqAUvQI3erIJUxgBeqi+Z00VtRuen2
 xcEhdflLgQ6JWY+YfEy7UkZniLare8TN3DI327J2dUWjXmwrqJ+Bbp5RuLQ7RJ4h9JVUGy3noeo
 cZWZjk94PMpBbTA=
X-Received: by 2002:a05:6000:1a86:b0:39c:310a:f87e with SMTP id
 ffacd0b85a97d-3a099ad62acmr1819909f8f.16.1746181408370; 
 Fri, 02 May 2025 03:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRzgtNEvTxvR9D0XSIaBpOuNpnosvpK5i9hJCbLJIrxsVq0m/jTT14S6CDisuK+/vtV8Q4gQ==
X-Received: by 2002:a05:6000:1a86:b0:39c:310a:f87e with SMTP id
 ffacd0b85a97d-3a099ad62acmr1819889f8f.16.1746181407961; 
 Fri, 02 May 2025 03:23:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc50esm40864275e9.8.2025.05.02.03.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/9] lcitool: use Rust 1.78 for Debian bookworm
Date: Fri,  2 May 2025 12:23:14 +0200
Message-ID: <20250502102323.104815-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The rustc-web package provides a newer Rust compiler (1.78) on all
architectures except mips64el.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst | 7 ++++---
 tests/lcitool/mappings.yml     | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 52521552c8a..bfcbb431f10 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -118,9 +118,10 @@ Rust build dependencies
   include bindgen or have an older version, it is recommended to install
   a newer version using ``cargo install bindgen-cli``.
 
-  Developers may want to use Cargo-based tools in the QEMU source tree;
-  this requires Cargo 1.74.0.  Note that Cargo is not required in order
-  to build QEMU.
+  QEMU requires Rust 1.77.0.  This is available on all supported platforms
+  with one exception, namely the ``mips64el`` architecture on Debian bookworm.
+  For all other architectures, Debian bookworm provides a new-enough Rust
+  compiler in the ``rustc-web`` package.
 
 Optional build dependencies
   Build components whose absence does not affect the ability to build QEMU
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 74eb13d62b6..2ac304b72ff 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -64,6 +64,9 @@ mappings:
   python3-wheel:
     OpenSUSELeap15: python311-pip
 
+  rust:
+    Debian12: rustc-web
+
 pypi_mappings:
   # Request more recent version
   meson:
-- 
2.49.0


