Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4E5CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ROn-0001xA-Az; Thu, 16 Oct 2025 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9ROk-0001lV-5t
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9ROc-0002jZ-Mc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760634247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IXzjVioYkEJKhXxl8PXQivoYqlUEZxMJyeof8RR9W9M=;
 b=MudY6+5va7st0v0mtU0Rr0z3satLYj0Rav9DkQiw2VTPaPWxk6xbFgwvJk11CmKpbDu51u
 7Q2odLkZWkIJRfICfMaQnRcFAjQ3Ri8zAG7H17zD4x86+J683z33O/EP9w6SAfX5q3InHi
 zx49fgWzS7LlLstOdwRpSnE27Z16U94=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-5jMV2kbmMc68li7IAR_k_g-1; Thu, 16 Oct 2025 13:04:00 -0400
X-MC-Unique: 5jMV2kbmMc68li7IAR_k_g-1
X-Mimecast-MFC-AGG-ID: 5jMV2kbmMc68li7IAR_k_g_1760634239
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-471148ad64aso4498575e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634239; x=1761239039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXzjVioYkEJKhXxl8PXQivoYqlUEZxMJyeof8RR9W9M=;
 b=oToG1xrWQUtCByiOJXDCIOny3wnqTpA/80xE7Nh60ECqHsvgPgac7IVlgTo41BO6P9
 Y8l1MiPKwe2MSAsbVXttEI2WjY09PmVOfhhEGQq97tb7K9RtClVEXu6FcDZ8VgzPxGop
 /v/g+1RzWu39xk2rSD0+SwnZXbvbKpb0jOU+ZJMyblqLipSx3KfzNrW+U1/dGwrmxQVi
 +dVHpN1AYNSEAbp44INbwAkdOQtyf9dkLjwrS2J3LKKPQ2saueYdTj5TM/ZxLWa6pSem
 ePUs8F5lxWXE4mVrEPPLA7eZ5OlXMsXqoOLhmme7L4SaoqgPwQ7as0qVMu3b+YhWO9HU
 xtng==
X-Gm-Message-State: AOJu0YzbAarUW3z/lZgSzezV4i7kcD4P8EiHFpYnaV2vB7p1gMy3SQ8H
 JV6ja9LlmbPf437bQ74VeMWq78ysA9yRpa4/Q1qmWjU8gimOJ+oU5M+GUTWESnhZz+XZW3PMFGN
 xdqnrkPspQ899tf3q74PeXPgNt1sPSLdBxrqxnUwmcqdm+KGotxNUGszIssLHA98ceZPg7bVBuw
 FW5RpZWdq59le0ueCpUTlBXoZMvoaDkV9gUl/oH0Nt
X-Gm-Gg: ASbGncutI4Tliq+OAP2k+RqSaLl83NJn/8CoIBhij/+kPwb33ceLwbT82TDX6Oum+1n
 5B6UlntzgJwAJLmx1iDmjfaxPpXWg7BTKR1ykAtWcQCDSDb2OC7qKy6OHKYsRSVYnPf4X+I/t34
 iGxI4q1Jb9KLfPs5t0wAjB3LGbR5wSpQyRWhoXZKXaO6W+UV2dL5t6giS/hpVDfV+4UpqPs58XB
 lY8YCzOAG/frpUbamFYomBDbz69MHAsvscTaLhFEnWr4PnfLBw71YcS02shlZu718SWJMHUdXM6
 qXv/tm0mWnUsVBBmXkOjVvdnB7h9F7eHOLzAcEV7MVgjhQnhL9rREZG2Erk2y2fEJEmTHY2+/Ua
 p/9i9FQmES/j4TwPzSIYfblldtT+fgfE+xiwYfWx6RgZauHhlFykfxqXeszSi4DAR1KkJIqAd/p
 w=
X-Received: by 2002:a05:600c:548a:b0:46f:b42e:edce with SMTP id
 5b1f17b1804b1-47117925db7mr5414815e9.39.1760634238859; 
 Thu, 16 Oct 2025 10:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHumFk5hIVteueIxKJBVyn6ePG1VwCj3OHskcJQXnUAqO3XCDciOsa4anlnl5b2xycSecA9uw==
X-Received: by 2002:a05:600c:548a:b0:46f:b42e:edce with SMTP id
 5b1f17b1804b1-47117925db7mr5414565e9.39.1760634238389; 
 Thu, 16 Oct 2025 10:03:58 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5d48sm37720675e9.9.2025.10.16.10.03.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 10:03:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: do not descend into *-user if no user-mode emulators
 built
Date: Thu, 16 Oct 2025 19:03:57 +0200
Message-ID: <20251016170357.1362790-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

User-mode emulators cannot be built for unsupported host architectures;
avoid incorrectly descending into common-user/unknown.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index afaefa01722..3facde5b68f 100644
--- a/meson.build
+++ b/meson.build
@@ -3935,9 +3935,11 @@ endif
 
 common_user_inc = []
 
-subdir('common-user')
-subdir('bsd-user')
-subdir('linux-user')
+if have_user
+  subdir('common-user')
+  subdir('bsd-user')
+  subdir('linux-user')
+endif
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
-- 
2.51.0


