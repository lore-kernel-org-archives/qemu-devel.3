Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AECE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK32-0001Y3-Th; Fri, 10 Jan 2025 13:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2E-0000GF-II
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2A-000187-Rg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4cw780DN/LGmTQ/ybrMWyZ0EkmQUgapSHvCxCFoy5k=;
 b=BNJIdnKfiw62MdRRB6E+r9r1dJNskRYv5ZAXiKCvWw1RJTSSzt1vP+DYoctCOCbRt4diAC
 UeAhK4VD2W6POxlvgA595EIt/H3LKC1Pds4GxWaLoH++kjVQFndM2vAm3XPg3FYWEVgEOi
 gO6FfHVhlnJDh3A+OiKfM0pV+FVJiJo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ZM3R3ENRPT2MAUJyh_IjdA-1; Fri, 10 Jan 2025 13:47:00 -0500
X-MC-Unique: ZM3R3ENRPT2MAUJyh_IjdA-1
X-Mimecast-MFC-AGG-ID: ZM3R3ENRPT2MAUJyh_IjdA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa680e17f6dso173599066b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534819; x=1737139619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4cw780DN/LGmTQ/ybrMWyZ0EkmQUgapSHvCxCFoy5k=;
 b=HGQxFnI71MMwdT8vdbEHO2gndMDGI1Z3zRB5zUzP+c9j6wi8dAxiL924pkcCczTNBr
 3YnZ6puJVP+QA8TSyMnvemIk3aqLA2Sp7Ezpz+rB4Vivg0MjRH+xaMZx9/4PQW34MH23
 Ey8a3a0V+VmIgkAIu1n+nCZmftIoo6mYtZFgizgtUKikfbDv7JirBDlqG5mIZEBCzwQB
 4gUMnGyd1abj268HoOuLXELZBjyQDgwTr17gH4KTvzaA1jLq5dSKkfijb72Ont3V/16F
 SG+GkGLVkwZthTbGH5Ii4c3kbIPRRxBrWIqToxAJLHrUwL3YqoF4MJ/LfeEQTngHZoOL
 FMKA==
X-Gm-Message-State: AOJu0Yyg6j89ZHIV/ZceNJI3SMsHgoQVXrn60f+IRdYUXuqtUpTKovX+
 KOKP7D7+4sKi2X9Z/C0t+neLOF77NSrdVaA1EhycLQJSMeaOmLpN+7rBuJh9vwBVcjUm0LNAL/l
 QLg7kloLIztATkPfcf0pudo2f0svm3BmfhYpNttkXr24f2GoUDTgzmKyGKyUGhtUvQX+DvWToXM
 ++gPekvDZHMu5EqHd0iIaVaJgDQYYH9qZsMspoU/w=
X-Gm-Gg: ASbGncvZA/hqtyZrpiXLigFpZCAC794WVF8FsTaIT4dCmvTXrBJspDlrG7YgPoEF345
 ly9V+aR7tb9xVwjs+IK8aORF9SprwT1zFN+vzXvwFobwb8IOOVJXVIAlIAlSPLTKDQXW8o8BZcn
 mmgqx6I9Xd+aJNgucmh9CqcPqNwunA8ZbSCzjNWK1Iqc/KwHuHoVu9j9zYfXzAMJxMgwTw+fJI4
 bHIDIqEJQ5ehfnuHQDN5hGLrmW/fVELWtO1le0emjiyKeWovbM8JDBdXag=
X-Received: by 2002:a05:6402:2814:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5d972e63dc9mr26575763a12.22.1736534818439; 
 Fri, 10 Jan 2025 10:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa5socmm5yd1SDbmSBLMuMpKplEFcH3+/QsNge+wdKVsAZ+VfBqmnprKmGulJMofkYctwX3A==
X-Received: by 2002:a05:6402:2814:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5d972e63dc9mr26575547a12.22.1736534816507; 
 Fri, 10 Jan 2025 10:46:56 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dacf1sm195757366b.63.2025.01.10.10.46.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/38] qom: remove unused field
Date: Fri, 10 Jan 2025 19:45:56 +0100
Message-ID: <20250110184620.408302-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

The "concrete_class" field of InterfaceClass is only ever written, and as far
as I can tell is not particularly useful when debugging either; remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 5 ++++-
 qom/object.c         | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 95d6e064d9b..f28ffea9a64 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -573,12 +573,15 @@ struct InterfaceInfo {
  *
  * The class for all interfaces.  Subclasses of this class should only add
  * virtual methods.
+ *
+ * Note that most of the fields of ObjectClass are unused (all except
+ * "type", in fact).  They are only present in InterfaceClass to allow
+ * @object_class_dynamic_cast to work with both regular classes and interfaces.
  */
 struct InterfaceClass
 {
     ObjectClass parent_class;
     /* private: */
-    ObjectClass *concrete_class;
     Type interface_type;
 };
 
diff --git a/qom/object.c b/qom/object.c
index b4c52d055d9..e9dfad854bd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -314,7 +314,6 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
     g_free((char *)info.name);
 
     new_iface = (InterfaceClass *)iface_impl->class;
-    new_iface->concrete_class = ti->class;
     new_iface->interface_type = interface_type;
 
     ti->class->interfaces = g_slist_append(ti->class->interfaces, new_iface);
-- 
2.47.1


