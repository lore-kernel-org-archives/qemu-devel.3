Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A8FCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8T-0000mo-Gs; Thu, 04 Apr 2024 08:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8Q-0000lq-Rz
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8P-00010T-CY
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGsiOWJv5V843yPjMDAAyG56pyYPyj7fhXTNvvLUdHs=;
 b=TsGNtRHE3HbOcgBoav5fcjcRadM21EpQX+Z3envTgX9z+4GjpxWmGwKcZ/b68Qav2QMXH5
 1waS/Ge4vi//QJex7p3tdDufTnISwYl+2cAR/kTVp1KmUZDdFL257N7asi7AWxtYBPgWVK
 vLNLD03jnaJcKYlcQsDxHiA+89l8mGM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Llgkv_NEPeCbsNgrmCe_ag-1; Thu, 04 Apr 2024 08:23:59 -0400
X-MC-Unique: Llgkv_NEPeCbsNgrmCe_ag-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-515bbb9a73aso884610e87.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233437; x=1712838237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGsiOWJv5V843yPjMDAAyG56pyYPyj7fhXTNvvLUdHs=;
 b=dxtgf0S1y/eY8g7zjWmhCbM7D690qSb66LNbVwsS+q4A0Xfg0ESPYrxVfKZrehl5p5
 mXoKZuoLfFtg0HbeglHR3GUsy7BVg+79Gx3NPX/BzxoQYWLTgJebn4qVE/ilQvW63GPL
 sewNBDTNIZzc3Yk8vXNSicz8vPs3rv52RkXrobWHPJ9Qrn2Qb54uVUckqlF+UWfIN3cr
 s4M8upiUBZd5of0gBaqBOjMVjLqh9rvLFwqakMymYvQMe48ui9fxi/pQMPoWcdD/rdq5
 e3Vxxjt0/JuG0ICE0GKh0wdzV0hWRQWe2PXHEcpVUlKf5uRpUkOMNfaawgxpcI+XCNzq
 C/Lw==
X-Gm-Message-State: AOJu0Yywk+dm5/eByi4L6jXxpR83eOp3zEZS5+gjk/pBHb5Ctjau1ol9
 n1Pyn5ucFPm8/Gk7h2jP7bd6qY5T/vNTXqZevzZ23QkgTYuwq5h38NXz4N5SFxEWgiC50UilfCu
 zaGEw19sHjT0A1jAhGF+Nq6zOfPssuP4X/5cqWwzbcPX/U9Gb5zeFjEk7ylEWUIQdVpmyjLBUK0
 gAdQtHfwwrFM5mv0O+V/tGlyicdzLNuOJ4bu8/
X-Received: by 2002:ac2:4a6c:0:b0:515:90e5:4555 with SMTP id
 q12-20020ac24a6c000000b0051590e54555mr1482594lfp.16.1712233437524; 
 Thu, 04 Apr 2024 05:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsRFyDiXYHKCS1Gh7h+M1i+yM7rWqRzttF8unR9EdETBwvAmEMHGiXF9Ctl8llmwqLq6c/oA==
X-Received: by 2002:ac2:4a6c:0:b0:515:90e5:4555 with SMTP id
 q12-20020ac24a6c000000b0051590e54555mr1482547lfp.16.1712233437009; 
 Thu, 04 Apr 2024 05:23:57 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 ev6-20020a056402540600b005682a0e915fsm9165344edb.76.2024.04.04.05.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:23:56 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 04/11] vhost-user-server: do not set memory fd
 non-blocking
Date: Thu,  4 Apr 2024 14:23:23 +0200
Message-ID: <20240404122330.92710-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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
2.44.0


