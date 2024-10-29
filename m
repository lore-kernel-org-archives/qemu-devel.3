Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B446CD2AB38
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lIz-00069X-SU; Tue, 29 Oct 2024 08:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIt-00068f-Gp
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIs-0000UW-5A
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730204789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FILn0kiELRQI/h2bsureFqbI99ihRtFsbCjCMadVMro=;
 b=KuQgtvH5yx41c3HaHEMhdQ4sbTd/0Cd9R5AX3KvFfURTnjRzOzFu0nKCUOXLkjZHpfniKz
 GrYVNj1VwbmJNKACLi1MAEnt5qWvH6imuiqF1PKsZl085IxkD7K8TjnJhKjmA6p2kGZ40J
 MzGTFfZcV7eI6LSoyQ0Rt3dVb2U725c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ccSb7PekNlC235xnlvxVHQ-1; Tue, 29 Oct 2024 08:26:26 -0400
X-MC-Unique: ccSb7PekNlC235xnlvxVHQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d537292d7so3556903f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730204783; x=1730809583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FILn0kiELRQI/h2bsureFqbI99ihRtFsbCjCMadVMro=;
 b=uhumACDbGxSr16V1PJTUgDFBSBcjq+mkotwXZDg1sIbNAgvE4YhOb5R8Hp7BRdcQo4
 kkpmmVv/0Pwr4Nf3v68Swj5s/VEKSJImeEJ+1p0UzBUR5ZZ0hnDV4Ew+ndv9UUfyElwg
 EQh4V5lZMViMD5v8KCklFSOAbCrR/k7nEx1SEJkWxXd1GKwyTnnM0gODUo/vGq8QRlAt
 apg0cwBDfYkjd0FI+oGiQmUr8e1yx9O0gzWUXqzx9+YjHQ2kUFE6wo23t+n/bojbkIBP
 l8s6NsC36XaGhRlitQxTZ2op/TUC25/JFzstndajmM9mh8dEZpD+1E5wogCblJsawSOH
 gK7Q==
X-Gm-Message-State: AOJu0YwXUeGZ6O6Ni4KrRwLQVugHf7qGpVGH3oAc54X+RO+RZwLWWA0P
 Xseqtla/JYbwphRqLFVl9GaslNT3LG4jTuWQmlt/2adUOL6RzLtQXWQArEK/Xo9TM6hMBrstNY9
 6gskMhfcJL711JWdGwuajFwFYkWCUENX+5BPkZR0ktOIGmSZm2ElwFGQATh2bLN2P/h4XxI1GG8
 CvQ3zva8UR/xfSGxvF9LROsfx99sDrDDBLJLUlJ24=
X-Received: by 2002:a5d:5508:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-3806117ea93mr9939831f8f.18.1730204783334; 
 Tue, 29 Oct 2024 05:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGgW/ntLxCwdNahZG9fX1P43CFaOleu13T6XiyyWaxBWyS/3sCmQpMLr3w2hVo34nGTMEgJQ==
X-Received: by 2002:a5d:5508:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-3806117ea93mr9939814f8f.18.1730204782946; 
 Tue, 29 Oct 2024 05:26:22 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b92700sm12386260f8f.99.2024.10.29.05.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:26:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 5/5] qom: allow user-creatable classes to be in modules
Date: Tue, 29 Oct 2024 13:26:09 +0100
Message-ID: <20241029122609.514347-6-pbonzini@redhat.com>
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

There is no real reason to make user-creatable classes different
from other backends in this respect.  This also allows modularized
character devices to be treated by qom-list-properties just like
builtin ones.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object_interfaces.c | 2 +-
 qom/qom-qmp-cmds.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 1f2aa133066..1a6f29c053e 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -90,7 +90,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
         return NULL;
     }
 
-    klass = object_class_by_name(type);
+    klass = module_object_class_by_name(type);
     if (!klass) {
         error_setg(errp, "invalid object type: %s", type);
         return NULL;
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 69a8e17aa80..46e4562300c 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -186,7 +186,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
     ObjectPropertyIterator iter;
     ObjectPropertyInfoList *prop_list = NULL;
 
-    klass = object_class_by_name(typename);
+    klass = module_object_class_by_name(typename);
     if (klass == NULL) {
         error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                   "Class '%s' not found", typename);
-- 
2.47.0


