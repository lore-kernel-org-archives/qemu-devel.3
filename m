Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AC9C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFm-0004sG-CB; Tue, 06 May 2025 11:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFY-0004RM-DC
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFU-0002E0-Vu
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9XoMb5qN4Oa9TZ4oVvJWOLn4eFe7xMdd1uzmvhg4vM=;
 b=BISiJMBBV5qK9eXiTf8z1hynyqf/0Nz+WJZlLPrHEpXmhRZm/+j//KmqcWrIwXEz7bUvd5
 G5f2dRUrLSfPZG+d4ELfzaqwA2Bs3yJELeURmJrcmMQnJGM0CeevorkfBY8fxw0Q6+XMyt
 nyAjr9cBcLseTLrhYeIjSgXU4ICdjOI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-HZJOq-UBNseF7F3bRJRkUg-1; Tue, 06 May 2025 11:30:13 -0400
X-MC-Unique: HZJOq-UBNseF7F3bRJRkUg-1
X-Mimecast-MFC-AGG-ID: HZJOq-UBNseF7F3bRJRkUg_1746545412
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso1558298f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545411; x=1747150211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9XoMb5qN4Oa9TZ4oVvJWOLn4eFe7xMdd1uzmvhg4vM=;
 b=MpTcGEktYe6GMCzR9V8VXGuBDNa16s74BV/TBgCz8O2teFttlaQZmVwAGFURIcpLbW
 gGfx/IiglsCeWiLzb0DbSX0XJ0wyevbWdYZNYB/gPO7h06pyGE4ry1U+fpKkeRAPlf8l
 VXtM2P2W10l9Dr69mOoi+kiKh3cgfaKZYDuhwaGnCbWru/hRthbLtHFfNPg4JmIpeqo1
 nHeYlK0ADukyWrZFyDWHItg3HAs5Hi5YHDHjm74cau81BQIxPlbeem94rMhO+GbnSP79
 b7L/K3GObbiYMYxcF//z+z6+rSyiM+mp0ydx3GrBZqcqeET19ufcl9EPd390wKlrIYvT
 3wTA==
X-Gm-Message-State: AOJu0YwkywAiNlaBBopBsSHQDLg4L/uQC4tB5f/sOoypn9wvEHWv+HAy
 8aUMV7y7WKnFAm1pYdgDC2rlugvxBQyk2eSjNyxtQQw08QRaDKP4hWQBNRQxLytL0hsmzFAjSPZ
 pwH7V7A068h2EyMGzZ3YDnDDij2BqEbvgKdt48H4XCxCgc4+rfvLrWNWihnKztCWyGQc/NfIBxf
 BpWBMr/acNHvBfH95GrBG8yRR02bcxgQ0ok8I5
X-Gm-Gg: ASbGnct1I3WfGGjPKeSZUX9sJ8TGQ9WvUcazODb4scmBuXcLMChd/Hd5DP1a4SF4ycV
 mdcN1YG/tzfEkIrg6tMhU8JTUGWrBJoNzodaj3YPt25xwgroc8mM8AOxPsiOjC9kNv78yGJk824
 Onoj+kTlzKQ8rfsHrcEAdUT/6cA84hMznjXtubrQ/pJqE1kNjGLCQP4tzO9Z5zTVBdcefxj7ghK
 Avl1sZ3gRGDhMsQEChNnl7Etf0HqGyCYTC+iyZYWRAt/wG/MBrwIKpOHmxANKRmfMyC6tgWnWfO
 qHhwh0ZIBgIocBI=
X-Received: by 2002:a05:6000:2506:b0:3a0:b1de:1bc0 with SMTP id
 ffacd0b85a97d-3a0b1de1d73mr2195456f8f.13.1746545411648; 
 Tue, 06 May 2025 08:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGDPsArANAodhe+/MHjurDaI64+BlNn4NDYwtR+G8pq2Cgx8LNCNICPo95TF2D3feKueEoTg==
X-Received: by 2002:a05:6000:2506:b0:3a0:b1de:1bc0 with SMTP id
 ffacd0b85a97d-3a0b1de1d73mr2195435f8f.13.1746545411224; 
 Tue, 06 May 2025 08:30:11 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b170b8sm13758278f8f.82.2025.05.06.08.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 20/30] include/glib-compat.h: Poison g_list_sort and
 g_slist_sort
Date: Tue,  6 May 2025 17:29:15 +0200
Message-ID: <20250506152927.222671-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/fa57c8069d6c723f5b947560677f4ca596334330.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/glib-compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 86be439ba0e..2e32b90f051 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -36,6 +36,13 @@
 #include <pwd.h>
 #endif
 
+/*
+ * These functions perform function pointer casts which can cause function call
+ * failure on Emscripten. Use g_slist_sort_with_data and g_list_sort_with_data
+ * instead of these functions.
+ */
+#pragma GCC poison g_slist_sort g_list_sort
+
 /*
  * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, allowing
  * use of functions from newer GLib via this compat header needs a little
-- 
2.49.0


