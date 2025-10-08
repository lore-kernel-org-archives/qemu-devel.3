Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BACCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NmU-0004r0-4v; Wed, 08 Oct 2025 02:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmM-0004oh-Ot
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmG-0004R0-4V
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ox+2Cd1Vco9Rw3gEfv+kUxlheT1q5JV06Fe+h/pCQD0=;
 b=gHPy+gX6KDK5Fo9bFPEftOH93VnS0siGoe+PieNt6PkbV8TaK4g3Wdy9BtCTtJqquuPAki
 q5V9Ja+kOOrs8qMxcXcUXqUaJqIRwMPs8ojEFCFMzbID7vZOywsE67N7pgM6HZ3eW7qVfh
 uWvEnLzbkeQAO2CczAUtucscOD39Qbo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-jae1rkXnOueNrgR1GF1PAA-1; Wed, 08 Oct 2025 02:35:53 -0400
X-MC-Unique: jae1rkXnOueNrgR1GF1PAA-1
X-Mimecast-MFC-AGG-ID: jae1rkXnOueNrgR1GF1PAA_1759905352
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-632c9a9ceb1so7591265a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759905350; x=1760510150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ox+2Cd1Vco9Rw3gEfv+kUxlheT1q5JV06Fe+h/pCQD0=;
 b=GIshx/PQ8/PRuHYsijVyQ8+rxJeIEB2rJFVJLBE7yh+gFUEx8xj16K9iDhbsfRalSq
 sm+VcJHneSaKAXAO/NcNHGm+Nu4KlQ1KibWfMuJn0W8iGbtboPUTqp1QwCGQ4oyojT7y
 6Bsco98dcgo52J8hJCWgKUsKVJnv5LQ4mDAdlGRE3BxPrHzbwtLYj5w8RbW14RSaE4Xp
 Wl8oKJiwB1NbC3MzTKAs7P68utw4tsFI97aAc9jF9ud8itwHsCTqQosk6X4LYyy2irkc
 dYGVQFl/v0Q1YqFckYyKr+jlzp1eGPQXfLwp3KbcFan4izw1sh+XisUapuUOfwYNwLFa
 jR9w==
X-Gm-Message-State: AOJu0Yy/X4TPOfd+Blv7r8gsy7KZf6VFKY6D9Ey/YHET8veldpWsSRvT
 xnhVwTl8H+KHgIOryp2noeMlNxC74zW/8kQ6PzWRWnwd8dJ82wiMWeLfLRQlrYbtaAsQT0ineVf
 QJC0FNSKH4EeFTJItxtxohJnF5G/3h1aFmJXUBhU80YBfwntw/LsfsBX67cX3jc8pVQ1RT0Gh/L
 FzJZsa/P15GkZXCwgcs63grtXsUUg9h6yjPJORvZhc
X-Gm-Gg: ASbGncuvm1ZsVROswSrg/lm/Ds896uaQjK6cTOkqdoxXhJh1MMH6x7nTHFbZmQjYcfa
 q07gaJc4f6T89UotDDF627a8JeraU1S6oVWPowSm/0xWqcAcT3JhqzLvpVJ2gd8qetabRS7ZeOw
 Hs9ZgWMa/ibmpRHrp7PCyUAfJxMUWrbqJH23tXaori+ptcGqnx0pjNVwnz/x+gX2zFSR8r2Xdi3
 EcUxIRrzNDPytTwOmn+/0sePi21ipT2h1zVIq/Bw/WwXPlK0GetOfTdaDwQvy22UgcvXaU8IS71
 fE3a5tagQ1XK1TvQgn1yhSDF8nekH5jKHHG7GuLNlmjYtyjR9dIjnL1STmsvBNVXd+RiBESanrV
 hv2ETbqNx7+ooKrTT2bOCi81quYTVlCQdzQPx91o/ThXxezOl
X-Received: by 2002:a05:6402:4402:b0:639:e580:6335 with SMTP id
 4fb4d7f45d1cf-639e58068ccmr88264a12.2.1759905350167; 
 Tue, 07 Oct 2025 23:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGva4RXvbnYcSmDoGbCT10/vZQbNHQyR10iZ/7JgvVrxWBcD2tqmbCyzOKmGCZ4RJ4L+K7WSQ==
X-Received: by 2002:a05:6402:4402:b0:639:e580:6335 with SMTP id
 4fb4d7f45d1cf-639e58068ccmr88237a12.2.1759905349735; 
 Tue, 07 Oct 2025 23:35:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6378810112bsm13910586a12.26.2025.10.07.23.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 23:35:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 1/6] tracetool: rename variable with conflicting types
Date: Wed,  8 Oct 2025 08:35:40 +0200
Message-ID: <20251008063546.376603-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"backend" is used as both a string and a backend.Wrapper.  In preparation
for adding type annotations, use different names.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 74062d21a7c..85527c08c98 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -566,9 +566,9 @@ def generate(events, group, format, backends,
 
     if len(backends) == 0:
         raise TracetoolError("no backends specified")
-    for backend in backends:
-        if not tracetool.backend.exists(backend):
-            raise TracetoolError("unknown backend: %s" % backend)
+    for backend_name in backends:
+        if not tracetool.backend.exists(backend_name):
+            raise TracetoolError("unknown backend: %s" % backend_name)
     backend = tracetool.backend.Wrapper(backends, format)
 
     import tracetool.backend.dtrace
-- 
2.51.0


