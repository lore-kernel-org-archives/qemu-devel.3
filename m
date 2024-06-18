Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF3EC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVeq-0006l1-91; Tue, 18 Jun 2024 06:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeh-0006jC-TH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeg-0000qB-Av
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718704893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omq0CP5he99OGK2yfFFh7e+anHH7U6JGORMDNNdU/Yw=;
 b=aZr5Wlctk8b1mxFPd4AgeoQLly05AMaQIO46BY1UaTNGsdXgWGMtP05x3dEjBthmGcQ5RU
 3s+vZzHW0YnfaL3V5LEvUEAFfr2ILbZB3tRyS2DTWw1UidqJdp/Ih4EKyz18OidVVZtQsx
 EyKs/f2P1jFGgAOCIfEyuwTOsYW0evs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-tMtTOpasMnypUW6DSVXa4w-1; Tue, 18 Jun 2024 06:01:32 -0400
X-MC-Unique: tMtTOpasMnypUW6DSVXa4w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-421f3b7b27eso47390165e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704889; x=1719309689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omq0CP5he99OGK2yfFFh7e+anHH7U6JGORMDNNdU/Yw=;
 b=kBaS88iKkRhMpVZaoR1e1Pmxsj9s24S2Q69Halk3A2D49sEG5HFdbV9ZZyM4WjIA7t
 Z7is7e9QuyC/413YjI/x4bfGqbkvNgecelJm0tEpo2sl/ItQDePxoTyNmqAKEv7U4EpC
 9CzhTGxYTWUwrqHhYYGeoO2+H0PZYbV+gIU3blO1QNuRGRX+0a9S35TfR3LOGfAY2y/f
 NknCHpxMiAeGpWDWjeuraxkrWbQ4mV+jOm6X5FEGLlD2lnru7Lt8oa8AwYAKgGBNaB0y
 0sZaR4w+MbVzCjhOD3mJK+8RwUVA7xQRbHVXqkpG89LmY2rnY4du7OTQwa6PWLyEmfYa
 y10g==
X-Gm-Message-State: AOJu0YyxdmUkw91Si3lU0/c3u9thNkoT+bEeSLHKiEGVWFxs9ddL9P8R
 dRAV8apJ1MxzoF2KDcJ1nm6hf/oi9UwLrWszOijQh2+PCyNsRbrzweyhL0azpBEbQrhF5UdXnc9
 dYZczo5QBDxYpXQYoBhCgeIZr7nFgpb2XGAu73xdNKlZ87c9aGq6r/lF7naKUqD681tFFaJVsBt
 mNQUfTGXa9WWU7LC2W2/ghJ0dKKpIYfPKfOV+l
X-Received: by 2002:a05:600c:460a:b0:422:fa63:33c1 with SMTP id
 5b1f17b1804b1-423b6042b14mr85155035e9.3.1718704889303; 
 Tue, 18 Jun 2024 03:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz/n6EkirxnAOJq5rTblqIlHIMDurzatdzRs3nNi9adNaPfP2xl/YDqcTsIttfk38Ssr3cpw==
X-Received: by 2002:a05:600c:460a:b0:422:fa63:33c1 with SMTP id
 5b1f17b1804b1-423b6042b14mr85154465e9.3.1718704888769; 
 Tue, 18 Jun 2024 03:01:28 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4246b67f0aesm52531845e9.45.2024.06.18.03.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:01:26 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: Coiby Xu <Coiby.Xu@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Brad Smith <brad@comstyle.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, gmaglione@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 05/13] vhost-user-server: do not set memory fd non-blocking
Date: Tue, 18 Jun 2024 12:00:35 +0200
Message-ID: <20240618100043.144657-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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


