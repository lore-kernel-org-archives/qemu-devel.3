Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C09C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 17:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2wTg-0002A6-9z; Fri, 03 May 2024 13:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2wTf-00029g-1v
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2wTd-0004nC-4M
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714756419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N28cbHomwUkcv440YAC+5DY2urfg9/G5rX696DgsQAw=;
 b=MyBFSfvv8TFLFIaesFx7+e5z/5gcJsDeDxtDg/EOZ/sdm19m3Pn2ysE5H3FeKhoj4mSzle
 evGweRdWokYrHQsM+vg14QxGWxfQ3FHQkjL8I7lUkoGfeo+4bWQiYKOJxWsPGTr3f3wNun
 rDc/b5cG8LhV0h6CjNVlOHOA8AGJtsA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-UkOlS1akN8-9-JtQmAYX8w-1; Fri, 03 May 2024 13:13:37 -0400
X-MC-Unique: UkOlS1akN8-9-JtQmAYX8w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572d0cb1ffbso656164a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 10:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714756416; x=1715361216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N28cbHomwUkcv440YAC+5DY2urfg9/G5rX696DgsQAw=;
 b=TdoqN9ONdd8d5Saf/XOz6I/aG76aa8vYvfB1hqPSF/cfb4fhOK25IwFuFN8TCe6Y0f
 Xvts/xShg19KPbNUkHSefLF5OEOq6Zi1Nkms1D1Y/3mrhD9v1eb2fsCaFgfb0VE6GJXl
 e1Uy9kDAqUYhmRcv/xcwWbVH+MWe1/c4GrUUWqk5m2SJy8QQoWLA+HcdiomeR5gxSzFn
 NcPzze7fVAFutik9wgPKApcKpnZenJG7MJQGqTdCw8jLoUe4DoZt3iCXi5DN47HvSUrw
 SCVWEZC5IV8c6aMpkYvoGwYxpdsDtstXGOVaAsf7Za3OzCGQAGGKaQv7onzfdW8H5lQr
 INXQ==
X-Gm-Message-State: AOJu0YyebtdjznaAubmo+BAumLWh0tiuVZjbLSYJTOnHA3Wg7bMeOftb
 3mZV9u6Uv7SJFbQH0T+1JjMCC/ZFMeYX4QkqkYJHKtTpWF65f5XpgC4qqFv10DRwg3zDUJcgNpq
 hgl2DcD/VnTktHASuYjoTrgBKQh9g3Cnu+Ie6gqAh+Wke+/Eg7nfw3uSe9/VtI8Di0R/tI1bm99
 RxHulTEVoh0eMXWn5VCop4wB6WXmK0xnnTjZBW
X-Received: by 2002:a50:d495:0:b0:56d:c928:ad76 with SMTP id
 s21-20020a50d495000000b0056dc928ad76mr1953974edi.26.1714756415813; 
 Fri, 03 May 2024 10:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa2w+Kf+jjuIPg3x4XQF90TD5/aM9r2PKvpeB8Murh4DiHcSevfl4PBMRAaARVbzRIJMHjnQ==
X-Received: by 2002:a50:d495:0:b0:56d:c928:ad76 with SMTP id
 s21-20020a50d495000000b0056dc928ad76mr1953961edi.26.1714756415382; 
 Fri, 03 May 2024 10:13:35 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05640226cf00b00572a0550acbsm1874561edd.55.2024.05.03.10.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 10:13:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	kkostiuk@redhat.com
Subject: [PATCH] qga/commands-posix: fix typo in qmp_guest_set_user_password
Date: Fri,  3 May 2024 19:13:33 +0200
Message-ID: <20240503171333.241463-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

qga/commands-posix.c does not compile on FreeBSD due to a confusion
between "chpasswdata" (wrong) and "chpasswddata" (used in the #else
branch).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/commands-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7a065c4085c..7f05996495a 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2173,7 +2173,7 @@ void qmp_guest_set_user_password(const char *username,
     }
 
 #ifdef __FreeBSD__
-    g_autofree char *chpasswdata = g_strdup(rawpasswddata);
+    g_autofree char *chpasswddata = g_strdup(rawpasswddata);
     const char *crypt_flag = crypted ? "-H" : "-h";
     const char *argv[] = {"pw", "usermod", "-n", username,
                           crypt_flag, "0", NULL};
-- 
2.44.0


