Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683C2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0zG-00021w-Q2; Thu, 21 Aug 2025 04:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0yb-0000e4-07
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0yV-0001iW-0L
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppHs8O7DX583USXq/jSZEYkkRAy011Ydfoexnnm+Yqk=;
 b=A70T/8FHmtJuJES2DlQKzGqmf1Czb1VazsioHsGC3nEDMNoy1WwHqh2wE2UEat8dZ5Alyr
 Djva+EtZOGYd2vHpf625SFsRoSfXejTqMp5Uf8B4duHBhHqW0cnRuydHUNrrUN4Hgydib1
 UFUdVTLUlxnsaOAlsql5ZkIm5ls+bZg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-TAkumatzPT-xH9ji4FUeLA-1; Thu, 21 Aug 2025 04:48:42 -0400
X-MC-Unique: TAkumatzPT-xH9ji4FUeLA-1
X-Mimecast-MFC-AGG-ID: TAkumatzPT-xH9ji4FUeLA_1755766121
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24457f440f0so9745765ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766121; x=1756370921;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppHs8O7DX583USXq/jSZEYkkRAy011Ydfoexnnm+Yqk=;
 b=ObCPNz/Mu3hSDyKZOBY56AAESk0wbUFrz7quEIvVg/+WKP6l4v9tEb7y3sd/vE8RSI
 tL/5f0/P2/hYvQSn3hV5r5e6ANyfrsfWsjb51kv0wFv0TrMxdbbIqs5REI58X1qRvgFA
 iR2UTjOo/QPAZDoLWqThwXU6Vgi/kD8qUaqq7sPIq4G/2d0G+iebiYbFCd2h0qo8O+ku
 co6cFYfiaVrUEEWiBU8nq4tEKJ/tJA68aqbeBp+9qc4ZObLkhIJQqu2LqR6Btx3PDqti
 f9nIcuKmd7h0BkE6Rb50lVlENlQyYPf2Cwzt1KaaKqDvxf+Os+1JQS0o4tRjnZ9nDQ9P
 euyw==
X-Gm-Message-State: AOJu0Yzi5AmldjQGc0i65mHyYHJXtwEUUeOybtvSafg7z3h96MChq62X
 /l0QxKrA6M5/YLkPp2CXbCAUdW4RwcBbuda/BnM+wHCjjw+RxD/m/C9gJ/Aj8G9/SPdxdkNv+yD
 Gslgy7ABJX371UhASf9nbkcxsoadLIcxZMPwpB+rXeMaFak3yI2lgS1iM
X-Gm-Gg: ASbGnctJr3K68D9+lbYPd8iJ5PoIyNKIOfHTIIeDiSJjBrgzdxnMfl3Hw69PuPbDP/E
 xP1dNzWoLHRohHoaisqDMrvgT5d+FFNrYqFUhbA5ARlSwtUbf8OSJ0tYjK8C/Rmxq2VEXwCjdi7
 FCHau5dsU3M5VQMt2qq1uoWWxrLufmyYF5zClusH9sRVLpWqmFR7KnDghLPQxYv+pnYUlfoTXpU
 ToNL5cgRPAWXa/Hcs0XhAqaEUvCdrKEeVMNZhorbHYc2rPH0TK+WBByAl9y9ue6XtOFBOVGOdov
 oLAyGd4f5Xn3vOlr4aGlYpb0W5TZ4p/8VkKowxeEHY43xZrBjSSz
X-Received: by 2002:a17:902:cf0d:b0:234:a734:4ab1 with SMTP id
 d9443c01a7336-245febee8demr22778845ad.3.1755766120799; 
 Thu, 21 Aug 2025 01:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0Q3dZkGLVnSn5ASpC2AqakL+X1hf6PAuwvnRVW+kyn5ArNb3ZXEduC3QD7fIYOsir92foMQ==
X-Received: by 2002:a17:902:cf0d:b0:234:a734:4ab1 with SMTP id
 d9443c01a7336-245febee8demr22778485ad.3.1755766120427; 
 Thu, 21 Aug 2025 01:48:40 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:48:40 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:17 +0530
Subject: [PATCH v12 23/27] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-23-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=armenon@redhat.com;
 h=from:subject:message-id; bh=odWNCL7J0yJYAtYKRmTdx7jNOjfCtXVndXLWr78gg10=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayOymlc212M856sEXAVELX48uLZMeNC558nXVq2ZP7a
 tPSxNMSO0pZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAExk43JGhnWmXa1iN1Q+z/l9
 7viH5uC/cot9n3y9qfxg08S7cluPZc9gZGjlYHiUriy8ylb8UdyKS12fhIve/7KIaJKauv5vWID
 oDj4A
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b53a9db8e21a68b9fe4991dceda89bbfff738caf..2e2b38def670d7d5cadbb9665d0b19b008a0a373 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            error_prepend(&local_err,
+                          "loadvm failed during postcopy: %d: ", load_res);
+            migrate_set_error(migr, local_err);
+            error_report_err(local_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.50.1


