Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D42FC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU24-0006pt-97; Thu, 31 Jul 2025 10:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTG4-0000eB-1m
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTFv-0008IY-Q7
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y35vdzplFkFTtVXfpintBM0kj+D4txIp+GxRyRVgZoQ=;
 b=Qys2d9XpZh4nsq0/GhAkNcft8T6HjWYTTWRiHc/gC0z+h4aTqYIqNJs55slj3AlzMgzOnT
 CGAP90tXgwMkn+VGdcQUodTGtVUDYPmpTp4OkUjOaOPViu9PFsoGRDuJbGjBWfSA6tifYl
 S+MyHSr2uwy2bPRYIAL0/BkHzpQauoI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-nJU-rLEsMdKl-AHdmS1pnw-1; Thu, 31 Jul 2025 09:23:32 -0400
X-MC-Unique: nJU-rLEsMdKl-AHdmS1pnw-1
X-Mimecast-MFC-AGG-ID: nJU-rLEsMdKl-AHdmS1pnw_1753968211
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31f5f70a07bso1712233a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968211; x=1754573011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y35vdzplFkFTtVXfpintBM0kj+D4txIp+GxRyRVgZoQ=;
 b=Ns1E0yKrE4b3HiFTLaEgGMjVv1SCwu90dP4nN/G66NJwKgCQy5V+kOkyc2r/Q/HdO+
 bfzrRNJwd+ZLZUFdyqQBMwqhvgOSFoISAER9Az+Ulzx/+TmtZVDGtshuWK1bGzrjtEru
 Vp52A9Ada5VU8yu772RyyS8y6y3a31RX9H6Y08tkKKNwfX2T0LUvZn8ln7sBvYTZUEBp
 JpuoQmP9t6M6vJd/fJdauK5Z/5a4ncLMku0qLZ9S689GDuBwzF3QmO27HICAde8YqBjc
 AJzXhxEaAXFPqJ0X9yow8/Sq+YsEMr5U9VMi/H8p5gjP5SFweKu+yL2U8couQkSqHFUA
 beXQ==
X-Gm-Message-State: AOJu0YzcSCwy/27mL53CKA5mUgnR2HqphPKZUH0PsVr7q6QmBAGV0Qqd
 +8MiONwRSdshb6DMBvijwTmDZ9rUw7RigK+niaOPJueKgW8a5sOT4yV6vBVTUZzL5/OyrkRFsaA
 eFfC0UqXHIDKAkGOB2prXd5jkmyhgbK0a5LEfCZSnCvBnQuSa2jT7h57osPwHJl8gPURLw6aX5l
 QN42h/OKV+LlEN9Kvi1u530dho4e2RzUxgvBtKbo5oPw==
X-Gm-Gg: ASbGncukHhVgbh7f2dIjtyD1fu4LiHdW8Do1KLydsdPw7oh2QPsLsOvGxqj04PYN/tT
 SOJG8xWoaDHIHJZvaOMYQvB4sDXpQm2kTb7o+TAC+nWbuhxt627MuU9gGtGW5Sub8bQ0acZRSNr
 VnAGYmDENNwqG0lb7W6dCUMyCunjO8ikD9YrI+OvNr+i1gv1zDBNZMlN63RRX+QjaWX03taNn3M
 kb/sK0JDuSBpmYd4BLreyQvpxp+y/BIC3O9IYxIwNDXvJoFRlNSZU3OMfqvlIvDwOe9kCAwhawi
 TC+rCV7GiMOIwIv8jH81TKmXuFdUhx1nUkxdkok1UW3U0U534+dS
X-Received: by 2002:a17:90b:2fd0:b0:31e:e0b7:88ee with SMTP id
 98e67ed59e1d1-31f5de96370mr11907404a91.16.1753968210904; 
 Thu, 31 Jul 2025 06:23:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaF0MudpTvnj2d4LKFabmqreIYUx1JMPEme56jWjnHk7zvE7qmHLrVRS5Cb+PHiSK65SwPtw==
X-Received: by 2002:a17:90b:2fd0:b0:31e:e0b7:88ee with SMTP id
 98e67ed59e1d1-31f5de96370mr11907332a91.16.1753968210466; 
 Thu, 31 Jul 2025 06:23:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:23:29 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:50 +0530
Subject: [PATCH v8 10/27] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-10-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=armenon@redhat.com;
 h=from:subject:message-id; bh=4PohIq4+ZnPybABXSTBOombbTYHtEautdteGAWLIKLY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37tP2DbX/JCctOeUxY+eS/wkemsVc3HyZaY4c4R0tN
 /QUW3U7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATGTXdYZ/WlvdCj/rnPE5snuD
 +XxDdZumunkN5yYVvv3yVWg/w8spKQz/A6TvuRXHx90RvJRiM5V3TqZOidQlh8duC3g6jYJOnXn
 HBwA=
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
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 280ee92133975913f1d374231b431235a7301b7d..f0dac8b13c12a1785c0a293b8382641e82ce89d1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2403,7 +2403,7 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2413,7 +2413,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2424,8 +2424,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
                           length);
     if (ret != length) {
         object_unref(OBJECT(bioc));
-        error_report("CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
-                     ret, length);
+        error_setg(errp, "CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
+                   ret, length);
         return (ret < 0) ? ret : -EAGAIN;
     }
     bioc->usage += length;
@@ -2455,6 +2455,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2610,11 +2613,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.50.0


