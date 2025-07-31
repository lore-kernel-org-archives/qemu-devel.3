Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AA4C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUBt-0006au-9N; Thu, 31 Jul 2025 10:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTH9-0007BN-LK
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTH7-0008VE-Rm
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYXz+t7lY2pc+w468p7vksRNCF9gH6persDWdh07D1Q=;
 b=SBn3+ji3yhLLZohrL4Uv7Y6E0XhlJQyZ8X0Ldyg4kRQQeBXkbbAXHe0yKc48PmUNbyfRxV
 XBV6Iee89k8QXPvSfPc8EuTz7ct2AeUPAF4yeIJ4QntUhuBmKGLbYQnsMUueqV0UKNUR0x
 N+cAetpeAnHHR+sdzXyxPI8mBvVxKeM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-CrLaG81wNYCVoaDKew_mlA-1; Thu, 31 Jul 2025 09:24:47 -0400
X-MC-Unique: CrLaG81wNYCVoaDKew_mlA-1
X-Mimecast-MFC-AGG-ID: CrLaG81wNYCVoaDKew_mlA_1753968287
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31f2dd307d4so1110290a91.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968286; x=1754573086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYXz+t7lY2pc+w468p7vksRNCF9gH6persDWdh07D1Q=;
 b=ucXOs2ps7i6FkOzo9njebuzWk22lFikBHL5JZYa3iKD1XeJ4MJe1WS4gee7xXPMZb0
 j4ym8KqwRwB2DuBBweeb2J5IWBhL0a2rCpdg5sQ32oehwxyZ7cQZyPpSxBNlthl9VJwt
 GQ8WpVLOZ1FP7PZ7+YGDnAuEM+kkMPBqxlLXgLwRPnl1TQTISFkepFIsaCUfEJb+PCn2
 9SXTT2OV9YNJMy8GnHMXwsSaXJPuMfuM/blEuyqjlGRVoWSyGRq3Iib3ACgjswQcpS8a
 tUNccPE0Oe9cH/LpX2zdBjq4+NFGD0sY9xQliceuz5MD8Lchiq8qsVsIWAf8gA6baKAA
 OQCQ==
X-Gm-Message-State: AOJu0YyA9Voezu2oAX2t9NtH9PiDt+3kxpi2Qf4+/ERcnxn65q45epx9
 SvSZJK9laBfDYQaC+5srUdoYGGkTf2fdPD25kYyyYxbAsh7itMSDlsS/Ycwi1wyDl1EeMEQoYbw
 6nWKGRIRcdn8Rak87E4BGKSe8Esi6bqwqNcO8RsT6HkGMoWCWdwqtBOuKXLst/nGsdEgWgt5Y9S
 8EAP9T+ASfMaqBSdycg1n1IV94cUBMXomZOlzWs8S5YA==
X-Gm-Gg: ASbGncvE131VJ6rjie+l2e2GJ+Eh5kLa+idWGxjQuMwXAUujVjoIJTn3lndUX3eBHeQ
 HIsgG5+S+Vb63MGmwPb2y7DGBbRev1WaEDGn9LPOUbH/s8Ua6T7Ir3VM6a5yQ9+GD8+c1Wyzb3P
 llkEUOpSocN0/xcS7ytmmry2w8D0C7ooAX8h+18hhMTPRIFTpYiNirwfn6G6MymiwYx1sJDoO39
 GU5O6ZelhJzOnBnfz8925OXkBjlZNJfYi0ZMy2oZuEij0dmeEWRW8qfdihGD5UlePLbenHQYmNg
 VACICYhjLxb9hw2QoME5Pp2ozg3LpmefeVb7iB+1alK/tmw53xPi
X-Received: by 2002:a17:90b:1348:b0:31f:1757:f9f8 with SMTP id
 98e67ed59e1d1-31f5de54aa4mr8165238a91.22.1753968286509; 
 Thu, 31 Jul 2025 06:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRTdY7Lwpza3rTbYeBSesD15vxKgJmm7CdduM+OWnvie6RHfAAusQZttS32qdY3v2+6/sC5Q==
X-Received: by 2002:a17:90b:1348:b0:31f:1757:f9f8 with SMTP id
 98e67ed59e1d1-31f5de54aa4mr8165167a91.22.1753968285988; 
 Thu, 31 Jul 2025 06:24:45 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:24:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:58 +0530
Subject: [PATCH v8 18/27] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-18-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=armenon@redhat.com;
 h=from:subject:message-id; bh=cKQFSSzoOVChlG6ImaPlxCUTOALoFJJai4iGUly2L5Y=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37jMlP8a+j2lKJ43/7JhyLdgt0D/y//Zkz8wrat98N
 RcnqRV0lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BuMmrGf478/+Pb0mt0mpyNk/S
 nXBl9px3MvXe/tlH97jkTz1XsvMCw3+f2IhiAb5F+eXPw7X5uM52HleSVtu3pVxi4qrM3ngxf0Y A
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index eeae34454117fa785a7514ed70b11bb712e37d6b..e885f1724f223771d60081fea199320abc549d2f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2537,7 +2537,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2550,6 +2550,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2654,11 +2655,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;

-- 
2.50.0


