Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518B2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuEN-0002bh-Ag; Tue, 28 May 2024 06:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuE8-0001zD-SL
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuE7-0000H4-E3
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wj7gnJyB4SMKmHEg0BihWZTUVviWXwgvTE/XsVbq+I=;
 b=K8P/kDMFIL/5ZKuzeU/Iw3KjesYyLJXjovDsGxKk8GEzVUQWrfW3H4A7YAoKt3X6535Oyk
 rAL9dVAwSMwW+JE5LfYEsn6ivhaTBYM6qYJkJz/fewPbNPqwzEWraH96xpkRQZTITb/qIo
 QjiVU0O+PaevhB3XzO4hzy5fpmvr9eE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-jHh4zLY6PAuIVAp5n2Ppfg-1; Tue, 28 May 2024 06:38:40 -0400
X-MC-Unique: jHh4zLY6PAuIVAp5n2Ppfg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e95ad38ad1so5249691fa.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892715; x=1717497515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wj7gnJyB4SMKmHEg0BihWZTUVviWXwgvTE/XsVbq+I=;
 b=rekInwCp0Po2u7IOc+6Owm0U/TIQM5AEGMXAGOq40xt38bvwFbON+WjDd++V+Fs3SC
 YLolp/20q1J2RHpnjicPEU33rxLMGGc+No9ZMnD8w87E+y6ONmclGsfthTTw43vdNwf7
 DxlJ3ErEzXom6M+/FzkiM72OH/B5BVYH3VmNxMfRqiN1l8JPtDI/f7YTvaiIBZeZxiLb
 Vg2gqylz+1ys3LwDw2hddZnVCGPgQo7n0cYM3nDV/5Ty3QAprkDXjHzRTCvo+lfPI1B/
 eYrTOgIrYbuCXvEhj0ZKumtD3aQ86EpHQGD1gA0uGwTSVdnXRfASIAw4GKkdWdpRLX4/
 Rg/g==
X-Gm-Message-State: AOJu0Yx3cnMmyuTprYd+q9R0m4gA0MPUcICqOPzJdRLncLdoqCOsFnC1
 w56FVwM3DelbmufUZX6Al0wnqBa8PWxzbp+LPCkZm0NF+nyZUj8sOQFc5flU7Ae4hQto5RuEufu
 JZAjxNFdiRe7ahdgPmRawWyUcndPff16wY2NJR1HOYQVwwaZadBQWt8K4vR3R1L0w/aLQuRJt3A
 hR5sJa3KFQ6tyCNzW6mGCLIDZbevy8ScpaqMc+
X-Received: by 2002:a05:651c:b0a:b0:2e9:7fa4:b34e with SMTP id
 38308e7fff4ca-2e97fa4b4ebmr35459071fa.16.1716892714971; 
 Tue, 28 May 2024 03:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ4Dp0Wh/isyRgLJ33Dhya7bZa8HCODyohqU9sO3Tz5mR26misn3ZNoqp/+rbmNAqW7MVgGw==
X-Received: by 2002:a05:651c:b0a:b0:2e9:7fa4:b34e with SMTP id
 38308e7fff4ca-2e97fa4b4ebmr35458561fa.16.1716892714462; 
 Tue, 28 May 2024 03:38:34 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f163a8sm168842015e9.13.2024.05.28.03.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:38:31 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, gmaglione@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Laurent Vivier <lvivier@redhat.com>, Brad Smith <brad@comstyle.com>,
 slp@redhat.com, stefanha@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 11/12] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Date: Tue, 28 May 2024 12:38:30 +0200
Message-ID: <20240528103830.146286-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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
2.45.1


