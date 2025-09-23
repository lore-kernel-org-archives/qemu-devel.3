Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94A7CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xha-0007y0-4Z; Tue, 23 Sep 2025 03:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xhW-0007xR-1N
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xhM-0004CZ-5W
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758613464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AqbIlwL+jjuAsyw20UbjBICVHOr8moxHVavCdA2Aoqg=;
 b=PdYpRZztmFbJZYqnZ16qeEl9Ie5HPUGhvNUG47laAMOgvNBD1DcJR9O6cIE+52qc1MOqZj
 eYY4Ey8j7NxPom3nzzqkMG/ThQyNAajzSupPlqUDsaMRMeOwo15pA4trFIQWMoYfMmpYIw
 sLPNeW2KSh1DT7vtKUp11VEloASCNnU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-bMvurgtMOVOqCASNMfxrYA-1; Tue, 23 Sep 2025 03:44:22 -0400
X-MC-Unique: bMvurgtMOVOqCASNMfxrYA-1
X-Mimecast-MFC-AGG-ID: bMvurgtMOVOqCASNMfxrYA_1758613461
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6305c385adbso4118042a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758613460; x=1759218260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AqbIlwL+jjuAsyw20UbjBICVHOr8moxHVavCdA2Aoqg=;
 b=deblERbs61wLWxw2GWo1QUHtTuee94JvOgpI8e/sjQ72f1FDnr9GeEVfZg4Up5nuD/
 4DitPW+upF7iEqLsZlLEuFHrCsQ9fUJEgYpCr5aXOF8axkScL/BxOGQqeihDFd3eVCVW
 HcwxFq0iR2ltaJE+yqCsRCN141KfMq/u6Owdrc3xR5eU5l7r7Srxew63Vpac18EtLE5j
 KqyDhDL8Ez9keUilXHogDb9GA+xDX0ZQaQ46PlxhHQoY2N39wuOUT+xT8CpUq6EUCj24
 hm9cdegUlHkMutbkTgd1oBusGzoqt+tXgpMpOYaz3IldBD+7FKfsQXoZgBjkHaDmwTCP
 +UlQ==
X-Gm-Message-State: AOJu0YykHQM2FP9tSuj750X9zVo9xWsNEr0koy1nzQk02tvL7eGJOr0W
 /C7Q73I/UJTL/kPiO/+l/lIdGB0erLtjaiokiqjrwUrJhbjZY2e5v6fC4RVauLmQyVLNj1HzSbA
 VgSPAI7KhUX99FOnPntKSTAlb08dx+W1XZfAJLJZtVhNmn7YHUZRZtykn8CrmAcfp0YQtI0tPzq
 m8G3mZrZqCRgoKEbUTW3xNj90X8IyGFV5rmlS6oFa9
X-Gm-Gg: ASbGncsgBOrBC5WYt7jMtOoSWhcVeMqpz6ZUSk1n5nOrIaxAe/qcnQKl07W7VgZTDZ/
 bJCfuajWaKS0Yuph4Ys/jlvnudvVo7Jxt7qDGHWRhqC3lERwAoUz/akcaR97lFDpy+xz8PHgH3K
 NXqUkGhqiG2+ymgB/jNmKprkUDqQIre/GV0RB8wiK3FMlJO+6FMXeWmKTJxQ77DkWHbjAjVQYjM
 r9EjITQjY/64iFTLsaAscFG7HyX1N1oUHxYMhmrVCkvYMlPVBS7EqY8vkqe89s5dvP2P2d+3kYI
 6uKo4Vj8JQQC7LnsDxqof9rbXiInOuzGbOklFR7Mvuo4vZ5YPg9rCXZwnXjkrYnmjmnM3Q5mlhZ
 QUa/R3FCgMaijDrAEZ5B05eIF2Uini7PZs3EMDUg5HvFYIQ==
X-Received: by 2002:a17:907:724a:b0:afe:9f26:5819 with SMTP id
 a640c23a62f3a-b3027d3faa6mr155913366b.28.1758613460277; 
 Tue, 23 Sep 2025 00:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLRcx33rcehhN+M0wb6ulkDgS7+hwKevONaYSBSGlfsRsMzRGy8BwU+xa3U/vak+LbraPZ/A==
X-Received: by 2002:a17:907:724a:b0:afe:9f26:5819 with SMTP id
 a640c23a62f3a-b3027d3faa6mr155910366b.28.1758613459853; 
 Tue, 23 Sep 2025 00:44:19 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2a88413acbsm564478266b.24.2025.09.23.00.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 00:44:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	stefanha@redhat.com,
	mads@ynddal.dk
Subject: [PATCH v2] tracing: deprecate "ust" tracing backend
Date: Tue, 23 Sep 2025 09:44:18 +0200
Message-ID: <20250923074418.87716-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
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

The "ust" backend is complex (tracetool contains two output formats just
for that backend).  It is not clear if if it has any users, and LTTng
anyway can use the uprobe tracepoints provided by the "dtrace" backend,
therefore deprecate "ust".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 meson.build               | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index aa300bbd507..57250f9d47f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -533,3 +533,12 @@ command documentation for details on the ``fdset`` usage.
 
 The ``zero-blocks`` capability was part of the block migration which
 doesn't exist anymore since it was removed in QEMU v9.1.
+
+Host features
+-------------
+
+``ust`` tracing backend
+-----------------------
+
+LTTng can use uprobe tracepoints, therefore it is recommended to use
+the ``dtrace`` backend instead.
diff --git a/meson.build b/meson.build
index 72da97829ab..b5e2186b35e 100644
--- a/meson.build
+++ b/meson.build
@@ -5073,3 +5073,7 @@ if not actually_reloc and (host_os == 'windows' or get_option('relocatable'))
   message('QEMU will have to be installed under ' + get_option('prefix') + '.')
   message('Use --disable-relocatable to remove this warning.')
 endif
+
+if 'ust' in get_option('trace_backends')
+  warning('ust trace backend is deprecated, use dtrace backend for uprobe support')
+endif
-- 
2.51.0


