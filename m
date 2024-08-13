Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F17C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduyX-0006RY-Db; Tue, 13 Aug 2024 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyV-0006FA-8w
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyR-00038N-Ih
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83GI1fDfDMGezYy05oq4L94LxUNct25QLDIJmFGGzPE=;
 b=E0+/QDUPRXG7s1BRegkDiLooxO91XWq5iI4RMmd30Fj/EnxuPlGk00aq4hoEh+6bzJpv/e
 dNnvxllqY9/eAGa1q2t3cCqIKab+n2fqShvh1D5ow7dBDQDBDFxZwEyvESYlvLZLh/wBSo
 8NEHb7rGXVUTWjwf6udryJriRwPauS0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-YDsk1ZeDNxOZ1ays2ZKOEg-1; Tue, 13 Aug 2024 13:06:17 -0400
X-MC-Unique: YDsk1ZeDNxOZ1ays2ZKOEg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5bb8fc3df4aso4310808a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568776; x=1724173576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83GI1fDfDMGezYy05oq4L94LxUNct25QLDIJmFGGzPE=;
 b=qUXqImvyEnHCAgugzPX4I5NGvXbtypmnIcSymNkBbABtp5HhETDGUL1yyuMxbebVbn
 lsjuix2fX4TswoMNe68wCPTsGAICKY7cZ93N2NeFtSDHF1yjYNC/GlaMN7X7ed0Oygd3
 4JwG9B1xO4FXWyySL6OWFuj0GM9YZAL1nxzCwv43jCdigU0UmGQMOCauvxDD/Pvlqy/C
 37oBcmHUN+I5/dOrYcAQCB8SNoA0rQGIQRhUYdXqo9ktYHnd+NkY0ZFp2f/XQxWx3wKd
 tpw2UvY1Xtu+Y3IC3JvrnFtKGQ+KuqK0RcTsNTm/C+SSGCiLmZ62TUQAQa7e0HpgkLUq
 tUOQ==
X-Gm-Message-State: AOJu0YyuIwS62AfRvADe4YaPbzSGNVOOd88ko94Huygj5gFrFamT3drN
 GpheusZXEg8K6ntsYmc9UlLHSwKK7CMjch1Ja7QLDG+DlXMqe5qBLK7cJatqZjkztOpsDspHmMg
 5qDHtDM3Hj0jLkg2BlfufMLCekBBotkcjGSCbx3YTvYyqTMSZYBaxlfO6/xNfTq2W74qG7b0YxK
 F9jkIqL9HR+Vp/nlChyoat2hQJPU/tQJbH7O0E
X-Received: by 2002:a05:6402:2354:b0:5a2:a0d9:c1a2 with SMTP id
 4fb4d7f45d1cf-5bea1cad0damr102262a12.26.1723568776191; 
 Tue, 13 Aug 2024 10:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzsM50zCb89/RGNNWmZqNRMHD0zqp5+0Wk7Sa/qvkIIWqFubrprvfAZomrRgjuwBQlsXB67g==
X-Received: by 2002:a05:6402:2354:b0:5a2:a0d9:c1a2 with SMTP id
 4fb4d7f45d1cf-5bea1cad0damr102238a12.26.1723568775739; 
 Tue, 13 Aug 2024 10:06:15 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd190ad1bcsm3114523a12.30.2024.08.13.10.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:06:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Claudio Fontana <cfontana@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-stable@nongnu.org
Subject: [PULL 5/6] module: Prevent crash by resetting local_err in
 module_load_qom_all()
Date: Tue, 13 Aug 2024 19:05:54 +0200
Message-ID: <20240813170556.104193-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170556.104193-1-pbonzini@redhat.com>
References: <20240813170556.104193-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

Set local_err to NULL after it has been freed in error_report_err(). This
avoids triggering assert(*errp == NULL) failure in error_setv() when
local_err is reused in the loop.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Link: https://lore.kernel.org/r/20240809121340.992049-2-alexander.ivanov@virtuozzo.com
[Do the same by moving the declaration instead. - Paolo]
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 32e263163c7..3eb0f06df16 100644
--- a/util/module.c
+++ b/util/module.c
@@ -354,13 +354,13 @@ int module_load_qom(const char *type, Error **errp)
 void module_load_qom_all(void)
 {
     const QemuModinfo *modinfo;
-    Error *local_err = NULL;
 
     if (module_loaded_qom_all) {
         return;
     }
 
     for (modinfo = module_info; modinfo->name != NULL; modinfo++) {
+        Error *local_err = NULL;
         if (!modinfo->objs) {
             continue;
         }
-- 
2.46.0


