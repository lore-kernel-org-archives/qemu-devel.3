Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40373C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU7m-0004g4-Sf; Thu, 31 Jul 2025 10:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTFh-0007oz-Cp
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTFb-0008FM-4s
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2fOYR/9n6os2GWcaytNtOuo9VDsGK864lc8x/7qXR8=;
 b=ZYV/Xwt/3S3nMQj30tWQhL+bTaPnfwY0DBL4lsF6zEhiMt1laBRd4kcZIBuBV3KWc9aJch
 Wdu/on5AgChDib8T2c91xcf1oFXGHbJXzapNvPJvJevLuNHQ/xBu8WLUs964lfAkJ0NUIH
 mBaExlTs8C0G+bS53VvjpaLSe+xuwQ0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-jAvTTJC5PrWbPVmYQss_Dg-1; Thu, 31 Jul 2025 09:23:13 -0400
X-MC-Unique: jAvTTJC5PrWbPVmYQss_Dg-1
X-Mimecast-MFC-AGG-ID: jAvTTJC5PrWbPVmYQss_Dg_1753968192
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31ea14cc097so431665a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968192; x=1754572992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2fOYR/9n6os2GWcaytNtOuo9VDsGK864lc8x/7qXR8=;
 b=A/jse/QQWvONGxeTQXHzuqbslAx72y67rtMgRZ4cIitOEk7ltMwegrPc19T0uVBEBx
 JUj3STemh3zHiosOiTnUqFWddPkBOohvMe0ovHnTVspyuDQGriVT6bq37aYky7HPI+2V
 8z9niw0KE3valPaOsR0nFF0GBWG7fdvGlhRi1/N0HMAjowHPLOqXk82GjMNJ9afa6foJ
 1Dusm8lymRrnwco3Dwe/wQph4PExWta3gnG2B2mEx9GbAHma518vSOagAmqiqmRTMSL1
 ldYpn2rzteS8oss3aRCHEZVB7Nkw2JiPRhX6s3RtXMT8uYp20evtm3BUcbSap8owTjCS
 VSow==
X-Gm-Message-State: AOJu0Yzhz2ggpDkoHD9OVz75moUV02KompClZ0BwC9Adw/P64AfWweaD
 fWU2kCyVhtr91I3zpf4WQ9JCE5bfd6xcFPRpRhhIwnRkVlq5kIAKRIh13LUa8XSMsa925RzHMaX
 fhR3H70i/0ejEKYQcGNOOPucSWLqdimlmSZAB1qeq+Wv26WU3SFOm+Uo9o1mbyMsniaXmTfcQR0
 CBLEHzcfk7w9BAPP9REIqhs1OBn57TlkNlkimCsmHvmw==
X-Gm-Gg: ASbGncv4ALIyePGoh+bpDGKVbdPGeORjFsVTBeGvmYKGj2wiZzN+Kn6XyVYp15eHRYv
 67Nmu+o5ATmgWP2Cz/c+a5YsJ6YQ11K45SpSCUee4Ob+fofyfjbrTn4yOOM9quOqMe+9I9c80e5
 FYvphxBN3v3kcQFLtYCrROivB3xHsb3MErogwlhFYur1uP40AO4d8FL/KM4MIaXfZ1WIg1EsuZB
 X5BKRXgO4j+U9LG2TSjPB4o7vjNoUrJp5IVWfy3cz5F9DXp5dnm/aby6Gtq3P5iIIy2CdqQqyYv
 EosFq2krreQHSpo0V5Kt4UAKAa+6L6WtGxRyxyK+2UAZXoju/9za
X-Received: by 2002:a17:90b:3ecb:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-31f5dd6b545mr9561677a91.7.1753968191391; 
 Thu, 31 Jul 2025 06:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoCxJT+fLdKKitWpQBr6k882ihhZnhoKB1eGxHAhO6F70iD6P6Anz89O8triJ8PqRaFfbOqQ==
X-Received: by 2002:a17:90b:3ecb:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-31f5dd6b545mr9561593a91.7.1753968190622; 
 Thu, 31 Jul 2025 06:23:10 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:23:10 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:48 +0530
Subject: [PATCH v8 08/27] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-8-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=armenon@redhat.com;
 h=from:subject:message-id; bh=gZeeufuGJO+jx1CzE6vGy8W4/PdHRl15dQahu1SenoQ=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37tOlx7xvzefuusG31KZv5deC32cDV4bNrN1WVjRj7
 RKxlsVdHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACYiMJuRYXdOXOX7tVN2TpYQ
 X5yqVidxvXvZtn8MCecmWMs9dwjlus7w3525VaSqqEAsOyk1m6k+oeFpw7RJia9ezShYedBcokS
 cGQA=
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use warn_report() instead of error_report(); it ensures that
a resume command received while the migration is not
in postcopy recover state is not fatal. It only informs that
the command received is unusual, and therefore we should not set
errp with the error string.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 39d6fd5b832971f23afc08100a20bcac045f3904..dfdb39952b0de12f7a4d6a0850c052a50e719925 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2334,12 +2334,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
     }
 }
 
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: illegal resume received", __func__);
+        warn_report("%s: illegal resume received", __func__);
         /* Don't fail the load, only for this. */
-        return 0;
+        return;
     }
 
     /*
@@ -2391,8 +2391,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         /* Kick the fast ram load thread too */
         qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
     }
-
-    return 0;
 }
 
 /**
@@ -2627,7 +2625,8 @@ static int loadvm_process_command(QEMUFile *f)
         return loadvm_postcopy_ram_handle_discard(mis, len);
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len);

-- 
2.50.0


