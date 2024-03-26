Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860F5CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72b-00005J-PV; Tue, 26 Mar 2024 09:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72Z-0008LW-P5
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72Y-0005Id-EJ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2fIVWILzKzQaFbqxYLTu1zrjB/5hVEGYyQqHDi9HUo=;
 b=Q4eFfIxbBMCroOLdMdb6Xya7ej1+3K8UmxpImQxjpE9CMJD+GVDdUBOJzgvlf+/O9BdqqN
 kBJuJK1Wz4Wz0SwQKJSUYLsjMMxWsonB5nTXc4SuLB8EveBphR/BtT0IadYFT8jT3P+gAk
 6RMr5eQlI9zyhWxI6iq2igqHOdhOmJg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-PpOBSzWqOt2OL9sFGSz8wQ-1; Tue, 26 Mar 2024 09:40:32 -0400
X-MC-Unique: PpOBSzWqOt2OL9sFGSz8wQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33ed44cb765so3110952f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460430; x=1712065230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2fIVWILzKzQaFbqxYLTu1zrjB/5hVEGYyQqHDi9HUo=;
 b=gpVIiyWRJPoepQRJ6uGnOWChugYzheYByP5qGw/DvK0RUknR2HY46OmAtcHfg54yD0
 Iw7cKuNBcUgHGnnhzl8aGiur0NKPIAcwQR2I6fkcivR4S3INsC3ZAfiW9RT4XEvrA5Cq
 67++Dn8BgHyferto+rpGnkruepmWbZ65bmJ8+xwh+GtHIaIUfxSCX2Nv8yH6vM+HyhAR
 v9Q7woP/fZpcHQKMPHO5nBk6JULmRu3eYo+qm1mJB/5Mop7+8wJPT/ZCoDkCOgG/m++I
 RBRoQkbBUDTVDKYU1RdoYt24dWYH0CvCjVHq+aYtxJDZt5NP1XjFPdbeF0OlmaQua9mw
 7IDQ==
X-Gm-Message-State: AOJu0YxH4ldRvLLL6yWFaQ6kWuLg5w/m0X1xuFSwG1PPv7SciwcROatR
 oBxYPBT9xwqIQCDmTGVmp+uNV1tb3x5F3NTfjTXOV4edwTmwOiugINmmDsbDOmwLkt8VId0qmoC
 5Zrho2XCdzgGt411qZ+e4NDVLFE2NUPNILEeO6tPwchmCD2JuvsXf8U/Ia5xBlaZ4j6udyOFbDF
 RXKCQuzaDW6i7n+eaBzvJoAPKHrHWEuHSY9dwt
X-Received: by 2002:adf:f247:0:b0:33e:c3dd:3fc5 with SMTP id
 b7-20020adff247000000b0033ec3dd3fc5mr6749438wrp.42.1711460430652; 
 Tue, 26 Mar 2024 06:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5Z0TWihqlQsjKToAKPi7u/YUyF0V4G4uV9X6cLYYr9d0KldAmFZOrU0VUNULbb4LjtEUKpQ==
X-Received: by 2002:adf:f247:0:b0:33e:c3dd:3fc5 with SMTP id
 b7-20020adff247000000b0033ec3dd3fc5mr6749404wrp.42.1711460430330; 
 Tue, 26 Mar 2024 06:40:30 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 a13-20020a056000050d00b0033e239040d8sm12211009wrf.84.2024.03.26.06.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:40:29 -0700 (PDT)
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
Subject: [PATCH for-9.1 v2 10/11] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Date: Tue, 26 Mar 2024 14:39:35 +0100
Message-ID: <20240326133936.125332-11-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

`memory-backend-memfd` is available only on Linux while the new
`memory-backend-shm` can be used on any POSIX-compliant operating
system. Let's use it so we can run the test in multiple environments.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 117b9acd10..e945f6abf2 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -906,7 +906,7 @@ static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
                            vhost_user_blk_bin);
 
     g_string_append_printf(cmd_line,
-            " -object memory-backend-memfd,id=mem,size=256M,share=on "
+            " -object memory-backend-shm,id=mem,size=256M,share=on "
             " -M memory-backend=mem -m 256M ");
 
     for (i = 0; i < vus_instances; i++) {
-- 
2.44.0


