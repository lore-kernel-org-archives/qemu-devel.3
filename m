Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60445CAC588
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZTJ-0006qk-6x; Mon, 08 Sep 2025 06:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZTG-0006pk-5J
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSx-00069b-FI
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yHt1Cnp6xdqYeA2MrGvgIihPETwX6YFNW7mP7Vuv5A=;
 b=OOXjznqJa7Cuyqrn+1e/JT7ITjFcoiBdKu6+bFuPowGQPamRycJ6Ceiesd+BNA/X7bXms3
 pJ6ZcBmo0Nu3txsby+q4YKsyWL47Ph5KQ/Kh6d4IoFoV6rgFH5zg2JzMGD9Rm0C7lgKRVt
 H4K5sPBxy4PtRd4UOdzmSG5+7dyPLuY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-Q1Sff3tQPlKALWeaeb24ug-1; Mon, 08 Sep 2025 06:51:11 -0400
X-MC-Unique: Q1Sff3tQPlKALWeaeb24ug-1
X-Mimecast-MFC-AGG-ID: Q1Sff3tQPlKALWeaeb24ug_1757328670
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3df3e935ec8so2017767f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328669; x=1757933469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yHt1Cnp6xdqYeA2MrGvgIihPETwX6YFNW7mP7Vuv5A=;
 b=hS0u9RI4QcSvE8Mfbp01KIxe4e+Ly98puGCjJwXaqEETkOepWrLP/0Ao73v/odce7q
 Ge/rydwFBQDIwnKv+1LWv1N1G9KFfm5ndK+M1TvWifNZXg7Ux2F9OYwzrTxzkkFmGfRe
 2GIc8dJ4GXnV1vqIECVrOPHJl5msMXSp1jwh9KJvZoOFFZNAB96kAkxVSdTeHUwFy4fi
 xHYl6AuF6I3Zmf01soUKvwAV9ZlFZHc7vJmgpc1tbZr78x1lmHrZDRcAd931WSvygG9m
 A3zeVCOeU+8UYUhWFC1ySfbJoJpU3Jsf0bABo4+ifj3zHHXKYAZwduasiuvHFemMLb5E
 ieZA==
X-Gm-Message-State: AOJu0YzCqptJjFBQEcV+CQDvdi0Km6EGjsjtjUE5nkePGD778SG0VFez
 KDgZ/s7WgxVHAL3+x6/3yxuOVIvwgBYPecLRx6LhGYSjzGLmIJ7AmSXKh/hWceUYpSgYyAoHvw6
 ypp9Qn/MX+e4bAobcEQtMXP92GeHvML46ofnNhNLnknDZUGzSJSdyHj3aylp3m18RZw5s98UxQH
 w749SyVIU3YKv/dpIcUNmZ7TeWAlVzg3erDJTq6tmT
X-Gm-Gg: ASbGncuGuSz+U9di6jKsVwTqmi0DI3dC+uWHeaqGR3BjsESsr31gvSDZ2LMHZy1yKXc
 FtCTjXZab0n7gMn8KsiVF/eaRMcndaS0bE5UdnTS3OtWiIlu7Y//tfZL5yW4MhPVCSd5fhsku+7
 rzRU2+JKN56aE6Eo9+lM/4tZgdLPuM6+y89TKCwxLG7tJGKEezUP1/eG41++P/5MJ5oQ2MNB6xR
 8IsPOsWYBlAEbfX7OLeio2Ys1YeWWoY+4DUfUs9k5vyTXJnbFM6+XlAH5eOVDtxlKS+R97a7o1i
 OHdDrkeFec3Rixd/rbf8p6gAYWeEc796pPEPF4gdbMd6N65QSUuhrOAf6klLOFLTyTfYT6P0lAz
 JPaM+Xo8FYESlKkuNOgNXwSX03TkC1s52FWeCNetgYWc=
X-Received: by 2002:a05:6000:2209:b0:3e5:31d3:e330 with SMTP id
 ffacd0b85a97d-3e641a62252mr6405793f8f.25.1757328669287; 
 Mon, 08 Sep 2025 03:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8quSI9tT2jAQfhJSz16uEwObN/vtcxAqg1zia9QFxF4iD6uB84FlS5nSyxran1AAerVCulg==
X-Received: by 2002:a05:6000:2209:b0:3e5:31d3:e330 with SMTP id
 ffacd0b85a97d-3e641a62252mr6405764f8f.25.1757328668751; 
 Mon, 08 Sep 2025 03:51:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd3aadbcesm164897645e9.17.2025.09.08.03.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:51:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 26/33] rust/hpet: drop now unneeded qemu_api dep
Date: Mon,  8 Sep 2025 12:49:58 +0200
Message-ID: <20250908105005.2119297-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-18-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                | 1 -
 rust/hw/timer/hpet/Cargo.toml  | 1 -
 rust/hw/timer/hpet/meson.build | 1 -
 3 files changed, 3 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 021ce6dd48c..c407029afed 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -93,7 +93,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_api",
  "qemu_macros",
  "qom",
  "system",
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 68e8187bb82..08bf97af553 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -17,7 +17,6 @@ migration = { path = "../../../migration" }
 bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
 system = { path = "../../../system" }
-qemu_api = { path = "../../../qemu-api" }
 qemu_macros = { path = "../../../qemu-macros" }
 hwcore = { path = "../../../hw/core" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 3b94d5ec0a7..8ab26630d95 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -5,7 +5,6 @@ _libhpet_rs = static_library(
   rust_abi: 'rust',
   dependencies: [
     common_rs,
-    qemu_api_rs,
     util_rs,
     migration_rs,
     bql_rs,
-- 
2.51.0


