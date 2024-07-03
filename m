Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133D2C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lI-0005oU-0G; Wed, 03 Jul 2024 18:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lF-0005cm-Ne
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lC-0001bx-2Z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LYdZnAc26juhzysGXK6UuvaiCGSQLeNMHoi5Vg2b1dE=;
 b=hq6AYHuxxYnwsdi29jyyQaZBFZSN2+vHfMNj4w/K1UVnO/FG+IiAPks23CDxVx+xvUc2uK
 k3nib8/76QxR8xHiGb9tOF/8/jZ3GSzLSlAMhYcaDUqT9mPfUVKSU5sRs3L83bsIBj85hc
 qim1eS/mLjuKcVThZuv6LwamL4KK4RQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-3kL2Y8V5Ofq6mggGDQqFBg-1; Wed, 03 Jul 2024 18:47:28 -0400
X-MC-Unique: 3kL2Y8V5Ofq6mggGDQqFBg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52cda76173dso5431677e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046847; x=1720651647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYdZnAc26juhzysGXK6UuvaiCGSQLeNMHoi5Vg2b1dE=;
 b=hbFKaS3L6IURLQr6h2IxXMHZdhRz3e5T3GR6KLWbuWy8PYz8A5s4mqKvj38sTQ+zMn
 qwRkp8Xj0cXgBEcZo9Z5Lzyx6BAqZ8mlLA1GlT4HGizBg2Quqrb3pnFsYMnt/9HsItaP
 gAIcTbnqkw44MxEavaOTavtFgkYA+dm9JtfBMkpJFkQK1pUJqB9sDjUOK2Zdu++AXzqS
 nun9l46GIAMSJKNblMgoVLWB9mjR8P/ErNz2Mt4nst1Ed2VbyJAaIdRlj5LAp+i+/OmA
 T/DZmTcpFvN10gV+vhNT78/kWtMI0ryx1+b5g+MyBcs9roWsvN92dKcurYee7X7sqRD4
 lw/g==
X-Gm-Message-State: AOJu0Yy8YXz1Rhyp49iFfjdH8rGrigIMZHlyi7co2faKbv5pFvWAy9O8
 mZccej0ZGcMp2cenAKZu/5oQ1FX1H96zS4X5qUFPa2j2piicbPTHJ92oxt9hYCqDVJ3vSxOkFaz
 utFthk9NteFQ8oAuausCGqUcvXIqjZCYhtcRhv/npa7lsfxFaTbt4VjONvrUNEFMf3wuPtwjhQu
 7qzO/Ti2MmlytUZvOgh3qqWwh7XoSHHQ==
X-Received: by 2002:ac2:5487:0:b0:52e:934f:bda5 with SMTP id
 2adb3069b0e04-52e934fbdf5mr2360933e87.21.1720046847024; 
 Wed, 03 Jul 2024 15:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZtg+8b7ZwW4Xu+gbxk61NEm7H3iipD5KMEeUFWkNdKVicZ5eh/ox7UMMfuXQmzJa24fOD9Q==
X-Received: by 2002:ac2:5487:0:b0:52e:934f:bda5 with SMTP id
 2adb3069b0e04-52e934fbdf5mr2360923e87.21.1720046846345; 
 Wed, 03 Jul 2024 15:47:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77ae5bfcddsm39242866b.173.2024.07.03.15.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:25 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuxue Liu <yuxue.liu@jaguarmicro.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 40/85] vhost-user-test: no set non-blocking for cal fd less
 than 0.
Message-ID: <f72fc16910c8f44edf052f52672e0e63bbbc773c.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the scenario where vhost-user sets eventfd to -1,
qemu_chr_fe_get_msgfds retrieves fd as -1. When vhost_user_read
receives, it does not perform blocking operations on the descriptor
with fd=-1, so non-blocking operations should not be performed here
either.This is a normal use case. Calling g_unix_set_fd_nonblocking
at this point will cause the test to interrupt.

When vhost_user_write sets the call fd to -1, it sets the number of
fds to 0, so the fds obtained by qemu_chr_fe_get_msgfds will also
be 0.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Message-Id: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f..255bde54ab 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -458,7 +458,10 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_KICK:
     case VHOST_USER_SET_VRING_CALL:
         /* consume the fd */
-        qemu_chr_fe_get_msgfds(chr, &fd, 1);
+        if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
+            qos_printf("call fd: %d, do not set non-blocking\n", fd);
+            break;
+        }
         /*
          * This is a non-blocking eventfd.
          * The receive function forces it to be blocking,
-- 
MST


