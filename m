Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A62CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKqz-00051i-D4; Wed, 27 Aug 2025 14:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqd-0004nu-Nc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqV-0005m2-41
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+VhgY0cIUaYQiWgozPEinNSa9szANgEuQJdQ6/e0AM=;
 b=aKFCflw/P9jPuLpcQWNCdhqqJs62QuIC+Bd+j3V/7G1ZtxBYfuJfG/uVRH8b5YAbC03XCH
 OmcC4W46e3pnVz9lxD+U3vk3rGzdBhhOpr7OJO1niIjb1H1XgV3f9TMk31XRE/0F7p7NEv
 pNlRVQwrEFoYeogWwLN3LPnAX9ewcHc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-PWrnWhCqOl2yAOOhmzjDWQ-1; Wed, 27 Aug 2025 14:25:54 -0400
X-MC-Unique: PWrnWhCqOl2yAOOhmzjDWQ-1
X-Mimecast-MFC-AGG-ID: PWrnWhCqOl2yAOOhmzjDWQ_1756319153
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0cb0aaso560635e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319151; x=1756923951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+VhgY0cIUaYQiWgozPEinNSa9szANgEuQJdQ6/e0AM=;
 b=tTL8F5rYlDNY3bK4OM6odDBykJZ3xGZ2ZFaepI/yj8mHzJ+rLoLmaW8SDT+9ULUe/j
 n6AaGl0ERh3leDq6wfm0/ycQkNoBapybLAJz1Cacj02+agWtyYlttDtDS5ceH8XboSV4
 1uuHfKoi+aNzhXHQGpmV/tyiXg0X9jvnWesC6B1w2NyrAteRiFesYCtPkqG5BRIPM2H1
 rT/w71xI2GF+oczLnyidFE1NwU8pS0m9NKYZJzGQ2vdOrqffvlqytxBejoHOaamEHjKM
 myNPii3mwsH3Xgo8Rum7oCGbtmEum+Hj3sezkacTTB7Y7jwhR12QFUZIc5kSAfpvFBqM
 LN4A==
X-Gm-Message-State: AOJu0YxIHOv2zsWDU+0UzbZdZUInJZDmp3cLdwPSzHOAzSMKrMSwG25m
 i9lujsEnE7JpaY9WrZ4Co8V3zBtCe1KrXb/cZAcCUy3yr9UxlV0blQT1u1HqlVpVm7I24PNp3w6
 Xo88WbYhxHlSlwomDgvOO3oMyyqnncqRRxCoy/0VTPjdAT6IKii1YugxSxNzTONGkkT4EmRHOuY
 QdvWpzsrZkSm6UqwfKVHCYQAV/4BqoOScfHM4IpeFm
X-Gm-Gg: ASbGnctuvxJq+XdnOfxmpySABC334y0T5cdkIEYFT6hI9+30m//Y1P+KNg0+n50IOH4
 E6maFQ8NDKKIwjBAG/ZJDYyTKs4KkkXAUjTmdXls1l8FZHPGswYY8hUoW8TJkG5dnRvOXCi+rG1
 AmCQ0s8KYg+ZgUEo/ENrPacuX0kxw1VLMOioX5s9iDy09qArBdcM/L3P37jR9L3FZ5P5yNUGuuk
 ju/YybQZtryssYxnpRfAOuWgCbM/PDi+n9fZAfU6gcAH2VjltvFozH151m7cinujJhssvVAH4lA
 jzICeSeodsos8FeNnenA6hfRepgGiQ/mByXebopdcPltXLkK2qKnBbhG3RMXQZgicHOK3OA7C3/
 ry+2u579YL/BnCr/wqbqfjA7oXUX4Uzqlv9XCVrMA+dk=
X-Received: by 2002:a05:6000:1446:b0:3c7:f0fb:82e with SMTP id
 ffacd0b85a97d-3c7f0fb0b0cmr11459495f8f.56.1756319151018; 
 Wed, 27 Aug 2025 11:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwLr1GNeDUcspXXlHF9KXJ+G+4+JN7+a5BDUyBZwCJBXhtowGtaRdn9EfPtFiKi8d5+IJsrQ==
X-Received: by 2002:a05:6000:1446:b0:3c7:f0fb:82e with SMTP id
 ffacd0b85a97d-3c7f0fb0b0cmr11459476f8f.56.1756319150441; 
 Wed, 27 Aug 2025 11:25:50 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm39388635e9.13.2025.08.27.11.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:25:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 03/14] scripts/minikconf.py: s/Error/KconfigParserError
Date: Wed, 27 Aug 2025 20:25:21 +0200
Message-ID: <20250827182533.854476-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Error is not defined in this script, raise KconfigParserError instead.

Fixes: 82f5181777ebe04b550fd94a1d04c49dd3f012dc ("kconfig: introduce kconfig files")
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250820-scripts-minikconf-fixes-v1-2-252041a9125e@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 2a4694fb6a3..4de5aeed11a 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -363,7 +363,9 @@ def parse_file(self, fp):
 
     def do_assignment(self, var, val):
         if not var.startswith("CONFIG_"):
-            raise Error('assigned variable should start with CONFIG_')
+            raise KconfigParserError(
+                self, "assigned variable should start with CONFIG_"
+            )
         var = self.data.do_var(var[7:])
         self.data.do_assignment(var, val)
 
-- 
2.51.0


