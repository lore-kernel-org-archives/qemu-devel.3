Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC50C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9sK-0003Xy-Qc; Thu, 23 May 2024 10:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sB-0003CG-4W
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9s9-00043u-5V
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edUAbB6FYQtNYztKJ8aeeDlCGuti83HdzsdflmaIRq4=;
 b=cOEm6KoQjGyWc1HcwWbM5I+kuP+ZZ+3L6yn5HtuDPaTjy3YOeMvT8hqcAvZzHxLj2Qv/9I
 LASCk2p8WhS2nW5RR18fEZ66ul/DqfXPYCfaRckIMuP8uvHkcCKyweggc3fWdJKzwdAPC4
 JNObbiDDHXBOkYIxmvDt2+CUX0y/aJ8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-CiM65WmPNMWilqxtYX_PVw-1; Thu, 23 May 2024 10:56:47 -0400
X-MC-Unique: CiM65WmPNMWilqxtYX_PVw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-803178218b3so106604241.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476206; x=1717081006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edUAbB6FYQtNYztKJ8aeeDlCGuti83HdzsdflmaIRq4=;
 b=goDSgezTk2xvvMftC7W/3Slk2WLCI3sM5HG3JhfOm1xgORySyokTniYc19n6Fc8X7M
 0nZW1jtknxBgKviU2yPWWkylzpfuRFJkqlkFY14xhiNhdIThx4+K1pUPta8ek+EzPKNU
 wBT0EcxIXjz7lXsQGzMO6Y3N38l6+yFJ4haNbrAHiCuWUk1SEs5YRVWZ19A2FR4IwJIk
 Bn9AivEPhEzIgwizzqpL5QAwLcDekMDyuzQChpewl1DvjljR+mjm4skBkcDYhslmkcvB
 eivoFf1NRBp6cNXZYhRLN6rd1tF7ixGE6F/1Fj8RZwz7h7ZEPSqBqH6/FkfpkJti1Dgq
 /lKA==
X-Gm-Message-State: AOJu0YyMRZLrHI8xPPC7oEykHvLqKjlp7fhBNDW4yBrZuj9mD6BUxhfn
 ZkuyUOjcF3WHmoSXy8akjdFKGV07xq/QPeXeMiuzkqMhB/xAHZqsiYlT6Rztq1l2g9jDmZrSizH
 pAHKoGPZNGxDQNERtU0Mrar6538ImPp08fvbgrLekztVggaow2xZLx3dlEEHhtiv9prNiyZq0Ow
 ojkmOnJchmMCSptGKZBvuammKtbUJrHmL5qOMu
X-Received: by 2002:a05:6122:1829:b0:4dc:b486:e4a5 with SMTP id
 71dfb90a1353d-4e212f1b787mr5172789e0c.0.1716476205928; 
 Thu, 23 May 2024 07:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmySploH/h2W6a6HnRYeB4E6EpdvHnDW61lCXGKV1+O0F44Qy1IHPHfbppgWanotLDjKsH6w==
X-Received: by 2002:a05:6122:1829:b0:4dc:b486:e4a5 with SMTP id
 71dfb90a1353d-4e212f1b787mr5172737e0c.0.1716476205360; 
 Thu, 23 May 2024 07:56:45 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d704dsm143641646d6.116.2024.05.23.07.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:56:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 09/13] osdep: move O_DSYNC and O_DIRECT defines from
 file-posix
Date: Thu, 23 May 2024 16:55:18 +0200
Message-ID: <20240523145522.313012-10-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These defines are also useful for vhost-user-blk when it is compiled
in some POSIX systems that do not define them, so let's move them to
“qemu/osdep.h”.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/qemu/osdep.h | 14 ++++++++++++++
 block/file-posix.c   | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f61edcfdc2..e165b5cb1b 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -325,6 +325,20 @@ void QEMU_ERROR("code path is reachable")
 #define ESHUTDOWN 4099
 #endif
 
+/* OS X does not have O_DSYNC */
+#ifndef O_DSYNC
+#ifdef O_SYNC
+#define O_DSYNC O_SYNC
+#elif defined(O_FSYNC)
+#define O_DSYNC O_FSYNC
+#endif
+#endif
+
+/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
+#ifndef O_DIRECT
+#define O_DIRECT O_DSYNC
+#endif
+
 #define RETRY_ON_EINTR(expr) \
     (__extension__                                          \
         ({ typeof(expr) __result;                               \
diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..7a196a2abf 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -110,20 +110,6 @@
 #include <sys/diskslice.h>
 #endif
 
-/* OS X does not have O_DSYNC */
-#ifndef O_DSYNC
-#ifdef O_SYNC
-#define O_DSYNC O_SYNC
-#elif defined(O_FSYNC)
-#define O_DSYNC O_FSYNC
-#endif
-#endif
-
-/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
-#ifndef O_DIRECT
-#define O_DIRECT O_DSYNC
-#endif
-
 #define FTYPE_FILE   0
 #define FTYPE_CD     1
 
-- 
2.45.1


