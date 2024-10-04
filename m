Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3895CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJF-0005T2-Le; Fri, 04 Oct 2024 12:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlH7-0000At-4D
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlH5-0006Ur-AW
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uWdMuqfxCw5Np2FFSdp69OVDoJ5makDfahK/kSKpIQ=;
 b=fwJOjlZhSavzcgw1iJWC0R+VWjJJ6Bs9xO5omkRubaPM6hCZMj1QKdFfDX0DH3+lLLEQNi
 VJW8BfvW93kGpOPoFD8ohF6S7F6OBY3rC9qUtjUrz7wZmQGqQWfJPhYsCyWrmE7IhJMxGw
 6J+6MDPW/F6Wqm6Y9RIlDbB3e4naysM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-jyCNDfw-P_O9bT8D3ARejA-1; Fri, 04 Oct 2024 12:35:25 -0400
X-MC-Unique: jyCNDfw-P_O9bT8D3ARejA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ca8037d9aso14223555e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059723; x=1728664523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uWdMuqfxCw5Np2FFSdp69OVDoJ5makDfahK/kSKpIQ=;
 b=qlOXXDncW6gO5g0EA2GY+RvIVeW4GdHQWHGKbxT3YLaAuO+VEKpJbu2ohX+PBMII3r
 Pg/nZkl8c/+9pPFLVjiLB51JFvkDmP8ERF1ZSBuiM80v562t47JTJgtiDpHo8V0Y5oGs
 DBQ2W7lwoKys7Z5UMDH7rH2f86t/JR1NuDLCmLfaTD0WmXGXLdqVAANFQA5c6JZka7Ct
 ol1zvfGOIEV+O78MIRk2RE2ohBAvehXc9yS7uDgEAUxVbVk3iXgbNdlyAuVe+PS6aR8M
 M+hkP/LQCTPkmuXinHKsG0FpFLbhZdZttx6rOjfd2xIDqgWlELbpjbGUJpSpHexAofh+
 ULGw==
X-Gm-Message-State: AOJu0YxnZFj0LVRkMKI7xjUEfFmrAvp+TVhc4jeTd1K7wWI/A6IOL/0o
 19UoYfPQl2AkItyaxJXjcTD7niy/VzL2zW7pbciAKGscYQkgcclSUyLATcWP0rTv4bc1oLEsZQD
 RLLx2DkNPAEN16xyJp48wwQPl2ktcbjls/vLQ6OsX8r9suXfszUR5FbEiAfcUGgvJCq4CXffCed
 litKuAZj7ZEbh4ie1gmT+yyBoKq5AtY7tpgWDqres=
X-Received: by 2002:a7b:cc89:0:b0:42c:bd5b:cb53 with SMTP id
 5b1f17b1804b1-42f85aef0bamr21673885e9.23.1728059723484; 
 Fri, 04 Oct 2024 09:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLzkEF37x5PLR6J1A5gexFqbXLzkwyiSj7Q1gt03RPmTcumKVNCk27V4o3cYgscuYDLOENeA==
X-Received: by 2002:a7b:cc89:0:b0:42c:bd5b:cb53 with SMTP id
 5b1f17b1804b1-42f85aef0bamr21673655e9.23.1728059723014; 
 Fri, 04 Oct 2024 09:35:23 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89ed9d4bsm1459855e9.42.2024.10.04.09.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 21/23] qom: rename object_resolve_path_type() "ambiguousp"
Date: Fri,  4 Oct 2024 18:34:13 +0200
Message-ID: <20241004163415.951106-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Make it match the function declaration & documentation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20241002080806.2868406-2-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 28c5b66eab5..0adbef29462 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2184,7 +2184,7 @@ static Object *object_resolve_partial_path(Object *parent,
 }
 
 Object *object_resolve_path_type(const char *path, const char *typename,
-                                 bool *ambiguousp)
+                                 bool *ambiguous)
 {
     Object *obj;
     char **parts;
@@ -2193,11 +2193,11 @@ Object *object_resolve_path_type(const char *path, const char *typename,
     assert(parts);
 
     if (parts[0] == NULL || strcmp(parts[0], "") != 0) {
-        bool ambiguous = false;
+        bool ambig = false;
         obj = object_resolve_partial_path(object_get_root(), parts,
-                                          typename, &ambiguous);
-        if (ambiguousp) {
-            *ambiguousp = ambiguous;
+                                          typename, &ambig);
+        if (ambiguous) {
+            *ambiguous = ambig;
         }
     } else {
         obj = object_resolve_abs_path(object_get_root(), parts + 1, typename);
-- 
2.46.1


