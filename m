Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B474CCCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmI-0005h1-QZ; Wed, 01 Oct 2025 04:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rm5-0005eV-Q8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rlp-0005zf-BN
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkDh2PxrD9+QTzw6kMUAgyF3bTdWXZdPJnZrIUKZWws=;
 b=N3PVQ2N5lNyj1y227uSqDoCX3pepqx4E5wNA6CmhTT2363nAiDtI1Kwr7NR+p4TH+VzBcM
 ZFR+PLnEt8kKUgLGOvqRy//V4llJ2oQKzBEgvWWnInO1QahiJZboQwGIym6F2jho0CEwYz
 im+ljD/CRbb0eu8wyP2VaSWu1gkcTnY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-yZxIhEoVNiOUs5AHASvYsQ-1; Wed, 01 Oct 2025 04:00:57 -0400
X-MC-Unique: yZxIhEoVNiOUs5AHASvYsQ-1
X-Mimecast-MFC-AGG-ID: yZxIhEoVNiOUs5AHASvYsQ_1759305657
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3cbee9769fso434485866b.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305656; x=1759910456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkDh2PxrD9+QTzw6kMUAgyF3bTdWXZdPJnZrIUKZWws=;
 b=Ijcu0LhLJJnsYMFzn2v5MpupMvJjPvrDtQ2S1Qxh0wo+6gX1Lbo7B8J7LGW0g8HApJ
 hs9/ue4Ddziam2VqxWx4KWZUlf9JYUMyI97ipckBqdJdBsT+4AONKnzq7Nos8EQH1e72
 Ijowzf5gpIOF0y2DJ1mXn5adUS9pXOjnpKIg6hvKtIV8j3O5aFIIUA1UOVnK2RhVRPP1
 UKcnhg6CE1TdqOC8jHxsTwF8fDwrKwQKQdRN5Dmi4QfM6vz4RkH2aKbjp17s85mc9cUA
 SfgcAc2qA6wDUdNkOC6od4ILUIt+bY7DzXCB7quJf8RJsCTEiFZzjCAV2P+WTdQt5OBq
 RyBg==
X-Gm-Message-State: AOJu0YwH63AIaop81gcgVrDqnSziPr9fGrr8IqxcHPBb1ygUOD1gL+/+
 38Dyb8esSWs4sNxNhEW57gZweSQB+kQBea0bFd61aEgPbByB7un1+MtBUCzgxUO5kbhrbcsBASE
 5UWxw875ePtRKWuNIwrOKn+poy7svJ+fG4LPIKYjJMelnrMMAJ1UU//iVT6d44iJWOFSjiesaxE
 vd1k9k6FK+fJETYx73H1CvRpaw9IEleRogOOJRTpJz
X-Gm-Gg: ASbGncu+YC07aMWG09c8nyc+fBgn1Gs5SfGe9S1X9pR3L28AiWDZWLoOYxp2Y/PaRIw
 MLKZoVynZwsjt35+4Vg+KhowvMJoFTSj7jEzHkgDlcZ0q4cizOUK9Pi5uwffSNuzMKYt0/FicbR
 bGfGa+eH18+0QKuZqYr239Vz/VVcL3b0iN+PgZWvA4Uvqq/RM45iGoIp5lVDc9ge+DTXJX9ba5D
 9BJTvYKcqr3TeoysMnYBKAqFHmXYptKz88nuuWIERkkx80TchvpdLJ3A0sh9C/7D4G1n6RZhuJW
 Ns/wCTkbcwtqsUFTcBGoLdsA1LXNvY1dGQNM3Dcf+HLsFlo4As6sxDQ1+QyDUYD5zMl5tN3mN61
 l/t2FPyBbyYkOLoy21hyOxeV1O9/aIkOk46c9HChBEKL9o36qkcY=
X-Received: by 2002:a17:907:94d1:b0:b3c:193:820e with SMTP id
 a640c23a62f3a-b46e4d7d8c1mr292715166b.13.1759305655695; 
 Wed, 01 Oct 2025 01:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2pgmqTtXUVLor5PDotVsFol3CAg18Nx5vgeT/XIGhPoIS9gpRvPmj0A4DzQ9tzSSQ87gf3Q==
X-Received: by 2002:a17:907:94d1:b0:b3c:193:820e with SMTP id
 a640c23a62f3a-b46e4d7d8c1mr292712266b.13.1759305655277; 
 Wed, 01 Oct 2025 01:00:55 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b41f5ed2cf2sm359927266b.36.2025.10.01.01.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:00:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 01/14] qobject: make refcount atomic
Date: Wed,  1 Oct 2025 10:00:38 +0200
Message-ID: <20251001080051.1043944-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The Rust bindings for QObject will only share a complete
object and treat it as immutable from that point on.  With
that constraint, it is trivial to make QObjects thread-safe
just by making reference count operations atomic.  Do the
same when the C code adds or removes references.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/qobject.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qobject/qobject.h b/include/qobject/qobject.h
index a6244d0ce00..02f4c6a6eb2 100644
--- a/include/qobject/qobject.h
+++ b/include/qobject/qobject.h
@@ -32,6 +32,7 @@
 #ifndef QOBJECT_H
 #define QOBJECT_H
 
+#include "qemu/atomic.h"
 #include "qapi/qapi-builtin-types.h"
 
 /* Not for use outside include/qobject/ */
@@ -73,7 +74,7 @@ QEMU_BUILD_BUG_MSG(QTYPE__MAX != 7,
 static inline void qobject_ref_impl(QObject *obj)
 {
     if (obj) {
-        obj->base.refcnt++;
+        qatomic_inc(&obj->base.refcnt);
     }
 }
 
@@ -95,7 +96,7 @@ void qobject_destroy(QObject *obj);
 static inline void qobject_unref_impl(QObject *obj)
 {
     assert(!obj || obj->base.refcnt);
-    if (obj && --obj->base.refcnt == 0) {
+    if (obj && qatomic_fetch_dec(&obj->base.refcnt) == 1) {
         qobject_destroy(obj);
     }
 }
-- 
2.51.0


