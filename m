Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D42FC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9rq-0002iC-Gq; Thu, 23 May 2024 10:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rS-0002I4-4g
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rP-0003zQ-Cs
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hN/AM+u5Z+nLunf2Rn+i5MH2xtaDn5R44afvB9no9H8=;
 b=Krie9YBayxWKzy+uzdLHzd2eYitjNpY+i8DYzZG7bvVTOUHO2xJxGFmR4cS3ZTe0cA599K
 vNgYQQ+Nav34nZEJzyeN0Mpj2wpdRsMP5CoWUTwQsWsweqCfjDZ16eyts3wo8tnwk+s8gp
 yBSSklP8r7n7IWnUdlegpsglPxGUn7I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-RWgf_cylNmaV6ZoCUsnj-Q-1; Thu, 23 May 2024 10:56:01 -0400
X-MC-Unique: RWgf_cylNmaV6ZoCUsnj-Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ab7b258941so3344926d6.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476161; x=1717080961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hN/AM+u5Z+nLunf2Rn+i5MH2xtaDn5R44afvB9no9H8=;
 b=r+r+8TRCu5FP69qT4hWdmi9QR1aoVnVZ7dr8q1MYDYdL86aj3FhDRMoRXF2C4TGdKM
 /7/TzRLnBGRId0CY5JzOOEF+W5GSSvCZ9uh/SNw7zMsQ81hPkdQrWxUjDhY2u7rYLG0F
 OOkCTOG0eCEFl26mWJnCm+X1e9D5/zsRvTEp+mPTcjnDaVcpZeRcYWHe4FIgbSMI5DIS
 7ro6DGF1NFiNuBewo38aQC/dS1to2pCsFg9t1zowpUrPwMVkuFWZPhWgSpgU8tCThIzl
 aVTRm6pKOjUKzPTLcYfrh9j+gug7mHaihoxQonRhmJwmpnqjowTxk48jZvhBdzpmliYL
 87YQ==
X-Gm-Message-State: AOJu0YxtGqwGdpZeMbwWWrT9cBJ13rCp3qx73hoihgH6n46PjiKwOcTl
 yvj9Dh5GLlJ+OobBDcjqXmD2tcOoSeO+/frFsvGxyoQjYQ/LOMY1Mf9refbIpizm3rKGo+x13Q2
 qz0i82CMC+reRHUCgoyvqwrcxrRYSqG6QYaYF+pSQsTp1Eg6ZQcwjSjezZ3k0bQ/4zqEnXd7lr5
 BAMvWkRii6Og2qhSROkMOoks7N3prsFP2SY54s
X-Received: by 2002:ad4:4f54:0:b0:6ab:8a1b:6941 with SMTP id
 6a1803df08f44-6ab8a1b6b1bmr35374436d6.7.1716476161073; 
 Thu, 23 May 2024 07:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYM6uGiT4bQfpAzvCAcmG6s6un94sj/pZW+pZmEpB7DSlUh5LBB6cJ2/hoTPcTM92uGDVcrg==
X-Received: by 2002:ad4:4f54:0:b0:6ab:8a1b:6941 with SMTP id
 6a1803df08f44-6ab8a1b6b1bmr35374046d6.7.1716476160643; 
 Thu, 23 May 2024 07:56:00 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab8b361681sm11824566d6.84.2024.05.23.07.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:55:59 -0700 (PDT)
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
Subject: [PATCH v5 04/13] vhost-user-server: do not set memory fd non-blocking
Date: Thu, 23 May 2024 16:55:13 +0200
Message-ID: <20240523145522.313012-5-sgarzare@redhat.com>
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.45.1


