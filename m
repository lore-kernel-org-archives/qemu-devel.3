Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E59CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72B-0007H6-8A; Tue, 26 Mar 2024 09:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp725-0007C3-OX
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp724-00057o-CD
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGDk8t1Sssy5sr3pI6FPbTNJvoJDpa2GRLWLlgFnCCg=;
 b=UVjme058wOxU/fljnSmAdZZWT/i9etsyAIIm6ZNDTrvfKWmNi4N7qjKoox7xt61khD6eG/
 4RDt5jIRGQh8Pvm4aNaLvxqno+tLuZDvFXqn1tMYGmDO9mxcZa518BfmnQUZaa3cOuHMe7
 58xHxwTNo517CgIkeEyzzPjc0zowh1E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-p81ApJd_Orm_MuSPdfsdrw-1; Tue, 26 Mar 2024 09:40:02 -0400
X-MC-Unique: p81ApJd_Orm_MuSPdfsdrw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3417fa3f143so1322597f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460400; x=1712065200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGDk8t1Sssy5sr3pI6FPbTNJvoJDpa2GRLWLlgFnCCg=;
 b=iG8RuVAfmZH/WgrJtawxI/RB4/mVddR5eACuPEWCTPvaKcfesdjJgsZAofjTm/Z7Vo
 tKjlpdBDeL0uo+ghQO5fzXLDmKVriyG9JV0KReJcC7Lg3cvU89TJOx2z5WNg6zR99tJY
 vEWviHn9VQ8R7JYqKKVutbjorWEavgB7uCpbs3lTeRRzAQZD9Z3Q1Ge1YqmQrI77lfkx
 y46sMon9rUL2jvGxFZhbqLK3yI5uBv20rUGHgxPtgXAlQN6c4VT9ME0y2A59HAx2NG8H
 k7m78SzGihyCc13VcAWubX8RQNdmrm9DKQvvqnyDgmWQqquI3Z5IVQDIIR0Av9YqiWE5
 w1EQ==
X-Gm-Message-State: AOJu0Yxj7bvwKNkx1z7cxKmFTNzO/mc53TsQH7syLJWxuu6P2tLK0mkd
 zkyYghAh5LTKm8mDHAVVzAyrXrCk3ww7yO78eyTA4ZSsTCbDkNP3XNG9VYo5NILllJuIyJwF+sE
 I29w9aqmablDHzWigjyd+d+Btx7Q37ABRNXro1+ivAyPMVYlRhDShCbBjd5YRk5thDXEvUXyabL
 QVUPCASdQQU7NDaerRtLMCBfTKnHKqiOk/VY31
X-Received: by 2002:adf:fd07:0:b0:33e:7c3f:ee0f with SMTP id
 e7-20020adffd07000000b0033e7c3fee0fmr6615247wrr.28.1711460400441; 
 Tue, 26 Mar 2024 06:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFImdrA8cehgHQjACL3IkcO9h+idapOlwMAutQ+pb3b6l8BdOECajlEwjWrV55g/onVxx/g8Q==
X-Received: by 2002:adf:fd07:0:b0:33e:7c3f:ee0f with SMTP id
 e7-20020adffd07000000b0033e7c3fee0fmr6615209wrr.28.1711460400033; 
 Tue, 26 Mar 2024 06:40:00 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 w6-20020a05600c474600b0041490d1cd06sm577179wmo.40.2024.03.26.06.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:39:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 04/11] vhost-user-server: don't abort if we can't
 set fd non-blocking
Date: Tue, 26 Mar 2024 14:39:29 +0100
Message-ID: <20240326133936.125332-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

In vhost-user-server we set all fd received from the other peer
in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
if we fail, it's not really a problem, because we don't use these
fd with blocking operations, but only to map memory.

In these cases a failure is not bad, so let's just report a warning
instead of panicking if we fail to set some fd in non-blocking mode.

This for example occurs in macOS where setting shm_open() fd
non-blocking is failing (errno: 25).

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 util/vhost-user-server.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 3bfb1ad3ec..064999f0b7 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -66,7 +66,11 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
 {
     int i;
     for (i = 0; i < vmsg->fd_num; i++) {
-        qemu_socket_set_nonblock(vmsg->fds[i]);
+        int ret = qemu_socket_try_set_nonblock(vmsg->fds[i]);
+        if (ret) {
+            warn_report("Failed to set fd %d nonblock for request %d: %s",
+                        vmsg->fds[i], vmsg->request, strerror(-ret));
+        }
     }
 }
 
-- 
2.44.0


