Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22CED2AB36
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lIw-00069A-VY; Tue, 29 Oct 2024 08:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIm-00067r-F5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIj-0000TU-Sd
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730204779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4htve3jF9i+MdStP1HNvXC37SaqbXO3fBifh0QuZLA=;
 b=STTQoQHrFBXgEGiRjw3cvIz7xAdNgRdwHwPx9r0+mq/gx2o+gcAOVE//VjgOPDeQqoR/Y2
 tkFHyvdWwcEPsUFYGsb6VjLw2oc8jufAVbGExr/59VS4wL8mQFCny/efdY6toEyrNqaGfM
 T3sNhLLLluEIkwDnSZeOSsL+Q3C4Sy8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-TIYMtRACNeK14eYjLNwNwA-1; Tue, 29 Oct 2024 08:26:15 -0400
X-MC-Unique: TIYMtRACNeK14eYjLNwNwA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso31121575e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730204774; x=1730809574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4htve3jF9i+MdStP1HNvXC37SaqbXO3fBifh0QuZLA=;
 b=W/UfpUG67MyIsUewZEUzCOtw1WmPjIJ6de88QZVWymkDWDd2Xx73EMq82xzKJrtT6I
 /CvwpFgYXKQFIB/xEd9sosygktVn5VYVvQPCVU7mccq8R7VYhXuDpYxx2e0enOMyPwPS
 JPFNVq6mm4ncLvbzxqK/eGeoPm0XOzn4bF5CM/oavg2tCDKxpxD3OHdecxKXY7MguqB9
 zHISCwNXZU+y8CV0wuBBh4rB2A1BBvNgu7yI6UiaLYVXAmLJC5RFyvX90mRNxw9iS6KD
 +ONFdzb07aAjxvBo+tfuzAptvjg/UfTtH9znetlPk4T69Ng0WyvrZbqzXmZAjFsGZc74
 LMMw==
X-Gm-Message-State: AOJu0YzhmcMs5TK6BPvUrbF7n2/xonAylONzAgHfPIlzeluijHPXUO1F
 FBCRZ+k6hCpkm0bCga4Hl19NCGUehweumefgsrAvpvtWaD0sQB4Mdo2RP9qgbt1OB2GZFwdJJNO
 F4lkBFF+IPh2Pzh50/N/Zu8IQSRwE5SFd6Tx/ajYu2rHQzT4u2zDEnrQc0RCRuQesX+1s8XNhjc
 IssGdNTw6rtY6zwuAgoIg7u3hmIg+ZHdMV9DBDt+w=
X-Received: by 2002:a05:600c:314f:b0:42c:b826:a26c with SMTP id
 5b1f17b1804b1-431b55e6087mr16772735e9.8.1730204773868; 
 Tue, 29 Oct 2024 05:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETz7lpPtCJw2TF5vgB2ARn1TOjm1oJTPDs8htQ8AjvaQlJ2OXOF9TDruwhrmr0l7iL0prKCQ==
X-Received: by 2002:a05:600c:314f:b0:42c:b826:a26c with SMTP id
 5b1f17b1804b1-431b55e6087mr16772445e9.8.1730204773439; 
 Tue, 29 Oct 2024 05:26:13 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935962acsm141012345e9.19.2024.10.29.05.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:26:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 1/5] qom: remove unused function
Date: Tue, 29 Oct 2024 13:26:05 +0100
Message-ID: <20241029122609.514347-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029122609.514347-1-pbonzini@redhat.com>
References: <20241029122609.514347-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The function has been unused since commit 4fa28f23906 ("ppc/pnv:
Instantiate cores separately", 2019-12-17).  The idea was that
you could use it to build an array of objects via pointer
arithmetic, but no one is doing it anymore.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 8 --------
 qom/object.c         | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2af9854675c..43c135984a6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2032,14 +2032,6 @@ int object_child_foreach_recursive(Object *obj,
  */
 Object *container_get(Object *root, const char *path);
 
-/**
- * object_type_get_instance_size:
- * @typename: Name of the Type whose instance_size is required
- *
- * Returns the instance_size of the given @typename.
- */
-size_t object_type_get_instance_size(const char *typename);
-
 /**
  * object_property_help:
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index 11424cf4711..8b269414488 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -262,14 +262,6 @@ static size_t type_object_get_align(TypeImpl *ti)
     return 0;
 }
 
-size_t object_type_get_instance_size(const char *typename)
-{
-    TypeImpl *type = type_get_by_name(typename);
-
-    g_assert(type != NULL);
-    return type_object_get_size(type);
-}
-
 static bool type_is_ancestor(TypeImpl *type, TypeImpl *target_type)
 {
     assert(target_type);
-- 
2.47.0


