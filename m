Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7059EC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCje-0002kW-6I; Wed, 16 Jul 2025 20:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgq-00057X-VH
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgn-0005EI-LC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZtmhFWXk5EBlCK/Tfl2DDsfMrvf6BAx9oYobKQ3Me4=;
 b=YTTqSLTsywnFO+3w09g19q+Mgh3lcjXvPHxztF6iHi24pURmnyZnysCuUhHWW55vqMJL6e
 ljB0850A5bT2o7+u4h9H7D/gZxyu+AfofhCvYCUrYpWhh1pbXqE00nHDDKCNe0UnACaDid
 BlFqLLB+d+hSilniedlkkChyWkFZR70=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-cSocseykM7eR3z3ihggDlA-1; Wed, 16 Jul 2025 20:41:30 -0400
X-MC-Unique: cSocseykM7eR3z3ihggDlA-1
X-Mimecast-MFC-AGG-ID: cSocseykM7eR3z3ihggDlA_1752712889
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3121cffd7e8so287969a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712889; x=1753317689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZtmhFWXk5EBlCK/Tfl2DDsfMrvf6BAx9oYobKQ3Me4=;
 b=DK1BIkJBa33pkzE/bFKk4D7y2WZVdgdmGbI2dL3x5ygZl5CRpFXx3jKRZzIGEULfNp
 YbF/rsO9ts2CmjZT4wHLdNLALpVEFPWsDcUdTlLQTX1m/MKQH9utyGjOmdXNlz8kRC0q
 CPMJWT8EwfPbMmvkduMUOOaECoW9e8lut98L42Ay/9rZE9dQ2NwGsHEMHkfABNLNXgMs
 9YvKAzjIC5t/zMRtM0EwrrbSkToJWoQlUqsHK7wRDHNft/uwxtQxfyh0px70gfYX0KHm
 jU688T/nE6Pjni6r7CjMdbL3vBtcZ8v5ABUPSTwfQKWT/rGdmVhDbrZJGlr5Xz0I6FHi
 Ywxg==
X-Gm-Message-State: AOJu0Yx4Ap0yEKbg2DcUq4hAirlRIEqUzkjirrV9oOoaJhdtu+6V/gCU
 X+yZ7HUBnmL2s4Oy5YEq+hTU0NDvYICRlZWMhJpB2HahfMHugqY/gvu/xpKaMpo1x0CDgeb3fz2
 +spQgy3LxIv7WSldPDj17OJ1fbydTEuE7lPuEelRUwGGw3EXBn8pdqprH
X-Gm-Gg: ASbGncu6HjVJYGgwNn1jgZ4JgVvGs3AWkpb+AJCQkoDpBn99dga3sm1cckP4Cv0ReBU
 ZY9gqITldzX5rLQ9Nc1mh33VcyFDd+F5sx/QzNA4ftJY7O0m83tC5u80/ohOSMwGb8ZOyF7R10p
 Op/OqP0y2kVwqhzktxc2Z8CV7FDYsn3EGR7xpNs0PLgIgY9MAANl8ioqupW62Hgb+/ilHRsaa3N
 lSf7VdV6375Okev9emY5kpUTYbobOW+mhqrZK/jsboC9HY1LYBSajw2AA9QNDYVwgiflv3bd+rJ
 M7/zsh452zvgaHL5LI2/HCYoIjm1fzOgC+K+7UyKvlL5ub2wjE3p
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr7176847a91.10.1752712889026; 
 Wed, 16 Jul 2025 17:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmebMCBMk6ihA+cLhuqZsidElzjATgVn9P5fJDdzUAkU21TMkIcG4NUghddoJtkoBc2/Y81A==
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr7176803a91.10.1752712888566; 
 Wed, 16 Jul 2025 17:41:28 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:41:28 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:40 +0530
Subject: [PATCH v5 17/23] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-17-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=armenon@redhat.com;
 h=from:subject:message-id; bh=WY426VfUBXwCjZ7dTs7nSVvKszQSlYt+qnrtxNljt5o=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm9IPXnt3W5fNrhuuMVjw2810r/Cd7Gp2W22Tuk1w7
 RemkrMdpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJrI6iJFhvrJWt7jNdIMTD5yy
 CjdfVXwqftVqJc96VidG5/8mGhVTGP4ZuSdfEK++uOD6lirFf8e0glQmu9i7JVieemj894LlRhE
 2AA==
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 755ba7e4504d377a4649da191ad9875d9fd66f69..a23c242a5f05f85a8544924c464480810995815e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2527,7 +2527,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2540,6 +2540,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2648,12 +2649,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;

-- 
2.50.0


