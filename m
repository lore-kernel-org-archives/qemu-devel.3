Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0521EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJViv-0005RR-FW; Tue, 18 Jun 2024 06:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVib-00057k-B1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJViZ-0001U1-H0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718705134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLmIFJnBiZstRbWMCttQ1B85eqiav2i7bnLQ8L9RWs8=;
 b=ZabeN9EYJYwRw3DFUh7S3FBRPpx7H2TD91793IaFasWORq1cfQdxeyhFba/AbgpxgWTZ0v
 jO0LrDgNbrvRItJ5ey600pa4uPhfMs6zEbFywuXmEJct5asHYdWTQ7QQGxGaHnn9OyPvuA
 TbDnqGW+ZMrGiLYgQ8PjBAjTtRdq/2M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-om0_B6AiPO-Lrno9Q9Wpsw-1; Tue, 18 Jun 2024 06:05:33 -0400
X-MC-Unique: om0_B6AiPO-Lrno9Q9Wpsw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f21956382so3381553f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705132; x=1719309932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLmIFJnBiZstRbWMCttQ1B85eqiav2i7bnLQ8L9RWs8=;
 b=qj8kjSsM+QnO1DzWTM/khzaRYNNOpX0VOKeOfZuyODVF3AHTxD2RYQzIjCB1cT2M88
 aabF3I0G6YppufdpHKHkANpnUp9nLsCYtiZk3vn5Fu9+n6wt6lVZTORWcLZinxhcIKKk
 XE2+VtRg2SF9IIAXReMziLzweyJ6B2ayzavGLTnpuiUCAlqDe0mkM2PDATxjdPkVCcjv
 IiYm1tYYXLcQYgCotwgUbN+GChJLfEjT0buzdfQF9/pT3WpExBFv6AnclxMLCUgIVwzU
 p3CSeMnfskUIZ+NQS3yV2OmjzJQLDq7w0y1q5223as48f93kzQBSMBo3VVfeKMR1A3/L
 0ztg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsJZVw8+jwAcAkUMUhpVV1YbSWGgkXUR0Y9S/n6Pj9pAWH1WunaiUPRn6zzDpI9sDnkxcn5iiElIvWMM/resul5rXLO48=
X-Gm-Message-State: AOJu0YzhoBTtfV0tAYqXbSn4fbjL9dhbp4Y5mdGcLRT77yYp+4ibHCgL
 yR5t85P3kdpDdjP4HBo+ybw4clxg1CFX7F+SfSXx4jQMPNSUXfXAuzR9+97sOKl9iIwQyC4Mzu8
 YC8V/10dgpiKYKqNckdjpqg67Wk0LD+zr81gu1uzGGr3ggpY5tI1k
X-Received: by 2002:a05:6000:22e:b0:362:40cd:1bc with SMTP id
 ffacd0b85a97d-36240cd02aemr478548f8f.24.1718705132505; 
 Tue, 18 Jun 2024 03:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnE0GCv/YZXncNH5Alm9LYmEI3nUwKhyNtbHP3mUE/cD3YzL7djLDsWpqx7H8taapurh7IeA==
X-Received: by 2002:a05:6000:22e:b0:362:40cd:1bc with SMTP id
 ffacd0b85a97d-36240cd02aemr478519f8f.24.1718705132141; 
 Tue, 18 Jun 2024 03:05:32 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c906sm13811218f8f.39.2024.06.18.03.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:05:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, gmaglione@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 12/13] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Date: Tue, 18 Jun 2024 12:05:27 +0200
Message-ID: <20240618100527.145883-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


