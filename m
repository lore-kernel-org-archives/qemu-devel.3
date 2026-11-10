Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88921606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=dhi2mo84
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqec-0005Mh-DQ; Tue, 10 Nov 2026 13:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqea-0005L7-EG
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:09 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqeX-0003Mk-4Y
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1562818f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794335584; x=1794940384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=isfZxjU3qOEiLMN4EsyJzrszmQX9hADapqRpoX6Eh3M=;
 b=dhi2mo84NeuuUIZMGXWlWUWA72ksEjw3f/fxW+H682TBzj2zYSAxRmUcMZTyFp9B1V
 T9QZrDIGqB1UJRufa5BQxj6h7DigAhnBayTTjLeh/VW63R1/92loyuC2yZJ9XxtTuw/h
 TSdLbUTIjZriscNJuA3XdfdsCcsL3+VQBKHX3Ojmj5XWRxzQGSrBZZwMlmdLX0QpAf94
 6oMmeE/8S97pvqrWcU16HQ8O//l4mO+/+za5751OQvnoFoN2j26r1Po32uS3zhft1qFy
 jrX7H5Bu+i/x4V44iilBjMrrovMDWjevxqQnITFhnkgkVQgGgG+HQstaCqtIJMNGgt11
 kTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335584; x=1794940384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=isfZxjU3qOEiLMN4EsyJzrszmQX9hADapqRpoX6Eh3M=;
 b=OD21Mi5UG7fIZ8sLp+mtdvp7q8C3Zx2WMN5XzE59V9nsDrQ+Yhn575AjGlPtUf8KC/
 9+Wb9gw/EJd7HfzONaCIWZwDdxWitjRHRXlakuiGn6iKNU2Y5gGndhiXJluoZgLi8OJI
 DE50c37c6qR+mzlYy2+JYT5c88XM1InKd7xoUYZvgdK+6t29Grqcm9EAwZMHFhN7RtNC
 q0/SCDcOq0wICe6HjrwjBAvaPP4QF2Cf3WLOpSsMWlbZUuHTCdVQJLkBlxkPPvv3VJrZ
 UGfAsiZ0Njv39W45Bz+WrucMtYyOUqU66h/ZqU0vNcOBsXrURJPxXEyC9U5f6Jns10d2
 gNFA==
X-Gm-Message-State: APuU4Z85RIoB5uc5i73pG3ZHGlGgAnLW7lPXpDB5HGs4a+FNmRIjOfkD
 sU+gKYJffZTVaz8vj+EfwFDup95+stmra+hJD0TzSLUtCwizl/lCN0NOtr3EODTt5hEJlYnBJKT
 C18zt
X-Gm-Gg: AYBFou0rf64vlld7t9xd9lx6TCo/LzHLZB4sVEGpMrb/A3Gp7Vx0CVdZOxFqeb3y+Kb
 yx9pzv0SGeOnqVtB3t13+075m5oAXzIm0ZCS9P4FMnSafLG/WMYapcEdeKjlluKA2lzcj8HKPgX
 ZJ1ZrEx9f+LveW93JPlzdsiyCGH1x577jnLOgmRamofFi+QN1EfM4c3CGeaJoqxwgEaerA6zdfI
 B2nNsqgK5k0fkDet4ucEtCupZxhsFlt720xjMJRvim5cKnEVdFv2xOyWMLuc9+N29gCIDd7je56
 mhI4hcZ+xfR4qVF1syctOwrt7XTkGHm0wvTtSGi342K8A36BiORaX5SOMtAEQCi52ujOuawopRX
 CooM/Xocn6lF2Nfkow2DVE08U07GnDrru4EF4rB+dC5KUE5ZbRFafItE3hO6dqcmf9f7hviABty
 DGroI5NNtv8eF6cgCQUHJVNhPpE0ozzJwd/w2EUoMlOtvBLTHddPXkCNSVAS0/boVzegCFKQ5vF
 zhbOMkfLvChILP8Yb5xVzjA6GeI4bUuCELGiJVDJAUHc7ns5X4KLoHZcDm8WA9mNglc+5hwTPjj
 846vBi/wasBL7enxVeaENYmo9RjHWpsjqU49Xd1KvbAIZc4=
X-Received: by 2002:a05:6000:1a8c:b0:493:5d67:499 with SMTP id
 ffacd0b85a97d-4982e737b02mr6697722f8f.14.1794335583577; 
 Tue, 10 Nov 2026 10:33:03 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f78:6441:d0f1:22af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm6384827f8f.37.2026.11.10.10.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:33:02 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 2/5] migration/postcopy: set destination postcopy-active in
 the run BH
Date: Tue, 10 Nov 2026 19:32:54 +0100
Message-ID: <20261110183257.2930908-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110183257.2930908-1-den@openvz.org>
References: <20261110183257.2930908-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=den@openvz.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") made
the destination enter POSTCOPY_ACTIVE in loadvm_postcopy_handle_run(),
before it schedules loadvm_postcopy_handle_run_bh(), and only the BH
starts the VM or moves it to RUN_STATE_PAUSED. Management reacting to
the destination's postcopy-active event can therefore still find the
VM in RUN_STATE_INMIGRATE, where blockdev-add creates inactive nodes
and attaching a device to them fails with "Block node is read-only".

Move the transition to the end of the run BH, after vm_start() or
runstate_set(), as process_incoming_migration_bh() does for precopy
COMPLETED. Without a return path the listen thread enters
POSTCOPY_ACTIVE directly, and the fast snapshot load path switches
right after scheduling the BH; in both cases the state is no longer
POSTCOPY_DEVICE when the BH runs and the transition is a no-op.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
---
 migration/savevm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7d0276c1d7..600db7a1ab 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2263,6 +2263,12 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     }
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
+
+    /* Already POSTCOPY_ACTIVE without a return path or in fast snapshot load */
+    if (mis->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    }
     qemu_event_set(&mis->main_thread_load_event);
 }
 
@@ -2277,11 +2283,6 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
         return -1;
     }
 
-    /* We might be already in POSTCOPY_ACTIVE if there is no return path */
-    if (mis->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
-        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
-                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    }
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
 
-- 
2.53.0


