Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B60DCE8E70
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x3l-00043n-Ex; Thu, 24 Oct 2024 08:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3a-0003zA-Da
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3U-0000Ed-QQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729773307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mViewCgOGDMlHRXHm6Ff3nuWR7zUwAwAF9HzbBfp5Ik=;
 b=gEkD2Yt314W2X9MeT0dig1Ac7k65ub8iJ/iZbwSBQJ3R6w65RhaAc6hQGaGc39/br5hFqk
 8XG5y2PU/J5eJ3owgvXxB+8YaVgPx3c1t0w8on8+FroBw9u7J+veMb0HNLCAc/Pgw90z5C
 Hk+gyRgxcoHQcZoOhvrTlLbgW2Xj8no=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-PTwV4MSgP1Gsxmqf8VFRSg-1; Thu, 24 Oct 2024 08:35:06 -0400
X-MC-Unique: PTwV4MSgP1Gsxmqf8VFRSg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so6413595e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773304; x=1730378104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mViewCgOGDMlHRXHm6Ff3nuWR7zUwAwAF9HzbBfp5Ik=;
 b=PuKDZA/iYRUBdh6aF1cX0AEjCM5I7qy1Hrv90FDni3zOpyPkdWehS4pAOrUeZk6V0s
 gcTyZYb48l2kT7+4YWM+zJJiuVTTFf3safzdxyr5IZEEm+J5py4TrtjBRVMA+XA43vz9
 rSHVxth0xPPw11qCZJydocvPvcqN1yY+rflGh8JjtlkOHuyZMl/VazrH0z4x8ERcfjeG
 2HC6FzcEv5tuqOtuaQSb/lbshbLIrBXLMDVs97eEpr+GvBfw7FnIRWSBp13/tdQGvqYG
 lW1uGZTO6ZxqzzYorQA1YwFcNvkm8TGYxEZc24m75p780loTZ7fza9dB5YAR/yBAy4yC
 lqHA==
X-Gm-Message-State: AOJu0YwYhTr0izsm0T4lLQ9LTFH595InI6aiB8V7AgZJ/bDoEfYGr/sJ
 A2z39uEyizOrcenO9BZLBcbqbYPD4GWM3QhnDNawK4dJqvToPnWI/16WPsgcPa1EI8s0a2cd7t2
 hx9jvf9/LQZE6PEFJrrJDZW8pwYx4Eoor/VE8pyF/DKiWE/hYKNC+TyZ9B2frTK8HF74MGWJgKe
 mYnzv/fYC0PDNzPb7Wb9IxocMUPuQ9xS7mSpAfGeg=
X-Received: by 2002:a05:600c:3550:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-4318413f0ccmr54328945e9.12.1729773304049; 
 Thu, 24 Oct 2024 05:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzYigG4QorSGEqrdTm/SDW/W3DNQjw1NBLSiWDmfXeF+ImapImv+hNlY/zGfQz8g7RbYStZg==
X-Received: by 2002:a05:600c:3550:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-4318413f0ccmr54328685e9.12.1729773303515; 
 Thu, 24 Oct 2024 05:35:03 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b567977sm16188305e9.27.2024.10.24.05.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:35:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 2/8] sockets: Remove deadcode
Date: Thu, 24 Oct 2024 14:34:53 +0200
Message-ID: <20241024123459.59350-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024123459.59350-1-pbonzini@redhat.com>
References: <20241024123459.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

socket_remote_address hasn't been used since it was added in
  17c55decec ("sockets: add helpers for creating SocketAddress from a socket")

inet_connect hasn't been used since 2017's
  8ecc2f9eab ("sheepdog: Use SocketAddress and socket_connect()")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Link: https://lore.kernel.org/r/20240918232633.463861-1-dave@treblig.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/sockets.h | 16 ----------------
 util/qemu-sockets.c    | 35 -----------------------------------
 2 files changed, 51 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index d935fd80da8..c562690d893 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -61,7 +61,6 @@ int socket_set_fast_reuse(int fd);
 int inet_ai_family_from_address(InetSocketAddress *addr,
                                 Error **errp);
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp);
-int inet_connect(const char *str, Error **errp);
 int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
 
 NetworkAddressFamily inet_netfamily(int family);
@@ -117,21 +116,6 @@ socket_sockaddr_to_address(struct sockaddr_storage *sa,
  */
 SocketAddress *socket_local_address(int fd, Error **errp);
 
-/**
- * socket_remote_address:
- * @fd: the socket file handle
- * @errp: pointer to uninitialized error object
- *
- * Get the string representation of the remote socket
- * address. A pointer to the allocated address information
- * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddress() when no
- * longer required.
- *
- * Returns: the socket address struct, or NULL on error
- */
-SocketAddress *socket_remote_address(int fd, Error **errp);
-
 /**
  * socket_address_flatten:
  * @addr: the socket address to flatten
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 60c44b2b56b..c1b162b0560 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -707,26 +707,6 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
 }
 
 
-/**
- * Create a blocking socket and connect it to an address.
- *
- * @str: address string
- * @errp: set in case of an error
- *
- * Returns -1 in case of error, file descriptor on success
- **/
-int inet_connect(const char *str, Error **errp)
-{
-    int sock = -1;
-    InetSocketAddress *addr = g_new(InetSocketAddress, 1);
-
-    if (!inet_parse(addr, str, errp)) {
-        sock = inet_connect_saddr(addr, errp);
-    }
-    qapi_free_InetSocketAddress(addr);
-    return sock;
-}
-
 #ifdef CONFIG_AF_VSOCK
 static bool vsock_parse_vaddr_to_sockaddr(const VsockSocketAddress *vaddr,
                                           struct sockaddr_vm *svm,
@@ -1421,21 +1401,6 @@ SocketAddress *socket_local_address(int fd, Error **errp)
 }
 
 
-SocketAddress *socket_remote_address(int fd, Error **errp)
-{
-    struct sockaddr_storage ss;
-    socklen_t sslen = sizeof(ss);
-
-    if (getpeername(fd, (struct sockaddr *)&ss, &sslen) < 0) {
-        error_setg_errno(errp, errno, "%s",
-                         "Unable to query remote socket address");
-        return NULL;
-    }
-
-    return socket_sockaddr_to_address(&ss, sslen, errp);
-}
-
-
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 {
     SocketAddress *addr;
-- 
2.47.0


