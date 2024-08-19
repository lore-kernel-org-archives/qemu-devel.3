Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F742C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg3ux-0004Sw-KX; Mon, 19 Aug 2024 11:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bleal@redhat.com>) id 1sg3uZ-0004Ri-9N
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bleal@redhat.com>) id 1sg3uR-0007C9-Di
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724079781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gHmGo5d4f2Ue8FO+IDuPyI8nkp1T1WSe/NNoH/BHkw8=;
 b=F0A2Ij6kZDXE84yiuP/djwqCKqb0n1nRk1QTvxhdo+ZiOKRTOOIltIp+tl3nK64+VJhSFi
 9xX0EifE4tZ+kRHiQVp91o2qjD5Q0D1TAwx2LT3PTsMr43LlMB+dMp+gpCDPjzhVO9mT4l
 K8kKSGmR+Xme+W9pzpZwWuBPIDTQhCs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-CzGTcdgIMzW-ms2T9gkWlA-1; Mon, 19 Aug 2024 11:01:39 -0400
X-MC-Unique: CzGTcdgIMzW-ms2T9gkWlA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a1dab8a2eeso520120785a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 08:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079698; x=1724684498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHmGo5d4f2Ue8FO+IDuPyI8nkp1T1WSe/NNoH/BHkw8=;
 b=Ldz4gayb7OdkeNGWtXkkE7zWcsr/uL+FbGzls45X36WvVI2YGmJWyDjPm6tipVwPBf
 nyBIhheGGUHw2xFg3pyorWdWK1r/lyMqaFkgTlY9mkrj67n1cmjwJCyJpW4HEDBDMWS3
 mkux/d0TG+iZT2ml4ELXGqFBst0zSmZC7abc6Dwzp/4CVBJc3HXLkLi1tHVlNCjByvmh
 nPmbOXk9+OrLuVK7hn5Vz8LbBwKeOkhpI8FZYVfRKpjqMIvnFKWdO1shgx4aQ+ag53mB
 gaLsoiuYtdmQFZyJZMqBt1S22T7bTaORaTx6voop614NileNraZ2ca2uN5/8PDKTsFt5
 4DYw==
X-Gm-Message-State: AOJu0Yyg/bkwK8DoP6dqCm+rYK9ljaCGiCLCtgJeoEWDTqw+T1VqaxFL
 J5pCDbLUum/NPjLeICQnU9JzTuiduu2DOdOaWFoN0EgV45cCoO7jUsdFUyGCXFkp5N9vr/4lmR9
 h8MpbdPn6DLn7aVDWKUyoEhOgcHhzTok0gUdeF54hNw8JWgZITdxYAxG9nndJmLkzxJF/otDU+Y
 aL924DwGA3QieifkVdv9/ZqBa7Rl71Yzbf
X-Received: by 2002:a05:6214:5f04:b0:6bd:6f66:8b5b with SMTP id
 6a1803df08f44-6bf7ce5a750mr164283896d6.36.1724079697500; 
 Mon, 19 Aug 2024 08:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPIm0aGTTeCesTyCKr8x9bHWXhg9nNlly88oJFRPrUv+x2t+1QfhWMP5nxVK6k8Kbh65Ft+w==
X-Received: by 2002:a05:6214:5f04:b0:6bd:6f66:8b5b with SMTP id
 6a1803df08f44-6bf7ce5a750mr164282606d6.36.1724079696452; 
 Mon, 19 Aug 2024 08:01:36 -0700 (PDT)
Received: from fedora.redhat.com ([142.181.120.78])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6feed2a9sm43105556d6.111.2024.08.19.08.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:01:35 -0700 (PDT)
From: Beraldo Leal <bleal@redhat.com>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>
Subject: [PATCH] MAINTAINERS: Remove myself as reviewer
Date: Mon, 19 Aug 2024 11:00:35 -0400
Message-Id: <20240819150035.2180786-1-bleal@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=bleal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Finally taking this off my to-do list. It’s been a privilege to be part
of this project, but I am no longer actively involved in reviewing
Python code here, so I believe it's best to update the list to reflect
the current maintainers.

Please, feel free to reach out if any questions arise.

Signed-off-by: Beraldo Leal <bleal@redhat.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6..806cf0884d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3174,7 +3174,6 @@ F: qapi/cryptodev.json
 Python library
 M: John Snow <jsnow@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
-R: Beraldo Leal <bleal@redhat.com>
 S: Maintained
 F: python/
 T: git https://gitlab.com/jsnow/qemu.git python
@@ -4121,7 +4120,6 @@ M: Alex Bennée <alex.bennee@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
-R: Beraldo Leal <bleal@redhat.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4162,7 +4160,6 @@ W: https://trello.com/b/6Qi1pxVn/avocado-qemu
 R: Cleber Rosa <crosa@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
-R: Beraldo Leal <bleal@redhat.com>
 S: Odd Fixes
 F: tests/avocado/
 
-- 
2.40.0


