Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8585C54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribe8-0003LN-Fm; Fri, 08 Mar 2024 09:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribe0-0003EB-0w
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdt-0005SC-Rt
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0rmMaJt4MALPwGW3i+DaPD4OmnBD3wO03Edu/ZWJ8Q=;
 b=BZ06rnE/uOeB8Fg7LyrTxK0CYyYuuR822o8OArN8m+FZPDwFy85qH+vWfeOy4ibl+N4HUl
 FyKEtnuyVF2EqOggfyr3bL6HAxuaDvrAZCnsgpKfO4woUohqudbFEK7mAQGj1DQeDUesvO
 eJzroCoI84XBlI/iNZLPefYP65YkmNA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-DQR_uqMJOu64pZSwSnAPcw-1; Fri, 08 Mar 2024 09:56:11 -0500
X-MC-Unique: DQR_uqMJOu64pZSwSnAPcw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-567002485e2so557692a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909769; x=1710514569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0rmMaJt4MALPwGW3i+DaPD4OmnBD3wO03Edu/ZWJ8Q=;
 b=XEtsqO/UNhxtfrdfsni5nEsoEYiiQrJmsXtukPnObCk+/c57HKiFIMVDpiBez4eNim
 xGujjkGuv4uJiz925VRAO6jsFAJvC1yrd3Lt1RcGbmPMOvmDwH9s7eA7GLghOx715BK8
 u7rNNas/deeH8x5CDcm0M1xnV8cCy+SO9td3g0KW83wc/UfvyqAuuEwIWCp76jwZcTQi
 KuWX/5qvonGYRK2soj6O9VVjc+huEGFkIHGD23pOCV9uvbcm1YG+JW9dVKve4Xr6fHib
 s5pZaQQk0/yjdQu/yCBo00YEKB0ZcuB7o0LafrcM/uIMru0u8aaceklN9/au2h+83x3J
 Wxig==
X-Gm-Message-State: AOJu0YxtNn3VCHFclGxRA5WLAjcY44ige2osNiK2dtk+CorAEbSI8O/4
 IqHRwgXAY7hT/NFqP4+W5vPwVtBZiicjpQizzcTuxFEK017sE9lcGOVWsxXMTJ839d5fpDC+pMh
 UVowSSYQmqfbQyWMO7OM+VBY0xjQb9vJXQM6MMAd1F3HwZokJK34dlQSz/ey5+sZGIxuAU1MhAS
 KomJltQowtrI2aAxTUsn95wHOhgpm5Z6Au0YSU
X-Received: by 2002:a50:d59c:0:b0:566:ab2b:e1ce with SMTP id
 v28-20020a50d59c000000b00566ab2be1cemr1959333edi.18.1709909769238; 
 Fri, 08 Mar 2024 06:56:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTgGcgP6HPVo29O9+nxTo/S8qrtvTM3+cJFwXCiesecuXHUDL//oOpM62GsV/YvhKwgtKa4g==
X-Received: by 2002:a50:d59c:0:b0:566:ab2b:e1ce with SMTP id
 v28-20020a50d59c000000b00566ab2be1cemr1959319edi.18.1709909768977; 
 Fri, 08 Mar 2024 06:56:08 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 ig10-20020a056402458a00b005657eefa8e9sm9256453edb.4.2024.03.08.06.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Kanda <mark.kanda@oracle.com>
Subject: [PULL 06/12] oslib-posix: fix memory leak in touch_all_pages
Date: Fri,  8 Mar 2024 15:55:48 +0100
Message-ID: <20240308145554.599614-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

touch_all_pages() can return early, before creating threads.  In this case,
however, it leaks the MemsetContext that it has allocated at the
beginning of the function.

Reported by Coverity as CID 1534922.

Fixes: 04accf43df8 ("oslib-posix: initialize backend memory objects in parallel", 2024-02-06)
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3c379f96c26..e76441695bd 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -467,11 +467,13 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
          * preallocating synchronously.
          */
         if (context->num_threads == 1 && !async) {
+            ret = 0;
             if (qemu_madvise(area, hpagesize * numpages,
                              QEMU_MADV_POPULATE_WRITE)) {
-                return -errno;
+                ret = -errno;
             }
-            return 0;
+            g_free(context);
+            return ret;
         }
         touch_fn = do_madv_populate_write_pages;
     } else {
-- 
2.43.2


