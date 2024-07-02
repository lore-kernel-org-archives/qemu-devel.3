Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00566C3814E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyB-00081l-IH; Tue, 02 Jul 2024 16:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjy4-0007D5-PF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjy1-0001Dy-Km
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3m1Xw9Ub15rW4o3esEC0MkiVgr91nuiCfcAKrltL4I=;
 b=hUZf59tA7XvPYo7ZsWC6R2bvtPfFfNLADjmV0NC93x7SlYGsCeILuiOFTO26Mfmu8OmcW2
 zq7oPMFdfUZv/qYQhvDB+rVvUSBKUnCIMesdPeIH+d1vpxWKDxeQ6JjDVHvsO3CpEOj9HX
 xTa1oeeNB7SQ0BB/iW3r9X+N8vokGQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132--eqf2gIpP0GGsigT-hNSnA-1; Tue, 02 Jul 2024 16:19:04 -0400
X-MC-Unique: -eqf2gIpP0GGsigT-hNSnA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4256849a9f4so31644215e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951543; x=1720556343;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3m1Xw9Ub15rW4o3esEC0MkiVgr91nuiCfcAKrltL4I=;
 b=I+kVwHYlbRPj+4Y9rt+ekZMBJGKPXvLit7b/35BjuGMcioqouaDwnMOQODTRVhgVzb
 J9TCY60Woy+HZ8XOqUcbnFYgEnYJTsylcos3SSlO4eP5Rt34YS7VL4NdfoMHWc8Jj/3J
 K7H4YXsWE5g928D7w5hX7mOWzpf9K5ivt6MJqvvaHQH186MbAA0tX3Bhv4njxhAafA+0
 Am2VoM6hrhqTBKZWrXDBnXbOBcAtXiuTzLPAavXSvmODZobPUYl9kkCOm7mxw01hN+Dk
 k7u5xrzyysbRkcAfewHt9Vs9kfZ53SC1UotWHL5a2bvpp5PudIjDCva+FUAox1nM44Kn
 iqVg==
X-Gm-Message-State: AOJu0YwRrCZ1K/pwJ7pbfsAgnzkwR4H5/ElhD0GZfJ3k11cT2jVkfV4K
 G0CgMkmeg31ni7NDpEl8A8GINohzEWXZlivO3Zy3BDnzYVwurYUOTHcek1IS3xMF/nNc27Hk+xF
 K7xHy3LUybNxG4kdcD1zhCMGRpRgsz0lH/9mEfitqCKyFZ8BnudJzPWIPWy1lUuAn0LWh1d6O+l
 NgHRgRv2UJLSPIHCBp12udGZ3akibsvQ==
X-Received: by 2002:a5d:47aa:0:b0:366:eb00:9dd6 with SMTP id
 ffacd0b85a97d-367756a3585mr9268055f8f.1.1719951542811; 
 Tue, 02 Jul 2024 13:19:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmc8wv35Albphvw15+7lvIySsgH4Qv5bMd1dsjSHlW3rCEC2eojB7WdUcyarwn9WLbvTewRQ==
X-Received: by 2002:a5d:47aa:0:b0:366:eb00:9dd6 with SMTP id
 ffacd0b85a97d-367756a3585mr9268018f8f.1.1719951542199; 
 Tue, 02 Jul 2024 13:19:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678e68a622sm1497656f8f.106.2024.07.02.13.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:01 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 57/88] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Message-ID: <f8ff4a66d6aca062e01a49095089a3679f421b50.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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

From: Stefano Garzarella <sgarzare@redhat.com>

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
Message-Id: <20240618100527.145883-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


