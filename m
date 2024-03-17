Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3CEC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaC-0002BX-EY; Sun, 17 Mar 2024 16:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaA-0002B8-ML
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxa8-0002Ye-T7
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbTnciHLM6snyuE4srqwTppUYesQqhHUAcBa6gwlgSM=;
 b=KG072rqFFUgPjMD+peQ1xzQ//JZJR2FJI0UDZvK1I7s+BFN+ioC9Mf6taAeedQLLw1SDRx
 heMA0a3WjWtbFMk7rnuXVd5KZZT4dGC6VQWbsTiaDYxDJXSUh2/LmSQlfVqo7yqFCObnFX
 eFeNSA5BkTCoAPkR7StPtXsk2pqEjsM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-kaKBa3-xOXGfWYj9T5aLAQ-1; Sun, 17 Mar 2024 16:58:09 -0400
X-MC-Unique: kaKBa3-xOXGfWYj9T5aLAQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-430b4572a97so12822251cf.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709089; x=1711313889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbTnciHLM6snyuE4srqwTppUYesQqhHUAcBa6gwlgSM=;
 b=sZea3u+unS65sxlU44IQCD/2etmqS3XZuVE0nMfd9i/TayRM+lHgYYFOVckleLmGub
 hj2taYMYlvwkjNjtxNVyvWjxw6DAfIW4D4MKHD2bigeuSPhN5zG9o/Tw8iNcwxOLRWGL
 NbtxjzbX8K7qXfY7brUR3NOPRbEyAp8Buqo4WyZDnYYHSoSbIK3wO7IRbiHxL1wjF1y1
 3V+wdqkDGcyRq5dNBT+5zKfH7DPcPGaD7HIIMg9KuUy1jNR3cNfB/83bv4t7rgWqvpNt
 V9pHL0eoo0zHYG4JpPeVGYOi31Eq9sj5UTO4GQAaf8qT5Xaj+5NKfWKe8V6mnJwNXDCo
 kbIQ==
X-Gm-Message-State: AOJu0YysBYOx3uBxwQ6PCVoLldQ8yWV6bKCQ8DX+GQWTbSkWdMu2um+8
 ON/unyh8ypnfJUIk2g7ZM7fEwtQXAbPpAqdaIjYhNAhaAjqvIzWXmeTQTKDTmTPnGEUb9cuQDuV
 pBOA/V6mdMxyLjhO6sXmMIOwD3LVIRhAoKf7pvZyNsozQZ5nlM1hWnhG/MS7j7+XbVnkDrkNIPh
 sCKxP7PrQuf3Y+fWzIwsFBD9bxqEQR3ZLn6w==
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr8883214qvb.6.1710709088810; 
 Sun, 17 Mar 2024 13:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp0W3MZ3YXyHbOiPw9/LK7NYkTThLMeP+OylfAnrLosrxy4uQEO8S8lm8eRe4EotLqOG3/Fg==
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr8883192qvb.6.1710709088414; 
 Sun, 17 Mar 2024 13:58:08 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:07 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/10] io: Introduce qio_channel_file_new_dupfd
Date: Sun, 17 Mar 2024 16:57:54 -0400
Message-ID: <20240317205803.361163-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Add a new helper function for creating a QIOChannelFile channel with a
duplicated file descriptor. This saves the calling code from having to
do error checking on the dup() call.

Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Link: https://lore.kernel.org/r/20240311233335.17299-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel-file.h | 18 ++++++++++++++++++
 io/channel-file.c         | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index 50e8eb1138..d373a4e44d 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -68,6 +68,24 @@ struct QIOChannelFile {
 QIOChannelFile *
 qio_channel_file_new_fd(int fd);
 
+/**
+ * qio_channel_file_new_dupfd:
+ * @fd: the file descriptor
+ * @errp: pointer to initialized error object
+ *
+ * Create a new IO channel object for a file represented by the @fd
+ * parameter. Like qio_channel_file_new_fd(), but the @fd is first
+ * duplicated with dup().
+ *
+ * The channel will own the duplicated file descriptor and will take
+ * responsibility for closing it, the original FD is owned by the
+ * caller.
+ *
+ * Returns: the new channel object
+ */
+QIOChannelFile *
+qio_channel_file_new_dupfd(int fd, Error **errp);
+
 /**
  * qio_channel_file_new_path:
  * @path: the file path
diff --git a/io/channel-file.c b/io/channel-file.c
index a6ad7770c6..6436cfb6ae 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -45,6 +45,18 @@ qio_channel_file_new_fd(int fd)
     return ioc;
 }
 
+QIOChannelFile *
+qio_channel_file_new_dupfd(int fd, Error **errp)
+{
+    int newfd = dup(fd);
+
+    if (newfd < 0) {
+        error_setg_errno(errp, errno, "Could not dup FD %d", fd);
+        return NULL;
+    }
+
+    return qio_channel_file_new_fd(newfd);
+}
 
 QIOChannelFile *
 qio_channel_file_new_path(const char *path,
-- 
2.44.0


