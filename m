Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B14DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNcl-0004z9-Hw; Wed, 12 Jun 2024 09:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNcj-0004oV-To
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNci-00085L-Ap
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omq0CP5he99OGK2yfFFh7e+anHH7U6JGORMDNNdU/Yw=;
 b=C36yp+PngYLGI6xRkp5rEyOE8wq6Mzw9O/l8gJ1ijZ2iBMY+9Su7rlnj5o4j86uUcIGKau
 68Z2Wn44rEIMv66ons+0vz5MkP4Ke8itpNNF+9zqNArQ66mXIcIOL9HFSudGzBMMj6qFS7
 8SpzqWDYF/Yr0ztIx+o+KcPp8CHGqOQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-CBramQ5bNLKYikemXjWDvg-1; Wed, 12 Jun 2024 09:02:42 -0400
X-MC-Unique: CBramQ5bNLKYikemXjWDvg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7955f8b4bcfso247174785a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197361; x=1718802161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omq0CP5he99OGK2yfFFh7e+anHH7U6JGORMDNNdU/Yw=;
 b=B5TWH9rF72l1iK1fDNu5LDPUmJ1NqgSNm0Nf0S1AD/bWkojMC4yRIIYn19A21+L1D1
 pkeB53jTocN6Ql/kqCuqLxMgm4tJrM+pZ3XC/dOHRRPWYKN63df6rs29vvSkpf+hjJ98
 nqQ9mQKKQTcce1illJUyLeJ+eZX43Ziq3DeMXiwEm4C/H4ENKbriYV+p5EOpQntsc1Tc
 2dG70gkg+Ylx+JQHjKt0Az+d2ncRKoBgaeiIXH6WD3b6wU7JLBEHGx8IqcUY9Yekl/bj
 qOpO77K71b4/LetxoyubHrGHFETXfmVQ/F5T1qkqErAIR4o1rCQD4orUW271Po76OsNp
 Tljg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYGB7vumvkH5RFQBefoWl1a2PZxOyklnlEHclwH9W4Nz3vZw7vOnMPCiqxRIm4gPyDk1NM8P4lveK5NQhv2/jL8i8y604=
X-Gm-Message-State: AOJu0Yyomteqw8VTS5qeZak19DFUbjOveU2UxzWs1KvL8qbtdMGrxfdu
 PyJXXzW0dmSsjhjjx42FTbEyu7V/c9umsw+GI88rfn63i6l+VUe+dLf5PbnRzySQPOZzDjp9tP8
 UDa6vCcxzPsF8C+pXyunkwmvp2SS14DH8jk0OoRlxc5wQVeiTO+p7
X-Received: by 2002:a05:620a:258b:b0:795:5d6f:8bbd with SMTP id
 af79cd13be357-797f613d22emr202984985a.73.1718197361323; 
 Wed, 12 Jun 2024 06:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHpTjWc/xjAx6/et7Wama94T4aqW8tZbAGLUMl7jPrJ5idIez/XUss2R4MdT1ntNwZU9N9xA==
X-Received: by 2002:a05:620a:258b:b0:795:5d6f:8bbd with SMTP id
 af79cd13be357-797f613d22emr202980385a.73.1718197360870; 
 Wed, 12 Jun 2024 06:02:40 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79532813a4fsm599132885a.13.2024.06.12.06.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:02:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RESEND v7 04/12] vhost-user-server: do not set memory fd
 non-blocking
Date: Wed, 12 Jun 2024 15:01:32 +0200
Message-ID: <20240612130140.63004-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In vhost-user-server we set all fd received from the other peer
in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
it's not really needed, because we don't use these fd with blocking
operations, but only to map memory.

In addition, in some systems this operation can fail (e.g. in macOS
setting an fd returned by shm_open() non-blocking fails with errno
= ENOTTY).

So, let's avoid setting fd non-blocking for those messages that we
know carry memory fd (e.g. VHOST_USER_ADD_MEM_REG,
VHOST_USER_SET_MEM_TABLE).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- avoiding setting fd non-blocking for messages where we have memory fd
  (Eric)
---
 util/vhost-user-server.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 3bfb1ad3ec..b19229074a 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -65,6 +65,18 @@ static void vmsg_close_fds(VhostUserMsg *vmsg)
 static void vmsg_unblock_fds(VhostUserMsg *vmsg)
 {
     int i;
+
+    /*
+     * These messages carry fd used to map memory, not to send/receive messages,
+     * so this operation is useless. In addition, in some systems this
+     * operation can fail (e.g. in macOS setting an fd returned by shm_open()
+     * non-blocking fails with errno = ENOTTY)
+     */
+    if (vmsg->request == VHOST_USER_ADD_MEM_REG ||
+        vmsg->request == VHOST_USER_SET_MEM_TABLE) {
+        return;
+    }
+
     for (i = 0; i < vmsg->fd_num; i++) {
         qemu_socket_set_nonblock(vmsg->fds[i]);
     }
-- 
2.45.2


