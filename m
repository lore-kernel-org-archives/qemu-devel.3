Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2170CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTw-0002vl-CM; Wed, 22 Oct 2025 15:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTr-0002uI-KM
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTp-0001ad-CR
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCz1Mt3gTG/0s7R16hMFmFgj60vzRZb4DcUvnfXRMOU=;
 b=GzlOipz/eigCBGAr6MHPij+B6Mt2IdEP0wQQsHU0jxxm1PTXhZW8YN8uERnnZWIKJ+Jysy
 VpTvcyINxRqa3PLC5obNW7miJH4mmNQIx0FJRwZLXaXBiTo1covD1xwhyc2nkRzd0t2fPE
 95c7r4GbHBv3Jpiw7IEI/+sretSbWbw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ty4JxtnaPZyFCEu1Q7JMHQ-1; Wed, 22 Oct 2025 15:26:38 -0400
X-MC-Unique: ty4JxtnaPZyFCEu1Q7JMHQ-1
X-Mimecast-MFC-AGG-ID: ty4JxtnaPZyFCEu1Q7JMHQ_1761161198
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e8b33c1d8eso44217061cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161197; x=1761765997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCz1Mt3gTG/0s7R16hMFmFgj60vzRZb4DcUvnfXRMOU=;
 b=DVi+NE918Ik5q5q0VPxzPMi383Md5S/S1FcWeXcmDgEovO1yJDTT10N/blr0G5kcWR
 YE9cl7V1nUnouSYjbV1PJqy3vsiqpRAkfAvJpz/qDqgETih8I1RnUj42YIZ2KRCwQ4Ym
 E5It2zaQdkeh9DY+Uic68Av5+i7a9GcoE6eJBrbXi0aHnDf+b2qLP6FNuH+7HWV+PM4i
 S1cSqmDZcJ/GK2EBFn0KOlDQoNX6VtgvFWJ2v7layDnRPXWyN8l85FUyLplv7Av8KiRn
 CZkNCIvoBRXErar7kfzTPxRiyGW9OSC+xeXk9ubKfoMe8kEPujRGM3GvZ7zAt6j/urQP
 oImw==
X-Gm-Message-State: AOJu0Ywx85HRGxu754BX7+9vK1qBml7iZ3BEaVQggYyGsDHeECEt4rfx
 tr4XgUU8LpvbT9nsBEzzDLNT8yFmPpWYY6xS2MQgTlxy+kVsokyOEuiNG5Anxs3/Jc3Rg2IVmE3
 2QUIrGZ/EO6mk6lW1hCNbfYL24RWarF9vgiSQdkr1erDiWKMLnm9KvGUyAA8jzJKau1WNEmsH5l
 JxYkRM8sfng42Mh8wjaBbUJD+WzjX9hEprOr8eqw==
X-Gm-Gg: ASbGncujy4dqRtg/D6I5bmq5pA0UFyEnK+k0gciMO24ZMvSRiGhGH4jcZZVYip+C0jg
 Pr3fYuewis8ivvjKbetacMpkcN/RCKR5Wz2/Y7gUbMJ89X+iQvgJD3tq7t9uv7b9J/6KmX2U9E6
 PZWdPFmJt9+vLowBJYkSI0eQU4c3G6LcN8cUnr2J8pBxi3Ofl/F/t3rjTrDECD86o/Sx5xV02M3
 QylIXmROKuo+F1KYCxny8bRqU/9IcAz1uCds4vDzBEUAhoI6zmM79Q01bqduAJy0MODMtEtpvTY
 zG2O/710deYFO4tdAiO53E7Ns+2W3e+H2XOeU9riAcLUDeeGF/4DZfHBtGcfHHiq
X-Received: by 2002:ac8:7f50:0:b0:4e8:999b:70a9 with SMTP id
 d75a77b69052e-4e89d4123dfmr243437021cf.72.1761161197226; 
 Wed, 22 Oct 2025 12:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+7+PkJ8yuFjcIgOIzPsP1vhB0nMTTXKNBqSVlLqqnJXccpPbF8tX8sCpxXNiqLG9IqdlLEA==
X-Received: by 2002:ac8:7f50:0:b0:4e8:999b:70a9 with SMTP id
 d75a77b69052e-4e89d4123dfmr243436591cf.72.1761161196686; 
 Wed, 22 Oct 2025 12:26:36 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 13/13] migration/vfio: Drop BQL dependency for loadvm
 SWITCHOVER_START
Date: Wed, 22 Oct 2025 15:26:12 -0400
Message-ID: <20251022192612.2737648-14-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

That was there only because we used to do loadvm in a coroutine on the main
thread with BQL held, while there was a locking order issue.

Now make the API to not depend on BQL anymore.  Instead making sure we
don't take BQL invoking switchover_start() hooks.

Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration-multifd.c | 3 ---
 migration/savevm.c          | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index e4785031a7..c824f30fb0 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -766,13 +766,10 @@ int vfio_multifd_switchover_start(VFIODevice *vbasedev)
 
     assert(multifd);
 
-    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
-    bql_unlock();
     WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
         assert(!multifd->load_bufs_thread_running);
         multifd->load_bufs_thread_running = true;
     }
-    bql_lock();
 
     qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 16fae635c0..f67b97c9ab 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2648,8 +2648,7 @@ static int loadvm_process_command(QEMUFile *f, bool bql_held, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        WITH_BQL_HELD(bql_held) {
-            /* TODO: drop the BQL dependency */
+        WITH_BQL_RELEASED(bql_held) {
             ret = loadvm_postcopy_handle_switchover_start(errp);
         }
         return ret;
-- 
2.50.1


