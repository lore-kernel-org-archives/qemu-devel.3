Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D632CC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNeE-0000xZ-VW; Wed, 12 Jun 2024 09:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNeC-0000dz-5R
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNeA-0008Jd-FP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLmIFJnBiZstRbWMCttQ1B85eqiav2i7bnLQ8L9RWs8=;
 b=M+NNAAAXPhug8xMgD+ua1UWfi8JtCB+6DUYtPme8blXg9xvFnFV7Y2mQgfkEO4T8AFzxTa
 JEtkRTe1KfzNIjV8NvRLsLNWgB+P4qUQvMJuyr9TWhofC8Os+ZP1VpWBm74koc5B0a9459
 IHlvU3CijwugP46gCbk+8vbwJl50HwA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-TZh3dgHfM_qVPuegyCi0jQ-1; Wed, 12 Jun 2024 09:04:12 -0400
X-MC-Unique: TZh3dgHfM_qVPuegyCi0jQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7979055b950so180782285a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197452; x=1718802252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLmIFJnBiZstRbWMCttQ1B85eqiav2i7bnLQ8L9RWs8=;
 b=f0btQTxysIC3ME6nY7Q6o6E4NJ3Q6yClUB6oLe263ie0mehDKk0QwoEmyfbgBngnL1
 p+mqyd1YjFwCLoxD6dx+TL3CwTx19+EHRM5G1IMzRzoVBTk0K4GwE6x8yl288vGeBVgH
 YCdSVYy2VPh/0CjVpIEdKHsuiFFZpPXTk9Zjt8mf2e8Zxh1jMKXkhbedK+QDKLlVoUSK
 bM/CBpC5gzK48GXBmkE/CtZDvqRx3AaaBanJd5wQmniGgOS74iZir2gAw8fZGxHNVti/
 U4IxENmVQ6poa/gOJ108uiREkWp+aVd/oRHSnEohK/S7K9KA6ExmVAFI5rbzLWFoLAh5
 ul7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM7fQlSFvU7jNzgSe9J0YN5cUj8ju4WXIT4/kb/7bruKd998q7d8osMsn6k4IoiZQAywTbuUdtYwBCUx5yKBs5VUV71p4=
X-Gm-Message-State: AOJu0YxgF7vIElho3NLQlcHL3VKnWI0+80FyrT6VlTle9jOXwreGA94b
 /a35FFQpSZhjbX6UoNW0iPBiF4N/h6Jk4pqY1sybLqLIG88tfSWH40euwnnFsJE5BqGeGdRBvkH
 iiOSaUEfV9cH2i21iBU2tvq6KBJDiOOujf+CJX5IX8TtUQSa3W/vQ
X-Received: by 2002:a05:620a:254e:b0:795:570a:b9e3 with SMTP id
 af79cd13be357-797f603bcfbmr154119985a.34.1718197451863; 
 Wed, 12 Jun 2024 06:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDk0TROvQ8Cw4FccfFx4OhllQv9drIYA2Pqi+0faMWI8dzIjiuR3Gfddh+gx5Xhmf05qUBbA==
X-Received: by 2002:a05:620a:254e:b0:795:570a:b9e3 with SMTP id
 af79cd13be357-797f603bcfbmr154110785a.34.1718197450872; 
 Wed, 12 Jun 2024 06:04:10 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-795331c88d6sm600125585a.115.2024.06.12.06.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:04:06 -0700 (PDT)
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
Subject: [PATCH RESEND v7 11/12] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Date: Wed, 12 Jun 2024 15:01:39 +0200
Message-ID: <20240612130140.63004-12-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

`memory-backend-memfd` is available only on Linux while the new
`memory-backend-shm` can be used on any POSIX-compliant operating
system. Let's use it so we can run the test in multiple environments.

Since we are here, let`s remove `share=on` which is the default for shm
(and also for memfd).

Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v6
- removed `share=on` since it's the default [David]
---
 tests/qtest/vhost-user-blk-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 117b9acd10..ea90d41232 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -906,7 +906,7 @@ static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
                            vhost_user_blk_bin);
 
     g_string_append_printf(cmd_line,
-            " -object memory-backend-memfd,id=mem,size=256M,share=on "
+            " -object memory-backend-shm,id=mem,size=256M "
             " -M memory-backend=mem -m 256M ");
 
     for (i = 0; i < vus_instances; i++) {
-- 
2.45.2


