Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A7EC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekU-00075j-1H; Thu, 27 Feb 2025 09:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekP-00073F-IS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekN-0003jD-Ee
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIrGFvl8XMnSDNAnwzqUPVz8YQqpnZQKu+akhrL+9gc=;
 b=g+57ciItA7Lf+3gucuPYLnUT95VaiV81NtrVO/5oXtMOKs2/vIJUj7cJZd1ZwKcXk7mkwv
 AVuSVpDt3+yv+tar3oguZLwbwhEmPrrCfCkLIjM9rGjdpJPlD92nlhICpsradDSmMu5n9T
 F+TJPlqBmyWvGS7Sw8VCenQcAv1fXhw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-AI6gzLkaP8yPBGnA7efScg-1; Thu, 27 Feb 2025 09:20:16 -0500
X-MC-Unique: AI6gzLkaP8yPBGnA7efScg-1
X-Mimecast-MFC-AGG-ID: AI6gzLkaP8yPBGnA7efScg_1740666015
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abbe5ac36a9so116393866b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666015; x=1741270815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIrGFvl8XMnSDNAnwzqUPVz8YQqpnZQKu+akhrL+9gc=;
 b=PMOHcx6Hqz8/MRgmDmB56elnpMBjtxlehOk/NdB2E6ZwaQyb3O+327AlJ8DCwoWZ2n
 LTlP14h4c0QPY9Dm1a8ekTCH0+aANfQKJI3uFPgv+xOUIMB7LYXemo20G9S4pfdBdLSW
 a1zhY9+oAhbatMrvT43XYaAGk7g3PhMySWxeT0OzaKKTvkuBbuNgeBG8rHfYa1WPh3+P
 zQQsyg+8owOLAC21rHNuO9GL/9CmqkO62Utpn81Oyhju2g/kjHa4vJkilHxn5zb/6/yu
 7ZOHPlBm14iroRO+TVU7dqlS/Fcgz1JrnNKsYIgnlDbck1BbbfbOPRgki56ZULo2cnf0
 Hpwg==
X-Gm-Message-State: AOJu0YwxdaMmJRaabDPl/v5CibjgnuD2dBnvihtJSqKS73z3Ly8oZe7v
 sWxKq1OTfy37OZzb8mAOZf5Jl0zqnu1Z7VVcplpS72NRjhmkoOAI+h7XZN0wf42udywEAILo1gf
 zTl/3SmsUOY+2eRtr4yJ/RISmARCNYSefFm0zwZM4kz83K2p8M+4JSDBYx4QA53admSG1uUWieJ
 CwkBF01Ura77d7P11sW4V/Fj0XkY0b+dT0pFP+doY=
X-Gm-Gg: ASbGnctZq5cEmLWsghkYvdsRZ6iY/G7sZNBU4gYWjtme3lNy0+6heD4iziHlszQaDub
 MzXu3KtDC5wbETC1FXNB6M18eF3cFMtccIU4hYf/Amh1/whZikuwtiajoF6OT1WAIMl0IXiRJQf
 ZKNtQtmZ2A4lrpd3y5Y8reGwjD9zN1XYllK0VZShgsDCFgYsiE2WvNulWkdISVmQE1J5qLeOZkW
 JygN2rKbvbWGGHdejucyAQo1WBmeEDJ+POFZ371QQ5vO1iZI8z8aMjfbLUOGuO2YTdcEBJuoRqG
 b0OO2KzaNsVKLhpehat+
X-Received: by 2002:a17:906:309a:b0:ab7:4641:a72d with SMTP id
 a640c23a62f3a-abc0de4fb0cmr2488339266b.51.1740666014727; 
 Thu, 27 Feb 2025 06:20:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGowif1EE8SoFEH8XN4ShMl+uizlle4Eeii03++zVweXfeDYmMob3hKp9e5Ee+vgo0OsUQAmg==
X-Received: by 2002:a17:906:309a:b0:ab7:4641:a72d with SMTP id
 a640c23a62f3a-abc0de4fb0cmr2488334866b.51.1740666014241; 
 Thu, 27 Feb 2025 06:20:14 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c759385sm128256566b.150.2025.02.27.06.20.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/34] docs: rust: update description of crates
Date: Thu, 27 Feb 2025 15:19:27 +0100
Message-ID: <20250227141952.811410-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index d68701c9c87..5d8aa3a45bc 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -139,16 +139,22 @@ anymore.
 Writing Rust code in QEMU
 -------------------------
 
-Right now QEMU includes three crates:
+QEMU includes four crates:
 
 * ``qemu_api`` for bindings to C code and useful functionality
 
 * ``qemu_api_macros`` defines several procedural macros that are useful when
   writing C code
 
-* ``pl011`` (under ``rust/hw/char/pl011``) is the sample device that is being
-  used to further develop ``qemu_api`` and ``qemu_api_macros``.  It is a functional
-  replacement for the ``hw/char/pl011.c`` file.
+* ``pl011`` (under ``rust/hw/char/pl011``) and ``hpet`` (under ``rust/hw/timer/hpet``)
+  are sample devices that demonstrate ``qemu_api`` and ``qemu_api_macros``, and are
+  used to further develop them.  These two crates are functional\ [#issues]_ replacements
+  for the ``hw/char/pl011.c`` and ``hw/timer/hpet.c`` files.
+
+.. [#issues] The ``pl011`` crate is synchronized with ``hw/char/pl011.c``
+   as of commit 02b1f7f61928.  The ``hpet`` crate is synchronized as of
+   commit f32352ff9e.  Both are lacking tracing functionality; ``hpet``
+   is also lacking support for migration.
 
 This section explains how to work with them.
 
-- 
2.48.1


