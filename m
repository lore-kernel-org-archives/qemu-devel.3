Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A220DC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyLz-0000oH-MF; Fri, 31 May 2024 05:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLx-0000mw-Ul
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLt-0006VJ-Be
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+U+M0KDU9P1p+mp5Onz5lZ6sHba7FesDa33BFDN+1Jo=;
 b=UQhDNsMJT7kUyAZR54c/2FENbv6s/UvhggattX6wDKHGqChlC+Zl5Hv5YQs7fFtpTZPwIi
 V/RPvFsGaaP1h08w1LpP+LhQAaKUPSEfHBiZDYerpFc5Fir82j2pkIhNEkzKHEgpwsVMNJ
 Fz1RYY548iK0dhIgN5AiF414HcGyCi0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-Ruc4SFuWOmSrwk17V4Ytew-1; Fri, 31 May 2024 05:15:06 -0400
X-MC-Unique: Ruc4SFuWOmSrwk17V4Ytew-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-579e6a3edeeso810773a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146905; x=1717751705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+U+M0KDU9P1p+mp5Onz5lZ6sHba7FesDa33BFDN+1Jo=;
 b=ZTohtLM7OcuBnQi3R/n7h1i8mdwAaT4oJUpdStU0anYe3HfC/DdCSYnnlWfORadJ7k
 Ht58QgHZOt1bW3v5K8jTvarAm1GcHROBN0wBNxLLuRWVbO/XOKmy7cuNYuwKxhywCVjb
 EIr6IkLHPSfLiFQfCzBy3Hc4hfrxe0hCDvzGr8ktqaw2U4xzHnOhFl8ujQNRWreYPWYA
 Nk688IcolrFb85HWu26yJyfaRXHKqt8d9DDEr1yfHJnDngZQnmHErKLxSyRrRqfRVL8P
 Wtzzr9o0GsYbJwAwYjl8DoNXSAwlHcX2LsiRunmYE5M2SpJaDkTf6aF8KeC6g7on1vam
 yGpg==
X-Gm-Message-State: AOJu0YwCFmT9hxnijs98agX0xwF9lh1IOefD4H+bvf7MGAwdpofOXCx4
 bYshZ8zLOmTa2Y/eH5/zHIAPp6mBuxfS8scfpEZcDSQcMCvQsgTsdgHHkbREzeXAdnb0K9nnX/R
 h1r90nL22PJRZ+qgFZdVnWVPufRwFl51Q3oKwBF+OK47FXw5JLGXtndtmldru6OqtIB5sFjuP9o
 h/2lsoAxrgFK/2v4bDh4G6r9TiTcC5pr3wfg0v
X-Received: by 2002:a50:d596:0:b0:574:eb69:fadf with SMTP id
 4fb4d7f45d1cf-57a3656455fmr818282a12.36.1717146905134; 
 Fri, 31 May 2024 02:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEm1OsF/9rnnYAYYHeV1/tTodgTufJ7dm8/QfqTnE+fYChYNF9ytShMHMQnos3aV60pXekjQ==
X-Received: by 2002:a50:d596:0:b0:574:eb69:fadf with SMTP id
 4fb4d7f45d1cf-57a3656455fmr818263a12.36.1717146904570; 
 Fri, 31 May 2024 02:15:04 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c6d4absm768793a12.72.2024.05.31.02.15.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 02:15:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] meson: assume x86-64-v2 baseline ISA
Date: Fri, 31 May 2024 11:14:53 +0200
Message-ID: <20240531091457.42200-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

x86-64-v2 processors were released in 2008, assume that we have one.
Unfortunately there is no GCC flag to enable all the features
without disabling what came after; so enable them one by one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 63866071445..19d1fc1f33b 100644
--- a/meson.build
+++ b/meson.build
@@ -336,9 +336,13 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
-# ??? Only extremely old AMD cpus do not have cmpxchg16b.
-# If we truly care, we should simply detect this case at
-# runtime and generate the fallback to serial emulation.
+# Assume x86-64-v2 (minus CMPXCHG16B for 32-bit code)
+if host_arch == 'i386'
+  qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
+endif
+if host_arch in ['i386', 'x86_64']
+  qemu_common_flags = ['-mpopcnt', '-msse4.2'] + qemu_common_flags
+endif
 if host_arch == 'x86_64'
   qemu_common_flags = ['-mcx16'] + qemu_common_flags
 endif
-- 
2.45.1


