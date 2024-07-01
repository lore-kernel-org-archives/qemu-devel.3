Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F78C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIVO-0004CW-54; Mon, 01 Jul 2024 10:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVM-00045Z-KK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVK-0005pK-3H
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=luGqbPijLsIyeJwfJwi+l/hOQ+ghfxnFRgaepulV208=;
 b=T/zdvewbLcrr/DIWvVf/LHCHCpAqA2MmkixWV9jajdP6fhQLc/jocRIbXeALD5DTP2zwtr
 7rDqNr43bEIeqGb9AjhDDumiix0gEJzGMFk4uq/oMWkcw2w5/7LPyEkQeV0kH0BSzttmof
 fi07csMxIOjia1qn8YWUupxWvbZX31w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-yIct2ODCNCuRp60fWHdyGQ-1; Mon, 01 Jul 2024 10:59:40 -0400
X-MC-Unique: yIct2ODCNCuRp60fWHdyGQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36536118656so1875030f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845977; x=1720450777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luGqbPijLsIyeJwfJwi+l/hOQ+ghfxnFRgaepulV208=;
 b=mbNXi+npS+6TI/gIEyjobwbIkshPgerssM3ZYpL8SGaJhk498TL2Eg3uTHtSghkfBk
 fMuhtphYX9V/n0XAfNDFIR1p78H50R2YjXpYpDbJ/i4qJ6IXj1qX67zzuOSdCRx3102V
 YT+XSmsBabFV3JkI0fbDyjV0ljJ/pXpXtcTy10P6p5tRGLOI7yWxNaU5PbsXUXOwG9JK
 TN5hFaoi9k/06Nc77A58X0AcyhX3XOG9P/FXgB3ge40pRzaaF75vRCHKqpyhJAUx+UhJ
 /rAKQeJcoIdnRu97nvzHJFRpNj0o5HoDog2aP6FvlnGYuIOpHd91imeJ9cFhs3H6vV5W
 3/Aw==
X-Gm-Message-State: AOJu0YzmrRuVRJIwyagW27jvwq0fDdLwun7lIl44jWenMXPgHwfsCYpb
 BXeh88eAfcoVhilE6ZuD/VHQa9RAzE3HtIijU/eWnPkoLI2Yr6EjZCfRZQUI13xo/oxZ4O7J+a6
 9GNkDycpwlMo7E4v1B9bYIyYr0zQ1az9UK3C7MgGxL6S/L0YL8v/SxjVaBM0ZtUauCnCZn5WZeM
 dTzf5t/01jGDVq5zapRuc+DTt5HjJyVhSZiNOH
X-Received: by 2002:a5d:6205:0:b0:367:4dc9:efcb with SMTP id
 ffacd0b85a97d-367757305c6mr4185680f8f.70.1719845977783; 
 Mon, 01 Jul 2024 07:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYpktNCTaKAuU/apTVDe8ZFC76gPb3FORDsTr4ThlRulNc0TDB9C7Ge/UmV5o7AbbXsyj7vA==
X-Received: by 2002:a5d:6205:0:b0:367:4dc9:efcb with SMTP id
 ffacd0b85a97d-367757305c6mr4185660f8f.70.1719845977449; 
 Mon, 01 Jul 2024 07:59:37 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c1018sm155820705e9.40.2024.07.01.07.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 14/14] rust: use version of toml_edit that does not require
 new Rust
Date: Mon,  1 Jul 2024 16:58:46 +0200
Message-ID: <20240701145853.1394967-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

toml_edit is quite aggressive in bumping the minimum required
version of Rust.  Force usage of an old version that runs
with 1.63.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/Cargo.toml |  3 +++
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/qemu/Cargo.toml b/qemu/Cargo.toml
index 93808a5..3ce5dba 100644
--- a/qemu/Cargo.toml
+++ b/qemu/Cargo.toml
@@ -15,3 +15,6 @@ matches = ">=0"
 
 [build-dependencies]
 version_check = { version = "~0.9" }
+
+# pick older version in order to support Rust 1.63
+toml_edit = { version = "~0.14" }
-- 
2.45.2


